Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB650C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 15:04:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3EB787D57;
	Mon, 15 Apr 2024 17:03:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dcW09vw4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3658287CF2; Mon, 15 Apr 2024 17:03:50 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9493487E3F
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 17:03:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4187a98705cso3295165e9.2
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 08:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713193423; x=1713798223; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=75JeNrH2fm9Dj7m4XrOpiemG5n9ITOmRPsU5m9vbyek=;
 b=dcW09vw4dmIpKNWzdWxz6AQKjjZLagh7dukPJzPQ0hpHEGImQT93DuCL1Ucp7k3SKN
 7pkHQwDQDaxwDTlWszcsxu6ZsIAdw7b7Tfv7U7Pw17cdzsEIk7pA5FoI/pAoeU1XzPdi
 H0n2KAWJyqlCrTybPm1cGFM3t7xfMSLVmLJuyIjAYxdaJ1J6W56rMRBMMtOCOXSzicjZ
 vEcgsIQVLwXamBIRClrwLlvfEg5o06WR6xnQhGxzVHDQHDRkalSuwVg3zHbI4kcVPg6X
 2EpBbmkCtqEs/JrxnoUSkK4h+5soazubhe+d4YZCpyNxa9YWkRIFmbqaFcXjnSep5+tQ
 eaaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713193423; x=1713798223;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=75JeNrH2fm9Dj7m4XrOpiemG5n9ITOmRPsU5m9vbyek=;
 b=kVCi07zs6pf3C0Lm1kKh8XcjL/IXbptYNc7x3gTLAApYCrGfVOwB4XbVgUEHTKJvVg
 /LWcq85MWZb+JTLF/H9A0JrbrgzZ0P1LB+5l4EebqHZNRYUdcugWecPr2wyhT5j/CPvv
 XnlfFQg1r1/blXUXuyfhb1LA+vWs5bYuyItfwmNz7PCLsw0yli5nav7lJVBZhRRfRfuw
 xYhtnWzzCv0R2OIxthy1Y36UmfGpNWA4Yj28W94bxbVjjFx3kceuX9WyVkyBvhbL2RBL
 dJZwNbX4AE6rQ46SSEeQhvXII+0xC0uNJ13s0gm6tIPy7QwOftCP2FbBSdkrpQZKR92z
 JF5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdziQ4pD00hpQ9eHGlEyTuft1iDbYbNOGmekB6hqH88Ial4sdhHj87iCmr2dvQoyfdfH41QhPUzs88pyaH2AMA7rhrVw==
X-Gm-Message-State: AOJu0YzXUFrLspFgwni31UJdzu/jGg1rle9YnLgBE5gIm/dpdgDHhYGO
 HDUHIDw50kYY7vJV93EoC9XJ+TNnYTUau8ACzSgy/9VKGZPwyG2vHIYzCQW4YAg=
X-Google-Smtp-Source: AGHT+IHHmiD9iRg7BoZUXLz0bsETObpb7bATC7RrRYkwkdpqhQ7qIHi3N6vwwAOcjAU5Sz7iu6Rmeg==
X-Received: by 2002:a05:600c:4689:b0:418:4ecb:fc80 with SMTP id
 p9-20020a05600c468900b004184ecbfc80mr2335105wmo.23.1713193422789; 
 Mon, 15 Apr 2024 08:03:42 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 p7-20020a05600c358700b004182cd07133sm9040333wmq.3.2024.04.15.08.03.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Apr 2024 08:03:42 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 15 Apr 2024 16:03:39 +0100
Subject: [PATCH v2 2/3] clk/qcom: ipq4019: return valid rate when setting
 UART clock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240415-b4-msm-serial-bitrate-v2-2-b7a048adc6a3@linaro.org>
References: <20240415-b4-msm-serial-bitrate-v2-0-b7a048adc6a3@linaro.org>
In-Reply-To: <20240415-b4-msm-serial-bitrate-v2-0-b7a048adc6a3@linaro.org>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: Robert Marko <robert.marko@sartura.hr>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=979;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=jbE4uxM05hys6K6aPZcowyfpb9rgLC2loD8Pu1qX1Mc=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhjRZx9M3F256+5Wh45rBuoxbjiniNZxzj3/es3zz5f0MQ
 WUNTjIhHaUsDIIcDLJiiiziJ5ZZNq29bK+xfcEFmDmsTCBDGLg4BWAit/4wMsz4O8/v3Ncg0aeJ
 Emtc+makL1De+ujl54iDmT8Z2j8U2HAy/OFo+R3v1/li2gMGy+319r5d8XNLzjRaBBxPEw1s5T6
 kNBkA
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

clk_set_rate() should return the clock rate that was set. The IPQ4019
clock driver doesn't set any rates yet but it should still return the
expected value so that drivers can work properly.

For a baud rate of 115200 with an expected bit clock divisor of 16, the
clock rate should be 1843200 so return that frequency.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/clk/qcom/clock-ipq4019.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/clock-ipq4019.c b/drivers/clk/qcom/clock-ipq4019.c
index d693776d339d..72f235eab212 100644
--- a/drivers/clk/qcom/clock-ipq4019.c
+++ b/drivers/clk/qcom/clock-ipq4019.c
@@ -20,9 +20,9 @@ static ulong ipq4019_clk_set_rate(struct clk *clk, ulong rate)
 {
 	switch (clk->id) {
 	case GCC_BLSP1_UART1_APPS_CLK: /*UART1*/
 		/* This clock is already initialized by SBL1 */
-		return 0;
+		return 1843200;
 	default:
 		return -EINVAL;
 	}
 }

-- 
2.44.0

