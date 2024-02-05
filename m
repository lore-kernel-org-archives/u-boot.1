Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3779C48292
	for <u-boot@archiver.kernel.org>; Mon,  5 Feb 2024 18:59:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EBF187C31;
	Mon,  5 Feb 2024 19:59:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dBKVLWHe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88177879AF; Mon,  5 Feb 2024 19:59:07 +0100 (CET)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3108687B7F
 for <u-boot@lists.denx.de>; Mon,  5 Feb 2024 19:59:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3be62ccda4bso3137646b6e.1
 for <u-boot@lists.denx.de>; Mon, 05 Feb 2024 10:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707159542; x=1707764342; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NF3zWNunKud42g0C4Mea5oYODa0T72jE9pBWBZ/3gN8=;
 b=dBKVLWHe8L2QTo2HezohZT4N7ZAuZ3DfJkHoC28mZ5Tyis+qEUpFcVSzHbRCB1Q9qv
 8InGtx1v2Co8V/+u7H23/C7RNGX9aKGJejUOtIJxzc59JAGr1WWZN+n4ZqEm0UoXzs2S
 y4eB2FHUmPRwe1juEfK0my2btzv1/nwvah/5oyK/pdoQpjWfk6N2E41rAV4821RCa+7/
 xVEUhsP/aI9OHEoDMRVLVHwB8wwyw04yzSiQSOss2O+KQ43H71K0N4IGgggzy5Xw5OXR
 N4p/2PEBQJuOVZ7UWnTEJF0Gu8yoOEu+U9NsPFgCGkeaAz0dSx+khMNSpkwxdiI5rpsv
 NP/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707159542; x=1707764342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NF3zWNunKud42g0C4Mea5oYODa0T72jE9pBWBZ/3gN8=;
 b=h6Y3JIOFjhsXEMN1XTqtmNxdOOWdGxVg7r6C+7ZAKGX/h+2BgeVtrcEqJJqbbRIlTG
 MXcmF3oJ5RfQVWRF+enn/GHIE8murQoYRVZA9Nk9bwRQF9wiEV1g4oO53NC6DCCdOvSO
 t/kJEx/Lx9mQ3Cf7ilKqibxsb+VwrHhx+M/mpQUXnTZBQc7WXlEVGb85IWtjkVTNYDwE
 alQBNiiBubXTWEgaGyADg1iq5iZKjgYbt2p0pHfCqzs0EHpvvNwnzMz/zjpLUyFMao7g
 HKHVTkIlPOFnzeV1eMdfYviAtvKs7zTVb3ucpIpIAAWNja/6GRDX0zD8a2Ym8WDh9TEo
 Ytpg==
X-Gm-Message-State: AOJu0YwbESP4nN2189pCrQDSZZ290T7tqGTAIXJz5+A6wkAK9aH6gfXH
 rLQrbMVyjmUKmfjVIk4eFP3gVunbTJ1WCNq+bEcWB0JQVEhWV+ANM8elLI+L
X-Google-Smtp-Source: AGHT+IEshIzmafpUiwzD6oMxawF9Ee6Glvpk0Ybq+o06AIyvASM6SYEInqlVcD0+78rmVqik1dQdjw==
X-Received: by 2002:a05:6808:178d:b0:3be:b23a:8509 with SMTP id
 bg13-20020a056808178d00b003beb23a8509mr819422oib.1.1707159542524; 
 Mon, 05 Feb 2024 10:59:02 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXKryRqX55beo3Te9XJxez/g9G2ZipihT3Tu3/rZC8W0JvfS6n30OSJUCfOTcsxkU+mHXMTfPVG25BPnT5KY4KmjfwkLFRpPAyndghEC/ZL+cKGX5O4ph9dOK2FOhz1Eb2aSzm3nfXnI0+j8PjNKWJBtbH3O63lNbzQYthiJvkJgZOaiySC2jMBXA5qRnXbtEpEU8VySkIMDI2Mk+eonizn
Received: from localhost.localdomain ([75.28.21.198])
 by smtp.gmail.com with ESMTPSA id
 cn22-20020a056808351600b003bfdfc7e5d6sm65692oib.42.2024.02.05.10.59.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Feb 2024 10:59:02 -0800 (PST)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: kever.yang@rock-chips.com, philipp.tomsich@vrull.eu, sjg@chromium.org,
 jonas@kwiboo.se, jagan@amarulasolutions.com,
 Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 4/4] board: rockchip: Add early ADC button detect for RGxx3
Date: Mon,  5 Feb 2024 12:58:55 -0600
Message-Id: <20240205185855.21508-5-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205185855.21508-1-macroalpha82@gmail.com>
References: <20240205185855.21508-1-macroalpha82@gmail.com>
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

Add ADC button detect for early SPL stage for RGxx3 device. This is
important because on at least the RG353P and RG353V a clk pin is not
exposed that would allow us to take the eMMC out of the boot path.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c | 64 ++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c b/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
index 5c57b902d1..099eea60c3 100644
--- a/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
+++ b/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
@@ -6,12 +6,14 @@
 #include <abuf.h>
 #include <adc.h>
 #include <asm/io.h>
+#include <command.h>
 #include <display.h>
 #include <dm.h>
 #include <dm/lists.h>
 #include <env.h>
 #include <fdt_support.h>
 #include <linux/delay.h>
+#include <linux/iopoll.h>
 #include <mipi_dsi.h>
 #include <mmc.h>
 #include <panel.h>
@@ -19,6 +21,8 @@
 #include <stdlib.h>
 #include <video_bridge.h>
 
+#define BOOT_BROM_DOWNLOAD	0xef08a53c
+
 #define GPIO0_BASE		0xfdd60000
 #define GPIO4_BASE		0xfe770000
 #define GPIO_SWPORT_DR_L	0x0000
@@ -32,6 +36,14 @@
 
 #define GPIO_WRITEMASK(bits)	((bits) << 16)
 
+#define SARADC_BASE		0xfe720000
+#define SARADC_DATA		0x0000
+#define SARADC_STAS		0x0004
+#define SARADC_ADC_STATUS	BIT(0)
+#define SARADC_CTRL		0x0008
+#define SARADC_INPUT_SRC_MSK	0x7
+#define SARADC_POWER_CTRL	BIT(3)
+
 #define DTB_DIR			"rockchip/"
 
 struct rg3xx_model {
@@ -157,12 +169,64 @@ static const struct rg353_panel rg353_panel_details[] = {
 	},
 };
 
+/*
+ * The device has internal eMMC, and while some devices have an exposed
+ * clk pin you can ground to force a bypass not all devices do. As a
+ * result it may be possible for some devices to become a perma-brick
+ * if a corrupted TPL or SPL stage with a valid header is flashed to
+ * the internal eMMC. Add functionality to read ADC channel 0 (the func
+ * button) as early as possible in the boot process to provide some
+ * protection against this. If we ever get an open TPL stage, we should
+ * consider moving this function there.
+ */
+void read_func_button(void)
+{
+	int ret;
+	u32 reg;
+
+	/* Turn off SARADC to reset it. */
+	writel(0, (SARADC_BASE + SARADC_CTRL));
+
+	/* Enable channel 0 and power on SARADC. */
+	writel(((0 & SARADC_INPUT_SRC_MSK) | SARADC_POWER_CTRL),
+	       (SARADC_BASE + SARADC_CTRL));
+
+	/*
+	 * Wait for data to be ready. Use timeout of 20000us from
+	 * rockchip_saradc driver.
+	 */
+	ret = readl_poll_timeout((SARADC_BASE + SARADC_STAS), reg,
+				 !(reg & SARADC_ADC_STATUS), 20000);
+	if (ret) {
+		printf("ADC Timeout");
+		return;
+	}
+
+	/* Read the data from the SARADC. */
+	reg = readl((SARADC_BASE + SARADC_DATA));
+
+	/* Turn the SARADC back off so it's ready to be used again. */
+	writel(0, (SARADC_BASE + SARADC_CTRL));
+
+	/*
+	 * If the value is less than 30 the button is being pressed.
+	 * Reset the device back into Rockchip download mode.
+	 */
+	if (reg <= 30) {
+		printf("download key pressed, entering download mode...");
+		writel(BOOT_BROM_DOWNLOAD, CONFIG_ROCKCHIP_BOOT_MODE_REG);
+		do_reset(NULL, 0, 0, NULL);
+	}
+};
+
 /*
  * Start LED very early so user knows device is on. Set color
  * to red.
  */
 void spl_board_init(void)
 {
+	read_func_button();
+
 	/* Set GPIO0_C5, GPIO0_C6, and GPIO0_C7 to output. */
 	writel(GPIO_WRITEMASK(GPIO_C7 | GPIO_C6 | GPIO_C5) | \
 	       (GPIO_C7 | GPIO_C6 | GPIO_C5),
-- 
2.34.1

