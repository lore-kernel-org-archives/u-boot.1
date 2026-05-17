Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62329CD4F3C
	for <u-boot@archiver.kernel.org>; Sun, 17 May 2026 22:52:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE3B4846D0;
	Mon, 18 May 2026 00:51:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Jj+3QdBN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 424C98469F; Mon, 18 May 2026 00:51:52 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B97A7846B0
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 00:51:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7dcdd23fcdfso887093a34.3
 for <u-boot@lists.denx.de>; Sun, 17 May 2026 15:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779058308; x=1779663108; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h9ROgLRkkmj6cS012G/qsv6B1Wsw6Cw4J/rKrbh/z2A=;
 b=Jj+3QdBNGA7ER6enL80x6qA3drItqE2sXT9UCwvgZfP9zlF3dG0TPLLJQYeTFh+/+e
 HK97CzKc2tvA7sHaS8j/1xv3b3kR641eWOTFvNu0xI+lPQDCG9hczy9A6hc3rUlJ/6Ev
 EZiUdkLlSYZ7f2DjsWe457qhKxuPY0wkTb1+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779058308; x=1779663108;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=h9ROgLRkkmj6cS012G/qsv6B1Wsw6Cw4J/rKrbh/z2A=;
 b=F/wRtZs7bTa9EQEs8e97VKEF0tJtNBrqvShSFgNTYnrR8CGpjC2pTsUFpXhRy3Ls+B
 3pVVAdhHUBFlgGyjZmxxctaCECHnG4lzuNxtiHf+jMsJUkE3dPn/IPaPHAKdqaSxwUrg
 rK85qxsMSifLh170sAXay2WfxTbhiKX5BBR6VlNzYWcPVaJq5tYUtnX+5LEkbhY4zWTX
 oWcPySy+ueqGD7ODGWIPNyhfeVbqcolthxZ848dnwhvZ4kdRtC+pKGIj6GdRJ0ALptTz
 0GnDO2VoIp1vZvcivyS95QfZNATlSj2GOs0UvORyYJjVm2Nz0VwKweJ8bYoF6oFcWgyU
 qQFw==
X-Gm-Message-State: AOJu0YxreaL2erXuxHcFzwSXzP7cWt6FO9mxAP1fsCuZVIGac2CkeXNX
 gsufrZK8PjYwTjAaVERokLNDmUP9NMhJH9MJwvYvQpRzHcnAnLwc355b21a9P7zCaLj+TfY0UeE
 yA76a1pKv
X-Gm-Gg: Acq92OETpzCmd1LUZ6wcpXD44J6UWBFv0Qe4mNdZeMnWmFAVD4FwaBb56WVuSyo/Hiz
 bQPd1gYbs1PqFvMpa5Hh5CF6Y7z2VFuQf8wvqP2a/wyuT/wuf2Q0osQnBRE1X74lqlDIN9mTpzH
 aZWYDKoluxlwjBmZPJwK2I+yRsxWXJxz48gGTQsUTmlNHrrE8V7cePFMiY8Q/ETmV/g7hJcRLDx
 lFjCCL5IrjCzrTJN3Knl2HAp9H4r4VNQoCoAZUoTRTXR3dkQLEuiKKVwM6gTD7NSgWZgeY5M3qx
 u1rX9mOtujWtP4/ToYhqyTMZdRjKTNOANeOeT4Rr6EJIStlL25+HQoOaKkSXCfhgoq+gs9kqYi3
 aBLNvtYOujqMm+0RTYMtxYLUJK5UCv7C77bYRq/zUn8EN3uzso6UbXnyMhogP91m//lluwIgkij
 bZ1uzhB5uWIK6lF75QbQ==
X-Received: by 2002:a05:6830:d04:b0:7d9:f50f:968a with SMTP id
 46e09a7af769-7e4ea03b63amr8307497a34.5.1779058308511; 
 Sun, 17 May 2026 15:51:48 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55bc4983asm6386357a34.26.2026.05.17.15.51.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 15:51:47 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 07/11] test: Move the configuration-editor setup to its own
 file
Date: Sun, 17 May 2026 16:51:05 -0600
Message-ID: <20260517225122.2966807-8-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260517225122.2966807-1-sjg@chromium.org>
References: <20260517225122.2966807-1-sjg@chromium.org>
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

Move setup_cedit_file() to its own module.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/py/img/cedit.py     | 20 ++++++++++++++++++++
 test/py/tests/test_ut.py | 12 +-----------
 2 files changed, 21 insertions(+), 11 deletions(-)
 create mode 100644 test/py/img/cedit.py

diff --git a/test/py/img/cedit.py b/test/py/img/cedit.py
new file mode 100644
index 00000000000..4b53275d259
--- /dev/null
+++ b/test/py/img/cedit.py
@@ -0,0 +1,20 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (c) 2016, NVIDIA CORPORATION. All rights reserved.
+
+"""Create configuration editor test files"""
+
+import os
+
+import utils
+
+
+def setup_cedit_file(ubman):
+    """Set up a .dtb file for use with testing expo and configuration editor"""
+    infname = os.path.join(ubman.config.source_dir,
+                           'test/boot/files/expo_layout.dts')
+    inhname = os.path.join(ubman.config.source_dir,
+                           'test/boot/files/expo_ids.h')
+    expo_tool = os.path.join(ubman.config.source_dir, 'tools/expo.py')
+    outfname = 'cedit.dtb'
+    utils.run_and_log(
+        ubman, f'{expo_tool} -e {inhname} -l {infname} -o {outfname}')
diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index 4736b92ca13..e8d47b79365 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -25,19 +25,9 @@ from img.armbian import setup_bootmenu_image
 from img.chromeos import setup_cros_image
 from img.android import setup_android_image
 from img.efi import setup_efi_image
+from img.cedit import setup_cedit_file
 
 
-def setup_cedit_file(ubman):
-    """Set up a .dtb file for use with testing expo and configuration editor"""
-    infname = os.path.join(ubman.config.source_dir,
-                           'test/boot/files/expo_layout.dts')
-    inhname = os.path.join(ubman.config.source_dir,
-                           'test/boot/files/expo_ids.h')
-    expo_tool = os.path.join(ubman.config.source_dir, 'tools/expo.py')
-    outfname = 'cedit.dtb'
-    utils.run_and_log(
-        ubman, f'{expo_tool} -e {inhname} -l {infname} -o {outfname}')
-
 @pytest.mark.buildconfigspec('ut_dm')
 def test_ut_dm_init(ubman):
     """Initialize data for ut dm tests."""
-- 
2.43.0

