Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 586FDC282DE
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 07:15:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67D8180540;
	Thu, 13 Mar 2025 08:15:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LuPK/BUJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15F4280548; Thu, 13 Mar 2025 08:15:23 +0100 (CET)
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com
 [IPv6:2607:f8b0:4864:20::92c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9C578003E
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 08:15:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-86d6976f768so282305241.1
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 00:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741850061; x=1742454861; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wIuSlzoyTU4u1Y3Zzn+0+G5NKfeVdtWFBwnNqoT9EJc=;
 b=LuPK/BUJIkJGd2PM3NE5DdToM3iHhXAUIiJFOhd2qQsiaqqhT1MV1n08hTA8PMOrDN
 1tT+zGczios+13bRxOMGcxII1Fj1a6FhFc0Cm8DCfO9y82vskzQO5UOkROhdpTF2b9sr
 ROXACNVUAb6UCBFJdgZPfKDqDnSImQkGN9N4fpzJ8YoiZwS3TaHd7n47GWFRkpbnMZ2h
 uaZmlR6Wcm0PDLAZaMWqVlJClN2wDhBlkgW0iyyD1PgMOj8CwXDke/xSXcT8/m/KFddF
 9xrXRR/22gujNPAg3yuQUnjxXxFDayePN6wasVecJmAUUlcGNRrVSRao0wqOPO+SWlXv
 7t9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741850061; x=1742454861;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wIuSlzoyTU4u1Y3Zzn+0+G5NKfeVdtWFBwnNqoT9EJc=;
 b=sg4uf1/eSKSvJEGx90gXd8gyRkExGI+S4TJiOjYPOK6lDUnt7C80PHAP/JHf7Yr/lx
 L1IILsuONMj0nW8E5x+7Kpr1FBdrk51kIByPmiaKuw8QiyUiY2RRK4AK2P7CweMf70Xx
 s8dTayi6O23b2auYwvAIeUf2jnAiWPcBxufCWSSNWA9M2ZpU7zSmNeSHzP/+Sbbh+Td7
 c1uQVbSHqRLQtzJjJJXbCzOhN3mr2LuGOAAwzMWhOpsw2Y6Bnko+Gswbrq7WdcufC2fP
 imdu6XAal2f7lBCyeWP0ReuHu8QjCClOMNryhogzLzKelW5r7ODpp0WD0///UTFJTErP
 Z7LA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQ3Hy5Y4DbWLcwzvpXA4kjGk4rgdxsdbPlmbDoZtGfj/qQqyPxqIhSRJYEyEd4/7rIWoXppN8=@lists.denx.de
X-Gm-Message-State: AOJu0YwRq65yeOI1VFFi2y8hnLr3vThnSjXLkVXbYpOBow0gES9+GY59
 ZN5MRpMcuQUMZbSoaunisUIsYhERaQLyeTg+FndhCsUkqFjeRZUEGuT7W9KpZN14IcrrdQuN82r
 2rb4VEvXKpnQP2b/BodpagVnHCAE/+aQQvPPRUA==
X-Gm-Gg: ASbGncvIEgeCX3BLkmK368OJrrjc0Wc/gCny4WnHo/R26Gk0PuNeX504779Y35klpdp
 pcWKH5d5Lzi1+dLe20v64celG5k8phpmuuYQTeoz2A4srEWFeJWpO1boXKes3P3CEOQ73eJ6hmT
 aPTW4YoIX5Z+v5giVif8zPwpWdkIjPtpkC7VGKBg==
X-Google-Smtp-Source: AGHT+IGrjeLv0s9v32+i6sqChJIs8iRtNV6yAvrYN/W6WyU7nxoyRjjn547nb6z3N3LR79KWCTpyNHXNoxvTLxQ4//4=
X-Received: by 2002:a05:6102:f8b:b0:4c1:903e:7bed with SMTP id
 ada2fe7eead31-4c30a35d93fmr21173979137.0.1741850061464; Thu, 13 Mar 2025
 00:14:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250312085424.1201148-1-sughosh.ganu@linaro.org>
 <20250312085424.1201148-3-sughosh.ganu@linaro.org>
 <8d8b3709-3619-41c3-999c-2021ccb2300d@canonical.com>
In-Reply-To: <8d8b3709-3619-41c3-999c-2021ccb2300d@canonical.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Thu, 13 Mar 2025 12:44:10 +0530
X-Gm-Features: AQ5f1JoNBgGjY_S9qYsQznHdbOqxMcsP9yYWftV8W9vDFQLBcSSIc6fvfQsF82s
Message-ID: <CADg8p96nRGRmBh5fgJmvrQ2Exr22=PvpGVU0FTRXWn=0QFXS4A@mail.gmail.com>
Subject: Re: [PATCH v8 2/8] efi_loader: install device-tree on configuration
 table on every invocation
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Anton Antonov <Anton.Antonov@arm.com>, 
 Tobias Waldekranz <tobias@waldekranz.com>, u-boot@lists.denx.de
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

On Thu, 13 Mar 2025 at 01:40, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 12.03.25 09:54, Sughosh Ganu wrote:
> > The efi_install_fdt() function is called before booting an EFI binary,
> > either directly, or through a bootmanager. This function installs a
> > copy of the device-tree(DT) on the EFI configuration table, which is
> > passed on to the OS.
> >
> > The current logic in this function does not install a DT if the table
> > already has a DT installed on it. However, this existing copy of the
>
> The device-tree is the configuration table. Maybe better write:
>
> ... if a device-tree is already installed as an EFI configuration table.

Oh. Isn't the device-tree *one* of the entries on the configuration
table? I mean, the spec says this, "The EFI Configuration table is the
ConfigurationTable field in the EFI System Table. This table contains
a set of GUID/pointer pairs". And one of these pairs happens to be the
DT.

>
> > DT might not be up-to-date, or it could be a wrong DT for the image
> > that is being booted. Always install a DT afresh to the configuration
> > table before booting the EFI binary.
> >
> > Installing a new DT also involves some additional checks that are
> > needed to clean up memory associated with the existing DT copy. Check
> > for an existing copy, and free up that memory.
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> > Changes since V7:
> > * Change the type of fdt_pages to efi_uintn_t
> > * Remove the check for either of fdt_pages or new_fdt_addr being 0
> > * Change the format specifier for fdt_pages in the debug messages for
> >    size_t
> > * Put the assignment of new_fdt_addr and fdt_pages on separate lines
> >    to avoid checkpatch error
> >
> >
> >   lib/efi_loader/efi_helper.c | 32 ++++++++++++++++++++++----------
> >   1 file changed, 22 insertions(+), 10 deletions(-)
> >
> > diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
> > index 15ad042bc61..37e5859741f 100644
> > --- a/lib/efi_loader/efi_helper.c
> > +++ b/lib/efi_loader/efi_helper.c
> > @@ -454,11 +454,21 @@ efi_status_t efi_env_set_load_options(efi_handle_t handle,
> >    */
> >   static efi_status_t copy_fdt(void **fdtp)
> >   {
> > -     unsigned long fdt_pages;
> >       efi_status_t ret = 0;
> >       void *fdt, *new_fdt;
> > -     u64 new_fdt_addr;
> > -     uint fdt_size;
> > +     static u64 new_fdt_addr;
> > +     static efi_uintn_t fdt_pages;
> > +     ulong fdt_size;
> > +
> > +     if (new_fdt_addr) {
> > +             log_debug("%s: Found allocated memory at %#llx, with %#zx pages\n",
> > +                       __func__, new_fdt_addr, fdt_pages);
> > +             ret = efi_free_pages(new_fdt_addr, fdt_pages);
>
> We should not free the memory before removing the configuration table.
> Otherwise in an error situation we might end up with an invalid
> device-tree pointer.

Yes, that is a good point. Will add this change.

>
> /* Ignoring EFI_NOT_FOUND if not device-tree is installed */
> efi_install_configuration_table(&efi_guid_fdt, NULL);
> if (new_fdt_addr) {
>         ret = efi_free_pages(new_fdt_addr, fdt_pages);
>         ...
>
> > +             if (ret != EFI_SUCCESS) {
> > +                     log_err("Unable to free up existing FDT memory region\n");
>  > +                    return ret;> +          }
>
> Ok, something weird happened. But this should not stop booting.

Okay, so I now see that none of the EFI code seems to be checking the
return value of the efi_free_{pages, pool} functions.

>
> Just set new_fdt_addr = 0 in any case.
>
>         if (ret!= EFI_SUCCES)
>                 log_err("Failed to free existing FDT memory\n");
>         new_fdt_addr = 0;
>
> > +     }
> >
> >       /*
> >        * Give us at least 12 KiB of breathing room in case the device tree
> > @@ -472,16 +482,21 @@ static efi_status_t copy_fdt(void **fdtp)
> >                                EFI_ACPI_RECLAIM_MEMORY, fdt_pages,
> >                                &new_fdt_addr);
> >       if (ret != EFI_SUCCESS) {
> > +             new_fdt_addr = 0;
>
> efi_allocate_pages() only updates new_fdt_addr() in case of success.
> If we set new_fdt_addr = 0 above, this line might be removed.

Okay

>
> > +             fdt_pages = 0;
>
> This line is not really needed as our if-statements don't use it.

Yeah, but it just feels weird just zeroing out one of the parameters
and not the other. Someone who reads this code later might find it
odd. And I am sure that the compiler would be doing the necessary
optimisations. If you don't have a strong opinion on this, I would
prefer this stay.

-sughosh

>
> Best regards
>
> Heinrich
>
> >               log_err("Failed to reserve space for FDT\n");
> > -             goto done;
> > +             return ret;
> >       }
> > +     log_debug("%s: Allocated memory at %#llx, with %#zx pages\n",
> > +               __func__, new_fdt_addr, fdt_pages);
> > +
> >       new_fdt = (void *)(uintptr_t)new_fdt_addr;
> >       memcpy(new_fdt, fdt, fdt_totalsize(fdt));
> >       fdt_set_totalsize(new_fdt, fdt_size);
> >
> > -     *fdtp = (void *)(uintptr_t)new_fdt_addr;
> > -done:
> > -     return ret;
> > +     *fdtp = new_fdt;
> > +
> > +     return EFI_SUCCESS;
> >   }
> >
> >   /**
> > @@ -534,9 +549,6 @@ efi_status_t efi_install_fdt(void *fdt)
> >               const char *fdt_opt;
> >               uintptr_t fdt_addr;
> >
> > -             /* Look for device tree that is already installed */
> > -             if (efi_get_configuration_table(&efi_guid_fdt))
> > -                     return EFI_SUCCESS;
> >               /* Check if there is a hardware device tree */
> >               fdt_opt = env_get("fdt_addr");
> >               /* Use our own device tree as fallback */
>
