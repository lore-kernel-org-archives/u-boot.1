Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C264EFEFB5D
	for <u-boot@archiver.kernel.org>; Fri, 27 Feb 2026 15:24:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5B4883F4D;
	Fri, 27 Feb 2026 16:23:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7A5283F4D; Fri, 27 Feb 2026 16:23:51 +0100 (CET)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E27D683F2A
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 16:23:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=duwe@lst.de
Received: by verein.lst.de (Postfix, from userid 2005)
 id BFF2568BFE; Fri, 27 Feb 2026 16:23:48 +0100 (CET)
In-Reply-To: <20260227152046.42DE068B05@verein.lst.de>
References: <20260227152046.42DE068B05@verein.lst.de>
From: Torsten Duwe <duwe@lst.de>
Subject: [PATCH 8/9] pci: brcmstb: rework iBAR handling
To: Peter Robinson <pbrobinson@gmail.com>, Matthias Brugger <mbrugger@suse.com>
Cc: Tom Rini <trini@konsulko.com>,"Jan Čermák" <sairon@sairon.cz>,Andrea della Porta <andrea.porta@suse.com>,"Ivan T. Ivanov" <iivanov@suse.de>, Stanimir Varbanov <stanimir.varbanov@suse.com>, Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>, Volodymyr Babchuk <volodymyr_babchuk@epam.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,Paul Barker <paul.barker.ct@bp.renesas.com>,Patrice Chotard <patrice.chotard@foss.st.com>,Christian Marangi <ansuelsmth@gmail.com>,Patrick Delaunay <patrick.delaunay@foss.st.com>,Huan Zhou <me@per1cycle.org>,Gabriel Fernandez <gabriel.fernandez@foss.st.com>,Kever Yang <kever.yang@rock-chips.com>,Jonas Karlman <jonas@kwiboo.se>,Joseph Chen <chenjh@rock-chips.com>,Elaine Zhang <zhangqing@rock-chips.com>, u-boot@lists.denx.de
Message-Id: <20260227152348.BFF2568BFE@verein.lst.de>
Date: Fri, 27 Feb 2026 16:23:48 +0100 (CET)
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

Rework the setup of inbound PCIe windows: use the convenience functions
from Linux kernel commit ae6476c6de187 to calculate the BAR offsets and
factor out the setup code into a separate function.

The Linux kernel first allocates and populates an array of inbound_win[]
and sets the BARs from it later, while U-Boot does it all on the fly,
in one go, so the code is not 1:1 comparable.

Signed-off-by: Torsten Duwe <duwe@suse.de>
---
 drivers/pci/pcie_brcmstb.c | 107 ++++++++++++++++++++++++++++++-------
 1 file changed, 88 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/pcie_brcmstb.c b/drivers/pci/pcie_brcmstb.c
index 8a25fb04563..e5c848c9e8e 100644
--- a/drivers/pci/pcie_brcmstb.c
+++ b/drivers/pci/pcie_brcmstb.c
@@ -50,6 +50,29 @@
 #define SSC_STATUS_PLL_LOCK_MASK			0x800
 #define SSC_STATUS_PLL_LOCK_SHIFT			11
 
+#define PCIE_RC_PL_PHY_CTL_15				0x184c
+#define PCIE_RC_PL_PHY_CTL_15_DIS_PLL_PD_MASK		0x400000
+#define PCIE_RC_PL_PHY_CTL_15_PM_CLK_PERIOD_MASK	0xff
+
+#define PCIE_MISC_UBUS_CTRL				0x40a4
+#define  PCIE_MISC_UBUS_CTRL_UBUS_PCIE_REPLY_ERR_DIS_MASK	BIT(13)
+#define  PCIE_MISC_UBUS_CTRL_UBUS_PCIE_REPLY_DECERR_DIS_MASK	BIT(19)
+#define PCIE_MISC_AXI_READ_ERROR_DATA			0x4170
+#define PCIE_MISC_UBUS_TIMEOUT				0x40A8
+#define PCIE_MISC_RC_CONFIG_RETRY_TIMEOUT		0x405c
+#define PCIE_MISC_RC_BAR4_CONFIG_LO			0x40d4
+#define PCIE_MISC_RC_BAR4_CONFIG_HI			0x40d8
+#define PCIE_MISC_UBUS_BAR_CONFIG_REMAP_HI_MASK		0xff
+#define PCIE_MISC_UBUS_BAR4_CONFIG_REMAP_HI		0x4110
+#define PCIE_MISC_UBUS_BAR_CONFIG_REMAP_ENABLE		0x1
+#define PCIE_MISC_UBUS_BAR_CONFIG_REMAP_LO_MASK		0xfffff000
+#define PCIE_MISC_UBUS_BAR4_CONFIG_REMAP_LO		0x410c
+
+#define PCIE_MISC_UBUS_BAR1_CONFIG_REMAP		0x40ac
+#define PCIE_MISC_UBUS_BAR2_CONFIG_REMAP		0x40b4
+#define  PCIE_MISC_UBUS_BAR2_CONFIG_REMAP_ACCESS_ENABLE_MASK	BIT(0)
+#define  MISC_CTRL_PCIE_RCB_MPS_MODE_MASK		0x400
+
 enum {
 	RGR1_SW_INIT_1,
 	EXT_CFG_INDEX,
@@ -437,17 +460,75 @@ static void brcm_pcie_set_outbound_win(struct brcm_pcie *pcie,
 	writel(tmp, base + PCIE_MEM_WIN0_LIMIT_HI(win));
 }
 
+static u32 brcm_bar_reg_offset(int bar)
+{
+	if (bar <= 3)
+		return PCIE_MISC_RC_BAR1_CONFIG_LO + 8 * (bar - 1);
+	else
+		return PCIE_MISC_RC_BAR4_CONFIG_LO + 8 * (bar - 4);
+}
+
+static u32 brcm_ubus_reg_offset(int bar)
+{
+	if (bar <= 3)
+		return PCIE_MISC_UBUS_BAR1_CONFIG_REMAP + 8 * (bar - 1);
+	else
+		return PCIE_MISC_UBUS_BAR4_CONFIG_REMAP_LO + 8 * (bar - 4);
+}
+
+static void brcm_pcie_set_inbound_windows(struct udevice *dev)
+{
+	struct brcm_pcie *pcie = dev_get_priv(dev);
+	void __iomem *base = pcie->base;
+	int i, ibar_no, ret;
+	u32 tmp;
+
+	ibar_no = 0;
+	/* pre-2712 chips leave the first entry empty */
+	if (pcie->pcie_cfg->type != BCM2712)
+		ibar_no++;
+
+	/* program inbound windows from OF property "dma-regions" */
+	for (i = 0; i < 7; i++, ibar_no++) {
+		u64 bar_cpu, bar_size, bar_pci;
+		struct pci_region region;
+		int ubus_bar_offset, rc_bar_offset;
+
+		ret = pci_get_dma_regions(dev, &region, i);
+		if (ret)	/* no region #i? Then we're done. */
+			break;
+		ubus_bar_offset = brcm_ubus_reg_offset(ibar_no + 1);
+		rc_bar_offset = brcm_bar_reg_offset(ibar_no + 1);
+
+		bar_pci = region.bus_start;
+		bar_cpu = region.phys_start;
+		bar_size = region.size;
+
+		tmp = lower_32_bits(bar_pci);
+		u32p_replace_bits(&tmp, brcm_pcie_encode_ibar_size(bar_size),
+				  RC_BAR2_CONFIG_LO_SIZE_MASK);
+		writel(tmp, base + rc_bar_offset);
+		writel(upper_32_bits(bar_pci), base + rc_bar_offset + 4);
+
+		tmp = lower_32_bits(bar_cpu) &
+				PCIE_MISC_UBUS_BAR_CONFIG_REMAP_LO_MASK;
+		tmp |= PCIE_MISC_UBUS_BAR_CONFIG_REMAP_ENABLE;
+		writel(tmp, base + ubus_bar_offset);
+
+		tmp = upper_32_bits(bar_cpu) &
+			PCIE_MISC_UBUS_BAR_CONFIG_REMAP_HI_MASK;
+		writel(tmp, base + ubus_bar_offset + 4);
+	}
+}
+
 static int brcm_pcie_probe(struct udevice *dev)
 {
 	struct udevice *ctlr = pci_get_controller(dev);
 	struct pci_controller *hose = dev_get_uclass_priv(ctlr);
 	struct brcm_pcie *pcie = dev_get_priv(dev);
 	void __iomem *base = pcie->base;
-	struct pci_region region;
 	bool ssc_good = false;
 	int num_out_wins = 0;
-	u64 rc_bar2_offset, rc_bar2_size;
-	unsigned int scb_size_val;
 	int i, ret;
 	u16 nlw, cls, lnksta;
 	u32 tmp;
@@ -488,23 +569,9 @@ static int brcm_pcie_probe(struct udevice *dev)
 			MISC_CTRL_CFG_READ_UR_MODE_MASK |
 			MISC_CTRL_MAX_BURST_SIZE_128);
 
-	pci_get_dma_regions(dev, &region, 0);
-	rc_bar2_offset = region.bus_start - region.phys_start;
-	rc_bar2_size = 1ULL << fls64(region.size - 1);
-
-	tmp = lower_32_bits(rc_bar2_offset);
-	u32p_replace_bits(&tmp, brcm_pcie_encode_ibar_size(rc_bar2_size),
-			  RC_BAR2_CONFIG_LO_SIZE_MASK);
-	writel(tmp, base + PCIE_MISC_RC_BAR2_CONFIG_LO);
-	writel(upper_32_bits(rc_bar2_offset),
-	       base + PCIE_MISC_RC_BAR2_CONFIG_HI);
-
-	scb_size_val = rc_bar2_size ?
-		       ilog2(rc_bar2_size) - 15 : 0xf; /* 0xf is 1GB */
-
+	/* Enable 32GB memory to be accessed from PCIe in the SCB0 */
 	tmp = readl(base + PCIE_MISC_MISC_CTRL);
-	u32p_replace_bits(&tmp, scb_size_val,
-			  MISC_CTRL_SCB0_SIZE_MASK);
+	u32p_replace_bits(&tmp, 20, MISC_CTRL_SCB0_SIZE_MASK);
 	writel(tmp, base + PCIE_MISC_MISC_CTRL);
 
 	/* Disable the PCIe->GISB memory window (RC_BAR1) */
@@ -521,6 +588,8 @@ static int brcm_pcie_probe(struct udevice *dev)
 	/* Clear any interrupts we find on boot */
 	writel(0xffffffff, base + PCIE_MSI_INTR2_CLR);
 
+	brcm_pcie_set_inbound_windows(dev);
+
 	if (pcie->gen)
 		brcm_pcie_set_gen(pcie, pcie->gen);
 
-- 
2.51.0

