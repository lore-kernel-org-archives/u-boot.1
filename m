Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86CFBC61DC2
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 08:34:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AB97740574;
	Wed, 26 Aug 2026 08:34:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ac6bQ-FL1kek; Wed, 26 Aug 2026 08:33:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787733239;
	bh=XnNYco01tadxfvjPpLUt7feHV/q9uVHo2/2k+5fXAEc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vQA31UEp+exBTno63ikbbSCjXFufQpi4rdKuj6rNIY6q6eqzKIx1ba57w2kigOH7r
	 HOH147HazsE5gacWLN/+OywlLMmsJBDRhHQlx0PpERa0fBwhTs/ESP4cPTriARZrv5
	 FXVyztkU/3aH7BgSd1ZWRUWE1mNYRB1YXBBIkvzGF0IMXIpzPzagVB2evzsYqufs9G
	 YC4jlvr9Xw7MX1Kz/wTugQb8HFYMRJuQOgTbQnTqV7NaiYG8G/nqC87Ud/VWxb4QSL
	 mYV7xWc9EflbjEpJ6PogstHWny/D/PAElfL193mad02NAdVjRtX7vKMtmojRNxI4sr
	 lkFZRXA20Vfkw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 431444055E;
	Wed, 26 Aug 2026 08:33:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C40F2105
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 08:33:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B5F564055E
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 08:33:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3A15hfSh1j6D for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 08:33:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=R0GpT5ZM
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0E89640556
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 08:33:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w3F2t/Mv7Ldg8akpTmg2MvcSqH7XV8kqWnH5W39aeWW/Ea5iVKVssGhisYVlYSSKpiB0QOULaxmL7dlfdSkGJ/ndVplEt3qwTq+Niog1mNN5E6/vz5Q1xqzTd4QVeJ1riYm1sjvl/gv2ao0wfgX/6UCFiRhI2yBvW7L9rh/3/jUOLypW2tXO9PSfprxvxYSQJYCxi9ZncNYrZjWidJBz9qZjOwOSpuKuC2ct9a+kl8RklDu9Bzwp5xjdbkQ8onAW6p51zNVYPW4E4r34XBmMI9fgpSQTMHswu56AM21CyXGDNsixJz5qogr4qNgqLK2eWImt6t2Jx0+yuKS82MlPUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XnNYco01tadxfvjPpLUt7feHV/q9uVHo2/2k+5fXAEc=;
 b=PED2HlFGJpjBplbcSRe3KTP6mnroSOzJP+F2DSJFYBRgWz0wjNoqNRpn6g5XydWSPVZyh62lzOTIOpSozKLhPlSeLh39QFt7rNt7DG+1wk55mPlsoFnG8T/HCbLz+bBDPyo0ZqWzaDd8Um610IZjEeP9Q4j8rd04H5DuueRXF6g/gLs9Doe2KChjCPqIIeWwgBjqfY6KyMKwM8NfuKg9X5jp6RDPf4bRPrifXUIWyqipYwVIwYoroKlTFuFbHAgNYDZoMRXbq6NNV7w+Ev56u3oK36xlWDDFfit7Frtmj8yZbyRJqubEJKa0+tNnB1MDny4qeNl3sAJ800tRcxfiQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XnNYco01tadxfvjPpLUt7feHV/q9uVHo2/2k+5fXAEc=;
 b=R0GpT5ZMHER6oN4QYVlwfPNvpVVDhyBCr1mtkyzu2Lzu0S8HunD2hlHdML1N88o12AHl/lkvLDSo1zDjCoiDtD9bCgwDLbfjFlFq4rPhOlFOGVQFprPeEc7BAwakCACFg94Ebzgb2kAaJl346/cW+i93Fr1X+5U3a1B/JXzsJEI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by PAXPR04MB9470.eurprd04.prod.outlook.com (2603:10a6:102:2b3::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Wed, 26 Aug
 2026 08:33:45 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%4]) with mapi id 15.21.0360.005; Wed, 26 Aug 2026
 08:33:44 +0000
Message-ID: <d206aa31-c248-4fd1-b915-d42f40aa5c5d@cherry.de>
Date: Wed, 26 Aug 2026 10:33:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rockchip: px30: Fix TPL_STACK overflow into BootROM
 reserved region
To: Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.u-boot-project.org, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>
References: <20260810211405.2837550-1-jonas@kwiboo.se>
 <a0ac40ac-1716-4451-a585-a1bdec39ce84@0leil.net>
 <89b693b4-ac18-4807-8f1d-59e4338bae5a@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <89b693b4-ac18-4807-8f1d-59e4338bae5a@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: VI1PR06CA0227.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::48) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|PAXPR04MB9470:EE_
X-MS-Office365-Filtering-Correlation-Id: bfc1b66b-1b62-4d17-9480-08df034cbda7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|366016|23010399003|376014|22082099003|18002099003|56012099006|11063799006|4133799003|3023799007|6133799003|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info: Q5E2iTaISdwCd4r2D38vmielBh5v6fUfJeYws9Zxt3s2wNQcZb/Vf8A20GifbyFzcqfxd34N04UyExUrPDh+cR9Z0iAvtes+ap9pv1eEG+3cTpl7Wx2d2MIYmmJih7CgQNGz1eS2kxI2hbBgRUjKFwyacbyGlkxnneczHYaluEDbcQRKZqC2BkxWg7x7FDNGbrUhvmQd3Wgkvqdgex71YAxZZpf3qiNJr/f8MGOe96IoL67tu+2PG47td3qTpG4otGU6stTy4x039+SuARsErLOvxPZZ0ALcVLw+rMJbSQkPf+zC8PSozPS5s66EisGjcxBz0yVBngOaEihiMQCps08U7b7WPkBF4ZJdf7y/nTjw9Q6knkBNmp6vPxyBjRBw3EqpQitw8ftrFfJW2/5z4NbWZJYWCntbUsoVwpOeM0mvXca9V7WJojEKO726P2bYhIG41MSViIQyb/Bv4d/RxG5UBQw5CrkChToDz1KQNJ8exFfGfN+r4InYVcJk1imbGbXtV+X6PgqH5WIkdc52bSeYGf/LD/gK5Qzoxo72hQv9FJsXQeGiqh925RJrLbw4JNBPvkko///Y25re8d0GvwLr9n0SMTHvsOVXariNOXP1uokDuCjZDnZGdqZvtNKS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(11063799006)(4133799003)(3023799007)(6133799003)(10067099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkNMVGl5RUxRQVVRV0ZxNUVPVXNJWXZHS0pjcnlrUUROd3JndmRKWFR4bnB6?=
 =?utf-8?B?YzVMejBJcng4RjQyZ0lqaW1md2lDMVd2M3kyeUpCNFg4cUxlb09MVXJuQVpH?=
 =?utf-8?B?a1NwRU9DMi9KcWs0dEZweUhLZjNsM05jeVFjWVNVOXp1VUtlUGJiNm1uSHFr?=
 =?utf-8?B?V3ZZaVlpWThCdXExSjVVSXJMWFViZFBISVMxVlNQV2t3VnVOWEhpRUQyalkx?=
 =?utf-8?B?SHBDQWJkUW1hUFRTMG44UTczY01kMUwwWXRWa1hFY0JJOW8zZkNSdkhWYUZK?=
 =?utf-8?B?RWdXZi8vb1NyMTZOVGk1NkplNWZYbzQ4SG5sOXJ0YXlFZDBYY0YxNEJYZkNm?=
 =?utf-8?B?U2JDMU5ueG5OTlFsdUVKcXBmNUUzSUZQV0tHSVRhTDNCU1IweFlmWWx2MHhH?=
 =?utf-8?B?WjRzVG8wUEt3SllPQXFqdGtpMkZpVnJhZXcxNHp4S3ZMNnFJYS9leFhhUi9K?=
 =?utf-8?B?ak9mNGFvbVQ2bUVlZDVXZWNITVhmRVY2RzZDV2JyQ25RcENVa29jOCtXWWN5?=
 =?utf-8?B?Z2lhRW5lUm5KTExRbUlWbG5yZElwTmwyeWVrNmhRczE0ZVB5emg0dVNlL2cx?=
 =?utf-8?B?VFNqWG5qSE5SYlNuTVFlK2R0SHdaMElSczJ2SXZjR1NNTThwTjNLcW02eENU?=
 =?utf-8?B?aCtwb1llUHJob09oQTh4cFRhRzA1UnZHVzl5blU1K3BoN0luVWF1d0tIbXJ0?=
 =?utf-8?B?ak9OMVd3Sm54STg0OHpIS2t5cTlyUjAzSVluVURPQ1JQcTFqVXAxTGNmMDN0?=
 =?utf-8?B?dnliaHdsQ2QwdnV3NGdYRlF0OUlhUW1mbHJBOGZnamZ2bHpaVkorZ0Z6ZUV4?=
 =?utf-8?B?QkZkaVRQbGpEYmFMWklpN2s0T01lTUpweWhoMG0wN2REeHBqVEwvc0ZZMnhN?=
 =?utf-8?B?OFI3cS9KZXd4dlZFcWtiaEMwSU13bzNVWUdJMHVQVnlNZ05YMDl0YTNZQy9z?=
 =?utf-8?B?dFZJVENYMGJKR3JQUCtKWWEyQ3M5Y2RteHY1T0ZEWlYycEtKUk5KbTlNQkp2?=
 =?utf-8?B?T3N5NmVJb3hENWI5eFNoTXVqMit6TXFHWVdjcVRHT3ZzU1RqNHdQVU0raWhP?=
 =?utf-8?B?Nmw4bjFuMFJHakR0ZnhZWEN6VndNRXFxZkZxU0FWMzc2cmErd2pwS3Jjd0RQ?=
 =?utf-8?B?NWVRZnBoVUVlV3U2T3AwUFhHZXJGVTVTcndNRHc4RmJPaXlkYzgwZE5oM2JL?=
 =?utf-8?B?WXI5Q2FRcDRYYTlLU3R5N29PVVlDNFZLMXJKbGt2bWptdlB0aTRpVTJuNk5o?=
 =?utf-8?B?SkxERXlYNTA0aW5IMEljSUdoSk5nWVhQbW1haUk4RFJuOEhmTVF5WU9IOXpW?=
 =?utf-8?B?emFrYktOWENkNGxqYXcyQ3ZFakNlTEF1bFdOdGlCdTRhWk1NOStBNzE0MzJm?=
 =?utf-8?B?UUZTMDAwK2xIaHpUM1RkK1dtMFEzenZYeXVLYXVDRFNsRlBYdUowaTVBcEl6?=
 =?utf-8?B?b2NaOTBYeDd1L2Q0ZVZMU0hPcU0yTlJaMU1UZDNlVFpHN0ZudStTWTlhc05B?=
 =?utf-8?B?MVVsUHpyWnpSMzAvMFg4R0xpYzA3K1NYWEU2WE1NL0Y2SmljNDJlN2h0ZnVS?=
 =?utf-8?B?c1NOUEQ5cS9Zb0srdWxWbURHTXNrNHdtYm81dEYzckVLckFwYmJBR1lEOGN4?=
 =?utf-8?B?dWRkZGtqUmJDc3A3TFh4cy9LK0pNTWl4MUlpUE5QUnR4Y3IzTG1ZZFNoTXVW?=
 =?utf-8?B?cUxLMVpvc0JhNG51T1p4ZXlESXVHMXRIVmt3L0RnRmRBcnYwejdMREt3OW1H?=
 =?utf-8?B?dmlxUWpPNHppeHNjUndFenl4WXJUaURFOVdiUlJKU21yNjdZdEtrWlFwOFgv?=
 =?utf-8?B?bDJkNm9jaW0xQ29YeGNNeTMvVklNRTBBc0oxUVZSOUMvbGR4YWYxSmhiQ1BS?=
 =?utf-8?B?dytDT1hZdGRha3ppcWkrWG1BRU95dkI1bythU1hmVlhzS3ZxalNEUzZLWThi?=
 =?utf-8?B?RXJGZXE1Y1p5Vng0akYvT0VkQnNWaUxMeVQ2QmJaK3pZNUNnVXlpOW5Qdm9h?=
 =?utf-8?B?NHVmUHNPSXRRSktoMG95S2ovaW9BNUZ2aTlHNUxxbGw2bmpUWXZnaEwrMUY4?=
 =?utf-8?B?SG5mSmpuSWR3VU9KVFJSQThRK2ZqWjNnZkRXM3k2T1pmYll3aVNQL0pMdHE4?=
 =?utf-8?B?YmFrVDl1MzJ2YVdaTDVkV1lhcVZZQmNqWERiYTVEMXRFeU45QnNYYWM5TW93?=
 =?utf-8?B?U0pmR05VM3hKcTVqNXhQLzhZOUQ4ZStIMmhyQS9wQmtDOWFnUHdlVDFpM2Jt?=
 =?utf-8?B?dWMwQlNVeWxKNHRPTUw4Y2IwRGdtbG40SkczMWEyUFBrK0pLdk5IVk1KNDla?=
 =?utf-8?B?NTFLVFdsWVRUcGo4SmJNZkdoMXVkR1hkWGErS2Ewb2dQWjcvb0FQcnJqT0FY?=
 =?utf-8?Q?F6Dz7VyRk9waAFGDjsiTGKWa1qQObxGar9SvFQF49FCba?=
X-MS-Exchange-AntiSpam-MessageData-1: BVWrS2v4fMHN6q0V+HebqaiLOjhYEODKtcI=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: bfc1b66b-1b62-4d17-9480-08df034cbda7
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 08:33:44.6458 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TCgTNUh3zXahGYwaenw2FeoZOfDp6GkQKaxib/nY40E4CH09OG2KX0XPSaxjRDTT7/VY8miO9F4AkZbDF1FTr8fqJIzNAPMcImN1NmeT83Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9470
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

Hi Jonas,

On 8/24/26 5:59 PM, Jonas Karlman wrote:
> Hi Quentin,
> 
> On 8/24/2026 3:45 PM, Quentin Schulz wrote:
>> Hi Jonas,
>>
>> On 8/10/26 11:14 PM, Jonas Karlman wrote:
>>> The PX30/RK3326 has 16 KiB SRAM at [0xff0e0000, 0xff0e4000), with the
>>> initial 4 KiB at [0xff0e0000, 0xff0e1000) reserved for BootROM at boot.
>>>
>>> SRAM addressing only seems to use 14 bits, meaning that reading from
>>> 0xff0e4000+ wraps around and instead reads back data at 0xff0e0000+.
>>>
>>> Using a TPL_STACK at 0xff0e4ff0 (16-bytes aligned) means TPL use BootROM
>>> reserved region for its global data, malloc area and runtime stack.
>>>
>>
>> This should be its own commit.
> 
> The main purpose of this patch is to fix the overflow of TPL into lower
> 4 KiB of SRAM, i.e. the area used as BootROMs stack and state. Returning
> to BootROM to load next image (SPL) could possible be affected depending
> on TPLs use of malloc and/or its stack usage.
> 

Yeah but that's already the case no? It's not because there is one issue 
that there's necessarily one cause to the issue, or many ways to trigger 
the issue.

> All changes have been kept in a single patch to make changes safe for
> bisect. If we just change TPL_STACK and keep malloc size, or just change

Bisect isn't necessarily useful if we start with a broken state. It 
matters if we somehow make it worse, which we shouldn't.

> malloc size TPL may start to accidentally overwrite areas in the BootROM
> reserved area that affects BootROMs ability to load next image or the
> TPL stack may start to overwrite end of TPL image.
> 
> E.g. if we only change TPL_STACK we end up with 136 byte free for
> stack usage before stack can start to overwrite TPL BSS/code:
> 
>      [0xff0e0000, 0xff0e4000)          16 KiB   SRAM
>        [0xff0e0000, 0xff0e1000)         4 KiB   BROM area
>        [0xff0e1000, 0xff0e4000)        12 KiB   TPL area
>          [0xff0e1000, 0xff0e3800)      10 KiB    code
>          [0xff0e3800, 0xff0e3848)      72 bytes  BSS
>          [0xff0e38d0]                            stack pointer
>            [0xff0e3848, 0xff0e38d0]   136 bytes  stack area
>          [0xff0e38d0, 0xff0e3ed0)    1536 bytes  malloc area (unused)
>          [0xff0e3ed0, 0xff0e4000)     304 bytes  global data
> 
> And if we change malloc size the TPL stack likely move closer to
> BootROMs own stack. Current combo of TPL_STACK, GD_SIZE and MALLOC_F_LEN
> seem to not affect BootROM but that could change if any one of them
> changes independently.
> 
>>
>>> TPL on PX30/RK3326 does not have any use for the malloc area, the
>>> generated GD_SIZE is typically around 304 bytes and BSS around 72 bytes.
>>>
>>
>> As far as I understood, this is space/size optimization and not a bug
>> fix, so should therefore be its own commit.
> 
> The only part that possible safely can be moved to its own commit is the
> increase to 11 KiB for code size. Mostly wanted to keep this together
> to help for future references as this patch then have all details on why
> such size change was possible and could be considered safe.
> 

Once the issues are fixed and merged, you can always point at a git 
commit hash in another patch.

>>
>>> Current memory layout possibly looks something like:
>>>
>>>     [0xff0e0000, 0xff0e4000)          16 KiB   SRAM
>>>       [0xff0e0000, 0xff0e1000)         4 KiB   BROM area
>>>         [0xff0e09f0, 0xff0e0ff0)    1536 bytes  malloc area (unused)
>>>         [0xff0e08c0, 0xff0e09f0)     304 bytes  global data
>>>         [0xff0e08c0]                            stack pointer
>>>       [0xff0e1000, 0xff0e4000)        12 KiB   TPL area
>>>         [0xff0e1000, 0xff0e3800)      10 KiB    code
>>>         [0xff0e3800, 0xff0e3848)      72 bytes  BSS
>>>
>>> Update TPL_STACK to use the top of SRAM address and reduce MALLOC_F_LEN
>>> to 0x0 to avoid overflowing global data and stack into BootROM reserved
>>> region.
>>>
>>
>> Aren't we then missing a build-time check to make sure this is not possible?
> 
> Not sure how we could build-time check this without a guesstimate on how
> deep runtime stack is needed.
> 

Fair enough, we know the pool we've reserved for the heap (malloc) but 
we cannot reserve space for the stack so we cannot know.

>>
>>> After those changes the memory layout looks something like:
>>>
>>>     [0xff0e0000, 0xff0e4000)          16 KiB   SRAM
>>>       [0xff0e0000, 0xff0e1000)         4 KiB   BROM area
>>>       [0xff0e1000, 0xff0e4000)        12 KiB   TPL area
>>>         [0xff0e1000, 0xff0e3800)      10 KiB    code
>>>         [0xff0e3800, 0xff0e3848)      72 bytes  BSS
>>>         [0xff0e3ed0, 0xff0e4000)     304 bytes  global data
>>>         [0xff0e3ed0]                            stack pointer
>>>           [0xff0e3848, 0xff0e3ed0)  1672 bytes  stack area
>>>
>>> With these changes the TPL_MAX_SIZE can safely be extended to 11 KiB,
>>> leaving enough for the stack to grow down around 648 bytes before it
>>> starts to overlap into TPL or BSS.
>>>
>>> And with all changes the memory layout looks something like:
>>>
>>>     [0xff0e0000, 0xff0e4000)          16 KiB   SRAM
>>>       [0xff0e0000, 0xff0e1000)         4 KiB   BROM area
>>>       [0xff0e1000, 0xff0e4000)        12 KiB   TPL area
>>>         [0xff0e1000, 0xff0e3c00)      11 KiB    code
>>>         [0xff0e3c00, 0xff0e3c48)      72 bytes  BSS
>>>         [0xff0e3ed0, 0xff0e4000)     304 bytes  global data
>>>         [0xff0e3ed0]                            stack pointer
>>>           [0xff0e3c48, 0xff0e3ed0)   648 bytes  stack area
>>>
>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>> Reviewed-by: Simon Glass <sjg@chromium.org>
>>> ---
>>> The overflow/wrapping was runtime validated on a RK3326 ODROID-GO Super
>>> by printing out content of [0xff0e0000, 0xff0e5000] and comparing the
>>> initial 4 KiB with the 16-20 KiB and the data matched 1:1.
>>>
>>
>> How did you test that? md.l on either address results in a Synchronous
>> Abort on my PX30 without your patch. We could also just write a random
>> pattern only at one address, and if it appears at the other address as
>> well, then you've discovered an address wrap indeed.
> 
> I used something like following to dump content as early as possible
> from TPL. I used something that printed multiple columns, and compared

That was the hint I was missing. This likely means TF-A protects the 
area somehow. I removed TF-A from u-boot.itb and I could compare both 
addresses with:

=> cmp.l 0xff0e0000 0xff0e4000 0x1000
Total of 4096 word(s) were the same

Funnily enough, I can increase the area to check to 0x3000 words but 
anything after that results in a Synchronous abort.

> the output for 0x0-0x1000 and 0x4000-0x5000. Think I also tried to write
> something and could see the values being reflected in both places.
> 

=> md.l 0xff0e0000 0x4
ff0e0000: 62144471 b9d836bc 5ef2ce5b e00c1527  qD.b.6..[..^'...
=> random 0xff0e0000 0x10
=> md.l 0xff0e0000 0x4
ff0e0000: a727051d b7145d3f aac7cfa6 3557e1df  ..'.?]........W5
=> md.l 0xff0e4000 0x4
ff0e4000: a727051d b7145d3f aac7cfa6 3557e1df  ..'.?]........W5
=> cmp.l 0xff0e0000 0xff0e4000 0x1000
Total of 4096 word(s) were the same

=> random 0xff0e0000 0x4000
16384 bytes filled with random data
=> cmp.l 0xff0e0000 0xff0e4000 0x1000
Total of 4096 word(s) were the same
=> random 0xff0e4000 0x4000
16384 bytes filled with random data
=> cmp.l 0xff0e0000 0xff0e4000 0x1000
Total of 4096 word(s) were the same

So I think this proves what you've just said.

> void tpl_board_init(void)
> {
> 	for (int i = 0; i < 0x5000 / sizeof(u32); i++) {
> 		ulong addr = SRAM_BASE + i * sizeof(u32);
> 		u32 val = readl(addr);
> 		if (!val)
> 			continue;
> 		printascii("SRAM ");
> 		printhex8(addr);
> 		printascii(": ");
> 		printhex8(val);
> 		printascii("\n");
> 	}
> }
> 
>>
>>> Changes in v2:
>>> - Mention BSS in commit message
>>> - Update spelling in commit message
>>> - Collect r-b tag
>>>
>>> With the patch "global_data: Only include driver model fields when DM is
>>> enabled" [1], the stack area can grow down an additional 48 bytes before
>>> it starts to overlap into TPL or BSS.
>>>
>>> [1] https://patch.msgid.link/20260810204828.2836359-1-jonas@kwiboo.se/
>>> ---
>>>    arch/arm/mach-rockchip/px30/Kconfig | 4 ++--
>>>    common/spl/Kconfig.tpl              | 2 +-
>>>    tools/rkcommon.c                    | 2 +-
>>>    3 files changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-rockchip/px30/Kconfig b/arch/arm/mach-rockchip/px30/Kconfig
>>> index adba1b49a52b..cc0632cf7b2d 100644
>>> --- a/arch/arm/mach-rockchip/px30/Kconfig
>>> +++ b/arch/arm/mach-rockchip/px30/Kconfig
>>> @@ -81,10 +81,10 @@ config TPL_TEXT_BASE
>>>    	default 0xff0e1000
>>>    
>>>    config TPL_STACK
>>> -	default 0xff0e4fff
>>> +	default 0xff0e4000
>>>    
>>>    config TPL_SYS_MALLOC_F_LEN
>>> -	default 0x600
>>> +	default 0x0
>>
>> Disable malloc in TPL on PX30 instead, that's actually what you want to
>> be doing and not "reserve 0 bytes for malloc". That's gated by
>> TPL_SYS_MALLOC_F.
> 
> Ideally we should disable TPL_SYS_MALLOC_F, but I thought it was too
> obtrusive to change the default value for TPL_SYS_MALLOC_F as part of
> this fix, so opted to just use 0x0 as size limit as there was no
> difference in code for the resulting TPL binary. The only benefit of
> TPL_SYS_MALLOC_F being disabled, beside being schematically more correct,> is that GD_SIZE could be around 24 bytes smaller.
> 
> I can set the TPL_SYS_MALLOC_F_LEN to 0x200 and fully drop the 10 to 11
> KiB code change in a v3 if you prefer that over this?
> 

If we don't malloc() today, does it matter how much TPL_SYS_MALLOC_F_LEN 
is? I won't take the TPL_SYS_MALLOC_F_LEN = 0 change, now or later. If 
we really can disable malloc in TPL without making our lives much harder 
in the future, I still think we should aim for separate commits for 
disabling it and then reclaiming its space on the SRAM for the TPL max size.

Is there any chance you can check we really do not use malloc() (and 
associated, like realloc, memalign, valloc, pvalloc, calloc, 
malloc_trim, ...) in TPL, I'm a bit concerned by what this will limit us 
to in the future as well. The helptext only says the driver model (I'm 
assuming DM/xPL_DM) needs this but it isn't actually enforced at the 
Kconfig-level of the DM/xPL_DM symbols.

>>
>>>    
>>>    config DEBUG_UART_CHANNEL
>>>    	int "Mux channel to use for debug UART2/UART3"
>>> diff --git a/common/spl/Kconfig.tpl b/common/spl/Kconfig.tpl
>>> index a535b61ecd35..cdb9cb188c7c 100644
>>> --- a/common/spl/Kconfig.tpl
>>> +++ b/common/spl/Kconfig.tpl
>>> @@ -129,7 +129,7 @@ config TPL_MAX_SIZE
>>>    	default 0x2e000 if ROCKCHIP_RK3399
>>>    	default 0x8000 if ROCKCHIP_RK3288 || ROCKCHIP_RV1126
>>>    	default 0x7000 if ROCKCHIP_RK322X || ROCKCHIP_RK3328 || ROCKCHIP_RK3368
>>> -	default 0x2800 if ROCKCHIP_PX30
>>> +	default 0x2c00 if ROCKCHIP_PX30
>>>    	default 0x0
>>>    	help
>>>    	  The maximum size (in bytes) of the TPL stage.
>>> diff --git a/tools/rkcommon.c b/tools/rkcommon.c
>>> index b39777fc0607..872fc21c039d 100644
>>> --- a/tools/rkcommon.c
>>> +++ b/tools/rkcommon.c
>>> @@ -137,7 +137,7 @@ struct spl_info {
>>>    };
>>>    
>>>    static struct spl_info spl_infos[] = {
>>> -	{ "px30", "RK33", 0x2800, false, RK_HEADER_V1 },
>>> +	{ "px30", "RK33", 0x2c00, false, RK_HEADER_V1 },
>>
>> Downstream actually has 0x3000 there with the justification that SRAM is
>> 16KiB and BootROM has 4KiB reserved for the stack, c.f. 3bbe0d2f9129
>> ("tools: rkcommon: add rk3326 and correct spl size for px30"), why are
>> we still 0x400 below?
> 
> I actually tried to change to use 0x3000 value in a prior patch, but
> dropped the change due to a response from Kever [1].
> 

I understood Kever's comment as "only take what's in downstream, no 
extra changes" and 0x3000 is coming from downstream. From looking at the 
changes, the RK3368 one you suggested back then is different from what's 
downstream (0x10000 - 0x1000 instead of 0x8000 - 0x1000), same for 
RK3288 with 0x18000 - 0x1000 vs 0x8000. The rest is identical in result 
although they may be written differently (e.g. 0x2000 - 0x800 instead of 
0x1800).

> For most RK SoCs mkimage use a hard size limit and only exclude the BROM
> reserved area, and for some reason on PX30 the size limit also likely
> leave room for U-Boot TPL runtime needs, e.g. BSS/malloc/stack use.
> 
> In my opinion the mkimage tool should not try to impose any limit on
> what the packaged image does or require during runtime, it should just
> be a simple tool that packages binary images into bootable idblock
> format and only apply hard limits.

We need mkimage to validate the generated image is usable. I think 
0x2800 for the usable SRAM size for PX30 was a mistake made by Rockchip 
in their downstream and we just used that when upstreaming support for 
it. Downstream fixed it in 3bbe0d2f9129 ("tools: rkcommon: add rk3326 
and correct spl size for px30"), dated "Fri Jan 7 15:22:54 2022 +0800", 
while upstream support for PX30 (in tools/rkcommon.c) got added in 
c6e66b12e4cd ("rockchip: mkimage: add support for px30"), dated "Fri Jul 
12 11:43:34 2019 +0200", so it's just that nobody bothered fixing this 
upstream yet.

I don't know if we take into account the malloc pool size when computing 
the size of the binary (or if we should), but there's a tool for that I 
believe in tools/spl_size_limit.c that's triggered if 
CONFIG_SPL_SIZE_LIMIT != 0x0.

Cheers,
Quentin
