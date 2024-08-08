Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2613C3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 03:17:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90E4088A8C;
	Thu,  8 Aug 2024 05:15:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JoClWhk/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19BB68873C; Thu,  8 Aug 2024 05:15:01 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABBEB8873C
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 05:14:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3db23a6085aso264133b6e.1
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 20:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723086896; x=1723691696; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vj5yOoYqRmk6ibwWr0LCEjUzXfYo7p7hgCs6F8uRp28=;
 b=JoClWhk/X4+PuBo1bD/wnJyAo++x/RvoIMrNShFjGL4CjAN9+P10rxrlN+/p2KbctQ
 jQpWV3R4D9AYgYjBdQNMnYo87f10w77pPPNyrLhLw5RB1Z4RKGuEFH1zI4kJSCUMxOU3
 1OqFruLrGafOpitAp4WzdKyMwVOlMCFfaMaWe16IECHofMTxNKXwNUbyliE9Y6I7SIaW
 JY+yiLasSiHtIwh+c9dDyZ1gLtEUK3Z8m/1atMTFbilFTfKTXABK0udHyW3KwREvTK9X
 qTn+y3Ez62Z2ag5wjtO3uC7b8FlDM1e3mcv20EJoubM1tt8RvJrkitkM/Xu6YBtWV1PA
 S4UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723086897; x=1723691697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vj5yOoYqRmk6ibwWr0LCEjUzXfYo7p7hgCs6F8uRp28=;
 b=R7BtjwR8vDEHv1lG4KzlSDjYtGOwDzUIm8SBGXT/+gyK4Q1zms/rxW+gKatVD0OLb3
 MRzFIdeJY4PbzxOOEAHCT+q6FGcObX+ixQxiFhBrfC0pm3RvP7/vD03PHpATOupY5GEc
 xKm23gTAUoDXgXueqdZ1YKgG+G2NtcfnOaQUTlCReKtoxfHgZLvl/75qmfzb7mtkn1Tw
 m6+vd+Tm+ao+wHWBS2ETEAeb1ne0QxO8LstccrtMXtSvwJmZDCBAcwGy8NYIHRajAoe5
 CyF+Yzl5EjLjj83iHFIh6rqutJCLj8X6d0gKnbvYAdsLVKeQHlSMpqeYou5Ur6NXIZiq
 m+dw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSCZrVIxlGxuO0pecO1/csbmCDBp0LfFA1vWtG2hIhL+AErGz2erxxYffpdJrzWUn4lk2aw85Hvry8xkoEfvk56Od9SA==
X-Gm-Message-State: AOJu0YzyQoYGi3ZSxaDEugIhp8CNOOKjJ98m8pBYUAvcPkLS0xJdS7GI
 6JZWQU93QEFktRhLRVUKxhK0bSBxq7wnFDpCigXEtWJqy2Hjn8nRpRiwVFMh0zw=
X-Google-Smtp-Source: AGHT+IEVWvT2TBgT1yw/mQWhGKVVS/Bkfd3e/Lzx5B7zqsRRQxNWMH22dt0gu8CvQtU7VyoojFCCSA==
X-Received: by 2002:a05:6808:f0a:b0:3d9:3e6f:ba07 with SMTP id
 5614622812f47-3dc3c160ca8mr103171b6e.3.1723086896715; 
 Wed, 07 Aug 2024 20:14:56 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3db563b80b2sm4594283b6e.45.2024.08.07.20.14.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 20:14:56 -0700 (PDT)
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
Subject: [PATCH v5 16/38] arm: exynos: Add header guard for dwmmc.h
Date: Wed,  7 Aug 2024 22:14:22 -0500
Message-Id: <20240808031444.9619-17-semen.protsenko@linaro.org>
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

Add missing header guard to prevent possible build errors.

Fixes: 77b55e8cfcee ("ARM: exynos: move SoC sources to mach-exynos")
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

 arch/arm/mach-exynos/include/mach/dwmmc.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-exynos/include/mach/dwmmc.h b/arch/arm/mach-exynos/include/mach/dwmmc.h
index 59c28ed54c58..811e9a04c6e3 100644
--- a/arch/arm/mach-exynos/include/mach/dwmmc.h
+++ b/arch/arm/mach-exynos/include/mach/dwmmc.h
@@ -4,6 +4,9 @@
  * Jaehoon Chung <jh80.chung@samsung.com>
  */
 
+#ifndef __ASM_ARM_ARCH_DWMMC_H
+#define __ASM_ARM_ARCH_DWMMC_H
+
 #define DWMCI_CLKSEL		0x09C
 #define DWMCI_SET_SAMPLE_CLK(x)	(x)
 #define DWMCI_SET_DRV_CLK(x)	((x) << 16)
@@ -25,3 +28,5 @@
 /* CLKSEL Register */
 #define DWMCI_DIVRATIO_BIT		24
 #define DWMCI_DIVRATIO_MASK		0x7
+
+#endif /* __ASM_ARM_ARCH_DWMMC_H */
-- 
2.39.2

