Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 694F1CD4F54
	for <u-boot@archiver.kernel.org>; Sat, 23 May 2026 08:55:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EBDB846E1;
	Sat, 23 May 2026 10:55:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kFH/pd/U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27F0884704; Sat, 23 May 2026 10:55:14 +0200 (CEST)
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACA04846E1
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 10:55:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x343.google.com with SMTP id
 46e09a7af769-7de44ed7a11so7983804a34.1
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 01:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779526510; x=1780131310; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vDSAUO65uwldnTZXs2RUyQ6LlQrYVFUTM8239XfVHgg=;
 b=kFH/pd/UfcT2t6g7Xb4Z0LF8g4kKKsjtVa4sVBGY+cSThsV1YCvG2uBHKv/Fj7W0W5
 e5Y7FFjG7Y/j2sdnXcKrM36tJvuyCrKMMx3N10nQVdH8DSPHocUxnZ52OM0rhEFRXlAW
 tFeDa2sWIU66FE48eVVkFvu6dyqmRUjiKkcGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779526510; x=1780131310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vDSAUO65uwldnTZXs2RUyQ6LlQrYVFUTM8239XfVHgg=;
 b=CJ3wvivqXoWoFgBXT6Tg3G7XNftdm7/y364BqCkPeUh9tzIB8EQGFAsUTkpPme+/DC
 gceDCvJq+q30CBURuCZoPEHIpDJlqH5Fuxcr8cikGy30xofCwD7knjdZgMuAgWM4LpAy
 Q0O7LHLDjr8WRCVWZHF6yBNWhPnZmT3jV6IENggbnOQfUiIqTiPXvraG8U14/3I2licW
 +KIaOewUIv4dXTaZ7uSLWM+IUmIAsBJ+ugFNN/lAJGfVtB1aPTKNiUdR2SDZvfV5csFc
 Of67hwMVARD6hK3TrKKdPO9AwSFEbHxNrZY2ABXUAfxp5GBbXRMjm5uAMt9RYnSQx/DK
 ezSg==
X-Gm-Message-State: AOJu0Yym+fmt+noQf+Zg3QCuxVNj5wt+326mk0STc3prubROwk/i/ed3
 Y73y1UN5HigEVZjL5F5FurUb51GElIAb79p4HxnrOTvXKpSIHzESJ+abZTHybq0FRJv2Z657yYg
 FA5xoT9owxOw=
X-Gm-Gg: Acq92OGWrO6iIEiEbWQjLKYt3BnuT3xeyfF0P767jrgeiWr7oVHZcbUAs8ukId84r0r
 jJnQwxXYD+L8a/8Kph1r1iNqtig3HW1qrm3oMDZOuwm5eLaRT9kUpmnQkbNC72mD8CeFzQisXCL
 mzXpm2Xx4oU+MSVziYATOwy9OxvZqurHwU74g1vIG/O/b82/KM/GPPI3UFmauWNS9xfdbJArn1W
 JuvwqW6F8H4gHoobCyZLNWdZLM3ANVJTHy9MxUuafv4fCTzfvn6UBauDpxYAB3Txurn+PfFTaxm
 cLrpqF6e8XzvCkdPxjk06CaJ8vmFPhbtAFRp6WtP97c8xC5WECOC9tqlmr4aYY8thobZUTM2QDg
 dlnLVCCBvMK+MWxZ9+5eBwfQt4Faxn4SoqjfP8qNck5UKD8j1/Uy3jLv4PHYZ505N96RNOAa5U1
 Hn7d3Lh2Rmb2fhXrSUxw==
X-Received: by 2002:a05:6830:3745:b0:7dc:cb67:cb67 with SMTP id
 46e09a7af769-7e5feded17fmr4743853a34.5.1779526510394; 
 Sat, 23 May 2026 01:55:10 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e60666ae5fsm2893602a34.24.2026.05.23.01.55.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2026 01:55:07 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 03/11] test: Move script image-creation to its own file
Date: Sat, 23 May 2026 02:54:39 -0600
Message-ID: <20260523085455.750591-4-sjg@chromium.org>
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

Move setup_script_image() to its own module. The image exercises the
script bootmeth and is modelled on Armbian 22.08 Jammy, so name the
module and function after what they test rather than the distribution.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Rename the module to script and the function to setup_script_image(),
  naming it after the bootmeth it tests rather than the Armbian
  distribution it is modelled on

 test/py/img/script.py    | 129 +++++++++++++++++++++++++++++++++++++++
 test/py/tests/test_ut.py | 122 +-----------------------------------
 2 files changed, 131 insertions(+), 120 deletions(-)
 create mode 100644 test/py/img/script.py

diff --git a/test/py/img/script.py b/test/py/img/script.py
new file mode 100644
index 00000000000..3e36686ee5a
--- /dev/null
+++ b/test/py/img/script.py
@@ -0,0 +1,129 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (c) 2016, NVIDIA CORPORATION. All rights reserved.
+
+"""Create script test disk images"""
+
+import os
+
+import utils
+from fs_helper import DiskHelper, FsHelper
+from img.common import mkdir_cond
+
+
+def setup_script_image(ubman):
+    """Create a 20MB disk image for the script bootmeth
+
+    This is modelled on Armbian 22.08 Jammy
+    """
+    mmc_dev = 4
+
+    script = '''# DO NOT EDIT THIS FILE
+#
+# Please edit /boot/armbianEnv.txt to set supported parameters
+#
+
+setenv load_addr "0x9000000"
+setenv overlay_error "false"
+# default values
+setenv rootdev "/dev/mmcblk%dp1"
+setenv verbosity "1"
+setenv console "both"
+setenv bootlogo "false"
+setenv rootfstype "ext4"
+setenv docker_optimizations "on"
+setenv earlycon "off"
+
+echo "Boot script loaded from ${devtype} ${devnum}"
+
+if test -e ${devtype} ${devnum} ${prefix}armbianEnv.txt; then
+	load ${devtype} ${devnum} ${load_addr} ${prefix}armbianEnv.txt
+	env import -t ${load_addr} ${filesize}
+fi
+
+if test "${logo}" = "disabled"; then setenv logo "logo.nologo"; fi
+
+if test "${console}" = "display" || test "${console}" = "both"; then setenv consoleargs "console=tty1"; fi
+if test "${console}" = "serial" || test "${console}" = "both"; then setenv consoleargs "console=ttyS2,1500000 ${consoleargs}"; fi
+if test "${earlycon}" = "on"; then setenv consoleargs "earlycon ${consoleargs}"; fi
+if test "${bootlogo}" = "true"; then setenv consoleargs "bootsplash.bootfile=bootsplash.armbian ${consoleargs}"; fi
+
+# get PARTUUID of first partition on SD/eMMC the boot script was loaded from
+if test "${devtype}" = "mmc"; then part uuid mmc ${devnum}:1 partuuid; fi
+
+setenv bootargs "root=${rootdev} rootwait rootfstype=${rootfstype} ${consoleargs} consoleblank=0 loglevel=${verbosity} ubootpart=${partuuid} usb-storage.quirks=${usbstoragequirks} ${extraargs} ${extraboardargs}"
+
+if test "${docker_optimizations}" = "on"; then setenv bootargs "${bootargs} cgroup_enable=cpuset cgroup_memory=1 cgroup_enable=memory swapaccount=1"; fi
+
+load ${devtype} ${devnum} ${ramdisk_addr_r} ${prefix}uInitrd
+load ${devtype} ${devnum} ${kernel_addr_r} ${prefix}Image
+
+load ${devtype} ${devnum} ${fdt_addr_r} ${prefix}dtb/${fdtfile}
+fdt addr ${fdt_addr_r}
+fdt resize 65536
+for overlay_file in ${overlays}; do
+	if load ${devtype} ${devnum} ${load_addr} ${prefix}dtb/rockchip/overlay/${overlay_prefix}-${overlay_file}.dtbo; then
+		echo "Applying kernel provided DT overlay ${overlay_prefix}-${overlay_file}.dtbo"
+		fdt apply ${load_addr} || setenv overlay_error "true"
+	fi
+done
+for overlay_file in ${user_overlays}; do
+	if load ${devtype} ${devnum} ${load_addr} ${prefix}overlay-user/${overlay_file}.dtbo; then
+		echo "Applying user provided DT overlay ${overlay_file}.dtbo"
+		fdt apply ${load_addr} || setenv overlay_error "true"
+	fi
+done
+if test "${overlay_error}" = "true"; then
+	echo "Error applying DT overlays, restoring original DT"
+	load ${devtype} ${devnum} ${fdt_addr_r} ${prefix}dtb/${fdtfile}
+else
+	if load ${devtype} ${devnum} ${load_addr} ${prefix}dtb/rockchip/overlay/${overlay_prefix}-fixup.scr; then
+		echo "Applying kernel provided DT fixup script (${overlay_prefix}-fixup.scr)"
+		source ${load_addr}
+	fi
+	if test -e ${devtype} ${devnum} ${prefix}fixup.scr; then
+		load ${devtype} ${devnum} ${load_addr} ${prefix}fixup.scr
+		echo "Applying user provided fixup script (fixup.scr)"
+		source ${load_addr}
+	fi
+fi
+booti ${kernel_addr_r} ${ramdisk_addr_r} ${fdt_addr_r}
+
+# Recompile with:
+# mkimage -C none -A arm -T script -d /boot/boot.cmd /boot/boot.scr
+'''
+    fsh = FsHelper(ubman.config, 'ext4', 18, 'mmc')
+    fsh.setup()
+    bootdir = os.path.join(fsh.srcdir, 'boot')
+    mkdir_cond(bootdir)
+    cmd_fname = os.path.join(bootdir, 'boot.cmd')
+    scr_fname = os.path.join(bootdir, 'boot.scr')
+    with open(cmd_fname, 'w', encoding='ascii') as outf:
+        print(script, file=outf)
+
+    infname = os.path.join(ubman.config.source_dir,
+                            'test/py/tests/bootstd/armbian.bmp.xz')
+    bmp_file = os.path.join(bootdir, 'boot.bmp')
+    utils.run_and_log(
+        ubman,
+        ['sh', '-c', f'xz -dc {infname} >{bmp_file}'])
+
+    mkimage = ubman.config.build_dir + '/tools/mkimage'
+    utils.run_and_log(
+        ubman, f'{mkimage} -C none -A arm -T script -d {cmd_fname} {scr_fname}')
+
+    kernel = 'vmlinuz-5.15.63-rockchip64'
+    target = os.path.join(bootdir, kernel)
+    with open(target, 'wb') as outf:
+        print('kernel', outf)
+
+    symlink = os.path.join(bootdir, 'Image')
+    if os.path.exists(symlink):
+        os.remove(symlink)
+    utils.run_and_log(
+        ubman, f'echo here {kernel} {symlink}')
+    os.symlink(kernel, symlink)
+    fsh.mk_fs()
+    img = DiskHelper(ubman.config, mmc_dev, 'mmc', True)
+    img.add_fs(fsh, DiskHelper.EXT4)
+    img.create()
+    fsh.cleanup()
diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index fb3064847ff..a23fb6244d6 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -21,125 +21,7 @@ from fs_helper import DiskHelper, FsHelper
 from test_android import test_abootimg
 from img.common import mkdir_cond, copy_partition
 from img.extlinux import setup_extlinux_image
-
-
-def setup_bootmenu_image(ubman):
-    """Create a 20MB disk image with a single ext4 partition
-
-    This is modelled on Armbian 22.08 Jammy
-    """
-    mmc_dev = 4
-
-    script = '''# DO NOT EDIT THIS FILE
-#
-# Please edit /boot/armbianEnv.txt to set supported parameters
-#
-
-setenv load_addr "0x9000000"
-setenv overlay_error "false"
-# default values
-setenv rootdev "/dev/mmcblk%dp1"
-setenv verbosity "1"
-setenv console "both"
-setenv bootlogo "false"
-setenv rootfstype "ext4"
-setenv docker_optimizations "on"
-setenv earlycon "off"
-
-echo "Boot script loaded from ${devtype} ${devnum}"
-
-if test -e ${devtype} ${devnum} ${prefix}armbianEnv.txt; then
-	load ${devtype} ${devnum} ${load_addr} ${prefix}armbianEnv.txt
-	env import -t ${load_addr} ${filesize}
-fi
-
-if test "${logo}" = "disabled"; then setenv logo "logo.nologo"; fi
-
-if test "${console}" = "display" || test "${console}" = "both"; then setenv consoleargs "console=tty1"; fi
-if test "${console}" = "serial" || test "${console}" = "both"; then setenv consoleargs "console=ttyS2,1500000 ${consoleargs}"; fi
-if test "${earlycon}" = "on"; then setenv consoleargs "earlycon ${consoleargs}"; fi
-if test "${bootlogo}" = "true"; then setenv consoleargs "bootsplash.bootfile=bootsplash.armbian ${consoleargs}"; fi
-
-# get PARTUUID of first partition on SD/eMMC the boot script was loaded from
-if test "${devtype}" = "mmc"; then part uuid mmc ${devnum}:1 partuuid; fi
-
-setenv bootargs "root=${rootdev} rootwait rootfstype=${rootfstype} ${consoleargs} consoleblank=0 loglevel=${verbosity} ubootpart=${partuuid} usb-storage.quirks=${usbstoragequirks} ${extraargs} ${extraboardargs}"
-
-if test "${docker_optimizations}" = "on"; then setenv bootargs "${bootargs} cgroup_enable=cpuset cgroup_memory=1 cgroup_enable=memory swapaccount=1"; fi
-
-load ${devtype} ${devnum} ${ramdisk_addr_r} ${prefix}uInitrd
-load ${devtype} ${devnum} ${kernel_addr_r} ${prefix}Image
-
-load ${devtype} ${devnum} ${fdt_addr_r} ${prefix}dtb/${fdtfile}
-fdt addr ${fdt_addr_r}
-fdt resize 65536
-for overlay_file in ${overlays}; do
-	if load ${devtype} ${devnum} ${load_addr} ${prefix}dtb/rockchip/overlay/${overlay_prefix}-${overlay_file}.dtbo; then
-		echo "Applying kernel provided DT overlay ${overlay_prefix}-${overlay_file}.dtbo"
-		fdt apply ${load_addr} || setenv overlay_error "true"
-	fi
-done
-for overlay_file in ${user_overlays}; do
-	if load ${devtype} ${devnum} ${load_addr} ${prefix}overlay-user/${overlay_file}.dtbo; then
-		echo "Applying user provided DT overlay ${overlay_file}.dtbo"
-		fdt apply ${load_addr} || setenv overlay_error "true"
-	fi
-done
-if test "${overlay_error}" = "true"; then
-	echo "Error applying DT overlays, restoring original DT"
-	load ${devtype} ${devnum} ${fdt_addr_r} ${prefix}dtb/${fdtfile}
-else
-	if load ${devtype} ${devnum} ${load_addr} ${prefix}dtb/rockchip/overlay/${overlay_prefix}-fixup.scr; then
-		echo "Applying kernel provided DT fixup script (${overlay_prefix}-fixup.scr)"
-		source ${load_addr}
-	fi
-	if test -e ${devtype} ${devnum} ${prefix}fixup.scr; then
-		load ${devtype} ${devnum} ${load_addr} ${prefix}fixup.scr
-		echo "Applying user provided fixup script (fixup.scr)"
-		source ${load_addr}
-	fi
-fi
-booti ${kernel_addr_r} ${ramdisk_addr_r} ${fdt_addr_r}
-
-# Recompile with:
-# mkimage -C none -A arm -T script -d /boot/boot.cmd /boot/boot.scr
-'''
-    fsh = FsHelper(ubman.config, 'ext4', 18, 'mmc')
-    fsh.setup()
-    bootdir = os.path.join(fsh.srcdir, 'boot')
-    mkdir_cond(bootdir)
-    cmd_fname = os.path.join(bootdir, 'boot.cmd')
-    scr_fname = os.path.join(bootdir, 'boot.scr')
-    with open(cmd_fname, 'w', encoding='ascii') as outf:
-        print(script, file=outf)
-
-    infname = os.path.join(ubman.config.source_dir,
-                            'test/py/tests/bootstd/armbian.bmp.xz')
-    bmp_file = os.path.join(bootdir, 'boot.bmp')
-    utils.run_and_log(
-        ubman,
-        ['sh', '-c', f'xz -dc {infname} >{bmp_file}'])
-
-    mkimage = ubman.config.build_dir + '/tools/mkimage'
-    utils.run_and_log(
-        ubman, f'{mkimage} -C none -A arm -T script -d {cmd_fname} {scr_fname}')
-
-    kernel = 'vmlinuz-5.15.63-rockchip64'
-    target = os.path.join(bootdir, kernel)
-    with open(target, 'wb') as outf:
-        print('kernel', outf)
-
-    symlink = os.path.join(bootdir, 'Image')
-    if os.path.exists(symlink):
-        os.remove(symlink)
-    utils.run_and_log(
-        ubman, f'echo here {kernel} {symlink}')
-    os.symlink(kernel, symlink)
-    fsh.mk_fs()
-    img = DiskHelper(ubman.config, mmc_dev, 'mmc', True)
-    img.add_fs(fsh, DiskHelper.EXT4)
-    img.create()
-    fsh.cleanup()
+from img.script import setup_script_image
 
 
 def setup_cros_image(ubman):
@@ -523,7 +405,7 @@ def test_ut_dm_init_bootstd(ubman):
     """Initialise data for bootflow tests"""
 
     setup_extlinux_image(ubman, 1, 'mmc')
-    setup_bootmenu_image(ubman)
+    setup_script_image(ubman)
     setup_cedit_file(ubman)
     setup_cros_image(ubman)
     setup_android_image(ubman)
-- 
2.43.0

