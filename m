Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD80EC0218C
	for <u-boot@archiver.kernel.org>; Sat, 25 Jan 2025 21:32:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3A6080836;
	Sat, 25 Jan 2025 22:32:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YSW8L0WL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75E7B80EB5; Sat, 25 Jan 2025 22:32:23 +0100 (CET)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DB40807FE
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 22:32:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-844d7f81dd1so94747339f.2
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 13:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737840737; x=1738445537; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Om0VokitbdLSJTK3qnhmuDIFQGogPNYu8EKzfiyTkvY=;
 b=YSW8L0WLGqsWox8WfHaX1wptmhMFa1mJDuhSUpSS+b7peAWJlgZ4MHSjGZ7axW0cru
 JIxJR9uJXLzmtEJeaUFMNFYQZ63rAwcjJdzMlsj4EHsmNYkzw6xruQAY8AypbcgxJAgA
 AN8sr9u7DZ2ovXltslzujoP8QNjmw2QEoQiUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737840737; x=1738445537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Om0VokitbdLSJTK3qnhmuDIFQGogPNYu8EKzfiyTkvY=;
 b=bcthjaK9c59OxEZvxAd8vj+7Bosz+n/XokZZgCo4OF25c4oFEA/ATh+sUy8KJdiO4/
 HVkerNPcpmEp4RlV/1a9R+C0HiVFk2iartEzYw35bCDvJVibv76JVkqbarnK4Ds7HgvD
 mXpKDPWp81wFpeGRPsI53E8/IXspRU/6akklKtkaUL0TTEFyf6rVFTQwqlIiZK9GhBHe
 lYo9DkuMR0XN/vqA2RrnqYcfN2bc2OzQ2GFY91Ui9RxiXLWu1lAzTW3ddJiYD14h1LiQ
 V3TFjQAO21wDGPaQXXpL7kmBkeAMJpEygqm5iZixeSsTKgZozS/YLDV2JOzRAxLEnYIS
 P38w==
X-Gm-Message-State: AOJu0Yz3sKOrSPS9fVoH35SIpSAudFOXUsFla2cmMaNtAEiSzNDpzSDy
 /H+1l+erZETC2tnx7rYr10TqGwPCFZ6VAf98iO6sj3iRDt2+ZCzuUwmKkSu0GrlTkCXjMM/fKNM
 =
X-Gm-Gg: ASbGncuCQPCJjq/jmphw6JcFvV5+jJfjfIRtV4X7lvJXY/yWJV3onA1o4bxH0B5XhoQ
 NyP2uFvh09PF0x0uFvI46qUjFxIFCIDMnpFlNxfLEoVWBWVkGp/dnBhS4CvaYliTWlgyEB9m1zy
 amX4qY/8jw3IDwGSPv4pgg64oRwPiYqSsWCljOjP2MnrJ+P7EgC86lDkgCAMRzJx/gCTChc+kQ5
 HsAreY6TNydnOgXrpvJik6bF/pGaLnvGSlorJl3Sy8YaSVi2bU4dmEtl7iXC76367Pv9CehKrrr
 YOXmvw5+YVYZ9JssCyr8zLfTqU6dZGs44KDnSQdoRg==
X-Google-Smtp-Source: AGHT+IFOv1eYMbMtjToRdLv6So5OGL1s1AnDHF55a95/MUP4Q3MI6CE5+VKy1Vuf5H01EzqHpyTeqA==
X-Received: by 2002:a05:6602:3e94:b0:843:e667:f196 with SMTP id
 ca18e2360f4ac-851b61ee917mr3576989139f.4.1737840735979; 
 Sat, 25 Jan 2025 13:32:15 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-8521e01754dsm164103539f.32.2025.01.25.13.32.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jan 2025 13:32:14 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, Love Kumar <love.kumar@amd.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>, Richard Weinberger <richard@nod.at>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH 2/4] test: Drop u_boot_ prefix on test files
Date: Sat, 25 Jan 2025 14:31:37 -0700
Message-ID: <20250125213150.1608395-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250125213150.1608395-1-sjg@chromium.org>
References: <20250125213150.1608395-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

We know this is U-Boot so the prefix serves no purpose other than to
make things longer and harder to read. Drop it and rename the files.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 doc/develop/py_testing.rst                    |  4 +-
 doc/develop/tests_writing.rst                 |  2 +-
 test/py/conftest.py                           | 52 +++++------
 ...u_boot_console_base.py => console_base.py} |  8 +-
 ...onsole_exec_attach.py => console_board.py} |  6 +-
 ..._console_sandbox.py => console_sandbox.py} |  8 +-
 test/py/{u_boot_spawn.py => spawn.py}         |  0
 test/py/tests/fit_util.py                     |  2 +-
 test/py/tests/test_android/test_ab.py         | 12 +--
 test/py/tests/test_android/test_abootimg.py   | 10 +--
 test/py/tests/test_android/test_avb.py        |  2 +-
 test/py/tests/test_dfu.py                     | 18 ++--
 test/py/tests/test_efi_fit.py                 |  2 +-
 test/py/tests/test_efi_loader.py              |  4 +-
 test/py/tests/test_env.py                     | 24 +++---
 test/py/tests/test_event_dump.py              |  2 +-
 test/py/tests/test_extension.py               |  2 +-
 test/py/tests/test_fit.py                     |  2 +-
 test/py/tests/test_fit_auto_signed.py         |  2 +-
 test/py/tests/test_fit_ecdsa.py               |  2 +-
 test/py/tests/test_fit_hashes.py              |  2 +-
 test/py/tests/test_fpga.py                    |  8 +-
 test/py/tests/test_fs/conftest.py             |  2 +-
 test/py/tests/test_gpio.py                    |  2 +-
 test/py/tests/test_gpt.py                     | 14 +--
 test/py/tests/test_kconfig.py                 |  2 +-
 test/py/tests/test_md.py                      |  6 +-
 test/py/tests/test_mmc.py                     |  8 +-
 test/py/tests/test_mmc_rd.py                  |  4 +-
 test/py/tests/test_mmc_wr.py                  |  4 +-
 test/py/tests/test_net.py                     |  6 +-
 test/py/tests/test_net_boot.py                |  4 +-
 test/py/tests/test_of_migrate.py              |  2 +-
 test/py/tests/test_ofplatdata.py              |  2 +-
 test/py/tests/test_optee_rpmb.py              |  2 +-
 test/py/tests/test_pinmux.py                  |  2 +-
 test/py/tests/test_pstore.py                  |  2 +-
 test/py/tests/test_sandbox_opts.py            |  2 +-
 test/py/tests/test_scp03.py                   |  2 +-
 test/py/tests/test_sf.py                      | 12 +--
 test/py/tests/test_source.py                  |  2 +-
 test/py/tests/test_spi.py                     | 14 +--
 test/py/tests/test_tpm2.py                    | 10 +--
 test/py/tests/test_trace.py                   |  2 +-
 test/py/tests/test_ums.py                     | 20 ++---
 test/py/tests/test_upl.py                     |  2 +-
 test/py/tests/test_usb.py                     | 12 +--
 test/py/tests/test_ut.py                      | 86 +++++++++----------
 test/py/tests/test_vbe_vpl.py                 | 10 +--
 test/py/tests/test_vboot.py                   |  2 +-
 test/py/tests/test_zynq_secure.py             | 12 +--
 test/py/tests/test_zynqmp_secure.py           |  8 +-
 test/py/{u_boot_utils.py => utils.py}         |  0
 53 files changed, 216 insertions(+), 216 deletions(-)
 rename test/py/{u_boot_console_base.py => console_base.py} (99%)
 rename test/py/{u_boot_console_exec_attach.py => console_board.py} (95%)
 rename test/py/{u_boot_console_sandbox.py => console_sandbox.py} (93%)
 rename test/py/{u_boot_spawn.py => spawn.py} (100%)
 rename test/py/{u_boot_utils.py => utils.py} (100%)

diff --git a/doc/develop/py_testing.rst b/doc/develop/py_testing.rst
index 02367355f93..1bb38eb96a3 100644
--- a/doc/develop/py_testing.rst
+++ b/doc/develop/py_testing.rst
@@ -125,7 +125,7 @@ browser, but may be read directly as plain text, perhaps with the aid of the
 If sandbox crashes (e.g. with a segfault) you will see message like this::
 
 
-    test/py/u_boot_spawn.py:171: in expect
+    test/py/spawn.py:171: in expect
         c = os.read(self.fd, 1024).decode(errors='replace')
     E   ValueError: U-Boot exited with signal 11 (Signals.SIGSEGV)
 
@@ -482,7 +482,7 @@ U-Boot console, and returns all output from that command. This allows
 validation or interpretation of the command output. This function validates
 that certain strings are not seen on the U-Boot console. These include shell
 error messages and the U-Boot sign-on message (in order to detect unexpected
-board resets). See the source of `u_boot_console_base.py` for a complete list of
+board resets). See the source of `console_base.py` for a complete list of
 "bad" strings. Some test scenarios are expected to trigger these strings. Use
 `ubpy.disable_check()` to temporarily disable checking for specific
 strings. See `test_unknown_cmd.py` for an example.
diff --git a/doc/develop/tests_writing.rst b/doc/develop/tests_writing.rst
index 73e91bf7294..d37976fc06d 100644
--- a/doc/develop/tests_writing.rst
+++ b/doc/develop/tests_writing.rst
@@ -120,7 +120,7 @@ in Python::
        """Test that md reads memory as expected, and that memory can be modified
        using the mw command."""
 
-       ram_base = u_boot_utils.find_ram_base(ubpy)
+       ram_base = utils.find_ram_base(ubpy)
        addr = '%08x' % ram_base
        val = 'a5f09876'
        expected_response = addr + ': ' + val
diff --git a/test/py/conftest.py b/test/py/conftest.py
index d70f621c2bf..5096c20ed65 100644
--- a/test/py/conftest.py
+++ b/test/py/conftest.py
@@ -7,7 +7,7 @@
 # test, at shutdown etc. These hooks perform functions such as:
 # - Parsing custom command-line options.
 # - Pullilng in user-specified board configuration.
-# - Creating the U-Boot console test fixture.
+# - Creating the ubpy test fixture.
 # - Creating the HTML log file.
 # - Monitoring each test's results.
 # - Implementing custom pytest markers.
@@ -25,12 +25,12 @@ import re
 from _pytest.runner import runtestprotocol
 import subprocess
 import sys
+from spawn import BootFail, Timeout, Unexpected, handle_exception
 import time
-from u_boot_spawn import BootFail, Timeout, Unexpected, handle_exception
 
-# Globals: The HTML log file, and the connection to the U-Boot console.
+# Globals: The HTML log file, and the top-level fixture
 log = None
-console = None
+ubpy_fix = None
 
 TEST_PY_DIR = os.path.dirname(os.path.abspath(__file__))
 
@@ -244,7 +244,7 @@ def pytest_configure(config):
             ubconfig.buildconfig.update(parser.items('root'))
 
     global log
-    global console
+    global ubpy_fix
     global ubconfig
 
     (board_type, board_type_extra, board_identity, build_dir, build_dir_extra,
@@ -339,11 +339,11 @@ def pytest_configure(config):
         os.environ['U_BOOT_' + v.upper()] = getattr(ubconfig, v)
 
     if board_type.startswith('sandbox'):
-        import u_boot_console_sandbox
-        console = u_boot_console_sandbox.ConsoleSandbox(log, ubconfig)
+        import console_sandbox
+        ubpy_fix = console_sandbox.ConsoleSandbox(log, ubconfig)
     else:
-        import u_boot_console_exec_attach
-        console = u_boot_console_exec_attach.ConsoleExecAttach(log, ubconfig)
+        import console_board
+        ubpy_fix = console_board.ConsoleExecAttach(log, ubconfig)
 
 
 def generate_ut_subtest(metafunc, fixture_name, sym_path):
@@ -362,7 +362,7 @@ def generate_ut_subtest(metafunc, fixture_name, sym_path):
     Returns:
         Nothing.
     """
-    fn = console.config.build_dir + sym_path
+    fn = ubpy_fix.config.build_dir + sym_path
     try:
         with open(fn, 'rt') as f:
             lines = f.readlines()
@@ -403,8 +403,8 @@ def generate_config(metafunc, fixture_name):
     """
 
     subconfigs = {
-        'brd': console.config.brd,
-        'env': console.config.env,
+        'brd': ubpy_fix.config.brd,
+        'env': ubpy_fix.config.env,
     }
     parts = fixture_name.split('__')
     if len(parts) < 2:
@@ -466,7 +466,7 @@ def u_boot_log(request):
          The fixture value.
      """
 
-     return console.log
+     return ubpy_fix.log
 
 @pytest.fixture(scope='session')
 def u_boot_config(request):
@@ -479,7 +479,7 @@ def u_boot_config(request):
          The fixture value.
      """
 
-     return console.config
+     return ubpy_fix.config
 
 @pytest.fixture(scope='function')
 def ubpy(request):
@@ -495,18 +495,18 @@ def ubpy(request):
         pytest.skip('Cannot get target connection')
         return None
     try:
-        console.ensure_spawned()
+        ubpy_fix.ensure_spawned()
     except OSError as err:
-        handle_exception(ubconfig, console, log, err, 'Lab failure', True)
+        handle_exception(ubconfig, ubpy_fix, log, err, 'Lab failure', True)
     except Timeout as err:
-        handle_exception(ubconfig, console, log, err, 'Lab timeout', True)
+        handle_exception(ubconfig, ubpy_fix, log, err, 'Lab timeout', True)
     except BootFail as err:
-        handle_exception(ubconfig, console, log, err, 'Boot fail', True,
-                         console.get_spawn_output())
+        handle_exception(ubconfig, ubpy_fix, log, err, 'Boot fail', True,
+                         ubpy.get_spawn_output())
     except Unexpected:
-        handle_exception(ubconfig, console, log, err, 'Unexpected test output',
+        handle_exception(ubconfig, ubpy_fix, log, err, 'Unexpected test output',
                          False)
-    return console
+    return ubpy_fix
 
 anchors = {}
 tests_not_run = []
@@ -613,8 +613,8 @@ def cleanup():
         Nothing.
     """
 
-    if console:
-        console.close()
+    if ubpy_fix:
+        ubpy_fix.close()
     if log:
         with log.section('Status Report', 'status_report'):
             log.status_pass('%d passed' % len(tests_passed))
@@ -835,7 +835,7 @@ def pytest_runtest_protocol(item, nextitem):
         test_durations[item.name] = duration
 
     if failure_cleanup:
-        console.drain_console()
+        ubpy_fix.drain_console()
 
     test_list.append(item.name)
     tests_not_run.remove(item.name)
@@ -845,7 +845,7 @@ def pytest_runtest_protocol(item, nextitem):
     except:
         # If something went wrong with logging, it's better to let the test
         # process continue, which may report other exceptions that triggered
-        # the logging issue (e.g. console.log wasn't created). Hence, just
+        # the logging issue (e.g. ubpy_fix.log wasn't created). Hence, just
         # squash the exception. If the test setup failed due to e.g. syntax
         # error somewhere else, this won't be seen. However, once that issue
         # is fixed, if this exception still exists, it will then be logged as
@@ -858,6 +858,6 @@ def pytest_runtest_protocol(item, nextitem):
     log.end_section(item.name)
 
     if failure_cleanup:
-        console.cleanup_spawn()
+        ubpy_fix.cleanup_spawn()
 
     return True
diff --git a/test/py/u_boot_console_base.py b/test/py/console_base.py
similarity index 99%
rename from test/py/u_boot_console_base.py
rename to test/py/console_base.py
index fa9cd57b04b..b080c389547 100644
--- a/test/py/u_boot_console_base.py
+++ b/test/py/console_base.py
@@ -13,8 +13,8 @@ import os
 import pytest
 import re
 import sys
-import u_boot_spawn
-from u_boot_spawn import BootFail, Timeout, Unexpected, handle_exception
+import spawn
+from spawn import BootFail, Timeout, Unexpected, handle_exception
 
 # Regexes for text we expect U-Boot to send to the console.
 pattern_u_boot_spl_signon = re.compile('(U-Boot SPL \\d{4}\\.\\d{2}[^\r\n]*\\))')
@@ -157,9 +157,9 @@ class ConsoleBase(object):
     def get_spawn(self):
         # This is not called, ssubclass must define this.
         # Return a value to avoid:
-        #   u_boot_console_base.py:348:12: E1128: Assigning result of a function
+        #   console_base.py:348:12: E1128: Assigning result of a function
         #   call, where the function returns None (assignment-from-none)
-        return u_boot_spawn.Spawn([])
+        return spawn.Spawn([])
 
 
     def eval_bad_patterns(self):
diff --git a/test/py/u_boot_console_exec_attach.py b/test/py/console_board.py
similarity index 95%
rename from test/py/u_boot_console_exec_attach.py
rename to test/py/console_board.py
index 8b253b4451d..bacb1e2526c 100644
--- a/test/py/u_boot_console_exec_attach.py
+++ b/test/py/console_board.py
@@ -8,8 +8,8 @@ physical serial port.
 """
 
 import sys
-from u_boot_spawn import Spawn
-from u_boot_console_base import ConsoleBase
+from spawn import Spawn
+from console_base import ConsoleBase
 
 class ConsoleExecAttach(ConsoleBase):
     """Represents a physical connection to a U-Boot console, typically via a
@@ -53,7 +53,7 @@ class ConsoleExecAttach(ConsoleBase):
             None.
 
         Returns:
-            A u_boot_spawn.Spawn object that is attached to U-Boot.
+            A spawn.Spawn object that is attached to U-Boot.
         """
 
         args = [self.config.board_type, self.config.board_identity]
diff --git a/test/py/u_boot_console_sandbox.py b/test/py/console_sandbox.py
similarity index 93%
rename from test/py/u_boot_console_sandbox.py
rename to test/py/console_sandbox.py
index 7bc44c78b8b..da55d2fcc1f 100644
--- a/test/py/u_boot_console_sandbox.py
+++ b/test/py/console_sandbox.py
@@ -7,8 +7,8 @@ Logic to interact with the sandbox port of U-Boot, running as a sub-process.
 """
 
 import time
-from u_boot_spawn import Spawn
-from u_boot_console_base import ConsoleBase
+from spawn import Spawn
+from console_base import ConsoleBase
 
 class ConsoleSandbox(ConsoleBase):
     """Represents a connection to a sandbox U-Boot console, executed as a sub-
@@ -39,7 +39,7 @@ class ConsoleSandbox(ConsoleBase):
             None.
 
         Returns:
-            A u_boot_spawn.Spawn object that is attached to U-Boot.
+            A spawn.Spawn object that is attached to U-Boot.
         """
 
         bcfg = self.config.buildconfig
@@ -71,7 +71,7 @@ class ConsoleSandbox(ConsoleBase):
             use_dtb: True to use a device tree file, False to run without one
 
         Returns:
-            A u_boot_spawn.Spawn object that is attached to U-Boot.
+            A spawn.Spawn object that is attached to U-Boot.
         """
 
         try:
diff --git a/test/py/u_boot_spawn.py b/test/py/spawn.py
similarity index 100%
rename from test/py/u_boot_spawn.py
rename to test/py/spawn.py
diff --git a/test/py/tests/fit_util.py b/test/py/tests/fit_util.py
index 16ff8c96c63..7aad4030be3 100644
--- a/test/py/tests/fit_util.py
+++ b/test/py/tests/fit_util.py
@@ -5,7 +5,7 @@
 
 import os
 
-import u_boot_utils as util
+import utils as util
 
 def make_fname(cons, basename):
     """Make a temporary filename
diff --git a/test/py/tests/test_android/test_ab.py b/test/py/tests/test_android/test_ab.py
index 71719d86104..320d1566e63 100644
--- a/test/py/tests/test_android/test_ab.py
+++ b/test/py/tests/test_android/test_ab.py
@@ -5,7 +5,7 @@
 
 import os
 import pytest
-import u_boot_utils
+import utils
 
 class ABTestDiskImage(object):
     """Disk Image used by the A/B tests."""
@@ -25,7 +25,7 @@ class ABTestDiskImage(object):
         persistent = ubpy.config.persistent_data_dir + '/' + filename
         self.path = ubpy.config.result_dir  + '/' + filename
 
-        with u_boot_utils.persistent_file_helper(ubpy.log, persistent):
+        with utils.persistent_file_helper(ubpy.log, persistent):
             if os.path.exists(persistent):
                 ubpy.log.action('Disk image file ' + persistent +
                     ' already exists')
@@ -35,16 +35,16 @@ class ABTestDiskImage(object):
                 os.ftruncate(fd, 524288)
                 os.close(fd)
                 cmd = ('sgdisk', persistent)
-                u_boot_utils.run_and_log(ubpy, cmd)
+                utils.run_and_log(ubpy, cmd)
 
                 cmd = ('sgdisk', '--new=1:64:512', '--change-name=1:misc',
                     persistent)
-                u_boot_utils.run_and_log(ubpy, cmd)
+                utils.run_and_log(ubpy, cmd)
                 cmd = ('sgdisk', '--load-backup=' + persistent)
-                u_boot_utils.run_and_log(ubpy, cmd)
+                utils.run_and_log(ubpy, cmd)
 
         cmd = ('cp', persistent, self.path)
-        u_boot_utils.run_and_log(ubpy, cmd)
+        utils.run_and_log(ubpy, cmd)
 
 di = None
 @pytest.fixture(scope='function')
diff --git a/test/py/tests/test_android/test_abootimg.py b/test/py/tests/test_android/test_abootimg.py
index 3f3c467e804..a5f8cbb1a47 100644
--- a/test/py/tests/test_android/test_abootimg.py
+++ b/test/py/tests/test_android/test_abootimg.py
@@ -6,7 +6,7 @@
 
 import os
 import pytest
-import u_boot_utils
+import utils
 
 """
 These tests rely on disk image (boot.img), which is automatically created by
@@ -122,7 +122,7 @@ class AbootimgTestDiskImage(object):
         persistent = ubpy.config.persistent_data_dir + '/' + filename
         self.path = ubpy.config.result_dir  + '/' + filename
         ubpy.log.action('persistent is ' + persistent)
-        with u_boot_utils.persistent_file_helper(ubpy.log, persistent):
+        with utils.persistent_file_helper(ubpy.log, persistent):
             if os.path.exists(persistent):
                 ubpy.log.action('Disk image file ' + persistent +
                     ' already exists')
@@ -133,12 +133,12 @@ class AbootimgTestDiskImage(object):
                 f.write(hex_img)
                 f.close()
                 cmd = ('xxd', '-r', '-p', gz_hex, gz)
-                u_boot_utils.run_and_log(ubpy, cmd)
+                utils.run_and_log(ubpy, cmd)
                 cmd = ('gunzip', '-9', gz)
-                u_boot_utils.run_and_log(ubpy, cmd)
+                utils.run_and_log(ubpy, cmd)
 
         cmd = ('cp', persistent, self.path)
-        u_boot_utils.run_and_log(ubpy, cmd)
+        utils.run_and_log(ubpy, cmd)
 
 gtdi1 = None
 @pytest.fixture(scope='function')
diff --git a/test/py/tests/test_android/test_avb.py b/test/py/tests/test_android/test_avb.py
index 71457f90563..33f3d60b867 100644
--- a/test/py/tests/test_android/test_avb.py
+++ b/test/py/tests/test_android/test_avb.py
@@ -15,7 +15,7 @@ For configuration verification:
 """
 
 import pytest
-import u_boot_utils as util
+import utils as util
 
 # defauld mmc id
 mmc_dev = 1
diff --git a/test/py/tests/test_dfu.py b/test/py/tests/test_dfu.py
index b2f86f95e76..ee91e95a347 100644
--- a/test/py/tests/test_dfu.py
+++ b/test/py/tests/test_dfu.py
@@ -9,7 +9,7 @@
 import os
 import os.path
 import pytest
-import u_boot_utils
+import utils
 
 """
 Note: This test relies on:
@@ -143,9 +143,9 @@ def test_dfu(ubpy, env__usb_dev_port, env__dfu_config):
             Nothing.
         """
 
-        u_boot_utils.wait_until_file_open_fails(
+        utils.wait_until_file_open_fails(
             env__usb_dev_port['host_usb_dev_node'], True)
-        fh = u_boot_utils.attempt_to_open_file(
+        fh = utils.attempt_to_open_file(
             env__usb_dev_port['host_usb_dev_node'])
         if fh:
             fh.close()
@@ -164,7 +164,7 @@ def test_dfu(ubpy, env__usb_dev_port, env__dfu_config):
         cmd = 'dfu 0 ' + env__dfu_config['cmd_params']
         ubpy.run_command(cmd, wait_for_prompt=False)
         ubpy.log.action('Waiting for DFU USB device to appear')
-        fh = u_boot_utils.wait_until_open_succeeds(
+        fh = utils.wait_until_open_succeeds(
             env__usb_dev_port['host_usb_dev_node'])
         fh.close()
 
@@ -190,7 +190,7 @@ def test_dfu(ubpy, env__usb_dev_port, env__dfu_config):
             ubpy.ctrlc()
             ubpy.log.action(
                 'Waiting for DFU USB device to disappear')
-            u_boot_utils.wait_until_file_open_fails(
+            utils.wait_until_file_open_fails(
                 env__usb_dev_port['host_usb_dev_node'], ignore_errors)
         except:
             if not ignore_errors:
@@ -213,7 +213,7 @@ def test_dfu(ubpy, env__usb_dev_port, env__dfu_config):
         cmd = ['dfu-util', '-a', alt_setting, up_dn_load_arg, fn]
         if 'host_usb_port_path' in env__usb_dev_port:
             cmd += ['-p', env__usb_dev_port['host_usb_port_path']]
-        u_boot_utils.run_and_log(ubpy, cmd)
+        utils.run_and_log(ubpy, cmd)
         ubpy.wait_for('Ctrl+C to exit ...')
 
     def dfu_write(alt_setting, fn):
@@ -261,7 +261,7 @@ def test_dfu(ubpy, env__usb_dev_port, env__dfu_config):
             Nothing.
         """
 
-        test_f = u_boot_utils.PersistentRandomFile(ubpy,
+        test_f = utils.PersistentRandomFile(ubpy,
             'dfu_%d.bin' % size, size)
         readback_fn = ubpy.config.result_dir + '/dfu_readback.bin'
 
@@ -279,7 +279,7 @@ def test_dfu(ubpy, env__usb_dev_port, env__dfu_config):
 
         ubpy.log.action('Comparing written and read data')
         written_hash = test_f.content_hash
-        read_back_hash = u_boot_utils.md5sum_file(readback_fn, size)
+        read_back_hash = utils.md5sum_file(readback_fn, size)
         assert(written_hash == read_back_hash)
 
     # This test may be executed against multiple USB ports. The test takes a
@@ -295,7 +295,7 @@ def test_dfu(ubpy, env__usb_dev_port, env__dfu_config):
     else:
         sizes = []
 
-    dummy_f = u_boot_utils.PersistentRandomFile(ubpy,
+    dummy_f = utils.PersistentRandomFile(ubpy,
         'dfu_dummy.bin', 1024)
 
     alt_setting_test_file = env__dfu_config.get('alt_id_test_file', '0')
diff --git a/test/py/tests/test_efi_fit.py b/test/py/tests/test_efi_fit.py
index fc57536821d..934f3fb2a7b 100644
--- a/test/py/tests/test_efi_fit.py
+++ b/test/py/tests/test_efi_fit.py
@@ -55,7 +55,7 @@ env__efi_fit_tftp_file = {
 
 import os.path
 import pytest
-import u_boot_utils as util
+import utils as util
 
 # Define the parametrized ITS data to be used for FIT images generation.
 ITS_DATA = '''
diff --git a/test/py/tests/test_efi_loader.py b/test/py/tests/test_efi_loader.py
index f654a18bd69..0f7fc2caddf 100644
--- a/test/py/tests/test_efi_loader.py
+++ b/test/py/tests/test_efi_loader.py
@@ -53,7 +53,7 @@ env__efi_helloworld_net_http_test_skip = True
 """
 
 import pytest
-import u_boot_utils
+import utils
 
 PROTO_TFTP, PROTO_HTTP = range(0, 2)
 
@@ -132,7 +132,7 @@ def fetch_file(ubpy, env_conf, proto):
 
     addr = f.get('addr', None)
     if not addr:
-        addr = u_boot_utils.find_ram_base(ubpy)
+        addr = utils.find_ram_base(ubpy)
 
     fn = f['fn']
     if proto == PROTO_TFTP:
diff --git a/test/py/tests/test_env.py b/test/py/tests/test_env.py
index f25504550b3..255d5779932 100644
--- a/test/py/tests/test_env.py
+++ b/test/py/tests/test_env.py
@@ -13,7 +13,7 @@ from subprocess import call, CalledProcessError
 import tempfile
 
 import pytest
-import u_boot_utils
+import utils
 
 # FIXME: This might be useful for other tests;
 # perhaps refactor it into ConsoleBase or some other state object?
@@ -187,7 +187,7 @@ def test_env_initial_env_file(ubpy):
     except:
         pass
 
-    u_boot_utils.run_and_log(cons, ['make', builddir, 'u-boot-initial-env'])
+    utils.run_and_log(cons, ['make', builddir, 'u-boot-initial-env'])
 
     assert os.path.exists(envfile)
 
@@ -278,7 +278,7 @@ def test_env_import_checksum_no_size(state_test_env):
        env import function.
     """
     c = state_test_env.ubpy
-    ram_base = u_boot_utils.find_ram_base(state_test_env.ubpy)
+    ram_base = utils.find_ram_base(state_test_env.ubpy)
     addr = '%08x' % ram_base
 
     with c.disable_check('error_notification'):
@@ -291,7 +291,7 @@ def test_env_import_whitelist_checksum_no_size(state_test_env):
        env import function when variables are passed as parameters.
     """
     c = state_test_env.ubpy
-    ram_base = u_boot_utils.find_ram_base(state_test_env.ubpy)
+    ram_base = utils.find_ram_base(state_test_env.ubpy)
     addr = '%08x' % ram_base
 
     with c.disable_check('error_notification'):
@@ -303,7 +303,7 @@ def test_env_import_whitelist_checksum_no_size(state_test_env):
 def test_env_import_whitelist(state_test_env):
     """Test importing only a handful of env variables from an environment."""
     c = state_test_env.ubpy
-    ram_base = u_boot_utils.find_ram_base(state_test_env.ubpy)
+    ram_base = utils.find_ram_base(state_test_env.ubpy)
     addr = '%08x' % ram_base
 
     set_var(state_test_env, 'foo1', 'bar1')
@@ -340,7 +340,7 @@ def test_env_import_whitelist_delete(state_test_env):
        environment to be imported.
     """
     c = state_test_env.ubpy
-    ram_base = u_boot_utils.find_ram_base(state_test_env.ubpy)
+    ram_base = utils.find_ram_base(state_test_env.ubpy)
     addr = '%08x' % ram_base
 
     set_var(state_test_env, 'foo1', 'bar1')
@@ -446,16 +446,16 @@ def mk_env_ext4(state_test_env):
         # Some distributions do not add /sbin to the default PATH, where mkfs.ext4 lives
         os.environ["PATH"] += os.pathsep + '/sbin'
         try:
-            u_boot_utils.run_and_log(c, 'dd if=/dev/zero of=%s bs=1M count=16' % persistent)
-            u_boot_utils.run_and_log(c, 'mkfs.ext4 %s' % persistent)
-            sb_content = u_boot_utils.run_and_log(c, 'tune2fs -l %s' % persistent)
+            utils.run_and_log(c, 'dd if=/dev/zero of=%s bs=1M count=16' % persistent)
+            utils.run_and_log(c, 'mkfs.ext4 %s' % persistent)
+            sb_content = utils.run_and_log(c, 'tune2fs -l %s' % persistent)
             if 'metadata_csum' in sb_content:
-                u_boot_utils.run_and_log(c, 'tune2fs -O ^metadata_csum %s' % persistent)
+                utils.run_and_log(c, 'tune2fs -O ^metadata_csum %s' % persistent)
         except CalledProcessError:
             call('rm -f %s' % persistent, shell=True)
             raise
 
-    u_boot_utils.run_and_log(c, ['cp',  '-f', persistent, fs_img])
+    utils.run_and_log(c, ['cp',  '-f', persistent, fs_img])
     return fs_img
 
 @pytest.mark.boardspec('sandbox')
@@ -560,7 +560,7 @@ def test_env_text(ubpy):
             fname = os.path.join(path, 'infile')
             with open(fname, 'w') as inf:
                 print(intext, file=inf)
-            result = u_boot_utils.run_and_log(cons, ['awk', '-f', script, fname])
+            result = utils.run_and_log(cons, ['awk', '-f', script, fname])
             if expect_val is not None:
                 expect = '#define CONFIG_EXTRA_ENV_TEXT "%s"\n' % expect_val
                 assert result == expect
diff --git a/test/py/tests/test_event_dump.py b/test/py/tests/test_event_dump.py
index 51cc9a3a211..6a3ac795ac0 100644
--- a/test/py/tests/test_event_dump.py
+++ b/test/py/tests/test_event_dump.py
@@ -4,7 +4,7 @@
 
 import pytest
 import re
-import u_boot_utils as util
+import utils as util
 
 # This is only a partial test - coverting 64-bit sandbox. It does not test
 # big-endian images, nor 32-bit images
diff --git a/test/py/tests/test_extension.py b/test/py/tests/test_extension.py
index cb470c1c951..4e678d59bef 100644
--- a/test/py/tests/test_extension.py
+++ b/test/py/tests/test_extension.py
@@ -6,7 +6,7 @@
 
 import os
 import pytest
-import u_boot_utils
+import utils
 
 overlay_addr = 0x1000
 
diff --git a/test/py/tests/test_fit.py b/test/py/tests/test_fit.py
index bbf2eab33e3..ca3249c913d 100755
--- a/test/py/tests/test_fit.py
+++ b/test/py/tests/test_fit.py
@@ -6,7 +6,7 @@
 import os
 import pytest
 import struct
-import u_boot_utils as util
+import utils as util
 import fit_util
 
 # Define a base ITS which we can adjust using % and a dictionary
diff --git a/test/py/tests/test_fit_auto_signed.py b/test/py/tests/test_fit_auto_signed.py
index 6b8f7d1848f..038cb2d10ce 100644
--- a/test/py/tests/test_fit_auto_signed.py
+++ b/test/py/tests/test_fit_auto_signed.py
@@ -17,7 +17,7 @@ The test does not run the sandbox. It only checks the host tool mkimage.
 
 import os
 import pytest
-import u_boot_utils as util
+import utils as util
 import binascii
 from Cryptodome.Hash import SHA1
 from Cryptodome.Hash import SHA256
diff --git a/test/py/tests/test_fit_ecdsa.py b/test/py/tests/test_fit_ecdsa.py
index e51120bc15c..79e633ac333 100644
--- a/test/py/tests/test_fit_ecdsa.py
+++ b/test/py/tests/test_fit_ecdsa.py
@@ -12,7 +12,7 @@ This test doesn't run the sandbox. It only checks the host tool 'mkimage'
 
 import os
 import pytest
-import u_boot_utils as util
+import utils as util
 from Cryptodome.Hash import SHA256
 from Cryptodome.PublicKey import ECC
 from Cryptodome.Signature import DSS
diff --git a/test/py/tests/test_fit_hashes.py b/test/py/tests/test_fit_hashes.py
index 7b13c0e748c..fbc01f078b2 100644
--- a/test/py/tests/test_fit_hashes.py
+++ b/test/py/tests/test_fit_hashes.py
@@ -12,7 +12,7 @@ This test doesn't run the sandbox. It only checks the host tool 'mkimage'
 
 import os
 import pytest
-import u_boot_utils as util
+import utils as util
 
 kernel_hashes = {
     "sha512" : "f18c1486a2c29f56360301576cdfce4dfd8e8e932d0ed8e239a1f314b8ae1d77b2a58cd7fe32e4075e69448e623ce53b0b6aa6ce5626d2c189a5beae29a68d93",
diff --git a/test/py/tests/test_fpga.py b/test/py/tests/test_fpga.py
index 5b146d0a2a4..a2e19f7f76d 100644
--- a/test/py/tests/test_fpga.py
+++ b/test/py/tests/test_fpga.py
@@ -8,7 +8,7 @@
 import pytest
 import re
 import random
-import u_boot_utils
+import utils
 
 """
 Note: This test relies on boardenv_* containing configuration values to define
@@ -518,7 +518,7 @@ def test_fpga_secure_bit_auth(ubpy):
 
     addr = f.get('addr', None)
     if not addr:
-      addr = u_boot_utils.find_ram_base(ubpy)
+      addr = utils.find_ram_base(ubpy)
 
     expected_tftp = 'Bytes transferred = '
     fn = f['fn']
@@ -546,7 +546,7 @@ def test_fpga_secure_bit_img_auth_kup(ubpy):
 
     keyaddr = f.get('keyaddr', None)
     if not keyaddr:
-      addr = u_boot_utils.find_ram_base(ubpy)
+      addr = utils.find_ram_base(ubpy)
     expected_tftp = 'Bytes transferred = '
     keyfn = f['keyfn']
     output = ubpy.run_command('tftpboot %x %s' % (keyaddr, keyfn))
@@ -554,7 +554,7 @@ def test_fpga_secure_bit_img_auth_kup(ubpy):
 
     addr = f.get('addr', None)
     if not addr:
-      addr = u_boot_utils.find_ram_base(ubpy)
+      addr = utils.find_ram_base(ubpy)
     expected_tftp = 'Bytes transferred = '
     fn = f['enckupfn']
     output = ubpy.run_command('tftpboot %x %s' % (addr, fn))
diff --git a/test/py/tests/test_fs/conftest.py b/test/py/tests/test_fs/conftest.py
index af2adaf1645..ea25cc75aac 100644
--- a/test/py/tests/test_fs/conftest.py
+++ b/test/py/tests/test_fs/conftest.py
@@ -8,7 +8,7 @@ import pytest
 import re
 from subprocess import call, check_call, check_output, CalledProcessError
 from fstest_defs import *
-import u_boot_utils as util
+import utils as util
 # pylint: disable=E0611
 from tests import fs_helper
 
diff --git a/test/py/tests/test_gpio.py b/test/py/tests/test_gpio.py
index 1b30fb4726f..d6ebf40e841 100644
--- a/test/py/tests/test_gpio.py
+++ b/test/py/tests/test_gpio.py
@@ -5,7 +5,7 @@
 
 import pytest
 import time
-import u_boot_utils
+import utils
 
 """
 	test_gpio_input is intended to test the fix 4dbc107f4683.
diff --git a/test/py/tests/test_gpt.py b/test/py/tests/test_gpt.py
index 530545c151d..f312e9ece87 100644
--- a/test/py/tests/test_gpt.py
+++ b/test/py/tests/test_gpt.py
@@ -6,7 +6,7 @@
 
 import os
 import pytest
-import u_boot_utils
+import utils
 
 """
 These tests rely on a 4 MB disk image, which is automatically created by
@@ -63,7 +63,7 @@ class GptTestDiskImage(object):
         persistent = ubpy.config.persistent_data_dir + '/' + filename
         self.path = ubpy.config.result_dir  + '/' + filename
 
-        with u_boot_utils.persistent_file_helper(ubpy.log, persistent):
+        with utils.persistent_file_helper(ubpy.log, persistent):
             if os.path.exists(persistent):
                 ubpy.log.action('Disk image file ' + persistent +
                     ' already exists')
@@ -75,23 +75,23 @@ class GptTestDiskImage(object):
                 cmd = ('sgdisk',
                     '--disk-guid=375a56f7-d6c9-4e81-b5f0-09d41ca89efe',
                     persistent)
-                u_boot_utils.run_and_log(ubpy, cmd)
+                utils.run_and_log(ubpy, cmd)
                 # part1 offset 1MB size 1MB
                 cmd = ('sgdisk', '--new=1:2048:4095', '--change-name=1:part1',
                     '--partition-guid=1:33194895-67f6-4561-8457-6fdeed4f50a3',
                     '-A 1:set:2',
                     persistent)
                 # part2 offset 2MB size 1.5MB
-                u_boot_utils.run_and_log(ubpy, cmd)
+                utils.run_and_log(ubpy, cmd)
                 cmd = ('sgdisk', '--new=2:4096:7167', '--change-name=2:part2',
                     '--partition-guid=2:cc9c6e4a-6551-4cb5-87be-3210f96c86fb',
                     persistent)
-                u_boot_utils.run_and_log(ubpy, cmd)
+                utils.run_and_log(ubpy, cmd)
                 cmd = ('sgdisk', '--load-backup=' + persistent)
-                u_boot_utils.run_and_log(ubpy, cmd)
+                utils.run_and_log(ubpy, cmd)
 
         cmd = ('cp', persistent, self.path)
-        u_boot_utils.run_and_log(ubpy, cmd)
+        utils.run_and_log(ubpy, cmd)
 
 @pytest.fixture(scope='function')
 def state_disk_image(ubpy):
diff --git a/test/py/tests/test_kconfig.py b/test/py/tests/test_kconfig.py
index bd1f75a795f..cd54ac58f83 100644
--- a/test/py/tests/test_kconfig.py
+++ b/test/py/tests/test_kconfig.py
@@ -4,7 +4,7 @@
 
 import pytest
 
-import u_boot_utils as util
+import utils as util
 
 # This is needed for Azure, since the default '..' directory is not writeable
 TMPDIR = '/tmp/test_kconfig'
diff --git a/test/py/tests/test_md.py b/test/py/tests/test_md.py
index 550a367d076..84e206441d9 100644
--- a/test/py/tests/test_md.py
+++ b/test/py/tests/test_md.py
@@ -3,14 +3,14 @@
 # Copyright (c) 2015-2016, NVIDIA CORPORATION. All rights reserved.
 
 import pytest
-import u_boot_utils
+import utils
 
 @pytest.mark.buildconfigspec('cmd_memory')
 def test_md(ubpy):
     """Test that md reads memory as expected, and that memory can be modified
     using the mw command."""
 
-    ram_base = u_boot_utils.find_ram_base(ubpy)
+    ram_base = utils.find_ram_base(ubpy)
     addr = '%08x' % ram_base
     val = 'a5f09876'
     expected_response = addr + ': ' + val
@@ -26,7 +26,7 @@ def test_md_repeat(ubpy):
     """Test command repeat (via executing an empty command) operates correctly
     for "md"; the command must repeat and dump an incrementing address."""
 
-    ram_base = u_boot_utils.find_ram_base(ubpy)
+    ram_base = utils.find_ram_base(ubpy)
     addr_base = '%08x' % ram_base
     words = 0x10
     addr_repeat = '%08x' % (ram_base + (words * 4))
diff --git a/test/py/tests/test_mmc.py b/test/py/tests/test_mmc.py
index ad7faaff5f0..d1f38ac3d63 100644
--- a/test/py/tests/test_mmc.py
+++ b/test/py/tests/test_mmc.py
@@ -4,7 +4,7 @@
 import pytest
 import random
 import re
-import u_boot_utils
+import utils
 
 """
 Note: This test doesn't rely on boardenv_* configuration values but it can
@@ -290,7 +290,7 @@ def test_mmc_fatload_fatwrite(ubpy):
                 for y in mmc_modes:
                     ubpy.run_command('mmc dev %d %d %d' % x, part, y)
                     part_detect = 1
-                    addr = u_boot_utils.find_ram_base(ubpy)
+                    addr = utils.find_ram_base(ubpy)
                     devices[x]['addr_%d' % part] = addr
                     size = random.randint(4, 1 * 1024 * 1024)
                     devices[x]['size_%d' % part] = size
@@ -394,7 +394,7 @@ def test_mmc_ext4load_ext4write(ubpy):
                 for y in mmc_modes:
                     ubpy.run_command('mmc dev %d %d %d' % x, part, y)
                     part_detect = 1
-                    addr = u_boot_utils.find_ram_base(ubpy)
+                    addr = utils.find_ram_base(ubpy)
                     devices[x]['addr_%d' % part] = addr
                     size = random.randint(4, 1 * 1024 * 1024)
                     devices[x]['size_%d' % part] = size
@@ -658,7 +658,7 @@ def test_mmc_fat_read_write_files(ubpy):
                 for y in mmc_modes:
                     ubpy.run_command('mmc dev %d %d %d' % x, part, y)
                     part_detect = 1
-                    addr = u_boot_utils.find_ram_base(ubpy)
+                    addr = utils.find_ram_base(ubpy)
                     count_f = 0
                     addr_l = []
                     size_l = []
diff --git a/test/py/tests/test_mmc_rd.py b/test/py/tests/test_mmc_rd.py
index 0fc5dbc05a3..5f61810f1e2 100644
--- a/test/py/tests/test_mmc_rd.py
+++ b/test/py/tests/test_mmc_rd.py
@@ -7,7 +7,7 @@
 
 import pytest
 import time
-import u_boot_utils
+import utils
 
 """
 This test relies on boardenv_* to containing configuration values to define
@@ -241,7 +241,7 @@ def test_mmc_rd(ubpy, env__mmc_rd_config):
     bcfg = ubpy.config.buildconfig
     has_cmd_memory = bcfg.get('config_cmd_memory', 'n') == 'y'
     has_cmd_crc32 = bcfg.get('config_cmd_crc32', 'n') == 'y'
-    ram_base = u_boot_utils.find_ram_base(ubpy)
+    ram_base = utils.find_ram_base(ubpy)
     addr = '0x%08x' % ram_base
 
     # Select MMC device
diff --git a/test/py/tests/test_mmc_wr.py b/test/py/tests/test_mmc_wr.py
index 2b278cb21cd..062ad8c4d0a 100644
--- a/test/py/tests/test_mmc_wr.py
+++ b/test/py/tests/test_mmc_wr.py
@@ -6,7 +6,7 @@
 # to the eMMC or SD card, then reads it back and performs a comparison.
 
 import pytest
-import u_boot_utils
+import utils
 
 """
 This test relies on boardenv_* to containing configuration values to define
@@ -61,7 +61,7 @@ def test_mmc_wr(ubpy, env__mmc_wr_config):
 
     count_bytes = count_sectors * 512
     bcfg = ubpy.config.buildconfig
-    ram_base = u_boot_utils.find_ram_base(ubpy)
+    ram_base = utils.find_ram_base(ubpy)
     src_addr = '0x%08x' % ram_base
     dst_addr = '0x%08x' % (ram_base + count_bytes)
 
diff --git a/test/py/tests/test_net.py b/test/py/tests/test_net.py
index 1c31a9d4727..bdb7e6f372d 100644
--- a/test/py/tests/test_net.py
+++ b/test/py/tests/test_net.py
@@ -5,7 +5,7 @@
 # tftpboot commands.
 
 import pytest
-import u_boot_utils
+import utils
 import uuid
 import datetime
 import re
@@ -315,7 +315,7 @@ def test_net_nfs(ubpy):
 
     addr = f.get('addr', None)
     if not addr:
-        addr = u_boot_utils.find_ram_base(ubpy)
+        addr = utils.find_ram_base(ubpy)
 
     fn = f['fn']
     output = ubpy.run_command('nfs %x %s' % (addr, fn))
@@ -411,7 +411,7 @@ def test_net_tftpput(ubpy):
 
     addr = f.get("addr", None)
     if not addr:
-        addr = u_boot_utils.find_ram_base(ubpy)
+        addr = utils.find_ram_base(ubpy)
 
     sz = f.get("size", None)
     timeout = f.get("timeout", ubpy.p.timeout)
diff --git a/test/py/tests/test_net_boot.py b/test/py/tests/test_net_boot.py
index 025bad7c893..20153b94a2f 100644
--- a/test/py/tests/test_net_boot.py
+++ b/test/py/tests/test_net_boot.py
@@ -2,7 +2,7 @@
 # (C) Copyright 2023, Advanced Micro Devices, Inc.
 
 import pytest
-import u_boot_utils
+import utils
 import test_net
 import re
 
@@ -130,7 +130,7 @@ def setup_tftpboot_boot(ubpy):
     setup_networking(ubpy)
     addr = f.get('addr', None)
     if not addr:
-        addr = u_boot_utils.find_ram_base(ubpy)
+        addr = utils.find_ram_base(ubpy)
 
     fn = f['fn']
     timeout = f.get('timeout', 50000)
diff --git a/test/py/tests/test_of_migrate.py b/test/py/tests/test_of_migrate.py
index 274ea455f9f..ca6627a115d 100644
--- a/test/py/tests/test_of_migrate.py
+++ b/test/py/tests/test_of_migrate.py
@@ -7,7 +7,7 @@
 import os
 import pytest
 
-import u_boot_utils as util
+import utils as util
 
 # This is needed for Azure, since the default '..' directory is not writeable
 TMPDIR1 = '/tmp/test_no_migrate'
diff --git a/test/py/tests/test_ofplatdata.py b/test/py/tests/test_ofplatdata.py
index 391d475ca90..cb9be2eca50 100644
--- a/test/py/tests/test_ofplatdata.py
+++ b/test/py/tests/test_ofplatdata.py
@@ -2,7 +2,7 @@
 # Copyright (c) 2016 Google, Inc
 
 import pytest
-import u_boot_utils as util
+import utils as util
 
 @pytest.mark.boardspec('sandbox_spl')
 @pytest.mark.buildconfigspec('spl_of_platdata')
diff --git a/test/py/tests/test_optee_rpmb.py b/test/py/tests/test_optee_rpmb.py
index 8940d4a3073..08068bd9f1d 100644
--- a/test/py/tests/test_optee_rpmb.py
+++ b/test/py/tests/test_optee_rpmb.py
@@ -7,7 +7,7 @@ This tests optee_rpmb cmd in U-Boot
 """
 
 import pytest
-import u_boot_utils as util
+import utils as util
 
 @pytest.mark.buildconfigspec('cmd_optee_rpmb')
 def test_optee_rpmb_read_write(ubpy):
diff --git a/test/py/tests/test_pinmux.py b/test/py/tests/test_pinmux.py
index e599d2f38fe..c171700d5f7 100644
--- a/test/py/tests/test_pinmux.py
+++ b/test/py/tests/test_pinmux.py
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 import pytest
-import u_boot_utils
+import utils
 
 @pytest.mark.buildconfigspec('cmd_pinmux')
 def test_pinmux_usage_1(ubpy):
diff --git a/test/py/tests/test_pstore.py b/test/py/tests/test_pstore.py
index 91bbe16a2ac..a66dcc13eda 100644
--- a/test/py/tests/test_pstore.py
+++ b/test/py/tests/test_pstore.py
@@ -3,7 +3,7 @@
 # Author: Frédéric Danis <frederic.danis@collabora.com>
 
 import pytest
-import u_boot_utils
+import utils
 import os
 import tempfile
 import shutil
diff --git a/test/py/tests/test_sandbox_opts.py b/test/py/tests/test_sandbox_opts.py
index a0231f6d453..1c1c77f0f98 100644
--- a/test/py/tests/test_sandbox_opts.py
+++ b/test/py/tests/test_sandbox_opts.py
@@ -4,7 +4,7 @@
 
 import pytest
 
-import u_boot_utils as util
+import utils as util
 
 # This is needed for Azure, since the default '..' directory is not writeable
 TMPDIR = '/tmp/test_cmdline'
diff --git a/test/py/tests/test_scp03.py b/test/py/tests/test_scp03.py
index 3ff6c0a2602..3ceabdc6a21 100644
--- a/test/py/tests/test_scp03.py
+++ b/test/py/tests/test_scp03.py
@@ -11,7 +11,7 @@ For additional details check doc/usage/scp03.rst
 """
 
 import pytest
-import u_boot_utils as util
+import utils as util
 
 @pytest.mark.buildconfigspec('cmd_scp03')
 def test_scp03(ubpy):
diff --git a/test/py/tests/test_sf.py b/test/py/tests/test_sf.py
index 0e9ea0c422f..b5f82f482d5 100644
--- a/test/py/tests/test_sf.py
+++ b/test/py/tests/test_sf.py
@@ -5,7 +5,7 @@
 import re
 import pytest
 import random
-import u_boot_utils
+import utils
 
 """
 Note: This test relies on boardenv_* containing configuration values to define
@@ -57,7 +57,7 @@ def sf_prepare(ubpy, env__sf_config):
     """
 
     sf_params = {}
-    sf_params['ram_base'] = u_boot_utils.find_ram_base(ubpy)
+    sf_params['ram_base'] = utils.find_ram_base(ubpy)
 
     probe_id = env__sf_config.get('id', 0)
     speed = env__sf_config.get('speed', 0)
@@ -123,14 +123,14 @@ def sf_read(ubpy, env__sf_config, sf_params):
 
     cmd = 'mw.b %08x %02x %x' % (addr, pattern, count)
     ubpy.run_command(cmd)
-    crc_pattern = u_boot_utils.crc32(ubpy, addr, count)
+    crc_pattern = utils.crc32(ubpy, addr, count)
     if crc_expected:
         assert crc_pattern != crc_expected
 
     cmd = 'sf read %08x %08x %x' % (addr, offset, count)
     response = ubpy.run_command(cmd)
     assert 'Read: OK' in response, 'Read operation failed'
-    crc_readback = u_boot_utils.crc32(ubpy, addr, count)
+    crc_readback = utils.crc32(ubpy, addr, count)
     assert crc_pattern != crc_readback, 'sf read did not update RAM content.'
     if crc_expected:
         assert crc_readback == crc_expected
@@ -156,7 +156,7 @@ def sf_update(ubpy, env__sf_config, sf_params):
 
     cmd = 'mw.b %08x %02x %x' % (addr, pattern, count)
     ubpy.run_command(cmd)
-    crc_pattern = u_boot_utils.crc32(ubpy, addr, count)
+    crc_pattern = utils.crc32(ubpy, addr, count)
 
     cmd = 'sf update %08x %08x %x' % (addr, offset, count)
     ubpy.run_command(cmd)
@@ -201,7 +201,7 @@ def test_sf_erase(ubpy, env__sf_config):
 
     cmd = 'mw.b %08x ff %x' % (addr, count)
     ubpy.run_command(cmd)
-    crc_ffs = u_boot_utils.crc32(ubpy, addr, count)
+    crc_ffs = utils.crc32(ubpy, addr, count)
 
     crc_read = sf_read(ubpy, env__sf_config, sf_params)
     assert crc_ffs == crc_read, 'Unexpected CRC32 after erase operation.'
diff --git a/test/py/tests/test_source.py b/test/py/tests/test_source.py
index 66539cf89c1..1ea50325ef0 100644
--- a/test/py/tests/test_source.py
+++ b/test/py/tests/test_source.py
@@ -3,7 +3,7 @@
 
 import os
 import pytest
-import u_boot_utils as util
+import utils as util
 
 @pytest.mark.boardspec('sandbox')
 @pytest.mark.buildconfigspec('cmd_echo')
diff --git a/test/py/tests/test_spi.py b/test/py/tests/test_spi.py
index 414d44bed1b..c08a2349ca9 100644
--- a/test/py/tests/test_spi.py
+++ b/test/py/tests/test_spi.py
@@ -51,7 +51,7 @@ env__spi_lock_unlock = {
 import random
 import re
 import pytest
-import u_boot_utils
+import utils
 
 SPI_DATA = {}
 EXPECTED_ERASE = 'Erased: OK'
@@ -200,7 +200,7 @@ def test_spi_erase_block(ubpy):
 
 def spi_write_twice(ubpy, page_size, erase_size, total_size, timeout):
     ''' Random write till page size, random till size and full size '''
-    addr = u_boot_utils.find_ram_base(ubpy)
+    addr = utils.find_ram_base(ubpy)
 
     old_size = 0
     for size in (
@@ -273,7 +273,7 @@ def test_spi_write_twice(ubpy):
 def spi_write_continues(ubpy, page_size, erase_size, total_size, timeout):
     ''' Write with random size of data to continue SPI write case '''
     spi_erase_block(ubpy, erase_size, total_size)
-    addr = u_boot_utils.find_ram_base(ubpy)
+    addr = utils.find_ram_base(ubpy)
 
     output = ubpy.run_command(f'crc32 {hex(addr + 0x10000)} {hex(total_size)}')
     m = re.search('==> (.+?)$', output)
@@ -329,7 +329,7 @@ def spi_read_twice(ubpy, page_size, total_size, timeout):
     ''' Read the whole SPI flash twice, random_size till full flash size,
     random till page size '''
     for size in random.randint(4, page_size), random.randint(4, total_size), total_size:
-        addr = u_boot_utils.find_ram_base(ubpy)
+        addr = utils.find_ram_base(ubpy)
         size = size & ~3
         with ubpy.temporary_timeout(timeout):
             output = ubpy.run_command(
@@ -453,13 +453,13 @@ def protect_ops(ubpy, lock_addr, lock_size, ops="unlock"):
 
 def erase_write_ops(ubpy, start, size):
     ''' Basic erase and write operation for flash '''
-    addr = u_boot_utils.find_ram_base(ubpy)
+    addr = utils.find_ram_base(ubpy)
     flash_ops(ubpy, 'erase', start, size, 0, 0, EXPECTED_ERASE)
     flash_ops(ubpy, 'write', start, size, addr, 0, EXPECTED_WRITE)
 
 def spi_lock_unlock(ubpy, lock_addr, lock_size):
     ''' Lock unlock operations for SPI family flash '''
-    addr = u_boot_utils.find_ram_base(ubpy)
+    addr = utils.find_ram_base(ubpy)
     erase_size = get_erase_size()
 
     # Find the protected/un-protected region
@@ -614,7 +614,7 @@ def test_spi_negative(ubpy):
     total_size = get_total_size()
     erase_size = get_erase_size()
     page_size = get_page_size()
-    addr = u_boot_utils.find_ram_base(ubpy)
+    addr = utils.find_ram_base(ubpy)
     i = 0
     while i < loop:
         # Erase negative test
diff --git a/test/py/tests/test_tpm2.py b/test/py/tests/test_tpm2.py
index 418a974227e..3dea9323835 100644
--- a/test/py/tests/test_tpm2.py
+++ b/test/py/tests/test_tpm2.py
@@ -4,7 +4,7 @@
 
 import os.path
 import pytest
-import u_boot_utils
+import utils
 import re
 import time
 
@@ -197,7 +197,7 @@ def test_tpm2_get_capability(ubpy):
         tpm2_sandbox_init(ubpy)
 
     force_init(ubpy)
-    ram = u_boot_utils.find_ram_base(ubpy)
+    ram = utils.find_ram_base(ubpy)
 
     read_cap = ubpy.run_command('tpm2 get_capability 0x6 0x20e 0x200 1') #0x%x 1' % ram)
     output = ubpy.run_command('echo $?')
@@ -220,7 +220,7 @@ def test_tpm2_dam_parameters(ubpy):
     if is_sandbox(ubpy):
         tpm2_sandbox_init(ubpy)
     force_init(ubpy)
-    ram = u_boot_utils.find_ram_base(ubpy)
+    ram = utils.find_ram_base(ubpy)
 
     # Set the DAM parameters to known values
     ubpy.run_command('tpm2 dam_parameters 3 10 0')
@@ -245,7 +245,7 @@ def test_tpm2_pcr_read(ubpy):
         tpm2_sandbox_init(ubpy)
 
     force_init(ubpy)
-    ram = u_boot_utils.find_ram_base(ubpy)
+    ram = utils.find_ram_base(ubpy)
 
     read_pcr = ubpy.run_command('tpm2 pcr_read 10 0x%x' % ram)
     output = ubpy.run_command('echo $?')
@@ -273,7 +273,7 @@ def test_tpm2_pcr_extend(ubpy):
     if is_sandbox(ubpy):
         tpm2_sandbox_init(ubpy)
     force_init(ubpy)
-    ram = u_boot_utils.find_ram_base(ubpy)
+    ram = utils.find_ram_base(ubpy)
 
     read_pcr = ubpy.run_command('tpm2 pcr_read 10 0x%x' % (ram + 0x20))
     output = ubpy.run_command('echo $?')
diff --git a/test/py/tests/test_trace.py b/test/py/tests/test_trace.py
index 86541c96e0d..51a7171eeb3 100644
--- a/test/py/tests/test_trace.py
+++ b/test/py/tests/test_trace.py
@@ -6,7 +6,7 @@ import os
 import pytest
 import re
 
-import u_boot_utils as util
+import utils as util
 
 # This is needed for Azure, since the default '..' directory is not writeable
 TMPDIR = '/tmp/test_trace'
diff --git a/test/py/tests/test_ums.py b/test/py/tests/test_ums.py
index 0078f9568f6..dec4e75d1d8 100644
--- a/test/py/tests/test_ums.py
+++ b/test/py/tests/test_ums.py
@@ -11,7 +11,7 @@ import os.path
 import pytest
 import re
 import time
-import u_boot_utils
+import utils
 
 """
 Note: This test relies on:
@@ -116,7 +116,7 @@ def test_ums(ubpy, env__usb_dev_port, env__block_devs):
     else:
         host_ums_part_node = host_ums_dev_node
 
-    test_f = u_boot_utils.PersistentRandomFile(ubpy, 'ums.bin',
+    test_f = utils.PersistentRandomFile(ubpy, 'ums.bin',
         1024 * 1024);
     if have_writable_fs_partition:
         mounted_test_fn = mount_point + '/' + mount_subdir + test_f.fn
@@ -138,7 +138,7 @@ def test_ums(ubpy, env__usb_dev_port, env__block_devs):
         cmd = 'ums %s %s %s' % (tgt_usb_ctlr, tgt_dev_type, tgt_dev_id)
         ubpy.run_command(cmd, wait_for_prompt=False)
         ubpy.wait_for(re.compile('UMS: LUN.*[\r\n]'))
-        fh = u_boot_utils.wait_until_open_succeeds(host_ums_part_node)
+        fh = utils.wait_until_open_succeeds(host_ums_part_node)
         ubpy.log.action('Reading raw data from UMS device')
         fh.read(4096)
         fh.close()
@@ -155,7 +155,7 @@ def test_ums(ubpy, env__usb_dev_port, env__block_devs):
 
         ubpy.log.action('Mounting exported UMS device')
         cmd = ('/bin/mount', host_ums_part_node)
-        u_boot_utils.run_and_log(ubpy, cmd)
+        utils.run_and_log(ubpy, cmd)
 
     def umount(ignore_errors):
         """Unmount the block device that U-Boot exports.
@@ -172,7 +172,7 @@ def test_ums(ubpy, env__usb_dev_port, env__block_devs):
 
         ubpy.log.action('Unmounting UMS device')
         cmd = ('/bin/umount', host_ums_part_node)
-        u_boot_utils.run_and_log(ubpy, cmd, ignore_errors)
+        utils.run_and_log(ubpy, cmd, ignore_errors)
 
     def stop_ums(ignore_errors):
         """Stop U-Boot's ums shell command from executing.
@@ -193,7 +193,7 @@ def test_ums(ubpy, env__usb_dev_port, env__block_devs):
         ubpy.log.action(
             'Stopping long-running U-Boot ums shell command')
         ubpy.ctrlc()
-        u_boot_utils.wait_until_file_open_fails(host_ums_part_node,
+        utils.wait_until_file_open_fails(host_ums_part_node,
             ignore_errors)
 
     ignore_cleanup_errors = True
@@ -206,11 +206,11 @@ def test_ums(ubpy, env__usb_dev_port, env__block_devs):
             mount()
             ubpy.log.action('Writing test file via UMS')
             cmd = ('rm', '-f', mounted_test_fn)
-            u_boot_utils.run_and_log(ubpy, cmd)
+            utils.run_and_log(ubpy, cmd)
             if os.path.exists(mounted_test_fn):
                 raise Exception('Could not rm target UMS test file')
             cmd = ('cp', test_f.abs_fn, mounted_test_fn)
-            u_boot_utils.run_and_log(ubpy, cmd)
+            utils.run_and_log(ubpy, cmd)
             ignore_cleanup_errors = False
         finally:
             umount(ignore_errors=ignore_cleanup_errors)
@@ -223,9 +223,9 @@ def test_ums(ubpy, env__usb_dev_port, env__block_devs):
         try:
             mount()
             ubpy.log.action('Reading test file back via UMS')
-            read_back_hash = u_boot_utils.md5sum_file(mounted_test_fn)
+            read_back_hash = utils.md5sum_file(mounted_test_fn)
             cmd = ('rm', '-f', mounted_test_fn)
-            u_boot_utils.run_and_log(ubpy, cmd)
+            utils.run_and_log(ubpy, cmd)
             ignore_cleanup_errors = False
         finally:
             umount(ignore_errors=ignore_cleanup_errors)
diff --git a/test/py/tests/test_upl.py b/test/py/tests/test_upl.py
index 155e44ddcb6..287e107a885 100644
--- a/test/py/tests/test_upl.py
+++ b/test/py/tests/test_upl.py
@@ -6,7 +6,7 @@
 import os
 
 import pytest
-import u_boot_utils
+import utils
 
 @pytest.mark.boardspec('sandbox_vpl')
 def test_upl_handoff(ubpy):
diff --git a/test/py/tests/test_usb.py b/test/py/tests/test_usb.py
index 0f6ac4c7d08..ba183252e45 100644
--- a/test/py/tests/test_usb.py
+++ b/test/py/tests/test_usb.py
@@ -4,7 +4,7 @@
 import pytest
 import random
 import re
-import u_boot_utils
+import utils
 
 """
 Note: This test doesn't rely on boardenv_* configuration values but it can
@@ -296,7 +296,7 @@ def test_usb_fatls_fatinfo(ubpy):
         pytest.skip('No %s partition detected' % fs.upper())
 
 def usb_fatload_fatwrite(ubpy, fs, x, part):
-    addr = u_boot_utils.find_ram_base(ubpy)
+    addr = utils.find_ram_base(ubpy)
     size = random.randint(4, 1 * 1024 * 1024)
     output = ubpy.run_command('crc32 %x %x' % (addr, size))
     m = re.search('==> (.+?)', output)
@@ -391,7 +391,7 @@ def test_usb_ext4ls(ubpy):
         pytest.skip('No %s partition detected' % fs.upper())
 
 def usb_ext4load_ext4write(ubpy, fs, x, part):
-    addr = u_boot_utils.find_ram_base(ubpy)
+    addr = utils.find_ram_base(ubpy)
     size = random.randint(4, 1 * 1024 * 1024)
     output = ubpy.run_command('crc32 %x %x' % (addr, size))
     m = re.search('==> (.+?)', output)
@@ -505,7 +505,7 @@ def test_usb_ext2load(ubpy):
                 part_detect = 1
                 file, size, expected_crc32 = \
                     usb_ext4load_ext4write(ubpy, fs, x, part)
-                addr = u_boot_utils.find_ram_base(ubpy)
+                addr = utils.find_ram_base(ubpy)
 
                 offset = random.randrange(128, 1024, 128)
                 output = ubpy.run_command(
@@ -572,7 +572,7 @@ def test_usb_load(ubpy):
 
                 for part in partitions:
                     part_detect = 1
-                    addr = u_boot_utils.find_ram_base(ubpy)
+                    addr = utils.find_ram_base(ubpy)
 
                     if fs == 'fat':
                         file, size, expected_crc32 = \
@@ -616,7 +616,7 @@ def test_usb_save(ubpy):
 
                 for part in partitions:
                     part_detect = 1
-                    addr = u_boot_utils.find_ram_base(ubpy)
+                    addr = utils.find_ram_base(ubpy)
                     size = random.randint(4, 1 * 1024 * 1024)
                     file = '%s_%d' % ('uboot_test', size)
 
diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index 853a00caa9d..2d5f519d5aa 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -13,7 +13,7 @@ import os
 import os.path
 import pytest
 
-import u_boot_utils
+import utils
 # pylint: disable=E0611
 from tests import fs_helper
 from test_android import test_abootimg
@@ -52,8 +52,8 @@ def setup_image(cons, devnum, part_type, img_size=20, second_part=False,
     if second_part:
         spec += '\ntype=c'
 
-    u_boot_utils.run_and_log(cons, f'qemu-img create {fname} 20M')
-    u_boot_utils.run_and_log(cons, f'sfdisk {fname}',
+    utils.run_and_log(cons, f'qemu-img create {fname} 20M')
+    utils.run_and_log(cons, f'sfdisk {fname}',
                              stdin=spec.encode('utf-8'))
     return fname, mnt
 
@@ -149,12 +149,12 @@ booti ${kernel_addr_r} ${ramdisk_addr_r} ${fdt_addr_r}
     infname = os.path.join(cons.config.source_dir,
                             'test/py/tests/bootstd/armbian.bmp.xz')
     bmp_file = os.path.join(bootdir, 'boot.bmp')
-    u_boot_utils.run_and_log(
+    utils.run_and_log(
         cons,
         ['sh', '-c', f'xz -dc {infname} >{bmp_file}'])
 
     mkimage = cons.config.build_dir + '/tools/mkimage'
-    u_boot_utils.run_and_log(
+    utils.run_and_log(
         cons, f'{mkimage} -C none -A arm -T script -d {cmd_fname} {scr_fname}')
 
     kernel = 'vmlinuz-5.15.63-rockchip64'
@@ -165,16 +165,16 @@ booti ${kernel_addr_r} ${ramdisk_addr_r} ${fdt_addr_r}
     symlink = os.path.join(bootdir, 'Image')
     if os.path.exists(symlink):
         os.remove(symlink)
-    u_boot_utils.run_and_log(
+    utils.run_and_log(
         cons, f'echo here {kernel} {symlink}')
     os.symlink(kernel, symlink)
 
     fsfile = 'ext18M.img'
-    u_boot_utils.run_and_log(cons, f'fallocate -l 18M {fsfile}')
-    u_boot_utils.run_and_log(cons, f'mkfs.ext4 {fsfile} -d {mnt}')
-    u_boot_utils.run_and_log(cons, f'dd if={fsfile} of={fname} bs=1M seek=1')
-    u_boot_utils.run_and_log(cons, f'rm -rf {mnt}')
-    u_boot_utils.run_and_log(cons, f'rm -f {fsfile}')
+    utils.run_and_log(cons, f'fallocate -l 18M {fsfile}')
+    utils.run_and_log(cons, f'mkfs.ext4 {fsfile} -d {mnt}')
+    utils.run_and_log(cons, f'dd if={fsfile} of={fname} bs=1M seek=1')
+    utils.run_and_log(cons, f'rm -rf {mnt}')
+    utils.run_and_log(cons, f'rm -f {fsfile}')
 
 def setup_bootflow_image(cons):
     """Create a 20MB disk image with a single FAT partition"""
@@ -208,7 +208,7 @@ label Fedora-Workstation-armhfp-31-1.9 (5.3.7-301.fc31.armv7hl)
     with open(inf, 'wb') as fd:
         fd.write(gzip.compress(b'vmlinux'))
     mkimage = cons.config.build_dir + '/tools/mkimage'
-    u_boot_utils.run_and_log(
+    utils.run_and_log(
         cons, f'{mkimage} -f auto -d {inf} {os.path.join(mnt, vmlinux)}')
 
     with open(os.path.join(mnt, initrd), 'w', encoding='ascii') as fd:
@@ -217,16 +217,16 @@ label Fedora-Workstation-armhfp-31-1.9 (5.3.7-301.fc31.armv7hl)
     mkdir_cond(os.path.join(mnt, dtbdir))
 
     dtb_file = os.path.join(mnt, f'{dtbdir}/sandbox.dtb')
-    u_boot_utils.run_and_log(
+    utils.run_and_log(
         cons, f'dtc -o {dtb_file}', stdin=b'/dts-v1/; / {};')
 
     fsfile = 'vfat18M.img'
-    u_boot_utils.run_and_log(cons, f'fallocate -l 18M {fsfile}')
-    u_boot_utils.run_and_log(cons, f'mkfs.vfat {fsfile}')
-    u_boot_utils.run_and_log(cons, ['sh', '-c', f'mcopy -i {fsfile} {mnt}/* ::/'])
-    u_boot_utils.run_and_log(cons, f'dd if={fsfile} of={fname} bs=1M seek=1')
-    u_boot_utils.run_and_log(cons, f'rm -rf {mnt}')
-    u_boot_utils.run_and_log(cons, f'rm -f {fsfile}')
+    utils.run_and_log(cons, f'fallocate -l 18M {fsfile}')
+    utils.run_and_log(cons, f'mkfs.vfat {fsfile}')
+    utils.run_and_log(cons, ['sh', '-c', f'mcopy -i {fsfile} {mnt}/* ::/'])
+    utils.run_and_log(cons, f'dd if={fsfile} of={fname} bs=1M seek=1')
+    utils.run_and_log(cons, f'rm -rf {mnt}')
+    utils.run_and_log(cons, f'rm -f {fsfile}')
 
 def setup_cros_image(cons):
     """Create a 20MB disk image with ChromiumOS partitions"""
@@ -248,7 +248,7 @@ def setup_cros_image(cons):
         """
         kern_part = os.path.join(cons.config.result_dir,
                                  f'kern-part-{arch}.bin')
-        u_boot_utils.run_and_log(
+        utils.run_and_log(
             cons,
             f'futility vbutil_kernel --pack {kern_part} '
             '--keyblock doc/chromium/files/devkeys/kernel.keyblock '
@@ -276,8 +276,8 @@ def setup_cros_image(cons):
 
     mmc_dev = 5
     fname = os.path.join(cons.config.source_dir, f'mmc{mmc_dev}.img')
-    u_boot_utils.run_and_log(cons, f'qemu-img create {fname} 20M')
-    u_boot_utils.run_and_log(cons, f'cgpt create {fname}')
+    utils.run_and_log(cons, f'qemu-img create {fname} 20M')
+    utils.run_and_log(cons, f'cgpt create {fname}')
 
     uuid_state = 'ebd0a0a2-b9e5-4433-87c0-68b6b72699c7'
     uuid_kern = 'fe3a2a5d-4f32-41a7-b725-accc3285a309'
@@ -316,13 +316,13 @@ def setup_cros_image(cons):
             size = int(size_str[:-1]) * sect_1mb
         else:
             size = int(size_str)
-        u_boot_utils.run_and_log(
+        utils.run_and_log(
             cons,
             f"cgpt add -i {part['num']} -b {ptr} -s {size} -t {part['type']} {fname}")
         ptr += size
 
-    u_boot_utils.run_and_log(cons, f'cgpt boot -p {fname}')
-    out = u_boot_utils.run_and_log(cons, f'cgpt show -q {fname}')
+    utils.run_and_log(cons, f'cgpt boot -p {fname}')
+    out = utils.run_and_log(cons, f'cgpt show -q {fname}')
 
     # We expect something like this:
     #   8239        2048       1  Basic data
@@ -389,8 +389,8 @@ def setup_android_image(cons):
 
     mmc_dev = 7
     fname = os.path.join(cons.config.source_dir, f'mmc{mmc_dev}.img')
-    u_boot_utils.run_and_log(cons, f'qemu-img create {fname} 20M')
-    u_boot_utils.run_and_log(cons, f'cgpt create {fname}')
+    utils.run_and_log(cons, f'qemu-img create {fname} 20M')
+    utils.run_and_log(cons, f'cgpt create {fname}')
 
     ptr = 40
 
@@ -412,13 +412,13 @@ def setup_android_image(cons):
             size = int(size_str[:-1]) * sect_1mb
         else:
             size = int(size_str)
-        u_boot_utils.run_and_log(
+        utils.run_and_log(
             cons,
             f"cgpt add -i {part['num']} -b {ptr} -s {size} -l {part['label']} -t basicdata {fname}")
         ptr += size
 
-    u_boot_utils.run_and_log(cons, f'cgpt boot -p {fname}')
-    out = u_boot_utils.run_and_log(cons, f'cgpt show -q {fname}')
+    utils.run_and_log(cons, f'cgpt boot -p {fname}')
+    out = utils.run_and_log(cons, f'cgpt show -q {fname}')
 
     # Create a dict (indexed by partition number) containing the above info
     for line in out.splitlines():
@@ -445,8 +445,8 @@ def setup_android_image(cons):
 
     mmc_dev = 8
     fname = os.path.join(cons.config.source_dir, f'mmc{mmc_dev}.img')
-    u_boot_utils.run_and_log(cons, f'qemu-img create {fname} 20M')
-    u_boot_utils.run_and_log(cons, f'cgpt create {fname}')
+    utils.run_and_log(cons, f'qemu-img create {fname} 20M')
+    utils.run_and_log(cons, f'cgpt create {fname}')
 
     ptr = 40
 
@@ -466,13 +466,13 @@ def setup_android_image(cons):
             size = int(size_str[:-1]) * sect_1mb
         else:
             size = int(size_str)
-        u_boot_utils.run_and_log(
+        utils.run_and_log(
             cons,
             f"cgpt add -i {part['num']} -b {ptr} -s {size} -l {part['label']} -t basicdata {fname}")
         ptr += size
 
-    u_boot_utils.run_and_log(cons, f'cgpt boot -p {fname}')
-    out = u_boot_utils.run_and_log(cons, f'cgpt show -q {fname}')
+    utils.run_and_log(cons, f'cgpt boot -p {fname}')
+    out = utils.run_and_log(cons, f'cgpt show -q {fname}')
 
     # Create a dict (indexed by partition number) containing the above info
     for line in out.splitlines():
@@ -502,7 +502,7 @@ def setup_cedit_file(cons):
                            'test/boot/files/expo_ids.h')
     expo_tool = os.path.join(cons.config.source_dir, 'tools/expo.py')
     outfname = 'cedit.dtb'
-    u_boot_utils.run_and_log(
+    utils.run_and_log(
         cons, f'{expo_tool} -e {inhname} -l {infname} -o {outfname}')
 
 @pytest.mark.buildconfigspec('ut_dm')
@@ -528,7 +528,7 @@ def test_ut_dm_init(ubpy):
         data = b'\x00' * (2 * 1024 * 1024)
         with open(fn, 'wb') as fh:
             fh.write(data)
-        u_boot_utils.run_and_log(
+        utils.run_and_log(
             ubpy, f'sfdisk {fn}', stdin=b'type=83')
 
     fs_helper.mk_fs(ubpy.config, 'ext2', 0x200000, '2MB', None)
@@ -559,12 +559,12 @@ def setup_efi_image(cons):
         with open(efi_dst, 'wb') as outf:
             outf.write(inf.read())
     fsfile = 'vfat18M.img'
-    u_boot_utils.run_and_log(cons, f'fallocate -l 18M {fsfile}')
-    u_boot_utils.run_and_log(cons, f'mkfs.vfat {fsfile}')
-    u_boot_utils.run_and_log(cons, ['sh', '-c', f'mcopy -vs -i {fsfile} {mnt}/* ::/'])
-    u_boot_utils.run_and_log(cons, f'dd if={fsfile} of={fname} bs=1M seek=1')
-    u_boot_utils.run_and_log(cons, f'rm -rf {mnt}')
-    u_boot_utils.run_and_log(cons, f'rm -f {fsfile}')
+    utils.run_and_log(cons, f'fallocate -l 18M {fsfile}')
+    utils.run_and_log(cons, f'mkfs.vfat {fsfile}')
+    utils.run_and_log(cons, ['sh', '-c', f'mcopy -vs -i {fsfile} {mnt}/* ::/'])
+    utils.run_and_log(cons, f'dd if={fsfile} of={fname} bs=1M seek=1')
+    utils.run_and_log(cons, f'rm -rf {mnt}')
+    utils.run_and_log(cons, f'rm -f {fsfile}')
 
 @pytest.mark.buildconfigspec('cmd_bootflow')
 @pytest.mark.buildconfigspec('sandbox')
diff --git a/test/py/tests/test_vbe_vpl.py b/test/py/tests/test_vbe_vpl.py
index 7e25924e4e7..313c2f93e18 100644
--- a/test/py/tests/test_vbe_vpl.py
+++ b/test/py/tests/test_vbe_vpl.py
@@ -6,7 +6,7 @@
 import os
 
 import pytest
-import u_boot_utils
+import utils
 
 @pytest.mark.boardspec('sandbox_vpl')
 @pytest.mark.requiredtool('dtc')
@@ -19,13 +19,13 @@ def test_vbe_vpl(ubpy):
 
     # Enable firmware1 and the mmc that it uses. These are needed for the full
     # VBE flow.
-    u_boot_utils.run_and_log(
+    utils.run_and_log(
         cons, f'fdtput -t s {fdt} /bootstd/firmware0 status disabled')
-    u_boot_utils.run_and_log(
+    utils.run_and_log(
         cons, f'fdtput -t s {fdt} /bootstd/firmware1 status okay')
-    u_boot_utils.run_and_log(
+    utils.run_and_log(
         cons, f'fdtput -t s {fdt} /mmc3 status okay')
-    u_boot_utils.run_and_log(
+    utils.run_and_log(
         cons, f'fdtput -t s {fdt} /mmc3 filename {image_fname}')
 
     # Remove any existing RAM file, so we don't have old data present
diff --git a/test/py/tests/test_vboot.py b/test/py/tests/test_vboot.py
index 72472914f2c..ffc6477c173 100644
--- a/test/py/tests/test_vboot.py
+++ b/test/py/tests/test_vboot.py
@@ -42,7 +42,7 @@ import os
 import shutil
 import struct
 import pytest
-import u_boot_utils as util
+import utils as util
 import vboot_forge
 import vboot_evil
 
diff --git a/test/py/tests/test_zynq_secure.py b/test/py/tests/test_zynq_secure.py
index 17b2ea39e8d..b1041d236bb 100644
--- a/test/py/tests/test_zynq_secure.py
+++ b/test/py/tests/test_zynq_secure.py
@@ -3,7 +3,7 @@
 
 import pytest
 import re
-import u_boot_utils
+import utils
 import test_net
 
 """
@@ -68,7 +68,7 @@ def test_zynq_aes_image(ubpy):
 
     srcaddr = f.get('srcaddr', None)
     if not srcaddr:
-        addr = u_boot_utils.find_ram_base(ubpy)
+        addr = utils.find_ram_base(ubpy)
 
     expected_tftp = 'Bytes transferred = '
     fn = f['fn']
@@ -96,7 +96,7 @@ def test_zynq_aes_bitstream(ubpy):
 
     srcaddr = f.get('srcaddr', None)
     if not srcaddr:
-        addr = u_boot_utils.find_ram_base(ubpy)
+        addr = utils.find_ram_base(ubpy)
 
     expected_tftp = 'Bytes transferred = '
     fn = f['fnbit']
@@ -124,7 +124,7 @@ def test_zynq_aes_partial_bitstream(ubpy):
 
     srcaddr = f.get('srcaddr', None)
     if not srcaddr:
-        addr = u_boot_utils.find_ram_base(ubpy)
+        addr = utils.find_ram_base(ubpy)
 
     expected_tftp = 'Bytes transferred = '
     fn = f['fnpbit']
@@ -150,7 +150,7 @@ def test_zynq_rsa_image(ubpy):
 
     srcaddr = f.get('srcaddr', None)
     if not srcaddr:
-        addr = u_boot_utils.find_ram_base(ubpy)
+        addr = utils.find_ram_base(ubpy)
 
     expected_tftp = 'Bytes transferred = '
     fn = f['fn']
@@ -176,7 +176,7 @@ def test_zynq_rsa_image_invalid(ubpy):
 
     srcaddr = f.get('srcaddr', None)
     if not srcaddr:
-        addr = u_boot_utils.find_ram_base(ubpy)
+        addr = utils.find_ram_base(ubpy)
 
     expected_tftp = 'Bytes transferred = '
     fninvalid = f['fninvalid']
diff --git a/test/py/tests/test_zynqmp_secure.py b/test/py/tests/test_zynqmp_secure.py
index e2b6ac5a221..c6ccc6ba0bc 100644
--- a/test/py/tests/test_zynqmp_secure.py
+++ b/test/py/tests/test_zynqmp_secure.py
@@ -3,7 +3,7 @@
 
 import pytest
 import re
-import u_boot_utils
+import utils
 import test_net
 
 """
@@ -45,7 +45,7 @@ def test_zynqmp_secure_boot_image(ubpy):
 
     addr = f.get('addr', None)
     if not addr:
-        addr = u_boot_utils.find_ram_base(ubpy)
+        addr = utils.find_ram_base(ubpy)
 
     expected_tftp = 'Bytes transferred = '
     fn = f['fn']
@@ -78,7 +78,7 @@ def test_zynqmp_secure_boot_img_kup(ubpy):
 
     keyaddr = f.get('keyaddr', None)
     if not keyaddr:
-        addr = u_boot_utils.find_ram_base(ubpy)
+        addr = utils.find_ram_base(ubpy)
     expected_tftp = 'Bytes transferred = '
     keyfn = f['keyfn']
     output = ubpy.run_command('tftpboot %x %s' % (keyaddr, keyfn))
@@ -86,7 +86,7 @@ def test_zynqmp_secure_boot_img_kup(ubpy):
 
     addr = f.get('addr', None)
     if not addr:
-        addr = u_boot_utils.find_ram_base(ubpy)
+        addr = utils.find_ram_base(ubpy)
     expected_tftp = 'Bytes transferred = '
     fn = f['enckupfn']
     output = ubpy.run_command('tftpboot %x %s' % (addr, fn))
diff --git a/test/py/u_boot_utils.py b/test/py/utils.py
similarity index 100%
rename from test/py/u_boot_utils.py
rename to test/py/utils.py
-- 
2.43.0

