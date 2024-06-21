Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60441C2BB85
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 20:48:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 066058858C;
	Fri, 21 Jun 2024 22:47:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZvdXR6Av";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17B0E88405; Fri, 21 Jun 2024 22:46:52 +0200 (CEST)
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com
 [IPv6:2607:f8b0:4864:20::d44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1BD888576
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 22:46:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd44.google.com with SMTP id
 ca18e2360f4ac-7eb895539e3so94107739f.2
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 13:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719002806; x=1719607606; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E+q4gqJa2swS7fW00RKTnduYoOd3HH3BvpJOyGpjEl4=;
 b=ZvdXR6Avgux+n5GQwtvT86II7RyiryJdxoR8O05B3M/KEkjBvnQD+fa00bx22sUsD7
 9m0a08QX27Oq0kIY8v6fKychy4gMwMZHTHmoTr7ufEUZqOpC5oAFHmcmgWdPmucQeLsv
 CqnLVzbWODzc19eeOI2UBK8F9aXAuQHfujkEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719002806; x=1719607606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E+q4gqJa2swS7fW00RKTnduYoOd3HH3BvpJOyGpjEl4=;
 b=a4Opq8JaIJteSJVsCibj4V0Uu0JcblrydNk2RPhbxRDXEFGq3Rq5ekyD4fd7eWj0f1
 GbxIM+8SyptPQnW1j+KTc/95vcTdsU78364yKy82dXlYyW4xGjd756DxsGhuojPAg7zd
 DyTbF/j4GNlA8vWW28Uwa76lNs/hT6m/hC01DtmZdd8kMkK0U6mMZRB6FtjAy2U95OFG
 tFa6BMiCudWji+mixLGekp7y+yNvIQ9SxQ3831jZ5Id1b5aQ5+8JEoEV/hY3zp11LC36
 FeduqVP6w3oWQhU7TVa+LjpjXA4SvyKIHCZmefIhNk0DHDDYJ7x3+iYwfT+Fjy7H2YMn
 ODfg==
X-Gm-Message-State: AOJu0Yy7zUAEo/r5IYXNNOeY2XnCS93/kPJf4i7RaUQSXvAJCmSDyIuR
 pPj41ptRpW9ep2LNQ+pRdx+8NK2SgalZDUKRdVHQ9usvqE0o2XTeTmNkSi6qlWkhRJcGPtPNC3v
 UpUSH
X-Google-Smtp-Source: AGHT+IGsovfAbOO8DT9/MNnO9k+6qdtlcinbjZxoIluWndM+s3UPTp6bs52A5GAuWMNFaGRuIJwhNw==
X-Received: by 2002:a05:6602:14cc:b0:7eb:c7ff:26e3 with SMTP id
 ca18e2360f4ac-7f13ee7a920mr1012651939f.16.1719002806576; 
 Fri, 21 Jun 2024 13:46:46 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-7f39203ec51sm50698939f.53.2024.06.21.13.46.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 13:46:46 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: [PATCH 09/11] buildman: Add a flag to force mrproper on failure
Date: Fri, 21 Jun 2024 14:46:30 -0600
Message-Id: <20240621204632.2706813-10-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240621204632.2706813-1-sjg@chromium.org>
References: <20240621204632.2706813-1-sjg@chromium.org>
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

