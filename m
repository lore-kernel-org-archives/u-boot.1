Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25468C27C53
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 01:18:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 069258857C;
	Mon, 10 Jun 2024 03:12:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="K6exQkYr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E80688578; Mon, 10 Jun 2024 03:12:54 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44A8B8855B
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 03:12:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6f9866bd5ccso687112a34.3
 for <u-boot@lists.denx.de>; Sun, 09 Jun 2024 18:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717981970; x=1718586770; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qSYVbYC4gQd29WxG1Wj2imLXR1RK9xSMuEmszO8QnpQ=;
 b=K6exQkYrjdJ6kwOyjDTGSEH5G53g2eFWIetP7NU0bLC2yQWWdN2w9OdY8tpR+gXpv3
 6gwN+KCJP4H+Rl1W87Y4JHT8jEbv7zFicNGV0748en8VT2LNHF4Iw9M00L637sYut93j
 Mn3w656QjUlbL6+6vAT4PeBadY7Wc+LSZGsYGdEMA5j4j+htaE3Qsoedca1JJf3VtE67
 7ruk+W4p47S/W2yFUUIUQsEZ+NnxOuVYsgm5S1MwHB3GXaxF3eeJQY9pr/dWxUTM5Prj
 HmsXnFPSnuN+6BN61IpDh2Ko6EkMqwHbEu5/C6+oCbLV1UZgLFJFrfp8pxgsFYb3XFUj
 0V5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717981970; x=1718586770;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qSYVbYC4gQd29WxG1Wj2imLXR1RK9xSMuEmszO8QnpQ=;
 b=ImA8gHH5i4mwW7IzrM+htGHjRTK/JibGS/B7cW494WagERfpyI9fbFmwPr/BqzaIYx
 iLKALQ5XHsLnkQg/xLrQLhoTNSs2S62iRijKFxv36hF9ieNHvekY0Dzk6lRCsBXAk/4v
 WAEKwCYbOfVROR4r5dEUbjrCwMUuMQWVI4AHVNfniGjvo1QaaHDDAvacgvbf0m7lldos
 ayo5h4tgKjHV0sFQayWRdr4cJ11rVmd94qcr7Wg+Wbr2IvmBSF0mRHVP6u81/qhTgZCp
 5pS5kAaJasAbHKB3TC6owTgcuH7ztVk6uz0X4CqDtxohTcDAPGtHxJmSD86jgtTxuf9l
 mv1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBuwij2JztsOiBIVBpH2sEUbcZjv81enqgNAsvpjeq8AFBB9SMcTG5eRyxQVFr6tzlTFXmwd5pvf/NrrjuMok70criKA==
X-Gm-Message-State: AOJu0Yw+BkZhNXTXtNSbxVufuRXJxPfslL2UgXhQibdCUIApwapbbtuH
 FRvlqpDGc1ouaqYqXa5AczluPK6RezJJkivvLh7dZvSShn0+fjRaW/eC8hY4Gcs=
X-Google-Smtp-Source: AGHT+IHLJWr0ap/tFDnbRkWlrQLolvwEE1KJZgkCc4lacOzDQY5y7ySJ1s2lrHaHKXB84inNM0yzHA==
X-Received: by 2002:a9d:6d8a:0:b0:6f9:6518:27d9 with SMTP id
 46e09a7af769-6f965182aa1mr5726889a34.3.1717981970015; 
 Sun, 09 Jun 2024 18:12:50 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6f94dcf47e7sm1566973a34.61.2024.06.09.18.12.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jun 2024 18:12:49 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Simon Glass <sjg@chromium.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v2 32/40] mmc: exynos_dw_mmc: Add support for ARM64 Exynos
 chips
Date: Sun,  9 Jun 2024 20:12:18 -0500
Message-Id: <20240610011226.4050-33-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240610011226.4050-1-semen.protsenko@linaro.org>
References: <20240610011226.4050-1-semen.protsenko@linaro.org>
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
index 5be0cb009e4e..2c8364ab8d40 100644
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

