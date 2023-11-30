Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B692C4167B
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 20:23:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 385ED87718;
	Thu, 30 Nov 2023 21:22:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PWkmmt3P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65C4A87709; Thu, 30 Nov 2023 21:22:53 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CA3087675
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 21:22:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40b2ddab817so13055555e9.3
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 12:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701375771; x=1701980571; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gNQvmCLiBayJJsb5GwMY9zHRvD0ru7zzWcRupzkcjp4=;
 b=PWkmmt3PveuHvzcQ9cXkXBRv1MfC3zlZ0JuwwRn49fBhMEOIIm62CgmqWHet9GJTz2
 Px9o9PlpVEgLIGRVkB15/KXBzrw53khTssRLR2l1Euj+Hzxcwoi+4qWeagVc98LlDbPV
 p5D/6XhirT0vslyT4NI0RtN7UT1V2y1H/YW/izE+WIfLg2t756S3oAQmu4K4JZlNEcw0
 PKnlSRbD5Mmr9pLuBJQ+S2D/CK/0d0E/dgLN9qljXn79Czh/9vjWdJdoC6nMQqfDdXLr
 nkhvMIX6Y/tpFv6SoCnfl/sWPdCMn2kw+siDaHCszuGU3eYoqdyOHsWwhv4CddFYg/bh
 P4mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701375771; x=1701980571;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gNQvmCLiBayJJsb5GwMY9zHRvD0ru7zzWcRupzkcjp4=;
 b=M63AGHMMAVwD+w7y2Cjxynyg+/nzL7oFgJjsi9M/0LvV/dFYbnBn0FSRShigSmLOHm
 3q7jMRLT1QFcFS27p/KXNSPc6W+piIajhCF6JVFMU+SL2UoFvDcfUaBpW0k1pLs6qEWv
 Pf1yoL+wCRMzPqs8g6XyjtDn0Rjxip8T9OA2zGaPtWjQmJUGhXjiJjjDO1FKUX6mn3qY
 PLY2gx4bqllT163edO5yCGDpOD6GXtD2A47g//aJuIi8uGpt59qwSypHeoMHKApb49bP
 vaCs8NISuxSzQfexg/8eK0Rcomtk8xET+L0EuZDM/QWKjlCJwUF2i54yfhPGqwiTXCXu
 PtAw==
X-Gm-Message-State: AOJu0YzbTCXO3hzlw2NUFtqbT3nsARTE2SQaKkPoBIE+3k4WM1Tfq6bz
 TJEmBwn/km1o2mf42hnJedTzJA==
X-Google-Smtp-Source: AGHT+IFqA4QSWGpnxf9okGua/YCZqRgEgikrhMKw5iXoUbmKV8Tfj3hY73Xj1r6bJNKNa6C6idD/Mw==
X-Received: by 2002:a05:600c:16d4:b0:40b:5e59:daa5 with SMTP id
 l20-20020a05600c16d400b0040b5e59daa5mr40933wmn.184.1701375771011; 
 Thu, 30 Nov 2023 12:22:51 -0800 (PST)
Received: from lion.localdomain ([79.79.179.141])
 by smtp.gmail.com with ESMTPSA id
 fa23-20020a05600c519700b003fee6e170f9sm3028900wmb.45.2023.11.30.12.22.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Nov 2023 12:22:50 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 30 Nov 2023 20:22:28 +0000
Subject: [PATCH v5 4/9] gpio: qcom_pmic: drop pon GPIO driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231130-b4-qcom-dt-compat-v5-4-41500e237ad0@linaro.org>
References: <20231130-b4-qcom-dt-compat-v5-0-41500e237ad0@linaro.org>
In-Reply-To: <20231130-b4-qcom-dt-compat-v5-0-41500e237ad0@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4105;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=zSKOl9ga1DLlbd+RdN4jSUxH38m8oKW4T7JK6ets4DM=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtSM92Lvy2W5N1Z2Fni3bP1gL/Rg2ZRUp8/fLdOiLrC8u
 q827Wx1RykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZiIWCIjw97s+uafx04vmnPo
 9Q7f+Z+4JzQEzEordnkdXvrZqePflHJGhk1zeNa0Hz/w+uOBD+kaJf6Pt7Q5Vn3xYwwpT00OM4g
 +9QQA
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

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/gpio/Kconfig          |   3 +-
 drivers/gpio/qcom_pmic_gpio.c | 104 ------------------------------------------
 2 files changed, 2 insertions(+), 105 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index ba42b0768e12..fbf77673c5e0 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -309,12 +309,13 @@ config CMD_PCA953X
 config QCOM_PMIC_GPIO
 	bool "Qualcomm generic PMIC GPIO/keypad driver"
 	depends on DM_GPIO && PMIC_QCOM
+	select BUTTON
 	help
 	  Support for GPIO pins and power/reset buttons found on
 	  Qualcomm SoCs PMIC.
 	  Default name for GPIO bank is "pm8916".
 	  Power and reset buttons are placed in "pwkey_qcom" bank and
-          have gpio numbers 0 and 1 respectively.
+	  have gpio numbers 0 and 1 respectively.
 
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

