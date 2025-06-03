Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E0BDC5AE59
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 22:16:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF817822D7;
	Wed,  4 Jun 2025 00:16:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="g4yVcY2Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5742C828BC; Wed,  4 Jun 2025 00:16:19 +0200 (CEST)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7278281FEE
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 00:16:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-2db9e29d3bcso2618401fac.1
 for <u-boot@lists.denx.de>; Tue, 03 Jun 2025 15:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748988975; x=1749593775; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RV3+bcyR4mAqiUTn6eUkgQTg9lDYHLU92614vj+GWmU=;
 b=g4yVcY2ZoKWSbx85GOptuO4I8VVEymFAZdDXtAzEu3N3/hK2RTufjKRefRk7FJhJJk
 5RvZbCQquEBJom/28VEgCcxDpRQ7FYVLeIWHr3V+bS2x2WTAJGCZ4vO3pNfSU18QX9WO
 94n5VJ2oIi3PIoThcetIJfjqtyoH4phxwVRzbd3IxtKmHlHW80uERSXg+x/5pBEFaRsN
 zKAHnQJpMlIZU2AUQHSnu5Y5CkZvCusleILRUU7Klkbvl8oKmg70QfOlwOeQMu95tQwT
 svzsWoBV4faEd++djr/AZmVT1o9FQXF2VrpT84pn0Lg9ur1yBKhcsq/xPftZQ0PY3U/v
 1yqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748988975; x=1749593775;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RV3+bcyR4mAqiUTn6eUkgQTg9lDYHLU92614vj+GWmU=;
 b=DBCWHPaVlftrYNPBxClrCT5qOk51Y8EGhaq5xgUJCbuAlDYg2bBpwpppFbGVxhic7N
 wpuR4c4zMS/lIxx59BL22E4dnbU4vWpwPaEakqqmHwHYbLX6gJ8TNNYxDq73L/+bd5UD
 fkt049a+nTlZ/X9M4EPrL/Ph1dRjVK1LFZBLXXHhPhLEMCz/M6zs8BDZtQHThkDrV6hr
 zVOGyUH4P5pG19YLb1hzL68pLzaHUYc+mlk47AE6ktkFaMKiplPgGnP3C4RtzqbkhNa/
 wOpNeFT2xVmY5+LCa75w0Knlqg1ulxTu7cuoGlcnqKBywBd7YRtPp8+64nhmkj+jljut
 MmWA==
X-Gm-Message-State: AOJu0Ywwbp56gsScGr87buJNuYpW0aUyXcTdZIIkDxY7tsz9ktPEDmeL
 KkxHjwXLMWNrOG32EhUbNurrR+OiPKbjt4B84KGqGsk4wdsfCsImaT49Wu4S6w==
X-Gm-Gg: ASbGnctIcolOT+s5DnbUm/Ewdr0L+K1FWx68gE4MEIHJNGk2fMmlJp5y7QpaGypTquR
 3zhY7SBYKz1LurZgOPV4DijkEcjO/8zh6LCfcItvI5kJrFkb675QjMBe69yZDL4wt8HDMXEQdp8
 0aehdWuex9BcI5EFugKQti6N32Ms1osE2xgL/OEHzYOqU/AY+N43q1ugFmtXXBb1QkXf0yp7/8O
 G4FGcZrvhDl42wNv/s2yq8kEm3xwgsaS/VBRlbVFLuST7WVQxI4aP3yI5kfgh7lpoykL+hIztv7
 K1dH0QSBqoLDT6qtp9i22Iohc6zpeaD7w1f5xlHy02tw4nGRvDlHwEMd25rlqPZsMY3tpN4=
X-Google-Smtp-Source: AGHT+IGVM21SYa5pF6+P9y/KaSmVTNeMfRt+FRfe1YDXjUpwGjbVUs3e3mOTKU4ydGyp5DKyzfDXRA==
X-Received: by 2002:a05:6870:6c0c:b0:2d5:cb3:6b1c with SMTP id
 586e51a60fabf-2e9bf1dfe85mr372204fac.14.1748988974905; 
 Tue, 03 Jun 2025 15:16:14 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf:d19a:d10c:4358:1346])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2e906803b1csm2360529fac.21.2025.06.03.15.16.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 15:16:14 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: heiko@sntech.de, quentin.schulz@cherry.de, jonas@kwiboo.se,
 kever.yang@rock-chips.com, philipp.tomsich@vrull.eu, sjg@chromium.org,
 trini@konsulko.com, Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH] rockchip: Add support for GameForce Ace
Date: Tue,  3 Jun 2025 17:13:44 -0500
Message-ID: <20250603221344.372367-1-macroalpha82@gmail.com>
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
 configs/gameforce-ace-rk3588s_defconfig | 69 +++++++++++++++++++++++++
 doc/board/rockchip/rockchip.rst         |  1 +
 5 files changed, 102 insertions(+)
 create mode 100644 board/gameforce/ace-rk3588s/Kconfig
 create mode 100644 board/gameforce/ace-rk3588s/MAINTAINERS
 create mode 100644 configs/gameforce-ace-rk3588s_defconfig

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
index 00000000000..19893a76c15
--- /dev/null
+++ b/configs/gameforce-ace-rk3588s_defconfig
@@ -0,0 +1,69 @@
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
+CONFIG_PCI=y
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
+CONFIG_PCIE_DW_ROCKCHIP=y
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
index b88299cbba2..941d729dbe2 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -141,6 +141,7 @@ List of mainline supported Rockchip boards:
      - Rockchip EVB (evb-rk3588)
      - Edgeble Neural Compute Module 6A SoM - Neu6a (neu6a-io-rk3588)
      - Edgeble Neural Compute Module 6B SoM - Neu6b (neu6b-io-rk3588)
+     - GameForce Ace (gameforce-ace-rk3588s)
      - FriendlyElec CM3588 NAS (cm3588-nas-rk3588)
      - FriendlyElec NanoPC-T6 (nanopc-t6-rk3588)
      - FriendlyElec NanoPi R6C (nanopi-r6c-rk3588s)
-- 
2.43.0

