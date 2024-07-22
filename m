Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8379C3DA59
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 18:00:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EC66886BB;
	Mon, 22 Jul 2024 19:58:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iwFhkGz3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92FCB884AC; Mon, 22 Jul 2024 19:57:58 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C2AC885B6
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 19:57:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-70368b53cc0so2299702a34.1
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 10:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721671073; x=1722275873; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PPILu+oS4i00jOzIMXyC/z62h6jSzQ9rf9UfyCALLiY=;
 b=iwFhkGz3oPVIpqTBX3cjCyxAomboJDXKXUUVzUNiwclAs2dY0AyDLXDUgdnVrswkS4
 t1ousRPhYIaXUIq4KSaRGAtiXarnBD7Q9vwlNKZKQSz5V6Bd7jBQm2CQ5dXvwz46tqF9
 7+LJfX/rXvTSi61UlVDJHBWiDLSJUFs4MDRPJiBCHmE9cSbKKg6NBZXttAje9RaDe4UP
 B8/5X5pRrJLLVr6qVGTFw+DKlrhbsC2L2g8TwL4sM8uLj3RnuH/hMD+WxgQOyEFbB0VV
 n2VYvr34HaPT2fBVbTWgWrt7xugZ0v/LPCBqcPgSesIiogAFAIBqFCJ6PyMXuEqJ51p8
 1HtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721671073; x=1722275873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PPILu+oS4i00jOzIMXyC/z62h6jSzQ9rf9UfyCALLiY=;
 b=sntoBhS9HmoTvMm7Zv/rf2z0e75ezKM6nDF0gZ/x6R5oy+COxkA7a9cjFQfUKJ1ovS
 I4NKAdZkINAPjti+YXcJZ0a6Niaj5D+lDPQ0j5DzvIRlxvy2E5UKVrhTMfHDZa1kwQ6z
 8WN1XdIV3SWZGNroR55hujX58R6s8zsqeLBsWqDtxBwLGJx9iEnyonCMHttPA+YPcL0I
 SMWoYGqtgh+HdNB5AFyc6x0lr5oqHt79uUzAroIjuIaQ1FtZSJC5NquW2pkJe1wNrnTT
 C2aMXXj10Poog6mmD8sp954R2Pa0LvvlYR5DNkQkokR2cXOTx/V6i842HGStSaSpEApA
 BI1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3wRyQJb0PLcNHXp7lP/Ed7tT5rfdvYAoulRkdSy4CkPOq649t5FcVIQlnfg/6Dlse/8MkmkdmkNZBRqAUKJyN3PUjNQ==
X-Gm-Message-State: AOJu0YxetKEZR88HTLdTwizdv1GeNO6Eud6R3On9/OU20zjaq8X2VfGm
 rAry3FLzahcfsalfjTUoJEyylClQ26NoL0Y7gTmE3I9GL1APGNX9SrbKY4uje9E=
X-Google-Smtp-Source: AGHT+IHcWhLRNWd0/PHXfEK+gDsEhtYx4zKGA1+oxl6l1lyloE1HPHaYbYVM6efwmmtwMGArLoNMMA==
X-Received: by 2002:a05:6830:278b:b0:708:b28d:f964 with SMTP id
 46e09a7af769-70900912bb7mr9061996a34.18.1721671073037; 
 Mon, 22 Jul 2024 10:57:53 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-708f60c1944sm1638181a34.20.2024.07.22.10.57.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 10:57:52 -0700 (PDT)
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
Subject: [PATCH v3 16/38] arm: exynos: Add header guard for dwmmc.h
Date: Mon, 22 Jul 2024 12:57:18 -0500
Message-Id: <20240722175740.6985-17-semen.protsenko@linaro.org>
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

Add missing header guard to prevent possible build errors.

Fixes: 77b55e8cfcee ("ARM: exynos: move SoC sources to mach-exynos")
Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
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

