Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49F07F8FA9E
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 17:12:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BB4D839D5;
	Tue, 21 Apr 2026 19:12:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="TKmmwApM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4698083A91; Tue, 21 Apr 2026 19:12:54 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D8C580086
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 19:12:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ujSOvtCfalU/1e6/4i1eLaCamAjguA6xt+mi9uFBi5+8X+JOK2fjZwIqbm8BLNboBboIYdp7HjlYz8L/TXX88zRLWEW6836p11baQfhu/+1ptdjVB7DnleWm8GXJWBDWTp3xoNP18Jlj9Pj7BlExP9iNQNNn28stfzl+KfQg+5nSq2Vxrf9zN1xfjFu/dIK9y//ZjfsXF0OVfk8+DA0/EXYqgE4+ZzN2DXlsz3X6ICRzhlMUaIrw5u/mB4Gckb3EwgVTqE5XzKejlk+bC3cS1sp4+A767eDNeNDvEAh0tDS14UZHOigUVV1z+Dqy3wfdq+Sh+WDuRKYb5MpnJDVwdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dSxvP75iLv1E5eJPNWywQHo6a4Zn/WGYNzOjkArOMSo=;
 b=XN+Zxl8iEy2LzsYABz9rtbivlhGzRWIPX4s2TPEBS04nz/kBCzbJW6Dpt4HVLk7eJcQ64Qdz4lj1tvghw2daUYfZf3xJoTGfyQHvYxI4F/SpumR7DnABkQfZXbusxXOyaQXDCkuN4SnyVQIYu73y4pRyIURbri7CuFy8uFsDWRRuBVQp+1r4UElS7mlk8nnfap2pZQJdxFK+4NPHRaYe2q6BLj7nsta747drsP0XDGXC8VxR21lZN/wzHY6Ruen++SjEMOMrGN0MSi2/5pTszhYntr5dTsUUfZsyu5aKHIyJfztyNSCGcy3E3N1Yp9K7SbYaG3I9s3DJfU0W4UZ3nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSxvP75iLv1E5eJPNWywQHo6a4Zn/WGYNzOjkArOMSo=;
 b=TKmmwApMFcyMmleXOJ9HZcLiUqZAZcx/EoOyzgjbcbF7jKbapXVYIs33h5m2gv2YF4bfI9/QYbDckbYxlGnqLa88paaccJrZ+sETTNPaguCXiDTfwA4/NIw3di1W3R05URz8gpr8PNHIsaJ7mmARBHQAQPe3uN/BL48NxL3uHi8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by GV1PR04MB10774.eurprd04.prod.outlook.com (2603:10a6:150:205::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.33; Tue, 21 Apr
 2026 17:12:45 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 17:12:45 +0000
Message-ID: <cf689aa6-4852-41c1-9c49-3c208e40d76b@cherry.de>
Date: Tue, 21 Apr 2026 19:12:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] sunxi: spl: fix SPL_SUNXI_LED active low configuration
To: Paul Kocialkowski <paulk@sys-base.io>,
 Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, linux-sunxi@lists.linux.dev
References: <20260407223447.4956-1-andre.przywara@arm.com>
 <20260407223447.4956-2-andre.przywara@arm.com> <adfMQBPdntWy1KIq@shepard>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <adfMQBPdntWy1KIq@shepard>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0144.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::20) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|GV1PR04MB10774:EE_
X-MS-Office365-Filtering-Correlation-Id: 8953209e-b6dd-4c9e-b6d8-08de9fc93453
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|10070799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: Kl+MGEGYH5UFB/UvKNM5zKv040xvQom++/MZ0j7mftnc1V7DyM4rRMTR7Bw/NyyrSprFrn4AHIrQeeiUA1vfc79He8+v7igtKSz02Zmo6cg70s7RGzC5kBZB15R/t9PyNabZR53B+B97lDLER5bC4/YPcXGeNBLpWjFt7h8A7IOQCrTD2hX+lZ9peQQfYMaK8ciU1F+Ba/MR82fzDBxyJajW4xGzo9W0YDx1A63cRf111OrkOVnFDEJ3BcBZJ1PZh4dXDQJWW0q1HuzAXYNh0NoybVZLrRaI3zwik34dChZ+ym1970FNrXBFg3SdYdiJ4M6bl+QTYo47GB9e0bAdxo8Ybm1tvQrtEaCG9IaEy3qjtOCIr4yeMkK9tSKNJDQ94Hv+nDgGluCaE04j6QtfzIngM/uOnr82gf5eQfqUNEWfhpwazqOte2kCFJtLJ/AbkhH2M0R9+g1p/yV13loPMJu1j3HS23LWWIxcON9HUhrxnjd0TuFVFZUi/0twZjkglTBTBdWNdXYme6mJkS7Kkj1v4CIBVBVgAL7EoiBZf+qRfsZhEXQ26trKCMXATcyhTab0NU3n0H3zKjfGLLLdx4eqfOe801AqZOuea4i6+ZhBg9DxNbgLMsGbbnk+s24NkAI6/g+4G0xtrb0iRti0qWrNkJ9/3CjQtDJvHqwjvK5YeGM0RMbPBL8f9y26HNXcaFK52OsWc+jXEiHWhZK775iKx08mDeHXCjGb/MapAxA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7743.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmVKOVptanp3MDdvTTBBUHBRWGtWMFYzOWV2ZUlMS204R0JJSGlHMVNneXAy?=
 =?utf-8?B?YUk5c00rM3lRM05nNlJaZkFMT2dUcGNJdU9odjZDRm8rNGcrM1YvRUxnRVFN?=
 =?utf-8?B?NTIrZ1UxWXF2NkF1Uk81cnNJTkNydkQ5WGhnSmRqdDBRcVRTd1BrcGtLbzFX?=
 =?utf-8?B?djIyK0JXcUFpaElmQnF6MHdadlE0dmt0YkgxQjgvbURINUpUMmV4LzExNDZK?=
 =?utf-8?B?MFhici8vQXR3aVpDU0VkVkVCcUNGbWhWMDZ4NlpYS2swVmRxU3kwNGFTUitY?=
 =?utf-8?B?R1ZuTnhMbGtHK2ZDWXpvczkwdDB4aDdpOGlWZnRrelBVUlRCRmprNCt6cUtR?=
 =?utf-8?B?QWxXaFZCNFJFM0FmMUUyL0VsT3JCMXVLT251V1E4NGtOYUZVRW5uNlpxMjBH?=
 =?utf-8?B?V09Gd2ZuSVNwKzFMMnAwNXI5RzBOUDV6S2ZTdXFEMDdYZHlTdU05bGZUT3h1?=
 =?utf-8?B?S3JwbGhwODM3dXhFdzl1cFFaQXdOMy9hQ1RMSzM0ZmhFeFFEb21JcllLOWN1?=
 =?utf-8?B?OVlKTUhuOSswRVhBWUdyVFFNbThHQTN6VDQyenMvSGdkVWhSaVRXcVEwTDgw?=
 =?utf-8?B?ZXBQWnNXYm43dDQ5SnUwYi9JcjZVKzBFUXdtNjVOL2pabHhqMHppazZIVmdU?=
 =?utf-8?B?TGViS2ZqYnZrbUFmYm8vMzdHOSt3ZmJFQUo3N1NKMVZ2NEgzQVJmb1NYaUFZ?=
 =?utf-8?B?T29sbFFEL1BYakJSa2xIWTRHTXZnaEFuYUg4Z2RnZXJZZy9Vcklyak9iMkor?=
 =?utf-8?B?UWttVTI2b1d1RE1EL1FOQVNXdlRYaTN6SFoyc2ZRUEFNNEltQ0ZYUmRoMkNP?=
 =?utf-8?B?SEtGOVJCVTBnMFpUSnFxbDA4S2pPdDBkZk9iNTF2OUJVZm1ibFFpWEVFbVJn?=
 =?utf-8?B?ZWsybDJhQkhsM1FKdzY0a3FESEgrZmxCWWdHdENuUWxHYjZoSTAxMnVnQTRx?=
 =?utf-8?B?ZHV4MDI1SkZpQWZhaVhYVWk0UVRpa1BkWVdqL1Urb1JadGVEVGhHQmtyQ2ZC?=
 =?utf-8?B?ekZYVlFHK1M4MTB6NFRkb2ozU0wvVEJ4em05bVJOeXdiUWRyQVhvOVhubnRC?=
 =?utf-8?B?bi9USjN2TTVXaGNNUTRnVnFRTWJPRHJja09LQjBKc0licVo2V3ozY05tV0FU?=
 =?utf-8?B?Q1Yvdk9oc2ZabE1IQmI4WjFYMURlQ1JDQlFXa0x1VVRhenhpejdTb0VQcEw1?=
 =?utf-8?B?blZiREdSVk1ZTG0xVW9VT3I3bE9rOUdDTzZkclVTNVhxam1yYlhzMWdWYjY2?=
 =?utf-8?B?T1AxandpVTNIRXUyL0orbjRjZ082bFVPQ1dSbFZ6SHNORER1Z3I4SnErSld4?=
 =?utf-8?B?NldBWW5qNnJxc2xsOVFkd1R5WDQyckpiK1RpYUVyRG40Q25yeFNnUUcwam8z?=
 =?utf-8?B?ZEFPYWt0T3kvN0lXTlhMS00zWG1ZaDRxVGxaYmZJYU1vMkhVM1MzaVVrelpZ?=
 =?utf-8?B?dkxBdGZmRkRHRjZUUmVoQnNNb1FhdWdFVEI1cDZEWDF0K3ExeVlQSXR4V3RE?=
 =?utf-8?B?T3BJbFErVm9VU2ZEVHlObDQxcUIwMFUzRW9Ia3kwYzNVRWRxV3NHdi9BenRs?=
 =?utf-8?B?MnMwWHpDYlVOY2MzTisvMDJSMVlIc3pubndOSmdEN2pTdkxoMHhKL0tSMGhN?=
 =?utf-8?B?UVVpcEZISy80dXVhUFlpSlk3YVlxUHZxRjBaeWdjSHBlSU5mdk9vNXFDcG05?=
 =?utf-8?B?TCtiK2NuWXBzYU1lVEpMZjRTMldnVVN0SVNrKzE5Qm5sNFhkZmFiQ1VyQU4x?=
 =?utf-8?B?a0kxZnhDNW1mcjd3cHBSaUVVZGN1MGJCS3dVdU4wQ252NjRpNTYybUxrN1Zo?=
 =?utf-8?B?L3ExR3RaR2ozcTRXdWJ5cmY0Q1QvQTg0SGFZclphampBMlozRVRVWXMvcHpv?=
 =?utf-8?B?eXF5WThhOXBWMCtuelg1b21ya0oyRE5NTW5oK3VzVXcxQmlyZHNqQlJ5MEh4?=
 =?utf-8?B?ZGVCWG4vci9qeiswOC9ZREpibFVBTGU3SU45UDJ0RE9jaDUxaTdjNi8zZ1Bz?=
 =?utf-8?B?cXJEUEN4NFpXRUpTUE5URWc4cHNMbERmVW1tOTh4aklKekh3SHV5RndrY1hW?=
 =?utf-8?B?cXEvTTRGTHZRN0xEVUkzbUFpc3JvUythNHFYME5jb3p1MDM5Z0kwZHllVHp3?=
 =?utf-8?B?Tks0a1hFNE9uMjBzSmttNnpVWkZzTkZmQVYrdGZuUHlHcjdpZHlteVF1WTRm?=
 =?utf-8?B?OWM2OWtqbGg4WUt5dW52MnBzMU9DUk5yMWdJMWxvQkN2TVJHa2JkbHpyNUMz?=
 =?utf-8?B?OXdLaEtZeitRL0xZaVc5RkNqbUlBWWQ1dk8yeU5kMXdBU3YzMkx6WFRoSktN?=
 =?utf-8?B?b3BDN1VHVWQyYk0rUGEwTnFvTUIxR3ozdFJWT0NyRkp0bHMrZFk4dWt2OWJs?=
 =?utf-8?Q?2ApDXsI6ApIf3sn0IELOdKuH6ecvP1mhJ4qgE?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8953209e-b6dd-4c9e-b6d8-08de9fc93453
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 17:12:45.1060 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JyxYeV95l7QRM/pScU5AgpKu+Dak2cY6STeHymNGrU/CfPxOegclwFQuylbX8foKqpbtFC9wVm+UvzPM7j9GPkyX05/AGdkfzI9jTlZN6Tg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10774
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

Hi Paul,

On 4/9/26 5:56 PM, Paul Kocialkowski wrote:
> Hi,
> 
> On Wed 08 Apr 26, 00:34, Andre Przywara wrote:
>> The newly introduced Allwinner SPL LED "framework" defined a
>> SPL_SUNXI_LED_STATUS_STATE Kconfig symbol, that was supposed to denote
>> the active-low vs. active-high polarity of the LED. However this is
>> a bool symbol, so it will simply vanish if not defined, and we cannot use
>> it directly inside a C statement.
>>
>> Filter the symbol through the IS_ENABLED() macro, which will return 0 if
>> the symbol is not defined, which is the intended value here.
>>
>> This fixes configuring LEDs with active-low polarity.
>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>> ---
>>   board/sunxi/board.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/board/sunxi/board.c b/board/sunxi/board.c
>> index d7722d1858a..80dcae9c1a4 100644
>> --- a/board/sunxi/board.c
>> +++ b/board/sunxi/board.c
>> @@ -563,7 +563,7 @@ static void sunxi_spl_store_dram_size(phys_addr_t dram_size)
>>   static void status_led_init(void)
>>   {
>>   #if CONFIG_IS_ENABLED(SUNXI_LED_STATUS)
>> -	unsigned int state = CONFIG_SPL_SUNXI_LED_STATUS_STATE;
>> +	unsigned int state = IS_ENABLED(CONFIG_SPL_SUNXI_LED_STATUS_STATE);
> 
> Sorry I didn't react to the initial submission, but it feels like the
> CONFIG_SPL_SUNXI_LED_STATUS_STATE symbol really means active-high if enabled
> and active-low if disabled. The name would suggest that it's an int with a value
> of either 0 or 1 instead.
> 

Yeah, I lazily renamed the old CONFIG_LED_STATUS_STATE which used to be 
an int range (0..2) and made it both specific for Allwinner as well as 
changing it into a bool.

> I think it would be less confusing to call the symbol
> CONFIG_SPL_SUNXI_LED_STATUS_ACTIVE_LOW and reverse its meaning, so that we can
> spare defining it in most configs (that will be active-high).

You can also have
default y
in your symbol to not have to reverse the meaning.

> Also the description currently mentions "initial state" which may be confusing
> as it could refer to the state inherited after reset (e.g. due to some pull
> resistor) or the state we do set in the SPL.
> 

It was the prompt for the now removed LED_STATUS_STATE. What are you 
suggesting instead?

>>   	unsigned int gpio = CONFIG_SPL_SUNXI_LED_STATUS_BIT;
> 
> And while at it I would rename this to something like:
> CONFIG_SPL_SUNXI_LED_STATUS_GPIO since it indicates the GPIO number, not a
> specific bit in a sunxi-specific kind of register.
> 

Also a remnant of LED_STATUS_BIT* symbols. Either work for me.

Cheers,
Quentin
