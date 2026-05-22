Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E50CD5BAC
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 10:01:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73956843B6;
	Fri, 22 May 2026 12:01:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JqmrgOkQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 785DE846A4; Fri, 22 May 2026 12:01:45 +0200 (CEST)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5CF1841D7
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 12:01:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-7b41fdf9de2so51998317b3.0
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 03:01:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779444101; cv=none;
 d=google.com; s=arc-20240605;
 b=dtLBk01o9m1HS7Z3p55hwCgfvIqkMPE9qp3n36waLKVrC7NafBz/A7qq8CTchSzdmz
 7OorX3cxXg6QNZPtDwTS4MDtVO6/SvvZwrnuqONQqEAofU5D2+6qSS+T3Tcux8UlSrH+
 H3W9m5IRQ1WlUTWSY/DJYbn75pW1nbQLQ7nuwlqrryG8kvtq3iAmaCU4E6fL0BSjp0ku
 DrcJXS/O0Rt/4Or7s5oSj846pbJT2/0KE8hzrWHH8NhR4hW8wMeMHXoJ7GjOxEcUN8Kn
 gYxUVqJpbtSGMwYA7kUSX7nkSGFa2m6Xx2nu5RN4gv1Q3YLkJYu6eorrsbhvbYWSW+6n
 Kqig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=BcEuUsEDVZSxX/uwTfLiRuIaluqi0SI+Djesz6UfQ9s=;
 fh=cQBl78mxxK8e3HGWkTZ1olYtcy3VsxjKFdFewNtUEL4=;
 b=DY5wMZfEQFDMQ9tbnYj0igYFncGz+3X2WZqvgqYVvZ2doImN+EPLtCSMghRP6Z7gyQ
 mHPccTyG6M2TImVpdhvzVhWNSfWrb8KAkIvs/nYe1jQCgPPFiPgpezsnN4SqmkQ3XCh9
 ydlWclSDCabA5T2/WzzD6K8MCD21nWpMu8yDPYZ4hgOYLwZ2iZbpJt1FTSNckA0d95PU
 MCPUAwR1vFjCLs7S5dZdOFWY7ka9tbh0G41yqyUZRzQgdyHHkb29MgQGxaUgRtcQyjAq
 sI3KxJxcL/Xc158huTyeM6AMBCBsj3mlwCMwc8K33Jk6BmnKSzpJC/6xu/RmAbtNeTdq
 RE3g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779444101; x=1780048901; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BcEuUsEDVZSxX/uwTfLiRuIaluqi0SI+Djesz6UfQ9s=;
 b=JqmrgOkQrvowLtEVkqrEY6Ef9XczqCGz7QqAEQQvCdEbVB4MRIz9imZtnTgQHO6L4X
 MpTG5RMKB0GHohZCowtHr+QaDZG51zRD9QTSwgfHebR5hSJgqE8ONTFBgq9uVR7Zi2SM
 /7mPYwDbKmFa4vShluHiAH9UEewzvsH/wqrBNeHkHa0CVSN8w+kq7k3eDo604Phs9Uv+
 3OJEm3FXCzVlPMgulMJLYrWGyGvc+BNfqMtgM9B736VsD7lfCe9xIpU6sPI3C4nepJcS
 zNsaqe+QCV//xlipJascQfPO5zvD9DVjVsr0+Ft396CNLcZgrLxH5Y4aipHP6J3kEuCg
 bWjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779444101; x=1780048901;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BcEuUsEDVZSxX/uwTfLiRuIaluqi0SI+Djesz6UfQ9s=;
 b=Mj2Z3VVeDjbX0//hXIwS5mGt0iGMw7R836mpU3m1ruVohXF/GNiGjzHMRemcr/nQGY
 2FSQharUxRVJLa+rmT3J3/N4ZCLmssCOcFWi0PDImzcGTLwYWjNu3GZwWVVO64S8bHqF
 77yN9H32H/zuGDucfQW+nbCuoaFNVZR/D5GC2WHs0DyepTK7wqJwFCJ5lHSSk9rMX/tO
 +s8003msEFMCQDyFY7RGw8+WYxu4q0y2+oYj/ynd6zZ0jRs9ejJJ51lwtHqabI2/dOEW
 nQze7Yq6u4qWE9C8vq7q2jHQnizGPIeAnZ0d+zhw5NlXl+eznXeXTMSD8R3XDBNdvtmt
 SXag==
X-Forwarded-Encrypted: i=1;
 AFNElJ+KFE+L4PuiWHuzKkc3Y5aB0SR776KcrOScCPxcl0n/b5FUquPPKDoJjtojlD7W0OHl1sW9jeY=@lists.denx.de
X-Gm-Message-State: AOJu0YzmMAl1aHqUHqwF+JaYbxIjlDwqz2jYuYmNBy859TVcPjUWePgb
 QMrr9SO0VjQcV81Y/SkEZxA0ky3gwmV617gTzGPiMGhPziaO3MhxeO26RPD7qoKZ2dyi4y+egNN
 sOMpn5DyCJ79iTydUrcFHFWl0JkG3FR3gkEWRc7qqLg==
X-Gm-Gg: Acq92OEcjOqg0edF/jp+4heHu4fjRwHY76gY5vfL/tw9b0oAD57goaH42tteLgNurX8
 tI53rNzt9kc1KIOr2ByQekWcerLf8wZ28xvbEIJQtWwjAS21Aq5OE92kp1XdHZd35CTgHpWzwfH
 4CGFpJSoCaVXaePdsjXiYv3EeG9QCPz1bbzDuiNRZ+BYDI3nRXJiJvhGIeeH3fOFLMRaCS12cJd
 L/RyFxm9Aq7qBVItMRV6rlpc3uBV2UVZiD3+ZTRmqUU4Fih9lsBgSbIaJVxXIlJLryeYUTNGyb/
 gPoK7wYNYNGV65wM0rehbrA0Zq3yDa6r+FW9/2rEQ7ycvRJf7f9yU+BGG8bMGmy0Q5ySRvLYrok
 ZeL8IBFpOj+c/KEBWKHgnozv80rtv5SvtBB9g5AbLLFarmD/AVpWfPO2mWsAJzVUPgySzYV9HTe
 ZLR3j5V3f60dnYwrFsXpAcr00hyC3m/dweUKASdI+ZWD8ITN1QQqDpiuzpfFt2CabvBM97DK8Fp
 n/+2um75XNMOQ2c+h5C7w/BDSpRTAZxGxiyUIMZMiUxFhli3qUoN3tOwGhrwvJLewaA0iIG9OI+
 n6ET+EnomLzqjxXwnu6ZV2rFz/wVqeoF+E7vLgi4wtzZALOkTMjAxaSqB3jFr+Wvk5tSxMA0JbD
 b0gdRAg==
X-Received: by 2002:a05:690e:1183:b0:65c:5fdb:e981 with SMTP id
 956f58d0204a3-65ec95f013dmr2942329d50.11.1779444100447; Fri, 22 May 2026
 03:01:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260521185025.30857-1-heinrich.schuchardt@canonical.com>
 <20260521185025.30857-2-heinrich.schuchardt@canonical.com>
 <CAC_iWjL_sY+oRBvaaVH9vB5b7uRdzoQKam+jndQY-gMoRfeetQ@mail.gmail.com>
 <11bab46d-0f42-41a0-95e5-8cba08eb0a48@canonical.com>
In-Reply-To: <11bab46d-0f42-41a0-95e5-8cba08eb0a48@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 22 May 2026 13:01:04 +0300
X-Gm-Features: AVHnY4Kjh_5qt79ndMNyM9eDBX0LEfhLInhBAxAXzzaZV-aZEbl6bfUCGsLj1OI
Message-ID: <CAC_iWjLF7-TavWNCFk1tXgDAPb92ZRoMWqHAJeixL-jdQivXnQ@mail.gmail.com>
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

Hi Heinrich,

On Fri, 22 May 2026 at 11:51, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 5/22/26 09:50, Ilias Apalodimas wrote:
> > Hi Heinrich,
> >
> > On Thu, 21 May 2026 at 21:50, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >>
> >> Both efi_add_memory_map() and efi_install_configuration_table() expect
> >> pointers and not virtual sandbox addresses.
> >
> > efi_add_memory_map() expects a PA afaict. EFI is identify mapped so
> > that will make no differece, but we can be a bit explicit on the
> > commit message
>
> Virtual sandbox addresses are not virtual addresses in the EFI sense.
>
> They are offsets in a memory chunked retrieved via mmap().
>
> On sandbox_defconfig:
>
> => echo $loadaddr
> 0x0
>
> 0x0 is definitively not the address of the mmap'ed memory chunk. It is
> the offset inside the mmap'ed memory chunk.
>
> We must not use these values in the EFI memory map, ACPI tables, or
> anything else an application launched by the sandbox accesses.
>
> >
> >>
> >> We need to convert the virtual sandbox addresses in efi_acpi_register() to
> >> pointers in memory before using them.
> >>
> >> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >> ---
> >>   lib/efi_loader/efi_acpi.c | 42 ++++++++++++++++++++++++---------------
> >>   1 file changed, 26 insertions(+), 16 deletions(-)
> >>
> >> diff --git a/lib/efi_loader/efi_acpi.c b/lib/efi_loader/efi_acpi.c
> >> index 046986a7518..70cb896ac25 100644
> >> --- a/lib/efi_loader/efi_acpi.c
> >> +++ b/lib/efi_loader/efi_acpi.c
> >> @@ -25,7 +25,7 @@ static const efi_guid_t acpi_guid = EFI_ACPI_TABLE_GUID;
> >>    */
> >>   efi_status_t efi_acpi_register(void)
> >>   {
> >> -       ulong addr, start, end;
> >> +       void *addr, *start, *end;
> >>          efi_status_t ret;
> >>
> >>          /*
> >> @@ -37,39 +37,49 @@ efi_status_t efi_acpi_register(void)
> >>           */
> >>          if (IS_ENABLED(CONFIG_BLOBLIST_TABLES)) {
> >>                  int size;
> >> -               void *tab = bloblist_get_blob(BLOBLISTT_ACPI_TABLES, &size);
> >>
> >> -               if (!tab)
> >> +               addr = bloblist_get_blob(BLOBLISTT_ACPI_TABLES, &size);
> >> +
> >> +               if (!addr)
> >>                          return EFI_NOT_FOUND;
> >> -               addr = map_to_sysmem(tab);
>
> In the previous code:
>
> `tab` is a pointer which you can use to address memory.
> `addr` is an offset to the memory that sandbox has claimed via mmap().
>
> >>
> >> -               ret = efi_add_memory_map(addr, size,
>
> So instead of passing a memory address we were passing here an offset.
> This is wrong.

Yea that makes sense. I was was remembering map_to_sysmem() wrong.

One nit though since you'll send a v2 for selftests. Can you cast
(u64)(uintptr_t)addr instead of (uintptr_t)addr;

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>
> >
> > Why was this wrong? Isn't addr after map_to_sysmem() going to return a
> > PA in normal hardware and the whatever sandbox has mapped? I think
> > this will break the sandbox case for both cases.
>
> No, map_to_sysmem() returns an offset to an mmap'ed memory chunk.
> But in the EFI memory map we need the addresses that can be used as
> pointers.
>
> Best regards
>
> Heinrich
>
> >
> >> +               ret = efi_add_memory_map((uintptr_t)addr, size,
> >>                                           EFI_ACPI_RECLAIM_MEMORY);
> >>                  if (ret != EFI_SUCCESS)
> >>                          return ret;
> >>          } else {
> >>                  /* Mark space used for tables */
> >> -               start = ALIGN_DOWN(gd->arch.table_start, EFI_PAGE_MASK);
> >> -               end = ALIGN(gd->arch.table_end, EFI_PAGE_MASK);
> >> -               ret = efi_add_memory_map(start, end - start,
> >> +               start = (void *)ALIGN_DOWN(
> >> +                       (uintptr_t)map_sysmem(gd->arch.table_start, 0),
> >> +                       (uintptr_t)EFI_PAGE_MASK);
> >> +               end = (void *)ALIGN((uintptr_t)map_sysmem(gd->arch.table_end,
> >> +                                                         0),
> >> +                                   (uintptr_t)EFI_PAGE_MASK);
> >> +               ret = efi_add_memory_map((uintptr_t)start,
> >> +                                        (uintptr_t)end - (uintptr_t)start,
> >>                                           EFI_ACPI_RECLAIM_MEMORY);
> >>                  if (ret != EFI_SUCCESS)
> >>                          return ret;
> >>                  if (gd->arch.table_start_high) {
> >> -                       start = ALIGN_DOWN(gd->arch.table_start_high,
> >> -                                          EFI_PAGE_MASK);
> >> -                       end = ALIGN(gd->arch.table_end_high, EFI_PAGE_MASK);
> >> -                       ret = efi_add_memory_map(start, end - start,
> >> +                       start = (void *)ALIGN_DOWN(
> >> +                               (uintptr_t)map_sysmem(gd->arch.table_start_high,
> >> +                                                     0),
> >> +                               (uintptr_t)EFI_PAGE_MASK);
> >> +                       end = (void *)ALIGN((uintptr_t)map_sysmem(
> >> +                                                   gd->arch.table_end_high, 0),
> >> +                                           EFI_PAGE_MASK);
> >> +                       ret = efi_add_memory_map((uintptr_t)start
> >
> > [...]
> >
> > Thanks
> > /Ilias
>
