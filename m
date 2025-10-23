Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83325CCD193
	for <u-boot@archiver.kernel.org>; Thu, 23 Oct 2025 07:58:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECE6C836C8;
	Thu, 23 Oct 2025 09:57:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="I2sz72c7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 606D08323A; Thu, 23 Oct 2025 09:34:18 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 758CE82E34
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 09:34:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QNJO/5KWXpUqTPlEngvpPDzKUy7w6CAGhduyd7C3gAPG7k7ZYslZ08K1ZAmpga1oRpYcqvRB8j3UdQQzJyT89ZF+9Z2SNzlhw6MRm/BvyX3XJmz8Bzqo9VQuq74hXlBSyq9s1d3nrAmw0hdyeaGdB01HobKb0UPkV6bY9rDhubPKruNSZYDeH14rC124uBR+cOWwv2zuwRXsD1R7UamzojG4UgTp0jF8pi3dDCWUZ5pSPuDN3hEFkTCqs5FRDGKYbXxab6FwCB/KudNiD3Z79DSJ8rNI6ybNZM/9gVT621i0T1cukSZ2whx4ljjg4hjeZm8kEjAK9G1KFj/s8v8FWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQV/D3E6nxOjXQ+orkstBgJ56sBQgoCIXinZnihK3ys=;
 b=KFR3na0zYjPOzs6oBLqbgc9T+twVqHQ2PLrKSyOb0+cRgwNQPcGv2UtF/UqzzYe8uOnv9lKUtz77fIixVAD6qKh0+UJGhDTrTsqGY9xFsq8i7CtLGVcxIB8t1A7uLmQ6XTCuRAY6/oagezcPidBnbpLIVBrD24/XyTI5L3/jdncj4je58b0zaJ3WJyOT3kZXHyeB3SL5bnc/sj36mB3RA6uLeF1JhVBEZ7+S1rHab9CgKnYwGSBwk+TpCmZY/5jD+QrqBGhCjvCq5+yl/80qn4wBaVY3dsU0kyejN5OeM5COY6ARgxpSVcSAJep9smZ84ZZc5Q8Ap62d34DsZBH7tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQV/D3E6nxOjXQ+orkstBgJ56sBQgoCIXinZnihK3ys=;
 b=I2sz72c7mwTUUsP9cpUZXUv+5FHcIAd8i3y2dDtpeM+jzlZka+gTUThafMq7MmqRUfHbHEaeTEH8p7m6kxM3qQWVS1U2SPJYe1CWPZyTmzD4Z5Q9luOo+mz8OTKTYAwHsP5G5fkTuCjJ9fTcsuywfgm0DO4upQHcg/XKNeO8eTagCKF0r6vd6brZhEvoxv1kCJchHMxuYOIOYFAGSoH+YQ8ZvTQZ0UysmSIOmKLm93rzhtspSW6esHLUqvB4b9xC7ieyDG9i7f+FjeULQ5XnmfnMQCpF+HTKe+GtyjYhFSk2NaP5iniekaON+t8U5d4EWMclIV890KqtmCUfHEMRAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 07:34:14 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 07:34:14 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: u-boot@lists.denx.de,
	Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Cc: Peng Fan <peng.fan@nxp.com>, jh80.chung@samsung.com, trini@konsulko.com,
 marex@denx.de, tien.fong.chee@altera.com
Subject: Re: [PATCH] power: regulator: Remove duplicate include of
 regulator_common.h
Date: Thu, 23 Oct 2025 16:46:06 +0800
Message-Id: <176120893104.2124.2097717487239710714.b4-ty@nxp.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20251023050017.4580-1-tanmay.kathpalia@altera.com>
References: <20251023050017.4580-1-tanmay.kathpalia@altera.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:3:18::32) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DBBPR04MB7737:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d392665-a564-4cd4-03ac-08de120690e1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aURXWXlEWWtKZUorczhralU1OWZIN3hOc29aNGdTTEZCSEQ4ZW5jMUNjSGhX?=
 =?utf-8?B?eXArbWhmSUVESzljRmRodEZWdEo3b1lNRzQveHZIL0V0Y3Z5WVlyWTZxOVJN?=
 =?utf-8?B?dnBZckFmZ09rM0kxdkV1ZVdRVGdCUkxLR1g1MXQ5aWJxMkVGKzRkVHNKeVNi?=
 =?utf-8?B?UXdZRVo4Y1piVHBVUmRNVjhpaTdiYkI5UWZQVjBmM0RTWVpFUFpSVUw5RE1n?=
 =?utf-8?B?TDAvN3doL21UNGJOTm83Y1VSblNydVBuVWEyak9pT3IzV0tReEF3UTdvMWFH?=
 =?utf-8?B?NHMxOFAxOTR5anFLelVSMWJyMlMyT3A1SmpxTzRaTmo0VnR2b3dDWkIwaE1k?=
 =?utf-8?B?T0lselgwTFBsWmM3M1MzaTg5MUZkVzAwNytzVHhzWGRINU1taTUwVStaTE9R?=
 =?utf-8?B?dXJLNlgvZVVFTlE2Nk1lTHhLMUptU2JxWitsa0lDOHBOckhXSVJUUFlWaFNZ?=
 =?utf-8?B?eFFGTFRlVFpqeTdmVE1vNmQrQ2tvaFJVSmtXQWNDK3c0emNtOWp4MVM0eTJL?=
 =?utf-8?B?V0REa3lEWjU5YUFUZEVOK1gwR1hRWHNyQUxRNWxDWUdoUE5xTTZyUkFtaVoz?=
 =?utf-8?B?VVJSLzZRcTRzb1AvRjk5MGJnMzBCQ2xuRE5xYmRyRDVTL1JQNzErelFoSmNu?=
 =?utf-8?B?VUFHYXRrMnNieXRsWTIrUG15WGdhc0pxOUs2SWNRcVNTeFVJSnRKWlR2YTVr?=
 =?utf-8?B?dTJwaUYzYW9HOVMzVVVrUmxobFdXREhIRi8rUjdNM0J1MGs2V2J2MjZxajZr?=
 =?utf-8?B?dXd6V2VQTFBKUmVhSnBYbFJERGdhVjdsRGFkcTUzTTdBV2UxWGpFYU1MMjRh?=
 =?utf-8?B?a3B5LzQ4dURHNTJPbnpSS1Q0NjI1aHFMVzJSRnBMWjVWLzBVNzBNNlRnd0FU?=
 =?utf-8?B?L0dhRE4rSk01Lzgwd1B2ZUdHRlQwdW00MnVPeExSbkFJTHpkRTc0bWtjUTBk?=
 =?utf-8?B?MXZ5dmZQbFpKVXF1L1N3WHk5N05qSzhoUVRkNnN3UmRGUkZrTzgvUll5bXdY?=
 =?utf-8?B?MVVPZlc1WCtweUdPamMvM0xpOXVydkVhK3BITTI0bG5iWlh1dHhTMVJESmhq?=
 =?utf-8?B?OWlHT1ByWStoMlMvVnB0Tm9SSFFWSjhlMW85MEZEaThGODUzL2N2KysvRC9C?=
 =?utf-8?B?cmdFT2VacnAvUTcwblZXWmtoS1djdEJiYXlhQUtWeHhzTi9aTWZ5dXY4a0tD?=
 =?utf-8?B?c1RHNVI3MVJPakhWalhyZkZBUm4yRDcxV1ZSMm5UOHo4OEtYU0xOVEYzY2dF?=
 =?utf-8?B?bnAreThtTytmdUZlZmxtY3JLdmZCRzVQcnp3bkhpUDhXYVNoUndWa0VjOWxL?=
 =?utf-8?B?WVZmSjNVWktjRk4rbEpzbENlRnYvL1ZOdTdhNno4STRtYXRJdDhaaS84ZFJ2?=
 =?utf-8?B?b3hKM0g0c2krdVQyZkdMRXAxcGFrMkxEN2ZkeFpzYVd3ZkJ2VFBMWTg3ZE9p?=
 =?utf-8?B?ZmtuK2JFczhFRjRxZWNtSjUreTQ2U3BIeEN5Ujdwc3hKNXAwMHNzY1RjVG0r?=
 =?utf-8?B?OEFkU3pwei9GRVpTYjA4Wkh6TlhSckhYUmdLWklJYVlBNkhrSzB0NExLR1NZ?=
 =?utf-8?B?Q3VFWjhETUdnbHVxSkxkYnkwczBOZzR4OFU2Z0hrQTBkNE1lY1FKb2FoOG5u?=
 =?utf-8?B?aXFHTXl6emQwZ3dVMW5xeXJoYzRrOC9keUR4a0tmV1QwRHFkZHhWOW0yRmFq?=
 =?utf-8?B?NHFEdkVoUDRYV2VOdm0xZm5udXF2c3BqUU51cGEwSkY5TFVFbFJiQnVEc2hN?=
 =?utf-8?B?dkpub3RlV3lCY0JsTjIwMW5XNnZ0WTJxaFJ5TkVTQVJTSjlXRVV3eXdOMGFk?=
 =?utf-8?B?U0ZHK0RiYlZjS2pBRmtqd3lWVEZLRDR2Y1gwWUd5V1A3OUFseE5PQUh0enNY?=
 =?utf-8?B?LzU2d0VnSXgzdVpxRXhIdzB5ZEowZEdYLzFQbnJvNUd2NE5XNlVtNHF3d0R4?=
 =?utf-8?B?NFNYZE5aYTdEc0gwQlNYcHJkNWRxZFFXbURxbkl0STRmNXV2ak5ob2U4QXl2?=
 =?utf-8?B?VDQrV0tCZFZGM1dmYjVtMEp4YkxINzRiNWVsMXRwQTU0SnRuQ3IvN1A5V1pL?=
 =?utf-8?Q?WDheJB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(52116014)(376014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXFMdVhhQ0ZkWVBIRkxYWEY0Umc5Ulp5dGZzcklZZmovVHFHek93Q3RKSmhI?=
 =?utf-8?B?Y2pGb2xIeFVqNWc1ekM4QlIrZXFwSlBWOENxcC9Cbm94MUhKUzRsbmV3QUJP?=
 =?utf-8?B?MjhrazBmallSSDJ2eThKUlVsU2w2RGFLQ1dDSXFsWDZrU3JNMTAzTDBPSGl3?=
 =?utf-8?B?T0Jma1F3V2g4TGpIVWFHSjFoZDN2eDFKUk5hSXpIa2tIVXU2QzhjZ2tYbXZT?=
 =?utf-8?B?QkJhdXZmQitqQ2JZdm1VQitrazZNb3ROTTdDRHo0NjhINkJQcVFzUytzdUQ1?=
 =?utf-8?B?ejB4dVIwbk1zZGZSOUI5NjZvbFFzVG9TRGJzbEFuVEorU25sKytOcFRRWkw2?=
 =?utf-8?B?OGJEZnVueDVwbmZGc3FZWklaY2Z0cmUvUVBERHZ2Zm5BUldseFM4VWpqdVk4?=
 =?utf-8?B?a2UxMnJJU3JiTHRGVGxPTWV2N1YyZ1FyZ3lnek5PMU52NXFiMkd5Wmhxd2l0?=
 =?utf-8?B?Q2kyc0EyOU5sYSt4QnA3UTMzZWQ3UzVKL05oR2NzbnhrQ0ZtL3RXSVRuTUxq?=
 =?utf-8?B?TThhSmVZaTRNbjE4RHdKRWpCT1orM2NSZEJmTlFqN1lwNG9kSlQyVG5CTmNM?=
 =?utf-8?B?QjFvL094cUtIRkE3YXJBNUxzV0lOOFZ5RWNzNkRrUElDYnNlbWVrMXZsZlhU?=
 =?utf-8?B?eE5IYXh2TjFPcEpqbEVVcGJtRk5ZdjljcWJ2a1NOWEc2SFZCVFAyaDJTd0xU?=
 =?utf-8?B?STFHSFRVVFJLWkx3SjZTOWQ0S2pNdjZocjBtVTNLVytBcFRQSjNhQVBTaXVT?=
 =?utf-8?B?T3RoT3FEUWRlcnJuOEs4LzZFbUQ4MWZoMi9KSVUxSHBUUVZXSUVJUk11bk9Y?=
 =?utf-8?B?REtiT1c5cXBZSW5XOE5EbmduSFZ5ZjZuVkE0a3ZhZTZBOVJDMlFZL1NtaXV4?=
 =?utf-8?B?UjVUMzlyeFVoajZCdHN4cmRkT3FnZlZ1QkEydHhPVE9LL3VRdU11ck1pOWhH?=
 =?utf-8?B?ajhBMG5ObVNxNlVLKy9oU3RmajNMbEV1VzR3VGhVMExGVnV4OVkvbGF5YlRt?=
 =?utf-8?B?Y3ZQbmRocjlTckJOTGt5WHZIUjJjZVdxU09Gd0ZsZ2ZkOE5RZ0l6WGE1RDVt?=
 =?utf-8?B?OEhSb3FDWHV2dEtETGtiYTl6NFAwWXc2ZmtENWlYWW5FdVhTRVpMdWRUcVhR?=
 =?utf-8?B?aS91OXEvcCtmT2hhU3hGbE9vWVNKZzNabzRBQ3AycEJiVWhXMmpwVnRKbHVQ?=
 =?utf-8?B?QWVQUjZSZVhPQUJIcXBaeUZWVWdGM0lCU0dOcGFSeGZCWEI1VFdEOHFYMGZr?=
 =?utf-8?B?RFJubXdiaGxxd2lHajNXVk0wbWcxc3ZESjRDOWlMcUI4UVhmNzB1Y0gvczY4?=
 =?utf-8?B?TDA4LzU5NVZmZ01kU0s3eU9GYXMyUFNjYlVJSkRkWHAzZG1PWjE2RnBTbHIz?=
 =?utf-8?B?NUkyOU9xTkc5NUM4MkEwVjByOGgxVmpBNlVHNFppY3RqcU1hYnNaMmdueWsy?=
 =?utf-8?B?c0V3bXBLSlhkSjJRcDhmMlpCczh6cDY2RXlzV2lJK25aY0VWTU81UmI3Z2Ny?=
 =?utf-8?B?MCtxQkoxUjFmaEh6Q0ZxbGhvZEliejdwNHU4MVhXK011dUcyR0hrU0laQkRl?=
 =?utf-8?B?WFg2a3BWQmpXZXBpZ3hBQmczdmpDbFlmaUg4VUQxT2ZvcW5US0VvQkZhdDNI?=
 =?utf-8?B?KzhlaHlISDVSMXRiTzdpdWJxZE9kWjkrMk4zTWkxL3lqcFpOV3RhWmNKMFZj?=
 =?utf-8?B?V0lWN3lLeGFyUkNHZklSVzhuRVFkZkJQRWxtYXg3OS96aWtaUWVoTWdnblVq?=
 =?utf-8?B?SnliL2JWNWEzbWdZb1VRZDVKeTI5dTRiS1JmZkQ2eGFYR1FjNDQ2VmJrMlF5?=
 =?utf-8?B?Zmg2bUZyMit0eUJjVkF5cytaQmNsLzlpbmk1dlR1OCs2OHBwVTYxcStRZzdH?=
 =?utf-8?B?cVdLdWRwWUdFYnJVOUJFNTR0S0xpMGx1RFgxRnVXUHdEdERMVTZFbGtzVXcy?=
 =?utf-8?B?TTU1UmF5ZUVtWXRjVEpCSmZQWGpJUDNMZUV3RGdMNDNxMmdJM2J5NHRNV3Zo?=
 =?utf-8?B?YzYvM0pVbkdTWlJ1anRib1JlaTl4ZnBDWHhMTXFmL0Vud1h4YTlVY2dLV2tk?=
 =?utf-8?B?enZSTXFUaHRWUjhwVTI1YVg5NFZZa0s1L1BnaFJYQ1lhdXI3RUorVTUyVklu?=
 =?utf-8?Q?abcxmjW8ZywFZK7nCxgvSO1DZ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d392665-a564-4cd4-03ac-08de120690e1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 07:34:14.6658 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aXVpv2E4YgR38xArar1xmFsyscgcMZCyn9vYM4hS1pplI15UOSPzRoflLlo7GHUhC/Y5fpejxUQ0y8TSD5xb/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7737
X-Mailman-Approved-At: Thu, 23 Oct 2025 09:57:06 +0200
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


On Wed, 22 Oct 2025 22:00:17 -0700, Tanmay Kathpalia wrote:
> Remove duplicate #include "regulator_common.h" statements from regulator
> driver files.
> 
> 

Applied to mmc/next, thanks!

[1/1] power: regulator: Remove duplicate include of regulator_common.h
      commit: ff416b1dd13a4ed5905db11a929fc8f574756623

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>
