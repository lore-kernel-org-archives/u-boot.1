Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70DCACD5BB1
	for <u-boot@archiver.kernel.org>; Sat, 23 May 2026 08:55:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E33F0846CA;
	Sat, 23 May 2026 10:55:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="a6mcETPO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F17C2846DE; Sat, 23 May 2026 10:55:06 +0200 (CEST)
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 892048469F
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 10:55:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x342.google.com with SMTP id
 46e09a7af769-7e615efd7d7so671202a34.2
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 01:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779526503; x=1780131303; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dTULh7Ojn3qcUafHQ3oq7OhX3M0VupRucSacdE2nxis=;
 b=a6mcETPOuUf9xzHuT3iKb846yud20KPA3379VcVddZA/9/GtVdUiohCaZkOzIpMlEJ
 x1c79SJmrGEjruBZZJh3ubnbRBqKbnFOqUbeFxdYDD3/IWVm70g8TTwtf5Rtckl+XAK+
 gkfgEC/0o6lOooLJTiGOJ03Wph3nWV3+rlTR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779526503; x=1780131303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dTULh7Ojn3qcUafHQ3oq7OhX3M0VupRucSacdE2nxis=;
 b=bcIz0QqZq0s8D3NUASSFWNWVC3tqwp3fYBomClwymY5lW1D4JN2Gz9Q1XCwUhLF3j4
 pJ4Y+bDx3hi4A4YeEsdi2HPMhONggGXPd482/7tB27deXhuGTlj2jzufd5vPuRVjdh1r
 sWcdrGAH7rziPhfp9sGJnYgA69spbzeIJH9NmZEstkY+R1t2Z3q6CAG2TQRG8qIJK6O0
 qYMTcgg4Vij50IyFwcAh2ouF/3clilHdrMSczhsyCOx6+yFE2tEf3RmZzrnFmoM60Jbe
 LZpkFVprGTBt2QJetK454df5nENSOdu2APbqu1be15q9/VaePyILaIPlRbvFMRf/mYfx
 El9A==
X-Gm-Message-State: AOJu0Yxjs4PCSjGCJ6SVy0+tMAqRigCrs0sgmZY+aMQz6xjIZC7m2fLm
 tFAgGS/AXLxsefroiDq/aF/e2hfr/r2+g+ZVDDEzFGbcSQNs+2c5E7gZZ1C53D2VI8K6v7aEsiC
 qDfkvQv1z5kA=
X-Gm-Gg: Acq92OE9TzB8J8pW3qwprHXZUS0/JCIpljxlqrZ32+LdUR6iZobOna4VV/cUbOSKfcS
 MM5qrw/Oj0HJjrpprNxUjQZE17lGdQN5w0bRVGnVB4eyQwvt0Ggl8brL+jk69Bpc0+VFQltyQR1
 NKJnZ+2zKEWfNA17VNPBv4Nw7OS0+fMmfpeMequaIK3YJn5fXFMe7vmkcvbCQySniSIZdxuTIY3
 bhxg3TcwNKn7Wsoh/ytFV7VSGsqDaK8TY4mZv4/PtBKuWRCqwmb56WvUCH5lvOG/D5Ld1jPnL0I
 uRxg64ascfrIxY06Eq8fzsYGBtDthLufcnWDFCs1ME1nONjljUg9w6UiOUrnQD5dDoC0EEnslFk
 lphxXtX/oy2MtdHN4xA7hvvzgPSse+sry1kxfOQsQYcRlw0OQaAhb+7Ylq2EDBBFPbw3oUBcQ1J
 7rZab4Y9/hs85EO9O4gw==
X-Received: by 2002:a05:6830:6f84:b0:7e4:163:49cc with SMTP id
 46e09a7af769-7e5feda42b1mr5611043a34.7.1779526502809; 
 Sat, 23 May 2026 01:55:02 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e60666ae5fsm2893602a34.24.2026.05.23.01.55.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2026 01:55:02 -0700 (PDT)
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
Subject: [PATCH v2 01/11] test: Create a common file for image utilities
Date: Sat, 23 May 2026 02:54:37 -0600
Message-ID: <20260523085455.750591-2-sjg@chromium.org>
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

Move mkdir_cond(), copy_partition(), and make_extlinux_disk() to a
common module which can be used by the rest of the image-creation code.

Add myself as a maintainer for this new directory, and the test/py
framework itself.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Rename the setup_extlinux_image() helper to make_extlinux_disk()

 MAINTAINERS              |  5 +++
 test/py/img/common.py    | 86 ++++++++++++++++++++++++++++++++++++++++
 test/py/tests/test_ut.py | 77 ++---------------------------------
 3 files changed, 94 insertions(+), 74 deletions(-)
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
index 00000000000..301b6c840d4
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
+def make_extlinux_disk(ubman, devnum, basename, vmlinux, initrd, dtbdir,
+                       script):
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
index dce5a37dd35..01d01e3ade7 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -19,26 +19,8 @@ import utils
 from tests import fs_helper
 from fs_helper import DiskHelper, FsHelper
 from test_android import test_abootimg
+from img.common import mkdir_cond, copy_partition, make_extlinux_disk
 
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
 
@@ -236,8 +165,8 @@ label Fedora-Workstation-armhfp-31-1.9 (5.3.7-301.fc31.armv7hl)
         append ro root=UUID=9732b35b-4cd5-458b-9b91-80f7047e0b8a rhgb quiet LANG=en_US.UTF-8 cma=192MB cma=256MB
         fdtdir /%s/
         initrd /%s''' % (vmlinux, dtbdir, initrd)
-    setup_extlinux_image(ubman, devnum, basename, vmlinux, initrd, dtbdir,
-                         script)
+    make_extlinux_disk(ubman, devnum, basename, vmlinux, initrd, dtbdir,
+                       script)
 
 def setup_cros_image(ubman):
     """Create a 20MB disk image with ChromiumOS partitions"""
-- 
2.43.0

