Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F697C54E67
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 05:29:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4766E88141;
	Wed, 27 Mar 2024 06:29:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="hP1oZQc0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D57D388145; Wed, 27 Mar 2024 06:29:15 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89B4C88132
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 06:28:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danishanwar@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42R5SruK068890;
 Wed, 27 Mar 2024 00:28:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1711517333;
 bh=poby2Oe1i2+bT4JKkmBowhZIzY6HB8kefdtbvGzArik=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=hP1oZQc0SeUSm+os6DKV6S/KSxNXzu4xc9cmQocUwuCL1yUfcvzWv7DhemBxOgwzI
 RLJvM48gPo+v/LDLGO6gUQAdxtkxKdt3YbqsrOWHuuBO+SDk1NZMJhSUkSwQNan737
 LeSG3BZ0G+hcHbMWqebH962lQz3BLDU4z4hiIg/U=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42R5SrSA069409
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 27 Mar 2024 00:28:53 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 27
 Mar 2024 00:28:52 -0500
Received: from fllvsmtp8.itg.ti.com (10.64.41.158) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 27 Mar 2024 00:28:52 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
 by fllvsmtp8.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42R5Sqod003564;
 Wed, 27 Mar 2024 00:28:52 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
 by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 42R5SqTk017307;
 Wed, 27 Mar 2024 00:28:52 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>, Maxime Ripard
 <mripard@kernel.org>, Nishanth Menon <nm@ti.com>, Roger Quadros
 <rogerq@kernel.org>, Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, MD
 Danish Anwar <danishanwar@ti.com>,
 Devarsh Thakkar <devarsht@ti.com>, Aradhya Bhatia <a-bhatia1@ti.com>,
 Nikhil M Jain <n-jain1@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>, Manorit
 Chawdhry <m-chawdhry@ti.com>, Andrew Davis <afd@ti.com>, Ramon Fried
 <rfried.dev@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>, Tom Rini
 <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, <r-gunasekaran@ti.com>
Subject: [PATCH v4 4/5] net: ti: icssg: Add ICSSG ethernet driver
Date: Wed, 27 Mar 2024 10:58:40 +0530
Message-ID: <20240327052841.1692469-5-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240327052841.1692469-1-danishanwar@ti.com>
References: <20240327052841.1692469-1-danishanwar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

This is the PRUSS Ethernet driver for TI AM654 Sr2.0 and laterSoCs with
the ICSSG PRU Sub-system running EMAC firmware. ICSSG Subsystem supports
two slices per instance. This driver caters to both slices / ports of
the icssg subsystem.

Since it is not possible for Ethernet driver to register more than one
port for a given instance, this patch introduces top level PRUETH as
UCLASS_MISC and binds UCLASS_ETH to individual ports in order to support
bringing up more than one Ethernet interface in U-Boot.

Since top level driver is UCLASS_MISC, board files would need to
instantiate the driver explicitly.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 arch/arm/mach-k3/common.c     |  11 +
 drivers/net/ti/Kconfig        |  13 +
 drivers/net/ti/Makefile       |   1 +
 drivers/net/ti/icssg_prueth.c | 685 ++++++++++++++++++++++++++++++++++
 drivers/net/ti/icssg_prueth.h |   3 +
 5 files changed, 713 insertions(+)
 create mode 100644 drivers/net/ti/icssg_prueth.c

diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index b0fb87b97a..d151277d6d 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -270,6 +270,17 @@ int misc_init_r(void)
 			printf("Failed to probe am65_cpsw_nuss driver\n");
 	}
 
+	if (IS_ENABLED(CONFIG_TI_ICSSG_PRUETH)) {
+		struct udevice *dev;
+		int ret;
+
+		ret = uclass_get_device_by_driver(UCLASS_MISC,
+						  DM_DRIVER_GET(prueth),
+						  &dev);
+		if (ret)
+			printf("Failed to probe prueth driver\n");
+	}
+
 	/* Default FIT boot on HS-SE devices */
 	if (get_device_type() == K3_DEVICE_TYPE_HS_SE)
 		env_set("boot_fit", "1");
diff --git a/drivers/net/ti/Kconfig b/drivers/net/ti/Kconfig
index 72eccc99e5..ddfa95a0b7 100644
--- a/drivers/net/ti/Kconfig
+++ b/drivers/net/ti/Kconfig
@@ -57,3 +57,16 @@ config MDIO_TI_CPSW
 	help
 	  This driver supports the TI CPSW MDIO interface found in various
 	  TI SoCs.
+
+config TI_ICSSG_PRUETH
+	bool "TI Gigabit PRU Ethernet driver"
+	depends on ARCH_K3
+	imply DM_MDIO
+	imply MISC_INIT_R
+	imply MISC
+	imply MDIO_TI_CPSW
+	select PHYLIB
+	select FS_LOADER
+	help
+	  Support Gigabit Ethernet ports over the ICSSG PRU Subsystem
+	  This subsystem is available starting with the AM65 platform.
diff --git a/drivers/net/ti/Makefile b/drivers/net/ti/Makefile
index 30c4c4b6d5..b2b3aa3b18 100644
--- a/drivers/net/ti/Makefile
+++ b/drivers/net/ti/Makefile
@@ -7,3 +7,4 @@ obj-$(CONFIG_DRIVER_TI_EMAC) += davinci_emac.o
 obj-$(CONFIG_DRIVER_TI_KEYSTONE_NET) += keystone_net.o cpsw_mdio.o
 obj-$(CONFIG_TI_AM65_CPSW_NUSS) += am65-cpsw-nuss.o
 obj-$(CONFIG_MDIO_TI_CPSW) += cpsw_mdio.o
+obj-$(CONFIG_TI_ICSSG_PRUETH) += icssg_prueth.o icssg_classifier.o icssg_config.o icssg_queues.o
diff --git a/drivers/net/ti/icssg_prueth.c b/drivers/net/ti/icssg_prueth.c
new file mode 100644
index 0000000000..d22a56c217
--- /dev/null
+++ b/drivers/net/ti/icssg_prueth.c
@@ -0,0 +1,685 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Texas Instruments K3 AM65 PRU Ethernet Driver
+ *
+ * Copyright (C) 2018-2024, Texas Instruments, Incorporated
+ *
+ */
+
+#include <asm/io.h>
+#include <asm/processor.h>
+#include <clk.h>
+#include <dm/lists.h>
+#include <dm/device.h>
+#include <dma-uclass.h>
+#include <dm/of_access.h>
+#include <dm/pinctrl.h>
+#include <fs_loader.h>
+#include <miiphy.h>
+#include <net.h>
+#include <phy.h>
+#include <power-domain.h>
+#include <linux/soc/ti/ti-udma.h>
+#include <regmap.h>
+#include <remoteproc.h>
+#include <syscon.h>
+#include <soc.h>
+#include <linux/pruss_driver.h>
+#include <dm/device_compat.h>
+
+#include "icssg_prueth.h"
+#include "icss_mii_rt.h"
+
+#define ICSS_SLICE0     0
+#define ICSS_SLICE1     1
+
+#ifdef PKTSIZE_ALIGN
+#define UDMA_RX_BUF_SIZE PKTSIZE_ALIGN
+#else
+#define UDMA_RX_BUF_SIZE ALIGN(1522, ARCH_DMA_MINALIGN)
+#endif
+
+#ifdef PKTBUFSRX
+#define UDMA_RX_DESC_NUM PKTBUFSRX
+#else
+#define UDMA_RX_DESC_NUM 4
+#endif
+
+/* Config region lies in shared RAM */
+#define ICSS_CONFIG_OFFSET_SLICE0	0
+#define ICSS_CONFIG_OFFSET_SLICE1	0x8000
+
+/* Firmware flags */
+#define ICSS_SET_RUN_FLAG_VLAN_ENABLE		BIT(0)	/* switch only */
+#define ICSS_SET_RUN_FLAG_FLOOD_UNICAST		BIT(1)	/* switch only */
+#define ICSS_SET_RUN_FLAG_PROMISC		BIT(2)	/* MAC only */
+#define ICSS_SET_RUN_FLAG_MULTICAST_PROMISC	BIT(3)	/* MAC only */
+
+/* CTRLMMR_ICSSG_RGMII_CTRL register bits */
+#define ICSSG_CTRL_RGMII_ID_MODE		BIT(24)
+
+/* Management packet type */
+#define PRUETH_PKT_TYPE_CMD		0x10
+
+/* Number of PRU Cores per Slice */
+#define ICSSG_NUM_PRU_CORES		3
+
+static int icssg_gmii_select(struct prueth_priv *priv)
+{
+	struct phy_device *phydev = priv->phydev;
+
+	if (phydev->interface != PHY_INTERFACE_MODE_MII &&
+	    phydev->interface < PHY_INTERFACE_MODE_RGMII &&
+	    phydev->interface > PHY_INTERFACE_MODE_RGMII_TXID) {
+		dev_err(priv->dev, "PHY mode unsupported %s\n",
+			phy_string_for_interface(phydev->interface));
+		return -EINVAL;
+	}
+
+	/* AM65 SR2.0 has TX Internal delay always enabled by hardware
+	 * and it is not possible to disable TX Internal delay. The below
+	 * switch case block describes how we handle different phy modes
+	 * based on hardware restriction.
+	 */
+	switch (phydev->interface) {
+	case PHY_INTERFACE_MODE_RGMII_ID:
+		phydev->interface = PHY_INTERFACE_MODE_RGMII_RXID;
+		break;
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+		phydev->interface = PHY_INTERFACE_MODE_RGMII;
+		break;
+	case PHY_INTERFACE_MODE_RGMII:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+		dev_err(priv->dev, "RGMII mode without TX delay is not supported");
+		return -EINVAL;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int icssg_phy_init(struct udevice *dev)
+{
+	struct prueth_priv *priv = dev_get_priv(dev);
+	struct phy_device *phydev;
+	u32 supported = PHY_GBIT_FEATURES;
+	int ret;
+
+	phydev = dm_eth_phy_connect(dev);
+	if (!phydev) {
+		dev_err(dev, "phy_connect() failed\n");
+		return -ENODEV;
+	}
+
+	/* disable unsupported features */
+	supported &= ~(PHY_10BT_FEATURES |
+			SUPPORTED_100baseT_Half |
+			SUPPORTED_1000baseT_Half |
+			SUPPORTED_Pause |
+			SUPPORTED_Asym_Pause);
+
+	phydev->supported &= supported;
+	phydev->advertising = phydev->supported;
+	priv->phydev = phydev;
+
+	ret = icssg_gmii_select(priv);
+	if (ret)
+		goto out;
+
+	ret = phy_config(phydev);
+	if (ret < 0)
+		dev_err(dev, "phy_config() failed: %d", ret);
+out:
+	return ret;
+}
+
+static void icssg_config_set_speed(struct prueth_priv *priv, int speed)
+{
+	struct prueth *prueth = priv->prueth;
+	u8 fw_speed;
+
+	switch (speed) {
+	case SPEED_1000:
+		fw_speed = FW_LINK_SPEED_1G;
+		break;
+	case SPEED_100:
+		fw_speed = FW_LINK_SPEED_100M;
+		break;
+	case SPEED_10:
+		fw_speed = FW_LINK_SPEED_10M;
+		break;
+	default:
+		/* Other links speeds not supported */
+		dev_err(priv->dev, "Unsupported link speed\n");
+		return;
+	}
+
+	writeb(fw_speed, prueth->dram[priv->port_id].pa + PORT_LINK_SPEED_OFFSET);
+}
+
+static int icssg_update_link(struct prueth_priv *priv)
+{
+	struct phy_device *phy = priv->phydev;
+	struct prueth *prueth = priv->prueth;
+	bool gig_en = false, full_duplex = false;
+
+	if (phy->link) { /* link up */
+		if (phy->speed == SPEED_1000)
+			gig_en = true;
+		if (phy->duplex == DUPLEX_FULL)
+			full_duplex = true;
+		/* Set the RGMII cfg for gig en and full duplex */
+		icssg_update_rgmii_cfg(prueth->miig_rt, phy->speed, full_duplex,
+				       priv->port_id, priv);
+		/* update the Tx IPG based on 100M/1G speed */
+		icssg_config_ipg(priv, phy->speed, priv->port_id);
+
+		/* Send command to firmware to update Speed setting */
+		icssg_config_set_speed(priv, phy->speed);
+
+		/* Enable PORT FORWARDING */
+		emac_set_port_state(priv, ICSSG_EMAC_PORT_FORWARD);
+
+		printf("link up on port %d, speed %d, %s duplex\n",
+		       priv->port_id, phy->speed,
+		       (phy->duplex == DUPLEX_FULL) ? "full" : "half");
+	} else {
+		emac_set_port_state(priv, ICSSG_EMAC_PORT_DISABLE);
+		printf("link down on port %d\n", priv->port_id);
+	}
+
+	return phy->link;
+}
+
+struct icssg_firmwares {
+	char *pru;
+	char *rtu;
+	char *txpru;
+};
+
+static struct icssg_firmwares icssg_emac_firmwares[] = {
+	{
+		.pru = "/lib/firmware/ti-pruss/am65x-sr2-pru0-prueth-fw.elf",
+		.rtu = "/lib/firmware/ti-pruss/am65x-sr2-rtu0-prueth-fw.elf",
+		.txpru = "/lib/firmware/ti-pruss/am65x-sr2-txpru0-prueth-fw.elf",
+	},
+	{
+		.pru = "/lib/firmware/ti-pruss/am65x-sr2-pru1-prueth-fw.elf",
+		.rtu = "/lib/firmware/ti-pruss/am65x-sr2-rtu1-prueth-fw.elf",
+		.txpru = "/lib/firmware/ti-pruss/am65x-sr2-txpru1-prueth-fw.elf",
+	}
+};
+
+static int icssg_start_pru_cores(struct udevice *dev)
+{
+	struct prueth_priv *priv = dev_get_priv(dev);
+	struct prueth *prueth = priv->prueth;
+	struct icssg_firmwares *firmwares;
+	struct udevice *rproc_dev = NULL;
+	int ret, slice;
+	u32 phandle;
+	u8 index;
+
+	slice = priv->port_id;
+	index = slice * ICSSG_NUM_PRU_CORES;
+	firmwares = icssg_emac_firmwares;
+
+	ofnode_read_u32_index(dev_ofnode(prueth->dev), "ti,prus", index, &phandle);
+	ret = uclass_get_device_by_phandle_id(UCLASS_REMOTEPROC, phandle, &rproc_dev);
+	if (ret) {
+		dev_err(dev, "Unknown remote processor with phandle '0x%x' requested(%d)\n",
+			phandle, ret);
+		return ret;
+	}
+
+	prueth->pru_core_id = dev_seq(rproc_dev);
+	ret = rproc_set_firmware(rproc_dev, firmwares[slice].pru);
+	if (ret)
+		return ret;
+
+	ret = rproc_boot(rproc_dev);
+	if (ret) {
+		dev_err(dev, "failed to boot PRU%d: %d\n", slice, ret);
+		return -EINVAL;
+	}
+
+	ofnode_read_u32_index(dev_ofnode(prueth->dev), "ti,prus", index + 1, &phandle);
+	ret = uclass_get_device_by_phandle_id(UCLASS_REMOTEPROC, phandle, &rproc_dev);
+	if (ret) {
+		dev_err(dev, "Unknown remote processor with phandle '0x%x' requested(%d)\n",
+			phandle, ret);
+		goto halt_pru;
+	}
+
+	prueth->rtu_core_id = dev_seq(rproc_dev);
+	ret = rproc_set_firmware(rproc_dev, firmwares[slice].rtu);
+	if (ret)
+		goto halt_pru;
+
+	ret = rproc_boot(rproc_dev);
+	if (ret) {
+		dev_err(dev, "failed to boot RTU%d: %d\n", slice, ret);
+		goto halt_pru;
+	}
+
+	ofnode_read_u32_index(dev_ofnode(prueth->dev), "ti,prus", index + 2, &phandle);
+	ret = uclass_get_device_by_phandle_id(UCLASS_REMOTEPROC, phandle, &rproc_dev);
+	if (ret) {
+		dev_err(dev, "Unknown remote processor with phandle '0x%x' requested(%d)\n",
+			phandle, ret);
+		goto halt_rtu;
+	}
+
+	prueth->txpru_core_id = dev_seq(rproc_dev);
+	ret = rproc_set_firmware(rproc_dev, firmwares[slice].txpru);
+	if (ret)
+		goto halt_rtu;
+
+	ret = rproc_boot(rproc_dev);
+	if (ret) {
+		dev_err(dev, "failed to boot TXPRU%d: %d\n", slice, ret);
+		goto halt_rtu;
+	}
+
+	return 0;
+
+halt_rtu:
+	rproc_stop(prueth->rtu_core_id);
+
+halt_pru:
+	rproc_stop(prueth->pru_core_id);
+	return ret;
+}
+
+static int icssg_stop_pru_cores(struct udevice *dev)
+{
+	struct prueth_priv *priv = dev_get_priv(dev);
+	struct prueth *prueth = priv->prueth;
+
+	rproc_stop(prueth->pru_core_id);
+	rproc_stop(prueth->rtu_core_id);
+	rproc_stop(prueth->txpru_core_id);
+
+	return 0;
+}
+
+static int prueth_start(struct udevice *dev)
+{
+	struct ti_udma_drv_chan_cfg_data *dma_rx_cfg_data;
+	struct eth_pdata *pdata = dev_get_plat(dev);
+	struct prueth_priv *priv = dev_get_priv(dev);
+	struct prueth *prueth = priv->prueth;
+	struct icssg_flow_cfg *flow_cfg;
+	u8 *hwaddr = pdata->enetaddr;
+	char chn_name[16];
+	void *config;
+	int ret, i;
+
+	icssg_class_set_mac_addr(prueth->miig_rt, priv->port_id, hwaddr);
+	icssg_ft1_set_mac_addr(prueth->miig_rt, priv->port_id, hwaddr);
+	icssg_class_default(prueth->miig_rt, priv->port_id, 0);
+
+	/* Set Load time configuration */
+	icssg_config(priv);
+
+	ret = icssg_start_pru_cores(dev);
+	if (ret)
+		return ret;
+
+	/* To differentiate channels for SLICE0 vs SLICE1 */
+	snprintf(chn_name, sizeof(chn_name), "tx%d-0", priv->port_id);
+
+	ret = dma_get_by_name(prueth->dev, chn_name, &prueth->dma_tx);
+	if (ret)
+		dev_err(dev, "TX dma get failed %d\n", ret);
+
+	snprintf(chn_name, sizeof(chn_name), "rx%d", priv->port_id);
+	ret = dma_get_by_name(prueth->dev, chn_name, &prueth->dma_rx);
+	if (ret)
+		dev_err(dev, "RX dma get failed %d\n", ret);
+
+	for (i = 0; i < UDMA_RX_DESC_NUM; i++) {
+		ret = dma_prepare_rcv_buf(&prueth->dma_rx,
+					  net_rx_packets[i],
+					  UDMA_RX_BUF_SIZE);
+		if (ret)
+			dev_err(dev, "RX dma add buf failed %d\n", ret);
+	}
+
+	ret = dma_enable(&prueth->dma_tx);
+	if (ret) {
+		dev_err(dev, "TX dma_enable failed %d\n", ret);
+		goto tx_fail;
+	}
+
+	ret = dma_enable(&prueth->dma_rx);
+	if (ret) {
+		dev_err(dev, "RX dma_enable failed %d\n", ret);
+		goto rx_fail;
+	}
+
+	/* check if the rx_flow_id of dma_rx is as expected since
+	 * driver hardcode that value in config struct to firmware
+	 * in probe. Just add this sanity check to catch any change
+	 * to rx channel assignment in the future.
+	 */
+	dma_get_cfg(&prueth->dma_rx, 0, (void **)&dma_rx_cfg_data);
+	config = (void *)(prueth->dram[priv->port_id].pa + ICSSG_CONFIG_OFFSET);
+
+	flow_cfg = config + PSI_L_REGULAR_FLOW_ID_BASE_OFFSET;
+	writew(dma_rx_cfg_data->flow_id_base, &flow_cfg->rx_base_flow);
+	writew(0, &flow_cfg->mgm_base_flow);
+
+	dev_info(dev, "K3 ICSSG: rflow_id_base: %u, chn_name = %s\n",
+		 dma_rx_cfg_data->flow_id_base, chn_name);
+
+	ret = phy_startup(priv->phydev);
+	if (ret) {
+		dev_err(dev, "phy_startup failed\n");
+		goto phy_fail;
+	}
+
+	ret = icssg_update_link(priv);
+	if (!ret) {
+		ret = -ENODEV;
+		goto phy_shut;
+	}
+
+	return 0;
+
+phy_shut:
+	phy_shutdown(priv->phydev);
+phy_fail:
+	dma_disable(&prueth->dma_rx);
+	dma_free(&prueth->dma_rx);
+rx_fail:
+	dma_disable(&prueth->dma_tx);
+	dma_free(&prueth->dma_tx);
+
+tx_fail:
+	icssg_class_disable(prueth->miig_rt, priv->port_id);
+
+	return ret;
+}
+
+static int prueth_send(struct udevice *dev, void *packet, int length)
+{
+	struct prueth_priv *priv = dev_get_priv(dev);
+	struct prueth *prueth = priv->prueth;
+	int ret;
+
+	ret = dma_send(&prueth->dma_tx, packet, length, NULL);
+
+	return ret;
+}
+
+static int prueth_recv(struct udevice *dev, int flags, uchar **packetp)
+{
+	struct prueth_priv *priv = dev_get_priv(dev);
+	struct prueth *prueth = priv->prueth;
+	int ret;
+
+	/* try to receive a new packet */
+	ret = dma_receive(&prueth->dma_rx, (void **)packetp, NULL);
+
+	return ret;
+}
+
+static int prueth_free_pkt(struct udevice *dev, uchar *packet, int length)
+{
+	struct prueth_priv *priv = dev_get_priv(dev);
+	struct prueth *prueth = priv->prueth;
+	int ret = 0;
+
+	if (length > 0) {
+		u32 pkt = prueth->rx_next % UDMA_RX_DESC_NUM;
+
+		dev_dbg(dev, "%s length:%d pkt:%u\n", __func__, length, pkt);
+
+		ret = dma_prepare_rcv_buf(&prueth->dma_rx,
+					  net_rx_packets[pkt],
+					  UDMA_RX_BUF_SIZE);
+		prueth->rx_next++;
+	}
+
+	return ret;
+}
+
+static void prueth_stop(struct udevice *dev)
+{
+	struct prueth_priv *priv = dev_get_priv(dev);
+	struct prueth *prueth = priv->prueth;
+
+	phy_shutdown(priv->phydev);
+
+	dma_disable(&prueth->dma_tx);
+	dma_disable(&prueth->dma_rx);
+
+	icssg_stop_pru_cores(dev);
+
+	dma_free(&prueth->dma_tx);
+	dma_free(&prueth->dma_rx);
+}
+
+static const struct eth_ops prueth_ops = {
+	.start		= prueth_start,
+	.send		= prueth_send,
+	.recv		= prueth_recv,
+	.free_pkt	= prueth_free_pkt,
+	.stop		= prueth_stop,
+};
+
+static int icssg_ofdata_parse_phy(struct udevice *dev)
+{
+	struct prueth_priv *priv = dev_get_priv(dev);
+
+	dev_read_u32(dev, "reg", &priv->port_id);
+	priv->phy_interface = dev_read_phy_mode(dev);
+	if (priv->phy_interface == PHY_INTERFACE_MODE_NA) {
+		dev_err(dev, "Invalid PHY mode '%s', port %u\n",
+			phy_string_for_interface(priv->phy_interface),
+			priv->port_id);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int prueth_port_probe(struct udevice *dev)
+{
+	struct prueth_priv *priv = dev_get_priv(dev);
+	struct prueth *prueth;
+	char portname[15];
+	int ret;
+
+	priv->dev = dev;
+	prueth = dev_get_priv(dev->parent);
+	priv->prueth = prueth;
+
+	sprintf(portname, "%s-%s", dev->parent->name, dev->name);
+
+	device_set_name(dev, portname);
+
+	ret = icssg_ofdata_parse_phy(dev);
+	if (ret)
+		goto out;
+
+	ret = icssg_phy_init(dev);
+	if (ret)
+		goto out;
+
+	ret = pruss_request_mem_region(prueth->pruss,
+				       priv->port_id ? PRUSS_MEM_DRAM1 : PRUSS_MEM_DRAM0,
+				       &prueth->dram[priv->port_id]);
+	if (ret) {
+		dev_err(dev, "could not request DRAM%d region\n", priv->port_id);
+		return ret;
+	}
+out:
+	return ret;
+}
+
+static int prueth_probe(struct udevice *dev)
+{
+	ofnode node, pruss_node, mdio_node, sram_node, curr_sram_node;
+	struct prueth *prueth = dev_get_priv(dev);
+	u32 phandle, err, sp, prev_end_addr;
+	struct udevice **prussdev = NULL;
+	ofnode eth_ports_node, eth_node;
+	struct udevice *port_dev;
+	int ret = 0;
+
+	prueth->dev = dev;
+
+	err = ofnode_read_u32(dev_ofnode(dev), "ti,prus", &phandle);
+	if (err)
+		return err;
+
+	node = ofnode_get_by_phandle(phandle);
+	if (!ofnode_valid(node))
+		return -EINVAL;
+
+	pruss_node = ofnode_get_parent(node);
+	ret = device_get_global_by_ofnode(pruss_node, prussdev);
+	if (ret)
+		dev_err(dev, "error getting the pruss dev\n");
+	prueth->pruss = *prussdev;
+
+	ret = pruss_request_mem_region(*prussdev, PRUSS_MEM_SHRD_RAM2,
+				       &prueth->shram);
+	if (ret)
+		return ret;
+
+	ret = pruss_request_tm_region(*prussdev, &prueth->tmaddr);
+	if (ret)
+		return ret;
+
+	prueth->miig_rt = syscon_regmap_lookup_by_phandle(dev, "ti,mii-g-rt");
+	if (!prueth->miig_rt) {
+		dev_err(dev, "couldn't get mii-g-rt syscon regmap\n");
+		return -ENODEV;
+	}
+
+	prueth->mii_rt = syscon_regmap_lookup_by_phandle(dev, "ti,mii-rt");
+	if (!prueth->mii_rt) {
+		dev_err(dev, "couldn't get mii-rt syscon regmap\n");
+		return -ENODEV;
+	}
+
+	ret = ofnode_read_u32(dev_ofnode(dev), "sram", &sp);
+	if (ret) {
+		dev_err(dev, "sram node fetch failed %d\n", ret);
+		return ret;
+	}
+
+	sram_node = ofnode_get_by_phandle(sp);
+	if (!ofnode_valid(sram_node))
+		return -EINVAL;
+
+	prev_end_addr = ofnode_get_addr(sram_node);
+
+	ofnode_for_each_subnode(curr_sram_node, sram_node) {
+		u32 start_addr, size, end_addr, avail;
+		const char *name;
+
+		name = ofnode_get_name(curr_sram_node);
+		start_addr = ofnode_get_addr(curr_sram_node);
+		size = ofnode_get_size(curr_sram_node);
+		end_addr = start_addr + size;
+		avail = start_addr - prev_end_addr;
+
+		if (avail > MSMC_RAM_SIZE)
+			break;
+
+		prev_end_addr = end_addr;
+	}
+
+	prueth->sram_pa = prev_end_addr;
+	if (prueth->sram_pa % SZ_64K != 0) {
+		/* This is constraint for SR2.0 firmware */
+		dev_err(dev, "sram address needs to be 64KB aligned\n");
+		return -EINVAL;
+	}
+	dev_dbg(dev, "sram: addr %x size %x\n", prueth->sram_pa, MSMC_RAM_SIZE);
+
+	mdio_node = ofnode_find_subnode(pruss_node, "mdio");
+	prueth->mdio_base = ofnode_get_addr(mdio_node);
+	ofnode_read_u32(mdio_node, "bus_freq", &prueth->mdio_freq);
+
+	ret = clk_get_by_name_nodev(mdio_node, "fck", &prueth->mdiofck);
+	if (ret) {
+		dev_err(dev, "failed to get clock %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_enable(&prueth->mdiofck);
+	if (ret) {
+		dev_err(dev, "clk_enable failed %d\n", ret);
+		return ret;
+	}
+
+	eth_ports_node = dev_read_subnode(dev, "ethernet-ports");
+	if (!ofnode_valid(eth_ports_node))
+		return -ENOENT;
+
+	ofnode_for_each_subnode(eth_node, eth_ports_node) {
+		const char *node_name;
+		u32 port_id;
+		bool disabled;
+
+		node_name = ofnode_get_name(eth_node);
+		disabled = !ofnode_is_enabled(eth_node);
+		ret = ofnode_read_u32(eth_node, "reg", &port_id);
+		if (ret)
+			dev_err(dev, "%s: error reading port_id (%d)\n", node_name, ret);
+
+		if (port_id >= PRUETH_NUM_MACS) {
+			dev_err(dev, "%s: invalid port_id (%d)\n", node_name, port_id);
+			return -EINVAL;
+		}
+
+		if (port_id < 0)
+			continue;
+		if (disabled)
+			continue;
+
+		ret = device_bind_driver_to_node(dev, "prueth_port",
+						 ofnode_get_name(eth_node),
+						 eth_node, &port_dev);
+		if (ret) {
+			dev_err(dev, "Failed to bind to %s node\n", ofnode_get_name(eth_node));
+			goto out;
+		}
+	}
+
+	return 0;
+out:
+	clk_disable(&prueth->mdiofck);
+
+	return ret;
+}
+
+static const struct udevice_id prueth_ids[] = {
+	{ .compatible = "ti,am654-icssg-prueth" },
+	{ .compatible = "ti,am642-icssg-prueth" },
+	{ }
+};
+
+U_BOOT_DRIVER(prueth) = {
+	.name	= "prueth",
+	.id	= UCLASS_MISC,
+	.of_match = prueth_ids,
+	.probe	= prueth_probe,
+	.priv_auto = sizeof(struct prueth),
+};
+
+U_BOOT_DRIVER(prueth_port) = {
+	.name	= "prueth_port",
+	.id	= UCLASS_ETH,
+	.probe	= prueth_port_probe,
+	.ops	= &prueth_ops,
+	.priv_auto = sizeof(struct prueth_priv),
+	.plat_auto = sizeof(struct eth_pdata),
+	.flags = DM_FLAG_ALLOC_PRIV_DMA,
+};
diff --git a/drivers/net/ti/icssg_prueth.h b/drivers/net/ti/icssg_prueth.h
index 42686b8c79..0c95fefbcb 100644
--- a/drivers/net/ti/icssg_prueth.h
+++ b/drivers/net/ti/icssg_prueth.h
@@ -62,6 +62,9 @@ struct prueth {
 	bool			mdio_manual_mode;
 	int			speed;
 	int			duplex;
+	u8			pru_core_id;
+	u8			rtu_core_id;
+	u8			txpru_core_id;
 };
 
 struct prueth_priv {
-- 
2.34.1

