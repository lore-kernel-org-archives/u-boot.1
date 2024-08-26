Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6520FC5321D
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 16:49:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D02938897E;
	Mon, 26 Aug 2024 18:49:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="p1zpcZSj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41B9588AD2; Mon, 26 Aug 2024 18:49:14 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A6BD88A08
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 18:49:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=B.Hahn@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1724690952; x=1727282952;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7K5wKTaw4r4ryX6Z9yWiPrXSIktGsYqYVq9aTpAaAN4=;
 b=p1zpcZSj0aoMBF6mTyr4RITMmP2SP1uq+SOkhYOJEmsBCdenC1qz7QzNQ08Efdpq
 GdpqtGfEp4b/6+N2nAVwf+7wqr5TR7BVCKrdmZbeHAlBjtd7DpFXAIVSr07AiARo
 1zoXX4vc037OWgGiJoMOrZngqaZNkf5fVarHI0i36C8=;
X-AuditID: ac14000a-03e52700000021bc-b9-66ccb2076fc3
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id E0.BB.08636.802BCC66;
 Mon, 26 Aug 2024 18:49:12 +0200 (CEST)
Received: from llp-Hahn.hahn.test (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 26 Aug
 2024 18:49:11 +0200
From: Benjamin Hahn <B.Hahn@phytec.de>
Date: Mon, 26 Aug 2024 18:49:05 +0200
Subject: [PATCH 1/2] configs: phycore-imx8mp_defconfig: Enable SPI NOR
 flash support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240826-wip-bhahn-add_qspi_support-v1-1-0ea7840b940a@phytec.de>
References: <20240826-wip-bhahn-add_qspi_support-v1-0-0ea7840b940a@phytec.de>
In-Reply-To: <20240826-wip-bhahn-add_qspi_support-v1-0-0ea7840b940a@phytec.de>
To: Teresa Remmet <t.remmet@phytec.de>, Yannic Moog <y.moog@phytec.de>, Tom
 Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, Benjamin Hahn
 <B.Hahn@phytec.de>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724690951; l=2704;
 i=B.Hahn@phytec.de; s=20240126; h=from:subject:message-id;
 bh=7K5wKTaw4r4ryX6Z9yWiPrXSIktGsYqYVq9aTpAaAN4=;
 b=pmj4L+4uKpCxzV3ht1lZCtpeVrysNfmKzmUojgg7BWfTt0px8uoqKyUCfwfTz7P5DTek5Wyk/
 8Lrzk5KUUVlB6b28Ham9tr8Dhl7Ry1ARuX7cfl443/oA0WRw9nqRAcq
X-Developer-Key: i=B.Hahn@phytec.de; a=ed25519;
 pk=r04clMulHz6S6js6elPBA+U+zVdDAqJyEyoNd8I3pSw=
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOLMWRmVeSWpSXmKPExsWyRpKBR5dj05k0gxW/mS2mTtrMbvF2bye7
 Rfc7dQdmj1cHVrF7nL2zg9Gjv7uFNYA5issmJTUnsyy1SN8ugStj9g/RgkmiFZ/X32FqYHwo
 1MXIySEhYCJxYM4hxi5GLg4hgSVMElfWH2MBSQgJPGSUmNZeCGKzCahJ7HrzmhXEZhFQlVjR
 /pWpi5GDQ1ggTGLNJQ+QMK+AoMTJmU9YQMLMApoS63fpg4SZBeQltr+dwwxR4isx41UHE8R0
 X4n/R0+BbeIU8JM4u/wuG4gtIpAuse3Fd1aIMVES7yYGQVwpLPF59xo2kCslBHYzSbTPWMkM
 UiMhkCix87UcxEhZiZvnt7BB1MtLTDv3mhnCDpU4smk10wRGkVlIDp2FcOgsJIcuYGRexSiU
 m5mcnVqUma1XkFFZkpqsl5K6iREU+CIMXDsY++Z4HGJk4mA8xCjBwawkwit3+WSaEG9KYmVV
 alF+fFFpTmrxIUZpDhYlcd7VHcGpQgLpiSWp2ampBalFMFkmDk6pBkbpFKaeI9psknYiBvuv
 v17VlaoeF6tbe035WcX85OPudZzf9r9nEC9acO5Y8d7X9TLejl9K369xm+jeEOV+79Ivu2sW
 TSfW8/yWNrs8v39masVyJ7eTv2L2R2q92zzr6idW1Zi84w1eeX8iCiTzmO71dwW+e2ldsqyq
 1ajbZg6DRvZGwQu2UkosxRmJhlrMRcWJAL2gU9pqAgAA
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

Enable SPI NOR flash support in U-Boot.

Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>
---
 configs/phycore-imx8mp_defconfig | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/configs/phycore-imx8mp_defconfig b/configs/phycore-imx8mp_defconfig
index 63f8a80ba994..7f6e6c67bfd2 100644
--- a/configs/phycore-imx8mp_defconfig
+++ b/configs/phycore-imx8mp_defconfig
@@ -6,8 +6,10 @@ CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_PHYTEC_SOM_DETECTION=y
+CONFIG_SF_DEFAULT_SPEED=80000000
 CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0x3C0000
+CONFIG_ENV_SECT_SIZE=0x10000
 CONFIG_SYS_I2C_MXC_I2C1=y
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="freescale/imx8mp-phyboard-pollux-rdk"
@@ -29,7 +31,9 @@ CONFIG_SYS_LOAD_ADDR=0x40480000
 CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_SPL_LOAD_FIT=y
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_SYSTEM_SETUP=y
+CONFIG_FDT_FIXUP_PARTITIONS=y
 CONFIG_DEFAULT_FDT_FILE="oftree"
 CONFIG_SYS_CBSIZE=2048
 CONFIG_SYS_PBSIZE=2074
@@ -48,7 +52,9 @@ CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x300
 # CONFIG_SPL_CRYPTO is not set
 CONFIG_SPL_I2C=y
+CONFIG_SPL_NOR_SUPPORT=y
 CONFIG_SPL_POWER=y
+CONFIG_SPL_SPI_FLASH_MTD=y
 CONFIG_SPL_WATCHDOG=y
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_PROMPT="u-boot=> "
@@ -64,6 +70,8 @@ CONFIG_CMD_FUSE=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
+CONFIG_CMD_MTD=y
+CONFIG_CMD_SF_TEST=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_USB_SDP=y
 CONFIG_CMD_USB_MASS_STORAGE=y
@@ -77,10 +85,12 @@ CONFIG_CMD_EXT4=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
+CONFIG_CMD_MTDPARTS=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
+CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=2
@@ -113,6 +123,17 @@ CONFIG_MMC_UHS_SUPPORT=y
 CONFIG_MMC_HS400_ES_SUPPORT=y
 CONFIG_MMC_HS400_SUPPORT=y
 CONFIG_FSL_USDHC=y
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_BAR=y
+CONFIG_SPI_FLASH_MACRONIX=y
+CONFIG_SPI_FLASH_SPANSION=y
+CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_SPI_FLASH_SST=y
+CONFIG_SPI_FLASH_WINBOND=y
+# CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
+CONFIG_SPI_FLASH_MTD=y
 CONFIG_PHYLIB=y
 CONFIG_PHY_TI_DP83867=y
 CONFIG_DM_ETH_PHY=y
@@ -134,6 +155,9 @@ CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_SPL_POWER_I2C=y
 CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_NXP_FSPI=y
 CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_PSCI=y

-- 
2.34.1

