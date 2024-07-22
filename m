Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3FADC3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 23:30:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1938B886DB;
	Tue, 23 Jul 2024 01:30:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="mMjdmDrx";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="gtv7jh1s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15E35885F4; Tue, 23 Jul 2024 01:29:59 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 036608789F
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 01:29:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4WSc274ZRBz9sq5;
 Tue, 23 Jul 2024 01:29:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721690991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mtQS7TAYA9NN+Ec2meHVjlB2hyIrUCfrCoX1Tycs2J8=;
 b=mMjdmDrx7J05GHkTZpnIiqhnLAThNTMhBhnKniAsoATJm5+FxnBKdAe779xHW+2xzZ4yba
 dOl1jeqNCA6HTHwoulXFvbcsFzdh1Ap8rTjgh79lFDOJ4Cr2jc8CEBqiikq6qsnxi2Stm7
 Vq60jic+OZi7j9nBPEskTll8xCxQYLAFO5jqF8ulv91XDPrp6nlg+v8kUj8kR/AAxFa55G
 vre7dOF1ZO7IX7tz2nQSnk9E+u9vZa37ugYLBURU2vVh6rtTOh1USFLJeVmeWnwxvotqMR
 cvgaN/DgzMzLttXSA7XXwSij3B27zva6SatHQ0Kb6roZpcpf+r3vNrxZ0QlgWw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721690989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mtQS7TAYA9NN+Ec2meHVjlB2hyIrUCfrCoX1Tycs2J8=;
 b=gtv7jh1sl2Oqo3Me57sK9MlKqlAlPNhus4Jh9bUQ8uykwo4rv5aZWoZgY8FwyIlk9vTmOK
 roY93tZFUebd4MGUE5MLphOUAZAdnk52Hys+y5GuNJUaB04E+tKZYbF6zp1fMvo+smpzRR
 sY5LX54MuGzzi33DmpGFV77PdNoh2qmc5MzDs/k3pFA1o5irR/VsIHVkpCHJ/M5lNDy5sI
 cpMke+BQS+IsUMag1OMkW7Ww4lCKOCeP0lSWkk6fHCvuJMutoFq1DNMdK/2U+KC+cbH3IT
 QTW709Ga7mh2m+MW/P/VUNtSKdjGIS3xHAISgCMJ7flwwW8G/ucSuUg0Y+gvRg==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 03/15] include: dt-bindings: Remove duplicate newlines
Date: Tue, 23 Jul 2024 01:28:22 +0200
Message-ID: <20240722232910.91249-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240722232910.91249-1-marek.vasut+renesas@mailbox.org>
References: <20240722232910.91249-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: e26d531bd9df03e53e4
X-MBO-RS-META: sbspudu3hcaafx3zpdamsd1ss6qrwnji
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

Drop all duplicate newlines. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 include/dt-bindings/clock/mt8516-clk.h       | 1 -
 include/dt-bindings/clock/qcom,gcc-msm8996.h | 1 -
 include/dt-bindings/clock/qcom,rpmh.h        | 1 -
 include/dt-bindings/clock/tegra210-car.h     | 1 -
 include/dt-bindings/dma/at91.h               | 1 -
 include/dt-bindings/mfd/stm32f7-rcc.h        | 1 -
 6 files changed, 6 deletions(-)

diff --git a/include/dt-bindings/clock/mt8516-clk.h b/include/dt-bindings/clock/mt8516-clk.h
index 745b87f3a0d..d6f9a4516cb 100644
--- a/include/dt-bindings/clock/mt8516-clk.h
+++ b/include/dt-bindings/clock/mt8516-clk.h
@@ -8,7 +8,6 @@
 #ifndef _DT_BINDINGS_CLK_MT8516_H
 #define _DT_BINDINGS_CLK_MT8516_H
 
-
 /* APMIXEDSYS */
 
 #define CLK_APMIXED_ARMPLL	0
diff --git a/include/dt-bindings/clock/qcom,gcc-msm8996.h b/include/dt-bindings/clock/qcom,gcc-msm8996.h
index ddfd6fd7308..de5c36c7800 100644
--- a/include/dt-bindings/clock/qcom,gcc-msm8996.h
+++ b/include/dt-bindings/clock/qcom,gcc-msm8996.h
@@ -347,7 +347,6 @@
 #define GCC_USB3PHY_PHY_BCR					104
 #define GCC_MSS_RESTART						105
 
-
 /* Indexes for GDSCs */
 #define AGGRE0_NOC_GDSC			0
 #define HLOS1_VOTE_AGGRE0_NOC_GDSC	1
diff --git a/include/dt-bindings/clock/qcom,rpmh.h b/include/dt-bindings/clock/qcom,rpmh.h
index 0a7d1be0d12..bf5b59b1008 100644
--- a/include/dt-bindings/clock/qcom,rpmh.h
+++ b/include/dt-bindings/clock/qcom,rpmh.h
@@ -1,7 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (c) 2018, 2020, The Linux Foundation. All rights reserved. */
 
-
 #ifndef _DT_BINDINGS_CLK_MSM_RPMH_H
 #define _DT_BINDINGS_CLK_MSM_RPMH_H
 
diff --git a/include/dt-bindings/clock/tegra210-car.h b/include/dt-bindings/clock/tegra210-car.h
index bd3530e56d4..eddac16800d 100644
--- a/include/dt-bindings/clock/tegra210-car.h
+++ b/include/dt-bindings/clock/tegra210-car.h
@@ -248,7 +248,6 @@
 #define TEGRA210_CLK_SOR_SAFE 222
 #define TEGRA210_CLK_PLL_P_OUT_CPU 223
 
-
 #define TEGRA210_CLK_UARTB 224
 #define TEGRA210_CLK_VFIR 225
 #define TEGRA210_CLK_SPDIF_IN 226
diff --git a/include/dt-bindings/dma/at91.h b/include/dt-bindings/dma/at91.h
index ab6cbba4540..0e7814b0dce 100644
--- a/include/dt-bindings/dma/at91.h
+++ b/include/dt-bindings/dma/at91.h
@@ -26,7 +26,6 @@
 #define AT91_DMA_CFG_FIFOCFG_ALAP	(0x1 << AT91_DMA_CFG_FIFOCFG_OFFSET)	/* largest defined AHB burst */
 #define AT91_DMA_CFG_FIFOCFG_ASAP	(0x2 << AT91_DMA_CFG_FIFOCFG_OFFSET)	/* single AHB access */
 
-
 /* ---------- XDMAC ---------- */
 #define AT91_XDMAC_DT_MEM_IF_MASK	(0x1)
 #define AT91_XDMAC_DT_MEM_IF_OFFSET	(13)
diff --git a/include/dt-bindings/mfd/stm32f7-rcc.h b/include/dt-bindings/mfd/stm32f7-rcc.h
index a4e4f927139..1aa267e76a5 100644
--- a/include/dt-bindings/mfd/stm32f7-rcc.h
+++ b/include/dt-bindings/mfd/stm32f7-rcc.h
@@ -34,7 +34,6 @@
 #define STM32F7_AHB1_RESET(bit) (STM32F7_RCC_AHB1_##bit + (0x10 * 8))
 #define STM32F7_AHB1_CLOCK(bit) (STM32F7_RCC_AHB1_##bit)
 
-
 /* AHB2 */
 #define STM32F7_RCC_AHB2_DCMI		0
 #define STM32F7_RCC_AHB2_CRYP		4
-- 
2.43.0

