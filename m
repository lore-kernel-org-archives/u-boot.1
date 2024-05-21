Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 444ADC25B74
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 15:46:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29E2088342;
	Tue, 21 May 2024 17:46:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jr2LCGwK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 784CA8824A; Tue, 21 May 2024 17:46:02 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47A8388333
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 17:46:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-5b277a61f6fso1734752eaf.1
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 08:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716306359; x=1716911159; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j4Jp1w1P2KOtAdL03/YEfJcuwvGAfgdBTp24XsA9ur8=;
 b=jr2LCGwKM3GFhBDzJ35pVEcS8DRvoJWysS2UKmagUb5r7uMW8LxehBL4RL8CNOzubX
 eVjkHixoCySqnzMId/5j8EVwX+2z0mDJZ9TEG+ViRpopCAxD4hz1p+dThRLyl+8dcHXO
 xQWNspJbfrNZ53kXORYKPHc8rGrBwB9CbfpZC5qX7FRehmhTVcJUhDL6Hdj7WFV9Yb63
 EnLdbeTfPz6X5VY0mY3t95LX7HGkeBXlF4IXeHfi3LpscVOR26+qQgnaVPUiMLok+UnC
 9W9A0Ca0acZR0j08KEBEV4sVevzPFBcOBs8jH75mSRM0nWLCds6UeihAEaRIRiXb0RPW
 sRrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716306359; x=1716911159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j4Jp1w1P2KOtAdL03/YEfJcuwvGAfgdBTp24XsA9ur8=;
 b=Wgow7vIvH98aWmIhNxS1XoEIZj9T6lqx0s/QzUzH7eetG/tMgYpLRgtdqpKg7dBwP9
 JVssiCMDHp3RlSKUuIrz33HCjcRNmXKdEAgCS8fJ2hAfOy6nKDJIbgFIQsirTPaiy/6T
 3fBJ7G3QcldMu3M3/j8v7l8PjqAAZ/HL8WMIwgaKXMODeMcA22+Crk63s/bl6imv/mA9
 kM4UcCWPXOugfU3DaD6vIr66XLv0g3bkRlDruwlC5LkXVIWHzOGYmnZxA3YDDtmal+Nj
 sskGW7M0UoqCVvA9a7aeg/fuKCBuYIzmL4Bo/4LR+YE/3Ck8ToPukAdeUF2LlDXAqzTW
 xbfA==
X-Gm-Message-State: AOJu0YzHYbrRfWIRQMk0m+NtjP1JXJCRbzv/d6p0uS4SycqCAB+hxRPM
 TDXkUtX7+HOpAOVRH/JSoE7jh4S2Dfa5wh6ZvWfu4Qvct/TohIqkaOdD+g==
X-Google-Smtp-Source: AGHT+IH23JCUT2nZbL+t0VH0xvPgBXUTo7jEhhJ9qQFNW7/ZCDj3QFmvgL4uz3k94TvMbCKMJTdBSA==
X-Received: by 2002:a05:6820:248c:b0:5b2:8deb:98cb with SMTP id
 006d021491bc7-5b3299ba504mr4725112eaf.2.1716306358729; 
 Tue, 21 May 2024 08:45:58 -0700 (PDT)
Received: from localhost.localdomain ([75.28.21.198])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5b5390b9c54sm676960eaf.0.2024.05.21.08.45.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 May 2024 08:45:58 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: jonas@kwiboo.se, trini@konsulko.com, kever.yang@rock-chips.com,
 philipp.tomsich@vrull.eu, sjg@chromium.org,
 Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 1/2 V2] Revert "board: rockchip: Add early ADC button detect
 for RGxx3"
Date: Tue, 21 May 2024 10:45:48 -0500
Message-Id: <20240521154549.255607-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240521154549.255607-1-macroalpha82@gmail.com>
References: <20240521154549.255607-1-macroalpha82@gmail.com>
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

From: Chris Morgan <macromorgan@hotmail.com>

This reverts commit 41a60d0e5cef54a59596a58940fa7c9cf071034b.

On some of the supported devices the adc detect code always returns
that the button has been pushed, and as a result the device will
not boot normally.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c | 64 ----------------------
 1 file changed, 64 deletions(-)

diff --git a/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c b/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
index 099eea60c3..5c57b902d1 100644
--- a/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
+++ b/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
@@ -6,14 +6,12 @@
 #include <abuf.h>
 #include <adc.h>
 #include <asm/io.h>
-#include <command.h>
 #include <display.h>
 #include <dm.h>
 #include <dm/lists.h>
 #include <env.h>
 #include <fdt_support.h>
 #include <linux/delay.h>
-#include <linux/iopoll.h>
 #include <mipi_dsi.h>
 #include <mmc.h>
 #include <panel.h>
@@ -21,8 +19,6 @@
 #include <stdlib.h>
 #include <video_bridge.h>
 
-#define BOOT_BROM_DOWNLOAD	0xef08a53c
-
 #define GPIO0_BASE		0xfdd60000
 #define GPIO4_BASE		0xfe770000
 #define GPIO_SWPORT_DR_L	0x0000
@@ -36,14 +32,6 @@
 
 #define GPIO_WRITEMASK(bits)	((bits) << 16)
 
-#define SARADC_BASE		0xfe720000
-#define SARADC_DATA		0x0000
-#define SARADC_STAS		0x0004
-#define SARADC_ADC_STATUS	BIT(0)
-#define SARADC_CTRL		0x0008
-#define SARADC_INPUT_SRC_MSK	0x7
-#define SARADC_POWER_CTRL	BIT(3)
-
 #define DTB_DIR			"rockchip/"
 
 struct rg3xx_model {
@@ -169,64 +157,12 @@ static const struct rg353_panel rg353_panel_details[] = {
 	},
 };
 
-/*
- * The device has internal eMMC, and while some devices have an exposed
- * clk pin you can ground to force a bypass not all devices do. As a
- * result it may be possible for some devices to become a perma-brick
- * if a corrupted TPL or SPL stage with a valid header is flashed to
- * the internal eMMC. Add functionality to read ADC channel 0 (the func
- * button) as early as possible in the boot process to provide some
- * protection against this. If we ever get an open TPL stage, we should
- * consider moving this function there.
- */
-void read_func_button(void)
-{
-	int ret;
-	u32 reg;
-
-	/* Turn off SARADC to reset it. */
-	writel(0, (SARADC_BASE + SARADC_CTRL));
-
-	/* Enable channel 0 and power on SARADC. */
-	writel(((0 & SARADC_INPUT_SRC_MSK) | SARADC_POWER_CTRL),
-	       (SARADC_BASE + SARADC_CTRL));
-
-	/*
-	 * Wait for data to be ready. Use timeout of 20000us from
-	 * rockchip_saradc driver.
-	 */
-	ret = readl_poll_timeout((SARADC_BASE + SARADC_STAS), reg,
-				 !(reg & SARADC_ADC_STATUS), 20000);
-	if (ret) {
-		printf("ADC Timeout");
-		return;
-	}
-
-	/* Read the data from the SARADC. */
-	reg = readl((SARADC_BASE + SARADC_DATA));
-
-	/* Turn the SARADC back off so it's ready to be used again. */
-	writel(0, (SARADC_BASE + SARADC_CTRL));
-
-	/*
-	 * If the value is less than 30 the button is being pressed.
-	 * Reset the device back into Rockchip download mode.
-	 */
-	if (reg <= 30) {
-		printf("download key pressed, entering download mode...");
-		writel(BOOT_BROM_DOWNLOAD, CONFIG_ROCKCHIP_BOOT_MODE_REG);
-		do_reset(NULL, 0, 0, NULL);
-	}
-};
-
 /*
  * Start LED very early so user knows device is on. Set color
  * to red.
  */
 void spl_board_init(void)
 {
-	read_func_button();
-
 	/* Set GPIO0_C5, GPIO0_C6, and GPIO0_C7 to output. */
 	writel(GPIO_WRITEMASK(GPIO_C7 | GPIO_C6 | GPIO_C5) | \
 	       (GPIO_C7 | GPIO_C6 | GPIO_C5),
-- 
2.34.1

