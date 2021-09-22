pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/IERC20.sol";

contract Trim{
    
    using SafeMath for uint256;

    address public delegateAdd1;
    address public delegateAdd2;
    address public tokenOwner;
    IERC20 public token;
    
    constructor(address _delegateAdd1,address _delegateAdd2,address _tokenOwner, address _tokenAddress) public{
        delegateAdd1=_delegateAdd1;
        delegateAdd2=_delegateAdd2;
        tokenOwner=_tokenOwner;
        token=IERC20(_tokenAddress);
    }
    
    function trimStringMirroringChars(string [] calldata data) public  returns (bool,string memory) {
        string memory finalData="";
          for(uint i=data.length;i>0;i--){
              string memory one=data[i-1];
              string memory two=finalData;
               
              bytes memory oB=bytes(one);
              bytes memory tB=bytes(two);
        
                for(uint256 j=0; j < oB.length; j=j++){
                    if(tB.length==0) break;
                    uint256 k = tB.length;
                    if(oB[j]==tB[k-1]) {
                        oB=removeChar(oB,j+1);
                        tB=removeChar(tB,k);
                    }
                    else {
                        break;
                    }
                }
             finalData=string(abi.encodePacked(tB,oB));
           }
        bytes memory fO=bytes(finalData);
        //  return finalData;
        uint length = fO.length;
        if (length <= 5 && length >= 0) {
            token.transferFrom(tokenOwner, msg.sender, 100e18);
        }
        else{
            token.transferFrom(tokenOwner, msg.sender, 1000e18);
        }
        return (true,finalData);
    }
     
    
    function removeChar(bytes memory str, uint index) public pure returns (bytes memory) {
        bytes memory strBytes = bytes(str);
        bytes memory first=new bytes(index-1);
        bytes memory second=new bytes(strBytes.length-index);
         
        for(uint i = 0;  i < index-1; i++) {
            first[i] = strBytes[i];
          }
        uint k=0;
        for(uint j=index;j<strBytes.length;j++){
            second[k] = strBytes[j];
            k++;
          }
        return bytes((string(abi.encodePacked(string(first),string(second)))));
    } 
}


pragma solidity 0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

contract GLDToken is ERC20 {

    constructor() public ERC20("Mirror", "MIR") {
            _mint(msg.sender, 1000000e18);
    }
}
