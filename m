Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 336A2D767E9
	for <u-boot@archiver.kernel.org>; Thu, 31 Oct 2024 17:13:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9AAE892AA;
	Thu, 31 Oct 2024 18:13:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=phytec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytec.com header.i=@phytec.com header.b="e55AftM7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA86F88B8F; Thu, 31 Oct 2024 17:21:34 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20720.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::720])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4D72889EF
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 17:21:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=phytec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ggiordano@phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pwVpqaDH7nJSwBLNzNmew8ovSHWseWs5S0lEYW0lsfkv24PhOUhYY+ZGx+L5oE5p92T1e9mn9FIoY0OjNZ73T/qsHRiCyHvfN3pYzHesqgMKVI9x4HDpXi+4Qt0/0OvlBPZg/gRucOLFGKi4Ej3OPKdQrn6So9wcNKY9ZLrc74qsy+Bl3LaT0EOygVjTQbBFxDsNrEqyZJ+MbmFdG55Aw/KnJ/RHktb7N5OYOWFBximMWubB4ugov0NYNSqPq5kBpqCpdKNCIbHdNQw883zr9FjuYDVvCutVWNWIsWPmULGrlZ0v0vB7/DUm/usdM00CrABsYDoXaN9XG6dLe7UuKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1SRXaNmhPKyYqz8vO8964AaMs1GUlA2GDQU8J55Mn0o=;
 b=oiAPw8tarULzLb64pqT93eu4XHKCWX64cH5u3Ce7QMmLj5kM8r3jqcjf5luX5/Z8lncynX6GBqKdLK4oiGMRvr00+lNXUB5ou0yv3YjMLfkVNJebt4mFMYCJsEZtoWjHQuF3vwoHEF6ZfoU3OIX2tnDYD1fyhuolMQ5WYTV3IAMxB6aLHhZjnLBWa6qFbGH5YnWZmITfCYSuc4k7XOKxM9VH+/T716u5XnTUBpM6KOrZZfcao4ElzG87pQMgfjvf5UuqRvNnCcHb5EsL6YCafO5ONX5+DKGcG/3D5aIN1t+qFmxA+yIlBVjgo3mVfYD0Ba9p5x0VkBGdh3WS8yWcSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1SRXaNmhPKyYqz8vO8964AaMs1GUlA2GDQU8J55Mn0o=;
 b=e55AftM7UeJ4CfWnkoGVVHTOMqHgHOecBELLIdoYNYqcymT+Me3REJrKm9cKpuFKy9VT2NYggZoHf6dWvjSnIg0GWe3cOpTKTdPIqFj7ICBMeppv3ET1S6Zw9dltYNq9mcWmYmVTF9j/c2h5ufuVibfKHIgL1Zrd+Pg1Gm8LZ3E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from SJ2PR22MB4354.namprd22.prod.outlook.com (2603:10b6:a03:537::8)
 by PH0PR22MB2955.namprd22.prod.outlook.com (2603:10b6:510:ff::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 31 Oct
 2024 16:21:27 +0000
Received: from SJ2PR22MB4354.namprd22.prod.outlook.com
 ([fe80::789c:e41e:1367:383d]) by SJ2PR22MB4354.namprd22.prod.outlook.com
 ([fe80::789c:e41e:1367:383d%5]) with mapi id 15.20.8093.027; Thu, 31 Oct 2024
 16:21:27 +0000
From: Garrett Giordano <ggiordano@phytec.com>
To: trini@konsulko.com, afd@ti.com, bb@ti.com, w.egorov@phytec.de,
 vaishnav.a@ti.com, hnagalla@ti.com, j-choudhary@ti.com, a-nandan@ti.com,
 nm@ti.com, sjg@chromium.org, a-bhatia1@ti.com
Cc: u-boot@lists.denx.de,
	upstream@lists.phytec.de
Subject: [PATCH v2] arm: mach-k3: am62a7: Provide a way to obtain boot device
 for non SPLs
Date: Thu, 31 Oct 2024 09:21:03 -0700
Message-Id: <20241031162103.2835289-1-ggiordano@phytec.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN1PR12CA0005.namprd12.prod.outlook.com
 (2603:10b6:408:e1::10) To SJ2PR22MB4354.namprd22.prod.outlook.com
 (2603:10b6:a03:537::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR22MB4354:EE_|PH0PR22MB2955:EE_
X-MS-Office365-Filtering-Correlation-Id: 0008c6f1-e2e0-4b49-2403-08dcf9c811c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|52116014|376014|366016|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?S4hZ725vYOwcRgh6Bq6OA4kshi6RJw04XfdWqbCbArD2yNnyR6thR0CDb5VT?=
 =?us-ascii?Q?IuRR0E81XF/mZM7NQxvH2KDUuSxXFChi6BFB5s52oXNQrzbFcF6VnLfWAxQD?=
 =?us-ascii?Q?eKEPrTdFu6TQHgMzPtchRW3/3vDlTxv8KGMwAoZ8F5ZdThRRnpLx3luCK5HU?=
 =?us-ascii?Q?cCbkYIdO4+TnuUINRWUUF1bRs+tFWa7uzR4lAolXCAA0diQCRPZhVCW+j10a?=
 =?us-ascii?Q?WQAwUcyw7w4yqLIkS4xwnKZyYnqr2amlq7u1DXY87UWc7ZdTeAIPleoB237l?=
 =?us-ascii?Q?+il1JxyL3sFUlLRq6WwjWTRqu6qkcF64vr4KuR8n5ghF9gZg6xnOwlLALZTT?=
 =?us-ascii?Q?ZufhXy0sxjfLG8ZMgwc37pJmccnnS/7bMagItan8LQ8IWNkYNq+WD51BRdks?=
 =?us-ascii?Q?VI1RFnZt4h+xR2nIz4xVGUPYjTPx3mQ6i8zOJAZq6Ybcrv7lE/gGR/DSv6NE?=
 =?us-ascii?Q?wCfKpPDpirhZ6UYrDXHDpd6M87xwHXi7NHeMNwmw7QjYSxwEs/OWUnOkujtf?=
 =?us-ascii?Q?jjC1aeZ2kE8ZD/WWcKmDDiNP2fP00xQwOOawvC2v0h5o67qwyG2SMxMRKJgG?=
 =?us-ascii?Q?kSugo1hWH9pU0vd3mGQIgtHBe2Ug2onDIXU0xSZheQRhuCwNFKC0TWDiQOIk?=
 =?us-ascii?Q?w+V/lwGPfg9C1tsdOHZkKvhw9cP5g9IVUUVqMurVFSFokAG0Tpr4gaZiiMYK?=
 =?us-ascii?Q?ri1zMktlj1YCsQPKaWiJH2arpVVkXvPMrPMhzf3MwxpdYPTY+Muuw7pd3Mbo?=
 =?us-ascii?Q?iV4FLkzrSzDLyJAlOnNH1843fcUILgOdHMnRFBC2KYWHUSvEtf1gI25SNegz?=
 =?us-ascii?Q?bH0zWznFDrqzFrX5LqW0tKLQFATSng6kZxOzIQhkAP8e5Gcj8gmOWzO54sdM?=
 =?us-ascii?Q?1E69tyAm2fhgx2YMkIXHPacwnJ8X+uT80on8f/uObcQ44uJQ1m4EeE8tAz0q?=
 =?us-ascii?Q?wHCjqBAsrSXsgb8KsDjY56wbK25z1ZFIjLGbd6Gf6eyHFQPNfIgTdAgxzq7k?=
 =?us-ascii?Q?0yHViX3exz6cMow0L7sTpr9/R1kgE+xdJYbc9Zns+lOA6SqxatLaWne5iu+B?=
 =?us-ascii?Q?jDdcpnBIUCrWu11oFMRMFU2jmwuBpm8MiKk4E17krpro4qcDMIqvUYsxZYqT?=
 =?us-ascii?Q?MKfUfcyMXD2csSPI0lx9sFvxbzA7ValU//w/e0WwdvlhQUcSJMlC4jlsd+W9?=
 =?us-ascii?Q?/O/WEO2L40zMigTArdsNqoq6a9HOqELd6eN0yOBFDSPUokX4qRaqvIWAWbQB?=
 =?us-ascii?Q?Ugs974Xwaf5AkxVs7jUq+usTubNlb63IlJdWXjBQ/Vxu8NuySnsvOyI39PsI?=
 =?us-ascii?Q?npY6s+SIsgvaIfIPnRLNoA50XSq6ZQrEmamH6hf7qzXtx8GTLbBRUDOuREXI?=
 =?us-ascii?Q?PoL86i72ZfwFq0xAtlbDAGXJMlh7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR22MB4354.namprd22.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UXPQQT+t7byCoIAKQu2sLplYOHeRFAtd6zqy3qBr7hwSCED9hQeixHZjYLt8?=
 =?us-ascii?Q?ByNSLluxsQUuuWWpbTRK678wcEmHgIyEYcMYyhxi9J/BerXbyx3LR+5NIB7X?=
 =?us-ascii?Q?xzLFqEmq5BEiNqwdEvMWr15t5iZxj1FUXq3+qe3rBXzkXrkyEnkOr1NS7Hda?=
 =?us-ascii?Q?9w4mMl+uSwHpv2sNNat1NqfefYeiR3EIFYZyKTIrQIxucxL0apmHzqpPhHUP?=
 =?us-ascii?Q?j1efkcccm9+WCbfi056r4PnCW8oHA62BVJkcZERfoS3pcIkE2wsT7bsGDbr8?=
 =?us-ascii?Q?NPJrwTMdjlRC8WDNs+VsQldXEnyvwTihNLAYGZ4XYz8LAOjtj6VAZUZ2VSmt?=
 =?us-ascii?Q?WERCJ0f8M8WTndmpVXpbsSN3SnEyi5417lJ3gqmRGzPSSEyaXQiRrEixUnz6?=
 =?us-ascii?Q?80TXHDN+iZauciIxJbJK1uyjl1Fn+SKkGzfOUHzpYfNb1X5w3Hr/Bgep886v?=
 =?us-ascii?Q?/OFOvbISigLd5op9Bd83HizeLTn1PpFli1df1ROgAsNpl9GLly73nv+S/oaC?=
 =?us-ascii?Q?i91MbxZ+8wkWF0gSrWKx9NmCkSqn2wFQGnLDGAiSTCCRjcGG0iagM+pxHT0/?=
 =?us-ascii?Q?CHmFc2W6qkCqx0cd+RXqYayegF0fLJfbv2cbrh50xyV9feFobcWG1OcG8yr1?=
 =?us-ascii?Q?bDgcI1XQlPZBfBKdSdjid+roi5YwEGNJYtjNp+ImqcCjZDQ60Ag7MMkQHje+?=
 =?us-ascii?Q?dS0mfgiIqbkjhXSPay/3SqUTHQB8dHcSieuKfmr6cCsD8zVAy/Rc1IQ2/8Ze?=
 =?us-ascii?Q?Y9ELr++tApyeH/PMKbCwmqmY7sB5bOfs//RINqnoAsJbh+0YcSDBe0/F/9mk?=
 =?us-ascii?Q?2WfcLd/4i+dlpQJBrqvf+lBIT1yj/j6IrTmeYS0T6aThytpFj3IWn6zFX/a8?=
 =?us-ascii?Q?3YXe4ZkSdUBDOD37CvxhwnrYNVmf1BBhg/ykVPG99bjHi8QDqI9+hUniGS0Q?=
 =?us-ascii?Q?4dWiV0UZgrfn27OHJj4UGbPrHOMbbFctQoosH0NgTMaPb829qkEPeU18x68s?=
 =?us-ascii?Q?60IQ/UOYyzucb9qwAiXRbsTIbFUqxKWhORPRdPfgkhWP3ItElGtk2o4d1rEv?=
 =?us-ascii?Q?5C41ASHcrfI9GkzoP0gQTK2lPe8Xl6m8ribEaTMuZSKVUib1lSxzFecaJYmE?=
 =?us-ascii?Q?5wYkDcbPHLj5uinouiapkgzOq7P6bKfN47iTGG3w2OPHQ76jpmAf+GW5BNU5?=
 =?us-ascii?Q?n2H4qDjtzuVDD0ynQ20CiBynLu24rTENyHSk1NSxAoF4xFIB/vv3ysrKPtBl?=
 =?us-ascii?Q?8yAUmheqVR+AIjCdpaXTt5dIOSVXv2WYgqQAU8t8GjiMMyffOM9r72/rfs9Y?=
 =?us-ascii?Q?Gtg543dD6ojARJCHxFI2UpKv+6Gpxe5o0QMP+rdHFUxuHu84CVC6Yogl2jZk?=
 =?us-ascii?Q?bv5QE8jDo/3KmY2qR/FrO5Fe1XavDVezyEz603bGB7MncA/uY1F+KMyH9S7b?=
 =?us-ascii?Q?5opR2RUhZiwc+1Bziw0RL83mR0g3/Q6vqysESrhChjjtQ1XTXijSotFjTK6K?=
 =?us-ascii?Q?tpZEA6RvcES4l/gnJ8oAQVx3JYFawYHuMn6/zYDNjTecv0SYcg3LZlELqEgS?=
 =?us-ascii?Q?laWQd6r/29Bl6IOU1TskUeSY1BbdG6ND+Li2eA1I?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0008c6f1-e2e0-4b49-2403-08dcf9c811c7
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR22MB4354.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 16:21:26.9203 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bGR/3ow18fhtpsIy0hd36z5BnyG7GerLHqoygSnR3gex93xvyerBfQM3vSh43/8lG8rHslIv1mhM7Ezg91grPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR22MB2955
X-Mailman-Approved-At: Thu, 31 Oct 2024 18:13:37 +0100
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

Introduce get_boot_device() to obtain the booting device. Make it also
available for non SPL builds so u-boot can also know the device it
is booting from.

Signed-off-by: Garrett Giordano <ggiordano@phytec.com>
Reviewed-by: Bryan Brattlof <bb@ti.com>
---
 v2:
   - Drop duplicate CONFIG_SOC_K3_AM62A7 entry from arch/arm/mach-k3/Makefile

 arch/arm/mach-k3/am62ax/Makefile      |   1 +
 arch/arm/mach-k3/am62ax/am62a7_init.c |  97 +----------------------
 arch/arm/mach-k3/am62ax/boot.c        | 106 ++++++++++++++++++++++++++
 3 files changed, 108 insertions(+), 96 deletions(-)
 create mode 100644 arch/arm/mach-k3/am62ax/boot.c

diff --git a/arch/arm/mach-k3/am62ax/Makefile b/arch/arm/mach-k3/am62ax/Makefile
index e2ef88196f8..4e35e0c844d 100644
--- a/arch/arm/mach-k3/am62ax/Makefile
+++ b/arch/arm/mach-k3/am62ax/Makefile
@@ -5,3 +5,4 @@

 obj-$(CONFIG_OF_SYSTEM_SETUP) += am62a7_fdt.o
 obj-$(CONFIG_XPL_BUILD) += am62a7_init.o
+obj-y += boot.o
diff --git a/arch/arm/mach-k3/am62ax/am62a7_init.c b/arch/arm/mach-k3/am62ax/am62a7_init.c
index 0f62f39075b..5c0d3ee6869 100644
--- a/arch/arm/mach-k3/am62ax/am62a7_init.c
+++ b/arch/arm/mach-k3/am62ax/am62a7_init.c
@@ -171,102 +171,7 @@ void board_init_f(ulong dummy)
 	debug("am62a_init: %s done\n", __func__);
 }

-static u32 __get_backup_bootmedia(u32 devstat)
-{
-	u32 bkup_bootmode = (devstat & MAIN_DEVSTAT_BACKUP_BOOTMODE_MASK) >>
-				MAIN_DEVSTAT_BACKUP_BOOTMODE_SHIFT;
-	u32 bkup_bootmode_cfg =
-			(devstat & MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_MASK) >>
-				MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_SHIFT;
-
-	switch (bkup_bootmode) {
-	case BACKUP_BOOT_DEVICE_UART:
-		return BOOT_DEVICE_UART;
-
-	case BACKUP_BOOT_DEVICE_USB:
-		return BOOT_DEVICE_USB;
-
-	case BACKUP_BOOT_DEVICE_ETHERNET:
-		return BOOT_DEVICE_ETHERNET;
-
-	case BACKUP_BOOT_DEVICE_MMC:
-		if (bkup_bootmode_cfg)
-			return BOOT_DEVICE_MMC2;
-		return BOOT_DEVICE_MMC1;
-
-	case BACKUP_BOOT_DEVICE_SPI:
-		return BOOT_DEVICE_SPI;
-
-	case BACKUP_BOOT_DEVICE_I2C:
-		return BOOT_DEVICE_I2C;
-
-	case BACKUP_BOOT_DEVICE_DFU:
-		if (bkup_bootmode_cfg & MAIN_DEVSTAT_BACKUP_USB_MODE_MASK)
-			return BOOT_DEVICE_USB;
-		return BOOT_DEVICE_DFU;
-	};
-
-	return BOOT_DEVICE_RAM;
-}
-
-static u32 __get_primary_bootmedia(u32 devstat)
-{
-	u32 bootmode = (devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_MASK) >>
-				MAIN_DEVSTAT_PRIMARY_BOOTMODE_SHIFT;
-	u32 bootmode_cfg = (devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_MASK) >>
-				MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_SHIFT;
-
-	switch (bootmode) {
-	case BOOT_DEVICE_OSPI:
-		fallthrough;
-	case BOOT_DEVICE_QSPI:
-		fallthrough;
-	case BOOT_DEVICE_XSPI:
-		fallthrough;
-	case BOOT_DEVICE_SPI:
-		return BOOT_DEVICE_SPI;
-
-	case BOOT_DEVICE_ETHERNET_RGMII:
-		fallthrough;
-	case BOOT_DEVICE_ETHERNET_RMII:
-		return BOOT_DEVICE_ETHERNET;
-
-	case BOOT_DEVICE_EMMC:
-		return BOOT_DEVICE_MMC1;
-
-	case BOOT_DEVICE_SPI_NAND:
-		return BOOT_DEVICE_SPINAND;
-
-	case BOOT_DEVICE_MMC:
-		if ((bootmode_cfg & MAIN_DEVSTAT_PRIMARY_MMC_PORT_MASK) >>
-				MAIN_DEVSTAT_PRIMARY_MMC_PORT_SHIFT)
-			return BOOT_DEVICE_MMC2;
-		return BOOT_DEVICE_MMC1;
-
-	case BOOT_DEVICE_DFU:
-		if ((bootmode_cfg & MAIN_DEVSTAT_PRIMARY_USB_MODE_MASK) >>
-		    MAIN_DEVSTAT_PRIMARY_USB_MODE_SHIFT)
-			return BOOT_DEVICE_USB;
-		return BOOT_DEVICE_DFU;
-
-	case BOOT_DEVICE_NOBOOT:
-		return BOOT_DEVICE_RAM;
-	}
-
-	return bootmode;
-}
-
 u32 spl_boot_device(void)
 {
-	u32 devstat = readl(CTRLMMR_MAIN_DEVSTAT);
-	u32 bootmedia;
-
-	if (bootindex == K3_PRIMARY_BOOTMODE)
-		bootmedia = __get_primary_bootmedia(devstat);
-	else
-		bootmedia = __get_backup_bootmedia(devstat);
-
-	debug("am62a_init: %s: devstat = 0x%x bootmedia = 0x%x bootindex = %d\n",
-	       __func__, devstat, bootmedia, bootindex);
-	return bootmedia;
+	return get_boot_device();
 }
diff --git a/arch/arm/mach-k3/am62ax/boot.c b/arch/arm/mach-k3/am62ax/boot.c
new file mode 100644
index 00000000000..af7fce1e5e9
--- /dev/null
+++ b/arch/arm/mach-k3/am62ax/boot.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0+
+#include <asm/io.h>
+#include <asm/arch/hardware.h>
+#include <asm/arch/am62a_spl.h>
+
+static u32 __get_backup_bootmedia(u32 devstat)
+{
+	u32 bkup_bootmode = (devstat & MAIN_DEVSTAT_BACKUP_BOOTMODE_MASK) >>
+				MAIN_DEVSTAT_BACKUP_BOOTMODE_SHIFT;
+	u32 bkup_bootmode_cfg =
+			(devstat & MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_MASK) >>
+				MAIN_DEVSTAT_BACKUP_BOOTMODE_CFG_SHIFT;
+
+	switch (bkup_bootmode) {
+	case BACKUP_BOOT_DEVICE_UART:
+		return BOOT_DEVICE_UART;
+
+	case BACKUP_BOOT_DEVICE_USB:
+		return BOOT_DEVICE_USB;
+
+	case BACKUP_BOOT_DEVICE_ETHERNET:
+		return BOOT_DEVICE_ETHERNET;
+
+	case BACKUP_BOOT_DEVICE_MMC:
+		if (bkup_bootmode_cfg)
+			return BOOT_DEVICE_MMC2;
+		return BOOT_DEVICE_MMC1;
+
+	case BACKUP_BOOT_DEVICE_SPI:
+		return BOOT_DEVICE_SPI;
+
+	case BACKUP_BOOT_DEVICE_I2C:
+		return BOOT_DEVICE_I2C;
+
+	case BACKUP_BOOT_DEVICE_DFU:
+		if (bkup_bootmode_cfg & MAIN_DEVSTAT_BACKUP_USB_MODE_MASK)
+			return BOOT_DEVICE_USB;
+		return BOOT_DEVICE_DFU;
+	};
+
+	return BOOT_DEVICE_RAM;
+}
+
+static u32 __get_primary_bootmedia(u32 devstat)
+{
+	u32 bootmode = (devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_MASK) >>
+				MAIN_DEVSTAT_PRIMARY_BOOTMODE_SHIFT;
+	u32 bootmode_cfg = (devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_MASK) >>
+				MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_SHIFT;
+
+	switch (bootmode) {
+	case BOOT_DEVICE_OSPI:
+		fallthrough;
+	case BOOT_DEVICE_QSPI:
+		fallthrough;
+	case BOOT_DEVICE_XSPI:
+		fallthrough;
+	case BOOT_DEVICE_SPI:
+		return BOOT_DEVICE_SPI;
+
+	case BOOT_DEVICE_ETHERNET_RGMII:
+		fallthrough;
+	case BOOT_DEVICE_ETHERNET_RMII:
+		return BOOT_DEVICE_ETHERNET;
+
+	case BOOT_DEVICE_EMMC:
+		return BOOT_DEVICE_MMC1;
+
+	case BOOT_DEVICE_SPI_NAND:
+		return BOOT_DEVICE_SPINAND;
+
+	case BOOT_DEVICE_MMC:
+		if ((bootmode_cfg & MAIN_DEVSTAT_PRIMARY_MMC_PORT_MASK) >>
+				MAIN_DEVSTAT_PRIMARY_MMC_PORT_SHIFT)
+			return BOOT_DEVICE_MMC2;
+		return BOOT_DEVICE_MMC1;
+
+	case BOOT_DEVICE_DFU:
+		if ((bootmode_cfg & MAIN_DEVSTAT_PRIMARY_USB_MODE_MASK) >>
+		    MAIN_DEVSTAT_PRIMARY_USB_MODE_SHIFT)
+			return BOOT_DEVICE_USB;
+		return BOOT_DEVICE_DFU;
+
+	case BOOT_DEVICE_NOBOOT:
+		return BOOT_DEVICE_RAM;
+	}
+
+	return bootmode;
+}
+
+u32 get_boot_device(void)
+{
+	u32 devstat = readl(CTRLMMR_MAIN_DEVSTAT);
+	u32 bootmode = *(u32 *)(K3_BOOT_PARAM_TABLE_INDEX_OCRAM);
+	u32 bootmedia;
+
+	if (bootmode == K3_PRIMARY_BOOTMODE)
+		bootmedia = __get_primary_bootmedia(devstat);
+	else
+		bootmedia = __get_backup_bootmedia(devstat);
+
+	debug("%s: devstat = 0x%x bootmedia = 0x%x bootmode = %d\n",
+	      __func__, devstat, bootmedia, bootmode);
+
+	return bootmedia;
+}
--
2.25.1

