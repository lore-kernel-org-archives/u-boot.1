Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3BDCC25B78
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 23:37:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6966688565;
	Thu, 23 May 2024 01:32:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ww3aDiu7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07B7388551; Thu, 23 May 2024 01:32:12 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBE0E885AF
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 01:32:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-23fb9c871c8so2838194fac.1
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 16:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716420724; x=1717025524; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e3I+qziADukJZPXKQtX4Z43+D4uHEu+EXcXUTJu4VN0=;
 b=Ww3aDiu73Wl/Oe9vGLLDx88qX4aLuuG/D9WOT/Kgt4TcUIGz2jUbratBUsooKF408q
 Skzl0UfczHL64aYHgQ6EulCVcurIpgd+dX+u8TOPS+Dyv/JOYXTrnrBOY1cMHdnsM0qu
 l3tbyH44/cP0lykxlJ0s6PCEcsi263nOujoztYjHpM62vbi2iPEblfksz6EH5JW9gkMi
 lkbTFRgTty/wpfCpPB6u5Fa+Lw8jgDpPMbsjmzjWl0oACIhnNnNhbws6IrI+LBBnpnLS
 rjKy2Iak1nfNQm/ajyliAADHTRevh1H27PnVC24c3PDThjrjatPdWYevzSQBUmQYUc2Q
 TwvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716420724; x=1717025524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e3I+qziADukJZPXKQtX4Z43+D4uHEu+EXcXUTJu4VN0=;
 b=ZyNUCooxKWuNV9mHTOCubzOkQ7pyblLLSjrspmlE08+FaYeRSxLZiUIdBGjFtbhIDK
 5CH+ni3J5I6zEsuBDqVE1i9mRnQyxtYYKPEezDdwVZxVvjMM+uZeOeVrhfH7174rEJkO
 yJ/iZmJfKa4hQKeqwN8Ua3GXD3sOW5iHC5KZ++u0f5nNBJXIIfjVQjjggcUSmpgRHYFf
 79SzOxxo3joubOOs/0ySvXKGr7+oN1Vxfr1RTD+dHKrx8AB1PGOJjNKNNv986T7KQN3x
 MX/9zxBdp2ZySL0cMHtyDuvaCIqC7w/C4rQsxpbsL3fM3yx2EIddM26B4O9Jq+mriRN9
 Yy+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1iTtCIJI5zeg3XVjjXYR8U0qs5VIhZokhasz2Y3SZfmBiZfrJd3iGLz0GTAVHHFrLYs+oBsen9/7JVkK+QRjT0hMG0w==
X-Gm-Message-State: AOJu0YyAni5fYUcFoPDypLDMN85nxqeOmyTkmdjYr3ymMlIPOU92gWfl
 LWwDvczlICWWPcG83zDZwASi86Sc8RrG+XsrLDA0vy3d3JmeeNRTEy7Fa7iyPEY=
X-Google-Smtp-Source: AGHT+IFrrIbFTgAcwRQQyBwLnDlBjdhp8ZcVeTodvX6RgyuDsC2NhwBjRHFeilVJtH45GrK4habxhg==
X-Received: by 2002:a05:6870:a9a0:b0:22e:d13b:c13d with SMTP id
 586e51a60fabf-24c68b58cf1mr3790564fac.18.1716420724450; 
 Wed, 22 May 2024 16:32:04 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-24c6e66c1e8sm453071fac.11.2024.05.22.16.32.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 16:32:04 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Simon Glass <sjg@chromium.org>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH 33/42] mmc: exynos_dw_mmc: Add support for ARM64 Exynos chips
Date: Wed, 22 May 2024 18:31:26 -0500
Message-Id: <20240522233135.26835-34-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240522233135.26835-1-semen.protsenko@linaro.org>
References: <20240522233135.26835-1-semen.protsenko@linaro.org>
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
index 938fd51a2ac6..ac1a1784b440 100644
--- a/drivers/mmc/exynos_dw_mmc.c
+++ b/drivers/mmc/exynos_dw_mmc.c
@@ -386,6 +386,11 @@ static const struct exynos_dwmmc_variant exynos5_drv_data = {
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
@@ -393,6 +398,9 @@ static const struct udevice_id exynos_dwmmc_ids[] = {
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

