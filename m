Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31BB4C87FD1
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 17:52:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D68483923;
	Tue,  5 Aug 2025 19:52:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F9E0841B7; Tue,  5 Aug 2025 19:52:01 +0200 (CEST)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41FBD83885
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 19:51:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paulk@sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id 7A25C1F0004B
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 17:51:58 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id E7696B011EC; Tue,  5 Aug 2025 17:51:57 +0000 (UTC)
Received: from localhost.localdomain (unknown [192.168.1.64])
 by laika.paulk.fr (Postfix) with ESMTP id 00950B011ED;
 Tue,  5 Aug 2025 17:48:29 +0000 (UTC)
From: Paul Kocialkowski <paulk@sys-base.io>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Chen-Yu Tsai <wens@csie.org>,
 Icenowy Zheng <icenowy@aosc.xyz>, Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH v2 07/11] sunxi: Add support for UART1 on PG pins for the V3/S3
Date: Tue,  5 Aug 2025 19:48:23 +0200
Message-ID: <20250805174827.3696191-8-paulk@sys-base.io>
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

The V3/S3 has extra pins for UART1 on PG pins, which are not present
on the V3s. Add support for them and make them the default UART1 pins
on the V3. Note that PE pins are also available for UART1 but almost
never used since they also provide the CSI I2C lines.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 arch/arm/mach-sunxi/board.c | 4 ++++
 include/sunxi_gpio.h        | 1 +
 2 files changed, 5 insertions(+)

diff --git a/arch/arm/mach-sunxi/board.c b/arch/arm/mach-sunxi/board.c
index a1a02b0fae50..d1b27b062d6d 100644
--- a/arch/arm/mach-sunxi/board.c
+++ b/arch/arm/mach-sunxi/board.c
@@ -169,6 +169,10 @@ static int gpio_init(void)
 	sunxi_gpio_set_cfgpin(SUNXI_GPG(3), SUN5I_GPG_UART1);
 	sunxi_gpio_set_cfgpin(SUNXI_GPG(4), SUN5I_GPG_UART1);
 	sunxi_gpio_set_pull(SUNXI_GPG(4), SUNXI_GPIO_PULL_UP);
+#elif CONFIG_CONS_INDEX == 2 && defined(CONFIG_MACH_SUN8I_V3)
+	sunxi_gpio_set_cfgpin(SUNXI_GPG(6), SUN8I_V3_GPG_UART1);
+	sunxi_gpio_set_cfgpin(SUNXI_GPG(7), SUN8I_V3_GPG_UART1);
+	sunxi_gpio_set_pull(SUNXI_GPG(7), SUNXI_GPIO_PULL_UP);
 #elif CONFIG_CONS_INDEX == 3 && defined(CONFIG_MACH_SUN8I_H3)
 	sunxi_gpio_set_cfgpin(SUNXI_GPA(0), SUN8I_H3_GPA_UART2);
 	sunxi_gpio_set_cfgpin(SUNXI_GPA(1), SUN8I_H3_GPA_UART2);
diff --git a/include/sunxi_gpio.h b/include/sunxi_gpio.h
index e166b9758f44..7d142f65ea8a 100644
--- a/include/sunxi_gpio.h
+++ b/include/sunxi_gpio.h
@@ -141,6 +141,7 @@ enum sunxi_gpio_number {
 #define SUN8I_GPG_SDC1		2
 #define SUN8I_GPG_UART1		2
 #define SUN5I_GPG_UART1		4
+#define SUN8I_V3_GPG_UART1	2
 
 #define SUN6I_GPH_PWM		2
 #define SUN8I_GPH_PWM		2
-- 
2.49.0

