Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC992E7717F
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 11:50:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E8DF8004E;
	Mon, 16 Dec 2024 12:50:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="MJGuYznw";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="k8NkBMaU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 415D28005B; Mon, 16 Dec 2024 12:50:39 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7E2E8003E
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 12:50:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4YBdYQ34Lkz9shh;
 Mon, 16 Dec 2024 12:50:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734349834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=drjPWeWVKIV7nipOoGaDj6wiSvuvKcrveKRsrGFCjUE=;
 b=MJGuYznwnHWI8S/54mYj7qpZVM0CUMtov22rj3eVXUnqSgoUqILjxIYaIfbdAsn0lkAsFA
 La/i8yL8yrQiXxDGijBkDnsvpa5Onpxmw5iC2ttScJ5sXEHznQqXV0yTNYeFCl4WQ8yZzj
 h9fQQSkJSMdiK8fCCMSHGJ/JH4EGkD+d4J1pdV/j67qLlHHb/CGDb1o3sFPhId88EbnbbM
 1ntke2lJ+W7zL6GgxOPB8wy5ewxyGljWy1h5rAYrpIqAQa5QjfL3W9zMpSjANQUyvpDMxp
 KZ74DhK/3AvZbaf5QPjdeqxagxf6eXjobCEf5Uhf3f0lIWF49uswEwZgdBwaIA==
Message-ID: <18cbc9d6-847a-49ea-9308-b1a6ee4ae920@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734349832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=drjPWeWVKIV7nipOoGaDj6wiSvuvKcrveKRsrGFCjUE=;
 b=k8NkBMaU/46skzl4h8JW1WNrCt7zrHLomGc3cG3AnGKbB0veaLryWhg+e5ERpQuX8NTPNc
 ZCdwIzKgWBwffXyK3VPXJEgL+9q4QNw7hBemGhUQmMtVkvyP5N7oRoMBHCdGwKSqGJWhmR
 zaTeQofIHtotJrOsUrb863gw8j4T+72x80hWwDMtFrf6aUeQJuXpVduSX3qZp+Bp70LGKB
 sjSpvlMFU73CSoKq4ktnjpuP9LicOUEMr8T1ZbkAa929a4O1/+yjbEBvXknbN4p0N4PeFg
 D7XNChwH2YB1+9oIV0yLAnAYSE4XOgGwppfNYqyyK4DbWrd0XST1QYU0Zy4OpQ==
Date: Mon, 16 Dec 2024 12:50:10 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] arm64: Convert core type check macros into inline
 functions
To: Biju Das <biju.das.jz@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Chris Paterson <Chris.Paterson2@renesas.com>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Tom Rini <trini@konsulko.com>
References: <20241214224344.303452-1-marek.vasut+renesas@mailbox.org>
 <TY3PR01MB1134681A786D500D575B1D2CE863B2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <TY3PR01MB1134681A786D500D575B1D2CE863B2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 860327b83004e3e21f7
X-MBO-RS-META: wp371ehrwdnfin1orfafcu35a8ipjsjs
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

On 12/16/24 9:54 AM, Biju Das wrote:
> Hi Marek,
> 
> Thanks for the patch.
> 
>> -----Original Message-----
>> From: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> Sent: 14 December 2024 22:43
>> Subject: [PATCH 1/3] arm64: Convert core type check macros into inline functions
>>
>> Turn the core type check macros into inline functions to perform better type checking on them. The
>> inline functions get optimized out in case they are not used. Indent the MIDR_PARTNUM_CORTEX_An macros
>> in preparation for addition of future three-digit cores and use MIDR_PARTNUM_SHIFT in
>> MIDR_PARTNUM_MASK to be consistent.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> ---
>> Cc: Biju Das <biju.das.jz@bp.renesas.com>
>> Cc: Chris Paterson <chris.paterson2@renesas.com>
>> Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
>> Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: u-boot@lists.denx.de
>> ---
>>   arch/arm/include/asm/armv8/cpu.h | 28 +++++++++++++++++-----------
>>   1 file changed, 17 insertions(+), 11 deletions(-)
>>
>> diff --git a/arch/arm/include/asm/armv8/cpu.h b/arch/arm/include/asm/armv8/cpu.h
>> index 40d54dc85ab..aa1470bb72d 100644
>> --- a/arch/arm/include/asm/armv8/cpu.h
>> +++ b/arch/arm/include/asm/armv8/cpu.h
>> @@ -3,11 +3,11 @@
>>    * Copyright 2018 NXP
>>    */
>>
>> -#define MIDR_PARTNUM_CORTEX_A35	0xD04
>> -#define MIDR_PARTNUM_CORTEX_A53	0xD03
>> -#define MIDR_PARTNUM_CORTEX_A72	0xD08
>> -#define MIDR_PARTNUM_SHIFT	0x4
>> -#define MIDR_PARTNUM_MASK	(0xFFF << 0x4)
>> +#define MIDR_PARTNUM_CORTEX_A35		0xD04
>> +#define MIDR_PARTNUM_CORTEX_A53		0xD03
>> +#define MIDR_PARTNUM_CORTEX_A72		0xD08
>> +#define MIDR_PARTNUM_SHIFT		0x4
>> +#define MIDR_PARTNUM_MASK		(0xFFF << MIDR_PARTNUM_SHIFT)
>>
>>   static inline unsigned int read_midr(void)  { @@ -18,9 +18,15 @@ static inline unsigned int
>> read_midr(void)
>>   	return val;
>>   }
>>
>> -#define is_cortex_a35() (((read_midr() & MIDR_PARTNUM_MASK) >> \
>> -			 MIDR_PARTNUM_SHIFT) == MIDR_PARTNUM_CORTEX_A35)
>> -#define is_cortex_a53() (((read_midr() & MIDR_PARTNUM_MASK) >> \
>> -			 MIDR_PARTNUM_SHIFT) == MIDR_PARTNUM_CORTEX_A53)
>> -#define is_cortex_a72() (((read_midr() & MIDR_PARTNUM_MASK) >>\
>> -			 MIDR_PARTNUM_SHIFT) == MIDR_PARTNUM_CORTEX_A72)
>> +#define is_cortex_a(__n)					\
>> +	static inline int is_cortex_a##__n(void)		\
>> +	{							\
>> +		unsigned int midr = read_midr();		\
> 
> Maybe unsigned int midr = read_midr() & MIDR_PARTNUM_MASK, to reduce one store
> Operation???
The compiler will optimize the result as needed, this expansion here is 
for readability purpose only.
