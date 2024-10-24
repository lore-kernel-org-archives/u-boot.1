Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 334A2CE8E8A
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 15:28:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DA1F8907D;
	Thu, 24 Oct 2024 17:26:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71FC689070; Thu, 24 Oct 2024 17:26:06 +0200 (CEST)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by phobos.denx.de (Postfix) with ESMTP id F31A389023
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 17:25:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.11,229,1725289200"; d="scan'208";a="226888020"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie6.idc.renesas.com with ESMTP; 25 Oct 2024 00:25:54 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.93.183])
 by relmlir5.idc.renesas.com (Postfix) with ESMTP id AF3454008C65;
 Fri, 25 Oct 2024 00:25:42 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Sumit Garg <sumit.garg@linaro.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
	u-boot@lists.denx.de
Subject: [PATCH 11/14] net: ravb: Add RZ/G2L Support
Date: Thu, 24 Oct 2024 16:24:45 +0100
Message-Id: <20241024152448.102-12-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241024152448.102-1-paul.barker.ct@bp.renesas.com>
References: <20241024152448.102-1-paul.barker.ct@bp.renesas.com>
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

The Renesas R9A07G044L (RZ/G2L) SoC includes two Gigabit Ethernet
interfaces which can be supported using the ravb driver. Some RZ/G2L
specific steps need to be taken during initialization due to differences
between this SoC and previously supported SoCs. We also need to ensure
that the module reset is de-asserted after the module clock is enabled
but before any Ethernet register reads/writes take place.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 arch/arm/mach-renesas/Kconfig |   1 +
 drivers/net/Kconfig           |   2 +
 drivers/net/ravb.c            | 183 ++++++++++++++++++++++++++++++++--
 3 files changed, 176 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-renesas/Kconfig b/arch/arm/mach-renesas/Kconfig
index aeb55da609bd..d373ab56ce91 100644
--- a/arch/arm/mach-renesas/Kconfig
+++ b/arch/arm/mach-renesas/Kconfig
@@ -76,6 +76,7 @@ config RZG2L
 	imply MULTI_DTB_FIT
 	imply MULTI_DTB_FIT_USER_DEFINED_AREA
 	imply PINCTRL_RZG2L
+	imply RENESAS_RAVB
 	imply RENESAS_SDHI
 	imply RZG2L_GPIO
 	imply SCIF_CONSOLE
diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 89f7411bdf33..d009acdcd94f 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -822,6 +822,8 @@ config RENESAS_RAVB
 	depends on RCAR_64
 	select PHYLIB
 	select PHY_ETHERNET_ID
+	select BITBANGMII
+	select BITBANGMII_MULTI
 	help
 	  This driver implements support for the Ethernet AVB block in
 	  Renesas M3 and H3 SoCs.
diff --git a/drivers/net/ravb.c b/drivers/net/ravb.c
index fb869cd0872e..e2ab929858c8 100644
--- a/drivers/net/ravb.c
+++ b/drivers/net/ravb.c
@@ -24,6 +24,7 @@
 #include <asm/io.h>
 #include <asm/global_data.h>
 #include <asm/gpio.h>
+#include <reset.h>
 
 /* Registers */
 #define RAVB_REG_CCC		0x000
@@ -31,12 +32,14 @@
 #define RAVB_REG_CSR		0x00C
 #define RAVB_REG_APSR		0x08C
 #define RAVB_REG_RCR		0x090
+#define RAVB_REG_RTC		0x0B4
 #define RAVB_REG_TGC		0x300
 #define RAVB_REG_TCCR		0x304
 #define RAVB_REG_RIC0		0x360
 #define RAVB_REG_RIC1		0x368
 #define RAVB_REG_RIC2		0x370
 #define RAVB_REG_TIC		0x378
+#define RAVB_REG_RIC3		0x388
 #define RAVB_REG_ECMR		0x500
 #define RAVB_REG_RFLR		0x508
 #define RAVB_REG_ECSIPR		0x518
@@ -44,6 +47,7 @@
 #define RAVB_REG_GECMR		0x5b0
 #define RAVB_REG_MAHR		0x5c0
 #define RAVB_REG_MALR		0x5c8
+#define RAVB_REG_CSR0		0x800
 
 #define CCC_OPC_CONFIG		BIT(0)
 #define CCC_OPC_OPERATION	BIT(1)
@@ -65,14 +69,24 @@
 #define PIR_MDC			BIT(0)
 
 #define ECMR_TRCCM		BIT(26)
+#define ECMR_RCPT		BIT(25)
 #define ECMR_RZPF		BIT(20)
 #define ECMR_PFR		BIT(18)
 #define ECMR_RXF		BIT(17)
+#define ECMR_TXF		BIT(16)
 #define ECMR_RE			BIT(6)
 #define ECMR_TE			BIT(5)
 #define ECMR_DM			BIT(1)
+#define ECMR_PRM		BIT(0)
 #define ECMR_CHG_DM		(ECMR_TRCCM | ECMR_RZPF | ECMR_PFR | ECMR_RXF)
 
+#define CSR0_RPE		BIT(5)
+#define CSR0_TPE		BIT(4)
+
+#define GECMR_SPEED_10M		(0 << 4)
+#define GECMR_SPEED_100M	(1 << 4)
+#define GECMR_SPEED_1G		(2 << 4)
+
 /* DMA Descriptors */
 #define RAVB_NUM_BASE_DESC		16
 #define RAVB_NUM_TX_DESC		8
@@ -108,6 +122,16 @@
 
 #define RAVB_TX_TIMEOUT_MS		1000
 
+#define RAVB_RCV_BUFF_MAX		8192
+
+struct ravb_device_ops {
+	int (*mac_init)(struct udevice *dev);
+	int (*dmac_init)(struct udevice *dev);
+	int (*config)(struct udevice *dev);
+	int (*reset_deassert)(struct udevice *dev);
+	void (*reset_assert)(struct udevice *dev);
+};
+
 struct ravb_desc {
 	u32	ctrl;
 	u32	dptr;
@@ -131,6 +155,7 @@ struct ravb_priv {
 	struct mii_dev		*bus;
 	void __iomem		*iobase;
 	struct clk_bulk		clks;
+	struct reset_ctl	rst;
 };
 
 static inline void ravb_flush_dcache(u32 addr, u32 len)
@@ -350,8 +375,25 @@ static int ravb_write_hwaddr(struct udevice *dev)
 }
 
 /* E-MAC init function */
-static int ravb_mac_init(struct ravb_priv *eth)
+static int ravb_mac_init_rzg2l(struct udevice *dev)
 {
+	struct ravb_priv *eth = dev_get_priv(dev);
+
+	setbits_32(eth->iobase + RAVB_REG_ECMR,
+		   ECMR_PRM | ECMR_RXF | ECMR_TXF | ECMR_RCPT |
+		   ECMR_TE | ECMR_RE | ECMR_RZPF |
+		   (eth->phydev->duplex ? ECMR_DM : 0));
+
+	/* Recv frame limit set register */
+	writel(RAVB_RCV_BUFF_MAX + ETH_FCS_LEN, eth->iobase + RAVB_REG_RFLR);
+
+	return 0;
+}
+
+static int ravb_mac_init_rcar(struct udevice *dev)
+{
+	struct ravb_priv *eth = dev_get_priv(dev);
+
 	/* Disable MAC Interrupt */
 	writel(0, eth->iobase + RAVB_REG_ECSIPR);
 
@@ -364,12 +406,10 @@ static int ravb_mac_init(struct ravb_priv *eth)
 /* AVB-DMAC init function */
 static int ravb_dmac_init(struct udevice *dev)
 {
+	struct ravb_device_ops *device_ops =
+		(struct ravb_device_ops *)dev_get_driver_data(dev);
 	struct ravb_priv *eth = dev_get_priv(dev);
-	struct eth_pdata *pdata = dev_get_plat(dev);
-	int ret = 0;
-	int mode = 0;
-	unsigned int delay;
-	bool explicit_delay = false;
+	int ret;
 
 	/* Set CONFIG mode */
 	ret = ravb_reset(dev);
@@ -385,6 +425,27 @@ static int ravb_dmac_init(struct udevice *dev)
 	/* Set little endian */
 	clrbits_le32(eth->iobase + RAVB_REG_CCC, CCC_BOC);
 
+	return device_ops->dmac_init(dev);
+}
+
+static int ravb_dmac_init_rzg2l(struct udevice *dev)
+{
+	struct ravb_priv *eth = dev_get_priv(dev);
+
+	/* Set Max Frame Length (RTC) */
+	writel(RAVB_RCV_BUFF_MAX, eth->iobase + RAVB_REG_RTC);
+
+	return 0;
+}
+
+static int ravb_dmac_init_rcar(struct udevice *dev)
+{
+	struct ravb_priv *eth = dev_get_priv(dev);
+	struct eth_pdata *pdata = dev_get_plat(dev);
+	int mode = 0;
+	unsigned int delay;
+	bool explicit_delay = false;
+
 	/* AVB rx set */
 	writel(0x18000001, eth->iobase + RAVB_REG_RCR);
 
@@ -429,22 +490,50 @@ static int ravb_dmac_init(struct udevice *dev)
 
 static int ravb_config(struct udevice *dev)
 {
+	struct ravb_device_ops *device_ops =
+		(struct ravb_device_ops *)dev_get_driver_data(dev);
 	struct ravb_priv *eth = dev_get_priv(dev);
 	struct phy_device *phy = eth->phydev;
-	u32 mask = ECMR_CHG_DM | ECMR_RE | ECMR_TE;
 	int ret;
 
 	/* Configure AVB-DMAC register */
 	ravb_dmac_init(dev);
 
 	/* Configure E-MAC registers */
-	ravb_mac_init(eth);
+	device_ops->mac_init(dev);
 	ravb_write_hwaddr(dev);
 
 	ret = phy_startup(phy);
 	if (ret)
 		return ret;
 
+	return device_ops->config(dev);
+}
+
+static int ravb_config_rzg2l(struct udevice *dev)
+{
+	struct ravb_priv *eth = dev_get_priv(dev);
+	struct phy_device *phy = eth->phydev;
+
+	writel(CSR0_TPE | CSR0_RPE, eth->iobase + RAVB_REG_CSR0);
+
+	/* Set the transfer speed */
+	if (phy->speed == 10)
+		writel(GECMR_SPEED_10M, eth->iobase + RAVB_REG_GECMR);
+	else if (phy->speed == 100)
+		writel(GECMR_SPEED_100M, eth->iobase + RAVB_REG_GECMR);
+	else if (phy->speed == 1000)
+		writel(GECMR_SPEED_1G, eth->iobase + RAVB_REG_GECMR);
+
+	return 0;
+}
+
+static int ravb_config_rcar(struct udevice *dev)
+{
+	struct ravb_priv *eth = dev_get_priv(dev);
+	struct phy_device *phy = eth->phydev;
+	u32 mask = ECMR_CHG_DM | ECMR_RE | ECMR_TE;
+
 	/* Set the transfer speed */
 	if (phy->speed == 100)
 		writel(0, eth->iobase + RAVB_REG_GECMR);
@@ -491,8 +580,47 @@ static void ravb_stop(struct udevice *dev)
 	ravb_reset(dev);
 }
 
+static int ravb_reset_deassert_rzg2l(struct udevice *dev)
+{
+	struct ravb_priv *eth = dev_get_priv(dev);
+	int ret;
+
+	ret = reset_get_by_index(dev, 0, &eth->rst);
+	if (ret < 0) {
+		dev_err(dev, "failed to get reset line\n");
+		return ret;
+	}
+
+	ret = reset_deassert(&eth->rst);
+	if (ret < 0) {
+		dev_err(dev, "failed to de-assert reset line\n");
+		reset_free(&eth->rst);
+	}
+
+	return ret;
+}
+
+static int ravb_reset_deassert_rcar(struct udevice *dev)
+{
+	return 0;
+}
+
+static void ravb_reset_assert_rzg2l(struct udevice *dev)
+{
+	struct ravb_priv *eth = dev_get_priv(dev);
+
+	reset_assert(&eth->rst);
+	reset_free(&eth->rst);
+}
+
+static void ravb_reset_assert_rcar(struct udevice *dev)
+{
+}
+
 static int ravb_probe(struct udevice *dev)
 {
+	struct ravb_device_ops *device_ops =
+		(struct ravb_device_ops *)dev_get_driver_data(dev);
 	struct eth_pdata *pdata = dev_get_plat(dev);
 	struct ravb_priv *eth = dev_get_priv(dev);
 	struct bb_miiphy_bus *phybus;
@@ -530,6 +658,10 @@ static int ravb_probe(struct udevice *dev)
 	if (ret)
 		goto err_mdio_register;
 
+	ret = device_ops->reset_deassert(dev);
+	if (ret)
+		goto err_reset_deassert;
+
 	ret = ravb_reset(dev);
 	if (ret)
 		goto err_mdio_reset;
@@ -541,6 +673,8 @@ static int ravb_probe(struct udevice *dev)
 	return 0;
 
 err_mdio_reset:
+	device_ops->reset_assert(dev);
+err_reset_deassert:
 	clk_release_bulk(&eth->clks);
 err_mdio_register:
 	mdio_free(mdiodev);
@@ -551,8 +685,11 @@ err_mdio_alloc:
 
 static int ravb_remove(struct udevice *dev)
 {
+	struct ravb_device_ops *device_ops =
+		(struct ravb_device_ops *)dev_get_driver_data(dev);
 	struct ravb_priv *eth = dev_get_priv(dev);
 
+	device_ops->reset_assert(dev);
 	clk_release_bulk(&eth->clks);
 
 	free(eth->phydev);
@@ -684,9 +821,35 @@ int ravb_of_to_plat(struct udevice *dev)
 	return 0;
 }
 
+static const struct ravb_device_ops ravb_device_ops_rzg2l = {
+	.mac_init = ravb_mac_init_rzg2l,
+	.dmac_init = ravb_dmac_init_rzg2l,
+	.config = ravb_config_rzg2l,
+	.reset_deassert = ravb_reset_deassert_rzg2l,
+	.reset_assert = ravb_reset_assert_rzg2l,
+};
+
+static const struct ravb_device_ops ravb_device_ops_rcar = {
+	.mac_init = ravb_mac_init_rcar,
+	.dmac_init = ravb_dmac_init_rcar,
+	.config = ravb_config_rcar,
+	.reset_deassert = ravb_reset_deassert_rcar,
+	.reset_assert = ravb_reset_assert_rcar,
+};
+
 static const struct udevice_id ravb_ids[] = {
-	{ .compatible = "renesas,etheravb-rcar-gen3" },
-	{ .compatible = "renesas,etheravb-rcar-gen4" },
+	{
+		.compatible = "renesas,etheravb-rcar-gen3",
+		.data = (ulong)&ravb_device_ops_rcar,
+	},
+	{
+		.compatible = "renesas,etheravb-rcar-gen4",
+		.data = (ulong)&ravb_device_ops_rcar,
+	},
+	{
+		.compatible = "renesas,rzg2l-gbeth",
+		.data = (ulong)&ravb_device_ops_rzg2l,
+	},
 	{ }
 };
 
-- 
2.43.0

