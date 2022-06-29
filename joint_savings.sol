/*
Joint Savings Account
---------------------

Automation of the creation of joint savings accounts. 
A solidity smart contract that accepts two user addresses that are then able to control a joint savings account. 
The smart contract will use ether management functions to implement various requirements from the financial institution to provide the features of the joint savings account.

---------------------
Using this contract in Remix we will use the following Ethereum dummy addresses on the Vanity-ETH website, which includes an Ethereum vanity address generator.

  Dummy account1 address: 0x0c0669Cd5e60a6F4b8ce437E4a4A007093D368Cb
  Dummy account2 address: 0x7A1f3dFAa0a4a19844B606CD6e91d693083B12c0
*/

pragma solidity ^0.5.0;

// Define a new contract named `JointSavings`
contract JointSavings {
    /*
    Define the following variables in the new contract:
      - Two variables of type `address payable` named `accountOne` and `accountTwo`
      - A variable of type `address public` named `lastToWithdraw`
      - Two variables of type `uint public` named `lastWithdrawAmount` and `contractBalance`
    */
  address payable accountOne;
  address payable accountTwo;
  address public lastToWithdraw;
  uint public lastWithdrawAmount; 
  uint public contractBalance;
    
    /*
    Define a function named `withdraw` that accepts two arguments:
      - An `amount` of type `uint`
      - A `recipient` of type `payable address`
      
    */

  function withdraw(uint amount, address payable recipient) public {
    require(recipient == accountOne || recipient == accountTwo, "You don't own this account!");
    require(amount <= contractBalance, "Insufficient funds!");
    
    if (lastToWithdraw != recipient) {
      lastToWithdraw = recipient;
    }
      
    recipient.transfer(amount);
    lastWithdrawAmount = amount;
    contractBalance = address(this).balance;
    }

  // Define a `public payable` function named `deposit`
  function deposit() public payable {

    contractBalance = address(this).balance;
  }
   
   /*
    Define a `public` function named `setAccounts` that receive two `address payable` arguments named `account1` and `account2`.
    */
  function setAccounts(address payable account1, address payable account2) public{

    accountOne = account1;
    accountTwo = account2;
  }
   
   /*
    Add a fallback function so that your contract can store ether that's sent from outside the deposit function
    */
  function() external payable {}

}
