Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 385F8D0E6F4
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 11:41:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49A0D88F28;
	Mon, 21 Oct 2024 13:39:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kNsL9B4D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B096388FA8; Mon, 21 Oct 2024 13:39:07 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5470A88F5B
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 13:39:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5c9362c26d8so9211476a12.1
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 04:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729510743; x=1730115543; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=89VitzKhAPiQLFUpFVgGy85iUm85mQAsEP/iKY8QS5w=;
 b=kNsL9B4DTCnk3hp0CuoDZR+mj1WsvKA5J/pyij0D946eeSgDtYA3T5zZMEZBoGP+sv
 /Bz2mwgiXl8byLHyEqV9zqTja7d+V+6g4M2WXL2XsEt2Qlwb2kwV30wvEJ4NFDIZW0tg
 HH8UJ6eiVCNg0XDJMNVElxedHpdxxm2lO10t8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729510743; x=1730115543;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=89VitzKhAPiQLFUpFVgGy85iUm85mQAsEP/iKY8QS5w=;
 b=fHUxrHwck7jX9GdDjON/s2mGjsfSr6PCJllRaGtKZ5/g9minNFXGwut2sfOckZf1+V
 0KdWNPa5zSvqJN/FFk+z6rFsxbrx9/VaaPHjOR7cQxjJ8wc466mdQ2fVMua0D9V0w/64
 +iV6Plzyn5Gbji7Ls+sEH+mVy7eSLG9XIFNPxmw9F5o3BlJk1LRcgr177JZobXP4UrOK
 G0LgJuquBMDOvTqua20jOn0JFxJKqhWrXz2wOKPBjcYsnwI3q0c05kgpaxy1KZAamkyc
 5GnDATnfWaPkQuaQQ7AlM74YDnhW0Hu+lsmWCmeKF80918jmgiPLOPqyTS0tVQlXnD/U
 F1sg==
X-Gm-Message-State: AOJu0YwsYBkgjF8GNnslsS+MVvKvbl4zIwslqtgrj8SYa5J+UM0P9vp0
 8KkCih+pzs9rRRUpSRrH6dxd9En46zcy19xv51l9bpAP9MEkOLA2pMQP4EHZOmgstsLkUWLi0uv
 E77qd
X-Google-Smtp-Source: AGHT+IE3HqnLRofMJruTfLzaKfpkUKg+XKIBOyvu3LqL+QOcllVGWnoYdZJspoU7BagVLWdqxdyEjA==
X-Received: by 2002:a17:907:94cd:b0:a9a:60b0:a8e7 with SMTP id
 a640c23a62f3a-a9a6a3eb4a2mr1152338566b.2.1729510742035; 
 Mon, 21 Oct 2024 04:39:02 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a91571ea5sm191604366b.160.2024.10.21.04.39.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 04:39:01 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jonas Karlman <jonas@kwiboo.se>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Stefan Roese <sr@denx.de>, Wan Yee Lau <wan.yee.lau@intel.com>
Subject: [PATCH v2 13/25] misc: Drop gpio_led driver
Date: Mon, 21 Oct 2024 13:38:21 +0200
Message-ID: <20241021113839.318572-14-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241021113839.318572-1-sjg@chromium.org>
References: <20241021113839.318572-1-sjg@chromium.org>
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

(no changes since v1)

 drivers/misc/Makefile   |   1 -
 drivers/misc/gpio_led.c | 106 ----------------------------------------
 2 files changed, 107 deletions(-)
 delete mode 100644 drivers/misc/gpio_led.c

diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index dac805e4cdd..b7332587faa 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -49,7 +49,6 @@ obj-$(CONFIG_IHS_FPGA) += ihs_fpga.o
 obj-$(CONFIG_IMX8) += imx8/
 obj-$(CONFIG_IMX_ELE) += imx_ele/
 obj-$(CONFIG_LED_STATUS) += status_led.o
-obj-$(CONFIG_LED_STATUS_GPIO) += gpio_led.o
 obj-$(CONFIG_MPC83XX_SERDES) += mpc83xx_serdes.o
 obj-$(CONFIG_$(PHASE_)LS2_SFP) += ls2_sfp.o
 obj-$(CONFIG_$(XPL_)MXC_OCOTP) += mxc_ocotp.o
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

