Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38475C3ABAC
	for <u-boot@archiver.kernel.org>; Sun,  4 May 2025 13:25:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7403C82A56;
	Sun,  4 May 2025 15:24:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PurprsJu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3ED3882A55; Sun,  4 May 2025 15:24:22 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2574882A3B
 for <u-boot@lists.denx.de>; Sun,  4 May 2025 15:24:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-ac339f53df9so750211566b.1
 for <u-boot@lists.denx.de>; Sun, 04 May 2025 06:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746365059; x=1746969859; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RtUI4SeN3kxE/fY9/c0CHJZRRe5jg/dDGqGexAra/ds=;
 b=PurprsJuflNa9dZTON8rhGI9sOhKwpRmoh9yrb4s13Wsyvpn4Z91+OeDfcz8bmFbIS
 5ovp8hBVOxqz//hqOqzreCwgAHXLYQZKRC1w8MONplNWLLkgrqdc38o/soASKDoXm2DQ
 uPZ+zH16h8uHlafOwGIrl5l3GSqyqYo8YVXdk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746365059; x=1746969859;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RtUI4SeN3kxE/fY9/c0CHJZRRe5jg/dDGqGexAra/ds=;
 b=s+LCcqBCSnRcS93Z7cO/j8+D2J+6G/6XBOnFDlmsZGByMvD89AQ/CcpDo0p/uAomkO
 754VheFPvPbFR3JKcyW9cv3Tg7RvdmP5+dJJxk8zlQptfsT2DNy3tt6bi+owHwt8Onfb
 p99K2ukNrsWuHgP1cRzRwmjT+wN7EbTTDMfUNxGxn8lxvBo8JcVT9NDI8I2qlCbuhpR4
 IJufHZECHtM43zX/5tZeiyI7uqKD53nzj+9BsWqf6vD7lOC7E+Yd+HP/DeAmz7dSnEx4
 N8zM+OAS64WmoXMywfS7IDTIF09vqbVK/exSIgIIAZBMJkqhvZ+CEp0idE+PTLRl83WK
 HnjQ==
X-Gm-Message-State: AOJu0YwuxLq3y5ReQMIgDrSl7tbMNHTDvLn2GUW/hxDLxcUsOfA+YFya
 A456kSr41cNTIWtpQ7AEV4VLdWhsg9z5tapt8dGDoGD/Lc1nL2ygYM82EN+ZFPFaRqXqo/Xflax
 UQ6lRJZA=
X-Gm-Gg: ASbGncsj/G0z004hZkPEvsc63Y1ch6HOD1+k8U59ah3wkNajT28DDQc0ifYha7bL9jl
 h0v0T9oB1L0oxKil+xm4Q17JCZUSibImY7ibVmvd2zR+yKrkKY49hoEt8owg33roRaQWYXXTc76
 pb29CqWd/xV8x3EED3kVaT/pbXZ5uwJbWWVFJpsMarh34dQXovVUahOEMLVl0l+i6Qqj/ogXbm6
 tI+PPdiyZoSwTMoy8o5OcNO7aDdvxeHskJJSmqHDlzKYtwJIFHIaQ8gTwDqiWTUJO1DxbdgeOQz
 pRRXGm9PJaKAVYVc7U3e8bvf+lNkva0FAi0b
X-Google-Smtp-Source: AGHT+IEP2yIOHLRWh42nxQCNmi50TbeQU4XtNuuVcuXtJqLBUcRXdP6IPOyZd+arAN7asZaM4GnO4w==
X-Received: by 2002:a17:907:930c:b0:aca:a1c9:d155 with SMTP id
 a640c23a62f3a-ad1a48bc387mr387103066b.11.1746365058631; 
 Sun, 04 May 2025 06:24:18 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad1891f508asm328655666b.85.2025.05.04.06.24.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 06:24:17 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Kochetkov <al.kochet@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 09/30] tools: Plumb in capture control
Date: Sun,  4 May 2025 15:23:25 +0200
Message-ID: <20250504132356.2317305-10-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250504132356.2317305-1-sjg@chromium.org>
References: <20250504132356.2317305-1-sjg@chromium.org>
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

(no changes since v1)

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
index f2f478d5e7e..eb0c4522a94 100644
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
index fc441a78dc1..d258a1935c9 100644
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

