class Depview < Formula
  desc "Show Swift package dependency trees for packages and Xcode projects"
  homepage "https://github.com/ninikurshavishvili/depview"
  url "https://github.com/ninikurshavishvili/depview/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "09ee904f774d5e6b51c45d220731c91c27881bdf7f6d3b22a9bc3673d52bc23a"
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
