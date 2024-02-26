Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C98BAC5478C
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 08:05:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0520C87EA9;
	Mon, 26 Feb 2024 09:05:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="F0CeZ17y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47E0887EA9; Mon, 26 Feb 2024 09:05:25 +0100 (CET)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF85E87E9A
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 09:05:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3c17ac08a38so1099257b6e.1
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 00:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708934717; x=1709539517; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NS1imNy5cMRkJnAu/Oqwwu6sp0eqePeuXBM/242QSKI=;
 b=F0CeZ17y3dFZEjSL0TYWr4Vzb3heJD8Ad0TnI7rNypB13LM3aJh9+HEDLXGwOv6ve+
 7JdGbQiDoknbKBPlaqNAqIceXDgeNcteq3dPxWy5b4A5F95qv+/JNoJ/qg6mr54h/Jdh
 0XdudUdH8bxGI+prc8HzyZuDIIbjwzgXZ0i66/dhpRgot6ytPoiEPbiOrdA6pO/xkzGC
 R6STP/5I7GR0rUOBw0eICFr75b4BTRKGXkfF5LuxunukPlsLz3oFsRwWf9y9ysiO6kxC
 W/u2uGzncIjx5dGOyCrX6+coXdX97H8uFK4+0jQ6B2maEhNFiHFxHTpt1b23+/m0+2Tp
 lPQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708934717; x=1709539517;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NS1imNy5cMRkJnAu/Oqwwu6sp0eqePeuXBM/242QSKI=;
 b=dLoDy4fvXfny2CagNzAUI8+N4CVzrIFYoOXe+6GCaCxrobFpbkF/idwE8Ng0rEKJMJ
 L9/8Oq3HUDVdcVsMUqCm5muBqN3rKMRvSzELaYIpKf5GOISDT6Y4Tu7sDz3bwzYUKuDD
 Fd6N8WqUFVCyrZidakipth3vF6p5EfXRlPsnCH+rd7IisBwWELfP/s3s8jQeYF73AnPO
 go5kExn2GKtLmI+6ZeiH0KDb1uI0byZpUErW2eHp//q2FUzB/HEaME067LptLORDXg4i
 H3X4tsqf0fQvgcFCs+FpW/p20G3E/+i/5+k8TN8hTjOEKI3JTy1TO1qoyYufGpdCUlUQ
 VgRw==
X-Gm-Message-State: AOJu0YyN3GVRS0XdcnmOmPFbzfglh5ZUohRe0MvjL1FdMBDKLD8vniP1
 bFkbKf3nzj8Pk3exsAVrNEzPZFGygr8y84skK54xSebpJFbjXvKNvuPkClT48SIHWNTU5nCgh/8
 i
X-Google-Smtp-Source: AGHT+IEfiIFXxTGkcvOtHb7BeaUvRbVG4ezy6HBTAshTwJ4DPYs85IwNh+swpYhKCx+57tfHlPBHAg==
X-Received: by 2002:a05:6808:d54:b0:3c1:9b2b:b592 with SMTP id
 w20-20020a0568080d5400b003c19b2bb592mr3868372oik.22.1708934717190; 
 Mon, 26 Feb 2024 00:05:17 -0800 (PST)
Received: from sumit-X1.. ([223.178.208.32]) by smtp.gmail.com with ESMTPSA id
 k2-20020aa788c2000000b006e13a88d52esm3392842pff.61.2024.02.26.00.05.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 00:05:16 -0800 (PST)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de
Cc: marcel.ziswiler@toradex.com, francesco@dolcini.it, trini@konsulko.com,
 lukma@denx.de, seanga2@gmail.com, jh80.chung@samsung.com, festevam@denx.de,
 andrejs.cainikovs@toradex.com, sjg@chromium.org, peng.fan@nxp.com,
 aford173@gmail.com, marex@denx.de, ilias.apalodimas@linaro.org,
 sahaj.sarup@linaro.org, fathi.boudra@linaro.org, remi.duraffort@linaro.org,
 daniel.thompson@linaro.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v2 1/8] clk: imx8mp: Add support for PCIe clocks
Date: Mon, 26 Feb 2024 13:34:26 +0530
Message-Id: <20240226080433.3307154-2-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240226080433.3307154-1-sumit.garg@linaro.org>
References: <20240226080433.3307154-1-sumit.garg@linaro.org>
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

Pre-requisite to enable PCIe support on iMX8MP SoC.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/clk/imx/clk-imx8mp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index a21a3ce34bbc..7dfc829df2c4 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -62,6 +62,10 @@ static const char *imx8mp_dram_apb_sels[] = {"clock-osc-24m", "sys_pll2_200m", "
 					     "sys_pll1_160m", "sys_pll1_800m", "sys_pll3_out",
 					     "sys_pll2_250m", "audio_pll2_out", };
 
+static const char * const imx8mp_pcie_aux_sels[] = {"clock-osc-24m", "sys_pll2_200m", "sys_pll2_50m",
+						    "sys_pll3_out", "sys_pll2_100m", "sys_pll1_80m",
+						    "sys_pll1_160m", "sys_pll1_200m", };
+
 static const char *imx8mp_i2c5_sels[] = {"clock-osc-24m", "sys_pll1_160m", "sys_pll2_50m",
 					 "sys_pll3_out", "audio_pll1_out", "video_pll1_out",
 					 "audio_pll2_out", "sys_pll1_133m", };
@@ -272,6 +276,7 @@ static int imx8mp_clk_probe(struct udevice *dev)
 
 	clk_dm(IMX8MP_CLK_DRAM_ALT, imx8m_clk_composite("dram_alt", imx8mp_dram_alt_sels, base + 0xa000));
 	clk_dm(IMX8MP_CLK_DRAM_APB, imx8m_clk_composite_critical("dram_apb", imx8mp_dram_apb_sels, base + 0xa080));
+	clk_dm(IMX8MP_CLK_PCIE_AUX, imx8m_clk_composite("pcie_aux", imx8mp_pcie_aux_sels, base + 0xa400));
 	clk_dm(IMX8MP_CLK_I2C5, imx8m_clk_composite("i2c5", imx8mp_i2c5_sels, base + 0xa480));
 	clk_dm(IMX8MP_CLK_I2C6, imx8m_clk_composite("i2c6", imx8mp_i2c6_sels, base + 0xa500));
 	clk_dm(IMX8MP_CLK_ENET_QOS, imx8m_clk_composite("enet_qos", imx8mp_enet_qos_sels, base + 0xa880));
@@ -322,6 +327,7 @@ static int imx8mp_clk_probe(struct udevice *dev)
 	clk_dm(IMX8MP_CLK_I2C2_ROOT, imx_clk_gate4("i2c2_root_clk", "i2c2", base + 0x4180, 0));
 	clk_dm(IMX8MP_CLK_I2C3_ROOT, imx_clk_gate4("i2c3_root_clk", "i2c3", base + 0x4190, 0));
 	clk_dm(IMX8MP_CLK_I2C4_ROOT, imx_clk_gate4("i2c4_root_clk", "i2c4", base + 0x41a0, 0));
+	clk_dm(IMX8MP_CLK_PCIE_ROOT, imx_clk_gate4("pcie_root_clk", "pcie_aux", base + 0x4250, 0));
 	clk_dm(IMX8MP_CLK_PWM1_ROOT, imx_clk_gate4("pwm1_root_clk", "pwm1", base + 0x4280, 0));
 	clk_dm(IMX8MP_CLK_PWM2_ROOT, imx_clk_gate4("pwm2_root_clk", "pwm2", base + 0x4290, 0));
 	clk_dm(IMX8MP_CLK_PWM3_ROOT, imx_clk_gate4("pwm3_root_clk", "pwm3", base + 0x42a0, 0));
-- 
2.34.1

