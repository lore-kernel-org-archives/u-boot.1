Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52BA1C36014
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 07:45:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7922181F28;
	Tue,  1 Apr 2025 09:45:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Oa+4GuCM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4969281F7E; Tue,  1 Apr 2025 09:45:28 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2595D81F28
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 09:45:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43cf034d4abso57673855e9.3
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 00:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743493523; x=1744098323; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ec1XQppwNIBrqjNQ3+jcBRMvjcVkSGM39Fb6VVuz3hI=;
 b=Oa+4GuCMo9lNAG2AOO6v76STihvanTR/CC+4VcUghTPItIAuRHSV5Zd0f6pwbpmOhB
 CudciBrj9jkW30/tyKnlznaUweeG49murnObC8jgWsxrXIuoQ6RL+QQCYXUyficFHL6v
 eM8ew/9mYedVmEolMGwvEiqc/w8cjbn0RDcCH7ukcFppQFYM7zGvzn5A4IU6cUbaoW1/
 ffv1lnFRemlJHsn8+lJGxU8w8so7ztsz5vtzUdDtlrtGR6pKMXBiuTfafPIqbUiNdyFX
 bnVvdP316xNCmRrPP0tz5C+RmUk29uTFN3KegiAT02bdis0VY5nlDQHO7jcLzg4C5TUz
 NGew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743493523; x=1744098323;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ec1XQppwNIBrqjNQ3+jcBRMvjcVkSGM39Fb6VVuz3hI=;
 b=YKUJ/SKJ7I7lQ4g6AtVvGRXc/22clCXFCyGGBpcrRpjrJo9the/dVv0sGrjuaZtbY6
 O7RfU80q729Mf7iEWb2nxoUOxIjFiOw/Fc8zxp694yAF/M0JpKrWgsoYuQJqKbQrF1QK
 NKUFzx05gnrhW6Ov3mfH/tGmKyr5nzQAHZPzaBT3AGFs0dyfs2W6fgxxK36T0QSz3Wza
 4M6uy14IOkqVSJf7bbVo3hLMJA07cxI/EAetsLByfqmISZe4a5GV2xSI5iC8QJpdKp6M
 Bv94gGLJydzhrP4/tyjwaoT9OcarBkfCBfR4s6of2N0qZg5J6XU6m1HNrZrcxRPDYk5n
 Jhaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBEVNSMJsdNVdJ+wfDkFt1+6ucryLmHfyUOTKEAcDWz0/H78tHh10qpbNu0holS1DG8JobQOE=@lists.denx.de
X-Gm-Message-State: AOJu0YyMc59Au8H6s5FOkQblJVVA+GVBMd9GCme7nsWBGBqEZzss4cWC
 qNDDt5pvRQ+Yzs43IqnuIO+PupWXxekF3EcAWPteBgIj5RKH+KcPLc60y5ewttw=
X-Gm-Gg: ASbGncvUouHrwoxX/QMiy+BJ8h1IWMGJF9LTaQC6l1yk+vA+6ps6sV5WTmHdDLENAfW
 R8GvMjJedxiZuPV3MUvNy258MWHz3FS4KsqhbLooaRb2pWdVen4ArzzkaEeKddZGJUAuCQB+rYF
 78JNMe65lCsBwSbugCmWPN/zZBlTv+iMshMWP3fEnfuKKtOTBHN6YlGY0I87G6l/9lD0RvVXBzd
 6164pKD+lId3HrYVXrM79hgeXm+P7SwmhzPxNpjSWkgGNUiKl+cviatE1Mghc2KoAlIIaPbb8rc
 M+oX+7wI2LBi9TWFhZ6dTTa9Z6U1fWjzIl2QmrJuwwg084OdsvbXCbZp3cn4W+Fd6MO6BKSnEV8
 X
X-Google-Smtp-Source: AGHT+IGHcZ95JHSWLXmqVUlXOvvxcoCTsacdP5qknjFIrV3AcVT4joxTXRCW/3kgrBQJijvSIiMMUw==
X-Received: by 2002:a05:600c:a05:b0:439:9e13:2dd7 with SMTP id
 5b1f17b1804b1-43ea77369d5mr15483725e9.2.1743493523647; 
 Tue, 01 Apr 2025 00:45:23 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d8ff02f9csm148715295e9.26.2025.04.01.00.45.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 00:45:23 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 01 Apr 2025 09:45:20 +0200
Subject: [PATCH 2/2] gpio: msm: return correct value return for special
 output pins
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250401-topic-sm8x50-msm-gpio-special-fixes-v1-2-a1148a02bb16@linaro.org>
References: <20250401-topic-sm8x50-msm-gpio-special-fixes-v1-0-a1148a02bb16@linaro.org>
In-Reply-To: <20250401-topic-sm8x50-msm-gpio-special-fixes-v1-0-a1148a02bb16@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1302;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=hoLA7ZKCAOAW0iiHzQaX1JDz3A8RRPfy/MSRs50n4dc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBn65mQIZ3j99JrsMfIVJ2B4nQbEqGPF9EgfqOf/3zu
 oe1EzHKJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ+uZkAAKCRB33NvayMhJ0S/3EA
 CKs/fdgfl/jQcn4T6/16hLhU+/4e2gD3liqwpPegdw59iL/5rhXZb6q+i849NAQq6A9jsemGG+3Owy
 shYbR92ZCp6ewm3fM6nTPFoINnyRao8iSD4SrB4ORSlOST1vpV3DAGvaCqdAYqFbMa9UAeSbWh3LMU
 XJ8WqZKf+3BhfyNW8BdqSy8u97Ow56Qatc+uI16p4MtSagBVstgQETDfuIMhMWp3pBQXt+jTxWrJMw
 jamcy3imnriOUBBYCLNUTJLHZTvGZbDz3rp9tzz+7G0IdJsEvSdGD+58Ka8G38xcRzxzuN3gFDNs4C
 sCmqPDbBzI11s2/TLMzwLfL/7H/wy7vY8ScyHn18/e0Fbil2K5gBSeWihPMOUQyBl4fB9K5dfvbKBN
 t6WMbEcrtL6jcawEj0bCynSQ2c1/FnNQL0MS4dM/O6BcMU0Odd5sX0DNXrPguSX9t8sUDPV82uSToJ
 h1jYYa8lbd4VVRhppSln1hqjjHZO8JPd/31s7DQUQiZXSga/uqKts9/hxbnYHBjE1UXShu6TsMXx1k
 H+OLzWWp8pR0obSKBRL2Fz93h8MkOUjyEtshlL/oVtOU2hjIwdE1t+EE4FNGDBQwwXOrJORrVpoUZI
 9Y+Pa0xCiazAeSDDWp7YQ9bUKbcGPZGWU376oZaZP5RCD69dBibIonrxYgkA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

When a special pin is output only, the current code would return 0,
but if the pin is output only we can get the output value.

Try to return the output value and in all the other cases return
an error instead of 0.

Fixes: f9bb539460d ("gpio: msm: add support for special pins")
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/gpio/msm_gpio.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/msm_gpio.c b/drivers/gpio/msm_gpio.c
index f208eec7e56170a9a79f8f021ceec85b7da0ed81..54afd44fbd3c53ccbe2c6c46ac1c9cf7bb0f7107 100644
--- a/drivers/gpio/msm_gpio.c
+++ b/drivers/gpio/msm_gpio.c
@@ -172,12 +172,19 @@ static int msm_gpio_get_value_special(struct msm_gpio_bank *priv, unsigned int g
 	const struct msm_special_pin_data *data;
 
 	if (!priv->pin_data->special_pins_data)
-		return 0;
+		return -EINVAL;
 
 	data = &priv->pin_data->special_pins_data[offset];
 
-	if (!data->io_reg || data->in_bit >= 31)
-		return 0;
+	if (!data->io_reg)
+		return -EINVAL;
+
+	if (data->in_bit >= 31) {
+		if (data->out_bit >= 31)
+			return -EINVAL;
+
+		return !!(readl(priv->base + data->io_reg) >> data->out_bit);
+	}
 
 	return !!(readl(priv->base + data->io_reg) >> data->in_bit);
 }

-- 
2.34.1

