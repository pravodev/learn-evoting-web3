# 🗳️ EVoting Smart Contract

A simple and transparent **Ethereum-based voting system** built with Solidity.  
This contract allows an **owner** to register candidates, control the voting process, and determine the election winner on-chain.

---

## 📜 Overview

The **EVoting** contract provides a decentralized way to conduct elections on the Ethereum blockchain.  
It ensures:
- Only the contract owner can manage the voting process.
- Each voter can vote only once.
- Votes are counted transparently.
- The winner can only be declared after the voting period has ended.

---

## ⚙️ Smart Contract Details

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;
```

### Contract: `EVoting`

#### State Variables
| Variable | Type | Description |
|-----------|------|-------------|
| `owner` | `address` | The address that deployed the contract and controls administrative actions. |
| `isCanVoting` | `bool` | Indicates whether voting is currently active. |
| `candidateList` | `Candidate[]` | Stores all registered candidates. |
| `registeredCandidate` | `mapping(address => bool)` | Tracks addresses that are already registered as candidates. |
| `hasVoted` | `mapping(address => bool)` | Tracks which addresses have already voted. |

#### Structs
```solidity
struct Candidate {
    address candidateAddress;
    uint numberOfVotes;
}
```
Represents a candidate with their wallet address and total number of votes.

---

## 🚀 Features

✅ **Owner Controls**
- Only the owner can:
  - Add candidates
  - Start or stop voting

✅ **Voter Protections**
- Each address can only vote once.
- The owner cannot vote.
- Voting can only happen when active.

✅ **Transparent Results**
- Anyone can view all candidates and their votes.
- The winner can be determined on-chain after voting ends.

---

## 🧩 Functions

### `constructor()`
Sets the contract deployer as the owner and initializes voting as inactive.

---

### `addCandidate(address _candidateAddress)`
Registers a new candidate.

**Requirements:**
- Only the owner can call this.
- Candidate must not already be registered.

---

### `getTotalCandidates() → uint`
Returns the total number of registered candidates.

---

### `setIsCanVoting(bool _value)`
Activates or deactivates the voting session.

**Requirements:**
- Only the owner can call this.

---

### `vote(uint _candidateIndex)`
Casts a vote for a candidate at a given index.

**Requirements:**
- Voting must be active.  
- Candidate must exist.  
- Caller must not have voted before.  
- Owner cannot vote.

---

### `getWinner() → Candidate`
Returns the winning candidate.

**Requirements:**
- There must be at least one candidate.  
- Voting must be finished (`isCanVoting == false`).  

Returns a `Candidate` struct containing:
- `candidateAddress`
- `numberOfVotes`

---

## 🧠 Example Flow

1. **Deploy** the contract.  
   The deployer automatically becomes the owner.

2. **Add candidates**  
   ```solidity
   addCandidate(0xAbc...123);
   addCandidate(0xDef...456);
   ```

3. **Start voting**  
   ```solidity
   setIsCanVoting(true);
   ```

4. **Voters cast votes**  
   ```solidity
   vote(0); // votes for first candidate
   ```

5. **End voting**  
   ```solidity
   setIsCanVoting(false);
   ```

6. **Get the winner**  
   ```solidity
   getWinner();
   ```

---

## 🔒 Security Notes
- `require` statements are used extensively to enforce correct behavior.
- The contract uses simple logic and no external calls, minimizing attack surfaces.
- All voting data is stored on-chain and fully transparent.

---

## 🧾 License
This project is licensed under the **MIT License**.  
You are free to use, modify, and distribute it as long as proper credit is given.