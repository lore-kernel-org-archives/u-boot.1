Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB31EB64DE
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 10:14:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 952378900C;
	Tue, 10 Sep 2024 12:14:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="oiPSTE7Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F31188F65; Tue, 10 Sep 2024 12:14:01 +0200 (CEST)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net
 [217.70.183.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C93038900C
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 12:13:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9058D24000C;
 Tue, 10 Sep 2024 10:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1725963227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yJY/3A9Q+JUoMFWierSm+dEnGefp+U2I3PhYBgVx+Qw=;
 b=oiPSTE7YKRgM9nX5fZAhM5eeCkZtspFfP3rOl3WpZ6xvsdt06OpFrkQh4IueA6F4//RRQa
 IvTGg0S0LZM64+SXoPadnpeWVPMAZSLX8vikB95K2QbdiSPqUlZGgjrXdFsE0IqtkJLkOJ
 oD0j9pUTO9gEMBgpU28Mu3rotReOcJmFnlBzhj5JCJJAJ6StdNPPuTNnXSjs7vHzxP1QDR
 KoAUbLZB+yo560VGCFuy2aBqeaLIU3jAuXzkEoRC8H2zKrpNbKFb6O52N72xLk5nTRrMzx
 PKRDqV3XSympF5bRwt+ExkuLL6svByfp5Lrq/yl8vPFS/yetiQ7ocr+oG2pNHg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>
Cc: <u-boot@lists.denx.de>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Ian Ray <ian.ray@gehealthcare.com>, Marek Vasut <marek.vasut@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 3/8] clk: imx8mp: Add media related clocks
Date: Tue, 10 Sep 2024 12:13:39 +0200
Message-ID: <20240910101344.110633-4-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240910101344.110633-1-miquel.raynal@bootlin.com>
References: <20240910101344.110633-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 drivers/clk/imx/clk-imx8mp.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index 7dfc829df2c..92c5d8441c0 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -15,7 +15,10 @@
 
 #include "clk.h"
 
+static u32 share_count_media;
+
 static const char *pll_ref_sels[] = { "clock-osc-24m", "dummy", "dummy", "dummy", };
+static const char *video_pll1_bypass_sels[] = {"video_pll1", "video_pll1_ref_sel", };
 static const char *dram_pll_bypass_sels[] = {"dram_pll", "dram_pll_ref_sel", };
 static const char *arm_pll_bypass_sels[] = {"arm_pll", "arm_pll_ref_sel", };
 static const char *sys_pll1_bypass_sels[] = {"sys_pll1", "sys_pll1_ref_sel", };
@@ -42,6 +45,14 @@ static const char *imx8mp_nand_usdhc_sels[] = {"clock-osc-24m", "sys_pll1_266m",
 					       "sys_pll2_200m", "sys_pll1_133m", "sys_pll3_out",
 					       "sys_pll2_250m", "audio_pll1_out", };
 
+static const char *imx8mp_media_axi_sels[] = {"clock-osc-24m", "sys_pll2_1000m", "sys_pll1_800m",
+					      "sys_pll3_out", "sys_pll1_40m", "audio_pll2_out",
+					      "clk_ext1", "sys_pll2_500m", };
+
+static const char *imx8mp_media_apb_sels[] = {"clock-osc-24m", "sys_pll2_125m", "sys_pll1_800m",
+					      "sys_pll3_out", "sys_pll1_40m", "audio_pll2_out",
+					      "clk_ext1", "sys_pll1_133m", };
+
 static const char *imx8mp_noc_sels[] = {"clock-osc-24m", "sys_pll1_800m", "sys_pll3_out",
 					"sys_pll2_1000m", "sys_pll2_500m", "audio_pll1_out",
 					"video_pll1_out", "audio_pll2_out", };
@@ -174,6 +185,15 @@ static const char *imx8mp_usdhc3_sels[] = {"clock-osc-24m", "sys_pll1_400m", "sy
 					   "sys_pll2_500m", "sys_pll3_out", "sys_pll1_266m",
 					   "audio_pll2_out", "sys_pll1_100m", };
 
+static const char *imx8mp_media_disp_pix_sels[] = {"clock-osc-24m", "video_pll1_out", "audio_pll2_out",
+						   "audio_pll1_out", "sys_pll1_800m",
+						   "sys_pll2_1000m", "sys_pll3_out", "clk_ext4", };
+
+static const char *imx8mp_media_ldb_sels[] = {"clock-osc-24m", "sys_pll2_333m", "sys_pll2_100m",
+						     "sys_pll1_800m", "sys_pll2_1000m",
+						     "clk_ext2", "audio_pll2_out",
+						     "video_pll1_out", };
+
 static const char *imx8mp_enet_ref_sels[] = {"clock-osc-24m", "sys_pll2_125m", "sys_pll2_50m",
 					     "sys_pll2_100m", "sys_pll1_160m", "audio_pll1_out",
 					     "video_pll1_out", "clk_ext4", };
@@ -196,12 +216,15 @@ static int imx8mp_clk_probe(struct udevice *dev)
 
 	base = (void *)ANATOP_BASE_ADDR;
 
+	clk_dm(IMX8MP_VIDEO_PLL1_REF_SEL, imx_clk_mux("video_pll1_ref_sel", base + 0x28, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
 	clk_dm(IMX8MP_DRAM_PLL_REF_SEL, imx_clk_mux("dram_pll_ref_sel", base + 0x50, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
 	clk_dm(IMX8MP_ARM_PLL_REF_SEL, imx_clk_mux("arm_pll_ref_sel", base + 0x84, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
 	clk_dm(IMX8MP_SYS_PLL1_REF_SEL, imx_clk_mux("sys_pll1_ref_sel", base + 0x94, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
 	clk_dm(IMX8MP_SYS_PLL2_REF_SEL, imx_clk_mux("sys_pll2_ref_sel", base + 0x104, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
 	clk_dm(IMX8MP_SYS_PLL3_REF_SEL, imx_clk_mux("sys_pll3_ref_sel", base + 0x114, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
 
+	clk_dm(IMX8MP_VIDEO_PLL1, imx_clk_pll14xx("video_pll1", "video_pll1_ref_sel", base + 0x28,
+						  &imx_1443x_pll));
 	clk_dm(IMX8MP_DRAM_PLL, imx_clk_pll14xx("dram_pll", "dram_pll_ref_sel", base + 0x50,
 						&imx_1443x_dram_pll));
 	clk_dm(IMX8MP_ARM_PLL, imx_clk_pll14xx("arm_pll", "arm_pll_ref_sel", base + 0x84,
@@ -213,12 +236,14 @@ static int imx8mp_clk_probe(struct udevice *dev)
 	clk_dm(IMX8MP_SYS_PLL3, imx_clk_pll14xx("sys_pll3", "sys_pll3_ref_sel", base + 0x114,
 						&imx_1416x_pll));
 
+	clk_dm(IMX8MP_VIDEO_PLL1_BYPASS, imx_clk_mux_flags("video_pll1_bypass", base + 0x28, 16, 1, video_pll1_bypass_sels, ARRAY_SIZE(video_pll1_bypass_sels), CLK_SET_RATE_PARENT));
 	clk_dm(IMX8MP_DRAM_PLL_BYPASS, imx_clk_mux_flags("dram_pll_bypass", base + 0x50, 4, 1, dram_pll_bypass_sels, ARRAY_SIZE(dram_pll_bypass_sels), CLK_SET_RATE_PARENT));
 	clk_dm(IMX8MP_ARM_PLL_BYPASS, imx_clk_mux_flags("arm_pll_bypass", base + 0x84, 4, 1, arm_pll_bypass_sels, ARRAY_SIZE(arm_pll_bypass_sels), CLK_SET_RATE_PARENT));
 	clk_dm(IMX8MP_SYS_PLL1_BYPASS, imx_clk_mux_flags("sys_pll1_bypass", base + 0x94, 4, 1, sys_pll1_bypass_sels, ARRAY_SIZE(sys_pll1_bypass_sels), CLK_SET_RATE_PARENT));
 	clk_dm(IMX8MP_SYS_PLL2_BYPASS, imx_clk_mux_flags("sys_pll2_bypass", base + 0x104, 4, 1, sys_pll2_bypass_sels, ARRAY_SIZE(sys_pll2_bypass_sels), CLK_SET_RATE_PARENT));
 	clk_dm(IMX8MP_SYS_PLL3_BYPASS, imx_clk_mux_flags("sys_pll3_bypass", base + 0x114, 4, 1, sys_pll3_bypass_sels, ARRAY_SIZE(sys_pll3_bypass_sels), CLK_SET_RATE_PARENT));
 
+	clk_dm(IMX8MP_VIDEO_PLL1_OUT, imx_clk_gate("video_pll1_out", "video_pll1_bypass", base + 0x28, 13));
 	clk_dm(IMX8MP_DRAM_PLL_OUT, imx_clk_gate("dram_pll_out", "dram_pll_bypass", base + 0x50, 13));
 	clk_dm(IMX8MP_ARM_PLL_OUT, imx_clk_gate("arm_pll_out", "arm_pll_bypass", base + 0x84, 11));
 	clk_dm(IMX8MP_SYS_PLL1_OUT, imx_clk_gate("sys_pll1_out", "sys_pll1_bypass", base + 0x94, 11));
@@ -267,10 +292,13 @@ static int imx8mp_clk_probe(struct udevice *dev)
 	clk_dm(IMX8MP_CLK_MAIN_AXI, imx8m_clk_composite_critical("main_axi", imx8mp_main_axi_sels, base + 0x8800));
 	clk_dm(IMX8MP_CLK_ENET_AXI, imx8m_clk_composite_critical("enet_axi", imx8mp_enet_axi_sels, base + 0x8880));
 	clk_dm(IMX8MP_CLK_NAND_USDHC_BUS, imx8m_clk_composite_critical("nand_usdhc_bus", imx8mp_nand_usdhc_sels, base + 0x8900));
+	clk_dm(IMX8MP_CLK_MEDIA_AXI, imx8m_clk_composite("media_axi", imx8mp_media_axi_sels, base + 0x8a00));
+	clk_dm(IMX8MP_CLK_MEDIA_APB, imx8m_clk_composite("media_apb", imx8mp_media_apb_sels, base + 0x8a80));
 	clk_dm(IMX8MP_CLK_NOC, imx8m_clk_composite_critical("noc", imx8mp_noc_sels, base + 0x8d00));
 	clk_dm(IMX8MP_CLK_NOC_IO, imx8m_clk_composite_critical("noc_io", imx8mp_noc_io_sels, base + 0x8d80));
 
 	clk_dm(IMX8MP_CLK_AHB, imx8m_clk_composite_critical("ahb_root", imx8mp_ahb_sels, base + 0x9000));
+	clk_dm(IMX8MP_CLK_MEDIA_DISP2_PIX, imx8m_clk_composite("media_disp2_pix", imx8mp_media_disp_pix_sels, base + 0x9300));
 
 	clk_dm(IMX8MP_CLK_IPG_ROOT, imx_clk_divider2("ipg_root", "ahb_root", base + 0x9080, 0, 1));
 
@@ -309,6 +337,8 @@ static int imx8mp_clk_probe(struct udevice *dev)
 
 	clk_dm(IMX8MP_CLK_WDOG, imx8m_clk_composite("wdog", imx8mp_wdog_sels, base + 0xb900));
 	clk_dm(IMX8MP_CLK_USDHC3, imx8m_clk_composite("usdhc3", imx8mp_usdhc3_sels, base + 0xbc80));
+	clk_dm(IMX8MP_CLK_MEDIA_DISP1_PIX, imx8m_clk_composite("media_disp1_pix", imx8mp_media_disp_pix_sels, base + 0xbe00));
+	clk_dm(IMX8MP_CLK_MEDIA_LDB, imx8m_clk_composite("media_ldb", imx8mp_media_ldb_sels, base + 0xbf00));
 
 	clk_dm(IMX8MP_CLK_DRAM_ALT_ROOT, imx_clk_fixed_factor("dram_alt_root", "dram_alt", 1, 4));
 	clk_dm(IMX8MP_CLK_DRAM_CORE, imx_clk_mux2_flags("dram_core_clk", base + 0x9800, 24, 1, imx8mp_dram_core_sels, ARRAY_SIZE(imx8mp_dram_core_sels), CLK_IS_CRITICAL));
@@ -352,6 +382,11 @@ static int imx8mp_clk_probe(struct udevice *dev)
 	clk_dm(IMX8MP_CLK_WDOG2_ROOT, imx_clk_gate4("wdog2_root_clk", "wdog", base + 0x4540, 0));
 	clk_dm(IMX8MP_CLK_WDOG3_ROOT, imx_clk_gate4("wdog3_root_clk", "wdog", base + 0x4550, 0));
 	clk_dm(IMX8MP_CLK_HSIO_ROOT, imx_clk_gate4("hsio_root_clk", "ipg_root", base + 0x45c0, 0));
+	clk_dm(IMX8MP_CLK_MEDIA_APB_ROOT, imx_clk_gate2_shared2("media_apb_root_clk", "media_apb", base + 0x45d0, 0, &share_count_media));
+	clk_dm(IMX8MP_CLK_MEDIA_AXI_ROOT, imx_clk_gate2_shared2("media_axi_root_clk", "media_axi", base + 0x45d0, 0, &share_count_media));
+	clk_dm(IMX8MP_CLK_MEDIA_DISP1_PIX_ROOT, imx_clk_gate2_shared2("media_disp1_pix_root_clk", "media_disp1_pix", base + 0x45d0, 0, &share_count_media));
+	clk_dm(IMX8MP_CLK_MEDIA_DISP2_PIX_ROOT, imx_clk_gate2_shared2("media_disp2_pix_root_clk", "media_disp2_pix", base + 0x45d0, 0, &share_count_media));
+	clk_dm(IMX8MP_CLK_MEDIA_LDB_ROOT, imx_clk_gate2_shared2("media_ldb_root_clk", "media_ldb", base + 0x45d0, 0, &share_count_media));
 
 	clk_dm(IMX8MP_CLK_USDHC3_ROOT, imx_clk_gate4("usdhc3_root_clk", "usdhc3", base + 0x45e0, 0));
 
-- 
2.43.0

