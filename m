Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EADCCDE03A
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 20:47:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 662C388363;
	Thu, 26 Sep 2024 22:47:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="n5dNDZJx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E21688D63; Thu, 26 Sep 2024 22:47:39 +0200 (CEST)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27CE38806A
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 22:47:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-4585721f6edso8847621cf.2
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 13:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727383656; x=1727988456; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8AuXWoANLB+LWEL8cSz8dz3ZeOjGtWVdxqyK1y3liXI=;
 b=n5dNDZJxxKpidDRRnszxFHbbJoyaMxF1vnUwrD6sYkvubX7g3mtuWLC9gDytS77UXh
 xY8tqp2i35gIlLMVs3aSUe+PBteUJR3YR/S1vhDwzf+p7SCPnlumCzFd1nWSQD0f2mjg
 jg0MgDsJDFUfn4oM0HzVLiaVlRPDMe35hQYVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727383656; x=1727988456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8AuXWoANLB+LWEL8cSz8dz3ZeOjGtWVdxqyK1y3liXI=;
 b=R8YLyjfjeCgFu78ApM5j1TxCb6g4XTt+uQPYyM+ULdBr/jLXgaOzOvFLFAhOL4WstK
 PCMrsocGDXczvLfZwCEvE36SEzip6fsrm4KV3JSAooZ84VQ63vZkUPrJ3QksLTaUCsok
 4RPm42O0kTdQ2neMQjS/a5A849Jft0AIEVoFa+ri7EUuza50wl2SCSTscOyTlJaOPsmL
 z7cscE/qLnM4qNEC2naVZYJJjHWyQv3pWdWozxarIUxfbE5SM9EeDbIf6Xaq623ZhOC9
 fZjN+twkqsaOyZiuAe2duNlNyM7yIbBbK7A1GuN10Yyn0jjY/5XCHZtV+9QhQ5wUEPke
 TfCA==
X-Gm-Message-State: AOJu0YxJX/wuiY+vDhcKMsSgf2KOLWx5Zg18AKd8Zd+OuUGB4ZWm/uQg
 3+G4iJcXlvxheDw/Hen+vZ/OwuIGlVyjcy52l63+xurgyWLCSmVeGJR/5bWAZxVxDGu3oCx7wGh
 XPgk2BR8=
X-Google-Smtp-Source: AGHT+IHA/Rub4qcXOE570taCDNohungd59jH4cgEhAH9asCgI1nEguacn/gbWCgMG+HkTR1rXpg1+Q==
X-Received: by 2002:a05:6214:3b86:b0:6c5:5088:e39a with SMTP id
 6a1803df08f44-6cb3b5fae96mr12295676d6.29.1727383655904; 
 Thu, 26 Sep 2024 13:47:35 -0700 (PDT)
Received: from chromium.org ([205.220.129.31])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cb3b66cff5sm2538696d6.77.2024.09.26.13.47.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 13:47:35 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Doug Zobel <douglas.zobel@climate.com>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH 01/27] led: Drop LED_STATUS_BOARD_SPECIFIC
Date: Thu, 26 Sep 2024 22:44:21 +0200
Message-ID: <20240926204455.963584-2-sjg@chromium.org>
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

This is not used by any board and there is a driver model version of
LEDs. Drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

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
index bee74b25751..5c401f92080 100644
--- a/drivers/led/Kconfig
+++ b/drivers/led/Kconfig
@@ -142,12 +142,6 @@ config LED_STATUS_GPIO
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
index 6707ab1d29d..3d118af0d8b 100644
--- a/include/status_led.h
+++ b/include/status_led.h
@@ -54,23 +54,12 @@ void status_led_set(int led, int state);
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
 
 #endif	/* CONFIG_LED_STATUS	*/
 
-- 
2.43.0

