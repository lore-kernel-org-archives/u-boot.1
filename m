Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD47DC83F0F
	for <u-boot@archiver.kernel.org>; Thu, 10 Jul 2025 03:43:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48666835CD;
	Thu, 10 Jul 2025 05:43:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="TQpL8Xrj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91B4483642; Thu, 10 Jul 2025 05:43:15 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FB88834BC
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 05:43:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 45A542082E;
 Thu, 10 Jul 2025 05:43:13 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iCO5ZbIC5ZCp; Thu, 10 Jul 2025 05:43:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1752118991; bh=/YGiJuPTEHqWGkIZFbJlU0+3PaChlWujblz9waxz1W0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=TQpL8Xrj7SBDEkakAjWvUcZwYHnICBUW8+9MjpfyzHWBUIJD8ALAeNBgIAYwlYbZg
 sipg3pUOU2bcbuAu0zbflb+pJeFJ4r3OK+ywZqZXQkvq80BC3AZGLwFSo5MLqfSnaw
 zvaqlVt9a6z04NUiPmUdqQz0iFGs/342xQMqLCEtXLOcxe8F5JIJIoGhUe9Jr49EH/
 cqWwnOlfggn7XY96pYeWyeD9VpSb4fh2SNZdfDftlpAwFcnPCoAGHV48vvkdn3Em9+
 ZGaNfPhs9vg3eZbKu9+XOv4MDvvw1unZlxP9AbC6lzLbBBmafI5JbQkRdGCq81KJ8L
 mv1YqrWuzDyrw==
From: Yao Zi <ziyao@disroot.org>
To: Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Wei Fu <wefu@redhat.com>,
 Yixun Lan <dlan@gentoo.org>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Maksim Kiselev <bigunclemax@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, Han Gao <rabenda.cn@gmail.com>,
 Han Gao <gaohan@iscas.ac.cn>, Yao Zi <ziyao@disroot.org>
Subject: [PATCH 3/5] drivers: net: Add T-Head DWMAC glue layer
Date: Thu, 10 Jul 2025 03:41:59 +0000
Message-ID: <20250710034201.39901-4-ziyao@disroot.org>
In-Reply-To: <20250710034201.39901-1-ziyao@disroot.org>
References: <20250710034201.39901-1-ziyao@disroot.org>
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

The Designware IP integrated in TH1520 SoC requires extra clock
configuration to operate correctly. The Linux kernel's T-Head DWMAC glue
driver is ported and adapted to U-Boot's API.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 MAINTAINERS               |   1 +
 drivers/net/Kconfig       |   8 ++
 drivers/net/Makefile      |   1 +
 drivers/net/dwmac_thead.c | 288 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 298 insertions(+)
 create mode 100644 drivers/net/dwmac_thead.c

diff --git a/MAINTAINERS b/MAINTAINERS
index d5264c8f5df..438f24f1ff7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1576,6 +1576,7 @@ M:	Yao Zi <ziyao@disroot.org>
 S:	Maintained
 F:	arch/riscv/cpu/th1520/
 F:	drivers/clk/thead/clk-th1520-ap.c
+F:	drivers/net/dwmac_thead.c
 F:	drivers/pinctrl/pinctrl-th1520.c
 F:	drivers/ram/thead/th1520_ddr.c
 
diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 950ed0f25a9..d942fa4e202 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -411,6 +411,14 @@ config ETH_DESIGNWARE_S700
 	  This provides glue layer to use Synopsys Designware Ethernet MAC
 	  present on Actions S700 SoC.
 
+config ETH_DESIGNWARE_THEAD
+	bool "T-Head glue driver for Synopsys Designware Ethernet MAC"
+	depends on ETH_DESIGNWARE
+	select DW_ALTDESCRIPTOR
+	help
+	  This provides glue layer to use Synopsys Designware Ethernet MAC
+	  present on T-Head SoCs.
+
 config DW_ALTDESCRIPTOR
 	bool "Designware Ethernet MAC uses alternate (enhanced) descriptors"
 	depends on ETH_DESIGNWARE
diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index 67bba3a8536..79cc8b422b0 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -38,6 +38,7 @@ obj-$(CONFIG_ETH_DESIGNWARE) += designware.o
 obj-$(CONFIG_ETH_DESIGNWARE_MESON8B) += dwmac_meson8b.o
 obj-$(CONFIG_ETH_DESIGNWARE_S700) += dwmac_s700.o
 obj-$(CONFIG_ETH_DESIGNWARE_SOCFPGA) += dwmac_socfpga.o
+obj-$(CONFIG_ETH_DESIGNWARE_THEAD) += dwmac_thead.o
 obj-$(CONFIG_ETH_SANDBOX) += sandbox.o
 obj-$(CONFIG_ETH_SANDBOX_RAW) += sandbox-raw-bus.o
 obj-$(CONFIG_ETH_SANDBOX_RAW) += sandbox-raw.o
diff --git a/drivers/net/dwmac_thead.c b/drivers/net/dwmac_thead.c
new file mode 100644
index 00000000000..138d71a6202
--- /dev/null
+++ b/drivers/net/dwmac_thead.c
@@ -0,0 +1,288 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * T-HEAD DWMAC platform driver
+ *
+ * Copyright (C) 2021 Alibaba Group Holding Limited.
+ * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
+ * Copyright (C) 2025 Yao Zi <ziyao@disroot.org>
+ *
+ */
+
+#include <asm/io.h>
+#include <clk.h>
+#include <dm.h>
+#include <linux/bitfield.h>
+#include <phy.h>
+
+#include "designware.h"
+
+#define GMAC_CLK_EN			0x00
+#define  GMAC_TX_CLK_EN			BIT(1)
+#define  GMAC_TX_CLK_N_EN		BIT(2)
+#define  GMAC_TX_CLK_OUT_EN		BIT(3)
+#define  GMAC_RX_CLK_EN			BIT(4)
+#define  GMAC_RX_CLK_N_EN		BIT(5)
+#define  GMAC_EPHY_REF_CLK_EN		BIT(6)
+#define GMAC_RXCLK_DELAY_CTRL		0x04
+#define  GMAC_RXCLK_BYPASS		BIT(15)
+#define  GMAC_RXCLK_INVERT		BIT(14)
+#define  GMAC_RXCLK_DELAY		GENMASK(4, 0)
+#define GMAC_TXCLK_DELAY_CTRL		0x08
+#define  GMAC_TXCLK_BYPASS		BIT(15)
+#define  GMAC_TXCLK_INVERT		BIT(14)
+#define  GMAC_TXCLK_DELAY		GENMASK(4, 0)
+#define GMAC_PLLCLK_DIV			0x0c
+#define  GMAC_PLLCLK_DIV_EN		BIT(31)
+#define  GMAC_PLLCLK_DIV_NUM		GENMASK(7, 0)
+#define GMAC_GTXCLK_SEL			0x18
+#define  GMAC_GTXCLK_SEL_PLL		BIT(0)
+#define GMAC_INTF_CTRL			0x1c
+#define  PHY_INTF_MASK			BIT(0)
+#define  PHY_INTF_RGMII			FIELD_PREP(PHY_INTF_MASK, 1)
+#define  PHY_INTF_MII_GMII		FIELD_PREP(PHY_INTF_MASK, 0)
+#define GMAC_TXCLK_OEN			0x20
+#define  TXCLK_DIR_MASK			BIT(0)
+#define  TXCLK_DIR_OUTPUT		FIELD_PREP(TXCLK_DIR_MASK, 0)
+#define  TXCLK_DIR_INPUT		FIELD_PREP(TXCLK_DIR_MASK, 1)
+
+#define GMAC_RGMII_CLK_RATE		125000000
+
+struct dwmac_thead_plat {
+	struct dw_eth_pdata dw_eth_pdata;
+	void __iomem *apb_base;
+};
+
+static int dwmac_thead_set_phy_if(struct dwmac_thead_plat *plat)
+{
+	u32 phyif;
+
+	switch (plat->dw_eth_pdata.eth_pdata.phy_interface) {
+	case PHY_INTERFACE_MODE_MII:
+		phyif = PHY_INTF_MII_GMII;
+		break;
+	case PHY_INTERFACE_MODE_RGMII:
+	case PHY_INTERFACE_MODE_RGMII_ID:
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+		phyif = PHY_INTF_RGMII;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	writel(phyif, plat->apb_base + GMAC_INTF_CTRL);
+	return 0;
+}
+
+static int dwmac_thead_set_txclk_dir(struct dwmac_thead_plat *plat)
+{
+	u32 txclk_dir;
+
+	switch (plat->dw_eth_pdata.eth_pdata.phy_interface) {
+	case PHY_INTERFACE_MODE_MII:
+		txclk_dir = TXCLK_DIR_INPUT;
+		break;
+	case PHY_INTERFACE_MODE_RGMII:
+	case PHY_INTERFACE_MODE_RGMII_ID:
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+		txclk_dir = TXCLK_DIR_OUTPUT;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	writel(txclk_dir, plat->apb_base + GMAC_TXCLK_OEN);
+	return 0;
+}
+
+static unsigned long dwmac_thead_rgmii_tx_rate(int speed)
+{
+	switch (speed) {
+	case 10:
+		return 2500000;
+	case 100:
+		return 25000000;
+	case 1000:
+		return 125000000;
+	}
+
+	return -EINVAL;
+}
+
+static int dwmac_thead_set_clk_tx_rate(struct dwmac_thead_plat *plat,
+				       struct dw_eth_dev *edev,
+				       unsigned long tx_rate)
+{
+	unsigned long rate;
+	u32 div, reg;
+
+	rate = clk_get_rate(&edev->clocks[0]);
+
+	writel(0, plat->apb_base + GMAC_PLLCLK_DIV);
+
+	div = rate / tx_rate;
+	if (rate != tx_rate * div) {
+		pr_err("invalid gmac rate %lu\n", rate);
+		return -EINVAL;
+	}
+
+	reg = FIELD_PREP(GMAC_PLLCLK_DIV_EN, 1) |
+	      FIELD_PREP(GMAC_PLLCLK_DIV_NUM, div);
+		writel(reg, plat->apb_base + GMAC_PLLCLK_DIV);
+
+	return 0;
+}
+
+static int dwmac_thead_enable_clk(struct dwmac_thead_plat *plat)
+{
+	u32 reg;
+
+	switch (plat->dw_eth_pdata.eth_pdata.phy_interface) {
+	case PHY_INTERFACE_MODE_MII:
+		reg = GMAC_RX_CLK_EN | GMAC_TX_CLK_EN;
+		break;
+
+	case PHY_INTERFACE_MODE_RGMII:
+	case PHY_INTERFACE_MODE_RGMII_ID:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+		/* use pll */
+		writel(GMAC_GTXCLK_SEL_PLL, plat->apb_base + GMAC_GTXCLK_SEL);
+		reg = GMAC_TX_CLK_EN | GMAC_TX_CLK_N_EN | GMAC_TX_CLK_OUT_EN |
+		      GMAC_RX_CLK_EN | GMAC_RX_CLK_N_EN;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	writel(reg, plat->apb_base + GMAC_CLK_EN);
+	return 0;
+}
+
+static int dwmac_thead_eth_start(struct udevice *dev)
+{
+	struct dwmac_thead_plat *plat = dev_get_plat(dev);
+	struct dw_eth_dev *edev = dev_get_priv(dev);
+	phy_interface_t interface;
+	bool is_rgmii;
+	long tx_rate;
+	int ret;
+
+	interface = plat->dw_eth_pdata.eth_pdata.phy_interface;
+	is_rgmii = (interface == PHY_INTERFACE_MODE_RGMII)	|
+		   (interface == PHY_INTERFACE_MODE_RGMII_ID)	|
+		   (interface == PHY_INTERFACE_MODE_RGMII_RXID)	|
+		   (interface == PHY_INTERFACE_MODE_RGMII_TXID);
+
+	/*
+	 * When operating in RGMII mode, the TX clock is generated by an
+	 * internal divider and fed to the MAC. Configure and enable it before
+	 * initializing the MAC.
+	 */
+	if (is_rgmii) {
+		ret = dwmac_thead_set_clk_tx_rate(plat, edev,
+						  GMAC_RGMII_CLK_RATE);
+		if (ret)
+			return ret;
+	}
+
+	ret = designware_eth_init(edev, plat->dw_eth_pdata.eth_pdata.enetaddr);
+	if (ret)
+		return ret;
+
+	if (is_rgmii) {
+		tx_rate = dwmac_thead_rgmii_tx_rate(edev->phydev->speed);
+		if (tx_rate < 0)
+			return tx_rate;
+
+		ret = dwmac_thead_set_clk_tx_rate(plat, edev, tx_rate);
+		if (ret)
+			return ret;
+	}
+
+	ret = designware_eth_enable(edev);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int dwmac_thead_probe(struct udevice *dev)
+{
+	struct dwmac_thead_plat *plat = dev_get_plat(dev);
+	unsigned int reg;
+	int ret;
+
+	ret = designware_eth_probe(dev);
+	if (ret)
+		return ret;
+
+	ret = dwmac_thead_set_phy_if(plat);
+	if (ret) {
+		pr_err("failed to set phy interface: %d\n", ret);
+		return ret;
+	}
+
+	ret = dwmac_thead_set_txclk_dir(plat);
+	if (ret) {
+		pr_err("failed to set TX clock direction: %d\n", ret);
+		return ret;
+	}
+
+	reg = readl(plat->apb_base + GMAC_RXCLK_DELAY_CTRL);
+	reg &= ~(GMAC_RXCLK_DELAY);
+	reg |= FIELD_PREP(GMAC_RXCLK_DELAY, 0);
+	writel(reg, plat->apb_base + GMAC_RXCLK_DELAY_CTRL);
+
+	reg = readl(plat->apb_base + GMAC_TXCLK_DELAY_CTRL);
+	reg &= ~(GMAC_TXCLK_DELAY);
+	reg |= FIELD_PREP(GMAC_TXCLK_DELAY, 0);
+	writel(reg, plat->apb_base + GMAC_TXCLK_DELAY_CTRL);
+
+	ret = dwmac_thead_enable_clk(plat);
+	if (ret)
+		pr_err("failed to enable clock: %d\n", ret);
+
+	return ret;
+}
+
+static int dwmac_thead_of_to_plat(struct udevice *dev)
+{
+	struct dwmac_thead_plat *pdata = dev_get_plat(dev);
+
+	pdata->apb_base = dev_read_addr_index_ptr(dev, 1);
+	if (!pdata->apb_base) {
+		pr_err("failed to get apb registers\n");
+		return -ENOENT;
+	}
+
+	return designware_eth_of_to_plat(dev);
+}
+
+static const struct eth_ops dwmac_thead_eth_ops = {
+	.start                  = dwmac_thead_eth_start,
+	.send                   = designware_eth_send,
+	.recv                   = designware_eth_recv,
+	.free_pkt               = designware_eth_free_pkt,
+	.stop                   = designware_eth_stop,
+	.write_hwaddr           = designware_eth_write_hwaddr,
+};
+
+static const struct udevice_id dwmac_thead_match[] = {
+	{ .compatible = "thead,th1520-gmac" },
+	{ /* sentinel */ }
+};
+
+U_BOOT_DRIVER(dwmac_thead) = {
+	.name		= "dwmac_thead",
+	.id		= UCLASS_ETH,
+	.of_match	= dwmac_thead_match,
+	.of_to_plat	= dwmac_thead_of_to_plat,
+	.probe		= dwmac_thead_probe,
+	.ops		= &dwmac_thead_eth_ops,
+	.priv_auto	= sizeof(struct dw_eth_dev),
+	.plat_auto	= sizeof(struct dwmac_thead_plat),
+	.flags		= DM_FLAG_ALLOC_PRIV_DMA,
+};
-- 
2.50.0

