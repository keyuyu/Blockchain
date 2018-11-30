pragma solidity ^0.4.4;

contract bid {
 //   event Newbid(uint zombieId, uint _bidNumbera);

    uint public bidHighest = 0;  // databse id
    uint high_id = 0;  // bidding number
    uint d = 0;

    struct BidData {
        address account;
        uint bidNumber;
        uint timef;
    }

    struct Bidset {
        uint bidbase;    //Start Price;
        uint class;     //0: namely public bid, 1: sealed bid
        uint8 hour;      //bid time
        uint8 min;       // bid time
        uint n;          // setting time
        uint deadL;      //expiration time
        uint8 limitT;    // limit number of biding times
    }

    struct BidMark {     // find Bid
        uint id;  
        uint bidTimes;
    }

    BidData[] public bidDatas;   // database
    Bidset public b;                      
    mapping (address => BidMark) public bidMarks;
//uint bidbase,uint8 class,uint8 hour,uint8 min,uint8 limiT

    function bid ()
    {
        b.bidbase = 400;
        b.class = 0;
        b.hour = 0;
        b.min = 2;
        b.n = now;
        b.deadL = b.n/1000 + b.hour * 1 hours + b.min * 1 minutes;  // bid end time
        b.limitT = 3;
        d = b.deadL;
    }
    
    function bidingNumber(uint _bidNumber) returns (bool){  
        uint id;
        if(now/1000 < b.deadL&&_bidNumber > b.bidbase)
        { 
            if(bidMarks[msg.sender].bidTimes < b.limitT)// public bid:user can set the limit times,seal bid:the limit is 1
            {
                bidMarks[msg.sender].bidTimes++;
            }else{
                return false;
            }
            id = bidDatas.push(BidData(msg.sender,_bidNumber,now)) - 1;
        }else{
            return false;
        }
        
        if(_bidNumber > bidHighest)
        {
            bidHighest = _bidNumber;
            bidMarks[msg.sender].id = id;
            high_id = id;
        }
        return true;
    }

    function bidingRet() constant public returns (uint) {
        return bidHighest;
    }

    function bidingend() constant public returns (address a,uint b,uint c) {
        if(d > now/1000) 
        {
            return (0,0,0);
        }else{

        }
        return (bidDatas[high_id].account,bidDatas[high_id].bidNumber,bidDatas[high_id].timef);
    }

    function bidingAddressRet(address name) constant public returns (address,uint,uint) {
        if(b.class == 0) //public bid return
        {
            
        }else{
            return (0,0,0);
        }
        uint id = bidMarks[name].id;
       
        return (bidDatas[id].account,bidDatas[id].bidNumber,bidDatas[id].timef);
    }

    // function bidingTest() constant public returns (address) {
    //    // return bidSeals[0].account;
    //    return msg.sender;
    // }
    
    
}


