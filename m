Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1F32C4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 11:44:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 837B788412;
	Mon, 22 Apr 2024 13:44:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="guULuNBe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DD9688379; Mon, 22 Apr 2024 13:44:05 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9748C883A2
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 13:44:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-343d1003106so3586510f8f.1
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 04:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1713786243; x=1714391043; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rd1Q6gJh84Bl9N5fQ0Bn0TP1W4PJtTj7HUVuOEfuqD4=;
 b=guULuNBewllldcAnoNPfD+gxnkeHcQYUctI1U42zKQhI/XCz1tkkzm/3xndMA3i+bK
 pSOaVCublJcif4vw+Nvc96lWoWO7wmNeBE5XhdT2fIzhux6oCDPRlsAntmdRIdu6SHT6
 rOuPeX5K+af/JxlztrJeaNDzahFb0vNykbiAOGlqYXrv0rht82rC4Xhg84GR09uAL2Pg
 WVt2rKlI0GNRhAqhjeWDuT5g69BWVlGp4scq2WFD/2pasxDSUmv6J+RvTROb0VQ9+Yws
 WrAWxiXrrfBPM1yYGXtjqBJXJaAcesNNdLe+jlH9h+Cw07S4OouUtBLEdTxTq3k3m8BB
 0Ciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713786243; x=1714391043;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rd1Q6gJh84Bl9N5fQ0Bn0TP1W4PJtTj7HUVuOEfuqD4=;
 b=iD0yCEpRGO66jgkC2lhNbCRXeMawXtWQ6oyXTp5U675yeIIvEkxDvhNNYr4OYYkH4f
 doA409bAc1vFYW31Y6X9Odqhg9hDqIYQuvD6iv4dJ+LnjOnJdq6VXJ8mmEjMffHzqHAi
 v+qruYk1rAlhmYC4mC626rdonz7mb4NqgYRRsu9DA+os519PWxpeIz//302jh+Y4y8oD
 LqneKUjYo/nHe7DDN4wVQvYGqOrqBUnocoCQwy1v4DRk1kMgB0fMQgScBRHZg9rzHDox
 FGoosbfRw2B4sVkG1wasgDbRx/heUJNDRcZ+/Zq6cb2upWTpPpzrrJRSroh1DyhjkI1u
 zMzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3PmRv4pt+lzqi2YkrlxG5zLJ5u0Jn60tmpvFWmnWcR44srmEPp9SMKENhVUKbxr24R2XYfRGnoSSMKBtkK+ufjeV38w==
X-Gm-Message-State: AOJu0YxUO0jiimOujMs9eRvKaPqlT3iAn+iQ2BTOooEg6P2QibTcHHzG
 vrnUt1MApSCAge7Eh1ZfN2CnOcd68GyhvUe4uEKgUNUty/zqv/8Mq/1J2WK4hdA=
X-Google-Smtp-Source: AGHT+IEr0hfaXQBnPamevj88NTwgCY47NUFrvMAJQbTo3/gweTtRYla9In9mzcCfNnfKkkPDj7+Qww==
X-Received: by 2002:a5d:5985:0:b0:34a:eef8:b162 with SMTP id
 n5-20020a5d5985000000b0034aeef8b162mr4546283wri.5.1713786243175; 
 Mon, 22 Apr 2024 04:44:03 -0700 (PDT)
Received: from fedora.. (dh207-14-170.xnet.hr. [88.207.14.170])
 by smtp.googlemail.com with ESMTPSA id
 e5-20020adfe385000000b003455e5d2569sm12022977wrm.0.2024.04.22.04.44.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Apr 2024 04:44:02 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: trini@konsulko.com, caleb.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@linaro.org, u-boot@lists.denx.de
Cc: j.beck@linefinity.com,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v2 2/5] mach-ipq40xx: import GPIO header from mach-snapgradon
Date: Mon, 22 Apr 2024 13:43:25 +0200
Message-ID: <20240422114359.219762-2-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240422114359.219762-1-robert.marko@sartura.hr>
References: <20240422114359.219762-1-robert.marko@sartura.hr>
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

Pinctrl driver was refactored and moved, but the required header that
it depends on was not included.

Fixes: 24d2908e987a ("pinctrl: qcom: move ipq4019 driver from mach-ipq40xx")
Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 arch/arm/mach-ipq40xx/include/mach/gpio.h | 37 +++++++++++++++++++----
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-ipq40xx/include/mach/gpio.h b/arch/arm/mach-ipq40xx/include/mach/gpio.h
index a45747c0fe..53c6ae0649 100644
--- a/arch/arm/mach-ipq40xx/include/mach/gpio.h
+++ b/arch/arm/mach-ipq40xx/include/mach/gpio.h
@@ -1,10 +1,35 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * Empty gpio.h
+ * Qualcomm common pin control data.
  *
- * This file must stay as arch/arm/include/asm/gpio.h requires it.
- *
- * Copyright (c) 2019 Sartura Ltd.
- *
- * Author: Robert Marko <robert.marko@sartura.hr>
+ * Copyright (C) 2023 Linaro Ltd.
  */
+#ifndef _QCOM_GPIO_H_
+#define _QCOM_GPIO_H_
+
+#include <asm/types.h>
+#include <stdbool.h>
+
+struct msm_pin_data {
+	int pin_count;
+	const unsigned int *pin_offsets;
+	/* Index of first special pin, these are ignored for now */
+	unsigned int special_pins_start;
+};
+
+static inline u32 qcom_pin_offset(const unsigned int *offs, unsigned int selector)
+{
+	u32 out = (selector * 0x1000);
+
+	if (offs)
+		return out + offs[selector];
+
+	return out;
+}
+
+static inline bool qcom_is_special_pin(const struct msm_pin_data *pindata, unsigned int pin)
+{
+	return pindata->special_pins_start && pin >= pindata->special_pins_start;
+}
+
+#endif /* _QCOM_GPIO_H_ */
-- 
2.44.0

