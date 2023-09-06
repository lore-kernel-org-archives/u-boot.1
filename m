Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1D2FEB8FA5
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 04:00:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02D0286553;
	Wed,  6 Sep 2023 06:00:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nqrWtGa9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08D708666B; Wed,  6 Sep 2023 06:00:38 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36BBE86553
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 06:00:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-58cbdf3eecaso30771667b3.0
 for <u-boot@lists.denx.de>; Tue, 05 Sep 2023 21:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693972834; x=1694577634; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AsL93w0JohuxWulQ84FPpRM9tCMtvR9c9+Dc+Wa9pdw=;
 b=nqrWtGa96Nt9yHli4XeAbDqf81q89l458Hy1IJJH15ms7rfE3TODSxyoxX4ur5VB+P
 jWYs8UIdRVejUKbihTwV9WltXjwN0SzCUfG9lqYk0vqDXVh8VA3vVkN+mFpWjK+HsziC
 mKOmPYAeXd3RM6ns+c8V9+x5+tJec/hfbVxy7YmYznVlhTJeB/jUmoqY7Gwbr3/uimUe
 2aSBCKwurJccyfw2zsxIY3MM67v037vTWPC5Jc99I0J9QmBXL4sjCT58h8dKBZhDj+VZ
 N8dPmr6s6K5WJiifYgwtMMXEeQekEXBb+Ks7OadJOWCqTDsVhFymvbjJzbItlmnxNedg
 lamA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693972834; x=1694577634;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AsL93w0JohuxWulQ84FPpRM9tCMtvR9c9+Dc+Wa9pdw=;
 b=Q/ockfKY+4UVYVhhBItSgiTspkJa2J7wOuoDL+0KqGnVHxCvzytbMsyW/ez/arx6OZ
 JEd/zhrB4O4EGM1R5l7rCytGypBqoDhcKB3EE7cTw5IjJi9SQ94OyNksanSFbP5fcziP
 gbFkI+mZbQqtRtwFoPWqbOiq8ahjFV7YhG6c7fB9/PAB4Tmb2EJD/acVgFQAE6xdndcm
 4XGZI9pjV9OBHfOVXdhXCIkxT5Ah2UQ+0zHBzh73VqQnhavtxSSnWiJnE6wZMu6Vl64/
 jt42LCb9oI/QNwzN9BRBpzO+8SXryVixe1F8WXP4igWnehZYsXcskVtmHO03xnixfSNz
 Ix9g==
X-Gm-Message-State: AOJu0YxU+bq4OIScMEhCrDsEubqB0VuPn1+ZQLKNVmgGft9Fn9/XxvH0
 eeIQhSTWmH43Drsaz1ISE7Q=
X-Google-Smtp-Source: AGHT+IEGqX3h+CF93VIR1sHCwfGwAya00aMFmnrdx79/da8D24z1JM4mWX2Fad+lB0yNmp3UXVIY+A==
X-Received: by 2002:a0d:d747:0:b0:592:264c:a88c with SMTP id
 z68-20020a0dd747000000b00592264ca88cmr16949960ywd.18.1693972833808; 
 Tue, 05 Sep 2023 21:00:33 -0700 (PDT)
Received: from localhost.localdomain
 (76-229-100-169.lightspeed.irvnca.sbcglobal.net. [76.229.100.169])
 by smtp.gmail.com with ESMTPSA id
 t144-20020a0dea96000000b005839a780c29sm3510214ywe.102.2023.09.05.21.00.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Sep 2023 21:00:33 -0700 (PDT)
From: Tony Dinh <mibodhi@gmail.com>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>,
 Tony Dinh <mibodhi@gmail.com>
Subject: [PATCH] bootstd: sata: Add bootstd support for ahci sata
Date: Tue,  5 Sep 2023 21:00:02 -0700
Message-Id: <20230906040002.19267-1-mibodhi@gmail.com>
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

 drivers/ata/Makefile       |  1 +
 drivers/ata/sata.c         | 25 +++++++++++++++
 drivers/ata/sata_bootdev.c | 62 ++++++++++++++++++++++++++++++++++++++
 include/sata.h             |  1 +
 4 files changed, 89 insertions(+)
 create mode 100644 drivers/ata/sata_bootdev.c

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

