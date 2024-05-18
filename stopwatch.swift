import UIKit

class ViewController: UIViewController {
    
    var timer = Timer()
    var isTimerRunning = false
    var counter: Double = 0.0
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00.0"
        label.font = UIFont.systemFont(ofSize: 40)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let startStopButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Start", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let resetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Reset", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(timeLabel)
        view.addSubview(startStopButton)
        view.addSubview(resetButton)
        
        setupLayout()
        
        startStopButton.addTarget(self, action: #selector(startStopTapped), for: .touchUpInside)
        resetButton.addTarget(self, action: #selector(resetTapped), for: .touchUpInside)
    }
    
    func setupLayout() {
        timeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        timeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        startStopButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        startStopButton.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 20).isActive = true
        
        resetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        resetButton.topAnchor.constraint(equalTo: startStopButton.bottomAnchor, constant: 20).isActive = true
    }
    
    @objc func startStopTapped() {
        if isTimerRunning {
            timer.invalidate()
            startStopButton.setTitle("Start", for: .normal)
        } else {
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            startStopButton.setTitle("Stop", for: .normal)
        }
        isTimerRunning.toggle()
    }
    
    @objc func resetTapped() {
        timer.invalidate()
        isTimerRunning = false
        counter = 0.0
        timeLabel.text = "00:00.0"
        startStopButton.setTitle("Start", for: .normal)
    }
    
    @objc func updateTimer() {
        counter += 0.1
        timeLabel.text = formatTime(counter)
    }
    
    func formatTime(_ interval: Double) -> String {
        let minutes = Int(interval) / 60
        let seconds = interval.truncatingRemainder(dividingBy: 60)
        return String(format: "%02d:%04.1f", minutes, seconds)
    }
}
