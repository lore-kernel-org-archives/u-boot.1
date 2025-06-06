Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD512C5AD49
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 10:21:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0F1C81FEE;
	Fri,  6 Jun 2025 12:21:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38AEC82977; Fri,  6 Jun 2025 12:21:37 +0200 (CEST)
Received: from smtp-190d.mail.infomaniak.ch (smtp-190d.mail.infomaniak.ch
 [185.125.25.13])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E9B281F0D
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 12:21:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6b])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4bDHRK5k9WzyPd;
 Fri,  6 Jun 2025 12:21:33 +0200 (CEST)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4bDHRJ3grMzDNX; Fri,  6 Jun 2025 12:21:32 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Fri, 06 Jun 2025 12:21:23 +0200
Subject: [PATCH v2] rockchip: px30: Implement checkboard() to print SoC variant
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250606-px30-identify-variant-v2-1-624d34ccc381@cherry.de>
X-B4-Tracking: v=1; b=H4sIACLBQmgC/4WNQQ6DIBBFr2JmXRrAUqqr3qNxQXEss0EzEKIx3
 r3UC3T5XvLf3yEhEybomx0YCyWaYwV9acAHFz8oaKwMWmojjX6IZW1ldRgzTZsojsnFLBy2nbd
 WK2PeULcL40Tr2X0NlQOlPPN23hT1s/+KRQklbujunTfaOjk+fUDm7ToiDMdxfAGfadcyugAAA
 A==
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
SoC: PX30S
SoC: PX30K

when U-Boot proper is running.

The information is read from the OTP and also the DDR_GRF. There's no
public information as far as I know about the layout and stored
information on OTP but this was provided by Rockchip themselves through
their support channel.

The OTP stores the information of whether the SoC is PX30/PX30S or
PX30K. To differentiate between PX30 and PX30S, one needs to read some
undocumented bitfield in a DDR_GRF register as done in vendor kernel,
c.f. https://github.com/armbian/linux-rockchip/blob/rk-6.1-rkr5.1/drivers/soc/rockchip/rockchip-cpuinfo.c#L118-L133.

I do not own a PX30S so cannot test it works properly.

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
had a device with a PX30S so we could verify it prints what it should :)
---
Changes in v2:
- added (theoretical, untested) support for PX30S based on feedback from
  Kever,
- Link to v1: https://lore.kernel.org/r/20250528-px30-identify-variant-v1-1-4ea69c527a0d@cherry.de
---
 arch/arm/dts/px30-u-boot.dtsi      |  4 +++
 arch/arm/mach-rockchip/px30/px30.c | 50 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

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
index 8ce9ac561f0213fd4db933fdb9e1edde61ac39ca..ee0f788a21063a0c36259ac4ce95f809e164e9cd 100644
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
@@ -15,6 +19,7 @@
 #include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/cru_px30.h>
 #include <dt-bindings/clock/px30-cru.h>
+#include <linux/bitfield.h>
 
 const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
 	[BROM_BOOTSOURCE_EMMC] = "/mmc@ff390000",
@@ -442,3 +447,48 @@ void board_debug_uart_init(void)
 #endif /* CONFIG_DEBUG_UART_BASE && CONFIG_DEBUG_UART_BASE == ... */
 }
 #endif /* CONFIG_DEBUG_UART_BOARD_INIT */
+
+#define PX30_OTP_SPECIFICATION_OFFSET		0x06
+
+#define DDR_GRF_BASE_ADDR               0xff630000
+#define DDR_GRF_CON(n)                  (0 + (n) * 4)
+
+int checkboard(void)
+{
+	struct udevice *dev;
+	u8 specification;
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
+	/* SoC variant, e.g. 0x21 for PX30/PX30S and 0x2b for PX30K */
+	ret = misc_read(dev, PX30_OTP_SPECIFICATION_OFFSET, &specification, 1);
+	if (ret < 0) {
+		log_debug("Could not read specification, ret=%d\n", ret);
+		return 0;
+	}
+
+	if (specification == 0x2b) {
+		printf("SoC:   PX30K\n");
+		return 0;
+	}
+
+	/* From vendor kernel: drivers/soc/rockchip/rockchip-cpuinfo.c */
+	specification = FIELD_GET(GENMASK(15, 14),
+				  readl(DDR_GRF_BASE_ADDR + DDR_GRF_CON(1)));
+	log_debug("DDR specification is %d\n", specification);
+	if (specification == 0x3)
+		printf("SoC:   PX30S\n");
+	else
+		printf("SoC:   PX30\n");
+
+	return 0;
+}

---
base-commit: 11b8bcd7005ff24b2114dcc4d1061e083e4c9e6c
change-id: 20250528-px30-identify-variant-ae39c772155b

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

