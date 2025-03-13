Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95A06C282DE
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 07:38:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F20B810F4;
	Thu, 13 Mar 2025 08:38:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Qi4UcQuN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B77581782; Thu, 13 Mar 2025 08:38:31 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5388381895
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 08:38:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id AD2D23F5BC
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 07:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1741851503;
 bh=qSyCI45m75FnBqYY9uCEhmVKfLeHGbQwPFOmJoQW018=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=Qi4UcQuNeChaEozNAG0257VKfnjYOqP2RrmoRi0g6KdsB0wwxl2LvUltflrvft5M5
 +YJQ8tuTScZd+02/S+2wQBvRickN/ggW6K/PSgdut8m14jC9YZRXVDKuMVXYtIjnZ0
 ICT6jcKUwHkVAjdn7evf9oAOmuI92QTtSDqqoaaCjM86bFhIDbli4vS1ePlsYY5egv
 FMzehEMFUIh8k3e/8DbS2fSsynHqfztBGXTINtLGWGJdwk6xx5TUY87yLgkshxYvwz
 WadHKPfMYUjpVBm1u9IWASxKvN8Uge6cS18nC4FwyTum0vFiiwONmBfvzu/PkwOmSK
 yBb4Ph9TpEYkQ==
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43d08915f61so2766635e9.2
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 00:38:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741851503; x=1742456303;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qSyCI45m75FnBqYY9uCEhmVKfLeHGbQwPFOmJoQW018=;
 b=hVzOTtLxGIA9VT1zes8+DxnSUI0g+USX37SO2LNtKaSrSXwbJYxKeqA8bVUY6b/E/B
 2Goqs17tdECBNFXKSuVerzXTaG1RGfUwExz45ow1FUg3oWpKTsQK1Fr6I1rckRdKVmuM
 0FtqUHA+lPblQ4fJCYTtsEdWpN8u4f5ESm398L6K6EfBD11gOvVLLfqWZsQaQgjTeEhP
 5af4oDFlmx5Dg1q1QPoXdVahCQJ2CqpS9OEV6P8EWYB5KLXA9zJtDEAnKT7SkDYGzKuK
 39WdOBQJpyKa8PCdJYMbYCiFtAiXSaxpq6Lzx8CxjGhkVAvuaGAZ/J+v6B+d1vvatuEV
 8+mQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJ76l9SXa6+gs6NkmX5cRZ7shZU6Rs/6ATFH5U73jP0b9IxUpAe7StUckZtuw83FgoN30gT00=@lists.denx.de
X-Gm-Message-State: AOJu0YzWoZ9O4fU1NV+gds4/VjNpj2uqgeG7IDiWTZNMQcHkmpekaTvh
 4zcH0lOiO8z04ZS6Fw47BUfvtfpGlnIiB8UByd5SRYpFDYCnI0Rn+TADx0GPG6DZn4absWmZLtm
 KbDl817CnrSuhLnQVqySBRNFRuYVGsOS/JY4PIO71q65Xa/gY1u/yFjO6sc6IkRIdhuk=
X-Gm-Gg: ASbGnctHPpYqJ1WK9XsR+NDezQix4XX/zag6oetceWHgKL/qEpXJ7wNvseOywPaiLsw
 MhYEPcJz3hSXQ/K0HzBOO0H27BN7IDb120e6wp4/4QTtAQ4v+YlNQb5uW4YVhZ53bZ/v5g6vooL
 B3N2yTndX94rJgBp0wXyD3elL0iQxCp6jtf/+tSslpis67JauGg0B/9+AMbUEHXX9RAZFaRx8e2
 NLtFx3YLSsmEGGIU+cD0utq1h37pB4gzGdjba7UnB7CsxGqMAKqOOyCtr0wDp6GBOdLXoYy/PME
 hH5NHuYOeWU0cRvX8Dn+3/0juQ6Gepv73n1yHQvn/GczTl3ACrkLMsFN8IcW1ufECzRkizhZPUo
 Xh+Chgg==
X-Received: by 2002:a05:600c:6b6b:b0:43b:c857:e9c8 with SMTP id
 5b1f17b1804b1-43c601d19d6mr205388375e9.31.1741851503037; 
 Thu, 13 Mar 2025 00:38:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtqA4rixK7T8aBwCryjkijeiISqEIU7sdKMTIZf3viz1LuPvWVWa4mvtvhHQE6iTkaI4Y17g==
X-Received: by 2002:a05:600c:6b6b:b0:43b:c857:e9c8 with SMTP id
 5b1f17b1804b1-43c601d19d6mr205388085e9.31.1741851502633; 
 Thu, 13 Mar 2025 00:38:22 -0700 (PDT)
Received: from ?IPV6:2a02:3035:6e0:345b:e644:8505:68cc:d761?
 ([2a02:3035:6e0:345b:e644:8505:68cc:d761])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d0a7582absm44010185e9.17.2025.03.13.00.38.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 00:38:21 -0700 (PDT)
Message-ID: <1a320b0b-142c-4b0e-b624-9d02f953aeed@canonical.com>
Date: Thu, 13 Mar 2025 08:38:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/8] efi_loader: install device-tree on configuration
 table on every invocation
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Tobias Waldekranz <tobias@waldekranz.com>, u-boot@lists.denx.de
References: <20250312085424.1201148-1-sughosh.ganu@linaro.org>
 <20250312085424.1201148-3-sughosh.ganu@linaro.org>
 <8d8b3709-3619-41c3-999c-2021ccb2300d@canonical.com>
 <CADg8p96nRGRmBh5fgJmvrQ2Exr22=PvpGVU0FTRXWn=0QFXS4A@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CADg8p96nRGRmBh5fgJmvrQ2Exr22=PvpGVU0FTRXWn=0QFXS4A@mail.gmail.com>
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

On 13.03.25 08:14, Sughosh Ganu wrote:
> On Thu, 13 Mar 2025 at 01:40, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> On 12.03.25 09:54, Sughosh Ganu wrote:
>>> The efi_install_fdt() function is called before booting an EFI binary,
>>> either directly, or through a bootmanager. This function installs a
>>> copy of the device-tree(DT) on the EFI configuration table, which is
>>> passed on to the OS.
>>>
>>> The current logic in this function does not install a DT if the table
>>> already has a DT installed on it. However, this existing copy of the
>>
>> The device-tree is the configuration table. Maybe better write:
>>
>> ... if a device-tree is already installed as an EFI configuration table.
> 
> Oh. Isn't the device-tree *one* of the entries on the configuration
> table? I mean, the spec says this, "The EFI Configuration table is the
> ConfigurationTable field in the EFI System Table. This table contains
> a set of GUID/pointer pairs". And one of these pairs happens to be the
> DT.


The UEFI spec uses the term "configuration table" both for the field 
ConfigurationTable in the SystemTable as well as for the objects that 
this table is pointing to.

UEFI specification 2.11, Chapter 7.5.6, 
EFI_BOOT_SERVICES.InstallConfigurationTable(), has this sentence:

The InstallConfigurationTable() function is used to maintain the list of 
configuration tables that are stored in the EFI System Table.

So the device-tree is one of the configuration tables like the SMBIOS 
table, and many others.

As the specification uses the term "configuration table" with 
alternative significations, it would be preferable if the commit message 
would make it clear which one is being referred to.

Best regards

Heinrich

> 
>>
>>> DT might not be up-to-date, or it could be a wrong DT for the image
>>> that is being booted. Always install a DT afresh to the configuration
>>> table before booting the EFI binary.
>>>
>>> Installing a new DT also involves some additional checks that are
>>> needed to clean up memory associated with the existing DT copy. Check
>>> for an existing copy, and free up that memory.
>>>
>>> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
>>> ---
>>> Changes since V7:
>>> * Change the type of fdt_pages to efi_uintn_t
>>> * Remove the check for either of fdt_pages or new_fdt_addr being 0
>>> * Change the format specifier for fdt_pages in the debug messages for
>>>     size_t
>>> * Put the assignment of new_fdt_addr and fdt_pages on separate lines
>>>     to avoid checkpatch error
>>>
>>>
>>>    lib/efi_loader/efi_helper.c | 32 ++++++++++++++++++++++----------
>>>    1 file changed, 22 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
>>> index 15ad042bc61..37e5859741f 100644
>>> --- a/lib/efi_loader/efi_helper.c
>>> +++ b/lib/efi_loader/efi_helper.c
>>> @@ -454,11 +454,21 @@ efi_status_t efi_env_set_load_options(efi_handle_t handle,
>>>     */
>>>    static efi_status_t copy_fdt(void **fdtp)
>>>    {
>>> -     unsigned long fdt_pages;
>>>        efi_status_t ret = 0;
>>>        void *fdt, *new_fdt;
>>> -     u64 new_fdt_addr;
>>> -     uint fdt_size;
>>> +     static u64 new_fdt_addr;
>>> +     static efi_uintn_t fdt_pages;
>>> +     ulong fdt_size;
>>> +
>>> +     if (new_fdt_addr) {
>>> +             log_debug("%s: Found allocated memory at %#llx, with %#zx pages\n",
>>> +                       __func__, new_fdt_addr, fdt_pages);
>>> +             ret = efi_free_pages(new_fdt_addr, fdt_pages);
>>
>> We should not free the memory before removing the configuration table.
>> Otherwise in an error situation we might end up with an invalid
>> device-tree pointer.
> 
> Yes, that is a good point. Will add this change.
> 
>>
>> /* Ignoring EFI_NOT_FOUND if not device-tree is installed */
>> efi_install_configuration_table(&efi_guid_fdt, NULL);
>> if (new_fdt_addr) {
>>          ret = efi_free_pages(new_fdt_addr, fdt_pages);
>>          ...
>>
>>> +             if (ret != EFI_SUCCESS) {
>>> +                     log_err("Unable to free up existing FDT memory region\n");
>>   > +                    return ret;> +          }
>>
>> Ok, something weird happened. But this should not stop booting.
> 
> Okay, so I now see that none of the EFI code seems to be checking the
> return value of the efi_free_{pages, pool} functions.
> 
>>
>> Just set new_fdt_addr = 0 in any case.
>>
>>          if (ret!= EFI_SUCCES)
>>                  log_err("Failed to free existing FDT memory\n");
>>          new_fdt_addr = 0;
>>
>>> +     }
>>>
>>>        /*
>>>         * Give us at least 12 KiB of breathing room in case the device tree
>>> @@ -472,16 +482,21 @@ static efi_status_t copy_fdt(void **fdtp)
>>>                                 EFI_ACPI_RECLAIM_MEMORY, fdt_pages,
>>>                                 &new_fdt_addr);
>>>        if (ret != EFI_SUCCESS) {
>>> +             new_fdt_addr = 0;
>>
>> efi_allocate_pages() only updates new_fdt_addr() in case of success.
>> If we set new_fdt_addr = 0 above, this line might be removed.
> 
> Okay
> 
>>
>>> +             fdt_pages = 0;
>>
>> This line is not really needed as our if-statements don't use it.
> 
> Yeah, but it just feels weird just zeroing out one of the parameters
> and not the other. Someone who reads this code later might find it
> odd. And I am sure that the compiler would be doing the necessary
> optimisations. If you don't have a strong opinion on this, I would
> prefer this stay.
> 
> -sughosh
> 
>>
>> Best regards
>>
>> Heinrich
>>
>>>                log_err("Failed to reserve space for FDT\n");
>>> -             goto done;
>>> +             return ret;
>>>        }
>>> +     log_debug("%s: Allocated memory at %#llx, with %#zx pages\n",
>>> +               __func__, new_fdt_addr, fdt_pages);
>>> +
>>>        new_fdt = (void *)(uintptr_t)new_fdt_addr;
>>>        memcpy(new_fdt, fdt, fdt_totalsize(fdt));
>>>        fdt_set_totalsize(new_fdt, fdt_size);
>>>
>>> -     *fdtp = (void *)(uintptr_t)new_fdt_addr;
>>> -done:
>>> -     return ret;
>>> +     *fdtp = new_fdt;
>>> +
>>> +     return EFI_SUCCESS;
>>>    }
>>>
>>>    /**
>>> @@ -534,9 +549,6 @@ efi_status_t efi_install_fdt(void *fdt)
>>>                const char *fdt_opt;
>>>                uintptr_t fdt_addr;
>>>
>>> -             /* Look for device tree that is already installed */
>>> -             if (efi_get_configuration_table(&efi_guid_fdt))
>>> -                     return EFI_SUCCESS;
>>>                /* Check if there is a hardware device tree */
>>>                fdt_opt = env_get("fdt_addr");
>>>                /* Use our own device tree as fallback */
>>

