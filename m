Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68EC0CD5BB1
	for <u-boot@archiver.kernel.org>; Sat, 23 May 2026 08:55:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31219846F9;
	Sat, 23 May 2026 10:55:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="O+YcVkUi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D247846DE; Sat, 23 May 2026 10:55:09 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63F888469F
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 10:55:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7e61d8d9a21so98216a34.0
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 01:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779526506; x=1780131306; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mRdtEP4pMijNMutpb2YsuGpLUQ53G0XWi6daRLGL9MM=;
 b=O+YcVkUiIgkb92+vuhRQjLvHsQaTzTD6ZXSFEj76SCU2/r99gF8aGjFq3+bGqXDwIh
 q+xRj9IOQw6T6yKKfgehvuipqAnUl1RhSUN21nLfhd9oJccRiwSxrmLtN8rkniMvXTbQ
 qzAFRg8/omkusOSh+3r1I5P7PmhfumIsWeZiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779526506; x=1780131306;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mRdtEP4pMijNMutpb2YsuGpLUQ53G0XWi6daRLGL9MM=;
 b=pDaoqsLG7n1+VFCXrbMXYJzomqxxvFtJn8YfG+RzvTrf72cWHe5XqLhVNhwR3E7b/W
 iuqI5EZOUrlFU2uYdpngj0W07VNSyCPxxNRSAy3PZLAp9ev9KnKdTUABd/EXyblbc9O2
 YomNmdNyVi5G/iWCJwUuX3IfwUfwemi8WLz3TXsOiGVaN2rZOuLicWNwgzD4eJT7y5Tj
 lRcem8cfbiEjvADEJJe6It7IpdXYyNS5OvtlBnjhioOM6ZcMqJJkpmFdcE/4LsIID2yQ
 jma0XMaslIydxVF/slCDZLWQDehZyE+E7UfXwdqU7W0pSE1QeqK5pLRiUy2rbzcSFSBO
 RHEQ==
X-Gm-Message-State: AOJu0YyzZ8n6D+2m1j5G90O7EMg3A0LEovNK6w5xUAPGCxmvdqQDdoKj
 9v6nMiNMN/nxdZy3kpN2OGNFSX/G5QqNPJB2O/W8l8DP2BFiHdSVhTO/azRmRrOVjco9z82OISQ
 ZZDa7Oqsz
X-Gm-Gg: Acq92OE0IwuhKrH4LBHaECNRgoYJl54ir0dLUdxQ32DyJwdBMqLBocffzOllarayPVr
 4nE8Zaj4N8RdcvrgOC4Ct2SRh17W8cyNb6opW2FJyRSbbAY98hicXX99qu9aCnLx4d5Snn2Y6TZ
 oOLaR9KL/JCj9cTI5Zimm2Dk5vMcI9R+XJqBfAGc8/BRwVTdNDGYRPZyF6zE6JkHU8R0xaC9JYf
 QuIulMLJXkHbSkLmZUVvOSIWdPnI/3BPv7HGQSXHH39UHCVUKYExiixuthysX6WKNadFm6qViln
 e7cvccGpvNfbiXtQ5g/bDP3mGBT+H8G2tFyyF1XyGni4EllADv76V/r6LeV8WQLEZRF4KxyU0ED
 KMLLLANWO9BKsL0GBlaaIkDbCGxkXGPusMEa4javd6NfyoNMTQOI5YSI31RmIk0lmz3OYKnfsF7
 ORu+gcXjwDiWPi6cE6eLHL0C24HK7D
X-Received: by 2002:a05:6830:67ef:b0:7d9:f50f:968a with SMTP id
 46e09a7af769-7e5fec66f0fmr3981209a34.5.1779526506081; 
 Sat, 23 May 2026 01:55:06 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e60666ae5fsm2893602a34.24.2026.05.23.01.55.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2026 01:55:03 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 02/11] test: Move extlinux image-creation to its own file
Date: Sat, 23 May 2026 02:54:38 -0600
Message-ID: <20260523085455.750591-3-sjg@chromium.org>
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

Move setup_extlinux_image() to its own module. The image exercises the
extlinux bootmeth and is modelled on Fedora 31, so name the module and
function after what they test rather than the distribution.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Rename the module to extlinux and the function to
  setup_extlinux_image(), naming it after the bootmeth it tests rather
  than the Fedora distribution it is modelled on

 test/py/img/extlinux.py  | 36 ++++++++++++++++++++++++++++++++++++
 test/py/tests/test_ut.py | 32 +++-----------------------------
 2 files changed, 39 insertions(+), 29 deletions(-)
 create mode 100644 test/py/img/extlinux.py

diff --git a/test/py/img/extlinux.py b/test/py/img/extlinux.py
new file mode 100644
index 00000000000..f747fc5a382
--- /dev/null
+++ b/test/py/img/extlinux.py
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (c) 2016, NVIDIA CORPORATION. All rights reserved.
+
+"""Create extlinux test disk images"""
+
+from img.common import make_extlinux_disk
+
+
+def setup_extlinux_image(ubman, devnum, basename):
+    """Create a 20MB disk image for the extlinux bootmeth
+
+    This is modelled on Fedora 31
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
+    make_extlinux_disk(ubman, devnum, basename, vmlinux, initrd, dtbdir,
+                       script)
diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index 01d01e3ade7..fb3064847ff 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -19,7 +19,8 @@ import utils
 from tests import fs_helper
 from fs_helper import DiskHelper, FsHelper
 from test_android import test_abootimg
-from img.common import mkdir_cond, copy_partition, make_extlinux_disk
+from img.common import mkdir_cond, copy_partition
+from img.extlinux import setup_extlinux_image
 
 
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
-    make_extlinux_disk(ubman, devnum, basename, vmlinux, initrd, dtbdir,
-                       script)
-
 def setup_cros_image(ubman):
     """Create a 20MB disk image with ChromiumOS partitions"""
     Partition = collections.namedtuple('part', 'start,size,name')
@@ -548,7 +522,7 @@ def setup_rauc_image(ubman):
 def test_ut_dm_init_bootstd(ubman):
     """Initialise data for bootflow tests"""
 
-    setup_fedora_image(ubman, 1, 'mmc')
+    setup_extlinux_image(ubman, 1, 'mmc')
     setup_bootmenu_image(ubman)
     setup_cedit_file(ubman)
     setup_cros_image(ubman)
-- 
2.43.0

