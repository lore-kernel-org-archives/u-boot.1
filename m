Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03829CCFA00
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 16:36:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C26B083A3A;
	Fri, 31 Oct 2025 17:36:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="TbTCaqcb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B09B083A36; Fri, 31 Oct 2025 17:36:25 +0100 (CET)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BA6183A36
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 17:36:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id BD2D44E41446
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 16:36:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 94BE060704;
 Fri, 31 Oct 2025 16:36:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 783D511818087; Fri, 31 Oct 2025 17:36:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1761928582; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=ME64KbEflX5BSIH6jv7K9JVsBu7PG+bs7RB0bCSk2AU=;
 b=TbTCaqcbs5h9ABlEC45JqrVL5/4CoLmLWcSmimwvaxg7VHHK005FtOIzWvsAsygERKZ5ca
 IHvyO30TP+a7Rk1x0wY/DYVcVXxEGqmiko23ogQ7vvFxhLKcY3vPJ5crirfgifW3xY2NxI
 /A2aljKULQwvF0aDpK+JE7DXhXKbUqr8NPBPmuuwh4C6+vAf3mhG8DdyF3GwPsLtArVrh6
 ep305TzkSQMxwN3+2fcVS7frhmRBbvekFZmWdV3freTBftX5F2uhDeMPT+XVqX5C37jbAy
 wXU8q6INi+b7KWZwPyN7GcXCcqpuX+bxr7ZT6SoaaCgJfTMlDepV8hsO73vPyg==
From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
Date: Fri, 31 Oct 2025 17:36:04 +0100
Subject: [PATCH 2/2] include: configs: am335x_evm: Replace findduid with
 find_distro_rootpart
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-feature_distro_rootpart-v1-2-4e7c465708e8@bootlin.com>
References: <20251031-feature_distro_rootpart-v1-0-4e7c465708e8@bootlin.com>
In-Reply-To: <20251031-feature_distro_rootpart-v1-0-4e7c465708e8@bootlin.com>
To: u-boot@lists.denx.de
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 "Bajjuri, Praneeth" <praneeth@ti.com>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
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

The default config does not allow booting from different storage devices
when using the uuid environment variable to describe the rootfs partition.

Use the newly introduced find_distro_rootpart customizable environment
variable to locate the rootfs partition dynamically, instead of finduuid
which hardcodes the rootfs partition location (mmc 0:2). This allows the
board to boot from different storage devices while still using UUID-based
root partition identification.

Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
---
 configs/am335x_evm_defconfig         | 3 +--
 configs/am335x_evm_spiboot_defconfig | 3 +--
 configs/am335x_hs_evm_defconfig      | 2 +-
 configs/am335x_hs_evm_spi_defconfig  | 1 -
 configs/am335x_hs_evm_uart_defconfig | 3 +--
 include/configs/am335x_evm.h         | 4 +++-
 6 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/configs/am335x_evm_defconfig b/configs/am335x_evm_defconfig
index 2b68902edef..a85e76ef3a1 100644
--- a/configs/am335x_evm_defconfig
+++ b/configs/am335x_evm_defconfig
@@ -17,7 +17,7 @@ CONFIG_FIT_VERBOSE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_OF_BOARD_SETUP=y
-CONFIG_BOOTCOMMAND="run findfdt; run init_console; run finduuid; run distro_bootcmd"
+CONFIG_BOOTCOMMAND="run findfdt; run init_console; run distro_bootcmd"
 CONFIG_LOGLEVEL=3
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_SPL_SYS_MALLOC=y
@@ -44,7 +44,6 @@ CONFIG_CMD_SPL=y
 CONFIG_CMD_SPL_NAND_OFS=0x00080000
 CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
 CONFIG_CMD_NAND=y
-# CONFIG_CMD_SETEXPR is not set
 CONFIG_BOOTP_DNS2=y
 CONFIG_CMD_MTDPARTS=y
 CONFIG_MTDIDS_DEFAULT="nand0=nand.0"
diff --git a/configs/am335x_evm_spiboot_defconfig b/configs/am335x_evm_spiboot_defconfig
index f81149e9435..014dba4e8b3 100644
--- a/configs/am335x_evm_spiboot_defconfig
+++ b/configs/am335x_evm_spiboot_defconfig
@@ -19,7 +19,7 @@ CONFIG_TIMESTAMP=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_OF_BOARD_SETUP=y
-CONFIG_BOOTCOMMAND="run findfdt; run init_console; run finduuid; run distro_bootcmd"
+CONFIG_BOOTCOMMAND="run findfdt; run init_console; run distro_bootcmd"
 CONFIG_LOGLEVEL=3
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_SPL_SYS_MALLOC=y
@@ -34,7 +34,6 @@ CONFIG_SYS_SPI_U_BOOT_OFFS=0x20000
 CONFIG_CMD_SPL=y
 CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
 CONFIG_CMD_NAND=y
-# CONFIG_CMD_SETEXPR is not set
 CONFIG_BOOTP_DNS2=y
 CONFIG_CMD_MTDPARTS=y
 # CONFIG_SPL_EFI_PARTITION is not set
diff --git a/configs/am335x_hs_evm_defconfig b/configs/am335x_hs_evm_defconfig
index 6673038cb4c..bdf2e303eb9 100644
--- a/configs/am335x_hs_evm_defconfig
+++ b/configs/am335x_hs_evm_defconfig
@@ -15,7 +15,7 @@ CONFIG_TIMESTAMP=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_OF_BOARD_SETUP=y
-CONFIG_BOOTCOMMAND="run findfdt; run init_console; run finduuid; run distro_bootcmd"
+CONFIG_BOOTCOMMAND="run findfdt; run init_console; run distro_bootcmd"
 CONFIG_LOGLEVEL=3
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_SPL_MAX_SIZE=0xb0b0
diff --git a/configs/am335x_hs_evm_spi_defconfig b/configs/am335x_hs_evm_spi_defconfig
index df009844def..f6cf589275c 100644
--- a/configs/am335x_hs_evm_spi_defconfig
+++ b/configs/am335x_hs_evm_spi_defconfig
@@ -17,7 +17,6 @@ CONFIG_CMD_I2C=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_DFU=y
 CONFIG_CMD_GPIO=y
-# CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_EXT4_WRITE=y
 
 CONFIG_BLK=n
diff --git a/configs/am335x_hs_evm_uart_defconfig b/configs/am335x_hs_evm_uart_defconfig
index 00fe12f8f67..e93a45fd6a4 100644
--- a/configs/am335x_hs_evm_uart_defconfig
+++ b/configs/am335x_hs_evm_uart_defconfig
@@ -18,7 +18,7 @@ CONFIG_TIMESTAMP=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_OF_BOARD_SETUP=y
-CONFIG_BOOTCOMMAND="run findfdt; run init_console; run finduuid; run distro_bootcmd"
+CONFIG_BOOTCOMMAND="run findfdt; run init_console; run distro_bootcmd"
 CONFIG_LOGLEVEL=3
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_SPL_MAX_SIZE=0x9ab0
@@ -33,7 +33,6 @@ CONFIG_SPL_NAND_DRIVERS=y
 CONFIG_SPL_NAND_ECC=y
 CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
 CONFIG_CMD_NAND=y
-# CONFIG_CMD_SETEXPR is not set
 CONFIG_BOOTP_DNS2=y
 CONFIG_CMD_MTDPARTS=y
 CONFIG_MTDIDS_DEFAULT="nand0=nand.0"
diff --git a/include/configs/am335x_evm.h b/include/configs/am335x_evm.h
index d2164b41d6d..46dc7e2db4e 100644
--- a/include/configs/am335x_evm.h
+++ b/include/configs/am335x_evm.h
@@ -81,7 +81,9 @@
 #define CFG_EXTRA_ENV_SETTINGS \
 	DEFAULT_LINUX_BOOT_ENV \
 	"fdtfile=undefined\0" \
-	"finduuid=part uuid mmc 0:2 uuid\0" \
+	"find_distro_rootpart=" \
+		"setexpr distro_rootpart ${distro_bootpart} + 1 ;" \
+		"part uuid ${devtype} ${devnum}:${distro_rootpart} uuid ;\0" \
 	"console=ttyO0,115200n8\0" \
 	"partitions=" \
 		"uuid_disk=${uuid_gpt_disk};" \

-- 
2.43.0

