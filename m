Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11B40C3814E
	for <u-boot@archiver.kernel.org>; Sun,  7 Jul 2024 08:20:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45C3D882D6;
	Sun,  7 Jul 2024 10:20:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="mlMUzcBT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAB80881AD; Sun,  7 Jul 2024 10:20:20 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A4D4882E2
 for <u-boot@lists.denx.de>; Sun,  7 Jul 2024 10:20:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a77c4309fc8so278434966b.3
 for <u-boot@lists.denx.de>; Sun, 07 Jul 2024 01:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1720340416; x=1720945216;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QX5kacvy5aDw93Qbo6FzNpAxa7xLxA+iAJoBrMTOwto=;
 b=mlMUzcBTlYBDIlnY8dx0FEZn/NluVM6TpHlnuRx1DU8rCtOTX4LkMFHHD3dFY0FRNd
 PzzuvIFggyKW0A+M+Mo64fTQTfB0RqxKWN5BMLS3ik3ZWFWxJEUWezK89rooor344f/Z
 v80JRT2kded0hp+4GWMBJ52jcvrsPCQrHllnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720340416; x=1720945216;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QX5kacvy5aDw93Qbo6FzNpAxa7xLxA+iAJoBrMTOwto=;
 b=Ax5MLZS/kC2JnpfCMJp2GLA5rjSgDRc8ZmMY9og82agQU6BgY+qiiXYZYxyJ06LF3A
 gkYcTnWQP0jy2QVE/Zkm/LaybaIPcc52jzP468ZmHb2lXlMix7SDrHBrLK1MWl5MDAQO
 cPqk1R4JGpsEKE6UUqFeNbCib9joL1af2rH4cFDzMs21eGy8yX5RMaaKEgvmmdt0syvT
 yuOM9jGsvq79+kdRSLfYr+Wkg3q732XYwLB+2eRLZJFkgo2ROl2HFQ/yck0wESLfljNI
 8o6OZeKyai2IOlV413pfLj4FcJn//zLRuII+2D2AW9lW+H/foKF4hopCA2I64S9ECaA7
 sjDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOCEkeq4P7B7ldQlXEC7+qBBHKsq72fqN8zrkIykymKPDdX52bVrFCxOr61S59nfCpWNKDLif4tdnaLJnBv5fqI0UxdQ==
X-Gm-Message-State: AOJu0YwZT7o0Zop+f/PYUUh0l0KpwtiSp7GBRU72+5PFJ+Tiws0HdcKV
 NK3cTWSRufDt2SCmFUYlD8cOSfqyhM7sxcVYxOG6uTyr4OYePtym2M7lQxH0R+M=
X-Google-Smtp-Source: AGHT+IGG+YTf60vhHtTkLAPxgyBtXwbomDlZ2YlChxlhBbuiAGguA+66W0EQ6BozMPcyWlsnVr4tIw==
X-Received: by 2002:a17:906:a42:b0:a77:cdaa:8897 with SMTP id
 a640c23a62f3a-a77cdaa8aefmr395250766b.76.1720340415672; 
 Sun, 07 Jul 2024 01:20:15 -0700 (PDT)
Received: from panicking.. ([109.52.6.228]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a77e4a8092dsm111708666b.58.2024.07.07.01.20.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jul 2024 01:20:15 -0700 (PDT)
From: Michael Trimarchi <michael@amarulasolutions.com>
To: Fabio Estevam <festevam@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, linux-amarula@amarulasolutions.com,
 u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH 4/4] clk: imx8mp: Make parent names arrays const pointers
Date: Sun,  7 Jul 2024 10:20:01 +0200
Message-ID: <20240707082001.20746-5-michael@amarulasolutions.com>
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
 drivers/clk/imx/clk-imx8mp.c | 242 +++++++++++++++++------------------
 1 file changed, 121 insertions(+), 121 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index 1f498b6ba4..6b18483c81 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -14,178 +14,178 @@
 
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
 
-static const char *imx8mp_a53_sels[] = {"clock-osc-24m", "arm_pll_out", "sys_pll2_500m",
-					"sys_pll2_1000m", "sys_pll1_800m", "sys_pll1_400m",
-					"audio_pll1_out", "sys_pll3_out", };
+static const char * const imx8mp_a53_sels[] = {"clock-osc-24m", "arm_pll_out", "sys_pll2_500m",
+					       "sys_pll2_1000m", "sys_pll1_800m", "sys_pll1_400m",
+					       "audio_pll1_out", "sys_pll3_out", };
 
-static const char *imx8mp_hsio_axi_sels[] = {"clock-osc-24m", "sys_pll2_500m", "sys_pll1_800m",
-					     "sys_pll2_100m", "sys_pll2_200m", "clk_ext2",
-					     "clk_ext4", "audio_pll2_out", };
+static const char * const imx8mp_hsio_axi_sels[] = {"clock-osc-24m", "sys_pll2_500m", "sys_pll1_800m",
+						    "sys_pll2_100m", "sys_pll2_200m", "clk_ext2",
+						    "clk_ext4", "audio_pll2_out", };
 
-static const char *imx8mp_main_axi_sels[] = {"clock-osc-24m", "sys_pll2_333m", "sys_pll1_800m",
-					     "sys_pll2_250m", "sys_pll2_1000m", "audio_pll1_out",
-					     "video_pll1_out", "sys_pll1_100m",};
+static const char * const imx8mp_main_axi_sels[] = {"clock-osc-24m", "sys_pll2_333m", "sys_pll1_800m",
+						    "sys_pll2_250m", "sys_pll2_1000m", "audio_pll1_out",
+						    "video_pll1_out", "sys_pll1_100m",};
 
-static const char *imx8mp_enet_axi_sels[] = {"clock-osc-24m", "sys_pll1_266m", "sys_pll1_800m",
-					     "sys_pll2_250m", "sys_pll2_200m", "audio_pll1_out",
-					     "video_pll1_out", "sys_pll3_out", };
+static const char * const imx8mp_enet_axi_sels[] = {"clock-osc-24m", "sys_pll1_266m", "sys_pll1_800m",
+						    "sys_pll2_250m", "sys_pll2_200m", "audio_pll1_out",
+						    "video_pll1_out", "sys_pll3_out", };
 
-static const char *imx8mp_nand_usdhc_sels[] = {"clock-osc-24m", "sys_pll1_266m", "sys_pll1_800m",
-					       "sys_pll2_200m", "sys_pll1_133m", "sys_pll3_out",
-					       "sys_pll2_250m", "audio_pll1_out", };
+static const char * const imx8mp_nand_usdhc_sels[] = {"clock-osc-24m", "sys_pll1_266m", "sys_pll1_800m",
+						      "sys_pll2_200m", "sys_pll1_133m", "sys_pll3_out",
+						      "sys_pll2_250m", "audio_pll1_out", };
 
-static const char *imx8mp_noc_sels[] = {"clock-osc-24m", "sys_pll1_800m", "sys_pll3_out",
-					"sys_pll2_1000m", "sys_pll2_500m", "audio_pll1_out",
-					"video_pll1_out", "audio_pll2_out", };
+static const char * const imx8mp_noc_sels[] = {"clock-osc-24m", "sys_pll1_800m", "sys_pll3_out",
+					       "sys_pll2_1000m", "sys_pll2_500m", "audio_pll1_out",
+					       "video_pll1_out", "audio_pll2_out", };
 
-static const char *imx8mp_noc_io_sels[] = {"clock-osc-24m", "sys_pll1_800m", "sys_pll3_out",
-					   "sys_pll2_1000m", "sys_pll2_500m", "audio_pll1_out",
-					   "video_pll1_out", "audio_pll2_out", };
+static const char * const imx8mp_noc_io_sels[] = {"clock-osc-24m", "sys_pll1_800m", "sys_pll3_out",
+						  "sys_pll2_1000m", "sys_pll2_500m", "audio_pll1_out",
+						  "video_pll1_out", "audio_pll2_out", };
 
-static const char *imx8mp_ahb_sels[] = {"clock-osc-24m", "sys_pll1_133m", "sys_pll1_800m",
-					"sys_pll1_400m", "sys_pll2_125m", "sys_pll3_out",
-					"audio_pll1_out", "video_pll1_out", };
+static const char * const imx8mp_ahb_sels[] = {"clock-osc-24m", "sys_pll1_133m", "sys_pll1_800m",
+					       "sys_pll1_400m", "sys_pll2_125m", "sys_pll3_out",
+					       "audio_pll1_out", "video_pll1_out", };
 
-static const char *imx8mp_dram_alt_sels[] = {"clock-osc-24m", "sys_pll1_800m", "sys_pll1_100m",
-					     "sys_pll2_500m", "sys_pll2_1000m", "sys_pll3_out",
-					     "audio_pll1_out", "sys_pll1_266m", };
+static const char * const imx8mp_dram_alt_sels[] = {"clock-osc-24m", "sys_pll1_800m", "sys_pll1_100m",
+						    "sys_pll2_500m", "sys_pll2_1000m", "sys_pll3_out",
+						    "audio_pll1_out", "sys_pll1_266m", };
 
-static const char *imx8mp_dram_apb_sels[] = {"clock-osc-24m", "sys_pll2_200m", "sys_pll1_40m",
-					     "sys_pll1_160m", "sys_pll1_800m", "sys_pll3_out",
-					     "sys_pll2_250m", "audio_pll2_out", };
+static const char * const imx8mp_dram_apb_sels[] = {"clock-osc-24m", "sys_pll2_200m", "sys_pll1_40m",
+						    "sys_pll1_160m", "sys_pll1_800m", "sys_pll3_out",
+						    "sys_pll2_250m", "audio_pll2_out", };
 
 static const char * const imx8mp_pcie_aux_sels[] = {"clock-osc-24m", "sys_pll2_200m", "sys_pll2_50m",
 						    "sys_pll3_out", "sys_pll2_100m", "sys_pll1_80m",
 						    "sys_pll1_160m", "sys_pll1_200m", };
 
-static const char *imx8mp_i2c5_sels[] = {"clock-osc-24m", "sys_pll1_160m", "sys_pll2_50m",
-					 "sys_pll3_out", "audio_pll1_out", "video_pll1_out",
-					 "audio_pll2_out", "sys_pll1_133m", };
+static const char * const imx8mp_i2c5_sels[] = {"clock-osc-24m", "sys_pll1_160m", "sys_pll2_50m",
+						"sys_pll3_out", "audio_pll1_out", "video_pll1_out",
+						"audio_pll2_out", "sys_pll1_133m", };
 
-static const char *imx8mp_i2c6_sels[] = {"clock-osc-24m", "sys_pll1_160m", "sys_pll2_50m",
-					 "sys_pll3_out", "audio_pll1_out", "video_pll1_out",
-					 "audio_pll2_out", "sys_pll1_133m", };
+static const char * const imx8mp_i2c6_sels[] = {"clock-osc-24m", "sys_pll1_160m", "sys_pll2_50m",
+						"sys_pll3_out", "audio_pll1_out", "video_pll1_out",
+						"audio_pll2_out", "sys_pll1_133m", };
 
-static const char *imx8mp_enet_qos_sels[] = {"clock-osc-24m", "sys_pll2_125m", "sys_pll2_50m",
-					     "sys_pll2_100m", "sys_pll1_160m", "audio_pll1_out",
-					     "video_pll1_out", "clk_ext4", };
+static const char * const imx8mp_enet_qos_sels[] = {"clock-osc-24m", "sys_pll2_125m", "sys_pll2_50m",
+						    "sys_pll2_100m", "sys_pll1_160m", "audio_pll1_out",
+						    "video_pll1_out", "clk_ext4", };
 
-static const char *imx8mp_enet_qos_timer_sels[] = {"clock-osc-24m", "sys_pll2_100m", "audio_pll1_out",
-						   "clk_ext1", "clk_ext2", "clk_ext3",
-						   "clk_ext4", "video_pll1_out", };
+static const char * const imx8mp_enet_qos_timer_sels[] = {"clock-osc-24m", "sys_pll2_100m", "audio_pll1_out",
+							  "clk_ext1", "clk_ext2", "clk_ext3",
+							  "clk_ext4", "video_pll1_out", };
 
-static const char *imx8mp_usdhc1_sels[] = {"clock-osc-24m", "sys_pll1_400m", "sys_pll1_800m",
-					   "sys_pll2_500m", "sys_pll3_out", "sys_pll1_266m",
-					   "audio_pll2_out", "sys_pll1_100m", };
+static const char * const imx8mp_usdhc1_sels[] = {"clock-osc-24m", "sys_pll1_400m", "sys_pll1_800m",
+						  "sys_pll2_500m", "sys_pll3_out", "sys_pll1_266m",
+						  "audio_pll2_out", "sys_pll1_100m", };
 
-static const char *imx8mp_usdhc2_sels[] = {"clock-osc-24m", "sys_pll1_400m", "sys_pll1_800m",
-					   "sys_pll2_500m", "sys_pll3_out", "sys_pll1_266m",
-					   "audio_pll2_out", "sys_pll1_100m", };
+static const char * const imx8mp_usdhc2_sels[] = {"clock-osc-24m", "sys_pll1_400m", "sys_pll1_800m",
+						  "sys_pll2_500m", "sys_pll3_out", "sys_pll1_266m",
+						  "audio_pll2_out", "sys_pll1_100m", };
 
-static const char *imx8mp_i2c1_sels[] = {"clock-osc-24m", "sys_pll1_160m", "sys_pll2_50m",
-					 "sys_pll3_out", "audio_pll1_out", "video_pll1_out",
-					 "audio_pll2_out", "sys_pll1_133m", };
+static const char * const imx8mp_i2c1_sels[] = {"clock-osc-24m", "sys_pll1_160m", "sys_pll2_50m",
+						"sys_pll3_out", "audio_pll1_out", "video_pll1_out",
+						"audio_pll2_out", "sys_pll1_133m", };
 
-static const char *imx8mp_i2c2_sels[] = {"clock-osc-24m", "sys_pll1_160m", "sys_pll2_50m",
-					 "sys_pll3_out", "audio_pll1_out", "video_pll1_out",
-					 "audio_pll2_out", "sys_pll1_133m", };
+static const char * const imx8mp_i2c2_sels[] = {"clock-osc-24m", "sys_pll1_160m", "sys_pll2_50m",
+						"sys_pll3_out", "audio_pll1_out", "video_pll1_out",
+						"audio_pll2_out", "sys_pll1_133m", };
 
-static const char *imx8mp_i2c3_sels[] = {"clock-osc-24m", "sys_pll1_160m", "sys_pll2_50m",
-					 "sys_pll3_out", "audio_pll1_out", "video_pll1_out",
-					 "audio_pll2_out", "sys_pll1_133m", };
+static const char * const imx8mp_i2c3_sels[] = {"clock-osc-24m", "sys_pll1_160m", "sys_pll2_50m",
+						"sys_pll3_out", "audio_pll1_out", "video_pll1_out",
+						"audio_pll2_out", "sys_pll1_133m", };
 
-static const char *imx8mp_i2c4_sels[] = {"clock-osc-24m", "sys_pll1_160m", "sys_pll2_50m",
-					 "sys_pll3_out", "audio_pll1_out", "video_pll1_out",
-					 "audio_pll2_out", "sys_pll1_133m", };
+static const char * const imx8mp_i2c4_sels[] = {"clock-osc-24m", "sys_pll1_160m", "sys_pll2_50m",
+						"sys_pll3_out", "audio_pll1_out", "video_pll1_out",
+						"audio_pll2_out", "sys_pll1_133m", };
 
-static const char *imx8mp_uart1_sels[] = {"clock-osc-24m", "sys_pll1_80m", "sys_pll2_200m",
-					  "sys_pll2_100m", "sys_pll3_out", "clk_ext2",
-					  "clk_ext4", "audio_pll2_out", };
+static const char * const imx8mp_uart1_sels[] = {"clock-osc-24m", "sys_pll1_80m", "sys_pll2_200m",
+						 "sys_pll2_100m", "sys_pll3_out", "clk_ext2",
+						 "clk_ext4", "audio_pll2_out", };
 
-static const char *imx8mp_uart2_sels[] = {"clock-osc-24m", "sys_pll1_80m", "sys_pll2_200m",
-					  "sys_pll2_100m", "sys_pll3_out", "clk_ext2",
-					  "clk_ext3", "audio_pll2_out", };
-
-static const char *imx8mp_uart3_sels[] = {"clock-osc-24m", "sys_pll1_80m", "sys_pll2_200m",
-					  "sys_pll2_100m", "sys_pll3_out", "clk_ext2",
-					  "clk_ext4", "audio_pll2_out", };
+static const char * const imx8mp_uart2_sels[] = {"clock-osc-24m", "sys_pll1_80m", "sys_pll2_200m",
+						 "sys_pll2_100m", "sys_pll3_out", "clk_ext2",
+						 "clk_ext3", "audio_pll2_out", };
 
-static const char *imx8mp_uart4_sels[] = {"clock-osc-24m", "sys_pll1_80m", "sys_pll2_200m",
-					  "sys_pll2_100m", "sys_pll3_out", "clk_ext2",
-					  "clk_ext3", "audio_pll2_out", };
+static const char * const imx8mp_uart3_sels[] = {"clock-osc-24m", "sys_pll1_80m", "sys_pll2_200m",
+						 "sys_pll2_100m", "sys_pll3_out", "clk_ext2",
+						 "clk_ext4", "audio_pll2_out", };
 
-static const char *imx8mp_usb_core_ref_sels[] = {"clock-osc-24m", "sys_pll1_100m", "sys_pll1_40m",
-						 "sys_pll2_100m", "sys_pll2_200m", "clk_ext2",
+static const char * const imx8mp_uart4_sels[] = {"clock-osc-24m", "sys_pll1_80m", "sys_pll2_200m",
+						 "sys_pll2_100m", "sys_pll3_out", "clk_ext2",
 						 "clk_ext3", "audio_pll2_out", };
 
-static const char *imx8mp_usb_phy_ref_sels[] = {"clock-osc-24m", "sys_pll1_100m", "sys_pll1_40m",
-					        "sys_pll2_100m", "sys_pll2_200m", "clk_ext2",
-					        "clk_ext3", "audio_pll2_out", };
+static const char * const imx8mp_usb_core_ref_sels[] = {"clock-osc-24m", "sys_pll1_100m", "sys_pll1_40m",
+							"sys_pll2_100m", "sys_pll2_200m", "clk_ext2",
+							"clk_ext3", "audio_pll2_out", };
+
+static const char * const imx8mp_usb_phy_ref_sels[] = {"clock-osc-24m", "sys_pll1_100m", "sys_pll1_40m",
+						       "sys_pll2_100m", "sys_pll2_200m", "clk_ext2",
+						       "clk_ext3", "audio_pll2_out", };
 
-static const char *imx8mp_gic_sels[] = {"clock-osc-24m", "sys_pll2_200m", "sys_pll1_40m",
-					"sys_pll2_100m", "sys_pll1_800m",
-					"sys_pll2_500m", "clk_ext4", "audio_pll2_out" };
+static const char * const imx8mp_gic_sels[] = {"clock-osc-24m", "sys_pll2_200m", "sys_pll1_40m",
+					       "sys_pll2_100m", "sys_pll1_800m",
+					       "sys_pll2_500m", "clk_ext4", "audio_pll2_out" };
 
-static const char *imx8mp_pwm1_sels[] = {"clock-osc-24m", "sys_pll2_100m", "sys_pll1_160m",
-					"sys_pll1_40m", "sys_pll3_out", "clk_ext1",
-					"sys_pll1_80m", "video_pll1_out", };
+static const char * const imx8mp_pwm1_sels[] = {"clock-osc-24m", "sys_pll2_100m", "sys_pll1_160m",
+						"sys_pll1_40m", "sys_pll3_out", "clk_ext1",
+						"sys_pll1_80m", "video_pll1_out", };
 
-static const char *imx8mp_pwm2_sels[] = {"clock-osc-24m", "sys_pll2_100m", "sys_pll1_160m",
-					"sys_pll1_40m", "sys_pll3_out", "clk_ext1",
-					"sys_pll1_80m", "video_pll1_out", };
+static const char * const imx8mp_pwm2_sels[] = {"clock-osc-24m", "sys_pll2_100m", "sys_pll1_160m",
+						"sys_pll1_40m", "sys_pll3_out", "clk_ext1",
+						"sys_pll1_80m", "video_pll1_out", };
 
-static const char *imx8mp_pwm3_sels[] = {"clock-osc-24m", "sys_pll2_100m", "sys_pll1_160m",
-					"sys_pll1_40m", "sys_pll3_out", "clk_ext2",
-					"sys_pll1_80m", "video_pll1_out", };
+static const char * const imx8mp_pwm3_sels[] = {"clock-osc-24m", "sys_pll2_100m", "sys_pll1_160m",
+						"sys_pll1_40m", "sys_pll3_out", "clk_ext2",
+						"sys_pll1_80m", "video_pll1_out", };
 
-static const char *imx8mp_pwm4_sels[] = {"clock-osc-24m", "sys_pll2_100m", "sys_pll1_160m",
-					"sys_pll1_40m", "sys_pll3_out", "clk_ext2",
-					"sys_pll1_80m", "video_pll1_out", };
+static const char * const imx8mp_pwm4_sels[] = {"clock-osc-24m", "sys_pll2_100m", "sys_pll1_160m",
+						"sys_pll1_40m", "sys_pll3_out", "clk_ext2",
+						"sys_pll1_80m", "video_pll1_out", };
 
-static const char *imx8mp_ecspi1_sels[] = {"clock-osc-24m", "sys_pll2_200m", "sys_pll1_40m",
+static const char * const imx8mp_ecspi1_sels[] = {"clock-osc-24m", "sys_pll2_200m", "sys_pll1_40m",
 						  "sys_pll1_160m", "sys_pll1_800m", "sys_pll3_out",
 						  "sys_pll2_250m", "audio_pll2_out", };
 
-static const char *imx8mp_ecspi2_sels[] = {"clock-osc-24m", "sys_pll2_200m", "sys_pll1_40m",
+static const char * const imx8mp_ecspi2_sels[] = {"clock-osc-24m", "sys_pll2_200m", "sys_pll1_40m",
 						  "sys_pll1_160m", "sys_pll1_800m", "sys_pll3_out",
 						  "sys_pll2_250m", "audio_pll2_out", };
 
-static const char *imx8mp_ecspi3_sels[] = {"clock-osc-24m", "sys_pll2_200m", "sys_pll1_40m",
+static const char * const imx8mp_ecspi3_sels[] = {"clock-osc-24m", "sys_pll2_200m", "sys_pll1_40m",
 						  "sys_pll1_160m", "sys_pll1_800m", "sys_pll3_out",
 						  "sys_pll2_250m", "audio_pll2_out", };
 
-static const char *imx8mp_wdog_sels[] = {"clock-osc-24m", "sys_pll1_133m", "sys_pll1_160m",
-					 "vpu_pll_out", "sys_pll2_125m", "sys_pll3_out",
-					 "sys_pll1_80m", "sys_pll2_166m" };
+static const char * const imx8mp_wdog_sels[] = {"clock-osc-24m", "sys_pll1_133m", "sys_pll1_160m",
+						"vpu_pll_out", "sys_pll2_125m", "sys_pll3_out",
+						"sys_pll1_80m", "sys_pll2_166m" };
 
-static const char *imx8mp_qspi_sels[] = {"clock-osc-24m", "sys_pll1_400m", "sys_pll2_333m",
-					 "sys_pll2_500m", "audio_pll2_out", "sys_pll1_266m",
-					 "sys_pll3_out", "sys_pll1_100m", };
+static const char * const imx8mp_qspi_sels[] = {"clock-osc-24m", "sys_pll1_400m", "sys_pll2_333m",
+						"sys_pll2_500m", "audio_pll2_out", "sys_pll1_266m",
+						"sys_pll3_out", "sys_pll1_100m", };
 
-static const char *imx8mp_usdhc3_sels[] = {"clock-osc-24m", "sys_pll1_400m", "sys_pll1_800m",
-					   "sys_pll2_500m", "sys_pll3_out", "sys_pll1_266m",
-					   "audio_pll2_out", "sys_pll1_100m", };
+static const char * const imx8mp_usdhc3_sels[] = {"clock-osc-24m", "sys_pll1_400m", "sys_pll1_800m",
+						  "sys_pll2_500m", "sys_pll3_out", "sys_pll1_266m",
+						  "audio_pll2_out", "sys_pll1_100m", };
 
-static const char *imx8mp_enet_ref_sels[] = {"clock-osc-24m", "sys_pll2_125m", "sys_pll2_50m",
-					     "sys_pll2_100m", "sys_pll1_160m", "audio_pll1_out",
-					     "video_pll1_out", "clk_ext4", };
+static const char * const imx8mp_enet_ref_sels[] = {"clock-osc-24m", "sys_pll2_125m", "sys_pll2_50m",
+						    "sys_pll2_100m", "sys_pll1_160m", "audio_pll1_out",
+						    "video_pll1_out", "clk_ext4", };
 
-static const char *imx8mp_enet_timer_sels[] = {"clock-osc-24m", "sys_pll2_100m", "audio_pll1_out",
-					       "clk_ext1", "clk_ext2", "clk_ext3",
-					       "clk_ext4", "video_pll1_out", };
+static const char * const imx8mp_enet_timer_sels[] = {"clock-osc-24m", "sys_pll2_100m", "audio_pll1_out",
+						      "clk_ext1", "clk_ext2", "clk_ext3",
+						      "clk_ext4", "video_pll1_out", };
 
-static const char *imx8mp_enet_phy_ref_sels[] = {"clock-osc-24m", "sys_pll2_50m", "sys_pll2_125m",
-						 "sys_pll2_200m", "sys_pll2_500m", "audio_pll1_out",
-						 "video_pll1_out", "audio_pll2_out", };
+static const char * const imx8mp_enet_phy_ref_sels[] = {"clock-osc-24m", "sys_pll2_50m", "sys_pll2_125m",
+							"sys_pll2_200m", "sys_pll2_500m", "audio_pll1_out",
+							"video_pll1_out", "audio_pll2_out", };
 
-static const char *imx8mp_dram_core_sels[] = {"dram_pll_out", "dram_alt_root", };
+static const char * const imx8mp_dram_core_sels[] = {"dram_pll_out", "dram_alt_root", };
 
 static int imx8mp_clk_probe(struct udevice *dev)
 {
-- 
2.43.0

