Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC4DEC3DA6E
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 01:52:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59EF187831;
	Tue, 26 Dec 2023 02:52:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="T0O/y6in";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55D1D87835; Tue, 26 Dec 2023 02:52:25 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBA59877F3
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 02:52:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5551b7013b6so240223a12.1
 for <u-boot@lists.denx.de>; Mon, 25 Dec 2023 17:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703555539; x=1704160339; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=I5a72dOzRK0PFsZSSQBBn/gWDLBouEJt+et11J2WHEo=;
 b=T0O/y6inanLKnfGNrMNG+7J7foIwBAu/01ZbFTCHOGmnJER8Y5GwyFA8djasaIxvNN
 8jQa9TzwCB2WfFZHTC4fTnmL8w2owfd1vBHc06JdSb4KJaB2Uc4ysk0ScoIxHC4bfzFd
 1iv/I6OkkLgiuN3X1D0+GyFrFY6A54BesRi5qP4p+92pAsLaRDTR4w1gS6pL7gZZ5isC
 xxC4pjYwP2RAzjgmzLeRvCyBHF1VZwzYLYbEgItxygj9dBXREmU4X4GclIopoQ6hbPYL
 AuoELYArkqyIF4u/GoXNUPadiHzQIg8eJ93pauHzK3VKuaoSDAV0R9jTuGgHl69R5A2M
 9Vdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703555539; x=1704160339;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I5a72dOzRK0PFsZSSQBBn/gWDLBouEJt+et11J2WHEo=;
 b=AZqA+milKiMF/ucr1R1huh6RqLW8iQv+rRUoUBPbKRLDa/UEtOHQGP9xB2snHC+vpi
 9pcxGUcPVO2k+GdELQ2sFlUFj/r06qV+ka1K/8SqEoRS/HRQeHd+AACTPzHkv82n8amH
 fHdeWRMQ3jzyObqwwpq2B1pzUmy0dJRKfZOhoctoLYuWy/HFt114TRfylABGAvivEdkJ
 kIMjM2M/pVYpV/yZwzZjy+W+kPKAlzhPDPrsgBtCCfAZwJ3jRaD6RMZfQv5dVSkfVU1n
 Pgg8SSYF33XMn/7wSlwJ/34FfoHFGoZ9IlAxvYx7h3rrmuzO59o0sN14wJbEwbQQghl+
 Yrug==
X-Gm-Message-State: AOJu0Yw+MCrUU/wTNS92LRxZkaCT/jVy9yQiQNA0P4HyAPJOH8oF0UcJ
 du8h1BHW4GZy4RYbvBGLyKST9qnFVMAkvay51gCAlohWPUU27Q==
X-Google-Smtp-Source: AGHT+IHtqBaokaqFaMmJVnVpOk2r7Ew7Uao7z3lkau9rAbpvkm6pngxFK4MhUyvC08ZbzlCujf8YcZvD3nB+QDaAGwc=
X-Received: by 2002:a17:907:3fa4:b0:a23:671c:2284 with SMTP id
 hr36-20020a1709073fa400b00a23671c2284mr9693599ejc.29.1703555539154; Mon, 25
 Dec 2023 17:52:19 -0800 (PST)
MIME-Version: 1.0
References: <20231220084133.435240-1-masahisa.kojima@linaro.org>
 <20231220084133.435240-2-masahisa.kojima@linaro.org>
 <0001a0b4-8104-4a15-9614-470c3108b379@gmx.de>
In-Reply-To: <0001a0b4-8104-4a15-9614-470c3108b379@gmx.de>
From: Masahisa Kojima <masahisa.kojima@linaro.org>
Date: Tue, 26 Dec 2023 10:52:07 +0900
Message-ID: <CADQ0-X8mO5+-OwZQzZAkAAsuBOZTFd7oSBKLQD=te1OODC-uDQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] efi_loader: auto-generate boot option for each blkio
 device
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

On Mon, 25 Dec 2023 at 21:22, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 12/20/23 09:41, Masahisa Kojima wrote:
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
> > index 56d97f2382..636f01e2eb 100644
> > --- a/lib/efi_loader/efi_bootmgr.c
> > +++ b/lib/efi_loader/efi_bootmgr.c
> > @@ -560,6 +560,50 @@ err:
> >       return ret;
> >   }
> >
> > +/**
> > + * try_load_from_media() - load file from media
> > + *
> > + * @fp:              file path
>
> This does not match the parameter name of the function leading to a
> 'make htmldocs' build error.

Sorry, I will fix it.

>
> > + * @handle:  pointer to handle for newly installed image
> > + *
> > + * If @fp contains a file name, load the file.
> > + * If @fp does not have a file name, search the architecture-specific
>
> ditto

OK.

Thanks,
Masahisa Kojima


>
> Best regards
>
> Heinrich
>
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
> > +{
> > +     efi_handle_t h;
> > +     efi_status_t ret = EFI_SUCCESS;
> > +     struct efi_device_path *rem, *dp = NULL;
> > +     struct efi_device_path *final_dp = file_path;
> > +
> > +     h = efi_dp_find_obj(file_path, &efi_block_io_guid, &rem);
> > +     if (h) {
> > +             if (rem->type == DEVICE_PATH_TYPE_END) {
> > +                     /* no file name present, try default file */
> > +                     ret = check_disk_has_default_file(h->dev, &dp);
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
> >    *
> >    * @opt:            pointer to the media boot option structure
> > - * @volume_handles:  pointer to the efi handles
> > + * @handles:         pointer to the efi handles
> >    * @count:          number of efi handle
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
> >       if (ret != EFI_SUCCESS)
> >               goto out;
> >
> > @@ -1073,8 +1122,7 @@ efi_status_t efi_bootmgr_update_media_device_boot_option(void)
> >               goto out;
> >       }
> >
> > -     /* enumerate all devices supporting EFI_SIMPLE_FILE_SYSTEM_PROTOCOL */
> > -     ret = efi_bootmgr_enumerate_boot_option(opt, volume_handles, count);
> > +     ret = efi_bootmgr_enumerate_boot_option(opt, handles, &count);
> >       if (ret != EFI_SUCCESS)
> >               goto out;
> >
> > @@ -1122,7 +1170,7 @@ out:
> >                       free(opt[i].lo);
> >       }
> >       free(opt);
> > -     efi_free_pool(volume_handles);
> > +     efi_free_pool(handles);
> >
> >       if (ret == EFI_NOT_FOUND)
> >               return EFI_SUCCESS;
>
