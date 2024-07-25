Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33EBFC3DA49
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 20:50:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6669F887D2;
	Thu, 25 Jul 2024 22:45:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bF7YsR1U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D6BB887BE; Thu, 25 Jul 2024 22:45:48 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62D12886FF
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 22:45:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-708adad61f8so197704a34.1
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 13:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721940344; x=1722545144; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=//uH7yJGSDY8rN70UBA8TlyadKbabT684utf6tf0WQs=;
 b=bF7YsR1UmUiLxBRCEkG94yMLxDlFdXkqYqr/0MB5zOq8IjB6fvFBGmHvcHHE2guolf
 /80+h2tczGOgA6wVv27S7GFgouDOoDI/Ds0yYX4XhFPAtKY2kwVGXTS8Vh0Q0DZnd7KF
 7ZlTpn1Gw3nTQiePXMWeSjoLU9VRG3yLwJ8ryO3rm9N25dGyHdUY6c734/Gec1bFtZ3I
 vxyK3FRvTwLd8Yi60hRC77r0EkRFiOwE9E8ZxCi9XQg/0Q7djgTFHFlw6MZUZtFth9kS
 n6Wz4hIjw1qHAXF3fCOUzOKRk5hukRgX8sLsbs6Lg920ekfSAvtNYtlOHEBps4MX4FQ7
 02SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721940344; x=1722545144;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=//uH7yJGSDY8rN70UBA8TlyadKbabT684utf6tf0WQs=;
 b=mOmvoatxQZKhKDJ2llMEcF7J+FmajeBnQ5ovtqQbbcQUDXiYy++cbeDR19r8FxdccF
 qJEnn7wwI2IhYY3XdPrwcdOuIXwCEVYobI5UixE93yik14unoCnSXef5um35QYo3AVp+
 GEHiaRdYlPr2Jx9WgqADdH05pIr0dBIwWfPEU8BnRGKeyUsMrYAjy0DRKQDSbsGyF/+Z
 zFsWNFd1pevUXPay/o3iyoZkUU/g0Ywe/2thMDpgkYGkQMJMODqFLHA6Afw9xKJ7ADLR
 afGUrDRf6SjVOq+MqGfdIZTmw8HLa7EhbOqmSVYrQD5h6zB00zxM6nBuyYqiyJreqwAx
 yctw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjGG4cystOVIq0ijeLWgadFxQ6Vo1unWZzH/tHcoCqXxVFd90S2DCTWHeQA0XQtCpGQ0IHpDiZQW3y0AMXE+4ETExkTQ==
X-Gm-Message-State: AOJu0YwQ+lwN5QBCBEl3OR8nNEZBspM63bHFtEKsZaRSaoJi4mB2qrSw
 1TVzNCaXbekM/8tKsttzxnzX8/0pUaSxnrcntBzM8taVr3cmOkj8kg9vQWsQ6/A=
X-Google-Smtp-Source: AGHT+IFlbOGJx+6E7Yqohp7IcncwtGgtU+v7JGZ1yn9xkV7xZW6kKKuGl/0RYwgDtWYtdJU10/B2uA==
X-Received: by 2002:a05:6830:6005:b0:703:7821:da7 with SMTP id
 46e09a7af769-709324c47demr3979632a34.25.1721940344174; 
 Thu, 25 Jul 2024 13:45:44 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70930705e89sm453505a34.18.2024.07.25.13.45.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 13:45:43 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Minkyu Kang <mk7.kang@samsung.com>, Minkyu Kang <promsoft@gmail.com>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v4 31/38] mmc: exynos_dw_mmc: Add support for ARM64 Exynos
 chips
Date: Thu, 25 Jul 2024 15:45:13 -0500
Message-Id: <20240725204520.18134-32-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240725204520.18134-1-semen.protsenko@linaro.org>
References: <20240725204520.18134-1-semen.protsenko@linaro.org>
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

