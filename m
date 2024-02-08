Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB2A8C4828F
	for <u-boot@archiver.kernel.org>; Thu,  8 Feb 2024 12:04:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BC0E87E62;
	Thu,  8 Feb 2024 13:03:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="UZ9gRDKn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8049687E37; Thu,  8 Feb 2024 13:03:26 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B96A487E51
 for <u-boot@lists.denx.de>; Thu,  8 Feb 2024 13:03:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=B.Hahn@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1707393800; x=1709985800;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DFz3eG2z7yQMKaFjIw8tElqOPzI3ZsdP6P+J/NeBO6o=;
 b=UZ9gRDKnzb28WeFck2EMkckWnbwejZOlpMxQpWSfn+I/RuxGwqRKF7xrnGF9pDyP
 AjRSp5k26P6DychZrIvl4b8BhiENjD4N9KUeETF2kIJ3NsErueBTMBRoBZj5PvVs
 nlFvaoc2SjeiaOYheeMHfEEEEvIi2yMJf0g/PWAW5m0=;
X-AuditID: ac14000a-fbefe7000000290d-7e-65c4c30870d5
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id AF.80.10509.803C4C56;
 Thu,  8 Feb 2024 13:03:20 +0100 (CET)
Received: from llp-hahn.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 8 Feb 2024
 13:03:20 +0100
From: Benjamin Hahn <B.Hahn@phytec.de>
Date: Thu, 8 Feb 2024 13:03:11 +0100
Subject: [PATCH v3 4/4] phycore-imx8mp: add support for booting and
 flashing emmc via UUU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240208-usb_support-v3-4-e605efd50512@phytec.de>
References: <20240208-usb_support-v3-0-e605efd50512@phytec.de>
In-Reply-To: <20240208-usb_support-v3-0-e605efd50512@phytec.de>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, NXP
 i.MX U-Boot Team <uboot-imx@nxp.com>, Teresa Remmet <t.remmet@phytec.de>, Tom
 Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, Dan Carpenter
 <dan.carpenter@linaro.org>, Benjamin Hahn <B.Hahn@phytec.de>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707393799; l=3532;
 i=B.Hahn@phytec.de; s=20240126; h=from:subject:message-id;
 bh=DFz3eG2z7yQMKaFjIw8tElqOPzI3ZsdP6P+J/NeBO6o=;
 b=OLI4Un8xL3LHyjXROOriVD5M8KLhDPe5dSEGDY0IK+noY6iYVpNRN5u4xf/4s7GdQeZSImfN2
 hBpSw9v1RNnD+iQd8mTnu5tuHTLBohA9fzH1PNBJJiuTYkkU0tYGp67
X-Developer-Key: i=B.Hahn@phytec.de; a=ed25519;
 pk=r04clMulHz6S6js6elPBA+U+zVdDAqJyEyoNd8I3pSw=
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkkeLIzCtJLcpLzFFi42JZI8nAo8tx+EiqwZFtGhYf5rWyWzy86m/R
 fsrHYuqkzewWb/d2sltMebye3aL7nboDu8e8WSdYPHbOusvu8erAKnaPO9f2sHmcvbOD0aO/
 u4XVY+O7HUwB7FFcNimpOZllqUX6dglcGZv+f2QtOCdd8WZjP3sD43/xLkZODgkBE4lNTyey
 dzFycQgJLGaS2PB8CjOE84BRYsqDWywgVWwCahK73rxm7WLk4GARUJG4d7cKJCwsEC3R9fcy
 I4jNKyAocXLmExaQEmYBTYn1u/RBwswC8hLb385hhiixk/jxeTETiC0EZC9r2Ak2nVPAXmLP
 kZdsIGtFBLYzSlxb/IsRxGEWaGGUmPS/ixFkqISAsMSmnVogcQmB3UwSKw++Z4GIJ0rsfC0H
 MVRW4ub5LWwQj8lLTDv3mhnCDpXY+mU70wRGkVlITp2FcOosJKcuYGRexSiUm5mcnVqUma1X
 kFFZkpqsl5K6iREUTSIMXDsY++Z4HGJk4mA8xCjBwawkwhuy5EiqEG9KYmVValF+fFFpTmrx
 IUZpDhYlcd7VHcGpQgLpiSWp2ampBalFMFkmDk6pBsbeh3P2SMzds0KIfZLXigrm7KXKNx3r
 GqZv3dq+SeXGtz+TZvKJrKyMXvHtOPfE7mcRy49veuOpyrdBJ2GLVKbmwo0q6z7P2JD1z9VQ
 3v1R8RoJ5pwf9RpPpqgFqr1fcqVgjw9TQnqgv5rQ75dmVafey+fpJxY8iHz7+frxS9sdv4qt
 dXhx1FxMiaU4I9FQi7moOBEAPh/CpJQCAAA=
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

add support for Serial Downloader Boot via UUU as well as flashing emmc
via UUU on USB0 Port of phyBOARD Pollux.

Reviewed-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>
---
 board/phytec/phycore_imx8mp/phycore-imx8mp.c |  4 ++++
 configs/phycore-imx8mp_defconfig             | 18 ++++++++++++++++--
 include/configs/phycore_imx8mp.h             |  5 +++++
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/board/phytec/phycore_imx8mp/phycore-imx8mp.c b/board/phytec/phycore_imx8mp/phycore-imx8mp.c
index a8f0821437..dbdd6bb793 100644
--- a/board/phytec/phycore_imx8mp/phycore-imx8mp.c
+++ b/board/phytec/phycore_imx8mp/phycore-imx8mp.c
@@ -46,6 +46,10 @@ int board_late_init(void)
 	case MMC3_BOOT:
 		env_set_ulong("mmcdev", 2);
 		break;
+	case USB_BOOT:
+		printf("Detect USB boot. Will enter fastboot mode!\n");
+		env_set_ulong("dofastboot", 1);
+		break;
 	default:
 		break;
 	}
diff --git a/configs/phycore-imx8mp_defconfig b/configs/phycore-imx8mp_defconfig
index e3fe4ed94e..0f37286d5d 100644
--- a/configs/phycore-imx8mp_defconfig
+++ b/configs/phycore-imx8mp_defconfig
@@ -27,7 +27,7 @@ CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="mmc dev ${mmcdev}; if mmc rescan; then if run loadimage; then run mmcboot; else run netboot; fi; fi;"
+CONFIG_BOOTCOMMAND="if test ${dofastboot} = 1; then fastboot 0; fi; mmc dev ${mmcdev}; if mmc rescan; then if run loadimage; then run mmcboot; else run netboot; fi; fi;"
 CONFIG_DEFAULT_FDT_FILE="oftree"
 CONFIG_SYS_CBSIZE=2048
 CONFIG_SYS_PBSIZE=2074
@@ -66,6 +66,7 @@ CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_USB_SDP=y
 CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_DHCP=y
 CONFIG_CMD_MII=y
@@ -87,6 +88,17 @@ CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM=y
 CONFIG_CLK_COMPOSITE_CCF=y
 CONFIG_CLK_IMX8MP=y
+CONFIG_USB_FUNCTION_FASTBOOT=y
+CONFIG_FASTBOOT_BUF_ADDR=0x42800000
+CONFIG_FASTBOOT_BUF_SIZE=0x13000000
+CONFIG_FASTBOOT_FLASH=y
+CONFIG_FASTBOOT_UUU_SUPPORT=y
+CONFIG_FASTBOOT_FLASH_MMC_DEV=2
+CONFIG_FASTBOOT_MMC_BOOT_SUPPORT=y
+CONFIG_FASTBOOT_MMC_BOOT1_NAME="mmc2boot0"
+CONFIG_FASTBOOT_MMC_BOOT2_NAME="mmc2boot1"
+CONFIG_FASTBOOT_MMC_USER_SUPPORT=y
+CONFIG_FASTBOOT_MMC_USER_NAME="mmc2"
 CONFIG_MXC_GPIO=y
 CONFIG_DM_I2C=y
 # CONFIG_SPL_DM_I2C is not set
@@ -111,6 +123,9 @@ CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_IMX8M=y
 CONFIG_SPL_POWER_LEGACY=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_IMX8M_POWER_DOMAIN=y
+CONFIG_IMX8MP_HSIOMIX_BLKCTRL=y
 CONFIG_POWER_PCA9450=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
@@ -136,5 +151,4 @@ CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_MANUFACTURER="FSL"
 CONFIG_USB_GADGET_VENDOR_NUM=0x0525
 CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
-CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_IMX_WATCHDOG=y
diff --git a/include/configs/phycore_imx8mp.h b/include/configs/phycore_imx8mp.h
index d79d364c8e..11a17be7fe 100644
--- a/include/configs/phycore_imx8mp.h
+++ b/include/configs/phycore_imx8mp.h
@@ -19,6 +19,11 @@
 	"fdt_addr=0x48000000\0" \
 	"fdt_file=" CONFIG_DEFAULT_FDT_FILE "\0" \
 	"ip_dyn=yes\0" \
+	"dofastboot=0\0" \
+	"fastboot_raw_partition_bootloader=64 8128\0" \
+	"fastboot_raw_partition_all=0 4194304\0" \
+	"emmc_dev=2\0" \
+	"sd_dev=1\0" \
 	"mmcdev=" __stringify(CONFIG_SYS_MMC_ENV_DEV) "\0" \
 	"mmcpart=1\0" \
 	"mmcroot=2\0" \

-- 
2.34.1

