Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 379F9E7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 15:42:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83B4980192;
	Thu, 12 Dec 2024 16:42:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Wdntw6UC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1936801BE; Thu, 12 Dec 2024 16:42:33 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53CB78018E
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 16:42:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-6eff5f99de4so8109647b3.1
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 07:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734018150; x=1734622950; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=T69HQygl46wPsEpNMQV0a503c/kVS/opY5UpmdtwrD8=;
 b=Wdntw6UCQvM2fmDU5fjRT8bK3OdWPsy8MH8+wBEnA5dEgPboyua9Zbwlnk2DfNv3+7
 pjnxVsHwhyxGQehvSkrjWWaU+M0yI8iiFYoAGHxQ+mHk580auTwhsqpEduAmPDFY4GKv
 p1b2in5CzU28bJBbn3pXIqQYYzYqzMOg1zKE00GMpvRt3m7oqKDsjv1o1Kx9XPB6F0O3
 QbSC8gQvUmygwwq64FcuTz1XbhlySkqp5sYd2LA6DIfp9hFVbBXf9/v9vpweYNimq056
 ofWlSNZkEf0aqKWAOkydViwx/tV4/f98J9iBwg6iIQ7+2VhJDSK8z+XVliTTfnVVo1Cf
 VIfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734018150; x=1734622950;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T69HQygl46wPsEpNMQV0a503c/kVS/opY5UpmdtwrD8=;
 b=r7bdDJpdLrRQ1yInMgktsWKDvyysWr4FjNU+dfcAWjWAxrYbLc5mLpODiIZSsS642C
 cogrZY3NehkWOAH+TGdzmW9oZNUx48eXWd27nr7mkHs8meaVyjZkajS9RaHgMmv/XpcL
 EHmJuHj34NzeUrRH7EFnmC9KWfiBY0rfw0JgJYTxoukeL5lrSo6o5S3Bxd9d5APm6wRN
 cy/PXslFj8HiZRuKauKXvgTI6pARGy+WgMMk907GD4MyyVww9zguf1Vp/ya/VbE2vqLA
 mGjb9Y9xPpxop8JPbB86FloihMU82UB7I17AzOKmjc8BG8XCSfD9DQOHqsVskBTeCRH2
 jyVQ==
X-Gm-Message-State: AOJu0YwYXk3wiY4cnFI2DpG0PZsJe6r0eskcBYnlnJsKsL+Rn30QA/Aw
 mG1mLAwYH4qdj6L8ESAPzBRvS0MCE1A4gcnfRtZkaIqvTPwqzLtn5KGQwo5OX8ovIgaZZ1zz//z
 +mYJJAa3W7N9fbRtspadAt/wSkG1xJQ7MMFaPBg==
X-Gm-Gg: ASbGncu30Be5f+oP1mUp/hb2ncYlzgtFnKbTG0+gDo3e5+ON5iFA1IqslN0YyPTMTxD
 Uon4L4qpMn6AoEx7NZ1d3K+W38iqiZTBV8OP7Dg==
X-Google-Smtp-Source: AGHT+IHVw1Az/KOiKBolIYc8SNrWTap3dSSCKXtaul5KUE3ok8Bbreg8+jatxlnTT+be9ewU7UpnIkOuupoNuzVjtxE=
X-Received: by 2002:a05:690c:601:b0:6ef:97a2:49ef with SMTP id
 00721157ae682-6f27525f347mr9570187b3.8.1734018150197; Thu, 12 Dec 2024
 07:42:30 -0800 (PST)
MIME-Version: 1.0
References: <20241211223822.2446254-1-sjg@chromium.org>
 <20241211223822.2446254-6-sjg@chromium.org>
 <CAC_iWjLk_moWeTpo-dR_FV7E4+40U0S+DjD5dd3nWhf2KSGDrg@mail.gmail.com>
 <CAFLszTh1wPrjXu7oJrdUGqyGEFLC-mZ4JzuwXuiUjegpqhPA9g@mail.gmail.com>
In-Reply-To: <CAFLszTh1wPrjXu7oJrdUGqyGEFLC-mZ4JzuwXuiUjegpqhPA9g@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 12 Dec 2024 17:41:54 +0200
Message-ID: <CAC_iWjJrXndvOAN3dL=vJUP7e5zYXGeGRVZofs0G-HH0t_0XLw@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] efi_loader: Move the fallback code from
 efi_run_image()
To: Simon Glass <sjg@chromium.org>
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

On Thu, 12 Dec 2024 at 15:45, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ilias,
>
> On Thu, 12 Dec 2024 at 00:53, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Checkpatch has errors on this. Please have a look
>
> It's the brackets not matching up because of
> efi_uninstall_multiple_protocol_interfaces() being so long. It also
> complains about possible blank lines at the end of the file, but that
> isn't correct.
>
> >
> > Also for some reason is fails to apply after patch 4.
>
> It is based on top of the other series (confusion between pointers and
> addresses). I can send it independently if you'd like to apply this
> one first.

Yes please, if it's not too much work. I think the other one still
needs bigger adjustments

Thanks
/Ilias
>
> >
> > Thanks
> > /Ilias
> >
> >
> > On Thu, 12 Dec 2024 at 00:38, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > This code is only needed if an invalid image/device path is passed in.
> > > Move the code out to a caller where this can be dealt with. The normal
> > > flow will provide these parameters.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > > (no changes since v1)
> > >
> > >  lib/efi_loader/efi_bootbin.c | 103 ++++++++++++++++-------------------
> > >  1 file changed, 48 insertions(+), 55 deletions(-)
> > >
> > > diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
> > > index 8ebd48547cb..582b2745ced 100644
> > > --- a/lib/efi_loader/efi_bootbin.c
> > > +++ b/lib/efi_loader/efi_bootbin.c
> > > @@ -147,36 +147,13 @@ static efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size,
> > >                                   struct efi_device_path *device,
> > >                                   struct efi_device_path *image)
> > >  {
> > > -       efi_handle_t mem_handle = NULL, handle;
> > > -       struct efi_device_path *file_path = NULL;
> > > -       struct efi_device_path *msg_path;
> > > +       efi_handle_t handle;
> > > +       struct efi_device_path *msg_path, *file_path;
> > >         efi_status_t ret;
> > >         u16 *load_options;
> > >
> > > -       if (!device || !image) {
> > > -               log_debug("Not loaded from disk\n");
> > > -               /*
> > > -                * Special case for efi payload not loaded from disk,
> > > -                * such as 'bootefi hello' or for example payload
> > > -                * loaded directly into memory via JTAG, etc:
> > > -                */
> > > -               file_path = efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE,
> > > -                                           source_buffer, source_size);
> > > -               /*
> > > -                * Make sure that device for device_path exist
> > > -                * in load_image(). Otherwise, shell and grub will fail.
> > > -                */
> > > -               ret = efi_install_multiple_protocol_interfaces(&mem_handle,
> > > -                                                              &efi_guid_device_path,
> > > -                                                              file_path, NULL);
> > > -               if (ret != EFI_SUCCESS)
> > > -                       goto out;
> > > -               msg_path = file_path;
> > > -       } else {
> > > -               file_path = efi_dp_concat(device, image, 0);
> > > -               msg_path = image;
> > > -               log_debug("Loaded from disk\n");
> > > -       }
> > > +       file_path = efi_dp_concat(device, image, 0);
> > > +       msg_path = image;
> > >
> > >         log_info("Booting %pD\n", msg_path);
> > >
> > > @@ -195,36 +172,13 @@ static efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size,
> > >         ret = do_bootefi_exec(handle, load_options);
> > >
> > >  out:
> > > -       if (mem_handle) {
> > > -               efi_status_t r;
> > > -
> > > -               r = efi_uninstall_multiple_protocol_interfaces(
> > > -                       mem_handle, &efi_guid_device_path, file_path, NULL);
> > > -               if (r != EFI_SUCCESS)
> > > -                       log_err("Uninstalling protocol interfaces failed\n");
> > > -       }
> > > -       efi_free_pool(file_path);
> > >
> > >         return ret;
> > >  }
> > >
> > > -/**
> > > - * efi_binary_run_() - run loaded UEFI image
> > > - *
> > > - * @image_ptr: memory address of the UEFI image
> > > - * @size:      size of the UEFI image
> > > - * @fdt:       device-tree
> > > - * @device:    EFI device-path
> > > - * @image:     EFI image-path
> > > - *
> > > - * Execute an EFI binary image loaded at @image.
> > > - * @size may be zero if the binary is loaded with U-Boot load command.
> > > - *
> > > - * Return:     status code
> > > - */
> > > -efi_status_t efi_binary_run_(void *image_ptr, size_t size, void *fdt,
> > > -                            struct efi_device_path *device,
> > > -                            struct efi_device_path *image)
> > > +static efi_status_t efi_binary_run_(void *image_ptr, size_t size, void *fdt,
> > > +                                   struct efi_device_path *device,
> > > +                                   struct efi_device_path *image)
> > >  {
> > >         efi_status_t ret;
> > >
> > > @@ -257,6 +211,45 @@ efi_status_t efi_binary_run_(void *image_ptr, size_t size, void *fdt,
> > >   */
> > >  efi_status_t efi_binary_run(void *image, size_t size, void *fdt)
> > >  {
> > > -       return efi_binary_run_(image, size, fdt, bootefi_device_path,
> > > -                              bootefi_image_path);
> > > +       efi_handle_t mem_handle = NULL;
> > > +       struct efi_device_path *file_path = NULL;
> > > +       efi_status_t ret;
> > > +
> > > +       if (!bootefi_device_path || !bootefi_image_path) {
> > > +               log_debug("Not loaded from disk\n");
> > > +               /*
> > > +                * Special case for efi payload not loaded from disk,
> > > +                * such as 'bootefi hello' or for example payload
> > > +                * loaded directly into memory via JTAG, etc:
> > > +                */
> > > +               file_path = efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE, image,
> > > +                                           size);
> > > +               /*
> > > +                * Make sure that device for device_path exist
> > > +                * in load_image(). Otherwise, shell and grub will fail.
> > > +                */
> > > +               ret = efi_install_multiple_protocol_interfaces(&mem_handle,
> > > +                                                              &efi_guid_device_path,
> > > +                                                              file_path, NULL);
> > > +               if (ret != EFI_SUCCESS)
> > > +                       goto out;
> > > +       } else {
> > > +               log_debug("Loaded from disk\n");
> > > +       }
> > > +
> > > +       ret = efi_binary_run_(image, size, fdt, bootefi_device_path,
> > > +                             bootefi_image_path);
> > > +out:
> > > +       if (mem_handle) {
> > > +               efi_status_t r;
> > > +
> > > +               r = efi_uninstall_multiple_protocol_interfaces(mem_handle,
> > > +                                       &efi_guid_device_path, file_path, NULL);
> > > +               if (r != EFI_SUCCESS)
> > > +                       log_err("Uninstalling protocol interfaces failed\n");
> > > +       }
> > > +       efi_free_pool(file_path);
> > > +
> > > +       return ret;
> > >  }
> > > +
> > > --
> > > 2.34.1
> > >
