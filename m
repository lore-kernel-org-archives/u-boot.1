Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 454ACC369DC
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 13:38:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE18782162;
	Thu,  1 May 2025 15:37:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="b9VYndyP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE86A82153; Thu,  1 May 2025 15:37:52 +0200 (CEST)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01C028213D
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 15:37:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-3d93deba52fso3017535ab.0
 for <u-boot@lists.denx.de>; Thu, 01 May 2025 06:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746106668; x=1746711468; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XEVmOE+yKS9BZLT9yo1F0EP38kKKl3LyIVgoEUtyITQ=;
 b=b9VYndyP5+m2qAPsPIQF8Kb7hsi/jkWFR8NZ8QSiYLE6K+NBwQv59FYOt1LD/7O4b2
 cKK3R7YfuGUu7kwe4yPtzT6FUiuOpgSH2xCJ+L18Wx/ozk1ItnEacKdm5bDr7wxS3DDi
 nbYdjpX6n2ofi4eviPycRttbjXuXMMP3qAKUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746106668; x=1746711468;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XEVmOE+yKS9BZLT9yo1F0EP38kKKl3LyIVgoEUtyITQ=;
 b=nJZgNk8BMR9Vea/fI8HwDI3P7DsyS5e0V6X2wSDOopfYkY1sPbAGs9KYpSdx+NoaJJ
 uShiffk/Wv2aTS57uuqILVczYpTXORZ3CSBjeJGFNJphEJU9BC3/ryx0jTacZa13EgiB
 C9tZzHOy9NKZS3ElleIYoWBUSLNVOjl5E4QlCRBVonfDW66CvywSGMtlboAqaS/Wj1Qr
 /JUGrdtbx6vCpLd68kTxnPM8ZvhO4JsbHBO/dAvbq/Sek9PMb1TzIc7GEMLHm605YP28
 U7gO1puUUfYhenQDgCQOZfEUH/0fDuRUEFgnhK0hWzERVw6Mzp7E+UbE63yzRTq4v0Pk
 AKwQ==
X-Gm-Message-State: AOJu0Yxov/ZYsCsAdYyPFwklpeIufdPA2UVH3OlU9G34zen7rie2MY5r
 5cKEG0Vqi81a420Bfm3PXjPLrYS0yZ6y+wG2jusqBIsYFHufSCg5ETUfsLmSCiVlZ5yruB7nWhc
 =
X-Gm-Gg: ASbGncv6MgSWcpu6MGrdTaCUG6IWrf7xblQUeYOjX6uWIgFg4rytTaZY0iMKgkUpdtE
 dUCUO3wfUSM9erlpeV1QU1c2cyX3vWhaTzkIGX4bGS54NumfgFr0ZV3Cm31ANm/+DmzKOjgZLPS
 DpRdLWo0nh7xqRsMctuGcgwMXLZIBxUhaydwDYkY/DhbpSgbIYWevyT92A6Vgiu9WnElXA8ie1p
 msRg7Q29Aj+NsSIgCBitJnn5D3WculZpxxrmulZiamSOr1e7xaoUJj95lFyngSQGXm38/8Vk8U4
 QcOh0MLEq0A903tFSHZcAvNIDZ/CmEQGOzP8Ne7CXFlWsF7sB+k7oDkvGjXlSe8XTO2oLC8H2+o
 nww==
X-Google-Smtp-Source: AGHT+IEjyGu9RhVg/SDiW6YPbW0RbBIq+QWy0R0w8j7jQEvPVK294eOoo6DGv0Sr9ZgsOIsHqHHijA==
X-Received: by 2002:a05:6e02:18c5:b0:3d9:6e2d:c7dd with SMTP id
 e9e14a558f8ab-3d96f22d8a8mr35605815ab.17.1746106668018; 
 Thu, 01 May 2025 06:37:48 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f88303bb9esm165385173.136.2025.05.01.06.37.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 06:37:47 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, Julius Lehmann <lehmanju@devpi.de>,
 Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Richard Weinberger <richard@nod.at>, Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 10/18] test/py: Add an extlinux file similar to Ubuntu
Date: Thu,  1 May 2025 07:37:10 -0600
Message-ID: <20250501133726.2627373-11-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501133726.2627373-1-sjg@chromium.org>
References: <20250501133726.2627373-1-sjg@chromium.org>
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

Add an extlinux configuration-file that contains a few entries as
created by the u-boot-menu package in Ubuntu 24.04

Increase the number of sandbox-USB-hub ports to permit this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Update commit message to make it clear this is not actually an image

 arch/sandbox/dts/test.dts      |  9 +++++++-
 drivers/usb/emul/sandbox_hub.c |  2 +-
 test/boot/bootdev.c            | 34 +++++++++++++++++++----------
 test/boot/bootflow.c           |  6 +++--
 test/dm/blk.c                  |  4 ++--
 test/dm/usb.c                  |  4 ++--
 test/py/tests/test_ut.py       | 40 ++++++++++++++++++++++++++++++++++
 7 files changed, 79 insertions(+), 20 deletions(-)

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index 6cd87b74a64..060c48eaefd 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -1515,6 +1515,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			hub-emul {
+				/* See SANDBOX_NUM_PORTS if you need more ports */
 				compatible = "sandbox,usb-hub";
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -1536,8 +1537,14 @@
 					sandbox,filepath = "testflash2.bin";
 				};
 
-				keyb@3 {
+				flash-stick@3 {
 					reg = <3>;
+					compatible = "sandbox,usb-flash";
+					sandbox,filepath = "flash3.img";
+				};
+
+				keyb@4 {
+					reg = <4>;
 					compatible = "sandbox,usb-keyb";
 				};
 
diff --git a/drivers/usb/emul/sandbox_hub.c b/drivers/usb/emul/sandbox_hub.c
index 3b3e59f978f..dc348d152c2 100644
--- a/drivers/usb/emul/sandbox_hub.c
+++ b/drivers/usb/emul/sandbox_hub.c
@@ -10,7 +10,7 @@
 #include <dm/device-internal.h>
 
 /* We only support up to 8 */
-#define SANDBOX_NUM_PORTS	4
+#define SANDBOX_NUM_PORTS	8
 
 struct sandbox_hub_plat {
 	struct usb_dev_plat plat;
diff --git a/test/boot/bootdev.c b/test/boot/bootdev.c
index d5499918249..4333f3c977c 100644
--- a/test/boot/bootdev.c
+++ b/test/boot/bootdev.c
@@ -221,11 +221,14 @@ static int bootdev_test_order(struct unit_test_state *uts)
 	ut_assertok(env_set("boot_targets", "mmc1 mmc2 usb"));
 	ut_assertok(bootflow_scan_first(NULL, NULL, &iter, 0, &bflow));
 
-	/* get the usb device which has a backing file (flash1.img) */
+	/* get the first usb device which has a backing file (flash1.img) */
+	ut_asserteq(0, bootflow_scan_next(&iter, &bflow));
+
+	/* get the second usb device which has a backing file (flash3.img) */
 	ut_asserteq(0, bootflow_scan_next(&iter, &bflow));
 
 	ut_asserteq(-ENODEV, bootflow_scan_next(&iter, &bflow));
-	ut_asserteq(5, iter.num_devs);
+	ut_asserteq(6, iter.num_devs);
 	ut_asserteq_str("mmc1.bootdev", iter.dev_used[0]->name);
 	ut_asserteq_str("mmc2.bootdev", iter.dev_used[1]->name);
 	ut_asserteq_str("usb_mass_storage.lun0.bootdev",
@@ -264,12 +267,13 @@ static int bootdev_test_order(struct unit_test_state *uts)
 	ut_asserteq(2, iter.num_devs);
 
 	/*
-	 * Now scan past mmc1 and make sure that the 3 USB devices show up. The
-	 * first one has a backing file so returns success
+	 * Now scan past mmc1 and make sure that the 4 USB devices show up. The
+	 * first two have a backing file so returns success
 	 */
 	ut_asserteq(0, bootflow_scan_next(&iter, &bflow));
+	ut_asserteq(0, bootflow_scan_next(&iter, &bflow));
 	ut_asserteq(-ENODEV, bootflow_scan_next(&iter, &bflow));
-	ut_asserteq(6, iter.num_devs);
+	ut_asserteq(7, iter.num_devs);
 	ut_asserteq_str("mmc2.bootdev", iter.dev_used[0]->name);
 	ut_asserteq_str("mmc1.bootdev", iter.dev_used[1]->name);
 	ut_asserteq_str("mmc0.bootdev", iter.dev_used[2]->name);
@@ -330,11 +334,14 @@ static int bootdev_test_prio(struct unit_test_state *uts)
 	/* 3 MMC and 3 USB bootdevs: MMC should come before USB */
 	ut_assertok(bootflow_scan_first(NULL, NULL, &iter, 0, &bflow));
 
-	/* get the usb device which has a backing file (flash1.img) */
+	/* get the first usb device which has a backing file (flash1.img) */
+	ut_asserteq(0, bootflow_scan_next(&iter, &bflow));
+
+	/* get the second usb device which has a backing file (flash3.img) */
 	ut_asserteq(0, bootflow_scan_next(&iter, &bflow));
 
 	ut_asserteq(-ENODEV, bootflow_scan_next(&iter, &bflow));
-	ut_asserteq(6, iter.num_devs);
+	ut_asserteq(7, iter.num_devs);
 	ut_asserteq_str("mmc2.bootdev", iter.dev_used[0]->name);
 	ut_asserteq_str("usb_mass_storage.lun0.bootdev",
 			iter.dev_used[3]->name);
@@ -351,11 +358,14 @@ static int bootdev_test_prio(struct unit_test_state *uts)
 	ut_assertok(bootflow_scan_first(NULL, NULL, &iter, BOOTFLOWIF_HUNT,
 					&bflow));
 
-	/* get the usb device which has a backing file (flash1.img) */
+	/* get the first usb device which has a backing file (flash1.img) */
+	ut_asserteq(0, bootflow_scan_next(&iter, &bflow));
+
+	/* get the second usb device which has a backing file (flash3.img) */
 	ut_asserteq(0, bootflow_scan_next(&iter, &bflow));
 
 	ut_asserteq(-ENODEV, bootflow_scan_next(&iter, &bflow));
-	ut_asserteq(7, iter.num_devs);
+	ut_asserteq(8, iter.num_devs);
 	ut_asserteq_str("usb_mass_storage.lun0.bootdev",
 			iter.dev_used[0]->name);
 	ut_asserteq_str("mmc2.bootdev", iter.dev_used[1]->name);
@@ -393,7 +403,7 @@ static int bootdev_test_hunter(struct unit_test_state *uts)
 
 	ut_assertok(bootdev_hunt("usb1", false));
 	ut_assert_nextline(
-		"Bus usb@1: scanning bus usb@1 for devices... 5 USB Device(s) found");
+		"Bus usb@1: scanning bus usb@1 for devices... 6 USB Device(s) found");
 	ut_assert_console_end();
 
 	/* USB is 7th in the list, so bit 8 */
@@ -449,7 +459,7 @@ static int bootdev_test_cmd_hunt(struct unit_test_state *uts)
 	ut_assert_skip_to_line("Hunting with: spi_flash");
 	ut_assert_nextline("Hunting with: usb");
 	ut_assert_nextline(
-		"Bus usb@1: scanning bus usb@1 for devices... 5 USB Device(s) found");
+		"Bus usb@1: scanning bus usb@1 for devices... 6 USB Device(s) found");
 	ut_assert_nextline("Hunting with: virtio");
 	ut_assert_console_end();
 
@@ -552,7 +562,7 @@ static int bootdev_test_hunt_prio(struct unit_test_state *uts)
 	ut_assert_nextline("Hunting with: ide");
 	ut_assert_nextline("Hunting with: usb");
 	ut_assert_nextline(
-		"Bus usb@1: scanning bus usb@1 for devices... 5 USB Device(s) found");
+		"Bus usb@1: scanning bus usb@1 for devices... 6 USB Device(s) found");
 	ut_assert_console_end();
 
 	return 0;
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 1447af2eb14..3ee87145dc8 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -1298,7 +1298,7 @@ static int bootflow_efi(struct unit_test_state *uts)
 
 	ut_assertok(run_command("bootflow scan", 0));
 	ut_assert_skip_to_line(
-		"Bus usb@1: scanning bus usb@1 for devices... 5 USB Device(s) found");
+		"Bus usb@1: scanning bus usb@1 for devices... 6 USB Device(s) found");
 
 	ut_assertok(run_command("bootflow list", 0));
 
@@ -1308,8 +1308,10 @@ static int bootflow_efi(struct unit_test_state *uts)
 	ut_assert_nextlinen("  0  extlinux");
 	ut_assert_nextlinen(
 		"  1  efi          ready   usb_mass_    1  usb_mass_storage.lun0.boo /EFI/BOOT/BOOTSBOX.EFI");
+	ut_assert_nextlinen(
+		"  2  extlinux     ready   usb_mass_    1  usb_mass_storage.lun0.boo /extlinux/extlinux.conf");
 	ut_assert_nextlinen("---");
-	ut_assert_skip_to_line("(2 bootflows, 2 valid)");
+	ut_assert_skip_to_line("(3 bootflows, 3 valid)");
 	ut_assert_console_end();
 
 	ut_assertok(run_command("bootflow select 1", 0));
diff --git a/test/dm/blk.c b/test/dm/blk.c
index aa5cbc63777..2e889d1a418 100644
--- a/test/dm/blk.c
+++ b/test/dm/blk.c
@@ -82,12 +82,12 @@ static int dm_test_blk_usb(struct unit_test_state *uts)
 	ut_asserteq_ptr(usb_dev, dev_get_parent(dev));
 
 	/* Check we have one block device for each mass storage device */
-	ut_asserteq(6, count_blk_devices());
+	ut_asserteq(7, count_blk_devices());
 
 	/* Now go around again, making sure the old devices were unbound */
 	ut_assertok(usb_stop());
 	ut_assertok(usb_init());
-	ut_asserteq(6, count_blk_devices());
+	ut_asserteq(7, count_blk_devices());
 	ut_assertok(usb_stop());
 
 	return 0;
diff --git a/test/dm/usb.c b/test/dm/usb.c
index fa894c1096e..d89d436d269 100644
--- a/test/dm/usb.c
+++ b/test/dm/usb.c
@@ -158,7 +158,7 @@ static int dm_test_usb_stop(struct unit_test_state *uts)
 	ut_assertok(uclass_get_device(UCLASS_MASS_STORAGE, 0, &dev));
 	ut_assertok(uclass_get_device(UCLASS_MASS_STORAGE, 1, &dev));
 	ut_assertok(uclass_get_device(UCLASS_MASS_STORAGE, 2, &dev));
-	ut_asserteq(6, count_usb_devices());
+	ut_asserteq(7, count_usb_devices());
 	ut_assertok(usb_stop());
 	ut_asserteq(0, count_usb_devices());
 
@@ -429,7 +429,7 @@ static int dm_test_usb_keyb(struct unit_test_state *uts)
 	/* Initially there should be no characters */
 	ut_asserteq(0, tstc());
 
-	ut_assertok(uclass_get_device_by_name(UCLASS_USB_EMUL, "keyb@3",
+	ut_assertok(uclass_get_device_by_name(UCLASS_USB_EMUL, "keyb@4",
 					      &dev));
 
 	/*
diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index fc72496ba46..85ba6e3f5c3 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -232,6 +232,45 @@ label Fedora-Workstation-armhfp-31-1.9 (5.3.7-301.fc31.armv7hl)
     setup_bootflow_image(ubman, devnum, basename, vmlinux, initrd, dtbdir,
                          script)
 
+def setup_ubuntu_image(ubman, devnum, basename):
+    """Create a 20MB Ubuntu disk image with a single FAT partition
+
+    Args:
+        ubman (ConsoleBase): Console to use
+        devnum (int): Device number to use, e.g. 1
+        basename (str): Base name to use in the filename, e.g. 'mmc'
+    """
+    vmlinux = 'vmlinuz-6.8.0-53-generic'
+    initrd = 'initrd.img-6.8.0-53-generic'
+    dtbdir = None
+    script = '''## /boot/extlinux/extlinux.conf
+##
+## IMPORTANT WARNING
+##
+## The configuration of this file is generated automatically.
+## Do not edit this file manually, use: u-boot-update
+
+default l0
+menu title U-Boot menu
+prompt 1
+timeout 50
+
+
+label l0
+	menu label Ubuntu 24.04.1 LTS 6.8.0-53-generic
+	linux /boot/%s
+	initrd /boot/%s
+
+	append root=/dev/disk/by-uuid/bcfdda4a-8249-4f40-9f0f-7c1a76b6cbe8 ro earlycon
+
+label l0r
+	menu label Ubuntu 24.04.1 LTS 6.8.0-53-generic (rescue target)
+	linux /boot/%s
+	initrd /boot/%s
+''' % (vmlinux, initrd, vmlinux, initrd)
+    setup_bootflow_image(ubman, devnum, basename, vmlinux, initrd, dtbdir,
+                         script)
+
 def setup_cros_image(ubman):
     """Create a 20MB disk image with ChromiumOS partitions"""
     Partition = collections.namedtuple('part', 'start,size,name')
@@ -581,6 +620,7 @@ def test_ut_dm_init_bootstd(ubman):
     setup_cros_image(ubman)
     setup_android_image(ubman)
     setup_efi_image(ubman)
+    setup_ubuntu_image(ubman, 3, 'flash')
 
     # Restart so that the new mmc1.img is picked up
     ubman.restart_uboot()
-- 
2.43.0

