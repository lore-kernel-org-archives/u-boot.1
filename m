Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66FBACAC5A7
	for <u-boot@archiver.kernel.org>; Tue, 23 Sep 2025 11:13:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA72B835CB;
	Tue, 23 Sep 2025 13:12:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="W5FH1/u4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09A1F835C9; Tue, 23 Sep 2025 13:12:45 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0DB8835BF
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 13:12:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dBkHvFIwUE1Qq8dkaw3Cu5aI8rkCO71psiuy9C0fk0uUa4wsyKv6FmWgVnF0f3r6ZEsrSy9zSxIFRD72ncUDBskZ0s6ckpeHqkI9n+Io+mw0wfVdOVaClvHlLNQLQGAE722P80bj1bd6sLsfUQqVwMD6pZzSEAsB61U6+bXVabTma73oQ0vtNqo+AmGiilbmRg200bwf/AzHhLVe5Aczx7/VF4o7nu/2+lGKdsHQR4A6ulOPenmO70pNEc8fwY8VU+v+Lw4o2SdxYseCy7ONKIldoLdlOf+jqZTr4eu5Io7+sZzm2YwUf0uv3VyZefjMpUg32Dt1vU6Zfr4s0UTP8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=reXXfoOu/+jNuGDP9U3zjLtmLRKstEcCN+REIjFmenU=;
 b=UfKrlkX+4C+0SnRCowKi6XTFnb6/5F83BZlyTuoawmoP9h8BJxuVazSL8C61Ovdgkz++BS3L3ahwHfXX/Lv6oRr+RtvN+bSc0CZVZ2D7bdx/+5h4QpaVje0n9Zqm1GJhj64wLWfmtjyExwUhVhjICKRoLPUcRi34BNLVzhZzcQ0aUErrbgUN+V3aA4Z2zqM4dpZ71IvhYvuudSq4JPeofysTxcGxbEpVbCIHLh4NzeNlX3r1O9amqbIzjF5TEZz+qpbbZFzSse7P+eVDh26iNoqVTUbiC0G+Z61m4zvGQCrcOs+EWH8HtqpqJNVSxpEOeu4ACqSc7e+oTJbTqtwsPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=reXXfoOu/+jNuGDP9U3zjLtmLRKstEcCN+REIjFmenU=;
 b=W5FH1/u4l4xKmNEencx4MuXlMkjq69M5I4NPdY8IXN5k8B0r+Pk4CBzWCKCpp16muzZm9rR8Rg03sYc5mDY3SmuEk0yrOeXKeCm4QCb13K72fP85BpMwa5JJ+GUrO881R4si0QXmtj937Mu18JqAJ9TediNoTyL+gIre0oobnbafHFbGBRiVMrxN+aDc8wz60QJMqGjqcLLcTHorVFt3JdvgidRKGZG6fQ4EPJ2wEdGQnO7CkcHvRRlQXH0Ci89uACEc0UTm5UTlsXPLMc2l38Dgz6J3cSwU8alyPoqjndblIwgL1VxZnUeeQ2gakGeUuyP+JK3ZeBJ/JUSSPnqDFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PA4PR04MB7919.eurprd04.prod.outlook.com (2603:10a6:102:c1::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Tue, 23 Sep
 2025 11:12:40 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 11:12:40 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Tue, 23 Sep 2025 19:11:52 +0800
Subject: [PATCH 08/10] net: fsl_enetc: Add i.MX94 support to NETC block
 control driver
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-usbnetc-v1-8-507cddbe7214@oss.nxp.com>
References: <20250923-usbnetc-v1-0-507cddbe7214@oss.nxp.com>
In-Reply-To: <20250923-usbnetc-v1-0-507cddbe7214@oss.nxp.com>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Alice Guo <alice.guo@nxp.com>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>
Cc: u-boot@lists.denx.de, Ye Li <ye.li@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR01CA0005.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::23) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|PA4PR04MB7919:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e46b5ee-dc91-49c4-99c1-08ddfa921c5d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|19092799006|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dUJpeTFmaHNSR3BUOTJHbDQybG5tdjRBVFpWdHJjSnIwcmNyQS9Vdy9XOVNY?=
 =?utf-8?B?ZFFkaVhHMm1QZ1hzU2lSeEhHMWx5RE1IZGlINnNlVkhzWTFXWW55NnN4Z3hr?=
 =?utf-8?B?WDV3NVcvQXhGdnIxZDRVait6c3E2Uk1jZ1A5WE5lNThNdCswWWdrRzRkM2ZU?=
 =?utf-8?B?YkQraVMzaUYxSmFpY1NQcEhpeEV3TVUyeVNPYkdwK1dkRVNUZGY5MmFaYkJl?=
 =?utf-8?B?TFZ6MU9kdmFpK2pLZElqNlFoYjhnT1FqamZ6WHBHUUMwaEJlOElxYlZQVTdz?=
 =?utf-8?B?UFdMTm1UZnRNdHlkdWhSTUlXNTVLTHRDaXR6VXFWYXlITWV0YU9JRHFlNmsw?=
 =?utf-8?B?cm5WQjVaOW1kZXJJVVVkOEMxd05MMGMwajdrbTdwV0pBUlMvb3RRNzdEVDMw?=
 =?utf-8?B?aWhNb2JFNHR4VWhJSzdqRzNjWUg5d3RRNXJIczVlOTRhVDNseHMzV00rQk9D?=
 =?utf-8?B?L09zbzJZdEI2elJsUFA4N2VUaW5WYWdic2wwbXlZYSswa3RmNTZwTi9rWjk4?=
 =?utf-8?B?SHZjSXpXOHZVTmhwYjlaaWVPK3pTYU8wTUw0MVhoUEpYSWJEeW50U1A5Z2pE?=
 =?utf-8?B?Y0x4NE1lVjkyYjdaZ2NoR3VHdXgvdVpxYnBScGlZdG82RlBIYlU3Q3dTL2I0?=
 =?utf-8?B?bUkzRHFkK2NpZVdQTUxxTG5mZ2FrSmx2bHhieXB5OENYSlJmSkpiZ3lSU2pU?=
 =?utf-8?B?bjM4LzVneTVJSFI0SXJmbjJKSitXdnZSSVNZUWs0ZTZFSW9LeHNxMlBlcWNt?=
 =?utf-8?B?NlRLdVF3clBGM1hFd2Z1MVQzSzRETlJZY2xPSTdRSUg3c2VDTDlTWFVmNWFz?=
 =?utf-8?B?V1VtZG9jaUFPZlp1SHZWTi9HdXVka1NrdmdFVzlwNmVrdWMyT2ljWWJyckpJ?=
 =?utf-8?B?d1pBRVZXU0t4d2tQL2RiU2hTOWJnZEgwaXBXWVFrZ1dZZFVOZW9xSmJDVGFH?=
 =?utf-8?B?eVhWUkpRdU1lTGlIOWxYUzlsdTdQemVKcXVEZDZJdDZqZEQwQis5ZGJyRjA5?=
 =?utf-8?B?WldwaUhrMXFHbUc4Wk4rcE1sMHVtVlBZR0I4eWVUR2M1dVZXTG9ZRlpwUjdU?=
 =?utf-8?B?WkZXMEdmSW9SNk5pcEdZOEtBYStuSkk1R3ljTVA5YU1BM2d3ZWhmYmlMNU41?=
 =?utf-8?B?RStMUnljV2gxVnA2OWhuVC8ra1ZnL3FrUjdnSWFNeW5QT0R2WHI0VXcvRmZQ?=
 =?utf-8?B?TGx2V0NvYzRqWG9hMGM5V1RTNVQwWCs0anNSbiswUDRqY1JrcmhsS1RJOUQ2?=
 =?utf-8?B?Vm4wejdpZVRQYWJyMy9nc1c5Nm5QcVNURUNEaHd6aHR6bGpkQWhnQi9UYUNX?=
 =?utf-8?B?Y09Dd2tQUXF2SUNmMTVEOHhNN0NyTTU1eFkxTjBZUjhZcWRrVU42bCtCVDhy?=
 =?utf-8?B?WDVmamhVOTRlbmNjekV3alc5S0xkMXJlK20yUDJ2a3JIMjlEdXB2UmJrcllC?=
 =?utf-8?B?d3ZIWEg3R0ZMbVpNYk5OaVlyS0R3QWx0UFNQODJWdHZNblBMYjlmZXVoKy9D?=
 =?utf-8?B?aEZNbXd5ZGZoZjFqRE9pMi93cEdZSVFJNHlOSVRTOXQ1QUJsYk8wcGliZW1Q?=
 =?utf-8?B?T1ZrTE5hUlpFN0dYZUxtRjc3SFJUTVF2WlJtdGxCaCttanhRaFQ2Nk9HVDRj?=
 =?utf-8?B?OTJCVmZ1bUJWcUtMSkk5VlFtZmk5UThrRmprYWlYOEZHT3FUQjdWL29CQjl4?=
 =?utf-8?B?djNCOTdUWlByQlNLS25tL0Nrb1FvYnNzcGxXcXdmSVdMU3BNWGFtRzBtMFFr?=
 =?utf-8?B?T0Z3VlltSndmcnhiUklEK2lPUWhnaUVNcW5OZFd5TENwUmRrV00xUDBHOGVy?=
 =?utf-8?B?M3VINGc2SGk4dlFmcUt5a3M2Z1ViVHA2ZGMzd0VtWk1TU3ZWWmdjTmZ4UFU3?=
 =?utf-8?B?VjdwTW9UWVZkUUlIZ3ZVYkJNYW02a3VmekYySVVQVlU1YVBtOW03ejNmdkFy?=
 =?utf-8?B?cTJtR3phNTR5TWplUEUxR2VKbmg4MzZheXg3d01qWE85cjBOeTZpeWFtUlBz?=
 =?utf-8?Q?SoqSMz3GpeKs1vIJuuKnXYy+yxrUNM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(19092799006)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZG9yQXNUM3B6K1pkOXVaM25XK3hSNDZXSzRiblhZb211dlptVkY4RVFSR3hC?=
 =?utf-8?B?YytVbWIxTHVjTmdqUm1TeXBaL284ZGlZRTRxTW9mS0JSd1FFRGRJMXVQczJU?=
 =?utf-8?B?WTFpd2J1ejRMQ1lhMWp1RHNnc1ZWeXFBWS9QMkprUCttTFF6RGQrdU56bkhZ?=
 =?utf-8?B?WFhWMHJxN0owUE9Ca1l3YXplM0ZLR0N0SDVjYjJWeXRIbVJiUi9jT1dRZmVz?=
 =?utf-8?B?c2NnNjRBaitRWlB6Q1UvYkN6cE1jV1dlbFIyQWxNcHFYdkhYdXRrMzdpWHpX?=
 =?utf-8?B?cjJGdUdhY3JmS2xpUEVNSGRxTHBXSXVKWWgwZWJEMXBnck8xZDdoYWRuOUw4?=
 =?utf-8?B?UDcrY0IyS2RYRE1HT0Vabit3WnlwL3JJYWtYaGtVbzFuY29BMnRHNUxHTDFp?=
 =?utf-8?B?VTdPK2xDVWNwWnA0U0hRWi9oNGsvMHluOEVnRHRPanRaY1lyMjFTZmZoaEJu?=
 =?utf-8?B?NnBQU1M5NUZNc1Q3elhrS0lEa3Jyb20vYWFGY1F5d3U0TDBtLy90NHdMdzg5?=
 =?utf-8?B?WEJtaEwzM3BVYzQ5MjQzQ2FwVEpZb3lWN3JTekEyOXlMcnJLbE51S040djMz?=
 =?utf-8?B?TFZ3c0dWcWlDVHNNL0JoR09CbFViTGZWZzhXN1BsWnV4dFhoQzVCZUExcEp0?=
 =?utf-8?B?Y0JwYk5Qem1ITm1aZDk0YjkrTzRORkFKWWhnMWpHVTBiZm9uZkcrT0RHWCtL?=
 =?utf-8?B?TmU1V050dmZoQWFDZkh2SXd5YmdVcTNsYnRnTE9VWkpTWTJOOVFkaFlHSSt2?=
 =?utf-8?B?UXcxVmJ3TFNPcEZKR3FDWklDSmZCSXJncGNhL2MyU3JZZGZ5UDNRQmtyNDdN?=
 =?utf-8?B?Y1lCMkNGYklybWRpckd3QWxEQnZMWkV1RGNUNSs2MGJVTTcwa1Q2aWtvQ0hD?=
 =?utf-8?B?R1dBTERHazY2dkJuSG1yRTJNRGoxbkNxbVJBcEszV2hBWEZDUEVET2JRN2VB?=
 =?utf-8?B?YVZGOVVxaWtick8xNjd3S2V2aENTYXcrdnJpSk81clRyYlkyaFhLRTdGZUl5?=
 =?utf-8?B?Tm5BWmVSNlpUQnViRGZ1ZjhXaURld3NkR2dZK0p0aUFDa01nTWN1WWVsT0FH?=
 =?utf-8?B?SkQwU0ljK2syUTFTUGxza3QrbU9sd1dEQkxjckIzOTNDL0dhUEpsMkxxRmZm?=
 =?utf-8?B?T0V3cDNKK0JIWHJCclozQ016SDJVYlFTcEtab3NaSzRtZ2pYOTkrRFpYYklr?=
 =?utf-8?B?bE5tVDAzZGZkd3VwQ3hYMnFsa3pMZ3dvZ3U3Njh6WmZxdEFRWklYQ0F0NG9Q?=
 =?utf-8?B?aTN1d2xPWVNRSHNlcEh1WW1aNlFwWlpVVk5PQmRBSVlCaFowNkdVWFFrcjhu?=
 =?utf-8?B?N3pIeSszeUtqU25Oc2JnSmJCSUgzWVJ2M2lKS2J4Sktoa0d2M1VCV3hSUGxR?=
 =?utf-8?B?UGV3VjlFdGhxZi9CZVVWcWw1bGdBZUJUUVF6NlY1MkptOGE0NG1LRzhmbWZ2?=
 =?utf-8?B?bSt6RVZocThHdlljT3l6bkkxR3k0ZDJjUCtwSVJPQ0k1ZFJZcDRzQTZaTkZs?=
 =?utf-8?B?NWhlTVZBbXR6d09INnVLYjUvczk5Zms4dDVHdkRUWTdjaVBaZnM5YUhMcG5y?=
 =?utf-8?B?NVhvUXpCY2kvMFdnSmt4N0puMmpSam4zSTQrTG8yRGNTc25GZU9XVFZQN0Fn?=
 =?utf-8?B?Z3NZSDRPMXRRYlpjSW1FMkRiV0pIOG1uN1FzSUd5NFB2YWx5WXN6VGZCME1C?=
 =?utf-8?B?OHFXblRXQ3U3bmdIdzBXYkhoMEM3RWN1NWo4WmQ5cHNaS2xTZE9oSWlFNWJq?=
 =?utf-8?B?U0JZdE81SDZtTGpaSmhTSktmYTEvVlF1SlA4bzVzM1RGM1dXTjRra1ExV0t1?=
 =?utf-8?B?VUorc0JjQlRjczJMb3h2bC9tTWVZMzcrUHkyNlhMdXZPMHgxbVdUR2tWRVBP?=
 =?utf-8?B?eWZKQ2REcllMaCs2eDBRcFhFS1Jkc2NWenUxS0xEbUxBQlZvVXZnQlMxRGJ4?=
 =?utf-8?B?NjlGWjUybUV0MHlsVGlvamdaSW1ld1JjQVFqTzJTd1htb2hoYUQvc2tkalVi?=
 =?utf-8?B?cmoyVVVNNzdYTzI3LzZiN2ZDWE5EZTNENi9iQnRxSHhVb3RuVnpYTktSaU5E?=
 =?utf-8?B?TU9SRDd5WExrUllrSkRmOXNKUUVaTlBLL010L0FGbVVjM1J2eTJZdzUrU1lS?=
 =?utf-8?Q?84dzSpct8v9ap7cy0jKUjhtgM?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e46b5ee-dc91-49c4-99c1-08ddfa921c5d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 11:12:40.6466 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RZfsIJp2KQiXWu8KEJhvrl8zMDEb4k1A0gXcVDP81cF3mmgH014X0PD27e2bsJ0mI+Zim4IjfVdNB+n0yaYu/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7919
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

From: Ye Li <ye.li@nxp.com>

Extend the NETC block control driver to support the i.MX94 SoC.

Acked-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/net/Kconfig                   |   5 +-
 drivers/net/fsl_enetc_netc_blk_ctrl.c | 338 +++++++++++++++++++++++++++++++++-
 2 files changed, 333 insertions(+), 10 deletions(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index d1cb69f85ad..4ad226bea4f 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -1002,8 +1002,9 @@ config FSL_ENETC
 
 config FSL_ENETC_NETC_BLK_CTRL
 	bool "NXP ENETC NETC blocks control driver"
-	depends on FSL_ENETC && IMX95
-	default y if IMX95
+	depends on FSL_ENETC
+	depends on IMX95 || IMX94
+	default y if IMX95 || IMX94
 	help
 	  This driver configures Integrated Endpoint Register Block (IERB) and
 	  Privileged Register Block (PRB) of NETC. For i.MX platforms, it also
diff --git a/drivers/net/fsl_enetc_netc_blk_ctrl.c b/drivers/net/fsl_enetc_netc_blk_ctrl.c
index 46b68d3d8a4..2d705c61ecd 100644
--- a/drivers/net/fsl_enetc_netc_blk_ctrl.c
+++ b/drivers/net/fsl_enetc_netc_blk_ctrl.c
@@ -43,6 +43,19 @@
 #define PCS_PROT_SFI			BIT(4)
 #define PCS_PROT_10G_SXGMII		BIT(6)
 
+#define IMX94_MISC_SOC_CONTROL		0x0
+#define SEL_XPCS_1			BIT(1)
+#define IMX94_XPCS_PORT_0		0x0
+#define IMX94_XPCS_PORT_1		0x1
+
+#define IMX94_EXT_PIN_CONTROL		0x10
+#define MAC2_MAC3_SEL			BIT(1)
+
+#define IMX94_CFG_LINK_PCS_PROT(a)	(0x14 + (a) * 4)
+#define IMX94_NETC_LINK_CFG(a)		(0x4c + (a) * 4)
+#define NETC_LINK_CFG_MII_PROT		GENMASK(3, 0)
+#define NETC_LINK_CFG_IO_VAR		GENMASK(19, 16)
+
 /* NETC privileged register block register */
 #define PRB_NETCRR			0x100
 #define  NETCRR_SR			BIT(0)
@@ -55,6 +68,7 @@
 /* NETC integrated endpoint register block register */
 #define IERB_EMDIOFAUXR			0x344
 #define IERB_T0FAUXR			0x444
+#define IERB_ETBCR(a)			(0x300c + 0x100 * (a))
 #define IERB_EFAUXR(a)			(0x3044 + 0x100 * (a))
 #define IERB_VFAUXR(a)			(0x4004 + 0x40 * (a))
 #define FAUXR_LDID			GENMASK(3, 0)
@@ -64,6 +78,26 @@
 #define IMX95_ENETC1_BUS_DEVFN		0x40
 #define IMX95_ENETC2_BUS_DEVFN		0x80
 
+#define IMX94_ENETC3_BUS_DEVFN		0x0
+#define IMX94_TIMER0_BUS_DEVFN		0x1
+#define IMX94_SWITCH_BUS_DEVFN		0x2
+#define IMX94_ENETC0_BUS_DEVFN		0x100
+#define IMX94_TIMER1_BUS_DEVFN		0x101
+#define IMX94_ENETC1_BUS_DEVFN		0x140
+#define IMX94_ENETC2_BUS_DEVFN		0x180
+#define IMX94_TIMER2_BUS_DEVFN		0x181
+#define IMX94_ENETC0_LINK		3
+#define IMX94_ENETC1_LINK		4
+#define IMX94_ENETC2_LINK		5
+#define IMX94_ENETC0_OFFSET		0
+#define IMX94_ENETC1_OFFSET		1
+#define IMX94_ENETC2_OFFSET		2
+#define IMX94_SWITCH_PORT2		2
+#define IMX94_SWITCH_CPU_PORT		3
+#define IMX94_TIMER0_ID			0
+#define IMX94_TIMER1_ID			1
+#define IMX94_TIMER2_ID			2
+
 /* Flags for different platforms */
 #define NETC_HAS_NETCMIX		BIT(0)
 
@@ -73,6 +107,15 @@ struct netc_blk_ctrl {
 	void __iomem *netcmix;
 };
 
+struct netc_devinfo {
+	int (*netcmix_init)(struct udevice *dev);
+	int (*ierb_init)(struct udevice *dev);
+	void (*xpcs_port_init)(struct netc_blk_ctrl *priv, int port);
+};
+
+static struct netc_blk_ctrl *netc_bc;
+static struct netc_devinfo *netc_di;
+
 static void netc_reg_write(void __iomem *base, u32 offset, u32 val)
 {
 	writel(val, base + offset);
@@ -183,6 +226,150 @@ static int imx95_netcmix_init(struct udevice *dev)
 	return 0;
 }
 
+static int imx94_enetc_get_link_num(ofnode np)
+{
+	int bus_devfn;
+
+	bus_devfn = netc_of_pci_get_bus_devfn(np);
+	if (bus_devfn < 0)
+		return -EINVAL;
+
+	/* Parse ENETC link number */
+	switch (bus_devfn) {
+	case IMX94_ENETC0_BUS_DEVFN:
+		return IMX94_ENETC0_LINK;
+	case IMX94_ENETC1_BUS_DEVFN:
+		return IMX94_ENETC1_LINK;
+	case IMX94_ENETC2_BUS_DEVFN:
+		return IMX94_ENETC2_LINK;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int imx94_link_config(struct netc_blk_ctrl *priv,
+			     ofnode np, int link_id)
+{
+	phy_interface_t interface;
+	int mii_proto;
+	u32 val;
+
+	interface = ofnode_read_phy_mode(np);
+	if (interface == -1)
+		return -EINVAL;
+
+	mii_proto = netc_get_link_mii_protocol(interface);
+	if (mii_proto < 0)
+		return -EINVAL;
+
+	val = mii_proto & NETC_LINK_CFG_MII_PROT;
+	if (mii_proto == MII_PROT_SERIAL) {
+		int pcs_proto = PCS_PROT_1G_SGMII;
+
+		if (pcs_proto == PHY_INTERFACE_MODE_2500BASEX)
+			pcs_proto = PCS_PROT_2500M_SGMII;
+
+		netc_reg_write(priv->netcmix, IMX94_CFG_LINK_PCS_PROT(link_id),
+			       pcs_proto);
+		val = u32_replace_bits(val, IO_VAR_16FF_16G_SERDES,
+				       NETC_LINK_CFG_IO_VAR);
+	}
+
+	netc_reg_write(priv->netcmix, IMX94_NETC_LINK_CFG(link_id), val);
+
+	if (link_id == IMX94_ENETC0_LINK) {
+		val = netc_reg_read(priv->netcmix, IMX94_EXT_PIN_CONTROL);
+		val |= MAC2_MAC3_SEL;
+		netc_reg_write(priv->netcmix, IMX94_EXT_PIN_CONTROL, val);
+	}
+
+	return 0;
+}
+
+static int imx94_enetc_link_config(struct netc_blk_ctrl *priv,
+				   ofnode np, bool *enetc0_en)
+{
+	int link_id;
+
+	link_id = imx94_enetc_get_link_num(np);
+	if (link_id < 0)
+		return -EINVAL;
+
+	if (link_id == IMX94_ENETC0_LINK)
+		*enetc0_en = true;
+
+	return imx94_link_config(priv, np, link_id);
+}
+
+static int imx94_switch_link_config(struct netc_blk_ctrl *priv,
+				    ofnode np, bool *swp2_en)
+{
+	ofnode ports, child;
+	int port_id, err = 0;
+
+	ports = ofnode_find_subnode(np, "ports");
+	if (!ofnode_valid(ports))
+		ports = ofnode_find_subnode(np, "ethernet-ports");
+	if (!ofnode_valid(ports))
+		return -ENODEV;
+
+	ofnode_for_each_subnode(child, ports) {
+		if (ofnode_read_u32(child, "reg", &port_id) < 0) {
+			err = -ENODEV;
+			goto end;
+		}
+
+		if (port_id == IMX94_SWITCH_CPU_PORT)
+			continue;
+
+		if (port_id == IMX94_SWITCH_PORT2)
+			*swp2_en = true;
+
+		err = imx94_link_config(priv, child, port_id);
+		if (err)
+			goto end;
+	}
+
+end:
+	return err;
+}
+
+static int imx94_netcmix_init(struct udevice *dev)
+{
+	struct netc_blk_ctrl *priv = dev_get_priv(dev);
+	ofnode child, gchild;
+	bool enetc0_en = false, swp2_en = false;
+	int err;
+
+	dev_for_each_subnode(child, dev) {
+		if (!ofnode_is_enabled(child))
+			continue;
+
+		ofnode_for_each_subnode(gchild, child) {
+			if (!ofnode_is_enabled(gchild))
+				continue;
+
+			if (ofnode_device_is_compatible(gchild, "pci1131,e101")) {
+				err = imx94_enetc_link_config(priv, gchild, &enetc0_en);
+				if (err)
+					return err;
+			} else if (ofnode_device_is_compatible(gchild, "pci1131,eef2")) {
+				err = imx94_switch_link_config(priv, gchild, &swp2_en);
+				if (err)
+					return err;
+			}
+		}
+	}
+
+	if (enetc0_en && swp2_en) {
+		dev_err(dev, "Cannot enable swp2 and enetc0 at the same time\n");
+
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static bool netc_ierb_is_locked(struct netc_blk_ctrl *priv)
 {
 	return !!(netc_reg_read(priv->prb, PRB_NETCRR) & NETCRR_LOCK);
@@ -238,9 +425,99 @@ static int imx95_ierb_init(struct udevice *dev)
 	return 0;
 }
 
+static int imx94_enetc_get_enetc_offset(ofnode np)
+{
+	int bus_devfn;
+
+	bus_devfn = netc_of_pci_get_bus_devfn(np);
+	if (bus_devfn < 0)
+		return -EINVAL;
+
+	/* Parse ENETC offset */
+	switch (bus_devfn) {
+	case IMX94_ENETC0_BUS_DEVFN:
+		return IMX94_ENETC0_OFFSET;
+	case IMX94_ENETC1_BUS_DEVFN:
+		return IMX94_ENETC1_OFFSET;
+	case IMX94_ENETC2_BUS_DEVFN:
+		return IMX94_ENETC2_OFFSET;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int imx94_enetc_get_timer_id(ofnode np)
+{
+	int bus_devfn;
+
+	bus_devfn = netc_of_pci_get_bus_devfn(np);
+	if (bus_devfn < 0)
+		return -EINVAL;
+
+	/* Parse ENETC PTP timer ID */
+	switch (bus_devfn) {
+	case IMX94_TIMER0_BUS_DEVFN:
+		return IMX94_TIMER0_ID;
+	case IMX94_TIMER1_BUS_DEVFN:
+		return IMX94_TIMER1_ID;
+	case IMX94_TIMER2_BUS_DEVFN:
+		return IMX94_TIMER2_ID;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int imx94_enetc_update_tid(struct netc_blk_ctrl *priv, ofnode pf_np)
+{
+	ofnode timer_np;
+	int offset, tid;
+
+	offset = imx94_enetc_get_enetc_offset(pf_np);
+	if (offset < 0) {
+		printf("Find unknown PF node.\n");
+		return offset;
+	}
+
+	timer_np = ofnode_parse_phandle(pf_np, "nxp,ptp-timer", 0);
+	if (!ofnode_valid(timer_np)) {
+		/*
+		 * If nxp,ptp-timer is not set, the first timer of the bus
+		 * where enetc is located will be used as the default timer.
+		 */
+		tid = IMX94_TIMER1_ID;
+		goto update_reg;
+	}
+
+	tid = imx94_enetc_get_timer_id(timer_np);
+	if (tid < 0) {
+		printf("Incorrect bus/devfn of ptp-timer.\n");
+		return tid;
+	}
+
+update_reg:
+	netc_reg_write(priv->ierb, IERB_ETBCR(offset), tid);
+
+	return 0;
+}
+
+static int imx94_ierb_init(struct udevice *dev)
+{
+	struct netc_blk_ctrl *priv = dev_get_priv(dev);
+	ofnode bus_np, pf_np;
+	int ret = 0;
+
+	dev_for_each_subnode(bus_np, dev)
+		ofnode_for_each_subnode(pf_np, bus_np)
+			if (ofnode_device_is_compatible(pf_np, "pci1131,e101"))
+				ret = imx94_enetc_update_tid(priv, pf_np);
+
+	return ret;
+}
+
 static int netc_ierb_init(struct udevice *dev)
 {
 	struct netc_blk_ctrl *priv = dev_get_priv(dev);
+	struct netc_devinfo *devinfo = (struct netc_devinfo *)dev_get_driver_data(dev);
 	int err;
 
 	if (netc_ierb_is_locked(priv)) {
@@ -251,9 +528,11 @@ static int netc_ierb_init(struct udevice *dev)
 		}
 	}
 
-	err = imx95_ierb_init(dev);
-	if (err)
-		return err;
+	if (devinfo->ierb_init) {
+		err = devinfo->ierb_init(dev);
+		if (err)
+			return err;
+	}
 
 	err = netc_lock_ierb(priv);
 	if (err) {
@@ -264,6 +543,31 @@ static int netc_ierb_init(struct udevice *dev)
 	return 0;
 }
 
+static void imx94_netc_xpcs_port_init(struct netc_blk_ctrl *priv, int port)
+{
+	u32 val;
+
+	val = netc_reg_read(priv->netcmix, IMX94_MISC_SOC_CONTROL);
+	if (port == IMX94_XPCS_PORT_1)
+		val |= SEL_XPCS_1;
+	else
+		val &= ~SEL_XPCS_1;
+	netc_reg_write(priv->netcmix, IMX94_MISC_SOC_CONTROL, val);
+}
+
+void netc_xpcs_port_init(int port)
+{
+	struct netc_blk_ctrl *priv = netc_bc;
+	struct netc_devinfo *devinfo;
+
+	if (!priv)
+		return;
+
+	devinfo = netc_di;
+	if (devinfo->xpcs_port_init)
+		devinfo->xpcs_port_init(priv, port);
+}
+
 static int netc_prb_check_error(struct netc_blk_ctrl *priv)
 {
 	if (netc_reg_read(priv->prb, PRB_NETCSR) & NETCSR_ERROR)
@@ -272,14 +576,27 @@ static int netc_prb_check_error(struct netc_blk_ctrl *priv)
 	return 0;
 }
 
+static const struct netc_devinfo imx95_devinfo = {
+	.netcmix_init = imx95_netcmix_init,
+	.ierb_init = imx95_ierb_init,
+};
+
+static const struct netc_devinfo imx94_devinfo = {
+	.netcmix_init = imx94_netcmix_init,
+	.ierb_init = imx94_ierb_init,
+	.xpcs_port_init = imx94_netc_xpcs_port_init,
+};
+
 static const struct udevice_id netc_blk_ctrl_match[] = {
-	{ .compatible = "nxp,imx95-netc-blk-ctrl" },
+	{ .compatible = "nxp,imx95-netc-blk-ctrl", .data = (ulong)&imx95_devinfo },
+	{ .compatible = "nxp,imx94-netc-blk-ctrl", .data = (ulong)&imx94_devinfo },
 	{},
 };
 
 static int netc_blk_ctrl_probe(struct udevice *dev)
 {
 	struct netc_blk_ctrl *priv = dev_get_priv(dev);
+	struct netc_devinfo *devinfo = (struct netc_devinfo *)dev_get_driver_data(dev);
 	struct clk *ipg_clk;
 	fdt_addr_t regs;
 	int err;
@@ -318,10 +635,12 @@ static int netc_blk_ctrl_probe(struct udevice *dev)
 
 	priv->netcmix = (void __iomem *)regs;
 
-	err = imx95_netcmix_init(dev);
-	if (err) {
-		dev_err(dev, "Initializing NETCMIX failed\n");
-		return err;
+	if (devinfo->netcmix_init) {
+		err = devinfo->netcmix_init(dev);
+		if (err) {
+			dev_err(dev, "Initializing NETCMIX failed\n");
+			return err;
+		}
 	}
 
 	err = netc_ierb_init(dev);
@@ -333,6 +652,9 @@ static int netc_blk_ctrl_probe(struct udevice *dev)
 	if (netc_prb_check_error(priv) < 0)
 		dev_warn(dev, "The current IERB configuration is invalid\n");
 
+	netc_bc = priv;
+	netc_di = devinfo;
+
 	return 0;
 }
 

-- 
2.43.0

