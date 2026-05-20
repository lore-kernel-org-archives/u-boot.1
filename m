Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A9BECD4F5E
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 06:05:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C36AF844CF;
	Wed, 20 May 2026 08:05:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=superkali.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=superkali.me header.i=@superkali.me header.b="CY9yxdML";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E62E68469D; Wed, 20 May 2026 08:05:35 +0200 (CEST)
Received: from fr5000-r.dnsiaas.com (fr5000-r.dnsiaas.com [92.42.104.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 586578465A
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 08:05:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=superkali.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hello@superkali.me
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=superkali.me; s=default; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DqbBhmSUwmXUMptoryEpg41P+/xXQDQcNMtf3OwOQ+o=; b=CY9yxdMLv4YQmmc5zOP6H/sV+y
 VSJQFWSrMtvRj5yocF6sFDDDrsiQjdyRx5De4dYp64pu76pUH3j9Hmy0UiHFFVlXkAkx07eGrBSEa
 FO7YE24CMHAFidbwsNlz7UWnwWbhJSCHVV4ChuYubMlCG63fBTCzq+WR3kYZx82cxTKONE5rj5NB8
 b2RzMWCfpyS+7m3oCGbw3DIYxFGN+BxjVUC2X9iUnmiZo47L2G/Xgx0MVFb5AcYM/0e6FVHnt6z79
 Mepx1ao+VPZg0kBq0dVjf3OldLblV/5Ty1FFaYvGHZ5jDm/4lAF56QBx+0MUNZ0Isi+H/dg6SyXwX
 0eD1RcdQ==;
Received: from [81.57.40.39] (port=50682 helo=vscode.iliadbox.lan)
 by fr5000-r.dnsiaas.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.2) (envelope-from <hello@superkali.me>)
 id 1wPa3h-0000000DuY3-1AZS; Wed, 20 May 2026 08:05:31 +0200
From: Daniele Briguglio <hello@superkali.me>
Date: Wed, 20 May 2026 08:05:27 +0200
Subject: [PATCH v3 1/4] clk: add gated-fixed-clock driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-rock-5-itx-pcie-refclk-dtsi-v3-1-58f2cea72030@superkali.me>
References: <20260520-rock-5-itx-pcie-refclk-dtsi-v3-0-58f2cea72030@superkali.me>
In-Reply-To: <20260520-rock-5-itx-pcie-refclk-dtsi-v3-0-58f2cea72030@superkali.me>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Peng Fan <peng.fan@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Sean Anderson <sean.anderson@linux.dev>, 
 Richard Genoud <richard.genoud@bootlin.com>, Simon Glass <sjg@chromium.org>, 
 Peter Korsgaard <peter@korsgaard.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Daniele Briguglio <hello@superkali.me>, Jonas Karlman <jonas@kwiboo.se>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779257127; l=5029;
 i=hello@superkali.me; h=from:subject:message-id;
 bh=YGCDiooiq65Ay+YmzLEYUpNZEy6K+4PPRzs7RKiDC5E=;
 b=RprZMZUngFRhYeogAoaiC+ZO/FpkavcJbM2yOhKooKsOiTSZeTdHS8iESewxh8fHMN1wW9j67
 IxMNaNqDAzkAMZqgxT2i1hwTr+gC7bWQoGY8fmdSPIzwwzrl6AQUux/
X-Developer-Key: i=hello@superkali.me; a=ed25519;
 pk=5tynRWQdL93CDcapJ73FkcCRY2PeBOJOIAoIhRig53U=
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - fr5000-r.dnsiaas.com
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - superkali.me
X-Get-Message-Sender-Via: fr5000-r.dnsiaas.com: authenticated_id:
 hello@superkali.me
X-Authenticated-Sender: fr5000-r.dnsiaas.com: hello@superkali.me
X-Source: 
X-Source-Args: 
X-Source-Dir: 
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

Add a UCLASS_CLK driver matching the Linux DT binding documented at
Documentation/devicetree/bindings/clock/gated-fixed-clock.yaml, a
fixed-rate oscillator whose output is enabled by toggling a
regulator supply.  The optional enable-gpios variant is not
implemented.

The first user in U-Boot will be rk3588-rock-5-itx, where the PCIe3
ports reference a PI6C 100MHz oscillator declared with this
compatible and pcie_dw_rockchip currently fails clk_get_by_index()
with -ENODEV on every boot since v2026.04.

Suggested-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Daniele Briguglio <hello@superkali.me>
---
 MAINTAINERS                   |  5 +++
 drivers/clk/Kconfig           |  9 +++++
 drivers/clk/Makefile          |  1 +
 drivers/clk/clk-gated-fixed.c | 84 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 99 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ea646f618..67ba55d83 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1268,6 +1268,11 @@ F:	tools/fwumdata_src/fwumdata.c
 F:	tools/fwumdata_src/fwumdata.h
 F:	tools/fwumdata_src/mkfwumdata.c
 
+GATED FIXED-RATE CLOCK DRIVER
+M:	Daniele Briguglio <hello@superkali.me>
+S:	Maintained
+F:	drivers/clk/clk-gated-fixed.c
+
 GATEWORKS_SC
 M:	Tim Harvey <tharvey@gateworks.com>
 S:	Maintained
diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index c2da7b393..0c2f4698e 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -94,6 +94,15 @@ config CLK_COMPOSITE_CCF
 	  Enable this option if you want to (re-)use the Linux kernel's Common
 	  Clock Framework [CCF] composite code in U-Boot's clock driver.
 
+config CLK_GATED_FIXED
+	bool "Regulator-gated fixed-rate clock driver"
+	depends on CLK && DM_REGULATOR
+	help
+	  Enable this option to add a driver for fixed-rate clocks whose
+	  output is gated by a regulator supply, described in the device
+	  tree with the "gated-fixed-clock" compatible.  Typical use is
+	  external PCIe reference clock generators on Rockchip boards.
+
 config CLK_GPIO
 	bool "GPIO-controlled clock gate driver"
 	depends on CLK
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 5f0c0d8a5..338ddc029 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_$(PHASE_)CLK) += clk_fixed_factor.o
 obj-$(CONFIG_$(PHASE_)CLK_CCF) += clk.o clk-divider.o clk-mux.o clk-gate.o
 obj-$(CONFIG_$(PHASE_)CLK_CCF) += clk-fixed-factor.o
 obj-$(CONFIG_$(PHASE_)CLK_COMPOSITE_CCF) += clk-composite.o
+obj-$(CONFIG_$(PHASE_)CLK_GATED_FIXED) += clk-gated-fixed.o
 obj-$(CONFIG_$(PHASE_)CLK_GPIO) += clk-gpio.o
 obj-$(CONFIG_$(PHASE_)CLK_STUB) += clk-stub.o
 
diff --git a/drivers/clk/clk-gated-fixed.c b/drivers/clk/clk-gated-fixed.c
new file mode 100644
index 000000000..d52f278d7
--- /dev/null
+++ b/drivers/clk/clk-gated-fixed.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2026 Daniele Briguglio <hello@superkali.me>
+ *
+ * Clock driver for a fixed-rate oscillator gated by a regulator
+ * supply (Linux DT binding "gated-fixed-clock").
+ */
+
+#define LOG_CATEGORY UCLASS_CLK
+
+#include <clk-uclass.h>
+#include <dm.h>
+#include <errno.h>
+#include <log.h>
+#include <power/regulator.h>
+#include <dm/device_compat.h>
+
+struct clk_gated_fixed_priv {
+	struct udevice	*supply;
+	ulong		rate;
+};
+
+static int clk_gated_fixed_enable(struct clk *clk)
+{
+	struct clk_gated_fixed_priv *priv = dev_get_priv(clk->dev);
+
+	return regulator_set_enable_if_allowed(priv->supply, true);
+}
+
+static int clk_gated_fixed_disable(struct clk *clk)
+{
+	struct clk_gated_fixed_priv *priv = dev_get_priv(clk->dev);
+
+	return regulator_set_enable_if_allowed(priv->supply, false);
+}
+
+static ulong clk_gated_fixed_get_rate(struct clk *clk)
+{
+	struct clk_gated_fixed_priv *priv = dev_get_priv(clk->dev);
+
+	return priv->rate;
+}
+
+static const struct clk_ops clk_gated_fixed_ops = {
+	.enable		= clk_gated_fixed_enable,
+	.disable	= clk_gated_fixed_disable,
+	.get_rate	= clk_gated_fixed_get_rate,
+};
+
+static int clk_gated_fixed_probe(struct udevice *dev)
+{
+	struct clk_gated_fixed_priv *priv = dev_get_priv(dev);
+	u32 rate;
+	int ret;
+
+	ret = dev_read_u32(dev, "clock-frequency", &rate);
+	if (ret) {
+		dev_err(dev, "missing clock-frequency: %d\n", ret);
+		return ret;
+	}
+	priv->rate = rate;
+
+	ret = device_get_supply_regulator(dev, "vdd-supply", &priv->supply);
+	if (ret) {
+		dev_err(dev, "failed to get vdd-supply: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct udevice_id clk_gated_fixed_match[] = {
+	{ .compatible = "gated-fixed-clock" },
+	{ /* sentinel */ }
+};
+
+U_BOOT_DRIVER(gated_fixed_clock) = {
+	.name		= "gated_fixed_clock",
+	.id		= UCLASS_CLK,
+	.of_match	= clk_gated_fixed_match,
+	.probe		= clk_gated_fixed_probe,
+	.priv_auto	= sizeof(struct clk_gated_fixed_priv),
+	.ops		= &clk_gated_fixed_ops,
+};

-- 
2.47.3

