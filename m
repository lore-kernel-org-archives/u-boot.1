Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E3AC41513
	for <u-boot@archiver.kernel.org>; Wed,  8 May 2024 13:48:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6044A8844B;
	Wed,  8 May 2024 15:48:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HLKOZwxK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB6398843D; Wed,  8 May 2024 15:48:01 +0200 (CEST)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 013F0885AF
 for <u-boot@lists.denx.de>; Wed,  8 May 2024 15:47:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-51fea3031c3so5715656e87.0
 for <u-boot@lists.denx.de>; Wed, 08 May 2024 06:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715176077; x=1715780877; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Jkhe99MuWaEtySemysRvFB9PmvpxoBKVOOLJukxzJA8=;
 b=HLKOZwxKVrdfQm2nDn4mjxUsRzbF3/qwxQ9GVplKR6khZLBsJqP/C4JuJJKCtycRUL
 a997toeP2zSMBLAkZ15WBM4pL8lC/ojNEMCNplcLK7E31+sAufIx+0pEgREg6Bb6Aqru
 Oo83cfhhQWCUXuucpLs4oDvwvu7ZU+6u94ps+XAVcVSHWSdSGbJ0VGju5WS9KgP9x9Zd
 b+YgX3b8wFeRUuZOmbO9jcYqcyAdkxbZpGYIRT0BbuACtFmHKxp2HaSIuBTJHg+LAoy9
 nRsUhAKQWw5h8vqzAKZmWz/HGHlbI14jhiI/8rVKOCJAjeImu94RBFj3Y1G2pN4r3vec
 xIbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715176077; x=1715780877;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Jkhe99MuWaEtySemysRvFB9PmvpxoBKVOOLJukxzJA8=;
 b=vWnLKtnM/JMovhBITDvFsX7oRBuQPgmfQ2zFRg+aujq7nYe+T1JJhhCZvNsVKv8Dtm
 JoIg7PVXAI61EHmbTJ8I44SDSihpBUmPShP5zw+y+PKQn4YBhaKgp9A38BX4rzu21LbA
 aqSI08Pr9/2C+rAwKS4GVTKJ6Gao/b6Dk8NAwzJ0h/XhHk2e3Qm23xEvrvGZQuZIojfU
 PNrxFYnQCdzJKfum7ZjLGwP8Vq02H7MDyF6W9X69Ss+9mpTbdnWQl5nSTqm0Zl329B5a
 z9R0mlKNBg8LJGpPBq95fxL2G1mf69n2xDz3ohWLmKadPG1CqxO0PXCJoxeEoe8f2+oU
 xw7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbMvMZXOD7LTnbVGBXXGl5bcbtw6mf+B7kS1VFhIg8yf3kD3gYEEH2QbcsgVY8t1kb/Yh6HezBc4xo7+eKcEn4vVkGEA==
X-Gm-Message-State: AOJu0YxzZltGEKEpSJ9Pz6CMrG511vxhZl/6265OSY7nf8LoKLxdTsdd
 x008YggOJMaf+/hSDKO3XM6p2wZ9EbuJ4kz/F7g8n8LKbTQ8wtIGdcAnYIh4oHTBxVdG6eXxTqH
 CD1oBuPsiIe18zuxoMfrfcpSUmh6lfGuGqKaMsQ==
X-Google-Smtp-Source: AGHT+IHm4a7nRvAImNDxhOb3JRpM85cWB0Ogglft0+IMgCHq6aDccvocQt5PcVzMTsbeS/VZ+M1BKHkSxNu0SHdxE4U=
X-Received: by 2002:ac2:4c2c:0:b0:51c:eeee:8679 with SMTP id
 2adb3069b0e04-5217cf3cb15mr2058699e87.56.1715176077002; Wed, 08 May 2024
 06:47:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240508112401.155528-1-o451686892@gmail.com>
In-Reply-To: <20240508112401.155528-1-o451686892@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 8 May 2024 16:47:20 +0300
Message-ID: <CAC_iWjLv8cdL-zUfYA+7GAtY=xHOHN6kJmg7gOFdbCmpPoiB5A@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: capsule: detect possible ESP device path
To: Weizhao Ouyang <o451686892@gmail.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Dan Carpenter <dan.carpenter@linaro.org>, u-boot@lists.denx.de
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

Hi Weizhao,

On Wed, 8 May 2024 at 14:24, Weizhao Ouyang <o451686892@gmail.com> wrote:
>
> When using CapsuleApp to execute on-disk update, it will choose the
> first boot option as BootNext entry to perform the capsule update after
> a reboot.

This is not entirely accurate. The capsule update on-disk mechanism
will look in the ESP pointed to by BootNext or the highest priority
BootOrder.
But the problem you are describing isn't tied only to capsules. IIUC
if you have a logical partition with bootXXX.efi the current code will
ignore it as well and the automatic selection of the boot option won't
work.
Can you adjust the commit message on v2 and mention the scanning as an
issue with the capsule on disk being the obvious side-effect?

> But auto-generate boot option will ignore the logical
> partition which might be an ESP, thus it could not find the capsule
> file.
>
> Align with the EDK II, detect the possible ESP device path by expanding
> the media path.

>
> Fixes: f86fba8adbf3 ("efi_loader: auto-generate boot option for each blkio device")
> Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
> ---
>  include/efi_loader.h          |   6 ++
>  lib/efi_loader/efi_boottime.c |  15 ++---
>  lib/efi_loader/efi_capsule.c  | 110 +++++++++++++++++++++++++++++++++-
>  3 files changed, 118 insertions(+), 13 deletions(-)
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 9600941aa327..9d78fa936701 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -683,6 +683,12 @@ efi_status_t efi_protocol_open(struct efi_handler *handler,
>                                void **protocol_interface, void *agent_handle,
>                                void *controller_handle, uint32_t attributes);
>
> +/* Connect drivers to controller */
> +efi_status_t EFIAPI efi_connect_controller(efi_handle_t controller_handle,
> +                                          efi_handle_t *driver_image_handle,
> +                                          struct efi_device_path *remain_device_path,
> +                                          bool recursive);
> +
>  /* Install multiple protocol interfaces */
>  efi_status_t EFIAPI
>  efi_install_multiple_protocol_interfaces(efi_handle_t *handle, ...);
> diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
> index 1951291747cd..2c86d78208b2 100644
> --- a/lib/efi_loader/efi_boottime.c
> +++ b/lib/efi_loader/efi_boottime.c
> @@ -103,12 +103,6 @@ static efi_status_t EFIAPI efi_disconnect_controller(
>                                         efi_handle_t driver_image_handle,
>                                         efi_handle_t child_handle);
>
> -static
> -efi_status_t EFIAPI efi_connect_controller(efi_handle_t controller_handle,
> -                                          efi_handle_t *driver_image_handle,
> -                                          struct efi_device_path *remain_device_path,
> -                                          bool recursive);
> -
>  /* Called on every callback entry */
>  int __efi_entry_check(void)
>  {
> @@ -3670,11 +3664,10 @@ static efi_status_t efi_connect_single_controller(
>   *
>   * Return: status code
>   */
> -static efi_status_t EFIAPI efi_connect_controller(
> -                       efi_handle_t controller_handle,
> -                       efi_handle_t *driver_image_handle,
> -                       struct efi_device_path *remain_device_path,
> -                       bool recursive)
> +efi_status_t EFIAPI efi_connect_controller(efi_handle_t controller_handle,
> +                                          efi_handle_t *driver_image_handle,
> +                                          struct efi_device_path *remain_device_path,
> +                                          bool recursive)
>  {
>         efi_status_t r;
>         efi_status_t ret = EFI_NOT_FOUND;
> diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.c
> index de0d49ebebda..919e3cba071b 100644
> --- a/lib/efi_loader/efi_capsule.c
> +++ b/lib/efi_loader/efi_capsule.c
> @@ -922,6 +922,105 @@ static bool device_is_present_and_system_part(struct efi_device_path *dp)
>         return true;
>  }
>
> +/**
> + * get_esp_from_boot_option_file_path - get the expand device path

expanded

> + *
> + * Get a possible efi system partition by expanding a boot option
> + * file path.
> + *
> + * @boot_dev   The device path pointing to a boot option
> + * Return:     The full ESP device path or NULL if fail
> + */
> +static struct efi_device_path *get_esp_from_boot_option_file_path(struct efi_device_path *boot_dev)
> +{
> +       efi_status_t ret = EFI_SUCCESS;
> +       efi_handle_t handle;
> +       struct efi_device_path *dp = boot_dev;
> +       struct efi_device_path *full_path = NULL;
> +
> +       ret = EFI_CALL(efi_locate_device_path(&efi_simple_file_system_protocol_guid,
> +                                             &dp,
> +                                             &handle));
> +       if (ret != EFI_SUCCESS)
> +               ret = EFI_CALL(efi_locate_device_path(&efi_block_io_guid, &dp, &handle));
> +
> +       /* Expand Media Device Path */

I don't see where the device path is expanded in this patch.
We already have try_load_from_media() which tries to do something
similar. Is anything missing from there?

> +       if (ret == EFI_SUCCESS && EFI_DP_TYPE(dp, END, END)) {

Can you invert the logic here and return immediately?
(if ret != EFI_SUCCESS ...etc )
    return full_path;

The indentation will go away.

> +               struct efi_device_path *temp_dp;
> +               struct efi_block_io *block_io;
> +               void *buffer;
> +               efi_handle_t *simple_file_system_handle;
> +               efi_uintn_t number_handles, index;
> +               u32 size;
> +               u32 temp_size;
> +
> +               temp_dp = boot_dev;
> +               ret = EFI_CALL(efi_locate_device_path(&efi_simple_file_system_protocol_guid,
> +                                                     &temp_dp,
> +                                                     &handle));
> +               /*
> +                * For device path pointing to simple file system, it only expands to one
> +                * full path

Why do we have multiple calls to efi_locate_device_path()? Aren't the
arguments identical?
Which part of edk2 did you read? Is it BmExpandMediaDevicePath()?


> +                */
> +               if (ret == EFI_SUCCESS && EFI_DP_TYPE(temp_dp, END, END)) {
> +                       if (device_is_present_and_system_part(temp_dp))
> +                               return temp_dp;
> +               }
> +
> +               /*
> +                * For device path only pointing to the removable device handle, try to
> +                * search all its children handles
> +                */
> +               ret = EFI_CALL(efi_locate_device_path(&efi_block_io_guid, &temp_dp, &handle));
> +               EFI_CALL(efi_connect_controller(handle, NULL, NULL, true));
> +
> +               /* Align with edk2, issue a dummy read to the device to check the device change */
> +               ret = EFI_CALL(efi_handle_protocol(handle, &efi_block_io_guid, (void **)&block_io));
> +               if (ret == EFI_SUCCESS) {
> +                       buffer = memalign(block_io->media->io_align, block_io->media->block_size);
> +                       if (buffer) {
> +                               ret = EFI_CALL(block_io->read_blocks(block_io,
> +                                                                    block_io->media->media_id,
> +                                                                    0,
> +                                                                    block_io->media->block_size,
> +                                                                    buffer));
> +                               free(buffer);
> +                       } else {
> +                               return full_path;
> +                       }
> +               } else {
> +                       return full_path;
> +               }
> +
> +               /* detect the default boot file from removable media */
> +               size = efi_dp_size(boot_dev) - sizeof(struct efi_device_path);
> +               EFI_CALL(efi_locate_handle_buffer(BY_PROTOCOL,
> +                                                 &efi_simple_file_system_protocol_guid,
> +                                                 NULL,
> +                                                 &number_handles,
> +                                                 &simple_file_system_handle));
> +               for (index = 0; index < number_handles; index++) {
> +                       EFI_CALL(efi_handle_protocol(simple_file_system_handle[index],
> +                                                    &efi_guid_device_path,
> +                                                    (void **)&temp_dp));
> +
> +                       log_debug("Search ESP %pD\n", temp_dp);
> +                       temp_size = efi_dp_size(temp_dp) - sizeof(struct efi_device_path);
> +                       if (size <= temp_size && !memcmp(temp_dp, boot_dev, size)) {
> +                               if (device_is_present_and_system_part(temp_dp)) {
> +                                       efi_free_pool(simple_file_system_handle);
> +                                       return temp_dp;
> +                               }
> +                       }
> +               }
> +
> +               if (simple_file_system_handle)
> +                       efi_free_pool(simple_file_system_handle);
> +       }
> +
> +       return full_path;
> +}
> +
>  /**
>   * find_boot_device - identify the boot device
>   *
> @@ -938,6 +1037,7 @@ static efi_status_t find_boot_device(void)
>         int i, num;
>         struct efi_simple_file_system_protocol *volume;
>         struct efi_device_path *boot_dev = NULL;
> +       struct efi_device_path *full_path = NULL;
>         efi_status_t ret;
>
>         /* find active boot device in BootNext */
> @@ -961,8 +1061,14 @@ static efi_status_t find_boot_device(void)
>                         if (device_is_present_and_system_part(boot_dev)) {
>                                 goto found;
>                         } else {
> -                               efi_free_pool(boot_dev);
> -                               boot_dev = NULL;
> +                               full_path = get_esp_from_boot_option_file_path(boot_dev);
> +                               if (full_path) {
> +                                       boot_dev = full_path;
> +                                       goto found;
> +                               } else {
> +                                       efi_free_pool(boot_dev);
> +                                       boot_dev = NULL;
> +                               }
>                         }
>                 }
>         }
> --
> 2.40.1
>

Thanks
/Ilias
