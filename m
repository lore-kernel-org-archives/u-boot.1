Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A80FCE64039
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 22:33:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFFED896CC;
	Thu, 21 Nov 2024 23:32:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Pnzh7GvG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3805E896CC; Thu, 21 Nov 2024 23:32:50 +0100 (CET)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC9438975B
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 23:32:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-6ee7a400647so16128797b3.1
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 14:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732228351; x=1732833151; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a/ejvnbwhT0jaGVzZ8yGqqubJF7OVuUZlwNWkf+CyOI=;
 b=Pnzh7GvGCj6ooczzgSQWl81htmu4KGOE5Zzdd3unQPr4AXhvn98ZIOBn3cM/XhKhWn
 aDUPLYI8WRzhfslY/58ej+rODz4mJclGIZLakMIqTjW4HD/Pz9mWDitVBj0CXGM52IIV
 IZgqAKxdRVNDW4veKgDSW/uhAdUBZaQtMj6i0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732228351; x=1732833151;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a/ejvnbwhT0jaGVzZ8yGqqubJF7OVuUZlwNWkf+CyOI=;
 b=CAAmL31y9D78sttJA8SgbxipiUIO/jZVgpmCquWzurs1FVu8YS/yJXMTTdaolC5wHy
 sFTZdFCtKzBjurRp1AbfeiY2/Nd5t3yd9jnTt9useng9ivPPweM4uHD/4Gg8DbI/SUJQ
 w42sc6OVo5n0LsU3Ug+gwGln/Jfo7ssizhk0k64ptZmjmxAOMkjL3BXl+sXS19J3ddR5
 xDyvUyrJGBuZCOL6VrAFh/3fFSuU9W5kIgZetz8uoUZpcMOy+IbhST63o2xO0PEDckJw
 f8daUttORNWGupyHlKQZ8f7dxLKTkIunMCVWayWpZVJO0XSL7WLPxmKs/hiFEPhkFtJL
 ErpQ==
X-Gm-Message-State: AOJu0YxM1iM5tZcYQO1uTRbUzSqa4b4VbX0Ay0wRlsE4ibEIKeD6LBev
 NORlrdXYu8NqbOGH4ZCwuTRuxicQ3v7ATJkr/YW3bsLx+1neA2qDgqM4oDkJPkVkVyH5gsyn2Zw
 =
X-Gm-Gg: ASbGncs7RfVqzTYXSoX8zvdkvXwWlXWK0+53a+b9gWgmCTW+Qu+1ucu3lTBEMbJGw8U
 /LFhaD8W2/up1GFLr09fU4mmPnwMtV2XayP7D3UhRyrumSSSqIyZ6IIDTakmtV/EYlCpndrYykv
 K5iPJeafoK/xBe7s3jR0/wkD+fEjInL08a5XJFSx+IVkMHp3hbQSZWtO7ZeOwpoNgqdsx81j6EU
 Lhchgh8siGD+55BpzXuu6ndAadUSkB7Puv7W3+CdzS2HjY=
X-Google-Smtp-Source: AGHT+IEGmR43fysPB0BjO32pp9dsi20e4VFHDPvpPV24Rrk4IT1eq1YZw+s5ExxLlX7XCG9oa+mCWw==
X-Received: by 2002:a05:690c:6406:b0:6d7:f32:735b with SMTP id
 00721157ae682-6eee0a12f65mr11069887b3.27.1732228351039; 
 Thu, 21 Nov 2024 14:32:31 -0800 (PST)
Received: from chromium.org ([12.181.243.100])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6eedfe2a46esm1687507b3.38.2024.11.21.14.32.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 14:32:30 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Richard Weinberger <richard@nod.at>,
 Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH v2 4/8] test_ut: Allow running unprivileged
Date: Thu, 21 Nov 2024 15:32:10 -0700
Message-ID: <20241121223217.330117-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241121223217.330117-1-sjg@chromium.org>
References: <20241121223217.330117-1-sjg@chromium.org>
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

From: Richard Weinberger <richard@nod.at>

Like for test_fs, no need to mess with loop mounts.

Signed-off-by: Richard Weinberger <richard@nod.at>
Tweaks to reduce diff (keep mnt variable):
Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Attempt to reduce the diff, for easier review

 test/py/tests/test_ut.py | 86 ++++++++++++----------------------------
 1 file changed, 26 insertions(+), 60 deletions(-)

diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index 0b716f4029c..d449d0baf5e 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -8,7 +8,6 @@ test one at a time, as well setting up some files needed by the tests.
 # Copyright (c) 2016, NVIDIA CORPORATION. All rights reserved.
 """
 import collections
-import getpass
 import gzip
 import os
 import os.path
@@ -43,44 +42,21 @@ def setup_image(cons, devnum, part_type, img_size=20, second_part=False,
     Returns:
         tuple:
             str: Filename of MMC image
-            str: Directory name of 'mnt' directory
+            str: Directory name of scratch directory
     """
     fname = os.path.join(cons.config.source_dir, f'{basename}{devnum}.img')
-    mnt = os.path.join(cons.config.persistent_data_dir, 'mnt')
+    mnt = os.path.join(cons.config.persistent_data_dir, 'scratch')
     mkdir_cond(mnt)
 
     spec = f'type={part_type:x}, size={img_size - 2}M, start=1M, bootable'
     if second_part:
         spec += '\ntype=c'
 
-    u_boot_utils.run_and_log(cons, f'qemu-img create {fname} {img_size}M')
-    u_boot_utils.run_and_log(cons, f'sudo sfdisk {fname}',
+    u_boot_utils.run_and_log(cons, f'qemu-img create {fname} 20M')
+    u_boot_utils.run_and_log(cons, f'sfdisk {fname}',
                              stdin=spec.encode('utf-8'))
     return fname, mnt
 
-def mount_image(cons, fname, mnt, fstype):
-    """Create a filesystem and mount it on partition 1
-
-    Args:
-        cons (ConsoleBase): Console to use
-        fname (str): Filename of MMC image
-        mnt (str): Directory name of 'mnt' directory
-        fstype (str): Filesystem type ('vfat' or 'ext4')
-
-    Returns:
-        str: Name of loop device used
-    """
-    out = u_boot_utils.run_and_log(cons, f'sudo losetup --show -f -P {fname}')
-    loop = out.strip()
-    part = f'{loop}p1'
-    u_boot_utils.run_and_log(cons, f'sudo mkfs.{fstype} {part}')
-    opts = ''
-    if fstype == 'vfat':
-        opts += f' -o uid={os.getuid()},gid={os.getgid()}'
-    u_boot_utils.run_and_log(cons, f'sudo mount -o loop {part} {mnt}{opts}')
-    u_boot_utils.run_and_log(cons, f'sudo chown {getpass.getuser()} {mnt}')
-    return loop
-
 def copy_prepared_image(cons, devnum, fname, basename='mmc'):
     """Use a prepared image since we cannot create one
 
@@ -102,13 +78,8 @@ def setup_bootmenu_image(cons):
     mmc_dev = 4
     fname, mnt = setup_image(cons, mmc_dev, 0x83)
 
-    loop = None
-    mounted = False
     complete = False
     try:
-        loop = mount_image(cons, fname, mnt, 'ext4')
-        mounted = True
-
         script = '''# DO NOT EDIT THIS FILE
 #
 # Please edit /boot/armbianEnv.txt to set supported parameters
@@ -212,15 +183,16 @@ booti ${kernel_addr_r} ${ramdisk_addr_r} ${fdt_addr_r}
             cons, f'echo here {kernel} {symlink}')
         os.symlink(kernel, symlink)
 
+        fsfile = 'ext18M.img'
+        u_boot_utils.run_and_log(cons, f'fallocate -l 18M {fsfile}')
+        u_boot_utils.run_and_log(cons, f'mkfs.ext4 {fsfile} -d {mnt}')
+        u_boot_utils.run_and_log(cons, f'dd if={fsfile} of={fname} bs=1M seek=1')
         complete = True
-
     except ValueError as exc:
         print(f'Falled to create image, failing back to prepared copy: {exc}')
     finally:
-        if mounted:
-            u_boot_utils.run_and_log(cons, f'sudo umount --lazy {mnt}')
-        if loop:
-            u_boot_utils.run_and_log(cons, f'sudo losetup -d {loop}')
+        u_boot_utils.run_and_log(cons, f'rm -rf {mnt}')
+        u_boot_utils.run_and_log(cons, f'rm -f {fsfile}')
 
     if not complete:
         copy_prepared_image(cons, mmc_dev, fname)
@@ -230,13 +202,8 @@ def setup_bootflow_image(cons):
     mmc_dev = 1
     fname, mnt = setup_image(cons, mmc_dev, 0xc, second_part=True)
 
-    loop = None
-    mounted = False
     complete = False
     try:
-        loop = mount_image(cons, fname, mnt, 'vfat')
-        mounted = True
-
         vmlinux = 'vmlinuz-5.3.7-301.fc31.armv7hl'
         initrd = 'initramfs-5.3.7-301.fc31.armv7hl.img'
         dtbdir = 'dtb-5.3.7-301.fc31.armv7hl'
@@ -274,19 +241,21 @@ label Fedora-Workstation-armhfp-31-1.9 (5.3.7-301.fc31.armv7hl)
         dtb_file = os.path.join(mnt, f'{dtbdir}/sandbox.dtb')
         u_boot_utils.run_and_log(
             cons, f'dtc -o {dtb_file}', stdin=b'/dts-v1/; / {};')
+
+        fsfile = 'vfat18M.img'
+        u_boot_utils.run_and_log(cons, f'fallocate -l 18M {fsfile}')
+        u_boot_utils.run_and_log(cons, f'mkfs.vfat {fsfile}')
+        u_boot_utils.run_and_log(cons, ['sh', '-c', f'mcopy -i {fsfile} {mnt}/* ::/'])
+        u_boot_utils.run_and_log(cons, f'dd if={fsfile} of={fname} bs=1M seek=1')
         complete = True
     except ValueError as exc:
         print(f'Falled to create image, failing back to prepared copy: {exc}')
     finally:
-        if mounted:
-            u_boot_utils.run_and_log(cons, f'sudo umount --lazy {mnt}')
-        if loop:
-            u_boot_utils.run_and_log(cons, f'sudo losetup -d {loop}')
-
+        u_boot_utils.run_and_log(cons, f'rm -rf {mnt}')
+        u_boot_utils.run_and_log(cons, f'rm -f {fsfile}')
     if not complete:
         copy_prepared_image(cons, mmc_dev, fname)
 
-
 def setup_cros_image(cons):
     """Create a 20MB disk image with ChromiumOS partitions"""
     Partition = collections.namedtuple('part', 'start,size,name')
@@ -336,8 +305,6 @@ def setup_cros_image(cons):
     mmc_dev = 5
     fname = os.path.join(cons.config.source_dir, f'mmc{mmc_dev}.img')
     u_boot_utils.run_and_log(cons, f'qemu-img create {fname} 20M')
-    #mnt = os.path.join(cons.config.persistent_data_dir, 'mnt')
-    #mkdir_cond(mnt)
     u_boot_utils.run_and_log(cons, f'cgpt create {fname}')
 
     uuid_state = 'ebd0a0a2-b9e5-4433-87c0-68b6b72699c7'
@@ -559,31 +526,30 @@ def setup_efi_image(cons):
     fname, mnt = setup_image(cons, devnum, 0xc, second_part=True,
                              basename=basename)
 
-    loop = None
-    mounted = False
     complete = False
     try:
-        loop = mount_image(cons, fname, mnt, 'ext4')
-        mounted = True
         efi_dir = os.path.join(mnt, 'EFI')
         mkdir_cond(efi_dir)
         bootdir = os.path.join(efi_dir, 'BOOT')
         mkdir_cond(bootdir)
         efi_src = os.path.join(cons.config.build_dir,
-                               f'lib/efi_loader/testapp.efi')
+                            'lib/efi_loader/testapp.efi')
         efi_dst = os.path.join(bootdir, 'BOOTSBOX.EFI')
         with open(efi_src, 'rb') as inf:
             with open(efi_dst, 'wb') as outf:
                 outf.write(inf.read())
+        fsfile = 'vfat18M.img'
+        u_boot_utils.run_and_log(cons, f'fallocate -l 18M {fsfile}')
+        u_boot_utils.run_and_log(cons, f'mkfs.vfat {fsfile}')
+        u_boot_utils.run_and_log(cons, ['sh', '-c', f'mcopy -vs -i {fsfile} {mnt}/* ::/'])
+        u_boot_utils.run_and_log(cons, f'dd if={fsfile} of={fname} bs=1M seek=1')
         complete = True
     except ValueError as exc:
         print(f'Falled to create image, failing back to prepared copy: {exc}')
 
     finally:
-        if mounted:
-            u_boot_utils.run_and_log(cons, 'sudo umount --lazy %s' % mnt)
-        if loop:
-            u_boot_utils.run_and_log(cons, 'sudo losetup -d %s' % loop)
+        u_boot_utils.run_and_log(cons, f'rm -rf {mnt}')
+        u_boot_utils.run_and_log(cons, f'rm -f {fsfile}')
 
     if not complete:
         copy_prepared_image(cons, devnum, fname, basename)
-- 
2.43.0

