Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03BDAC35FFB
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 03:22:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FCD981F7E;
	Wed, 19 Mar 2025 04:19:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742354381;
	bh=3ZR2Fj2Kfy01EwC5HWfCOzCGRcfdMCmiFNVwgM6JeZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jlArEAOM8APzS6ojy2ODcufswlCt8zymUPqsdQaYR75i5MMuNTvJgmAH5BR+PxK/W
	 rZ5WkLTNFguLkcUvQnURdqcBPY76csUxY7Kt/i1vC6Zyyufk1kZhYBhH+d8xstOuA8
	 tKhJTp10xxEpTg8aety4KlngzPWYleWtAGR7PccvVkjG8R5weEdtAo/M1/be6m80Zl
	 sthd88kKTUEz6bXYuXvNk7+tCaEMENa02JPMF0dgcrrvX1ccbCYVNfIGrDEiliri6T
	 xpqirf+JajdLWIT522q3dVTx6hsqErxscjPo7S9Mi5ER0YY9ik2clKvUh/s+tGSrnu
	 s/P/QZH2yaOSg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8154A81026; Wed, 19 Mar 2025 04:19:39 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79B7881ED8
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 04:19:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="SPfa+f5U"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2AB6E101F63B7; Wed, 19 Mar 2025 04:19:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742354375; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=3ZR2Fj2Kfy01EwC5HWfCOzCGRcfdMCmiFNVwgM6JeZM=;
 b=SPfa+f5UYygIU9Wu6RkKPYtkZyJm66LOAdxXEznghQaNDRhyazSj2CJIlH16Tiw1NZH7NE
 vVhPvaFVPIk3wcok4AzP+PcAf7xKxBVe762sbVbjl1j/zEBRYFcCp2R7PgR9ZUDhjMtqdK
 yil5Rw8zGBA8ob86rWOpPSC589EryIjbKV5wzwSR6fCjmLkFPinQakUDK1VxE/hq/uF1g5
 P9KgD6Rsgal80itr2aLui+UtvPOiQL75Y7EyXKMO8pCitfny7vKAXZPtWQNp98n7Fa9zB5
 mAC+VRS56ffcWGsoCGVQxo+WhplGB4I3YcJDpPd4bo/m78Lxljy7/ISo+khAvQ==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Dong Aisheng <aisheng.dong@nxp.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, uboot-imx@nxp.com
Subject: [PATCH 20/24] clk: imx: Pass struct udevice into imx_clk_divider*()
Date: Wed, 19 Mar 2025 04:17:30 +0100
Message-ID: <20250319031852.233537-21-marex@denx.de>
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

Pass struct udevice * into imx_clk_divider*() functions, so the
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
 drivers/clk/imx/clk-imx6q.c     | 16 ++++++++--------
 drivers/clk/imx/clk-imx8mm.c    |  4 ++--
 drivers/clk/imx/clk-imx8mn.c    |  4 ++--
 drivers/clk/imx/clk-imx8mp.c    |  4 ++--
 drivers/clk/imx/clk-imx8mq.c    | 26 +++++++++++++-------------
 drivers/clk/imx/clk-imxrt1020.c | 10 +++++-----
 drivers/clk/imx/clk-imxrt1050.c | 22 +++++++++++-----------
 drivers/clk/imx/clk-imxrt1170.c |  8 ++++----
 drivers/clk/imx/clk.h           | 21 ++++++++++++---------
 9 files changed, 59 insertions(+), 56 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index 8d86caead9a..2855a4d2926 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -79,20 +79,20 @@ static int imx6q_clk_probe(struct udevice *dev)
 			   usdhc_sels, ARRAY_SIZE(usdhc_sels)));
 
 	clk_dm(IMX6QDL_CLK_USDHC1_PODF,
-	       imx_clk_divider("usdhc1_podf", "usdhc1_sel",
+	       imx_clk_divider(dev, "usdhc1_podf", "usdhc1_sel",
 			       base + 0x24, 11, 3));
 	clk_dm(IMX6QDL_CLK_USDHC2_PODF,
-	       imx_clk_divider("usdhc2_podf", "usdhc2_sel",
+	       imx_clk_divider(dev, "usdhc2_podf", "usdhc2_sel",
 			       base + 0x24, 16, 3));
 	clk_dm(IMX6QDL_CLK_USDHC3_PODF,
-	       imx_clk_divider("usdhc3_podf", "usdhc3_sel",
+	       imx_clk_divider(dev, "usdhc3_podf", "usdhc3_sel",
 			       base + 0x24, 19, 3));
 	clk_dm(IMX6QDL_CLK_USDHC4_PODF,
-	       imx_clk_divider("usdhc4_podf", "usdhc4_sel",
+	       imx_clk_divider(dev, "usdhc4_podf", "usdhc4_sel",
 			       base + 0x24, 22, 3));
 
 	clk_dm(IMX6QDL_CLK_ECSPI_ROOT,
-	       imx_clk_divider("ecspi_root", "pll3_60m", base + 0x38, 19, 6));
+	       imx_clk_divider(dev, "ecspi_root", "pll3_60m", base + 0x38, 19, 6));
 
 	clk_dm(IMX6QDL_CLK_ECSPI1,
 	       imx_clk_gate2(dev, "ecspi1", "ecspi_root", base + 0x6c, 0));
@@ -118,12 +118,12 @@ static int imx6q_clk_probe(struct udevice *dev)
 	       imx_clk_busy_mux(dev, "periph",  base + 0x14, 25, 1, base + 0x48,
 				5, periph_sels,  ARRAY_SIZE(periph_sels)));
 	clk_dm(IMX6QDL_CLK_AHB,
-	       imx_clk_busy_divider("ahb", "periph", base + 0x14, 10, 3,
+	       imx_clk_busy_divider(dev, "ahb", "periph", base + 0x14, 10, 3,
 				    base + 0x48, 1));
 	clk_dm(IMX6QDL_CLK_IPG,
-	       imx_clk_divider("ipg", "ahb", base + 0x14, 8, 2));
+	       imx_clk_divider(dev, "ipg", "ahb", base + 0x14, 8, 2));
 	clk_dm(IMX6QDL_CLK_IPG_PER,
-	       imx_clk_divider("ipg_per", "ipg", base + 0x1c, 0, 6));
+	       imx_clk_divider(dev, "ipg_per", "ipg", base + 0x1c, 0, 6));
 	clk_dm(IMX6QDL_CLK_I2C1,
 	       imx_clk_gate2(dev, "i2c1", "ipg_per", base + 0x70, 6));
 	clk_dm(IMX6QDL_CLK_I2C2,
diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
index d77f662e5dd..9fd0bb970d3 100644
--- a/drivers/clk/imx/clk-imx8mm.c
+++ b/drivers/clk/imx/clk-imx8mm.c
@@ -280,14 +280,14 @@ static int imx8mm_clk_probe(struct udevice *dev)
 	clk_dm(IMX8MM_CLK_A53_CG,
 	       imx_clk_gate3(dev, "arm_a53_cg", "arm_a53_src", base + 0x8000, 28));
 	clk_dm(IMX8MM_CLK_A53_DIV,
-	       imx_clk_divider2("arm_a53_div", "arm_a53_cg",
+	       imx_clk_divider2(dev, "arm_a53_div", "arm_a53_cg",
 				base + 0x8000, 0, 3));
 
 	clk_dm(IMX8MM_CLK_AHB,
 	       imx8m_clk_composite_critical(dev, "ahb", imx8mm_ahb_sels,
 					    base + 0x9000));
 	clk_dm(IMX8MM_CLK_IPG_ROOT,
-	       imx_clk_divider2("ipg_root", "ahb", base + 0x9080, 0, 1));
+	       imx_clk_divider2(dev, "ipg_root", "ahb", base + 0x9080, 0, 1));
 
 	clk_dm(IMX8MM_CLK_NAND_USDHC_BUS,
 	       imx8m_clk_composite_critical(dev, "nand_usdhc_bus",
diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index 76b4e365f3d..bfda4251d99 100644
--- a/drivers/clk/imx/clk-imx8mn.c
+++ b/drivers/clk/imx/clk-imx8mn.c
@@ -277,14 +277,14 @@ static int imx8mn_clk_probe(struct udevice *dev)
 	clk_dm(IMX8MN_CLK_A53_CG,
 	       imx_clk_gate3(dev, "arm_a53_cg", "arm_a53_src", base + 0x8000, 28));
 	clk_dm(IMX8MN_CLK_A53_DIV,
-	       imx_clk_divider2("arm_a53_div", "arm_a53_cg",
+	       imx_clk_divider2(dev, "arm_a53_div", "arm_a53_cg",
 				base + 0x8000, 0, 3));
 
 	clk_dm(IMX8MN_CLK_AHB,
 	       imx8m_clk_composite_critical(dev, "ahb", imx8mn_ahb_sels,
 					    base + 0x9000));
 	clk_dm(IMX8MN_CLK_IPG_ROOT,
-	       imx_clk_divider2("ipg_root", "ahb", base + 0x9080, 0, 1));
+	       imx_clk_divider2(dev, "ipg_root", "ahb", base + 0x9080, 0, 1));
 
 	clk_dm(IMX8MN_CLK_ENET_AXI,
 	       imx8m_clk_composite(dev, "enet_axi", imx8mn_enet_axi_sels,
diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index 7c6b5322427..ed11d751af0 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -264,7 +264,7 @@ static int imx8mp_clk_probe(struct udevice *dev)
 
 	clk_dm(IMX8MP_CLK_A53_SRC, imx_clk_mux2(dev, "arm_a53_src", base + 0x8000, 24, 3, imx8mp_a53_sels, ARRAY_SIZE(imx8mp_a53_sels)));
 	clk_dm(IMX8MP_CLK_A53_CG, imx_clk_gate3(dev, "arm_a53_cg", "arm_a53_src", base + 0x8000, 28));
-	clk_dm(IMX8MP_CLK_A53_DIV, imx_clk_divider2("arm_a53_div", "arm_a53_cg", base + 0x8000, 0, 3));
+	clk_dm(IMX8MP_CLK_A53_DIV, imx_clk_divider2(dev, "arm_a53_div", "arm_a53_cg", base + 0x8000, 0, 3));
 
 	clk_dm(IMX8MP_CLK_HSIO_AXI, imx8m_clk_composite(dev, "hsio_axi", imx8mp_hsio_axi_sels, base + 0x8380));
 	clk_dm(IMX8MP_CLK_MAIN_AXI, imx8m_clk_composite_critical(dev, "main_axi", imx8mp_main_axi_sels, base + 0x8800));
@@ -275,7 +275,7 @@ static int imx8mp_clk_probe(struct udevice *dev)
 
 	clk_dm(IMX8MP_CLK_AHB, imx8m_clk_composite_critical(dev, "ahb_root", imx8mp_ahb_sels, base + 0x9000));
 
-	clk_dm(IMX8MP_CLK_IPG_ROOT, imx_clk_divider2("ipg_root", "ahb_root", base + 0x9080, 0, 1));
+	clk_dm(IMX8MP_CLK_IPG_ROOT, imx_clk_divider2(dev, "ipg_root", "ahb_root", base + 0x9080, 0, 1));
 
 	clk_dm(IMX8MP_CLK_DRAM_ALT, imx8m_clk_composite(dev, "dram_alt", imx8mp_dram_alt_sels, base + 0xa000));
 	clk_dm(IMX8MP_CLK_DRAM_APB, imx8m_clk_composite_critical(dev, "dram_apb", imx8mp_dram_apb_sels, base + 0xa080));
diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
index 5faa2d20224..7632ffe72e7 100644
--- a/drivers/clk/imx/clk-imx8mq.c
+++ b/drivers/clk/imx/clk-imx8mq.c
@@ -313,27 +313,27 @@ static int imx8mq_clk_probe(struct udevice *dev)
 	       imx_clk_fixed_factor("sys_pll2_1000m", "sys_pll2_out", 1, 1));
 
 	clk_dm(IMX8MQ_CLK_MON_AUDIO_PLL1_DIV,
-	       imx_clk_divider("audio_pll1_out_monitor", "audio_pll1_bypass", base + 0x78, 0, 3));
+	       imx_clk_divider(dev, "audio_pll1_out_monitor", "audio_pll1_bypass", base + 0x78, 0, 3));
 	clk_dm(IMX8MQ_CLK_MON_AUDIO_PLL2_DIV,
-	       imx_clk_divider("audio_pll2_out_monitor", "audio_pll2_bypass", base + 0x78, 4, 3));
+	       imx_clk_divider(dev, "audio_pll2_out_monitor", "audio_pll2_bypass", base + 0x78, 4, 3));
 	clk_dm(IMX8MQ_CLK_MON_VIDEO_PLL1_DIV,
-	       imx_clk_divider("video_pll1_out_monitor", "video_pll1_bypass", base + 0x78, 8, 3));
+	       imx_clk_divider(dev, "video_pll1_out_monitor", "video_pll1_bypass", base + 0x78, 8, 3));
 	clk_dm(IMX8MQ_CLK_MON_GPU_PLL_DIV,
-	       imx_clk_divider("gpu_pll_out_monitor", "gpu_pll_bypass", base + 0x78, 12, 3));
+	       imx_clk_divider(dev, "gpu_pll_out_monitor", "gpu_pll_bypass", base + 0x78, 12, 3));
 	clk_dm(IMX8MQ_CLK_MON_VPU_PLL_DIV,
-	       imx_clk_divider("vpu_pll_out_monitor", "vpu_pll_bypass", base + 0x78, 16, 3));
+	       imx_clk_divider(dev, "vpu_pll_out_monitor", "vpu_pll_bypass", base + 0x78, 16, 3));
 	clk_dm(IMX8MQ_CLK_MON_ARM_PLL_DIV,
-	       imx_clk_divider("arm_pll_out_monitor", "arm_pll_bypass", base + 0x78, 20, 3));
+	       imx_clk_divider(dev, "arm_pll_out_monitor", "arm_pll_bypass", base + 0x78, 20, 3));
 	clk_dm(IMX8MQ_CLK_MON_SYS_PLL1_DIV,
-	       imx_clk_divider("sys_pll1_out_monitor", "sys_pll1_out", base + 0x7c, 0, 3));
+	       imx_clk_divider(dev, "sys_pll1_out_monitor", "sys_pll1_out", base + 0x7c, 0, 3));
 	clk_dm(IMX8MQ_CLK_MON_SYS_PLL2_DIV,
-	       imx_clk_divider("sys_pll2_out_monitor", "sys_pll2_out", base + 0x7c, 4, 3));
+	       imx_clk_divider(dev, "sys_pll2_out_monitor", "sys_pll2_out", base + 0x7c, 4, 3));
 	clk_dm(IMX8MQ_CLK_MON_SYS_PLL3_DIV,
-	       imx_clk_divider("sys_pll3_out_monitor", "sys_pll3_out", base + 0x7c, 8, 3));
+	       imx_clk_divider(dev, "sys_pll3_out_monitor", "sys_pll3_out", base + 0x7c, 8, 3));
 	clk_dm(IMX8MQ_CLK_MON_DRAM_PLL_DIV,
-	       imx_clk_divider("dram_pll_out_monitor", "dram_pll_out", base + 0x7c, 12, 3));
+	       imx_clk_divider(dev, "dram_pll_out_monitor", "dram_pll_out", base + 0x7c, 12, 3));
 	clk_dm(IMX8MQ_CLK_MON_VIDEO_PLL2_DIV,
-	       imx_clk_divider("video_pll2_out_monitor", "video_pll2_out", base + 0x7c, 16, 3));
+	       imx_clk_divider(dev, "video_pll2_out_monitor", "video_pll2_out", base + 0x7c, 16, 3));
 	clk_dm(IMX8MQ_CLK_MON_SEL,
 	       imx_clk_mux_flags(dev, "pllout_monitor_sel", base + 0x74, 0, 4,
 				 pllout_monitor_sels,
@@ -354,7 +354,7 @@ static int imx8mq_clk_probe(struct udevice *dev)
 	clk_dm(IMX8MQ_CLK_A53_CG,
 	       imx_clk_gate3(dev, "arm_a53_cg", "arm_a53_src", base + 0x8000, 28));
 	clk_dm(IMX8MQ_CLK_A53_DIV,
-	       imx_clk_divider2("arm_a53_div", "arm_a53_cg",
+	       imx_clk_divider2(dev, "arm_a53_div", "arm_a53_cg",
 				base + 0x8000, 0, 3));
 	clk_dm(IMX8MQ_CLK_A53_CORE,
 	       imx_clk_mux2(dev, "arm_a53_src", base + 0x9880, 24, 1,
@@ -364,7 +364,7 @@ static int imx8mq_clk_probe(struct udevice *dev)
 	       imx8m_clk_composite_critical(dev, "ahb", imx8mq_ahb_sels,
 					    base + 0x9000));
 	clk_dm(IMX8MQ_CLK_IPG_ROOT,
-	       imx_clk_divider2("ipg_root", "ahb", base + 0x9080, 0, 1));
+	       imx_clk_divider2(dev, "ipg_root", "ahb", base + 0x9080, 0, 1));
 
 	clk_dm(IMX8MQ_CLK_ENET_AXI,
 	       imx8m_clk_composite(dev, "enet_axi", imx8mq_enet_axi_sels,
diff --git a/drivers/clk/imx/clk-imxrt1020.c b/drivers/clk/imx/clk-imxrt1020.c
index 40cba218c29..90fe98556b5 100644
--- a/drivers/clk/imx/clk-imxrt1020.c
+++ b/drivers/clk/imx/clk-imxrt1020.c
@@ -100,19 +100,19 @@ static int imxrt1020_clk_probe(struct udevice *dev)
 			   semc_sels, ARRAY_SIZE(semc_sels)));
 
 	clk_dm(IMXRT1020_CLK_AHB_PODF,
-	       imx_clk_divider("ahb_podf", "periph_sel",
+	       imx_clk_divider(dev, "ahb_podf", "periph_sel",
 			       base + 0x14, 10, 3));
 	clk_dm(IMXRT1020_CLK_USDHC1_PODF,
-	       imx_clk_divider("usdhc1_podf", "usdhc1_sel",
+	       imx_clk_divider(dev, "usdhc1_podf", "usdhc1_sel",
 			       base + 0x24, 11, 3));
 	clk_dm(IMXRT1020_CLK_USDHC2_PODF,
-	       imx_clk_divider("usdhc2_podf", "usdhc2_sel",
+	       imx_clk_divider(dev, "usdhc2_podf", "usdhc2_sel",
 			       base + 0x24, 16, 3));
 	clk_dm(IMXRT1020_CLK_LPUART_PODF,
-	       imx_clk_divider("lpuart_podf", "lpuart_sel",
+	       imx_clk_divider(dev, "lpuart_podf", "lpuart_sel",
 			       base + 0x24, 0, 6));
 	clk_dm(IMXRT1020_CLK_SEMC_PODF,
-	       imx_clk_divider("semc_podf", "semc_sel",
+	       imx_clk_divider(dev, "semc_podf", "semc_sel",
 			       base + 0x14, 16, 3));
 
 	clk_dm(IMXRT1020_CLK_USDHC1,
diff --git a/drivers/clk/imx/clk-imxrt1050.c b/drivers/clk/imx/clk-imxrt1050.c
index 71d5fa8a90e..ec1f5ee9077 100644
--- a/drivers/clk/imx/clk-imxrt1050.c
+++ b/drivers/clk/imx/clk-imxrt1050.c
@@ -85,10 +85,10 @@ static int imxrt1050_clk_probe(struct udevice *dev)
 				 CLK_SET_RATE_PARENT));
 
 	clk_dm(IMXRT1050_CLK_VIDEO_POST_DIV_SEL,
-	       imx_clk_divider("video_post_div_sel", "pll5_video",
+	       imx_clk_divider(dev, "video_post_div_sel", "pll5_video",
 			       base + 0xa0, 19, 2));
 	clk_dm(IMXRT1050_CLK_VIDEO_DIV,
-	       imx_clk_divider("video_div", "video_post_div_sel",
+	       imx_clk_divider(dev, "video_div", "video_post_div_sel",
 			       base + 0x170, 30, 2));
 
 	clk_dm(IMXRT1050_CLK_PLL3_80M,
@@ -113,7 +113,7 @@ static int imxrt1050_clk_probe(struct udevice *dev)
 		return -EINVAL;
 
 	clk_dm(IMXRT1050_CLK_ARM_PODF,
-	       imx_clk_divider("arm_podf", "pll1_arm",
+	       imx_clk_divider(dev, "arm_podf", "pll1_arm",
 			       base + 0x10, 0, 3));
 
 	clk_dm(IMXRT1050_CLK_PRE_PERIPH_SEL,
@@ -142,28 +142,28 @@ static int imxrt1050_clk_probe(struct udevice *dev)
 			   lcdif_sels, ARRAY_SIZE(lcdif_sels)));
 
 	clk_dm(IMXRT1050_CLK_AHB_PODF,
-	       imx_clk_divider("ahb_podf", "periph_sel",
+	       imx_clk_divider(dev, "ahb_podf", "periph_sel",
 			       base + 0x14, 10, 3));
 	clk_dm(IMXRT1050_CLK_IPG_PDOF,
-	       imx_clk_divider("ipg_podf", "ahb_podf",
+	       imx_clk_divider(dev, "ipg_podf", "ahb_podf",
 			       base + 0x14, 8, 2));
 	clk_dm(IMXRT1050_CLK_USDHC1_PODF,
-	       imx_clk_divider("usdhc1_podf", "usdhc1_sel",
+	       imx_clk_divider(dev, "usdhc1_podf", "usdhc1_sel",
 			       base + 0x24, 11, 3));
 	clk_dm(IMXRT1050_CLK_USDHC2_PODF,
-	       imx_clk_divider("usdhc2_podf", "usdhc2_sel",
+	       imx_clk_divider(dev, "usdhc2_podf", "usdhc2_sel",
 			       base + 0x24, 16, 3));
 	clk_dm(IMXRT1050_CLK_LPUART_PODF,
-	       imx_clk_divider("lpuart_podf", "lpuart_sel",
+	       imx_clk_divider(dev, "lpuart_podf", "lpuart_sel",
 			       base + 0x24, 0, 6));
 	clk_dm(IMXRT1050_CLK_SEMC_PODF,
-	       imx_clk_divider("semc_podf", "semc_sel",
+	       imx_clk_divider(dev, "semc_podf", "semc_sel",
 			       base + 0x14, 16, 3));
 	clk_dm(IMXRT1050_CLK_LCDIF_PRED,
-	       imx_clk_divider("lcdif_pred", "lcdif_sel",
+	       imx_clk_divider(dev, "lcdif_pred", "lcdif_sel",
 			       base + 0x38, 12, 3));
 	clk_dm(IMXRT1050_CLK_LCDIF_PODF,
-	       imx_clk_divider("lcdif_podf", "lcdif_pred",
+	       imx_clk_divider(dev, "lcdif_podf", "lcdif_pred",
 			       base + 0x18, 23, 3));
 
 	clk_dm(IMXRT1050_CLK_USDHC1,
diff --git a/drivers/clk/imx/clk-imxrt1170.c b/drivers/clk/imx/clk-imxrt1170.c
index caf34a55459..043c400559e 100644
--- a/drivers/clk/imx/clk-imxrt1170.c
+++ b/drivers/clk/imx/clk-imxrt1170.c
@@ -160,28 +160,28 @@ static int imxrt1170_clk_probe(struct udevice *dev)
 	       imx_clk_mux(dev, "lpuart1_sel", base + (25 * 0x80), 8, 3,
 			   lpuart1_sels, ARRAY_SIZE(lpuart1_sels)));
 	clk_dm(IMXRT1170_CLK_LPUART1,
-	       imx_clk_divider("lpuart1", "lpuart1_sel",
+	       imx_clk_divider(dev, "lpuart1", "lpuart1_sel",
 			       base + (25 * 0x80), 0, 8));
 
 	clk_dm(IMXRT1170_CLK_USDHC1_SEL,
 	       imx_clk_mux(dev, "usdhc1_sel", base + (58 * 0x80), 8, 3,
 			   usdhc1_sels, ARRAY_SIZE(usdhc1_sels)));
 	clk_dm(IMXRT1170_CLK_USDHC1,
-	       imx_clk_divider("usdhc1", "usdhc1_sel",
+	       imx_clk_divider(dev, "usdhc1", "usdhc1_sel",
 			       base + (58 * 0x80), 0, 8));
 
 	clk_dm(IMXRT1170_CLK_GPT1_SEL,
 	       imx_clk_mux(dev, "gpt1_sel", base + (14 * 0x80), 8, 3,
 			   gpt1_sels, ARRAY_SIZE(gpt1_sels)));
 	clk_dm(IMXRT1170_CLK_GPT1,
-	       imx_clk_divider("gpt1", "gpt1_sel",
+	       imx_clk_divider(dev, "gpt1", "gpt1_sel",
 			       base + (14 * 0x80), 0, 8));
 
 	clk_dm(IMXRT1170_CLK_SEMC_SEL,
 	       imx_clk_mux(dev, "semc_sel", base + (4 * 0x80), 8, 3,
 			   semc_sels, ARRAY_SIZE(semc_sels)));
 	clk_dm(IMXRT1170_CLK_SEMC,
-	       imx_clk_divider("semc", "semc_sel",
+	       imx_clk_divider(dev, "semc", "semc_sel",
 			       base + (4 * 0x80), 0, 8));
 	struct clk *clk, *clk1;
 
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 4caf3b053d4..32fa832f856 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -138,25 +138,28 @@ static inline struct clk *imx_clk_fixed_factor(const char *name,
 			CLK_SET_RATE_PARENT, mult, div);
 }
 
-static inline struct clk *imx_clk_divider(const char *name, const char *parent,
-		void __iomem *reg, u8 shift, u8 width)
+static inline struct clk *imx_clk_divider(struct udevice *dev, const char *name,
+					  const char *parent, void __iomem *reg,
+					  u8 shift, u8 width)
 {
-	return clk_register_divider(NULL, name, parent, CLK_SET_RATE_PARENT,
+	return clk_register_divider(dev, name, parent, CLK_SET_RATE_PARENT,
 			reg, shift, width, 0);
 }
 
 static inline struct clk *
-imx_clk_busy_divider(const char *name, const char *parent, void __iomem *reg,
-		     u8 shift, u8 width, void __iomem *busy_reg, u8 busy_shift)
+imx_clk_busy_divider(struct udevice *dev, const char *name,
+		     const char *parent, void __iomem *reg, u8 shift, u8 width,
+		     void __iomem *busy_reg, u8 busy_shift)
 {
-	return clk_register_divider(NULL, name, parent, CLK_SET_RATE_PARENT,
+	return clk_register_divider(dev, name, parent, CLK_SET_RATE_PARENT,
 			reg, shift, width, 0);
 }
 
-static inline struct clk *imx_clk_divider2(const char *name, const char *parent,
-		void __iomem *reg, u8 shift, u8 width)
+static inline struct clk *imx_clk_divider2(struct udevice *dev, const char *name,
+					   const char *parent, void __iomem *reg,
+					   u8 shift, u8 width)
 {
-	return clk_register_divider(NULL, name, parent,
+	return clk_register_divider(dev, name, parent,
 			CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
 			reg, shift, width, 0);
 }
-- 
2.47.2

