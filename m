Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24AC7CDB474
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 11:17:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DAD9878C5;
	Mon, 23 Oct 2023 13:17:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="k3QY0R18";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9E68878E2; Mon, 23 Oct 2023 13:17:10 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20722.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::722])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CCCB878C5
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 13:17:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HSJEornCd+sG7z3FyjgQ1utcPO1XLwreP9WK9SB6mjPzTG1hHdDDJA2v8rLvclT8Qn0Wp6xt7H9ImrG94ayRhjLemzr15wL09tmUqoqTwMRkRgFaoLNTE+8sk525zxeX9F8nss503WfJh/ztC47W5qXWPACejDTSwu09KplrEpI2v5KT2ob/vRjwJMwSwCOilKsCMzVY+TEg8Gjfsff3/b6lEAXjHI1JUAHvJK0bHCi2eE57pm1TMDRHeEHfN3BTXg39CWv9HwhsY1BO55GL5KhivReb5wimVXo+Esltk8HtjUsXdY88gOyUoOE+dhwBLrZNqB7ZeQ3/6lE6uB4enQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nlkwn2gvX3kLPPUnckrIwfNPsTZfbEmgzvfTjP2sucw=;
 b=lKeZKPLuYOxOT7NV1ubjb207Xq3Wm3jRx2mxi4qUWVXSnHxC/XH8mBQBw2fygrmEs6yBPIcZ4/ulA9uT6qW7tqqSQt1LVQrO+kngJInE/mMpN+h/JgtEbRkWPTVLXkXkLinpauUnFSeQpiqCpQeTGXJQb5eVcxLkivKDNIXAlqSFY+RQigs/jbIPhUWJX8ey0O8BVgZGcKZcf7BfYbvvpyJOWHLWGsWAp0H6JJUsnbDEYvloUjZVWkhwnLqZTSorvYIKtbtDNWNUi6gWDinW9JuFb71UdJBbBpmFgt+AUTcO5B+7L5uKRACJs/L75geP6GitFUo+z/Q3Lfe1Mt6KOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nlkwn2gvX3kLPPUnckrIwfNPsTZfbEmgzvfTjP2sucw=;
 b=k3QY0R18PUWjFXW7/erIzQ1yQJLGgZs3P3TL+b5zLWOMn+ELFtuwvMSC4Jhc5MNnXunMIyzXBmHwQAb6nswFSDsM8+5aZozvtxJHPFUkAHvxiworGIKCWhcVmeMpnioBHz/+foE/8VqZdsnm4R5rmaUUxHw4Y7KocXl42VzwSW8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by PAWPR10MB7769.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:34f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Mon, 23 Oct
 2023 11:17:04 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5%7]) with mapi id 15.20.6907.030; Mon, 23 Oct 2023
 11:17:04 +0000
Message-ID: <d828a076-2a4b-479b-9d5c-6b12ecc274c2@prevas.dk>
Date: Mon, 23 Oct 2023 13:17:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] led: add TI LP5562 LED driver
Content-Language: en-US, da
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Cc: Philippe Reynes <philippe.reynes@softathome.com>,
 Doug Zobel <douglas.zobel@climate.com>, Tom Rini <trini@konsulko.com>
References: <20231019095837.2084458-1-rasmus.villemoes@prevas.dk>
 <20231019095837.2084458-7-rasmus.villemoes@prevas.dk>
 <88c0c718-d62f-4854-89d3-c68029c44556@denx.de>
 <f53f9d1b-ae49-4bca-af39-6af23429e5a0@prevas.dk>
 <eac43740-80aa-47c4-8237-1abd82615dcb@denx.de>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <eac43740-80aa-47c4-8237-1abd82615dcb@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0105.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::14) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|PAWPR10MB7769:EE_
X-MS-Office365-Filtering-Correlation-Id: 31b894fd-cdc5-4e0d-5a17-08dbd3b995da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DyKCnG8wGCr/cepjVT/i637UgZvrQtizckkNVS+iB310C3Du3+x2twdayh9Q12y6kv9/GU8XWjIFsB9pFJSfqbx9q6bf58N7IvSFSmq3HKZNSXKUEvIp1uGnRo3s+ZclN3psG0kX6/mmTpKqkJAZe8pRC1DHztfyReJCmh1hGc4w1zIbL7FQw0aDQ4eG+xDLYZ3ghUbip3NtOU/T20OcRL8O86ELOZjX1I4t6qacuUzplVC1xpVMSarlwwQ8HzZkLoteKvwhlK2yPHrmsVKZJ+kS1f5PPoVaal1h9kGl2S/60L4HV6QklhCZwUKW6w1i8GdcHx3rDSlFiyB+cbmyw4WNXbWHClGn/DqoCyvIYShaAjcm2cnLqX+U7V3CNL9qxncoQK35/+zvOA4h4XZ4G/m2oQ2VyEudC5ZmzAi8hsIyIjjPDPAFxVqGqiUYAsYAYtbkhHUyZ++L8OLvhGyO1B/CGp09U5iE5TOn0/TtstfVfZKLlBKE6j0Nnc041wzp4Hr/aKCxuI01CPNARgiGahF7nB4Ehy7LR6ObxpiaU4amVwk3qNwi8PBXkJochxoxd7TxxBFGyRt5Q8bYZsGNrLWekyLEf35+N3JkZH9qDqxNOHwDPZBP3LjbBubA8tCaesuEbtg+hydN7e4iP5RkoQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(39850400004)(346002)(366004)(136003)(396003)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(26005)(31686004)(38100700002)(2906002)(41300700001)(44832011)(86362001)(31696002)(5660300002)(36756003)(8676002)(4326008)(8976002)(8936002)(2616005)(6506007)(6666004)(478600001)(54906003)(66946007)(316002)(66476007)(66556008)(83380400001)(6486002)(966005)(53546011)(6512007)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjJKVTF5RGJPNHJRVmdlV2FpaFlBcGRaOGEwMkhuY1QyT3RCcGkraEsxbVZG?=
 =?utf-8?B?V0UweWdnbVhiMmJzeUFKWFhpQ0JlN2VyNjVxekJNd05RaUZRbTNwM2ljYWl2?=
 =?utf-8?B?eXplWEgzUHp4U2F2ZTIwWk84WStIMjlvMGZqVEZreTAzeDJnVVpXcnZxM1lQ?=
 =?utf-8?B?QkUwVFRuQktHTEhVY2lYdjZlK3JIbHB5YW5BSWdkUDFXQkNKT0VhdFlYSWpj?=
 =?utf-8?B?N2x3WE14K3Z1ZklKZ1lUcXJ4UVRIbWpVMUkwUXJBMTJDK0JQL2l5VThaNnZ4?=
 =?utf-8?B?ejkrbjZmOE5KUkhsYUd5TklHODdpUGVHVWU4QWpHU0F2enMwYTFDcmV0eHlz?=
 =?utf-8?B?cmF2MmoySW85cnhnQmhyVDJseXhaMWFDR2Q5bWZHV084QnhsQ3crUTdGQ1Ev?=
 =?utf-8?B?UWx4YW9td3pJd21CMmN1YTZzZG12UHRiYXJLcDVLamhMb0d5cjRhRmFTZ0Uz?=
 =?utf-8?B?RVZpTVUrWktSRkZFL2NvRDdzanRCNzFzcUlSbHhvYmdXTnBYeHlkU1paMlYr?=
 =?utf-8?B?Q21hM0k5dVR3RjUva3ZQYUc1MXYrZFZaQ01ySCtzTlZqdUJsL01NdDRZVkdz?=
 =?utf-8?B?b2NDUHNSU2tJazZXdXBjcktVcitDWHRzVzVuWlRFaEZjY3lPaVBSbm9PNGh4?=
 =?utf-8?B?WS96Zlh2VFVmSVFyMUFyTERVSVBlTkhOU0g1eFYvczlyUWpFVTBINEwxRUVq?=
 =?utf-8?B?Rk9UNUEydjdrM1cyZE03VklrWVZ1cDBNcjU5d0hvUmMxcTJwVlNkbVBtN3hV?=
 =?utf-8?B?cTJHWXAxN0xrajFpOGJlTjd2UWhFRW8rWjBwaUxQTWRLbDdIOTVFaitMWlpK?=
 =?utf-8?B?T3FHSkR5RDdUK0JpenIyci84QXRXaHNEMmNEbnZmQzhLUHl0Q3dmclUwbm1t?=
 =?utf-8?B?S2N2eXg2MlJuS1UzVlMvN1B5czJYclFWUjN6M3Z2L0JDRmhPcmN0djhpNStk?=
 =?utf-8?B?eXVWd0k4RUhDNkhXUjFPWENnVGtFY2lsZFRpWlNVRXlkNU80NzNMMTVicWRB?=
 =?utf-8?B?aEl4VlZFSG13QjFXUG1BSXJBM0lNblhXOVF4VDYzN09yY1N5N1hIOE1wLzFa?=
 =?utf-8?B?REZkOHFMMWY5OTcxTFI5aXBFQUovNzFSZUJ0Y1NRbDNKc1BRbGJqN002ZkNZ?=
 =?utf-8?B?bjZtdjByYzhVd1R3VFh3a3hGbXpaMmlvazZSazh1MUpsellQTzRUK2QvVlNU?=
 =?utf-8?B?QUo1UWNOcXR3bEdWUGh3TmVva2hkQSs1SVRYcW5KNUtrSTIzb25mL2E0K2xE?=
 =?utf-8?B?WnhkNjhxbTkvQmNFc1RWanczclE2NW1Lb2lPYUw1dXhlQ2VWZVVLY1pya2Vm?=
 =?utf-8?B?S1BpR1gzdmJ0NGJCZzF6aWFmcHYySTlQYWUzRllFRzVRQUMzTjJNdDU4QktZ?=
 =?utf-8?B?dDY1VmxEeUxTcVp4dlliZm5xKzRQRnZ2T2E5VUpFUElMZWtUMEJVM2dDTGhh?=
 =?utf-8?B?azh1ajVTM0xJWXQyaWZtREJhc3dHaWV0dnlFTkh6VHZMdUFkRW9kMHRVS05T?=
 =?utf-8?B?RUQ4dlNoODR6cjdZcHpQcERnNUpYNGo5dmRFNjdKbUo2RmM1WSt2RE5lZ2Qr?=
 =?utf-8?B?ckd6SUVpUEZZdnNGeGNrOFBra3hJbzR0cnhvdUdZdEgxUktLSTNsMmkrK2ZN?=
 =?utf-8?B?aXRTeDdMZFk3RVl6T01kcVcrT0crV0lGcDJGUGprYVUyNVd0L3BLVVd2RFFF?=
 =?utf-8?B?Ymd2SEZoZ3FUMXk4aTZnK2ZmbWNVZm9QTndxRzhpek42Sng3NkRCTlFhcmJl?=
 =?utf-8?B?VkZyaFdjbGFuMHY2MTZiVnBlUGx3VEgwMWhoVzZ0RjlHV2crenZOS01LUEg0?=
 =?utf-8?B?VTZOUHFCeEVaRTRyOE1qbEpZUk4yVkgwTlpZWTJvc1RRWW5aNEVrNm9LTVFM?=
 =?utf-8?B?Nm8xemVZQVNWZW1vRlRwYnBoOUg1TE5RS3RLVUI0VHpTZ20ydW14MWhoMkI5?=
 =?utf-8?B?K1hZY25UZks1azhUdjZGRGV3ai9kWnpXY2lMZTJkQ3lxSWlJb1lZT0FGVnd6?=
 =?utf-8?B?bGFOQmYzVCtXYnZCb2d2aG52cDk1QzlKd2pFMEQwTXRMYmEwYnd2NjBZY3dR?=
 =?utf-8?B?cGVoMWxGcXNLYzRFQURlNXovdk5sYW1lWkZ4TmJJT2laeVRTV25rZ3lGV1Bw?=
 =?utf-8?B?c1ZwT2JobjZzVVg1RHVnYTU0RFNCSmcwQ3pYOEFOQkpVL0gwWG0vUWE4R3FG?=
 =?utf-8?B?dkE9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 31b894fd-cdc5-4e0d-5a17-08dbd3b995da
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 11:17:04.1389 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XJHM0q+6fZH9Iu9Zf4ztx+vqhQimHjz4R3NHdht4egu9pRRGu6Elry4DrB26k9yAUn/fmBEyd77y6PWWbf0NLP93bnmN58Fk6bNP38Ul1qQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7769
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

On 23/10/2023 11.39, Marek Vasut wrote:
> On 10/23/23 11:11, Rasmus Villemoes wrote:
>> On 19/10/2023 15.58, Marek Vasut wrote:
>>> On 10/19/23 11:58, Rasmus Villemoes wrote:
>>>> From: Doug Zobel <douglas.zobel@climate.com>
>>>>
>>>> Driver for the TI LP5562 4 channel LED controller. Supports
>>>> independent on/off control of all 4 channels. Supports LED_BLINK on 3
>>>> independent channels: blue/green/red. The white channel can blink, but
>>>> shares the blue channel blink rate.
>>>>
>>>> Heavily based on patch originally from Doug Zobel [1].
>>>>
>>>> I have modified it so it matches the DT bindings in the linux tree,
>>>> and also follows the linux driver implementation more closely. This
>>>> should address Tom's concerns, and also matches my goal of making the
>>>> U-Boot driver work with our existing .dts which is known to work in
>>>> linux.
>>>>
>>>> As our boards only have the R,G,B outputs connected, I have not
>>>> actually tested how the white channel behaves, but the R,G,B work
>>>> exactly as expected.
>>>>
>>>> [1]
>>>> https://lore.kernel.org/u-boot/1547150757-1561-1-git-send-email-douglas.zobel@climate.com/
>>>>
>>>> Cc: Doug Zobel <douglas.zobel@climate.com>
>>>> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
>>>> ---
>>>>    doc/device-tree-bindings/leds/leds-lp5562.txt |  63 ++
>>>>    drivers/led/Kconfig                           |   8 +
>>>>    drivers/led/Makefile                          |   1 +
>>>>    drivers/led/led_lp5562.c                      | 578
>>>> ++++++++++++++++++
>>>>    4 files changed, 650 insertions(+)
>>>>    create mode 100644 doc/device-tree-bindings/leds/leds-lp5562.txt
>>>>    create mode 100644 drivers/led/led_lp5562.c
>>>>
>>>> diff --git a/doc/device-tree-bindings/leds/leds-lp5562.txt
>>>> b/doc/device-tree-bindings/leds/leds-lp5562.txt
>>>> new file mode 100644
>>>> index 0000000000..4e0c742959
>>>> --- /dev/null
>>>> +++ b/doc/device-tree-bindings/leds/leds-lp5562.txt
>>>
>>> Why not use Linux
>>> Documentation/devicetree/bindings/leds/leds-lp55xx.yaml ?
>>
>> Because I'm not adding support for all the devices covered by that
>> binding, nor for all the properties defined there (and some of those, I
>> think, do not even make sense for the lp5562 but only apply to some of
>> the other variants).
> 
> Using old bindings like that will only cause divergence, please dont do
> that.

I am not doing that (i.e. using old bindings). Compared to Doug's
original patch, I _have_ changed that .txt file to match the existing
linux binding and hence my existing .dts. And made all the corresponding
(mostly mechanical) changes in the driver. Which I also mentioned in the
commit log:

>>>> I have modified it so it matches the DT bindings in the linux tree,

For example reading some property values using dev_read_u8, because for
some reason the binding specifies that the values are /bits/8.

If you want I can spell out all the changes I made. It just doesn't make
sense to have that kind of info in the commit log.

>>> [...]
>>>
>>>> --- /dev/null
>>>> +++ b/drivers/led/led_lp5562.c
>>>> @@ -0,0 +1,578 @@
>>>> +// SPDX-License-Identifier: GPL-2.0+
>>>> +/*
>>>> + * Copyright (C) 2018 Doug Zobel <douglas.zobel@climate.com>
>>>
>>> Why not port Linux drivers/leds/leds-lp5562.c ?
>>
>> Because that would be way more work to make that fit into U-Boot's LED
>> framework than to take Doug's initial patch and make it build against
>> current U-Boot.
> 
> Seems the drivers are just about the same complexity, so why not port
> the new Linux one ?

So how did you measure the complexity? LOC? If so, you may have missed
drivers/leds/leds-lp55xx-common.[ch].

They are far from the same complexity, and the linux driver simply has
tons of gunk that would have to be removed or #ifdef'ed out to compile
in U-Boot, and I'd still need to add the U-Boot-specific glue for the
struct led_ops etc. In the end I don't think much more than the register
defines could actually be reused. And since I now have a driver that
actually works I don't really want to try and see what it would take to
port the linux driver. It even includes blink support, for which there
is AFAIK no equivalent API in linux, so that would have to be
implemented separately on top - I don't need it, but left it in (and
tested it) because it was in Doug's original patch. If I removed that it
would be cut at least 1/3 of the lines.

Rasmus

