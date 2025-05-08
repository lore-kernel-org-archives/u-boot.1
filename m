Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E32EC3ABBE
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 07:30:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D9FF829A0;
	Thu,  8 May 2025 09:29:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Yjs5XOnG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4189382999; Thu,  8 May 2025 09:29:27 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2104829A1
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 09:29:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43cfecdd8b2so4786675e9.2
 for <u-boot@lists.denx.de>; Thu, 08 May 2025 00:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746689363; x=1747294163; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/8vjE3/Qy4nfFvJSJwSE6ohXjFy3MPpaTN4Fl8geLQo=;
 b=Yjs5XOnG1wSydnEwNYy7QU9SDwwYVXBghna5Wih2rhwbVGN67x2VAnANh9SV7xevZw
 L8qdk6kVNgWqBH/fpunNg2OoHX6EspWsW8Vms0xb8qLNq4svHrehBhi6G3pQaEJIS8cB
 ChlmgEYpRrJ1qV6t4oJn44MUxpuI7A+6WgA6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746689363; x=1747294163;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/8vjE3/Qy4nfFvJSJwSE6ohXjFy3MPpaTN4Fl8geLQo=;
 b=vsAeI63Ff1byr/yyelu+p+56oT9LcjxW4Tr1Q+3L7O4OgRmHYrkNCBz+AWlTg8Y8k7
 joENpvbbnOz4btDiTLodIQ7AP+PLN+oSbMUBVjkB4+lyhBAegEelG0+/3FadUN3n8tdo
 EqFcxZvcn4yTX7kRVH0F29aghZRfHZUGRrVeUhgl2K7WBJJJxc0FxWoqj89gSppWWp5I
 62KFe8RttMvsMePtz0gpM3Sl+Ud4QE8tAzgph1zr5S6JSK3CXl9RLWX0HhklKdF1Vtsn
 K6pxP0gTFk9Av15Gl5zsllgLXrOmFr5hMRukVqYffyb2yADTP6WJOWEyo2EtS/mkLipG
 wWwg==
X-Gm-Message-State: AOJu0YyBdiJSZl9rzBCV1wwdN/9NYFJEPzn9/oFEeiZM+bpYv2pLcpZD
 x/tB1b9UVidu8h6uAwgXlr4LDTS8UNNSsr+tfOzdAN9PQ1lYM3Lemvnz2UXUO6F+5wwAmoCs8a7
 o6BAYrr+4Vw==
X-Gm-Gg: ASbGnct68xdINwre2TNSCwEwyTVs64UZPxU43AaQEN/yw0mkOIVgswSPLPqO7tWMZY5
 klLXfnOV2dS1LNVLaagG5EfjsgvJswBt/zaEuDkxUc7rvPs7+HkCXF5lFBY5KcsRuegdztQpm8c
 1ipz70Ma8951TobSbt/jQTR88WDMTyphNVPjvA25bZPI4N2fco0KVX3YzuhTN8lxG1mmXcCF98Q
 0vWd/ACGtDffBti5qwsCA8LuOHhFCs68H+NIXzmHAesARdKvOu954ttnZsK0RGNlzCqRu9W341C
 Tt6NOmkKSINBfoS0HVhSyKgwq9eQ9ycO1Ve6Vg==
X-Google-Smtp-Source: AGHT+IFzCHkWqsCi9yTIEAkoLX2L1p0AFwEoSwZmHRtvHhDVDYZRhb3F2i+REDfOg4W5JCS8wnvPDA==
X-Received: by 2002:a05:600c:3d0b:b0:43d:2230:300f with SMTP id
 5b1f17b1804b1-442d0221359mr25064895e9.0.1746689363486; 
 Thu, 08 May 2025 00:29:23 -0700 (PDT)
Received: from chromium.org ([213.157.19.150])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a0bd6999bfsm774375f8f.46.2025.05.08.00.29.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 May 2025 00:29:22 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Brian Norris <computersforpeace@gmail.com>,
 Douglas Anderson <dianders@chromium.org>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 06/20] patman: Allow setting a git directory when sending
Date: Thu,  8 May 2025 09:28:30 +0200
Message-ID: <20250508072907.207175-7-sjg@chromium.org>
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

Support specifying the git-directory when creating and sending patches.
This will allow better testing of this functionality, since we can use a
test directory.

For count_commits_to_branch() support an end commit while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/patchstream.py |  7 ++++---
 tools/patman/send.py        | 16 +++++++++-------
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/tools/patman/patchstream.py b/tools/patman/patchstream.py
index 3ec06a6b5f5..5691ee4b3c1 100644
--- a/tools/patman/patchstream.py
+++ b/tools/patman/patchstream.py
@@ -754,7 +754,7 @@ def get_metadata_for_list(commit_range, git_dir=None, count=None,
     pst.finalise()
     return series
 
-def get_metadata(branch, start, count):
+def get_metadata(branch, start, count, git_dir=None):
     """Reads out patch series metadata from the commits
 
     This does a 'git log' on the relevant commits and pulls out the tags we
@@ -769,8 +769,9 @@ def get_metadata(branch, start, count):
         Series: Object containing information about the commits.
     """
     top = f"{branch if branch else 'HEAD'}~{start}"
-    series = get_metadata_for_list(top, None, count)
-    series.base_commit = commit.Commit(gitutil.get_hash(f'{top}~{count}'))
+    series = get_metadata_for_list(top, git_dir, count)
+    series.base_commit = commit.Commit(
+        gitutil.get_hash(f'{top}~{count}', git_dir))
     series.branch = branch or gitutil.get_branch()
     series.top = top
     return series
diff --git a/tools/patman/send.py b/tools/patman/send.py
index a2db3cff07f..7989fe32f92 100644
--- a/tools/patman/send.py
+++ b/tools/patman/send.py
@@ -112,7 +112,7 @@ def email_patches(col, series, cover_fname, patch_files, process_tags, its_a_go,
 
 
 def prepare_patches(col, branch, count, start, end, ignore_binary, signoff,
-                    keep_change_id=False, cwd=None):
+                    keep_change_id=False, git_dir=None, cwd=None):
     """Figure out what patches to generate, then generate them
 
     The patch files are written to the current directory, e.g. 0001_xxx.patch
@@ -123,11 +123,12 @@ def prepare_patches(col, branch, count, start, end, ignore_binary, signoff,
         branch (str): Branch to create patches from (None = current)
         count (int): Number of patches to produce, or -1 to produce patches for
             the current branch back to the upstream commit
-        start (int): Start partch to use (0=first / top of branch)
+        start (int): Start patch to use (0=first / top of branch)
         end (int): End patch to use (0=last one in series, 1=one before that,
             etc.)
         ignore_binary (bool): Don't generate patches for binary files
         keep_change_id (bool): Preserve the Change-Id tag.
+        git_dir (str): Path to git repository (None to use default)
         cwd (str): Path to use for git operations (None to use current dir)
 
     Returns:
@@ -139,7 +140,8 @@ def prepare_patches(col, branch, count, start, end, ignore_binary, signoff,
     """
     if count == -1:
         # Work out how many patches to send if we can
-        count = (gitutil.count_commits_to_branch(branch) - start)
+        count = (gitutil.count_commits_to_branch(branch, git_dir=git_dir) -
+                 start)
 
     if not count:
         str = 'No commits found to process - please use -c flag, or run:\n' \
@@ -148,9 +150,9 @@ def prepare_patches(col, branch, count, start, end, ignore_binary, signoff,
 
     # Read the metadata from the commits
     to_do = count - end
-    series = patchstream.get_metadata(branch, start, to_do)
+    series = patchstream.get_metadata(branch, start, to_do, git_dir)
     cover_fname, patch_files = gitutil.create_patches(
-        branch, start, to_do, ignore_binary, series, signoff,
+        branch, start, to_do, ignore_binary, series, signoff, git_dir=git_dir,
         cwd=cwd)
 
     # Fix up the patch files to our liking, and insert the cover letter
@@ -161,7 +163,7 @@ def prepare_patches(col, branch, count, start, end, ignore_binary, signoff,
     return series, cover_fname, patch_files
 
 
-def send(args, cwd=None):
+def send(args, git_dir=None, cwd=None):
     """Create, check and send patches by email
 
     Args:
@@ -172,7 +174,7 @@ def send(args, cwd=None):
     series, cover_fname, patch_files = prepare_patches(
         col, args.branch, args.count, args.start, args.end,
         args.ignore_binary, args.add_signoff,
-        keep_change_id=args.keep_change_id, cwd=cwd)
+        keep_change_id=args.keep_change_id, git_dir=git_dir, cwd=cwd)
     ok = check_patches(series, patch_files, args.check_patch,
                        args.verbose, args.check_patch_use_tree, cwd)
 
-- 
2.43.0

