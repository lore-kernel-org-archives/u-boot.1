Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 962C8F43857
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 16:04:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86F9E842A2;
	Wed, 15 Apr 2026 18:04:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="I1YC+XO6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B02C284255; Wed, 15 Apr 2026 18:03:59 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 639118425F
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 18:03:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-43d7a5e77b1so2139601f8f.1
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 09:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776269035; x=1776873835;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vaL/94QoMaiOYY1DhgfnHu3bq9tAFCbGEBRcI6y3Uo0=;
 b=I1YC+XO61b0Qw9DQdC1RbSZi416s/6fCtZWnob4azNMemyF/KPJId8DLG0UM5GzCmT
 Biz13ItLt6qSPaCSYlcMkfYsRGwvxrheYPIccxfYIp3yHpqHD+gOvp+jIi6ayKmP7+PA
 7kcsV0N4qG5mhvJZffFtcPQD8WspaEefOpqwBLQkdEa9PJyAuxe8Wm8/TV6n2RwTDQf/
 DscqVGjhaEexl2Hme66ydj+lb/d/xWCaixLdz3CiQCEzxjv2gd66XlZs08lwwun1Ndze
 6uVKDqcG30kTEFvoy7VTL+HYubQpiaFfKOFeJw9GWtxKGrg9ywIUOBurgSIgs1sDoRUU
 K3YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776269035; x=1776873835;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vaL/94QoMaiOYY1DhgfnHu3bq9tAFCbGEBRcI6y3Uo0=;
 b=Ne9v+k0QcUChNUH8stzlyJOV6F30Q1nfGQUKxgbFJW69a/yGwWa+XIrvVcRWATW6pE
 9WSUI7rHDcxQ5izfh3FlUQliXDk4sDBrKgneNAKaFxl+63ZIQEWpor1d9reeufcQOodK
 5aDtTuuHM1ULL7CH30pNhPh8aPP4hHcfGcYQqcLcZyCbYBgkGzFxzVZ9j4byM1T+VA0O
 Y5tE8tBZD83nFQA7AYgxPlceGsmUJK89EPvmRdv8QzhbRbroAd8UlN9hxoyh/Z4wWUTb
 g42kX9G19Ozcw5FMYZAw+kHt8n5lKE+2xJZwQ7o3DzzuJQAn102pK2Zt4WKDE/SCZVEq
 ykOw==
X-Gm-Message-State: AOJu0Yw5+8o8/5hHOsx2l4EgDpO12r34MDY4ysJ7WuBLQEr75G78G7Tl
 0fUWxLsujQfvePyziF5GLRRuTbsiRDL5jeDkSLTAQh9v8keD5t0d2KaHBrUwdf8tdQc=
X-Gm-Gg: AeBDietidz64WqdXpEc0CFXnE6W2gnrqDxo9dXfDWomoqaacdUbwfc4arFLNkVkuAwP
 Wor0WMFo3JWrsJ9UZuzmu4M4HXn/11wdjAnEuCAf5A+azz74gTtuLHJ/jXc+SQgjoVYbOtTnShh
 Ql1lfOVv2ayYhl0qsBZLcRNBakftV09iO7QwzZCTgVgkvvwYgQpg5J8+X+LS+ImYPTCZYz3Zxgb
 Kaye/eQs2VDgZSB7JzzVtKau0YYR6LffUR+ETKqbCOv7MLuuFFXXlmDQBSpdhdrw/HDviqpF6/z
 KCSt+4lvVN5n81vftVDLvvcoJh287mGngCurhyXEd4U/jGB3fndnrx5TFaOs8zyoWcfBnPpAnTU
 jZKUlXKRxb4TUEU3xOyiPjLJF2w+J44486UUcQcl0WJKzhNlrVVE1szGh2aqXsptQonsthBmk5B
 Vo/YbzdSONMVO09noMzyanYBcFp5U0ACE=
X-Received: by 2002:a05:6000:471e:b0:43b:940a:3457 with SMTP id
 ffacd0b85a97d-43d595e0467mr36953915f8f.28.1776269034635; 
 Wed, 15 Apr 2026 09:03:54 -0700 (PDT)
Received: from localhost ([2001:4090:a246:83ca:1917:a47e:1872:2063])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43ead3e0091sm5449405f8f.25.2026.04.15.09.03.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 09:03:54 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Wed, 15 Apr 2026 18:02:26 +0200
Subject: [PATCH v6 05/14] configs: am335x_evm: Unify evm board defconfigs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-topic-am33-evm-oftree-v2026-01-v6-5-94cde349bb01@baylibre.com>
References: <20260415-topic-am33-evm-oftree-v2026-01-v6-0-94cde349bb01@baylibre.com>
In-Reply-To: <20260415-topic-am33-evm-oftree-v2026-01-v6-0-94cde349bb01@baylibre.com>
To: u-boot@lists.denx.de, Marc Murphy <marc.murphy@sancloud.com>
Cc: Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Parvathi Pudi <parvathi@couthit.com>, 
 Basharath Hussain Khaja <basharath@couthit.com>, 
 Paul Barker <paul.barker@sancloud.com>, "Andrew F. Davis" <afd@ti.com>, 
 Simon Glass <sjg@chromium.org>, Anshul Dalal <anshuld@ti.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Johan Jonker <jbx6244@gmail.com>, Brian Sune <briansune@gmail.com>, 
 Hai Pham <hai.pham.ud@renesas.com>, 
 Bernhard Messerklinger <bernhard.messerklinger@at.abb.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Parth Pancholi <parth.pancholi@toradex.com>, 
 =?utf-8?q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 Paul Kocialkowski <contact@paulk.fr>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=18909; i=msp@baylibre.com;
 h=from:subject:message-id; bh=0Cf356qmUbPpOF0hIIXPoDqrfGaPFedoBeFDomnblMU=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhsz729Y+UFKRXhfLcqek+czTBYVXd1VH9/6X3HlXaX30l
 eXXXVuXdZSyMIhxMciKKbJ0Joam/ZffeSx50bLNMHNYmUCGMHBxCsBEppYx/K8S/Jb1429crpml
 ZXOlQ0zW5y95UlttnARydv7JunldJZXhn6pCrdu7rYET219NynbPudd95+aGyNVODyqtGd+JTt3
 7ghUA
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
Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
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
2.53.0

