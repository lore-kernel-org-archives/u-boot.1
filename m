Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03795C369DC
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 13:24:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 501BE8295C;
	Tue, 29 Apr 2025 15:24:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="afawXFu3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39B058215E; Tue, 29 Apr 2025 15:24:06 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8C7F828A2
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 15:24:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7304efb4b3bso3301459a34.0
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 06:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745933042; x=1746537842; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CFhwPVJREwAKur8GGyrXBJ+3Io0f0JYxNuxNB2VQKcQ=;
 b=afawXFu31DBLSxy43X4BIcGRsqY1B+MFGaMR6/VoTtY7+VgbuoGum2XLXETZhODZES
 EhaqxqQ9jC3uEL2LS5Vyx8k+NMia9Xgj3kaLeiIpcqd74HZ4iI4UF/j7+3TJgMAME+jY
 BqFxu+/MP1zggiRACyENXn/HrvvWttAG/ugDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745933042; x=1746537842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CFhwPVJREwAKur8GGyrXBJ+3Io0f0JYxNuxNB2VQKcQ=;
 b=ZvedXIU/bY/j9YO+8O4n9WShU7Ubjn76i4MQwyGdGD4lC0ekioYr16rgtK9xyPiXWO
 6riLVFabkhukKGh7TA9YHBTz+SW7oYlcb3r0ECPlcu/U75We/lc7VbLLp3yOCs0/P9Rh
 uoWYBGfZuOsGAXVRm60ZiO9tvVrKH+I0euBsZ7S9kM0+U+egAz5Y3IrwCLwzUaUM55Lh
 Oukm8Vjt8esvtVZZWZpEJ4zmzJ9KBzpLjWwwnba/6BI0U4AgHuyQYZTwbuNRMQr34/HU
 qzYngI1k0u5QCURVYUGuQFYq+T1UM853o96kigMVPpWbH1VApPYtGPGtW87YdFyCcm2j
 nwBA==
X-Gm-Message-State: AOJu0YwnWSj+S1sMhdkShKGVhJeIE+xAcJbWxdyTpTx1hd1sAfXtHFrc
 YKfiFi+DTdc6PJIR/qFe3fI7CkZ0iCXzHL+QDsjBYuANztC5F6WAP5pAiAAjJ6+xs1fI9U87zHA
 =
X-Gm-Gg: ASbGncuhztZ+c5eMuUeFkz7PaRu5KvWcYFDTxRvpkWQbORoysnTZUMW3WPK6HBGxyoU
 UoAzVgqK6V10BVmUuJcuGiuq5MZ5Aq1uwKRWaUc3Hh8b/zchrWTsVtcuTB+j8YqJwcJpbk9LeOp
 C6Zz/kw4cmZOxdkF1QHkSiIwiJn24armUciTg27llRBgeiIAT6qDZHkIqBW3wk3M8sooYzT+4Cs
 GImeWLWCt8Sm3rJO1p6qGGHcTYNX66NJtrmJX63QeVu7hb8Mop167g/jDs0TuTQnQBZ+JaQPYp1
 reuwfruh5gfJFYrk3KKFu6bH99cALabYwQ9xedtEXcl20vnKCIYzD3x8omN9J3+HN0EHjV/aTBt
 nFQ==
X-Google-Smtp-Source: AGHT+IHcDyUtiQ1ZZog7K/vMR8vuQGElBuIAZCKf8hPCzExz+M+HGudIXSyPM4ULvLKjAXhQhRKF4w==
X-Received: by 2002:a05:6830:4111:b0:72b:9ce5:6da6 with SMTP id
 46e09a7af769-7308a514f36mr1478816a34.9.1745933041973; 
 Tue, 29 Apr 2025 06:24:01 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7308b117371sm277320a34.16.2025.04.29.06.23.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 06:24:00 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Kochetkov <al.kochet@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 09/30] tools: Plumb in capture control
Date: Tue, 29 Apr 2025 07:22:06 -0600
Message-ID: <20250429132239.251756-10-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429132239.251756-1-sjg@chromium.org>
References: <20250429132239.251756-1-sjg@chromium.org>
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

Add control of capturing output into u_boot_pylib and the tools which
use it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/ftest.py           |  3 ++-
 tools/binman/main.py            |  4 ++--
 tools/buildman/main.py          |  2 +-
 tools/dtoc/main.py              |  5 +++--
 tools/dtoc/test_fdt.py          |  2 +-
 tools/patman/__main__.py        |  2 +-
 tools/u_boot_pylib/__main__.py  |  2 +-
 tools/u_boot_pylib/test_util.py | 10 +++++++---
 8 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 3fb7416a567..f20a9d9bb54 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -270,7 +270,7 @@ class TestFunctional(unittest.TestCase):
 
     @classmethod
     def setup_test_args(cls, preserve_indir=False, preserve_outdirs=False,
-                        toolpath=None, verbosity=None):
+                        toolpath=None, verbosity=None, no_capture=False):
         """Accept arguments controlling test execution
 
         Args:
@@ -285,6 +285,7 @@ class TestFunctional(unittest.TestCase):
         cls.preserve_outdirs = preserve_outdirs
         cls.toolpath = toolpath
         cls.verbosity = verbosity
+        cls.no_capture = no_capture
 
     def _CheckBintool(self, bintool):
         if not bintool.is_present():
diff --git a/tools/binman/main.py b/tools/binman/main.py
index 326f5c93155..fa5ad79ca0e 100755
--- a/tools/binman/main.py
+++ b/tools/binman/main.py
@@ -77,8 +77,8 @@ def RunTests(debug, verbosity, processes, test_preserve_dirs, args, toolpath):
     # Run the entry tests first ,since these need to be the first to import the
     # 'entry' module.
     result = test_util.run_test_suites(
-        'binman', debug, verbosity, test_preserve_dirs, processes, test_name,
-        toolpath,
+        'binman', debug, verbosity, False, test_preserve_dirs, processes,
+        test_name, toolpath,
         [bintool_test.TestBintool, entry_test.TestEntry, ftest.TestFunctional,
          fdt_test.TestFdt, elf_test.TestElf, image_test.TestImage,
          cbfs_util_test.TestCbfs, fip_util_test.TestFip])
diff --git a/tools/buildman/main.py b/tools/buildman/main.py
index 72571b226d9..77b9bebed27 100755
--- a/tools/buildman/main.py
+++ b/tools/buildman/main.py
@@ -49,7 +49,7 @@ def run_tests(skip_net_tests, debug, verbose, args):
     # Run the entry tests first ,since these need to be the first to import the
     # 'entry' module.
     result = test_util.run_test_suites(
-        'buildman', debug, verbose, False, args.threads, test_name, [],
+        'buildman', debug, verbose, False, False, args.threads, test_name, [],
         [test.TestBuild, func_test.TestFunctional, 'buildman.toolchain'])
 
     return (0 if result.wasSuccessful() else 1)
diff --git a/tools/dtoc/main.py b/tools/dtoc/main.py
index 6c91450410e..59b98b0fa9f 100755
--- a/tools/dtoc/main.py
+++ b/tools/dtoc/main.py
@@ -58,8 +58,9 @@ def run_tests(processes, args):
     test_dtoc.setup()
 
     result = test_util.run_test_suites(
-        toolname='dtoc', debug=True, verbosity=1, test_preserve_dirs=False,
-        processes=processes, test_name=test_name, toolpath=[],
+        toolname='dtoc', debug=True, verbosity=1, no_capture=False,
+        test_preserve_dirs=False, processes=processes, test_name=test_name,
+        toolpath=[],
         class_and_module_list=[test_dtoc.TestDtoc,test_src_scan.TestSrcScan])
 
     return (0 if result.wasSuccessful() else 1)
diff --git a/tools/dtoc/test_fdt.py b/tools/dtoc/test_fdt.py
index 0b01518f3a5..a0bed4e18bb 100755
--- a/tools/dtoc/test_fdt.py
+++ b/tools/dtoc/test_fdt.py
@@ -969,7 +969,7 @@ def run_tests(names, processes):
     """
     test_name = names[0] if names else None
     result = test_util.run_test_suites(
-        'test_fdt', False, False, False, processes, test_name, None,
+        'test_fdt', False, False, False, False, processes, test_name, None,
         [TestFdt, TestNode, TestProp, TestFdtUtil])
 
     return (0 if result.wasSuccessful() else 1)
diff --git a/tools/patman/__main__.py b/tools/patman/__main__.py
index 0d08a53cbab..db78ea603c2 100755
--- a/tools/patman/__main__.py
+++ b/tools/patman/__main__.py
@@ -38,7 +38,7 @@ def run_patman():
         from patman import test_checkpatch
 
         result = test_util.run_test_suites(
-            'patman', False, False, False, None, None, None,
+            'patman', False, False, False, False, None, None, None,
             [test_checkpatch.TestPatch, func_test.TestFunctional,
              'settings'])
 
diff --git a/tools/u_boot_pylib/__main__.py b/tools/u_boot_pylib/__main__.py
index c0762bca733..d86b9d7dce0 100755
--- a/tools/u_boot_pylib/__main__.py
+++ b/tools/u_boot_pylib/__main__.py
@@ -16,7 +16,7 @@ if __name__ == "__main__":
     from u_boot_pylib import test_util
 
     result = test_util.run_test_suites(
-        'u_boot_pylib', False, False, False, None, None, None,
+        'u_boot_pylib', False, False, False, False, None, None, None,
         ['terminal'])
 
     sys.exit(0 if result.wasSuccessful() else 1)
diff --git a/tools/u_boot_pylib/test_util.py b/tools/u_boot_pylib/test_util.py
index 119ae60af33..3f7e5ece4e9 100644
--- a/tools/u_boot_pylib/test_util.py
+++ b/tools/u_boot_pylib/test_util.py
@@ -12,6 +12,7 @@ import sys
 import unittest
 
 from u_boot_pylib import command
+from u_boot_pylib import terminal
 
 use_concurrent = True
 try:
@@ -155,8 +156,8 @@ class FullTextTestResult(unittest.TextTestResult):
         super().addSkip(test, reason)
 
 
-def run_test_suites(toolname, debug, verbosity, test_preserve_dirs, processes,
-                    test_name, toolpath, class_and_module_list):
+def run_test_suites(toolname, debug, verbosity, no_capture, test_preserve_dirs,
+                    processes, test_name, toolpath, class_and_module_list):
     """Run a series of test suites and collect the results
 
     Args:
@@ -179,6 +180,9 @@ def run_test_suites(toolname, debug, verbosity, test_preserve_dirs, processes,
         sys.argv.append('-D')
     if verbosity:
         sys.argv.append('-v%d' % verbosity)
+    if no_capture:
+        sys.argv.append('-N')
+        terminal.USE_CAPTURE = False
     if toolpath:
         for path in toolpath:
             sys.argv += ['--toolpath', path]
@@ -207,7 +211,7 @@ def run_test_suites(toolname, debug, verbosity, test_preserve_dirs, processes,
             setup_test_args = getattr(module, 'setup_test_args')
             setup_test_args(preserve_indir=test_preserve_dirs,
                 preserve_outdirs=test_preserve_dirs and test_name is not None,
-                toolpath=toolpath, verbosity=verbosity)
+                toolpath=toolpath, verbosity=verbosity, no_capture=no_capture)
         if test_name:
             # Since Python v3.5 If an ImportError or AttributeError occurs
             # while traversing a name then a synthetic test that raises that
-- 
2.43.0

