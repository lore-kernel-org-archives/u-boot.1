Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2283D39404
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 09:30:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF2DD840ED;
	Thu,  2 Apr 2026 11:29:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="fqq7E0WU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27EC1840CB; Thu,  2 Apr 2026 11:29:46 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2D2284175
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 11:29:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=simona.toaca@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ljkUvQpOK+FrjmD6+97jQkGdPxBnXseTHyEJwm15v+s328jIEJtPzCwd37Y03suixPmq4M9OfF03AWU/I0f6sJ8TWN/FdDjza+mYtjp/2nfmrpMwNvamDatRJaCw1stVSTt42dhWgVoJPBHGhnR4ctX768KioQy0qFQGjCaOdvF3mj1VCDDsl7mXaa8RYNrhsAurRzTEDEnWhoSWpEexn4AepnhtXUMuMVfeY7Kk8Iyj3O1sWQTwgZ7LWLkJdzyoLQVuqkr6O9wthzHbTzvAR2GGy1rReGFMGTDnwg2SmOuQDjmkeDZ8k0FTU4ukkrCdL9nIO5llzzCpd65IHKpCsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DueOb0fSDPa/hv1/oj9GYYlM9G+Mv8wSOZeIo+Iq3D8=;
 b=IcEmLCSyZklqi5Jyg5kR4kDW0RXNqw+xNIJ3WfIXspLsJdatu7dkYd7aLghYOe/M7ZuCzMBMrtXoIngHDlvmwomerRxIun9WwYLwMkcOj5KEGNQ2hFb0ftLsw1R5FyIEXJdUxGySwTgTm5GIKmn29UKlHqcohvXOLjajFmvqy7cT7cHVZSSJK0GbSogfmSVSq1Bk0lJKRWzT2XmiMN6Na0kA2YQnyHsK1fyJkQnQkPdFzxk1y8WajbI/ScqWF4carQEifiDtS83SGRVFQFMmfpeN7GsZujyy5p5nz0Znv5v/qDvRap0IQMSRdHTVdxByX/APurCTlrVnWQQI3vW7lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DueOb0fSDPa/hv1/oj9GYYlM9G+Mv8wSOZeIo+Iq3D8=;
 b=fqq7E0WU2viDgcHzqXqRjmyMUVg06OWMl6IKgO8/GK3FtpexoVuwk0Wp2/T8JjeC3j7q0xhmUcjwxvwGuWvJ8BkHliMwmRBrX/5dkJ5YHqEqqyDvdB8VH08CeRpnBQg6+7GTZ0xpLcGEEo+C7sF76XrBIdvntXHGHu+wBr05RkWA5HsESNl9tpxjnpBPnqxukgkQjVnRg6QXby8fX9d4MMHeQ9m+Kt9RSsMqtOUBge4KQKmY3BAKbgH8tr7MwP1/UCwiZEP/ipUAlCzGiDjhf6W5pNQ27rhxv0wxi5r4J8ZpK+kSKTZaLA9ISOKQ0OiaRKjinFUjIxrKr9uX2qTH1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI0PR04MB11917.eurprd04.prod.outlook.com (2603:10a6:800:306::9)
 by AM7PR04MB7095.eurprd04.prod.outlook.com (2603:10a6:20b:11c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Thu, 2 Apr
 2026 09:29:34 +0000
Received: from VI0PR04MB11917.eurprd04.prod.outlook.com
 ([fe80::a506:3460:d2bc:26e7]) by VI0PR04MB11917.eurprd04.prod.outlook.com
 ([fe80::a506:3460:d2bc:26e7%4]) with mapi id 15.20.9769.016; Thu, 2 Apr 2026
 09:29:34 +0000
From: "Simona Toaca (OSS)" <simona.toaca@oss.nxp.com>
To: uboot-imx@nxp.com,
	u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, festevam@gmail.com, peng.fan@nxp.com,
 alice.guo@nxp.com, viorel.suman@nxp.com, simona.toaca@nxp.com,
 ye.li@nxp.com, ping.bai@nxp.com, marex@nabladev.com,
 sebastien.szymanski@armadeus.com, ravi@prevas.dk,
 joao.goncalves@toradex.com, ji.luo@nxp.com, semen.protsenko@linaro.org,
 tharvey@gateworks.com, qijian.guo@nxp.com
Subject: [PATCH v3 4/6] board: nxp: imx9{4, 5,
 52}_evk: Add qb save option in SPL
Date: Thu,  2 Apr 2026 12:40:46 +0300
Message-ID: <a67c5f278a0824723d448fcf230dde2f93c6dda8.1775121078.git.simona.toaca@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1775121078.git.simona.toaca@nxp.com>
References: <cover.1775121078.git.simona.toaca@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::6) To VI0PR04MB11917.eurprd04.prod.outlook.com
 (2603:10a6:800:306::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB11917:EE_|AM7PR04MB7095:EE_
X-MS-Office365-Filtering-Correlation-Id: 3841bcfe-a915-4473-5dc3-08de909a5a27
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: HnoU0WGT44WwID+FxPgm55K/r4X0C9ULF5nN3A/+dN50vZjpIgp6vJxhBzjuI4RSqfauKdlJKSlFautTqmmwsg6t0f2SINXr2pfDc1MGOCy/nEJ2EVfM1YLpT02aga1iZgWRNAAUTJzs6ICL2ILnMM9wFgrA4TwVhaOcsjh86lmwOUxjgNtvCALDsQBT7xzuJUKfKr+rS4ERkBQbZ43tF4Vmd4lckHdkZllHwuerhUlXM0aKeTof2dYN1VVGsvtx38FZ/NLAevWcSaT+4Rtht3WQbVJr38gopf57fR//b4HROHWtV/mvabFrHcclrBiC5sqj1jVeJEmJ0Eg+vh0S+duLcsKhnUswcT20GcpufVORZfFWmqFNor3mbrQQBPEKGUNGA3B6NrcGPFGBLJFY/8fZrwJxlXxyeF4ftwP4w9B+DuN1dPwHQTmqonFUcR90TtkaDhsAzcS+HcNleb3B4jXCiANT3K7/4BgeBKpqAktzpQzq/7Sbbtc2+5kfZ7GpgXid5JdukoR4GHx02haM5rzgWoM0mTOxDXdJFqqlt3WmuPI2QK34Yf/3CJJSbCQaHGw1O+FP7K2mO4/lgK4I+hxbC6t5i5F4QVmsPEhZOd4aDigO9DQGFW/YkGavdYiw+7AqHAH6AtOUjpPOUP6EYhjuU+I/dx8esMF8eM2DEMGY2XobpNu52HJRyns7IBzgqc7ADDfotGnzsowI0HwRmfk9lN53ku1aUsHyNqJnqJM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR04MB11917.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(376014)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HLUvINC5slHvufUhom+IEb3gdw6E5p+F2eCVvpSn7kNnQDEOnD7dbj2ZBI3j?=
 =?us-ascii?Q?xb+Xxh/xx9Xf3POgGfnXu3hwtijC15ecq6DxSuN9Adose10rreXsMczKCBuF?=
 =?us-ascii?Q?D+7xFu5ynAmy2hczqVIlr8xRYBkT43/GXqSpDnk4bOkrMM2Y/P+oOhggFAU8?=
 =?us-ascii?Q?/VRL+7h2mB5zkN/rfHQJQNxJtzZNf+QviURk4Mme3xKQlUKLXcnPb4m7TurK?=
 =?us-ascii?Q?SRm5bpibMqL0uV22vPPZaWmWYQBrnlv/Y0mC0RtMeechz7ZZvYkENOPhx3CA?=
 =?us-ascii?Q?FZFWBZnFL+2lCVfHfBWWziR7r/jD0vHrnBmv6IfFb936YRJFJ6m4vHqp5JkX?=
 =?us-ascii?Q?8rUCMNuPEC0vWV14hxfk1Wa20GbtzKmI4aD1wdNyAKUmncjGs63JRQQG02HW?=
 =?us-ascii?Q?Qvw9DW7wZLrJIvZ90hXwdPdGuO3orhtH5ENWfSDriNSFBJj6AxaFyA9Ug3yr?=
 =?us-ascii?Q?/82eKB8U8laUkQa3sTHztr++VQ7cFGMOELyWG69U9rf9aAbPbYFpQYYTyt2q?=
 =?us-ascii?Q?5rINJNxVSrfWwU2WwB6dHCcNjuhyr89iHuCmTffeF5szqicI17VY/nKv5+V2?=
 =?us-ascii?Q?mXDVCW484RuS/hYpMlhZDfVQxJAB1sIa2n3QvypdJtIgWci3dc5Y4lLZMQC8?=
 =?us-ascii?Q?yrPA3YOPRzRhfFR4oxm8pQ/EvCLlc14GEViZ59QWIRZiuVUBmSxNY57gDRqw?=
 =?us-ascii?Q?wRuyAx9mVsalTQR/7y9FGJxPUjFeg+gSxoZ+MSi+QZ9jhndaM63wSxOiIcNC?=
 =?us-ascii?Q?BUvCnH/XY593Qx7ZiHmmTe8qKDyTpMkR9q9CeP3bgXuzxPa/1WbpFlca4nxQ?=
 =?us-ascii?Q?PO2gpJjM1/zmoj9fyTROKCU/1BC8PzbzPPweu3qaH+P4jjh+whVxxhjWZvW1?=
 =?us-ascii?Q?GzIYqlnyDwSEdRTm4p15wz3CTFMLByGn9DLg/BrGhHs5M8eCMRVKlP0bBBVQ?=
 =?us-ascii?Q?etanZg5gubd9aBQRpgE908k2qaXcl5y+4kENwJeVzy9PwhmZclurTlhNDScg?=
 =?us-ascii?Q?n/yGy2pJJu1/HGeTdMprdMI8PakEfkAmXWiJVKA3WivjWyzT5uweUgkNFBRk?=
 =?us-ascii?Q?BLhh2J1m3D9fr11kB4T1vW/0gIsIsIeo6HDJWUV0+qRDokhjZOWDaT6EXWZr?=
 =?us-ascii?Q?VES5H0K0K3I8X9MZ4zxhdEjCj/NX8DT4I0GuhGQlLbgsogpgmnoLHHSoAdpu?=
 =?us-ascii?Q?jsQuL3l7KoChZL7cHX33hT9TgMh5/C9SjmteLxXQxhuOnnh6qIcn7lYBiRz1?=
 =?us-ascii?Q?wpRXCsXmx/Y5ILdWV+4ptbQOgL79m5rD3Z7BwwZ9wupvOqc7krS7t1NCw5o4?=
 =?us-ascii?Q?6+926AQcgodGB7/AzMNoT8IjA7Wp5E6BxlLARoDOaIWJU3G5L0TJ5Y4zmkjU?=
 =?us-ascii?Q?feMP9pe9YuYWomxnhCQJRkMoloiz7I13JDh9GoKLg46C3XiBfH2XP746gi0s?=
 =?us-ascii?Q?KvvJaex5z0RPwVXgbiRFGpXGjLZZj5cJ+PPCOlwnjPAp54q/CF/CIZ3ptCVr?=
 =?us-ascii?Q?xMs6270lJof2DLMuarvCeD3bidUhaaT5Rj5BvYKY/0gzimNH2EtOc7spK2d6?=
 =?us-ascii?Q?Y4G4UbZXcHUnhk0s+cdSEVQZ1a2M02xAwVRKF1e3f45SYlu8bKH0NRts4cd+?=
 =?us-ascii?Q?zZ3RNfW1lOfQYlDAarHAJzl91zyfI93Zmb7LWMJtND414292CxuFgPnZnyXO?=
 =?us-ascii?Q?OBuOTqxJbJ4WTJh0daS/aFIvAFKH0wHpedPmA0SYOF/pRtL/jsul/THoINqx?=
 =?us-ascii?Q?JN3fvaFM8Q=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3841bcfe-a915-4473-5dc3-08de909a5a27
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB11917.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 09:29:34.7862 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CwCsaXCndFXzdiQJlw2OwMIGLtJqdNgtKPxgA2VsEDVsOmdz839TtwJ9NkG78UP7kvEb3xaM4t1LMVV/AltvBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7095
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

From: Simona Toaca <simona.toaca@nxp.com>

Call qb save automatically in the board-specific
spl_board_init(), if SPL_IMX_QB option is enabled.
This makes sure qb_save is called before any image
loading is done by the SPL. This option is also
suitable for the case where U-Boot proper is
missing (Falcon mode).

qb save refers to saving DDR training data to NVM,
so that OEI runs Quickboot flow on next reboot,
skipping full training and achieveing a lower boot
time.

Signed-off-by: Simona Toaca <simona.toaca@nxp.com>
---
 arch/arm/mach-imx/Kconfig       | 8 ++++++++
 arch/arm/mach-imx/imx9/Makefile | 4 +++-
 board/nxp/imx94_evk/spl.c       | 6 +++++-
 board/nxp/imx952_evk/spl.c      | 4 ++++
 board/nxp/imx95_evk/spl.c       | 6 +++++-
 5 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 48266cfd6e2..3fb8ebb886c 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -71,6 +71,14 @@ config CSF_SIZE
 	  Define the maximum size for Command Sequence File (CSF) binary
 	  this information is used to define the image boot data.
 
+config SPL_IMX_QB
+	bool "Run qb save during SPL"
+	depends on SPL && (IMX94 || IMX95 || IMX952)
+	help
+	  Automatically save DDR training data (Quickboot data)
+	  to current boot device when needed (when OEI runs Training
+	  flow and saves qb data to volatile memory).
+
 config CMD_IMX_QB
 	bool "Support the 'qb' command"
 	default y
diff --git a/arch/arm/mach-imx/imx9/Makefile b/arch/arm/mach-imx/imx9/Makefile
index 3e323a714c1..8b01897b928 100644
--- a/arch/arm/mach-imx/imx9/Makefile
+++ b/arch/arm/mach-imx/imx9/Makefile
@@ -14,6 +14,8 @@ ifneq ($(CONFIG_SPL_BUILD),y)
 obj-y += imx_bootaux.o
 endif
 
-ifneq ($(CONFIG_XPL_BUILD),y)
+ifeq ($(CONFIG_XPL_BUILD),y)
+obj-$(CONFIG_SPL_IMX_QB) += qb.o
+else
 obj-$(CONFIG_CMD_IMX_QB) += qb.o
 endif
diff --git a/board/nxp/imx94_evk/spl.c b/board/nxp/imx94_evk/spl.c
index 6eb0fff99f4..df583c9adf0 100644
--- a/board/nxp/imx94_evk/spl.c
+++ b/board/nxp/imx94_evk/spl.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright 2025 NXP
+ * Copyright 2025-2026 NXP
  */
 
 #include <hang.h>
@@ -14,6 +14,7 @@
 #include <asm/arch/sys_proto.h>
 #include <asm/mach-imx/boot_mode.h>
 #include <asm/mach-imx/ele_api.h>
+#include <asm/mach-imx/qb.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -44,6 +45,9 @@ void spl_board_init(void)
 	ret = ele_start_rng();
 	if (ret)
 		printf("Fail to start RNG: %d\n", ret);
+
+	if (IS_ENABLED(CONFIG_SPL_IMX_QB))
+		spl_qb_save();
 }
 
 static void xspi_nor_reset(void)
diff --git a/board/nxp/imx952_evk/spl.c b/board/nxp/imx952_evk/spl.c
index de9256dc267..d497597625f 100644
--- a/board/nxp/imx952_evk/spl.c
+++ b/board/nxp/imx952_evk/spl.c
@@ -8,6 +8,7 @@
 #include <asm/gpio.h>
 #include <asm/mach-imx/boot_mode.h>
 #include <asm/mach-imx/ele_api.h>
+#include <asm/mach-imx/qb.h>
 #include <asm/sections.h>
 #include <hang.h>
 #include <init.h>
@@ -44,6 +45,9 @@ void spl_board_init(void)
 	ret = ele_start_rng();
 	if (ret)
 		printf("Fail to start RNG: %d\n", ret);
+
+	if (IS_ENABLED(CONFIG_SPL_IMX_QB))
+		spl_qb_save();
 }
 
 static void xspi_nor_reset(void)
diff --git a/board/nxp/imx95_evk/spl.c b/board/nxp/imx95_evk/spl.c
index 761a1a4a0f6..35e4458f2b7 100644
--- a/board/nxp/imx95_evk/spl.c
+++ b/board/nxp/imx95_evk/spl.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright 2025 NXP
+ * Copyright 2025-2026 NXP
  */
 
 #include <hang.h>
@@ -13,6 +13,7 @@
 #include <asm/arch/sys_proto.h>
 #include <asm/mach-imx/boot_mode.h>
 #include <asm/mach-imx/ele_api.h>
+#include <asm/mach-imx/qb.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -41,6 +42,9 @@ void spl_board_init(void)
 	ret = ele_start_rng();
 	if (ret)
 		printf("Fail to start RNG: %d\n", ret);
+
+	if (IS_ENABLED(CONFIG_SPL_IMX_QB))
+		spl_qb_save();
 }
 
 void board_init_f(ulong dummy)
-- 
2.43.0

