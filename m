Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E688C25B6B
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 19:35:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F1D787BAC;
	Thu, 26 Oct 2023 21:35:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="alX6ZMMN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3037A87BB9; Thu, 26 Oct 2023 21:35:39 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65AA287644
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 21:35:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-507975d34e8so1920473e87.1
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 12:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698348935; x=1698953735; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8/YMKlrNcuxLE/GbR0KhPtmKOju02AGOToI1dgN1Z3g=;
 b=alX6ZMMNXW9F7E/Fb/k3vUCVuOSdkBHMiP2U3iwMiO/NtgnuZ7zvdGVvs6vAKRGnjy
 BZozsaoroSE9qNQtPw3AsJqBOKuXCo5YaiShdCbiFyQ4i2dL/8iVE1NTavaGOmr2kEqs
 RhhpDzEGc9AI3J3lg7gtrKeYUuK+EuAHEk9nb9NFGIcNKofH8kB032htVnKZ6sUG+afZ
 DEzGeDYLWtQ/C/kd+McOJNfmeUOk/cIT3NU1tX+RTKGyjtSU9W3+40DQC1sdP5kfLInb
 CIEpkuoj7ejBsT7gaiAvcXJwrnevXPm4vVrqwX2GFLbPapIpze6h8boaUsh2usQKUyl5
 cyMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698348935; x=1698953735;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8/YMKlrNcuxLE/GbR0KhPtmKOju02AGOToI1dgN1Z3g=;
 b=vDnaQEJAPTkhVWxQtc6FA+kvD7KcVavg14t4POXasy4W/m6xKRDZGgf+91hJqub0z+
 yaG5UqNnSvhxR7b/6O68UDJ0CQhXzoOaJajO2aFg8d1BgqUuSuJ31j0OrAXaDILRtxnD
 7yiusdjFaRLobNvSlQ11APveXgczzJCEoNOj+Nwxx3s6i4x5rD5ucJjNEW4vLvQzb8Cz
 lA1br9nN8jJn7jg6pCVYnd05YpZk+qGF2+MhSxz1Kf6C1Vo9tbaW2iaa5Tvr2Z8Yy1xb
 lMx3eLuGR7/0h2SCC6U5WkfWb0XJmvquFIPL2vzeuKUx1K1C0hN+J3SpyzcM0PsvMYGv
 wSuQ==
X-Gm-Message-State: AOJu0YzoJUtBEv9ZOaupmQ/6HyKuXhFCjaxO6wnkuroTYzz+IoXxc4rQ
 xbdURJDxA+D5jmabFmiX66tFlb7G0Rxhq0vgZeTuug==
X-Google-Smtp-Source: AGHT+IFEukiDdZ0Lb7cmISdaJ1uS/ZHZ70cryyafyXQ5+buC+7JbLFUt3e43YXbCOjLD2td9RTgvgGYP3W9WXZefwPE=
X-Received: by 2002:a19:5211:0:b0:507:99fe:28f3 with SMTP id
 m17-20020a195211000000b0050799fe28f3mr240256lfb.34.1698348935477; Thu, 26 Oct
 2023 12:35:35 -0700 (PDT)
MIME-Version: 1.0
References: <20231025062845.3100964-1-masahisa.kojima@linaro.org>
 <20231025062845.3100964-6-masahisa.kojima@linaro.org>
In-Reply-To: <20231025062845.3100964-6-masahisa.kojima@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 26 Oct 2023 22:34:59 +0300
Message-ID: <CAC_iWjJJSTFQKctpsRzg=M9RVkD7G8qVSbfsMhfieW9k9oCrKg@mail.gmail.com>
Subject: Re: [PATCH v8 5/7] efi_loader: support boot from URI device path
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

Kojima-san,

Thanks the device path handling seems saner in this version.

On Wed, 25 Oct 2023 at 09:30, Masahisa Kojima
<masahisa.kojima@linaro.org> wrote:
>
> This supports to boot from the URI device path.
> When user selects the URI device path, bootmgr downloads
> the file using wget into the address specified by loadaddr
> env variable.
> If the file is .iso or .img file, mount the image with blkmap
> then try to boot with the default file(e.g. EFI/BOOT/BOOTAA64.EFI).
> Since boot option indicating the default file is automatically
> created when new disk is detected, system can boot by selecting
> the automatically created blkmap boot option.
> If the file is PE-COFF file, load and start the downloaded file.
>
> The buffer used to download the ISO image file must be
> reserved to avoid the unintended access to the image and
> expose the ramdisk to the OS.
> For PE-COFF file case, this memory reservation is done
> in LoadImage Boot Service.
>
> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> ---
>  cmd/bootefi.c                |   5 +
>  include/efi_loader.h         |   1 +
>  lib/efi_loader/Kconfig       |   9 ++
>  lib/efi_loader/efi_bootmgr.c | 229 +++++++++++++++++++++++++++++++++++
>  4 files changed, 244 insertions(+)
>
> diff --git a/cmd/bootefi.c b/cmd/bootefi.c
> index 20e5c94a33..74203ec5b6 100644
> --- a/cmd/bootefi.c
> +++ b/cmd/bootefi.c
> @@ -394,6 +394,11 @@ out:
>                         log_err("Failed to remove loadfile2 for initrd\n");
>         }
>
> +       if (IS_ENABLED(CONFIG_EFI_HTTP_BOOT)) {
> +               if (efi_bootmgr_release_ramdisk() != EFI_SUCCESS)
> +                       log_err("Failed to remove ramdisk\n");
> +       }
> +

So, I know I am the one who did this first and removed the loadfile2
protocol by calling a function in a boot failure.
I didn't like it back then either but we didn't have events.  I think
it's best if we define an event for reverting  the memory changes
instead of calling functions (and I will fix the same thing for
loadfile2 protocol destruction)

Heinrich what do you think?

>         /* Control is returned to U-Boot, disable EFI watchdog */
>         efi_set_watchdog(0);
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index e24410505f..2fea1f17fb 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -937,6 +937,7 @@ efi_status_t efi_set_load_options(efi_handle_t handle,
>                                   efi_uintn_t load_options_size,
>                                   void *load_options);
>  efi_status_t efi_bootmgr_load(efi_handle_t *handle, void **load_options);

[...]

>
> +#include <blk.h>
> +#include <blkmap.h>
>  #include <common.h>
>  #include <charset.h>
> +#include <dm.h>
>  #include <log.h>
>  #include <malloc.h>
> +#include <net.h>
>  #include <efi_default_filename.h>
>  #include <efi_loader.h>
>  #include <efi_variable.h>
> @@ -19,6 +23,10 @@
>  static const struct efi_boot_services *bs;
>  static const struct efi_runtime_services *rs;
>
> +static u32 image_size;
> +static ulong image_addr;
> +static struct udevice *ramdisk_blk_dev = NULL;
> +
>  const efi_guid_t efi_guid_bootmenu_auto_generated =
>                 EFICONFIG_AUTO_GENERATED_ENTRY_GUID;
>
> @@ -168,6 +176,197 @@ out:
>         return ret;
>  }
>
> +/**
> + * mount_image() - mount the image with blkmap
> + *
> + * @lo_label:  u16 label string of load option
> + * @addr:      image address
> + * @size:      image size
> + * Return:     pointer to the UCLASS_BLK udevice, NULL if failed
> + */
> +static struct udevice *mount_image(u16 *lo_label, ulong addr, int size)
> +{
> +       int err;
> +       struct blkmap *bm;
> +       struct udevice *bm_dev;
> +       char *label = NULL, *p;
> +
> +       label = efi_alloc(utf16_utf8_strlen(lo_label) + 1);
> +       if (!label)
> +               return NULL;
> +
> +       p = label;
> +       utf16_utf8_strcpy(&p, lo_label);
> +       err = blkmap_create_ramdisk(label, addr, size, &bm_dev);
> +       if (err) {
> +               efi_free_pool(label);
> +               return NULL;
> +       }
> +       bm = dev_get_plat(bm_dev);
> +
> +       efi_free_pool(label);
> +
> +       return bm->blk;
> +}
> +
> +/**
> + * try_load_default_file() - try to load the default file
> + *
> + * Search the device having EFI_SIMPLE_FILE_SYSTEM_PROTOCOL,
> + * then try to load with the default boot file(e.g. EFI/BOOT/BOOTAA64.EFI).
> + *
> + * @dev                        pointer to the UCLASS_BLK or UCLASS_PARTITION udevice
> + * @image_handle:      pointer to handle for newly installed image
> + * Return:             status code
> + */
> +static efi_status_t try_load_default_file(struct udevice *dev,
> +                                         efi_handle_t *image_handle)
> +{
> +       efi_status_t ret;
> +       efi_handle_t handle;
> +       struct efi_handler *handler;
> +       struct efi_device_path *file_path;
> +       struct efi_device_path *device_path;
> +
> +       if (dev_tag_get_ptr(dev, DM_TAG_EFI, (void **)&handle)) {
> +               log_warning("DM_TAG_EFI not found\n");
> +               return EFI_INVALID_PARAMETER;
> +       }
> +
> +       ret = efi_search_protocol(handle,
> +                                 &efi_simple_file_system_protocol_guid, &handler);
> +       if (ret != EFI_SUCCESS)
> +               return ret;

nit; but do we really need this check? Or is it just to fail early
before efi_load_image() gets called?

> +
> +       ret = EFI_CALL(bs->open_protocol(handle, &efi_guid_device_path,
> +                                        (void **)&device_path, efi_root, NULL,
> +                                        EFI_OPEN_PROTOCOL_GET_PROTOCOL));
> +       if (ret != EFI_SUCCESS)
> +               return ret;
> +
> +       file_path = expand_media_path(device_path);
> +       ret = EFI_CALL(efi_load_image(true, efi_root, file_path, NULL, 0,
> +                                     image_handle));
> +       efi_free_pool(file_path);
> +
> +       return ret;
> +}
> +
> +/**
> + * load_default_file_from_blk_dev() - load the default file
> + *
> + * @blk                pointer to the UCLASS_BLK udevice
> + * @handle:    pointer to handle for newly installed image
> + * Return:     status code
> + */
> +static efi_status_t load_default_file_from_blk_dev(struct udevice *blk,
> +                                                  efi_handle_t *handle)
> +{
> +       efi_status_t ret;
> +       struct udevice *partition;
> +
> +       /* image that has no partition table but a file system */
> +       ret = try_load_default_file(blk, handle);
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
> +               ret = try_load_default_file(partition, handle);
> +               if (ret == EFI_SUCCESS)
> +                       return ret;
> +       }
> +
> +       return EFI_NOT_FOUND;
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
> +               struct udevice *blk;
> +
> +               blk = mount_image(lo_label, image_addr, image_size);
> +               if (!blk)
> +                       return EFI_LOAD_ERROR;
> +
> +               ret = load_default_file_from_blk_dev(blk, handle);
> +               if (ret != EFI_SUCCESS)
> +                       return ret;
> +
> +               ramdisk_blk_dev = blk;
> +
> +               /*
> +                * TODO: expose the ramdisk to OS.
> +                * Need to pass the ramdisk information by the architecture-specific
> +                * methods such as 'pmem' device-tree node.
> +                */
> +               ret = efi_add_memory_map(image_addr, image_size,
> +                                        EFI_RESERVED_MEMORY_TYPE);
> +               if (ret != EFI_SUCCESS)
> +                       efi_bootmgr_release_ramdisk();
> +       } else if (efi_check_pe((void *)image_addr, image_size, NULL) == EFI_SUCCESS) {
> +               efi_handle_t mem_handle = NULL;
> +               struct efi_device_path *file_path;
> +
> +               file_path = efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE,
> +                                           (uintptr_t)image_addr, image_size);
> +               ret = efi_install_multiple_protocol_interfaces(
> +                       &mem_handle, &efi_guid_device_path, file_path, NULL);
> +               if (ret != EFI_SUCCESS)
> +                       return ret;
> +
> +               ret = EFI_CALL(efi_load_image(false, efi_root, file_path,
> +                                             (void *)image_addr, image_size,
> +                                             handle));
> +       } else {
> +               log_err("Error: file type is not supported\n");
> +               return EFI_UNSUPPORTED;
> +       }
> +
> +       return ret;
> +}
> +
>  /**
>   * try_load_entry() - try to load image for boot option
>   *
> @@ -211,6 +410,14 @@ static efi_status_t try_load_entry(u16 n, efi_handle_t *handle,
>                 if (EFI_DP_TYPE(lo.file_path, MEDIA_DEVICE, FILE_PATH)) {
>                         /* file_path doesn't contain a device path */
>                         ret = try_load_from_short_path(lo.file_path, handle);
> +               } else if (EFI_DP_TYPE(lo.file_path, MESSAGING_DEVICE, MSG_URI)) {
> +                       if (IS_ENABLED(CONFIG_EFI_HTTP_BOOT))
> +                               ret = try_load_from_uri_path(
> +                                       (struct efi_device_path_uri *)
> +                                               lo.file_path,
> +                                       lo.label, handle);
> +                       else
> +                               ret = EFI_LOAD_ERROR;
>                 } else {
>                         file_path = expand_media_path(lo.file_path);
>                         ret = EFI_CALL(efi_load_image(true, efi_root, file_path,
> @@ -345,6 +552,28 @@ error:
>         return ret;
>  }
>
> +/**
> + * efi_bootmgr_release_ramdisk() - release ramdisk resource
> + *
> + * Return:             status code
> + */
> +efi_status_t efi_bootmgr_release_ramdisk(void)
> +{
> +       efi_status_t ret = EFI_SUCCESS;
> +
> +       if (ramdisk_blk_dev) {
> +               ret = efi_add_memory_map(image_addr, image_size,
> +                                        EFI_CONVENTIONAL_MEMORY);
> +
> +               if (blkmap_destroy(ramdisk_blk_dev->parent))
> +                       ret = EFI_DEVICE_ERROR;

This seems a bit weird.  We are changing the return error value on
multiple errors.
The efi_add_memory_map() shouldn't fail, unless something *really* bad
has happened.
Can we check for the return code in this and print an appropriate error?

This function also has 2 callers, one of them isn't checking the
return value.  Again at least print a message so users are aware that
some memory cant be reclaimed

Thanks
/Ilias

> +
> +               ramdisk_blk_dev = NULL;
> +       }
> +
> +       return ret;
> +}
> +
>  /**
>   * efi_bootmgr_enumerate_boot_option() - enumerate the possible bootable media
>   *
> --
> 2.34.1
>
