Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F299C25B74
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 16:48:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B0AA88647;
	Fri, 24 May 2024 18:48:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GIWEp4zT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E516F8866B; Fri, 24 May 2024 18:48:10 +0200 (CEST)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E91888552
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 18:48:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-24c9f892aeaso568597fac.2
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 09:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716569286; x=1717174086; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+vaEk8DYSSYP5McAOCfau4dwx01dIY1hx2ELGIY5IFA=;
 b=GIWEp4zTxz9RTQJRlR0fGF7nJ7CaBdeSGzM7cUwVrrDg7Z6k/2z1J/N0yPl2srltPi
 HPoriOc1PgugdQGm5ISfSvzbqa6+5aTvdArchBAu+XxCZXzN74CbLnXgP2vys73flW48
 OgIa1uTyT25dqr9AOinOeY6fgaXr+SEjW+6jYMAUECpY5sDswVI5iZrba8NqdnPeeP5w
 jaLgrhkePFtCkixn8hSQw94hWZnI5sjq8ex0oureDoBCC7f7Go4GmhSmZ24/zYylQLGe
 2GgmBPa18r2kLfJSC29/BaRFB41sBvmQ2uB+FPs5GMFjAihPrgrXRtPD/Zwl3Twqa2TA
 GnJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716569286; x=1717174086;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+vaEk8DYSSYP5McAOCfau4dwx01dIY1hx2ELGIY5IFA=;
 b=DnjP1JLHFcaXPbbQjoxxhjQ/Mcn/rJVPejzVB7fCrB14Yp5lLHlT/R3vpDXN0jfL/8
 biK9QyWJGSgH1HXckKabouH0Qo/dgfZ5IWIIdokK9wIOELDks8rO6hSn5JVQcTYQRhbo
 SW35TwR7mhdg992BZVefXOedlxcEi7twb3vXrz12GazkfwDEwonxwFmepTJ4BBWeUp2Q
 a43G5AbSC4ZDjAW66SLeU/E/2mRAjq9Uy+fLRMhBf/aN5ETPfOeV+xJgArQXOEzc6avn
 z7zjBY5dZHs39Z2WSSXp9q69daJctFBfi0RUXiZUwcQDDt5aAwK0PiJE/MuytGzAc3NP
 5uiw==
X-Gm-Message-State: AOJu0YwkdIiziYa/vUOnDYR5Uh/4+KGfhd8cQpSH6Qg10x1e2QN21Q8d
 RI54IW/SuSMz51iynbRseCWqI4cSzG574vs/9xHAMI6mqyLNBQNapRBXRg==
X-Google-Smtp-Source: AGHT+IFUEp5xXH3OAVXk+e8JjkfFv06gj47Qu51aA2K3V/PZqY/BLFrDuic1aHMNYrJdCKN9SY/VOw==
X-Received: by 2002:a05:6870:3043:b0:23c:cab7:1310 with SMTP id
 586e51a60fabf-24ca140ece4mr3500371fac.56.1716569284324; 
 Fri, 24 May 2024 09:48:04 -0700 (PDT)
Received: from localhost.localdomain ([75.28.21.198])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-24ca1f7b274sm434445fac.3.2024.05.24.09.48.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 09:48:03 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: kever.yang@rock-chips.com, sjg@chromium.org, philipp.tomsich@vrull.eu,
 jagan@edgeble.ai, Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V4] board: rockchip: Add Indiedroid Nova
Date: Fri, 24 May 2024 11:48:00 -0500
Message-Id: <20240524164800.367544-1-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
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

The Indiedroid Nova is a Rockchip RK3588S based SBC from Indiedroid.

Specifications:

    Rockchip RK3588S SoC
    4x ARM Cortex-A76, 4x ARM Cortex-A55
    4/8/16GB memory LPDDR4x
    Mali G610MC4 GPU
    Optional eMMC
    2x USB 2.0, 2x USB 3.0, 1x USB 3.0 C port with DP Alt
    1x MIPI-CSI Port (4-lane or 2x 2-lane)
    1x MIPI-DSI 4-lane connector
    1x Micro HDMI 2.1 output, 1x DP 1.4 output
    Gigabit Ethernet
    Realtek RTL8821CS WiFi
    4 pin debug UART connector
    40 pin GPIO header
    Size: 85mm x 56mm (Raspberry Pi Form Factor)

Kernel commit:
3900160e164b ("arm64: dts: rockchip: Add Indiedroid Nova board")

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---

Changes since V3:
 - Corrected another typo in the MAINTAINERS file. I think I got them
   all this time.

Changes since V2:
 - Corrected typo in the MAINTAINERS file.
 - Removed OF_UPSTREAM since it is now defined for all RK3588 boards.

Changes since V1:
 - Refactored to use the upstream Linux device tree now that that is
   an option.
 - Added board to doc/board/rockchip/rockchip.rst.

---
 arch/arm/mach-rockchip/rk3588/Kconfig | 10 ++++
 board/indiedroid/nova/Kconfig         | 12 +++++
 board/indiedroid/nova/MAINTAINERS     |  6 +++
 configs/nova-rk3588s_defconfig        | 69 +++++++++++++++++++++++++++
 doc/board/rockchip/rockchip.rst       |  1 +
 include/configs/nova-rk3588s.h        | 15 ++++++
 6 files changed, 113 insertions(+)
 create mode 100644 board/indiedroid/nova/Kconfig
 create mode 100644 board/indiedroid/nova/MAINTAINERS
 create mode 100644 configs/nova-rk3588s_defconfig
 create mode 100644 include/configs/nova-rk3588s.h

diff --git a/arch/arm/mach-rockchip/rk3588/Kconfig b/arch/arm/mach-rockchip/rk3588/Kconfig
index 39049ab35a..820e979abb 100644
--- a/arch/arm/mach-rockchip/rk3588/Kconfig
+++ b/arch/arm/mach-rockchip/rk3588/Kconfig
@@ -78,6 +78,15 @@ config TARGET_NANOPCT6_RK3588
 	  Power: 5.5*2.1mm DC Jack, 12VDC input
 	  Dimensions: 110x80x1.6mm (without case) / 86x114.5x30mm (with case)
 
+config TARGET_NOVA_RK3588
+	bool "Indiedroid Nova RK3588"
+	select BOARD_LATE_INIT
+	help
+	  Indiedroid Nova is a Rockchip RK3588s based SBC by Indiedroid.
+	  It comes in configurations from 4GB of RAM to 16GB of RAM,
+	  includes socket for eMMC storage, an SDMMC slot, and a 40-pin
+	  GPIO header for expansion.
+
 config TARGET_RK3588_NEU6
 	bool "Edgeble Neural Compute Module 6(Neu6) SoM"
 	select BOARD_LATE_INIT
@@ -223,6 +232,7 @@ config TEXT_BASE
 
 source "board/edgeble/neural-compute-module-6/Kconfig"
 source "board/friendlyelec/nanopc-t6-rk3588/Kconfig"
+source "board/indiedroid/nova/Kconfig"
 source "board/pine64/quartzpro64-rk3588/Kconfig"
 source "board/turing/turing-rk1-rk3588/Kconfig"
 source "board/radxa/rock5a-rk3588s/Kconfig"
diff --git a/board/indiedroid/nova/Kconfig b/board/indiedroid/nova/Kconfig
new file mode 100644
index 0000000000..271d15a0ed
--- /dev/null
+++ b/board/indiedroid/nova/Kconfig
@@ -0,0 +1,12 @@
+if TARGET_NOVA_RK3588
+
+config SYS_BOARD
+	default "nova-rk3588s"
+
+config SYS_VENDOR
+	default "indiedroid"
+
+config SYS_CONFIG_NAME
+	default "nova-rk3588s"
+
+endif
diff --git a/board/indiedroid/nova/MAINTAINERS b/board/indiedroid/nova/MAINTAINERS
new file mode 100644
index 0000000000..db1f11551b
--- /dev/null
+++ b/board/indiedroid/nova/MAINTAINERS
@@ -0,0 +1,6 @@
+INDIEDROID-NOVA-RK3588
+M:	Chris Morgan <macromorgan@hotmail.com>
+S:	Maintained
+F:	board/indiedroid/nova
+F:	configs/nova-rk3588s_defconfig
+F:	include/configs/nova-rk3588s.h
diff --git a/configs/nova-rk3588s_defconfig b/configs/nova-rk3588s_defconfig
new file mode 100644
index 0000000000..a2e2440359
--- /dev/null
+++ b/configs/nova-rk3588s_defconfig
@@ -0,0 +1,69 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588s-indiedroid-nova"
+CONFIG_ROCKCHIP_RK3588=y
+CONFIG_SPL_SERIAL=y
+CONFIG_TARGET_NOVA_RK3588=y
+CONFIG_DEBUG_UART_BASE=0xFEB50000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_SYS_LOAD_ADDR=0xc00800
+CONFIG_PCI=y
+CONFIG_DEBUG_UART=y
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_SPL_FIT_SIGNATURE=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588s-indiedroid-nova.dtb"
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
+CONFIG_CMD_USB=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_REGULATOR=y
+# CONFIG_SPL_DOS_PARTITION is not set
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_LIVE=y
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_SPL_REGMAP=y
+CONFIG_SPL_SYSCON=y
+CONFIG_SPL_CLK=y
+CONFIG_ROCKCHIP_GPIO=y
+CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_MISC=y
+CONFIG_SUPPORT_EMMC_RPMB=y
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
+CONFIG_ERRNO_STR=y
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index 9a726e9cde..593070e58b 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -123,6 +123,7 @@ List of mainline supported Rockchip boards:
      - Edgeble Neural Compute Module 6B SoM - Neu6b (neu6b-io-rk3588)
      - FriendlyElec NanoPC-T6 (nanopc-t6-rk3588)
      - Generic RK3588S/RK3588 (generic-rk3588)
+     - Indiedroid Nova (nova-rk3588s)
      - Pine64 QuartzPro64 (quartzpro64-rk3588)
      - Radxa ROCK 5A (rock5a-rk3588s)
      - Radxa ROCK 5B (rock5b-rk3588)
diff --git a/include/configs/nova-rk3588s.h b/include/configs/nova-rk3588s.h
new file mode 100644
index 0000000000..0edd1ce888
--- /dev/null
+++ b/include/configs/nova-rk3588s.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2022 Collabora Ltd.
+ */
+
+#ifndef __NOVA_RK3588S_H
+#define __NOVA_RK3588S_H
+
+#define ROCKCHIP_DEVICE_SETTINGS \
+		"stdout=serial,vidconsole\0" \
+		"stderr=serial,vidconsole\0"
+
+#include <configs/rk3588_common.h>
+
+#endif /* __NOVA_RK3588S_H */
-- 
2.34.1

