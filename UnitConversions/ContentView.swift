//
//  ContentView.swift
//  UnitConversions
//
//  Created by Sandro Gakharia on 29.06.25.
//

import SwiftUI

struct ContentView: View {
    @State private var inputNumber = 1.0
    @State private var inputUnit = "seconds"
    @State private var outputUnit = "seconds"
    @FocusState private var isFocused: Bool
    let timeUnits = ["seconds", "minutes", "hours", "days"]
    
    func convertToSeconds(input: Double, unit: String) -> Double {
        if unit == "seconds" {
            return input
        } else if unit == "minutes" {
            return input * 60.0
        } else if unit == "hours" {
            return input * 60.0 * 60.0
        } else {
            return input * 60.0 * 60.0 * 24.0
        }
    }
    
    func convertToOthers(input: Double, outputUnit: String) -> Double {
        let seconds = convertToSeconds(input: input, unit: inputUnit)
        if outputUnit == "seconds" {
            return seconds
        } else if outputUnit == "minutes" {
            return seconds / 60.0
        } else if outputUnit == "hours" {
            return seconds / 60.0 / 60.0
        } else {
            return seconds / 60.0 / 60.0 / 24.0
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section ("How many units?") {
                    TextField(inputUnit, value: $inputNumber, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($isFocused)
                    Picker("From", selection: $inputUnit) {
                        ForEach(timeUnits, id: \.self) {
                            Text("\($0)")
                        }
                    }.pickerStyle(.navigationLink)
                    Picker("To", selection: $outputUnit) {
                        ForEach(timeUnits, id: \.self) {
                            Text("\($0)")
                        }
                    }.pickerStyle(.navigationLink)
                }
                
                Section ("Result") {
                    Text(convertToOthers(input: inputNumber, outputUnit: outputUnit).formatted())
                }
            }
            .navigationTitle("Time Converter")
            .toolbar {
                if isFocused {
                    Button("Done") {
                        isFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
