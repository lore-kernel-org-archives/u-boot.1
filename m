Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69397C54FC6
	for <u-boot@archiver.kernel.org>; Sun,  1 Sep 2024 22:27:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EF3388AD7;
	Mon,  2 Sep 2024 00:26:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="A6g+0D6w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4514688A7F; Mon,  2 Sep 2024 00:26:52 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E702A8690D
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 00:26:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-82a3acaa1bbso42167639f.2
 for <u-boot@lists.denx.de>; Sun, 01 Sep 2024 15:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725229608; x=1725834408; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JOKXGXx2O0QuWJLmpb70snzkVoo3Pg5CAS+f/O7nx4k=;
 b=A6g+0D6w2PwUY1czocyEPV4Nv0L0efuHdvteRzsH2kMhkupjl0xHKCqJO30tHyiiwu
 DoqyI7uCiG/bVEW9EOU+GP84YNVhX0WUWZEYIq8/5UPbSg+YxyPVptIrbmWl2oI4nrSL
 zclzSzMGUjG0HSmrQ6BQma7x+yi8FChhDF5nQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725229608; x=1725834408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JOKXGXx2O0QuWJLmpb70snzkVoo3Pg5CAS+f/O7nx4k=;
 b=kp6+eG4h8+sEKBnGJOkZk9TtIkVc/+NU51qcWm1Q80/fBOtYBK+Ly0k8uzHUbtiEeJ
 FOuCt/W6OnYYBNCQUv5cr+TJrINgtGbzT+XuQ31lItydlcu0qSSij8OQs5daCpZJzyx5
 /nfrZY4Z1ov4ZH8btFQ7RSe7AoOi+Zzo4yiY6XVCYYSeulHYSRNVDpX0NlCh+HZV3NmD
 YBWlG/Y+yaqP/If97J/U9EGsBRMQnNcILvz4m+xhSZuRH0lRkFdUCdCKFLEQ6srIrsh1
 6P1HNjQLaxhLTDKeCHo9XkRgcEBbyZDJctK4k5BDDtRsubJ7TJiJrJkXQfm9JxDfA+QO
 m74Q==
X-Gm-Message-State: AOJu0YzsOHYfCAZq93MGRe8i5kRFdiR3mqiPnj676jmXkMiSYq1OF3Aj
 oOzDZPnY5dBekubXOpZbusmkSNIhTtAbI21h6rpi0k0Z7hCEvoMeWqcgqcQgOvj6QD5uF9XTqac
 =
X-Google-Smtp-Source: AGHT+IHZv9C8C9lMDAXyJOwP2ZW0ewYVwW5SLmpCRWGTujrveTFf/bQ1tsu6vb7afk+L90NFcetshw==
X-Received: by 2002:a05:6602:60c7:b0:807:f0fb:11a2 with SMTP id
 ca18e2360f4ac-82a11094588mr1529340639f.13.1725229608030; 
 Sun, 01 Sep 2024 15:26:48 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-82a1a4c099asm215751839f.48.2024.09.01.15.26.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Sep 2024 15:26:47 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Stephen Warren <swarren@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH v4 03/23] test/py: Fix some pylint warnings in test_ut.py
Date: Sun,  1 Sep 2024 16:26:14 -0600
Message-Id: <20240901222634.460873-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240901222634.460873-1-sjg@chromium.org>
References: <20240901222634.460873-1-sjg@chromium.org>
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

Tidy up most of these warnings. Remaining are four of these:

   R0914: Too many local variables

which can only by fixed by splitting things into functions, so that is
left for another time.

Part of this change was done by the flynt tool.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/py/tests/test_ut.py | 94 ++++++++++++++++++++--------------------
 1 file changed, 48 insertions(+), 46 deletions(-)

diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index 05e15830590..39aa1035e34 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -1,6 +1,12 @@
 # SPDX-License-Identifier: GPL-2.0
-# Copyright (c) 2016, NVIDIA CORPORATION. All rights reserved.
+"""
+Unit-test runner
+
+Provides a test_ut() function which is used by conftest.py to run each unit
+test one at a time, as well setting up some files needed by the tests.
 
+# Copyright (c) 2016, NVIDIA CORPORATION. All rights reserved.
+"""
 import collections
 import getpass
 import gzip
@@ -44,8 +50,8 @@ def setup_image(cons, mmc_dev, part_type, second_part=False):
     if second_part:
         spec += '\ntype=c'
 
-    u_boot_utils.run_and_log(cons, 'qemu-img create %s 20M' % fname)
-    u_boot_utils.run_and_log(cons, 'sudo sfdisk %s' % fname,
+    u_boot_utils.run_and_log(cons, f'qemu-img create {fname} 20M')
+    u_boot_utils.run_and_log(cons, f'sudo sfdisk {fname}',
                              stdin=spec.encode('utf-8'))
     return fname, mnt
 
@@ -61,13 +67,13 @@ def mount_image(cons, fname, mnt, fstype):
     Returns:
         str: Name of loop device used
     """
-    out = u_boot_utils.run_and_log(cons, 'sudo losetup --show -f -P %s' % fname)
+    out = u_boot_utils.run_and_log(cons, f'sudo losetup --show -f -P {fname}')
     loop = out.strip()
     part = f'{loop}p1'
     u_boot_utils.run_and_log(cons, f'sudo mkfs.{fstype} {part}')
     opts = ''
     if fstype == 'vfat':
-         opts += f' -o uid={os.getuid()},gid={os.getgid()}'
+        opts += f' -o uid={os.getuid()},gid={os.getgid()}'
     u_boot_utils.run_and_log(cons, f'sudo mount -o loop {part} {mnt}{opts}')
     u_boot_utils.run_and_log(cons, f'sudo chown {getpass.getuser()} {mnt}')
     return loop
@@ -82,9 +88,7 @@ def copy_prepared_image(cons, mmc_dev, fname):
     """
     infname = os.path.join(cons.config.source_dir,
                            f'test/py/tests/bootstd/mmc{mmc_dev}.img.xz')
-    u_boot_utils.run_and_log(
-        cons,
-        ['sh', '-c', 'xz -dc %s >%s' % (infname, fname)])
+    u_boot_utils.run_and_log(cons, ['sh', '-c', f'xz -dc {infname} >{fname}'])
 
 def setup_bootmenu_image(cons):
     """Create a 20MB disk image with a single ext4 partition
@@ -101,9 +105,6 @@ def setup_bootmenu_image(cons):
         loop = mount_image(cons, fname, mnt, 'ext4')
         mounted = True
 
-        vmlinux = 'Image'
-        initrd = 'uInitrd'
-        dtbdir = 'dtb'
         script = '''# DO NOT EDIT THIS FILE
 #
 # Please edit /boot/armbianEnv.txt to set supported parameters
@@ -177,12 +178,12 @@ booti ${kernel_addr_r} ${ramdisk_addr_r} ${fdt_addr_r}
 
 # Recompile with:
 # mkimage -C none -A arm -T script -d /boot/boot.cmd /boot/boot.scr
-''' % (mmc_dev)
+'''
         bootdir = os.path.join(mnt, 'boot')
         mkdir_cond(bootdir)
         cmd_fname = os.path.join(bootdir, 'boot.cmd')
         scr_fname = os.path.join(bootdir, 'boot.scr')
-        with open(cmd_fname, 'w') as outf:
+        with open(cmd_fname, 'w', encoding='ascii') as outf:
             print(script, file=outf)
 
         infname = os.path.join(cons.config.source_dir,
@@ -212,13 +213,12 @@ booti ${kernel_addr_r} ${ramdisk_addr_r} ${fdt_addr_r}
         complete = True
 
     except ValueError as exc:
-        print('Falled to create image, failing back to prepared copy: %s',
-              str(exc))
+        print(f'Falled to create image, failing back to prepared copy: {exc}')
     finally:
         if mounted:
-            u_boot_utils.run_and_log(cons, 'sudo umount --lazy %s' % mnt)
+            u_boot_utils.run_and_log(cons, f'sudo umount --lazy {mnt}')
         if loop:
-            u_boot_utils.run_and_log(cons, 'sudo losetup -d %s' % loop)
+            u_boot_utils.run_and_log(cons, f'sudo losetup -d {loop}')
 
     if not complete:
         copy_prepared_image(cons, mmc_dev, fname)
@@ -254,32 +254,32 @@ label Fedora-Workstation-armhfp-31-1.9 (5.3.7-301.fc31.armv7hl)
         ext = os.path.join(mnt, 'extlinux')
         mkdir_cond(ext)
 
-        with open(os.path.join(ext, 'extlinux.conf'), 'w') as fd:
+        conf = os.path.join(ext, 'extlinux.conf')
+        with open(conf, 'w', encoding='ascii') as fd:
             print(script, file=fd)
 
         inf = os.path.join(cons.config.persistent_data_dir, 'inf')
         with open(inf, 'wb') as fd:
             fd.write(gzip.compress(b'vmlinux'))
-        u_boot_utils.run_and_log(cons, 'mkimage -f auto -d %s %s' %
-                                 (inf, os.path.join(mnt, vmlinux)))
+        u_boot_utils.run_and_log(
+            cons, f'mkimage -f auto -d {inf} {os.path.join(mnt, vmlinux)}')
 
-        with open(os.path.join(mnt, initrd), 'w') as fd:
+        with open(os.path.join(mnt, initrd), 'w', encoding='ascii') as fd:
             print('initrd', file=fd)
 
         mkdir_cond(os.path.join(mnt, dtbdir))
 
-        dtb_file = os.path.join(mnt, '%s/sandbox.dtb' % dtbdir)
+        dtb_file = os.path.join(mnt, f'{dtbdir}/sandbox.dtb')
         u_boot_utils.run_and_log(
-            cons, 'dtc -o %s' % dtb_file, stdin=b'/dts-v1/; / {};')
+            cons, f'dtc -o {dtb_file}', stdin=b'/dts-v1/; / {};')
         complete = True
     except ValueError as exc:
-        print('Falled to create image, failing back to prepared copy: %s',
-              str(exc))
+        print(f'Falled to create image, failing back to prepared copy: {exc}')
     finally:
         if mounted:
-            u_boot_utils.run_and_log(cons, 'sudo umount --lazy %s' % mnt)
+            u_boot_utils.run_and_log(cons, f'sudo umount --lazy {mnt}')
         if loop:
-            u_boot_utils.run_and_log(cons, 'sudo losetup -d %s' % loop)
+            u_boot_utils.run_and_log(cons, f'sudo losetup -d {loop}')
 
     if not complete:
         copy_prepared_image(cons, mmc_dev, fname)
@@ -303,7 +303,8 @@ def setup_cros_image(cons):
         Return:
             bytes: Packed-kernel data
         """
-        kern_part = os.path.join(cons.config.result_dir, 'kern-part-{arch}.bin')
+        kern_part = os.path.join(cons.config.result_dir,
+                                 f'kern-part-{arch}.bin')
         u_boot_utils.run_and_log(
             cons,
             f'futility vbutil_kernel --pack {kern_part} '
@@ -332,7 +333,7 @@ def setup_cros_image(cons):
 
     mmc_dev = 5
     fname = os.path.join(cons.config.source_dir, f'mmc{mmc_dev}.img')
-    u_boot_utils.run_and_log(cons, 'qemu-img create %s 20M' % fname)
+    u_boot_utils.run_and_log(cons, f'qemu-img create {fname} 20M')
     #mnt = os.path.join(cons.config.persistent_data_dir, 'mnt')
     #mkdir_cond(mnt)
     u_boot_utils.run_and_log(cons, f'cgpt create {fname}')
@@ -381,20 +382,20 @@ def setup_cros_image(cons):
 
     u_boot_utils.run_and_log(cons, f'cgpt boot -p {fname}')
     out = u_boot_utils.run_and_log(cons, f'cgpt show -q {fname}')
-    '''We expect something like this:
-        8239        2048       1  Basic data
-          45        2048       2  ChromeOS kernel
-        8238           1       3  ChromeOS rootfs
-        2093        2048       4  ChromeOS kernel
-        8237           1       5  ChromeOS rootfs
-          41           1       6  ChromeOS kernel
-          42           1       7  ChromeOS rootfs
-        4141        2048       8  Basic data
-          43           1       9  ChromeOS reserved
-          44           1      10  ChromeOS reserved
-          40           1      11  ChromeOS firmware
-        6189        2048      12  EFI System Partition
-    '''
+
+    # We expect something like this:
+    #   8239        2048       1  Basic data
+    #     45        2048       2  ChromeOS kernel
+    #   8238           1       3  ChromeOS rootfs
+    #   2093        2048       4  ChromeOS kernel
+    #   8237           1       5  ChromeOS rootfs
+    #     41           1       6  ChromeOS kernel
+    #     42           1       7  ChromeOS rootfs
+    #   4141        2048       8  Basic data
+    #     43           1       9  ChromeOS reserved
+    #     44           1      10  ChromeOS reserved
+    #     40           1      11  ChromeOS firmware
+    #   6189        2048      12  EFI System Partition
 
     # Create a dict (indexed by partition number) containing the above info
     for line in out.splitlines():
@@ -446,7 +447,7 @@ def setup_android_image(cons):
 
     mmc_dev = 7
     fname = os.path.join(cons.config.source_dir, f'mmc{mmc_dev}.img')
-    u_boot_utils.run_and_log(cons, 'qemu-img create %s 20M' % fname)
+    u_boot_utils.run_and_log(cons, f'qemu-img create {fname} 20M')
     u_boot_utils.run_and_log(cons, f'cgpt create {fname}')
 
     ptr = 40
@@ -498,11 +499,12 @@ def setup_android_image(cons):
     with open(fname, 'wb') as outf:
         outf.write(disk_data)
 
-    print('wrote to {}'.format(fname))
+    print(f'wrote to {fname}')
 
     return fname
 
 def setup_cedit_file(cons):
+    """Set up a .dtb file for use with testing expo and configuration editor"""
     infname = os.path.join(cons.config.source_dir,
                            'test/boot/files/expo_layout.dts')
     inhname = os.path.join(cons.config.source_dir,
@@ -584,7 +586,7 @@ def test_ut(u_boot_console, ut_subtest):
         # ut hush hush_test_simple_dollar prints "Unknown command" on purpose.
         with u_boot_console.disable_check('unknown_command'):
             output = u_boot_console.run_command('ut ' + ut_subtest)
-        assert('Unknown command \'quux\' - try \'help\'' in output)
+        assert 'Unknown command \'quux\' - try \'help\'' in output
     else:
         output = u_boot_console.run_command('ut ' + ut_subtest)
     assert output.endswith('Failures: 0')
-- 
2.34.1

