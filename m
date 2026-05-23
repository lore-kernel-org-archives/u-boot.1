Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BC74CD5BB1
	for <u-boot@archiver.kernel.org>; Sat, 23 May 2026 08:55:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFE6B846E2;
	Sat, 23 May 2026 10:55:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KVZUnl5m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DC5A847B0; Sat, 23 May 2026 10:55:22 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F37068469F
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 10:55:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7e61b59e03eso290032a34.2
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 01:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779526519; x=1780131319; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yo5hzzBPtuDKlAjuUmxnIIPdxuYRdmSLxZNtHzgHrl0=;
 b=KVZUnl5mmUq06vhcO99nvqrlcAUufPvVReK4/fh9vmmdxAe/V8JqrV7EigD/Z0bd57
 /lLWT3GrwcGVZU7ERhELhzVXHg9zf33XW7Qr6ILmDD1Md2Vti4onD12EdagfvX2ONGOl
 5elQDfdjqhAYt/kgrconCnBIa5YMA4/UMuceM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779526519; x=1780131319;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Yo5hzzBPtuDKlAjuUmxnIIPdxuYRdmSLxZNtHzgHrl0=;
 b=abDOQfHSMhj4XlpTHq2MOH2HLfpJw/HXeEJkAYS82YYr17EOJcpr2OOhHWbMrjtwHW
 xEnS/Z9BdUlu+YFz6pad2SA09UKPPcdoKqhkTDRQNte38EsXA4ZBBr6q5Rt63XSiwsBX
 k75pbNVaRZ2spp3gD0t6IHdrFCYqElt4kQA6aQ8FnLlFkG6J+x3YW4jN7wN0LIbPQzX/
 OBUGIGb72Mk+SaTMA7DSMLeyrzdyzwkWOjI5JGYdb3CHmNTQiqET5GPQ2GzH1jSVt5GS
 yAr79N9RTuZUvQwFfexEqDQI3LAxsEx7jRSKzLrV5x2qOAXQMowXFcrqLciSkP9mTSyr
 E4zQ==
X-Gm-Message-State: AOJu0Yy0/OEhHlCwqvf+exBm2Zy1ryTHbc8aKJovk9kyAf7p9lM1WsK3
 eJ2zt7socCe/citrwrH9eNHdGjGazH20pckch7kwqtECj+XDaRqueTAn8so14NGGY7Cfu0Qovwc
 1X2LeF8KG
X-Gm-Gg: Acq92OEFAFNQAs4LG9IraPeU+pM/OoL055ZOnCP+JsjlhWCaVyHoDu1ejBecpnt0Ywx
 RtzPePuvDmpRhBhmNJbigJSllLwAVVSAJQbL2MVrIFOcl7UgkKfVbTFUoyTyLcXO/XLI8nqtVKL
 8f7sD7T0Xy1Xaqd27FNu2JR6fFsI543ucRAYJ+F95Caq5sDtcbCMwQu38ZuSxvn23ohB27COscW
 3W4jMkGQwh6Lf6sOsgOIglJnWzTNoUFt/uWdhzEOW8ruxtc3ek+ZKfGzq49K4RrAl3rsQD633KW
 4MhnmXu6IR3I0aiNehMP9T39DmiSVbBFnkwnsNGtzx8oRoWwEAloY86iywXwOtMRCfHtjdmptt5
 /+4yrWnZuFDplhzYCxhakAoAWfAhkBhdMElpdKZro/FFWXZ33ekT4u3fOkgp5R1XSQWCtBwpir6
 GUlUUL3r4EPeYy3rdFIA==
X-Received: by 2002:a05:6830:d8b:b0:7dc:d28a:3d2a with SMTP id
 46e09a7af769-7e5fee2058bmr4336073a34.15.1779526518586; 
 Sat, 23 May 2026 01:55:18 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e60666ae5fsm2893602a34.24.2026.05.23.01.55.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2026 01:55:11 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 04/11] test: Move ChromeOS image-creation to its own file
Date: Sat, 23 May 2026 02:54:40 -0600
Message-ID: <20260523085455.750591-5-sjg@chromium.org>
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

Move setup_cros_image() to its own module. This function creates disk
images with a ChromiumOS partition layout.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

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
index a23fb6244d6..87e02079608 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -22,147 +22,9 @@ from test_android import test_abootimg
 from img.common import mkdir_cond, copy_partition
 from img.extlinux import setup_extlinux_image
 from img.script import setup_script_image
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

