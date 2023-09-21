Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 845ADE7D0A1
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 17:18:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FD4286B26;
	Thu, 21 Sep 2023 19:18:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="YqfGBkOd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE77986B29; Thu, 21 Sep 2023 19:07:02 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 954CE863CF
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 19:07:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Durai.ManickamKR@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1695316021; x=1726852021;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=JCinDAsD2rFK2F/B3r1iaf+B1/Ofy4zmzCMCEpii3Nw=;
 b=YqfGBkOd3VhwGBuPZwwwjZiDP6dDqz+QDgCtcd0Ufo3BlkQukHxdZ1Bd
 3mA4oUeNQlUL0JyaUiRIaHz1mlWxvitzOguYzl71xzocLqMd/RIz6Zpka
 zV2Tl1FH5Uiwz46jvlZ+MZikbuo0b1qHZP0TnKEwl4VHKv4CZx448ED25
 orZHAp/TnAXJGbMsG3kbXCz8YBokdUdKkR8npYdzg9y88NWCVpVEGRUwO
 SkbgCqnwMTWNBEkq8BNcydmC30kjROiwAsvPXy9FZYr5Q+oUB+mRKgwqO
 Iz7H06fvHgcShPCKDOTkfxw21MZTvgxLU8Xg4/Rurrxu/qsTHKLvOmodz w==;
X-CSE-ConnectionGUID: cU1AIYy8TkeLIR+AFzD2vA==
X-CSE-MsgGUID: bJGX7IJdSteskqeA3l8JVA==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,166,1694761200"; d="scan'208";a="236462448"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 21 Sep 2023 10:06:59 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 21 Sep 2023 10:06:55 -0700
Received: from che-lt-i66125lx.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Thu, 21 Sep 2023 10:06:52 -0700
From: Durai Manickam KR <durai.manickamkr@microchip.com>
To: <u-boot@lists.denx.de>
CC: <durai.manickamkr@microchip.com>, <hari.prasathge@microchip.com>,
 <varshini.rajendran@microchip.com>, <cristian.birsan@microchip.com>,
 <nicolas.ferre@microchip.com>, <balamanikandan.gunasundar@microchip.com>
Subject: [PATCH 2/4] configs: at91: sam9x60_curiosity: Add
 sam9x60_curiosity_nandflash_defconfig
Date: Thu, 21 Sep 2023 22:36:29 +0530
Message-ID: <20230921170631.45752-3-durai.manickamkr@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230921170631.45752-1-durai.manickamkr@microchip.com>
References: <20230921170631.45752-1-durai.manickamkr@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Thu, 21 Sep 2023 19:18:38 +0200
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

Add boot from NAND flash support for sam9x60_curiosity.

Signed-off-by: Durai Manickam KR <durai.manickamkr@microchip.com>
---
 board/atmel/sam9x60_curiosity/MAINTAINERS     |  1 +
 configs/sam9x60_curiosity_nandflash_defconfig | 92 +++++++++++++++++++
 2 files changed, 93 insertions(+)
 create mode 100644 configs/sam9x60_curiosity_nandflash_defconfig

diff --git a/board/atmel/sam9x60_curiosity/MAINTAINERS b/board/atmel/sam9x60_curiosity/MAINTAINERS
index 0d9369e027..992d3f4024 100644
--- a/board/atmel/sam9x60_curiosity/MAINTAINERS
+++ b/board/atmel/sam9x60_curiosity/MAINTAINERS
@@ -6,3 +6,4 @@ F:	board/atmel/sam9x60_curiosity/
 F:	include/configs/sam9x60_curiosity.h
 F:	configs/sam9x60_curiosity_mmc_defconfig
 F:	configs/sam9x60_curiosity_mmc1_defconfig
+F:	configs/sam9x60_curiosity_nandflash_defconfig
diff --git a/configs/sam9x60_curiosity_nandflash_defconfig b/configs/sam9x60_curiosity_nandflash_defconfig
new file mode 100644
index 0000000000..4146bf0ac9
--- /dev/null
+++ b/configs/sam9x60_curiosity_nandflash_defconfig
@@ -0,0 +1,92 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_ARCH_AT91=y
+CONFIG_TEXT_BASE=0x23f00000
+CONFIG_SYS_MALLOC_LEN=0x81000
+CONFIG_SYS_MALLOC_F_LEN=0x8000
+CONFIG_TARGET_SAM9X60_CURIOSITY=y
+CONFIG_ATMEL_LEGACY=y
+CONFIG_NR_DRAM_BANKS=8
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="at91-sam9x60_curiosity"
+CONFIG_SYS_PROMPT="U-Boot> "
+CONFIG_DEBUG_UART_BASE=0xfffff200
+CONFIG_DEBUG_UART_CLOCK=200000000
+CONFIG_DEBUG_UART_BOARD_INIT=y
+CONFIG_ENV_OFFSET_REDUND=0x100000
+CONFIG_SYS_LOAD_ADDR=0x22000000
+CONFIG_DEBUG_UART=y
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x2000bf00
+CONFIG_FIT=y
+CONFIG_NAND_BOOT=y
+CONFIG_BOOTDELAY=3
+CONFIG_USE_BOOTARGS=y
+CONFIG_BOOTARGS="console=ttyS0,115200 earlyprintk mtdparts=atmel_nand:256k(bootstrap)ro,768k(uboot)ro,256k(env_redundant),256k(env),512k(dtb),6M(kernel)ro,-(rootfs) rootfstype=ubifs ubi.mtd=12 root=ubi0:rootfs rw"
+CONFIG_USE_BOOTCOMMAND=y
+CONFIG_BOOTCOMMAND="nand read 0x22000000 0x200000 0x600000; nand read 0x21000000 0x180000 0x20000; bootz 0x22000000 - 0x21000000"
+CONFIG_SYS_CONSOLE_IS_IN_ENV=y
+# CONFIG_DISPLAY_BOARDINFO is not set
+CONFIG_MISC_INIT_R=y
+CONFIG_HUSH_PARSER=y
+CONFIG_SYS_CBSIZE=256
+CONFIG_SYS_PBSIZE=281
+CONFIG_CMD_BOOTZ=y
+CONFIG_CMD_CLK=y
+CONFIG_CMD_DM=y
+# CONFIG_CMD_FLASH is not set
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_NAND=y
+CONFIG_CMD_NAND_TRIMFFS=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_DHCP=y
+CONFIG_BOOTP_BOOTFILESIZE=y
+CONFIG_CMD_MII=y
+CONFIG_CMD_PING=y
+CONFIG_CMD_HASH=y
+CONFIG_HASH_VERIFY=y
+CONFIG_CMD_FAT=y
+CONFIG_CMD_UBI=y
+CONFIG_OF_CONTROL=y
+CONFIG_ENV_IS_IN_NAND=y
+CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_REGMAP=y
+CONFIG_SYSCON=y
+CONFIG_CLK=y
+CONFIG_CLK_CCF=y
+CONFIG_CLK_AT91=y
+CONFIG_AT91_GENERIC_CLK=y
+CONFIG_AT91_SAM9X60_PLL=y
+CONFIG_CPU=y
+CONFIG_AT91_GPIO=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_AT91=y
+CONFIG_ATMEL_EBI=y
+CONFIG_MFD_ATMEL_SMC=y
+CONFIG_I2C_EEPROM=y
+CONFIG_MICROCHIP_FLEXCOM=y
+CONFIG_GENERIC_ATMEL_MCI=y
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+# CONFIG_SYS_NAND_USE_FLASH_BBT is not set
+CONFIG_DM_NAND_ATMEL=y
+CONFIG_SYS_NAND_ONFI_DETECTION=y
+CONFIG_PHY_MICREL=y
+CONFIG_MACB=y
+CONFIG_PINCTRL=y
+CONFIG_PINCTRL_AT91=y
+CONFIG_DM_SERIAL=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_ATMEL_USART=y
+CONFIG_SYSRESET=y
+CONFIG_SYSRESET_AT91=y
+CONFIG_TIMER=y
+CONFIG_MCHP_PIT64B_TIMER=y
+CONFIG_W1=y
+CONFIG_W1_GPIO=y
+CONFIG_W1_EEPROM=y
+CONFIG_W1_EEPROM_DS24XXX=y
+CONFIG_OF_LIBFDT_OVERLAY=y
-- 
2.25.1

