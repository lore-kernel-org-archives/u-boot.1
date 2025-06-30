Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94E87C83029
	for <u-boot@archiver.kernel.org>; Mon, 30 Jun 2025 16:05:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1313882E40;
	Mon, 30 Jun 2025 18:05:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UfYGjibH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E36982ADA; Mon, 30 Jun 2025 18:05:03 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F01182E40
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 18:04:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a4f379662cso1929478f8f.0
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 09:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751299492; x=1751904292; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=z5G4sIRxTG4U1QGiE9u+jy31Ioc4yLM7VXGZrFMXlww=;
 b=UfYGjibHFBXdnRYCY+O/HWEuabSiFo/WAGJIkYWNQ5ebrN18Rlzp9cUEQfoN7XtFc7
 M6Bz4/CoNIRBVkaFuSbkMDqa1Rv6yoHF8PIw7UvIcqczCaUbuC+CWps2nAxZMnv2LnWK
 PheSv0D8vAQ5vv9SYSWNf5ecR8sCrEgdou4TzXVvDp05qEyphFMBiibUKoEYzpTLJJfi
 547EnCFdFNMXymfh9ryaREcAf7LL3wLweKsoZiBf8RdJt1vPV3Ti/ZRWjjt6ysJefj6p
 VV/Y6HwRurgZLFt+xrC1kRnQSLKdRexNuaUxyEylqoVNobB2luUV/9HS5fbQY60X7PMr
 o5qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751299492; x=1751904292;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z5G4sIRxTG4U1QGiE9u+jy31Ioc4yLM7VXGZrFMXlww=;
 b=vzSeqGiiHGao5J4SabxGJREARyl1NjWBeT30rWoayb9BtGpvxRu53fIJTyplzHH0OV
 vfWxN9UB2QTEb71uZ1Js0YIwIoqfii/1hDbIwfq2nX2QG/Kx5iWsdaBz1qSXTiMwxTXs
 a8U13f0xPeyQORJKJwGbI4YXH4k5iZSlysKYpTmxj/8uGhWcsP1ta5Q7OI7SHEyMfuDH
 k2XmDWcu1XReo5GilLqiADOHiKvbZq5NZD5FFuObmHsftjmaq0n7D6+yZWJezhtnuX8a
 7XqAKy16Kq7Av2Ufh88PfoAJlHIbWzML7isAE4y9umgq/b8N0j4aRa2UNWJ+TWkwZawq
 wZmQ==
X-Gm-Message-State: AOJu0Yza4M8VnbOgPwiDMkDGnK0HFRO871xOVCHYBawhYwZiXG4fPmVs
 nOwcsPN+Inl54FTHPIoV1al7iTdi4GNWxKCZcH0m94y2tVKMwFFBmDzMRTHTVv1xj8Y=
X-Gm-Gg: ASbGncuxqZpN94oqUwsVXo5bmwDryp7J59YL707sTpkLhBFM6l7YHR5VsKqb7FsAmTD
 PDrDUBGajWIpO7n3z24DWDAEbFes72s4nwUcFaVw3tIdqJyaC3zYmDLC9a/33VMW7dTuISg0GSW
 tyWJci83B3o8vwc2LtxfH+ZF+ZP2N3dr7pKM95HoBQoFCMBWCe6e3VpsrKN7CmeAhWMAx0JV1Ux
 PCOpenAjrpzTgU7hq6BVUpRuVefhn8jDPh0En/YThu/HNmvVzN6cJd4v3wYVq34EMKXYjYJ9I2s
 bGZR3swHfndRPOm2Lla7r+TUddslMMgRnsEMST3Sy/0hM/oONyHYLPZr9H7FHnDUQQyMIjVD3Tv
 nhfptGts=
X-Google-Smtp-Source: AGHT+IHj1h0NEQ4A6C3a4ssyrNb1LKrAC3cuKqenjNYLTsYs9xUlAcySKIbU4i0zM0whTHcvvLlWMA==
X-Received: by 2002:adf:9d89:0:b0:3a6:e2d5:f14c with SMTP id
 ffacd0b85a97d-3a8fdeff3fcmr10218149f8f.30.1751299492323; 
 Mon, 30 Jun 2025 09:04:52 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c7ec69dsm10685215f8f.6.2025.06.30.09.04.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 09:04:52 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 30 Jun 2025 18:04:45 +0200
Subject: [PATCH v2 2/2] gpio: qcom: move pm8550 gpio to new driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250630-topic-sm8x50-pmic-gpio-pinctrl-new-v2-2-cc1512931197@linaro.org>
References: <20250630-topic-sm8x50-pmic-gpio-pinctrl-new-v2-0-cc1512931197@linaro.org>
In-Reply-To: <20250630-topic-sm8x50-pmic-gpio-pinctrl-new-v2-0-cc1512931197@linaro.org>
To: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3218;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=UD4lh7YLCq7xJDrxI+MT78QBezZ8U6s4p08979djvuc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBoYrWgr1bLA8+CodnXfzcoRsZid9PUQzl1EXKeLZT7
 kpfO/QCJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaGK1oAAKCRB33NvayMhJ0bP5EA
 C8TlBJrp75rV/k5ggUfyKjAHPvZLlf2aQSvEbcSELVKomH4kGFIYnk9HEJ74QRUZzIbJtF5Xbz5Hk7
 5IUupRuTti406+n1Y83cgpsFzw5VS/KifAf8QJSgLIQiDAFqpdcOti/JVRuOwakKYiZqEPKwzfUSqX
 5LYi/uAFWfzRw1sih5vD1/180L9fLHxYRKyWKdZBSxPiijLD7ZxDtVEQwi159mdHOX2XScfcusdf7T
 +brWZd/OrZAEic3mndM5NYBe8oxFCpE6Su0DACwjgWGpJwl+iMpaTFOJuJbxkqQRVJabHQ1KywfMDT
 N/R0CTnpVswpk9FJg/frDZ6Dfs+9WWkYvc5+ckg9gD5cyqejGvmTwuRN1TqQw1nVcdOQrkHSTgpJQ/
 uyR5qZBXEpDvCa7/PHdUrceAGNiRS2Xl87v8Yq6j3M7NJDu48tTgE3wnJlRi7zzL4b7qPBYGnye1VL
 C6ptigU5zisSPVA/M/1ZaQI0hpoKgQgYWxg4FInGy6hzsY/qqqA5Me9TSPJyHd0c5z0HJMn5URAyVW
 KhFy0vU7nQG/luTFCA0A95Kmotygowbe2dHQb0oKIaHKuLZGZtYiSe8WfgHmDA8mg9GweiIeLGpaFr
 QIbTu1cUGvsgWSppnSZKTBymOd4gTPHbXZbbAMeFWOPYvVBa8qZ34IqhKqkA==
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

Move support of the pm8550 gpios to the newly introduced
driver and drop the compatible entry and the read-only quirk
at the same time from the old driver.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/gpio/qcom_pmic_gpio.c | 20 +-------------------
 drivers/gpio/qcom_spmi_gpio.c |  1 +
 2 files changed, 2 insertions(+), 19 deletions(-)

diff --git a/drivers/gpio/qcom_pmic_gpio.c b/drivers/gpio/qcom_pmic_gpio.c
index cd9f3926ac41d84161b1e5311d9a99bb0b4a68ff..4458c55cd3da4d279b360b701348b50247036198 100644
--- a/drivers/gpio/qcom_pmic_gpio.c
+++ b/drivers/gpio/qcom_pmic_gpio.c
@@ -69,17 +69,6 @@
 #define REG_EN_CTL             0x46
 #define REG_EN_CTL_ENABLE      (1 << 7)
 
-/**
- * pmic_gpio_match_data - platform specific configuration
- *
- * @PMIC_MATCH_READONLY: treat all GPIOs as readonly, don't attempt to configure them.
- * This is a workaround for an unknown bug on some platforms where trying to write the
- * GPIO configuration registers causes the board to hang.
- */
-enum pmic_gpio_quirks {
-	QCOM_PMIC_QUIRK_READONLY = (1 << 0),
-};
-
 struct qcom_pmic_gpio_data {
 	uint32_t pid; /* Peripheral ID on SPMI bus */
 	bool     lv_mv_type; /* If subtype is GPIO_LV(0x10) or GPIO_MV(0x11) */
@@ -128,13 +117,8 @@ static int qcom_gpio_set_direction(struct udevice *dev, unsigned int offset,
 {
 	struct qcom_pmic_gpio_data *plat = dev_get_plat(dev);
 	uint32_t gpio_base = plat->pid + REG_OFFSET(offset);
-	ulong quirks = dev_get_driver_data(dev);
 	int ret = 0;
 
-	/* Some PMICs don't like their GPIOs being configured */
-	if (quirks & QCOM_PMIC_QUIRK_READONLY)
-		return 0;
-
 	/* Disable the GPIO */
 	ret = pmic_clrsetbits(dev->parent, gpio_base + REG_EN_CTL,
 			      REG_EN_CTL_ENABLE, 0);
@@ -278,7 +262,6 @@ static int qcom_gpio_bind(struct udevice *dev)
 {
 
 	struct qcom_pmic_gpio_data *plat = dev_get_plat(dev);
-	ulong quirks = dev_get_driver_data(dev);
 	struct udevice *child;
 	struct driver *drv;
 	int ret;
@@ -292,7 +275,7 @@ static int qcom_gpio_bind(struct udevice *dev)
 	/* Bind the GPIO driver as a child of the PMIC. */
 	ret = device_bind_with_driver_data(dev, drv,
 					   dev->name,
-					   quirks, dev_ofnode(dev), &child);
+					   0, dev_ofnode(dev), &child);
 	if (ret)
 		return log_msg_ret("bind", ret);
 
@@ -365,7 +348,6 @@ static const struct udevice_id qcom_gpio_ids[] = {
 	{ .compatible = "qcom,pms405-gpio" },
 	{ .compatible = "qcom,pm6125-gpio" },
 	{ .compatible = "qcom,pm8150-gpio" },
-	{ .compatible = "qcom,pm8550-gpio", .data = QCOM_PMIC_QUIRK_READONLY },
 	{ }
 };
 
diff --git a/drivers/gpio/qcom_spmi_gpio.c b/drivers/gpio/qcom_spmi_gpio.c
index 2bb0f0d10c32ff55d3fd5c61b9bc2999878bfea6..22c8072534e9188445f0aaef5336863fd1da7a75 100644
--- a/drivers/gpio/qcom_spmi_gpio.c
+++ b/drivers/gpio/qcom_spmi_gpio.c
@@ -743,6 +743,7 @@ static int qcom_spmi_pmic_gpio_probe(struct udevice *dev)
 }
 
 static const struct udevice_id qcom_spmi_pmic_gpio_ids[] = {
+	{ .compatible = "qcom,pm8550-gpio" },
 	{ .compatible = "qcom,pm8550b-gpio" },
 	{ .compatible = "qcom,pm8550ve-gpio" },
 	{ .compatible = "qcom,pm8550vs-gpio" },

-- 
2.34.1

