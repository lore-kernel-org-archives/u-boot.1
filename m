Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F5DFC4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 08:02:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CF558765B;
	Wed,  8 Nov 2023 09:02:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zJlxsg2D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAED187665; Wed,  8 Nov 2023 09:02:30 +0100 (CET)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B72D587654
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 09:02:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-5094727fa67so8915605e87.3
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 00:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699430548; x=1700035348; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TVMkfagcbOS+KfJORhOFwxO0ACd4aM/KLKtD3ckibx0=;
 b=zJlxsg2DTQOn4CxRM5i6Ri1i//tA6AeLVgJHpB6h30lNZLjhEQg4OEKUxks5ABOuK0
 p0raTCTSxjVLtqE2iQSFBtlShBj8icxpM7xZyONV0ioCzqxLwnvV7Ax+RAU3qaO0HDM2
 8hyIzkqLpTQoTT8eG27NwEVx6UIwcTLUSjWpOAkvX5yrFbXd6Ncj9TLiHVsjSv8cDDrq
 PLpUjkgGv7ZkKHyw2NBW+4O1HxblqJWxgPnIU6uY0arI7cfb0uCsyhZA5T8bvVP7HucC
 wOWlJSRlttL34Wx4RNmOI/3fy5NTc5d2seFQlRfPrxMblrJfPsQgsbayMxpug/Fqy7aF
 JQmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699430548; x=1700035348;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TVMkfagcbOS+KfJORhOFwxO0ACd4aM/KLKtD3ckibx0=;
 b=WmN2yMmtFSg4gTWiwnhQEUr8ub4W430ODc2+ZE8Bcm6kRdHNeiJid2Dvp7NKeJBjDH
 pj5x8PJUh/DBaJKj5V53oC63qhIxEh2fe5mTRjzkLIlIi1dhtOgIV26JLoFRi60L10ca
 +mP025NnuKtbGxh27m6X2kOqFRdqijljS6/H39ACbscWNC8zrGxcb/nHcHqpu9agOxiy
 8spd1ExusxmLWYM6tGxL/nD7qCfUgsZiIGlqs5Lgo8HNUky5FYVIQRgQtjSA/31v5Y1G
 88b0qlwozLLSbuyNzUM+smwCJZrnWoMAsJteVvra5oac3id06ij0xLYjTiICzSqkc3tV
 nLOg==
X-Gm-Message-State: AOJu0Yy8Rzn/FEQYMIm2COUYtuO1wCohlz8byS8LjO5s/u5CGsR78I5K
 K/lKFVNzhsqa5NI/LcRiQTQL6LNhio9V3XeQvQDWGg==
X-Google-Smtp-Source: AGHT+IFsT1NicNpYUYnSIq6RZB9qfLplWvBG5jIL611WKwsU97c/SF0OmqcBEO0JPnye0wzjllwX/2Qsktmsho9EA7I=
X-Received: by 2002:a05:6512:3196:b0:506:87a3:c27c with SMTP id
 i22-20020a056512319600b0050687a3c27cmr827540lfe.53.1699430547781; Wed, 08 Nov
 2023 00:02:27 -0800 (PST)
MIME-Version: 1.0
References: <20231106113920.3631591-1-masahisa.kojima@linaro.org>
 <20231106113920.3631591-8-masahisa.kojima@linaro.org>
 <CAC_iWjJvhjC3NL18ypkmKTC-kBw+y_WsO+hqNMuE5NZzsVNf6w@mail.gmail.com>
 <CADQ0-X_-8QZNaC=avVFCZkMZYq1Xvp6m0Mc+JcxX7Dv+E4bCag@mail.gmail.com>
In-Reply-To: <CADQ0-X_-8QZNaC=avVFCZkMZYq1Xvp6m0Mc+JcxX7Dv+E4bCag@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 8 Nov 2023 10:01:51 +0200
Message-ID: <CAC_iWjJHd=4ULCJ=gCWDApB38ZJmRmvbST50rjVJZz9wV3RoSQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v10 7/9] efi_loader: support boot from URI device
 path
To: Masahisa Kojima <masahisa.kojima@linaro.org>
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

Kojima-san

[...]
> > > + * @dev:       pointer to the UCLASS_BLK or UCLASS_PARTITION udevice
> > > + * @dp:                pointer to default file device path
> > > + * Return:     status code
> > > + */
> > > +static efi_status_t search_default_file(struct udevice *dev,
> > > +                                       struct efi_device_path **dp)
> > > +{
> > > +       efi_status_t ret;
> > > +       efi_handle_t handle;
> > > +       u16 *default_file_name = NULL;
> > > +       struct efi_file_handle *root, *f;
> > > +       struct efi_device_path *full_path;
> > > +       struct efi_device_path *device_path;
> > > +       struct efi_device_path *file_path = NULL;
> > > +       struct efi_simple_file_system_protocol *file_system;
> > > +
> > > +       if (dev_tag_get_ptr(dev, DM_TAG_EFI, (void **)&handle)) {
> > > +               log_warning("DM_TAG_EFI not found\n");
> > > +               return EFI_INVALID_PARAMETER;
> > > +       }
> > > +
> > > +       ret = EFI_CALL(bs->open_protocol(handle, &efi_simple_file_system_protocol_guid,
> > > +                                        (void **)&file_system, efi_root, NULL,
> > > +                                        EFI_OPEN_PROTOCOL_GET_PROTOCOL));
> > > +       if (ret != EFI_SUCCESS)
> > > +               return ret;
> > > +
> > > +       ret = EFI_CALL(file_system->open_volume(file_system, &root));
> > > +       if (ret != EFI_SUCCESS)
> > > +               return ret;
> > > +
> > > +       file_path = efi_dp_from_file(NULL, "/EFI/BOOT/" BOOTEFI_NAME);
> > > +       default_file_name = efi_dp_str(file_path);
> > > +       if (!default_file_name) {
> > > +               ret = EFI_OUT_OF_RESOURCES;
> > > +               goto err;
> > > +       }
> > > +
> > > +       ret = EFI_CALL(root->open(root, &f, default_file_name,
> > > +                                 EFI_FILE_MODE_READ, 0));
> > > +       efi_free_pool(default_file_name);
> > > +       if (ret != EFI_SUCCESS)
> > > +               goto err;
> > > +
> > > +       EFI_CALL(f->close(f));
> > > +
> > > +       ret = EFI_CALL(bs->open_protocol(handle, &efi_guid_device_path,
> > > +                                        (void **)&device_path, efi_root, NULL,
> > > +                                        EFI_OPEN_PROTOCOL_GET_PROTOCOL));
> > > +       if (ret != EFI_SUCCESS)
> > > +               goto err;
> > > +
> > > +       full_path = efi_dp_append(device_path, file_path);
> > > +       if (!full_path) {
> > > +               ret = EFI_OUT_OF_RESOURCES;
> > > +               goto err;
> > > +       }
> > > +
> > > +       *dp = full_path;
> > > +err:
> > > +       efi_free_pool(file_path);
> > > +
> > > +       return ret;
> > > +}
> >
> > We discussed this offline, adding it here for completeness.
> > What is happening here, is that we are mounting the blkmap disk and
> > try to search boot options on the fly.
> > Since u-boot will scan all boot options once a disk is probed, the
> > boot option you are trying to find is already added in the EFI
> > bootmgr.  I think it's going to be easier to search for that specific
> > boot option instead of re-scanning for it on the fly.
>
> I'm now trying to implement loading a default file
> from the auto-generated boot option, I would like to consult with you.
>
> My v9 implementation to load the default file
> from blkmap device is as follows.
>
> /**
>  * try_load_default_file() - try to load the default file
>  *
>  * Search the device having EFI_SIMPLE_FILE_SYSTEM_PROTOCOL,
>  * then try to load with the default boot file(e.g. EFI/BOOT/BOOTAA64.EFI).
>  *
>  * @dev                        pointer to the UCLASS_BLK or
> UCLASS_PARTITION udevice
>  * @image_handle:      pointer to handle for newly installed image
>  * Return:             status code
>  */
> static efi_status_t try_load_default_file(struct udevice *dev,
>                                          efi_handle_t *image_handle)
> {
>        efi_status_t ret;
>        efi_handle_t handle;
>        struct efi_handler *handler;
>        struct efi_device_path *file_path;
>        struct efi_device_path *device_path;
>
>        if (dev_tag_get_ptr(dev, DM_TAG_EFI, (void **)&handle)) {
>                log_warning("DM_TAG_EFI not found\n");
>                return EFI_INVALID_PARAMETER;
>        }
>
>        ret = efi_search_protocol(handle,
>
> &efi_simple_file_system_protocol_guid, &handler);
>        if (ret != EFI_SUCCESS)
>                return ret;
>
>        ret = EFI_CALL(bs->open_protocol(handle, &efi_guid_device_path,
>                                         (void **)&device_path, efi_root, NULL,
>                                         EFI_OPEN_PROTOCOL_GET_PROTOCOL));
>        if (ret != EFI_SUCCESS)
>                return ret;
>
>        file_path = expand_media_path(device_path);
>        ret = EFI_CALL(efi_load_image(true, efi_root, file_path, NULL, 0,
>                                      image_handle));
>        efi_free_pool(file_path);
>
>        return ret;
> }
>
> Note that try_load_default_file() is repeatedly called
> with all child partition devices until it succeeds.
>
> If we try to load the default file from the auto-generated boot option,
> we probably need to do the following steps.
>   - search all auto-generated boot option
>       - deserialize the boot option
>       - check the boot option has device_path points to the blkmap
> blk/partition device
>       - call expand_media_path() with the device_path of the boot option
>
> Since we already have the devive_path of the blk/partition devices,
> I think it is simple we just call expand_media_path() with these device_path
> instead of searching for the boot option.
>
> What do you think?

Fair enough,
Can we then replace the open coded file_path = efi_dp_from_file(NULL,
"/EFI/BOOT/" BOOTEFI_NAME); etc with expand_media_path?
That function already search for the
efi_simple_file_system_protocol_guid and we should avoid code
duplication

Thanks
/Ilias


>
> Thanks,
> Masahisa Kojima
>
> >
> > Thanks
> > /Ilias
> >
> >
> >
> > > +
> > > +/**
> > > + * check_disk_has_default_file() - load the default file
> > > + *
> > > + * @blk:       pointer to the UCLASS_BLK udevice
> > > + * @dp:                pointer to default file device path
> > > + * Return:     status code
> > > + */
> > > +static efi_status_t check_disk_has_default_file(struct udevice *blk,
> > > +                                               struct efi_device_path **dp)
> > > +{
> > > +       efi_status_t ret;
> > > +       struct udevice *partition;
> > > +
> > > +       /* image that has no partition table but a file system */
> > > +       ret = search_default_file(blk, dp);
> > > +       if (ret == EFI_SUCCESS)
> > > +               return ret;
> > > +
> > > +       /* try the partitions */
> > > +       device_foreach_child(partition, blk) {
> > > +               enum uclass_id id;
> > > +
> > > +               id = device_get_uclass_id(partition);
> > > +               if (id != UCLASS_PARTITION)
> > > +                       continue;
> > > +
> > > +               ret = search_default_file(partition, dp);
> > > +               if (ret == EFI_SUCCESS)
> > > +                       return ret;
> > > +       }
> > > +
> > > +       return EFI_NOT_FOUND;
> > > +}
> > > +
> > > +/**
> > > + * prepare_loaded_image() - prepare ramdisk for downloaded image
> > > + *
> > > + * @label:     label of load option
> > > + * @addr:      image address
> > > + * @size:      image size
> > > + * @dp:                pointer to default file device path
> > > + * Return:     status code
> > > + */
> > > +static efi_status_t prepare_loaded_image(u16 *label, ulong addr, ulong size,
> > > +                                        struct efi_device_path **dp)
> > > +{
> > > +       efi_status_t ret;
> > > +       struct udevice *blk;
> > > +
> > > +       blk = mount_image(label, addr, size);
> > > +       if (!blk)
> > > +               return EFI_LOAD_ERROR;
> > > +
> > > +       ret = check_disk_has_default_file(blk, dp);
> > > +       if (ret != EFI_SUCCESS) {
> > > +               log_info("Cannot boot from downloaded image\n");
> > > +               goto err;
> > > +       }
> > > +
> > > +       /*
> > > +        * TODO: expose the ramdisk to OS.
> > > +        * Need to pass the ramdisk information by the architecture-specific
> > > +        * methods such as 'pmem' device-tree node.
> > > +        */
> > > +       ret = efi_add_memory_map(addr, size, EFI_RESERVED_MEMORY_TYPE);
> > > +       if (ret != EFI_SUCCESS) {
> > > +               log_err("Memory reservation failed\n");
> > > +               goto err;
> > > +       }
> > > +
> > > +       ramdisk_blk_dev = blk;
> > > +
> > > +       return EFI_SUCCESS;
> > > +
> > > +err:
> > > +       if (blkmap_destroy(blk->parent))
> > > +               log_err("Destroying blkmap failed\n");
> > > +
> > > +       return ret;
> > > +}
> > > +
> > > +/**
> > > + * efi_bootmgr_release_uridp_resource() - cleanup uri device path resource
> > > + *
> > > + * Return:     status code
> > > + */
> > > +efi_status_t efi_bootmgr_release_uridp_resource(void)
> > > +{
> > > +       efi_status_t ret = EFI_SUCCESS;
> > > +
> > > +       if (ramdisk_blk_dev) {
> > > +               ret = efi_add_memory_map(image_addr, image_size,
> > > +                                        EFI_CONVENTIONAL_MEMORY);
> > > +               if (ret != EFI_SUCCESS)
> > > +                       log_err("Reclaiming memory failed\n");
> > > +
> > > +               if (blkmap_destroy(ramdisk_blk_dev->parent)) {
> > > +                       log_err("Destroying blkmap failed\n");
> > > +                       ret = EFI_DEVICE_ERROR;
> > > +               }
> > > +
> > > +               ramdisk_blk_dev = NULL;
> > > +       }
> > > +
> > > +       efi_free_pool(loaded_dp);
> > > +       loaded_dp = NULL;
> > > +
> > > +       return ret;
> > > +}
> > > +
> > > +/**
> > > + * efi_bootmgr_image_return_notify() - return to efibootmgr callback
> > > + *
> > > + * @event:     the event for which this notification function is registered
> > > + * @context:   event context - not used in this function
> > > + */
> > > +static void EFIAPI efi_bootmgr_image_return_notify(struct efi_event *event,
> > > +                                                  void *context)
> > > +{
> > > +       efi_status_t ret;
> > > +
> > > +       EFI_ENTRY("%p, %p", event, context);
> > > +       ret = efi_bootmgr_release_uridp_resource();
> > > +       EFI_EXIT(ret);
> > > +}
> > > +
> > > +/**
> > > + * try_load_from_uri_path() - Handle the URI device path
> > > + *
> > > + * @uridp:     uri device path
> > > + * @lo_label:  label of load option
> > > + * @handle:    pointer to handle for newly installed image
> > > + * Return:     status code
> > > + */
> > > +static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
> > > +                                          u16 *lo_label,
> > > +                                          efi_handle_t *handle)
> > > +{
> > > +       char *s;
> > > +       int err;
> > > +       int uri_len;
> > > +       efi_status_t ret;
> > > +       void *source_buffer;
> > > +       efi_uintn_t source_size;
> > > +       struct efi_event *event = NULL;
> > > +
> > > +       loaded_dp = NULL;
> > > +       ramdisk_blk_dev = NULL;
> > > +
> > > +       s = env_get("loadaddr");
> > > +       if (!s) {
> > > +               log_err("Error: loadaddr is not set\n");
> > > +               return EFI_INVALID_PARAMETER;
> > > +       }
> > > +       image_addr = hextoul(s, NULL);
> > > +       err = wget_with_dns(image_addr, uridp->uri);
> > > +       if (err < 0)
> > > +               return EFI_INVALID_PARAMETER;
> > > +       image_size = env_get_hex("filesize", 0);
> > > +       if (!image_size)
> > > +               return EFI_INVALID_PARAMETER;
> > > +
> > > +       /*
> > > +        * If the file extension is ".iso" or ".img", mount it and try to load
> > > +        * the default file.
> > > +        * If the file is PE-COFF image, load the downloaded file.
> > > +        */
> > > +       uri_len = strlen(uridp->uri);
> > > +       if (!strncmp(&uridp->uri[uri_len - 4], ".iso", 4) ||
> > > +           !strncmp(&uridp->uri[uri_len - 4], ".img", 4)) {
> > > +               ret = prepare_loaded_image(lo_label, image_addr, image_size, &loaded_dp);
> > > +               if (ret != EFI_SUCCESS)
> > > +                       goto err;
> > > +
> > > +               source_buffer = NULL;
> > > +               source_size = 0;
> > > +       } else if (efi_check_pe((void *)image_addr, image_size, NULL) == EFI_SUCCESS) {
> > > +               efi_handle_t mem_handle = NULL;
> > > +
> > > +               /*
> > > +                * loaded_dp must exist until efi application returns,
> > > +                * will be freed in return_to_efibootmgr event callback.
> > > +                */
> > > +               loaded_dp = efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE,
> > > +                                           (uintptr_t)image_addr, image_size);
> > > +               ret = efi_install_multiple_protocol_interfaces(
> > > +                       &mem_handle, &efi_guid_device_path, loaded_dp, NULL);
> > > +               if (ret != EFI_SUCCESS)
> > > +                       goto err;
> > > +
> > > +               source_buffer = (void *)image_addr;
> > > +               source_size = image_size;
> > > +       } else {
> > > +               log_err("Error: file type is not supported\n");
> > > +               return EFI_UNSUPPORTED;
> > > +       }
> > > +
> > > +       ret = EFI_CALL(efi_load_image(false, efi_root, loaded_dp, source_buffer,
> > > +                                     source_size, handle));
> > > +       if (ret != EFI_SUCCESS)
> > > +               goto err;
> > > +
> > > +       /* create event for cleanup when the image returns or error occurs */
> > > +       ret = efi_create_event(EVT_NOTIFY_SIGNAL, TPL_CALLBACK,
> > > +                              efi_bootmgr_image_return_notify, NULL,
> > > +                              &efi_guid_event_group_return_to_efibootmgr,
> > > +                              &event);
> > > +       if (ret != EFI_SUCCESS) {
> > > +               log_err("Creating event failed\n");
> > > +               goto err;
> > > +       }
> > > +
> > > +       return ret;
> > > +
> > > +err:
> > > +       efi_bootmgr_release_uridp_resource();
> > > +
> > > +       return ret;
> > > +}
> > > +
> > >  /**
> > >   * try_load_entry() - try to load image for boot option
> > >   *
> > > @@ -211,6 +541,13 @@ static efi_status_t try_load_entry(u16 n, efi_handle_t *handle,
> > >                 if (EFI_DP_TYPE(lo.file_path, MEDIA_DEVICE, FILE_PATH)) {
> > >                         /* file_path doesn't contain a device path */
> > >                         ret = try_load_from_short_path(lo.file_path, handle);
> > > +               } else if (EFI_DP_TYPE(lo.file_path, MESSAGING_DEVICE, MSG_URI)) {
> > > +                       if (IS_ENABLED(CONFIG_EFI_HTTP_BOOT))
> > > +                               ret = try_load_from_uri_path(
> > > +                                       (struct efi_device_path_uri *)lo.file_path,
> > > +                                       lo.label, handle);
> > > +                       else
> > > +                               ret = EFI_LOAD_ERROR;
> > >                 } else {
> > >                         file_path = expand_media_path(lo.file_path);
> > >                         ret = EFI_CALL(efi_load_image(true, efi_root, file_path,
> > > --
> > > 2.34.1
> > >
