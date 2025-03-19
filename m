Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E20B0C35FFB
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 03:20:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B09DE81CAF;
	Wed, 19 Mar 2025 04:19:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742354365;
	bh=ezVFOZQ7Wuojv8ETsya0sEsuhp+tsc7bqmy98av0Zmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vRlIiecI+5c10ix5UnkijJca/Ji3p51BfEg8t8TwfbIJCP4MXtT22ujGDf5azXxdE
	 0qqUfiDXOnMZ06tCksDLDTzYWOtgYXRdDGodRyxy40kXHU7p+7y59H4Yw9orktiTjO
	 QLQQtwYX5X/oPj9Hlvu4phQitX77D5e4bTgSMFECy6qxLG6A15UleilQuwd2sbMMnn
	 Obk0VGxp4VwO8yASS6q46CcMwGBJvEEvyTSDFJWI+SUuH7R2IxoeK5Lo9C+Ci2+9hT
	 VBO7ZeFOmNTkEBuMcWH2GDZAPFWLD1Kiz0oyRhm++0Yn0hYUlM6yjNUdlpZcr14YnM
	 IM3GiaQZdBOHg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id C85A281E18; Wed, 19 Mar 2025 04:19:22 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 170398197D
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 04:19:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="NJNm0yyp"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id BA496101E91C9; Wed, 19 Mar 2025 04:19:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742354359; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=ezVFOZQ7Wuojv8ETsya0sEsuhp+tsc7bqmy98av0Zmg=;
 b=NJNm0yypQCWxcSBEunG9V1Vmn1C0QX/ehbe29msP4NiFmaY2oQe4c7u0i9yRQONtB0Hyoc
 UaY3TgnmrvhdrKTaoOkEJUahgTcpbj1tRtlaemKzj0Etz1k1Lbx5sdAId/b4OXixRyHUgK
 MuW+ehBTwr2Ps14tHnJIEfk2RdHsY+TLUrYpkWdDKhmEYd76RF0VA9mjjbjzqy6geZxP37
 qBDIQXN/0P5ForWWXiJOrA3JFYc1FAtaiy66yohv07lcVjhyWxjhuRbox+w3PZH0cDy7ct
 qUVd45r44TMNR6rIS2HfAvCfWk1jMCDowPzIIB8UzDqR0Iv0UcQ4iwpPs3sW4Q==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Dong Aisheng <aisheng.dong@nxp.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, uboot-imx@nxp.com
Subject: [PATCH 05/24] clk: imx: Pass struct udevice into imx_clk_mux*()
Date: Wed, 19 Mar 2025 04:17:15 +0100
Message-ID: <20250319031852.233537-6-marex@denx.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250319031852.233537-1-marex@denx.de>
References: <20250319031852.233537-1-marex@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Pass struct udevice * into imx_clk_mux*() functions, so the
clock core would have access to parent struct udevice *.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>
Cc: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Cc: uboot-imx@nxp.com
---
 drivers/clk/imx/clk-imx6q.c     | 12 +++++------
 drivers/clk/imx/clk-imx8mm.c    | 24 ++++++++++-----------
 drivers/clk/imx/clk-imx8mn.c    | 24 ++++++++++-----------
 drivers/clk/imx/clk-imx8mp.c    | 26 +++++++++++-----------
 drivers/clk/imx/clk-imx8mq.c    | 38 ++++++++++++++++-----------------
 drivers/clk/imx/clk-imx93.c     |  2 +-
 drivers/clk/imx/clk-imxrt1020.c | 18 ++++++++--------
 drivers/clk/imx/clk-imxrt1050.c | 32 +++++++++++++--------------
 drivers/clk/imx/clk-imxrt1170.c |  8 +++----
 drivers/clk/imx/clk.h           | 12 +++++------
 10 files changed, 98 insertions(+), 98 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index df9f0285e1e..98a7f13c1df 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -66,16 +66,16 @@ static int imx6q_clk_probe(struct udevice *dev)
 		return -EINVAL;
 
 	clk_dm(IMX6QDL_CLK_USDHC1_SEL,
-	       imx_clk_mux("usdhc1_sel", base + 0x1c, 16, 1,
+	       imx_clk_mux(dev, "usdhc1_sel", base + 0x1c, 16, 1,
 			   usdhc_sels, ARRAY_SIZE(usdhc_sels)));
 	clk_dm(IMX6QDL_CLK_USDHC2_SEL,
-	       imx_clk_mux("usdhc2_sel", base + 0x1c, 17, 1,
+	       imx_clk_mux(dev, "usdhc2_sel", base + 0x1c, 17, 1,
 			   usdhc_sels, ARRAY_SIZE(usdhc_sels)));
 	clk_dm(IMX6QDL_CLK_USDHC3_SEL,
-	       imx_clk_mux("usdhc3_sel", base + 0x1c, 18, 1,
+	       imx_clk_mux(dev, "usdhc3_sel", base + 0x1c, 18, 1,
 			   usdhc_sels, ARRAY_SIZE(usdhc_sels)));
 	clk_dm(IMX6QDL_CLK_USDHC4_SEL,
-	       imx_clk_mux("usdhc4_sel", base + 0x1c, 19, 1,
+	       imx_clk_mux(dev, "usdhc4_sel", base + 0x1c, 19, 1,
 			   usdhc_sels, ARRAY_SIZE(usdhc_sels)));
 
 	clk_dm(IMX6QDL_CLK_USDHC1_PODF,
@@ -112,10 +112,10 @@ static int imx6q_clk_probe(struct udevice *dev)
 	       imx_clk_gate2("usdhc4", "usdhc4_podf", base + 0x80, 8));
 
 	clk_dm(IMX6QDL_CLK_PERIPH_PRE,
-	       imx_clk_mux("periph_pre", base + 0x18, 18, 2, periph_pre_sels,
+	       imx_clk_mux(dev, "periph_pre", base + 0x18, 18, 2, periph_pre_sels,
 			   ARRAY_SIZE(periph_pre_sels)));
 	clk_dm(IMX6QDL_CLK_PERIPH,
-	       imx_clk_busy_mux("periph",  base + 0x14, 25, 1, base + 0x48,
+	       imx_clk_busy_mux(dev, "periph",  base + 0x14, 25, 1, base + 0x48,
 				5, periph_sels,  ARRAY_SIZE(periph_sels)));
 	clk_dm(IMX6QDL_CLK_AHB,
 	       imx_clk_busy_divider("ahb", "periph", base + 0x14, 10, 3,
diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
index bb6958f0ec2..7f1ceee4cf2 100644
--- a/drivers/clk/imx/clk-imx8mm.c
+++ b/drivers/clk/imx/clk-imx8mm.c
@@ -156,19 +156,19 @@ static int imx8mm_clk_probe(struct udevice *dev)
 	base = (void *)ANATOP_BASE_ADDR;
 
 	clk_dm(IMX8MM_DRAM_PLL_REF_SEL,
-	       imx_clk_mux("dram_pll_ref_sel", base + 0x50, 0, 2,
+	       imx_clk_mux(dev, "dram_pll_ref_sel", base + 0x50, 0, 2,
 			   pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
 	clk_dm(IMX8MM_ARM_PLL_REF_SEL,
-	       imx_clk_mux("arm_pll_ref_sel", base + 0x84, 0, 2,
+	       imx_clk_mux(dev, "arm_pll_ref_sel", base + 0x84, 0, 2,
 			   pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
 	clk_dm(IMX8MM_SYS_PLL1_REF_SEL,
-	       imx_clk_mux("sys_pll1_ref_sel", base + 0x94, 0, 2,
+	       imx_clk_mux(dev, "sys_pll1_ref_sel", base + 0x94, 0, 2,
 			   pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
 	clk_dm(IMX8MM_SYS_PLL2_REF_SEL,
-	       imx_clk_mux("sys_pll2_ref_sel", base + 0x104, 0, 2,
+	       imx_clk_mux(dev, "sys_pll2_ref_sel", base + 0x104, 0, 2,
 			   pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
 	clk_dm(IMX8MM_SYS_PLL3_REF_SEL,
-	       imx_clk_mux("sys_pll3_ref_sel", base + 0x114, 0, 2,
+	       imx_clk_mux(dev, "sys_pll3_ref_sel", base + 0x114, 0, 2,
 			   pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
 
 	clk_dm(IMX8MM_DRAM_PLL,
@@ -189,27 +189,27 @@ static int imx8mm_clk_probe(struct udevice *dev)
 
 	/* PLL bypass out */
 	clk_dm(IMX8MM_DRAM_PLL_BYPASS,
-	       imx_clk_mux_flags("dram_pll_bypass", base + 0x50, 4, 1,
+	       imx_clk_mux_flags(dev, "dram_pll_bypass", base + 0x50, 4, 1,
 				 dram_pll_bypass_sels,
 				 ARRAY_SIZE(dram_pll_bypass_sels),
 				 CLK_SET_RATE_PARENT));
 	clk_dm(IMX8MM_ARM_PLL_BYPASS,
-	       imx_clk_mux_flags("arm_pll_bypass", base + 0x84, 4, 1,
+	       imx_clk_mux_flags(dev, "arm_pll_bypass", base + 0x84, 4, 1,
 				 arm_pll_bypass_sels,
 				 ARRAY_SIZE(arm_pll_bypass_sels),
 				 CLK_SET_RATE_PARENT));
 	clk_dm(IMX8MM_SYS_PLL1_BYPASS,
-	       imx_clk_mux_flags("sys_pll1_bypass", base + 0x94, 4, 1,
+	       imx_clk_mux_flags(dev, "sys_pll1_bypass", base + 0x94, 4, 1,
 				 sys_pll1_bypass_sels,
 				 ARRAY_SIZE(sys_pll1_bypass_sels),
 				 CLK_SET_RATE_PARENT));
 	clk_dm(IMX8MM_SYS_PLL2_BYPASS,
-	       imx_clk_mux_flags("sys_pll2_bypass", base + 0x104, 4, 1,
+	       imx_clk_mux_flags(dev, "sys_pll2_bypass", base + 0x104, 4, 1,
 				 sys_pll2_bypass_sels,
 				 ARRAY_SIZE(sys_pll2_bypass_sels),
 				 CLK_SET_RATE_PARENT));
 	clk_dm(IMX8MM_SYS_PLL3_BYPASS,
-	       imx_clk_mux_flags("sys_pll3_bypass", base + 0x114, 4, 1,
+	       imx_clk_mux_flags(dev, "sys_pll3_bypass", base + 0x114, 4, 1,
 				 sys_pll3_bypass_sels,
 				 ARRAY_SIZE(sys_pll3_bypass_sels),
 				 CLK_SET_RATE_PARENT));
@@ -275,7 +275,7 @@ static int imx8mm_clk_probe(struct udevice *dev)
 		return -EINVAL;
 
 	clk_dm(IMX8MM_CLK_A53_SRC,
-	       imx_clk_mux2("arm_a53_src", base + 0x8000, 24, 3,
+	       imx_clk_mux2(dev, "arm_a53_src", base + 0x8000, 24, 3,
 			    imx8mm_a53_sels, ARRAY_SIZE(imx8mm_a53_sels)));
 	clk_dm(IMX8MM_CLK_A53_CG,
 	       imx_clk_gate3("arm_a53_cg", "arm_a53_src", base + 0x8000, 28));
@@ -420,7 +420,7 @@ static int imx8mm_clk_probe(struct udevice *dev)
 #endif
 
 	clk_dm(IMX8MM_CLK_ARM,
-	       imx_clk_mux2_flags("arm_core", base + 0x9880, 24, 1,
+	       imx_clk_mux2_flags(dev, "arm_core", base + 0x9880, 24, 1,
 				  imx8mm_arm_core_sels,
 				  ARRAY_SIZE(imx8mm_arm_core_sels),
 				  CLK_IS_CRITICAL));
diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index be15ebd0e25..70aa851ef52 100644
--- a/drivers/clk/imx/clk-imx8mn.c
+++ b/drivers/clk/imx/clk-imx8mn.c
@@ -148,19 +148,19 @@ static int imx8mn_clk_probe(struct udevice *dev)
 	base = (void *)ANATOP_BASE_ADDR;
 
 	clk_dm(IMX8MN_DRAM_PLL_REF_SEL,
-	       imx_clk_mux("dram_pll_ref_sel", base + 0x50, 0, 2,
+	       imx_clk_mux(dev, "dram_pll_ref_sel", base + 0x50, 0, 2,
 			   pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
 	clk_dm(IMX8MN_ARM_PLL_REF_SEL,
-	       imx_clk_mux("arm_pll_ref_sel", base + 0x84, 0, 2,
+	       imx_clk_mux(dev, "arm_pll_ref_sel", base + 0x84, 0, 2,
 			   pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
 	clk_dm(IMX8MN_SYS_PLL1_REF_SEL,
-	       imx_clk_mux("sys_pll1_ref_sel", base + 0x94, 0, 2,
+	       imx_clk_mux(dev, "sys_pll1_ref_sel", base + 0x94, 0, 2,
 			   pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
 	clk_dm(IMX8MN_SYS_PLL2_REF_SEL,
-	       imx_clk_mux("sys_pll2_ref_sel", base + 0x104, 0, 2,
+	       imx_clk_mux(dev, "sys_pll2_ref_sel", base + 0x104, 0, 2,
 			   pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
 	clk_dm(IMX8MN_SYS_PLL3_REF_SEL,
-	       imx_clk_mux("sys_pll3_ref_sel", base + 0x114, 0, 2,
+	       imx_clk_mux(dev, "sys_pll3_ref_sel", base + 0x114, 0, 2,
 			   pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
 
 	clk_dm(IMX8MN_DRAM_PLL,
@@ -181,27 +181,27 @@ static int imx8mn_clk_probe(struct udevice *dev)
 
 	/* PLL bypass out */
 	clk_dm(IMX8MN_DRAM_PLL_BYPASS,
-	       imx_clk_mux_flags("dram_pll_bypass", base + 0x50, 4, 1,
+	       imx_clk_mux_flags(dev, "dram_pll_bypass", base + 0x50, 4, 1,
 				 dram_pll_bypass_sels,
 				 ARRAY_SIZE(dram_pll_bypass_sels),
 				 CLK_SET_RATE_PARENT));
 	clk_dm(IMX8MN_ARM_PLL_BYPASS,
-	       imx_clk_mux_flags("arm_pll_bypass", base + 0x84, 4, 1,
+	       imx_clk_mux_flags(dev, "arm_pll_bypass", base + 0x84, 4, 1,
 				 arm_pll_bypass_sels,
 				 ARRAY_SIZE(arm_pll_bypass_sels),
 				 CLK_SET_RATE_PARENT));
 	clk_dm(IMX8MN_SYS_PLL1_BYPASS,
-	       imx_clk_mux_flags("sys_pll1_bypass", base + 0x94, 4, 1,
+	       imx_clk_mux_flags(dev, "sys_pll1_bypass", base + 0x94, 4, 1,
 				 sys_pll1_bypass_sels,
 				 ARRAY_SIZE(sys_pll1_bypass_sels),
 				 CLK_SET_RATE_PARENT));
 	clk_dm(IMX8MN_SYS_PLL2_BYPASS,
-	       imx_clk_mux_flags("sys_pll2_bypass", base + 0x104, 4, 1,
+	       imx_clk_mux_flags(dev, "sys_pll2_bypass", base + 0x104, 4, 1,
 				 sys_pll2_bypass_sels,
 				 ARRAY_SIZE(sys_pll2_bypass_sels),
 				 CLK_SET_RATE_PARENT));
 	clk_dm(IMX8MN_SYS_PLL3_BYPASS,
-	       imx_clk_mux_flags("sys_pll3_bypass", base + 0x114, 4, 1,
+	       imx_clk_mux_flags(dev, "sys_pll3_bypass", base + 0x114, 4, 1,
 				 sys_pll3_bypass_sels,
 				 ARRAY_SIZE(sys_pll3_bypass_sels),
 				 CLK_SET_RATE_PARENT));
@@ -272,7 +272,7 @@ static int imx8mn_clk_probe(struct udevice *dev)
 		return -EINVAL;
 
 	clk_dm(IMX8MN_CLK_A53_SRC,
-	       imx_clk_mux2("arm_a53_src", base + 0x8000, 24, 3,
+	       imx_clk_mux2(dev, "arm_a53_src", base + 0x8000, 24, 3,
 			    imx8mn_a53_sels, ARRAY_SIZE(imx8mn_a53_sels)));
 	clk_dm(IMX8MN_CLK_A53_CG,
 	       imx_clk_gate3("arm_a53_cg", "arm_a53_src", base + 0x8000, 28));
@@ -406,7 +406,7 @@ static int imx8mn_clk_probe(struct udevice *dev)
 #endif
 
 	clk_dm(IMX8MN_CLK_ARM,
-	       imx_clk_mux2_flags("arm_core", base + 0x9880, 24, 1,
+	       imx_clk_mux2_flags(dev, "arm_core", base + 0x9880, 24, 1,
 				  imx8mn_arm_core_sels,
 				  ARRAY_SIZE(imx8mn_arm_core_sels),
 				  CLK_IS_CRITICAL));
diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index 1d04090ca00..4b916bef7a1 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -199,11 +199,11 @@ static int imx8mp_clk_probe(struct udevice *dev)
 
 	clk_dm(IMX8MP_CLK_DUMMY, clk_register_fixed_rate(NULL, "dummy", 0));
 
-	clk_dm(IMX8MP_DRAM_PLL_REF_SEL, imx_clk_mux("dram_pll_ref_sel", base + 0x50, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
-	clk_dm(IMX8MP_ARM_PLL_REF_SEL, imx_clk_mux("arm_pll_ref_sel", base + 0x84, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
-	clk_dm(IMX8MP_SYS_PLL1_REF_SEL, imx_clk_mux("sys_pll1_ref_sel", base + 0x94, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
-	clk_dm(IMX8MP_SYS_PLL2_REF_SEL, imx_clk_mux("sys_pll2_ref_sel", base + 0x104, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
-	clk_dm(IMX8MP_SYS_PLL3_REF_SEL, imx_clk_mux("sys_pll3_ref_sel", base + 0x114, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
+	clk_dm(IMX8MP_DRAM_PLL_REF_SEL, imx_clk_mux(dev, "dram_pll_ref_sel", base + 0x50, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
+	clk_dm(IMX8MP_ARM_PLL_REF_SEL, imx_clk_mux(dev, "arm_pll_ref_sel", base + 0x84, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
+	clk_dm(IMX8MP_SYS_PLL1_REF_SEL, imx_clk_mux(dev, "sys_pll1_ref_sel", base + 0x94, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
+	clk_dm(IMX8MP_SYS_PLL2_REF_SEL, imx_clk_mux(dev, "sys_pll2_ref_sel", base + 0x104, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
+	clk_dm(IMX8MP_SYS_PLL3_REF_SEL, imx_clk_mux(dev, "sys_pll3_ref_sel", base + 0x114, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
 
 	clk_dm(IMX8MP_DRAM_PLL, imx_clk_pll14xx("dram_pll", "dram_pll_ref_sel", base + 0x50,
 						&imx_1443x_dram_pll));
@@ -216,11 +216,11 @@ static int imx8mp_clk_probe(struct udevice *dev)
 	clk_dm(IMX8MP_SYS_PLL3, imx_clk_pll14xx("sys_pll3", "sys_pll3_ref_sel", base + 0x114,
 						&imx_1416x_pll));
 
-	clk_dm(IMX8MP_DRAM_PLL_BYPASS, imx_clk_mux_flags("dram_pll_bypass", base + 0x50, 4, 1, dram_pll_bypass_sels, ARRAY_SIZE(dram_pll_bypass_sels), CLK_SET_RATE_PARENT));
-	clk_dm(IMX8MP_ARM_PLL_BYPASS, imx_clk_mux_flags("arm_pll_bypass", base + 0x84, 4, 1, arm_pll_bypass_sels, ARRAY_SIZE(arm_pll_bypass_sels), CLK_SET_RATE_PARENT));
-	clk_dm(IMX8MP_SYS_PLL1_BYPASS, imx_clk_mux_flags("sys_pll1_bypass", base + 0x94, 4, 1, sys_pll1_bypass_sels, ARRAY_SIZE(sys_pll1_bypass_sels), CLK_SET_RATE_PARENT));
-	clk_dm(IMX8MP_SYS_PLL2_BYPASS, imx_clk_mux_flags("sys_pll2_bypass", base + 0x104, 4, 1, sys_pll2_bypass_sels, ARRAY_SIZE(sys_pll2_bypass_sels), CLK_SET_RATE_PARENT));
-	clk_dm(IMX8MP_SYS_PLL3_BYPASS, imx_clk_mux_flags("sys_pll3_bypass", base + 0x114, 4, 1, sys_pll3_bypass_sels, ARRAY_SIZE(sys_pll3_bypass_sels), CLK_SET_RATE_PARENT));
+	clk_dm(IMX8MP_DRAM_PLL_BYPASS, imx_clk_mux_flags(dev, "dram_pll_bypass", base + 0x50, 4, 1, dram_pll_bypass_sels, ARRAY_SIZE(dram_pll_bypass_sels), CLK_SET_RATE_PARENT));
+	clk_dm(IMX8MP_ARM_PLL_BYPASS, imx_clk_mux_flags(dev, "arm_pll_bypass", base + 0x84, 4, 1, arm_pll_bypass_sels, ARRAY_SIZE(arm_pll_bypass_sels), CLK_SET_RATE_PARENT));
+	clk_dm(IMX8MP_SYS_PLL1_BYPASS, imx_clk_mux_flags(dev, "sys_pll1_bypass", base + 0x94, 4, 1, sys_pll1_bypass_sels, ARRAY_SIZE(sys_pll1_bypass_sels), CLK_SET_RATE_PARENT));
+	clk_dm(IMX8MP_SYS_PLL2_BYPASS, imx_clk_mux_flags(dev, "sys_pll2_bypass", base + 0x104, 4, 1, sys_pll2_bypass_sels, ARRAY_SIZE(sys_pll2_bypass_sels), CLK_SET_RATE_PARENT));
+	clk_dm(IMX8MP_SYS_PLL3_BYPASS, imx_clk_mux_flags(dev, "sys_pll3_bypass", base + 0x114, 4, 1, sys_pll3_bypass_sels, ARRAY_SIZE(sys_pll3_bypass_sels), CLK_SET_RATE_PARENT));
 
 	clk_dm(IMX8MP_DRAM_PLL_OUT, imx_clk_gate("dram_pll_out", "dram_pll_bypass", base + 0x50, 13));
 	clk_dm(IMX8MP_ARM_PLL_OUT, imx_clk_gate("arm_pll_out", "arm_pll_bypass", base + 0x84, 11));
@@ -262,7 +262,7 @@ static int imx8mp_clk_probe(struct udevice *dev)
 	if (!base)
 		return -EINVAL;
 
-	clk_dm(IMX8MP_CLK_A53_SRC, imx_clk_mux2("arm_a53_src", base + 0x8000, 24, 3, imx8mp_a53_sels, ARRAY_SIZE(imx8mp_a53_sels)));
+	clk_dm(IMX8MP_CLK_A53_SRC, imx_clk_mux2(dev, "arm_a53_src", base + 0x8000, 24, 3, imx8mp_a53_sels, ARRAY_SIZE(imx8mp_a53_sels)));
 	clk_dm(IMX8MP_CLK_A53_CG, imx_clk_gate3("arm_a53_cg", "arm_a53_src", base + 0x8000, 28));
 	clk_dm(IMX8MP_CLK_A53_DIV, imx_clk_divider2("arm_a53_div", "arm_a53_cg", base + 0x8000, 0, 3));
 
@@ -314,7 +314,7 @@ static int imx8mp_clk_probe(struct udevice *dev)
 	clk_dm(IMX8MP_CLK_USDHC3, imx8m_clk_composite("usdhc3", imx8mp_usdhc3_sels, base + 0xbc80));
 
 	clk_dm(IMX8MP_CLK_DRAM_ALT_ROOT, imx_clk_fixed_factor("dram_alt_root", "dram_alt", 1, 4));
-	clk_dm(IMX8MP_CLK_DRAM_CORE, imx_clk_mux2_flags("dram_core_clk", base + 0x9800, 24, 1, imx8mp_dram_core_sels, ARRAY_SIZE(imx8mp_dram_core_sels), CLK_IS_CRITICAL));
+	clk_dm(IMX8MP_CLK_DRAM_CORE, imx_clk_mux2_flags(dev, "dram_core_clk", base + 0x9800, 24, 1, imx8mp_dram_core_sels, ARRAY_SIZE(imx8mp_dram_core_sels), CLK_IS_CRITICAL));
 
 	clk_dm(IMX8MP_CLK_DRAM1_ROOT, imx_clk_gate4_flags("dram1_root_clk", "dram_core_clk", base + 0x4050, 0, CLK_IS_CRITICAL));
 	clk_dm(IMX8MP_CLK_ECSPI1_ROOT, imx_clk_gate4("ecspi1_root_clk", "ecspi1", base + 0x4070, 0));
@@ -359,7 +359,7 @@ static int imx8mp_clk_probe(struct udevice *dev)
 	clk_dm(IMX8MP_CLK_USDHC3_ROOT, imx_clk_gate4("usdhc3_root_clk", "usdhc3", base + 0x45e0, 0));
 
 	clk_dm(IMX8MP_CLK_ARM,
-	       imx_clk_mux2_flags("arm_core", base + 0x9880, 24, 1,
+	       imx_clk_mux2_flags(dev, "arm_core", base + 0x9880, 24, 1,
 				  imx8mp_arm_core_sels,
 				  ARRAY_SIZE(imx8mp_arm_core_sels),
 				  CLK_IS_CRITICAL));
diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
index ed4acd79ef7..dc9b7d56815 100644
--- a/drivers/clk/imx/clk-imx8mq.c
+++ b/drivers/clk/imx/clk-imx8mq.c
@@ -152,31 +152,31 @@ static int imx8mq_clk_probe(struct udevice *dev)
 	clk_dm(IMX8MQ_CLK_27M, clk_register_fixed_rate(NULL, "clock-osc-27m", 27000000));
 
 	clk_dm(IMX8MQ_DRAM_PLL1_REF_SEL,
-	       imx_clk_mux("dram_pll_ref_sel", base + 0x60, 0, 2,
+	       imx_clk_mux(dev, "dram_pll_ref_sel", base + 0x60, 0, 2,
 			   pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
 	clk_dm(IMX8MQ_ARM_PLL_REF_SEL,
-	       imx_clk_mux("arm_pll_ref_sel", base + 0x28, 0, 2,
+	       imx_clk_mux(dev, "arm_pll_ref_sel", base + 0x28, 0, 2,
 			   pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
 	clk_dm(IMX8MQ_GPU_PLL_REF_SEL,
-	       imx_clk_mux("gpu_pll_ref_sel", base + 0x18, 0, 2,
+	       imx_clk_mux(dev, "gpu_pll_ref_sel", base + 0x18, 0, 2,
 			   pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
 	clk_dm(IMX8MQ_VPU_PLL_REF_SEL,
-	       imx_clk_mux("vpu_pll_ref_sel", base + 0x20, 0, 2,
+	       imx_clk_mux(dev, "vpu_pll_ref_sel", base + 0x20, 0, 2,
 			   pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
 	clk_dm(IMX8MQ_SYS3_PLL1_REF_SEL,
-	       imx_clk_mux("sys3_pll_ref_sel", base + 0x48, 0, 2,
+	       imx_clk_mux(dev, "sys3_pll_ref_sel", base + 0x48, 0, 2,
 			   pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
 	clk_dm(IMX8MQ_AUDIO_PLL1_REF_SEL,
-	       imx_clk_mux("audio_pll1_ref_sel", base + 0x0, 0, 2,
+	       imx_clk_mux(dev, "audio_pll1_ref_sel", base + 0x0, 0, 2,
 			   pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
 	clk_dm(IMX8MQ_AUDIO_PLL2_REF_SEL,
-	       imx_clk_mux("audio_pll2_ref_sel", base + 0x8, 0, 2,
+	       imx_clk_mux(dev, "audio_pll2_ref_sel", base + 0x8, 0, 2,
 			   pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
 	clk_dm(IMX8MQ_VIDEO_PLL1_REF_SEL,
-	       imx_clk_mux("video_pll1_ref_sel", base + 0x10, 0, 2,
+	       imx_clk_mux(dev, "video_pll1_ref_sel", base + 0x10, 0, 2,
 			   pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
 	clk_dm(IMX8MQ_VIDEO2_PLL1_REF_SEL,
-	       imx_clk_mux("video_pll2_ref_sel", base + 0x54, 0, 2,
+	       imx_clk_mux(dev, "video_pll2_ref_sel", base + 0x54, 0, 2,
 			   pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
 
 	clk_dm(IMX8MQ_ARM_PLL,
@@ -207,32 +207,32 @@ static int imx8mq_clk_probe(struct udevice *dev)
 
 	/* PLL bypass out */
 	clk_dm(IMX8MQ_ARM_PLL_BYPASS,
-	       imx_clk_mux_flags("arm_pll_bypass", base + 0x28, 4, 1,
+	       imx_clk_mux_flags(dev, "arm_pll_bypass", base + 0x28, 4, 1,
 				 arm_pll_bypass_sels,
 				 ARRAY_SIZE(arm_pll_bypass_sels),
 				 CLK_SET_RATE_PARENT));
 	clk_dm(IMX8MQ_GPU_PLL_BYPASS,
-	       imx_clk_mux_flags("gpu_pll_bypass", base + 0x18, 4, 1,
+	       imx_clk_mux_flags(dev, "gpu_pll_bypass", base + 0x18, 4, 1,
 				 gpu_pll_bypass_sels,
 				 ARRAY_SIZE(gpu_pll_bypass_sels),
 				 CLK_SET_RATE_PARENT));
 	clk_dm(IMX8MQ_VPU_PLL_BYPASS,
-	       imx_clk_mux_flags("vpu_pll_bypass", base + 0x20, 4, 1,
+	       imx_clk_mux_flags(dev, "vpu_pll_bypass", base + 0x20, 4, 1,
 				 vpu_pll_bypass_sels,
 				 ARRAY_SIZE(vpu_pll_bypass_sels),
 				 CLK_SET_RATE_PARENT));
 	clk_dm(IMX8MQ_AUDIO_PLL1_BYPASS,
-	       imx_clk_mux_flags("audio_pll1_bypass", base + 0x0, 4, 1,
+	       imx_clk_mux_flags(dev, "audio_pll1_bypass", base + 0x0, 4, 1,
 				 audio_pll1_bypass_sels,
 				 ARRAY_SIZE(audio_pll1_bypass_sels),
 				 CLK_SET_RATE_PARENT));
 	clk_dm(IMX8MQ_AUDIO_PLL2_BYPASS,
-	       imx_clk_mux_flags("audio_pll2_bypass", base + 0x8, 4, 1,
+	       imx_clk_mux_flags(dev, "audio_pll2_bypass", base + 0x8, 4, 1,
 				 audio_pll2_bypass_sels,
 				 ARRAY_SIZE(audio_pll2_bypass_sels),
 				 CLK_SET_RATE_PARENT));
 	clk_dm(IMX8MQ_VIDEO_PLL1_BYPASS,
-	       imx_clk_mux_flags("video_pll1_bypass", base + 0x10, 4, 1,
+	       imx_clk_mux_flags(dev, "video_pll1_bypass", base + 0x10, 4, 1,
 				 video_pll1_bypass_sels,
 				 ARRAY_SIZE(video_pll1_bypass_sels),
 				 CLK_SET_RATE_PARENT));
@@ -335,7 +335,7 @@ static int imx8mq_clk_probe(struct udevice *dev)
 	clk_dm(IMX8MQ_CLK_MON_VIDEO_PLL2_DIV,
 	       imx_clk_divider("video_pll2_out_monitor", "video_pll2_out", base + 0x7c, 16, 3));
 	clk_dm(IMX8MQ_CLK_MON_SEL,
-	       imx_clk_mux_flags("pllout_monitor_sel", base + 0x74, 0, 4,
+	       imx_clk_mux_flags(dev, "pllout_monitor_sel", base + 0x74, 0, 4,
 				 pllout_monitor_sels,
 				 ARRAY_SIZE(pllout_monitor_sels),
 				 CLK_SET_RATE_PARENT));
@@ -349,7 +349,7 @@ static int imx8mq_clk_probe(struct udevice *dev)
 	}
 
 	clk_dm(IMX8MQ_CLK_A53_SRC,
-	       imx_clk_mux2("arm_a53_src", base + 0x8000, 24, 3,
+	       imx_clk_mux2(dev, "arm_a53_src", base + 0x8000, 24, 3,
 			    imx8mq_a53_sels, ARRAY_SIZE(imx8mq_a53_sels)));
 	clk_dm(IMX8MQ_CLK_A53_CG,
 	       imx_clk_gate3("arm_a53_cg", "arm_a53_src", base + 0x8000, 28));
@@ -357,7 +357,7 @@ static int imx8mq_clk_probe(struct udevice *dev)
 	       imx_clk_divider2("arm_a53_div", "arm_a53_cg",
 				base + 0x8000, 0, 3));
 	clk_dm(IMX8MQ_CLK_A53_CORE,
-	       imx_clk_mux2("arm_a53_src", base + 0x9880, 24, 1,
+	       imx_clk_mux2(dev, "arm_a53_src", base + 0x9880, 24, 1,
 			    imx8mq_a53_core_sels, ARRAY_SIZE(imx8mq_a53_core_sels)));
 
 	clk_dm(IMX8MQ_CLK_AHB,
@@ -378,7 +378,7 @@ static int imx8mq_clk_probe(struct udevice *dev)
 
 	/* DRAM */
 	clk_dm(IMX8MQ_CLK_DRAM_CORE,
-	       imx_clk_mux2("dram_core_clk", base + 0x9800, 24, 1,
+	       imx_clk_mux2(dev, "dram_core_clk", base + 0x9800, 24, 1,
 			    imx8mq_dram_core_sels, ARRAY_SIZE(imx8mq_dram_core_sels)));
 	clk_dm(IMX8MQ_CLK_DRAM_ALT,
 	       imx8m_clk_composite("dram_alt", imx8mq_dram_alt_sels, base + 0xa000));
diff --git a/drivers/clk/imx/clk-imx93.c b/drivers/clk/imx/clk-imx93.c
index b31e57a4a01..0caec91fd9a 100644
--- a/drivers/clk/imx/clk-imx93.c
+++ b/drivers/clk/imx/clk-imx93.c
@@ -338,7 +338,7 @@ static int imx93_clk_probe(struct udevice *dev)
 	}
 
 	clk_dm(IMX93_CLK_A55_SEL,
-	       imx_clk_mux2("a55_sel", base + 0x4820, 0, 1,
+	       imx_clk_mux2(dev, "a55_sel", base + 0x4820, 0, 1,
 			    a55_core_sels, ARRAY_SIZE(a55_core_sels)));
 
 	return 0;
diff --git a/drivers/clk/imx/clk-imxrt1020.c b/drivers/clk/imx/clk-imxrt1020.c
index 752434cb0ad..16fc3bcdb3e 100644
--- a/drivers/clk/imx/clk-imxrt1020.c
+++ b/drivers/clk/imx/clk-imxrt1020.c
@@ -46,12 +46,12 @@ static int imxrt1020_clk_probe(struct udevice *dev)
 
 	/* PLL bypass out */
 	clk_dm(IMXRT1020_CLK_PLL2_BYPASS,
-	       imx_clk_mux_flags("pll2_bypass", base + 0x30, 16, 1,
+	       imx_clk_mux_flags(dev, "pll2_bypass", base + 0x30, 16, 1,
 				 pll2_bypass_sels,
 				 ARRAY_SIZE(pll2_bypass_sels),
 				 CLK_SET_RATE_PARENT));
 	clk_dm(IMXRT1020_CLK_PLL3_BYPASS,
-	       imx_clk_mux_flags("pll3_bypass", base + 0x10, 16, 1,
+	       imx_clk_mux_flags(dev, "pll3_bypass", base + 0x10, 16, 1,
 				 pll3_bypass_sels,
 				 ARRAY_SIZE(pll3_bypass_sels),
 				 CLK_SET_RATE_PARENT));
@@ -78,25 +78,25 @@ static int imxrt1020_clk_probe(struct udevice *dev)
 		return -EINVAL;
 
 	clk_dm(IMXRT1020_CLK_PRE_PERIPH_SEL,
-	       imx_clk_mux("pre_periph_sel", base + 0x18, 18, 2,
+	       imx_clk_mux(dev, "pre_periph_sel", base + 0x18, 18, 2,
 			   pre_periph_sels, ARRAY_SIZE(pre_periph_sels)));
 	clk_dm(IMXRT1020_CLK_PERIPH_SEL,
-	       imx_clk_mux("periph_sel", base + 0x14, 25, 1,
+	       imx_clk_mux(dev, "periph_sel", base + 0x14, 25, 1,
 			   periph_sels, ARRAY_SIZE(periph_sels)));
 	clk_dm(IMXRT1020_CLK_USDHC1_SEL,
-	       imx_clk_mux("usdhc1_sel", base + 0x1c, 16, 1,
+	       imx_clk_mux(dev, "usdhc1_sel", base + 0x1c, 16, 1,
 			   usdhc_sels, ARRAY_SIZE(usdhc_sels)));
 	clk_dm(IMXRT1020_CLK_USDHC2_SEL,
-	       imx_clk_mux("usdhc2_sel", base + 0x1c, 17, 1,
+	       imx_clk_mux(dev, "usdhc2_sel", base + 0x1c, 17, 1,
 			   usdhc_sels, ARRAY_SIZE(usdhc_sels)));
 	clk_dm(IMXRT1020_CLK_LPUART_SEL,
-	       imx_clk_mux("lpuart_sel", base + 0x24, 6, 1,
+	       imx_clk_mux(dev, "lpuart_sel", base + 0x24, 6, 1,
 			   lpuart_sels, ARRAY_SIZE(lpuart_sels)));
 	clk_dm(IMXRT1020_CLK_SEMC_ALT_SEL,
-	       imx_clk_mux("semc_alt_sel", base + 0x14, 7, 1,
+	       imx_clk_mux(dev, "semc_alt_sel", base + 0x14, 7, 1,
 			   semc_alt_sels, ARRAY_SIZE(semc_alt_sels)));
 	clk_dm(IMXRT1020_CLK_SEMC_SEL,
-	       imx_clk_mux("semc_sel", base + 0x14, 6, 1,
+	       imx_clk_mux(dev, "semc_sel", base + 0x14, 6, 1,
 			   semc_sels, ARRAY_SIZE(semc_sels)));
 
 	clk_dm(IMXRT1020_CLK_AHB_PODF,
diff --git a/drivers/clk/imx/clk-imxrt1050.c b/drivers/clk/imx/clk-imxrt1050.c
index 2c029ec5a6e..5f37915f593 100644
--- a/drivers/clk/imx/clk-imxrt1050.c
+++ b/drivers/clk/imx/clk-imxrt1050.c
@@ -36,16 +36,16 @@ static int imxrt1050_clk_probe(struct udevice *dev)
 	base = (void *)ofnode_get_addr(ofnode_by_compatible(ofnode_null(), "fsl,imxrt-anatop"));
 
 	clk_dm(IMXRT1050_CLK_PLL1_REF_SEL,
-	       imx_clk_mux("pll1_arm_ref_sel", base + 0x0, 14, 2,
+	       imx_clk_mux(dev, "pll1_arm_ref_sel", base + 0x0, 14, 2,
 			   pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
 	clk_dm(IMXRT1050_CLK_PLL2_REF_SEL,
-	       imx_clk_mux("pll2_sys_ref_sel", base + 0x30, 14, 2,
+	       imx_clk_mux(dev, "pll2_sys_ref_sel", base + 0x30, 14, 2,
 			   pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
 	clk_dm(IMXRT1050_CLK_PLL3_REF_SEL,
-	       imx_clk_mux("pll3_usb_otg_ref_sel", base + 0x10, 14, 2,
+	       imx_clk_mux(dev, "pll3_usb_otg_ref_sel", base + 0x10, 14, 2,
 			   pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
 	clk_dm(IMXRT1050_CLK_PLL5_REF_SEL,
-	       imx_clk_mux("pll5_video_ref_sel", base + 0xa0, 14, 2,
+	       imx_clk_mux(dev, "pll5_video_ref_sel", base + 0xa0, 14, 2,
 			   pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
 
 	clk_dm(IMXRT1050_CLK_PLL1_ARM,
@@ -64,22 +64,22 @@ static int imxrt1050_clk_probe(struct udevice *dev)
 
 	/* PLL bypass out */
 	clk_dm(IMXRT1050_CLK_PLL1_BYPASS,
-	       imx_clk_mux_flags("pll1_bypass", base + 0x0, 16, 1,
+	       imx_clk_mux_flags(dev, "pll1_bypass", base + 0x0, 16, 1,
 				 pll1_bypass_sels,
 				 ARRAY_SIZE(pll1_bypass_sels),
 				 CLK_SET_RATE_PARENT));
 	clk_dm(IMXRT1050_CLK_PLL2_BYPASS,
-	       imx_clk_mux_flags("pll2_bypass", base + 0x30, 16, 1,
+	       imx_clk_mux_flags(dev, "pll2_bypass", base + 0x30, 16, 1,
 				 pll2_bypass_sels,
 				 ARRAY_SIZE(pll2_bypass_sels),
 				 CLK_SET_RATE_PARENT));
 	clk_dm(IMXRT1050_CLK_PLL3_BYPASS,
-	       imx_clk_mux_flags("pll3_bypass", base + 0x10, 16, 1,
+	       imx_clk_mux_flags(dev, "pll3_bypass", base + 0x10, 16, 1,
 				 pll3_bypass_sels,
 				 ARRAY_SIZE(pll3_bypass_sels),
 				 CLK_SET_RATE_PARENT));
 	clk_dm(IMXRT1050_CLK_PLL5_BYPASS,
-	       imx_clk_mux_flags("pll5_bypass", base + 0xa0, 16, 1,
+	       imx_clk_mux_flags(dev, "pll5_bypass", base + 0xa0, 16, 1,
 				 pll5_bypass_sels,
 				 ARRAY_SIZE(pll5_bypass_sels),
 				 CLK_SET_RATE_PARENT));
@@ -117,28 +117,28 @@ static int imxrt1050_clk_probe(struct udevice *dev)
 			       base + 0x10, 0, 3));
 
 	clk_dm(IMXRT1050_CLK_PRE_PERIPH_SEL,
-	       imx_clk_mux("pre_periph_sel", base + 0x18, 18, 2,
+	       imx_clk_mux(dev, "pre_periph_sel", base + 0x18, 18, 2,
 			   pre_periph_sels, ARRAY_SIZE(pre_periph_sels)));
 	clk_dm(IMXRT1050_CLK_PERIPH_SEL,
-	       imx_clk_mux("periph_sel", base + 0x14, 25, 1,
+	       imx_clk_mux(dev, "periph_sel", base + 0x14, 25, 1,
 			   periph_sels, ARRAY_SIZE(periph_sels)));
 	clk_dm(IMXRT1050_CLK_USDHC1_SEL,
-	       imx_clk_mux("usdhc1_sel", base + 0x1c, 16, 1,
+	       imx_clk_mux(dev, "usdhc1_sel", base + 0x1c, 16, 1,
 			   usdhc_sels, ARRAY_SIZE(usdhc_sels)));
 	clk_dm(IMXRT1050_CLK_USDHC2_SEL,
-	       imx_clk_mux("usdhc2_sel", base + 0x1c, 17, 1,
+	       imx_clk_mux(dev, "usdhc2_sel", base + 0x1c, 17, 1,
 			   usdhc_sels, ARRAY_SIZE(usdhc_sels)));
 	clk_dm(IMXRT1050_CLK_LPUART_SEL,
-	       imx_clk_mux("lpuart_sel", base + 0x24, 6, 1,
+	       imx_clk_mux(dev, "lpuart_sel", base + 0x24, 6, 1,
 			   lpuart_sels, ARRAY_SIZE(lpuart_sels)));
 	clk_dm(IMXRT1050_CLK_SEMC_ALT_SEL,
-	       imx_clk_mux("semc_alt_sel", base + 0x14, 7, 1,
+	       imx_clk_mux(dev, "semc_alt_sel", base + 0x14, 7, 1,
 			   semc_alt_sels, ARRAY_SIZE(semc_alt_sels)));
 	clk_dm(IMXRT1050_CLK_SEMC_SEL,
-	       imx_clk_mux("semc_sel", base + 0x14, 6, 1,
+	       imx_clk_mux(dev, "semc_sel", base + 0x14, 6, 1,
 			   semc_sels, ARRAY_SIZE(semc_sels)));
 	clk_dm(IMXRT1050_CLK_LCDIF_SEL,
-	       imx_clk_mux("lcdif_sel", base + 0x38, 15, 3,
+	       imx_clk_mux(dev, "lcdif_sel", base + 0x38, 15, 3,
 			   lcdif_sels, ARRAY_SIZE(lcdif_sels)));
 
 	clk_dm(IMXRT1050_CLK_AHB_PODF,
diff --git a/drivers/clk/imx/clk-imxrt1170.c b/drivers/clk/imx/clk-imxrt1170.c
index 88a294f4165..7e06504584f 100644
--- a/drivers/clk/imx/clk-imxrt1170.c
+++ b/drivers/clk/imx/clk-imxrt1170.c
@@ -157,28 +157,28 @@ static int imxrt1170_clk_probe(struct udevice *dev)
 		return -EINVAL;
 
 	clk_dm(IMXRT1170_CLK_LPUART1_SEL,
-	       imx_clk_mux("lpuart1_sel", base + (25 * 0x80), 8, 3,
+	       imx_clk_mux(dev, "lpuart1_sel", base + (25 * 0x80), 8, 3,
 			   lpuart1_sels, ARRAY_SIZE(lpuart1_sels)));
 	clk_dm(IMXRT1170_CLK_LPUART1,
 	       imx_clk_divider("lpuart1", "lpuart1_sel",
 			       base + (25 * 0x80), 0, 8));
 
 	clk_dm(IMXRT1170_CLK_USDHC1_SEL,
-	       imx_clk_mux("usdhc1_sel", base + (58 * 0x80), 8, 3,
+	       imx_clk_mux(dev, "usdhc1_sel", base + (58 * 0x80), 8, 3,
 			   usdhc1_sels, ARRAY_SIZE(usdhc1_sels)));
 	clk_dm(IMXRT1170_CLK_USDHC1,
 	       imx_clk_divider("usdhc1", "usdhc1_sel",
 			       base + (58 * 0x80), 0, 8));
 
 	clk_dm(IMXRT1170_CLK_GPT1_SEL,
-	       imx_clk_mux("gpt1_sel", base + (14 * 0x80), 8, 3,
+	       imx_clk_mux(dev, "gpt1_sel", base + (14 * 0x80), 8, 3,
 			   gpt1_sels, ARRAY_SIZE(gpt1_sels)));
 	clk_dm(IMXRT1170_CLK_GPT1,
 	       imx_clk_divider("gpt1", "gpt1_sel",
 			       base + (14 * 0x80), 0, 8));
 
 	clk_dm(IMXRT1170_CLK_SEMC_SEL,
-	       imx_clk_mux("semc_sel", base + (4 * 0x80), 8, 3,
+	       imx_clk_mux(dev, "semc_sel", base + (4 * 0x80), 8, 3,
 			   semc_sels, ARRAY_SIZE(semc_sels)));
 	clk_dm(IMXRT1170_CLK_SEMC,
 	       imx_clk_divider("semc", "semc_sel",
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 27a53ae5583..f18249ee8a8 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -167,7 +167,7 @@ struct clk *imx_clk_fixup_mux(const char *name, void __iomem *reg,
 			      u8 shift, u8 width, const char * const *parents,
 			      int num_parents, void (*fixup)(u32 *val));
 
-static inline struct clk *imx_clk_mux_flags(const char *name,
+static inline struct clk *imx_clk_mux_flags(struct udevice *dev, const char *name,
 			void __iomem *reg, u8 shift, u8 width,
 			const char * const *parents, int num_parents,
 			unsigned long flags)
@@ -177,7 +177,7 @@ static inline struct clk *imx_clk_mux_flags(const char *name,
 				width, 0);
 }
 
-static inline struct clk *imx_clk_mux2_flags(const char *name,
+static inline struct clk *imx_clk_mux2_flags(struct udevice *dev, const char *name,
 		void __iomem *reg, u8 shift, u8 width,
 		const char * const *parents,
 		int num_parents, unsigned long flags)
@@ -187,8 +187,8 @@ static inline struct clk *imx_clk_mux2_flags(const char *name,
 			reg, shift, width, 0);
 }
 
-static inline struct clk *imx_clk_mux(const char *name, void __iomem *reg,
-			u8 shift, u8 width, const char * const *parents,
+static inline struct clk *imx_clk_mux(struct udevice *dev, const char *name,
+			void __iomem *reg, u8 shift, u8 width, const char * const *parents,
 			int num_parents)
 {
 	return clk_register_mux(NULL, name, parents, num_parents,
@@ -197,7 +197,7 @@ static inline struct clk *imx_clk_mux(const char *name, void __iomem *reg,
 }
 
 static inline struct clk *
-imx_clk_busy_mux(const char *name, void __iomem *reg, u8 shift, u8 width,
+imx_clk_busy_mux(struct udevice *dev, const char *name, void __iomem *reg, u8 shift, u8 width,
 		 void __iomem *busy_reg, u8 busy_shift,
 		 const char * const *parents, int num_parents)
 {
@@ -206,7 +206,7 @@ imx_clk_busy_mux(const char *name, void __iomem *reg, u8 shift, u8 width,
 			width, 0);
 }
 
-static inline struct clk *imx_clk_mux2(const char *name, void __iomem *reg,
+static inline struct clk *imx_clk_mux2(struct udevice *dev, const char *name, void __iomem *reg,
 			u8 shift, u8 width, const char * const *parents,
 			int num_parents)
 {
-- 
2.47.2

