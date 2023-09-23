Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52E58CE7A89
	for <u-boot@archiver.kernel.org>; Sat, 23 Sep 2023 19:48:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A047686BC1;
	Sat, 23 Sep 2023 21:45:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RqE3bZ8I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4582186B8A; Sat, 23 Sep 2023 21:44:56 +0200 (CEST)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40F4D86B79
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 21:44:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-34fd43afcc5so11971945ab.0
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 12:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695498291; x=1696103091; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fsFY33ClEM09TM1fvb+iT6M6aB2N9VNMIphemKUwOXA=;
 b=RqE3bZ8IengWinstrMl00QQyb9Sz7cjLCOXejeFLkdjtU80NKLyFTFTB4BirRR172L
 m66yHvlyfbNHI5x0Lv6yxD5yGRSyMF2IZTKunouuJ6A3xjWiTnOHNLWO3799DixCULiE
 DfRsu/tKHa6ssCgAo6wTtxRxeH3ZP08cPc3sE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695498291; x=1696103091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fsFY33ClEM09TM1fvb+iT6M6aB2N9VNMIphemKUwOXA=;
 b=JOkojy1yNYTOgzdF65iuTynY2Dj9JyXW2a+wNJswx3lcEsnBXUqjQcJLSwtkOicD1B
 MNpZehmSIEFBbPGqYZDwxv12e43JI6/c26JJAk81wWcmDbEzpavgOBsanLKPHl9zCLhI
 vZhebdr9b4lhn0KLKb2Srx7otG1cLhnLJfNMgCOH4M6ydaTHkBo7MDlatiC+6acxMEew
 1T50D6ILkRFLcbjgfOokfYt2KVEp+GiEFXx4Qm5e1ooStl4/MerE8yaVb84IrZDDvnqZ
 DXdlbPloPBviaZwmFnPlQyV20C4unbHFAsxQYZTLgMguxvEfIl+p7ctjFPf9CrqwPoRh
 ZBRg==
X-Gm-Message-State: AOJu0YythjT5IwWpg6AtNccEzyHGzDK9spB7NilFS/1I6i+XcjSaAjr/
 oiQS6w5NUQMJSW9q4ic6YT6wowUnawc4Z4as74c=
X-Google-Smtp-Source: AGHT+IF+inj2p5xMV8nyl7x7mhqJw33VAV/MwnwUGiee6zyZl8Kpv8mXqDx4lh36kZqQ80wt3CKj/Q==
X-Received: by 2002:a05:6e02:20e1:b0:34f:d79b:85bd with SMTP id
 q1-20020a056e0220e100b0034fd79b85bdmr5143910ilv.2.1695498291285; 
 Sat, 23 Sep 2023 12:44:51 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 el9-20020a0566384d8900b00439d4db47b6sm1697786jab.39.2023.09.23.12.44.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Sep 2023 12:44:51 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 22/27] moveconfig: Show a summary at the end
Date: Sat, 23 Sep 2023 13:44:11 -0600
Message-ID: <20230923194424.1739224-23-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230923194424.1739224-1-sjg@chromium.org>
References: <20230923194424.1739224-1-sjg@chromium.org>
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

Rather than printing all the failed boards, which are now easily visible
on the terminal, just show a summary. Sort it by defconfig and drop the
'_defconfig' suffix.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/tools/moveconfig.py b/tools/moveconfig.py
index 2a4badf8649a..c6d7c53f8b89 100755
--- a/tools/moveconfig.py
+++ b/tools/moveconfig.py
@@ -571,8 +571,8 @@ class Slot:
                    successfully, or False when it fails.
         """
         # output at least 30 characters to hide the "* defconfigs out of *".
+        name = self.defconfig[:-len('_defconfig')]
         if self.log:
-            name = self.defconfig[:-len('_defconfig')]
 
             # Put the first log line on the first line
             log = name.ljust(20) + ' ' + self.log[0]
@@ -588,7 +588,7 @@ class Slot:
                 sys.exit('Exit on error.')
             # If --exit-on-error flag is not set, skip this board and continue.
             # Record the failed board.
-            self.failed_boards.add(self.defconfig)
+            self.failed_boards.add(name)
 
         self.progress.inc(success)
         self.progress.show()
@@ -618,6 +618,7 @@ class Slots:
         """
         self.args = args
         self.slots = []
+        self.progress = progress
         self.col = col
         devnull = subprocess.DEVNULL
         make_cmd = get_make_cmd()
@@ -662,8 +663,8 @@ class Slots:
                 ret = False
         return ret
 
-    def show_failed_boards(self):
-        """Display all of the failed boards (defconfigs)."""
+    def show_result(self):
+        """Show the results of processing"""
         boards = set()
         output_file = 'moveconfig.failed'
 
@@ -671,14 +672,16 @@ class Slots:
             boards |= slot.get_failed_boards()
 
         if boards:
-            boards = '\n'.join(boards) + '\n'
-            msg = 'The following boards were not processed due to error:\n'
-            msg += boards
-            msg += f'(the list has been saved in {output_file})\n'
-            print(self.col.build(self.col.RED, msg, bright=True),
-                  file=sys.stderr)
-
+            print(self.col.build(
+                self.col.RED,
+                f'{len(boards)} failed (see {output_file})', True))
+            boards = '\n'.join(sorted(boards)) + '\n'
             write_file(output_file, boards)
+        else:
+            # Add enough spaces to overwrite the progress indicator
+            print(self.col.build(
+                self.col.GREEN,
+                f'{self.progress.total} processed        ', bright=True))
 
 class ReferenceSource:
 
@@ -757,8 +760,7 @@ def move_config(toolchains, args, db_queue, col):
     while not slots.empty():
         time.sleep(SLEEP_TIME)
 
-    print('')
-    slots.show_failed_boards()
+    slots.show_result()
 
 def find_kconfig_rules(kconf, config, imply_config):
     """Check whether a config has a 'select' or 'imply' keyword
-- 
2.42.0.515.g380fc7ccd1-goog

