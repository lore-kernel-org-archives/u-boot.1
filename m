Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD2F3FF8868
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 16:44:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E33338468B;
	Tue, 28 Apr 2026 18:43:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2414F845D8; Tue, 28 Apr 2026 18:39:40 +0200 (CEST)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F86E845E3
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 18:39:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=duwe@lst.de
Received: by verein.lst.de (Postfix, from userid 2005)
 id 7987968D09; Tue, 28 Apr 2026 18:39:36 +0200 (CEST)
Subject: [PATCH v2 6/9] pci: brcmstb: Get and use bridge and rescal reset
 properties
To: Peter Robinson <pbrobinson@gmail.com>, Matthias Brugger <mbrugger@suse.com>
Cc: Tom Rini <trini@konsulko.com>,"Jan Čermák" <sairon@sairon.cz>,Andrea della Porta <andrea.porta@suse.com>,"Ivan T. Ivanov" <iivanov@suse.de>, Stanimir Varbanov <stanimir.varbanov@suse.com>, Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>, Volodymyr Babchuk <volodymyr_babchuk@epam.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,Paul Barker <paul.barker.ct@bp.renesas.com>,Patrice Chotard <patrice.chotard@foss.st.com>,Christian Marangi <ansuelsmth@gmail.com>,Patrick Delaunay <patrick.delaunay@foss.st.com>,Huan Zhou <me@per1cycle.org>,Gabriel Fernandez <gabriel.fernandez@foss.st.com>,Kever Yang <kever.yang@rock-chips.com>,Jonas Karlman <jonas@kwiboo.se>,Joseph Chen <chenjh@rock-chips.com>,Elaine Zhang <zhangqing@rock-chips.com>, Pedro Falcato <pfalcato@suse.de>,u-boot@lists.denx.de
In-Reply-To: <20260428162319.99B4268B05@verein.lst.de>
Message-Id: <20260428163936.7987968D09@verein.lst.de>
Date: Tue, 28 Apr 2026 18:39:36 +0200 (CEST)
From: duwe@lst.de (Torsten Duwe)
X-Mailman-Approved-At: Tue, 28 Apr 2026 18:43:21 +0200
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
 drivers/pci/pcie_brcmstb.c | 51 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie_brcmstb.c b/drivers/pci/pcie_brcmstb.c
index 261f8790528..1f97cda5cc7 100644
--- a/drivers/pci/pcie_brcmstb.c
+++ b/drivers/pci/pcie_brcmstb.c
@@ -21,6 +21,7 @@
 #include <linux/bitfield.h>
 #include <linux/log2.h>
 #include <linux/iopoll.h>
+#include <reset.h>
 
 /* PCIe parameters */
 #define BRCM_NUM_PCIE_OUT_WINS				4
@@ -83,6 +84,8 @@ struct brcm_pcie {
 
 	int			gen;
 	bool			ssc;
+	struct reset_ctl	rescal;
+	struct reset_ctl	bridge_reset;
 	const struct brcm_pcie_cfg_data *pcie_cfg;
 };
 
@@ -147,6 +150,34 @@ static void brcm_pcie_perst_set_2712(struct brcm_pcie *pcie, u32 val)
 	writel(tmp, pcie->base + PCIE_MISC_PCIE_CTRL);
 }
 
+static void brcm_pcie_get_resets_dt(struct udevice *dev)
+{
+	struct brcm_pcie *pcie = dev_get_priv(dev);
+	int ret;
+
+	ret = reset_get_by_name(dev, "rescal", &pcie->rescal);
+	if (ret) {
+		printf("Unable to get rescal reset\n");
+		return;
+	}
+
+	ret = reset_get_by_name(dev, "bridge", &pcie->bridge_reset);
+	if (ret) {
+		printf("Unable to get bridge reset\n");
+		return;
+	}
+}
+
+static void brcm_pcie_do_reset(struct udevice *dev)
+{
+	struct brcm_pcie *pcie = dev_get_priv(dev);
+	int ret;
+
+	ret = reset_deassert(&pcie->rescal);
+	if (ret)
+		printf("failed to deassert 'rescal'\n");
+}
+
 static void brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie, u32 val)
 {
 	if (val)
@@ -157,6 +188,14 @@ static void brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie, u32 val
 			     RGR1_SW_INIT_1_INIT_MASK);
 }
 
+static void brcm_pcie_bridge_sw_init_set_2712(struct brcm_pcie *pcie, u32 val)
+{
+	if (val)
+		reset_assert(&pcie->bridge_reset);
+	else
+		reset_deassert(&pcie->bridge_reset);
+}
+
 /**
  * brcm_pcie_link_up() - Check whether the PCIe link is up
  * @pcie: Pointer to the PCIe controller state
@@ -413,6 +452,12 @@ static int brcm_pcie_probe(struct udevice *dev)
 	u16 nlw, cls, lnksta;
 	u32 tmp;
 
+	/*
+	 * Ensure rescal reset for BCM2712 is really disabled.
+	 */
+	if (pcie->pcie_cfg->type == BCM2712)
+		brcm_pcie_do_reset(dev);
+
 	/*
 	 * Reset the bridge, assert the fundamental reset. Note for some SoCs,
 	 * e.g. BCM7278, the fundamental reset should not be asserted here.
@@ -611,6 +656,10 @@ static int brcm_pcie_of_to_plat(struct udevice *dev)
 		pcie->gen = max_link_speed;
 
 	pcie->pcie_cfg = (const struct brcm_pcie_cfg_data *)dev_get_driver_data(dev);
+
+	if (pcie->pcie_cfg->type == BCM2712)
+		brcm_pcie_get_resets_dt(dev);
+
 	return 0;
 }
 
@@ -645,7 +694,7 @@ static const struct brcm_pcie_cfg_data bcm2712_cfg = {
 	.offsets	= pcie_offsets_bcm2712,
 	.type		= BCM2712,
 	.perst_set	= brcm_pcie_perst_set_2712,
-	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
+	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_2712,
 	.rc_mode	= brcm_pcie_rc_mode,
 };
 
-- 
2.54.0

