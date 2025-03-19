Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 058C4C35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 14:40:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A951A81F4E;
	Wed, 19 Mar 2025 15:39:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="giEOmaJG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53DB98193A; Wed, 19 Mar 2025 15:39:03 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3D3B81E60
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:39:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-390e3b3d3f4so4271134f8f.2
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 07:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742395139; x=1742999939; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q8sgHD9uWm+hIy6DH+2eZ5GrM6CEKNLHpe5DR2K+m3E=;
 b=giEOmaJGBVDVcyRDZjXIeSFPn/eZLesl+DUne4LVfP70knrdb74c9Zf9JyZMb73483
 c5gmV+mjDx60BHtUymr8ajhKo1CwM9M/Kkwgn6ytp5Y6ON4kxsUS5aA3WoEUttOaNpOX
 b3EtLU1GwU1mg6e8+q2lIehJEbl5gR16CL5Ao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742395139; x=1742999939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q8sgHD9uWm+hIy6DH+2eZ5GrM6CEKNLHpe5DR2K+m3E=;
 b=O/sg4fO0uBGejWO45GTdvNJAJ5cp2jtxBTPlR+pPVmniBBk7XcRm/ikpeqVowtogcy
 IyIbdYFc0u2oIXIwNor58kx/wCfj0ztw5PuM6TOi1LVg5KtE6PneUzu17U6HyR4gxtiO
 HuzABRrWymj1swpiSk1Yx7ti/cu82QLJAGgyVV+wvzCKzMftBia8so8JIysWcMOu5vmi
 ORrsPNUnQ09BmKxWuYlgYOWUYEWaeIuGfdklRQlm1sFLfxuGaAj3TPQbBxpKCIQPsq/R
 QzOns5d7jqhXkL/eukGGU57NXseKKJoRopv+xzcEVWY3ucAb0NWBrigBKpnSrwEi+i7p
 aRQA==
X-Gm-Message-State: AOJu0Yy9l2kJ0Xygtw/Vfy2t8VcJwsjjJMh86pKbQK3AXljFvl7oiPJJ
 81wor+dom9lUwn+6FyrFJgALgpqFhe4HZLnWb8NgUgXlPwtevguybNRlzqnw0tfbMrJf1EY3dEs
 =
X-Gm-Gg: ASbGncsn7LuhAWqGigF9ZDvCGqumZuvxPRxm37oxvOINMIcKAfn+NygEY2+CmJt1tYi
 bQyFp5QD4nvligRQ12n46/UKDbZuwsTiIdN0eg1LWb9JcDqpTtPYKodZzFPZqaHGDq1SlsM3SsA
 kqdPoEi3mXKdNxNc3o2bc0goXV24gr7CQRXhcDFSNPdyD96D7W7/8q3/1+YLfDy25fCdRagXsjG
 veL/VLiKGVF65y6uvNPimZ/4wgwnvpSjcg1lIWFjSwW182+oATtSOMJsJVIXGVI1xvULoYOb0NU
 +ysCwXMzvqFyAgLhX69DVbseRra9qd5dqRk40Ip/IA==
X-Google-Smtp-Source: AGHT+IE8T8bzwtQJSgfcQ7sCUaIw/el5jfBQUkcGhhusFGLz9s3Zap7wsaz0cS8K9gRMIe/xzloPqg==
X-Received: by 2002:a5d:5888:0:b0:391:231b:8e0d with SMTP id
 ffacd0b85a97d-39973b32bb3mr3721091f8f.39.1742395139355; 
 Wed, 19 Mar 2025 07:38:59 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb318a80sm21534428f8f.61.2025.03.19.07.38.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:38:58 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, Julius Lehmann <lehmanju@devpi.de>,
 Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Richard Weinberger <richard@nod.at>, Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 09/17] test/py: Add a test image for Ubuntu
Date: Wed, 19 Mar 2025 15:38:03 +0100
Message-ID: <20250319143820.2385092-10-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319143820.2385092-1-sjg@chromium.org>
References: <20250319143820.2385092-1-sjg@chromium.org>
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

Add an extlinux image that contains a few Ubuntu entries.

Increase the number of sandbox-USB-hub ports to permit this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

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
index aad5f36dcb5..81f68c48574 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -262,6 +262,45 @@ label Fedora-Workstation-armhfp-31-1.9 (5.3.7-301.fc31.armv7hl)
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
@@ -611,6 +650,7 @@ def test_ut_dm_init_bootstd(ubman):
     setup_cros_image(ubman)
     setup_android_image(ubman)
     setup_efi_image(ubman)
+    setup_ubuntu_image(ubman, 3, 'flash')
 
     # Restart so that the new mmc1.img is picked up
     ubman.restart_uboot()
-- 
2.43.0

