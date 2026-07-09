Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAD1BC43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 18:51:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 357C084C02;
	Thu,  9 Jul 2026 20:51:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MUuq874X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4357584C03; Thu,  9 Jul 2026 20:51:17 +0200 (CEST)
Received: from mail-pj2-x02.google.com (mail-pj2-x02.google.com
 [IPv6:2607:f8b0:4864:39::2])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB4DA84C01
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 20:51:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=coiaprant@gmail.com
Received: by mail-pj2-x02.google.com with SMTP id
 d9443c01a7336-2cb3f5bb19aso198635ad.1
 for <u-boot@lists.denx.de>; Thu, 09 Jul 2026 11:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783623073; x=1784227873; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=YzA+IyafgyGiM90GrPxF2gyVUYDIQV/tos8Uy1c7e7s=;
 b=MUuq874XumLtiTniMs9U4mFsdsOYnfn8m1USJh1ZfYyRKHvBpaUVrSC1Ph7j8/GYYD
 +UUFbKCfOXyhqfrPi5F8Wk7QsC9zccfZuB6Jr9/hut2jk2LIjJYl3xNHiHL39kAKXOwM
 wWu/8uSNhGM7kbiGbcu6tGx55lAUjfiU8zxKMs4/jX+LyfmnimwdU411+DULfDfBW5m6
 JUafZ1blWvttL+qlWykBiFd+Mg29vpM980T9LOQGq9L0n9Dz9Yvk1dz9mlHp0rGVsh/I
 0dAdqN7RBoeODyDpv+uMl94s5mFjr5Fsa8XEuofbMQXKDiL9IoLuY4/DltxSWFC2f9Q9
 /URQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783623073; x=1784227873;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YzA+IyafgyGiM90GrPxF2gyVUYDIQV/tos8Uy1c7e7s=;
 b=tAOreQIk4YIu0SNyxBlXEcm0lv0lu8uym20BejdFQ+wPEK39Ei0Axv0mnEXvIFyUZb
 KDPLl4o+v0oaEES5/sNZn+Sh8RdGREpYodjcLZf2tuzoJneOfOH7oJnE4sV2wBo3ffnY
 F5qAWiNzcJtLmFdu6I7forBqXjMqkenAjBl+DWEFRCpNjpenanm7IyoNEH0M9D5zC77x
 rphEa54bDWrfGukLhMkvZ6YBZoRa4v/kgTdhXSD3fyfhjRV7JLQYLGgxaH2hasVzW1nT
 fwy2bY5dCrg966eJZwwv/pzS40ub2sK0eUOIhti91KvSrmtoyBqrRZ21SGim99DoKHSN
 c02g==
X-Gm-Message-State: AOJu0YxPpqgw0nQDvCloUIn22ntuGY6BVlmXUPlR6mWvCTV2p73169R/
 jT9R/0TxIlhk/n2Rv1XyO3LRQuWLkV5Ip9pZCMSpWRc63qsi6OoTmHjw7ffuJbj22A4T2g==
X-Gm-Gg: AfdE7cnCjiaRTS9gWC69cnb251Q2hav/W6/UKDC3m20RYkSexSxaqSB3xNosexnSzfD
 WpZ6uk4n5f04E//2a50S6RlieGc61nkD+FLAuxVKJ0X8ZEC/ndB8taWixfGwzw+kGPA0HfiEd8p
 V8GVx+okx+/spm71oxv5Mzz33A/junYbBxYUkIrOn/SjrFZcEqgrwgChTUmemEecm2sBnRlgJrR
 6IT3ioapiMwElwPvf5ZUjFduiwEKCpcDyeZzVqb8vrV+BmA2KVj2AXQZM1uQYPTjmenT7a377Lg
 Ynt3cJiEZ0TqdMIiUHRLAJ67RFXPmIncUYG1n45tQOO1SQCqJGbQVmDOnt6E7QjvyPzM0RddqwP
 zOUzxf8g4VajWUFl1L7XcYRswrYulHTefRghOlL17EqQXd1xsuU4KJ3VDYsnFFdtr5HtiJlOSE/
 G3duS7e+gCBgPYsIPLGg==
X-Received: by 2002:a17:903:1247:b0:2ca:eea:eb5c with SMTP id
 d9443c01a7336-2ccea373170mr86541815ad.18.1783623072868; 
 Thu, 09 Jul 2026 11:51:12 -0700 (PDT)
Received: from server.lan ([103.213.4.16]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d1e28fsm49922135ad.43.2026.07.09.11.51.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 11:51:12 -0700 (PDT)
From: Coia Prant <coiaprant@gmail.com>
To: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de,
	Coia Prant <coiaprant@gmail.com>
Subject: [PATCH v3] board: rockchip: Add support for 9Tripod X3568 v4
Date: Fri, 10 Jul 2026 02:51:01 +0800
Message-ID: <20260709185101.2149485-1-coiaprant@gmail.com>
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
- CPU (RK3568B2/RK3568J)
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
- PCIe: 1x PCIe 3.0 x2 (x4 connector) [power/clock/slot may not install]

Link:
- https://appletsapi.52solution.com/media/X3568V4%E5%BC%80%E5%8F%91%E6%9D%BF%E7%A1%AC%E4%BB%B6%E6%89%8B%E5%86%8C.pdf
- https://blog.gov.cooking/archives/research-ninetripod-x3568-v4-and-flash.html

Signed-off-by: Coia Prant <coiaprant@gmail.com>
---
 board/rockchip/evb_rk3568/MAINTAINERS     |  5 ++
 configs/9tripod-x3568-v4-rk3568_defconfig | 76 +++++++++++++++++++++++
 doc/board/rockchip/rockchip.rst           |  1 +
 3 files changed, 82 insertions(+)
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
index 00000000000..c0e7a565359
--- /dev/null
+++ b/configs/9tripod-x3568-v4-rk3568_defconfig
@@ -0,0 +1,76 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3568-9tripod-x3568-v4"
+CONFIG_ROCKCHIP_RK3568=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SYS_LOAD_ADDR=0xc00800
+CONFIG_DEBUG_UART_BASE=0xFE660000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_PCI=y
+CONFIG_DEBUG_UART=y
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_SPL_FIT_SIGNATURE=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-9tripod-x3568-v4.dtb"
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
+CONFIG_CMD_PMIC=y
+CONFIG_CMD_REGULATOR=y
+# CONFIG_SPL_DOS_PARTITION is not set
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_LIVE=y
+CONFIG_OF_SPL_REMOVE_PROPS="interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_SPL_SYSCON=y
+CONFIG_AHCI=y
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
+CONFIG_DWC_ETH_QOS=y
+CONFIG_DWC_ETH_QOS_ROCKCHIP=y
+CONFIG_PHY_MOTORCOMM=y
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
2.47.3

