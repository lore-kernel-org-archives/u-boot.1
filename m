Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2FD8CDB474
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 09:11:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3BD287883;
	Mon, 23 Oct 2023 11:11:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="bndzWh3W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8E438780D; Mon, 23 Oct 2023 11:11:46 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20714.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1b::714])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7B32878B2
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 11:11:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bh4Oi/BYtoONCza5aQfzIKbDOSrL3+l3B0pYDq3UthpP91RMfXKbJuIuv/mc/gCqcL3efSkmSdsrPZ8y2QxfbfSfs7N93klDpJZK/0X4BLebKdQnMYoWRqy9KF2fOpS3XOINTNRqWHy8mkLI7BdZOodeID45sv7RvygAnBZVavktrqInxYTSfdf8+04VpnwGVsIqzYVhx0ixgfCMEzxLcT1v7lX/9FI3nmtQOr/HoR+RRJ1pS76NxXlBkhblhGOnfqiDrY6m/A/jspZJII2cY+3bZo7tLdDjhsapEKsG2tFgSm57HcdpYFDepnxMZAZgdeytxstNCSGt4ma1XhmVDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a5OX5xPqtMVgosnwvMaTFaH4A4hrw0uKKxeAogKccaU=;
 b=k5Ufcv4lUv8KrtnrnDcZ1wCL2huUw2BECXvptJpVZlUrkLFRcHdskmnxQlvm+Jz6yTR5YtUpZ9PvRby8+YhRB78CEAFviwEWtdtJvU4gx7KPNY8fpaKBgaaZ6fCNLeZ2P096j2WmjkNV8GKHiIZFX54Zc66H1Xs81jBubTjc+vQRT779NzniycBMOegrtEb6blWCgZpCJV/9jfWSd1YWvfRLi3H68dPT4BOOBs5KvoeetDolqGeOOe5stZTyc2eQjr8CEF6PiyXE5//g4f2fdYyaeX3uvmHOXLQBcsQtiykSxbQLNn8NGe+IczuYoT9l+SrcokmaB3MTZPpiYOBfIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a5OX5xPqtMVgosnwvMaTFaH4A4hrw0uKKxeAogKccaU=;
 b=bndzWh3WT/lZCYclbogF20H3B6+GyGpVQCqtISdABWM0bu2Vjxwm4tM1Iwu/Ll02P8SzzVBv7TCN76cRQTCkcklH8xCxpRVSaOXWUJw39nMllwRSZCpEJLfnAL+fI0OVeMcs7D7nCXhHObgCCbw1ZJje1+fiDqPaUpNtxRYvoAQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by VI1PR10MB3631.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:13b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Mon, 23 Oct
 2023 09:11:40 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5%7]) with mapi id 15.20.6907.030; Mon, 23 Oct 2023
 09:11:40 +0000
Message-ID: <f53f9d1b-ae49-4bca-af39-6af23429e5a0@prevas.dk>
Date: Mon, 23 Oct 2023 11:11:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] led: add TI LP5562 LED driver
Content-Language: en-US, da
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Cc: Philippe Reynes <philippe.reynes@softathome.com>,
 Doug Zobel <douglas.zobel@climate.com>, Tom Rini <trini@konsulko.com>
References: <20231019095837.2084458-1-rasmus.villemoes@prevas.dk>
 <20231019095837.2084458-7-rasmus.villemoes@prevas.dk>
 <88c0c718-d62f-4854-89d3-c68029c44556@denx.de>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <88c0c718-d62f-4854-89d3-c68029c44556@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0117.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::32) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|VI1PR10MB3631:EE_
X-MS-Office365-Filtering-Correlation-Id: ca7c8e97-4f19-4003-ec1f-08dbd3a8115a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VIqoTWLaOvy5Zl5GBv4L8GCeqGP+RJaI7RLs9xY+zIQq17NNByOCfRo5cKtMVzBJ30YoFs840cboKxN+QoBXTpCfiD6WaKjKBRmU/FbSOsIDgd01VPgrJZaLtTpzXnf3XeTmSD8Em17RAQjtS4qj/XLZFKv8yCbEESNexExP4KXAKQP5hI1Z8GEr5rqAbzIMfJxnmfVn3N7qbJ7HtWHjCfZH/vYTHDioHKiqa0EoHahpYRllNFWyZVsXza8w2BgfmFL1tFFNmBQt+auogt0NvYVln5xn24CP00jMuEsfbcQ+zoUABNqfAVKxQHuiJ68uxnSECdygLq4Uqd9+jUTA1nQTYhgaHq1IIq0VlHuIJdrxzU5bXOL3Ky+WMgdPAIYzJ0uEh/Lr/QZ73o1N3nahPltbtagerP5m18jV2lhOgh5xE72W6DE40fFGvFhs/+WWQ6CjKU7H98RzCsnME4eLbAEH17QQmxxGMG9iUONAcHr33yrS6UWTR00s9E/gKWVauMqFj56vesQpDbwwMy6rhxPJwGdc88Kt4y6NrU/krkGA12+40IdP+gYMPS2TWdJMddSZTdZgCZ5u1uRlGIRWm1WHRTwpCbYQ3jztVti+Xah10m02H6eaUrvREqF8MsoO75BgA85jrvN1OLq2cGVdIQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(376002)(39840400004)(366004)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(66946007)(66556008)(66476007)(316002)(54906003)(478600001)(966005)(6486002)(86362001)(31696002)(36756003)(5660300002)(8936002)(4326008)(2906002)(8676002)(44832011)(41300700001)(83380400001)(8976002)(38100700002)(53546011)(6512007)(6506007)(2616005)(6666004)(26005)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1g3a0RYMDIva2VUa2hnS21TRkJWeDlEZzFEQ0hiTTlwU1hielFPb1E3dUJ5?=
 =?utf-8?B?akJlREcwOFlOVThtTXlNY3hsTzlVcWVMYzhwaFFNME9oK2dobzNxdzhHYnNm?=
 =?utf-8?B?c3RVak0yRTV2djZiMWF5emsvYWl5RXgrelR5eVQ0Sm5tZ1AxR1h3alM1MHJv?=
 =?utf-8?B?TEM0aTZwQm9JdXpZeXJJUHY3NU52M0VNR1hQYUxwdTVSSTg2TVRWc25CYjBP?=
 =?utf-8?B?SjJEcUxSb21GLzRKcE9RK3dnK3Y5SDZQQWlMSlI3ZkJhZzlzS2RxOW1QMytR?=
 =?utf-8?B?bHFTOVJLaW55dFBpNVZmSUpQUWREbE5JQU53b0EvQjFmaS93Wkwvcjk5QkVn?=
 =?utf-8?B?RlN3Q2Y0eldiSU1JRC9Vb1Q0NDY1S3poWGM0bi8wN0FUTENOZCt3ZmRhbzU3?=
 =?utf-8?B?OWdtcWpYczBkZkswOUFlUTk1M2F6M1dmb1JnMlNwNnhwSEdDTUEvemhzSzJP?=
 =?utf-8?B?WFdCdHVBUmVIN3J4Z1MwNkc4WEtjVkhkTng0K1BVNngranhVQVJoaWJFaDdF?=
 =?utf-8?B?K0Exakpnemw0a0ZWb3NOcEZDaDlkSkgyN0djY016dGhFOU1HYWNpWkYrWFRN?=
 =?utf-8?B?U3hTUVp2VzdYZVpNR1ZpNXBucU44T0VrR1E4bEVaWFBPWWY1eDFZaVVJcm15?=
 =?utf-8?B?SjdQd3JLcEh3bjArL3Z2RkVZTUE3czB0cTZiNC9XQnBjYnN2UHpYcXVsa1Vo?=
 =?utf-8?B?SWFZeStWclpOYWl0OWhia1laUko5M1hpZWt0bC9hY0pGNm9TTnNNK205clhT?=
 =?utf-8?B?RVNOTTdaanRmL0VZVHFCU0tKemZ2UklYcThyNjBsN0JZWnQ1WTR4ZUkyWjhM?=
 =?utf-8?B?WmphNHVPbGdGeHIwNTNYL1dJSnFDQ3UrTTMrUU9ZNXJ1OElheUxLanU3U0Iv?=
 =?utf-8?B?U3RJMlFMekdQbkZOQUovb0d2Y3lTWXF1eFVhdDVuQVFjYXUxNU40dmVlUzRq?=
 =?utf-8?B?dXZoLzRHTkhDSUpyTFowRUVuMUxmMzB2ODBFVStCMVVIYkJqelZLVjBPZFNx?=
 =?utf-8?B?eDYrWUlCcFVzL0JPREkzanBDaWExZy8wQ3diRVQ2WFpRamYwV2Y3dURLcCtp?=
 =?utf-8?B?dkhpN3o3Tkd1Z0VvM2RFN2sxL0cwd1hBK1BDZEErMUxCNHNDTFlHdTVWUldZ?=
 =?utf-8?B?MXZIMnNYenRtY0JGdDVxdjhUNnYvWkhuM28rQzFtdDVBOUNlK3Y0d21SREtE?=
 =?utf-8?B?OGtsVitHVFYyVS9SNXpqbzE4OXFIQTAxSHBoTi9YNGRrQ1QveGxTR2xQaVdY?=
 =?utf-8?B?Q2VwRUhmZHhuVUN2U0ZkdWRtSXFNWlRqU3JTbGViMDVHS3JSeHhMbWFqR094?=
 =?utf-8?B?L3JFeThhSnNnNFNrZXZ1bk1XMTRSTjUvK2xkK3EwcEFDZms0NGl4bDhrWlU4?=
 =?utf-8?B?cmIxWDYrNlZkZzF6UFQycG5tb29iMFV2OUlwR3dQYnRLWHdTcnZwR3FOWnMx?=
 =?utf-8?B?MzRjZG80NXF5Vkw3SnZJSEFTNkUvak9EY3BwUzhVY1FGdUFodHBqQjJvcytT?=
 =?utf-8?B?SmVwWDQwUFB1NVVXaWNDMG1FaGFjcjQ4dnNJaHV4NDQ1TGkvcVFxSDRSOWw2?=
 =?utf-8?B?STNNajlvc0lwcUNocVRYYitrVkFwZVlYTmgxbWJNcmZkYUJLY2FjMk5sV2Zx?=
 =?utf-8?B?MFkrTHBucGRKdjVZcFNDQXk4ekRRV0RORG1HNXFZd2RBcTB2aVVVSGdnVUFJ?=
 =?utf-8?B?ck54Y3M3dDRTSUNhL3IxZ3dhK281UnJQbTgwSUxkNXZabHRaS01vL2Yya1hT?=
 =?utf-8?B?akJtNWU3Vm5KdVdGcGVaWjZvcGhFS3FjdzdKc2tyMkhUb2d3M0xlaFlHL2VZ?=
 =?utf-8?B?Tm5UcUJIcGtBMnE4RTUvM09TalhnaDdPRVoxMzY1ZDJkYkpaV0cyVjRpT1ZM?=
 =?utf-8?B?K0RwU0dDS2oxdk9YZTFTc2J2akxhTVMyZVRMai9CK09uYXpSN2xMdUk3UlVB?=
 =?utf-8?B?eXZPbHFNa0hydGtFZjM4YUxCeUVERXNjaVJHTm5BVDI1ZWxBOGJoMkg5NEo5?=
 =?utf-8?B?dzF1NTlaR0tjVlZpSkc1R1FnYVY2S2h5WFU5ZmFIZVNrQk55bjBqdG9VckZN?=
 =?utf-8?B?ZERjeEQyVWJCanhMQktWSDBRQkplNURvdy82Yko3OGx4WmdraFN0NjZsYTYy?=
 =?utf-8?B?SkpjRzVhRFkvdnVxczNYYkgvY0h4VmZJTmVMQVU5WTZFVExzTTNtMDUrekR3?=
 =?utf-8?B?UFE9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: ca7c8e97-4f19-4003-ec1f-08dbd3a8115a
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 09:11:40.3343 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zSY/bI7zmjwXGSm9U90e1Zw2t3qQ5K4eMUyutnOcWg2KCYjwZzbPFsbsfzqXV4fCYFSMG9nOOPWYRQ5fNodi0Cyje2WFF8ECZxt+drgtY0M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3631
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

On 19/10/2023 15.58, Marek Vasut wrote:
> On 10/19/23 11:58, Rasmus Villemoes wrote:
>> From: Doug Zobel <douglas.zobel@climate.com>
>>
>> Driver for the TI LP5562 4 channel LED controller. Supports
>> independent on/off control of all 4 channels. Supports LED_BLINK on 3
>> independent channels: blue/green/red. The white channel can blink, but
>> shares the blue channel blink rate.
>>
>> Heavily based on patch originally from Doug Zobel [1].
>>
>> I have modified it so it matches the DT bindings in the linux tree,
>> and also follows the linux driver implementation more closely. This
>> should address Tom's concerns, and also matches my goal of making the
>> U-Boot driver work with our existing .dts which is known to work in
>> linux.
>>
>> As our boards only have the R,G,B outputs connected, I have not
>> actually tested how the white channel behaves, but the R,G,B work
>> exactly as expected.
>>
>> [1]
>> https://lore.kernel.org/u-boot/1547150757-1561-1-git-send-email-douglas.zobel@climate.com/
>>
>> Cc: Doug Zobel <douglas.zobel@climate.com>
>> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
>> ---
>>   doc/device-tree-bindings/leds/leds-lp5562.txt |  63 ++
>>   drivers/led/Kconfig                           |   8 +
>>   drivers/led/Makefile                          |   1 +
>>   drivers/led/led_lp5562.c                      | 578 ++++++++++++++++++
>>   4 files changed, 650 insertions(+)
>>   create mode 100644 doc/device-tree-bindings/leds/leds-lp5562.txt
>>   create mode 100644 drivers/led/led_lp5562.c
>>
>> diff --git a/doc/device-tree-bindings/leds/leds-lp5562.txt
>> b/doc/device-tree-bindings/leds/leds-lp5562.txt
>> new file mode 100644
>> index 0000000000..4e0c742959
>> --- /dev/null
>> +++ b/doc/device-tree-bindings/leds/leds-lp5562.txt
> 
> Why not use Linux Documentation/devicetree/bindings/leds/leds-lp55xx.yaml ?

Because I'm not adding support for all the devices covered by that
binding, nor for all the properties defined there (and some of those, I
think, do not even make sense for the lp5562 but only apply to some of
the other variants).

> [...]
> 
>> --- /dev/null
>> +++ b/drivers/led/led_lp5562.c
>> @@ -0,0 +1,578 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Copyright (C) 2018 Doug Zobel <douglas.zobel@climate.com>
> 
> Why not port Linux drivers/leds/leds-lp5562.c ?

Because that would be way more work to make that fit into U-Boot's LED
framework than to take Doug's initial patch and make it build against
current U-Boot.

Rasmus

