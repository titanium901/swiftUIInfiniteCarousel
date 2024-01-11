//
//  Main.swift
//  SwiftUI Infinite Carousel
//
//  Created by Popov Yuriy on 09.01.2024.
//

import SwiftUI

struct Main: View {
    @State private var currentPage: String = ""
    @State private var listOfPages: [Page] = []
    @State private var fakedPages: [Page] = []
    var body: some View {
        GeometryReader {
            let size = $0.size

            TabView(selection: $currentPage, content: {
                ForEach(fakedPages) { page in
                    RoundedRectangle(cornerSize: CGSize(width: 25, height: 30), style: .continuous)
                        .fill(page.color.gradient)
                        .frame(width: size.height - 60, height: size.height)
                        .tag(page.id.uuidString)
                        .offsetX(currentPage == page.id.uuidString) { rect in
                            let minX = rect.minX
                            let pageOffset = minX - (size.width * CGFloat(fakeIndex(page)))

                            let pageProgress = pageOffset / size.width

                            if -pageProgress < 1.0 {
                                if fakedPages.indices.contains(fakedPages.count - 1) {
                                    currentPage = fakedPages[fakedPages.count - 1].id.uuidString
                                }
                            }

                            if -pageProgress > CGFloat(fakedPages.count - 1) {
                                if fakedPages.indices.contains(1) {
                                    currentPage = fakedPages[1].id.uuidString
                                }
                            }
                        }
                }
            })
            .tabViewStyle(.page(indexDisplayMode: .never))
            .overlay(alignment: .bottom) {
                PageControl(totalPages: listOfPages.count, currentPage: originalIndex(currentPage))
                    .offset(y: -15)
            }
        }
        .frame(height: 400)
        .onAppear {
            guard fakedPages.isEmpty else { return }
            for color in [Color.red, Color.blue, Color.yellow, Color.black, Color.brown] {
                listOfPages.append(.init(color: color))
            }

            fakedPages.append(contentsOf: listOfPages)

            if var firstPage = listOfPages.first, var lastPage = listOfPages.last {
                currentPage = firstPage.id.uuidString
                
                firstPage.id = .init()
                lastPage.id = .init()

                fakedPages.append(firstPage)
                fakedPages.insert(lastPage, at: 0)
            }
        }
    }

    func fakeIndex(_ of: Page) -> Int {
        fakedPages.firstIndex(of: of) ?? 0
    }

    func originalIndex(_ id: String) -> Int {
        listOfPages.firstIndex { page in
            page.id.uuidString == id
        } ?? 0
    }
}

#Preview {
    Main()
}
