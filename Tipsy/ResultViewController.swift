//
//  ResultViewController.swift
//  Tipsy
//
//  Created by Сергей Золотухин on 14.02.2023.
//

import UIKit

final class ResultViewController: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.textAlignment = .center
        label.text = "Total per person"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.textAlignment = .center
        label.text = ""
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let commentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.textAlignment = .center
        label.text = ""
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var recalculateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Recalculate", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(recalculateButtonTapped), for: .touchUpInside)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        button.backgroundColor = UIColor.green
        return button
    }()
    
    func setupResultViewController(_ model: ResultViewModel) {
        valueLabel.text = model.finalSum
        commentLabel.text = "Split between \(model.split) people, with \(model.tipPercent)% tip"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
    
    @objc
    private func recalculateButtonTapped() {
        dismiss(animated: false)
    }
}

private extension ResultViewController {
    func routeToResult() {
        let viewController = ResultViewController()
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: false)
    }
    
    func setupViewController() {
        view.backgroundColor = .systemMint
        addSubviews()
        setConstraints()
    }
    
    func addSubviews() {
        
        mainStackView.addArrangedSubview(titleLabel)
        mainStackView.addArrangedSubview(valueLabel)
        mainStackView.addArrangedSubview(commentLabel)
        
        view.addSubview(mainStackView)
        view.addSubview(recalculateButton)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainStackView.heightAnchor.constraint(equalToConstant: 350),
            
            recalculateButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            recalculateButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            recalculateButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            recalculateButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
