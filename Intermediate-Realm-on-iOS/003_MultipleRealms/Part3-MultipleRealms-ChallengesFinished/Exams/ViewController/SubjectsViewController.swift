/**
 * Copyright (c) 2017 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit
import RealmSwift

class SubjectsViewController: UITableViewController {

  private var subjects: Results<SubjectName>!

  override func viewDidLoad() {
    let mainRealm = try! Realm(configuration: RealmConfig.main.configuration)
    let examNames = Array(mainRealm.objects(Exam.self)
      .map { $0.name })

    let staticRealm = try! Realm(configuration: RealmConfig.static.configuration)
    subjects = staticRealm.objects(SubjectName.self)
      .filter("NOT name IN %@", examNames)
      .sorted(byKeyPath: "name")
  }

  // MARK: - table data source

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return subjects?.count ?? 0
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let subject = subjects![indexPath.row]

      let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
      cell.textLabel!.text = subject.name
      return cell
  }

  // MARK: - table delegate

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let subject = subjects?[indexPath.row] else {
      return
    }

    let realm = try! Realm(configuration: RealmConfig.main.configuration)
    let exam = Exam(subject.name, date: Date(timeIntervalSinceNow: 7 * 24 * 60 * 60))

    try! realm.write {
      realm.add(exam)
    }

    navigationController!.popViewController(animated: true)
  }
}
