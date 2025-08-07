Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 201D4C87FCF
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 11:20:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B614F844F1;
	Thu,  7 Aug 2025 13:20:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Smy9fIrW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20BC783C34; Thu,  7 Aug 2025 13:20:10 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41E7283C61
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 13:20:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3b7886bee77so670332f8f.0
 for <u-boot@lists.denx.de>; Thu, 07 Aug 2025 04:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754565606; x=1755170406; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lhCEOMPhEmsHb5b9ZuAxsMW4rshIDR3WmdafXvekejo=;
 b=Smy9fIrW/CQx9DZ8whLE6U+vRJjbfyr2rvVioumFUHcvqwwE7g+7/pSqoTS5Cv6Zsp
 9bSTXAavq29NHwaXl5pa/VLDkHOG7fnxef+4RffJsiBxZS3S74SdF0q2DEwp2KdY44mo
 pze0h2EdoXc6ardbXcrDUbu15Lsdwd/TJ8ps1RfqILhTZeAj8rr9ovmkHUVeMCzX9WX9
 LZatcFiTNbyPpu76j0Sp8vb8AhaRI7rYur7PwNhOWnY9TrExFmUHnbHz2qWhTVhyFELz
 wP0Oxppp2Rq8F5qpY/vjA9RrWizacptmFfcfSR7Le80QjV+fvnrsRfE3zAPcBCVCh9OI
 qD5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754565606; x=1755170406;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lhCEOMPhEmsHb5b9ZuAxsMW4rshIDR3WmdafXvekejo=;
 b=wBT0By+yOaBdBuVuuEPhTmroftSkFv9AERRTEtiPfzMNtRxhDoV1VQkFfXhJVwSuzl
 EFfnKS54w4teNXqFAqNd7iWUCcFhZ17Bw4R7oVFOuN1MmIDWHvoLsMwEM7aGv+UlIO+E
 9cO/Dnu+tUIcdjs5UPX7Hi1Cxg9vVICOdgCr9xqSMgdg1njaxl1rB1rJ1Rer0PC/FVBB
 hgFgFAEF0ADVP0z/wvMPsOX3CGcNxAy1UH0qeeQDmiPePh34aCakLTI9IzMmkJnwgSkt
 71LQDg4N2xj4O4h0NSHCAoYq+ab5moJXF0Vm3d25j+zSjO0J78yuGnhQYzPP+508SGH4
 idYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9RhlfqiQYIUF1H5mor8/TIdhsXPYS6Ol2Iu5VMzGQX4SWmdgtwUSWyUcOzviTBubFMGJ5Q50=@lists.denx.de
X-Gm-Message-State: AOJu0Yy+pu8NZ9g6A62qC/AUEA4XNFxpEprhRwmr0ayVVX/7ohGi7iz9
 A3RfCnKwTSD4r0VhxXXTGb7YoIp28L5q4El6f0i/QRhumTj+2ZH1zkz8wEWYalooFlw=
X-Gm-Gg: ASbGncttx0W0qRXEdocbxyKgpglUbdc2EsTVissBY1yOAIESYAQ+bEQKUQR/zhK6Lm9
 pgsaBvknoT3nfTyIQS53vc+6dQB+6VpW1FC1iWxW1Z2oS13awMY0r2sQLYZDsyA0DRiLMjTFbuO
 pT1TeFnNUk4DsFvR4K29Kf52QaZvnh04KXkHhIPSZzC5aujXwGAaNDI84IlKA6Z8K5/BFagM7e8
 acCGQ72EohbYZFfepFjEWO/hAd0yTyU04TR3PNpW00kdLrE+gVd/O3SW7uxsz22WOCoJ+KwI12z
 4uHxy8QNyjiSMKp3zbGSuoxpShREE5aIHMZQqFP0QEMXm/ikw1Bn32y4taIv6tVT1GOV7ijDimB
 p6ZyHXYLg28t1kdBIekb0TyFB7KlqPORTlB0w3ctsF3hQvyjyypw=
X-Google-Smtp-Source: AGHT+IHpDuOdmgoJgkXxbwycWwLZ+viAxatSrfPatpsbdJYe1+b1hXHwh6/ZJ0DpX7p8yR0GCNM1eg==
X-Received: by 2002:a05:6000:22c5:b0:3b7:bedd:d268 with SMTP id
 ffacd0b85a97d-3b8f41bf05amr5417651f8f.53.1754565606143; 
 Thu, 07 Aug 2025 04:20:06 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:377e:cf4f:d0ff:80bf])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3bf956sm27038612f8f.24.2025.08.07.04.20.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 04:20:05 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Thu, 07 Aug 2025 12:20:02 +0100
Subject: [PATCH 2/2] pinctrl: qcom: sdm845: Limit check off by 1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250807-pinctrl_qcom-v1-2-42fac6707fd5@linaro.org>
References: <20250807-pinctrl_qcom-v1-0-42fac6707fd5@linaro.org>
In-Reply-To: <20250807-pinctrl_qcom-v1-0-42fac6707fd5@linaro.org>
To: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

The driver specifies 154 pins so should have a maximum selector of 153
to ensure that the index into the array special_pins_names does not
overflow.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/pinctrl/qcom/pinctrl-sdm845.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-sdm845.c b/drivers/pinctrl/qcom/pinctrl-sdm845.c
index 3f55fc81c8e..24b42e94c7a 100644
--- a/drivers/pinctrl/qcom/pinctrl-sdm845.c
+++ b/drivers/pinctrl/qcom/pinctrl-sdm845.c
@@ -72,7 +72,7 @@ static const char *sdm845_get_pin_name(struct udevice *dev,
 		"sdc2_data",
 	};
 
-	if (selector >= 150 && selector <= 154)
+	if (selector >= 150 && selector <= 153)
 		snprintf(pin_name, MAX_PIN_NAME_LEN, special_pins_names[selector - 150]);
 	else
 		snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);

-- 
2.39.5

