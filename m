Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9E43CA101F
	for <u-boot@archiver.kernel.org>; Wed, 10 Sep 2025 23:55:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4F9883257;
	Thu, 11 Sep 2025 01:54:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="G9U8AEkF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A994A833AD; Thu, 11 Sep 2025 01:54:17 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E54F83236
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 01:54:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N+KjisptQE7b9J5FxNKxqNJPxlp9yrpSeto9Q7wx7v7cwoZ8iRl1ggofX5VtL2oDEoXwTBWUGy1rUM7wqa7Ha2cK1d8vuyJf2jXteleTTZKi6nLorh8jrLwZGDk0kKuqrMoGjOYcHMIHhlVYRtPLgPGz0k/ZGEURj+6SQyT4jAKU/sFvykc5Rlkuczu8j/TToFnPz4rrbjBstT8LHS6eCr+M2Du5Nxsl8WK2MiIlQB7RBdjP5v/P3JpPtAEk0BdgeEvrfZOiXyhReqYamjSTxlB6jdojLjScI1Zxr6w2KKu8mQ1JZYHwSqgwqazL2hDlKG+k9HSj+Ci/hNAsoYM5GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2/4519YpOJP2FArMPW/CXF2AOGAkp8YnvhAEyGC2ru8=;
 b=qAnI8DCphrbKwBNRXfRwBEU5DHN28DJmjvGoE6JL7OPGBcHKFWmIt+njnamz0sbuV5ibudO1HtnG1wVZNA/5IGvUhRsUsHkZQonIePXixDKg2gHZVwDtExLmmj+K/GIcMNv2Fljtwjces8G6aaaEvdwXT0+pUN+8H5r+NeMNWouquRN8VZSTtJYixpYk9U0mU8UBOlDckH+2hpMfvQ2ZeLDossRALllhK4Ko5E3GG06fKBRL00MFoWE2ZWmQkBjdwTqv+sE/kyr9x5JSg6/Gk9hFt/Y9t6gp5RLeE1Vc88WvPVxOfhRLo/VFThbtpJIUgpfyypHvbQ2wtHp/oxADXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/4519YpOJP2FArMPW/CXF2AOGAkp8YnvhAEyGC2ru8=;
 b=G9U8AEkFhX/RCXn2O5TRtVg6ubFCNEmhOJJilfrIJr7wXzCFp40MHBQnfhAZ6sRPJ65Y2zShzFGNjDEpQmem/92Bk19RE83I0gbHW59ueqY9qXhUP+RpeiRX4kECMcCzZcJAc5DwQ09zMaqe953m/Kowlj/TJsrNJPT2GRFjGrWQrDf4XNC7fGLJvMeZT621cM7iSmdSvbFKjKYJs+0pAizpTGMNMsRYQ92Rb6eIGqLI96KxCmEr5R/MRzrZppLGskTuX/GeejdcSiYuJRrBEQYxjq1fTxIbeTXaTo69SeVwKd2uuaCcAQ9tYBodJdT1J6fZT0rQiipw8C5LRG99hg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PA2PR04MB10514.eurprd04.prod.outlook.com (2603:10a6:102:41e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Wed, 10 Sep
 2025 23:54:14 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9115.010; Wed, 10 Sep 2025
 23:54:14 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Mon, 01 Sep 2025 18:48:07 +0800
Subject: [PATCH v1 8/8] pinctrl: nxp: Add i.MX94 daisy register offset
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-imx94-v1-8-c85ae7cdd95c@oss.nxp.com>
References: <20250901-imx94-v1-0-c85ae7cdd95c@oss.nxp.com>
In-Reply-To: <20250901-imx94-v1-0-c85ae7cdd95c@oss.nxp.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>, 
 Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, Alice Guo <alice.guo@oss.nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: MAXP287CA0008.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::18) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|PA2PR04MB10514:EE_
X-MS-Office365-Filtering-Correlation-Id: 15c80157-fdca-46d7-2840-08ddf0c55869
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|366016|1800799024|376014|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NGl2a1VHVTl1ckgrRStlcE1yd2ZoaFQ4QlMrWkJERVcrK0txUnZQamdaaGRj?=
 =?utf-8?B?UFVWNUxKbW4zVVRRbWw1OHhVaHJndkpsTE5qVzVraUp4eDNSVzA0M3Z6RWwx?=
 =?utf-8?B?OExGWmZ5TXFRZjZldU90UFdhYUdtOGlwb0lMQnlyTUJMbHozSndHdWhpTEN4?=
 =?utf-8?B?WG5ZaFYybnNVc2ozYWJMUVZqYTVMcDIwa2IyWTNoNkorUFp2TFdLWUZ5YjVS?=
 =?utf-8?B?cjZhd1B4S0RBcnNFbzJHb2kxMHM4T1JBWHBPaTBoelh1KzB5SHoyVXFad2Fh?=
 =?utf-8?B?TTN1dUVjOXIxbXNiblFtYWxObU1veVRlNmRUMzZvNjl3V0RxTzdqc25UZTFx?=
 =?utf-8?B?T25KL1d4TVVTakJUMjhuc2NscXFoL2dRUEpWRkFGWGY5VmwzaUdPVE5TYmxo?=
 =?utf-8?B?dTlhclFXbEF1SzJhUmpFL2ZxVDlldm9zRFFBT2pJa0hFVVpMQmFtV01IWlg5?=
 =?utf-8?B?L3JPaHppZk5lanlIcnU5b2paTkgwVGF1ZGJ4Y2RNeWgyMGVMaUdyL0duM1FF?=
 =?utf-8?B?Z0Q3Zmx4MVZ5ZWJYSG1pdUU2Vndpb3NmbTA3QjhqQUdMYVQ0RnZzanJsRElG?=
 =?utf-8?B?Wk9uRTRoU2pwYUg3T2ZDc3d4QzRzTmpzcEVMQ2Y3QTRsRkZVKzZJNndGRm9R?=
 =?utf-8?B?ZTFqeFVqd3I3U1JIZmZncVZUQ3JmQVI2a3k2WWk0Uy9WWHZKNFNBMXdsM3FI?=
 =?utf-8?B?QjI0b2gxRnhvODNQemRzQ1plbmhpVUJKNmJOVTBIekxkT2NpSy9JbDNpYnI4?=
 =?utf-8?B?MjVlbGRvZHlrb2xlOFF6aXNLWmYySUU5aEQxa05oOFBCZWRldVBzQmY5eGtt?=
 =?utf-8?B?YUxTT2taNnFBV0IxWmc1dEVMa1lXMGZZTkR2V2NIV0dSS0ozWmhZNzZnbXNj?=
 =?utf-8?B?RUNXSWo1NUhzZ2g2MFZ5TE8wbmFXVW1mdXcwa0V0cjlSME96NkdLeG1YVkhj?=
 =?utf-8?B?eFZCVUFERHdGay85ZU5LT2p4RC9uYlBFdXJLYzA2aFNjOHZQcWFqdEYzYmFH?=
 =?utf-8?B?VHdZdlQrdDUwRzY3bkRNWG0xU2hGY1d2RXBCcGRMcFVncTMxaWpzdmhId3Bu?=
 =?utf-8?B?cG9RSG53Y1hIdFBvZkYwcjlkVHJZVVF0bmJBQjY5bXJSdkI2dkZZTFgyV1l0?=
 =?utf-8?B?eExMVkNWV3VqT0QwN0NpNzNlcEZJTVRRY0EycEpXWExJdnJITk9nQ2lqWFhx?=
 =?utf-8?B?ak9lSkpJcnRiOWo4QVplYjYyUDdkWHN1ZHVPZlAweGxoNnNmZGM5bXFwMnpP?=
 =?utf-8?B?bk1yWnFmeHZycmNINnR5UG8vL3A2c3JodTFHR1VCVjlHM01MeWs5WUNGY1BQ?=
 =?utf-8?B?VE0wQ2k4K3F2RWJaMGdMWC9JbEFEYkRsWjdGR3NiTTNZWVpsZk9IYkxrM0Z5?=
 =?utf-8?B?R0N0NytLVFNuTlppMHRwL3RFSkQrSm52SWZ6T25CbXR3N1ZkZVhZQm5XZGxO?=
 =?utf-8?B?c1FlWTdUMnR6cFdRdWhLc2JyeUczWUgzWlhMaHMzQzhoUmV5YitnM0RxUzhY?=
 =?utf-8?B?T3BEajJUR3Q2S3psMVZPZXdra1hrd3Y5TTRuQXZyZndWMjFVVDVrTDJKUXpJ?=
 =?utf-8?B?MzZlUVU1Q1BZRHBpa3ErWWhWMDY1KzJocXg4TTBnYktTMU1CM2x2SzdadFlV?=
 =?utf-8?B?NllJR2tRZDdzUEZpVjU0UW9ocUhlT0dla3dpVWVlNnBUVmU4M2ZtYnk4cWox?=
 =?utf-8?B?SStSaFJSNVBtcFVoUUQwcFI4UjIvRkh5L081QjY4OWFqbWpaUEJ6Uzc3MlZD?=
 =?utf-8?B?Q0lCaFdrSFl2SndwaUhWRWwrNkphRncyUFNyN28wUzV3OEducjBrZmhxQ3Zr?=
 =?utf-8?B?YWxXTSt5ZmhvclU5TDJpUkFFQ0lBeFU2dUFjRkNONmdFYzl6Zll5aHhzbmgw?=
 =?utf-8?B?amR5RkhMbk9Vd1B1TTdkL2tVZGR5UEhOZERLVVJkazQ5OGRTYjE2MlFEaC9X?=
 =?utf-8?B?aEhkNUw2WWwzSzdzT3FsVWFWZmQ2bzdlRFpoQlAxRFY5WjV4QkpqK0JjVjR2?=
 =?utf-8?Q?hEBdZEXaqa6wnfPeUJKkB9OqcVkyQQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(366016)(1800799024)(376014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2oxcmMvNUlFd2hrdk9YOVNXWkw3Yk52cVlvT1dnQ1NxYXdDUk00TVQrL3ZY?=
 =?utf-8?B?YVZtanJyWHRnWWtRblFRSXR2WElzRTZ5aldGWmVmQnM5MmdmbVdsdERJMW1J?=
 =?utf-8?B?d0FjUTdKN0hQY25qallpbEVIQmkzb0Z6Ymwwc1ByRlhJWGx3RnhqdmpjaXFJ?=
 =?utf-8?B?ZmIwbUgwWVViWHFYdy8yYUVMUldSNWNHZGtuSXUrblFBdStyTUdtM3ZCbU1t?=
 =?utf-8?B?bkhpUXFVZU8wMEUwZkhCTzVLcmJmUEFOcFNmZGErSE5GMjZWRE1ZejNKdkJy?=
 =?utf-8?B?UU1xcVkvWkxDeWNIUVFJeHBseVo2dWI5VkhaRHlLK1I2dzJmU2dsMndma04w?=
 =?utf-8?B?K2k1OWZ6SDd5MXdxSDNQZndpYUR2azBvY3VvZGRvSlpsUExFYWFzbWZQSkNw?=
 =?utf-8?B?ejBrMFVGMHJsOTd1bkUwQzlmMXlYSDZqcE83YVU4ZzBNS0NocWNTYlRhZU0x?=
 =?utf-8?B?NkdhRiswQW0wUVVQU0pLeG1lYU5Lc2JWdWEySzJSMFlsNFAybUY4RHBTU3Uw?=
 =?utf-8?B?V2Q5TTNEMU82Z1lTOGQ4d1pleFdodGZNQ3o0cnRucWVhY1FlSVZzRlhETHhu?=
 =?utf-8?B?bHRUSzhjMlYrWkRLT29MQTZRRkt6cjAydG5LL1ZXdGhHMkdueGFFZGdVU2hT?=
 =?utf-8?B?dHBnaUdzcFNpRTJoVE41OVpHNEpqM1BpWktvc0hTMHlkVncxaC9XWWJnb1hH?=
 =?utf-8?B?bS91S1d0bmVMLzNBcGg5dit3RmhONEpjamN1WStMcFZKbjhsWjIyVFg1SG5w?=
 =?utf-8?B?TndmKzl5NVBuSHBhNWxzUEpjb2NiQzBHY3RwV3lkZUxhR2RCOGNsdFQ4NHB5?=
 =?utf-8?B?Vnk1bjVYSGNJclpWd0ZwSU90N1RQbEp3VW43UkJ0ak4vV3ZGaVJpbUQrdVJr?=
 =?utf-8?B?Wk5KU1Jad215K25tZUpJcDA2QktaRkt4N1BvNVl6eUxVaUJmUlJkSWgzYnhN?=
 =?utf-8?B?SSsxY3pEVTRKdGg0cmpQeldqc09ySkZRR0dvRHUrVG4vT3JMRy96Zk0vNFR3?=
 =?utf-8?B?NUxuSzB1TWlYaWRWazlUbnI4NzBVM3JNWDNIaXJDQlJkTFFidUl3RC9UVjQw?=
 =?utf-8?B?aGNrSCtJcm5vTGxMMmhKTFU5NDltQUx4enp1clBOOFUwQVRYQlpkQ3Jtb0NZ?=
 =?utf-8?B?MWpmMDcrYUtxQklyK3pTMEJVMjBaanlCRlVhNDNDaWhlR29nYjZsbnFjVkNV?=
 =?utf-8?B?VXRGOVUyOElrcFR5UFVqV2lKcFphQ0Z6Q0VLaDBkN3prd3hMN3B5YWpKdnc3?=
 =?utf-8?B?VnNBd01YYVhnU0ZROTdEUTdSKytHc0dCbEtBWHpjaGRQdFRoR2d4ME4yM3A4?=
 =?utf-8?B?VzFYYzYrV0twejNMeDZrb2U2dS9RRGQzQ0lFdnNCTVNMM2RjTHgrd2F3Lzdm?=
 =?utf-8?B?b2ZIdWpGSmNQNVBlQ3lDQ3pxOWxCb0ZsTy9ScEJaY2VJcTIybVBxdG9NdGRh?=
 =?utf-8?B?OWFPbVBlTWZiYXp4b3JSTldrVlFNMS9rKzRjMWUvRUZnNHFSUFJrSGhRdUZM?=
 =?utf-8?B?T1JNYXhZYy9RQjl0TFYyMmJiYWU2M3VLalZKY2ZMZUNMQ1hjR25zWXY3Z00r?=
 =?utf-8?B?dFRmNVFCTG0yc2RXcTFBM3FzTlIrNHprTnowa2FUSzBnZTJldndLbjdMcUxF?=
 =?utf-8?B?ZC9ZenM0blhvOXJEN0c0eTVQWWNobkJsMDdxbGxFN1VsWFN0QXBhUzNEalVt?=
 =?utf-8?B?UEtxOHFvUFQ5M2Q5N1FyYUhKdDROQmp0T3V2djFmNUtoNkdCK21HaCtlcDFw?=
 =?utf-8?B?ZFp3ZVRIaytObWdMVWp1TFJCZy8xU01aTjZNT3FHdllVSEh6Qm5SNG13VTMv?=
 =?utf-8?B?WmVWcjFWQ2dmQmgyZm5iUzV0cEc4eG5STFdPeVBPODMrRWI1ZmhCMno4STFu?=
 =?utf-8?B?WjA2ei9SUnpCMGpoU09obHZLTE9aaDZEUzV1Wk9LR3hFcUo4dWZIN2l4akh2?=
 =?utf-8?B?d3BFL0o5TnJBZ2RCRmNuWlVjMzhkeHZuLzNFQ0toV3lYY2E4YllCN0o5OW5s?=
 =?utf-8?B?ZUNiMWlFUHJzK2hwd1hsMy9SeGVWK282Z2NqWUtMNmRqbzNvekVtUVc1YXpk?=
 =?utf-8?B?aEZycGhrbE1NSUhsNCtPMVhsTTRyMVpORm4wWlovL25oeGlPQzBGQnZjdjVk?=
 =?utf-8?Q?tTi9vvWs5dgO2N5SiaCHr8lQ7?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15c80157-fdca-46d7-2840-08ddf0c55869
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 23:54:14.0199 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OPiNyel1QygeGvUBcO+HES+YBa8+vLhwr4PGryP4wlImSpRivJDc6VYoF5RviN0Mz50k33Y20EaY0BDs78WW4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10514
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

Define the daisy register offset for i.MX94 at 0x608 within the iomuxc
register space. This enables correct pad selection for daisy chain
configuration on i.MX94 platforms.

Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Acked-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pinctrl/nxp/pinctrl-imx-scmi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/nxp/pinctrl-imx-scmi.c b/drivers/pinctrl/nxp/pinctrl-imx-scmi.c
index aed47be337d..781835c6852 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx-scmi.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx-scmi.c
@@ -16,6 +16,7 @@
 #include "pinctrl-imx.h"
 
 #define DAISY_OFFSET_IMX95      0x408
+#define DAISY_OFFSET_IMX94      0x608
 
 /* SCMI pin control types */
 #define PINCTRL_TYPE_MUX        192
@@ -133,6 +134,8 @@ static int imx_scmi_pinctrl_probe(struct udevice *dev)
 
 	if (IS_ENABLED(CONFIG_IMX95))
 		priv->daisy_offset = DAISY_OFFSET_IMX95;
+	else if (IS_ENABLED(CONFIG_IMX94))
+		priv->daisy_offset = DAISY_OFFSET_IMX94;
 	else
 		return -EINVAL;
 
@@ -141,7 +144,7 @@ static int imx_scmi_pinctrl_probe(struct udevice *dev)
 
 static int imx_scmi_pinctrl_bind(struct udevice *dev)
 {
-	if (IS_ENABLED(CONFIG_IMX95))
+	if (IS_ENABLED(CONFIG_IMX95) || IS_ENABLED(CONFIG_IMX94))
 		return 0;
 
 	return -ENODEV;

-- 
2.43.0

