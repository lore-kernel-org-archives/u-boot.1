Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEAB9C02180
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 04:07:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AF0D8070C;
	Thu, 16 Jan 2025 05:05:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1737000357;
	bh=YzuKcQkfg2d93+Oq7Ftqh6OHG9bk44CvPJ8JYVfo57I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Kb6eKOFVILw7Y6EjLbDaSL8lxoSPpIj9Tl6IKkUqu21bQ1xOmNY1LcdhBIrOvzdAD
	 0rHpe5+cds+RqoatN6Z+WSUg2EEAT4zNkHfgUkC/3DoRcB4ybPhPf936ZCo+IVfCD9
	 x6lKrd4fWULw1MilPI3xC1Limt97tUBoUgIfhh0aRTd2euwNyN7yyNscIXv8bYujdI
	 c5e3vPYVyt6zCcUJT9/cC5U/7HEs3qtltDDbAcYvhDSI5IdF6VivUtcsWQc0Zb1wwP
	 WQuxre/IdzgYaizpy2uFAWcLiPsrqKLuirbbATzJJ67jbo3lXtlwwhvGAGQ9B/UYR0
	 JVp6C/C5o31Ww==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B94D80786; Thu, 16 Jan 2025 05:05:55 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5900F80737
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 05:05:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="Jq+5pcJs"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 72164109343A1; Thu, 16 Jan 2025 05:05:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1737000351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YzuKcQkfg2d93+Oq7Ftqh6OHG9bk44CvPJ8JYVfo57I=;
 b=Jq+5pcJsfFccGZPGyv1w9D7RYkl5GWULo0qjOgmmplrtvCPi54K24QtYNUBRQXAA0IPzKY
 B6XmlwyMKk+DAiml0chqqgh/QU6iNlJPscO66uCm/K3887P4YJ9WBLNYGtrytOMbtWS91E
 aD/0GqF2JrlsSf4mQunarfiWpRnvd5NbCh/WO7GY4oi3Hzsgq0Qullx4ZgeR/e7cUNee0f
 UoSNJQ2IWHBlmm6N6iHVk8zONcPxgu7b97SpgFZ7ObuRaeV+6f2odihl4kvhnzQYybLGqd
 3RL0tLsKxKXJdUqQWmICETUoVQW5sl7OjcM1L8GuvoVBVVHLaxOhkSCUAjc/5A==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Alice Guo <alice.guo@nxp.com>, Marek Vasut <marex@denx.de>,
 Ye Li <ye.li@nxp.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Markus Gothe <markus.gothe@genexis.eu>, Peng Fan <peng.fan@nxp.com>,
 Ramon Fried <rfried.dev@gmail.com>, Robert Marko <robert.marko@sartura.hr>,
 Romain Naour <romain.naour@smile.fr>, Simon Glass <sjg@chromium.org>,
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 13/13] net: fsl_enetc: Update enetc driver to support i.MX95
Date: Thu, 16 Jan 2025 05:03:30 +0100
Message-ID: <20250116040449.306098-13-marex@denx.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250116040449.306098-1-marex@denx.de>
References: <20250116040449.306098-1-marex@denx.de>
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

From: Alice Guo <alice.guo@nxp.com>

i.MX95 uses enetc version 4.1 controller. Update the enetc for i.MX95.
Add ARM-specific cache handling and i.MX95 specific register layout
handling.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
Signed-off-by: Marek Vasut <marex@denx.de> # Clean up
Signed-off-by: Ye Li <ye.li@nxp.com>
---
Cc: Alice Guo <alice.guo@nxp.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Markus Gothe <markus.gothe@genexis.eu>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Robert Marko <robert.marko@sartura.hr>
Cc: Romain Naour <romain.naour@smile.fr>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Ye Li <ye.li@nxp.com>
Cc: u-boot@lists.denx.de
---
 drivers/net/fsl_enetc.c | 275 +++++++++++++++++++++++++++++++++++++---
 drivers/net/fsl_enetc.h |  35 ++++-
 2 files changed, 286 insertions(+), 24 deletions(-)

diff --git a/drivers/net/fsl_enetc.c b/drivers/net/fsl_enetc.c
index 1a348f41ea0..67ef5f34a8a 100644
--- a/drivers/net/fsl_enetc.c
+++ b/drivers/net/fsl_enetc.c
@@ -2,6 +2,7 @@
 /*
  * ENETC ethernet controller driver
  * Copyright 2017-2021 NXP
+ * Copyright 2023-2025 NXP
  */
 
 #include <dm.h>
@@ -16,13 +17,44 @@
 #include <miiphy.h>
 #include <linux/bug.h>
 #include <linux/delay.h>
+#include <linux/build_bug.h>
+
+#ifdef CONFIG_ARCH_IMX9
+#include <asm/mach-imx/sys_proto.h>
+#include <cpu_func.h>
+#endif
 
 #include "fsl_enetc.h"
 
 #define ENETC_DRIVER_NAME	"enetc_eth"
 
+/*
+ * Calculate number of buffer descriptors per cacheline, and compile-time
+ * validate that:
+ * - the RX and TX descriptors are the same size
+ * - the descriptors fit exactly into cachelines without overlap
+ * - all descriptors fit exactly into cachelines
+ */
+#define ENETC_NUM_BD_IN_CL						\
+	((ARCH_DMA_MINALIGN / sizeof(struct enetc_tx_bd)) +		\
+	BUILD_BUG_ON_ZERO(sizeof(struct enetc_tx_bd) !=			\
+			  sizeof(union enetc_rx_bd)) +			\
+	BUILD_BUG_ON_ZERO(ARCH_DMA_MINALIGN % sizeof(struct enetc_tx_bd)) + \
+	BUILD_BUG_ON_ZERO(ARCH_DMA_MINALIGN % sizeof(union enetc_rx_bd)) + \
+	BUILD_BUG_ON_ZERO(ENETC_BD_CNT %				\
+			  (ARCH_DMA_MINALIGN / sizeof(struct enetc_tx_bd))))
+
 static int enetc_remove(struct udevice *dev);
 
+static int enetc_is_imx95(struct udevice *dev)
+{
+	struct pci_child_plat *pplat = dev_get_parent_plat(dev);
+
+	/* Test whether this is i.MX95 ENETCv4. This may be optimized out. */
+	return IS_ENABLED(CONFIG_ARCH_IMX9) &&
+	       pplat->vendor == PCI_VENDOR_ID_PHILIPS;
+}
+
 static int enetc_is_ls1028a(struct udevice *dev)
 {
 	struct pci_child_plat *pplat = dev_get_parent_plat(dev);
@@ -34,12 +66,60 @@ static int enetc_is_ls1028a(struct udevice *dev)
 
 static int enetc_dev_id(struct udevice *dev)
 {
+	if (enetc_is_imx95(dev))
+		return PCI_DEV(pci_get_devfn(dev)) >> 3;
 	if (enetc_is_ls1028a(dev))
 		return PCI_FUNC(pci_get_devfn(dev));
 
 	return 0;
 }
 
+static void enetc_inval_rxbd(struct udevice *dev)
+{
+	struct enetc_priv *priv = dev_get_priv(dev);
+	union enetc_rx_bd *desc = &priv->enetc_rxbd[priv->rx_bdr.next_prod_idx];
+	unsigned long start = rounddown((unsigned long)desc, ARCH_DMA_MINALIGN);
+	unsigned long end = roundup((unsigned long)desc + sizeof(*desc),
+				    ARCH_DMA_MINALIGN);
+
+	if (enetc_is_imx95(dev))
+		invalidate_dcache_range(start, end);
+}
+
+static void enetc_flush_bd(struct udevice *dev, int pi, bool tx)
+{
+	struct enetc_priv *priv = dev_get_priv(dev);
+	union enetc_rx_bd *rxdesc = &priv->enetc_rxbd[pi];
+	struct enetc_tx_bd *txdesc = &priv->enetc_txbd[pi];
+	unsigned long desc = tx ? (unsigned long)txdesc : (unsigned long)rxdesc;
+	unsigned long size = tx ? sizeof(*txdesc) : sizeof(*rxdesc);
+	unsigned long start = rounddown(desc, ARCH_DMA_MINALIGN);
+	unsigned long end = roundup(desc + size, ARCH_DMA_MINALIGN);
+
+	if (enetc_is_imx95(dev))
+		flush_dcache_range(start, end);
+}
+
+static void enetc_inval_buffer(struct udevice *dev, void *buf, size_t size)
+{
+	unsigned long start = rounddown((unsigned long)buf, ARCH_DMA_MINALIGN);
+	unsigned long end = roundup((unsigned long)buf + size,
+				    ARCH_DMA_MINALIGN);
+
+	if (enetc_is_imx95(dev))
+		invalidate_dcache_range(start, end);
+}
+
+static void enetc_flush_buffer(struct udevice *dev, void *buf, size_t size)
+{
+	unsigned long start = rounddown((unsigned long)buf, ARCH_DMA_MINALIGN);
+	unsigned long end = roundup((unsigned long)buf + size,
+				    ARCH_DMA_MINALIGN);
+
+	if (enetc_is_imx95(dev))
+		flush_dcache_range(start, end);
+}
+
 /* register accessors */
 static u32 enetc_read_reg(void __iomem *addr)
 {
@@ -93,9 +173,19 @@ static u32 enetc_read_pcapr_mdio(struct udevice *dev)
 	struct enetc_data *data = (struct enetc_data *)dev_get_driver_data(dev);
 	struct enetc_priv *priv = dev_get_priv(dev);
 	const u32 off = ENETC_PCAPR0 + data->reg_offset_pcapr;
-	u32 reg = enetc_read_reg(priv->port_regs + off);
+	const u32 reg = enetc_read_reg(priv->port_regs + off);
 
-	return reg & ENETC_PCAPRO_MDIO;
+	if (enetc_is_imx95(dev))
+		return reg & ENETC_PCS_PROT;
+	else if (enetc_is_ls1028a(dev))
+		return reg & ENETC_PCAPRO_MDIO;
+
+	return 0;
+}
+
+static void enetc_write_port(struct enetc_priv *priv, u32 off, u32 val)
+{
+	enetc_write_reg(priv->port_regs + off, val);
 }
 
 /* MAC port register accessors */
@@ -135,13 +225,30 @@ static void enetc_set_ierb_primary_mac(struct udevice *dev, void *blob)
 	static int ierb_fn_to_pf[] = { 0, 1, 2, -1, -1, -1, 3 };
 	struct pci_child_plat *ppdata = dev_get_parent_plat(dev);
 	struct eth_pdata *pdata = dev_get_plat(dev);
+	struct enetc_priv *priv = dev_get_priv(dev);
 	const u8 *enetaddr = pdata->enetaddr;
 	u16 lower = *(const u16 *)(enetaddr + 4);
 	u32 upper = *(const u32 *)enetaddr;
 	int devfn, offset;
 	char path[256];
 
-	if (enetc_is_ls1028a(dev)) {
+	if (enetc_is_imx95(dev)) {
+		/*
+		 * Configure the ENETC primary MAC addresses - Set register
+		 * PMAR0/1 for SI 0 and PSIaPMAR0/1 for SI 1, 2 .. a
+		 * (optionally pre-configured in IERB).
+		 */
+		devfn = enetc_dev_id(dev);
+		if (devfn > 2)
+			return;
+
+		enetc_write(priv, IMX95_ENETC_SIPMAR0, upper);
+		enetc_write(priv, IMX95_ENETC_SIPMAR1, lower);
+
+		snprintf(path, 256, "/soc/pcie@%x/ethernet@%x,%x",
+			 PCI_BUS(dm_pci_get_bdf(dev)), PCI_DEV(ppdata->devfn),
+			 PCI_FUNC(ppdata->devfn));
+	} else if (enetc_is_ls1028a(dev)) {
 		/*
 		 * LS1028A is the only part with IERB at this time and
 		 * there are plans to change its structure, keep this
@@ -279,7 +386,7 @@ static int enetc_init_sgmii(struct udevice *dev)
 /* set up MAC for RGMII */
 static void enetc_init_rgmii(struct udevice *dev, struct phy_device *phydev)
 {
-	u32 old_val, val;
+	u32 old_val, val, dpx = 0;
 
 	old_val = val = enetc_read_mac_port(dev, ENETC_PM_IF_MODE);
 
@@ -299,10 +406,15 @@ static void enetc_init_rgmii(struct udevice *dev, struct phy_device *phydev)
 		val |= ENETC_PM_IFM_SSP_10;
 	}
 
+	if (enetc_is_imx95(dev))
+		dpx = ENETC_PM_IFM_FULL_DPX_IMX;
+	else if (enetc_is_ls1028a(dev))
+		dpx = ENETC_PM_IFM_FULL_DPX_LS;
+
 	if (phydev->duplex == DUPLEX_FULL)
-		val |= ENETC_PM_IFM_FULL_DPX;
+		val |= dpx;
 	else
-		val &= ~ENETC_PM_IFM_FULL_DPX;
+		val &= ~dpx;
 
 	if (val == old_val)
 		return;
@@ -328,7 +440,10 @@ static void enetc_setup_mac_iface(struct udevice *dev,
 	case PHY_INTERFACE_MODE_10GBASER:
 		/* set ifmode to (US)XGMII */
 		if_mode = enetc_read_mac_port(dev, ENETC_PM_IF_MODE);
-		if_mode &= ~ENETC_PM_IF_IFMODE_MASK;
+		if (enetc_is_imx95(dev))
+			if_mode &= ~ENETC_PM_IF_IFMODE_MASK_IMX;
+		else if (enetc_is_ls1028a(dev))
+			if_mode &= ~ENETC_PM_IF_IFMODE_MASK_LS;
 		enetc_write_mac_port(dev, ENETC_PM_IF_MODE, if_mode);
 		break;
 	};
@@ -472,6 +587,21 @@ static int enetc_remove(struct udevice *dev)
 	return 0;
 }
 
+static int enetc_imx95_write_hwaddr(struct udevice *dev)
+{
+	struct eth_pdata *plat = dev_get_plat(dev);
+	struct enetc_priv *priv = dev_get_priv(dev);
+	u8 *addr = plat->enetaddr;
+
+	u16 lower = *(const u16 *)(addr + 4);
+	u32 upper = *(const u32 *)addr;
+
+	enetc_write_port(priv, IMX95_ENETC_PMAR0, upper);
+	enetc_write_port(priv, IMX95_ENETC_PMAR1, lower);
+
+	return 0;
+}
+
 /*
  * LS1028A is the only part with IERB at this time and there are plans to
  * change its structure, keep this LS1028A specific for now.
@@ -512,6 +642,8 @@ static int enetc_write_hwaddr(struct udevice *dev)
 	struct eth_pdata *plat = dev_get_plat(dev);
 	u8 *addr = plat->enetaddr;
 
+	if (enetc_is_imx95(dev))
+		return enetc_imx95_write_hwaddr(dev);
 	if (enetc_is_ls1028a(dev))
 		return enetc_ls1028a_write_hwaddr(dev);
 
@@ -528,6 +660,7 @@ static int enetc_write_hwaddr(struct udevice *dev)
 static void enetc_enable_si_port(struct udevice *dev)
 {
 	struct enetc_priv *priv = dev_get_priv(dev);
+	u32 val = ENETC_PM_CC_TXP_IMX | ENETC_PM_CC_TX | ENETC_PM_CC_RX;
 
 	/* set Rx/Tx BDR count */
 	enetc_write_psicfgr(dev, 0, ENETC_PSICFGR_SET_BDR(ENETC_RX_BDR_CNT,
@@ -535,12 +668,18 @@ static void enetc_enable_si_port(struct udevice *dev)
 	/* set Rx max frame size */
 	enetc_write_mac_port(dev, ENETC_PM_MAXFRM, ENETC_RX_MAXFRM_SIZE);
 	/* enable MAC port */
-	enetc_write_mac_port(dev, ENETC_PM_CC, ENETC_PM_CC_RX_TX_EN);
+	if (enetc_is_ls1028a(dev))
+		val |= ENETC_PM_CC_TXP_LS | ENETC_PM_CC_PROMIS;
+	enetc_write_mac_port(dev, ENETC_PM_CC, val);
 	/* enable port */
+	if (enetc_is_imx95(dev))
+		enetc_write_port(priv, ENETC_POR, 0x0);
 	enetc_write_pmr(dev, ENETC_PMR_SI0_EN);
 	/* set SI cache policy */
-	enetc_write(priv, ENETC_SICAR0,
-		    ENETC_SICAR_RD_CFG | ENETC_SICAR_WR_CFG);
+	enetc_write(priv, ENETC_SICAR0, ENETC_SICAR_WR_CFG |
+					(enetc_is_imx95(dev) ?
+					 ENETC_SICAR_RD_CFG_IMX :
+					 ENETC_SICAR_RD_CFG_LS));
 	/* enable SI */
 	enetc_write(priv, ENETC_SIMR, ENETC_SIMR_EN);
 }
@@ -631,6 +770,8 @@ static void enetc_setup_rx_bdr(struct udevice *dev)
 		priv->enetc_rxbd[i].w.addr = enetc_rxb_address(dev, i);
 		/* each RX buffer must be aligned to 64B */
 		WARN_ON(priv->enetc_rxbd[i].w.addr & (ARCH_DMA_MINALIGN - 1));
+
+		enetc_flush_bd(dev, i, false);
 	}
 
 	/* reset producer (ENETC owned) and consumer (SW owned) index */
@@ -651,6 +792,7 @@ static void enetc_setup_rx_bdr(struct udevice *dev)
  */
 static int enetc_start(struct udevice *dev)
 {
+	int ret;
 	struct enetc_priv *priv = dev_get_priv(dev);
 
 	/* reset and enable the PCI device */
@@ -664,9 +806,13 @@ static int enetc_start(struct udevice *dev)
 	enetc_setup_tx_bdr(dev);
 	enetc_setup_rx_bdr(dev);
 
+	ret = phy_startup(priv->phy);
+	if (ret)
+		return ret;
+
 	enetc_setup_mac_iface(dev, priv->phy);
 
-	return phy_startup(priv->phy);
+	return 0;
 }
 
 /*
@@ -709,6 +855,8 @@ static int enetc_send(struct udevice *dev, void *packet, int length)
 	enetc_dbg(dev, "TxBD[%d]send: pkt_len=%d, buff @0x%x%08x\n", pi, length,
 		  upper_32_bits((u64)nv_packet), lower_32_bits((u64)nv_packet));
 
+	enetc_flush_buffer(dev, packet, length);
+
 	/* prepare Tx BD */
 	memset(&priv->enetc_txbd[pi], 0x0, sizeof(struct enetc_tx_bd));
 	priv->enetc_txbd[pi].addr =
@@ -716,7 +864,10 @@ static int enetc_send(struct udevice *dev, void *packet, int length)
 	priv->enetc_txbd[pi].buf_len = cpu_to_le16(length);
 	priv->enetc_txbd[pi].frm_len = cpu_to_le16(length);
 	priv->enetc_txbd[pi].flags = cpu_to_le16(ENETC_TXBD_FLAGS_F);
+
 	dmb();
+	enetc_flush_bd(dev, pi, true);
+
 	/* send frame: increment producer index */
 	pi = (pi + 1) % txr->bd_count;
 	txr->next_prod_idx = pi;
@@ -738,15 +889,15 @@ static int enetc_recv(struct udevice *dev, int flags, uchar **packetp)
 {
 	struct enetc_priv *priv = dev_get_priv(dev);
 	struct bd_ring *rxr = &priv->rx_bdr;
-	int tries = ENETC_POLL_TRIES;
 	int pi = rxr->next_prod_idx;
-	int ci = rxr->next_cons_idx;
+	int tries = ENETC_POLL_TRIES;
 	u32 status;
 	int len;
 	u8 rdy;
 
 	do {
 		dmb();
+		enetc_inval_rxbd(dev);
 		status = le32_to_cpu(priv->enetc_rxbd[pi].r.lstatus);
 		/* check if current BD is ready to be consumed */
 		rdy = ENETC_RXBD_STATUS_R(status);
@@ -758,28 +909,114 @@ static int enetc_recv(struct udevice *dev, int flags, uchar **packetp)
 	dmb();
 	len = le16_to_cpu(priv->enetc_rxbd[pi].r.buf_len);
 	*packetp = (uchar *)enetc_rxb_address(dev, pi);
+	enetc_inval_buffer(dev, *packetp, len);
 	enetc_dbg(dev, "RxBD[%d]: len=%d err=%d pkt=0x%x%08x\n", pi, len,
 		  ENETC_RXBD_STATUS_ERRORS(status),
 		  upper_32_bits((u64)*packetp), lower_32_bits((u64)*packetp));
 
-	/* BD clean up and advance to next in ring */
-	memset(&priv->enetc_rxbd[pi], 0, sizeof(union enetc_rx_bd));
-	priv->enetc_rxbd[pi].w.addr = enetc_rxb_address(dev, pi);
+	return len;
+}
+
+static int enetc_free_pkt(struct udevice *dev, uchar *packet, int length)
+{
+	const int bd_num_in_cl = enetc_is_imx95(dev) ? ENETC_NUM_BD_IN_CL : 1;
+	struct enetc_priv *priv = dev_get_priv(dev);
+	struct bd_ring *rxr = &priv->rx_bdr;
+	int pi = rxr->next_prod_idx;
+	int ci = rxr->next_cons_idx;
+	uchar *packet_expected;
+	int i;
+
+	packet_expected = (uchar *)enetc_rxb_address(dev, pi);
+	if (packet != packet_expected) {
+		printf("%s: Unexpected packet (expected %p)\n", __func__,
+		       packet_expected);
+		return -EINVAL;
+	}
+
 	rxr->next_prod_idx = (pi + 1) % rxr->bd_count;
 	ci = (ci + 1) % rxr->bd_count;
 	rxr->next_cons_idx = ci;
 	dmb();
-	/* free up the slot in the ring for HW */
-	enetc_write_reg(rxr->cons_idx, ci);
 
-	return len;
+	if ((pi + 1) % bd_num_in_cl == 0) {
+		/* BD clean up and advance to next in ring */
+		for (i = 0; i < bd_num_in_cl; i++) {
+			memset(&priv->enetc_rxbd[pi - i], 0, sizeof(union enetc_rx_bd));
+			priv->enetc_rxbd[pi - i].w.addr = enetc_rxb_address(dev, pi - i);
+		}
+
+		/* Will flush all bds in one cacheline */
+		enetc_flush_bd(dev, pi - bd_num_in_cl + 1, false);
+
+		/* free up the slot in the ring for HW */
+		enetc_write_reg(rxr->cons_idx, ci);
+	}
+
+	return 0;
 }
 
+#if IS_ENABLED(CONFIG_ARCH_IMX9)
+static int enetc_read_rom_hwaddr(struct udevice *dev)
+{
+	struct eth_pdata *pdata = dev_get_plat(dev);
+	unsigned int dev_id = enetc_dev_id(dev);
+	unsigned char *mac = pdata->enetaddr;
+
+	if (dev_id > 2)
+		return -EINVAL;
+
+	imx_get_mac_from_fuse(dev_id, mac);
+
+	return !is_valid_ethaddr(mac);
+}
+
+static const struct eth_ops enetc_ops_imx = {
+	.start			= enetc_start,
+	.send			= enetc_send,
+	.recv			= enetc_recv,
+	.stop			= enetc_stop,
+	.free_pkt		= enetc_free_pkt,
+	.write_hwaddr		= enetc_write_hwaddr,
+	.read_rom_hwaddr	= enetc_read_rom_hwaddr,
+};
+
+U_BOOT_DRIVER(eth_enetc_imx) = {
+	.name		= ENETC_DRIVER_NAME,
+	.id		= UCLASS_ETH,
+	.bind		= enetc_bind,
+	.probe		= enetc_probe,
+	.remove		= enetc_remove,
+	.ops		= &enetc_ops_imx,
+	.priv_auto	= sizeof(struct enetc_priv),
+	.plat_auto	= sizeof(struct eth_pdata),
+};
+
+static const struct enetc_data enetc_data_imx = {
+	.reg_offset_pmr		= ENETC_PMR_OFFSET_IMX,
+	.reg_offset_psipmar	= ENETC_PSIPMARn_OFFSET_IMX,
+	.reg_offset_pcapr	= ENETC_PCAPR_OFFSET_IMX,
+	.reg_offset_psicfgr	= ENETC_PSICFGR_OFFSET_IMX,
+	.reg_offset_mac		= ENETC_PM_OFFSET_IMX,
+};
+
+static struct pci_device_id enetc_ids_imx[] = {
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_PHILIPS, PCI_DEVICE_ID_ENETC4_ETH),
+		.driver_data = (ulong)&enetc_data_imx,
+	},
+	{}
+};
+
+U_BOOT_PCI_DEVICE(eth_enetc_imx, enetc_ids_imx);
+#endif
+
 static const struct eth_ops enetc_ops_ls = {
 	.start	= enetc_start,
 	.send	= enetc_send,
 	.recv	= enetc_recv,
 	.stop	= enetc_stop,
+	.free_pkt = enetc_free_pkt,
 	.write_hwaddr = enetc_write_hwaddr,
 };
 
diff --git a/drivers/net/fsl_enetc.h b/drivers/net/fsl_enetc.h
index 82c2476e1fa..804df853bf5 100644
--- a/drivers/net/fsl_enetc.h
+++ b/drivers/net/fsl_enetc.h
@@ -12,6 +12,7 @@
 
 /* PCI function IDs */
 #define PCI_DEVICE_ID_ENETC_ETH		0xE100
+#define PCI_DEVICE_ID_ENETC4_ETH	0xE101
 #define PCI_DEVICE_ID_ENETC_MDIO	0xEE01
 #define PCI_DEVICE_ID_ENETC4_EMDIO	0xEE00
 
@@ -23,7 +24,8 @@
 /* write cache cfg: snoop, no allocate, data & BD coherent */
 #define  ENETC_SICAR_WR_CFG	0x6767
 /* read cache cfg: coherent copy, look up, don't alloc in cache */
-#define  ENETC_SICAR_RD_CFG	0x27270000
+#define  ENETC_SICAR_RD_CFG_LS	0x27270000
+#define  ENETC_SICAR_RD_CFG_IMX	0x2b2b0000
 #define ENETC_SIROCT		0x300
 #define ENETC_SIRFRM		0x308
 #define ENETC_SITOCT		0x320
@@ -58,25 +60,37 @@ enum enetc_bdr_type {TX, RX};
 #define ENETC_PORT_REGS_OFF		0x10000
 
 /* Port registers */
+#define ENETC_PMR_OFFSET_IMX		0x0010
 #define ENETC_PMR_OFFSET_LS		0x0000
 #define ENETC_PMR			0x0000
 #define  ENETC_PMR_SI0_EN		BIT(16)
 #define ENETC_PSIPMMR			0x0018
+#define ENETC_PSIPMARn_OFFSET_IMX	0x0000
 #define ENETC_PSIPMARn_OFFSET_LS	0x0080
 #define ENETC_PSIPMAR0			0x0080
 #define ENETC_PSIPMAR1			0x0084
+#define ENETC_PCAPR_OFFSET_IMX		0x4008
 #define ENETC_PCAPR_OFFSET_LS		0x0900
 #define ENETC_PCAPR0			0x0000
-#define  ENETC_PCAPRO_MDIO		BIT(11)
+#define ENETC_PCAPRO_MDIO		BIT(11)	/* LS only */
+#define ENETC_PCS_PROT			GENMASK(15, 0) /* IMX only */
+/* ENETC base registers */
 #define ENETC_PSICFGR_OFFSET_LS		0x0940
 #define ENETC_PSICFGR_SHIFT_LS		0x10
+#define ENETC_PSICFGR_OFFSET_IMX	0x2010
+#define ENETC_PSICFGR_SHIFT_IMX		0x80
 #define ENETC_PSICFGR(n, s)		((n) * (s))
 #define  ENETC_PSICFGR_SET_BDR(rx, tx)	(((rx) << 16) | (tx))
 /* MAC configuration */
+#define ENETC_PM_OFFSET_IMX		0x5000
 #define ENETC_PM_OFFSET_LS		0x8000
 #define ENETC_PM_CC			0x0008
 #define  ENETC_PM_CC_DEFAULT		0x0810
-#define  ENETC_PM_CC_RX_TX_EN		0x8813
+#define  ENETC_PM_CC_TXP_IMX		BIT(15)
+#define  ENETC_PM_CC_TXP_LS		BIT(11)
+#define  ENETC_PM_CC_PROMIS		BIT(4)
+#define  ENETC_PM_CC_TX			BIT(1)
+#define  ENETC_PM_CC_RX			BIT(0)
 #define ENETC_PM_MAXFRM			0x0014
 #define  ENETC_RX_MAXFRM_SIZE		PKTSIZE_ALIGN
 #define ENETC_PM_IMDIO_BASE		0x0030
@@ -87,8 +101,19 @@ enum enetc_bdr_type {TX, RX};
 #define  ENETC_PM_IFM_SSP_1000		(2 << 13)
 #define  ENETC_PM_IFM_SSP_100		(0 << 13)
 #define  ENETC_PM_IFM_SSP_10		(1 << 13)
-#define  ENETC_PM_IFM_FULL_DPX		BIT(12)
-#define  ENETC_PM_IF_IFMODE_MASK	GENMASK(1, 0)
+#define  ENETC_PM_IFM_FULL_DPX_IMX	BIT(6)
+#define  ENETC_PM_IFM_FULL_DPX_LS	BIT(12)
+#define  ENETC_PM_IF_IFMODE_MASK_IMX	GENMASK(2, 0)
+#define  ENETC_PM_IF_IFMODE_MASK_LS	GENMASK(1, 0)
+
+/* i.MX95 specific registers */
+#define IMX95_ENETC_SIPMAR0		0x80
+#define IMX95_ENETC_SIPMAR1		0x84
+
+/* Port registers */
+#define IMX95_ENETC_PMAR0		0x4020
+#define IMX95_ENETC_PMAR1		0x4024
+#define ENETC_POR			0x4100
 
 /* buffer descriptors count must be multiple of 8 and aligned to 128 bytes */
 #define ENETC_BD_CNT		CONFIG_SYS_RX_ETH_BUFFER
-- 
2.45.2

