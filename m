Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 703FBC3DA4B
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 03:17:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A56808896C;
	Tue, 16 Jul 2024 05:17:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cjvAHJxA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0B438895F; Tue, 16 Jul 2024 05:17:18 +0200 (CEST)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 069B78895E
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 05:17:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5c6661bca43so2421355eaf.0
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 20:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721099833; x=1721704633; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TV0F84NEw9mpv7xyvlRnO/tlsllVPnK1puQnC/TjSBM=;
 b=cjvAHJxAm7W+XSkIgK0NjPTd05jaFYhHu5FXOPgpgtWRcnEwdcQbj/c1nNYZ13gxcq
 +3Hf/z/L6Tc1loqjt+05F+hmz+extL1iSlGUP8N0R3/7L576Tb7QK8LLPGzcmSc3jEIP
 fPCYqOPoQdWBvptU1yxxJKXoMoz0kNXt+n4eTbYwo5lEhXXUzZBG7sCA1Lv7x9EVWh0E
 wWLHFnVDgPi3w1vQeFoQ8hUKDo9anSYCZxVp0Tk2NiO2BCYy4LCQn+0TTi3okvmPqQFs
 ELue5P3/3j/xtwM4LJmoFxuqkFSsa4eC+0gWjXavPL6MGFIOLHUJUi8RpL61/1vnyEs4
 ARKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721099833; x=1721704633;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TV0F84NEw9mpv7xyvlRnO/tlsllVPnK1puQnC/TjSBM=;
 b=IVuczrI/+/z0PVs5/5vigtc2ACoKmK2XgkdjtBpt3hyFVcDRklQcqGXeu6Iuw+UmHW
 qIHr4PC9yeOf64jF+92sFXuCX2WQQlH6Ahxb04BVhyjWnCCEjxSdg43RyzQd5WHDc6/K
 y7mi8j/fs3r1gbupEzVC5ZMsXKx0dJe8VtnVyYiIKT/UnKUkpHYq3l4qXHchN1QjuSuY
 NSuCm/8Gms4Cb4VFGd8TCzX9z4szWKG85Uf/aMAzt+UrYRX+cN7yb6Xo1eE0S6H51EDn
 vvtEW+rh9ZHm40Fc//8eCM7aSrXJ+cjj1/lRVyA/wEzzbeTxeAzeMNEh09AKiEn8gAPx
 UyFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhFWqKw3GmbNylDkJmeY8uIPsaOFoHktmWSY1/Oloq/fiYKkiisOj0Gsfvdf9+dnzPCoITAU616M4m9Y2BPAUzhrEw4g==
X-Gm-Message-State: AOJu0YztAFcbSvupbOjNfk4nzXWhGX06UZqNCBZHiZ9JZoErM2TGI0PM
 rnMrRaObLEuzlVFKYhHC6+JocD6Zs3HPMKfZWgyuwH2bkvTv6HlqFaRI15/etBY=
X-Google-Smtp-Source: AGHT+IGV1cGKYg/Ku798SVq8XIx0BxZHip4BEUAQLnYDYRZl4lCcbHjl9Axy1f5Ug0CDwQLXNUuJ4w==
X-Received: by 2002:a05:6871:331d:b0:25e:29e7:14c2 with SMTP id
 586e51a60fabf-260bdffd217mr647265fac.38.1721099832655; 
 Mon, 15 Jul 2024 20:17:12 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-260751354fcsm1199506fac.13.2024.07.15.20.17.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 20:17:12 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>,
	Minkyu Kang <mk7.kang@samsung.com>
Cc: Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Anand Moon <linux.amoon@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH v2 3/5] clk: exynos: Add SSS clocks for Exynos850
Date: Mon, 15 Jul 2024 22:17:07 -0500
Message-Id: <20240716031709.24943-4-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240716031709.24943-1-semen.protsenko@linaro.org>
References: <20240716031709.24943-1-semen.protsenko@linaro.org>
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

