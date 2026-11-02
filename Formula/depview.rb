class Depview < Formula
  desc "Show Swift package dependency trees for packages and Xcode projects"
  homepage "https://github.com/ninikurshavishvili/depview"
  url "https://github.com/ninikurshavishvili/depview/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "24f7085a20fd757e1a1e602793832857f3c0542a81e7cffa3c25f16069729683"
  license "MIT"

  # swift-tools-version 6.0 needs Xcode 16; depview itself needs macOS 13.
  depends_on xcode: ["16.0", :build]
  depends_on macos: :ventura

  def install
    system "swift", "build", "--disable-sandbox", "--configuration", "release", "--product", "depview"
    bin.install ".build/release/depview"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/depview --version")
    # An empty folder is a user error: exit code 1 and a message with a hint.
    output = shell_output("#{bin}/depview tree #{testpath} 2>&1", 1)
    assert_match "No Package.swift or Xcode project", output
  end
end
