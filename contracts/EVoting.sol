// SPDX-License-Identifier: MIT

pragma solidity ^0.8.30;

contract EVoting {
    bool isCanVoting;
    
    address public owner;

    struct Candidate {
        address candidateAddress;
        uint numberOfVotes;
    }

    Candidate[] public candidateList;

    mapping(address => bool) public registeredCandidate;

    mapping(address => bool) public hasVoted;

    constructor() {
        owner = msg.sender;
        isCanVoting = false;
    }

    function addCandidate(address _candidateAddress) public { 
        require(msg.sender == owner, "Only owner can add candidates");
        require(!registeredCandidate[_candidateAddress], "Candidate already registered");
        
        candidateList.push(Candidate(_candidateAddress, 0));
        registeredCandidate[_candidateAddress] = true;
    }

    function getTotalCandidates() public view returns (uint) {
        return candidateList.length;
    }

    function setIsCanVoting(bool _value) public {
        require(msg.sender == owner, "Only owner can add candidates");
        isCanVoting = _value;
    }

    function vote(uint _candidateIndex) public {
        require(isCanVoting, "Voting is not active");
        require(_candidateIndex < candidateList.length, "Candidate does not exist");
        require(!hasVoted[msg.sender], "You have already voted");
        require(msg.sender != owner, "Owner is not allowed to vote");

        candidateList[_candidateIndex].numberOfVotes++;
        hasVoted[msg.sender] = true;
    }

    function getWinner() public view returns(Candidate memory) {
        require(candidateList.length > 0, "No candidates available");
        require(!isCanVoting, "Voting period is still active");

        uint highestVotes = 0;
        uint winnerIndex = 0;

        for (uint i = 0; i < candidateList.length; i++) {
            if (candidateList[i].numberOfVotes > highestVotes) {
                highestVotes = candidateList[i].numberOfVotes;
                winnerIndex = i;
            }
        }

        return candidateList[winnerIndex];
    }
}