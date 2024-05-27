Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6038C25B79
	for <u-boot@archiver.kernel.org>; Mon, 27 May 2024 21:35:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96A37883D6;
	Mon, 27 May 2024 23:34:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BM2IIT8K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2736D88167; Mon, 27 May 2024 19:03:13 +0200 (CEST)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40C9A87E95
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 19:03:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=liujianfeng1994@gmail.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1f480624d10so12818725ad.1
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 10:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716829388; x=1717434188; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FO9uu8YQZXjJ118DXwBvnI0b1ni3EHSTj6qKxNv9AHM=;
 b=BM2IIT8KkpNTfMnyA10l84ySMaS69fR1ZF0aDR69WeC7WuZPdMkY1pn3hzHFoVA+eJ
 YzNgVWn83ci0JgRTzEq1NQSI1nCehQUByOLAU0XhpMIlLN4EfdxSUrB1Oah49R6NE7ta
 ELtfGqHbxSVNpjV5shVg7kNJxDqBEAXCiN0bHwztCvjctqZA2edqw8wKDzyO89G4FqrL
 ySV8VBpqAmmzaZW2DLKSXRECWXhsLYgyW7XeqjpowJ6v8i5mkrE49pGbiIoKjBGWwiHU
 qNTpKOOuHYUKAhS/wJv6NC/O2G5/HL92fsKEGc9V9ACU27AEym0/Vs3PAnsl6pmmCN4W
 ILzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716829388; x=1717434188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FO9uu8YQZXjJ118DXwBvnI0b1ni3EHSTj6qKxNv9AHM=;
 b=UPRGuEGF5oY/oW+84b+9tMV+KB9jCJ4YCZzNhcGNnzempR7spjDeilwH8SitwUCRza
 j4+a/RCjvxBV9nQxoF7ZeDBRtemdbsNobM+Xk5mVUFErC5AFTEglsnzHyPOdFWfSutVK
 kDDehLhBaXpF+v3pT53kJIgaTLyVn/Dxgo6t4l/lzNDVhbZitCQiGOaADHWK+VwCIyA2
 MM5gJKjwuoR6w3R9mTAemAWXT8WijhTgrPS4tU+pnN1CsMtUPYcZ8IULXH9Gxw+cBqYw
 M7GV/EEj6LI1TlMlOTE6EV/bgBDRzT0UNYg8SAeznceHRmjYw1nZlTT5vVf1gkvE4IKK
 wuUg==
X-Gm-Message-State: AOJu0Yw6axNhuYVxYXB6rf76xp9S1RE/3p5HPHmh5D6iqNuSrU/eCqxn
 sRoTtsN3D3pa1YLYqD5yytYjCivdtqQElZ4KYkzeNfq7+Ct0uSGjgzIcU3YzeEo=
X-Google-Smtp-Source: AGHT+IFXjxS5HJ2Et+j7U/kJ3e9AO9UqcpnH6FNm1gOyfEDqpLyRex/POomlLYdQ82eDIdjZ4anMFg==
X-Received: by 2002:a17:903:2a86:b0:1f3:4d8f:e5f3 with SMTP id
 d9443c01a7336-1f4486d606dmr108372225ad.15.1716829388188; 
 Mon, 27 May 2024 10:03:08 -0700 (PDT)
Received: from localhost.localdomain ([221.220.133.99])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c757845sm63462095ad.5.2024.05.27.10.03.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 10:03:07 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: u-boot@lists.denx.de
Cc: Jianfeng Liu <liujianfeng1994@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christopher Obbard <chris.obbard@collabora.com>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 FUKAUMI Naoki <naoki@radxa.com>, Jagan Teki <jagan@edgeble.ai>,
 John Clark <inindev@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Joshua Riek <jjriek@verizon.net>, Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marex@denx.de>,
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tianling Shen <cnsztl@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 7/7] board: rockchip: add ArmSoM Sige7 Rk3588 board
Date: Tue, 28 May 2024 01:02:14 +0800
Message-Id: <20240527170214.283988-8-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527170214.283988-1-liujianfeng1994@gmail.com>
References: <20240527170214.283988-1-liujianfeng1994@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 27 May 2024 23:34:36 +0200
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

ArmSoM Sige7 is a Rockchip RK3588 based SBC (Single Board Computer) by
ArmSoM.

There are two variants depending on the DRAM size : 8G and 16G.

Specification:

    Rockchip Rk3588 SoC
    4x ARM Cortex-A76, 4x ARM Cortex-A55
    8/16GB memory LPDDR4x
    Mali G610MC4 GPU
    2x MIPI CSI 2 multiple lanes connector
    64GB/128GB on board eMMC
    uSD slot
    1x USB 2.0 Type-A, 1x USB 3.0 Type-A, 1x USB 3.0 Type-C
    1x HDMI 2.1 output
    2x 2.5 Gbps Ethernet port
    40-pin IO header including UART, SPI and I2C
    USB PD over USB Type-C
    Size: 92mm x 62mm

Kernel commit:
81c828a67c78 (arm64: dts: rockchip: Add ArmSom Sige7 board)

Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
---

Changes in v3:
- Use update-dts-subtree.sh to pick upstream dts

Changes in v2:
- Fix alphabetical order of MAINTAINERS
- Use arch/arm/dts/rk3588-armsom-sige7* in board MAINTAINERS
- Remove spi flash related config
- Move kernel dts to dts/upstream/src/arm64/rockchip/

 MAINTAINERS                                  |  1 +
 arch/arm/dts/rk3588-armsom-sige7-u-boot.dtsi | 28 ++++++
 arch/arm/mach-rockchip/rk3588/Kconfig        | 26 ++++++
 board/armsom/sige7-rk3588/Kconfig            | 12 +++
 board/armsom/sige7-rk3588/MAINTAINERS        |  7 ++
 configs/sige7-rk3588_defconfig               | 93 ++++++++++++++++++++
 doc/board/rockchip/rockchip.rst              |  1 +
 include/configs/sige7-rk3588.h               | 15 ++++
 8 files changed, 183 insertions(+)
 create mode 100644 arch/arm/dts/rk3588-armsom-sige7-u-boot.dtsi
 create mode 100644 board/armsom/sige7-rk3588/Kconfig
 create mode 100644 board/armsom/sige7-rk3588/MAINTAINERS
 create mode 100644 configs/sige7-rk3588_defconfig
 create mode 100644 include/configs/sige7-rk3588.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 6c861b529df..fffcf898bf1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -534,6 +534,7 @@ F:	arch/arm/include/asm/arch-rockchip/
 F:	arch/arm/mach-rockchip/
 F:	board/amarula/vyasa-rk3288/
 F:	board/anbernic/rgxx3_rk3566/
+F:	board/armsom/sige7-rk3588/
 F:	board/chipspark/popmetal_rk3288
 F:	board/engicam/px30_core/
 F:	board/firefly/
diff --git a/arch/arm/dts/rk3588-armsom-sige7-u-boot.dtsi b/arch/arm/dts/rk3588-armsom-sige7-u-boot.dtsi
new file mode 100644
index 00000000000..2c984d01471
--- /dev/null
+++ b/arch/arm/dts/rk3588-armsom-sige7-u-boot.dtsi
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2024 ArmSoM Technology Co., Ltd.
+ */
+
+#include "rk3588-u-boot.dtsi"
+
+&sdhci {
+	cap-mmc-highspeed;
+	mmc-hs200-1_8v;
+};
+
+&u2phy1 {
+	status = "okay";
+};
+
+&u2phy1_otg {
+	status = "okay";
+};
+
+&usbdp_phy1 {
+	status = "okay";
+};
+
+&usb_host1_xhci {
+	dr_mode = "host";
+	status = "okay";
+};
diff --git a/arch/arm/mach-rockchip/rk3588/Kconfig b/arch/arm/mach-rockchip/rk3588/Kconfig
index 39049ab35a9..4c14b0be1eb 100644
--- a/arch/arm/mach-rockchip/rk3588/Kconfig
+++ b/arch/arm/mach-rockchip/rk3588/Kconfig
@@ -152,6 +152,31 @@ config TARGET_ROCK5B_RK3588
 	  USB PD over USB Type-C
 	  Size: 100mm x 72mm (Pico-ITX form factor)
 
+config TARGET_SIGE7_RK3588
+	bool "ArmSoM Sige7 RK3588 board"
+	select BOARD_LATE_INIT
+	help
+	  ArmSoM Sige7 is a Rockchip RK3588 based SBC (Single Board Computer)
+	  by ArmSoM.
+
+	  There are two variants depending on the DRAM size : 8G and 16G.
+
+	  Specification:
+
+	  Rockchip Rk3588 SoC
+	  4x ARM Cortex-A76, 4x ARM Cortex-A55
+	  8/16GB memory LPDDR4x
+	  Mali G610MC4 GPU
+	  2x MIPI CSI 2 multiple lanes connector
+	  64GB/128GB on board eMMC
+	  uSD slot
+	  1x USB 2.0 Type-A, 1x USB 3.0 Type-A, 1x USB 3.0 Type-C
+	  1x HDMI 2.1 output
+	  2x 2.5 Gbps Ethernet port
+	  40-pin IO header including UART, SPI and I2C
+	  USB PD over USB Type-C
+	  Size: 92mm x 62mm
+
 config TARGET_QUARTZPRO64_RK3588
 	bool "Pine64 QuartzPro64 RK3588 board"
 	select BOARD_LATE_INIT
@@ -221,6 +246,7 @@ config ROCKCHIP_COMMON_STACK_ADDR
 config TEXT_BASE
 	default 0x00a00000
 
+source "board/armsom/sige7-rk3588/Kconfig"
 source "board/edgeble/neural-compute-module-6/Kconfig"
 source "board/friendlyelec/nanopc-t6-rk3588/Kconfig"
 source "board/pine64/quartzpro64-rk3588/Kconfig"
diff --git a/board/armsom/sige7-rk3588/Kconfig b/board/armsom/sige7-rk3588/Kconfig
new file mode 100644
index 00000000000..793985f531b
--- /dev/null
+++ b/board/armsom/sige7-rk3588/Kconfig
@@ -0,0 +1,12 @@
+if TARGET_SIGE7_RK3588
+
+config SYS_BOARD
+	default "sige7-rk3588"
+
+config SYS_VENDOR
+	default "armsom"
+
+config SYS_CONFIG_NAME
+	default "sige7-rk3588"
+
+endif
diff --git a/board/armsom/sige7-rk3588/MAINTAINERS b/board/armsom/sige7-rk3588/MAINTAINERS
new file mode 100644
index 00000000000..0fba39b76c2
--- /dev/null
+++ b/board/armsom/sige7-rk3588/MAINTAINERS
@@ -0,0 +1,7 @@
+SIGE7-RK3588
+M:	Jianfeng Liu <liujianfeng1994@gmail.com>
+S:	Maintained
+F:	board/armsom/sige7-rk3588
+F:	include/configs/sige7-rk3588.h
+F:	configs/sige7-rk3588_defconfig
+F:	arch/arm/dts/rk3588-armsom-sige7*
diff --git a/configs/sige7-rk3588_defconfig b/configs/sige7-rk3588_defconfig
new file mode 100644
index 00000000000..d15fc09fc8d
--- /dev/null
+++ b/configs/sige7-rk3588_defconfig
@@ -0,0 +1,93 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_SYS_HAS_NONCACHED_MEMORY=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588-armsom-sige7"
+CONFIG_ROCKCHIP_RK3588=y
+CONFIG_SPL_SERIAL=y
+CONFIG_TARGET_SIGE7_RK3588=y
+CONFIG_DEBUG_UART_BASE=0xFEB50000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_SPL_SPI=y
+CONFIG_SYS_LOAD_ADDR=0xc00800
+CONFIG_PCI=y
+CONFIG_DEBUG_UART=y
+CONFIG_AHCI=y
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_SPL_FIT_SIGNATURE=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-armsom-sige7.dtb"
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_SPL_MAX_SIZE=0x40000
+CONFIG_SPL_PAD_TO=0x7f8000
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_SPL_ATF=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_ROCKUSB=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_REGULATOR=y
+# CONFIG_SPL_DOS_PARTITION is not set
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_LIVE=y
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_SPL_REGMAP=y
+CONFIG_SPL_SYSCON=y
+CONFIG_AHCI_PCI=y
+CONFIG_DWC_AHCI=y
+CONFIG_SPL_CLK=y
+# CONFIG_USB_FUNCTION_FASTBOOT is not set
+CONFIG_ROCKCHIP_GPIO=y
+CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_MISC=y
+CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SDMA=y
+CONFIG_MMC_SDHCI_ROCKCHIP=y
+CONFIG_PHYLIB=y
+CONFIG_RTL8169=y
+CONFIG_NVME_PCI=y
+CONFIG_PCIE_DW_ROCKCHIP=y
+CONFIG_PHY_ROCKCHIP_INNO_USB2=y
+CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
+CONFIG_PHY_ROCKCHIP_USBDP=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_PWM_ROCKCHIP=y
+CONFIG_SPL_RAM=y
+CONFIG_SCSI=y
+CONFIG_BAUDRATE=1500000
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_SYS_NS16550_MEM32=y
+CONFIG_SYSRESET=y
+CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_GENERIC=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_OHCI_GENERIC=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_SPL_USB_DWC3_GENERIC=y
+CONFIG_USB_HOST_ETHER=y
+CONFIG_USB_ETHER_ASIX=y
+CONFIG_USB_ETHER_ASIX88179=y
+CONFIG_USB_ETHER_LAN75XX=y
+CONFIG_USB_ETHER_LAN78XX=y
+CONFIG_USB_ETHER_MCS7830=y
+CONFIG_USB_ETHER_RTL8152=y
+CONFIG_USB_ETHER_SMSC95XX=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_USB_FUNCTION_ROCKUSB=y
+CONFIG_ERRNO_STR=y
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index 9a726e9cde6..6b826b3288f 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -118,6 +118,7 @@ List of mainline supported Rockchip boards:
      - Radxa ROCK 3 Model A (rock-3a-rk3568)
 
 * rk3588
+     - ArmSoM Sige7 (sige7-rk3588)
      - Rockchip EVB (evb-rk3588)
      - Edgeble Neural Compute Module 6A SoM - Neu6a (neu6a-io-rk3588)
      - Edgeble Neural Compute Module 6B SoM - Neu6b (neu6b-io-rk3588)
diff --git a/include/configs/sige7-rk3588.h b/include/configs/sige7-rk3588.h
new file mode 100644
index 00000000000..fd08da568b1
--- /dev/null
+++ b/include/configs/sige7-rk3588.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2024 ArmSoM Technology Co., Ltd.
+ */
+
+#ifndef __SIGE7_RK3588_H
+#define __SIGE7_RK3588_H
+
+#define ROCKCHIP_DEVICE_SETTINGS \
+		"stdout=serial,vidconsole\0" \
+		"stderr=serial,vidconsole\0"
+
+#include <configs/rk3588_common.h>
+
+#endif /* __SIGE7_RK3588_H */
-- 
2.34.1

