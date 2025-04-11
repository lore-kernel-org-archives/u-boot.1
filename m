Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73020C369A2
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 08:13:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E52A83F7F;
	Fri, 11 Apr 2025 10:13:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="wHplM0W7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 771C582B16; Fri, 11 Apr 2025 10:13:47 +0200 (CEST)
Received: from AS8PR03CU001.outbound.protection.outlook.com
 (mail-westeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3423983F7F
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 10:13:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DRm62gK6A37oc+y2i11xUI0tyNJkaG8w9Gogr0wqX4G3nfiePZHkabpV1EtSc9rhyKFcxLGusCpUiGIPVWF6HKUkwfBWRnIZBUpuRBG1UUrYmapUu2DWD7r796l7BYLfpvY/o6//NkkMxCZSz3HoTs9LoQkNJxubhbzRDz/k2ldUyKdm9XdP2/zCTF9daueOj1ryoM6QTNO3SA4OensPANiOGD6o7tZojUMdhkXWkz7EQ4WCfs/A3Rcsodgkc8J6iyd6BRL7WccUcKkEiLEpZpLU3O0T4uc5RGVzbL3XezL500NTG28BUvcJanaQJoYedcwC+jf9cjOJ9abD1PSVHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CuDq3N53lj/y9bGDdKUZJyl71Rr2igrSNciaFr5dB04=;
 b=xV7LbTPHYY8DOdcWn16mT5dBm57HgLcikqUM545AgoMHEsUhf/4XqhS6+T6L+wPmp0x8iaLqKNU7+IO2LuqZFxsut1b746TkyPcBfBQx1PUM8HZb+i0cqoaFBqPL8jT92muF2LkS3ZCp/X2Ceq2IQCloaamHy4L+fhaITI5au8x2z8a2uEXXO//sXhfxuhqJtUS91z6JjGws2awYP8NmgoLSKCRZ/0VYwmWguedU+kgQF5NF3r0jNJ3WDX4NPxeJV+Ghpqun7JoxbugJcCxnufrBFNqClUSTvrG2xXkGE/vFoWLd3sQA3Or/HfpnR/1/q0bOiGtV6bRGvdcTEWp4vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CuDq3N53lj/y9bGDdKUZJyl71Rr2igrSNciaFr5dB04=;
 b=wHplM0W7oDcAkbQ3jRIb8Hh2Hp79amaM7iBnQrj3E0obRN6B80KHmiC35QrEumKAe+nHPdfFc3IrSCIS2zzXtQp7BK3CAF79zXHZNHx2/Wyofl28PFXGRPQroGCKzd059RFby3hgql0KcAZuln4n8JDla7gdNKUYqBgEnTzOOCp28DMm6TElhxACVsKV572Tt0Z9N6XWrN5I8EBA2qw60rEDzn/hN1nm8uFjJ49bX3rfIgNIukvW8THBasmmaBzaSfgvxPDuQ7h1ng2yV2BO9+MAWbxs8BLtAkf1RkMDHMJz7WvqyJ8FCZb+dVQrd2jrOQxp94d73TNldnLyAUXUWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PA4PR04MB7967.eurprd04.prod.outlook.com (2603:10a6:102:b8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.23; Fri, 11 Apr
 2025 08:13:43 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8632.024; Fri, 11 Apr 2025
 08:13:43 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: marex@denx.de, trini@konsulko.com, festevam@gmail.com, lukma@denx.de,
 seanga2@gmail.com, sjg@chromium.org, sbabic@denx.de,
 alpernebiyasak@gmail.com, alice.guo@nxp.com
Cc: u-boot@lists.denx.de, viorel.suman@nxp.com, ye.li@nxp.com,
 ranjani.vaidyanathan@nxp.com, peng.fan@nxp.com, frank.li@nxp.com,
 ji.luo@nxp.com, jindong.yue@nxp.com, Anton.Gres@ifm.com
Subject: [PATCH v9 16/20] tools: imx8image: add i.MX95 support
Date: Fri, 11 Apr 2025 16:06:59 +0800
Message-ID: <20250411080707.602371-17-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250411080707.602371-1-alice.guo@oss.nxp.com>
References: <20250411080707.602371-1-alice.guo@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0009.apcprd06.prod.outlook.com
 (2603:1096:4:186::17) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|PA4PR04MB7967:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fd89cbf-7143-4e70-8b69-08dd78d0c5dd
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|7416014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9x12Vw2ViFJ7K9FFQJ9WlV7X2gD8hUELgfBqHj1H5yA+PxLO37dUkNr+2XPY?=
 =?us-ascii?Q?/WWplUbjiUQeg6euXPsffo+rNbDhiNbnFjFr+qTA9AoSR5/zkTStuHMUhsaj?=
 =?us-ascii?Q?aAWHtdK8ubKcqjYbmT0EOZ4SRlxpX4nhKTE1cQ+oZcVouP8D1ZcR9zba7bn2?=
 =?us-ascii?Q?3JGuRNgC3dZIrfkYKLdFttS87iU/G4dH4xQiuDNP/CVE+LsVmq74AfzsMrsl?=
 =?us-ascii?Q?TaynjxmYtyVuCltsWC4l8Uksl7mB6a6acFw0ivY5tijh4CGoZBLWLQibbUK2?=
 =?us-ascii?Q?rNqubUBJbMFx5gsg8Ii2Xdy0hVypdMml5mZbySzQwIVRVKeROusfXdGIis6L?=
 =?us-ascii?Q?4ThTHKW4nzMvvcvHuiu1xLwO9Y/2R22dCzQ75iFWcG0WM4CQ2FqY3DKHxeZx?=
 =?us-ascii?Q?HoCcWQFx84CsAgLuinT9mhiir60OD1aUAYo06pAXdGnecTFILqWQvKHTg0r1?=
 =?us-ascii?Q?sYNLfIhQgsTj2l6Ilz8yL3EAbBkoy2z1OqnCcECsaq4x1pFWqFPyivsOwWxW?=
 =?us-ascii?Q?hBNCj+pF71XQ3w6vzXWH515t9UzcmJTcODn3IV+AKGix0WuenjPQmHI2LgVz?=
 =?us-ascii?Q?m80nJpJs1BDFyGdZKEJiwtSj/VlrijBoKB92nha2ErH3hs9Hd3RhWU3hnB6F?=
 =?us-ascii?Q?SINTg6Yct/jylN1lT3OyaYmls1VsU6r2a8oBJiNsXUWXte18SSRLOj2Pa/qG?=
 =?us-ascii?Q?fOqb6jrSMnRttNBp+eF+LvP1889UYTuX9bk6hulmDj7YuAahPR3ocNoHfx6D?=
 =?us-ascii?Q?FSYEtDB2xZUOkfr9s9YhefLMg2AwNDQvlFr+HIsdtNiKKyOteXjnzyQJUmkr?=
 =?us-ascii?Q?PNILejjsqeZ3FVQPhIFLh6EvXHqEPSibv8nkfCL/OFJXKsAoeA46YwvFm/f6?=
 =?us-ascii?Q?LZHiAWarmbP6V41gPsXbxPRpjgsvXMQbvRnx2//yeP4yuBSKL3FIcgr//3Hu?=
 =?us-ascii?Q?OtvpCYdFd4HZO4Jvi/yFP81SViV5Vu1jZjmmRqBq3EamVifpjnzX+0SZq0bo?=
 =?us-ascii?Q?tQVlHPPbyzz7F5J9qZJAfRLWa2KV54wuO3gol5UsEVoyzfrPEPl6WB23I2e7?=
 =?us-ascii?Q?JAH0WxYYzuW6Hd0WE8JlpfNWa8bbKu7xK1VWP4sWuYv8uOkeyBcj2YUFfEc1?=
 =?us-ascii?Q?tN7jrWksItPYT/ipt8zBZ9myaZNeD/5OKYbn9ergRohiymRgt0W5iLvFBsu+?=
 =?us-ascii?Q?3LvIdEgU971lGuZL0ggl5Gu+qtObAMCi+5ikTMpSgeGZS7VYefl6PgC8zoCe?=
 =?us-ascii?Q?pSLAbOx4tag420/SxjCTQnFT/J5S108LRxUy6tikgrqhNlhQKAnzbN0if50F?=
 =?us-ascii?Q?pJvCFDmmSpiKWFyhK2cC25nHutHe7uLIJkOqUkoyhGB0aj8l0h1Z2P6HHFah?=
 =?us-ascii?Q?d3gx0W1NHlxyK8h0RgGhIUfqGtYPUQ5VP79BjnUDm8AdCsc+HG9qoV4rMAy9?=
 =?us-ascii?Q?cj26v0AF96W3kXP51hZmUk0L/il/h1Oib372ALyVfUQ7Z7pHrrW/3A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fCpuilQ9pSvRFrYCFee69LIC8i2hWW+ZEMMzFkT9aGYLV5TBoPS8Wp6YVPpJ?=
 =?us-ascii?Q?oDr5jMibAeSM3R072T0acY+vJyHksqzYJLX1zqqBfG3fopeqA4W5PfnCb9Ce?=
 =?us-ascii?Q?Zu3YSDp6gKk9rTKM3aY8yu3o1+11+xJr0eUZczmUS9KeH55QscMso91me9Gj?=
 =?us-ascii?Q?sOs4f6tMjhSLHXJhexAqsCfucM6yyEa4248sZ5t2biA3h86zH5JgcgY451Ez?=
 =?us-ascii?Q?T+GafrOBc/BmBoPpRkS1pELtd4CCDM/VAu7av5UuOYueH05NO6wCDXibSyDC?=
 =?us-ascii?Q?qinbsP4FEssudxnY6u/Y3/yIEpCdutRotfN7S8uQUaS0ofXiNazykbic154f?=
 =?us-ascii?Q?xAVnNBrOs58JipBQD7AKWL3MAt6FM9Rm3dNXKj7enHtkJ2jh0u4oChLSk1Cc?=
 =?us-ascii?Q?vIbO12d25x+H2pG5slY0m8lUfF7kF+FhCJFSpR2wLUTISgE7fTA81cBxv8dv?=
 =?us-ascii?Q?G77pV9Ydm2Pj808/H57rNhUiLrn7tkcUvU+I4PUntCbNh3D2wwD0n2PoJBO9?=
 =?us-ascii?Q?f5karuV3TNF2Eva3IsG5gKG+toWKLM72nZdkcZFnuOU5mOJlEn+sosb2qLuQ?=
 =?us-ascii?Q?eDiHfPkU5QOiBNkRPOHl9wscrMSR1U1Tiatsj6J+DcA5Iga3ilixcEx5rUoN?=
 =?us-ascii?Q?hLtY5mH2BRTl+AY6GV9tfyxv46aukC6ta7NOR0XXu8v2o9J1OUaNmnsth/sb?=
 =?us-ascii?Q?VU6AhyA4T+4W9IPfehV5/xfLr1OyTsc9feF1nKUC9KBMhcsyNpF2356C9Xls?=
 =?us-ascii?Q?avO7mdLqBtyJFXxYriILLFVVuoxmb9CIiZxprM2qWIM5OIrvKLSiMDwMQ7d2?=
 =?us-ascii?Q?Jabwf4BoI7iqozbutLoHdgURwzswGf37tUwNCzr1Mo7+XR2QfUv7H+YMdyVM?=
 =?us-ascii?Q?IbjmUOMLYEI0eto/TTmL8nQF8mhXCakArKInIQr2LtzT5Xhf4oMJJAEQCmjn?=
 =?us-ascii?Q?4XLHSMZcUQpOfG8sGG/6gcEhhLJ5onJ81RdrVHtShEDnXOxrFgq74ALyiadb?=
 =?us-ascii?Q?TGJnyDR0wAy4U/y/lK334I4u3d4jO4fX9JWb3RpauYP+It9pJfg/OR/ldoQe?=
 =?us-ascii?Q?3Q46cG95qDUvJu8l5NzMNek36orJRpZ3n38vj0WXQVfqy1NN0gnJx5nfKzBv?=
 =?us-ascii?Q?6uRnqyib2XQMWCvIzdMFUNr/P+MKDlm82pqAA5TakfSZspavJ/18nl2WnWnV?=
 =?us-ascii?Q?cFdDgusokp/arDnRi6kkJUYw32SptD5CKhVj5W6m+NM/lMiRpYpLVMmLcYGK?=
 =?us-ascii?Q?9LYUFgypkK8/xl51iTJ1HGsHNuVtCzNhGJdUCGsOW9s0m2JwXcriFKSwPsNJ?=
 =?us-ascii?Q?uOk5BeQIjBaSBBcUgGv0Ezpg7Lo0fYRG3gJ7IqrGbnuHdQFArpy7QTEGwAik?=
 =?us-ascii?Q?VoXkHwWcpL8nd5ax3yiie88AYClPAiwdxXEbcPtmHhJxNAVBiaSIGKXBYjn4?=
 =?us-ascii?Q?pMHK7DjMbpAPVpm7C1hFujV1FMwnpNN6xtQUo2bDiCZ9JnxbNU1Eq7OTyGV7?=
 =?us-ascii?Q?KgJWBs0hu/p/OILG75RTJOt65PiacI7SVp0fHlK7ri9dy86h+PfXYMzM9scJ?=
 =?us-ascii?Q?SvSsBa8yoDvvciYO4DbJ3CVHRUI3fTwUDqr1s271?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fd89cbf-7143-4e70-8b69-08dd78d0c5dd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 08:13:43.1849 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TYIYKVGbyA/LKGGZH0eKPoF6Net/WlYj9xVN2O3zvILFXUW22apVT5q6QehOhnuvRaZfiST+a/K/3//iKl7j+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7967
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

From: Alice Guo <alice.guo@nxp.com>

i.MX95 uses binman to invoke mkimage to create image container. 2 image
containers are needed currently. The first one is composed of
ahab-container.img, LPDDR firmware images, OEI images, System Manager
image and u-boot-spl.bin. The second one is consisted of ARM Trusted
firmware and u-boot.bin.

Because DDR OEI image and LPDDR firmware images have to be packaged
together and named as m33-oei-ddrfw.bin by binman, so imx9_image.sh does
not check if m33-oei-ddrfw.bin exists.

When using "make imx95_19x19_evk_defconfig; make", imx9_image.sh will
delete the line for u-boot.bin in container.cfg. In fact, binman is
always called after the u-boot.bin is built, so imx9_image.sh does not
check if u-boot.bin exists.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 include/imx8image.h |  19 +++++-
 tools/imx8image.c   | 147 +++++++++++++++++++++++++++++++++++++++-----
 tools/imx9_image.sh |   8 +++
 3 files changed, 155 insertions(+), 19 deletions(-)

diff --git a/include/imx8image.h b/include/imx8image.h
index 6b95e93fb50..e0d25c5b6c9 100644
--- a/include/imx8image.h
+++ b/include/imx8image.h
@@ -157,7 +157,9 @@ enum imx8image_cmd {
 	CMD_SOC_TYPE,
 	CMD_CONTAINER,
 	CMD_IMAGE,
-	CMD_DATA
+	CMD_DATA,
+	CMD_DUMMY_V2X,
+	CMD_HOLD,
 };
 
 enum imx8image_core_type {
@@ -169,7 +171,9 @@ enum imx8image_core_type {
 	CFG_A35,
 	CFG_A55,
 	CFG_A53,
-	CFG_A72
+	CFG_A72,
+	CFG_M33,
+	CFG_OEI,
 };
 
 enum imx8image_fld_types {
@@ -208,7 +212,10 @@ typedef enum option_type {
 	FILEOFF,
 	MSG_BLOCK,
 	SENTINEL,
-	UPOWER
+	UPOWER,
+	OEI,
+	DUMMY_V2X,
+	HOLD,
 } option_type_t;
 
 typedef struct {
@@ -227,12 +234,16 @@ typedef struct {
 #define CORE_CA35       4
 #define CORE_CA72       5
 #define CORE_SECO       6
+#define CORE_M33        7
 
 #define CORE_ULP_CM33		0x1
 #define CORE_ULP_CA35		0x2
 #define CORE_ULP_UPOWER 	0x4
 #define CORE_ULP_SENTINEL 	0x6
 
+#define CORE_IMX95_M33P		0
+#define CORE_IMX95_A55C0	2
+
 #define SC_R_OTP	357U
 #define SC_R_DEBUG	354U
 #define SC_R_ROM_0	236U
@@ -246,10 +257,12 @@ typedef struct {
 #define IMG_TYPE_EXEC    0x03   /* Executable image type */
 #define IMG_TYPE_DATA    0x04   /* Data image type */
 #define IMG_TYPE_DCD_DDR 0x05   /* DCD/DDR image type */
+#define IMG_TYPE_OEI     0x05   /* Optional Executable image type */
 #define IMG_TYPE_SECO    0x06   /* SECO image type */
 #define IMG_TYPE_SENTINEL 0x06	/* SENTINEL image type */
 #define IMG_TYPE_PROV    0x07   /* Provisioning image type */
 #define IMG_TYPE_DEK     0x08   /* DEK validation type */
+#define IMG_TYPE_V2X_DUMMY 0x0E /* V2X Dummy image */
 
 #define IMG_TYPE_SHIFT   0
 #define IMG_TYPE_MASK    0x1f
diff --git a/tools/imx8image.c b/tools/imx8image.c
index 0135b190951..a333ded46e2 100644
--- a/tools/imx8image.c
+++ b/tools/imx8image.c
@@ -7,6 +7,7 @@
 
 #include "imx8image.h"
 #include <image.h>
+#include <linux/sizes.h>
 
 static int p_idx;
 static int sector_size;
@@ -54,7 +55,9 @@ static table_entry_t imx8image_cmds[] = {
 	{CMD_CONTAINER,         "CONTAINER",            "new container",      },
 	{CMD_IMAGE,             "IMAGE",                "new image",          },
 	{CMD_DATA,              "DATA",                 "new data",           },
-	{-1,                    "",                     "",	              },
+	{CMD_DUMMY_V2X,         "DUMMY_V2X",            "v2x",                },
+	{CMD_HOLD,              "HOLD",                 "hold",               },
+	{-1,                    "",                     "",	              }
 };
 
 static table_entry_t imx8image_core_entries[] = {
@@ -66,7 +69,9 @@ static table_entry_t imx8image_core_entries[] = {
 	{CFG_A55,	"A55",			"A55 core",	},
 	{CFG_A53,	"A53",			"A53 core",	},
 	{CFG_A72,	"A72",			"A72 core",	},
-	{-1,		"",			"",		},
+	{CFG_OEI,	"OEI",			"OEI", },
+	{CFG_M33,	"M33",			"M33 core", },
+	{-1,		"",			"",		}
 };
 
 static table_entry_t imx8image_sector_size[] = {
@@ -144,6 +149,14 @@ static void parse_cfg_cmd(image_t *param_stack, int32_t cmd, char *token,
 			exit(EXIT_FAILURE);
 		}
 		break;
+	case CMD_DUMMY_V2X:
+		param_stack[p_idx].option = DUMMY_V2X;
+		param_stack[p_idx++].entry = (uint32_t)strtoll(token, NULL, 0);
+		break;
+	case CMD_HOLD:
+		param_stack[p_idx].option = HOLD;
+		param_stack[p_idx].entry = (uint32_t)strtoll(token, NULL, 0);
+		param_stack[p_idx++].filename = NULL;
 	default:
 		break;
 	}
@@ -221,6 +234,16 @@ static void parse_cfg_fld(image_t *param_stack, int32_t *cmd, char *token,
 				(*cmd == CMD_DATA) ? DATA : AP;
 			param_stack[p_idx].filename = token;
 			break;
+		case CFG_OEI:
+			param_stack[p_idx].option = OEI;
+			param_stack[p_idx].filename = token;
+			param_stack[p_idx].ext = CORE_CM4_0;
+			break;
+		case CFG_M33:
+			param_stack[p_idx].option = M40;
+			param_stack[p_idx].ext = 0;
+			param_stack[p_idx].filename = token;
+			break;
 		}
 		break;
 	case CFG_LOAD_ADDR:
@@ -238,9 +261,15 @@ static void parse_cfg_fld(image_t *param_stack, int32_t *cmd, char *token,
 		case CFG_A53:
 		case CFG_A55:
 		case CFG_A72:
+		case CFG_M33:
 			param_stack[p_idx++].entry =
 				(uint32_t)strtoll(token, NULL, 0);
 			break;
+		case CFG_OEI:
+			param_stack[p_idx].dst = (uint32_t)strtoll(token, NULL, 0);
+			param_stack[p_idx].entry = param_stack[p_idx].dst + 1;
+			p_idx++;
+			break;
 		}
 	default:
 		break;
@@ -549,6 +578,7 @@ static void set_image_array_entry(flash_header_v3_t *container,
 				  char *tmp_filename, bool dcd_skip)
 {
 	uint64_t entry = image_stack->entry;
+	uint64_t dst = image_stack->dst;
 	uint64_t core = image_stack->ext;
 	uint32_t meta;
 	char *tmp_name = "";
@@ -558,7 +588,9 @@ static void set_image_array_entry(flash_header_v3_t *container,
 	img->offset = offset;  /* Is re-adjusted later */
 	img->size = size;
 
-	set_image_hash(img, tmp_filename, IMAGE_HASH_ALGO_DEFAULT);
+	if (type != DUMMY_V2X) {
+		set_image_hash(img, tmp_filename, IMAGE_HASH_ALGO_DEFAULT);
+	}
 
 	switch (type) {
 	case SECO:
@@ -580,6 +612,27 @@ static void set_image_array_entry(flash_header_v3_t *container,
 		img->dst = 0xe4000000; /* S400 IRAM base */
 		img->entry = 0xe4000000;
 		break;
+	case OEI:
+		if (soc != IMX9) {
+			fprintf(stderr, "Error: invalid core id: %" PRIi64 "\n", core);
+			exit(EXIT_FAILURE);
+		}
+
+		img->hab_flags |= IMG_TYPE_OEI;
+		if (core == CORE_CM4_0) {
+			img->hab_flags |= CORE_ULP_CM33 << BOOT_IMG_FLAGS_CORE_SHIFT;
+			meta = CORE_IMX95_M33P;
+
+		} else {
+			img->hab_flags |= CORE_ULP_CA35 << BOOT_IMG_FLAGS_CORE_SHIFT;
+			meta = CORE_IMX95_A55C0;
+		}
+		tmp_name = "OEI";
+		img->dst = (dst ? dst : entry);
+		img->entry = entry;
+		img->meta = meta;
+		custom_partition = 0;
+		break;
 	case AP:
 		if (soc == QX && core == CORE_CA35) {
 			meta = IMAGE_A35_DEFAULT_META(custom_partition);
@@ -587,8 +640,10 @@ static void set_image_array_entry(flash_header_v3_t *container,
 			meta = IMAGE_A53_DEFAULT_META(custom_partition);
 		} else if (soc == QM && core == CORE_CA72) {
 			meta = IMAGE_A72_DEFAULT_META(custom_partition);
-		} else if (((soc == ULP) || (soc == IMX9)) && core == CORE_CA35) {
+		} else if ((soc == ULP) && core == CORE_CA35) {
 			meta = 0;
+		} else if ((soc == IMX9) && core == CORE_CA35) {
+			meta = CORE_IMX95_A55C0;
 		} else {
 			fprintf(stderr,
 				"Error: invalid AP core id: %" PRIu64 "\n",
@@ -687,6 +742,15 @@ static void set_image_array_entry(flash_header_v3_t *container,
 			img->entry = 0x28300200;
 		}
 		break;
+	case DUMMY_V2X:
+		img->hab_flags |= IMG_TYPE_V2X_DUMMY;
+		img->hab_flags |= CORE_SC << BOOT_IMG_FLAGS_CORE_SHIFT;
+		tmp_name = "V2X Dummy";
+		set_image_hash(img, "/dev/null", IMAGE_HASH_ALGO_DEFAULT);
+		img->dst = entry;
+		img->entry = entry;
+		img->size = 0; /* dummy image has no size */
+		break;
 	default:
 		fprintf(stderr, "unrecognized image type (%d)\n", type);
 		exit(EXIT_FAILURE);
@@ -709,15 +773,26 @@ void set_container(flash_header_v3_t *container,  uint16_t sw_version,
 	fprintf(stdout, "container flags: 0x%x\n", container->flags);
 }
 
-static int get_container_image_start_pos(image_t *image_stack, uint32_t align)
+static int get_container_image_start_pos(image_t *image_stack, uint32_t align, uint32_t *v2x)
 {
 	image_t *img_sp = image_stack;
 	/*8K total container header*/
 	int file_off = CONTAINER_IMAGE_ARRAY_START_OFFSET;
 	FILE *fd = NULL;
-	flash_header_v3_t header;
+	flash_header_v3_t *header;
+	flash_header_v3_t *header2;
+	void *p;
 	int ret;
 
+	p = calloc(1, SZ_4K);
+	if (!p) {
+		fprintf(stderr, "Fail to alloc 4K memory\n");
+		exit(EXIT_FAILURE);
+	}
+
+	header = p;
+	header2 = p + FIRST_CONTAINER_HEADER_LENGTH;
+
 	while (img_sp->option != NO_IMG) {
 		if (img_sp->option == APPEND) {
 			fd = fopen(img_sp->filename, "r");
@@ -726,7 +801,7 @@ static int get_container_image_start_pos(image_t *image_stack, uint32_t align)
 				exit(EXIT_FAILURE);
 			}
 
-			ret = fread(&header, sizeof(header), 1, fd);
+			ret = fread(header, SZ_4K, 1, fd);
 			if (ret != 1) {
 				printf("Failure Read header %d\n", ret);
 				exit(EXIT_FAILURE);
@@ -734,19 +809,27 @@ static int get_container_image_start_pos(image_t *image_stack, uint32_t align)
 
 			fclose(fd);
 
-			if (header.tag != IVT_HEADER_TAG_B0) {
-				fprintf(stderr, "header tag mismatched file %s\n", img_sp->filename);
+			if (header->tag != IVT_HEADER_TAG_B0) {
+				fprintf(stderr, "header tag mismatched \n");
 				exit(EXIT_FAILURE);
 			} else {
-				file_off +=
-					header.img[header.num_images - 1].size;
-				file_off = ALIGN(file_off, align);
+				if (header2->tag != IVT_HEADER_TAG_B0) {
+					file_off += header->img[header->num_images - 1].size;
+					file_off = ALIGN(file_off, align);
+				} else {
+					file_off = header2->img[header2->num_images - 1].offset + FIRST_CONTAINER_HEADER_LENGTH;
+					file_off += header2->img[header2->num_images - 1].size;
+					file_off = ALIGN(file_off, align);
+					fprintf(stderr, "Has 2nd container %x\n", file_off);
+					*v2x = true;
+				}
 			}
 		}
 
 		img_sp++;
 	}
 
+	free(p);
 	return file_off;
 }
 
@@ -838,6 +921,7 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 	char *tmp_filename = NULL;
 	uint32_t size = 0;
 	uint32_t file_padding = 0;
+	uint32_t v2x = false;
 	int ret;
 
 	int container = -1;
@@ -861,7 +945,7 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 	set_imx_hdr_v3(&imx_header, 0);
 	set_imx_hdr_v3(&imx_header, 1);
 
-	file_off = get_container_image_start_pos(image_stack, sector_size);
+	file_off = get_container_image_start_pos(image_stack, sector_size, &v2x);
 	fprintf(stdout, "container image offset (aligned):%x\n", file_off);
 
 	/* step through image stack and generate the header */
@@ -870,6 +954,7 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 	/* stop once we reach null terminator */
 	while (img_sp->option != NO_IMG) {
 		switch (img_sp->option) {
+		case OEI:
 		case AP:
 		case M40:
 		case M41:
@@ -892,6 +977,30 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 			file_off += ALIGN(sbuf.st_size, sector_size);
 			break;
 
+		case DUMMY_V2X:
+			if (container < 0) {
+				fprintf(stderr, "No container found\n");
+				exit(EXIT_FAILURE);
+			}
+			tmp_filename = "dummy";
+			set_image_array_entry(&imx_header.fhdr[container],
+						soc,
+						img_sp,
+						file_off,
+						0,
+						tmp_filename,
+						dcd_skip);
+			img_sp->src = file_off;
+			break;
+
+		case HOLD:
+			if (container < 0) {
+				fprintf(stderr, "No container found\n");
+				exit(EXIT_FAILURE);
+			}
+			file_off += ALIGN(img_sp->entry, sector_size);
+			break;
+
 		case SECO:
 		case SENTINEL:
 			if (container < 0) {
@@ -963,11 +1072,15 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 	do {
 		if (img_sp->option == APPEND) {
 			copy_file(ofd, img_sp->filename, 0, 0);
-			file_padding += FIRST_CONTAINER_HEADER_LENGTH;
+			if (v2x)
+				file_padding += FIRST_CONTAINER_HEADER_LENGTH * 2;
+			else
+				file_padding += FIRST_CONTAINER_HEADER_LENGTH;
 		}
 		img_sp++;
 	} while (img_sp->option != NO_IMG);
 
+	fprintf(stderr, "%s: %x %d\n", __func__, file_padding, v2x);
 	/* Add padding or skip appended container */
 	ret = lseek(ofd, file_padding, SEEK_SET);
 	if (ret < 0) {
@@ -980,6 +1093,7 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 		/* Note: Image offset are not contained in the image */
 		tmp = flatten_container_header(&imx_header, container + 1,
 					       &size, file_padding);
+		fprintf(stderr, "error writing image hdr %x\n", size);
 		/* Write image header */
 		if (write(ofd, tmp, size) != size) {
 			fprintf(stderr, "error writing image hdr\n");
@@ -1000,7 +1114,8 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 		    img_sp->option == AP || img_sp->option == DATA ||
 		    img_sp->option == SCD || img_sp->option == SCFW ||
 		    img_sp->option == SECO || img_sp->option == MSG_BLOCK ||
-		    img_sp->option == UPOWER || img_sp->option == SENTINEL) {
+		    img_sp->option == UPOWER || img_sp->option == SENTINEL ||
+		    img_sp->option == OEI) {
 			copy_file_aligned(ofd, img_sp->filename, img_sp->src,
 					  sector_size);
 		}
@@ -1031,7 +1146,7 @@ int imx8image_copy_image(int outfd, struct image_tool_params *mparams)
 	fprintf(stdout, "CONTAINER SW VERSION:\t0x%04x\n", sw_version);
 
 	build_container(soc, sector_size, emmc_fastboot,
-			img_sp, dcd_skip, fuse_version, sw_version, outfd);
+			img_sp, false, fuse_version, sw_version, outfd);
 
 	return 0;
 }
diff --git a/tools/imx9_image.sh b/tools/imx9_image.sh
index ca78a57a19a..6523d1a0ad1 100755
--- a/tools/imx9_image.sh
+++ b/tools/imx9_image.sh
@@ -18,6 +18,14 @@ for f in $blobs; do
 		continue
 	fi
 
+	if [ $f = "m33-oei-ddrfw.bin" ]; then
+		continue
+	fi
+
+	if [ $f = "u-boot.bin" ]; then
+		continue
+	fi
+
 	if [ ! -f $tmp ]; then
 		echo "WARNING '$tmp' not found, resulting binary may be not-functional" >&2
 
-- 
2.43.0

