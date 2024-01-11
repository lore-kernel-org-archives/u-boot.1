Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47B91C4707C
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 03:09:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A0CF87A88;
	Thu, 11 Jan 2024 04:09:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cV+cZw8X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAA3487A88; Thu, 11 Jan 2024 04:09:19 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AB4F8797B
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 04:09:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a2ac304e526so394509566b.0
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 19:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704942554; x=1705547354; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4iIrLHmg0LRpl3lSbGYln+vMlgZvRD2W8qqvul3qGic=;
 b=cV+cZw8XUG4vsHr1WVDism8WocwwLPBM/SJa0SdHryLo/DHilVUup6XjvJ68/llH1Z
 dt451CjbWhsnIrk7PxqNKMYB+ji7r/ztVCyM9O0HwrYOYxtPgYF+uE/fXyE4Sc9J7K/O
 NwA/OX33tb0K5QTqqFgzulrkDH9T8WAwfp6V6NpkXBtcvUWjT8srbzT65WC1YSr2YFTI
 O6PHEwoJJrhtvjqnR5oXIzWrWJyknfLJNjC3RJf4q2ojCEOb/p5Y68dCaeMCRBhHX3qV
 JGBMI092neKeRRrzux8p05mTpvUgDVUWbJj8EQUZ7YB2/iqaQWZq2VgaiMogGkMxoFjH
 TKiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704942554; x=1705547354;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4iIrLHmg0LRpl3lSbGYln+vMlgZvRD2W8qqvul3qGic=;
 b=UrJMHqalYYJJVxH1qCrWQEnxINknV7st4OGphQMno/nGlNVehhXBJBwPnXhsBqnfMJ
 EFzrtleeRyv8PzqAECwJMMsZTbms3MRSMPuUfULDiNh325vjlA3q45Lf7yvJt0Ft5Unx
 E2PtQ/NINBoCXUmIL8KJ/6gp+WWVigh41hJ2eEHA2xLnwRvKzDXQtRU/2SwKgGPKQWmt
 UqEhykrMAOl8ewRZBj6q5E1xaMJ5VsLKHE988r4dr70KUCKSZNm4O5K93o5e6WzeS9iF
 lMOzCbP+0htUuGMQWDamHl6iUqbTuhlOqN2jcaJLQkA67QyqBfZRIKmLcQBIgv5+tyC4
 /KNw==
X-Gm-Message-State: AOJu0Yy34uBylvEu1s27ObSBNHyuli2RmMk9H9lFFq9QptchMOFysUKj
 +XS+RMeVBf3MHrAJv0Iim/f7Tv4LaeiMupLk7v5xck6PgdQACw==
X-Google-Smtp-Source: AGHT+IE+i3zcl5w0YwCfdP3r7Q0wwP6Qe5bLfhceknyJu9QFyWeb1EY8GpJS/SBWW6WK2NuxR3A4MfvF2XfPPetdvRs=
X-Received: by 2002:a17:906:8d2:b0:a28:1c0b:eabf with SMTP id
 o18-20020a17090608d200b00a281c0beabfmr206994eje.94.1704942553600; Wed, 10 Jan
 2024 19:09:13 -0800 (PST)
MIME-Version: 1.0
References: <20231226062820.722358-1-masahisa.kojima@linaro.org>
 <20231226062820.722358-2-masahisa.kojima@linaro.org>
 <0b827e9d-6646-40cb-9944-9d3c7bb40827@gmx.de>
In-Reply-To: <0b827e9d-6646-40cb-9944-9d3c7bb40827@gmx.de>
From: Masahisa Kojima <masahisa.kojima@linaro.org>
Date: Thu, 11 Jan 2024 12:09:01 +0900
Message-ID: <CADQ0-X8D9GJsR9=GPCVGUs88dNRaWMYmTua10sfig9pQneCurQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] efi_loader: auto-generate boot option for each
 blkio device
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
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

On Wed, 10 Jan 2024 at 22:53, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 26.12.23 07:28, Masahisa Kojima wrote:
> > Current efibootmgr auto-generates the boot option for all
> > disks and partitions installing EFI_SIMPLE_FILE_SYSTEM_PROTOCOL,
> > while EDK II reference implementation auto-generates the boot option
> > for all devices installing  EFI_BLOCK_IO_PROTOCOL with
> > eliminating logical partitions.
> >
> > This commit modifies the efibootmgr to get aligned to EDK II.
> >
> > Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> > ---
> >   lib/efi_loader/efi_bootmgr.c | 94 +++++++++++++++++++++++++++---------
> >   1 file changed, 71 insertions(+), 23 deletions(-)
> >
> > diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> > index 56d97f2382..747f75ee82 100644
> > --- a/lib/efi_loader/efi_bootmgr.c
> > +++ b/lib/efi_loader/efi_bootmgr.c
> > @@ -560,6 +560,50 @@ err:
> >       return ret;
> >   }
> >
> > +/**
> > + * try_load_from_media() - load file from media
> > + *
> > + * @file_path:       file path
> > + * @handle:  pointer to handle for newly installed image
>
> Please, use the same description as in try_load_entry():
>
>      on return handle for the newly installed image

OK.

>
> > + *
> > + * If @file_path contains a file name, load the file.
> > + * If @file_path does not have a file name, search the architecture-specific
> > + * default file and load it.
> > + * TODO: If the FilePathList[0] device does not support
> > + * EFI_SIMPLE_FILE_SYSTEM_PROTOCOL but supports EFI_BLOCK_IO_PROTOCOL,
> > + * call EFI_BOOT_SERVICES.ConnectController()
> > + * TODO: FilePathList[0] device supports EFI_SIMPLE_FILE_SYSTEM_PROTOCOL
> > + * not based on EFI_BLOCK_IO_PROTOCOL
> > + *
> > + * Return:   status code
> > + */
> > +static efi_status_t try_load_from_media(struct efi_device_path *file_path,
> > +                                     efi_handle_t *handle)
>
> %s/handle/handle_img/
OK.

>
> or h_img
>
> > +{
> > +     efi_handle_t h;
>
> %s/h/handle_blkdev/
OK.

>
> or h_blkdev
>
>
> > +     efi_status_t ret = EFI_SUCCESS;
> > +     struct efi_device_path *rem, *dp = NULL;
> > +     struct efi_device_path *final_dp = file_path;
> > +
> > +     h = efi_dp_find_obj(file_path, &efi_block_io_guid, &rem);
> > +     if (h) {
> > +             if (rem->type == DEVICE_PATH_TYPE_END) {
> > +                     /* no file name present, try default file */
> > +                     ret = check_disk_has_default_file(h->dev, &dp);
>
> check_disk_has_default_file() does not only check for a default file
> path , i.e. EFI/BOOT/BOO<ARCH>.EFI, but will check for a given file
> path, if provided. In a later patch we should rename this function to
> something less misleading.

OK. I will include a renaming patch in this series.

>
> > +                     if (ret != EFI_SUCCESS)
> > +                             return ret;
> > +
> > +                     final_dp = dp;
> > +             }
> > +     }
> > +
> > +     ret = EFI_CALL(efi_load_image(true, efi_root, final_dp, NULL, 0, handle));
> > +
> > +     efi_free_pool(dp);
> > +
> > +     return ret;
> > +}
> > +
> >   /**
> >    * try_load_entry() - try to load image for boot option
> >    *
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
> >    * efi_bootmgr_enumerate_boot_option() - enumerate the possible bootable media
>
> %s/efi_bootmgr_enumerate_boot_option/efi_bootmgr_enumerate_boot_options/
OK.

>
> >    *
> >    * @opt:            pointer to the media boot option structure
> > - * @volume_handles:  pointer to the efi handles
> > + * @handles:         pointer to the efi handles
>
> %s/efi/EFI/
>
> "pointer to the efi handles" could be handles for anything.
>
> %s/pointer to the efi handles/pointer to block device handles/
OK.

>
> We should move the call to LocateBufferHandle into this function as the
> caller does not use handles.

But no_handles is required in the
caller(efi_bootmgr_update_media_device_boot_option)
to allocate an opt array.
   opt = calloc(count, sizeof(struct eficonfig_media_boot_option));

>
>
> >    * @count:          number of efi handle
>
> On entry number of handles to block devices.
> On exit number of boot options.
OK.

>
> >    * Return:          status code
> >    */
> >   static efi_status_t efi_bootmgr_enumerate_boot_option(struct eficonfig_media_boot_option *opt,
> > -                                                   efi_handle_t *volume_handles,
> > -                                                   efi_status_t count)
> > +                                                   efi_handle_t *handles,
> > +                                                   efi_uintn_t *count)
> >   {
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
> >   out:
> > +     *count = num;
> > +
> >       return ret;
> >   }
> >
> > @@ -1040,8 +1090,7 @@ efi_status_t efi_bootmgr_delete_boot_option(u16 boot_index)
> >   /**
> >    * efi_bootmgr_update_media_device_boot_option() - generate the media device boot option
> >    *
> > - * This function enumerates all devices supporting EFI_SIMPLE_FILE_SYSTEM_PROTOCOL
> > - * and generate the bootmenu entries.
> > + * This function enumerates all BlockIo devices and add the boot option for it.
> >    * This function also provide the BOOT#### variable maintenance for
> >    * the media device entries.
> >    * - Automatically create the BOOT#### variable for the newly detected device,
> > @@ -1057,13 +1106,13 @@ efi_status_t efi_bootmgr_update_media_device_boot_option(void)
> >       u32 i;
> >       efi_status_t ret;
> >       efi_uintn_t count;
> > -     efi_handle_t *volume_handles = NULL;
> > +     efi_handle_t *handles = NULL;
> >       struct eficonfig_media_boot_option *opt = NULL;
> >
> >       ret = efi_locate_handle_buffer_int(BY_PROTOCOL,
> > -                                        &efi_simple_file_system_protocol_guid,
> > +                                        &efi_block_io_guid,
> >                                          NULL, &count,
> > -                                        (efi_handle_t **)&volume_handles);
> > +                                        (efi_handle_t **)&handles);
>
> This is the call that should be moved to
> efi_bootmgr_enumerate_boot_options().

no_handles(count) is required to allocate an opt array.
So let me keep efi_locate_handle_buffer_int() call here.

>
> >       if (ret != EFI_SUCCESS)
> >               goto out;
> >
> > @@ -1073,8 +1122,7 @@ efi_status_t efi_bootmgr_update_media_device_boot_option(void)
> >               goto out;
> >       }
> >
> > -     /* enumerate all devices supporting EFI_SIMPLE_FILE_SYSTEM_PROTOCOL */
> > -     ret = gg(opt, volume_handles, count);
> > +     ret = efi_bootmgr_enumerate_boot_option(opt, handles, &count);
>
> %s/, handles//

Let me keep it as is.

>
> >       if (ret != EFI_SUCCESS)
> >               goto out;
> >
> > @@ -1122,7 +1170,7 @@ out:
> >                       free(opt[i].lo);
> >       }
> >       free(opt);
> > -     efi_free_pool(volume_handles);
> > +     efi_free_pool(handles);
>
> To be moved to efi_bootmgr_enumerate_boot_options().

Let me keep it as is.

Thanks,
Masahisa Kojima

>
> Best regards
>
> Heinrich
>
> >
> >       if (ret == EFI_NOT_FOUND)
> >               return EFI_SUCCESS;
>
