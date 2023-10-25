Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A889BC0032E
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 09:51:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72218879E7;
	Wed, 25 Oct 2023 11:51:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25B92879D8; Wed, 25 Oct 2023 11:51:45 +0200 (CEST)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::224])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29C0C879A6
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 11:51:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=foss+uboot@0leil.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 07BFAE0002;
 Wed, 25 Oct 2023 09:51:41 +0000 (UTC)
From: Quentin Schulz <foss+uboot@0leil.net>
To: Klaus Goger <klaus.goger@theobroma-systems.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: Quentin Schulz <foss+uboot@0leil.net>, u-boot@lists.denx.de,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, heiko@sntech.de
Subject: [PATCH 1/2] rockchip: ringneck-px30: always reset STM32 companion
 controller on boot
Date: Wed, 25 Oct 2023 11:51:14 +0200
Message-ID: <20231025-ringneck-stm32-reset-v1-1-052562bec53f@theobroma-systems.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231025-ringneck-stm32-reset-v1-0-052562bec53f@theobroma-systems.com>
References: <20231025-ringneck-stm32-reset-v1-0-052562bec53f@theobroma-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit
X-GND-Sasl: foss@0leil.net
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

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>

It's happened that glitches on the STM32_RST and STM32_BOOT lines have
put the STM32 companion microcontroller into DFU mode making it not boot
its FW, rendering it useless for the user.

Considering that the STM32 companion microcontroller is always reset on
a reboot or power cycle, resetting it once again in U-Boot SPL isn't
going to hurt it any more.

For ATtiny companion microcontroller, the situation is a bit different
because a reboot or power cycle doesn't reset it. Additionally, since it
can only be reset with a UPDI reset on the STM32_RST line, and that is
virtually impossible to mistakenly trigger, the ATtiny is unlikely to be
in unwanted reset or enter reset because U-Boot toggles STM32_RST line.

Cc: Quentin Schulz <foss+uboot@0leil.net>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 .../ringneck_px30/ringneck-px30.c                  | 52 ++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/board/theobroma-systems/ringneck_px30/ringneck-px30.c b/board/theobroma-systems/ringneck_px30/ringneck-px30.c
index bb1bb4acf5c..804a991e281 100644
--- a/board/theobroma-systems/ringneck_px30/ringneck-px30.c
+++ b/board/theobroma-systems/ringneck_px30/ringneck-px30.c
@@ -16,12 +16,14 @@
 #include <usb.h>
 #include <dm/pinctrl.h>
 #include <dm/uclass-internal.h>
+#include <asm/gpio.h>
 #include <asm/io.h>
 #include <asm/setup.h>
 #include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/hardware.h>
 #include <asm/arch-rockchip/periph.h>
 #include <asm/arch-rockchip/misc.h>
+#include <linux/delay.h>
 #include <power/regulator.h>
 #include <u-boot/sha256.h>
 
@@ -169,3 +171,53 @@ int misc_init_r(void)
 
 	return 0;
 }
+
+#define STM32_RST	100 // GPIO3_A4
+#define STM32_BOOT	101 // GPIO3_A5
+
+void spl_board_init(void)
+{
+	/*
+	 * Glitches on STM32_BOOT and STM32_RST lines during poweroff or power
+	 * on may put the STM32 companion microcontroller into DFU mode, let's
+	 * always reset it into normal mode instead.
+	 * Toggling the STM32_RST line is safe to do with the ATtiny companion
+	 * microcontroller variant because it will not trigger an MCU reset
+	 * since only a UPDI reset command will. Since a UPDI reset is difficult
+	 * to mistakenly trigger, glitches to the lines are theoretically also
+	 * incapable of triggering an actual ATtiny reset.
+	 */
+	int ret = gpio_request(STM32_RST, "STM32_RST");
+
+	if (ret) {
+		debug("Failed to request STM32_RST\n");
+		return;
+	}
+
+	ret = gpio_request(STM32_BOOT, "STM32_BOOT");
+	if (ret) {
+		debug("Failed to request STM32_BOOT\n");
+		return;
+	}
+
+	// Rely on HW pull-down for inactive level
+	ret = gpio_direction_input(STM32_BOOT);
+	if (ret) {
+		debug("Failed to configure STM32_BOOT\n");
+		return;
+	}
+
+	ret = gpio_direction_output(STM32_RST, 0);
+	if (ret) {
+		debug("Failed to configure STM32_RST\n");
+		return;
+	}
+
+	mdelay(1);
+
+	ret = gpio_direction_output(STM32_RST, 1);
+	if (ret) {
+		debug("Failed to configure STM32_RST\n");
+		return;
+	}
+}

-- 
2.41.0

