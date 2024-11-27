Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51DA3D6ACC3
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 12:18:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3734897DB;
	Wed, 27 Nov 2024 13:18:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="EhnRNzg9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A0CC897DA; Wed, 27 Nov 2024 13:18:01 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2071b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::71b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D04A3897D3
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 13:17:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XIfpx2CwMEKoYiaW9bz5KTT+zysHdW34sm6hd5Q4MZbce9dKho4hOT6wTIjwczi2Hw0SlfvH+a+wbtt8nTzWltClUQ/fMLFo7Bipd0Xd44S/X7kvpcqJxBq7+YQhx13rI1qTGlXMPMf7d5VCzmh72xuCzqmOXIgPfImqcOccJfw4AYUjFDthXtKW65cun9O4zX2PjLdnsE0oiSctldKaLL8keiDOJU/FWE/e1TzQ5ROX4r4F2avJaIxTAmmqoULfUjFibnurV+jWLczL559kehbXEnbJm8PkR+Xggo1gktF0UPhP+4R0Uze1v4As4fk6JLHB/3j/rtYENO7TNjiPIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HCgfAMTWSjLN2GoOvFtzfigqsqhvEWMW1LTQPaVm2HA=;
 b=QVZcMkwOM3hQmoItZwOf/4344NE2s5/waASH2y6gVDaVPd8UVrzv8fZ0vY6Dv56SynzT/wkHOw/bmZojz1X13vDThWxs0OdS4/6SYPDMNN0vO5+uLCXOi2Fj4pXpOz/3u7E/35c9DFSxq1KtMhbPLbd4Np4GNPLRkb8t/cxY1kPtC1md20vhf8cvbKaYsMESDeD/nEhggZ3O8xOduXxJLwiuXc7lyaPgsDqXar8o/luTQpTalM1hBEIbO79Ssq6+qQCHdreTqRn7W++psgNZep2gn+9+GZBcjq3R6CtxVI5tArF8Yvq5c1BZafj5G45F050XQffnPG1Ua8+q1Ztq0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCgfAMTWSjLN2GoOvFtzfigqsqhvEWMW1LTQPaVm2HA=;
 b=EhnRNzg9TChe3yuRWlbWrTJgmH1jE2RWRFtL32u73myADhz/3bBlAhZaymCSHLIYE9Ed2N/TpfxPxuBD3VHrVDfLoQb0xd2B2s1f5R/sr5KQMxje1+pfTUisoJRV8GPgFcMt0H5lwMrIUp2SPDZOuFnSnppfluh2fkgsY3PD7Ao=
Received: from DUZPR01CA0352.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::15) by AS8P195MB2341.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:635::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Wed, 27 Nov
 2024 12:17:55 +0000
Received: from DU6PEPF0000B622.eurprd02.prod.outlook.com
 (2603:10a6:10:4b8:cafe::7) by DUZPR01CA0352.outlook.office365.com
 (2603:10a6:10:4b8::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.13 via Frontend Transport; Wed,
 27 Nov 2024 12:17:55 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DU6PEPF0000B622.mail.protection.outlook.com (10.167.8.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8207.12 via Frontend Transport; Wed, 27 Nov 2024 12:17:55 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 27 Nov
 2024 13:17:54 +0100
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 27 Nov
 2024 13:17:54 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <trini@konsulko.com>, <n-francis@ti.com>, <d-gole@ti.com>, <afd@ti.com>,
 <nm@ti.com>, <d.schultz@phytec.de>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
Subject: [PATCH 4/4] configs: phycore_am6*_a53_defconfig: Enable capsule update
Date: Wed, 27 Nov 2024 13:17:36 +0100
Message-ID: <20241127121736.1525948-5-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241127121736.1525948-1-w.egorov@phytec.de>
References: <20241127121736.1525948-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B622:EE_|AS8P195MB2341:EE_
X-MS-Office365-Filtering-Correlation-Id: ba792e2e-050b-4032-42cc-08dd0edd8625
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?T9KupI92coWEOD0yEXdDyUqAATbrYZw20np8c/xKqXtaChmqFRzccOJzdYir?=
 =?us-ascii?Q?XRWAnz8gYBjoFEBpCG25C78+zasBiz8FtnYXBRZFlngA2NcqDB/t0cnbjBA+?=
 =?us-ascii?Q?lDHVhi17WU6CV+0lU7SR8aDJSxd0MnT7n29O8nKeiNsVL7bAxFwdKxSn/ewM?=
 =?us-ascii?Q?sSajYUi8mFyt49jROFLQk3TF4pjIzvhkAEaj9E7oGhkN952vdr2SAXFILsBD?=
 =?us-ascii?Q?5PSY91GdpMyCxDQx6dSvVPi2/+jssAvmETNZQ0wgMmzbj5lYHhI5TKP2V7QP?=
 =?us-ascii?Q?a5uzEmND6d++JSYEr9EohtwfmYIfTbQPbp3j7n0NqPrktfRFjzvZo7OSj3aB?=
 =?us-ascii?Q?I67NLwfEskXALZJXqvsza/fq8b7IvhG2+Et7lk4RhlPM6eEU3k3pWv1uWAmZ?=
 =?us-ascii?Q?fTUbX9Lsir74/fhyQTDOEAlAGoLJTcmJkeiW2XXV2jVe/OJASYfAlFYLSd0n?=
 =?us-ascii?Q?85corJSfwvRWCu5BsNtk13jQREnlPjfjPMK02FO4+HG6aykXBe3QMdDgvXFt?=
 =?us-ascii?Q?hJWN3NYBlZBejU2Yqe5eIU76ldxSHUfoI8uOuGA9r2op0Soq7oOhAiQK/HAO?=
 =?us-ascii?Q?cBgMHzRlqdto8gby3Du73eo59QXOwqfnrxtGk3GVx17pgYe8Y8ZW9YCCPeIU?=
 =?us-ascii?Q?rR4clBAIoB4uQwxhg3FqVS4QmfwKzaNf+FlQIsr1bhU08E7p/2/RMZOLqW9z?=
 =?us-ascii?Q?8aZlgINn+O1nQlhKiR75qI2TdDFMjDYDweSpZ/7aQgXEip8fKM88nLMi0HsY?=
 =?us-ascii?Q?4Mx8BlXylWFUK1R85ys1pC7yPE64NOQdEWt3TdznbmS5eRUNsssMDVLsday5?=
 =?us-ascii?Q?LoQbKoQdqyTwEA0lCi3fnJdkRnWazQQlLwZ1NYCc5Nd+ZHSzDV/2rdaOHipT?=
 =?us-ascii?Q?xeMP94UFPwjREJJi/oa7WWRtsbHnxfVeLsJBj2QhR4CRwBkK/Fo0bBIugNGZ?=
 =?us-ascii?Q?HwCL13RMLZ14tmdz+EhXZr33/41PH8T7ruCo1gYoXHu0lzvpl16/MqOJPgV9?=
 =?us-ascii?Q?ewVPXQJPPGWYL2wu28aHDoXzeu8ueuC0GlC13Z6uTkbBHvG9TU1TVo1SWfc4?=
 =?us-ascii?Q?9xXqOnAix4oFbz1bIIMTCXd43HTmK3I2s9X1yUiKezJhZmOLDIM3xYNfGbB7?=
 =?us-ascii?Q?dP5+1nrfTLd4Ex/h+FnEkdo5o7+Y8vwtX0m0fdANHjbN2JYQ3IM3FuZF0z3p?=
 =?us-ascii?Q?f5BtZI05RmrpJGgWEpUTDTtmi7JL98ZtX2VgTtHxoyDKtDOUK0LuhWw79/T3?=
 =?us-ascii?Q?ksK3JaLbPEEzUfs5nwLq+fGuJBeHIyxJf2Jry36SH8saDTeZv5CG1RpXL/rh?=
 =?us-ascii?Q?k2ZWbiEOl3fgEtV9yRukjVhLDpqHkZ1gwnrfkKomJXKxIb+N/7edIC1tL4MV?=
 =?us-ascii?Q?AxvyrIZ3RRHRMuAwJEeVTuMxmAHx9ZXn0iwU6hJ0x6IW8T/wzQVlj6Zlfa7b?=
 =?us-ascii?Q?z7iT+e19C2dCmU+YdexByVeUCUx46+lw?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 12:17:55.6847 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba792e2e-050b-4032-42cc-08dd0edd8625
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000B622.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P195MB2341
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

Enable raw & on disk capsule updates and provide configs required
for updating MTD devices. Also resync after savedefconfig.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 configs/phycore_am62x_a53_defconfig | 10 ++++++++++
 configs/phycore_am64x_a53_defconfig |  8 ++++++++
 2 files changed, 18 insertions(+)

diff --git a/configs/phycore_am62x_a53_defconfig b/configs/phycore_am62x_a53_defconfig
index 43b0dac5efd..551fd4415c6 100644
--- a/configs/phycore_am62x_a53_defconfig
+++ b/configs/phycore_am62x_a53_defconfig
@@ -36,6 +36,9 @@ CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
 # CONFIG_PSCI_RESET is not set
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_EFI_SET_TIME=y
+CONFIG_EFI_CAPSULE_ON_DISK=y
+CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
 CONFIG_BOOTSTD_FULL=y
@@ -61,12 +64,16 @@ CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x280000
 CONFIG_SPL_YMODEM_SUPPORT=y
+# CONFIG_CMD_BOOTEFI_HELLO is not set
+CONFIG_CMD_BOOTEFI_SELFTEST=y
+CONFIG_CMD_NVEDIT_EFI=y
 CONFIG_CMD_DFU=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_MTD=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_CACHE=y
+CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_RTC=y
 CONFIG_CMD_SMC=y
 CONFIG_OF_CONTROL=y
@@ -91,6 +98,7 @@ CONFIG_CLK=y
 CONFIG_SPL_CLK=y
 CONFIG_CLK_TI_SCI=y
 CONFIG_DFU_MMC=y
+CONFIG_DFU_MTD=y
 CONFIG_DFU_RAM=y
 CONFIG_SYS_DFU_DATA_BUF_SIZE=0x40000
 CONFIG_SYS_DFU_MAX_FILE_SIZE=0x800000
@@ -107,6 +115,7 @@ CONFIG_MMC_SDHCI_ADMA=y
 CONFIG_SPL_MMC_SDHCI_ADMA=y
 CONFIG_MMC_SDHCI_AM654=y
 CONFIG_MTD=y
+CONFIG_DM_MTD=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 # CONFIG_SPI_FLASH_SMART_HWCAPS is not set
@@ -157,3 +166,4 @@ CONFIG_USB_GADGET_PRODUCT_NUM=0x6165
 CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_SPL_DFU=y
 CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
+# CONFIG_HEXDUMP is not set
diff --git a/configs/phycore_am64x_a53_defconfig b/configs/phycore_am64x_a53_defconfig
index ac9731d9674..bc450004722 100644
--- a/configs/phycore_am64x_a53_defconfig
+++ b/configs/phycore_am64x_a53_defconfig
@@ -35,6 +35,8 @@ CONFIG_SPL_LIBDISK_SUPPORT=y
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_EFI_CAPSULE_ON_DISK=y
+CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
 CONFIG_BOOTSTD_FULL=y
@@ -65,7 +67,10 @@ CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x280000
 CONFIG_SPL_YMODEM_SUPPORT=y
+# CONFIG_CMD_BOOTEFI_HELLO is not set
+CONFIG_CMD_BOOTEFI_SELFTEST=y
 CONFIG_CMD_ASKENV=y
+CONFIG_CMD_NVEDIT_EFI=y
 CONFIG_CMD_DFU=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
@@ -73,6 +78,7 @@ CONFIG_CMD_MMC=y
 CONFIG_CMD_MTD=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_CACHE=y
+CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_RTC=y
 CONFIG_CMD_TIME=y
 CONFIG_CMD_SMC=y
@@ -98,6 +104,7 @@ CONFIG_SPL_CLK_CCF=y
 CONFIG_CLK_CCF=y
 CONFIG_CLK_TI_SCI=y
 CONFIG_DFU_MMC=y
+CONFIG_DFU_MTD=y
 CONFIG_DFU_RAM=y
 CONFIG_DFU_SF=y
 CONFIG_SYS_DFU_DATA_BUF_SIZE=0x40000
@@ -121,6 +128,7 @@ CONFIG_MMC_SDHCI_ADMA=y
 CONFIG_SPL_MMC_SDHCI_ADMA=y
 CONFIG_MMC_SDHCI_AM654=y
 CONFIG_MTD=y
+CONFIG_DM_MTD=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 # CONFIG_SPI_FLASH_SMART_HWCAPS is not set
-- 
2.34.1

