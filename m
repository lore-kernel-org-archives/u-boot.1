Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E26B8C54ED1
	for <u-boot@archiver.kernel.org>; Tue, 27 May 2025 11:19:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8268682F8E;
	Tue, 27 May 2025 13:19:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XMzfBUMC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 587248301F; Tue, 27 May 2025 13:19:47 +0200 (CEST)
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com
 [IPv6:2607:f8b0:4864:20::d44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D2F982116
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 13:19:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd44.google.com with SMTP id
 ca18e2360f4ac-8647e143f28so243413639f.1
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 04:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748344782; x=1748949582; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tGfItuoPWFyUiLR7DYnDPqpEoS+RKz+ORMD9Htqo43k=;
 b=XMzfBUMCeQZWHJVPt3mxcPo1xjFG/X+xgmji2zyVpQ48hxTmQxdskv/FysqYs+b17z
 Fp6umqaJiYf0r2I5snN4kcruc6tbFQlxHGV8fxL3E6iHg9WU8CZdwSPyvO1i7ReIXcbv
 5xKldNK7Ku54WLUsemZ36IO1c3pQTmvVMn1vs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748344782; x=1748949582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tGfItuoPWFyUiLR7DYnDPqpEoS+RKz+ORMD9Htqo43k=;
 b=CrkXFZJ4rpocTogkVFDW11VKYKz3gOmwA2h82x4agbjsIfhT+iPwmoFKZvhQkvHsbQ
 uL9S3d+cE1qMu5cxSfrddeLDklVFe2ywYZgY1e3HJJkT4FfQu8tMMaEQr/xn5vH+21rz
 53qdcMmgxbHfIF5GflZ2dh7Va0QWN75E/r04muzQNklRZQANAKxt+qeOsyRrhNbA3fZg
 XjhYfHEW5AOapzrWfTGyoXLQFXxJlMintUxzM2LMIxkB5XMC2jSFvCAZUoScjtrmBDJH
 HQbhUqHdnQQdLuZX91uqMMVuUGBaUkeMoxIFYK7ydi6FOqfBnGyM4GD1U7CVrIDfeurS
 VMoA==
X-Gm-Message-State: AOJu0Ywvl2a9mm+iELIOBlZ7rrhMsEwRAPg9RuuLKl6MbfSoUOem27bJ
 JAdby8hAtusm8YPUotTZ/RtTLL5jq6QIB30ZgcbSEJKnSiEOs7OeClvmLTRgXurm9ppmVN7lNU8
 6k4mgayuLxJY=
X-Gm-Gg: ASbGncuHIp1+cGhP2KX1kfc4S94W5vba312LlGrRzU7BlZiacr9bFmE8PWBmozLLcRD
 1WbtdPUQI7uvl8tGASUH/241EcDr36kbijJeHCVObBjJu0wNhXFJwfTkN56+JJx+wDfbdUvSjnt
 JdIMTzKoW4lsTpe7n+I8tHxc6jeOwVvLxQ90oLUOEdck3KHSXGUFZAb7gexVpaeQ5CbEQ3CPosx
 hPSysrCQgLZopisyGQqKcddfBjFsEX7S8wiVkxbHmprRH89E7t/UTMgPSfNH5CyL+fma0/hFbxO
 E8n4TFn90NLeAqj1wGAYtT+mgHdoAD33T+OpKY8kjIDNSwYVHEcb7LYaxC1tSwlCoU5WDJvEumi
 j1OZQQ8d4qJlh
X-Google-Smtp-Source: AGHT+IH9PcXV9Hd2O3W2nRfJAKqtPzAMH4IjneFvs6dEuuvvAyaiQ+tNG0eGJ9x5YmPVvB4jNoTPkg==
X-Received: by 2002:a05:6e02:1d94:b0:3dc:7a9a:44d3 with SMTP id
 e9e14a558f8ab-3dc9b7279f4mr124600055ab.21.1748344782339; 
 Tue, 27 May 2025 04:19:42 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3dc82e014f4sm36362755ab.40.2025.05.27.04.19.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 04:19:41 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/2] buildman: Support an in-tree build in the current dir
Date: Tue, 27 May 2025 05:19:21 -0600
Message-ID: <20250527111932.3058650-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250527111932.3058650-1-sjg@chromium.org>
References: <20250527111932.3058650-1-sjg@chromium.org>
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

Allow -w to be used with -i to do a build without a separate output
directory.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/buildman/builder.py       |  7 +++++--
 tools/buildman/builderthread.py | 28 ++++++++++++++++------------
 tools/buildman/buildman.rst     |  2 ++
 tools/buildman/control.py       | 17 ++++++++++-------
 4 files changed, 33 insertions(+), 21 deletions(-)

diff --git a/tools/buildman/builder.py b/tools/buildman/builder.py
index 6538a3d296f..9516e25e215 100644
--- a/tools/buildman/builder.py
+++ b/tools/buildman/builder.py
@@ -631,10 +631,13 @@ class Builder:
         Args:
             commit_upto: Commit number to use (0..self.count-1)
             target: Target name
+
+        Return:
+            str: Output directory to use, or '' if None
         """
         output_dir = self.get_output_dir(commit_upto)
         if self.work_in_output:
-            return output_dir
+            return output_dir or ''
         return os.path.join(output_dir, target)
 
     def get_done_file(self, commit_upto, target):
@@ -1683,7 +1686,7 @@ class Builder:
         """
         thread_dir = self.get_thread_dir(thread_num)
         builderthread.mkdir(thread_dir)
-        git_dir = os.path.join(thread_dir, '.git')
+        git_dir = os.path.join(thread_dir, '.git') if thread_dir else None
 
         # Create a worktree or a git repo clone for this thread if it
         # doesn't already exist
diff --git a/tools/buildman/builderthread.py b/tools/buildman/builderthread.py
index 4617f516f40..a249174f158 100644
--- a/tools/buildman/builderthread.py
+++ b/tools/buildman/builderthread.py
@@ -31,13 +31,13 @@ def mkdir(dirname, parents=False):
     """Make a directory if it doesn't already exist.
 
     Args:
-        dirname (str): Directory to create
+        dirname (str): Directory to create, or None to do nothing
         parents (bool): True to also make parent directories
 
     Raises:
         OSError: File already exists
     """
-    if os.path.exists(dirname):
+    if not dirname or os.path.exists(dirname):
         return
     try:
         if parents:
@@ -57,7 +57,7 @@ def _remove_old_outputs(out_dir):
     """Remove any old output-target files
 
     Args:
-        out_dir (str): Output directory for the build
+        out_dir (str): Output directory for the build, or None for current dir
 
     Since we use a build directory that was previously used by another
     board, it may have produced an SPL image. If we don't remove it (i.e.
@@ -65,7 +65,7 @@ def _remove_old_outputs(out_dir):
     output of this build, even if it does not produce SPL images.
     """
     for elf in BASE_ELF_FILENAMES:
-        fname = os.path.join(out_dir, elf)
+        fname = os.path.join(out_dir or '', elf)
         if os.path.exists(fname):
             os.remove(fname)
 
@@ -193,9 +193,11 @@ class BuilderThread(threading.Thread):
 
         Args:
             brd (Board): Board to create arguments for
-            out_dir (str): Path to output directory containing the files
+            out_dir (str): Path to output directory containing the files, or
+                or None to not use a separate output directory
             out_rel_dir (str): Output directory relative to the current dir
-            work_dir (str): Directory to which the source will be checked out
+            work_dir (str): Directory to which the source will be checked out,
+                or None to use current directory
             commit_upto (int): Commit number to build (0...n-1)
 
         Returns:
@@ -206,7 +208,7 @@ class BuilderThread(threading.Thread):
         """
         args = []
         cwd = work_dir
-        src_dir = os.path.realpath(work_dir)
+        src_dir = os.path.realpath(work_dir) if work_dir else os.getcwd()
         if commit_upto is None:
             # In this case we are building in the original source directory
             # (i.e. the current directory where buildman is invoked. The
@@ -215,8 +217,9 @@ class BuilderThread(threading.Thread):
             #
             # Symlinks can confuse U-Boot's Makefile since we may use '..'
             # in our path, so remove them.
-            real_dir = os.path.realpath(out_dir)
-            args.append(f'O={real_dir}')
+            if out_dir:
+                real_dir = os.path.realpath(out_dir)
+                args.append(f'O={real_dir}')
             cwd = None
             src_dir = os.getcwd()
         elif out_rel_dir:
@@ -398,7 +401,8 @@ class BuilderThread(threading.Thread):
             config_only (bool): Only configure the source, do not build it
             adjust_cfg (list of str): See the cfgutil module and run_commit()
             commit (Commit): Commit only being built
-            out_dir (str): Output directory for the build
+            out_dir (str): Output directory for the build, or None to use
+               current
             out_rel_dir (str): Output directory relatie to the current dir
             result (CommandResult): Previous result
 
@@ -410,7 +414,7 @@ class BuilderThread(threading.Thread):
         """
         # Set up the environment and command line
         env = self.builder.make_environment(self.toolchain)
-        if not os.path.exists(out_dir):
+        if out_dir and not os.path.exists(out_dir):
             mkdir(out_dir)
 
         args, cwd, src_dir = self._build_args(brd, out_dir, out_rel_dir,
@@ -421,7 +425,7 @@ class BuilderThread(threading.Thread):
         _remove_old_outputs(out_dir)
 
         # If we need to reconfigure, do that now
-        cfg_file = os.path.join(out_dir, '.config')
+        cfg_file = os.path.join(out_dir or '', '.config')
         cmd_list = []
         if do_config or adjust_cfg:
             result = self._reconfigure(
diff --git a/tools/buildman/buildman.rst b/tools/buildman/buildman.rst
index 2555139334f..8c45a841024 100644
--- a/tools/buildman/buildman.rst
+++ b/tools/buildman/buildman.rst
@@ -1338,6 +1338,8 @@ disturbed by the build. Use `-i` to do an in-tree build instead. Note that this
 does not affect the source directory, since buildman creates a separate git
 'worktree' for each board. This means that it is possible to do an in-tree
 build of an entire branch, or even a 'current source' build for multiple boards.
+As a special case, you can use `-wi` to do an in-tree build in the current
+directory.
 
 Build summary
 -------------
diff --git a/tools/buildman/control.py b/tools/buildman/control.py
index 4c9489126c1..4dedd333551 100644
--- a/tools/buildman/control.py
+++ b/tools/buildman/control.py
@@ -390,7 +390,7 @@ def get_boards_obj(output_dir, regen_board_list, maintainer_check, full_check,
     read it in.
 
     Args:
-        output_dir (str): Output directory to use
+        output_dir (str): Output directory to use, or None to use current dir
         regen_board_list (bool): True to just regenerate the board list
         maintainer_check (bool): True to just run a maintainer check
         full_check (bool): True to just run a full check of Kconfig and
@@ -414,9 +414,9 @@ def get_boards_obj(output_dir, regen_board_list, maintainer_check, full_check,
             return 2
         return 0
 
-    if not os.path.exists(output_dir):
+    if output_dir and not os.path.exists(output_dir):
         os.makedirs(output_dir)
-    board_file = os.path.join(output_dir, 'boards.cfg')
+    board_file = os.path.join(output_dir or '', 'boards.cfg')
     if regen_board_list and regen_board_list != '-':
         board_file = regen_board_list
 
@@ -501,7 +501,7 @@ def adjust_args(args, series, selected):
 
 
 def setup_output_dir(output_dir, work_in_output, branch, no_subdirs, col,
-                     clean_dir):
+                     in_tree, clean_dir):
     """Set up the output directory
 
     Args:
@@ -509,6 +509,7 @@ def setup_output_dir(output_dir, work_in_output, branch, no_subdirs, col,
         work_in_output (bool): True to work in the output directory
         branch (str): Name of branch to build, or None if none
         no_subdirs (bool): True to put the output in the top-level output dir
+        in_tree (bool): True if doing an in-tree build
         clean_dir: Used for tests only, indicates that the existing output_dir
             should be removed before starting the build
 
@@ -516,9 +517,11 @@ def setup_output_dir(output_dir, work_in_output, branch, no_subdirs, col,
         str: Updated output directory pathname
     """
     if not output_dir:
-        if work_in_output:
-            sys.exit(col.build(col.RED, '-w requires that you specify -o'))
         output_dir = '..'
+        if work_in_output:
+            if not in_tree:
+                sys.exit(col.build(col.RED, '-w requires that you specify -o'))
+            output_dir = None
     if branch and not no_subdirs:
         # As a special case allow the board directory to be placed in the
         # output directory itself rather than any subdirectory.
@@ -751,7 +754,7 @@ def do_buildman(args, toolchains=None, make_func=None, brds=None,
 
     output_dir = setup_output_dir(
         args.output_dir, args.work_in_output, args.branch,
-        args.no_subdirs, col, clean_dir)
+        args.no_subdirs, col, args.in_tree, clean_dir)
 
     # Work out what subset of the boards we are building
     if not brds:
-- 
2.43.0

base-commit: 9665e6b85eef02e62b1fe6a15e6f5fac418273fe
branch: bmg
