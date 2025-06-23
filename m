Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C67BFC7115D
	for <u-boot@archiver.kernel.org>; Mon, 23 Jun 2025 05:52:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06E5982D4A;
	Mon, 23 Jun 2025 07:52:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="MYw2ADIT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D730382D34; Mon, 23 Jun 2025 07:52:23 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E028882D17
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 07:52:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QuZWa9ou33MPEHK9MS79LmveeQQ2EGZSrEEQqbOX0a1al/OhDt2IOoqBl68AQGhKUKp5YrV3Zrq1ihek0b99jRCV9oqX7DP0+4MwKY88YBBctU5qJgZSRYjZj9HYMz6myT1svWPq6IbTCSmJijuZux8s6+bOyHHkzq8pLxNhS5deEF1qd5uK8ArEBzSSfcpdVeKSEkL8elSXfI6QcJBuLlOOOEg4cl4uRro290Zqa7UqbJ4gjO7P7R/K2xCsjxty4yRgMw4GWM/HGeeBlyk+8FCHOgCtLw0zE0aVe16O7peKHkyvGIbc+W65DI4nzzK78MW7ZLevEflDMwjtkZVw4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=st9w3HryqeA4Gp/5uS8C9Poqzv5gRgITyo4qNCAVCm0=;
 b=WXzuMLlY+SfFJ1PjWAz2G9vObMrWm/RpTsbHB1fLLOr+BGXZS8aOYyYla+ssgvizIwOMLDwglrJjcAerDxVf7rV0pcmyAUQ0WmcW8/FBU2dkP7ltNfNNXWonsFLUiERWp+Clt441ggNHbqaboRbzVyhaeQ6uvBuCqCURFr8jLOWEWMhsKa3o04zkQQLGrMv+5clh9ybIjpI8ByjcsQxxEWFDUWfEI+3P8C8BrIPlKRvPRoJQNGLgydfsY+yhXZMorMyQJdZKr1NaaalKroa6g649grWKwa8ocW1hE5hvhQeGFlMUD0Znjj2yPx4qUNgBXdxNiDSbIS7wWzalIn7eFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=st9w3HryqeA4Gp/5uS8C9Poqzv5gRgITyo4qNCAVCm0=;
 b=MYw2ADITNiLO1woPQoURv1Z8ttJndYvjYMntCESM67bJ5MCzZ3dMBe/eokAfkSuVB/T/z81+tJLJu1vcb7w0c9EnhXajGqIhUV0k28Hiihjff+91yPPyJFLhAcgyKAeR1I4shPgMSH3jNhwQ6/xEEWiiCZnLpF1iby29gUg0AEsN+7nSWznoSQtHnxZidQ+0Q49BjESLIfF0cYOSoklanp1NqW0wSfIOxjQjblNbp7eZqqLhNwKVVvCSuSZZjplWBZ6zo3AuqSP3KwPyLP/AYzShIWx49VvtWOp3J/HKR73qKpQI0dEbxqewQU2wDgOQ+RiyDzH/YOaeI0b3BeQpOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU4PR04MB10671.eurprd04.prod.outlook.com (2603:10a6:10:582::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.26; Mon, 23 Jun
 2025 05:52:20 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%3]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 05:52:20 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 23 Jun 2025 15:02:29 +0800
Subject: [PATCH v2 1/5] imx8mp: evk: Add support for capsule update
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-sr-v2-1-e97fc53f0f8d@nxp.com>
References: <20250623-sr-v2-0-e97fc53f0f8d@nxp.com>
In-Reply-To: <20250623-sr-v2-0-e97fc53f0f8d@nxp.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SG2PR02CA0077.apcprd02.prod.outlook.com
 (2603:1096:4:90::17) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU4PR04MB10671:EE_
X-MS-Office365-Filtering-Correlation-Id: f4b6282b-22f3-4c3f-b28b-08ddb21a1e25
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Wm1INUYra3NLdXFtMzVJV3dJNjBFV2JYSlJ4TTA0d1VFcmVCU01Ic1NPK1Jr?=
 =?utf-8?B?SUd0SkpPcVBLSHBERzE5aWticGphb0pwcVkyaUtOZnI2aWZWZCtGRlNnU3RK?=
 =?utf-8?B?SmVNTlJ1OVZjRWlYVmdqOW1rLzMzdHBRSHpkZm1JQ3VjV2UyZ2w5Ym4rVDFx?=
 =?utf-8?B?L0wrQkJmeUN6cWd5M3Q1VDhWT1oxMm81YVpTbFJQUGFOd0NCTlN4SGkyaGIv?=
 =?utf-8?B?UjFwUEpBVERhcHdCTWJaL05rZk5DeXI2NC9aaHJPcnY2REhLcDg1UmR3N203?=
 =?utf-8?B?bklXNlA5WmtUSk5qT3ZjK2hRTWY0N0FYOVJBMjFnSThrUU1mQWcrdmx4eldI?=
 =?utf-8?B?S0NSMFdYeDd1dEdmdEFuTnFRL1NqK0VwS2FpZkpuOEUyUTlkcEQ3M2dZUEdh?=
 =?utf-8?B?eit4T0ViTEFOZG5aZkN5SDFGYlRPTkNrbzUrOGtPTVVEVjNBdk8rUXM3K0hv?=
 =?utf-8?B?WjZNWDhSUFBLVFE3R1lVMlh1b2NFM2NicndvOGxRdU4wVS85WEtSRER3SzUr?=
 =?utf-8?B?UDEvOWdmaythdm1ubjRaUzQrOFBzb1BJWXNaWktMS3dObEErVk83V05ueFh2?=
 =?utf-8?B?T2JYV1Q5REt0aFJEVnJldWZNNjNzQ2hMQ3haYlE2dUNJOTRmRDJvSVFPd0h3?=
 =?utf-8?B?T29YWWhGSmtHakhDbVM1ekkyRDJldUpDTWFrT2lkT0RTRFJPaFVPWWUxdHo3?=
 =?utf-8?B?Z0dESlIyM01tUC96aWlKSVZLQVNPOWVkcXBKZUVGUWxRVmxYTmxOcEE0bzMx?=
 =?utf-8?B?WGFZQXdpRnpoK01lZkNsWHpGeVBSQU91TTBSSExZWnQwdU1WL3R0ZHRLQnJt?=
 =?utf-8?B?cWRTUjBSOWVRdUVqWHlybHJBcmhqS2lseFByNzFaWHAvSXNIUWtLQkhSWGM5?=
 =?utf-8?B?cEJVd3UyeGFGbHVtaXBabUpKVXBFVW5VeUl4dFFHcGQ3UzhEN2tqUmhlUTRj?=
 =?utf-8?B?MVlqR2hWRlhyN1hmWmh6eThURCtqbTRweEIxM2V5VDh5U3Vvb3lFSGtMYU43?=
 =?utf-8?B?M0dNK1pNa0pySzRCakxwMU4vTVk2RHNldnpmbUxFUlhGTnlDR3ZOc0x3T1RQ?=
 =?utf-8?B?eXRoSkJpM1RtRGVNWGQzN1FJRzhjQ09EUmdiMDB4UC9nT2FoSDZLUXJEMTU4?=
 =?utf-8?B?OUVjWkwrSHZLT0huZ0hWOVBZVXhRQnpiZEJNSGJQK2NNZXY4R1d2d3NCQzFY?=
 =?utf-8?B?aVg4aUtWeUJZVzRueUFjOUFUT1lYUVU0TUJZdEx4bEE2N0Z1Q3RmbWdjN285?=
 =?utf-8?B?YnVndTFVaXBNTThnMGpGakJ3U0k2NWx1U1pjMFBQVnhCWmhUcUZFM3M1MU5N?=
 =?utf-8?B?Rm5QcDliNlFMNFhpaldUcGVIMCs4aGN2L2tiQ25CQTh3a3E1cmFaOW1ySnFO?=
 =?utf-8?B?ZzZPem4va0xidnZZWjNDVktmZ1VSNVY1NjNzV0hJek85dEw5UXRqajRYRFpM?=
 =?utf-8?B?OEdyNFNFRC9hQmZRdkszZ3dKMDlkeVFjM056Z0dtQUtmbGhsWkttRXZJUWVs?=
 =?utf-8?B?U1dna2ZWL0xOWG1WU1JuZmFTd1dQYzJ2d2laSTNrUUhVU3c0RE9oOFNhdE9D?=
 =?utf-8?B?ZEZXanZnTzB5SEZEQ3UrakozR1FZejEram8wZG11YW1DNFZ2ZmVvTStIQ0R1?=
 =?utf-8?B?Wkkycm42UlE0OXFyc2Y3Nm1sY0dBWGxKRTlDSE5FbEZubVNld1pKMFBDTDNS?=
 =?utf-8?B?VGZ0RW1YbG9QVGdSaFl1cjlCQ0toTUpPK0gvcDZzVzJOc3g0ajhMc0lXNmZl?=
 =?utf-8?B?UGg0elFpSEFYWW5KZGcvUk9rUHB2VzdyTTVVQzBnOXRjZXF6U1RXR0RkWVFm?=
 =?utf-8?B?dE5sMW91RXA1dGh2a2F2RlhVdWJWUEl1VGpaWGZ4bXp6cmRRQWlTSnQ0M3dV?=
 =?utf-8?B?T0k3WThYYTU2M1M4TkVhUWtTU21yenpuNkpFck0yQS9LbVh1MWpXU05JZmZC?=
 =?utf-8?B?MVZwN3dKNjNUM3MxSFQ5K1A5YTBpRFEwdGN1SVJ3d3UvWHBnQTBzUTdYMlJ2?=
 =?utf-8?B?U1c4Vmo0MmZBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(52116014)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTFBdWt0emx4Y1JaK096K1FEcmo5TzVhQ2xkOUR3bmZLTHlZc2ZjR1ZrR29S?=
 =?utf-8?B?anZ6cEEvdndNMDR2SGVEc0F3OFE0SkE3MzFJcDBjS0JoSjRCbWlJemY1cnJy?=
 =?utf-8?B?MTNFZmNvUEhKWmgzbEZDOXE3LzBJc2dRVUdVRldkRUVnaEdLcmxRTkwwRDE2?=
 =?utf-8?B?VjJCSXF0cnZlWVV0NlNBZ0tTVjFaRmN2NnIzWkZWZkxIcUtmYnBxeXlnZGxR?=
 =?utf-8?B?WEw2TndGRlpqK0s4M2Q5ZTFocDltR2tOOG9BRnNCdTZFL1UrSE5DZW82RERn?=
 =?utf-8?B?Q3AzQXBFYy8vZlRUU1VEeXVGWW9pUDk4NFh5NWV1NGs0R1RiY0FDLzF1UXU1?=
 =?utf-8?B?VStucFQvUXNsQzRmMHp5RlF2TDdST2EyQmJ4TFVwMEhVNkpqVnhxUndBM081?=
 =?utf-8?B?R044RnVaajRGVnhvTUszWWM2YkNDN1BMb1A1enRvYmYyWGNoZWlMRC90RVdY?=
 =?utf-8?B?dW1ZU2YxcnhSQWF1akkyTVdNL3Q3S3Fqa0h4aElmTGVYOGxjY2dvczhnVnY2?=
 =?utf-8?B?OWJkN0tWMGFKSFVzOFB4NDNnbThlenRFL2tCWUpQY3BwYmtEamY1Z3M0REgv?=
 =?utf-8?B?MDROYXBCcGUxSjlkc1V0Z3NoZ2JucWxUT20vaVpIZG9CNDAzbldEelVmOXh0?=
 =?utf-8?B?OGtubkF2cmNMUFRDTjg0VW9GN05ZcGhxMjdNWkhzK3RGSFJQVXRYR3E4NlV2?=
 =?utf-8?B?Z05EZVBBaVRLOEQyczBVQWR0UjVqRDN1Vjh1UmQ0MzBkczY4SWJhZ0hGS1BO?=
 =?utf-8?B?cTg4NW5lbkVmN3JIaHBuTmw5bXUvYlJxWXJxVWVtUUtqa2xCS2w5UWJGMkIx?=
 =?utf-8?B?YzJ0NkhuUzhtWlMxTUxIMVBhUjd6dFJjRFNtNUZ1SmtJczRIM1RtTzJ4TGtk?=
 =?utf-8?B?TjduMXpzbTdiZm1GN1lOdHNaM3VyeUtIREEwcUhDaGhYeHRCN3JzSDN3TDRW?=
 =?utf-8?B?S1FNS2FTV3BWQVlOeTU2OHlsUWRwZ29EVWpZV2p5ZFczVkRZU2t5VndlQ0pa?=
 =?utf-8?B?QnI0UEZ3ZVo2Nmx2MzRsZDkwYlpRT1BRako0WXVnRG1Ha3ZEVm1RaW1heTlj?=
 =?utf-8?B?R0VSSWVTWWxydGh5cXJjVllNbmtWbmxQTU9OS2dZMExJcXhWRDJweFFDUVNw?=
 =?utf-8?B?YTdWNnlrRVFad1VqRWJWWEY4NEtlbnpHY1pqRlFRTGQyYW1sVGxtWlFLaHNV?=
 =?utf-8?B?QlhiNnJZR0VlbVZJTjJpSmYybmxpTWRWR2xmMlI0YTVaL2doUDBVL2FGNTMv?=
 =?utf-8?B?TnFDNEErSzFpS0NIM0JETDkvVlRlanpMNW8ra25aOEpzU2w5cUh2ckxqZWZK?=
 =?utf-8?B?YS9nRXc4Qi9jMzFFQ3R1Zno1MUlYTEdZNllZUkVpOFBoMFl5NWpNZUlUcGZw?=
 =?utf-8?B?N0IvMnM3dVBCUklacEdUL3RoWDZ3OVlCM3M3di9QVmRUYloremI1OEpuT2NJ?=
 =?utf-8?B?QURna1U4bFVSWDBJa09yazNlZ2dKL3FrTElSMXV6Q21SLzhCYzEweDBZVUYz?=
 =?utf-8?B?bmlqd2VYTVN5VHNqWk1Fb0dUa3NwWExaTWsrZS9XVTcyam9HYlVDR3o4ZXhw?=
 =?utf-8?B?NDUvTjBtK29VU3hyWFY3aU1CT0FpMWNJWVgvc05pMzlQaDg0NWlmdFpQdUVL?=
 =?utf-8?B?TndpQUNQb01NNVU4MkY2cVRHd2p4T1poMFpieHR2akx4UVpHRTZycEpFVmVH?=
 =?utf-8?B?RE9Lb0txTGxjbkRXRTczK29hamZqSVZ3WGd2SHJNbUdDekVNZG9zU3lmSXZB?=
 =?utf-8?B?eUFuZnJqT092Y25WSzRacEJkRTBqRndaL21raG1uTGJ5TmxhVnJPNU9YTlcx?=
 =?utf-8?B?bkdYb1B2UnhHbTZyTENnVjFTUmxaOFJWc3NxVjdLc1pzb0FqRWZZYjVKKzJY?=
 =?utf-8?B?S2srMVByRDQrbmRQSjJTMFkzemR4VGxxZWt1c1FJQUhEcFR0aXZOOVB0TnNl?=
 =?utf-8?B?S0lWbm01NFlzNnQrR3pZcnJmell6MHI3dFZRdlN2Uys3eGVselpUV0RrZHRE?=
 =?utf-8?B?U3Z0dklyS2hIU1lpZTZ6TEN0aThIdUpaRk9iRGY3T1BmNnZBZE1uN2tCbzdC?=
 =?utf-8?B?aUJCYUQvaUFNaEd5b3c4UlkxcUxNSURuVnNEOFJWblU1RG1zSnRZOWoweDU4?=
 =?utf-8?Q?xQDxjD+e9NtpalG7KAX+95jVk?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4b6282b-22f3-4c3f-b28b-08ddb21a1e25
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 05:52:20.2957 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WQirzvlWV3P6Nn+D1WroK+fhBDDeLmBgIxC8tHUmwvJnM46xo700trTfpryIvUYl0iT12U/M2YXfIbcInFC7Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10671
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

Capsule update is EFI based firmware update which is widely
used in various OS distributions. This feature is required
by ARM System-Ready compliance test. So
 - Define image array and GUID
 - Select configs for EFI Capsule update

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/freescale/imx8mp_evk/imx8mp_evk.c | 23 +++++++++++++++++++++++
 configs/imx8mp_evk_defconfig            | 15 +++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/board/freescale/imx8mp_evk/imx8mp_evk.c b/board/freescale/imx8mp_evk/imx8mp_evk.c
index 2ff067bc6752135f323398e620e37ef11d1b91bb..2a9ba7df2bb35d9daeaf9e7e4cf3c82c097e23a3 100644
--- a/board/freescale/imx8mp_evk/imx8mp_evk.c
+++ b/board/freescale/imx8mp_evk/imx8mp_evk.c
@@ -4,8 +4,31 @@
  */
 
 #include <asm/arch/sys_proto.h>
+#include <config.h>
+#include <efi_loader.h>
 #include <env.h>
 
+#if CONFIG_IS_ENABLED(EFI_HAVE_CAPSULE_SUPPORT)
+#define IMX_BOOT_IMAGE_GUID \
+	EFI_GUID(0x928b33bc, 0xe58b, 0x4247, 0x9f, 0x1d, \
+		 0x3b, 0xf1, 0xee, 0x1c, 0xda, 0xff)
+
+struct efi_fw_image fw_images[] = {
+	{
+		.image_type_id = IMX_BOOT_IMAGE_GUID,
+		.fw_name = u"IMX8MP-EVK-RAW",
+		.image_index = 1,
+	},
+};
+
+struct efi_capsule_update_info update_info = {
+	.dfu_string = "mmc 2=flash-bin raw 0 0x2000 mmcpart 1",
+	.num_images = ARRAY_SIZE(fw_images),
+	.images = fw_images,
+};
+#endif /* EFI_HAVE_CAPSULE_SUPPORT */
+
+
 int board_init(void)
 {
 	return 0;
diff --git a/configs/imx8mp_evk_defconfig b/configs/imx8mp_evk_defconfig
index 5b2c977edf8d7ff5e89e9a29de18603c14c7f3df..351d24657324a00ff040d80aa796a20c3daed947 100644
--- a/configs/imx8mp_evk_defconfig
+++ b/configs/imx8mp_evk_defconfig
@@ -23,6 +23,11 @@ CONFIG_SYS_BOOTM_LEN=0x2000000
 CONFIG_SYS_LOAD_ADDR=0x40480000
 CONFIG_SPL=y
 CONFIG_SPL_IMX_ROMAPI_LOADADDR=0x48000000
+CONFIG_EFI_MM_COMM_TEE=y
+CONFIG_EFI_VAR_BUF_SIZE=139264
+CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
+CONFIG_EFI_CAPSULE_ON_DISK=y
+CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
 CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_SPL_LOAD_FIT=y
@@ -51,16 +56,20 @@ CONFIG_SYS_PROMPT="u-boot=> "
 CONFIG_CMD_CPU=y
 # CONFIG_CMD_EXPORTENV is not set
 # CONFIG_CMD_IMPORTENV is not set
+CONFIG_CMD_NVEDIT_EFI=y
 # CONFIG_CMD_CRC32 is not set
 CONFIG_CMD_CLK=y
+CONFIG_CMD_DFU=y
 CONFIG_CMD_FUSE=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
+CONFIG_CMD_OPTEE=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_USB_SDP=y
 CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_CACHE=y
+CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_CONTROL=y
@@ -76,6 +85,7 @@ CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM=y
 CONFIG_CLK_COMPOSITE_CCF=y
 CONFIG_CLK_IMX8MP=y
+CONFIG_DFU_MMC=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x42800000
 CONFIG_FASTBOOT_BUF_SIZE=0x20000000
@@ -89,6 +99,7 @@ CONFIG_DM_PCA953X=y
 CONFIG_DM_I2C=y
 CONFIG_LED=y
 CONFIG_LED_GPIO=y
+CONFIG_SUPPORT_EMMC_RPMB=y
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_MMC_IO_VOLTAGE=y
 CONFIG_MMC_UHS_SUPPORT=y
@@ -124,6 +135,8 @@ CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
+CONFIG_TEE=y
+CONFIG_OPTEE=y
 CONFIG_USB=y
 # CONFIG_SPL_DM_USB is not set
 CONFIG_DM_USB_GADGET=y
@@ -139,3 +152,5 @@ CONFIG_USB_GADGET_MANUFACTURER="FSL"
 CONFIG_USB_GADGET_VENDOR_NUM=0x0525
 CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
 CONFIG_IMX_WATCHDOG=y
+CONFIG_SPL_RSA=y
+CONFIG_SHA384=y

-- 
2.35.3

