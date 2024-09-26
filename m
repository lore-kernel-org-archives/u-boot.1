Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D68F1CDE03A
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 20:50:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AAD588DFD;
	Thu, 26 Sep 2024 22:50:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="a2mhrD0/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C6CA88E18; Thu, 26 Sep 2024 22:50:21 +0200 (CEST)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A075A88DF9
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 22:50:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7a9b72749bcso125780685a.0
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 13:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727383817; x=1727988617; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vTCli/w81A9wvYO7dP752fOz72SbRMpHIXjound9aqs=;
 b=a2mhrD0/ZDR3vsMCj8vDLUhWGrL/P1oK+L2YdMauAFn3tBtIs5IaewUnXYiiSFKrTu
 KpT4DV/AV1Tde0ENVhfF3/RD6CAgEWhcDCUxmrVoM3gCk61sCOB4ZVR87jOCHuV3RG5T
 S4kEqLz5uDSK1qjSpzPb059kDcyDF5F0FzsaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727383817; x=1727988617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vTCli/w81A9wvYO7dP752fOz72SbRMpHIXjound9aqs=;
 b=H1Sgfg6C9NGRhYqnzGUZwSRAVtwBMdoqZn8OWZTZ7fGR8A9hyD9heg7DScoJ+C1+O0
 WL4Bdi1SfGM2x7kUGXfVecaLCNUNpf533XP4zW9aJT6wP8/zDcmzRbFvKdgVSqxZlMuf
 h7vvmhQWg5qrm0CACsoQIr6tu3hQWsbaoQtar8UY0N45wUBLG9s7+x2OcN0GqJL4Twu+
 PL6kG2L3twhNMKeS8ckiRYYjMfLL1a8Ldnp5z+otmG68M+AURy6sjlM0KnpuacYLg0yN
 +VIFi7qPQAmWyN+uIqJGk2Ac1xKZ69iDLJUAlntukwDF2H9dLMAAg3s2CmwSD6m4IhVs
 /Jeg==
X-Gm-Message-State: AOJu0Yxymbr11ka3uBGhbrIjpqHB4FuDpvPLPqAJVwn8e4ZLrEUXrH+v
 /7wl10xfvT2UjkTWYXruijwbXm+IGFFUfKV+f8oPSQPWLvsl1I8fMXrl1GVSrZ2meUnmnKU6BHh
 cbTs3tHs=
X-Google-Smtp-Source: AGHT+IFbl79TU8ngh5YI0kE0aAAnZjPF9knTaaIA7xd9UvjIylkEaOA2DB5YHQZgIlnIU+9919wCLg==
X-Received: by 2002:a05:6214:3d0d:b0:6cb:3a93:f8f7 with SMTP id
 6a1803df08f44-6cb3b63d9d9mr13818176d6.34.1727383817362; 
 Thu, 26 Sep 2024 13:50:17 -0700 (PDT)
Received: from chromium.org ([205.220.129.31])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cb3b66cff5sm2538696d6.77.2024.09.26.13.50.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 13:50:17 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Wan Yee Lau <wan.yee.lau@intel.com>
Subject: [PATCH 12/27] misc: Drop gpio_led driver
Date: Thu, 26 Sep 2024 22:44:32 +0200
Message-ID: <20240926204455.963584-13-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240926204455.963584-1-sjg@chromium.org>
References: <20240926204455.963584-1-sjg@chromium.org>
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

This is not used anymore, so drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/misc/Makefile   |   1 -
 drivers/misc/gpio_led.c | 106 ----------------------------------------
 2 files changed, 107 deletions(-)
 delete mode 100644 drivers/misc/gpio_led.c

diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index e53d52c47b3..c4941377b7d 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -49,7 +49,6 @@ obj-$(CONFIG_IHS_FPGA) += ihs_fpga.o
 obj-$(CONFIG_IMX8) += imx8/
 obj-$(CONFIG_IMX_ELE) += imx_ele/
 obj-$(CONFIG_LED_STATUS) += status_led.o
-obj-$(CONFIG_LED_STATUS_GPIO) += gpio_led.o
 obj-$(CONFIG_MPC83XX_SERDES) += mpc83xx_serdes.o
 obj-$(CONFIG_$(SPL_TPL_)LS2_SFP) += ls2_sfp.o
 obj-$(CONFIG_$(SPL_)MXC_OCOTP) += mxc_ocotp.o
diff --git a/drivers/misc/gpio_led.c b/drivers/misc/gpio_led.c
deleted file mode 100644
index e63689967a7..00000000000
--- a/drivers/misc/gpio_led.c
+++ /dev/null
@@ -1,106 +0,0 @@
-/*
- * Status LED driver based on GPIO access conventions of Linux
- *
- * Copyright (C) 2010 Thomas Chou <thomas@wytron.com.tw>
- * Licensed under the GPL-2 or later.
- */
-
-#include <status_led.h>
-#include <asm/gpio.h>
-
-#ifndef CFG_GPIO_LED_INVERTED_TABLE
-#define CFG_GPIO_LED_INVERTED_TABLE {}
-#endif
-
-static led_id_t gpio_led_inv[] = CFG_GPIO_LED_INVERTED_TABLE;
-
-static int gpio_led_gpio_value(led_id_t mask, int state)
-{
-	int i, gpio_value = (state == CONFIG_LED_STATUS_ON);
-
-	for (i = 0; i < ARRAY_SIZE(gpio_led_inv); i++) {
-		if (gpio_led_inv[i] == mask)
-			gpio_value = !gpio_value;
-	}
-
-	return gpio_value;
-}
-
-void __led_init(led_id_t mask, int state)
-{
-	int gpio_value;
-
-	if (gpio_request(mask, "gpio_led") != 0) {
-		printf("%s: failed requesting GPIO%lu!\n", __func__, mask);
-		return;
-	}
-
-	gpio_value = gpio_led_gpio_value(mask, state);
-	gpio_direction_output(mask, gpio_value);
-}
-
-void __led_set(led_id_t mask, int state)
-{
-	int gpio_value = gpio_led_gpio_value(mask, state);
-
-	gpio_set_value(mask, gpio_value);
-}
-
-void __led_toggle(led_id_t mask)
-{
-	gpio_set_value(mask, !gpio_get_value(mask));
-}
-
-#ifdef CONFIG_GPIO_LED_STUBS
-
-/* 'generic' override of colored LED stubs, to use GPIO functions instead */
-
-#ifdef CONFIG_LED_STATUS_RED
-void red_led_on(void)
-{
-	__led_set(CONFIG_LED_STATUS_RED, CONFIG_LED_STATUS_ON);
-}
-
-void red_led_off(void)
-{
-	__led_set(CONFIG_LED_STATUS_RED, CONFIG_LED_STATUS_OFF);
-}
-#endif
-
-#ifdef CONFIG_LED_STATUS_GREEN
-void green_led_on(void)
-{
-	__led_set(CONFIG_LED_STATUS_GREEN, CONFIG_LED_STATUS_ON);
-}
-
-void green_led_off(void)
-{
-	__led_set(CONFIG_LED_STATUS_GREEN, CONFIG_LED_STATUS_OFF);
-}
-#endif
-
-#ifdef CONFIG_LED_STATUS_YELLOW
-void yellow_led_on(void)
-{
-	__led_set(CONFIG_LED_STATUS_YELLOW, CONFIG_LED_STATUS_ON);
-}
-
-void yellow_led_off(void)
-{
-	__led_set(CONFIG_LED_STATUS_YELLOW, CONFIG_LED_STATUS_OFF);
-}
-#endif
-
-#ifdef CONFIG_LED_STATUS_BLUE
-void blue_led_on(void)
-{
-	__led_set(CONFIG_LED_STATUS_BLUE, CONFIG_LED_STATUS_ON);
-}
-
-void blue_led_off(void)
-{
-	__led_set(CONFIG_LED_STATUS_BLUE, CONFIG_LED_STATUS_OFF);
-}
-#endif
-
-#endif /* CONFIG_GPIO_LED_STUBS */
-- 
2.43.0

