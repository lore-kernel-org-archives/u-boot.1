Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFFC6CF856D
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 08:43:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF0C688975;
	Thu,  3 Oct 2024 10:43:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="cd/HZyD1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 041CB88C4D; Thu,  3 Oct 2024 10:43:02 +0200 (CEST)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::228])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CB0188896
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 10:42:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bastien.curutchet@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id DAFCA1BF209;
 Thu,  3 Oct 2024 08:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1727944978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=FH5eaqytOJ4Xiy6u+mLvuC+gFjeXDh61YlJUUy0ZW20=;
 b=cd/HZyD1MXMys2vh/thZxbQ307Zbz+NT6h1qjor6Fes3+BXQ9NycFfzUYuOf1WRqbMvfmh
 hh+RDzwTg5mlPdvhaJjU5b1mAnFJpLvKyFvS7H1cwye3Jeftu2Nx4MPUPe/u4j4p1wov8C
 7o6ROj5f3qzQL5KmO9rMMuebjcqrH+Tybb+KObJGouHc94mh6FUveTonz5bwnd6cPETD8U
 QziLyJiTP0aWVhWHRCRpyErpGLCiS+7aAw4mr/61r9vsu70wCeaS5N7IN0xwJ3U8Ldeiic
 ATWUIeFdeT+s2QsSDjsLQcc61apgKmU+E/QvE4mM8V/Dv0J3zNa5Wo4VK3f6OQ==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
To: Tom Rini <trini@konsulko.com>,
	Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Herve Codina <herve.codina@bootlin.com>,
 Christopher Cordahi <christophercordahi@nanometrics.ca>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>
Subject: [PATCH] drivers: watchdog: Add DaVinci's watchdog support
Date: Thu,  3 Oct 2024 10:42:55 +0200
Message-ID: <20241003084255.33478-1-bastien.curutchet@bootlin.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: bastien.curutchet@bootlin.com
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

Add support for the DaVinci's watchdog timer

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
 drivers/watchdog/Kconfig       |   7 ++
 drivers/watchdog/Makefile      |   1 +
 drivers/watchdog/davinci_wdt.c | 131 +++++++++++++++++++++++++++++++++
 3 files changed, 139 insertions(+)
 create mode 100644 drivers/watchdog/davinci_wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 0c3e991331..a1c50b3f1f 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -169,6 +169,13 @@ config WDT_CORTINA
 	  This driver support all CPU ISAs supported by Cortina
 	  Access CAxxxx SoCs.
 
+config WDT_DAVINCI
+	bool "DaVinci watchdog timer support"
+	depends on WDT
+	help
+	  Select this to enable the watchdog timer for DaVinci SoCs such as the
+	  OMAP-L138.
+
 config WDT_GPIO
 	bool "External gpio watchdog support"
 	depends on WDT
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 7b39adcf0f..ad3053998a 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -29,6 +29,7 @@ obj-$(CONFIG_WDT_BOOKE) += booke_wdt.o
 obj-$(CONFIG_WDT_CORTINA) += cortina_wdt.o
 obj-$(CONFIG_WDT_ORION) += orion_wdt.o
 obj-$(CONFIG_WDT_CDNS) += cdns_wdt.o
+obj-$(CONFIG_WDT_DAVINCI) += davinci_wdt.o
 obj-$(CONFIG_WDT_FTWDT010) += ftwdt010_wdt.o
 obj-$(CONFIG_WDT_GPIO) += gpio_wdt.o
 obj-$(CONFIG_WDT_MAX6370) += max6370_wdt.o
diff --git a/drivers/watchdog/davinci_wdt.c b/drivers/watchdog/davinci_wdt.c
new file mode 100644
index 0000000000..fa8d7842e9
--- /dev/null
+++ b/drivers/watchdog/davinci_wdt.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * DaVinci Watchdog driver
+ *
+ */
+
+#include <asm/io.h>
+#include <clk.h>
+#include <dm.h>
+#include <wdt.h>
+
+/* Control Register */
+#define DAVINCI_WDT_ID			0x00
+#define DAVINCI_WDT_TIM12		0x10
+#define DAVINCI_WDT_TIM34		0x14
+#define DAVINCI_WDT_PRD12		0x18
+#define DAVINCI_WDT_PRD34		0x1C
+#define DAVINCI_WDT_TCR			0x20
+#define DAVINCI_WDT_TGCR		0x24
+#define DAVINCI_WDT_WDTCR		0x28
+
+#define DAVINCI_TCR_CONT_EN		BIT(7)
+
+#define DAVINCI_TGCR_PLUSEN		BIT(4)
+#define DAVINCI_TGCR_WDT_MODE		BIT(3)
+#define DAVINCI_TGCR_TIM34RS		BIT(1)
+#define DAVINCI_TGCR_TIM12RS		BIT(0)
+
+#define DAVINCI_WDTCR_INVALID_KEY	(0x5555 << 16)
+#define DAVINCI_WDTCR_WDKEY0		(0xA5C6 << 16)
+#define DAVINCI_WDTCR_WDKEY1		(0xDA7E << 16)
+#define DAVINCI_WDTCR_WDFLAG		BIT(15)
+#define DAVINCI_WDTCR_WDEN		BIT(14)
+
+#define DEFAULT_THRESHOLD		0xA03200000
+
+struct davinci_wdt_priv {
+	void __iomem *base;
+	struct clk *ref_clk;
+};
+
+static int davinci_wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
+{
+	struct davinci_wdt_priv *priv = dev_get_priv(dev);
+	ulong rate = clk_get_rate(priv->ref_clk);
+	u64 threshold;
+
+	if (!rate)
+		threshold = DEFAULT_THRESHOLD;
+	else
+		threshold = rate * timeout_ms / 1000;
+
+	/* Reset control registers */
+	writel(0, priv->base + DAVINCI_WDT_TCR);
+	writel(0, priv->base + DAVINCI_WDT_TGCR);
+
+	/* Enable watchdog mode and timers */
+	writel(DAVINCI_TGCR_WDT_MODE | DAVINCI_TGCR_TIM12RS | DAVINCI_TGCR_TIM34RS,
+	       priv->base + DAVINCI_WDT_TGCR);
+
+	/* Reset counters */
+	writel(0, priv->base + DAVINCI_WDT_TIM12);
+	writel(0, priv->base + DAVINCI_WDT_TIM34);
+
+	/* Set timeout threshold */
+	writel(threshold & 0xFFFFFFFF, priv->base + DAVINCI_WDT_PRD12);
+	writel(threshold >> 32, priv->base + DAVINCI_WDT_PRD34);
+
+	/* Enable counter */
+	writel(DAVINCI_TCR_CONT_EN, priv->base + DAVINCI_WDT_TCR);
+
+	/* Go to watchdog's active state */
+	writel(DAVINCI_WDTCR_WDEN | DAVINCI_WDTCR_WDKEY0, priv->base + DAVINCI_WDT_WDTCR);
+	writel(DAVINCI_WDTCR_WDEN | DAVINCI_WDTCR_WDKEY1, priv->base + DAVINCI_WDT_WDTCR);
+
+	return 0;
+}
+
+static int davinci_wdt_expire_now(struct udevice *dev, ulong flags)
+{
+	struct davinci_wdt_priv *priv = dev_get_priv(dev);
+
+	writel(DAVINCI_WDTCR_INVALID_KEY, priv->base + DAVINCI_WDT_WDTCR);
+
+	return 0;
+}
+
+static int davinci_wdt_restart(struct udevice *dev)
+{
+	struct davinci_wdt_priv *priv = dev_get_priv(dev);
+
+	writel(DAVINCI_WDTCR_WDEN | DAVINCI_WDTCR_WDKEY0, priv->base + DAVINCI_WDT_WDTCR);
+	writel(DAVINCI_WDTCR_WDEN | DAVINCI_WDTCR_WDKEY1, priv->base + DAVINCI_WDT_WDTCR);
+
+	return 0;
+}
+
+static int davinci_wdt_probe(struct udevice *dev)
+{
+	struct davinci_wdt_priv *priv = dev_get_priv(dev);
+
+	priv->base = dev_remap_addr_index(dev, 0);
+	if (!priv->base)
+		return -EFAULT;
+
+	priv->ref_clk = devm_clk_get(dev, "ref");
+	if (IS_ERR(priv->ref_clk))
+		return PTR_ERR(priv->ref_clk);
+
+	return 0;
+}
+
+static const struct wdt_ops davinci_wdt_ops = {
+	.start = davinci_wdt_start,
+	.reset = davinci_wdt_restart,
+	.expire_now = davinci_wdt_expire_now,
+};
+
+static const struct udevice_id davinci_wdt_ids[] = {
+	{.compatible = "ti,davinci-wdt"},
+	{}
+};
+
+U_BOOT_DRIVER(davinci_wdt) = {
+	.name = "davinci_wdt",
+	.id = UCLASS_WDT,
+	.probe = davinci_wdt_probe,
+	.of_match = davinci_wdt_ids,
+	.ops = &davinci_wdt_ops,
+	.priv_auto = sizeof(struct davinci_wdt_priv),
+};
-- 
2.46.0

