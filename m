Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53A86C02180
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 04:07:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D866807BC;
	Thu, 16 Jan 2025 05:05:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1737000353;
	bh=x2diDqa1KIVCnxopPip6tIfQWLvYlfcLYbFryVto8Vs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qSQ3ImkOIi/In3Uq6vlIKGq3DNBiloa/JQc+SM0mkm6cg2bCQysmcQz8KIVDPObgG
	 wjcGYN3ASMxThqN0GJpK+RBOdwGYWYDnXhKNon0Ba0vum2Oy/gm1IGwXgyTnjN5OtI
	 GznLP0e3i5BBm6lrqx3Idm9m140hd+sAJgs8f8pxzVN2tIUIFeT813t1W/qmgmLd3m
	 +0vaJJ6UZbn4eDdiUk8RAQ/xawqMCSOjrUWv5qyHhFcSFbwtI25jbPMFRpbdQahZwJ
	 2sQghqVfqC0sEr1R/mjTAChfsT5S/WHCJHZZRHZNtQ/CW43I73QmehGWtVUBIXFV7U
	 0nZmUowm5JSsQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E15E80737; Thu, 16 Jan 2025 05:05:51 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C9E88077D
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 05:05:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="UcovSe0F"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 35FBC10936A16; Thu, 16 Jan 2025 05:05:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1737000348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x2diDqa1KIVCnxopPip6tIfQWLvYlfcLYbFryVto8Vs=;
 b=UcovSe0FZUYS7oUEFJVnNedHbH1f4Uup8AiaBF2dEufctwXleAKtXrtn3FHnsHESZUybeQ
 2UDItvlkVi0+xitcfgWp8vnaKKU2I8t5/kIUc3/8s2mPlzXeWmeODONheFS8OxnmtL2DAi
 jUw3mXfcrSyZZoxhAkhz1um4snrNqG43DfZAbghWbE3YSPU9bN27WqNO2f5oS9awFYeUjD
 vJVJkl2QyinHuKNKa9+mWZ+2vuWqN6HOkNoTxy0suw/BD4r1fMh0iHpJoAlj/mloxu1IN/
 NpMvxLgJJC7aWAzfgTPolJCtqupUQQ8c4azgpIi6KrkFcZO9fHJAc902njL0Hw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Alice Guo <alice.guo@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Markus Gothe <markus.gothe@genexis.eu>, Peng Fan <peng.fan@nxp.com>,
 Ramon Fried <rfried.dev@gmail.com>, Robert Marko <robert.marko@sartura.hr>,
 Romain Naour <romain.naour@smile.fr>, Simon Glass <sjg@chromium.org>,
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>,
 Ye Li <ye.li@nxp.com>
Subject: [PATCH 11/13] net: fsl_enetc: Add initial netc-blk-ctrl driver support
Date: Thu, 16 Jan 2025 05:03:28 +0100
Message-ID: <20250116040449.306098-11-marex@denx.de>
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

The netc-blk-ctrl driver is used to configure Integrated Endpoint
Register Block (IERB) and Privileged Register Block (PRB) of NETC.
For i.MX platforms, it is also used to configure the NETCMIX block.

The IERB contains registers that are used for pre-boot initialization,
debug, and non-customer configuration. The PRB controls global reset
and global error handling for NETC. The NETCMIX block is mainly used
to set MII protocol and PCS protocol of the links, it also contains
settings for some other functions.

Note the IERB configuration registers can only be written after being
unlocked by PRB, otherwise, all write operations are inhibited. A warm
reset is performed when the IERB is unlocked, and it results in an FLR
to all NETC devices. Therefore, all NETC device drivers must be probed
or initialized after the warm reset is finished.

Ported from Linux 6.13-rc as of commit
fe5ba6bf91b3 ("net: enetc: add initial netc-blk-ctrl driver support")

Signed-off-by: Marek Vasut <marex@denx.de>
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
 drivers/net/Kconfig                   |  14 ++
 drivers/net/Makefile                  |   1 +
 drivers/net/fsl_enetc_netc_blk_ctrl.c | 346 ++++++++++++++++++++++++++
 3 files changed, 361 insertions(+)
 create mode 100644 drivers/net/fsl_enetc_netc_blk_ctrl.c

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 88ff025a37b..dcf6b4c81fc 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -1019,6 +1019,20 @@ config FSL_ENETC
 	  This driver supports the NXP ENETC Ethernet controller found on some
 	  of the NXP SoCs.
 
+config FSL_ENETC_NETC_BLK_CTRL
+	bool "NXP ENETC NETC blocks control driver"
+	depends on FSL_ENETC && IMX95
+	default y if IMX95
+	help
+	  This driver configures Integrated Endpoint Register Block (IERB) and
+	  Privileged Register Block (PRB) of NETC. For i.MX platforms, it also
+	  includes the configuration of NETCMIX block.
+	  The IERB contains registers that are used for pre-boot initialization,
+	  debug, and non-customer configuration. The PRB controls global reset
+	  and global error handling for NETC. The NETCMIX block is mainly used
+	  to set MII protocol and PCS protocol of the links, it also contains
+	  settings for some other functions.
+
 config MDIO_GPIO_BITBANG
 	bool "GPIO bitbanging MDIO driver"
 	depends on DM_MDIO && DM_GPIO
diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index e51a917933e..c6217f08f14 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -44,6 +44,7 @@ obj-$(CONFIG_FEC_MXC) += fec_mxc.o
 obj-$(CONFIG_FMAN_ENET) += fm/
 obj-$(CONFIG_FMAN_ENET) += fsl_mdio.o
 obj-$(CONFIG_FSL_ENETC) += fsl_enetc.o fsl_enetc_mdio.o
+obj-$(CONFIG_FSL_ENETC_NETC_BLK_CTRL) += fsl_enetc_netc_blk_ctrl.o
 obj-$(CONFIG_FSL_LS_MDIO) += fsl_ls_mdio.o
 obj-$(CONFIG_FSL_MC_ENET) += fsl-mc/
 obj-$(CONFIG_FSL_MC_ENET) += ldpaa_eth/
diff --git a/drivers/net/fsl_enetc_netc_blk_ctrl.c b/drivers/net/fsl_enetc_netc_blk_ctrl.c
new file mode 100644
index 00000000000..46b68d3d8a4
--- /dev/null
+++ b/drivers/net/fsl_enetc_netc_blk_ctrl.c
@@ -0,0 +1,346 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * NXP NETC Blocks Control Driver
+ *
+ * Copyright 2024 NXP
+ *
+ * This driver is used for pre-initialization of NETC, such as PCS and MII
+ * protocols, LDID, warm reset, etc. Therefore, all NETC device drivers can
+ * only be probed after the netc-blk-crtl driver has completed initialization.
+ * In addition, when the system enters suspend mode, IERB, PRB, and NETCMIX
+ * will be powered off, except for WOL. Therefore, when the system resumes,
+ * these blocks need to be reinitialized.
+ */
+
+#include <asm/io.h>
+#include <clk.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/iopoll.h>
+#include <phy_interface.h>
+
+/* NETCMIX registers */
+#define IMX95_CFG_LINK_IO_VAR		0x0
+#define  IO_VAR_16FF_16G_SERDES		0x1
+#define  IO_VAR(port, var)		(((var) & 0xf) << ((port) << 2))
+
+#define IMX95_CFG_LINK_MII_PROT		0x4
+#define CFG_LINK_MII_PORT_0		GENMASK(3, 0)
+#define CFG_LINK_MII_PORT_1		GENMASK(7, 4)
+#define  MII_PROT_MII			0x0
+#define  MII_PROT_RMII			0x1
+#define  MII_PROT_RGMII			0x2
+#define  MII_PROT_SERIAL		0x3
+#define  MII_PROT(port, prot)		(((prot) & 0xf) << ((port) << 2))
+
+#define IMX95_CFG_LINK_PCS_PROT(a)	(0x8 + (a) * 4)
+#define PCS_PROT_1G_SGMII		BIT(0)
+#define PCS_PROT_2500M_SGMII		BIT(1)
+#define PCS_PROT_XFI			BIT(3)
+#define PCS_PROT_SFI			BIT(4)
+#define PCS_PROT_10G_SXGMII		BIT(6)
+
+/* NETC privileged register block register */
+#define PRB_NETCRR			0x100
+#define  NETCRR_SR			BIT(0)
+#define  NETCRR_LOCK			BIT(1)
+
+#define PRB_NETCSR			0x104
+#define  NETCSR_ERROR			BIT(0)
+#define  NETCSR_STATE			BIT(1)
+
+/* NETC integrated endpoint register block register */
+#define IERB_EMDIOFAUXR			0x344
+#define IERB_T0FAUXR			0x444
+#define IERB_EFAUXR(a)			(0x3044 + 0x100 * (a))
+#define IERB_VFAUXR(a)			(0x4004 + 0x40 * (a))
+#define FAUXR_LDID			GENMASK(3, 0)
+
+/* Platform information */
+#define IMX95_ENETC0_BUS_DEVFN		0x0
+#define IMX95_ENETC1_BUS_DEVFN		0x40
+#define IMX95_ENETC2_BUS_DEVFN		0x80
+
+/* Flags for different platforms */
+#define NETC_HAS_NETCMIX		BIT(0)
+
+struct netc_blk_ctrl {
+	void __iomem *prb;
+	void __iomem *ierb;
+	void __iomem *netcmix;
+};
+
+static void netc_reg_write(void __iomem *base, u32 offset, u32 val)
+{
+	writel(val, base + offset);
+}
+
+static u32 netc_reg_read(void __iomem *base, u32 offset)
+{
+	return readl(base + offset);
+}
+
+static int netc_of_pci_get_bus_devfn(ofnode node)
+{
+	u32 reg[5];
+	int error;
+
+	error = ofnode_read_u32_array(node, "reg", reg, ARRAY_SIZE(reg));
+	if (error)
+		return error;
+
+	return (reg[0] >> 8) & 0xffff;
+}
+
+static int netc_get_link_mii_protocol(phy_interface_t interface)
+{
+	switch (interface) {
+	case PHY_INTERFACE_MODE_MII:
+		return MII_PROT_MII;
+	case PHY_INTERFACE_MODE_RMII:
+		return MII_PROT_RMII;
+	case PHY_INTERFACE_MODE_RGMII:
+	case PHY_INTERFACE_MODE_RGMII_ID:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+		return MII_PROT_RGMII;
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_2500BASEX:
+	case PHY_INTERFACE_MODE_10GBASER:
+	case PHY_INTERFACE_MODE_XGMII:
+	case PHY_INTERFACE_MODE_USXGMII:
+		return MII_PROT_SERIAL;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int imx95_netcmix_init(struct udevice *dev)
+{
+	struct netc_blk_ctrl *priv = dev_get_priv(dev);
+	ofnode child, gchild;
+	phy_interface_t interface;
+	int bus_devfn, mii_proto;
+	u32 val;
+
+	/* Default setting of MII protocol */
+	val = MII_PROT(0, MII_PROT_RGMII) | MII_PROT(1, MII_PROT_RGMII) |
+	      MII_PROT(2, MII_PROT_SERIAL);
+
+	/* Update the link MII protocol through parsing phy-mode */
+	dev_for_each_subnode(child, dev) {
+		if (!ofnode_is_enabled(child))
+			continue;
+
+		ofnode_for_each_subnode(gchild, child) {
+			if (!ofnode_is_enabled(gchild))
+				continue;
+
+			if (!ofnode_device_is_compatible(gchild, "pci1131,e101"))
+				continue;
+
+			bus_devfn = netc_of_pci_get_bus_devfn(gchild);
+			if (bus_devfn < 0)
+				return -EINVAL;
+
+			if (bus_devfn == IMX95_ENETC2_BUS_DEVFN)
+				continue;
+
+			interface = ofnode_read_phy_mode(gchild);
+			if (interface == -1)
+				continue;
+
+			mii_proto = netc_get_link_mii_protocol(interface);
+			if (mii_proto < 0)
+				return -EINVAL;
+
+			switch (bus_devfn) {
+			case IMX95_ENETC0_BUS_DEVFN:
+				val &= ~CFG_LINK_MII_PORT_0;
+				val |= FIELD_PREP(CFG_LINK_MII_PORT_0, mii_proto);
+				break;
+			case IMX95_ENETC1_BUS_DEVFN:
+				val &= ~CFG_LINK_MII_PORT_1;
+				val |= FIELD_PREP(CFG_LINK_MII_PORT_1, mii_proto);
+				break;
+			default:
+				return -EINVAL;
+			}
+		}
+	}
+
+	/* Configure Link I/O variant */
+	netc_reg_write(priv->netcmix, IMX95_CFG_LINK_IO_VAR,
+		       IO_VAR(2, IO_VAR_16FF_16G_SERDES));
+	/* Configure Link 2 PCS protocol */
+	netc_reg_write(priv->netcmix, IMX95_CFG_LINK_PCS_PROT(2),
+		       PCS_PROT_10G_SXGMII);
+	netc_reg_write(priv->netcmix, IMX95_CFG_LINK_MII_PROT, val);
+
+	return 0;
+}
+
+static bool netc_ierb_is_locked(struct netc_blk_ctrl *priv)
+{
+	return !!(netc_reg_read(priv->prb, PRB_NETCRR) & NETCRR_LOCK);
+}
+
+static int netc_lock_ierb(struct netc_blk_ctrl *priv)
+{
+	u32 val;
+
+	netc_reg_write(priv->prb, PRB_NETCRR, NETCRR_LOCK);
+
+	return readl_poll_timeout(priv->prb + PRB_NETCSR, val,
+				  !(val & NETCSR_STATE), 2000);
+}
+
+static int netc_unlock_ierb_with_warm_reset(struct netc_blk_ctrl *priv)
+{
+	u32 val;
+
+	netc_reg_write(priv->prb, PRB_NETCRR, 0);
+
+	return readl_poll_timeout(priv->prb + PRB_NETCRR, val,
+				  !(val & NETCRR_LOCK), 100000);
+}
+
+static int imx95_ierb_init(struct udevice *dev)
+{
+	struct netc_blk_ctrl *priv = dev_get_priv(dev);
+
+	/* EMDIO : No MSI-X intterupt */
+	netc_reg_write(priv->ierb, IERB_EMDIOFAUXR, 0);
+	/* ENETC0 PF */
+	netc_reg_write(priv->ierb, IERB_EFAUXR(0), 0);
+	/* ENETC0 VF0 */
+	netc_reg_write(priv->ierb, IERB_VFAUXR(0), 1);
+	/* ENETC0 VF1 */
+	netc_reg_write(priv->ierb, IERB_VFAUXR(1), 2);
+	/* ENETC1 PF */
+	netc_reg_write(priv->ierb, IERB_EFAUXR(1), 3);
+	/* ENETC1 VF0 */
+	netc_reg_write(priv->ierb, IERB_VFAUXR(2), 5);
+	/* ENETC1 VF1 */
+	netc_reg_write(priv->ierb, IERB_VFAUXR(3), 6);
+	/* ENETC2 PF */
+	netc_reg_write(priv->ierb, IERB_EFAUXR(2), 4);
+	/* ENETC2 VF0 */
+	netc_reg_write(priv->ierb, IERB_VFAUXR(4), 5);
+	/* ENETC2 VF1 */
+	netc_reg_write(priv->ierb, IERB_VFAUXR(5), 6);
+	/* NETC TIMER */
+	netc_reg_write(priv->ierb, IERB_T0FAUXR, 7);
+
+	return 0;
+}
+
+static int netc_ierb_init(struct udevice *dev)
+{
+	struct netc_blk_ctrl *priv = dev_get_priv(dev);
+	int err;
+
+	if (netc_ierb_is_locked(priv)) {
+		err = netc_unlock_ierb_with_warm_reset(priv);
+		if (err) {
+			dev_err(dev, "Unlock IERB failed.\n");
+			return err;
+		}
+	}
+
+	err = imx95_ierb_init(dev);
+	if (err)
+		return err;
+
+	err = netc_lock_ierb(priv);
+	if (err) {
+		dev_err(dev, "Lock IERB failed.\n");
+		return err;
+	}
+
+	return 0;
+}
+
+static int netc_prb_check_error(struct netc_blk_ctrl *priv)
+{
+	if (netc_reg_read(priv->prb, PRB_NETCSR) & NETCSR_ERROR)
+		return -1;
+
+	return 0;
+}
+
+static const struct udevice_id netc_blk_ctrl_match[] = {
+	{ .compatible = "nxp,imx95-netc-blk-ctrl" },
+	{},
+};
+
+static int netc_blk_ctrl_probe(struct udevice *dev)
+{
+	struct netc_blk_ctrl *priv = dev_get_priv(dev);
+	struct clk *ipg_clk;
+	fdt_addr_t regs;
+	int err;
+
+	ipg_clk = devm_clk_get_optional(dev, "ipg");
+	if (IS_ERR(ipg_clk)) {
+		dev_err(dev, "Set ipg clock failed\n");
+		return PTR_ERR(ipg_clk);
+	}
+
+	err = clk_prepare_enable(ipg_clk);
+	if (err) {
+		dev_err(dev, "Enable ipg clock failed\n");
+		return PTR_ERR(ipg_clk);
+	}
+
+	regs = dev_read_addr_name(dev, "ierb");
+	if (regs == FDT_ADDR_T_NONE) {
+		dev_err(dev, "Missing IERB resource\n");
+		return -EINVAL;
+	}
+
+	priv->ierb = (void __iomem *)regs;
+	regs = dev_read_addr_name(dev, "prb");
+	if (regs == FDT_ADDR_T_NONE) {
+		dev_err(dev, "Missing PRB resource\n");
+		return -EINVAL;
+	}
+
+	priv->prb = (void __iomem *)regs;
+	regs = dev_read_addr_name(dev, "netcmix");
+	if (regs == FDT_ADDR_T_NONE) {
+		dev_err(dev, "Missing NETCMIX resource\n");
+		return -EINVAL;
+	}
+
+	priv->netcmix = (void __iomem *)regs;
+
+	err = imx95_netcmix_init(dev);
+	if (err) {
+		dev_err(dev, "Initializing NETCMIX failed\n");
+		return err;
+	}
+
+	err = netc_ierb_init(dev);
+	if (err) {
+		dev_err(dev, "Initializing IERB failed\n");
+		return err;
+	}
+
+	if (netc_prb_check_error(priv) < 0)
+		dev_warn(dev, "The current IERB configuration is invalid\n");
+
+	return 0;
+}
+
+U_BOOT_DRIVER(netc_blk_ctrl_drv) = {
+	.name		= "netc_blk_ctrl",
+	.id		= UCLASS_SIMPLE_BUS,
+	.of_match	= netc_blk_ctrl_match,
+	.probe		= netc_blk_ctrl_probe,
+	.priv_auto	= sizeof(struct netc_blk_ctrl),
+	.flags		= DM_FLAG_PRE_RELOC,
+};
-- 
2.45.2

