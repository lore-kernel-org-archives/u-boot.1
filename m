Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E50CD1284
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 13:34:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7ABA58808D;
	Tue,  2 Apr 2024 15:34:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="TKnxcmDg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 882068815E; Tue,  2 Apr 2024 15:34:10 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0B2188149
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 15:34:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HLPhjJ7yPQ7bdbG0AvttNV2Dhv80mz/xZTpWQWpwB2twllzQjBRKxtg5Dlt7ZrjDzn3p8nGNZAKTEOT5BkjUB+MpuA0EDZFrtgc5ALArwiBCcCte6o6bExWjyx2LYsfb4goExF+DRXPxsfuAekLSOToOonH8aNkUxdXmBWiHsnbZQqJ2BNWhiyXJv3qYfDssLclBkRn7A8RFdh6vHW2XFS7oxaMSAC7Z50OCmf8SyAD4PNjCofYsR2BK7el42pzwGCGs14cxv12Cyq4Psx29nODVCF8GaOlSY4t2SMIliISt51I1XL7uvs6UiegClR1Nj5jSGgl6RLEODDYD+aZtkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=haia4p6sX4OFqxEuBp359gKadqaIQbOADfvyuB7rKZ0=;
 b=i7ROpcHC0X5+chGVjGFlExrkS8gHhvIDJg1IjCBYv2wOdO7v5xLrQ5X4CFnuMpwOtXBq/EA4GWa3tFxNJjspHM/W2ioOT6yeIuCQBdsJENWrx22C9TO+z6TWWuPY9aL2xdH/aNAcbYMGieQ9qurQWUMTjmui7hd4Pjs4PifuGliOXc3jv8+YiitS38UH/AdSLv3n6qoZlA8er3zJzzQ4WeJZUr2+U1dhH32mmRIMhaBGvJmXqMKik0ouUfoeQ2A5Xc3JhfPgN/42DsNnT3mV6aXwc5NNot1n+eYBNq6ugiaLUm7pn2gykfci3AiUdmZLkYkGp7OgrSaMmXEcWMJm1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=haia4p6sX4OFqxEuBp359gKadqaIQbOADfvyuB7rKZ0=;
 b=TKnxcmDgjYSnpT4yuKKBSDww7nNQTPWuQ3JW9XIfjuQ292JG09hZcge1AXheTFZLHNV5WSbEF7AO+ErQ4VbPoeurGQOoHhOA25WfSQu8ofFvjd+4jxI7NfNJZXz6Bv7N8jGTMoX3xUSVtYwfjajVWL4EKmSz0JIsqmnANnaHJ+7yK5mENmXPsvqfohclp1MFVulzmipNbZ2vKVCznzPeWWvSlk8xm5OB1BzMzjsvr4WnsbBIS5EgSiDLrR0ygiM8p8XO+VF/f5TYeFH8R77Nl6BIS85+4cuN9iipl98ZHKb4TWHBSvYvKwoxgSFQfWH9BCdnqRoSgYYlsV6a4pnA5g==
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by AM8PR04MB7348.eurprd04.prod.outlook.com (2603:10a6:20b:1db::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.32; Tue, 2 Apr
 2024 13:34:05 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::3e70:7029:faf2:7779]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::3e70:7029:faf2:7779%3]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 13:34:05 +0000
Message-ID: <f8650292-d808-4fcf-a794-3236cf117a37@theobroma-systems.com>
Date: Tue, 2 Apr 2024 15:34:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/19] rockchip: rk356x-generic: Add support for SPI flash
 and USB OTG
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20240329190224.3613471-1-jonas@kwiboo.se>
 <20240329190224.3613471-19-jonas@kwiboo.se>
 <d10bd351-5005-427f-bc41-ebe547e5bda6@theobroma-systems.com>
 <021954a9-0047-4c7c-8cbc-734dd85014bd@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <021954a9-0047-4c7c-8cbc-734dd85014bd@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: WA1P291CA0019.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::23) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|AM8PR04MB7348:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o/Oefc5OfDlm8bCxecJBBqlP53GajgYeV0gS/EG2zKYbNBAzjcmO5rw2Y82f6pGFz3y18/jWUSf0PxBZ76clda4gtVWhP66vlJm64r40IUfFrcisClwqFUAv4n4apv9HB3o4W3Zeb0zQRhsww/jb3NkDegBU7nbDekuXkssOTLIDUUfIGih/e1JjykZbqSJI9SLWFnNQ1do4RE9qpPaeatX6lIkjWl0IY6X0Cr3S8wrPK7aCDrikDXTFMcw4fBqBkk+UM3hz0x3j82nvlUblZ3Hy+7eKQzlGaU+HTBHRgwNChCO0gH8j7DnaPmnyngFwGmfhvXQXxBiOvNKnXHDkfVYuzwBAljdgtXlJrjNb2g0j52K0/d8esZhbTSjS5IXK6heKA47bR4LTRlHn8N4w3JdcZYJgxm8YjDk9SmR3OGsU65B5yexaw/vCo6QB1J4IniR8oFnI/wIjw1gU1EFfmQxWJJ4L25tiCA3bRoRRyLaot50ePve4ldKyCipi3PtzylyoQEC4xI7B91uQ0Vc/6IGoqDs++4MGlG9uHhAq91ZyJdq2vbgZU0kn6eRYyz7WCTbg/eBudiwQCTk1pk5lWk6bx7sJJWh8iH11ifH8NWE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmhDQkgwSjFKVGdNUFdjelNDeHFwNHlxR3J3YlNoVFMxVWZTTFRyWFRYWnMw?=
 =?utf-8?B?MHd5NU5mdDZEanJMUXB0bkFzYUNqOGV4OEgzS2d3MjRQSi9HdDBRbW9mbDhn?=
 =?utf-8?B?QzBXY3ZpYmxxR3FtSmRoa3Q0a0pMRldXS3BQc2JPMDBKb2NxQXFBcGM1RFNU?=
 =?utf-8?B?M0xBZ0FUT3ZLUGg4dU9sYlhhT1g4NXdaQmNsZnY2S0ZBamVSakhNcmU2SXBR?=
 =?utf-8?B?TFEwd0N1Nm03LzRMa2tUYTI0SDl1ZitQYVl4Qk0xbjBqNUlQTksyNXA5bEdO?=
 =?utf-8?B?NDk2b0M5Yjc5TmtXWFMrMy9iLzRKdFdqbm9XRXRHcVFjZmQ4UnhXa2s2amo5?=
 =?utf-8?B?V1JTenYrZXlWQ0UyRXRrRW1jc25RTGMwREdPeU5ZbllpVWNWR3NJUGpGaXhR?=
 =?utf-8?B?VFVSVnpFWjZjTlE1NGduak4vckEyWnhzUmxoc3MvOWIyT010eWZRUys3V0FT?=
 =?utf-8?B?cE8zQ2lMS0FKaU1va0MrQkxtVWFRanZ1b0VsZVBqU3I0bittSUJYcTVJczZy?=
 =?utf-8?B?cVl0TU1nZGkzdWgxVXlPUUdmMDNYSjI5akdEN3EyZUpSZkE1VU9sVmgvdW1N?=
 =?utf-8?B?b2NmQjZIbXVYcmFDWmJhWStQQ2UxUmpJUmQwM25EYUczVjFlYW5GT1EvMk9Y?=
 =?utf-8?B?aGRPdXExSjdSZjF4blV6NC92cUtmU2hSazRPRVI4QUp3TFVDNHQ5K2JpczBm?=
 =?utf-8?B?RHNWUW9ia0Fzd0dMTThOK1BLbU4wcmtWNDZud1kzNG1qdHdmUW84dmw0L3dv?=
 =?utf-8?B?SUllU0N4M1lJVXpmaitBN0NjVDExQ25Kd2FqbjJmeGI2N2pabnZwZFhDaXNw?=
 =?utf-8?B?a0NHSlZ1UGxZUDFmZUtZRlZtT25Ka1E2Q1JsRHExR2ZlUVFyTTUzdWlPOTlz?=
 =?utf-8?B?OVkrRFVrZkFBZnVlRmk2bHE5UTYwQlNXMW1WYzZhNnZVNm9IS2M0OSs4UHdH?=
 =?utf-8?B?V2JSZnlLSEd4Y2Q4aFNjR3RPVFIzYjl3SXhqdTRaRWU3V1hYaVVySDNFVlVi?=
 =?utf-8?B?d2oySzFnUmE5enZ5MGtSVjZtNkYwT0h6SThLTzk3MGw1NHlGakQ3bjB5aTNT?=
 =?utf-8?B?ekE1NWkyK3NLalh1L3JLVXcvT1FibjBmT3ozbDVUMjRSVUxscDFoY1pCN3BV?=
 =?utf-8?B?N1RnTksxRHRMa3R1WFBoR05SZXZhdU9OclBmQStlclRLbFBqVlcxZGpqVDZx?=
 =?utf-8?B?V2EydkhnaDRUU2IvMUNraVk5bURRUWRyZW45K0R6UGJ1bGNDcTd2WUJGclBG?=
 =?utf-8?B?d1dUNmwvOFR6bldzeHhReTlyYTI4a2FYNXlRN2pZeURGY2JLeXAwM0RRS1Bi?=
 =?utf-8?B?b28yYy9mY1p4K3hleGNBVXdZeDZsaDh0QXp5QjZQY1R0USs2OG5FU2hraWtx?=
 =?utf-8?B?MmtNenQ4M3NXSzZZU0g0eFEwSzIyVlc4SE5vU09qY3dZYk1NUDRINHU5YzNY?=
 =?utf-8?B?V2hZV0M0K3dBOVNSUjRyRHcrRSsrYWovcTllaG1pUG1NalBkNFNVbndwRFgx?=
 =?utf-8?B?TWlsWEh1c2VrTFpKQW1BKzByMWFpSHlxVzJOYkhobjFqZUZwNkhFeHdQeFZO?=
 =?utf-8?B?dEpWWlBLMWY3cFoxeVpRNDREUDdBRUJmM1RvUDFUQ3djNUNyc0pPRTk1TUU3?=
 =?utf-8?B?WUU1SGtHQ3cySDdUMndDMWJMSmJBWmxrNDhuMjgvbW9wQXNYWmVQNGdOWDVV?=
 =?utf-8?B?WWdDbG5uQTVzTElHdFFSbjFDbWVwUG5OdTZpUm5pYlp5NnVoOHplVmVTV1c5?=
 =?utf-8?B?L3BCb0U2aGdXc3Bwbkt5eURCbG52bmpvamsvbVZZYnNtb0ZDSXNobkhvQ2NP?=
 =?utf-8?B?MzYyM1AyUHdiMGl6L2hnN2NOWWQvUTZZeE1UVjMwcitkV2k2ZGNORXFTV243?=
 =?utf-8?B?Nk5aSDlqNmFoeWM1QVZlbHk5V3VycXZwODlOYmp2aG1DMk9WaEhwVE84K3dO?=
 =?utf-8?B?ejMwTVpmZFZEeDZIa3hOUE5tUlMvdkZHUXY1ckRtRDhMc0oybm9hZ2R5aXIy?=
 =?utf-8?B?K2VRZG1wQWNzZU5INzlNUmxvditNNnhjOEZUWHVCd0prT1FVZnMrelp2dTlJ?=
 =?utf-8?B?UGlZQkhPNUJXUmFLaEtSQm5DVk9WTDdWMEJPSmozRFpaM2NQME9Sckd6OTR5?=
 =?utf-8?B?UEJCdlZDU1NrazhvaHRYL2VLWVZFQmRHZlcwT201UVhwU2tURGlNc0I5MXV0?=
 =?utf-8?Q?bmmignC0tFXOw3nAsHDD3L8=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f96e5955-0e62-430b-e411-08dc531990d9
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 13:34:05.0340 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /9y8+4QhpibRfWDVRxosF6BUIe9IwWcZPXpDguqItzib5MOKnJrAfDIGNj2rqJr7TzN0LSQM5PpYnFFWIIpztom7Y4vIrl2SB2q4a8qH7urZ/f781ZUfzBRoasuwCTfZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7348
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

On 4/2/24 14:37, Jonas Karlman wrote:
> Hi Quentin,
> 
> On 2024-04-02 12:38, Quentin Schulz wrote:
>> Hi Jonas,
>>
>> On 3/29/24 20:01, Jonas Karlman wrote:
>>> Extend the Generic RK3566/RK3568 target to also include support for SPI
>>> flash, USB OTG, RockUSB and UMS.
>>>
>>> Also fix sdmmc alias, include missing pinctrl and add broken-cd prop to
>>> fix use of SD-card in linux.
>>>
>>
>> I think we would have benefit with more and smaller commits there, but
>> since you're the one mainly maintaining those generic devices, up to you.
> 
> I can try to split it in a v2.
> 
>>
>> [...]
>>
>>>    &sdmmc0 {
>>> +	broken-cd;
>>>    	bus-width = <4>;
>>>    	cap-sd-highspeed;
>>>    	disable-wp;
>>>    	no-mmc;
>>>    	no-sdio;
>>>    	pinctrl-names = "default";
>>> -	pinctrl-0 = <&sdmmc0_bus4 &sdmmc0_clk &sdmmc0_cmd>;
>>> +	pinctrl-0 = <&sdmmc0_bus4 &sdmmc0_clk &sdmmc0_cmd &sdmmc0_det>;
>>
>> This is... surprising.
>>
>> `broken-cd` but we still mux the SDMMC_DET pin in the SD card detect
>> function?
>>
>> According to the dt binding, if broken-cd is provided, we should do
>> polling. If neither cd-gpios nor broken-cd is passed, host native card
>> detect will be used (which I assume means the SD card controller handles
>> this internally).
>>
>> c.f.
>> https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bindings/mmc/mmc-controller.yaml#L33
>>
>> What are we supposed to do there actually, because this seems to be
>> contradicting itself?
> 
> The generic DTs is intended to be able to be use as control FDT in
> U-Boot with any board that mostly follows reference hw dedign as close
> as possible.
> 
> broken-cd was added to fool U-Boot (and possible Linux) into thinking a
> card is present. And the sdmmc0_det pinctrl was added to satisfy the
> controller logic and auto jtag.
> 

You shouldn't need to fool auto jtag anymore on RK3588 since 
https://source.denx.de/u-boot/u-boot/-/commit/5d710738bb1e0ff2bb93ce7baf4c9691ce919b53 
since it would be disabled except if you enable it by hand via the symbol.

I assume you need a similar patch for RK3568.

Linux disables auto jtag automatically for RK3588 since 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/soc/rockchip/grf.c?id=6f6878ec6faf16a5f36761c93da6ea9cf09adb33. 
I guess you need a similar patch for RK3568?

> When I tried to boot into linux with the control FDT prior to this, only
> eMMC was detected and working, after these changes SD-card was working.
> 
> Will re-try without broken-cd for v2.
> 

I think it'd make sense to properly patch this by disabling autojtag 
feature instead :)

>>
>>>    	status = "okay";
>>>    };
>>>    
>>> +&sfc {
>>> +	#address-cells = <1>;
>>> +	#size-cells = <0>;
>>> +	status = "okay";
>>> +
>>> +	flash@0 {
>>> +		compatible = "jedec,spi-nor";
>>> +		reg = <0>;
>>> +		spi-max-frequency = <24000000>;
>>
>> Random thought, but shouldn't we update common/spl/spl_spi.c to read
>> this value instead of using CONFIG_SF_DEFAULT_SPEED? (Nothing to do in
>> this patch series though :) ).
> 
> For U-Boot proper the value from this prop is used, SF_DEFAULT_SPEED is
> only used in SPL.
> 

Yup, but I assume we have DM support for SPI flashes in SPL, so we could 
do this instead of having to rely on a defconfig symbol :)

>>
>> [...]
>>
>>> diff --git a/configs/generic-rk3568_defconfig b/configs/generic-rk3568_defconfig
>>> index e7d5e55bbfd8..b458080cd539 100644
>>> --- a/configs/generic-rk3568_defconfig
>>> +++ b/configs/generic-rk3568_defconfig
>>> @@ -3,17 +3,22 @@ CONFIG_SKIP_LOWLEVEL_INIT=y
>>>    CONFIG_COUNTER_FREQUENCY=24000000
>>>    CONFIG_ARCH_ROCKCHIP=y
>>>    CONFIG_NR_DRAM_BANKS=2
>>> +CONFIG_SF_DEFAULT_SPEED=24000000
>>>    CONFIG_DEFAULT_DEVICE_TREE="rk3568-generic"
>>>    CONFIG_ROCKCHIP_RK3568=y
>>> +CONFIG_ROCKCHIP_SPI_IMAGE=y
>>>    CONFIG_SPL_SERIAL=y
>>>    CONFIG_DEBUG_UART_BASE=0xFE660000
>>>    CONFIG_DEBUG_UART_CLOCK=24000000
>>> +CONFIG_SPL_SPI_FLASH_SUPPORT=y
>>> +CONFIG_SPL_SPI=y
>>>    CONFIG_SYS_LOAD_ADDR=0xc00800
>>>    CONFIG_DEBUG_UART=y
>>>    CONFIG_FIT=y
>>>    CONFIG_FIT_VERBOSE=y
>>>    CONFIG_SPL_FIT_SIGNATURE=y
>>>    CONFIG_SPL_LOAD_FIT=y
>>> +# CONFIG_BOOTMETH_VBE is not set
>>>    CONFIG_LEGACY_IMAGE_FORMAT=y
>>>    CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-generic.dtb"
>>>    # CONFIG_DISPLAY_CPUINFO is not set
>>> @@ -21,32 +26,58 @@ CONFIG_DISPLAY_BOARDINFO_LATE=y
>>>    CONFIG_SPL_MAX_SIZE=0x40000
>>>    CONFIG_SPL_PAD_TO=0x7f8000
>>>    # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
>>> +CONFIG_SPL_SPI_LOAD=y
>>> +CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
>>>    CONFIG_SPL_ATF=y
>>>    CONFIG_CMD_GPIO=y
>>>    CONFIG_CMD_GPT=y
>>>    CONFIG_CMD_MMC=y
>>> +CONFIG_CMD_ROCKUSB=y
>>> +CONFIG_CMD_USB_MASS_STORAGE=y
>>>    # CONFIG_CMD_SETEXPR is not set
>>>    # CONFIG_SPL_DOS_PARTITION is not set
>>>    CONFIG_SPL_OF_CONTROL=y
>>>    CONFIG_OF_LIVE=y
>>>    CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
>>> +CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>>> +# CONFIG_NET is not set
>>
>> This seems surprising, do you really want to get rid of network support
>> for the generic board defconfig?
> 
> My intention with the generic targets is that they only contain bare
> minimum to boot from emmc/sd-card/spi flash. And a future possible use
> could be to replace vendor usbplug blob and/or for other flashing or
> recovery purposes. So network support should not be needed, also saves
> a little on binary size and boot speed.
> 

netboot/pxe/tftp is nice for debugging, but I understand :)

Cheers,
Quentin
