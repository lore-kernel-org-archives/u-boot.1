Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 707D11098792
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 14:39:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 135B284101;
	Fri, 20 Mar 2026 15:38:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="dkS1SU/T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0C6083FFF; Fri, 20 Mar 2026 15:32:26 +0100 (CET)
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::b5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 037E583F9B
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 15:32:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kcxt@postmarketos.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1774017143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8TOdW1C2jzBT6E8bbI7bLvVyd00e6KNjwAOMN21XucM=;
 b=dkS1SU/TJMuWNVlRFSmhporbSgPM+ixlpNjfSqSY6RRHuiXyt13ERJi2/ETY8SdqjtFM6d
 zctJfENu+iJ2uo045S4Ydr9Gq+Cor4bHeRG2eBOAR1RyXkbTflZggsRKSPSEPVqNdcl61A
 ouwHY+T/XCGjrCK1feebWyFi7TSQsNqx2lojndaBttYMqQdEqbiEMmLus+6cQyhvgl5bTH
 nT5wn/XgkVc1jWBIr4UivEHFanvIYOIxNyrxUgxmlG4XaUwopjhrosyU3tt+/pzso3hZOD
 uyM4xco+6naG95Ybb0UWM8++XAxj9U9mZaTdKqvP85q3GHlBvzzBrKzWy0h92Q==
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
Subject: [PATCH RFC 38/40] clk/qcom/ccf: adapt clocks for U-Boot
Date: Fri, 20 Mar 2026 15:31:34 +0100
Message-ID: <20260320-casey-ccf-upstream-v1-38-5b654f4b6620@linaro.org>
In-Reply-To: <20260319-casey-ccf-upstream-v1-0-4df2ee2226da@linaro.org>
References: <20260319-casey-ccf-upstream-v1-0-4df2ee2226da@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=25560;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=+1Sy/P0C+qQKtMtZjcHJ+SAaw0wqFHyU8jnhpvW+H4g=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsy9kSte/cwu0teV/9Oq0FZ4s3fuy9Q5h1fm/zL9JOy/b
 NMOtUCPjlIWBkEOBlkxRRbxE8ssm9ZettfYvuACzBxWJpAhDFycAjCRY18YGRYtn8s+69O61bmP
 Ph78fmHdnoNaUw1mbmt/vlmKbf5z/1l3GP7whQjI8E9TD4h8vGy67YP8PzWun0+Lx53P/lwV+fj
 RTi4pAA==
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

Adapt the various clock type helpers to work with U-Boot CCF, these
changes are quite minor, predominantly just the superficial API
differences.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/clk/qcom/Kconfig                  |   1 +
 drivers/clk/qcom/ccf/Makefile             |  21 ++++
 drivers/clk/qcom/ccf/clk-alpha-pll.c      |   5 +-
 drivers/clk/qcom/ccf/clk-branch.c         |   7 +-
 drivers/clk/qcom/ccf/clk-branch.h         |   1 +
 drivers/clk/qcom/ccf/clk-rcg2.c           | 157 ++++++------------------------
 drivers/clk/qcom/ccf/clk-regmap-divider.c |   2 +-
 drivers/clk/qcom/ccf/clk-regmap-mux-div.c |   1 +
 drivers/clk/qcom/ccf/clk-regmap-mux.c     |   2 +-
 drivers/clk/qcom/ccf/clk-regmap-phy-mux.c |   2 +-
 drivers/clk/qcom/ccf/clk-regmap.c         |  10 +-
 drivers/clk/qcom/ccf/clk-regmap.h         |   2 +-
 drivers/clk/qcom/ccf/clk-rpmh.c           | 113 ++++++++++-----------
 13 files changed, 122 insertions(+), 202 deletions(-)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 8504ed5d6561..727ff7dec61d 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -2,8 +2,9 @@ if ARCH_SNAPDRAGON || ARCH_IPQ40XX
 
 config CLK_QCOM
 	bool
 	depends on CLK && DM_RESET && POWER_DOMAIN
+	select REGMAP if CLK_CCF_FULL
 	def_bool n
 
 menu "Qualcomm clock drivers"
 
diff --git a/drivers/clk/qcom/ccf/Makefile b/drivers/clk/qcom/ccf/Makefile
new file mode 100644
index 000000000000..1d8fcdd3667f
--- /dev/null
+++ b/drivers/clk/qcom/ccf/Makefile
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# (C) Copyright 2023 Linaro
+
+obj-y += common.o common-uboot.o
+obj-y += clk-regmap.o
+obj-y += clk-alpha-pll.o
+obj-y += clk-rcg2.o
+obj-y += clk-branch.o
+obj-y += clk-regmap-divider.o
+obj-y += clk-regmap-mux.o
+obj-y += clk-regmap-mux-div.o
+obj-y += clk-regmap-phy-mux.o
+obj-y += clk-rpmh.o
+obj-y += reset.o
+obj-y += gdsc.o
+
+obj-$(CONFIG_CLK_QCOM_SM8650) += gcc-sm8650.o \
+				 dispcc-sm8550.o \
+				 tcsrcc-sm8650.o
+
diff --git a/drivers/clk/qcom/ccf/clk-alpha-pll.c b/drivers/clk/qcom/ccf/clk-alpha-pll.c
index 6aeba40358c1..58a13521abc3 100644
--- a/drivers/clk/qcom/ccf/clk-alpha-pll.c
+++ b/drivers/clk/qcom/ccf/clk-alpha-pll.c
@@ -3,16 +3,19 @@
  * Copyright (c) 2015, 2018, The Linux Foundation. All rights reserved.
  * Copyright (c) 2021, 2023-2024, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
+#include <asm/io.h>
+#include <div64.h>
+#include <linux/bug.h>
 #include <linux/kernel.h>
-#include <linux/export.h>
 #include <linux/clk-provider.h>
 #include <linux/regmap.h>
 #include <linux/delay.h>
 
 #include "clk-alpha-pll.h"
 #include "common.h"
+#include "common-uboot.h"
 
 #define PLL_MODE(p)		((p)->offset + 0x0)
 # define PLL_OUTCTRL		BIT(0)
 # define PLL_BYPASSNL		BIT(1)
diff --git a/drivers/clk/qcom/ccf/clk-branch.c b/drivers/clk/qcom/ccf/clk-branch.c
index 444e7d8648d4..0b91a71289b2 100644
--- a/drivers/clk/qcom/ccf/clk-branch.c
+++ b/drivers/clk/qcom/ccf/clk-branch.c
@@ -3,13 +3,13 @@
  * Copyright (c) 2013, The Linux Foundation. All rights reserved.
  * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
+#include <linux/bug.h>
 #include <linux/kernel.h>
 #include <linux/bitops.h>
 #include <linux/err.h>
 #include <linux/delay.h>
-#include <linux/export.h>
 #include <linux/clk-provider.h>
 #include <linux/regmap.h>
 
 #include "clk-branch.h"
@@ -83,10 +83,13 @@ static int clk_branch_wait(const struct clk_branch *br, bool enabling,
 			if (check_halt(br, enabling))
 				return 0;
 			udelay(1);
 		}
-		WARN(1, "%s status stuck at 'o%s'", name,
+		WARN(1, "%s status stuck at 'o%s'\n", name,
 				enabling ? "ff" : "n");
+		u32 val;
+		regmap_read(br->clkr.regmap, br->halt_reg, &val);
+		printf("%s: halt_reg %#x val %#x\n", name, br->halt_reg, val);
 		return -EBUSY;
 	}
 	return 0;
 }
diff --git a/drivers/clk/qcom/ccf/clk-branch.h b/drivers/clk/qcom/ccf/clk-branch.h
index 6bc2ba2b5350..5cc5c2e9d165 100644
--- a/drivers/clk/qcom/ccf/clk-branch.h
+++ b/drivers/clk/qcom/ccf/clk-branch.h
@@ -5,8 +5,9 @@
 #define __QCOM_CLK_BRANCH_H__
 
 #include <linux/bitfield.h>
 #include <linux/clk-provider.h>
+#include <linux/regmap.h>
 
 #include "clk-regmap.h"
 
 /**
diff --git a/drivers/clk/qcom/ccf/clk-rcg2.c b/drivers/clk/qcom/ccf/clk-rcg2.c
index e18cb8807d73..2f60830fc302 100644
--- a/drivers/clk/qcom/ccf/clk-rcg2.c
+++ b/drivers/clk/qcom/ccf/clk-rcg2.c
@@ -2,27 +2,23 @@
 /*
  * Copyright (c) 2013, 2018, The Linux Foundation. All rights reserved.
  */
 
+#include <div64.h>
 #include <linux/kernel.h>
 #include <linux/bitops.h>
 #include <linux/err.h>
 #include <linux/bug.h>
-#include <linux/export.h>
-#include <linux/clk.h>
+#include <clk.h>
 #include <linux/clk-provider.h>
 #include <linux/delay.h>
 #include <linux/rational.h>
 #include <linux/regmap.h>
 #include <linux/math64.h>
-#include <linux/gcd.h>
-#include <linux/minmax.h>
-#include <linux/slab.h>
-
-#include <asm/div64.h>
 
 #include "clk-rcg.h"
 #include "common.h"
+#include "common-uboot.h"
 
 #define CMD_REG			0x0
 #define CMD_UPDATE		BIT(0)
 #define CMD_ROOT_EN		BIT(1)
@@ -132,9 +128,9 @@ static int update_config(struct clk_rcg2 *rcg)
 			return 0;
 		udelay(1);
 	}
 
-	WARN(1, "%s: rcg didn't update its configuration.", name);
+	WARN(1, "%s: rcg didn't update its configuration.\n", name);
 	return -EBUSY;
 }
 
 static int clk_rcg2_set_parent(struct clk_hw *hw, u8 index)
@@ -222,9 +218,11 @@ clk_rcg2_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 	u32 cfg;
 
 	regmap_read(rcg->clkr.regmap, RCG_CFG_OFFSET(rcg), &cfg);
 
-	return __clk_rcg2_recalc_rate(hw, parent_rate, cfg);
+	ulong rate = __clk_rcg2_recalc_rate(hw, parent_rate, cfg);
+	pr_debug("%s: %s: rate %lu parent_rate %lu\n", __func__, clk_hw_get_name(hw), rate, parent_rate);
+	return rate;
 }
 
 static int _freq_tbl_determine_rate(struct clk_hw *hw, const struct freq_tbl *f,
 				    struct clk_rate_request *req,
@@ -349,22 +347,31 @@ static int _freq_tbl_fm_determine_rate(struct clk_hw *hw, const struct freq_mult
 	struct clk_hw *p;
 	int index;
 
 	f = qcom_find_freq_multi(f, rate);
-	if (!f || !f->confs)
+	if (!f || !f->confs) {
+		dev_err(hw->clk->dev, "%s: couldn't match rate %lu\n", clk_hw_get_name(hw), rate);
 		return -EINVAL;
+	}
+
+	log_debug("%s: %s rate %lu table rate %lu\n", __func__,
+		clk_hw_get_name(hw), rate, f->freq);
 
 	conf = __clk_rcg2_select_conf(hw, f, rate);
 	if (IS_ERR(conf))
 		return PTR_ERR(conf);
 	index = qcom_find_src_index(hw, rcg->parent_map, conf->src);
-	if (index < 0)
+	if (index < 0) {
+		dev_err(hw->clk->dev, "Couldn't find index for src %#x: %d\n", conf->src, index);
 		return index;
+	}
 
 	clk_flags = clk_hw_get_flags(hw);
 	p = clk_hw_get_parent_by_index(hw, index);
-	if (!p)
+	if (!p) {
+		dev_err(hw->clk->dev, "%s: couldn't get parent index %d\n", clk_hw_get_name(hw), index);
 		return -EINVAL;
+	}
 
 	if (clk_flags & CLK_SET_RATE_PARENT) {
 		rate = f->freq;
 		if (conf->pre_div) {
@@ -1203,122 +1210,8 @@ const struct clk_ops clk_pixel_ops = {
 	.determine_rate = clk_pixel_determine_rate,
 };
 EXPORT_SYMBOL_GPL(clk_pixel_ops);
 
-static int clk_gfx3d_determine_rate(struct clk_hw *hw,
-				    struct clk_rate_request *req)
-{
-	struct clk_rate_request parent_req = { .min_rate = 0, .max_rate = ULONG_MAX };
-	struct clk_rcg2_gfx3d *cgfx = to_clk_rcg2_gfx3d(hw);
-	struct clk_hw *xo, *p0, *p1, *p2;
-	unsigned long p0_rate;
-	u8 mux_div = cgfx->div;
-	int ret;
-
-	p0 = cgfx->hws[0];
-	p1 = cgfx->hws[1];
-	p2 = cgfx->hws[2];
-	/*
-	 * This function does ping-pong the RCG between PLLs: if we don't
-	 * have at least one fixed PLL and two variable ones,
-	 * then it's not going to work correctly.
-	 */
-	if (WARN_ON(!p0 || !p1 || !p2))
-		return -EINVAL;
-
-	xo = clk_hw_get_parent_by_index(hw, 0);
-	if (req->rate == clk_hw_get_rate(xo)) {
-		req->best_parent_hw = xo;
-		return 0;
-	}
-
-	if (mux_div == 0)
-		mux_div = 1;
-
-	parent_req.rate = req->rate * mux_div;
-
-	/* This has to be a fixed rate PLL */
-	p0_rate = clk_hw_get_rate(p0);
-
-	if (parent_req.rate == p0_rate) {
-		req->rate = req->best_parent_rate = p0_rate;
-		req->best_parent_hw = p0;
-		return 0;
-	}
-
-	if (req->best_parent_hw == p0) {
-		/* Are we going back to a previously used rate? */
-		if (clk_hw_get_rate(p2) == parent_req.rate)
-			req->best_parent_hw = p2;
-		else
-			req->best_parent_hw = p1;
-	} else if (req->best_parent_hw == p2) {
-		req->best_parent_hw = p1;
-	} else {
-		req->best_parent_hw = p2;
-	}
-
-	clk_hw_get_rate_range(req->best_parent_hw,
-			      &parent_req.min_rate, &parent_req.max_rate);
-
-	if (req->min_rate > parent_req.min_rate)
-		parent_req.min_rate = req->min_rate;
-
-	if (req->max_rate < parent_req.max_rate)
-		parent_req.max_rate = req->max_rate;
-
-	ret = __clk_determine_rate(req->best_parent_hw, &parent_req);
-	if (ret)
-		return ret;
-
-	req->rate = req->best_parent_rate = parent_req.rate;
-	req->rate /= mux_div;
-
-	return 0;
-}
-
-static int clk_gfx3d_set_rate_and_parent(struct clk_hw *hw, unsigned long rate,
-		unsigned long parent_rate, u8 index)
-{
-	struct clk_rcg2_gfx3d *cgfx = to_clk_rcg2_gfx3d(hw);
-	struct clk_rcg2 *rcg = &cgfx->rcg;
-	u32 cfg;
-	int ret;
-
-	cfg = rcg->parent_map[index].cfg << CFG_SRC_SEL_SHIFT;
-	/* On some targets, the GFX3D RCG may need to divide PLL frequency */
-	if (cgfx->div > 1)
-		cfg |= ((2 * cgfx->div) - 1) << CFG_SRC_DIV_SHIFT;
-
-	ret = regmap_write(rcg->clkr.regmap, rcg->cmd_rcgr + CFG_REG, cfg);
-	if (ret)
-		return ret;
-
-	return update_config(rcg);
-}
-
-static int clk_gfx3d_set_rate(struct clk_hw *hw, unsigned long rate,
-			      unsigned long parent_rate)
-{
-	/*
-	 * We should never get here; clk_gfx3d_determine_rate() should always
-	 * make us use a different parent than what we're currently using, so
-	 * clk_gfx3d_set_rate_and_parent() should always be called.
-	 */
-	return 0;
-}
-
-const struct clk_ops clk_gfx3d_ops = {
-	.is_enabled = clk_rcg2_is_enabled,
-	.get_parent = clk_rcg2_get_parent,
-	.set_parent = clk_rcg2_set_parent,
-	.recalc_rate = clk_rcg2_recalc_rate,
-	.set_rate = clk_gfx3d_set_rate,
-	.set_rate_and_parent = clk_gfx3d_set_rate_and_parent,
-	.determine_rate = clk_gfx3d_determine_rate,
-};
-EXPORT_SYMBOL_GPL(clk_gfx3d_ops);
-
 static int clk_rcg2_set_force_enable(struct clk_hw *hw)
 {
 	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
 	const char *name = clk_hw_get_name(hw);
@@ -1372,8 +1265,11 @@ static int __clk_rcg2_shared_set_rate(struct clk_hw *hw, unsigned long rate,
 {
 	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
 	const struct freq_tbl *f;
 
+	log_debug("%s: %s rate %lu parent_rate %lu policy %sp\n", __func__,
+		clk_hw_get_name(hw), rate, parent_rate, policy == FLOOR ? "floor" : "ceil");
+
 	switch (policy) {
 	case FLOOR:
 		f = qcom_find_freq_floor(rcg->freq_tbl, rate);
 		break;
@@ -1383,8 +1279,15 @@ static int __clk_rcg2_shared_set_rate(struct clk_hw *hw, unsigned long rate,
 	default:
 		return -EINVAL;
 	}
 
+	if (!f) {
+		dev_err(hw->clk->dev, "%s: couldn't find frequency for rate %lu\n", clk_hw_get_name(hw), rate);
+		return -EINVAL;
+	}
+
+	log_debug("%s: found freq %p rate %lu\n", __func__, f, f ? f->freq : 10101010);
+
 	/*
 	 * In case clock is disabled, update the M, N and D registers, cache
 	 * the CFG value in parked_cfg and don't hit the update bit of CMD
 	 * register.
@@ -1447,8 +1350,10 @@ static int clk_rcg2_shared_enable(struct clk_hw *hw)
 static void clk_rcg2_shared_disable(struct clk_hw *hw)
 {
 	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
 
+	log_debug("%s: %s\n", __func__, clk_hw_get_name(hw));
+
 	/*
 	 * Store current configuration as switching to safe source would clear
 	 * the SRC and DIV of CFG register
 	 */
diff --git a/drivers/clk/qcom/ccf/clk-regmap-divider.c b/drivers/clk/qcom/ccf/clk-regmap-divider.c
index 4f5395f0ab6d..f37556d31f4e 100644
--- a/drivers/clk/qcom/ccf/clk-regmap-divider.c
+++ b/drivers/clk/qcom/ccf/clk-regmap-divider.c
@@ -2,12 +2,12 @@
 /*
  * Copyright (c) 2014, The Linux Foundation. All rights reserved.
  */
 
+#include <dm/ofnode.h>
 #include <linux/kernel.h>
 #include <linux/bitops.h>
 #include <linux/regmap.h>
-#include <linux/export.h>
 
 #include "clk-regmap-divider.h"
 
 static inline struct clk_regmap_div *to_clk_regmap_div(struct clk_hw *hw)
diff --git a/drivers/clk/qcom/ccf/clk-regmap-mux-div.c b/drivers/clk/qcom/ccf/clk-regmap-mux-div.c
index 6044839da85a..9c0eb8e1b8e2 100644
--- a/drivers/clk/qcom/ccf/clk-regmap-mux-div.c
+++ b/drivers/clk/qcom/ccf/clk-regmap-mux-div.c
@@ -3,8 +3,9 @@
  * Copyright (c) 2017, Linaro Limited
  * Author: Georgi Djakov <georgi.djakov@linaro.org>
  */
 
+#include <dm/ofnode.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/regmap.h>
diff --git a/drivers/clk/qcom/ccf/clk-regmap-mux.c b/drivers/clk/qcom/ccf/clk-regmap-mux.c
index 45d9cca28064..c6f95a3d4e5f 100644
--- a/drivers/clk/qcom/ccf/clk-regmap-mux.c
+++ b/drivers/clk/qcom/ccf/clk-regmap-mux.c
@@ -2,12 +2,12 @@
 /*
  * Copyright (c) 2014, The Linux Foundation. All rights reserved.
  */
 
+#include <dm/ofnode.h>
 #include <linux/kernel.h>
 #include <linux/bitops.h>
 #include <linux/regmap.h>
-#include <linux/export.h>
 
 #include "clk-regmap-mux.h"
 
 static inline struct clk_regmap_mux *to_clk_regmap_mux(struct clk_hw *hw)
diff --git a/drivers/clk/qcom/ccf/clk-regmap-phy-mux.c b/drivers/clk/qcom/ccf/clk-regmap-phy-mux.c
index 7b7243b7107d..04f79591aef4 100644
--- a/drivers/clk/qcom/ccf/clk-regmap-phy-mux.c
+++ b/drivers/clk/qcom/ccf/clk-regmap-phy-mux.c
@@ -2,12 +2,12 @@
 /*
  * Copyright (c) 2022, Linaro Ltd.
  */
 
+#include <linux/bug.h>
 #include <linux/clk-provider.h>
 #include <linux/bitfield.h>
 #include <linux/regmap.h>
-#include <linux/export.h>
 
 #include "clk-regmap.h"
 #include "clk-regmap-phy-mux.h"
 
diff --git a/drivers/clk/qcom/ccf/clk-regmap.c b/drivers/clk/qcom/ccf/clk-regmap.c
index 92ac4e0d7dbe..bc59b2456a3e 100644
--- a/drivers/clk/qcom/ccf/clk-regmap.c
+++ b/drivers/clk/qcom/ccf/clk-regmap.c
@@ -2,12 +2,13 @@
 /*
  * Copyright (c) 2014, The Linux Foundation. All rights reserved.
  */
 
+#include <dm/ofnode.h>
+#include <dm/device.h>
 #include <linux/device.h>
 #include <linux/clk-provider.h>
 #include <linux/regmap.h>
-#include <linux/export.h>
 
 #include "clk-regmap.h"
 
 /**
@@ -93,14 +94,11 @@ EXPORT_SYMBOL_GPL(clk_disable_regmap);
  * Clocks that use regmap for their register I/O should register their
  * clk_regmap struct via this function so that the regmap is initialized
  * and so that the clock is registered with the common clock framework.
  */
-int devm_clk_register_regmap(struct device *dev, struct clk_regmap *rclk)
+int devm_clk_register_regmap(struct udevice *dev, struct clk_regmap *rclk, struct regmap *regmap)
 {
-	if (dev && dev_get_regmap(dev, NULL))
-		rclk->regmap = dev_get_regmap(dev, NULL);
-	else if (dev && dev->parent)
-		rclk->regmap = dev_get_regmap(dev->parent, NULL);
+	rclk->regmap = regmap;
 
 	return devm_clk_hw_register(dev, &rclk->hw);
 }
 EXPORT_SYMBOL_GPL(devm_clk_register_regmap);
diff --git a/drivers/clk/qcom/ccf/clk-regmap.h b/drivers/clk/qcom/ccf/clk-regmap.h
index 14ec659a3a77..c23160f2b6e5 100644
--- a/drivers/clk/qcom/ccf/clk-regmap.h
+++ b/drivers/clk/qcom/ccf/clk-regmap.h
@@ -32,7 +32,7 @@ static inline struct clk_regmap *to_clk_regmap(struct clk_hw *hw)
 
 int clk_is_enabled_regmap(struct clk_hw *hw);
 int clk_enable_regmap(struct clk_hw *hw);
 void clk_disable_regmap(struct clk_hw *hw);
-int devm_clk_register_regmap(struct device *dev, struct clk_regmap *rclk);
+int devm_clk_register_regmap(struct udevice *dev, struct clk_regmap *rclk, struct regmap *regmap);
 
 #endif
diff --git a/drivers/clk/qcom/ccf/clk-rpmh.c b/drivers/clk/qcom/ccf/clk-rpmh.c
index 1a98b3a0c528..992e6a3da4f8 100644
--- a/drivers/clk/qcom/ccf/clk-rpmh.c
+++ b/drivers/clk/qcom/ccf/clk-rpmh.c
@@ -5,18 +5,16 @@
 
 #include <linux/clk-provider.h>
 #include <linux/err.h>
 #include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/of.h>
-#include <linux/platform_device.h>
-#include <linux/string_choices.h>
 #include <soc/qcom/cmd-db.h>
 #include <soc/qcom/rpmh.h>
 #include <soc/qcom/tcs.h>
 
 #include <dt-bindings/clock/qcom,rpmh.h>
 
+#include "common-uboot.h"
+
 #define CLK_RPMH_ARC_EN_OFFSET		0
 #define CLK_RPMH_VRM_EN_OFFSET		4
 
 /**
@@ -58,9 +56,9 @@ struct clk_rpmh {
 	u32 aggr_state;
 	u32 last_sent_aggr_state;
 	u32 valid_state_mask;
 	u32 unit;
-	struct device *dev;
+	struct udevice *dev;
 	struct clk_rpmh *peer;
 };
 
 struct clk_rpmh_desc {
@@ -69,9 +67,9 @@ struct clk_rpmh_desc {
 	/* RPMh clock clkaN are optional for this platform */
 	bool clka_optional;
 };
 
-static DEFINE_MUTEX(rpmh_clk_lock);
+// static DEFINE_MUTEX(rpmh_clk_lock);
 
 #define __DEFINE_CLK_RPMH(_name, _clk_name, _res_name,			\
 			  _res_en_offset, _res_on, _div)		\
 	static struct clk_rpmh clk_rpmh_##_clk_name##_ao;		\
@@ -309,8 +307,10 @@ static int clk_rpmh_bcm_set_rate(struct clk_hw *hw, unsigned long rate,
 				 unsigned long parent_rate)
 {
 	struct clk_rpmh *c = to_clk_rpmh(hw);
 
+	printf("%s: %s: rate %lu parent_rate %lu\n", __func__, clk_hw_get_name(hw), rate, parent_rate);
+
 	c->aggr_state = rate / c->unit;
 	/*
 	 * Since any non-zero value sent to hw would result in enabling the
 	 * clock, only send the value if the clock has already been prepared.
@@ -335,9 +335,9 @@ static unsigned long clk_rpmh_bcm_recalc_rate(struct clk_hw *hw,
 	return (unsigned long)c->aggr_state * c->unit;
 }
 
 static const struct clk_ops clk_rpmh_bcm_ops = {
-	.prepare	= clk_rpmh_bcm_prepare,
+	.enable	= clk_rpmh_bcm_prepare,
 	.unprepare	= clk_rpmh_bcm_unprepare,
 	.set_rate	= clk_rpmh_bcm_set_rate,
 	.determine_rate = clk_rpmh_determine_rate,
 	.recalc_rate	= clk_rpmh_bcm_recalc_rate,
@@ -900,9 +900,9 @@ static const struct clk_rpmh_desc clk_rpmh_glymur = {
 	.clks = glymur_rpmh_clocks,
 	.num_clks = ARRAY_SIZE(glymur_rpmh_clocks),
 };
 
-static struct clk_hw *of_clk_rpmh_hw_get(struct of_phandle_args *clkspec,
+static struct clk_hw *of_clk_rpmh_hw_get(struct ofnode_phandle_args *clkspec,
 					 void *data)
 {
 	struct clk_rpmh_desc *rpmh = data;
 	unsigned int idx = clkspec->args[0];
@@ -914,16 +914,16 @@ static struct clk_hw *of_clk_rpmh_hw_get(struct of_phandle_args *clkspec,
 
 	return rpmh->clks[idx];
 }
 
-static int clk_rpmh_probe(struct platform_device *pdev)
+static int clk_rpmh_probe(struct udevice *dev)
 {
 	struct clk_hw **hw_clks;
 	struct clk_rpmh *rpmh_clk;
 	const struct clk_rpmh_desc *desc;
 	int ret, i;
 
-	desc = of_device_get_match_data(&pdev->dev);
+	desc = (void *)dev_get_driver_data(dev);
 	if (!desc)
 		return -ENODEV;
 
 	hw_clks = desc->clks;
@@ -947,17 +947,17 @@ static int clk_rpmh_probe(struct platform_device *pdev)
 			if (desc->clka_optional &&
 			    !strncmp(rpmh_clk->res_name, "clka", sizeof("clka") - 1))
 				continue;
 
-			dev_err(&pdev->dev, "missing RPMh resource address for %s\n",
+			dev_err(dev, "missing RPMh resource address for %s\n",
 				rpmh_clk->res_name);
 			return -ENODEV;
 		}
 
 		data = cmd_db_read_aux_data(rpmh_clk->res_name, &aux_data_len);
 		if (IS_ERR(data)) {
 			ret = PTR_ERR(data);
-			dev_err(&pdev->dev,
+			dev_err(dev,
 				"error reading RPMh aux data for %s (%d)\n",
 				rpmh_clk->res_name, ret);
 			return ret;
 		}
@@ -966,78 +966,65 @@ static int clk_rpmh_probe(struct platform_device *pdev)
 		if (aux_data_len == sizeof(*data))
 			rpmh_clk->unit = le32_to_cpu(data->unit) * 1000ULL;
 
 		rpmh_clk->res_addr += res_addr;
-		rpmh_clk->dev = &pdev->dev;
+		rpmh_clk->dev = dev;
 
-		ret = devm_clk_hw_register(&pdev->dev, hw_clks[i]);
+		ret = devm_clk_hw_register(dev, hw_clks[i]);
 		if (ret) {
-			dev_err(&pdev->dev, "failed to register %s\n", name);
+			dev_err(dev, "failed to register %s\n", name);
 			return ret;
 		}
 	}
 
 	/* typecast to silence compiler warning */
-	ret = devm_of_clk_add_hw_provider(&pdev->dev, of_clk_rpmh_hw_get,
+	ret = devm_of_clk_add_hw_provider(dev, of_clk_rpmh_hw_get,
 					  (void *)desc);
 	if (ret) {
-		dev_err(&pdev->dev, "Failed to add clock provider\n");
+		dev_err(dev, "Failed to add clock provider\n");
 		return ret;
 	}
 
-	dev_dbg(&pdev->dev, "Registered RPMh clocks\n");
+	dev_dbg(dev, "Registered RPMh clocks\n");
 
 	return 0;
 }
 
-static const struct of_device_id clk_rpmh_match_table[] = {
-	{ .compatible = "qcom,glymur-rpmh-clk", .data = &clk_rpmh_glymur},
-	{ .compatible = "qcom,milos-rpmh-clk", .data = &clk_rpmh_milos},
-	{ .compatible = "qcom,qcs615-rpmh-clk", .data = &clk_rpmh_qcs615},
-	{ .compatible = "qcom,qdu1000-rpmh-clk", .data = &clk_rpmh_qdu1000},
-	{ .compatible = "qcom,sa8775p-rpmh-clk", .data = &clk_rpmh_sa8775p},
-	{ .compatible = "qcom,sar2130p-rpmh-clk", .data = &clk_rpmh_sar2130p},
-	{ .compatible = "qcom,sc7180-rpmh-clk", .data = &clk_rpmh_sc7180},
-	{ .compatible = "qcom,sc7280-rpmh-clk", .data = &clk_rpmh_sc7280},
-	{ .compatible = "qcom,sc8180x-rpmh-clk", .data = &clk_rpmh_sc8180x},
-	{ .compatible = "qcom,sc8280xp-rpmh-clk", .data = &clk_rpmh_sc8280xp},
-	{ .compatible = "qcom,sdm845-rpmh-clk", .data = &clk_rpmh_sdm845},
-	{ .compatible = "qcom,sdm670-rpmh-clk", .data = &clk_rpmh_sdm670},
-	{ .compatible = "qcom,sdx55-rpmh-clk",  .data = &clk_rpmh_sdx55},
-	{ .compatible = "qcom,sdx65-rpmh-clk",  .data = &clk_rpmh_sdx65},
-	{ .compatible = "qcom,sdx75-rpmh-clk",  .data = &clk_rpmh_sdx75},
-	{ .compatible = "qcom,sm4450-rpmh-clk", .data = &clk_rpmh_sm4450},
-	{ .compatible = "qcom,sm6350-rpmh-clk", .data = &clk_rpmh_sm6350},
-	{ .compatible = "qcom,sm8150-rpmh-clk", .data = &clk_rpmh_sm8150},
-	{ .compatible = "qcom,sm8250-rpmh-clk", .data = &clk_rpmh_sm8250},
-	{ .compatible = "qcom,sm8350-rpmh-clk", .data = &clk_rpmh_sm8350},
-	{ .compatible = "qcom,sm8450-rpmh-clk", .data = &clk_rpmh_sm8450},
-	{ .compatible = "qcom,sm8550-rpmh-clk", .data = &clk_rpmh_sm8550},
-	{ .compatible = "qcom,sm8650-rpmh-clk", .data = &clk_rpmh_sm8650},
-	{ .compatible = "qcom,sm8750-rpmh-clk", .data = &clk_rpmh_sm8750},
-	{ .compatible = "qcom,x1e80100-rpmh-clk", .data = &clk_rpmh_x1e80100},
+static const struct udevice_id clk_rpmh_match_table[] = {
+	{ .compatible = "qcom,glymur-rpmh-clk", .data = (ulong)&clk_rpmh_glymur},
+	{ .compatible = "qcom,milos-rpmh-clk", .data = (ulong)&clk_rpmh_milos},
+	{ .compatible = "qcom,qcs615-rpmh-clk", .data = (ulong)&clk_rpmh_qcs615},
+	{ .compatible = "qcom,qdu1000-rpmh-clk", .data = (ulong)&clk_rpmh_qdu1000},
+	{ .compatible = "qcom,sa8775p-rpmh-clk", .data = (ulong)&clk_rpmh_sa8775p},
+	{ .compatible = "qcom,sar2130p-rpmh-clk", .data = (ulong)&clk_rpmh_sar2130p},
+	{ .compatible = "qcom,sc7180-rpmh-clk", .data = (ulong)&clk_rpmh_sc7180},
+	{ .compatible = "qcom,sc7280-rpmh-clk", .data = (ulong)&clk_rpmh_sc7280},
+	{ .compatible = "qcom,sc8180x-rpmh-clk", .data = (ulong)&clk_rpmh_sc8180x},
+	{ .compatible = "qcom,sc8280xp-rpmh-clk", .data = (ulong)&clk_rpmh_sc8280xp},
+	{ .compatible = "qcom,sdm845-rpmh-clk", .data = (ulong)&clk_rpmh_sdm845},
+	{ .compatible = "qcom,sdm670-rpmh-clk", .data = (ulong)&clk_rpmh_sdm670},
+	{ .compatible = "qcom,sdx55-rpmh-clk",  .data = (ulong)&clk_rpmh_sdx55},
+	{ .compatible = "qcom,sdx65-rpmh-clk",  .data = (ulong)&clk_rpmh_sdx65},
+	{ .compatible = "qcom,sdx75-rpmh-clk",  .data = (ulong)&clk_rpmh_sdx75},
+	{ .compatible = "qcom,sm4450-rpmh-clk", .data = (ulong)&clk_rpmh_sm4450},
+	{ .compatible = "qcom,sm6350-rpmh-clk", .data = (ulong)&clk_rpmh_sm6350},
+	{ .compatible = "qcom,sm8150-rpmh-clk", .data = (ulong)&clk_rpmh_sm8150},
+	{ .compatible = "qcom,sm8250-rpmh-clk", .data = (ulong)&clk_rpmh_sm8250},
+	{ .compatible = "qcom,sm8350-rpmh-clk", .data = (ulong)&clk_rpmh_sm8350},
+	{ .compatible = "qcom,sm8450-rpmh-clk", .data = (ulong)&clk_rpmh_sm8450},
+	{ .compatible = "qcom,sm8550-rpmh-clk", .data = (ulong)&clk_rpmh_sm8550},
+	{ .compatible = "qcom,sm8650-rpmh-clk", .data = (ulong)&clk_rpmh_sm8650},
+	{ .compatible = "qcom,sm8750-rpmh-clk", .data = (ulong)&clk_rpmh_sm8750},
+	{ .compatible = "qcom,x1e80100-rpmh-clk", .data = (ulong)&clk_rpmh_x1e80100},
 	{ }
 };
-MODULE_DEVICE_TABLE(of, clk_rpmh_match_table);
 
-static struct platform_driver clk_rpmh_driver = {
-	.probe		= clk_rpmh_probe,
-	.driver		= {
-		.name	= "clk-rpmh",
-		.of_match_table = clk_rpmh_match_table,
-	},
+U_BOOT_DRIVER(clk_rpmh) = {
+	.name = "clk-rpmh",
+	.id = UCLASS_NOP,
+	.probe = clk_rpmh_probe,
+	.of_match = clk_rpmh_match_table,
+	.flags = DM_FLAG_DEFAULT_PD_CTRL_OFF,
 };
 
-static int __init clk_rpmh_init(void)
-{
-	return platform_driver_register(&clk_rpmh_driver);
-}
-core_initcall(clk_rpmh_init);
-
-static void __exit clk_rpmh_exit(void)
-{
-	platform_driver_unregister(&clk_rpmh_driver);
-}
-module_exit(clk_rpmh_exit);
-
 MODULE_DESCRIPTION("QCOM RPMh Clock Driver");
 MODULE_LICENSE("GPL v2");

-- 
2.51.0

