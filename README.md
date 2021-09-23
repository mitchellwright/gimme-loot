# Gimme (the Loot)

This repository uses Next.js and Tailwind for the front end experience.

We are using Hardhat for Solidity development. We also are using the [@openzeppelin/contracts](https://www.npmjs.com/package/@openzeppelin/contracts) NPM package to import standard OZ contracts.

## How to use

To deploy the contract to the test net, make sure that to update `hardhat.config.js` to have the private key of the wallet you'd like to deploy from, and an Infura project ID.

You will also need to add the contract to the allowlist in the security settings for the project within Infura.

Once all that is set up, you can run the following command to deploy to the Rinkeby test network:
`npx hardhat run scripts/deploy.js --network rinkeby`

## How to verify the contract

Once the contract is deployed, you can also verify the contract. First, add the contract address to the allowlist in the security setting for the project in Infura.

Then run the following command:
`npx hardhat verify --network rinkeby DEPLOYED_CONTRACT_ADDRESS`
