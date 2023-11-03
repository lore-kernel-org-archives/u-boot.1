Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FCB9C4332F
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 09:28:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CCDF87477;
	Fri,  3 Nov 2023 10:28:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A54E874D1; Fri,  3 Nov 2023 10:28:34 +0100 (CET)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6CF187455
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 10:28:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=foss+uboot@0leil.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id A08E2C0005;
 Fri,  3 Nov 2023 09:28:28 +0000 (UTC)
From: Quentin Schulz <foss+uboot@0leil.net>
To: Klaus Goger <klaus.goger@theobroma-systems.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: Quentin Schulz <foss+uboot@0leil.net>, u-boot@lists.denx.de,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, heiko@sntech.de
Subject: [PATCH v2 1/2] rockchip: ringneck-px30: always reset STM32
 companion controller on boot
Date: Fri,  3 Nov 2023 10:28:12 +0100
Message-ID: <20231103-ringneck-stm32-reset-v2-1-a0e5559f89bf@theobroma-systems.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231103-ringneck-stm32-reset-v2-0-a0e5559f89bf@theobroma-systems.com>
References: <20231103-ringneck-stm32-reset-v2-0-a0e5559f89bf@theobroma-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: quoted-printable
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

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>=0D
=0D
It's happened that glitches on the STM32_RST and STM32_BOOT lines have=0D
put the STM32 companion microcontroller into DFU mode making it not boot=0D
its FW, rendering it useless for the user.=0D
=0D
Considering that the STM32 companion microcontroller is always reset on=0D
a reboot or power cycle, resetting it once again in U-Boot SPL isn't=0D
going to hurt it any more.=0D
=0D
For ATtiny companion microcontroller, the situation is a bit different=0D
because a reboot or power cycle doesn't reset it. Additionally, since it=0D
can only be reset with a UPDI reset on the STM32_RST line, and that is=0D
virtually impossible to mistakenly trigger, the ATtiny is unlikely to be=0D
in unwanted reset or enter reset because U-Boot toggles STM32_RST line.=0D
=0D
Cc: Quentin Schulz <foss+uboot@0leil.net>=0D
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>=0D
---=0D
 .../ringneck_px30/ringneck-px30.c                  | 53 ++++++++++++++++++=
++++=0D
 1 file changed, 53 insertions(+)=0D
=0D
diff --git a/board/theobroma-systems/ringneck_px30/ringneck-px30.c b/board/=
theobroma-systems/ringneck_px30/ringneck-px30.c=0D
index bb1bb4acf5c..537ce0d1d11 100644=0D
--- a/board/theobroma-systems/ringneck_px30/ringneck-px30.c=0D
+++ b/board/theobroma-systems/ringneck_px30/ringneck-px30.c=0D
@@ -16,12 +16,14 @@=0D
 #include <usb.h>=0D
 #include <dm/pinctrl.h>=0D
 #include <dm/uclass-internal.h>=0D
+#include <asm/gpio.h>=0D
 #include <asm/io.h>=0D
 #include <asm/setup.h>=0D
 #include <asm/arch-rockchip/clock.h>=0D
 #include <asm/arch-rockchip/hardware.h>=0D
 #include <asm/arch-rockchip/periph.h>=0D
 #include <asm/arch-rockchip/misc.h>=0D
+#include <linux/delay.h>=0D
 #include <power/regulator.h>=0D
 #include <u-boot/sha256.h>=0D
 =0D
@@ -169,3 +171,54 @@ int misc_init_r(void)=0D
 =0D
 	return 0;=0D
 }=0D
+=0D
+#define STM32_RST	100 /* GPIO3_A4 */=0D
+#define STM32_BOOT	101 /* GPIO3_A5 */=0D
+=0D
+void spl_board_init(void)=0D
+{=0D
+	/*=0D
+	 * Glitches on STM32_BOOT and STM32_RST lines during poweroff or power=0D
+	 * on may put the STM32 companion microcontroller into DFU mode, let's=0D
+	 * always reset it into normal mode instead.=0D
+	 * Toggling the STM32_RST line is safe to do with the ATtiny companion=0D
+	 * microcontroller variant because it will not trigger an MCU reset=0D
+	 * since only a UPDI reset command will. Since a UPDI reset is difficult=
=0D
+	 * to mistakenly trigger, glitches to the lines are theoretically also=0D
+	 * incapable of triggering an actual ATtiny reset.=0D
+	 */=0D
+	int ret;=0D
+=0D
+	ret =3D gpio_request(STM32_RST, "STM32_RST");=0D
+	if (ret) {=0D
+		debug("Failed to request STM32_RST\n");=0D
+		return;=0D
+	}=0D
+=0D
+	ret =3D gpio_request(STM32_BOOT, "STM32_BOOT");=0D
+	if (ret) {=0D
+		debug("Failed to request STM32_BOOT\n");=0D
+		return;=0D
+	}=0D
+=0D
+	/* Rely on HW pull-down for inactive level */=0D
+	ret =3D gpio_direction_input(STM32_BOOT);=0D
+	if (ret) {=0D
+		debug("Failed to configure STM32_BOOT as input\n");=0D
+		return;=0D
+	}=0D
+=0D
+	ret =3D gpio_direction_output(STM32_RST, 0);=0D
+	if (ret) {=0D
+		debug("Failed to configure STM32_RST as output low\n");=0D
+		return;=0D
+	}=0D
+=0D
+	mdelay(1);=0D
+=0D
+	ret =3D gpio_direction_output(STM32_RST, 1);=0D
+	if (ret) {=0D
+		debug("Failed to configure STM32_RST as output high\n");=0D
+		return;=0D
+	}=0D
+}=0D
=0D
-- =0D
2.41.0=0D
=0D
