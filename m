Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42E1BE77188
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 15:21:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6467806DD;
	Tue, 14 Jan 2025 16:21:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Z0oay6LU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C93E8060C; Tue, 14 Jan 2025 16:21:29 +0100 (CET)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::610])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B120806DD
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 16:21:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZC1sKra8kp5FAO0QP8cbF3WoeqPOjxm5tSoKDWIlBxGwra6FJYOkW8WOHyfM3HIuI5EbK9px+2EcAJHHdwM8ggGJD5scKzeQusMMLPJav3kO7SlxpgJOptv0BiCBAJFhBYjK9iU1ZmeP/hfSxGBHRGYVmijVDEq9mnYoJRo6n3XkGbtxClMsv55Y0kHKcsWd9HDjnEOVgr0666sR2tQcJq9WxFqc256fOiY0YJHgj4nn8/+GeTlEf4vW556EoA6tXC8t0wEaXm2ZE4fnaKmSBagagDNClHHEUV/s/w+zh28Bw2WxaAQSUgwH6ywKTWQh0Yz5kxhJ70QPQz8UBzUmOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Roh9TugX00lFO/jzYURBBGMLUWDpXBLB6QuBXCy19Xg=;
 b=bWDyK08LiVf2RRv4iHHgviMsK87iB6U8CFmqr3WEl0uiTOxpnp0Ok34V5sobzxZ0CFnbTgMpTVF+8lyU43tkJtHCQyNk0sj6+lzlZBQX372ENeNdz3/DddgOHgLHNavQIMkSfPB+k4KDipfWPBNEoLn+jrns9xQJlL8f628Rip8RB4XmAzZ5miH+NChWIqTmthvkFiBD2m49vby5qBm+SOH1+UiyZK7IJfG6zroh1DrDoTII0hX7BAyDNStxfW0zVOBIsQ6MZdBCrAF92S9yX8gLSu72HJupUhdD1yIn1eJe6RQXEqFbH1V/pdfE8jZi3/8y68fbcI7/7PqwoFtAng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Roh9TugX00lFO/jzYURBBGMLUWDpXBLB6QuBXCy19Xg=;
 b=Z0oay6LUbxW78cvREunzudBC3e8ChfUTjC93vJj4pd/y6Ty6OVMGfb0EmEOTacDybzJIeYOKvpOxIHXcfGKS5+yujUeK+58cKK4BpKskIJT6LlYaxuRTnwmVb9340sJqWl444glbsUyB1bpWfgmVjNvN9rlxXxZ2gl2DU3KYGD4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PAXPR04MB8574.eurprd04.prod.outlook.com (2603:10a6:102:215::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 15:21:25 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8335.015; Tue, 14 Jan 2025
 15:21:25 +0000
Message-ID: <5f42abef-4aad-4f57-8396-6d8d17a89285@cherry.de>
Date: Tue, 14 Jan 2025 16:21:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] board: rockchip: add FriendlyElec NanoPi R3S
To: Tianling Shen <cnsztl@gmail.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
References: <20241226092043.419511-1-cnsztl@gmail.com>
 <2b658c60-480f-4488-8c40-f781a849cb32@cherry.de>
 <5d2fb256-cd0a-4a94-ba9f-f13a928656ed@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <5d2fb256-cd0a-4a94-ba9f-f13a928656ed@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0094.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::20) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PAXPR04MB8574:EE_
X-MS-Office365-Filtering-Correlation-Id: 0007d65a-aff8-4be9-450f-08dd34af1c1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MEJ1YXFmQVRvbk5tcFNuT0VuS0hEM0pOSEJMdTB3bGtCOVNJd0hHZ2VFenNE?=
 =?utf-8?B?NWtXT0M4WnZvQ1N0WUt2dlN2R3ZZU1I2L2ZaRUpBdDFDb1J0bVZJemJWdUpw?=
 =?utf-8?B?Y0NmY3FGOUJXU0djZm1MUTg2Nmx0SzNaVmJoeDBnRFQzMnpqNHNoSzZyMWNO?=
 =?utf-8?B?bGpjc0ZQZHdWSXo1YlZmMXVLY0ZzYy9vSC9YMkVpUlZIZERuTHg2dzRnRUQr?=
 =?utf-8?B?SXhLQWFkRHpXK2xMNTBJSjRzQWZkMHVnZ2F4dWlUNExqZG1jMVRUaXNmNmJR?=
 =?utf-8?B?dWxPZ1FnVEFwR0ZxY3I5ZjJMdTVNWmw0SUUza2pJeHpTWmoxZ0RLYTA4bnpE?=
 =?utf-8?B?NlNWSGVZeFJJOHZ1d1ZuNytsZlFnUlpsZVdQcWMrSXQwV1QwWk9MN0pwSy80?=
 =?utf-8?B?M0dESEFaSnlacnNtRnpJM1lia2FMMENPNFZ0K1I3MTV6MklxNXJIUmlQSm05?=
 =?utf-8?B?SXdIaEU2TkFnbUdKekJXSnJsRmpVRU5KOG05OWhWcW1mK21rbm9oMmJjWTNz?=
 =?utf-8?B?Y2pEb0oxell4SDlTQmtTQ0xIbm1FRi9wYW5BcTlkdkNJUkk5T21IU0xsUitX?=
 =?utf-8?B?MGpSdjk2dWpuOG5PY2svWlJ5ZGdTSzRRSDZjczdGeVB2T3p1VGhmSVhSUjJK?=
 =?utf-8?B?UTlRMlZXUVdoSzR3V1FkbWJHOUpqazlqaElRTXp0N0g2WUpvY2x0OVFNcHBq?=
 =?utf-8?B?UEhaY0RWRUYzZFhHWlR1UHJzT1RsUWVyQThIYTBORkZxeVFEUTNZbTRnbkk0?=
 =?utf-8?B?UWtKVmhLQmxzSmdqbko3Z0pVelVNeXRsL21sSkRvNFQwS2llMjlrb1dNNjJG?=
 =?utf-8?B?cFNTS2l2RGV4WEJWV3haSkJHTUxDVjRVTjBXbmppclh1Mi9zZGtCQ0RDWk1q?=
 =?utf-8?B?WnlTVXAxVG1XRUdVcUQzOHVoRUlBeTRoakFGRm14UzRqamRTL3ZUSTFRRllW?=
 =?utf-8?B?ZlJpbUZnTjJNaEg5TnJONEtsMGRZdkNTRXZWNEs2Z2VvT1JPRWJjbENUNFhH?=
 =?utf-8?B?a3h0TkxFTWtUVFNObUorNmY1NXhCTVlMRWVPUTQzeDAySzBtN3UxaEViR3Bx?=
 =?utf-8?B?YXpnSmlLV1FVYnlNem1BTmRlaWlqbHl0WFlSRUQxcE5Hd2tzN1ZSdS9ZSitO?=
 =?utf-8?B?aTk5OGREeSt4dTZuRFQ2eGRyaG8waHFWTjF4c0dyaDlFblpnNVI4ZVUrekJU?=
 =?utf-8?B?d2NPYzNmQXU0K0NYeTkwQ0ZlS3NWNjEvR2ZWcW9mWFpuK1h0b0lFRWVTdzNT?=
 =?utf-8?B?Z3kxZVBwaGNhSkdwRmNaUWhiaURBNURjUGpoS29kZHZUTTZiZU9vRGc2MDQr?=
 =?utf-8?B?K2hvTXloQU14MDNaNURLb052RnlLSFZQSmk3dmVsNEM4eU1iSE9ZWkQ4a2dI?=
 =?utf-8?B?SmNMeGFFU3YrL2pYRWRrVEw5WHd2alMyblNzWHpJWnR0TnhwN3ZWdjZwTjBs?=
 =?utf-8?B?U0o1Q0ViMUhkYk1NcFBZWTducHRLY0tIeUY1OGFScVpmMC9CQU11KzlmN1Bk?=
 =?utf-8?B?blptZjJja0hLZU94QWpaeHpEMUxLUXVWcklaamsyL3pjdko3UWxNM25DRFNY?=
 =?utf-8?B?R09NQlFIVmNyeUcycldpVExKQzZEMHNQV01DQ0NNS2w2SDdhRW1KOXJ0Mitt?=
 =?utf-8?B?SWs0UUh3VGFVaCtKYmpXMmJBbGRJVEJvTCs0cDBKS29hSURNYnc1a2Rxb0xq?=
 =?utf-8?B?K0NicE5Pd2JrUVEyRStmanFnbkFoQlMyMHpGa0xScUQ1SE1qQjd4bWNVVXZa?=
 =?utf-8?B?WlRwaVdSNkE2L1RCMzRhRXJsdk10dHhaRkY5OXBtZk1FVVZyT3lmYVJVVXNP?=
 =?utf-8?B?R3BRdU9mOCtQK0RpczBiWjVKMkpSOWhSY2xlOTVDQ0lIa05nNWdvWUNabFVD?=
 =?utf-8?Q?mt7MHwgAD8sQx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUUrVDRGM3ErNFA0WFRrTnBzbE56NzBUcHgwQ1NnZUxJTlhzUVJGRmViVFNm?=
 =?utf-8?B?dnQ0QTIyaERBT29BM1hSV0pRZXhuMTFCZU50UFVtZElpSXJHTGFKLzJvOS9S?=
 =?utf-8?B?d3h6SXR0VUtvd3Q4VDdMaER0L3Q5eE5ZWEluc3JJOEVENW9qMVdWRHlLT1pq?=
 =?utf-8?B?U1NENVU5MXozSWowa0xpWndEL1JDVUZpbDZlLzBMM0hoRGR3eG5xUFBNaFhC?=
 =?utf-8?B?OFpvb052TzhkZmtDM0NqQ3cwRSt1T2YwayszdmlkN2FPdDNBb25qQ1FZemVL?=
 =?utf-8?B?N1lWcjJiYzllL3JCMG5td3BsZDdORW1DLzdVdDh6dWpWOGlwY1hRbFhPM2Rk?=
 =?utf-8?B?NGFGcXlFRjZBSDVRLzlrWDVBMXBaR09nMzQrbjJ6ZEVSbjMrQzVuOC9ZN01s?=
 =?utf-8?B?R3pTbnZjRC95K0tiVkFSc0kvQThEVTBya2JLUDU5cHUzNmNmWnF5YmRURldx?=
 =?utf-8?B?cS9RdU1kbEMxUnBaZ003bnhxNUc2VmxITUVlcGIzbGhKakRZNXlPY1Q2ZkRG?=
 =?utf-8?B?UjRBUzNKTkdIRlg1NU5ReWUyYmZ1R3VsNVorWkNqOXB6QzMyRkZPRjhLZWF0?=
 =?utf-8?B?cGdkNEhkSjF0VjdsOGhSRndXKzl1b09PdXBvalNEUEpCY0FCRTBrU3UwWHNs?=
 =?utf-8?B?OWkrTUwwNm53YisyTUtTQ3YwSzRCYm1hWGEwdy9aYVQ3enJkc05Xa1A2TzhQ?=
 =?utf-8?B?MzRXU09nd1BtMUVzeHBRSXJGVTBrM2JMNkJKYTBnbVIweGwrcDRDZkJEc0N3?=
 =?utf-8?B?czJVNnNHZEJsOWxxQWUyd3Eza2lweEZ4WkNPYlVmNlJzTHlWeTJJbzNVMkZy?=
 =?utf-8?B?UjRBS0poYk5lMUtDTHpqeXdlbXNTajVRa2xNdndwYkZBVUVtVndlNUdySnp6?=
 =?utf-8?B?cStjcXVSZkFhM1ZCSUxTMndZandiZjRNcXREZThHMVNESGhiSEhNUFVqOG5E?=
 =?utf-8?B?T2htNGJtbFEyWDFRUE9RTVNOcE1uSFRRSEptdUxDaG5hNmEwSW9MTkhVckZB?=
 =?utf-8?B?NUtsOU1USmg5aC9tdVdYTFdHUkE2a2JHbk9mb3dzZmg3SzZnNkJ5dkNiM3dK?=
 =?utf-8?B?clpuaS8wZkJUK1hlTFNjMlcrd1UvQ295M3p1c2dxUkJSTlBLaUljVTVQd0U0?=
 =?utf-8?B?MzZzSHVVYlJJRnZQcFFKMEpUL1lRU0VXWVpzUFRjM0xHYlV6S2NZRGdnNjgw?=
 =?utf-8?B?K3FkeldQTyszVzZpaEFsTHJNTktsSFc5RzRhdWJINFlzckkwVk53SU03RWdq?=
 =?utf-8?B?c2MvdkhzTURCMHFKbEVKYm9aQjNoQmV3dzc5N2VmbXQ3eE9WZGdYQ0FEUHA4?=
 =?utf-8?B?ejRGcGFYV1pJNHpEMmd0SUQxOXZ1dUo4SDFXbVRObDJNZ08vSmdVWHFRKzhV?=
 =?utf-8?B?cm1IQUxCQkNDRnkrVG84d2pSVE1pUVFzLzFLZnpGU0VNck8rMy9PMitHMU9R?=
 =?utf-8?B?ckVSZ3NEN1IrWDRlMEwrTkZ3WWk1eE9FdytxVkRZR2FUOVRVZHc4OVd3aDVh?=
 =?utf-8?B?bVllbUdJNkJBSDVCZ3F5eGJqTGpvanlyNTlEQXVzOXZyd2lpUGdLSStVZjVh?=
 =?utf-8?B?K3ZzeGRLYXh2eCszVzdtNHUyNEdoUjZVTG5PV1FIMjJ2aDFKL0ZsUElSRk9k?=
 =?utf-8?B?am9mZVNXSGFBOHJKZzJxRjJVeGNZY1ROU2l1T2ZTOFpBdVJDa3JlOUkzdTM0?=
 =?utf-8?B?YVFva2FJTFlmMEpSVVAvOEt2SmM3QW5KaUs4V3pUU0RNdUo1TmNna1h6bWdp?=
 =?utf-8?B?YjE2WE9Mak1oWkh1VTNSakMxZVhob2NXaGsrS0lLdk5kSjV4eCttNS9lV2dy?=
 =?utf-8?B?MXp6TGl1Zm4zVVFDWFlObEJwcW9rcTJsVHRWNElZWmVNZkN6d0I2aHpOVmpJ?=
 =?utf-8?B?R0I0d0h1ZXlBQWQrRzhNNVd3UVgxQXFmU2dIdUd5QlF6SVZYVVFYVjhDdWhD?=
 =?utf-8?B?YUpxUENuTWlvZVFrTy9LdldxckwwQUYwamNEb055SHZiWnREdWZUSk9Oamd5?=
 =?utf-8?B?K3MyeXoxRUFNd2lyeEJ6TWcwR2NCRkladVRCbFBTSnFsV3JETzZNT1BJL2pT?=
 =?utf-8?B?K0s4NzFsTVIzWFBBUE1Ua0FyNjhTNFVWeEdNbTRmVzJ4ZnpMTjArV215aGRp?=
 =?utf-8?B?bEIwd3hhTjRQTm4wY3VTM3JCbXFzT0ZVekp0bkNWYjUyWkJmL0FsMUdOWDJQ?=
 =?utf-8?B?amc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0007d65a-aff8-4be9-450f-08dd34af1c1b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 15:21:25.3099 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RKbY3lza34fuSmwIdOlm+bE3GPzeKGtnKbdWiV2j6W/Bx7FRaQd5VMZJfeDjVGfxrDsz8P8Z0ilXolG9ufbybNfCS+8Atrc5lsY4o9cNzi8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8574
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

Hi Tianling,

On 1/14/25 3:49 PM, Tianling Shen wrote:
> Hi Quentin,
> 
> On 2025/1/14 22:39, Quentin Schulz wrote:
>> Hi Tianling,
>>
>> On 12/26/24 10:20 AM, Tianling Shen wrote:
>>> The NanoPi R3S(as "R3S") is an open source platform with dual-Gbps
>>> Ethernet ports designed and developed by FriendlyElec for IoT
>>> applications.
>>>
>>> Tianling Shen (7):
>>>    arm64: dts: rockchip: Add FriendlyARM NanoPi R3S board
>>>    arm64: dts: rockchip: fix model name for FriendlyElec NanoPi R3S
>>>    arm64: dts: rockchip: replace deprecated snps,reset props for NanoPi
>>>      R3S
>>>    arm64: dts: rockchip: sort props in pmu_io_domains node for NanoPi 
>>> R3S
>>>    arm64: dts: rockchip: enable eMMC HS200 mode for NanoPi R3S
>>>    arm64: dts: rockchip: reorder mmc aliases for NanoPi R3S
>>
>> How did you backport the above patches?
>>
>> ./tools/update-subtree.sh pick dts <commit>
>>
>> is the tool to be used, it should have added a
>>
> 
> Thank you for the tip! I did not know there's such a script and
> I just copy&paste the commit message from linux tree manually.
> 

Mmmm, how did you apply the patch in your tree then? Trying to figure 
out how we can avoid this in the future.

I'm wondering if we shouldn't have tooling in place to detect when 
things aren't done the proper way (for maintainers I mean). We 
**really** want to have dts/upstream be upstream + some patches that 
were already merged in devicetree-rebasing tree. I don't know enough 
about subtree merges that Tom does when updating to a new tagged release 
to know if it's actually safe or if the possible mistake made when 
applying a commit by hand can persist without us noticing. I guess a 
mistake made in a manually applied patch would be caught by Tom during 
the merge from the next release with a merge conflict, but then that's 
pain for him to debug.

Cheers,
Quentin
