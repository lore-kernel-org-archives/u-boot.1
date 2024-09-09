Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73F59ECE57A
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 12:06:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B069C88C70;
	Mon,  9 Sep 2024 14:06:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EZBXz5Yt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4838F88D90; Mon,  9 Sep 2024 14:06:51 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48E1588C70
 for <u-boot@lists.denx.de>; Mon,  9 Sep 2024 14:06:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5c3ed267a7bso1811919a12.3
 for <u-boot@lists.denx.de>; Mon, 09 Sep 2024 05:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725883609; x=1726488409; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pp4hr0Pl6dMJ7egx7sUE8uwG6pH4A9PkCe8vVMgvv6o=;
 b=EZBXz5YtMqHaM0Ds4zbl0KuELyZN0BhY55RX3QymB0y2XXtVAXdCax90u9onqrCzDF
 esUE17I0Sho0xPbaA8hAy0HFbUcOu45Xisae6pL7ohVXKLXOEN9R8cYquLKDjq87eicU
 d1exLT793lkE45DDneXO+asoLDLuVfJaCZT35ZvtGGZP1c3p5ZBNfohOLSpO9uOdPksL
 hByA4024/Tl7bTceWdHYiQoRJkT4WLUKbEct6p0hLnRvpUhylqfKjJ/d3MJ1Lo25DnIk
 xcvlS4Kj81FLJMFmckQJG8U3iDqUJAAY+4rMa1G8OheBH8w1GeORQ29/n7NYLUyAB1nn
 HI+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725883609; x=1726488409;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pp4hr0Pl6dMJ7egx7sUE8uwG6pH4A9PkCe8vVMgvv6o=;
 b=PbXvklqhuZKcywZU7EnJcuskvj0Nx0sRG5WnLnnAvMW/BTW4Q9uMRWhYJMdAZdfrMM
 P2avWuHyo6jF9xIdR0vvySrDcwM19GRmpo18CJZcNEzOIUFAGwaN913Vf45JGHrGD8z8
 8s/XpQpYnlYajTYqhwt1bAy7996kisH+58Jup5DLeufu+cwYB/0ttTumhYTm7UiR1X3e
 RKf74L4oC/IH5D5X6A6Kl4dsL7K25OagV1NPDPFjADJXQqozOLZ2gJJN5009NFKJ2ziu
 qI80Id+877kcOiT+IbGHs+L8djJh7shfOGrC6Xnq3ZsBHvyINmBfM6RJu4RNAZTiKOSK
 AZzA==
X-Gm-Message-State: AOJu0YyhAnm6YA69cKdk60EWVAQMyIT25fuJHbGid3u8tzlJRl9QUkDt
 AL9jGDmHRegYkodJojR9LxiivlgTzq3qe1dYA1QnyHgF30KVHrvIMHaTVm8VE+o=
X-Google-Smtp-Source: AGHT+IFEpHxH5wE3L5Q9bXuf3G2aff/z1cxp6lF+L3R/VmSw5Z4Cr4CqgZUtGU6PoW8juCOQ7Val5A==
X-Received: by 2002:a17:907:e90:b0:a7a:9447:3e8c with SMTP id
 a640c23a62f3a-a8a885bddf2mr664900466b.3.1725883608431; 
 Mon, 09 Sep 2024 05:06:48 -0700 (PDT)
Received: from lion.caleb.rex.connolly.tech ([2a02:8109:aa0d:be00::8db])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d2583f73asm332871966b.7.2024.09.09.05.06.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 05:06:47 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, Heiko Schocher <hs@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	u-boot-qcom@groups.io
Subject: [PATCH] Revert "gpio: qcom_pmic: add a quirk to skip GPIO
 configuration"
Date: Mon,  9 Sep 2024 14:06:10 +0200
Message-ID: <20240909120641.1396544-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.46.0
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

This reverts commit 19f000b72b2fa7e4540f7cdb91287aff594239bd.

The bug in writing was caused by a long-standing error in the SPMI
driver which has since been fixed - c2de620d64d4 ("spmi: msm: fix
version 5 support"). We can safely enable writing GPIO configuration
now.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
Tested on SDM845/pm8998 (OnePlus 6)
---
 drivers/gpio/qcom_pmic_gpio.c | 27 +++++----------------------
 1 file changed, 5 insertions(+), 22 deletions(-)

diff --git a/drivers/gpio/qcom_pmic_gpio.c b/drivers/gpio/qcom_pmic_gpio.c
index 80fee841ee3f..f2ef4e5ce144 100644
--- a/drivers/gpio/qcom_pmic_gpio.c
+++ b/drivers/gpio/qcom_pmic_gpio.c
@@ -68,19 +68,8 @@
 
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
 	u32 pin_count;
@@ -127,15 +116,10 @@ static int qcom_gpio_set_direction(struct udevice *dev, unsigned int offset,
 				   bool input, int value)
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
 	if (ret < 0)
@@ -277,9 +261,8 @@ static const struct dm_gpio_ops qcom_gpio_ops = {
 static int qcom_gpio_bind(struct udevice *dev)
 {
 
 	struct qcom_pmic_gpio_data *plat = dev_get_plat(dev);
-	ulong quirks = dev_get_driver_data(dev);
 	struct udevice *child;
 	struct driver *drv;
 	int ret;
 
@@ -291,9 +274,9 @@ static int qcom_gpio_bind(struct udevice *dev)
 
 	/* Bind the GPIO driver as a child of the PMIC. */
 	ret = device_bind_with_driver_data(dev, drv,
 					   dev->name,
-					   quirks, dev_ofnode(dev), &child);
+					   0, dev_ofnode(dev), &child);
 	if (ret)
 		return log_msg_ret("bind", ret);
 
 	dev_set_plat(child, plat);
@@ -360,13 +343,13 @@ static int qcom_gpio_probe(struct udevice *dev)
 
 static const struct udevice_id qcom_gpio_ids[] = {
 	{ .compatible = "qcom,pm8916-gpio" },
 	{ .compatible = "qcom,pm8994-gpio" },	/* 22 GPIO's */
-	{ .compatible = "qcom,pm8998-gpio", .data = QCOM_PMIC_QUIRK_READONLY },
+	{ .compatible = "qcom,pm8998-gpio" },
 	{ .compatible = "qcom,pms405-gpio" },
-	{ .compatible = "qcom,pm6125-gpio", .data = QCOM_PMIC_QUIRK_READONLY },
-	{ .compatible = "qcom,pm8150-gpio", .data = QCOM_PMIC_QUIRK_READONLY },
-	{ .compatible = "qcom,pm8550-gpio", .data = QCOM_PMIC_QUIRK_READONLY },
+	{ .compatible = "qcom,pm6125-gpio" },
+	{ .compatible = "qcom,pm8150-gpio" },
+	{ .compatible = "qcom,pm8550-gpio" },
 	{ }
 };
 
 U_BOOT_DRIVER(qcom_pmic_gpio) = {
-- 
2.46.0

