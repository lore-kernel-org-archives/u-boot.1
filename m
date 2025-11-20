Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 741FECF885A
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 13:58:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B4CC83FD3;
	Thu, 20 Nov 2025 14:58:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBCE983D3C; Thu, 20 Nov 2025 13:48:28 +0100 (CET)
Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::bc09])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A53584068
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 13:48:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dBynk0tFZzc23;
 Thu, 20 Nov 2025 13:48:26 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4dBynh5DDQzwJF; Thu, 20 Nov 2025 13:48:24 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Thu, 20 Nov 2025 13:48:05 +0100
Subject: [PATCH 1/2] led: migrate last legacy LED user (olinuxino+net) to
 modern LED framework
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-legacy-led-removal-v1-1-369d44338358@cherry.de>
References: <20251120-legacy-led-removal-v1-0-369d44338358@cherry.de>
In-Reply-To: <20251120-legacy-led-removal-v1-0-369d44338358@cherry.de>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Sean Edmond <seanedmond@microsoft.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, 
 Max Merchel <Max.Merchel@ew.tq-group.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Huan Wang <alison.wang@nxp.com>, 
 Angelo Dureghello <angelo@kernel-space.org>, 
 Enric Balletbo i Serra <eballetbo@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Philip Molloy <philip.molloy@analog.com>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>, 
 Maxim Moskalets <maximmosk4@gmail.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymondmaoca@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Jesse Taube <mr.bossman075@gmail.com>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>, 
 Harsha Vardhan V M <h-vm@ti.com>, briansune <briansune@gmail.com>, 
 Yao Zi <ziyao@disroot.org>, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.3
X-Infomaniak-Routing: alpha
X-Mailman-Approved-At: Thu, 20 Nov 2025 14:58:48 +0100
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

This migrates the last user of the legacy LED API, IMX233-OLinuXino, to
the modern LED framework.

The current implementation does the following:
 - lit the LED when booting,
 - turn off the LED the moment a BOOTP packet is received,

The first step is easily reproduced by using the
/options/u-boot/boot-led property to point at the LED. Unfortunately,
the boot-led is only lit by U-Boot proper at the very end of the boot
process, much later than currently. We can however force the LED on
whenever the GPIO LED driver is bound by marking the LED as
default-state = "on", and this happens slightly before board_init() is
called. We then do not need /options/u-boot/boot-led property for that
anymore.

However, the second step relies on /options/u-boot/boot-led and
CONFIG_LED_BOOT being set to reproduce the same behavior and requires us
to migrate net/bootp.c to the modern LED framework at the same time to
keep bisectability.

I couldn't figure out how to map CONFIG_LED_STATUS_BIT=778 to an actual
GPIO on the SoC but according to the schematics[1] only one LED is
present. I couldn't also map the SoC pin number to an actual GPIO from
the IMX23 manual, but there's already one GPIO LED specified in the
Device Tree so my guess is all of those are one and the same.

This was only build tested as I do not own this device.

[1] https://github.com/OLIMEX/OLINUXINO/blob/master/HARDWARE/iMX233-OLinuXino-Mini/1.%20Latest%20hardware%20revision/iMX233-OLINUXINO-MINI%20hardware%20revision%20E/iMX233-OLINUXINO-MINI_Rev_E.pdf

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 arch/arm/dts/imx23-olinuxino-u-boot.dtsi     | 15 +++++++++++++++
 board/olimex/mx23_olinuxino/mx23_olinuxino.c |  7 -------
 configs/mx23_olinuxino_defconfig             | 12 ++++--------
 net/bootp.c                                  |  8 ++++----
 4 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/arch/arm/dts/imx23-olinuxino-u-boot.dtsi b/arch/arm/dts/imx23-olinuxino-u-boot.dtsi
index dee8433696f..3f2f117b953 100644
--- a/arch/arm/dts/imx23-olinuxino-u-boot.dtsi
+++ b/arch/arm/dts/imx23-olinuxino-u-boot.dtsi
@@ -1,5 +1,20 @@
 // SPDX-License-Identifier: GPL-2.0+
 
+/ {
+	leds {
+		user_led: user {
+			default-state = "on";
+		};
+	};
+
+	options {
+		u-boot {
+			compatible = "u-boot,config";
+			boot-led = <&user_led>;
+		};
+	};
+};
+
 &ssp0 {
 	non-removable;
 };
diff --git a/board/olimex/mx23_olinuxino/mx23_olinuxino.c b/board/olimex/mx23_olinuxino/mx23_olinuxino.c
index b2bb6678c23..78136c1620a 100644
--- a/board/olimex/mx23_olinuxino/mx23_olinuxino.c
+++ b/board/olimex/mx23_olinuxino/mx23_olinuxino.c
@@ -13,9 +13,6 @@
 #include <asm/arch/imx-regs.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/sys_proto.h>
-#ifdef CONFIG_LED_STATUS
-#include <status_led.h>
-#endif
 #include <linux/delay.h>
 
 DECLARE_GLOBAL_DATA_PTR;
@@ -61,9 +58,5 @@ int board_init(void)
 	/* Adress of boot parameters */
 	gd->bd->bi_boot_params = PHYS_SDRAM_1 + 0x100;
 
-#if defined(CONFIG_LED_STATUS) && defined(CONFIG_LED_STATUS_BOOT_ENABLE)
-	status_led_set(CONFIG_LED_STATUS_BOOT, CONFIG_LED_STATUS_STATE);
-#endif
-
 	return 0;
 }
diff --git a/configs/mx23_olinuxino_defconfig b/configs/mx23_olinuxino_defconfig
index 1da18f31344..3df1c8d007d 100644
--- a/configs/mx23_olinuxino_defconfig
+++ b/configs/mx23_olinuxino_defconfig
@@ -8,6 +8,7 @@ CONFIG_NR_DRAM_BANKS=1
 CONFIG_ENV_SIZE=0x4000
 CONFIG_ENV_OFFSET=0x40000
 CONFIG_IMX_CONFIG=""
+CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="imx23-olinuxino"
 CONFIG_TARGET_MX23_OLINUXINO=y
 CONFIG_SPL_SERIAL=y
@@ -38,14 +39,9 @@ CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="uImage"
 CONFIG_VERSION_VARIABLE=y
 CONFIG_MXS_GPIO=y
-CONFIG_LED_STATUS=y
-CONFIG_LED_STATUS_GPIO=y
-CONFIG_LED_STATUS0=y
-CONFIG_LED_STATUS_BIT=778
-CONFIG_LED_STATUS_STATE=2
-CONFIG_LED_STATUS_BOOT_ENABLE=y
-CONFIG_LED_STATUS_BOOT=0
-CONFIG_LED_STATUS_CMD=y
+CONFIG_LED=y
+CONFIG_LED_BOOT=y
+CONFIG_LED_GPIO=y
 CONFIG_MMC_MXS=y
 CONFIG_CONS_INDEX=0
 CONFIG_DM_SERIAL=y
diff --git a/net/bootp.c b/net/bootp.c
index 64fca9a42d9..1d905a01a47 100644
--- a/net/bootp.c
+++ b/net/bootp.c
@@ -19,8 +19,8 @@
 #include <linux/delay.h>
 #include <net/tftp.h>
 #include "bootp.h"
-#ifdef CONFIG_LED_STATUS
-#include <status_led.h>
+#if IS_ENABLED(CONFIG_LED_BOOT)
+#include <led.h>
 #endif
 #ifdef CONFIG_BOOTP_RANDOM_DELAY
 #include "net_rand.h"
@@ -396,8 +396,8 @@ static void bootp_handler(uchar *pkt, unsigned dest, struct in_addr sip,
 	/*
 	 *	Got a good BOOTP reply.	 Copy the data into our variables.
 	 */
-#if defined(CONFIG_LED_STATUS) && defined(CONFIG_LED_STATUS_BOOT_ENABLE)
-	status_led_set(CONFIG_LED_STATUS_BOOT, CONFIG_LED_STATUS_OFF);
+#if IS_ENABLED(CONFIG_LED_BOOT)
+	led_boot_off();
 #endif
 
 	store_net_params(bp);		/* Store net parameters from reply */

-- 
2.51.1

