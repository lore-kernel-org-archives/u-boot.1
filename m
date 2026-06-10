Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7FC9CD8CA8
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 01:27:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9ACB849D8;
	Wed, 10 Jun 2026 03:27:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oXiNGXw/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E516849C9; Wed, 10 Jun 2026 03:27:45 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C42D846BE
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 03:27:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+me.samcday.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id AEDE66024D;
 Wed, 10 Jun 2026 01:27:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 60C5BC2BCC7;
 Wed, 10 Jun 2026 01:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1781054861;
 bh=SxC+sNhq1t+meeKQlSq8BfUSxWJDcb50Sw5oR1DIYcU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=oXiNGXw/whSf9wWQm02hRYn9fVwIzKXJHMWIFEKuXesu471kjfL57/xzFEaLjUX3y
 rYMqzD4hd/LwvCj1+nqi53Oe/JYRtHVqURs3+ybj+BSNPl+fL3hhDWc2MwOqQZXofr
 U5NAxqX2ESAMxqBPStoFqora2oPZYN7QEY1gYRkZbEJzBiSrWVPOLpOOGsv9IG9RZV
 SloUz1oOqRBn45j9KhDdEIt9IamCJz9XL0ofGnGtF63aXe+yoWpsi4X7OrTY4FtVni
 rkeZdAHBnyiEclB3mBAcrF7HYctJW7qJsnqFw4P6dbhoOmgcie9K9A0w+c/XxfHAzz
 I2rkorerhToiQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 4F541CD98C8;
 Wed, 10 Jun 2026 01:27:41 +0000 (UTC)
From: Sam Day via B4 Relay <devnull+me.samcday.com@kernel.org>
Date: Wed, 10 Jun 2026 11:27:40 +1000
Subject: [PATCH v3 02/10] binman: test name globbing support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-android-binman-v3-2-710298a38fcc@samcday.com>
References: <20260610-android-binman-v3-0-710298a38fcc@samcday.com>
In-Reply-To: <20260610-android-binman-v3-0-710298a38fcc@samcday.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Bryan Brattlof <bb@ti.com>, 
 Yannic Moog <y.moog@phytec.de>, Wojciech Dubowik <Wojciech.Dubowik@mt.com>, 
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Rasmus Villemoes <ravi@prevas.dk>, Javier Tia <floss@jetm.me>, 
 Minkyu Kang <mk7.kang@samsung.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Henrik Grimler <henrik@grimler.se>, yan wang <yan.wang@softathome.com>, 
 Marek Vasut <marex@nabladev.com>, Denis Mukhin <dmukhin@ford.com>, 
 Sam Day <me@samcday.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781054859; l=3070;
 i=me@samcday.com; s=20240502; h=from:subject:message-id;
 bh=WQnxi6Rd5nSb22GQsdLENqKhq48kpIGbbQvj2Kbi7wI=;
 b=5n0TnMtQSfKkLDEtWDjsTKLc8y5IM6TmM2FfQsJUELnsCRTmc4j3+7vd6LKBIIs9NKqs5Mp7P
 EmpH5waqVe4D7hqxrPw02vnxHKqR/Gx9wxvjNcTxdBDQU6rtwythOSy
X-Developer-Key: i=me@samcday.com; a=ed25519;
 pk=bzyS0akxWMqr9+AXzgBRIp28KKpEOs+GjYMc2yf+aeU=
X-Endpoint-Received: by B4 Relay for me@samcday.com/20240502 with auth_id=595
X-Original-From: Sam Day <me@samcday.com>
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
Reply-To: me@samcday.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Sam Day <me@samcday.com>

This makes invocations like `binman test testAndroid*` possible. It also
composes well with the previous commit that adds support for multiple
test names: `binman test 'testAndroid*' 'testQcdt*'` also works as you'd
expect.
---
 tools/binman/cmdline.py         |  2 +-
 tools/u_boot_pylib/test_util.py | 12 +++++++-----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/tools/binman/cmdline.py b/tools/binman/cmdline.py
index 9632ec115e5..b3be9f79b20 100644
--- a/tools/binman/cmdline.py
+++ b/tools/binman/cmdline.py
@@ -201,7 +201,7 @@ controlled by a description in the board device tree.'''
                  'preserve the output directory if a single test is run (pass '
                  'test name at the end of the command line')
         test_parser.add_argument('tests', nargs='*',
-                                 help='Test names to run (omit for all)')
+                                 help='Test names/patterns to run (omit for all)')
 
     tool_parser = subparsers.add_parser('tool', help='Check bintools')
     tool_parser.add_argument('-l', '--list', action='store_true',
diff --git a/tools/u_boot_pylib/test_util.py b/tools/u_boot_pylib/test_util.py
index ff275a7b7c0..2089b3574ca 100644
--- a/tools/u_boot_pylib/test_util.py
+++ b/tools/u_boot_pylib/test_util.py
@@ -4,6 +4,7 @@
 #
 
 import doctest
+import fnmatch
 import glob
 import multiprocessing
 import os
@@ -186,7 +187,9 @@ def run_test_suites(toolname, debug, verbosity, no_capture, test_preserve_dirs,
         test_names = [test_name]
     else:
         test_names = list(test_name or [])
-    test_name_set = set(test_names)
+
+    def _match_name(name):
+        return any(fnmatch.fnmatchcase(name, pattern) for pattern in test_names)
 
     if use_concurrent and processes != 1 and not test_names:
         suite = ConcurrentTestSuite(suite,
@@ -194,7 +197,7 @@ def run_test_suites(toolname, debug, verbosity, no_capture, test_preserve_dirs,
 
     for module in class_and_module_list:
         if (isinstance(module, str) and
-                (not test_names or module in test_name_set)):
+                (not test_names or _match_name(module))):
             suite.addTests(doctest.DocTestSuite(module))
 
     for module in class_and_module_list:
@@ -211,9 +214,8 @@ def run_test_suites(toolname, debug, verbosity, no_capture, test_preserve_dirs,
             # while traversing a name then a synthetic test that raises that
             # error when run will be returned. Check that the requested test
             # exists, otherwise these errors are included in the results.
-            module_test_names = loader.getTestCaseNames(module)
-            for name in test_names:
-                if name in module_test_names:
+            for name in loader.getTestCaseNames(module):
+                if _match_name(name):
                     suite.addTests(loader.loadTestsFromName(name, module))
         else:
             suite.addTests(loader.loadTestsFromTestCase(module))

-- 
2.54.0


