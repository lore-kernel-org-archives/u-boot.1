Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1983CCD4F3D
	for <u-boot@archiver.kernel.org>; Sun, 17 May 2026 22:52:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92E6B846B0;
	Mon, 18 May 2026 00:51:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="R4Zk8hX3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CB20846C6; Mon, 18 May 2026 00:51:51 +0200 (CEST)
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90F95846AD
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 00:51:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x341.google.com with SMTP id
 46e09a7af769-7e4de538f83so980219a34.1
 for <u-boot@lists.denx.de>; Sun, 17 May 2026 15:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779058307; x=1779663107; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n+uW4303SseZxwnMI6A/2QhgStSGP/XvCaSd3ZAfeOY=;
 b=R4Zk8hX3nprdNeaGfCDgkSopApAWPytjejgJbsBnlcLG3b/EU61D30BmK+iPD0aRX1
 prlVr552AbKgjf/VSNkMXz5cqOFdpoCCQ/N6e6GcmJg3XVv8mBj2loakP3rUsFnfZ25P
 jyN1A7fluvdhfpPOjAJni++7iWpEJtcIqDw0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779058307; x=1779663107;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=n+uW4303SseZxwnMI6A/2QhgStSGP/XvCaSd3ZAfeOY=;
 b=aORj2VWQfX/ZFTqEiLUe4tbwM2gdCunElzelNE+ZsbZQw9aDqiJ45QFUUiWO1sTzrF
 Ui3IFHH6HxtaRe2geuuaJ2cMOKooYtx377eUi5DjnD0flew4T3ECyiczbB5j04niwvj3
 xTUN/DmDZUd7Dy2om8HiBnRlFaSfVR0P0N3x9805eZe/sSoRpQnpSvgyx0VsCRbwtlSL
 pTxikxm5txzoQDtBRazUZNxVS+IKDUVRtG9m5NtP/gPadxGhSgdH/TNC3S+j1hmkodM+
 0myJQuQxGG9icGE8rROqHKG6nE7z4KguBDjMWlG3insU3DOQYCN/9qyLqf/FhHRRP9vY
 EJAA==
X-Gm-Message-State: AOJu0YwxiqWzxwwJZg86e57AjJ20bzfi2seO72dnJB5CONBOvouAD8pU
 jCAgnM0rhC+KWcuQTNAXW56jaLEcR3HvTISt+WmhKL1nm5Egz/UV4Oe5X8ZPGXjpdETza9l3lTm
 KthNY7CjDQpk=
X-Gm-Gg: Acq92OE+wr0r4dXbxdpV77VJgLbBPwF6ueFpNek+UWNldQVqpp2NOFjqe6D+MJjWbp2
 qMo6vQFcXC/HUDiFXl0W0KOc40eOGJRME+zD7T85f3KcO8TlepSwZCg7gULT6p2uIhnTvLANYta
 pMOgDlKu8du8fBEnW8UGd5u9qZSJcwOGlbe55vXBF/6hkwr+YISm7p8wl1LUd7SNgjUp/wgLTWu
 EQd/5vsRYWzRh3jr6W7uXqWZBP5TH/22PddUtUbgeScDjcazJfz09p0j/fonf6mKOdQo2vq2CZL
 xFhdceHesJwTjyacVLbR4hHlUjE5TP0G3+tLowfsNNRlX5B96dnjrsTVdTYX9r4kRGQqxfjOO2y
 uYopTuEoyu6QdLl2hjZbIn5xjXWSrBajZYr1SMovG6/3vhWum//REA2TxwlwGRFkjl4MHso2Iw+
 73u43CDwDzwA/zjaSMVg==
X-Received: by 2002:a05:6830:2b10:b0:7dc:d587:af3 with SMTP id
 46e09a7af769-7e4fa04a8c3mr8122437a34.23.1779058306815; 
 Sun, 17 May 2026 15:51:46 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55bc4983asm6386357a34.26.2026.05.17.15.51.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 15:51:46 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 06/11] test: Move EFI image-creation to its own file
Date: Sun, 17 May 2026 16:51:04 -0600
Message-ID: <20260517225122.2966807-7-sjg@chromium.org>
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

Move setup_efi_image() to its own module.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/py/img/efi.py       | 33 +++++++++++++++++++++++++++++++++
 test/py/tests/test_ut.py | 25 +------------------------
 2 files changed, 34 insertions(+), 24 deletions(-)
 create mode 100644 test/py/img/efi.py

diff --git a/test/py/img/efi.py b/test/py/img/efi.py
new file mode 100644
index 00000000000..1327a2be6ce
--- /dev/null
+++ b/test/py/img/efi.py
@@ -0,0 +1,33 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (c) 2016, NVIDIA CORPORATION. All rights reserved.
+
+"""Create EFI test disk images"""
+
+import os
+
+from fs_helper import DiskHelper, FsHelper
+from img.common import mkdir_cond
+
+
+def setup_efi_image(ubman):
+    """Create a 20MB disk image with an EFI app on it"""
+    devnum = 1
+    fsh = FsHelper(ubman.config, 'vfat', 18, 'flash')
+    fsh.setup()
+    efi_dir = os.path.join(fsh.srcdir, 'EFI')
+    mkdir_cond(efi_dir)
+    bootdir = os.path.join(efi_dir, 'BOOT')
+    mkdir_cond(bootdir)
+    efi_src = os.path.join(ubman.config.build_dir,
+                        'lib/efi_loader/testapp.efi')
+    efi_dst = os.path.join(bootdir, 'BOOTSBOX.EFI')
+    with open(efi_src, 'rb') as inf:
+        with open(efi_dst, 'wb') as outf:
+            outf.write(inf.read())
+
+    fsh.mk_fs()
+
+    img = DiskHelper(ubman.config, devnum, 'flash', True)
+    img.add_fs(fsh, DiskHelper.VFAT)
+    img.create()
+    fsh.cleanup()
diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index 9e571304dee..4736b92ca13 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -24,6 +24,7 @@ from img.fedora import setup_fedora_image
 from img.armbian import setup_bootmenu_image
 from img.chromeos import setup_cros_image
 from img.android import setup_android_image
+from img.efi import setup_efi_image
 
 
 def setup_cedit_file(ubman):
@@ -79,30 +80,6 @@ def test_ut_dm_init(ubman):
         fh.write(data)
 
 
-def setup_efi_image(ubman):
-    """Create a 20MB disk image with an EFI app on it"""
-    devnum = 1
-    fsh = FsHelper(ubman.config, 'vfat', 18, 'flash')
-    fsh.setup()
-    efi_dir = os.path.join(fsh.srcdir, 'EFI')
-    mkdir_cond(efi_dir)
-    bootdir = os.path.join(efi_dir, 'BOOT')
-    mkdir_cond(bootdir)
-    efi_src = os.path.join(ubman.config.build_dir,
-                        'lib/efi_loader/testapp.efi')
-    efi_dst = os.path.join(bootdir, 'BOOTSBOX.EFI')
-    with open(efi_src, 'rb') as inf:
-        with open(efi_dst, 'wb') as outf:
-            outf.write(inf.read())
-
-    fsh.mk_fs()
-
-    img = DiskHelper(ubman.config, devnum, 'flash', True)
-    img.add_fs(fsh, DiskHelper.VFAT)
-    img.create()
-    fsh.cleanup()
-
-
 def setup_rauc_image(ubman):
     """Create a 40MB disk image with an A/B RAUC system on it"""
     mmc_dev = 10
-- 
2.43.0

