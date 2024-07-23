Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8000C3DA63
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 18:15:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3612887F5;
	Tue, 23 Jul 2024 20:14:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XiJVzKen";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADDE588840; Tue, 23 Jul 2024 20:14:53 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1BF188840
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 20:14:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3d9e13ef9aaso3569393b6e.1
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 11:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721758483; x=1722363283; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h7x02m9/X1nGZUg7wrvjrfkcmJ2jc/Kg6fCq7AurZhY=;
 b=XiJVzKenbojk+IvAVtZyxhV8BJovgLx396QsjsQcwP8XpM8ymdwP0CHkZTQgup23hd
 h9Sv39IpejmmJlykt+LwANQ28DRNpMWAlu539DFQGIPwH8z5nPi+2oA1wawmKJuTiOci
 HQ+1g639HqDajCAyLAG/yIAOG4ROjvxQyuV6M5l4hswGBLJ/YUnGUVR7DgzabLInGJ0X
 4dtVOnTA8NgZKG8cXG3GyHuDEQyTPm58a00PI4rpWIHyKrrl97IntV9uXXYmbOraoJSF
 Tt1vxVkOX5pC8jwlruPfADtBXZqw6ilu7aogyN0/L+LCwrhWRKt3NsF9b6QRph8RA07k
 Y0yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721758483; x=1722363283;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h7x02m9/X1nGZUg7wrvjrfkcmJ2jc/Kg6fCq7AurZhY=;
 b=OIwQe+0TJRAb/qazYOaBCz8YlUZTE9Nk6XE65xAMZ1DP7/EvXTp4dl83iqG/w0q+/1
 3kDCmnSrVB2w4oPn6S5yGcCMgNGlhMxq9DJbnMuf/S9wokUGaR3sE3RNd0/31EZqRTe3
 egRPvNdysdjkuvlS7u6UNkacUDO51zCfdykmObjsyIQTfIrJAaAPU8gMjN+hgXZyvfLp
 nvkUDauJOEwXLp/jZMGNNNpD0r1P3iNU0cL0clAfRPfwU+Gc7QubmKw8AfRT1VGKycd2
 QoVJnVjKV9u3RfBLvcIKFygyIyGuAQOmOAuqpeZqSu35gidCghudtiyz6U5XA7iJvHCE
 rPyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2Ocsvd9hy8qAhzHwzaGcBPJSZ6MptT+aK6CE78Alb4OWPKg4ZEAzMFuU3Qpam/FNqREGmtAFSKgaB3PLTEyfem95gdA==
X-Gm-Message-State: AOJu0YyJIqBiD0z/DOSDdxlxlZdhHauf4FYFP6ieqTyx3YHLXJBcpyu5
 BvtofPDH/+ysd3Aa/buMbtp8MqvE3l9UEnmnxr0FhGqswBbwNyznQw3PR59uk5W6W8r2syyU9JH
 b
X-Google-Smtp-Source: AGHT+IH+QpFi1DcARRAHdVVHdl19vsqG0iSENVljx0ySnDX4TeO+G3Mzo/jn630UqWPgs1bsywqntw==
X-Received: by 2002:a05:6808:2189:b0:3da:a6b7:47f3 with SMTP id
 5614622812f47-3dae979ff92mr15302166b6e.1.1721758482645; 
 Tue, 23 Jul 2024 11:14:42 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3dae0982785sm2084678b6e.23.2024.07.23.11.14.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 11:14:42 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <promsoft@gmail.com>,
	Minkyu Kang <mk7.kang@samsung.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Anand Moon <linux.amoon@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH v3 3/5] clk: exynos: Add SSS clocks for Exynos850
Date: Tue, 23 Jul 2024 13:14:37 -0500
Message-Id: <20240723181439.7089-4-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240723181439.7089-1-semen.protsenko@linaro.org>
References: <20240723181439.7089-1-semen.protsenko@linaro.org>
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

Add ACLK (operating clock) and PCLK (bus clock) for Security Sub System
(SSS) in Exynos850. Those clocks are needed for RNG enablement.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v3:
  - (none)

Changes in v2:
  - (none)

 drivers/clk/exynos/clk-exynos850.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/clk/exynos/clk-exynos850.c b/drivers/clk/exynos/clk-exynos850.c
index 0c09ba02de4a..8cbc626f31e8 100644
--- a/drivers/clk/exynos/clk-exynos850.c
+++ b/drivers/clk/exynos/clk-exynos850.c
@@ -323,14 +323,18 @@ U_BOOT_DRIVER(exynos850_cmu_peri) = {
 /* Register Offset definitions for CMU_CORE (0x12000000) */
 #define PLL_CON0_MUX_CLKCMU_CORE_BUS_USER	0x0600
 #define PLL_CON0_MUX_CLKCMU_CORE_MMC_EMBD_USER	0x0620
+#define PLL_CON0_MUX_CLKCMU_CORE_SSS_USER	0x0630
 #define CLK_CON_DIV_DIV_CLK_CORE_BUSP		0x1800
 #define CLK_CON_GAT_GOUT_CORE_MMC_EMBD_I_ACLK	0x20e8
 #define CLK_CON_GAT_GOUT_CORE_MMC_EMBD_SDCLKIN	0x20ec
+#define CLK_CON_GAT_GOUT_CORE_SSS_I_ACLK	0x2128
+#define CLK_CON_GAT_GOUT_CORE_SSS_I_PCLK	0x212c
 
 /* List of parent clocks for Muxes in CMU_CORE */
 PNAME(mout_core_bus_user_p)		= { "clock-oscclk", "dout_core_bus" };
 PNAME(mout_core_mmc_embd_user_p)	= { "clock-oscclk",
 					    "dout_core_mmc_embd" };
+PNAME(mout_core_sss_user_p)		= { "clock-oscclk", "dout_core_sss" };
 
 static const struct samsung_mux_clock core_mux_clks[] = {
 	MUX(CLK_MOUT_CORE_BUS_USER, "mout_core_bus_user", mout_core_bus_user_p,
@@ -338,6 +342,8 @@ static const struct samsung_mux_clock core_mux_clks[] = {
 	MUX_F(CLK_MOUT_CORE_MMC_EMBD_USER, "mout_core_mmc_embd_user",
 	      mout_core_mmc_embd_user_p, PLL_CON0_MUX_CLKCMU_CORE_MMC_EMBD_USER,
 	      4, 1, CLK_SET_RATE_PARENT, 0),
+	MUX(CLK_MOUT_CORE_SSS_USER, "mout_core_sss_user", mout_core_sss_user_p,
+	    PLL_CON0_MUX_CLKCMU_CORE_SSS_USER, 4, 1),
 };
 
 static const struct samsung_div_clock core_div_clks[] = {
@@ -351,6 +357,10 @@ static const struct samsung_gate_clock core_gate_clks[] = {
 	GATE(CLK_GOUT_MMC_EMBD_SDCLKIN, "gout_mmc_embd_sdclkin",
 	     "mout_core_mmc_embd_user", CLK_CON_GAT_GOUT_CORE_MMC_EMBD_SDCLKIN,
 	     21, CLK_SET_RATE_PARENT, 0),
+	GATE(CLK_GOUT_SSS_ACLK, "gout_sss_aclk", "mout_core_sss_user",
+	     CLK_CON_GAT_GOUT_CORE_SSS_I_ACLK, 21, 0, 0),
+	GATE(CLK_GOUT_SSS_PCLK, "gout_sss_pclk", "dout_core_busp",
+	     CLK_CON_GAT_GOUT_CORE_SSS_I_PCLK, 21, 0, 0),
 };
 
 static const struct samsung_clk_group core_cmu_clks[] = {
-- 
2.39.2

