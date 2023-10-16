Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57ED7CDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 22:51:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8DB286B81;
	Tue, 17 Oct 2023 00:51:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SxrJ5DIh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8704F86BA1; Tue, 17 Oct 2023 00:51:32 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B161386A3C
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 00:51:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-5a7eef0b931so62790727b3.0
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 15:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697496688; x=1698101488; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uAP3PRVZKBCGLkt/qtsrPRvEQwZ+RovfHOngT+JfztM=;
 b=SxrJ5DIhsxD+WDxVIbfj4r/Hveo+io8yNMBxWrYPw48W55ftxopzSmoouvun8F6HLD
 YH2PIbvF4fSEE3vChiMQgjZeSxjArr/k+aeNUzkwk4aS0gvbbHbaD0N4LtA5Pj8uOP7B
 xtsD6StPSItg7CvDY4aGZfwbx6nk/5OzSyJog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697496688; x=1698101488;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uAP3PRVZKBCGLkt/qtsrPRvEQwZ+RovfHOngT+JfztM=;
 b=QUgzyfs+ylfVxtTSn6zRB9jlmbhs19MQ/Qsa0Y+p4AkIS3OQQac9L5972z+GdN0cte
 6KMHD7T55kdXXYJYJcpnXJPabykPVGbRcTAdLmbFFF0qynlkC3qjSqaGOGtmi3onBwxS
 VcVWuGKfYfolD2tazRaKK0n2CC0ltR49rN8ZS1gQpPUaeVqq3L//Hao7upEiKdzEnxbl
 t71YimnP8+zZ7IY6UDk+EdgWxhuMGIXpuBNGhttjtapshQwKgJe7V4d82tVsLcmNfkLd
 8IgFxVppNA1rFGud7lb0B+R7BW2ftEHY6ujBDB9fZsZYC3YjE6hQhrSIO7a/9Ci2UU9+
 5NrQ==
X-Gm-Message-State: AOJu0YxXrL+3OVzH404mjgfiI7wDikViidIoTIXUyiXgeFz3e6Vbgbk4
 8qDLjQFrBof+1K/qX2VVKyy+J4htbi1xbC/S/b+QfQ==
X-Google-Smtp-Source: AGHT+IFMVCeq5KjbbNCCkiRAc9bdeYB/9KjL9svGUTYKVPyBM9+5Yd2q3AC8nc67Kf0u+Nln8HohAg==
X-Received: by 2002:a81:9182:0:b0:5a7:b782:6dd9 with SMTP id
 i124-20020a819182000000b005a7b7826dd9mr559999ywg.26.1697496688341; 
 Mon, 16 Oct 2023 15:51:28 -0700 (PDT)
Received: from sjg1.unitedwifi.com ([205.220.129.18])
 by smtp.gmail.com with ESMTPSA id
 ph5-20020a0562144a4500b006588bd29c7esm64601qvb.28.2023.10.16.15.51.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 15:51:28 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Alexander Gendin <agendin@matrox.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>, Bin Meng <bmeng.cn@gmail.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>, Nikhil M Jain <n-jain1@ti.com>,
 Rick Chen <rick@andestech.com>, Zong Li <zong.li@sifive.com>
Subject: [PATCH] mbr: Test tweaks
Date: Mon, 16 Oct 2023 16:50:46 -0600
Message-ID: <20231016225059.712261-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
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

Rather than do another review on [1] I thought it better to add a patch
showing changes. This is intended to be squashed in, if acceptable.

With the patch as is, various bootstd tests fail. This is because the
test adds a new mmc6 device. There is nothing really wrong with adding
new devices, but it does require quite a few tests to be updated. It is
simpler to have mmc6 disabled by default, then just enable it for the
one test that uses it.

This patch does that and undoes the changes to blk.c and bootdev.c

[1] https://patchwork.ozlabs.org/project/uboot/patch/ZSNWVGTjPEt2jXn5@alg-gentoo/

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/Kconfig                       |  2 ++
 arch/sandbox/dts/test.dts          |  1 +
 configs/sandbox_defconfig          |  2 --
 configs/sandbox_flattree_defconfig |  2 ++
 test/boot/bootdev.c                |  2 +-
 test/cmd/mbr.c                     | 13 ++++++++-
 test/dm/blk.c                      | 44 ++++++++++--------------------
 7 files changed, 32 insertions(+), 34 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 19f2891ba1c5..4f5b75129f34 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -208,6 +208,8 @@ config SANDBOX
 	imply PHYSMEM
 	imply GENERATE_ACPI_TABLE
 	imply BINMAN
+	imply CMD_MBR
+	imply CMD_MMC
 
 config SH
 	bool "SuperH architecture"
diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index 3a8c2456d401..9fe2d63dcc50 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -1101,6 +1101,7 @@
 
 	/* This is used for mbr tests */
 	mmc6 {
+		status = "disabled";
 		compatible = "sandbox,mmc";
 		filename = "mmc6.img";
 	};
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 01830c7bd255..a1c1a45a08a3 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -73,8 +73,6 @@ CONFIG_CMD_IDE=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_LOADM=y
 CONFIG_CMD_LSBLK=y
-CONFIG_CMD_MBR=y
-CONFIG_CMD_MMC=y
 CONFIG_CMD_MUX=y
 CONFIG_CMD_OSD=y
 CONFIG_CMD_PCI=y
diff --git a/configs/sandbox_flattree_defconfig b/configs/sandbox_flattree_defconfig
index 29ae4532c508..44ab80725fc7 100644
--- a/configs/sandbox_flattree_defconfig
+++ b/configs/sandbox_flattree_defconfig
@@ -47,10 +47,12 @@ CONFIG_CMD_MBR=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_OSD=y
 CONFIG_CMD_PCI=y
+CONFIG_CMD_READ=y
 CONFIG_CMD_REMOTEPROC=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_TEMPERATURE=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_WRITE=y
 CONFIG_BOOTP_DNS2=y
 CONFIG_CMD_TFTPPUT=y
 CONFIG_CMD_TFTPSRV=y
diff --git a/test/boot/bootdev.c b/test/boot/bootdev.c
index 66c151131edb..c5f14a7a1323 100644
--- a/test/boot/bootdev.c
+++ b/test/boot/bootdev.c
@@ -128,7 +128,7 @@ static int bootdev_test_labels(struct unit_test_state *uts)
 		    bootdev_find_by_label("fred0", &dev, &mflags));
 
 	/* Check unknown sequence number */
-	ut_asserteq(-ENOENT, bootdev_find_by_label("mmc7", &dev, &mflags));
+	ut_asserteq(-ENOENT, bootdev_find_by_label("mmc6", &dev, &mflags));
 
 	return 0;
 }
diff --git a/test/cmd/mbr.c b/test/cmd/mbr.c
index 4091ea687fc5..751b16d605b7 100644
--- a/test/cmd/mbr.c
+++ b/test/cmd/mbr.c
@@ -7,11 +7,14 @@
  */
 
 #include <common.h>
-#include <asm/global_data.h>
+#include <dm.h>
 #include <console.h>
 #include <dm/test.h>
 #include <mapmem.h>
 #include <part.h>
+#include <asm/global_data.h>
+#include <dm/device-internal.h>
+#include <dm/lists.h>
 #include <test/suites.h>
 #include <test/ut.h>
 
@@ -231,6 +234,14 @@ static int mbr_test_run(struct unit_test_state *uts)
 	unsigned char mbr_wbuf[512], ebr_wbuf[512], rbuf[512];
 	char mbr_parts_buf[256];
 	ulong mbr_wa, ebr_wa, ra, ebr_blk, mbr_parts_max;
+	struct udevice *dev;
+	ofnode root, node;
+
+	/* Enable the mmc6 node for this test */
+	root = oftree_root(oftree_default());
+	node = ofnode_find_subnode(root, "mmc6");
+	ut_assert(ofnode_valid(node));
+	ut_assertok(lists_bind_fdt(gd->dm_root, node, &dev, NULL, false));
 
 	mbr_parts_max = sizeof('\0') + 2 +
 		strlen(mbr_parts_header) +
diff --git a/test/dm/blk.c b/test/dm/blk.c
index 993c617832a8..799f1e4dc75b 100644
--- a/test/dm/blk.c
+++ b/test/dm/blk.c
@@ -83,12 +83,12 @@ static int dm_test_blk_usb(struct unit_test_state *uts)
 	ut_asserteq_ptr(usb_dev, dev_get_parent(dev));
 
 	/* Check we have one block device for each mass storage device */
-	ut_asserteq(7, count_blk_devices());
+	ut_asserteq(6, count_blk_devices());
 
 	/* Now go around again, making sure the old devices were unbound */
 	ut_assertok(usb_stop());
 	ut_assertok(usb_init());
-	ut_asserteq(7, count_blk_devices());
+	ut_asserteq(6, count_blk_devices());
 	ut_assertok(usb_stop());
 
 	return 0;
@@ -191,8 +191,6 @@ static int dm_test_blk_iter(struct unit_test_state *uts)
 	ut_asserteq_str("mmc1.blk", dev->name);
 	ut_assertok(blk_next_device_err(BLKF_REMOVABLE, &dev));
 	ut_asserteq_str("mmc0.blk", dev->name);
-	ut_assertok(blk_next_device_err(BLKF_REMOVABLE, &dev));
-	ut_asserteq_str("mmc6.blk", dev->name);
 	ut_asserteq(-ENODEV, blk_next_device_err(BLKF_REMOVABLE, &dev));
 
 	ut_assertok(blk_first_device_err(BLKF_BOTH, &dev));
@@ -204,8 +202,8 @@ static int dm_test_blk_iter(struct unit_test_state *uts)
 	ut_asserteq(-ENODEV, blk_next_device_err(BLKF_FIXED, &dev));
 
 	ut_asserteq(1, blk_count_devices(BLKF_FIXED));
-	ut_asserteq(3, blk_count_devices(BLKF_REMOVABLE));
-	ut_asserteq(4, blk_count_devices(BLKF_BOTH));
+	ut_asserteq(2, blk_count_devices(BLKF_REMOVABLE));
+	ut_asserteq(3, blk_count_devices(BLKF_BOTH));
 
 	i = 0;
 	blk_foreach_probe(BLKF_FIXED, dev)
@@ -214,16 +212,14 @@ static int dm_test_blk_iter(struct unit_test_state *uts)
 
 	i = 0;
 	blk_foreach_probe(BLKF_REMOVABLE, dev)
-		ut_asserteq_str((++i == 1 ? "mmc1.blk" : i == 2 ?
-			"mmc0.blk" : "mmc6.blk"), dev->name);
-	ut_asserteq(3, i);
+		ut_asserteq_str(i++ ? "mmc0.blk" : "mmc1.blk", dev->name);
+	ut_asserteq(2, i);
 
 	i = 0;
 	blk_foreach_probe(BLKF_BOTH, dev)
 		ut_asserteq_str((++i == 1 ? "mmc2.blk" : i == 2 ?
-			"mmc1.blk" : i == 3 ? "mmc0.blk" : "mmc6.blk"),
-			dev->name);
-	ut_asserteq(4, i);
+			"mmc1.blk" : "mmc0.blk"), dev->name);
+	ut_asserteq(3, i);
 
 	return 0;
 }
@@ -247,10 +243,6 @@ static int dm_test_blk_flags(struct unit_test_state *uts)
 	ut_assertnonnull(dev);
 	ut_asserteq_str("mmc0.blk", dev->name);
 
-	ut_assertok(blk_find_next(BLKF_BOTH, &dev));
-	ut_assertnonnull(dev);
-	ut_asserteq_str("mmc6.blk", dev->name);
-
 	ut_asserteq(-ENODEV, blk_find_next(BLKF_BOTH, &dev));
 	ut_assertnull(dev);
 
@@ -274,10 +266,6 @@ static int dm_test_blk_flags(struct unit_test_state *uts)
 	ut_assertnonnull(dev);
 	ut_asserteq_str("mmc0.blk", dev->name);
 
-	ut_assertok(blk_next_device_err(BLKF_BOTH, &dev));
-	ut_assertnonnull(dev);
-	ut_asserteq_str("mmc6.blk", dev->name);
-
 	ut_asserteq(-ENODEV, blk_next_device_err(BLKF_BOTH, &dev));
 
 	/* Look only for fixed devices */
@@ -296,10 +284,6 @@ static int dm_test_blk_flags(struct unit_test_state *uts)
 	ut_assertnonnull(dev);
 	ut_asserteq_str("mmc0.blk", dev->name);
 
-	ut_assertok(blk_next_device_err(BLKF_REMOVABLE, &dev));
-	ut_assertnonnull(dev);
-	ut_asserteq_str("mmc6.blk", dev->name);
-
 	ut_asserteq(-ENODEV, blk_next_device_err(BLKF_REMOVABLE, &dev));
 
 	return 0;
@@ -316,7 +300,7 @@ static int dm_test_blk_foreach(struct unit_test_state *uts)
 	found = 0;
 	blk_foreach(BLKF_BOTH, dev)
 		found |= 1 << dectoul(&dev->name[3], NULL);
-	ut_asserteq(0x47, found);
+	ut_asserteq(7, found);
 
 	/* All devices are removable until probed */
 	found = 0;
@@ -327,14 +311,14 @@ static int dm_test_blk_foreach(struct unit_test_state *uts)
 	found = 0;
 	blk_foreach(BLKF_REMOVABLE, dev)
 		found |= 1 << dectoul(&dev->name[3], NULL);
-	ut_asserteq(0x47, found);
+	ut_asserteq(7, found);
 
 	/* Now try again with the probing functions */
 	found = 0;
 	blk_foreach_probe(BLKF_BOTH, dev)
 		found |= 1 << dectoul(&dev->name[3], NULL);
-	ut_asserteq(0x47, found);
-	ut_asserteq(4, blk_count_devices(BLKF_BOTH));
+	ut_asserteq(7, found);
+	ut_asserteq(3, blk_count_devices(BLKF_BOTH));
 
 	found = 0;
 	blk_foreach_probe(BLKF_FIXED, dev)
@@ -345,8 +329,8 @@ static int dm_test_blk_foreach(struct unit_test_state *uts)
 	found = 0;
 	blk_foreach_probe(BLKF_REMOVABLE, dev)
 		found |= 1 << dectoul(&dev->name[3], NULL);
-	ut_asserteq(0x43, found);
-	ut_asserteq(3, blk_count_devices(BLKF_REMOVABLE));
+	ut_asserteq(3, found);
+	ut_asserteq(2, blk_count_devices(BLKF_REMOVABLE));
 
 	return 0;
 }
-- 
2.42.0.655.g421f12c284-goog

