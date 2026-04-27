Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5AB8FF8868
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 17:27:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0500683BC4;
	Mon, 27 Apr 2026 19:27:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="gCc+ia/H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A968083C14; Mon, 27 Apr 2026 19:27:17 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6799283AA9
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 19:27:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jg0cF6smCjzWRAh3P8TBBoqoTfMEmBEjlBEB8HXs5dOT0V2FGlrV4j6x0I8rgPb+GVaHJXKT6w3GDbPu/BLcbmzaWJBTprbpGFYasDTwsNx+tD/RmxvJOm9ROWQ6iqlWlkYKVBcOeGypltJHupPTCzr+VoyGRYVnuperSQaN65yUXNb5YOM30BuqV4KTKIAv+sE681zfCcTyFFu9iS2C0sD8sqLcMZZY9CxyZnfOdpcZFJbcrJ5Ai814JT7UTiZkUSj8C26Z0uvpYGJhcUHvIbMVxOkRh7ZIp8MUj+kwKem19pauppwdEDUPuFjmbPnh4UlcZrnufK7hXgpIpJqw4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0+MgbIl/iJWSl6W6opxFX5IecypNSaQE3AhMRd520rc=;
 b=jklfke0dwJ5M/KYraioulFt+hXiEyBPKJgFoGU4mNArYUkYgeUfhdIXfq4meMdn8e1G6m2/G2tOZe3JlO4n7ASOkBvsn0tRIJ07lKc5YsLLwKlLbVEZkn1zTdRyHKBNVamXXj5+IUPjnP7SY77dkZRw/VboD1TXyJjHWF4J3IZcEWL/1iM2I9RHQ3x9VO0KZ9qDTYKnohq6CBWioKUviZYeJoBSvm4POkiM4FPA7J/1KtXwNKxiz6N+OIAH/BkiQf3ww/zUW6iJU+kcdm4DuTwEEJ2abmjrOwN1SlsSQR/RKl96n2t3x+rwHSxi5PAgCb7BNWPE9EZn8NPZrG2+uRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+MgbIl/iJWSl6W6opxFX5IecypNSaQE3AhMRd520rc=;
 b=gCc+ia/HpnRTeKJ3kAXTrf6gZee0igxraY76OQ7IsP4p7LVLhW0k5ga2z5J0yuP4+reJY1n2IDXKCYDdHAVjc8R1xkcpCWiFOmcB2P612IYv0Z2PWD3p/y6szoiUVFfygTFNAGPh7Vnkp0HHqxih3nizBu6Gps1K4Pvtk9CUfUI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by VI1PR04MB7197.eurprd04.prod.outlook.com (2603:10a6:800:129::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 17:27:11 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.20.9846.016; Mon, 27 Apr 2026
 17:27:11 +0000
Message-ID: <8fd75285-39c3-4dfa-a163-41bc6628d995@cherry.de>
Date: Mon, 27 Apr 2026 19:27:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] sunxi: spl: fix SPL_SUNXI_LED active low configuration
To: Andre Przywara <andre.przywara@arm.com>,
 Paul Kocialkowski <paulk@sys-base.io>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, linux-sunxi@lists.linux.dev
References: <20260407223447.4956-1-andre.przywara@arm.com>
 <20260407223447.4956-2-andre.przywara@arm.com> <adfMQBPdntWy1KIq@shepard>
 <cf689aa6-4852-41c1-9c49-3c208e40d76b@cherry.de>
 <33493bbd-2364-4015-a3ab-858992800da9@arm.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <33493bbd-2364-4015-a3ab-858992800da9@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0054.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::18) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|VI1PR04MB7197:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cda1f1f-2fc1-43eb-13bc-08dea482377f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|10070799003|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: BL/tvClv889uEgLB76p5SXxNsCDnOISPaN4Wp40eTmiwKG1dk8pHFC04ZKf7N3PsRru2KWl+8K9H8kJDWwyg6AV1K7P9D1oowIkXtbBGS65I0wig4En3v/9XzLysAcZ3QKab/PJvQ5Aojha024Kv2F0MZv0vDml6K7IJsM+GqObj+9PZJhujcpVczw7h3hVGV2EGVKSOOGYzR2jEA8ZSpfOa6MI3mW2fPzd8B/e2lW/29WaohcJViooDkfIJST+B5bZCuugbcMR6VMKuLjKBIp8vgUsJJoGra29gNcYp5V1dkA2O7S1xLtfJ8zOEeYLYMe/FozcDoKbMCfXfVg/EDzV3naUW7Tn7vb8sgbNs9NcA2ov9gCrMnvgi3GP1hyjZOmFD/Nv/mDYlePWs4fyqTBFMkL7qHtmpHazSdVBkuiAzengwIzeQJPRRXMctP2fIcPaujehjmiIhRbmiQ3Gq06Kn5YyM6k9+ib9zZRwf7tGAyrlUi1U6BwSHhWT09r8S5zuoqlEPGe6trINMsEUM13nLPqZkwgJLW64cpTWgtD3Oq16oVzqLkesOf5MdaaqCH6IIRL963J2fn2QvCzbf5K3EfUk9eAaLvl7r2VV0F7ilmr/olzjP9xA5jTSfT8AQAZKPybbO8xhQbLFDE0lhHTHFuIBFZq5oQi8r9SU4PkHOkf069CFtU8PPlP4lqI+YdPWTchsbekv3qakB/tdHY3gF67l5k/2VIKhjeTYXkzM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7743.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3E2VHZtb0JkZi96NmZqeFBDb0RLTGdTUkd3cXJUM0JHMEVzWk4zNTdmZDdQ?=
 =?utf-8?B?TmxBdVcxQWxTZ1o3TGtoMFNkeTR3OFVNMmZYVm9tTUg1U2FNZ01ZbnVWWE9M?=
 =?utf-8?B?cTlnQ3dZNEh1UDUwamdyZHJRWFpsZ3kxWXUwYTJObllNR29zeUtNcW5rczFM?=
 =?utf-8?B?aWJDWHBrLzhJVmNKR0Z3VHd5Tld2RDh1dDk3Z05EdkpvR2VkSGplUDVjQ1lr?=
 =?utf-8?B?WURreFB3L0V2NzJpeklmQXpOWWVIL3BnNDVxbXFzM3VXeHdUYzUwMnNrYkFw?=
 =?utf-8?B?d25ybmhSTWhybDNRY3ZRYXhZTEVRT1REVlNpL3ZRQy8yQmNyL0JTWjR2dVpC?=
 =?utf-8?B?YlZNVGtaL1k0K1ZBSU83ZVBrZzQzcFdjSTEvK25rcEpIOXBpVk5vcHNQeVJD?=
 =?utf-8?B?Nk4yNWdBNGpMcEtES2JoYk10TXZYb21XNWVZMzhLdFVlclFISnlidE8rb1I5?=
 =?utf-8?B?RFFlVmhuUmtzUVA5TEQ0NmExdXZPOWlyRmE3N1FvLyttNGFWMVYyQXAzSmRV?=
 =?utf-8?B?UUVoSDBHbDR4YlZZWlRIVUdPL3lOTW9GOWxvK2NFVUZtZ3dsckJWNGh6cUEy?=
 =?utf-8?B?ajl1aDFja3RRcXhOdWJmNDUwQnl5VTVSSDRVR0E2NmM1VklmRVhZbjhpTDNL?=
 =?utf-8?B?MjBPc1BsUExzMU1tTTVnVUljYW1iUHZuQnZSYVRZckh0cExEdU9mWjR5QlFZ?=
 =?utf-8?B?WndRUXorcVBDQ2hYWkdqT2Z4c2FSa2hScjZoWEYwRi9Sc2NJNzcxMXFpellQ?=
 =?utf-8?B?U3BJS25mWS8rVUcrKzhsaDJpeHZWc0pRc2o2S2o0ckNQckdnTFR2blB5SmV3?=
 =?utf-8?B?VHRRUWhaYkJRVmZtWi9CZCtXUTNPSEsyTmRvWXVoWEpieWtvVU9SUDV6VFA1?=
 =?utf-8?B?V1BOd2tRa1d4ZVlUdU5Bb1pmYkVtalNFeXRDa3ExMEtPWCtqU0k0a0lqamFo?=
 =?utf-8?B?eUZCM1czV0JZaC9VL1RmcHdlR1NrQVYybjQ1U3VReUNIUVRPWTA4WjhqUzEw?=
 =?utf-8?B?eUhvdGtkb3ZraDQxVEd2ZXJhdGtyNmYyQll0cWJTWkVrcTV0ZURpc1VwUTU2?=
 =?utf-8?B?MURLb0lMdnpBTEJwT1VydEkyYm83aDh4bjVzWWd2VmxvRFJjTk5IL3JkV1Vl?=
 =?utf-8?B?NDd2NlY1VEROdzJNdEoxQVFLUEE0OXV5VmhzZjN5Y1VPWTJkWmFHSDBGc2R3?=
 =?utf-8?B?RjkzS2lRMzdwNlJISkxjQk9YZ01yVy9RYTNNVG5LNWRtcEJhUXJaWHZFbEh0?=
 =?utf-8?B?UkRBRGc5MFdjTS90aEZxbFFkYkZUSjNyTXVQOUFJbVltOXJQRjVwOHA3KzVz?=
 =?utf-8?B?OGJaZElqT25yMzNyRjFOcUhxNnpKMTJNVXpQMGFsRXFTVkpUNzhzR3hUSGRO?=
 =?utf-8?B?UFJKSDNIWTArUStFanFtdnpBSUhXbFVJWTZhYlBqWnY4Q1NzUVZROHJuZ3A5?=
 =?utf-8?B?K3kvTWJRVXk3UFZsRXUzMHhlVEQvdnU3ZWpRTC8wRjlQUXE5dFdsRU5Sdldx?=
 =?utf-8?B?eXMvNUVwWlFxc05SYk9hN0Vuc2JTcjliT2FVZnAwcUpBczJ4Y242S3N2ZmRx?=
 =?utf-8?B?cklrbEo2Tm5NdDJPVVFOY21OZ3hRTGtvY2lhbHZxOExvb0I1VHdpd25EOU9L?=
 =?utf-8?B?SVRTSFhTWTRiRTFRVDVOWHcxR1dDS0dqNWYzRUFQSnhCWnNNTU9pU0hqdlpm?=
 =?utf-8?B?NndFQ2FIMTY2bGZBeGZXMVRVaTJlV3FKS2dPRHppU2tyeGhNUEZ3RnI2MWN6?=
 =?utf-8?B?S0NCZklNVENRNXp3Qzd6YTNtZEljOGo5azJLR3FKNmJEVUNEcHJZZnVWWlZw?=
 =?utf-8?B?cDljMThTVk5hNUZuNndOWXV6bDhTMW83UW9HQmhVUFlESkdseWxuMVRiSVVO?=
 =?utf-8?B?VGhGUVVTM3F1TE9sbkZhaTZLSGFiVkJnYlpTc24yN0hVYldFS0h0Y0p4aXlR?=
 =?utf-8?B?SnFWLzNMZ3QxNTB0M3VMZW5qRVFPdDVoMEVFZlUxTU9GbVUzQ1pud0xaaFd4?=
 =?utf-8?B?OFlybERwWVBIQ1hMU3o4NENPZlFYQ0tpWVYvS3QxTmxFNTBmMDBrRktrNjIv?=
 =?utf-8?B?S2JBam1XS3VrbkplZlhLSXZYU1FkaHVrT284MHFIRTNadE9FTlNwY2FrMTNo?=
 =?utf-8?B?VVZrRGRrV3pRYklXc0wwMHJTUFZ4TjEzVHZPZCtEcTdQOExYaXZ1YVFMclBE?=
 =?utf-8?B?VzdWQTAyVWs1UmswRTBrRUYxWHlNZTdiVFhRbVA2eUpMdXF2bTVFKytuRDFo?=
 =?utf-8?B?bW5wTFAweDJFanhYbktvMlFPcnE0ZFRxTEJtZ2o3Tk9IdFI4SS81S1R2NWdk?=
 =?utf-8?B?cURMb25Vb1BuQ21SL1VmOXppUjVFOElyRyt1ayt5djc5clZlditxOG1oUmgw?=
 =?utf-8?Q?jsH6a/LLRdVRZehf67X1j2KEK7vj45VbYkmq0?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cda1f1f-2fc1-43eb-13bc-08dea482377f
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 17:27:11.8576 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wc87iN6zWDjYp/e1Z0R9A24qzBlRObR3l6UQwD8KX48UrN/7OtkqQLTVxZQpH9FAxK430MOSRkn0hJX3+KmfK9gzGoyhvrHBPi3ckRj7ZgY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7197
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

Hi Andre,

On 4/27/26 3:07 PM, Andre Przywara wrote:
> Hi Quentin, Paul,
> 
> ah, it seems like LEDs are the "embedded bike shed", let me add my shade 
> of blue ;-)
> 
> On 4/21/26 19:12, Quentin Schulz wrote:
>> Hi Paul,
>>
>> On 4/9/26 5:56 PM, Paul Kocialkowski wrote:
>>> Hi,
>>>
>>> On Wed 08 Apr 26, 00:34, Andre Przywara wrote:
>>>> The newly introduced Allwinner SPL LED "framework" defined a
>>>> SPL_SUNXI_LED_STATUS_STATE Kconfig symbol, that was supposed to denote
>>>> the active-low vs. active-high polarity of the LED. However this is
>>>> a bool symbol, so it will simply vanish if not defined, and we 
>>>> cannot use
>>>> it directly inside a C statement.
>>>>
>>>> Filter the symbol through the IS_ENABLED() macro, which will return 
>>>> 0 if
>>>> the symbol is not defined, which is the intended value here.
>>>>
>>>> This fixes configuring LEDs with active-low polarity.
>>>>
>>>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>>>> ---
>>>>   board/sunxi/board.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/board/sunxi/board.c b/board/sunxi/board.c
>>>> index d7722d1858a..80dcae9c1a4 100644
>>>> --- a/board/sunxi/board.c
>>>> +++ b/board/sunxi/board.c
>>>> @@ -563,7 +563,7 @@ static void 
>>>> sunxi_spl_store_dram_size(phys_addr_t dram_size)
>>>>   static void status_led_init(void)
>>>>   {
>>>>   #if CONFIG_IS_ENABLED(SUNXI_LED_STATUS)
>>>> -    unsigned int state = CONFIG_SPL_SUNXI_LED_STATUS_STATE;
>>>> +    unsigned int state = 
>>>> IS_ENABLED(CONFIG_SPL_SUNXI_LED_STATUS_STATE);
>>>
>>> Sorry I didn't react to the initial submission, but it feels like the
>>> CONFIG_SPL_SUNXI_LED_STATUS_STATE symbol really means active-high if 
>>> enabled
>>> and active-low if disabled. The name would suggest that it's an int 
>>> with a value
>>> of either 0 or 1 instead.
>>>
>>
>> Yeah, I lazily renamed the old CONFIG_LED_STATUS_STATE which used to 
>> be an int range (0..2) and made it both specific for Allwinner as well 
>> as changing it into a bool.
>>
>>> I think it would be less confusing to call the symbol
>>> CONFIG_SPL_SUNXI_LED_STATUS_ACTIVE_LOW and reverse its meaning, so 
>>> that we can
>>> spare defining it in most configs (that will be active-high).
>>
>> You can also have
>> default y
>> in your symbol to not have to reverse the meaning.
> 
> So what about:
> config CONFIG_SPL_SUNXI_LED_STATUS_ACTIVE_HIGH
>      default y
> then?
> 
>>
>>> Also the description currently mentions "initial state" which may be 
>>> confusing
>>> as it could refer to the state inherited after reset (e.g. due to 
>>> some pull
>>> resistor) or the state we do set in the SPL.
>>>
>>
>> It was the prompt for the now removed LED_STATUS_STATE. What are you 
>> suggesting instead?
> 
> I came up with:
> Whether the GPIO of the status LED must be set high or low to turn the 
> LED on.
> Thoughts?
> 
>>
>>>>       unsigned int gpio = CONFIG_SPL_SUNXI_LED_STATUS_BIT;
>>>
>>> And while at it I would rename this to something like:
>>> CONFIG_SPL_SUNXI_LED_STATUS_GPIO since it indicates the GPIO number, 
>>> not a
>>> specific bit in a sunxi-specific kind of register.
>>>
>>
>> Also a remnant of LED_STATUS_BIT* symbols. Either work for me.
> 
> Yes, indeed CONFIG_LED_STATUS_GPIO makes much more sense.
> 

CONFIG_SPL_SUNXI_LED_STATUS_GPIO I'm assuming?

> Let me know what you think.
> 

Ack to all but I also don't care too much about Allwinner. @Paul?

Cheers,
Quentin
