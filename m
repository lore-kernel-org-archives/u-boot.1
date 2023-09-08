Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C0AEEEB562
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 19:10:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0904386977;
	Fri,  8 Sep 2023 21:10:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SyijsY/W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C22486977; Fri,  8 Sep 2023 21:10:09 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C30E80726
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 21:10:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-58caaedb20bso24887577b3.1
 for <u-boot@lists.denx.de>; Fri, 08 Sep 2023 12:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694200200; x=1694805000; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5ahj68QoBYpl5laaN7YYEHxcxGk3Dy7ue1P52a0gL7Q=;
 b=SyijsY/WFcCqEuPzrBtphYNrbSaVa9h/3jLU9etS304gyF7+MYVsl+j/+4dJ4eEuhR
 RYw1jJLv3E3xvsktK2660cKeUr0+iUqWoepHJXpcnbBqGddqiSVCtUkZ2+eh1/k1VpeE
 repCBlBWOWhPmnH0RIo1BPlNdOczFCcAOI08GktS/JkuZ+NZTf9aSnPhiid/O1WUm68T
 6LmC+LrW5iqMMsp929RyptYR6YHKDfvF3vAnewVHTC1VdB+zyiflQ5HJW44kd/jAQYy4
 W8D4D84gRiPPMaPUY+T2iLiyzVKiHJ9D6wdC3phlI5JY9E6J0/M7OAY9V92JXs47MEho
 IHWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694200200; x=1694805000;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5ahj68QoBYpl5laaN7YYEHxcxGk3Dy7ue1P52a0gL7Q=;
 b=Qwc+KT+/TByhkpL5bV1QcAYrh7Se/Ld3kxYosdtgQzrJkd54wy5hHay/7P6RcpQqRK
 jKQJ1Ws+KtCpG5foWptNDRbnPcmUsKz+/WiMHNCLFxv872c5RbEpyif4+qdzKgs4PHk5
 As0d7OaN/+GdZm+A7NkQ2LWz2oX2N95wi+zQMy4f67gTcCwEYxw+dFstSXAkdtAwNL7e
 ux9GkZGIkhn1LvnBFtEgBZW5UhH3UkZYx3dIP/5FTeXGBsZ860rV5VwmivBF7YJfcEzA
 kn85P62EiWaIbc8I6RyQBRrJD8u0lqGd4lK7Tuzp0O8xVQTdfTXCdgjDNqY1gQcyIvoq
 xniQ==
X-Gm-Message-State: AOJu0Yy4oRU8qlSYFm8Z9bttgSRo+2FLAnBJbQjYicnpq5A+yZfZX11R
 C+nZmS6kj2F7bDNdhi1cEjk=
X-Google-Smtp-Source: AGHT+IF44RvE6nCxU56zK5DwQdKaNp66omJZ54R9Roh7P7mzy0s4TJkx7g94qZQ/eEE6PbecVr3RWg==
X-Received: by 2002:a0d:ca84:0:b0:58d:5df8:f61e with SMTP id
 m126-20020a0dca84000000b0058d5df8f61emr3341868ywd.2.1694200200070; 
 Fri, 08 Sep 2023 12:10:00 -0700 (PDT)
Received: from localhost.localdomain
 (76-229-100-169.lightspeed.irvnca.sbcglobal.net. [76.229.100.169])
 by smtp.gmail.com with ESMTPSA id
 h6-20020a0df706000000b0058c55d40765sm562957ywf.106.2023.09.08.12.09.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 12:09:59 -0700 (PDT)
From: Tony Dinh <mibodhi@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Stefan Roese <sr@denx.de>,
	Tony Dinh <mibodhi@gmail.com>
Subject: [PATCH v3] bootstd: sata: Add bootstd support for ahci sata
Date: Fri,  8 Sep 2023 12:09:34 -0700
Message-Id: <20230908190935.12516-1-mibodhi@gmail.com>
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

Changes in v3:
- Correct drivers/ata/Makefile to compile sata_bootdev only if
ahci sata is enabled.

Changes in v2:
- set devtype to sata in bootmeth_script for non-scsi SATA device.

 boot/bootmeth_script.c     | 12 ++++++--
 drivers/ata/Makefile       |  2 +-
 drivers/ata/sata.c         | 25 +++++++++++++++
 drivers/ata/sata_bootdev.c | 62 ++++++++++++++++++++++++++++++++++++++
 include/sata.h             |  1 +
 5 files changed, 99 insertions(+), 3 deletions(-)
 create mode 100644 drivers/ata/sata_bootdev.c

diff --git a/boot/bootmeth_script.c b/boot/bootmeth_script.c
index 58c57a2d4b..0269e0f9b0 100644
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

