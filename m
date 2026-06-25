Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A76ECDE001
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 15:50:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 090DC847C8;
	Thu, 25 Jun 2026 17:50:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eX4txRj7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9881084894; Thu, 25 Jun 2026 17:50:55 +0200 (CEST)
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E091B84704
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 17:50:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=coiaprant@gmail.com
Received: by mail-pl1-x643.google.com with SMTP id
 d9443c01a7336-2c7f5869cddso600335ad.1
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 08:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782402651; x=1783007451; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HwPpogUCSpQD6KjmLJSiziJCMg6XMPE78U/zIY3r+Zo=;
 b=eX4txRj7xI4msjcX8lctYGQ9XanSMZCgEb6shWwKBSaaCFWp1eK870g7V+V1Z1zWLk
 nbAl6YSy8jtDr3/Cqyr593GK6J3POv5REZCJ0f/2tEsLLAHMy5cSq7vPCZTA0kRGNnf7
 6pXK2Yjgnd5JJCV9ZnT/PIUeUsjY/vuZ3y5thG76QelnsTfSEr1gh34NpMA9nGp+Rpgl
 yXKCWwRqvTR89x7rauRUawi0ojeR4mU0o5BheVl3bg1orO09zmSjcy5h2sMcIZpdwysp
 ig0HwIwbP/bsnB9gabVlOsraO0ZqLAJqDK816OkHcGwYwNro3xuKol05uB8/D0GjTHJb
 uCGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782402651; x=1783007451;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HwPpogUCSpQD6KjmLJSiziJCMg6XMPE78U/zIY3r+Zo=;
 b=JRAbBHOMzeXBCQ89etPH+HO5ycJbhNd89480+/sKZbmsIbh0Laq1YarY2+3+WsD2Aa
 me+2HZo1qKgPXRFFfU+HDtZ/943YKbetgUHzygONzb5gJ6IXaTvkdKEL/zWYpIbz5Cmf
 KWUVTa0Er3dCavd9zzd+KsISWjeLVHJHECK2FN8cBzyYwNt+Mk41KwA8AHuRAUSM72A0
 NWUtzZiC2xyJFl8leTj/skrCNktbIaiBBxZFBFx9tmh/Dtub1tSowoFt29uCx88d9M9H
 q3ToHN8g0VkuKZD+WMaj6pMS+cdH51s7VSx2iQ4saxa3vtDx+Sdd6ez3HY5JmuRacPle
 xkWA==
X-Gm-Message-State: AOJu0Yy2ZB77YApD1+Fj4Nah4PS0tzUF/KMf6fSVZrv6Q5m+4NsCCAyj
 qr3NU9sQzkopheCNwnzKCMAJtQEkQ6DTN42KQEJC35rwAdPu9OfGU73H
X-Gm-Gg: AfdE7clYJto59xtnfGIIfWNOHeYIS+KVN/ETgQ2VzVmOqvatsuQekSWStAPzU7oTDsW
 Zr3zYGo3jwdld+fRQOXFhObgzSpjc7vBf9jJBiijpG5dHgq9nIatP9MEehcqvaFNrfiIYLn/N+F
 RyxrH8HRv0ZMppbH9f0Sv4J/tibj95dzuVadLLGmjD/07rfjdoI/2V2EPZqVq0rDwdYpl6z9M/Z
 9XExsuS1YayAA57AeAAnTxWeOs4g6oIhgnZUf7IIE0lmgYBXI5QJ80TLYEeUNk2N8gOZ/QfxhzR
 RsgvlLh5Y92C7sTo/h8ij+lqFBwNO2kLQOOqwPEPCD8TKbmGPO0xptcLxyggTqLZnXdYSmg1Wpt
 X8xYuw+tqgcWiIlnNKtNGVaaMmuFooCvR5MZ2ft3P66ToBI7uzC73mYEJhDhtjQ5md/fN7LDRyM
 iw+ggr3D4ktr4rLv+vyV68vA==
X-Received: by 2002:a17:902:da88:b0:2c6:e46f:7e62 with SMTP id
 d9443c01a7336-2c7fca4b753mr33604415ad.33.1782402651008; 
 Thu, 25 Jun 2026 08:50:51 -0700 (PDT)
Received: from server.lan ([150.230.217.250]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c7f5b04be8sm22903815ad.35.2026.06.25.08.50.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 08:50:50 -0700 (PDT)
From: Coia Prant <coiaprant@gmail.com>
To: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de,
	Coia Prant <coiaprant@gmail.com>
Subject: [PATCH v2] board: rockchip: Add for 9Tripod X3568 v4
Date: Thu, 25 Jun 2026 23:50:22 +0800
Message-ID: <20260625155021.2269190-2-coiaprant@gmail.com>
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
 board/rockchip/evb_rk3568/MAINTAINERS     |  5 ++
 configs/9tripod-x3568-v4-rk3568_defconfig | 79 +++++++++++++++++++++++
 doc/board/rockchip/rockchip.rst           |  1 +
 3 files changed, 85 insertions(+)
 create mode 100644 configs/9tripod-x3568-v4-rk3568_defconfig

diff --git a/board/rockchip/evb_rk3568/MAINTAINERS b/board/rockchip/evb_rk3568/MAINTAINERS
index 7e17a6a987a..9ae22ce6845 100644
--- a/board/rockchip/evb_rk3568/MAINTAINERS
+++ b/board/rockchip/evb_rk3568/MAINTAINERS
@@ -1,3 +1,8 @@
+9TRIPOD-X3568-V4
+M:	Coia Prant <coiaprant@gmail.com>
+S:	Maintained
+F:	configs/9tripod-x3568-v4-rk3568_defconfig
+
 BANANAPI-BPI-R2-PRO
 M:	Frank Wunderlich <frank-w@public-files.de>
 S:	Maintained
diff --git a/configs/9tripod-x3568-v4-rk3568_defconfig b/configs/9tripod-x3568-v4-rk3568_defconfig
new file mode 100644
index 00000000000..044dfe9452c
--- /dev/null
+++ b/configs/9tripod-x3568-v4-rk3568_defconfig
@@ -0,0 +1,79 @@
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
+CONFIG_OF_SPL_REMOVE_PROPS="interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
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
index a31ee7100b9..0c996cf880b 100644
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

