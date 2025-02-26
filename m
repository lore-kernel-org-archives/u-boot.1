Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AFA7C021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 18:00:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75E00811BA;
	Wed, 26 Feb 2025 18:58:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jw3skQMp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B666381026; Wed, 26 Feb 2025 18:33:08 +0100 (CET)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55DCE80F88
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 18:33:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=malysagreg@gmail.com
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-e53c9035003so5497316276.2
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 09:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740591185; x=1741195985; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z4S6pu9vLnpcKQKvO7D07esYTTT9Y8H4LPZalllNLNw=;
 b=jw3skQMpBRKW+rdc3uBH1TaYrH0+42+fbz2ZZ4s6bnkJDo0b9od5QGvHIL+w3Jq6J5
 MBH+sul2LHyPtd9YzWtXZsBYzeNtfooKLE0t3xWxxxU2+GFaOf7y0+9W1wh5VkugnOlA
 F3AiBgOyjhPuUXgq+KfhGI2FrTpVOTpOKJyf2HEYlR+yLuOdj5UzV3snvXJKnYMQfnWs
 D9wF6aWnI+Nsw3TqUFVa+J4Ic7b9evh/HuM+ncmpUh/7OS9ziI5iecao84QU1rOltt5a
 6G5AYYtyGASuyMyp29bFzR+/OYal7MhSdaJ/LCM5rjrZUGylOU6PGrLbsVWgqM8dmPX5
 xDfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740591185; x=1741195985;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z4S6pu9vLnpcKQKvO7D07esYTTT9Y8H4LPZalllNLNw=;
 b=dcX1TzY1UShdj7lgHUlgXlxw6RLKhpaex37oDE28Okr2yHdZdjBj2DsS0v0QW2pxCo
 df2KMG4Qjr39PKv3LiCeavSsSIuYG8XxvjfTuHJd3U9Gl9p2qN+TG0TB8qFjqNGDDBAy
 5Vs9ph7TEi99dajHSsqDjFC7yUrKqU0DMQTLCUHUVI1FcrcMdKyqg9dDoafA8RTRjPiH
 YXBxYpYvS4xS1ynZyKR2+PKWj37SL/vS/ExHlC1G6Tnvtpqkz4FwcsvmEtjYneI1OVdi
 LEk0rpaSlkoLLXc8iXERrc2zl2L6u8HmU7sPCMLMhGgP+YIUKM7jxa0/+Sr6+C4VC/8H
 rJbQ==
X-Gm-Message-State: AOJu0YxKthp+melQxXMF13B0GV3QBA/GKnH5y6WupXPD/nC8bDZxd8Pp
 ZhfvoxmhUG+tlEi4Ui54cBMgcGqciQhdb7CvsRlpeYW3PR+NocejpM2F3PI=
X-Gm-Gg: ASbGncuqPQIsCvd2vZe4w63F67g3tpwK8/uuhHfK+MTawkOTp4CKupBZ3hjiELSVVXc
 izcLB1MH9EsOjtCxphM3oyETYP11hwLCocjuGSwjBpRqdr2FOjcBcd56ckTxWoRrk/u70OFAGaM
 zm7Qyy0P3MPgoRMBJEbp+qMyeGKFbz6W+bU4M+oalpuUaeOo6gp273gu9TwJ/rJy5QN3uxT6Czx
 q6VNRkv+gpx5PPDRLd+FPCi760RLM82D8pUs2MSNfC37rQvUHpt9x9Se9QM5YKjLkPQ+beKACwZ
 SvHFU5S7TGERx+DHdJGNfpDnYQUrKc5GKcpxz1YPAA==
X-Google-Smtp-Source: AGHT+IHO2j7mvEZhAGdpWOVJL8vf75N1ynGziNBAG5aYaqxq9GuUtYTKHHyXg2OOQwFKbtVHlQyoAQ==
X-Received: by 2002:a05:6902:2384:b0:e5d:e04f:f2bc with SMTP id
 3f1490d57ef6-e607a56594dmr6800380276.44.1740591184590; 
 Wed, 26 Feb 2025 09:33:04 -0800 (PST)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e607b40d227sm1067620276.31.2025.02.26.09.33.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 09:33:04 -0800 (PST)
From: Greg Malysa <malysagreg@gmail.com>
To: u-boot@lists.denx.de
Cc: adsp-linux@analog.com,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Greg Malysa <malysagreg@gmail.com>, Ian Roberts <ian.roberts@timesys.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Devarsh Thakkar <devarsht@ti.com>, Fabio Estevam <festevam@gmail.com>,
 Greg Malysa <greg.malysa@timesys.com>, Heiko Schocher <hs@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 08/12] watchdog: Add support for ADI SC5XX-family watchdog
 peripheral
Date: Wed, 26 Feb 2025 12:30:30 -0500
Message-ID: <20250226173150.13198-9-malysagreg@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250226173150.13198-1-malysagreg@gmail.com>
References: <20250226173150.13198-1-malysagreg@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 26 Feb 2025 18:58:54 +0100
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

Co-developed-by: Greg Malysa <malysagreg@gmail.com>
Signed-off-by: Greg Malysa <malysagreg@gmail.com>
Co-developed-by: Ian Roberts <ian.roberts@timesys.com>
Signed-off-by: Ian Roberts <ian.roberts@timesys.com>
Signed-off-by: Vasileios Bimpikas <vasileios.bimpikas@analog.com>
Signed-off-by: Utsav Agarwal <utsav.agarwal@analog.com>
Signed-off-by: Arturs Artamonovs <arturs.artamonovs@analog.com>
Signed-off-by: Oliver Gaskell <Oliver.Gaskell@analog.com>
Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>

---

Changes in v3:
- replace readl/writel with ioread32 and iowrite32 and friends

 MAINTAINERS                |   1 +
 drivers/watchdog/Kconfig   |   9 +++
 drivers/watchdog/Makefile  |   1 +
 drivers/watchdog/adi_wdt.c | 143 +++++++++++++++++++++++++++++++++++++
 4 files changed, 154 insertions(+)
 create mode 100644 drivers/watchdog/adi_wdt.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 2c4dc8b14c1..0cefd888885 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -640,6 +640,7 @@ F:	drivers/pinctrl/pinctrl-adi-adsp.c
 F:	drivers/serial/serial_adi_uart4.c
 F:	drivers/timer/adi_sc5xx_timer.c
 F:	drivers/usb/musb-new/sc5xx.c
+F:	drivers/watchdog/adi_wdt.c
 F:	include/configs/sc5*
 F:	include/dt-bindings/pinctrl/adi-adsp.h
 F:	include/env/adi/
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index b39b2546e5c..1bb67f50352 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -95,6 +95,15 @@ config WDT_APPLE
 	  The watchdog will perform a full SoC reset resulting in a
 	  reboot of the entire system.
 
+config WDT_ADI
+	bool "Analog Devices watchdog timer support"
+	select WDT
+	select SPL_WDT if SPL
+	depends on ARCH_SC5XX
+	help
+	  Enable this to support Watchdog Timer on ADI SC57X, SC58X, SC59X,
+	  and SC59X_64 processors
+
 config WDT_ARMADA_37XX
 	bool "Marvell Armada 37xx watchdog timer support"
 	depends on WDT && ARMADA_3700
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 9b6b1a8e8ad..e6bd4c587af 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -53,3 +53,4 @@ obj-$(CONFIG_WDT_STM32MP) += stm32mp_wdt.o
 obj-$(CONFIG_WDT_SUNXI) += sunxi_wdt.o
 obj-$(CONFIG_WDT_TANGIER) += tangier_wdt.o
 obj-$(CONFIG_WDT_XILINX) += xilinx_wwdt.o
+obj-$(CONFIG_WDT_ADI) += adi_wdt.o
diff --git a/drivers/watchdog/adi_wdt.c b/drivers/watchdog/adi_wdt.c
new file mode 100644
index 00000000000..6f5b3d5d042
--- /dev/null
+++ b/drivers/watchdog/adi_wdt.c
@@ -0,0 +1,143 @@
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
+	iowrite32(0, priv->wdt_base + WDOG_STAT);
+
+	return 0;
+}
+
+static int adi_wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
+{
+	struct adi_wdt_priv *priv = dev_get_priv(dev);
+
+	/* Disable SYSCD_RESETb input and clear the RCU0 reset status */
+	iowrite32(0xf, priv->rcu_base + RCU_STAT);
+	iowrite32(0x0, priv->rcu_base + RCU_CTL);
+
+	/* reset the SEC controller */
+	iowrite32(0x2, priv->sec_base + SEC_GCTL);
+	iowrite32(0x2, priv->sec_base + SEC_FCTL);
+
+	udelay(50);
+
+	/* enable SEC fault event */
+	iowrite32(0x1, priv->sec_base + SEC_GCTL);
+
+	/* ANOMALY 36100004 Spurious External Fault event occurs when FCTL
+	 * is re-programmed when currently active fault is not cleared
+	 */
+	iowrite32(0xc0, priv->sec_base + SEC_FCTL);
+	iowrite32(0xc1, priv->sec_base + SEC_FCTL);
+
+	/* enable SEC fault source for watchdog0 */
+	setbits_32(priv->sec_base + SEC_SCTL0 + (3*8), 0x6);
+
+	/* Enable SYSCD_RESETb input */
+	iowrite32(0x100, priv->rcu_base + RCU_CTL);
+
+	/* enable watchdog0 */
+	iowrite32(WDDIS, priv->wdt_base + WDOG_CTL);
+
+	iowrite32(timeout_ms / 1000 *
+	       (clk_get_rate(&priv->clock) / (IS_ENABLED(CONFIG_SC58X) ? 2 : 1)),
+	       priv->wdt_base + WDOG_CNT);
+
+	iowrite32(0, priv->wdt_base + WDOG_STAT);
+	iowrite32(WDEN, priv->wdt_base + WDOG_CTL);
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
2.45.2

