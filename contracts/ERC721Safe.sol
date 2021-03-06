pragma solidity 0.6.4;

import "./helpers/SafeMath.sol";
import "./erc/ERC721/IERC721.sol";
import "./erc/ERC721/ERC721Mintable.sol";

contract ERC721Safe {
    using SafeMath for uint256;

    // ERC721 contract => amount of tokens owned by Safe
    mapping(address => uint256) public _balances;

    // ERC721 contract => amount of tokens burned by Safe
    mapping(address => uint256) public _burnedTokens;

    function fundERC721(address tokenAddress, address owner, uint tokenID) public {
        IERC721 erc721 = IERC721(tokenAddress);
        erc721.transferFrom(owner, address(this), tokenID);

        _balances[tokenAddress] = _balances[tokenAddress].add(1);
    }

    function lockERC721(address tokenAddress, address owner, address recipient, uint tokenID) internal {
        IERC721 erc721 = IERC721(tokenAddress);
        erc721.transferFrom(owner, recipient, tokenID);

        _balances[tokenAddress] = _balances[tokenAddress].add(1);
    }

    function releaseERC721(address tokenAddress, address owner, address recipient, uint256 tokenID) internal {
        IERC721 erc721 = IERC721(tokenAddress);
        erc721.transferFrom(owner, recipient, tokenID);

        _balances[tokenAddress] = _balances[tokenAddress].sub(1);
    }

    function burnERC721(address tokenAddress, uint256 tokenID) internal {
        ERC721Mintable erc721 = ERC721Mintable(tokenAddress);
        erc721.burn(tokenID);

        _burnedTokens[tokenAddress] = _burnedTokens[tokenAddress].add(1);
    }
}
