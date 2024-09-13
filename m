Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B31FA3737
	for <u-boot@archiver.kernel.org>; Fri, 13 Sep 2024 09:57:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0284488CD8;
	Fri, 13 Sep 2024 11:57:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="YGFp/klG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4144788C24; Fri, 13 Sep 2024 11:57:09 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCA9488C39
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 11:57:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a8d0d82e76aso281258566b.3
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 02:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1726221423; x=1726826223;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PyaFmNCSWcMYfKku/Mr27YgQakO6Oi+2kFb/osBneFg=;
 b=YGFp/klGXXjR6UP3s/y/hd4lpsxP6BH23JHFb9FFww8k12xOzXEFB3+ZTBlJ0kokfx
 LfzoXA3ELHzkAJnERjty9lodmG895X0xlBXAtkWvq/7rEScRT278JsunxkCKG7DCStbX
 06u6WTiNoOJ3fZ0RmSANHUrniwQjukjEs96kI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726221423; x=1726826223;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PyaFmNCSWcMYfKku/Mr27YgQakO6Oi+2kFb/osBneFg=;
 b=mioAXqAqxdr7qKMee4mAFAVcGUG1vEKhgjAfCdmLrJsiRrudZCwin7TzefVmxIdT7f
 YDYzcrZ3sTN4BgXkjhP7ZlSJ6yLJUcMe7sV7aESqn/p4DrCk1Bonz8nsxl5A9suFW3le
 3FQ/ky38m1ocarqS8x38QTrjPfrIQaQW0M3vhCfNviA7BTUyIg0VlI3qkwwNkD2mYguh
 tb6ObmKdvpkiWxEJdK51WI6t4f4vMOG6N5X6fmhbwTGb+Z9V19+GDU8QqVXASF73mqZT
 qvqLvsuR52X/xUf9sRToV4a4FTeh3KA3TbXBGXHRZ4912qBYDQVhjv0QfvW9lPCJEOJE
 Btng==
X-Gm-Message-State: AOJu0YzkV04qRcgWLFdIP3NL3UA55d5AjPiNqhsxk90Cp5Q3lhZfhNmK
 ACOuAKdUHEa8e1e/dTGKYsdfxhWQl/TNhoINqqupxTsr5KmEvuMv0PxZenO0UDvM0lO0KfVg1L+
 M664=
X-Google-Smtp-Source: AGHT+IHAfMm1PZAMkvL327dmL+JIUkF2E1cb6fQZ6MZsOtyavWJg1vJzSU353la0Gb/zhIueRghioQ==
X-Received: by 2002:a17:907:c7c4:b0:a86:7021:1368 with SMTP id
 a640c23a62f3a-a9029434ca4mr601239966b.21.1726221423050; 
 Fri, 13 Sep 2024 02:57:03 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it
 (host-87-4-102-18.retail.telecomitalia.it. [87.4.102.18])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25cee72bsm863224766b.173.2024.09.13.02.57.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 02:57:02 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@denx.de>, linux-amarula@amarulasolutions.com,
 michael@amarulasolutions.com, Miquel Raynal <miquel.raynal@bootlin.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marex@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 03/26] clk: imx8mm: Prevent clock critical path from disabling
 during reparent and set_rate
Date: Fri, 13 Sep 2024 11:55:45 +0200
Message-ID: <20240913095622.72377-4-dario.binacchi@amarulasolutions.com>
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

This commit ensures that critical clock paths are not disabled during
reparent and set_rate operations within the clock framework, paving the
way for the inclusion of new features.

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/clk/imx/clk-imx8mm.c | 64 +++++++++++++++++++++++++++++-------
 1 file changed, 52 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
index a91c6767fac5..432348a15cad 100644
--- a/drivers/clk/imx/clk-imx8mm.c
+++ b/drivers/clk/imx/clk-imx8mm.c
@@ -27,11 +27,25 @@ static const char * const imx8mm_a53_sels[] = {"clock-osc-24m", "arm_pll_out", "
 					       "sys_pll2_1000m", "sys_pll1_800m", "sys_pll1_400m",
 					       "audio_pll1_out", "sys_pll3_out", };
 
+#ifndef CONFIG_SPL_BUILD
+static const char * const imx8mm_noc_sels[] = {"clock-osc-24m", "sys_pll1_800m", "sys_pll3_out",
+					       "sys_pll2_1000m", "sys_pll2_500m", "audio_pll1_out",
+					       "video_pll1_out", "audio_pll2_out", };
+
+static const char * const imx8mm_noc_apb_sels[] = {"clock-osc-24m", "sys_pll1_400m", "sys_pll3_out",
+						   "sys_pll2_333m", "sys_pll2_200m",
+						   "sys_pll1_800m", "audio_pll1_out",
+						   "video_pll1_out", };
+
 static const char * const imx8mm_ahb_sels[] = {"clock-osc-24m", "sys_pll1_133m", "sys_pll1_800m",
 					       "sys_pll1_400m", "sys_pll2_125m", "sys_pll3_out",
 					       "audio_pll1_out", "video_pll1_out", };
 
-#ifndef CONFIG_SPL_BUILD
+static const char * const imx8mm_main_axi_sels[] = {"clock-osc-24m", "sys_pll2_333m",
+						    "sys_pll1_800m", "sys_pll2_250m",
+						    "sys_pll2_1000m", "audio_pll1_out",
+						    "video_pll1_out", "sys_pll1_100m",};
+
 static const char * const imx8mm_enet_axi_sels[] = {"clock-osc-24m", "sys_pll1_266m", "sys_pll1_800m",
 						    "sys_pll2_250m", "sys_pll2_200m", "audio_pll1_out",
 						    "video_pll1_out", "sys_pll3_out", };
@@ -47,6 +61,11 @@ static const char * const imx8mm_enet_timer_sels[] = {"clock-osc-24m", "sys_pll2
 static const char * const imx8mm_enet_phy_sels[] = {"clock-osc-24m", "sys_pll2_50m", "sys_pll2_125m",
 						    "sys_pll2_200m", "sys_pll2_500m", "video_pll1_out",
 						    "audio_pll2_out", };
+
+static const char * const imx8mm_dram_apb_sels[] = {"clock-osc-24m", "sys_pll2_200m",
+						    "sys_pll1_40m", "sys_pll1_160m",
+						    "sys_pll1_800m", "sys_pll3_out",
+						    "sys_pll2_250m", "audio_pll2_out", };
 #endif
 
 static const char * const imx8mm_nand_usdhc_sels[] = {"clock-osc-24m", "sys_pll1_266m", "sys_pll1_800m",
@@ -82,8 +101,9 @@ static const char * const imx8mm_i2c4_sels[] = {"clock-osc-24m", "sys_pll1_160m"
 						"audio_pll2_out", "sys_pll1_133m", };
 
 #if CONFIG_IS_ENABLED(PCIE_DW_IMX)
-static const char * const imx8mm_pcie1_ctrl_sels[] = {"clock-osc-24m", "sys_pll2_250m", "sys_pll2_200m",
-						      "sys_pll1_266m", "sys_pll1_800m", "sys_pll2_500m",
+static const char * const imx8mm_pcie1_ctrl_sels[] = {"clock-osc-24m", "sys_pll2_250m",
+						      "sys_pll2_200m", "sys_pll1_266m",
+						      "sys_pll1_800m", "sys_pll2_500m",
 						      "sys_pll2_333m", "sys_pll3_out", };
 
 static const char * const imx8mm_pcie1_phy_sels[] = {"clock-osc-24m", "sys_pll2_100m", "sys_pll2_500m",
@@ -135,6 +155,10 @@ static const char * const imx8mm_usb_phy_sels[] = {"clock-osc-24m", "sys_pll1_10
 						   "sys_pll2_100m", "sys_pll2_200m", "clk_ext2",
 						   "clk_ext3", "audio_pll2_out", };
 
+static const char * const imx8mm_gic_sels[] = {"clock-osc-24m", "sys_pll2_200m", "sys_pll1_40m",
+					       "sys_pll2_100m", "sys_pll1_800m", "clk_ext2",
+					       "clk_ext4", "audio_pll2_out" };
+
 #if CONFIG_IS_ENABLED(DM_SPI)
 static const char * const imx8mm_ecspi1_sels[] = {"clock-osc-24m", "sys_pll2_200m", "sys_pll1_40m",
 						  "sys_pll1_160m", "sys_pll1_800m", "sys_pll3_out",
@@ -283,18 +307,34 @@ static int imx8mm_clk_probe(struct udevice *dev)
 	       imx_clk_divider2("arm_a53_div", "arm_a53_cg",
 				base + 0x8000, 0, 3));
 
-	clk_dm(IMX8MM_CLK_AHB,
-	       imx8m_clk_composite_critical("ahb", imx8mm_ahb_sels,
-					    base + 0x9000));
 	clk_dm(IMX8MM_CLK_IPG_ROOT,
 	       imx_clk_divider2("ipg_root", "ahb", base + 0x9080, 0, 1));
 
+#ifndef CONFIG_SPL_BUILD
+	/* BUS */
+	clk_dm(IMX8MM_CLK_MAIN_AXI,
+	       imx8m_clk_composite_critical("main_axi",
+					    imx8mm_main_axi_sels, base + 0x8800));
+	clk_dm(IMX8MM_CLK_ENET_AXI,
+	       imx8m_clk_composite("enet_axi", imx8mm_enet_axi_sels, base + 0x8880));
+	clk_dm(IMX8MM_CLK_NOC,
+	       imx8m_clk_composite_critical("noc", imx8mm_noc_sels, base + 0x8d00));
+	clk_dm(IMX8MM_CLK_NOC_APB,
+	       imx8m_clk_composite_critical("noc_apb", imx8mm_noc_apb_sels,
+					    base + 0x8d80));
+	clk_dm(IMX8MM_CLK_AHB,
+	       imx8m_clk_composite_critical("ahb", imx8mm_ahb_sels, base + 0x9000));
+	clk_dm(IMX8MM_CLK_DRAM_APB,
+	       imx8m_clk_composite_critical("dram_apb", imx8mm_dram_apb_sels,
+					    base + 0xa080));
+#endif
+
 	clk_dm(IMX8MM_CLK_NAND_USDHC_BUS,
-	       imx8m_clk_composite_critical("nand_usdhc_bus",
-					    imx8mm_nand_usdhc_sels,
+	       imx8m_clk_composite_critical("nand_usdhc_bus", imx8mm_nand_usdhc_sels,
 					    base + 0x8900));
+
 	clk_dm(IMX8MM_CLK_USB_BUS,
-		imx8m_clk_composite("usb_bus", imx8mm_usb_bus_sels, base + 0x8b80));
+	       imx8m_clk_composite("usb_bus", imx8mm_usb_bus_sels, base + 0x8b80));
 
 	/* IP */
 #if CONFIG_IS_ENABLED(PCIE_DW_IMX)
@@ -358,9 +398,6 @@ static int imx8mm_clk_probe(struct udevice *dev)
 
 	/* clks not needed in SPL stage */
 #ifndef CONFIG_SPL_BUILD
-	clk_dm(IMX8MM_CLK_ENET_AXI,
-	       imx8m_clk_composite("enet_axi", imx8mm_enet_axi_sels,
-				   base + 0x8880));
 	clk_dm(IMX8MM_CLK_ENET_REF,
 	       imx8m_clk_composite("enet_ref", imx8mm_enet_ref_sels,
 	       base + 0xa980));
@@ -396,6 +433,9 @@ static int imx8mm_clk_probe(struct udevice *dev)
 	       imx_clk_gate4("pcie1_root_clk", "pcie1_ctrl", base + 0x4250, 0));
 #endif
 
+	clk_dm(IMX8MM_CLK_GIC,
+	       imx8m_clk_composite_critical("gic", imx8mm_gic_sels, base + 0xb200));
+
 #if CONFIG_IS_ENABLED(DM_SPI)
 	clk_dm(IMX8MM_CLK_ECSPI1,
 	       imx8m_clk_composite("ecspi1", imx8mm_ecspi1_sels, base + 0xb280));
-- 
2.43.0

