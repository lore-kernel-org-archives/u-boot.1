Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3CEE1098792
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 14:39:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15672840CF;
	Fri, 20 Mar 2026 15:38:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="jN8xFrg3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AC6C83FC5; Fri, 20 Mar 2026 15:32:23 +0100 (CET)
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::ba])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34C2083F00
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 15:32:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kcxt@postmarketos.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1774017139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZebeunayAyKzVB9cKrTkH9BCekDBsdVHWHi3u/9w/5k=;
 b=jN8xFrg3USOSuqc/n1NnAhi9D7IMqx+S58lXIwpnL+isxzhvNr9KTkiXaSwbsCZaaQRNQH
 fnLhveYSPGNWpEz8eu3BhbgY6H0eJj4vtLulgeAqXmEMpUhYZT6AzPmFTleEmKSYrUQFXN
 gftWqTJA3vwVlahnkOXbGxM/pGJLC19s+570dB1Cb5rW4adLwCUgHaNPro3Kb9ZPzLFAUq
 YP5XKbX3Bt/NILVw07qWBzBR7ngQhMcm68wZDjFRC93MIW0XTUjyElzpyEBvjF5HeOrGif
 C95DVwf6Q/ZtbvyjL26i4A22BSaTZ8doBfpWNXwacbbNkKdC7CYgtSzGFpkWyQ==
From: Casey Connolly <kcxt@postmarketos.org>
To: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
 u-boot-qcom@groups.io, uboot-snps-arc@synopsys.com,
 u-boot-amlogic@groups.io, Sumit Garg <sumit.garg@kernel.org>
Cc: Casey Connolly <casey.connolly@linaro.org>, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Michal Simek <michal.simek@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Robert Marko <robert.marko@sartura.hr>,
 Thierry Reding <treding@nvidia.com>,
 Valentin Caron <valentin.caron@foss.st.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Rui Miguel Silva <rui.silva@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 20260319-casey-ccf-upstream-v1-0-4df2ee2226da@linaro.org,
 Marek Vasut <marex@denx.de>
Subject: [PATCH RFC 37/40] clk/qcom/ccf: adapt common, gdsc,
 and reset code for U-Boot
Date: Fri, 20 Mar 2026 15:31:33 +0100
Message-ID: <20260320-casey-ccf-upstream-v1-37-5b654f4b6620@linaro.org>
In-Reply-To: <20260319-casey-ccf-upstream-v1-0-4df2ee2226da@linaro.org>
References: <20260319-casey-ccf-upstream-v1-0-4df2ee2226da@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=36029;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=pTg2DYm1YBrXMl1Ae4kAqOMD+Gegfm7mDR1C5pJEWnE=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsy9kStmVh+f5WI31UeyLv3XFLVk4fXi5V/2FvwraV6aV
 SrzbHpWRykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZhIrBXD/zy2/JulpimTn7+0
 LNjhclptWWLvAzM+/XOChRcPfWvN+svIsPfIQqGsii8u3H+Ko1WfekoWnzNb7ta8fOlPjV/XNdS
 z3gMA
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Approved-At: Fri, 20 Mar 2026 15:38:37 +0100
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

From: Casey Connolly <casey.connolly@linaro.org>

Since U-Boot drivers require a udevice per driver, adapt the qcom clock
core code as well as the power domain and reset drivers so that we bind
these additional drivers to the clock device. The clock device itself
will be a UCLASS_NOP driver for clarity, even though with CCF it would
be possible to register the clocks from either the PD or reset drivers,
using a separate device for now makes the code cleaner and easier to
reason about.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/clk/qcom/ccf/common.c | 328 ++++++++----------------------------------
 drivers/clk/qcom/ccf/common.h |  40 ++++--
 drivers/clk/qcom/ccf/gdsc.c   | 324 +++++++++++++----------------------------
 drivers/clk/qcom/ccf/gdsc.h   |  32 +++--
 drivers/clk/qcom/ccf/reset.c  | 101 +++++++++----
 drivers/clk/qcom/ccf/reset.h  |  10 +-
 6 files changed, 282 insertions(+), 553 deletions(-)

diff --git a/drivers/clk/qcom/ccf/common.c b/drivers/clk/qcom/ccf/common.c
index 121591886774..8af0e8889357 100644
--- a/drivers/clk/qcom/ccf/common.c
+++ b/drivers/clk/qcom/ccf/common.c
@@ -2,17 +2,17 @@
 /*
  * Copyright (c) 2013-2014, The Linux Foundation. All rights reserved.
  */
 
-#include <linux/export.h>
-#include <linux/module.h>
+#include <dm/read.h>
+#include <dm/device_compat.h>
+#include <dm/devres.h>
+#include <dm/ofnode.h>
+#include <linux/compat.h>
 #include <linux/regmap.h>
-#include <linux/platform_device.h>
 #include <linux/clk-provider.h>
-#include <linux/interconnect-clk.h>
-#include <linux/pm_runtime.h>
-#include <linux/reset-controller.h>
-#include <linux/of.h>
+#include <reset.h>
+#include <event.h>
 
 #include "common.h"
 #include "clk-alpha-pll.h"
 #include "clk-branch.h"
@@ -20,13 +20,15 @@
 #include "clk-regmap.h"
 #include "reset.h"
 #include "gdsc.h"
 
+#include "common-uboot.h"
+
+DECLARE_GLOBAL_DATA_PTR;
+
 struct qcom_cc {
-	struct qcom_reset_controller reset;
 	struct clk_regmap **rclks;
 	size_t num_rclks;
-	struct dev_pm_domain_list *pd_list;
 };
 
 const
 struct freq_tbl *qcom_find_freq(const struct freq_tbl *f, unsigned long rate)
@@ -104,18 +106,36 @@ int qcom_find_cfg_index(struct clk_hw *hw, const struct parent_map *map, u8 cfg)
 }
 EXPORT_SYMBOL_GPL(qcom_find_cfg_index);
 
 struct regmap *
-qcom_cc_map(struct platform_device *pdev, const struct qcom_cc_desc *desc)
+qcom_cc_map(struct udevice *dev, const struct qcom_cc_desc *desc)
 {
 	void __iomem *base;
-	struct device *dev = &pdev->dev;
+	struct regmap_config config = {
+		.reg_offset_shift = 0,
+	};
 
-	base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(base))
-		return ERR_CAST(base);
+	switch (desc->config->val_bits) {
+	case 64:
+		config.width = REGMAP_SIZE_64;
+		break;
+	case 32:
+		config.width = REGMAP_SIZE_32;
+		break;
+	case 16:
+		config.width = REGMAP_SIZE_16;
+		break;
+	}
 
-	return devm_regmap_init_mmio(dev, base, desc->config);
+	if (desc->config->max_register) {
+		base = dev_read_addr_ptr(dev);
+		if (!IS_ERR(base)) {
+			config.r_start = (ulong)base;
+			config.r_size = desc->config->max_register - (ulong)base;
+		}
+	}
+
+	return devm_regmap_init(dev, NULL, NULL, &config);
 }
 EXPORT_SYMBOL_GPL(qcom_cc_map);
 
 void
@@ -138,259 +158,43 @@ qcom_pll_set_fsm_mode(struct regmap *map, u32 reg, u8 bias_count, u8 lock_count)
 	regmap_update_bits(map, reg, PLL_VOTE_FSM_ENA, PLL_VOTE_FSM_ENA);
 }
 EXPORT_SYMBOL_GPL(qcom_pll_set_fsm_mode);
 
-static void qcom_cc_gdsc_unregister(void *data)
-{
-	gdsc_unregister(data);
-}
-
-/*
- * Backwards compatibility with old DTs. Register a pass-through factor 1/1
- * clock to translate 'path' clk into 'name' clk and register the 'path'
- * clk as a fixed rate clock if it isn't present.
- */
-static int _qcom_cc_register_board_clk(struct device *dev, const char *path,
-				       const char *name, unsigned long rate,
-				       bool add_factor)
-{
-	struct device_node *node = NULL;
-	struct device_node *clocks_node;
-	struct clk_fixed_factor *factor;
-	struct clk_fixed_rate *fixed;
-	struct clk_init_data init_data = { };
-	int ret;
-
-	clocks_node = of_find_node_by_path("/clocks");
-	if (clocks_node) {
-		node = of_get_child_by_name(clocks_node, path);
-		of_node_put(clocks_node);
-	}
-
-	if (!node) {
-		fixed = devm_kzalloc(dev, sizeof(*fixed), GFP_KERNEL);
-		if (!fixed)
-			return -EINVAL;
-
-		fixed->fixed_rate = rate;
-		fixed->hw.init = &init_data;
-
-		init_data.name = path;
-		init_data.ops = &clk_fixed_rate_ops;
-
-		ret = devm_clk_hw_register(dev, &fixed->hw);
-		if (ret)
-			return ret;
-	}
-	of_node_put(node);
-
-	if (add_factor) {
-		factor = devm_kzalloc(dev, sizeof(*factor), GFP_KERNEL);
-		if (!factor)
-			return -EINVAL;
-
-		factor->mult = factor->div = 1;
-		factor->hw.init = &init_data;
-
-		init_data.name = name;
-		init_data.parent_names = &path;
-		init_data.num_parents = 1;
-		init_data.flags = 0;
-		init_data.ops = &clk_fixed_factor_ops;
-
-		ret = devm_clk_hw_register(dev, &factor->hw);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
-int qcom_cc_register_board_clk(struct device *dev, const char *path,
-			       const char *name, unsigned long rate)
-{
-	bool add_factor = true;
-
-	/*
-	 * TODO: The RPM clock driver currently does not support the xo clock.
-	 * When xo is added to the RPM clock driver, we should change this
-	 * function to skip registration of xo factor clocks.
-	 */
-
-	return _qcom_cc_register_board_clk(dev, path, name, rate, add_factor);
-}
-EXPORT_SYMBOL_GPL(qcom_cc_register_board_clk);
-
-int qcom_cc_register_sleep_clk(struct device *dev)
-{
-	return _qcom_cc_register_board_clk(dev, "sleep_clk", "sleep_clk_src",
-					   32768, true);
-}
-EXPORT_SYMBOL_GPL(qcom_cc_register_sleep_clk);
-
-/* Drop 'protected-clocks' from the list of clocks to register */
-static void qcom_cc_drop_protected(struct device *dev, struct qcom_cc *cc)
-{
-	struct device_node *np = dev->of_node;
-	u32 i;
-
-	of_property_for_each_u32(np, "protected-clocks", i) {
-		if (i >= cc->num_rclks)
-			continue;
-
-		cc->rclks[i] = NULL;
-	}
-}
-
-static struct clk_hw *qcom_cc_clk_hw_get(struct of_phandle_args *clkspec,
+static struct clk_hw *qcom_cc_clk_hw_get(struct ofnode_phandle_args *clkspec,
 					 void *data)
 {
 	struct qcom_cc *cc = data;
 	unsigned int idx = clkspec->args[0];
 
+	// printf("%s: %s: id %u\n", __func__, ofnode_get_name(clkspec->node), idx);
+
 	if (idx >= cc->num_rclks) {
 		pr_err("%s: invalid index %u\n", __func__, idx);
 		return ERR_PTR(-EINVAL);
 	}
 
-	return cc->rclks[idx] ? &cc->rclks[idx]->hw : NULL;
+	if (!cc->rclks[idx])
+		return NULL;
+
+	/* U-Boot: some clocks may not be registered pre-reloc */
+	return cc->rclks[idx]->hw.core ? &cc->rclks[idx]->hw : NULL;
 }
 
-static int qcom_cc_icc_register(struct device *dev,
-				const struct qcom_cc_desc *desc)
-{
-	struct icc_clk_data *icd;
-	struct clk_hw *hws;
-	int i;
-
-	if (!IS_ENABLED(CONFIG_INTERCONNECT_CLK))
-		return 0;
-
-	if (!desc->icc_hws)
-		return 0;
-
-	icd = devm_kcalloc(dev, desc->num_icc_hws, sizeof(*icd), GFP_KERNEL);
-	if (!icd)
-		return -ENOMEM;
-
-	for (i = 0; i < desc->num_icc_hws; i++) {
-		icd[i].master_id = desc->icc_hws[i].master_id;
-		icd[i].slave_id = desc->icc_hws[i].slave_id;
-		hws = &desc->clks[desc->icc_hws[i].clk_id]->hw;
-		icd[i].clk = devm_clk_hw_get_clk(dev, hws, "icc");
-		if (IS_ERR(icd[i].clk))
-			return dev_err_probe(dev, PTR_ERR(icd[i].clk),
-					     "(%d) clock entry is null\n", i);
-		icd[i].name = clk_hw_get_name(hws);
-	}
-
-	return devm_icc_clk_register(dev, desc->icc_first_node_id,
-						     desc->num_icc_hws, icd);
-}
-
-static int qcom_cc_clk_pll_configure(const struct qcom_cc_driver_data *data,
-				     struct regmap *regmap)
-{
-	const struct clk_init_data *init;
-	struct clk_alpha_pll *pll;
-	int i;
-
-	for (i = 0; i < data->num_alpha_plls; i++) {
-		pll = data->alpha_plls[i];
-		init = pll->clkr.hw.init;
-
-		if (!pll->config || !pll->regs) {
-			pr_err("%s: missing pll config or regs\n", init->name);
-			return -EINVAL;
-		}
-
-		qcom_clk_alpha_pll_configure(pll, regmap);
-	}
-
-	return 0;
-}
-
-static void qcom_cc_clk_regs_configure(struct device *dev, const struct qcom_cc_driver_data *data,
-				       struct regmap *regmap)
-{
-	int i;
-
-	for (i = 0; i < data->num_clk_cbcrs; i++)
-		qcom_branch_set_clk_en(regmap, data->clk_cbcrs[i]);
-
-	if (data->clk_regs_configure)
-		data->clk_regs_configure(dev, regmap);
-}
-
-int qcom_cc_really_probe(struct device *dev,
+int qcom_cc_really_probe(struct udevice *dev,
 			 const struct qcom_cc_desc *desc, struct regmap *regmap)
 {
-	int i, ret;
-	struct qcom_reset_controller *reset;
+	int ret;
 	struct qcom_cc *cc;
-	struct gdsc_desc *scd;
 	size_t num_clks = desc->num_clks;
 	struct clk_regmap **rclks = desc->clks;
 	size_t num_clk_hws = desc->num_clk_hws;
 	struct clk_hw **clk_hws = desc->clk_hws;
+	int i;
 
 	cc = devm_kzalloc(dev, sizeof(*cc), GFP_KERNEL);
 	if (!cc)
 		return -ENOMEM;
 
-	ret = devm_pm_domain_attach_list(dev, NULL, &cc->pd_list);
-	if (ret < 0 && ret != -EEXIST)
-		return ret;
-
-	if (desc->use_rpm) {
-		ret = devm_pm_runtime_enable(dev);
-		if (ret)
-			return ret;
-
-		ret = pm_runtime_resume_and_get(dev);
-		if (ret)
-			return ret;
-	}
-
-	if (desc->driver_data) {
-		ret = qcom_cc_clk_pll_configure(desc->driver_data, regmap);
-		if (ret)
-			goto put_rpm;
-
-		qcom_cc_clk_regs_configure(dev, desc->driver_data, regmap);
-	}
-
-	reset = &cc->reset;
-	reset->rcdev.of_node = dev->of_node;
-	reset->rcdev.ops = &qcom_reset_ops;
-	reset->rcdev.owner = dev->driver->owner;
-	reset->rcdev.nr_resets = desc->num_resets;
-	reset->regmap = regmap;
-	reset->reset_map = desc->resets;
-
-	ret = devm_reset_controller_register(dev, &reset->rcdev);
-	if (ret)
-		goto put_rpm;
-
-	if (desc->gdscs && desc->num_gdscs) {
-		scd = devm_kzalloc(dev, sizeof(*scd), GFP_KERNEL);
-		if (!scd) {
-			ret = -ENOMEM;
-			goto put_rpm;
-		}
-		scd->dev = dev;
-		scd->scs = desc->gdscs;
-		scd->num = desc->num_gdscs;
-		scd->pd_list = cc->pd_list;
-		ret = gdsc_register(scd, &reset->rcdev, regmap);
-		if (ret)
-			goto put_rpm;
-		ret = devm_add_action_or_reset(dev, qcom_cc_gdsc_unregister,
-					       scd);
-		if (ret)
-			goto put_rpm;
-	}
-
 	if (desc->driver_data &&
 	    desc->driver_data->dfs_rcgs &&
 	    desc->driver_data->num_dfs_rcgs) {
 		ret = qcom_cc_register_rcg_dfs(regmap,
@@ -402,67 +206,47 @@ int qcom_cc_really_probe(struct device *dev,
 
 	cc->rclks = rclks;
 	cc->num_rclks = num_clks;
 
-	qcom_cc_drop_protected(dev, cc);
-
 	for (i = 0; i < num_clk_hws; i++) {
+		// if (!(gd->flags & GD_FLG_RELOC) && !(clk_hws[i]->init->flags & CLK_REGISTER_PRE_RELOC))
+		// 	continue;
 		ret = devm_clk_hw_register(dev, clk_hws[i]);
 		if (ret)
-			goto put_rpm;
+			return ret;
 	}
 
 	for (i = 0; i < num_clks; i++) {
 		if (!rclks[i])
 			continue;
+		// if (!(gd->flags & GD_FLG_RELOC) && !(rclks[i]->hw.init->flags & CLK_REGISTER_PRE_RELOC))
+		// 	continue;
 
-		ret = devm_clk_register_regmap(dev, rclks[i]);
+		ret = devm_clk_register_regmap(dev, rclks[i], regmap);
 		if (ret)
-			goto put_rpm;
+			return ret;
 	}
 
 	ret = devm_of_clk_add_hw_provider(dev, qcom_cc_clk_hw_get, cc);
 	if (ret)
 		goto put_rpm;
 
-	ret = qcom_cc_icc_register(dev, desc);
-
 put_rpm:
 	if (desc->use_rpm)
 		pm_runtime_put(dev);
 
 	return ret;
 }
 EXPORT_SYMBOL_GPL(qcom_cc_really_probe);
 
-int qcom_cc_probe(struct platform_device *pdev, const struct qcom_cc_desc *desc)
+int qcom_cc_probe(struct udevice *dev, const struct qcom_cc_desc *desc)
 {
 	struct regmap *regmap;
 
-	regmap = qcom_cc_map(pdev, desc);
+	regmap = qcom_cc_map(dev, desc);
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
-	return qcom_cc_really_probe(&pdev->dev, desc, regmap);
+	return qcom_cc_really_probe(dev, desc, regmap);
 }
 EXPORT_SYMBOL_GPL(qcom_cc_probe);
 
-int qcom_cc_probe_by_index(struct platform_device *pdev, int index,
-			   const struct qcom_cc_desc *desc)
-{
-	struct regmap *regmap;
-	void __iomem *base;
-
-	base = devm_platform_ioremap_resource(pdev, index);
-	if (IS_ERR(base))
-		return -ENOMEM;
-
-	regmap = devm_regmap_init_mmio(&pdev->dev, base, desc->config);
-	if (IS_ERR(regmap))
-		return PTR_ERR(regmap);
-
-	return qcom_cc_really_probe(&pdev->dev, desc, regmap);
-}
-EXPORT_SYMBOL_GPL(qcom_cc_probe_by_index);
-
-MODULE_LICENSE("GPL v2");
-MODULE_DESCRIPTION("QTI Common Clock module");
diff --git a/drivers/clk/qcom/ccf/common.h b/drivers/clk/qcom/ccf/common.h
index 953c91f7b145..6dc4ec3ea9d6 100644
--- a/drivers/clk/qcom/ccf/common.h
+++ b/drivers/clk/qcom/ccf/common.h
@@ -3,23 +3,41 @@
 
 #ifndef __QCOM_CLK_COMMON_H__
 #define __QCOM_CLK_COMMON_H__
 
+#include <linux/types.h>
+
 struct platform_device;
 struct regmap_config;
 struct clk_regmap;
 struct qcom_reset_map;
 struct regmap;
 struct freq_tbl;
 struct clk_hw;
+struct udevice;
 
 #define PLL_LOCK_COUNT_SHIFT	8
 #define PLL_LOCK_COUNT_MASK	0x3f
 #define PLL_BIAS_COUNT_SHIFT	14
 #define PLL_BIAS_COUNT_MASK	0x3f
 #define PLL_VOTE_FSM_ENA	BIT(20)
 #define PLL_VOTE_FSM_RESET	BIT(21)
 
+/* U-Boot compat */
+struct compat_regmap_config {
+	const char *name;
+
+	int reg_bits;
+	int reg_stride;
+	int reg_shift;
+	unsigned int reg_base;
+	int pad_bits;
+	int val_bits;
+
+	unsigned int max_register;
+	bool fast_io;
+};
+
 struct qcom_icc_hws_data {
 	int master_id;
 	int slave_id;
 	int clk_id;
@@ -31,13 +49,13 @@ struct qcom_cc_driver_data {
 	u32 *clk_cbcrs;
 	size_t num_clk_cbcrs;
 	const struct clk_rcg_dfs_data *dfs_rcgs;
 	size_t num_dfs_rcgs;
-	void (*clk_regs_configure)(struct device *dev, struct regmap *regmap);
+	void (*clk_regs_configure)(struct udevice *dev, struct regmap *regmap);
 };
 
 struct qcom_cc_desc {
-	const struct regmap_config *config;
+	const struct compat_regmap_config *config;
 	struct clk_regmap **clks;
 	size_t num_clks;
 	const struct qcom_reset_map *resets;
 	size_t num_resets;
@@ -74,19 +92,15 @@ extern int qcom_find_src_index(struct clk_hw *hw, const struct parent_map *map,
 			       u8 src);
 extern int qcom_find_cfg_index(struct clk_hw *hw, const struct parent_map *map,
 			       u8 cfg);
 
-extern int qcom_cc_register_board_clk(struct device *dev, const char *path,
+extern int qcom_cc_register_board_clk(struct udevice *dev, const char *path,
 				      const char *name, unsigned long rate);
-extern int qcom_cc_register_sleep_clk(struct device *dev);
+extern int qcom_cc_register_sleep_clk(struct udevice *dev);
 
-extern struct regmap *qcom_cc_map(struct platform_device *pdev,
-				  const struct qcom_cc_desc *desc);
-extern int qcom_cc_really_probe(struct device *dev,
-				const struct qcom_cc_desc *desc,
-				struct regmap *regmap);
-extern int qcom_cc_probe(struct platform_device *pdev,
-			 const struct qcom_cc_desc *desc);
-extern int qcom_cc_probe_by_index(struct platform_device *pdev, int index,
-				  const struct qcom_cc_desc *desc);
+extern struct regmap * qcom_cc_map(struct udevice *dev,
+				   const struct qcom_cc_desc *desc);
+int qcom_cc_probe(struct udevice *dev, const struct qcom_cc_desc *desc);
+int qcom_cc_really_probe(struct udevice *dev,
+			 const struct qcom_cc_desc *desc, struct regmap *regmap);
 
 #endif
diff --git a/drivers/clk/qcom/ccf/gdsc.c b/drivers/clk/qcom/ccf/gdsc.c
index 7deabf8400cf..5380bb479d6e 100644
--- a/drivers/clk/qcom/ccf/gdsc.c
+++ b/drivers/clk/qcom/ccf/gdsc.c
@@ -2,20 +2,22 @@
 /*
  * Copyright (c) 2015, 2017-2018, 2022, The Linux Foundation. All rights reserved.
  */
 
+#include <dm/device.h>
+#include <dm/device_compat.h>
+#include <dm/device-internal.h>
+#include <dm/ofnode.h>
 #include <linux/bitops.h>
+#include <linux/compat.h>
 #include <linux/delay.h>
 #include <linux/err.h>
-#include <linux/export.h>
-#include <linux/jiffies.h>
+#include <linux/bug.h>
 #include <linux/kernel.h>
-#include <linux/ktime.h>
-#include <linux/pm_domain.h>
 #include <linux/regmap.h>
-#include <linux/regulator/consumer.h>
-#include <linux/reset-controller.h>
-#include <linux/slab.h>
+#include <power/regulator.h>
+#include <power-domain-uclass.h>
+#include <reset-uclass.h>
 #include "gdsc.h"
 
 #define PWR_ON_MASK		BIT(31)
 #define EN_REST_WAIT_MASK	GENMASK_ULL(23, 20)
@@ -48,9 +50,9 @@
 
 #define STATUS_POLL_TIMEOUT_US	2000
 #define TIMEOUT_US		500
 
-#define domain_to_gdsc(domain) container_of(domain, struct gdsc, pd)
+#define domain_to_gdsc(domain) ((struct gdsc *)domain->priv)
 
 enum gdsc_status {
 	GDSC_OFF,
 	GDSC_ON
@@ -101,15 +103,15 @@ static int gdsc_hwctrl(struct gdsc *sc, bool en)
 }
 
 static int gdsc_poll_status(struct gdsc *sc, enum gdsc_status status)
 {
-	ktime_t start;
+	u64 timeout;
 
-	start = ktime_get();
+	timeout = timer_get_us() + STATUS_POLL_TIMEOUT_US;
 	do {
 		if (gdsc_check_status(sc, status))
 			return 0;
-	} while (ktime_us_delta(ktime_get(), start) < STATUS_POLL_TIMEOUT_US);
+	} while (timer_get_us() < timeout);
 
 	if (gdsc_check_status(sc, status))
 		return 0;
 
@@ -174,9 +176,9 @@ static int gdsc_toggle_logic(struct gdsc *sc, enum gdsc_status status,
 		udelay(1);
 	}
 
 	ret = gdsc_poll_status(sc, status);
-	WARN(ret, "%s status stuck at 'o%s'", sc->pd.name, status ? "ff" : "n");
+	WARN(ret, "%s status stuck at 'o%s'\n", sc->pd.name, status ? "ff" : "n");
 
 	if (!ret && status == GDSC_OFF && sc->rsupply) {
 		ret = regulator_disable(sc->rsupply);
 		if (ret < 0)
@@ -187,21 +189,23 @@ static int gdsc_toggle_logic(struct gdsc *sc, enum gdsc_status status,
 }
 
 static inline int gdsc_deassert_reset(struct gdsc *sc)
 {
-	int i;
+	debug("%s: %s: resets not yet supported!\n", sc->pd.name, __func__);
+	// int i;
 
-	for (i = 0; i < sc->reset_count; i++)
-		sc->rcdev->ops->deassert(sc->rcdev, sc->resets[i]);
+	// for (i = 0; i < sc->reset_count; i++)
+	// 	reset_deassert(sc->rcdev, sc->resets[i]);
 	return 0;
 }
 
 static inline int gdsc_assert_reset(struct gdsc *sc)
 {
-	int i;
+	debug("%s: %s: resets not yet supported!\n", sc->pd.name, __func__);
+	// int i;
 
-	for (i = 0; i < sc->reset_count; i++)
-		sc->rcdev->ops->assert(sc->rcdev, sc->resets[i]);
+	// for (i = 0; i < sc->reset_count; i++)
+	// 	reset_assert(sc->rcdev, sc->resets[i]);
 	return 0;
 }
 
 static inline void gdsc_force_mem_on(struct gdsc *sc)
@@ -255,11 +259,10 @@ static void gdsc_retain_ff_on(struct gdsc *sc)
 
 	regmap_update_bits(sc->regmap, sc->gdscr, mask, mask);
 }
 
-static int gdsc_enable(struct generic_pm_domain *domain)
+static int _gdsc_enable(struct gdsc *sc)
 {
-	struct gdsc *sc = domain_to_gdsc(domain);
 	int ret;
 
 	if (sc->pwrsts == PWRSTS_ON)
 		return gdsc_deassert_reset(sc);
@@ -313,9 +316,14 @@ static int gdsc_enable(struct generic_pm_domain *domain)
 
 	return 0;
 }
 
-static int gdsc_disable(struct generic_pm_domain *domain)
+static int gdsc_enable(struct power_domain *domain)
+{
+	return _gdsc_enable(domain_to_gdsc(domain));
+}
+
+static int gdsc_disable(struct power_domain *domain)
 {
 	struct gdsc *sc = domain_to_gdsc(domain);
 	int ret;
 
@@ -352,9 +360,9 @@ static int gdsc_disable(struct generic_pm_domain *domain)
 	 */
 	if (sc->pwrsts == PWRSTS_RET_ON)
 		return 0;
 
-	ret = gdsc_toggle_logic(sc, GDSC_OFF, domain->synced_poweroff);
+	ret = gdsc_toggle_logic(sc, GDSC_OFF, true);
 	if (ret)
 		return ret;
 
 	if (sc->flags & CLAMP_IO)
@@ -362,45 +370,8 @@ static int gdsc_disable(struct generic_pm_domain *domain)
 
 	return 0;
 }
 
-static int gdsc_set_hwmode(struct generic_pm_domain *domain, struct device *dev, bool mode)
-{
-	struct gdsc *sc = domain_to_gdsc(domain);
-	int ret;
-
-	ret = gdsc_hwctrl(sc, mode);
-	if (ret)
-		return ret;
-
-	/*
-	 * Wait for the GDSC to go through a power down and
-	 * up cycle. If we poll the status register before the
-	 * power cycle is finished we might read incorrect values.
-	 */
-	udelay(1);
-
-	/*
-	 * When the GDSC is switched to HW mode, HW can disable the GDSC.
-	 * When the GDSC is switched back to SW mode, the GDSC will be enabled
-	 * again, hence we need to poll for GDSC to complete the power up.
-	 */
-	if (!mode)
-		return gdsc_poll_status(sc, GDSC_ON);
-
-	return 0;
-}
-
-static bool gdsc_get_hwmode(struct generic_pm_domain *domain, struct device *dev)
-{
-	struct gdsc *sc = domain_to_gdsc(domain);
-	u32 val;
-
-	regmap_read(sc->regmap, sc->gdscr, &val);
-
-	return !!(val & HW_CONTROL_MASK);
-}
-
 static int gdsc_init(struct gdsc *sc)
 {
 	u32 mask, val;
 	int on, ret;
@@ -427,14 +398,14 @@ static int gdsc_init(struct gdsc *sc)
 	ret = regmap_update_bits(sc->regmap, sc->gdscr, mask, val);
 	if (ret)
 		return ret;
 
-	/* Force gdsc ON if only ON state is supported */
-	if (sc->pwrsts == PWRSTS_ON) {
-		ret = gdsc_toggle_logic(sc, GDSC_ON, false);
-		if (ret)
-			return ret;
-	}
+	// /* Force gdsc ON if only ON state is supported */
+	// if (sc->pwrsts == PWRSTS_ON) {
+	// 	ret = gdsc_toggle_logic(sc, GDSC_ON, false);
+	// 	if (ret)
+	// 		return ret;
+	// }
 
 	on = gdsc_check_status(sc, GDSC_ON);
 	if (on < 0)
 		return on;
@@ -473,31 +444,31 @@ static int gdsc_init(struct gdsc *sc)
 		}
 
 	} else if (sc->flags & ALWAYS_ON) {
 		/* If ALWAYS_ON GDSCs are not ON, turn them ON */
-		gdsc_enable(&sc->pd);
+		_gdsc_enable(sc);
 		on = true;
 	}
 
 	if (on || (sc->pwrsts & PWRSTS_RET))
 		gdsc_force_mem_on(sc);
 	else
 		gdsc_clear_mem_on(sc);
 
-	if (sc->flags & ALWAYS_ON)
-		sc->pd.flags |= GENPD_FLAG_ALWAYS_ON;
-	if (!sc->pd.power_off)
-		sc->pd.power_off = gdsc_disable;
-	if (!sc->pd.power_on)
-		sc->pd.power_on = gdsc_enable;
-	if (sc->flags & HW_CTRL_TRIGGER) {
-		sc->pd.set_hwmode_dev = gdsc_set_hwmode;
-		sc->pd.get_hwmode_dev = gdsc_get_hwmode;
-	}
+	// if (sc->flags & ALWAYS_ON)
+	// 	sc->pd.flags |= GENPD_FLAG_ALWAYS_ON;
+	// if (!sc->pd.power_off)
+	// 	sc->pd.power_off = gdsc_disable;
+	// if (!sc->pd.power_on)
+	// 	sc->pd.power_on = gdsc_enable;
+	// if (sc->flags & HW_CTRL_TRIGGER) {
+	// 	sc->pd.set_hwmode_dev = gdsc_set_hwmode;
+	// 	sc->pd.get_hwmode_dev = gdsc_get_hwmode;
+	// }
 
-	ret = pm_genpd_init(&sc->pd, NULL, !on);
-	if (ret)
-		goto err_disable_supply;
+	// ret = pm_genpd_init(&sc->pd, NULL, !on);
+	// if (ret)
+	// 	goto err_disable_supply;
 
 	return 0;
 
 err_disable_supply:
@@ -506,162 +477,69 @@ err_disable_supply:
 
 	return ret;
 }
 
-static int gdsc_add_subdomain_list(struct dev_pm_domain_list *pd_list,
-				   struct generic_pm_domain *subdomain)
+static int qcom_gdsc_of_xlate(struct power_domain *pd,
+			struct ofnode_phandle_args *args)
 {
-	int i, ret;
+	struct gdsc_desc *desc = (struct gdsc_desc *)dev_get_driver_data(pd->dev);
 
-	for (i = 0; i < pd_list->num_pds; i++) {
-		struct device *dev = pd_list->pd_devs[i];
-		struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
-
-		ret = pm_genpd_add_subdomain(genpd, subdomain);
-		if (ret)
-			return ret;
+	if (args->args_count != 1) {
+		debug("Invalid args_count: %d\n", args->args_count);
+		return -EINVAL;
 	}
 
+	pd->id = args->args[0];
+
+	if (pd->id > desc->num_gdscs) {
+		dev_err(pd->dev, "Invalid GDSC ID %ld\n", pd->id);
+		return -EINVAL;
+	}
+
+	/* Assign per-GDSC private data */
+	desc->gdsc[pd->id]->regmap = desc->regmap;
+	pd->priv = desc->gdsc[pd->id];
+
+	gdsc_init(desc->gdsc[pd->id]);
+
 	return 0;
 }
 
-static void gdsc_remove_subdomain_list(struct dev_pm_domain_list *pd_list,
-				       struct generic_pm_domain *subdomain)
+static const struct power_domain_ops qcom_gdsc_ops = {
+	.on = gdsc_enable,
+	.off = gdsc_disable,
+	.of_xlate = qcom_gdsc_of_xlate,
+};
+
+U_BOOT_DRIVER(qcom_gdsc) = {
+	.name = "qcom_gdsc",
+	.id = UCLASS_POWER_DOMAIN,
+	.ops = &qcom_gdsc_ops,
+	.flags = DM_FLAG_PRE_RELOC,
+};
+
+int gdsc_register(struct udevice *dev, struct gdsc **gdscs, int num_gdscs,
+		  struct regmap *regmap)
 {
-	int i;
+	int ret;
+	char *name;
+	struct gdsc_desc *desc;
 
-	for (i = 0; i < pd_list->num_pds; i++) {
-		struct device *dev = pd_list->pd_devs[i];
-		struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
-
-		pm_genpd_remove_subdomain(genpd, subdomain);
-	}
-}
-
-static void gdsc_pm_subdomain_remove(struct gdsc_desc *desc, size_t num)
-{
-	struct device *dev = desc->dev;
-	struct gdsc **scs = desc->scs;
-	int i;
-
-	/* Remove subdomains */
-	for (i = num - 1; i >= 0; i--) {
-		if (!scs[i])
-			continue;
-		if (scs[i]->parent)
-			pm_genpd_remove_subdomain(scs[i]->parent, &scs[i]->pd);
-		else if (!IS_ERR_OR_NULL(dev->pm_domain))
-			pm_genpd_remove_subdomain(pd_to_genpd(dev->pm_domain), &scs[i]->pd);
-		else if (desc->pd_list)
-			gdsc_remove_subdomain_list(desc->pd_list, &scs[i]->pd);
-	}
-}
-
-int gdsc_register(struct gdsc_desc *desc,
-		  struct reset_controller_dev *rcdev, struct regmap *regmap)
-{
-	int i, ret;
-	struct genpd_onecell_data *data;
-	struct device *dev = desc->dev;
-	struct gdsc **scs = desc->scs;
-	size_t num = desc->num;
-
-	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
-	if (!data)
+	desc = kzalloc(sizeof(*desc), GFP_KERNEL);
+	if (!desc)
 		return -ENOMEM;
 
-	data->domains = devm_kcalloc(dev, num, sizeof(*data->domains),
-				     GFP_KERNEL);
-	if (!data->domains)
+	desc->dev = dev;
+	desc->gdsc = gdscs;
+	desc->num_gdscs = num_gdscs;
+	desc->regmap = regmap;
+
+	name = kzalloc(64, GFP_KERNEL);
+	if (!name)
 		return -ENOMEM;
+	ret = snprintf(name, 64, "%s.%s", desc->dev->name, "gdsc");
+	if (ret < 0)
+		return ret;
 
-	for (i = 0; i < num; i++) {
-		if (!scs[i] || !scs[i]->supply)
-			continue;
-
-		scs[i]->rsupply = devm_regulator_get_optional(dev, scs[i]->supply);
-		if (IS_ERR(scs[i]->rsupply)) {
-			ret = PTR_ERR(scs[i]->rsupply);
-			if (ret != -ENODEV)
-				return ret;
-
-			scs[i]->rsupply = NULL;
-		}
-	}
-
-	data->num_domains = num;
-	for (i = 0; i < num; i++) {
-		if (!scs[i])
-			continue;
-		scs[i]->regmap = regmap;
-		scs[i]->rcdev = rcdev;
-		ret = gdsc_init(scs[i]);
-		if (ret)
-			return ret;
-		data->domains[i] = &scs[i]->pd;
-	}
-
-	/* Add subdomains */
-	for (i = 0; i < num; i++) {
-		if (!scs[i])
-			continue;
-		if (scs[i]->parent)
-			ret = pm_genpd_add_subdomain(scs[i]->parent, &scs[i]->pd);
-		else if (!IS_ERR_OR_NULL(dev->pm_domain))
-			ret = pm_genpd_add_subdomain(pd_to_genpd(dev->pm_domain), &scs[i]->pd);
-		else if (desc->pd_list)
-			ret = gdsc_add_subdomain_list(desc->pd_list, &scs[i]->pd);
-
-		if (ret)
-			goto err_pm_subdomain_remove;
-	}
-
-	return of_genpd_add_provider_onecell(dev->of_node, data);
-
-err_pm_subdomain_remove:
-	gdsc_pm_subdomain_remove(desc, i);
-
-	return ret;
+	return device_bind_with_driver_data(desc->dev, DM_DRIVER_REF(qcom_gdsc),
+					    strdup(name), (ulong)desc, dev_ofnode(dev), NULL);
 }
-
-void gdsc_unregister(struct gdsc_desc *desc)
-{
-	struct device *dev = desc->dev;
-	size_t num = desc->num;
-
-	gdsc_pm_subdomain_remove(desc, num);
-	of_genpd_del_provider(dev->of_node);
-}
-
-/*
- * On SDM845+ the GPU GX domain is *almost* entirely controlled by the GMU
- * running in the CX domain so the CPU doesn't need to know anything about the
- * GX domain EXCEPT....
- *
- * Hardware constraints dictate that the GX be powered down before the CX. If
- * the GMU crashes it could leave the GX on. In order to successfully bring back
- * the device the CPU needs to disable the GX headswitch. There being no sane
- * way to reach in and touch that register from deep inside the GPU driver we
- * need to set up the infrastructure to be able to ensure that the GPU can
- * ensure that the GX is off during this super special case. We do this by
- * defining a GX gdsc with a dummy enable function and a "default" disable
- * function.
- *
- * This allows us to attach with genpd_dev_pm_attach_by_name() in the GPU
- * driver. During power up, nothing will happen from the CPU (and the GMU will
- * power up normally but during power down this will ensure that the GX domain
- * is *really* off - this gives us a semi standard way of doing what we need.
- */
-int gdsc_gx_do_nothing_enable(struct generic_pm_domain *domain)
-{
-	struct gdsc *sc = domain_to_gdsc(domain);
-	int ret = 0;
-
-	/* Enable the parent supply, when controlled through the regulator framework. */
-	if (sc->rsupply)
-		ret = regulator_enable(sc->rsupply);
-
-	/* Do nothing with the GDSC itself */
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(gdsc_gx_do_nothing_enable);
diff --git a/drivers/clk/qcom/ccf/gdsc.h b/drivers/clk/qcom/ccf/gdsc.h
index dd843e86c05b..e37f5ddbc4d3 100644
--- a/drivers/clk/qcom/ccf/gdsc.h
+++ b/drivers/clk/qcom/ccf/gdsc.h
@@ -6,14 +6,18 @@
 #ifndef __QCOM_GDSC_H__
 #define __QCOM_GDSC_H__
 
 #include <linux/err.h>
-#include <linux/pm_domain.h>
+#include <power-domain.h>
 
 struct regmap;
-struct regulator;
 struct reset_controller_dev;
 
+/* Compat struct for Linux */
+struct compat_power_domain {
+	const char *name;
+};
+
 /**
  * struct gdsc - Globally Distributed Switch Controller
  * @pd: generic power domain
  * @regmap: regmap for MMIO accesses
@@ -31,10 +35,10 @@ struct reset_controller_dev;
  * @reset_count: number of @resets
  * @rcdev: reset controller
  */
 struct gdsc {
-	struct generic_pm_domain	pd;
-	struct generic_pm_domain	*parent;
+	struct compat_power_domain	pd;
+	struct power_domain	*parent;
 	struct regmap			*regmap;
 	unsigned int			gdscr;
 	unsigned int			collapse_ctrl;
 	unsigned int			collapse_mask;
@@ -67,28 +71,26 @@ struct gdsc {
 #define ALWAYS_ON	BIT(6)
 #define RETAIN_FF_ENABLE	BIT(7)
 #define NO_RET_PERIPH	BIT(8)
 #define HW_CTRL_TRIGGER	BIT(9)
-	struct reset_controller_dev	*rcdev;
+	struct reset_ctl		*rcdev;
 	unsigned int			*resets;
 	unsigned int			reset_count;
 
 	const char 			*supply;
-	struct regulator		*rsupply;
+	struct udevice			*rsupply;
 };
 
 struct gdsc_desc {
-	struct device *dev;
-	struct gdsc **scs;
-	size_t num;
-	struct dev_pm_domain_list *pd_list;
+	struct gdsc **gdsc;
+	int num_gdscs;
+	struct udevice *dev;
+	struct regmap *regmap;
 };
 
-#ifdef CONFIG_QCOM_GDSC
-int gdsc_register(struct gdsc_desc *desc, struct reset_controller_dev *,
-		  struct regmap *);
-void gdsc_unregister(struct gdsc_desc *desc);
-int gdsc_gx_do_nothing_enable(struct generic_pm_domain *domain);
+#ifdef CONFIG_CLK_QCOM
+int gdsc_register(struct udevice *dev, struct gdsc **gdscs, int num_gdscs,
+		  struct regmap *regmap);
 #else
 static inline int gdsc_register(struct gdsc_desc *desc,
 				struct reset_controller_dev *rcdev,
 				struct regmap *r)
diff --git a/drivers/clk/qcom/ccf/reset.c b/drivers/clk/qcom/ccf/reset.c
index d96c96a9089f..4abca7ad80b1 100644
--- a/drivers/clk/qcom/ccf/reset.c
+++ b/drivers/clk/qcom/ccf/reset.c
@@ -2,36 +2,29 @@
 /*
  * Copyright (c) 2013, The Linux Foundation. All rights reserved.
  */
 
+#include <dm/device.h>
+#include <dm/device-internal.h>
+#include <dm/device_compat.h>
 #include <linux/bitops.h>
-#include <linux/export.h>
 #include <linux/regmap.h>
-#include <linux/reset-controller.h>
+#include <reset-uclass.h>
 #include <linux/delay.h>
 
 #include "reset.h"
 
-static int qcom_reset(struct reset_controller_dev *rcdev, unsigned long id)
-{
-	struct qcom_reset_controller *rst = to_qcom_reset_controller(rcdev);
+#define to_qcom_reset_controller(r) \
+	(dev_get_priv((r)->dev))
 
-	rcdev->ops->assert(rcdev, id);
-	fsleep(rst->reset_map[id].udelay ?: 1); /* use 1 us as default */
-
-	rcdev->ops->deassert(rcdev, id);
-	return 0;
-}
-
-static int qcom_reset_set_assert(struct reset_controller_dev *rcdev,
-				 unsigned long id, bool assert)
+static int qcom_reset_set_assert(struct reset_ctl *rcdev, bool assert)
 {
 	struct qcom_reset_controller *rst;
 	const struct qcom_reset_map *map;
 	u32 mask;
 
 	rst = to_qcom_reset_controller(rcdev);
-	map = &rst->reset_map[id];
+	map = &rst->reset_map[rcdev->id];
 	mask = map->bitmask ? map->bitmask : BIT(map->bit);
 
 	regmap_update_bits(rst->regmap, map->reg, mask, assert ? mask : 0);
 
@@ -40,20 +33,80 @@ static int qcom_reset_set_assert(struct reset_controller_dev *rcdev,
 
 	return 0;
 }
 
-static int qcom_reset_assert(struct reset_controller_dev *rcdev, unsigned long id)
+static int qcom_reset_assert(struct reset_ctl *rcdev)
 {
-	return qcom_reset_set_assert(rcdev, id, true);
+	return qcom_reset_set_assert(rcdev, true);
 }
 
-static int qcom_reset_deassert(struct reset_controller_dev *rcdev, unsigned long id)
+static int qcom_reset_deassert(struct reset_ctl *rcdev)
 {
-	return qcom_reset_set_assert(rcdev, id, false);
+	return qcom_reset_set_assert(rcdev, false);
 }
 
-const struct reset_control_ops qcom_reset_ops = {
-	.reset = qcom_reset,
-	.assert = qcom_reset_assert,
-	.deassert = qcom_reset_deassert,
+static int qcom_reset_of_xlate(struct reset_ctl *rcdev,
+			struct ofnode_phandle_args *args)
+{
+	struct qcom_reset_controller *desc = dev_get_priv(rcdev->dev);
+
+	if (args->args_count != 1) {
+		debug("Invalid args_count: %d\n", args->args_count);
+		return -EINVAL;
+	}
+
+	rcdev->id = args->args[0];
+
+	if (rcdev->id > desc->nr_resets) {
+		dev_err(rcdev->dev, "Invalid GDSC ID %ld\n", rcdev->id);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static struct reset_ops qcom_reset_ops = {
+	.rst_assert = qcom_reset_assert,
+	.rst_deassert = qcom_reset_deassert,
+	.of_xlate = qcom_reset_of_xlate,
 };
-EXPORT_SYMBOL_GPL(qcom_reset_ops);
+
+U_BOOT_DRIVER(qcom_reset) = {
+	.name = "qcom_reset",
+	.id = UCLASS_RESET,
+	.ops = &qcom_reset_ops,
+	.flags = DM_FLAG_PRE_RELOC,
+};
+
+int qcom_reset_register(struct udevice *dev, const struct qcom_reset_map *reset_map,
+			int nr_resets, struct regmap *regmap)
+{
+	int ret;
+	char *name;
+	struct qcom_reset_controller *desc;
+	struct udevice *rst_dev;
+
+	desc = kzalloc(sizeof(*desc), GFP_KERNEL);
+	if (!desc)
+		return -ENOMEM;
+
+	desc->reset_map = reset_map;
+	desc->nr_resets = nr_resets;
+	desc->regmap = regmap;
+
+	name = kzalloc(64, GFP_KERNEL);
+	if (!name)
+		return -ENOMEM;
+	ret = snprintf(name, 64, "%s.%s", dev->name, "reset");
+	if (ret < 0)
+		return ret;
+
+	printf("%s: desc %p\n", __func__, desc);
+	ret = device_bind_with_driver_data(dev, DM_DRIVER_REF(qcom_reset),
+					    strdup(name), 0, dev_ofnode(dev), &rst_dev);
+	if (ret)
+		return ret;
+
+	dev_set_priv(rst_dev, desc);
+
+	return 0;
+}
diff --git a/drivers/clk/qcom/ccf/reset.h b/drivers/clk/qcom/ccf/reset.h
index fe0561bf53d4..5911b397e2dd 100644
--- a/drivers/clk/qcom/ccf/reset.h
+++ b/drivers/clk/qcom/ccf/reset.h
@@ -5,9 +5,9 @@
 
 #ifndef __QCOM_CLK_RESET_H__
 #define __QCOM_CLK_RESET_H__
 
-#include <linux/reset-controller.h>
+#include <reset.h>
 
 struct qcom_reset_map {
 	unsigned int reg;
 	u8 bit;
@@ -18,14 +18,12 @@ struct qcom_reset_map {
 struct regmap;
 
 struct qcom_reset_controller {
 	const struct qcom_reset_map *reset_map;
+	int nr_resets;
 	struct regmap *regmap;
-	struct reset_controller_dev rcdev;
 };
 
-#define to_qcom_reset_controller(r) \
-	container_of(r, struct qcom_reset_controller, rcdev);
-
-extern const struct reset_control_ops qcom_reset_ops;
+int qcom_reset_register(struct udevice *dev, const struct qcom_reset_map *reset_map,
+			int nr_resets, struct regmap *regmap);
 
 #endif

-- 
2.51.0

