Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01F31C48297
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 17:03:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62EF78723E;
	Mon, 12 Feb 2024 18:03:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="ixn2o9ig";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03EF78723E; Mon, 12 Feb 2024 18:03:07 +0100 (CET)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com
 (mail-tyzapc01olkn20801.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:280c::801])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5106087732
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 18:03:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=forbidden405@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CStAK4EuQS4M0LWSHrHTqSwFT9NmHxR9siZEBS38fTF6uEIxgOlcG1H8iBmZpJ+U/oxk+NVG6cJWHm+VVC9kIXcJFpcjNGCw53GkKpXjEFQedNyg+dB4PT7yRm2pQVVeHGVrIpGV7H44+U40T5dm9haHwXKPQXF3vhnAPa8zM+KcNWUdTjdSirC2QuH5S1PLwV+Yc45oLWzZzOnQhjdWQlZBlfaBDjx0RWMdb8MeqR+689kDCytLVb6ObcLZyZJSaMGbrzmGAAGMlcAvyY1xH2CL+kB+XMiXawaSuFpClY9UAdvXpSgp/3PdIzl/J8D4sXsayx6m0YwExFDBkeNacg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PpYqLs0UNJW0R9bvcadhYr1AfZ4op0Tsi0CvEVgDFk0=;
 b=gGr83UUoF+A6sYCnaYNpSHF8gPc94QHbnwTy7TSsOfvHsCJGaeMOcL+Y26scw+JElTkr93xd5isAdj1DR3JkXlPTnGKAuZ3biMbHRpdaArwlN2psCB60vQ3Ag9nh5rkbtpK7indeu3XAPbOSwai/7//92Y6mBzmw38ecBFfabzwFXek4MlCCCIEWpedNIttxW7g08++FkEt/ZIVoMv/881VYTunKV9K2H6M3MlCSatDxnzgCirgNC2SkfsVECVmZRJ3Ml8L2LVP8Iov2SoMU761ZTd+KN6qUZJWc4cmh5mZovjzskVlkeEmbfPPrU9VOtbBM0IsZ4ew3lQC07S6VJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PpYqLs0UNJW0R9bvcadhYr1AfZ4op0Tsi0CvEVgDFk0=;
 b=ixn2o9igwPV40woCSUTZUGEhqEF67P31Y5dQHUKTIQJgIgvN8rQO7LvFHWxH+9d5teW5NN7BIaHXhYUuLyo3ygZYvngzAGOgNB+IKsvZtLjTQRBMo3f+p1jty9xBkOdQUanbZxXLMRHpyYdyysglzs6aYOssixWjvI2tgr1ZPhQypNcnyugL3JRHy1J7JIRAhOXa3n/V4G1EX4mDgu6zUCcj3dgg6QN6nZKRj6qEk9hrPYJylpE1fCenmXzjKx/Oaf161LDIQyKLVtGjVjt1re8P/cr9XdZsgBdx71Lz8Vy82ZvJKxHVzeIyFqeZ0fQLIbWtAaa2+LNh2HTLSE1Tjw==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by PUZPR06MB5794.apcprd06.prod.outlook.com (2603:1096:301:f2::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.35; Mon, 12 Feb
 2024 17:02:57 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::9a6b:d813:8f4b:cba1]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::9a6b:d813:8f4b:cba1%4]) with mapi id 15.20.7270.033; Mon, 12 Feb 2024
 17:02:56 +0000
Message-ID: <SEZPR06MB69597D40FEF2059B89BC68D196482@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Tue, 13 Feb 2024 01:02:50 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] pinctrl: add support for HiSilicon HiSTB SoCs
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Igor Opaniuk <igor.opaniuk@foundries.io>, u-boot@lists.denx.de
References: <20240213-pinctrl-v1-1-e71c8ead72f2@outlook.com>
 <20240212165827.GJ3040305@bill-the-cat>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <20240212165827.GJ3040305@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [cb+PJKRiJcK0fEzcfvj0Z6nqbCz475OzRtD1dA7623r5nYF7EdLpMR3Pp6OxoFk6j6USXkgMG5g=]
X-ClientProxiedBy: TY2PR0101CA0025.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8000::11) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID: <9eaa0a3e-2fb6-460d-987d-4d14825acb4a@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|PUZPR06MB5794:EE_
X-MS-Office365-Filtering-Correlation-Id: 175a8e73-0653-4d6c-2462-08dc2bec7501
X-MS-Exchange-SLBlob-MailProps: laRBL560oLTYF3BVvcfZzLdqNADu7oxW7GL/lD7xyWF/t8zqXreO4Q9qil0BKSNCzuu7jhaG+n3hD4eC6ZRGyxJcvB1CNVjBPXTBWJ+dmVtMOgytip0ubI4wZi5K/CTdTQEXGc0HcWR3S6l56JtCBzNpnpFrKlp2qW14bmq5cCMLlS0oVk/hxmY8UfiS+MiQLKmaVqyTG7cVL9GNLCpFZ20LKAP5RbpLtrjloklaGLtCGI4crSEy7jFWPfiyhFJFWkf5e3Jk7P4zPgkacu8LG1v2ZzZDOAdS8eTMl9GHUeuL4PaZussBhAVcKa4Vs4O4pz9eSi8EjDSZbCKkDLmUJS3Pn094Xq1A/7OCFwpF16iz4v6KBviGDb+DkilWaV8siGFJowKX8RzUSkMCbf4xf14nVH2wmaX7hbTwBuEMnU0XGvFJrjjXyHZtQJDYJ2Id9ZoOusaKWcJ1n5pxao/69vTZnxNr7KsX8yDPs7fMx16a6stC1fitEYoH35tnPsx+7ivPiU+zregaAU+5cW/UHHWT15mYK4nSRrdh4IoATzV1OnFWZ4QZdNPa2FOdzYtwSP8fUiqA0aL9mG7LkZBEyCyqbi2RokUQH6QfG+D+yKe1GJrd0bb+Kf2V6ICpZ5YOZQnLBMDsK+ToAN8CWHyjBfJ2+P9cLPoPXcElH0WIr616p6JMxoN3TdL5ubKYgfnVNEG44l6TS3dpNFT6msjJcX7CiK6cT7Xj/hDaW+NkSZZjTkdbbb5JxqQ5m4Csq6ECpayf/i+IF1Q0QSmi+Ut46vUM12P5JrPW
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V+8K7MuxJCaN4U3Fhn8rEt9sQ05sv3RZ3d58rxq+Oypsd1Oyt4dwb3xUijW6BHrNaSsuIel8y9dBePBhIxRgqhZO1GptYq9p940TZ+PrkOijMXLoUW7iReMaZyckoIGGkjABjq28db/3hQm/c+tnbQvTYGk3+xIM04vaOwjfFeT3cGZCkaskvLa1DC2CMLsY17Lcj/XFtJDDjfK8yP/eCHunfYbJ4UgeAswsrzp+4ZArbAQEhjHEXKZgKyRzt0bQPOhaSJI8q0fFQMwSmM9n+K/W2n/4HbePp6iF1dNb4Pcoc7gi5jtry6UyVuSDJ3qVAEwzHgjXGbiABsa+3/Zho7jVmnbTYXlhSqEGsfHBkl14cVlPCMCQvCzfCuy4DIQljewxxLlsnXtyGJ5vWVkgJIYOWLDh9z/4IIII1XzYkdKlROAjxdTLpghnILvY17X+CLx0PYqbBHOxbR2s4VorS9yDg4OmPOW1qvFYU1/jkEIdKSk7AIviNrejobWioxJEIkcZGCCHnzA9DG2wt9c7zIdCDzJmGPykKrMhirwGLg5xYuls4LiFj7ZEVRrf9s44
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0xpOUJFM2xtN2FKMnBWZCtHUlFIMTlLSjJGalU4SUpsRmp0NXAxb2lFOHRO?=
 =?utf-8?B?NjFiOVZEVTZsdE52TkovYlQ5MHZzb0RuaGhHSEs0NnFFaURzeWVhdm1YY2k2?=
 =?utf-8?B?cU50VUx0SzJqN3RkVVQvLzZVc3FrTHFmTklxK0NPZGdBMXU4dklMRVNzdTVJ?=
 =?utf-8?B?TnZFWjhET1JyWCtIWForb2hZR1JDaDVFeTZNQ3VRdXR6aWtjY0ErbWNBSlBD?=
 =?utf-8?B?dlI2amRUUktEZXZVZ3RRSFBUbi9WdmtzMk84L3dqb2hXNS9XNnJRemdmL0pj?=
 =?utf-8?B?NmVWeDFENG84TzZpVC9hUnh0ZFA3OUJyeVQyRlNJVDkyQ3g3SURYNzBqUzJh?=
 =?utf-8?B?VlhnUFhsRS9hbUJvVmZseFNidWlNZFNDMXZSZXRDOGtmR2w2dDBObFdVVzhZ?=
 =?utf-8?B?eDMrbUhxSG9sTG5hTUR3L3lqdkZPbmxFNjFkZm9hU0ZpbFdWekl4MnM3RXVR?=
 =?utf-8?B?dHZodUVwWEVDbmdheExzd2p3UDR6VU54VmJqa0htLzJ2VnpSNTc1RmtwQWFE?=
 =?utf-8?B?bUJSbHJOTW1pak5ZcVVNcTlvNjY5N2xKV1RhREtKejJ2NWh4R1VnSVFnTXpt?=
 =?utf-8?B?dmFPaUtDTHk3a0M0bUNuMDVLTk44eXF3YmNPZ3JqVXNWeDk0NjB6Y1JLYkdF?=
 =?utf-8?B?T0JkYjZGMS9BMDR0c0pkWmVZcW5sVTNpeWpNajdxNTQ5NnZZK1UxZlh5aGI4?=
 =?utf-8?B?RE5USHp0Z25YK0JaeGU5MjJ3UDNHNEl2QkNpSWNSUDliRVovcmxuVTNCL2hM?=
 =?utf-8?B?RkpzUkVPekJBUSttYk93NndvbElhNzFXb1hxejJPd0RqNmErT0l4aDFpS0lI?=
 =?utf-8?B?K01FNDBsVEh6NTFNaFRvYlYrcXQrdmo3d3FjMmFodDI3MnhoOFk3L1VFbCtN?=
 =?utf-8?B?ODhuaVNDRFVCb0N2aVFRWEhUUzVidUE2NUtMSHQxa0J0REJzUkN0NjRCeCt2?=
 =?utf-8?B?Mk5LblRMWHNjc2RTWVJ6YUZnUGdMbnl5VEQ0N1NhWlAwTkJWdXZBcTBOT2hk?=
 =?utf-8?B?bE5KRkhLNXNsYXcyQ3dKemhZWk12WE1vVXh3T1NBM1l5VDVnTk5hMWg2Ulkx?=
 =?utf-8?B?WHN5Y1V4SkJjY0dDMVd4am1EREZVSVlFN2RaazBaVkJXZ3VkK0tqL01qaVRB?=
 =?utf-8?B?Y3VjOEZYN0VacmhkbVdHcElMdFpoV1h6cEZybFNlaW9keU5HUHMwSkE1eHhJ?=
 =?utf-8?B?dVBIaTk1dDdKV0lXTHVPWFY1UFRTRUFRbUdCd3VLSUlucWFEMHVwNWM4bjNT?=
 =?utf-8?B?VHJETis0VlRMeDdCa0JtV3FrS2gwRDlpYi9lTDVRSmgwWWMxR1plT002VENR?=
 =?utf-8?B?VUdPNkNoWnhFM00zeThxd3o0ay96eG42R0hvVEU4RkpoS2RCQXlwVVBYQjJt?=
 =?utf-8?B?TGR1TjN3UnhZK3Y2OUh1L0hqVGxwUFRqRWRjZU9paEJSMXlLNTBMVVVGalFR?=
 =?utf-8?B?c2NKOGJOYUxTR1FOUzRaSzRTMk5HYUlFRmlMWk9QQUFndVJKUk5LcU1LMmdn?=
 =?utf-8?B?ZjRZWkhYZDZ5OFdVQjJNRHlndlpiSXA0K3RLcXpITWU1MmszQjVsL0lvNTJN?=
 =?utf-8?B?M1FMdHFqeVJ3QUkySXpkK2NhNWlCRGhMRFFMUnoxdUUyTWpkaHBzbXRDRE45?=
 =?utf-8?B?ck9pQTVWZk9HSFl0bWxGbU9xelRxVnBKb0g1T1FOM1p4RWdicS9qQmZRQVYw?=
 =?utf-8?B?djNMakVsRkZaZkZYZjBHbWdFUnhVa0R2czlHWGJHbzNRdThGQ3NGV1hGZC9t?=
 =?utf-8?Q?HAJqvTK8mxJgDzn8mRDgmdqLaFkeizFbSnKBCnF?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 175a8e73-0653-4d6c-2462-08dc2bec7501
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 17:02:55.7317 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5794
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

On 2/13/2024 12:58 AM, Tom Rini wrote:
> On Tue, Feb 13, 2024 at 12:30:15AM +0800, Yang Xiwen via B4 Relay wrote:
>
>> From: Yang Xiwen <forbidden405@outlook.com>
>>
>> The first supported SoC is Hi3798MV200.
>>
>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
>> ---
>> This patchset adds support for HiSTB ioconfig module. The module is used
>> to set pins config(e.g. pull-up, pull-down, drive-strength etc..) and
>> pinmux.
>>
>> The first supported chip is Hi3798MV200. Adding support for Hi3798CV200
>> should be also easy.
>>
>> Below is an example of the dts node:
> [snip]
>
> Has this binding already been accepted to the kernel? Thanks.
>
No, I've not wrote the driver for linux yet. That's why it is RFC now. 
But it is expected to be soon. I'm going to finish u-boot part first and 
work on linux kernel later. After that, i can sync linux dts and 
bindings back to u-boot.

-- 
Regards,
Yang Xiwen

