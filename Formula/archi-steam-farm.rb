class ArchiSteamFarm < Formula
  desc "ASF is a C# application that allows you to farm steam cards"
  homepage "https://github.com/JustArchi/ArchiSteamFarm"
  url "https://github.com/JustArchi/ArchiSteamFarm/releases/download/2.1.6.8/ASF.zip"
  version "2.1.6.8"
  sha256 "c0e7f4efdbaa51acb3b64ad0c41383de752dda26db5ad990761ff088d80544c7"

  bottle do
    cellar :any_skip_relocation
    sha256 "b0bffa6963171f4a360297168ec01593628b6ab1750ee115b76e28ea27238f8a" => :sierra
    sha256 "b0bffa6963171f4a360297168ec01593628b6ab1750ee115b76e28ea27238f8a" => :el_capitan
    sha256 "b0bffa6963171f4a360297168ec01593628b6ab1750ee115b76e28ea27238f8a" => :yosemite
  end

  depends_on "mono"

  def install
    libexec.install "ASF.exe"
    (bin/"asf").write <<-EOS.undent
      #!/bin/bash
      mono #{libexec}/ASF.exe "$@"
    EOS

    etc.install "config" => "asf"
    libexec.install_symlink etc/"asf" => "config"
  end

  def caveats; <<-EOS.undent
    Config: #{etc}/asf/
    EOS
  end

  test do
    assert_match "ASF V#{version}", shell_output("#{bin}/asf --client")
  end
end
