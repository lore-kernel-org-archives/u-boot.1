Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00227CEB2D0
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 13:20:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25642891DE;
	Tue,  1 Oct 2024 15:19:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cXhfXS1W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52911891BC; Tue,  1 Oct 2024 14:25:56 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 833D9891BF
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 14:25:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-42cae4eb026so52615715e9.0
 for <u-boot@lists.denx.de>; Tue, 01 Oct 2024 05:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727785553; x=1728390353; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=H+kMnJtZ98NhnK/hZ42dVvAIDOYZTqyYUYkSYqe08/w=;
 b=cXhfXS1WTGsIk5pulgehEkXlFuYKlz67bIzCg0Zbbh32vgzaVdKUy1ukUX2Slgjoin
 bb02PI8M+4qWxXZnH01/Scq+nfLDUTdeW3W3FmnRBUEj6bfI8AtJHXhsDchASNO0UCp6
 4RKuYmVhr+wwDXPsJU9PSlYTiIcQGVVswNkDqW5zZXz0ZfvyYbXThINs70WZXjrEVNsk
 c0ZBjydpJoYGF+IhFLkKcdmZE91VlgoEwvQInPfKYBFcByCH9MShgn0PBTTvlF+UtPPQ
 GCsuGEZqc3hrOdRi4J4W+l2Zp29lIlYV4Maxxk+qpuxYwM3LZ5GxogBHfe4jXJ4YMYNw
 8h/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727785553; x=1728390353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H+kMnJtZ98NhnK/hZ42dVvAIDOYZTqyYUYkSYqe08/w=;
 b=YHtjnbJMuEkrf8Pg9FCbcoYS+i3f2Vq2crUY5TJned7cJJAscNt1kAaBLSKrhpA53O
 q2bZOyaaFcXGb5dYaTgcf2xaSbEbv/77UuhUUHFcmfnMAaZWNgj6FH9cqCLiCE+l/ed7
 ENYkzAk5Np8JYkdbvq8Qd6eMDFWHXetz0eJnW2DCfRWjjc0WFajdyXaJxZ+Ei7+JHOeX
 4K/tzFq1pDMfID+Os4xHoKFKpS3/n+VNxLTHPkSFaqppfY0ZGWwtu4YzOKdAYv+3zzBq
 99kUR0+Guyuoz7xSCFt/WK7lezsIsV0zg+wcvI1+zjM/XzDXmKIawZQyUuA9iPoSw6Sr
 PLmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrEoQU/R7+f1x37w8W5oqA3JMNYTBsXecEC7Q1dOTGolzp6B7zX/ZFcaypyi9GppMJZdx7Fro=@lists.denx.de
X-Gm-Message-State: AOJu0Yyp7MSlQzobb9ICVhvHvPqTXJ06WEpGtrTREEqcZrkyjEkRPTqD
 3Tghon3KwyBP0fBKsN+ymJ2Lck6cavc8FZHs+oKsJxLlyhFrpoIN
X-Google-Smtp-Source: AGHT+IEkq3sFalZ5xzMPoiyzmVnF1ikKNnhkZMP6i0a3lW9rPVANDpZ7qa3v5NRbK1ByFYNiW4futg==
X-Received: by 2002:a5d:644c:0:b0:37c:c4b4:339e with SMTP id
 ffacd0b85a97d-37cd5acba99mr10355066f8f.25.1727785552584; 
 Tue, 01 Oct 2024 05:25:52 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e94c4sm11646366f8f.62.2024.10.01.05.25.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 05:25:52 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Sean Anderson <seanga2@gmail.com>, Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Alexander Gendin <agendin@matrox.com>,
 Yang Xiwen <forbidden405@outlook.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>, Heiko Schocher <hs@denx.de>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Martin Kurbanov <mmkurbanov@salutedevices.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Artur Rojek <artur@conclusive.pl>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Vasileios Amoiridis <vassilisamir@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Doug Zobel <douglas.zobel@climate.com>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de, John Crispin <john@phrozen.org>
Subject: [PATCH v5 04/11] common: board_r: rework BOOT LED handling
Date: Tue,  1 Oct 2024 14:24:37 +0200
Message-ID: <20241001122511.8832-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241001122511.8832-1-ansuelsmth@gmail.com>
References: <20241001122511.8832-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 01 Oct 2024 15:19:18 +0200
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

Rework BOOT LED handling. There is currently one legacy implementation
for BOOT LED from Status Led API.

This work on ancient implementation used by BOOTP by setting the LED
to Blink on boot and to turn it OFF when the firmware was correctly
received by network.

Now that we new LED implementation have support for LED boot, rework
this by also set the new BOOT LED to blink and also set it to ON before
entering main loop to confirm successful boot.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 common/board_r.c     | 28 ++++++++++++++++++++--------
 include/status_led.h | 13 +++++++++++++
 2 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/common/board_r.c b/common/board_r.c
index d4ba245ac69..c3f8dd5d4ee 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -39,6 +39,7 @@
 #include <initcall.h>
 #include <kgdb.h>
 #include <irq_func.h>
+#include <led.h>
 #include <malloc.h>
 #include <mapmem.h>
 #include <miiphy.h>
@@ -459,17 +460,28 @@ static int initr_malloc_bootparams(void)
 }
 #endif
 
-#if defined(CONFIG_LED_STATUS)
 static int initr_status_led(void)
 {
-#if defined(CONFIG_LED_STATUS_BOOT)
-	status_led_set(CONFIG_LED_STATUS_BOOT, CONFIG_LED_STATUS_BLINKING);
-#else
 	status_led_init();
-#endif
+
+	return 0;
+}
+
+static int initr_boot_led_blink(void)
+{
+	status_led_boot_blink();
+
+	led_boot_blink();
+
+	return 0;
+}
+
+static int initr_boot_led_on(void)
+{
+	led_boot_on();
+
 	return 0;
 }
-#endif
 
 #ifdef CONFIG_CMD_NET
 static int initr_net(void)
@@ -713,9 +725,8 @@ static init_fnc_t init_sequence_r[] = {
 #if defined(CONFIG_MICROBLAZE) || defined(CONFIG_M68K)
 	timer_init,		/* initialize timer */
 #endif
-#if defined(CONFIG_LED_STATUS)
 	initr_status_led,
-#endif
+	initr_boot_led_blink,
 	/* PPC has a udelay(20) here dating from 2002. Why? */
 #ifdef CONFIG_BOARD_LATE_INIT
 	board_late_init,
@@ -738,6 +749,7 @@ static init_fnc_t init_sequence_r[] = {
 #if defined(CFG_PRAM)
 	initr_mem,
 #endif
+	initr_boot_led_on,
 	run_main_loop,
 };
 
diff --git a/include/status_led.h b/include/status_led.h
index 6707ab1d29d..1282022253e 100644
--- a/include/status_led.h
+++ b/include/status_led.h
@@ -39,6 +39,13 @@ void status_led_init(void);
 void status_led_tick(unsigned long timestamp);
 void status_led_set(int led, int state);
 
+static inline void status_led_boot_blink(void)
+{
+#ifdef CONFIG_LED_STATUS_BOOT_ENABLE
+	status_led_set(CONFIG_LED_STATUS_BOOT, CONFIG_LED_STATUS_BLINKING);
+#endif
+}
+
 /*****  MVS v1  **********************************************************/
 #if (defined(CONFIG_MVS) && CONFIG_MVS < 2)
 # define STATUS_LED_PAR		im_ioport.iop_pdpar
@@ -72,6 +79,12 @@ void __led_blink(led_id_t mask, int freq);
 # include <asm/status_led.h>
 #endif
 
+#else
+
+static inline void status_led_init(void) { }
+static inline void status_led_set(int led, int state) { }
+static inline void status_led_boot_blink(void) { }
+
 #endif	/* CONFIG_LED_STATUS	*/
 
 /*
-- 
2.45.2

