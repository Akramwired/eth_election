pragma solidity 0.5.0;

contract Election {
    // Model a Candidate
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    // Store Candidates Count
    uint public candidatesCount;

    //storing the accounts of the voters that have voted already
    mapping(address => bool) public voters;

    // Read/write Candidates
    mapping(uint => Candidate) public candidates;

    // Read/write candidate
    string public candidate;

    // voted event
    event votedEvent (
        uint indexed _candidateId
    );

    // Constructor
    constructor () public {
        addCandidate("Candidate 1");
        addCandidate("Candidate 2");
    }

    function addCandidate (string memory _name) private {
        candidatesCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    function vote (uint _candidateId) public {
        // voter hasn't voted before
        require(!voters[msg.sender]);
        // voter to vote a valide candidate
        require(_candidateId > 0 && _candidateId <= candidatesCount);
        // voter can vote only once
        voters[msg.sender] = true;
        // Cast vote to a particular candidate
        candidates[_candidateId].voteCount ++;

        // emitting the voted event
        emit votedEvent(_candidateId);
    }
}