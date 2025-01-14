//SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "./ERC404.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract Void is ERC404 {
    string public dataURI;
    string public baseTokenURI;

    constructor(address _owner) ERC404("void404", "void404", 18, 10000, _owner) {
        balanceOf[_owner] = 10000 * 10 ** 18;
        whitelist[_owner] = true;
    }

    function yeet(uint256 amount) public {
        uint256 total = amount * 10 ** 18;
        bool yeeting = transfer(address(0), total);
        if (yeeting == true){
            totalSupply -= total;
        }
    }

    function setDataURI(string memory _dataURI) public onlyOwner {
        dataURI = _dataURI;
    }

    function setTokenURI(string memory _tokenURI) public onlyOwner {
        baseTokenURI = _tokenURI;
    }

    function setNameSymbol(string memory _name, string memory _symbol) public onlyOwner {
        _setNameSymbol(_name, _symbol);
    }

    function tokenURI(uint256 id) public view override returns (string memory) {
        if (bytes(baseTokenURI).length > 0) {
            return string.concat(baseTokenURI, Strings.toString(id));
        } else {
            string memory URI;
            uint8 seed = uint8(bytes1(keccak256(abi.encodePacked(id))));
            if (seed <= 100) {
                URI = string.concat(dataURI,"1.json");
            } else if (seed <= 160) {
                URI = string.concat(dataURI,"2.json");
            } else if (seed <= 210) {
                URI = string.concat(dataURI,"3.json");
            } else if (seed <= 240) {
                URI = string.concat(dataURI,"4.json");
            } else if (seed <= 255) {
                URI = string.concat(dataURI,"5.json"); 
            }
        return URI;
        }
    }
}