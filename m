Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D4C0C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 10:53:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 641F786487;
	Mon,  6 Nov 2023 11:53:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="czkIyuVA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2B4A865ED; Mon,  6 Nov 2023 11:53:12 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D39280310
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 11:53:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1cc0d0a0355so31130945ad.3
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 02:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699267988; x=1699872788; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0Cf1IlMRC4n8kaTzuTGtmG2qFX1KaGCO41hl30tWJyo=;
 b=czkIyuVA0R5d6vvx6Dern7KIz8IjgyxYbT1yhX7yYm6IohlUGC8HyasunucbNy9I7g
 FJmWpfYCL/DAHs6+kjhuSHQ7rd7XkOtoZHr/JatlIVMuL5QIgWUpsHrLZS3ymo77lkS0
 eO641xvl+zaahp2RAVN0X3MP6xtjxQOd6QBIlO+JnyWNN59bdDcPDGp0Wxr6BvtMgbtm
 UF3RcxRhL3XW4CY419NZDv02jDEYhdQ+4u/lBYQlEae0CRrgOe90g0GtCUCFXkwy804H
 j/BrP4FtPL5v7EnmGRks2940Q4olavuxgiPCP9sHJjG6Snogsfk1YeptGzShWLk/n+EI
 iT1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699267988; x=1699872788;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0Cf1IlMRC4n8kaTzuTGtmG2qFX1KaGCO41hl30tWJyo=;
 b=LnYP0S8sWbg+TqTlaCwDScnq/G3lC5m9UsdAefbwVA3JGo7A7QfRsHQ1yhNDZoSE9p
 wKf4r7mbFegkyYlbMNzkrr7TizRzo81zFVBBaOqCNQ0Sf91PeZks2HOaDQGyQ2FFrXcY
 GlNQTs45QkYQA56IiYsEXvcbGqdyjAwQUvn5L/XW+8Nc8Ap2/cq5zuiitjRnaDy/FcEg
 yz5NBJQaSwtDQ+tMdfZM9f+RktIvvSEyqVsqYoJ8VOsN1nZR+kmjJmDyX5SoyWsi5orX
 7ZFS0ZfNZc7wNzf3VCfopyCfziqFAS33m5HAfm7eml3KaTZe4jaV5tgMuHXHsuDq6g+e
 QuoA==
X-Gm-Message-State: AOJu0Yz2X8bP4LImDHlbsuwoNfQbExsNYWqJEnY/QAyMl3o/AID7zYFn
 597beeXmKar/RPqlX3LdUAb5lrB+NAPzwyVqg+iTRQ==
X-Google-Smtp-Source: AGHT+IFO5L4UTWr/b5ZYgt8jLhf8XxntqsfiV6AvVXO1HIo4kLlc8jMhNRzoMAaAqPlJAYFvrR45CbjO2nTyQj05Krc=
X-Received: by 2002:a17:90b:3101:b0:27d:661f:59ac with SMTP id
 gc1-20020a17090b310100b0027d661f59acmr22625113pjb.38.1699267988467; Mon, 06
 Nov 2023 02:53:08 -0800 (PST)
MIME-Version: 1.0
References: <20231102064459.3466953-1-masahisa.kojima@linaro.org>
 <20231102064459.3466953-8-masahisa.kojima@linaro.org>
 <CAC_iWjLs9zCHrhkQJ5yAc+b1xhEEvpyCvh6EuJfduTqcUW0Bww@mail.gmail.com>
In-Reply-To: <CAC_iWjLs9zCHrhkQJ5yAc+b1xhEEvpyCvh6EuJfduTqcUW0Bww@mail.gmail.com>
From: Masahisa Kojima <masahisa.kojima@linaro.org>
Date: Mon, 6 Nov 2023 19:52:57 +0900
Message-ID: <CADQ0-X-1AWfdPakT7y_t=_y_XjYhyagwXy4sz-UYqb10FQRg5g@mail.gmail.com>
Subject: Re: [PATCH v9 7/9] efi_loader: support boot from URI device path
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

Hi Ilias,

On Thu, 2 Nov 2023 at 20:03, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Kojima-san
>
>
> > +
> > +/**
> > + * try_load_default_file() - try to load the default file
> > + *
> > + * Search the device having EFI_SIMPLE_FILE_SYSTEM_PROTOCOL,
> > + * then try to load with the default boot file(e.g. EFI/BOOT/BOOTAA64.EFI).
> > + *
> > + * @dev                        pointer to the UCLASS_BLK or UCLASS_PARTITION udevice
> > + * @image_handle:      pointer to handle for newly installed image
> > + * Return:             status code
> > + */
> > +static efi_status_t try_load_default_file(struct udevice *dev,
> > +                                         efi_handle_t *image_handle)
> > +{
> > +       efi_status_t ret;
> > +       efi_handle_t handle;
> > +       struct efi_handler *handler;
> > +       struct efi_device_path *file_path;
> > +       struct efi_device_path *device_path;
> > +
> > +       if (dev_tag_get_ptr(dev, DM_TAG_EFI, (void **)&handle)) {
> > +               log_warning("DM_TAG_EFI not found\n");
> > +               return EFI_INVALID_PARAMETER;
> > +       }
> > +
> > +       ret = efi_search_protocol(handle,
> > +                                 &efi_simple_file_system_protocol_guid, &handler);
> > +       if (ret != EFI_SUCCESS)
> > +               return ret;
> > +
> > +       ret = EFI_CALL(bs->open_protocol(handle, &efi_guid_device_path,
> > +                                        (void **)&device_path, efi_root, NULL,
> > +                                        EFI_OPEN_PROTOCOL_GET_PROTOCOL));
> > +       if (ret != EFI_SUCCESS)
> > +               return ret;
> > +
> > +       file_path = expand_media_path(device_path);
> > +       ret = EFI_CALL(efi_load_image(true, efi_root, file_path, NULL, 0,
> > +                                     image_handle));
> > +       efi_free_pool(file_path);
> > +
> > +       return ret;
> > +}
> > +
> > +/**
> > + * load_default_file_from_blk_dev() - load the default file
> > + *
> > + * @blk                pointer to the UCLASS_BLK udevice
> > + * @handle:    pointer to handle for newly installed image
> > + * Return:     status code
> > + */
> > +static efi_status_t load_default_file_from_blk_dev(struct udevice *blk,
> > +                                                  efi_handle_t *handle)
> > +{
> > +       efi_status_t ret;
> > +       struct udevice *partition;
> > +
> > +       /* image that has no partition table but a file system */
> > +       ret = try_load_default_file(blk, handle);
> > +       if (ret == EFI_SUCCESS)
> > +               return ret;
> > +
> > +       /* try the partitions */
> > +       device_foreach_child(partition, blk) {
> > +               enum uclass_id id;
> > +
> > +               id = device_get_uclass_id(partition);
> > +               if (id != UCLASS_PARTITION)
> > +                       continue;
> > +
> > +               ret = try_load_default_file(partition, handle);
> > +               if (ret == EFI_SUCCESS)
> > +                       return ret;
> > +       }
> > +
> > +       return EFI_NOT_FOUND;
> > +}
> > +
> > +/**
> > + * efi_bootmgr_release_ramdisk() - release ramdisk resource
> > + *
> > + * Return:             status code
> > + */
> > +efi_status_t efi_bootmgr_release_ramdisk(void)
> > +{
> > +       efi_status_t ret = EFI_SUCCESS;
> > +
> > +       if (ramdisk_blk_dev) {
> > +               ret = efi_add_memory_map(image_addr, image_size,
> > +                                        EFI_CONVENTIONAL_MEMORY);
> > +               if (ret != EFI_SUCCESS)
> > +                       log_err("Reclaiming memory failed\n");
> > +
> > +               if (blkmap_destroy(ramdisk_blk_dev->parent)) {
> > +                       log_err("Destroying blkmap failed\n");
> > +                       ret = EFI_DEVICE_ERROR;
> > +               }
> > +
> > +               ramdisk_blk_dev = NULL;
> > +       }
> > +
> > +       return ret;
> > +}
> > +
> > +/**
> > + * efi_bootmgr_image_return_notify() - return to efibootmgr callback
> > + *
> > + * @event:     the event for which this notification function is registered
> > + * @context:   event context - not used in this function
> > + */
> > +static void EFIAPI efi_bootmgr_image_return_notify(struct efi_event *event,
> > +                                                  void *context)
> > +{
> > +       efi_status_t ret;
> > +
> > +       EFI_ENTRY("%p, %p", event, context);
> > +       ret = efi_bootmgr_release_ramdisk();
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
> > +       struct udevice *blk;
> > +       struct efi_event *event = NULL;
> > +
> > +       s = env_get("loadaddr");
> > +       if (!s) {
> > +               log_err("Error: loadaddr is not set\n");
> > +               return EFI_INVALID_PARAMETER;
> > +       }
> > +       image_addr = hextoul(s, NULL);
> > +       err = wget_with_dns(image_addr, uridp->uri);
> > +       if (err < 0)
> > +               return EFI_INVALID_PARAMETER;
> > +       image_size = env_get_hex("filesize", 0);
> > +       if (!image_size)
> > +               return EFI_INVALID_PARAMETER;
> > +
> > +       /*
> > +        * If the file extension is ".iso" or ".img", mount it and try to load
> > +        * the default file.
> > +        * If the file is PE-COFF image, load the downloaded file.
> > +        */
> > +       uri_len = strlen(uridp->uri);
> > +       if (!strncmp(&uridp->uri[uri_len - 4], ".iso", 4) ||
> > +           !strncmp(&uridp->uri[uri_len - 4], ".img", 4)) {
> > +               blk = mount_image(lo_label, image_addr, image_size);
> > +               if (!blk)
> > +                       return EFI_LOAD_ERROR;
> > +
> > +               ret = load_default_file_from_blk_dev(blk, handle);
> > +               if (ret != EFI_SUCCESS) {
> > +                       log_info("Cannot boot from downloaded image\n");
> > +                       goto iso_error;
> > +               }
> > +
> > +               ret = efi_create_event(EVT_NOTIFY_SIGNAL, TPL_CALLBACK,
> > +                                      efi_bootmgr_image_return_notify, NULL,
> > +                                      &efi_guid_event_group_return_to_efibootmgr, &event);
> > +               if (ret != EFI_SUCCESS) {
> > +                       log_err("Creating event failed\n");
> > +                       goto iso_error;
> > +               }
> > +
> > +               /*
> > +                * TODO: expose the ramdisk to OS.
> > +                * Need to pass the ramdisk information by the architecture-specific
> > +                * methods such as 'pmem' device-tree node.
> > +                */
> > +               ret = efi_add_memory_map(image_addr, image_size,
> > +                                        EFI_RESERVED_MEMORY_TYPE);
> > +               if (ret != EFI_SUCCESS) {
> > +                       log_err("Memory reservation failed\n");
> > +                       goto iso_error;
> > +               }
> > +
> > +               ramdisk_blk_dev = blk;
> > +       } else if (efi_check_pe((void *)image_addr, image_size, NULL) == EFI_SUCCESS) {
> > +               efi_handle_t mem_handle = NULL;
> > +               struct efi_device_path *file_path;
> > +
> > +               file_path = efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE,
> > +                                           (uintptr_t)image_addr, image_size);
> > +               ret = efi_install_multiple_protocol_interfaces(
> > +                       &mem_handle, &efi_guid_device_path, file_path, NULL);
> > +               if (ret != EFI_SUCCESS)
> > +                       return ret;
> > +
> > +               ret = EFI_CALL(efi_load_image(false, efi_root, file_path,
> > +                                             (void *)image_addr, image_size,
> > +                                             handle));
> > +       } else {
> > +               log_err("Error: file type is not supported\n");
> > +               return EFI_UNSUPPORTED;
> > +       }
>
> This is a bit confusing to read overall.  It works fine though so I
> suggest renaming load_default_file_from_blk_dev to
> prepare_loaded_image().  That function can mount the image, reserve
> memory and return the file path
>
> The code for both efi apps and iso images would look like this
>
>  if (!strncmp(&uridp->uri[uri_len - 4], ".iso", 4) ||
>       !strncmp(&uridp->uri[uri_len - 4], ".img", 4)) {
>           prepare_loaded_image()
>           efi_create_event()
> else if (efi_check_pe((void *)image_addr, image_size, NULL) == EFI_SUCCESS) {
>       file_path = efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE,
>                                               (uintptr_t)image_addr,
> image_size);

Freeing this file_path for the EFI application case is missing.
I will fix it in the next version.

>                   ret = efi_install_multiple_protocol_interfaces(
>                           &mem_handle, &efi_guid_device_path,
> file_path, NULL);
>                   if (ret != EFI_SUCCESS)
>                           return ret;
> } else {
>    log_err("Error: file type is not supported\n");
>    return EFI_UNSUPPORTED;
> }
>
> ret = EFI_CALL(efi_load_image(false, efi_root, file_path,
>                                                 (void *)image_addr,
> image_size,
>                                                 handle));
>
> .....
>
>
> IOW the if/else cases prepare the DP for you and reserve any needed
> memory.  Once that's done you load the image from a single location

Yes, refactor the code and send the next version shortly.

Thanks,
Masahisa Kojima

>
> Thanks
> /Ilias
>
>
> > +
> > +       return ret;
> > +
> > +iso_error:
> > +       if (blkmap_destroy(blk->parent))
> > +               log_err("Destroying blkmap failed\n");
> > +       if (event)
> > +               EFI_CALL(bs->close_event(event));
> > +       return ret;
> > +}
> > +
> >  /**
> >   * try_load_entry() - try to load image for boot option
> >   *
> > @@ -211,6 +471,14 @@ static efi_status_t try_load_entry(u16 n, efi_handle_t *handle,
> >                 if (EFI_DP_TYPE(lo.file_path, MEDIA_DEVICE, FILE_PATH)) {
> >                         /* file_path doesn't contain a device path */
> >                         ret = try_load_from_short_path(lo.file_path, handle);
> > +               } else if (EFI_DP_TYPE(lo.file_path, MESSAGING_DEVICE, MSG_URI)) {
> > +                       if (IS_ENABLED(CONFIG_EFI_HTTP_BOOT))
> > +                               ret = try_load_from_uri_path(
> > +                                       (struct efi_device_path_uri *)
> > +                                               lo.file_path,
> > +                                       lo.label, handle);
> > +                       else
> > +                               ret = EFI_LOAD_ERROR;
> >                 } else {
> >                         file_path = expand_media_path(lo.file_path);
> >                         ret = EFI_CALL(efi_load_image(true, efi_root, file_path,
> > --
> > 2.34.1
> >
