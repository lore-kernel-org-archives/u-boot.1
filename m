Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B488CD5BB1
	for <u-boot@archiver.kernel.org>; Sat, 23 May 2026 12:24:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FCB5848D2;
	Sat, 23 May 2026 14:23:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="LE1AjcbE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D093848D2; Sat, 23 May 2026 14:23:21 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C732848BF
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 14:23:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hUc0nuSbgTf3KnbLE4++mB2b6CLSh8MEdXMr8WqpEnxXXEOdg39BL/pjFtlUUnTifN3oCO04QcepKMufPf9orvnF+I+VzqXQOxkcEfbjSP7pi2aMl/7OeVTUC6WijEBDxgoHITdsyqEsrhKs1CjT5s+fkg0QvqSpBp94WKR+xg8iX01z/RNZh3vGNKplWrn2BquMBuisiA3SYcX3HyyjCUOpjwdx38mFDxnMLTTNgd9PZ+O1VB3IpacOfIWmuIcReiHGxMsMwsMnNRuLhEtnQJ8ozXruyDO1VisUh9IXWD2OBzv3p8rb5d3EMRdKva4jx4DU7Aix17YzJLmHDUKOfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WSlp9U5er80igDsOi1rmBbSZIZSV0KFnXGfTBS4v8X4=;
 b=Phg1yRHXyqGFXjhCFP9g02Hc3cKWYfOnPniVTdRMybLF+4NqqLBhs142IsDaQMpf0IZ2YI46ExHATuUv+kg0FmQqiYwGy1ODsxXISKDCeKI6DJFJwU+vLppVTfV3ZBOi5tqWhkBIFu5WJytgmRzVZLZgQSsP1SACJNvFOypVz1ntz7osK4/blKsMKfZ9eTU5Ds0oYAal31m9rCa5tP2DlsBcQOBeVRwM+IgJY4MVinN0W5RGdbjsQPdVr9DGPfnHzxW9nF2gN/NCIINzSkul3OuQcX6l1wQRhoj2OTQ4pHKsDzEtXX9wU7cPHrFEpTRTsLGx55LB0XraJ2oLS8f/Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WSlp9U5er80igDsOi1rmBbSZIZSV0KFnXGfTBS4v8X4=;
 b=LE1AjcbEfzwVpQuHr5SKL9QbjobAB6nx9psU80wWWGoNMD7EjicGIgf7ogYYgjyhovFDgraYpk/7ZcgXLcwmbeQdlPEk/nreNCkb5VmaH46OxX71TF64nXt9xTIFDicQubuIp01mHol16fkr+KH3XilXfJ1PUJdlByT7eaaXnSNGwzBXGphjvfEg3KlxRChubHvGQ1BBBzgz7FGb4BOxVRlVndVESUp43qiU7jsKtW3Z7bazlmU5mywbYXHZ9kKzC+kaDN4aj+VhfXqyiL2PNlEOZwYZ1m06ecdXUsUeikwdcCOo5XTpDRKkpOkq8+OFlvADfzCk5N2ZZN5c769srw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by GV4PR04MB11976.eurprd04.prod.outlook.com (2603:10a6:150:2e9::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.18; Sat, 23 May
 2026 12:23:17 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Sat, 23 May 2026
 12:23:17 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 23 May 2026 21:39:50 +0800
Subject: [PATCH 07/13] imx8m: dts: Update ddr firmware name
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260523-imx-misc-v1-7-2898c9eca9f8@nxp.com>
References: <20260523-imx-misc-v1-0-2898c9eca9f8@nxp.com>
In-Reply-To: <20260523-imx-misc-v1-0-2898c9eca9f8@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: MA5PR01CA0255.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:223::6) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|GV4PR04MB11976:EE_
X-MS-Office365-Filtering-Correlation-Id: c364c3da-7b83-4937-2ddc-08deb8c611c6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|376014|52116014|1800799024|18002099003|22082099003|56012099003|38350700014|11063799006;
X-Microsoft-Antispam-Message-Info: RfFbDsZfiUumM1aVcIa1WJ9e4YvZhmOSxXakzSF2lbKVSrT6frmGLSRpv1WksBCHCwGHt8Q3SZsRDnKG5UZAHU1KAdDsmmvLuQmpn/zk4XxtSOi5sKO/yG1EnAUymkAqsprm7JrRYgZsF2rQZ3fWIB1YP88DklFDiYouH2Yhc4/I7Az+S7ZfUZz/GpZwv7bOJUsbFdHqsSDW22kfEKSNuoLBSZyku7SuWnlZu4ZLQYtJVljISdggXPGZteqvf/pnRet16Ai1Nf7kI6pT0EETQp8yZRhO0yWCMMJFiDFD7T7qgl47NsB/7zqwtC4TVqrbaPMbUHY7Im4VCsGbVA5gitOZyvjFIWeLztJFYUplGEdvuEdfaAfCjmj7F9kZQxKZiYEfY5kb8rbwyld424t0tYFyE+D46/KkwM4hPMTw0aFLNsZeJWtpYIYjmLrHGT3bVtXHQV0AMEtOsqqJsrIkXDDL5ECtyypZelKw8hV/CUzRjquypDNFthvR1pe+0CucKl6OJfIUL60cTHSZv0Dx0WHY0Q/Jqn16sRIR1kKVOoVC+iHXlOGKObGzouuXBPbkLe9Gy6yMWCQ499lqID7yYq7C55RXpzDcYD8KIuJAq8AA2054cwJWIYts+kPzeFLsfrumwDdTBXKyBH9XVNOlr1AAz1XNzyMMRemd8Jx0BdttUagDyBbtlKma9OMPgyR+PuWzSCjiHgMCo5+++6+0GhjepFf36PYG8tu3hijLe/1NcFlnpkOxt1XowruJ7sbs
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(376014)(52116014)(1800799024)(18002099003)(22082099003)(56012099003)(38350700014)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjFlekt2MFZ0allyN2lTZHg4M0NkZk8zdGNNbzNkVG9JK0d4c0hQU2twbTJo?=
 =?utf-8?B?RWQ2K3ZPSW02U2o1Z3hTSWg1NTJGSnUrYUV3WCtxaXR2TlVZNVg4N0xlT1Qz?=
 =?utf-8?B?N3pFREFXOStOZE1wNGMycm9lVGpoYWp2NTR3TkVqdEpFMU1YSzAzcjRtbDB6?=
 =?utf-8?B?dmNnYXh0MTdEK2tCZUlHbE8vK1k1emZrV3NOZnl2bVI1aVdFdDc0eHVDcG5k?=
 =?utf-8?B?Z3o4Z0VqZTZBZE80elJNSXZJdlpJdHQ2SHZaYUY5RWJsd2cxd1UyRmhFVGtr?=
 =?utf-8?B?Vy8xbk55NWoxYmtOS2JLVXlOc3dVY0FLamhNV2E0dXAzNTJiTkUxcDFNZ0lE?=
 =?utf-8?B?cS8yK2V6ZEVvV2d2VEdWTmdiK2FqZ29VeENXeC9IbzNFb3ltT1VxU0hCaTdp?=
 =?utf-8?B?OGtXN003cnhIVGhUejZqTHR2Y3RUQUpnN1pXYjAyVGNKSEFpaWlLNDEyWHpY?=
 =?utf-8?B?Sm1QZC9rendpWlNZUVFjOEF4ZmxUSmFmRmJKY3dYVEhHQ29pOGM2cVdOWkJ5?=
 =?utf-8?B?N1JwUFhQampiT01UbFRwQkV3bHNUTzZpU1d0ZW1yMUJiL0JsdHdJaXlKbzZj?=
 =?utf-8?B?dnhweU96VCtXdW9aVkR4M2Q4YTZ2RXpGWTBVZzNIelJwb3pXM1VMQzlIR2VI?=
 =?utf-8?B?T21DdjNnTTBRVnhreEVTbUpkejAwQ05pQjFXc2k2WTd2RzEyQkh4RGwwbDhW?=
 =?utf-8?B?OUI1NUptbWVCUHIvYnVrOTI1SXllTVlSdHpWWldMM3RSRERJOUZQYnhJLzNS?=
 =?utf-8?B?ODh2Q242RkV0QStBWGlWRkFmV1QvM1EwU1g4Z3NKdHBuTzhzeWZIYlhHTnRY?=
 =?utf-8?B?YU1PSXJRN1BnZzZjWUphb1c4eVZzL0RCdzRqbFk0VVlnTFA2NHRuQkRWWG5m?=
 =?utf-8?B?ZWw4WGdiU29qd2ZxdkxNSWNqdlFWQVpoR083MTQ4NWxpdXROMWpUYjZsYkdW?=
 =?utf-8?B?WFpORndzNk52UC94WDV0bVlCYTRwMVRQTnNuc2MvSmZ1YWZYZHlFb040emg0?=
 =?utf-8?B?bStVZEx2TG1uVmhuY1BwUE9WK2xVT0ZpTWkvaXZ3WWRWcW91eEVEY21BR1hI?=
 =?utf-8?B?U1FFbEFOU0tWT1YyamJsRjZPS0xSbEgxaUN5WndLM2MrY0plVHVSMDNQdFVG?=
 =?utf-8?B?YTFFZ3hFd0ZqUFFzTmJhYkhIRnVLS1dKS2Rab1BkV0djblN5MUxaeFAwTm04?=
 =?utf-8?B?TE1TbmlPTit1MXdqZmFwM1JSSkc4aE5HaEg4Z3d4VlNwc2JTY3ZZZlZLUG1u?=
 =?utf-8?B?ajVBWFpWeEExTDNJd3BUSTJEOUNMSTJKZkxQcEJ5RTBucnYyVjJmV1FOMUg3?=
 =?utf-8?B?SWhNbHhFeXBuNTlyOTFpQ2lyMFd1RUU1N2ZkNjNwTUZvNlg4T25aQXJsM0RF?=
 =?utf-8?B?VUdrNHVDaWZpdzlSaUJRSFliUS9IcHFZTmpoTTlwMmhYN25MVVFHYVNjN3BC?=
 =?utf-8?B?djZYS1dkTDB6RWFIb0hYSUJHWUM5aU5FcHNnejk4RkJXZlI2N1ZqY21oWXcr?=
 =?utf-8?B?N1Q4d2RQWUFsSThERmNBbU9FaS9rMmpQYmtEeFVManYyU2tSdzU5ZUVkbnRM?=
 =?utf-8?B?Nlk4b0Y0NkVad3M1N1c0dGkzZEMvVzNHYmJFVXJLSTNKckx4eE1YelJKSkh6?=
 =?utf-8?B?Z3ZEOXNWMEExeGVFSnMvTlc1YnBFN3RTSTFBait2UjdvYnlQYlhJNDhFc0NW?=
 =?utf-8?B?T0N2QUNsMmhmVUZTMEJ0OGVDVEpDUGFVSExObFl0SlgxSzBIMVQ1Zk9iekV3?=
 =?utf-8?B?U1JORjEwSHJQamh6Vm9Fa3hNbnlyQktkWmtmcno2RC9aSUV5Q1J4dStoNlFk?=
 =?utf-8?B?NXZheThQVEU3amJwamlxQmJOVmtZMUIzY3lhYnZFNGt5cWs3KzNCdzRjT096?=
 =?utf-8?B?Z3EyMWY4Z1BhdVVZeEYyVkdJWkRRbDQ2NDZwa3ExNEJrRUY1a2c2K3lDWkZ3?=
 =?utf-8?B?eGpOMmd3aTAwTXpUenNIdnVJNUtYZFZmMm95ai9acGZGNWxxSzVlRDhKZ2Zz?=
 =?utf-8?B?VXEwTzJscWFnc1prQ2djNTJaNmMzdGhnZ0h1a1NOQ2RXUlo2bVM4MzRhdHVq?=
 =?utf-8?B?RWdacisxWWQ2TXRaR0E2OWd4NjFFa2N6cFo3MEtvY3NybENaQ0E3UThOd0kw?=
 =?utf-8?B?T0lWcUhHd0o3NmpwcU1CZHhWQ3c3QlRlWDc0VElvRUhxQ2NFajFtejJZNlV1?=
 =?utf-8?B?V2UrQUtISUN5NzlYaEtSZzh1SXJ4VFVYTDJEWngreXBNaXpZNTJkS2hjbGFU?=
 =?utf-8?B?TlBjZHV1SUdTb0VkckZpeTYycm9uaXZNQkp4Nm9KRlVhSkI5QjRxdktmSkVj?=
 =?utf-8?B?T25BNmRQV05ZTTNpT3UzYjIwcEhmUGhSakZLTnRUZ0NMbWJEUnUrdz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c364c3da-7b83-4937-2ddc-08deb8c611c6
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2026 12:23:17.5041 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gxEsd8ucevrZXXNWB3UOpVEdT9CjGlqTyuXK2ygqhHEMCgLMI71dHhl2+fM33srqQ72UsHvXNgMP7WFFmThFnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11976
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

Update to latest ddr firmware name, otherwise user may use legacy ddr
firmware from linux-firmware-imx release.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/dts/imx8mm-u-boot.dtsi | 8 ++++----
 arch/arm/dts/imx8mn-u-boot.dtsi | 8 ++++----
 arch/arm/dts/imx8mq-u-boot.dtsi | 8 ++++----
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/dts/imx8mm-u-boot.dtsi b/arch/arm/dts/imx8mm-u-boot.dtsi
index d891e8062fe..3d1850d4ea4 100644
--- a/arch/arm/dts/imx8mm-u-boot.dtsi
+++ b/arch/arm/dts/imx8mm-u-boot.dtsi
@@ -85,25 +85,25 @@
 					};
 
 					ddr-1d-imem-fw {
-						filename = "lpddr4_pmu_train_1d_imem.bin";
+						filename = "lpddr4_pmu_train_1d_imem_202006.bin";
 						align-end = <4>;
 						type = "blob-ext";
 					};
 
 					ddr-1d-dmem-fw {
-						filename = "lpddr4_pmu_train_1d_dmem.bin";
+						filename = "lpddr4_pmu_train_1d_dmem_202006.bin";
 						align-end = <4>;
 						type = "blob-ext";
 					};
 
 					ddr-2d-imem-fw {
-						filename = "lpddr4_pmu_train_2d_imem.bin";
+						filename = "lpddr4_pmu_train_2d_imem_202006.bin";
 						align-end = <4>;
 						type = "blob-ext";
 					};
 
 					ddr-2d-dmem-fw {
-						filename = "lpddr4_pmu_train_2d_dmem.bin";
+						filename = "lpddr4_pmu_train_2d_dmem_202006.bin";
 						align-end = <4>;
 						type = "blob-ext";
 					};
diff --git a/arch/arm/dts/imx8mn-u-boot.dtsi b/arch/arm/dts/imx8mn-u-boot.dtsi
index 29eecd6d70d..d59b0030d6f 100644
--- a/arch/arm/dts/imx8mn-u-boot.dtsi
+++ b/arch/arm/dts/imx8mn-u-boot.dtsi
@@ -140,7 +140,7 @@
 
 					ddr-1d-imem-fw {
 #ifdef CONFIG_IMX8M_LPDDR4
-						filename = "lpddr4_pmu_train_1d_imem.bin";
+						filename = "lpddr4_pmu_train_1d_imem_202006.bin";
 #elif CONFIG_IMX8M_DDR4
 						filename = "ddr4_imem_1d_201810.bin";
 #else
@@ -152,7 +152,7 @@
 
 					ddr-1d-dmem-fw {
 #ifdef CONFIG_IMX8M_LPDDR4
-						filename = "lpddr4_pmu_train_1d_dmem.bin";
+						filename = "lpddr4_pmu_train_1d_dmem_202006.bin";
 #elif CONFIG_IMX8M_DDR4
 						filename = "ddr4_dmem_1d_201810.bin";
 #else
@@ -165,7 +165,7 @@
 #if defined(CONFIG_IMX8M_LPDDR4) || defined(CONFIG_IMX8M_DDR4)
 					ddr-2d-imem-fw {
 #ifdef CONFIG_IMX8M_LPDDR4
-						filename = "lpddr4_pmu_train_2d_imem.bin";
+						filename = "lpddr4_pmu_train_2d_imem_202006.bin";
 #else
 						filename = "ddr4_imem_2d_201810.bin";
 #endif
@@ -175,7 +175,7 @@
 
 					ddr-2d-dmem-fw {
 #ifdef CONFIG_IMX8M_LPDDR4
-						filename = "lpddr4_pmu_train_2d_dmem.bin";
+						filename = "lpddr4_pmu_train_2d_dmem_202006.bin";
 #else
 						filename = "ddr4_dmem_2d_201810.bin";
 #endif
diff --git a/arch/arm/dts/imx8mq-u-boot.dtsi b/arch/arm/dts/imx8mq-u-boot.dtsi
index ed2c704f2e5..b4deaa92160 100644
--- a/arch/arm/dts/imx8mq-u-boot.dtsi
+++ b/arch/arm/dts/imx8mq-u-boot.dtsi
@@ -96,25 +96,25 @@
 				};
 
 				ddr-1d-imem-fw {
-					filename = "lpddr4_pmu_train_1d_imem.bin";
+					filename = "lpddr4_pmu_train_1d_imem_202006.bin";
 					align-end = <4>;
 					type = "blob-ext";
 				};
 
 				ddr-1d-dmem-fw {
-					filename = "lpddr4_pmu_train_1d_dmem.bin";
+					filename = "lpddr4_pmu_train_1d_dmem_202006.bin";
 					align-end = <4>;
 					type = "blob-ext";
 				};
 
 				ddr-2d-imem-fw {
-					filename = "lpddr4_pmu_train_2d_imem.bin";
+					filename = "lpddr4_pmu_train_2d_imem_202006.bin";
 					align-end = <4>;
 					type = "blob-ext";
 				};
 
 				ddr-2d-dmem-fw {
-					filename = "lpddr4_pmu_train_2d_dmem.bin";
+					filename = "lpddr4_pmu_train_2d_dmem_202006.bin";
 					align-end = <4>;
 					type = "blob-ext";
 				};

-- 
2.51.0

