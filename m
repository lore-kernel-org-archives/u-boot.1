Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC28ACE7A88
	for <u-boot@archiver.kernel.org>; Sat, 23 Sep 2023 19:48:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A566186BAE;
	Sat, 23 Sep 2023 21:45:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aSAUGYoW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA98F863DD; Sat, 23 Sep 2023 21:44:55 +0200 (CEST)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F04F886B57
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 21:44:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-34fc7f51441so12932655ab.0
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 12:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695498290; x=1696103090; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pJBBneHWxmVTTSQjHLmv6UCKg0rMU+kGLlstRa/JPBg=;
 b=aSAUGYoWF3v9yFV6Sp23Xv6jFPOu8u5Wqf7Gw5pux135QVr+7+SAdtQdtye/5Ghy8Y
 gS2VX+tc0084EeoS9MNdc9b1pZxG4+Hi58CBihFJF9lV4/N+aRQZi1Wza3uiLEH5GYUe
 vQLTnWYa7Ga4/dDyqQNHqH0lNMPp8d3/wubus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695498290; x=1696103090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pJBBneHWxmVTTSQjHLmv6UCKg0rMU+kGLlstRa/JPBg=;
 b=UeDkafKAaTIT6qoiyK8lmyA0CxsVm4WPZN9Za1NYhYGIXVWTRy76F1V/VzwFYvgRAY
 SL/1eATWkGyTFVo7nA3L3lKLOoZHiVemuvjuHJV6Ku0SiyXMUPdWkke535RtSnqhc8fP
 48lxjFNeyzkIkSbOfFBP+V7Etwupix6T5bgW1pxgVOoPsxQjERffw0x3evSeAhsmk5my
 hTesISR/erOiktBCQLCYMU3WagYvT8ZLKxEv5WnzpZVNFJGrpQaJ2ob40SYCCAjbPJT+
 efEs71F9WWam9LNEOENmFxkCggiMx1wMKC29ba9Zd+p37RPgYBKQ45G1BTtSLQQfys1C
 gpKQ==
X-Gm-Message-State: AOJu0YxfmHVOTcSkUB2+ccwb7ey6d6AbaxAvbf+LYixOXA5Wu3dVpR5P
 bB229aEpUsQgJtlD/UNWT+iDgnEa9bTLcWKfkMk=
X-Google-Smtp-Source: AGHT+IEYvmF9t09Sd0BN1cTUXwmD/oEloPRluV5ge8/phyIud+3OKhRCSje3xl75HHXjxuk2w1mLBA==
X-Received: by 2002:a05:6e02:b47:b0:34f:dfdb:be08 with SMTP id
 f7-20020a056e020b4700b0034fdfdbbe08mr4085278ilu.23.1695498290373; 
 Sat, 23 Sep 2023 12:44:50 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 el9-20020a0566384d8900b00439d4db47b6sm1697786jab.39.2023.09.23.12.44.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Sep 2023 12:44:49 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 21/27] moveconfig: Show failures in progress
Date: Sat, 23 Sep 2023 13:44:10 -0600
Message-ID: <20230923194424.1739224-22-sjg@chromium.org>
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

Show the number of accumulated failures when processing. Use a shorter
format with colour.

An unwanted space appears before the defconfig name on every item except
the last. Fix that while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/tools/moveconfig.py b/tools/moveconfig.py
index 9e9cb672a967..2a4badf8649a 100755
--- a/tools/moveconfig.py
+++ b/tools/moveconfig.py
@@ -241,24 +241,36 @@ class Progress:
 
     """Progress Indicator"""
 
-    def __init__(self, total):
+    def __init__(self, col, total):
         """Create a new progress indicator.
 
         Args:
-          total: A number of defconfig files to process.
+            color_enabled (bool): True for colour output
+            total (int): A number of defconfig files to process.
         """
+        self.col = col
         self.current = 0
+        self.good = 0
         self.total = total
 
-    def inc(self):
-        """Increment the number of processed defconfig files."""
+    def inc(self, success):
+        """Increment the number of processed defconfig files.
 
+        Args:
+            success (bool): True if processing succeeded
+        """
+        self.good += success
         self.current += 1
 
     def show(self):
         """Display the progress."""
         if self.current != self.total:
-            print(f' {self.current} defconfigs out of {self.total}\r', end=' ')
+            line = self.col.build(self.col.GREEN, f'{self.good:5d}')
+            line += self.col.build(self.col.RED,
+                                   f'{self.current - self.good:5d}')
+            line += self.col.build(self.col.MAGENTA,
+                                   f'/{self.total - self.current}')
+            print(f'{line}  \r', end='')
         sys.stdout.flush()
 
 
@@ -578,7 +590,7 @@ class Slot:
             # Record the failed board.
             self.failed_boards.add(self.defconfig)
 
-        self.progress.inc()
+        self.progress.inc(success)
         self.progress.show()
         self.state = STATE_IDLE
 
@@ -729,7 +741,7 @@ def move_config(toolchains, args, db_queue, col):
     else:
         defconfigs = get_all_defconfigs()
 
-    progress = Progress(len(defconfigs))
+    progress = Progress(col, len(defconfigs))
     slots = Slots(toolchains, args, progress, reference_src_dir, db_queue, col)
 
     # Main loop to process defconfig files:
-- 
2.42.0.515.g380fc7ccd1-goog

