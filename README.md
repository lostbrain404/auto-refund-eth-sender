# Auto Refund ETH Sender

A simple and secure Solidity smart contract that allows sending Ether to a recipient with automatic refund of any excess ETH sent. Designed for safe ETH transfers with event logging.

## 📦 Features

- Accepts incoming ETH transfers
- Sends a specified amount to any recipient
- Automatically refunds the extra ETH to the sender
- Emits events for transparency and tracking:
  - `Received`: when the contract receives ETH
  - `sentEth`: when ETH is sent to a recipient
  - `Refunded`: when a refund is made to the sender

## 🧠 Use Case

This contract is useful when:
- You want to transfer ETH with built-in safety checks
- You want to handle overpayments by returning the extra ETH
- You need on-chain logs for all transfers
