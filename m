Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05E93CF5386
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 13:15:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0217892DC;
	Wed, 23 Oct 2024 15:15:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CmAkZCGK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DD7588F82; Wed, 23 Oct 2024 13:39:47 +0200 (CEST)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8881F88DEF
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 13:39:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcus.folkesson@gmail.com
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2fb4ec17f5cso63684011fa.3
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 04:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729683583; x=1730288383; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pVL+kIAv+h6r6joh1LnQinliL2vLQFoA5dlPlv0cm0Q=;
 b=CmAkZCGKgULb1t7bVVgcNG+2JhMZQoZN47hdA6pB/T5tWNbhpKR86ifuslRsJGIxbo
 bbHqLQU4C44GcGGBAlA3oSSFFPyvGboNQoK4Fvenwontnyw/R7NyXpQVGFgiLpYrvAou
 SynGEmrfsH4jS03YBkIdMR9QXaqH+boasoRitJPxLYWGZdDqmoOAmg+nQrt49P6iuxok
 EqTWK/CQLm9Schy97ncVGDqzbaPeXLdJ18WJA4S3ejo6toy1YYvn6K1M67qyGrJ6LQ4d
 Kmsdc6kS3rKP3tHnWT3W1MvlyJw1t2nwTv23wOazMOSr908eaOsn4mFqsSMJUG4zgqQ8
 KRBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729683583; x=1730288383;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pVL+kIAv+h6r6joh1LnQinliL2vLQFoA5dlPlv0cm0Q=;
 b=So1qcUEFk+a0xVrtm6XVt4s/yiIJ7mQDg+8DGBangwrLZYfPx17zLrvFEX2oJrQx+M
 b+VjnqcqcclTaoQxUogwR8Ed1AGMcIwUuG9DMBRIw7AFi9XRCxood3u0QJsUjhhDePWw
 U0GEGKM2+MK+HfWkgY316E+QsB9QHZ59pNgO1ZqfR9UzKRc4+5rdpNKWwsZ+iv4zDn2Z
 Qk5qTqE6ApQA2NCxTiwZOMR41/kivcf7Tv1kqdqY9ZJ8FrziKIXmeT4hmFSNFBgwL/KT
 lMEd5VGBKP0fTTY8PQ/CI5uetc23kjZRrCvr0KNQKRlcoc54FcBipHYnvmeRmqQ0btNh
 psJQ==
X-Gm-Message-State: AOJu0YxSJzjlLPBRwENQQ7+cpMe3jgOX4cE73v52QqRnNGZVFgnozICZ
 U2ifmiEozCygFKGovTnXjWvrP6M4XwGTitocAj4djfm+3ACRtxLlRCyCQg==
X-Google-Smtp-Source: AGHT+IHKFHQZSOkTrtiz4o2lbTKnmhv0Ka+021y6Egou4pUtUGBGBK1vXYrNVn8w9xRArXCqRF9iZg==
X-Received: by 2002:a2e:b8cd:0:b0:2fb:5f9d:c296 with SMTP id
 38308e7fff4ca-2fc9d33af84mr10316641fa.4.1729683582378; 
 Wed, 23 Oct 2024 04:39:42 -0700 (PDT)
Received: from localhost.localdomain (83-233-6-197.cust.bredband2.com.
 [83.233.6.197]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2fb9ae12708sm10415631fa.116.2024.10.23.04.39.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 04:39:40 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Stefan Roese <sr@denx.de>,
	Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH] watchdog: davinci: add support for DaVinci DM644x/DM646x
 processors
Date: Wed, 23 Oct 2024 13:39:26 +0200
Message-ID: <20241023113926.3223138-1-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 23 Oct 2024 15:15:20 +0200
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

Watchdog driver for DaVinci DM644x/DM646x processors.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 MAINTAINERS                    |   5 ++
 drivers/watchdog/Kconfig       |   9 ++
 drivers/watchdog/Makefile      |   1 +
 drivers/watchdog/davinci_wdt.c | 151 +++++++++++++++++++++++++++++++++
 4 files changed, 166 insertions(+)
 create mode 100644 drivers/watchdog/davinci_wdt.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 8dcce886b8..53aac8a0c3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -854,6 +854,11 @@ F:	cmd/cyclic.c
 F:	common/cyclic.c
 F:	include/cyclic.h
 
+DAVINCI WATCHDOG
+M:	Marcus Folkesson <marcus.folkesson@gmail.com>
+S:	Maintained
+F:	drivers/watchdog/davinci_wdt.c
+
 DFU
 M:	Lukasz Majewski <lukma@denx.de>
 S:	Maintained
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index b5ac8f7f50..e38acb0fe2 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -161,6 +161,15 @@ config WDT_CORTINA
 	  This driver support all CPU ISAs supported by Cortina
 	  Access CAxxxx SoCs.
 
+config WDT_DAVINCI
+	tristate "DaVinci watchdog timer support"
+	depends on WDT
+	depends on ARCH_DAVINCI || ARCH_KEYSTONE
+	select WATCHDOG_CORE
+	help
+	  Support for the watchdog timer in the DaVinci DM644x/DM646x
+	  or Keystone processors.
+
 config WDT_GPIO
 	bool "External gpio watchdog support"
 	depends on WDT
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 446d961d7d..ab454924c3 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_WDT_BOOKE) += booke_wdt.o
 obj-$(CONFIG_WDT_CORTINA) += cortina_wdt.o
 obj-$(CONFIG_WDT_ORION) += orion_wdt.o
 obj-$(CONFIG_WDT_CDNS) += cdns_wdt.o
+obj-$(CONFIG_WDT_DAVINCI) += davinci_wdt.o
 obj-$(CONFIG_WDT_GPIO) += gpio_wdt.o
 obj-$(CONFIG_WDT_MAX6370) += max6370_wdt.o
 obj-$(CONFIG_WDT_MESON_GXBB) += meson_gxbb_wdt.o
diff --git a/drivers/watchdog/davinci_wdt.c b/drivers/watchdog/davinci_wdt.c
new file mode 100644
index 0000000000..e822621fd3
--- /dev/null
+++ b/drivers/watchdog/davinci_wdt.c
@@ -0,0 +1,151 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Watchdog driver for DaVinci DM644x/DM646x processors
+ *
+ * Copyright 2024 Marcus Folkesson <marcus.folkesson@gmail.com>
+ */
+
+#include <asm/global_data.h>
+#include <asm/io.h>
+#include <common.h>
+#include <clk.h>
+#include <dm/device.h>
+#include <dm/fdtaddr.h>
+#include <dm/read.h>
+#include <linux/bitops.h>
+#include <linux/bitfield.h>
+#include <linux/err.h>
+#include <log.h>
+#include <watchdog.h>
+#include <wdt.h>
+
+/* Timer register set definition */
+#define PID12	(0x0)
+#define EMUMGT	(0x4)
+#define TIM12	(0x10)
+#define TIM34	(0x14)
+#define PRD12	(0x18)
+#define PRD34	(0x1C)
+#define TCR	(0x20)
+#define TGCR	(0x24)
+#define WDTCR	(0x28)
+
+/* TCR bit definitions */
+#define ENAMODE12		GENMASK(7, 6)
+#define ENAMODE12_DISABLED	(0)
+#define ENAMODE12_ONESHOT	(1)
+#define ENAMODE12_PERIODIC	(2)
+
+/* TGCR bit definitions */
+#define TIM12RS_UNRESET		BIT(0)
+#define TIM34RS_UNRESET		BIT(1)
+#define TIMMODE			GENMASK(3, 2)
+#define TIMMODE_64BIT_WDOG      (2)
+
+/* WDTCR bit definitions */
+#define WDEN			BIT(14)
+#define WDFLAG			BIT(15)
+#define WDKEY_SEQ0		(0xa5c6 << 16)
+#define WDKEY_SEQ1		(0xda7e << 16)
+
+DECLARE_GLOBAL_DATA_PTR;
+
+struct davinci_wdt_priv {
+	void __iomem *reg;
+	unsigned long clk_rate;
+};
+
+static int davinci_wdt_reset(struct udevice *dev)
+{
+	struct davinci_wdt_priv *priv = dev_get_priv(dev);
+
+	/* put watchdog in service state */
+	writel(WDKEY_SEQ0 | WDEN, priv->reg + WDTCR);
+	/* put watchdog in active state */
+	writel(WDKEY_SEQ1 | WDEN, priv->reg + WDTCR);
+
+	return 0;
+}
+
+static int davinci_wdt_start(struct udevice *dev, u64 timeout, ulong flags)
+{
+	u32 tgcr;
+	u32 timer_margin;
+	struct davinci_wdt_priv *priv = dev_get_priv(dev);
+
+	/* disable, internal clock source */
+	writel(0, priv->reg + TCR);
+
+	/* reset timer, set mode to 64-bit watchdog, and unreset */
+	writel(0, priv->reg + TGCR);
+	tgcr = FIELD_PREP(TIMMODE, TIMMODE_64BIT_WDOG) | TIM12RS_UNRESET | TIM34RS_UNRESET;
+	writel(tgcr, priv->reg + TGCR);
+
+	/* clear counter regs */
+	writel(0, priv->reg + TIM12);
+	writel(0, priv->reg + TIM34);
+
+	/* set timeout period */
+	timeout = timeout / 1000;
+	timer_margin = (((u64)timeout * priv->clk_rate) & 0xffffffff);
+	writel(timer_margin, priv->reg + PRD12);
+	timer_margin = (((u64)timeout * priv->clk_rate) >> 32);
+	writel(timer_margin, priv->reg + PRD34);
+
+	/* enable run continuously */
+	writel(FIELD_PREP(ENAMODE12, ENAMODE12_PERIODIC), priv->reg + TCR);
+
+	return davinci_wdt_reset(dev);
+}
+
+static int davinci_wdt_expire_now(struct udevice *dev, ulong flags)
+{
+	davinci_wdt_start(dev, 0, flags);
+
+	return 0;
+}
+
+static int davinci_wdt_probe(struct udevice *dev)
+{
+	debug("%s: Probing wdt%u (davinci-wdt)\n", __func__, dev_seq(dev));
+
+	return 0;
+}
+
+static int davinci_wdt_of_to_plat(struct udevice *dev)
+{
+	struct davinci_wdt_priv *priv = dev_get_priv(dev);
+	struct clk clk;
+
+	priv->reg = (void __iomem *)dev_read_addr(dev);
+	if (IS_ERR(priv->reg))
+		return PTR_ERR(priv->reg);
+
+	if (!clk_get_by_index(dev, 0, &clk))
+		priv->clk_rate = clk_get_rate(&clk);
+	else
+		priv->clk_rate = 24000000;
+
+	return 0;
+}
+
+static const struct wdt_ops davinci_wdt_ops = {
+	.start = davinci_wdt_start,
+	.reset = davinci_wdt_reset,
+	.expire_now = davinci_wdt_expire_now,
+};
+
+static const struct udevice_id davinci_wdt_ids[] = {
+	{ .compatible = "ti,davinci-wdt" },
+	{}
+};
+
+U_BOOT_DRIVER(davinci_wdt) = {
+	.name = "davinci_wdt",
+	.id = UCLASS_WDT,
+	.of_match = davinci_wdt_ids,
+	.probe = davinci_wdt_probe,
+	.priv_auto	= sizeof(struct davinci_wdt_priv),
+	.of_to_plat = davinci_wdt_of_to_plat,
+	.ops = &davinci_wdt_ops,
+};
-- 
2.46.0

