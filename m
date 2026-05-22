Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB5F1CD5BB0
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 11:03:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F2F8843B6;
	Fri, 22 May 2026 13:03:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AXwkm6p1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1A00846CF; Fri, 22 May 2026 13:03:05 +0200 (CEST)
Received: from mail-yx1-xb12b.google.com (mail-yx1-xb12b.google.com
 [IPv6:2607:f8b0:4864:20::b12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3955D841D7
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 13:03:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-65eb1b25c77so1729889d50.0
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 04:03:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779447781; cv=none;
 d=google.com; s=arc-20240605;
 b=P8+z/59gFHVqQHijJ8LuKRAI4jhfQBLuHkFrfdJ9y2NKsEJtGU6CH21gX/ppndagQw
 DFQXOXZ4XdM0y0i19l+PPfrmMztmXs/LPwWtnPkM+bJ8m2Diyz/4j+xTiYpKzWhw/60S
 YsiQSPqoT2ah75QF77eoW4z+sbY3G71e9tQk6wVhuieaobQnOhFgd3NcLknwZRx1clT+
 rwazDm1j1jqbAWaJqwyvjU5LECT0edsHoTNryjovx4Rc9aE8z8PM8fsI0yw8VtjSpIEw
 Z4rjHRBMuxJ80Zv23sEbEsAZxEw+xjqrXnnfY1daaIAnV/IjKNUMgHZY+kWwoerBiVzj
 ArTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=X5m6YhIKGtPNom/WongtzgB47FwfPgN1Os7+PtOFyJg=;
 fh=3SFCdNDK1e/f3l5kx1bxEfdMsqgEvFeRk7I4tlK0X7k=;
 b=RTLp4qWLWlwFThq6KWeN3fHuQ/0d8HYlP9iUFeWEXdjlOtJrS29WHNn4c2oFfSEGfm
 0+wRh8MlDspuQvfvte18WOgOyfGJ8Wmf89wSirVXjS/BwqG6G/vFICatUl9j/e+9izZB
 9wLZnV2Oujqe/BrhKVfyhNj9eM+2gVWHPKQkaLv0x1RamoZ7yygr5TZ4zyeFDGkpnr+N
 RT0xRCKtcj3U+zax0rboth+WMIcyAEADDdyKtO2tLCPWaKL0/f9hoM6hD4fz+bxOKAxH
 5DGb/FhRcggIydBP6PkH3mH2IRrGEasmX91IL30MvIFcro38fo3UvUwvThUqTsWeOdeY
 7qVA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779447781; x=1780052581; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=X5m6YhIKGtPNom/WongtzgB47FwfPgN1Os7+PtOFyJg=;
 b=AXwkm6p1zogPOFj9t5ORgnxjnc2Z/eGK5gnYpDL+aCx2FaKnwLE3d5ow+eDsaa1QzB
 TlJ6Ungjeqwuw74Qd9S6fFuh3R+MKs211rr8P62I6XssAkj1SLSdrLaWROTAPbuuc3/E
 7nBIgF5rykQzCMdx0bMQl1EeceOUHnBcxTjSKubO9kTwi16yLISpmMm9UN6+2Zvwh492
 3L/7bXUl6CSUZgfIJhpjLR2iTpwjP9VbyKXyKk1N5cOszJlMk2j2m285lkxT0tq40eJ0
 FAuJ3JlDvgWcp5BFBZj2q92uxxHhgVkMjI5nQIpqGuzlINRaTPPGA9Cdr/4ctPpB5G8I
 oXPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779447781; x=1780052581;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X5m6YhIKGtPNom/WongtzgB47FwfPgN1Os7+PtOFyJg=;
 b=F+gSK+JOhKBXEu5lE/HtMgUWIcHT2R9VmG4uBBHJPmvMQXD/L4EFfgw3xHDcwGGyBx
 EfJy/itC2/f+62Rk4sNEEkxB4YskT+FM1ol56JmyLmQWNGSAusCR6YDB7QDotw45fcPY
 ZH9IhrOxtvKzUtG5JayOQnhbi6mIax5vDl034iUU5zY7o2a5dWVAAeFHuRgfpwmlbzEI
 5aw9oXLSkmnLX1IhOYLnEbvaXQYT3alVMp3UNimDZYvQNLSB5JZ942tFCF+xrRd0texO
 1eDAaIuJoCgMS59KJNoA89tqEWno/sPREQfuYdZJVoyj/wuP5W+6VUJIOyc+IpjWzYgi
 WhjA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/hrn2J3iDACeVuXURS3M3+hsXqDR+G3qpHf8C64tTB/Tu0fs27muw0nYnUhoLlgkdJsHD1aIw=@lists.denx.de
X-Gm-Message-State: AOJu0Yw136PJVSW/ayXdC7ut2VLIP/puGp365FNWYbbrLZ/88G94cFE1
 S9txMbEBbCMxWEa/aiFo1sKMoofZBYBVXCWiy7nsCLWM12oIemnRgWCkqFpSAMiIc0eHjYLkyrg
 Qbi70SWlijJnctrJ56r7WBRLJ9eX1zOAL3szGQinGvw==
X-Gm-Gg: Acq92OGCTCBt4B6a3lxmc7b0qyZJQx0A96tgTmB/m9KSAl0Pw7jaoIdGdtmp4LjBh0R
 fJZhMk2JReCtYTqIEqY63+F9etTS0ROpnkSmd6zeYCtOK8Dz4+L5ODBs+fPrjAx3fKsNPw5l2BT
 bnJgN07JgVePe4fGmFZWGzwzhYDOUtP/1HTTUMmy/Mmz6qaIg8UoaIDJrDUIyDvIAyBnh9ApJkR
 7vT7H/P/5ihVWWflGURGhgErAF5IE08pzKkzuciZsryBn71aCfjldyct0Z4RRQt7mOAlOMMsG1s
 wyXzs8Ckq0lZWrsgKgYhqYhT80WgZSWi+HbIDdf8MakTYjG/uboud+3HvSl0T7t0CS9T67mSuqv
 VfX7/bbSs9eneBLhNK6/gnB8du0qL60JV3wOnwB5a251jbv1XyyBfSRj1HOmrLdFMUme1iE/hhF
 m/AixGWyIu1Z3L9Zb/uZiFIkztaumXDyDermLNs52U89rmpMKk0iVE/MiYmqLGrHFZzI2t7vYyM
 tqBZQdsjDqvmpwE3l+PpNbpxOxTQTGvs2r6FxOsTU2wy1voYjgfhvC+CPQQr6yJEbkwMrfrjmnb
 PIGWJ+bmgQi3cY7/SYISV+G05JBDSOzZSfHqIEZXheCFBc9Lcgr7Of7Dy7boIFZ1xzNjLFQLhOU
 s/QywHA==
X-Received: by 2002:a05:690e:4808:b0:65e:b97:7725 with SMTP id
 956f58d0204a3-65ec9926c57mr2055188d50.50.1779447780408; Fri, 22 May 2026
 04:03:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260521185025.30857-1-heinrich.schuchardt@canonical.com>
 <20260521185025.30857-2-heinrich.schuchardt@canonical.com>
 <CAC_iWjL_sY+oRBvaaVH9vB5b7uRdzoQKam+jndQY-gMoRfeetQ@mail.gmail.com>
 <11bab46d-0f42-41a0-95e5-8cba08eb0a48@canonical.com>
 <CAC_iWjLF7-TavWNCFk1tXgDAPb92ZRoMWqHAJeixL-jdQivXnQ@mail.gmail.com>
 <9fd344b0-4bd6-4681-a3f2-2ebb20d1859f@canonical.com>
In-Reply-To: <9fd344b0-4bd6-4681-a3f2-2ebb20d1859f@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 22 May 2026 14:02:24 +0300
X-Gm-Features: AVHnY4IOijbghvPOI_l-yEh4wl6aGHT0d38KdNxXmG9tHLnnFqtAQIv4aI2zkis
Message-ID: <CAC_iWjLaucH+24D_Z71-ohbw5TBgcLVkaNX4d_12_TmZFFcQ4A@mail.gmail.com>
Subject: Re: [PATCH 1/3] efi_loader: use pointers in efi_acpi_register()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

On Fri, 22 May 2026 at 13:31, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 5/22/26 12:01, Ilias Apalodimas wrote:
> > Hi Heinrich,
> >
> > On Fri, 22 May 2026 at 11:51, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >>
> >> On 5/22/26 09:50, Ilias Apalodimas wrote:
> >>> Hi Heinrich,
> >>>
> >>> On Thu, 21 May 2026 at 21:50, Heinrich Schuchardt
> >>> <heinrich.schuchardt@canonical.com> wrote:
> >>>>
> >>>> Both efi_add_memory_map() and efi_install_configuration_table() expect
> >>>> pointers and not virtual sandbox addresses.
> >>>
> >>> efi_add_memory_map() expects a PA afaict. EFI is identify mapped so
> >>> that will make no differece, but we can be a bit explicit on the
> >>> commit message
> >>
> >> Virtual sandbox addresses are not virtual addresses in the EFI sense.
> >>
> >> They are offsets in a memory chunked retrieved via mmap().
> >>
> >> On sandbox_defconfig:
> >>
> >> => echo $loadaddr
> >> 0x0
> >>
> >> 0x0 is definitively not the address of the mmap'ed memory chunk. It is
> >> the offset inside the mmap'ed memory chunk.
> >>
> >> We must not use these values in the EFI memory map, ACPI tables, or
> >> anything else an application launched by the sandbox accesses.
> >>
> >>>
> >>>>
> >>>> We need to convert the virtual sandbox addresses in efi_acpi_register() to
> >>>> pointers in memory before using them.
> >>>>
> >>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >>>> ---
> >>>>    lib/efi_loader/efi_acpi.c | 42 ++++++++++++++++++++++++---------------
> >>>>    1 file changed, 26 insertions(+), 16 deletions(-)
> >>>>
> >>>> diff --git a/lib/efi_loader/efi_acpi.c b/lib/efi_loader/efi_acpi.c
> >>>> index 046986a7518..70cb896ac25 100644
> >>>> --- a/lib/efi_loader/efi_acpi.c
> >>>> +++ b/lib/efi_loader/efi_acpi.c
> >>>> @@ -25,7 +25,7 @@ static const efi_guid_t acpi_guid = EFI_ACPI_TABLE_GUID;
> >>>>     */
> >>>>    efi_status_t efi_acpi_register(void)
> >>>>    {
> >>>> -       ulong addr, start, end;
> >>>> +       void *addr, *start, *end;
> >>>>           efi_status_t ret;
> >>>>
> >>>>           /*
> >>>> @@ -37,39 +37,49 @@ efi_status_t efi_acpi_register(void)
> >>>>            */
> >>>>           if (IS_ENABLED(CONFIG_BLOBLIST_TABLES)) {
> >>>>                   int size;
> >>>> -               void *tab = bloblist_get_blob(BLOBLISTT_ACPI_TABLES, &size);
> >>>>
> >>>> -               if (!tab)
> >>>> +               addr = bloblist_get_blob(BLOBLISTT_ACPI_TABLES, &size);
> >>>> +
> >>>> +               if (!addr)
> >>>>                           return EFI_NOT_FOUND;
> >>>> -               addr = map_to_sysmem(tab);
> >>
> >> In the previous code:
> >>
> >> `tab` is a pointer which you can use to address memory.
> >> `addr` is an offset to the memory that sandbox has claimed via mmap().
> >>
> >>>>
> >>>> -               ret = efi_add_memory_map(addr, size,
> >>
> >> So instead of passing a memory address we were passing here an offset.
> >> This is wrong.
> >
> > Yea that makes sense. I was was remembering map_to_sysmem() wrong.
> >
> > One nit though since you'll send a v2 for selftests. Can you cast
> > (u64)(uintptr_t)addr instead of (uintptr_t)addr;
>
> C converts function parameters to the expected integer type. (u64) for
> an uintptr_t is a widening conversion on 32bit and a nop on 64bit
> systems. An explicit conversion to (u64) has no extra effect.
>
> Same for assignments.

Ok if it's zero-extended properly, then that's ok

Thanks
/Ilias
>
> This is different on C++, where 32bit uintptr_t needs to be explicitly
> converted to u64.
>
> Best regards
>
> Heinrich
>
> >
> > Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >
> >>
> >>>
> >>> Why was this wrong? Isn't addr after map_to_sysmem() going to return a
> >>> PA in normal hardware and the whatever sandbox has mapped? I think
> >>> this will break the sandbox case for both cases.
> >>
> >> No, map_to_sysmem() returns an offset to an mmap'ed memory chunk.
> >> But in the EFI memory map we need the addresses that can be used as
> >> pointers.
> >>
> >> Best regards
> >>
> >> Heinrich
> >>
> >>>
> >>>> +               ret = efi_add_memory_map((uintptr_t)addr, size,
> >>>>                                            EFI_ACPI_RECLAIM_MEMORY);
> >>>>                   if (ret != EFI_SUCCESS)
> >>>>                           return ret;
> >>>>           } else {
> >>>>                   /* Mark space used for tables */
> >>>> -               start = ALIGN_DOWN(gd->arch.table_start, EFI_PAGE_MASK);
> >>>> -               end = ALIGN(gd->arch.table_end, EFI_PAGE_MASK);
> >>>> -               ret = efi_add_memory_map(start, end - start,
> >>>> +               start = (void *)ALIGN_DOWN(
> >>>> +                       (uintptr_t)map_sysmem(gd->arch.table_start, 0),
> >>>> +                       (uintptr_t)EFI_PAGE_MASK);
> >>>> +               end = (void *)ALIGN((uintptr_t)map_sysmem(gd->arch.table_end,
> >>>> +                                                         0),
> >>>> +                                   (uintptr_t)EFI_PAGE_MASK);
> >>>> +               ret = efi_add_memory_map((uintptr_t)start,
> >>>> +                                        (uintptr_t)end - (uintptr_t)start,
> >>>>                                            EFI_ACPI_RECLAIM_MEMORY);
> >>>>                   if (ret != EFI_SUCCESS)
> >>>>                           return ret;
> >>>>                   if (gd->arch.table_start_high) {
> >>>> -                       start = ALIGN_DOWN(gd->arch.table_start_high,
> >>>> -                                          EFI_PAGE_MASK);
> >>>> -                       end = ALIGN(gd->arch.table_end_high, EFI_PAGE_MASK);
> >>>> -                       ret = efi_add_memory_map(start, end - start,
> >>>> +                       start = (void *)ALIGN_DOWN(
> >>>> +                               (uintptr_t)map_sysmem(gd->arch.table_start_high,
> >>>> +                                                     0),
> >>>> +                               (uintptr_t)EFI_PAGE_MASK);
> >>>> +                       end = (void *)ALIGN((uintptr_t)map_sysmem(
> >>>> +                                                   gd->arch.table_end_high, 0),
> >>>> +                                           EFI_PAGE_MASK);
> >>>> +                       ret = efi_add_memory_map((uintptr_t)start
> >>>
> >>> [...]
> >>>
> >>> Thanks
> >>> /Ilias
> >>
>
