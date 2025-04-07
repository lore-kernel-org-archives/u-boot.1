Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7736BC3601A
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 10:52:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 390FD82D6B;
	Mon,  7 Apr 2025 12:52:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="l4I1RlwR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AC6E82991; Mon,  7 Apr 2025 12:52:34 +0200 (CEST)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C65D782E68
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 12:52:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-22403cbb47fso42501365ad.0
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 03:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744023149; x=1744627949; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qjDegDFr4gCyCZQDblyq2svv+gdHdHLePLqi/yVKhwA=;
 b=l4I1RlwRsdBBpTMRv4TldqXGWBZbFO5vFda/yXi5r+N8HLPBYRGqQLGWE8w178Ewys
 ji+wDmb+HrEIAt20IYvYnVPOOIea6rJ+e+p75kGHIFqZlxzLUSFP1s/0V6jwuzzsrcfX
 PJaAykOAlw8hGUj8Hjav4b5Oj3lLodBnLAMDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744023149; x=1744627949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qjDegDFr4gCyCZQDblyq2svv+gdHdHLePLqi/yVKhwA=;
 b=vTs2jrW/BdiCZY16Tu+dcyQVXI2v/rWx6NE+KQJOShOGAsfiHm85VHLWAw4Qtnm1cj
 6r8BopMlaKHOtvi6N9rapIpqcvgnjJiUh49k2mBTxlKs9gWwwC5cJiqt7sJqTlXqRCWM
 QYRFuWMLpcZ7jkqtJ4cd/Gbbe1q+90l40lCURJEghTZD9LjTh4jgmfsWd5sCCcws5AQx
 mBaqPlAimfpcdv/evYycwGiLAMqYq12lM6mvyaIDwFxrYK7AAHk7lzC+0UwEevS1rU0k
 pJkGntx2raFYtk1ahlh0w3bzdJEURGYNltYGQkpllsUnDFgoCmkY4f5N5JF8103a/1BY
 W5gA==
X-Gm-Message-State: AOJu0YxT1exGHrQVV5H63TNGt4GfWuak6h8+b4N5gqTgdOI41m8Di2mN
 ilIzBqJvV6X4GRFsoHvF86omPExBruVMurbF8ri5Y9rtpMiFG226ZKGJGukyuftcl3fp3V7NBCY
 hwA==
X-Gm-Gg: ASbGncszdiJRi/bzeoqvlUpHHh3WcseBdzzFlpx3T4WdlFgcTGuppsCTyX2/Aaryd9K
 Svam0pfZ+O3nA7loqrXVkyDw9fFhxYnEKnlIwe0WZmdV3NJpY6gctpIup7jR+HhRog2WG+d/jio
 4vQnqFQi4usZLenWh4QQ4Kv583l6EZRZMddFtA7tQBcJ3SUEW6yEXxjhBEwZVfgOzrSJspYh6Mj
 obNJWxbFzjlk7aJiuuzue+K+glG1y5pmPZM9HmP/LlWnIPr3UXT/wnRjTaTLyy6BR5n8CUl5vAC
 kFCgU57FAvQ2TNqEK6RMwdUeNokKlUCciIOucg==
X-Google-Smtp-Source: AGHT+IHUQ5jQUtub0WGmk86LIx/HmoKZEmP7WnGWCvQfK365Z+T/jId3PNjtdSXi4RvIax3I2bus5A==
X-Received: by 2002:a17:903:13ce:b0:215:b75f:a1cb with SMTP id
 d9443c01a7336-22a8a85a251mr163946335ad.9.1744023148643; 
 Mon, 07 Apr 2025 03:52:28 -0700 (PDT)
Received: from chromium.org ([205.220.129.36])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739d97ee7a0sm8138736b3a.41.2025.04.07.03.52.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 03:52:27 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Douglas Anderson <dianders@chromium.org>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/5] patman: Pass the alias dict into gitutil.email_patches()
Date: Mon,  7 Apr 2025 22:51:45 +1200
Message-ID: <20250407105151.689453-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250407105151.689453-1-sjg@chromium.org>
References: <20250407105151.689453-1-sjg@chromium.org>
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

Rather than accessing the settings module in this function, require the
alias dict to be passed in.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/control.py       |  2 +-
 tools/patman/func_test.py     |  5 +++--
 tools/u_boot_pylib/gitutil.py | 19 ++++++++-----------
 3 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/tools/patman/control.py b/tools/patman/control.py
index c1b6e41e2d2..f578336c7cc 100644
--- a/tools/patman/control.py
+++ b/tools/patman/control.py
@@ -153,7 +153,7 @@ def email_patches(col, series, cover_fname, patch_files, process_tags, its_a_go,
     if its_a_go:
         cmd = gitutil.email_patches(
             series, cover_fname, patch_files, dry_run, not ignore_bad_tags,
-            cc_file, in_reply_to=in_reply_to, thread=thread,
+            cc_file, settings.alias, in_reply_to=in_reply_to, thread=thread,
             smtp_server=smtp_server)
     else:
         print(col.build(col.RED, "Not sending emails due to errors/warnings"))
diff --git a/tools/patman/func_test.py b/tools/patman/func_test.py
index 720746e21f5..b8fb49c34ba 100644
--- a/tools/patman/func_test.py
+++ b/tools/patman/func_test.py
@@ -206,13 +206,14 @@ class TestFunctional(unittest.TestCase):
         dry_run = True
         in_reply_to = mel
         count = 2
-        settings.alias = {
+        alias = {
             'fdt': ['simon'],
             'u-boot': ['u-boot@lists.denx.de'],
             'simon': [self.leb],
             'fred': [self.fred],
             'joe': [self.joe],
         }
+        settings.alias = alias
 
         text = self._get_text('test01.txt')
         series = patchstream.get_metadata_for_test(text)
@@ -231,7 +232,7 @@ class TestFunctional(unittest.TestCase):
                                         None, get_maintainer_script)
             cmd = gitutil.email_patches(
                 series, cover_fname, args, dry_run, not ignore_bad_tags,
-                cc_file, in_reply_to=in_reply_to, thread=None)
+                cc_file, alias, in_reply_to=in_reply_to, thread=None)
             series.ShowActions(args, cmd, process_tags)
         cc_lines = open(cc_file, encoding='utf-8').read().splitlines()
         os.remove(cc_file)
diff --git a/tools/u_boot_pylib/gitutil.py b/tools/u_boot_pylib/gitutil.py
index 7c9d0deecbb..7d3a0b68c53 100644
--- a/tools/u_boot_pylib/gitutil.py
+++ b/tools/u_boot_pylib/gitutil.py
@@ -5,7 +5,6 @@
 import os
 import sys
 
-from patman import settings
 from u_boot_pylib import command
 from u_boot_pylib import terminal
 
@@ -437,7 +436,7 @@ def check_suppress_cc_config():
 
 
 def email_patches(series, cover_fname, args, dry_run, warn_on_error, cc_fname,
-                  self_only=False, alias=None, in_reply_to=None, thread=False,
+                  alias, self_only=False, in_reply_to=None, thread=False,
                   smtp_server=None):
     """Email a patch series.
 
@@ -449,10 +448,10 @@ def email_patches(series, cover_fname, args, dry_run, warn_on_error, cc_fname,
         warn_on_error (bool): True to print a warning when an alias fails to
             match, False to ignore it.
         cc_fname (str): Filename of Cc file for per-commit Cc
-        self_only (bool): True to just email to yourself as a test
-        alias (dict or None): Alias dictionary: (None to use settings default)
+        alias (dict): Alias dictionary:
             key: alias
             value: list of aliases or email addresses
+        self_only (bool): True to just email to yourself as a test
         in_reply_to (str or None): If set we'll pass this to git as
             --in-reply-to - should be a message ID that this is in reply to.
         thread (bool): True to add --thread to git send-email (make
@@ -498,7 +497,7 @@ send --cc-cmd cc-fname" cover p1 p2'
     # Restore argv[0] since we clobbered it.
     >>> sys.argv[0] = _old_argv0
     """
-    to = build_email_list(series.get('to'), settings.alias, '--to', warn_on_error)
+    to = build_email_list(series.get('to'), alias, '--to', warn_on_error)
     if not to:
         git_config_to = command.output('git', 'config', 'sendemail.to',
                                        raise_on_error=False)
@@ -510,9 +509,9 @@ send --cc-cmd cc-fname" cover p1 p2'
                   "git config sendemail.to u-boot@lists.denx.de")
             return None
     cc = build_email_list(list(set(series.get('cc')) - set(series.get('to'))),
-                          settings.alias, '--cc', warn_on_error)
+                          alias, '--cc', warn_on_error)
     if self_only:
-        to = build_email_list([os.getenv('USER')], '--to', settings.alias,
+        to = build_email_list([os.getenv('USER')], '--to', alias,
                               warn_on_error)
         cc = []
     cmd = ['git', 'send-email', '--annotate']
@@ -535,14 +534,14 @@ send --cc-cmd cc-fname" cover p1 p2'
     return cmdstr
 
 
-def lookup_email(lookup_name, alias=None, warn_on_error=True, level=0):
+def lookup_email(lookup_name, alias, warn_on_error=True, level=0):
     """If an email address is an alias, look it up and return the full name
 
     TODO: Why not just use git's own alias feature?
 
     Args:
         lookup_name (str): Alias or email address to look up
-        alias (dict or None): Alias dictionary: (None to use settings default)
+        alias (dict): Alias dictionary
             key: alias
             value: list of aliases or email addresses
         warn_on_error (bool): True to print a warning when an alias fails to
@@ -589,8 +588,6 @@ def lookup_email(lookup_name, alias=None, warn_on_error=True, level=0):
     Recursive email alias at 'mary'
     ['j.bloggs@napier.co.nz', 'm.poppins@cloud.net']
     """
-    if not alias:
-        alias = settings.alias
     lookup_name = lookup_name.strip()
     if '@' in lookup_name:      # Perhaps a real email address
         return [lookup_name]
-- 
2.43.0

