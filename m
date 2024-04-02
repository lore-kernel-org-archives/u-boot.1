Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7F41C6FD1F
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 13:54:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E6C78836F;
	Tue,  2 Apr 2024 15:54:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="HOkRPzjp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C5C988374; Tue,  2 Apr 2024 15:54:30 +0200 (CEST)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on072e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe02::72e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32E048812F
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 15:54:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hrqU1bficX5CgZM1y/3ET49YotvoJRNtXe5nfZ2RZFKMjnaYBHfGhqcFXuYYC7yr7QTAaLgbBcNJo4KB3E/NmNq7LD79/XyjVxCxEaW4gPhiCxDMut511ocivqlLR+DCqaq8ONABMak9X3Cc6UiugzkLDvkmzW3ShHsnmHiJY6LIA7bDxrU+6vmt7kI8b9oa6Y8WjRGHgH38LnWvCPYiE6T9tU9GhRjlBxAZGnA04kvYFJjotQCIcLtI0++QfI2KcoTcAzJiTMs0f09pYqIg3MqOUa1tyZRHy+98AsscvEo6F12KWlWHhdzCPbyA37ycrwFjn1A9Wz9mhpNbNQqdLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fl54eR5OijAv/QKUn1sMD/xjCWvoTEtL0jVeDqbWg+A=;
 b=ntenz8XETWTdlbHMZoHBJ4jgdTJ71bp7UBkMGmpfhXiD33KMN2PA+dfh7Nr4+xATdrxrYc2F1dNd2c3A1CqP8IvQK+jPfYi355WtyVGSl8P22ztS3302dV9le4Z12YHWwKNMfmQnV+iHgBPgbScTpWgx4Vzw1YeFnYmhD4GMeDOj+3+i5YFBfMy6K6I0JYS2y74ApYRk7r8yTxCMoxL0TEZpC3jFC9p2C7Wou6BURcgG6c0wIvyiutI4wX2wnBRf8Ml4htPpC0GmSMJkMaWwqgF7hsE2r7Fxy9SbNDZ2Gu7mSMxMCqBCHJ1CC7RdIptwMjsFswsdvdrNj7jvPQY8Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fl54eR5OijAv/QKUn1sMD/xjCWvoTEtL0jVeDqbWg+A=;
 b=HOkRPzjpaaWnILEu/fvDA+EmkO2Qwf7UGAZ9W/F1/xQNeXolbyw8pBI7+dH0C7g60DqZ6LAwhUi3p3Ou3BD+FOJiFDBwWQ+9UZeEtAWUMgeCdn5I2kl3oE//cTQPCl6d1lnBt/XDbuTDpy3nf9FIQig1G1Xf7SoOt4xLlqp2zeGzmhF/Vt+Jmk0cpE2QF3YKYPXlb2Zi2/KQCqjzqJjOyQl0bQUaH2ZeCItf0zW/oozkJAOHNQJNu5Os/8YGytp4FevqrUJNw0olaw7FhmwfEn+6siu0Jnk82tbt9FcU2yGVIFGvxr+QU0cRvdKRjRWykJAK/2boQWPYyHI+CQZTVQ==
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by VI1PR04MB6944.eurprd04.prod.outlook.com (2603:10a6:803:133::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 13:54:23 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::3e70:7029:faf2:7779]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::3e70:7029:faf2:7779%3]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 13:54:23 +0000
Message-ID: <6d2cba03-e381-4a7a-b5ed-a86df2e475db@theobroma-systems.com>
Date: Tue, 2 Apr 2024 15:54:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/19] rockchip: rk3588: Update bootph props
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Andy Yan <andyshrk@163.com>, John Clark <inindev@gmail.com>,
 Eugen Hristev <eugen.hristev@collabora.com>, Joshua Riek
 <jjriek@verizon.net>, u-boot@lists.denx.de
References: <20240329190224.3613471-1-jonas@kwiboo.se>
 <20240329190224.3613471-13-jonas@kwiboo.se>
 <68bbc86e-f412-4e3d-bc5d-d18027edf63f@theobroma-systems.com>
 <e7bf1fbf-782e-41af-af38-82514bd2af82@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <e7bf1fbf-782e-41af-af38-82514bd2af82@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: WA1P291CA0015.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::13) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|VI1PR04MB6944:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y8qLXFYwtUgX8RLB7dB0FwSi5A2zjZZyofiPCR33QmFV6HjDW0mTjzR2hH0a5+F80ERTJXmBsqjvqE57lv2BZVpZqdjT7/gyx9UmSJYJkbvWiImCk6KtBxCft3ApEXqAObdGrWQvkCEd/RW9WcijlqSDOdGBJZPSDNNadYouLE1TW4CmUsNMPma9mSGks9BLV02/pheIM6r7XvBzQbL1Gg4NVT9Ox5s/74CkDmFryaRJhyb9XJqIe9yrrDodab7lZCjoV/guN/UX6P6Berxmp0o/TdpLW+fMon6veiOmYhQcKZEMwf4RU+vcgENLGZJxDnqpQqGPSptf7fOABsnZ4xd4LtF7h5qechz0MgM/PyndkEukmmI2dd+dxYjeApB3UTGR8i+GnPQw748YMdb6GPboQSy/JygDLtUK3ksmeDftAx46JIIXSUSyEWASBwTb19C5vBWuH5u1jZwbUSJCdg2mktTtEaqWEbh6fdJ77dbDbF7JbFN7Uo9a0FCF2ycdu9MYAX60bCWwwqWW/z2du4qJTAyuX0E2bGRRW5SGDo/498itcyiuu5NNvrJSoJpCJnFZZnEROsJDDoYnIigKi13L6zemGv96u7qLP8CW+rk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(7416005)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0RTalJQNi9sbzZ6RmVVc3dKSFp3VEw5NXNmdUVDN2N0MFZaQWhhWTdwcHA3?=
 =?utf-8?B?R3BIdDVwTjJkdkp3bDFIWVE4V0tvaWpOZTVaY0d5Q2IydjVZR1ViZ1pxTGc1?=
 =?utf-8?B?TVRuRDJkb0Z4cE5ERlJuNzJjNVgwSU42NXdvbG5kbDErRDZmR2EwYjZDa0hB?=
 =?utf-8?B?WVNEa3AveXlWNGYxekFUd0RIU2JJZnhzMDQwUGsxUFIzc0YyZVpWM1ppd0Yv?=
 =?utf-8?B?OE9iWWNETU44dzRxZzBieG5sd3lKRzBHOGtxU1Uvbm9mYVViT1FDVW5RcFlC?=
 =?utf-8?B?ODFRMmpISS9nSStsTHhwMWs0MW01VGllcWNNWkZFRmNkRXhhaW9tSjVVLzdE?=
 =?utf-8?B?WnQxcEFrZUJpRXIrK1Z6dGZoVzN6c0NOb0xYWUlsY09jRHg5N3pRZlp5dkU1?=
 =?utf-8?B?U2lvR3BEMGdnZjVMckduWmFkVTFoeFA4OTZDUXdFV0dDcnRtQjA4VnJBeEVp?=
 =?utf-8?B?OExIdFVSakhmS09XYk4rM0xRUDVKcEpuZ0NjUkxTeVF0cmFQSGxya3lSMlRD?=
 =?utf-8?B?c3Q3d1NlRkw0WWRIVzAxTFd3UmRnajNzZ3V0Uk5QM2RpNlNKb3pVWUN4L3Jx?=
 =?utf-8?B?dlF0emtwUDBqVDVtdUNXeEVLaTM0U0tYUStyRGxJTTBZZGI4TkhSTVRmUWZB?=
 =?utf-8?B?Qkt6NnY0aUlDbGlqUVVvSUJMYTJWMk8vc2NQRzRIZFJFVjhlbHI0clJLL3Zj?=
 =?utf-8?B?VC9FT1RRNi9HTW1CczZOekVzekpwaUlLS0dNb2tRSDNPWkZDNXlBQTdZeHJM?=
 =?utf-8?B?eGV5WGhDcFJQWlQ0T0NjZmpEUmlkdmhTcFV3K0h0dTlQaVJlQndEN2N2RHhD?=
 =?utf-8?B?TW9RRm1YMTFROTJPTzhDcEdBdlN6QmdBOFVBUTJqbmlJbzR1YUttcXg2UHVE?=
 =?utf-8?B?WTFzNityVitQLzlDN0NDSWVBclVkQkhkN21BckpsRGQxSHVZZHcxRXRTKytM?=
 =?utf-8?B?NSs4T0VHRC9tcjlCYlloZlpqSlFVS25CRnRJTTUwdFpBV3lPcnBHaEJzWWJs?=
 =?utf-8?B?aW52ODJzSE1jVDFINFBaYjRNc04xbXpqWVkxUjhIUEJlbmtNS28vRHhDSWVx?=
 =?utf-8?B?VXBxa2hFQ3J2SzBRZTVjd2xQVlNESVc0SXVSNG9IWHQzR0JiZnhYSitLZXlo?=
 =?utf-8?B?VE9QVS9PV3FKWm52a1ZHcHBhbW5kZzlVRHFYcytnM00yaWRuUkVBMmUvNGxl?=
 =?utf-8?B?ZkFGWXQ4RllCSEFkK0g3WldIYisxOFl5WnJjaXJoaSt1T0tPV3BMNTVzQmQ0?=
 =?utf-8?B?dVUxOVpqODZDeTFpeWVzclhON09IN0JlUGIwMXI5cHhsbFRKeDNvWDI3dTZL?=
 =?utf-8?B?Wi96NUx6dFRKSkV2SjFVMXJVSXNvQ2RQbGZOMjVnbHJzSUZZN2VGdlV4bmVp?=
 =?utf-8?B?bGw3N2k3dk5uZDdVR2YxUlpHMXpxY0p0b3liVDlXOVU5aGFwR2hUdGllOFNo?=
 =?utf-8?B?Q0szYWcwZHhxdEJHWWM4Ymg3RW12cnlFbEQ1NnJsM1dWWVpFQ0RzREZqSTha?=
 =?utf-8?B?d2dwOFJIWDVJVzl0cjR1Q3FCL1dNV2pCWVovaVhPU2xEL0NjTFI2S2FlZ0lo?=
 =?utf-8?B?a0VzelUrYkxteFJBelVHbzlKRVQ1QTR5OU96RUNQRkJ1TmxuZ0J2Rlh0Zm9u?=
 =?utf-8?B?RXRMTm9Lbm42RDVMMk9rQzNQZ2FPUDVjd1JLNGx2VlF3STU5K3g1aEI5SU1Y?=
 =?utf-8?B?c0FQcW5lejVRbzZkRlV5Q3FnQjU1eCtQZU1PMlllWDlON21wVFlsYm0rcnhn?=
 =?utf-8?B?VVRCdm5JbTd1WjZVS2JSTnFKWTByNjFkWFBqc05ueHdReXlCQkFzUVlvalpY?=
 =?utf-8?B?ZE05Y2tnM0g4L2kybHAzd0EwM1dkSmNFK28zeDhJZUh4TXdDQTByN2l0MXF6?=
 =?utf-8?B?QVRSREpqUEFaWW9MRlRlbkFwTnlMYWZYU3gxK1ZtZ0ozMjJoSENvc3RnbmdK?=
 =?utf-8?B?NWp6OXJuOTlsM2paNXVQOXpnM3VZa1pSRDY2Q1cwVnI4L0MzZTJYVXYxNDI3?=
 =?utf-8?B?VlFZU1QwRWlNcDVsc09nemVGR1JRV1hhZTI5a2JCQndXZlBDMEczbkUxSGhq?=
 =?utf-8?B?Y1U0V1lsSFRMOHRPTXRObkR5aGltQVRFclFUV0JzM2NDU2RkdHk1akxJL0Nw?=
 =?utf-8?B?encwejdGd1RQK3M1RTRMdDJZdUsweVI3ZkZ1SkNEeHRybUw5SUJRak1sSUNv?=
 =?utf-8?Q?+6eBjzSSemf277TBxg9Oz8o=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ada3acd-7e3c-4a81-9cc7-08dc531c66ed
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 13:54:23.1953 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T46sO3OFZ+VfbdUMZ1u2HP8xGkooeiCecZl0hoW3OUv23ArVSFYV2G3vseOGNidAzzFQIdxl/uxhgAdxFcSr2b3M+hSlmGG/hgMC3MlGZZDTNcipXPG7jN/U5idBeq3d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6944
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

Hi Jonas,

On 4/2/24 15:36, Jonas Karlman wrote:
> Hi Quentin,
> 
> On 2024-04-02 13:20, Quentin Schulz wrote:
>> Hi Jonas,
>>
>> On 3/29/24 20:01, Jonas Karlman wrote:
>>
>> [...]
>>
>>> diff --git a/arch/arm/dts/rk3588s-u-boot.dtsi b/arch/arm/dts/rk3588s-u-boot.dtsi
>>> index e4171bd24d2a..a502a82fae6a 100644
>>> --- a/arch/arm/dts/rk3588s-u-boot.dtsi
>>> +++ b/arch/arm/dts/rk3588s-u-boot.dtsi
>>> @@ -121,31 +121,35 @@
>>>    };
>>>    
>>>    &cru {
>>> -	bootph-pre-ram;
>>> +	bootph-all;
>>>    };
>>>    
>>>    &emmc_bus8 {
>>> -	bootph-all;
>>> +	bootph-pre-ram;
>>>    };
>>>    
>>>    &emmc_clk {
>>> -	bootph-all;
>>> +	bootph-pre-ram;
>>>    };
>>>    
>>>    &emmc_cmd {
>>> -	bootph-all;
>>> +	bootph-pre-ram;
>>>    };
>>>    
>>>    &emmc_data_strobe {
>>> -	bootph-all;
>>> +	bootph-pre-ram;
>>>    };
>>>    
>>>    &emmc_rstnout {
>>> -	bootph-all;
>>> +	bootph-pre-ram;
>>>    };
>>>    
>>>    &ioc {
>>> -	bootph-pre-ram;
>>> +	bootph-all;
>>> +};
>>> +
>>> +&pcfg_pull_down {
>>> +	bootph-all;
>>>    };
>>>    
>>>    &pcfg_pull_none {
>>> @@ -157,6 +161,10 @@
>>>    };
>>>    
>>>    &pcfg_pull_up_drv_level_2 {
>>> +	bootph-pre-ram;
>>> +};
>>> +
>>> +&php_grf {
>>>    	bootph-all;
>>>    };
>>>    
>>> @@ -189,19 +197,23 @@
>>>    };
>>>    
>>>    &sdmmc_bus4 {
>>> -	bootph-all;
>>> +	bootph-pre-ram;
>>>    };
>>>    
>>>    &sdmmc_clk {
>>> -	bootph-all;
>>> +	bootph-pre-ram;
>>>    };
>>>    
>>>    &sdmmc_cmd {
>>> -	bootph-all;
>>> +	bootph-pre-ram;
>>>    };
>>>    
>>>    &sdmmc_det {
>>> -	bootph-all;
>>> +	bootph-pre-ram;
>>> +};
>>> +
>>
>> Please add bootph-some-ram to all nodes related to eMMC/SD card
>> otherwise I assume some boards won't work anymore (e.g. the ones that
>> need to find MMC devices through DT in arch_env_get_location, e.g.
>> Theobroma's Jaguar (and soon Tiger)).
> 
> Sure I will add them in a v2.
> 
> When I tested your arch_env_get_location() it did not seem to require
> any pinctrl nodes at pre-reloc stage.
> 

Mmmmmm... I assume it is because the device checked in 
arch_env_get_location() in U-Boot proper pre-reloc is necessarily the 
same as the one used to load U-Boot proper from SPL, which means the SPL 
will have set the mux correctly (because of bootph-pre-ram). I don't 
think U-Boot proper pre-reloc has a separate DTB from U-Boot proper, so 
I think it checks only for boopth-some-ram property in the MMC 
controller node, and maybe not for pinctrl nodes?

> Ideally we should be able to skip use of DM, env and serial at pre-reloc
> stage for Rockchip. Serial and pinctrl already gets configured in SPL, and
> use of DM slows down boot by 200-700ms, but that is for another series ;-)
> 

Agreed :)

>>
>> c.f.
>> https://source.denx.de/u-boot/u-boot/-/commit/70f9212d61fe79c605b805c6eb0764b29f8ae3b6
>>
>> It was not easy to have this merged, so I'd prefer to avoid having to go
>> through it again to fix my board(s) :)
>>
>> It'd be nice to split this into multiple commits so we can have some
>> individual justification of why such a change is made, so that we know
>> if we need to revert/update it in the future.
> 
> Will try to split this in v2.
> 
> In summary some pinctrl or nodes referenced was not enabled for SPL
> stage, and some was enabled for TPL that should never be needed in TPL,
> if U-Boot TPL will be used in future.
> 
> TPL: uart node + dmc/ram and any node required/referenced
> SPL: TPL + sdmmc/sdhci/spi-flash nodes and related pinctrl

For the <soc>-u-boot.dtsi, I guess this is good enough, we may need more 
though for some boards (e.g. emmc-reset, gpios, etc...).

> pre-reloc: TPL + sdmmc/sdhci/spi-flash nodes
> 
> I created a python script [1] that can check the built tpl/spl/proper
> dtb for missing nodes and some config options for all soc targets.
> 
> [1] https://gist.github.com/Kwiboo/34c099fb42eb6ae5ed515a04275a7ed7
> 

Ooooooh this seems really neat. I'm always very careful when adding 
support for a new board and I'm always afraid to miss a few nodes, I'll 
try to not forget to have a look at this for adding support for Tiger 
RK3588 :)

Do you have any plan of submitting this on the ML? I think this could be 
beneficial to the project!

Cheers,
Quentin
