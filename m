Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE6CFEFB56
	for <u-boot@archiver.kernel.org>; Fri, 27 Feb 2026 15:23:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98AF483E96;
	Fri, 27 Feb 2026 16:23:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1F7983EF9; Fri, 27 Feb 2026 16:23:34 +0100 (CET)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAFE683E76
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 16:23:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=duwe@lst.de
Received: by verein.lst.de (Postfix, from userid 2005)
 id 9A6CD68C7B; Fri, 27 Feb 2026 16:23:31 +0100 (CET)
In-Reply-To: <20260227152046.42DE068B05@verein.lst.de>
References: <20260227152046.42DE068B05@verein.lst.de>
From: Torsten Duwe <duwe@lst.de>
Subject: [PATCH 3/9] pci: brcmstb: Support different variants using a cfg
 struct
To: Peter Robinson <pbrobinson@gmail.com>, Matthias Brugger <mbrugger@suse.com>
Cc: Tom Rini <trini@konsulko.com>,"Jan Čermák" <sairon@sairon.cz>,Andrea della Porta <andrea.porta@suse.com>,"Ivan T. Ivanov" <iivanov@suse.de>, Stanimir Varbanov <stanimir.varbanov@suse.com>, Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>, Volodymyr Babchuk <volodymyr_babchuk@epam.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,Paul Barker <paul.barker.ct@bp.renesas.com>,Patrice Chotard <patrice.chotard@foss.st.com>,Christian Marangi <ansuelsmth@gmail.com>,Patrick Delaunay <patrick.delaunay@foss.st.com>,Huan Zhou <me@per1cycle.org>,Gabriel Fernandez <gabriel.fernandez@foss.st.com>,Kever Yang <kever.yang@rock-chips.com>,Jonas Karlman <jonas@kwiboo.se>,Joseph Chen <chenjh@rock-chips.com>,Elaine Zhang <zhangqing@rock-chips.com>, u-boot@lists.denx.de
Message-Id: <20260227152331.9A6CD68C7B@verein.lst.de>
Date: Fri, 27 Feb 2026 16:23:31 +0100 (CET)
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

From: Torsten Duwe <duwe@suse.de>

The Linux kernel driver already had support for multiple hardware
variants when the bcm2712 was added (see e.g. linux commit
10dbedad3c818 which is the last in a longer set of changes). This
patch brings in this required infrastructure and adds a
differentiation between 2711 and 2712 register layouts on top.
It also accounts for the bcm2712 reset logic quirk that the software
init bit must not remain set, albeit the reset control location is
only corrected in patch#6 of this series.

Signed-off-by: Torsten Duwe <duwe@suse.de>
---
 .../mach-bcm283x/include/mach/acpi/bcm2711.h  |   6 +-
 drivers/pci/pcie_brcmstb.c                    | 122 ++++++++++++++++--
 2 files changed, 114 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-bcm283x/include/mach/acpi/bcm2711.h b/arch/arm/mach-bcm283x/include/mach/acpi/bcm2711.h
index a86875b1833..6eb5389b858 100644
--- a/arch/arm/mach-bcm283x/include/mach/acpi/bcm2711.h
+++ b/arch/arm/mach-bcm283x/include/mach/acpi/bcm2711.h
@@ -70,6 +70,7 @@
 #define PCIE_MISC_RC_BAR2_CONFIG_HI               0x4038
 #define PCIE_MISC_RC_BAR3_CONFIG_LO               0x403c
 #define  RC_BAR3_CONFIG_LO_SIZE_MASK                0x1f
+#define PCIE_MISC_PCIE_CTRL			  0x4064
 #define PCIE_MISC_PCIE_STATUS                     0x4068
 #define  STATUS_PCIE_PORT_MASK                      0x80
 #define  STATUS_PCIE_PORT_SHIFT                        7
@@ -107,7 +108,10 @@
 #define PCIE_MSI_INTR2_MASK_SET               0x4510
 
 #define PCIE_RGR1_SW_INIT_1                   0x9210
-#define PCIE_EXT_CFG_INDEX                    0x9000
+#define  RGR1_SW_INIT_1_PERST_MASK			0x1
+#define  RGR1_SW_INIT_1_PERSTB_MASK			0x4
+#define  RGR1_SW_INIT_1_INIT_MASK			0x2
+
 /* A small window pointing at the ECAM of the device selected by CFG_INDEX */
 #define PCIE_EXT_CFG_DATA                     0x8000
 
diff --git a/drivers/pci/pcie_brcmstb.c b/drivers/pci/pcie_brcmstb.c
index 47c0802df23..261f8790528 100644
--- a/drivers/pci/pcie_brcmstb.c
+++ b/drivers/pci/pcie_brcmstb.c
@@ -49,6 +49,28 @@
 #define SSC_STATUS_PLL_LOCK_MASK			0x800
 #define SSC_STATUS_PLL_LOCK_SHIFT			11
 
+enum {
+	RGR1_SW_INIT_1,
+	EXT_CFG_INDEX,
+	EXT_CFG_DATA,
+	PCIE_HARD_DEBUG,
+};
+
+enum brcm_pcie_type {
+	BCM2711,
+	BCM2712
+};
+
+struct brcm_pcie;
+
+struct brcm_pcie_cfg_data {
+	const int *offsets;
+	const enum brcm_pcie_type type;
+	void (*perst_set)(struct brcm_pcie *pcie, u32 val);
+	void (*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
+	bool (*rc_mode)(struct brcm_pcie *pcie);
+};
+
 /**
  * struct brcm_pcie - the PCIe controller state
  * @base: Base address of memory mapped IO registers of the controller
@@ -61,6 +83,7 @@ struct brcm_pcie {
 
 	int			gen;
 	bool			ssc;
+	const struct brcm_pcie_cfg_data *pcie_cfg;
 };
 
 /**
@@ -104,6 +127,36 @@ static bool brcm_pcie_rc_mode(struct brcm_pcie *pcie)
 	return (val & STATUS_PCIE_PORT_MASK) >> STATUS_PCIE_PORT_SHIFT;
 }
 
+static void brcm_pcie_perst_set_generic(struct brcm_pcie *pcie, u32 val)
+{
+	if (val)
+		setbits_le32(pcie->base + pcie->pcie_cfg->offsets[RGR1_SW_INIT_1],
+			     RGR1_SW_INIT_1_PERST_MASK);
+	else
+		clrbits_le32(pcie->base + pcie->pcie_cfg->offsets[RGR1_SW_INIT_1],
+			     RGR1_SW_INIT_1_PERST_MASK);
+}
+
+static void brcm_pcie_perst_set_2712(struct brcm_pcie *pcie, u32 val)
+{
+	u32 tmp;
+
+	/* Perst bit has moved and assert value is 0 */
+	tmp = readl(pcie->base + PCIE_MISC_PCIE_CTRL);
+	u32p_replace_bits(&tmp, !val, RGR1_SW_INIT_1_PERSTB_MASK);
+	writel(tmp, pcie->base + PCIE_MISC_PCIE_CTRL);
+}
+
+static void brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie, u32 val)
+{
+	if (val)
+		setbits_le32(pcie->base + pcie->pcie_cfg->offsets[RGR1_SW_INIT_1],
+			     RGR1_SW_INIT_1_INIT_MASK);
+	else
+		clrbits_le32(pcie->base + pcie->pcie_cfg->offsets[RGR1_SW_INIT_1],
+			     RGR1_SW_INIT_1_INIT_MASK);
+}
+
 /**
  * brcm_pcie_link_up() - Check whether the PCIe link is up
  * @pcie: Pointer to the PCIe controller state
@@ -150,8 +203,8 @@ static int brcm_pcie_config_address(const struct udevice *dev, pci_dev_t bdf,
 	/* For devices, write to the config space index register */
 	idx = PCIE_ECAM_OFFSET(pci_bus, pci_dev, pci_func, 0);
 
-	writel(idx, pcie->base + PCIE_EXT_CFG_INDEX);
-	*paddress = pcie->base + PCIE_EXT_CFG_DATA + offset;
+	writel(idx, pcie->base + pcie->pcie_cfg->offsets[EXT_CFG_INDEX]);
+	*paddress = pcie->base + pcie->pcie_cfg->offsets[EXT_CFG_DATA] + offset;
 
 	return 0;
 }
@@ -365,8 +418,9 @@ static int brcm_pcie_probe(struct udevice *dev)
 	 * e.g. BCM7278, the fundamental reset should not be asserted here.
 	 * This will need to be changed when support for other SoCs is added.
 	 */
-	setbits_le32(base + PCIE_RGR1_SW_INIT_1,
-		     PCIE_RGR1_SW_INIT_1_INIT_MASK | PCIE_RGR1_SW_INIT_1_PERST_MASK);
+	pcie->pcie_cfg->bridge_sw_init_set(pcie, 1);
+	if (pcie->pcie_cfg->type != BCM2712)
+		pcie->pcie_cfg->perst_set(pcie, 1);
 	/*
 	 * The delay is a safety precaution to preclude the reset signal
 	 * from looking like a glitch.
@@ -374,9 +428,9 @@ static int brcm_pcie_probe(struct udevice *dev)
 	udelay(100);
 
 	/* Take the bridge out of reset */
-	clrbits_le32(base + PCIE_RGR1_SW_INIT_1, PCIE_RGR1_SW_INIT_1_INIT_MASK);
+	pcie->pcie_cfg->bridge_sw_init_set(pcie, 0);
 
-	clrbits_le32(base + PCIE_MISC_HARD_PCIE_HARD_DEBUG,
+	clrbits_le32(base + pcie->pcie_cfg->offsets[PCIE_HARD_DEBUG],
 		     PCIE_HARD_DEBUG_SERDES_IDDQ_MASK);
 
 	/* Wait for SerDes to be stable */
@@ -426,8 +480,7 @@ static int brcm_pcie_probe(struct udevice *dev)
 		brcm_pcie_set_gen(pcie, pcie->gen);
 
 	/* Unassert the fundamental reset */
-	clrbits_le32(pcie->base + PCIE_RGR1_SW_INIT_1,
-		     PCIE_RGR1_SW_INIT_1_PERST_MASK);
+	pcie->pcie_cfg->perst_set(pcie, 0);
 
 	/*
 	 * Wait for 100ms after PERST# deassertion; see PCIe CEM specification
@@ -446,7 +499,7 @@ static int brcm_pcie_probe(struct udevice *dev)
 		return -EINVAL;
 	}
 
-	if (!brcm_pcie_rc_mode(pcie)) {
+	if (!pcie->pcie_cfg->rc_mode(pcie)) {
 		printf("PCIe misconfigured; is in EP mode\n");
 		return -EINVAL;
 	}
@@ -514,14 +567,25 @@ static int brcm_pcie_remove(struct udevice *dev)
 	void __iomem *base = pcie->base;
 
 	/* Assert fundamental reset */
-	setbits_le32(base + PCIE_RGR1_SW_INIT_1, PCIE_RGR1_SW_INIT_1_PERST_MASK);
+	setbits_le32(base + pcie->pcie_cfg->offsets[RGR1_SW_INIT_1],
+		     PCIE_RGR1_SW_INIT_1_PERST_MASK);
 
 	/* Turn off SerDes */
-	setbits_le32(base + PCIE_MISC_HARD_PCIE_HARD_DEBUG,
+	setbits_le32(base + pcie->pcie_cfg->offsets[PCIE_HARD_DEBUG],
 		     PCIE_HARD_DEBUG_SERDES_IDDQ_MASK);
 
 	/* Shutdown bridge */
-	setbits_le32(base + PCIE_RGR1_SW_INIT_1, PCIE_RGR1_SW_INIT_1_INIT_MASK);
+	pcie->pcie_cfg->bridge_sw_init_set(pcie, 1);
+
+	/*
+	 * For the controllers that are utilizing reset for bridge Sw init,
+	 * such as BCM2712, reset should be deasserted after assertion.
+	 * Leaving it in asserted state may lead to unexpected hangs in
+	 * the Linux Kernel driver because it do not perform reset initialization
+	 * and start accessing device memory.
+	 */
+	if (pcie->pcie_cfg->type == BCM2712)
+		pcie->pcie_cfg->bridge_sw_init_set(pcie, 0);
 
 	return 0;
 }
@@ -546,6 +610,7 @@ static int brcm_pcie_of_to_plat(struct udevice *dev)
 	else
 		pcie->gen = max_link_speed;
 
+	pcie->pcie_cfg = (const struct brcm_pcie_cfg_data *)dev_get_driver_data(dev);
 	return 0;
 }
 
@@ -554,8 +619,39 @@ static const struct dm_pci_ops brcm_pcie_ops = {
 	.write_config	= brcm_pcie_write_config,
 };
 
+static const int pcie_offsets[] = {
+	[RGR1_SW_INIT_1] = 0x9210,
+	[EXT_CFG_INDEX]  = 0x9000,
+	[EXT_CFG_DATA]   = 0x8000,
+	[PCIE_HARD_DEBUG] = 0x4204,
+};
+
+static const struct brcm_pcie_cfg_data bcm2711_cfg = {
+	.offsets	= pcie_offsets,
+	.type		= BCM2711,
+	.perst_set	= brcm_pcie_perst_set_generic,
+	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
+	.rc_mode	= brcm_pcie_rc_mode,
+};
+
+static const int pcie_offsets_bcm2712[] = {
+	[RGR1_SW_INIT_1] = 0x0,
+	[EXT_CFG_INDEX] = 0x9000,
+	[EXT_CFG_DATA] = 0x8000,
+	[PCIE_HARD_DEBUG] = 0x4304,
+};
+
+static const struct brcm_pcie_cfg_data bcm2712_cfg = {
+	.offsets	= pcie_offsets_bcm2712,
+	.type		= BCM2712,
+	.perst_set	= brcm_pcie_perst_set_2712,
+	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
+	.rc_mode	= brcm_pcie_rc_mode,
+};
+
 static const struct udevice_id brcm_pcie_ids[] = {
-	{ .compatible = "brcm,bcm2711-pcie" },
+	{ .compatible = "brcm,bcm2711-pcie", .data = (ulong)&bcm2711_cfg },
+	{ .compatible = "brcm,bcm2712-pcie", .data = (ulong)&bcm2712_cfg },
 	{ }
 };
 
-- 
2.51.0

