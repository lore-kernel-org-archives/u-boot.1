Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 148EAC3DA4B
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 16:02:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E59F988AE8;
	Wed, 17 Jul 2024 17:57:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SVSun4NR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F02A488AEE; Wed, 17 Jul 2024 17:57:35 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F328C88ABF
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 17:57:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-427b1d4da32so5929535e9.0
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 08:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721231853; x=1721836653; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GldL5aJTeqn49cGdlj9Ew84IpbBAn1THiiTYIRNHwMc=;
 b=SVSun4NRzaoNSYEggBnfJHrvVG1CaN3U4jfFODQfLBvgBV2zC43XpB6u8x6JnOUNBF
 LTZrjmtfu6RcGqEmHfKBu0H7hSQBHD2WniyvWKmToAHiqF2iu+/tKzH9UY50AtOub0qj
 UzToD1KpDCaYJ4RxjUkGnjRnT7HUQg6jLZjR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721231853; x=1721836653;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GldL5aJTeqn49cGdlj9Ew84IpbBAn1THiiTYIRNHwMc=;
 b=WF9R2dB/OwVXyJCjyynArq+iwqBJsEjstVRdR83loIHVgXpgK/4l+DUDubpELvkWPT
 rkpPncu1diNEP0lOe/ChboQUNrHPsPTmmN1U9ijinLqHEXuaGhMFtHmzCJjy1112332z
 Y5LNDs4MoLS2p6CBESdTA8ZRmEqb1CP0H++hAE6qH+sX3v+dmO1MKIQR9QInTokQX7hZ
 52gJyP6HCTz7D+gqG/ykCs8C8ESE9egwoVA19Yg8FY8k5XE0uerb9m778QotlcsOBlas
 Vl2f00dbXIw6ulnaJo1N9l28HpA32p5WVSYdT+Mk3Bpm2tlwUS6Wvu6dW7LdYdPDLxMg
 yRuA==
X-Gm-Message-State: AOJu0YyraUeQBkcUJTjgeG5pciwbX5IR7E3Pc84D5YSEKp71+UTLjzRQ
 /9LyTy9kYJqTdmeRhEBqIzFDGndd9MFZEtQ6Wbog+pCyUigJ4BeOf2AldGaRGjs+cO74ezYeCAk
 =
X-Google-Smtp-Source: AGHT+IGH6mtkw/bACj9Y3aI9Py9MKtIhTx3H464tcwG97o9Go/R6JTicjXJo709iIstiWZWzlRtrYQ==
X-Received: by 2002:a05:600c:1c94:b0:426:6eb6:1374 with SMTP id
 5b1f17b1804b1-427c804cac0mr1077765e9.0.1721231853322; 
 Wed, 17 Jul 2024 08:57:33 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dafb877sm12173958f8f.69.2024.07.17.08.57.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 08:57:32 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 19/24] qconfig: Move progress output into the class
Date: Wed, 17 Jul 2024 16:57:07 +0100
Message-Id: <20240717155712.2913651-20-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240717155712.2913651-1-sjg@chromium.org>
References: <20240717155712.2913651-1-sjg@chromium.org>
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

Rather than create these outputs separately, put them in the class so
that the main program doesn't need to deal with them.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/qconfig.py | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/tools/qconfig.py b/tools/qconfig.py
index dc5b7691064..405981938e5 100755
--- a/tools/qconfig.py
+++ b/tools/qconfig.py
@@ -217,20 +217,26 @@ def read_file(fname, as_lines=True, skip_unicode=False):
 
 ### classes ###
 class Progress:
-
     """Progress Indicator"""
 
     def __init__(self, col, total):
         """Create a new progress indicator.
 
         Args:
-            color_enabled (bool): True for colour output
+            col (terminal.Color): Colour-output class
             total (int): A number of defconfig files to process.
+
+            current (int): Number of boards processed so far
+            failed (int): Number of failed boards
+            failure_msg (str): Message indicating number of failures, '' if none
         """
         self.col = col
+        self.total = total
+
         self.current = 0
         self.good = 0
-        self.total = total
+        self.failed = None
+        self.failure_msg = None
 
     def inc(self, success):
         """Increment the number of processed defconfig files.
@@ -252,6 +258,11 @@ class Progress:
             print(f'{line}  \r', end='')
         sys.stdout.flush()
 
+    def completed(self):
+        """Set up extra properties when completed"""
+        self.failed = self.total - self.good
+        self.failure_msg = f'{self.failed} failed, ' if self.failed else ''
+
 
 def scan_kconfig():
     """Scan all the Kconfig files and create a Config object
@@ -752,6 +763,7 @@ def move_config(args, col):
 
     slots.write_failed_boards()
     db_queue.join()
+    progress.completed()
     return config_db, progress
 
 def find_kconfig_rules(kconf, config, imply_config):
@@ -1634,8 +1646,6 @@ def main():
     if args.commit:
         add_commit(args.configs)
 
-    failed = progress.total - progress.good
-    failure = f'{failed} failed, ' if failed else ''
     if args.build_db:
         configs = args.configs
         with open(CONFIG_DATABASE, 'w', encoding='utf-8') as outf:
@@ -1645,11 +1655,11 @@ def main():
                     outf.write(f'   {config}={configs[config]}\n')
                 outf.write('\n')
         print(col.build(
-            col.RED if failed else col.GREEN,
-            f'{failure}{len(config_db)} boards written to {CONFIG_DATABASE}'))
+            col.RED if progress.failed else col.GREEN,
+            f'{progress.failure_msg}{len(config_db)} boards written to {CONFIG_DATABASE}'))
     else:
-        if failed:
-            print(col.build(col.RED, f'{failure}see {FAILED_LIST}', True))
+        if progress.failed:
+            print(col.build(col.RED, f'{progress.failure_msg}see {FAILED_LIST}', True))
         else:
             # Add enough spaces to overwrite the progress indicator
             print(col.build(
-- 
2.34.1

