Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 882B5C531F9
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 03:07:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9570C40A9D;
	Fri, 24 Jul 2026 03:07:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xPqzNhb5-lwk; Fri, 24 Jul 2026 03:07:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1E91740A5B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784862437;
	bh=d8hXwXr+s7Ayv57nH3tyhetQQKf1wSNoqwzvUB4THDY=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=DAMG9DNXc/utJKGsKT2mIXicNR7VUZTgS/GbKddZRzGvQpd40UO1zSqo5dMIZD6me
	 br40yOkuzK8/reAfjH6GRi5wuSiGla/TRMVQWY+mZ09d8CzdqJir3fVs08i8LX9nIG
	 JmJjTm1koT+upH102qVNPgG42bj9nBekL7IP0slUia7PseKQRTzKTvj6Vqy92utBgt
	 BPr1eeY94XWXffT4KMXUTCnBjj3J6FBmUco1dMUg40r8E+Q22gGWB4PU4t1vOFLf25
	 yrVT60yQEiJ/214f0ayP70YD8u0Meuhw368aZXffrYUBP3zy05Sw4c8QE0O/sXAKtC
	 x8QhZzJyB1gyQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1E91740A5B;
	Fri, 24 Jul 2026 03:07:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 64A572E5
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 03:07:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4A68840A5B
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 03:07:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vuNVycX1319O for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 03:07:14 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=alice.guo@oss.nxp.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 1198340A48
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1198340A48
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1198340A48
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 03:07:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O+Z6TZYHV0j5mizak3msQ7FSjfQfFaYb/Pa3jXTF4Ua0azG+dMixN/wwxoWvyJMiildzPzwFsQ7oFfWaIslTPDv8iqlxF48zF72M318uPuxIyqOfrCXB42IXHr39dNI5UIC08w68dlVq27vAPWNPVxb5nuELKwxUwLV8ko+OqHmvCEeBx8ujxqURPGuf5rYfy1YhxMB+fJpA+4rfsWDOCwXOJAQ572Z/XX8tWXjHfFRWXM8NYZz7GPU+X2kvt0/xAvcbsgz5WWolyUZDSNu+I339r/oSGIoziVEpVhKxpc6LakDV+u2xRdLVdVPVxDjbmPyA3yf78d8VZlLRorEz+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d8hXwXr+s7Ayv57nH3tyhetQQKf1wSNoqwzvUB4THDY=;
 b=NZoSmLnpfsaqXDkBWHB2SHg9MspDl+XxXUazewx9AIfaibSMDTq40uhZ5SwK0btSR+S6jvpTYKkeyTxGr1K72bbXyVKFOcn5W36MYg20FTqpC7/hd0DAFxOxe4WlISuQe66bPEHAz3o66+1AeUHnesAYJjw974bsN9CAdbEp27DyIvE9ANevy/hE+iNe78lCs1FUQ+mcvk/nPfsa9w0f6aQFxbvzHk3QTzBbNoxNe28EEbMzOcMA19R5T/FknZeZaPFKue2qhqlBKirTWKSJHokGH0NXif/DMqMz1fhs9EAfMKyDPhnk075adM3WFaUi1UXm31FA/glA7zlJhloxNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
Received: from AM9PR04MB8114.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::22)
 by GV4PR04MB11749.eurprd04.prod.outlook.com (2603:10a6:150:2df::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Fri, 24 Jul
 2026 03:07:08 +0000
Received: from AM9PR04MB8114.eurprd04.prod.outlook.com
 ([fe80::cab0:e4b0:6be:b1d1]) by AM9PR04MB8114.eurprd04.prod.outlook.com
 ([fe80::cab0:e4b0:6be:b1d1%4]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 03:07:08 +0000
From: alice.guo@oss.nxp.com
Subject: [PATCH v3 0/3] net: fsl_enetc: Add SGMII 1G for i.MX95
Date: Fri, 24 Jul 2026 11:10:42 +0800
Message-Id: <20260724-imx95-v1-0-7131a9e17fe1@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALLXYmoC/yWMyw5AMBQFf0XOWhPqFX5FLKoursQjLdJE/LtiO
 ZPJXLBkmCyq4IKhky2vi4c4DKBHtQwkuPMMGck8KmQqeHZlJrSKZap00qo8g283Qz2771PjTND
 8zh7tRHp/B7jvB7bK4QltAAAA
X-Change-ID: 20260724-imx95-ca124ac3ba65
To: u-boot@lists.u-boot-project.org
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>, 
 Clark Wang <xiaoning.wang@nxp.com>, Marek Vasut <marex@nabladev.com>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: MA5P287CA0156.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d7::12) To AM9PR04MB8114.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b7::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8114:EE_|GV4PR04MB11749:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ab40a58-4402-4e1e-6043-08dee930a57d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|19092799006|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: bufRGDvhbxeckeHgHdKuFANhxJVWHi0qLCx8f4ZUxl9D77im/sGrYmhQN1GWxPJcXv3oGU+rMDbldPvaKjeE6cg1TDV2VjSCDvWszbcIVfBEjrEXKioXPcdcX+gJzrV1fYcf5hWaw7cyrNDqQhcdQ9YXOv4Jyr+4tcflKoHMrmaufLukqU4V1YTz5I5i/iwmwY4Yaj7ciXsvz4vCu0Vknnw59smcFMhPrEplShuTmoS6nZSVYX2ltYD1AuXHWOMTB9lBpB4kJ6geNaRbjcpMl5kjXHXX62CxWgfV8+YAGifpgMZD2YTR2SqOz+2iy5NvQDcTEWpESQ18URmXcr0kJ+4HBASnOeJ6L8JhV5wxRC0p4cEtCCiglg9FRELPFxxeDjv95NUBWruWiH2DRLQKW8aEWBhYHBNPW+E70KDVcoaCdGja/EiovbY8u3ODYeKj0BBrGMf2BzJp0vdtbUWi7vuEvXYLiqXp+qb1BUcOpeFMg2AVR4Etjk7vzfXEjUNgspBPkiW3sow0Wwk4SZZfrnd1vUe8T5Zp8FhjE3VwF2xELdAiW5NNsGSDm9tCrw1bJ3hbn14cy4IBETjspTd7tMTch0aS9pbXo2G5Dg4gVnQsxb/t7sVggOcZYSXxsBCJXprvlgGzLCybIuh4zKUBQu1yln6ZMMbG/FaXeeFNpKI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8114.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(19092799006)(56012099006)(11063799006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mk5VWXYrM3dFakVheU13RGNaSnpybElqUXhZVmdjRjdPdUhJUXpKVG0vUm13?=
 =?utf-8?B?bG5NeHc2eW5PWnNnU1BmNzNwZm5aQ0Zsc1oxZW1pS29mdlRTbmVGMjYzSzNL?=
 =?utf-8?B?NGx2R2tSYzdGWGh4ZG5hSmRxVERhZzdYM1BHSHlHN2ErSzhFb1p2aG5uMkNq?=
 =?utf-8?B?Q2M2WWhZQ3gzMUtLbGJmdFhCaWVoTDA1M2E0OTljMzhGeWwwcGM5bkR0dWZJ?=
 =?utf-8?B?K1RzOHhJd1RaczZXSjd2ZFphaVdqQ0d2a0lETjk3c3Y1Y3N6R0dmdzZaWVhu?=
 =?utf-8?B?Wjk4aFNkZVltbW9EVmVPMVNMMDExYUxZbkJZWENCWEloMWNlTis0QU9VWDR0?=
 =?utf-8?B?UGQyc1Q5QmJROUszcjNvSDhFaU5hRDRoUHJxL1lqZGdhVGVsRU9WNWZlNjIy?=
 =?utf-8?B?MEJDYzhTSE4vWE45SXI5UDBqUWVjMzlyS1ZWNnE2dGdSMElsZEdsVEo4MFVj?=
 =?utf-8?B?b1VsUi9iUW1uMENoMHhLcktCSXl6YjZSUDNpYVVjenZkZUFlUHUzZGYwQzFN?=
 =?utf-8?B?Tkh1R2VRaVhQa1pGeFdpUGNybnFXdnowbDZlOWoxWnNWenZZM2ZmNW5tK0N1?=
 =?utf-8?B?ZGhUdGlSdW5YZy92akdld2FFenU0UEtSWktWUjl4RGZqbkllc2YrbEhRd1Vk?=
 =?utf-8?B?Nm56QnNPVEthSXZzMmFNNC82YnBCWE5CTlNXYlFyRUZzK2FzbHQ2eFZ3QWJs?=
 =?utf-8?B?dVJXSU5lUmxHTTNoaW0yVFd3Si9SYkZXQS9wNmZGalBIdFhvLzY3YVJGS1M3?=
 =?utf-8?B?eHBUR3h5WVoveGJucmZ2cDk0UGZxK2NPVWVRK0N4UE1UQTlCcWU3TWg5S0h1?=
 =?utf-8?B?M3ZtaENjNHlQanJaSGYwLzB1akExcE82UWFJUmF1WkN6ME1mNnVHZ3pmRk4v?=
 =?utf-8?B?SUFpR3luQmZWUUc2WGNtbE5jMVFLYW41ZVRzc1FXNTM2ME5hc2hXQ1ppN29v?=
 =?utf-8?B?ZnFSVE5iaCtRL1B3alRRWWR0dTRUekRpWTVUSVFON0JIZFRhTUZxT2dxS21S?=
 =?utf-8?B?MXN1MUVMaWs0aVN3VTl5d1IrbGIreDNUOG5CQ0pwQWtnQmZXTytWR0dXd3NG?=
 =?utf-8?B?amRUbm9HNHo5U0VBV2kza2NGWkVnVTlYL1lCWndYWUpPRmNHak5jMzg4cHo0?=
 =?utf-8?B?MStOMGZKaGhWYlVKWXNEY3NLMmhpeTBKb0hlK3gxWk9CQzZQZ1hDVGtaRHI0?=
 =?utf-8?B?SmI5dUg4WkFyN1lZVnZEU1V3SC9Xd0V6dEJDMzhqRW4xeWdjUEs4MWl1Wnkz?=
 =?utf-8?B?OHU4a3ZMNjFjVWp4dXdxbjY3WGMxVlBvZ3d4SDNPTDRJMEJpY0xGa1J4Sm1C?=
 =?utf-8?B?bnRzdVd4b2JlYmNpeUNFQi9NZVMwNmFrcGlnMnJXMFU4REVsL3F4NUpreWps?=
 =?utf-8?B?ZWY5czBkUWVnUFVWM3JJeU5xdXEvVHl2N20vcExMSW1vY2dkdDJwV2V4MTcz?=
 =?utf-8?B?VEhTQ0I2L1I5Z0puc0lpT09sMVBsQTFoT0ZOZjA3MUVRWjg2V3cvMGJ1MHNZ?=
 =?utf-8?B?aGxFRE5mZWJvRXJOTDJBUGRDd01nUnIyaVAvd0hyVjBCRjNzRVg1MWRCdmcv?=
 =?utf-8?B?a21yeEtjMU9WSDE1ckV6SW42d1VkYkJnZHdNUHdodHQ1Z3RYNFZra3p5Tzl2?=
 =?utf-8?B?eCtpY3BISkEwRXhKd05rWVc4VnBrY1dWZ05SUEhqd2ovbGFEM0xBbnRaZ3d4?=
 =?utf-8?B?MFFvQW4vVEhYaVJaNUdKZml5UW5zVk9GU0xVYTRHTW4zbUZvT2htVklJUllF?=
 =?utf-8?B?RHJrMy8raHRrQ2lwdW5VMlZRN2RibFNQbzBsUFB1aWJJZXBnQUFjM01UZnhN?=
 =?utf-8?B?SGxOWEpnTWZBSlBFSzBDRDlqME1KMGxyOVFicDNJdTFHOFYxdzNHTTM0MDV4?=
 =?utf-8?B?Tkw3WHpHLzBxbXpSdTF2YStvK1M3WERwMVFmUUVrS1huRkZXY0VEMkVkbzdi?=
 =?utf-8?B?cksyeXN3ZjZQb2ZHeFRONnZXUEF2UmovSXM2b21VdzlUZ1dqcFMxYXNUdDM3?=
 =?utf-8?B?dGJIWFBERU5WcnVKQkYraEI0QVdrNlpIK3EwazU2ZWxqSC9tTC9Yd0Y3K1hU?=
 =?utf-8?B?THhycDJoMXlCQWlPbm5CUk1nYXV1SmE0TGlnVTZUS09PUVp1dWxNYWpzZU51?=
 =?utf-8?B?NWJBaUJaK2pTamd3KzNyZ2NFSHkvbkJaa0ZzZWxOUitGTWdEUlVCZW9aeVFS?=
 =?utf-8?B?Y2tPZCs5ZzA0Uk9EUXJic1NrbU96bzlIbm96T3dpWGZEZWVvNGY4QWgzRjNw?=
 =?utf-8?B?RjYveWJaZHdXa0VPak9iV3NsZWJ3ZlA5a3BPU3NxNlFkVThZYVhvc2dlbGt3?=
 =?utf-8?B?Q1YxeVJRb1c5UHB6Z3NZbklnc2ZPQ1ZjU0FsM2c4eWRqRndwMkZtakc5a2ZW?=
 =?utf-8?Q?dgtSg/AcPsbdPuRTmewaIOvMZ9rnJC9ZVoDCV?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ab40a58-4402-4e1e-6043-08dee930a57d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 03:07:08.2064 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RIEW3rdXT8/VqaaXhTRoE7qghIjZS20pXY8IPyD+CVCwQCVguuFrOUJPWLwzy+X9V4qZBHw+bu+hiJb9JZDiNb23+TDIPppWFHBDlf6qmbt36+lOGAkgXjZHqXzw3j1T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11749
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d8hXwXr+s7Ayv57nH3tyhetQQKf1wSNoqwzvUB4THDY=;
 b=d3g/E6Uly4OFBksnOkmUoAsDlqdLwggziMvi9KIZDcgyC3o3KEvPTGz/A2nUUCUinPIxQxaA8d//09iiFN7ePrhAxaAzPjCyDElaLtAwR1SEA0HtFc4RK1X/6KQu6dcIa17wclxESLLy7/uQDiJhUZ2wQJLbogCBlC6W8eGAvH3dg7Z4KnMRtVk97AKawJ/NucdfdkwXjFadUEDT51OaCCcu21/783nAmzBYUu2OEhDYRdRtm5k3X93bXVCeaeTU9xQwv1TB8YIXpNxIdTTHckdL3oTKETTEEXZg+jk8dLcYVkunFZxq36zq/W83gKGk9oybinv3nVSkBceKHHbvVA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.nxp.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=d3g/E6Ul
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Changes in v2:
- Fix CI build failure

Changes in v3:
- Replaced #ifdef CONFIG_ARCH_IMX9 guard with a runtime wrapper
  function, improving code cleanliness
- Added explicit 1G-only PHY capability restriction for SGMII on i.MX95
  (no 10/100 support)
- Added a new public wrapper xpcs_phy_sgmii_1g_config()
  fsl_enetc_xpcs_phy.c for better abstraction

CI: https://github.com/u-boot/u-boot/pull/1019/checks

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
Alice Guo (3):
      net: fsl_enetc_xpcs_phy: Extract common PMA MMD init sequence into helper function
      net: fsl_enetc_xpcs_phy: Add SGMII 1G support for i.MX95 Ethernet PHY Wrapper
      net: fsl_enetc: Add 1G SGMII mode support for i.MX95

 drivers/net/fsl_enetc.c          |  20 ++
 drivers/net/fsl_enetc.h          |   1 +
 drivers/net/fsl_enetc_xpcs_phy.c | 700 ++++++++++++++++++++++++++++++++++-----
 3 files changed, 639 insertions(+), 82 deletions(-)
---
base-commit: d7ef23c07b8e34f65b3e15e3b4e7f58d074923c8
change-id: 20260724-imx95-ca124ac3ba65

Best regards,
--  
Alice Guo <alice.guo@nxp.com>

