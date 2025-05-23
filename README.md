# Doctor Scheduling App

A decentralized application built on the Aptos blockchain that enables automated doctor appointment scheduling.

## Overview
This project implements a simple yet effective doctor appointment scheduling system using Aptos smart contracts. It allows patients to request appointments with doctors, and doctors to confirm these appointments, all recorded securely on the blockchain.

## Smart Contract Features

- **Patient Appointment Requests:** Patients can request appointments with doctors by specifying the doctor's address, preferred time, and a brief description of the visit.  
- **Doctor Confirmations:** Doctors can confirm pending appointments requested by patients.  
- **Appointment Status Tracking:** The system tracks whether appointments are pending or confirmed.  
- **Security:** Built-in authorization checks ensure only the designated doctor can confirm specific appointments.

## Technical Implementation
The smart contract is implemented in Move, Aptos's native programming language. It uses the following key components:

- **Table Structure:** Efficiently stores and accesses appointment data.  
- **Appointment Struct:** Contains all relevant appointment information.  
- **AppointmentStore Resource:** Manages appointments for each user.

## Getting Started

### Prerequisites
- Aptos CLI  
- Aptos SDK  
- Basic understanding of Move programming language

### Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/monishweb/Automated-doctor-scheduling-App.git
   cd Automated-doctor-scheduling-App

## Screenshot
![image](https://github.com/user-attachments/assets/2b94fdbf-d4ce-4766-a9a5-2a22f96d39ed)
![image](https://github.com/user-attachments/assets/ab9ec540-7443-4fc1-bf03-1b65843a1382)

"transaction_hash": "0xa35adfce0ff1da393af56152817909cc2cf40725ed12a89b2a89079c1ad57c5a",

