Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B96DC02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 16:27:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5944E801C3;
	Mon,  3 Feb 2025 17:27:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GDW8/mGH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9743801BE; Mon,  3 Feb 2025 17:27:35 +0100 (CET)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29E54805FF
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 17:27:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3a9caa3726fso12359725ab.1
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 08:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738600051; x=1739204851; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pmqe8nephEwWhgyVPVTsy2xIOW0uoQ9t9rLQvacKMvc=;
 b=GDW8/mGHkOAxGGbThn+sYHSxWFtqCv00pcLselo00sMHcFP9pxpGHR+uQN/CBgzOeu
 jYo+0SRogZsRJiD43Xo6ktIQRB2XX308Y3hdKg286hYpUnCFGpegfvjPsgXV/YCZOXG8
 QqWFRHQAC/Sutd2UhTdyYK+9hLFWuKlwWyoTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738600051; x=1739204851;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pmqe8nephEwWhgyVPVTsy2xIOW0uoQ9t9rLQvacKMvc=;
 b=ETsq6jO95K+YQnpsSAXFrj6uQnvzqixP0exbJ/uvkKhUHSR/MOUJqWCaxSixZHo4/I
 i+d3EcPSw6DMmOUtSRnC2G2FDIYpVnAm+bB0H1IjHR48WHNDBcRLOMzbypgIJFNf953s
 LNR5guQ9Ga6414RTN70zeBGotVAudGnxOBlmQfswWfrFr49ywQlmp4aq1ZKO9E0HY86z
 FdmzAC3cBpqaQ0xMtb/GV5OBEcqIfkhxUwerRCKLEmTwfP3mKu0/NhkLoR6Yus+1IdPq
 183TuUQyVRUdSfk5293JRTbd4D3CEEoXEBqxXE8E+YKaMjo3NtX58JVW5VhcMCI4FcLl
 SjoQ==
X-Gm-Message-State: AOJu0YyJCnZ+z94g3GjbSWChHNge9oPxdt3cCf0tOOMoZ4BUGkXxSvqp
 EIpMCzPt6Icp1wfoflRLStpQ5Y6OAZfs5Sd1yUHsk3qpzwvWpfA1bNgq8vM5s3o7jGnA0dsIcxM
 =
X-Gm-Gg: ASbGncu1Cz4eBvaWOAJA/yfsk1Rq5urt5UnUClCm+cVK+Td8Zd1naxcz+20nT2aadSf
 R929xiBlmhZHXNtpVNfzHQLT5EiF+yPdXBXs0ZGamkToNNID7ET+noxnQ2oJpnOMQTIneQRIfxr
 4ElTBvmJrRgqW77pMoPPhFBmTYAp1Mb+jegpBkwcIG2bPNQyepvv24U0yzXuOQzKcxaHEmgjUeW
 eiR1dXfN++TpnOF3y+q5qMnxLl44A231d1aspAzrtPrmKbgzfFoAkxG0yIhDNo+a+CZCRi1F6H8
 f5RUMcYfE6ymwpWtRts0EqYi5N1Y++XZ9aLlAVl5gkUd8HXG8bZN
X-Google-Smtp-Source: AGHT+IGWAK4OD42hMY5jpQ9XJ3WyBYVLIrXb4PSRbBqIx4joZvOil/gvacywS/UwEl+wX+EM9kaopQ==
X-Received: by 2002:a05:6e02:1f06:b0:3cd:e9a0:3c3d with SMTP id
 e9e14a558f8ab-3d008e3bbb5mr164223405ab.2.1738600049679; 
 Mon, 03 Feb 2025 08:27:29 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d01da7e688sm15935735ab.33.2025.02.03.08.27.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 08:27:27 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Kochetkov <al.kochet@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Brian Norris <computersforpeace@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Douglas Anderson <dianders@chromium.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 4/4] u_boot_pylib: Add a function to run a single command
Date: Mon,  3 Feb 2025 09:26:45 -0700
Message-ID: <20250203162704.627469-5-sjg@chromium.org>
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

Add a helper to avoid needing to use a list within a list for this
simple case.

Update existing users of runpipe() to use this where possible.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/ftest.py           |  5 +--
 tools/buildman/boards.py        |  4 +--
 tools/buildman/builder.py       | 11 ++++---
 tools/buildman/builderthread.py | 31 +++++++++---------
 tools/buildman/func_test.py     |  6 ++--
 tools/buildman/toolchain.py     |  2 +-
 tools/patman/gitutil.py         | 56 ++++++++++++++++-----------------
 tools/patman/patchstream.py     |  2 +-
 tools/rmboard.py                | 25 ++++++---------
 tools/u_boot_pylib/command.py   | 15 +++++++++
 tools/u_boot_pylib/tools.py     |  2 +-
 11 files changed, 84 insertions(+), 75 deletions(-)

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 803f7599c58..31db307cbed 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -345,8 +345,9 @@ class TestFunctional(unittest.TestCase):
             Arguments to pass, as a list of strings
             kwargs: Arguments to pass to Command.RunPipe()
         """
-        result = command.run_pipe([[self._binman_pathname] + list(args)],
-                capture=True, capture_stderr=True, raise_on_error=False)
+        all_args = [self._binman_pathname] + list(args)
+        result = command.run_one(*all_args, capture=True, capture_stderr=True,
+                                 raise_on_error=False)
         if result.return_code and kwargs.get('raise_on_error', True):
             raise Exception("Error running '%s': %s" % (' '.join(args),
                             result.stdout + result.stderr))
diff --git a/tools/buildman/boards.py b/tools/buildman/boards.py
index e7aa0d85a58..2fe43c3fc89 100644
--- a/tools/buildman/boards.py
+++ b/tools/buildman/boards.py
@@ -251,9 +251,9 @@ class KconfigScanner:
                 '-undef',
                 '-x', 'assembler-with-cpp',
                 defconfig]
-            result = command.run_pipe([cmd], capture=True, capture_stderr=True)
+            stdout = command.output(*cmd, capture_stderr=True)
             temp = tempfile.NamedTemporaryFile(prefix='buildman-')
-            tools.write_file(temp.name, result.stdout, False)
+            tools.write_file(temp.name, stdout, False)
             fname = temp.name
             tout.info(f'Processing #include to produce {defconfig}')
         else:
diff --git a/tools/buildman/builder.py b/tools/buildman/builder.py
index 380c4057613..3f5ddd8e722 100644
--- a/tools/buildman/builder.py
+++ b/tools/buildman/builder.py
@@ -512,7 +512,7 @@ class Builder:
             stage: Stage that we are at (mrproper, config, oldconfig, build)
             cwd: Directory where make should be run
             args: Arguments to pass to make
-            kwargs: Arguments to pass to command.run_pipe()
+            kwargs: Arguments to pass to command.run_one()
         """
 
         def check_output(stream, data):
@@ -533,11 +533,12 @@ class Builder:
             return False
 
         self._restarting_config = False
-        self._terminated  = False
+        self._terminated = False
         cmd = [self.gnu_make] + list(args)
-        result = command.run_pipe([cmd], capture=True, capture_stderr=True,
-                cwd=cwd, raise_on_error=False, infile='/dev/null',
-                output_func=check_output, **kwargs)
+        result = command.run_one(*cmd, capture=True, capture_stderr=True,
+                                 cwd=cwd, raise_on_error=False,
+                                 infile='/dev/null', output_func=check_output,
+                                 **kwargs)
 
         if self._terminated:
             # Try to be helpful
diff --git a/tools/buildman/builderthread.py b/tools/buildman/builderthread.py
index 5c61d9c81bd..dc8a24d898c 100644
--- a/tools/buildman/builderthread.py
+++ b/tools/buildman/builderthread.py
@@ -179,13 +179,12 @@ class BuilderThread(threading.Thread):
             cwd (str): Working directory to set, or None to leave it alone
             *args (list of str): Arguments to pass to 'make'
             **kwargs (dict): A list of keyword arguments to pass to
-                command.run_pipe()
+                command.run_one()
 
         Returns:
             CommandResult object
         """
-        return self.builder.do_make(commit, brd, stage, cwd, *args,
-                **kwargs)
+        return self.builder.do_make(commit, brd, stage, cwd, *args, **kwargs)
 
     def _build_args(self, brd, out_dir, out_rel_dir, work_dir, commit_upto):
         """Set up arguments to the args list based on the settings
@@ -590,9 +589,10 @@ class BuilderThread(threading.Thread):
             lines = []
             for fname in BASE_ELF_FILENAMES:
                 cmd = [f'{self.toolchain.cross}nm', '--size-sort', fname]
-                nm_result = command.run_pipe([cmd], capture=True,
-                        capture_stderr=True, cwd=result.out_dir,
-                        raise_on_error=False, env=env)
+                nm_result = command.run_one(*cmd, capture=True,
+                                            capture_stderr=True,
+                                            cwd=result.out_dir,
+                                            raise_on_error=False, env=env)
                 if nm_result.stdout:
                     nm_fname = self.builder.get_func_sizes_file(
                         result.commit_upto, result.brd.target, fname)
@@ -600,9 +600,10 @@ class BuilderThread(threading.Thread):
                         print(nm_result.stdout, end=' ', file=outf)
 
                 cmd = [f'{self.toolchain.cross}objdump', '-h', fname]
-                dump_result = command.run_pipe([cmd], capture=True,
-                        capture_stderr=True, cwd=result.out_dir,
-                        raise_on_error=False, env=env)
+                dump_result = command.run_one(*cmd, capture=True,
+                                              capture_stderr=True,
+                                              cwd=result.out_dir,
+                                              raise_on_error=False, env=env)
                 rodata_size = ''
                 if dump_result.stdout:
                     objdump = self.builder.get_objdump_file(result.commit_upto,
@@ -615,9 +616,10 @@ class BuilderThread(threading.Thread):
                             rodata_size = fields[2]
 
                 cmd = [f'{self.toolchain.cross}size', fname]
-                size_result = command.run_pipe([cmd], capture=True,
-                        capture_stderr=True, cwd=result.out_dir,
-                        raise_on_error=False, env=env)
+                size_result = command.run_one(*cmd, capture=True,
+                                              capture_stderr=True,
+                                              cwd=result.out_dir,
+                                              raise_on_error=False, env=env)
                 if size_result.stdout:
                     lines.append(size_result.stdout.splitlines()[1] + ' ' +
                                  rodata_size)
@@ -626,9 +628,8 @@ class BuilderThread(threading.Thread):
             cmd = [f'{self.toolchain.cross}objcopy', '-O', 'binary',
                    '-j', '.rodata.default_environment',
                    'env/built-in.o', 'uboot.env']
-            command.run_pipe([cmd], capture=True,
-                            capture_stderr=True, cwd=result.out_dir,
-                            raise_on_error=False, env=env)
+            command.run_one(*cmd, capture=True, capture_stderr=True,
+                            cwd=result.out_dir, raise_on_error=False, env=env)
             if not work_in_output:
                 copy_files(result.out_dir, build_dir, '', ['uboot.env'])
 
diff --git a/tools/buildman/func_test.py b/tools/buildman/func_test.py
index b2edda9f492..d38aea7a405 100644
--- a/tools/buildman/func_test.py
+++ b/tools/buildman/func_test.py
@@ -232,8 +232,8 @@ class TestFunctional(unittest.TestCase):
         self._toolchains.Add('gcc', test=False)
 
     def _RunBuildman(self, *args):
-        return command.run_pipe([[self._buildman_pathname] + list(args)],
-                capture=True, capture_stderr=True)
+        all_args = [self._buildman_pathname] + list(args)
+        return command.run_one(*all_args, capture=True, capture_stderr=True)
 
     def _RunControl(self, *args, brds=False, clean_dir=False,
                     test_thread_exceptions=False, get_builder=True):
@@ -445,7 +445,7 @@ class TestFunctional(unittest.TestCase):
             stage: Stage that we are at (mrproper, config, build)
             cwd: Directory where make should be run
             args: Arguments to pass to make
-            kwargs: Arguments to pass to command.run_pipe()
+            kwargs: Arguments to pass to command.run_one()
         """
         self._make_calls += 1
         out_dir = ''
diff --git a/tools/buildman/toolchain.py b/tools/buildman/toolchain.py
index 958f36f9f61..5d051e005da 100644
--- a/tools/buildman/toolchain.py
+++ b/tools/buildman/toolchain.py
@@ -100,7 +100,7 @@ class Toolchain:
         else:
             self.priority = priority
         if test:
-            result = command.run_pipe([cmd], capture=True, env=env,
+            result = command.run_one(*cmd, capture=True, env=env,
                                      raise_on_error=False)
             self.ok = result.return_code == 0
             if verbose:
diff --git a/tools/patman/gitutil.py b/tools/patman/gitutil.py
index ffe05273b35..6d6a7eedecc 100644
--- a/tools/patman/gitutil.py
+++ b/tools/patman/gitutil.py
@@ -65,9 +65,9 @@ def count_commits_to_branch(branch):
         rev_range = '%s..%s' % (us, branch)
     else:
         rev_range = '@{upstream}..'
-    pipe = [log_cmd(rev_range, oneline=True)]
-    result = command.run_pipe(pipe, capture=True, capture_stderr=True,
-                              oneline=True, raise_on_error=False)
+    cmd = log_cmd(rev_range, oneline=True)
+    result = command.run_one(*cmd, capture=True, capture_stderr=True,
+                             oneline=True, raise_on_error=False)
     if result.return_code:
         raise ValueError('Failed to determine upstream: %s' %
                          result.stderr.strip())
@@ -84,8 +84,7 @@ def name_revision(commit_hash):
     Return:
         Name of revision, if any, else None
     """
-    pipe = ['git', 'name-rev', commit_hash]
-    stdout = command.run_pipe([pipe], capture=True, oneline=True).stdout
+    stdout = command.output_one_line('git', 'name-rev', commit_hash)
 
     # We expect a commit, a space, then a revision name
     name = stdout.split(' ')[1].strip()
@@ -108,9 +107,9 @@ def guess_upstream(git_dir, branch):
             Name of upstream branch (e.g. 'upstream/master') or None if none
             Warning/error message, or None if none
     """
-    pipe = [log_cmd(branch, git_dir=git_dir, oneline=True, count=100)]
-    result = command.run_pipe(pipe, capture=True, capture_stderr=True,
-                              raise_on_error=False)
+    cmd = log_cmd(branch, git_dir=git_dir, oneline=True, count=100)
+    result = command.run_one(*cmd, capture=True, capture_stderr=True,
+                             raise_on_error=False)
     if result.return_code:
         return None, "Branch '%s' not found" % branch
     for line in result.stdout.splitlines()[1:]:
@@ -183,9 +182,9 @@ def count_commits_in_range(git_dir, range_expr):
         Number of patches that exist in the supplied range or None if none
         were found
     """
-    pipe = [log_cmd(range_expr, git_dir=git_dir, oneline=True)]
-    result = command.run_pipe(pipe, capture=True, capture_stderr=True,
-                              raise_on_error=False)
+    cmd = log_cmd(range_expr, git_dir=git_dir, oneline=True)
+    result = command.run_one(*cmd, capture=True, capture_stderr=True,
+                             raise_on_error=False)
     if result.return_code:
         return None, "Range '%s' not found or is invalid" % range_expr
     patch_count = len(result.stdout.splitlines())
@@ -250,9 +249,8 @@ def clone(git_dir, output_dir):
     Args:
         commit_hash: Commit hash to check out
     """
-    pipe = ['git', 'clone', git_dir, '.']
-    result = command.run_pipe([pipe], capture=True, cwd=output_dir,
-                              capture_stderr=True)
+    result = command.run_one('git', 'clone', git_dir, '.', capture=True,
+                             cwd=output_dir, capture_stderr=True)
     if result.return_code != 0:
         raise OSError('git clone: %s' % result.stderr)
 
@@ -263,13 +261,13 @@ def fetch(git_dir=None, work_tree=None):
     Args:
         commit_hash: Commit hash to check out
     """
-    pipe = ['git']
+    cmd = ['git']
     if git_dir:
-        pipe.extend(['--git-dir', git_dir])
+        cmd.extend(['--git-dir', git_dir])
     if work_tree:
-        pipe.extend(['--work-tree', work_tree])
-    pipe.append('fetch')
-    result = command.run_pipe([pipe], capture=True, capture_stderr=True)
+        cmd.extend(['--work-tree', work_tree])
+    cmd.append('fetch')
+    result = command.run_one(*cmd, capture=True, capture_stderr=True)
     if result.return_code != 0:
         raise OSError('git fetch: %s' % result.stderr)
 
@@ -283,9 +281,9 @@ def check_worktree_is_available(git_dir):
     Returns:
         True if git-worktree commands will work, False otherwise.
     """
-    pipe = ['git', '--git-dir', git_dir, 'worktree', 'list']
-    result = command.run_pipe([pipe], capture=True, capture_stderr=True,
-                              raise_on_error=False)
+    result = command.run_one('git', '--git-dir', git_dir, 'worktree', 'list',
+                             capture=True, capture_stderr=True,
+                             raise_on_error=False)
     return result.return_code == 0
 
 
@@ -298,11 +296,11 @@ def add_worktree(git_dir, output_dir, commit_hash=None):
         commit_hash: Commit hash to checkout
     """
     # We need to pass --detach to avoid creating a new branch
-    pipe = ['git', '--git-dir', git_dir, 'worktree', 'add', '.', '--detach']
+    cmd = ['git', '--git-dir', git_dir, 'worktree', 'add', '.', '--detach']
     if commit_hash:
-        pipe.append(commit_hash)
-    result = command.run_pipe([pipe], capture=True, cwd=output_dir,
-                              capture_stderr=True)
+        cmd.append(commit_hash)
+    result = command.run_one(*cmd, capture=True, cwd=output_dir,
+                             capture_stderr=True)
     if result.return_code != 0:
         raise OSError('git worktree add: %s' % result.stderr)
 
@@ -313,8 +311,8 @@ def prune_worktrees(git_dir):
     Args:
         git_dir: The repository whose deleted worktrees should be pruned
     """
-    pipe = ['git', '--git-dir', git_dir, 'worktree', 'prune']
-    result = command.run_pipe([pipe], capture=True, capture_stderr=True)
+    result = command.run_one('git', '--git-dir', git_dir, 'worktree', 'prune',
+                             capture=True, capture_stderr=True)
     if result.return_code != 0:
         raise OSError('git worktree prune: %s' % result.stderr)
 
@@ -687,7 +685,7 @@ def setup():
     if alias_fname:
         settings.ReadGitAliases(alias_fname)
     cmd = log_cmd(None, count=0)
-    use_no_decorate = (command.run_pipe([cmd], raise_on_error=False)
+    use_no_decorate = (command.run_one(*cmd, raise_on_error=False)
                        .return_code == 0)
 
 
diff --git a/tools/patman/patchstream.py b/tools/patman/patchstream.py
index 4955f6aaab9..940b50ca8d4 100644
--- a/tools/patman/patchstream.py
+++ b/tools/patman/patchstream.py
@@ -711,7 +711,7 @@ def get_list(commit_range, git_dir=None, count=None):
     """
     params = gitutil.log_cmd(commit_range, reverse=True, count=count,
                             git_dir=git_dir)
-    return command.run_pipe([params], capture=True).stdout
+    return command.run_one(*params, capture=True).stdout
 
 def get_metadata_for_list(commit_range, git_dir=None, count=None,
                           series=None, allow_overwrite=False):
diff --git a/tools/rmboard.py b/tools/rmboard.py
index 0c56b149e0f..594fd89b8d7 100755
--- a/tools/rmboard.py
+++ b/tools/rmboard.py
@@ -43,18 +43,16 @@ def rm_kconfig_include(path):
     Args:
         path: Path to search for and remove
     """
-    cmd = ['git', 'grep', path]
-    stdout = command.run_pipe([cmd], capture=True, raise_on_error=False).stdout
+    stdout = command.output('git', 'grep', path, raise_on_error=False)
     if not stdout:
         return
     fname = stdout.split(':')[0]
 
     print("Fixing up '%s' to remove reference to '%s'" % (fname, path))
-    cmd = ['sed', '-i', '\|%s|d' % path, fname]
-    stdout = command.run_pipe([cmd], capture=True).stdout
+    stdout = command.run_one('sed', '-i', rf'\|{path}|d', fname,
+                             capture=True).stdout
 
-    cmd = ['git', 'add', fname]
-    stdout = command.run_pipe([cmd], capture=True).stdout
+    stdout = command.output('git', 'add', fname)
 
 def rm_board(board):
     """Create a commit which removes a single board
@@ -68,8 +66,7 @@ def rm_board(board):
     """
 
     # Find all MAINTAINERS and Kconfig files which mention the board
-    cmd = ['git', 'grep', '-l', board]
-    stdout = command.run_pipe([cmd], capture=True).stdout
+    stdout = command.output('git', 'grep', '-l', board)
     maintain = []
     kconfig = []
     for line in stdout.splitlines():
@@ -109,16 +106,14 @@ def rm_board(board):
     # Search for Kconfig files in the resulting list. Remove any 'source' lines
     # which reference Kconfig files we want to remove
     for path in real:
-        cmd = ['find', path]
-        stdout = (command.run_pipe([cmd], capture=True, raise_on_error=False).
-                  stdout)
+        stdout = command.output('find', path, raise_on_error=False)
         for fname in stdout.splitlines():
             if fname.endswith('Kconfig'):
                 rm_kconfig_include(fname)
 
     # Remove unwanted files
     cmd = ['git', 'rm', '-r'] + real
-    stdout = command.run_pipe([cmd], capture=True).stdout
+    stdout = command.output(*cmd, capture=True)
 
     ## Change the messages as needed
     msg = '''arm: Remove %s board
@@ -131,13 +126,11 @@ Remove it.
         msg += 'Patch-cc: %s\n' % name
 
     # Create the commit
-    cmd = ['git', 'commit', '-s', '-m', msg]
-    stdout = command.run_pipe([cmd], capture=True).stdout
+    stdout = command.output('git', 'commit', '-s', '-m', msg)
 
     # Check if the board is mentioned anywhere else. The user will need to deal
     # with this
-    cmd = ['git', 'grep', '-il', board]
-    print(command.run_pipe([cmd], capture=True, raise_on_error=False).stdout)
+    print(command.output('git', 'grep', '-il', board, raise_on_error=False))
     print(' '.join(cmd))
 
 for board in sys.argv[1:]:
diff --git a/tools/u_boot_pylib/command.py b/tools/u_boot_pylib/command.py
index a98dcedd322..0e247355ef6 100644
--- a/tools/u_boot_pylib/command.py
+++ b/tools/u_boot_pylib/command.py
@@ -188,6 +188,21 @@ def run(*cmd, **kwargs):
     return run_pipe([cmd], **kwargs).stdout
 
 
+def run_one(*cmd, **kwargs):
+    """Run a single command
+
+    Note that you must add 'capture' to kwargs to obtain non-empty output
+
+    Args:
+        *cmd (list of str): Command to run
+        **kwargs (dict of args): Extra arguments to pass in
+
+    Returns:
+        CommandResult: output of command
+    """
+    return run_pipe([cmd], **kwargs)
+
+
 def run_list(cmd):
     """Run a command and return its output
 
diff --git a/tools/u_boot_pylib/tools.py b/tools/u_boot_pylib/tools.py
index 187725b5015..48f927a7846 100644
--- a/tools/u_boot_pylib/tools.py
+++ b/tools/u_boot_pylib/tools.py
@@ -360,7 +360,7 @@ def run_result(name, *args, **kwargs):
             args = tuple(extra_args) + args
         name = os.path.expanduser(name)  # Expand paths containing ~
         all_args = (name,) + args
-        result = command.run_pipe([all_args], capture=True, capture_stderr=True,
+        result = command.run_one(*all_args, capture=True, capture_stderr=True,
                                  env=env, raise_on_error=False, binary=binary)
         if result.return_code:
             if raise_on_error:
-- 
2.43.0

