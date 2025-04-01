Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97163C36018
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 09:48:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5637582063;
	Tue,  1 Apr 2025 11:47:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MAhPnMMC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C160A81FC8; Tue,  1 Apr 2025 11:47:54 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C5E781FFC
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 11:47:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-391342fc0b5so3901352f8f.3
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 02:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743500871; x=1744105671; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=z5G4sIRxTG4U1QGiE9u+jy31Ioc4yLM7VXGZrFMXlww=;
 b=MAhPnMMCKbGykDDlazR5QyOquWYtFdWqh00tKZEphT86XTYeI/J+chRrkOQxSa2QSF
 QT4piq51KRtLxth8DMgHDIIrnp9FZna/0rVpGS3VAtbKj0IqkZ5SVgG+8+2g2W1rsE73
 jXd2JDch9BeWXzQSrzsanLMEP9HFuFg5uYdSIRYUzRp3bFqN7fuzv1CYiKphKx3ohxJo
 VbizNzU8J1rEaoQVYVIozIxOB1X/wmNlR4xf+q034PqbJO3ZAJNJjyweAzoRE7svnSVs
 I9Jfqz7R3tugObHnF34Mh+35LkPV4DIp9Xyp6qPECXWJuQ3tNLD43YN1LjM9jVJ02YvN
 vCXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743500871; x=1744105671;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z5G4sIRxTG4U1QGiE9u+jy31Ioc4yLM7VXGZrFMXlww=;
 b=WZRfJlLj/ggs67AAUjvXWfhbHY66CWVPBdofZt1uIyQ8O4l2cwBNJDsuvbOxePV85U
 cW/icCxLOqF+/NCKI/KJ6fVMXy6F9fsKTx8ErgEnJiLT5djuKLP17Etaq2bnQq3jJXxp
 HVcfJXfiF4Z4SriTnVfDipsUTOWX3GiaZIBk3LQ+Hhyo1e8vyfaIuHHaVa4+AkPI4+AE
 cnpk+fF3oiOH+9ZceSe7vdSNY/JWEtwsS1VG2GU0cFVklAWZrSU8z/sU0qHzDOvEkdn0
 JKzRQbW2AH3/iAn7hfzttGPY81y9md6IsA/dUXScoN/bbN8OEWHRK7J3F7xYDwsdZ5Z6
 NHbw==
X-Gm-Message-State: AOJu0Ywlx7IGAT9zmsaZbrThHneBsm0Mhuv1qqA1WZTRK7aHCyjsKsBD
 SKxQDF9lwLRkyzqrBtt0jnn6FvmwOf+HsS3++ZP2D5ojEb9OiuSlE1DOsV6wIV/Tv8GmczT3UH8
 S
X-Gm-Gg: ASbGncttFS6NY9vU6hl9V/C4xUPdSre/Qs9JCSkBRxPTWUXPUz6d1HeBrSdNmTmWCRW
 1Qrzq7Tlwa3pHf5urVtov5yA/2iyNp6Zb9349x4rKcDJ80HEQOg/HJorvGl9PPEDCsoiE9HDAox
 4kGtCBAzzjGK+S6rpiJLKTDoMMdUcwedkkkjlWzo5ZG3osSz5TM3XFrwx280JxuT+Mg4yXSSB4X
 SalvagOq77wOXEoflpfNdXEVZ5i5K9HIdbUnFiOLgO9Tzm9TK9wp1r2tV2sKpSAtfOegr3+PQ4F
 vgcPkL2tH80HVejrqOoF8iKq2oBWipYelkhCgXjdnE8eGSZRAff8+CAaPKFA9CfU9Q==
X-Google-Smtp-Source: AGHT+IEyv+Cu6BL+Mvx5SL2T6ehAaA6fTAywrrbSf2UDeFCT3TWs/WY3Lt9/k4OPjNS8Q3RirDu/Xw==
X-Received: by 2002:a05:6000:1843:b0:391:952:c730 with SMTP id
 ffacd0b85a97d-39c120cca4emr9563672f8f.11.1743500870875; 
 Tue, 01 Apr 2025 02:47:50 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b6656a0sm13733581f8f.37.2025.04.01.02.47.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 02:47:50 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 01 Apr 2025 11:47:48 +0200
Subject: [PATCH RFC/RFT 2/2] gpio: qcom: move pm8550 gpio to new driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250401-topic-sm8x50-pmic-gpio-pinctrl-new-v1-2-74077ef0b464@linaro.org>
References: <20250401-topic-sm8x50-pmic-gpio-pinctrl-new-v1-0-74077ef0b464@linaro.org>
In-Reply-To: <20250401-topic-sm8x50-pmic-gpio-pinctrl-new-v1-0-74077ef0b464@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3218;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=UD4lh7YLCq7xJDrxI+MT78QBezZ8U6s4p08979djvuc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBn67ZEllOcEATxxVCz2zMP5ZpuBj3c9gwEKogTVRVw
 to5BiNaJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ+u2RAAKCRB33NvayMhJ0cEGD/
 9ofGLONnVSTF6I/+vSeRHPlK6TZu7QjYl+r/O8Y8mnnUYh5BlC2nAxHk0c9qZYNw0G0xHisEOuSynP
 ijuT1Vtei8YSnJhSdj+HhkYQVaWiaj2c2KwKeK2XERsnl+tiMnMYQpFwWshAFgbwjdIkxI9JEJdtwV
 8WypNYWRuEbemKkumqyqrrPE1fExy+YB2DllVIVy5UOmgLnr4NmpW7n+2+VY/lCBMBbW24lOMJpZ5u
 BEtN73Zt+y3qtYnnsQIwbtAVEKKjZcvjE1dAAE1H7zfkXneTtdBcx6DVT+vuDH2pYpIr1PuvQ0Jj5x
 lnr36mRsfrwfk6tNpmelEVVCvL2NSY0UJhdS+Jq1mgkujAYUo5YuA+zaN6XmQYgGJV2p2q7Mqc0B21
 OYHUul6jTM6/jW+MjaPr4y7C+pP2omz4T60vBXr1Vp3UrgkhTsDVoh+kZUIC5n5v42hlIBjtd2uGOj
 CiFO/IH4AqdgdpC38F+0OQOfqWHsJ1nO0jfP9GnFOj59g8uwNE3sdHqW7UjuB0tbpYHZnKu4TKivgM
 g8Ug9pPDzvDZsydwSpspq+dx7qutOkVTl1mxFsKydriFG3F5C0t8SMJY+mDwHE6+NaJl2yzAhTzmxj
 HcazBVC9WHLsngYxVykmFNusjHydhX24zK+RXHoW3hCv5+rqTxxXdVBEg1uQ==
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

