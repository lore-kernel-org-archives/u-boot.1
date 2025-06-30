Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F38BC7EE39
	for <u-boot@archiver.kernel.org>; Mon, 30 Jun 2025 10:25:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8AC481FEE;
	Mon, 30 Jun 2025 12:25:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="km6vXrMl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EA318206E; Mon, 30 Jun 2025 12:25:30 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FB5F81D6A
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 12:25:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-45348bff79fso19352645e9.2
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 03:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751279127; x=1751883927; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GQS3gj4HeQW7or2PpVQnth/VAWv4usOelidn287QY2U=;
 b=km6vXrMlaczv2IDBHVdl9ejiCqtmWWAryZhJ1IQ/q3sfQLbCm60NcM4PuPb/AShEPt
 Rn6MCvdyRggLWLoJoI4852ffJ3JxDJZg+nxdOkcMYzh48v4xrRapX+JyzIqXiNaqwVVO
 7aYpczaBbyL5XThYD2G6TXbrbMDuMxm+tNT7ITodD2DkCMxwsdlWVUPftcDiTVCBOlXj
 qUZxpWnWDZ3nabngDuy1VFpF+bdjWXrQinBkndPKRhiJc2U60vgDtnscwHlIVAFj0Y+s
 jDcG5pQMiH6BY5mI/UFKFSCCvjlgE2uIaez+01AqdmWn4+frhBxyhUSLn31rKLKK3+D8
 HyEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751279127; x=1751883927;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GQS3gj4HeQW7or2PpVQnth/VAWv4usOelidn287QY2U=;
 b=FJdq31IQ/1F4lSsEF4Uzo5CFRQUnQ8GCuanfrSaBLHYcUBHWFHi69Uo1D29vD8vIHQ
 eabaMFvCfaTZ3/F6cPIkXqTWKf53Wdp+4OJdji0zR7qx95BsSiRU/dHiZliostzAZUkV
 5cPYJ54zRY/yU1xtpDjZIJ+ny3/Xje4cvJt+/WL/qcYpzIKvgpvPrmf/hUHb3y79ek/N
 KV0EA17vUDjqBiGvmTZXkchdfdOI+jcdp/ZoW968MIv55oRYWw9m0k2AK+2i374Clzvq
 tJMdtRtPcGeiMXHmcUlH0NqzycV9gO50v9PutHUQbA7jHddZXeILXym2MLqLuRW/yEWQ
 TCIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmY7eHKAIn8UmhkSg04f7VM2Sc0JcXolZGg/HL6uexME6Ic7VG3E/VJi9JXzmAPrHen1kdSoo=@lists.denx.de
X-Gm-Message-State: AOJu0Yw7so++jYWFWQAlUNsBtQp/vME1VPCvCg3U6f35xsJxyWurt33F
 VzoRiYB428TAAfJvpJhuLjdAm7G9zbMBj7iuYwX/znB7i429s8yWQ1Sr
X-Gm-Gg: ASbGnct14hx9z/kFIT2yIphQZP4MrSawqIsPlA/r+2RjpOWG1+A4tRtf0maXZ/PXF3U
 cznkkL0uziAfFrkrP6NjxpDHB5pVR40HNAHVrF4erOo2qEtZ1ScAALgpxcgEtg4dCLqd+IGy+5H
 Nj+QLkvbIRlH/r/v7PCJdCbOJwDc9nPkYnYz9ANwgCkh+/82cQ3vXNCBK39BFKpYlyQHS7M1n9D
 JLGq/RoLP6+8NdP03Hze9AEvvFO18N+Vt6+laFH24+i+JMG7KGlFE+nOYvBI8ZmVxy6dxIVxKsg
 kCDUfPp98MPFtoVRpoCms1Cl7bb0OVrNiXQ0pwYb4Uul+AptYjZTWZaEaWjtEcmSHg5dOD4M4Pd
 O7VTX78SOu2qwwow63J2sfU/4FDX4SJwOMRDcABKsG8JgoJRmrXMBM2NVtfQUS8D3OwS0TQKelo
 d+NVJFbbva0pFQ7S/lJQZh
X-Google-Smtp-Source: AGHT+IE4IJZBx+/JOjj6NEn7qfz8ippy/8Eehnr95m27ZNIsrjhBH8jbm2zZ37j+Ki7geKN6bbU7zQ==
X-Received: by 2002:a05:600c:310e:b0:43c:fcbc:9680 with SMTP id
 5b1f17b1804b1-4538ee84c6emr115416025e9.25.1751279127184; 
 Mon, 30 Jun 2025 03:25:27 -0700 (PDT)
Received: from cypher.home.roving-it.com
 (2.c.4.1.7.3.6.4.2.a.a.3.0.f.c.2.1.8.6.2.1.1.b.f.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:fb11:2681:2cf0:3aa2:4637:14c2])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4538a3a57c2sm130450895e9.12.2025.06.30.03.25.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 03:25:26 -0700 (PDT)
From: Peter Robinson <pbrobinson@gmail.com>
To: Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Cc: Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH] board: rockchip: Add support for rk3588 MNT Reform2
Date: Mon, 30 Jun 2025 11:25:20 +0100
Message-ID: <20250630102524.127970-1-pbrobinson@gmail.com>
X-Mailer: git-send-email 2.50.0
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

Add support for MNT Reform2, it works as a carrier board
with a Firefly iCore-3588Q SoM.

Specification:
- Rockchip RK3588
- LPDDR5X 16/32 GB
- eMMC 128/256 GB
- HDMI Type A out x 1
- USB 3.0 Host x 1
- USB-C 3.0 with DisplayPort AltMode
- PCIE M.2 E Key for Wireless connection
- PCIE M.2 M Key for NVME connection
- DSI to eDP panel
- 1Gb Ethernet w/ Microchip KSZ9310 PHY

Tested using Fedora boot on USB stick and eMMC.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---
 arch/arm/dts/rk3588-mnt-reform2-u-boot.dtsi | 14 ++++
 board/rockchip/evb_rk3588/MAINTAINERS       |  6 ++
 configs/mnt-reform2-rk3588_defconfig        | 87 +++++++++++++++++++++
 doc/board/rockchip/rockchip.rst             |  1 +
 4 files changed, 108 insertions(+)
 create mode 100644 arch/arm/dts/rk3588-mnt-reform2-u-boot.dtsi
 create mode 100644 configs/mnt-reform2-rk3588_defconfig

diff --git a/arch/arm/dts/rk3588-mnt-reform2-u-boot.dtsi b/arch/arm/dts/rk3588-mnt-reform2-u-boot.dtsi
new file mode 100644
index 00000000000..d54220a3271
--- /dev/null
+++ b/arch/arm/dts/rk3588-mnt-reform2-u-boot.dtsi
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+#include "rk3588-u-boot.dtsi"
+
+/ {
+	chosen {
+		u-boot,spl-boot-order = "same-as-spl", &sdmmc, &sdhci;
+	};
+};
+
+&fspim2_pins {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
diff --git a/board/rockchip/evb_rk3588/MAINTAINERS b/board/rockchip/evb_rk3588/MAINTAINERS
index 1232f05a387..24cf13c3c48 100644
--- a/board/rockchip/evb_rk3588/MAINTAINERS
+++ b/board/rockchip/evb_rk3588/MAINTAINERS
@@ -29,6 +29,12 @@ F:	configs/generic-rk3588_defconfig
 F:	arch/arm/dts/rk3588-generic.dts
 F:	arch/arm/dts/rk3588-generic-u-boot.dtsi
 
+MNT-REFORM2-RK3588
+M:	Peter Robinson <pbrobinson@gmail.com>
+S:	Maintained
+F:	configs/mnt-reform2-rk3588_defconfig
+F:	arch/arm/dts/rk3588-mnt-reform2-u-boot.dtsi
+
 ORANGEPI-5-RK3588
 M:	Jonas Karlman <jonas@kwiboo.se>
 S:	Maintained
diff --git a/configs/mnt-reform2-rk3588_defconfig b/configs/mnt-reform2-rk3588_defconfig
new file mode 100644
index 00000000000..e76c714b03d
--- /dev/null
+++ b/configs/mnt-reform2-rk3588_defconfig
@@ -0,0 +1,87 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588-mnt-reform2"
+CONFIG_ROCKCHIP_RK3588=y
+CONFIG_SPL_SERIAL=y
+CONFIG_TARGET_EVB_RK3588=y
+CONFIG_SYS_LOAD_ADDR=0xc00800
+CONFIG_DEBUG_UART_BASE=0xFEB50000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_PCI=y
+CONFIG_DEBUG_UART=y
+CONFIG_USE_PREBOOT=y
+CONFIG_PREBOOT="pci enum; usb start; nvme scan;"
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_SPL_FIT_SIGNATURE=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-mnt-reform2"
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_SPL_MAX_SIZE=0x40000
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_SPL_ATF=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
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
+CONFIG_LED=y
+CONFIG_LED_GPIO=y
+CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_MISC=y
+CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_MMC_HS400_ES_SUPPORT=y
+CONFIG_SPL_MMC_HS400_ES_SUPPORT=y
+CONFIG_MMC_HS400_SUPPORT=y
+CONFIG_SPL_MMC_HS400_SUPPORT=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SDMA=y
+CONFIG_MMC_SDHCI_ROCKCHIP=y
+CONFIG_PHY_MICREL=y
+CONFIG_PHY_MICREL_KSZ90X1=y
+CONFIG_DWC_ETH_QOS=y
+CONFIG_DWC_ETH_QOS_ROCKCHIP=y
+CONFIG_PHYLIB=y
+CONFIG_NVME_PCI=y
+CONFIG_PCIE_DW_ROCKCHIP=y
+CONFIG_PHY_ROCKCHIP_INNO_USB2=y
+CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
+CONFIG_PHY_ROCKCHIP_USBDP=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_DM_PMIC=y
+CONFIG_PMIC_RK8XX=y
+CONFIG_REGULATOR_RK8XX=y
+CONFIG_PWM_ROCKCHIP=y
+CONFIG_SPL_RAM=y
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
index b88299cbba2..0c2c294e6cb 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -149,6 +149,7 @@ List of mainline supported Rockchip boards:
      - Hardkernel ODROID-M2 (odroid-m2-rk3588s)
      - Indiedroid Nova (nova-rk3588s)
      - Khadas Edge2 (khadas-edge2-rk3588s)
+     - MNT Reform2 (mnt-reform2-rk3588)
      - Pine64 QuartzPro64 (quartzpro64-rk3588)
      - Radxa ROCK 5 ITX (rock-5-itx-rk3588)
      - Radxa ROCK 5A (rock5a-rk3588s)
-- 
2.50.0

