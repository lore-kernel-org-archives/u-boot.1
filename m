Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18A93CD5BAC
	for <u-boot@archiver.kernel.org>; Sat, 23 May 2026 16:35:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 100FA84922;
	Sat, 23 May 2026 18:34:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B5048493E; Sat, 23 May 2026 18:34:39 +0200 (CEST)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D28084927
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 18:34:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=duwe@lst.de
Received: by verein.lst.de (Postfix, from userid 2005)
 id E58D768D12; Sat, 23 May 2026 18:34:35 +0200 (CEST)
In-Reply-To: <20260523163239.8EEA768BEB@verein.lst.de>
References: <20260523163239.8EEA768BEB@verein.lst.de>
Subject: [PATCH v4 6/9] pci: brcmstb: Get and use bridge and rescal reset
 properties
To: Peter Robinson <pbrobinson@gmail.com>, Matthias Brugger <mbrugger@suse.com>
Cc: Tom Rini <trini@konsulko.com>,"Jan Čermák" <sairon@sairon.cz>,Andrea della Porta <andrea.porta@suse.com>,"Ivan T. Ivanov" <iivanov@suse.de>, Stanimir Varbanov <stanimir.varbanov@suse.com>, Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>, Volodymyr Babchuk <volodymyr_babchuk@epam.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,Paul Barker <paul.barker.ct@bp.renesas.com>,Patrice Chotard <patrice.chotard@foss.st.com>,Christian Marangi <ansuelsmth@gmail.com>,Patrick Delaunay <patrick.delaunay@foss.st.com>,Huan Zhou <me@per1cycle.org>,Gabriel Fernandez <gabriel.fernandez@foss.st.com>,Kever Yang <kever.yang@rock-chips.com>,Jonas Karlman <jonas@kwiboo.se>,Joseph Chen <chenjh@rock-chips.com>,Elaine Zhang <zhangqing@rock-chips.com>, Pedro Falcato <pfalcato@suse.de>,u-boot@lists.denx.de
Message-Id: <20260523163435.E58D768D12@verein.lst.de>
Date: Sat, 23 May 2026 18:34:35 +0200 (CEST)
From: duwe@lst.de (Torsten Duwe)
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

Check whether the device tree has nodes for the two reset controls and use
them if so.

Signed-off-by: Torsten Duwe <duwe@suse.de>
Co-authored-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Tested-by: Pedro Falcato <pfalcato@suse.de>
---
 drivers/pci/pcie_brcmstb.c | 70 +++++++++++++++++++++++++++++++++++---
 1 file changed, 65 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pcie_brcmstb.c b/drivers/pci/pcie_brcmstb.c
index 5cb39dfd136..4d253440de9 100644
--- a/drivers/pci/pcie_brcmstb.c
+++ b/drivers/pci/pcie_brcmstb.c
@@ -21,6 +21,7 @@
 #include <linux/bitfield.h>
 #include <linux/log2.h>
 #include <linux/iopoll.h>
+#include <reset.h>
 
 /* PCIe parameters */
 #define BRCM_NUM_PCIE_OUT_WINS				4
@@ -79,6 +80,8 @@ struct brcm_pcie {
 
 	int			gen;
 	bool			ssc;
+	struct reset_ctl	rescal;
+	struct reset_ctl	bridge_reset;
 	const struct brcm_pcie_cfg_data *pcie_cfg;
 };
 
@@ -143,14 +146,57 @@ static void brcm_pcie_perst_set_2712(struct brcm_pcie *pcie, u32 val)
 	writel(tmp, pcie->base + PCIE_MISC_PCIE_CTRL);
 }
 
-static void brcm_pcie_bridge_sw_init_set(struct brcm_pcie *pcie, u32 val)
+static int brcm_pcie_get_resets_dt(struct udevice *dev)
 {
+	struct brcm_pcie *pcie = dev_get_priv(dev);
+	int ret;
+
+	ret = reset_get_by_name(dev, "rescal", &pcie->rescal);
+	if (ret) {
+		printf("Unable to get rescal reset\n");
+		return ret;
+	}
+
+	ret = reset_get_by_name(dev, "bridge", &pcie->bridge_reset);
+	if (ret) {
+		printf("Unable to get bridge reset\n");
+	}
+	return ret;
+}
+
+static int brcm_pcie_do_reset(struct udevice *dev)
+{
+	struct brcm_pcie *pcie = dev_get_priv(dev);
+	int ret;
+
+	ret = reset_deassert(&pcie->rescal);
+	if (ret)
+		printf("failed to deassert 'rescal'\n");
+	return ret;
+}
+
+static int brcm_pcie_bridge_sw_init_set(struct brcm_pcie *pcie, u32 val)
+{
+	int ret = 0;
+
+	if (pcie->bridge_reset.dev)
+	{
+		if (val)
+			ret = reset_assert(&pcie->bridge_reset);
+		else
+			ret = reset_deassert(&pcie->bridge_reset);
+		if (ret)
+			log_err("failed to %sassert bridge reset, err=%d\n",
+				val ? "" : "de", ret);
+		return ret;
+	}
 	if (val)
 		setbits_le32(pcie->base + pcie->pcie_cfg->offsets[RGR1_SW_INIT_1],
 			     RGR1_SW_INIT_1_INIT_MASK);
 	else
 		clrbits_le32(pcie->base + pcie->pcie_cfg->offsets[RGR1_SW_INIT_1],
 			     RGR1_SW_INIT_1_INIT_MASK);
+	return ret;
 }
 
 /**
@@ -405,16 +451,25 @@ static int brcm_pcie_probe(struct udevice *dev)
 	int num_out_wins = 0;
 	u64 rc_bar2_offset, rc_bar2_size;
 	unsigned int scb_size_val;
-	int i, ret;
+	int i, ret = 0;
 	u16 nlw, cls, lnksta;
 	u32 tmp;
 
+	/*
+	 * Ensure rescal reset for BCM2712 is really disabled.
+	 */
+	if (pcie->pcie_cfg->type == BCM2712)
+		ret = brcm_pcie_do_reset(dev);
+	if (ret)
+		return ret;
 	/*
 	 * Reset the bridge, assert the fundamental reset. Note for some SoCs,
 	 * e.g. BCM7278, the fundamental reset should not be asserted here.
 	 * This will need to be changed when support for other SoCs is added.
 	 */
-	brcm_pcie_bridge_sw_init_set(pcie, 1);
+	ret = brcm_pcie_bridge_sw_init_set(pcie, 1);
+	if (ret)
+		return ret;
 	if (pcie->pcie_cfg->type != BCM2712)
 		pcie->pcie_cfg->perst_set(pcie, 1);
 	/*
@@ -424,8 +479,9 @@ static int brcm_pcie_probe(struct udevice *dev)
 	udelay(100);
 
 	/* Take the bridge out of reset */
-	brcm_pcie_bridge_sw_init_set(pcie, 0);
-
+	ret = brcm_pcie_bridge_sw_init_set(pcie, 0);
+	if (ret)
+		return ret;
 	clrbits_le32(base + pcie->pcie_cfg->offsets[PCIE_HARD_DEBUG],
 		     PCIE_HARD_DEBUG_SERDES_IDDQ_MASK);
 
@@ -607,6 +663,10 @@ static int brcm_pcie_of_to_plat(struct udevice *dev)
 		pcie->gen = max_link_speed;
 
 	pcie->pcie_cfg = (const struct brcm_pcie_cfg_data *)dev_get_driver_data(dev);
+
+	if (pcie->pcie_cfg->type == BCM2712)
+		return brcm_pcie_get_resets_dt(dev);
+
 	return 0;
 }
 
-- 
2.54.0

