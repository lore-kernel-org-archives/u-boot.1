Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBDD4C54E68
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 07:55:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6559F87F64;
	Thu, 21 Mar 2024 08:55:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="HCp7elnN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F10BA88049; Thu, 21 Mar 2024 08:55:00 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5FC68744F
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 08:54:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O3jkFapnuwdNxUsxGAr2urKudL77jmUWmOaG94Uf62a6QAa5oy9YCFhxkCj38mVrxzRHOhB/ziYVj2NRIPT2NTRJN3n1EeUqCyQPdUt0iG2Qqqfd/thHVtohyKM7GbisiKvUa5buK7hf1yzUk3ljOF2K6hUyB4snQ0KDCCbo8CSSx9eTuW2PN9+0ylpNuaU9HjaL5Xh4dKvanLWJ4ZRIHN2yh6XDzbabsoV9KtCnNcnyBZwWujsu5jwTiDBW6nR4BrfU4/AXl3sjJssJBRtTaldJjX5/lf/9VCoKTxt5sAjt58mltCe/bp0lJv8rAIAItt09RzPhZzb374MtnInJyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ZS3eaEXGOxqdHYjVoBLAi5eHt0risx7HlHWAefDMbE=;
 b=EWozeEXcv7V5ZNxdSQkn0SaaZ1aMMw1bBIyLjlgm8t3FIJRuGXJQAtvqxLm8SrovzGa/UlR0VPBfK+PdMvRtKTIwT4WWwgT/41FygOyZPZedXZz+NwHHkdm9dapRgvLiDN2zmIq4w0DBJpReq2iWRqPPYrg0Ssl+CpAMUORIQD9wkPNAAFmDSbFOj35hr9WmN7Isgx0Hgp9IHKRkB7IuzBN2E2bXWBnI71hLJtCWctFdEVPBwkQd9o0TtZclNF1c+40JC6xadogvLZJvl6J1S+w10omEZY5qMCqbiyNQmTVKnhNwppM9b2yLKrQMNLAxBik5X7lGjZmebgEQXtVAHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ZS3eaEXGOxqdHYjVoBLAi5eHt0risx7HlHWAefDMbE=;
 b=HCp7elnNW2MOsLEWwtognPaOMY2ZJ01CRUE2pMxI2M+DWdHB5qHUuca2Ecapd6zZueNNf0zWwEDRWILmgB58fDJOPG4t2KfHRS8jkP8qpi2Q/Y9OJkc+J9xVXVPmCwkIBFrBft4RG0XLgd9Z3ptFesycH9mUvkhjSkJAX/NthtE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by DU5PR08MB10580.eurprd08.prod.outlook.com (2603:10a6:10:51e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.31; Thu, 21 Mar
 2024 07:54:57 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::d003:60c0:6918:8a5]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::d003:60c0:6918:8a5%6]) with mapi id 15.20.7386.031; Thu, 21 Mar 2024
 07:54:57 +0000
Message-ID: <f4d3d1b0-d7f2-42cc-9d70-4da1da14ea81@weidmueller.com>
Date: Thu, 21 Mar 2024 08:54:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] spl: Introduce architecture specific init function
To: Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, u-boot@lists.denx.de,
 Lukas Funke <lukas.funke@weidmueller.com>, Bin Meng <bmeng@tinylab.org>,
 Chanho Park <chanho61.park@samsung.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Marek Vasut <marex@denx.de>, Mayuresh Chitale <mchitale@ventanamicro.com>,
 Nikhil M Jain <n-jain1@ti.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Samuel Holland <samuel@sholland.org>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>
References: <20240320131928.1836386-1-lukas.funke-oss@weidmueller.com>
 <20240320131928.1836386-2-lukas.funke-oss@weidmueller.com>
 <20240320143048.GU3442575@bill-the-cat>
 <3866627e-de73-dbc7-fd8c-bb2b0d11b5cc@ti.com>
 <20240320153316.GW3442575@bill-the-cat>
 <20240320154952.4ee9052f@donnerap.manchester.arm.com>
From: Lukas Funke <lukas.funke-oss@weidmueller.com>
In-Reply-To: <20240320154952.4ee9052f@donnerap.manchester.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0123.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::16) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|DU5PR08MB10580:EE_
X-MS-Office365-Filtering-Correlation-Id: ea66ab93-35dc-4098-6f6b-08dc497c33dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: acs32A96Gdicr8I7jJ9D0ITEK88Eb/yPNg8Pibnr7vjIerYzgSdGwpO/D62/b/p+ggW1De0ddAG/PdbgparJIVPjvhoBVKyqs+uShDVK8ycwwGAL7Xy/rc4hLNmBAgKFJeSFxfVLoJoa+SPGJ0SoHaQiXPF8+IglbPPRPPJSSysJwfXsqmzxxlO4uQNIz5NHdOqCFtf8OldXt8yhZZsCo2LZ7JKA5lEGbJmjIDzO9x/RYeGWWJRRIyIx+2EfK0Rkms8u2NGfN6o8hTvFHFuEMkYM5H0QeF3IxCwpJ5EHnjkAzCEMQlrIGSgQwl2iAl5u/nFRGobqRzmuSRVwOQTsCMuNUxwIdRwPWj68meYZuxyhdz3EZ6o9DCQAFeCCGcvnEmh2oWrt6xJw1RcwqfgjxMm9Wow+iigrovJ0e76rS2vvybNMgRaMmFyccWMz/NB9ojv4FfvFoaSZpHXUrRIMUqCYaIpgw9bkfzXJvFMHXCOFarRfnPvlFuBP9w36W0Hu1r+YrefL6d5+ZAc+cLu8/FhZywgnjQP9FSe11scOOQp530sT9a59/2+lXZ/rMbnTQl6fM15F5uuVVaHDPmX+JbMEXgbXnLMpj6TCdt1fGBTMrmmjfGTSktdHci6A7l3MJvMNCtLiZsJc4AdxLpCbWvMSmq0gKyydT7m/JpR0IEs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(7416005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjYrOEdvOEJLY3RFK2QyOTlWRS81U056bUt2SnlXY2xYOWZQRnQ1UEkxbnd2?=
 =?utf-8?B?VXo1c1RodldyUlZxWUpTVWZxN09BbGRjYnVIRnM5QjBkVVdlOElsRFJsMFFY?=
 =?utf-8?B?NXYybjAzeGtuczFkQVIxTk5GZEd6aVBOV3hRak1NdjgrWU1KSklRalYvWTZv?=
 =?utf-8?B?bGFIU0lvVmJGeGxmUE4xdzBCb3FBbWdYNitzYzhnTThBYjN4aXJqQUxKK1pF?=
 =?utf-8?B?bFNsalZNZ0N6SlluMEhiRUg0NVpEdCt5SUQwdEJTN2Q5dTBEZVZFZlFjQXJx?=
 =?utf-8?B?QktabGZQVi9MQ1g4NVdiTUFuemhoVFI2NnFRK2hlWUJ5bkZTdmJwNWZYR1p3?=
 =?utf-8?B?dDNpR2lVd2dUM1FIcUVXWUJUMERuYzNaZG84RmxCcmw2OXU3YkZMOU5iaXl2?=
 =?utf-8?B?bCtnMUZYcGx5SzAvYitsMzlJMHJUNWx1NVd1dHBYeDZZS2RkcWJONHBCOUJj?=
 =?utf-8?B?U0p0ZHJRUjFCOVJWL0pmZlRZUWJPemhMeXFtTDNqZThncFZ3S2swcjZ2SWdi?=
 =?utf-8?B?Z0ZIMndQaVY2YVVUZ0o3emV6c0ljWG1MRlphenVGM0t3WUxmT0JBL253ekcw?=
 =?utf-8?B?YVBRakdqQWRrbmZBZS8zSk1VcC9xTm1ramp5TUljb1ZtMTF6SWNYYk9nWEV3?=
 =?utf-8?B?Si9hU0dMMWdlRVVMSWtHSU00T3R5emEvVy9Fbng5QXc0RU5KS0xVYU1UOVpl?=
 =?utf-8?B?RVBRZFloTmZ1cWtjL21jRTNFUmFMSlVnSHNqRDNhOGovVmRtYi8zRm9rRVNG?=
 =?utf-8?B?dmhSZDZwMi9wTDNQc0pFb3dhNDdmUzR5Tk54QWRNVDRpMXhzRkZiVXBHOStC?=
 =?utf-8?B?SWk2TnpTYURMT3kzL3VITi9DZXBucVpaK2pDR0hzQVdzV05MTGw3bURZTmZ5?=
 =?utf-8?B?NTNWK3ZNZldmblJWOWhlVk9KeFFrMmtxRVVsbVRKMzZZQVNmZEt0MU04RXlX?=
 =?utf-8?B?cy81bkZjRmFRZWh0UkM5VTZmdkhLZ0JMaHhycjdSQUtxZ2J0ZWRoeXVJb1hy?=
 =?utf-8?B?SmQ5ZDFEOWoxRXdqZmNKM0ZmN3ZSYkFQRUc1WGNueTQ0d0F2em1YeW9QWmM4?=
 =?utf-8?B?a3hwaE5ydDExT1owYzBPMVNuQUNOTWR0K0ptYUs3VVd4QStCSzA0SThsRTUy?=
 =?utf-8?B?eUpiSnlSZ2E2QmdQZ0hYSVRUNmxDVUdsaVVFUkJ0bklIdTFkUDk2VHlTdUVR?=
 =?utf-8?B?V25LV1BBbHVTKzQ3WEptd0hyKzlpcklQdzQ1d0NGRHdva2pTSGJPZEJqRUpB?=
 =?utf-8?B?RXlMRjNlT3IxdHlmNFhUYkRMZUFSR1gxdFFPZ0NkQUpGRk01NnlTbzNBcUcv?=
 =?utf-8?B?dGt3QzhXeGcxOVNUdDNhWkIrUUlmeHVjN2FBMDNlUjVxMGFkdWlySyttc3Zx?=
 =?utf-8?B?MktVU29mQ0ZWSXhiMElGS1pISGZ3eVlyVW9wQkJVZHkyWlE0WmUyNkFHQmhY?=
 =?utf-8?B?c3JpVFlQMmhMcmRKc3FVUjB1cWJ5UXg2dXJPOXIwbnVZeEhxQitzSmZjSzVR?=
 =?utf-8?B?d3BKcE1KeEphS3JMaEI5aGV6cDhUMVVPQzVseks1R082Y0FobWpVcW8wQ0x2?=
 =?utf-8?B?dHdxQWJaVWFtbFlxR3ZISUYzdnRYelRLMEU2cEUyd2pQdDFtQnJyZkY5cFVM?=
 =?utf-8?B?bE1KZ3ZSZVcydnJqS1R2UEJ3NUFlZUIrQWpWa3JFcGdSNjU0ei9oSVhSbHl5?=
 =?utf-8?B?cW5vY0o2aEZRTGsvdXlQVHREcXM2M2VFbkpaM2ZlblNWVytwVW5ERG1UaDR4?=
 =?utf-8?B?RDRlc3FSaVJucVBaOGtKQk4rOUpBd1R1Qzc5UXRmdW5PQU1aYUR4MCtVQ2t0?=
 =?utf-8?B?TjhOVGdLRGV6bENwNjlhdHJtYWJWSGtVTWNJaG5PenpKS2FjVjNTVkdlbkMr?=
 =?utf-8?B?WHhlQUxXUHNtcEdQWldQOVQxMFR2YkJFdGxCNlpDNGZTdzF3YXpVZTFxcmVN?=
 =?utf-8?B?VlNzMFNqSVU0alRLdzRtQytnTTM0dEZJbzE1a1Yyc1FreEdzb3NkcnFBQXZP?=
 =?utf-8?B?aEwzRUcwNll0S2tHUUdyMng5VGJwbHFCcU1maHBENFl1bmxGYXlqbkx6NExm?=
 =?utf-8?B?NmRrTHpoRHdnTHc4TkhwQUllNVFoME1haTdLbmJ5ZHo1bzB2RzRJR1pxTXFD?=
 =?utf-8?B?Z3Y0SENLMW1VMHZCbmV6bkh5dHE4WXJraTlCeXZDaGhGa1E2cmcwcmlxZ2pu?=
 =?utf-8?B?OXc9PQ==?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea66ab93-35dc-4098-6f6b-08dc497c33dd
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 07:54:57.5822 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ld3jnBReai3TwgjrvqTNt1aN3oblMnVgQidqDaXXgSjGM3bvao3DsEKXKJRp7JDdKWNgw3h5TWKm2ROC4O6pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR08MB10580
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

On 20.03.2024 16:49, Andre Przywara wrote:
> On Wed, 20 Mar 2024 11:33:16 -0400
> Tom Rini <trini@konsulko.com> wrote:
> 
> Hi,
> 
>> On Wed, Mar 20, 2024 at 08:52:30PM +0530, Devarsh Thakkar wrote:
>>> Hi Tom, Lukas,
>>>
>>> Thanks for the patch Lukas.
>>>
>>> On 20/03/24 20:00, Tom Rini wrote:
>>>> On Wed, Mar 20, 2024 at 02:19:26PM +0100, lukas.funke-oss@weidmueller.com wrote:
>>>>    
>>>>> From: Lukas Funke <lukas.funke@weidmueller.com>
>>>>>
>>>>> Some architectures use spl_board_init() in their architecture specific
>>>>> implementation. Board developers should be able to add board specific
>>>>> implementation via spl_board_init(). Hence, introduce a spl_arch_init()
>>>>> method which is called right before spl_board_init() for architecture
>>>>> specific implementation.
>>>>>
>>>>> Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
>>>>
>>>> I think this could allow for other SoCs to clean up their existing
>>>
>>> Does it make more sense to make this SoC specific then instead of arch
>>> specific to allow broader range of code?
>>
>> "soc" and "arch" are somewhat interchangeable at times, so I think we
> 
> Isn't "arch" ambiguous anyway? I connect that with CPU architecture, as in
> x86, ARM, RISC-V. And we have that in the top level directories: arch/arm,
> etc.
> But here it's one level below, isn't it? Where "platform" (or "plat")
> would be a more suiting term to describe a SoC family, like xilinx or
> sunxi?
> So the hierarchy would be really: arch -> plat -> soc -> board?
> 
> Or am I confused here?

No. But in some cases the 'platform' level is missing: for xilinx it's 
"arch->arm->mach-zynq-><impl>", for rockchip it's 
"arch->arm->plat->soc", i.e. "arch->arm->mach-rockchip->rk3399-><impl>". 
If we follow your proposed rule it should be: 
arch->arm->mach-xilinx->zynq-><impl>. Maybe this is an idea for the next 
cleanup round?

Regarding the patch:

I'd agree that the init code is not (cpu)architecture dependent. Some 
vendors init the console, some init the ddr, some init the leds and so 
on. Thus, we should go one level upwards and change it to 
"spl_soc_init()" if everyone is okay with it?

Best regards,
Lukas

> 
> Cheers,
> Andre
> 
> 
>> can go one step at a time here and bring in this abstraction and see
>> where everyone else is able to clean their code up to.
>>
> 

