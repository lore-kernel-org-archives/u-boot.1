Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72EFBC46CD2
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 14:07:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5445987E43;
	Tue, 30 Jan 2024 15:05:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jvITzF7p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5A5087E32; Tue, 30 Jan 2024 15:05:27 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E0BB87DF8
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 15:05:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40faff092a2so1648465e9.2
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 06:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706623520; x=1707228320; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wFp1hHRR/1SlOW6t5sCZNic6sCRFVKX2pLY+ZrtFe1M=;
 b=jvITzF7pECTlnOcEaNRQXSauNg1kUB6VdvYjIceqV1AHyDTgJevzTSL80GeLztSkfH
 vSOJQ2dirpIidH1gXt8absVaYqa4cq0jWPb7ZVjQaLTIyHgOvYP1d8mI1EoW1LZE3fHK
 2w8RTO98bMVliDivzxsxxsdCTqZDWNwflRv4eVaHMDktQHvhIARRdU0tAYaQbAnduu2u
 wKZCZq3Fuos9HF8v8ZS2G2L4WgBj3ZyE7hkUquK4D/4J4zJljhXCdoEgEfmpdF8uhnp9
 li3jgp18JRWWxtt1CiiqIBDLYHFBugj67VbaM3+A/lQPFH00QGbDt7yOFE/4jUd1Zhiq
 jfLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706623520; x=1707228320;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wFp1hHRR/1SlOW6t5sCZNic6sCRFVKX2pLY+ZrtFe1M=;
 b=Tnr2Qc0eFWKKdoKqz54E0W2Uc//kTrgZ6ARz75/pqRAxerreqCf89I7JcauOUHUJjD
 C7UTP/m0RrAR9bwxYxK7iD8nAwPXaBkGw3HFs9JYyV5Wbz9A1yJ807A6UQE2wvGhmfIe
 NXlomuMEchZWjR5cZxf+NuZzszWjs7lzH8EBSCMJWx4FBtTsqb0k2R7UmAeNdH71FFA3
 U9MUllrS/M6zkPmKHFvJw7esfDd0nMBUYUwrk9TTkkeGaD7y3qEIJhzFBniTdsrTPrvb
 Dl3G75LFGxDmpZ6nHEUGtulQmNeuvrXAvId+5b2UiaDA4mEtobDbr3PgCvwlQfzVHTv2
 t6xA==
X-Gm-Message-State: AOJu0YziuS7+6BXj8cszEppzjV5KD7eESfSfzwrBGgjUvFb7y1brQycK
 i7zm5JbpY4im+H0heoHniOJ76xhOaqYI4SyPhcxjmhMrF/3fanRTzydGLC/z8bM=
X-Google-Smtp-Source: AGHT+IEK0alLT7Jwm5EQl2NavEB7u0ofiGAGrsrJCmlBSNCJl6AM1KknvmdstVNt5/Aemv8oVigwDA==
X-Received: by 2002:a05:600c:a384:b0:40f:24e:d480 with SMTP id
 hn4-20020a05600ca38400b0040f024ed480mr1361996wmb.18.1706623520197; 
 Tue, 30 Jan 2024 06:05:20 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 g11-20020a05600c310b00b0040f035bebfcsm1799017wmo.12.2024.01.30.06.05.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 06:05:19 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 30 Jan 2024 14:04:59 +0000
Subject: [PATCH v3 11/36] gpio: qcom_pmic: add a quirk to skip GPIO
 configuration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240130-b4-qcom-common-target-v3-11-e523cbf9e556@linaro.org>
References: <20240130-b4-qcom-common-target-v3-0-e523cbf9e556@linaro.org>
In-Reply-To: <20240130-b4-qcom-common-target-v3-0-e523cbf9e556@linaro.org>
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
 bh=ymwAonFlifJ0H9BsiASyOwN2adBqwArF+W83RQBLkgg=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtSdTAKv6/idDygWTt+qKnGrOu9BPee6z+y/HH7nGB3cX
 TErXreto5SFQZCDQVZMkUX8xDLLprWX7TW2L7gAM4eVCWQIAxenAEyk8hXDf5+ChyX6giX5lyxd
 n52tmf/vbXlverr61PM9LMEr83ZvtmT4nyr9fOrngGyj7frvuQ7PT9t/6e+SH0XrM8PbopJ7+L9
 MdwMA
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
2.43.0

