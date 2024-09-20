Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF86FCF9C68
	for <u-boot@archiver.kernel.org>; Sat, 21 Sep 2024 02:37:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B428488641;
	Sat, 21 Sep 2024 04:37:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XcZyo6w0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41E488785E; Sat, 21 Sep 2024 00:51:52 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5189E8785E
 for <u-boot@lists.denx.de>; Sat, 21 Sep 2024 00:51:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3787f30d892so1525858f8f.0
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 15:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726872710; x=1727477510; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aSDQmEUlpD2H4DUe5lM8yl+oX9bOA/Q8yS2GRmz3Xpw=;
 b=XcZyo6w0xKxIs6zS74E/cynXq1/m3rzr2SjLseQx1tqMOe57SZUtsGsebv3Pun15VG
 qryp6Z7QtfoGhZiHdaVwNpIM4XXx8mIsDYxOQy2a+hSZLBE0+fR7zNnjdzfEsD0x5EKv
 N/i/5P4fKYwgLQ++LMbn5fVVJ/hrOKnFRkIjigoJkTDUebnKZiLlErkU/VCoYlnWkkDz
 /8I/GZNc5UzLvbdojS1DoK2a7/4AKn2QAJUBNTS05Rg5kSNwgloqgmiJNFW/PKOigEcx
 IrwoA0TeVc3oUIlij7j05wu0HiS9RysV3J9PfMr371GPX47rDkCnkHvkwD0yBhlzlgcD
 JBqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726872710; x=1727477510;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aSDQmEUlpD2H4DUe5lM8yl+oX9bOA/Q8yS2GRmz3Xpw=;
 b=qcfIaPwz+ID6hub1diCTpNW5Lpo8tpF6g7cz6TEpBzxXpL283lvNtMP5ZF04xKJt8l
 8R7LATtwpmNjgpfPmOuKzvRPMszfrETpXGoHcjs1GubZgLylrKFdWi+3sDW5xsr/Jfio
 DLpIAHGExVSPx/MmYmrc/Z8hxp3h5Jk02EdgNgJ2GaV5/iKc9WPW+4ITMnWBYgvTJGU0
 3sAI8EZDsm/IJShYve8RHFIXasetx8/0QhCrPLI6ie+iTUMx7GHPEevV1dcd7PI/Mlhq
 DOjFh1p7vYwQuF1YtmRTg8m4riLJWuA3CgTMPDJOcoYB/cdwJ8CAHq74EVi6xcEZbIQl
 XjWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJJLoC+oBKj84m9YEu3Y57PEnCa56c8H7oyKGOMz50DwNmkwaxgu1sKduS29t7E2JKfJGq6XM=@lists.denx.de
X-Gm-Message-State: AOJu0YziT8cMregyn4xA7nxhBcCHTjWcfDhj2fHtkVMygFOkAUU5CyV2
 u8t0FKSoZTPbjm0bavhPjHE4gsnwDw4sEVi0wF49QuizuZa8urO5
X-Google-Smtp-Source: AGHT+IG6uf7GpUrY1J/g3OK7QlZm5f8yH+T+93pEDgm/8mxJKJWMirdegbm6IEggEXRvcHk1M6B6qg==
X-Received: by 2002:adf:f688:0:b0:36b:c126:fe6d with SMTP id
 ffacd0b85a97d-37a4227839emr2466851f8f.24.1726872709392; 
 Fri, 20 Sep 2024 15:51:49 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-378e73e837csm18850516f8f.27.2024.09.20.15.51.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 15:51:48 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Sean Anderson <seanga2@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Yang Xiwen <forbidden405@outlook.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>, Heiko Schocher <hs@denx.de>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Martin Kurbanov <mmkurbanov@salutedevices.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Artur Rojek <artur@conclusive.pl>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Vasileios Amoiridis <vassilisamir@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Doug Zobel <douglas.zobel@climate.com>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de, John Crispin <john@phrozen.org>
Subject: [PATCH v4 04/11] common: board_r: rework BOOT LED handling
Date: Sat, 21 Sep 2024 00:49:57 +0200
Message-ID: <20240920225101.2008-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240920225101.2008-1-ansuelsmth@gmail.com>
References: <20240920225101.2008-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 21 Sep 2024 04:37:11 +0200
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

