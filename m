Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9D7AC3ABC3
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 11:06:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A52318295C;
	Sat, 10 May 2025 13:05:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OgTZNqk5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6997C80ADF; Sat, 10 May 2025 13:05:55 +0200 (CEST)
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com
 [IPv6:2a00:1450:4864:20::542])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64E4580ADF
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 13:05:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x542.google.com with SMTP id
 4fb4d7f45d1cf-5f7ec0e4978so5270944a12.1
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 04:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746875152; x=1747479952; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2qkeP6L4iSgqhbOuoUYwlnWE70+xaXaXGQwTReesnf0=;
 b=OgTZNqk5YlVmjUZF84X0t45F0wXRn0Qlc3Fja+VQ7BQ707SRpLLefzI++K4p5c8/OY
 LtSv6Dgmaq+543zXpSOj2RCuaV0CeXIRR+EEFcNlPlS5o9b7ZVDoS7fxABz/MhyFrfYo
 MLtj6+KulNYcu+27CbohV43QPT+YHbvUQMBgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746875152; x=1747479952;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2qkeP6L4iSgqhbOuoUYwlnWE70+xaXaXGQwTReesnf0=;
 b=GqbytIf9et8A4hG6v6I38wPk5VOde4xHbgZneYl5SvbVPEaEwWN4NfrmYmmwkfFBCB
 RxKwkUZI8AqzIUwI1ZZ/UCdev/Wtx4EA/VYThb3XZWGPsJGFbXE2WcRDRWPWrzPt3Q4L
 hUESSeRtmSc/+6WbeKN6ZRZCM8gChElLMoESpUddoq2yrdyH4CoaoQYSlEX9COX9Fnds
 O9WfsnjBzqqxxyHNTFQ3CVAbDVCtnvqQ3Wrxl4hi2mLxad4Ra9KUeMQ1NTkCj39hO9FE
 oA5fWic9P5ogwDfpzRJ4JZ46uDLblfeYFXZ6tn/5PYV9lTxliGy1VaQMtjZhJtuCQUwq
 iexQ==
X-Gm-Message-State: AOJu0YzLALhylJZcZLDEmaIpXs3OqrRJLEbBgB7IMaormbsO9HEJnpio
 5rOiu9sYRb4j79NSlah9oh0qbTnAkNtvpujZGEHx8K52Gnb6J3pfiaTt+y+un9xN9/fIaGek67f
 EkEwLorY75aeV
X-Gm-Gg: ASbGncvtDxhWZ4rRwYxGQw3jo8d7H6Yh9jIKzBDYIa/hVcd7p5zXnr23vl+vXcyq28Y
 nLo1Lpa32c466Ct9NHCEnUZ66qQ/lB+GWfVO3Lrxf/nIc5CkTN455owZfdbKfDmQXTjJRsrfZfc
 PFT5P07JWH79174Ru7AXIfKipMZI2xL0bRWbpjuVpA1oWLZkoMjvt3u3+95MvwtJwXnPGpF0/Qv
 Lw6fAIahku+KSeO8nSaHNi8Y73NEjDMMwykB5fU9bBh0qW08K5BkWDKD0OGepsVDnGScrzaZpsq
 1y8A92xBK7f1hiqGe92aGoPR6k3yjUrCpmqLETQLoN2lzUw=
X-Google-Smtp-Source: AGHT+IE+05RA+lDS28eVPbQcZhKS9i7Xvtz2tcjZcupPqMrbtUvUc2iEsakou57Pf2SGxR5ACKbLpg==
X-Received: by 2002:a17:906:c155:b0:ace:cdfc:40aa with SMTP id
 a640c23a62f3a-ad218f0f1e1mr634836966b.19.1746875152311; 
 Sat, 10 May 2025 04:05:52 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad2192c8b8asm300148866b.5.2025.05.10.04.05.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 May 2025 04:05:51 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Brandon Maier <brandon.maier@collins.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 02/25] patman: Deal with git safe-directory warning
Date: Sat, 10 May 2025 13:04:55 +0200
Message-ID: <20250510110535.1453745-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250510110535.1453745-1-sjg@chromium.org>
References: <20250510110535.1453745-1-sjg@chromium.org>
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

When running tests where the .git directory is not owned by the current
user, various warnings are produced and the tests fail. This happens in
CI.

For patman itself, modify the gitutil.get_top_level() function to return
None in this case. Ensure that the warning is not shown, since it creates
about 1000 lines of output.

For checkpatch, the same warning is produced even though --no-tree is
given. Suppress that as well.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/checkpatch.py     |  7 ++++---
 tools/patman/cmdline.py        |  8 ++++++--
 tools/patman/get_maintainer.py | 13 ++++++++-----
 tools/patman/project.py        |  3 ++-
 tools/patman/settings.py       |  3 ++-
 tools/u_boot_pylib/gitutil.py  | 11 ++++++++---
 6 files changed, 30 insertions(+), 15 deletions(-)

diff --git a/tools/patman/checkpatch.py b/tools/patman/checkpatch.py
index 5df06b1095a..f9204a907ef 100644
--- a/tools/patman/checkpatch.py
+++ b/tools/patman/checkpatch.py
@@ -22,7 +22,7 @@ RE_NOTE = re.compile(r'NOTE: (.*)')
 
 
 def find_check_patch():
-    top_level = gitutil.get_top_level()
+    top_level = gitutil.get_top_level() or ''
     try_list = [
         os.getcwd(),
         os.path.join(os.getcwd(), '..', '..'),
@@ -219,8 +219,9 @@ def check_patch(fname, verbose=False, show_types=False, use_tree=False,
         args.append('--no-tree')
     if show_types:
         args.append('--show-types')
-    output = command.output(*args, os.path.join(cwd or '', fname),
-                            raise_on_error=False)
+    output = command.output(
+        *args, os.path.join(cwd or '', fname), raise_on_error=False,
+        capture_stderr=not use_tree)
 
     return check_patch_parse(output, verbose)
 
diff --git a/tools/patman/cmdline.py b/tools/patman/cmdline.py
index 0ae92f88c4b..108fa52d820 100644
--- a/tools/patman/cmdline.py
+++ b/tools/patman/cmdline.py
@@ -44,11 +44,15 @@ def add_send_args(par):
         '-m', '--no-maintainers', action='store_false',
         dest='add_maintainers', default=True,
         help="Don't cc the file maintainers automatically")
+    default_arg = None
+    top_level = gitutil.get_top_level()
+    if top_level:
+        default_arg = os.path.join(top_level, 'scripts',
+                                   'get_maintainer.pl') + ' --norolestats'
     par.add_argument(
         '--get-maintainer-script', dest='get_maintainer_script', type=str,
         action='store',
-        default=os.path.join(gitutil.get_top_level(), 'scripts',
-                             'get_maintainer.pl') + ' --norolestats',
+        default=default_arg,
         help='File name of the get_maintainer.pl (or compatible) script.')
     par.add_argument(
         '-r', '--in-reply-to', type=str, action='store',
diff --git a/tools/patman/get_maintainer.py b/tools/patman/get_maintainer.py
index 200ee96551d..1c8fa726573 100644
--- a/tools/patman/get_maintainer.py
+++ b/tools/patman/get_maintainer.py
@@ -21,7 +21,7 @@ def find_get_maintainer(script_file_name):
     if get_maintainer:
         return get_maintainer
 
-    git_relative_script = os.path.join(gitutil.get_top_level(),
+    git_relative_script = os.path.join(gitutil.get_top_level() or '',
                                        script_file_name)
     if os.path.exists(git_relative_script):
         return git_relative_script
@@ -46,11 +46,14 @@ def get_maintainer(script_file_name, fname, verbose=False):
     """
     # Expand `script_file_name` into a file name and its arguments, if
     # any.
-    cmd_args = shlex.split(script_file_name)
-    file_name = cmd_args[0]
-    arguments = cmd_args[1:]
+    get_maintainer = None
+    arguments = None
+    if script_file_name:
+        cmd_args = shlex.split(script_file_name)
+        file_name = cmd_args[0]
+        arguments = cmd_args[1:]
 
-    get_maintainer = find_get_maintainer(file_name)
+        get_maintainer = find_get_maintainer(file_name)
     if not get_maintainer:
         if verbose:
             print("WARNING: Couldn't find get_maintainer.pl")
diff --git a/tools/patman/project.py b/tools/patman/project.py
index d6143a67066..e633401e9d6 100644
--- a/tools/patman/project.py
+++ b/tools/patman/project.py
@@ -18,7 +18,8 @@ def detect_project():
     """
     top_level = gitutil.get_top_level()
 
-    if os.path.exists(os.path.join(top_level, "include", "u-boot")):
+    if (not top_level or
+            os.path.exists(os.path.join(top_level, "include", "u-boot"))):
         return "u-boot"
     elif os.path.exists(os.path.join(top_level, "kernel")):
         return "linux"
diff --git a/tools/patman/settings.py b/tools/patman/settings.py
index 7a0866cd370..def932db43a 100644
--- a/tools/patman/settings.py
+++ b/tools/patman/settings.py
@@ -364,7 +364,8 @@ def Setup(parser, project_name, argv, config_fname=None):
 
     if config_fname is None:
         config_fname = '%s/.patman' % os.getenv('HOME')
-    git_local_config_fname = os.path.join(gitutil.get_top_level(), '.patman')
+    git_local_config_fname = os.path.join(gitutil.get_top_level() or '',
+                                          '.patman')
 
     has_config = False
     has_git_local_config = False
diff --git a/tools/u_boot_pylib/gitutil.py b/tools/u_boot_pylib/gitutil.py
index cfcfeffe2f4..7d001d03bed 100644
--- a/tools/u_boot_pylib/gitutil.py
+++ b/tools/u_boot_pylib/gitutil.py
@@ -644,7 +644,7 @@ def get_top_level():
     """Return name of top-level directory for this git repo.
 
     Returns:
-        str: Full path to git top-level directory
+        str: Full path to git top-level directory, or None if not found
 
     This test makes sure that we are running tests in the right subdir
 
@@ -652,7 +652,12 @@ def get_top_level():
             os.path.join(get_top_level(), 'tools', 'patman')
     True
     """
-    return command.output_one_line('git', 'rev-parse', '--show-toplevel')
+    result = command.run_one(
+        'git', 'rev-parse', '--show-toplevel', oneline=True, capture=True,
+        capture_stderr=True, raise_on_error=False)
+    if result.return_code:
+        return None
+    return result.stdout.strip()
 
 
 def get_alias_file():
@@ -670,7 +675,7 @@ def get_alias_file():
     if os.path.isabs(fname):
         return fname
 
-    return os.path.join(get_top_level(), fname)
+    return os.path.join(get_top_level() or '', fname)
 
 
 def get_default_user_name():
-- 
2.43.0

