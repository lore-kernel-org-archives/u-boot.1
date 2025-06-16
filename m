Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F491C71136
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 16:49:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3929682CA4;
	Mon, 16 Jun 2025 18:49:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="TDl/td4L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27C1082CBC; Mon, 16 Jun 2025 18:49:49 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 322BD81E18
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 18:49:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=h-salunke@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55GGneDt2692734;
 Mon, 16 Jun 2025 11:49:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1750092580;
 bh=/Tia9pAVYg3vRQmg63E+nxtltJ6ebxaWSMKd5CDSncs=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=TDl/td4LwndV44dOgHW/z5xaYqN/S1FiH7mxDJZorXVCYv+pHeOp/rCvarnEDVwWr
 yivIf3zLnLjvTZLTS7+CUQA0rMW9+X5pkK2gCJ+4n14RkG/FvA9PhYr1XtusL1U6mo
 WSiHbJ0E1gKm8JBkWPq5AbstDEnLmHWnejrvyH64=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55GGneZo2817625
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 16 Jun 2025 11:49:40 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 16
 Jun 2025 11:49:39 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 16 Jun 2025 11:49:39 -0500
Received: from hp-z2-tower.dhcp.ti.com (hp-z2-tower.dhcp.ti.com [172.24.227.4])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55GGnUUU416867;
 Mon, 16 Jun 2025 11:49:35 -0500
From: Hrushikesh Salunke <h-salunke@ti.com>
To: <vigneshr@ti.com>, <trini@konsulko.com>, <rfried.dev@gmail.com>,
 <jm@ti.com>, <s-k6@ti.com>, <rogerq@kernel.org>, <afd@ti.com>,
 <sjg@chromium.org>, <danishanwar@ti.com>, <anshuld@ti.com>,
 <n-francis@ti.com>
CC: <u-boot@lists.denx.de>, <h-salunke@ti.com>, <s-vadapalli@ti.com>,
 <srk@ti.com>
Subject: [PATCH v2 1/2] pci_endpoint: Add TI K3 Cadence PCIe Endpoint
 Controller driver
Date: Mon, 16 Jun 2025 22:19:28 +0530
Message-ID: <20250616164929.631791-2-h-salunke@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250616164929.631791-1-h-salunke@ti.com>
References: <20250616164929.631791-1-h-salunke@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Add support for Endpoint mode of operation in the Cadence PCIe
Controller present on TI's K3 SoCs. This driver is an adaptation of the
Linux kernel v6.15 driver (drivers/pci/controller/cadence/pci-j721e.c).

Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
---
 drivers/pci_endpoint/Kconfig           |   6 +
 drivers/pci_endpoint/Makefile          |   1 +
 drivers/pci_endpoint/pcie_cdns_ti_ep.c | 395 +++++++++++++++++++++++++
 3 files changed, 402 insertions(+)
 create mode 100644 drivers/pci_endpoint/pcie_cdns_ti_ep.c

diff --git a/drivers/pci_endpoint/Kconfig b/drivers/pci_endpoint/Kconfig
index 19cfa0aafb5..9900481daa6 100644
--- a/drivers/pci_endpoint/Kconfig
+++ b/drivers/pci_endpoint/Kconfig
@@ -22,6 +22,12 @@ config PCIE_CADENCE_EP
 	  endpoint mode. This PCIe controller may be embedded into many
 	  different vendors SoCs.
 
+config PCIE_CDNS_TI_EP
+	bool "TI K3 PCIe EP support"
+	help
+	  Say Y here to enable support for the Canence PCIe Controller
+	  in Endpoint Mode on TI's K3 Socs.
+
 config PCI_SANDBOX_EP
 	bool "Sandbox PCIe endpoint controller"
 	depends on PCI_ENDPOINT
diff --git a/drivers/pci_endpoint/Makefile b/drivers/pci_endpoint/Makefile
index 3cd987259d3..62a865c4463 100644
--- a/drivers/pci_endpoint/Makefile
+++ b/drivers/pci_endpoint/Makefile
@@ -6,3 +6,4 @@
 obj-y += pci_ep-uclass.o
 obj-$(CONFIG_PCIE_CADENCE_EP) += pcie-cadence-ep.o
 obj-$(CONFIG_PCI_SANDBOX_EP) += sandbox-pci_ep.o
+obj-$(CONFIG_PCIE_CDNS_TI_EP) += pcie_cdns_ti_ep.o
diff --git a/drivers/pci_endpoint/pcie_cdns_ti_ep.c b/drivers/pci_endpoint/pcie_cdns_ti_ep.c
new file mode 100644
index 00000000000..59c17d0f1e4
--- /dev/null
+++ b/drivers/pci_endpoint/pcie_cdns_ti_ep.c
@@ -0,0 +1,395 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Copyright (C) 2025 Texas Instruments Incorporated - https://www.ti.com
+ *
+ * PCIe Endpoint controller driver for TI's K3 SoCs with Cadence PCIe controller
+ *
+ * Ported from the Linux driver - drivers/pci/controller/cadence/pci-j721e.c
+ *
+ * Author: Hrushikesh Salunke <h-salunke@ti.com>
+ *
+ */
+
+#include <clk.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <generic-phy.h>
+#include <linux/log2.h>
+#include <linux/sizes.h>
+#include <power-domain.h>
+#include <regmap.h>
+#include <syscon.h>
+#include <pcie-cadence.h>
+#include <pci_ep.h>
+
+#define PCIE_USER_CMD_STATUS_REG_OFFSET	0x4
+#define LINK_TRAINING_ENABLE			BIT(0)
+
+#define PCIE_MODE_SEL_MASK			BIT(7)
+#define PCIE_GEN_SEL_MASK			GENMASK(1, 0)
+#define PCIE_LINK_WIDTH_MASK			GENMASK(9, 8)
+
+struct pcie_cdns_ti_ep_data {
+	unsigned int		quirk_retrain_flag:1;
+	unsigned int		quirk_detect_quiet_flag:1;
+	unsigned int		quirk_disable_flr:1;
+	unsigned int		byte_access_allowed:1;
+	unsigned int		max_lanes;
+};
+
+struct pcie_cdns_ti_ep {
+	struct udevice		*dev;
+	void __iomem		*intd_cfg_base;
+	void __iomem		*user_cfg_base;
+	void __iomem		*reg_base;
+	void __iomem		*mem_base;
+	fdt_size_t		cfg_size;
+	struct regmap		*syscon_base;
+	u32			max_link_speed;
+	u32			num_lanes;
+	u32			pcie_ctrl_offset;
+	unsigned int		quirk_retrain_flag:1;
+	unsigned int		quirk_detect_quiet_flag:1;
+	unsigned int		quirk_disable_flr:1;
+	unsigned int		byte_access_allowed:1;
+};
+
+static inline u32 pcie_cdns_ti_ep_user_readl(struct pcie_cdns_ti_ep *pcie, u32 offset)
+{
+	return readl(pcie->user_cfg_base + offset);
+}
+
+static inline void pcie_cdns_ti_ep_user_writel(struct pcie_cdns_ti_ep *pcie, u32 offset,
+					       u32 val)
+{
+	writel(val, pcie->user_cfg_base + offset);
+}
+
+static void pcie_cdns_ti_start_link(struct pcie_cdns_ti_ep *pcie)
+{
+	u32 reg;
+
+	reg = pcie_cdns_ti_ep_user_readl(pcie, PCIE_USER_CMD_STATUS_REG_OFFSET);
+	reg |= LINK_TRAINING_ENABLE;
+	pcie_cdns_ti_ep_user_writel(pcie, PCIE_USER_CMD_STATUS_REG_OFFSET, reg);
+}
+
+static int pcie_cdns_reset(struct udevice *dev, struct power_domain *pci_pwrdmn)
+{
+	int ret;
+
+	ret = power_domain_off(pci_pwrdmn);
+	if (ret) {
+		dev_err(dev, "failed to power off\n");
+		return ret;
+	}
+
+	ret = power_domain_on(pci_pwrdmn);
+	if (ret) {
+		dev_err(dev, "failed to power on: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int pcie_cdns_config_serdes(struct udevice *dev)
+{
+	if (CONFIG_IS_ENABLED(PHY_CADENCE_TORRENT)) {
+		struct phy serdes;
+		int ret = 7;
+
+		ret = generic_phy_get_by_name(dev,  "pcie-phy", &serdes);
+		if (ret != 0 && ret != -EBUSY) {
+			dev_err(dev, "unable to get serdes\n");
+			return ret;
+		}
+		generic_phy_reset(&serdes);
+		generic_phy_init(&serdes);
+		generic_phy_power_on(&serdes);
+	} else {
+		dev_info(dev, "Proceeding with the assumption that the SERDES is already configured\n");
+	}
+	return 0;
+}
+
+static int pcie_cdns_ti_ctrl_init(struct pcie_cdns_ti_ep *pcie)
+{
+	struct regmap *syscon = pcie->syscon_base;
+	u32 val = 0;
+
+	/* Set mode of operation */
+	regmap_update_bits(syscon, pcie->pcie_ctrl_offset, PCIE_MODE_SEL_MASK,
+			   val);
+
+	/* Set link speed */
+	regmap_update_bits(syscon, pcie->pcie_ctrl_offset, PCIE_GEN_SEL_MASK,
+			   pcie->max_link_speed - 1);
+
+	/* Set link width */
+	regmap_update_bits(syscon, pcie->pcie_ctrl_offset, PCIE_LINK_WIDTH_MASK,
+			   (pcie->num_lanes - 1) << 8);
+	return 0;
+}
+
+static int pcie_cdns_ti_write_header(struct udevice *dev, uint fn,
+				     struct pci_ep_header *hdr)
+{
+	struct pcie_cdns_ti_ep *pcie_ep = dev_get_priv(dev);
+	struct cdns_pcie pcie;
+
+	pcie.reg_base = pcie_ep->reg_base;
+
+	cdns_pcie_ep_fn_writew(&pcie, fn, PCI_DEVICE_ID, hdr->deviceid);
+	cdns_pcie_ep_fn_writeb(&pcie, fn, PCI_REVISION_ID, hdr->revid);
+	cdns_pcie_ep_fn_writeb(&pcie, fn, PCI_CLASS_PROG,
+			       hdr->progif_code);
+	cdns_pcie_ep_fn_writew(&pcie, fn, PCI_CLASS_DEVICE,
+			       hdr->subclass_code |
+			       hdr->baseclass_code << 8);
+	cdns_pcie_ep_fn_writeb(&pcie, fn, PCI_CACHE_LINE_SIZE,
+			       hdr->cache_line_size);
+	cdns_pcie_ep_fn_writew(&pcie, fn, PCI_SUBSYSTEM_ID,
+			       hdr->subsys_id);
+	cdns_pcie_ep_fn_writeb(&pcie, fn, PCI_INTERRUPT_PIN,
+			       hdr->interrupt_pin);
+
+	/*
+	 * Vendor ID can only be modified from function 0, all other functions
+	 * use the same vendor ID as function 0.
+	 */
+	if (fn == 0) {
+		/* Update the vendor IDs. */
+		u32 id = CDNS_PCIE_LM_ID_VENDOR(hdr->vendorid) |
+			 CDNS_PCIE_LM_ID_SUBSYS(hdr->subsys_vendor_id);
+
+		cdns_pcie_writel(&pcie, CDNS_PCIE_LM_ID, id);
+	}
+
+	return 0;
+}
+
+static int pcie_cdns_ti_set_bar(struct udevice *dev, uint fn,
+				struct pci_bar *ep_bar)
+{
+	struct pcie_cdns_ti_ep *pcie_ep = dev_get_priv(dev);
+	struct cdns_pcie pcie;
+	dma_addr_t bar_phys = ep_bar->phys_addr;
+	enum pci_barno bar = ep_bar->barno;
+	int flags = ep_bar->flags;
+	u32 addr0, addr1, reg, cfg, b, aperture, ctrl;
+	u64 sz;
+
+	pcie.reg_base = pcie_ep->reg_base;
+
+	/* BAR size is 2^(aperture + 7) */
+	sz = max_t(size_t, ep_bar->size, CDNS_PCIE_EP_MIN_APERTURE);
+	/*
+	 * roundup_pow_of_two() returns an unsigned long, which is not suited
+	 * for 64bit values.
+	 */
+	sz = 1ULL << fls64(sz - 1);
+	aperture = ilog2(sz) - 7; /* 128B -> 0, 256B -> 1, 512B -> 2, ... */
+
+	if ((flags & PCI_BASE_ADDRESS_SPACE) == PCI_BASE_ADDRESS_SPACE_IO) {
+		ctrl = CDNS_PCIE_LM_BAR_CFG_CTRL_IO_32BITS;
+	} else {
+		bool is_prefetch = !!(flags & PCI_BASE_ADDRESS_MEM_PREFETCH);
+		bool is_64bits = (sz > SZ_2G) |
+			!!(ep_bar->flags & PCI_BASE_ADDRESS_MEM_TYPE_64);
+
+		if (is_64bits && (bar & 1))
+			return -EINVAL;
+
+		if (is_64bits && !(flags & PCI_BASE_ADDRESS_MEM_TYPE_64))
+			ep_bar->flags |= PCI_BASE_ADDRESS_MEM_TYPE_64;
+
+		if (is_64bits && is_prefetch)
+			ctrl = CDNS_PCIE_LM_BAR_CFG_CTRL_PREFETCH_MEM_64BITS;
+		else if (is_prefetch)
+			ctrl = CDNS_PCIE_LM_BAR_CFG_CTRL_PREFETCH_MEM_32BITS;
+		else if (is_64bits)
+			ctrl = CDNS_PCIE_LM_BAR_CFG_CTRL_MEM_64BITS;
+		else
+			ctrl = CDNS_PCIE_LM_BAR_CFG_CTRL_MEM_32BITS;
+	}
+
+	addr0 = lower_32_bits(bar_phys);
+	addr1 = upper_32_bits(bar_phys);
+	cdns_pcie_writel(&pcie, CDNS_PCIE_AT_IB_EP_FUNC_BAR_ADDR0(fn, bar),
+			 addr0);
+	cdns_pcie_writel(&pcie, CDNS_PCIE_AT_IB_EP_FUNC_BAR_ADDR1(fn, bar),
+			 addr1);
+
+	/*
+	 * Cadence PCIe controller provides a register interface to configure
+	 * BAR of an Endpoint function. Per function there are two BAR configuration
+	 * registers, out of which first is used to configure BAR_0 to BAR_4 and
+	 * second is used to configure the remaining BARs.
+	 */
+	if (bar < BAR_4) {
+		reg = CDNS_PCIE_LM_EP_FUNC_BAR_CFG0(fn);
+		b = bar;
+	} else {
+		reg = CDNS_PCIE_LM_EP_FUNC_BAR_CFG1(fn);
+		b = bar - BAR_4;
+	}
+
+	cfg = cdns_pcie_readl(&pcie, reg);
+
+	cfg &= ~(CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_APERTURE_MASK(b) |
+		 CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_CTRL_MASK(b));
+	cfg |= (CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_APERTURE(b, aperture) |
+		CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_CTRL(b, ctrl));
+	cdns_pcie_writel(&pcie, reg, cfg);
+
+	cfg = cdns_pcie_readl(&pcie, reg);
+
+	return 0;
+}
+
+static int pcie_cdns_ti_start(struct udevice *dev)
+{
+	struct pcie_cdns_ti_ep *pcie = dev_get_priv(dev);
+
+	pcie_cdns_ti_start_link(pcie);
+
+	return 0;
+}
+
+static int pcie_cdns_ti_ep_probe(struct udevice *dev)
+{
+	struct pcie_cdns_ti_ep *pcie = dev_get_priv(dev);
+	struct pcie_cdns_ti_ep_data *data;
+	struct power_domain pci_pwrdmn;
+	struct clk *clk;
+	int ret;
+
+	pcie->dev = dev;
+	data = (struct pcie_cdns_ti_ep_data *)dev_get_driver_data(dev);
+	if (!data)
+		return -EINVAL;
+
+	pcie->quirk_retrain_flag = data->quirk_retrain_flag;
+	pcie->quirk_detect_quiet_flag = data->quirk_detect_quiet_flag;
+	pcie->quirk_disable_flr = data->quirk_disable_flr;
+
+	if (pcie->num_lanes > data->max_lanes) {
+		dev_warn(dev, "cannot support %d lanes, defaulting to %d\n",
+			 pcie->num_lanes, data->max_lanes);
+		pcie->num_lanes = data->max_lanes;
+	}
+
+	ret = power_domain_get_by_index(dev, &pci_pwrdmn, 0);
+	if (ret) {
+		dev_err(dev, "failed to get power domain: %d\n", ret);
+		return ret;
+	}
+
+	/*
+	 * Reset the PCIe controller so that newly configured BAR
+	 * values are reflected.
+	 */
+	ret = pcie_cdns_reset(dev, &pci_pwrdmn);
+	if (ret) {
+		dev_err(dev, "failed to reset controller: %d\n", ret);
+		return ret;
+	}
+
+	clk = devm_clk_get(dev, "fck");
+	if (IS_ERR(clk)) {
+		ret = PTR_ERR(clk);
+		dev_err(dev, "failed to get functional clock\n");
+		return ret;
+	}
+
+	ret = pcie_cdns_config_serdes(dev);
+	if (ret) {
+		dev_err(dev, "failed to configure serdes: %d\n", ret);
+		return ret;
+	}
+
+	ret = pcie_cdns_ti_ctrl_init(pcie);
+	if (ret) {
+		dev_err(dev, "failed to initialize controller: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int pcie_cdns_ti_ep_of_to_plat(struct udevice *dev)
+{
+	struct pcie_cdns_ti_ep *pcie = dev_get_priv(dev);
+	struct regmap *syscon;
+	u32 offset;
+	int ret;
+
+	pcie->intd_cfg_base = dev_remap_addr_name(dev, "intd_cfg");
+	if (!pcie->intd_cfg_base)
+		return -EINVAL;
+
+	pcie->user_cfg_base = dev_remap_addr_name(dev, "user_cfg");
+	if (!pcie->user_cfg_base)
+		return -EINVAL;
+
+	pcie->reg_base = dev_remap_addr_name(dev, "reg");
+	if (!pcie->reg_base)
+		return -EINVAL;
+
+	pcie->mem_base = dev_remap_addr_name(dev, "mem");
+	if (!pcie->mem_base)
+		return -EINVAL;
+
+	ret = dev_read_u32(dev, "num-lanes", &pcie->num_lanes);
+	if (ret)
+		return ret;
+
+	ret = dev_read_u32(dev, "max-link-speed", &pcie->max_link_speed);
+	if (ret)
+		return ret;
+
+	syscon = syscon_regmap_lookup_by_phandle(dev, "ti,syscon-pcie-ctrl");
+	if (IS_ERR(syscon)) {
+		if (PTR_ERR(syscon) == -ENODEV)
+			return 0;
+		return PTR_ERR(syscon);
+	}
+
+	ret = dev_read_u32_index(dev, "ti,syscon-pcie-ctrl", 1, &offset);
+	if (ret)
+		return ret;
+
+	pcie->syscon_base = syscon;
+	pcie->pcie_ctrl_offset = offset;
+
+	return 0;
+}
+
+static const struct pci_ep_ops pcie_cdns_ti_ep_ops = {
+	.write_header = pcie_cdns_ti_write_header,
+	.set_bar	  = pcie_cdns_ti_set_bar,
+	.start	      = pcie_cdns_ti_start,
+};
+
+static const struct pcie_cdns_ti_ep_data am64_pcie_ep_data = {
+	.max_lanes = 1,
+};
+
+static const struct udevice_id pcie_cdns_ti_ep_ids[] = {
+	{
+		.compatible = "ti,am64-pcie-ep",
+		.data = (ulong)&am64_pcie_ep_data,
+	},
+	{},
+};
+
+U_BOOT_DRIVER(pcie_cdns_ti_ep) = {
+	.name			= "pcie_cdns_ti_ep",
+	.id			    = UCLASS_PCI_EP,
+	.of_match		= pcie_cdns_ti_ep_ids,
+	.ops			= &pcie_cdns_ti_ep_ops,
+	.of_to_plat		= pcie_cdns_ti_ep_of_to_plat,
+	.probe			= pcie_cdns_ti_ep_probe,
+	.priv_auto		= sizeof(struct pcie_cdns_ti_ep),
+};
-- 
2.34.1

