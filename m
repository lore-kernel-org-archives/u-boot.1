Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10DBDD3C91A
	for <u-boot@archiver.kernel.org>; Sat, 19 Oct 2024 15:28:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 084C988F8E;
	Sat, 19 Oct 2024 17:25:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YkEQpYIT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4344289356; Sat, 19 Oct 2024 17:25:13 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C044187D1A
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 17:25:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3a3b63596e0so9167055ab.0
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 08:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729351508; x=1729956308; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UeiGMCAB1DWjVwVLUtobQMr9tqyKMXgmFkk0dNTto5o=;
 b=YkEQpYIT7VJ3KYaKg+4eQnTDkYTCLB1TXLDW2WaNxC0m6fXGnpGejfRtikAcpiEH0e
 IQS3af3KYbDzlXLldWxy9FkPTJyS+iamEbOgywol0aojbjJ1yiY2aNao2IFAqO7vyoOd
 cQIxKuTxcn6tThyAIYH4GTHexhVjRTq8ic9SY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729351508; x=1729956308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UeiGMCAB1DWjVwVLUtobQMr9tqyKMXgmFkk0dNTto5o=;
 b=A51I4zW5QdKj9zpV37oZ/xQSbZqeM57s8S5/qKYs/LtoS9oSykO/VZ6PXBhmDg2NVF
 2PzhZyUZFe/+EH+BaxW2XkUj1NfiUTqsJYHjX16xCOYzu35P2/Q4ZR4hLAMP/B0DcUHA
 fPDlJsWlHWlSxYM9Pdhaf8xtzDYzEs+vvUFUkx/ZCiF/0uF1xeJL3zbc7Is7i8S82CQS
 9DlXn9j6cR0zcgTEhiN+zq5kHngcldj4yjuiZclgX1mB6iAzAcd5GKpfFoIkrhUkTo4N
 HT9MQoZ9F9kK/XgmONRW+RxpJr4mL9/umcU7FxVFQFRyJbOKBu+/DkgBV+LVENZjDe7r
 gTqw==
X-Gm-Message-State: AOJu0Ywdzq1/1J6DE08GaVqZxAoJKyxvVllKcOjKA2cVPSTRhd7znClD
 Vv2xOf1Tse7jPFZ0fYdv7jH/YIo0EdEd225aqVjlFhyV2ixnsfh90GBZKg0SmkcvBHqAuqriisI
 =
X-Google-Smtp-Source: AGHT+IGunPZJ0R5fmtH5h159Im/LICNzu8vIM6h8feUhPvYX/IBSr+KXZ4iojyihAUo238cQRs1vrw==
X-Received: by 2002:a92:cda9:0:b0:3a0:c8b8:1b0f with SMTP id
 e9e14a558f8ab-3a3e529475fmr60040285ab.2.1729351508275; 
 Sat, 19 Oct 2024 08:25:08 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10b5ada8sm1036833173.23.2024.10.19.08.25.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2024 08:25:07 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Eddie James <eajames@linux.ibm.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yang Xiwen <forbidden405@outlook.com>
Subject: [PATCH v7 6/7] test: efi: boot: Set up an image suitable for EFI
 testing
Date: Sat, 19 Oct 2024 09:24:33 -0600
Message-Id: <20241019152434.1017394-7-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241019152434.1017394-1-sjg@chromium.org>
References: <20241019152434.1017394-1-sjg@chromium.org>
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

(no changes since v1)

 arch/sandbox/dts/test.dts           |   2 +-
 test/boot/bootdev.c                 |  18 +++++++++-
 test/boot/bootflow.c                |   2 +-
 test/py/tests/bootstd/flash1.img.xz | Bin 0 -> 5016 bytes
 test/py/tests/test_ut.py            |  52 ++++++++++++++++++++++++----
 5 files changed, 65 insertions(+), 9 deletions(-)
 create mode 100644 test/py/tests/bootstd/flash1.img.xz

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index 9bf44ae3b0b..f40fd5a2b16 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -1512,7 +1512,7 @@
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
index cc894e804a4..0a819998ebd 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -533,7 +533,7 @@ static int prep_mmc_bootdev(struct unit_test_state *uts, const char *mmc_dev,
 
 	order[2] = mmc_dev;
 
-	/* Enable the mmc4 node since we need a second bootflow */
+	/* Enable the requested mmc node since we need a second bootflow */
 	root = oftree_root(oftree_default());
 	node = ofnode_find_subnode(root, mmc_dev);
 	ut_assert(ofnode_valid(node));
diff --git a/test/py/tests/bootstd/flash1.img.xz b/test/py/tests/bootstd/flash1.img.xz
new file mode 100644
index 0000000000000000000000000000000000000000..9148b91a20c1f0acb54449b124d1408961e92507
GIT binary patch
literal 5016
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

literal 0
HcmV?d00001

diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index 39aa1035e34..f647e2f0af2 100644
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
@@ -549,6 +551,43 @@ def test_ut_dm_init(u_boot_console):
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
@@ -559,6 +598,7 @@ def test_ut_dm_init_bootstd(u_boot_console):
     setup_cedit_file(u_boot_console)
     setup_cros_image(u_boot_console)
     setup_android_image(u_boot_console)
+    setup_efi_image(u_boot_console)
 
     # Restart so that the new mmc1.img is picked up
     u_boot_console.restart_uboot()
-- 
2.34.1

