Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 755B4C52D6F
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 14:59:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E586D88DE4;
	Wed, 21 Aug 2024 16:59:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="vwzkurQF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F61688A7E; Wed, 21 Aug 2024 16:59:26 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AC4E88BB8
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 16:59:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47LExImS021041;
 Wed, 21 Aug 2024 09:59:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1724252358;
 bh=kgHajaZPwqqbVuGLCvp00zwpz6rAntP+yISRB2QkfJU=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=vwzkurQFeNfArNbQlUiiC1jYEhewm0n32pG90mSKNldyyPoQDKh2YvDCf/kM+YWhw
 7k82EGKmaxrO7pblkku6Jv2kItq3D5p06ogIn73y4mUKepop+3ZwjFrheHFF3HKxPQ
 IdLs87WhhgEEgiPocxQui18Uo8r1JYxPAtc30I9w=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47LExIhI075921
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 21 Aug 2024 09:59:18 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 21
 Aug 2024 09:59:18 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 21 Aug 2024 09:59:18 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.81])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47LEx9wX121096;
 Wed, 21 Aug 2024 09:59:14 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <n-francis@ti.com>, <nm@ti.com>, <a-limaye@ti.com>, 
 <marcel.ziswiler@toradex.com>, <seanga2@gmail.com>, <sjg@chromium.org>,
 <marex@denx.de>, <john@phrozen.org>, <ansuelsmth@gmail.com>,
 <sumit.garg@linaro.org>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <srk@ti.com>,
 <s-vadapalli@ti.com>
Subject: [RFC PATCH 1/2] pci: Add TI K3 Cadence PCIe Controller
Date: Wed, 21 Aug 2024 20:29:07 +0530
Message-ID: <20240821145908.3408573-2-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240821145908.3408573-1-s-vadapalli@ti.com>
References: <20240821145908.3408573-1-s-vadapalli@ti.com>
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

Add support for the Cadence PCIe Controller present on TI's K3 SoCs.
This driver is an adaptation of the Linux driver.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/pci/Kconfig        |   6 +
 drivers/pci/Makefile       |   1 +
 drivers/pci/pcie_cdns_ti.c | 645 +++++++++++++++++++++++++++++++++++++
 3 files changed, 652 insertions(+)
 create mode 100644 drivers/pci/pcie_cdns_ti.c

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 22a56f4ca3..876a5fa57e 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -137,6 +137,12 @@ config PCI_GT64120
 	bool "GT64120 PCI support"
 	depends on MIPS
 
+config PCIE_CDNS_TI
+	bool "TI K3 PCIe support"
+	help
+	  Say Y here to enable support for the Cadence PCIe Controller
+	  on TI's K3 SoCs.
+
 config PCI_PHYTIUM
 	bool "Phytium PCIe support"
 	help
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 5b2d296980..bf361cd0fb 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_PCI) += pci_auto_common.o pci_common.o
 obj-$(CONFIG_PCIE_ECAM_GENERIC) += pcie_ecam_generic.o
 obj-$(CONFIG_PCIE_ECAM_SYNQUACER) += pcie_ecam_synquacer.o
 obj-$(CONFIG_PCIE_APPLE) += pcie_apple.o
+obj-$(CONFIG_PCIE_CDNS_TI) += pcie_cdns_ti.o
 obj-$(CONFIG_PCI_FTPCI100) += pci_ftpci100.o
 obj-$(CONFIG_PCI_GT64120) += pci_gt64120.o
 obj-$(CONFIG_PCI_MPC85XX) += pci_mpc85xx.o
diff --git a/drivers/pci/pcie_cdns_ti.c b/drivers/pci/pcie_cdns_ti.c
new file mode 100644
index 0000000000..2b9bba19b4
--- /dev/null
+++ b/drivers/pci/pcie_cdns_ti.c
@@ -0,0 +1,645 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com
+ *
+ * PCIe controller driver for TI's K3 SoCs with Cadence PCIe controller
+ *
+ * Ported from the Linux driver - drivers/pci/controller/cadence/pci-j721e.c
+ *
+ * Author: Siddharth Vadapalli <s-vadapalli@ti.com>
+ *
+ */
+
+#include <asm/global_data.h>
+#include <asm/gpio.h>
+#include <clk-uclass.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <generic-phy.h>
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/log2.h>
+#include <log.h>
+#include <pci.h>
+#include <power-domain.h>
+#include <regmap.h>
+#include <syscon.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+#define CDNS_PCIE_LM_BASE		0x00100000
+#define CDNS_PCIE_LM_ID			(CDNS_PCIE_LM_BASE + 0x0044)
+#define CDNS_PCIE_LTSSM_CTRL_CAP	(CDNS_PCIE_LM_BASE + 0x0054)
+#define CDNS_PCIE_LM_RC_BAR_CFG		(CDNS_PCIE_LM_BASE + 0x0300)
+
+#define CDNS_PCIE_LM_ID_VENDOR_MASK	GENMASK(15, 0)
+#define CDNS_PCIE_LM_ID_VENDOR_SHIFT	0
+#define CDNS_PCIE_LM_ID_VENDOR(vid) \
+	(((vid) << CDNS_PCIE_LM_ID_VENDOR_SHIFT) & CDNS_PCIE_LM_ID_VENDOR_MASK)
+#define CDNS_PCIE_LM_ID_SUBSYS_MASK	GENMASK(31, 16)
+#define CDNS_PCIE_LM_ID_SUBSYS_SHIFT	16
+#define CDNS_PCIE_LM_ID_SUBSYS(sub) \
+	(((sub) << CDNS_PCIE_LM_ID_SUBSYS_SHIFT) & CDNS_PCIE_LM_ID_SUBSYS_MASK)
+
+#define CDNS_PCIE_LM_RC_BAR_CFG_BAR0_CTRL_MASK		GENMASK(8, 6)
+#define CDNS_PCIE_LM_RC_BAR_CFG_BAR0_CTRL(c) \
+	(((c) << 6) & CDNS_PCIE_LM_RC_BAR_CFG_BAR0_CTRL_MASK)
+#define CDNS_PCIE_LM_RC_BAR_CFG_BAR1_CTRL_MASK		GENMASK(16, 14)
+#define CDNS_PCIE_LM_RC_BAR_CFG_BAR1_CTRL(c) \
+	(((c) << 14) & CDNS_PCIE_LM_RC_BAR_CFG_BAR1_CTRL_MASK)
+#define CDNS_PCIE_LM_RC_BAR_CFG_PREFETCH_MEM_ENABLE	BIT(17)
+#define CDNS_PCIE_LM_RC_BAR_CFG_PREFETCH_MEM_64BITS	BIT(18)
+#define CDNS_PCIE_LM_RC_BAR_CFG_IO_ENABLE		BIT(19)
+#define CDNS_PCIE_LM_RC_BAR_CFG_IO_32BITS		BIT(20)
+
+#define CDNS_PCIE_LM_BAR_CFG_CTRL_DISABLED		0x0
+
+#define CDNS_PCIE_RP_BASE	0x00200000
+
+/*
+ * Address Translation Registers
+ */
+#define CDNS_PCIE_AT_BASE	0x00400000
+
+/* Region r Outbound AXI to PCIe Address Translation Register 0 */
+#define CDNS_PCIE_AT_OB_REGION_PCI_ADDR0(r) \
+	(CDNS_PCIE_AT_BASE + 0x0000 + ((r) & 0x1f) * 0x0020)
+#define CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_NBITS_MASK	GENMASK(5, 0)
+#define CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_NBITS(nbits) \
+	(((nbits) - 1) & CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_NBITS_MASK)
+#define CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_DEVFN_MASK	GENMASK(19, 12)
+#define CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_DEVFN(devfn) \
+	(((devfn) << 12) & CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_DEVFN_MASK)
+#define CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_BUS_MASK	GENMASK(27, 20)
+#define CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_BUS(bus) \
+	(((bus) << 20) & CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_BUS_MASK)
+
+/* Region r Outbound AXI to PCIe Address Translation Register 1 */
+#define CDNS_PCIE_AT_OB_REGION_PCI_ADDR1(r) \
+	(CDNS_PCIE_AT_BASE + 0x0004 + ((r) & 0x1f) * 0x0020)
+
+/* Region r Outbound PCIe Descriptor Register 0 */
+#define CDNS_PCIE_AT_OB_REGION_DESC0(r) \
+	(CDNS_PCIE_AT_BASE + 0x0008 + ((r) & 0x1f) * 0x0020)
+#define CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_MEM		0x2
+#define CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_IO		0x6
+#define CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_CONF_TYPE0	0xa
+#define CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_CONF_TYPE1	0xb
+
+/* Bit 23 MUST be set in RC mode. */
+#define CDNS_PCIE_AT_OB_REGION_DESC0_HARDCODED_RID	BIT(23)
+#define CDNS_PCIE_AT_OB_REGION_DESC0_DEVFN_MASK	GENMASK(31, 24)
+#define CDNS_PCIE_AT_OB_REGION_DESC0_DEVFN(devfn) \
+	(((devfn) << 24) & CDNS_PCIE_AT_OB_REGION_DESC0_DEVFN_MASK)
+
+/* Region r Outbound PCIe Descriptor Register 1 */
+#define CDNS_PCIE_AT_OB_REGION_DESC1(r)	\
+	(CDNS_PCIE_AT_BASE + 0x000c + ((r) & 0x1f) * 0x0020)
+#define CDNS_PCIE_AT_OB_REGION_DESC1_BUS_MASK	GENMASK(7, 0)
+#define CDNS_PCIE_AT_OB_REGION_DESC1_BUS(bus) \
+	((bus) & CDNS_PCIE_AT_OB_REGION_DESC1_BUS_MASK)
+
+/* Region r AXI Region Base Address Register 0 */
+#define CDNS_PCIE_AT_OB_REGION_CPU_ADDR0(r) \
+	(CDNS_PCIE_AT_BASE + 0x0018 + ((r) & 0x1f) * 0x0020)
+#define CDNS_PCIE_AT_OB_REGION_CPU_ADDR0_NBITS_MASK	GENMASK(5, 0)
+#define CDNS_PCIE_AT_OB_REGION_CPU_ADDR0_NBITS(nbits) \
+	(((nbits) - 1) & CDNS_PCIE_AT_OB_REGION_CPU_ADDR0_NBITS_MASK)
+
+/* Region r AXI Region Base Address Register 1 */
+#define CDNS_PCIE_AT_OB_REGION_CPU_ADDR1(r) \
+	(CDNS_PCIE_AT_BASE + 0x001c + ((r) & 0x1f) * 0x0020)
+
+/* AXI link down register */
+#define CDNS_PCIE_AT_LINKDOWN (CDNS_PCIE_AT_BASE + 0x0824)
+
+#define CDNS_PCIE_DETECT_QUIET_MIN_DELAY_MASK	GENMASK(2, 1)
+#define CDNS_PCIE_DETECT_QUIET_MIN_DELAY_SHIFT	1
+#define CDNS_PCIE_DETECT_QUIET_MIN_DELAY(delay) \
+	 (((delay) << CDNS_PCIE_DETECT_QUIET_MIN_DELAY_SHIFT) & \
+	 CDNS_PCIE_DETECT_QUIET_MIN_DELAY_MASK)
+
+#define LINK_TRAINING_ENABLE	BIT(0)
+#define LINK_WAIT_MAX_RETRIES	10
+#define LINK_WAIT_USLEEP_MIN	90000
+#define LINK_WAIT_USLEEP_MAX	100000
+
+#define PCIE_USER_CMD_STATUS_REG_OFFSET	0x4
+#define PCIE_USER_LINK_STATUS_REG_OFFSET	0x14
+#define PCIE_USER_LINK_STATUS_MASK		GENMASK(1, 0)
+
+#define PCIE_MODE_SEL_MASK		BIT(7)
+#define PCIE_GEN_SEL_MASK		GENMASK(1, 0)
+#define PCIE_LINK_WIDTH_MASK		GENMASK(9, 8)
+
+#define usleep_range(a, b) udelay((b))
+
+enum link_status {
+	NO_RECEIVERS_DETECTED,
+	LINK_TRAINING_IN_PROGRESS,
+	LINK_UP_DL_IN_PROGRESS,
+	LINK_UP_DL_COMPLETED,
+};
+
+struct pcie_cdns_ti {
+	struct udevice		*dev;
+	void __iomem		*intd_cfg_base;
+	void __iomem		*user_cfg_base;
+	void __iomem		*reg_base;
+	void __iomem		*cfg_base;
+	fdt_size_t		cfg_size;
+	struct regmap		*syscon_base;
+	struct pci_controller	*host_bridge;
+	u32			device_id;
+	u32			max_link_speed;
+	u32			num_lanes;
+	u32			pcie_ctrl_offset;
+	u32			vendor_id;
+
+	/* IO, MEM & PREFETCH PCI regions */
+	struct pci_region	io;
+	struct pci_region	mem;
+	struct pci_region	prefetch;
+};
+
+/* Cadence PCIe Controller register access helpers */
+static inline void pcie_cdns_ti_writel(struct pcie_cdns_ti *pcie, u32 reg, u32 val)
+{
+	writel(val, pcie->reg_base + reg);
+}
+
+static inline u32 pcie_cdns_ti_readl(struct pcie_cdns_ti *pcie, u32 reg)
+{
+	return readl(pcie->reg_base + reg);
+}
+
+/* Root Port register access helpers */
+static inline void pcie_cdns_ti_rp_writeb(struct pcie_cdns_ti *pcie,
+					  u32 reg, u8 val)
+{
+	void __iomem *addr = pcie->reg_base + CDNS_PCIE_RP_BASE + reg;
+
+	writeb(val, addr);
+}
+
+static inline void pcie_cdns_ti_rp_writew(struct pcie_cdns_ti *pcie,
+					  u32 reg, u16 val)
+{
+	void __iomem *addr = pcie->reg_base + CDNS_PCIE_RP_BASE + reg;
+
+	writew(val, addr);
+}
+
+/* User register access helpers */
+static inline u32 pcie_cdns_ti_user_readl(struct pcie_cdns_ti *pcie, u32 offset)
+{
+	return readl(pcie->user_cfg_base + offset);
+}
+
+static inline void pcie_cdns_ti_user_writel(struct pcie_cdns_ti *pcie, u32 offset,
+					    u32 val)
+{
+	writel(val, pcie->user_cfg_base + offset);
+}
+
+void __iomem *pcie_cdns_ti_map_bus(struct pcie_cdns_ti *pcie, pci_dev_t bdf,
+				   uint offset)
+{
+	int busnr, devnr, funcnr, devfn;
+	u32 addr0, desc0;
+
+	busnr = PCI_BUS(bdf);
+	devnr = PCI_DEV(bdf);
+	funcnr = PCI_FUNC(bdf);
+	devfn = (devnr << 3) | funcnr;
+
+	if (busnr == 0) {
+		if (devfn)
+			return NULL;
+		return pcie->reg_base + (offset & 0xfff);
+	}
+
+	if (!(pcie_cdns_ti_readl(pcie, CDNS_PCIE_LM_BASE) & 0x1))
+		return NULL;
+
+	pcie_cdns_ti_writel(pcie, CDNS_PCIE_AT_LINKDOWN, 0x0);
+
+	addr0 = CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_NBITS(12) |
+		CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_DEVFN(devfn) |
+		CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_BUS(busnr);
+	pcie_cdns_ti_writel(pcie, CDNS_PCIE_AT_OB_REGION_PCI_ADDR0(0), addr0);
+
+	desc0 = CDNS_PCIE_AT_OB_REGION_DESC0_HARDCODED_RID |
+		CDNS_PCIE_AT_OB_REGION_DESC0_DEVFN(0);
+
+	if (busnr == 1)
+		desc0 |= CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_CONF_TYPE0;
+	else
+		desc0 |= CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_CONF_TYPE1;
+
+	pcie_cdns_ti_writel(pcie, CDNS_PCIE_AT_OB_REGION_DESC0(0), desc0);
+
+	return pcie->cfg_base + (offset & 0xfff);
+}
+
+static int pcie_cdns_ti_read_config(const struct udevice *bus, pci_dev_t bdf,
+				    uint offset, ulong *valuep,
+				    enum pci_size_t size)
+{
+	struct pcie_cdns_ti *pcie = dev_get_priv(bus);
+	void __iomem *addr;
+	ulong value;
+
+	addr = pcie_cdns_ti_map_bus(pcie, bdf, offset & ~0x3);
+	if (!addr) {
+		debug("%s: bdf out of range\n", __func__);
+		*valuep = pci_get_ff(size);
+		return 0;
+	}
+
+	value = readl(addr);
+	*valuep = pci_conv_32_to_size(value, offset, size);
+
+	return 0;
+}
+
+static int pcie_cdns_ti_write_config(struct udevice *bus, pci_dev_t bdf,
+				     uint offset, ulong value,
+				     enum pci_size_t size)
+{
+	struct pcie_cdns_ti *pcie = dev_get_priv(bus);
+	void __iomem *addr;
+	ulong prev;
+
+	addr = pcie_cdns_ti_map_bus(pcie, bdf, offset & ~0x3);
+	if (!addr) {
+		debug("%s: bdf out of range\n", __func__);
+		return 0;
+	}
+
+	prev = readl(addr);
+	value = pci_conv_size_to_32(prev, value, offset, size);
+	writel(value, addr);
+
+	return 0;
+}
+
+static int pcie_cdns_ti_ctrl_init(struct pcie_cdns_ti *pcie)
+{
+	struct regmap *syscon = pcie->syscon_base;
+
+	/* Set mode of operation */
+	regmap_update_bits(syscon, pcie->pcie_ctrl_offset, PCIE_MODE_SEL_MASK,
+			   BIT(7));
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
+static void pcie_cdns_ti_detect_quiet_quirk(struct pcie_cdns_ti *pcie)
+{
+	u32 delay = 0x3;
+	u32 ltssm_ctrl_cap;
+
+	ltssm_ctrl_cap = pcie_cdns_ti_readl(pcie, CDNS_PCIE_LTSSM_CTRL_CAP);
+	ltssm_ctrl_cap = ((ltssm_ctrl_cap &
+			    ~CDNS_PCIE_DETECT_QUIET_MIN_DELAY_MASK) |
+			    CDNS_PCIE_DETECT_QUIET_MIN_DELAY(delay));
+
+	pcie_cdns_ti_writel(pcie, CDNS_PCIE_LTSSM_CTRL_CAP, ltssm_ctrl_cap);
+	ltssm_ctrl_cap = pcie_cdns_ti_readl(pcie, CDNS_PCIE_LTSSM_CTRL_CAP);
+}
+
+static void pcie_cdns_ti_start_user_link(struct pcie_cdns_ti *pcie)
+{
+	u32 reg;
+
+	reg = pcie_cdns_ti_user_readl(pcie, PCIE_USER_CMD_STATUS_REG_OFFSET);
+	reg |= LINK_TRAINING_ENABLE;
+	pcie_cdns_ti_user_writel(pcie, PCIE_USER_CMD_STATUS_REG_OFFSET, reg);
+}
+
+static bool pcie_cdns_ti_user_link_up(struct pcie_cdns_ti *pcie)
+{
+	u32 reg;
+
+	reg = pcie_cdns_ti_user_readl(pcie, PCIE_USER_LINK_STATUS_REG_OFFSET);
+	reg &= PCIE_USER_LINK_STATUS_MASK;
+	if (reg == LINK_UP_DL_COMPLETED)
+		return true;
+
+	return false;
+}
+
+static int pcie_cdns_ti_host_wait_for_link(struct pcie_cdns_ti *pcie)
+{
+	int retries;
+
+	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
+		if (pcie_cdns_ti_user_link_up(pcie)) {
+			dev_info(pcie->dev, "link up\n");
+			return 0;
+		}
+		usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
+	}
+
+	dev_err(pcie->dev, "failed to bring up link\n");
+	return -ETIMEDOUT;
+}
+
+static int pcie_cdns_ti_start_host_link(struct pcie_cdns_ti *pcie)
+{
+	int ret;
+
+	ret = pcie_cdns_ti_host_wait_for_link(pcie);
+	/* TODO: Handle Gen2 Link retrain quirk for J721E */
+
+	return ret;
+}
+
+static void pcie_cdns_ti_init_root_port(struct pcie_cdns_ti *pcie)
+{
+	u32 val, ctrl, id;
+
+	ctrl = CDNS_PCIE_LM_BAR_CFG_CTRL_DISABLED;
+	val = CDNS_PCIE_LM_RC_BAR_CFG_BAR0_CTRL(ctrl) |
+		CDNS_PCIE_LM_RC_BAR_CFG_BAR1_CTRL(ctrl) |
+		CDNS_PCIE_LM_RC_BAR_CFG_PREFETCH_MEM_ENABLE |
+		CDNS_PCIE_LM_RC_BAR_CFG_PREFETCH_MEM_64BITS |
+		CDNS_PCIE_LM_RC_BAR_CFG_IO_ENABLE |
+		CDNS_PCIE_LM_RC_BAR_CFG_IO_32BITS;
+	pcie_cdns_ti_writel(pcie, CDNS_PCIE_LM_RC_BAR_CFG, val);
+
+	if (pcie->vendor_id != 0xffff) {
+		id = CDNS_PCIE_LM_ID_VENDOR(pcie->vendor_id) |
+			CDNS_PCIE_LM_ID_SUBSYS(pcie->vendor_id);
+		pcie_cdns_ti_writel(pcie, CDNS_PCIE_LM_ID, id);
+	}
+
+	if (pcie->device_id != 0xffff)
+		pcie_cdns_ti_rp_writew(pcie, PCI_DEVICE_ID, pcie->device_id);
+
+	pcie_cdns_ti_rp_writeb(pcie, PCI_CLASS_REVISION, 0);
+	pcie_cdns_ti_rp_writeb(pcie, PCI_CLASS_PROG, 0);
+	pcie_cdns_ti_rp_writew(pcie, PCI_CLASS_DEVICE, PCI_CLASS_BRIDGE_PCI);
+}
+
+void pcie_cdns_ti_set_outbound_region(struct pcie_cdns_ti *pcie, u8 busnr,
+				      u8 fn, u32 r, bool is_io, u64 cpu_addr,
+				      u64 pci_addr, u32 size)
+{
+	u64 sz = 1ULL << fls64(size - 1);
+	int nbits = ilog2(sz);
+	u32 addr0, addr1, desc0, desc1;
+
+	if (nbits < 8)
+		nbits = 8;
+
+	addr0 = CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_NBITS(nbits) |
+		(lower_32_bits(pci_addr) & GENMASK(31, 8));
+	addr1 = upper_32_bits(pci_addr);
+
+	pcie_cdns_ti_writel(pcie, CDNS_PCIE_AT_OB_REGION_PCI_ADDR0(r), addr0);
+	pcie_cdns_ti_writel(pcie, CDNS_PCIE_AT_OB_REGION_PCI_ADDR1(r), addr1);
+
+	if (is_io)
+		desc0 = CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_IO;
+	else
+		desc0 = CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_MEM;
+	desc1 = 0;
+
+	desc0 |= CDNS_PCIE_AT_OB_REGION_DESC0_HARDCODED_RID |
+		 CDNS_PCIE_AT_OB_REGION_DESC0_DEVFN(0);
+	desc1 |= CDNS_PCIE_AT_OB_REGION_DESC1_BUS(busnr);
+
+	pcie_cdns_ti_writel(pcie, CDNS_PCIE_AT_OB_REGION_DESC0(r), desc0);
+	pcie_cdns_ti_writel(pcie, CDNS_PCIE_AT_OB_REGION_DESC1(r), desc1);
+
+	addr0 = CDNS_PCIE_AT_OB_REGION_CPU_ADDR0_NBITS(nbits) |
+		(lower_32_bits(cpu_addr) & GENMASK(31, 8));
+	addr1 = upper_32_bits(cpu_addr);
+
+	pcie_cdns_ti_writel(pcie, CDNS_PCIE_AT_OB_REGION_CPU_ADDR0(r), addr0);
+	pcie_cdns_ti_writel(pcie, CDNS_PCIE_AT_OB_REGION_CPU_ADDR1(r), addr1);
+}
+
+static void pcie_cdns_ti_init_address_translation(struct pcie_cdns_ti *pcie)
+{
+	struct pci_controller *hb = pcie->host_bridge;
+	u32 addr0, addr1, desc1, region = 1;
+	u64 cpu_addr = (u64)pcie->cfg_base;
+	int i, busnr = 0;
+
+	/*
+	 * Reserve region 0 for PCI configure space accesses:
+	 * OB_REGION_PCI_ADDR0 and OB_REGION_DESC0 are updated dynamically by
+	 * cdns_pci_map_bus(), other region registers are set here once for all.
+	 */
+	addr1 = 0; /* Should be programmed to zero. */
+	desc1 = CDNS_PCIE_AT_OB_REGION_DESC1_BUS(busnr);
+	pcie_cdns_ti_writel(pcie, CDNS_PCIE_AT_OB_REGION_PCI_ADDR1(0), addr1);
+	pcie_cdns_ti_writel(pcie, CDNS_PCIE_AT_OB_REGION_DESC1(0), desc1);
+
+	addr0 = CDNS_PCIE_AT_OB_REGION_CPU_ADDR0_NBITS(12) |
+		(lower_32_bits(cpu_addr) & GENMASK(31, 8));
+	addr1 = upper_32_bits(cpu_addr);
+	pcie_cdns_ti_writel(pcie, CDNS_PCIE_AT_OB_REGION_CPU_ADDR0(0), addr0);
+	pcie_cdns_ti_writel(pcie, CDNS_PCIE_AT_OB_REGION_CPU_ADDR1(0), addr1);
+
+	for (i = 0; i < hb->region_count; i++) {
+		if (hb->regions[i].flags == PCI_REGION_IO) {
+			pcie->io.phys_start = hb->regions[i].phys_start; /* IO base */
+			pcie->io.bus_start = hb->regions[i].bus_start;  /* IO_bus_addr */
+			pcie->io.size = hb->regions[i].size;      /* IO size */
+
+			pcie_cdns_ti_set_outbound_region(pcie, busnr, 0, region,
+							 true, pcie->io.phys_start,
+							 pcie->io.bus_start,
+							 pcie->io.size);
+		} else {
+			pcie->mem.phys_start = hb->regions[i].phys_start; /* MEM base */
+			pcie->mem.bus_start = hb->regions[i].bus_start;  /* MEM_bus_addr */
+			pcie->mem.size = hb->regions[i].size;	    /* MEM size */
+
+			pcie_cdns_ti_set_outbound_region(pcie, busnr, 0, region,
+							 false, pcie->mem.phys_start,
+							 pcie->mem.bus_start,
+							 pcie->mem.size);
+		}
+		region++;
+	}
+}
+
+static void pcie_cdns_ti_host_init(struct pcie_cdns_ti *pcie)
+{
+	pcie_cdns_ti_init_root_port(pcie);
+	pcie_cdns_ti_init_address_translation(pcie);
+}
+
+static int pcie_cdns_ti_setup_host(struct pcie_cdns_ti *pcie)
+{
+	int ret;
+
+	/* TODO: The following is only required for J7200 */
+	pcie_cdns_ti_detect_quiet_quirk(pcie);
+
+	pcie_cdns_ti_start_user_link(pcie);
+
+	ret = pcie_cdns_ti_start_host_link(pcie);
+	if (ret)
+		return ret;
+
+	pcie_cdns_ti_host_init(pcie);
+
+	return 0;
+}
+
+static int pcie_cdns_ti_probe(struct udevice *dev)
+{
+	struct pcie_cdns_ti *pcie = dev_get_priv(dev);
+	struct udevice *pci_ctlr = pci_get_controller(dev);
+	struct pci_controller *host_bridge = dev_get_uclass_priv(pci_ctlr);
+	struct power_domain pci_pwrdmn;
+	struct gpio_desc *gpiod;
+	struct phy serdes;
+	struct clk *clk;
+	int ret;
+
+	pcie->dev = dev;
+	pcie->host_bridge = host_bridge;
+
+	ret = power_domain_get_by_index(dev, &pci_pwrdmn, 0);
+	if (ret) {
+		dev_err(dev, "failed to get power domain\n");
+		return ret;
+	}
+
+	ret = power_domain_on(&pci_pwrdmn);
+	if (ret) {
+		dev_err(dev, "failed to power on\n");
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
+	ret = generic_phy_get_by_name(dev,  "pcie-phy", &serdes);
+	if (ret) {
+		dev_err(dev, "unable to get serdes");
+		return ret;
+	}
+	generic_phy_reset(&serdes);
+	generic_phy_init(&serdes);
+	generic_phy_power_on(&serdes);
+
+	ret = pcie_cdns_ti_ctrl_init(pcie);
+	if (ret)
+		return ret;
+
+	gpiod = devm_gpiod_get_optional(dev, "reset", GPIOD_IS_OUT);
+	if (IS_ERR(gpiod)) {
+		ret = PTR_ERR(gpiod);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "Failed to get reset GPIO\n");
+		return ret;
+	}
+
+	if (gpiod) {
+		ret = dm_gpio_set_value(gpiod, 0);
+		usleep_range(100, 200);
+		ret = dm_gpio_set_value(gpiod, 1);
+		if (ret)
+			return ret;
+	}
+
+	ret = pcie_cdns_ti_setup_host(pcie);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int pcie_cdns_ti_of_to_plat(struct udevice *dev)
+{
+	struct pcie_cdns_ti *pcie = dev_get_priv(dev);
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
+	pcie->cfg_base = dev_remap_addr_name(dev, "cfg");
+	if (!pcie->cfg_base)
+		return -EINVAL;
+
+	pcie->vendor_id = 0xffff;
+	pcie->device_id = 0xffff;
+	dev_read_u32(dev, "vendor-id", &pcie->vendor_id);
+	dev_read_u32(dev, "device-id", &pcie->device_id);
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
+static const struct dm_pci_ops pcie_cdns_ti_ops = {
+	.read_config	= pcie_cdns_ti_read_config,
+	.write_config	= pcie_cdns_ti_write_config,
+};
+
+static const struct udevice_id pcie_cdns_ti_ids[] = {
+	{ .compatible = "ti,j7200-pcie-host" },
+	{ }
+};
+
+U_BOOT_DRIVER(pcie_cdns_ti) = {
+	.name			= "pcie_cdns_ti",
+	.id			= UCLASS_PCI,
+	.of_match		= pcie_cdns_ti_ids,
+	.ops			= &pcie_cdns_ti_ops,
+	.of_to_plat		= pcie_cdns_ti_of_to_plat,
+	.probe			= pcie_cdns_ti_probe,
+	.priv_auto		= sizeof(struct pcie_cdns_ti),
+};
-- 
2.40.1

