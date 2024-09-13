Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96D10FA3736
	for <u-boot@archiver.kernel.org>; Fri, 13 Sep 2024 09:57:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D51688C10;
	Fri, 13 Sep 2024 11:57:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="AE1p+oh4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53B3488CAE; Fri, 13 Sep 2024 11:57:07 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C49C388C30
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 11:57:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a8d2daa2262so73638566b.1
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 02:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1726221422; x=1726826222;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YX5eqLwY3E1X9i2vX7+YausFj30i2Y01yBnLyTg+prA=;
 b=AE1p+oh4vYXgSfbTAZPLHWm8xZQFOziIsUpEdmWqggLoq3uCzngSU6Iy/mA41WmSz7
 65Dia2TzQqb9obfWfk0Wfu8rHwQ2Q4mqSGRU9w9rSNGxFmATK+RfovUU7hFppO7ua6OI
 AAxX0vc5SNllw791UOajfU4bK8YDFzM+FIto8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726221422; x=1726826222;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YX5eqLwY3E1X9i2vX7+YausFj30i2Y01yBnLyTg+prA=;
 b=ruvK2/CpovyiIdqOz7sY2GP+Oi9HL7W0aT7b/igk/dAYIL7FVd5Fs/40pdj/N5gmp+
 igxLgbjZArfodzyoHoygPRvh5zl5HNZLSTd1RLh0+0vEcALMMBW/mskRSBqkVV+yPKE9
 VU7oZkPIdq/GiHelq6xyxj5Ld5Q2pyKndPJrTC0eSpoW5RrIBeII14xVJ0w6nXbpQZG2
 I6MqMBdzEEOoPXgch9gLa7HoeUm+tyGi1EanXnzSJGfeMpZXDaUudtWSrJ+NzmH/JtpJ
 W7qh6KipY3jGUJgAJ9kQRfp2uA6bUQMJaER7HjkIHlo0NfDsjmfyVsAUDnjTZJw6tFAs
 Lyug==
X-Gm-Message-State: AOJu0YzmTLeFKGbxkGfvaTkIpAhQEgTYEVXP5qVPmIiBjnibEAiBLYN0
 EbE6hgpJTHGG4E/akb19DLpbhoVE5VBHFYyV8x05crMF1P7njLnYlMBkZvUoOf98/S59l5LRhnD
 yjDQ=
X-Google-Smtp-Source: AGHT+IEPLtzawOYeqKAfKEPdhaJXaMHnCmggooUE9darZu/TZjOX5E+evKTPdAV+olVTJY6XpRiKFQ==
X-Received: by 2002:a17:907:7f8a:b0:a8a:572c:709f with SMTP id
 a640c23a62f3a-a9047b4815emr154574166b.5.1726221421922; 
 Fri, 13 Sep 2024 02:57:01 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it
 (host-87-4-102-18.retail.telecomitalia.it. [87.4.102.18])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25cee72bsm863224766b.173.2024.09.13.02.57.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 02:57:01 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@denx.de>, linux-amarula@amarulasolutions.com,
 michael@amarulasolutions.com, Miquel Raynal <miquel.raynal@bootlin.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Fabio Estevam <festevam@gmail.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Lukasz Majewski <lukma@denx.de>,
 Nicolas Heemeryck <nicolas.heemeryck@devialet.com>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 02/26] clk: imx8mn: Prevent clock critical path from disabling
 during reparent and set_rate
Date: Fri, 13 Sep 2024 11:55:44 +0200
Message-ID: <20240913095622.72377-3-dario.binacchi@amarulasolutions.com>
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

 drivers/clk/imx/clk-imx8mn.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index 125215e84f41..c96a2ebaa19a 100644
--- a/drivers/clk/imx/clk-imx8mn.c
+++ b/drivers/clk/imx/clk-imx8mn.c
@@ -29,10 +29,19 @@ static const char * const imx8mn_a53_sels[] = {"clock-osc-24m", "arm_pll_out", "
 					       "sys_pll2_1000m", "sys_pll1_800m", "sys_pll1_400m",
 					       "audio_pll1_out", "sys_pll3_out", };
 
+static const char * const imx8mn_noc_sels[] = {"osc_24m", "sys_pll1_800m", "sys_pll3_out",
+					       "sys_pll2_1000m", "sys_pll2_500m", "audio_pll1_out",
+					       "video_pll_out", "audio_pll2_out", };
+
 static const char * const imx8mn_ahb_sels[] = {"clock-osc-24m", "sys_pll1_133m", "sys_pll1_800m",
 					       "sys_pll1_400m", "sys_pll2_125m", "sys_pll3_out",
 					       "audio_pll1_out", "video_pll_out", };
 
+static const char * const imx8mn_main_axi_sels[] = {"osc_24m", "sys_pll2_333m", "sys_pll1_800m",
+						    "sys_pll2_250m", "sys_pll2_1000m",
+						    "audio_pll1_out", "video_pll_out",
+						    "sys_pll1_100m",};
+
 static const char * const imx8mn_enet_axi_sels[] = {"clock-osc-24m", "sys_pll1_266m", "sys_pll1_800m",
 						    "sys_pll2_250m", "sys_pll2_200m", "audio_pll1_out",
 						    "video_pll_out", "sys_pll3_out", };
@@ -67,6 +76,9 @@ static const char * const imx8mn_usdhc2_sels[] = {"clock-osc-24m", "sys_pll1_400
 						  "sys_pll2_500m", "sys_pll3_out", "sys_pll1_266m",
 						  "audio_pll2_out", "sys_pll1_100m", };
 
+static const char * const imx8mn_gic_sels[] = {"clock-osc-24m", "sys_pll2_200m", "sys_pll1_40m",
+					       "sys_pll2_100m", "sys_pll1_800m", "clk_ext2",
+					       "clk_ext4", "audio_pll2_out" };
 #if CONFIG_IS_ENABLED(DM_SPI)
 static const char * const imx8mn_ecspi1_sels[] = {"clock-osc-24m", "sys_pll2_200m", "sys_pll1_40m",
 						  "sys_pll1_160m", "sys_pll1_800m", "sys_pll3_out",
@@ -286,15 +298,18 @@ static int imx8mn_clk_probe(struct udevice *dev)
 	clk_dm(IMX8MN_CLK_IPG_ROOT,
 	       imx_clk_divider2("ipg_root", "ahb", base + 0x9080, 0, 1));
 
+	/* BUS */
+	clk_dm(IMX8MN_CLK_MAIN_AXI,
+	       imx8m_clk_composite_critical("main_axi", imx8mn_main_axi_sels, base + 0x8800));
 	clk_dm(IMX8MN_CLK_ENET_AXI,
-	       imx8m_clk_composite("enet_axi", imx8mn_enet_axi_sels,
-				   base + 0x8880));
+	       imx8m_clk_composite("enet_axi", imx8mn_enet_axi_sels, base + 0x8880));
 	clk_dm(IMX8MN_CLK_NAND_USDHC_BUS,
-	       imx8m_clk_composite_critical("nand_usdhc_bus",
-					    imx8mn_nand_usdhc_sels,
+	       imx8m_clk_composite_critical("nand_usdhc_bus", imx8mn_nand_usdhc_sels,
 					    base + 0x8900));
 	clk_dm(IMX8MN_CLK_USB_BUS,
 		imx8m_clk_composite("usb_bus", imx8mn_usb_bus_sels, base + 0x8b80));
+	clk_dm(IMX8MN_CLK_NOC,
+	       imx8m_clk_composite_critical("noc", imx8mn_noc_sels, base + 0x8d00));
 
 	/* IP */
 	clk_dm(IMX8MN_CLK_USDHC1,
@@ -389,7 +404,8 @@ static int imx8mn_clk_probe(struct udevice *dev)
 	clk_dm(IMX8MN_CLK_PWM4_ROOT,
 	       imx_clk_gate4("pwm4_root_clk", "pwm4", base + 0x42b0, 0));
 #endif
-
+	clk_dm(IMX8MN_CLK_GIC,
+	       imx8m_clk_composite_critical("gic", imx8mn_gic_sels, base + 0xb200));
 #if CONFIG_IS_ENABLED(DM_SPI)
 	clk_dm(IMX8MN_CLK_ECSPI1,
 	       imx8m_clk_composite("ecspi1", imx8mn_ecspi1_sels, base + 0xb280));
-- 
2.43.0

