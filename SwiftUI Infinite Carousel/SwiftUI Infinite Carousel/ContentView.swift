//
//  ContentView.swift
//  SwiftUI Infinite Carousel
//
//  Created by Popov Yuriy on 09.01.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            Main()
                .navigationTitle("Infinite Carousel")
        }
    }
}

#Preview {
    ContentView()
}
