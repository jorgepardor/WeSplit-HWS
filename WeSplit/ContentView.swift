//
//  ContentView.swift
//  WeSplit
//
//  Created by Jorge Pardo on 16/9/23 as part of HWS 100 days of switftUI course.
//

import SwiftUI

struct ContentView: View {
    @State private var checkTotal = 0.0
    @State private var tipPercentage = 20
    @State private var peopleEating = 2
    @FocusState private var amountIsFocused : Bool
    
    let localCurrency: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currency?.identifier ?? "USD")
        
    var mealGrandTotal : Double {
        let tipSelected = Double(tipPercentage)
        let tipValue = checkTotal / 100 * tipSelected
        let mealGrandTotal = checkTotal + tipValue
        return mealGrandTotal
        
    }
    
    var totalPerPerson : Double {
        mealGrandTotal / Double(peopleEating + 2)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Monto de la factura:", value: $checkTotal, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Comensales:", selection: $peopleEating) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                } header: {
                    Text("Datos de la cuenta:")
                }
                
                Section {
                    Picker("Propina:", selection: $tipPercentage) {
                        ForEach(0..<101) {
                            Text($0, format: .percent)
                        }
                    }
                } header: {
                    Text("¿Cuánta propina quieres dejar?")
                }

                
                Section {
                    Text(totalPerPerson, format: localCurrency)
                } header: {
                    Text("Monto a pagar por persona:")
                }
                
                Section {
                    Text(mealGrandTotal, format: localCurrency)
                } header: {
                    Text("Total de la factura (Imp. Incluidos):")
                }
            }
            .navigationTitle("WeSplit!")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
