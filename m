Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1842DCD5BC9
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 11:29:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 508378056B;
	Wed, 27 May 2026 13:29:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="icBH/olY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0E0C8341A; Wed, 27 May 2026 13:29:34 +0200 (CEST)
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F696803C6
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 13:29:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=coiaprant@gmail.com
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-2b9ec9443c2so64961675ad.1
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 04:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779881371; x=1780486171; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yd+rsm06THkUoOEfDAdZ0jh3ruTY3HV4/NzKVvhr+dU=;
 b=icBH/olY8J/aGlIxoT7Wrq0sKhPidyB/S1uGHeNmLzun0a6Y7LZyYOT+IWB9wgqfk+
 j+e0wyDrO8Y9GYjg7zctaSpW2QrbKRhLSshHylW3sfOo0lRBrr90XMSCICVXssWCdNpm
 rqXzF2aOjdEzxqml4yCezNMeQdE/Jhu3jKnY/4xrS0k47BYBkUfhGTz3Y51NnaIttfcn
 CCHeFCJc5VUqnjKlb6yxZ+dhaURMphS/+Td82vtokteh+BJjJu/cvl5E8V4ICIIPng3c
 CfwBdGs0C+vWq4pIffoKdu+CIRXcZMOgMo4iIJwyL6vkLDPLpY8pB9A+s7inrp7GZD3u
 +I/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779881371; x=1780486171;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yd+rsm06THkUoOEfDAdZ0jh3ruTY3HV4/NzKVvhr+dU=;
 b=E//ZKjUDpwFfcPc78t4Aq1HwIB8vawT9//amhrizDRghgrx+uv2S3x9Ejq8Bgtvt4Z
 NI+Bdz6SMRye7aVr+dwU/iXApEQGnYy4chEe1WPE2I0rRCUKUZ2KcByNRhSwHy6W1yEo
 6MJt4nz9a8tch2slOvDyT9ySNYWosWlTBNsnUY7kmn5F7zYW8cUkgk9VkjOrCeUG7v/4
 r+EGRrxxf3aRVPzYOthR/dY6Pww/Pc5uXs4RF5/OX/GG+B65rlU6xDNwKocosvb3UN3Z
 clp+B8ndIirFz0FJ28JmWmVxuDnPPrWDL2Rz73t1sNGp6xtuiGg0zK4VsZruBDl3sBwp
 ZmvA==
X-Gm-Message-State: AOJu0Yy3IP91fJH90voKjFavA2MztKaq45S14R+35BexRA0ILbs0I7yj
 84r/syNfcpkSjPxd+YHIGxZ6hF3cnMeO3n4YTjE5pQ4YMNJoOl+pnsso
X-Gm-Gg: Acq92OEPMOAWY1wdvbaD5XlidkmjjGw6ITx5sz1T3cdDQXd4+2pHITtw2PNHR3Isff1
 aIePDsh6Kbv15tUCmYimJqIp2rsqInot43RIRwHYvILMJFZd+t8DhVy+OnzN3Vsc4SzGl+Fe1kz
 zjIDSeyBFdZf+5jMieCl4pKo/B6OrzYUcPL+joBED4Llfk+8Qab5vFSNFK9WXzLWp5H35EgnOFF
 r9as3UQFH4wkyfdoTGRWns/9VYN7Fv6II3eolk+Jy02O5wDO8vEiERbX2SVC3MaNlxJ/bErbLrH
 8BtUp3ogb/zsNlY5pUXV5WWveHl9WoyJUsLzJZG7UFx1BhVUs4y4gqw+ZJdqHCHLX3oNepVw0PW
 NWr+5tdY6WnwwgamefebVGt77TokrVOqKNhQIdTILNKlchjoaFEShZeNHG5T7hsQZwt//hPLvcn
 Jd3CxFxVmQmS4EDJ8fLw==
X-Received: by 2002:a17:902:d60d:b0:2ba:838b:bfae with SMTP id
 d9443c01a7336-2beb089e812mr201432495ad.18.1779881370610; 
 Wed, 27 May 2026 04:29:30 -0700 (PDT)
Received: from server.lan ([103.213.4.16]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb58c49b2sm145268695ad.60.2026.05.27.04.29.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 04:29:30 -0700 (PDT)
From: Coia Prant <coiaprant@gmail.com>
To: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de,
	Coia Prant <coiaprant@gmail.com>
Subject: [PATCH] board: rockchip: Add for 9Tripod X3568 v4
Date: Wed, 27 May 2026 19:29:22 +0800
Message-ID: <20260527112922.554052-1-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The 9Tripod X3568 v4 is an RK3568-based SBC, just like the RK3568-EVB.
It always uses soldered connections between the X3568CV2/X3568CV3/X3568CV4 core board
and the X3568bv4 I/O board.

The differences between the core boards
- PCB size, layout
- CPU (RKK3568B2/RK3568J)
- Memory type (DDR4/LPDDR4/LPDDR4X) and size
- eMMC size
- DSI/EDP resistor values
Although the components vary, they maintain full compatibility.

The X3568 board has multiple hardware revisions, and we currently support v4 (I/O board).

Specification:
- SoC: RockChip RK3568 ARM64 (4 cores)
- eMMC: 16-128 GB
- RAM: 2-16 GB
- Power: DC 12V 2A
- Ethernet: 2x YT8521SC RGMII (10/100/1000 Mbps)
- Wireless radio: 802.11b/g/n/ac/ax dual-band
- LED:
  Power: AlwaysOn
  User: GPIO
- Button:
  VOL+: SARADC/0 <35k µV>
  VOL-: SARADC/0 <450k µV>
  Power/Reset: PMIC RK809
- CAN
  CAN/1: 4-pin (PH 2.0)
- PWM
  PWM/4: Backlight DSI/0 DSI/1
  PWM/7: IR Receiver [may not install]
- UART:
  UART/2: Debug TTL - 1500000 8N1 (1.25mm)
  UART/3: TTL (PH 2.0)
  UART/4: TTL (PH 2.0)
  UART/8: AP6275S Bluetooth
  UART/9: TTL (PH 2.0)
- I2C:
  I2C/0: PMIC RK809
  I2C/1: Touchscreen DSI/0 DSI/1
  I2C/4: Camera
  I2C/5: RTC@51 PCF8563
- I2S:
  I2S/0: miniHDMI Sound
  I2S/1: RK809 Audio Codec
  I2S/3: AP6275S Bluetooth Sound
- SDMMC:
  SDMMC/0: microSD (TF) slot
  SDMMC/2: AP6275S SDIO WiFi card
- Camera: 1x CSI
- Video: miniHDMI / DSI0 (MIPI/LVDS) / DSI1 (MIPI/EDP)
- Audio: miniHDMI / MIC on-board / Speaker / SPDIF / 3.5mm Headphones / AP6275S Bluetooth
- USB:
  USB 2.0 HOST x2
  USB 2.0 HOST x3 (4-pin)
  USB 2.0 OTG x1 (shared with USB 3.0 OTG/HOST) [slot may not install]
  USB 3.0 HOST x1
  USB 3.0 OTG/HOST x1
- SATA: 1x SATA 3.0 with Power/4-pin [slot may not install]
- PCIe: 1x PCIe 3.0 x2 (x4 connecter) [power/clock/slot may not install]

Link:
- https://appletsapi.52solution.com/media/X3568V4%E5%BC%80%E5%8F%91%E6%9D%BF%E7%A1%AC%E4%BB%B6%E6%89%8B%E5%86%8C.pdf
- https://blog.gov.cooking/archives/research-ninetripod-x3568-v4-and-flash.html

Signed-off-by: Coia Prant <coiaprant@gmail.com>
---
 .../dts/rk3568-9tripod-x3568-v4-u-boot.dtsi   |  3 +
 board/rockchip/evb_rk3568/MAINTAINERS         |  7 ++
 configs/9tripod-x3568-v4-rk3568_defconfig     | 80 +++++++++++++++++++
 doc/board/rockchip/rockchip.rst               |  1 +
 4 files changed, 91 insertions(+)
 create mode 100644 arch/arm/dts/rk3568-9tripod-x3568-v4-u-boot.dtsi
 create mode 100644 configs/9tripod-x3568-v4-rk3568_defconfig

diff --git a/arch/arm/dts/rk3568-9tripod-x3568-v4-u-boot.dtsi b/arch/arm/dts/rk3568-9tripod-x3568-v4-u-boot.dtsi
new file mode 100644
index 00000000000..e0cb8e3e7c8
--- /dev/null
+++ b/arch/arm/dts/rk3568-9tripod-x3568-v4-u-boot.dtsi
@@ -0,0 +1,3 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+#include "rk3568-u-boot.dtsi"
diff --git a/board/rockchip/evb_rk3568/MAINTAINERS b/board/rockchip/evb_rk3568/MAINTAINERS
index 030cdbe6f3d..0783fb203c3 100644
--- a/board/rockchip/evb_rk3568/MAINTAINERS
+++ b/board/rockchip/evb_rk3568/MAINTAINERS
@@ -1,3 +1,10 @@
+9TRIPOD-X3568-V4
+M:	Coia Prant <coiaprant@gmail.com>
+R:	Jonas Karlman <jonas@kwiboo.se>
+S:	Maintained
+F:	configs/9tripod-x3568-v4-rk3568_defconfig
+F:	arch/arm/dts/rk3568-9tripod-x3568-v4-u-boot.dtsi
+
 BANANAPI-BPI-R2-PRO
 M:	Frank Wunderlich <frank-w@public-files.de>
 S:	Maintained
diff --git a/configs/9tripod-x3568-v4-rk3568_defconfig b/configs/9tripod-x3568-v4-rk3568_defconfig
new file mode 100644
index 00000000000..71c0087d369
--- /dev/null
+++ b/configs/9tripod-x3568-v4-rk3568_defconfig
@@ -0,0 +1,80 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_SYS_HAS_NONCACHED_MEMORY=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3568-9tripod-x3568-v4"
+CONFIG_ROCKCHIP_RK3568=y
+CONFIG_SPL_SERIAL=y
+CONFIG_DEBUG_UART_BASE=0xFE660000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_SYS_LOAD_ADDR=0xc00800
+CONFIG_PCI=y
+CONFIG_DEBUG_UART=y
+CONFIG_AHCI=y
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_SPL_FIT_SIGNATURE=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-9tripod-x3568-v4.dtb"
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
+CONFIG_CMD_PMIC=y
+CONFIG_CMD_REGULATOR=y
+# CONFIG_SPL_DOS_PARTITION is not set
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_LIVE=y
+# CONFIG_OF_UPSTREAM is not set
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_SPL_REGMAP=y
+CONFIG_SPL_SYSCON=y
+CONFIG_DWC_AHCI=y
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
+CONFIG_PHY_MOTORCOMM=y
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
+CONFIG_ERRNO_STR=y
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index 141071f528a..9415e680c91 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -126,6 +126,7 @@ List of mainline supported Rockchip boards:
      - Xunlong Orange Pi 3B (orangepi-3b-rk3566)
 
 * rk3568
+     - 9Tripod X3568 v4 (9tripod-x3568-v4-rk3568)
      - Rockchip Evb-RK3568 (evb-rk3568)
      - Banana Pi BPI-R2 Pro (bpi-r2-pro-rk3568)
      - EmbedFire LubanCat 2 (lubancat-2-rk3568)
-- 
2.53.0

