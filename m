Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6E91D0E6F7
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 11:39:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D579688FC4;
	Mon, 21 Oct 2024 13:39:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Vz5RLwbV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A512D88EE8; Mon, 21 Oct 2024 13:38:58 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1302889AE
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 13:38:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5c94b0b466cso4985707a12.0
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 04:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729510736; x=1730115536; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KUqrnha8r/+ll18/Hs3mg5HiovtfGf/ibQh4Ztzq/7I=;
 b=Vz5RLwbVEXMhTFsJECyqkuoex0wxnKTIFy9Oa8swcCpCV1rz0pENkt4F7K6KVXU5XP
 p6v6AHV0Qh0VcqAGl6HLNVuZBEfc8mDkqhrswsvikq5znW4+PNQTv4eWmBOSuQZy35g0
 vMEB8LYhZuzb2JtMpESbaKliy9EPkkI16jbxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729510736; x=1730115536;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KUqrnha8r/+ll18/Hs3mg5HiovtfGf/ibQh4Ztzq/7I=;
 b=gZQSX5RVnDZ4jS+U5twJn66dZvyK8msCTZu6YCkyNYUTkhhZRgvDusLOQzeSea6Ctp
 TXh/JLxIJp7sPGuA5f4U2zQfSiB6riBWhd9fidhSjuUGYUbujm83nf3PRxosA1BMwk7v
 G+uxoBhIJ3uKrtahh+MihpFWY8jiH7WbsjZUXTDN78ir5uPjLFHVID08PSmw2j41Cezp
 Pdepn4F4QTYiaPlERtuyvHVoghOxdcBrDIl3mw/tlIY90qJhtYaHN8fIpVa5ULT0WsDW
 GWnsu5cqfC2Vy3czyO5JoYH4kCU5jH7Z7I5O5p9kBw4rcthB4c8WIWCpVcGsB93ZnMMG
 nAIQ==
X-Gm-Message-State: AOJu0Yzyj9aLXyZHkiNco+krgy6cpkpxebZhoxLN/EAet+H7/vujQg6R
 ERTG3sMX2dq2x3KRE7KhSchMK2eHNaLZcqtBMlx57RF6GqSYkDWxzrIeF/UNd07f9viFpvRpV3n
 E7GsA
X-Google-Smtp-Source: AGHT+IFUakIOtO2bN9QW9DiWFV/Uc9W5v7hE6BFXisbw/cM32ON+20TCN+hfhfxnem3DNHO/zLKKCw==
X-Received: by 2002:a17:907:9303:b0:a99:7539:2458 with SMTP id
 a640c23a62f3a-a9a69cdab98mr947825866b.65.1729510735616; 
 Mon, 21 Oct 2024 04:38:55 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a91571ea5sm191604366b.160.2024.10.21.04.38.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 04:38:55 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Doug Zobel <douglas.zobel@climate.com>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH v2 06/25] led: Drop LED_STATUS_BOARD_SPECIFIC
Date: Mon, 21 Oct 2024 13:38:14 +0200
Message-ID: <20241021113839.318572-7-sjg@chromium.org>
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

This is not used by any board and there is a driver model version of
LEDs. Drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 cmd/legacy_led.c     | 40 ----------------------------------------
 drivers/led/Kconfig  |  6 ------
 include/status_led.h | 13 +------------
 3 files changed, 1 insertion(+), 58 deletions(-)

diff --git a/cmd/legacy_led.c b/cmd/legacy_led.c
index 50de7e89d8f..ef2135e0dba 100644
--- a/cmd/legacy_led.c
+++ b/cmd/legacy_led.c
@@ -24,26 +24,6 @@ struct led_tbl_s {
 typedef struct led_tbl_s led_tbl_t;
 
 static const led_tbl_t led_commands[] = {
-#ifdef CONFIG_LED_STATUS_BOARD_SPECIFIC
-#ifdef CONFIG_LED_STATUS0
-	{ "0", CONFIG_LED_STATUS_BIT, NULL, NULL, NULL },
-#endif
-#ifdef CONFIG_LED_STATUS1
-	{ "1", CONFIG_LED_STATUS_BIT1, NULL, NULL, NULL },
-#endif
-#ifdef CONFIG_LED_STATUS2
-	{ "2", CONFIG_LED_STATUS_BIT2, NULL, NULL, NULL },
-#endif
-#ifdef CONFIG_LED_STATUS3
-	{ "3", CONFIG_LED_STATUS_BIT3, NULL, NULL, NULL },
-#endif
-#ifdef CONFIG_LED_STATUS4
-	{ "4", CONFIG_LED_STATUS_BIT4, NULL, NULL, NULL },
-#endif
-#ifdef CONFIG_LED_STATUS5
-	{ "5", CONFIG_LED_STATUS_BIT5, NULL, NULL, NULL },
-#endif
-#endif
 #ifdef CONFIG_LED_STATUS_GREEN
 	{ "green", CONFIG_LED_STATUS_GREEN, green_led_off, green_led_on, NULL },
 #endif
@@ -148,26 +128,6 @@ int do_legacy_led(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 U_BOOT_CMD(
 	led, 4, 1, do_legacy_led,
 	"["
-#ifdef CONFIG_LED_STATUS_BOARD_SPECIFIC
-#ifdef CONFIG_LED_STATUS0
-	"0|"
-#endif
-#ifdef CONFIG_LED_STATUS1
-	"1|"
-#endif
-#ifdef CONFIG_LED_STATUS2
-	"2|"
-#endif
-#ifdef CONFIG_LED_STATUS3
-	"3|"
-#endif
-#ifdef CONFIG_LED_STATUS4
-	"4|"
-#endif
-#ifdef CONFIG_LED_STATUS5
-	"5|"
-#endif
-#endif
 #ifdef CONFIG_LED_STATUS_GREEN
 	"green|"
 #endif
diff --git a/drivers/led/Kconfig b/drivers/led/Kconfig
index c98cbf92fab..268118a6c3a 100644
--- a/drivers/led/Kconfig
+++ b/drivers/led/Kconfig
@@ -166,12 +166,6 @@ config LED_STATUS_GPIO
 	  The status LED can be connected to a GPIO pin. In such cases, the
 	  gpio_led driver can be used as a status LED backend implementation.
 
-config LED_STATUS_BOARD_SPECIFIC
-	bool "Specific board"
-	default y
-	help
-	  LED support is only for a specific board.
-
 comment "LEDs parameters"
 
 config LED_STATUS0
diff --git a/include/status_led.h b/include/status_led.h
index 1282022253e..59cf9f89956 100644
--- a/include/status_led.h
+++ b/include/status_led.h
@@ -61,23 +61,12 @@ static inline void status_led_boot_blink(void)
    * ADVICE: Define in your board configuration file rather than
    * filling this file up with lots of custom board stuff.
    */
-
-#elif defined(CONFIG_LED_STATUS_BOARD_SPECIFIC)
-/* led_id_t is unsigned long mask */
-typedef unsigned long led_id_t;
-
-extern void __led_toggle (led_id_t mask);
-extern void __led_init (led_id_t mask, int state);
-extern void __led_set (led_id_t mask, int state);
-void __led_blink(led_id_t mask, int freq);
 #else
 # error Status LED configuration missing
 #endif
 /************************************************************************/
 
-#ifndef CONFIG_LED_STATUS_BOARD_SPECIFIC
-# include <asm/status_led.h>
-#endif
+#include <asm/status_led.h>
 
 #else
 
-- 
2.43.0

