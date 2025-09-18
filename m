Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7305DCAC59A
	for <u-boot@archiver.kernel.org>; Thu, 18 Sep 2025 08:44:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95A9B8318E;
	Thu, 18 Sep 2025 10:44:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="YPBZVEBN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85AD980107; Thu, 18 Sep 2025 10:44:45 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D8BB82C84
 for <u-boot@lists.denx.de>; Thu, 18 Sep 2025 10:44:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukma@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 63F0510647B; Thu, 18 Sep 2025 10:44:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1758185082; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=ZcvaSUvGcFgQDXEQHWByTahKAixybgPZAamHYYolKF0=;
 b=YPBZVEBNqVfCZTA6RFzQ8J861+hqtKGEagFAyVBw4PGcZhNq9shiNaSMFBAStyGGFLV2fD
 ZR9kgaUotwKaMjosvZRYK9YM3ZSmrVDkX9NCztvQ9z0hi19nHXM3ZT3dgLTetYjCUJAlK0
 6fD4IgcD+sFkzkXZ/jRSohd0tAbrXf0gRa64IeHv/v/a9e9VJ/4LdigN/2iub8WJcwFQd+
 63w7m3JKemI4p9l+WQ74WQ9tTAf34+KkwnAdHcZRlRDsDMubafM8fMe0HpwhFmJKIj/Eso
 n0FiAAQlnt1jUL1q0pjlfkDohqojdipsodXQee6oi9xYQn9r4Ok616CPMuDqNA==
From: Lukasz Majewski <lukma@nabladev.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Stephen Warren <swarren@nvidia.com>, Lukasz Majewski <lukma@nabladev.com>
Subject: [PATCH v2 2/2] watchdog: Add implementation of NVIDIA's Tegra
 watchdog driver
Date: Thu, 18 Sep 2025 10:42:07 +0200
Message-Id: <20250918084207.3862049-2-lukma@nabladev.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250918084207.3862049-1-lukma@nabladev.com>
References: <20250918084207.3862049-1-lukma@nabladev.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

This commit provides support for Tegra watchdog functionality.
The WATCHDOG index 0 in conjunction with TIMER 5 has been used. as the
same setup is used in the Linux kernel driver.

Signed-off-by: Lukasz Majewski <lukma@nabladev.com>
---
Changes for v2:
- Remove () from defines and use hex lower case numbers
- Move check for timeout range validity before first register write
- Remove "nvidia,tegra30-timer" device compatibility check
---
 drivers/watchdog/Kconfig     |   7 +++
 drivers/watchdog/Makefile    |   1 +
 drivers/watchdog/tegra_wdt.c | 118 +++++++++++++++++++++++++++++++++++
 3 files changed, 126 insertions(+)
 create mode 100644 drivers/watchdog/tegra_wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 9e149a75e81..a10baed7232 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -454,6 +454,13 @@ config WDT_TANGIER
 	  Intel Tangier SoC. If you're using a board with Intel Tangier
 	  SoC, say Y here.
 
+config WDT_TEGRA
+	bool "Tegra watchdog"
+	depends on WDT && ARCH_TEGRA
+	help
+	  Select this to enable support for the watchdog timer
+	  embedded in NVIDIA Tegra SoCs.
+
 config WDT_ARM_SMC
 	bool "ARM SMC watchdog timer support"
 	depends on WDT && ARM_SMCCC
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index d52d17e1c90..02e2674f8af 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -53,6 +53,7 @@ obj-$(CONFIG_WDT_STARFIVE) += starfive_wdt.o
 obj-$(CONFIG_WDT_STM32MP) += stm32mp_wdt.o
 obj-$(CONFIG_WDT_SUNXI) += sunxi_wdt.o
 obj-$(CONFIG_WDT_TANGIER) += tangier_wdt.o
+obj-$(CONFIG_WDT_TEGRA) += tegra_wdt.o
 obj-$(CONFIG_WDT_XILINX) += xilinx_wwdt.o
 obj-$(CONFIG_WDT_ADI) += adi_wdt.o
 obj-$(CONFIG_WDT_QCOM) += qcom-wdt.o
diff --git a/drivers/watchdog/tegra_wdt.c b/drivers/watchdog/tegra_wdt.c
new file mode 100644
index 00000000000..345c83fc8a2
--- /dev/null
+++ b/drivers/watchdog/tegra_wdt.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * NVIDIA Tegra Watchdog driver
+ *
+ * Copyright (C) 2025 NABLA Software Engineering
+ * Lukasz Majewski, NABLA Software Engineering, lukma@nabladev.com
+ */
+
+#include <dm.h>
+#include <wdt.h>
+#include <hang.h>
+#include <asm/io.h>
+#include <watchdog.h>
+
+/* Timer registers */
+#define TIMER_PTV			0x0
+#define TIMER_EN			BIT(31)
+#define TIMER_PERIODIC			BIT(30)
+
+/* WDT registers */
+#define WDT_CFG			0x0
+#define WDT_CFG_PERIOD_SHIFT		4
+#define WDT_CFG_PERIOD_MASK		GENMASK(7, 0)
+#define WDT_CFG_INT_EN			BIT(12)
+#define WDT_CFG_PMC2CAR_RST_EN		BIT(15)
+#define WDT_CMD			0x8
+#define WDT_CMD_START_COUNTER		BIT(0)
+#define WDT_CMD_DISABLE_COUNTER	BIT(1)
+#define WDT_UNLOCK			0xc
+#define WDT_UNLOCK_PATTERN		0xc45a
+
+/* Use watchdog ID 0 */
+#define WDT0_BASE			0x100
+
+/* Use Timer 5 as WDT counter */
+#define WDT_TIM5_BASE			0x60
+#define WDT_TIM5_ID			5
+
+struct tegra_wdt_priv {
+	void __iomem *wdt_base;
+	void __iomem *tim_base;
+};
+
+static int tegra_wdt_reset(struct udevice *dev)
+{
+	struct tegra_wdt_priv *priv = dev_get_priv(dev);
+
+	writel(WDT_CMD_START_COUNTER, priv->wdt_base + WDT_CMD);
+
+	return 0;
+}
+
+static int tegra_wdt_start(struct udevice *dev, u64 timeout, ulong flags)
+{
+	struct tegra_wdt_priv *priv = dev_get_priv(dev);
+	u32 timeout_sec = timeout / 1000;
+
+	/* Support for timeout from 1 to 255 seconds */
+	if (timeout_sec < 1 || timeout_sec > 255)
+		return -EINVAL;
+
+	/*
+	 * Timer for WDT has a fixed 1MHz clock, so for 1 second period one
+	 * shall write 1000000ul.
+	 *
+	 * On Tegra the watchdog reset actually occurs on the 4th expiration
+	 * of this counter, so we set the period to 1/4.
+	 */
+	writel(TIMER_EN | TIMER_PERIODIC | (1000000ul / 4),
+	       priv->tim_base + TIMER_PTV);
+
+	writel(WDT_CFG_PMC2CAR_RST_EN | (timeout_sec << WDT_CFG_PERIOD_SHIFT) |
+	       WDT_TIM5_ID, priv->wdt_base + WDT_CFG);
+
+	writel(WDT_CMD_START_COUNTER, priv->wdt_base + WDT_CMD);
+
+	return 0;
+}
+
+static int tegra_wdt_stop(struct udevice *dev)
+{
+	struct tegra_wdt_priv *priv = dev_get_priv(dev);
+
+	writel(WDT_UNLOCK_PATTERN, priv->wdt_base + WDT_UNLOCK);
+	writel(WDT_CMD_DISABLE_COUNTER, priv->wdt_base + WDT_CMD);
+	writel(0, priv->tim_base + TIMER_PTV);
+
+	return 0;
+}
+
+static int tegra_wdt_probe(struct udevice *dev)
+{
+	struct tegra_wdt_priv *priv = dev_get_priv(dev);
+	void __iomem *base;
+
+	base = dev_read_addr_ptr(dev);
+	if (!base)
+		return -ENOENT;
+
+	priv->wdt_base = base + WDT0_BASE;
+	priv->tim_base = base + WDT_TIM5_BASE;
+
+	return 0;
+}
+
+static const struct wdt_ops tegra_wdt_ops = {
+	.start		= tegra_wdt_start,
+	.stop		= tegra_wdt_stop,
+	.reset		= tegra_wdt_reset,
+};
+
+U_BOOT_DRIVER(tegra_wdt) = {
+	.name = "tegra_wdt",
+	.id = UCLASS_WDT,
+	.priv_auto = sizeof(struct tegra_wdt_priv),
+	.probe = tegra_wdt_probe,
+	.ops = &tegra_wdt_ops,
+};
-- 
2.39.5

