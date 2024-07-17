Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 927CCC3DA4B
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 16:01:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2705488AD8;
	Wed, 17 Jul 2024 17:57:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZjGeQAyJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FE1588AD7; Wed, 17 Jul 2024 17:57:34 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CD3388AB2
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 17:57:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-367b8a60b60so3939795f8f.2
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 08:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721231852; x=1721836652; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ybezj24e5n7shbxMq0bCkNvHfpiq7xv1meQoOW9s85M=;
 b=ZjGeQAyJ553btzAH1aKkX3FHbDMl3NizDgzLyMNxmNLVxAPHKd+n+4aGHoBWzgWUQn
 UJoCjQ3CYB4/CO4btPBs0LyVXYYvtMNgS+1VE0OoO/eMkT3RmiZovFUPIrOynGf3WGxu
 UyVqt64PT7KdRq2aOJcpfxwBZ1IKFseZBjurg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721231852; x=1721836652;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ybezj24e5n7shbxMq0bCkNvHfpiq7xv1meQoOW9s85M=;
 b=R2sKRQSk2+zSOSl0TCNAc75M0UZ3VVd09RFPLw08XH8krk4HPmBNh4uaxJu2IATGsm
 CvCeN+8llrsGgzEaYmdDls/Ip6mc3I9PHn4MhUty8+mSfgXEMl+Lbt1YLxstunfbPMzH
 TBZo+Kv95JGTffEnhVYE3JiJcC9mpKOktpi9VItFeRVKDsI8qmpPj2PDiUiLSGShXSTP
 E2caRVdX7a+24UDpw/noESENhlbN1863D6cR2ykHXC4HSP4jtpPq5RexYw0kAzvvkjqp
 qU3iqNDTeyHK65Cr3jDQOzPN6vJ6XmIIjtOVKdScjlx0swulpukQq6HgNVLttMiIyCwG
 g4Yg==
X-Gm-Message-State: AOJu0Yw7yDhrPAAcCw+Ic6IZWXpjrK68PsfunyWAw1Uw9GHnnAFOre/2
 mqBD69EMe/zLGFCVNucGNlmK5P5SJzohaZV7h5XXLlHmyRel6WTwb67dRWOqO1g85Yn3SjvPgIo
 =
X-Google-Smtp-Source: AGHT+IGUAAmyWx7Achn8P8nqbdq+PMLCGINZm3KX4iXPncAGM77pxh7QoTFOZkYIdEhS7Zg1YR5/Ww==
X-Received: by 2002:a5d:588e:0:b0:368:3198:5ac4 with SMTP id
 ffacd0b85a97d-36831985ca4mr1793496f8f.39.1721231851867; 
 Wed, 17 Jul 2024 08:57:31 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dafb877sm12173958f8f.69.2024.07.17.08.57.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 08:57:31 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 17/24] qconfig: Move all move_config code into move_config()
Date: Wed, 17 Jul 2024 16:57:05 +0100
Message-Id: <20240717155712.2913651-18-sjg@chromium.org>
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

Move the setup and completion code into the move_config() function so
it is all in one place.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/qconfig.py | 45 +++++++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/tools/qconfig.py b/tools/qconfig.py
index b1487928613..74d7d1bd175 100755
--- a/tools/qconfig.py
+++ b/tools/qconfig.py
@@ -693,18 +693,36 @@ class ReferenceSource:
 
         return self.src_dir
 
-def move_config(toolchains, args, db_queue, col):
+def move_config(args, col):
     """Build database or sync config options to defconfig files.
 
     Args:
-        toolchains (Toolchains): Toolchains to use
         args (Namespace): Program arguments
-        db_queue (Queue): Queue for database updates
         col (terminal.Color): Colour object
 
     Returns:
-        Progress: Progress indicator
+        tuple:
+            config_db (dict of configs for each defconfig):
+                key: defconfig name, e.g. "MPC8548CDS_legacy_defconfig"
+                value: dict:
+                    key: CONFIG option
+                    value: Value of option
+            Progress: Progress indicator
     """
+    config_db = {}
+    db_queue = queue.Queue()
+    dbt = DatabaseThread(config_db, db_queue)
+    dbt.daemon = True
+    dbt.start()
+
+    check_clean_directory()
+    bsettings.setup('')
+
+    # Get toolchains to use
+    toolchains = toolchain.Toolchains()
+    toolchains.GetSettings()
+    toolchains.Scan(verbose=False)
+
     if args.git_ref:
         reference_src = ReferenceSource(args.git_ref)
         reference_src_dir = reference_src.get_dir()
@@ -733,7 +751,8 @@ def move_config(toolchains, args, db_queue, col):
         time.sleep(SLEEP_TIME)
 
     slots.write_failed_boards()
-    return progress
+    db_queue.join()
+    return config_db, progress
 
 def find_kconfig_rules(kconf, config, imply_config):
     """Check whether a config has a 'select' or 'imply' keyword
@@ -1590,23 +1609,9 @@ def main():
     if args.find:
         return do_find_config(args.configs)
 
-    # We are either building the database or forcing a sync of defconfigs
-    config_db = {}
-    db_queue = queue.Queue()
-    dbt = DatabaseThread(config_db, db_queue)
-    dbt.daemon = True
-    dbt.start()
-
-    check_clean_directory()
-    bsettings.setup('')
-    toolchains = toolchain.Toolchains()
-    toolchains.GetSettings()
-    toolchains.Scan(verbose=False)
-
     col = terminal.Color(terminal.COLOR_NEVER if args.nocolour
                          else terminal.COLOR_IF_TERMINAL)
-    progress = move_config(toolchains, args, db_queue, col)
-    db_queue.join()
+    config_db, progress = move_config(args, col)
 
     configs = args.configs
     if args.commit:
-- 
2.34.1

