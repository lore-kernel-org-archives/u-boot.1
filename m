Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B7E1C4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 09:37:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FE188715B;
	Tue,  7 Nov 2023 10:37:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="E9wsXbMe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B8288715E; Tue,  7 Nov 2023 10:37:53 +0100 (CET)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0D75870EF
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 10:37:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5094727fa67so7321619e87.3
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 01:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699349870; x=1699954670; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=m+JtNFLGyU85OlszsZmKfyOKaslWFjZiF/+rzELr9e8=;
 b=E9wsXbMeObYV5l1/vbOshkryaRMVVN5sBPjYnRxHR1Ezeue5pO8jvwrYOps3uBoJwb
 GO1T8APPMJlG7DPkgG8AgtdMJdjqXVsddb9J8v5tvBRahTcEztQpjW2PIzD1wq8wf0ns
 7kwssbcbyTXI5fzHlLrOiPW/Gz74YTZOPzp8JAkNQx4RjXrsJfxwQRG03XySRyTPcUdn
 H/aD1qPL+q+W5pvtH0dkavSuHrNzE73bTxfTBDmvMWof2rcEPsSvYdI5Oi8py7q0w4wi
 JpaR1Q3J2nIIZyHjPcYNe5hAa9sTjgLkFiiZW/IwNGD7xube/kwFmEkZdQCrO0x0Hly1
 G3og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699349870; x=1699954670;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m+JtNFLGyU85OlszsZmKfyOKaslWFjZiF/+rzELr9e8=;
 b=jVN9qmA4yIJQQsYHPs5OxY3/wIZDRm8vNhuON6OyAp/vN6oWRv7SNwTBLPj8HQD37y
 pNyPq4ZNff02Bbnxg8on7h0zNl+NQ5e1LkHMrrhqX3nLfIBsWnvRTMoP4aklj3+sPopb
 9e+ETE+Jt3XDXhEt1ooFmxVOoxVNIF13dBhZYXwoSy62862rcyI2bHPlgnWZnzJ7hfkM
 vZCAwpYyLZKgAH3rBntX2dVabwZzDqfqQChgs2gfMJnQQZUNykmS8BYJsGuHZAF2IdaK
 KZ06yHAcStDUnGvGLr1p+xCiz0zBMUWV9zUNQEuwBacVrrOLrB8w3Y8kFZrgLzSmtprL
 Wi6A==
X-Gm-Message-State: AOJu0YzMyWWhdoiUw/WAeLApLLZh4jT3vG8FfAUFxAezG8+DcaZZOH7X
 O8X2TZOCZjNEbi7oyNWt2SO8Ms0yNcbT4ufnVQaa0w==
X-Google-Smtp-Source: AGHT+IEMDqeeawoxqrEVq1f4K1wpOfBwNhP45PPGQV2hOIuRMBvkev324SRR6p6LqWU3/QucBGwEhjiVGqIQd9gys30=
X-Received: by 2002:ac2:43c3:0:b0:507:ab6b:31ef with SMTP id
 u3-20020ac243c3000000b00507ab6b31efmr20716892lfl.41.1699349870043; Tue, 07
 Nov 2023 01:37:50 -0800 (PST)
MIME-Version: 1.0
References: <20231106113920.3631591-1-masahisa.kojima@linaro.org>
 <20231106113920.3631591-8-masahisa.kojima@linaro.org>
In-Reply-To: <20231106113920.3631591-8-masahisa.kojima@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 7 Nov 2023 11:37:13 +0200
Message-ID: <CAC_iWjJvhjC3NL18ypkmKTC-kBw+y_WsO+hqNMuE5NZzsVNf6w@mail.gmail.com>
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

On Mon, 6 Nov 2023 at 13:40, Masahisa Kojima <masahisa.kojima@linaro.org> wrote:
[...]

> +/**
> + * search_default_file() - search default file
> + *
> + * @dev:       pointer to the UCLASS_BLK or UCLASS_PARTITION udevice
> + * @dp:                pointer to default file device path
> + * Return:     status code
> + */
> +static efi_status_t search_default_file(struct udevice *dev,
> +                                       struct efi_device_path **dp)
> +{
> +       efi_status_t ret;
> +       efi_handle_t handle;
> +       u16 *default_file_name = NULL;
> +       struct efi_file_handle *root, *f;
> +       struct efi_device_path *full_path;
> +       struct efi_device_path *device_path;
> +       struct efi_device_path *file_path = NULL;
> +       struct efi_simple_file_system_protocol *file_system;
> +
> +       if (dev_tag_get_ptr(dev, DM_TAG_EFI, (void **)&handle)) {
> +               log_warning("DM_TAG_EFI not found\n");
> +               return EFI_INVALID_PARAMETER;
> +       }
> +
> +       ret = EFI_CALL(bs->open_protocol(handle, &efi_simple_file_system_protocol_guid,
> +                                        (void **)&file_system, efi_root, NULL,
> +                                        EFI_OPEN_PROTOCOL_GET_PROTOCOL));
> +       if (ret != EFI_SUCCESS)
> +               return ret;
> +
> +       ret = EFI_CALL(file_system->open_volume(file_system, &root));
> +       if (ret != EFI_SUCCESS)
> +               return ret;
> +
> +       file_path = efi_dp_from_file(NULL, "/EFI/BOOT/" BOOTEFI_NAME);
> +       default_file_name = efi_dp_str(file_path);
> +       if (!default_file_name) {
> +               ret = EFI_OUT_OF_RESOURCES;
> +               goto err;
> +       }
> +
> +       ret = EFI_CALL(root->open(root, &f, default_file_name,
> +                                 EFI_FILE_MODE_READ, 0));
> +       efi_free_pool(default_file_name);
> +       if (ret != EFI_SUCCESS)
> +               goto err;
> +
> +       EFI_CALL(f->close(f));
> +
> +       ret = EFI_CALL(bs->open_protocol(handle, &efi_guid_device_path,
> +                                        (void **)&device_path, efi_root, NULL,
> +                                        EFI_OPEN_PROTOCOL_GET_PROTOCOL));
> +       if (ret != EFI_SUCCESS)
> +               goto err;
> +
> +       full_path = efi_dp_append(device_path, file_path);
> +       if (!full_path) {
> +               ret = EFI_OUT_OF_RESOURCES;
> +               goto err;
> +       }
> +
> +       *dp = full_path;
> +err:
> +       efi_free_pool(file_path);
> +
> +       return ret;
> +}

We discussed this offline, adding it here for completeness.
What is happening here, is that we are mounting the blkmap disk and
try to search boot options on the fly.
Since u-boot will scan all boot options once a disk is probed, the
boot option you are trying to find is already added in the EFI
bootmgr.  I think it's going to be easier to search for that specific
boot option instead of re-scanning for it on the fly.

Thanks
/Ilias



> +
> +/**
> + * check_disk_has_default_file() - load the default file
> + *
> + * @blk:       pointer to the UCLASS_BLK udevice
> + * @dp:                pointer to default file device path
> + * Return:     status code
> + */
> +static efi_status_t check_disk_has_default_file(struct udevice *blk,
> +                                               struct efi_device_path **dp)
> +{
> +       efi_status_t ret;
> +       struct udevice *partition;
> +
> +       /* image that has no partition table but a file system */
> +       ret = search_default_file(blk, dp);
> +       if (ret == EFI_SUCCESS)
> +               return ret;
> +
> +       /* try the partitions */
> +       device_foreach_child(partition, blk) {
> +               enum uclass_id id;
> +
> +               id = device_get_uclass_id(partition);
> +               if (id != UCLASS_PARTITION)
> +                       continue;
> +
> +               ret = search_default_file(partition, dp);
> +               if (ret == EFI_SUCCESS)
> +                       return ret;
> +       }
> +
> +       return EFI_NOT_FOUND;
> +}
> +
> +/**
> + * prepare_loaded_image() - prepare ramdisk for downloaded image
> + *
> + * @label:     label of load option
> + * @addr:      image address
> + * @size:      image size
> + * @dp:                pointer to default file device path
> + * Return:     status code
> + */
> +static efi_status_t prepare_loaded_image(u16 *label, ulong addr, ulong size,
> +                                        struct efi_device_path **dp)
> +{
> +       efi_status_t ret;
> +       struct udevice *blk;
> +
> +       blk = mount_image(label, addr, size);
> +       if (!blk)
> +               return EFI_LOAD_ERROR;
> +
> +       ret = check_disk_has_default_file(blk, dp);
> +       if (ret != EFI_SUCCESS) {
> +               log_info("Cannot boot from downloaded image\n");
> +               goto err;
> +       }
> +
> +       /*
> +        * TODO: expose the ramdisk to OS.
> +        * Need to pass the ramdisk information by the architecture-specific
> +        * methods such as 'pmem' device-tree node.
> +        */
> +       ret = efi_add_memory_map(addr, size, EFI_RESERVED_MEMORY_TYPE);
> +       if (ret != EFI_SUCCESS) {
> +               log_err("Memory reservation failed\n");
> +               goto err;
> +       }
> +
> +       ramdisk_blk_dev = blk;
> +
> +       return EFI_SUCCESS;
> +
> +err:
> +       if (blkmap_destroy(blk->parent))
> +               log_err("Destroying blkmap failed\n");
> +
> +       return ret;
> +}
> +
> +/**
> + * efi_bootmgr_release_uridp_resource() - cleanup uri device path resource
> + *
> + * Return:     status code
> + */
> +efi_status_t efi_bootmgr_release_uridp_resource(void)
> +{
> +       efi_status_t ret = EFI_SUCCESS;
> +
> +       if (ramdisk_blk_dev) {
> +               ret = efi_add_memory_map(image_addr, image_size,
> +                                        EFI_CONVENTIONAL_MEMORY);
> +               if (ret != EFI_SUCCESS)
> +                       log_err("Reclaiming memory failed\n");
> +
> +               if (blkmap_destroy(ramdisk_blk_dev->parent)) {
> +                       log_err("Destroying blkmap failed\n");
> +                       ret = EFI_DEVICE_ERROR;
> +               }
> +
> +               ramdisk_blk_dev = NULL;
> +       }
> +
> +       efi_free_pool(loaded_dp);
> +       loaded_dp = NULL;
> +
> +       return ret;
> +}
> +
> +/**
> + * efi_bootmgr_image_return_notify() - return to efibootmgr callback
> + *
> + * @event:     the event for which this notification function is registered
> + * @context:   event context - not used in this function
> + */
> +static void EFIAPI efi_bootmgr_image_return_notify(struct efi_event *event,
> +                                                  void *context)
> +{
> +       efi_status_t ret;
> +
> +       EFI_ENTRY("%p, %p", event, context);
> +       ret = efi_bootmgr_release_uridp_resource();
> +       EFI_EXIT(ret);
> +}
> +
> +/**
> + * try_load_from_uri_path() - Handle the URI device path
> + *
> + * @uridp:     uri device path
> + * @lo_label:  label of load option
> + * @handle:    pointer to handle for newly installed image
> + * Return:     status code
> + */
> +static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
> +                                          u16 *lo_label,
> +                                          efi_handle_t *handle)
> +{
> +       char *s;
> +       int err;
> +       int uri_len;
> +       efi_status_t ret;
> +       void *source_buffer;
> +       efi_uintn_t source_size;
> +       struct efi_event *event = NULL;
> +
> +       loaded_dp = NULL;
> +       ramdisk_blk_dev = NULL;
> +
> +       s = env_get("loadaddr");
> +       if (!s) {
> +               log_err("Error: loadaddr is not set\n");
> +               return EFI_INVALID_PARAMETER;
> +       }
> +       image_addr = hextoul(s, NULL);
> +       err = wget_with_dns(image_addr, uridp->uri);
> +       if (err < 0)
> +               return EFI_INVALID_PARAMETER;
> +       image_size = env_get_hex("filesize", 0);
> +       if (!image_size)
> +               return EFI_INVALID_PARAMETER;
> +
> +       /*
> +        * If the file extension is ".iso" or ".img", mount it and try to load
> +        * the default file.
> +        * If the file is PE-COFF image, load the downloaded file.
> +        */
> +       uri_len = strlen(uridp->uri);
> +       if (!strncmp(&uridp->uri[uri_len - 4], ".iso", 4) ||
> +           !strncmp(&uridp->uri[uri_len - 4], ".img", 4)) {
> +               ret = prepare_loaded_image(lo_label, image_addr, image_size, &loaded_dp);
> +               if (ret != EFI_SUCCESS)
> +                       goto err;
> +
> +               source_buffer = NULL;
> +               source_size = 0;
> +       } else if (efi_check_pe((void *)image_addr, image_size, NULL) == EFI_SUCCESS) {
> +               efi_handle_t mem_handle = NULL;
> +
> +               /*
> +                * loaded_dp must exist until efi application returns,
> +                * will be freed in return_to_efibootmgr event callback.
> +                */
> +               loaded_dp = efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE,
> +                                           (uintptr_t)image_addr, image_size);
> +               ret = efi_install_multiple_protocol_interfaces(
> +                       &mem_handle, &efi_guid_device_path, loaded_dp, NULL);
> +               if (ret != EFI_SUCCESS)
> +                       goto err;
> +
> +               source_buffer = (void *)image_addr;
> +               source_size = image_size;
> +       } else {
> +               log_err("Error: file type is not supported\n");
> +               return EFI_UNSUPPORTED;
> +       }
> +
> +       ret = EFI_CALL(efi_load_image(false, efi_root, loaded_dp, source_buffer,
> +                                     source_size, handle));
> +       if (ret != EFI_SUCCESS)
> +               goto err;
> +
> +       /* create event for cleanup when the image returns or error occurs */
> +       ret = efi_create_event(EVT_NOTIFY_SIGNAL, TPL_CALLBACK,
> +                              efi_bootmgr_image_return_notify, NULL,
> +                              &efi_guid_event_group_return_to_efibootmgr,
> +                              &event);
> +       if (ret != EFI_SUCCESS) {
> +               log_err("Creating event failed\n");
> +               goto err;
> +       }
> +
> +       return ret;
> +
> +err:
> +       efi_bootmgr_release_uridp_resource();
> +
> +       return ret;
> +}
> +
>  /**
>   * try_load_entry() - try to load image for boot option
>   *
> @@ -211,6 +541,13 @@ static efi_status_t try_load_entry(u16 n, efi_handle_t *handle,
>                 if (EFI_DP_TYPE(lo.file_path, MEDIA_DEVICE, FILE_PATH)) {
>                         /* file_path doesn't contain a device path */
>                         ret = try_load_from_short_path(lo.file_path, handle);
> +               } else if (EFI_DP_TYPE(lo.file_path, MESSAGING_DEVICE, MSG_URI)) {
> +                       if (IS_ENABLED(CONFIG_EFI_HTTP_BOOT))
> +                               ret = try_load_from_uri_path(
> +                                       (struct efi_device_path_uri *)lo.file_path,
> +                                       lo.label, handle);
> +                       else
> +                               ret = EFI_LOAD_ERROR;
>                 } else {
>                         file_path = expand_media_path(lo.file_path);
>                         ret = EFI_CALL(efi_load_image(true, efi_root, file_path,
> --
> 2.34.1
>
