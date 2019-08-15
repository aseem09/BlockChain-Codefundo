pragma solidity >=0.5.0<0.7.0;

contract Owned {
    address owner;
    
    constructor() public {
        owner = msg.sender;
    }
    
   modifier onlyOwner {
       require(msg.sender == owner);
       _;
   }
}

contract Courses is Owned {
    
    uint count=0;
    struct Instructor {
        uint age;
        bytes16 fName;
        bytes16 lName;
    }
    
    mapping (address => Instructor) instructors;
    address[] public instructorAccts;
    bytes16[] voters;

    event instructorInfo(
       bytes16 fName,
       bytes16 lName,
       uint age
    );
    
    function setInstructor(address _address, uint _age, bytes16 _fName, bytes16 _lName) public onlyOwner{
        Instructor memory instructor = instructors[_address];
        count++;
        instructor.age = _age;
        instructor.fName = _fName;
        instructor.lName = _lName;
        
        voters.push(_fName);
        instructorAccts.push(_address);
        emit instructorInfo(_fName, _lName, _age);
    }
    
    function getInstructors() public view returns(address[] memory) {
        return instructorAccts;
    }
    function getVoters() public view returns(uint) {
        return count;
    }
    
    function getInstructor(address _address) public view returns (uint, bytes16, bytes16) {
        return (instructors[_address].age, instructors[_address].fName, instructors[_address].lName);
    }
    
    function countInstructors() public view returns (uint) {
        return count;
    }
    
}