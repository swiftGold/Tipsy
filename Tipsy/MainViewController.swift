//
//  MainViewController.swift
//  Tipsy
//
//  Created by Сергей Золотухин on 14.02.2023.
//

import UIKit

final class MainViewController: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.textAlignment = .left
        label.text = "Enter bill total"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var billTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.keyboardType = .numberPad
        textField.textAlignment = .center
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 10
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let selectTipLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.textAlignment = .left
        label.text = "Select tip"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var zeroPercentButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("0%", for: .normal)
        button.setTitleColor(.green, for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        button.tag = 0
        return button
    }()
    
    private lazy var tenPercentButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("10%", for: .normal)
        button.setTitleColor(.green, for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        button.tag = 10
        return button
    }()
    
    private lazy var twentyPercentButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("20%", for: .normal)
        button.setTitleColor(.green, for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        button.tag = 20
        return button
    }()
    
    private let percentButtonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let chooseSplitLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.textAlignment = .left
        label.text = "Choose split"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stepperLabel: UILabel = {
        let label = UILabel()
        label.textColor = .green
        label.textAlignment = .center
        label.text = "2"
        label.font = UIFont.boldSystemFont(ofSize: 36)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var stepper: UIStepper = {
        let stepper = UIStepper()
        stepper.minimumValue = 2
        stepper.maximumValue = 50
        stepper.value = 1
        stepper.addTarget(self, action: #selector(stepperDidTap), for: .valueChanged)
        stepper.translatesAutoresizingMaskIntoConstraints = false
        return stepper
    }()
    
    private let stepperStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var calculateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Calculate", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(calculateButtonTapped), for: .touchUpInside)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        button.backgroundColor = UIColor.green
        return button
    }()
    
    private var percentValue = 0
    private var splitValue = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
    
    @objc
    private func buttonTapped(_ sender: UIButton) {
        chooseButtonsBAckColor(sender)
        percentValue = sender.tag
    }
    
    @objc
    private func stepperDidTap(_ sender: UIStepper) {
        stepperLabel.text = String(Int(sender.value))
        splitValue = Int(sender.value)
    }
    
    @objc
    private func calculateButtonTapped() {
        if billTextField.text != "" {
            let viewModel = ResultViewModel(finalSum: calculate(), tipPercent: percentValue, split: splitValue)
            let viewController = ResultViewController()
            viewController.modalPresentationStyle = .fullScreen
            viewController.setupResultViewController(viewModel)
            present(viewController, animated: false)
        } else {
            titleLabel.textColor = .red
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                self?.titleLabel.textColor = .darkGray
            }
        }
    }
}

extension MainViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        let allowedCharacters = ".,+1234567890"
//        let allowedCharacterSet = CharacterSet(charactersIn: allowedCharacters)
//        let typeCharacterSet = CharacterSet(charactersIn: string)
//        return allowedCharacterSet.isSuperset(of: typeCharacterSet)
        isValidNumber(str: string)
    }
}

func isValidNumber(str:String) -> Bool{
    if str.isEmpty {
            return false
        }
        let newChar = NSCharacterSet(charactersIn: str)
        let boolValid = NSCharacterSet.decimalDigits.isSuperset(of: newChar as CharacterSet)
        if boolValid{
            return true
        }else{
            let lst = str.components(separatedBy: ".")
            let newStr = lst.joined(separator: "")
            let currentChar = NSCharacterSet(charactersIn: newStr)
            if lst.count == 2 && !lst.contains("") && NSCharacterSet.decimalDigits.isSuperset(of: currentChar as CharacterSet){
                return true
            }
            return false
        }
}

private extension MainViewController {
    func calculate() -> String {
        guard let stringBillValue = billTextField.text else { fatalError() }
        guard let billValue = Double(stringBillValue) else { fatalError() }
        guard let percent = Double("1.\(percentValue)") else { fatalError() }
        let result = billValue * percent / Double(splitValue)
        let finalSum = String(format: "%0.2f", result)
        return finalSum
    }
    
    func chooseButtonsBAckColor(_ sender: UIButton) {
        zeroPercentButton.backgroundColor = .clear
        tenPercentButton.backgroundColor = .clear
        twentyPercentButton.backgroundColor = .clear
        sender.backgroundColor = UIColor.gray
    }

    func setupViewController() {
        view.backgroundColor = .systemMint
        addSubviews()
        setConstraints()
    }
    
    func addSubviews() {
        percentButtonsStackView.addArrangedSubview(zeroPercentButton)
        percentButtonsStackView.addArrangedSubview(tenPercentButton)
        percentButtonsStackView.addArrangedSubview(twentyPercentButton)
        
        stepperStackView.addArrangedSubview(stepperLabel)
        stepperStackView.addArrangedSubview(stepper)
        
        mainStackView.addArrangedSubview(titleLabel)
        mainStackView.addArrangedSubview(billTextField)
        mainStackView.addArrangedSubview(selectTipLabel)
        mainStackView.addArrangedSubview(percentButtonsStackView)
        mainStackView.addArrangedSubview(chooseSplitLabel)
        mainStackView.addArrangedSubview(stepperStackView)

        view.addSubview(mainStackView)
        view.addSubview(calculateButton)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainStackView.heightAnchor.constraint(equalToConstant: 350),
            
            calculateButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            calculateButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            calculateButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            calculateButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

