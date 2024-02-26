Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D81EBC5478C
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 17:28:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E403E87FB4;
	Mon, 26 Feb 2024 18:26:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iLlsiGDE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5905387FA9; Mon, 26 Feb 2024 18:26:39 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2B9287F6A
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 18:26:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-33d118a181fso2257070f8f.1
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 09:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708968391; x=1709573191; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=K8GensPlvh1O1pGB+6orMTcQX8FeUDhHw5hMSEk+bOY=;
 b=iLlsiGDEGi5BAQC8tRKWeO2qsqCY0ZLSC+3LhU3iWfdW21FQLZAceCY4nDkWJ9eo3P
 O+xrUgkj5ub+vy5WC17086OMwSoRArFFiJd4PZ+8TYG0bDqF3CaJEkaMSuPFBZHNeNg4
 XfywtwuMUq0Nvvp2VX4NprdDfPQlXzfdd48B2t8KF2SJtnlFxXaquTNdo4bgqOKs67JH
 sGCc5fHJDyT/5APtvHT7tC3oMQlGzeu7/gPk++z1LaLCZ12DecXZvJU9wJkQ6T7orgmk
 do0As9JnLRoa7UUId46HAOxtnbhW/citq50XP6EUGCaPrVtb4pET5RPLVtcPyS+2fJBA
 gU+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708968391; x=1709573191;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K8GensPlvh1O1pGB+6orMTcQX8FeUDhHw5hMSEk+bOY=;
 b=RAUZeNSUnD5Z2tVc8AyNHiQyFLD+Qqh6uH0/tNvogAR09CWqqaquF0wkob4R9nugx7
 7btIkrMxrNUrIuu8ra9WsBd/2HaPfS5P/2qnyExM2QhYd237++g3NXDJTWVWqP8WLmro
 EFYM8J3SSJvO/vmV30SAzaEA1mLoR5KX167uNmjpltupTWpwiKtnOmn4YHy0B0X91u67
 NiYesCWEzLS6hjtTUn62AcEsR+33+BvwGao4XiGt9qtuQ+qKP6liQJkZBaYzO+i5Pbhx
 OuhWKgtSe8wNxjCIHxlgM/1/Okus96/dFHSJ8QbULD8vUH75qvFmUEXOKn/5Mlh2+5DU
 WBfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX97dPJSRG4bstFo3SZOubTnUMH8aF29e6gFbBdbrjby99VhfrB2CwmnAL0aI2mVc4lV5HQ4EaANspmRYcsjl47LtizlQ==
X-Gm-Message-State: AOJu0YwcFXJRh3xNkqUJW0RwvAjKxEr0VsidvzRD2q5aH8EgY4SRGJ8J
 KjpUgSG1D6Rc+znXTm395b7VuUxPGRLyZeVShVH5aO0zzjPJ36pf6E7+en2xGqA=
X-Google-Smtp-Source: AGHT+IFUcUjkFtyVWiUwMhFoSUtSNQUKidgQr8KKoR9OoRzpWMlSPL+PuxL9IEmDDHY2N/yL0OJs0Q==
X-Received: by 2002:a5d:468a:0:b0:33d:50cd:4672 with SMTP id
 u10-20020a5d468a000000b0033d50cd4672mr4504905wrq.21.1708968391441; 
 Mon, 26 Feb 2024 09:26:31 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 bt1-20020a056000080100b0033d9c7eb63csm9142256wrb.84.2024.02.26.09.26.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 09:26:31 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 26 Feb 2024 17:26:14 +0000
Subject: [PATCH v5 10/39] gpio: qcom_pmic: add a quirk to skip GPIO
 configuration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-b4-qcom-common-target-v5-10-10c8e078befb@linaro.org>
References: <20240226-b4-qcom-common-target-v5-0-10c8e078befb@linaro.org>
In-Reply-To: <20240226-b4-qcom-common-target-v5-0-10c8e078befb@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2464;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=WFOE1aBqYJfs0haUszbjoPUuUGsyz6AsID+c/IrzLM0=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtQ7J3eaLTp+xaNHXKVPjfPUDrZdvb9jWU1uSdXVPVtyr
 uPdoZrkjlIWBkEOBlkxRRbxE8ssm9ZettfYvuACzBxWJpAhDFycAjCRczEM/53v7H+UMGWiDqem
 /HfhhI46oU3RLA1afj7tN+rtDLSjlzH80w8+6uf8+lTmcsegHt+dOy9rzxVaWXXg3jLL7qnz/Q+
 GzQIA
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

This is not expected behaviour but appears to be due to a U-Boot
specific bug. This quirk at least allows for the volume buttons to be
used on platforms where this bug is apparent.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/gpio/qcom_pmic_gpio.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/qcom_pmic_gpio.c b/drivers/gpio/qcom_pmic_gpio.c
index 2a4fef8d28cb..63b512725ad9 100644
--- a/drivers/gpio/qcom_pmic_gpio.c
+++ b/drivers/gpio/qcom_pmic_gpio.c
@@ -63,8 +63,19 @@
 
 #define REG_EN_CTL             0x46
 #define REG_EN_CTL_ENABLE      (1 << 7)
 
+/**
+ * pmic_gpio_match_data - platform specific configuration
+ *
+ * @PMIC_MATCH_READONLY: treat all GPIOs as readonly, don't attempt to configure them.
+ * This is a workaround for an unknown bug on some platforms where trying to write the
+ * GPIO configuration registers causes the board to hang.
+ */
+enum pmic_gpio_quirks {
+	QCOM_PMIC_QUIRK_READONLY = (1 << 0),
+};
+
 struct qcom_gpio_bank {
 	uint32_t pid; /* Peripheral ID on SPMI bus */
 	bool     lv_mv_type; /* If subtype is GPIO_LV(0x10) or GPIO_MV(0x11) */
 };
@@ -74,9 +85,14 @@ static int qcom_gpio_set_direction(struct udevice *dev, unsigned offset,
 {
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
 			      REG_EN_CTL_ENABLE, 0);
@@ -303,9 +319,9 @@ static int qcom_gpio_of_to_plat(struct udevice *dev)
 
 static const struct udevice_id qcom_gpio_ids[] = {
 	{ .compatible = "qcom,pm8916-gpio" },
 	{ .compatible = "qcom,pm8994-gpio" },	/* 22 GPIO's */
-	{ .compatible = "qcom,pm8998-gpio" },
+	{ .compatible = "qcom,pm8998-gpio", .data = QCOM_PMIC_QUIRK_READONLY },
 	{ .compatible = "qcom,pms405-gpio" },
 	{ }
 };
 

-- 
2.43.1

