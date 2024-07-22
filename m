Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28A92C3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 18:03:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41DDE8875D;
	Mon, 22 Jul 2024 19:58:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MtJ0Y6Rk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 168CC88744; Mon, 22 Jul 2024 19:58:08 +0200 (CEST)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B1D88863E
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 19:58:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-5d3cf39c239so2516586eaf.1
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 10:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721671084; x=1722275884; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L2Qba+p3+HBxKvTQF4PAqRbfCun8WfOLNPwAsqU7wq0=;
 b=MtJ0Y6RkHlQ+9+sqgLnYSrSCKkGMdVWFTB74dnAB5Py2uoZ26iy3QVAF/p8dhLnM8o
 mlb5TgW6nn1Uk9+vfJtsm/DJsGJT/rLp784I+TkRfeDtrzJUhwc8OZq/CE+XOPhj91m+
 Sv7sMzJE7YG7GUQpoTK+b5BOUKkKwXbq/7Ihuo6RucSncMUs+dUdlIJk6v6R1vES9wEe
 D+JgTr39ZRlPOqSLgpaxHj0aVj+K3qtDLEimOcXCocYilCGudPKGtlCZUzG9WN+iHg/M
 HlMTKWYpiDdQZVZToASxZM0cCYdx96w5xxpcp+LbeTlQykn1KjULCbTDartgyiPN5xQZ
 SNLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721671084; x=1722275884;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L2Qba+p3+HBxKvTQF4PAqRbfCun8WfOLNPwAsqU7wq0=;
 b=lK+7zoQ3tTgk7Uq80UZXzuma+0Zvc/c6o3JVUNny5aDQG1uoCCYrSRRSrkjzxZz7V0
 vfTJr8WyKlXP6OrlCk5sDoakIZt5Rl7wNJHP5U8vKykH/okYA7QSuSPqpqhdH3xwqP0H
 K6oW8wy7Iz70ENTZ4Vgg/D4/6dWhDXU/Yx75qLAS0msyeecR1l5ja9hoX7X6kZ+H1z3M
 0ObmCSFmg+/WWiBfyiyOJpo1CD7qYrdkHHBdHD+vYJ7LeazWH/9IZc/0iSHbNkVotUYY
 lGaBGjteqdFoisevGEY+QEnZ7ymWOwbQZwyWA+S9DpE1RwmmzT7ACtoJANp70U6T+Ea+
 NJjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUceVDr9Zlti0877uZkBlrHPkvR3PiullEPy4Zp218EtHIXYBRgk4K8u/yY2j1tQ1tCke5laxKkDK6e0SZE4BT95Ga0lA==
X-Gm-Message-State: AOJu0YyzR0YESiGSeYLHNsMG0f6XtQvmUX/JjotHVdwdkkrq3r5565CK
 EjT1FD9m6a3JFyu13NvFD2oEas3NZFkGzJJshpMRltMa8+uZ8AeQ5VykF7AkdZc=
X-Google-Smtp-Source: AGHT+IE7L9O6ZLSjz148zju96vpGmtemyb16Qjw9Virem88vsHB5DXALxDVcG1jGyG18ljB3LDQPSg==
X-Received: by 2002:a05:6870:fb87:b0:261:1342:26b9 with SMTP id
 586e51a60fabf-263ab62ba17mr6138455fac.51.1721671084179; 
 Mon, 22 Jul 2024 10:58:04 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2610cb2c2f1sm1771818fac.57.2024.07.22.10.58.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 10:58:03 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <mk7.kang@samsung.com>,
	Minkyu Kang <promsoft@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v3 31/38] mmc: exynos_dw_mmc: Add support for ARM64 Exynos
 chips
Date: Mon, 22 Jul 2024 12:57:33 -0500
Message-Id: <20240722175740.6985-32-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240722175740.6985-1-semen.protsenko@linaro.org>
References: <20240722175740.6985-1-semen.protsenko@linaro.org>
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

