Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D80CD4F3D
	for <u-boot@archiver.kernel.org>; Sun, 17 May 2026 22:51:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 560968468B;
	Mon, 18 May 2026 00:51:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RvSgQmyP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDCA684676; Mon, 18 May 2026 00:51:40 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92AE284683
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 00:51:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-479dd56d016so1413398b6e.3
 for <u-boot@lists.denx.de>; Sun, 17 May 2026 15:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779058297; x=1779663097; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uuvMx05ddak2MqbQ0542GQF50qu18+yISy820IVOXTw=;
 b=RvSgQmyPPmYWY4zEZEbQ2TpKpeqwECYFrVPVHqj8QughqLQguJmfzu62fhrakXgIgE
 nwHPL/Vys+cyDdFQp2H3/7bdXr0FpF7wXfu1coX9UdqZHAqywcsPL3PZKU9bCUJDDj9R
 a4Tv0e9fU+KTwdfuPMT3/Jov9djShXbnc/A9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779058297; x=1779663097;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uuvMx05ddak2MqbQ0542GQF50qu18+yISy820IVOXTw=;
 b=jo6nwaW0+tJrDAoGe5stbdO7GZzO7dXpXw6nktfH+eBfEs6SeypypiLCkQGKtIZkIL
 +9wkF5tD3woK3nZ1hOBlmFr7VXSaP+zFWy9+OapoNjBMf49vjQ2LeSW/DTtgd6qBNgaV
 KztY8bqDD9I0bZdo0trVwapX/0sjBVvCAQQuXJjO6Gzgwu4Vt8i8ZdA1Oe9b/BGx/v9F
 0MRJYYWOsyXXP8yJ2b/FRp9YEC49a4iqOSvFe9LoKqTtHidkbpKt8DSdRnHv0E41ML0E
 aweO173lt8PG+F3yHCKH6c4/wYS0rCgeXuJyX65AZrb2L0ArNMynvL3Z6Lcbe0OpY9LK
 81nw==
X-Gm-Message-State: AOJu0YwnaP8cvEgfDkVf/aGA3dEN5tT+sJWD8RhV3Bn6Kwa3/D71ukdX
 sCWkBxZH9T3/bOz7vdV/x/BVdSxZu4qlszWm7Ha/7yNNg3pG0z9HxUZULtBDLTkMY025wb6s/DW
 djvoFOfuI
X-Gm-Gg: Acq92OFPsoHsU7Isr7EXSbrmrXRX+S69jO619a1Z8AmbgHq6tdsHptHPckZXF+1MzwL
 6aT0Cwy2Ks2lIXAGiu2qHElrZXFWFOtcZO+rlBYS/AK8cB9FSv35Ejc2xNybsw5THnVoejHx02u
 rFOCdxJ9UcNT6+/qlx4n+hXKJu5Ye3tZKTxJJtitN7XfZk4O1keGnva4fKQdrGCDBssQ3jFbC28
 La0oEwv8sE3jJZDBRC8mRTPy4vJmtBJMkF6q/t9plfIo7TDwshNJPQOMCX4UnLTkJ+j0376xxUr
 7L4Z0QVRiVu7DCh4t/aH0zPRSH1uHsCStJtXXPsj25yDPaIg9GO2F0uli3iEf6D+rGYaZzfAcpG
 akZd8wPkrZ5xlquZffUHq9swspo6SX4jd/n5+DOPQ5fhgGJrs77MYc7lKaoNL45j/4D5EjCgRQn
 ujfCuSKDMIHSyuHGslrW5g8Gd0u5qT
X-Received: by 2002:a05:6808:164d:b0:467:1e28:64f4 with SMTP id
 5614622812f47-482e55aa093mr8696543b6e.4.1779058297275; 
 Sun, 17 May 2026 15:51:37 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55bc4983asm6386357a34.26.2026.05.17.15.51.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 15:51:36 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 02/11] test: Move Fedora image-creation to its own file
Date: Sun, 17 May 2026 16:51:00 -0600
Message-ID: <20260517225122.2966807-3-sjg@chromium.org>
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

Move setup_fedora_image() to its own module.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/py/img/fedora.py    | 34 ++++++++++++++++++++++++++++++++++
 test/py/tests/test_ut.py | 28 +---------------------------
 2 files changed, 35 insertions(+), 27 deletions(-)
 create mode 100644 test/py/img/fedora.py

diff --git a/test/py/img/fedora.py b/test/py/img/fedora.py
new file mode 100644
index 00000000000..ad2174ebfb0
--- /dev/null
+++ b/test/py/img/fedora.py
@@ -0,0 +1,34 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (c) 2016, NVIDIA CORPORATION. All rights reserved.
+
+"""Create Fedora test disk images"""
+
+from img.common import setup_extlinux_image
+
+
+def setup_fedora_image(ubman, devnum, basename):
+    """Create a 20MB Fedora disk image with a single FAT partition
+
+    Args:
+        ubman (ConsoleBase): Console to use
+        devnum (int): Device number to use, e.g. 1
+        basename (str): Base name to use in the filename, e.g. 'mmc'
+    """
+    vmlinux = 'vmlinuz-5.3.7-301.fc31.armv7hl'
+    initrd = 'initramfs-5.3.7-301.fc31.armv7hl.img'
+    dtbdir = 'dtb-5.3.7-301.fc31.armv7hl'
+    script = '''# extlinux.conf generated by appliance-creator
+ui menu.c32
+menu autoboot Welcome to Fedora-Workstation-armhfp-31-1.9. Automatic boot in # second{,s}. Press a key for options.
+menu title Fedora-Workstation-armhfp-31-1.9 Boot Options.
+menu hidden
+timeout 20
+totaltimeout 600
+
+label Fedora-Workstation-armhfp-31-1.9 (5.3.7-301.fc31.armv7hl)
+        kernel /%s
+        append ro root=UUID=9732b35b-4cd5-458b-9b91-80f7047e0b8a rhgb quiet LANG=en_US.UTF-8 cma=192MB cma=256MB
+        fdtdir /%s/
+        initrd /%s''' % (vmlinux, dtbdir, initrd)
+    setup_extlinux_image(ubman, devnum, basename, vmlinux, initrd, dtbdir,
+                         script)
diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index 97ef2d8e517..16dd70d2e9b 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -20,6 +20,7 @@ from tests import fs_helper
 from fs_helper import DiskHelper, FsHelper
 from test_android import test_abootimg
 from img.common import mkdir_cond, copy_partition, setup_extlinux_image
+from img.fedora import setup_fedora_image
 
 
 def setup_bootmenu_image(ubman):
@@ -141,33 +142,6 @@ booti ${kernel_addr_r} ${ramdisk_addr_r} ${fdt_addr_r}
     fsh.cleanup()
 
 
-def setup_fedora_image(ubman, devnum, basename):
-    """Create a 20MB Fedora disk image with a single FAT partition
-
-    Args:
-        ubman (ConsoleBase): Console to use
-        devnum (int): Device number to use, e.g. 1
-        basename (str): Base name to use in the filename, e.g. 'mmc'
-    """
-    vmlinux = 'vmlinuz-5.3.7-301.fc31.armv7hl'
-    initrd = 'initramfs-5.3.7-301.fc31.armv7hl.img'
-    dtbdir = 'dtb-5.3.7-301.fc31.armv7hl'
-    script = '''# extlinux.conf generated by appliance-creator
-ui menu.c32
-menu autoboot Welcome to Fedora-Workstation-armhfp-31-1.9. Automatic boot in # second{,s}. Press a key for options.
-menu title Fedora-Workstation-armhfp-31-1.9 Boot Options.
-menu hidden
-timeout 20
-totaltimeout 600
-
-label Fedora-Workstation-armhfp-31-1.9 (5.3.7-301.fc31.armv7hl)
-        kernel /%s
-        append ro root=UUID=9732b35b-4cd5-458b-9b91-80f7047e0b8a rhgb quiet LANG=en_US.UTF-8 cma=192MB cma=256MB
-        fdtdir /%s/
-        initrd /%s''' % (vmlinux, dtbdir, initrd)
-    setup_extlinux_image(ubman, devnum, basename, vmlinux, initrd, dtbdir,
-                         script)
-
 def setup_cros_image(ubman):
     """Create a 20MB disk image with ChromiumOS partitions"""
     Partition = collections.namedtuple('part', 'start,size,name')
-- 
2.43.0

