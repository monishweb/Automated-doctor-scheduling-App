module DoctorScheduling::Appointment {
    use std::string::String;
    use aptos_framework::timestamp;
    use aptos_framework::signer;
    use aptos_std::table::{Self, Table};
    
    /// Error codes
    const E_NOT_AUTHORIZED: u64 = 1;
    const E_APPOINTMENT_NOT_FOUND: u64 = 2;
    const E_APPOINTMENT_ALREADY_CONFIRMED: u64 = 3;
    const E_APPOINTMENT_ALREADY_EXISTS: u64 = 4;
    
    /// Appointment status
    const STATUS_PENDING: u8 = 0;
    const STATUS_CONFIRMED: u8 = 1;
    
    /// Structure for appointment
    struct Appointment has store, drop {
        doctor_address: address,
        patient_address: address,
        timestamp: u64,         // Appointment time as Unix timestamp
        status: u8,             // 0: pending, 1: confirmed
        description: String,    // Brief description of the appointment
    }
    
    /// Store for all appointments
    struct AppointmentStore has key {
        appointments: Table<u64, Appointment>, // Key is appointment ID
        next_appointment_id: u64,
    }
    
    /// Initialize appointment store for user
    public fun init_appointment_store(account: &signer) {
        let appointments = table::new<u64, Appointment>();
        move_to(account, AppointmentStore {
            appointments,
            next_appointment_id: 0,
        });
    }
    
    /// Function for patients to request an appointment with a doctor
    public fun request_appointment(
        patient: &signer,
        doctor_address: address,
        appointment_time: u64,
        description: String
    ) acquires AppointmentStore {
        let patient_address = signer::address_of(patient);
        
        // Ensure the patient has initialized the store
        if (!exists<AppointmentStore>(patient_address)) {
            init_appointment_store(patient);
        };
        
        let appointment_store = borrow_global_mut<AppointmentStore>(patient_address);
        let appointment_id = appointment_store.next_appointment_id;
        
        // Create the appointment
        let new_appointment = Appointment {
            doctor_address,
            patient_address,
            timestamp: appointment_time,
            status: STATUS_PENDING,
            description,
        };
        
        // Store the appointment
        table::add(&mut appointment_store.appointments, appointment_id, new_appointment);
        appointment_store.next_appointment_id = appointment_id + 1;
    }
    
    /// Function for doctors to confirm appointments
    public fun confirm_appointment(
        doctor: &signer,
        patient_address: address,
        appointment_id: u64
    ) acquires AppointmentStore {
        let doctor_address = signer::address_of(doctor);
        
        assert!(exists<AppointmentStore>(patient_address), E_APPOINTMENT_NOT_FOUND);
        
        let appointment_store = borrow_global_mut<AppointmentStore>(patient_address);
        assert!(table::contains(&appointment_store.appointments, appointment_id), E_APPOINTMENT_NOT_FOUND);
        
        let appointment = table::borrow_mut(&mut appointment_store.appointments, appointment_id);
        
        // Ensure the doctor is the one assigned to the appointment
        assert!(appointment.doctor_address == doctor_address, E_NOT_AUTHORIZED);
        // Ensure the appointment is not already confirmed
        assert!(appointment.status == STATUS_PENDING, E_APPOINTMENT_ALREADY_CONFIRMED);
        
        // Confirm the appointment
        appointment.status = STATUS_CONFIRMED;
    }
}