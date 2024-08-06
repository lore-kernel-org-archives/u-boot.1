Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11F81C3DA64
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 13:06:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B4F188A8F;
	Tue,  6 Aug 2024 14:59:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ay0zoGvN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67AC688B22; Tue,  6 Aug 2024 14:59:56 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0565588A63
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 14:59:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-396e2d21812so2519675ab.2
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 05:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722949192; x=1723553992; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z8eq2a/yMA0WiQtlN7pApVkbRROrcKprszM11T3YVUE=;
 b=ay0zoGvNo8Lt/jPQ8abuywTYXyuV0cYQMeZ+HRuBbYjdKK57P4zGUkDJPYUrsa6t8G
 74CEY6kRz8h2LExbplIkGi1+wXed18JIFuGOM9aASeLh0Oz7iMLEuFnmFizX1cuMTtoN
 AXMVeKvA09TpdyQicHVa/toseBdNSCHaCHxkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722949192; x=1723553992;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z8eq2a/yMA0WiQtlN7pApVkbRROrcKprszM11T3YVUE=;
 b=kmH0GgclvugquJnAooOvZi3dc2EeNqYIgsT6kEDXCC0tbV7BczEHf5cNyAsJi/79l7
 YnJwdIwltevZ0SDNV+meEbv1E81JC8xR5nDIRU5zqUS+/pYcC1CAjTP7/TtxUGwseDkh
 g0voa/auOr7CAVqiu7vt/5Dn79oJja9LqEPrBqLhWjjq0+sd3KaK63oXgHS3REJQ+lxn
 AbafDm/cdY7uVeLfCJ5o1uK17x6tPhilXrhLpSUZsEVV3lw8Ni6WHe4n/vfxe0wocpmB
 o0YKcBCWSMdT6MPc+0do3TkCGjX1FcRM6uL9nBsj9rTAHDOO9lVXdKcf5gWMkNeraoUZ
 Ecug==
X-Gm-Message-State: AOJu0YwMT07gFQ4VngA+L8Su7tzfaZutYsVDD5k+utlHnJhL13KYFpn0
 TqlRf2Ep01NfnpYYayu3fKDwIHk7sIqg1NUXMmESs3+E7r0DIXZsfJofCIK+OgBG9tltDHOuxJM
 =
X-Google-Smtp-Source: AGHT+IGtud4zJIvfIAa5k1Q2ekkykWkAGhUZqdwazwsm1iGvjpj4CR7GaqD8uxWZ3wNiFjycgNCXog==
X-Received: by 2002:a92:ad0f:0:b0:396:f026:b0b3 with SMTP id
 e9e14a558f8ab-39b1fbc0aa9mr140180025ab.15.1722949192121; 
 Tue, 06 Aug 2024 05:59:52 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39b20ab5ccdsm36871565ab.40.2024.08.06.05.59.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 05:59:51 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Eddie James <eajames@linux.ibm.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Jonas Karlman <jonas@kwiboo.se>, Julien Masson <jmasson@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>, Sean Anderson <seanga2@gmail.com>,
 Yang Xiwen <forbidden405@outlook.com>
Subject: [PATCH v2 38/39] test: Set up an image suitable for EFI testing
Date: Tue,  6 Aug 2024 06:58:49 -0600
Message-Id: <20240806125850.2316956-39-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240806125850.2316956-1-sjg@chromium.org>
References: <20240806125850.2316956-1-sjg@chromium.org>
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

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/sandbox/dts/test.dts           |   2 +-
 test/boot/bootdev.c                 |  18 +++++++++-
 test/boot/bootflow.c                |   2 +-
 test/py/tests/bootstd/flash1.img.xz | Bin 0 -> 5016 bytes
 test/py/tests/test_ut.py            |  52 ++++++++++++++++++++++++----
 5 files changed, 65 insertions(+), 9 deletions(-)
 create mode 100644 test/py/tests/bootstd/flash1.img.xz

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index 5fb5eac862e..a99de6e62ce 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -1507,7 +1507,7 @@
 				flash-stick@1 {
 					reg = <1>;
 					compatible = "sandbox,usb-flash";
-					sandbox,filepath = "testflash1.bin";
+					sandbox,filepath = "flash1.img";
 				};
 
 				flash-stick@2 {
diff --git a/test/boot/bootdev.c b/test/boot/bootdev.c
index de16a51956d..254fcd26a5c 100644
--- a/test/boot/bootdev.c
+++ b/test/boot/bootdev.c
@@ -216,6 +216,10 @@ static int bootdev_test_order(struct unit_test_state *uts)
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
@@ -255,7 +259,11 @@ static int bootdev_test_order(struct unit_test_state *uts)
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
@@ -318,6 +326,10 @@ static int bootdev_test_prio(struct unit_test_state *uts)
 	/* 3 MMC and 3 USB bootdevs: MMC should come before USB */
 	console_record_reset_enable();
 	ut_assertok(bootflow_scan_first(NULL, NULL, &iter, 0, &bflow));
+
+	/* get the usb device which has a backing file (flash1.img) */
+	ut_asserteq(0, bootflow_scan_next(&iter, &bflow));
+
 	ut_asserteq(-ENODEV, bootflow_scan_next(&iter, &bflow));
 	ut_asserteq(6, iter.num_devs);
 	ut_asserteq_str("mmc2.bootdev", iter.dev_used[0]->name);
@@ -335,6 +347,10 @@ static int bootdev_test_prio(struct unit_test_state *uts)
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
index 8ea091a36af..6d85cf20dd5 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -537,7 +537,7 @@ static int prep_mmc_bootdev(struct unit_test_state *uts, const char *mmc_dev,
 
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

