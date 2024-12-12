Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB59E7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 13:45:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55275800CF;
	Thu, 12 Dec 2024 14:45:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BlqEeEHR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A4D780209; Thu, 12 Dec 2024 14:45:30 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 432038008A
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 14:45:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-aa689a37dd4so110027066b.3
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 05:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734011128; x=1734615928; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Mg+5HP6MhUvELT4ln7Tr6W6dloeSu8Tag7qglFgJMfs=;
 b=BlqEeEHRjajrRVHjz9MjzdMp5J1r3OuUqtfW69wHwHmN1rekitsA7cjCRsbfpT4sxF
 6SHKIsQKVgGJR+CqIWGpHJYFClMYyzHFZwjz0Js/PUITNluPGRsjO5p9zKYqiVU89K8k
 0SFavGNElffRkOUqYY9waoZr2919zvJjKUvyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734011128; x=1734615928;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Mg+5HP6MhUvELT4ln7Tr6W6dloeSu8Tag7qglFgJMfs=;
 b=jjrIke3Csl9r+oquxr6CM9XmiUyI3O3ewM27OaBj6MLyimBmOo86/KtBcrHuMykwzY
 Wdtq3yTjAvevKkWmWR+1mgZJg0NofRtbW0VFj2fZeUJXrviorFko9UfN2g38Unnfk9xV
 fb5sJegaKiszBy+UGss8j6L6sMXsJrxHXQmnB8RQLLOb/gP0sWhyx39/VJjqgFB7qNRz
 bykPzbi9V7ooJPtmfoigEMSiOGhmCe4e/OZzsw1WSgeLfHuWvT5bC99j35v1DEFjWh9D
 2f4YnkJXAzdZm6IUWQ8m1aQwAQPBBLqHnAoEgHZTHGetfv7x6w/0qTId6zY4a4t7P88G
 UwcA==
X-Gm-Message-State: AOJu0YyhufzKfGtCEeIo+hLHdNPdQ/PAS7wk3f5l2ZRNoTuExaxJJ35E
 rbG8h8k2Nbc3LxgW1P/eFeHSFWkCMuLru+gZpgM7lWuMq+8i8i4mOk9vJtsEL/VtAvC6nQ1qRrK
 gocnzbe67GXhIeRbyAzjhm5qZWSmpZotEejI1
X-Gm-Gg: ASbGncvlACees61imp3/sbdQawTaMdn0BtF/ItWQhdTuyfa6Ii2Dsd146B+aAL24u1j
 ubdaxlYgdKBudaa5sPTjLjNnKrptkUY24YNlUB1c=
X-Google-Smtp-Source: AGHT+IEO1Qznejk1jUPTSvNHczV/V5XmLU1rNXBTHiDX2v9XA28fnfwWsSy71LF7X9qJftAN5lsfmGV/o/obo3P4ia0=
X-Received: by 2002:a17:907:1ca7:b0:aa6:77e6:ea3d with SMTP id
 a640c23a62f3a-aa6b1378bfamr804796266b.45.1734011127647; Thu, 12 Dec 2024
 05:45:27 -0800 (PST)
MIME-Version: 1.0
References: <20241211223822.2446254-1-sjg@chromium.org>
 <20241211223822.2446254-6-sjg@chromium.org>
 <CAC_iWjLk_moWeTpo-dR_FV7E4+40U0S+DjD5dd3nWhf2KSGDrg@mail.gmail.com>
In-Reply-To: <CAC_iWjLk_moWeTpo-dR_FV7E4+40U0S+DjD5dd3nWhf2KSGDrg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 12 Dec 2024 06:45:16 -0700
Message-ID: <CAFLszTh1wPrjXu7oJrdUGqyGEFLC-mZ4JzuwXuiUjegpqhPA9g@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] efi_loader: Move the fallback code from
 efi_run_image()
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Moritz Fischer <moritzf@google.com>
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

On Thu, 12 Dec 2024 at 00:53, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Checkpatch has errors on this. Please have a look

It's the brackets not matching up because of
efi_uninstall_multiple_protocol_interfaces() being so long. It also
complains about possible blank lines at the end of the file, but that
isn't correct.

>
> Also for some reason is fails to apply after patch 4.

It is based on top of the other series (confusion between pointers and
addresses). I can send it independently if you'd like to apply this
one first.

>
> Thanks
> /Ilias
>
>
> On Thu, 12 Dec 2024 at 00:38, Simon Glass <sjg@chromium.org> wrote:
> >
> > This code is only needed if an invalid image/device path is passed in.
> > Move the code out to a caller where this can be dealt with. The normal
> > flow will provide these parameters.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >  lib/efi_loader/efi_bootbin.c | 103 ++++++++++++++++-------------------
> >  1 file changed, 48 insertions(+), 55 deletions(-)
> >
> > diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
> > index 8ebd48547cb..582b2745ced 100644
> > --- a/lib/efi_loader/efi_bootbin.c
> > +++ b/lib/efi_loader/efi_bootbin.c
> > @@ -147,36 +147,13 @@ static efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size,
> >                                   struct efi_device_path *device,
> >                                   struct efi_device_path *image)
> >  {
> > -       efi_handle_t mem_handle = NULL, handle;
> > -       struct efi_device_path *file_path = NULL;
> > -       struct efi_device_path *msg_path;
> > +       efi_handle_t handle;
> > +       struct efi_device_path *msg_path, *file_path;
> >         efi_status_t ret;
> >         u16 *load_options;
> >
> > -       if (!device || !image) {
> > -               log_debug("Not loaded from disk\n");
> > -               /*
> > -                * Special case for efi payload not loaded from disk,
> > -                * such as 'bootefi hello' or for example payload
> > -                * loaded directly into memory via JTAG, etc:
> > -                */
> > -               file_path = efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE,
> > -                                           source_buffer, source_size);
> > -               /*
> > -                * Make sure that device for device_path exist
> > -                * in load_image(). Otherwise, shell and grub will fail.
> > -                */
> > -               ret = efi_install_multiple_protocol_interfaces(&mem_handle,
> > -                                                              &efi_guid_device_path,
> > -                                                              file_path, NULL);
> > -               if (ret != EFI_SUCCESS)
> > -                       goto out;
> > -               msg_path = file_path;
> > -       } else {
> > -               file_path = efi_dp_concat(device, image, 0);
> > -               msg_path = image;
> > -               log_debug("Loaded from disk\n");
> > -       }
> > +       file_path = efi_dp_concat(device, image, 0);
> > +       msg_path = image;
> >
> >         log_info("Booting %pD\n", msg_path);
> >
> > @@ -195,36 +172,13 @@ static efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size,
> >         ret = do_bootefi_exec(handle, load_options);
> >
> >  out:
> > -       if (mem_handle) {
> > -               efi_status_t r;
> > -
> > -               r = efi_uninstall_multiple_protocol_interfaces(
> > -                       mem_handle, &efi_guid_device_path, file_path, NULL);
> > -               if (r != EFI_SUCCESS)
> > -                       log_err("Uninstalling protocol interfaces failed\n");
> > -       }
> > -       efi_free_pool(file_path);
> >
> >         return ret;
> >  }
> >
> > -/**
> > - * efi_binary_run_() - run loaded UEFI image
> > - *
> > - * @image_ptr: memory address of the UEFI image
> > - * @size:      size of the UEFI image
> > - * @fdt:       device-tree
> > - * @device:    EFI device-path
> > - * @image:     EFI image-path
> > - *
> > - * Execute an EFI binary image loaded at @image.
> > - * @size may be zero if the binary is loaded with U-Boot load command.
> > - *
> > - * Return:     status code
> > - */
> > -efi_status_t efi_binary_run_(void *image_ptr, size_t size, void *fdt,
> > -                            struct efi_device_path *device,
> > -                            struct efi_device_path *image)
> > +static efi_status_t efi_binary_run_(void *image_ptr, size_t size, void *fdt,
> > +                                   struct efi_device_path *device,
> > +                                   struct efi_device_path *image)
> >  {
> >         efi_status_t ret;
> >
> > @@ -257,6 +211,45 @@ efi_status_t efi_binary_run_(void *image_ptr, size_t size, void *fdt,
> >   */
> >  efi_status_t efi_binary_run(void *image, size_t size, void *fdt)
> >  {
> > -       return efi_binary_run_(image, size, fdt, bootefi_device_path,
> > -                              bootefi_image_path);
> > +       efi_handle_t mem_handle = NULL;
> > +       struct efi_device_path *file_path = NULL;
> > +       efi_status_t ret;
> > +
> > +       if (!bootefi_device_path || !bootefi_image_path) {
> > +               log_debug("Not loaded from disk\n");
> > +               /*
> > +                * Special case for efi payload not loaded from disk,
> > +                * such as 'bootefi hello' or for example payload
> > +                * loaded directly into memory via JTAG, etc:
> > +                */
> > +               file_path = efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE, image,
> > +                                           size);
> > +               /*
> > +                * Make sure that device for device_path exist
> > +                * in load_image(). Otherwise, shell and grub will fail.
> > +                */
> > +               ret = efi_install_multiple_protocol_interfaces(&mem_handle,
> > +                                                              &efi_guid_device_path,
> > +                                                              file_path, NULL);
> > +               if (ret != EFI_SUCCESS)
> > +                       goto out;
> > +       } else {
> > +               log_debug("Loaded from disk\n");
> > +       }
> > +
> > +       ret = efi_binary_run_(image, size, fdt, bootefi_device_path,
> > +                             bootefi_image_path);
> > +out:
> > +       if (mem_handle) {
> > +               efi_status_t r;
> > +
> > +               r = efi_uninstall_multiple_protocol_interfaces(mem_handle,
> > +                                       &efi_guid_device_path, file_path, NULL);
> > +               if (r != EFI_SUCCESS)
> > +                       log_err("Uninstalling protocol interfaces failed\n");
> > +       }
> > +       efi_free_pool(file_path);
> > +
> > +       return ret;
> >  }
> > +
> > --
> > 2.34.1
> >
