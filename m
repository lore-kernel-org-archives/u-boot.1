Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D56FFD0D79F
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 14:50:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2EF38936A;
	Fri, 11 Oct 2024 16:50:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xtHTadky";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EF0C8936A; Fri, 11 Oct 2024 16:50:01 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF562892F8
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 16:49:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linus.walleij@linaro.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5c89e66012aso2981838a12.2
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 07:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728658198; x=1729262998; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PPMQ77CzsI908RmYEkGH9OurPrHcLN6r8qHnSlgAoQg=;
 b=xtHTadkyHorsolfZc0ELlZCZC1Mv/6vUarIX/66QgTF9OEEsLdcycIrxgDISQavVcH
 c+2ZdkC4ooX1QKLg2C/RoM3Kw7zzAUlHUiu6fatNtEMbLvUGeLHX6haw6pd7yYw6Uky1
 C60LhlP6lpLJ2Iy5OcM4b5W+zTN03Q1yrrTYbdOdsBZSRFLu8U+RSbnMRf5pr2DZUbEj
 upEqDxZPXvAYqABpLCWu7ziWPXoDB4Lwek+bBOGyIVHmX3yfT9FasuSP7tVXzZCfXVAD
 Y+gtktZuqqjAAIg7ih5zeLMQ57r/EgMpNqRsQK4niNj4FipvZNyXL88UnA2kUxnqLzu8
 NbXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728658198; x=1729262998;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PPMQ77CzsI908RmYEkGH9OurPrHcLN6r8qHnSlgAoQg=;
 b=tsF9zdktLIqObfcG72jknl7fvyoZMxtibTLMscBUxEMKS/Dsafjtrvs98fbg6G76Pm
 UADGuw3Gu097xVbxGxRgJexXqeXCmG97BF3Cu1naCfpVKdOzx+YWOkvq9aV7LDvHnrA9
 P2FT9TYiFO8BTudLiJGfQtURskhSjG87NpRXpsPJNVPNpz9Fln5siKtcvKrYSQdEL6zU
 1JlZ7xziCCjD4yclZ1LTcy2tmbER36GvtpsCJ4TlxLiGshd7dan9VJOVYuHuoVXeH70x
 gevhy6CiWSKnMNqTvRvDkG7y5GB9VoHTFRvs6JaAb9EP9CN/I8k7RYVafb+iKef+D85I
 Vhdw==
X-Gm-Message-State: AOJu0YzglP98KuhTyJ5/iG/DY2+XjpZAZm5MkwPXd8rz3fGXq7t1Off3
 cLB1Z1J84lrdAaVWqrtEYKQ/VcbNw1hAaMhM/fGKwqRFxsvN9YHYlrbKCKkkDsE=
X-Google-Smtp-Source: AGHT+IEsrbcJ+XZoGki0qWtd7aB5whYp9rPTAFjCnsf4/kgesT/nTy0gbAWI9dXfyrQ729/RIqKgFA==
X-Received: by 2002:a05:6402:5c9:b0:5c8:a0fd:63d6 with SMTP id
 4fb4d7f45d1cf-5c948d24835mr2056879a12.20.1728658198217; 
 Fri, 11 Oct 2024 07:49:58 -0700 (PDT)
Received: from lino.lan ([85.235.12.238]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c9372940e3sm2006113a12.81.2024.10.11.07.49.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 07:49:56 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 11 Oct 2024 16:49:54 +0200
Subject: [PATCH v2 1/4] mtd: rawnand: brcmnand: Add BCMBCA RAW NAND driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-bcmbca-nand-support-v2-1-1fe928e5b933@linaro.org>
References: <20241011-bcmbca-nand-support-v2-0-1fe928e5b933@linaro.org>
In-Reply-To: <20241011-bcmbca-nand-support-v2-0-1fe928e5b933@linaro.org>
To: u-boot@lists.denx.de, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Anand Gore <anand.gore@broadcom.com>, 
 William Zhang <william.zhang@broadcom.com>, 
 Kursad Oney <kursad.oney@broadcom.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.14.0
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

The Broadcom BCA platforms are broadband access SoCs.
This is a port of the upstream Linux driver to U-Boot.
It was based on drivers/mtd/nand/raw/brcmnand/bcmbca_nand.c
from Linux v6.11.

Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mtd/nand/raw/Kconfig                |   7 ++
 drivers/mtd/nand/raw/brcmnand/Makefile      |   1 +
 drivers/mtd/nand/raw/brcmnand/bcmbca_nand.c | 152 ++++++++++++++++++++++++++++
 3 files changed, 160 insertions(+)

diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index 9f3f1267cbd1..c345fc1f1fba 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -120,6 +120,13 @@ config NAND_BRCMNAND
 	  Enable the driver for NAND flash on platforms using a Broadcom NAND
 	  controller.
 
+config NAND_BRCMNAND_BCMBCA
+	bool "Support Broadcom NAND controller on BCMBCA platforms"
+	depends on NAND_BRCMNAND && ARCH_BCMBCA
+	help
+	  Enable support for broadcom nand driver on BCA (broadband
+	  access) platforms such as BCM6846.
+
 config NAND_BRCMNAND_6368
 	bool "Support Broadcom NAND controller on bcm6368"
 	depends on NAND_BRCMNAND && ARCH_BMIPS
diff --git a/drivers/mtd/nand/raw/brcmnand/Makefile b/drivers/mtd/nand/raw/brcmnand/Makefile
index 0c6325aaa618..24d0d5684490 100644
--- a/drivers/mtd/nand/raw/brcmnand/Makefile
+++ b/drivers/mtd/nand/raw/brcmnand/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_NAND_BRCMNAND_6753) += bcm6753_nand.o
 obj-$(CONFIG_NAND_BRCMNAND_68360) += bcm68360_nand.o
 obj-$(CONFIG_NAND_BRCMNAND_6838) += bcm6838_nand.o
 obj-$(CONFIG_NAND_BRCMNAND_6858) += bcm6858_nand.o
+obj-$(CONFIG_NAND_BRCMNAND_BCMBCA) += bcmbca_nand.o
 obj-$(CONFIG_NAND_BRCMNAND_IPROC) += iproc_nand.o
 obj-$(CONFIG_NAND_BRCMNAND) += brcmnand.o
 obj-$(CONFIG_NAND_BRCMNAND) += brcmnand_compat.o
diff --git a/drivers/mtd/nand/raw/brcmnand/bcmbca_nand.c b/drivers/mtd/nand/raw/brcmnand/bcmbca_nand.c
new file mode 100644
index 000000000000..2753783ae70f
--- /dev/null
+++ b/drivers/mtd/nand/raw/brcmnand/bcmbca_nand.c
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <asm/io.h>
+#include <memalign.h>
+#include <nand.h>
+#include <linux/bitops.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <dm.h>
+#include <linux/printk.h>
+
+#include "brcmnand.h"
+
+struct bcmbca_nand_soc {
+	struct brcmnand_soc soc;
+	void __iomem *base;
+};
+
+#define BCMBCA_NAND_INT			0x00
+#define BCMBCA_NAND_STATUS_SHIFT	0
+#define BCMBCA_NAND_STATUS_MASK		(0xfff << BCMBCA_NAND_STATUS_SHIFT)
+
+#define BCMBCA_NAND_INT_EN		0x04
+#define BCMBCA_NAND_ENABLE_SHIFT	0
+#define BCMBCA_NAND_ENABLE_MASK		(0xffff << BCMBCA_NAND_ENABLE_SHIFT)
+
+enum {
+	BCMBCA_NP_READ		= BIT(0),
+	BCMBCA_BLOCK_ERASE	= BIT(1),
+	BCMBCA_COPY_BACK	= BIT(2),
+	BCMBCA_PAGE_PGM		= BIT(3),
+	BCMBCA_CTRL_READY	= BIT(4),
+	BCMBCA_DEV_RBPIN	= BIT(5),
+	BCMBCA_ECC_ERR_UNC	= BIT(6),
+	BCMBCA_ECC_ERR_CORR	= BIT(7),
+};
+
+#if defined(CONFIG_ARM64)
+#define ALIGN_REQ		8
+#else
+#define ALIGN_REQ		4
+#endif
+
+static inline bool bcmbca_nand_is_buf_aligned(void *flash_cache,  void *buffer)
+{
+	return IS_ALIGNED((uintptr_t)buffer, ALIGN_REQ) &&
+				IS_ALIGNED((uintptr_t)flash_cache, ALIGN_REQ);
+}
+
+static bool bcmbca_nand_intc_ack(struct brcmnand_soc *soc)
+{
+	struct bcmbca_nand_soc *priv =
+			container_of(soc, struct bcmbca_nand_soc, soc);
+	void __iomem *mmio = priv->base + BCMBCA_NAND_INT;
+	u32 val = brcmnand_readl(mmio);
+
+	if (val & (BCMBCA_CTRL_READY << BCMBCA_NAND_STATUS_SHIFT)) {
+		/* Ack interrupt */
+		val &= ~BCMBCA_NAND_STATUS_MASK;
+		val |= BCMBCA_CTRL_READY << BCMBCA_NAND_STATUS_SHIFT;
+		brcmnand_writel(val, mmio);
+		return true;
+	}
+
+	return false;
+}
+
+static void bcmbca_nand_intc_set(struct brcmnand_soc *soc, bool en)
+{
+	struct bcmbca_nand_soc *priv =
+			container_of(soc, struct bcmbca_nand_soc, soc);
+	void __iomem *mmio = priv->base + BCMBCA_NAND_INT_EN;
+	u32 val = brcmnand_readl(mmio);
+
+	/* Don't ack any interrupts */
+	val &= ~BCMBCA_NAND_STATUS_MASK;
+
+	if (en)
+		val |= BCMBCA_CTRL_READY << BCMBCA_NAND_ENABLE_SHIFT;
+	else
+		val &= ~(BCMBCA_CTRL_READY << BCMBCA_NAND_ENABLE_SHIFT);
+
+	brcmnand_writel(val, mmio);
+}
+
+static void bcmbca_read_data_bus(struct brcmnand_soc *soc,
+				 void __iomem *flash_cache,  u32 *buffer, int fc_words)
+{
+	/*
+	 * memcpy can do unaligned aligned access depending on source
+	 * and dest address, which is incompatible with nand cache. Fallback
+	 * to the memcpy_fromio in such case
+	 */
+	if (bcmbca_nand_is_buf_aligned((void __force *)flash_cache, buffer))
+		memcpy((void *)buffer, (void __force *)flash_cache, fc_words * 4);
+	else
+		memcpy_fromio((void *)buffer, flash_cache, fc_words * 4);
+}
+
+static int bcmbca_nand_probe(struct udevice *dev)
+{
+	struct udevice *pdev = dev;
+	struct bcmbca_nand_soc *priv = dev_get_priv(dev);
+	struct brcmnand_soc *soc;
+	struct resource res;
+
+	soc = &priv->soc;
+
+	dev_read_resource_byname(pdev, "nand-int-base", &res);
+	priv->base = devm_ioremap(dev, res.start, resource_size(&res));
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	soc->ctlrdy_ack = bcmbca_nand_intc_ack;
+	soc->ctlrdy_set_enabled = bcmbca_nand_intc_set;
+	soc->read_data_bus = bcmbca_read_data_bus;
+
+	/* Disable and ack all interrupts  */
+	brcmnand_writel(0, priv->base + BCMBCA_NAND_INT_EN);
+	brcmnand_writel(0, priv->base + BCMBCA_NAND_INT);
+
+	return brcmnand_probe(pdev, soc);
+}
+
+static const struct udevice_id bcmbca_nand_dt_ids[] = {
+	{
+		.compatible = "brcm,nand-bcm63138",
+	},
+	{ /* sentinel */ }
+};
+
+U_BOOT_DRIVER(bcmbca_nand) = {
+	.name = "bcmbca-nand",
+	.id = UCLASS_MTD,
+	.of_match = bcmbca_nand_dt_ids,
+	.probe = bcmbca_nand_probe,
+	.priv_auto	= sizeof(struct bcmbca_nand_soc),
+};
+
+void board_nand_init(void)
+{
+	struct udevice *dev;
+	int ret;
+
+	ret = uclass_get_device_by_driver(UCLASS_MTD,
+					  DM_DRIVER_GET(bcmbca_nand), &dev);
+	if (ret && ret != -ENODEV)
+		pr_err("Failed to initialize %s. (error %d)\n", dev->name,
+		       ret);
+}

-- 
2.46.2

