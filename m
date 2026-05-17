Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5C41CD4F3D
	for <u-boot@archiver.kernel.org>; Sun, 17 May 2026 22:51:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 236CC84683;
	Mon, 18 May 2026 00:51:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BnN5ECpQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F33CF845E3; Mon, 18 May 2026 00:51:39 +0200 (CEST)
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47A3784676
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 00:51:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x342.google.com with SMTP id
 46e09a7af769-7d4c383f2fcso1821281a34.0
 for <u-boot@lists.denx.de>; Sun, 17 May 2026 15:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779058295; x=1779663095; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O1989O+nxb9Rb7l8tGzUi8GMd+f5TssGyz3Qr3HfaNQ=;
 b=BnN5ECpQOCSMODi7nOcfnOcC/zfcODNkcxdZVhPE/ahEQumb8CK+nu4E3zcT04lAX2
 8PY+IBKCI1FSBI+Y2K6+QxAvxxj1w8W4PlW7SP6Nb0bthn2LQGkid5qi/HuOOWbnePyH
 TLTUC6q/wfLikEDhU2Vt7rV7Qn4+ASfCj35R0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779058295; x=1779663095;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=O1989O+nxb9Rb7l8tGzUi8GMd+f5TssGyz3Qr3HfaNQ=;
 b=Ec3Aacq0PlXPFLRxFQAUbU1btWdtOiKqAIz0RUEzlbVgVvAN/teWxkIaWC0lDzfTKG
 CzVlN5y72j0K4vXq6LbQmm0a9GNH2Up9whhz/0B0Addd7HQzv2tTCjPxIWN0iiVQz6Hl
 /iqRcz6pydwL02+Mw7pafgnynYKEHB+g/1y6JzTWMGRRK4V5nggcPLxdeNcCKyDdsGgb
 8CYIy7/ac63JUhbKndlxQx9cGqiwrofGq7GWlE7U3/+J4O8fb4vVvzb4rR/xt3yNXThv
 IDzrrh286pKcIZwscKXjxmpmYZGPvOChwSm8bKesPWPB4EW8TYFGH4kdmhb2ACCmirTh
 BhJg==
X-Gm-Message-State: AOJu0Yw5FGzrcwmvXZr7DmPAay1qxFPyGMWaW5e3+EtFigumx02pJveU
 zYntNVcU7gBSUmvv+RzB0Fa0hUgglqtP4SXsi80UFpRxBiZxcFdSVVG6R9ZE0SIsSZL/CIidTqU
 RmQoGOwHcT3A=
X-Gm-Gg: Acq92OHge9kcmQSqTrQ8d8uH5m2YmbuJvSSbUz7MQcUCywtM9jGMX5gCuaBp7xvombz
 SFMyRiSWqbJfh/u1qiMvFQp8SfrL4Sj1xYkWy/yuWEZ9z9fA3kiPo0rft3XIx0fPKUq3fAc5fFm
 JPfmz5agIaxKJBlpVsC2hE0W+V0AfT2F3CXoB3vQWlBYaF14Y7qMYJq54A2KeHKTOMiYrDqqT3t
 4h7jckwLNz6lQAOvbofEEXxqC6cilud7rP2xnw8+Vx6xRvjL6wHPSjdf5I2Noi1Gma6NDEWPOpj
 ohItGFzRW2gNfg9YLzRPie607qLwYKC6Cb1kYiLbsmVE16RJVumfQ+EswRajHPHX40XiGbpO0Ym
 1c88B6RiOI+JIy7l9Y+MmBJIScSBP2Pq4cAPp48gYkNffqRZdW33P+eCKvEdSfIjmYM/HNu+V+E
 EOEqjiI940O6OQz0d3DQ==
X-Received: by 2002:a05:6830:380e:b0:7d7:ef0a:1ce9 with SMTP id
 46e09a7af769-7e4f2b44dccmr9004068a34.14.1779058295487; 
 Sun, 17 May 2026 15:51:35 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55bc4983asm6386357a34.26.2026.05.17.15.51.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 15:51:34 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Marek Vasut <marek.vasut@mailbox.org>, Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Philip Molloy <philip.molloy@analog.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>,
 Yao Zi <me@ziyao.cc>
Subject: [PATCH 01/11] test: Create a common file for image utilities
Date: Sun, 17 May 2026 16:50:59 -0600
Message-ID: <20260517225122.2966807-2-sjg@chromium.org>
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

Move mkdir_cond(), copy_partition(), and setup_extlinux_image() to a
common module which can be used by the rest of the image-creation code.

Add myself as a maintainer for this new directory, and the test/py
framework itself.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 MAINTAINERS              |  5 +++
 test/py/img/common.py    | 86 ++++++++++++++++++++++++++++++++++++++++
 test/py/tests/test_ut.py | 73 +---------------------------------
 3 files changed, 92 insertions(+), 72 deletions(-)
 create mode 100644 test/py/img/common.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 0dcc7243124..d33ea42116c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1829,6 +1829,11 @@ M:	Liviu Dudau <liviu.dudau@foss.arm.com>
 S:	Maintained
 F:	drivers/video/tda19988.c
 
+TEST FRAMEWORK (PYTHON)
+M:	Simon Glass <sjg@chromium.org>
+F:	test/py
+F:	test/py/img
+
 TI LP5562 LED DRIVER
 M:	Rasmus Villemoes <rasmus.villemoes@prevas.dk>
 S:	Supported
diff --git a/test/py/img/common.py b/test/py/img/common.py
new file mode 100644
index 00000000000..37349c0a2e7
--- /dev/null
+++ b/test/py/img/common.py
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (c) 2016, NVIDIA CORPORATION. All rights reserved.
+
+"""Common utilities for image creation"""
+
+import gzip
+import os
+
+import utils
+from fs_helper import DiskHelper, FsHelper
+
+
+def mkdir_cond(dirname):
+    """Create a directory if it doesn't already exist
+
+    Args:
+        dirname (str): Name of directory to create
+    """
+    if not os.path.exists(dirname):
+        os.mkdir(dirname)
+
+
+def copy_partition(ubman, fsfile, outname):
+    """Copy a partition into a disk image
+
+    Args:
+        ubman (ConsoleBase): U-Boot fixture
+        fsfile (str): Name of partition file
+        outname (str): Name of full-disk file to update
+    """
+    utils.run_and_log(ubman,
+                      f'dd if={fsfile} of={outname} bs=1M seek=1 conv=notrunc')
+
+
+def setup_extlinux_image(ubman, devnum, basename, vmlinux, initrd, dtbdir,
+                         script):
+    """Create a 20MB disk image with a single FAT partition
+
+    Args:
+        ubman (ConsoleBase): Console to use
+        devnum (int): Device number to use, e.g. 1
+        basename (str): Base name to use in the filename, e.g. 'mmc'
+        vmlinux (str): Kernel filename
+        initrd (str): Ramdisk filename
+        dtbdir (str or None): Devicetree filename
+        script (str): Script to place in the extlinux.conf file
+    """
+    fsh = FsHelper(ubman.config, 'vfat', 18, prefix=basename)
+    fsh.setup()
+
+    ext = os.path.join(fsh.srcdir, 'extlinux')
+    mkdir_cond(ext)
+
+    conf = os.path.join(ext, 'extlinux.conf')
+    with open(conf, 'w', encoding='ascii') as fd:
+        print(script, file=fd)
+
+    inf = os.path.join(ubman.config.persistent_data_dir, 'inf')
+    with open(inf, 'wb') as fd:
+        fd.write(gzip.compress(b'vmlinux'))
+    mkimage = ubman.config.build_dir + '/tools/mkimage'
+    utils.run_and_log(
+        ubman, f'{mkimage} -f auto -d {inf} {os.path.join(fsh.srcdir, vmlinux)}')
+
+    with open(os.path.join(fsh.srcdir, initrd), 'w', encoding='ascii') as fd:
+        print('initrd', file=fd)
+
+    if dtbdir:
+        mkdir_cond(os.path.join(fsh.srcdir, dtbdir))
+
+        dtb_file = os.path.join(fsh.srcdir, f'{dtbdir}/sandbox.dtb')
+        utils.run_and_log(
+            ubman, f'dtc -o {dtb_file}', stdin=b'/dts-v1/; / {};')
+
+    fsh.mk_fs()
+
+    img = DiskHelper(ubman.config, devnum, basename, True)
+    img.add_fs(fsh, DiskHelper.VFAT, bootable=True)
+
+    ext4 = FsHelper(ubman.config, 'ext4', 1, prefix=basename)
+    ext4.setup()
+    ext4.mk_fs()
+
+    img.add_fs(ext4, DiskHelper.EXT4)
+    img.create()
+    fsh.cleanup()
diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index dce5a37dd35..97ef2d8e517 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -19,26 +19,8 @@ import utils
 from tests import fs_helper
 from fs_helper import DiskHelper, FsHelper
 from test_android import test_abootimg
+from img.common import mkdir_cond, copy_partition, setup_extlinux_image
 
-def mkdir_cond(dirname):
-    """Create a directory if it doesn't already exist
-
-    Args:
-        dirname (str): Name of directory to create
-    """
-    if not os.path.exists(dirname):
-        os.mkdir(dirname)
-
-def copy_partition(ubman, fsfile, outname):
-    """Copy a partition into a disk iamge
-
-    Args:
-        ubman (ConsoleBase): U-Boot fixture
-        fsfile (str): Name of partition file
-        outname (str): Name of full-disk file to update
-    """
-    utils.run_and_log(ubman,
-                      f'dd if={fsfile} of={outname} bs=1M seek=1 conv=notrunc')
 
 def setup_bootmenu_image(ubman):
     """Create a 20MB disk image with a single ext4 partition
@@ -159,59 +141,6 @@ booti ${kernel_addr_r} ${ramdisk_addr_r} ${fdt_addr_r}
     fsh.cleanup()
 
 
-def setup_extlinux_image(ubman, devnum, basename, vmlinux, initrd, dtbdir,
-                         script):
-    """Create a 20MB disk image with a single FAT partition
-
-    Args:
-        ubman (ConsoleBase): Console to use
-        devnum (int): Device number to use, e.g. 1
-        basename (str): Base name to use in the filename, e.g. 'mmc'
-        vmlinux (str): Kernel filename
-        initrd (str): Ramdisk filename
-        dtbdir (str or None): Devicetree filename
-        script (str): Script to place in the extlinux.conf file
-    """
-    fsh = FsHelper(ubman.config, 'vfat', 18, prefix=basename)
-    fsh.setup()
-
-    ext = os.path.join(fsh.srcdir, 'extlinux')
-    mkdir_cond(ext)
-
-    conf = os.path.join(ext, 'extlinux.conf')
-    with open(conf, 'w', encoding='ascii') as fd:
-        print(script, file=fd)
-
-    inf = os.path.join(ubman.config.persistent_data_dir, 'inf')
-    with open(inf, 'wb') as fd:
-        fd.write(gzip.compress(b'vmlinux'))
-    mkimage = ubman.config.build_dir + '/tools/mkimage'
-    utils.run_and_log(
-        ubman, f'{mkimage} -f auto -d {inf} {os.path.join(fsh.srcdir, vmlinux)}')
-
-    with open(os.path.join(fsh.srcdir, initrd), 'w', encoding='ascii') as fd:
-        print('initrd', file=fd)
-
-    if dtbdir:
-        mkdir_cond(os.path.join(fsh.srcdir, dtbdir))
-
-        dtb_file = os.path.join(fsh.srcdir, f'{dtbdir}/sandbox.dtb')
-        utils.run_and_log(
-            ubman, f'dtc -o {dtb_file}', stdin=b'/dts-v1/; / {};')
-
-    fsh.mk_fs()
-
-    img = DiskHelper(ubman.config, devnum, basename, True)
-    img.add_fs(fsh, DiskHelper.VFAT, bootable=True)
-
-    ext4 = FsHelper(ubman.config, 'ext4', 1, prefix=basename)
-    ext4.setup()
-    ext4.mk_fs()
-
-    img.add_fs(ext4, DiskHelper.EXT4)
-    img.create()
-    fsh.cleanup()
-
 def setup_fedora_image(ubman, devnum, basename):
     """Create a 20MB Fedora disk image with a single FAT partition
 
-- 
2.43.0

