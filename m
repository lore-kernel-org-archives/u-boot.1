Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2894C369AB
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 09:17:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1783F82054;
	Thu, 24 Apr 2025 11:17:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GcospBgI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47E5E809D4; Thu, 24 Apr 2025 11:17:02 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47B50815D1
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 11:17:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43cef035a3bso4720015e9.1
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 02:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745486220; x=1746091020; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xxCPC0FiMfMn5IWelUErW3QGleF5J7FJC1wMvEkACjs=;
 b=GcospBgIqnV6bDi4xeKKjKC6oBUhqNVkRL0hxiA6wRSSy5uWUYOD6c+OxtHWlp60Rb
 p+fMCBGOecuaFV4Ctn2vWy300xn1KjmHa8Ql0aY5jJEXrlwuWzQERba5sNyBL758XNIa
 /XOFI+XPPa8o2ElnQwVszRLtclvqp1N4V3AYTaa746tn3CFO1eXNXGqOaa84F6kmGebe
 eGMphgfjL5QBM5V5SFH+4aiOEmEXfZUKXFJ1+qtsO/owpGvcnz00HU/leH5H3f3FbSUH
 Np7NfM06QbcaiuUGzEikGLH77ff9KmRGsmit5sjzKmJpYvB/eUUEBQM0qo6dxOd/tkrf
 LRXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745486220; x=1746091020;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xxCPC0FiMfMn5IWelUErW3QGleF5J7FJC1wMvEkACjs=;
 b=k8/fbKAJPCacdo0IH8Hb8WSzDBpJdlfvWbSRha4v9SAPIDgfilAaL7wnQPi4ixso9U
 9sdAIpLUMb/Xi8RDeOvTGS7QQ4c+7Cssk4QSZVOwtwcWo7D9I3zGqFGQsfxqWVJWDWGz
 J8cLYQCC9PVCKljWzkiHNqbAwRpfNbzZUxTl0Ivhkr4nlqHa2XYtg3pJiP4jTUp0kgxZ
 NUfUsNsv9lvdlPRRCbojPH1f7WcdaIHPhXyIr1pdI3MexDbJ+uEYRYUO4MAAjMt2RFXL
 WuZIl6rszDBNaZihXxB92fwnnxJx88+KaRxKLKj327i/75XBrmotIDPhgqaX0KOQiWed
 5i9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbuy1F0xGVtoG6lek4uuIlmQZIHloxLExy+GqjWwItb25deY2hcmNoqNrqs6tKDU0XprcftaY=@lists.denx.de
X-Gm-Message-State: AOJu0Yx7StGzLrxPk4FODcHYn9jNk/RzNUwiA1VPSbMTvkQYN+bB5xz3
 J2AJj8W2oAWfkuMOYbZaAgbZX0fD5UnFY5OEKtLN2OXGSRzdl5Zt8Ngf6vhK8cw=
X-Gm-Gg: ASbGncvl4TFE+VWr2RBbofGCVRUQm0IHGasveChb+ZRwEkkLNiSxV8eXeNLxs4ssi/l
 XVbUUq90QWkNV8X6eL1nyhzcPhQqgThrM/0J8Cw86fNyyyuuyiWZcYp2ISt4SaDrDcGpOY34qb9
 MOJT5nXRBGco4cR3c2+4TBETLozcA/id9evcmJ5gIheKBBbJLxkmNU7btXkv4X95RtcBx98bB8N
 xBr9/TInDOK73VqlEwcAuW12KeF7mJeWitKmFOdr9MjrDcJCzKnusctQOSO0GYQr/Y/TUgTeWkI
 zC6PRIRl0go7/amW9E38Qcd9jlZLnVA4pxqQRY14Nskmy5lyeZ8=
X-Google-Smtp-Source: AGHT+IFvpVJjToGCfXv3ii4UsEVehfesgz3basSjjQQFj4rKBYGkMoP+KZUs/HGNqKNgQMi9FKiQHg==
X-Received: by 2002:a05:600c:a403:b0:43d:fa5d:9314 with SMTP id
 5b1f17b1804b1-4409e67851fmr7470855e9.32.1745486219648; 
 Thu, 24 Apr 2025 02:16:59 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef30:d677:e5de:3a6:836])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d1e19e1sm13000945e9.0.2025.04.24.02.16.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 02:16:59 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Thu, 24 Apr 2025 11:16:41 +0200
Subject: [PATCH v2 1/6] clk: qcom: apq8016: Fix SDCC clock addresses
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-apq8016-clock-fixes2-v2-1-fcc371c9e45f@linaro.org>
References: <20250424-apq8016-clock-fixes2-v2-0-fcc371c9e45f@linaro.org>
In-Reply-To: <20250424-apq8016-clock-fixes2-v2-0-fcc371c9e45f@linaro.org>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Sam Day <me@samcday.com>, 
 u-boot-qcom@groups.io, u-boot@lists.denx.de
X-Mailer: b4 0.14.2
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

The SDCC_...(n) macros in clock-apq8016.c result in the wrong addresses:

 - SDCC1: SDCC_APPS_CBCR(0) = ((0 * 0x1000) + 0x41018) = 0x41018
   Should be 0x42018, this is an invalid register close to the USB clocks.
 - SDCC2: SDCC_APPS_CBCR(1) = ((1 * 0x1000) + 0x41018) = 0x42018
   Should be 0x43018, this is the SDCC1 clock.

When we try to enable SDCC2, we actually end up enabling SDCC1. When we try
to enable SDCC1, we just issue some broken register writes.

This hasn't caused any trouble so far, because the boot firmware is keeping
both SDCC clocks running. However, if these clocks are disabled when
entering U-Boot, MMC initialization is failing.

Fix this by using the proper offset for the macros. The SDCC_CMD_RCGR() was
already correct, but change it the same way for consistency.

Fixes: 085921368b7d ("arm: Add support for Qualcomm Snapdragon family")
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 drivers/clk/qcom/clock-apq8016.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/qcom/clock-apq8016.c b/drivers/clk/qcom/clock-apq8016.c
index 6a53f900a9e5c065714fea9eceb528e90d29c407..274c71c53ff76c9a7ea18e3698c12b20a9b1f418 100644
--- a/drivers/clk/qcom/clock-apq8016.c
+++ b/drivers/clk/qcom/clock-apq8016.c
@@ -23,10 +23,10 @@
 #define APCS_GPLL_ENA_VOTE		(0x45000)
 #define APCS_CLOCK_BRANCH_ENA_VOTE (0x45004)
 
-#define SDCC_BCR(n)			((n * 0x1000) + 0x41000)
-#define SDCC_CMD_RCGR(n)		(((n + 1) * 0x1000) + 0x41004)
-#define SDCC_APPS_CBCR(n)		((n * 0x1000) + 0x41018)
-#define SDCC_AHB_CBCR(n)		((n * 0x1000) + 0x4101C)
+#define SDCC_BCR(n)			(((n) * 0x1000) + 0x42000)
+#define SDCC_CMD_RCGR(n)		(((n) * 0x1000) + 0x42004)
+#define SDCC_APPS_CBCR(n)		(((n) * 0x1000) + 0x42018)
+#define SDCC_AHB_CBCR(n)		(((n) * 0x1000) + 0x4201C)
 
 /* BLSP1 AHB clock (root clock for BLSP) */
 #define BLSP1_AHB_CBCR			0x1008

-- 
2.47.2

