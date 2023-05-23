// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract Wigg_nash is ERC721, ERC721Enumerable, ERC721URIStorage {
    using Counters for Counters.Counter; //initialising counters library that we will use track our NFT id's

    Counters.Counter private _tokenIdCounter;

    // To limit the Max number of NFT's tjat users will be able to mint
    uint256 MAX_SUPPLY = 10000;

    constructor() ERC721("Wigg_nash", "WIGG") {} //assiging name and the symbol of our smart contract 

    //Miting the NFT here 
    // 1. Address of the wallet or the smart contract that we want to send the NFT to 
    // 2. Properties of the NFT which have to be sent to the address of the smart contact 
     
    function safeMint(address to, string memory uri) public{
        uint256 tokenId = _tokenIdCounter.current(); // giving the current token ID number to the token ID
        // checking the max supply with the tokenId , If the TokenId is greater than the max supply , display the error message
        require(tokenId <= MAX_SUPPLY, "I'm Sorry All the NFT's are Minted");
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
    }

    // The following functions are overrides required by Solidity.
    // Function overloading - We will rewrite the function in our child smart contract 

    function _beforeTokenTransfer(address from, address to, uint256 tokenId, uint256 batchSize)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId, batchSize);
    }

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    // this is the function in which the opensea and other marketplaces will call and gather the URI of the token
    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}