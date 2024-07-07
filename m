Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 659C4C30653
	for <u-boot@archiver.kernel.org>; Sun,  7 Jul 2024 08:20:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAF728858C;
	Sun,  7 Jul 2024 10:20:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="bmi7xSXr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D07F788327; Sun,  7 Jul 2024 10:20:15 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8143881AD
 for <u-boot@lists.denx.de>; Sun,  7 Jul 2024 10:20:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a77c9d3e593so217744166b.0
 for <u-boot@lists.denx.de>; Sun, 07 Jul 2024 01:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1720340413; x=1720945213;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=buiSbQzLP0gfv4iQQlsY8tHFLp+E5GR4KdSjucy5p3E=;
 b=bmi7xSXrgx7ZsV4FIBCFi8dLGE99xQDFKwAld3ToEP2Sc5VL+3cqyzeu1wJsZuWLY9
 pNKydWUeiD7mOM2Km9Pi7vnLWxUjCA7TPiz4tbEo24OUx3r65kQ3f8M/nXdJhAV7+x7X
 XKDOWtZknCtAlkTwvADdt3+sh10CiJAlXo8lQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720340413; x=1720945213;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=buiSbQzLP0gfv4iQQlsY8tHFLp+E5GR4KdSjucy5p3E=;
 b=E9guKOAppcjsgKzmXCH4D4MyLmwk6uZWxVwDSu2xpKS8onbJiG8uBj82Jef6IiBPaQ
 HvIOG1eq7mvlDzY7qhOj5NzZtdVhNHBMLqXpJTbIfaPrHE3tds6RvNRkFs5ueOSmBmIH
 jOUDeyKQWRWkqtPP0MmaUNC8/Fa4OViZpgtMyiuHq6fTRIsakzfpWXZ3fKrcwPP2x/hm
 gjwNxBz/BeItXN1GXP0mtOnVPknL16brPSyGa40nECzQ9gGX45P9XT8vgyIB4e1hwCGH
 TMbJMNWcBi2PEVvPPid6zSQGlTuEmmX3ollh6oR1Ie8WV/PA/bW9D2TepbcYVGE07NgM
 Zfig==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXpVR9PxYdBW3fDalTrhEA7oKA7eaXwRKaNmEntA5fEWkP2VAJ3dvYAFauRJ9LXC1xsFttxiY4s9BChmbUCQBQT+2IjA==
X-Gm-Message-State: AOJu0Yye0B5h7fczcZrM7qIKRGR8iwb0bZYEEOQRW9A+/Zv7jQxmrviR
 vQfq+oeB6QBdMu91KDDuvuPYOLqDvsaP3if3JuU+JE4c7IB1StblDwMaUKF+0vM=
X-Google-Smtp-Source: AGHT+IE/dmFbPlnNkkxwOfDmSC6LJU440zo+XnaFVeCoirZEeCAYQ7+igJNxvdtoc6BI3znnfJm2CA==
X-Received: by 2002:a17:906:245a:b0:a77:eb34:3b45 with SMTP id
 a640c23a62f3a-a77eb343d2dmr132346366b.36.1720340412011; 
 Sun, 07 Jul 2024 01:20:12 -0700 (PDT)
Received: from panicking.. ([109.52.6.228]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a77e4a8092dsm111708666b.58.2024.07.07.01.20.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jul 2024 01:20:11 -0700 (PDT)
From: Michael Trimarchi <michael@amarulasolutions.com>
To: Fabio Estevam <festevam@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, linux-amarula@amarulasolutions.com,
 u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH 3/4] clk: imx8mm: Make parent names arrays const pointers
Date: Sun,  7 Jul 2024 10:20:00 +0200
Message-ID: <20240707082001.20746-4-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240707082001.20746-1-michael@amarulasolutions.com>
References: <20240707082001.20746-1-michael@amarulasolutions.com>
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

The arrays containing the mux selectors need to be of const pointer
to const char.

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
 drivers/clk/imx/clk-imx8mm.c | 157 +++++++++++++++++++++--------------
 1 file changed, 93 insertions(+), 64 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
index 70e2e53bde..e538f047b3 100644
--- a/drivers/clk/imx/clk-imx8mm.c
+++ b/drivers/clk/imx/clk-imx8mm.c
@@ -14,108 +14,137 @@
 
 #include "clk.h"
 
-static const char *pll_ref_sels[] = { "clock-osc-24m", "dummy", "dummy", "dummy", };
-static const char *dram_pll_bypass_sels[] = {"dram_pll", "dram_pll_ref_sel", };
-static const char *arm_pll_bypass_sels[] = {"arm_pll", "arm_pll_ref_sel", };
-static const char *sys_pll1_bypass_sels[] = {"sys_pll1", "sys_pll1_ref_sel", };
-static const char *sys_pll2_bypass_sels[] = {"sys_pll2", "sys_pll2_ref_sel", };
-static const char *sys_pll3_bypass_sels[] = {"sys_pll3", "sys_pll3_ref_sel", };
+static const char * const pll_ref_sels[] = { "clock-osc-24m", "dummy", "dummy", "dummy", };
+static const char * const dram_pll_bypass_sels[] = {"dram_pll", "dram_pll_ref_sel", };
+static const char * const arm_pll_bypass_sels[] = {"arm_pll", "arm_pll_ref_sel", };
+static const char * const sys_pll1_bypass_sels[] = {"sys_pll1", "sys_pll1_ref_sel", };
+static const char * const sys_pll2_bypass_sels[] = {"sys_pll2", "sys_pll2_ref_sel", };
+static const char * const sys_pll3_bypass_sels[] = {"sys_pll3", "sys_pll3_ref_sel", };
 
-static const char *imx8mm_a53_sels[] = {"clock-osc-24m", "arm_pll_out", "sys_pll2_500m", "sys_pll2_1000m",
-					"sys_pll1_800m", "sys_pll1_400m", "audio_pll1_out", "sys_pll3_out", };
+static const char * const imx8mm_a53_sels[] = {"clock-osc-24m", "arm_pll_out", "sys_pll2_500m",
+					       "sys_pll2_1000m", "sys_pll1_800m", "sys_pll1_400m",
+					       "audio_pll1_out", "sys_pll3_out", };
 
-static const char *imx8mm_ahb_sels[] = {"clock-osc-24m", "sys_pll1_133m", "sys_pll1_800m", "sys_pll1_400m",
-					"sys_pll2_125m", "sys_pll3_out", "audio_pll1_out", "video_pll1_out", };
+static const char * const imx8mm_ahb_sels[] = {"clock-osc-24m", "sys_pll1_133m", "sys_pll1_800m",
+					       "sys_pll1_400m", "sys_pll2_125m", "sys_pll3_out",
+					       "audio_pll1_out", "video_pll1_out", };
 
 #ifndef CONFIG_SPL_BUILD
-static const char *imx8mm_enet_axi_sels[] = {"clock-osc-24m", "sys_pll1_266m", "sys_pll1_800m", "sys_pll2_250m",
-					     "sys_pll2_200m", "audio_pll1_out", "video_pll1_out", "sys_pll3_out", };
+static const char * const imx8mm_enet_axi_sels[] = {"clock-osc-24m", "sys_pll1_266m", "sys_pll1_800m",
+						    "sys_pll2_250m", "sys_pll2_200m", "audio_pll1_out",
+						    "video_pll1_out", "sys_pll3_out", };
 
-static const char *imx8mm_enet_ref_sels[] = {"clock-osc-24m", "sys_pll2_125m", "sys_pll2_50m", "sys_pll2_100m",
-					     "sys_pll1_160m", "audio_pll1_out", "video_pll1_out", "clk_ext4", };
+static const char * const imx8mm_enet_ref_sels[] = {"clock-osc-24m", "sys_pll2_125m", "sys_pll2_50m",
+						    "sys_pll2_100m", "sys_pll1_160m", "audio_pll1_out",
+						    "video_pll1_out", "clk_ext4", };
 
-static const char *imx8mm_enet_timer_sels[] = {"clock-osc-24m", "sys_pll2_100m", "audio_pll1_out", "clk_ext1", "clk_ext2",
-					       "clk_ext3", "clk_ext4", "video_pll1_out", };
+static const char * const imx8mm_enet_timer_sels[] = {"clock-osc-24m", "sys_pll2_100m", "audio_pll1_out",
+						      "clk_ext1", "clk_ext2", "clk_ext3",
+						      "clk_ext4", "video_pll1_out", };
 
-static const char *imx8mm_enet_phy_sels[] = {"clock-osc-24m", "sys_pll2_50m", "sys_pll2_125m", "sys_pll2_200m",
-					     "sys_pll2_500m", "video_pll1_out", "audio_pll2_out", };
+static const char * const imx8mm_enet_phy_sels[] = {"clock-osc-24m", "sys_pll2_50m", "sys_pll2_125m",
+						    "sys_pll2_200m", "sys_pll2_500m", "video_pll1_out",
+						    "audio_pll2_out", };
 #endif
 
-static const char *imx8mm_nand_usdhc_sels[] = {"clock-osc-24m", "sys_pll1_266m", "sys_pll1_800m", "sys_pll2_200m",
-					       "sys_pll1_133m", "sys_pll3_out", "sys_pll2_250m", "audio_pll1_out", };
+static const char * const imx8mm_nand_usdhc_sels[] = {"clock-osc-24m", "sys_pll1_266m", "sys_pll1_800m",
+						      "sys_pll2_200m", "sys_pll1_133m", "sys_pll3_out",
+						      "sys_pll2_250m", "audio_pll1_out", };
 
-static const char *imx8mm_usb_bus_sels[] = {"clock-osc-24m", "sys_pll2_500m", "sys_pll1_800m", "sys_pll2_100m",
-					    "sys_pll2_200m", "clk_ext2", "clk_ext4", "audio_pll2_out", };
+static const char * const imx8mm_usb_bus_sels[] = {"clock-osc-24m", "sys_pll2_500m", "sys_pll1_800m",
+						   "sys_pll2_100m", "sys_pll2_200m", "clk_ext2",
+						   "clk_ext4", "audio_pll2_out", };
 
-static const char *imx8mm_usdhc1_sels[] = {"clock-osc-24m", "sys_pll1_400m", "sys_pll1_800m", "sys_pll2_500m",
-					   "sys_pll3_out", "sys_pll1_266m", "audio_pll2_out", "sys_pll1_100m", };
+static const char * const imx8mm_usdhc1_sels[] = {"clock-osc-24m", "sys_pll1_400m", "sys_pll1_800m",
+						  "sys_pll2_500m", "sys_pll3_out", "sys_pll1_266m",
+						  "audio_pll2_out", "sys_pll1_100m", };
 
-static const char *imx8mm_usdhc2_sels[] = {"clock-osc-24m", "sys_pll1_400m", "sys_pll1_800m", "sys_pll2_500m",
-					   "sys_pll3_out", "sys_pll1_266m", "audio_pll2_out", "sys_pll1_100m", };
+static const char * const imx8mm_usdhc2_sels[] = {"clock-osc-24m", "sys_pll1_400m", "sys_pll1_800m",
+						  "sys_pll2_500m", "sys_pll3_out", "sys_pll1_266m",
+						  "audio_pll2_out", "sys_pll1_100m", };
 
-static const char *imx8mm_i2c1_sels[] = {"clock-osc-24m", "sys_pll1_160m", "sys_pll2_50m", "sys_pll3_out", "audio_pll1_out",
-					 "video_pll1_out", "audio_pll2_out", "sys_pll1_133m", };
+static const char * const imx8mm_i2c1_sels[] = {"clock-osc-24m", "sys_pll1_160m", "sys_pll2_50m",
+						"sys_pll3_out", "audio_pll1_out", "video_pll1_out",
+						"audio_pll2_out", "sys_pll1_133m", };
 
-static const char *imx8mm_i2c2_sels[] = {"clock-osc-24m", "sys_pll1_160m", "sys_pll2_50m", "sys_pll3_out", "audio_pll1_out",
-					 "video_pll1_out", "audio_pll2_out", "sys_pll1_133m", };
+static const char * const imx8mm_i2c2_sels[] = {"clock-osc-24m", "sys_pll1_160m", "sys_pll2_50m",
+						"sys_pll3_out", "audio_pll1_out", "video_pll1_out",
+						"audio_pll2_out", "sys_pll1_133m", };
 
-static const char *imx8mm_i2c3_sels[] = {"clock-osc-24m", "sys_pll1_160m", "sys_pll2_50m", "sys_pll3_out", "audio_pll1_out",
-					 "video_pll1_out", "audio_pll2_out", "sys_pll1_133m", };
+static const char * const imx8mm_i2c3_sels[] = {"clock-osc-24m", "sys_pll1_160m", "sys_pll2_50m",
+						"sys_pll3_out", "audio_pll1_out", "video_pll1_out",
+						"audio_pll2_out", "sys_pll1_133m", };
 
-static const char *imx8mm_i2c4_sels[] = {"clock-osc-24m", "sys_pll1_160m", "sys_pll2_50m", "sys_pll3_out", "audio_pll1_out",
-					 "video_pll1_out", "audio_pll2_out", "sys_pll1_133m", };
+static const char * const imx8mm_i2c4_sels[] = {"clock-osc-24m", "sys_pll1_160m", "sys_pll2_50m",
+						"sys_pll3_out", "audio_pll1_out", "video_pll1_out",
+						"audio_pll2_out", "sys_pll1_133m", };
 
 #if CONFIG_IS_ENABLED(PCIE_DW_IMX)
-static const char *imx8mm_pcie1_ctrl_sels[] = {"clock-osc-24m", "sys_pll2_250m", "sys_pll2_200m", "sys_pll1_266m",
-					       "sys_pll1_800m", "sys_pll2_500m", "sys_pll2_333m", "sys_pll3_out", };
+static const char * const imx8mm_pcie1_ctrl_sels[] = {"clock-osc-24m", "sys_pll2_250m", "sys_pll2_200m",
+						      "sys_pll1_266m", "sys_pll1_800m", "sys_pll2_500m",
+						      "sys_pll2_333m", "sys_pll3_out", };
 
-static const char *imx8mm_pcie1_phy_sels[] = {"clock-osc-24m", "sys_pll2_100m", "sys_pll2_500m", "clk_ext1", "clk_ext2",
-					      "clk_ext3", "clk_ext4", "sys_pll1_400m", };
+static const char * const imx8mm_pcie1_phy_sels[] = {"clock-osc-24m", "sys_pll2_100m", "sys_pll2_500m",
+						     "clk_ext1", "clk_ext2", "clk_ext3",
+						     "clk_ext4", "sys_pll1_400m", };
 
-static const char *imx8mm_pcie1_aux_sels[] = {"clock-osc-24m", "sys_pll2_200m", "sys_pll2_50m", "sys_pll3_out",
-					      "sys_pll2_100m", "sys_pll1_80m", "sys_pll1_160m", "sys_pll1_200m", };
+static const char * const imx8mm_pcie1_aux_sels[] = {"clock-osc-24m", "sys_pll2_200m", "sys_pll2_50m",
+						     "sys_pll3_out", "sys_pll2_100m", "sys_pll1_80m",
+						     "sys_pll1_160m", "sys_pll1_200m", };
 #endif
 
 #ifndef CONFIG_SPL_BUILD
-static const char *imx8mm_pwm1_sels[] = {"clock-osc-24m", "sys_pll2_100m", "sys_pll1_160m", "sys_pll1_40m",
-					 "sys_pll3_out", "clk_ext1", "sys_pll1_80m", "video_pll1_out", };
+static const char * const imx8mm_pwm1_sels[] = {"clock-osc-24m", "sys_pll2_100m", "sys_pll1_160m",
+						"sys_pll1_40m", "sys_pll3_out", "clk_ext1",
+						"sys_pll1_80m", "video_pll1_out", };
 
-static const char *imx8mm_pwm2_sels[] = {"clock-osc-24m", "sys_pll2_100m", "sys_pll1_160m", "sys_pll1_40m",
-					 "sys_pll3_out", "clk_ext1", "sys_pll1_80m", "video_pll1_out", };
+static const char * const imx8mm_pwm2_sels[] = {"clock-osc-24m", "sys_pll2_100m", "sys_pll1_160m",
+						"sys_pll1_40m", "sys_pll3_out", "clk_ext1",
+						"sys_pll1_80m", "video_pll1_out", };
 
-static const char *imx8mm_pwm3_sels[] = {"clock-osc-24m", "sys_pll2_100m", "sys_pll1_160m", "sys_pll1_40m",
-					 "sys_pll3_out", "clk_ext2", "sys_pll1_80m", "video_pll1_out", };
+static const char * const imx8mm_pwm3_sels[] = {"clock-osc-24m", "sys_pll2_100m", "sys_pll1_160m",
+						"sys_pll1_40m", "sys_pll3_out", "clk_ext2",
+						"sys_pll1_80m", "video_pll1_out", };
 
-static const char *imx8mm_pwm4_sels[] = {"clock-osc-24m", "sys_pll2_100m", "sys_pll1_160m", "sys_pll1_40m",
-					 "sys_pll3_out", "clk_ext2", "sys_pll1_80m", "video_pll1_out", };
+static const char * const imx8mm_pwm4_sels[] = {"clock-osc-24m", "sys_pll2_100m", "sys_pll1_160m",
+						"sys_pll1_40m", "sys_pll3_out", "clk_ext2",
+						"sys_pll1_80m", "video_pll1_out", };
 #endif
 
-static const char *imx8mm_wdog_sels[] = {"clock-osc-24m", "sys_pll1_133m", "sys_pll1_160m", "vpu_pll_out",
-					 "sys_pll2_125m", "sys_pll3_out", "sys_pll1_80m", "sys_pll2_166m", };
+static const char * const imx8mm_wdog_sels[] = {"clock-osc-24m", "sys_pll1_133m", "sys_pll1_160m",
+						"vpu_pll_out", "sys_pll2_125m", "sys_pll3_out",
+						"sys_pll1_80m", "sys_pll2_166m", };
 
-static const char *imx8mm_usdhc3_sels[] = {"clock-osc-24m", "sys_pll1_400m", "sys_pll1_800m", "sys_pll2_500m",
-					   "sys_pll3_out", "sys_pll1_266m", "audio_pll2_clk", "sys_pll1_100m", };
+static const char * const imx8mm_usdhc3_sels[] = {"clock-osc-24m", "sys_pll1_400m", "sys_pll1_800m",
+						  "sys_pll2_500m", "sys_pll3_out", "sys_pll1_266m",
+						  "audio_pll2_clk", "sys_pll1_100m", };
 
 #if CONFIG_IS_ENABLED(NXP_FSPI)
-static const char *imx8mm_qspi_sels[] = {"clock-osc-24m", "sys_pll1_400m", "sys_pll2_333m", "sys_pll2_500m",
-					   "audio_pll2_out", "sys_pll1_266m", "sys_pll3_out", "sys_pll1_100m", };
+static const char * const imx8mm_qspi_sels[] = {"clock-osc-24m", "sys_pll1_400m", "sys_pll2_333m",
+						"sys_pll2_500m", "audio_pll2_out", "sys_pll1_266m",
+						"sys_pll3_out", "sys_pll1_100m", };
 #endif
 
-static const char *imx8mm_usb_core_sels[] = {"clock-osc-24m", "sys_pll1_100m", "sys_pll1_40m", "sys_pll2_100m",
-					     "sys_pll2_200m", "clk_ext2", "clk_ext3", "audio_pll2_out", };
+static const char * const imx8mm_usb_core_sels[] = {"clock-osc-24m", "sys_pll1_100m", "sys_pll1_40m",
+						    "sys_pll2_100m", "sys_pll2_200m", "clk_ext2",
+						    "clk_ext3", "audio_pll2_out", };
 
-static const char *imx8mm_usb_phy_sels[] = {"clock-osc-24m", "sys_pll1_100m", "sys_pll1_40m", "sys_pll2_100m",
-					     "sys_pll2_200m", "clk_ext2", "clk_ext3", "audio_pll2_out", };
+static const char * const imx8mm_usb_phy_sels[] = {"clock-osc-24m", "sys_pll1_100m", "sys_pll1_40m",
+						   "sys_pll2_100m", "sys_pll2_200m", "clk_ext2",
+						   "clk_ext3", "audio_pll2_out", };
 
 #if CONFIG_IS_ENABLED(DM_SPI)
-static const char *imx8mm_ecspi1_sels[] = {"clock-osc-24m", "sys_pll2_200m", "sys_pll1_40m", "sys_pll1_160m",
-					   "sys_pll1_800m", "sys_pll3_out", "sys_pll2_250m", "audio_pll2_out", };
+static const char * const imx8mm_ecspi1_sels[] = {"clock-osc-24m", "sys_pll2_200m", "sys_pll1_40m",
+						  "sys_pll1_160m", "sys_pll1_800m", "sys_pll3_out",
+						  "sys_pll2_250m", "audio_pll2_out", };
 
-static const char *imx8mm_ecspi2_sels[] = {"clock-osc-24m", "sys_pll2_200m", "sys_pll1_40m", "sys_pll1_160m",
-					   "sys_pll1_800m", "sys_pll3_out", "sys_pll2_250m", "audio_pll2_out", };
+static const char * const imx8mm_ecspi2_sels[] = {"clock-osc-24m", "sys_pll2_200m", "sys_pll1_40m",
+						  "sys_pll1_160m", "sys_pll1_800m", "sys_pll3_out",
+						  "sys_pll2_250m", "audio_pll2_out", };
 
-static const char *imx8mm_ecspi3_sels[] = {"clock-osc-24m", "sys_pll2_200m", "sys_pll1_40m", "sys_pll1_160m",
-					   "sys_pll1_800m", "sys_pll3_out", "sys_pll2_250m", "audio_pll2_out", };
+static const char * const imx8mm_ecspi3_sels[] = {"clock-osc-24m", "sys_pll2_200m", "sys_pll1_40m",
+						  "sys_pll1_160m", "sys_pll1_800m", "sys_pll3_out",
+						  "sys_pll2_250m", "audio_pll2_out", };
 #endif
 
 static int imx8mm_clk_probe(struct udevice *dev)
-- 
2.43.0

