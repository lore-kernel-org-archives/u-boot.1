Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82ADFCD4F3D
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 01:01:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 805E084676;
	Mon, 18 May 2026 03:01:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="lTWAK0ea";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9480C84694; Mon, 18 May 2026 03:01:07 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4769883FEE
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 03:01:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pHM5Wkk20CiIH2HmNXcQX7d6GswKxxZumh4ioPaBe0E2+V+WSJiDWykUZgRlrA2yeOdJzg3uYhzole+DKa9S3NPAxGcwSB83vDet0h1v9AgZ1xgrzpTs1N/xN+Gp+VZL06X9xThOrrR77sVQdQsPMtuivY9XsfWIhhx65vGTVefq0WUVxPnVyLiLph0ICpmMU/zi9yVkcJeYBhnUzfCvhetlKphiUDdUf2ZTQQtUTfCh1HbImiapj1dViFjb/qZizpyjoGCC4c+w+vxQ0CrLnGW6ks6dynGkrhLEP4p0hJIZCkpmxGFZFOrfm8LbhBUDCjWWiBJoE//OEB5ZaNV4GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zU4Ho5yczhal1FcB0oAGKns2+uqU0iMRmKETjR/qgDc=;
 b=k97yT+pNSQm/UXUbXqn1frY9MqgjFWvMA0MrKwsps3/JQgLXX2+c11uuKXyad9XQBJW5wf2OvfgWcnEJios9+WKN+d+oAFMxvDx/Sz7QWLH2d+bmyZSW8FvxCWG4AoZSFcvPzIxXXRLUPpxiCEc7IhQuSUbWGFnbvUihcIUZ/ecGcKKqwBlgaOsp8bwIDUqi8xdYPO5qkWQKuYAFk+poBFiiCxN9QCAncT0joMOSxXVvvIzo3nJzE2/OlEu24Ir6JxpAqj9ButOWD0RuvpXYBTudPI3dkn77Z0lBOEKwZjXKR2BqCjV9tZqvhLQohRnUlfraFPZYpNtc3vScpXUF2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zU4Ho5yczhal1FcB0oAGKns2+uqU0iMRmKETjR/qgDc=;
 b=lTWAK0easB8F1gGdk/Zs1CiUF2KjXXmEWLzvzHgOMBpUMbqFo/KpvTxi0UBXDNTGnWSx7VxNQShAbXjPEaCZqoIwvXeC8VhqEe17eeERyYYe93Bas/UZ9T+5WHueroYIa+OP/1DeyOf5dLQqRHGeKmWTy3Y8CTxw//LmkHVP5OyzhMwkpjWAr/1APGfrLuUOcJsMBIhnAClt/F6iYcyyoh4rTv/iRtqpStzi94O4bliz6AiOmb4RKAp2yLnTPyoilgAFjtC7xWvUF0aYEDMBBuT5sS4Gi9iBazJb9MUJZ473mubOfO6ZJrbKR4/J3xZD2Z1vHrtqXLUcBoyZammVfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by PA4PR04MB9272.eurprd04.prod.outlook.com (2603:10a6:102:2a7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 01:01:03 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0025.020; Mon, 18 May 2026
 01:01:03 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 18 May 2026 10:18:12 +0800
Subject: [PATCH 3/4] imx8mm: pgh: Switch to OF_UPSTREAM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-imx8m-of-upstream-2-v1-3-05c0b996c883@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: c0d3c2e4-2ccd-464d-3f15-08deb478eedc
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|52116014|376014|18002099003|56012099003|22082099003|38350700014|3023799003|11063799003;
X-Microsoft-Antispam-Message-Info: 7M+nzalrjTfB1S0dY8o7K45hauUN0eeE/rA87mtd9NXMP/Yp3VANOL8KD1Jj2mAioHihqBBkOiFlM2I0p9FAJgXJP/dE+NGW2Ka8rmB3oC5eHVscmlalRkTUflrhyasJHw3SlI92bww5rFPk28XwS4gUgn8MnvqVQ70WxDJ0dM1wC4z5mHGKo5LLO3xfVld/b4xly331564Mgcyc7EFiZEgCSSqrrY/Ifeq5Ith4AkB+TJafyjrHdwe6k9bVqU/HuvBZJ+tNpVwYL5ipP/F/Bd5EXXnWXA48eFtebUUoMc7Tw2JFzsYXjGXnIHhm1juufgeb2rJB+T5/hPOCE0t8AKXaM/m0QFexTidh62jKgb4N2pdEYYoCBtqNlcGEpSddJA0FS8aLpaGwWmV6YCHDnpzbca/QJpKNl28RMn6RyMLdcKSQcTdHlqpnmR8JtkjIJ6GJRTXd5OYPNwiGJ0evD/WIIBLpAl77xzOBHqJcr579u8MUW8t7ETpWeXaLe5bho+M7PvimK7nymLvWbFy9RgWlJUHNd8RVzL0BQgB9zK16r8SP7qMfOC6eLkvgS1V1d0C8SP4jdTEmxNGKxU+CYVv16ZsCAgFw4xwT8vUy3I0jtC9kAu+DKuCdt9PPzdfZwvwW4snTuu4RR08SyNlnJS2mXgbGNk0Xxs5Bes87XG18cxbw76LG55qmwrJGFKYHPbXl7uszcVtJ+WwVRmNlsoUWMh9gXvfY2P9B/KrdpaAFkrH7F4vjTXAXJLvUZuKl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(376014)(18002099003)(56012099003)(22082099003)(38350700014)(3023799003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0ZhODhpRFhuSlB0WUlCYmpmWEZhY3hUMURMUU1MRkk4Y3kvbTlTNlB1eDFw?=
 =?utf-8?B?aDVIV2pOcXIxRHkvNm5pSGFnanlKdnF6NjNvdEl5TnltNkMvM0lIMFlxWUVN?=
 =?utf-8?B?SUROZU40RmdKZC81V3ptYi9pOHNxN1BXc2RURmZNOFZsN2xDbDRaREwyTzJP?=
 =?utf-8?B?Mjh5V1dqSVZobVZVR0lIRmJDdVNWRHBNeUFoeU1MZERFNjN2S2JIRnpPKzRS?=
 =?utf-8?B?NldXYk81WFJtZ2FNSzRqM09VZ0JVS2dmb3ZRWEN5THJMbGI4bTlFRklYbmdB?=
 =?utf-8?B?bjdpeSszYVNmejFpbUh1YW9YUzdrQTZXQmRrOFMzdHpvVmg1N1ErK21OdEg0?=
 =?utf-8?B?QmxxazJVeUd6UW9qZjhkR2FCQjQwajF4aGw3aEtkd29mQmR4bTgzTEZDYzZT?=
 =?utf-8?B?SlNzdGVjUmxhK0VWaDNVY3ViNFFvNjk0Y3hQb05kbGVucWpQb1hGRlpHSm16?=
 =?utf-8?B?cGtUMlNvY0lETmlGZCt1SklsVjZBKzh1b29nbmxGQis0MEdCT0UvMTJwV0E0?=
 =?utf-8?B?UGQyb2d0d0xRSVhWTFIvNm9QeG5nQnJOK0dZRFQ0aGg2RW5kckhjVTlFd2Iw?=
 =?utf-8?B?TFlZVGMva2QySXd0V2VobjFRUEdXeSt4a1ZycVhOTTRNVnBVa2FwaExnZmgz?=
 =?utf-8?B?OUpLNXJsclNVS1ZySktKT1ZpVDFNVEdKYTlXeTZRaEEvM3NCTzRkaEo0OXNt?=
 =?utf-8?B?SktOUjZ5M3BiV1ZDalYwcVUzbm1vdW1BbWhJNlhXWGV0NEZ1UjBLZnVPZlY2?=
 =?utf-8?B?eWJaQk9qL1E5Y29WMStETzRHandmaUsyUlhSQk9xY08wbUFJRWRwbEswM2lJ?=
 =?utf-8?B?QTJCZzZyRlg3ODBzVVphY3ZyM2U3YmVyL1NDdnhNbWdtZEdRRXRkQTY2QVRt?=
 =?utf-8?B?UnRUNWdsRzhhSktRdDlDbVdEU2hNSlIvRzNjc2RQeFlrNTdQUlBvazBsd1l5?=
 =?utf-8?B?RmVqNld4VUJyMS8zM2VmOEZDK2FXSWlBd3JVNFpSK3Vqbk1GYUp1MkE4aEk1?=
 =?utf-8?B?dlZIa01uZGcydnpoNVJnanFxdlJmMWlqUTk0cW82TDhMSVdHb3EvaXVVS0Q0?=
 =?utf-8?B?UG04WlRpNEs5NWZCbG95WTFRVXJwTEkxRWFwT3hZZCtjRWM3T21RV1BNVVlZ?=
 =?utf-8?B?eDh3Z051allLVkJ6Zi9GWVpyTzhpL28yV0hpTTdjM1czN25kVjZRV1dpZTZU?=
 =?utf-8?B?T2QycC9ML2JtM3dzYm9xKzhUMmVCRjdVSkI5RGdFYklrOUlhZnY5Q1hzb3hI?=
 =?utf-8?B?cW51NlR2N09uSThGU3A5QXRIQjg4NUxRUlNUVG5laWs1WEtIVXNNcE9hRUpZ?=
 =?utf-8?B?YVI5M0IvZnl1cGdDcGpRUUxqZExSNkZzK0tsaFpOc0kvTnA4aytKM2JCVjVQ?=
 =?utf-8?B?U3p0ekd3OXBkcFQ2cXUyUnZ6N1p6NERHNDhJOERUZDc1djJydWF2SEFtS2V0?=
 =?utf-8?B?NTg5MmhlMVV0VTRUdlMrMFd3TzkvMUxYdC8zUXZuYVNGbVo2VjJjdnBzNk1J?=
 =?utf-8?B?T0R2enQvbE5OYVN2ZGluek05cExkL3U5dGZ5SWxJSUVvZUMrSjR5bnFxa040?=
 =?utf-8?B?SzlsZ2tPMzVQK2RHditoNTh5VmNkUForRThWVURPcGhnZkNsSXRWQlFsaVhB?=
 =?utf-8?B?VGdMLzgwSEVVd2hBclJESHJhOFdwbll4a012dEw0bzNCVThmcFR1dXo2L2Zz?=
 =?utf-8?B?aVMyaElnOGZ4UUhWeEdlTHQyWHNKcUI2TUk0Z0pQeDBZQTRkNjlHTWRBcGVO?=
 =?utf-8?B?NG9FTWhadnFObnBhcWI5ekxDNnVaNjVOWGFEUlB3dXpqT29JV0wxbHRZZk1y?=
 =?utf-8?B?dDRRTnNoSGp1Y2dGS1BUR09Xdzh0V0hSemM0b0xlS0JkdnA0eUhYVEEzVUNE?=
 =?utf-8?B?TTlZTzdPNldPTXdJSk9LT3V5MGhkMUFoL1FrSDRwMWVFWEtVdU52SFpEcC9V?=
 =?utf-8?B?K1FNWkMvbVMwMjJvUUVKRWtFZXpJSW1aR05qQXZpdlIxdzFPa0pFc3Jramcr?=
 =?utf-8?B?TVYvZEVKYW1Db1FiUnp0cHNUek5YeTlhQmtRNFFOL3U4RXNDeDZlVlVZNlZ5?=
 =?utf-8?B?SDNSQWYvcFhjcUpKM3R3U3RvMEEzemJwcDhVaG1UaE1uNzFMbW5wOFlxY1Bh?=
 =?utf-8?B?RCs2aUQxc2pqekpFbFVVcUg1djliK3N6LytWdk1OMDQ2UUJsVmRuOG5pWWdE?=
 =?utf-8?B?VytZV2FDZGIwUGJMaEZWMk85TkZNQWpsNm1lOTVqcGc4ZENnNEJkZFhDN2g4?=
 =?utf-8?B?dFBkTVlkbmhMK0ZkNGFqbGdLWXdqRkkyT05FUSs5TkJ5UUlpajVPVVl2TVBG?=
 =?utf-8?B?Z2F2SnoxUmMrKzhlR0kxdURNVWpxQnBnRHhPTnlHYlRiTHlYWTVwdz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0d3c2e4-2ccd-464d-3f15-08deb478eedc
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 01:01:03.0943 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d1gIt9GgoWP9/mDw7pT+D773tYnDZJ0TUIAXIPUyh3YvRlF348xUfyxFpb94k6VSwCNAWueoz8a+AHTpNeH0Zg==
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

The U-Boot copy of the board device trees for this board is almost same as
the ones in dts/upstream except some differences in display which not
impact U-Boot as of now, so switch to the board to OF_UPSTREAM, by dropping
the U-Boot copies and selecting OF_UPSTREAM.

There are some changes in imx8mm-tqma8mqml.dtsi regarding sdhc2 supply,
select DM_PMIC_PCA9450, DM_REGULATOR_PCA9450 and SPL_DM_REGULATOR_PCA9450
to avoid breaking sd.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/dts/Makefile              |   1 -
 arch/arm/dts/imx8mm-phg.dts        | 266 -----------------------------
 arch/arm/dts/imx8mm-tqma8mqml.dtsi | 341 -------------------------------------
 arch/arm/mach-imx/imx8m/Kconfig    |   1 +
 configs/imx8mm_phg_defconfig       |   5 +-
 5 files changed, 5 insertions(+), 609 deletions(-)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index dacea5487c6..acf1a1b8495 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -875,7 +875,6 @@ dtb-$(CONFIG_ARCH_IMX8) += \
 dtb-$(CONFIG_ARCH_IMX8M) += \
 	imx8mm-data-modul-edm-sbc.dtb \
 	imx8mm-mx8menlo.dtb \
-	imx8mm-phg.dtb \
 	imx8mq-cm.dtb \
 	imx8mp-data-modul-edm-sbc.dtb \
 	imx8mp-dhcom-som-overlay-rev100.dtbo \
diff --git a/arch/arm/dts/imx8mm-phg.dts b/arch/arm/dts/imx8mm-phg.dts
deleted file mode 100644
index e9447738b10..00000000000
--- a/arch/arm/dts/imx8mm-phg.dts
+++ /dev/null
@@ -1,266 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright 2022 Fabio Estevam <festevam@denx.de>
- */
-
-/dts-v1/;
-
-#include "imx8mm-tqma8mqml.dtsi"
-
-/ {
-	model = "Cloos i.MX8MM PHG board";
-	compatible = "cloos,imx8mm-phg", "tq,imx8mm-tqma8mqml", "fsl,imx8mm";
-
-	aliases {
-		mmc0 = &usdhc3;
-		mmc1 = &usdhc2;
-	};
-
-	chosen {
-		stdout-path = &uart2;
-	};
-
-	beeper {
-		compatible = "gpio-beeper";
-		pinctrl-0 = <&pinctrl_beeper>;
-		gpios = <&gpio1 0 GPIO_ACTIVE_HIGH>;
-	};
-
-	leds {
-		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_gpio_led>;
-
-		led-0 {
-			label = "status1";
-			gpios = <&gpio1 10 GPIO_ACTIVE_HIGH>;
-		};
-
-		led-1 {
-			label = "status2";
-			gpios = <&gpio1 3 GPIO_ACTIVE_HIGH>;
-		};
-
-		led-2 {
-			label = "status3";
-			gpios = <&gpio1 6 GPIO_ACTIVE_HIGH>;
-		};
-
-		led-3 {
-			label = "run";
-			gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
-		};
-
-		led-4 {
-			label = "powerled";
-			gpios = <&gpio1 1 GPIO_ACTIVE_HIGH>;
-		};
-	};
-
-	reg_usb_otg_vbus: regulator-usb-otg-vbus {
-		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_otg_vbus_ctrl>;
-		regulator-name = "usb_otg_vbus";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		gpio = <&gpio2 2 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
-	reg_usdhc2_vmmc: regulator-vmmc {
-		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
-		regulator-name = "VSD_3V3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-		startup-delay-us = <100>;
-		off-on-delay-us = <12000>;
-	};
-};
-
-&ecspi1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_ecspi1>;
-	cs-gpios = <&gpio5 9 GPIO_ACTIVE_LOW>;
-	status = "okay";
-};
-
-&fec1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_fec1>;
-	phy-mode = "rgmii-id";
-	phy-handle = <&ethphy0>;
-	fsl,magic-packet;
-	status = "okay";
-
-	mdio {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		ethphy0: ethernet-phy@0 {
-			reg = <0>;
-			compatible = "ethernet-phy-ieee802.3-c22";
-		};
-	};
-};
-
-&i2c2 {
-	clock-frequency = <100000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c2>;
-	status = "okay";
-};
-
-&uart2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart2>;
-	status = "okay";
-};
-
-&usbphynop1 {
-	power-domains = <&pgc_otg1>;
-};
-
-&usbphynop2 {
-	power-domains = <&pgc_otg2>;
-};
-
-&usbotg1 {
-	dr_mode = "host";
-	vbus-supply = <&reg_usb_otg_vbus>;
-	status = "okay";
-};
-
-&usbotg2 {
-	dr_mode = "host";
-	status = "okay";
-};
-
-&usdhc2 {
-	assigned-clocks = <&clk IMX8MM_CLK_USDHC2>;
-	assigned-clock-rates = <400000000>;
-	assigned-clock-parents = <&clk IMX8MM_SYS_PLL1_400M>;
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
-	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
-	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
-	bus-width = <4>;
-	cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
-	disable-wp;
-	no-mmc;
-	no-sdio;
-	sd-uhs-sdr104;
-	sd-uhs-ddr50;
-	vmmc-supply = <&reg_usdhc2_vmmc>;
-	status = "okay";
-};
-
-&iomuxc {
-	pinctrl_beeper: beepergrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_GPIO1_IO00_GPIO1_IO0		0x19
-		>;
-	};
-
-	pinctrl_ecspi1: ecspi1grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_ECSPI1_MISO_ECSPI1_MISO		0x82
-			MX8MM_IOMUXC_ECSPI1_MOSI_ECSPI1_MOSI		0x82
-			MX8MM_IOMUXC_ECSPI1_SCLK_ECSPI1_SCLK		0x82
-			MX8MM_IOMUXC_ECSPI1_SS0_GPIO5_IO9		0x19
-		>;
-	};
-
-	pinctrl_fec1: fec1grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_ENET_MDC_ENET1_MDC		0x40000002
-			MX8MM_IOMUXC_ENET_MDIO_ENET1_MDIO		0x40000002
-			MX8MM_IOMUXC_ENET_TD3_ENET1_RGMII_TD3		0x14
-			MX8MM_IOMUXC_ENET_TD2_ENET1_RGMII_TD2		0x14
-			MX8MM_IOMUXC_ENET_TD1_ENET1_RGMII_TD1		0x14
-			MX8MM_IOMUXC_ENET_TD0_ENET1_RGMII_TD0		0x14
-			MX8MM_IOMUXC_ENET_RD3_ENET1_RGMII_RD3		0x90
-			MX8MM_IOMUXC_ENET_RD2_ENET1_RGMII_RD2		0x90
-			MX8MM_IOMUXC_ENET_RD1_ENET1_RGMII_RD1		0x90
-			MX8MM_IOMUXC_ENET_RD0_ENET1_RGMII_RD0		0x90
-			MX8MM_IOMUXC_ENET_TXC_ENET1_RGMII_TXC		0x14
-			MX8MM_IOMUXC_ENET_RXC_ENET1_RGMII_RXC		0x90
-			MX8MM_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL	0x90
-			MX8MM_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL	0x14
-			MX8MM_IOMUXC_SAI2_RXC_GPIO4_IO22		0x10
-		>;
-	};
-
-	pinctrl_gpio_led: gpioledgrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_GPIO1_IO10_GPIO1_IO10		0x19
-			MX8MM_IOMUXC_GPIO1_IO03_GPIO1_IO3		0x19
-			MX8MM_IOMUXC_GPIO1_IO06_GPIO1_IO6		0x19
-			MX8MM_IOMUXC_GPIO1_IO07_GPIO1_IO7		0x19
-			MX8MM_IOMUXC_GPIO1_IO01_GPIO1_IO1		0x19
-		>;
-	};
-
-	pinctrl_i2c2: i2c2grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_I2C2_SCL_I2C2_SCL		0x400001c3
-			MX8MM_IOMUXC_I2C2_SDA_I2C2_SDA		0x400001c3
-		>;
-	};
-
-	pinctrl_otg_vbus_ctrl: otgvbusctrlgrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_SD1_DATA0_GPIO2_IO2		0x119
-		>;
-	};
-
-	pinctrl_uart2: uart2grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_UART2_RXD_UART2_DCE_RX		0x140
-			MX8MM_IOMUXC_UART2_TXD_UART2_DCE_TX		0x140
-		>;
-	};
-
-	pinctrl_usdhc2_gpio: usdhc2grpgpiogrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x1c4
-		>;
-	};
-
-	pinctrl_usdhc2: usdhc2grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK		0x190
-			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD		0x1d0
-			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x1d0
-			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d0
-			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d0
-			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d0
-		>;
-	};
-
-	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK		0x194
-			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD		0x1d4
-			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x1d4
-			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d4
-			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d4
-			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d4
-		>;
-	};
-
-	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
-		fsl,pins = <
-			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK		0x196
-			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD		0x1d6
-			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x1d6
-			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d6
-			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d6
-			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d6
-		>;
-	};
-};
diff --git a/arch/arm/dts/imx8mm-tqma8mqml.dtsi b/arch/arm/dts/imx8mm-tqma8mqml.dtsi
deleted file mode 100644
index f649dfacb4b..00000000000
--- a/arch/arm/dts/imx8mm-tqma8mqml.dtsi
+++ /dev/null
@@ -1,341 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
-/*
- * Copyright 2020-2021 TQ-Systems GmbH
- */
-
-#include <dt-bindings/phy/phy-imx8-pcie.h>
-#include "imx8mm.dtsi"
-
-/ {
-	model = "TQ-Systems GmbH i.MX8MM TQMa8MxML";
-	compatible = "tq,imx8mm-tqma8mqml", "fsl,imx8mm";
-
-	memory@40000000 {
-		device_type = "memory";
-		/*  our minimum RAM config will be 1024 MiB */
-		reg = <0x00000000 0x40000000 0 0x40000000>;
-	};
-
-	/* e-MMC IO, needed for HS modes */
-	reg_vcc1v8: regulator-vcc1v8 {
-		compatible = "regulator-fixed";
-		regulator-name = "TQMA8MXML_VCC1V8";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-	};
-
-	/* identical to buck4_reg, but should never change */
-	reg_vcc3v3: regulator-vcc3v3 {
-		compatible = "regulator-fixed";
-		regulator-name = "TQMA8MXML_VCC3V3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	reserved-memory {
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges;
-
-		/* global autoconfigured region for contiguous allocations */
-		linux,cma {
-			compatible = "shared-dma-pool";
-			reusable;
-			/* 640 MiB */
-			size = <0 0x28000000>;
-			/*  1024 - 128 MiB, our minimum RAM config will be 1024 MiB */
-			alloc-ranges = <0 0x40000000 0 0x78000000>;
-			linux,cma-default;
-		};
-	};
-};
-
-&A53_0 {
-	cpu-supply = <&buck2_reg>;
-};
-
-&flexspi {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_flexspi>;
-	status = "okay";
-
-	flash0: flash@0 {
-		compatible = "jedec,spi-nor";
-		reg = <0>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		spi-max-frequency = <84000000>;
-		spi-tx-bus-width = <1>;
-		spi-rx-bus-width = <4>;
-	};
-};
-
-&gpu_2d {
-	status = "okay";
-};
-
-&gpu_3d {
-	status = "okay";
-};
-
-&i2c1 {
-	clock-frequency = <100000>;
-	pinctrl-names = "default", "gpio";
-	pinctrl-0 = <&pinctrl_i2c1>;
-	pinctrl-1 = <&pinctrl_i2c1_gpio>;
-	scl-gpios = <&gpio5 14 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-	sda-gpios = <&gpio5 15 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-	status = "okay";
-
-	sensor0: temperature-sensor-eeprom@1b {
-		compatible = "nxp,se97", "jedec,jc-42.4-temp";
-		reg = <0x1b>;
-	};
-
-	pca9450: pmic@25 {
-		compatible = "nxp,pca9450a";
-		reg = <0x25>;
-
-		/* PMIC PCA9450 PMIC_nINT GPIO1_IO08 */
-		pinctrl-0 = <&pinctrl_pmic>;
-		pinctrl-names = "default";
-		interrupt-parent = <&gpio1>;
-		interrupts = <8 IRQ_TYPE_LEVEL_LOW>;
-
-		regulators {
-			/* V_0V85_SOC: 0.85 */
-			buck1_reg: BUCK1 {
-				regulator-name = "BUCK1";
-				regulator-min-microvolt = <850000>;
-				regulator-max-microvolt = <850000>;
-				regulator-boot-on;
-				regulator-always-on;
-				regulator-ramp-delay = <3125>;
-			};
-
-			/* VDD_ARM */
-			buck2_reg: BUCK2 {
-				regulator-name = "BUCK2";
-				regulator-min-microvolt = <850000>;
-				regulator-max-microvolt = <1000000>;
-				regulator-boot-on;
-				regulator-always-on;
-				nxp,dvs-run-voltage = <950000>;
-				nxp,dvs-standby-voltage = <850000>;
-				regulator-ramp-delay = <3125>;
-			};
-
-			/* V_0V85_GPU / DRAM / VPU */
-			buck3_reg: BUCK3 {
-				regulator-name = "BUCK3";
-				regulator-min-microvolt = <850000>;
-				regulator-max-microvolt = <950000>;
-				regulator-boot-on;
-				regulator-always-on;
-				regulator-ramp-delay = <3125>;
-			};
-
-			/* VCC3V3 -> VMMC, ... must not be changed */
-			buck4_reg: BUCK4 {
-				regulator-name = "BUCK4";
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			/* V_1V8 -> VQMMC, SPI-NOR, ... must not be changed */
-			buck5_reg: BUCK5 {
-				regulator-name = "BUCK5";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			/* V_1V1 -> RAM, ... must not be changed */
-			buck6_reg: BUCK6 {
-				regulator-name = "BUCK6";
-				regulator-min-microvolt = <1100000>;
-				regulator-max-microvolt = <1100000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			/* V_1V8_SNVS */
-			ldo1_reg: LDO1 {
-				regulator-name = "LDO1";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			/* V_0V8_SNVS */
-			ldo2_reg: LDO2 {
-				regulator-name = "LDO2";
-				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <850000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			/* V_1V8_ANA */
-			ldo3_reg: LDO3 {
-				regulator-name = "LDO3";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			/* V_0V9_MIPI */
-			ldo4_reg: LDO4 {
-				regulator-name = "LDO4";
-				regulator-min-microvolt = <900000>;
-				regulator-max-microvolt = <900000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			/* VCC SD IO - switched using SD2 VSELECT */
-			ldo5_reg: LDO5 {
-				regulator-name = "LDO5";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-			};
-		};
-	};
-
-
-	pcf85063: rtc@51 {
-		compatible = "nxp,pcf85063a";
-		reg = <0x51>;
-		quartz-load-femtofarads = <7000>;
-	};
-
-	eeprom1: eeprom@53 {
-		compatible = "nxp,se97b", "atmel,24c02";
-		read-only;
-		reg = <0x53>;
-		pagesize = <16>;
-	};
-
-	eeprom0: eeprom@57 {
-		compatible = "atmel,24c64";
-		reg = <0x57>;
-		pagesize = <32>;
-	};
-};
-
-&pcie_phy {
-	fsl,refclk-pad-mode = <IMX8_PCIE_REFCLK_PAD_INPUT>;
-	fsl,clkreq-unsupported;
-};
-
-&usdhc3 {
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	pinctrl-0 = <&pinctrl_usdhc3>;
-	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
-	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
-	bus-width = <8>;
-	non-removable;
-	no-sd;
-	no-sdio;
-	vmmc-supply = <&reg_vcc3v3>;
-	vqmmc-supply = <&reg_vcc1v8>;
-	status = "okay";
-};
-
-/*
- * Attention:
- * wdog reset is routed to PMIC, PMIC must be preconfigured to force POR
- * without LDO for SNVS. GPIO1_IO02 must not be used as GPIO.
- */
-&wdog1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_wdog>;
-	fsl,ext-reset-output;
-	status = "okay";
-};
-
-&iomuxc {
-	pinctrl_flexspi: flexspigrp {
-		fsl,pins = <MX8MM_IOMUXC_NAND_ALE_QSPI_A_SCLK		0x82>,
-			   <MX8MM_IOMUXC_NAND_CE0_B_QSPI_A_SS0_B	0x82>,
-			   <MX8MM_IOMUXC_NAND_DATA00_QSPI_A_DATA0	0x82>,
-			   <MX8MM_IOMUXC_NAND_DATA01_QSPI_A_DATA1	0x82>,
-			   <MX8MM_IOMUXC_NAND_DATA02_QSPI_A_DATA2	0x82>,
-			   <MX8MM_IOMUXC_NAND_DATA03_QSPI_A_DATA3	0x82>;
-	};
-
-	pinctrl_i2c1: i2c1grp {
-		fsl,pins = <MX8MM_IOMUXC_I2C1_SCL_I2C1_SCL		0x40000004>,
-			   <MX8MM_IOMUXC_I2C1_SDA_I2C1_SDA		0x40000004>;
-	};
-
-	pinctrl_i2c1_gpio: i2c1gpiogrp {
-		fsl,pins = <MX8MM_IOMUXC_I2C1_SCL_GPIO5_IO14		0x40000004>,
-			   <MX8MM_IOMUXC_I2C1_SDA_GPIO5_IO15		0x40000004>;
-	};
-
-	pinctrl_pmic: pmicgrp {
-		fsl,pins = <MX8MM_IOMUXC_GPIO1_IO08_GPIO1_IO8		0x94>;
-	};
-
-	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
-		fsl,pins = <MX8MM_IOMUXC_SD2_RESET_B_GPIO2_IO19		0x84>;
-	};
-
-	pinctrl_usdhc3: usdhc3grp {
-		fsl,pins = <MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK		0x1d4>,
-			   <MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD		0x1d2>,
-			   <MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0	0x1d4>,
-			   <MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1	0x1d4>,
-			   <MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2	0x1d4>,
-			   <MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3	0x1d4>,
-			   <MX8MM_IOMUXC_NAND_RE_B_USDHC3_DATA4		0x1d4>,
-			   <MX8MM_IOMUXC_NAND_CE2_B_USDHC3_DATA5	0x1d4>,
-			   <MX8MM_IOMUXC_NAND_CE3_B_USDHC3_DATA6	0x1d4>,
-			   <MX8MM_IOMUXC_NAND_CLE_USDHC3_DATA7		0x1d4>,
-			   <MX8MM_IOMUXC_NAND_CE1_B_USDHC3_STROBE	0x84>,
-			   /* option USDHC3_RESET_B not defined, only in RM */
-			   <MX8MM_IOMUXC_NAND_READY_B_GPIO3_IO16	0x84>;
-	};
-
-	pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
-		fsl,pins = <MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK		0x1d2>,
-			   <MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD		0x1d2>,
-			   <MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0	0x1d4>,
-			   <MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1	0x1d4>,
-			   <MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2	0x1d4>,
-			   <MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3	0x1d4>,
-			   <MX8MM_IOMUXC_NAND_RE_B_USDHC3_DATA4		0x1d4>,
-			   <MX8MM_IOMUXC_NAND_CE2_B_USDHC3_DATA5	0x1d4>,
-			   <MX8MM_IOMUXC_NAND_CE3_B_USDHC3_DATA6	0x1d4>,
-			   <MX8MM_IOMUXC_NAND_CLE_USDHC3_DATA7		0x1d4>,
-			   <MX8MM_IOMUXC_NAND_CE1_B_USDHC3_STROBE	0x84>,
-			   /* option USDHC3_RESET_B not defined, only in RM */
-			   <MX8MM_IOMUXC_NAND_READY_B_GPIO3_IO16	0x84>;
-	};
-
-	pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
-		fsl,pins = <MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK		0x1d6>,
-			   <MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD		0x1d2>,
-			   <MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0	0x1d4>,
-			   <MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1	0x1d4>,
-			   <MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2	0x1d4>,
-			   <MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3	0x1d4>,
-			   <MX8MM_IOMUXC_NAND_RE_B_USDHC3_DATA4		0x1d4>,
-			   <MX8MM_IOMUXC_NAND_CE2_B_USDHC3_DATA5	0x1d4>,
-			   <MX8MM_IOMUXC_NAND_CE3_B_USDHC3_DATA6	0x1d4>,
-			   <MX8MM_IOMUXC_NAND_CLE_USDHC3_DATA7		0x1d4>,
-			   <MX8MM_IOMUXC_NAND_CE1_B_USDHC3_STROBE	0x84>,
-			   /* option USDHC3_RESET_B not defined, only in RM */
-			   <MX8MM_IOMUXC_NAND_READY_B_GPIO3_IO16	0x84>;
-	};
-
-	pinctrl_wdog: wdoggrp {
-		fsl,pins = <MX8MM_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B	0x84>;
-	};
-};
diff --git a/arch/arm/mach-imx/imx8m/Kconfig b/arch/arm/mach-imx/imx8m/Kconfig
index aa8783e971b..af3e3d5f0c3 100644
--- a/arch/arm/mach-imx/imx8m/Kconfig
+++ b/arch/arm/mach-imx/imx8m/Kconfig
@@ -139,6 +139,7 @@ config TARGET_IMX8MM_PHG
 	select IMX8MM
 	select SUPPORT_SPL
 	select IMX8M_LPDDR4
+	imply OF_UPSTREAM
 
 config TARGET_IMX8MM_VENICE
 	bool "Support Gateworks Venice iMX8M Mini module"
diff --git a/configs/imx8mm_phg_defconfig b/configs/imx8mm_phg_defconfig
index 8fbe0e049e6..c99b8e22bac 100644
--- a/configs/imx8mm_phg_defconfig
+++ b/configs/imx8mm_phg_defconfig
@@ -7,7 +7,7 @@ CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_ENV_SIZE=0x4000
 CONFIG_ENV_OFFSET=0x200000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="imx8mm-phg"
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx8mm-phg"
 CONFIG_TARGET_IMX8MM_PHG=y
 CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y
@@ -90,8 +90,11 @@ CONFIG_PINCTRL_IMX8M=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_IMX8M_POWER_DOMAIN=y
 CONFIG_DM_PMIC=y
+CONFIG_DM_PMIC_PCA9450=y
 CONFIG_SPL_DM_PMIC_PCA9450=y
 CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_PCA9450=y
+CONFIG_SPL_DM_REGULATOR_PCA9450=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_DM_SERIAL=y

-- 
2.51.0

