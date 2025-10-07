Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE50CCD184
	for <u-boot@archiver.kernel.org>; Tue,  7 Oct 2025 08:19:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9338838E7;
	Tue,  7 Oct 2025 10:18:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fris.de header.i=@fris.de header.b="KpvaTc84";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 211228388D; Tue,  7 Oct 2025 10:18:24 +0200 (CEST)
Received: from mail.fris.de (mail.fris.de [IPv6:2a01:4f8:c2c:390b::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 321A4838E5
 for <u-boot@lists.denx.de>; Tue,  7 Oct 2025 10:18:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=frieder@fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4E702C9A4E; Tue,  7 Oct 2025 10:18:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
 t=1759825101; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=7v7jjTSbNkzebYklfS+nap3/mtVtZYubSITuUN89hco=;
 b=KpvaTc84EOhMvaHHwhs9Jv9gZMaDfp4rqlP0sL6a8M7yN4xhC3odG2tb/YOPlGHk0Nz5un
 aS3zazf8ftH0MGQPnTEkpQ/rlfhBb+1TniZ6EmPijN6SoCNjKTCIn5ciyQlBWFTkesi20S
 8ou3VDD9n8o2PQ6ASIgyCg4+kO8U/AEEeEjLkAUcPqtEb+SGXlKPuSIVihU233uq2CjrGa
 8ZEsCeBdTrsIOjf91snr4pCSdqxcMLvzoEH/Ia7KGXwLIb/o/7Ga99bkpOWKx5lx0OJjFC
 x4s8z+Zk0Kj5rDNKGxm5zcdZQVYLu6F3pP+Zq9zB0wCkjknDn+Maq9GZMX0lxQ==
From: Frieder Schrempf <frieder@fris.de>
To: Frieder Schrempf <frieder.schrempf@kontron.de>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Eberhard Stoll <eberhard.stoll@kontron.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 08/13] imx: kontron-sl-mx8mm: Enable multiple useful commands,
 drivers and features
Date: Tue,  7 Oct 2025 10:16:05 +0200
Message-ID: <20251007081640.61772-9-frieder@fris.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007081640.61772-1-frieder@fris.de>
References: <20251007081640.61772-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Frieder Schrempf <frieder.schrempf@kontron.de>

Enable a bunch of useful features such as:

* Linux devicetree fixups
* devicetree overlay support
* secure boot dependencies
* commands (filesystems, disks, etc.)
* fastboot support
* USB storage/ethernet

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 configs/kontron-sl-mx8mm_defconfig | 47 +++++++++++++++++++++++++++---
 1 file changed, 43 insertions(+), 4 deletions(-)

diff --git a/configs/kontron-sl-mx8mm_defconfig b/configs/kontron-sl-mx8mm_defconfig
index f11e58a8433..1d0a6a83052 100644
--- a/configs/kontron-sl-mx8mm_defconfig
+++ b/configs/kontron-sl-mx8mm_defconfig
@@ -14,6 +14,7 @@ CONFIG_DM_GPIO=y
 CONFIG_SPL_DM_SPI=y
 CONFIG_DEFAULT_DEVICE_TREE="imx8mm-kontron-bl"
 CONFIG_TARGET_KONTRON_MX8MM=y
+CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
@@ -38,8 +39,9 @@ CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_SYS_CBSIZE=2048
-CONFIG_SYS_PBSIZE=276
+CONFIG_SYS_PBSIZE=2074
 CONFIG_BOARD_TYPES=y
 # CONFIG_BOARD_INIT is not set
 CONFIG_BOARD_LATE_INIT=y
@@ -60,30 +62,52 @@ CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x58000
 CONFIG_SPL_WATCHDOG=y
 CONFIG_CMD_NVEDIT_EFI=y
+CONFIG_CRC32_VERIFY=y
 CONFIG_CMD_EEPROM=y
 CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
 CONFIG_SYS_EEPROM_SIZE=8192
 CONFIG_SYS_EEPROM_PAGE_WRITE_BITS=5
 CONFIG_SYS_EEPROM_PAGE_WRITE_DELAY_MS=6
+CONFIG_CMD_MD5SUM=y
+CONFIG_MD5SUM_VERIFY=y
+CONFIG_CMD_MEMTEST=y
+CONFIG_CMD_SHA1SUM=y
+CONFIG_SHA1SUM_VERIFY=y
 # CONFIG_CMD_LZMADEC is not set
 CONFIG_CMD_CLK=y
 CONFIG_CMD_DFU=y
 CONFIG_CMD_FUSE=y
 CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_GPT_RENAME=y
 CONFIG_CMD_I2C=y
+CONFIG_CMD_LSBLK=y
+CONFIG_CMD_MBR=y
 CONFIG_CMD_MMC=y
+CONFIG_CMD_BKOPS_ENABLE=y
+CONFIG_MMC_SPEED_MODE_SET=y
 CONFIG_CMD_MTD=y
+CONFIG_CMD_READ=y
+CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_USB_SDP=y
 CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_WDT=y
+CONFIG_CMD_BOOTCOUNT=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_RTC=y
 CONFIG_CMD_TIME=y
+CONFIG_CMD_GETTIME=y
+CONFIG_CMD_UUID=y
 CONFIG_CMD_PMIC=y
 CONFIG_CMD_REGULATOR=y
+CONFIG_CMD_SMC=y
+CONFIG_HASH_VERIFY=y
+CONFIG_CMD_BTRFS=y
 CONFIG_CMD_EXT4_WRITE=y
+CONFIG_CMD_FS_UUID=y
+CONFIG_PARTITION_TYPE_GUID=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIST="imx8mm-kontron-bl imx8mm-kontron-bl-osm-s"
@@ -93,9 +117,13 @@ CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_HOSTNAME=y
 CONFIG_HOSTNAME="kontron-mx8mm"
+CONFIG_VERSION_VARIABLE=y
+CONFIG_TFTP_TSIZE=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_REGMAP=y
+CONFIG_SYSCON=y
 CONFIG_BOOTCOUNT_LIMIT=y
 CONFIG_BOOTCOUNT_ENV=y
 CONFIG_SPL_CLK_COMPOSITE_CCF=y
@@ -103,6 +131,14 @@ CONFIG_CLK_COMPOSITE_CCF=y
 CONFIG_SPL_CLK_IMX8MM=y
 CONFIG_CLK_IMX8MM=y
 CONFIG_DFU_SF=y
+CONFIG_USB_FUNCTION_FASTBOOT=y
+CONFIG_FASTBOOT_BUF_ADDR=0x42000000
+CONFIG_FASTBOOT_FLASH=y
+CONFIG_FASTBOOT_UUU_SUPPORT=y
+CONFIG_FASTBOOT_FLASH_MMC_DEV=0
+CONFIG_FASTBOOT_MMC_BOOT_SUPPORT=y
+CONFIG_FASTBOOT_MMC_USER_SUPPORT=y
+CONFIG_GPIO_HOG=y
 CONFIG_MXC_GPIO=y
 CONFIG_DM_I2C=y
 CONFIG_I2C_EEPROM=y
@@ -122,6 +158,7 @@ CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_SPI_FLASH_MTD=y
 CONFIG_PHYLIB=y
 CONFIG_PHY_MSCC=y
+CONFIG_PHY_ETHERNET_ID=y
 CONFIG_DM_ETH_PHY=y
 CONFIG_PHY_GIGE=y
 CONFIG_FEC_MXC=y
@@ -157,7 +194,9 @@ CONFIG_USB=y
 CONFIG_SPL_USB_HOST=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_MXC_USB_OTG_HACTIVE=y
-# CONFIG_USB_STORAGE is not set
+CONFIG_USB_ONBOARD_HUB=y
+CONFIG_USB_HOST_ETHER=y
+CONFIG_USB_ETHER_SMSC95XX=y
 CONFIG_USB_GADGET=y
 CONFIG_SPL_USB_GADGET=y
 CONFIG_USB_GADGET_MANUFACTURER="FSL"
@@ -165,8 +204,8 @@ CONFIG_USB_GADGET_VENDOR_NUM=0x0525
 CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
 CONFIG_CI_UDC=y
 CONFIG_SDP_LOADADDR=0x40400000
-CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_USB_ETHER=y
+CONFIG_USB_ETH_CDC=y
 CONFIG_SPL_USB_SDP_SUPPORT=y
 # CONFIG_WATCHDOG_AUTOSTART is not set
 CONFIG_IMX_WATCHDOG=y
-# CONFIG_HEXDUMP is not set
-- 
2.51.0

