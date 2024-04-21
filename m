Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75CFCC4345F
	for <u-boot@archiver.kernel.org>; Sun, 21 Apr 2024 14:07:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA9F4881C4;
	Sun, 21 Apr 2024 16:07:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="qJcgy2hB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B13A88195; Sun, 21 Apr 2024 16:07:53 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D67E87FA7
 for <u-boot@lists.denx.de>; Sun, 21 Apr 2024 16:07:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-41a4d9102dcso842495e9.1
 for <u-boot@lists.denx.de>; Sun, 21 Apr 2024 07:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1713708469; x=1714313269;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pRn4ZyunEviE0YbPOFSQffFYSR8jGupbyCCDFq4etgg=;
 b=qJcgy2hBZDvGr6XDnYMfYRrRc5rXkToX1jJcpao+RKqp4P0kpFZ2Uhq30LE9n1IAUO
 tY8wuA0G177RvgRqV4a6XJpHQWm/91x8udDwS8lvbQ7jp3E/VMDIOUn+AMyaWieZ81a5
 P5wSPP+ynF8gjBhc9b+qRnr2F+denWCEdPWVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713708469; x=1714313269;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pRn4ZyunEviE0YbPOFSQffFYSR8jGupbyCCDFq4etgg=;
 b=K+rtKFlbc175kgUxLs2iGe5/zDk4+w85tjCsLExBAF7+vRg4rMTI4/VdaZwvzuffic
 XnuGFQKoEe8ZrsAy/tzVMKuKqxVZ25ejrwJrMZPMkhaEivCjtxn0xCV2BlPdJuoZlTmT
 hrpl0bzdfCZchMLJ/CpDI5BZoJLR/tQCIFnd22QUtkkmbx6fZyP0mKc8MUD6kr9ZjYk2
 3PF8FBAMeR9ZBWxhva6j6tU5uV9mRUnLqCX386DYUSDxLWIf45f7lhFiOUzJTSEnAype
 sOevrJXqDe6iakpH4y+oJZzY8cXHShBX8eP6scvwPPy0r/hfoNWhImesCao7gjPxtrdj
 IW9Q==
X-Gm-Message-State: AOJu0YxPfRGhWXm+csp/jdqsnmU6MDYz0U91JWP4T3w8NGN+XVj6IU6q
 L6ad4RlB0JDSTuCWH8DYcDnOHIFgHO2cJuxUC11OJuqUQwTqeldZsBwi0GzgCsU=
X-Google-Smtp-Source: AGHT+IHoe2IhmY+LwkY/X4v8bXRu0AX2r75ZndB5Rfee68WZB2xff+ohd1gpSRgvMRny6q9KqdK6Dw==
X-Received: by 2002:a05:600c:310a:b0:41a:5d49:8cab with SMTP id
 g10-20020a05600c310a00b0041a5d498cabmr20752wmo.11.1713708469403; 
 Sun, 21 Apr 2024 07:07:49 -0700 (PDT)
Received: from panicking.amarulasolutions.com ([62.18.232.149])
 by smtp.gmail.com with ESMTPSA id
 r13-20020a05600c458d00b00417f65f148esm17314734wmo.31.2024.04.21.07.07.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Apr 2024 07:07:49 -0700 (PDT)
From: Michael Trimarchi <michael@amarulasolutions.com>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Fabio Estevam <festevam@gmail.com>,
 linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH] clk: imx8mn: add video clocks support
Date: Sun, 21 Apr 2024 16:07:45 +0200
Message-Id: <20240421140745.25870-1-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.40.1
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

Add clocks support for the video subsystem.

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
 drivers/clk/imx/clk-imx8mn.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index 457acb8a40..baac79dd29 100644
--- a/drivers/clk/imx/clk-imx8mn.c
+++ b/drivers/clk/imx/clk-imx8mn.c
@@ -23,6 +23,7 @@ static const char *arm_pll_bypass_sels[] = {"arm_pll", "arm_pll_ref_sel", };
 static const char *sys_pll1_bypass_sels[] = {"sys_pll1", "sys_pll1_ref_sel", };
 static const char *sys_pll2_bypass_sels[] = {"sys_pll2", "sys_pll2_ref_sel", };
 static const char *sys_pll3_bypass_sels[] = {"sys_pll3", "sys_pll3_ref_sel", };
+static const char *video_pll_bypass_sels[] = {"video_pll", "video_pll_ref_sel", };
 
 static const char *imx8mn_a53_sels[] = {"clock-osc-24m", "arm_pll_out", "sys_pll2_500m", "sys_pll2_1000m",
 					"sys_pll1_800m", "sys_pll1_400m", "audio_pll1_out", "sys_pll3_out", };
@@ -30,6 +31,10 @@ static const char *imx8mn_a53_sels[] = {"clock-osc-24m", "arm_pll_out", "sys_pll
 static const char *imx8mn_ahb_sels[] = {"clock-osc-24m", "sys_pll1_133m", "sys_pll1_800m", "sys_pll1_400m",
 					"sys_pll2_125m", "sys_pll3_out", "audio_pll1_out", "video_pll_out", };
 
+static const char *imx8mn_disp_pixel_sels[] = {"osc_24m", "video_pll_out", "audio_pll2_out",
+					       "audio_pll1_out", "sys_pll1_800m", "sys_pll2_1000m",
+					       "sys_pll3_out", "clk_ext4", };
+
 static const char *imx8mn_enet_axi_sels[] = {"clock-osc-24m", "sys_pll1_266m", "sys_pll1_800m", "sys_pll2_250m",
 					     "sys_pll2_200m", "audio_pll1_out", "video_pll_out", "sys_pll3_out", };
 
@@ -139,6 +144,9 @@ static int imx8mn_clk_probe(struct udevice *dev)
 	clk_dm(IMX8MN_SYS_PLL3_REF_SEL,
 	       imx_clk_mux("sys_pll3_ref_sel", base + 0x114, 0, 2,
 			   pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
+	clk_dm(IMX8MN_VIDEO_PLL1_REF_SEL,
+	       imx_clk_mux("video_pll_ref_sel", base + 0x28, 0, 2,
+			   pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
 
 	clk_dm(IMX8MN_DRAM_PLL,
 	       imx_clk_pll14xx("dram_pll", "dram_pll_ref_sel",
@@ -155,6 +163,9 @@ static int imx8mn_clk_probe(struct udevice *dev)
 	clk_dm(IMX8MN_SYS_PLL3,
 	       imx_clk_pll14xx("sys_pll3", "sys_pll3_ref_sel",
 			       base + 0x114, &imx_1416x_pll));
+	clk_dm(IMX8MN_VIDEO_PLL1,
+	       imx_clk_pll14xx("video_pll", "video_pll_ref_sel",
+			       base + 0x28, &imx_1443x_pll));
 
 	/* PLL bypass out */
 	clk_dm(IMX8MN_DRAM_PLL_BYPASS,
@@ -183,6 +194,12 @@ static int imx8mn_clk_probe(struct udevice *dev)
 				 ARRAY_SIZE(sys_pll3_bypass_sels),
 				 CLK_SET_RATE_PARENT));
 
+	clk_dm(IMX8MN_VIDEO_PLL1_BYPASS,
+	       imx_clk_mux_flags("video_pll_bypass", base + 0x28, 16, 1,
+				 video_pll_bypass_sels,
+				 ARRAY_SIZE(video_pll_bypass_sels),
+				 CLK_SET_RATE_PARENT));
+
 	/* PLL out gate */
 	clk_dm(IMX8MN_DRAM_PLL_OUT,
 	       imx_clk_gate("dram_pll_out", "dram_pll_bypass",
@@ -199,6 +216,9 @@ static int imx8mn_clk_probe(struct udevice *dev)
 	clk_dm(IMX8MN_SYS_PLL3_OUT,
 	       imx_clk_gate("sys_pll3_out", "sys_pll3_bypass",
 			    base + 0x114, 11));
+	clk_dm(IMX8MN_VIDEO_PLL1_OUT,
+	       imx_clk_gate("video_pll_out", "video_pll_bypass",
+			    base + 0x28, 13));
 
 	/* SYS PLL fixed output */
 	clk_dm(IMX8MN_SYS_PLL1_40M,
@@ -275,6 +295,9 @@ static int imx8mn_clk_probe(struct udevice *dev)
 	clk_dm(IMX8MN_CLK_USDHC2,
 	       imx8m_clk_composite("usdhc2", imx8mn_usdhc2_sels,
 				   base + 0xac80));
+
+	clk_dm(IMX8MN_CLK_DISP_PIXEL,
+	       imx8m_clk_composite("disp_pixel", imx8mn_disp_pixel_sels, base + 0xa500));
 	clk_dm(IMX8MN_CLK_I2C1,
 	       imx8m_clk_composite("i2c1", imx8mn_i2c1_sels, base + 0xad00));
 	clk_dm(IMX8MN_CLK_I2C2,
-- 
2.40.1

