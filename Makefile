-include .env

.PHONY: all test deploy

build :; forge build

test :; forge test

install :; forge install cyfrin/foundry-devops@0.2.2 --no-commit && forge install smartcontractkit/chainlink-brownie-contracts@1.1.1 --no-commit && forge install foundry-rs/forge-std@v1.8.2 --no-commit && forge install transmissions11/solmate@v6 --no-commit 

# must do cast wallet import default --interactive and save private key from metamask so `--account default` can access the private key safely and automatically
deploy-sepolia:
	@forge script script/DeployRaffle.s.sol:DeployRaffle --rpc-url $(SEPOLIA_RPC_URL) --account default --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv

# # to manually verify if auto-verifying from deploy target doesn't work, use this replacing the contract address with the one generated from the deploy. then upload the json file to verify contract on etherscan
# verify-contract:
# 	forge verify-contract <contract address> src/Raffle.sol:Raffle --etherscan-api-key $ETHERSCAN_API_KEY --rpc-url $SEPOLIA_RPC_URL --show-standard-json-input > json.json