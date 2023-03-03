//
//  WelcomeViewController.swift
//  Notes
//
//  Created by Никита Ананьев on 01.03.2023.
//

import UIKit
import SnapKit

class WelcomeViewController: UIViewController {
    var mode = 0
    //MARK: Views
    
    // TODO: Add custom buttom layer
    lazy var nextButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = .green
        button.setTitle("Круто! Что дальше?", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 30)
        return button
    }()
    
    //MARK: First state
    lazy var greetLabel: UILabel = {
        let label = UILabel()
        label.text = "Встречайте!"
        label.font = .systemFont(ofSize: 38)
        label.layer.opacity = 0
        return label
    }()
    lazy var notesLabel: UILabel = {
        let label = UILabel()
        label.text = "Notes"
        label.font = .boldSystemFont(ofSize: 54)
        label.layer.opacity = 0
        return label
    }()
    
    //MARK: Secondstate
    
    lazy var addingLabel: UILabel = {
        let label = UILabel()
        label.text = "Добавляйте свои заметки"
        label.font = .systemFont(ofSize: 38)
        label.layer.opacity = 0
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    lazy var editingLabel: UILabel = {
        let label = UILabel()
        label.text = "Редактируйте"
        label.font = .systemFont(ofSize: 38)
        label.layer.opacity = 0
        return label
    }()
    lazy var deletingLabel: UILabel = {
        let label = UILabel()
        label.text = "Удаляйте"
        label.font = .systemFont(ofSize: 38)
        label.layer.opacity = 0
        return label
    }()
    lazy var excuseMeLabel: UILabel = {
        let label = UILabel()
        label.text = "Пока функционала мало, но мы только начали ;)"
        label.font = .systemFont(ofSize: 38)
        label.layer.opacity = 0
        label.numberOfLines = 0
        label.textAlignment = .center
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        nextButton.addTarget(self, action: #selector(hitButton), for: .touchUpInside)
        
    }
    @objc func hitButton() {
        mode += 1
        view.setNeedsLayout()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    override func viewWillLayoutSubviews() {
        switch mode {
        case 0:
            setupWelcomeLabels()
            setupNextButton()
            animateOpacity(view: greetLabel, delay: 1)
            animateOpacity(view: notesLabel, delay: 2)
            animateOpacity(view: nextButton, delay: 3)
        case 1:
            setupSecondLabels()
            animateOpacity(view: addingLabel, delay: 1)
            animateOpacity(view: editingLabel, delay: 2)
            animateOpacity(view: deletingLabel, delay: 3)
            animateOpacity(view: excuseMeLabel, delay: 4)
        default:
            let vc = ViewController()
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .partialCurl
            present(vc, animated: true)
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    
    private func setupNextButton() {
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.bottom.equalTo(view).offset(-200)
            make.centerX.equalTo(view)
        }
        nextButton.layer.opacity = 0
    }
    private func setupWelcomeLabels() {
        view.addSubview(greetLabel)
        greetLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalToSuperview().offset(120)
        }
        view.addSubview(notesLabel)
        notesLabel.snp.makeConstraints { make in
            make.top.equalTo(greetLabel.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
        }
    }
    private func setupSecondLabels() {
        greetLabel.removeFromSuperview()
        notesLabel.removeFromSuperview()
        
        let stackView = UIStackView()
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 50
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(120)
            make.left.right.equalToSuperview()
        }
        stackView.addArrangedSubview(addingLabel)
        stackView.addArrangedSubview(editingLabel)
        stackView.addArrangedSubview(deletingLabel)
        stackView.addArrangedSubview(excuseMeLabel)
    }
    
    private func animateOpacity(view: UIView, delay: Double) {
        DispatchQueue.main.async { [weak view] in
            
            UIView.animate(withDuration: 3, delay: delay) {
                view?.layer.opacity = 1
            }
        }
    }
    
    deinit {
        print("Deinited")
    }
}

fileprivate enum ViewTransition {
    case first, second, transit
}

