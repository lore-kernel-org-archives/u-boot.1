Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9624AD3A696
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 19:24:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 250E7891D4;
	Tue, 29 Oct 2024 20:22:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Gtzaq/vW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6499891A8; Tue, 29 Oct 2024 20:22:50 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3424891D4
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 20:22:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a9a977d6cc7so413489066b.3
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 12:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730229765; x=1730834565; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MiBONus4oTVlVBr/jerbObQ2Ci+VSu2+aOE9bUGQhoI=;
 b=Gtzaq/vWj4jLITuICWRIxQ5oLUvmo0VDou0PcyFdDTvJip1HQqASEn9N6i3l5seaTa
 csbH1u0H4y+Y5Ln8NAKmOubz53oQNY28LYf4jimuOG+SyMtuxnsm3kN0Ud7vuD+/9+v8
 dcweDjODIcilVdX5L9P4F/3lgWsYKeEC4c6p0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730229765; x=1730834565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MiBONus4oTVlVBr/jerbObQ2Ci+VSu2+aOE9bUGQhoI=;
 b=BD076A93Q9jvspkE8YWb8c0QV8DBBMuLB7Lq0pLdS9YcrEJcpZ05Mp0qazrs2nt9W3
 0ZalWXTXZN7mMMi+l4othG7wVNMjPEPfzkIvNmw7H2nHh8+8Yl4Y3Nh2qSjnv+0hUL7X
 RaVDZtPOH8BJoqkVydTvmaB6YD+8Q7PpHMNVxVPfmxFPWBqxS4qPtBhQ+boKv7BrOmnx
 PbZ+VQnhKDxdutRSHsb51pAdK89cQd3xymXUNS9T5hHpTRpDhk5RvP6ZeAXL0IhhlvgZ
 d7LfWJoxM29Yxc0dP45EMb1byKLrb0cdG8ovKM3fLBkQjyBAEuwsNksRBUSw4s8r/oVS
 aIAg==
X-Gm-Message-State: AOJu0YwVLx78RlAcB0YYrdCkZJ1l/4q5BPNeblOo7OqZgjy74KK5U1du
 XES40D2slS1MzaPSKg/TdOzniVYl1BUGZheJkttheANmsKg2WX5R7vdidovsun07TBdJ4yLGiQ8
 BYO5m
X-Google-Smtp-Source: AGHT+IGMt1OIfEEIUlLRA+XY0F4aiybJRHXLQ5wsb1ReyYqK0/MEsuhmEIbda7mVnIpu8P/+WniwZQ==
X-Received: by 2002:a05:6402:28c5:b0:5cb:bebb:38d8 with SMTP id
 4fb4d7f45d1cf-5cbbf8c2365mr12819562a12.14.1730229764720; 
 Tue, 29 Oct 2024 12:22:44 -0700 (PDT)
Received: from chromium.org ([87.215.50.114]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cbb629f65esm4272770a12.36.2024.10.29.12.22.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 12:22:43 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Yang Xiwen <forbidden405@outlook.com>
Subject: [PATCH v9 10/11] test: efi: boot: Set up an image suitable for EFI
 testing
Date: Tue, 29 Oct 2024 20:22:18 +0100
Message-ID: <20241029192222.362445-11-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241029192222.362445-1-sjg@chromium.org>
References: <20241029192222.362445-1-sjg@chromium.org>
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

Create a new disk for use with tests, which contains the new 'testapp'
EFI app specifically intended for testing the EFI loader.

Attach it to the USB device, since most testing is currently done with
mmc.

Initially this image will be used to test the EFI bootmeth.

Fix a stale comment in prep_mmc_bootdev() while we are here.

For now this uses sudo and a compressed fallback file, like all the
other bootstd tests. Once this series is in, the patch which moves
this to use user-space tools will be cleaned up and re-submitted.

Signed-off-by: Simon Glass <sjg@chromium.org>

---
Here is the patch to avoid sudo and CI fallback:

[1] https://patchwork.ozlabs.org/project/uboot/patch/
20240802093322.15240-1-richard@nod.at/

Changes in v9:
- Mark the image as complete after writing it

 arch/sandbox/dts/test.dts           |   2 +-
 test/boot/bootdev.c                 |  18 +++++++++-
 test/boot/bootflow.c                |   2 +-
 test/py/tests/bootstd/flash1.img.xz | Bin 0 -> 4980 bytes
 test/py/tests/test_ut.py            |  53 ++++++++++++++++++++++++----
 5 files changed, 66 insertions(+), 9 deletions(-)
 create mode 100644 test/py/tests/bootstd/flash1.img.xz

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index 3017b33d67b..dee280184b1 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -1515,7 +1515,7 @@
 				flash-stick@1 {
 					reg = <1>;
 					compatible = "sandbox,usb-flash";
-					sandbox,filepath = "testflash1.bin";
+					sandbox,filepath = "flash1.img";
 				};
 
 				flash-stick@2 {
diff --git a/test/boot/bootdev.c b/test/boot/bootdev.c
index 369105ca4cf..c892854b227 100644
--- a/test/boot/bootdev.c
+++ b/test/boot/bootdev.c
@@ -221,6 +221,10 @@ static int bootdev_test_order(struct unit_test_state *uts)
 	/* Use the environment variable to override it */
 	ut_assertok(env_set("boot_targets", "mmc1 mmc2 usb"));
 	ut_assertok(bootflow_scan_first(NULL, NULL, &iter, 0, &bflow));
+
+	/* get the usb device which has a backing file (flash1.img) */
+	ut_asserteq(0, bootflow_scan_next(&iter, &bflow));
+
 	ut_asserteq(-ENODEV, bootflow_scan_next(&iter, &bflow));
 	ut_asserteq(5, iter.num_devs);
 	ut_asserteq_str("mmc1.bootdev", iter.dev_used[0]->name);
@@ -260,7 +264,11 @@ static int bootdev_test_order(struct unit_test_state *uts)
 	ut_assertok(bootflow_scan_first(NULL, NULL, &iter, 0, &bflow));
 	ut_asserteq(2, iter.num_devs);
 
-	/* Now scan past mmc1 and make sure that the 3 USB devices show up */
+	/*
+	 * Now scan past mmc1 and make sure that the 3 USB devices show up. The
+	 * first one has a backing file so returns success
+	 */
+	ut_asserteq(0, bootflow_scan_next(&iter, &bflow));
 	ut_asserteq(-ENODEV, bootflow_scan_next(&iter, &bflow));
 	ut_asserteq(6, iter.num_devs);
 	ut_asserteq_str("mmc2.bootdev", iter.dev_used[0]->name);
@@ -322,6 +330,10 @@ static int bootdev_test_prio(struct unit_test_state *uts)
 
 	/* 3 MMC and 3 USB bootdevs: MMC should come before USB */
 	ut_assertok(bootflow_scan_first(NULL, NULL, &iter, 0, &bflow));
+
+	/* get the usb device which has a backing file (flash1.img) */
+	ut_asserteq(0, bootflow_scan_next(&iter, &bflow));
+
 	ut_asserteq(-ENODEV, bootflow_scan_next(&iter, &bflow));
 	ut_asserteq(6, iter.num_devs);
 	ut_asserteq_str("mmc2.bootdev", iter.dev_used[0]->name);
@@ -339,6 +351,10 @@ static int bootdev_test_prio(struct unit_test_state *uts)
 	bootflow_iter_uninit(&iter);
 	ut_assertok(bootflow_scan_first(NULL, NULL, &iter, BOOTFLOWIF_HUNT,
 					&bflow));
+
+	/* get the usb device which has a backing file (flash1.img) */
+	ut_asserteq(0, bootflow_scan_next(&iter, &bflow));
+
 	ut_asserteq(-ENODEV, bootflow_scan_next(&iter, &bflow));
 	ut_asserteq(7, iter.num_devs);
 	ut_asserteq_str("usb_mass_storage.lun0.bootdev",
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 7cfb217088e..d7e94c8cc59 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -534,7 +534,7 @@ static int prep_mmc_bootdev(struct unit_test_state *uts, const char *mmc_dev,
 
 	order[2] = mmc_dev;
 
-	/* Enable the mmc4 node since we need a second bootflow */
+	/* Enable the requested mmc node since we need a second bootflow */
 	root = oftree_root(oftree_default());
 	node = ofnode_find_subnode(root, mmc_dev);
 	ut_assert(ofnode_valid(node));
diff --git a/test/py/tests/bootstd/flash1.img.xz b/test/py/tests/bootstd/flash1.img.xz
new file mode 100644
index 0000000000000000000000000000000000000000..0efd9cbe146db6e8f422d9d66f11a772a493ce29
GIT binary patch
literal 4980
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
ByL$it

literal 0
HcmV?d00001

diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index 39aa1035e34..9b54f941014 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -28,21 +28,22 @@ def mkdir_cond(dirname):
     if not os.path.exists(dirname):
         os.mkdir(dirname)
 
-def setup_image(cons, mmc_dev, part_type, second_part=False):
+def setup_image(cons, devnum, part_type, second_part=False, basename='mmc'):
     """Create a 20MB disk image with a single partition
 
     Args:
         cons (ConsoleBase): Console to use
-        mmc_dev (int): MMC device number to use, e.g. 1
+        devnum (int): Device number to use, e.g. 1
         part_type (int): Partition type, e.g. 0xc for FAT32
         second_part (bool): True to contain a small second partition
+        basename (str): Base name to use in the filename, e.g. 'mmc'
 
     Returns:
         tuple:
             str: Filename of MMC image
             str: Directory name of 'mnt' directory
     """
-    fname = os.path.join(cons.config.source_dir, f'mmc{mmc_dev}.img')
+    fname = os.path.join(cons.config.source_dir, f'{basename}{devnum}.img')
     mnt = os.path.join(cons.config.persistent_data_dir, 'mnt')
     mkdir_cond(mnt)
 
@@ -78,16 +79,17 @@ def mount_image(cons, fname, mnt, fstype):
     u_boot_utils.run_and_log(cons, f'sudo chown {getpass.getuser()} {mnt}')
     return loop
 
-def copy_prepared_image(cons, mmc_dev, fname):
+def copy_prepared_image(cons, devnum, fname, basename='mmc'):
     """Use a prepared image since we cannot create one
 
     Args:
         cons (ConsoleBase): Console touse
-        mmc_dev (int): MMC device number
+        devnum (int): device number
         fname (str): Filename of MMC image
+        basename (str): Base name to use in the filename, e.g. 'mmc'
     """
     infname = os.path.join(cons.config.source_dir,
-                           f'test/py/tests/bootstd/mmc{mmc_dev}.img.xz')
+                           f'test/py/tests/bootstd/{basename}{devnum}.img.xz')
     u_boot_utils.run_and_log(cons, ['sh', '-c', f'xz -dc {infname} >{fname}'])
 
 def setup_bootmenu_image(cons):
@@ -549,6 +551,44 @@ def test_ut_dm_init(u_boot_console):
     with open(fn, 'wb') as fh:
         fh.write(data)
 
+
+def setup_efi_image(cons):
+    """Create a 20MB disk image with an EFI app on it"""
+    devnum = 1
+    basename = 'flash'
+    fname, mnt = setup_image(cons, devnum, 0xc, second_part=True,
+                             basename=basename)
+
+    loop = None
+    mounted = False
+    complete = False
+    try:
+        loop = mount_image(cons, fname, mnt, 'ext4')
+        mounted = True
+        efi_dir = os.path.join(mnt, 'EFI')
+        mkdir_cond(efi_dir)
+        bootdir = os.path.join(efi_dir, 'BOOT')
+        mkdir_cond(bootdir)
+        efi_src = os.path.join(cons.config.build_dir,
+                               f'lib/efi_loader/testapp.efi')
+        efi_dst = os.path.join(bootdir, 'BOOTSBOX.EFI')
+        with open(efi_src, 'rb') as inf:
+            with open(efi_dst, 'wb') as outf:
+                outf.write(inf.read())
+        complete = True
+    except ValueError as exc:
+        print(f'Falled to create image, failing back to prepared copy: {exc}')
+
+    finally:
+        if mounted:
+            u_boot_utils.run_and_log(cons, 'sudo umount --lazy %s' % mnt)
+        if loop:
+            u_boot_utils.run_and_log(cons, 'sudo losetup -d %s' % loop)
+
+    if not complete:
+        copy_prepared_image(cons, devnum, fname, basename)
+
+
 @pytest.mark.buildconfigspec('cmd_bootflow')
 @pytest.mark.buildconfigspec('sandbox')
 def test_ut_dm_init_bootstd(u_boot_console):
@@ -559,6 +599,7 @@ def test_ut_dm_init_bootstd(u_boot_console):
     setup_cedit_file(u_boot_console)
     setup_cros_image(u_boot_console)
     setup_android_image(u_boot_console)
+    setup_efi_image(u_boot_console)
 
     # Restart so that the new mmc1.img is picked up
     u_boot_console.restart_uboot()
-- 
2.43.0

