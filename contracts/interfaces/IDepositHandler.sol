pragma solidity 0.6.4;

interface IDepositHandler {
    // Implementing contracts must have the below variable
    // indicating what type of deposit they handle
    // string public _depositType;

    function getDepositType() external returns (string memory);
    function deposit(uint256 depositID, address depositer, bytes calldata data) external;
    function executeDeposit(bytes calldata data) external;
}