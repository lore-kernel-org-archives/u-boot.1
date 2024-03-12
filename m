Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D74FC54E58
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 07:04:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C88687DE2;
	Tue, 12 Mar 2024 08:04:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="K0/NrvKj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAA8286D73; Tue, 12 Mar 2024 08:04:04 +0100 (CET)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8730587F00
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 08:04:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1dd916ad172so16046675ad.2
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 00:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710227039; x=1710831839; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dY+qdBOLgzVcCOUIDdygOtl+TxAI/QN8lZLKphGGUbY=;
 b=K0/NrvKjSHG0TNH7HzHNhmwDvdNx6qYuVJnW42Iyrb0ugIDW78A83s/pj4g1Ifn8ki
 HWQt6ObJHlIz5t6ZTv7iYk+kj3kLLwiYP/HEvf/6ZfuD0cnbDEv21JLAWNegCupPqp71
 iWSlrw/qC9PnE9bqb8W+orVR6kJsjx8qKp63atrjlIPu3CYaENBiaQQiBBH5uV9hIrpA
 H4lsiqyRuhVpFv92UMxJhujVYOBPglnuj5N1oY2+N0sWL2wuYKcMsZWL893KRxijbasw
 116to1o+UFhx6Ilm0t2JNL5iYuHV66C49WllngxPrLQb52XZjVBllZhhux/I8tURZnKn
 RcWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710227039; x=1710831839;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dY+qdBOLgzVcCOUIDdygOtl+TxAI/QN8lZLKphGGUbY=;
 b=H+WpTVOrVth5CIZSrOYr6i/qt50EF3O2O9tLeVlf0gd5w2WZh3g9pjVd0cwLgGok5A
 0pdIgnJc5KkrO/KfHYgmJls/rpAYEhqzYSuu0ZwTaPhW1PDMXl+WDfjRCgVoaSKXw2Im
 2Yj3CzsK52SVUsWWXHYLSWqSYZBQ7+arXIonmN8koc3PMRe5cJr5n6oxQUldXgdxVUK6
 8ik02qliq41puyFTL9ZuevC6J27otjjN+g257aKbC5Vd3lUQW8/eEWVdsqAm9yOruiqm
 HMyCn39h9wNpNDyAZEIvX1P+AgEwR+ZnXzKdqkp/NTiaM4DXsCUnBLNtSNtJ1dOiY5xU
 4jWw==
X-Gm-Message-State: AOJu0YzM3SWWwkQ6LulR5pkGTB7s7RYUKVSMn2tT17kgpT/Ht0KWL3v5
 RXCHqwpBaCm2dIkyjNY32dACsqYZFFewoxSwHXCAJw8lchxwn6bMT2RXDkZ553eMwSMXZQnLlUz
 u
X-Google-Smtp-Source: AGHT+IEpILjYucq0bTSXLWSneaOAYviSYar9i1cCaxcoQR7UQt6QEf+ybrOfOJ2csrl4nAzXcS5q+A==
X-Received: by 2002:a17:903:32c3:b0:1dd:6263:62d4 with SMTP id
 i3-20020a17090332c300b001dd626362d4mr12288503plr.3.1710227039294; 
 Tue, 12 Mar 2024 00:03:59 -0700 (PDT)
Received: from sumit-X1.. ([223.178.211.249]) by smtp.gmail.com with ESMTPSA id
 e13-20020a170902784d00b001dd0d0d26a4sm6045401pln.147.2024.03.12.00.03.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 00:03:59 -0700 (PDT)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, tharvey@gateworks.com, marcel.ziswiler@toradex.com,
 francesco@dolcini.it, lukma@denx.de, seanga2@gmail.com,
 jh80.chung@samsung.com, sjg@chromium.org, festevam@denx.de,
 andrejs.cainikovs@toradex.com, peng.fan@nxp.com, aford173@gmail.com,
 marex@denx.de, ilias.apalodimas@linaro.org, sahaj.sarup@linaro.org,
 fathi.boudra@linaro.org, remi.duraffort@linaro.org,
 daniel.thompson@linaro.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v3 01/11] clk: imx8mp: Add support for PCIe clocks
Date: Tue, 12 Mar 2024 12:33:28 +0530
Message-Id: <20240312070338.86127-2-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240312070338.86127-1-sumit.garg@linaro.org>
References: <20240312070338.86127-1-sumit.garg@linaro.org>
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

Add support for PCIe clocks required to enable PCIe support on
iMX8MP SoC.

Tested-by: Tim Harvey <tharvey@gateworks.com> #imx8mp-venice*
Tested-by: Adam Ford <aford173@gmail.com> #imx8mp-beacon-kit
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/clk/imx/clk-imx8mp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index a21a3ce34bb..7dfc829df2c 100644
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

