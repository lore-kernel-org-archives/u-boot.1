Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39A74CD5BC9
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 00:43:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72D5084963;
	Tue, 26 May 2026 02:42:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E72F484926; Tue, 26 May 2026 02:36:53 +0200 (CEST)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6CD584940
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 02:36:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=aspeedtech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ryan_chen@aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 26 May
 2026 08:36:41 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 26 May 2026 08:36:41 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Tue, 26 May 2026 08:36:41 +0800
Subject: [PATCH v3 4/5] reset: ast2700: add reset driver support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260526-ast2700_clk-v3-4-a4cd24c214d6@aspeedtech.com>
References: <20260526-ast2700_clk-v3-0-a4cd24c214d6@aspeedtech.com>
In-Reply-To: <20260526-ast2700_clk-v3-0-a4cd24c214d6@aspeedtech.com>
To: Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
 <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, "Chia-Wei
 Wang" <chiawei_wang@aspeedtech.com>, Sumit Garg <sumit.garg@kernel.org>,
 Anshul Dalal <anshuld@ti.com>, Svyatoslav Ryhel <clamor95@gmail.com>, "Tien
 Fong Chee" <tien.fong.chee@altera.com>, Andre Przywara
 <andre.przywara@arm.com>, Frieder Schrempf <frieder.schrempf@kontron.de>,
 Peng Fan <peng.fan@nxp.com>, Ernest Van Hoecke
 <ernest.vanhoecke@toradex.com>, Brian Sune <briansune@gmail.com>, "Johan
 Jonker" <jbx6244@gmail.com>, Hai Pham <hai.pham.ud@renesas.com>, David
 Lechner <dlechner@baylibre.com>, Emanuele Ghidoli
 <emanuele.ghidoli@toradex.com>, Parth Pancholi <parth.pancholi@toradex.com>,
 Paresh Bhagat <p-bhagat@ti.com>, Janne Grunau <j@jannau.net>, Paul
 Kocialkowski <contact@paulk.fr>, "Patrice Chotard"
 <patrice.chotard@foss.st.com>, Gabriel Fernandez
 <gabriel.fernandez@foss.st.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Finley Xiao <finley.xiao@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Yao Zi <me@ziyao.cc>, "Kuan-Wei
 Chiu" <visitorckw@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>,
 "Quentin Schulz" <quentin.schulz@cherry.de>, Stefan Roese
 <stefan.roese@mailbox.org>, Jerome Forissier <jerome.forissier@arm.com>,
 Philip Molloy <philip.molloy@analog.com>, Ryan Chen
 <ryan_chen@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779755800; l=4018;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=EConpnLwOZ12EKxveH6ZUaqwaqZL8Orb1AwMrzgkHgo=;
 b=UOtcYt5vjoCEvwAD0iC5/Nqi4Ssi7raik5GyDr/yTyGPneqX2/N0HhcAWJbR/MMqT74pcMjBL
 qz2hF32GOg6DTPiul0GGm2AGUSIy1Yad0ctVD5J74WtaDM/yLahERs6
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=
X-Mailman-Approved-At: Tue, 26 May 2026 02:42:34 +0200
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

Add reset controller driver for the dual-die AST2700 SoC. The
controller manages module-level reset signals via the modrst
register block at offset 0x200 within each SCU.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
 drivers/reset/Kconfig         |  9 +++++
 drivers/reset/Makefile        |  1 +
 drivers/reset/reset-ast2700.c | 82 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 92 insertions(+)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index ebf484d9df4..0af5d4b104e 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -91,6 +91,15 @@ config RESET_AST2600
 	  Say Y if you want to control reset signals of different peripherals
 	  through System Control Unit (SCU).
 
+config RESET_AST2700
+	bool "Reset controller driver for AST2700 SoCs"
+	depends on DM_RESET && ASPEED_AST2700
+	default y if ASPEED_AST2700
+	help
+	  Support for reset controller on AST2700 SoC.
+	  Say Y if you want to control reset signals of different peripherals
+	  through System Control Unit (SCU).
+
 config RESET_ROCKCHIP
 	bool "Reset controller driver for Rockchip SoCs"
 	depends on DM_RESET && ARCH_ROCKCHIP && CLK
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 088545c6473..e722b940e9c 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_RESET_BCM6345) += reset-bcm6345.o
 obj-$(CONFIG_RESET_UNIPHIER) += reset-uniphier.o
 obj-$(CONFIG_RESET_AST2500) += reset-ast2500.o
 obj-$(CONFIG_RESET_AST2600) += reset-ast2600.o
+obj-$(CONFIG_RESET_AST2700) += reset-ast2700.o
 obj-$(CONFIG_RESET_ROCKCHIP) += reset-rockchip.o rst-rk3506.o rst-rk3528.o rst-rk3576.o rst-rk3588.o
 obj-$(CONFIG_RESET_MESON) += reset-meson.o
 obj-$(CONFIG_RESET_SOCFPGA) += reset-socfpga.o
diff --git a/drivers/reset/reset-ast2700.c b/drivers/reset/reset-ast2700.c
new file mode 100644
index 00000000000..2dd9e36cc0a
--- /dev/null
+++ b/drivers/reset/reset-ast2700.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) ASPEED Technology Inc.
+ */
+
+#include <asm/io.h>
+#include <dm.h>
+#include <linux/err.h>
+#include <reset.h>
+#include <reset-uclass.h>
+
+/* Offset of the modrst register block within the SCU. */
+#define AST2700_RESET_OFFSET	0x200
+
+struct ast2700_reset_priv {
+	void __iomem *base;
+};
+
+static int ast2700_reset_assert(struct reset_ctl *reset_ctl)
+{
+	struct ast2700_reset_priv *priv = dev_get_priv(reset_ctl->dev);
+
+	if (reset_ctl->id < 32)
+		writel(BIT(reset_ctl->id), priv->base);
+	else
+		writel(BIT(reset_ctl->id - 32), priv->base + 0x20);
+
+	return 0;
+}
+
+static int ast2700_reset_deassert(struct reset_ctl *reset_ctl)
+{
+	struct ast2700_reset_priv *priv = dev_get_priv(reset_ctl->dev);
+
+	if (reset_ctl->id < 32)
+		writel(BIT(reset_ctl->id), priv->base + 0x04);
+	else
+		writel(BIT(reset_ctl->id - 32), priv->base + 0x24);
+
+	return 0;
+}
+
+static int ast2700_reset_status(struct reset_ctl *reset_ctl)
+{
+	struct ast2700_reset_priv *priv = dev_get_priv(reset_ctl->dev);
+	int status;
+
+	if (reset_ctl->id < 32)
+		status = BIT(reset_ctl->id) & readl(priv->base);
+	else
+		status = BIT(reset_ctl->id - 32) & readl(priv->base + 0x20);
+
+	return !!status;
+}
+
+static int ast2700_reset_probe(struct udevice *dev)
+{
+	struct ast2700_reset_priv *priv = dev_get_priv(dev);
+	void __iomem *scu_base;
+
+	scu_base = dev_read_addr_ptr(dev);
+	if (!scu_base)
+		return -EINVAL;
+
+	priv->base = scu_base + AST2700_RESET_OFFSET;
+
+	return 0;
+}
+
+static const struct reset_ops ast2700_reset_ops = {
+	.rst_assert = ast2700_reset_assert,
+	.rst_deassert = ast2700_reset_deassert,
+	.rst_status = ast2700_reset_status,
+};
+
+U_BOOT_DRIVER(ast2700_reset) = {
+	.name = "ast2700_reset",
+	.id = UCLASS_RESET,
+	.probe = ast2700_reset_probe,
+	.ops = &ast2700_reset_ops,
+	.priv_auto = sizeof(struct ast2700_reset_priv),
+};

-- 
2.34.1

