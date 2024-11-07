Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28EC5D5D688
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 21:33:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57535891BC;
	Thu,  7 Nov 2024 22:32:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eMTCDrU3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38FDA891BC; Thu,  7 Nov 2024 22:32:33 +0100 (CET)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71DE68920A
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 22:32:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3a6be9bd626so5726285ab.2
 for <u-boot@lists.denx.de>; Thu, 07 Nov 2024 13:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731015146; x=1731619946; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n6k5OFFhxwHhd2pJWkck0QX0Ou5TnkVywazQ+dv8xH0=;
 b=eMTCDrU38ENa65+cDUQsImONPYK1oRP6oKsLl+F2O6p8M2DG8YmXmlBHrk9vBU81B4
 /6oU8lGo6nF64KqgTx3+Mnot93K9Um2Bn+dpStyyP84G2RXy/WuvPjLZINjy+J2oPU3V
 HtEVVPBpEqqYfVIyL69ZlAVAJDbN1Uu6g/xgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731015146; x=1731619946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n6k5OFFhxwHhd2pJWkck0QX0Ou5TnkVywazQ+dv8xH0=;
 b=cIlGbOqtxPFSY8H/1qbTppWJcx0DHOA0YsWE03LOOajLMo5plPbdmhFcRKlpO6TYlQ
 Vkhs4nIHWvWBEpYiP7x0vByJnBjULn0jrJVfQLJ3M+72X8XcROzdMcNqiwmoiw/2puE0
 NjorUWgEw4LxING4KIxBPv6+SbRW3DsqotTv7T3U78jh8eRKm6H4+BWt8ehUZySfjj2J
 MchecBDtcti7LEk0njb1asvxsvag9pz8CbyZMMWNBu339TJNNu3quD0UxiCTIu+u+uzc
 6vfKs89v7sJlp2pALZPLiYrjB9Cbkk4xkWC5iVJncnqfG7cxRO2cF9OwUdPPRWWJfHhq
 iQUQ==
X-Gm-Message-State: AOJu0YwIxMMhBR8uIWArEjilCknRrGO0AQrWXrMxKmJFC3e3V84/Jvux
 GPVWgNqXy5xA+UyPvcdPpzZ9FNQ6BpNyaiZx4aLRAuHArSZRvQTHsJ9ksmXymBjkm4VGBG6gfEg
 =
X-Google-Smtp-Source: AGHT+IF1/n25KwPLDq8L7XpBr1ZKeps9lJwa5x22BAMZJTS9WOfqw7mUxcTGVEIlTUyMWcNZPenncQ==
X-Received: by 2002:a05:6e02:17c6:b0:3a0:a80a:997c with SMTP id
 e9e14a558f8ab-3a6f1a25691mr8363215ab.19.1731015146451; 
 Thu, 07 Nov 2024 13:32:26 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a6ead30a79sm4831745ab.71.2024.11.07.13.32.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2024 13:32:25 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, Julius Lehmann <lehmanju@devpi.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yang Xiwen <forbidden405@outlook.com>
Subject: [PATCH v10 09/10] test: efi: boot: Set up an image suitable for EFI
 testing
Date: Thu,  7 Nov 2024 14:31:49 -0700
Message-Id: <20241107213150.1711962-10-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241107213150.1711962-1-sjg@chromium.org>
References: <20241107213150.1711962-1-sjg@chromium.org>
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

(no changes since v9)

Changes in v9:
- Mark the image as complete after writing it

 arch/sandbox/dts/test.dts           |   2 +-
 test/boot/bootdev.c                 |  18 +++++++++-
 test/boot/bootflow.c                |   2 +-
 test/py/tests/bootstd/flash1.img.xz | Bin 0 -> 4924 bytes
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
index 369c611d924..8c44afd9297 100644
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
index 372bbab6b8d..ac548e78ceb 100644
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
index 0000000000000000000000000000000000000000..29b78c62a9bf264fa8b795b82b432bf3ab4e2765
GIT binary patch
literal 4924
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
YhlPdFIp0xdukLa_CjZAFrJ4EP0QdZp5dZ)H

literal 0
HcmV?d00001

diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index 9166c8f6b6e..6d44191976b 100644
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
@@ -547,6 +549,44 @@ def test_ut_dm_init(u_boot_console):
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
@@ -557,6 +597,7 @@ def test_ut_dm_init_bootstd(u_boot_console):
     setup_cedit_file(u_boot_console)
     setup_cros_image(u_boot_console)
     setup_android_image(u_boot_console)
+    setup_efi_image(u_boot_console)
 
     # Restart so that the new mmc1.img is picked up
     u_boot_console.restart_uboot()
-- 
2.34.1

