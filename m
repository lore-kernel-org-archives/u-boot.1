Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CE7BCD98ED
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 13:10:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DB3284A0B;
	Thu, 18 Jun 2026 15:09:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=ludwig.nussel@siemens.com header.b="Cas74oIh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 043E3849BB; Thu, 18 Jun 2026 15:09:54 +0200 (CEST)
Received: from mta-65-225.siemens.flowmailer.net
 (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F37F4849DA
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 15:09:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id
 20260618130949e237230617000207d9 for <u-boot@lists.denx.de>;
 Thu, 18 Jun 2026 15:09:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=ludwig.nussel@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=HAeA9BfaKX6ydfAr01sw86PjpLddr4h3awZ4DdqL09o=;
 b=Cas74oIhrgOaU+HiMiKW8cMM/gUfB9DVGWMBaj4AOxzDDkJKG+q4M4pji5p5ejibdyiC7V
 sc0jiWfTW2Nd+aqUMbPzJ0kAMFS5GizFqwLoPWC4QXprk/BqnW2t+2g4KiQeEnGwuzErtlzy
 EQuDMpCEaGa8abtsuPzhSr712b7qSrHUylSVYc8od8VCQ7M42T9E7rIxhxJ9beJOunv2zKVs
 YwhY0/G6ZUy2yDZUr+aXs16GA/hC+H8WWRPMbyg/ayLzyZZO9QAbLIwr5vsasSzXXKsjcv/s
 0LwEFlREPCj+IQClbHnIuAZm3aO3c+DygEeT6bJzB4sCJzSpNok3FWBg==;
From: Ludwig Nussel <ludwig.nussel@siemens.com>
To: u-boot@lists.denx.de
Cc: Ludwig Nussel <ludwig.nussel@siemens.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v7 7/8] test: vboot: refactor run_bootm
Date: Thu, 18 Jun 2026 14:47:42 +0200
Message-ID: <20260618130943.549083-3-ludwig.nussel@siemens.com>
In-Reply-To: <20260618130943.549083-1-ludwig.nussel@siemens.com>
References: <20260618130943.549083-1-ludwig.nussel@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328817:519-21489:flowmailer
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

- split off a generic part of run_bootm. The helper function is for
  future use in similar commands
- moves u-boot restart below section opening for better log structuring
- only look for expected string in last command. This way a failed
  assert() doesn't dump unrelated output.
- use f-strings in the refactored code while at it

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>
---

(no changes since v6)

Changes in v6:
- Add missing return value documentation to run_fit_commands()
- use f-strings for the refactored code
- drop not needed length check for command list

Changes in v5:
- new patch

 test/py/tests/test_vboot.py | 55 +++++++++++++++++++++++++++----------
 1 file changed, 41 insertions(+), 14 deletions(-)

diff --git a/test/py/tests/test_vboot.py b/test/py/tests/test_vboot.py
index 6459c7c313e..df5db157a52 100644
--- a/test/py/tests/test_vboot.py
+++ b/test/py/tests/test_vboot.py
@@ -151,6 +151,39 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
                                  tmpdir, '-I', tmpdir])
         os.environ['PYTHONPATH'] = pythonpath
 
+
+    def run_fit_commands(commands, expect_string, fit=None):
+        """Load fit image and run commands in U-Boot.
+
+        Asserts that 'expect_string' is contained in the output of the last command
+
+        This always starts a fresh U-Boot instance since the device tree may
+        contain a new public key.
+
+        Args:
+            commands: list of commands to run
+            expect_string: A string which is expected in the output
+            fit: FIT filename to load and verify
+
+        Returns:
+            The joined output of the last command run.
+        """
+
+        ubman.restart_uboot()
+
+        if not fit:
+            fit = f'{tmpdir}test.fit'
+        # run commands that just prepare for the actually relevant one
+        ubman.run_command(f'host load hostfs - 100 {fit}')
+        for cmd in commands[:-1]:
+            ubman.run_command(cmd)
+
+        output = ''.join(ubman.run_command(commands[-1]))
+
+        assert expect_string in output
+
+        return output
+
     def run_bootm(sha_algo, test_type, expect_string, boots, fit=None):
         """Run a 'bootm' command U-Boot.
 
@@ -166,20 +199,14 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
                     we are expected to not boot
             fit: FIT filename to load and verify
         """
-        if not fit:
-            fit = '%stest.fit' % tmpdir
-        ubman.restart_uboot()
-        with ubman.log.section('Verified boot %s %s' % (sha_algo, test_type)):
-            output = ubman.run_command_list(
-                ['host load hostfs - 100 %s' % fit,
-                 'fdt addr 100',
-                 'bootm 100'])
-        assert expect_string in ''.join(output)
-        if boots:
-            assert 'sandbox: continuing, as we cannot run' in ''.join(output)
-        else:
-            assert('sandbox: continuing, as we cannot run'
-                   not in ''.join(output))
+
+        with ubman.log.section(f'Verified boot {sha_algo} {test_type}: looking for "{expect_string}"'):
+            output = run_fit_commands(['fdt addr 100', 'bootm 100'], expect_string, fit)
+
+            if boots:
+                assert 'sandbox: continuing, as we cannot run' in output
+            else:
+                assert 'sandbox: continuing, as we cannot run' not in output
 
     def sign_fit(sha_algo, options):
         """Sign the FIT
-- 
2.43.0

