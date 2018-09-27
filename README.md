# Autoencoder
A deep autoencoder network for automatic time-series segmentaiton. Implemented in Julia 0.6.4 from the <a href="https://arxiv.org/pdf/1801.05394.pdf">2018 paper by Wei-Han Lee</a> using <a href="https://github.com/malmaud/TensorFlow.jl">TensorFlow.jl</a> and trained on the <a href="https://archive.ics.uci.edu/ml/datasets/EEG+Eye+State">UCI EEG Eye State Dataset</a>.

![Detected Breakpoints in final model](https://github.com/ringohoffman/Autoencoder/blob/master/checkpoints/detectedBP.png)
