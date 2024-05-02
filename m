Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5912AC4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 19:34:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBAC988387;
	Thu,  2 May 2024 21:34:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HIVvUfdD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61AD188313; Thu,  2 May 2024 21:34:18 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3909188373
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 21:34:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3c7498041cfso4771085b6e.2
 for <u-boot@lists.denx.de>; Thu, 02 May 2024 12:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714678455; x=1715283255; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j4Jp1w1P2KOtAdL03/YEfJcuwvGAfgdBTp24XsA9ur8=;
 b=HIVvUfdDyrD0j9jMSLuyYDSaKnAB7AG3iylEf4IOxeoDgA2PAhR+GvLs67g5/EnVkB
 hCdz2FcuT/lm+A5OWHewR1ia2HTUak5dPQgVKrvlfYU91P2NTcB+/6NywnBRfmfPDH3L
 7i8qPTEn6Ci930tCOLh19Qq4ChDDWzucN1im/kb3JanBq1NZVMklczcuoWlHbPaZnpX6
 h1WfIDUYK1ylKtLoIdbS+3F8+WOpFnoZuPusalxxj2nIVK6TR7PlHJBOTS4kNW8MdI0D
 loUCRaGoGGMgyDi0+VQP95Pch1VJ88DDzYe4YGAh4F4bEXdXRxK2DvyVN8VTx0WUbje9
 cwKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714678455; x=1715283255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j4Jp1w1P2KOtAdL03/YEfJcuwvGAfgdBTp24XsA9ur8=;
 b=ljg8Q8zytRjBKvfS3eu+KT7N0Ux2nSzQoTZwe8qZ7VX98E50ZE7Dwk0LVVOJKU0hPc
 DFP4XbLIRABHNSP05vXWf3Hd05+Ur2CyWtvEJ4zst4xluz+BSFQ0QdlrE3zvOWDnK2Sb
 XxqdOG6ODjYbVFtFdo722ICnXg75DhAuBMo3+2AeHOT+RHbLSSCU80HeRX80ERHBVeiQ
 Z72exKBzMOcrEYJZyR6RfcjUFSYBtC3oT2mzbHMCwCCmxrMORI8fBl824dWkPTmVMMVV
 pUzRx/3S3vWcfNcD+UAsD5XSeYM4Zj37PU4QSb8g+kuE0yHcIO7yyPsqMyrAlSRPs3Em
 R+Eg==
X-Gm-Message-State: AOJu0Ywi5D1DJ54kxA/DBW1ySc53KRLyOEZI+ioHS1EcxA1Nz4NEBy0P
 wrdUczXyDS0SNsjbolQt7A+StFmmFaC4J9+D7YR+QVe/FCAMlt+dPHzLQA==
X-Google-Smtp-Source: AGHT+IEU6WoHSw6ppy2xzRFUpL8z5eLsN/yezamUSaBB+Zprq77QNMrX6Rdafeq1YEUo52xrWG8L+Q==
X-Received: by 2002:a05:6808:6295:b0:3c8:6569:5f08 with SMTP id
 du21-20020a056808629500b003c865695f08mr910088oib.27.1714678454688; 
 Thu, 02 May 2024 12:34:14 -0700 (PDT)
Received: from localhost.localdomain ([75.28.21.198])
 by smtp.gmail.com with ESMTPSA id
 ck9-20020a056808250900b003c4f39fb9e7sm252340oib.36.2024.05.02.12.34.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 May 2024 12:34:14 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: dsimic@manjaro.org, jonas@kwiboo.se, trini@konsulko.com,
 kever.yang@rock-chips.com, philipp.tomsich@vrull.eu, sjg@chromium.org,
 Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 1/2] Revert "board: rockchip: Add early ADC button detect for
 RGxx3"
Date: Thu,  2 May 2024 14:34:09 -0500
Message-Id: <20240502193410.1080938-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502193410.1080938-1-macroalpha82@gmail.com>
References: <20240502193410.1080938-1-macroalpha82@gmail.com>
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

