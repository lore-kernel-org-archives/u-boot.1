Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C28A2CD5BB1
	for <u-boot@archiver.kernel.org>; Sat, 23 May 2026 08:56:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7410684837;
	Sat, 23 May 2026 10:55:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mLIijwOr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 481BB84849; Sat, 23 May 2026 10:55:30 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26D7D8482F
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 10:55:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7e61d3fb1c6so115280a34.3
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 01:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779526527; x=1780131327; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xyWYSU6Qh/oQCBD7P8dDE8vngQ2beIcwqd37jBTeuPA=;
 b=mLIijwOrAs4HTjmDtmI16qf+58c6o54Khi41o9Zd9hrJDse9IMeEJ16ARXPjQa+k11
 5NQk3psnap4RAyi5VrJqourcy6xn0ci+91g199VKVmdWPxxmEXLdFCkm8X8rRF98GkR3
 lG9KF+Gg/s944QtdVjvh7kJgb7A7wIfIpPU5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779526527; x=1780131327;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xyWYSU6Qh/oQCBD7P8dDE8vngQ2beIcwqd37jBTeuPA=;
 b=cWCo9rReWJ4PnIthOhIyuGG7TdGguVbW6rZpKOiHZl0RcRU5csPiy7utyPyhQRWspK
 12jfOtf7M+PSiLRf4IfNG1jLccny0OSKcZudWOdtFNa0+XkSkeMrixmlj/vq0jEl0yQi
 5YiAX3zfOsMdm8EPb8Knjx/5VidWynHSp4YhFQ0P/VtJEXIvSwT/c1p8TNR/wNggPQpq
 p2VNJncVTp8CjchxjHOdMIZ841qbOIVBgC5nay79WtOPZDPejuQzjpp3hW4f4PFxwFfY
 h6523vMdH7rD4qPL2ecXQciAW6v5K6HFjOo4jRZajrR5xtGwfa/pYwuIyF7fQXdGJ1T3
 8CDg==
X-Gm-Message-State: AOJu0Yz95O0Sy6EOo0ncab3ZVLHml+bBG/cSTddv2G6XzRrqtTDays9U
 J4W8ajOSw20h6DQpVz3nzCsNsGlmhllnAPArTKSTdkuaFB94RDLPaaPDDw+adFU6C7NLfP9w+yy
 0lX/pZGRj
X-Gm-Gg: Acq92OHbmtvM6XfTmktxcvVk006Q4w1w5EgjDMccCDXUbMQj/MT1xAK8W72JwVtJV5d
 HaZbtFNqHgNWuGpjxiVFi0tMbSwULtKsDQ/XbdqYyXIahyLQ3gZzTBh+0tQyLdl+IBX6b9boEkN
 JAKW/toEQR4EXPIpTphS4XcT6ZnyaZuKkIyfAgyKAk8ajZbcg3mQolWE1KHZJeDrCfFxsf9CInR
 1CKCrBtDK/41Mmt0Ji9Hih7Q3ghlUrR2pIQSLSfFPhc89OIUVhLLnXEThCOZLP5nVFrD+H1x2yc
 TaPH/1qC9qqLbyN254rt2hjjou1iFPJGXarInoIxQbB7ZO5ZLXcvYsKJNf41RyEMLU3LHBOEF40
 SOW7FCWgV+7oa5KukB1DbVWoNIWudFUwLeo6pZl7bO3/vRRZSrJhqnjdNkJ+BQgs85h1+t2QauB
 TaedeVVYHwPizzFfT/teHnnFzPMO9+
X-Received: by 2002:a05:6830:2b08:b0:7dc:d0e3:5bdd with SMTP id
 46e09a7af769-7e5ff02a2cbmr5043716a34.19.1779526526884; 
 Sat, 23 May 2026 01:55:26 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e60666ae5fsm2893602a34.24.2026.05.23.01.55.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2026 01:55:26 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 07/11] test: Move the configuration-editor setup to its own
 file
Date: Sat, 23 May 2026 02:54:43 -0600
Message-ID: <20260523085455.750591-8-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260523085455.750591-1-sjg@chromium.org>
References: <20260523085455.750591-1-sjg@chromium.org>
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

(no changes since v1)

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
index 1616afbb975..38fec6cf8a2 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -25,19 +25,9 @@ from img.script import setup_script_image
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

