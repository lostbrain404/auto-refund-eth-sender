// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// A smart contract to send ETH and automatically refund excess ETH to the sender
contract AutoRefundSender {

    // Events to log activities on-chain
    event Received(address indexed sender, uint amount);     // Emitted when ETH is received
    event sentEth(address indexed to, uint amount);          // Emitted when ETH is sent to a recipient
    event Refunded(address indexed sender, uint amount);     // Emitted when excess ETH is refunded

    // Special receive function to handle plain ETH transfers (without data)
    receive() external payable {
        emit Received(msg.sender, msg.value);   // Log received ETH
    }

    /**
     * @dev Sends ETH to a specified recipient and refunds any extra ETH sent.
     * @param _recipient The address to send ETH to.
     * @param amount The amount of ETH to send (in wei).
     */
    function sendTo(address payable _recipient, uint256 amount) public payable {
        // Ensure the sender sent enough ETH
        require(msg.value >= amount, "not enough eth");

        // Send the specified amount to the recipient
        (bool sent, ) = _recipient.call{value: amount}("");
        require(sent, "failed to send eth");

        // Emit the sent event
        emit sentEth(_recipient, amount);

        // Calculate any extra ETH sent
        uint256 refund = msg.value - amount;

        // If extra ETH exists, refund it to the sender
        if (refund > 0) {
            (bool refunded, ) = payable(msg.sender).call{value: refund}("");
            require(refunded, "refund failed");
            emit Received(msg.sender, refund);  // Log the refund
        }
    }

    /**
     * @dev Returns the current ETH balance of the contract.
     * @return The ETH balance (in wei).
     */
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}
