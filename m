Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B47CE7716D
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 13:56:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A2D1894E9;
	Thu,  5 Dec 2024 14:54:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="EYgoa9TQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BEBC89540; Thu,  5 Dec 2024 14:54:53 +0100 (CET)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net
 [217.70.183.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1102F8950A
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 14:54:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2743F40011;
 Thu,  5 Dec 2024 13:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1733406888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A584HzgWP4wN1k01LjC5ZJIVkLRUgWoKZ8cley4rkdo=;
 b=EYgoa9TQmP2FwYLwOfdUyebXr7KyvQCBze4UJqOQ92LvDwjVHPxn6DODkMcAyDCRfWfzaf
 wR8T0VfjMCZKykUjAVJPrElsoRjcUIhy6nKKN7kvGFSxlkdOYeXefgSZ3xbxJlyabObU7C
 mbAED3VxcrVdlyeBVhq/VHdTQ6E9WMA0st4p2AQhHwYMr5fVky6W4+mrIs7pa/dGXY400f
 oD2ChySVvw+5PC8BVLXdeV7lAphbwzvyjaMP4dFZEKLYr8j95FladamWLn62XWMVExVjpg
 OzOWZro2gP/4/PYkg/C6NOFkLS2zuFNZwN+IkJ7BnLSQBX4BZeXqmP7REmdwHg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Thu, 05 Dec 2024 14:54:13 +0100
Subject: [PATCH v2 07/13] clk: imx8mp: Add media related clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241205-ge-mainline-display-support-v2-7-4683bb4388dc@bootlin.com>
References: <20241205-ge-mainline-display-support-v2-0-4683bb4388dc@bootlin.com>
In-Reply-To: <20241205-ge-mainline-display-support-v2-0-4683bb4388dc@bootlin.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>, 
 u-boot@lists.denx.de, Ian Ray <ian.ray@gehealthcare.com>, 
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Adam Ford <aford173@gmail.com>, Marek Vasut <marex@denx.de>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.15-dev
X-GND-Sasl: miquel.raynal@bootlin.com
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

These are all the clocks needed to get an LCD panel working, going
through one of the LCDIF and the LDB. The media AXI and APB clocks are
also described.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/clk/imx/clk-imx8mp.c | 69 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index 1d04090ca00785fdf1f4fc751a69506664dbed89..8c9e6b33e8a994bdcc19dbcf04dcf2f0e99da420 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -14,7 +14,14 @@
 
 #include "clk.h"
 
+#if CONFIG_IS_ENABLED(VIDEO)
+static u32 share_count_media;
+#endif
+
 static const char * const pll_ref_sels[] = { "clock-osc-24m", "dummy", "dummy", "dummy", };
+#if CONFIG_IS_ENABLED(VIDEO)
+static const char * const video_pll1_bypass_sels[] = {"video_pll1", "video_pll1_ref_sel", };
+#endif
 static const char * const dram_pll_bypass_sels[] = {"dram_pll", "dram_pll_ref_sel", };
 static const char * const arm_pll_bypass_sels[] = {"arm_pll", "arm_pll_ref_sel", };
 static const char * const sys_pll1_bypass_sels[] = {"sys_pll1", "sys_pll1_ref_sel", };
@@ -31,6 +38,12 @@ static const char * const imx8mp_hsio_axi_sels[] = {"clock-osc-24m", "sys_pll2_5
 						    "sys_pll2_100m", "sys_pll2_200m", "clk_ext2",
 						    "clk_ext4", "audio_pll2_out", };
 
+#if CONFIG_IS_ENABLED(VIDEO)
+static const char * const imx8mp_media_isp_sels[] = {"osc_24m", "sys_pll2_1000m", "sys_pll1_800m",
+						     "sys_pll3_out", "sys_pll1_400m", "audio_pll2_out",
+						     "clk_ext1", "sys_pll2_500m", };
+#endif
+
 static const char * const imx8mp_main_axi_sels[] = {"clock-osc-24m", "sys_pll2_333m", "sys_pll1_800m",
 						    "sys_pll2_250m", "sys_pll2_1000m", "audio_pll1_out",
 						    "video_pll1_out", "sys_pll1_100m",};
@@ -43,6 +56,16 @@ static const char * const imx8mp_nand_usdhc_sels[] = {"clock-osc-24m", "sys_pll1
 						      "sys_pll2_200m", "sys_pll1_133m", "sys_pll3_out",
 						      "sys_pll2_250m", "audio_pll1_out", };
 
+#if CONFIG_IS_ENABLED(VIDEO)
+static const char * const imx8mp_media_axi_sels[] = {"clock-osc-24m", "sys_pll2_1000m", "sys_pll1_800m",
+						     "sys_pll3_out", "sys_pll1_40m", "audio_pll2_out",
+						     "clk_ext1", "sys_pll2_500m", };
+
+static const char * const imx8mp_media_apb_sels[] = {"clock-osc-24m", "sys_pll2_125m", "sys_pll1_800m",
+					      "sys_pll3_out", "sys_pll1_40m", "audio_pll2_out",
+					      "clk_ext1", "sys_pll1_133m", };
+#endif
+
 static const char * const imx8mp_noc_sels[] = {"clock-osc-24m", "sys_pll1_800m", "sys_pll3_out",
 					       "sys_pll2_1000m", "sys_pll2_500m", "audio_pll1_out",
 					       "video_pll1_out", "audio_pll2_out", };
@@ -175,6 +198,17 @@ static const char * const imx8mp_usdhc3_sels[] = {"clock-osc-24m", "sys_pll1_400
 						  "sys_pll2_500m", "sys_pll3_out", "sys_pll1_266m",
 						  "audio_pll2_out", "sys_pll1_100m", };
 
+#if CONFIG_IS_ENABLED(VIDEO)
+static const char * const imx8mp_media_disp_pix_sels[] = {"clock-osc-24m", "video_pll1_out", "audio_pll2_out",
+							  "audio_pll1_out", "sys_pll1_800m",
+							  "sys_pll2_1000m", "sys_pll3_out", "clk_ext4", };
+
+static const char * const imx8mp_media_ldb_sels[] = {"clock-osc-24m", "sys_pll2_333m", "sys_pll2_100m",
+						     "sys_pll1_800m", "sys_pll2_1000m",
+						     "clk_ext2", "audio_pll2_out",
+						     "video_pll1_out", };
+#endif
+
 static const char * const imx8mp_enet_ref_sels[] = {"clock-osc-24m", "sys_pll2_125m", "sys_pll2_50m",
 						    "sys_pll2_100m", "sys_pll1_160m", "audio_pll1_out",
 						    "video_pll1_out", "clk_ext4", };
@@ -199,12 +233,19 @@ static int imx8mp_clk_probe(struct udevice *dev)
 
 	clk_dm(IMX8MP_CLK_DUMMY, clk_register_fixed_rate(NULL, "dummy", 0));
 
+#if CONFIG_IS_ENABLED(VIDEO)
+	clk_dm(IMX8MP_VIDEO_PLL1_REF_SEL, imx_clk_mux("video_pll1_ref_sel", base + 0x28, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
+#endif
 	clk_dm(IMX8MP_DRAM_PLL_REF_SEL, imx_clk_mux("dram_pll_ref_sel", base + 0x50, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
 	clk_dm(IMX8MP_ARM_PLL_REF_SEL, imx_clk_mux("arm_pll_ref_sel", base + 0x84, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
 	clk_dm(IMX8MP_SYS_PLL1_REF_SEL, imx_clk_mux("sys_pll1_ref_sel", base + 0x94, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
 	clk_dm(IMX8MP_SYS_PLL2_REF_SEL, imx_clk_mux("sys_pll2_ref_sel", base + 0x104, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
 	clk_dm(IMX8MP_SYS_PLL3_REF_SEL, imx_clk_mux("sys_pll3_ref_sel", base + 0x114, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
 
+#if CONFIG_IS_ENABLED(VIDEO)
+	clk_dm(IMX8MP_VIDEO_PLL1, imx_clk_pll14xx("video_pll1", "video_pll1_ref_sel", base + 0x28,
+						  &imx_1443x_pll));
+#endif
 	clk_dm(IMX8MP_DRAM_PLL, imx_clk_pll14xx("dram_pll", "dram_pll_ref_sel", base + 0x50,
 						&imx_1443x_dram_pll));
 	clk_dm(IMX8MP_ARM_PLL, imx_clk_pll14xx("arm_pll", "arm_pll_ref_sel", base + 0x84,
@@ -216,12 +257,18 @@ static int imx8mp_clk_probe(struct udevice *dev)
 	clk_dm(IMX8MP_SYS_PLL3, imx_clk_pll14xx("sys_pll3", "sys_pll3_ref_sel", base + 0x114,
 						&imx_1416x_pll));
 
+#if CONFIG_IS_ENABLED(VIDEO)
+	clk_dm(IMX8MP_VIDEO_PLL1_BYPASS, imx_clk_mux_flags("video_pll1_bypass", base + 0x28, 16, 1, video_pll1_bypass_sels, ARRAY_SIZE(video_pll1_bypass_sels), CLK_SET_RATE_PARENT));
+#endif
 	clk_dm(IMX8MP_DRAM_PLL_BYPASS, imx_clk_mux_flags("dram_pll_bypass", base + 0x50, 4, 1, dram_pll_bypass_sels, ARRAY_SIZE(dram_pll_bypass_sels), CLK_SET_RATE_PARENT));
 	clk_dm(IMX8MP_ARM_PLL_BYPASS, imx_clk_mux_flags("arm_pll_bypass", base + 0x84, 4, 1, arm_pll_bypass_sels, ARRAY_SIZE(arm_pll_bypass_sels), CLK_SET_RATE_PARENT));
 	clk_dm(IMX8MP_SYS_PLL1_BYPASS, imx_clk_mux_flags("sys_pll1_bypass", base + 0x94, 4, 1, sys_pll1_bypass_sels, ARRAY_SIZE(sys_pll1_bypass_sels), CLK_SET_RATE_PARENT));
 	clk_dm(IMX8MP_SYS_PLL2_BYPASS, imx_clk_mux_flags("sys_pll2_bypass", base + 0x104, 4, 1, sys_pll2_bypass_sels, ARRAY_SIZE(sys_pll2_bypass_sels), CLK_SET_RATE_PARENT));
 	clk_dm(IMX8MP_SYS_PLL3_BYPASS, imx_clk_mux_flags("sys_pll3_bypass", base + 0x114, 4, 1, sys_pll3_bypass_sels, ARRAY_SIZE(sys_pll3_bypass_sels), CLK_SET_RATE_PARENT));
 
+#if CONFIG_IS_ENABLED(VIDEO)
+	clk_dm(IMX8MP_VIDEO_PLL1_OUT, imx_clk_gate("video_pll1_out", "video_pll1_bypass", base + 0x28, 13));
+#endif
 	clk_dm(IMX8MP_DRAM_PLL_OUT, imx_clk_gate("dram_pll_out", "dram_pll_bypass", base + 0x50, 13));
 	clk_dm(IMX8MP_ARM_PLL_OUT, imx_clk_gate("arm_pll_out", "arm_pll_bypass", base + 0x84, 11));
 	clk_dm(IMX8MP_SYS_PLL1_OUT, imx_clk_gate("sys_pll1_out", "sys_pll1_bypass", base + 0x94, 11));
@@ -267,13 +314,23 @@ static int imx8mp_clk_probe(struct udevice *dev)
 	clk_dm(IMX8MP_CLK_A53_DIV, imx_clk_divider2("arm_a53_div", "arm_a53_cg", base + 0x8000, 0, 3));
 
 	clk_dm(IMX8MP_CLK_HSIO_AXI, imx8m_clk_composite("hsio_axi", imx8mp_hsio_axi_sels, base + 0x8380));
+#if CONFIG_IS_ENABLED(VIDEO)
+	clk_dm(IMX8MP_CLK_MEDIA_ISP, imx8m_clk_composite("media_isp", imx8mp_media_isp_sels, base + 0x8400));
+#endif
 	clk_dm(IMX8MP_CLK_MAIN_AXI, imx8m_clk_composite_critical("main_axi", imx8mp_main_axi_sels, base + 0x8800));
 	clk_dm(IMX8MP_CLK_ENET_AXI, imx8m_clk_composite_critical("enet_axi", imx8mp_enet_axi_sels, base + 0x8880));
 	clk_dm(IMX8MP_CLK_NAND_USDHC_BUS, imx8m_clk_composite_critical("nand_usdhc_bus", imx8mp_nand_usdhc_sels, base + 0x8900));
+#if CONFIG_IS_ENABLED(VIDEO)
+	clk_dm(IMX8MP_CLK_MEDIA_AXI, imx8m_clk_composite("media_axi", imx8mp_media_axi_sels, base + 0x8a00));
+	clk_dm(IMX8MP_CLK_MEDIA_APB, imx8m_clk_composite("media_apb", imx8mp_media_apb_sels, base + 0x8a80));
+#endif
 	clk_dm(IMX8MP_CLK_NOC, imx8m_clk_composite_critical("noc", imx8mp_noc_sels, base + 0x8d00));
 	clk_dm(IMX8MP_CLK_NOC_IO, imx8m_clk_composite_critical("noc_io", imx8mp_noc_io_sels, base + 0x8d80));
 
 	clk_dm(IMX8MP_CLK_AHB, imx8m_clk_composite_critical("ahb_root", imx8mp_ahb_sels, base + 0x9000));
+#if CONFIG_IS_ENABLED(VIDEO)
+	clk_dm(IMX8MP_CLK_MEDIA_DISP2_PIX, imx8m_clk_composite("media_disp2_pix", imx8mp_media_disp_pix_sels, base + 0x9300));
+#endif
 
 	clk_dm(IMX8MP_CLK_IPG_ROOT, imx_clk_divider2("ipg_root", "ahb_root", base + 0x9080, 0, 1));
 
@@ -312,6 +369,10 @@ static int imx8mp_clk_probe(struct udevice *dev)
 
 	clk_dm(IMX8MP_CLK_WDOG, imx8m_clk_composite("wdog", imx8mp_wdog_sels, base + 0xb900));
 	clk_dm(IMX8MP_CLK_USDHC3, imx8m_clk_composite("usdhc3", imx8mp_usdhc3_sels, base + 0xbc80));
+#if CONFIG_IS_ENABLED(VIDEO)
+	clk_dm(IMX8MP_CLK_MEDIA_DISP1_PIX, imx8m_clk_composite("media_disp1_pix", imx8mp_media_disp_pix_sels, base + 0xbe00));
+	clk_dm(IMX8MP_CLK_MEDIA_LDB, imx8m_clk_composite("media_ldb", imx8mp_media_ldb_sels, base + 0xbf00));
+#endif
 
 	clk_dm(IMX8MP_CLK_DRAM_ALT_ROOT, imx_clk_fixed_factor("dram_alt_root", "dram_alt", 1, 4));
 	clk_dm(IMX8MP_CLK_DRAM_CORE, imx_clk_mux2_flags("dram_core_clk", base + 0x9800, 24, 1, imx8mp_dram_core_sels, ARRAY_SIZE(imx8mp_dram_core_sels), CLK_IS_CRITICAL));
@@ -355,6 +416,14 @@ static int imx8mp_clk_probe(struct udevice *dev)
 	clk_dm(IMX8MP_CLK_WDOG2_ROOT, imx_clk_gate4("wdog2_root_clk", "wdog", base + 0x4540, 0));
 	clk_dm(IMX8MP_CLK_WDOG3_ROOT, imx_clk_gate4("wdog3_root_clk", "wdog", base + 0x4550, 0));
 	clk_dm(IMX8MP_CLK_HSIO_ROOT, imx_clk_gate4("hsio_root_clk", "ipg_root", base + 0x45c0, 0));
+#if CONFIG_IS_ENABLED(VIDEO)
+	clk_dm(IMX8MP_CLK_MEDIA_APB_ROOT, imx_clk_gate2_shared2("media_apb_root_clk", "media_apb", base + 0x45d0, 0, &share_count_media));
+	clk_dm(IMX8MP_CLK_MEDIA_AXI_ROOT, imx_clk_gate2_shared2("media_axi_root_clk", "media_axi", base + 0x45d0, 0, &share_count_media));
+	clk_dm(IMX8MP_CLK_MEDIA_DISP1_PIX_ROOT, imx_clk_gate2_shared2("media_disp1_pix_root_clk", "media_disp1_pix", base + 0x45d0, 0, &share_count_media));
+	clk_dm(IMX8MP_CLK_MEDIA_DISP2_PIX_ROOT, imx_clk_gate2_shared2("media_disp2_pix_root_clk", "media_disp2_pix", base + 0x45d0, 0, &share_count_media));
+	clk_dm(IMX8MP_CLK_MEDIA_LDB_ROOT, imx_clk_gate2_shared2("media_ldb_root_clk", "media_ldb", base + 0x45d0, 0, &share_count_media));
+	clk_dm(IMX8MP_CLK_MEDIA_ISP_ROOT, imx_clk_gate2_shared2("media_isp_root_clk", "media_isp", base + 0x45d0, 0, &share_count_media));
+#endif
 
 	clk_dm(IMX8MP_CLK_USDHC3_ROOT, imx_clk_gate4("usdhc3_root_clk", "usdhc3", base + 0x45e0, 0));
 

-- 
2.47.0

