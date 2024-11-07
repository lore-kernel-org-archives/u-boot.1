Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8585CD5AE46
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 02:58:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7C8788CD9;
	Thu,  7 Nov 2024 03:58:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kJiK5BpU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA707891D7; Thu,  7 Nov 2024 03:58:36 +0100 (CET)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 389DC88A9D
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 03:58:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3e5f86e59f1so332200b6e.1
 for <u-boot@lists.denx.de>; Wed, 06 Nov 2024 18:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730948313; x=1731553113; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TNE21ZH5+wzDSDaWBE/g3mpXJTJhpQotd7ensLGy83M=;
 b=kJiK5BpUd1VZsyKpAm2brhpok9W0U9j+Ns/7C6awumzq8Q8S2pOvoYefTzMCkmcbc9
 DfVnTf523WEDoSpSFu9mM+I8kt3W62Z8JU6NIYbwFAaBj5SMynKF3TyvzjZDA/I8fanI
 geuhzYYWdioSiwY42LR93kBn2toWfp5+D2Km+9NgHt3aYijYLXOkYmX+BZtrN5gic4SH
 AQAO478SicJXsV/0xWqFswQ5pVshjvg5R3XkGIuQ0RnOD7BWR1aFrVcWs7x0UfIXGqdu
 WD+gKQ9A34XLKZ+w5So36pnt6hYJDCE/30/qpA1MTnxfuPWOTSQIcCKRE0gbg+TKdV80
 aPlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730948313; x=1731553113;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TNE21ZH5+wzDSDaWBE/g3mpXJTJhpQotd7ensLGy83M=;
 b=RNYRKn8i1HxG0WjSBNmxTJzSXBQ7Z/DsaGLXxlZP0vs4ExF/f2THZce86c6v9c3UC7
 aJnQo50oGWEqv437Rr43lZHpQ7cNpsQtvVlJhWu5OmQyrjVK83gRjZDBB6tju3tJ9eqh
 DmlvylDLKkPr7iWmCatH7ga8s9grqf27KViUWwRc5D9PNSjIEN3fcZXdkqBSVKAmGJP8
 S94ZAPtFIvJM6hakiOHb3k4Ln08q/mOGqL5lvqU43/l8t7veo+i+hkc1xMY07oGNWb0h
 fWmfqCRPBHPrKHkfIvwUKEQ4tVkqXDVdHqVd2mVjrvEgP8h0+Ej+OBrex9b3ppSMuw2Z
 QATw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhDsxtoq2BaO1mHlyef5kjBf51q1TTXJySdgblXbiQg61P/G2YOjFDkrGhjrOGEpvcy5HaEmI=@lists.denx.de
X-Gm-Message-State: AOJu0YxQil8eotS8IhzBPSCbkTValHHrM4IWazfTkKRxQF9kxnZ1IBqu
 3RKLOWqa2XlgvfWcNXOJvOk3oHwByP31cxYfo1c2N59QMuM7OFIFtubW+3ra32E=
X-Google-Smtp-Source: AGHT+IE5dscd6bJUtu3mrDFI9FwNhxUKgrBomrGP3iocb80h1Ykth1xcuKrTYT5DfhzQ6a493hc/lA==
X-Received: by 2002:a05:6808:1922:b0:3e3:c411:adf0 with SMTP id
 5614622812f47-3e78d35aaaemr443899b6e.21.1730948312845; 
 Wed, 06 Nov 2024 18:58:32 -0800 (PST)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3e78cc80866sm94907b6e.16.2024.11.06.18.58.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2024 18:58:32 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: David Feng <fenghua@phytium.com.cn>,
	u-boot@lists.denx.de
Subject: [PATCH v2 1/2] armv8: Fix get_sctlr() return type
Date: Wed,  6 Nov 2024 20:58:30 -0600
Message-Id: <20241107025831.5459-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
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

SCTLR_EL2 is a 64-bit register [1]. Return its value as long (64 bit)
instead of int (32 bit) in get_sctlr() to make sure it's not trimmed.

[1] https://developer.arm.com/documentation/ddi0595/2021-06/AArch64-Registers/SCTLR-EL2--System-Control-Register--EL2-?lang=en

Fixes: 0ae7653128c8 ("arm64: core support")
Suggested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v2:
  - None (this patch was introduced in v2)

 arch/arm/cpu/armv8/cache_v8.c | 2 +-
 arch/arm/include/asm/system.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
index e6be6359c5d9..5d6953ffedd1 100644
--- a/arch/arm/cpu/armv8/cache_v8.c
+++ b/arch/arm/cpu/armv8/cache_v8.c
@@ -825,7 +825,7 @@ void dcache_enable(void)
 
 void dcache_disable(void)
 {
-	uint32_t sctlr;
+	unsigned long sctlr;
 
 	sctlr = get_sctlr();
 
diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
index 52f6c9b934d7..dbf9ab43e280 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -171,7 +171,7 @@ static inline unsigned int current_el(void)
 	return 3 & (el >> 2);
 }
 
-static inline unsigned int get_sctlr(void)
+static inline unsigned long get_sctlr(void)
 {
 	unsigned int el;
 	unsigned long val;
-- 
2.39.5

