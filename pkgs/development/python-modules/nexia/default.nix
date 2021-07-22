{ lib
, buildPythonPackage
, fetchFromGitHub
, pytestCheckHook
, pythonOlder
, requests
, requests-mock
}:

buildPythonPackage rec {
  pname = "nexia";
  version = "0.9.10";
  disabled = pythonOlder "3.5";

  src = fetchFromGitHub {
    owner = "bdraco";
    repo = pname;
    rev = version;
    sha256 = "sha256-Ka75JxPlsivQ5oqEuGVTpc+Ppb7V7arLVTpcNYiIJ00=";
  };

  propagatedBuildInputs = [
    requests
  ];

  checkInputs = [
    requests-mock
    pytestCheckHook
  ];

  postPatch = ''
    substituteInPlace setup.py --replace '"pytest-runner",' ""
  '';

  pythonImportsCheck = [ "nexia" ];

  meta = with lib; {
    description = "Python module for Nexia thermostats";
    homepage = "https://github.com/bdraco/nexia";
    license = with licenses; [ asl20 ];
    maintainers = with maintainers; [ fab ];
  };
}
