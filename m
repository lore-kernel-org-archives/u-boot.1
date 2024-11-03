Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A1E1E67819
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 00:36:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FCA4891AD;
	Sun,  3 Nov 2024 01:36:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Magzt/CP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0DFA892E5; Sun,  3 Nov 2024 01:36:27 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B05CA892FD
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 01:36:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-21145812538so422745ad.0
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 17:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730594182; x=1731198982; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=89VitzKhAPiQLFUpFVgGy85iUm85mQAsEP/iKY8QS5w=;
 b=Magzt/CP7VlaPE3YqZpeD+Kwu/J0GXiaNtQfK2/7csEcxULg5gXvK81mX2e02+351h
 2+gsvRZf/5fFBfS3xB7/8vhyQ/Y4OPda1vXfvwauVRpLUHC5s25XE6muAaoAH52csr+/
 pizSguPVsoTCIqmU8U09yzf81IZ52+RPqmkR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730594182; x=1731198982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=89VitzKhAPiQLFUpFVgGy85iUm85mQAsEP/iKY8QS5w=;
 b=NuabXmQg8hGy+aPt6CSV6hkHcxyQMbm4/pTrJwGY1gki57uysKEx8oSOcgVuHY/IH9
 DNOAB/q+9nxLll0rjjEkYHvdwUHzWSuUlvCqFGFMDgNPay0NfH5uV0kGJrtND4iBHTLH
 a+ZE5T+6MkY+0LcUTAuj+CfXXGSR+X1XCVsTgUMvatLH72Uh8mF0TBqJsoIKrW52A9+6
 d3LljEqHr8hcXBKYNcjo6wh4bPE0tuvPMdOJ0Va/x8IgGpegeLiUqWJFxgyJQOXFbqDE
 d+WbjUqDUXZm8dYhJ3tC8bukzXZu/iImQtwena6pd+767zsv5KKIj28mYX9agoTaRAl6
 dNuw==
X-Gm-Message-State: AOJu0YwxL2G7INz5c2fnMtbIt1l/707fEqwwkwAryRDGM5YpMjiLSQy9
 lMIAt3d5sKXisX0nEui0rwWNMBTs1hjviaf/w9X+NsVyN+QMPE4X/pdnc3MthhwSjdIe+SG6Mrd
 lCw==
X-Google-Smtp-Source: AGHT+IERyV3XqmUYSiMA28n9iErRKdFmB+SqDMGK+DpUx/uohoOKxo1+JQQ8IxP2FThDSLbBrICbrA==
X-Received: by 2002:a17:903:2442:b0:20c:5cdd:a9e with SMTP id
 d9443c01a7336-210c6c02482mr347884335ad.28.1730594181879; 
 Sat, 02 Nov 2024 17:36:21 -0700 (PDT)
Received: from chromium.org ([205.220.129.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211057a63f2sm38987995ad.168.2024.11.02.17.36.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 17:36:21 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jonas Karlman <jonas@kwiboo.se>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Tien Fong Chee <tien.fong.chee@intel.com>,
 Wan Yee Lau <wan.yee.lau@intel.com>
Subject: [PATCH v3 12/25] misc: Drop gpio_led driver
Date: Sat,  2 Nov 2024 18:33:04 -0600
Message-ID: <20241103003322.626036-13-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241103003322.626036-1-sjg@chromium.org>
References: <20241103003322.626036-1-sjg@chromium.org>
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

