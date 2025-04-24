Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45273C369D5
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 06:34:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F12EE80F9C;
	Thu, 24 Apr 2025 08:34:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="N1ytKhox";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D853F819FC; Thu, 24 Apr 2025 08:34:04 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B42CB80FF7
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 08:34:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=evzY47CEsa6dD4iso1aHTxMbnMomq1/cWcKwHrPRFDgP97o4vBdNSE4G5UwrbTMkYqnZwcKU7cdhFcZhxwdNAPoszBtoCCRRXN2lbUPY2+N4LesIYdv0TH3c7u5Vn+iEXzHmKxK92Ci5FND+vresSIc87ta4z2R6UcdbTVmcKhiyA86JaI7js41Sdqa6OYY3CtTTsVfOEVpj1DhyQ4efvy/bTRHlffFsY9HP1FTlS+PQy4jTfrqa52f7jbTpHktul1kIdIW7yrpViJj8ENB8F0ZGG2NqfvVcVtEO30h3O9VpEqUPXHpc3mRA0SNXAXjiaXzgg11BkH+NpWFn1xr6zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P9bgJdxApWO0OK5m2ceaNl0WHVX+MUokdfxvbc9cgBg=;
 b=PZDXcJ7ii/iOAJ09yiCbZwgNkXmWeH3wt+DIaj0xDZX39AbEBUJiShvIWeG/qlR8j+3Z/r7hPZjhVNSIXhKWggleSYTu3N+6EBLQfYM/GOGAvM412rPetjntyJE/EvuB+elen6Q/w/T3oMbAKNWSSNxU8lJFpgJ+UvvakNyKEFggeiKCGeIdYYu6M7EZpYTzDiA4HlrWQjtCuvfn8x6snQyqCFaAGfC+OOkBEZgSGR7NqjCLRSauMBq3BStmZYxyYZjwYvijTHvlTrB55PLcLGpnYfY08PMII/xl/NYQWPfJyEba7JJcaikqu06leFYC2JSwyMC8WPNZI/zGE3+0Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P9bgJdxApWO0OK5m2ceaNl0WHVX+MUokdfxvbc9cgBg=;
 b=N1ytKhoxQAl3A7gwzGV9ZIPo1wdpWsrXYf74hfczgMOLN/3cFQBZ1S/PvgtLGcYuHTIYMltjmxuLY+OjfqdGJz3E6XaIyxjNjWbCWh7ZIgLARAG5ws/ahFyuwmeMt7DWimLjRxn/jY0bmKxuA9nghFuA1aSCVJ3VkAGM7b84SsolEypD0x/9t4BpfniEAq2vOfegvOEv0WA8Dld0dbfd/NqyECLv0J1uTHW0OaD9E7w4V4PTo9nm41mhTxjYqANHHPG4OAtvHO8QECOEmIc/Yw+Vdpu7j4v783I075t/gDZwT83AgWCya5iY/zBR9aOTURLLZjtoUegyN+BrSESezg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DBBPR04MB7738.eurprd04.prod.outlook.com (2603:10a6:10:1ea::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.24; Thu, 24 Apr
 2025 06:33:59 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 06:33:59 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Thu, 24 Apr 2025 14:32:58 +0800
Subject: [PATCH v10 02/21] firmware: scmi: use scmi_proto_driver_get()
 function to get SCMI protocol driver
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-imx95-v1-2-10a8449b1e5e@oss.nxp.com>
References: <20250424-imx95-v1-0-10a8449b1e5e@oss.nxp.com>
In-Reply-To: <20250424-imx95-v1-0-10a8449b1e5e@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SG2PR01CA0140.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::20) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DBBPR04MB7738:EE_
X-MS-Office365-Filtering-Correlation-Id: 03a66e5c-e31c-46b6-dd04-08dd82f9fecd
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|7416014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c0xPWVduVlJCclY2Mk9yR2JCUXg4dVdGSjR3NTdpd0pTSFludzFPNFlON3lE?=
 =?utf-8?B?MWdzNkxOMm9PWUtKZWxjanUrRXZqTm5HQlFqaTc3bUs4b1NKQ1l1WUF6eUpt?=
 =?utf-8?B?aS85ZWpNZjY2dnBQdjcwdmJLSHBXdEdKUmpJbmdJL0w0QlN3ODNHbzZ1UWZs?=
 =?utf-8?B?cDRSb090OTV0dTlwdkozZ1NpMFBNSWN4cTdGRXloMFRMQ3lyYmF6RlBlRGJT?=
 =?utf-8?B?SUdqZ3phTWNwU1VNRi8yZDFjdEwybVdodThYd2VEVVNybkwvU2xOeFVLcnhL?=
 =?utf-8?B?MytDL0xPcGhrUW1lK3R6QjVpMWxYaVl0RHplMzUwTXRpQnlRSmNtRjEvcEVs?=
 =?utf-8?B?aGlRdm8xRVF4Z2YxYU4rekFkbGFqL3R6d0NTdU8wWDdHZWl6QlpKdUlWUlZ0?=
 =?utf-8?B?VU5hSng3UVN3V0k3ZnlLVHZya3ZPQmpoTnlnM3JhTDNsRU5NNmltZjduMW11?=
 =?utf-8?B?NmdDcTdLaTl4RktmL2cwWHZreFBqeUY4SE02TDRpM0cwdWJhMTJVUW5kZzBj?=
 =?utf-8?B?TFFQSURBYTlMNVhUYVpadHN4KzBiZzgxeHdCVE41WWVVS0ZzWm81dDNDL2Fs?=
 =?utf-8?B?RXFUNjU5M242YVlSeFV0OEhqcUV6NjJpNExSUFpPd1Y3NXdiNEgrNEl1cytP?=
 =?utf-8?B?QWgzTTZEdVJsNVM5dTRUM1pRdDdSVXUxT0xCQU4zb1crb2k3MWxUUnhGSnFB?=
 =?utf-8?B?dzNCSkZuV1hWSUlZbERHRjRoSFZ3d2U1c2tlM0haNDZ1UzdkV1VvbXNyR1Fx?=
 =?utf-8?B?YmVaN05iMHVyNVVJSW1EdWN5OTFPLzFwTk9BREQwT3krZFp1cWREMTYzODEv?=
 =?utf-8?B?Ull3VndsSjFySmRldEZTamNDaVpray96QjV5cUl2Ym80NTFrTGszSmNSZHZF?=
 =?utf-8?B?ZjRhemY0MFJpSDhrMW1uTnR0OUVDZWxaVW0vTUp4K0UzeGFJS01ZejBCbC9C?=
 =?utf-8?B?SFg0TE5Lc2NPYVFMSklFSjlUMFordkx3aVJtUmNHNmZNNGZKUWhYamRrdEda?=
 =?utf-8?B?SDhobkJCRDRqWVZGemZJZCs4ZlU0QUJtdVRqbTFKaFVLQU50a3pDZ1dsV2Q3?=
 =?utf-8?B?VW1BR3paeGd3U1BrdzFOL2dSOEwrelhMRnVUY3g1Z1o1dVgrS0ZmQ3BuU0w4?=
 =?utf-8?B?ejJOSktkYithV1UwSWs5Uk1iM3JBNHNMdHhhMUVHNkljK3RCQmF5eHFibEtJ?=
 =?utf-8?B?RnIyY0kyNHc3ZThINDNQcmtjN1ZpSWtCb05yNDJjQUNvSVNxRVpWUVpITld5?=
 =?utf-8?B?eEg1akMzUDhyL2FUTUJvUlJZelhmZUNlYmdNL2tpQ0ZFRDlrOXNQNnB2SVh0?=
 =?utf-8?B?S3JkYTVteWh6RlRVcHVZY0w3bHluVGhmYVVaNjF1NEptR3M2ZTU4cjZ2ODlr?=
 =?utf-8?B?R1VhQTNyQ3hmN0lGaU1NYXFxUDJZejZUQUoxOEdPQlZBK2FZYUZvK3JScnlW?=
 =?utf-8?B?OGZTY0U1KzkwMk5KUUV0SlBTRGFwUW5qaFYrbzZLajMyb0RhK0tYbVVrOUor?=
 =?utf-8?B?UGlsQXYwellqU0RiUVdQVGVlK1BwVSt6SWY1b0ZHdy92UjVQQkJ1Nzl3VjN2?=
 =?utf-8?B?SGRIZFpITVpjc1hreVBnNGU0VHlMS0ozRlR2RGdkcEJVUmZBeHI5dmIzbFoy?=
 =?utf-8?B?OWwxbDBQVGExdUhaMmlweTljMFdlRi8vTlRpRUJGTDRGamlMZUYxVUowYnVW?=
 =?utf-8?B?NlEyNnpKYjdIT210cWZOUG41S0xZUlRkSnVHM0lUS3JLc0RDc1RNU21EL3FV?=
 =?utf-8?B?dmR4aldwSTBTS2plM2ZBSDFoRGlBVXE2M0JuaTZ5ZTAyTTBtZmtESm5SNndT?=
 =?utf-8?B?aFJkMXZPUkpBQmkxVDl5TTR5aDdYb0pva0hnVk5JT09Kck5BQTA2UkpBekxo?=
 =?utf-8?B?RnI1MG9WZ2EyNXVqWnpJNm5FNnpOTXRobkZJVmViVEQ2N3g3RGlwRVhsWlhs?=
 =?utf-8?B?cG8ydjRhbk9mSStWblhXc3lDOE56WVlObTBFKzh2ek52SFpUbHhrY2doejlE?=
 =?utf-8?B?bEFwZ3RZak9BPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmhOQ21jeTVZczI0QjM0NUQ0azNMem0zWjF1YzkwTFNyK2hnb2RXM0J0Yll6?=
 =?utf-8?B?T1BMaGV4OUd2eDVpK0dvcXhPRW5GeGFIdVpYUUcyV3o5bDZhYjVuWlpkVlZy?=
 =?utf-8?B?TVVON25GdjF5aWNueE1aaUpTV1RjbkFET3V1ZDZGb0lsaWo1dlNIRWRDbktv?=
 =?utf-8?B?UjFoVkRoeXNNcDlJQ0F2WDlCM3NuMFlCSG5WbHFMSGxERGN3MHFGdlZNSll0?=
 =?utf-8?B?Zm5ZYlRtV3c5M2RmUGxDeVQzTytEYzFDamM0OWVxc3B4SkFZeU1OQURwbzVa?=
 =?utf-8?B?Vk93UFlCWWxJOXlPNFp1K3lPSWZxTGxlSkhBbE43dFQvK1Zuc01DZkFxdFQ2?=
 =?utf-8?B?MW4zMzcwNHJWZHZRNzZUdTYxTWQza0hzWEVtUy9NbGlySUlldWN5NVlxYXFB?=
 =?utf-8?B?Z0hUWVZwUkY2NWJQTVIvbjlWZlFlUjBFdmN6dUxUaWlsZ0ZlOVBtazNkaEdI?=
 =?utf-8?B?TVdlcWxDWDkvVXM4Z3dtaXQwQURkRFphNVlDUkpXT2Y5UGUrSHJ3bkwvdU1m?=
 =?utf-8?B?SGFXZ1R1K3J2UzRNRmU2clVIZlE5K3M5TVNUNlRTT1IxbW9USzh2YXlqbGtj?=
 =?utf-8?B?RE1WNk5XbVZoZjFWNTdGTXl0S2tna2dZMDJkbWJHcDM0bXpRUmNOR3RYZ0Fu?=
 =?utf-8?B?UGpLcG1kZE95ak51bTBON2RoVmxNN2tlN0k3b090bWRmNVVlTndyZU5WbENK?=
 =?utf-8?B?SG1YOFdaamNsWFlQOFJ6T3FXNVh4a01XaWFsNi9td0t6RkJtdGpjdFg5RFZt?=
 =?utf-8?B?WG9oTjlSOTA0bFowVDJLcWdheWZISXc5RkZsOGNnQzJhbm9zSkRYakozSTV5?=
 =?utf-8?B?OXBKeWMxdjNzdXVkaDN1bGJrYW1iODhFbGR6eWprNUZhYW8wN09oRCtaMDFF?=
 =?utf-8?B?WUdkVjBnSFlYTjBNU1hZTVdtS2p6NGpJTklVdUdXSUFWOElETzZhZFlUdi9T?=
 =?utf-8?B?R04yYU5YUEdYYjU3WUk2NjZUOG1nT0ZFY2FPcVphdy9IL2MwMkNXVTMyd0cx?=
 =?utf-8?B?N1Q5emsxMzR6MGREL3NJdkZDYTlBSXg5ZURHNWpFNEtSb2hKNFJsTUp3Yis1?=
 =?utf-8?B?a0FGZ2FMV1YvR2tkMVFPUDJiTGc1bXpsL3dERkppZEFCcFlyem1IZGgvRG5I?=
 =?utf-8?B?RGhzYUREbSs3dWFhcUVxWnhma3NWRU9zaCtvOFN6bUpzYW5odVM3cmdBaCtJ?=
 =?utf-8?B?bFZnaDJCVjI4UG5uYm9DeUJkTHdBeVJjTGNCcXphTnFsOXJaRWJxMUUrVHE2?=
 =?utf-8?B?QngrQ0JiTllVQitCOUtML0xnaUxPVFIxTzY4NGxWTHNzb2IrdnoyTHhGTzl4?=
 =?utf-8?B?U0xrSW51aVhYRDBaUVFBOHpBeFlBRzY3ZVVTRWVnUHBOY1QxSFpmRy9JdjFJ?=
 =?utf-8?B?VVFZczNFWHUwMC9yWTZsazhHa1NrWE81RmFCb1RwRzM2WUhMTWpJbkd6V2Jl?=
 =?utf-8?B?MXNOakNGNVl2RW1YRU5QV3pEbUZkcTlUSEdEYnMyaVJNcTFjUHlNTWpHZWJm?=
 =?utf-8?B?aE9ZbHcvRGNOZFViQXZpeG5xc21lVy9MUkF4VE9Ra2tOT1FTSU4zODNBR0Y2?=
 =?utf-8?B?RVlSWUIyYXp4bU9UOTFwSHN0WTArcjNhbTdOdXVaNkJES3pGU3pUUFhkd1Np?=
 =?utf-8?B?dmZKTWtNd21hS09CTTI4NFhZc1ZCNVQxek5OVFhsZDRyakpWaVNCMGJMekJE?=
 =?utf-8?B?MU1jZHFKSWtSN24xVzdPTkxLeVVoQ2F5cXd5U01rTjZ2RzVuZzQxeW5PU1Jn?=
 =?utf-8?B?c2EvQmN4Ulc2MEh6TlAzV2ZvdnVmK3VSK3hNKytkejJwbkUxT1RCR0dNWmFz?=
 =?utf-8?B?Q2p0dk9KcVhITWVXQm85Tkx2ZXFJUG9XaGRwUlA3L0pyTkdDYTlBUTAwaC9p?=
 =?utf-8?B?cHVNV2pEQk5Pam1rTUh0VTljTzV3aXpXTG9OWjcySndzaG10cE1jN3VaVUpp?=
 =?utf-8?B?a3B0bDNnYnVVTWJ1VmdsSGY2QUdqRnRLL29KYWZ3M1h4czBZbkxtWXRKcUhm?=
 =?utf-8?B?VmV1Yy9xSjBQZFZ2US9KWGl0cmJrZG9jUllHZ1pYckdBdlZTRkdHN00yUkFI?=
 =?utf-8?B?TGdEN1N2R3NYYWxpb2lpMlpvOGxYWEs0S1prenVNRzRDcWF2V2kwYzB1RjJs?=
 =?utf-8?Q?LMvhAEl2uouUhrUZE/KCEEalW?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03a66e5c-e31c-46b6-dd04-08dd82f9fecd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 06:33:59.1334 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yvyny6PB7jaJJkJZSxWRIp9EMwrGv/50nk2RoMt+kK+EX0hTmVBliOKB4wGxBONpg85yM/0gwKuCTxtqa8m3Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7738
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

If there is a SoC specific SCMI protocol driver, using
scmi_proto_driver_get() function can avoid to add SoC specific code to
scmi_agent-uclass.c.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/clk/clk_scmi.c                    |  8 ++++++++
 drivers/firmware/scmi/scmi_agent-uclass.c | 28 ++++------------------------
 drivers/power/domain/scmi-power-domain.c  |  8 ++++++++
 drivers/power/regulator/scmi_regulator.c  |  8 ++++++++
 drivers/reset/reset-scmi.c                |  8 ++++++++
 5 files changed, 36 insertions(+), 24 deletions(-)

diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
index e42d2032d45..b8d40cc9653 100644
--- a/drivers/clk/clk_scmi.c
+++ b/drivers/clk/clk_scmi.c
@@ -8,6 +8,7 @@
 #include <clk-uclass.h>
 #include <dm.h>
 #include <scmi_agent.h>
+#include <scmi_agent-uclass.h>
 #include <scmi_protocols.h>
 #include <asm/types.h>
 #include <linux/clk-provider.h>
@@ -191,3 +192,10 @@ U_BOOT_DRIVER(scmi_clock) = {
 	.ops = &scmi_clk_ops,
 	.probe = scmi_clk_probe,
 };
+
+static struct scmi_proto_match match[] = {
+	{ .proto_id = SCMI_PROTOCOL_ID_CLOCK },
+	{ /* Sentinel */ }
+};
+
+U_BOOT_SCMI_PROTO_DRIVER(scmi_clock, match);
diff --git a/drivers/firmware/scmi/scmi_agent-uclass.c b/drivers/firmware/scmi/scmi_agent-uclass.c
index ea79cfa0cf2..cc3f31d881e 100644
--- a/drivers/firmware/scmi/scmi_agent-uclass.c
+++ b/drivers/firmware/scmi/scmi_agent-uclass.c
@@ -425,31 +425,11 @@ static int scmi_bind_protocols(struct udevice *dev)
 
 		drv = NULL;
 		name = ofnode_get_name(node);
-		switch (protocol_id) {
-		case SCMI_PROTOCOL_ID_POWER_DOMAIN:
-			if (CONFIG_IS_ENABLED(SCMI_POWER_DOMAIN) &&
-			    scmi_protocol_is_supported(dev, protocol_id))
-				drv = DM_DRIVER_GET(scmi_power_domain);
-			break;
-		case SCMI_PROTOCOL_ID_CLOCK:
-			if (CONFIG_IS_ENABLED(CLK_SCMI) &&
-			    scmi_protocol_is_supported(dev, protocol_id))
-				drv = DM_DRIVER_GET(scmi_clock);
-			break;
-		case SCMI_PROTOCOL_ID_RESET_DOMAIN:
-			if (IS_ENABLED(CONFIG_RESET_SCMI) &&
-			    scmi_protocol_is_supported(dev, protocol_id))
-				drv = DM_DRIVER_GET(scmi_reset_domain);
-			break;
-		case SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN:
-			if (IS_ENABLED(CONFIG_DM_REGULATOR_SCMI) &&
-			    scmi_protocol_is_supported(dev, protocol_id))
-				drv = DM_DRIVER_GET(scmi_voltage_domain);
-			break;
-		default:
-			break;
-		}
 
+		if (!scmi_protocol_is_supported(dev, protocol_id))
+			continue;
+
+		drv = scmi_proto_driver_get(protocol_id);
 		if (!drv) {
 			dev_dbg(dev, "Ignore unsupported SCMI protocol %#x\n",
 				protocol_id);
diff --git a/drivers/power/domain/scmi-power-domain.c b/drivers/power/domain/scmi-power-domain.c
index 3cd0f075d95..e8c0ba8878e 100644
--- a/drivers/power/domain/scmi-power-domain.c
+++ b/drivers/power/domain/scmi-power-domain.c
@@ -11,6 +11,7 @@
 #include <power-domain.h>
 #include <power-domain-uclass.h>
 #include <scmi_agent.h>
+#include <scmi_agent-uclass.h>
 #include <scmi_protocols.h>
 #include <dm/device_compat.h>
 
@@ -190,3 +191,10 @@ U_BOOT_DRIVER(scmi_power_domain) = {
 	.probe = scmi_power_domain_probe,
 	.priv_auto = sizeof(struct scmi_power_domain_priv),
 };
+
+static struct scmi_proto_match match[] = {
+	{ .proto_id = SCMI_PROTOCOL_ID_POWER_DOMAIN },
+	{ /* Sentinel */ }
+};
+
+U_BOOT_SCMI_PROTO_DRIVER(scmi_power_domain, match);
diff --git a/drivers/power/regulator/scmi_regulator.c b/drivers/power/regulator/scmi_regulator.c
index 79db1a6a8aa..7d2db1e2bee 100644
--- a/drivers/power/regulator/scmi_regulator.c
+++ b/drivers/power/regulator/scmi_regulator.c
@@ -8,6 +8,7 @@
 #include <dm.h>
 #include <errno.h>
 #include <scmi_agent.h>
+#include <scmi_agent-uclass.h>
 #include <scmi_protocols.h>
 #include <asm/types.h>
 #include <dm/device.h>
@@ -202,3 +203,10 @@ U_BOOT_DRIVER(scmi_voltage_domain) = {
 	.id = UCLASS_NOP,
 	.bind = scmi_regulator_bind,
 };
+
+static struct scmi_proto_match match[] = {
+	{ .proto_id = SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN },
+	{ /* Sentinel */ }
+};
+
+U_BOOT_SCMI_PROTO_DRIVER(scmi_voltage_domain, match);
diff --git a/drivers/reset/reset-scmi.c b/drivers/reset/reset-scmi.c
index 6dc1fcb3365..f92a9e35579 100644
--- a/drivers/reset/reset-scmi.c
+++ b/drivers/reset/reset-scmi.c
@@ -9,6 +9,7 @@
 #include <errno.h>
 #include <reset-uclass.h>
 #include <scmi_agent.h>
+#include <scmi_agent-uclass.h>
 #include <scmi_protocols.h>
 #include <asm/types.h>
 
@@ -81,3 +82,10 @@ U_BOOT_DRIVER(scmi_reset_domain) = {
 	.ops = &scmi_reset_domain_ops,
 	.probe = scmi_reset_probe,
 };
+
+static struct scmi_proto_match match[] = {
+	{ .proto_id = SCMI_PROTOCOL_ID_RESET_DOMAIN },
+	{ /* Sentinel */ }
+};
+
+U_BOOT_SCMI_PROTO_DRIVER(scmi_reset_domain, match);

-- 
2.43.0

