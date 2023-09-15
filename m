Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C9FEEAA7A
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 00:26:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BEA486A93;
	Fri, 15 Sep 2023 02:23:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GwC/sGMx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0DCD869D8; Fri, 15 Sep 2023 02:23:06 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A242F86886
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 02:23:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-792979d4cb5so55050139f.2
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 17:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694737383; x=1695342183; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gtkMb2sGTUuKjLn5iKW0s0gVMlJQmKh8/DFFrn2G7Hc=;
 b=GwC/sGMxEp7LwfDxxjEkMvt0UeId0mxURY/0gA9xX4c2oEvll2xBFyCe60myhNQQQ5
 PWvzWF43FhtCBsiU5wEcV5yKFVYOmmIArM4Ht+gLqZ+mGoAxGhL4/PXY4i20/jQbHv9U
 yLdJt9OVZH4bQLM1xkDOlwiM1pB1FQNqrlvkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694737383; x=1695342183;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gtkMb2sGTUuKjLn5iKW0s0gVMlJQmKh8/DFFrn2G7Hc=;
 b=aWeb2U4bQNZ+2A89z+2N0tWtsldEx9tKnC87rzOln1/92jR+bVTKvEbMz0F12bkp1m
 zyzUhrtJEWeME8fh8N4KTgM4zwafF++Cba2KxWYhziG3lrv0zDtgFwmYbmhfkpceDZLM
 6r7BOdbyspNyac26gWc3LkHkbxM8tRCfAVLkilsX06cONinVTFdiSHBvchE64Mjuzyyj
 DqH3HiPg1B/G18u4oIpsca8IPXCx91+Ror0TVUFadk471e0/qv5qdceBb1Gg2h7T2Yku
 2NNp29w3tow/6YERdkgGggePLResCpPGmnmcb1YHoy3C2svAssRiSYp9dRU67NSn7/pc
 QfPQ==
X-Gm-Message-State: AOJu0Yxuvz/kCh3hd4IkOhVVtUuI15hVSmGbbi+795ldv0H6bC7qnP68
 cyilNkvx8Lj8fZ6uDy8XwBbZE4l9Rh6z9LKc4DY=
X-Google-Smtp-Source: AGHT+IEugXS/0i32aMKfqL39tEhiLasqVYjPgLumXgQwqby7jODKj+L6cYG4QxSXJ0/GmgJWPlLMQQ==
X-Received: by 2002:a05:6602:29b2:b0:798:3cb5:ad30 with SMTP id
 u18-20020a05660229b200b007983cb5ad30mr80027ios.7.1694737383308; 
 Thu, 14 Sep 2023 17:23:03 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 i23-20020a5e8517000000b007836e9ff198sm744796ioj.55.2023.09.14.17.23.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 17:23:03 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Masahiro Yamada <masahiroy@kernel.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 21/27] moveconfig: Show failures in progress
Date: Thu, 14 Sep 2023 18:22:23 -0600
Message-ID: <20230915002236.798760-22-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230915002236.798760-1-sjg@chromium.org>
References: <20230915002236.798760-1-sjg@chromium.org>
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
2.42.0.459.ge4e396fd5e-goog

