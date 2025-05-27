Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35C94C54F30
	for <u-boot@archiver.kernel.org>; Tue, 27 May 2025 10:01:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DD5682FAB;
	Tue, 27 May 2025 12:01:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="KdZyDG8c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1887682FD6; Tue, 27 May 2025 12:01:23 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::601])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 720CF82F8E
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 12:01:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W3uu6MBQw0SFNtJpYW/7wsUG0OdVIisPe9IBgZMhq0wFqYBh9tJHEt087XXU4NaSTjOmUav3rSby3GzZ281HDOKCTbh8EvWPu8kwtbHkGRRSoXQArm4KRZS6jGidRam+HXioc+OUfzLKKyXNunqABADpN4XAJR5/UXhgTj6lvW0Vl/WKBE/zaUQfSZqa23YjPbCJoKlch9PmKTzYLAVTIopObVUa6GNSQzxkeJwZuI/C7iv45OYhZuXy0dts7OIPmptaQQ6Oid1KNBr09iTJ5Su/fwSZfkXF+68zn5t6p/dsQQgbvoFPSCLSxcPYDgM2Lzu0P+EScfwv6ooxRgG3Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sE7HsNWItm4ic6OSF51tN435IPvDGuu+OTxUvy9CU4Y=;
 b=SXovx8His7vsT4xWQyuuryS4xUbwokCvl04kuX499qkPOQCkjKMt5UK9e1swGcyQVLMvXcD+fR3/1fRyahk64ryCucejXoVpWC79gXtqxHQ0fVb/cPs1djRUSg0f2VUgUsHCvWgpz5B0PT2AuvWjn4Qjwcrd3CL5y6O4Hzvnl177ua7SJGT9WNtosnQuRrNibjnwJT3bkPA3R5YZfLSu4udp+qYWnVR8kHkWC+7pB2kNr4kYiO8uiAXS4NsIj7y8NK7v3nWo2DMhMCsRNoB+VwALHDZ5C92XUFExNUZ7a/q/ICDPyyYfAt1FA3YMzrFcWIbf8aGldH6s0Nc70sZi7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sE7HsNWItm4ic6OSF51tN435IPvDGuu+OTxUvy9CU4Y=;
 b=KdZyDG8c7t56yGqxjRieNlz60aleJmewdvcyEq8oQReYzkNZx1RDdms6Rkk4eLd4ZeFM7dnsgVoP5NPbE2WNbYjWjeQHP1oV6NkUb+H1tIbvI+nhm3Y2pUj2+48kvt5w2bdJPWyxkipAH1imSQZlqC8BktR3Bh4QSU3EoUyJuTI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by GV1PR10MB6346.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:89::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Tue, 27 May
 2025 10:01:09 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.8722.031; Tue, 27 May 2025
 10:01:09 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,  Daniel Schwierzeck
 <daniel.schwierzeck@gmail.com>,  Joe Hershberger <joe.hershberger@ni.com>
Subject: Re: [PATCH 0/4] list.h/treewide: get rid of no-op prefetch()
In-Reply-To: <20250526220155.GE100073@bill-the-cat> (Tom Rini's message of
 "Mon, 26 May 2025 16:01:55 -0600")
References: <20250507121246.518691-1-ravi@prevas.dk>
 <20250522165656.GB2179216@bill-the-cat> <87r00c3143.fsf@prevas.dk>
 <20250525230201.GS100073@bill-the-cat> <87msaz2i46.fsf@prevas.dk>
 <20250526220155.GE100073@bill-the-cat>
Date: Tue, 27 May 2025 12:01:08 +0200
Message-ID: <87ecwa2x0b.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0049.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::10) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|GV1PR10MB6346:EE_
X-MS-Office365-Filtering-Correlation-Id: d4939165-53dd-455b-4e5b-08dd9d0567ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|7053199007|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?l7lLJE0kMwi8YSxcscDOCjoHnYCLMnMr6G2W+RVFVVN9viHQLUtQS+hTt6E2?=
 =?us-ascii?Q?eV9o+f8exlyoFVv/KUW9fkNxG/R1kGZVducNuWwHZtJT58vSt36F4Ej0VaON?=
 =?us-ascii?Q?3K/hkbkj+QiyVKbECAqRs1LgyMOJlQxCWHP2ixIBvEKUiVlKAK94I7FNG/j1?=
 =?us-ascii?Q?WzjceWWbilkrv84ezrOKDjVVu8R9EMlWzn4GkAOrC4SxOEYJIDlRNrVU2DPK?=
 =?us-ascii?Q?LOCtfnc5GfC8y3+gaRrivTVdZc4inHAyLYo5T9iCP7QDdt7NvW55zqwz4KHG?=
 =?us-ascii?Q?/rn09YXm3xwd9wv+8PCX/9sztBtosTEnyQvyoIlzBhXyCLglrZ28iBnc9NXb?=
 =?us-ascii?Q?IbbZTXfLEiGmSIMKYWrRzsN8mir4ZhmShhOaiB5SHfm/mYdeVZNrYYfOG31H?=
 =?us-ascii?Q?28ilPSfpwz2Mi6Ufs9Mlc0kpauttlCXhIoKT+nZ0MKJgJ1MmyPs6VzBqMY7m?=
 =?us-ascii?Q?Gn7jiV5/D/BEBkwzwyPHpRAB8EYuNSXclgt6uxxMK9ARqcDnZZMtJy/DWXy/?=
 =?us-ascii?Q?SelMTWhmBJ3Y2VQXfvFGNoPIFEDwdxJRZb0HqxThIjTTU8jUcxk7OxH0qMwK?=
 =?us-ascii?Q?EzGRaGGnXEKB/jijZf0TfrF93swjhGg3XDO8NAdZ8Ht+trGjiEiD8PjDfAT4?=
 =?us-ascii?Q?Aa4Q1nfLDNv3ZVHFf+CD5WX6OxL2u2YuW6CYH/jaGcnEXvKuJCsHQKHMyS+v?=
 =?us-ascii?Q?9XIHiOQ+sF5ejocnEfkFQhiGncYorNqjgeZ/LHbrbAio1G3YZsYzaQexYTVI?=
 =?us-ascii?Q?Dzso+qTsvGr99hyUCZ+bWCLeDdZTxBlwEaQP+0BrcQcvZO+fSzJFerBTvyEA?=
 =?us-ascii?Q?zdC6M0KbAxEnz7Br/gYJDcg/rz4mWV6ybBp7CKxRomkhguNcYl354WuXp9c7?=
 =?us-ascii?Q?ME0hp2hGcmQzj/P/2Id1Eo+YaklNz+WQFesHPRbqTP8G51l05A1qizz7QCWO?=
 =?us-ascii?Q?/0fpOdK4NAQD/U7ZspsUB0Crcx/VUaRpD/0wVkqMKNiWkXm6DMhGH5T3yklU?=
 =?us-ascii?Q?/Bz89g1BHyYsU5yQwp/jDc7j3LhoYHyAZc7RHOBLXcc2d8XIbIPMYreWPaKJ?=
 =?us-ascii?Q?k2un+AWkbcQcj4xLcfJtD7rmL0RTFY3HI/tuwo0KAaeYfdDFq+JsLbytSSlf?=
 =?us-ascii?Q?BwVpMmcjewMnme6WrfqskO8WlhMJtoJb+zAyXh2/2bklkmCkQfJUoGc6RRWQ?=
 =?us-ascii?Q?2+XBIAP3LA+te7xQygjvkaW4Mw7pPlwi929UkrvZo61QCUE3jMKf6zN2zoTC?=
 =?us-ascii?Q?f0w5Q9LbaD0abLuxjFlE7S5EcLzzBPCRZMME9DuW7BNaDhWGH4eNZW3nl87U?=
 =?us-ascii?Q?VhX45QNFAsLwPFF36O//MTCiemOjVwdyYD1wMIA1lfy2kmquDYvmyG0DxSZZ?=
 =?us-ascii?Q?BkTgTCOKNogsy/9Ko0GeTtgu8eJJv+xSKPUJ1QiNELjMBhXKQkTU0SXRdtJG?=
 =?us-ascii?Q?//txfc7TILZk9SLr2fUFvGWiEkLDz7QmJSDq7j3qNfsjRek9u6yoHg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VEFG4XlzZ4gvOz4K+QyvlzC+LjjWcwcYqAD7/noNuVCJ05EU4wPb+J2c9AAF?=
 =?us-ascii?Q?P0o+AycAnBnZgKo9NPe0llJy4jTMI7WmxrL6weKQRAIfiboqBllT7IIEdDdz?=
 =?us-ascii?Q?ra0Do0nym+swDPS1ydirfzVD8BE2c06q+FpZFZvhkxWp9Aq8A7jEjkqih9KY?=
 =?us-ascii?Q?QL5C7jxfr3DewKue3WqDAPTMP7YKHKZWr99nF/pRDb+w65HvTUMR14A/epnT?=
 =?us-ascii?Q?nG8l0JRxdmRy6FuXIGPukHhPeOefYXoSA7VUtrPH9BwUBEjhVXuYyjjGiTia?=
 =?us-ascii?Q?TYy0d2Z0GX5jjbSXW6bS8PiDBhN1v3J/72tsQscwMXACIr97kdiTcl4eiYFY?=
 =?us-ascii?Q?D/7teGGf9wr/pu2kvh47AVUOHQbgarFVe+y8TEOxhk81uOW0030vbcMIZp6e?=
 =?us-ascii?Q?/l2tepSLPdEw5IJk+ao0/nMhuFvrtan5PjosNStu2mTOdwlGO5xh2b1v17Uj?=
 =?us-ascii?Q?CDOva+hJfLfALnlBDWqf7DxFUiYSJbODnyYwOz2UQubm+bU2lFA+wrc/X7qB?=
 =?us-ascii?Q?7E259FFATwAm7g+X0GbKMqe6j55/9jAqb+sFMW21dduDKl8S47cNd6hLwrg4?=
 =?us-ascii?Q?Nn4APsgWe89HScrF8qk1Ge8T2b2lJOVQYoRZ2jX+3zFe39YXVDEzuslQjIBY?=
 =?us-ascii?Q?n9anFGBLlDXAttETkuMiR83OenvGPmoqyX2byLSXRXuD9DjzqboRZyZAkqLY?=
 =?us-ascii?Q?JiHbGln7bbNan1sBFWW3Yr8OujoRGypZC0zE/BCvyuestTwz3xSAqIHvmxeV?=
 =?us-ascii?Q?Cbu8ypsxZ2pFWFceJO2fiCHIkJC5SfIY+fWczw91KTl/Dj/BqThE95XXWQJ0?=
 =?us-ascii?Q?Im2FienXRjuggiDg3Dfc59ryfjZKAfzyyY7vGExEMLLajYMfxPrbtjTxny/7?=
 =?us-ascii?Q?Rx6O4WPqr15misffuU+Dp/C+xX0t8WYdpYMBO36ZbHLucX3+qiS8Ep1aoB6l?=
 =?us-ascii?Q?WHuKmfo7tYP9Q6IRayJwekMT3UGcoaTuMqgsTz2CXnE3zni1LX4la9Jq5Yi6?=
 =?us-ascii?Q?9RsnM8BEOOrY7oFWXsgF/hFLYe4fY+ryIi7ryL3ZL1OsULRf5Zutr04GuX3t?=
 =?us-ascii?Q?JfZDKnku38ruSZ+Ufd+W1coYYOF1QYIxnGojp/dq9MU2LFKBvdQE9xk1qlf/?=
 =?us-ascii?Q?XvZW3ZrXqtKf4SKBrHFACq+e9oYp5UZskKRsocej5h59ydJcxfTBKl912iUH?=
 =?us-ascii?Q?GMSW52aj0AX/TEiN4XVpns8UP0+Db0hUkuSc3/fdWrwh+JbggAAHTIPyqfER?=
 =?us-ascii?Q?L3p+chJe3/JtpIPwu6yHbRTV5WDksOANRxn+5DLS89SPDnWNif3O40fR/cTL?=
 =?us-ascii?Q?UuI3v539t5t8HO45sDzGG1/LPhR2rLSV0AQFsTug8b+E0Te1iokMmvjKSpsA?=
 =?us-ascii?Q?NjordkfEfO34m231jEC5J/opd9u1U3IhCEx+YDA24/Qd6krLp3ii8Oha2n1O?=
 =?us-ascii?Q?gjEWa+HfMvUKl2z+kzQyylQdlHcicttQuVBbggG6erxmsTOwgnB4uYgLH3Nx?=
 =?us-ascii?Q?/eWLeF+fNPo9eLE7Ju5tRk0Ozfn5+M4wtjeM8NLxk64waUq4BnABefD8P/V8?=
 =?us-ascii?Q?B7ICm3nKRgWZFbMBjx7T6DQNJC9ebMenGZPuAwObev1P9ykAZz2eoOD6cuCH?=
 =?us-ascii?Q?7g=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: d4939165-53dd-455b-4e5b-08dd9d0567ac
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 10:01:09.8417 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J4r2ojkmtLi+2xszgGdtlxAn3QAbNi1fBkAULn5MXOrfSvgPbaPIK8TQYaPL1ULvcJ7z6/IPXAzpgurjTIjCzpuAHluLb2qgKkwD/QyPILE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6346
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

On Mon, May 26 2025, Tom Rini <trini@konsulko.com> wrote:

> On Mon, May 26, 2025 at 11:10:33PM +0200, Rasmus Villemoes wrote:
>> On Sun, May 25 2025, Tom Rini <trini@konsulko.com> wrote:
>> 
>> > On Sun, May 25, 2025 at 10:07:56PM +0200, Rasmus Villemoes wrote:
>> >> 
>> >> :( so we've been relying on that prefetch() laundering away the
>> >> volatile.
>> >> 
>> >> Which really begs the question: Why, exactly, is it that gd even has
>> >> that volatile qualifier in the first place? 
>> >
>> > The answer is likely early 2000s GCC.
>> >
>> >> I'm 98% certain that we could drop that and get better code generation
>> >> and avoid a ton of places where we cast away that volatile which
>> >> shouldn't really be there anyway.
>> >
>> > It would be a good thing to experiment with now and maybe try for real
>> > in a near-future merge window.
>> 
>> So since it's declared per architecture I just tried with arm for now,
>> and this
>> 
>> diff --git a/arch/arm/include/asm/global_data.h b/arch/arm/include/asm/global_data.h
>> index 45401d5e3c8..f7a47204b7c 100644
>> --- a/arch/arm/include/asm/global_data.h
>> +++ b/arch/arm/include/asm/global_data.h
>> @@ -133,9 +133,9 @@ static inline gd_t *get_gd(void)
>>  #else
>>  
>>  #ifdef CONFIG_ARM64
>> -#define DECLARE_GLOBAL_DATA_PTR                register volatile gd_t *gd asm ("x18")
>> +#define DECLARE_GLOBAL_DATA_PTR                register gd_t *gd asm ("x18")
>>  #else
>> -#define DECLARE_GLOBAL_DATA_PTR                register volatile gd_t *gd asm ("r9")
>> +#define DECLARE_GLOBAL_DATA_PTR                register gd_t *gd asm ("r9")
>>  #endif
>>  #endif
>>  
>> 
>> builds, boots to linux, and passes our test suite on our
>> beagleboneblack, imx7 SabreSD, RPi 3, RPi 4, RPi-cm4, wandboard,
>> imx8mp-evk; i.e. a good mix of 32 and 64 bit arm.
>
> That's a good set of datapoints, thanks. Do you want to post a real
> series at some point or should I do it and Suggested-by you? Thanks.

I'll do a series and let the azure CI chew on it before posting it for
real.

Rasmus
