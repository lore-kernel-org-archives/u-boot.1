Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF363C2BB85
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 19:54:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02076885B0;
	Fri, 21 Jun 2024 21:52:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="b8OGlcvS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06CFA8856F; Fri, 21 Jun 2024 21:52:22 +0200 (CEST)
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com
 [IPv6:2607:f8b0:4864:20::143])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9CA28857C
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 21:52:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x143.google.com with SMTP id
 e9e14a558f8ab-3737dc4a669so9779395ab.0
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 12:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718999538; x=1719604338; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GObNPrk/tCEopd9X1kpliNcES1sI2HkzYaqk/1pvvvQ=;
 b=b8OGlcvSMc6GkyYG1G19x9qGaaG6c3IBxXgZYJjxeltgXDDCvn/oJSySjG7BJj6FzA
 BE5TUrNGnwgL3G1kBD2GihOwCptDLdW/LS/DkQybJ7trtvH0x5i9Z1PBJXfC5uaSfySV
 snIbhNAHGSTxb5wIX4X7IA7PFKnoeLiRkEUbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718999538; x=1719604338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GObNPrk/tCEopd9X1kpliNcES1sI2HkzYaqk/1pvvvQ=;
 b=CofgLDZIy7LCEdV6iQPLWqAqMXqEuIxUG92gcSvyftakk5E5eaqGb7+Spm19FRa4RJ
 ne7TFoJA+breIQuyprSyM0cclT3EP/c34cT1AuHfcd284sdSk747mQnetaCZu2zdUkgl
 kfrRTZAauAKSP5KRiPXG5ZQ9BwvtCBphmo6Wtef34i+IxTSOK/hynF/EhxMMB8r/wd4j
 ejJS+vkn0K32y+fVGkpqjQ8uNN/dXjjt9BwBVc+sB3Q6E4xZjkG9YKIYXJndoliKTNir
 clmOKX+kFsvge8R7ez4RoATy/pDhv5/IA0q9WrdyWNhSMC+wm0HJrltNPsNLLopL7lUG
 E8zw==
X-Gm-Message-State: AOJu0YydhwcV+gIYf6g9YJJrIcmetC2dkW6eqJm0Uh98YR2KJOfhGf+w
 dllCRJxgewQefKqeuI829c0Gru+yfE3OCCLXZXlpb7R/otD+XKh6BjllXjeGfkWwrktLTgAp3o/
 8PIkQ
X-Google-Smtp-Source: AGHT+IFYPSmFkE3uakBSClJI+8SI4vTabHq3U3VB1ewRYllmRvpeFkzN/YKOml8DN/rAaOcKb5BVYg==
X-Received: by 2002:a05:6602:1607:b0:7eb:b36f:b4e2 with SMTP id
 ca18e2360f4ac-7f13ee475camr1119531639f.10.1718999538205; 
 Fri, 21 Jun 2024 12:52:18 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-7f39203deb7sm48801139f.47.2024.06.21.12.52.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 12:52:17 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 10/43] buildman: Add a flag to force mrproper on failure
Date: Fri, 21 Jun 2024 13:51:31 -0600
Message-Id: <20240621195204.2675252-11-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240621195204.2675252-1-sjg@chromium.org>
References: <20240621195204.2675252-1-sjg@chromium.org>
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

(no changes since v1)

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

