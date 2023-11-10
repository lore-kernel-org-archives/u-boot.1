Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DDE7C4332F
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 07:19:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39F79877CC;
	Fri, 10 Nov 2023 08:19:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="C2EzrIcX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01B6387792; Fri, 10 Nov 2023 08:19:10 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAA1E877CC
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 08:19:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5441ba3e53cso2695275a12.1
 for <u-boot@lists.denx.de>; Thu, 09 Nov 2023 23:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699600746; x=1700205546; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XmnS80V2GoXgdJAu1TJBRnc9jrIImcI7OYxPaXgF1uE=;
 b=C2EzrIcXUklhZByuiVR6K4Puuf4Xoy4vtsfR4HWKID9PkuXCtc+cg5ebextMO9/p6z
 QOgk3PAkLwqo9QzRybHNHYrrt/vKKgexhN7dYR3jEUHbXO5wyA0RxPhfQBPaEZ2VZUtY
 j78JgQ+V7FqF/jLmr3xjYyL0b5prBlqJocrZAoWdLhnRjhQWGFQETvWI5vnOlW2BUlCw
 PMeo+AdL5Sq9QSWpc2Me2LgcR1IbvXVHYUCg37iK+DbequWO4h7OwM5sN2pnFv2tkXhi
 MxVYjdyisGKkLek8Zah67qSGR/6Ubk/37DC5BHeO4fFOSOoPOJtA/cS01nmH1KjCfrfn
 hMFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699600746; x=1700205546;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XmnS80V2GoXgdJAu1TJBRnc9jrIImcI7OYxPaXgF1uE=;
 b=PT+AwO0UhOushJkPzuIP2hT8MfUwp49qJzaZVmhX04zJtEJgAV7jPBEP8hlV1wEIHf
 xFiA0wW7cVabOkAV+13YwRWlnKCS10B2DXExpsKGDaY1v+hl0q2gijoijZ6/ytIIcwSI
 Hio3fq3M7JzIwxnuODazQvW9ammILwnJgpy6cP/D5wvziA5J8HXBy2QO1XDiVR6ialLR
 vs0Iktx90w3C1ciRq31VB7IEcuOlKecarKbPXHTNoD2v86tEu6TipO481h1zVOyvRMV8
 RW6kSBzKkbewOuIt79eY2aO8pScQ54WaB3oHb16DETc9gJRNtjNlkWWFSfAPLrz11xCP
 4JRA==
X-Gm-Message-State: AOJu0YwzMqyjP3AadC1/vi/DLG09JAv0bgUfDL/YRiaztBbossj5AqfQ
 djLYFde7e3vQv5RGNIe2aTrq5CRJV6Pw69R4a/Pg4g==
X-Google-Smtp-Source: AGHT+IGz3MkKDtXLUrfLJiJ899m02PZPTgGUaoWlxtvbqsZiUcIZiQk9OjkTZymvkWO0PxVdD6m6drWQaBVKLk6uqEM=
X-Received: by 2002:a50:c09a:0:b0:53e:3b8f:8a5a with SMTP id
 k26-20020a50c09a000000b0053e3b8f8a5amr5515391edf.39.1699600746270; Thu, 09
 Nov 2023 23:19:06 -0800 (PST)
MIME-Version: 1.0
References: <20231110042542.3797301-1-masahisa.kojima@linaro.org>
 <20231110042542.3797301-8-masahisa.kojima@linaro.org>
 <CAC_iWjKvgTwiC==bOfr+WWa0s2XSJoD+D7VPBXk_TtDroQxDpg@mail.gmail.com>
In-Reply-To: <CAC_iWjKvgTwiC==bOfr+WWa0s2XSJoD+D7VPBXk_TtDroQxDpg@mail.gmail.com>
From: Masahisa Kojima <masahisa.kojima@linaro.org>
Date: Fri, 10 Nov 2023 16:18:55 +0900
Message-ID: <CADQ0-X_v3dnpzQ+DmLu5EAsF6PRsLQqnyCqYvT8RFrghdqt8Ug@mail.gmail.com>
Subject: Re: [PATCH v12 7/9] efi_loader: support boot from URI device path
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Takahiro Akashi <takahiro.akashi@linaro.org>, 
 Michal Simek <michal.simek@amd.com>
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

On Fri, 10 Nov 2023 at 15:50, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Kojima-san
>
> Going through the patch one last time before I merge it I noticed some
> memory leaks
>
> On Fri, 10 Nov 2023 at 06:27, Masahisa Kojima
> <masahisa.kojima@linaro.org> wrote:
> >
> > This supports to boot from the URI device path.
> > When user selects the URI device path, bootmgr downloads
> > the file using wget into the address specified by loadaddr
> > env variable.
> > If the file is .iso or .img file, mount the image with blkmap
> > then try to boot with the default file(e.g. EFI/BOOT/BOOTAA64.EFI).
> > Since boot option indicating the default file is automatically
> > created when new disk is detected, system can boot by selecting
> > the automatically created blkmap boot option.
> > If the file is PE-COFF file, load and start the downloaded file.
> >
> > The buffer used to download the ISO image file must be
> > reserved to avoid the unintended access to the image and
> > expose the ramdisk to the OS.
> > For PE-COFF file case, this memory reservation is done
> > in LoadImage Boot Service.
> >
> > Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> > Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
>
> [...]
>
> > +
> > +/**
> > + * efi_bootmgr_image_return_notify() - return to efibootmgr callback
> > + *
> > + * @event:     the event for which this notification function is registered
> > + * @context:   event context
> > + */
> > +static void EFIAPI efi_bootmgr_image_return_notify(struct efi_event *event,
> > +                                                  void *context)
> > +{
> > +       efi_status_t ret;
> > +
> > +       EFI_ENTRY("%p, %p", event, context);
> > +       ret = efi_bootmgr_release_uridp_resource(context);
> > +       EFI_EXIT(ret);
> > +}
> > +
> > +/**
> > + * try_load_from_uri_path() - Handle the URI device path
> > + *
> > + * @uridp:     uri device path
> > + * @lo_label:  label of load option
> > + * @handle:    pointer to handle for newly installed image
> > + * Return:     status code
> > + */
> > +static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
> > +                                          u16 *lo_label,
> > +                                          efi_handle_t *handle)
> > +{
> > +       char *s;
> > +       int err;
> > +       int uri_len;
> > +       efi_status_t ret;
> > +       void *source_buffer;
> > +       efi_uintn_t source_size;
> > +       struct uridp_context *ctx;
> > +       struct udevice *blk = NULL;
> > +       struct efi_event *event = NULL;
> > +       efi_handle_t mem_handle = NULL;
> > +       struct efi_device_path *loaded_dp;
> > +       static ulong image_size, image_addr;
> > +
> > +       ctx = calloc(1, sizeof(struct uridp_context));
> > +       if (!ctx)
> > +               return EFI_OUT_OF_RESOURCES;
>
> ctx is allocated here
>
> > +
> > +       s = env_get("loadaddr");
> > +       if (!s) {
> > +               log_err("Error: loadaddr is not set\n");
> > +               return EFI_INVALID_PARAMETER;
>
> Should be freed here
>
> > +       }
> > +       image_addr = hextoul(s, NULL);
> > +       err = wget_with_dns(image_addr, uridp->uri);
> > +       if (err < 0)
> > +               return EFI_INVALID_PARAMETER;
>
> and here
>
> > +       image_size = env_get_hex("filesize", 0);
> > +       if (!image_size)
> > +               return EFI_INVALID_PARAMETER;
>
> and here
>
> > +
> > +       /*
> > +        * If the file extension is ".iso" or ".img", mount it and try to load
> > +        * the default file.
> > +        * If the file is PE-COFF image, load the downloaded file.
> > +        */
> > +       uri_len = strlen(uridp->uri);
> > +       if (!strncmp(&uridp->uri[uri_len - 4], ".iso", 4) ||
> > +           !strncmp(&uridp->uri[uri_len - 4], ".img", 4)) {
> > +               ret = prepare_loaded_image(lo_label, image_addr, image_size,
> > +                                          &loaded_dp, &blk);
> > +               if (ret != EFI_SUCCESS)
> > +                       goto err;
> > +
> > +               source_buffer = NULL;
> > +               source_size = 0;
> > +       } else if (efi_check_pe((void *)image_addr, image_size, NULL) == EFI_SUCCESS) {
> > +               /*
> > +                * loaded_dp must exist until efi application returns,
> > +                * will be freed in return_to_efibootmgr event callback.
> > +                */
> > +               loaded_dp = efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE,
> > +                                           (uintptr_t)image_addr, image_size);
> > +               ret = efi_install_multiple_protocol_interfaces(
> > +                       &mem_handle, &efi_guid_device_path, loaded_dp, NULL);
> > +               if (ret != EFI_SUCCESS)
> > +                       goto err;
> > +
> > +               source_buffer = (void *)image_addr;
> > +               source_size = image_size;
> > +       } else {
> > +               log_err("Error: file type is not supported\n");
> > +               return EFI_UNSUPPORTED;
>
> and here
>
> [...]
>
> Should we just goto err and set the return value instead of returning
> immediately?

Yes, we can set the return value goto err.

> If yes I can fix that during the merge

Thank you. It is very helpful if you can fix this.

Thanks,
Masahisa Kojima

>
> Thanks
> /Ilias
