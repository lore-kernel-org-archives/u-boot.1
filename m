Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A33DEE49AF
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 17:40:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C743E864A4;
	Tue, 22 Aug 2023 19:40:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A069864A4; Tue, 22 Aug 2023 19:40:41 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id E961C86497
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 19:40:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53E1711FB;
 Tue, 22 Aug 2023 10:41:18 -0700 (PDT)
Received: from a076522.blr.arm.com (a076522.blr.arm.com [10.162.46.7])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E30B3F762;
 Tue, 22 Aug 2023 10:40:35 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v11 01/15] binman: bintool: Build a tool from a list of
 commands
Date: Tue, 22 Aug 2023 23:09:54 +0530
Message-Id: <20230822174008.626239-2-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230822174008.626239-1-sughosh.ganu@linaro.org>
References: <20230822174008.626239-1-sughosh.ganu@linaro.org>
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

Add support to build a tool from source with a list of commands. This
is useful when a tool can be built with multiple commands instead of a
single command.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
Changes since V10: None

 tools/binman/bintool.py | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/tools/binman/bintool.py b/tools/binman/bintool.py
index 0b0f56dbbb..3c4ad1adbb 100644
--- a/tools/binman/bintool.py
+++ b/tools/binman/bintool.py
@@ -328,7 +328,7 @@ class Bintool:
             return result.stdout
 
     @classmethod
-    def build_from_git(cls, git_repo, make_target, bintool_path, flags=None):
+    def build_from_git(cls, git_repo, make_targets, bintool_path, flags=None):
         """Build a bintool from a git repo
 
         This clones the repo in a temporary directory, builds it with 'make',
@@ -336,7 +336,8 @@ class Bintool:
 
         Args:
             git_repo (str): URL of git repo
-            make_target (str): Target to pass to 'make' to build the tool
+            make_targets (list of str): List of targets to pass to 'make' to build
+                the tool
             bintool_path (str): Relative path of the tool in the repo, after
                 build is complete
             flags (list of str): Flags or variables to pass to make, or None
@@ -350,12 +351,14 @@ class Bintool:
         tmpdir = tempfile.mkdtemp(prefix='binmanf.')
         print(f"- clone git repo '{git_repo}' to '{tmpdir}'")
         tools.run('git', 'clone', '--depth', '1', git_repo, tmpdir)
-        print(f"- build target '{make_target}'")
-        cmd = ['make', '-C', tmpdir, '-j', f'{multiprocessing.cpu_count()}',
-               make_target]
-        if flags:
-            cmd += flags
-        tools.run(*cmd)
+        for target in make_targets:
+            print(f"- build target '{target}'")
+            cmd = ['make', '-C', tmpdir, '-j', f'{multiprocessing.cpu_count()}',
+                   target]
+            if flags:
+                cmd += flags
+            tools.run(*cmd)
+
         fname = os.path.join(tmpdir, bintool_path)
         if not os.path.exists(fname):
             print(f"- File '{fname}' was not produced")
-- 
2.34.1

