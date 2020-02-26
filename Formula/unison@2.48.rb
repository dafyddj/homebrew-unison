class UnisonAT248 < Formula
  desc "File synchronization tool for OSX"
  homepage "https://www.cis.upenn.edu/~bcpierce/unison/"
  url "https://github.com/bcpierce00/unison/archive/v2.48.15v4.tar.gz"
  version "2.48.15"
  sha256 "f8c7e982634bbe1ed6510fe5b36b6c5c55c06caefddafdd9edc08812305fdeec"

  bottle do
    cellar :any_skip_relocation
    sha256 "eb01217a48646b393a4769bdc25e1e947667816a38de9003211ac0342b8ec611" => :high_sierra
    sha256 "f9a68dceab3225aecf77c698a6db9f6aacd4f3795a63c2abc4c4cffdb0a13af5" => :sierra
    sha256 "74a22e776363cdc5a6d849c77e92d08747cc97b8f48a579ccae909eb8eccdcfc" => :el_capitan
  end

  depends_on "ocaml" => :build

  patch do
    url "https://github.com/bcpierce00/unison/commit/23fa129254a3304902739fc989950cc747d1e0b3.diff?full_index=1"
    sha256 "ad6b28dc2fe1c6c99863079c7e96b12452aa05c05ed010b6c551e32244ce76f2"
  end

  def install
    ENV.deparallelize
    ENV.delete "CFLAGS" # ocamlopt reads CFLAGS but doesn't understand common options
    ENV.delete "NAME" # https://github.com/Homebrew/homebrew/issues/28642
    system "make", "src/mkProjectInfo"
    system "make", "UISTYLE=text"
    bin.install "src/unison"
    prefix.install_metafiles "src"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/unison -version")
  end
end
