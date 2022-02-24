//*~~~> SPDX-License-Identifier: unlicensed
pragma solidity  >=0.8.0 <0.9.0;

import "@openzeppelin/contracts/access/AccessControl.sol";

contract MarketRoleProvider is AccessControl {

  address public marketplaceAdd;
  address public nftAdd;
  address public marketMintAdd;
  address public collectionsAdd;
  address public offersAdd;
  address public tradesAdd;
  address public bidsAdd;
  address public rewardsAdd;
  address public roleAdd;
  address public ownerProxyAdd;
  address public erc721FactoryAdd;
  address public erc1155FactoryAdd;
  address public PHUNKYAdd;
  address public devSig;

  mapping (bytes32 => address) marketBytes;

  /*~~~>
    Roles allow for designated accessibility
  <~~~*/
  bytes32 public constant PROXY_ROLE = keccak256("PROXY_ROLE");
  bytes32 public constant CONTRACT_ROLE = keccak256("CONTRACT_ROLE");
  bytes32 public constant DEV_ROLE = keccak256("DEV_ROLE");

  //*~~~> For tracking contract addresses
  bytes32 public constant DEV = keccak256("DEV");
  bytes32 public constant NFT = keccak256("NFT");
  bytes32 public constant MINT = keccak256("MINT");
  bytes32 public constant BIDS = keccak256("BIDS");
  bytes32 public constant ROLE = keccak256("ROLE");
  bytes32 public constant PROXY = keccak256("PROXY");
  bytes32 public constant OFFERS = keccak256("OFFERS");
  bytes32 public constant TRADES = keccak256("TRADES");
  bytes32 public constant PHUNKY = keccak256("PHUNKY");
  bytes32 public constant MARKET = keccak256("MARKET");
  bytes32 public constant REWARDS = keccak256("REWARDS");
  bytes32 public constant COLLECTION = keccak256("COLLECTION");
  bytes32 public constant ERC721FACTORY = keccak256("ERC721FACTORY");
  bytes32 public constant ERC1155FACTORY = keccak256("ERC1155FACTORY");

  /*~~~>
    Error message for unauthorized access
  <~~~*/
  string Mess = "DOES NOT HAVE ADMIN ROLE";

  /*~~~>
    Sets deployment address as default admin role
  <~~~*/
  constructor(address _controller) {
      _setupRole(DEFAULT_ADMIN_ROLE, _controller);
      _setupRole(PROXY_ROLE, _controller);
  }

  modifier hasAdmin(){
    require(hasRole(PROXY_ROLE, msg.sender), Mess);
    _;
  }

  function setMarketAdd(address _mrktAdd) hasAdmin public returns(bool){
    marketplaceAdd = _mrktAdd;
    marketBytes[MARKET]= _mrktAdd;
    return true;
  }
  function setNftAdd(address _nftAdd) hasAdmin public returns(bool){
    nftAdd = _nftAdd;
    marketBytes[NFT]= _nftAdd;
    return true;
  }
  function setMarketMintAdd(address _mintAdd) hasAdmin public returns(bool){
    marketMintAdd = _mintAdd;
    marketBytes[MINT] = _mintAdd;
    return true;
  }
   function setCollectionsAdd(address _collAdd) hasAdmin public returns(bool){
    collectionsAdd = _collAdd;
    marketBytes[COLLECTION] = _collAdd;
    return true;
  }
  function setOffersAdd(address _offAdd) hasAdmin public returns(bool){
    offersAdd = _offAdd;
    marketBytes[OFFERS] = _offAdd;
    return true;
  }
  function setTradesAdd(address _tradAdd) hasAdmin public returns(bool){
    tradesAdd = _tradAdd;
    marketBytes[TRADES] = _tradAdd;
    return true;
  }
  function setBidsAdd(address _bidsAdd) hasAdmin public returns(bool){
    bidsAdd = _bidsAdd;
    marketBytes[BIDS] = _bidsAdd;
    return true;
  }
  function setRwdsAdd(address _rwdsAdd) hasAdmin public returns(bool){
    rewardsAdd = _rwdsAdd;
    marketBytes[REWARDS] = _rwdsAdd;
    return true;
  }
  function setRoleAdd(address _role) public hasAdmin returns(bool){
    roleAdd = _role;
    marketBytes[ROLE] = _role;
    return true;
  }
  function setOwnerProxyAdd(address _proxyAdd) public hasAdmin returns(bool){
    ownerProxyAdd = _proxyAdd;
    marketBytes[PROXY]=_proxyAdd;
    return true;
  }
  function setFactoryAdd(address _erc721) public hasAdmin returns(bool){
    erc721FactoryAdd = _erc721;
    marketBytes[ERC721FACTORY] = _erc721;
    return true;
  }
  function set1155FactoryAdd(address _erc1155) public hasAdmin returns(bool){
    erc1155FactoryAdd = _erc1155;
    marketBytes[ERC1155FACTORY] = _erc1155;
    return true;
  }
  function setPhunkyAdd(address _phunky) public hasAdmin returns(bool) {
    PHUNKYAdd = _phunky;
    marketBytes[PHUNKY] = _phunky;
    return true;
  }
  function setDevSigAddress(address _sig) public hasAdmin returns(bool){
    devSig = _sig;
    marketBytes[DEV] = _sig;
    return true;
  }

  function fetchAddress(bytes32 _var) public view returns(address){
    return marketBytes[_var];
  }

  function hasTheRole(bytes32 role, address _address) public view returns(bool){
    bool isTrue = hasRole(role, _address);
    return isTrue;
  }

  ///@notice
  /*~~~> External ETH transfer forwarded to controller contract <~~~*/
  event FundsForwarded(uint value, address _from, address _to);
  receive() external payable {
    payable(ownerProxyAdd).transfer(msg.value);
      emit FundsForwarded(msg.value, msg.sender, ownerProxyAdd);
  }

  ///@notice
  //*~~~> Withdraw function for any stuck ETH sent
  function withdrawAmountFromContract(address _add) hasAdmin external {
      payable(_add).transfer(address(this).balance);
   }
}
