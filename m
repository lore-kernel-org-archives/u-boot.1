Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8D61E77184
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 00:22:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CD908033E;
	Fri, 20 Dec 2024 01:22:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="oPQXFQlv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD2268034E; Fri, 20 Dec 2024 01:22:07 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BCFB8033A
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 01:22:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-111-157.46.114.pool.telefonica.de
 [46.114.111.157])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 522DB3F78B; 
 Fri, 20 Dec 2024 00:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1734654121;
 bh=Bpp6oYe8FRIVtk6If9xcyijmpNIvMVTO5m7TodoZMkQ=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=oPQXFQlvQxWD286rj3dQ86hf0GFBpH1mU/gEpxsTrk98C88pgX/ykmmw4JA1So8d6
 Yi45BV5M1H4l0p8HA4piFP7kruy9PU5KeKk9y6jR/QPHtrwgTW/ip1isXI5UUbVxpc
 L9O9fs+nwwTets/T1NzDp4dwI+udB1URqYOngsvThTqHzuHBlfTrzxEnOd9fcAxg3q
 HorpQqTZInctmP8q7DGZ4j/6vSaAeg7dXJKYKhSWkg9p0sNxAwMmdGn9Y25g5YVd9M
 hgHyimWzHm8BZoMqTza7CspE8o0mdFivKQPNlpDg+6w3X0kjgpg6zpgHkAwqdYyUYg
 KoFT56C3mOO7A==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] buildman: allow specifying configuration fragments
Date: Fri, 20 Dec 2024 01:21:55 +0100
Message-ID: <20241220002156.87780-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
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

Currently we are no able to build with configuration fragments in our CI.
With this patch buildman gets a new argument --fragments for passing a
comma separated list of configuration fragments to add to the board
defconfigs.

    tools/buildman/buildman \
    -o build \
    -k qemu-riscv64_smode \
    --fragments acpi.config

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 tools/buildman/builder.py       |  3 ++-
 tools/buildman/builderthread.py | 18 +++++++++++-------
 tools/buildman/cmdline.py       |  2 ++
 tools/buildman/control.py       |  2 +-
 4 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/tools/buildman/builder.py b/tools/buildman/builder.py
index cbf1345281b..28a25e965ce 100644
--- a/tools/buildman/builder.py
+++ b/tools/buildman/builder.py
@@ -1783,7 +1783,7 @@ class Builder:
                 shutil.rmtree(dirname)
             terminal.print_clear()
 
-    def build_boards(self, commits, board_selected, keep_outputs, verbose):
+    def build_boards(self, commits, board_selected, keep_outputs, verbose, fragments=''):
         """Build all commits for a list of boards
 
         Args:
@@ -1821,6 +1821,7 @@ class Builder:
             job.keep_outputs = keep_outputs
             job.work_in_output = self.work_in_output
             job.adjust_cfg = self.adjust_cfg
+            job.fragments = fragments
             job.step = self._step
             if self.num_threads:
                 self.queue.put(job)
diff --git a/tools/buildman/builderthread.py b/tools/buildman/builderthread.py
index b5afee61aff..090388940f8 100644
--- a/tools/buildman/builderthread.py
+++ b/tools/buildman/builderthread.py
@@ -383,7 +383,7 @@ class BuilderThread(threading.Thread):
 
     def _config_and_build(self, commit_upto, brd, work_dir, do_config, mrproper,
                           config_only, adjust_cfg, commit, out_dir, out_rel_dir,
-                          result):
+                          fragments, result):
         """Do the build, configuring first if necessary
 
         Args:
@@ -397,6 +397,7 @@ class BuilderThread(threading.Thread):
             commit (Commit): Commit only being built
             out_dir (str): Output directory for the build
             out_rel_dir (str): Output directory relatie to the current dir
+            fragments (str): config fragments add to defconfig
             result (CommandResult): Previous result
 
         Returns:
@@ -412,6 +413,8 @@ class BuilderThread(threading.Thread):
         args, cwd, src_dir = self._build_args(brd, out_dir, out_rel_dir,
                                               work_dir, commit_upto)
         config_args = [f'{brd.target}_defconfig']
+        if fragments != None:
+            config_args.extend(fragments.split(','))
         config_out = io.StringIO()
 
         _remove_old_outputs(out_dir)
@@ -450,7 +453,7 @@ class BuilderThread(threading.Thread):
 
     def run_commit(self, commit_upto, brd, work_dir, do_config, mrproper,
                    config_only, force_build, force_build_failures,
-                   work_in_output, adjust_cfg):
+                   work_in_output, adjust_cfg, fragments):
         """Build a particular commit.
 
         If the build is already done, and we are not forcing a build, we skip
@@ -475,6 +478,7 @@ class BuilderThread(threading.Thread):
                      ~C to disable C
                      C=val to set the value of C (val must have quotes if C is
                          a string Kconfig
+            fragments (str): config fragments add to defconfig
 
         Returns:
             tuple containing:
@@ -504,7 +508,7 @@ class BuilderThread(threading.Thread):
                 result, do_config = self._config_and_build(
                     commit_upto, brd, work_dir, do_config, mrproper,
                     config_only, adjust_cfg, commit, out_dir, out_rel_dir,
-                    result)
+                    fragments, result)
             result.already_done = False
 
         result.toolchain = self.toolchain
@@ -697,7 +701,7 @@ class BuilderThread(threading.Thread):
                         self.builder.config_only,
                         force_build or self.builder.force_build,
                         self.builder.force_build_failures,
-                        job.work_in_output, job.adjust_cfg)
+                        job.work_in_output, job.adjust_cfg, job.fragments)
                 failed = result.return_code or result.stderr
                 did_config = do_config
                 if failed and not do_config and not self.mrproper:
@@ -708,7 +712,7 @@ class BuilderThread(threading.Thread):
                             brd, work_dir, True,
                             self.mrproper or self.builder.fallback_mrproper,
                             False, True, False, job.work_in_output,
-                            job.adjust_cfg)
+                            job.adjust_cfg, job.fragments)
                         did_config = True
                 if not self.builder.force_reconfig:
                     do_config = request_config
@@ -754,14 +758,14 @@ class BuilderThread(threading.Thread):
             result, request_config = self.run_commit(None, brd, work_dir, True,
                         self.mrproper, self.builder.config_only, True,
                         self.builder.force_build_failures, job.work_in_output,
-                        job.adjust_cfg)
+                        job.adjust_cfg, job.fragments)
             failed = result.return_code or result.stderr
             if failed and not self.mrproper:
                 result, request_config = self.run_commit(None, brd, work_dir,
                             True, self.builder.fallback_mrproper,
                             self.builder.config_only, True,
                             self.builder.force_build_failures,
-                            job.work_in_output, job.adjust_cfg)
+                            job.work_in_output, job.adjust_cfg, job.fragments)
 
             result.commit_upto = 0
             self._write_result(result, job.keep_outputs, job.work_in_output)
diff --git a/tools/buildman/cmdline.py b/tools/buildman/cmdline.py
index 7573e5bdfe8..38ea7f9f335 100644
--- a/tools/buildman/cmdline.py
+++ b/tools/buildman/cmdline.py
@@ -62,6 +62,8 @@ def add_upto_m(parser):
           help="Fetch a toolchain for architecture FETCH_ARCH ('list' to list)."
               ' You can also fetch several toolchains separate by comma, or'
               " 'all' to download all")
+    parser.add_argument('--fragments', type=str,
+          help="Comma separated list of configuration fragments to be applied")
     parser.add_argument(
           '--full-check', action='store_true',
           help='Check maintainer entries and TARGET configs')
diff --git a/tools/buildman/control.py b/tools/buildman/control.py
index 55d4d770c5c..a668783b4d4 100644
--- a/tools/buildman/control.py
+++ b/tools/buildman/control.py
@@ -561,7 +561,7 @@ def run_builder(builder, commits, board_selected, args):
         builder.show_summary(commits, board_selected)
     else:
         fail, warned, excs = builder.build_boards(
-            commits, board_selected, args.keep_outputs, args.verbose)
+            commits, board_selected, args.keep_outputs, args.verbose, args.fragments)
         if excs:
             return 102
         if fail:
-- 
2.47.1

