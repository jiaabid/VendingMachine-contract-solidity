// SPDX-License-Identifier: MIT

pragma solidity ^0.8.11;

contract VendingMachine {
    address public _owner;
    mapping (address=>uint) public cupcakeBalance;

    constructor(){
        _owner = msg.sender;
        cupcakeBalance[address(this)] = 10;
    }

//returns balance of cupcakes
 function retireveCupcakeBalance() public view returns (uint){
     return cupcakeBalance[address(this)];
 }

//owner can restock the balance
    function restock(uint itemCount) public{
        require(msg.sender == _owner,"Access Denied! Not a owner.");
        cupcakeBalance[address(this)] += itemCount;
    }

    //purchase the cupcake
    function purchase(uint itemCount) public payable {
        require(msg.value >= itemCount * 1 ether,"Not sufficient amount for the cupcakes!");
        require(cupcakeBalance[address(this)]>= itemCount,"Sorry we are out of stock!");
        cupcakeBalance[address(this)] -= itemCount;
        cupcakeBalance[msg.sender] += itemCount ;
    }
}