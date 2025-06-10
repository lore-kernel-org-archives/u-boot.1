Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 374A1C5B552
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 03:09:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62A3482B07;
	Tue, 10 Jun 2025 05:08:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EiN8Cb+3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C639482B18; Tue, 10 Jun 2025 05:08:53 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E03C82AA7
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 05:08:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-2da73158006so3688932fac.0
 for <u-boot@lists.denx.de>; Mon, 09 Jun 2025 20:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749524925; x=1750129725; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2k/6pK7vs3KXa43JX+6anjAhoJgfLzDp9iabxcPGSRA=;
 b=EiN8Cb+3kb7EHvLCqLsTrKiPnh9ykAIjlr7ASuacOGZyR9ll7zyTAgD1p+cUjSg/rd
 XorjPlSCYfq7Dzxzv0yY08LUSxpSrKQiQXGm5PEBELh9lAwnUoPLJ578YPVWWN2LK19u
 jaW9ZvaiCsLDO4cMMovI914ZBPt6JVc8fA8WJU4MFWiZu9Qu/IuZt11BHLkbmEFSz9Ll
 1F3OcddNkA7Y/zcYFSmK2u2qLqlHINmzMcLns/b+ZEgruEIoGj6GyCMHNVmc7DxpZ2wk
 S8KhTj2pJc0sab+0t4HDEG2rlEV88pZ9ImU/6buzVrrhWWTnK+WNYBjffErQ/iC4AA0X
 QzCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749524925; x=1750129725;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2k/6pK7vs3KXa43JX+6anjAhoJgfLzDp9iabxcPGSRA=;
 b=HPIZ02bbcvSM4V5QeuE0WzTO1pJ7LBLVfPKIRLLecCrYrBJWGS/ABxn2wQgWA1Iu8H
 YzntBq9VdJecisOGvZeLgXs1PN7jHy4gSBsqWoxnfHZzmQ2+8TNPj1XvNq0oE4LtRVy7
 O46BGNzHdWQBVg/fsJYjZp72VYqTfngsarMsHZrEZqvImSTLZ+PMLbO9/NhShDlf0TdU
 lOeteWeLMFjjOgH7k89HC++lTu9kEWb4spnXXXfOFG0Q6A6rZ/tiljVb5fLlgB79H5oA
 EUenu7dczT/LlzMPeAsF7sOrzqWTt5MN5DhNVErN7e5CdRpWcYHWmi0ALlzjyF+YvxoS
 19gA==
X-Gm-Message-State: AOJu0YzWGOZWrRCNE2fXic3FR5Pn+ReC0XK7RkO9ccXAxSbaeiadjZ2L
 VbhoCJhDEWFh+Ll9x+InrKqHhNdWMw3A3Zf6IJj2X23hHMxuFB5yFI8fq/384w==
X-Gm-Gg: ASbGnctNILenT2U1PfF1LogBHXXc5DwgY7ylhGuOj/Y5v7jGfSYG6ltyOMPVoGc5OiC
 nVtLxUX/1XsNOy8DqYgNgGYJ8O5mPsbAoyoQMZcvyPsd+6qtJE8Rjkj8hXQgsAEQ+yWC72VAI8l
 oDYf/YULJ4v0JFFk1P3jwxfItGTtd3yHewGCjDCGKX0pdTvqcp0hq4ZmOc2t46XU3bwuneZCVas
 xUOual/Zl151uLkV5x2BbLD3OCMsEcT1U4yKJshhIwlV5891Tw22L6BEKxHHSttQ3hCCKVfrh9P
 H6dZwQezrW7eeDxWJh7Y6kHKPilrnsCZmG1yFpY09n2k2Iv9GZ5D7qf67G8xXZY578l9SLSlEJd
 ghgzMLw==
X-Google-Smtp-Source: AGHT+IEDDKH6f6KLoTtmcZf8DFOG6T2RsyXwxKktyjUp237/DO9YGrY/LoWCNqV0flcALK8qt8sdPA==
X-Received: by 2002:a05:6871:7503:b0:2d4:ddf9:e5f5 with SMTP id
 586e51a60fabf-2ea00633bd0mr9038203fac.7.1749524925009; 
 Mon, 09 Jun 2025 20:08:45 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf:41b9:cc36:55e6:1668])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2ea0707a77asm2173266fac.13.2025.06.09.20.08.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 20:08:44 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: heiko@sntech.de, quentin.schulz@cherry.de, jonas@kwiboo.se,
 kever.yang@rock-chips.com, philipp.tomsich@vrull.eu, sjg@chromium.org,
 trini@konsulko.com, Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V2] rockchip: Add support for GameForce Ace
Date: Mon,  9 Jun 2025 22:06:16 -0500
Message-ID: <20250610030616.588285-1-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
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

From: Chris Morgan <macromorgan@hotmail.com>

The GameForce Ace is an RK3588S based handheld gaming device.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 arch/arm/mach-rockchip/rk3588/Kconfig   | 18 +++++++
 board/gameforce/ace-rk3588s/Kconfig     |  9 ++++
 board/gameforce/ace-rk3588s/MAINTAINERS |  5 ++
 configs/gameforce-ace-rk3588s_defconfig | 67 +++++++++++++++++++++++++
 doc/board/rockchip/rockchip.rst         |  1 +
 5 files changed, 100 insertions(+)
 create mode 100644 board/gameforce/ace-rk3588s/Kconfig
 create mode 100644 board/gameforce/ace-rk3588s/MAINTAINERS
 create mode 100644 configs/gameforce-ace-rk3588s_defconfig
---
Changes since V1:
 - Corrected alphabetical order in rockchip.rst
 - Removed unused PCI from defconfig

diff --git a/arch/arm/mach-rockchip/rk3588/Kconfig b/arch/arm/mach-rockchip/rk3588/Kconfig
index 4e7942ada87..9fbe3f225aa 100644
--- a/arch/arm/mach-rockchip/rk3588/Kconfig
+++ b/arch/arm/mach-rockchip/rk3588/Kconfig
@@ -27,6 +27,23 @@ config TARGET_CM3588_NAS_RK3588
 	  - 3.5mm Headphone out, 2.0mm PH-2A Mic in
 	  - 5V Fan connector, PWM beeper, IR receiver, RTC battery connector
 
+config TARGET_GAMEFORCE_ACE_RK3588S
+	bool "GameForce Ace"
+	help
+	  The GameForce Ace is a handheld game console from GameForce with
+	  the Rockchip RK3588S SoC.
+
+	  Hardware features:
+	  - Rockchip RK3588S SoC
+	  - 12GB LPDDR4x RAM
+	  - 128GB eMMC
+	  - MicroSD card slot
+	  - 1x USB 3.0 Type-C with DP AltMode support
+	  - 1x HDMI 2.1 micro-HDMI out
+	  - 1920x1080 touchscreen MIPI-DSI panel
+	  - Analog joysticks and L/R triggers
+	  - 16 digital buttons
+
 config TARGET_GENBOOK_CM5_RK3588
 	bool "Cool Pi CM5 GenBook"
 	help
@@ -410,6 +427,7 @@ source "board/friendlyelec/cm3588-nas-rk3588/Kconfig"
 source "board/friendlyelec/nanopc-t6-rk3588/Kconfig"
 source "board/friendlyelec/nanopi-r6c-rk3588s/Kconfig"
 source "board/friendlyelec/nanopi-r6s-rk3588s/Kconfig"
+source "board/gameforce/ace-rk3588s/Kconfig"
 source "board/hardkernel/odroid_m2/Kconfig"
 source "board/indiedroid/nova/Kconfig"
 source "board/khadas/khadas-edge2-rk3588s/Kconfig"
diff --git a/board/gameforce/ace-rk3588s/Kconfig b/board/gameforce/ace-rk3588s/Kconfig
new file mode 100644
index 00000000000..52f98ccf897
--- /dev/null
+++ b/board/gameforce/ace-rk3588s/Kconfig
@@ -0,0 +1,9 @@
+if TARGET_GAMEFORCE_ACE_RK3588S
+
+config SYS_BOARD
+	default "gameforce-ace-rk3588s"
+
+config SYS_VENDOR
+	default "GameForce"
+
+endif
diff --git a/board/gameforce/ace-rk3588s/MAINTAINERS b/board/gameforce/ace-rk3588s/MAINTAINERS
new file mode 100644
index 00000000000..dc18e7c8849
--- /dev/null
+++ b/board/gameforce/ace-rk3588s/MAINTAINERS
@@ -0,0 +1,5 @@
+GAMEFORCE-ACE-RK3588S
+M:	Chris Morgan <macromorgan@hotmail.com>
+S:	Maintained
+F:	board/gameforce/ace-rk3588s/
+F:	configs/gameforce-ace-rk3588s_defconfig
diff --git a/configs/gameforce-ace-rk3588s_defconfig b/configs/gameforce-ace-rk3588s_defconfig
new file mode 100644
index 00000000000..ec725a8df40
--- /dev/null
+++ b/configs/gameforce-ace-rk3588s_defconfig
@@ -0,0 +1,67 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588s-gameforce-ace"
+CONFIG_ROCKCHIP_RK3588=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SYS_LOAD_ADDR=0xc00800
+CONFIG_DEBUG_UART_BASE=0xFEB50000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_DEBUG_UART=y
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_SPL_FIT_SIGNATURE=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588s-gameforce-ace.dtb"
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_SPL_MAX_SIZE=0x40000
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_SPL_ATF=y
+CONFIG_CMD_MMC=y
+# CONFIG_CMD_SETEXPR is not set
+# CONFIG_SPL_DOS_PARTITION is not set
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_LIVE=y
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_NO_NET=y
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_SPL_REGMAP=y
+CONFIG_SPL_SYSCON=y
+CONFIG_BUTTON=y
+CONFIG_BUTTON_ADC=y
+CONFIG_BUTTON_GPIO=y
+CONFIG_SPL_CLK=y
+CONFIG_ROCKCHIP_GPIO=y
+CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_LED=y
+CONFIG_LED_GPIO=y
+CONFIG_MISC=y
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SDMA=y
+CONFIG_MMC_SDHCI_ROCKCHIP=y
+CONFIG_PHY_ROCKCHIP_INNO_USB2=y
+CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
+CONFIG_PHY_ROCKCHIP_USBDP=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_PWM_ROCKCHIP=y
+CONFIG_SPL_RAM=y
+# CONFIG_RAM_ROCKCHIP_DEBUG is not set
+CONFIG_BAUDRATE=1500000
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_SYS_NS16550_MEM32=y
+CONFIG_ROCKCHIP_SPI=y
+CONFIG_SYSRESET=y
+CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_GENERIC=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_OHCI_GENERIC=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_ERRNO_STR=y
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index b88299cbba2..a2d8a715a4b 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -145,6 +145,7 @@ List of mainline supported Rockchip boards:
      - FriendlyElec NanoPC-T6 (nanopc-t6-rk3588)
      - FriendlyElec NanoPi R6C (nanopi-r6c-rk3588s)
      - FriendlyElec NanoPi R6S (nanopi-r6s-rk3588s)
+     - GameForce Ace (gameforce-ace-rk3588s)
      - Generic RK3588S/RK3588 (generic-rk3588)
      - Hardkernel ODROID-M2 (odroid-m2-rk3588s)
      - Indiedroid Nova (nova-rk3588s)
-- 
2.43.0

