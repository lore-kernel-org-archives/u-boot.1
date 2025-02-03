Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7D74C02195
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 16:27:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC1C980562;
	Mon,  3 Feb 2025 17:27:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XjVJM/hL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E26380391; Mon,  3 Feb 2025 17:27:25 +0100 (CET)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2601801BE
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 17:27:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3d01896fa3bso25835835ab.3
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 08:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738600041; x=1739204841; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZipkgwauIDhyTeetnRaysTdljShuPhoVZbleBZVuwe8=;
 b=XjVJM/hLiI3f9gVrYIJyYKuFhc4izfjI3DRDfSMCTnspEV1f9ofZsShnzH43eQke3F
 ITuQGFT4JAjwS2biSH5Ote4eqABrNCmcgdrkS82RhiCL1CYrEChmh+ospJi5BFyZMTPL
 DoXQ34iXIWugH+L2TjnmZ/5KnZcPjz0fgxcPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738600041; x=1739204841;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZipkgwauIDhyTeetnRaysTdljShuPhoVZbleBZVuwe8=;
 b=luf5Ghr1jAIOjPKrMktLYuw1Z1Vm8ugdZP9qz/97il8lBcyBneepxymalzb716Aj1l
 dKz2h7xHeOeL/qQsWhpKEKoZmxROGtrj/NFZCE7EUgaYGTaFM6GjTTSGKyEYJKRB1LZc
 WgHBe/WJHTCOp5Zq4OIJtc7eniztlo2d+zN9ugxQsda2W+xAeY6EiDPtgkaiSRMwDAkP
 tN9jIehULTASTMAjoAU1xNtmaVGNjexL1TQDRvV1uz+AIypzc456xzbuFniXmuK+ZPuC
 4TAmcpk2ThAMKbbrWMW8PXWtGLTjmJw5LQt/qXBZN72DlAOOkkNz+VEBAEaTEOTwoj6k
 PsPQ==
X-Gm-Message-State: AOJu0Yyg/Il16+Jb12LwlpADgQv20EfBV2m9xf3QeZPNoHmxGA70NxTC
 qSJ8FJR7Yf5Kdt+n7pDXGoYDgm9P0nxeBfBb8rIIbzTsggeYRdGowyx/zpE/CB2vjzgHNVVF4eE
 =
X-Gm-Gg: ASbGnctYkMh20KKtCpEtApUHAM+0QmPHCwrNyiVP3ey+ylnXgQDmxbFTgKZum4uXpU0
 rCAKYwIlV6NSijvz47/mfPgJoZ3r5YcLfLC3srfgYe9Ac17UcSZW/K4FUI9szy4gRZw5bynil1K
 17WpFIzbXVyL6veOXrDbW0uImxyICZsEt4uWMdi0iJiURpbILwXO85ZjZLHKjFtI/632UmNhniR
 3CrdeUcTleYMOpu5yqrnmXbjUgEHdzGYVWUbvUOnNEaQQtTYI9xZw94DZJMUnxOtAdOyCkexPYH
 4uokRk6RtCWVUpwtRk7rLKi1UT7C49ynAJ3Hku+GDJBpKSIBEgtu
X-Google-Smtp-Source: AGHT+IF8BUcZhosO65LgdEP9L5LvdmuMvitPZyq2ymVGiD3qARb2q3t+xvZg3K4kEu3Sq5lOco/pZg==
X-Received: by 2002:a05:6e02:1387:b0:3d0:239a:c46a with SMTP id
 e9e14a558f8ab-3d0239acdc7mr81622185ab.9.1738600039281; 
 Mon, 03 Feb 2025 08:27:19 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d01da7e688sm15935735ab.33.2025.02.03.08.27.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 08:27:17 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Kochetkov <al.kochet@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/4] u_boot_pylib: Correct case for test_result
Date: Mon,  3 Feb 2025 09:26:42 -0700
Message-ID: <20250203162704.627469-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250203162704.627469-1-sjg@chromium.org>
References: <20250203162704.627469-1-sjg@chromium.org>
MIME-Version: 1.0
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

This should be in capitals and defined at the start of the file. Update
it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/ftest.py         | 14 +++++++-------
 tools/buildman/func_test.py   | 10 +++++-----
 tools/u_boot_pylib/command.py | 23 +++++++++++------------
 3 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 156567ace77..803f7599c58 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -303,7 +303,7 @@ class TestFunctional(unittest.TestCase):
     def setUp(self):
         # Enable this to turn on debugging output
         # tout.init(tout.DEBUG)
-        command.test_result = None
+        command.TEST_RESULT = None
 
     def tearDown(self):
         """Remove the temporary output directory"""
@@ -780,11 +780,11 @@ class TestFunctional(unittest.TestCase):
     def testFullHelpInternal(self):
         """Test that the full help is displayed with -H"""
         try:
-            command.test_result = command.CommandResult()
+            command.TEST_RESULT = command.CommandResult()
             result = self._DoBinman('-H')
             help_file = os.path.join(self._binman_dir, 'README.rst')
         finally:
-            command.test_result = None
+            command.TEST_RESULT = None
 
     def testHelp(self):
         """Test that the basic help is displayed with -h"""
@@ -1872,7 +1872,7 @@ class TestFunctional(unittest.TestCase):
 
     def testGbb(self):
         """Test for the Chromium OS Google Binary Block"""
-        command.test_result = self._HandleGbbCommand
+        command.TEST_RESULT = self._HandleGbbCommand
         entry_args = {
             'keydir': 'devkeys',
             'bmpblk': 'bmpblk.bin',
@@ -1941,7 +1941,7 @@ class TestFunctional(unittest.TestCase):
     def testVblock(self):
         """Test for the Chromium OS Verified Boot Block"""
         self._hash_data = False
-        command.test_result = self._HandleVblockCommand
+        command.TEST_RESULT = self._HandleVblockCommand
         entry_args = {
             'keydir': 'devkeys',
         }
@@ -1974,7 +1974,7 @@ class TestFunctional(unittest.TestCase):
     def testVblockContent(self):
         """Test that the vblock signs the right data"""
         self._hash_data = True
-        command.test_result = self._HandleVblockCommand
+        command.TEST_RESULT = self._HandleVblockCommand
         entry_args = {
             'keydir': 'devkeys',
         }
@@ -5474,7 +5474,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
     def testFitSubentryUsesBintool(self):
         """Test that binman FIT subentries can use bintools"""
-        command.test_result = self._HandleGbbCommand
+        command.TEST_RESULT = self._HandleGbbCommand
         entry_args = {
             'keydir': 'devkeys',
             'bmpblk': 'bmpblk.bin',
diff --git a/tools/buildman/func_test.py b/tools/buildman/func_test.py
index 03a4536d69c..b2edda9f492 100644
--- a/tools/buildman/func_test.py
+++ b/tools/buildman/func_test.py
@@ -187,7 +187,7 @@ class TestFunctional(unittest.TestCase):
         self._git_dir = os.path.join(self._base_dir, 'src')
         self._buildman_pathname = sys.argv[0]
         self._buildman_dir = os.path.dirname(os.path.realpath(sys.argv[0]))
-        command.test_result = self._HandleCommand
+        command.TEST_RESULT = self._HandleCommand
         bsettings.setup(None)
         bsettings.add_file(settings_data)
         self.setupToolchains()
@@ -266,7 +266,7 @@ class TestFunctional(unittest.TestCase):
         return result
 
     def testFullHelp(self):
-        command.test_result = None
+        command.TEST_RESULT = None
         result = self._RunBuildman('-H')
         help_file = os.path.join(self._buildman_dir, 'README.rst')
         # Remove possible extraneous strings
@@ -277,7 +277,7 @@ class TestFunctional(unittest.TestCase):
         self.assertEqual(0, result.return_code)
 
     def testHelp(self):
-        command.test_result = None
+        command.TEST_RESULT = None
         result = self._RunBuildman('-h')
         help_file = os.path.join(self._buildman_dir, 'README.rst')
         self.assertTrue(len(result.stdout) > 1000)
@@ -286,11 +286,11 @@ class TestFunctional(unittest.TestCase):
 
     def testGitSetup(self):
         """Test gitutils.Setup(), from outside the module itself"""
-        command.test_result = command.CommandResult(return_code=1)
+        command.TEST_RESULT = command.CommandResult(return_code=1)
         gitutil.setup()
         self.assertEqual(gitutil.use_no_decorate, False)
 
-        command.test_result = command.CommandResult(return_code=0)
+        command.TEST_RESULT = command.CommandResult(return_code=0)
         gitutil.setup()
         self.assertEqual(gitutil.use_no_decorate, True)
 
diff --git a/tools/u_boot_pylib/command.py b/tools/u_boot_pylib/command.py
index bbe95d86122..103358420dd 100644
--- a/tools/u_boot_pylib/command.py
+++ b/tools/u_boot_pylib/command.py
@@ -6,6 +6,13 @@ import os
 
 from u_boot_pylib import cros_subprocess
 
+# This permits interception of RunPipe for test purposes. If it is set to
+# a function, then that function is called with the pipe list being
+# executed. Otherwise, it is assumed to be a CommandResult object, and is
+# returned as the result for every run_pipe() call.
+# When this value is None, commands are executed as normal.
+TEST_RESULT = None
+
 """Shell command ease-ups for Python."""
 
 class CommandResult:
@@ -32,14 +39,6 @@ class CommandResult:
             self.combined = self.combined.decode('utf-8')
         return self
 
-
-# This permits interception of RunPipe for test purposes. If it is set to
-# a function, then that function is called with the pipe list being
-# executed. Otherwise, it is assumed to be a CommandResult object, and is
-# returned as the result for every run_pipe() call.
-# When this value is None, commands are executed as normal.
-test_result = None
-
 def run_pipe(pipe_list, infile=None, outfile=None,
             capture=False, capture_stderr=False, oneline=False,
             raise_on_error=True, cwd=None, binary=False,
@@ -63,14 +62,14 @@ def run_pipe(pipe_list, infile=None, outfile=None,
     Returns:
         CommandResult object
     """
-    if test_result:
-        if hasattr(test_result, '__call__'):
+    if TEST_RESULT:
+        if hasattr(TEST_RESULT, '__call__'):
             # pylint: disable=E1102
-            result = test_result(pipe_list=pipe_list)
+            result = TEST_RESULT(pipe_list=pipe_list)
             if result:
                 return result
         else:
-            return test_result
+            return TEST_RESULT
         # No result: fall through to normal processing
     result = CommandResult(b'', b'', b'')
     last_pipe = None
-- 
2.43.0

