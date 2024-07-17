Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF54AC3DA42
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 16:02:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D719688AF7;
	Wed, 17 Jul 2024 17:57:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="C8Q1zMjP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F50088AF9; Wed, 17 Jul 2024 17:57:40 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A120788AF5
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 17:57:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-367b8a60b60so3939866f8f.2
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 08:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721231857; x=1721836657; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pSi542Uq7eQms9MJ6dh6ZBB0Ffs9/0fip/6hT3MHN2A=;
 b=C8Q1zMjP9jykaQiGqT+M2aQmVaQLRds8C2wUWjX08nNLqYbGcIAbCtvKAf6wHQh99K
 1upuR9fViTu9JD7M2EuDhNxkYIn+9U1mfoj+cr/fUX4LOGYPapxXqm3cCOqFlxS5Y2ym
 sRD3DX5ZdTVyMqLgx4QALytKodGHdP2BnbqiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721231857; x=1721836657;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pSi542Uq7eQms9MJ6dh6ZBB0Ffs9/0fip/6hT3MHN2A=;
 b=veifyBJzHWvbwH3RO+THTvOSPYAdXW/6uGnHbsA3MtUmkO7kYEz4bqkRW35yzkBMIM
 uZNCnMQHuJs9yZBUNWtA0//+Ohcqe5IohuRk2taFh0tBhHvUh8Cv1qvKQfa6gRpeNGbD
 jT8hvMuOKCyMlsgf3oObcmfcyGhuhAv5allp7xx9mCbXmBjiEc3o8s/eZakxq+x50BZ2
 ipCVx1Ldp0zxO1oCn9r5t0yyHPmRq+OOZ6ia/KA4X5tcjxNG7KxQhTHEmwu2X7W3Pfse
 w45QHDQVt8DFcgfa17yjABvqQhJIDzJTNJhdSUFoO1Ih3oBa6GAZp1rdy3N+dZ0rng7m
 ZmUg==
X-Gm-Message-State: AOJu0YxxAdFzblNzLvKwsopdGgnaSkwLqlRDOV4bW2wDuYhqpTJSh9w+
 JS+ymNGA0CoeCvyik1GPEKtj6iJ0keyqP9fhlqI87zWxJzYMZyHLro3NeZ1t1hMiLe9NV2vF0nU
 =
X-Google-Smtp-Source: AGHT+IHw2J8SFhQhBCpq1yep1xQ4C2p+JhhPuLNR1Mi5g6dRU/Nev7f31lbv/8aEIr7zSBWnvLQBsw==
X-Received: by 2002:a5d:45d2:0:b0:367:83e9:b4a5 with SMTP id
 ffacd0b85a97d-368316fad85mr1291646f8f.49.1721231856869; 
 Wed, 17 Jul 2024 08:57:36 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dafb877sm12173958f8f.69.2024.07.17.08.57.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 08:57:36 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 22/24] qconfig: Drop col argument from Slots()
Date: Wed, 17 Jul 2024 16:57:10 +0100
Message-Id: <20240717155712.2913651-23-sjg@chromium.org>
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

This is not needed since the progress indicator has the object. Use that
instead.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/qconfig.py | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/tools/qconfig.py b/tools/qconfig.py
index c4171cf9076..dd24e4b398b 100755
--- a/tools/qconfig.py
+++ b/tools/qconfig.py
@@ -364,7 +364,7 @@ class Slot:
     """
 
     def __init__(self, toolchains, args, progress, devnull, make_cmd,
-                 reference_src_dir, db_queue, col):
+                 reference_src_dir, db_queue):
         """Create a new process slot.
 
         Args:
@@ -386,7 +386,7 @@ class Slot:
         self.make_cmd = (make_cmd, 'O=' + self.build_dir)
         self.reference_src_dir = reference_src_dir
         self.db_queue = db_queue
-        self.col = col
+        self.col = progress.col
         self.parser = KconfigParser(args, self.build_dir)
         self.state = STATE_IDLE
         self.failed_boards = set()
@@ -594,11 +594,9 @@ class Slot:
         return self.failed_boards
 
 class Slots:
-
     """Controller of the array of subprocess slots."""
 
-    def __init__(self, toolchains, args, progress, reference_src_dir, db_queue,
-                 col):
+    def __init__(self, toolchains, args, progress, reference_src_dir, db_queue):
         """Create a new slots controller.
 
         Args:
@@ -608,17 +606,16 @@ class Slots:
             reference_src_dir (str): Determine the true starting config state
                 from this source tree (None for none)
             db_queue (Queue): output queue to write config info for the database
-            col (terminal.Color): Colour object
         """
         self.args = args
         self.slots = []
         self.progress = progress
-        self.col = col
+        self.col = progress.col
         devnull = subprocess.DEVNULL
         make_cmd = get_make_cmd()
         for _ in range(args.jobs):
             self.slots.append(Slot(toolchains, args, progress, devnull,
-                                   make_cmd, reference_src_dir, db_queue, col))
+                                   make_cmd, reference_src_dir, db_queue))
 
     def add(self, defconfig):
         """Add a new subprocess if a vacant slot is found.
@@ -747,7 +744,7 @@ def move_config(args):
     col = terminal.Color(terminal.COLOR_NEVER if args.nocolour
                          else terminal.COLOR_IF_TERMINAL)
     progress = Progress(col, len(defconfigs))
-    slots = Slots(toolchains, args, progress, reference_src_dir, db_queue, col)
+    slots = Slots(toolchains, args, progress, reference_src_dir, db_queue)
 
     # Main loop to process defconfig files:
     #  Add a new subprocess into a vacant slot.
-- 
2.34.1

