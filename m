Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB78FC47258
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 08:46:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0F4187C4B;
	Wed, 31 Jan 2024 09:46:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="lHW8gviG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29FA087B8A; Wed, 31 Jan 2024 09:46:06 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1276787C02
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 09:46:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=B.Hahn@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1706690762; x=1709282762;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DFz3eG2z7yQMKaFjIw8tElqOPzI3ZsdP6P+J/NeBO6o=;
 b=lHW8gviGdA7Aba5otO4AFiNYzhKCpKZXn7bt9H1tJqKirqh2S4E4U2i/5UMgWtyX
 mpIwPX3bSV9LkEaihuFJ6owpCzsKX3iyXQYZqFWI/Ehl/pVRu6DhOXbaAZmjhhFD
 8k2ttCxjPiqVWB05krs+Lbn529rRnIRCflCbj4Lvs64=;
X-AuditID: ac14000a-fbefe7000000290d-ad-65ba08c9f6b4
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 3E.0E.10509.9C80AB56;
 Wed, 31 Jan 2024 09:46:02 +0100 (CET)
Received: from llp-hahn.hahn.test (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 31 Jan
 2024 09:46:01 +0100
From: Benjamin Hahn <B.Hahn@phytec.de>
Date: Wed, 31 Jan 2024 09:45:40 +0100
Subject: [PATCH v2 4/4] phycore-imx8mp: add support for booting and
 flashing emmc via UUU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240131-usb_support-v2-4-7521c554b597@phytec.de>
References: <20240131-usb_support-v2-0-7521c554b597@phytec.de>
In-Reply-To: <20240131-usb_support-v2-0-7521c554b597@phytec.de>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, NXP
 i.MX U-Boot Team <uboot-imx@nxp.com>, Teresa Remmet <t.remmet@phytec.de>, Tom
 Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, Benjamin Hahn
 <B.Hahn@phytec.de>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706690760; l=3532;
 i=B.Hahn@phytec.de; s=20240126; h=from:subject:message-id;
 bh=DFz3eG2z7yQMKaFjIw8tElqOPzI3ZsdP6P+J/NeBO6o=;
 b=0Gkn3x7OzMABeM6nvqkK22+A6WVrTsSu++Y4oXPG27s5pvpi2xymoi6jtEJlFk+cc9DMSnDue
 87RGI7l6UB5BKBLXCH5DGUYpWJhUwDgTyuvKoYsWzsLRwbw25x7OfRs
X-Developer-Key: i=B.Hahn@phytec.de; a=ed25519;
 pk=r04clMulHz6S6js6elPBA+U+zVdDAqJyEyoNd8I3pSw=
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMLMWRmVeSWpSXmKPExsWyRpKBR/cUx65Ug8WGFg+v+lu0n/KxmDpp
 M7vF272d7BZTHq9nt+h+p+7A5jFv1gkWj52z7rJ7vDqwit3j7J0djB793S2sHhvf7WAKYIvi
 sklJzcksSy3St0vgytj0/yNrwTnpijcb+9kbGP+LdzFyckgImEhc+TuHrYuRi0NIYDGTxNoZ
 i5ghnIeMEttP97OAVLEJqEnsevOatYuRg4NFQFWiYwE7SFhYIFqi+0sHM4jNKyAocXLmExaQ
 EmYBTYn1u/RBwswC8hLb386BKrGTeLr7FdgUISB71/1YkDCngL3E7y8H2UG2ighsZ5S4tvgX
 I8SYKIl3E4NATAkBYYlNO7VASiQEdjNJzNtzih0iniix87UcyBghAVmJm+e3sEF8JS8x7dxr
 Zgg7VOLIptVMExhFZiG5cxbCnbOQ3LmAkXkVo1BuZnJ2alFmtl5BRmVJarJeSuomRlDEiDBw
 7WDsm+NxiJGJg/EQowQHs5II70q5nalCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeVd3BKcKCaQn
 lqRmp6YWpBbBZJk4OKUaGCdMtjiRxdtlsXL5rJMyBjw72pKzdm1zcd0crir0f8syOyEWn7VX
 9OqmPNKq3BbWqOy361XMtbrMj0f1vZd93721fEepr8JmZ6Ub7uaN6114z06NtS4Ieex6K0pz
 98G5vjnG7a4rBSoELQMeM28STlaRkq2Ts2WTiUjjLtiVFKrW95lBUo9RiaU4I9FQi7moOBEA
 lCn7E4YCAAA=
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

