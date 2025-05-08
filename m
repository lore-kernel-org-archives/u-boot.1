Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1F72C3ABC0
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 07:29:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 547F0828F8;
	Thu,  8 May 2025 09:29:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dijhj4Pq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 134098295C; Thu,  8 May 2025 09:29:20 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0E98828C2
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 09:29:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43d07ca6a80so2835895e9.1
 for <u-boot@lists.denx.de>; Thu, 08 May 2025 00:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746689357; x=1747294157; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RcFvSq76VZP5f3ZOXIQtaQz++drS1viRgt9Z5UpkPPc=;
 b=dijhj4PqHe5YVQh6QjT/+dVok5PdG593Txu8jR4EmvrnuBvKgoGykXt0jO3TrQTRXI
 V48wGq3fkISAE9y8dchPuYBFzQmDUfoc8Vo68n7uNbjffw/DUgUPg+p+xG6jbt6GmAIt
 /t+JABF2gHEv22Sjz2/as0frAHXBmYJ8s79So=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746689357; x=1747294157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RcFvSq76VZP5f3ZOXIQtaQz++drS1viRgt9Z5UpkPPc=;
 b=JaeoRXrDJngU3JQ8qxnP/WWZfOLqDX/w4oHjKo8HJGiBD6KfyYJmZr3pkAKN70BlAC
 xH8l8uSo7Wywf8loKdTbxaKuKJSmu6CIFFU39Xbmslu3BvTOb/ITeQnG5gHEoSFtXDVe
 JSBrjSE73rFZRyD0ogB9xW5h5n0QQebWMbqy0FZ8zHNUd053Rpvty46XQi3X/Gd2MCwh
 Vd3CiCB7ymzGNinB+wEwYOfVmrUeaAEUZPHdjUaco12WiyXlVqPVR8Yx7W5MFraqEHLr
 Pc+orRVnTqgw2M+Uqltrdr7m7DN7L1a0DOmUK6AmqGl85+KNX4Ao17lV2UuHAsaJruEA
 74eQ==
X-Gm-Message-State: AOJu0YzBiFdZmiohtLac0nVLAEeLjTT3Td0AmIU8mY1t5v6Y9J/x7sy7
 a+xpA+fHwOOJrUJ4sF5cYZTTh4TZylep6btac4nJDzlRwWRhpU9JIG+J2uPJveNZSRdQoPyZoRu
 tvOlgPAWBEg==
X-Gm-Gg: ASbGnct4V6jKgayuEXZCxdrrSCml4gnQ+3MapToHAWtpc9faXyR0IWyutY7fWc8iJqz
 /j5TcOR7Cdg29ukoTp84108E3ou9ILNN5/ZcWDID471LcMsEA3qxrx5ijKQ16Nx2i90p2FMJG3C
 wdGv8+hrhB+qFWTQRxCSiKBeYzggHY42QkJ0pxIGFQ7mKWWrezAw16DuMEeBtuNL2Jh712hVCCn
 JoH9FPFIkkMZjoVaomPjinf9ZNFCigdAVKyRzlnaYHviCNPfn32pviORuL0pjbUmFRn4vzq8D7P
 cUOJ+mMRMhiwnwG8D47O85GQzWjbKS1QxGBsMPnI+gInr9a4
X-Google-Smtp-Source: AGHT+IFq1Cc6pJOMSIM80vbSh4ExZUiRZucpnS6i9OL5WMjNH7wGVWluk3Q6h//GI0InM9mU+b9bnA==
X-Received: by 2002:a05:600c:1c97:b0:43c:ea1a:720a with SMTP id
 5b1f17b1804b1-441d44bb7ffmr49993225e9.1.1746689356849; 
 Thu, 08 May 2025 00:29:16 -0700 (PDT)
Received: from chromium.org ([213.157.19.150])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a0bd6999bfsm774375f8f.46.2025.05.08.00.29.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 May 2025 00:29:15 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 02/20] u_boot_pylib: Provide directories to gitutil functions
Date: Thu,  8 May 2025 09:28:26 +0200
Message-ID: <20250508072907.207175-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250508072907.207175-1-sjg@chromium.org>
References: <20250508072907.207175-1-sjg@chromium.org>
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

For testing it is useful to be able to set the current directory used
for git operations, as well as the git-repo directory. Update some of
the functions to support this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/u_boot_pylib/command.py |  5 ++--
 tools/u_boot_pylib/gitutil.py | 49 +++++++++++++++++++++++++----------
 2 files changed, 38 insertions(+), 16 deletions(-)

diff --git a/tools/u_boot_pylib/command.py b/tools/u_boot_pylib/command.py
index 0e247355ef6..cb7ebf49ce5 100644
--- a/tools/u_boot_pylib/command.py
+++ b/tools/u_boot_pylib/command.py
@@ -203,7 +203,7 @@ def run_one(*cmd, **kwargs):
     return run_pipe([cmd], **kwargs)
 
 
-def run_list(cmd):
+def run_list(cmd, **kwargs):
     """Run a command and return its output
 
     Args:
@@ -211,8 +211,9 @@ def run_list(cmd):
 
     Returns:
         str: output of command
+        **kwargs (dict of args): Extra arguments to pass in
     """
-    return run_pipe([cmd], capture=True).stdout
+    return run_pipe([cmd], capture=True, **kwargs).stdout
 
 
 def stop_all():
diff --git a/tools/u_boot_pylib/gitutil.py b/tools/u_boot_pylib/gitutil.py
index e5a466c8cc6..f89576ef3b9 100644
--- a/tools/u_boot_pylib/gitutil.py
+++ b/tools/u_boot_pylib/gitutil.py
@@ -47,7 +47,7 @@ def log_cmd(commit_range, git_dir=None, oneline=False, reverse=False,
     return cmd
 
 
-def count_commits_to_branch(branch):
+def count_commits_to_branch(branch, git_dir=None, end=None):
     """Returns number of commits between HEAD and the tracking branch.
 
     This looks back to the tracking branch and works out the number of commits
@@ -55,16 +55,22 @@ def count_commits_to_branch(branch):
 
     Args:
         branch (str or None): Branch to count from (None for current branch)
+        git_dir (str): Path to git repository (None to use default)
+        end (str): End commit to stop before
 
     Return:
         Number of patches that exist on top of the branch
     """
-    if branch:
-        us, _ = get_upstream('.git', branch)
+    if end:
+        rev_range = f'{end}..{branch}'
+    elif branch:
+        us, msg = get_upstream(git_dir or '.git', branch)
+        if not us:
+            raise ValueError(msg)
         rev_range = f'{us}..{branch}'
     else:
         rev_range = '@{upstream}..'
-    cmd = log_cmd(rev_range, oneline=True)
+    cmd = log_cmd(rev_range, git_dir=git_dir, oneline=True)
     result = command.run_one(*cmd, capture=True, capture_stderr=True,
                              oneline=True, raise_on_error=False)
     if result.return_code:
@@ -321,7 +327,8 @@ def prune_worktrees(git_dir):
         raise OSError(f'git worktree prune: {result.stderr}')
 
 
-def create_patches(branch, start, count, ignore_binary, series, signoff=True):
+def create_patches(branch, start, count, ignore_binary, series, signoff=True,
+                   git_dir=None, cwd=None):
     """Create a series of patches from the top of the current branch.
 
     The patch files are written to the current directory using
@@ -334,11 +341,16 @@ def create_patches(branch, start, count, ignore_binary, series, signoff=True):
         ignore_binary (bool): Don't generate patches for binary files
         series (Series): Series object for this series (set of patches)
         signoff (bool): True to add signoff lines automatically
+        git_dir (str): Path to git repository (None to use default)
+        cwd (str): Path to use for git operations
     Return:
         Filename of cover letter (None if none)
         List of filenames of patch files
     """
-    cmd = ['git', 'format-patch', '-M']
+    cmd = ['git']
+    if git_dir:
+        cmd += ['--git-dir', git_dir]
+    cmd += ['format-patch', '-M']
     if signoff:
         cmd.append('--signoff')
     if ignore_binary:
@@ -351,7 +363,7 @@ def create_patches(branch, start, count, ignore_binary, series, signoff=True):
     brname = branch or 'HEAD'
     cmd += [f'{brname}~{start + count}..{brname}~{start}']
 
-    stdout = command.run_list(cmd)
+    stdout = command.run_list(cmd, cwd=cwd)
     files = stdout.splitlines()
 
     # We have an extra file if there is a cover letter
@@ -436,7 +448,7 @@ def check_suppress_cc_config():
 
 def email_patches(series, cover_fname, args, dry_run, warn_on_error, cc_fname,
                   alias, self_only=False, in_reply_to=None, thread=False,
-                  smtp_server=None):
+                  smtp_server=None, cwd=None):
     """Email a patch series.
 
     Args:
@@ -456,6 +468,7 @@ def email_patches(series, cover_fname, args, dry_run, warn_on_error, cc_fname,
         thread (bool): True to add --thread to git send-email (make
             all patches reply to cover-letter or first patch in series)
         smtp_server (str or None): SMTP server to use to send patches
+        cwd (str): Path to use for patch files (None to use current dir)
 
     Returns:
         Git command that was/would be run
@@ -528,7 +541,7 @@ send --cc-cmd cc-fname" cover p1 p2'
         cmd.append(cover_fname)
     cmd += args
     if not dry_run:
-        command.run(*cmd, capture=False, capture_stderr=False)
+        command.run(*cmd, capture=False, capture_stderr=False, cwd=cwd)
     cmdstr = ' '.join([f'"{x}"' if ' ' in x and not '"' in x else x
                        for x in cmd])
     return cmdstr
@@ -695,7 +708,7 @@ def setup():
                        .return_code == 0)
 
 
-def get_hash(spec):
+def get_hash(spec, git_dir=None):
     """Get the hash of a commit
 
     Args:
@@ -704,8 +717,11 @@ def get_hash(spec):
     Returns:
         str: Hash of commit
     """
-    return command.output_one_line('git', 'show', '-s', '--pretty=format:%H',
-                                   spec)
+    cmd = ['git']
+    if git_dir:
+        cmd += ['--git-dir', git_dir]
+    cmd += ['show', '-s', '--pretty=format:%H', spec]
+    return command.output_one_line(*cmd)
 
 
 def get_head():
@@ -717,13 +733,18 @@ def get_head():
     return get_hash('HEAD')
 
 
-def get_branch():
+def get_branch(git_dir=None):
     """Get the branch we are currently on
 
     Return:
         str: branch name, or None if none
+        git_dir (str): Path to git repository (None to use default)
     """
-    out = command.output_one_line('git', 'rev-parse', '--abbrev-ref', 'HEAD')
+    cmd = ['git']
+    if git_dir:
+        cmd += ['--git-dir', git_dir]
+    cmd += ['rev-parse', '--abbrev-ref', 'HEAD']
+    out = command.output_one_line(*cmd, raise_on_error=False)
     if out == 'HEAD':
         return None
     return out
-- 
2.43.0

