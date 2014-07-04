#t/plugin/example-00.t
# testing Ado example plugin
use Mojo::Base -strict;
use File::Basename;
use File::Spec::Functions qw(catdir updir catfile);
use Cwd qw(abs_path);
use Test::More;

BEGIN {
    $ENV{MOJO_HOME} = abs_path(catdir(dirname(__FILE__), updir, 'ado'));
}
use lib("$ENV{MOJO_HOME}/lib");
use Test::Mojo;
my $t   = Test::Mojo->new('Ado');
my $app = $t->app;

my $plugin = $app->plugin('example', {lelemale => 1});

ok($ENV{MOJO_HOME},               'MOJO_HOME is ' . $ENV{MOJO_HOME});
ok($app->home eq $ENV{MOJO_HOME}, '$app->home eq $ENV{MOJO_HOME}');
ok($app->plugins->namespaces->[-1] eq 'Ado::Plugin',
    '$app->plugins->namespaces->[-1]: ' . $app->plugins->namespaces->[-1]);
is_deeply(
    $plugin->config,
    {   "a"        => 1,
        "bla"      => "off",
        "err"      => 1,
        "lelemale" => 1
    },
    'All plugin configs are merged right!'
);
done_testing;