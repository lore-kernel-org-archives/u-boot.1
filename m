Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A50FEC6FA8F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 19:59:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B57686A35;
	Thu, 24 Aug 2023 21:56:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eP81GqCX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62843869C7; Thu, 24 Aug 2023 21:56:19 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82F0D869ED
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 21:56:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-792707f78b5so8194339f.1
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 12:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692906974; x=1693511774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XPAEyM+3oWAt2orfchmYOKL7DAbJRnv7mLeyvemrHSw=;
 b=eP81GqCX3mlmS9iWqGQqHOwxYtZMj+v/6UZrQlrgkqnJzv6W2YAdKkOs/UUgoNBD8M
 Ib+/IACuyIFg2iYZfB0SWUpboWaPGqEVtfgpYDpeOTUAg0LwL5sbvUC7E3IU5oqmxdHc
 XANa6YXho7q0+MniuNR7/IMhskvU1xRmlCUWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692906974; x=1693511774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XPAEyM+3oWAt2orfchmYOKL7DAbJRnv7mLeyvemrHSw=;
 b=FG8PUAZQ6gzOrvyUbJjXE+/qA08Tv5jaJyvGNp1Y186mx+PM9rj2tDGjrUlTz8sCa3
 iuTBcrgInN1MMTK16mM/rGL4MlGOVXFJGv9M0z0waBfZV/30isjuQObXxpfwQ0Cb46eR
 8h8KLVbYGWAq8qObb0kU4NfrDW8pq2KCGwJgynu5pSqteKqH7KfJ7VGpKexzTyBtEjlD
 6tIbqF8aFwGFZmOrT9fyGCTnIDphbfwPw1toMSbpL5+MVjohGGyMpFdnyvXb3Sh7FIyi
 MS8Vo6lHoMdOqSqRtaM4baA04JGClWoceyXfLxG6ESFewyzDcJVMhr4l+dCo5RK9RSlN
 ASrA==
X-Gm-Message-State: AOJu0YznjJCHqoNY1tiHv+eP8veYBDCtQEhB9/Mhe+SaulUTyHFzxaAZ
 EaL4yraddjWD27e88uW2DR3L8ZOGP2SPvmdfgU4=
X-Google-Smtp-Source: AGHT+IHlf5TkUYgOmBLVNnub0B+OAcAmjM/DVUheZwC/46aUaODq4NAoPPdkRcvcxBG7kPRolH4LGw==
X-Received: by 2002:a5e:c810:0:b0:787:169a:927 with SMTP id
 y16-20020a5ec810000000b00787169a0927mr7246082iol.20.1692906974005; 
 Thu, 24 Aug 2023 12:56:14 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 b22-20020a6be716000000b007925328d6ddsm12734ioh.20.2023.08.24.12.56.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 12:56:13 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 18/23] bootstd: Add a test for bootmeth_cros
Date: Thu, 24 Aug 2023 13:55:41 -0600
Message-ID: <20230824195553.1685996-19-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230824195553.1685996-1-sjg@chromium.org>
References: <20230824195553.1685996-1-sjg@chromium.org>
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

The ChromiumOS bootmeth has no tests at present. Before adding more
features. add a basic test.

This creates a disk which can be scanned by the bootmeth, so make sure
things work. It is quite rudimentary, since the kernel is faked, the root
disk is missing and there is no cmdline stored.

Enable the bootmeth for snow so it can build the unit test.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/sandbox/dts/test.dts |   9 +++
 configs/snow_defconfig    |   1 +
 test/boot/bootflow.c      |  33 ++++++++-
 test/py/tests/test_ut.py  | 142 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 183 insertions(+), 2 deletions(-)

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index f351d5cb84b0..49cc94882229 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -39,6 +39,8 @@
 		mmc1 = "/mmc1";
 		mmc2 = "/mmc2";
 		mmc3 = "/mmc3";
+		mmc4 = "/mmc4";
+		mmc5 = "/mmc5";
 		pci0 = &pci0;
 		pci1 = &pci1;
 		pci2 = &pci2;
@@ -1055,6 +1057,13 @@
 		filename = "mmc4.img";
 	};
 
+	/* This is used for ChromiumOS tests */
+	mmc5 {
+		status = "disabled";
+		compatible = "sandbox,mmc";
+		filename = "mmc5.img";
+	};
+
 	pch {
 		compatible = "sandbox,pch";
 	};
diff --git a/configs/snow_defconfig b/configs/snow_defconfig
index bb066a645991..22ec8e5141f6 100644
--- a/configs/snow_defconfig
+++ b/configs/snow_defconfig
@@ -29,6 +29,7 @@ CONFIG_DEBUG_UART=y
 CONFIG_FIT=y
 CONFIG_FIT_BEST_MATCH=y
 CONFIG_BOOTSTD_FULL=y
+CONFIG_BOOTMETH_CROS=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_SILENT_CONSOLE=y
 CONFIG_BLOBLIST=y
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 54a878c4bd5d..ae34370981cb 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -27,6 +27,7 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
+extern U_BOOT_DRIVER(bootmeth_cros);
 extern U_BOOT_DRIVER(bootmeth_script);
 
 static int inject_response(struct unit_test_state *uts)
@@ -514,7 +515,8 @@ BOOTSTD_TEST(bootflow_cmd_boot, UT_TESTF_DM | UT_TESTF_SCAN_FDT);
  * @mmc_dev: MMC device to use, e.g. "mmc4"
  * Returns 0 on success, -ve on failure
  */
-static int prep_mmc_bootdev(struct unit_test_state *uts, const char *mmc_dev)
+static int prep_mmc_bootdev(struct unit_test_state *uts, const char *mmc_dev,
+			    bool bind_cros)
 {
 	const char *order[] = {"mmc2", "mmc1", mmc_dev, NULL};
 	struct udevice *dev, *bootstd;
@@ -533,6 +535,13 @@ static int prep_mmc_bootdev(struct unit_test_state *uts, const char *mmc_dev)
 	ut_assertok(device_bind(bootstd, DM_DRIVER_REF(bootmeth_script),
 				"bootmeth_script", 0, ofnode_null(), &dev));
 
+	/* Enable the cros bootmeth if needed */
+	if (bind_cros) {
+		ut_assertok(uclass_first_device_err(UCLASS_BOOTSTD, &bootstd));
+		ut_assertok(device_bind(bootstd, DM_DRIVER_REF(bootmeth_cros),
+					"cros", 0, ofnode_null(), &dev));
+	}
+
 	/* Change the order to include the device */
 	std = dev_get_priv(bootstd);
 	old_order = std->bootdev_order;
@@ -556,7 +565,7 @@ static int prep_mmc_bootdev(struct unit_test_state *uts, const char *mmc_dev)
  */
 static int prep_mmc4_bootdev(struct unit_test_state *uts)
 {
-	ut_assertok(prep_mmc_bootdev(uts, "mmc4"));
+	ut_assertok(prep_mmc_bootdev(uts, "mmc4", false));
 
 	return 0;
 }
@@ -963,3 +972,23 @@ static int bootflow_cmdline(struct unit_test_state *uts)
 	return 0;
 }
 BOOTSTD_TEST(bootflow_cmdline, 0);
+
+/* Test ChromiumOS bootmeth */
+static int bootflow_cros(struct unit_test_state *uts)
+{
+	ut_assertok(prep_mmc_bootdev(uts, "mmc5", true));
+	ut_assertok(run_command("bootflow list", 0));
+
+	ut_assert_nextlinen("Showing all");
+	ut_assert_nextlinen("Seq");
+	ut_assert_nextlinen("---");
+	ut_assert_nextlinen("  0  extlinux");
+	ut_assert_nextlinen("  1  cros         ready   mmc          2  mmc5.bootdev.whole       ");
+	ut_assert_nextlinen("---");
+	ut_assert_skip_to_line("(2 bootflows, 2 valid)");
+
+	ut_assert_console_end();
+
+	return 0;
+}
+BOOTSTD_TEST(bootflow_cros, 0);
diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index 3cc41c2ffb13..856eaf1b7f22 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # Copyright (c) 2016, NVIDIA CORPORATION. All rights reserved.
 
+import collections
 import getpass
 import gzip
 import os
@@ -282,6 +283,146 @@ label Fedora-Workstation-armhfp-31-1.9 (5.3.7-301.fc31.armv7hl)
         copy_prepared_image(cons, mmc_dev, fname)
 
 
+def setup_cros_image(cons):
+    """Create a 20MB disk image with ChromiumOS partitions"""
+    Partition = collections.namedtuple('part', 'start,size,name')
+    parts = {}
+    disk_data = None
+
+    def pack_kernel(cons, arch, kern, dummy):
+        """Pack a kernel containing some fake data
+
+        Args:
+            cons (ConsoleBase): Console to use
+            arch (str): Architecture to use ('x86' or 'arm')
+            kern (str): Filename containing kernel
+            dummy (str): Dummy filename to use for config and bootloader
+
+        Return:
+            bytes: Packed-kernel data
+        """
+        kern_part = os.path.join(cons.config.result_dir, 'kern-part-{arch}.bin')
+        u_boot_utils.run_and_log(
+            cons,
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
+    fname = os.path.join(cons.config.source_dir, f'mmc{mmc_dev}.img')
+    u_boot_utils.run_and_log(cons, 'qemu-img create %s 20M' % fname)
+    #mnt = os.path.join(cons.config.persistent_data_dir, 'mnt')
+    #mkdir_cond(mnt)
+    u_boot_utils.run_and_log(cons, f'cgpt create {fname}')
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
+        u_boot_utils.run_and_log(
+            cons,
+            f"cgpt add -i {part['num']} -b {ptr} -s {size} -t {part['type']} {fname}")
+        ptr += size
+
+    u_boot_utils.run_and_log(cons, f'cgpt boot -p {fname}')
+    out = u_boot_utils.run_and_log(cons, f'cgpt show -q {fname}')
+    '''We expect something like this:
+        8239        2048       1  Basic data
+          45        2048       2  ChromeOS kernel
+        8238           1       3  ChromeOS rootfs
+        2093        2048       4  ChromeOS kernel
+        8237           1       5  ChromeOS rootfs
+          41           1       6  ChromeOS kernel
+          42           1       7  ChromeOS rootfs
+        4141        2048       8  Basic data
+          43           1       9  ChromeOS reserved
+          44           1      10  ChromeOS reserved
+          40           1      11  ChromeOS firmware
+        6189        2048      12  EFI System Partition
+    '''
+
+    # Create a dict (indexed by partition number) containing the above info
+    for line in out.splitlines():
+        start, size, num, name = line.split(maxsplit=3)
+        parts[int(num)] = Partition(int(start), int(size), name)
+
+    dummy = os.path.join(cons.config.result_dir, 'dummy.txt')
+    with open(dummy, 'wb') as outf:
+        outf.write(b'dummy\n')
+
+    # For now we just use dummy kernels. This limits testing to just detecting
+    # a signed kernel. We could add support for the x86 data structures so that
+    # testing could cover getting the cmdline, setup.bin and other pieces.
+    kern = os.path.join(cons.config.result_dir, 'kern.bin')
+    with open(kern, 'wb') as outf:
+        outf.write(b'kernel\n')
+
+    with open(fname, 'rb') as inf:
+        disk_data = inf.read()
+
+    # put x86 kernel in partition 2 and arm one in partition 4
+    set_part_data(2, pack_kernel(cons, 'x86', kern, dummy))
+    set_part_data(4, pack_kernel(cons, 'arm', kern, dummy))
+
+    with open(fname, 'wb') as outf:
+        outf.write(disk_data)
+
+    return fname
+
+
 def setup_cedit_file(cons):
     infname = os.path.join(cons.config.source_dir,
                            'test/boot/files/expo_layout.dts')
@@ -327,6 +468,7 @@ def test_ut_dm_init_bootstd(u_boot_console):
     setup_bootflow_image(u_boot_console)
     setup_bootmenu_image(u_boot_console)
     setup_cedit_file(u_boot_console)
+    setup_cros_image(u_boot_console)
 
     # Restart so that the new mmc1.img is picked up
     u_boot_console.restart_uboot()
-- 
2.42.0.rc1.204.g551eb34607-goog

