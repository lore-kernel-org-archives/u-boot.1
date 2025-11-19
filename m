Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97122CF396B
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 17:01:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 313B483FA5;
	Wed, 19 Nov 2025 18:01:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85411835C6; Wed, 19 Nov 2025 18:01:22 +0100 (CET)
Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::42ac])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BB7283DA6
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 18:01:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dBSS00ws9zvNG;
 Wed, 19 Nov 2025 18:01:20 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4dBSRz37QgzFPS; Wed, 19 Nov 2025 18:01:19 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 19 Nov 2025 18:01:12 +0100
Subject: [PATCH 1/4] corvus: remove green led support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-corvus-led-red-green-v1-1-ce86b8d59dfc@cherry.de>
References: <20251119-corvus-led-red-green-v1-0-ce86b8d59dfc@cherry.de>
In-Reply-To: <20251119-corvus-led-red-green-v1-0-ce86b8d59dfc@cherry.de>
To: u-boot@lists.denx.de
Cc: Heiko Schocher <hs@nabladev.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Jesse Taube <mr.bossman075@gmail.com>, Raymond Mao <raymondmaoca@gmail.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Eugen Hristev <eugen.hristev@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neha Malcom Francis <n-francis@ti.com>, Fabio Estevam <festevam@gmail.com>, 
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

green_led_on and green_led_off are only called by the legacy LED command
(CONFIG_LED_STATUS_CMD) when CONFIG_LED_STATUS_GREEN is enabled, both of
which aren't enabled for corvus, so let's simply remove it as it's dead
code.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 board/siemens/corvus/board.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/board/siemens/corvus/board.c b/board/siemens/corvus/board.c
index a8714e055d7..670bcab484c 100644
--- a/board/siemens/corvus/board.c
+++ b/board/siemens/corvus/board.c
@@ -53,7 +53,6 @@ static void corvus_request_gpio(void)
 	gpio_request(AT91_PIN_PB18, "SPICS1");
 	gpio_request(AT91_PIN_PB3, "SPICS0");
 	gpio_request(AT91_PIN_PD31, "red led"); /* this is the user1 led */
-	gpio_request(AT91_PIN_PD0, "green led"); /* this is the user2 led */
 }
 
 void red_led_on(void)
@@ -66,16 +65,6 @@ void red_led_off(void)
 	gpio_set_value(AT91_PIN_PD31, 0);
 }
 
-void green_led_on(void)
-{
-	gpio_set_value(AT91_PIN_PD0, 0);
-}
-
-void green_led_off(void)
-{
-	gpio_set_value(AT91_PIN_PD0, 1);
-}
-
 static void corvus_nand_hw_init(void)
 {
 	struct at91_smc *smc = (struct at91_smc *)ATMEL_BASE_SMC;

-- 
2.51.1

