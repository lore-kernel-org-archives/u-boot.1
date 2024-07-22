Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D24FC3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 10:56:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DBE587EFA;
	Mon, 22 Jul 2024 12:56:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fDZ7cuqg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92ED687FED; Mon, 22 Jul 2024 12:56:30 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FD4C87EDC
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 12:56:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maximmosk4@gmail.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-52efd530a4eso2359118e87.0
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 03:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721645787; x=1722250587; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EmSGqWagZiXFhRTw616nhLDQrkVwyGEZ/KWInSfISAA=;
 b=fDZ7cuqgVnZ2fkIzVVmKmUHxSoymNClcdkY+9W6eEbv87sWg1uexkoohlHkxsNaRQq
 xmMFw7L6RiCnH7zzYVrP6tSHJbO3F/+2eDbIpy0j5PHuC/+zf9OrfaLwaL+5wK57CAGN
 2Be5/yrVCTxAYCNAsXKBwivjxRL1lSOUD/RyYwH2ki7c36Bn4WGvELw9rAxbscy0g+YV
 tkV9FmthOQrXO9GxUIDR9VOWxQHC7tV/KX16RXVI77mmC9sd+Ob7yvtWBUaZBxJiNQ4R
 dLsy5wFWZJXjhREPKYrsrYCijNJR68+kVioF+K0IhuIkvG/zoaEaW8ZE4tnbdgDg9BYI
 68sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721645787; x=1722250587;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EmSGqWagZiXFhRTw616nhLDQrkVwyGEZ/KWInSfISAA=;
 b=jCC5KmS4Kd+MoZZpCTulonPEUatmhu+0WLOdF6HL4+6L4PMCNNGvUY8QpEoSmYz6x8
 5szs2nQ2ILr8hav/9VFW6jTTZfc7avie2qdCbucGnZdrRDsGjPWVZB/gMrCNo7/iGCLN
 7cSdwZZLclBj/ZIlzPB9FC1y/rzuE0jlG8i+Xs243cWg/EPgsK8zt6hiHtqCOKFdE1Bx
 kdemLBNa5J36MsSQrZXIVnb6rMMa+tV6JesN6ulhjkYaLauGkgwe/xEuT7MXJnf1czz9
 hIUhD4oZA5GGXMycsPKbG6owKEmXvv35O41Dc0ohI4GxFclSJUz5EaKntYschaD/GGPx
 Vrfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXf2yR3JDqk9M9yDMpH9W2svr8E0vLWfX7+2pTyO/nVJodgpHHJI86zWeDmJ1koIJc8JKrffCvfPmn9FTbxakgSygzIsQ==
X-Gm-Message-State: AOJu0YymCnr8lgIx0nWcYOKrBEi4hfveNRKF5On+iLTYg/e6ii9IIKzZ
 Om2T8tX30qF55+acMUah6fux01Zc5vTn+u8onAesFOQQmR6PV2iQ
X-Google-Smtp-Source: AGHT+IGwL+0eqAX6o9ahMH+bTQtwKBu2OSnUS6Yy/tORqA4GlZHlUHiIhOOPccCq12PgXrBCwE/3pw==
X-Received: by 2002:a05:6512:39c6:b0:52f:53c8:25ca with SMTP id
 2adb3069b0e04-52f53c826bemr1064716e87.64.1721645787197; 
 Mon, 22 Jul 2024 03:56:27 -0700 (PDT)
Received: from moskalets-nb.kdtln.ru (109-252-15-116.nat.spd-mgts.ru.
 [109.252.15.116]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-52fc2b5165dsm50678e87.18.2024.07.22.03.56.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 03:56:26 -0700 (PDT)
From: Maxim Moskalets <maximmosk4@gmail.com>
X-Google-Original-From: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
To: trini@konsulko.com,
	u-boot@lists.denx.de,
	sjg@chromium.org
Cc: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>,
 Maxim Moskalets <maximmosk4@gmail.com>, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v4] board: rockchip: add Radxa ROCK 3 Model C
Date: Mon, 22 Jul 2024 13:56:23 +0300
Message-Id: <20240722105623.74606-1-Maxim.Moskalets@kaspersky.com>
X-Mailer: git-send-email 2.39.2
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

Based on rock-3a-rk3568_defconfig.
Tested on v1.31 revision.

Board Specifications:
- Rockchip RK3566
- 1/2/4GB LPDDR4 2112MT/s
- eMMC socket
- uSD card slot
- M.2 2230 Connector
- GbE LAN with POE
- 3.5mm jack with mic
- HDMI 2.0, MIPI DSI/CSI
- USB 3.0 Host/OTG, USB 2.0 Host
- 40-pin GPIO expansion ports

Signed-off-by: Maxim Moskalets <maximmosk4@gmail.com>
Suggested-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Jonas Karlman <jonas@kwiboo.se>
---
v4:
	fixed typo in commit-msg
	moved maintainers record to file for rk3568 boards
	renamed from ROCK 3 Model C to ROCK3C
v3:
	add suggested by Jonas Karlman <jonas@kwiboo.se> in
	https://lore.kernel.org/all/bbb81dd1-e318-423d-8258-db7556ce6850@kwiboo.se/
v2:
	rebase to updated upstream dts
---
 arch/arm/dts/rk3566-rock-3c-u-boot.dtsi | 10 +++
 board/rockchip/evb_rk3568/MAINTAINERS   |  7 ++
 configs/rock-3c-rk3566_defconfig        | 97 +++++++++++++++++++++++++
 doc/board/rockchip/rockchip.rst         |  1 +
 4 files changed, 115 insertions(+)
 create mode 100644 arch/arm/dts/rk3566-rock-3c-u-boot.dtsi
 create mode 100644 configs/rock-3c-rk3566_defconfig

diff --git a/arch/arm/dts/rk3566-rock-3c-u-boot.dtsi b/arch/arm/dts/rk3566-rock-3c-u-boot.dtsi
new file mode 100644
index 00000000000..fd7f5367b75
--- /dev/null
+++ b/arch/arm/dts/rk3566-rock-3c-u-boot.dtsi
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+#include "rk356x-u-boot.dtsi"
+
+&sfc {
+	flash@0 {
+		bootph-pre-ram;
+		bootph-some-ram;
+	};
+};
diff --git a/board/rockchip/evb_rk3568/MAINTAINERS b/board/rockchip/evb_rk3568/MAINTAINERS
index e5b0986ead9..ba4884db8e1 100644
--- a/board/rockchip/evb_rk3568/MAINTAINERS
+++ b/board/rockchip/evb_rk3568/MAINTAINERS
@@ -69,3 +69,10 @@ S:	Maintained
 F:	configs/rock-3a-rk3568_defconfig
 F:	arch/arm/dts/rk3568-rock-3a.dts
 F:	arch/arm/dts/rk3568-rock-3a-u-boot.dtsi
+
+ROCK-3C
+M:	Jonas Karlman <jonas@kwiboo.se>
+M:	Maxim Moskalets <maximmosk4@gmail.com>
+S:	Maintained
+F:	arch/arm/dts/rk3566-rock-3c-u-boot.dtsi
+F:	configs/rock-3c-rk3566_defconfig
diff --git a/configs/rock-3c-rk3566_defconfig b/configs/rock-3c-rk3566_defconfig
new file mode 100644
index 00000000000..f44b202c8c3
--- /dev/null
+++ b/configs/rock-3c-rk3566_defconfig
@@ -0,0 +1,97 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_SF_DEFAULT_SPEED=24000000
+CONFIG_SF_DEFAULT_MODE=0x2000
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3566-rock-3c"
+CONFIG_ROCKCHIP_RK3568=y
+CONFIG_ROCKCHIP_SPI_IMAGE=y
+CONFIG_SPL_SERIAL=y
+CONFIG_DEBUG_UART_BASE=0xFE660000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_SPL_SPI_FLASH_SUPPORT=y
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
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3566-rock-3c.dtb"
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_SPL_MAX_SIZE=0x40000
+CONFIG_SPL_PAD_TO=0x7f8000
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_SPL_SPI_LOAD=y
+CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
+CONFIG_SPL_ATF=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_POWEROFF=y
+CONFIG_CMD_USB=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_PMIC=y
+CONFIG_CMD_REGULATOR=y
+# CONFIG_SPL_DOS_PARTITION is not set
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_LIVE=y
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_SPL_REGMAP=y
+CONFIG_SPL_SYSCON=y
+CONFIG_SCSI_AHCI=y
+CONFIG_AHCI_PCI=y
+CONFIG_SPL_CLK=y
+CONFIG_ROCKCHIP_GPIO=y
+CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_LED=y
+CONFIG_LED_GPIO=y
+CONFIG_MISC=y
+CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SDMA=y
+CONFIG_MMC_SDHCI_ROCKCHIP=y
+CONFIG_SF_DEFAULT_BUS=4
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_SPI_FLASH_GIGADEVICE=y
+CONFIG_SPI_FLASH_MACRONIX=y
+CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_SPI_FLASH_XTX=y
+CONFIG_PHY_REALTEK=y
+CONFIG_DWC_ETH_QOS=y
+CONFIG_DWC_ETH_QOS_ROCKCHIP=y
+CONFIG_NVME_PCI=y
+CONFIG_PCIE_DW_ROCKCHIP=y
+CONFIG_PHY_ROCKCHIP_INNO_USB2=y
+CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_DM_PMIC=y
+CONFIG_PMIC_RK8XX=y
+CONFIG_REGULATOR_RK8XX=y
+CONFIG_SPL_RAM=y
+CONFIG_SCSI=y
+CONFIG_BAUDRATE=1500000
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_SYS_NS16550_MEM32=y
+CONFIG_ROCKCHIP_SFC=y
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
index bedc52e03e2..60357af6caa 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -105,6 +105,7 @@ List of mainline supported Rockchip boards:
      - Pine64 SOQuartz on Model A (soquartz-model-a-rk3566)
      - Powkiddy X55 (powkiddy-x55-rk3566)
      - Radxa CM3 IO Board (radxa-cm3-io-rk3566)
+     - Radxa ROCK 3C (rock-3c-rk3566)
 
 * rk3568
      - Rockchip Evb-RK3568 (evb-rk3568)
-- 
2.39.2

