Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AAADC87FCB
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 17:51:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6941E8392E;
	Tue,  5 Aug 2025 19:51:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCAD484189; Tue,  5 Aug 2025 19:51:39 +0200 (CEST)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4B9683885
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 19:51:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paulk@sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id 3A9E71F0003D
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 17:51:36 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id BF762B011EB; Tue,  5 Aug 2025 17:51:35 +0000 (UTC)
Received: from localhost.localdomain (unknown [192.168.1.64])
 by laika.paulk.fr (Postfix) with ESMTP id BD1FBB011EC;
 Tue,  5 Aug 2025 17:48:29 +0000 (UTC)
From: Paul Kocialkowski <paulk@sys-base.io>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Chen-Yu Tsai <wens@csie.org>,
 Icenowy Zheng <icenowy@aosc.xyz>, Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH v2 06/11] sunxi: Add support for I2C1 on PB pins for the V3/V3s
Date: Tue,  5 Aug 2025 19:48:22 +0200
Message-ID: <20250805174827.3696191-7-paulk@sys-base.io>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250805174827.3696191-1-paulk@sys-base.io>
References: <20250805174827.3696191-1-paulk@sys-base.io>
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

From: Paul Kocialkowski <contact@paulk.fr>

Both the V3 and V3s support I2C1 on PB pins, which is often used to
connect an AXP209 PMIC on V3 boards.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 board/sunxi/board.c  | 4 ++++
 include/sunxi_gpio.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/board/sunxi/board.c b/board/sunxi/board.c
index 6520636ffab5..72aa86cd752d 100644
--- a/board/sunxi/board.c
+++ b/board/sunxi/board.c
@@ -98,6 +98,10 @@ void i2c_init_board(void)
 	sunxi_gpio_set_cfgpin(SUNXI_GPH(16), SUN6I_GPH_TWI1);
 	sunxi_gpio_set_cfgpin(SUNXI_GPH(17), SUN6I_GPH_TWI1);
 	clock_twi_onoff(1, 1);
+#elif defined(CONFIG_MACH_SUN8I_V3_V3S)
+	sunxi_gpio_set_cfgpin(SUNXI_GPB(8), SUN8I_V3S_GPB_TWI1);
+	sunxi_gpio_set_cfgpin(SUNXI_GPB(9), SUN8I_V3S_GPB_TWI1);
+	clock_twi_onoff(1, 1);
 #elif defined(CONFIG_MACH_SUN8I)
 	sunxi_gpio_set_cfgpin(SUNXI_GPH(4), SUN8I_GPH_TWI1);
 	sunxi_gpio_set_cfgpin(SUNXI_GPH(5), SUN8I_GPH_TWI1);
diff --git a/include/sunxi_gpio.h b/include/sunxi_gpio.h
index 12b54c8dda4d..e166b9758f44 100644
--- a/include/sunxi_gpio.h
+++ b/include/sunxi_gpio.h
@@ -110,6 +110,7 @@ enum sunxi_gpio_number {
 #define SUN4I_GPB_TWI1		2
 #define SUN5I_GPB_TWI1		2
 #define SUN8I_V3S_GPB_TWI0	2
+#define SUN8I_V3S_GPB_TWI1	2
 #define SUN4I_GPB_UART0		2
 #define SUN5I_GPB_UART0		2
 #define SUN8I_GPB_UART2		2
-- 
2.49.0

