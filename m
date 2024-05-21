Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65DFDC25B7C
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 15:34:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6438882A7;
	Tue, 21 May 2024 17:34:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G6RNPRWb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E9BC882AC; Tue, 21 May 2024 17:34:03 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84D7D88013
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 17:34:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-6f0277767fbso1230571a34.3
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 08:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716305639; x=1716910439; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CAfZMOQAGoH+dMeRT/mE3oZITxBkYxI/gajM1JKdLVc=;
 b=G6RNPRWbX2h7aXm19BHDqvLn6u79qiNr8LPWMUdNj+BTwoFGrew/5BzG6MVOdleYRw
 LSy79xHSAhtnsHAreByij6sUpwFjTEcvhKOcslyzmNBvbfy6N6cgqzb4e3yTYC913Ziz
 6wycFQnVL5xXWxn0mGy+0BJYlRXPk9wSLKltSJ3UJbkGaixgQHR6WK5uLhG31CmPmSTg
 D80QGTMLj6NY5/NrLngazfhRfRvda/mo2lzfFV4aD+LGDTjq+r3wYMxdm1693IXZACzN
 XuDuLc/qUwy99HAN9hljWOXCOzRKIIuQZbTFi6tcAeRF+nTxNAhr59ZGvQiBiz+qX+C4
 BPxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716305639; x=1716910439;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CAfZMOQAGoH+dMeRT/mE3oZITxBkYxI/gajM1JKdLVc=;
 b=s5KuEg7agfqyyH6obVZKaN0AEZeRneeXj+4joEtdYEcr7SMkidRKOY2Dxaj9jf8Zuq
 TNzejV1rSzkVwZUcxu5CfU6gwJLq/1qjaOQtsp1Vy47p2IOK/c2whU5mcqerJx0nkShH
 Bh2FgS/8TFYsJGcIR4iVX9hdMQWT7eKBSM0F935ikBMJ9J3xkK0IgAToCE8+9ODY2pgH
 A3aagLL72zTIg/se03rH2FdJJAy2BLbBRivm3anSs8zN7xdpGWyvBNC2f44tEBrsFpBD
 GZ1SjwaJUoYDHo598/q5iLLUenNfgaQn/9l6wu/D8egS0VoqzfG1RMgyKklDIXDkSzj4
 OCcQ==
X-Gm-Message-State: AOJu0Yy2P66Lem0yUS0k8c74pBRK9tfL7xSI9qtUeDagKLSGu1PSBdn3
 FirIOCFb3Ash4alWpZ2gyrSa1GZ9CfexoHEirKuSfGvU9ToJIojwBwLWqw==
X-Google-Smtp-Source: AGHT+IHWBUfsiXUr0k398X07Mp97A4Wg1K1u0QT2KrlfEh0R3v/gWXn2E2MSZAnZMtrE53+5Djm7Mw==
X-Received: by 2002:a05:6830:1290:b0:6f0:6864:eee6 with SMTP id
 46e09a7af769-6f0e911398fmr33939895a34.10.1716305639009; 
 Tue, 21 May 2024 08:33:59 -0700 (PDT)
Received: from localhost.localdomain ([75.28.21.198])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6f0fdc57a9csm3601164a34.58.2024.05.21.08.33.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 May 2024 08:33:58 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, kever.yang@rock-chips.com, sjg@chromium.org,
 philipp.tomsich@vrull.eu, jagan@edgeble.ai,
 Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V3] board: rockchip: Add Indiedroid Nova
Date: Tue, 21 May 2024 10:33:50 -0500
Message-Id: <20240521153350.238644-1-macroalpha82@gmail.com>
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
index 0000000000..db40adf9ad
--- /dev/null
+++ b/board/indiedroid/nova/MAINTAINERS
@@ -0,0 +1,6 @@
+INDIEDROID-NOVA-RK3588
+M:	Chris Morgan <macromorgan@hotmail.com>
+S:	Maintained
+F:	board/indiedroid/nova
+F:	include/configs/nova-rk3588s.h
+F:	configs/indiedroid-nova-rk3588s_defconfig
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

