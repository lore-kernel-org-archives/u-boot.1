Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC5D7CD4F54
	for <u-boot@archiver.kernel.org>; Sat, 23 May 2026 08:55:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDCB384815;
	Sat, 23 May 2026 10:55:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nndmEW1U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D707C8469F; Sat, 23 May 2026 10:55:25 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AECE84815
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 10:55:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7e612d0693eso883510a34.3
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 01:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779526522; x=1780131322; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qtH1qEyquFUDAkFDGKkqq7Z+153sujwLw2+45N4NHgQ=;
 b=nndmEW1U44dODXDkgQD/K7kMn49gsMosNG2GFRkyxYaz85rGTgp+TsVP9M/xDMeV77
 0ytuIIxosYW0SWaGy1lkhNyaB93mFqtTpeNVE+SfjVaeXu4QCHEJpGds+Ilvvmjk5lq7
 +WIfr3CH7V6I0G5TciPIkklOctLv9vRtAPBww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779526522; x=1780131322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qtH1qEyquFUDAkFDGKkqq7Z+153sujwLw2+45N4NHgQ=;
 b=C5MqNYcoNK07bEqNF1+/jz24cg2rJT6/1QAnieRmnyfxNlukWQaqqTmQXPRARqR9ZB
 rjM0YUS4Lm+lGqN14aWqnuukoAYOTKsNSXoo7ziIk19c450GsAVCnr+JIuT+1EDENY5N
 Hei21cWzE2cycNrSCxQe6lBGH3YYB2SsYyp8Y6rUio9j2an7gb69FBfIAGrWSobK9g+4
 wUHJ/wXiXAR6QYyK6Rm6KnWNfUzouvBjYBCF0xge+cp2pj/MRMN7/L/oLY2Yr9ArF+kq
 pE7+HUrDeB3/PrWfDIc8QJ5MXVjwv7hZaxPbvLIFsQqDSunVH6KizzH72zTga/X56x8F
 0oMA==
X-Gm-Message-State: AOJu0Yyrzp3uT/WmsOzgpuaaVCk5pkEMh8CF95y2lRKaZx2PoK5mWd5E
 +EVL/xV4JSBy4v9aJL5glR+Eg5P0VhqvjcKhJxtkXtAX4isrjXHh2YCpgx6peeRkaa5ct0uyNJk
 mU+nPoH7C
X-Gm-Gg: Acq92OEBAPhLpvTbOgA0wZACzJN67rvR0vZORPWatcNUCpk9cxGKzJ/zjg1xPWYoS5Z
 TODgwLvzcyFDFpr85B830jN+VHZAQQ5za5v9q2gFQfjUrr29Ly5hmrs9zDz/McvHw/h+2wmOQ7M
 1kzuAigFdTzD8GfczvNASgiU8NpxuxpklqwyYQuJ0QJolxM+d/9pgTEdtPCehIdfRSoCVIls0XX
 3YRSRojJ8eca0RNuYUtYLptKZoTokhJ6/k6rB8dfGijcTt6dEeuptyvTHFP41xpB6BMdBuxvV7k
 9QU6mPM0do4/2VEii4mHOKxQg9TQLrkt6icAjdT0rn+IklaSHU68XFyqI/vdAPwWn6uBNNWulNO
 TLB2pd5vSiKKjhJM3oT5wVHJle8h8yP8T/YpnEg8cN0EjEhW5l6wjXQMyvCFul7DCnCCdqYv/jj
 pRox3sBZC74NA8lhFNng==
X-Received: by 2002:a05:6830:82fc:b0:7dc:c4ae:a679 with SMTP id
 46e09a7af769-7e5fed3a2c8mr4274291a34.9.1779526522212; 
 Sat, 23 May 2026 01:55:22 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e60666ae5fsm2893602a34.24.2026.05.23.01.55.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2026 01:55:19 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 05/11] test: Move Android image-creation to its own file
Date: Sat, 23 May 2026 02:54:41 -0600
Message-ID: <20260523085455.750591-6-sjg@chromium.org>
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

Move setup_android_image() function to its own module.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/py/img/android.py   | 138 +++++++++++++++++++++++++++++++++++++++
 test/py/tests/test_ut.py | 128 +-----------------------------------
 2 files changed, 139 insertions(+), 127 deletions(-)
 create mode 100644 test/py/img/android.py

diff --git a/test/py/img/android.py b/test/py/img/android.py
new file mode 100644
index 00000000000..2ea964f5520
--- /dev/null
+++ b/test/py/img/android.py
@@ -0,0 +1,138 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (c) 2016, NVIDIA CORPORATION. All rights reserved.
+
+"""Create Android test disk images"""
+
+import collections
+import os
+
+import utils
+from test_android import test_abootimg
+
+
+def setup_android_image(ubman):
+    """Create a 20MB disk image with Android partitions"""
+    Partition = collections.namedtuple('part', 'start,size,name')
+    parts = {}
+    disk_data = None
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
+    mmc_dev = 7
+    fname = os.path.join(ubman.config.source_dir, f'mmc{mmc_dev}.img')
+    utils.run_and_log(ubman, f'qemu-img create {fname} 20M')
+    utils.run_and_log(ubman, f'cgpt create {fname}')
+
+    ptr = 40
+
+    # Number of sectors in 1MB
+    sect_size = 512
+    sect_1mb = (1 << 20) // sect_size
+
+    required_parts = [
+        {'num': 1, 'label':'misc', 'size': '1M'},
+        {'num': 2, 'label':'boot_a', 'size': '4M'},
+        {'num': 3, 'label':'boot_b', 'size': '4M'},
+        {'num': 4, 'label':'vendor_boot_a', 'size': '4M'},
+        {'num': 5, 'label':'vendor_boot_b', 'size': '4M'},
+    ]
+
+    for part in required_parts:
+        size_str = part['size']
+        if 'M' in size_str:
+            size = int(size_str[:-1]) * sect_1mb
+        else:
+            size = int(size_str)
+        utils.run_and_log(
+            ubman,
+            f"cgpt add -i {part['num']} -b {ptr} -s {size} -l {part['label']} -t basicdata {fname}")
+        ptr += size
+
+    utils.run_and_log(ubman, f'cgpt boot -p {fname}')
+    out = utils.run_and_log(ubman, f'cgpt show -q {fname}')
+
+    # Create a dict (indexed by partition number) containing the above info
+    for line in out.splitlines():
+        start, size, num, name = line.split(maxsplit=3)
+        parts[int(num)] = Partition(int(start), int(size), name)
+
+    with open(fname, 'rb') as inf:
+        disk_data = inf.read()
+
+    test_abootimg.AbootimgTestDiskImage(ubman, 'bootv4.img', test_abootimg.boot_img_hex)
+    boot_img = os.path.join(ubman.config.result_dir, 'bootv4.img')
+    with open(boot_img, 'rb') as inf:
+        set_part_data(2, inf.read())
+
+    test_abootimg.AbootimgTestDiskImage(ubman, 'vendor_boot.img', test_abootimg.vboot_img_hex)
+    vendor_boot_img = os.path.join(ubman.config.result_dir, 'vendor_boot.img')
+    with open(vendor_boot_img, 'rb') as inf:
+        set_part_data(4, inf.read())
+
+    with open(fname, 'wb') as outf:
+        outf.write(disk_data)
+
+    print(f'wrote to {fname}')
+
+    mmc_dev = 8
+    fname = os.path.join(ubman.config.source_dir, f'mmc{mmc_dev}.img')
+    utils.run_and_log(ubman, f'qemu-img create {fname} 20M')
+    utils.run_and_log(ubman, f'cgpt create {fname}')
+
+    ptr = 40
+
+    # Number of sectors in 1MB
+    sect_size = 512
+    sect_1mb = (1 << 20) // sect_size
+
+    required_parts = [
+        {'num': 1, 'label':'misc', 'size': '1M'},
+        {'num': 2, 'label':'boot_a', 'size': '4M'},
+        {'num': 3, 'label':'boot_b', 'size': '4M'},
+    ]
+
+    for part in required_parts:
+        size_str = part['size']
+        if 'M' in size_str:
+            size = int(size_str[:-1]) * sect_1mb
+        else:
+            size = int(size_str)
+        utils.run_and_log(
+            ubman,
+            f"cgpt add -i {part['num']} -b {ptr} -s {size} -l {part['label']} -t basicdata {fname}")
+        ptr += size
+
+    utils.run_and_log(ubman, f'cgpt boot -p {fname}')
+    out = utils.run_and_log(ubman, f'cgpt show -q {fname}')
+
+    # Create a dict (indexed by partition number) containing the above info
+    for line in out.splitlines():
+        start, size, num, name = line.split(maxsplit=3)
+        parts[int(num)] = Partition(int(start), int(size), name)
+
+    with open(fname, 'rb') as inf:
+        disk_data = inf.read()
+
+    test_abootimg.AbootimgTestDiskImage(ubman, 'boot.img', test_abootimg.img_hex)
+    boot_img = os.path.join(ubman.config.result_dir, 'boot.img')
+    with open(boot_img, 'rb') as inf:
+        set_part_data(2, inf.read())
+
+    with open(fname, 'wb') as outf:
+        outf.write(disk_data)
+
+    print(f'wrote to {fname}')
+
+    return fname
diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index 87e02079608..81269a5e92f 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -23,135 +23,9 @@ from img.common import mkdir_cond, copy_partition
 from img.extlinux import setup_extlinux_image
 from img.script import setup_script_image
 from img.chromeos import setup_cros_image
+from img.android import setup_android_image
 
 
-def setup_android_image(ubman):
-    """Create a 20MB disk image with Android partitions"""
-    Partition = collections.namedtuple('part', 'start,size,name')
-    parts = {}
-    disk_data = None
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
-    mmc_dev = 7
-    fname = os.path.join(ubman.config.source_dir, f'mmc{mmc_dev}.img')
-    utils.run_and_log(ubman, f'qemu-img create {fname} 20M')
-    utils.run_and_log(ubman, f'cgpt create {fname}')
-
-    ptr = 40
-
-    # Number of sectors in 1MB
-    sect_size = 512
-    sect_1mb = (1 << 20) // sect_size
-
-    required_parts = [
-        {'num': 1, 'label':'misc', 'size': '1M'},
-        {'num': 2, 'label':'boot_a', 'size': '4M'},
-        {'num': 3, 'label':'boot_b', 'size': '4M'},
-        {'num': 4, 'label':'vendor_boot_a', 'size': '4M'},
-        {'num': 5, 'label':'vendor_boot_b', 'size': '4M'},
-    ]
-
-    for part in required_parts:
-        size_str = part['size']
-        if 'M' in size_str:
-            size = int(size_str[:-1]) * sect_1mb
-        else:
-            size = int(size_str)
-        utils.run_and_log(
-            ubman,
-            f"cgpt add -i {part['num']} -b {ptr} -s {size} -l {part['label']} -t basicdata {fname}")
-        ptr += size
-
-    utils.run_and_log(ubman, f'cgpt boot -p {fname}')
-    out = utils.run_and_log(ubman, f'cgpt show -q {fname}')
-
-    # Create a dict (indexed by partition number) containing the above info
-    for line in out.splitlines():
-        start, size, num, name = line.split(maxsplit=3)
-        parts[int(num)] = Partition(int(start), int(size), name)
-
-    with open(fname, 'rb') as inf:
-        disk_data = inf.read()
-
-    test_abootimg.AbootimgTestDiskImage(ubman, 'bootv4.img', test_abootimg.boot_img_hex)
-    boot_img = os.path.join(ubman.config.result_dir, 'bootv4.img')
-    with open(boot_img, 'rb') as inf:
-        set_part_data(2, inf.read())
-
-    test_abootimg.AbootimgTestDiskImage(ubman, 'vendor_boot.img', test_abootimg.vboot_img_hex)
-    vendor_boot_img = os.path.join(ubman.config.result_dir, 'vendor_boot.img')
-    with open(vendor_boot_img, 'rb') as inf:
-        set_part_data(4, inf.read())
-
-    with open(fname, 'wb') as outf:
-        outf.write(disk_data)
-
-    print(f'wrote to {fname}')
-
-    mmc_dev = 8
-    fname = os.path.join(ubman.config.source_dir, f'mmc{mmc_dev}.img')
-    utils.run_and_log(ubman, f'qemu-img create {fname} 20M')
-    utils.run_and_log(ubman, f'cgpt create {fname}')
-
-    ptr = 40
-
-    # Number of sectors in 1MB
-    sect_size = 512
-    sect_1mb = (1 << 20) // sect_size
-
-    required_parts = [
-        {'num': 1, 'label':'misc', 'size': '1M'},
-        {'num': 2, 'label':'boot_a', 'size': '4M'},
-        {'num': 3, 'label':'boot_b', 'size': '4M'},
-    ]
-
-    for part in required_parts:
-        size_str = part['size']
-        if 'M' in size_str:
-            size = int(size_str[:-1]) * sect_1mb
-        else:
-            size = int(size_str)
-        utils.run_and_log(
-            ubman,
-            f"cgpt add -i {part['num']} -b {ptr} -s {size} -l {part['label']} -t basicdata {fname}")
-        ptr += size
-
-    utils.run_and_log(ubman, f'cgpt boot -p {fname}')
-    out = utils.run_and_log(ubman, f'cgpt show -q {fname}')
-
-    # Create a dict (indexed by partition number) containing the above info
-    for line in out.splitlines():
-        start, size, num, name = line.split(maxsplit=3)
-        parts[int(num)] = Partition(int(start), int(size), name)
-
-    with open(fname, 'rb') as inf:
-        disk_data = inf.read()
-
-    test_abootimg.AbootimgTestDiskImage(ubman, 'boot.img', test_abootimg.img_hex)
-    boot_img = os.path.join(ubman.config.result_dir, 'boot.img')
-    with open(boot_img, 'rb') as inf:
-        set_part_data(2, inf.read())
-
-    with open(fname, 'wb') as outf:
-        outf.write(disk_data)
-
-    print(f'wrote to {fname}')
-
-    return fname
-
 def setup_cedit_file(ubman):
     """Set up a .dtb file for use with testing expo and configuration editor"""
     infname = os.path.join(ubman.config.source_dir,
-- 
2.43.0

