Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 192DEC87FCA
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 11:20:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FD33844EC;
	Thu,  7 Aug 2025 13:20:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gxlRboa6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56F8383C34; Thu,  7 Aug 2025 13:20:08 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 003C583C4B
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 13:20:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3b8de6f7556so486836f8f.1
 for <u-boot@lists.denx.de>; Thu, 07 Aug 2025 04:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754565605; x=1755170405; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xwDEmzK+Xo40/sOH6rxRftHkVS4ye6Gu4ilBCK0y32Y=;
 b=gxlRboa64WEvH8pCsY7iHp5gb1PJPe5IszehRQ2EOVzpn66rDlzLxeu6WVd+ZhTJbh
 I+9ODs/DVOyy6hP9oHAMlOF4nnpw96jrJEcFU6obaESk5UEw+6MW+YvzlVXJv1XLOQxJ
 Edm1TvBNgip60rjEkA7K9cB6FDnCq+d2JVvJJnUrjkP5ykoVF9+6GI8c1QFcoWKrdQ8z
 IpgTgMQN/cmJdgict4uM+Pcl/KHUSuVBep46N6uEIVm0P+hvkUojQl94U8WEwUMQdqhu
 Xm092IUIG5nZad3x16EJUP5v7hz8gt4zdshmchr7dtM4lcp5OMYeEEy/aCs/KLBKeL6H
 0xIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754565605; x=1755170405;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xwDEmzK+Xo40/sOH6rxRftHkVS4ye6Gu4ilBCK0y32Y=;
 b=suNnJybsE/Jfz9dglhURy603fubYXjznZdYoP0zCNaS6/ujJW5+Drvh6LyrPNYJ0Zt
 CqW1xkgGeJhmZeWa40qYm8A0X8h1+iXAgoJMf9obE1iMwcSrT12nOq7WCINqnfxWu3rM
 QjcnMfHVzINKmyA1UDTuAEbJQgIrdy+SFRXXTwSOo3cnhc4j1G9FKwX3VoybtQgp1Slr
 vzc/vXJL5YjPu8+7tiIL2kci1GAQ6Dd26ORT6t32bzq2PgRRSW/3A1vkXyiNSR0p2ias
 iZP8oy8bCP+Bqgu+mR5Nw5e+quwTXw/McgthxcDrEmOQOitcl5A/VpdLC9CcKeWqL2bT
 JUCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUupbNa3h6Qk38iX70K45LBw9IoMEmGXbaVS2IbdXkRz9+UM3hhcAbwUxEaI5iPbgpsof/MZr8=@lists.denx.de
X-Gm-Message-State: AOJu0YwoqmwNYx/EgNOmmlAzZuGZd4ox3+Vv+hOLKy1BUpSM8Dn8VY0V
 oDqvZL9jPCb5hRi+TmBwOzt5UWcHZFbkpTCq/l34X38/WIwofhRBddI4TIn8ha8s5n0=
X-Gm-Gg: ASbGncunsdLqaTu7llG94D8Vz/7VjQ2XNK/94rIJB+peQ8eiKPRhpO90HW9IF4RMsys
 JLCO89GYx+syqZmKF6xY16WR3sNfoZczV8NvDYYUr0h5lprBmqU8OEC5OgHGn8LNvRVXWkSI0ZT
 4Z64BekNAffgVivcE0VREV4Ce8e8qb3cdhA+RSpNPbyUIvV1UD4vQ227OyDXJVfgoAbXjoGblhf
 BYgjBVCTuONqy8gRagdmGSBgmGAh5sIy9Ou2Hhp7TeP7Ww+4r0/prz2NnpAhdf+QUmSXKNQhSCe
 OxYNTKr1J/z2Q7X/Wa7pRihtzYbdyXvm2D8BahyTvMa/B5eyxBk4qEnkoVmnB4tyrcIKn7gwR/Y
 xE+GP8gwm6wp1m857E6QQhfh+FmiGvfssX+GutyZWfqVbZFn6TYw=
X-Google-Smtp-Source: AGHT+IFzdcRmDGw3n6X4eC/V+4ZO/Q9lNxJtQXGvPSirHiDmewPFPdyMdfmUWj/IzLiukJZLpvq1LQ==
X-Received: by 2002:a05:6000:2dc9:b0:3b7:907d:41c with SMTP id
 ffacd0b85a97d-3b8f41d4285mr6032990f8f.35.1754565605279; 
 Thu, 07 Aug 2025 04:20:05 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:377e:cf4f:d0ff:80bf])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3bf956sm27038612f8f.24.2025.08.07.04.20.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 04:20:04 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Thu, 07 Aug 2025 12:20:01 +0100
Subject: [PATCH 1/2] pinctrl: qcom: sa8775: Limit check for array index not
 correct
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250807-pinctrl_qcom-v1-1-42fac6707fd5@linaro.org>
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

In sa8775p_get_pin_name the limit check for the index into
msm_special_pins_data allows for more elements than exist. Add code to
ensure the array index remains in bounds.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/pinctrl/qcom/pinctrl-sa8775p.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-sa8775p.c b/drivers/pinctrl/qcom/pinctrl-sa8775p.c
index cb2496ff1fb..d4acae15d55 100644
--- a/drivers/pinctrl/qcom/pinctrl-sa8775p.c
+++ b/drivers/pinctrl/qcom/pinctrl-sa8775p.c
@@ -516,7 +516,9 @@ static const char *sa8775p_get_function_name(struct udevice *dev,
 static const char *sa8775p_get_pin_name(struct udevice *dev,
 					unsigned int selector)
 {
-	if (selector >= 149 && selector <= 155)
+	if (selector > 153)
+		strcpy(pin_name, "unknown");
+	else if (selector >= 149)
 		snprintf(pin_name, MAX_PIN_NAME_LEN,
 			 msm_special_pins_data[selector - 149].name);
 	else

-- 
2.39.5

