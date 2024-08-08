Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3856AC52D6F
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 03:20:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0514388C3A;
	Thu,  8 Aug 2024 05:15:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nMMLMrBS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B627D88B48; Thu,  8 Aug 2024 05:15:12 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83F0588B69
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 05:15:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-260f033fda3so359393fac.3
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 20:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723086908; x=1723691708; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+hh43Z+GW0dcCdUS/7pgvX0HmnQt16/ZlN6VS4bB2LU=;
 b=nMMLMrBS8wbj7Z5BKub0W0mA8JpR5RePPUEztm+PV/zDkxSqHktzod3txhG+PXEKqi
 PaFgsEmHE1ju5My8MDLNeHH8Cflp82X/mq2TkeloOQ1hf3hsWkG7vrNVz9atHgwj3A0p
 NKo+e3UcDgP3I6erLAYgvXr9RkpruP0ZU9QRj3su85dVs2g2CBI67KS/WuAPlGCMlT8L
 XdfnoK/Lm+xTRU200PJ7GX1ZU0sHBN+ek4IldfcoKj/nETMXUX5/RgtwL2L4imOamPKU
 Vo7/3sorDej8s8q1W9oihFkLg3e03yVTduUJvuoSeo58J+3SYpEikW9AsDP8oeyTcC4m
 VBIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723086908; x=1723691708;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+hh43Z+GW0dcCdUS/7pgvX0HmnQt16/ZlN6VS4bB2LU=;
 b=ZlXTjbCPSBg0cQYZd1nC0dTEx+2Kf162joNhxqea2zQYspkwMmVvauJFEZO+rrgRPX
 IQHYVGlFoqoNH909mj7tE8BQdwuAeQnJCEhzZwhe+rlThYU24U0baIIlEOIgSXqNGw5T
 skC/Ow0e6PyZcdwHd6EYr4AeuocB9MUrAxHe2gAFyh7d/jTzEOReZFIKiE2397YXaC1P
 geHFmibwLxSnzQNwEOzJ2C9rYcheqaDxOdIE5vJBUUHnyqV+jE70CvfbWMBWtg3csfC5
 95ini8nhEzz3JxJ3FzLoYsfq4uJqiktCBUO2ZwqDUsnxSlyRideNZVbts4Un+689Liqo
 QIow==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQmYfuy1PYuSS7qXt9h0zW6v0gRiLdUMHKhljniJXlVIZxz4ymEjFktovQwOxbSPehO+0WvJ1Mq8a+naLC6p15F+d/kg==
X-Gm-Message-State: AOJu0Yy5vv18gsQLGsAGBj91CA7mJj1LuRuLJN45Pcs2SZkeyitb46u4
 EezmYNPjQP4oS+Hadd6/K1eiJ3w9GUZt1EBIp66U5M8bpgSgPWTNrmCqDB654RU=
X-Google-Smtp-Source: AGHT+IHDBo4WPKcY06PlQmFDS8asHdDvceurcqAunt2PQ3VCi6S2i9awT1fi5CS96D+1j2Q3ZAGODQ==
X-Received: by 2002:a05:6870:1491:b0:254:f00e:56a2 with SMTP id
 586e51a60fabf-2692b61b2ccmr671994fac.9.1723086908013; 
 Wed, 07 Aug 2024 20:15:08 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2689a6d1b1asm4320250fac.58.2024.08.07.20.15.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 20:15:07 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <promsoft@gmail.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: Tom Rini <trini@konsulko.com>, Henrik Grimler <henrik@grimler.se>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v5 31/38] mmc: exynos_dw_mmc: Add support for ARM64 Exynos
 chips
Date: Wed,  7 Aug 2024 22:14:37 -0500
Message-Id: <20240808031444.9619-32-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240808031444.9619-1-semen.protsenko@linaro.org>
References: <20240808031444.9619-1-semen.protsenko@linaro.org>
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

Add the compatible entry and corresponding chip data for Exynos7
compatible chips, which covers modern ARM64 based Exynos chips. They
have some differences w.r.t. old ARM32 Exynos chips:
  - CLKSEL register offset is different
  - 64-bit IDMAC descriptor and 64-bit IDMAC registers are used
    (implemented in dw_mmc core driver)

In terms of the driver implementation, the CIU clock is obtained via CCF
framework (as opposed to ad-hoc clock driver implementation for ARM32
chips).

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v5:
  - (none)

Changes in v4:
  - (none)

Changes in v3:
  - (none)

Changes in v2:
  - (none)

 arch/arm/mach-exynos/include/mach/dwmmc.h | 1 +
 drivers/mmc/exynos_dw_mmc.c               | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/arch/arm/mach-exynos/include/mach/dwmmc.h b/arch/arm/mach-exynos/include/mach/dwmmc.h
index 811e9a04c6e3..7cb71be0d9fd 100644
--- a/arch/arm/mach-exynos/include/mach/dwmmc.h
+++ b/arch/arm/mach-exynos/include/mach/dwmmc.h
@@ -8,6 +8,7 @@
 #define __ASM_ARM_ARCH_DWMMC_H
 
 #define DWMCI_CLKSEL		0x09C
+#define DWMCI_CLKSEL64		0x0a8
 #define DWMCI_SET_SAMPLE_CLK(x)	(x)
 #define DWMCI_SET_DRV_CLK(x)	((x) << 16)
 #define DWMCI_SET_DIV_RATIO(x)	((x) << 24)
diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index ee3ae9f5e650..29241edf7915 100644
--- a/drivers/mmc/exynos_dw_mmc.c
+++ b/drivers/mmc/exynos_dw_mmc.c
@@ -385,6 +385,11 @@ static const struct exynos_dwmmc_variant exynos5_drv_data = {
 #endif
 };
 
+static const struct exynos_dwmmc_variant exynos7_smu_drv_data = {
+	.clksel	= DWMCI_CLKSEL64,
+	.quirks	= DWMCI_QUIRK_DISABLE_SMU,
+};
+
 static const struct udevice_id exynos_dwmmc_ids[] = {
 	{
 		.compatible	= "samsung,exynos4412-dw-mshc",
@@ -392,6 +397,9 @@ static const struct udevice_id exynos_dwmmc_ids[] = {
 	}, {
 		.compatible	= "samsung,exynos-dwmmc",
 		.data		= (ulong)&exynos5_drv_data,
+	}, {
+		.compatible	= "samsung,exynos7-dw-mshc-smu",
+		.data		= (ulong)&exynos7_smu_drv_data,
 	},
 	{ }
 };
-- 
2.39.2

