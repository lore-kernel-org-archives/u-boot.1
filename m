Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8AEAC3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 07:49:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32A1888137;
	Mon, 22 Jul 2024 09:49:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V6tmeH6k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29B4788216; Mon, 22 Jul 2024 09:49:21 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD3C88800C
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 09:49:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maximmosk4@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-52f04c29588so632580e87.3
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 00:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721634558; x=1722239358; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7aD1aCeUX7BrqF5pPc93bLBTpRngVY7tuvl/mmUzhZo=;
 b=V6tmeH6kdWdNsI2eWqNIwwZsM4nPzoMWGLdvNeCm2V1g4vRMOBKE040hicR0WPIHWz
 xOAfIkzBq6kY9cw1nKfV7GW0m9U3Z3aRfcz1inEqmnOSTS0UCh5L2Rh7GEWSFZhrs2aK
 1aoXbK0aNkKvafDd1X3NQT7iDDwJLhh4C4hLw1W+lubkcongvIAwxbbvshox47YzjfD3
 czaZaLsfgL8CJCZVO4N1KcmXHFkmCa8lEyGvuMfQ0Y4OZVdqUHdaxLDmqclXmLs2J3Pq
 UR675/kDsgaTlPFHrpesT6h/tdasML23gKsZ/VBHKhWll8dmWqc1Y8BSLLHBe1pMDjrg
 IX4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721634558; x=1722239358;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7aD1aCeUX7BrqF5pPc93bLBTpRngVY7tuvl/mmUzhZo=;
 b=ZTUsIqPMb1+6q7nhCWwt626VnnUB9ebYQJq2DDHE9/x7tFBgie6q3JPHmOk4M+NRIe
 ciF1WbhC3PHY40ClM5YxbpxW0pybYz5dDrw51qqIcqlVjl5FC801I/qgwNuBMVIzSr+l
 8XHOafiEObeb2L6lLOfWiZk/NdmmW/dV/8IbHZo48FMUjUTaANCXbSKaj5q6meGUB3Fz
 RXsEQoyDXJpC43TLjrme4mp+fNyITLQc9/U/ghSPSvnTW5oSMg4nmrH5Np8pZtwtoszZ
 7ZlAS6Bjij2kZl0OD1VyjZ7modRsmwce3DmGmlnCyH7PQ9peLkw1SltYt7FUwan3epYq
 60xQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRjI0CNUBy0IS71mZtZR9kjlPgil4hGzW3ITFjLPAnkmnOjxCndG5cuSIhCv3ioDJ/qoil1eT1PZbhVEJV54azwvj5qA==
X-Gm-Message-State: AOJu0YyD2KWOiBaz7dY1RRpuY5XKlY0YgM4cD9t3TLH5SYOzPCrk+cxD
 kw3sRntj3VOPrKl6W47XzXOYfVgfyK/uL3ZUVdfOzkV0+0bDYLQz
X-Google-Smtp-Source: AGHT+IGYWoiDhtyxXJbasbOUiPoWcKszIfzDoavqOIgqiDcQvF4lZF5xBHjFl5HDjYdXUmQpiChXrA==
X-Received: by 2002:a05:6512:3184:b0:52e:7f6b:5786 with SMTP id
 2adb3069b0e04-52efb8a5b0cmr2877314e87.61.1721634557790; 
 Mon, 22 Jul 2024 00:49:17 -0700 (PDT)
Received: from moskalets-nb.kdtln.ru (109-252-15-116.nat.spd-mgts.ru.
 [109.252.15.116]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-52ef553c1cfsm1111112e87.71.2024.07.22.00.49.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 00:49:17 -0700 (PDT)
From: Maxim Moskalets <maximmosk4@gmail.com>
X-Google-Original-From: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
To: trini@konsulko.com,
	u-boot@lists.denx.de,
	sjg@chromium.org
Cc: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>,
 Maxim Moskalets <maximmosk4@gmail.com>, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v3] board: rockchip: add Radxa ROCK 3 Model C
Date: Mon, 22 Jul 2024 10:49:07 +0300
Message-Id: <20240722074907.28507-1-Maxim.Moskalets@kaspersky.com>
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
Tesetd on v1.31 revision.

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
---
v3:
	add suggested by Jonas Karlman <jonas@kwiboo.se> in
	https://lore.kernel.org/all/bbb81dd1-e318-423d-8258-db7556ce6850@kwiboo.se/
v2:
	rebase to updated upstream dts
---
 MAINTAINERS                             |  7 ++
 arch/arm/dts/rk3566-rock-3c-u-boot.dtsi | 10 +++
 configs/rock-3c-rk3566_defconfig        | 97 +++++++++++++++++++++++++
 doc/board/rockchip/rockchip.rst         |  1 +
 4 files changed, 115 insertions(+)
 create mode 100644 arch/arm/dts/rk3566-rock-3c-u-boot.dtsi
 create mode 100644 configs/rock-3c-rk3566_defconfig

diff --git a/MAINTAINERS b/MAINTAINERS
index a6e47e8a217..b87077d3adb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -492,6 +492,13 @@ F:	include/configs/owl-common.h
 F:	configs/bubblegum_96_defconfig
 F:	configs/cubieboard7_defconfig
 
+ARM RADXA ROCK 3 MODEL C
+M:	Jonas Karlman <jonas@kwiboo.se>
+M:	Maxim Moskalets <maximmosk4@gmail.com>
+S:	Maintained
+F:	arch/arm/dts/rk3566-rock-3c-u-boot.dtsi
+F:	configs/rock-3c-rk3566_defconfig
+
 ARM RENESAS RMOBILE/R-CAR
 M:	Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
 M:	Marek Vasut <marek.vasut+renesas@mailbox.org>
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
index bedc52e03e2..69976ab2463 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -105,6 +105,7 @@ List of mainline supported Rockchip boards:
      - Pine64 SOQuartz on Model A (soquartz-model-a-rk3566)
      - Powkiddy X55 (powkiddy-x55-rk3566)
      - Radxa CM3 IO Board (radxa-cm3-io-rk3566)
+     - Radxa ROCK 3 Model C (rock-3c-rk3566)
 
 * rk3568
      - Rockchip Evb-RK3568 (evb-rk3568)
-- 
2.39.2

