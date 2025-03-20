Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B10DEC28B30
	for <u-boot@archiver.kernel.org>; Thu, 20 Mar 2025 14:01:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EB4D81D5A;
	Thu, 20 Mar 2025 15:00:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="H90brCAq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B4288198A; Thu, 20 Mar 2025 15:00:43 +0100 (CET)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39A6481101
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 15:00:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2ff6e91cff5so1366371a91.2
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 07:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742479238; x=1743084038; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cgTOJG1SR92Zc+AqlBQM2WqEywVvvfnHfjWeU/CPjWM=;
 b=H90brCAqblA8geTAThMxcziiw5TeX8BVxSvnTbBGg0IJi1mvN5qpbdAScbRik1c688
 Ee9SbvY3+Rwk3bDdeIamPmitWl8HLsk7onsQ6f9ZVAEj1IOmxatLGcdDIp5BXuZ52qmH
 3sJ+W7nN4ksC3vrPOGt7+0lV9k6C/4aCXeRjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742479238; x=1743084038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cgTOJG1SR92Zc+AqlBQM2WqEywVvvfnHfjWeU/CPjWM=;
 b=wc4Dm1EZtWbfc7XvF4hz+AYRADDoqNI9IigVTx7lUqCJYcbCQs2ZN67X1/d3b1yUN8
 fEXm/CQgs/Pk+9gDsRMSDNkJ2DdHAIkGQ89bvAu7Ot+68/FyMy4qIZMbhmdSuKRnV2R2
 eE/ZHfloSYOG7HzKXgolfqcY8DfEdX0W0qIBGInWGunqTL50nh77LGSFHyS9sVhsSLvy
 lCTeWxe5Ele0zYBQOvPzQJlUC6xZeoeTXONQY8yU6+Nll6bFiJQn4syy/cNBIRmAwPjk
 DtB/BjYyfnL2V+O7dpvg/nNmJ/RLVR6Uwvhc/GdQM6IsdammfBqXwNu7PZX74wAIRfLc
 Ncaw==
X-Gm-Message-State: AOJu0Yx6bzdyIHS08QqeFOHDqzjiz8zO+WR40GTmvdjFZTKTHA7DwSuA
 DJg6Ysc9kmUQZl+Z/35mnDbTJVLyPhI9POlbmGNX4SSGi9tlx36DK+1hFZqRlhId/OBulGrEbu5
 2
X-Gm-Gg: ASbGncsHgFFz9dz2U+rw51ZbLLdXyzQMuKKCT90qAmNsvZgT9K6P0Wh36BKAsHAvynL
 6ybj0bD/aNsZDaz42G6kpDQx0j+hjLcnW0ufja4ooj7hRAwbSIIYeIxSZ36yL4eHUOltN8vM+5Y
 WC9Db9YPTCZujC+40fp4SRFJogB8aRMkL5ywCiFMdGwtroJqc1jCBHpQqd9mIPXY+wehKQEpUCY
 jP3trcqBRBSB9eDdHvQ7wkLFCe+4yO732dyg/bJv36TGG8cMSdtJfu+9b7Zu9J7QLRIhjJSqgFt
 O0DO50jyYJJc8bpaq1OSEE4LAASmiZYmstrmiD5h3oPMR6sI
X-Google-Smtp-Source: AGHT+IEL3TxuBVkoljEQE+bMCJ74COGIvnQ+f92xdXeDM6XIwqcji/KDS1B8tI6rdQmn5RJOzSqnaQ==
X-Received: by 2002:a17:90b:3c0a:b0:2ff:4bac:6fba with SMTP id
 98e67ed59e1d1-301d53241a1mr5611124a91.24.1742479237492; 
 Thu, 20 Mar 2025 07:00:37 -0700 (PDT)
Received: from bill-the-cat.. ([187.144.138.125])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301bf59cd49sm3857532a91.22.2025.03.20.07.00.36
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 07:00:37 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH v2 03/10] test/py/tests: Move "setup_image" from test_ut.py to
 fs_helper.py
Date: Thu, 20 Mar 2025 07:59:24 -0600
Message-ID: <20250320140030.2052434-4-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250320140030.2052434-1-trini@konsulko.com>
References: <20250320140030.2052434-1-trini@konsulko.com>
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
Changes in v2:
- Rebase on next after the ubman series.
---
 test/py/tests/fs_helper.py | 34 ++++++++++++++++++++++++++++++++++
 test/py/tests/test_ut.py   | 38 ++++----------------------------------
 2 files changed, 38 insertions(+), 34 deletions(-)

diff --git a/test/py/tests/fs_helper.py b/test/py/tests/fs_helper.py
index ccfc0201a49f..f3e81b6bc61b 100644
--- a/test/py/tests/fs_helper.py
+++ b/test/py/tests/fs_helper.py
@@ -69,6 +69,40 @@ def mk_fs(config, fs_type, size, prefix, src_dir=None, size_gran = 0x100000):
         call(f'rm -f {fs_img}', shell=True)
         raise
 
+def setup_image(ubman, devnum, part_type, img_size=20, second_part=False,
+                basename='mmc'):
+    """Create a disk image with a single partition
+
+    Args:
+        ubman (ConsoleBase): Console to use
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
+    fname = os.path.join(ubman.config.source_dir, f'{basename}{devnum}.img')
+    mnt = os.path.join(ubman.config.persistent_data_dir, 'scratch')
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
index ea0c43cd4fcc..3a3f12d08984 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -27,43 +27,13 @@ def mkdir_cond(dirname):
     if not os.path.exists(dirname):
         os.mkdir(dirname)
 
-def setup_image(ubman, devnum, part_type, img_size=20, second_part=False,
-                basename='mmc'):
-    """Create a disk image with a single partition
-
-    Args:
-        ubman (ConsoleBase): Console to use
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
-    fname = os.path.join(ubman.config.source_dir, f'{basename}{devnum}.img')
-    mnt = os.path.join(ubman.config.persistent_data_dir, 'scratch')
-    mkdir_cond(mnt)
-
-    spec = f'type={part_type:x}, size={img_size - 2}M, start=1M, bootable'
-    if second_part:
-        spec += '\ntype=c'
-
-    utils.run_and_log(ubman, f'qemu-img create {fname} 20M')
-    utils.run_and_log(ubman, f'sfdisk {fname}',
-                             stdin=spec.encode('utf-8'))
-    return fname, mnt
-
 def setup_bootmenu_image(ubman):
     """Create a 20MB disk image with a single ext4 partition
 
     This is modelled on Armbian 22.08 Jammy
     """
     mmc_dev = 4
-    fname, mnt = setup_image(ubman, mmc_dev, 0x83)
+    fname, mnt = fs_helper.setup_image(ubman, mmc_dev, 0x83)
 
     script = '''# DO NOT EDIT THIS FILE
 #
@@ -179,7 +149,7 @@ booti ${kernel_addr_r} ${ramdisk_addr_r} ${fdt_addr_r}
 def setup_bootflow_image(ubman):
     """Create a 20MB disk image with a single FAT partition"""
     mmc_dev = 1
-    fname, mnt = setup_image(ubman, mmc_dev, 0xc, second_part=True)
+    fname, mnt = fs_helper.setup_image(ubman, mmc_dev, 0xc, second_part=True)
 
     vmlinux = 'vmlinuz-5.3.7-301.fc31.armv7hl'
     initrd = 'initramfs-5.3.7-301.fc31.armv7hl.img'
@@ -545,8 +515,8 @@ def setup_efi_image(ubman):
     """Create a 20MB disk image with an EFI app on it"""
     devnum = 1
     basename = 'flash'
-    fname, mnt = setup_image(ubman, devnum, 0xc, second_part=True,
-                             basename=basename)
+    fname, mnt = fs_helper.setup_image(ubman, devnum, 0xc, second_part=True,
+                                       basename=basename)
 
     efi_dir = os.path.join(mnt, 'EFI')
     mkdir_cond(efi_dir)
-- 
2.43.0

