Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F369AC27C53
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 01:15:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70FB0884BC;
	Mon, 10 Jun 2024 03:12:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PjN/S20O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9FCC8841D; Mon, 10 Jun 2024 03:12:43 +0200 (CEST)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BBED88470
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 03:12:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-254764f5472so1224362fac.1
 for <u-boot@lists.denx.de>; Sun, 09 Jun 2024 18:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717981959; x=1718586759; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=huWm+D9jGBOCac6oNDKL8UaJkATXpleDIsRJ3c0gbNs=;
 b=PjN/S20Oojla5Mw1AlhFv8CXFvRfP4627SQQ6+A/RDEZtGlCxHFYka705+Ihwri0pj
 B2DapCXST4zYvzwYCR+ssKAQLfbrTCaq16DdrcziVUUt3RHuZsy+O+m7t5+4MGBMBy5y
 hu9dPbXS73n4QcmJYoyU13actpP7rWWucmvrkv4PYTmZ5tKfoc8SbBZRS3Lz7H2Q6JJs
 UDBzWcteGVBsXdTNNLZIzW6AO+kTocZ3THYBX/w9VVXGoYN8TaUBcg4ck+MaS4l72PHJ
 BqETblt12L5gJA5GHRZkJVZw/jdlulOxze7MkD4bIaUM39rd1CuN/Epi/8nocRQ9XnmQ
 VKTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717981959; x=1718586759;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=huWm+D9jGBOCac6oNDKL8UaJkATXpleDIsRJ3c0gbNs=;
 b=oIFPDH+wby6SbfqM9ENc4yTDECaeiFngyKaB/zvCkwgwXYU7TvMyG49leSheu3YxOp
 NYYveVgkBvnYGxg2P4jyGDKY0TAZzRIgMX0MboynXHA7PeJocUzOC8bdhjlBlMwHN09z
 tBqUOfxfm2tdiY9k5aWRFFTfsqGmlyIGE0PrLXnycAII3U2JKI8EzVjcN7ibfSZhgJB/
 VSBCO2Uf+Boyfx+vc0G+Rnjy9oaALxZpLQxyrpVtfBmvpkpqI0MHGgI4wBhePoTRSCmJ
 4KMCit1vNM6ORUjoMzi0NQRGqI68QbI70rin9egdxqsLxKz21B8fieFVIoZohlQfc/CW
 9tLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOfEubSEv0VJvNdRwSvLwcQTcY0xfJCQ3yKMVKJkH97am9dfvBE6EglNg0i6tukoRWXe1dOqLUdSvO+RtbjcBR1epJfg==
X-Gm-Message-State: AOJu0YzbDU4sH3E6HryWR8ZJjGOgni08YPTXlEP+7a/d0JxuX7A5SpAi
 Ia9jqrl69/XD4td1r8a1Hf9YWqDnjMuIF9orpvYCPEsd6E4rL2nzFevRqEWwmWY=
X-Google-Smtp-Source: AGHT+IGV/SdwGaWy6xJdLW4/1bdVexAm9iGgV05cC1oAT/sbkwbrm5C6CWB9gSn2dgS2BlIbE9yppw==
X-Received: by 2002:a05:6870:a690:b0:254:b8f5:c918 with SMTP id
 586e51a60fabf-254b8f5cb5emr2802813fac.47.1717981958982; 
 Sun, 09 Jun 2024 18:12:38 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25447ecd779sm2070212fac.30.2024.06.09.18.12.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jun 2024 18:12:38 -0700 (PDT)
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
Subject: [PATCH v2 17/40] arm: exynos: Add header guard for dwmmc.h
Date: Sun,  9 Jun 2024 20:12:03 -0500
Message-Id: <20240610011226.4050-18-semen.protsenko@linaro.org>
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

Add missing header guard to prevent possible build errors.

Fixes: 77b55e8cfcee ("ARM: exynos: move SoC sources to mach-exynos")
Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
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

