Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0223CD13CF
	for <u-boot@archiver.kernel.org>; Sun, 17 Sep 2023 23:07:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BABB084788;
	Mon, 18 Sep 2023 01:07:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QlU1mQEe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C366A82BBF; Mon, 18 Sep 2023 01:07:42 +0200 (CEST)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A110884788
 for <u-boot@lists.denx.de>; Mon, 18 Sep 2023 01:07:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-34fcc3ac97bso7064485ab.0
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694992059; x=1695596859; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kYbbIDfPMGKLtxSSUvHKcMtOUOup28l1oAZ2omBB+gg=;
 b=QlU1mQEembkrwsGOau3TsDlrbEhTzwLNk0sXA8KkI+2i6T1kpQXjAawllBgaWYtt7Z
 q/J3Ggm4mRIA/8L+Mn/W/GQ1pDFl7EwtiV78zHFzNq/25ilh1F+DJSonfukceNMRdx+u
 Pj+hBy5r+bMI8K0eXz7N7DRxb+UoGsWbLOkuyvA8C3LKzmM42IVFh8jo+XsL0Vq3x4oV
 Qhv5LQ9DbzO5Cnrev7GMBajBotiCGOImgNhRCFLfgOAd+5nwGbW/2wLZ9RB92alCjJVR
 rYQ5BTz/aIdkUQECdGG3coLZCVB14igpOJm9YHdiTZVklqwGVgEiMtssPJia4wC5aL2Q
 SYng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694992059; x=1695596859;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kYbbIDfPMGKLtxSSUvHKcMtOUOup28l1oAZ2omBB+gg=;
 b=D5eZA5LZIG82LatxxcLicYUC9xpNgqbPk/Ap1T03iP2nMddC8auHj4xa4HhP/gMr1I
 6b8prChq+3mgrnadqyAXf/Lkl9J1eBooRrYgyWwQw32343oPr/koD5xGsRnppO1ckwlP
 SnbXEroP7paH+Tk2xCwSieU4nkxI/Bjq0/NZBw/nTJsfkpKZCC0E5kfigEYneUO0ldYO
 bUnX7Y8GajsGZbJvcZKsmBv2qZS9wNn2pgvOrJTOg7WWZMRK4+H7jgwmhSgZF6upiWW2
 FNeDqFtLmvMXZRrlV9SswyXo1ahseMYLXs7dOxWDEeUC3t6v6pZTK/8BzSmWQSOjXW0Y
 O3kg==
X-Gm-Message-State: AOJu0Yxe0miROpJyUgsQnKuaeDioxfbndsYOCZFkZFhN4Lb1Xk688MIc
 rWdrYm0pq8QIJijMTy/1QPw=
X-Google-Smtp-Source: AGHT+IHckR1uBYjYCQVnr5/4O66Mg1BsJj8WpmcSU0OmR7SI76ylFvJeU9jxhgJ9Pw8QNvyVeaYiWw==
X-Received: by 2002:a05:6e02:c08:b0:348:c57f:b016 with SMTP id
 d8-20020a056e020c0800b00348c57fb016mr8672397ile.3.1694992059021; 
 Sun, 17 Sep 2023 16:07:39 -0700 (PDT)
Received: from localhost.localdomain
 (76-229-100-169.lightspeed.irvnca.sbcglobal.net. [76.229.100.169])
 by smtp.gmail.com with ESMTPSA id
 x126-20020a25ce84000000b00d7ba4c5e31fsm1950191ybe.39.2023.09.17.16.07.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Sep 2023 16:07:38 -0700 (PDT)
From: Tony Dinh <mibodhi@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Stefan Roese <sr@denx.de>,
	Tony Dinh <mibodhi@gmail.com>
Subject: [PATCH v4] bootstd: sata: Add bootstd support for ahci sata
Date: Sun, 17 Sep 2023 16:06:48 -0700
Message-Id: <20230917230649.30357-1-mibodhi@gmail.com>
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

 boot/bootmeth_script.c     | 14 +++++++--
 drivers/ata/Makefile       |  2 +-
 drivers/ata/sata.c         | 32 ++++++++++++++++++++
 drivers/ata/sata_bootdev.c | 62 ++++++++++++++++++++++++++++++++++++++
 include/sata.h             |  6 ++++
 5 files changed, 112 insertions(+), 4 deletions(-)
 create mode 100644 drivers/ata/sata_bootdev.c

diff --git a/boot/bootmeth_script.c b/boot/bootmeth_script.c
index 58c57a2d4b..96e0ec5efa 100644
--- a/boot/bootmeth_script.c
+++ b/boot/bootmeth_script.c
@@ -190,10 +190,18 @@ static int script_boot(struct udevice *dev, struct bootflow *bflow)
 	ulong addr;
 	int ret;
 
-	if (desc->uclass_id == UCLASS_USB)
+	if (desc->uclass_id == UCLASS_USB) {
 		ret = env_set("devtype", "usb");
-	else
-		ret = env_set("devtype", blk_get_devtype(bflow->blk));
+	} else {
+		/* If the uclass is AHCI, but the driver is ATA
+		 * (not scsi), set devtype to sata
+		 */
+		if (!ret && IS_ENABLED(CONFIG_SATA) &&
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

