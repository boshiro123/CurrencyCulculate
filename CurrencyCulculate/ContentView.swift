//
//  ContentView.swift
//  CurrencyCulculate
//
//  Created by shirokiy on 06/09/2023.
import SwiftUI

struct ContentView: View {
    
    @State private var itemSelected = 0
    @State private var itemSelected2 = 1
    @State private var amount: String = ""
    @State private var showAlert = false
    private var currencies = ["USD","EUR","BYN"]
    private var currencies2 = ["USD","EUR","BYN"]

    func convert(_ convert: String)->String{
        
        var conversation = 1.0
        let amount = Double(convert.doubleValue)
        let selectedCurrency = currencies[itemSelected]
        let to = currencies[itemSelected2]
        let eurRates = ["USD": 1.075,"EUR": 1.0, "BYN": 3.499]
        let usdRates = ["USD": 1.0,"EUR": 0.93, "BYN": 3.256]
        let bynRates = ["USD": 0.307,"EUR": 0.286, "BYN": 1]
        
        switch(selectedCurrency){
        case "USD" :
            conversation = amount*(usdRates[to] ?? 0.0)
        case "EUR" :
            conversation = amount*(eurRates[to] ?? 0.0)
        case "BYN" :
            conversation = amount*(bynRates[to] ?? 0.0)
        default:
            print("Something went wrong!!!")
        }
        
        return String(format: "%.2f", conversation)
    }
    
    var body: some View {
        HStack{
            Form{
                Section(header: Text("Convert a currency")){
                    TextField("Enter an amount",text: $amount)
                        .keyboardType(.decimalPad)
                    
                    Picker(selection: $itemSelected, label: Text("From")){
                        ForEach(0..<currencies.count){ index in
                            if(!(currencies[itemSelected2]==currencies[index])){
                                Text(self.currencies[index]).tag(index)
                            }

                        }
                        
                    }
                    
                    Picker(selection: $itemSelected2, label: Text("To")){
                        ForEach(0..<currencies.count){ index in
                            if(!(currencies[itemSelected]==currencies[index])){
                                Text(self.currencies[index]).tag(index)
                            }
                        }
                    }
                }
                Section(header: Text("Conversetion")){
                    Text("\(convert(amount)) \(currencies[itemSelected2])")
                        
                }
            }
        }
    }
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
