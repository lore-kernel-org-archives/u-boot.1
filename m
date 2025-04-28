Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6617FC369D9
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 17:11:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF9C3822D7;
	Mon, 28 Apr 2025 19:10:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="tJuG8Pdz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6290C8215F; Mon, 28 Apr 2025 11:16:29 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F5B2820B7
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 11:16:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-39c0dfba946so3269444f8f.3
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 02:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1745831787; x=1746436587;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=l/CE2kwFO2qZYUKG9bbswiG1ALPqoRJCEF+u5PVGRGY=;
 b=tJuG8PdzKRF5F0Bd+H3PdQQbxs/GOKc56Dv67nFJcKtZ+6vPSA0ljVK5BswEbg5qqI
 qZsg2SbLk8CRfDWVbOeX6F+fC2wuOZstNqQz0XoXYZ4uB+uqQCAkAhI82qn3teLR6Z5G
 nHegIxZcIfgkUmeziDMtrsJLyHw168IiXgX+nj6g2Acf74qQqAEtN+fGOdRl4d9ZcQpI
 xecmZIZaqOwRl/Oa9LZkMM22BK3/Dj39ts+0jYplFz0faimEGqDEh4ntie+NWCymtTWb
 L5X3HXIjGSiCePzw8y49/UVo2ZfaAgJAHmBD6cJQvULwoYXH95kRmPBG3o9RIgcwsoXU
 SwKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745831787; x=1746436587;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l/CE2kwFO2qZYUKG9bbswiG1ALPqoRJCEF+u5PVGRGY=;
 b=VVVPvRmt9JCd4NXyw+XOFSNEh1ESN1vx5FYZMShrQOTVCKZsXsZtz1bxdrSSAkbgPm
 yfG0mS7fV4SkWCAZcqWmDuskPiM+dn6yKhL7UUSyebJ1Ysrf37oOCOR948WJeGX67ifb
 +5ozua1mMAa/KeX8vXZoiuQkr95UhXko0nSoF3tGd/awtK7Sgg+4fuMeBwMcIoEj9rZs
 Apj3waS3atYs1a3qBVV+RVTSSZ+RQlMN1/YFGAMobgVOCd+3zuc9V8yu6CysPh7r6IQe
 2Ss7BDxVfromqi27qjtJ5G16j9+wpihCJrDZemyzyst52rypdjD7CrfoGc+qnDlo//BD
 gUxg==
X-Gm-Message-State: AOJu0YwN6o1HK5jA3JsjKbgbCMzRu5+rKTf5up0ECNNDabpLzHa4gsNr
 XNpXz9cW1dYw67UDN+WJZJwFmXgP4FOLEux/oxQa4HpNXQ2x/uy6OpeiK9EcN6s=
X-Gm-Gg: ASbGncuTMU82e48oNw/fSS0LyFqUociKd4Y29kqJO67ZJ/mFlr0Pd61oLrcK6SUUzWZ
 pHmyRmVAzMEjyHWbHT53J6mYS9pBDFFR1xJ1EWL1wemHfxYq0uH5AaWwsMeKZJ4T5iff9HpgSHi
 pJxij5Wr/6Z4vTrWHKGiVnxereCRu6GJgN9EnIboe0TIA92hIHPhI0PHuB2BeJe5FZCkE9MvP3K
 mpNH2GkGnw7rebb+p4AWno5xa0mlFejKDi4H8sM9pSRYtPaBRNxTCH/t9h/bhzsLUkRHcS8rG5m
 vLKVtlhMDWEMDL5kR6zkQtritUdVlXo+Qqthl2o=
X-Google-Smtp-Source: AGHT+IE0e4OqOCqQgYz9KvUO8CynZDitEYc8d2FtwuoHAv+fGo/VRbhVD7i3eC170ExYfaj8+bfoHw==
X-Received: by 2002:adf:f989:0:b0:39c:2678:302b with SMTP id
 ffacd0b85a97d-3a07ab9be39mr5295623f8f.45.1745831786896; 
 Mon, 28 Apr 2025 02:16:26 -0700 (PDT)
Received: from [127.0.1.1] ([78.199.60.143])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3a073e5da0dsm10345258f8f.88.2025.04.28.02.16.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 02:16:26 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
Date: Mon, 28 Apr 2025 11:16:23 +0200
Subject: [PATCH v4 1/6] arm: at91: wdt: Remove at91_wdt struct
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-wdt-v4-1-bb7d1c7c051a@hifiphile.com>
References: <20250428-wdt-v4-0-bb7d1c7c051a@hifiphile.com>
In-Reply-To: <20250428-wdt-v4-0-bb7d1c7c051a@hifiphile.com>
To: Eugen Hristev <eugen.hristev@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de, Zixun LI <admin@hifiphile.com>
X-Mailer: b4 0.14.2
X-Mailman-Approved-At: Mon, 28 Apr 2025 19:10:16 +0200
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

at91_wdt struct is only used by spl, remove this reference and the struct
itself.

Signed-off-by: Zixun LI <admin@hifiphile.com>
---
 arch/arm/mach-at91/include/mach/at91_wdt.h | 6 ------
 arch/arm/mach-at91/spl.c                   | 4 +---
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/arm/mach-at91/include/mach/at91_wdt.h b/arch/arm/mach-at91/include/mach/at91_wdt.h
index 8ef8e007d7767308a5b46be46b02c51073723a41..78ad0453fd9eb3e42674d10cb11ce3da820cdc6a 100644
--- a/arch/arm/mach-at91/include/mach/at91_wdt.h
+++ b/arch/arm/mach-at91/include/mach/at91_wdt.h
@@ -19,12 +19,6 @@
 
 #else
 
-typedef struct at91_wdt {
-	u32	cr;
-	u32	mr;
-	u32	sr;
-} at91_wdt_t;
-
 struct at91_wdt_priv {
 	void __iomem *regs;
 	u32 regval;
diff --git a/arch/arm/mach-at91/spl.c b/arch/arm/mach-at91/spl.c
index 5feb8f735511a45dd37ee04bb3742f57d8f2e067..a814973242a723c47af210bd76db9210db061063 100644
--- a/arch/arm/mach-at91/spl.c
+++ b/arch/arm/mach-at91/spl.c
@@ -14,9 +14,7 @@
 #if !defined(CONFIG_WDT_AT91)
 void at91_disable_wdt(void)
 {
-	struct at91_wdt *wdt = (struct at91_wdt *)ATMEL_BASE_WDT;
-
-	writel(AT91_WDT_MR_WDDIS, &wdt->mr);
+	writel(AT91_WDT_MR_WDDIS, ATMEL_BASE_WDT + AT91_WDT_MR);
 }
 #endif
 

-- 
2.49.0

