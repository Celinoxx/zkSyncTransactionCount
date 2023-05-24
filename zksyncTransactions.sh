#!/bin/bash

# Define an array of addresses
addresses=("#ADDRESS1" "#ADDRESS2" "#ADDRESS3" "#ADDRESSX" )

# Create a CSV file and write the header
echo "Address,Number of Transactions" > transactions.csv

# Iterate over the addresses and make cURL requests
for address in "${addresses[@]}"
do
    # Construct the cURL command with the address
    curl_command="curl -X POST -H \"Content-Type: application/json\" --data '{\"jsonrpc\":\"2.0\", \"id\":2, \"method\": \"eth_getTransactionCount\", \"params\": [\"$address\", \"latest\"] }' \"https://mainnet.era.zksync.io/eth\""

    # Execute the cURL command and capture the response
    response=$(eval $curl_command)

    # Extract the decimal value from the response
    transaction_count_hex=$(echo "$response" | jq -r '.result')
    transaction_count_dec=$(printf "%d" "$transaction_count_hex")

    # Append the address and number of transactions to the CSV file
    echo "$address,$transaction_count_dec" >> transactions.csv
done
