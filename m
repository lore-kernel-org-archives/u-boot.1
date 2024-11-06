Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17B4CD59F5F
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 00:52:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B98C08903B;
	Thu,  7 Nov 2024 01:52:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="YS+IA+zn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A3E1891BC; Wed,  6 Nov 2024 22:04:02 +0100 (CET)
Received: from mail-il1-x164.google.com (mail-il1-x164.google.com
 [IPv6:2607:f8b0:4864:20::164])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59BF688E63
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 22:03:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=broadcom.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=dregan@broadcom.com
Received: by mail-il1-x164.google.com with SMTP id
 e9e14a558f8ab-3a39354ffaeso182965ab.1
 for <u-boot@lists.denx.de>; Wed, 06 Nov 2024 13:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1730927038; x=1731531838; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ghLTMxbYkqztNQNmTwrg7ZEAtBBzC1AEL0tlWQOd9HI=;
 b=YS+IA+znNrSjrb1XgnIZaKPI+l+As93cO76p+ALcQ8Z3PnT6DBaDVUXjbNgeaJ8nna
 zYB4Caz9WIw1TqEsjVfNJZ57F5WRE0AGIfDWR2CzME43SIe3YOSEwOfSgRGnNBGT5+hh
 0JLUlNmFman3wW4/ATblc3+ecxXQAaBfxU2G4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730927038; x=1731531838;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ghLTMxbYkqztNQNmTwrg7ZEAtBBzC1AEL0tlWQOd9HI=;
 b=n1P+MLUQcs/aVPl8vKbZM+WTf/gcHbJFkZ9RbJh8qxnho09kruIi5oOELgozV/MovP
 IGBwZhOyUsxe0UiG0ji3qVUpxXOYWq0gw81/IJjndqExW1sIamsvMX++wFhfUPO+2s+E
 rSfUhpCbE4coAVuzSvn5AfdCe9EZM1o+F+niK/YQwBkuysT7abCABR6QeobN+EK47qq/
 l03tsmaiFcseSqe+TQDPFz4gmC2iRV2IB/FWZIcM9k7mEhE6rLnEE04ObGOulOIWAPeC
 U+nBKmaEcMf7gdGAyi39nhXqcMlq0YJsHfQ/iYB8HRz8uofwxNWpc+IA2e/GkltAOsHU
 pkUA==
X-Gm-Message-State: AOJu0YzoYQN78xtXEyyj0gbaYzeAU9Knt5PVsmW0ASxm4cGn1IucugDq
 hGYwmaI9Ir46IAScLVsWs0FEvXBDFZgaHL9wPrrOBVeTRTTJHYBVhbtIyiuceQUrOgFvDVE47Fh
 K0AlTxo4CICmvwZR+sccuYiB9GoiEMBNAJ9Z1WasmdplY6oAERxj2b1MNtlMCbaewZEEFIUCSfU
 6rEviZ9t33RFedPguHnJ85+rmCV9t0twmBMsh3R+Ui9Rees5/0E9h5QWZW1oHnBw+ZA7QP
X-Google-Smtp-Source: AGHT+IFEZyUA+9w643Mc0hFRIZ1kwZTZxm60raDCqlwXZR9/jm7IhKb+M6BOGRC/OL0InqZeOIeHCuq3Bwl6
X-Received: by 2002:a05:6e02:1a08:b0:3a6:ca38:6873 with SMTP id
 e9e14a558f8ab-3a6e8440f97mr3119275ab.2.1730927038026; 
 Wed, 06 Nov 2024 13:03:58 -0800 (PST)
Received: from bcacpedev-irv-3.lvn.broadcom.net ([192.19.161.250])
 by smtp-relay.gmail.com with ESMTPS id
 e9e14a558f8ab-3a6a9a29b37sm8165005ab.71.2024.11.06.13.03.56
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 06 Nov 2024 13:03:58 -0800 (PST)
X-Relaying-Domain: broadcom.com
From: david regan <dregan@broadcom.com>
To: u-boot <u-boot@lists.denx.de>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Anand Gore <anand.gore@broadcom.com>,
 William Zhang <william.zhang@broadcom.com>,
 Kursad Oney <kursad.oney@broadcom.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Kamal Dasu <kamal.dasu@broadcom.com>, David Regan <dregan@broadcom.com>,
 David Regan <dregan@mail.com>, Tom Rini <trini@konsulko.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 1/4] mtd: nand: brcmnand: remove device specific nand driver
 files
Date: Wed,  6 Nov 2024 13:03:45 -0800
Message-Id: <20241106210348.218507-2-dregan@broadcom.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20241106210348.218507-1-dregan@broadcom.com>
References: <20241106210348.218507-1-dregan@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 07 Nov 2024 01:52:42 +0100
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

These device specific nand driver files can be removed because
they are now replaced by a common driver bcmbca_nand.c

Signed-off-by: david regan <dregan@broadcom.com>
---
 drivers/mtd/nand/raw/Kconfig                  |  24 ----
 drivers/mtd/nand/raw/brcmnand/Makefile        |   4 -
 drivers/mtd/nand/raw/brcmnand/bcm63158_nand.c | 125 ------------------
 drivers/mtd/nand/raw/brcmnand/bcm6753_nand.c  | 123 -----------------
 drivers/mtd/nand/raw/brcmnand/bcm68360_nand.c | 124 -----------------
 drivers/mtd/nand/raw/brcmnand/bcm6858_nand.c  | 125 ------------------
 6 files changed, 525 deletions(-)
 delete mode 100644 drivers/mtd/nand/raw/brcmnand/bcm63158_nand.c
 delete mode 100644 drivers/mtd/nand/raw/brcmnand/bcm6753_nand.c
 delete mode 100644 drivers/mtd/nand/raw/brcmnand/bcm68360_nand.c
 delete mode 100644 drivers/mtd/nand/raw/brcmnand/bcm6858_nand.c

diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index c345fc1f1fba..609bdffbf779 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -133,36 +133,12 @@ config NAND_BRCMNAND_6368
 	help
 	  Enable support for broadcom nand driver on bcm6368.
 
-config NAND_BRCMNAND_6753
-	bool "Support Broadcom NAND controller on bcm6753"
-	depends on NAND_BRCMNAND && BCM6855
-	help
-	  Enable support for broadcom nand driver on bcm6753.
-
-config NAND_BRCMNAND_68360
-	bool "Support Broadcom NAND controller on bcm68360"
-	depends on NAND_BRCMNAND && BCM6856
-	help
-	  Enable support for broadcom nand driver on bcm68360.
-
 config NAND_BRCMNAND_6838
 	bool "Support Broadcom NAND controller on bcm6838"
 	depends on NAND_BRCMNAND && ARCH_BMIPS && SOC_BMIPS_BCM6838
 	help
 	  Enable support for broadcom nand driver on bcm6838.
 
-config NAND_BRCMNAND_6858
-	bool "Support Broadcom NAND controller on bcm6858"
-	depends on NAND_BRCMNAND && BCM6858
-	help
-	  Enable support for broadcom nand driver on bcm6858.
-
-config NAND_BRCMNAND_63158
-	bool "Support Broadcom NAND controller on bcm63158"
-	depends on NAND_BRCMNAND && BCM63158
-	help
-	  Enable support for broadcom nand driver on bcm63158.
-
 config NAND_BRCMNAND_IPROC
 	bool "Support Broadcom NAND controller on the iproc family"
 	depends on NAND_BRCMNAND
diff --git a/drivers/mtd/nand/raw/brcmnand/Makefile b/drivers/mtd/nand/raw/brcmnand/Makefile
index 24d0d5684490..4fba5c1c7e3d 100644
--- a/drivers/mtd/nand/raw/brcmnand/Makefile
+++ b/drivers/mtd/nand/raw/brcmnand/Makefile
@@ -1,11 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0+
 
 obj-$(CONFIG_NAND_BRCMNAND_6368) += bcm6368_nand.o
-obj-$(CONFIG_NAND_BRCMNAND_63158) += bcm63158_nand.o
-obj-$(CONFIG_NAND_BRCMNAND_6753) += bcm6753_nand.o
-obj-$(CONFIG_NAND_BRCMNAND_68360) += bcm68360_nand.o
 obj-$(CONFIG_NAND_BRCMNAND_6838) += bcm6838_nand.o
-obj-$(CONFIG_NAND_BRCMNAND_6858) += bcm6858_nand.o
 obj-$(CONFIG_NAND_BRCMNAND_BCMBCA) += bcmbca_nand.o
 obj-$(CONFIG_NAND_BRCMNAND_IPROC) += iproc_nand.o
 obj-$(CONFIG_NAND_BRCMNAND) += brcmnand.o
diff --git a/drivers/mtd/nand/raw/brcmnand/bcm63158_nand.c b/drivers/mtd/nand/raw/brcmnand/bcm63158_nand.c
deleted file mode 100644
index 3f59fbbbb8f1..000000000000
--- a/drivers/mtd/nand/raw/brcmnand/bcm63158_nand.c
+++ /dev/null
@@ -1,125 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-
-#include <asm/io.h>
-#include <memalign.h>
-#include <nand.h>
-#include <linux/bitops.h>
-#include <linux/err.h>
-#include <linux/errno.h>
-#include <linux/io.h>
-#include <linux/ioport.h>
-#include <dm.h>
-#include <linux/printk.h>
-
-#include "brcmnand.h"
-
-struct bcm63158_nand_soc {
-	struct brcmnand_soc soc;
-	void __iomem *base;
-};
-
-#define BCM63158_NAND_INT		0x00
-#define BCM63158_NAND_STATUS_SHIFT	0
-#define BCM63158_NAND_STATUS_MASK	(0xfff << BCM63158_NAND_STATUS_SHIFT)
-
-#define BCM63158_NAND_INT_EN		0x04
-#define BCM63158_NAND_ENABLE_SHIFT	0
-#define BCM63158_NAND_ENABLE_MASK	(0xffff << BCM63158_NAND_ENABLE_SHIFT)
-
-enum {
-	BCM63158_NP_READ		= BIT(0),
-	BCM63158_BLOCK_ERASE	= BIT(1),
-	BCM63158_COPY_BACK	= BIT(2),
-	BCM63158_PAGE_PGM	= BIT(3),
-	BCM63158_CTRL_READY	= BIT(4),
-	BCM63158_DEV_RBPIN	= BIT(5),
-	BCM63158_ECC_ERR_UNC	= BIT(6),
-	BCM63158_ECC_ERR_CORR	= BIT(7),
-};
-
-static bool bcm63158_nand_intc_ack(struct brcmnand_soc *soc)
-{
-	struct bcm63158_nand_soc *priv =
-			container_of(soc, struct bcm63158_nand_soc, soc);
-	void __iomem *mmio = priv->base + BCM63158_NAND_INT;
-	u32 val = brcmnand_readl(mmio);
-
-	if (val & (BCM63158_CTRL_READY << BCM63158_NAND_STATUS_SHIFT)) {
-		/* Ack interrupt */
-		val &= ~BCM63158_NAND_STATUS_MASK;
-		val |= BCM63158_CTRL_READY << BCM63158_NAND_STATUS_SHIFT;
-		brcmnand_writel(val, mmio);
-		return true;
-	}
-
-	return false;
-}
-
-static void bcm63158_nand_intc_set(struct brcmnand_soc *soc, bool en)
-{
-	struct bcm63158_nand_soc *priv =
-			container_of(soc, struct bcm63158_nand_soc, soc);
-	void __iomem *mmio = priv->base + BCM63158_NAND_INT_EN;
-	u32 val = brcmnand_readl(mmio);
-
-	/* Don't ack any interrupts */
-	val &= ~BCM63158_NAND_STATUS_MASK;
-
-	if (en)
-		val |= BCM63158_CTRL_READY << BCM63158_NAND_ENABLE_SHIFT;
-	else
-		val &= ~(BCM63158_CTRL_READY << BCM63158_NAND_ENABLE_SHIFT);
-
-	brcmnand_writel(val, mmio);
-}
-
-static int bcm63158_nand_probe(struct udevice *dev)
-{
-	struct udevice *pdev = dev;
-	struct bcm63158_nand_soc *priv = dev_get_priv(dev);
-	struct brcmnand_soc *soc;
-	struct resource res;
-
-	soc = &priv->soc;
-
-	dev_read_resource_byname(pdev, "nand-int-base", &res);
-	priv->base = devm_ioremap(dev, res.start, resource_size(&res));
-	if (IS_ERR(priv->base))
-		return PTR_ERR(priv->base);
-
-	soc->ctlrdy_ack = bcm63158_nand_intc_ack;
-	soc->ctlrdy_set_enabled = bcm63158_nand_intc_set;
-
-	/* Disable and ack all interrupts  */
-	brcmnand_writel(0, priv->base + BCM63158_NAND_INT_EN);
-	brcmnand_writel(0, priv->base + BCM63158_NAND_INT);
-
-	return brcmnand_probe(pdev, soc);
-}
-
-static const struct udevice_id bcm63158_nand_dt_ids[] = {
-	{
-		.compatible = "brcm,nand-bcm63158",
-	},
-	{ /* sentinel */ }
-};
-
-U_BOOT_DRIVER(bcm63158_nand) = {
-	.name = "bcm63158-nand",
-	.id = UCLASS_MTD,
-	.of_match = bcm63158_nand_dt_ids,
-	.probe = bcm63158_nand_probe,
-	.priv_auto	= sizeof(struct bcm63158_nand_soc),
-};
-
-void board_nand_init(void)
-{
-	struct udevice *dev;
-	int ret;
-
-	ret = uclass_get_device_by_driver(UCLASS_MTD,
-					  DM_DRIVER_GET(bcm63158_nand), &dev);
-	if (ret && ret != -ENODEV)
-		pr_err("Failed to initialize %s. (error %d)\n", dev->name,
-		       ret);
-}
diff --git a/drivers/mtd/nand/raw/brcmnand/bcm6753_nand.c b/drivers/mtd/nand/raw/brcmnand/bcm6753_nand.c
deleted file mode 100644
index a101222a28fa..000000000000
--- a/drivers/mtd/nand/raw/brcmnand/bcm6753_nand.c
+++ /dev/null
@@ -1,123 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-
-#include <asm/io.h>
-#include <memalign.h>
-#include <nand.h>
-#include <linux/bitops.h>
-#include <linux/errno.h>
-#include <linux/io.h>
-#include <linux/ioport.h>
-#include <dm.h>
-
-#include "brcmnand.h"
-
-struct bcm6753_nand_soc {
-	struct brcmnand_soc soc;
-	void __iomem *base;
-};
-
-#define BCM6753_NAND_INT		0x00
-#define BCM6753_NAND_STATUS_SHIFT	0
-#define BCM6753_NAND_STATUS_MASK	(0xfff << BCM6753_NAND_STATUS_SHIFT)
-
-#define BCM6753_NAND_INT_EN		0x04
-#define BCM6753_NAND_ENABLE_SHIFT	0
-#define BCM6753_NAND_ENABLE_MASK	(0xffff << BCM6753_NAND_ENABLE_SHIFT)
-
-enum {
-	BCM6753_NP_READ		= BIT(0),
-	BCM6753_BLOCK_ERASE	= BIT(1),
-	BCM6753_COPY_BACK	= BIT(2),
-	BCM6753_PAGE_PGM	= BIT(3),
-	BCM6753_CTRL_READY	= BIT(4),
-	BCM6753_DEV_RBPIN	= BIT(5),
-	BCM6753_ECC_ERR_UNC	= BIT(6),
-	BCM6753_ECC_ERR_CORR	= BIT(7),
-};
-
-static bool bcm6753_nand_intc_ack(struct brcmnand_soc *soc)
-{
-	struct bcm6753_nand_soc *priv =
-			container_of(soc, struct bcm6753_nand_soc, soc);
-	void __iomem *mmio = priv->base + BCM6753_NAND_INT;
-	u32 val = brcmnand_readl(mmio);
-
-	if (val & (BCM6753_CTRL_READY << BCM6753_NAND_STATUS_SHIFT)) {
-		/* Ack interrupt */
-		val &= ~BCM6753_NAND_STATUS_MASK;
-		val |= BCM6753_CTRL_READY << BCM6753_NAND_STATUS_SHIFT;
-		brcmnand_writel(val, mmio);
-		return true;
-	}
-
-	return false;
-}
-
-static void bcm6753_nand_intc_set(struct brcmnand_soc *soc, bool en)
-{
-	struct bcm6753_nand_soc *priv =
-			container_of(soc, struct bcm6753_nand_soc, soc);
-	void __iomem *mmio = priv->base + BCM6753_NAND_INT_EN;
-	u32 val = brcmnand_readl(mmio);
-
-	/* Don't ack any interrupts */
-	val &= ~BCM6753_NAND_STATUS_MASK;
-
-	if (en)
-		val |= BCM6753_CTRL_READY << BCM6753_NAND_ENABLE_SHIFT;
-	else
-		val &= ~(BCM6753_CTRL_READY << BCM6753_NAND_ENABLE_SHIFT);
-
-	brcmnand_writel(val, mmio);
-}
-
-static int bcm6753_nand_probe(struct udevice *dev)
-{
-	struct udevice *pdev = dev;
-	struct bcm6753_nand_soc *priv = dev_get_priv(dev);
-	struct brcmnand_soc *soc;
-	struct resource res;
-
-	soc = &priv->soc;
-
-	dev_read_resource_byname(pdev, "nand-int-base", &res);
-	priv->base = devm_ioremap(dev, res.start, resource_size(&res));
-	if (IS_ERR(priv->base))
-		return PTR_ERR(priv->base);
-
-	soc->ctlrdy_ack = bcm6753_nand_intc_ack;
-	soc->ctlrdy_set_enabled = bcm6753_nand_intc_set;
-
-	/* Disable and ack all interrupts  */
-	brcmnand_writel(0, priv->base + BCM6753_NAND_INT_EN);
-	brcmnand_writel(0, priv->base + BCM6753_NAND_INT);
-
-	return brcmnand_probe(pdev, soc);
-}
-
-static const struct udevice_id bcm6753_nand_dt_ids[] = {
-	{
-		.compatible = "brcm,nand-bcm6753",
-	},
-	{ /* sentinel */ }
-};
-
-U_BOOT_DRIVER(bcm6753_nand) = {
-	.name = "bcm6753-nand",
-	.id = UCLASS_MTD,
-	.of_match = bcm6753_nand_dt_ids,
-	.probe = bcm6753_nand_probe,
-	.priv_auto = sizeof(struct bcm6753_nand_soc),
-};
-
-void board_nand_init(void)
-{
-	struct udevice *dev;
-	int ret;
-
-	ret = uclass_get_device_by_driver(UCLASS_MTD,
-					  DM_DRIVER_GET(bcm6753_nand), &dev);
-	if (ret && ret != -ENODEV)
-		pr_err("Failed to initialize %s. (error %d)\n", dev->name,
-		       ret);
-}
diff --git a/drivers/mtd/nand/raw/brcmnand/bcm68360_nand.c b/drivers/mtd/nand/raw/brcmnand/bcm68360_nand.c
deleted file mode 100644
index 385642d0c091..000000000000
--- a/drivers/mtd/nand/raw/brcmnand/bcm68360_nand.c
+++ /dev/null
@@ -1,124 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-
-#include <asm/io.h>
-#include <memalign.h>
-#include <nand.h>
-#include <linux/bitops.h>
-#include <linux/errno.h>
-#include <linux/io.h>
-#include <linux/ioport.h>
-#include <dm.h>
-#include <linux/printk.h>
-
-#include "brcmnand.h"
-
-struct bcm68360_nand_soc {
-	struct brcmnand_soc soc;
-	void __iomem *base;
-};
-
-#define BCM68360_NAND_INT		0x00
-#define BCM68360_NAND_STATUS_SHIFT	0
-#define BCM68360_NAND_STATUS_MASK	(0xfff << BCM68360_NAND_STATUS_SHIFT)
-
-#define BCM68360_NAND_INT_EN		0x04
-#define BCM68360_NAND_ENABLE_SHIFT	0
-#define BCM68360_NAND_ENABLE_MASK	(0xffff << BCM68360_NAND_ENABLE_SHIFT)
-
-enum {
-	BCM68360_NP_READ		= BIT(0),
-	BCM68360_BLOCK_ERASE	= BIT(1),
-	BCM68360_COPY_BACK	= BIT(2),
-	BCM68360_PAGE_PGM	= BIT(3),
-	BCM68360_CTRL_READY	= BIT(4),
-	BCM68360_DEV_RBPIN	= BIT(5),
-	BCM68360_ECC_ERR_UNC	= BIT(6),
-	BCM68360_ECC_ERR_CORR	= BIT(7),
-};
-
-static bool bcm68360_nand_intc_ack(struct brcmnand_soc *soc)
-{
-	struct bcm68360_nand_soc *priv =
-			container_of(soc, struct bcm68360_nand_soc, soc);
-	void __iomem *mmio = priv->base + BCM68360_NAND_INT;
-	u32 val = brcmnand_readl(mmio);
-
-	if (val & (BCM68360_CTRL_READY << BCM68360_NAND_STATUS_SHIFT)) {
-		/* Ack interrupt */
-		val &= ~BCM68360_NAND_STATUS_MASK;
-		val |= BCM68360_CTRL_READY << BCM68360_NAND_STATUS_SHIFT;
-		brcmnand_writel(val, mmio);
-		return true;
-	}
-
-	return false;
-}
-
-static void bcm68360_nand_intc_set(struct brcmnand_soc *soc, bool en)
-{
-	struct bcm68360_nand_soc *priv =
-			container_of(soc, struct bcm68360_nand_soc, soc);
-	void __iomem *mmio = priv->base + BCM68360_NAND_INT_EN;
-	u32 val = brcmnand_readl(mmio);
-
-	/* Don't ack any interrupts */
-	val &= ~BCM68360_NAND_STATUS_MASK;
-
-	if (en)
-		val |= BCM68360_CTRL_READY << BCM68360_NAND_ENABLE_SHIFT;
-	else
-		val &= ~(BCM68360_CTRL_READY << BCM68360_NAND_ENABLE_SHIFT);
-
-	brcmnand_writel(val, mmio);
-}
-
-static int bcm68360_nand_probe(struct udevice *dev)
-{
-	struct udevice *pdev = dev;
-	struct bcm68360_nand_soc *priv = dev_get_priv(dev);
-	struct brcmnand_soc *soc;
-	struct resource res;
-
-	soc = &priv->soc;
-
-	dev_read_resource_byname(pdev, "nand-int-base", &res);
-	priv->base = devm_ioremap(dev, res.start, resource_size(&res));
-	if (IS_ERR(priv->base))
-		return PTR_ERR(priv->base);
-
-	soc->ctlrdy_ack = bcm68360_nand_intc_ack;
-	soc->ctlrdy_set_enabled = bcm68360_nand_intc_set;
-
-	/* Disable and ack all interrupts  */
-	brcmnand_writel(0, priv->base + BCM68360_NAND_INT_EN);
-	brcmnand_writel(0, priv->base + BCM68360_NAND_INT);
-
-	return brcmnand_probe(pdev, soc);
-}
-
-static const struct udevice_id bcm68360_nand_dt_ids[] = {
-	{
-		.compatible = "brcm,nand-bcm68360",
-	},
-	{ /* sentinel */ }
-};
-
-U_BOOT_DRIVER(bcm68360_nand) = {
-	.name = "bcm68360-nand",
-	.id = UCLASS_MTD,
-	.of_match = bcm68360_nand_dt_ids,
-	.probe = bcm68360_nand_probe,
-	.priv_auto	= sizeof(struct bcm68360_nand_soc),
-};
-
-void board_nand_init(void)
-{
-	struct udevice *dev;
-	int ret;
-
-	ret = uclass_get_device_by_driver(UCLASS_MTD,
-					  DM_DRIVER_GET(bcm68360_nand), &dev);
-	if (ret && ret != -ENODEV)
-		pr_err("Failed to initialize %s. (error %d)\n", dev->name,
-		       ret);
-}
diff --git a/drivers/mtd/nand/raw/brcmnand/bcm6858_nand.c b/drivers/mtd/nand/raw/brcmnand/bcm6858_nand.c
deleted file mode 100644
index 564c678c9ef2..000000000000
--- a/drivers/mtd/nand/raw/brcmnand/bcm6858_nand.c
+++ /dev/null
@@ -1,125 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-
-#include <asm/io.h>
-#include <memalign.h>
-#include <nand.h>
-#include <linux/bitops.h>
-#include <linux/err.h>
-#include <linux/errno.h>
-#include <linux/io.h>
-#include <linux/ioport.h>
-#include <dm.h>
-#include <linux/printk.h>
-
-#include "brcmnand.h"
-
-struct bcm6858_nand_soc {
-	struct brcmnand_soc soc;
-	void __iomem *base;
-};
-
-#define BCM6858_NAND_INT		0x00
-#define BCM6858_NAND_STATUS_SHIFT	0
-#define BCM6858_NAND_STATUS_MASK	(0xfff << BCM6858_NAND_STATUS_SHIFT)
-
-#define BCM6858_NAND_INT_EN		0x04
-#define BCM6858_NAND_ENABLE_SHIFT	0
-#define BCM6858_NAND_ENABLE_MASK	(0xffff << BCM6858_NAND_ENABLE_SHIFT)
-
-enum {
-	BCM6858_NP_READ		= BIT(0),
-	BCM6858_BLOCK_ERASE	= BIT(1),
-	BCM6858_COPY_BACK	= BIT(2),
-	BCM6858_PAGE_PGM	= BIT(3),
-	BCM6858_CTRL_READY	= BIT(4),
-	BCM6858_DEV_RBPIN	= BIT(5),
-	BCM6858_ECC_ERR_UNC	= BIT(6),
-	BCM6858_ECC_ERR_CORR	= BIT(7),
-};
-
-static bool bcm6858_nand_intc_ack(struct brcmnand_soc *soc)
-{
-	struct bcm6858_nand_soc *priv =
-			container_of(soc, struct bcm6858_nand_soc, soc);
-	void __iomem *mmio = priv->base + BCM6858_NAND_INT;
-	u32 val = brcmnand_readl(mmio);
-
-	if (val & (BCM6858_CTRL_READY << BCM6858_NAND_STATUS_SHIFT)) {
-		/* Ack interrupt */
-		val &= ~BCM6858_NAND_STATUS_MASK;
-		val |= BCM6858_CTRL_READY << BCM6858_NAND_STATUS_SHIFT;
-		brcmnand_writel(val, mmio);
-		return true;
-	}
-
-	return false;
-}
-
-static void bcm6858_nand_intc_set(struct brcmnand_soc *soc, bool en)
-{
-	struct bcm6858_nand_soc *priv =
-			container_of(soc, struct bcm6858_nand_soc, soc);
-	void __iomem *mmio = priv->base + BCM6858_NAND_INT_EN;
-	u32 val = brcmnand_readl(mmio);
-
-	/* Don't ack any interrupts */
-	val &= ~BCM6858_NAND_STATUS_MASK;
-
-	if (en)
-		val |= BCM6858_CTRL_READY << BCM6858_NAND_ENABLE_SHIFT;
-	else
-		val &= ~(BCM6858_CTRL_READY << BCM6858_NAND_ENABLE_SHIFT);
-
-	brcmnand_writel(val, mmio);
-}
-
-static int bcm6858_nand_probe(struct udevice *dev)
-{
-	struct udevice *pdev = dev;
-	struct bcm6858_nand_soc *priv = dev_get_priv(dev);
-	struct brcmnand_soc *soc;
-	struct resource res;
-
-	soc = &priv->soc;
-
-	dev_read_resource_byname(pdev, "nand-int-base", &res);
-	priv->base = devm_ioremap(dev, res.start, resource_size(&res));
-	if (IS_ERR(priv->base))
-		return PTR_ERR(priv->base);
-
-	soc->ctlrdy_ack = bcm6858_nand_intc_ack;
-	soc->ctlrdy_set_enabled = bcm6858_nand_intc_set;
-
-	/* Disable and ack all interrupts  */
-	brcmnand_writel(0, priv->base + BCM6858_NAND_INT_EN);
-	brcmnand_writel(0, priv->base + BCM6858_NAND_INT);
-
-	return brcmnand_probe(pdev, soc);
-}
-
-static const struct udevice_id bcm6858_nand_dt_ids[] = {
-	{
-		.compatible = "brcm,nand-bcm6858",
-	},
-	{ /* sentinel */ }
-};
-
-U_BOOT_DRIVER(bcm6858_nand) = {
-	.name = "bcm6858-nand",
-	.id = UCLASS_MTD,
-	.of_match = bcm6858_nand_dt_ids,
-	.probe = bcm6858_nand_probe,
-	.priv_auto	= sizeof(struct bcm6858_nand_soc),
-};
-
-void board_nand_init(void)
-{
-	struct udevice *dev;
-	int ret;
-
-	ret = uclass_get_device_by_driver(UCLASS_MTD,
-					  DM_DRIVER_GET(bcm6858_nand), &dev);
-	if (ret && ret != -ENODEV)
-		pr_err("Failed to initialize %s. (error %d)\n", dev->name,
-		       ret);
-}
-- 
2.37.3

