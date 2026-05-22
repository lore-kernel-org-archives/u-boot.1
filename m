Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51A57CD5BB0
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 10:31:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F905841D7;
	Fri, 22 May 2026 12:31:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="BLzbpcDK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1C7B843B6; Fri, 22 May 2026 12:31:24 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81AAF83FF5
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 12:31:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id EF8B23FB6F
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 10:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1779445881;
 bh=6INgl4djeFWQXewC1C5XZvZo3FV/zbQ+Ybua/PRqbXE=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=BLzbpcDKe1iJiywWXiSmFQDGF3myocCMdtsbRuAKmraFzdPfr4nQXkAEWtShgCEbQ
 jZAeLrv8YMt3klJE6W7oRaXn9ZG/jx8apFScqIN4rcnBx6XhskP/kx3lZym26/IwCz
 SH4A1o8LdVHSo2gbe/RrIToY41fzTJOJT6OQXUDnpwGHM8Vxp2D6hZp7Z0t9jOsjPI
 8LYXY3br57+ko50OCNktDrnQ3jjNvP/x0ooQ+2UhouysdA14LApKHP+V7ZRpwtOhTW
 uCOz+JGa3HSoS9K0aBXlRfaR2n8rQODvkRz+qIkBXi0qDCpucFZ52Z7cXbBezJQJIR
 3a+l01IUudZytJEjCtNwf4HDSJx++A6z2dWUTaC44J0x3tMVvXgkqREDm5IgkjaiKo
 82p1m+5M5UDjCii6k5oG4I+GEoshwV/wKZSCjMGIDjfztUm0Yo8LB+nZiMejEMvHbY
 W+SO2TNCjlvaW0u+OYfRmi6hE404deRWpK0BkJU/OhoXG11aoKthNMh13tcu0Qze1i
 wNxYxbWIeTI9df1nTnu8lKVTOeotA0xksqZD4RuLWjzsUv7/EDbeFwbXRUrTwXrfnR
 UCGKQ1cD73Pd7UsdBycaDSS6gurOcyeN24jpOzoB7KEGTSh6JHpYkyZmda7S2elJeL
 2YfoGWTQh2EgLRoAaRMlq6/Q=
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49049100a40so232125e9.2
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 03:31:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779445881; x=1780050681;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6INgl4djeFWQXewC1C5XZvZo3FV/zbQ+Ybua/PRqbXE=;
 b=ZHRohoUHG5Uvx8YZpaPPx9CIcBUfN1mEheFjdy72ddu370uB9khyZuePB62v4mwv1E
 UDDeudOsuoPtyQGKddG0mbRZ0x1PX1FvdN8uQRlmqVz4LeWLV+Vt7tLes81Pjdf51ZNQ
 PuIHiF1dP9Xz6voCD7J7vNN1VWWA1qC5c8xwkk570+TEmWYgIprPQPQayDUbODEi1uuA
 1BJwbhHted/S5UQKTE0+DI4W4/MkNQRf/AIL5N/srKBr8A4PwyGOe7cBS26CeS2R/JMT
 BvaumbxTOawJM3lVwPwLxXpPkR0nynHLyYgd2k9Ny/+iAwYjf4yLMYShNXVAWTRrmXO9
 4RuQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/jqMEaIV9rwYwk4aBQcEU9IG7HsrGtMldhN2F5XOo2Ze49ImR5iQhzCdUDMXdf7L48amXzo64=@lists.denx.de
X-Gm-Message-State: AOJu0YxGRHHcCU5etlJSj1TV8otSYeveuGzby4aEya2UXng+yJcO10dg
 iLSDlfAsnbAGPnEEfEiR0NUT43n6cB6Q+yBt5VtZwyZ4GX7kfucVk2Zgz3CejY7kwhMVUAF/Pj6
 xH6CB+vQW6PIYFN2a8/+rGU1BoRzZuTMyh3lTuh5gD7CJj3sGaAitssq8tGIeKOHIg5hUhrE=
X-Gm-Gg: Acq92OGzJvhHCUOUDc7CO1zqaXCtqQbznpzhIS9HiLdLgdtnb0hcpr5iy59FhlidVw7
 iVLeJV8ch3wSqg8JgQ9bjlMgUtW3LL96iUARDWxNrII6o6R+z0vF/tGZhe+MbTzPOiab6dfTxqL
 a73v7dRVr2F0PsQLKc3CkzIyYXd8V8GwRg/imAgEKHaV7d0DOaJpSPPwCXDDVBw1Xbb3Z4rtTDj
 H2PbyEP1pN7UBbg/7xEct9CxqQqecRUnN1XfLEePwUDS7gi2frX7e23wMJs+Ad+3kzNJ9Do22Qr
 3yvSvq0daRrBDB6wS627dPPGh2n8ddwLgWYEurvIvxKhar6A559dqYWbp0c5C53lSxA1We1JmQM
 R6raS0DmrcuE35MjwQx2yUeZJhKH4ysfiE0cFj6mCDsMudfxFFrZfj/X9wdkZyxc0YWDn1cIASJ
 58NO5Wrm1HOzO5dcTQm0JgctTAFuKdZ6wlidZG2ZizHV0XcTgP8yQ+OlW5
X-Received: by 2002:a05:600c:8718:b0:48a:768b:eea9 with SMTP id
 5b1f17b1804b1-490424a0d03mr39695385e9.4.1779445881533; 
 Fri, 22 May 2026 03:31:21 -0700 (PDT)
X-Received: by 2002:a05:600c:8718:b0:48a:768b:eea9 with SMTP id
 5b1f17b1804b1-490424a0d03mr39695085e9.4.1779445881180; 
 Fri, 22 May 2026 03:31:21 -0700 (PDT)
Received: from [192.168.103.104]
 (ip-176-199-115-125.um44.pools.vodafone-ip.de. [176.199.115.125])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490454c5eb0sm37041005e9.2.2026.05.22.03.31.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 03:31:20 -0700 (PDT)
Message-ID: <9fd344b0-4bd6-4681-a3f2-2ebb20d1859f@canonical.com>
Date: Fri, 22 May 2026 12:31:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] efi_loader: use pointers in efi_acpi_register()
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20260521185025.30857-1-heinrich.schuchardt@canonical.com>
 <20260521185025.30857-2-heinrich.schuchardt@canonical.com>
 <CAC_iWjL_sY+oRBvaaVH9vB5b7uRdzoQKam+jndQY-gMoRfeetQ@mail.gmail.com>
 <11bab46d-0f42-41a0-95e5-8cba08eb0a48@canonical.com>
 <CAC_iWjLF7-TavWNCFk1tXgDAPb92ZRoMWqHAJeixL-jdQivXnQ@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAC_iWjLF7-TavWNCFk1tXgDAPb92ZRoMWqHAJeixL-jdQivXnQ@mail.gmail.com>
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

On 5/22/26 12:01, Ilias Apalodimas wrote:
> Hi Heinrich,
> 
> On Fri, 22 May 2026 at 11:51, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> On 5/22/26 09:50, Ilias Apalodimas wrote:
>>> Hi Heinrich,
>>>
>>> On Thu, 21 May 2026 at 21:50, Heinrich Schuchardt
>>> <heinrich.schuchardt@canonical.com> wrote:
>>>>
>>>> Both efi_add_memory_map() and efi_install_configuration_table() expect
>>>> pointers and not virtual sandbox addresses.
>>>
>>> efi_add_memory_map() expects a PA afaict. EFI is identify mapped so
>>> that will make no differece, but we can be a bit explicit on the
>>> commit message
>>
>> Virtual sandbox addresses are not virtual addresses in the EFI sense.
>>
>> They are offsets in a memory chunked retrieved via mmap().
>>
>> On sandbox_defconfig:
>>
>> => echo $loadaddr
>> 0x0
>>
>> 0x0 is definitively not the address of the mmap'ed memory chunk. It is
>> the offset inside the mmap'ed memory chunk.
>>
>> We must not use these values in the EFI memory map, ACPI tables, or
>> anything else an application launched by the sandbox accesses.
>>
>>>
>>>>
>>>> We need to convert the virtual sandbox addresses in efi_acpi_register() to
>>>> pointers in memory before using them.
>>>>
>>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>>> ---
>>>>    lib/efi_loader/efi_acpi.c | 42 ++++++++++++++++++++++++---------------
>>>>    1 file changed, 26 insertions(+), 16 deletions(-)
>>>>
>>>> diff --git a/lib/efi_loader/efi_acpi.c b/lib/efi_loader/efi_acpi.c
>>>> index 046986a7518..70cb896ac25 100644
>>>> --- a/lib/efi_loader/efi_acpi.c
>>>> +++ b/lib/efi_loader/efi_acpi.c
>>>> @@ -25,7 +25,7 @@ static const efi_guid_t acpi_guid = EFI_ACPI_TABLE_GUID;
>>>>     */
>>>>    efi_status_t efi_acpi_register(void)
>>>>    {
>>>> -       ulong addr, start, end;
>>>> +       void *addr, *start, *end;
>>>>           efi_status_t ret;
>>>>
>>>>           /*
>>>> @@ -37,39 +37,49 @@ efi_status_t efi_acpi_register(void)
>>>>            */
>>>>           if (IS_ENABLED(CONFIG_BLOBLIST_TABLES)) {
>>>>                   int size;
>>>> -               void *tab = bloblist_get_blob(BLOBLISTT_ACPI_TABLES, &size);
>>>>
>>>> -               if (!tab)
>>>> +               addr = bloblist_get_blob(BLOBLISTT_ACPI_TABLES, &size);
>>>> +
>>>> +               if (!addr)
>>>>                           return EFI_NOT_FOUND;
>>>> -               addr = map_to_sysmem(tab);
>>
>> In the previous code:
>>
>> `tab` is a pointer which you can use to address memory.
>> `addr` is an offset to the memory that sandbox has claimed via mmap().
>>
>>>>
>>>> -               ret = efi_add_memory_map(addr, size,
>>
>> So instead of passing a memory address we were passing here an offset.
>> This is wrong.
> 
> Yea that makes sense. I was was remembering map_to_sysmem() wrong.
> 
> One nit though since you'll send a v2 for selftests. Can you cast
> (u64)(uintptr_t)addr instead of (uintptr_t)addr;

C converts function parameters to the expected integer type. (u64) for 
an uintptr_t is a widening conversion on 32bit and a nop on 64bit 
systems. An explicit conversion to (u64) has no extra effect.

Same for assignments.

This is different on C++, where 32bit uintptr_t needs to be explicitly 
converted to u64.

Best regards

Heinrich

> 
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> 
>>
>>>
>>> Why was this wrong? Isn't addr after map_to_sysmem() going to return a
>>> PA in normal hardware and the whatever sandbox has mapped? I think
>>> this will break the sandbox case for both cases.
>>
>> No, map_to_sysmem() returns an offset to an mmap'ed memory chunk.
>> But in the EFI memory map we need the addresses that can be used as
>> pointers.
>>
>> Best regards
>>
>> Heinrich
>>
>>>
>>>> +               ret = efi_add_memory_map((uintptr_t)addr, size,
>>>>                                            EFI_ACPI_RECLAIM_MEMORY);
>>>>                   if (ret != EFI_SUCCESS)
>>>>                           return ret;
>>>>           } else {
>>>>                   /* Mark space used for tables */
>>>> -               start = ALIGN_DOWN(gd->arch.table_start, EFI_PAGE_MASK);
>>>> -               end = ALIGN(gd->arch.table_end, EFI_PAGE_MASK);
>>>> -               ret = efi_add_memory_map(start, end - start,
>>>> +               start = (void *)ALIGN_DOWN(
>>>> +                       (uintptr_t)map_sysmem(gd->arch.table_start, 0),
>>>> +                       (uintptr_t)EFI_PAGE_MASK);
>>>> +               end = (void *)ALIGN((uintptr_t)map_sysmem(gd->arch.table_end,
>>>> +                                                         0),
>>>> +                                   (uintptr_t)EFI_PAGE_MASK);
>>>> +               ret = efi_add_memory_map((uintptr_t)start,
>>>> +                                        (uintptr_t)end - (uintptr_t)start,
>>>>                                            EFI_ACPI_RECLAIM_MEMORY);
>>>>                   if (ret != EFI_SUCCESS)
>>>>                           return ret;
>>>>                   if (gd->arch.table_start_high) {
>>>> -                       start = ALIGN_DOWN(gd->arch.table_start_high,
>>>> -                                          EFI_PAGE_MASK);
>>>> -                       end = ALIGN(gd->arch.table_end_high, EFI_PAGE_MASK);
>>>> -                       ret = efi_add_memory_map(start, end - start,
>>>> +                       start = (void *)ALIGN_DOWN(
>>>> +                               (uintptr_t)map_sysmem(gd->arch.table_start_high,
>>>> +                                                     0),
>>>> +                               (uintptr_t)EFI_PAGE_MASK);
>>>> +                       end = (void *)ALIGN((uintptr_t)map_sysmem(
>>>> +                                                   gd->arch.table_end_high, 0),
>>>> +                                           EFI_PAGE_MASK);
>>>> +                       ret = efi_add_memory_map((uintptr_t)start
>>>
>>> [...]
>>>
>>> Thanks
>>> /Ilias
>>

