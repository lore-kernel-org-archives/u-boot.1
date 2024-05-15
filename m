Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F033C25B78
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 22:00:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5679688366;
	Wed, 15 May 2024 23:59:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="cf2C1QPy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2F3A8833B; Wed, 15 May 2024 23:59:35 +0200 (CEST)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF8B786DBD
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 23:59:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=greg.malysa@timesys.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-61be4b98766so85094817b3.3
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 14:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1715810371; x=1716415171;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z+ESdM3nGVZgo68VvQHebUEr4my4IzWFOIa3E44V34k=;
 b=cf2C1QPyKHWSYRiVXCZxSVJXQwIDjoJnvUQjk2OqrRmiCeYD03+oIBCQfsgR/9FRAY
 3INMDx1x8D+IgzfNOGuMCdQeoX/xbZw0XoIFLAHqCeDgWzmoApfV2AjPyeFTsh+0VM/I
 fX10URqDx7WuEieQSudh8yHFJtYk1n2jOEZsKYwUzA9bWVtYGqlIvdg9dCnCPY/q/AlK
 PY56jf/M56vPWx++/mEWfjCBydNFGwcPxvFYv03z5Q1AhRbTG3ik+ntHFMTSathny6UN
 N3Jw96PPFigkc8IT2HTjOEhjalD/gH/K0r1rUpDQtirs0CKmiJVvkkKvR4klXIhOS79C
 pY2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715810371; x=1716415171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z+ESdM3nGVZgo68VvQHebUEr4my4IzWFOIa3E44V34k=;
 b=SQkWhQftuqATp1D/o+yBFUH+iymiPr2wgPc9Lpyn5McgOcj9bSyrOifqT9j+TQk789
 RrlVK+4TlGK89m2GeyC07Klcopt4BxPGTOD30D800htuvHc3V7QpRkql3uQ7dtzVVhbb
 6sJHXXB63hO+SA9usKdlbpSVE2GuRoODF4K3+3QKGCOOmy1eCGR+/KEO16ASuzoie9PS
 KgI7qG9zG1n2olonFoue7CgS+T9lw0PXcgHE4p5TyK1KgnZ+O5RUQAmRBsILXivztO9O
 tE/13O80IJAGI2fgo9Rwi23x8r1g6aBvivU1kB3VUHYfrsca6xVDaoK0oe/lgaX/PtW0
 PKLQ==
X-Gm-Message-State: AOJu0YzQistkebV1r7W7LPzbGNiKq/iSi8q4LciBJJEtDv3P49i8Youq
 MZSJduCPTeGiqddw14bHlTKWK9MgD24XYhMsOHtlJJPqHJwpmK//ZAWoqkU925/yuuF/cVLp1Wy
 P3A==
X-Google-Smtp-Source: AGHT+IGKGua68Tb8wwd07TpxrfSTpIdbz2ZQvDxXnj63QNVlgmSLt2zowzXm6A8DoxwSS3OQQirOow==
X-Received: by 2002:a81:6c05:0:b0:620:4018:7c67 with SMTP id
 00721157ae682-622aff8cc75mr167433877b3.27.1715810371450; 
 Wed, 15 May 2024 14:59:31 -0700 (PDT)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6209e37913asm30956457b3.105.2024.05.15.14.59.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 14:59:31 -0700 (PDT)
From: Greg Malysa <greg.malysa@timesys.com>
To: u-boot@lists.denx.de
Cc: Matthew McClintock <Matthew.Mcclintock@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Greg Malysa <greg.malysa@timesys.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Chanho Park <chanho61.park@samsung.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Randolph <randolph@andestech.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 07/11] watchdog: Add support for ADI SC5XX-family watchdog
 peripheral
Date: Wed, 15 May 2024 17:57:44 -0400
Message-ID: <20240515215837.14028-8-greg.malysa@timesys.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240515215837.14028-1-greg.malysa@timesys.com>
References: <20240515215837.14028-1-greg.malysa@timesys.com>
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

From: Nathan Barrett-Morrison <nathan.morrison@timesys.com>

Co-developed-by: Greg Malysa <greg.malysa@timesys.com>
Signed-off-by: Greg Malysa <greg.malysa@timesys.com>
Co-developed-by: Ian Roberts <ian.roberts@timesys.com>
Signed-off-by: Ian Roberts <ian.roberts@timesys.com>
Signed-off-by: Vasileios Bimpikas <vasileios.bimpikas@analog.com>
Signed-off-by: Utsav Agarwal <utsav.agarwal@analog.com>
Signed-off-by: Arturs Artamonovs <arturs.artamonovs@analog.com>
Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
---

 MAINTAINERS                |   1 +
 drivers/watchdog/Kconfig   |   9 +++
 drivers/watchdog/Makefile  |   1 +
 drivers/watchdog/adi_wdt.c | 145 +++++++++++++++++++++++++++++++++++++
 4 files changed, 156 insertions(+)
 create mode 100644 drivers/watchdog/adi_wdt.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c1685f0352..6feb7e540b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -618,6 +618,7 @@ F:	drivers/pinctrl/pinctrl-adi-adsp.c
 F:	drivers/serial/serial_adi_uart4.c
 F:	drivers/timer/adi_sc5xx_timer.c
 F:	drivers/usb/musb-new/sc5xx.c
+F:	drivers/watchdog/adi_wdt.c
 F:	include/env/adi/
 
 ARM SNAPDRAGON
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 8318fd77a3..5a62000272 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -94,6 +94,15 @@ config WDT_APPLE
 	  The watchdog will perform a full SoC reset resulting in a
 	  reboot of the entire system.
 
+config WDT_ADI
+	bool "Analog Devices watchdog timer support"
+	select WDT
+	select SPL_WDT if SPL
+	depends on (SC57X || SC58X || SC59X || SC59X_64)
+	help
+	  Enable this to support Watchdog Timer on ADI SC57X, SC58X, SC59X,
+	  and SC59X_64 processors
+
 config WDT_ARMADA_37XX
 	bool "Marvell Armada 37xx watchdog timer support"
 	depends on WDT && ARMADA_3700
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 7b39adcf0f..7ad61b513c 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -50,3 +50,4 @@ obj-$(CONFIG_WDT_STM32MP) += stm32mp_wdt.o
 obj-$(CONFIG_WDT_SUNXI) += sunxi_wdt.o
 obj-$(CONFIG_WDT_TANGIER) += tangier_wdt.o
 obj-$(CONFIG_WDT_XILINX) += xilinx_wwdt.o
+obj-$(CONFIG_WDT_ADI) += adi_wdt.o
diff --git a/drivers/watchdog/adi_wdt.c b/drivers/watchdog/adi_wdt.c
new file mode 100644
index 0000000000..67d17dc692
--- /dev/null
+++ b/drivers/watchdog/adi_wdt.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * (C) Copyright 2022 - Analog Devices, Inc.
+ *
+ * Written and/or maintained by Timesys Corporation
+ *
+ * Converted to driver model by Nathan Barrett-Morrison
+ *
+ * Contact: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
+ * Contact: Greg Malysa <greg.malysa@timesys.com>
+ *
+ * adi_wtd.c - driver for ADI on-chip watchdog
+ *
+ */
+
+#include <clk.h>
+#include <dm.h>
+#include <wdt.h>
+#include <linux/delay.h>
+#include <linux/ioport.h>
+#include <linux/io.h>
+
+#define WDOG_CTL  0x0
+#define WDOG_CNT  0x4
+#define WDOG_STAT 0x8
+
+#define RCU_CTL   0x0
+#define RCU_STAT  0x4
+
+#define SEC_GCTL  0x0
+#define SEC_FCTL  0x10
+#define SEC_SCTL0 0x800
+
+#define WDEN      0x0010
+#define WDDIS     0x0AD0
+
+struct adi_wdt_priv {
+	void __iomem *rcu_base;
+	void __iomem *sec_base;
+	void __iomem *wdt_base;
+	struct clk clock;
+};
+
+static int adi_wdt_reset(struct udevice *dev)
+{
+	struct adi_wdt_priv *priv = dev_get_priv(dev);
+
+	writel(0, priv->wdt_base + WDOG_STAT);
+
+	return 0;
+}
+
+static int adi_wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
+{
+	struct adi_wdt_priv *priv = dev_get_priv(dev);
+	u32 sctl_val;
+
+	/* Disable SYSCD_RESETb input and clear the RCU0 reset status */
+	writel(0xf, priv->rcu_base + RCU_STAT);
+	writel(0x0, priv->rcu_base + RCU_CTL);
+
+	/* reset the SEC controller */
+	writel(0x2, priv->sec_base + SEC_GCTL);
+	writel(0x2, priv->sec_base + SEC_FCTL);
+
+	udelay(50);
+
+	/* enable SEC fault event */
+	writel(0x1, priv->sec_base + SEC_GCTL);
+
+	/* ANOMALY 36100004 Spurious External Fault event occurs when FCTL
+	 * is re-programmed when currently active fault is not cleared
+	 */
+	writel(0xc0, priv->sec_base + SEC_FCTL);
+	writel(0xc1, priv->sec_base + SEC_FCTL);
+
+	/* enable SEC fault source for watchdog0 */
+	sctl_val = readl((priv->sec_base + SEC_SCTL0) + 3 * 8) | 0x6;
+	writel(sctl_val, (priv->sec_base + SEC_SCTL0) + 3 * 8);
+
+	/* Enable SYSCD_RESETb input */
+	writel(0x100, priv->rcu_base + RCU_CTL);
+
+	/* enable watchdog0 */
+	writel(WDDIS, priv->wdt_base + WDOG_CTL);
+
+	writel(timeout_ms / 1000 *
+	       (clk_get_rate(&priv->clock) / (IS_ENABLED(CONFIG_SC58X) ? 2 : 1)),
+	       priv->wdt_base + WDOG_CNT);
+
+	writel(0, priv->wdt_base + WDOG_STAT);
+	writel(WDEN, priv->wdt_base + WDOG_CTL);
+
+	return 0;
+}
+
+static int adi_wdt_probe(struct udevice *dev)
+{
+	struct adi_wdt_priv *priv = dev_get_priv(dev);
+	int ret;
+	struct resource res;
+
+	ret = dev_read_resource_byname(dev, "rcu", &res);
+	if (ret)
+		return ret;
+	priv->rcu_base = devm_ioremap(dev, res.start, resource_size(&res));
+
+	ret = dev_read_resource_byname(dev, "sec", &res);
+	if (ret)
+		return ret;
+	priv->sec_base = devm_ioremap(dev, res.start, resource_size(&res));
+
+	ret = dev_read_resource_byname(dev, "wdt", &res);
+	if (ret)
+		return ret;
+	priv->wdt_base = devm_ioremap(dev, res.start, resource_size(&res));
+
+	ret = clk_get_by_name(dev, "sclk0", &priv->clock);
+	if (ret < 0) {
+		printf("Can't get WDT clk: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct wdt_ops adi_wdt_ops = {
+	.start		= adi_wdt_start,
+	.reset		= adi_wdt_reset,
+};
+
+static const struct udevice_id adi_wdt_ids[] = {
+	{ .compatible = "adi,wdt" },
+	{}
+};
+
+U_BOOT_DRIVER(adi_wdt) = {
+	.name		= "adi_wdt",
+	.id		= UCLASS_WDT,
+	.of_match	= adi_wdt_ids,
+	.probe		= adi_wdt_probe,
+	.ops		= &adi_wdt_ops,
+	.priv_auto = sizeof(struct adi_wdt_priv),
+	.flags		= DM_FLAG_PRE_RELOC,
+};
-- 
2.43.2

