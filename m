Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2F81EE4993
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 14:00:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F39FD864CC;
	Wed, 23 Aug 2023 15:59:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="npPktE8V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F20B8645F; Wed, 23 Aug 2023 15:59:31 +0200 (CEST)
Received: from mail.thorsis.com (mail.thorsis.com [92.198.35.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 345C18645A
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 15:59:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from adahl by ada.ifak-system.com with local (Exim 4.94.2)
 (envelope-from <ada@thorsis.com>)
 id 1qYoNs-001Zv3-9n; Wed, 23 Aug 2023 15:58:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=default;
 t=1692799167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8KdfaD5r969r3VHqQJv4AMvB4RxjNZ9sldnpUink2ys=;
 b=npPktE8VLRZ3eYtowEVQeFTOYM69ewB8VIBSOCPFROGtnvrAH17xhf0lUI0X5vVoJ3YMqr
 cDd8HdehetcGw26zMrL9DE8CpCT/WkC21jsk9uZDGoGXPfwE1kIYQJSojSWkH+CMPAJgxo
 1BH0acTYx3jtWgULQSl24rdSI/rOiHBEfxM9urqfpGSi2YhLK5cch2j+pEdGJekEvb1/vE
 nec0nLb+Q9h5HON+wR/t214XBs3bQwSVnIFtMw4bJACUsVjkYmEeGKIIcnZ8OVo0orGfZV
 XN+blu4GAnxNBPUuEA3TNO+2686dHQBFU7ypiLs2yWMgfwQ0r6HerELupPPkdQ==
From: Alexander Dahl <ada@thorsis.com>
To: Eugen Hristev <eugen.hristev@collabora.com>,
 Durai Manickam KR <durai.manickamkr@microchip.com>,
 Sandeep Sheriker M <sandeep.sheriker@microchip.com>
Cc: Sergiu Moga <sergiu.moga@microchip.com>,
	u-boot@lists.denx.de
Subject: [PATCH v2 1/5] configs: at91: sam9x60_curiosity: Sync both defconfig
 variants
Date: Wed, 23 Aug 2023 15:58:52 +0200
Message-Id: <20230823135856.376351-2-ada@thorsis.com>
In-Reply-To: <20230823135856.376351-1-ada@thorsis.com>
References: <20230823135856.376351-1-ada@thorsis.com>
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

The board has two SD card slots and we have two defconfigs for booting
from either the first (micro SD) named 'sam9x60_curiosity_mmc_defconfig'
or the second (full size SD) named 'sam9x60_curiosity_mmc1_defconfig'.
For comparable Microchip boards (sama5d27-som1-ek, sama5d29-curiosity,
sama7g5ek) with two card slots the defconfigs only differ in BOOTARGS,
BOOTCOMMAND, and ENV_FAT_DEVICE_AND_PART and the same should be the case
for sam9x60_curiosity.

Here the 'mmc1' config has more options enabled to support the raw NAND
flash populated on the board, so the 'mmc' config (for mmc0) was adapted
by enabling additional options, instead of removing options from mmc1.

The 'mem=128M' argument can be dropped from kernel command line, because
it is redundant to memory node in dts in both Linux and U-Boot:

        memory@20000000 {
                reg = <0x20000000 0x8000000>;
        };

Signed-off-by: Alexander Dahl <ada@thorsis.com>
---

Notes:
    v1 -> v2:
      - reworded commit message

 configs/sam9x60_curiosity_mmc_defconfig | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/configs/sam9x60_curiosity_mmc_defconfig b/configs/sam9x60_curiosity_mmc_defconfig
index 10937d67d7..269f015989 100644
--- a/configs/sam9x60_curiosity_mmc_defconfig
+++ b/configs/sam9x60_curiosity_mmc_defconfig
@@ -23,7 +23,7 @@ CONFIG_FIT=y
 CONFIG_SD_BOOT=y
 CONFIG_BOOTDELAY=3
 CONFIG_USE_BOOTARGS=y
-CONFIG_BOOTARGS="mem=128M console=ttyS0,115200 root=/dev/mmcblk0p2 rw rootfstype=ext4 rootwait"
+CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/mmcblk0p2 rw rootwait"
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="fatload mmc 0:1 0x21000000 at91-sam9x60_curiosity.dtb; fatload mmc 0:1 0x22000000 zImage; bootz 0x22000000 - 0x21000000"
 CONFIG_SYS_CONSOLE_IS_IN_ENV=y
@@ -38,6 +38,8 @@ CONFIG_CMD_DM=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
+CONFIG_CMD_NAND=y
+CONFIG_CMD_NAND_TRIMFFS=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_DHCP=y
 CONFIG_BOOTP_BOOTFILESIZE=y
@@ -50,6 +52,8 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_FAT=y
 CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_REGMAP=y
+CONFIG_SYSCON=y
 CONFIG_CLK=y
 CONFIG_CLK_CCF=y
 CONFIG_CLK_AT91=y
@@ -60,10 +64,17 @@ CONFIG_CPU=y
 CONFIG_AT91_GPIO=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_AT91=y
+CONFIG_ATMEL_EBI=y
+CONFIG_MFD_ATMEL_SMC=y
 CONFIG_I2C_EEPROM=y
 CONFIG_MICROCHIP_FLEXCOM=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ATMEL=y
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_MTD_RAW_NAND=y
+CONFIG_DM_NAND_ATMEL=y
+CONFIG_SYS_NAND_ONFI_DETECTION=y
 CONFIG_PHY_MICREL=y
 CONFIG_MACB=y
 CONFIG_PINCTRL=y
@@ -71,6 +82,8 @@ CONFIG_PINCTRL_AT91=y
 CONFIG_DM_SERIAL=y
 CONFIG_DEBUG_UART_ANNOUNCE=y
 CONFIG_ATMEL_USART=y
+CONFIG_SYSRESET=y
+CONFIG_SYSRESET_AT91=y
 CONFIG_TIMER=y
 CONFIG_MCHP_PIT64B_TIMER=y
 CONFIG_W1=y
-- 
2.30.2

