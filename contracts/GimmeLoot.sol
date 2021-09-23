/**
 *Submitted for verification at Etherscan.io on 2021-08-27
 */

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/interfaces/IERC165.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Context.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/interfaces/IERC721Receiver.sol";
import "@openzeppelin/contracts/interfaces/IERC721Metadata.sol";
import "@openzeppelin/contracts/utils/Address.sol";
import "@openzeppelin/contracts/utils/introspection/ERC165.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/interfaces/IERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

contract GimmeLoot is ERC721Enumerable, ReentrancyGuard, Ownable {
    uint256 public constant MAX_SUPPLY = 6666;
    uint256 private constant MAX_MINTS = 10;
    uint256 private constant MAX_PER_TX = 10;
    uint256 public reservedLoot = 100;
    uint256 public price = 10000000000000000; //0.01 ETH

    mapping(address => uint256) private addressToMintCount;

    uint8[] private rarities = [
        0,
        0,
        1,
        0,
        0,
        1,
        0,
        1,
        1,
        0,
        1,
        1,
        0,
        0,
        1,
        1,
        0,
        1,
        0,
        1,
        0,
        0,
        0,
        1,
        1,
        0,
        0,
        0,
        0,
        0,
        0,
        1,
        0,
        0,
        1,
        0,
        1,
        1,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        1,
        0,
        1,
        0,
        1,
        1,
        1,
        1,
        0,
        1,
        0,
        0,
        0,
        0,
        0,
        0,
        1,
        0,
        0,
        0,
        0,
        1,
        1,
        0,
        1,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        1,
        1,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        1,
        0,
        0,
        0,
        1,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        1,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        1,
        0,
        1,
        1,
        0,
        1,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        1
    ];

    string[] private attributes = [
        "ma",
        "gimme the loot",
        "soft-spoken niran",
        "trayvon martin",
        "lift every voice and sing",
        "to be young, gifted, and black",
        '"the ghetto"',
        "skittles and arizona iced tea",
        "the invisible man",
        "james baldwin",
        "shaun king's phenotype",
        "shaved ice obama",
        "the talented tenth",
        "the n word",
        "vibranium",
        "a$ap rocky's gender expression",
        '"catch a *what* by the toe?"',
        "jesse owen's fist",
        "carolyn parker",
        "marcus garvey's accounting practices",
        "bobby seale",
        "the well",
        "bigger thomas",
        "mid-air simone biles",
        "victorious serena",
        "hashbrowns on fleek",
        "zora neale huston",
        "grandpa",
        "frederick douglass",
        "lauren oya olamina",
        "patrisse cullors",
        "omar little's shotgun",
        "2008 innaguration",
        "national achivement scholarship",
        "wide-eyed viola davis",
        "snapback",
        '"how come he don\'t want me man"',
        "shaolin",
        '"pipeline problem"',
        "harlem",
        "0.197222222222222",
        "danny brown",
        "john h. johnson",
        "obama",
        "simon biles",
        "earth seed",
        "undervalued black pfps",
        "bessie smith",
        "cornpop",
        "40 acres and a juul",
        "cory booker's bumble profile",
        "the bible for children of color",
        "bill cosby apologia",
        "hot sauce watch",
        "anime",
        "chuck d's boom box",
        "rapdoge",
        "get out vibes",
        "lorraine motel",
        "ameena matthews",
        "crispus attucks",
        "jordan heels",
        "louis farrakhan's anti-semitism",
        "chimamanda ngozi adichie",
        "protect ya neck",
        "lubriderm",
        "harlem renaissance",
        "kanye's anxiety",
        "elijah mohammad's quran",
        "spelman",
        "howard arrogance",
        "lebron james",
        "issa rae",
        "robert f. smith",
        "everyone's protest novel",
        "OkayPlayer",
        "fruitvale station",
        "silk hair scarf",
        "soul train",
        "static shock",
        "proposition 16",
        '"terrorists don\'t take black hostages"',
        "the souls of black folk",
        '"your hair\'s uneven, you look dusty"',
        "huey &amp; riley",
        "yara shahidi",
        '"so articulate"',
        "BSA",
        "that go",
        "new day",
        "rock the boat",
        "the black grocery store",
        "bigger thomas",
        "parliament",
        "hyphy",
        "black girls code",
        "black twitter",
        '"you don\'t sound black"',
        "life of adidon",
        "beyhive",
        "backstage capital",
        "1.2% of 147 billion",
        "44260",
        "syd",
        "plessy v. ferguson",
        "white people are watching",
        "the autobiography of malcom x",
        "love &amp; basketball",
        "pulling the black card",
        "nigerian otc exchange",
        "theroot.com",
        "-102400",
        "amistad",
        "wakanda",
        "junglepussy",
        "no heart",
        "infared",
        "trap",
        "black faces white masks",
        "the buffalo soldiers",
        "high blood pressure",
        "stono rebellion",
        '"yo name is toby"',
        "church",
        "inglewood",
        "south miami",
        "leimert park",
        "bed stuy",
        "greenwood",
        "shaw howard",
        "west oakland",
        "two strand twists",
        "ashy knees",
        "double consciousness",
        "2009 beer summit",
        "baltimore",
        "philly",
        "detroit",
        "new orleans",
        "on god.",
        "collard greens",
        "february",
        "saving the democratic party",
        "the double v campaign",
        "cantu",
        "cocoa butter",
        "black is beautiful",
        '"i\'m from michigan"',
        "crabs in a bucket",
        "Life Africa",
        "stop killing us",
        "stop poisoning us",
        "see us",
        "reparations",
        "eyes on the prize",
        "henrietta lacks",
        '"where is JA?"',
        "hood rat stuff with my friends"
    ];

    function random(string memory input) internal pure returns (uint256) {
        return uint256(keccak256(abi.encodePacked(input)));
    }

    function getAttribute1(uint256 tokenId)
        internal
        view
        returns (string memory, uint8)
    {
        return pluck(tokenId, "ONE");
    }

    function getAttribute2(uint256 tokenId)
        internal
        view
        returns (string memory, uint8)
    {
        return pluck(tokenId, "TWO");
    }

    function getAttribute3(uint256 tokenId)
        internal
        view
        returns (string memory, uint8)
    {
        return pluck(tokenId, "THREE");
    }

    function getAttribute4(uint256 tokenId)
        internal
        view
        returns (string memory, uint8)
    {
        return pluck(tokenId, "FOUR");
    }

    function getAttribute5(uint256 tokenId)
        internal
        view
        returns (string memory, uint8)
    {
        return pluck(tokenId, "FIVE");
    }

    function pluck(uint256 tokenId, string memory keyPrefix)
        internal
        view
        returns (string memory, uint8)
    {
        uint256 rand = random(
            string(abi.encodePacked(keyPrefix, toString(tokenId)))
        );
        string memory output = attributes[rand % attributes.length];
        uint8 rarity = rarities[rand % rarities.length];
        return (output, rarity);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override
        returns (string memory)
    {
        string[12] memory parts;
        uint8[5] memory rarityColor;

        parts[
            0
        ] = '<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet" viewBox="0 0 350 350"><style>'
        ".color0 { fill: #111827; font-family: monospace; font-size: 15px;}"
        ".color1 { fill: #FF0000; font-family: monospace; font-size: 15px;}"
        '</style><rect width="100%" height="100%" fill="white"/>';

        (parts[2], rarityColor[0]) = getAttribute1(tokenId);

        parts[1] = string(
            abi.encodePacked(
                '<text x="5" y="40" class="',
                "color",
                uint2str(rarityColor[0]),
                '">'
            )
        );

        (parts[4], rarityColor[1]) = getAttribute2(tokenId);

        parts[3] = string(
            abi.encodePacked(
                '</text><text x="5" y="70" class="',
                "color",
                uint2str(rarityColor[1]),
                '">'
            )
        );

        (parts[6], rarityColor[2]) = getAttribute3(tokenId);

        parts[5] = string(
            abi.encodePacked(
                '</text><text x="5" y="100" class="',
                "color",
                uint2str(rarityColor[2]),
                '">'
            )
        );

        (parts[8], rarityColor[3]) = getAttribute4(tokenId);

        parts[7] = string(
            abi.encodePacked(
                '</text><text x="5" y="130" class="',
                "color",
                uint2str(rarityColor[3]),
                '">'
            )
        );

        (parts[10], rarityColor[4]) = getAttribute5(tokenId);

        parts[9] = string(
            abi.encodePacked(
                '</text><text x="5" y="160" class="',
                "color",
                uint2str(rarityColor[4]),
                '">'
            )
        );

        parts[11] = "</text></svg>";

        string memory output = string(
            abi.encodePacked(
                parts[0],
                parts[1],
                parts[2],
                parts[3],
                parts[4],
                parts[5],
                parts[6],
                parts[7],
                parts[8]
            )
        );
        output = string(
            abi.encodePacked(output, parts[9], parts[10], parts[11])
        );

        string memory json = Base64.encode(
            bytes(
                string(
                    abi.encodePacked(
                        '{"name": "Gimme (the Loot) #',
                        toString(tokenId),
                        '", "description": "Gimme (the Loot) is a collection of cultural artifacts for black people and the people who love us. Gimme (the Loot) will be used to inspire stories exclusively available to Gimme (the Loot) community members.", "image": "data:image/svg+xml;base64,',
                        Base64.encode(bytes(output)),
                        '"}'
                    )
                )
            )
        );
        output = string(
            abi.encodePacked("data:application/json;base64,", json)
        );

        return output;
    }

    function mint(uint256 amount, address _recipient)
        public
        payable
        nonReentrant
    {
        uint256 supply = totalSupply();
        require(amount <= MAX_PER_TX, "Exceeds max mint per transaction!");
        require(
            addressToMintCount[_recipient] + amount <= MAX_MINTS,
            "Exceeded wallet mint limit!"
        );
        require(
            supply + amount <= MAX_SUPPLY - reservedLoot,
            "Exceeds max supply!"
        );
        require(msg.value >= price * amount, "Invalid Eth value sent!");

        for (uint256 i = 1; i <= amount; i++) {
            _safeMint(_recipient, supply + i);
        }
        addressToMintCount[_recipient] += amount;
    }

    function reserveTeamTokens(address _to, uint256 _reserveAmount)
        public
        onlyOwner
    {
        require(_reserveAmount <= reservedLoot, "Not enough reserves");

        uint256 supply = totalSupply();

        for (uint256 i = 1; i <= _reserveAmount; i++) {
            _safeMint(_to, supply + i);
        }
        reservedLoot = reservedLoot - _reserveAmount;
    }

    function withdraw() public onlyOwner {
        address recipient1 = 0xdF161D71ABB7167C0C8f0a0e7fCf717AB589348a;
        address recipient2 = 0xC75446A6AdaEF73269dBdEcE73536977B2b639e0;

        // Withdraw 20% of the tokens
        payable(recipient1).transfer((address(this).balance * 20) / 100);
        // Withdraw the rest of the tokens
        payable(recipient2).transfer(address(this).balance);
    }

    function toString(uint256 value) internal pure returns (string memory) {
        // Inspired by OraclizeAPI's implementation - MIT license
        // https://github.com/oraclize/ethereum-api/blob/b42146b063c7d6ee1358846c198246239e9360e8/oraclizeAPI_0.4.25.sol

        if (value == 0) {
            return "0";
        }
        uint256 temp = value;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        bytes memory buffer = new bytes(digits);
        while (value != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + uint256(value % 10)));
            value /= 10;
        }
        return string(buffer);
    }

    function uint2str(uint256 _i)
        internal
        pure
        returns (string memory _uintAsString)
    {
        if (_i == 0) {
            return "0";
        }
        uint256 j = _i;
        uint256 len;
        while (j != 0) {
            len++;
            j /= 10;
        }
        bytes memory bstr = new bytes(len);
        uint256 k = len;
        while (_i != 0) {
            k = k - 1;
            uint8 temp = (48 + uint8(_i - (_i / 10) * 10));
            bytes1 b1 = bytes1(temp);
            bstr[k] = b1;
            _i /= 10;
        }
        return string(bstr);
    }

    constructor() ERC721("Gimme (the Loot)", "GIMME") Ownable() {}
}

/// [MIT License]
/// @title Base64
/// @notice Provides a function for encoding some bytes in base64
/// @author Brecht Devos <brecht@loopring.org>
library Base64 {
    bytes internal constant TABLE =
        "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

    /// @notice Encodes some bytes to the base64 representation
    function encode(bytes memory data) internal pure returns (string memory) {
        uint256 len = data.length;
        if (len == 0) return "";

        // multiply by 4/3 rounded up
        uint256 encodedLen = 4 * ((len + 2) / 3);

        // Add some extra buffer at the end
        bytes memory result = new bytes(encodedLen + 32);

        bytes memory table = TABLE;

        assembly {
            let tablePtr := add(table, 1)
            let resultPtr := add(result, 32)

            for {
                let i := 0
            } lt(i, len) {

            } {
                i := add(i, 3)
                let input := and(mload(add(data, i)), 0xffffff)

                let out := mload(add(tablePtr, and(shr(18, input), 0x3F)))
                out := shl(8, out)
                out := add(
                    out,
                    and(mload(add(tablePtr, and(shr(12, input), 0x3F))), 0xFF)
                )
                out := shl(8, out)
                out := add(
                    out,
                    and(mload(add(tablePtr, and(shr(6, input), 0x3F))), 0xFF)
                )
                out := shl(8, out)
                out := add(
                    out,
                    and(mload(add(tablePtr, and(input, 0x3F))), 0xFF)
                )
                out := shl(224, out)

                mstore(resultPtr, out)

                resultPtr := add(resultPtr, 4)
            }

            switch mod(len, 3)
            case 1 {
                mstore(sub(resultPtr, 2), shl(240, 0x3d3d))
            }
            case 2 {
                mstore(sub(resultPtr, 1), shl(248, 0x3d))
            }

            mstore(result, encodedLen)
        }

        return string(result);
    }
}
