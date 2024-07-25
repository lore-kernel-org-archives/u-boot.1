Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B4AC3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 20:48:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 534EC8869E;
	Thu, 25 Jul 2024 22:45:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qvyb4ty1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DC6E8851E; Thu, 25 Jul 2024 22:45:38 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88CA188548
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 22:45:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3db157cb959so187236b6e.0
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 13:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721940333; x=1722545133; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kYqZyVAHZrNM0H2n8OxL4kFCb9lPiM+vnuEfsBZOrHI=;
 b=qvyb4ty13rY7yZGqEeH4d2bSFUWLthM7b6TnzojuOBtczdYRtfxq5ZY3FnVEhXvZf0
 VsD/EKhmEb47oa5NvZbSxsvN16qbIafjUmDlrcrHXgMeoTodmHecWXJwb/y+90m8phfM
 BY7lDjG0W5g8vXGgsbsBGWLVNBpQ624RX4QSbROok5qWWC+ha0iPFtdd/06ACRs9iIMn
 r9ECnzkCFun1d5BW0G99Nqd8Kxj36uiHmNRablhzCgTfXdyQr63pFaKbfc03vEslVDxE
 p15P89k9l4cCiC+RHRc6tLIWlKz4jd6P99mCmmAHAc+Gbtte8ovOHgaTy/ZcOm+aDVwA
 mQnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721940333; x=1722545133;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kYqZyVAHZrNM0H2n8OxL4kFCb9lPiM+vnuEfsBZOrHI=;
 b=uIXQNhQVoNU4pSh7mlV8A4EP5pC/FoDIE/e+RLaGOlakiWf+useY//hAQLZABTUvkI
 4D3Kc+lMN3Ck3Unz1HC34FLpIYIcdv3j5jjkgmLJZta09SPPlhAIhTHGIgkQ22eaLMmw
 ZePi/HuAVPf3Fh5/YT2aibinVRWZg5fxUGIGhHk2WTlxlbb2IJrRo6zsHlrJ8Z2NvBj0
 Qn97n2xVRdszzhsTMReIEu49N8RhCzL3khjlC0z99nI7qGsHvL6Iu7PbZb9uovVayT5O
 j9exdM+zt1ueKUWg3rVkq+lgL4lkq8ybqdZaBMf5UyDrUhPLBOHk07fIpSj3pT2ORKh+
 MlIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVn10Xqkof8D6YQuJKK01nwiMCsUX+hmkbcNzn7EGtG/886rx1gPfazVOn/QI4XOa4DgjWoJiVxiFUnUzCyCkj5x3D8g==
X-Gm-Message-State: AOJu0Ywz5vee3YbkpxyOderO7Y7ve96yqTbcFFzZB+3vkErTVcDN56/5
 Dja4Fd7jtg5VJtVxwo6uITSp+lMP/At0Wep69+6aw7sBLc+fWfL01ZEK5RWc7dM=
X-Google-Smtp-Source: AGHT+IGRz5paOhuZ/XUDz86SzNj5aU2Cr2fD84q+sBaVUJQn7AZNWWXrxSH8u+r2/MtWvp0aDpn+qw==
X-Received: by 2002:a05:6808:222a:b0:3d6:317b:a95c with SMTP id
 5614622812f47-3db14157118mr3798997b6e.38.1721940333288; 
 Thu, 25 Jul 2024 13:45:33 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3db133fc6d4sm437317b6e.7.2024.07.25.13.45.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 13:45:33 -0700 (PDT)
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
Subject: [PATCH v4 16/38] arm: exynos: Add header guard for dwmmc.h
Date: Thu, 25 Jul 2024 15:44:58 -0500
Message-Id: <20240725204520.18134-17-semen.protsenko@linaro.org>
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

Add missing header guard to prevent possible build errors.

Fixes: 77b55e8cfcee ("ARM: exynos: move SoC sources to mach-exynos")
Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
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

