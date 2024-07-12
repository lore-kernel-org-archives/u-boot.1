Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A9E8C2BD09
	for <u-boot@archiver.kernel.org>; Fri, 12 Jul 2024 23:43:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9244887E2;
	Sat, 13 Jul 2024 01:43:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CyGHNSMv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1D51887CD; Sat, 13 Jul 2024 01:43:11 +0200 (CEST)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6336887E7
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 01:43:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-5c694d5c5adso1206596eaf.3
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 16:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720827787; x=1721432587; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hmDaa4Bknu4RRO/KQa7LMh+N3EDLCW3g9jzs5tsbOG4=;
 b=CyGHNSMvm5nNj0/mthl79HoibShi0y0NczUFNQwwJODw0ReOFlzrOuwBobFsc7yP/K
 g10PPdBF4yOENIu7XT/KElntvblG26QurKzH5eAzAPtEhOtAxIBAo9zNwnrL4qTiA2qC
 zTGQGU7U3C9YMBe158VPbH4nMj/hIrG1r8OuEoLkrtCUB6EzTeBpplNah8NnAKypEpse
 898mdN4DsO4VQHpSOrcWVR+AkzTWVqUANBHpilv5PJ6KcaBycSHXIzi/TAO32Eoi6rUF
 nLHPR84XAiFLZgyrSkUGlZT7DS1vOpjp4chZyLzqt/pv0UUgsmZs2G+pC3XsG7fDFaGq
 Jitg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720827787; x=1721432587;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hmDaa4Bknu4RRO/KQa7LMh+N3EDLCW3g9jzs5tsbOG4=;
 b=ZK6L/6X8xtE9AwwmI3n4ZeYCJDqTrxcNYjLynp6GHT39VzJ4CDfLYMYbeKVcQcwLeL
 6rKJRVYoODxdYRBuQN4Og+bDRvi8iwzMrOeIlincTcBNRtm8EPQSrQ/scqov6X69FvCO
 XjwmPPB9lv5hOIAMP9bTGQGJ6dWt3l365AkL9xhmhGNuV9BOo7DsiIej5+a5vEkMCnaU
 R8LNT0YI+C2V88xzeM56FxaMiDrL/XvsXUFcVxsbMvuyDO3bLHWrx/c34zv11ol7mF75
 uQMPMpAbN6p66BFb+CDrhiKtq2yvzmVhxnbfhKVBWO+eVlshEGSDuIOCoJae26r3MMAZ
 0A/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxFiF4evIJD+cdyqXM07eyoHU90sEuGor3AxP0UiTSMLsImvVyyegmcH16ac4rmy24mLgBSnmvcNtzAiI+lpgZUyjVeg==
X-Gm-Message-State: AOJu0Yzu+8r7qihvsu7zcmnQH/S0eI7tCCE8fv61f6brNZvHYZgpaPLx
 zImdyVB/gQuGVQpPKVlFsPlVe7L0vHRPJmaKS9NMMTGeq/IHAAZtzyRp6zHHcnT/Uom6cXSwm7H
 a0DQ=
X-Google-Smtp-Source: AGHT+IEr2x1N+pbUs+YwDEaL8umVAiBP+YJBvtMfCrnLK8kuKKoFFwmYWasYFYQ0CV6UfmoSa/bqjQ==
X-Received: by 2002:a05:6820:2686:b0:5cc:642c:a9e9 with SMTP id
 006d021491bc7-5cce3722993mr4110397eaf.1.1720827787449; 
 Fri, 12 Jul 2024 16:43:07 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5ce74df062asm17530eaf.1.2024.07.12.16.43.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jul 2024 16:43:07 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>,
	Minkyu Kang <mk7.kang@samsung.com>
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Anand Moon <linux.amoon@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sumit Garg <sumit.garg@linaro.org>,
 Chanho Park <chanho61.park@samsung.com>, u-boot@lists.denx.de
Subject: [PATCH 3/5] clk: exynos: Add SSS clocks for Exynos850
Date: Fri, 12 Jul 2024 18:43:02 -0500
Message-Id: <20240712234304.9675-4-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240712234304.9675-1-semen.protsenko@linaro.org>
References: <20240712234304.9675-1-semen.protsenko@linaro.org>
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

