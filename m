Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB62C3600C
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 07:08:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58FB881DEC;
	Thu, 27 Mar 2025 08:08:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="qKbLBhhP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BDFF81DEC; Thu, 27 Mar 2025 08:08:02 +0100 (CET)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACCED81E13
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 08:07:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=174f6da1a=Manikandan.M@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1743059279; x=1774595279;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gItp/JYH6NFA5bJ4OAgeKFwZ47VFJEP5banvA+Ekhkk=;
 b=qKbLBhhPfyMzH+WfS0Jdmlo3UcNXWr0cmuvS3/r6DPT29/FP52dLpWVp
 neZy2hH0aBfCC87Vu16L4yV3l0UQscNdyKw1mml0gBLt+p7n5l6HkAaRS
 dIkTs3wUdYHCaoiypEmWAzxrWPDaixWyRtVYk62wH9u/4bMXW5uVbTvWZ
 5dKg19hQoGBRzH4XJ5PSeKp+ipAAf2RVC7fMI8x5B+L9wx7IZco0lA3XA
 FeCBfaarzx5a/Nda59krU790ProyHaqVYgZKBHHeAg29oIQRbUxUNmdNw
 Uq/KMYLaFCq/1hLMznuDcnCQvp40uXaRZ0VrcQAoqrckepRVxMVcQ4OlX Q==;
X-CSE-ConnectionGUID: 9ZibUNzKTtqByUg53LDiRQ==
X-CSE-MsgGUID: 4Jso0evARim1A5Fgf5qz3Q==
X-IronPort-AV: E=Sophos;i="6.14,279,1736838000"; d="scan'208";a="39784745"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 27 Mar 2025 00:07:57 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 27 Mar 2025 00:07:27 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Thu, 27 Mar 2025 00:07:21 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: Eugen Hristev <eugen.hristev@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 <seanga2@gmail.com>, <sjg@chromium.org>, <mkorpershoek@baylibre.com>,
 <nathan.morrison@timesys.com>, <ilias.apalodimas@linaro.org>,
 <greg.malysa@timesys.com>, <caleb.connolly@linaro.org>,
 <Oliver.Gaskell@analog.com>, <robert.marko@sartura.hr>,
 <igor.opaniuk@gmail.com>, <semen.protsenko@linaro.org>,
 <william.zhang@broadcom.com>, <nicolas.ferre@microchip.com>,
 <u-boot@lists.denx.de>
CC: <manikandan.m@microchip.com>
Subject: [PATCH v5 8/8] configs: sam9x75_curiosity: Add initial mmc default
 config
Date: Thu, 27 Mar 2025 12:36:15 +0530
Message-ID: <20250327070615.334551-9-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250327070615.334551-1-manikandan.m@microchip.com>
References: <20250327070615.334551-1-manikandan.m@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

Add default configuration for sd-card to boot the linux kernel.

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
 board/atmel/sam9x75_curiosity/MAINTAINERS |  1 +
 configs/sam9x75_curiosity_mmc_defconfig   | 73 +++++++++++++++++++++++
 2 files changed, 74 insertions(+)
 create mode 100644 configs/sam9x75_curiosity_mmc_defconfig

diff --git a/board/atmel/sam9x75_curiosity/MAINTAINERS b/board/atmel/sam9x75_curiosity/MAINTAINERS
index a175053418f..f0dfdbe8d5c 100644
--- a/board/atmel/sam9x75_curiosity/MAINTAINERS
+++ b/board/atmel/sam9x75_curiosity/MAINTAINERS
@@ -4,3 +4,4 @@ S:	Maintained
 F:	board/atmel/sam9x75_curiosity/
 F:	include/configs/sam9x75_curiosity.h
 F:	arch/arm/dts/at91-sam9x75_curiosity-u-boot.dtsi
+F:	configs/sam9x75_curiosity_mmc_defconfig
diff --git a/configs/sam9x75_curiosity_mmc_defconfig b/configs/sam9x75_curiosity_mmc_defconfig
new file mode 100644
index 00000000000..76b85448285
--- /dev/null
+++ b/configs/sam9x75_curiosity_mmc_defconfig
@@ -0,0 +1,73 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_ARCH_AT91=y
+CONFIG_TEXT_BASE=0x23f00000
+CONFIG_SYS_MALLOC_LEN=0x81000
+CONFIG_SYS_MALLOC_F_LEN=0x12000
+CONFIG_TARGET_SAM9X75_CURIOSITY=y
+CONFIG_ATMEL_LEGACY=y
+CONFIG_NR_DRAM_BANKS=8
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20015f00
+CONFIG_ENV_SIZE=0x4000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="microchip/at91-sam9x75_curiosity"
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_SYS_LOAD_ADDR=0x22000000
+CONFIG_DEBUG_UART_BASE=0xfffff200
+CONFIG_DEBUG_UART_CLOCK=266666666
+CONFIG_DEBUG_UART_BOARD_INIT=y
+CONFIG_DEBUG_UART=y
+CONFIG_FIT=y
+CONFIG_SD_BOOT=y
+CONFIG_BOOTDELAY=3
+CONFIG_USE_BOOTARGS=y
+CONFIG_BOOTARGS="mem=256M console=ttyS0,115200 root=/dev/mmcblk0p2 rw rootfstype=ext4 rootwait"
+CONFIG_USE_BOOTCOMMAND=y
+CONFIG_BOOTCOMMAND="fatload mmc 0:1 0x21000000 at91-sam9x75_curiosity.dtb; fatload mmc 0:1 0x22000000 zImage; bootz 0x22000000 - 0x21000000"
+CONFIG_SYS_CBSIZE=256
+CONFIG_SYS_PBSIZE=281
+CONFIG_SYS_CONSOLE_IS_IN_ENV=y
+# CONFIG_DISPLAY_BOARDINFO is not set
+CONFIG_HUSH_PARSER=y
+CONFIG_SYS_PROMPT="U-Boot> "
+CONFIG_CMD_BOOTZ=y
+CONFIG_CMD_CLK=y
+CONFIG_CMD_DM=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_BOOTP_BOOTFILESIZE=y
+CONFIG_CMD_DHCP=y
+CONFIG_CMD_MII=y
+CONFIG_CMD_PING=y
+CONFIG_CMD_HASH=y
+CONFIG_HASH_VERIFY=y
+CONFIG_CMD_FAT=y
+CONFIG_OF_CONTROL=y
+CONFIG_ENV_IS_IN_FAT=y
+CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_CLK=y
+CONFIG_CLK_CCF=y
+CONFIG_CLK_AT91=y
+CONFIG_AT91_GENERIC_CLK=y
+CONFIG_AT91_SAM9X60_PLL=y
+CONFIG_CPU=y
+CONFIG_AT91_GPIO=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_AT91=y
+CONFIG_I2C_EEPROM=y
+CONFIG_MICROCHIP_FLEXCOM=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_ATMEL=y
+CONFIG_MTD=y
+CONFIG_PINCTRL=y
+CONFIG_PINCTRL_AT91=y
+CONFIG_DM_SERIAL=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_ATMEL_USART=y
+CONFIG_TIMER=y
+CONFIG_MCHP_PIT64B_TIMER=y
+CONFIG_PHANDLE_CHECK_SEQ=y
-- 
2.25.1

