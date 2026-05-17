Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ACADCD4F3D
	for <u-boot@archiver.kernel.org>; Sun, 17 May 2026 22:52:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D28C84676;
	Mon, 18 May 2026 00:51:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FvSAhhgf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E05578469A; Mon, 18 May 2026 00:51:42 +0200 (CEST)
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com
 [IPv6:2607:f8b0:4864:20::242])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73402845E3
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 00:51:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x242.google.com with SMTP id
 5614622812f47-47cbd444fd0so1130009b6e.2
 for <u-boot@lists.denx.de>; Sun, 17 May 2026 15:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779058299; x=1779663099; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gPaOW1NBnW0iLrZvl64tkS+rhT7Kst6WSgvafAg6DvY=;
 b=FvSAhhgfqpjepZN9V1b7NPHvUrlBe3j/l8ri6UgOhBX8NfBQ+cIfJOrPeIuRu9ecc9
 kDaEE95ewE/wtW55Ue7jYHzQ2Mui9sx3eSegE1CPS4JXVxfgw9MljbhbPElNaumjw3Mo
 q6UuvVFUP0IDxaf5GwSnAmp6yX2/khF6vddbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779058299; x=1779663099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gPaOW1NBnW0iLrZvl64tkS+rhT7Kst6WSgvafAg6DvY=;
 b=ZatF0xrdTQ7LJIenMSwo9VksIT+61IYKz1B9HF7MG6jIwBATglZ3wgwgHJCbgii1kt
 YXa4/NtCTzT8rt0TCtm0RblxMEobhgfERkItweNtA1tdXg16ijdvlY06vNxWp7rO9p48
 xiLgjJjy6tsH03WkanDgVQUCMEVVALl5NQr4xHgJV/twh7A3sWfm2z0BF1erzNiGB5uH
 dYm9EuJ13GQvMmAORaObnZNJHQ5AcUmUzKg69nJLJPyK+MklrGE8j1DDyaq67Tco5bNo
 /8Ch6Kv8yB5CCZUHYlRV2VFeGCyTpXQuBwKFJzebV64MzQI5LlUYXEGnkmka4FSeOLk5
 h0DQ==
X-Gm-Message-State: AOJu0YzoVfbEYM3YNS1HCW1sN0rjgPP/7y3pABbAcPJG5ChHgwtW6fGm
 o5dGPBXXPfznVIqFxGhiQ1eNIREcbEPM1m8bnPzreq1rthQ2LBShkLmXIinIZiZuc8qbNxQmJgu
 NQwj+6fj5SL8=
X-Gm-Gg: Acq92OGRK4BRoJeUQgJL4wzV5XajL5TRVMPjHziJqUvljVeRThEWmlBYkixBc20k6l5
 53G/s0T7iFX73NdukEZcrg57ojVHRPZUlFAXrAy9xpMq7Vnj3euMsWaWKGKZ7qKAxdbrMv1hPHz
 bjDAVerdnwVMENRXF57RfxigeiRdL0vFLMsU+ueP+DNb3Adrdti4epLe391/gyBzLWG5svgPnLc
 TeVUiVaj8huv/8htvmNXyFcV65KvdTaa2cIj5NqiBhlz4zGXrJ4SXSThGsroMI5Mn7lWBF04yqw
 sjbcKwgSGhJuOEjI0M0ZP6XWyZ/40JNktKwDlg3AMFYRo5ipzsce8uQFfz9i+2IVq/hBeCh6h9z
 8Ev99cBLLyPt0x8Wvc9KdnjRpgdUNb965xEgHWVYwnFTJp9PbUIhGfXHo5gtFmqJHneP1MZAJu6
 Te9ffdKYDLwq6K7GgIPfzfyhW4/d8e
X-Received: by 2002:a05:6808:f90:b0:479:ded7:477 with SMTP id
 5614622812f47-482e57876d1mr8381765b6e.40.1779058299108; 
 Sun, 17 May 2026 15:51:39 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55bc4983asm6386357a34.26.2026.05.17.15.51.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 15:51:38 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 03/11] test: Move Armbian image-creation to its own file
Date: Sun, 17 May 2026 16:51:01 -0600
Message-ID: <20260517225122.2966807-4-sjg@chromium.org>
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

Move setup_bootmenu_image() to its own module. This function creates an
image styled on Armbian 22.08 Jammy with a boot menu.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/py/img/armbian.py   | 129 +++++++++++++++++++++++++++++++++++++++
 test/py/tests/test_ut.py | 120 +-----------------------------------
 2 files changed, 130 insertions(+), 119 deletions(-)
 create mode 100644 test/py/img/armbian.py

diff --git a/test/py/img/armbian.py b/test/py/img/armbian.py
new file mode 100644
index 00000000000..40a890d57f6
--- /dev/null
+++ b/test/py/img/armbian.py
@@ -0,0 +1,129 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (c) 2016, NVIDIA CORPORATION. All rights reserved.
+
+"""Create Armbian test disk images"""
+
+import os
+
+import utils
+from fs_helper import DiskHelper, FsHelper
+from img.common import mkdir_cond
+
+
+def setup_bootmenu_image(ubman):
+    """Create a 20MB disk image with a single ext4 partition
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
index 16dd70d2e9b..6623d514dad 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -21,125 +21,7 @@ from fs_helper import DiskHelper, FsHelper
 from test_android import test_abootimg
 from img.common import mkdir_cond, copy_partition, setup_extlinux_image
 from img.fedora import setup_fedora_image
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
+from img.armbian import setup_bootmenu_image
 
 
 def setup_cros_image(ubman):
-- 
2.43.0

