Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D3CCEC8759
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 21:39:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65D13869F5;
	Thu,  7 Sep 2023 23:39:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gUNST/9w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45D2A869F2; Thu,  7 Sep 2023 23:39:44 +0200 (CEST)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66C6A86995
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 23:39:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-d7bae413275so3571749276.0
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 14:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694122780; x=1694727580; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=our/uxSB/CKplt07iIY3zvkZJ59EnrxcAcxj2EbdYcU=;
 b=gUNST/9wfwP/pTWT4BZcwo7GGzMSSN2rBeCsW3X4Wqh5DXzbOy1f141ynH8mrVGcfU
 mnR7UtoMVAP/CkrzSH5tFoqGaRrSka4W26eVAIOBM+6LfwCBPwaxflPCKYgFYEtZgXmu
 5NJZAWc6yfPJBt3HN0/NhzJrPbbhupngJjX4qzbLMvLEsqvous70JAFC8DyidVRUjMAb
 U6yu8lhDIH1hUG8WW+bLjEWqfDGY9IR/u19Q6GoX/Z1Q7n9/5wEkCx7Hy5AFdlXMDWfs
 c3zkSp8eWBGxiTehRAhXcDqa6tyT/fNp3Q1Mw4QLhy88MXmntI6j7OF2+FgXIItWFSFT
 1Gfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694122780; x=1694727580;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=our/uxSB/CKplt07iIY3zvkZJ59EnrxcAcxj2EbdYcU=;
 b=CFICOjPZFtFl9m3dd5GxuvcfSEr0NijIXYLyVEGployCElOR9pl7//8zO3TEulcgwE
 oTkJaNMbclvh1kdQsBScSr/g7hx5JzuuPcobVuH99SN5bK/Ekd0uXSZdslbCgnWtH+Jo
 s4zJRC3IfsaJQzkUgylUho44Id1hfS+m6f7rFQcVRPKJ+rnrmwQNIBd+IN2J6C184ynq
 dq05yCYFBTGVDgtDzEh4Aja6CiKixVyYxfHMccmHmTQNmFHbs9+c7i7jXAPb8w3lOrQ5
 iyD+zLHLOfD9DVwYI3cCj1NEXpsWZEvs5k0ULZSUhwovMNqwDGpPMODDSjJyd6TNd6wU
 NykA==
X-Gm-Message-State: AOJu0YxzwWaO6hvjoFI6MH6LdrnEeMCZKX/M3pkEx/fn2XebA8qWmVN0
 8VuibAouGrWsyTojX4BBZ1Y=
X-Google-Smtp-Source: AGHT+IEt9KM2+4QMMRB23ow7mICeDEswAIYWUSoktFgrFw0n3WDyAaUFfZdMgh9UkNXuKX7G8h0KAQ==
X-Received: by 2002:a25:b29d:0:b0:d78:2258:f5b8 with SMTP id
 k29-20020a25b29d000000b00d782258f5b8mr5034360ybj.19.1694122779888; 
 Thu, 07 Sep 2023 14:39:39 -0700 (PDT)
Received: from localhost.localdomain
 (76-229-100-169.lightspeed.irvnca.sbcglobal.net. [76.229.100.169])
 by smtp.gmail.com with ESMTPSA id
 z1-20020a258681000000b00d7b9fab78bfsm78214ybk.7.2023.09.07.14.39.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 14:39:39 -0700 (PDT)
From: Tony Dinh <mibodhi@gmail.com>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Stefan Roese <sr@denx.de>,
 Tony Dinh <mibodhi@gmail.com>
Subject: [PATCH v2] bootstd: sata: Add bootstd support for ahci sata
Date: Thu,  7 Sep 2023 14:39:22 -0700
Message-Id: <20230907213923.25948-1-mibodhi@gmail.com>
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

Changes in v2:
- set devtype to sata in bootmeth_script for non-scsi SATA device

 boot/bootmeth_script.c     | 12 ++++++--
 drivers/ata/Makefile       |  1 +
 drivers/ata/sata.c         | 25 +++++++++++++++
 drivers/ata/sata_bootdev.c | 62 ++++++++++++++++++++++++++++++++++++++
 include/sata.h             |  1 +
 5 files changed, 99 insertions(+), 2 deletions(-)
 create mode 100644 drivers/ata/sata_bootdev.c

diff --git a/boot/bootmeth_script.c b/boot/bootmeth_script.c
index a4050c384d..3113183fb0 100644
--- a/boot/bootmeth_script.c
+++ b/boot/bootmeth_script.c
@@ -190,10 +190,18 @@ static int script_boot(struct udevice *dev, struct bootflow *bflow)
 	ulong addr;
 	int ret;
 
-	if (desc->uclass_id == UCLASS_USB)
+	if (desc->uclass_id == UCLASS_USB) {
 		ret = env_set("devtype", "usb");
-	else
+	} else {
 		ret = env_set("devtype", blk_get_devtype(bflow->blk));
+
+		/* If the parent uclass is AHCI, but the driver is ATA
+		 * (not scsi), set devtype to sata
+		 */
+		if (!ret && IS_ENABLED(CONFIG_SATA) &&
+		    !strcmp("ahci", env_get("devtype")))
+			ret = env_set("devtype", "sata");
+	}
 	if (!ret)
 		ret = env_set_hex("devnum", desc->devnum);
 	if (!ret)
diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index 6e30180b8b..c1b51b5444 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_DWC_AHSATA) += dwc_ahsata.o
 obj-$(CONFIG_FSL_SATA) += fsl_sata.o
 obj-$(CONFIG_LIBATA) += libata.o
 obj-$(CONFIG_SATA) += sata.o
+obj-$(CONFIG_BOOTSTD) += sata_bootdev.o
 obj-$(CONFIG_SATA_CEVA) += sata_ceva.o
 obj-$(CONFIG_SATA_MV) += sata_mv.o
 obj-$(CONFIG_SATA_SIL) += sata_sil.o
diff --git a/drivers/ata/sata.c b/drivers/ata/sata.c
index ce3e9b5a40..9da7218564 100644
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
@@ -50,6 +52,29 @@ int sata_scan(struct udevice *dev)
 	return ops->scan(dev);
 }
 
+int sata_rescan(bool verbose)
+{
+	struct udevice *dev;
+	int devnum = 0;
+	int ret;
+
+	/* Find and probing the SATA controller */
+	ret = uclass_get_device(UCLASS_AHCI, devnum, &dev);
+
+	/* Sanity check */
+	if (ret)
+		ret = uclass_find_first_device(UCLASS_AHCI, &dev);
+	if (ret) {
+		printf("Cannot probe SATA device %d (err=%d)\n", devnum, ret);
+		return -ENOSYS;
+	}
+	if (!dev) {
+		printf("No SATA device found!\n");
+		return -ENOSYS;
+	}
+	return 0;
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
index d89f7a8a29..0495744bad 100644
--- a/include/sata.h
+++ b/include/sata.h
@@ -20,5 +20,6 @@ extern struct blk_desc sata_dev_desc[];
 
 int sata_probe(int devnum);
 int sata_remove(int devnum);
+int sata_rescan(bool verbose);
 
 #endif
-- 
2.39.2

