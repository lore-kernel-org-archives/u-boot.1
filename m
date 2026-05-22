Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F266CD5BB0
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 08:51:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04BA3846BD;
	Fri, 22 May 2026 10:51:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="jwlnWCUT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02544846CA; Fri, 22 May 2026 10:51:24 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAF758460E
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 10:51:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6AF4F3F46D
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 08:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1779439881;
 bh=3cg+GoJJrEZZa/cviO/lyqRddxDJlU0J5rHASQ9LVF0=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=jwlnWCUT+G2wJIMmBPp+fdgKMCjQJFuWcHUHFAtKrmqJxUku4LJE2dfO3unECIhad
 h1dEnCv+wjZF+IBoEHuRJ+lY9fXVNcjKtqhRv5b1AnjsbotD4fzDoKqTSzL37vwMDq
 p6LdXAcpT10AfpDNocm4/mzkOWM3SGlaHQOK5CDEDcq8l769vSHyBCs1K7Sv6FZxBY
 EZpQNMy8nmLtagmlnj0nJOJiokdHiLjmMOLd5TgudU82qAGfnpvoUniHlOj7NxbC5L
 brJ4B1xKV5ick1kkwNiBpHPkd/vbNOyEisvXY6lGdfYzqTHuUHxi649tXvl95fZi7U
 oJkESj+jDbXE1drERzgDd4xzGrLUFk4H8EiRqo1FRsr/cEq/zL/n+t/FLkKt28jUcy
 zwHAfABb/TrWjnR1mwW6NMaq9xbvgTkSfXPhWayc4BpT7k8CmWJ/h8NcbKpa/xPaP6
 MkpOb4Vt1tAUVlIvzPEkfkgvvjs1avNmUtFqVWk6uRvYt3pWrdHr3ETNR6iJ142EfY
 wFvFcsrPb25Mv7DpAkjDp73N6ekZ+wNNUjPdJaDjb8tztxdIrZSzu7rmi7iW9qo6Fj
 f42Tw/G8c31/YeRkElUS4roxDQC8oSgtCdOY7xSy5f9EvIYH6Yx6cM/yyEJjh8+hcL
 +e5hyi3AUl1yCmiV+U6tKiC0=
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49045243094so6874495e9.2
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 01:51:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779439881; x=1780044681;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3cg+GoJJrEZZa/cviO/lyqRddxDJlU0J5rHASQ9LVF0=;
 b=OapeEtLWJDg0IGiSqGm4TNqw7DzlblLNfPUYN4DKqtGYyZTGyThwbpxRFwMBh9vZD4
 KR87OG79R9AFDpwsLn1cOeRc8bGYkp7Qopmp2KFfsZien1bcNAoYFEXL37PrspGHn9mG
 2pcmSoSwhc14HhXOIaDzbq9IDQGHmVISukbjLFBRaWTootnkcLcQoKDtgDTbicS1x2Uc
 ni2cqXrEsgRN8HMfuf+gM6hdIGesdnZoInsm7T+HR3GyUrFpa7nKRah4Qv23ltoVCrlJ
 uT21yUtV2cq/3dEJxUGZUl9oTmp/FY4CRlADks4j59Yx4W7LDIO5UGSdviRTS+PDCFli
 nrZw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8JlikU0UR4nOK3ceD5HtlZcLbvr+yCD0+R3trUfeYz3yKeoYRklXBTC5Rrt1nsZW5taCi00hs=@lists.denx.de
X-Gm-Message-State: AOJu0Yw2tlo1rahyoSaLNdfFXXMtOFbwF2s+8yi6MtKA9PnpWA3otbXr
 ChGfI6slAuet7q76wqmnrlSKx9Utn9pD99GhxdfQLsI8lufLlHQdOpzs8OwTlrvalnfJ+chWp61
 17I6Ec28bVqNbFmoRxjFwmP/fKCOkDYTpP8U/fGrkMqbys2MjviKxDM2KKXDlVp1XOnBSfFg=
X-Gm-Gg: Acq92OF2ooZ0xG4birzJj4Id1JnFhU/3XLHVPBWCLLqNESNs4Sg9vi3hO9IvsPYPJhU
 rTOEM6kgGcchrsUwmzLEkKHkhvp0oHbo5JrT9D1LU4aPMcbAfhinaU/idJMmyR0uKLbMzLp2HfE
 J5cepmZruTGviSU46L0mQfPfZo0Py7E4CNC1adNyuWaLWeERKWIuGGkTR9je1pLs8XqY1o0R5kl
 TRxQV8QE9RTybX/3O6RlpIbzgCDn+l03USjxZ+r2X9v5dSCb72C4WsFkAC9+dJicf3hCVkUuZ0a
 DDfGW+meYZrmN5TeeM5IoMr6C1+7mt9j9ROW7VuSi8+10BT1rlFgUNa0oMLGS+gfyKV4z0oHRei
 B/v6UXT+CTl0VClTH1pN7/69C9eEHCa+S3gHcwYu6th9L2xHZBAP/0jutIZ9pojoNRcXjfqrpeK
 BvdfA2UChKXEZl5QBnh7bEpevWqLlR4QfIy12j6fJUc6/VAYpnEyeSz3AL
X-Received: by 2002:a05:600c:468a:b0:490:3d62:f5df with SMTP id
 5b1f17b1804b1-490428e5a6amr35176345e9.30.1779439881007; 
 Fri, 22 May 2026 01:51:21 -0700 (PDT)
X-Received: by 2002:a05:600c:468a:b0:490:3d62:f5df with SMTP id
 5b1f17b1804b1-490428e5a6amr35175845e9.30.1779439880542; 
 Fri, 22 May 2026 01:51:20 -0700 (PDT)
Received: from [192.168.103.104]
 (ip-176-199-115-125.um44.pools.vodafone-ip.de. [176.199.115.125])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d5e484sm2457638f8f.30.2026.05.22.01.51.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 01:51:19 -0700 (PDT)
Message-ID: <11bab46d-0f42-41a0-95e5-8cba08eb0a48@canonical.com>
Date: Fri, 22 May 2026 10:51:18 +0200
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
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAC_iWjL_sY+oRBvaaVH9vB5b7uRdzoQKam+jndQY-gMoRfeetQ@mail.gmail.com>
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

On 5/22/26 09:50, Ilias Apalodimas wrote:
> Hi Heinrich,
> 
> On Thu, 21 May 2026 at 21:50, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> Both efi_add_memory_map() and efi_install_configuration_table() expect
>> pointers and not virtual sandbox addresses.
> 
> efi_add_memory_map() expects a PA afaict. EFI is identify mapped so
> that will make no differece, but we can be a bit explicit on the
> commit message

Virtual sandbox addresses are not virtual addresses in the EFI sense.

They are offsets in a memory chunked retrieved via mmap().

On sandbox_defconfig:

=> echo $loadaddr
0x0

0x0 is definitively not the address of the mmap'ed memory chunk. It is 
the offset inside the mmap'ed memory chunk.

We must not use these values in the EFI memory map, ACPI tables, or 
anything else an application launched by the sandbox accesses.

> 
>>
>> We need to convert the virtual sandbox addresses in efi_acpi_register() to
>> pointers in memory before using them.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   lib/efi_loader/efi_acpi.c | 42 ++++++++++++++++++++++++---------------
>>   1 file changed, 26 insertions(+), 16 deletions(-)
>>
>> diff --git a/lib/efi_loader/efi_acpi.c b/lib/efi_loader/efi_acpi.c
>> index 046986a7518..70cb896ac25 100644
>> --- a/lib/efi_loader/efi_acpi.c
>> +++ b/lib/efi_loader/efi_acpi.c
>> @@ -25,7 +25,7 @@ static const efi_guid_t acpi_guid = EFI_ACPI_TABLE_GUID;
>>    */
>>   efi_status_t efi_acpi_register(void)
>>   {
>> -       ulong addr, start, end;
>> +       void *addr, *start, *end;
>>          efi_status_t ret;
>>
>>          /*
>> @@ -37,39 +37,49 @@ efi_status_t efi_acpi_register(void)
>>           */
>>          if (IS_ENABLED(CONFIG_BLOBLIST_TABLES)) {
>>                  int size;
>> -               void *tab = bloblist_get_blob(BLOBLISTT_ACPI_TABLES, &size);
>>
>> -               if (!tab)
>> +               addr = bloblist_get_blob(BLOBLISTT_ACPI_TABLES, &size);
>> +
>> +               if (!addr)
>>                          return EFI_NOT_FOUND;
>> -               addr = map_to_sysmem(tab);

In the previous code:

`tab` is a pointer which you can use to address memory.
`addr` is an offset to the memory that sandbox has claimed via mmap().

>>
>> -               ret = efi_add_memory_map(addr, size,

So instead of passing a memory address we were passing here an offset. 
This is wrong.

> 
> Why was this wrong? Isn't addr after map_to_sysmem() going to return a
> PA in normal hardware and the whatever sandbox has mapped? I think
> this will break the sandbox case for both cases.

No, map_to_sysmem() returns an offset to an mmap'ed memory chunk.
But in the EFI memory map we need the addresses that can be used as 
pointers.

Best regards

Heinrich

> 
>> +               ret = efi_add_memory_map((uintptr_t)addr, size,
>>                                           EFI_ACPI_RECLAIM_MEMORY);
>>                  if (ret != EFI_SUCCESS)
>>                          return ret;
>>          } else {
>>                  /* Mark space used for tables */
>> -               start = ALIGN_DOWN(gd->arch.table_start, EFI_PAGE_MASK);
>> -               end = ALIGN(gd->arch.table_end, EFI_PAGE_MASK);
>> -               ret = efi_add_memory_map(start, end - start,
>> +               start = (void *)ALIGN_DOWN(
>> +                       (uintptr_t)map_sysmem(gd->arch.table_start, 0),
>> +                       (uintptr_t)EFI_PAGE_MASK);
>> +               end = (void *)ALIGN((uintptr_t)map_sysmem(gd->arch.table_end,
>> +                                                         0),
>> +                                   (uintptr_t)EFI_PAGE_MASK);
>> +               ret = efi_add_memory_map((uintptr_t)start,
>> +                                        (uintptr_t)end - (uintptr_t)start,
>>                                           EFI_ACPI_RECLAIM_MEMORY);
>>                  if (ret != EFI_SUCCESS)
>>                          return ret;
>>                  if (gd->arch.table_start_high) {
>> -                       start = ALIGN_DOWN(gd->arch.table_start_high,
>> -                                          EFI_PAGE_MASK);
>> -                       end = ALIGN(gd->arch.table_end_high, EFI_PAGE_MASK);
>> -                       ret = efi_add_memory_map(start, end - start,
>> +                       start = (void *)ALIGN_DOWN(
>> +                               (uintptr_t)map_sysmem(gd->arch.table_start_high,
>> +                                                     0),
>> +                               (uintptr_t)EFI_PAGE_MASK);
>> +                       end = (void *)ALIGN((uintptr_t)map_sysmem(
>> +                                                   gd->arch.table_end_high, 0),
>> +                                           EFI_PAGE_MASK);
>> +                       ret = efi_add_memory_map((uintptr_t)start
> 
> [...]
> 
> Thanks
> /Ilias

