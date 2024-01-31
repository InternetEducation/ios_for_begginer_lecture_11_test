//
//  TinkoffCalculatorUITests.swift
//  TinkoffCalculatorUITests
//

import XCTest

class TinkoffCalculatorUITests: XCTestCase {

    let navigationButtonTitle = "toHistoryPageButton"

    override func setUp() {
        continueAfterFailure = false
    }

    override func tearDown() {
    }

    func test_lecture11_calculations() {
        let buttons = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "C", "x", "/", "+", "-", navigationButtonTitle]

        let app = XCUIApplication()
        app.launch()

        buttons.forEach {
            let button = app.buttons[$0]

            XCTAssertTrue(button.exists, "Не нашлась кнопка \($0).")
            XCTAssertTrue(button.isHittable, "Кнопка \($0) не нажимается.")
        }

        validateHistoryLabel(expectedVlaue: "NoData", in: app)

        app.buttons["2"].tap()
        app.buttons["7"].tap()
        app.buttons["+"].tap()
        app.buttons["3"].tap()
        app.buttons["="].tap()

        validateHistoryLabel(expectedVlaue: "30", in: app)

        app.buttons["-"].tap()
        app.buttons["9"].tap()
        app.buttons["7"].tap()
        app.buttons["="].tap()

        validateHistoryLabel(expectedVlaue: "-67", in: app)

        app.buttons["/"].tap()
        app.buttons["2"].tap()
        app.buttons["="].tap()

        validateHistoryLabel(expectedVlaue: "-33,5", in: app)

        app.buttons["x"].tap()
        app.buttons["1"].tap()
        app.buttons["1"].tap()
        app.buttons["0"].tap()
        app.buttons["="].tap()

        validateHistoryLabel(expectedVlaue: "-3685", in: app)
    }

    func validateHistoryLabel(expectedVlaue: String, in app: XCUIApplication) {
        app.buttons[navigationButtonTitle].tap()

        if !app.staticTexts[expectedVlaue].waitForExistence(timeout: 0.5) {
            XCTFail("Не найден лейбл вывода решения со значением: \(expectedVlaue)")
        }

        app.buttons.firstMatch.tap()
    }
}
