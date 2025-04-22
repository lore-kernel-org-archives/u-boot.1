Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D91D0C369D1
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 10:54:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72CA681CF0;
	Tue, 22 Apr 2025 12:54:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="S+Zh+kBQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 894A581CAF; Tue, 22 Apr 2025 12:54:39 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 928F0812BC
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 12:54:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5e6f4b3ebe5so9084871a12.0
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 03:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745319277; x=1745924077; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Y7WU/oizag/lowJHgE3Dpg7mwnI+gNVm0sXEVOxmMnY=;
 b=S+Zh+kBQbprLe7LAgEVBcgZYGRbq2tNvRF2RZkGTib9R5hFLPgKG/fMmSxCTr+ynjT
 Jd6GFuPYOZhmq4llgaTCo6hmo3YqLIp637Laq+ecKgJVtTB48rdJqNJwWfXzadIUCZyz
 /MDgoJifmMHi7PuQZjfx+ji2UBuTSqYzIYzppXRJy8yHFAd9qaejST61G/t6BOUQW8TJ
 Oek5ewIEBoH0OjpCIKbPf5EmwsBClt30g95MdcgpNLhbTXmvSKZkGPHQtlYdKDQ0qT/H
 jFXxHG7eebgSZDQHoSybz9UvjKAQ5cn6jwe2+FAx7PBXq/xGB54Ne/SgqsncdqJfMaeY
 NGZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745319277; x=1745924077;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y7WU/oizag/lowJHgE3Dpg7mwnI+gNVm0sXEVOxmMnY=;
 b=IvwG3Qubo+Xm3bqARHdDggPvan7BnRcLeOne/V9fvMaaJrOx5e39US+MnriNhMR5Pt
 5OaiqFdD82LtwjGlRy6pfO9FPjBPL72HjkTbl+rxlwxi+2Keeb2SY+IFG8PNXMUwzdxH
 K02gEg0BYHiPrDCH60gYJiyc/2AAFU48BkLMsriJwwRIJshtcQoKR5VgSQixnjjiswJJ
 lKeyMdmfiS8VzrmmwKVL0hd9qRx8qZXBIH0Edpmz9xLByISvqBvnQzB5PPgkSm2pwzUt
 mFYJ1RsrXzPD9HMJxY4F7t03U8PQMw9ze/7we6Wfp8vv3iv+DR9JrYhc7giwidZ2dCdr
 55EQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtQZJ29rH+d0kWs7r8iD3kDSRidaieCDx2mIS02wOGKJgEFZVbN4mvepiPT3yKexi+K/WE/C4=@lists.denx.de
X-Gm-Message-State: AOJu0Ywo2vL0I+ydW0Ah9oxjbJl9TyfBvlZBTchaf8Vg2HQ+YArQbbbC
 I+G0FN5F05Jqq8Ehb6+AVymqBcdYkVxN2JoGicxorQ4hPGro1EnS+wYyjnIGX1c=
X-Gm-Gg: ASbGncv2h/T1cTRP3hwCihnTGeiNXIGdoPSt5KsIpqS5Zg+k9WplVgaVT/cbZLnQNmj
 17CxERkvzJBGyjI+963x8czmb9NvRBIJs8AsJgX5McrFml/iYMF928kkH1S9CeafYlUk01qSEwB
 mmhrajDMINuYB5O/QMwTDIgH9ysltf4gcjczsNHFSs7itk3n2AUJYyqO3ClGNY0xxKqrKIt/TWa
 haqAAls03n3ldO7awNS3qxRIM4KA+/GklRPiWgVVBLRGqzy5SItBB3m0Jr2MHrC32VuFlO7F/2H
 IQGVbqkA/+qphCR7hz9LkHI+bqqQZ1mkCcXZ6AGtERs2XUI49x81ydW33Tf6oJLy
X-Google-Smtp-Source: AGHT+IFFPqZje1+n4o5OfW25/Bg2/uqKj5ctHLJvuIvmvEBltigfl7tX1h1KjMDxf5EPDj/RyIetXA==
X-Received: by 2002:a05:6402:1e96:b0:5eb:cc22:aa00 with SMTP id
 4fb4d7f45d1cf-5f628551676mr13103495a12.19.1745319276948; 
 Tue, 22 Apr 2025 03:54:36 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef30:d722:61ae:90dc:b4e7])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f62554a1desm5709635a12.8.2025.04.22.03.54.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 03:54:36 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Tue, 22 Apr 2025 12:54:06 +0200
Subject: [PATCH 1/6] clk: qcom: apq8016: Fix SDCC clock addresses
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250422-apq8016-clock-fixes2-v1-1-bfc9dd933da6@linaro.org>
References: <20250422-apq8016-clock-fixes2-v1-0-bfc9dd933da6@linaro.org>
In-Reply-To: <20250422-apq8016-clock-fixes2-v1-0-bfc9dd933da6@linaro.org>
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

