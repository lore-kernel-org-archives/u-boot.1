Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C03FEC282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 23:24:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1958981298;
	Fri,  7 Mar 2025 00:23:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aP/2NntC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B28B5805D7; Fri,  7 Mar 2025 00:23:18 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA72680F4C
 for <u-boot@lists.denx.de>; Fri,  7 Mar 2025 00:23:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-6fd9d9ae47cso12504207b3.3
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 15:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741303386; x=1741908186; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gfc8BB8I/QiwRjQ4t7D4+qGtjZJiaKLTLWCXuKXJ3ZI=;
 b=aP/2NntC1TAiHvv9ngBqXzm4NZzqnVSz4LY3Z5sAYU6Tem0B0wPmwZnWad1rovAO5y
 tskgW5oGWXRdHZyqAZsu2T9NTZnjXyqKQ62vCiKUeRp3C0j3jMuMNnK0MW0QD8bm9yxZ
 jiJooRrS5RK/X3Z8uBfJ4W3MaydBBuUU0ERb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741303386; x=1741908186;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gfc8BB8I/QiwRjQ4t7D4+qGtjZJiaKLTLWCXuKXJ3ZI=;
 b=epn1WaQL5e8cROGIHWOkSUTOKhY+3e1rZBm9+Q+lH2bpbq1StE7nhfZlWuIN5PwhAh
 rrgwy+uTDVnpba3HYPOrtYc8EZHKlFQI3HVgKPLGtNdD5+SMFZOXadMbhhYS1PJV3bmQ
 O0W6FEWsqljvJLILgmqlH3KwI28+Av4xVE01PSeNKhE+LnyHu9NribgKMhbqwH6WIouP
 0FTjVWQVX4JHijos1Y/4qD//ncvPOiC8I8/z9ljT3R9g8fBxTQShiLOY36uWUDPE+7u0
 tFFl5FbOD3RmdZG1TKf43klaetv9FiOKh+q1VYXClTmlQRfPwdSlk133LPQI5ppHL07e
 NC7A==
X-Gm-Message-State: AOJu0YwXE6/AjqOVg7w6ycgLBWpVhSIPEX3qOGRKu18s2dmXp9c+wVJH
 IsFX1EoihUCE5RKQCTM7Qap2MDqE3eMPZbLl9/g61pZR+XpK8WbX4YFYTDXJWDgiv8jbdczMSnT
 D
X-Gm-Gg: ASbGncucIuTLZbY6f79VN4+//zWBR1S8my90J/Zan2q3ItsMlQ8/K9GWhEWeO+kHOBj
 tPzKer2ifbEbYK3R1sQdiSFWURhebyxVjE7+T9a5mKx808mE+kvVZ/Mm5IGhdwz1552YxWTT6Wv
 kxtlw+BX+3iiRboYWhMG4Wxz0kgUDrabNdU0dMzO55zIPZ1yjQH7hKdsboOFOM5wmBHpEszOUTV
 qE97p3o01+7PdbEqZCR8EcaEq90F9swUBKaZ3eXvGDy2W+NxkttqbgwNWLOtvZ7Sjk49McaP3Q5
 NlBwuP/eYKElBc50jbGI24Mpv6qcaoO59I81uHkA3KUAC98P
X-Google-Smtp-Source: AGHT+IFsKrEa2FgccuGW603UQVSYRh4+trmTKPj8IW3xGp6p+7yJNU6wq4hWEJ/v+93wLWlzonZQ5g==
X-Received: by 2002:a05:690c:4b8b:b0:6fd:3fd0:6f2f with SMTP id
 00721157ae682-6febf3b70c8mr20833237b3.26.1741303386641; 
 Thu, 06 Mar 2025 15:23:06 -0800 (PST)
Received: from bill-the-cat.. ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6feb2a1c260sm4820617b3.6.2025.03.06.15.23.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 15:23:05 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH 03/10] test/py/tests: Move "setup_image" from test_ut.py to
 fs_helper.py
Date: Thu,  6 Mar 2025 17:17:05 -0600
Message-ID: <20250306232256.4150882-4-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306232256.4150882-1-trini@konsulko.com>
References: <20250306232256.4150882-1-trini@konsulko.com>
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

The generic function in test_ut.py to create a disk image with partition
table can be useful outside of test_ut.py so move it to be available
more clearly.

To make this a bit more easily used library function, make use of
check_call directly rather than calling things though u_boot_utils. In
turn, to more easily handle stdin here, use the shell "printf" utility
to pass sfdisk the specification to create as we do not have an actual
file descriptor to use here.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Simon Glass <sjg@chromium.org>
---
 test/py/tests/fs_helper.py | 34 +++++++++++++++++++++++++++++++++
 test/py/tests/test_ut.py   | 39 +++++---------------------------------
 2 files changed, 39 insertions(+), 34 deletions(-)

diff --git a/test/py/tests/fs_helper.py b/test/py/tests/fs_helper.py
index ccfc0201a49f..512ec9c04b06 100644
--- a/test/py/tests/fs_helper.py
+++ b/test/py/tests/fs_helper.py
@@ -69,6 +69,40 @@ def mk_fs(config, fs_type, size, prefix, src_dir=None, size_gran = 0x100000):
         call(f'rm -f {fs_img}', shell=True)
         raise
 
+def setup_image(config, devnum, part_type, img_size=20, second_part=False,
+                basename='mmc'):
+    """Create a disk image with a single partition
+
+    Args:
+        config (u_boot_config): U-Boot configuration
+        devnum (int): Device number to use, e.g. 1
+        part_type (int): Partition type, e.g. 0xc for FAT32
+        img_size (int): Image size in MiB
+        second_part (bool): True to contain a small second partition
+        basename (str): Base name to use in the filename, e.g. 'mmc'
+
+    Returns:
+        tuple:
+            str: Filename of MMC image
+            str: Directory name of scratch directory
+    """
+    fname = os.path.join(config.source_dir, f'{basename}{devnum}.img')
+    mnt = os.path.join(config.persistent_data_dir, 'scratch')
+
+    spec = f'type={part_type:x}, size={img_size - 2}M, start=1M, bootable'
+    if second_part:
+        spec += '\ntype=c'
+
+    try:
+        check_call(f'mkdir -p {mnt}', shell=True)
+        check_call(f'qemu-img create {fname} 20M', shell=True)
+        check_call(f'printf "{spec}" | sfdisk {fname}', shell=True)
+    except CalledProcessError:
+        call(f'rm -f {fname}', shell=True)
+        raise
+
+    return fname, mnt
+
 # Just for trying out
 if __name__ == "__main__":
     import collections
diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index d2d8ce10755b..cec894a7b9e3 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -27,43 +27,13 @@ def mkdir_cond(dirname):
     if not os.path.exists(dirname):
         os.mkdir(dirname)
 
-def setup_image(cons, devnum, part_type, img_size=20, second_part=False,
-                basename='mmc'):
-    """Create a disk image with a single partition
-
-    Args:
-        cons (ConsoleBase): Console to use
-        devnum (int): Device number to use, e.g. 1
-        part_type (int): Partition type, e.g. 0xc for FAT32
-        img_size (int): Image size in MiB
-        second_part (bool): True to contain a small second partition
-        basename (str): Base name to use in the filename, e.g. 'mmc'
-
-    Returns:
-        tuple:
-            str: Filename of MMC image
-            str: Directory name of scratch directory
-    """
-    fname = os.path.join(cons.config.source_dir, f'{basename}{devnum}.img')
-    mnt = os.path.join(cons.config.persistent_data_dir, 'scratch')
-    mkdir_cond(mnt)
-
-    spec = f'type={part_type:x}, size={img_size - 2}M, start=1M, bootable'
-    if second_part:
-        spec += '\ntype=c'
-
-    u_boot_utils.run_and_log(cons, f'qemu-img create {fname} 20M')
-    u_boot_utils.run_and_log(cons, f'sfdisk {fname}',
-                             stdin=spec.encode('utf-8'))
-    return fname, mnt
-
 def setup_bootmenu_image(cons):
     """Create a 20MB disk image with a single ext4 partition
 
     This is modelled on Armbian 22.08 Jammy
     """
     mmc_dev = 4
-    fname, mnt = setup_image(cons, mmc_dev, 0x83)
+    fname, mnt = fs_helper.setup_image(cons.config, mmc_dev, 0x83)
 
     script = '''# DO NOT EDIT THIS FILE
 #
@@ -179,7 +149,8 @@ booti ${kernel_addr_r} ${ramdisk_addr_r} ${fdt_addr_r}
 def setup_bootflow_image(cons):
     """Create a 20MB disk image with a single FAT partition"""
     mmc_dev = 1
-    fname, mnt = setup_image(cons, mmc_dev, 0xc, second_part=True)
+    fname, mnt = fs_helper.setup_image(cons.config, mmc_dev, 0xc,
+                                       second_part=True)
 
     vmlinux = 'vmlinuz-5.3.7-301.fc31.armv7hl'
     initrd = 'initramfs-5.3.7-301.fc31.armv7hl.img'
@@ -545,8 +516,8 @@ def setup_efi_image(cons):
     """Create a 20MB disk image with an EFI app on it"""
     devnum = 1
     basename = 'flash'
-    fname, mnt = setup_image(cons, devnum, 0xc, second_part=True,
-                             basename=basename)
+    fname, mnt = fs_helper.setup_image(cons.config, devnum, 0xc,
+                                       second_part=True, basename=basename)
 
     efi_dir = os.path.join(mnt, 'EFI')
     mkdir_cond(efi_dir)
-- 
2.43.0

