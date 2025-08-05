Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57363C87FCB
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 08:26:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1292184171;
	Tue,  5 Aug 2025 10:26:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NTjB/ZBo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75AC784177; Tue,  5 Aug 2025 10:26:02 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE5188416E
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 10:25:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-71b6ab52e8cso41575607b3.0
 for <u-boot@lists.denx.de>; Tue, 05 Aug 2025 01:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754382359; x=1754987159; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+JojN+pnkOJ0RRgqhS3ygyV5aS+IgzDQIXHNTtrZTNk=;
 b=NTjB/ZBoHGsCKQlBhBU9Nl1fYCdheLAFAPpHY3NsWtkxtmPQdB9TX4ij5DsxpDbgvA
 D7fIRahOAEzau/8h1xxsKdNBxm3qJH+aMo+Rc8BSC/FNyEGquV9klSsib7lmdp7YJgBj
 fMi8AK5qECPhLxEalX+WD2Zeoo5BIL+Qyf0wBmLh0cIjvJ4plXJ5cwcplZZ8h+zECSgm
 m8V99eTqvOLkeT81EdvJF30YBRlJd+TfkkXsGkjXgZg33wQbkC1eJUiNEKnNz5nD5KDa
 gru6nOT+NtCzqfoBaz3R9yvo8fOYgKAp/po2LYojVN62TpDzW6P/XqY9CvKFscOvPl9Y
 e9CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754382359; x=1754987159;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+JojN+pnkOJ0RRgqhS3ygyV5aS+IgzDQIXHNTtrZTNk=;
 b=FINqlwNRrabE+ryIoNItPdvvZp9xXVtoA7K5cFb5HdjrlItWWqg3UTFY8Sk/PISE59
 aQ8U0WIPBPxnWGlvbTB5uJTy//3YaFc45+fGqTbYNjpmxo/x9FoY8N43sd/NNrURVoll
 hC7cLvaGsXzoxPmCTpx6eciLxqwKkr+cyXBPzpj7NVPm2FBENP33U5K1Q5lF7Z3Pfjhx
 zrZU9cOVDBRk83z3VxifJ7ct2jD/+l7awNcHxXzADjjQUt+uX5/SLwoGHtgZ4HSaA78Z
 YvowRy1VB4H/krQ91COTd4vzXiKNxFKypNqFq5DUXXyeIUsCw39FTg3L6l2PAA2OSE1a
 JV8g==
X-Gm-Message-State: AOJu0Yz9Tp/piNqXv6ziFltjaR80IWJohoQsIATwxSZUU2jsNNxBJIRe
 dtBI+GIhOipyBQNuPh7SwAooOZDTffypzW9i0oYfgdWH2CbGTqYrGLnq+/s24e2KAVOpdUWJFyQ
 hOeHBpG4k7cH6UrQoCeMkezYSEwWO8uiasAK/YKQTYQ==
X-Gm-Gg: ASbGncsSbo4fbgIeRheaBqMa1T4hA5m3oEOiCedYmkTOwx5cDZhL04YGMHKRwvqb06f
 3t9gF1GF7TxKn4PupeE+7vlmggDl6ajnW4V13ks+zaS766Mbyf3bDSBJdCkTvcJAMbmdWXlcUZe
 2lg3zsSJ1hpu05z+27J9X3EDAxsqXHAMXUB+hJZQqi0ibRC6xmHpLZ6XVbLwQDbQYu/h9AR7qj5
 WhkS4b2
X-Google-Smtp-Source: AGHT+IEjVA8movU7R1JUFrQIvDgSIqkNe/H8pCByNr4nOXYdbct35tI5gFLGDzAIIfSG4V6xjX4BoakMr5F9462iDTE=
X-Received: by 2002:a05:690c:9d:b0:719:b6a8:de30 with SMTP id
 00721157ae682-71b7ed170b1mr138145997b3.4.1754382358606; Tue, 05 Aug 2025
 01:25:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250731213547.654823-1-javier.tia@linaro.org>
In-Reply-To: <20250731213547.654823-1-javier.tia@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 5 Aug 2025 11:25:22 +0300
X-Gm-Features: Ac12FXxEiV5ho_5cKq1jARfWebq8EI2Ob32bDCnhndV34HH8WB_akcID0JSlqxE
Message-ID: <CAC_iWj+YzzLnw5eHQaVQaS6+rAo2YjhARQDzYspwW2VtjvXWrQ@mail.gmail.com>
Subject: Re: [PATCH] disk: Use part_driver_lookup_type() to valid downloaded
 image
To: Javier Tia <javier.tia@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

Hi Javier

On Fri, 1 Aug 2025 at 00:35, Javier Tia <javier.tia@linaro.org> wrote:
>
> The part_driver_lookup_type() function was made public to be used in the
> EFI loader. This function is used to look up the partition type for a
> block device.
>
> This change allows the EFI loader to detect disk images by using the
> partition driver lookup. This replaces the previous method of checking
> the file extension, which was less optimal.
>
> The EFI loader generates a temporary block device from the downloaded
> image, employs the part_driver_lookup_type() function to verify the
> partition type, and checks if it corresponds to a valid ISO 9660, DOS
> MBR, or GPT EFI disk image, subsequently performing cleanup of the
> temporary device. If the downloaded file does not constitute a valid
> disk image, an error message will be logged, and the function will
> return EFI_UNSUPPORTED.
>
> Signed-off-by: Javier Tia <javier.tia@linaro.org>
> ---
>  disk/part.c                  |  3 +-
>  include/part.h               | 18 +++++++++
>  lib/efi_loader/efi_bootmgr.c | 76 +++++++++++++++++++++++++++++++-----
>  3 files changed, 87 insertions(+), 10 deletions(-)
>
> diff --git a/disk/part.c b/disk/part.c
> index 66e2b3a7219..adc24976624 100644
> --- a/disk/part.c
> +++ b/disk/part.c
> @@ -63,7 +63,7 @@ static struct part_driver *part_driver_get_type(int part_type)
>   * @dev_desc: Device descriptor
>   * Return: Driver found, or NULL if none
>   */
> -static struct part_driver *part_driver_lookup_type(struct blk_desc *desc)
> +struct part_driver *part_driver_lookup_type(struct blk_desc *desc)
>  {
>         struct part_driver *drv =
>                 ll_entry_start(struct part_driver, part_driver);
> @@ -855,3 +855,4 @@ int part_get_bootable(struct blk_desc *desc)
>
>         return 0;
>  }
> +
> diff --git a/include/part.h b/include/part.h
> index b772fb34c8a..3fc3186f4c4 100644
> --- a/include/part.h
> +++ b/include/part.h
> @@ -727,6 +727,24 @@ int part_get_type_by_name(const char *name);
>   */
>  int part_get_bootable(struct blk_desc *desc);
>
> +/**
> + * part_driver_lookup_type() - Look up the partition driver for a blk device
> + *
> + * If @desc->part_type is PART_TYPE_UNKNOWN, this checks each partition driver
> + * against the blk device to see if there is a valid partition table acceptable
> + * to that driver.
> + *
> + * If @desc->part_type is already set, it just returns the driver for that
> + * type, without testing if the driver can find a valid partition on the
> + * descriptor.
> + *
> + * On success it updates @desc->part_type if set to PART_TYPE_UNKNOWN on entry
> + *
> + * @desc: Device descriptor
> + * Return: Driver found, or NULL if none
> + */
> +struct part_driver *part_driver_lookup_type(struct blk_desc *desc);
> +
>  #else
>  static inline int part_driver_get_count(void)
>  { return 0; }
> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> index 662993fb809..f6729a40462 100644
> --- a/lib/efi_loader/efi_bootmgr.c
> +++ b/lib/efi_loader/efi_bootmgr.c
> @@ -17,6 +17,7 @@
>  #include <log.h>
>  #include <malloc.h>
>  #include <net.h>
> +#include <part.h>
>  #include <efi_loader.h>
>  #include <efi_variable.h>
>  #include <asm/unaligned.h>
> @@ -407,7 +408,7 @@ static efi_status_t efi_bootmgr_release_uridp(struct uridp_context *ctx)
>         if (!ctx)
>                 return ret;
>
> -       /* cleanup for iso or img image */
> +       /* cleanup for disk image */
>         if (ctx->ramdisk_blk_dev) {
>                 ret = efi_add_memory_map(ctx->image_addr, ctx->image_size,
>                                          EFI_CONVENTIONAL_MEMORY);
> @@ -452,6 +453,17 @@ static void EFIAPI efi_bootmgr_http_return(struct efi_event *event,
>         EFI_EXIT(ret);
>  }
>
> +/**
> + * cleanup_temp_blkdev() - Clean up temporary block device
> + *
> + * @temp_bdev: temporary block device to clean up
> + */
> +static void cleanup_temp_blkdev(struct udevice *temp_bdev)
> +{
> +       if (blkmap_destroy(temp_bdev->parent))
> +               log_err("Destroying temporary blkmap failed\n");
> +}

No need to add a new function for a call, just call blkmap_destroy() directly.
If you want to keep it as a separate function, just move the if
(temp_bdev) in here.

> +
>  /**
>   * try_load_from_uri_path() - Handle the URI device path
>   *
> @@ -466,7 +478,6 @@ static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
>  {
>         char *s;
>         int err;
> -       int uri_len;
>         efi_status_t ret;
>         void *source_buffer;
>         efi_uintn_t source_size;
> @@ -516,13 +527,55 @@ static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
>         image_size = ALIGN(image_size, SZ_2M);
>
>         /*
> -        * If the file extension is ".iso" or ".img", mount it and try to load
> -        * the default file.
> -        * If the file is PE-COFF image, load the downloaded file.
> +        * Check if the downloaded file is a disk image or PE-COFF image.
> +        * Use partition driver lookup for disk image detection.
>          */
> -       uri_len = strlen(uridp->uri);
> -       if (!strncmp(&uridp->uri[uri_len - 4], ".iso", 4) ||
> -           !strncmp(&uridp->uri[uri_len - 4], ".img", 4)) {
> +       struct udevice *temp_bdev;
> +       struct part_driver *part_drv = NULL;
> +
> +       /* Create temporary block device from the downloaded image for testing */
> +       temp_bdev = mount_image(lo_label, image_addr, image_size);
> +       if (!temp_bdev) {
> +               log_debug("mount_image() failed, will attempt PE-COFF detection\n");
> +       }

It's a single line in the if, drop the {}

> +       if (temp_bdev) {
> +               struct blk_desc *desc = dev_get_uclass_plat(temp_bdev);
> +               if (!desc) {
> +                       /* Clean up temporary device when dev_get_uclass_plat() returns NULL */
> +                       cleanup_temp_blkdev(temp_bdev);
> +               } else {
> +                       /* Use part_driver_lookup_type for comprehensive partition detection */
> +                       part_drv = part_driver_lookup_type(desc);
> +
> +                       /* Validate partition type */
> +                       if (part_drv) {
> +                               if (part_drv->part_type != PART_TYPE_DOS &&
> +                                   part_drv->part_type != PART_TYPE_ISO &&
> +                                   part_drv->part_type != PART_TYPE_EFI) {

Why does it have to be one of those partition types? The EFI spec does
not require the ESP to be a FAT.

> +                                       log_err("Unsupported partition type 0x%02x for EFI boot. "
> +                                                       "Only MBR DOS, ISO, and EFI partition types are supported.\n",
> +                                                       part_drv->part_type);
> +
> +                                       /* Clean up temporary device */
> +                                       cleanup_temp_blkdev(temp_bdev);
> +
> +                                       /* Set part_drv to NULL to fall through to PE-COFF detection */
> +                                       part_drv = NULL;
> +                               }
> +                       }
> +
> +                       /*
> +                        * If it's a disk image with supported partition type,
> +                        * prepare_loaded_image will create the final block device
> +                        */
> +                       if (part_drv) {
> +                               /* Clean up temporary device, prepare_loaded_image will create a new one */
> +                               cleanup_temp_blkdev(temp_bdev);
> +                       }
> +               }
> +       }
> +
> +       if (part_drv) {
>                 ret = prepare_loaded_image(lo_label, image_addr, image_size,
>                                            &loaded_dp, &blk);
>                 if (ret != EFI_SUCCESS)
> @@ -545,7 +598,12 @@ static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
>                 source_buffer = (void *)image_addr;
>                 source_size = image_size;
>         } else {
> -               log_err("Error: file type is not supported\n");
> +               /* Clean up temporary device if it was created but not a valid disk image */
> +               if (temp_bdev) {
> +                       cleanup_temp_blkdev(temp_bdev);
> +               }
> +
> +               log_err("Error: disk image is not supported\n");
>                 ret = EFI_UNSUPPORTED;
>                 goto err;
>         }
> --
> 2.50.1
>

Thanks
/Ilias
