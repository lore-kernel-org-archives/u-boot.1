Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 699BEC52D7C
	for <u-boot@archiver.kernel.org>; Mon, 12 Aug 2024 08:23:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C34D388614;
	Mon, 12 Aug 2024 10:23:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="QU51NL0z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 134AE88614; Mon, 12 Aug 2024 10:23:13 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E90C8806A
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 10:23:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qFKBCmhormndU9dHufX/dhjKnlgpPqnKyiZZVLZF+91h+U3kHrNu/ZmVZwEw6vFS+P4R0tMFvN8auzEukg6Z9W9zlAGA8ZPUUhP41HLZCsj2yvoZdlA8IJ8moT7MfxWTLHjNPQQiZkacW+c5LPSiImWxDuBt6BTfthJkKd8Yt4Me5gyKknimSk/LFaHBCVdQU2OmDG62bRq6bHy3qXcqoJMMea5V45IRMs9AB30jMTWgrtREHFLjYrFOJlM0SEa7BTc+R64uS6TQWJ9A9RXDlGYK48ifkH27ouuxjK4ZCjLJhWKvEdFw56Unuj0rvpJiJc6dxloMI7Lt6A0gyj08+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yO2FFmEJrjg1f4vO5dDxKyuEIQGum9eslrZ7CqPlgCw=;
 b=xTHrn5gu7VV0Sr5dD2u55MliV5NYYentpDGx4ewtDrrc7MhdDxB3H7cUK56+4P0dHCG3iwCLbwH7zPZ9zBzskmXlXrmPjn5X2VGgo+DCzWwxbMM0nEgIkUHDvgk1NBjmSAe+3dUbCp4xsY2oyYMc0L5miqfVQNdpQuSIfSjH3ML03ME2/UVlGgcd2l3CjuvSLwRpVBL5XminN+2X1dKTAYcgLvBOu7xFVOhxwbRYDXUjGjrJ7QLo96ogUUpet68LZBNbQgkHYIel5fZ23t5uOVB120/AVjtpkO9GxJPzMsyxPqfTkSNCyKLLA+Tvr0rc4i5rG22mXHmhOldMSIYtiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yO2FFmEJrjg1f4vO5dDxKyuEIQGum9eslrZ7CqPlgCw=;
 b=QU51NL0z4bC5jYBO5sCub3tO9QuXvPXllEF+r+mKhT/TtUOP4SMXMpgwAiz8faLLkjU/4TFm3Jvy1kciulkV+xLU0nLkL4pbOFICba5ACLXDvIA22a2KQfs4R3OY6AI0puWT5eCCdqQa7ZbHraJFqIiMIZij7/BVdCqthTOE+DA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA1PR04MB10503.eurprd04.prod.outlook.com (2603:10a6:102:446::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.19; Mon, 12 Aug
 2024 08:23:08 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 08:23:08 +0000
Message-ID: <6d73380c-d554-4c33-841d-1f6c0c025b7e@cherry.de>
Date: Mon, 12 Aug 2024 10:23:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] board: rockchip: Add support for rk3588 GenBook
To: Dragan Simic <dsimic@manjaro.org>, Andy Yan <andyshrk@163.com>
Cc: kever.yang@rock-chips.com, jonas@kwiboo.se, u-boot@lists.denx.de
References: <20240811100255.1664095-1-andyshrk@163.com>
 <20240811100255.1664095-2-andyshrk@163.com>
 <04ce9048d54f6d68a46967485c6ccb0e@manjaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <04ce9048d54f6d68a46967485c6ccb0e@manjaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA2P291CA0014.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::25) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA1PR04MB10503:EE_
X-MS-Office365-Filtering-Correlation-Id: 26a06180-aa06-47c1-49a5-08dcbaa7ff1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NUNOYTU3MTdmaUpOSzNQdys2UU16ZzNnemM5UTZmblA0S291ajdrVzA4RXNK?=
 =?utf-8?B?bFd5T3NScHczRWhESG1wK0pwdGRubzVmdG44OFFhZnI3emNYT0pvZk92YUpi?=
 =?utf-8?B?SUhINjdKa1lVcWhicFdqdy9rdFVBaGZOYjloRlZES1NTOG9iWVNEak5uT1Za?=
 =?utf-8?B?NStGOVJYcnJMcUFTRkJJanBkLzlFMnpkRHphaFpRdEhNdGdtWHJmWjdPMjNN?=
 =?utf-8?B?TUxxWWpxaVVnaW1tMTg3SStHZlRhYlFhaGZjR29lZnFiZzBwWGVRN0RZTXZ2?=
 =?utf-8?B?ZmpiSC9LVzNCUHlVbzQ2T2ViaHRieTFVekIvVFJmZlFaK3F0K3NnNld4OHUy?=
 =?utf-8?B?dUZOYWcxdjNmc3RRSTFoYXAzRDVVbWhabHZMZXZNR0RGZVVPZ1psaFlMSzg0?=
 =?utf-8?B?NmVFVUt0b0Q4TkdvUG13M0ZSK282TDlQVFRUTy9wdWdFMVhWbUkrMmVIcGxE?=
 =?utf-8?B?amNNbjMxSHdBdDc3UGJ4Yksvbkg0TGsyMVl4NmphMEc3SCt3UlNTR1p1ZC91?=
 =?utf-8?B?a0g3aDIzMFJsNG9ITEdDd0h5akZLYjNmQXY3cW85NFBiNyt1MkJFaU11RW4y?=
 =?utf-8?B?UTlsa3dCODZsZDJJTkxKZDNKVWNOMXpHTWpwRkgyMDhTK3d1N09CYjRCOFhr?=
 =?utf-8?B?ekYwZW52bkhmcmJTd0x1MGx0MUxtMmpueGpDaWlNZ1NYT29DYWNmUzBYdlFW?=
 =?utf-8?B?dUNEb0RmT1JxK3o0QkUxd0tWcDZodW5aUHlDTmRIVG9haTBjMktTSC9WZnV3?=
 =?utf-8?B?VU0xMnpzdEJGQm11bjlLVjFEVFZOOUI3aURTbHVwOWlzS0FLenR4anFHOFBn?=
 =?utf-8?B?Z1ZUSWlLMitmMFBaK1R4cEc2bmg4cmlZWm1jUGtPSkpzdDNuQWFkamx2UUlB?=
 =?utf-8?B?K3BMTzYyNDUxbHpJUm1VOGZld1ZEQkZCRWFmaXhVcTZ1U09vYlNPak9VV0JI?=
 =?utf-8?B?WFNFVVhwcnNjS29GMFZqWElzamEvcW1aTFdBVG1VOWFvL2ZEd0NKWm94eS9u?=
 =?utf-8?B?OC90cllDZkxOY1k1ZmdZZ3Fya1RTMTZkK0dUeG9BaG1IQzBDTWR1RExPNDZF?=
 =?utf-8?B?aE56ejcrSGNONDZXeW55S01OY2w4NkNLZmx4KzFRQ3ZpOXkya3g4NDA3NmFz?=
 =?utf-8?B?bWVOTXliVTRGVkM0Wlh0MGJ1NjZQRyttcjNhanBwZHJoQlNYUDROK3l1ZkNE?=
 =?utf-8?B?a2hRMzE1eUY5anppTVBZWE5kWE5Md2diTFV2WVNydnBmS1dyQmxDeEVqWUxa?=
 =?utf-8?B?di9Falp2bzIyVU5TZW5DVm5WRHIyQitMQ1hSTHpXS3FzMzI1a2s0UW45Tk5G?=
 =?utf-8?B?cDZpeFZUZ3hnNHJyWVR6NzRocWhhcFAva2Z5dEFrZEpUcklkdm84aEFJaGMx?=
 =?utf-8?B?U0E3UEk2eHBKeGdnZWJTWUQ3TnFQUlhWcVdxOHpoQ3RNZGRMZTRLUTR0V0Fw?=
 =?utf-8?B?K2FOZzRxN0EyQjZSam5aSVFqREFLRUtQcnJtVG1RYWhoTkdXQjFFVEhLWjl6?=
 =?utf-8?B?bnhENDY4TDdrZk9NTC9vcUtaazNaeFlIQ21FcnVJMW1SMUxCYXV0UFE3NWNY?=
 =?utf-8?B?ZlN0VVJlUGRUOU5MdGxObFpBUjlyVjhFQWlaOXJwRjRZaEsza2c5c0FJdDJk?=
 =?utf-8?B?MkRvWEwrclRBeUFXT3I2elVvdEF2d3FzNUc5d2VCaXQweE1vWGtYRFUrRC9h?=
 =?utf-8?B?UTYrMzVNUEtmWHJXbmhvTHhlNngxcUlIZXdpUnZXOTd1UVJKN0JUU3duNDJ6?=
 =?utf-8?Q?kjbVW788M/IxHVdMIk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGNMZ0tlZlhjVjB2NU1aL2NlZmNmTkhIaVpzOG05eWpTTC9tcTIxY2ZSUVMv?=
 =?utf-8?B?YkR5SXJxNlVOeEJtM0t3VHVVNGx6Ym9xVGZmNFpmQlBFKzRYeEdYemRnWkth?=
 =?utf-8?B?V3VJTTNTTXFNbUtLY3Q5SGcvRDFRWi9RemxTdU1VVmNad2RPSW8vUkFubDc2?=
 =?utf-8?B?d3N3SkRtT0I3MlptZnFSVGdWMnBQelI2eE00OXhBQTBsSkFVUUdrNzNMdkl3?=
 =?utf-8?B?Ujl6SEdBUEt5Z3hxckV4anFabEE3ZFpFRHNDOXM3M09OWmVxOG5XVkhMOHhY?=
 =?utf-8?B?QkVHZzdpbWdFbEQycEc1SFFVV2JQWXdhSUtQNzRHOUV2aWhOSTNicjA4SEcr?=
 =?utf-8?B?aWQ1bTUvUGR6TVJ6WXZqcDFpZEhPZ1pPY09xTWJkV1pDOVpZdkFMVFFHM3A5?=
 =?utf-8?B?MmhBUDF3VXhEaW5qWmJUTEFHRDlBbEt1c0hkQUpWVXFJSzhSS3JHQUN3dm9U?=
 =?utf-8?B?T0xRQWNsRkg4OXdtUHh0REViaUU1eVkrSG43Z2lrRjlUaml2bkhkc0JnSVBo?=
 =?utf-8?B?YWRqZ1h4MDNyRnRDdEt1bVNJSVlCbW1LRTZNajByZENES0puclV0WUhMcFlV?=
 =?utf-8?B?dFRGaVU4ay9EWkRwcXQxSitWRkgzN1NhemxSYStEUDZkWEI4TGU5V2NYcXZh?=
 =?utf-8?B?ZXhiWWY4MTI2MVNBa3I0bTFHOWtkYmNaNWUzN2VpcmJHMjl5a3MybzdyU1V4?=
 =?utf-8?B?eEhqWmk0ZzQ0S3U1M250RkpNVkVmMmJBU25pTUFMRiszN2R2K2FnZitSck9E?=
 =?utf-8?B?UmxvcjlYN3NBd29GYnhkVTZpbmhobnBBY0J0bVZQVllFU1hyR2ZjWHRZT1pD?=
 =?utf-8?B?UU1ZQm1MSk9TeE5lcXZmdXFYamNWMGhLUUx6Y0tpRnVzbDNhZ1VhNmsrVFdi?=
 =?utf-8?B?N3QzeTNsZldqOVpVc1Bmckx0RXRSdkxVTmc4UnM5cDBQR2RsL2F1U2o1TE5Z?=
 =?utf-8?B?bHJJaXpOZ2lGd3JyWVB4WW5OTUVmSzhRaWxPRGhWaVRmNkRMc0R6cGYwYVVt?=
 =?utf-8?B?YnRJa0JpakMvWVFMRVI3VGUwbGJpbEl2WFpDbzJCcHp2ZjN4TXJmMVdCWFlZ?=
 =?utf-8?B?bjZqN1pnd1RxN3J6UFF5Zk5Fdlc2aFJFWTNBcWJKSDBzSVdRU0JYejVsU0dz?=
 =?utf-8?B?WG03V1RNUGR5bGhXRWJvbTZQNmp0NXo2NSt5dFN1ZjdRNFpwUncvVlN5a2ZW?=
 =?utf-8?B?UVF0dXNZODE1VFM2TlRhRit4bnFOMlpaR3ZNa3dsdVJaZ0pUWnRKdUMvRW0v?=
 =?utf-8?B?czg2TGIzL1laakpLb1VmbzZOMGovQWF2VVI1aGQ2a1FFSGsyWHA5UVpFc3RJ?=
 =?utf-8?B?d1pvQ2NqekdPTitZbEdmbVdHYlZybFhMcVF5OE5KTFU0ejRIeDY3RHJoTm40?=
 =?utf-8?B?TG9NdkhWdHhpK2ZCQ3RqQ3laa1JaRlNQdXhWL2RvQ2ZpYVVVdmZJVWh1aDFP?=
 =?utf-8?B?ZFhpVFFvalFBWnVnazNWYnNrSURBMXZKYXl5bjJKelNMdW9JOCtlcjF5VEpM?=
 =?utf-8?B?dVc4Y1I4WC9MTk1sQ0VMZS85ekwzVUlReUpNNjA3OCtmWTBSUDQ4c2tCbVFG?=
 =?utf-8?B?SzJUc3dQYjcrV1pjVGVBbmNCM08vSjhnWGFidWRDTUxEeVA5WUFvUG1BUHpE?=
 =?utf-8?B?dnZJOG1JV3NRcnlxMXYyTFVwbkY0VmY0b3BxUWFFZjU1MVFCSENIZkZVTTNE?=
 =?utf-8?B?R2RJU2xqK0hzWDAwdW1uRkVUSmxEYTdHdjgyeVlYVGM0M3RaOFJVTnpTaTRp?=
 =?utf-8?B?TkN5ZjVJbmxRNStrMzVyVms1ZUxaUGQ1UVlpSWNqVlVxNFhTTXgvekJHd0Vq?=
 =?utf-8?B?MWhXNDJGUWJiVC9ZaTA1SE5lRnlQTkFYSVZYRWVSTmF3RVh0bmN2Y1NFVURG?=
 =?utf-8?B?MUVkOFJkenpBamQyVTJBdHlCei85OXpWRVZHS2JnNzZQajVQRmUvSHpiYVdY?=
 =?utf-8?B?U3RDNHNSR1F1cXJmbTc0VFo5aFVtbjBZbGNybXZyMnZrcGFId2ZuUWdSa3VG?=
 =?utf-8?B?VWpkMG43djd1bG02ZGNVbU1QNC95RVFuNDhDakVkakI2RlJJQTN6dkJ6WTZp?=
 =?utf-8?B?T0VJMWU1bVFmdVVEa1ArL3doQ0tPQ0ZJTldrNUZ0RFdwOEx2NDA0UlMrb0ls?=
 =?utf-8?Q?o3r5ssIoBjDOQ0ZTrWm1QFHjD?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 26a06180-aa06-47c1-49a5-08dcbaa7ff1e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 08:23:08.3878 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q+RN/OesdV5IMMX+wZQ1zE2IQAJcuJrulZyMtAPEO7hnk3rGmKkzkE4AElhkszMltEMwidrgAu7FAklggGCI0vtAbfDbTGVVluWYh51TaRA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10503
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

Hi Andy,

>> @@ -323,5 +329,6 @@ source "board/rockchip/evb_rk3588/Kconfig"
>>  source "board/rockchip/toybrick_rk3588/Kconfig"
>>  source "board/theobroma-systems/jaguar_rk3588/Kconfig"
>>  source "board/theobroma-systems/tiger_rk3588/Kconfig"
>> +source "board/coolpi/genbook/Kconfig"
> 

Order alphabetically here.

>> diff --git a/board/coolpi/genbook/README b/board/coolpi/genbook/README
>> new file mode 100644
>> index 00000000000..ba165953154
>> --- /dev/null
>> +++ b/board/coolpi/genbook/README
> 

We've moved the READMEs to doc/board/ so please do this as well.

You may only want to add your board to doc/board/rockchip/rockchip.rst 
if the instructions in that file are good enough for you. Consider 
extending the content if it doesn't, and if it's too much work, then 
creating your own readme in doc/board/ similar to how Theobroma Systems 
boards are documented would do just fine.

Note that those are in reStructuredText format (rST/Sphinx).

>> diff --git
>> a/dts/upstream/src/arm64/rockchip/rk3588-coolpi-cm5-genbook.dts
>> b/dts/upstream/src/arm64/rockchip/rk3588-coolpi-cm5-genbook.dts
>> new file mode 100644
>> index 00000000000..6418286efe4
>> --- /dev/null
>> +++ b/dts/upstream/src/arm64/rockchip/rk3588-coolpi-cm5-genbook.dts
> 
> I believe this should be turned into a separate commit, as a cherry-pick
> of an upstream DT commit.
> 

Yes, as a hint, you should be using tools/update-subtree.sh pick dts 
<commit> as documented here: 
https://docs.u-boot.org/en/latest/develop/devicetree/control.html#resyncing-with-devicetree-rebasing

You may need to pick more than one commit, that is fine.

The commit id comes from 
https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git/.


Cheers,
Quentin
