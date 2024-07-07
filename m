Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8E76C30653
	for <u-boot@archiver.kernel.org>; Sun,  7 Jul 2024 08:20:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3ECBE884EA;
	Sun,  7 Jul 2024 10:20:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="GzsduJQ9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BD93881AD; Sun,  7 Jul 2024 10:20:13 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F3C0882B8
 for <u-boot@lists.denx.de>; Sun,  7 Jul 2024 10:20:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a77c2d89af8so295506266b.2
 for <u-boot@lists.denx.de>; Sun, 07 Jul 2024 01:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1720340409; x=1720945209;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NeWtkS9gbnw1LCxaD4G1Iqu+SKOGYmscDMuGheSgVMw=;
 b=GzsduJQ9T94wYDzv6YJWcgyf9yBz2w3JVjAjUUxJ/PC7vFPo1HZ38uR2sBrdbjmwoB
 5XjD7Ruj3n3xIrSPt7KmbDiB/yGPsMZhDCKLpfR0mwUgJvQ3vyzswsoGLOTgPsncG9t7
 GQBqqI+sEoJMutXKpV466rwP5Ybfjub6BVyYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720340409; x=1720945209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NeWtkS9gbnw1LCxaD4G1Iqu+SKOGYmscDMuGheSgVMw=;
 b=Us8YB8p6fC8+pM/rd6rUm5YnrGAf3VRH5WbilNHmgMIarvtWcwg4uEOsQw59ylU8cc
 VqVwz6eAHiG+94XtFRGp+qoQFYhJW2p3FOqWYj8H+I+GuN0uHcw9YjLe2EywJ8opU8gP
 R2MJo4f74Ocp6Y2J27UDHcy7MWzq1BqrQYFMW6brbW8FLG/5iYOwAWGCcMYMbpD0SdS1
 0ir8kWZjdYPeHq/XHxwI3DAHnajnVUCEhf5Y6FDF2sKkiwdsHLkjSr2ZI2hhI9fzJhYc
 ELfSvI8xzLsytnqETX9vVQc7We3qyh4tMvq+m8R6lGc3JR3KJkhB6hBK9rRwQOjgLTJ1
 ykzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJGSSqwq1NfVA88N3y7b3Y/XLEgKsl2NL2Y/LJKacmoRDsRF+/OmoQyJje0ZFnPRXRoPrv0eRSi2q0SH4wE7jnT9wQ4g==
X-Gm-Message-State: AOJu0Yw56ec9u8ZkfTZZ2xpNI+RAtD64pkCtFD8hWcj451QFhZKIsGiC
 OydzuWpce5/BgBJWmbM54raxmEdW5j0QOSzyxhw3Ci+nIABizOsH0mM0c8sBNDs=
X-Google-Smtp-Source: AGHT+IEPlmCZf77N0bkLV5F8XyLkRSDU/NtTwkmkbf/S2x9Ijs/QePOUiR+Y9RKZKEv1rjOq8aKJaw==
X-Received: by 2002:a17:906:f912:b0:a77:c525:5c72 with SMTP id
 a640c23a62f3a-a77c5257236mr483591066b.37.1720340409434; 
 Sun, 07 Jul 2024 01:20:09 -0700 (PDT)
Received: from panicking.. ([109.52.6.228]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a77e4a8092dsm111708666b.58.2024.07.07.01.20.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jul 2024 01:20:09 -0700 (PDT)
From: Michael Trimarchi <michael@amarulasolutions.com>
To: Fabio Estevam <festevam@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, linux-amarula@amarulasolutions.com,
 u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH 2/4] clk: imx8mn: Make parent names arrays const pointers
Date: Sun,  7 Jul 2024 10:19:59 +0200
Message-ID: <20240707082001.20746-3-michael@amarulasolutions.com>
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
 drivers/clk/imx/clk-imx8mn.c | 142 ++++++++++++++++++++---------------
 1 file changed, 81 insertions(+), 61 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index bfd1677520..8911e342f1 100644
--- a/drivers/clk/imx/clk-imx8mn.c
+++ b/drivers/clk/imx/clk-imx8mn.c
@@ -16,106 +16,126 @@
 
 static u32 share_count_nand;
 
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
 
-static const char *imx8mn_a53_sels[] = {"clock-osc-24m", "arm_pll_out", "sys_pll2_500m", "sys_pll2_1000m",
-					"sys_pll1_800m", "sys_pll1_400m", "audio_pll1_out", "sys_pll3_out", };
+static const char * const imx8mn_a53_sels[] = {"clock-osc-24m", "arm_pll_out", "sys_pll2_500m",
+					       "sys_pll2_1000m", "sys_pll1_800m", "sys_pll1_400m",
+					       "audio_pll1_out", "sys_pll3_out", };
 
-static const char *imx8mn_ahb_sels[] = {"clock-osc-24m", "sys_pll1_133m", "sys_pll1_800m", "sys_pll1_400m",
-					"sys_pll2_125m", "sys_pll3_out", "audio_pll1_out", "video_pll_out", };
+static const char * const imx8mn_ahb_sels[] = {"clock-osc-24m", "sys_pll1_133m", "sys_pll1_800m",
+					       "sys_pll1_400m", "sys_pll2_125m", "sys_pll3_out",
+					       "audio_pll1_out", "video_pll_out", };
 
-static const char *imx8mn_enet_axi_sels[] = {"clock-osc-24m", "sys_pll1_266m", "sys_pll1_800m", "sys_pll2_250m",
-					     "sys_pll2_200m", "audio_pll1_out", "video_pll_out", "sys_pll3_out", };
+static const char * const imx8mn_enet_axi_sels[] = {"clock-osc-24m", "sys_pll1_266m", "sys_pll1_800m",
+						    "sys_pll2_250m", "sys_pll2_200m", "audio_pll1_out",
+						    "video_pll_out", "sys_pll3_out", };
 
 #ifndef CONFIG_SPL_BUILD
-static const char *imx8mn_enet_ref_sels[] = {"clock-osc-24m", "sys_pll2_125m", "sys_pll2_50m", "sys_pll2_100m",
-					     "sys_pll1_160m", "audio_pll1_out", "video_pll_out", "clk_ext4", };
+static const char * const imx8mn_enet_ref_sels[] = {"clock-osc-24m", "sys_pll2_125m", "sys_pll2_50m",
+						    "sys_pll2_100m", "sys_pll1_160m", "audio_pll1_out",
+						    "video_pll_out", "clk_ext4", };
 
-static const char *imx8mn_enet_timer_sels[] = {"clock-osc-24m", "sys_pll2_100m", "audio_pll1_out", "clk_ext1", "clk_ext2",
-					       "clk_ext3", "clk_ext4", "video_pll_out", };
+static const char * const imx8mn_enet_timer_sels[] = {"clock-osc-24m", "sys_pll2_100m", "audio_pll1_out",
+						      "clk_ext1", "clk_ext2", "clk_ext3",
+						      "clk_ext4", "video_pll_out", };
 
-static const char *imx8mn_enet_phy_sels[] = {"clock-osc-24m", "sys_pll2_50m", "sys_pll2_125m", "sys_pll2_200m",
-					     "sys_pll2_500m", "audio_pll1_out", "video_pll_out", "audio_pll2_out", };
+static const char * const imx8mn_enet_phy_sels[] = {"clock-osc-24m", "sys_pll2_50m", "sys_pll2_125m",
+						    "sys_pll2_200m", "sys_pll2_500m", "audio_pll1_out",
+						    "video_pll_out", "audio_pll2_out", };
 #endif
 
-static const char *imx8mn_nand_usdhc_sels[] = {"clock-osc-24m", "sys_pll1_266m", "sys_pll1_800m", "sys_pll2_200m",
-					       "sys_pll1_133m", "sys_pll3_out", "sys_pll2_250m", "audio_pll1_out", };
+static const char * const imx8mn_nand_usdhc_sels[] = {"clock-osc-24m", "sys_pll1_266m", "sys_pll1_800m",
+						      "sys_pll2_200m", "sys_pll1_133m", "sys_pll3_out",
+						      "sys_pll2_250m", "audio_pll1_out", };
 
 static const char * const imx8mn_usb_bus_sels[] = {"clock-osc-24m", "sys_pll2_500m", "sys_pll1_800m",
-						"sys_pll2_100m", "sys_pll2_200m", "clk_ext2",
-						"clk_ext4", "audio_pll2_out", };
+						   "sys_pll2_100m", "sys_pll2_200m", "clk_ext2",
+						   "clk_ext4", "audio_pll2_out", };
 
-static const char *imx8mn_usdhc1_sels[] = {"clock-osc-24m", "sys_pll1_400m", "sys_pll1_800m", "sys_pll2_500m",
-					   "sys_pll3_out", "sys_pll1_266m", "audio_pll2_out", "sys_pll1_100m", };
+static const char * const imx8mn_usdhc1_sels[] = {"clock-osc-24m", "sys_pll1_400m", "sys_pll1_800m",
+						  "sys_pll2_500m", "sys_pll3_out", "sys_pll1_266m",
+						  "audio_pll2_out", "sys_pll1_100m", };
 
-static const char *imx8mn_usdhc2_sels[] = {"clock-osc-24m", "sys_pll1_400m", "sys_pll1_800m", "sys_pll2_500m",
-					   "sys_pll3_out", "sys_pll1_266m", "audio_pll2_out", "sys_pll1_100m", };
+static const char * const imx8mn_usdhc2_sels[] = {"clock-osc-24m", "sys_pll1_400m", "sys_pll1_800m",
+						  "sys_pll2_500m", "sys_pll3_out", "sys_pll1_266m",
+						  "audio_pll2_out", "sys_pll1_100m", };
 
 #if CONFIG_IS_ENABLED(DM_SPI)
-static const char *imx8mn_ecspi1_sels[] = {"clock-osc-24m", "sys_pll2_200m", "sys_pll1_40m",
-					   "sys_pll1_160m", "sys_pll1_800m", "sys_pll3_out",
-					   "sys_pll2_250m", "audio_pll2_out", };
+static const char * const imx8mn_ecspi1_sels[] = {"clock-osc-24m", "sys_pll2_200m", "sys_pll1_40m",
+						  "sys_pll1_160m", "sys_pll1_800m", "sys_pll3_out",
+						  "sys_pll2_250m", "audio_pll2_out", };
 
-static const char *imx8mn_ecspi2_sels[] = {"clock-osc-24m", "sys_pll2_200m", "sys_pll1_40m",
-					   "sys_pll1_160m", "sys_pll1_800m", "sys_pll3_out",
-					   "sys_pll2_250m", "audio_pll2_out", };
+static const char * const imx8mn_ecspi2_sels[] = {"clock-osc-24m", "sys_pll2_200m", "sys_pll1_40m",
+						  "sys_pll1_160m", "sys_pll1_800m", "sys_pll3_out",
+						  "sys_pll2_250m", "audio_pll2_out", };
 
-static const char *imx8mn_ecspi3_sels[] = {"clock-osc-24m", "sys_pll2_200m", "sys_pll1_40m",
-					   "sys_pll1_160m", "sys_pll1_800m", "sys_pll3_out",
-					   "sys_pll2_250m", "audio_pll2_out", };
+static const char * const imx8mn_ecspi3_sels[] = {"clock-osc-24m", "sys_pll2_200m", "sys_pll1_40m",
+						  "sys_pll1_160m", "sys_pll1_800m", "sys_pll3_out",
+						  "sys_pll2_250m", "audio_pll2_out", };
 #endif
 
-static const char *imx8mn_i2c1_sels[] = {"clock-osc-24m", "sys_pll1_160m", "sys_pll2_50m", "sys_pll3_out", "audio_pll1_out",
-					 "video_pll_out", "audio_pll2_out", "sys_pll1_133m", };
+static const char * const imx8mn_i2c1_sels[] = {"clock-osc-24m", "sys_pll1_160m", "sys_pll2_50m",
+						"sys_pll3_out", "audio_pll1_out", "video_pll_out",
+						"audio_pll2_out", "sys_pll1_133m", };
 
-static const char *imx8mn_i2c2_sels[] = {"clock-osc-24m", "sys_pll1_160m", "sys_pll2_50m", "sys_pll3_out", "audio_pll1_out",
-					 "video_pll_out", "audio_pll2_out", "sys_pll1_133m", };
+static const char * const imx8mn_i2c2_sels[] = {"clock-osc-24m", "sys_pll1_160m", "sys_pll2_50m",
+						"sys_pll3_out", "audio_pll1_out", "video_pll_out",
+						"audio_pll2_out", "sys_pll1_133m", };
 
-static const char *imx8mn_i2c3_sels[] = {"clock-osc-24m", "sys_pll1_160m", "sys_pll2_50m", "sys_pll3_out", "audio_pll1_out",
-					 "video_pll_out", "audio_pll2_out", "sys_pll1_133m", };
+static const char * const imx8mn_i2c3_sels[] = {"clock-osc-24m", "sys_pll1_160m", "sys_pll2_50m",
+						"sys_pll3_out", "audio_pll1_out", "video_pll_out",
+						"audio_pll2_out", "sys_pll1_133m", };
 
-static const char *imx8mn_i2c4_sels[] = {"clock-osc-24m", "sys_pll1_160m", "sys_pll2_50m", "sys_pll3_out", "audio_pll1_out",
-					 "video_pll_out", "audio_pll2_out", "sys_pll1_133m", };
+static const char * const imx8mn_i2c4_sels[] = {"clock-osc-24m", "sys_pll1_160m", "sys_pll2_50m",
+						"sys_pll3_out", "audio_pll1_out", "video_pll_out",
+						"audio_pll2_out", "sys_pll1_133m", };
 
 #ifndef CONFIG_SPL_BUILD
-static const char *imx8mn_pwm1_sels[] = {"clock-osc-24m", "sys_pll2_100m", "sys_pll1_160m", "sys_pll1_40m",
-					 "sys_pll3_out", "clk_ext1", "sys_pll1_80m", "video_pll_out", };
+static const char * const imx8mn_pwm1_sels[] = {"clock-osc-24m", "sys_pll2_100m", "sys_pll1_160m",
+						"sys_pll1_40m", "sys_pll3_out", "clk_ext1",
+						"sys_pll1_80m", "video_pll_out", };
 
-static const char *imx8mn_pwm2_sels[] = {"clock-osc-24m", "sys_pll2_100m", "sys_pll1_160m", "sys_pll1_40m",
-					 "sys_pll3_out", "clk_ext1", "sys_pll1_80m", "video_pll_out", };
+static const char * const imx8mn_pwm2_sels[] = {"clock-osc-24m", "sys_pll2_100m", "sys_pll1_160m",
+						"sys_pll1_40m", "sys_pll3_out", "clk_ext1",
+						"sys_pll1_80m", "video_pll_out", };
 
-static const char *imx8mn_pwm3_sels[] = {"clock-osc-24m", "sys_pll2_100m", "sys_pll1_160m", "sys_pll1_40m",
-					 "sys_pll3_out", "clk_ext2", "sys_pll1_80m", "video_pll_out", };
+static const char * const imx8mn_pwm3_sels[] = {"clock-osc-24m", "sys_pll2_100m", "sys_pll1_160m",
+						"sys_pll1_40m", "sys_pll3_out", "clk_ext2",
+						"sys_pll1_80m", "video_pll_out", };
 
-static const char *imx8mn_pwm4_sels[] = {"clock-osc-24m", "sys_pll2_100m", "sys_pll1_160m", "sys_pll1_40m",
-					 "sys_pll3_out", "clk_ext2", "sys_pll1_80m", "video_pll_out", };
+static const char * const imx8mn_pwm4_sels[] = {"clock-osc-24m", "sys_pll2_100m", "sys_pll1_160m",
+						"sys_pll1_40m", "sys_pll3_out", "clk_ext2",
+						"sys_pll1_80m", "video_pll_out", };
 #endif
 
-static const char *imx8mn_wdog_sels[] = {"clock-osc-24m", "sys_pll1_133m", "sys_pll1_160m", "m7_alt_pll",
-					 "sys_pll2_125m", "sys_pll3_out", "sys_pll1_80m", "sys_pll2_166m", };
+static const char * const imx8mn_wdog_sels[] = {"clock-osc-24m", "sys_pll1_133m", "sys_pll1_160m",
+						"m7_alt_pll", "sys_pll2_125m", "sys_pll3_out",
+						"sys_pll1_80m", "sys_pll2_166m", };
 
-static const char *imx8mn_usdhc3_sels[] = {"clock-osc-24m", "sys_pll1_400m", "sys_pll1_800m", "sys_pll2_500m",
-					   "sys_pll3_out", "sys_pll1_266m", "audio_pll2_clk", "sys_pll1_100m", };
+static const char * const imx8mn_usdhc3_sels[] = {"clock-osc-24m", "sys_pll1_400m", "sys_pll1_800m",
+						  "sys_pll2_500m", "sys_pll3_out", "sys_pll1_266m",
+						  "audio_pll2_clk", "sys_pll1_100m", };
 
-static const char *imx8mn_qspi_sels[] = {"clock-osc-24m", "sys_pll1_400m", "sys_pll2_333m", "sys_pll2_500m",
-					   "audio_pll2_out", "sys_pll1_266m", "sys_pll3_out", "sys_pll1_100m", };
+static const char * const imx8mn_qspi_sels[] = {"clock-osc-24m", "sys_pll1_400m", "sys_pll2_333m",
+						"sys_pll2_500m", "audio_pll2_out", "sys_pll1_266m",
+						"sys_pll3_out", "sys_pll1_100m", };
 
 static const char * const imx8mn_nand_sels[] = {"clock-osc-24m", "sys_pll2_500m", "audio_pll1_out",
 						"sys_pll1_400m", "audio_pll2_out", "sys_pll3_out",
 						"sys_pll2_250m", "video_pll_out", };
 
 static const char * const imx8mn_usb_core_sels[] = {"clock-osc-24m", "sys_pll1_100m", "sys_pll1_40m",
-						"sys_pll2_100m", "sys_pll2_200m", "clk_ext2",
-						"clk_ext3", "audio_pll2_out", };
+						    "sys_pll2_100m", "sys_pll2_200m", "clk_ext2",
+						    "clk_ext3", "audio_pll2_out", };
 
 static const char * const imx8mn_usb_phy_sels[] = {"clock-osc-24m", "sys_pll1_100m", "sys_pll1_40m",
-						"sys_pll2_100m", "sys_pll2_200m", "clk_ext2",
-						"clk_ext3", "audio_pll2_out", };
+						   "sys_pll2_100m", "sys_pll2_200m", "clk_ext2",
+						   "clk_ext3", "audio_pll2_out", };
 
 static int imx8mn_clk_probe(struct udevice *dev)
 {
-- 
2.43.0

