Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B590AC0219D
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 21:27:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5E9780944;
	Sun,  9 Feb 2025 22:27:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="L9ZYALRX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2117809D4; Sun,  9 Feb 2025 22:27:29 +0100 (CET)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C1058091A
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 22:27:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-3cf82bd380bso32650915ab.0
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 13:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739136445; x=1739741245; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X1A5ZicTAVrQ4mz/P+E1iDdCfsYBkVfqjCaUpWNZPUY=;
 b=L9ZYALRXaLfPiBzba5rC+aufbY38mNsDUtPXBhJ6gIgLDlL9XswaaVFgEKoKJNiQWt
 f2BgLbcLmVanX0c+hycuRxftwvHceV59k9XUdVIEDNe5BNbyOMH5OUDFDL8/6ImBcO6x
 v10oL6hqh0vIs2lJpSkCK8b83i+Qm4Ow6sfxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739136445; x=1739741245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X1A5ZicTAVrQ4mz/P+E1iDdCfsYBkVfqjCaUpWNZPUY=;
 b=Oj6yN7aFmIZiyHQiP/k9B2gDhfwT+lOiVRmDVZlyIQ6GOwGrmcEgrZ2YO557xifXqi
 OXZM9lCIEPG7neeAeYdRKf8qCQ/hawhmWLZLyIxIvmRjcaw4hunDQV3+HWD+MIcuqUhT
 DPKMwA9N/GGvFDUSTK3500c6k5c9vkYC7crKIXjQZ49d3vTv/Nr5UtMnqnqaqP1sNm0m
 Ry5nruw3wdDQmOzERQ6de22lysuWVDU17hjun3OIBXHZzoUZj5ZlWVDsk2a9X2yvi7c6
 nDmgKZMEDNCR81YcwBFHrqTSlo26FLpFfzGLlDpdo+NcyKJ01Xu5/FcOCRkFEMfDvlIv
 qZxA==
X-Gm-Message-State: AOJu0Yz0tduNPsHzI62OCRagtXHY29NkuaEiSoQ0NcclBSfj5MfEmjDt
 eLgeL7lM8a0ThDn5nKNeyk5AA5oBs9l5XrXCJ/SOFUNAu4YIyWvk1nx7OPm3UnZ4nWK/bzxMFw8
 =
X-Gm-Gg: ASbGncv/65G4r+HVMw74X0iwvTZx6F0TvsEkaSn6dCAyesv+219XT6DNbwa2AdP11hD
 e3aZUz9sQ/Y4Wk0nX3LLSg5yYv4NMxPBfVpQVKwex1IMPjng3zS+ocRqpJ4va/rLC/o3Jme9wJ0
 cc73iaPp8z08UWYfbXWxenNzjsLB+fdgDOtkCU0e9EY0oEESv5rqVxUMtXFdrC6zP0rRdyZnkHd
 UeLj8A3tkZd1t+s1sHLYGac2KRZfr7VTIFedP6KZ3vH1v5JqkjgrmhIarfSv8aw4BInmJwM3l5r
 r2cSzaCN9lZbFub4AvCkcHqOlYMdbzoO4WOPY5IF+1wSfiMMFJo0
X-Google-Smtp-Source: AGHT+IHuC2dJM424O6b2aAUiPO2wXoi6XLlffHQgl91SsX8PbTqkGMD0l14bUp3pJSjwEqigavYmwg==
X-Received: by 2002:a05:6e02:b2e:b0:3d0:137a:8c77 with SMTP id
 e9e14a558f8ab-3d13dd026c9mr94539405ab.3.1739136444624; 
 Sun, 09 Feb 2025 13:27:24 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d1586ba972sm5986835ab.43.2025.02.09.13.27.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Feb 2025 13:27:23 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Brandon Maier <brandon.maier@collins.com>
Subject: [PATCH 2/2] u_boot_pylib: Clean up pylint warnings in gitutil.py
Date: Sun,  9 Feb 2025 14:26:01 -0700
Message-ID: <20250209212714.2317040-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250209212714.2317040-1-sjg@chromium.org>
References: <20250209212714.2317040-1-sjg@chromium.org>
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

Reduce the number of warnings in this file.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/buildman/func_test.py   |   4 +-
 tools/u_boot_pylib/gitutil.py | 240 ++++++++++++++++++----------------
 2 files changed, 128 insertions(+), 116 deletions(-)

diff --git a/tools/buildman/func_test.py b/tools/buildman/func_test.py
index 6d3aaf1ce02..d70849b47ab 100644
--- a/tools/buildman/func_test.py
+++ b/tools/buildman/func_test.py
@@ -288,11 +288,11 @@ class TestFunctional(unittest.TestCase):
         """Test gitutils.Setup(), from outside the module itself"""
         command.TEST_RESULT = command.CommandResult(return_code=1)
         gitutil.setup()
-        self.assertEqual(gitutil.use_no_decorate, False)
+        self.assertEqual(gitutil.USE_NO_DECORATE, False)
 
         command.TEST_RESULT = command.CommandResult(return_code=0)
         gitutil.setup()
-        self.assertEqual(gitutil.use_no_decorate, True)
+        self.assertEqual(gitutil.USE_NO_DECORATE, True)
 
     def _HandleCommandGitLog(self, args):
         if args[-1] == '--':
diff --git a/tools/u_boot_pylib/gitutil.py b/tools/u_boot_pylib/gitutil.py
index 6d6a7eedecc..5e3e98ac9a6 100644
--- a/tools/u_boot_pylib/gitutil.py
+++ b/tools/u_boot_pylib/gitutil.py
@@ -10,7 +10,7 @@ from u_boot_pylib import command
 from u_boot_pylib import terminal
 
 # True to use --no-decorate - we check this in setup()
-use_no_decorate = True
+USE_NO_DECORATE = True
 
 
 def log_cmd(commit_range, git_dir=None, oneline=False, reverse=False,
@@ -18,11 +18,11 @@ def log_cmd(commit_range, git_dir=None, oneline=False, reverse=False,
     """Create a command to perform a 'git log'
 
     Args:
-        commit_range: Range expression to use for log, None for none
-        git_dir: Path to git repository (None to use default)
-        oneline: True to use --oneline, else False
-        reverse: True to reverse the log (--reverse)
-        count: Number of commits to list, or None for no limit
+        commit_range (str): Range expression to use for log, None for none
+        git_dir (str): Path to git repository (None to use default)
+        oneline (bool): True to use --oneline, else False
+        reverse (bool): True to reverse the log (--reverse)
+        count (int or None): Number of commits to list, or None for no limit
     Return:
         List containing command and arguments to run
     """
@@ -32,12 +32,12 @@ def log_cmd(commit_range, git_dir=None, oneline=False, reverse=False,
     cmd += ['--no-pager', 'log', '--no-color']
     if oneline:
         cmd.append('--oneline')
-    if use_no_decorate:
+    if USE_NO_DECORATE:
         cmd.append('--no-decorate')
     if reverse:
         cmd.append('--reverse')
     if count is not None:
-        cmd.append('-n%d' % count)
+        cmd.append(f'-n{count}')
     if commit_range:
         cmd.append(commit_range)
 
@@ -55,22 +55,22 @@ def count_commits_to_branch(branch):
     since then.
 
     Args:
-        branch: Branch to count from (None for current branch)
+        branch (str or None): Branch to count from (None for current branch)
 
     Return:
         Number of patches that exist on top of the branch
     """
     if branch:
-        us, msg = get_upstream('.git', branch)
-        rev_range = '%s..%s' % (us, branch)
+        us, _ = get_upstream('.git', branch)
+        rev_range = f'{us}..{branch}'
     else:
         rev_range = '@{upstream}..'
     cmd = log_cmd(rev_range, oneline=True)
     result = command.run_one(*cmd, capture=True, capture_stderr=True,
                              oneline=True, raise_on_error=False)
     if result.return_code:
-        raise ValueError('Failed to determine upstream: %s' %
-                         result.stderr.strip())
+        raise ValueError(
+            f'Failed to determine upstream: {result.stderr.strip()}')
     patch_count = len(result.stdout.splitlines())
     return patch_count
 
@@ -79,7 +79,7 @@ def name_revision(commit_hash):
     """Gets the revision name for a commit
 
     Args:
-        commit_hash: Commit hash to look up
+        commit_hash (str): Commit hash to look up
 
     Return:
         Name of revision, if any, else None
@@ -99,8 +99,8 @@ def guess_upstream(git_dir, branch):
     'git name-rev' returns a plain branch name, with no ! or ^ modifiers.
 
     Args:
-        git_dir: Git directory containing repo
-        branch: Name of branch
+        git_dir (str): Git directory containing repo
+        branch (str): Name of branch
 
     Returns:
         Tuple:
@@ -111,23 +111,23 @@ def guess_upstream(git_dir, branch):
     result = command.run_one(*cmd, capture=True, capture_stderr=True,
                              raise_on_error=False)
     if result.return_code:
-        return None, "Branch '%s' not found" % branch
+        return None, f"Branch '{branch}' not found"
     for line in result.stdout.splitlines()[1:]:
         commit_hash = line.split(' ')[0]
         name = name_revision(commit_hash)
         if '~' not in name and '^' not in name:
             if name.startswith('remotes/'):
                 name = name[8:]
-            return name, "Guessing upstream as '%s'" % name
-    return None, "Cannot find a suitable upstream for branch '%s'" % branch
+            return name, f"Guessing upstream as '{name}'"
+    return None, f"Cannot find a suitable upstream for branch '{branch}'"
 
 
 def get_upstream(git_dir, branch):
     """Returns the name of the upstream for a branch
 
     Args:
-        git_dir: Git directory containing repo
-        branch: Name of branch
+        git_dir (str): Git directory containing repo
+        branch (str): Name of branch
 
     Returns:
         Tuple:
@@ -136,31 +136,30 @@ def get_upstream(git_dir, branch):
     """
     try:
         remote = command.output_one_line('git', '--git-dir', git_dir, 'config',
-                                         'branch.%s.remote' % branch)
+                                         f'branch.{branch}.remote')
         merge = command.output_one_line('git', '--git-dir', git_dir, 'config',
-                                        'branch.%s.merge' % branch)
+                                        f'branch.{branch}.merge')
     except command.CommandExc:
         upstream, msg = guess_upstream(git_dir, branch)
         return upstream, msg
 
     if remote == '.':
         return merge, None
-    elif remote and merge:
+    if remote and merge:
         # Drop the initial refs/heads from merge
         leaf = merge.split('/', maxsplit=2)[2:]
-        return '%s/%s' % (remote, '/'.join(leaf)), None
-    else:
-        raise ValueError("Cannot determine upstream branch for branch "
-                         "'%s' remote='%s', merge='%s'"
-                         % (branch, remote, merge))
+        return f'{remote}/{"/".join(leaf)}', None
+    raise ValueError("Cannot determine upstream branch for branch "
+                     f"'{branch}' remote='{remote}', merge='{merge}'")
 
 
 def get_range_in_branch(git_dir, branch, include_upstream=False):
     """Returns an expression for the commits in the given branch.
 
     Args:
-        git_dir: Directory containing git repo
-        branch: Name of branch
+        git_dir (str): Directory containing git repo
+        branch (str): Name of branch
+        include_upstream (bool): Include the upstream commit as well
     Return:
         Expression in the form 'upstream..branch' which can be used to
         access the commits. If the branch does not exist, returns None.
@@ -168,7 +167,7 @@ def get_range_in_branch(git_dir, branch, include_upstream=False):
     upstream, msg = get_upstream(git_dir, branch)
     if not upstream:
         return None, msg
-    rstr = '%s%s..%s' % (upstream, '~' if include_upstream else '', branch)
+    rstr = f"{upstream}{'~' if include_upstream else ''}..{branch}"
     return rstr, msg
 
 
@@ -176,8 +175,8 @@ def count_commits_in_range(git_dir, range_expr):
     """Returns the number of commits in the given range.
 
     Args:
-        git_dir: Directory containing git repo
-        range_expr: Range to check
+        git_dir (str): Directory containing git repo
+        range_expr (str): Range to check
     Return:
         Number of patches that exist in the supplied range or None if none
         were found
@@ -186,7 +185,7 @@ def count_commits_in_range(git_dir, range_expr):
     result = command.run_one(*cmd, capture=True, capture_stderr=True,
                              raise_on_error=False)
     if result.return_code:
-        return None, "Range '%s' not found or is invalid" % range_expr
+        return None, f"Range '{range_expr}' not found or is invalid"
     patch_count = len(result.stdout.splitlines())
     return patch_count, None
 
@@ -195,8 +194,9 @@ def count_commits_in_branch(git_dir, branch, include_upstream=False):
     """Returns the number of commits in the given branch.
 
     Args:
-        git_dir: Directory containing git repo
-        branch: Name of branch
+        git_dir (str): Directory containing git repo
+        branch (str): Name of branch
+        include_upstream (bool): Include the upstream commit as well
     Return:
         Number of patches that exist on top of the branch, or None if the
         branch does not exist.
@@ -211,7 +211,7 @@ def count_commits(commit_range):
     """Returns the number of commits in the given range.
 
     Args:
-        commit_range: Range of commits to count (e.g. 'HEAD..base')
+        commit_range (str): Range of commits to count (e.g. 'HEAD..base')
     Return:
         Number of patches that exist on top of the branch
     """
@@ -226,7 +226,10 @@ def checkout(commit_hash, git_dir=None, work_tree=None, force=False):
     """Checkout the selected commit for this build
 
     Args:
-        commit_hash: Commit hash to check out
+        commit_hash (str): Commit hash to check out
+        git_dir (str): Directory containing git repo, or None for current dir
+        work_tree (str): Git worktree to use, or None if none
+        force (bool): True to force the checkout (git checkout -f)
     """
     pipe = ['git']
     if git_dir:
@@ -240,26 +243,28 @@ def checkout(commit_hash, git_dir=None, work_tree=None, force=False):
     result = command.run_pipe([pipe], capture=True, raise_on_error=False,
                               capture_stderr=True)
     if result.return_code != 0:
-        raise OSError('git checkout (%s): %s' % (pipe, result.stderr))
+        raise OSError(f'git checkout ({pipe}): {result.stderr}')
 
 
-def clone(git_dir, output_dir):
-    """Checkout the selected commit for this build
+def clone(repo, output_dir):
+    """Clone a repo
 
     Args:
-        commit_hash: Commit hash to check out
+        repo (str): Repo to clone (e.g. web address)
+        output_dir (str): Directory to close into
     """
-    result = command.run_one('git', 'clone', git_dir, '.', capture=True,
+    result = command.run_one('git', 'clone', repo, '.', capture=True,
                              cwd=output_dir, capture_stderr=True)
     if result.return_code != 0:
-        raise OSError('git clone: %s' % result.stderr)
+        raise OSError(f'git clone: {result.stderr}')
 
 
 def fetch(git_dir=None, work_tree=None):
     """Fetch from the origin repo
 
     Args:
-        commit_hash: Commit hash to check out
+        git_dir (str): Directory containing git repo, or None for current dir
+        work_tree (str or None): Git worktree to use, or None if none
     """
     cmd = ['git']
     if git_dir:
@@ -269,14 +274,14 @@ def fetch(git_dir=None, work_tree=None):
     cmd.append('fetch')
     result = command.run_one(*cmd, capture=True, capture_stderr=True)
     if result.return_code != 0:
-        raise OSError('git fetch: %s' % result.stderr)
+        raise OSError(f'git fetch: {result.stderr}')
 
 
 def check_worktree_is_available(git_dir):
     """Check if git-worktree functionality is available
 
     Args:
-        git_dir: The repository to test in
+        git_dir (str): The repository to test in
 
     Returns:
         True if git-worktree commands will work, False otherwise.
@@ -291,9 +296,9 @@ def add_worktree(git_dir, output_dir, commit_hash=None):
     """Create and checkout a new git worktree for this build
 
     Args:
-        git_dir: The repository to checkout the worktree from
-        output_dir: Path for the new worktree
-        commit_hash: Commit hash to checkout
+        git_dir (str): The repository to checkout the worktree from
+        output_dir (str): Path for the new worktree
+        commit_hash (str): Commit hash to checkout
     """
     # We need to pass --detach to avoid creating a new branch
     cmd = ['git', '--git-dir', git_dir, 'worktree', 'add', '.', '--detach']
@@ -302,19 +307,19 @@ def add_worktree(git_dir, output_dir, commit_hash=None):
     result = command.run_one(*cmd, capture=True, cwd=output_dir,
                              capture_stderr=True)
     if result.return_code != 0:
-        raise OSError('git worktree add: %s' % result.stderr)
+        raise OSError(f'git worktree add: {result.stderr}')
 
 
 def prune_worktrees(git_dir):
     """Remove administrative files for deleted worktrees
 
     Args:
-        git_dir: The repository whose deleted worktrees should be pruned
+        git_dir (str): The repository whose deleted worktrees should be pruned
     """
     result = command.run_one('git', '--git-dir', git_dir, 'worktree', 'prune',
                              capture=True, capture_stderr=True)
     if result.return_code != 0:
-        raise OSError('git worktree prune: %s' % result.stderr)
+        raise OSError(f'git worktree prune: {result.stderr}')
 
 
 def create_patches(branch, start, count, ignore_binary, series, signoff=True):
@@ -324,11 +329,12 @@ def create_patches(branch, start, count, ignore_binary, series, signoff=True):
     git format-patch.
 
     Args:
-        branch: Branch to create patches from (None for current branch)
-        start: Commit to start from: 0=HEAD, 1=next one, etc.
-        count: number of commits to include
-        ignore_binary: Don't generate patches for binary files
-        series: Series object for this series (set of patches)
+        branch (str): Branch to create patches from (None for current branch)
+        start (int): Commit to start from: 0=HEAD, 1=next one, etc.
+        count (int): number of commits to include
+        ignore_binary (bool): Don't generate patches for binary files
+        series (Series): Series object for this series (set of patches)
+        signoff (bool): True to add signoff lines automatically
     Return:
         Filename of cover letter (None if none)
         List of filenames of patch files
@@ -342,9 +348,9 @@ def create_patches(branch, start, count, ignore_binary, series, signoff=True):
         cmd.append('--cover-letter')
     prefix = series.GetPatchPrefix()
     if prefix:
-        cmd += ['--subject-prefix=%s' % prefix]
+        cmd += [f'--subject-prefix={prefix}']
     brname = branch or 'HEAD'
-    cmd += ['%s~%d..%s~%d' % (brname, start + count, brname, start)]
+    cmd += [f'{brname}~{start + count}..{brname}~{start}']
 
     stdout = command.run_list(cmd)
     files = stdout.splitlines()
@@ -352,8 +358,7 @@ def create_patches(branch, start, count, ignore_binary, series, signoff=True):
     # We have an extra file if there is a cover letter
     if series.get('cover'):
         return files[0], files[1:]
-    else:
-        return None, files
+    return None, files
 
 
 def build_email_list(in_list, tag=None, alias=None, warn_on_error=True):
@@ -367,11 +372,13 @@ def build_email_list(in_list, tag=None, alias=None, warn_on_error=True):
     command line parameter) then the email address is quoted.
 
     Args:
-        in_list:        List of aliases/email addresses
-        tag:            Text to put before each address
-        alias:          Alias dictionary
-        warn_on_error: True to raise an error when an alias fails to match,
-                False to just print a message.
+        in_list (list of str): List of aliases/email addresses
+        tag (str): Text to put before each address
+        alias (dict): Alias dictionary:
+            key: alias
+            value: list of aliases or email addresses
+        warn_on_error (bool): True to raise an error when an alias fails to
+            match, False to just print a message.
 
     Returns:
         List of email addresses
@@ -399,7 +406,7 @@ def build_email_list(in_list, tag=None, alias=None, warn_on_error=True):
         if item not in result:
             result.append(item)
     if tag:
-        return ['%s %s%s%s' % (tag, quote, email, quote) for email in result]
+        return [f'{tag} {quote}{email}{quote}' for email in result]
     return result
 
 
@@ -407,24 +414,23 @@ def check_suppress_cc_config():
     """Check if sendemail.suppresscc is configured correctly.
 
     Returns:
-        True if the option is configured correctly, False otherwise.
+        bool: True if the option is configured correctly, False otherwise.
     """
     suppresscc = command.output_one_line(
         'git', 'config', 'sendemail.suppresscc', raise_on_error=False)
 
     # Other settings should be fine.
-    if suppresscc == 'all' or suppresscc == 'cccmd':
+    if suppresscc in ('all', 'cccmd'):
         col = terminal.Color()
 
-        print((col.build(col.RED, "error") +
-               ": git config sendemail.suppresscc set to %s\n"
-               % (suppresscc)) +
-              "  patman needs --cc-cmd to be run to set the cc list.\n" +
-              "  Please run:\n" +
-              "    git config --unset sendemail.suppresscc\n" +
-              "  Or read the man page:\n" +
-              "    git send-email --help\n" +
-              "  and set an option that runs --cc-cmd\n")
+        print(col.build(col.RED, 'error') +
+              f': git config sendemail.suppresscc set to {suppresscc}\n' +
+              '  patman needs --cc-cmd to be run to set the cc list.\n' +
+              '  Please run:\n' +
+              '    git config --unset sendemail.suppresscc\n' +
+              '  Or read the man page:\n' +
+              '    git send-email --help\n' +
+              '  and set an option that runs --cc-cmd\n')
         return False
 
     return True
@@ -432,24 +438,26 @@ def check_suppress_cc_config():
 
 def email_patches(series, cover_fname, args, dry_run, warn_on_error, cc_fname,
                   self_only=False, alias=None, in_reply_to=None, thread=False,
-                  smtp_server=None, get_maintainer_script=None):
+                  smtp_server=None):
     """Email a patch series.
 
     Args:
-        series: Series object containing destination info
-        cover_fname: filename of cover letter
-        args: list of filenames of patch files
-        dry_run: Just return the command that would be run
-        warn_on_error: True to print a warning when an alias fails to match,
-                False to ignore it.
-        cc_fname: Filename of Cc file for per-commit Cc
-        self_only: True to just email to yourself as a test
-        in_reply_to: If set we'll pass this to git as --in-reply-to.
-            Should be a message ID that this is in reply to.
-        thread: True to add --thread to git send-email (make
+        series (Series): Series object containing destination info
+        cover_fname (str or None): filename of cover letter
+        args (list of str): list of filenames of patch files
+        dry_run (bool): Just return the command that would be run
+        warn_on_error (bool): True to print a warning when an alias fails to
+            match, False to ignore it.
+        cc_fname (str): Filename of Cc file for per-commit Cc
+        self_only (bool): True to just email to yourself as a test
+        alias (dict or None): Alias dictionary: (None to use settings default)
+            key: alias
+            value: list of aliases or email addresses
+        in_reply_to (str or None): If set we'll pass this to git as
+            --in-reply-to - should be a message ID that this is in reply to.
+        thread (bool): True to add --thread to git send-email (make
             all patches reply to cover-letter or first patch in series)
-        smtp_server: SMTP server to use to send patches
-        get_maintainer_script: File name of script to get maintainers emails
+        smtp_server (str or None): SMTP server to use to send patches
 
     Returns:
         Git command that was/would be run
@@ -500,7 +508,7 @@ send --cc-cmd cc-fname" cover p1 p2'
                   "Series-to: Fred Bloggs <f.blogs@napier.co.nz>\n"
                   "Or do something like this\n"
                   "git config sendemail.to u-boot@lists.denx.de")
-            return
+            return None
     cc = build_email_list(list(set(series.get('cc')) - set(series.get('to'))),
                           '--cc', alias, warn_on_error)
     if self_only:
@@ -509,15 +517,15 @@ send --cc-cmd cc-fname" cover p1 p2'
         cc = []
     cmd = ['git', 'send-email', '--annotate']
     if smtp_server:
-        cmd.append('--smtp-server=%s' % smtp_server)
+        cmd.append(f'--smtp-server={smtp_server}')
     if in_reply_to:
-        cmd.append('--in-reply-to="%s"' % in_reply_to)
+        cmd.append(f'--in-reply-to="{in_reply_to}"')
     if thread:
         cmd.append('--thread')
 
     cmd += to
     cmd += cc
-    cmd += ['--cc-cmd', '"%s send --cc-cmd %s"' % (sys.argv[0], cc_fname)]
+    cmd += ['--cc-cmd', f'"{sys.argv[0]} send --cc-cmd {cc_fname}"']
     if cover_fname:
         cmd.append(cover_fname)
     cmd += args
@@ -533,10 +541,13 @@ def lookup_email(lookup_name, alias=None, warn_on_error=True, level=0):
     TODO: Why not just use git's own alias feature?
 
     Args:
-        lookup_name: Alias or email address to look up
-        alias: Dictionary containing aliases (None to use settings default)
-        warn_on_error: True to print a warning when an alias fails to match,
-                False to ignore it.
+        lookup_name (str): Alias or email address to look up
+        alias (dict or None): Alias dictionary: (None to use settings default)
+            key: alias
+            value: list of aliases or email addresses
+        warn_on_error (bool): True to print a warning when an alias fails to
+            match, False to ignore it.
+        level (int): Depth of alias stack, used to detect recusion/loops
 
     Returns:
         tuple:
@@ -589,16 +600,15 @@ def lookup_email(lookup_name, alias=None, warn_on_error=True, level=0):
 
     out_list = []
     if level > 10:
-        msg = "Recursive email alias at '%s'" % lookup_name
+        msg = f"Recursive email alias at '{lookup_name}'"
         if warn_on_error:
             raise OSError(msg)
-        else:
-            print(col.build(col.RED, msg))
-            return out_list
+        print(col.build(col.RED, msg))
+        return out_list
 
     if lookup_name:
         if lookup_name not in alias:
-            msg = "Alias '%s' not found" % lookup_name
+            msg = f"Alias '{lookup_name}' not found"
             if warn_on_error:
                 print(col.build(col.RED, msg))
             return out_list
@@ -615,7 +625,7 @@ def get_top_level():
     """Return name of top-level directory for this git repo.
 
     Returns:
-        Full path to git top-level directory
+        str: Full path to git top-level directory
 
     This test makes sure that we are running tests in the right subdir
 
@@ -630,7 +640,7 @@ def get_alias_file():
     """Gets the name of the git alias file.
 
     Returns:
-        Filename of git alias file, or None if none
+        str: Filename of git alias file, or None if none
     """
     fname = command.output_one_line('git', 'config', 'sendemail.aliasesfile',
                                     raise_on_error=False)
@@ -650,7 +660,8 @@ def get_default_user_name():
     Returns:
         User name found in .gitconfig file, or None if none
     """
-    uname = command.output_one_line('git', 'config', '--global', '--includes', 'user.name')
+    uname = command.output_one_line('git', 'config', '--global', '--includes',
+                                    'user.name')
     return uname
 
 
@@ -660,7 +671,8 @@ def get_default_user_email():
     Returns:
         User's email found in .gitconfig file, or None if none
     """
-    uemail = command.output_one_line('git', 'config', '--global', '--includes', 'user.email')
+    uemail = command.output_one_line('git', 'config', '--global', '--includes',
+                                     'user.email')
     return uemail
 
 
@@ -677,15 +689,15 @@ def get_default_subject_prefix():
 
 
 def setup():
-    """Set up git utils, by reading the alias files."""
+    """setup() - Set up git utils, by reading the alias files."""
     # Check for a git alias file also
-    global use_no_decorate
+    global USE_NO_DECORATE
 
     alias_fname = get_alias_file()
     if alias_fname:
         settings.ReadGitAliases(alias_fname)
     cmd = log_cmd(None, count=0)
-    use_no_decorate = (command.run_one(*cmd, raise_on_error=False)
+    USE_NO_DECORATE = (command.run_one(*cmd, raise_on_error=False)
                        .return_code == 0)
 
 
-- 
2.43.0

