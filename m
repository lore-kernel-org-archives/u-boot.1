Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55463C83F1A
	for <u-boot@archiver.kernel.org>; Thu, 10 Jul 2025 08:17:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 408358349B;
	Thu, 10 Jul 2025 10:17:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="au55FgFq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7606983599; Thu, 10 Jul 2025 10:17:35 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2071b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::71b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DEE08344C
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 10:17:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=L.Anderweit@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xlvy8aVdRmY6uHF/f+Mj7p+ZK5uqDAipFgkBhu77GkBasz+7sDx2iuIAEywIVl03S6UpPVysbnWGSDtnqp/2QOH79NWEt5PabOZFvoEjxlHLh8KLyy/rtVfmQ8oUrh71MG5dxUrabHexVjV057wqqv2qlmdd0ZByrXAPVO++KCHYImdf5PvLTKwYwFW6a2YRn2JffWQPXjCXNM14VMH7XJ6flAEvrwJvdIILoS5WfECO0wOdZ76Xnbk+eniRZgrwPcFFC9fK4FRnphvYG2JKJHTI80YHV8Q/dMkzoL7z0swa8QExKnbISyaSbcbnaM3HUbaziwSTkgHfYuk8acXQNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jkWlvhE3SoGeznyh7KMLQ1xGTm16R74iPFJ5wTTIAMg=;
 b=paZ0FjKpyUrB0jnvUgVDsYc6q7T7+Jj+NbaBvjqBvelJauWH5u9Pqtc3CBMYJb3LwIZHsIwbRa6G7ayqdqcXfhNVDLKV98YCPOUUt+xIHnxpR5BBBjDcRDB2sFkeabbP44kuChCRxikxosmYbay/Hb4oGeJ5Yy4k88sSCP5ird7t4UdEAsGLMvPYImXko9VfFLBA574hJtaJxEX5DF4m1E0tInU4ULdW9TLIY4qZGgES9S1qEhvmvqJfg65SY18Pwr6F5sOGG9dbGPSD+PgblPt+aZFjwqulIMMIvmt6EnZIADZF7M31XshEHxpscJdaxpcFU8iFF3yqNpR4U0mkhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jkWlvhE3SoGeznyh7KMLQ1xGTm16R74iPFJ5wTTIAMg=;
 b=au55FgFq6ZCIaBDMTce1g9KT4FrBC2u6sGr97jVyni/ZDxfKhl/yFapYFGoBmTXI11+z2BZQXN/pHBrdr3Rh0rgVfL6yCX9pj0kmSKWlRSVrvUzcUCBmDdC7bvVsuth7i/N5ih/BQgn2gQRUTV/Tk20pzIV/2uvd5sq1csDWd0B8OslZAH78FJBlwsntMvlonpTqjMoYJdJelDzZPuYhqSZ8ms3EWVbdPvQieH2gJrCjs5DA6I7iTzSjxp+Mz8qF0X/7EQYJ9JTDvV6A1STKNjH8aaC2CkfdiNdyzSnPgfYJvOQ68Qu+0AYqnP5l2lbm0Fbn7SLdx+zphuv9OLwK/w==
Received: from AM0PR03CA0057.eurprd03.prod.outlook.com (2603:10a6:208::34) by
 GVXP195MB1806.EURP195.PROD.OUTLOOK.COM (2603:10a6:150::6) with
 Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.27; Thu, 10 Jul 2025 08:17:28 +0000
Received: from AMS0EPF00000191.eurprd05.prod.outlook.com
 (2603:10a6:208:0:cafe::fd) by AM0PR03CA0057.outlook.office365.com
 (2603:10a6:208::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22 via Frontend Transport; Thu,
 10 Jul 2025 08:17:28 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AMS0EPF00000191.mail.protection.outlook.com (10.167.16.216) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 08:17:28 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Thu, 10 Jul
 2025 10:17:27 +0200
Received: from llp-anderweit.phytec.de (172.25.32.71) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Thu, 10 Jul
 2025 10:17:27 +0200
From: Leonard Anderweit <l.anderweit@phytec.de>
To: Teresa Remmet <t.remmet@phytec.de>, Tom Rini <trini@konsulko.com>,
 Benjamin Hahn <B.Hahn@phytec.de>, Leonard Anderweit <l.anderweit@phytec.de>,
 Yashwanth Varakala <y.varakala@phytec.de>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Yannic Moog <y.moog@phytec.de>
CC: <upstream@lists.phytec.de>, <u-boot@lists.denx.de>
Subject: [PATCH] phycore-imx8mp: Enable standard boot
Date: Thu, 10 Jul 2025 10:17:17 +0200
Message-ID: <20250710081717.435585-1-l.anderweit@phytec.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.32.71]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000191:EE_|GVXP195MB1806:EE_
X-MS-Office365-Filtering-Correlation-Id: 017cb5a5-6c9e-4919-6f05-08ddbf8a3585
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nB0Sl/IIfIfJwMqJDMk7pMhj82GYGAj7fEXOL22cvUmDySJP9NyaEsVQVzLa?=
 =?us-ascii?Q?xD1SnVv7bPQwtOK6zqKS4S6B5aILSJ+uRzQrDDOTivk3cEDImBwICRHN705R?=
 =?us-ascii?Q?EwsXMRR64SXxFbSEO6Y7fsVNs+GMU5FEEfVQuQj5+alw5b4zXziwv3fURiAt?=
 =?us-ascii?Q?swKXFakZsW9MmRFnZadoL2AWVkRZwgujSFhCIT1RV4exPDOCRWv7ki75TKPQ?=
 =?us-ascii?Q?1aBAfKZtnhVWkPn09u/EGP08tSmJOUwhGGC241afOOMJr8DDymhKRkUjQxgB?=
 =?us-ascii?Q?tUybb5stgfYwcvfgKxyxcHAh7roDNLZ0jhJvwc1btjT8LzOMdRFJiqgKWCFW?=
 =?us-ascii?Q?g/qpq7jJWiyq3Vk2VKGffEXOLVvHfJ+b91nQIBc6PecUh1p+SceuJN1LKhca?=
 =?us-ascii?Q?Jgu6nPcnOyzQjd9WyDkBlesbfEh5Tn5RpHTlXlUBLLIeMIRfKwLYXrJb/wiU?=
 =?us-ascii?Q?dnjR+AKOP1tfzmRFwV2B+cuUM9WaNsimWIV5meIX+F6d1LqOPb9VqTDAUmL8?=
 =?us-ascii?Q?YG5DBWxHm+d98/ZWaLnC6Szd/Sl098oY6kGOi4HZ2SGjykXytaoGpQbmd51r?=
 =?us-ascii?Q?QrFub5ESNx8czpVWiBuTIPEdLWyHWnuYTUDcF8ClcbmaC2cHndmGdEnKjpY8?=
 =?us-ascii?Q?MFYMb/QAeje8b6lVIAWNmZGcJS+nfPFsyPvisiywJhAQeAGyqBqYTe1sexAd?=
 =?us-ascii?Q?AWjY7o6UolVnUYRkDf3oE/QddPUJBruWV2TzS6XYB/f1W9mG2NkDCWjy3Euz?=
 =?us-ascii?Q?lrTbas1XE9a2mnsyWTGGYlXChERx0iu3e91Azl23KjmSSkLWv+yXBv5pyzs6?=
 =?us-ascii?Q?ctDH0EHX3vhXoTQyX8eUy3bs9eJ/bf9zesSKupUQZUdjSuiWrhSACdVigiXd?=
 =?us-ascii?Q?oCQWWWWWT7C3fHgEIB4aVsxW7VEVZr81Y0/rIuSf7YRC0Hu3K5XbThXs1KPJ?=
 =?us-ascii?Q?REbvIAOCq08nSv27fiRrOWYPHYUuK8LWn+Gq9kwe+Gs6b4v4MrhK0czYvoCv?=
 =?us-ascii?Q?szIBcaMtCE6RrP7ROnttlTC2Qqh9vhKM7bSnlHnV5L5h83ismbA86btalDOj?=
 =?us-ascii?Q?7NyXoGy+FbGhSOWldWOyrnqlCNXg+Lf7PNfVbCBwoo/pTTa5wVqAuj2l2beT?=
 =?us-ascii?Q?ZALLzvQ0EUmfCL2rJTushRuKH9S126hZEVazzYgIA+zjNbEx6Syd7a2pJPzf?=
 =?us-ascii?Q?48Vvq7WWo25Re/s1cJCckLvXpuf8hhHSfE6qbJSRiABBy/MgpyIgD0INM+en?=
 =?us-ascii?Q?um/HUM8aw4TerhI28m3Fpo/rCKfGQHkKlSDavPEs9+WXSSVxYs4mKTfIuvLA?=
 =?us-ascii?Q?s8U8SH/PnKJ1OrACsUH99rXt6rvK/1krkPzGdS0GFjC2FIEuZNuMpUeq7OJT?=
 =?us-ascii?Q?StVay1OeI2zARMPs0c+kN/RizAUxu045b4Acd2xqrq5z5GYaxcwBiYXnJMw/?=
 =?us-ascii?Q?DdE2Am6d+I0ddwLfRfiqjH2cx0GTkd7sP68t1BMy6XZvJSspw+rozyFQvxNv?=
 =?us-ascii?Q?4Y+n4GnOy2nT0+8PFScEHRPVNWVfZblGKRxu?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 08:17:28.0351 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 017cb5a5-6c9e-4919-6f05-08ddbf8a3585
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF00000191.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP195MB1806
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

Enable standard boot for the phycore-imx8mp and use it as default. Add
all variables required for standard boot to the environment.

Signed-off-by: Leonard Anderweit <l.anderweit@phytec.de>
Tested-by: Martin Schwan <m.schwan@phytec.de>
---
 .../phytec/phycore_imx8mp/phycore_imx8mp.env  | 78 +++----------------
 configs/phycore-imx8mp_defconfig              | 17 ++--
 2 files changed, 20 insertions(+), 75 deletions(-)

diff --git a/board/phytec/phycore_imx8mp/phycore_imx8mp.env b/board/phytec/phycore_imx8mp/phycore_imx8mp.env
index 69690aa92e4f..9a129a0a4bfc 100644
--- a/board/phytec/phycore_imx8mp/phycore_imx8mp.env
+++ b/board/phytec/phycore_imx8mp/phycore_imx8mp.env
@@ -1,82 +1,28 @@
-#include <env/phytec/rauc.env>
-#include <env/phytec/overlays.env>
-
 bootcmd=
 	if test ${dofastboot} = 1; then
 		fastboot 0;
 	fi;
-	mmc dev ${mmcdev};
-	if mmc rescan; then
-		run spiprobe;
-		if test ${doraucboot} = 1; then
-			run raucinit;
-		fi;
-		if run loadimage; then
-			run mmcboot;
-		else
-			run netboot;
-		fi;
-	fi;
-console=ttymxc0,115200
+	bootflow scan -lb;
+bootmeths=script efi
+boot_targets=mmc2 mmc1 usb ethernet
 bootenv_addr_r=0x49100000
-fdtoverlay_addr_r=0x49000000
+boot_script_dhcp=boot.scr.uimg
+console=ttymxc0,115200
 dofastboot=0
-emmc_dev=2
 fastboot_raw_partition_all=0 4194304
 fastboot_raw_partition_bootloader=64 8128
 fdt_addr_r=0x48000000
 fdtfile=CONFIG_DEFAULT_FDT_FILE
-image=Image
+fdtoverlay_addr_r=0x49000000
 ip_dyn=yes
+kernel_addr_r=0x5A080000
+kernel_comp_addr_r=0x60000000
+kernel_comp_size=0x2000000
 mtdparts=30bb0000.spi:3840k(u-boot),128k(env),128k(env_redund),-(none)
 mtdids=nor0=30bb0000.spi
-spiprobe=true
-loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdtfile}
-loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}
-mmcargs=
-	setenv bootargs ${mcore_clk} console=${console}
-	root=/dev/mmcblk${mmcdev}p${mmcroot} ${raucargs} rootwait rw
 mmcautodetect=yes
-mmcboot=
-	echo Booting from mmc ...;
-	if test ${no_bootenv} = 0; then
-		if run mmc_load_bootenv; then
-			env import -t ${bootenv_addr_r} ${filesize};
-		fi;
-	fi;
-	run mmcargs;
-	if run loadfdt; then
-		run mmc_apply_overlays;
-		booti ${loadaddr} - ${fdt_addr_r};
-	else
-		echo WARN: Cannot load the DT;
-	fi;
 mmcdev=CONFIG_ENV_MMC_DEVICE_INDEX
-mmcpart=1
-mmcroot=2
-netargs=
-	setenv bootargs ${mcore_clk} console=${console} root=/dev/nfs ip=dhcp
-	nfsroot=${serverip}:${nfsroot},v3,tcp
-netboot=
-	echo Booting from net ...;
-	if test ${ip_dyn} = yes; then
-		setenv get_cmd dhcp;
-	else
-		setenv get_cmd tftp;
-	fi;
-	if test ${no_bootenv} = 0; then
-		if run net_load_bootenv; then
-			env import -t ${bootenv_addr_r} ${filesize};
-		fi;
-	fi;
-	${get_cmd} ${loadaddr} ${image};
-	run netargs;
-	if ${get_cmd} ${fdt_addr_r} ${fdtfile}; then
-		run net_apply_overlays;
-		booti ${loadaddr} - ${fdt_addr_r};
-	else
-		echo WARN: Cannot load the DT;
-	fi;
 nfsroot=/srv/nfs
-prepare_mcore=setenv mcore_clk clk-imx8mp.mcore_booted
-sd_dev=1
+pxefile_addr_r=0x58600000
+ramdisk_addr_r=0x5E000000
+scriptaddr=0x40000000
diff --git a/configs/phycore-imx8mp_defconfig b/configs/phycore-imx8mp_defconfig
index cb38898a2458..975d061e7bac 100644
--- a/configs/phycore-imx8mp_defconfig
+++ b/configs/phycore-imx8mp_defconfig
@@ -31,10 +31,13 @@ CONFIG_IMX_BOOTAUX=y
 CONFIG_SPL_IMX_ROMAPI_LOADADDR=0x48000000
 CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
+CONFIG_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
+CONFIG_BOOTSTD_FULL=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_FDT_FIXUP_PARTITIONS=y
+# CONFIG_USE_BOOTCOMMAND is not set
 CONFIG_DEFAULT_FDT_FILE="oftree"
 CONFIG_SYS_CBSIZE=2048
 CONFIG_SYS_PBSIZE=2074
@@ -57,9 +60,11 @@ CONFIG_SPL_NOR_SUPPORT=y
 CONFIG_SPL_POWER=y
 CONFIG_SPL_SPI_FLASH_MTD=y
 CONFIG_SPL_WATCHDOG=y
-CONFIG_HUSH_PARSER=y
 CONFIG_SYS_PROMPT="u-boot=> "
+# CONFIG_CMD_VBE is not set
+CONFIG_CMD_BOOTEFI_SELFTEST=y
 CONFIG_CMD_ERASEENV=y
+CONFIG_CMD_NVEDIT_EFI=y
 # CONFIG_CMD_CRC32 is not set
 CONFIG_CMD_EEPROM=y
 CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
@@ -76,17 +81,12 @@ CONFIG_CMD_SF_TEST=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_USB_SDP=y
 CONFIG_CMD_USB_MASS_STORAGE=y
-CONFIG_CMD_DHCP=y
-CONFIG_CMD_MII=y
-CONFIG_CMD_PING=y
 CONFIG_CMD_CACHE=y
+CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_REGULATOR=y
-CONFIG_CMD_EXT2=y
-CONFIG_CMD_EXT4=y
 CONFIG_CMD_EXT4_WRITE=y
-CONFIG_CMD_FAT=y
-CONFIG_CMD_FS_GENERIC=y
 CONFIG_CMD_MTDPARTS=y
+# CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
@@ -172,7 +172,6 @@ CONFIG_USB_XHCI_DWC3_OF_SIMPLE=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_DWC3=y
 CONFIG_USB_DWC3_GENERIC=y
-CONFIG_USB_STORAGE=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_MANUFACTURER="PHYTEC"
 CONFIG_USB_GADGET_VENDOR_NUM=0x0525
-- 
2.43.0

