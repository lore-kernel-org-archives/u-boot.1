Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B75EC36008
	for <u-boot@archiver.kernel.org>; Wed, 26 Mar 2025 11:05:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73D038070C;
	Wed, 26 Mar 2025 12:05:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="azu88yXm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 557358083E; Wed, 26 Mar 2025 12:05:09 +0100 (CET)
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com
 [IPv6:2607:f8b0:4864:20::933])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAC14806FC
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 12:05:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ua1-x933.google.com with SMTP id
 a1e0cc1a2514c-86f9c719d63so2543309241.1
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 04:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742987100; x=1743591900; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1/zdG6EvX+XZYhY+1JEy/b7sRIXsk2lGsnxrWebqdNU=;
 b=azu88yXmrhfcC73PKmcSxX3DnXqHy9y09dC/FSBJFStemNTVI2BwgOHrUpZ/fG+NcR
 GopGEygxhR2gsKjYtZv9maqlY+ed4+x+3LHdqfppI6EOE7S7Xr30uq6PHmAeR0LDOP7q
 s4b5gw/qMuTUJLpz1pla9ey1XlXfVA0rtiyXIyjJT4SNWeeyOZBNKbgxqrMNuyy8XNlv
 f+emdE/Z+QJunrArhQST3z6LWWf7xAv8f/LPIzLQRsu7D4OOSWCqn5Bj0+tt2QquMRC7
 wWyuy+W0gFoNbnC/g695hsK5MpsdjQn/8uOgB7/Uvj265HQUPm5EBxCy6m36Px12yV/P
 3IzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742987100; x=1743591900;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1/zdG6EvX+XZYhY+1JEy/b7sRIXsk2lGsnxrWebqdNU=;
 b=vCAeYXem5B6TQnF0RuUp3/V9wAQm0HsdiYu/TiqeKiU7TsbuyVlP1y2axtSrlISUis
 0/of/LWGu0fIRrqdbRFrbFdoQxRiOLpGp+eyxDNIFVVocfFxIinBg/PboD8pc4hT+2mc
 LJPz9p9yzVIPsXMD3rTdhkArr345CjEX4nTNcsQmkrhA7scwsc6zYzOeiXs6vYmAC2RT
 GVAibvR3ni2ijvNQv4f880YzpUzrPghTttm/avkhVYfUUw0sLV2yzSwt5zYJ8H4NbhWH
 hg0QBhktG4HYbBMkK1PAXy/3vNwhZMxQbgqXFwqR8ltfBlQ/iYe8hMVdQ99o3COpWBOb
 jTlg==
X-Gm-Message-State: AOJu0Yw13036QJ5iPPSVERo6gdjQh9fwhBj2ydlaVelIKFYfBi/RZvea
 0M07QvPBEoD/UKLnlXH6teykPzw4krhur5uR14gez8HzfZFqQEJVLAZQdtc9VveTkopaci8EUQV
 suNxWzYbwa8rx/tiA04Bn35X7mBp7H72vyi8etQ==
X-Gm-Gg: ASbGncv2w8dE8LcDSZ+Uw4coQCmDd7bachU+JnQm7vLZE7dA7eRGo0jqEO8gHxxTS1X
 1jRJw4ibQyoSRDU+NDG9KhsymZP/prMXTblsLROvfUZDP4/GdU2wYzBDHsCJ4EpLVW5Kln8AglF
 Y50cJ7nFwKkp99tFpXj8tQvOyIG+d8ZBbx8ko0Fg==
X-Google-Smtp-Source: AGHT+IGgggL+dTTxQZ3806QeyyfFaT0mnafSy70hWILiOktadfZPKroLmkYuT/VKRSyWU33PbM0yUu133nPc1rLgrWs=
X-Received: by 2002:a05:6102:c4c:b0:4bb:b589:9d95 with SMTP id
 ada2fe7eead31-4c50d4923d2mr15296700137.4.1742987099865; Wed, 26 Mar 2025
 04:04:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250317083402.412310-1-sughosh.ganu@linaro.org>
 <20250317083402.412310-3-sughosh.ganu@linaro.org>
 <CAC_iWjJgOwvovyLTtiDu3PqMvCFX4SrOGj6CCE5QQMV-Ypq=Tw@mail.gmail.com>
In-Reply-To: <CAC_iWjJgOwvovyLTtiDu3PqMvCFX4SrOGj6CCE5QQMV-Ypq=Tw@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Wed, 26 Mar 2025 16:34:48 +0530
X-Gm-Features: AQ5f1JptyNk3wdDUrbFMKQ21uqdpb90L8j8yKBYFfQ5iQKuEl1pM5-KBLl8YPXg
Message-ID: <CADg8p96AwQQvR-0C7QfggKtoLGT1Hn4zcAAww-bH-Cc2=HdABA@mail.gmail.com>
Subject: Re: [PATCH v9 2/8] efi_loader: install device-tree on configuration
 table on every invocation
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Anton Antonov <Anton.Antonov@arm.com>, 
 Tobias Waldekranz <tobias@waldekranz.com>
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

On Wed, 26 Mar 2025 at 13:54, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Sughosh
>
> On Mon, 17 Mar 2025 at 10:34, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > The efi_install_fdt() function is called before booting an EFI binary,
> > either directly, or through a bootmanager. This function installs a
> > copy of the device-tree(DT) on the EFI configuration table, which is
> > passed on to the OS.
> >
> > The current logic in this function does not install a DT if a
> > device-tree is already installed as an EFI configuration
> > table. However, this existing copy of the DT might not be up-to-date,
> > or it could be a wrong DT for the image that is being booted. Always
> > install a DT afresh to the configuration table before booting the EFI
> > binary.
> >
> > Installing a new DT also involves some additional checks that are
> > needed to clean up memory associated with the existing DT copy. Check
> > for an existing copy, and free up that memory.
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> > Changes since V8:
> > * Re-word the commit message to indicate DT being installed as EFI
> >   configuration table
> > * Remove the existing EFI config table in copy_fdt()
> > * Move assignment of new_fdt_addr and fdt_pages variables to the block
> >   freeing up the existing config table memory
> >
> >  lib/efi_loader/efi_helper.c | 39 +++++++++++++++++++++++++++----------
> >  1 file changed, 29 insertions(+), 10 deletions(-)
> >
> > diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
> > index 15ad042bc61..f6fbcdffe82 100644
> > --- a/lib/efi_loader/efi_helper.c
> > +++ b/lib/efi_loader/efi_helper.c
> > @@ -454,11 +454,30 @@ efi_status_t efi_env_set_load_options(efi_handle_t handle,
> >   */
> >  static efi_status_t copy_fdt(void **fdtp)
> >  {
> > -       unsigned long fdt_pages;
> >         efi_status_t ret = 0;
> >         void *fdt, *new_fdt;
> > -       u64 new_fdt_addr;
> > -       uint fdt_size;
> > +       static u64 new_fdt_addr;
> > +       static efi_uintn_t fdt_pages;
> > +       ulong fdt_size;
> > +
> > +       /*
> > +        * Remove the configuration table that might already be
> > +        * installed, ignoring EFI_NOT_FOUND if no device-tree
> > +        * is installed
> > +        */
> > +       efi_install_configuration_table(&efi_guid_fdt, NULL);
> > +
> > +       if (new_fdt_addr) {
> > +               log_debug("%s: Found allocated memory at %#llx, with %#zx pages\n",
> > +                         __func__, new_fdt_addr, fdt_pages);
> > +
> > +               ret = efi_free_pages(new_fdt_addr, fdt_pages);
> > +               if (ret != EFI_SUCCESS)
> > +                       log_err("Unable to free up existing FDT memory region\n");
> > +
> > +               new_fdt_addr = 0;
> > +               fdt_pages = 0;
> > +       }
> >
> >         /*
> >          * Give us at least 12 KiB of breathing room in case the device tree
> > @@ -473,15 +492,18 @@ static efi_status_t copy_fdt(void **fdtp)
> >                                  &new_fdt_addr);
> >         if (ret != EFI_SUCCESS) {
> >                 log_err("Failed to reserve space for FDT\n");
> > -               goto done;
> > +               return ret;
> >         }
> > +       log_debug("%s: Allocated memory at %#llx, with %#zx pages\n",
> > +                 __func__, new_fdt_addr, fdt_pages);
> > +
> >         new_fdt = (void *)(uintptr_t)new_fdt_addr;
> >         memcpy(new_fdt, fdt, fdt_totalsize(fdt));
> >         fdt_set_totalsize(new_fdt, fdt_size);
> >
> > -       *fdtp = (void *)(uintptr_t)new_fdt_addr;
> > -done:
> > -       return ret;
> > +       *fdtp = new_fdt;
> > +
> > +       return EFI_SUCCESS;
> >  }
> >
> >  /**
> > @@ -534,9 +556,6 @@ efi_status_t efi_install_fdt(void *fdt)
> >                 const char *fdt_opt;
> >                 uintptr_t fdt_addr;
> >
> > -               /* Look for device tree that is already installed */
> > -               if (efi_get_configuration_table(&efi_guid_fdt))
> > -                       return EFI_SUCCESS;
>
> This is the last nit I have an I think these are ready for  -next.
>
> Instead of removing the existing table in copy_fdt, can we remove it
> before calling copy_fdt() in efi_install_fdt()

I had actually thought about this, but did not put it in the
efi_install_fdt() as we have a case for GENERATE_ACPI_TABLE, where we
are not actually doing anything with the device-tree. So copy_fdt() is
the place where we know that we are going to install the DT as
configuration table, so then remove the existing configuration table.

>
> if (efi_get_configuration_table(&efi_guid_fdt))
>     efi_install_configuration_table(&efi_guid_fdt, NULL);
> should be enough and you can also check the return code that way

For the above scenario, we will not be getting any other error than
EFI_NOT_FOUND no? If you have a strong opinion on this, I can make the
change. Please let me know. Thanks.

-sughosh

>
> Cheers
> /Ilias
>
>
> >                 /* Check if there is a hardware device tree */
> >                 fdt_opt = env_get("fdt_addr");
> >                 /* Use our own device tree as fallback */
> > --
> > 2.34.1
> >
