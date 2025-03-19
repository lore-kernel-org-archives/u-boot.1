Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8397C35FFB
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 12:04:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28FD381DDF;
	Wed, 19 Mar 2025 13:04:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A07B581DCD; Wed, 19 Mar 2025 13:04:31 +0100 (CET)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by phobos.denx.de (Postfix) with ESMTP id 1393581101
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 13:04:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-CSE-ConnectionGUID: xfiG/zQ8Se6Z+Q2xRl/YTA==
X-CSE-MsgGUID: Rvfpm9uVSHi3um4fSjcqVg==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie6.idc.renesas.com with ESMTP; 19 Mar 2025 21:04:28 +0900
Received: from rz-ub2404.betafive.net (unknown [10.24.1.74])
 by relmlir5.idc.renesas.com (Postfix) with ESMTP id D3D9D4016D6E;
 Wed, 19 Mar 2025 21:04:25 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
	u-boot@lists.denx.de
Subject: [PATCH v2 3/4] net: ravb: Add RZ/G2L Support
Date: Wed, 19 Mar 2025 12:03:59 +0000
Message-ID: <20250319120401.8297-4-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319120401.8297-1-paul.barker.ct@bp.renesas.com>
References: <20250319120401.8297-1-paul.barker.ct@bp.renesas.com>
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
 arch/arm/mach-renesas/Kconfig |  1 +
 drivers/net/Kconfig           |  2 +-
 drivers/net/ravb.c            | 57 +++++++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+), 1 deletion(-)

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
index 3db784faedd3..157d330a9cce 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -864,7 +864,7 @@ config RENESAS_RAVB
 	select PHY_ETHERNET_ID
 	help
 	  This driver implements support for the Ethernet AVB block in
-	  Renesas M3 and H3 SoCs.
+	  several Renesas R-Car and RZ SoCs.
 
 config MPC8XX_FEC
 	bool "Fast Ethernet Controller on MPC8XX"
diff --git a/drivers/net/ravb.c b/drivers/net/ravb.c
index ecf6e05f47eb..86aa5cd5835c 100644
--- a/drivers/net/ravb.c
+++ b/drivers/net/ravb.c
@@ -31,6 +31,7 @@
 #define RAVB_REG_CSR		0x00C
 #define RAVB_REG_APSR		0x08C
 #define RAVB_REG_RCR		0x090
+#define RAVB_REG_RTC		0x0B4
 #define RAVB_REG_TGC		0x300
 #define RAVB_REG_TCCR		0x304
 #define RAVB_REG_RIC0		0x360
@@ -44,6 +45,7 @@
 #define RAVB_REG_GECMR		0x5b0
 #define RAVB_REG_MAHR		0x5c0
 #define RAVB_REG_MALR		0x5c8
+#define RAVB_REG_CSR0		0x800
 
 #define CCC_OPC_CONFIG		BIT(0)
 #define CCC_OPC_OPERATION	BIT(1)
@@ -65,14 +67,24 @@
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
@@ -385,6 +397,16 @@ static void ravb_mac_init_rcar(struct udevice *dev)
 	writel(0, eth->iobase + RAVB_REG_ECSIPR);
 }
 
+static void ravb_mac_init_rzg2l(struct udevice *dev)
+{
+	struct ravb_priv *eth = dev_get_priv(dev);
+
+	setbits_32(eth->iobase + RAVB_REG_ECMR,
+		   ECMR_PRM | ECMR_RXF | ECMR_TXF | ECMR_RCPT |
+		   ECMR_TE | ECMR_RE | ECMR_RZPF |
+		   (eth->phydev->duplex ? ECMR_DM : 0));
+}
+
 /* AVB-DMAC init function */
 static int ravb_dmac_init(struct udevice *dev)
 {
@@ -459,6 +481,14 @@ static void ravb_dmac_init_rcar(struct udevice *dev)
 	writel(mode, eth->iobase + RAVB_REG_APSR);
 }
 
+static void ravb_dmac_init_rzg2l(struct udevice *dev)
+{
+	struct ravb_priv *eth = dev_get_priv(dev);
+
+	/* Set Max Frame Length (RTC) */
+	writel(0x7ffc0000 | RFLR_RFL_MIN, eth->iobase + RAVB_REG_RTC);
+}
+
 static int ravb_config(struct udevice *dev)
 {
 	struct ravb_device_ops *device_ops =
@@ -501,6 +531,22 @@ static void ravb_config_rcar(struct udevice *dev)
 	writel(mask, eth->iobase + RAVB_REG_ECMR);
 }
 
+static void ravb_config_rzg2l(struct udevice *dev)
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
+}
+
 static int ravb_start(struct udevice *dev)
 {
 	struct ravb_priv *eth = dev_get_priv(dev);
@@ -740,6 +786,13 @@ static const struct ravb_device_ops ravb_device_ops_rcar = {
 	.config = ravb_config_rcar,
 };
 
+static const struct ravb_device_ops ravb_device_ops_rzg2l = {
+	.mac_init = ravb_mac_init_rzg2l,
+	.dmac_init = ravb_dmac_init_rzg2l,
+	.config = ravb_config_rzg2l,
+	.has_reset = true,
+};
+
 static const struct udevice_id ravb_ids[] = {
 	{
 		.compatible = "renesas,etheravb-rcar-gen3",
@@ -749,6 +802,10 @@ static const struct udevice_id ravb_ids[] = {
 		.compatible = "renesas,etheravb-rcar-gen4",
 		.data = (ulong)&ravb_device_ops_rcar,
 	},
+	{
+		.compatible = "renesas,rzg2l-gbeth",
+		.data = (ulong)&ravb_device_ops_rzg2l,
+	},
 	{ }
 };
 
-- 
2.43.0

