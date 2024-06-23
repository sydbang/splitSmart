//
//  AddExpenseView.swift
//  SplitSmart
//
//  Created by Sunghee Bang on 2024-06-22.
//

import SwiftUI
import SwiftData

struct AddExpenseView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Group.id, order: .reverse) private var groups: [Group]
    @Query(sort: \Person.id, order: .reverse) private var person: [Person]
    
    @Binding var selectedTab: Constants.Tab
    @State private var detail: String = ""
    @State private var amount: Double?
    @State private var withGroup: [Group] = []
    @State private var withWhom: [Person] = []
    
    private let numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        return numberFormatter
    }() // TODO: This should go to ViewModel
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    selectedTab = .activities
                }, label: {
                    Text("X")
                })
                Spacer()
                Text("add an expense")
                Spacer()
                Button(action: {
                    //TODO: disable this button until all data required has been entered
                    //TODO: actual save the data to db
                }, label: {
                    Text("Save")
                })
            }
            HStack{
                AddExpenseWithView(withGroup: $withGroup, withWhom: $withWhom)
                Spacer()
                Button(action: {
                    // TODO: Go to selection and fill out withGroup and withWhom
                }, label: {
                    Text("+")
                })
            }
            TextField("Enter detail", text: $detail)
            TextField("0.00", value: $amount, formatter: numberFormatter)
                .keyboardType(.decimalPad)
            HStack {
                Text("Paid by ")
                Button {
                    //TODO: grab list of people from group
                } label: {
                    ButtonView(buttonText: "you")
                }
                Text(" and split ")
                Button {
                    //TODO: send them to options
                } label: {
                    ButtonView(buttonText: "equally")
                }
            }
        }.padding()
    }
}

#Preview {
    AddExpenseView(selectedTab: Binding.constant(Constants.Tab.addExpense))
        .modelContainer(for: [Group.self, Expense.self, ExpenseAllocation.self])
}
