{
  authentik-src,
  authentik-go,
  openapi-generator-cli,
  runCommand,
}:

runCommand "go-client-code" {
  nativeBuildInputs = [
    openapi-generator-cli
  ];
} ''
  cp --no-preserve=mode -vr ${authentik-go}/ $out/
  cp -vr ${authentik-src}/schema.yml $out/
  pushd $out &>/dev/null
    substituteInPlace config.yaml \
      --replace-fail "templateDir: /local/templates/" "templateDir: ./templates/"
    openapi-generator-cli generate -i schema.yml -g go -o . -c config.yaml
  popd &>/dev/null
''
