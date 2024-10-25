Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD5B1D0C5EA
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 08:41:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B0FC88E88;
	Fri, 25 Oct 2024 10:41:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="DQMol8g1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D814F88FAB; Fri, 25 Oct 2024 10:41:38 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::62c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AF3588E65
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 10:41:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aAedMOv6czSAJOjmd3UT8ClG5v7bWtxqWJvS7a1NxqsldemKZqwOrDz2s04hdyxCg8T6nbqXUAVY4fy3PVbOFUFfIu037I2EKhIMk74UHpqvHhrFSxB7/pYwQvfB/5wyElbrvHKVv32YoqixC1CuJT3IZcHF6w7e5C5L8WI5wE34qWVdkUu/AaVrnJZSL2VhERmbi8zXEIzlRM+5DbilSmuYlQ44PV0tgMBUgSi/b5nCEK+A8ftohJEXBzIoWgKPtGsXAHmmpsM+6f8/pJOQWqdkkzdCCl68HBnFvLOmTXmDpVjvWi766i+27ogp+rt9tEWzf5QnYBCl3UzaHRDXvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AraBPm0XTD5tbuz+z9QH9ppap/3vnFKSfDSwmmxMVpg=;
 b=kY2BeUxicNkbDedd7M1yS8qSqN1hrnPgsb8h3NFoAKzzxZf54qbCkmuFIwd0InT4lQyLMbk1p0NdSMLVtxsSHmtxbLqNtaHKfSucZyWTCSvVeRxh9HvqSrdic4ApG7FnhwItFwWTm1JDvJPLnW8afXiVn4nSKodxZDzGD71Q3XbeitW5X6rxJuAdqE7U374Ah8klsDA3fwfPT87HPe81IffkjtkApyJsdtxjBrwJ3fAsarku1acaNJMnPBQVe+Ac44zHBDu+0gF4ZPcAIEi5JjYACmmLnDHLgv3bvk937Aha7HQwpKC0rRxfpNhIE5kpJwUiq53p0e4JP22y+V39HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AraBPm0XTD5tbuz+z9QH9ppap/3vnFKSfDSwmmxMVpg=;
 b=DQMol8g1hgTmbKzTUx525W5vtOfdMQVTNhKpIuH7lZ/8JkIdHrjZpPEI8JvOtDH3HcKRu56wrYE/Hm+LgMsyD3ANiwU5T2S+a1sS42VovwgL0rf+urfrZKluBuaEr/T0sDo788/STGOYMNfQvjNy41/8kqawP9Bs0yg367FQPdA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by DU0PR10MB6509.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:407::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Fri, 25 Oct
 2024 08:41:23 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%5]) with mapi id 15.20.8114.007; Fri, 25 Oct 2024
 08:41:23 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Marek Vasut <marex@denx.de>
Cc: Tom Rini <trini@konsulko.com>,  u-boot@lists.denx.de,  Tim Harvey
 <tharvey@gateworks.com>,  Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH] imx8m: set sane default value for SPL_LOAD_FIT_ADDRESS
In-Reply-To: <9cbc17e9-3ed8-4bbe-b5c5-096b8a75747f@denx.de> (Marek Vasut's
 message of "Thu, 24 Oct 2024 18:13:36 +0200")
References: <20241024100145.841964-1-ravi@prevas.dk>
 <58754a24-eb1a-4306-a5de-e990539b1717@denx.de>
 <87seslprkk.fsf@prevas.dk>
 <5b9d07eb-14f1-4ac8-bc3f-69cdd8b87a73@denx.de>
 <20241024152019.GS4959@bill-the-cat>
 <9cbc17e9-3ed8-4bbe-b5c5-096b8a75747f@denx.de>
Date: Fri, 25 Oct 2024 10:41:27 +0200
Message-ID: <878quclglk.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0029.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::17) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|DU0PR10MB6509:EE_
X-MS-Office365-Filtering-Correlation-Id: fb7574e7-8427-4bc0-fd64-08dcf4d0ce3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BDPwTmW84/9vrEbwnMAuJcoyaHl9vyztc8NyEF4b9kGZ6OOnvyUxxq84G7Qf?=
 =?us-ascii?Q?tgPmLI5DCXXJJG9dms0gbd8jV2Y8trd78yxBbr0YNkocbCLgWwcyqpQrkIP2?=
 =?us-ascii?Q?dho82AlACZc4Tio9rCu9suKrEPs9wybOUDThLbI/frEeMfLUYBA9mBEmZKRA?=
 =?us-ascii?Q?7LXPZtnMZPG/PehTUbIDquEeSGszmyf0RFVdvP+NZ9uStY0Fqvlqhmj6Mj9F?=
 =?us-ascii?Q?Pk3qpZOw1zkTcxnSpQEvbThFCMrDb8hPj3S+XUDvdH6pmH0TMxCiLsI5eG6h?=
 =?us-ascii?Q?NxPrqaNYVbXWKBcEucOVndNJPZ+SkSQZdRnosYmb8jZgTj5QAy86xEuL8MHF?=
 =?us-ascii?Q?+Tw1f+KBPJVBMtzCuR3XALSyFYG2ef4NCfMzlsSrr7dT0SATODFwt5ISBhim?=
 =?us-ascii?Q?V7TTE30UEBZPGpDhp0w8RLdB97D8GQStj7ePPNFepQ96sMvL5yvINtxnu8dA?=
 =?us-ascii?Q?UZTY7WJGFyamOyjpO1AUJgduEDZHZFLDh1gy3ejYR2RpOmkuika2VhRzGCVE?=
 =?us-ascii?Q?vDWuwweGqFuB1jnK1+tRktq7DtwWcdG4QxuHPIjvwl1QHEfLgXgXKyTLv2eL?=
 =?us-ascii?Q?RNIiiXkky4ujQCouUWv4mGDe/Uf06wG8irNmagFsxrM87DbzlzdcXrsZdSwB?=
 =?us-ascii?Q?PHvpTbyts/dxWChi0NysdwGUSelhqqT9bO8IdfR4JYnw4zLt5s4SF0LRLshV?=
 =?us-ascii?Q?bts/0pHwhFq3W7Ew7BMtfXXzv5Z6xfQL8Uqm5wmPUVFCZySHnQ2qZ7Dpr0Mt?=
 =?us-ascii?Q?7ME0V7j1Tiu2P7e5oZCa2Wc4UZuW05/qgbCxmduvPXf4fYWTO+tzQ3mYR2Gw?=
 =?us-ascii?Q?vxO9EGewtU/GmDi0ski9s2hJSWwJZNVECffvIeYz/5LgONnh10d36ytI36Ai?=
 =?us-ascii?Q?vV2aqpX5qylijJLOSiaiAlzrmyd81Qq5c6I8IL8RyWV09C0glCB1EuiurZaq?=
 =?us-ascii?Q?yohwYDCGy6fSU8NfBLNqt6oqEFYIJp0IQDbmAq5J0Xtm1YCFXur4oBPUy2AW?=
 =?us-ascii?Q?TXgoFfwwpixKxMDd9JKvSYfRgPYOHnIHihrDfAssj/+QL58ahdxd4hUaOYjq?=
 =?us-ascii?Q?0wRPl7MgmEpSWI3JcaeeXrrTbfveD4RfTQ4N6BMwwIF6+VksiYdz8hhgvRIH?=
 =?us-ascii?Q?GUtjLYIgsbUMAb4Mzwi80cgNGH9XACX8Ydp/NBZuvUT5KzfeLEBzUyrV9mkF?=
 =?us-ascii?Q?4EieIyfnb9h7JImXmHHh0aLd55LrHED8vcsi8u8syJusuN3Hz4zXZ3ILb0GW?=
 =?us-ascii?Q?vVxE6m+R6idrHj5We8BCb1KcUJC5Hws0lqfHiVrSshAT4B5fDeZL3PBHgPNy?=
 =?us-ascii?Q?AB4OJPdoAoPkI8fO7dh4XKP6hU8KBFA3RKtS69imEM9IvhI/lN5qfdRAo9Ba?=
 =?us-ascii?Q?quRfWMA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dWlrLvXAJZ2hxMe5tvbR/tHlmlNLIXSa36So4CP5FKme+q2dip/oCi0cNEEv?=
 =?us-ascii?Q?30qXZvaMn0ZYKHlx51jkzS+MSMdJFxzelg45Lvi4yd3b7snkAtTMfGZLzViJ?=
 =?us-ascii?Q?AzqA3zjzIcImUl8LlpjfFmT68HLJJMUhw+45OD/uuJY5YhfNL1ve9QgUt4EM?=
 =?us-ascii?Q?DTETZNaeMoqO9uhHeby9PaJQWMtHyI2cxqw1A2QUDFJTnxDeio8c0LnpiAh3?=
 =?us-ascii?Q?FoTl65DoEf2tqVI4qEU43nukW4s+P4QdyREf8hxldpwuS4RQTWN+kCSXXSTq?=
 =?us-ascii?Q?dwjQfuaFcO95fqFMpb9bKWWlQHvEUWb10Tc/3b49rxfSmxLYXC6WfbaNULON?=
 =?us-ascii?Q?fQUYTDRZOiUbXlptixnP75lIcyfMYzOSeBQe3SLzBDjoFzLEKj9WeQMvK4/e?=
 =?us-ascii?Q?NtUiOxlR8qiKI2ygLy4MGJR1Bl31lhPddgHGsb6lTmuNr1uElT1LZA3oRgTl?=
 =?us-ascii?Q?J1K1+uhi+lc91pBBS0AFMlLT+3EZRH6N+o8KR2b2CPtJPyx2UZKOp4pT3KaU?=
 =?us-ascii?Q?SSK3CNZ0nhH57vul3n1vFA4uZnafw5nuCSwIn+MRJvnGLjECxMwZIbNN+01K?=
 =?us-ascii?Q?jjVn0xWeVZcB/w174Oo9H7PM/wWgO1LMBqcjz/Et5DHV9sCSOxIqPqM1AcVz?=
 =?us-ascii?Q?YIpt8EX1dZ146iT1NBWFqHWqcXA51KHCgkJMnxAcvjey5sVplBbR7VGTKrGl?=
 =?us-ascii?Q?knSdY57RTxvCm7CXQhiWnePx0VjBqX2v+wRShooG2ZDpBAKW9vg+IGz3cvDi?=
 =?us-ascii?Q?fwJ7kXlhJdDit4FMcmbLLoB8O5H0Zkf38VV4+DKJOXmuMbW+CUhMkYoUO7n9?=
 =?us-ascii?Q?6bzLECDS6E2cbJZX+z4TmBr5NNffSLxCcQO4fJRK9/+xenD8a9d7QusMTwu7?=
 =?us-ascii?Q?TScKKKcYrEalSxMBTBknZhOi0sUYHOye4hEXayCiJavIhRy15uGUp9Kwlp9t?=
 =?us-ascii?Q?HiJoqPv5L+GRvSFKsJOQImfE9uZ8K8BP4cgFjcmObn26TBSu1+AwI0ibt2Qa?=
 =?us-ascii?Q?urM/RY9aR93ntYO3T5orix56/o6lyqtyDhRPJagfeL169U2auGaiuyU48qJQ?=
 =?us-ascii?Q?CkdhxKZvy2wJ4eJVooVtYvuKv8G/qqvFMU3KpliGnSxZ9EtUefkalGDjJLj1?=
 =?us-ascii?Q?YUjAVTU0v6C5XEWfZuN4ONPZWaw/TLHO7PPFhYSQWixGn3p4U45CfYYI6B/x?=
 =?us-ascii?Q?fREIDdSwZg6+tMesJ73+9cT2wp7ODykNa2xNelcAHQQELW3c7pV87VcPTjC+?=
 =?us-ascii?Q?sOGDbmbl5/ILm3X/ZgCSwiSPVjAMPVtAj4zkIlq8PAkieXfGq7f47zzSoGq1?=
 =?us-ascii?Q?Ozz7x2r9y+qoiEEfV42VadxHzuuZYhy1ruZMUjqBKW5/0dfvh8khQ3cinWd/?=
 =?us-ascii?Q?spwFtiobOgNKPSP8NF3gg5aLuMOiJWk/9rrAOhCt+u2SFRBIpOr1QFQ5xLxv?=
 =?us-ascii?Q?9JGHeVbC6pAeaSQv7045/G8d0JxAwYDbPUb+GfK6Oj6MBgi98DYJLkNE2HzZ?=
 =?us-ascii?Q?S5bsieAsfZPK8QU5JXqrrG0YNhiBmg76MmvNTv+0WKulvytoc1w0PfY88cLm?=
 =?us-ascii?Q?cs45Binmam9l2fL+Ip85QNXqu3T8Sf0BQiHHFPYkSeQWRQS83jqnuI+DJWvv?=
 =?us-ascii?Q?8w=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: fb7574e7-8427-4bc0-fd64-08dcf4d0ce3d
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 08:41:23.2020 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S8khTpIifa0LDseP0WArsBY6eRQcvtiL+IAqss2iO7jMvM/i0A9SdVow46oH6qtKWII8tcC42U627sjkUekM8NcWrgdK+rCG9Xsbrln6CaI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6509
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

On Thu, Oct 24 2024, Marek Vasut <marex@denx.de> wrote:

> On 10/24/24 5:20 PM, Tom Rini wrote:
>> On Thu, Oct 24, 2024 at 04:06:03PM +0200, Marek Vasut wrote:
>>> On 10/24/24 3:18 PM, Rasmus Villemoes wrote:
>>>> On Thu, Oct 24 2024, Marek Vasut <marex@denx.de> wrote:
>>>>
>>>>> On 10/24/24 12:01 PM, Rasmus Villemoes wrote:
>>>>>> I enabled IMX_HAB on an imx8mp board, but even though I knew about the
>>>>>> implementation, I forgot that I had to provide a sane value for
>>>>>> SPL_LOAD_FIT_ADDRESS. The help text for IMX_HAB doesn't mention this
>>>>>> implicit requirement, and there's no build-time warning; the default
>>>>>> 0x0 value just ends up being returned from
>>>>>> board_spl_fit_buffer_addr(), obviously resulting in a non-booting
>>>>>> board.
>>>>>> The existing imx8m* board configs that set a non-zero value
>>>>>> currently
>>>>>> all use 0x44000000. The actual value doesn't matter too much, but 0 is
>>>>>> always wrong for imx8m platforms. So just use 0x44000000 as default
>>>>>> for those platforms.
>>>>>> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
>>>>>> ---
>>>>>>     boot/Kconfig | 1 +
>>>>>>     1 file changed, 1 insertion(+)
>>>>>> diff --git a/boot/Kconfig b/boot/Kconfig
>>>>>> index 940389d4882..72d1f69afcd 100644
>>>>>> --- a/boot/Kconfig
>>>>>> +++ b/boot/Kconfig
>>>>>> @@ -231,6 +231,7 @@ config SPL_LOAD_FIT
>>>>>>     config SPL_LOAD_FIT_ADDRESS
>>>>>>     	hex "load address of fit image"
>>>>>>     	depends on SPL_LOAD_FIT
>>>>>> +	default 0x44000000 if ARCH_IMX8M
>>>>> This only applies to HAB , for non-HAB the fitImage can be loaded at
>>>>> arbitrary location, do you need:
>>>>>
>>>>> default 0x44000000 if ARCH_IMX8M && IMX_HAB
>>>>>
>>>>> right ?
>>>>
>>>> On IMX8 without HAB, the value is not used at all AFAICT (otherwise the
>>>> value of 0x0 would have caused trouble already). I don't see the harm of
>>>> setting some sane value that's actually within DRAM space independent of
>>>> HAB.
>>>>
>>>> Making the default depend on IMX_HAB has the UX problem that if I do
>>>> "make imx8mp_evk_defconfig", then go about tweaking stuff, then do "make
>>>> menuconfig" and enable IMX_HAB, SPL_LOAD_FIT_ADDRESS already has the
>>>> bogus 0x0 value and nothing forces or asks that to be changed. Making the
>>>> default depend only on SOC (or SOC family or whatever IMX8M is in this
>>>> context) makes that problem go away.
>>> Looking at this closely, common/spl/spl_ram.c does make use of
>>> CONFIG_SPL_LOAD_FIT_ADDRESS too, so I think yes, we should have a default
>>> for this.
>>>
>>> iMX6 should have 0x14000000
>>> iMX7 should have 0x84000000
>>> iMX8M should have 0x44000000
>> These differ, slightly, from the value used in CONFIG_SYS_LOAD_ADDR.
>> Could that not be used (and the overall option changed to default
>> SYS_LOAD_ADDR ?
> If I recall it right, no ... these addresses are where the fitImage is
> loaded and where HAB does its authentication stuff on the fitImage,
> that address has to be fixed and well aligned.

Yes. Fixed certainly; I'm not aware of any specific aligment
requirements, but I can't imagine it would need more than 0x1000
alignment, and we'd never use a fixed address less aligned than that
anyway.

> The SYS_LOAD_ADDR is
> the destination address where the u-boot-nodtb.bin is copied from the
> fitImage AFTER the fitImage was authenticated.

No, I don't think so. Isn't u-boot-nodtb.bin just copied to the value of
the load= property in the FIT, which is CONFIG_TEXT_BASE, aka 0x40200000
in the imx8mp case.

As for Tom's suggestion to make SPL_LOAD_FIT_ADDRESS simply default to
SYS_LOAD_ADDR: Perhaps, it would certainly be better than 0x0 which is
almost always bogus. I think it would work for imx8mp_evk, though
0x40200000 and 0x40480000 are only 2.5MiB apart. But I have no idea how
many boards would be affected by such a change or how many random ad hoc
other CONFIG_FOO_THIS_OR_THAT exists that might or might not clash or
overlap. IOW, I'm not signing off on such a patch... But it could be
interesting to a least let CI chew on that to see if it's a complete
non-starter.

Rasmus
