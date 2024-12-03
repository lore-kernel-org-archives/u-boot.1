Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71A94E64AB3
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 14:38:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E214F89697;
	Tue,  3 Dec 2024 15:38:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="rONGT+r6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D88F8967D; Tue,  3 Dec 2024 15:38:03 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D42EC89677
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 15:37:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tDb+4AmBt7OUtuAxkPle7WMuLWR6ZR7msw4Ate0xXT83w2Ukdik4upMadI4aLxBbxyV8NJbHTP2+8Oj9KllqcZfyeUM1xt5hAL9aWkQL6TR2PgvZg1si9niUblFJnHdjnfjyHV+thEpHeZ0rteoe8w/EMN0NhET3ZJX6TFPF5ozgZn8oC4phDBy3cmecb9kwBkp/9BWmm2jNs1yTHa7x18RRXwBticA4E+k9Bj0YSy5VPjQAiUlDmdGYwVXolDYpA94zE/NbEhTOfofFfeu9rJW6GC3y6bEO2i96Kw0eQ0/53uOwiEF77HLoDoqAxviDfuMRb8OEariSpFCNi2/aoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9CM+w1Qs46hjbGY8yAsNNbFS/+QqqX5LWlgGc1fSk/8=;
 b=nenfsvcFt/vU64Tyrc46AGWA4BnNP3YV0U8AyXSpcf49kiU9B3K+biaWf2Z3tgJQ5dLRQfbdPBB/sPQKJXnMI7WLMAFuyeGuzD9KiPylEuVGo/Qe0P+nw+iozJhxPrRYgimMu2hdk/6rHtiIzWdQlGM8OTNOszdT70lMeu1ltuBMqXVGRUik4uGrfdij4qswQ49mzpeH3lNvzLtSdSy7I5fv4Gqg4q6e51RaknCotR3os2ZOHD5k0xLdYt8gPEICc2p3hMk2okSF0U1tk2anVhwZvmfVcYdcwE0a7EIsYQEO47mcJ9XB2RQbFfCjCdFvWx03OKvDrv2B5joTmavZ6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9CM+w1Qs46hjbGY8yAsNNbFS/+QqqX5LWlgGc1fSk/8=;
 b=rONGT+r6y3AO8gWvLSCKarbwzBFk0PUWsO8JnJAo0p4mvQx4lLGim4bC/HFFCDYh6l0UlCtCf8hQr8CzBcxrcAQBQE4tSdfZYI3H0P14xmiIMOVkHdLx02Uc2LaAY3ge0kBY6Nudw7sP1DkSuUMdf9gOqQj0/4X3ZPPxN1y8TLbFvJna5szenPAzjJBr5qpW8SXC/u4o+9do4QGHR9dXbeNm64LJcgdzUYUfR01+WyfMm1TP/1PC+EQJ/em7VsjzVXp4jfVkO02OKqD4BC9YK/xhPC3+ihIPw7MRpjxx6JKff+YeWbIHpOo34b8PUXfPlMDx4cBZbG9ccivw+aB5Gw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB7541.eurprd04.prod.outlook.com (2603:10a6:20b:29a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 14:37:54 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 14:37:54 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 03 Dec 2024 23:42:47 +0800
Subject: [PATCH 04/11] imx93: Update 9x9 part fuses checking
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-imx91-v1-4-48d2eaa4519e@nxp.com>
References: <20241203-imx91-v1-0-48d2eaa4519e@nxp.com>
In-Reply-To: <20241203-imx91-v1-0-48d2eaa4519e@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: JH0PR01CA0025.apcprd01.prod.exchangelabs.com
 (2603:1096:990:5a::19) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB7541:EE_
X-MS-Office365-Filtering-Correlation-Id: f99c6421-dc91-4d25-645f-08dd13a8125e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YnhYU2s4MmV4aFdvYVR6ME9tUDhBREVhZlVRNHMyb2p4ZVhMdHR2VWxJZFZl?=
 =?utf-8?B?bG9lWDN0eFROYVZpQnNjangxK0k5MnhLZmZ3Z0E1RGxyeHRLWXJFMi9aTEdI?=
 =?utf-8?B?OTZPT0dZcW5iTExwVXhwSzB2dHRDVG8xUUp0cnFxaG1RZS9HR2V5MTFPaFYw?=
 =?utf-8?B?a1c2MXd4STdKTUg4cUZ0N1pGNWc5eTdINGp3Ti9PczVWVzhvRzA4K3FuWkc0?=
 =?utf-8?B?QlZOb3NvREtJV1ljTDNHOFB5ZjlpQk02T3BHZGRkYXgvS0tJQTFaK25ESy9K?=
 =?utf-8?B?TFJEWThEVklaWkdzbDFPVzNhNjhJdjlFSXNCdGZ4U1Y1alhkamgzUExTaStB?=
 =?utf-8?B?QkdZNjFWNEVZYkJPQTZQQ1Zuam1pUys4NnFKcTE3MkJQWEV6dytzRGtSeWxh?=
 =?utf-8?B?WUx5cE5zaHRyOW1TL1RyMm5USnhtN2xseTBtMzhVd0xxZk9uME1ISTlOeU5S?=
 =?utf-8?B?cUg0SU1mblQxSS9iRHJLWVpLeGdDZUNYQWNYd0IyRmlSU3Qyc3U5YU5FMnJW?=
 =?utf-8?B?eE9KdTNUK3dmakp6RTk0Wkw0ZjdsdVVMUS85M0JOVFV0djYzczdnZmg2M1Vn?=
 =?utf-8?B?MG05ZDZ0dWNaYkFnNERQcCtLTVhZQmI3UlZxWFJhZ2NRQ2hwQnh6VDl0bjEx?=
 =?utf-8?B?aGRMRVo5V0YxMG1KNHlHZld6S1B4d1M2YkZLRzBsbFl6dDRhMVhLRlByckRK?=
 =?utf-8?B?UVZpaC8xNGFuSVVhRlRMVWJ1UlpsTFhoUGxxekEyMnpJbnZ0ZXBzU3UxWVpy?=
 =?utf-8?B?ak1jbXNEYUZiQUVSbTRUWlpidGRBNERTaGk1Wm9SYmdvWUc4SS9JT0Vpaml6?=
 =?utf-8?B?Z3hpQnVNc01OVW15T0xESDZoYVMrcXo0eXo0N3kzb3IxUWN6VlRpNy8zNk5o?=
 =?utf-8?B?T3lyR3dLYkZIZk1PZm9GbVJlRHZwY1BYV283V010VzBkeVpLc2EveTZEZ25t?=
 =?utf-8?B?WXJBanNFR1pHUTliREc0dU9TVlljbHowMlBMOThWTXgzV1crRXBUQXpLK0U1?=
 =?utf-8?B?Zlo0Y21tOXRja1o0RjZ4M05ham1LUU5nVStNWDgzQ3VNdlp5eFRCVm50blRu?=
 =?utf-8?B?RHh0K3FqYmlnMEMwNjlQQzl6aHllMnp3VE5NK3BjYStsVzdBMW1XeFFIY2tI?=
 =?utf-8?B?SlpVdC9SM2xGeUlxRG8xRjl0WFphczlnUXFwZENRaHNvbHE5UndUZG85Z3Fl?=
 =?utf-8?B?RDM2dXIxWTJmdnhrOVNUKzJiNjAwUEFjN2U4ZFZqVXBGS2xzSWpFNEt3V1l5?=
 =?utf-8?B?dGlkUEhmUWR3RGtLVjJodWRmMmVKNjlDR1R0SEQwL2MzUnQzSERIVnpIL1di?=
 =?utf-8?B?U0k1T3ZZQzEwdHNpb1dPSFFldFlHd3c0d3ZFT1BlNTdQZnpwYkMvR2dIY2w0?=
 =?utf-8?B?VHJ4cWd6STFwZloxazR6ajF6bmxoRWVZL29hdTF2R2NxR1o1MzdDalBUaHJ5?=
 =?utf-8?B?eWRLa0NRWjc0TkZ0czZaeEg0UXl2cWZxNlA4VmhVbHZiaitWYkVhNHQ3N0RJ?=
 =?utf-8?B?emZRdmo5akZZTDdxWDJiQm5BNDJ4TmtKT3Z6WjJ0WEpOenY2eTBtR0poMjA2?=
 =?utf-8?B?ZndjV2w4eHBlTnhWME5sbVZETWJ1SGdwYWZ1MGRPcERMMGN0THFDbzNzeGNx?=
 =?utf-8?B?dlZpTmFWbm00eTVtS2NUVFF5VXJ6dkRPMmx0ZmlLaDhPajVKRlhEWW0wSXV0?=
 =?utf-8?B?aHpsQS9KYnVkNkVXUDZScDdVYjNnU283MVZERS9ZLzBkdXVEa21pV2dRdXhG?=
 =?utf-8?B?bEpidTc1Y3JSZGlkZ3lFVWhsNU1yQjNONFZySDZlOFFVa3dGYjhMNVRwMlNa?=
 =?utf-8?B?RlllSXNXcGxXR2htN3R5S2c3NTU0a0xoMEJCYmdBVGdvcGdvTmh2RU1EUXlz?=
 =?utf-8?B?TmFiL2JrV3NpVDluNkFqNFpkaVRMK0NtUVVYalFkRGM1V1E9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eE5qNUg2MWM2YlFLOGY2U0RaVU5Md2ZyRjFaTVA2WnZqTVlORW1qcnpOZ0hB?=
 =?utf-8?B?cEVwSDJOOFRKdWc1c1ZjUS9VS1cwdnpMOEY1ckVlUWFxKzJqdEZYMjIweVkr?=
 =?utf-8?B?OHJTbnNJcWlzZUJQbkh4d053NEk2VzRjS2I1ZlZqOFF5ckphaHpqQUU4M1or?=
 =?utf-8?B?bFN0dXdsTVp1aTRjQ3hpNXRNRW1hMlIzUUxEN1U0eTA1cW94ZUFHT1B4S3dM?=
 =?utf-8?B?RXJOcW1pSGRLNElBVndSdURjeVNUNEV0cWNpQ09NUDdHTy9OdUZWNHlYaDlm?=
 =?utf-8?B?Nks3T1NuTklMWHZ3ZWZsNDRFVVhURFg2N3J5bWRQYnl0WldiUGUyUk5ORmJO?=
 =?utf-8?B?WmUya01ta0h4c1ZMNi9IODUzbk9NTDFmUmFTOUtOSzRmMTNvZVBISXRXNzVj?=
 =?utf-8?B?VFVqY0hXK0F3N2ZvSTNkNHpmdjh2ZHdyYlIxYm1HSTJsdVRZU3VkY2Z6R2xa?=
 =?utf-8?B?UTBPb05WUTVrZDZaZmJyRFk2L2VhYzdiWTJ5NXdZRnhXbFdLQjFKNzFqVkU3?=
 =?utf-8?B?aVRJOWMvVDhDRnZ3SnFwQkQ5NlcydElzb1dzZ2U4eG9UZ0ZlKzJjNlhEaUE5?=
 =?utf-8?B?U0lQVXpYSkRramVicjBLNGphalVsZXFVd3pmVndCMS9WV01JYkluNDdVSUdZ?=
 =?utf-8?B?MUFQR0Z4SmNnczhaek9MeDBsem9vVThDSE9vdUYyY1ZEZkFZVVI3MGdnamtY?=
 =?utf-8?B?SEJzUzI2ZnNmamVUOUJ4NXNNb3dTNmRCZzREN2EzZXQ1WlNuc2hZdmdEdzc0?=
 =?utf-8?B?eW5kWXV5V3M3Yks5Qkx1ZHlMTTBnWExBY3ZsYXdkVTlBcDFDMU1wZmIzWm5Z?=
 =?utf-8?B?OG9TeWczN09ucFR1WEhkaXNEMFlrNFJhNTFvaW1DTlM2MzlrR2VBdmlaTVVW?=
 =?utf-8?B?UEc0U0JOVlozc1JqUFZhc1FDaEJLQlc1YzlpeElZWXM4ZXZIZFptUGlzdVVP?=
 =?utf-8?B?all3aDRRcmtWaVhNOEgyWlpRNnJBZ0RjMkVvNmJ3SENrMUxYdmhMWTFvTnE2?=
 =?utf-8?B?LzlvZUcwZVNPNVgzNUdqdEt2MWc2V2Q3Mm5wQ2lMSWpWSmNtS0VKMWtrSnkx?=
 =?utf-8?B?bWFubzdQTmpuVXFuT2huQkMvL2daL1FoRit3cTBrRlpkUm9aaVZnZ1dPZ3Zv?=
 =?utf-8?B?ajVCVmxNYlRROFlidWs3cmZMQ0llcFIrWG5vQVBFWGJ5MnVUQTlPTFZ2L0FX?=
 =?utf-8?B?MGRYLzZ2QWVrN3ZiVFJSbkRjWXc4cGpwOU5IV0phWFlMSmxVd2tQekZUSDFu?=
 =?utf-8?B?UFZzTHUwemJlbHlHWWhwNnpXRklYZUFKN3lZNUh4UnFuM1E5c0ZzTEJLSnZl?=
 =?utf-8?B?OSsvU3BDUHJGbkRqSFVWcFZoWTRRUkYySmRNR3NiWTRwVEZQV2hUOTJ2S1Ft?=
 =?utf-8?B?M1Vaek5wZ3gzR0xjais0aktJSVRTS1U1ckg3QlR4YjBEeTNlVWlEMTFGQyt0?=
 =?utf-8?B?V213d3dVQkU5RzhJY2ViOXRBU3BhQ3Zra2pHN0lZRmxTaExyM1dwQytHWVdZ?=
 =?utf-8?B?Yi9PcFA4MjZlUXRaVmVWRWZLVVdtOXROZ3JBY1RJcGIxVDhXTVVVcTJBbVpG?=
 =?utf-8?B?Mm1pd1NNOHovMm91NnFJRjYyd1Q4dXNMekpnNzNPQ3JuUTF1Ly9pdVB3N2w1?=
 =?utf-8?B?RDR1cWxCcWM5Y2ovMTBJVWtDdW4wajR3VEFIbGxrR0VlTVY2Y09oK1N1NTlh?=
 =?utf-8?B?RU02U211NDYxK1g0bVQxQUNvcThXYWRwaXBqSDV0eXhTWGRJeFQxdTluQ2oz?=
 =?utf-8?B?WWlHTDQ4bUw3OG50TWtxWXB2cG1XdU41ckJra0tRNW1ka1Y2RjNvRjNaT0Jr?=
 =?utf-8?B?Q3hDekRYYXNoaTRXcUpOSmZyd3hBTEt0cGlZMTJTeXlRZVc5L3l0d2lFa2Vn?=
 =?utf-8?B?alRsTzdjQnBpd1JmZHYyWUhOTCtSWGpIdEN3Y3dyMzN1YkszOE5BSGs2Q2dG?=
 =?utf-8?B?cVN3M2crWldvL0s0RlJqekdCanpncU5KRTZMb2RmeTZ0NWhJbmU0ZEVYam0y?=
 =?utf-8?B?Zm5lZGdENEQ4OHJqNlQ4T1c4R3NsVTVTTUFCelJ2NDZxOHVRTmhBREs3RmVC?=
 =?utf-8?B?M05NZTVjeHZxb0c5d2F3cFYxYlBidm5zeU5BaVl4QjBvdGJaTzRlT09UdFQv?=
 =?utf-8?Q?wVcQdXEc7rt+hBie1nCFsLH4N?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f99c6421-dc91-4d25-645f-08dd13a8125e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 14:37:54.1412 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LLRtLX33iG14xhepOI4gUjtf0YkbkkC/wIwY7ZxBA9KZQL3xEWPBgY8y1zSit3+4gWTccBJJ7TJ2wYqvGQjVGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7541
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

According to iMX93 fuse burn plan, all 9x9 parts will have USB2,
ENET1 (FEC), LVDS1, CSI1 and DSI1 disabled. The codes missed ENET1
fuse when detecting 9x9. Although it still can detect 9x9 correctly,
we add the ENET1 fuse to the check to be more accurate.

Fixes: 58da865e27f ("imx9: add i.MX93 variants support")
Signed-off-by: Ye Li <ye.li@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx9/soc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/imx9/soc.c b/arch/arm/mach-imx/imx9/soc.c
index 6837ac82b05159899d294e01a0fabcc064ff82a2..d30a3b0a5f5944b536b4c7fc29b4aa80a91eff10 100644
--- a/arch/arm/mach-imx/imx9/soc.c
+++ b/arch/arm/mach-imx/imx9/soc.c
@@ -195,7 +195,7 @@ static u32 get_cpu_variant_type(u32 type)
 
 	bool npu_disable = !!(val & BIT(13));
 	bool core1_disable = !!(val & BIT(15));
-	u32 pack_9x9_fused = BIT(4) | BIT(17) | BIT(19) | BIT(24);
+	u32 pack_9x9_fused = BIT(4) | BIT(5) | BIT(17) | BIT(19) | BIT(24);
 
 	/* Low performance 93 part */
 	if (((val >> 6) & 0x3F) == 0xE && npu_disable)

-- 
2.35.3

