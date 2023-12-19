Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 093ADC41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 16:06:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98DC4877D8;
	Tue, 19 Dec 2023 17:04:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RVfH4mWm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0096E876DA; Tue, 19 Dec 2023 17:04:40 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22AAE877A9
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 17:04:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40c6e2a47f6so48908205e9.0
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 08:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703001871; x=1703606671; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/XL39AP2M4vV2tYz5P7n+Qfnm8VTDdl4a+oBun6X6mY=;
 b=RVfH4mWmNTslY6lpq4t/81Fy3+QgiFHY8IDR3R+F3nDlA4taXl7oNuoRGfIwCcoGTb
 XKi4OqLhX6e48TGXT13Lmj3H1d+xppzV10GnZkMw0HlqDShhsVEpBW9MSsBPTwul2FBT
 Ybg+MzPPwsOMCAsK0J7RryTISEiUjZVt4HaRsdhfxZqm4zP/Id4IvLWPIvSnUnjULwGC
 DAd5ygGAj69oeeJOI3YNQy2b3MHAtvsmDDSQ6Gd0tC+2qI5+5prEoMRXLMWMlXG7lIEi
 bIIpCT1wNWXtdqkrHzGZ+EC5d+vOI0F5vTXyQhRCA2QVsgYQWm7+h23eWH3vJhoPpd58
 rxZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703001871; x=1703606671;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/XL39AP2M4vV2tYz5P7n+Qfnm8VTDdl4a+oBun6X6mY=;
 b=kEPqEXAtVTEYTBgLjrY8tiBE8k+YrpDz2RPOJ1hBL94YH3d9h4m9xrsJGlMIR3zS8+
 SSqbAKe4kKsWK4nN25Y0qNDdRqpXS7F7Uc5cUre03C0gKMwx3uG6NncRHq1czO7WkijD
 7vYWh7j/mRwQPb3DNj4GCF1DPPm9GAXd7KbbeHLnOUziigFaf5HGpWwv+jZUk9FLarwS
 s3iHgFuKFJPX/Tck5vIuUSrlrEH5D3I/gd2RM9bbtZz4EEfkxY7h9Wh78+xdGqwMMGFP
 xUeIUVeGndrG1xZnSabNsp6Im/anoEevZaqXxBeuYnqGALR+8TGj0qhKEAhMrlsMQIVT
 ++Hg==
X-Gm-Message-State: AOJu0YwbofWkgM9SGYTWIOJNrE92M6VL6pOhoiIcn2AJv0tCjX5Ibt3O
 GXpbE/a/+k2nBgBv+jtcZgHNhQ==
X-Google-Smtp-Source: AGHT+IHy/rX7l3Z9Bxgak1JtSExxm/dlu9AN76mevMG4Y0vCLq+mOs+aI0+G5D0gbK5m0wBhZtAIsA==
X-Received: by 2002:a7b:c388:0:b0:40c:fc0:cff7 with SMTP id
 s8-20020a7bc388000000b0040c0fc0cff7mr4494201wmj.82.1703001871585; 
 Tue, 19 Dec 2023 08:04:31 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-230.as13285.net. [92.17.96.230])
 by smtp.gmail.com with ESMTPSA id
 je17-20020a05600c1f9100b0040d1450ca7esm3429723wmb.7.2023.12.19.08.04.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 08:04:31 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 19 Dec 2023 16:04:10 +0000
Subject: [PATCH v2 09/32] gpio: qcom_pmic: add a quirk to skip GPIO
 configuration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231219-b4-qcom-common-target-v2-9-b6dd9704219e@linaro.org>
References: <20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org>
In-Reply-To: <20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=2074;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=v9DH+F39Hgb1gjA0X0f+J6A1VLoDuYhN2VKeuQYCUC4=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtTG/Uwfsr5/KeT9+zxEROLCQ3vpTh+raXf0eHftTN5ds
 W9fV8q+jlIWBkEOBlkxRRbxE8ssm9ZettfYvuACzBxWJpAhDFycAjCRhCkM/+uc+L9YVjioTLya
 FhG/tyOE60mJTl38ctYW5rR5aytLlzIydGlNqNlRZWQ2MfaYSMJ5eZbS2aEH3Y6phlyecufJsoT
 YewA=
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

Some platforms hard reset when attempting to configure PMIC GPIOs. Add
support for quirks specified in match data with a single quirk to skip
this configuration. We rely on the GPIO already be configured correctly,
which is always the case for volume up (the only current user of these
GPIOs).

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/gpio/qcom_pmic_gpio.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/qcom_pmic_gpio.c b/drivers/gpio/qcom_pmic_gpio.c
index 2a4fef8d28cb..198cd84bc31e 100644
--- a/drivers/gpio/qcom_pmic_gpio.c
+++ b/drivers/gpio/qcom_pmic_gpio.c
@@ -64,6 +64,15 @@
 #define REG_EN_CTL             0x46
 #define REG_EN_CTL_ENABLE      (1 << 7)
 
+/**
+ * pmic_gpio_match_data - platform specific configuration
+ *
+ * @PMIC_MATCH_READONLY: treat all GPIOs as readonly, don't attempt to configure them
+ */
+enum pmic_gpio_quirks {
+	QCOM_PMIC_QUIRK_READONLY = (1 << 0),
+};
+
 struct qcom_gpio_bank {
 	uint32_t pid; /* Peripheral ID on SPMI bus */
 	bool     lv_mv_type; /* If subtype is GPIO_LV(0x10) or GPIO_MV(0x11) */
@@ -75,7 +84,12 @@ static int qcom_gpio_set_direction(struct udevice *dev, unsigned offset,
 	struct qcom_gpio_bank *priv = dev_get_priv(dev);
 	uint32_t gpio_base = priv->pid + REG_OFFSET(offset);
 	uint32_t reg_ctl_val;
-	int ret;
+	ulong quirks = dev_get_driver_data(dev);
+	int ret = 0;
+
+	/* Some PMICs don't like their GPIOs being configured */
+	if (quirks & QCOM_PMIC_QUIRK_READONLY)
+		return 0;
 
 	/* Disable the GPIO */
 	ret = pmic_clrsetbits(dev->parent, gpio_base + REG_EN_CTL,
@@ -304,7 +318,7 @@ static int qcom_gpio_of_to_plat(struct udevice *dev)
 static const struct udevice_id qcom_gpio_ids[] = {
 	{ .compatible = "qcom,pm8916-gpio" },
 	{ .compatible = "qcom,pm8994-gpio" },	/* 22 GPIO's */
-	{ .compatible = "qcom,pm8998-gpio" },
+	{ .compatible = "qcom,pm8998-gpio", .data = QCOM_PMIC_QUIRK_READONLY },
 	{ .compatible = "qcom,pms405-gpio" },
 	{ }
 };

-- 
2.42.1

