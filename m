Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A30EC4167B
	for <u-boot@archiver.kernel.org>; Tue,  5 Dec 2023 13:47:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 079668784C;
	Tue,  5 Dec 2023 14:47:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="e5Vx3mpd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12CB0878A9; Tue,  5 Dec 2023 14:47:05 +0100 (CET)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1047C87447
 for <u-boot@lists.denx.de>; Tue,  5 Dec 2023 14:47:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2c9f559b82cso33670711fa.0
 for <u-boot@lists.denx.de>; Tue, 05 Dec 2023 05:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701784022; x=1702388822; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BUOXJJrwuYx59XcbNPsr8AkqI4r/WwnLiXmnZJz33t8=;
 b=e5Vx3mpdBbLxs+4lO42fO3OkaZSZ9wIG4dVm1chYAP1hkA3P08S7yIDFQ8+GgrmxUf
 Vc+ewkBMxEAx79Kau76ai0HR79xCnRgVMzIMvGZIWm/QrKGsVKKPFOFsLicdAOuk3qdx
 7oiLarg1JGCrxgY0TXTBlZkxUHxNc3/mt4rBpq4PN0++hCI0cNEuR6ICJnFC7YRU1ByY
 jLcAKuPmfRRTDjp4pL/NDouLSaxkF5bj+JZTQVqFFk7FfTK9dzkQF8qB+FtRNj8XRHeE
 eUhw8RioK/VSJA6iMxgn986EMFRhAbpf8wW/vCv3IKUgPRoirej+Lt5PGZNrqH0T/eRD
 +NpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701784022; x=1702388822;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BUOXJJrwuYx59XcbNPsr8AkqI4r/WwnLiXmnZJz33t8=;
 b=hr1drUVriOuTHGDEefsG7DF6uJCqhnS/irkE4+DGygV/nZEiwGwRqSjfPtKZ4WIjpf
 b8WemXnnsIeieA8Zl4f6MfJYcYZRJB8Sn44vrI0G0wiGJ1sIPv9lHywBUlJsAzA8D4/R
 WVXJ2oqupqTrYbUkDiaLibGFmCHeaLfIKR09PbZEzbswOhnYIWAVcdHmFKD2Seg6nrDk
 WBd0qt+TI9TI5cL5aB/o0VHQyKPu/uSSSO3p7kTiEbrO4Ri7o7iuUcIMAbt01+jVeHMU
 8kDDTFWofV2iLW0hTapSXfvcBjqakGXJei1xhuqNRRA+pZCX8a5JCTa/ZyVP50t0VRZ1
 8MwQ==
X-Gm-Message-State: AOJu0YzMYowjb/9LOsGdGI+WbcFcX8BwOGtKGRJ7Vo8jvyNH1eK78aby
 perQxnEYVGi++qZhcuonfn1bRQ==
X-Google-Smtp-Source: AGHT+IFn9a9Vh9JhjS4+qbrNDYUsII2BfTN0BY3hfy+07OvX+Y8EKmjlF2aT7hXq8EI9+k2c+69vWA==
X-Received: by 2002:a2e:81c8:0:b0:2c9:b88c:b492 with SMTP id
 s8-20020a2e81c8000000b002c9b88cb492mr3338729ljg.23.1701784022026; 
 Tue, 05 Dec 2023 05:47:02 -0800 (PST)
Received: from lion.localdomain ([79.79.179.141])
 by smtp.gmail.com with ESMTPSA id
 d10-20020a2e928a000000b002ca0e0c837asm369688ljh.100.2023.12.05.05.47.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Dec 2023 05:47:01 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 05 Dec 2023 13:46:49 +0000
Subject: [PATCH v6 4/9] gpio: qcom_pmic: drop pon GPIO driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231205-b4-qcom-dt-compat-v6-4-61d104a8f920@linaro.org>
References: <20231205-b4-qcom-dt-compat-v6-0-61d104a8f920@linaro.org>
In-Reply-To: <20231205-b4-qcom-dt-compat-v6-0-61d104a8f920@linaro.org>
To: Ramon Fried <rfried.dev@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, 
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>, 
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=4249;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=Ra58TtEdxTT9kmMZDxiOnSwxFfu6ulamxF4t4PULT6I=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtR8zXO7rmxZvDb/2Bm2ffunHGoKuH5WtIfh54Tw2kMVy
 +bs0Z94uqOUhUGQg0FWTJFF/MQyy6a1l+01ti+4ADOHlQlkCAMXpwBMRPQyI8O2n1eKP/Y7iW/O
 KKm48n73nvLD7In1HgfqYv/NXnjHStmb4X8N9y7FtJnCe72ut3KYMqb9XyF771H/lAM3H8W+716
 0d/dZAA==
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

Remove the (now unused) GPIO driver for the power and resin buttons on
the PMIC.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Tested-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/gpio/Kconfig          |   5 +-
 drivers/gpio/qcom_pmic_gpio.c | 104 ------------------------------------------
 2 files changed, 2 insertions(+), 107 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index ba42b0768e12..e00b2f2fcfe3 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -309,12 +309,11 @@ config CMD_PCA953X
 config QCOM_PMIC_GPIO
 	bool "Qualcomm generic PMIC GPIO/keypad driver"
 	depends on DM_GPIO && PMIC_QCOM
+	select BUTTON
 	help
 	  Support for GPIO pins and power/reset buttons found on
 	  Qualcomm SoCs PMIC.
-	  Default name for GPIO bank is "pm8916".
-	  Power and reset buttons are placed in "pwkey_qcom" bank and
-          have gpio numbers 0 and 1 respectively.
+	  The GPIO bank is called "pmic"
 
 config PCF8575_GPIO
 	bool "PCF8575 I2C GPIO Expander driver"
diff --git a/drivers/gpio/qcom_pmic_gpio.c b/drivers/gpio/qcom_pmic_gpio.c
index e5841f502953..7b83c67fa464 100644
--- a/drivers/gpio/qcom_pmic_gpio.c
+++ b/drivers/gpio/qcom_pmic_gpio.c
@@ -275,107 +275,3 @@ U_BOOT_DRIVER(qcom_pmic_gpio) = {
 	.priv_auto	= sizeof(struct qcom_gpio_bank),
 };
 
-
-/* Add pmic buttons as GPIO as well - there is no generic way for now */
-#define PON_INT_RT_STS                        0x10
-#define KPDPWR_ON_INT_BIT                     0
-#define RESIN_ON_INT_BIT                      1
-
-static int qcom_pwrkey_get_function(struct udevice *dev, unsigned offset)
-{
-	return GPIOF_INPUT;
-}
-
-static int qcom_pwrkey_get_value(struct udevice *dev, unsigned offset)
-{
-	struct qcom_gpio_bank *priv = dev_get_priv(dev);
-
-	int reg = pmic_reg_read(dev->parent, priv->pid + PON_INT_RT_STS);
-
-	if (reg < 0)
-		return 0;
-
-	switch (offset) {
-	case 0: /* Power button */
-		return (reg & BIT(KPDPWR_ON_INT_BIT)) != 0;
-		break;
-	case 1: /* Reset button */
-	default:
-		return (reg & BIT(RESIN_ON_INT_BIT)) != 0;
-		break;
-	}
-}
-
-/*
- * Since pmic buttons modelled as GPIO, we need empty direction functions
- * to trick u-boot button driver
- */
-static int qcom_pwrkey_direction_input(struct udevice *dev, unsigned int offset)
-{
-	return 0;
-}
-
-static int qcom_pwrkey_direction_output(struct udevice *dev, unsigned int offset, int value)
-{
-	return -EOPNOTSUPP;
-}
-
-static const struct dm_gpio_ops qcom_pwrkey_ops = {
-	.get_value		= qcom_pwrkey_get_value,
-	.get_function		= qcom_pwrkey_get_function,
-	.direction_input	= qcom_pwrkey_direction_input,
-	.direction_output	= qcom_pwrkey_direction_output,
-};
-
-static int qcom_pwrkey_probe(struct udevice *dev)
-{
-	struct qcom_gpio_bank *priv = dev_get_priv(dev);
-	int reg;
-	u64 pid;
-
-	pid = dev_read_addr(dev);
-	if (pid == FDT_ADDR_T_NONE)
-		return log_msg_ret("bad address", -EINVAL);
-
-	priv->pid = pid;
-
-	/* Do a sanity check */
-	reg = pmic_reg_read(dev->parent, priv->pid + REG_TYPE);
-	if (reg != 0x1)
-		return log_msg_ret("bad type", -ENXIO);
-
-	reg = pmic_reg_read(dev->parent, priv->pid + REG_SUBTYPE);
-	if ((reg & 0x5) == 0)
-		return log_msg_ret("bad subtype", -ENXIO);
-
-	return 0;
-}
-
-static int qcom_pwrkey_of_to_plat(struct udevice *dev)
-{
-	struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
-
-	uc_priv->gpio_count = 2;
-	uc_priv->bank_name = dev_read_string(dev, "gpio-bank-name");
-	if (uc_priv->bank_name == NULL)
-		uc_priv->bank_name = "pwkey_qcom";
-
-	return 0;
-}
-
-static const struct udevice_id qcom_pwrkey_ids[] = {
-	{ .compatible = "qcom,pm8916-pwrkey" },
-	{ .compatible = "qcom,pm8994-pwrkey" },
-	{ .compatible = "qcom,pm8998-pwrkey" },
-	{ }
-};
-
-U_BOOT_DRIVER(pwrkey_qcom) = {
-	.name	= "pwrkey_qcom",
-	.id	= UCLASS_GPIO,
-	.of_match = qcom_pwrkey_ids,
-	.of_to_plat = qcom_pwrkey_of_to_plat,
-	.probe	= qcom_pwrkey_probe,
-	.ops	= &qcom_pwrkey_ops,
-	.priv_auto	= sizeof(struct qcom_gpio_bank),
-};

-- 
2.42.1

