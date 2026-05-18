Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85D73CD4F3D
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 01:01:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8002D84659;
	Mon, 18 May 2026 03:01:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="dpX/YckF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 136AE83AA9; Mon, 18 May 2026 03:01:10 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D787883FEE
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 03:01:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xhKcj4kcE4+CK7QOVd8T4gXnpPT6RhbWyVqv1ZOqtYODWdXiRPWg/c+T2r999Cu8ETvIipNBo0RjE++eQ2c5Rap6Ghjdmu8jyMBOtGcGmyTjY77T4u830z8nqORtPRqhNJwgr1zKLr4PixiRKJU8Zr0nBbGL7O7SKm7uZuwN1+dIW+ARktZ5aowHsjjeQrtAIMesOqpIwi9v3KP7BY+nEETd+ZeSf4hcZlG8PyQ2Vi6Kou0JBiE9tLUqBH0c8TFw4abhdevm2mrRLHn/P8AublR89KQ2O4RMN8mb4iACdjFvqEFxIZZb3xzIgk0xwBVXX0K/soVcx2W/ipjXy0bGeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vx1quvQTpc1sl2kb/A5M0yeroCl+vNT82FS9qze6wVY=;
 b=l7R7CgQCyaLWdNVxM4Lf+gmD8Ye/UEFfntEoL7WQjvaq9PxcGDSAsjNv0Y7jOasgPzeEx6FBrV5UK68vH2S6JffBgHjSeKKpfC+BVL3KSPgyNhWRa85ZU+y8NZDdyUT0FvvoEhOhRDUHTWyLK0ZuK2grdQzatrT7nP5Axo095Aq6LlgKq+YQBnktglgC9lDdUMrdrWv2zEt9v8qCoadsa5BciBKBmNHXKY+RWeVPq+cZud8/NLiu2PPsYwzc237oyl47H6DJ2LTD6D7gFKfeGu0ADkgM6fQb1XOTQoJgt07FrzqZjQW+19+zCR1AyiA1LKnwCooSL3+FC+fD01981g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vx1quvQTpc1sl2kb/A5M0yeroCl+vNT82FS9qze6wVY=;
 b=dpX/YckFKGLO/xcA5T3Hh1C9a2NnPPHrQ1lK+cFUpxRNzkUXwF6WQgmI0ZfyNeFV44Jg82VlNpU31Ghqtb0BxkTnT2teuZk+eVeVwJCnTStQx7Bixt/wFane8PJ4hRlTgHVrV7EY9kHPC/EIeX5rLArmDxm82OjCtbRBcoDQ8BJ0/nV3noT1TOIvHwqzyAk2p2F0bBTRzCnFK6Cl2BR00nQuImSruc6tCjbHOjSw+GiOCObj2ymVepYy7ROMsriTHH1BBRU8KhcD6afqn36NTChAy3elo1oNpHBXeAE6sDkm6Dqh70NEc/CPn+VeADehdnnO4OGoC1uJLvMTAkrodg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by PA4PR04MB9272.eurprd04.prod.outlook.com (2603:10a6:102:2a7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 01:01:05 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0025.020; Mon, 18 May 2026
 01:01:05 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 18 May 2026 10:18:13 +0800
Subject: [PATCH 4/4] imx8mp: msc-sm2s: Switch to OF_UPSTREAM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-imx8m-of-upstream-2-v1-4-05c0b996c883@nxp.com>
References: <20260518-imx8m-of-upstream-2-v1-0-05c0b996c883@nxp.com>
In-Reply-To: <20260518-imx8m-of-upstream-2-v1-0-05c0b996c883@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>, 
 Matteo Lisi <matteo.lisi@engicam.com>, 
 Martyn Welch <martyn.welch@collabora.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI2PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:4:196::19) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|PA4PR04MB9272:EE_
X-MS-Office365-Filtering-Correlation-Id: f544df01-e26b-4349-df4f-08deb478f05a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|52116014|376014|18002099003|56012099003|22082099003|38350700014|3023799003|11063799003;
X-Microsoft-Antispam-Message-Info: r66vD33SVES8hXpKcYTVXOo2rEPRt49BDPdQZoA/XhihbOX4lr0zB6aQyNl7oaS2krwDbLyc2dbwDRLYO+HuXwnwheHLaBik+x07ywl9seLG5B7qsqskFj6S26sUUtwM3sx/jEX2pM9+eA5EHVpNZstG+jzjCeXh/X6HXIINPwE7W75kmQYFzauOcMww7lPb1ZFUH1k3wViMy/3NYMVLrW3m/pNAo/U03ldjnKClZPrYIdui+3knLOmiZI8BlVbpB1HCJ7cBYvfMKoPQm46eWMV8/CX46ntUoYw0cxFAismUNJPiDhHp0i2Ufj7O5y1nOA7xTARRpovGfdJ3W1G522IvskVJ6G0pGM6BwKIyNH6flEk1mumN057vF0DoOJ3+BhG515oE5yvjNqBubh6BFZhenPDASDRAYFJWBOGrnxUyfPQju5JMFLBviyxUEMoPDbkrSgK3jpTlpY0UcIv+ogSfkx+ThQ4whbnc/2OW5RPnKpxa27w4fA3tfnbtDeSU2Lxx4O9DJxG7W9CsE6qN4G5vlzMe+EFBQ1X50TaXAo+ISjVSexLAnFb9RIH18JhTbqmo8OBTXoJ4+qp0HtbbVxSKII2+6wHnlCa7f8AVyUKRYe975W5kDXoZdDqyDi4i6m1TK6pSwhg9loE0PRgf3KFbLlEVWgg1vav+Am02UdqpXvEGyL+xrQUByU16qY8q8Q+Og7ifRg3c5RU8ssYJftkKF1P1zdgPHUIfQbXoFvDGOYI1hZrc1BjPUaFyWWdt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(376014)(18002099003)(56012099003)(22082099003)(38350700014)(3023799003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXZ3YXk2NDVST2QvNzZPWEpHaTByL0tTbTBQRVd5VEJDMXlBWWVIbVNYZmJZ?=
 =?utf-8?B?UGthcFVsRkhORDYzWFprejNXUEFXejJWa05wb1UvNEZPZ1dpWWdUU1lmNmE4?=
 =?utf-8?B?QVZrT2d3UXVoOVlkeVFYUHpqMUprZitTUzNOSHB0QnJZS25ocnFMcGxaT0hz?=
 =?utf-8?B?QW8vMGVmR1hnOHBQWWVOSHhQTjNJWktROGFDZzlHOFhrbDZ2NGxYOENzWVVP?=
 =?utf-8?B?ZEdtSEdLUFNyMVdkbmRwSkc1QWw1Zys1VFF1UWd2K214NXd1RUkxaS8xK0V2?=
 =?utf-8?B?dUVuZnNlN21KaWZuaFVGbktuSE1aMkhyVXdGOG9qcnpNbFNxMUdMQ0cycGZh?=
 =?utf-8?B?YmlQRzRsbUdaSlc1cExxT0p4L2V6UU9TTnVnRS83WjlWaFV0Y3pteklPYzlm?=
 =?utf-8?B?Z2lrQkhFWUlDbENobUFLU0pIVUI5YUlrd0FRdXd4NjI4S3hYR3NxU3lxZXhh?=
 =?utf-8?B?YkZ1eS9JSU9CM3M4ZDBSbUNlTHRBSGdiV2k5QnZ5VnBuTWE2d08yZkkvL1ZU?=
 =?utf-8?B?R2x3YnNETldMOGtVL2Nqdld2ektEMnN1NmpTRko5c28xdjJZbElFZ2pybmh5?=
 =?utf-8?B?RldlSzJrdkp4bTZBNGt3L3JpRHphcVVONWk4U3JSbjhnZ0FDKzZZaFkxSkNB?=
 =?utf-8?B?UEJ3VnBLNStlMmxNNVRROVJuTVhvNnFROE85VFZLNE1pQXhTQm8yQ1V5Zk1r?=
 =?utf-8?B?YXUxS2ZGYnFGVExVRkRvSTJmL0VoRmJmdkc0NVEvaUZQUXBhZDd5ZXJOME9S?=
 =?utf-8?B?TWVGVmNVOUljQ2kwY1VYNldrTW54cFNROG9EYkhiYS83TFE4c1QweHZiK1Rk?=
 =?utf-8?B?Ty9IbUx6ZWlCYnhOVjg0cjRxNnUyZEhUeWRjSDcyeUd6ajRPelRKUU9DYWYx?=
 =?utf-8?B?V1VGdFBZdmUvUGVYcTBJakRkR1FDcnhTbDNBWk9kYmdKMUtsRTlUUDhlc3hI?=
 =?utf-8?B?NmJEeURyWWNQMG0zV2xrZjZQTHhyK3FuUTIvWXAyYzc5cHNzcHVZK2FxS0s0?=
 =?utf-8?B?V3JQT0djTDZ0ZHUvSTRQaVFtLzRYRjFWYVljSEU1TCtIWVpwT25XOTZCR1Mz?=
 =?utf-8?B?NlBqcDR5bk1aZHJ2eUZKa09Ic2h0azdxLzJvNTRZcldrTHJDbnNtT0t2NWxK?=
 =?utf-8?B?Q0tyY05FSG54SW5XaEJIWVBWcGJNR0NuMStLckJoV3ZjNlNUbWJVWTZUR2x6?=
 =?utf-8?B?YTYwK2pvRTY4djVmT2ZuVjVuZXFNRm1hbHBSd3cwcHJuSk9Gc0RCU2pCcWNh?=
 =?utf-8?B?UFNQazlSc21lUGtIYlNIZXhmWkFxNkVkeXlRRXR4NGY4VnpQMjlQdEM1OVcv?=
 =?utf-8?B?VHFBdkVLdVkwUUdwRm5rNzA0ZTdubm5ubUtuUC9VYUVYRW5HZ3BoMjRuQ1hR?=
 =?utf-8?B?cCsvRDBjSUlIZTQ1M0dsTzVhRzF5bXZONXhiY1VnV1pKYzJ2WkZSQ2QwOGJ6?=
 =?utf-8?B?RWZxZWRyVkxpWDFHL05paUx2ZjYxNDliSlBCUTBPWUpkVm1nRHRuTkhXcnRG?=
 =?utf-8?B?TzdWaW5RZWh6N3pEQ2lBcHZaTldVQkNhWFRHSjZwTTljY016ZmF2TTF5Wjgx?=
 =?utf-8?B?VG5iZFBRWlZTQk84UXlaWndCZVNUdnVtdVdTc0NTVTR1OUVmL1cyN0IyV1ZW?=
 =?utf-8?B?aEQyWXpNUGpjY3dCd3h2YkJmdU5Va21RMC9CckVWU1JyQTFPUzVFamRJSW9k?=
 =?utf-8?B?VTYwMVBTL1NMSCt4cVp5enMvUG1wN0RYZEFwSjVZRFQxODk3cWV4VjZDTlBy?=
 =?utf-8?B?eHNYK1Erc2VyYjYwb0NmVUwvRjhzamlZVDVxc3BVMU5PbFBRSjJNeFM3THIy?=
 =?utf-8?B?aUV0S05UM29ob01QUlRzWjB0OUYxMy95TFZCYlhwNlBheVp3amhDeHBGWUln?=
 =?utf-8?B?ekVyY3o2OGY4YlF6Y0ExNW9tbmRwV0VmTW1Qb0p1dUFnTy9oVENKQlBDUFBn?=
 =?utf-8?B?alZOZGwyVTNCcGorWTlkbnRXenVFRlI2QkNZRjdzdEhnVnVtVUp1UEUzeU5R?=
 =?utf-8?B?YUdQbGs4NVZTblVDSkhGQklheVpabHJlaytXUjJrVzNWMXB1TXhWbDAxRS9S?=
 =?utf-8?B?TG44R2xxRTZkRzBkNmQrMzhHdDN5M2dPNTJFbVUyREh2SEVOYXV1QmtmWGNp?=
 =?utf-8?B?dHBMb1A2eTB2TVRLUlFqMnN6NytxbzBHUVBlUmp3TzBpNEF5K0JsTWhOS1pJ?=
 =?utf-8?B?NzNEZDhUVlAxNTh0cHprK3ZXamlSY0Fuc05uOUIzdURvUkpkQXRGRDBWK0dS?=
 =?utf-8?B?c1crcUVTam0vMlYvbzNVancvK0ZMZXF0Nk1nOGlQaU1zbVcwRDVDWGxOM2dR?=
 =?utf-8?B?MDQrMnJNNGZ0Ny9kZmpJQWtyS1ZvWFRBL2FLeXh1S1cwOWMwYlRHdz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f544df01-e26b-4349-df4f-08deb478f05a
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 01:01:05.5761 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: raJeozEjEfTkV6NCEYuhMpBGt9D6x17QRXWdUcgTYQ3htOnhr3IxiRQierJoAu2LLD1HubjZcnGdbaiAWJMLXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9272
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

From: Peng Fan <peng.fan@nxp.com>

In Upstream Linux, the board dts is imx8mp-msc-sm2s-ep1.dts which is
also showed in msc_sm2s_imx8mp_defconfig:CONFIG_DEFAULT_FDT_FILE.

Upstream file imx8mp-msc-sm2s.dtsi is almost same as U-Boot
imx8mp-msc-sm2s.dts, so directly use imx8mp-msc-sm2s-ep1.dts as U-Boot
device tree and rename the u-boot.dtsi to
imx8mp-msc-sm2s-ep1-u-boot.dtsi.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/dts/Makefile                              |   3 +-
 ...u-boot.dtsi => imx8mp-msc-sm2s-ep1-u-boot.dtsi} |   0
 arch/arm/dts/imx8mp-msc-sm2s.dts                   | 820 ---------------------
 arch/arm/mach-imx/imx8m/Kconfig                    |   1 +
 configs/msc_sm2s_imx8mp_defconfig                  |   2 +-
 5 files changed, 3 insertions(+), 823 deletions(-)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index acf1a1b8495..e099bd988fe 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -883,8 +883,7 @@ dtb-$(CONFIG_ARCH_IMX8M) += \
 	imx8mp-dhcom-pdk-overlay-eth2xfast.dtbo \
 	imx8mp-dhcom-drc02.dtb \
 	imx8mp-dhcom-pdk3-overlay-rev100.dtbo \
-	imx8mp-dhcom-picoitx.dtb \
-	imx8mp-msc-sm2s.dtb
+	imx8mp-dhcom-picoitx.dtb
 
 dtb-$(CONFIG_ARCH_IMX9) += \
 	imx93-11x11-frdm.dtb \
diff --git a/arch/arm/dts/imx8mp-msc-sm2s-u-boot.dtsi b/arch/arm/dts/imx8mp-msc-sm2s-ep1-u-boot.dtsi
similarity index 100%
rename from arch/arm/dts/imx8mp-msc-sm2s-u-boot.dtsi
rename to arch/arm/dts/imx8mp-msc-sm2s-ep1-u-boot.dtsi
diff --git a/arch/arm/dts/imx8mp-msc-sm2s.dts b/arch/arm/dts/imx8mp-msc-sm2s.dts
deleted file mode 100644
index 5dbec71747c..00000000000
--- a/arch/arm/dts/imx8mp-msc-sm2s.dts
+++ /dev/null
@@ -1,820 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2022 Avnet Embedded GmbH
- */
-
-/dts-v1/;
-
-#include "imx8mp.dtsi"
-#include <dt-bindings/net/ti-dp83867.h>
-
-/ {
-	aliases {
-		rtc0 = &sys_rtc;
-		rtc1 = &snvs_rtc;
-	};
-
-	chosen {
-		stdout-path = &uart2;
-	};
-
-	reg_usb0_host_vbus: regulator-usb0-vbus {
-		compatible = "regulator-fixed";
-		regulator-name = "usb0_host_vbus";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_usb0_vbus>;
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		gpio = <&gpio1 12 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
-	reg_usb1_host_vbus: regulator-usb1-vbus {
-		compatible = "regulator-fixed";
-		regulator-name = "usb1_host_vbus";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_usb1_vbus>;
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		gpio = <&gpio1 14 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
-	reg_usdhc2_vmmc: regulator-usdhc2 {
-		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_usdhc2_vmmc>;
-		regulator-name = "VSD_3V3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-		startup-delay-us = <100>;
-		off-on-delay-us = <12000>;
-	};
-
-	reg_flexcan1_xceiver: regulator-flexcan1 {
-		compatible = "regulator-fixed";
-		regulator-name = "flexcan1-xceiver";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	reg_flexcan2_xceiver: regulator-flexcan2 {
-		compatible = "regulator-fixed";
-		regulator-name = "flexcan2-xceiver";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	lcd0_backlight: backlight-0 {
-		compatible = "pwm-backlight";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_lcd0_backlight>;
-		pwms = <&pwm1 0 100000 0>;
-		brightness-levels = <0 255>;
-		num-interpolated-steps = <255>;
-		default-brightness-level = <255>;
-		enable-gpios = <&gpio1 5 GPIO_ACTIVE_HIGH>;
-		status = "disabled";
-	};
-
-	lcd1_backlight: backlight-1 {
-		compatible = "pwm-backlight";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_lcd1_backlight>;
-		pwms = <&pwm2 0 100000 0>;
-		brightness-levels = <0 255>;
-		num-interpolated-steps = <255>;
-		default-brightness-level = <255>;
-		enable-gpios = <&gpio1 6 GPIO_ACTIVE_HIGH>;
-		status = "disabled";
-	};
-
-	leds {
-		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_leds>;
-		status = "okay";
-
-		led-sw {
-			label = "sw-led";
-			gpios = <&gpio1 8 GPIO_ACTIVE_HIGH>;
-			default-state = "off";
-			linux,default-trigger = "heartbeat";
-		};
-	};
-
-	extcon_usb0: extcon-usb0 {
-		compatible = "linux,extcon-usb-gpio";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_usb0_extcon>;
-		id-gpio = <&gpio1 3 GPIO_ACTIVE_HIGH>;
-	};
-};
-
-&A53_0 {
-	cpu-supply = <&vcc_arm>;
-};
-
-&A53_1 {
-	cpu-supply = <&vcc_arm>;
-};
-
-&A53_2 {
-	cpu-supply = <&vcc_arm>;
-};
-
-&A53_3 {
-	cpu-supply = <&vcc_arm>;
-};
-
-&ecspi1 {
-	#address-cells = <1>;
-	#size-cells = <0>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_ecspi1>;
-	cs-gpios = <0>, <&gpio2 8 GPIO_ACTIVE_LOW>;
-};
-
-&ecspi2 {
-	#address-cells = <1>;
-	#size-cells = <0>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_ecspi2>;
-	cs-gpios = <0>, <&gpio2 9 GPIO_ACTIVE_LOW>;
-};
-
-&eqos {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_eqos>;
-	phy-mode = "rgmii-id";
-	phy-handle = <&ethphy0>;
-	status = "okay";
-
-	mdio {
-		compatible = "snps,dwmac-mdio";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		ethphy0: ethernet-phy@1 {
-			compatible = "ethernet-phy-ieee802.3-c22";
-			reg = <1>;
-			eee-broken-1000t;
-			reset-gpios = <&tca6424 16 GPIO_ACTIVE_LOW>;
-			reset-assert-us = <1000>;
-			reset-deassert-us = <1000>;
-			ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_25_NS>;
-			ti,tx-internal-delay = <DP83867_RGMIIDCTL_2_25_NS>;
-			ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
-			ti,clk-output-sel = <DP83867_CLK_O_SEL_OFF>;
-		};
-	};
-};
-
-&fec {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_fec>;
-	phy-mode = "rgmii-id";
-	phy-handle = <&ethphy1>;
-	fsl,magic-packet;
-	status = "okay";
-
-	mdio {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		ethphy1: ethernet-phy@1 {
-			compatible = "ethernet-phy-ieee802.3-c22";
-			reg = <1>;
-			eee-broken-1000t;
-			reset-gpios = <&tca6424 17 GPIO_ACTIVE_LOW>;
-			reset-assert-us = <1000>;
-			reset-deassert-us = <1000>;
-			ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_25_NS>;
-			ti,tx-internal-delay = <DP83867_RGMIIDCTL_2_25_NS>;
-			ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
-			ti,clk-output-sel = <DP83867_CLK_O_SEL_OFF>;
-		};
-	};
-};
-
-&i2c1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c1>;
-	clock-frequency = <400000>;
-	status = "okay";
-
-	id_eeprom: eeprom@50 {
-		compatible = "atmel,24c64";
-		reg = <0x50>;
-		pagesize = <32>;
-	};
-};
-
-&i2c2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c2>;
-	clock-frequency = <400000>;
-	status = "disabled";
-};
-
-&i2c3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c3>;
-	clock-frequency = <400000>;
-	status = "disabled";
-};
-
-&i2c4 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c4>;
-	clock-frequency = <400000>;
-	status = "disabled";
-};
-
-&i2c5 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c5>;
-	clock-frequency = <400000>;
-	status = "disabled";
-};
-
-&i2c6 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c6>;
-	clock-frequency = <400000>;
-	status = "okay";
-
-	tca6424: gpio@22 {
-		compatible = "ti,tca6424";
-		reg = <0x22>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_tca6424>;
-		gpio-controller;
-		#gpio-cells = <2>;
-		gpio-line-names = "BOOT_SEL0#", "BOOT_SEL1#", "BOOT_SEL2#",
-			"gbe0_int", "gbe1_int", "pmic_int", "rtc_int", "lvds_int",
-			"PCIE_WAKE#", "cam2_rst", "cam2_pwr", "SLEEP#",
-			"wifi_pd", "tpm_int", "wifi_int", "PCIE_A_RST#",
-			"gbe0_rst", "gbe1_rst", "LID#", "BATLOW#", "CHARGING#",
-			"CHARGER_PRSNT#";
-		interrupt-parent = <&gpio1>;
-		interrupts = <9 IRQ_TYPE_EDGE_RISING>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-	};
-
-	dsi_lvds_bridge: bridge@2d {
-		compatible = "ti,sn65dsi83";
-		reg = <0x2d>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_lvds_bridge>;
-		enable-gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
-		status = "disabled";
-	};
-
-	pmic: pmic@30 {
-		compatible = "ricoh,rn5t567";
-		reg = <0x30>;
-		interrupt-parent = <&tca6424>;
-		interrupts = <5 IRQ_TYPE_EDGE_FALLING>;
-
-		regulators {
-			DCDC1 {
-				regulator-name = "VCC_SOC";
-				regulator-always-on;
-				regulator-min-microvolt = <950000>;
-				regulator-max-microvolt = <950000>;
-			};
-
-			DCDC2 {
-				regulator-name = "VCC_DRAM";
-				regulator-always-on;
-				regulator-min-microvolt = <1100000>;
-				regulator-max-microvolt = <1100000>;
-			};
-
-			vcc_arm: DCDC3 {
-				regulator-name = "VCC_ARM";
-				regulator-always-on;
-				regulator-min-microvolt = <950000>;
-				regulator-max-microvolt = <950000>;
-			};
-
-			DCDC4 {
-				regulator-name = "VCC_1V8";
-				regulator-always-on;
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-			};
-
-			LDO1 {
-				regulator-name = "VCC_LDO1_2V5";
-				regulator-always-on;
-				regulator-min-microvolt = <2500000>;
-				regulator-max-microvolt = <2500000>;
-			};
-
-			LDO2 {
-				regulator-name = "VCC_LDO2_1V8";
-				regulator-always-on;
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-			};
-
-			LDO3 {
-				regulator-name = "VCC_ETH_2V5";
-				regulator-always-on;
-				regulator-min-microvolt = <2500000>;
-				regulator-max-microvolt = <2500000>;
-			};
-
-			LDO4 {
-				regulator-name = "VCC_DDR4_2V5";
-				regulator-always-on;
-				regulator-min-microvolt = <2500000>;
-				regulator-max-microvolt = <2500000>;
-			};
-
-			LDO5 {
-				regulator-name = "VCC_LDO5_1V8";
-				regulator-always-on;
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-			};
-
-			LDORTC1 {
-				regulator-name = "VCC_SNVS_1V8";
-				regulator-always-on;
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-			};
-
-			LDORTC2 {
-				regulator-name = "VCC_SNVS_3V3";
-				regulator-always-on;
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-			};
-		};
-	};
-
-	sys_rtc: rtc@32 {
-		compatible = "ricoh,r2221tl";
-		reg = <0x32>;
-		interrupt-parent = <&tca6424>;
-		interrupts = <6 IRQ_TYPE_EDGE_FALLING>;
-	};
-
-	tmp_sensor: temperature-sensor@71 {
-		compatible = "ti,tmp103";
-		reg = <0x71>;
-	};
-};
-
-&flexcan1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_flexcan1>;
-	xceiver-supply = <&reg_flexcan1_xceiver>;
-	status = "disabled";
-};
-
-&flexcan2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_flexcan2>;
-	xceiver-supply = <&reg_flexcan2_xceiver>;
-	status = "disabled";
-};
-
-&flexspi {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_flexspi0>;
-	status = "okay";
-
-	qspi_flash: flash@0 {
-		compatible = "jedec,spi-nor";
-		reg = <0>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		spi-max-frequency = <80000000>;
-		spi-tx-bus-width = <4>;
-		spi-rx-bus-width = <4>;
-	};
-};
-
-&pwm1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_pwm1>;
-	status = "disabled";
-};
-
-&pwm2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_pwm2>;
-	status = "disabled";
-};
-
-&pwm3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_pwm3>;
-	status = "disabled";
-};
-
-&pwm4 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_pwm4>;
-	status = "disabled";
-};
-
-&snvs_pwrkey {
-	status = "okay";
-};
-
-&uart1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart1>;
-	status = "okay";
-};
-
-&uart2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart2>;
-	uart-has-rtscts;
-	status = "okay";
-};
-
-&uart3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart3>;
-	uart-has-rtscts;
-	status = "okay";
-};
-
-&uart4 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart4>;
-	status = "disabled";
-};
-
-&usb3_phy0 {
-	vbus-supply = <&reg_usb0_host_vbus>;
-	status = "okay";
-};
-
-&usb3_phy1 {
-	vbus-supply = <&reg_usb1_host_vbus>;
-	status = "okay";
-};
-
-&usb3_0 {
-	status = "okay";
-};
-
-&usb3_1 {
-	status = "okay";
-};
-
-&usb_dwc3_0 {
-	dr_mode = "otg";
-	hnp-disable;
-	srp-disable;
-	adp-disable;
-	extcon = <&extcon_usb0>;
-	status = "okay";
-};
-
-&usb_dwc3_1 {
-	dr_mode = "host";
-	status = "okay";
-};
-
-&usdhc2 {
-	assigned-clocks = <&clk IMX8MP_CLK_USDHC2>;
-	assigned-clock-rates = <400000000>;
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
-	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
-	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
-	cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
-	wp-gpios = <&gpio2 20 GPIO_ACTIVE_HIGH>;
-	bus-width = <4>;
-	vmmc-supply = <&reg_usdhc2_vmmc>;
-	status = "okay";
-};
-
-&usdhc3 {
-	assigned-clocks = <&clk IMX8MP_CLK_USDHC3>;
-	assigned-clock-rates = <400000000>;
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	pinctrl-0 = <&pinctrl_usdhc3>;
-	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
-	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
-	bus-width = <8>;
-	non-removable;
-	status = "okay";
-};
-
-&wdog1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_wdog>;
-	fsl,ext-reset-output;
-	status = "okay";
-};
-
-&iomuxc {
-	pinctrl_ecspi1: ecspi1grp {
-		fsl,pins =
-			<MX8MP_IOMUXC_ECSPI1_MISO__ECSPI1_MISO		0x82>,
-			<MX8MP_IOMUXC_ECSPI1_MOSI__ECSPI1_MOSI		0x82>,
-			<MX8MP_IOMUXC_ECSPI1_SCLK__ECSPI1_SCLK		0x82>,
-			<MX8MP_IOMUXC_ECSPI1_SS0__ECSPI1_SS0		0x40000>,
-			<MX8MP_IOMUXC_SD1_DATA6__GPIO2_IO08		0x40000>;
-	};
-
-	pinctrl_ecspi2: ecspi2grp {
-		fsl,pins =
-			<MX8MP_IOMUXC_ECSPI2_MISO__ECSPI2_MISO		0x82>,
-			<MX8MP_IOMUXC_ECSPI2_MOSI__ECSPI2_MOSI		0x82>,
-			<MX8MP_IOMUXC_ECSPI2_SCLK__ECSPI2_SCLK		0x82>,
-			<MX8MP_IOMUXC_ECSPI2_SS0__ECSPI2_SS0		0x40000>,
-			<MX8MP_IOMUXC_SD1_DATA7__GPIO2_IO09		0x40000>;
-	};
-
-	pinctrl_eqos: eqosgrp {
-		fsl,pins =
-			<MX8MP_IOMUXC_ENET_MDC__ENET_QOS_MDC		0x3>,
-			<MX8MP_IOMUXC_ENET_MDIO__ENET_QOS_MDIO		0x3>,
-			<MX8MP_IOMUXC_ENET_RD0__ENET_QOS_RGMII_RD0	0x91>,
-			<MX8MP_IOMUXC_ENET_RD1__ENET_QOS_RGMII_RD1	0x91>,
-			<MX8MP_IOMUXC_ENET_RD2__ENET_QOS_RGMII_RD2	0x91>,
-			<MX8MP_IOMUXC_ENET_RD3__ENET_QOS_RGMII_RD3	0x91>,
-			<MX8MP_IOMUXC_ENET_RXC__CCM_ENET_QOS_CLOCK_GENERATE_RX_CLK	0x91>,
-			<MX8MP_IOMUXC_ENET_RX_CTL__ENET_QOS_RGMII_RX_CTL	0x91>,
-			<MX8MP_IOMUXC_ENET_TD0__ENET_QOS_RGMII_TD0	0x1f>,
-			<MX8MP_IOMUXC_ENET_TD1__ENET_QOS_RGMII_TD1	0x1f>,
-			<MX8MP_IOMUXC_ENET_TD2__ENET_QOS_RGMII_TD2	0x1f>,
-			<MX8MP_IOMUXC_ENET_TD3__ENET_QOS_RGMII_TD3	0x1f>,
-			<MX8MP_IOMUXC_ENET_TX_CTL__ENET_QOS_RGMII_TX_CTL	0x1f>,
-			<MX8MP_IOMUXC_ENET_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK	0x1f>;
-	};
-
-	pinctrl_fec: fecgrp {
-		fsl,pins =
-			<MX8MP_IOMUXC_SAI1_RXD2__ENET1_MDC		0x3>,
-			<MX8MP_IOMUXC_SAI1_RXD3__ENET1_MDIO		0x3>,
-			<MX8MP_IOMUXC_SAI1_RXD4__ENET1_RGMII_RD0	0x91>,
-			<MX8MP_IOMUXC_SAI1_RXD5__ENET1_RGMII_RD1	0x91>,
-			<MX8MP_IOMUXC_SAI1_RXD6__ENET1_RGMII_RD2	0x91>,
-			<MX8MP_IOMUXC_SAI1_RXD7__ENET1_RGMII_RD3	0x91>,
-			<MX8MP_IOMUXC_SAI1_TXC__ENET1_RGMII_RXC		0x91>,
-			<MX8MP_IOMUXC_SAI1_TXFS__ENET1_RGMII_RX_CTL	0x91>,
-			<MX8MP_IOMUXC_SAI1_TXD0__ENET1_RGMII_TD0	0x1f>,
-			<MX8MP_IOMUXC_SAI1_TXD1__ENET1_RGMII_TD1	0x1f>,
-			<MX8MP_IOMUXC_SAI1_TXD2__ENET1_RGMII_TD2	0x1f>,
-			<MX8MP_IOMUXC_SAI1_TXD3__ENET1_RGMII_TD3	0x1f>,
-			<MX8MP_IOMUXC_SAI1_TXD4__ENET1_RGMII_TX_CTL	0x1f>,
-			<MX8MP_IOMUXC_SAI1_TXD5__ENET1_RGMII_TXC	0x1f>;
-	};
-
-	pinctrl_flexcan1: flexcan1grp {
-		fsl,pins =
-			<MX8MP_IOMUXC_SAI5_RXD1__CAN1_TX		0x154>,
-			<MX8MP_IOMUXC_SAI5_RXD2__CAN1_RX		0x154>;
-	};
-
-	pinctrl_flexcan2: flexcan2grp {
-		fsl,pins =
-			<MX8MP_IOMUXC_SAI5_MCLK__CAN2_RX		0x154>,
-			<MX8MP_IOMUXC_SAI5_RXD3__CAN2_TX		0x154>;
-	};
-
-	pinctrl_flexspi0: flexspi0grp {
-		fsl,pins =
-			<MX8MP_IOMUXC_NAND_ALE__FLEXSPI_A_SCLK		0x1c2>,
-			<MX8MP_IOMUXC_NAND_CE0_B__FLEXSPI_A_SS0_B	0x82>,
-			<MX8MP_IOMUXC_NAND_DATA00__FLEXSPI_A_DATA00	0x82>,
-			<MX8MP_IOMUXC_NAND_DATA01__FLEXSPI_A_DATA01	0x82>,
-			<MX8MP_IOMUXC_NAND_DATA02__FLEXSPI_A_DATA02	0x82>,
-			<MX8MP_IOMUXC_NAND_DATA03__FLEXSPI_A_DATA03	0x82>,
-			<MX8MP_IOMUXC_NAND_DQS__GPIO3_IO14		0x19>;
-	};
-
-	pinctrl_i2c1: i2c1grp {
-		fsl,pins =
-			<MX8MP_IOMUXC_I2C1_SCL__I2C1_SCL		0x400001c3>,
-			<MX8MP_IOMUXC_I2C1_SDA__I2C1_SDA		0x400001c3>;
-	};
-
-	pinctrl_i2c2: i2c2grp {
-		fsl,pins =
-			<MX8MP_IOMUXC_I2C2_SCL__I2C2_SCL		0x400001c3>,
-			<MX8MP_IOMUXC_I2C2_SDA__I2C2_SDA		0x400001c3>;
-	};
-
-	pinctrl_i2c3: i2c3grp {
-		fsl,pins =
-			<MX8MP_IOMUXC_I2C3_SCL__I2C3_SCL		0x400001c3>,
-			<MX8MP_IOMUXC_I2C3_SDA__I2C3_SDA		0x400001c3>;
-	};
-
-	pinctrl_i2c4: i2c4grp {
-		fsl,pins =
-			<MX8MP_IOMUXC_I2C4_SCL__I2C4_SCL		0x400001c3>,
-			<MX8MP_IOMUXC_I2C4_SDA__I2C4_SDA		0x400001c3>;
-	};
-
-	pinctrl_i2c5: i2c5grp {
-		fsl,pins =
-			<MX8MP_IOMUXC_SPDIF_TX__I2C5_SCL		0x400001c3>,
-			<MX8MP_IOMUXC_SPDIF_RX__I2C5_SDA		0x400001c3>;
-	};
-
-	pinctrl_i2c6: i2c6grp {
-		fsl,pins =
-			<MX8MP_IOMUXC_SAI5_RXFS__I2C6_SCL		0x400001c3>,
-			<MX8MP_IOMUXC_SAI5_RXC__I2C6_SDA		0x400001c3>;
-	};
-
-	pinctrl_lcd0_backlight: lcd0-backlightgrp {
-		fsl,pins =
-			<MX8MP_IOMUXC_GPIO1_IO05__GPIO1_IO05		0x41>;
-	};
-
-	pinctrl_lcd1_backlight: lcd1-backlightgrp {
-		fsl,pins =
-			<MX8MP_IOMUXC_GPIO1_IO06__GPIO1_IO06		0x41>;
-	};
-
-	pinctrl_leds: ledsgrp {
-		fsl,pins =
-			<MX8MP_IOMUXC_GPIO1_IO08__GPIO1_IO08		0x19>;
-	};
-
-	pinctrl_lvds_bridge: lvds-bridgegrp {
-		fsl,pins =
-			<MX8MP_IOMUXC_GPIO1_IO07__GPIO1_IO07		0x41>;
-	};
-
-	pinctrl_pwm1: pwm1grp {
-		fsl,pins =
-			<MX8MP_IOMUXC_SPDIF_EXT_CLK__PWM1_OUT		0x116>;
-	};
-
-	pinctrl_pwm2: pwm2grp {
-		fsl,pins =
-			<MX8MP_IOMUXC_SAI5_RXD0__PWM2_OUT		0x116>;
-	};
-
-	pinctrl_pwm3: pwm3grp {
-		fsl,pins =
-			<MX8MP_IOMUXC_GPIO1_IO10__PWM3_OUT		0x116>;
-	};
-
-	pinctrl_pwm4: pwm4grp {
-		fsl,pins =
-			<MX8MP_IOMUXC_SAI3_MCLK__PWM4_OUT		0x116>;
-	};
-
-	pinctrl_tca6424: tca6424grp {
-		fsl,pins =
-			<MX8MP_IOMUXC_GPIO1_IO09__GPIO1_IO09		0x41>;
-	};
-
-	pinctrl_uart1: uart1grp {
-		fsl,pins =
-			<MX8MP_IOMUXC_UART1_RXD__UART1_DCE_RX		0x49>,
-			<MX8MP_IOMUXC_UART1_TXD__UART1_DCE_TX		0x49>;
-	};
-
-	pinctrl_uart2: uart2grp {
-		fsl,pins =
-			<MX8MP_IOMUXC_SD1_DATA4__GPIO2_IO06		0x1c4>,
-			<MX8MP_IOMUXC_SD1_DATA5__GPIO2_IO07		0x1c4>,
-			<MX8MP_IOMUXC_UART2_RXD__UART2_DCE_RX		0x49>,
-			<MX8MP_IOMUXC_UART2_TXD__UART2_DCE_TX		0x49>;
-	};
-
-	pinctrl_uart3: uart3grp {
-		fsl,pins =
-			<MX8MP_IOMUXC_SD1_RESET_B__GPIO2_IO10		0x1c4>,
-			<MX8MP_IOMUXC_SD1_STROBE__GPIO2_IO11		0x1c4>,
-			<MX8MP_IOMUXC_UART3_RXD__UART3_DCE_RX		0x49>,
-			<MX8MP_IOMUXC_UART3_TXD__UART3_DCE_TX		0x49>;
-	};
-
-	pinctrl_uart4: uart4grp {
-		fsl,pins =
-			<MX8MP_IOMUXC_UART4_RXD__UART4_DCE_RX		0x49>,
-			<MX8MP_IOMUXC_UART4_TXD__UART4_DCE_TX		0x49>;
-	};
-
-	pinctrl_usb0_extcon: usb0-extcongrp {
-		fsl,pins =
-			<MX8MP_IOMUXC_GPIO1_IO03__GPIO1_IO03		0x19>;
-	};
-
-	pinctrl_usb0_vbus: usb0-vbusgrp {
-		fsl,pins =
-			<MX8MP_IOMUXC_GPIO1_IO12__GPIO1_IO12		0x19>;
-	};
-
-	pinctrl_usb1_vbus: usb1-vbusgrp {
-		fsl,pins =
-			<MX8MP_IOMUXC_GPIO1_IO14__GPIO1_IO14		0x19>;
-	};
-
-	pinctrl_usdhc2_gpio: usdhc2-gpiogrp {
-		fsl,pins =
-			<MX8MP_IOMUXC_SD2_CD_B__GPIO2_IO12		0x1c4>,
-			<MX8MP_IOMUXC_SD2_WP__GPIO2_IO20		0x1c4>;
-	};
-
-	pinctrl_usdhc2: usdhc2grp {
-		fsl,pins =
-			<MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK		0x190>,
-			<MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD		0x1d0>,
-			<MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0		0x1d0>,
-			<MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1		0x1d0>,
-			<MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2		0x1d0>,
-			<MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3		0x1d0>,
-			<MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT	0xc1>;
-	};
-
-	pinctrl_usdhc2_vmmc: usdhc2-vmmcgrp {
-		fsl,pins =
-			<MX8MP_IOMUXC_SD2_RESET_B__GPIO2_IO19		0x41>;
-	};
-
-	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
-		fsl,pins =
-			<MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK		0x194>,
-			<MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD		0x1d4>,
-			<MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0		0x1d4>,
-			<MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1		0x1d4>,
-			<MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2		0x1d4>,
-			<MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3		0x1d4>,
-			<MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT	0xc1>;
-	};
-
-	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
-		fsl,pins =
-			<MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK		0x196>,
-			<MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD		0x1d6>,
-			<MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0		0x1d6>,
-			<MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1		0x1d6>,
-			<MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2		0x1d6>,
-			<MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3		0x1d6>,
-			<MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT	0xc1>;
-	};
-
-	pinctrl_usdhc3: usdhc3grp {
-		fsl,pins =
-			<MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK		0x190>,
-			<MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD		0x1d0>,
-			<MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0		0x1d0>,
-			<MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1		0x1d0>,
-			<MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2		0x1d0>,
-			<MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3		0x1d0>,
-			<MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4		0x1d0>,
-			<MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5		0x1d0>,
-			<MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6		0x1d0>,
-			<MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7		0x1d0>,
-			<MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE		0x190>;
-	};
-
-	pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
-		fsl,pins =
-			<MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK		0x194>,
-			<MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD		0x1d4>,
-			<MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0		0x1d4>,
-			<MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1		0x1d4>,
-			<MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2		0x1d4>,
-			<MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3		0x1d4>,
-			<MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4		0x1d4>,
-			<MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5		0x1d4>,
-			<MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6		0x1d4>,
-			<MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7		0x1d4>,
-			<MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE		0x194>;
-	};
-
-	pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
-		fsl,pins =
-			<MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK		0x196>,
-			<MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD		0x1d6>,
-			<MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0		0x1d6>,
-			<MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1		0x1d6>,
-			<MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2		0x1d6>,
-			<MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3		0x1d6>,
-			<MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4		0x1d6>,
-			<MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5		0x1d6>,
-			<MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6		0x1d6>,
-			<MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7		0x1d6>,
-			<MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE		0x196>;
-	};
-
-	pinctrl_wdog: wdoggrp {
-		fsl,pins =
-			<MX8MP_IOMUXC_GPIO1_IO02__WDOG1_WDOG_B		0xc6>;
-	};
-};
diff --git a/arch/arm/mach-imx/imx8m/Kconfig b/arch/arm/mach-imx/imx8m/Kconfig
index af3e3d5f0c3..0d22d3b4e3a 100644
--- a/arch/arm/mach-imx/imx8m/Kconfig
+++ b/arch/arm/mach-imx/imx8m/Kconfig
@@ -427,6 +427,7 @@ config TARGET_MSC_SM2S_IMX8MP
 	select IMX8MP
 	select SUPPORT_SPL
 	select IMX8M_LPDDR4
+	imply OF_UPSTREAM
 
 config TARGET_LIBREM5
 	bool "Purism Librem5 Phone"
diff --git a/configs/msc_sm2s_imx8mp_defconfig b/configs/msc_sm2s_imx8mp_defconfig
index 92f72de23a0..1bf681dab32 100644
--- a/configs/msc_sm2s_imx8mp_defconfig
+++ b/configs/msc_sm2s_imx8mp_defconfig
@@ -7,7 +7,7 @@ CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_ENV_SIZE=0x4000
 CONFIG_ENV_OFFSET=0x200000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="imx8mp-msc-sm2s"
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx8mp-msc-sm2s-ep1"
 CONFIG_TARGET_MSC_SM2S_IMX8MP=y
 CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y

-- 
2.51.0

