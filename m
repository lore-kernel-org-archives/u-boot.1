Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DFE5E7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 15:53:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9405B80317;
	Wed, 11 Dec 2024 16:53:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GfxEDpC6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15AA480327; Wed, 11 Dec 2024 16:53:54 +0100 (CET)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B21948034E
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 16:53:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2161eb95317so51301965ad.1
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 07:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733932430; x=1734537230; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cshEtzifr1JhqmcoJc9qI+mOT6A9t0I/EQOkWJ20XYA=;
 b=GfxEDpC6YMmWdLk58Kz1t7QcWD54oQ7GzdPTRMOla0Fl1lkZdnbIkORk2dbcjse/Wl
 Yu2/WdjQxOuZkUZEr2IuwlXdcAbls8ynzq8osBseSpRTH5PJzurG9hWCzGhr9tdpt6Si
 eoedw/RAzfO9aD84rNF0CIBffi9/XUKcxyq/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733932430; x=1734537230;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cshEtzifr1JhqmcoJc9qI+mOT6A9t0I/EQOkWJ20XYA=;
 b=ABbKEPUWp/ouFUESsNqoSG7RxalT+CiM4ydATH4a62nMkRtCUxUK07bwfaRciT4ujP
 jqZq+BfW6xyb/ylcRZUHTu49IWpwKMZq9oGaadH13DeLDMFnnonmHbf1WZlrXsl3io5G
 5dBMXd7AKGW35dqOL3rj8ijs+buxI+6t2xypLRjVZ0NileyOjakPus5TLAjubTbeVA9o
 MOEnkGfXbQU9jjilLh0e7WhNhE80yRDRcGIxmE6Ehs+ddeyZN2WyoyywttOvSUO8AaEK
 Bmmdz3DkslMhuz5F18JXqMxFo3u9E5lpcnz2q2FgYh5XPlwI3afKR27aAJtxeYwfEht3
 Hydw==
X-Gm-Message-State: AOJu0YyD+HllnDqDV1+v5Q1db2gVQmdNOK8+xwymSBBn1V0lfK5wYff1
 e3pxUHNjE6p/bUxbkAQ2jqSmHsyL3hO6GivID4OWnczERmaLe3tAXly+dhglK6uBfA8l52PUCfJ
 Q7yhW47UtW+rxZQUzaY4yzQOFVDCQ4bqAkcGb
X-Gm-Gg: ASbGncvC6AhJIGcct534DtlCvrOIMh7vEYlvGtHv7Xp4NLW24/kiUkXHJ16MHItcs8k
 fskcCUZlFxc58qJIhaenrLboSG6AT4G8dvEnY
X-Google-Smtp-Source: AGHT+IFC5sVNEmf2KzdVFWmiW0ePe7X4UTy+5pe2g50g+3vHAIX99EyMeTITVa/dgivCrUG3g80KcSCf8wxv8dcK4r0=
X-Received: by 2002:a17:902:e74e:b0:215:9470:7e82 with SMTP id
 d9443c01a7336-2177839710amr51810915ad.4.1733932430130; Wed, 11 Dec 2024
 07:53:50 -0800 (PST)
MIME-Version: 1.0
References: <20241211135418.563803-1-sjg@chromium.org>
 <20241211135418.563803-10-sjg@chromium.org>
 <CAC_iWj+g0Jzg3DMP2KgFnabhMe5U_L4mtvUYA+HUBms5_z5+BA@mail.gmail.com>
In-Reply-To: <CAC_iWj+g0Jzg3DMP2KgFnabhMe5U_L4mtvUYA+HUBms5_z5+BA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Dec 2024 08:53:32 -0700
Message-ID: <CAFLszThxT4NxAONLCJEt9beieFtuN4TWRPVV1byTvRNf8+===A@mail.gmail.com>
Subject: Re: [PATCH v5 09/23] efi_loader: Drop virtual_start from priv_mem_desc
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
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

Hi Ilias,

On Wed, 11 Dec 2024 at 08:09, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
>
> On Wed, 11 Dec 2024 at 15:54, Simon Glass <sjg@chromium.org> wrote:
> >
> > This field is always the same as physical_start, so keeping track of it
> > separately is unnecessary and confusing. Drop it.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >  lib/efi_loader/efi_memory.c | 10 +++-------
> >  1 file changed, 3 insertions(+), 7 deletions(-)
> >
> > diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> > index db40aee8353..8211600f7f6 100644
> > --- a/lib/efi_loader/efi_memory.c
> > +++ b/lib/efi_loader/efi_memory.c
> > @@ -37,7 +37,6 @@ efi_uintn_t efi_memory_map_key;
> >   * @type (enum efi_memory_type): EFI memory-type
> >   * @reserved: unused
> >   * @physical_start: Start address of region in physical memory
> > - * @virtual_start: Start address of region in physical memory
> >   * @num_pages: Number of EFI pages this record covers (each is EFI_PAGE_SIZE
> >   *     bytes)
> >   * @attribute: Memory attributes (see EFI_MEMORY...)
> > @@ -46,7 +45,6 @@ struct priv_mem_desc {
> >         u32 type;
> >         u32 reserved;
> >         efi_physical_addr_t physical_start;
> > -       efi_virtual_addr_t virtual_start;
> >         u64 num_pages;
> >         u64 attribute;
> >  };
> > @@ -187,7 +185,6 @@ static void efi_mem_sort(void)
> >                                 pages = cur->num_pages;
> >                                 prev->num_pages += pages;
> >                                 prev->physical_start -= pages << EFI_PAGE_SHIFT;
> > -                               prev->virtual_start -= pages << EFI_PAGE_SHIFT;
> >                                 list_del(&lmem->link);
> >                                 free(lmem);
> >
> > @@ -255,7 +252,6 @@ static s64 efi_mem_carve_out(struct efi_mem_list *map,
> >                         free(map);
> >                 } else {
> >                         map->desc.physical_start = carve_end;
> > -                       map->desc.virtual_start = carve_end;
> >                         map->desc.num_pages = (map_end - carve_end)
> >                                               >> EFI_PAGE_SHIFT;
> >                 }
> > @@ -276,7 +272,6 @@ static s64 efi_mem_carve_out(struct efi_mem_list *map,
> >                 return EFI_CARVE_OUT_OF_RESOURCES;
> >         newmap->desc = map->desc;
> >         newmap->desc.physical_start = carve_start;
> > -       newmap->desc.virtual_start = carve_start;
> >         newmap->desc.num_pages = (map_end - carve_start) >> EFI_PAGE_SHIFT;
> >         /* Insert before current entry (descending address order) */
> >         list_add_tail(&newmap->link, &map->link);
> > @@ -313,7 +308,6 @@ efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
> >                 return EFI_OUT_OF_RESOURCES;
> >         newlist->desc.type = memory_type;
> >         newlist->desc.physical_start = start;
> > -       newlist->desc.virtual_start = start;
> >         newlist->desc.num_pages = pages;
> >
> >         switch (memory_type) {
> > @@ -711,7 +705,9 @@ efi_status_t efi_get_memory_map(efi_uintn_t *memory_map_size,
> >                 memory_map->type = lmem->desc.type;
> >                 memory_map->reserved = lmem->desc.reserved;
> >                 memory_map->physical_start = lmem->desc.physical_start;
> > -               memory_map->virtual_start = lmem->desc.virtual_start;
> > +
> > +               /* virtual and physical are always the same */
> > +               memory_map->virtual_start = lmem->desc.physical_start;
> >                 memory_map->num_pages = lmem->desc.num_pages;
> >                 memory_map->attribute = lmem->desc.attribute;
> >                 memory_map--;
> > --
> > 2.34.1
> >
> I don't like duplicating efi_mem_desc and have a priv without the
> virtual address. I don't understand what you find confusing, but we
> have follows the spec (minus that reserved member) and I prefer it

We are still stuck on this address/pointer thing. As you will see at
the end of this series, I am changing the internal table to use
addresses, like lmb, so it is easier to understand what is going on...

Regards.

Simon
