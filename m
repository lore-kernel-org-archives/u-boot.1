Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36EF3C2D0D1
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 08:36:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64D1F883AD;
	Mon, 24 Jun 2024 10:35:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1719218124;
	bh=BqYPYsplDlqYMULLNDLqrOP76U1GOq6amOo71IHpjQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WD98hxV1QsirFlRDT7PuU099RCcGfMzW4QUYcHCgU1o+XEXXKT0quand7JwmCzjmH
	 yOp3gqkpMcmH3kJjqAqf36ptGvg74PwstSYFFxMw5qHw/XdBMZviX6s+AmlmIyGZCB
	 jMOTXkZ+aZtZBtjnFnFrx6AgJlyOGGFtLAEPQdT9j5+CiIighgA9YUwcC+2ooNDF6y
	 rgxMxmMggq06omWTyAG7//wAFQoC4tY8WsKm3Veyl9JaggDWzYx+wsjSc4UdBag8MC
	 JpBZXSK++Fmw7CIG8Jz0Sl1+9VoRxmbOnuwfBqiJvpPeIN2bVmwuYNzkouRw4kH5WE
	 BtYf1YWAowYbg==
Received: from localhost (unknown [IPv6:2001:861:52:5f60:ff6c:4545:dfcf:4c97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: pro@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id E472188433;
 Mon, 24 Jun 2024 10:35:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1719218123;
 bh=BqYPYsplDlqYMULLNDLqrOP76U1GOq6amOo71IHpjQw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=pyp44znad1EQtf21OZIAEDBD72+2QTzzLIfc2LZMEUOrBq6/okZ5oGJIqCY6c5XPY
 u63zCZt+Wvh2bM3Nh4965rP8ZVTGRf6ooOipVk2nrz6zO1CQy1h3CTtOXjV/BjDL97
 NgQ/Jz5KBUTScdYR4VhiydbFx7F6CULwJ9EmSUX2W7zXfzTUj77RKqM9eHXHrGnXUH
 3KZBcvzPOF5dJNYhWKFYsOzNTytUYAoorBmVjgsr09rBtPCBOqrorBFCpDA+syEEhO
 1KGC+kJV6qGdSTA59c1/If5+9yL7vHkW0b1njLQw+FWBcYftcoElPT/KnEAXIMPa30
 pHCFqnHZ3ALSQ==
From: Philip Oberfichtner <pro@denx.de>
To: u-boot@lists.denx.de
Cc: bmeng.cn@gmail.com, caleb.connolly@linaro.org,
 christophe.roullier@foss.st.com, epsi@gmx.de, eugen.hristev@collabora.com,
 festevam@gmail.com, forbidden405@outlook.com, ivprusov@salutedevices.com,
 joe.hershberger@ni.com, jonas@kwiboo.se, kever.yang@rock-chips.com,
 leyfoon.tan@starfivetech.com, marek.vasut+renesas@mailbox.org,
 marjolaine.amate@odyssee-systemes.fr, neil.armstrong@linaro.org,
 n-francis@ti.com, patrice.chotard@foss.st.com,
 patrick.delaunay@foss.st.com, philipp.tomsich@vrull.eu,
 rfried.dev@gmail.com, seanga2@gmail.com, sebastian.reichel@collabora.com,
 sebastien.szymanski@armadeus.com, sjg@chromium.org, sumit.garg@linaro.org,
 trini@konsulko.com, xypron.glpk@gmx.de, Philip Oberfichtner <pro@denx.de>
Subject: [RESEND PATCH v2 5/5] net: dwc_eth_qos: Add glue driver for Intel MAC
Date: Mon, 24 Jun 2024 10:34:50 +0200
Message-Id: <20240624083450.90297-6-pro@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240624083450.90297-1-pro@denx.de>
References: <20240624083450.90297-1-pro@denx.de>
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

Add dwc_eth_qos glue driver for the Intel Elkhart-Lake SOC.

Signed-off-by: Philip Oberfichtner <pro@denx.de>
---

Notes:
    Changes in V2:
    	- Remove 'struct eqos_intel_config' from dwc_eth_qos.h
    	- Improve some comments
    	- Remove duplicate MAC reset

 drivers/net/Kconfig             |   7 +
 drivers/net/Makefile            |   1 +
 drivers/net/dwc_eth_qos_intel.c | 446 ++++++++++++++++++++++++++++++++
 drivers/net/dwc_eth_qos_intel.h |  58 +++++
 include/pci_ids.h               |   9 +
 5 files changed, 521 insertions(+)
 create mode 100644 drivers/net/dwc_eth_qos_intel.c
 create mode 100644 drivers/net/dwc_eth_qos_intel.h

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index b2d7b49976..b23fe55792 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -225,6 +225,13 @@ config DWC_ETH_QOS_IMX
 	  The Synopsys Designware Ethernet QOS IP block with the specific
 	  configuration used in IMX soc.
 
+config DWC_ETH_QOS_INTEL
+	bool "Synopsys DWC Ethernet QOS device support for Intel"
+	depends on DWC_ETH_QOS
+	help
+	  The Synopsys Designware Ethernet QOS IP block with the specific
+	  configuration used in the Intel Elkhart-Lake soc.
+
 config DWC_ETH_QOS_ROCKCHIP
 	bool "Synopsys DWC Ethernet QOS device support for Rockchip SoCs"
 	depends on DWC_ETH_QOS
diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index dc3404519d..bd62c65dd5 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_DRIVER_DM9000) += dm9000x.o
 obj-$(CONFIG_DSA_SANDBOX) += dsa_sandbox.o
 obj-$(CONFIG_DWC_ETH_QOS) += dwc_eth_qos.o
 obj-$(CONFIG_DWC_ETH_QOS_IMX) += dwc_eth_qos_imx.o
+obj-$(CONFIG_DWC_ETH_QOS_INTEL) += dwc_eth_qos_intel.o
 obj-$(CONFIG_DWC_ETH_QOS_ROCKCHIP) += dwc_eth_qos_rockchip.o
 obj-$(CONFIG_DWC_ETH_QOS_QCOM) += dwc_eth_qos_qcom.o
 obj-$(CONFIG_DWC_ETH_QOS_STARFIVE) += dwc_eth_qos_starfive.o
diff --git a/drivers/net/dwc_eth_qos_intel.c b/drivers/net/dwc_eth_qos_intel.c
new file mode 100644
index 0000000000..15680187cc
--- /dev/null
+++ b/drivers/net/dwc_eth_qos_intel.c
@@ -0,0 +1,446 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023 DENX Software Engineering GmbH
+ * Philip Oberfichtner <pro@denx.de>
+ *
+ * Based on linux v6.1.38, especially drivers/net/ethernet/stmicro/stmmac
+ */
+
+#include <asm/io.h>
+#include <dm.h>
+#include <linux/delay.h>
+#include <miiphy.h>
+#include <net.h>
+#include <pci.h>
+
+#include "dwc_eth_qos.h"
+#include "dwc_eth_qos_intel.h"
+
+static struct pci_device_id intel_pci_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_EHL_RGMII1G) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_EHL_SGMII1) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_EHL_SGMII2G5) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_EHL_PSE0_RGMII1G) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_EHL_PSE0_SGMII1G) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_EHL_PSE0_SGMII2G5) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_EHL_PSE1_RGMII1G) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_EHL_PSE1_SGMII1G) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_EHL_PSE1_SGMII2G5) },
+	{}
+};
+
+static int __pci_config(struct udevice *dev)
+{
+	u32 val;
+
+	/* Try to enable I/O accesses and bus-mastering */
+	dm_pci_read_config32(dev, PCI_COMMAND, &val);
+	val |= PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER;
+	dm_pci_write_config32(dev, PCI_COMMAND, val);
+
+	/* Make sure it worked */
+	dm_pci_read_config32(dev, PCI_COMMAND, &val);
+	if (!(val & PCI_COMMAND_MEMORY)) {
+		pr_err("%s: Can't enable I/O memory\n", __func__);
+		return -ENOSPC;
+	}
+
+	if (!(val & PCI_COMMAND_MASTER)) {
+		pr_err("%s: Can't enable bus-mastering\n", __func__);
+		return -EPERM;
+	}
+
+	return 0;
+}
+
+static void __limit_fifo_size(struct udevice *dev)
+{
+	/*
+	 * As described in Intel Erratum EHL22, Document Number: 636674-2.1,
+	 * the PSE GbE Controllers advertise a wrong RX and TX fifo size.
+	 * Software should limit this value to 64KB.
+	 */
+	struct eqos_priv *eqos = dev_get_priv(dev);
+
+	eqos->tx_fifo_sz = 0x8000;
+	eqos->rx_fifo_sz = 0x8000;
+}
+
+static int __serdes_status_poll(struct udevice *dev,
+				unsigned char phyaddr, unsigned char phyreg,
+				unsigned short mask, unsigned short val)
+{
+	struct eqos_priv *eqos = dev_get_priv(dev);
+	unsigned int retries = 10;
+	unsigned short val_rd;
+
+	do {
+		miiphy_read(eqos->mii->name, phyaddr, phyreg, &val_rd);
+		if ((val_rd & mask) == (val & mask))
+			return 0;
+		udelay(POLL_DELAY_US);
+	} while (--retries);
+
+	return -ETIMEDOUT;
+}
+
+ /* Returns -ve if MAC is unknown and 0 on success */
+static int __mac_check_pse(const struct udevice *dev, bool *is_pse)
+{
+	struct pci_child_plat *plat = dev_get_parent_plat(dev);
+
+	if (!plat || plat->vendor != PCI_VENDOR_ID_INTEL)
+		return -ENXIO;
+
+	switch (plat->device) {
+	case PCI_DEVICE_ID_INTEL_EHL_PSE0_RGMII1G:
+	case PCI_DEVICE_ID_INTEL_EHL_PSE1_RGMII1G:
+	case PCI_DEVICE_ID_INTEL_EHL_PSE0_SGMII1G:
+	case PCI_DEVICE_ID_INTEL_EHL_PSE1_SGMII1G:
+	case PCI_DEVICE_ID_INTEL_EHL_PSE0_SGMII2G5:
+	case PCI_DEVICE_ID_INTEL_EHL_PSE1_SGMII2G5:
+		*is_pse = 1;
+		return 0;
+
+	case PCI_DEVICE_ID_INTEL_EHL_RGMII1G:
+	case PCI_DEVICE_ID_INTEL_EHL_SGMII1:
+	case PCI_DEVICE_ID_INTEL_EHL_SGMII2G5:
+		*is_pse = 0;
+		return 0;
+	};
+
+	return -ENXIO;
+}
+
+/* Check if we're in 2G5 mode */
+static bool __serdes_link_mode_2500(struct udevice *dev)
+{
+	const unsigned char phyad = INTEL_MGBE_ADHOC_ADDR;
+	struct eqos_priv *eqos = dev_get_priv(dev);
+	unsigned short data;
+
+	miiphy_read(eqos->mii->name, phyad, SERDES_GCR, &data);
+	if (((data & SERDES_LINK_MODE_MASK) >> SERDES_LINK_MODE_SHIFT) ==
+	    SERDES_LINK_MODE_2G5)
+		return true;
+
+	return false;
+}
+
+static int __serdes_powerup(struct udevice *dev)
+{
+	/* Based on linux/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c */
+
+	const unsigned char phyad = INTEL_MGBE_ADHOC_ADDR;
+	struct eqos_priv *eqos = dev_get_priv(dev);
+	unsigned short data;
+	int ret;
+	bool is_pse;
+
+	/* Set the serdes rate and the PCLK rate */
+	miiphy_read(eqos->mii->name, phyad, SERDES_GCR0, &data);
+
+	data &= ~SERDES_RATE_MASK;
+	data &= ~SERDES_PCLK_MASK;
+
+	if (__serdes_link_mode_2500(dev))
+		data |= SERDES_RATE_PCIE_GEN2 << SERDES_RATE_PCIE_SHIFT |
+			SERDES_PCLK_37p5MHZ << SERDES_PCLK_SHIFT;
+	else
+		data |= SERDES_RATE_PCIE_GEN1 << SERDES_RATE_PCIE_SHIFT |
+			SERDES_PCLK_70MHZ << SERDES_PCLK_SHIFT;
+
+	miiphy_write(eqos->mii->name, phyad, SERDES_GCR0, data);
+
+	/* assert clk_req */
+	miiphy_read(eqos->mii->name, phyad, SERDES_GCR0, &data);
+	data |= SERDES_PLL_CLK;
+	miiphy_write(eqos->mii->name, phyad, SERDES_GCR0, data);
+
+	/* check for clk_ack assertion */
+	ret = __serdes_status_poll(dev, phyad, SERDES_GSR0,
+				   SERDES_PLL_CLK, SERDES_PLL_CLK);
+
+	if (ret) {
+		pr_err("Serdes PLL clk request timeout\n");
+		return ret;
+	}
+
+	/* assert lane reset*/
+	miiphy_read(eqos->mii->name, phyad, SERDES_GCR0, &data);
+	data |= SERDES_RST;
+	miiphy_write(eqos->mii->name, phyad, SERDES_GCR0, data);
+
+	/* check for assert lane reset reflection */
+	ret = __serdes_status_poll(dev, phyad, SERDES_GSR0,
+				   SERDES_RST, SERDES_RST);
+
+	if (ret) {
+		pr_err("Serdes assert lane reset timeout\n");
+		return ret;
+	}
+
+	/* move power state to P0 */
+	miiphy_read(eqos->mii->name, phyad, SERDES_GCR0, &data);
+	data &= ~SERDES_PWR_ST_MASK;
+	data |= SERDES_PWR_ST_P0 << SERDES_PWR_ST_SHIFT;
+	miiphy_write(eqos->mii->name, phyad, SERDES_GCR0, data);
+
+	/* Check for P0 state */
+	ret = __serdes_status_poll(dev, phyad, SERDES_GSR0,
+				   SERDES_PWR_ST_MASK,
+				   SERDES_PWR_ST_P0 << SERDES_PWR_ST_SHIFT);
+
+	if (ret) {
+		pr_err("Serdes power state P0 timeout.\n");
+		return ret;
+	}
+
+	/* PSE only - ungate SGMII PHY Rx Clock*/
+	ret = __mac_check_pse(dev, &is_pse);
+	if (ret) {
+		pr_err("Failed to determine MAC type.\n");
+		return ret;
+	}
+
+	if (is_pse) {
+		miiphy_read(eqos->mii->name, phyad, SERDES_GCR0, &data);
+		data |= SERDES_PHY_RX_CLK;
+		miiphy_write(eqos->mii->name, phyad, SERDES_GCR0, data);
+	}
+
+	return 0;
+}
+
+static int __xpcs_access(struct udevice *dev, int reg, int v)
+{
+	/*
+	 * Common read/write helper function
+	 *
+	 * It may seem a bit odd at a first glance that we use bus->read()
+	 * directly insetad of one of the wrapper functions. But:
+	 *
+	 * (1) phy_read() can't be used because we do not access an acutal PHY,
+	 *     but a MAC-internal submodule.
+	 *
+	 * (2) miiphy_read() can't be used because it assumes MDIO_DEVAD_NONE.
+	 */
+
+	int port = INTEL_MGBE_XPCS_ADDR;
+	int devad = 0x1f;
+	u16 val;
+	struct eqos_priv *eqos;
+	struct mii_dev *bus;
+
+	eqos = dev_get_priv(dev);
+	bus = eqos->mii;
+
+	if (v < 0)
+		return bus->read(bus, port, devad, reg);
+
+	val = v;
+	return bus->write(bus, port, devad, reg, val);
+}
+
+static int __xpcs_read(struct udevice *dev, int reg)
+{
+	return __xpcs_access(dev, reg, -1);
+}
+
+static int __xpcs_write(struct udevice *dev, int reg, u16 val)
+{
+	return __xpcs_access(dev, reg, val);
+}
+
+static int __xpcs_clr_bits(struct udevice *dev, int reg, u16 bits)
+{
+	int ret;
+
+	ret = __xpcs_read(dev, reg);
+	if (ret < 0)
+		return ret;
+
+	ret &= ~bits;
+
+	return __xpcs_write(dev, reg, ret);
+}
+
+static int __xpcs_set_bits(struct udevice *dev, int reg, u16 bits)
+{
+	int ret;
+
+	ret = __xpcs_read(dev, reg);
+	if (ret < 0)
+		return ret;
+
+	ret |= bits;
+
+	return __xpcs_write(dev, reg, ret);
+}
+
+static int __xpcs_init(struct udevice *dev)
+{
+	/* Based on linux/drivers/net/pcs/pcs-xpcs.c */
+	struct eqos_priv *eqos = dev_get_priv(dev);
+	phy_interface_t interface = eqos->config->interface(dev);
+
+	if (interface != PHY_INTERFACE_MODE_SGMII)
+		return 0;
+
+	if (__xpcs_clr_bits(dev, VR_MII_MMD_CTRL,  XPCS_AN_CL37_EN)  ||
+	    __xpcs_set_bits(dev, VR_MII_AN_CTRL,   XPCS_MODE_SGMII)  ||
+	    __xpcs_set_bits(dev, VR_MII_DIG_CTRL1, XPCS_MAC_AUTO_SW) ||
+	    __xpcs_set_bits(dev, VR_MII_MMD_CTRL,  XPCS_AN_CL37_EN))
+		return -EIO;
+
+	return 0;
+}
+
+static int eqos_probe_ressources_intel(struct udevice *dev)
+{
+	__limit_fifo_size(dev);
+
+	return __pci_config(dev);
+}
+
+struct eqos_config eqos_intel_config;
+
+/*
+ * overwrite __weak function from eqos_intel.c
+ *
+ * For PCI devices the devcie tree is optional. Choose driver data based on PCI
+ * IDs instead.
+ */
+void *eqos_get_driver_data(struct udevice *dev)
+{
+	const struct pci_device_id *id;
+	const struct pci_child_plat *plat;
+
+	plat = dev_get_parent_plat(dev);
+
+	if (!plat)
+		return NULL;
+
+	/* last intel_pci_ids element is zero initialized */
+	for (id = intel_pci_ids; id->vendor != 0; id++) {
+		if (id->vendor == plat->vendor && id->device == plat->device)
+			return &eqos_intel_config;
+	}
+
+	return NULL;
+}
+
+static fdt_addr_t eqos_get_base_addr_intel(struct udevice *dev)
+{
+	void *ptr = dm_pci_map_bar(dev, PCI_BASE_ADDRESS_0, 0, 0,
+				   PCI_REGION_TYPE, PCI_REGION_MEM);
+
+	if (!ptr)
+		return FDT_ADDR_T_NONE;
+
+	return (fdt_addr_t)ptr;
+}
+
+static int eqos_start_resets_intel(struct udevice *dev)
+{
+	int ret;
+
+	ret = __xpcs_init(dev);
+	if (ret) {
+		pr_err("xpcs init failed.\n");
+		return ret;
+	}
+
+	ret = __serdes_powerup(dev);
+	if (ret) {
+		pr_err("Failed to power up serdes.\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static ulong eqos_get_tick_clk_rate_intel(struct udevice *dev)
+{
+	return 0;
+}
+
+static int eqos_get_enetaddr_intel(struct udevice *dev)
+{
+	/* Assume MAC address is programmed by previous boot stage */
+	struct eth_pdata *plat = dev_get_plat(dev);
+	struct eqos_priv *eqos = dev_get_priv(dev);
+	u8 *lo = (u8 *)&eqos->mac_regs->address0_low;
+	u8 *hi = (u8 *)&eqos->mac_regs->address0_high;
+
+	plat->enetaddr[0] = lo[0];
+	plat->enetaddr[1] = lo[1];
+	plat->enetaddr[2] = lo[2];
+	plat->enetaddr[3] = lo[3];
+	plat->enetaddr[4] = hi[0];
+	plat->enetaddr[5] = hi[1];
+
+	return 0;
+}
+
+static phy_interface_t eqos_get_interface_intel(const struct udevice *dev)
+{
+	struct pci_child_plat *plat = dev_get_parent_plat(dev);
+
+	if (!plat || plat->vendor != PCI_VENDOR_ID_INTEL)
+		return PHY_INTERFACE_MODE_NA;
+
+	switch (plat->device) {
+	/* The GbE Host Controller has no RGMII interface */
+	case PCI_DEVICE_ID_INTEL_EHL_RGMII1G:
+		return PHY_INTERFACE_MODE_NA;
+
+	case PCI_DEVICE_ID_INTEL_EHL_PSE0_RGMII1G:
+	case PCI_DEVICE_ID_INTEL_EHL_PSE1_RGMII1G:
+		return PHY_INTERFACE_MODE_RGMII;
+
+	/* Host SGMII and Host SGMII2G5 share the same device id */
+	case PCI_DEVICE_ID_INTEL_EHL_SGMII1:
+	case PCI_DEVICE_ID_INTEL_EHL_SGMII2G5:
+	case PCI_DEVICE_ID_INTEL_EHL_PSE0_SGMII2G5:
+	case PCI_DEVICE_ID_INTEL_EHL_PSE0_SGMII1G:
+	case PCI_DEVICE_ID_INTEL_EHL_PSE1_SGMII1G:
+	case PCI_DEVICE_ID_INTEL_EHL_PSE1_SGMII2G5:
+		return PHY_INTERFACE_MODE_SGMII;
+	};
+
+	return PHY_INTERFACE_MODE_NA;
+}
+
+static struct eqos_ops eqos_intel_ops = {
+	.eqos_inval_desc = eqos_inval_desc_generic,
+	.eqos_flush_desc = eqos_flush_desc_generic,
+	.eqos_inval_buffer = eqos_inval_buffer_generic,
+	.eqos_flush_buffer = eqos_flush_buffer_generic,
+	.eqos_probe_resources =  eqos_probe_ressources_intel,
+	.eqos_remove_resources = eqos_null_ops,
+	.eqos_get_base_addr = eqos_get_base_addr_intel,
+	.eqos_stop_resets = eqos_null_ops,
+	.eqos_start_resets = eqos_start_resets_intel,
+	.eqos_stop_clks = eqos_null_ops,
+	.eqos_start_clks = eqos_null_ops,
+	.eqos_calibrate_pads = eqos_null_ops,
+	.eqos_disable_calibration = eqos_null_ops,
+	.eqos_set_tx_clk_speed = eqos_null_ops,
+	.eqos_get_enetaddr = eqos_get_enetaddr_intel,
+	.eqos_get_tick_clk_rate = eqos_get_tick_clk_rate_intel,
+};
+
+struct eqos_config eqos_intel_config = {
+	.reg_access_always_ok = false,
+	.mdio_wait = 10,
+	.swr_wait = 50,
+	.config_mac = EQOS_MAC_RXQ_CTRL0_RXQ0EN_ENABLED_DCB,
+	.config_mac_mdio = EQOS_MAC_MDIO_ADDRESS_CR_250_300,
+	.axi_bus_width = EQOS_AXI_WIDTH_64,
+	.interface = eqos_get_interface_intel,
+	.ops = &eqos_intel_ops
+};
+
+extern U_BOOT_DRIVER(eth_eqos);
+U_BOOT_PCI_DEVICE(eth_eqos, intel_pci_ids);
diff --git a/drivers/net/dwc_eth_qos_intel.h b/drivers/net/dwc_eth_qos_intel.h
new file mode 100644
index 0000000000..a7eede621c
--- /dev/null
+++ b/drivers/net/dwc_eth_qos_intel.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (c) 2023 DENX Software Engineering GmbH
+ * Philip Oberfichtner <pro@denx.de>
+ *
+ * This header is based on linux v6.1.38,
+ *
+ *	drivers/net/pcs/pcs-xpcs.h
+ *	drivers/net/ethernet/stmicro/stmmac/dwmac-intel.h,
+ *
+ *      Copyright (c) 2020 Synopsys, Inc. and/or its affiliates
+ *      Copyright (c) 2020 Intel Corporation
+ */
+
+#ifndef __DWMAC_INTEL_H__
+#define __DWMAC_INTEL_H__
+
+#define POLL_DELAY_US 8
+
+/* SERDES Register */
+#define SERDES_GCR	0x0	/* Global Conguration */
+#define SERDES_GSR0	0x5	/* Global Status Reg0 */
+#define SERDES_GCR0	0xb	/* Global Configuration Reg0 */
+
+/* SERDES defines */
+#define SERDES_PLL_CLK		BIT(0)		/* PLL clk valid signal */
+#define SERDES_PHY_RX_CLK	BIT(1)		/* PSE SGMII PHY rx clk */
+#define SERDES_RST		BIT(2)		/* Serdes Reset */
+#define SERDES_PWR_ST_MASK	GENMASK(6, 4)	/* Serdes Power state*/
+#define SERDES_RATE_MASK	GENMASK(9, 8)
+#define SERDES_PCLK_MASK	GENMASK(14, 12)	/* PCLK rate to PHY */
+#define SERDES_LINK_MODE_MASK	GENMASK(2, 1)
+#define SERDES_LINK_MODE_SHIFT	1
+#define SERDES_PWR_ST_SHIFT	4
+#define SERDES_PWR_ST_P0	0x0
+#define SERDES_PWR_ST_P3	0x3
+#define SERDES_LINK_MODE_2G5	0x3
+#define SERSED_LINK_MODE_1G	0x2
+#define SERDES_PCLK_37p5MHZ	0x0
+#define SERDES_PCLK_70MHZ	0x1
+#define SERDES_RATE_PCIE_GEN1	0x0
+#define SERDES_RATE_PCIE_GEN2	0x1
+#define SERDES_RATE_PCIE_SHIFT	8
+#define SERDES_PCLK_SHIFT	12
+
+#define INTEL_MGBE_ADHOC_ADDR	0x15
+#define INTEL_MGBE_XPCS_ADDR	0x16
+
+/* XPCS defines */
+#define XPCS_MODE_SGMII		BIT(2)
+#define XPCS_MAC_AUTO_SW	BIT(9)
+#define XPCS_AN_CL37_EN		BIT(12)
+
+#define VR_MII_MMD_CTRL		0x0000
+#define VR_MII_DIG_CTRL1	0x8000
+#define VR_MII_AN_CTRL		0x8001
+
+#endif /* __DWMAC_INTEL_H__ */
diff --git a/include/pci_ids.h b/include/pci_ids.h
index f1886c3a75..14acb77d2d 100644
--- a/include/pci_ids.h
+++ b/include/pci_ids.h
@@ -2601,6 +2601,15 @@
 #define PCI_DEVICE_ID_DCI_PCCOM2	0x0004
 
 #define PCI_VENDOR_ID_INTEL		0x8086
+#define PCI_DEVICE_ID_INTEL_EHL_RGMII1G       0x4b30
+#define PCI_DEVICE_ID_INTEL_EHL_SGMII1        0x4b31
+#define PCI_DEVICE_ID_INTEL_EHL_SGMII2G5      0x4b32
+#define PCI_DEVICE_ID_INTEL_EHL_PSE0_RGMII1G  0x4ba0
+#define PCI_DEVICE_ID_INTEL_EHL_PSE0_SGMII1G  0x4ba1
+#define PCI_DEVICE_ID_INTEL_EHL_PSE0_SGMII2G5 0x4ba2
+#define PCI_DEVICE_ID_INTEL_EHL_PSE1_RGMII1G  0x4bb0
+#define PCI_DEVICE_ID_INTEL_EHL_PSE1_SGMII1G  0x4bb1
+#define PCI_DEVICE_ID_INTEL_EHL_PSE1_SGMII2G5 0x4bb2
 #define PCI_DEVICE_ID_INTEL_EESSC	0x0008
 #define PCI_DEVICE_ID_INTEL_SNB_IMC	0x0100
 #define PCI_DEVICE_ID_INTEL_IVB_IMC	0x0154
-- 
2.39.2

