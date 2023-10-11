Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15235CDB482
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 20:27:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A577986B38;
	Wed, 11 Oct 2023 22:27:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Qm8DOp8A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDAE686B38; Wed, 11 Oct 2023 22:27:18 +0200 (CEST)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B84A86C8B
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 22:27:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-d81d09d883dso283931276.0
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 13:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697056027; x=1697660827; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XTwiKembhaXL+2HpTvma9a83IOeoYRdUWaSzBEQbvjA=;
 b=Qm8DOp8AO18RbGKtKncRKmT0KuggMA6O5PjhkReIMcm6inLJkBSYmEXBal7KORQygx
 Bko75g+zrt6YvejETI/GyxFVaGlhBSgSUPn8s1V92m0Wvn3u6ahSpAvjAWKb2VQXoPgJ
 g9n2Kbn4tEPVnLkABuArITX/vV81UXA2i25tD+4dkYfkywyxMTE/huyBU6tIBGTNpx7n
 /ZSqMVND6ngsZdn+LKzOC+X+Li9LsuVkQgqXMo8tKKGskjdEivL11l5cNXY3Zjl3eDWL
 2xhyWFknfLmxyBk0NgvT67C9j+iCH9OvL5ZbIooMCEYl8ySGAsEQ4gZNotw7chB1LuFW
 d4Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697056027; x=1697660827;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XTwiKembhaXL+2HpTvma9a83IOeoYRdUWaSzBEQbvjA=;
 b=hoWx+WtWY97QJfBLWyNYwfxBax5VlsXPYqZ7TjFcjjqhPfwfOOETw2KpyPTMUNDXBZ
 cnmX8HF3XgKnytvlTLnjKsTLlHUtB4Qi5nDzgIzoSMgWx0ApF7drBgqEtU9PH4EAMQmI
 t0t5UiQeghmoL2NjRfJvb9fPeTvhCAIJUC7hVtWr0BPPOV/l0p1aTn2SWD/0LoYoGYNW
 v+kA4KEzsvWMu1/pby5yk0dKXPGG2gAHGjAi5ehopmaUcGT4lfEccJgoOXnZze3RqNnS
 CGQPL5DxBqCCd0YIBeNJWw5ZohUAPSK++r3G7eQySJhva7ARGg/whUoDyGDa3qwy1igV
 KDqg==
X-Gm-Message-State: AOJu0YzdB3nAoy/v/odP6Xpbz7ObeNjW6TO3tGQlBGHguwvfauKDF8u0
 SO18A/l5j0dCWBwalclMs/M=
X-Google-Smtp-Source: AGHT+IHVGx4xkskN6ecHGEQj2DZOZZPqTHC3QnEqCt2k+8/Q9dzMsrn++0nzpPr8JtWk15K1q1hIZg==
X-Received: by 2002:a25:b1a0:0:b0:d9a:44dd:fe45 with SMTP id
 h32-20020a25b1a0000000b00d9a44ddfe45mr6757979ybj.49.1697056026722; 
 Wed, 11 Oct 2023 13:27:06 -0700 (PDT)
Received: from localhost.localdomain
 (76-229-100-169.lightspeed.irvnca.sbcglobal.net. [76.229.100.169])
 by smtp.gmail.com with ESMTPSA id
 j200-20020a2523d1000000b00d9a58aa5806sm1404289ybj.25.2023.10.11.13.27.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 13:27:06 -0700 (PDT)
From: Tony Dinh <mibodhi@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Stefan Roese <sr@denx.de>,
	Tony Dinh <mibodhi@gmail.com>
Subject: [PATCH v5] bootstd: sata: Add bootstd support for ahci sata
Date: Wed, 11 Oct 2023 13:26:42 -0700
Message-Id: <20231011202643.9194-1-mibodhi@gmail.com>
X-Mailer: git-send-email 2.39.2
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

Add ahci sata bootdev and corresponding hunting function.

Signed-off-by: Tony Dinh <mibodhi@gmail.com>
---

Changes in v5:
- In bootmeth_script script_boot(), it's unnecessary to check for ret so
remove it. While we're here, also initialize ret in declaration.

Changes in v4:
- Revise logic in bootmeth_script() to set devtype to sata for non-scsi
SATA device
- Rewrite sata_rescan() logic to properly remove all devices before probing
- Add description to sata_rescan() header

Changes in v3:
- Correct drivers/ata/Makefile to compile sata_bootdev only if
ahci sata is enabled.

Changes in v2:
- set devtype to sata in bootmeth_script for non-scsi SATA device.

 boot/bootmeth_script.c     | 16 +++++++---
 drivers/ata/Makefile       |  2 +-
 drivers/ata/sata.c         | 32 ++++++++++++++++++++
 drivers/ata/sata_bootdev.c | 62 ++++++++++++++++++++++++++++++++++++++
 include/sata.h             |  6 ++++
 5 files changed, 113 insertions(+), 5 deletions(-)
 create mode 100644 drivers/ata/sata_bootdev.c

diff --git a/boot/bootmeth_script.c b/boot/bootmeth_script.c
index 345114dabf..06340e43d2 100644
--- a/boot/bootmeth_script.c
+++ b/boot/bootmeth_script.c
@@ -188,12 +188,20 @@ static int script_boot(struct udevice *dev, struct bootflow *bflow)
 {
 	struct blk_desc *desc = dev_get_uclass_plat(bflow->blk);
 	ulong addr;
-	int ret;
+	int ret = 0;
 
-	if (desc->uclass_id == UCLASS_USB)
+	if (desc->uclass_id == UCLASS_USB) {
 		ret = env_set("devtype", "usb");
-	else
-		ret = env_set("devtype", blk_get_devtype(bflow->blk));
+	} else {
+		/* If the uclass is AHCI, but the driver is ATA
+		 * (not scsi), set devtype to sata
+		 */
+		if (IS_ENABLED(CONFIG_SATA) &&
+		    desc->uclass_id == UCLASS_AHCI)
+			ret = env_set("devtype", "sata");
+		else
+			ret = env_set("devtype", blk_get_devtype(bflow->blk));
+	}
 	if (!ret)
 		ret = env_set_hex("devnum", desc->devnum);
 	if (!ret)
diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index 6e30180b8b..0b6f91098a 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -10,7 +10,7 @@ obj-$(CONFIG_SCSI_AHCI) += ahci.o
 obj-$(CONFIG_DWC_AHSATA) += dwc_ahsata.o
 obj-$(CONFIG_FSL_SATA) += fsl_sata.o
 obj-$(CONFIG_LIBATA) += libata.o
-obj-$(CONFIG_SATA) += sata.o
+obj-$(CONFIG_SATA) += sata.o sata_bootdev.o
 obj-$(CONFIG_SATA_CEVA) += sata_ceva.o
 obj-$(CONFIG_SATA_MV) += sata_mv.o
 obj-$(CONFIG_SATA_SIL) += sata_sil.o
diff --git a/drivers/ata/sata.c b/drivers/ata/sata.c
index ce3e9b5a40..f126b84e05 100644
--- a/drivers/ata/sata.c
+++ b/drivers/ata/sata.c
@@ -15,6 +15,8 @@
 #include <dm.h>
 #include <part.h>
 #include <sata.h>
+#include <dm/device-internal.h>
+#include <dm/uclass-internal.h>
 
 #ifndef CONFIG_AHCI
 struct blk_desc sata_dev_desc[CONFIG_SYS_SATA_MAX_DEVICE];
@@ -50,6 +52,36 @@ int sata_scan(struct udevice *dev)
 	return ops->scan(dev);
 }
 
+int sata_rescan(bool verbose)
+{
+	int ret;
+	struct udevice *dev;
+
+	if (verbose)
+		printf("Removing devices on SATA bus...\n");
+
+	blk_unbind_all(UCLASS_AHCI);
+
+	ret = uclass_find_first_device(UCLASS_AHCI, &dev);
+	if (ret || !dev) {
+		printf("Cannot find SATA device (err=%d)\n", ret);
+		return -ENOSYS;
+	}
+
+	ret = device_remove(dev, DM_REMOVE_NORMAL);
+	if (ret) {
+		printf("Cannot remove SATA device '%s' (err=%d)\n", dev->name, ret);
+		return -ENOSYS;
+	}
+
+	if (verbose)
+		printf("Rescanning SATA bus for devices...\n");
+
+	ret = uclass_probe_all(UCLASS_AHCI);
+
+	return ret;
+}
+
 #ifndef CONFIG_AHCI
 #ifdef CONFIG_PARTITIONS
 struct blk_desc *sata_get_dev(int dev)
diff --git a/drivers/ata/sata_bootdev.c b/drivers/ata/sata_bootdev.c
new file mode 100644
index 0000000000..f638493ce0
--- /dev/null
+++ b/drivers/ata/sata_bootdev.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Bootdev for sata
+ *
+ * Copyright 2023 Tony Dinh <mibodhi@gmail.com>
+ */
+
+#include <common.h>
+#include <ahci.h>
+#include <bootdev.h>
+#include <dm.h>
+#include <init.h>
+#include <sata.h>
+
+static int sata_bootdev_bind(struct udevice *dev)
+{
+	struct bootdev_uc_plat *ucp = dev_get_uclass_plat(dev);
+
+	ucp->prio = BOOTDEVP_4_SCAN_FAST;
+
+	return 0;
+}
+
+static int sata_bootdev_hunt(struct bootdev_hunter *info, bool show)
+{
+	int ret;
+
+	if (IS_ENABLED(CONFIG_PCI)) {
+		ret = pci_init();
+		if (ret)
+			return ret;
+	}
+
+	ret = sata_rescan(true);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+struct bootdev_ops sata_bootdev_ops = {
+};
+
+static const struct udevice_id sata_bootdev_ids[] = {
+	{ .compatible = "u-boot,bootdev-sata" },
+	{ }
+};
+
+U_BOOT_DRIVER(sata_bootdev) = {
+	.name		= "sata_bootdev",
+	.id		= UCLASS_BOOTDEV,
+	.ops		= &sata_bootdev_ops,
+	.bind		= sata_bootdev_bind,
+	.of_match	= sata_bootdev_ids,
+};
+
+BOOTDEV_HUNTER(sata_bootdev_hunter) = {
+	.prio		= BOOTDEVP_4_SCAN_FAST,
+	.uclass		= UCLASS_AHCI,
+	.hunt		= sata_bootdev_hunt,
+	.drv		= DM_DRIVER_REF(sata_bootdev),
+};
diff --git a/include/sata.h b/include/sata.h
index d89f7a8a29..6111cf65d9 100644
--- a/include/sata.h
+++ b/include/sata.h
@@ -21,4 +21,10 @@ extern struct blk_desc sata_dev_desc[];
 int sata_probe(int devnum);
 int sata_remove(int devnum);
 
+/*
+ * Remove existing AHCI SATA device uclass and all of its children,
+ * if any, and probe it again.
+ */
+int sata_rescan(bool verbose);
+
 #endif
-- 
2.39.2

