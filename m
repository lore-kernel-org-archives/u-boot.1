Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA56C3ABC0
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 07:30:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7A33829D4;
	Thu,  8 May 2025 09:29:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iH2mn1Kw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB51B8059D; Thu,  8 May 2025 09:29:35 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04A6C829D4
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 09:29:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3a108684f90so25805f8f.1
 for <u-boot@lists.denx.de>; Thu, 08 May 2025 00:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746689370; x=1747294170; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=or8ybXeDfxJd0iFICpiDx3YhfUlFmztzXJN3tK6wbcc=;
 b=iH2mn1Kwotj2p7nMe+DOOsSfTJU45by+YL41FAsSCtewev4XsqaTvHtR1jHNxvuHw/
 M5qo5sBQg9MGeIjziEp+bVoKLdz+mWut91IJtvRjd0dB38+u63NGkwnp6KAfvrbFBHU8
 HkxeFri/vQuXFtnQXvWODhJgg3jluJ4EydAvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746689370; x=1747294170;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=or8ybXeDfxJd0iFICpiDx3YhfUlFmztzXJN3tK6wbcc=;
 b=iU53oNkxuZ12aof+U4szIFVi4pM1IJ4WRKSKznqQ6MWJBlbZAEda5uh5eVOPlJ+6Px
 Y49Z3EoggPjJ6X8kL9buYcpM9zvUmTHq0ZJf8G+/8CjTp22pbZfjN1BRLGd/VBdWQtLp
 ZRzVpZY2V/DP2MqosodCbej0RoUOoV+CadxdND1FT7et3h9Xop4z8ObySdV68JMGqPVx
 NBsp5gvR4Jv2+E47iZCAKaXnKti2FmEJwC4sfNxkLQIPVY7qzyclSmAyqTzMy/XPn8vz
 GBpwxTyd+Vxjh3IDsatYlfS9QL54A4RlxEg4DtV5K7bx5DK/wOtPjm87uc3d/ORtDk5f
 aivw==
X-Gm-Message-State: AOJu0Yzdl22eyuy4qLq3p9ZRm45kXdqqpdv0Fxi/eXfo7p9CwLLdfbKw
 knL6Mp8gzzy/ADUQhNudloaSpUT/b0jUtUJkNvzSpMqSt4jsK37hjFdm6zYhREFPcjFQ68YZsTp
 s5Cmdr2t1TA==
X-Gm-Gg: ASbGncvrBQcrjwidHJsYy6YMQULawAYFUUILyzEg4jAQPL1E1CO4ENl8Kia46N5JoYA
 zbvmvUrMu972il665sdlfTsSZNhQTcptCRzCKZFAVdV1tjiaYGZ5M1lsfKsDD/gZs4MY1zIfHCS
 TklYZcV4jaWvy/xkJRl/CUZImMlWHZeUvORVIHYjhUZWpWwQ4nEa0ofl34BuvDqe/ansOjmYOUb
 9DMO7zQn+bB2kairnqCzhUaXHFe9olUFGnkRqKXDVqFt6hCjlbVz6dCAsZmC513hZ6DGHXGsQAf
 d748YjiXXz27O5RpLryoTml28EhPDwpXBURUDw==
X-Google-Smtp-Source: AGHT+IHEqbp6d0juBiSmZp/4/FpjBw+xkzFNzx01anDy51vb9zxL6nUHqFH3LUGLzVJ1aLN1bZfCxA==
X-Received: by 2002:adf:a442:0:b0:39c:c64e:cf58 with SMTP id
 ffacd0b85a97d-3a0ba1052damr1182745f8f.55.1746689370581; 
 Thu, 08 May 2025 00:29:30 -0700 (PDT)
Received: from chromium.org ([213.157.19.150])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a0bd6999bfsm774375f8f.46.2025.05.08.00.29.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 May 2025 00:29:29 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 09/20] patman: Use .git as the git directory
Date: Thu,  8 May 2025 09:28:33 +0200
Message-ID: <20250508072907.207175-10-sjg@chromium.org>
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

In tests, the 'git' directory is a subdirectory of the temporary
directory. Rename it to '.git' so that git will automatically find it
when git operations are done in the temporary directory. Set up the
config before the first git operation, so that this works correctly.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/func_test.py | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/patman/func_test.py b/tools/patman/func_test.py
index 624f388966e..5ddefc3a9b1 100644
--- a/tools/patman/func_test.py
+++ b/tools/patman/func_test.py
@@ -78,7 +78,7 @@ class TestFunctional(unittest.TestCase):
 
     def setUp(self):
         self.tmpdir = tempfile.mkdtemp(prefix='patman.')
-        self.gitdir = os.path.join(self.tmpdir, 'git')
+        self.gitdir = os.path.join(self.tmpdir, '.git')
         self.repo = None
 
     def tearDown(self):
@@ -416,7 +416,7 @@ Changes in v2:
             fname (str): Filename of file to create
             text (str): Text to put into the file
         """
-        path = os.path.join(self.gitdir, fname)
+        path = os.path.join(self.tmpdir, fname)
         tools.write_file(path, text, binary=False)
         index = self.repo.index
         index.add(fname)
@@ -550,7 +550,7 @@ complicated as possible''')
         control.setup()
         orig_dir = os.getcwd()
         try:
-            os.chdir(self.gitdir)
+            os.chdir(self.tmpdir)
 
             # Check that it can detect the current branch
             self.assertEqual(2, gitutil.count_commits_to_branch(None))
@@ -602,7 +602,7 @@ complicated as possible''')
     def test_custom_get_maintainer_script(self):
         """Validate that a custom get_maintainer script gets used."""
         self.make_git_tree()
-        with directory_excursion(self.gitdir):
+        with directory_excursion(self.tmpdir):
             # Setup git.
             os.environ['GIT_CONFIG_GLOBAL'] = '/dev/null'
             os.environ['GIT_CONFIG_SYSTEM'] = '/dev/null'
@@ -610,8 +610,6 @@ complicated as possible''')
             tools.run('git', 'config', 'user.email', 'dumdum@dummy.com')
             tools.run('git', 'branch', 'upstream')
             tools.run('git', 'branch', '--set-upstream-to=upstream')
-            tools.run('git', 'add', '.')
-            tools.run('git', 'commit', '-m', 'new commit')
 
             # Setup patman configuration.
             with open('.patman', 'w', buffering=1) as f:
@@ -623,6 +621,8 @@ complicated as possible''')
                 f.write('#!/usr/bin/env python\n'
                         'print("hello@there.com")\n')
             os.chmod('dummy-script.sh', 0x555)
+            tools.run('git', 'add', '.')
+            tools.run('git', 'commit', '-m', 'new commit')
 
             # Finally, do the test
             with terminal.capture():
@@ -1108,7 +1108,7 @@ diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
         branch = 'first'
         dest_branch = 'first2'
         count = 2
-        gitdir = os.path.join(self.gitdir, '.git')
+        gitdir = self.gitdir
 
         # Set up the test git tree. We use branch 'first' which has two commits
         # in it
-- 
2.43.0

