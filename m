Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8148BC27C75
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 20:04:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6685188728;
	Tue, 11 Jun 2024 22:02:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZhbfrTlk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D84E488717; Tue, 11 Jun 2024 22:02:26 +0200 (CEST)
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com
 [IPv6:2607:f8b0:4864:20::d43])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC6E588715
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 22:02:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd43.google.com with SMTP id
 ca18e2360f4ac-7eb895539e3so108196439f.2
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 13:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718136142; x=1718740942; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E+q4gqJa2swS7fW00RKTnduYoOd3HH3BvpJOyGpjEl4=;
 b=ZhbfrTlkr7KRtZDgqP1p0GyuZPL0Je1D1R3rDvxXiuBtdJtyExso+piYAGfMfRnT0J
 Wq20BH6BiF+rkhVGgXj0FpwhV3Vvz1M70KVSf56FwiyOG3aFcaOrJldU2863TibiVSXQ
 jVu1wP82c/aKZzifE2rNsMeMrGM6ZzaF3Gimc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718136142; x=1718740942;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E+q4gqJa2swS7fW00RKTnduYoOd3HH3BvpJOyGpjEl4=;
 b=isfBwfewgdzwfuq+1V0kdxrxlzCBEgIuRRkL2MV6IWdpnqFw0kkct2v5pZAB3wLwIw
 Y3ukKfYeGHmJbpQiOBMSJxyoM36S0hizrCCGFSrLrlVSaXa0NsSqlMmQ4aw0YQ860QXb
 X84vjmCuNgHpuvcV1t3nz8xUtXQKS0oy/ClLLubzG3d2cHgbVZWOj9X172w4RZkmy74A
 +Qe6/DqlMfdxkwmhB+UGUEhVDKYuIjJ0TDgYFvow+gFHY0ywyyahCbp5HnoPRHwwpGtX
 Y6avU/bQp0WlWepawCER89Mf4utoJRTi5cOmId0L5kOMecZubcICQ7i8/ibesMQ/l6Xd
 D/LQ==
X-Gm-Message-State: AOJu0YwoCwR+OSN/O1YxqNuxTLztsH7WuTezrPKkpLm1L4V01w7naSL7
 qGOBgg/amCCWAR8t+5mRjH9qRCsZEcfG1MJ9Dhzgd8R6q4oPaVFRaQk1uKJcKMTWGsIbkfEqFa4
 i+53u
X-Google-Smtp-Source: AGHT+IHRBYfG1t54v7ZCBvWuiVEPeZKJom2F+z1XAth+Zne8fqJGurcQ3jAyB5z7fme6jgAlgdQVjg==
X-Received: by 2002:a05:6e02:1aa9:b0:375:acd1:8bc4 with SMTP id
 e9e14a558f8ab-375acd190f3mr59089255ab.27.1718136142234; 
 Tue, 11 Jun 2024 13:02:22 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-375ca7617cbsm1119305ab.30.2024.06.11.13.02.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 13:02:22 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: [PATCH 10/42] buildman: Add a flag to force mrproper on failure
Date: Tue, 11 Jun 2024 14:01:24 -0600
Message-Id: <20240611200156.2245525-11-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240611200156.2245525-1-sjg@chromium.org>
References: <20240611200156.2245525-1-sjg@chromium.org>
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

When a file is removed by a commit (e.g. include/common.h yay!) it can
cause incremental build failures since one of the dependency files from
a previous build may mention the file.

Add an option to run 'make mrproper' automatically when a build fails.
This can be used to automatically resolve the problem, without always
adding the large overhead of 'make mrproper' to every build.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/buildman/builder.py       | 18 ++++++++++--------
 tools/buildman/builderthread.py |  6 ++++--
 tools/buildman/buildman.rst     |  3 ++-
 tools/buildman/cmdline.py       |  4 +++-
 tools/buildman/control.py       |  1 +
 5 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/tools/buildman/builder.py b/tools/buildman/builder.py
index f35175b4598..c4384f53e8d 100644
--- a/tools/buildman/builder.py
+++ b/tools/buildman/builder.py
@@ -256,14 +256,14 @@ class Builder:
     def __init__(self, toolchains, base_dir, git_dir, num_threads, num_jobs,
                  gnu_make='make', checkout=True, show_unknown=True, step=1,
                  no_subdirs=False, full_path=False, verbose_build=False,
-                 mrproper=False, per_board_out_dir=False,
-                 config_only=False, squash_config_y=False,
-                 warnings_as_errors=False, work_in_output=False,
-                 test_thread_exceptions=False, adjust_cfg=None,
-                 allow_missing=False, no_lto=False, reproducible_builds=False,
-                 force_build=False, force_build_failures=False,
-                 force_reconfig=False, in_tree=False,
-                 force_config_on_failure=False, make_func=None):
+                 mrproper=False, fallback_mrproper=False,
+                 per_board_out_dir=False, config_only=False,
+                 squash_config_y=False, warnings_as_errors=False,
+                 work_in_output=False, test_thread_exceptions=False,
+                 adjust_cfg=None, allow_missing=False, no_lto=False,
+                 reproducible_builds=False, force_build=False,
+                 force_build_failures=False, force_reconfig=False,
+                 in_tree=False, force_config_on_failure=False, make_func=None):
         """Create a new Builder object
 
         Args:
@@ -283,6 +283,7 @@ class Builder:
                 PATH
             verbose_build: Run build with V=1 and don't use 'make -s'
             mrproper: Always run 'make mrproper' when configuring
+            fallback_mrproper: Run 'make mrproper' and retry on build failure
             per_board_out_dir: Build in a separate persistent directory per
                 board rather than a thread-specific directory
             config_only: Only configure each build, don't build it
@@ -352,6 +353,7 @@ class Builder:
         self.force_reconfig = force_reconfig
         self.in_tree = in_tree
         self.force_config_on_failure = force_config_on_failure
+        self.fallback_mrproper = fallback_mrproper
 
         if not self.squash_config_y:
             self.config_filenames += EXTRA_CONFIG_FILENAMES
diff --git a/tools/buildman/builderthread.py b/tools/buildman/builderthread.py
index c0b1067e3f7..bbe2f6f0d24 100644
--- a/tools/buildman/builderthread.py
+++ b/tools/buildman/builderthread.py
@@ -705,8 +705,10 @@ class BuilderThread(threading.Thread):
                     # with a reconfig.
                     if self.builder.force_config_on_failure:
                         result, request_config = self.run_commit(commit_upto,
-                            brd, work_dir, True, self.mrproper, False, True,
-                            False, job.work_in_output, job.adjust_cfg)
+                            brd, work_dir, True,
+                            self.mrproper or self.builder.fallback_mrproper,
+                            False, True, False, job.work_in_output,
+                            job.adjust_cfg)
                         did_config = True
                 if not self.builder.force_reconfig:
                     do_config = request_config
diff --git a/tools/buildman/buildman.rst b/tools/buildman/buildman.rst
index aae2477b5c3..bd0482af5f7 100644
--- a/tools/buildman/buildman.rst
+++ b/tools/buildman/buildman.rst
@@ -995,7 +995,8 @@ By default, buildman doesn't execute 'make mrproper' prior to building the
 first commit for each board. This reduces the amount of work 'make' does, and
 hence speeds up the build. To force use of 'make mrproper', use -the -m flag.
 This flag will slow down any buildman invocation, since it increases the amount
-of work done on any build.
+of work done on any build. An alternative is to use the --fallback-mrproper
+flag, which retries the build with 'make mrproper' only after a build failure.
 
 One possible application of buildman is as part of a continual edit, build,
 edit, build, ... cycle; repeatedly applying buildman to the same change or
diff --git a/tools/buildman/cmdline.py b/tools/buildman/cmdline.py
index 03211bd5aa5..8dc5a8787b5 100644
--- a/tools/buildman/cmdline.py
+++ b/tools/buildman/cmdline.py
@@ -90,7 +90,9 @@ def add_upto_m(parser):
     parser.add_argument('--list-tool-chains', action='store_true', default=False,
           help='List available tool chains (use -v to see probing detail)')
     parser.add_argument('-m', '--mrproper', action='store_true',
-          default=False, help="Run 'make mrproper before reconfiguring")
+          default=False, help="Run 'make mrproper' before reconfiguring")
+    parser.add_argument('--fallback-mrproper', action='store_true',
+          default=False, help="Run 'make mrproper' and retry on build failure")
     parser.add_argument(
           '-M', '--allow-missing', action='store_true', default=False,
           help='Tell binman to allow missing blobs and generate fake ones as needed')
diff --git a/tools/buildman/control.py b/tools/buildman/control.py
index 8f6850c5211..f2dd87814c3 100644
--- a/tools/buildman/control.py
+++ b/tools/buildman/control.py
@@ -656,6 +656,7 @@ def do_buildman(args, toolchains=None, make_func=None, brds=None,
             no_subdirs=args.no_subdirs, full_path=args.full_path,
             verbose_build=args.verbose_build,
             mrproper=args.mrproper,
+            fallback_mrproper=args.fallback_mrproper,
             per_board_out_dir=args.per_board_out_dir,
             config_only=args.config_only,
             squash_config_y=not args.preserve_config_y,
-- 
2.34.1

