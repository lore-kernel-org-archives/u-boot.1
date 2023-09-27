Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A03E810DA
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 13:34:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 720C286E0E;
	Wed, 27 Sep 2023 15:34:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=tq-group.com header.i=@tq-group.com header.b="BtXFGrae";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBF7786D62; Wed, 27 Sep 2023 15:34:12 +0200 (CEST)
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 443A586DDE
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 15:34:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=matthias.schiffer@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
 t=1695821650; x=1727357650;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=OSld8Nz5scuQlixrbEcOP8NRspI4Mdc2R2R0e6eXo50=;
 b=BtXFGrae1LaKVK8bjf0rZEhfx9pyHObqz3GmOaCG97VxeH9kZA49oBH4
 k4EwL5La4I6UnnjCR6r6zy2AsdF5EUytSa6GPduG2Xg0VK6OBAlVl8iH1
 kHDbtd/G7oVZxv/Q0BBXkqugY1OXSIGCE7M88NV8a58Al64rtClJlpfG5
 j0wR9ewti8ypdpmS6RPcT4bkaRDXmdnl9po/i3IPi3R4dwiC5GBIQIO7E
 xbn5H5DDVulFMq/u2LjjdOFEMcdsitq7V8OFqlyLwhmY8GVwqeK5gUJFJ
 Exza5+1m0FE3qks9l4EwcUzeTJI9PiATdTj4Fjc6VUG982LUoTxzNfeyA w==;
X-IronPort-AV: E=Sophos;i="6.03,181,1694728800"; d="scan'208";a="33178732"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
 by mx1.tq-group.com with ESMTP; 27 Sep 2023 15:34:04 +0200
Received: from localhost.localdomain (SCHIFFERM-M2.tq-net.de [10.121.49.20])
 by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 8F9B3280075;
 Wed, 27 Sep 2023 15:34:04 +0200 (CEST)
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Simon Glass <sjg@chromium.org>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, u-boot@lists.denx.de, u-boot@ew.tq-group.com,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 5/5] treewide: use dev_read_addr_*_ptr() where appropriate
Date: Wed, 27 Sep 2023 15:33:34 +0200
Message-Id: <d4022e103b84d1d67615a728060afe6fb28bf747.1695817360.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <78309a6288060d9883de9f1406a2d81c4ca3904f.1695817360.git.matthias.schiffer@ew.tq-group.com>
References: <78309a6288060d9883de9f1406a2d81c4ca3904f.1695817360.git.matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

A follow-up to commit 842fb5de424e
("drivers: use devfdt_get_addr_size_index_ptr when cast to pointer")
and commit 320a1938b6f7
("drivers: use devfdt_get_addr_index_ptr when cast to pointer").

In addition to using the *_ptr variants of these functions where the
address is cast to a pointer, this also changes devfdt_get_addr_*() to
dev_read_addr_*() in a few places. Some variable and field types are
changed from fdt_addr_t or phys_addr_t to void* where the cast was
happening later.

This patch fixes a number of compile warnings when building a 32bit
U-Boot with CONFIG_PHYS_64BIT=y. In some places, it also fixes error
handling where the return value of dev_read_addr() etc. was checked for
NULL instead of FDT_ADDR_T_NONE.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---

This seems to work correctly (tested on x86 sandbox and TI AM62x; I have
not tested the Tegra, Sun4i and BCM drivers), but I have two questions:

It is not entirely clear to me what the difference between
dev_read_addr_ptr*() and dev_remap_addr*() etc. is, but some drivers mix
both. Should dev_remap_addr*() be used for __iomem? Is __iomem used
consistently in U-Boot at all?

Furthermore, can devfdt_get_*() be replaced with dev_read_*()
unconditionally? Is there any reason why devfdt_get_*() hasn't been
dropped entirely in a treewide search-and-replace?

The k3-sec-proxy change goes on top of my other patch "mailbox:
k3-sec-proxy: fix error handling for missing scfg in FDT" I submitted
yesterday.


 arch/arm/mach-k3/sysfw-loader.c       | 16 ++++++++--------
 drivers/dma/ti/k3-udma.c              |  5 ++---
 drivers/gpio/tegra186_gpio.c          |  4 ++--
 drivers/mailbox/k3-sec-proxy.c        | 18 +++++++++---------
 drivers/phy/allwinner/phy-sun4i-usb.c | 12 ++++++------
 drivers/phy/phy-bcm-sr-pcie.c         |  4 ++--
 drivers/ram/k3-am654-ddrss.c          | 20 ++++++++++----------
 drivers/ram/k3-ddrss/k3-ddrss.c       | 23 ++++++++++-------------
 drivers/soc/ti/k3-navss-ringacc.c     | 12 ++++++------
 9 files changed, 55 insertions(+), 59 deletions(-)

diff --git a/arch/arm/mach-k3/sysfw-loader.c b/arch/arm/mach-k3/sysfw-loader.c
index 9be2d9eaea2..ef245fef9c4 100644
--- a/arch/arm/mach-k3/sysfw-loader.c
+++ b/arch/arm/mach-k3/sysfw-loader.c
@@ -321,7 +321,7 @@ exit:
 static void *k3_sysfw_get_spi_addr(void)
 {
 	struct udevice *dev;
-	fdt_addr_t addr;
+	void *addr;
 	int ret;
 	unsigned int sf_bus = spl_spi_boot_bus();
 
@@ -329,11 +329,11 @@ static void *k3_sysfw_get_spi_addr(void)
 	if (ret)
 		return NULL;
 
-	addr = dev_read_addr_index(dev, 1);
-	if (addr == FDT_ADDR_T_NONE)
+	addr = dev_read_addr_index_ptr(dev, 1);
+	if (!addr)
 		return NULL;
 
-	return (void *)(addr + CONFIG_K3_SYSFW_IMAGE_SPI_OFFS);
+	return addr + CONFIG_K3_SYSFW_IMAGE_SPI_OFFS;
 }
 
 static void k3_sysfw_spi_copy(u32 *dst, u32 *src, size_t len)
@@ -349,18 +349,18 @@ static void k3_sysfw_spi_copy(u32 *dst, u32 *src, size_t len)
 static void *get_sysfw_hf_addr(void)
 {
 	struct udevice *dev;
-	fdt_addr_t addr;
+	void *addr;
 	int ret;
 
 	ret = uclass_find_first_device(UCLASS_MTD, &dev);
 	if (ret)
 		return NULL;
 
-	addr = dev_read_addr_index(dev, 1);
-	if (addr == FDT_ADDR_T_NONE)
+	addr = dev_read_addr_index_ptr(dev, 1);
+	if (!addr)
 		return NULL;
 
-	return (void *)(addr + CONFIG_K3_SYSFW_IMAGE_SPI_OFFS);
+	return addr + CONFIG_K3_SYSFW_IMAGE_SPI_OFFS;
 }
 #endif
 
diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 05c3a4311ce..1847c8889aa 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -1286,7 +1286,7 @@ static int udma_get_mmrs(struct udevice *dev)
 	u32 cap2, cap3, cap4;
 	int i;
 
-	ud->mmrs[MMR_GCFG] = (uint32_t *)devfdt_get_addr_name(dev, mmr_names[MMR_GCFG]);
+	ud->mmrs[MMR_GCFG] = dev_read_addr_name_ptr(dev, mmr_names[MMR_GCFG]);
 	if (!ud->mmrs[MMR_GCFG])
 		return -EINVAL;
 
@@ -1324,8 +1324,7 @@ static int udma_get_mmrs(struct udevice *dev)
 		if (i == MMR_RCHANRT && ud->rchan_cnt == 0)
 			continue;
 
-		ud->mmrs[i] = (uint32_t *)devfdt_get_addr_name(dev,
-				mmr_names[i]);
+		ud->mmrs[i] = dev_read_addr_name_ptr(dev, mmr_names[i]);
 		if (!ud->mmrs[i])
 			return -EINVAL;
 	}
diff --git a/drivers/gpio/tegra186_gpio.c b/drivers/gpio/tegra186_gpio.c
index 82dcaf96312..94a20d143e1 100644
--- a/drivers/gpio/tegra186_gpio.c
+++ b/drivers/gpio/tegra186_gpio.c
@@ -176,8 +176,8 @@ static int tegra186_gpio_bind(struct udevice *parent)
 	if (parent_plat)
 		return 0;
 
-	regs = (uint32_t *)devfdt_get_addr_name(parent, "gpio");
-	if (regs == (uint32_t *)FDT_ADDR_T_NONE)
+	regs = dev_read_addr_name_ptr(parent, "gpio");
+	if (!regs)
 		return -EINVAL;
 
 	for (port = 0; port < ctlr_data->port_count; port++) {
diff --git a/drivers/mailbox/k3-sec-proxy.c b/drivers/mailbox/k3-sec-proxy.c
index 27072610462..e0a18d8a97d 100644
--- a/drivers/mailbox/k3-sec-proxy.c
+++ b/drivers/mailbox/k3-sec-proxy.c
@@ -84,9 +84,9 @@ struct k3_sec_proxy_mbox {
 	struct mbox_chan chan;
 	struct k3_sec_proxy_desc *desc;
 	struct k3_sec_proxy_thread *chans;
-	phys_addr_t target_data;
-	phys_addr_t scfg;
-	phys_addr_t rt;
+	void *target_data;
+	void *scfg;
+	void *rt;
 };
 
 static inline u32 sp_readl(void __iomem *addr, unsigned int offset)
@@ -319,20 +319,20 @@ static int k3_sec_proxy_of_to_priv(struct udevice *dev,
 		return -ENODEV;
 	}
 
-	spm->target_data = devfdt_get_addr_name(dev, "target_data");
-	if (spm->target_data == FDT_ADDR_T_NONE) {
+	spm->target_data = dev_read_addr_name_ptr(dev, "target_data");
+	if (!spm->target_data) {
 		dev_err(dev, "No reg property for target data base\n");
 		return -EINVAL;
 	}
 
-	spm->scfg = devfdt_get_addr_name(dev, "scfg");
-	if (spm->scfg == FDT_ADDR_T_NONE) {
+	spm->scfg = dev_read_addr_name_ptr(dev, "scfg");
+	if (!spm->scfg) {
 		dev_err(dev, "No reg property for Secure Cfg base\n");
 		return -EINVAL;
 	}
 
-	spm->rt = devfdt_get_addr_name(dev, "rt");
-	if (spm->rt == FDT_ADDR_T_NONE) {
+	spm->rt = dev_read_addr_name_ptr(dev, "rt");
+	if (!spm->rt) {
 		dev_err(dev, "No reg property for Real Time Cfg base\n");
 		return -EINVAL;
 	}
diff --git a/drivers/phy/allwinner/phy-sun4i-usb.c b/drivers/phy/allwinner/phy-sun4i-usb.c
index 77dffcad884..6624e9134f4 100644
--- a/drivers/phy/allwinner/phy-sun4i-usb.c
+++ b/drivers/phy/allwinner/phy-sun4i-usb.c
@@ -472,9 +472,9 @@ static int sun4i_usb_phy_probe(struct udevice *dev)
 	if (!data->cfg)
 		return -EINVAL;
 
-	data->base = (void __iomem *)devfdt_get_addr_name(dev, "phy_ctrl");
-	if (IS_ERR(data->base))
-		return PTR_ERR(data->base);
+	data->base = (void __iomem *)dev_read_addr_name_ptr(dev, "phy_ctrl");
+	if (!data->base)
+		return -EINVAL;
 
 	device_get_supply_regulator(dev, "usb0_vbus_power-supply",
 				    &data->vbus_power_supply);
@@ -555,9 +555,9 @@ static int sun4i_usb_phy_probe(struct udevice *dev)
 
 		if (i || data->cfg->phy0_dual_route) {
 			snprintf(name, sizeof(name), "pmu%d", i);
-			phy->pmu = (void __iomem *)devfdt_get_addr_name(dev, name);
-			if (IS_ERR(phy->pmu))
-				return PTR_ERR(phy->pmu);
+			phy->pmu = (void __iomem *)dev_read_addr_name_ptr(dev, name);
+			if (!phy->pmu)
+				return -EINVAL;
 		}
 
 		phy->id = i;
diff --git a/drivers/phy/phy-bcm-sr-pcie.c b/drivers/phy/phy-bcm-sr-pcie.c
index f0e795333b9..cf33bab3707 100644
--- a/drivers/phy/phy-bcm-sr-pcie.c
+++ b/drivers/phy/phy-bcm-sr-pcie.c
@@ -143,8 +143,8 @@ static int sr_pcie_phy_probe(struct udevice *dev)
 
 	core->dev = dev;
 
-	core->base = (void __iomem *)devfdt_get_addr_name(dev, "reg_base");
-	core->cdru = (void __iomem *)devfdt_get_addr_name(dev, "cdru_base");
+	core->base = (void __iomem *)dev_read_addr_name_ptr(dev, "reg_base");
+	core->cdru = (void __iomem *)dev_read_addr_name_ptr(dev, "cdru_base");
 	debug("ip base %p\n", core->base);
 	debug("cdru base %p\n", core->cdru);
 
diff --git a/drivers/ram/k3-am654-ddrss.c b/drivers/ram/k3-am654-ddrss.c
index b8338f84a3d..4a8a6a90bfc 100644
--- a/drivers/ram/k3-am654-ddrss.c
+++ b/drivers/ram/k3-am654-ddrss.c
@@ -903,7 +903,7 @@ static int am654_ddrss_power_on(struct am654_ddrss_desc *ddrss)
 static int am654_ddrss_ofdata_to_priv(struct udevice *dev)
 {
 	struct am654_ddrss_desc *ddrss = dev_get_priv(dev);
-	phys_addr_t reg;
+	void *reg;
 	int ret;
 
 	debug("%s(dev=%p)\n", __func__, dev);
@@ -926,26 +926,26 @@ static int am654_ddrss_ofdata_to_priv(struct udevice *dev)
 		return ret;
 	}
 
-	reg = devfdt_get_addr_name(dev, "ss");
-	if (reg == FDT_ADDR_T_NONE) {
+	reg = dev_read_addr_name_ptr(dev, "ss");
+	if (!reg) {
 		dev_err(dev, "No reg property for DDRSS wrapper logic\n");
 		return -EINVAL;
 	}
-	ddrss->ddrss_ss_cfg = (void *)reg;
+	ddrss->ddrss_ss_cfg = reg;
 
-	reg = devfdt_get_addr_name(dev, "ctl");
-	if (reg == FDT_ADDR_T_NONE) {
+	reg = dev_read_addr_name_ptr(dev, "ctl");
+	if (!reg) {
 		dev_err(dev, "No reg property for Controller region\n");
 		return -EINVAL;
 	}
-	ddrss->ddrss_ctl_cfg = (void *)reg;
+	ddrss->ddrss_ctl_cfg = reg;
 
-	reg = devfdt_get_addr_name(dev, "phy");
-	if (reg == FDT_ADDR_T_NONE) {
+	reg = dev_read_addr_name_ptr(dev, "phy");
+	if (!reg) {
 		dev_err(dev, "No reg property for PHY region\n");
 		return -EINVAL;
 	}
-	ddrss->ddrss_phy_cfg = (void *)reg;
+	ddrss->ddrss_phy_cfg = reg;
 
 	ret = dev_read_u32_array(dev, "ti,ss-reg",
 			         (u32 *)&ddrss->params.ss_reg,
diff --git a/drivers/ram/k3-ddrss/k3-ddrss.c b/drivers/ram/k3-ddrss/k3-ddrss.c
index b54557f02cc..5b6089e8526 100644
--- a/drivers/ram/k3-ddrss/k3-ddrss.c
+++ b/drivers/ram/k3-ddrss/k3-ddrss.c
@@ -331,32 +331,29 @@ static int k3_ddrss_ofdata_to_priv(struct udevice *dev)
 {
 	struct k3_ddrss_desc *ddrss = dev_get_priv(dev);
 	struct k3_ddrss_data *ddrss_data = (struct k3_ddrss_data *)dev_get_driver_data(dev);
-	phys_addr_t reg;
+	void *reg;
 	int ret;
 
 	debug("%s(dev=%p)\n", __func__, dev);
 
-	reg = dev_read_addr_name(dev, "cfg");
-	if (reg == FDT_ADDR_T_NONE) {
+	reg = dev_read_addr_name_ptr(dev, "cfg");
+	if (!reg) {
 		dev_err(dev, "No reg property for DDRSS wrapper logic\n");
 		return -EINVAL;
 	}
-	ddrss->ddrss_ctl_cfg = (void *)reg;
+	ddrss->ddrss_ctl_cfg = reg;
 
-	reg = dev_read_addr_name(dev, "ctrl_mmr_lp4");
-	if (reg == FDT_ADDR_T_NONE) {
+	reg = dev_read_addr_name_ptr(dev, "ctrl_mmr_lp4");
+	if (!reg) {
 		dev_err(dev, "No reg property for CTRL MMR\n");
 		return -EINVAL;
 	}
-	ddrss->ddrss_ctrl_mmr = (void *)reg;
+	ddrss->ddrss_ctrl_mmr = reg;
 
-	reg = dev_read_addr_name(dev, "ss_cfg");
-	if (reg == FDT_ADDR_T_NONE) {
+	reg = dev_read_addr_name_ptr(dev, "ss_cfg");
+	if (!reg)
 		dev_dbg(dev, "No reg property for SS Config region, but this is optional so continuing.\n");
-		ddrss->ddrss_ss_cfg = NULL;
-	} else {
-		ddrss->ddrss_ss_cfg = (void *)reg;
-	}
+	ddrss->ddrss_ss_cfg = reg;
 
 	ret = power_domain_get_by_index(dev, &ddrss->ddrcfg_pwrdmn, 0);
 	if (ret) {
diff --git a/drivers/soc/ti/k3-navss-ringacc.c b/drivers/soc/ti/k3-navss-ringacc.c
index f110d78ce10..549c061d991 100644
--- a/drivers/soc/ti/k3-navss-ringacc.c
+++ b/drivers/soc/ti/k3-navss-ringacc.c
@@ -986,10 +986,10 @@ static int k3_nav_ringacc_init(struct udevice *dev, struct k3_nav_ringacc *ringa
 	if (!base_cfg)
 		return -EINVAL;
 
-	base_rt = (uint32_t *)devfdt_get_addr_name(dev, "rt");
+	base_rt = dev_read_addr_name_ptr(dev, "rt");
 	pr_debug("rt %p\n", base_rt);
-	if (IS_ERR(base_rt))
-		return PTR_ERR(base_rt);
+	if (!base_rt)
+		return -EINVAL;
 
 	ringacc->rings = devm_kzalloc(dev,
 				      sizeof(*ringacc->rings) *
@@ -1044,9 +1044,9 @@ struct k3_nav_ringacc *k3_ringacc_dmarings_init(struct udevice *dev,
 	ringacc->tisci = data->tisci;
 	ringacc->tisci_dev_id = data->tisci_dev_id;
 
-	base_rt = (uint32_t *)devfdt_get_addr_name(dev, "ringrt");
-	if (IS_ERR(base_rt))
-		return base_rt;
+	base_rt = dev_read_addr_name_ptr(dev, "ringrt");
+	if (!base_rt)
+		return ERR_PTR(-EINVAL);
 
 	ringacc->rings = devm_kzalloc(dev,
 				      sizeof(*ringacc->rings) *
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

