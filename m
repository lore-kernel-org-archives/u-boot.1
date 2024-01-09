Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 203D1C3DA6E
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 01:51:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F3348774E;
	Tue,  9 Jan 2024 02:51:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Me+C9kwe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93E40877F4; Tue,  9 Jan 2024 02:51:50 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8191E87718
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 02:51:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-556c60c3f9aso2970866a12.3
 for <u-boot@lists.denx.de>; Mon, 08 Jan 2024 17:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704765108; x=1705369908; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TI38P8mHagZs4MGBnRhA7RUmZkXE/Pwe5uYyw8eC1xk=;
 b=Me+C9kweLkazqcVJTbjvbR88feYstHoc7r2D1vEoqoInwEoKA0NEaHpWIpZwJhE0cF
 x6l0HqlIcfpfqoelXU4GyFzyak/tec8E3ZwUDMv4yHxCwEzRtOcPGBHsZVjRgykokDPc
 1Zi9i3gbKTb8rXFXH9w1JDetZbM1hW7BiAujnF/WBwNfz+M4kN+7ULh8VC2T7rYOwNoL
 t/18KJNdUTy1uxS9Z4/cg3/yk0DXN4EgLizBB0oYoC4arsg9gEK4gFIqiV0qm9TSKfjS
 9snDodcVO6H3I9aL/goIW6a7c7IJ+jes3azE3r/irtUGDMXcn44+3A8P+JXekZGPKyvi
 IZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704765108; x=1705369908;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TI38P8mHagZs4MGBnRhA7RUmZkXE/Pwe5uYyw8eC1xk=;
 b=geiyS/G6ExM1jNIwVJEDlI1gQOGi/vmkdBIJDP2aEmDk9WmfYhWfQsKQoJoeKKsJkI
 3tBKiUJvlhe1mJYZFC63j4TYggBE4XB4LE0fpzpUoeEnsIsM7Qx5O9x07RvfiQYNhM1y
 xmTEyZ11FyG2A8QVXVZfy9A5OLhMXyaoA1SMmFLloQeHDLvg6V4yTa9mcYB/5zQkGax8
 TSIcaKXFwpv+NPd/MOjZLyEBW2hNY96c0/FNVLOgm8fyJ3rJKyuEQZiVW4DF6G/CeONM
 ZeOIy+M/ZyBsC+yOubkEzxk1nt7tN/jJvhQ/wV3+qRJu1lcIlSNetw+jBMYVvtBaZFsM
 lGHg==
X-Gm-Message-State: AOJu0YzDnLxrwJzW38J1omzZUexuf3OZeZAS1r8YLoG5s68XRjJGcOui
 lHH69EL/VOMQuUM2nScjLu9KHOgbU6qvMqjh5YFewFtBbRmfOKBbErkCfWP90so=
X-Google-Smtp-Source: AGHT+IFCzn2rr6CjlwOcJn6s70XehutgpG2XLV/yuRnQt2nUBprKFvSidSn1SI6uTkmXXWwGOk9jBuRFke6QByXkckU=
X-Received: by 2002:a17:907:7e87:b0:a28:e03:8d62 with SMTP id
 qb7-20020a1709077e8700b00a280e038d62mr193222ejc.79.1704765107834; Mon, 08 Jan
 2024 17:51:47 -0800 (PST)
MIME-Version: 1.0
References: <20231226062820.722358-1-masahisa.kojima@linaro.org>
 <20231226062820.722358-2-masahisa.kojima@linaro.org> <ZY10qKZiGWrjQkUG@hades>
In-Reply-To: <ZY10qKZiGWrjQkUG@hades>
From: Masahisa Kojima <masahisa.kojima@linaro.org>
Date: Tue, 9 Jan 2024 10:51:36 +0900
Message-ID: <CADQ0-X-6KcTbsZ=Dar9cL-OJR5pEdC5R=1+woDZTy+QbEfcTgg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] efi_loader: auto-generate boot option for each
 blkio device
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Thu, 28 Dec 2023 at 22:14, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Kojima-san
>
> [...]
>
> >  /**
> >   * try_load_entry() - try to load image for boot option
> >   *
> > @@ -594,7 +638,6 @@ static efi_status_t try_load_entry(u16 n, efi_handle_t *handle,
> >       }
> >
> >       if (lo.attributes & LOAD_OPTION_ACTIVE) {
> > -             struct efi_device_path *file_path;
> >               u32 attributes;
> >
> >               log_debug("trying to load \"%ls\" from %pD\n", lo.label,
> > @@ -611,10 +654,7 @@ static efi_status_t try_load_entry(u16 n, efi_handle_t *handle,
> >                       else
> >                               ret = EFI_LOAD_ERROR;
> >               } else {
> > -                     file_path = expand_media_path(lo.file_path);
> > -                     ret = EFI_CALL(efi_load_image(true, efi_root, file_path,
> > -                                                   NULL, 0, handle));
> > -                     efi_free_pool(file_path);
> > +                     ret = try_load_from_media(lo.file_path, handle);
> >               }
> >               if (ret != EFI_SUCCESS) {
> >                       log_warning("Loading %ls '%ls' failed\n",
> > @@ -748,19 +788,19 @@ error:
> >   * efi_bootmgr_enumerate_boot_option() - enumerate the possible bootable media
> >   *
> >   * @opt:             pointer to the media boot option structure
> > - * @volume_handles:  pointer to the efi handles
> > + * @handles:         pointer to the efi handles
> >   * @count:           number of efi handle
> >   * Return:           status code
> >   */
> >  static efi_status_t efi_bootmgr_enumerate_boot_option(struct eficonfig_media_boot_option *opt,
> > -                                                   efi_handle_t *volume_handles,
> > -                                                   efi_status_t count)
> > +                                                   efi_handle_t *handles,
> > +                                                   efi_uintn_t *count)
> >  {
> > -     u32 i;
> > +     u32 i, num = 0;
> >       struct efi_handler *handler;
> >       efi_status_t ret = EFI_SUCCESS;
> >
> > -     for (i = 0; i < count; i++) {
> > +     for (i = 0; i < *count; i++) {
> >               u16 *p;
> >               u16 dev_name[BOOTMENU_DEVICE_NAME_MAX];
> >               char *optional_data;
> > @@ -768,8 +808,15 @@ static efi_status_t efi_bootmgr_enumerate_boot_option(struct eficonfig_media_boo
> >               char buf[BOOTMENU_DEVICE_NAME_MAX];
> >               struct efi_device_path *device_path;
> >               struct efi_device_path *short_dp;
> > +             struct efi_block_io *blkio;
> > +
> > +             ret = efi_search_protocol(handles[i], &efi_block_io_guid, &handler);
> > +             blkio = handler->protocol_interface;
> >
> > -             ret = efi_search_protocol(volume_handles[i], &efi_guid_device_path, &handler);
> > +             if (blkio->media->logical_partition)
> > +                     continue;
> > +
> > +             ret = efi_search_protocol(handles[i], &efi_guid_device_path, &handler);
> >               if (ret != EFI_SUCCESS)
> >                       continue;
> >               ret = efi_protocol_open(handler, (void **)&device_path,
> > @@ -777,7 +824,7 @@ static efi_status_t efi_bootmgr_enumerate_boot_option(struct eficonfig_media_boo
> >               if (ret != EFI_SUCCESS)
> >                       continue;
> >
> > -             ret = efi_disk_get_device_name(volume_handles[i], buf, BOOTMENU_DEVICE_NAME_MAX);
> > +             ret = efi_disk_get_device_name(handles[i], buf, BOOTMENU_DEVICE_NAME_MAX);
> >               if (ret != EFI_SUCCESS)
> >                       continue;
> >
> > @@ -801,17 +848,20 @@ static efi_status_t efi_bootmgr_enumerate_boot_option(struct eficonfig_media_boo
> >                * to store guid, instead of realloc the load_option.
> >                */
> >               lo.optional_data = "1234567";
> > -             opt[i].size = efi_serialize_load_option(&lo, (u8 **)&opt[i].lo);
> > -             if (!opt[i].size) {
> > +             opt[num].size = efi_serialize_load_option(&lo, (u8 **)&opt[num].lo);
> > +             if (!opt[num].size) {
>
> I am a bit lost here. Why are we using 'num' instead of 'i'? The opt
> variable contains all media boot options with a block_io_protocol right?
> Aren't we going to copy the wrong load options in optional_data if we don't use
> 'i'?

opt[] array is a container of valid boot options with a block_io_protocol
to be auto-generated by efi bootmgr.
handles[] array contains all block_io_protocol efi handles.

With this patch, we ignore the logical partition, opt[] array does not contain
the boot options of logical partitions.
So 'num' instead of 'i' is correct here.

Thanks,
Masahisa Kojima

>
> >                       ret = EFI_OUT_OF_RESOURCES;
> >                       goto out;
> >               }
> >               /* set the guid */
> > -             optional_data = (char *)opt[i].lo + (opt[i].size - u16_strsize(u"1234567"));
> > +             optional_data = (char *)opt[num].lo + (opt[num].size - u16_strsize(u"1234567"));
> >               memcpy(optional_data, &efi_guid_bootmenu_auto_generated, sizeof(efi_guid_t));
> > +             num++;
> >       }
> >
> >  out:
> > +     *count = num;
> > +
> >       return ret;
> >  }
> >
>
> [...]
>
> Thanks
> /Ilias
