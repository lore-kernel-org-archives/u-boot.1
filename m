Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2746FA3738
	for <u-boot@archiver.kernel.org>; Fri, 13 Sep 2024 09:58:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 168FF88D3C;
	Fri, 13 Sep 2024 11:57:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="RoFkZ48j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC10588BC0; Fri, 13 Sep 2024 11:57:14 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD07088C40
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 11:57:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-53661ac5ba1so2089313e87.2
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 02:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1726221429; x=1726826229;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tkMh91Hn86vFyByeQQFNsm5+zhBASEKSgno6mbETJI4=;
 b=RoFkZ48jbWcJacKCQ+tWOk78sVmYLzTj5WwFmmFggGOuBGu+2M8OtUIOmU8GZzioV3
 IdhJG6B9FG2/kV3/H+j+Ies4hPKMBj27adUxbgcqheZivjbn7teB7i6jOxCHPZN8R7gK
 NjYA/SnXDhXSFxfIYdNV/baFQCqb6KYrVh+E4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726221429; x=1726826229;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tkMh91Hn86vFyByeQQFNsm5+zhBASEKSgno6mbETJI4=;
 b=ad1wlJ2fGoBcFhPwLzdGZA5wIokRBmLJma1r6c3XgaUJoE3Tl6Dosum92DhqQwxHSj
 F1+94roKOkDM+7b4FAdK+3vkgiIeOY6siTedtECTXUGDKXRPFEtRiS1xJxcJHUUwqkeK
 CQThhTo2Uqr29RiuhtrEq/Goywielmbo8UPg0B6moGJaILEIMI+5CVWSDMmTBT7Hije4
 VybCO6EZPaBI3Ep4l1RvvZTMHEW4LZL8L4j7FfP4zf/8Ptw/toJXwFhMCFBS77PKr3sY
 +zEtSK2Ep6K1R0Jj9iS3L5LN0g0vw3sMtQmVc5SiaNWUsCVg94srsPdNS/e8R2cfErSD
 2GNg==
X-Gm-Message-State: AOJu0YxfU+dcUaSMrfgOW270gJxMpXoCrSg4HTZe8hUT/Gipajl48nFe
 6lGMyE902NRRkTIIGjXQEvnNKpAnjxTeNnsLF3c91jNPD9ydKFCsbgn/34aYltqsLvtzNMfnF/V
 eOmk=
X-Google-Smtp-Source: AGHT+IH/FBy0PVRRdjSZYohfWpkIsAMYxZTuohn9KL+HZUmX9psFi8l67FIW2lU4BJ2NX4wkpfTFJw==
X-Received: by 2002:a05:6512:3d23:b0:52c:99c9:bef6 with SMTP id
 2adb3069b0e04-53678fb1929mr3438130e87.7.1726221427752; 
 Fri, 13 Sep 2024 02:57:07 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it
 (host-87-4-102-18.retail.telecomitalia.it. [87.4.102.18])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25cee72bsm863224766b.173.2024.09.13.02.57.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 02:57:07 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@denx.de>, linux-amarula@amarulasolutions.com,
 michael@amarulasolutions.com, Miquel Raynal <miquel.raynal@bootlin.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Fabio Estevam <festevam@gmail.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Lukasz Majewski <lukma@denx.de>,
 Nicolas Heemeryck <nicolas.heemeryck@devialet.com>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 07/26] clk: imx8mn: add video clocks support
Date: Fri, 13 Sep 2024 11:55:49 +0200
Message-ID: <20240913095622.72377-8-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240913095622.72377-1-dario.binacchi@amarulasolutions.com>
References: <20240913095622.72377-1-dario.binacchi@amarulasolutions.com>
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

From: Michael Trimarchi <michael@amarulasolutions.com>

Add clocks support for the video subsystem.

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/clk/imx/clk-imx8mn.c | 97 +++++++++++++++++++++++++++++++++---
 1 file changed, 90 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index 449ebf2d0733..7ea4c90fa137 100644
--- a/drivers/clk/imx/clk-imx8mn.c
+++ b/drivers/clk/imx/clk-imx8mn.c
@@ -17,6 +17,7 @@
 static u32 share_count_nand;
 
 static const char * const pll_ref_sels[] = { "clock-osc-24m", "dummy", "dummy", "dummy", };
+static const char * const video_pll_bypass_sels[] = {"video_pll", "video_pll_ref_sel", };
 static const char * const dram_pll_bypass_sels[] = {"dram_pll", "dram_pll_ref_sel", };
 static const char * const arm_pll_bypass_sels[] = {"arm_pll", "arm_pll_ref_sel", };
 static const char * const sys_pll1_bypass_sels[] = {"sys_pll1", "sys_pll1_ref_sel", };
@@ -47,17 +48,52 @@ static const char * const imx8mn_enet_axi_sels[] = {"clock-osc-24m", "sys_pll1_2
 						    "video_pll_out", "sys_pll3_out", };
 
 #ifndef CONFIG_SPL_BUILD
-static const char * const imx8mn_enet_ref_sels[] = {"clock-osc-24m", "sys_pll2_125m", "sys_pll2_50m",
-						    "sys_pll2_100m", "sys_pll1_160m", "audio_pll1_out",
+static const char * const imx8mn_disp_axi_sels[] = {"clock-osc-24m", "sys_pll2_1000m",
+						    "sys_pll1_800m", "sys_pll3_out", "sys_pll1_40m",
+						    "audio_pll2_out", "clk_ext1", "clk_ext4", };
+
+static const char * const imx8mn_disp_apb_sels[] = {"clock-osc-24m", "sys_pll2_125m",
+						    "sys_pll1_800m", "sys_pll3_out", "sys_pll1_40m",
+						    "audio_pll2_out", "clk_ext1", "clk_ext3", };
+
+static const char * const imx8mn_disp_pixel_sels[] = {"clock-osc-24m", "video_pll_out",
+						      "audio_pll2_out", "audio_pll1_out",
+						      "sys_pll1_800m", "sys_pll2_1000m",
+						      "sys_pll3_out", "clk_ext4", };
+
+static const char * const imx8mn_dsi_core_sels[] = {"clock-osc-24m", "sys_pll1_266m",
+						    "sys_pll2_250m", "sys_pll1_800m",
+						    "sys_pll2_1000m", "sys_pll3_out",
+						    "audio_pll2_out", "video_pll_out", };
+
+static const char * const imx8mn_dsi_phy_sels[] = {"clock-osc-24m", "sys_pll2_125m",
+						   "sys_pll2_100m", "sys_pll1_800m",
+						   "sys_pll2_1000m", "clk_ext2",
+						   "audio_pll2_out", "video_pll_out", };
+
+static const char * const imx8mn_dsi_dbi_sels[] = {"clock-osc-24m", "sys_pll1_266m",
+						   "sys_pll2_100m", "sys_pll1_800m",
+						   "sys_pll2_1000m", "sys_pll3_out",
+						   "audio_pll2_out", "video_pll_out", };
+
+static const char * const imx8mn_camera_pixel_sels[] = {"clock-osc-24m", "sys_pll1_266m",
+							"sys_pll2_250m", "sys_pll1_800m",
+							"sys_pll2_1000m", "sys_pll3_out",
+							"audio_pll2_out", "video_pll_out", };
+
+static const char * const imx8mn_enet_ref_sels[] = {"clock-osc-24m", "sys_pll2_125m",
+						    "sys_pll2_50m", "sys_pll2_100m",
+						    "sys_pll1_160m", "audio_pll1_out",
 						    "video_pll_out", "clk_ext4", };
 
-static const char * const imx8mn_enet_timer_sels[] = {"clock-osc-24m", "sys_pll2_100m", "audio_pll1_out",
-						      "clk_ext1", "clk_ext2", "clk_ext3",
-						      "clk_ext4", "video_pll_out", };
+static const char * const imx8mn_enet_timer_sels[] = {"clock-osc-24m", "sys_pll2_100m",
+						      "audio_pll1_out", "clk_ext1", "clk_ext2",
+						      "clk_ext3", "clk_ext4", "video_pll_out", };
 
 static const char * const imx8mn_enet_phy_sels[] = {"clock-osc-24m", "sys_pll2_50m", "sys_pll2_125m",
-						    "sys_pll2_200m", "sys_pll2_500m", "audio_pll1_out",
-						    "video_pll_out", "audio_pll2_out", };
+						    "sys_pll2_200m", "sys_pll2_500m",
+						    "audio_pll1_out", "video_pll_out",
+						    "audio_pll2_out", };
 #endif
 
 static const char * const imx8mn_nand_usdhc_sels[] = {"clock-osc-24m", "sys_pll1_266m", "sys_pll1_800m",
@@ -151,6 +187,10 @@ static const char * const imx8mn_usb_phy_sels[] = {"clock-osc-24m", "sys_pll1_10
 						   "sys_pll2_100m", "sys_pll2_200m", "clk_ext2",
 						   "clk_ext3", "audio_pll2_out", };
 
+#ifndef CONFIG_SPL_BUILD
+static unsigned int share_count_disp;
+#endif
+
 static int imx8mn_clk_probe(struct udevice *dev)
 {
 	struct clk osc_24m_clk;
@@ -191,8 +231,19 @@ static int imx8mn_clk_probe(struct udevice *dev)
 	clk_dm(IMX8MN_SYS_PLL3,
 	       imx_clk_pll14xx("sys_pll3", "sys_pll3_ref_sel",
 			       base + 0x114, &imx_1416x_pll));
+	clk_dm(IMX8MN_VIDEO_PLL_REF_SEL,
+	       imx_clk_mux("video_pll_ref_sel", base + 0x28, 0, 2,
+			   pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
+	clk_dm(IMX8MN_VIDEO_PLL1,
+	       imx_clk_pll14xx("video_pll", "video_pll_ref_sel",
+			       base + 0x28, &imx_1443x_pll));
 
 	/* PLL bypass out */
+	clk_dm(IMX8MN_VIDEO_PLL_BYPASS,
+	       imx_clk_mux_flags("video_pll_bypass", base + 0x28, 16, 1,
+				 video_pll_bypass_sels,
+				 ARRAY_SIZE(video_pll_bypass_sels),
+				 CLK_SET_RATE_PARENT));
 	clk_dm(IMX8MN_DRAM_PLL_BYPASS,
 	       imx_clk_mux_flags("dram_pll_bypass", base + 0x50, 4, 1,
 				 dram_pll_bypass_sels,
@@ -220,6 +271,9 @@ static int imx8mn_clk_probe(struct udevice *dev)
 				 CLK_SET_RATE_PARENT));
 
 	/* PLL out gate */
+	clk_dm(IMX8MN_VIDEO_PLL_OUT,
+	       imx_clk_gate("video_pll_out", "video_pll_bypass",
+			    base + 0x28, 13));
 	clk_dm(IMX8MN_DRAM_PLL_OUT,
 	       imx_clk_gate("dram_pll_out", "dram_pll_bypass",
 			    base + 0x50, 13));
@@ -376,6 +430,35 @@ static int imx8mn_clk_probe(struct udevice *dev)
 
 	/* clks not needed in SPL stage */
 #ifndef CONFIG_SPL_BUILD
+	clk_dm(IMX8MN_CLK_DISP_AXI,
+	       imx8m_clk_composite("disp_axi", imx8mn_disp_axi_sels, base + 0x8a00));
+	clk_dm(IMX8MN_CLK_DISP_APB,
+	       imx8m_clk_composite("disp_apb", imx8mn_disp_apb_sels, base + 0x8a80));
+	clk_dm(IMX8MN_CLK_DISP_PIXEL,
+	       __imx8m_clk_composite("disp_pixel", imx8mn_disp_pixel_sels, base + 0xa500,
+				     CLK_SET_RATE_PARENT));
+	clk_dm(IMX8MN_CLK_DSI_CORE,
+	       imx8m_clk_composite("dsi_core", imx8mn_dsi_core_sels, base + 0xbb00));
+	clk_dm(IMX8MN_CLK_DSI_PHY_REF,
+	       imx8m_clk_composite("dsi_phy_ref", imx8mn_dsi_phy_sels, base + 0xbb80));
+	clk_dm(IMX8MN_CLK_DSI_DBI,
+	       imx8m_clk_composite("dsi_dbi", imx8mn_dsi_dbi_sels, base + 0xbc00));
+	clk_dm(IMX8MN_CLK_CAMERA_PIXEL,
+	       imx8m_clk_composite("camera_pixel", imx8mn_camera_pixel_sels, base + 0xbd00));
+
+	clk_dm(IMX8MN_CLK_DISP_AXI_ROOT,
+	       imx_clk_gate2_shared2("disp_axi_root_clk", "disp_axi", base + 0x45d0, 0,
+				     &share_count_disp));
+	clk_dm(IMX8MN_CLK_DISP_APB_ROOT,
+	       imx_clk_gate2_shared2("disp_apb_root_clk", "disp_apb", base + 0x45d0, 0,
+				     &share_count_disp));
+	clk_dm(IMX8MN_CLK_CAMERA_PIXEL_ROOT,
+	       imx_clk_gate2_shared2("camera_pixel_clk", "camera_pixel", base + 0x45d0, 0,
+				     &share_count_disp));
+	clk_dm(IMX8MN_CLK_DISP_PIXEL_ROOT,
+	       imx_clk_gate2_shared2("disp_pixel_clk", "disp_pixel", base + 0x45d0, 0,
+				     &share_count_disp));
+
 	clk_dm(IMX8MN_CLK_ENET_REF,
 	       imx8m_clk_composite("enet_ref", imx8mn_enet_ref_sels,
 	       base + 0xa980));
-- 
2.43.0

