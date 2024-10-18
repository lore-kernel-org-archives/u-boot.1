Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C4BBD30011
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 14:55:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7313C89057;
	Fri, 18 Oct 2024 16:55:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bDvsWnNF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E22E38919E; Fri, 18 Oct 2024 16:55:01 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E80F89110
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 16:54:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=conor@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 30C74A44320;
 Fri, 18 Oct 2024 14:54:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E885DC4CED5;
 Fri, 18 Oct 2024 14:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1729263297;
 bh=U2eba/Wr96MHa2FoIM6bJpG+w4MI5F788GRlDEQeTuE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bDvsWnNFzgc3NOcUC/Z3xXPSAoIFpWz7zGS4yWvBuyc50Qgzo4WoekkZF9ZyLgEvU
 au3oDYPnndzi2iSNJ4YM+qy9tDCm47+10cos2oFLfgnBm05eSRBi8JVNjRwM4DLkhl
 4mBFocIzxbfijvRF2SOnIAjNcu86Bka2AvtZC1Fj0+otH0FrRY7URxSi6uwftWNca3
 auPWzgl+6rwnUK4s+t/y+jtwNSegECceuCRsi3tJRu1MPx36xr2f0q0MoB2/vnfFhr
 QbGYfXeXQpluiYIug9Dv1R9juUi2WYLYuAQ8ni5XaOsTk1mMuEH8B4NK5Jc6wzw4s2
 Nx8KdthOvJjAw==
From: Conor Dooley <conor@kernel.org>
To: u-boot@lists.denx.de
Cc: conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Cyril Jean <cyril.jean@microchip.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v1 1/3] clk: microchip: mpfs: support new syscon based
 devicetree configuration
Date: Fri, 18 Oct 2024 15:54:42 +0100
Message-ID: <20241018145444.1660219-2-conor@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241018145444.1660219-1-conor@kernel.org>
References: <20241018145444.1660219-1-conor@kernel.org>
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

From: Conor Dooley <conor.dooley@microchip.com>

Why get a devicetree description wrong once when you can get it wrong
twice? The original mistake, which the driver supports was failing to
describe the main PLL that the "cfg" and "periph" clocks parented by.
The second mistake was describing the "cfg" and "periph" clocks a
reg region within the clock controller, rather as two registers within
a syscon region that also contains pinctrl, interrupt muxing controls
and other functions.

Make up for lost time and describe these regions as they should have
been originally, preserving support for the existing two configurations
for the sake of existing systems with firmware-provided devicetrees.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/clk/microchip/Kconfig           |  2 +
 drivers/clk/microchip/mpfs_clk.c        | 63 ++++++++++++++++++++-----
 drivers/clk/microchip/mpfs_clk.h        |  5 +-
 drivers/clk/microchip/mpfs_clk_cfg.c    | 16 +++----
 drivers/clk/microchip/mpfs_clk_periph.c | 37 +++++++--------
 5 files changed, 81 insertions(+), 42 deletions(-)

diff --git a/drivers/clk/microchip/Kconfig b/drivers/clk/microchip/Kconfig
index b70241559db..62072e100b1 100644
--- a/drivers/clk/microchip/Kconfig
+++ b/drivers/clk/microchip/Kconfig
@@ -1,5 +1,7 @@
 config CLK_MPFS
 	bool "Clock support for Microchip PolarFire SoC"
 	depends on CLK && CLK_CCF
+	depends on SYSCON
+	depends on REGMAP
 	help
 	  This enables support clock driver for Microchip PolarFire SoC platform.
diff --git a/drivers/clk/microchip/mpfs_clk.c b/drivers/clk/microchip/mpfs_clk.c
index 0a82777ff74..2c6694f0035 100644
--- a/drivers/clk/microchip/mpfs_clk.c
+++ b/drivers/clk/microchip/mpfs_clk.c
@@ -9,25 +9,39 @@
 #include <log.h>
 #include <dm/device.h>
 #include <dm/devres.h>
+#include <dm/ofnode.h>
 #include <dm/uclass.h>
+#include <regmap.h>
+#include <syscon.h>
 #include <dt-bindings/clock/microchip-mpfs-clock.h>
 #include <linux/err.h>
 
 #include "mpfs_clk.h"
 
-static int mpfs_clk_probe(struct udevice *dev)
+static int mpfs_clk_syscon_probe(struct udevice *dev, void __iomem **msspll_base,
+				 struct regmap **regmap)
+{
+	ofnode node;
+
+	node = ofnode_by_compatible(ofnode_null(), "microchip,mpfs-mss-top-sysreg");
+	if (!ofnode_valid(node))
+		return -ENODEV;
+
+	*regmap = syscon_node_to_regmap(node);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	*msspll_base = dev_read_addr_index_ptr(dev, 0);
+
+	return 0;
+}
+
+static int mpfs_clk_old_format_probe(struct udevice *dev, void __iomem **msspll_base,
+				     struct regmap **regmap)
 {
-	struct clk *parent_clk = dev_get_priv(dev);
-	struct clk clk_msspll = { .id = CLK_MSSPLL };
-	void __iomem *base;
-	void __iomem *msspll_base;
 	int ret;
 
-	base = dev_read_addr_index_ptr(dev, 0);
-	if (!base)
-		return -EINVAL;
-
-	ret = clk_get_by_index(dev, 0, parent_clk);
+	ret = regmap_init_mem_index(dev_ofnode(dev), regmap, 0);
 	if (ret)
 		return ret;
 
@@ -40,7 +54,30 @@ static int mpfs_clk_probe(struct udevice *dev)
 	 * Otherwise, skip registering it & pass the reference clock directly
 	 * to the cfg clock registration function.
 	 */
-	msspll_base = dev_read_addr_index_ptr(dev, 1);
+	*msspll_base = dev_read_addr_index_ptr(dev, 1);
+
+	return 0;
+}
+
+static int mpfs_clk_probe(struct udevice *dev)
+{
+	struct clk *parent_clk = dev_get_priv(dev);
+	struct clk clk_msspll = { .id = CLK_MSSPLL };
+	struct regmap *regmap;
+	void __iomem *msspll_base;
+	int ret;
+
+	ret = clk_get_by_index(dev, 0, parent_clk);
+	if (ret)
+		return ret;
+
+	ret = mpfs_clk_syscon_probe(dev, &msspll_base, &regmap);
+	if (ret) {
+		ret = mpfs_clk_old_format_probe(dev, &msspll_base, &regmap);
+		if (ret)
+			return ret;
+	}
+
 	if (msspll_base) {
 		ret = mpfs_clk_register_msspll(msspll_base, parent_clk);
 		if (ret)
@@ -50,11 +87,11 @@ static int mpfs_clk_probe(struct udevice *dev)
 		parent_clk = &clk_msspll;
 	}
 
-	ret = mpfs_clk_register_cfgs(base, parent_clk);
+	ret = mpfs_clk_register_cfgs(parent_clk, regmap);
 	if (ret)
 		return ret;
 
-	ret = mpfs_clk_register_periphs(base, dev);
+	ret = mpfs_clk_register_periphs(dev, regmap);
 
 	return ret;
 }
diff --git a/drivers/clk/microchip/mpfs_clk.h b/drivers/clk/microchip/mpfs_clk.h
index 72288cc971b..b8ad3ea7616 100644
--- a/drivers/clk/microchip/mpfs_clk.h
+++ b/drivers/clk/microchip/mpfs_clk.h
@@ -7,6 +7,7 @@
 #define __MICROCHIP_MPFS_CLK_H
 
 #include <linux/clk-provider.h>
+#include <regmap.h>
 /**
  * mpfs_clk_register_cfgs() - register configuration clocks
  *
@@ -14,7 +15,7 @@
  * @parent: a pointer to parent clock.
  * Return: zero on success, or a negative error code.
  */
-int mpfs_clk_register_cfgs(void __iomem *base, struct clk *parent);
+int mpfs_clk_register_cfgs(struct clk *parent, struct regmap *regmap);
 /**
  * mpfs_clk_register_msspll() - register the mss pll
  *
@@ -30,7 +31,7 @@ int mpfs_clk_register_msspll(void __iomem *base, struct clk *parent);
  * @dev: udevice representing the clock controller.
  * Return: zero on success, or a negative error code.
  */
-int mpfs_clk_register_periphs(void __iomem *base, struct udevice *dev);
+int mpfs_clk_register_periphs(struct udevice *dev, struct regmap *regmap);
 /**
  * divider_get_val() - get the clock divider value
  *
diff --git a/drivers/clk/microchip/mpfs_clk_cfg.c b/drivers/clk/microchip/mpfs_clk_cfg.c
index 5e8fb995289..7da1fc77120 100644
--- a/drivers/clk/microchip/mpfs_clk_cfg.c
+++ b/drivers/clk/microchip/mpfs_clk_cfg.c
@@ -9,6 +9,7 @@
 #include <dm/device.h>
 #include <dm/devres.h>
 #include <dm/uclass.h>
+#include <regmap.h>
 #include <dt-bindings/clock/microchip-mpfs-clock.h>
 #include <linux/err.h>
 
@@ -57,7 +58,7 @@ struct mpfs_cfg_clock {
  */
 struct mpfs_cfg_hw_clock {
 	struct mpfs_cfg_clock cfg;
-	void __iomem *sys_base;
+	struct regmap *regmap;
 	u32 prate;
 	struct clk hw;
 };
@@ -68,11 +69,11 @@ static ulong mpfs_cfg_clk_recalc_rate(struct clk *hw)
 {
 	struct mpfs_cfg_hw_clock *cfg_hw = to_mpfs_cfg_clk(hw);
 	struct mpfs_cfg_clock *cfg = &cfg_hw->cfg;
-	void __iomem *base_addr = cfg_hw->sys_base;
 	unsigned long rate;
 	u32 val;
 
-	val = readl(base_addr + REG_CLOCK_CONFIG_CR) >> cfg->shift;
+	regmap_read(cfg_hw->regmap, REG_CLOCK_CONFIG_CR, &val);
+	val >>= cfg->shift;
 	val &= clk_div_mask(cfg->width);
 	rate = cfg_hw->prate / (1u << val);
 	hw->rate = rate;
@@ -84,7 +85,6 @@ static ulong mpfs_cfg_clk_set_rate(struct clk *hw, ulong rate)
 {
 	struct mpfs_cfg_hw_clock *cfg_hw = to_mpfs_cfg_clk(hw);
 	struct mpfs_cfg_clock *cfg = &cfg_hw->cfg;
-	void __iomem *base_addr = cfg_hw->sys_base;
 	u32  val;
 	int divider_setting;
 
@@ -93,10 +93,10 @@ static ulong mpfs_cfg_clk_set_rate(struct clk *hw, ulong rate)
 	if (divider_setting < 0)
 		return divider_setting;
 
-	val = readl(base_addr + REG_CLOCK_CONFIG_CR);
+	regmap_read(cfg_hw->regmap, REG_CLOCK_CONFIG_CR, &val);
 	val &= ~(clk_div_mask(cfg->width) << cfg_hw->cfg.shift);
 	val |= divider_setting << cfg->shift;
-	writel(val, base_addr + REG_CLOCK_CONFIG_CR);
+	regmap_write(cfg_hw->regmap, REG_CLOCK_CONFIG_CR, val);
 
 	return clk_get_rate(hw);
 }
@@ -116,7 +116,7 @@ static struct mpfs_cfg_hw_clock mpfs_cfg_clks[] = {
 	CLK_CFG(CLK_AHB, "clk_ahb", 4, 2, mpfs_div_ahb_table, 0),
 };
 
-int mpfs_clk_register_cfgs(void __iomem *base, struct clk *parent)
+int mpfs_clk_register_cfgs(struct clk *parent, struct regmap *regmap)
 {
 	int ret;
 	int i, id, num_clks;
@@ -126,7 +126,7 @@ int mpfs_clk_register_cfgs(void __iomem *base, struct clk *parent)
 	num_clks = ARRAY_SIZE(mpfs_cfg_clks);
 	for (i = 0; i < num_clks; i++) {
 		hw = &mpfs_cfg_clks[i].hw;
-		mpfs_cfg_clks[i].sys_base = base;
+		mpfs_cfg_clks[i].regmap = regmap;
 		mpfs_cfg_clks[i].prate = clk_get_rate(parent);
 		name = mpfs_cfg_clks[i].cfg.name;
 		ret = clk_register(hw, MPFS_CFG_CLOCK, name, parent->dev->name);
diff --git a/drivers/clk/microchip/mpfs_clk_periph.c b/drivers/clk/microchip/mpfs_clk_periph.c
index 41c6df4fb97..b734f49d81a 100644
--- a/drivers/clk/microchip/mpfs_clk_periph.c
+++ b/drivers/clk/microchip/mpfs_clk_periph.c
@@ -9,6 +9,7 @@
 #include <dm/device.h>
 #include <dm/devres.h>
 #include <dm/uclass.h>
+#include <regmap.h>
 #include <dt-bindings/clock/microchip-mpfs-clock.h>
 #include <linux/err.h>
 
@@ -50,7 +51,7 @@ struct mpfs_periph_clock {
  */
 struct mpfs_periph_hw_clock {
 	struct mpfs_periph_clock periph;
-	void __iomem *sys_base;
+	struct regmap *regmap;
 	u32 prate;
 	struct clk hw;
 };
@@ -61,17 +62,16 @@ static int mpfs_periph_clk_enable(struct clk *hw)
 {
 	struct mpfs_periph_hw_clock *periph_hw = to_mpfs_periph_clk(hw);
 	struct mpfs_periph_clock *periph = &periph_hw->periph;
-	void __iomem *base_addr = periph_hw->sys_base;
-	u32 reg, val;
+	u32 reg;
 
 	if (periph->flags != CLK_IS_CRITICAL) {
-		reg = readl(base_addr + REG_SUBBLK_RESET_CR);
-		val = reg & ~(1u << periph->shift);
-		writel(val, base_addr + REG_SUBBLK_RESET_CR);
+		regmap_read(periph_hw->regmap, REG_SUBBLK_RESET_CR, &reg);
+		reg &= ~(1u << periph->shift);
+		regmap_write(periph_hw->regmap, REG_SUBBLK_RESET_CR, reg);
 
-		reg = readl(base_addr + REG_SUBBLK_CLOCK_CR);
-		val = reg | (1u << periph->shift);
-		writel(val, base_addr + REG_SUBBLK_CLOCK_CR);
+		regmap_read(periph_hw->regmap, REG_SUBBLK_CLOCK_CR, &reg);
+		reg |= (1u << periph->shift);
+		regmap_write(periph_hw->regmap, REG_SUBBLK_CLOCK_CR, reg);
 	}
 
 	return 0;
@@ -81,17 +81,16 @@ static int mpfs_periph_clk_disable(struct clk *hw)
 {
 	struct mpfs_periph_hw_clock *periph_hw = to_mpfs_periph_clk(hw);
 	struct mpfs_periph_clock *periph = &periph_hw->periph;
-	void __iomem *base_addr = periph_hw->sys_base;
-	u32 reg, val;
+	u32 reg;
 
 	if (periph->flags != CLK_IS_CRITICAL) {
-		reg = readl(base_addr + REG_SUBBLK_RESET_CR);
-		val = reg | (1u << periph->shift);
-		writel(val, base_addr + REG_SUBBLK_RESET_CR);
+		regmap_read(periph_hw->regmap, REG_SUBBLK_RESET_CR, &reg);
+		reg |= (1u << periph->shift);
+		regmap_write(periph_hw->regmap, REG_SUBBLK_RESET_CR, reg);
 
-		reg = readl(base_addr + REG_SUBBLK_CLOCK_CR);
-		val = reg & ~(1u << periph->shift);
-		writel(val, base_addr + REG_SUBBLK_CLOCK_CR);
+		regmap_read(periph_hw->regmap, REG_SUBBLK_CLOCK_CR, &reg);
+		reg &= ~(1u << periph->shift);
+		regmap_write(periph_hw->regmap, REG_SUBBLK_CLOCK_CR, reg);
 	}
 
 	return 0;
@@ -159,7 +158,7 @@ static struct mpfs_periph_hw_clock mpfs_periph_clks[] = {
 	CLK_PERIPH(CLK_CFM, "clk_periph_cfm", CLK_AHB, 29, 0),
 };
 
-int mpfs_clk_register_periphs(void __iomem *base, struct udevice *dev)
+int mpfs_clk_register_periphs(struct udevice *dev, struct regmap *regmap)
 {
 	int ret;
 	int i, id, num_clks;
@@ -172,7 +171,7 @@ int mpfs_clk_register_periphs(void __iomem *base, struct udevice *dev)
 
 		clk_request(dev, &parent);
 		hw = &mpfs_periph_clks[i].hw;
-		mpfs_periph_clks[i].sys_base = base;
+		mpfs_periph_clks[i].regmap = regmap;
 		mpfs_periph_clks[i].prate = clk_get_rate(&parent);
 		name = mpfs_periph_clks[i].periph.name;
 		ret = clk_register(hw, MPFS_PERIPH_CLOCK, name, parent.dev->name);
-- 
2.45.2

