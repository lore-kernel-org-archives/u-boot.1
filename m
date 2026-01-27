Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57163D340BC
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 16:51:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D7928418A;
	Tue, 27 Jan 2026 17:51:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pGpW7Fj0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B632084101; Tue, 27 Jan 2026 17:51:15 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49D4484172
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 17:51:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-432d2670932so5414570f8f.2
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 08:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769532673; x=1770137473;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6S6R7iigBiZIXonh9aLGJ/y4GTx2g2+Xk25P2Aniyp0=;
 b=pGpW7Fj0hoaN/+FVWv0D7nE6mb7c65edizUV8gM1zML39N5sJu9AY37nfCePwNsbrz
 VTIa+wgWUfbYzMeU09ScHYZi3MLcopZihNfkm2dEmoEROjYUrehZzk49flndBihhaNpI
 +dkCcW3+jAKFBRS5e5KtDwnMRBe8VBhpbr11W2Je6KZ9WnPhLbK34QPnOKbwCFpbr8Da
 ZIkedp1QKV4fXVnJ3VPK2OzSv2LAXAvHoufrLt49VvORHMh9+plP97nwKApKfOzGfaws
 U8HMsyM6SLCD7z0EsKEs1DC9XWBvuNoWKKgCgVOddFvwqDiqRSgDrQ+og9btpEXQ2aTd
 bp/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769532673; x=1770137473;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6S6R7iigBiZIXonh9aLGJ/y4GTx2g2+Xk25P2Aniyp0=;
 b=aSclvY0xg1l+oNE3RzVWVW4R86aLFA9wPgrk6Hk5km9NPCScqRX0ylOHrpfXdJv6SE
 kAs41xCgL5GwTibE0NEUE9ZjLr4U1FnWGoQU1Hx+uZRpdYHWETSqVTOF0NUb18K5pT20
 sImPwDbNHmhjPCNsJOe0/kM4rNnwRdiTNCNq6F3RAlIiKoMf25n4zRz1yQUEPOcfpWdt
 MkodZ8LJamOvyZZiCJwRAds/ocPkT73ymD1axlM9pjY5AOYEHdXrJkWkpCLzQpTRya70
 WdGrVpmfEOusSq5FzMU69fFe+PaQ9X6UBkE1QQs4F0CJ3TdVluRpU9MW5t0NoI5VIzaq
 mpAg==
X-Gm-Message-State: AOJu0YzIEQwo2YHx9S2i9DXAZy5npSVry/c08s17bVUzWJWkJX608e9c
 w4ZbiaV8CzXI/+LKDQVfXsRRoAJWup6GESStSseRZnLJ06cVf72yxKSEpdjwBziljpc=
X-Gm-Gg: AZuq6aJf048ZmZktqspw+pM8BHrGOVurS7J3uemz657bDQhDCqqrFjADluF72jB2iIJ
 Stto5W1DpSrQzsFTSizE7Vk7pDmYmoeaGDUWEVB4TxUXHPuiRPeRfF5h13foMwXxvuz0RRQA+oV
 fRgZa+QFNaIVOKAwJBEEQDH4085QHmsPi5RTS7V/JFepyT5xM5sq0SqZMQDVmVosHGbUW+/2Zp/
 dhAaf5XEXCKSMm/ZFyNTktoZdF1mo+wp3dHHzSLR0OdL+nclt20mweR9wz8mxt3uFlZeSMvGS4X
 7ok2exsRQpoyG4LGe+4+sEqlDvQazEgeqRErtpcFG7HRzE4XwLnlxZXNZjSWzvIUz5C+mtHJLIy
 5QeRFJBXDbU+0QxEnNBpvVx9b5j8V9VDC5KOKomH26avISs52R/YlE7vYltI6n/JTadKQgTnVEc
 n76OlRM7SAgN17TqeKiDY=
X-Received: by 2002:a05:6000:1843:b0:435:9144:1417 with SMTP id
 ffacd0b85a97d-435dd1bcd71mr3453702f8f.49.1769532672482; 
 Tue, 27 Jan 2026 08:51:12 -0800 (PST)
Received: from localhost ([2001:4090:a244:872b:a354:65f3:92a0:8de7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10e474csm66238f8f.2.2026.01.27.08.51.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 08:51:12 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Tue, 27 Jan 2026 17:48:19 +0100
Subject: [PATCH v4 05/10] configs: am335x_evm: Unify evm board defconfigs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260127-topic-am33-evm-oftree-v2026-01-v4-5-0dadb0710ce7@baylibre.com>
References: <20260127-topic-am33-evm-oftree-v2026-01-v4-0-0dadb0710ce7@baylibre.com>
In-Reply-To: <20260127-topic-am33-evm-oftree-v2026-01-v4-0-0dadb0710ce7@baylibre.com>
To: u-boot@lists.denx.de, Marc Murphy <marc.murphy@sancloud.com>
Cc: Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Parvathi Pudi <parvathi@couthit.com>, 
 Basharath Hussain Khaja <basharath@couthit.com>, 
 Paul Barker <paul.barker@sancloud.com>, "Andrew F. Davis" <afd@ti.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=18857; i=msp@baylibre.com;
 h=from:subject:message-id; bh=ApelAKu2437DFzLfD6hyzoYW2VuEqjbdCCEmqE0kjnc=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhsyKN6eZCv3OCbAzpt5cfEXv7Zlv1oKRE7QPdmQ7qMRN3
 b5KdJdjRykLgxgXg6yYIktnYmjaf/mdx5IXLdsMM4eVCWQIAxenAEwkKJjhr+QWj6PrecTzzaz2
 nnU2u33Nb2XnmUrXtbt+On956nxk+m2GvwKS5r/u7mGrko9Zmp/U+yrn7oyf/27mLNh/akfLPAE
 XIy4A
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
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

Much of the config symbols between the evm boards are the same
independent of the actual board. This patch creates a hierarchy for the
am335x_evm configs:

  am335x_evm.config
  `-> am335x_evm_defconfig
  `-> am335x_evm_spiboot_defconfig
  `-> am335x_hs_evm.config
      `-> am335x_hs_evm_defconfig
      `-> am335x_hs_evm_uart_defconfig

Reviewed-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 configs/am335x_evm.config            | 82 +++++++++++++++++++++++++++++++
 configs/am335x_evm_defconfig         | 84 +------------------------------
 configs/am335x_evm_spiboot_defconfig | 83 +------------------------------
 configs/am335x_hs_evm.config         | 14 ++++++
 configs/am335x_hs_evm_defconfig      | 95 +-----------------------------------
 configs/am335x_hs_evm_uart_defconfig | 94 +----------------------------------
 6 files changed, 104 insertions(+), 348 deletions(-)

diff --git a/configs/am335x_evm.config b/configs/am335x_evm.config
new file mode 100644
index 0000000000000000000000000000000000000000..9c12771a3299bcd0b1c5c14bb4c2306d7b02aae5
--- /dev/null
+++ b/configs/am335x_evm.config
@@ -0,0 +1,82 @@
+CONFIG_ARM=y
+CONFIG_ARCH_CPU_INIT=y
+CONFIG_ARCH_OMAP2PLUS=y
+CONFIG_TI_COMMON_CMD_OPTIONS=y
+CONFIG_SF_DEFAULT_SPEED=24000000
+CONFIG_DEFAULT_DEVICE_TREE="am335x-evm"
+CONFIG_AM33XX=y
+CONFIG_CLOCK_SYNTHESIZER=y
+CONFIG_SYS_BOOTM_LEN=0x1000000
+CONFIG_SPL=y
+CONFIG_TIMESTAMP=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_DISTRO_DEFAULTS=y
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_BOOTCOMMAND="run findfdt; run init_console; run finduuid; run distro_bootcmd"
+CONFIG_LOGLEVEL=3
+CONFIG_SYS_CONSOLE_INFO_QUIET=y
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
+CONFIG_SPL_FIT_IMAGE_TINY=y
+CONFIG_SPL_OPTIMIZE_INLINING=y
+# CONFIG_SPL_FS_EXT4 is not set
+CONFIG_SPL_MTD=y
+CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
+CONFIG_CMD_NAND=y
+CONFIG_BOOTP_DNS2=y
+CONFIG_CMD_MTDPARTS=y
+# CONFIG_SPL_EFI_PARTITION is not set
+CONFIG_OF_CONTROL=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+CONFIG_VERSION_VARIABLE=y
+CONFIG_NET_RETRY_COUNT=10
+CONFIG_BOOTP_SEND_HOSTNAME=y
+CONFIG_BOOTCOUNT_LIMIT=y
+CONFIG_SYS_BOOTCOUNT_BE=y
+CONFIG_CLK_CDCE9XX=y
+CONFIG_DFU_MMC=y
+CONFIG_DFU_NAND=y
+CONFIG_DFU_RAM=y
+CONFIG_USB_FUNCTION_FASTBOOT=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_EEPROM_ADDR=0x50
+# CONFIG_MMC_HW_PARTITIONING is not set
+CONFIG_MMC_OMAP_HS=y
+CONFIG_MTD=y
+CONFIG_MTD_RAW_NAND=y
+CONFIG_SYS_NAND_ONFI_DETECTION=y
+CONFIG_SYS_NAND_PAGE_SIZE=0x800
+CONFIG_SYS_NAND_OOBSIZE=0x40
+CONFIG_SYS_NAND_U_BOOT_LOCATIONS=y
+CONFIG_SYS_NAND_U_BOOT_OFFS=0xc0000
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_PHY_ATHEROS=y
+CONFIG_PHY_SMSC=y
+CONFIG_MII=y
+CONFIG_DRIVER_TI_CPSW=y
+CONFIG_DM_PMIC=y
+# CONFIG_SPL_DM_PMIC is not set
+CONFIG_PMIC_TPS65217=y
+CONFIG_SPL_POWER_TPS65910=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_OMAP3_SPI=y
+CONFIG_TIMER=y
+CONFIG_OMAP_TIMER=y
+CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
+CONFIG_USB_MUSB_HOST=y
+CONFIG_USB_MUSB_GADGET=y
+CONFIG_USB_MUSB_TI=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="Texas Instruments"
+CONFIG_USB_GADGET_VENDOR_NUM=0x0451
+CONFIG_USB_GADGET_PRODUCT_NUM=0xd022
+CONFIG_USB_ETHER=y
+CONFIG_WDT=y
+# CONFIG_SPL_WDT is not set
+CONFIG_DYNAMIC_CRC_TABLE=y
+CONFIG_LZO=y
diff --git a/configs/am335x_evm_defconfig b/configs/am335x_evm_defconfig
index 17c0f840d3ad3cb6f09fa914655b304e90d0066a..448b0a8308fcca04732b81313c72f7fd2247d1ca 100644
--- a/configs/am335x_evm_defconfig
+++ b/configs/am335x_evm_defconfig
@@ -1,33 +1,12 @@
-CONFIG_ARM=y
-CONFIG_ARCH_CPU_INIT=y
-CONFIG_ARCH_OMAP2PLUS=y
-CONFIG_TI_COMMON_CMD_OPTIONS=y
-CONFIG_SF_DEFAULT_SPEED=24000000
-CONFIG_DEFAULT_DEVICE_TREE="am335x-evm"
-CONFIG_AM33XX=y
-CONFIG_CLOCK_SYNTHESIZER=y
+#include <configs/am335x_evm.config>
+
 CONFIG_AM335X_USB0=y
 CONFIG_AM335X_USB0_PERIPHERAL=y
 CONFIG_AM335X_USB1=y
-CONFIG_SYS_BOOTM_LEN=0x1000000
-CONFIG_SPL=y
-CONFIG_TIMESTAMP=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_SPL_LOAD_FIT=y
-CONFIG_DISTRO_DEFAULTS=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_BOOTCOMMAND="run findfdt; run init_console; run finduuid; run distro_bootcmd"
-CONFIG_LOGLEVEL=3
-CONFIG_SYS_CONSOLE_INFO_QUIET=y
-CONFIG_SPL_SYS_MALLOC=y
-CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
-CONFIG_SPL_FIT_IMAGE_TINY=y
-CONFIG_SPL_OPTIMIZE_INLINING=y
 CONFIG_SPL_ETH=y
-# CONFIG_SPL_FS_EXT4 is not set
 CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"
-CONFIG_SPL_MTD=y
 CONFIG_SPL_MUSB_NEW=y
 CONFIG_SPL_NAND_DRIVERS=y
 CONFIG_SPL_NAND_ECC=y
@@ -42,90 +21,31 @@ CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTOR=0x1500
 CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTORS=0x200
 CONFIG_CMD_EXTENSION=y
 CONFIG_CMD_SPL_NAND_OFS=0x00080000
-CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
-CONFIG_CMD_NAND=y
 # CONFIG_CMD_SETEXPR is not set
-CONFIG_BOOTP_DNS2=y
-CONFIG_CMD_MTDPARTS=y
 CONFIG_MTDIDS_DEFAULT="nand0=nand.0"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=nand.0:128k(NAND.SPL),128k(NAND.SPL.backup1),128k(NAND.SPL.backup2),128k(NAND.SPL.backup3),256k(NAND.u-boot-spl-os),1m(NAND.u-boot),128k(NAND.u-boot-env),128k(NAND.u-boot-env.backup1),8m(NAND.kernel),-(NAND.file-system)"
-# CONFIG_SPL_EFI_PARTITION is not set
-CONFIG_OF_CONTROL=y
 CONFIG_OF_LIST="am335x-evm am335x-bone am335x-sancloud-bbe am335x-sancloud-bbe-lite am335x-sancloud-bbe-extended-wifi am335x-boneblack am335x-evmsk am335x-bonegreen am335x-icev2 am335x-pocketbeagle am335x-bonegreen-eco"
-CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_SPL_ENV_IS_NOWHERE=y
-CONFIG_VERSION_VARIABLE=y
-CONFIG_NET_RETRY_COUNT=10
-CONFIG_BOOTP_SEND_HOSTNAME=y
-CONFIG_BOOTCOUNT_LIMIT=y
-CONFIG_SYS_BOOTCOUNT_BE=y
 CONFIG_CLK=y
 CONFIG_CLK_CCF=y
-CONFIG_CLK_CDCE9XX=y
 CONFIG_CLK_TI_AM3_DPLL=y
 CONFIG_CLK_TI_CTRL=y
 CONFIG_CLK_TI_DIVIDER=y
 CONFIG_CLK_TI_GATE=y
 CONFIG_CLK_TI_MUX=y
 CONFIG_DFU_TFTP=y
-CONFIG_DFU_MMC=y
-CONFIG_DFU_NAND=y
-CONFIG_DFU_RAM=y
-CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_FLASH=y
 CONFIG_FASTBOOT_FLASH_MMC_DEV=1
 CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
-CONFIG_DM_I2C=y
 CONFIG_MISC=y
-CONFIG_SYS_I2C_EEPROM_ADDR=0x50
-# CONFIG_MMC_HW_PARTITIONING is not set
-CONFIG_MMC_OMAP_HS=y
-CONFIG_MTD=y
-CONFIG_MTD_RAW_NAND=y
 CONFIG_SYS_NAND_BLOCK_SIZE=0x20000
-CONFIG_SYS_NAND_ONFI_DETECTION=y
-CONFIG_SYS_NAND_PAGE_SIZE=0x800
-CONFIG_SYS_NAND_OOBSIZE=0x40
-CONFIG_SYS_NAND_U_BOOT_LOCATIONS=y
-CONFIG_SYS_NAND_U_BOOT_OFFS=0xc0000
-CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_STMICRO=y
-CONFIG_SPI_FLASH_WINBOND=y
-CONFIG_PHY_ATHEROS=y
-CONFIG_PHY_SMSC=y
 CONFIG_PHY_TI_DP83867=y
 CONFIG_PHY_GIGE=y
-CONFIG_MII=y
-CONFIG_DRIVER_TI_CPSW=y
-CONFIG_DM_PMIC=y
-# CONFIG_SPL_DM_PMIC is not set
-CONFIG_PMIC_TPS65217=y
-CONFIG_SPL_POWER_TPS65910=y
 CONFIG_DM_PWM=y
 CONFIG_PWM_TI_ECAP=y
-CONFIG_SPI=y
-CONFIG_DM_SPI=y
-CONFIG_OMAP3_SPI=y
-CONFIG_TIMER=y
-CONFIG_OMAP_TIMER=y
-CONFIG_USB=y
-CONFIG_DM_USB_GADGET=y
 CONFIG_SPL_DM_USB_GADGET=y
-CONFIG_USB_MUSB_HOST=y
-CONFIG_USB_MUSB_GADGET=y
-CONFIG_USB_MUSB_TI=y
-CONFIG_USB_GADGET=y
 CONFIG_SPL_USB_GADGET=y
-CONFIG_USB_GADGET_MANUFACTURER="Texas Instruments"
-CONFIG_USB_GADGET_VENDOR_NUM=0x0451
-CONFIG_USB_GADGET_PRODUCT_NUM=0xd022
-CONFIG_USB_ETHER=y
 CONFIG_SPL_USB_ETHER=y
 CONFIG_VIDEO=y
 CONFIG_AM335X_LCD=y
-CONFIG_WDT=y
-# CONFIG_SPL_WDT is not set
-CONFIG_DYNAMIC_CRC_TABLE=y
-CONFIG_LZO=y
diff --git a/configs/am335x_evm_spiboot_defconfig b/configs/am335x_evm_spiboot_defconfig
index 97f56f36aa6c5912bbd5fec7580cd1cd204bec2f..eebd916c02a2cad0d01ab738aab37b11dd3a9645 100644
--- a/configs/am335x_evm_spiboot_defconfig
+++ b/configs/am335x_evm_spiboot_defconfig
@@ -1,108 +1,29 @@
-CONFIG_ARM=y
-CONFIG_ARCH_CPU_INIT=y
-CONFIG_ARCH_OMAP2PLUS=y
-CONFIG_TI_COMMON_CMD_OPTIONS=y
-CONFIG_SF_DEFAULT_SPEED=24000000
+#include <configs/am335x_evm.config>
+
 CONFIG_ENV_OFFSET=0x100000
 CONFIG_SPL_DM_SPI=y
-CONFIG_DEFAULT_DEVICE_TREE="am335x-evm"
-CONFIG_AM33XX=y
-CONFIG_CLOCK_SYNTHESIZER=y
 # CONFIG_SPL_MMC is not set
-CONFIG_SYS_BOOTM_LEN=0x1000000
-CONFIG_SPL=y
 # CONFIG_SPL_FS_FAT is not set
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
-CONFIG_TIMESTAMP=y
-CONFIG_SPL_LOAD_FIT=y
-CONFIG_DISTRO_DEFAULTS=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_BOOTCOMMAND="run findfdt; run init_console; run finduuid; run distro_bootcmd"
-CONFIG_LOGLEVEL=3
-CONFIG_SYS_CONSOLE_INFO_QUIET=y
-CONFIG_SPL_SYS_MALLOC=y
-CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
-CONFIG_SPL_FIT_IMAGE_TINY=y
-# CONFIG_SPL_FS_EXT4 is not set
-CONFIG_SPL_MTD=y
 # CONFIG_SPL_NAND_SUPPORT is not set
 CONFIG_SPL_DM_SPI_FLASH=y
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x20000
-CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
-CONFIG_CMD_NAND=y
 # CONFIG_CMD_SETEXPR is not set
-CONFIG_BOOTP_DNS2=y
-CONFIG_CMD_MTDPARTS=y
-# CONFIG_SPL_EFI_PARTITION is not set
-CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIST="am335x-evm am335x-bone am335x-boneblack am335x-evmsk am335x-bonegreen am335x-icev2 am335x-pocketbeagle am335x-bonegreen-eco"
-CONFIG_ENV_OVERWRITE=y
 # CONFIG_ENV_IS_IN_FAT is not set
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_SPL_ENV_IS_NOWHERE=y
-CONFIG_VERSION_VARIABLE=y
-CONFIG_NET_RETRY_COUNT=10
-CONFIG_BOOTP_SEND_HOSTNAME=y
 CONFIG_SPL_OF_TRANSLATE=y
 CONFIG_SPL_TI_SYSC=y
-CONFIG_BOOTCOUNT_LIMIT=y
-CONFIG_SYS_BOOTCOUNT_BE=y
 CONFIG_SPL_CLK=y
-CONFIG_CLK_CDCE9XX=y
 CONFIG_CLK_TI_CTRL=y
 CONFIG_DFU_TFTP=y
-CONFIG_DFU_MMC=y
-CONFIG_DFU_NAND=y
-CONFIG_DFU_RAM=y
-CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_FLASH=y
 CONFIG_FASTBOOT_FLASH_MMC_DEV=1
 CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
-CONFIG_DM_I2C=y
-CONFIG_SYS_I2C_EEPROM_ADDR=0x50
 # CONFIG_SPL_DM_MMC is not set
-# CONFIG_MMC_HW_PARTITIONING is not set
-CONFIG_MMC_OMAP_HS=y
-CONFIG_MTD=y
-CONFIG_MTD_RAW_NAND=y
-CONFIG_SYS_NAND_ONFI_DETECTION=y
-CONFIG_SYS_NAND_PAGE_SIZE=0x800
-CONFIG_SYS_NAND_OOBSIZE=0x40
-CONFIG_SYS_NAND_U_BOOT_LOCATIONS=y
-CONFIG_SYS_NAND_U_BOOT_OFFS=0xc0000
-CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_STMICRO=y
-CONFIG_SPI_FLASH_WINBOND=y
-CONFIG_PHY_ATHEROS=y
-CONFIG_PHY_SMSC=y
-CONFIG_MII=y
-CONFIG_DRIVER_TI_CPSW=y
-CONFIG_DM_PMIC=y
-# CONFIG_SPL_DM_PMIC is not set
-CONFIG_PMIC_TPS65217=y
-CONFIG_SPL_POWER_TPS65910=y
-CONFIG_SPI=y
-CONFIG_DM_SPI=y
-CONFIG_OMAP3_SPI=y
-CONFIG_TIMER=y
-CONFIG_OMAP_TIMER=y
-CONFIG_USB=y
-CONFIG_DM_USB_GADGET=y
-CONFIG_USB_MUSB_HOST=y
-CONFIG_USB_MUSB_GADGET=y
-CONFIG_USB_MUSB_TI=y
-CONFIG_USB_GADGET=y
-CONFIG_USB_GADGET_MANUFACTURER="Texas Instruments"
-CONFIG_USB_GADGET_VENDOR_NUM=0x0451
-CONFIG_USB_GADGET_PRODUCT_NUM=0xd022
-CONFIG_USB_ETHER=y
-CONFIG_WDT=y
-# CONFIG_SPL_WDT is not set
-CONFIG_DYNAMIC_CRC_TABLE=y
 CONFIG_RSA=y
-CONFIG_LZO=y
diff --git a/configs/am335x_hs_evm.config b/configs/am335x_hs_evm.config
new file mode 100644
index 0000000000000000000000000000000000000000..7ade2fb163b204ad8bcc9554455fdd3e81657890
--- /dev/null
+++ b/configs/am335x_hs_evm.config
@@ -0,0 +1,14 @@
+#include <configs/am335x_evm.config>
+
+CONFIG_TI_SECURE_DEVICE=y
+# CONFIG_SPL_ENV_SUPPORT is not set
+CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"
+# CONFIG_SPL_NAND_SUPPORT is not set
+CONFIG_SPL_NAND_DRIVERS=y
+CONFIG_SPL_NAND_ECC=y
+CONFIG_MTDIDS_DEFAULT="nand0=nand.0"
+CONFIG_MTDPARTS_DEFAULT="mtdparts=nand.0:128k(NAND.SPL),128k(NAND.SPL.backup1),128k(NAND.SPL.backup2),128k(NAND.SPL.backup3),256k(NAND.u-boot-spl-os),1m(NAND.u-boot),128k(NAND.u-boot-env),128k(NAND.u-boot-env.backup1),8m(NAND.kernel),-(NAND.file-system)"
+CONFIG_OF_LIST="am335x-evm am335x-bone am335x-boneblack am335x-evmsk am335x-bonegreen am335x-icev2 am335x-pocketbeagle am335x-bonegreen-eco"
+CONFIG_SPL_DM_USB_GADGET=y
+CONFIG_SPL_TINY_MEMSET=y
+CONFIG_RSA=y
diff --git a/configs/am335x_hs_evm_defconfig b/configs/am335x_hs_evm_defconfig
index e4eedd439c8a26052f57764059d660fbfabcb15b..8f140fa5b1e9d0edc80374fdd740e0ba9c65935d 100644
--- a/configs/am335x_hs_evm_defconfig
+++ b/configs/am335x_hs_evm_defconfig
@@ -1,96 +1,5 @@
-CONFIG_ARM=y
-CONFIG_ARCH_CPU_INIT=y
-CONFIG_ARCH_OMAP2PLUS=y
-CONFIG_TI_SECURE_DEVICE=y
-CONFIG_TI_COMMON_CMD_OPTIONS=y
-CONFIG_SF_DEFAULT_SPEED=24000000
-CONFIG_DEFAULT_DEVICE_TREE="am335x-evm"
-CONFIG_AM33XX=y
-CONFIG_CLOCK_SYNTHESIZER=y
+#include <configs/am335x_hs_evm.config>
+
 CONFIG_SPL_TEXT_BASE=0x40300350
-CONFIG_SYS_BOOTM_LEN=0x1000000
-CONFIG_SPL=y
-CONFIG_TIMESTAMP=y
-CONFIG_SPL_LOAD_FIT=y
-CONFIG_DISTRO_DEFAULTS=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_BOOTCOMMAND="run findfdt; run init_console; run finduuid; run distro_bootcmd"
-CONFIG_LOGLEVEL=3
-CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_SPL_MAX_SIZE=0xb0b0
-CONFIG_SPL_SYS_MALLOC=y
-CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
-CONFIG_SPL_FIT_IMAGE_TINY=y
-# CONFIG_SPL_ENV_SUPPORT is not set
-# CONFIG_SPL_FS_EXT4 is not set
-CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"
-CONFIG_SPL_MTD=y
-# CONFIG_SPL_NAND_SUPPORT is not set
-CONFIG_SPL_NAND_DRIVERS=y
-CONFIG_SPL_NAND_ECC=y
 # CONFIG_SPL_YMODEM_SUPPORT is not set
-CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
-CONFIG_CMD_NAND=y
-CONFIG_BOOTP_DNS2=y
-CONFIG_CMD_MTDPARTS=y
-CONFIG_MTDIDS_DEFAULT="nand0=nand.0"
-CONFIG_MTDPARTS_DEFAULT="mtdparts=nand.0:128k(NAND.SPL),128k(NAND.SPL.backup1),128k(NAND.SPL.backup2),128k(NAND.SPL.backup3),256k(NAND.u-boot-spl-os),1m(NAND.u-boot),128k(NAND.u-boot-env),128k(NAND.u-boot-env.backup1),8m(NAND.kernel),-(NAND.file-system)"
-# CONFIG_SPL_EFI_PARTITION is not set
-CONFIG_OF_CONTROL=y
-CONFIG_OF_LIST="am335x-evm am335x-bone am335x-boneblack am335x-evmsk am335x-bonegreen am335x-icev2 am335x-pocketbeagle am335x-bonegreen-eco"
-CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
-CONFIG_VERSION_VARIABLE=y
-CONFIG_NET_RETRY_COUNT=10
-CONFIG_BOOTP_SEND_HOSTNAME=y
-CONFIG_BOOTCOUNT_LIMIT=y
-CONFIG_SYS_BOOTCOUNT_BE=y
-CONFIG_CLK_CDCE9XX=y
-CONFIG_DFU_MMC=y
-CONFIG_DFU_NAND=y
-CONFIG_DFU_RAM=y
-CONFIG_USB_FUNCTION_FASTBOOT=y
-CONFIG_DM_I2C=y
-CONFIG_SYS_I2C_EEPROM_ADDR=0x50
-# CONFIG_MMC_HW_PARTITIONING is not set
-CONFIG_MMC_OMAP_HS=y
-CONFIG_MTD=y
-CONFIG_MTD_RAW_NAND=y
-CONFIG_SYS_NAND_ONFI_DETECTION=y
-CONFIG_SYS_NAND_PAGE_SIZE=0x800
-CONFIG_SYS_NAND_OOBSIZE=0x40
-CONFIG_SYS_NAND_U_BOOT_LOCATIONS=y
-CONFIG_SYS_NAND_U_BOOT_OFFS=0xc0000
-CONFIG_DM_SPI_FLASH=y
-CONFIG_SPI_FLASH_WINBOND=y
-CONFIG_PHY_ATHEROS=y
-CONFIG_PHY_SMSC=y
-CONFIG_MII=y
-CONFIG_DRIVER_TI_CPSW=y
-CONFIG_DM_PMIC=y
-# CONFIG_SPL_DM_PMIC is not set
-CONFIG_PMIC_TPS65217=y
-CONFIG_SPL_POWER_TPS65910=y
-CONFIG_SPI=y
-CONFIG_DM_SPI=y
-CONFIG_OMAP3_SPI=y
-CONFIG_TIMER=y
-CONFIG_OMAP_TIMER=y
-CONFIG_USB=y
-CONFIG_DM_USB_GADGET=y
-CONFIG_SPL_DM_USB_GADGET=y
-CONFIG_USB_MUSB_HOST=y
-CONFIG_USB_MUSB_GADGET=y
-CONFIG_USB_MUSB_TI=y
-CONFIG_USB_GADGET=y
-CONFIG_USB_GADGET_MANUFACTURER="Texas Instruments"
-CONFIG_USB_GADGET_VENDOR_NUM=0x0451
-CONFIG_USB_GADGET_PRODUCT_NUM=0xd022
-CONFIG_USB_ETHER=y
-CONFIG_WDT=y
-# CONFIG_SPL_WDT is not set
-CONFIG_DYNAMIC_CRC_TABLE=y
-CONFIG_SPL_TINY_MEMSET=y
-CONFIG_RSA=y
-CONFIG_LZO=y
diff --git a/configs/am335x_hs_evm_uart_defconfig b/configs/am335x_hs_evm_uart_defconfig
index f60f63f87d7018e10840b27ee9c5afc179c1e167..ff60802fdf1b01c53b650993d14b7ca0a081af9b 100644
--- a/configs/am335x_hs_evm_uart_defconfig
+++ b/configs/am335x_hs_evm_uart_defconfig
@@ -1,98 +1,8 @@
-CONFIG_ARM=y
-CONFIG_ARCH_CPU_INIT=y
-CONFIG_ARCH_OMAP2PLUS=y
-CONFIG_TI_SECURE_DEVICE=y
-CONFIG_TI_COMMON_CMD_OPTIONS=y
-CONFIG_SF_DEFAULT_SPEED=24000000
-CONFIG_DEFAULT_DEVICE_TREE="am335x-evm"
-CONFIG_AM33XX=y
-CONFIG_CLOCK_SYNTHESIZER=y
+#include <configs/am335x_hs_evm.config>
+
 # CONFIG_SPL_MMC is not set
 CONFIG_SPL_TEXT_BASE=0x40301950
-CONFIG_SYS_BOOTM_LEN=0x1000000
-CONFIG_SPL=y
 # CONFIG_SPL_FS_FAT is not set
 # CONFIG_SPL_LIBDISK_SUPPORT is not set
-CONFIG_TIMESTAMP=y
-CONFIG_SPL_LOAD_FIT=y
-CONFIG_DISTRO_DEFAULTS=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_BOOTCOMMAND="run findfdt; run init_console; run finduuid; run distro_bootcmd"
-CONFIG_LOGLEVEL=3
-CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_SPL_MAX_SIZE=0x9ab0
-CONFIG_SPL_SYS_MALLOC=y
-CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
-CONFIG_SPL_FIT_IMAGE_TINY=y
-# CONFIG_SPL_ENV_SUPPORT is not set
-# CONFIG_SPL_FS_EXT4 is not set
-CONFIG_SPL_MTD=y
-# CONFIG_SPL_NAND_SUPPORT is not set
-CONFIG_SPL_NAND_DRIVERS=y
-CONFIG_SPL_NAND_ECC=y
-CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
-CONFIG_CMD_NAND=y
 # CONFIG_CMD_SETEXPR is not set
-CONFIG_BOOTP_DNS2=y
-CONFIG_CMD_MTDPARTS=y
-CONFIG_MTDIDS_DEFAULT="nand0=nand.0"
-CONFIG_MTDPARTS_DEFAULT="mtdparts=nand.0:128k(NAND.SPL),128k(NAND.SPL.backup1),128k(NAND.SPL.backup2),128k(NAND.SPL.backup3),256k(NAND.u-boot-spl-os),1m(NAND.u-boot),128k(NAND.u-boot-env),128k(NAND.u-boot-env.backup1),8m(NAND.kernel),-(NAND.file-system)"
-# CONFIG_SPL_EFI_PARTITION is not set
-CONFIG_OF_CONTROL=y
-CONFIG_OF_LIST="am335x-evm am335x-bone am335x-boneblack am335x-evmsk am335x-bonegreen am335x-icev2 am335x-pocketbeagle am335x-bonegreen-eco"
-CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
-CONFIG_VERSION_VARIABLE=y
-CONFIG_NET_RETRY_COUNT=10
-CONFIG_BOOTP_SEND_HOSTNAME=y
-CONFIG_BOOTCOUNT_LIMIT=y
-CONFIG_SYS_BOOTCOUNT_BE=y
-CONFIG_CLK_CDCE9XX=y
-CONFIG_DFU_MMC=y
-CONFIG_DFU_NAND=y
-CONFIG_DFU_RAM=y
-CONFIG_USB_FUNCTION_FASTBOOT=y
-CONFIG_DM_I2C=y
-CONFIG_SYS_I2C_EEPROM_ADDR=0x50
-# CONFIG_MMC_HW_PARTITIONING is not set
-CONFIG_MMC_OMAP_HS=y
-CONFIG_MTD=y
-CONFIG_MTD_RAW_NAND=y
-CONFIG_SYS_NAND_ONFI_DETECTION=y
-CONFIG_SYS_NAND_PAGE_SIZE=0x800
-CONFIG_SYS_NAND_OOBSIZE=0x40
-CONFIG_SYS_NAND_U_BOOT_LOCATIONS=y
-CONFIG_SYS_NAND_U_BOOT_OFFS=0xc0000
-CONFIG_DM_SPI_FLASH=y
-CONFIG_SPI_FLASH_WINBOND=y
-CONFIG_PHY_ATHEROS=y
-CONFIG_PHY_SMSC=y
-CONFIG_MII=y
-CONFIG_DRIVER_TI_CPSW=y
-CONFIG_DM_PMIC=y
-# CONFIG_SPL_DM_PMIC is not set
-CONFIG_PMIC_TPS65217=y
-CONFIG_SPL_POWER_TPS65910=y
-CONFIG_SPI=y
-CONFIG_DM_SPI=y
-CONFIG_OMAP3_SPI=y
-CONFIG_TIMER=y
-CONFIG_OMAP_TIMER=y
-CONFIG_USB=y
-CONFIG_DM_USB_GADGET=y
-CONFIG_SPL_DM_USB_GADGET=y
-CONFIG_USB_MUSB_HOST=y
-CONFIG_USB_MUSB_GADGET=y
-CONFIG_USB_MUSB_TI=y
-CONFIG_USB_GADGET=y
-CONFIG_USB_GADGET_MANUFACTURER="Texas Instruments"
-CONFIG_USB_GADGET_VENDOR_NUM=0x0451
-CONFIG_USB_GADGET_PRODUCT_NUM=0xd022
-CONFIG_USB_ETHER=y
-CONFIG_WDT=y
-# CONFIG_SPL_WDT is not set
-CONFIG_DYNAMIC_CRC_TABLE=y
-CONFIG_SPL_TINY_MEMSET=y
-CONFIG_RSA=y
-CONFIG_LZO=y

-- 
2.51.0

