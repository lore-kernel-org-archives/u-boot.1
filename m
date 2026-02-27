Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CD17FEFB56
	for <u-boot@archiver.kernel.org>; Fri, 27 Feb 2026 15:24:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D46783EDF;
	Fri, 27 Feb 2026 16:23:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5671E83F63; Fri, 27 Feb 2026 16:23:56 +0100 (CET)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 300CA83F56
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 16:23:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=duwe@lst.de
Received: by verein.lst.de (Postfix, from userid 2005)
 id F152968D16; Fri, 27 Feb 2026 16:23:52 +0100 (CET)
In-Reply-To: <20260227152046.42DE068B05@verein.lst.de>
References: <20260227152046.42DE068B05@verein.lst.de>
From: Torsten Duwe <duwe@lst.de>
Subject: [PATCH 9/9] pci: brcmstb: Adapt to AXI bridge
To: Peter Robinson <pbrobinson@gmail.com>, Matthias Brugger <mbrugger@suse.com>
Cc: Tom Rini <trini@konsulko.com>,"Jan Čermák" <sairon@sairon.cz>,Andrea della Porta <andrea.porta@suse.com>,"Ivan T. Ivanov" <iivanov@suse.de>, Stanimir Varbanov <stanimir.varbanov@suse.com>, Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>, Volodymyr Babchuk <volodymyr_babchuk@epam.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,Paul Barker <paul.barker.ct@bp.renesas.com>,Patrice Chotard <patrice.chotard@foss.st.com>,Christian Marangi <ansuelsmth@gmail.com>,Patrick Delaunay <patrick.delaunay@foss.st.com>,Huan Zhou <me@per1cycle.org>,Gabriel Fernandez <gabriel.fernandez@foss.st.com>,Kever Yang <kever.yang@rock-chips.com>,Jonas Karlman <jonas@kwiboo.se>,Joseph Chen <chenjh@rock-chips.com>,Elaine Zhang <zhangqing@rock-chips.com>, u-boot@lists.denx.de
Message-Id: <20260227152352.F152968D16@verein.lst.de>
Date: Fri, 27 Feb 2026 16:23:52 +0100 (CET)
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

Fix-ups for the BCM root complex when it is located behind an AXI
bridge and clocked with 54MHz.  Some are from kernel commit
377bced88c326, some where picked by Oleksii off a now-stale older
branch. All reworked for the simpler setup code in U-Boot.

Signed-off-by: Torsten Duwe <duwe@suse.de>
---
 .../mach-bcm283x/include/mach/acpi/bcm2711.h  |  1 +
 drivers/pci/pcie_brcmstb.c                    | 64 ++++++++++++++++++-
 2 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-bcm283x/include/mach/acpi/bcm2711.h b/arch/arm/mach-bcm283x/include/mach/acpi/bcm2711.h
index 6eb5389b858..869482eaffe 100644
--- a/arch/arm/mach-bcm283x/include/mach/acpi/bcm2711.h
+++ b/arch/arm/mach-bcm283x/include/mach/acpi/bcm2711.h
@@ -54,6 +54,7 @@
 #define  MISC_CTRL_CFG_READ_UR_MODE_MASK          0x2000
 #define  MISC_CTRL_MAX_BURST_SIZE_MASK            0x300000
 #define  MISC_CTRL_MAX_BURST_SIZE_128             0x0
+#define  MISC_CTRL_MAX_BURST_SIZE_128_2712		0x100000
 #define  MISC_CTRL_SCB0_SIZE_MASK                 0xf8000000
 
 #define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LO          0x400c
diff --git a/drivers/pci/pcie_brcmstb.c b/drivers/pci/pcie_brcmstb.c
index e5c848c9e8e..bd1dd17e690 100644
--- a/drivers/pci/pcie_brcmstb.c
+++ b/drivers/pci/pcie_brcmstb.c
@@ -521,6 +521,30 @@ static void brcm_pcie_set_inbound_windows(struct udevice *dev)
 	}
 }
 
+static void brcm_pcie_munge_pll(struct brcm_pcie *pcie)
+{
+	u32 tmp;
+	int ret, i;
+	u8 regs[] =  { 0x16,   0x17,   0x18,   0x19,   0x1b,   0x1c,   0x1e };
+	u16 data[] = { 0x50b9, 0xbda1, 0x0094, 0x97b4, 0x5030, 0x5030, 0x0007 };
+
+	ret = brcm_pcie_mdio_write(pcie->base, MDIO_PORT0, SET_ADDR_OFFSET,
+				   0x1600);
+	for (i = 0; i < ARRAY_SIZE(regs); i++) {
+		brcm_pcie_mdio_read(pcie->base, MDIO_PORT0, regs[i], &tmp);
+		debug("PCIE MDIO pre_refclk 0x%02x = 0x%04x\n",
+		      regs[i], tmp);
+	}
+	for (i = 0; i < ARRAY_SIZE(regs); i++) {
+		brcm_pcie_mdio_write(pcie->base, MDIO_PORT0, regs[i], data[i]);
+		brcm_pcie_mdio_read(pcie->base, MDIO_PORT0, regs[i], &tmp);
+		debug("PCIE MDIO post_refclk 0x%02x = 0x%04x\n",
+		      regs[i], tmp);
+	}
+
+	udelay(200);
+}
+
 static int brcm_pcie_probe(struct udevice *dev)
 {
 	struct udevice *ctlr = pci_get_controller(dev);
@@ -562,18 +586,56 @@ static int brcm_pcie_probe(struct udevice *dev)
 	/* Wait for SerDes to be stable */
 	udelay(100);
 
+	if (pcie->pcie_cfg->type == BCM2712) {
+		/* Allow a 54MHz (xosc) refclk source */
+		brcm_pcie_munge_pll(pcie);
+		/* Fix for L1SS errata */
+		tmp = readl(base + PCIE_RC_PL_PHY_CTL_15);
+		tmp &= ~PCIE_RC_PL_PHY_CTL_15_PM_CLK_PERIOD_MASK;
+		/* PM clock period is 18.52ns (round down) */
+		tmp |= 0x12;
+		writel(tmp, base + PCIE_RC_PL_PHY_CTL_15);
+	}
+
+	tmp = (pcie->pcie_cfg->type == BCM2712) ?
+			MISC_CTRL_MAX_BURST_SIZE_128_2712 :
+			MISC_CTRL_MAX_BURST_SIZE_128;
 	/* Set SCB_MAX_BURST_SIZE, CFG_READ_UR_MODE, SCB_ACCESS_EN */
 	clrsetbits_le32(base + PCIE_MISC_MISC_CTRL,
 			MISC_CTRL_MAX_BURST_SIZE_MASK,
 			MISC_CTRL_SCB_ACCESS_EN_MASK |
 			MISC_CTRL_CFG_READ_UR_MODE_MASK |
-			MISC_CTRL_MAX_BURST_SIZE_128);
+			MISC_CTRL_PCIE_RCB_MPS_MODE_MASK |
+			tmp);
 
 	/* Enable 32GB memory to be accessed from PCIe in the SCB0 */
 	tmp = readl(base + PCIE_MISC_MISC_CTRL);
 	u32p_replace_bits(&tmp, 20, MISC_CTRL_SCB0_SIZE_MASK);
 	writel(tmp, base + PCIE_MISC_MISC_CTRL);
 
+	if (pcie->pcie_cfg->type == BCM2712) {
+		/* Suppress AXI error responses and return 1s for read failures */
+		tmp = readl(base + PCIE_MISC_UBUS_CTRL);
+		u32p_replace_bits(&tmp, 1, PCIE_MISC_UBUS_CTRL_UBUS_PCIE_REPLY_ERR_DIS_MASK);
+		u32p_replace_bits(&tmp, 1, PCIE_MISC_UBUS_CTRL_UBUS_PCIE_REPLY_DECERR_DIS_MASK);
+		writel(tmp, base + PCIE_MISC_UBUS_CTRL);
+		writel(0xffffffff, base + PCIE_MISC_AXI_READ_ERROR_DATA);
+
+		/*
+		 * Adjust timeouts. The UBUS timeout also affects CRS
+		 * completion retries, as the request will get terminated if
+		 * either timeout expires, so both have to be a large value
+		 * (in clocks of 750MHz).
+		 * Set UBUS timeout to 250ms, then set RC config retry timeout
+		 * to be ~240ms.
+		 *
+		 * Setting CRSVis=1 will stop the core from blocking on a CRS
+		 * response, but does require the device to be well-behaved...
+		 */
+		writel(0xB2D0000, base + PCIE_MISC_UBUS_TIMEOUT);
+		writel(0xABA0000, base + PCIE_MISC_RC_CONFIG_RETRY_TIMEOUT);
+	}
+
 	/* Disable the PCIe->GISB memory window (RC_BAR1) */
 	clrbits_le32(base + PCIE_MISC_RC_BAR1_CONFIG_LO,
 		     RC_BAR1_CONFIG_LO_SIZE_MASK);
-- 
2.51.0

