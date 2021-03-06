//
/// Copyright (c) 2019 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import Foundation
import SwiftUI
import Combine

let minCellSize = CGSize(width: 200, height: 100)

struct Cell: Identifiable, Equatable {
  var id = UUID()
  var color = Color.black
  var size = minCellSize
  var offset = CGSize.zero
  var shapeType = ShapeType.roundedRect
  var text = "Default cell text"
}

class CellData: ObservableObject {
  @Published var selectedCell: Cell?
  
  @Published var cells: [Cell] = [
    Cell(color: .red,
         text: "Drawing in SwiftUI"),
    Cell(color: .green,
         offset: CGSize(width: 100, height: 300),
         text: "Shapes")
  ]
  
  func indexOf(cell: Cell) -> Int {
    guard let index = cells.firstIndex(where: {
      $0.id == cell.id
    }) else {
      fatalError("Cell \(cell) does not exist")
    }
    return index
  }
  
  func addCell(offset: CGSize) -> Cell {
    let cell = Cell(offset: offset)
    cells.append(cell)
    return cell
  }
}
