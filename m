Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9009D132AA
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 10:42:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F250887FED;
	Mon,  4 Nov 2024 11:42:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="D4us6lNG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABBB98898B; Mon,  4 Nov 2024 11:42:22 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2070a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::70a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4AD387F3B
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 11:42:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=C.Stoidner@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rrpm1ZzaoQuRV1QrsM4+Qwf9AU+P7xfx3gy/vubrGwaOt2eDx40x+4qbgwLE0o+xSHflV4dBmidKeYJELFm4TM1mCfP48UfnOA8PfLX9ctU5l5SaPU4aWNtYr83i6gFk1/4TvXh2B5znJ9VLZhTCgj3fYI31XuZ1zA+PV80Aagw7nRO/B6jJfGDVZwwbNWjgbfmwADyyHtC88Ga72VF3e38/8OYn32TyttO0ympMHHwhcmHDIDfBzss7cvU9Hc7szvB99aKn1bKdCKlJaMtBBLzCqpDZQzuCUqS8VrPIBOK6nlejXQtNJTLvAzrkn+WcRE3GaiY3/TNAFBkmeZBAaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yv+MTIz4YIj/wuJFAT+bkLCHWbw6gfv2txOTmII4Ouc=;
 b=SCIyd6AjePtM2WGl2NOuNFxT2+RnQ5b7jTSyuQ38Wv2ucMUD53Q75NahMyJeMKf9fKWbAoKcmRXZMMCMIeNL7UJSOfmjeNH3ZWij2Wr8hZaMQOLrEukd95q14HJOIkf+DW7ubMkdC9qz/Et+wE0g1NNSSJVnpPzgFc9LEp6SIoiAIL09biyyskFnMZOgcGxOgH/Mj054/vGbH1DHG34Lo/zCHmHL54LzZi641MSbSLN1M+syMd+ZMkNKhs2wVz/adATT9mmzcKm86eJkC/4vAgzjwuQSy1f8VlziaeXuBFTM+6iY+WWNna2+CO7DjJVpZpNHcch0vbYAt3onHPl6gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yv+MTIz4YIj/wuJFAT+bkLCHWbw6gfv2txOTmII4Ouc=;
 b=D4us6lNGbM1BClHLkTk2zb/C4F73Rp1PAAFNy2MYgnkRFdxIqpKHbxVGyoKTAcPqCKBC2iqX7CDxQNEzl/k0vRR+HwmYFUnUVppShVYYAaiC6x6tPaCONjZ0sjOcb72vKzcUmgAYnFzcwUkTnvDFtcTXOQKsg42Umf4tFqPIa+s=
Received: from DUZPR01CA0270.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::22) by DB4P195MB2016.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:388::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Mon, 4 Nov
 2024 10:42:19 +0000
Received: from DB5PEPF00014B9E.eurprd02.prod.outlook.com
 (2603:10a6:10:4b9:cafe::df) by DUZPR01CA0270.outlook.office365.com
 (2603:10a6:10:4b9::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30 via Frontend
 Transport; Mon, 4 Nov 2024 10:42:19 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB5PEPF00014B9E.mail.protection.outlook.com (10.167.8.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Mon, 4 Nov 2024 10:42:17 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 4 Nov 2024
 11:42:16 +0100
Received: from llp-stoidner.fritz.box (172.25.39.157) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 4 Nov 2024
 11:42:16 +0100
From: Christoph Stoidner <c.stoidner@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: Christoph Stoidner <c.stoidner@phytec.de>
Subject: [PATCH 0/3] Add support for all variants of the phyCORE-i.MX93 SOM
Date: Mon, 4 Nov 2024 11:41:46 +0100
Message-ID: <20241104104148.748331-1-c.stoidner@phytec.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.39.157]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9E:EE_|DB4P195MB2016:EE_
X-MS-Office365-Filtering-Correlation-Id: e5a371d4-85f9-4669-3f6b-08dcfcbd5a3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BXexukE17Fw1LZGV3PAiGxaBjsHFUBhCutqjtjqw7thGVtNUEyMsvHEFFjxC?=
 =?us-ascii?Q?Gkwd8ef3yt7Eqv05xScz08tt2JDYHHMRm7Vf1O5qyN3ZkuFSdpuwVhj4riHQ?=
 =?us-ascii?Q?KbO4rOGFf5Mi35NP3gMPAyrCHVUcIZKtmI15yZd5BAaiqKoHiJUJgeIR9rDZ?=
 =?us-ascii?Q?Z8FfQWjLHHlFvS6XAmvzE0r70AXv7RkgTWT8ZnTHMcZ1+pgPCNjCy+XnMQBf?=
 =?us-ascii?Q?8+OPXa4Q4wtK6dPN7I5aetYiFpwr5/kieOedkb9PL860JSvux1pDSGhLDStN?=
 =?us-ascii?Q?IE2kTceZVFTagM6cTAZIYuPm1lkZNcei3VbPrsTPlJcQgB6br1TkZuRihhNL?=
 =?us-ascii?Q?gyQx6WX8ZAxaq93ItgpvY/e8dJsvQiZHRr3dmSwDMSua1fmUt52buPRJZ91Y?=
 =?us-ascii?Q?yOEHhVuC4pp6VihuiTw6AyuJ6DHgx+vAyUSZE2Z2dOE/0AUN4aQwPIWZVT2j?=
 =?us-ascii?Q?y3xVTU+3YasvjYo7I3PAQIEkBJPgT0rAa2ORtE+VDsAx4kMEf/C2VgYSj/W7?=
 =?us-ascii?Q?DYL/OzolWlW3qEt0ClfOUwCmDryFVNlEvGE+cDmxNMCgnBinyAzV1VP/tYNX?=
 =?us-ascii?Q?GOK/TrvhcDkDYhT2c4YIPoB2rnnzc7CRHXitqUbq4T01PpO7X/whSht3WKzY?=
 =?us-ascii?Q?AE6LRplF+64692FYqwsv1XIUZOB5l+hXkJWMrC9D8HCi8ithLcL7uaRt+dGp?=
 =?us-ascii?Q?ZejsIDjgXTy1X0gknlXmABJzh3mtnrn5Z/BZzfckQeDggdNDeJ06AbiuCrRx?=
 =?us-ascii?Q?9IwofKnZC6MeRiz+IlOrPQf3Cksay2LACKmFds55w1WYdcTgM+ny2rFtGSiv?=
 =?us-ascii?Q?8VYFUB4w+/EmtB3A0DHL9c6hXUu5liLVH4Hhjaa21L/2qqgf/wLTcTv3N0MZ?=
 =?us-ascii?Q?qKlU1Qjes0lGYToPZtYEsTvOlFsJY+3+MvXtZSpW91qylI9T14yt7FX6a3dK?=
 =?us-ascii?Q?M2y+Bgk5gcSBBcKA9YmdYwFYaeFJByw6X5YKjWfde6GMgeeg/oGhdYjBx1QI?=
 =?us-ascii?Q?WBNFRcNVbqqyBc6xyk45MyrC7lrj1QowhmcKoANsdSdSEQ5lGHLSB98ktQuM?=
 =?us-ascii?Q?Af18CovzY4VZalzP/AYAwvgfwY0BrRTq49PUCbsInzXQRSnga67/gAOYDl8h?=
 =?us-ascii?Q?ppf3LCz5czsR9ZvYakdH7/GWm6x9jru9tDJs0LKPPaFEfydCAyEsgDAEOIi3?=
 =?us-ascii?Q?SpbWd1t2IlNsE+oRWUKtQFZZrjvWpZFG9nYSJrEoJ4nfiS30ru6P5wRizDCy?=
 =?us-ascii?Q?pNQCFwysRq81oBeP64x3VPwNDn6PzbyuuY3oTx4j+2xiC9zYS2pGdiX3plFx?=
 =?us-ascii?Q?aglvMXtLHUxube0NOZXO2z1Ar5jD80SDDReEonl5JxkTobnay+TfCtv2z8ut?=
 =?us-ascii?Q?8uXDBBCYZom9Xcc7y/yO/v4sujYw2W3f4nVo9rR8eOsgZsWHvw=3D=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 10:42:17.2255 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5a371d4-85f9-4669-3f6b-08dcfcbd5a3f
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B9E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4P195MB2016
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

The phyCORE-i.MX 93 is available in various variants (e.g. different ram
sizes, eMMC HS400 yes/no). It's eeprom contains information which features
the existing module supports.

Extend the existing board-code to support all the SOM variants. The spl/u-boot
evaluates the eeprom information and enables supported features accordingly.
The resulting spl and u-boot binary is able to boot each phyCORE-i.MX 93 SOM
variant on each carrier board.

Christoph Stoidner (3):
  board: phytec: phycore-imx93: Add 2GB LPDDR4X RAM timings
  board: phytec: imx93: Add eeprom-based hardware introspection
  board: phytec: imx93: Add phyCORE-i.MX93 support all SOM variants

 arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi |  33 +-
 arch/arm/mach-imx/imx9/Kconfig                |   2 +
 arch/arm/mach-imx/imx9/soc.c                  |   2 +-
 board/phytec/common/Kconfig                   |   8 +
 board/phytec/common/Makefile                  |   1 +
 board/phytec/common/imx93_som_detection.c     |  88 ++
 board/phytec/common/imx93_som_detection.h     |  33 +
 board/phytec/phycore_imx93/Kconfig            |  28 +
 board/phytec/phycore_imx93/MAINTAINERS        |   6 +-
 board/phytec/phycore_imx93/lpddr4_timing.c    | 794 ++++++++++++++++--
 board/phytec/phycore_imx93/phycore-imx93.c    |  52 ++
 board/phytec/phycore_imx93/spl.c              |  58 ++
 configs/imx93-phycore_defconfig               | 156 ++++
 13 files changed, 1196 insertions(+), 65 deletions(-)
 create mode 100644 board/phytec/common/imx93_som_detection.c
 create mode 100644 board/phytec/common/imx93_som_detection.h
 create mode 100644 configs/imx93-phycore_defconfig

-- 
2.34.1

