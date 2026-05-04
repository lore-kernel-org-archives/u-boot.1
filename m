Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFE62FF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 13:20:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90AA88467E;
	Mon,  4 May 2026 15:20:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="lgD7KAro";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D820E84255; Mon,  4 May 2026 15:20:46 +0200 (CEST)
Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::8fab])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6D6684659
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 15:20:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246b])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4g8Mhr3dv8zdRY;
 Mon,  4 May 2026 15:20:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1777900844;
 bh=L1UHkRTaGPps6p7I+arPUZJjR7u7sAqOzzbNKrMrKD4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=lgD7KAromSiZQmKwZp80VTwgXCMRnhso5Ey3KtmcmjG3M07NklwW+zmW+YpoxwfuG
 LOhD1VRHuDdK0IUP1I0CaeYP31tlPKf1+3/OH3m9zzDUjhNn0XynJvNCSORDms8WYj
 M/atlt+nwuIk9myW5BTx68DXLdYrTe7HFpO6hE/ZqdrElZ0Z+lOai+nP2O7NOM02SI
 kBjM+GTl1jCOwoH+6bkrVmkzHJo48iy2MVKN1yGCLW0goB48ajxBl7zVbkyTrpGuMW
 pJFxI4P77M2m+32AzRz5YD7BLmwuf2Qevp/h3eg9SmiSOTZMEzSI23YrIZNgzAY/u0
 PBnWvAoDW+M0A==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4g8Mhq20pDzCQl; Mon,  4 May 2026 15:20:43 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Mon, 04 May 2026 15:20:28 +0200
Subject: [PATCH RFC next 01/18] test/py: add pytest --make-args argument
 for additional Make arguments
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-extrawarn-sync-v1-1-b19301d1948a@cherry.de>
References: <20260504-extrawarn-sync-v1-0-b19301d1948a@cherry.de>
In-Reply-To: <20260504-extrawarn-sync-v1-0-b19301d1948a@cherry.de>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <simon.glass@canonical.com>, 
 Raymond Mao <raymondmaoca@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, Yao Zi <me@ziyao.cc>, 
 Rasmus Villemoes <ravi@prevas.dk>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15-dev-47773
X-Infomaniak-Routing: alpha
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Quentin Schulz <quentin.schulz@cherry.de>

We manually execute make commands within some tests, sometimes from
"dirty" build directories.

One example is the test_env_initial_env_file test which calls
make u-boot-initial-env
in a build directory that has already been populated possibly before
pytest is run (which is the case in our GitLab CI/CD).

In "sandbox with clang test.py" and "sandbox64 with clang test.py" we
build before pytest with clang-20 but pytest will call make without
setting HOSTCC or CC to clang-20, which results in clang flags being
used with gcc. Right now, it isn't triggering a build issue because we
use cc-disable-warning to disable the warning only if it's available, so
the clang flags aren't added. However, in a few commits we'll bump
scripts/Makefile.extrawarn to a newer version from the Linux kernel
(6.1) and it won't be used anymore, thus triggering fails.

Add an option to specify make arguments such that a user can provide
HOSTCC and CC for when the build directory to reuse has been built with
clang.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 test/py/conftest.py                 | 6 ++++--
 test/py/tests/test_cleanup_build.py | 4 ++--
 test/py/tests/test_env.py           | 4 ++--
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/test/py/conftest.py b/test/py/conftest.py
index 215aaa56534..a26aaee7b2f 100644
--- a/test/py/conftest.py
+++ b/test/py/conftest.py
@@ -95,6 +95,8 @@ def pytest_addoption(parser):
         help="Assume that U-Boot is ready and don't wait for a prompt")
     parser.addoption('--timing', default=False, action='store_true',
                      help='Show info on test timing')
+    parser.addoption('--make-args', action='append', default=[],
+                     help='Provide arguments to pass to the "make" command, e.g. HOSTCC=clang-20')
 
 
 def run_build(config, source_dir, build_dir, board_type, log):
@@ -120,8 +122,8 @@ def run_build(config, source_dir, build_dir, board_type, log):
         else:
             o_opt = ''
         cmds = (
-            ['make', o_opt, '-s', board_type + '_defconfig'],
-            ['make', o_opt, '-s', '-j{}'.format(os.cpu_count())],
+            ['make', *config.getoption('make_args'), o_opt, '-s', board_type + '_defconfig'],
+            ['make', *config.getoption('make_args'), o_opt, '-s', '-j{}'.format(os.cpu_count())],
         )
         name = 'make'
 
diff --git a/test/py/tests/test_cleanup_build.py b/test/py/tests/test_cleanup_build.py
index aca90cb1107..10568a68ef5 100644
--- a/test/py/tests/test_cleanup_build.py
+++ b/test/py/tests/test_cleanup_build.py
@@ -32,12 +32,12 @@ def tmp_copy_of_builddir(u_boot_config, tmp_path):
 
 
 @pytest.fixture(scope="module")
-def run_make(u_boot_log):
+def run_make(pytestconfig, u_boot_log):
     """Provide function to run and log make without connecting to u-boot console."""
     runner = u_boot_log.get_runner("make", sys.stdout)
 
     def _run_make(build_dir, target):
-        cmd = ["make", f"O={build_dir}", target]
+        cmd = ["make", *pytestconfig.getoption("make_args"), f"O={build_dir}", target]
         runner.run(cmd)
 
     yield _run_make
diff --git a/test/py/tests/test_env.py b/test/py/tests/test_env.py
index f8713a59ba9..0e52c5d2a13 100644
--- a/test/py/tests/test_env.py
+++ b/test/py/tests/test_env.py
@@ -175,7 +175,7 @@ def validate_set(state_test_env, var, value):
     assert response == ('%s=%s' % (var, value))
 
 @pytest.mark.boardspec('sandbox')
-def test_env_initial_env_file(ubman):
+def test_env_initial_env_file(pytestconfig, ubman):
     """Test that the u-boot-initial-env make target works"""
     builddir = 'O=' + ubman.config.build_dir
     envfile = ubman.config.build_dir + '/u-boot-initial-env'
@@ -186,7 +186,7 @@ def test_env_initial_env_file(ubman):
     except:
         pass
 
-    utils.run_and_log(ubman, ['make', builddir, 'u-boot-initial-env'])
+    utils.run_and_log(ubman, ['make', *pytestconfig.getoption('make_args'), builddir, 'u-boot-initial-env'])
 
     assert os.path.exists(envfile)
 

-- 
2.54.0

