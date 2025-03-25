Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89710C35FFC
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 09:02:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFDB080EEF;
	Tue, 25 Mar 2025 10:02:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="YQVFoDMS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B666280F70; Tue, 25 Mar 2025 10:02:53 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CD11808B6
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 10:02:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cmIb7vDUFkrSzby5yQdu8T2vMhD1RS+ESRy570ceLG4OLj8Kfnnm+x7dT8FTBC7CMdjlLWBsAWFFYS0FTHLXWxcNsCPaHr5lsNg3IdFa81XKSN1HVcJMUg2RsuUywPq7BNriTFbm0UOBU82IFgy9mhWlilCzeXEj2eQmRyFhSQkURG94tIu/XUajHMmd7TC1k+V+LXw71Ey3KaJ4wWAtQb6HVLfRWYkxz+Od7QzU0DAU0I0jLA+wyrXAMENpvEEvs4bwePu7DZhiFFeYHKLUMMszbBAZhlMDyVDWY+K5GpdIVlAC6n+ZlK7PriuMUSqfc1R+7Qc5YQrmz2W24G9gMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l06956M+GiZmZcdC7pCkyDBTyzx91ZbP21gJDbb7OVw=;
 b=RlAaQyeo7hQTxZloBDPUeMXOtT9dX894JJZosxOd7w8HnG+I0NnEqmz500DMl0xjG7+QRtag0TK8hjFlgD4BY3x8Dqv9IlVZZzC/6RnDp6PzSWuRr7gO8kThm0wiLwjKlND+LJIbg1XlELnKwvBmKIkSIg+DbJk8xEeri8/Tp4FXTOibgzKtBMiwYqk1xdeNACYsloxMoBJZUFBiOPVNiFCJyFXoDnKBmskxD5g/jUbHOiGUY+ADSxH4J/BPhGOPqcxDfCzoSrwX5QQkEdTobaGLZWDtyW4sRqUkC/TmdF2zdgfO8MitkINm4L7OTPBVzMU9eB29JkxAA9ugpf4RgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l06956M+GiZmZcdC7pCkyDBTyzx91ZbP21gJDbb7OVw=;
 b=YQVFoDMSSUWtK7RFDlxsz+UXWaVqcZYY12V3E0eLMTVoFSbUJlqiQLbQLFcI2cUihcH0p0wAFqBMdNFv9yOE24eR8/xQdroCqxfZ3g6JSRufZHjBWagEzhr2kZ0BCdjJDB15/xujcx2TLv2P975YR6FCX/ElY6YEY345pzEH9yI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM7PR04MB7061.eurprd04.prod.outlook.com (2603:10a6:20b:114::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 09:02:49 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 09:02:48 +0000
Message-ID: <cc0f556c-e9ed-458d-83d3-0f459f6e6c25@cherry.de>
Date: Tue, 25 Mar 2025 10:02:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] env: Rename SYS_REDUNDAND_ENVIRONMENT to
 ENV_REDUNDAND_ENVIRONMENT
To: Marek Vasut <marek.vasut@mailbox.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20250322215624.18994-1-marek.vasut+renesas@mailbox.org>
 <20250322215624.18994-2-marek.vasut+renesas@mailbox.org>
 <de961532-3565-49f1-b205-556684105a11@cherry.de>
 <bffe08af-3151-4064-bfd9-8a660a70599a@mailbox.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <bffe08af-3151-4064-bfd9-8a660a70599a@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0396.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::10) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM7PR04MB7061:EE_
X-MS-Office365-Filtering-Correlation-Id: ad084a23-51a7-4631-8b0d-08dd6b7bd053
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OTU0eXRFYzFtYm56UGpQbzJUS3lKZWhMazQzOUxHeWpWRkFya0RzRTdFL2hV?=
 =?utf-8?B?T2wrYlgwK1p5Z3NxZXVlWnA0QVBGNlB4M1M4NkRVN3podUdxZWFWUXNadUVV?=
 =?utf-8?B?dEtoZ1lWWlNLMUgwd0tZcVZwcEZrb2J2dU5VUlBqSW03LzlPV3Z2d29Ob2Ex?=
 =?utf-8?B?bW5rN3FwODhNSnZVUnJjU2RiZ1JLc0hIbm5JYS93WCtDZjRpRGxBMzI4dVRa?=
 =?utf-8?B?M2lJZnFWUzZXcVBBWVFlWjZGbVp6UkozcVYrM3N5RXlMVnVHY1U4aHpESkVy?=
 =?utf-8?B?MDh4QnVLVUl4dEV5K0VLM29sRTkwemhleGt6SlMzcVl6blVZSENlT3gzdlVK?=
 =?utf-8?B?S3psOUwyTm4wUkNqSGtBSmdRYkdmbHQrWmVRZHZyT1BJYmR3Sjdacis0U0wy?=
 =?utf-8?B?YVVWM05lMWtYOC9wcStDS3pOdm5FZC9UQUdNT25JZmw5Smppd3diNm9ZZVM4?=
 =?utf-8?B?VkZ1d21QL1NHaHIza1gyMFRZZ09WalBUTVB6c0JPSW1IcU92ams0dk02a21O?=
 =?utf-8?B?WVBnemFHMHRWZ3lXYWFMQWxxVG5QUURBNGFBSTdFclU4aThrM0dUeWVoSlBP?=
 =?utf-8?B?aUxSdnd4a2tkZDNGYy84SkgrdEFTbS9NRGxrOGlMQVVaWXNFc00zdzFCU1Ux?=
 =?utf-8?B?Z2NtVE02WGFEUWJuYmF4Zm1VNXYzVkJURC9KUnVFSjBTd2c5d1VoMlFzUjBY?=
 =?utf-8?B?WEl6NFdjc3FDWk50SlljVCt0dEZXd3UxSUloelpyMlZqWGFWSUo4cFcvRWll?=
 =?utf-8?B?Y2FSY3lYTEM3RjRjR3JaOHBJUFVDamhvU09LRm5VcTdzUDZnSENMTHhYZE5X?=
 =?utf-8?B?STdNVUo3UklIOWlaR0R2OERLcnBpeFRaYTk3M2p4dTgxZGFSQ3luYTcyY0Ji?=
 =?utf-8?B?SHBYTnhlU1hQZSsyNE9hZkRKODBrbGFkalE5bElpSGJXWmgwbU9PMjcwSWpL?=
 =?utf-8?B?bTJsMXlLNU5hblFlM05LTnB6bXFveEZWbzF3aUloL0dmbVJkemc5MTZEcHND?=
 =?utf-8?B?dng5dTFxVDUyM0RXZlBiTWhDb2lpaS9KT3J5eDBONjdmYmJ1aXh3Mk5GY2VU?=
 =?utf-8?B?WTRmY2prUWRlOEJJQ0M1cnRjdmJBcG11V0llU2NzVjhlNFhpaTgySDdzVmo2?=
 =?utf-8?B?QWlzVmhlSEZXbTZQZzBhUHFqQXNVbXFxZWxRUG1GVDZzQjFEazBKZEUyc3RP?=
 =?utf-8?B?azM0eFpzUkxwemd0cGJIczdRN3dRSGNJdEVzYkZJVHc2K2N3Nk92aEE2OHk1?=
 =?utf-8?B?K3RlcnF6bzZtQ0hpSFdwOUN6YTVEa2NJcEJrdFR2M3BETVpPM1BiVWljRzU1?=
 =?utf-8?B?V2VGNjJONGFsVVpRb2syYWt3SHlSODN5cVpKaTZDUlNnNW8zalpLOUd0QlE1?=
 =?utf-8?B?OGg5VW1jVk1OeVpTeEh6cE9oNnJ5M3RtbUhRSE5nNWd0dkhXb0NBeXFYZ1lt?=
 =?utf-8?B?VytKQ0Z2ZkNsTjdzdjBOU013OTRkQjJXL1V1Qll1QWd0VSs2Z1lQejVjLy92?=
 =?utf-8?B?SU5KVlBYa0pnL1VESHJRTXVPL0RiRFhqQlhPaTNibndqR2JLUEUwd1JuMkFR?=
 =?utf-8?B?aVdTZWVOeVFvY3dNemxuc1F5cDZDNkh4MVdFL2dtWEp3cnk1SnBLdVA3M2Fu?=
 =?utf-8?B?d040UGMyendMMlF0SDV4WUwveDlTV3F0c2R4VGdEaWowUVVraERBWk5ndE5u?=
 =?utf-8?B?OUlPTHJucVpwVStOVUV4QWZwb1lCeGtQNnBPdUNBTXprRnF5MVRFSG5Eenh6?=
 =?utf-8?B?dzAwZEVRbVFOMG1aeWxGd0NwOG9ycFJ6OHNHZCtJeU52MFhTZVBqaUw4SGky?=
 =?utf-8?B?Ty93VnFackhPaW5uRnNtT09EU01vNlVsN2l3ditDc045aUxNQUhoWDVIR1Q5?=
 =?utf-8?Q?XnjuGYuV3dTdr?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEFIR1VSQ20xM1NaR0hPS3FsbkluaXhvcnZ6cllXS2xFdHAvaWFlTVRZOHN4?=
 =?utf-8?B?Z0JpY0U2aVZsMGJDUEZoZ0gzbC9UUCtxanZ0am9jVGt6c0E4blFOM3FtTHZl?=
 =?utf-8?B?N21UK0dRMUdjYjNGM2ZWRlp2K1hUb0VFbE91elZOSEs5S3pBcnN6cC9SM0hO?=
 =?utf-8?B?YmMyZnRHMENYUVkvZEJqbW5NOEJpeEFLeFBCdDl2TWV2R2tKRjE2ZmxBQWEy?=
 =?utf-8?B?ZllSaWVzTTJmYWE5blBmOE1zaTFYMGhLU1JQTFphQkMvWkh2Rkpuby9yR2dO?=
 =?utf-8?B?UCs0dVRDaTRSc3dwRHBteDlvT0hXL043WGxReXEyYng4dVQ3ek53RlR1c0Jr?=
 =?utf-8?B?SHpoVGE2bjMwRm1NUGpIUWVrdEFvbEJ0NFFTa1JZaGJISDRvTldiTEx6Rkpa?=
 =?utf-8?B?c2xuR1M4UWg3bEs3RG5zc01DODJsdnNCSkU4WTR2MHZCbUpoZXFPR3U2cEF2?=
 =?utf-8?B?c05SWlk2RndaTkFScHpJaWNiYmsxbWRoVVc1aXFtVlBzeHFZakxBNlFIWE9K?=
 =?utf-8?B?b1NOUC92OFo5K3kxc1FhN29WSWtQWUJ0V3R0V0xYZDNjNjhGTVRubUNjVFZZ?=
 =?utf-8?B?T0NONWZ3Y3JlK3ZrV3ArbG5pUXpvY3h0Z091aVVHMUp2aU1ueU9wN25HQ3VP?=
 =?utf-8?B?VnRhaitTalpiTXlzTjA3MU9Dam1KOW5FZHBBaHRncjdlTkprSFl6OTE2dVAv?=
 =?utf-8?B?cWJLdXVpL1dNM1lGVXBlanlqaHhvQzhkREtPMGJTZFZWaXM5T0x2czRBb2U5?=
 =?utf-8?B?S0hjMHBCbVFGWjdHZ3hUVldlNlByYmFXYmd6UEhzazErQlV2S1c5S1ZBcTgx?=
 =?utf-8?B?Rno4TmRKazBSVlplanFrWmJWWk9pNzd6UTE5QmF0YngzeUNTNG4xK1FkQThD?=
 =?utf-8?B?YVl3SmpkNytXVmlnbVdrcmZzOUthSTRzdjNONXpWNWJSTUtvZTVjK1B4R25y?=
 =?utf-8?B?TldpenZsRSt6NkZhUzJsaWtKRzg5Y0ZRa04rNGRZWmVVK21Xd1hUb2N6UHRR?=
 =?utf-8?B?UDFYTTZpRHZaZHpCRHBSY3U0dW92ZUhxR2plWnJrdjRQbjNuM1RIcEZqWFNN?=
 =?utf-8?B?WEozNE96Ynp2MjN4N1RhWWVBY1Npd0J1RmZIYnZzZktBTXRaNko5NFRJeGsv?=
 =?utf-8?B?Mk4waUR4MFUvNDcyMWhxM0tXVWZXTFJESk1oWkNKVGEyQWxvZkIwQlhmUFdY?=
 =?utf-8?B?NjR6bmY1VnNlTDJlRkVZR3E3cFQybnQ1blZwcXk0eENKeXpMRlVqUVViK3M4?=
 =?utf-8?B?Q0wzcHMzVXhYM25mczhXSU1TMXdzUG1TRjA3Q21PUW8rTHdwOTFGbVYxOW5w?=
 =?utf-8?B?KytRUjk2bTdCNE5RWkE5QmlXcytGODhDQ0tjVkRJMndSLzFnR3VjUUtGMGNa?=
 =?utf-8?B?QmlPUktRdlhjZzZPZ1NZOXZNQVF0dVNyMEcrbWZrUDNDd1h0K2EzVXNCM0s4?=
 =?utf-8?B?Q05iMVZuRmhZQmQ0R0t3b1h5ZURDTmFUVnhYREVPWEhWWnRFa0VNZHNaUWo1?=
 =?utf-8?B?cER1amhNQ0w3UUV0NlpxdVBTbysrbUhOVkVpYWJwUjZXMU9ISUd2RCtJd0Yr?=
 =?utf-8?B?UXNRSG1oMDBLWDM3bVdiUm9CdDVOcG5lUC9EQkpKRlZRMWZQRmg0WmthK0J2?=
 =?utf-8?B?ekpyZmdzODJMK29MeFk1R1Vyd0R0RWF3ZjFDRlBscGRudzZEMkNML3R2MnRl?=
 =?utf-8?B?TENqZzZjQnZYRkM4SXNvWUc0ckRQL1dEajBkSjdEZ052YUhhZlIxQ3J5VHFG?=
 =?utf-8?B?T0FDQjRRRTFHZXNkS1ZoV3FiRmo0MXB5UmtodEpPRWR2M3RpTFlHcnR3VkZR?=
 =?utf-8?B?M3FQbnhkekhSNjJYb0E3b1RocjVmWDZBM2krbGQwcGhlWDFuUllCY3o1c2Rk?=
 =?utf-8?B?ajFibHZ5THBFbExMNnB4ekxCb1F2ZnF3QjZGOU5uTGI1dHNxUklSNnJQamp2?=
 =?utf-8?B?eFpiRExQTkg5Vm0xZ1lqQW9HWHpxRURwRng3aEgwYnRwaUFvOG9vLzZzUmVE?=
 =?utf-8?B?WlZDaXRZTkt2SkIxeTBVYk03KzM3cVlUNHFwMU8xZXVBTzJ3VjBtMitIOVhT?=
 =?utf-8?B?N3lQcWNFTDEzYkhTYTRPZkxacFVDck5VZmFzeWpQV0k4YmVuUG9LVGp6aks4?=
 =?utf-8?B?aFA3NUp2dlBueXAvMWViRC95ekVzUGFvM3Z5aHJhWWpzcDhUSDUvYUFEU1FN?=
 =?utf-8?B?bmc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ad084a23-51a7-4631-8b0d-08dd6b7bd053
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 09:02:48.5877 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ny6hr8NdXmz1RTmHdCF7P1XepLIvnzysEbkjVuBkVvshB74uKm1a6mBrqMzoSjgVZp8gVjQWimlCoZxhF1wnDYGH+YoeDWYNPeM1cWnz8Ls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7061
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

Hi Marek,

On 3/24/25 11:52 PM, Marek Vasut wrote:
> On 3/24/25 1:33 PM, Quentin Schulz wrote:
>> Hi Marek,
>>
>> On 3/22/25 10:55 PM, Marek Vasut wrote:
>>> Rename the variable and add ENV_ prefix, so that all configuration
>>> options which are related to environment would have an CONFIG_ENV_
>>> prefix. No functional change.
>>>
>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>>> ---
>> [...]
>>> diff --git a/env/Kconfig b/env/Kconfig
>>> index a177a354c8b..9ef45a7e3fe 100644
>>> --- a/env/Kconfig
>>> +++ b/env/Kconfig
>>> @@ -463,7 +463,7 @@ config ENV_IS_IN_UBI
>>>         the environment in.  This will enable redundant environments 
>>> in UBI.
>>>         It is assumed that both volumes are in the same MTD partition.
>>> -config SYS_REDUNDAND_ENVIRONMENT
>>> +config ENV_REDUNDAND_ENVIRONMENT
>>
>> Do either of the following:
>>
>> 1) fix typo: s/REDUNDAND/REDUNDANT/
>> 2) shorten name to be consistent with other symbols and avoid 
>> "env[...]environment" redundancy: config ENV_REDUND
> CONFIG_ENV_REDUNDANT works for you ?

Fine with me!

Cheers,
Quentin
