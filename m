Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07276D1AD30
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 09:16:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51ACB88D91;
	Wed, 16 Oct 2024 11:16:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="acPAkRVU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4439988E5C; Wed, 16 Oct 2024 11:16:23 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 350E588D5A
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 11:16:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-37d4b0943c7so4206443f8f.1
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 02:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729070181; x=1729674981; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PNO3SidIfs7L32mfWOAFaUmbBoAFAWS+1oQQFUO4qhQ=;
 b=acPAkRVUwaZu/X5tBkskkxJIYNxmYade4Ws5r6TBDdU7wFrQIm8PEkeWKRt8hvd7H+
 NDE5DvFSofMBYwfOCLuAA0jPuKZ6Nc4ZIDRDwK7lBDvolge0VinMCWvJq0UAnMa/ZqVd
 IPanGD9XBQTOihwCMQNf1toKGuxS/uCzpnABU/etuihArN6vl9nV5Ea8mRF3iaLJ3AKM
 E+H7T0oQry65YZPy1D5xnSID264zXa8T9ChLoUlTMHJaQ6bmF+V518fND3OZH1oXsWrm
 5Ppu1vnsbnp2HnOxyPFlyRQYK9f6XF2wCO5LKUeAeL9Edx9R9rt1z4ug2t/ZzH3hnnZq
 objA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729070181; x=1729674981;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PNO3SidIfs7L32mfWOAFaUmbBoAFAWS+1oQQFUO4qhQ=;
 b=lhbZ4F/pvYs29zFcGfzl9Z1bCYXc/9k0c+7UR5coPKpK3QlpZOm4jjFLIa/jetjLwZ
 0FH6dD9KupTBphDmOKUNYDQif1BuaYeN8vJeO0ThSOH/qNAplHjjaaeEcVFh2XNLSpq7
 aElgeTAdr/T3G0s7ZLEZUbh6EUx2m27XOw846IBOG1MRd5ezupivw5WP+z/6Nm9fAo35
 nSuH1P01Rp78OK7tsv8BZABY+JRbkOD2tRN1cr7H2dJvVfhVMEIdFRZMsD+aRPRQAlxI
 y+NfZwPWtM4LmuHJYmcYmwWBtHH1MQ3vYMfexO4/TWckyK/KXWK9ddhKz7InHV4pLAX7
 vIpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSV3hftd8+XsZqtKvkQxNjI/b9kYwHmKmVCLlQtHM1kuWJ3PHrTj0EQW5j4YSv7LPYb6tUgqk=@lists.denx.de
X-Gm-Message-State: AOJu0YxfANYVDU7/cnAsP/BOCqGW9ykOynaPS9YPfMoEfMiB19vXaqsC
 SOzBH03v4vsRyWRd9+kNNZc4wxiD3O9bdqQ4vL/PTbaEteFItdnUTxWV4rP+BpY=
X-Google-Smtp-Source: AGHT+IFcir56oWLywcO31UHyEBpXpHvQ/D/5Ay2PaxU1sq5kQQyV3xTFjfmntvopPYDbOLhSNv7O0A==
X-Received: by 2002:adf:f3cb:0:b0:37d:5133:8cba with SMTP id
 ffacd0b85a97d-37d86bd5ae0mr2324581f8f.20.1729070180555; 
 Wed, 16 Oct 2024 02:16:20 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fa87d56sm3810855f8f.43.2024.10.16.02.16.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 02:16:20 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 16 Oct 2024 11:16:18 +0200
Subject: [PATCH] gpio: qcom_pmic: add again the quirk to skip GPIO
 configuration on PM8550
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-topic-sm8x50-qcom-pmic-re-add-quirk-v1-1-6d4917d9063f@linaro.org>
X-B4-Tracking: v=1; b=H4sIAGGED2cC/x2NQQrCMBAAv1L27EIS0hr9inhos6sukibdqBRK/
 97gceYws0FlFa5w7TZQ/kmVPDewpw7ia5yfjEKNwRnnrbEDfnKRiDWFtTe4xJywpCaUcSTC5Sv
 6xnM/OU8UhuAv0EpF+SHr/3K77/sBZ/T49nUAAAA=
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2916;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=hN6n8o4h0rxq/LW5w3ACj/koQh5A5o1Sh6wxDILJb08=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnD4Rj/B127WHeIeDVrQmoPTS5eXXumtEN6B5VzIrW
 NWNdZbGJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZw+EYwAKCRB33NvayMhJ0cIRD/
 9/Y0D4aXfSVPbvL+00/SddifoMnPLLkhfy30ZhEtnsRhRn4xuBUUDNliKDb5uMRboaBGMIC2834VUH
 vMmYXAAYeaD1nqVPot2UyHrC/Ggw57AJgm9Qsi+cI/W4umqSiw57uIEvri1mFuq2z/z4phlaK5WFRv
 6TSY4WSHsitDcNbaXPWWBI6WXJ+i9cB1VYJU64GSMW6fjrFqUbbM5PDI0+U9tGUQfUhMIBDQ250Bhb
 Ck2XiNulP0FwlIdnxtJyNV8IN9l50EgHL3nK8aaWb9QP66rxH3LKzTDCONdknZG/PORc8+8T0CeRjB
 F4Qy9X7bvqEE4unLrp6r/BT94hjVhI39Xy2Hum9iu8GO0Fua893LoajKDWhU51oBK7eqKrIhV9YBCG
 73VhNrqkXgGYLIYp9DypNS9B4gqXCvw4jdU/BmjGgfrrE8WYPvPtWjUMSjdPnIGS6kUTLdlZ1ByDJq
 BsnCDL9eCavHkujdoOx9GvGcYpfdV3Rg4SD9g+BGWM59xjJ6zGMJSWmQV8tfTMOTaFy/DkZx6YRhyh
 //VkVWLwDjvx/hd8BCCzmwZSved7Iq62ktTnz3fwmXWpRqKCahLf3edLIthPdnDFJkOKVo1BuUPGTc
 Nl9jtYxXwg+n+yAh/ThnAJhpxF5Rn2wZFU83KXoy9XsUrl1YrslA+3vP89kg==
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

The qcom_pmic code is broken for new PMICs and should be fixed,
without the QUIRK the code is broken and the GPIOs don't work
anymore on SM8550 and SM8650 platforms.

Partially revert the revert and only add the quirk on the PM8550
PMIC, making the buttons and MMC detect gpio work again.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/gpio/qcom_pmic_gpio.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/qcom_pmic_gpio.c b/drivers/gpio/qcom_pmic_gpio.c
index f2ef4e5ce14..cd9f3926ac4 100644
--- a/drivers/gpio/qcom_pmic_gpio.c
+++ b/drivers/gpio/qcom_pmic_gpio.c
@@ -69,6 +69,17 @@
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
 struct qcom_pmic_gpio_data {
 	uint32_t pid; /* Peripheral ID on SPMI bus */
 	bool     lv_mv_type; /* If subtype is GPIO_LV(0x10) or GPIO_MV(0x11) */
@@ -117,8 +128,13 @@ static int qcom_gpio_set_direction(struct udevice *dev, unsigned int offset,
 {
 	struct qcom_pmic_gpio_data *plat = dev_get_plat(dev);
 	uint32_t gpio_base = plat->pid + REG_OFFSET(offset);
+	ulong quirks = dev_get_driver_data(dev);
 	int ret = 0;
 
+	/* Some PMICs don't like their GPIOs being configured */
+	if (quirks & QCOM_PMIC_QUIRK_READONLY)
+		return 0;
+
 	/* Disable the GPIO */
 	ret = pmic_clrsetbits(dev->parent, gpio_base + REG_EN_CTL,
 			      REG_EN_CTL_ENABLE, 0);
@@ -262,6 +278,7 @@ static int qcom_gpio_bind(struct udevice *dev)
 {
 
 	struct qcom_pmic_gpio_data *plat = dev_get_plat(dev);
+	ulong quirks = dev_get_driver_data(dev);
 	struct udevice *child;
 	struct driver *drv;
 	int ret;
@@ -275,7 +292,7 @@ static int qcom_gpio_bind(struct udevice *dev)
 	/* Bind the GPIO driver as a child of the PMIC. */
 	ret = device_bind_with_driver_data(dev, drv,
 					   dev->name,
-					   0, dev_ofnode(dev), &child);
+					   quirks, dev_ofnode(dev), &child);
 	if (ret)
 		return log_msg_ret("bind", ret);
 
@@ -348,7 +365,7 @@ static const struct udevice_id qcom_gpio_ids[] = {
 	{ .compatible = "qcom,pms405-gpio" },
 	{ .compatible = "qcom,pm6125-gpio" },
 	{ .compatible = "qcom,pm8150-gpio" },
-	{ .compatible = "qcom,pm8550-gpio" },
+	{ .compatible = "qcom,pm8550-gpio", .data = QCOM_PMIC_QUIRK_READONLY },
 	{ }
 };
 

---
base-commit: d5cab0d6adc26ec1bbd45c2fed101184d04454ae
change-id: 20241016-topic-sm8x50-qcom-pmic-re-add-quirk-75b24dd86849

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

