Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A909ACD4F3D
	for <u-boot@archiver.kernel.org>; Sun, 17 May 2026 22:52:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57CA2846A7;
	Mon, 18 May 2026 00:51:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fzz+Qq5J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9256845E3; Mon, 18 May 2026 00:51:46 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 385498469D
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 00:51:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7de431da8fbso1639615a34.1
 for <u-boot@lists.denx.de>; Sun, 17 May 2026 15:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779058302; x=1779663102; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N0C7P9RHsJwXbq8UemgrpmWvMOo3vtqCEeOjP9y2LMc=;
 b=fzz+Qq5JXEGFo+nADwYeKJvFwnJwsXFeV+QXhhiitut3xtiyNtIlHWQCgP3kfbIbWS
 raZ98JxgdS1JuFgrPp4u1q7rRAV74ykz48E7pGhkwzjVmLpi1CUxeu/BB3QS1NO6UHCt
 XzZ2wm93pGapsFDF9T/h9Qt245dVfPqLWc5zQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779058302; x=1779663102;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N0C7P9RHsJwXbq8UemgrpmWvMOo3vtqCEeOjP9y2LMc=;
 b=QDDP00B4HCdO8ggDcNIwH83SstikuBMXO8magCF+aD1wwU+N+ChyL9eLXYjLobkAK7
 uwoRrw1JQju7iNNvH3GdBfBnEQcjaY/CWILzUxc7/NfkAqJ3jZ5W83BcZijPdM/fRilJ
 uz78AaeKkuV5ZkqkZ3iY3wlHnWp4QMcr7iIdgjnHxPu1HLizwtXxdSzs2i400+ukZf5q
 4SKKJhgkvomzlK+y2diEy2sA0Ytzcjp0iTiQjGxYjrkEzM/vNXf1ZEi19px3hi9edT86
 9pS3Eo4XlGXBpyMW+EBenHNSeLpyEvLbCbP3rFMCg+m1/RxIeVVYK8qtETQv6Vj5LuI/
 JUhg==
X-Gm-Message-State: AOJu0YyBN5e9znDfmyCjwFd1PFlc/TmiBc6vs8QWP4gEwetrrpUbS2OT
 +xuHXHDENcuYE08vEU6m12/8+Z07biEuA4OyaIwfBKRQLNhh3uI8ii83mKbOqXAtpb0PiBFjzAd
 5np2kTvW9
X-Gm-Gg: Acq92OHIbIT6k5RXPGRJ6vYVF0L7nGFDvy3kS8367TUcoIs9iJSvLLhdWoeTKIKiIzi
 LBM51SayoMQQEIfOYrYrEcxUG9A4Mi34wO14q9rg0uOtYwSsaDJnSPzch9Ko/bts3frqyPZfYIu
 ITcD+FiPDTcBW6k9m8RjV7zvoAydoVXRteBhcc+Dm0S3m98TQgjIhWDoSCQTbhgraPl3PqtOeUQ
 PQuCdvLT12Z7qB31RZnY1KDXkXVQuVhi/t2Nca5z+qlQS8xj+XAe7R8nE839lBnDWo2ySfHG4tR
 IrsNv+KabWEA1hpcQDysCRxm0mIqGUY88DtyC91Nu2npqV0yrBH/QlJoUXQtOZwu9NetEleF4if
 ZqbQgh9SruP1CzQS7s2b9W1zToFN3KrrhUE5V7ospIAVaLi6hfRC5hpWftdxKKrZ4syDmT5lOYb
 Xs3D4D+Pj2me3pTJh6krjosb2FtV7Y
X-Received: by 2002:a05:6830:3903:b0:7e3:a897:5160 with SMTP id
 46e09a7af769-7e4f2b78c7emr8668038a34.13.1779058302336; 
 Sun, 17 May 2026 15:51:42 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55bc4983asm6386357a34.26.2026.05.17.15.51.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 15:51:40 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 04/11] test: Move ChromeOS image-creation to its own file
Date: Sun, 17 May 2026 16:51:02 -0600
Message-ID: <20260517225122.2966807-5-sjg@chromium.org>
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

Move setup_cros_image() to its own module. This function creates disk
images with a ChromiumOS partition layout.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/py/img/chromeos.py  | 149 +++++++++++++++++++++++++++++++++++++++
 test/py/tests/test_ut.py | 140 +-----------------------------------
 2 files changed, 150 insertions(+), 139 deletions(-)
 create mode 100644 test/py/img/chromeos.py

diff --git a/test/py/img/chromeos.py b/test/py/img/chromeos.py
new file mode 100644
index 00000000000..a533fd5ae33
--- /dev/null
+++ b/test/py/img/chromeos.py
@@ -0,0 +1,149 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (c) 2016, NVIDIA CORPORATION. All rights reserved.
+
+"""Create ChromeOS test disk images"""
+
+import collections
+import os
+
+import utils
+
+
+def setup_cros_image(ubman):
+    """Create a 20MB disk image with ChromiumOS partitions"""
+    Partition = collections.namedtuple('part', 'start,size,name')
+    parts = {}
+    disk_data = None
+
+    def pack_kernel(ubman, arch, kern, dummy):
+        """Pack a kernel containing some fake data
+
+        Args:
+            ubman (ConsoleBase): Console to use
+            arch (str): Architecture to use ('x86' or 'arm')
+            kern (str): Filename containing kernel
+            dummy (str): Dummy filename to use for config and bootloader
+
+        Return:
+            bytes: Packed-kernel data
+        """
+        kern_part = os.path.join(ubman.config.result_dir,
+                                 f'kern-part-{arch}.bin')
+        utils.run_and_log(
+            ubman,
+            f'futility vbutil_kernel --pack {kern_part} '
+            '--keyblock doc/chromium/files/devkeys/kernel.keyblock '
+            '--signprivate doc/chromium/files/devkeys/kernel_data_key.vbprivk '
+            f'--version 1  --config {dummy} --bootloader {dummy} '
+            f'--vmlinuz {kern}')
+
+        with open(kern_part, 'rb') as inf:
+            kern_part_data = inf.read()
+        return kern_part_data
+
+    def set_part_data(partnum, data):
+        """Set the contents of a disk partition
+
+        This updates disk_data by putting data in the right place
+
+        Args:
+            partnum (int): Partition number to set
+            data (bytes): Data for that partition
+        """
+        nonlocal disk_data
+
+        start = parts[partnum].start * sect_size
+        disk_data = disk_data[:start] + data + disk_data[start + len(data):]
+
+    mmc_dev = 5
+    fname = os.path.join(ubman.config.source_dir, f'mmc{mmc_dev}.img')
+    utils.run_and_log(ubman, f'qemu-img create {fname} 20M')
+    utils.run_and_log(ubman, f'cgpt create {fname}')
+
+    uuid_state = 'ebd0a0a2-b9e5-4433-87c0-68b6b72699c7'
+    uuid_kern = 'fe3a2a5d-4f32-41a7-b725-accc3285a309'
+    uuid_root = '3cb8e202-3b7e-47dd-8a3c-7ff2a13cfcec'
+    uuid_rwfw = 'cab6e88e-abf3-4102-a07a-d4bb9be3c1d3'
+    uuid_reserved = '2e0a753d-9e48-43b0-8337-b15192cb1b5e'
+    uuid_efi = 'c12a7328-f81f-11d2-ba4b-00a0c93ec93b'
+
+    ptr = 40
+
+    # Number of sectors in 1MB
+    sect_size = 512
+    sect_1mb = (1 << 20) // sect_size
+
+    required_parts = [
+        {'num': 0xb, 'label':'RWFW', 'type': uuid_rwfw, 'size': '1'},
+        {'num': 6, 'label':'KERN_C', 'type': uuid_kern, 'size': '1'},
+        {'num': 7, 'label':'ROOT_C', 'type': uuid_root, 'size': '1'},
+        {'num': 9, 'label':'reserved', 'type': uuid_reserved, 'size': '1'},
+        {'num': 0xa, 'label':'reserved', 'type': uuid_reserved, 'size': '1'},
+
+        {'num': 2, 'label':'KERN_A', 'type': uuid_kern, 'size': '1M'},
+        {'num': 4, 'label':'KERN_B', 'type': uuid_kern, 'size': '1M'},
+
+        {'num': 8, 'label':'OEM', 'type': uuid_state, 'size': '1M'},
+        {'num': 0xc, 'label':'EFI-SYSTEM', 'type': uuid_efi, 'size': '1M'},
+
+        {'num': 5, 'label':'ROOT_B', 'type': uuid_root, 'size': '1'},
+        {'num': 3, 'label':'ROOT_A', 'type': uuid_root, 'size': '1'},
+        {'num': 1, 'label':'STATE', 'type': uuid_state, 'size': '1M'},
+        ]
+
+    for part in required_parts:
+        size_str = part['size']
+        if 'M' in size_str:
+            size = int(size_str[:-1]) * sect_1mb
+        else:
+            size = int(size_str)
+        utils.run_and_log(
+            ubman,
+            f"cgpt add -i {part['num']} -b {ptr} -s {size} -t {part['type']} {fname}")
+        ptr += size
+
+    utils.run_and_log(ubman, f'cgpt boot -p {fname}')
+    out = utils.run_and_log(ubman, f'cgpt show -q {fname}')
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
+
+    # Create a dict (indexed by partition number) containing the above info
+    for line in out.splitlines():
+        start, size, num, name = line.split(maxsplit=3)
+        parts[int(num)] = Partition(int(start), int(size), name)
+
+    # Set up the kernel command-line
+    dummy = os.path.join(ubman.config.result_dir, 'dummy.txt')
+    with open(dummy, 'wb') as outf:
+        outf.write(b'BOOT_IMAGE=/vmlinuz-5.15.0-121-generic root=/dev/nvme0n1p1 ro quiet splash vt.handoff=7')
+
+    # For now we just use dummy kernels. This limits testing to just detecting
+    # a signed kernel. We could add support for the x86 data structures so that
+    # testing could cover getting the cmdline, setup.bin and other pieces.
+    kern = os.path.join(ubman.config.result_dir, 'kern.bin')
+    with open(kern, 'wb') as outf:
+        outf.write(b'kernel\n')
+
+    with open(fname, 'rb') as inf:
+        disk_data = inf.read()
+
+    # put x86 kernel in partition 2 and arm one in partition 4
+    set_part_data(2, pack_kernel(ubman, 'x86', kern, dummy))
+    set_part_data(4, pack_kernel(ubman, 'arm', kern, dummy))
+
+    with open(fname, 'wb') as outf:
+        outf.write(disk_data)
+
+    return fname
diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index 6623d514dad..5630c3dbe8a 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -22,147 +22,9 @@ from test_android import test_abootimg
 from img.common import mkdir_cond, copy_partition, setup_extlinux_image
 from img.fedora import setup_fedora_image
 from img.armbian import setup_bootmenu_image
+from img.chromeos import setup_cros_image
 
 
-def setup_cros_image(ubman):
-    """Create a 20MB disk image with ChromiumOS partitions"""
-    Partition = collections.namedtuple('part', 'start,size,name')
-    parts = {}
-    disk_data = None
-
-    def pack_kernel(ubman, arch, kern, dummy):
-        """Pack a kernel containing some fake data
-
-        Args:
-            ubman (ConsoleBase): Console to use
-            arch (str): Architecture to use ('x86' or 'arm')
-            kern (str): Filename containing kernel
-            dummy (str): Dummy filename to use for config and bootloader
-
-        Return:
-            bytes: Packed-kernel data
-        """
-        kern_part = os.path.join(ubman.config.result_dir,
-                                 f'kern-part-{arch}.bin')
-        utils.run_and_log(
-            ubman,
-            f'futility vbutil_kernel --pack {kern_part} '
-            '--keyblock doc/chromium/files/devkeys/kernel.keyblock '
-            '--signprivate doc/chromium/files/devkeys/kernel_data_key.vbprivk '
-            f'--version 1  --config {dummy} --bootloader {dummy} '
-            f'--vmlinuz {kern}')
-
-        with open(kern_part, 'rb') as inf:
-            kern_part_data = inf.read()
-        return kern_part_data
-
-    def set_part_data(partnum, data):
-        """Set the contents of a disk partition
-
-        This updates disk_data by putting data in the right place
-
-        Args:
-            partnum (int): Partition number to set
-            data (bytes): Data for that partition
-        """
-        nonlocal disk_data
-
-        start = parts[partnum].start * sect_size
-        disk_data = disk_data[:start] + data + disk_data[start + len(data):]
-
-    mmc_dev = 5
-    fname = os.path.join(ubman.config.source_dir, f'mmc{mmc_dev}.img')
-    utils.run_and_log(ubman, f'qemu-img create {fname} 20M')
-    utils.run_and_log(ubman, f'cgpt create {fname}')
-
-    uuid_state = 'ebd0a0a2-b9e5-4433-87c0-68b6b72699c7'
-    uuid_kern = 'fe3a2a5d-4f32-41a7-b725-accc3285a309'
-    uuid_root = '3cb8e202-3b7e-47dd-8a3c-7ff2a13cfcec'
-    uuid_rwfw = 'cab6e88e-abf3-4102-a07a-d4bb9be3c1d3'
-    uuid_reserved = '2e0a753d-9e48-43b0-8337-b15192cb1b5e'
-    uuid_efi = 'c12a7328-f81f-11d2-ba4b-00a0c93ec93b'
-
-    ptr = 40
-
-    # Number of sectors in 1MB
-    sect_size = 512
-    sect_1mb = (1 << 20) // sect_size
-
-    required_parts = [
-        {'num': 0xb, 'label':'RWFW', 'type': uuid_rwfw, 'size': '1'},
-        {'num': 6, 'label':'KERN_C', 'type': uuid_kern, 'size': '1'},
-        {'num': 7, 'label':'ROOT_C', 'type': uuid_root, 'size': '1'},
-        {'num': 9, 'label':'reserved', 'type': uuid_reserved, 'size': '1'},
-        {'num': 0xa, 'label':'reserved', 'type': uuid_reserved, 'size': '1'},
-
-        {'num': 2, 'label':'KERN_A', 'type': uuid_kern, 'size': '1M'},
-        {'num': 4, 'label':'KERN_B', 'type': uuid_kern, 'size': '1M'},
-
-        {'num': 8, 'label':'OEM', 'type': uuid_state, 'size': '1M'},
-        {'num': 0xc, 'label':'EFI-SYSTEM', 'type': uuid_efi, 'size': '1M'},
-
-        {'num': 5, 'label':'ROOT_B', 'type': uuid_root, 'size': '1'},
-        {'num': 3, 'label':'ROOT_A', 'type': uuid_root, 'size': '1'},
-        {'num': 1, 'label':'STATE', 'type': uuid_state, 'size': '1M'},
-        ]
-
-    for part in required_parts:
-        size_str = part['size']
-        if 'M' in size_str:
-            size = int(size_str[:-1]) * sect_1mb
-        else:
-            size = int(size_str)
-        utils.run_and_log(
-            ubman,
-            f"cgpt add -i {part['num']} -b {ptr} -s {size} -t {part['type']} {fname}")
-        ptr += size
-
-    utils.run_and_log(ubman, f'cgpt boot -p {fname}')
-    out = utils.run_and_log(ubman, f'cgpt show -q {fname}')
-
-    # We expect something like this:
-    #   8239        2048       1  Basic data
-    #     45        2048       2  ChromeOS kernel
-    #   8238           1       3  ChromeOS rootfs
-    #   2093        2048       4  ChromeOS kernel
-    #   8237           1       5  ChromeOS rootfs
-    #     41           1       6  ChromeOS kernel
-    #     42           1       7  ChromeOS rootfs
-    #   4141        2048       8  Basic data
-    #     43           1       9  ChromeOS reserved
-    #     44           1      10  ChromeOS reserved
-    #     40           1      11  ChromeOS firmware
-    #   6189        2048      12  EFI System Partition
-
-    # Create a dict (indexed by partition number) containing the above info
-    for line in out.splitlines():
-        start, size, num, name = line.split(maxsplit=3)
-        parts[int(num)] = Partition(int(start), int(size), name)
-
-    # Set up the kernel command-line
-    dummy = os.path.join(ubman.config.result_dir, 'dummy.txt')
-    with open(dummy, 'wb') as outf:
-        outf.write(b'BOOT_IMAGE=/vmlinuz-5.15.0-121-generic root=/dev/nvme0n1p1 ro quiet splash vt.handoff=7')
-
-    # For now we just use dummy kernels. This limits testing to just detecting
-    # a signed kernel. We could add support for the x86 data structures so that
-    # testing could cover getting the cmdline, setup.bin and other pieces.
-    kern = os.path.join(ubman.config.result_dir, 'kern.bin')
-    with open(kern, 'wb') as outf:
-        outf.write(b'kernel\n')
-
-    with open(fname, 'rb') as inf:
-        disk_data = inf.read()
-
-    # put x86 kernel in partition 2 and arm one in partition 4
-    set_part_data(2, pack_kernel(ubman, 'x86', kern, dummy))
-    set_part_data(4, pack_kernel(ubman, 'arm', kern, dummy))
-
-    with open(fname, 'wb') as outf:
-        outf.write(disk_data)
-
-    return fname
-
 def setup_android_image(ubman):
     """Create a 20MB disk image with Android partitions"""
     Partition = collections.namedtuple('part', 'start,size,name')
-- 
2.43.0

