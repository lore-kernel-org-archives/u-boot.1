Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A37E2C5AD4C
	for <u-boot@archiver.kernel.org>; Thu, 23 Nov 2023 20:45:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0ADB886C83;
	Thu, 23 Nov 2023 21:45:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=kernel-space.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=kernel-space.org header.i=@kernel-space.org header.b="wEUPXV+A";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b="hezt6Yty";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2609C87499; Thu, 23 Nov 2023 21:45:33 +0100 (CET)
Received: from mail.kernel-space.org (mail.kernel-space.org [195.201.34.187])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE1588622B
 for <u-boot@lists.denx.de>; Thu, 23 Nov 2023 21:45:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=kernel-space.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=angelo@kernel-space.org
Received: from kernel-space.org (localhost [127.0.0.1])
 by kernel-space.org (OpenSMTPD) with ESMTP id 741c3159;
 Thu, 23 Nov 2023 20:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kernel-space.org; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=s1; bh=jw
 j8FPecdf928c/6bwPZ7OrB7ps=; b=wEUPXV+AAZGwowAUj2e+Qg2i+CqaUmCCWy
 TSiSuJfCikRRKmL6DylWf4ot83TC8XhQSQkSwtHE+9uac9lNAPhYS4Ju8uXPFooP
 eJMUWbnlpA1+8KCPFz8qVv7IlWldB3v6lUIFrCoMjC43hKcjibQAWr+Yg2LvVBD7
 p8u8ExOr4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=kernel-space.org; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; q=dns; s=s1; b=
 zXmr3175oYKc1+sGcVTJFY9dQYPJ9nmEpUw78EDS2/AemoGTJqgdtCuSOZ8ZS4hs
 vhV5XsPargCtBqLsJVa/56ScPWFSo8cp1ubAr5fEe2REa616mwlCDzSKLqwknKUV
 jh8mmp52nEd1o3NLH7rILrVdR+hhdbDKPEkxu2B5q3k=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
 s=s1; t=1700772324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ftUhLfihG7BT8CUITeESFt1T08QYAk6Q0W9Qn9NkZPI=;
 b=hezt6Ytys2kqTrG1yQc5/q0FT77LA+oOZOfKqt7LDTZovTEq9DLNdrdyUo1nLvXC4zvv+P
 4F/vBxkrXNXIWYvzoHmBW9T2n6UTyPSJ4F3be6n/Y5TmUEC/jaDavbB/m3ypqssg6ymk8C
 d3aDv5Js1fiuibfC5ysjmDYoJWGyeDA=
Received: from [192.168.0.2] (host-87-1-222-220.retail.telecomitalia.it
 [87.1.222.220])
 by kernel-space.org (OpenSMTPD) with ESMTPSA id 9381caf5
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Thu, 23 Nov 2023 20:45:24 +0000 (UTC)
Message-ID: <cf41bc6d-b27e-0ecc-35d6-43a36c602c46@kernel-space.org>
Date: Thu, 23 Nov 2023 21:44:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.0
Subject: Re: [PATCH 04/11] m68k: Rework asm/global_data.h slightly
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Huan Wang <alison.wang@nxp.com>
References: <20231122131154.2444690-1-trini@konsulko.com>
 <20231122131154.2444690-4-trini@konsulko.com>
 <8d7b5e58-031b-d3bd-7270-b19c8e2a13cd@kernel-space.org>
 <20231122210903.GT2513409@bill-the-cat>
Content-Language: en-US, it
From: Angelo Dureghello <angelo@kernel-space.org>
In-Reply-To: <20231122210903.GT2513409@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Tom,

sorry, i have difficulties to get the full patchset,
was also looking into patchwork, but seems not updated.

Anyway, i applied patches one by one, all is ok.

Acked-by: Angelo Dureghello <angelo@kernel-space.org>

On 22/11/23 10:09 PM, Tom Rini wrote:
> On Wed, Nov 22, 2023 at 10:04:38PM +0100, Angelo Dureghello wrote:
>> Hi Tom,
>>
>> thanks,
>>
>> On 22/11/23 2:11 PM, Tom Rini wrote:
>>> In the architecture global data, replace the one case of u32 with
>>> unsigned long. Now, we can drop config.h here but then do need to add it
>>> in two m68k-centric spaces.
>>>
>>> Signed-off-by: Tom Rini <trini@konsulko.com>
>>> ---
>>> Cc: Huan Wang <alison.wang@nxp.com>
>>> Cc: Angelo Dureghello <angelo@kernel-space.org>
>>> ---
>>>    arch/m68k/include/asm/cache.h       | 2 ++
>>>    arch/m68k/include/asm/global_data.h | 4 +---
>>>    arch/m68k/lib/traps.c               | 1 +
>>>    3 files changed, 4 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/m68k/include/asm/cache.h b/arch/m68k/include/asm/cache.h
>>> index 8ed2b4dbab47..6ef7f7be1af8 100644
>>> --- a/arch/m68k/include/asm/cache.h
>>> +++ b/arch/m68k/include/asm/cache.h
>>> @@ -9,6 +9,8 @@
>>>    #ifndef __CACHE_H
>>>    #define __CACHE_H
>>> +#include <config.h>
>>> +
>>>    #if defined(CONFIG_MCF520x) || defined(CONFIG_MCF523x) || \
>>>        defined(CONFIG_MCF52x2)
>>>    #define CFG_CF_V2
>>> diff --git a/arch/m68k/include/asm/global_data.h b/arch/m68k/include/asm/global_data.h
>>> index 5f576ba16f9a..c2ef5770a3df 100644
>>> --- a/arch/m68k/include/asm/global_data.h
>>> +++ b/arch/m68k/include/asm/global_data.h
>>> @@ -7,8 +7,6 @@
>>>    #ifndef	__ASM_GBL_DATA_H
>>>    #define __ASM_GBL_DATA_H
>>> -#include <config.h>
>>> -
>>>    /* Architecture-specific global data */
>>>    struct arch_global_data {
>>>    #ifdef CONFIG_SYS_I2C_FSL
>>> @@ -24,7 +22,7 @@ struct arch_global_data {
>>>    	unsigned long sdhc_clk;
>>>    #endif
>>>    #if defined(CONFIG_FSL_ESDHC)
>>> -	u32 sdhc_per_clk;
>>> +	unsigned long sdhc_per_clk;
>>>    #endif
>>>    };
>>> diff --git a/arch/m68k/lib/traps.c b/arch/m68k/lib/traps.c
>>> index c283351181d8..2a025c5a6e86 100644
>>> --- a/arch/m68k/lib/traps.c
>>> +++ b/arch/m68k/lib/traps.c
>>> @@ -7,6 +7,7 @@
>>>     * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
>>>     */
>>> +#include <config.h>
>>>    #include <init.h>
>>>    #include <watchdog.h>
>>>    #include <command.h>
>>
>>
>> testing this getting some errors
>>
>> +drivers/watchdog/mcf_wdt.c: In function 'mcf_watchdog_init':
>> +drivers/watchdog/mcf_wdt.c:43:26: error: 'CFG_SYS_CLK' undeclared (first
>> use in this function)
>> +   43 |         cycles_per_sec = CFG_SYS_CLK / fixed_divider;
>> +      |                          ^~~~~~~~~~~
>>
>>
>> Seems solved by
>>
>> diff --git a/drivers/watchdog/mcf_wdt.c b/drivers/watchdog/mcf_wdt.c
>> index b555bbeb68..f5ff221dd5 100644
>> --- a/drivers/watchdog/mcf_wdt.c
>> +++ b/drivers/watchdog/mcf_wdt.c
>> @@ -11,6 +11,7 @@
>>   #include <asm/io.h>
>>   #include <wdt.h>
>>   #include <linux/bitops.h>
>> +#include <config.h>
> 
> Did you have the whole series applied? That is a reasonable solution,
> but I didn't see a failure here, thanks for the report.
> 
