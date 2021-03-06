//
//  AddView.swift
//  iExpense
//
//  Created by Nestor Trillo on 3/23/21.
//

//	LIBRARIES
import SwiftUI

struct AddView: View {
	//	LOCAL VARS
	@Environment(\.presentationMode) var presentationMode
	@ObservedObject var expenses: Expenses

	@State private var name = ""
	@State private var type = "Personal"
	@State private var amount = ""
	
	static let types = ["Business", "Personal"]

	var body: some View {
		NavigationView {
			Form {
				TextField("Name", text: $name)
				Picker("Type", selection: $type) {
					ForEach(Self.types, id: \.self) {
						Text($0)
					}
				}
				TextField("Amount", text: $amount)
					.keyboardType(.numberPad)
			}
			.navigationBarTitle("Add new expense")
			.navigationBarItems(trailing: Button("Save") {
				if let actualAmount = Int(self.amount) {
					let item = ExpenseItem(id: UUID(), name: self.name, type: self.type, amount: actualAmount)
					self.expenses.items.append(item)
					self.presentationMode.wrappedValue.dismiss()
				}
			})
		}
	}
	//	FUNCTIONS
}

//	PREVIEW
struct AddView_Previews: PreviewProvider {
	static var previews: some View {
		AddView(expenses: Expenses())
	}
}
