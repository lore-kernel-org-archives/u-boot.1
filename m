Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42CA1C3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 09:36:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6B2488B9D;
	Fri,  2 Aug 2024 11:36:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FB7688B8B; Fri,  2 Aug 2024 11:36:04 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D62F88B80
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 11:36:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=richard@nod.at
Received: from localhost (localhost [127.0.0.1])
 by lithops.sigma-star.at (Postfix) with ESMTP id 4017B64A3D18;
 Fri,  2 Aug 2024 11:36:00 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
 by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id I4ryiR2I2Q3K; Fri,  2 Aug 2024 11:35:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by lithops.sigma-star.at (Postfix) with ESMTP id 60FFF64C3B28;
 Fri,  2 Aug 2024 11:35:59 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
 by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id Gba9uH7OU83g; Fri,  2 Aug 2024 11:35:59 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
 by lithops.sigma-star.at (Postfix) with ESMTPSA id 0BD6264A3D05;
 Fri,  2 Aug 2024 11:35:59 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: u-boot@lists.denx.de
Cc: upstream+uboot@sigma-star.at, francis.laniel@amarulasolutions.com,
 glaroque@baylibre.com, mkorpershoek@baylibre.com, sjg@chromium.org,
 christian.taedcke@weidmueller.com, trini@konsulko.com,
 Richard Weinberger <richard@nod.at>
Subject: [PATCH 3/3] test_ut: Allow running unprivileged
Date: Fri,  2 Aug 2024 11:33:22 +0200
Message-Id: <20240802093322.15240-3-richard@nod.at>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240802093322.15240-1-richard@nod.at>
References: <20240802093322.15240-1-richard@nod.at>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

Like for test_fs, no need to mess with loop mounts.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 test/py/tests/test_ut.py | 93 +++++++++++++++-------------------------
 1 file changed, 34 insertions(+), 59 deletions(-)

diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index 3cef6c29fa..41003c14ff 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -2,7 +2,6 @@
 # Copyright (c) 2016, NVIDIA CORPORATION. All rights reserved.
=20
 import collections
-import getpass
 import gzip
 import os
 import os.path
@@ -22,8 +21,8 @@ def mkdir_cond(dirname):
     if not os.path.exists(dirname):
         os.mkdir(dirname)
=20
-def setup_image(cons, mmc_dev, part_type, second_part=3DFalse):
-    """Create a 20MB disk image with a single partition
+def setup_image(cons, mmc_dev, part_type, img_size, second_part=3DFalse)=
:
+    """Create a img_size sized disk image with a single partition
=20
     Args:
         cons (ConsoleBase): Console to use
@@ -32,45 +31,18 @@ def setup_image(cons, mmc_dev, part_type, second_part=
=3DFalse):
         second_part (bool): True to contain a small second partition
=20
     Returns:
-        tuple:
-            str: Filename of MMC image
-            str: Directory name of 'mnt' directory
+        str: Filename of MMC image
     """
     fname =3D os.path.join(cons.config.source_dir, f'mmc{mmc_dev}.img')
-    mnt =3D os.path.join(cons.config.persistent_data_dir, 'mnt')
-    mkdir_cond(mnt)
=20
-    spec =3D f'type=3D{part_type:x}, size=3D18M, bootable'
+    spec =3D f'type=3D{part_type:x}, size=3D{img_size - 2}M, start=3D1M,=
 bootable'
     if second_part:
         spec +=3D '\ntype=3Dc'
=20
-    u_boot_utils.run_and_log(cons, 'qemu-img create %s 20M' % fname)
-    u_boot_utils.run_and_log(cons, 'sudo sfdisk %s' % fname,
+    u_boot_utils.run_and_log(cons, f'qemu-img create {fname} {img_size}M=
')
+    u_boot_utils.run_and_log(cons, 'sfdisk %s' % fname,
                              stdin=3Dspec.encode('utf-8'))
-    return fname, mnt
-
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
-    out =3D u_boot_utils.run_and_log(cons, 'sudo losetup --show -f -P %s=
' % fname)
-    loop =3D out.strip()
-    part =3D f'{loop}p1'
-    u_boot_utils.run_and_log(cons, f'sudo mkfs.{fstype} {part}')
-    opts =3D ''
-    if fstype =3D=3D 'vfat':
-         opts +=3D f' -o uid=3D{os.getuid()},gid=3D{os.getgid()}'
-    u_boot_utils.run_and_log(cons, f'sudo mount -o loop {part} {mnt}{opt=
s}')
-    u_boot_utils.run_and_log(cons, f'sudo chown {getpass.getuser()} {mnt=
}')
-    return loop
+    return fname
=20
 def copy_prepared_image(cons, mmc_dev, fname):
     """Use a prepared image since we cannot create one
@@ -92,14 +64,12 @@ def setup_bootmenu_image(cons):
     This is modelled on Armbian 22.08 Jammy
     """
     mmc_dev =3D 4
-    fname, mnt =3D setup_image(cons, mmc_dev, 0x83)
+    fname =3D setup_image(cons, mmc_dev, 0x83, 20)
=20
-    loop =3D None
-    mounted =3D False
     complete =3D False
     try:
-        loop =3D mount_image(cons, fname, mnt, 'ext4')
-        mounted =3D True
+        scratch_dir =3D os.path.join(cons.config.persistent_data_dir, 's=
cratch')
+        mkdir_cond(scratch_dir)
=20
         vmlinux =3D 'Image'
         initrd =3D 'uInitrd'
@@ -178,7 +148,7 @@ booti ${kernel_addr_r} ${ramdisk_addr_r} ${fdt_addr_r=
}
 # Recompile with:
 # mkimage -C none -A arm -T script -d /boot/boot.cmd /boot/boot.scr
 ''' % (mmc_dev)
-        bootdir =3D os.path.join(mnt, 'boot')
+        bootdir =3D os.path.join(scratch_dir, 'boot')
         mkdir_cond(bootdir)
         cmd_fname =3D os.path.join(bootdir, 'boot.cmd')
         scr_fname =3D os.path.join(bootdir, 'boot.scr')
@@ -209,16 +179,19 @@ booti ${kernel_addr_r} ${ramdisk_addr_r} ${fdt_addr=
_r}
=20
         u_boot_utils.run_and_log(
             cons, f'mkimage -C none -A arm -T script -d {cmd_fname} {scr=
_fname}')
+
+        fsfile =3D 'ext18M.img'
+        u_boot_utils.run_and_log(cons, f'fallocate -l 18M {fsfile}')
+        u_boot_utils.run_and_log(cons, f'mkfs.ext4 {fsfile} -d {scratch_=
dir}')
+        u_boot_utils.run_and_log(cons, f'dd if=3D{fsfile} of=3D{fname} b=
s=3D1M seek=3D1')
         complete =3D True
=20
     except ValueError as exc:
         print('Falled to create image, failing back to prepared copy: %s=
',
               str(exc))
     finally:
-        if mounted:
-            u_boot_utils.run_and_log(cons, 'sudo umount --lazy %s' % mnt=
)
-        if loop:
-            u_boot_utils.run_and_log(cons, 'sudo losetup -d %s' % loop)
+        u_boot_utils.run_and_log(cons, 'rm -rf %s' % scratch_dir)
+        u_boot_utils.run_and_log(cons, 'rm -f %s' % fsfile)
=20
     if not complete:
         copy_prepared_image(cons, mmc_dev, fname)
@@ -226,14 +199,12 @@ booti ${kernel_addr_r} ${ramdisk_addr_r} ${fdt_addr=
_r}
 def setup_bootflow_image(cons):
     """Create a 20MB disk image with a single FAT partition"""
     mmc_dev =3D 1
-    fname, mnt =3D setup_image(cons, mmc_dev, 0xc, second_part=3DTrue)
+    fname =3D setup_image(cons, mmc_dev, 0xc, 20, second_part=3DTrue)
=20
-    loop =3D None
-    mounted =3D False
     complete =3D False
     try:
-        loop =3D mount_image(cons, fname, mnt, 'vfat')
-        mounted =3D True
+        scratch_dir =3D os.path.join(cons.config.persistent_data_dir, 's=
cratch')
+        mkdir_cond(scratch_dir)
=20
         vmlinux =3D 'vmlinuz-5.3.7-301.fc31.armv7hl'
         initrd =3D 'initramfs-5.3.7-301.fc31.armv7hl.img'
@@ -251,7 +222,7 @@ label Fedora-Workstation-armhfp-31-1.9 (5.3.7-301.fc3=
1.armv7hl)
         append ro root=3DUUID=3D9732b35b-4cd5-458b-9b91-80f7047e0b8a rhg=
b quiet LANG=3Den_US.UTF-8 cma=3D192MB cma=3D256MB
         fdtdir /%s/
         initrd /%s''' % (vmlinux, dtbdir, initrd)
-        ext =3D os.path.join(mnt, 'extlinux')
+        ext =3D os.path.join(scratch_dir, 'extlinux')
         mkdir_cond(ext)
=20
         with open(os.path.join(ext, 'extlinux.conf'), 'w') as fd:
@@ -261,25 +232,29 @@ label Fedora-Workstation-armhfp-31-1.9 (5.3.7-301.f=
c31.armv7hl)
         with open(inf, 'wb') as fd:
             fd.write(gzip.compress(b'vmlinux'))
         u_boot_utils.run_and_log(cons, 'mkimage -f auto -d %s %s' %
-                                 (inf, os.path.join(mnt, vmlinux)))
+                                 (inf, os.path.join(scratch_dir, vmlinux=
)))
=20
-        with open(os.path.join(mnt, initrd), 'w') as fd:
+        with open(os.path.join(scratch_dir, initrd), 'w') as fd:
             print('initrd', file=3Dfd)
=20
-        mkdir_cond(os.path.join(mnt, dtbdir))
+        mkdir_cond(os.path.join(scratch_dir, dtbdir))
=20
-        dtb_file =3D os.path.join(mnt, '%s/sandbox.dtb' % dtbdir)
+        dtb_file =3D os.path.join(scratch_dir, '%s/sandbox.dtb' % dtbdir=
)
         u_boot_utils.run_and_log(
             cons, 'dtc -o %s' % dtb_file, stdin=3Db'/dts-v1/; / {};')
+
+        fsfile =3D 'vfat18M.img'
+        u_boot_utils.run_and_log(cons, f'fallocate -l 18M {fsfile}')
+        u_boot_utils.run_and_log(cons, f'mkfs.vfat {fsfile}')
+        u_boot_utils.run_and_log(cons, ['sh', '-c', f'mcopy -i {fsfile} =
{scratch_dir}/* ::/'])
+        u_boot_utils.run_and_log(cons, f'dd if=3D{fsfile} of=3D{fname} b=
s=3D1M seek=3D1')
         complete =3D True
     except ValueError as exc:
         print('Falled to create image, failing back to prepared copy: %s=
',
               str(exc))
     finally:
-        if mounted:
-            u_boot_utils.run_and_log(cons, 'sudo umount --lazy %s' % mnt=
)
-        if loop:
-            u_boot_utils.run_and_log(cons, 'sudo losetup -d %s' % loop)
+        u_boot_utils.run_and_log(cons, 'rm -rf %s' % scratch_dir)
+        u_boot_utils.run_and_log(cons, 'rm -f %s' % fsfile)
=20
     if not complete:
         copy_prepared_image(cons, mmc_dev, fname)
--=20
2.35.3

