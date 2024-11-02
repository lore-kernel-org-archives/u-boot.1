Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FB0AE67816
	for <u-boot@archiver.kernel.org>; Sat,  2 Nov 2024 22:20:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 214EF892E5;
	Sat,  2 Nov 2024 23:20:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="C+NSKCf8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47BCD892C6; Sat,  2 Nov 2024 23:20:48 +0100 (CET)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 762DB89301
 for <u-boot@lists.denx.de>; Sat,  2 Nov 2024 23:20:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7205b6f51f3so2611907b3a.1
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 15:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730586043; x=1731190843; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KUqrnha8r/+ll18/Hs3mg5HiovtfGf/ibQh4Ztzq/7I=;
 b=C+NSKCf88XjlWN35z5rsHgQzir/V8nikHymtKd8+EMqL0dE3y5Hkwf2UoVvwh82E/3
 XojZ9jrN20mR35zZ0uY39VuBlpUE/ksaXuPQ2U/7e8bFcuuZlF/XEqIF7wX9JNZ7LADG
 QXs/aVFZCFP+lsX6fP4Vam0Hihr8G03hxrS/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730586043; x=1731190843;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KUqrnha8r/+ll18/Hs3mg5HiovtfGf/ibQh4Ztzq/7I=;
 b=ZcuoUN3dl3kvixdVB1YTFqgfQDahqkJQ30PDm1N1jMLwAe7frXjHXlXFNua8HOiTCH
 FFEO081Zk4hn+FShT1NqFGe7K4w+qk4AbsXEsTzvTEN5z7IuONbI6aevfkGI6Pf9CPwM
 alV5yL/1l/PZsxTNH7xlFJSICiWSV2TZvy7sYOZE7PiNQ9h95XZrE3cJSA6qNId5km+o
 j7NANTjYel0XWC4mRwPDo6czUlNY+e1nbYH9fEclaMdHERagavZ2xBSa/pXP9uPQ1ScQ
 FoWh0JPlebAGdxkZXOIBncb8cYOfZLjWhoOXIfpv7FUiARWOapElhhrxkqQc3MuA02l2
 VAjw==
X-Gm-Message-State: AOJu0YwbNWNbcieqzyOY8Z4tABWuVH6RSjm0Th+SNaFIKRCLzrdCM72u
 BuLWj5XxXgId8k8Ug+pEIwoxAOThvd3WPgJMGvspwUwrXTl6esahSR4ZLBjA/XzC9k7p97LWKSV
 yKQ==
X-Google-Smtp-Source: AGHT+IFPc+9cmhSnDspBzxXP5y2l4DEf7vysQE3IaaFt25s8rSBlcCo/9M8u5q1lUKyWofPF+NVxoQ==
X-Received: by 2002:a05:6a21:3115:b0:1d2:eb9d:9972 with SMTP id
 adf61e73a8af0-1dba5321ff1mr12000841637.20.1730586043392; 
 Sat, 02 Nov 2024 15:20:43 -0700 (PDT)
Received: from chromium.org ([205.220.129.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee45a0081esm4386286a12.59.2024.11.02.15.20.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 15:20:42 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Doug Zobel <douglas.zobel@climate.com>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH v3 05/25] led: Drop LED_STATUS_BOARD_SPECIFIC
Date: Sat,  2 Nov 2024 16:17:03 -0600
Message-ID: <20241102221737.547938-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241102221737.547938-1-sjg@chromium.org>
References: <20241102221737.547938-1-sjg@chromium.org>
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

