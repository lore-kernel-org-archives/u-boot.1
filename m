Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B3A4CF394B
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 16:44:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25BCE807C0;
	Wed, 19 Nov 2025 17:44:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19F9E807C0; Wed, 19 Nov 2025 17:44:20 +0100 (CET)
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch
 [185.125.25.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71B678312A
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 17:44:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246b])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dBS4K1FFgzlr8;
 Wed, 19 Nov 2025 17:44:17 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4dBS4J0GSxz8tF; Wed, 19 Nov 2025 17:44:16 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 19 Nov 2025 17:43:45 +0100
Subject: [PATCH 1/5] led: remove code guarded by always false conditions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-legacy-led-unused-code-v1-1-bc0ae1235baa@cherry.de>
References: <20251119-legacy-led-unused-code-v1-0-bc0ae1235baa@cherry.de>
In-Reply-To: <20251119-legacy-led-unused-code-v1-0-bc0ae1235baa@cherry.de>
To: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Raymond Mao <raymondmaoca@gmail.com>, 
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Alexander Graf <agraf@csgraf.de>, Peter Robinson <pbrobinson@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Weijie Gao <hackpascal@gmail.com>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alvin@pqrs.dk>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Max Merchel <Max.Merchel@ew.tq-group.com>, Mario Six <mario.six@gdsys.cc>, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>, 
 Sinan Akman <sinan@writeme.com>, Jesse Taube <mr.bossman075@gmail.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.3
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

The last CONFIG_MVS in code was removed almost 12 years ago in commit
3b98b57fa796 ("include: delete unused header files").

STATUS_LED_PAR was last seen 8 years ago when removed in commit
5b8e76c35ec3 ("powerpc, 8xx: remove support for 8xx").

If CONFIG_LED_STATUS_BOARD_SPECIFIC is not defined, the build will fail
so we won't even reach this part of the code.

Let's simplify the if block to actually possible configurations.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 include/status_led.h | 23 +----------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

diff --git a/include/status_led.h b/include/status_led.h
index 1282022253e..56d519f6d53 100644
--- a/include/status_led.h
+++ b/include/status_led.h
@@ -46,23 +46,7 @@ static inline void status_led_boot_blink(void)
 #endif
 }
 
-/*****  MVS v1  **********************************************************/
-#if (defined(CONFIG_MVS) && CONFIG_MVS < 2)
-# define STATUS_LED_PAR		im_ioport.iop_pdpar
-# define STATUS_LED_DIR		im_ioport.iop_pddir
-# undef  STATUS_LED_ODR
-# define STATUS_LED_DAT		im_ioport.iop_pddat
-
-# define STATUS_LED_ACTIVE	1		/* LED on for bit == 1	*/
-
-/*****  Someone else defines these  *************************************/
-#elif defined(STATUS_LED_PAR)
-  /*
-   * ADVICE: Define in your board configuration file rather than
-   * filling this file up with lots of custom board stuff.
-   */
-
-#elif defined(CONFIG_LED_STATUS_BOARD_SPECIFIC)
+#if defined(CONFIG_LED_STATUS_BOARD_SPECIFIC)
 /* led_id_t is unsigned long mask */
 typedef unsigned long led_id_t;
 
@@ -73,11 +57,6 @@ void __led_blink(led_id_t mask, int freq);
 #else
 # error Status LED configuration missing
 #endif
-/************************************************************************/
-
-#ifndef CONFIG_LED_STATUS_BOARD_SPECIFIC
-# include <asm/status_led.h>
-#endif
 
 #else
 

-- 
2.51.1

