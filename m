Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E23C25B10
	for <u-boot@archiver.kernel.org>; Mon, 13 May 2024 09:07:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94D0988087;
	Mon, 13 May 2024 11:07:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="PMchm9+u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49F7A88224; Mon, 13 May 2024 11:07:38 +0200 (CEST)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe02::618])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F1A787F39
 for <u-boot@lists.denx.de>; Mon, 13 May 2024 11:07:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l+AY18muSoTO8b/biZDY+wldUoYJNi6aBURvchF3/gMW9MUayoveJwtI1m7cTFSZBSgjjH3qXcs+tbojdAUvFDOEMfx0MoaocGxVcpyZ1e3hrZOdtwkrRe78rhkGJUO1Pt1piEmTIBIOa8sxLo+yshF5+kIpFzaeV6WEbP5zf6N+gNhCwT8Ev4bGqQU63wvM5m3TzinVqvCOgihE8LlPP3DXEgByipRDY6BqyUXdfi31wT4kL4dIuiOK9O3ovtjW8KAflGJWmk5yt5dW5WF43XIO6ucGN9UuqRpHi1tEnZt0LXZ8SYmiLHIYLZlAcZedoE9j7Rll3JwHxTMzrHaWGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jhHiadQgnWy0olxaRREmSbOK8kc0wvmxt9DpZkVoTX8=;
 b=kFtkCNBHuyw2E9kW/Lm2LxiHOnDUuKk+GIw8F+RUY5RUEuZgJuJyYN/0CRAVyRtq7Wvgrpcyb4BxeHO8SvVl599MAHkyhscJA2QyFDQ6isrh55VPSyPjCk25Bsivc0nyy+Qzz3i3iVJUk+OwKumxyxOc1aalNscNZKP/N+bm1Kh8Ra9V+UZ/Ns9saC/6Ce6zhkBf67DW+uxlFVDmnmennmhg26/dlTLcBA3n6IRgleqL6OWnyCz7r53QD48IdGS6AOF/Eoohto4Z+Ov/DBkH84t2MWnAcJuZeVBHFYpIctpoC0lqVebtfD29UXkHQHmsuAJ2sKKTeujEfqQ2mdNoNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jhHiadQgnWy0olxaRREmSbOK8kc0wvmxt9DpZkVoTX8=;
 b=PMchm9+uVuTM7VgM8JqbYWhR5mP6oboBpl5hQlRppcBf4wb2pIZWk8oPASbF9BhOL15PwW2w2CRzex3v9UwmR+G540CJK6LYRsST+WTC4CKEBih34lcbIHo7e0IFjFQlsElG7H6sro52AYUQORLLuKqSz6fm9EaUhEG0MW/MICI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by VI1PR10MB3197.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:13c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 09:07:32 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 09:07:32 +0000
Message-ID: <d5cf7fbb-2bad-4553-ad3f-1bda6d26b644@prevas.dk>
Date: Mon, 13 May 2024 11:07:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kconfig: default to zero if int/hex symbol lacks default
 property
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: Tom Rini <trini@konsulko.com>, Yoann Congal <yoann.congal@smile.fr>
Cc: u-boot@lists.denx.de, Masahiro Yamada <masahiroy@kernel.org>
References: <20240505135353.1507200-1-yoann.congal@smile.fr>
 <20240506174332.GN2568172@bill-the-cat>
 <d7c4aee3-47f3-401e-a66c-642ec5995ad1@smile.fr>
 <20240507172359.GX2568172@bill-the-cat>
 <36f1b695-5974-4c49-b5a7-43655588a994@prevas.dk>
Content-Language: en-US, da
In-Reply-To: <36f1b695-5974-4c49-b5a7-43655588a994@prevas.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0028.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:a::8)
 To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|VI1PR10MB3197:EE_
X-MS-Office365-Filtering-Correlation-Id: 787898f3-2a72-4cbe-9cd2-08dc732c1f83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aHhyTlVxREFYSjVBMkR0WU9yQ1FUcG81c3NFaFlucThVODFYeGdjQXVzcUtn?=
 =?utf-8?B?SFlsTFlFTmN4bDJITnI3WlM4QmtZZEFMT0lzY3R1MElSNTVCQThqK3VDQ3Vm?=
 =?utf-8?B?QXlPcHhxKzZRUU0yOVpqaTk1MXRYc09JeFhGZWJHeXphQTBvU3hBWVlaN2I4?=
 =?utf-8?B?V1BTSXJUUGJUTE5GLy92MDY3MHhYMFNrQ1l1cTZ6eU5VUHNtbjVTUFdFR3lh?=
 =?utf-8?B?b0tqSjhCaGlkWHFhOU8rT3Q5eHMxREtCZFZnQkJIZXJGa2I5dFUxbHB4REVn?=
 =?utf-8?B?cG1wQXFsM1ArTWxQd0I4WnV2SVNhdTNDbFYwOC9oeFJsVDhUanFQblBidnVi?=
 =?utf-8?B?eTI3Z2xWNVBFV1RzNTh0VVVqbUFzUUx0OFFrRUJsaDNVeXh2cFJSRU40VUs1?=
 =?utf-8?B?SGwrS2FsL0d6TjBjc1U1MnV5MUxtYVRaamhwZm9CRStZUjdHb05zWHo5VC9N?=
 =?utf-8?B?V0VpQ1Zlc2x6MGJOdGFTbmdhMERJRFJkUXBUbVAzdFRycGlDZTFRVUZTNEpF?=
 =?utf-8?B?ZlFtMXB2WnJMdWpxcS9vbDYvSTJBREVka1hCWTFaQk55NVBpK1JETUVVRU15?=
 =?utf-8?B?dFNJQTJGNVlVdHhMUzh6UFg4RXhHR3A5UnZPUm1vMnpPemo4ak5jekJmeno2?=
 =?utf-8?B?WjNtSDBNRkpxL2pDRFlWc1lBN3kzZXpKRnRkN0JRK255MHMxUlRaZmRLeEsv?=
 =?utf-8?B?UjRJdjlPVDRyNzJtaHptUnMxVFY2RE0vdlZXWWQrVTRsRnlDejd6YW16OG05?=
 =?utf-8?B?eUhjUmk0ZUJmRkJvblhOb3VVd2R5UzlwckozMDRydWVLOFI0bTNiZk1ZdE9R?=
 =?utf-8?B?djhGRmp3OTZsc3FicHUyd004a0dBTHJOY0srR2NEa25qaHFVampxaEVjMEM0?=
 =?utf-8?B?Q1FlRXl4Qis2ZTJ4bjVMdEhHTlM5MDM4R3JKUWlkT3lUNGRFQkhMWVJDU0J2?=
 =?utf-8?B?MnBlakF3SnpDUGpNMzZsaHRFQWtHNjRkNTJmUGxLRGs2RFVpdHFBM0E3MTNv?=
 =?utf-8?B?Q3J5OVlRbUlQT1NxcmV5Wk1lR1FsYmF2VUpnNjVwZ0FDcDhyMk1uYXZMNDh5?=
 =?utf-8?B?c2o2bWVxWVRra3NsR0M3aUlCYlBPUnJOYkJkb21wcTY2UktJT0FjREc2V1lr?=
 =?utf-8?B?aHNwOTZETFI3VnBTMW5UQXpqR1lTSGYwQUd2dkM3dlRWdEhoRjkzMzQ0cmNC?=
 =?utf-8?B?d2tLa2F6aUZzdkZjU1A4Nm5QMFVoSDZ4dHZwd29sVXlOWnZIUWRZanJITThY?=
 =?utf-8?B?b0lJK1EzbGlsSE1RUlhFRTY4SExwZVB3RWl5Zk1BN1M1Mk9tYTBEclJSU1lp?=
 =?utf-8?B?NHBnSzFGRjl0RWFHZWJWSW1QNXFNUnFyWDFBZkxhbk5YQStkYnBGejR2MVFK?=
 =?utf-8?B?bnFxdkhsRkZYTkdFek8zTmFFaURibU10Z2E3Z2x5Zk5qajZmdm9vQTV6T1JD?=
 =?utf-8?B?QnpIM3VBZTN2eWg1SVNBaWtTdUJ3VllYUE01MTd5MWI4N2k2L05jR1VmSlE2?=
 =?utf-8?B?aGg4bGtMbyt2c1BFdGlZWlhaMEZxb1BqSDUzZmUrQzZ0cTlHYVpZQ05laGdW?=
 =?utf-8?B?Y2Z0dlFIcFNQWFpaV3BPSDhXRWN4bDlsZTdpK1dqVXlDeW9BLzg4aTFwMVlX?=
 =?utf-8?Q?2Hq8xUnA53R4Ju5XfK00enXps/5Bt8mOkjCZisfCmNbY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3YvUzgzL3BBRmRweXV0M21qWW8rRkFmRXNLWThIYnZFdE9xbVA4anNTNDhY?=
 =?utf-8?B?R3ZaVUlVUXFrdDcwZTFBeDhQWmNyTWptY2FSZmxERWd3NW51aktoK2tZRjhq?=
 =?utf-8?B?U3NTK2lxTEZncTBYNG8raWYveVZsUVFaOVlVS1ZHZTVjU3FBMm83ZUNRYWlx?=
 =?utf-8?B?RTBWbDYzOWdlbXBWaW9MZm8rNkd5ZG9nQkVhZzA1ZXB2K3Z2MktXZHZ0eWJF?=
 =?utf-8?B?d2N4bGFYM3o3V2RGeWR2NGU5UXBVVFdpVTR0d0RKNm9vZ244THoxTWpBU2Rs?=
 =?utf-8?B?YlpyNHdqYlZZZ1lndTl2TWRiRkl4MWZETHEwUklOekF0TTh6K1lvUEFJOHVM?=
 =?utf-8?B?dE8vc2dyd1l2MDZ0Q3cxR1JQT25ibXY5c29pbDFQa1ZwRDB3N1pVemZJeVNr?=
 =?utf-8?B?K0E1dkpmeEthRUowOFRqTlBseG1KcWFTdTJQeE54dU1palVpVHJaZGowL0Vi?=
 =?utf-8?B?d3liWFlYTCtJRUdkR0Q4V2RRV0htYTR1dENZa202Ymcvc3F3OTJ0bWxxWC9H?=
 =?utf-8?B?enJCeUZHTWEzc2FmZWtsNmFMRXpJd0J4ZFliQjRLajU2Y0RnVENpSzhNbUJR?=
 =?utf-8?B?bXVybnluY3lnTklLNGphTUhRdHpzWUt5dlpwMWJLOTZCeFRKZGd6Y1dUNXFQ?=
 =?utf-8?B?cTFBN0toWDhFNGlDWVFBRHI1YkJkVWt1YmxFSnVYejV5V0VrSmFQL0tyUFN2?=
 =?utf-8?B?aytScktXS0RvczMreGRlS0t6TFpJek5OZ1JMdXhScGJMcmxLaDFFVW9WaVVx?=
 =?utf-8?B?d0hxQlFYdEh6d1BmR1EzUGdhOHV5UXJ0UmJldEEwbWQ1OXhoR2RNeGFyajFD?=
 =?utf-8?B?NnVVdUJtWUpaWHJDaDFOVmFyZnNOUGw2N1lKc1JFMVJIYUlUTjdzM1JQZEtQ?=
 =?utf-8?B?bHRpU25xMS9sVEo0K2pIS3BuOThVVm93SXRHMHFJK3Y1Ry85MXhTSjk2QWdo?=
 =?utf-8?B?aXBSZlJ0azZ0bFpqdnBycnlOMmt0VHlwbzlyaWk5S3RCa2RtN3RZeHhKb0Rj?=
 =?utf-8?B?SUk0RXRpaVBhYWViUmNuQjFTdkJVdUJpUllvbXJ0azVvdGJXSGx1UnkyV1FO?=
 =?utf-8?B?aTB5RVNtQ3htZFpneGFSQkp3d3YrQWJHN2w5OXRuSWdJODB5T3N6a0wwOEZT?=
 =?utf-8?B?clpnblB1aktBbDRTcTRyTldSZWFJWjhRemF4U3UxMWl2ajAyMlJqOXpxMEJK?=
 =?utf-8?B?azZ1QVp6Y3lMTGlTR0pzTDRUK2FpR29OUGpEUklnbVVUdHM4em9SQU1aSjMy?=
 =?utf-8?B?WDhHQU4rN2lqbkJ2TGdzWFNwZGlIbkg5N0kzdzg0MmoxMlg1bExOcGxyUzJN?=
 =?utf-8?B?QmhzZW1IQ1hERzd3R1U3TFFyQUFOVmlxdDUwNk4rOUFMS1hEdEdPTmNRRENR?=
 =?utf-8?B?RzBmMVBGU2x6U0lyeENaTmU4S01wWVoxWGVSSVpKYkxyS0F3b3EzcWJSNmZO?=
 =?utf-8?B?aEhWZk5sNnRiQWtzelVvRWQ3VEFPRlZ0TVpnRzY4UE9BSUU2M1R3VWt6UW16?=
 =?utf-8?B?QkpNaWxUQWtTeEN5QmVWRWpBUDJOZDErMk5XYXFWZWs0cmpYSkhab0pjdmJl?=
 =?utf-8?B?ZHl5RGhBMkNSQ09rTFZoNThYb1NmSkRsYlptUTRXME9qbk1QRlhXaUdyb3Rs?=
 =?utf-8?B?aTFPVHlOcVRSMmJEbDF6Q3REdHR1dlZ4WjBLNUZXWFA2ZWpOWlArUXZOM0o1?=
 =?utf-8?B?Y0FXbVJlSTFXaVJHdC9uSmI2aWhLR25wN05CcTU2blExd1M2NHAwRXorbG95?=
 =?utf-8?B?MEthVE52UUF2S3BVS1cxRzRHTzlOWkhzQnk0T0pCbDhwVFJOelBaR0U2VUZs?=
 =?utf-8?B?V2pBRm8zR1dTUHBoNlV2dlhMTlp1WDAzNnNTb001dEpnVVVCUjY4TGIydEZ0?=
 =?utf-8?B?aVdVMlloS0J0WnlmYjlmd0RDNTJ1WTc4Wm9tcjI1VzhrY3UyWHorVEo5RG0w?=
 =?utf-8?B?VldPeTJTRWoyV3h6aE0wdmo2dTZOUFl5L08waXlDT3dvYnByOXBJaDhrUzYv?=
 =?utf-8?B?WElqQTc1NDJtN1BxQ2QvOFBsa3k3bXBZa0J6ZTVNNm1OUnRmSWQ0blZTNDh1?=
 =?utf-8?B?VmhmcndKcGhyTXNnWkNwWGlZMjk2SEV0UVRFSFU5eW5rWityWVl5Z3JITm5L?=
 =?utf-8?B?TFFsd0ZsOG5oOVo4aHhsQnhIaDY0emZSalQyTzhFazM4dUdXdmtsTEdOS3Nk?=
 =?utf-8?B?Q0E9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 787898f3-2a72-4cbe-9cd2-08dc732c1f83
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 09:07:32.5497 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xDDldR2N+CKDiSVoIZPmd9YQXuUA/wBMXiFUWBa9GytqDBPPfXIbRrneQ5KHX4arErmgsFJNvUr4gBzwwvu/MpAyq6Q5qWaFYR1coiM32EE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3197
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

On 13/05/2024 10.28, Rasmus Villemoes wrote:
> On 07/05/2024 19.23, Tom Rini wrote:
>> On Tue, May 07, 2024 at 09:17:46AM +0200, Yoann Congal wrote:
>>> Le 06/05/2024 à 19:43, Tom Rini a écrit :
>>>> On Sun, May 05, 2024 at 03:53:53PM +0200, Yoann Congal wrote:
>>>>
>>>>> From: Masahiro Yamada <masahiroy@kernel.org>
>>>>>
>>>>> This is a cherry-pick from the kernel commit:
>>>>> 6262afa10ef7c (kconfig: default to zero if int/hex symbol lacks default property, 2023-11-26)
>>>>>
>>>>> When a default property is missing in an int or hex symbol, it defaults
>>>>> to an empty string, which is not a valid symbol value.
>>>>>
>>>>> It results in an incorrect .config, and can also lead to an infinite
>>>>> loop in scripting.
>>>>>
>>>>> Use "0" for int and "0x0" for hex as a default value.
>>>>>
>>>>> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>>>>> Reviewed-by: Yoann Congal <yoann.congal@smile.fr>
>>>>>
>>>>> Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
>>>>> ---
>>>>> Added context that was not in the upstream commit:
>>>>> The infinite loop case happens with a configuration defined like this
>>>>> (a hex config without a valid default value):
>>>>>   config HEX_TEST
>>>>>   	hex "Hex config without default"
>>>>>
>>>>> And using:
>>>>>   $ make oldconfig < /dev/null
>>>>>   scripts/kconfig/conf  --oldconfig Kconfig
>>>>>   *
>>>>>   * General setup
>>>>>   *
>>>>>
>>>>>   Error in reading or end of file.
>>>>>
>>>>>   Error in reading or end of file.
>>>>>   Hex config without default (HEX_TEST) [] (NEW)
>>>>>
>>>>>   Error in reading or end of file.
>>>>>   Hex config without default (HEX_TEST) [] (NEW)
>>>>>   # This loops forever
>>>>>
>>>>> NB: Scripted config manipulation often call make with /dev/null as
>>>>> stdin (Yocto recipe, CI build, ...)
>>>>>
>>>>> This was discovered when working on Yocto bug:
>>>>> https://bugzilla.yoctoproject.org/show_bug.cgi?id=14136
>>>
>>> Hi Tom,
>>>
>>>> I'm surprised this was accepted. In the past I've wanted to avoid this
>>>> kind of change in Kconfig because while the empty string can be easily
>>>> be checked in the code as "user didn't really configure this, do
>>>> nothing" a value of zero is a valid option in these cases and so then in
>>>> the code we need a bool symbol to decide if the hex/int symbol is set or
>>>> not.
>>>
>>> For context (and what it's worth), before this patch was merged, I've tried to fix this problem with a patch of my own which only exited the config process when the infinite loop would start:
>>> "[PATCH v4] kconfig: avoid an infinite loop in oldconfig/syncconfig" [0]
>>> ... the v5 version was a bit more severe and exited as soon as an error was hit, it was then removed from -next because it triggered a build failure [1].
>>>
>>>> Today this is less of an issue than it used to be in U-Boot with
>>>> everything CONFIG-related migrated to Kconfig and so there's no longer
>>>> the question of if we missed migrating a file that defined the value but
>>>> there's still places we have in the code where hex symbol is undefined
>>>> is not the same thing as hex symbol is 0x0.
>>>>
>>>> Is there a specific use case you have for this in U-Boot? It's been a
>>>> while, but it's also been cases of newly introduced symbols in Kconfig
>>>> files with incorrect dependencies, where the infinite loop in kconfig
>>>> happened, CI failed and we caught the problem.
>>>
>>> For a specific example, one can trigger this with CMD_PSTORE_MEM_ADDR like this (tested on today's master):
>>>   make qemu_arm64_defconfig
>>>   make menuconfig
>>>    # activate CONFIG_CMD_PSTORE=y but forget to fill CMD_PSTORE_MEM_ADDR
>>>   make < /dev/null # This emulates a Yocto/scripted/CI build and loops infinitely
>>>
>>> But, my more general use case is the Yocto dev trying to change the U-Boot (or any kconfig based software) config and accidentally trigger this.
>>> In Yocto, what they will see is a do_configure task taking a very long time but they won't see the looping logs the detect the problem (This is caught later by filing the RAM and the build process is killed by OOM, or the disk run out of space filed multi-GB log files).
>>>
>>> I'm sadly aware that defining a default value for this kind of config (fixed addresses) is not really sensible but the build time infinite loop is not good either.
>>
>> Exactly, but to me it's worse to cover up the build issue and introduce
>> a runtime issue instead. Something builds but then crashes at run time
>> is worse to me than builds fail / get stuck. Using your example,
>> CMD_PSTORE_MEM_ADDR depends on CMD_PSTORE and so if someone enables
>> CMD_PSTORE in a config fragment but doesn't define the address, the
>> build should not complete. Using 0x0 means that oops, now it fails to
>> work and might not be obvious why either.
> 
> I agree with Tom. Yes, we've also hit those yocto failures with a
> multi-GB do_configure log file, and that's pretty annoying when one just
> starts a build cooking over night and then the next day one's laptop has
> a filled disk. So clearly there is/was a problem to solve.
> 
> However, blindly adding a "default default" of 0 is not the right thing
> to do. It seems much better that, when there's no configured default and
> kconfig gets EOF when asking the user for input (as in the 'make
> oldconfig < /dev/null' case), kconfig should exit with an error
> explicitly saying "no value given for CONFIG_XYZ which also doesn't have
> a default value". That stops the build, and leaves precisely an
> indication what the problem is. 

For my own curiosity I tried to find where the infinite loop is, and I
think it's the while(1) in conf_string(). Not tested at all, but perhaps
something like

diff --git a/scripts/kconfig/conf.c b/scripts/kconfig/conf.c
index 965bb40c50e5..604b55124318 100644
--- a/scripts/kconfig/conf.c
+++ b/scripts/kconfig/conf.c
@@ -355,8 +355,7 @@ static int conf_string(struct menu *menu)
                printf("%*s%s ", indent - 1, "", menu->prompt->text);
                printf("(%s) ", sym->name);
                def = sym_get_string_value(sym);
-               if (def)
-                       printf("[%s] ", def);
+               printf("[%s] ", def ?: "no default");
                if (!conf_askvalue(sym, def))
                        return 0;
                switch (line[0]) {
@@ -376,6 +375,11 @@ static int conf_string(struct menu *menu)
                }
                if (def && sym_set_string_value(sym, def))
                        return 0;
+               if (!def) {
+                       fprintf(stderr, "A value for %s must be
provided\n", sym->name);
+                       if (feof(stdin))
+                               exit(1);
+               }
        }
 }


would be an improvement. There really is no point in looping forever
when there's nothing more to get from stdin.

Rasmus

