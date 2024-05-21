Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB9CC25B74
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 09:41:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 192C588155;
	Tue, 21 May 2024 11:41:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1716284488;
	bh=MUK1696CywxjVYQaOzloaOZFR0S1IMrKD1S/exroebI=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=iSMbOgX/ztVCi2UguLZRRpwGI5un1n/DHXe/2RQRVyHtBy6yotObm5uov6M7D/4cf
	 x0pCmhg8mlt0lEvr0O+OfawvUhXDfJ6JaP6OdvKqmmrnfdZdOCpOrlEcEskd5dTF26
	 u8NdiLoyaMko+maEJROfqSf6hEyzkssDX32S14FwpXeZ1CZBqoCPae+hYkcWWW4a19
	 i4KLDOCiW5SO9AU7Id31OvxjFfxe2B57NiyyvPSnXlI67U22v42paPYUAgPyVBmHde
	 UJFW+9O/mS3qkgY0vo3NonXdxiHfCImcaDHJcuWItq1aT3BZqSeWPzQsWT15BegHEH
	 tU7J9WsvhpDpg==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 5A37888124;
 Tue, 21 May 2024 11:41:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1716284486;
 bh=MUK1696CywxjVYQaOzloaOZFR0S1IMrKD1S/exroebI=;
 h=From:To:Cc:Subject:Date:From;
 b=EXnbvkHZj08AhJD8X0WH4vaOLn5hnd//h4qW4vc61MVKZH+qByva4cnHrUeTUPxnA
 QoyDikZJu1rsBSxHcN6G85EWunuRjq6iIoVLL/TRiui9cRBjtq/NkCEvAbNxooGKBi
 0z2Hg4hzNCvtn0aVh0aAm1dt9n0e3SeEJsJaOmx0fAJaG0NzOQo1yKxtbuvc7gesum
 onCd/t3wsncTClZafmAdQaN/SoYyobiOpeCf5WNEnaZU4KsV7bZqjUWhoZS1m4Ttlw
 Rjbq0qgcaWPV2iaZAcXPpst6b2PJMpNjxfu5YEGlUykRaLrd/VdGar1bIlSyVxRQ65
 cgI5oxXCRdr8w==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Philippe Schenker <philippe.schenker@toradex.com>,
 Martyn Welch <martyn.welch@collabora.com>, Stefano Babic <sbabic@denx.de>
Subject: [PATCH] ARM: dts: imx8mm: Update iMX8MM Menlo board configuration
Date: Tue, 21 May 2024 11:40:45 +0200
Message-ID: <20240521094108.8858-1-marex@denx.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
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

Synchronize Toradex Verdin iMX8MM based MX8Menlo board configuration
with Toradex Verdin iMX8MM and enable convenience commands like cat,
hexdump, xxd.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc: Philippe Schenker <philippe.schenker@toradex.com>
Cc: Martyn Welch <martyn.welch@collabora.com>
Cc: Stefano Babic <sbabic@denx.de>
Cc: u-boot@lists.denx.de
---
 configs/imx8mm-mx8menlo_defconfig | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/configs/imx8mm-mx8menlo_defconfig b/configs/imx8mm-mx8menlo_defconfig
index 1ed7f0a2259..2fbd25491f7 100644
--- a/configs/imx8mm-mx8menlo_defconfig
+++ b/configs/imx8mm-mx8menlo_defconfig
@@ -22,15 +22,19 @@ CONFIG_SPL_STACK=0x920000
 CONFIG_SPL=y
 CONFIG_SYS_BOOTCOUNT_SINGLEWORD=y
 CONFIG_ENV_OFFSET_REDUND=0xFFFFDE00
+CONFIG_IMX_BOOTAUX=y
 CONFIG_SYS_LOAD_ADDR=0x40480000
 CONFIG_SYS_MEMTEST_START=0x40000000
 CONFIG_SYS_MEMTEST_END=0x80000000
 CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
+CONFIG_FIT_VERBOSE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_DISTRO_DEFAULTS=y
+CONFIG_BOOTDELAY=1
 CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_BOOTCOMMAND="mmc partconf 0 distro_bootpart && load ${devtype} ${devnum}:${distro_bootpart} ${loadaddr} boot/fitImage && source ${loadaddr}:bootscr-boot.cmd ; reset"
+CONFIG_USE_PREBOOT=y
 CONFIG_DEFAULT_FDT_FILE="imx8mm-mx8menlo.dtb"
 CONFIG_SYS_CBSIZE=2048
 CONFIG_SYS_PBSIZE=2081
@@ -57,19 +61,26 @@ CONFIG_SYS_PROMPT="Verdin iMX8MM # "
 # CONFIG_BOOTM_NETBSD is not set
 CONFIG_CMD_ASKENV=y
 # CONFIG_CMD_EXPORTENV is not set
-# CONFIG_CMD_CRC32 is not set
+CONFIG_CRC32_VERIFY=y
+CONFIG_CMD_MD5SUM=y
+CONFIG_MD5SUM_VERIFY=y
 CONFIG_CMD_MEMTEST=y
 CONFIG_CMD_CLK=y
 CONFIG_CMD_FUSE=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
+CONFIG_CMD_READ=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_USB_SDP=y
 CONFIG_CMD_USB_MASS_STORAGE=y
+CONFIG_CMD_CAT=y
+CONFIG_CMD_XXD=y
 CONFIG_CMD_BOOTCOUNT=y
 CONFIG_CMD_CACHE=y
+CONFIG_CMD_TIME=y
 CONFIG_CMD_UUID=y
+CONFIG_CMD_PMIC=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_BTRFS=y
 CONFIG_CMD_EXT4_WRITE=y
@@ -84,8 +95,9 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
-CONFIG_ETHPRIME="FEC"
+CONFIG_ETHPRIME="eth0"
 CONFIG_VERSION_VARIABLE=y
+CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_IP_DEFRAG=y
 CONFIG_TFTP_BLOCKSIZE=4096
 CONFIG_SPL_DM=y
@@ -96,16 +108,26 @@ CONFIG_CLK_COMPOSITE_CCF=y
 CONFIG_SPL_CLK_IMX8MM=y
 CONFIG_CLK_IMX8MM=y
 CONFIG_GPIO_HOG=y
+CONFIG_SPL_GPIO_HOG=y
 CONFIG_MXC_GPIO=y
 CONFIG_DM_I2C=y
 CONFIG_MISC=y
 CONFIG_I2C_EEPROM=y
 CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_SPL_MMC_IO_VOLTAGE=y
+CONFIG_MMC_UHS_SUPPORT=y
+CONFIG_SPL_MMC_UHS_SUPPORT=y
+CONFIG_MMC_HS400_ES_SUPPORT=y
+CONFIG_MMC_HS400_SUPPORT=y
+CONFIG_SPL_MMC_HS400_SUPPORT=y
 CONFIG_FSL_USDHC=y
 CONFIG_PHYLIB=y
 CONFIG_PHY_ADDR_ENABLE=y
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ90X1=y
+CONFIG_PHY_FIXED=y
+CONFIG_DM_MDIO=y
 CONFIG_FEC_MXC=y
 CONFIG_MII=y
 CONFIG_SPL_PHY=y
@@ -128,6 +150,7 @@ CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
 CONFIG_DM_THERMAL=y
+CONFIG_IMX_TMU=y
 CONFIG_USB=y
 CONFIG_SPL_USB_HOST=y
 CONFIG_USB_EHCI_HCD=y
@@ -143,3 +166,4 @@ CONFIG_SDP_LOADADDR=0x40400000
 CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_SPL_USB_SDP_SUPPORT=y
 CONFIG_IMX_WATCHDOG=y
+CONFIG_HEXDUMP=y
-- 
2.43.0

