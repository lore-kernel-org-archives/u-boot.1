Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBB25C5AD49
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 12:00:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C2568390B;
	Wed, 28 May 2025 14:00:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20F8083931; Wed, 28 May 2025 14:00:52 +0200 (CEST)
Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::bc08])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE12F8321B
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 14:00:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0001.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246c])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4b6p4125Dlz7Dk;
 Wed, 28 May 2025 14:00:49 +0200 (CEST)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4b6p401F8qz87b; Wed, 28 May 2025 14:00:48 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 28 May 2025 14:00:36 +0200
Subject: [PATCH] rockchip: px30: Implement checkboard() to print SoC
 variant
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250528-px30-identify-variant-v1-1-4ea69c527a0d@cherry.de>
X-B4-Tracking: v=1; b=H4sIAOP6NmgC/x2MQQqAIBAAvxJ7TjBDrL4SHcy22ovFGlKEf2/pO
 AMzLyRkwgRD9QJjpkRHFGjqCsLu44aKFmEw2lhtTafOu9XiMF60Pip7Jh8v5bHtg3OmsXYGaU/
 Gle7/O06lfPazU4dnAAAA
X-Change-ID: 20250528-px30-identify-variant-ae39c772155b
To: Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>, 
 u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.2
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

This implements checkboard() to print the current SoC model used by a
board, e.g. one of:

SoC: PX30
SoC: PX30K

when U-Boot proper is running.

The information is read from the OTP. There's no public information as
far as I know about the layout and stored information but this was
provided by Rockchip themselves through their support channel.

I'm aware of at least one other variant, the PX30S/PX30-S but I have
neither a board with that SoC nor the information of what the value in
the OTP is supposed to be. If it follows what was done for RK3588
variants, where the letter is derived from some offset added to the
value read from the OTP, PX30S could be represented by 0x33 in the
OTP. I'm assuming this is correct and simply printing the char
represented by this offset added to the value in the OTP instead of
checking whether it's 0x21 (PX30) or 0x28 (PX30K) or bailing out.

Also add the OTP node to the pre-relocation phase of U-Boot proper so
that the SoC variant can be printed when DISPLAY_BOARDINFO is enabled.
This is not required if DISPLAY_BOARDINFO_LATE is enabled because this
happens after relocation. If both are enabled, then the SoC variant will
be printed twice in the boot log, e.g.:

U-Boot 2025.07-rc3-00014-g7cb731574ae6-dirty (May 28 2025 - 13:52:47 +0200)

Model: Theobroma Systems PX30-uQ7 SoM on Haikou devkit
SoC:   PX30  <---- due to DISPLAY_BOARDINFO
DRAM:  2 GiB
PMIC:  RK809 (on=0x40, off=0x00)
Core:  293 devices, 27 uclasses, devicetree: separate
MMC:   mmc@ff370000: 1, mmc@ff390000: 0
Loading Environment from MMC... Reading from MMC(1)... OK

In:    serial@ff030000
Out:   serial@ff030000
Err:   serial@ff030000
Model: Theobroma Systems PX30-uQ7 SoM on Haikou devkit
SoC:   PX30  <----- due to DISPLAY_BOARDINFO_LATE
Net:   eth0: ethernet@ff360000

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Tested on a PX30 Ringneck and PX30K Ringneck. Would be nice if anyone
had a device with a PX30S or any other variant so we could verify it
prints what it should :) Or maybe Kever knows :)?

Heavily based on work done by Jonas for RK3588 variant identification.
---
 arch/arm/dts/px30-u-boot.dtsi      |  4 ++++
 arch/arm/mach-rockchip/px30/px30.c | 39 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/arch/arm/dts/px30-u-boot.dtsi b/arch/arm/dts/px30-u-boot.dtsi
index 157d0ea6930c55cc067560bd795249a39c3249ab..2f726b0aaba358c8fb3bf6f8ed2f9afca416aabe 100644
--- a/arch/arm/dts/px30-u-boot.dtsi
+++ b/arch/arm/dts/px30-u-boot.dtsi
@@ -27,6 +27,10 @@
 	};
 };
 
+&otp {
+	bootph-some-ram;
+};
+
 &uart2 {
 	clock-frequency = <24000000>;
 	bootph-all;
diff --git a/arch/arm/mach-rockchip/px30/px30.c b/arch/arm/mach-rockchip/px30/px30.c
index 8ce9ac561f0213fd4db933fdb9e1edde61ac39ca..4203029f2b695b244ea1165160ce48981c333615 100644
--- a/arch/arm/mach-rockchip/px30/px30.c
+++ b/arch/arm/mach-rockchip/px30/px30.c
@@ -2,10 +2,14 @@
 /*
  * Copyright (c) 2017 Rockchip Electronics Co., Ltd
  */
+
+#define LOG_CATEGORY LOGC_ARCH
+
 #include <clk.h>
 #include <dm.h>
 #include <fdt_support.h>
 #include <init.h>
+#include <misc.h>
 #include <spl.h>
 #include <asm/armv8/mmu.h>
 #include <asm/arch-rockchip/bootrom.h>
@@ -442,3 +446,38 @@ void board_debug_uart_init(void)
 #endif /* CONFIG_DEBUG_UART_BASE && CONFIG_DEBUG_UART_BASE == ... */
 }
 #endif /* CONFIG_DEBUG_UART_BOARD_INIT */
+
+#define PX30_OTP_SPECIFICATION_OFFSET		0x06
+
+int checkboard(void)
+{
+	struct udevice *dev;
+	u8 specification;
+	char suffix[2];
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_ROCKCHIP_OTP) || !CONFIG_IS_ENABLED(MISC))
+		return 0;
+
+	ret = uclass_get_device_by_driver(UCLASS_MISC,
+					  DM_DRIVER_GET(rockchip_otp), &dev);
+	if (ret) {
+		log_debug("Could not find otp device, ret=%d\n", ret);
+		return 0;
+	}
+
+	/* specification: SoC variant, e.g. 0x21 for PX30 and 0x2b for PX30K */
+	ret = misc_read(dev, PX30_OTP_SPECIFICATION_OFFSET, &specification, 1);
+	if (ret < 0) {
+		log_debug("Could not read specification, ret=%d\n", ret);
+		return 0;
+	}
+
+	/* for PX30K i.e. 0x20 + 0x2b = 'K' */
+	suffix[0] = specification > 0x21 ? 0x20 + specification : '\0';
+	suffix[1] = '\0';
+
+	printf("SoC:   PX30%s\n", suffix);
+
+	return 0;
+}

---
base-commit: 11b8bcd7005ff24b2114dcc4d1061e083e4c9e6c
change-id: 20250528-px30-identify-variant-ae39c772155b

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

