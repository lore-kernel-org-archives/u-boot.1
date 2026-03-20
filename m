Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E27B9109878D
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 14:39:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E925083FED;
	Fri, 20 Mar 2026 15:38:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="iwWS/ZgX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10EEE84011; Fri, 20 Mar 2026 15:32:31 +0100 (CET)
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::bc])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4B8F83F9B
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 15:32:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kcxt@postmarketos.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1774017146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=weSPvnlFN7Yu4cT1Pa3sLqYUm5TjL7hDirTxCrx2YtE=;
 b=iwWS/ZgXOWCCPek4rV9SCJ2psNx3ONDN6CYls1UB6KPqh1Z2siew3lSeAl6gm3Y1FFXaHa
 IA8R+9qpJtrgjG/ZOoRkp+VK5oWE7Zp9Gx5YzZmcKCGqnzMuLcQFpOAJEQMmbn1c8k6YKi
 S4QX+RKyamzpwUjgsLuaA0vfOs+SBZ+/OWaD2BUgsa5J2xyh3+gMJnXIhhrmTyIU5B9c5I
 P8M07CrSSAC5VLzdcCLScq1s9NFXbBiYjbYMJ8RLdoLRil7US9/lPlxklgNHn1ePWl/RKZ
 yEzJDWM8XH/fPkVkqSHmTLe2+ZVt9REGQEMR1RRD0LWaUO9XFZXenvGWLYjaTQ==
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
Subject: [PATCH RFC 39/40] clk/qcom/ccf: adjust sm8650 clock drivers for U-Boot
Date: Fri, 20 Mar 2026 15:31:35 +0100
Message-ID: <20260320-casey-ccf-upstream-v1-39-5b654f4b6620@linaro.org>
In-Reply-To: <20260319-casey-ccf-upstream-v1-0-4df2ee2226da@linaro.org>
References: <20260319-casey-ccf-upstream-v1-0-4df2ee2226da@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=11319;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=vE0XNJM5nt5GyPeoOy46y6MJhG+09nxhrsrneumuPd0=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsy9kSvNZvq/uMOX7PCvTvjSz9P7u7b8ixd4tEdWo0jjn
 87f/bF8HaUsDIIcDLJiiiziJ5ZZNq29bK+xfcEFmDmsTCBDGLg4BWAi12oZ/uns5tycGL9nTtgU
 z8ONLSdV4752JfvM8f0vNP3REiXXRxUM/9OEdT+HJgZ4L7O/M/3x50c5x9yr70bK7TATS/twair
 f3BcA
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

Make the necessary changes for the gcc, dispcc, and tcsrcc clocks on
SM8650 to work correctly in U-Boot, this basically just consists of
adding a U_BOOT_DRIVER definition and adjusting a few types.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/clk/qcom/ccf/dispcc-sm8550.c | 51 ++++++++++++++++--------------------
 drivers/clk/qcom/ccf/gcc-sm8650.c    | 50 +++++++++++++++++------------------
 drivers/clk/qcom/ccf/tcsrcc-sm8650.c | 36 +++++++------------------
 3 files changed, 56 insertions(+), 81 deletions(-)

diff --git a/drivers/clk/qcom/ccf/dispcc-sm8550.c b/drivers/clk/qcom/ccf/dispcc-sm8550.c
index f27140c649f5..46fb0abbdd01 100644
--- a/drivers/clk/qcom/ccf/dispcc-sm8550.c
+++ b/drivers/clk/qcom/ccf/dispcc-sm8550.c
@@ -3,30 +3,27 @@
  * Copyright (c) 2021, The Linux Foundation. All rights reserved.
  * Copyright (c) 2023, Linaro Ltd.
  */
 
+#include <dm/device.h>
 #include <linux/clk-provider.h>
 #include <linux/err.h>
 #include <linux/kernel.h>
-#include <linux/mod_devicetable.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
 #include <linux/regmap.h>
-#include <linux/pm_runtime.h>
 
 #include <dt-bindings/clock/qcom,sm8550-dispcc.h>
 
 #include "common.h"
 #include "clk-alpha-pll.h"
 #include "clk-branch.h"
-#include "clk-pll.h"
 #include "clk-rcg.h"
 #include "clk-regmap.h"
 #include "clk-regmap-divider.h"
-#include "clk-regmap-mux.h"
 #include "reset.h"
 #include "gdsc.h"
 
+#include "common-uboot.h"
+
 /* Need to match the order of clocks in DT binding */
 enum {
 	DT_BI_TCXO,
 	DT_BI_TCXO_AO,
@@ -1736,9 +1733,9 @@ static struct gdsc *disp_cc_sm8550_gdscs[] = {
 	[MDSS_GDSC] = &mdss_gdsc,
 	[MDSS_INT2_GDSC] = &mdss_int2_gdsc,
 };
 
-static const struct regmap_config disp_cc_sm8550_regmap_config = {
+static const struct compat_regmap_config disp_cc_sm8550_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
 	.max_register = 0x11008,
@@ -1754,41 +1751,38 @@ static const struct qcom_cc_desc disp_cc_sm8550_desc = {
 	.gdscs = disp_cc_sm8550_gdscs,
 	.num_gdscs = ARRAY_SIZE(disp_cc_sm8550_gdscs),
 };
 
-static const struct of_device_id disp_cc_sm8550_match_table[] = {
+static const struct udevice_id disp_cc_sm8550_match_table[] = {
 	{ .compatible = "qcom,sar2130p-dispcc" },
 	{ .compatible = "qcom,sm8550-dispcc" },
 	{ .compatible = "qcom,sm8650-dispcc" },
 	{ }
 };
-MODULE_DEVICE_TABLE(of, disp_cc_sm8550_match_table);
 
-static int disp_cc_sm8550_probe(struct platform_device *pdev)
+static int dispcc_sm8650_bind(struct udevice *dev)
+{
+	dev->driver_data = (ulong)&disp_cc_sm8550_desc;
+	return qcom_cc_bind_pd_reset(dev);
+}
+
+static int disp_cc_sm8550_probe(struct udevice *dev)
 {
 	struct regmap *regmap;
 	int ret;
 
-	ret = devm_pm_runtime_enable(&pdev->dev);
-	if (ret)
-		return ret;
-
-	ret = pm_runtime_resume_and_get(&pdev->dev);
-	if (ret)
-		return ret;
-
-	regmap = qcom_cc_map(pdev, &disp_cc_sm8550_desc);
+	regmap = qcom_cc_map(dev, &disp_cc_sm8550_desc);
 	if (IS_ERR(regmap)) {
 		ret = PTR_ERR(regmap);
 		goto err_put_rpm;
 	}
 
-	if (of_device_is_compatible(pdev->dev.of_node, "qcom,sm8650-dispcc")) {
+	if (ofnode_device_is_compatible(dev_ofnode(dev), "qcom,sm8650-dispcc")) {
 		lucid_ole_vco[0].max_freq = 2100000000;
 		disp_cc_mdss_mdp_clk_src.freq_tbl = ftbl_disp_cc_mdss_mdp_clk_src_sm8650;
 		disp_cc_mdss_dptx1_usb_router_link_intf_clk.clkr.hw.init->parent_hws[0] =
 			&disp_cc_mdss_dptx1_link_div_clk_src.clkr.hw;
-	} else if (of_device_is_compatible(pdev->dev.of_node, "qcom,sar2130p-dispcc")) {
+	} else if (ofnode_device_is_compatible(dev_ofnode(dev), "qcom,sar2130p-dispcc")) {
 		disp_cc_pll0_config.l = 0x1f;
 		disp_cc_pll0_config.alpha = 0x4000;
 		disp_cc_pll0_config.user_ctl_val = 0x1;
 		disp_cc_pll1_config.user_ctl_val = 0x1;
@@ -1803,9 +1797,9 @@ static int disp_cc_sm8550_probe(struct platform_device *pdev)
 
 	/* Keep some clocks always-on */
 	qcom_branch_set_clk_en(regmap, 0xe054); /* DISP_CC_XO_CLK */
 
-	ret = qcom_cc_really_probe(&pdev->dev, &disp_cc_sm8550_desc, regmap);
+	ret = qcom_cc_really_probe(dev, &disp_cc_sm8550_desc, regmap);
 	if (ret)
 		goto err_put_rpm;
 
 	pm_runtime_put(&pdev->dev);
@@ -1817,16 +1811,15 @@ err_put_rpm:
 
 	return ret;
 }
 
-static struct platform_driver disp_cc_sm8550_driver = {
+U_BOOT_DRIVER(dispcc_sm8650) = {
+	.name = "dispcc-sm8650",
+	.id = UCLASS_NOP,
+	.bind = dispcc_sm8650_bind,
 	.probe = disp_cc_sm8550_probe,
-	.driver = {
-		.name = "disp_cc-sm8550",
-		.of_match_table = disp_cc_sm8550_match_table,
-	},
+	.of_match = disp_cc_sm8550_match_table,
+	// .flags = DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
 };
 
-module_platform_driver(disp_cc_sm8550_driver);
-
 MODULE_DESCRIPTION("QTI DISPCC SM8550 / SM8650  Driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/qcom/ccf/gcc-sm8650.c b/drivers/clk/qcom/ccf/gcc-sm8650.c
index 9067bd05f8f7..0e09987ccb11 100644
--- a/drivers/clk/qcom/ccf/gcc-sm8650.c
+++ b/drivers/clk/qcom/ccf/gcc-sm8650.c
@@ -9,8 +9,10 @@
 #include <linux/regmap.h>
 
 #include <dt-bindings/clock/qcom,sm8650-gcc.h>
 
+#include "common-uboot.h"
+
 #include "clk-alpha-pll.h"
 #include "clk-branch.h"
 #include "clk-rcg.h"
 #include "clk-regmap.h"
@@ -1198,9 +1200,9 @@ static struct clk_rcg2 gcc_qupv3_wrap2_s6_clk_src = {
 static struct clk_init_data gcc_qupv3_wrap2_s7_clk_src_init = {
 	.name = "gcc_qupv3_wrap2_s7_clk_src",
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-	.flags = CLK_SET_RATE_PARENT,
+	.flags = CLK_SET_RATE_PARENT | CLK_REGISTER_PRE_RELOC,
 	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap2_s7_clk_src = {
@@ -2812,9 +2814,9 @@ static struct clk_branch gcc_qupv3_wrap2_s7_clk = {
 			.parent_hws = (const struct clk_hw*[]) {
 				&gcc_qupv3_wrap2_s7_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
+			.flags = CLK_SET_RATE_PARENT | CLK_REGISTER_PRE_RELOC,
 			.ops = &clk_branch2_ops,
 		},
 	},
 };
@@ -3766,9 +3768,9 @@ static struct gdsc *gcc_sm8650_gdscs[] = {
 	[USB30_PRIM_GDSC] = &usb30_prim_gdsc,
 	[USB3_PHY_GDSC] = &usb3_phy_gdsc,
 };
 
-static const struct regmap_config gcc_sm8650_regmap_config = {
+static const struct compat_regmap_config gcc_sm8650_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
 	.max_register = 0x1f41f0,
@@ -3784,20 +3786,27 @@ static const struct qcom_cc_desc gcc_sm8650_desc = {
 	.gdscs = gcc_sm8650_gdscs,
 	.num_gdscs = ARRAY_SIZE(gcc_sm8650_gdscs),
 };
 
-static const struct of_device_id gcc_sm8650_match_table[] = {
-	{ .compatible = "qcom,sm8650-gcc" },
+static const struct udevice_id gcc_sm8650_match_table[] = {
+	{
+		.compatible = "qcom,sm8650-gcc",
+		.data = (ulong)&gcc_sm8650_desc,
+	},
 	{ }
 };
-MODULE_DEVICE_TABLE(of, gcc_sm8650_match_table);
 
-static int gcc_sm8650_probe(struct platform_device *pdev)
+static int gcc_sm8650_bind(struct udevice *dev)
+{
+	return qcom_cc_bind_pd_reset(dev);
+}
+
+static int gcc_sm8650_probe(struct udevice *dev)
 {
 	struct regmap *regmap;
 	int ret;
 
-	regmap = qcom_cc_map(pdev, &gcc_sm8650_desc);
+	regmap = qcom_cc_map(dev, (struct qcom_cc_desc *)dev_get_driver_data(dev));
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
 	ret = qcom_cc_register_rcg_dfs(regmap, gcc_dfs_clocks,
@@ -3820,29 +3829,18 @@ static int gcc_sm8650_probe(struct platform_device *pdev)
 
 	/* Clear GDSC_SLEEP_ENA_VOTE to stop votes being auto-removed in sleep. */
 	regmap_write(regmap, 0x52150, 0x0);
 
-	return qcom_cc_really_probe(&pdev->dev, &gcc_sm8650_desc, regmap);
+	return qcom_cc_really_probe(dev, &gcc_sm8650_desc, regmap);
 }
 
-static struct platform_driver gcc_sm8650_driver = {
+U_BOOT_DRIVER(gcc_sm8650) = {
+	.name = "gcc-sm8650",
+	.id = UCLASS_NOP,
+	.bind = gcc_sm8650_bind,
 	.probe = gcc_sm8650_probe,
-	.driver = {
-		.name = "gcc-sm8650",
-		.of_match_table = gcc_sm8650_match_table,
-	},
+	.of_match = gcc_sm8650_match_table,
+	.flags = DM_FLAG_DEFAULT_PD_CTRL_OFF,
 };
 
-static int __init gcc_sm8650_init(void)
-{
-	return platform_driver_register(&gcc_sm8650_driver);
-}
-subsys_initcall(gcc_sm8650_init);
-
-static void __exit gcc_sm8650_exit(void)
-{
-	platform_driver_unregister(&gcc_sm8650_driver);
-}
-module_exit(gcc_sm8650_exit);
-
 MODULE_DESCRIPTION("QTI GCC SM8650 Driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/qcom/ccf/tcsrcc-sm8650.c b/drivers/clk/qcom/ccf/tcsrcc-sm8650.c
index 3685dcde9a4b..3f158a923203 100644
--- a/drivers/clk/qcom/ccf/tcsrcc-sm8650.c
+++ b/drivers/clk/qcom/ccf/tcsrcc-sm8650.c
@@ -5,11 +5,8 @@
  * Copyright (c) 2023, Linaro Limited
  */
 
 #include <linux/clk-provider.h>
-#include <linux/mod_devicetable.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
 #include <linux/regmap.h>
 
 #include <dt-bindings/clock/qcom,sm8650-tcsr.h>
 
@@ -132,9 +129,9 @@ static struct clk_regmap *tcsr_cc_sm8650_clocks[] = {
 	[TCSR_USB2_CLKREF_EN] = &tcsr_usb2_clkref_en.clkr,
 	[TCSR_USB3_CLKREF_EN] = &tcsr_usb3_clkref_en.clkr,
 };
 
-static const struct regmap_config tcsr_cc_sm8650_regmap_config = {
+static const struct compat_regmap_config tcsr_cc_sm8650_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
 	.max_register = 0x3b000,
@@ -146,45 +143,32 @@ static const struct qcom_cc_desc tcsr_cc_sm8650_desc = {
 	.clks = tcsr_cc_sm8650_clocks,
 	.num_clks = ARRAY_SIZE(tcsr_cc_sm8650_clocks),
 };
 
-static const struct of_device_id tcsr_cc_sm8650_match_table[] = {
+static const struct udevice_id tcsr_cc_sm8650_match_table[] = {
 	{ .compatible = "qcom,milos-tcsr" },
 	{ .compatible = "qcom,sm8650-tcsr" },
 	{ }
 };
-MODULE_DEVICE_TABLE(of, tcsr_cc_sm8650_match_table);
 
-static int tcsr_cc_sm8650_probe(struct platform_device *pdev)
+static int tcsr_cc_sm8650_probe(struct udevice *dev)
 {
-	if (of_device_is_compatible(pdev->dev.of_node, "qcom,milos-tcsr")) {
+	if (ofnode_device_is_compatible(dev_ofnode(dev), "qcom,milos-tcsr")) {
 		tcsr_ufs_clkref_en.halt_reg = 0x31118;
 		tcsr_ufs_clkref_en.clkr.enable_reg = 0x31118;
 		tcsr_cc_sm8650_clocks[TCSR_USB2_CLKREF_EN] = NULL;
 		tcsr_cc_sm8650_clocks[TCSR_USB3_CLKREF_EN] = NULL;
 	}
 
-	return qcom_cc_probe(pdev, &tcsr_cc_sm8650_desc);
+	return qcom_cc_probe(dev, &tcsr_cc_sm8650_desc);
 }
 
-static struct platform_driver tcsr_cc_sm8650_driver = {
+U_BOOT_DRIVER(tcsrcc_sm8650) = {
+	.name = "tcsr_cc-sm8650",
+	.id = UCLASS_NOP,
 	.probe = tcsr_cc_sm8650_probe,
-	.driver = {
-		.name = "tcsr_cc-sm8650",
-		.of_match_table = tcsr_cc_sm8650_match_table,
-	},
+	.of_match = tcsr_cc_sm8650_match_table,
+	.flags = DM_FLAG_DEFAULT_PD_CTRL_OFF,
 };
 
-static int __init tcsr_cc_sm8650_init(void)
-{
-	return platform_driver_register(&tcsr_cc_sm8650_driver);
-}
-subsys_initcall(tcsr_cc_sm8650_init);
-
-static void __exit tcsr_cc_sm8650_exit(void)
-{
-	platform_driver_unregister(&tcsr_cc_sm8650_driver);
-}
-module_exit(tcsr_cc_sm8650_exit);
-
 MODULE_DESCRIPTION("QTI TCSRCC SM8650 Driver");
 MODULE_LICENSE("GPL");

-- 
2.51.0

