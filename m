Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70B97CD11C2
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 08:48:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D630187FDD;
	Wed, 10 Apr 2024 10:48:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="WmQIXaK9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 895E587FDD; Wed, 10 Apr 2024 10:48:03 +0200 (CEST)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260f::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DBD587E1B
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 10:48:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZfdvlnUGXBmUy96IFgl6YNRf+J/5M5kl+IWd6irf0RwC/q+6/IggkvjW5eS/UZl+QlGGoRMEHc3O/0/nslWrKd8/KiM7kSCmKyZpc39/3sSpFAQtVnKJenn+2xTbG27bI05XqQXDJJiJdlE6oaclsHWZAb20mw9AxuFXeeYLjjWjG9cnN7FPp9HyBTOZh9LBPO9/RUDpc11nQlSyno9g/t+Kf04QTKll7I6vtWir/zEOmAMF9iNuzihhmBfP4Nn46THqnbNzos9DiM5XeBEhWSoxUAdhzc4fdbqQTTVvWR0rUqi5li5c4ETXy/Nm5BS35Xf4Qf/c9X4KdJ3pRXsNPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eajgaM5fzkXgCVb7EugTXfsU2KWNZdzmQcMiVpY3eSk=;
 b=FoYHisA8aisHyZMQskx3oRUcZ5Nc5C33AsxCA0jWN7D0vkLupBT1mLKA8yK+urSGKHiJU41A/1NW+GAAuFEDz+QpYevS84ufWlpFCGjBG/TACWHLL91YghbrHJ+Y4AnXja2jvfeU7U9WS5ZPm0gRCmHbSYDLpSbQINQ0rNi8UZiApukSZye0e79vO70AI6M36ZEUuwNGW+b9TP4g7XYbA5dGz4J0bHYIqIeWzg2pa35WAOa841fqB5PEw82mlQh0vg/MR1GWMs1jtSj4hngPzSHY5d8K2w26KVNAnSDlchY538SsqWXsTN0CtH7vmbKyqil1MfS3sCi9n5/MwMU9ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eajgaM5fzkXgCVb7EugTXfsU2KWNZdzmQcMiVpY3eSk=;
 b=WmQIXaK9Zh+eosaiNMpVfCbMkTDJWWw0qOS4HSdbBafBEeEoBYX28ksyFuER8o/+UkUjWHh29y806ubGb1U8IL5nKc24YrC1Jr5GB3yRYBQDVrDb//ldWm2EVmtphMm9Ue0MZ7OMjY8MvT6SLG1moGDbucusWkgqI39shECut+cOvUGLDQwPBjbW2lff7wEydeeSZ7Lx/W5F/gnH1QhwH8cZ66pht0T/bsVVCAibbxpWn15xd8mRkZ6FFTas3tA8TP1f9Ge9yUr6ZyB14d8jq80pZPQNztGSr+icF2keUOG2IN59NLOHtiP76dfBrPYLdke8s3G9u4SS2ljtfi8sfQ==
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by PAXPR04MB8093.eurprd04.prod.outlook.com (2603:10a6:102:1c9::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Wed, 10 Apr
 2024 08:47:59 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::3e70:7029:faf2:7779]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::3e70:7029:faf2:7779%3]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 08:47:59 +0000
Message-ID: <3f0733d4-1739-45f8-adf4-57070ad21d2b@theobroma-systems.com>
Date: Wed, 10 Apr 2024 10:47:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mmc: Imply HS200 cap with mmc-hs400 prop to match
 linux
To: Dragan Simic <dsimic@manjaro.org>, Jonas Karlman <jonas@kwiboo.se>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20240408210619.3749231-1-jonas@kwiboo.se>
 <496013c1-7a57-4d12-bf31-c5257f35ee8c@theobroma-systems.com>
 <3b2643b4-dea7-43cd-9f9c-da63e6588281@kwiboo.se>
 <ac394528-ca53-41d5-8c4c-7c10943a7c92@theobroma-systems.com>
 <e73b2576-4a0c-4965-a1f8-debe6b364af3@kwiboo.se>
 <1cb93207c400d43518e95c713115723d@manjaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <1cb93207c400d43518e95c713115723d@manjaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA2P291CA0020.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::9) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|PAXPR04MB8093:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: srW3kfBRbFY26XuH/uHjGtlCIAe90k65MepbN5MkUNQZC/mlAsr7wIaZ9Tg/irnvFyBbuRZGbBxsT1KM8jbKoEMvPa2HbeHu/YziOL22eTt7AFq/Gk2DPm4B1ku2N1gVeJ3Yr3hP8Wqpbho20qJYrDM706aNHzSgBZY9PATdOvIYZMEur5cMRkw02YIFD7BVA/jGDDdA/CP71E+yW10Q+BwmHw2mUjF7YRUDjIgV3Q+UnM90fydnb4Al2ZZ2HOcM4Laq5bNP+HBsjogpAm07u33mY7tEJjsXkKAlqsGzaFm5m7S0CFKyX5PASugvJYYkYPc7fcFqwdbfCGOYtg2jnFKAIg1stOtaGrkgsueFyeBXOoUn1af/ZCO6FYenTyPpfhFxBACLB5KHrY1k8q9MImmORk+TV7Q1T94akGCw0trV5Fs6j6S2gB07QyBQ3P/p37S9f2WwDAQbAPmv+3UtlvYzCpYm6ihIcxsDNDNP8ZFWAMI65Lag1BCcK1ALq2nWUJQRa+2uySmd8utl5nuAnZ9iHKgMruZB6Fh0QTqsocU/+qS2qu8rFQ1dsrqUyNOEBLX9vbLE6doQaJi5cquUy12xH+2hWVZyYnNs34IPLLwmZXOS+TaE/i4Ye/I1jayl924qmMlHAtwQbd00xdKKtdTVxV/1evMmWNANhI6Hum4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3d4L3pJd1Z2djBSNTl2bHQyM2NUY1BYVFNROVBuQlBHK1E5TGp4UzZOb2F0?=
 =?utf-8?B?SlRWeHIxRng3bFpQdUVOM3dmV05pWkV6TG9pdHlucUx6bTZOcnNoMU5mV1F0?=
 =?utf-8?B?RkVTSHA0eGhPRVZacStXSjFnb01SSGtCdEg0VzZ2cEIvZStLMmhHU0dMMlhN?=
 =?utf-8?B?R1FrWTYwYnNwQU5vVTlCWGpQY0szQ0RSQlo2S1kxc1ppZzhOeHBjZFhJRkRC?=
 =?utf-8?B?QTdFZ1ZvVWFkb21pWC85MDBvaGlCb2Q2Mm5ZY205ODZ3d1hBTEJ3TDgwMXRy?=
 =?utf-8?B?ejkzZFRITXRNL0Y0RFY5U09TbkdzTFA5dDNKdkhVeE5XSmJZUHJyOS9PQzA3?=
 =?utf-8?B?VkZKbzZKOHZGNVpMV29SZlNqRk55dFo4bE5sa0dkTTRmVXNPNGRaNTUrZlNG?=
 =?utf-8?B?UWFyT1kyVUFobDRObUVhQTlQekFmS3RxQUMwVUFoZGRoZktMdjczNnB5WkdS?=
 =?utf-8?B?VlZJTGFDTkdDdUpTdHZiK3JhdWV6SGpDRlNLS0NlQURIMjFZRFpNVE9IYU1B?=
 =?utf-8?B?czJxSFMxKzJmQmhQbTJ5MkR1bUl4K1BIZkJESXRuS2JTTFZteXlHUC9wUkxU?=
 =?utf-8?B?YVdQdzdRczcyL2RMaGdweUU0WTZNa2NNUXJvemhLeW9YbGFkSDZ3Rzk2SFVa?=
 =?utf-8?B?YzUwZ2p6eFF5TFBwVHJIYlRSZlNhVUlrTnJoM1pEcHlReDRqM3FiQ0lzZWZM?=
 =?utf-8?B?SCtZZUoyR3lZd3dRVTZOanFKdWtqOWw4U21OcFdLenMxTlRxZ3NJNDU1Q2ZY?=
 =?utf-8?B?ckt0cE5ER09YcGxaZFZkRTcvcEEzSGQwUUl6d1NucFRTWnh1NEc4VWVIcStx?=
 =?utf-8?B?Z256dXhZSjllYnVEbFdvUGgrR3BOZkdMT0kvVlJveFNFSTk3b0dKMlNKMmgx?=
 =?utf-8?B?eFlQM05ZZHFKelIxNzNSb2F4R29YMjk4bHVoR01GQ1dWd2duaHRrUkRiQytM?=
 =?utf-8?B?bmVLck4rRGRXeTBUajRIeDFxMG10TEZsL1VYdjlPcWNmSG81OHZ3bGFIdUVT?=
 =?utf-8?B?MDRIOHVXaDAvMFZHbHdHVEN6UEVGc1lBYlU1OWJzZWt5aEhITjU2eEVqWjMw?=
 =?utf-8?B?dmtFUm1wVkYvcEYwcHFudEtzMkJKd1JqZzhVZEVrbFRPOHF1L3pSYnNSVzlR?=
 =?utf-8?B?bmZ2QUtEY0diZUhibHd6UWdudFR4SzRVNXRlZ3NyOThGUCs3RitMSXozek9L?=
 =?utf-8?B?Q2pSSjlVZU5oMS9QNDNZRDdVZWxzSlA5TTdrQzB0YW1ZQmVwUjdCcjFXWHR1?=
 =?utf-8?B?RWloVzB6NElrZGFtZ3g2NjhpMTRSTDRSNFpaNFNMRVhiNmtrcW1xSElmRzF2?=
 =?utf-8?B?T0QySWNUemgxTjVuK3FMVm9USTYydjN6Ynl2eVR1Y3Z5ZXpWUFpPbnY1SVFT?=
 =?utf-8?B?Q21BaWtJUEpXdU1IMy9yYkRoYmM3U2d0emRlOXhSTFN2ZXU2NW4zQU5NTzJ6?=
 =?utf-8?B?TUxDVWo4b3QwLzk2bmpPNWtTT0h6SlFNRkMwT0xZRm13K0owcVhIYXoxRGRM?=
 =?utf-8?B?MzE1VVkwdStMRDlPeDNPMGhYSEhyVUNpZ0ZGejdZU2QxWEZDYW5FbnBMOVhY?=
 =?utf-8?B?L1VhUy9IM1dBZ0ZNOGNoVEJRZkNZc1lSaTByTlExNk1MY2NnSkhGSEFYMjdz?=
 =?utf-8?B?VGpzUnlUSGpZcmJKL3h2ZE5DN3hmRU5tT2tqM0hZNEJrVlFqeFgrOVlld1l5?=
 =?utf-8?B?cWYydVREK00zSFozRUNVZ2lBYlVadmJMN1h5akdzTE5IdWdlbDdnZEVxajFD?=
 =?utf-8?B?K0swdjdhc1M1bVhibzI0c0o5Z1dXNlpPZFo4U0NBb1VEc2pidlhFdWlGMWo4?=
 =?utf-8?B?NWVTS2xkbXNVMXBsdzdmYUtEeS9NTmpVZEZaZmI3Y29JNTFZblpxYzFtWE9j?=
 =?utf-8?B?elpXNWJXdWVzdmJOTlZTSUs4eHM1TUpNNStnVm1hZytnMzZ1ZXdaZXFLcmtI?=
 =?utf-8?B?WUowZkpsKzRPQkozR2pjSDBBbVp2RnJxM09JeDY5dmtmSFZTY0h1TXpCSUZy?=
 =?utf-8?B?bUtvc25kcXBaaXJMTXhzVy9RNzdKeVZ5V2I0UW5RdVM0b1YrcG1RalZCbDQ1?=
 =?utf-8?B?THJDLzVreE9lS0l2ODdFR0FUdWk1KzE2blB5ZWV4dDQyWVBaWDZheVVpOUtw?=
 =?utf-8?B?aG9HZWNvNVIyOWFMRDIyTDZMZEVwYUFUNWxrUktvbU9veDRxQWQ4R3FzWWF1?=
 =?utf-8?B?UzFKY1hUemhIVFZ5Q0JVeXRBN2tDOFZ6M01KaWp2a1dnL2FnQXJsRnNHcTM4?=
 =?utf-8?B?WTV6a1pNTkdKd1J2d0paSS9FZEV3PT0=?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e9562c9-ec0b-4162-3cc6-08dc593aeccc
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 08:47:59.6770 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: scyp9kiLABRlRJGKNHvUaF4ijUVlopNQZjsTHR/yJS6hm51vDuhsugojLWdt1OLUXPTjOdSj6mboV2lWVWHSp8jO9U0227qrSY+xLdJP8tt7ZpUfhDjNnwQmd16fLNrD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8093
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

Hi Dragan,

On 4/9/24 21:30, Dragan Simic wrote:
> Hello Jonas,
> 
> On 2024-04-09 18:30, Jonas Karlman wrote:
>> On 2024-04-09 18:02, Quentin Schulz wrote:
>>> On 4/9/24 17:58, Jonas Karlman wrote:
>>>> On 2024-04-09 17:27, Quentin Schulz wrote:
>>>>> On 4/8/24 23:06, Jonas Karlman wrote:
>>>>>> eMMC nodes in linux device tree files typically only contain a 
>>>>>> mmc-hs400
>>>>>> prop to signal support for both HS400 and HS200. However, U-Boot 
>>>>>> require
>>>>>> an explicit mmc-hs200 prop to signal support for the HS200 mode.
>>>>>>   > Fix this by follow linux and imply HS200 cap when HS400 cap is 
>>>>>> signaled
>>>>>> using a mmc-hs400 prop.
>>>>>
>>>>> Technically speaking, the DT binding should be the one and only source
>>>>> of truth and should be implementation-agnostic.
>>>>>
>>>>> There it says:
>>>>> """
>>>>>     mmc-hs400-1_2v:
>>>>>       $ref: /schemas/types.yaml#/definitions/flag
>>>>>       description:
>>>>>         eMMC HS400 mode (1.2V I/O) is supported.
>>>>>
>>>>>     mmc-hs400-1_8v:
>>>>>       $ref: /schemas/types.yaml#/definitions/flag
>>>>>       description:
>>>>>         eMMC HS400 mode (1.8V I/O) is supported.
>>>>> """
>>>>>
>>>>> So I'd say, the DTs should be fixed to add mmc-hs200 as well 
>>>>> wherever it
>>>>> makes sense.
>>>>>
>>>>> The point of the DT/DT binding is to be system-agnostic and
>>>>> representative of the **HW** implementation. At least that's what 
>>>>> the DT
>>>>> people want it to be.
>>>>>
>>>>> If the eMMC standard doesn't allow to have HS400 without HS200, then I
>>>>> think this change is acceptable as is, because it is the reality of 
>>>>> the
>>>>> HW standard. Couldn't find this implied in the standard though (but I
>>>>> just skimmed through).
>>>>>
>>>>> It's also quite surprising, as it's not because the eMMC works with
>>>>> HS400 that it necessarily does with HS200 or that it's desired (EMI,
>>>>> signal integrity/stability, etc...)?
>>>>>
>>>>> Now, it wouldn't be the first time U-Boot follows whatever is done in
>>>>> Linux, so... up to you/the maintainers :)
>>>>
>>>> Agree that implying HS200 does not fully make sense, however it was 
>>>> part
>>>> of the original Linux binding when HS400 was added in v3.16-rc1 [1] 
>>>> so I
>>>> think that this is the expected behavior and changing it may be an ABI
>>>> breakage.
>>>
>>> I'm not advocating undoing the kernel "hack", but rather make it so that
>>> we add hs200 to DTs where it's actually supported instead of doing the
>>> same hack the kernel does. In that case, we wouldn't need the hack 
>>> anymore.
>>
>> I will add a patch that adds the missing mmc-hs200 props to affected
>> rk3588 boards, nanopc-t4 and quartzpro64 in v2 of the "rockchip: rk35xx:
>> Miscellaneous fixes and updates" series.
>>
>> Also turns out the issue with those boards was because of my other "mmc:
>> rockchip_sdhci: Revert 4 blocks PIO mode read limit for RK35xx" patch,
>> so will need to rework that revert some more before posting a v2 of that
>> patch.
>>
>> For this patch it is fully up to the maintainers if U-Boot wants to
>> mimic Linux kernel or not.
> 
> I think that the logic used in the Linux kernel should be followed,
> because one of the goals should be to add as few "touches" to the
> upstream DT files in U-Boot as possible.
> 

I was suggesting to fix the upstream DT files as well.

Cheers,
Quentin
