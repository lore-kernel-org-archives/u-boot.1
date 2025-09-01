Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43949CA0FF0
	for <u-boot@archiver.kernel.org>; Mon,  1 Sep 2025 10:09:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F64083977;
	Mon,  1 Sep 2025 12:09:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GCPXZag8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6E918399C; Mon,  1 Sep 2025 12:09:55 +0200 (CEST)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E52E83965
 for <u-boot@lists.denx.de>; Mon,  1 Sep 2025 12:09:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e96c48e7101so3531024276.2
 for <u-boot@lists.denx.de>; Mon, 01 Sep 2025 03:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756721391; x=1757326191; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=G0nBiEqPSyMl8vjcRFNY6CvakG5WAx7WruVLYi+rVPI=;
 b=GCPXZag8BqN4hGeZ4VdeyFj/fYZyAhTgK+aiTFjnvqjLGa1x0iztE5WeM0AhotTB7f
 mc2eJTo5rZwLjgPkDcbZt5G7OvXERPHyGekoyRfxFmKQmZQmTagAaQhjJ99H5230MAvA
 8U6RLMHSZ5TbVcdqXgQYZBMKmCoB4/XalUC3JbgKLUezAHDdchrF5CVj/aG0yjXq5N+v
 B1TerhQvJmpKhvx7NKsXo2euEek8HIa0lRzzEHWVcDOXYUS9W+QOHSwe3ZrSJkRz+Doi
 hizPNBdXjimJoBsC59vlBKIMIpUgUbKUvW1fW7X6ZRlkxiOyZV6tm5YlA/kNTf9kvPMF
 jJQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756721391; x=1757326191;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G0nBiEqPSyMl8vjcRFNY6CvakG5WAx7WruVLYi+rVPI=;
 b=ifHvHdXUazdazHsJOG5v7oFrcpNi1+RHeS1YxMnBHSXg7U9QpL/24z60bNWPf9Yu3E
 Ir6uTt7hCC35vCJh9umg0xMe1/3HkS6C16bRjaRZ1dYp1JcO0DMsZNHspUltdaS3cNJ0
 5FHgJxmQo8RP66JpA5FIfImXmYHzktLuD3YlhgkNPL0A7VEBgRt51VmnYyQU+k3ASjAy
 8JwoYKmsIEVugVvY5ujAfZe69GLkHdt2N11s7tr4UFOALuRAAGLUuhWQjBrO31MGU0fz
 E/iU02HBztxSElGTq2NcaX+Rrry+KMYkohDiPcbip5ebSZHow50SJrn5meiuFbacAFZj
 15lg==
X-Gm-Message-State: AOJu0Yw4pxQsWG8kC+nvcqQHJIvTW0yT9FVBuyqa1lr+GLEcsQSl1h5r
 hgIce7vjxq596GYt9WRDesFBH/KLwnYuYEGxtta4QHKuzpDR2UdCYMdk3pFV/FIgWaUoVtoxN49
 /qZMHR3fEjTOMor37UsN8H0Dp8I4ENCEb7ZkqUn5wRg==
X-Gm-Gg: ASbGncvU+mDxMTqKCV1C8NQt+uXWAKWjcbYC/jpmpyl3MkcwJW7fAa6EOGie17lrO/U
 4AsLNkELnWeUmmNpIDIZCIUG6MHKjhfdzzJBDLtSAzquPiIaJHk1/+ZRCFJFLRItejz8xTIQoSL
 GEIKxn4XnRraif6ZX+gaa7BcIUDY17AyU7te7roBCZkX//VkXlHsm/E++sG3RI1YpwPSvQ7fetg
 L74HCQlZNby0R9iglpmoISf4DphbpDg2boznHoS6rPk+3pfH8wpTnTbypX2uwF3RY3OaVBrBWvT
 O97h6e+byFjYvIQZNrxtt+0E0urla7rZT7esVNAea/poaOMK1AYd4H8dk/YQcWTdKmrNV6lT
X-Google-Smtp-Source: AGHT+IGho2vUxKQICvot4RUPq1/Fe8/2owY5Z3p7I/i9577GSVnEhXE2rmEYtbZn5M9++g2CLKKXvi9NHkxuOiXc0z0=
X-Received: by 2002:a05:690c:6d82:b0:721:64ec:bc58 with SMTP id
 00721157ae682-7227635cb87mr77648177b3.5.1756721391095; Mon, 01 Sep 2025
 03:09:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250829155415.90634-1-javier.tia@linaro.org>
In-Reply-To: <20250829155415.90634-1-javier.tia@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 1 Sep 2025 13:09:15 +0300
X-Gm-Features: Ac12FXwFHFyVVNbL9b9rVWB6qBB92XBTaJ6jvGmf7WY4kMiY5rfTufQiNcPvd4A
Message-ID: <CAC_iWjLK0Zhg2v0re=Y_ryJ4DXDw7xednwYs=iLR2SYQMEb2Ug@mail.gmail.com>
Subject: Re: [PATCH v3] disk: efi_loader: Improve disk image detection in
 efi_bootmgr
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

Hi Javier,

On Fri, 29 Aug 2025 at 18:54, Javier Tia <javier.tia@linaro.org> wrote:
>
> Enhances the process for identifying disk images within the EFI boot
> manager. Utilize part_driver_lookup_type() to verify the validity of a
> downloaded file as a disk image, rather than depending on file
> extensions.
>
> A temporary block device is created from the downloaded image and
> part_driver_lookup_type() is used for comprehensive partition detection.
> If a partition driver is found, the temporary device is reused instead
> of being destroyed and recreated.
>
> Signed-off-by: Javier Tia <javier.tia@linaro.org>
>
> ---
> Changelog:
> - v3 changes:
>   Update prepare_loaded_image() to require a non-null blk_dev parameter,
>   eliminating the conditional branching logic and replacing it with
>   direct assignment. In try_load_from_uri_path(), variable declarations
>   were moved to follow U-Boot Coding convention, redundant cleanup calls
>   were consolidated into a single location, and control flow was
>   improved by replacing empty conditional blocks with logical else
>   clauses for debug logging.
> - v2 link: https://lore.kernel.org/u-boot/20250808213627.649669-1-javier.tia@linaro.org/
> - v1 link: https://lore.kernel.org/u-boot/20250805162158.117876-1-javier.tia@linaro.org/
>
> ---
>  disk/part.c                  |  2 +-
>  include/part.h               | 18 +++++++++
>  lib/efi_loader/efi_bootmgr.c | 78 +++++++++++++++++++++++++++---------
>  3 files changed, 79 insertions(+), 19 deletions(-)
>
> diff --git a/disk/part.c b/disk/part.c
> index 66e2b3a7219..f0c6866e210 100644
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
> index 662993fb809..60e8804b1da 100644
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
> @@ -346,19 +347,26 @@ static efi_status_t fill_default_file_path(struct udevice *blk,
>   * @size:      image size
>   * @dp:                pointer to default file device path
>   * @blk:       pointer to created blk udevice
> + * @blk_dev:   existing block device to use (must be non-NULL)
>   * Return:     status code
> + *
> + * Caller must pass a valid non-NULL blk_dev; cleanup of temporary devices
> + * is caller's responsibility.
>   */
>  static efi_status_t prepare_loaded_image(u16 *label, ulong addr, ulong size,
>                                          struct efi_device_path **dp,
> -                                        struct udevice **blk)
> +                                        struct udevice **blk,
> +                                        struct udevice *blk_dev)
>  {
>         u64 pages;
>         efi_status_t ret;
>         struct udevice *ramdisk_blk;
>
> -       ramdisk_blk = mount_image(label, addr, size);

So, why can't we keep the mount_imagte() here now?

> -       if (!ramdisk_blk)
> -               return EFI_LOAD_ERROR;
> +       if (!blk_dev)
> +               return EFI_INVALID_PARAMETER;
> +
> +       /* Use the provided block device */
> +       ramdisk_blk = blk_dev;
>
>         ret = fill_default_file_path(ramdisk_blk, dp);
>         if (ret != EFI_SUCCESS) {
> @@ -387,9 +395,7 @@ static efi_status_t prepare_loaded_image(u16 *label, ulong addr, ulong size,
>         return EFI_SUCCESS;
>
>  err:
> -       if (blkmap_destroy(ramdisk_blk->parent))
> -               log_err("Destroying blkmap failed\n");
> -
> +       /* Cleanup is now the caller's responsibility */

This is an error I think we are fine cleaning up here

>         return ret;
>  }
>
> @@ -407,7 +413,7 @@ static efi_status_t efi_bootmgr_release_uridp(struct uridp_context *ctx)
>         if (!ctx)
>                 return ret;
>
> -       /* cleanup for iso or img image */
> +       /* cleanup for disk image */
>         if (ctx->ramdisk_blk_dev) {
>                 ret = efi_add_memory_map(ctx->image_addr, ctx->image_size,
>                                          EFI_CONVENTIONAL_MEMORY);
> @@ -452,6 +458,20 @@ static void EFIAPI efi_bootmgr_http_return(struct efi_event *event,
>         EFI_EXIT(ret);
>  }
>

[...]

>   *
> @@ -466,7 +486,6 @@ static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
>  {
>         char *s;
>         int err;
> -       int uri_len;
>         efi_status_t ret;
>         void *source_buffer;
>         efi_uintn_t source_size;
> @@ -476,6 +495,8 @@ static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
>         efi_handle_t mem_handle = NULL;
>         struct efi_device_path *loaded_dp;
>         static ulong image_size, image_addr;
> +       struct udevice *temp_bdev;
> +       struct part_driver *part_drv = NULL;
>
>         ctx = calloc(1, sizeof(struct uridp_context));
>         if (!ctx)
> @@ -516,17 +537,34 @@ static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
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
> +
> +       /* Create temporary block device from the downloaded image for testing */
> +       temp_bdev = mount_image(lo_label, image_addr, image_size);
> +       if (temp_bdev) {
> +               struct blk_desc *desc = dev_get_uclass_plat(temp_bdev);
> +               if (!desc) {
> +                       cleanup_temp_blkdev(temp_bdev);
> +                       temp_bdev = NULL; // prevent double cleanup later
> +               } else {
> +                       /* Use part_driver_lookup_type for comprehensive partition detection */
> +                       part_drv = part_driver_lookup_type(desc);

Can't we fold this into the prepare_image call?

then the code below becomes

ret = prepare_loaded_image(....);
if (ret == EFI_SUCCESS) {
       struct blk_desc *desc = dev_get_uclass_plat(temp_bdev);
       part_drv = part_driver_lookup_type(desc);
}

etc etc

> +
> +       if (part_drv) {
> +               /* Reuse the temporary device instead of destroying and recreating */
>                 ret = prepare_loaded_image(lo_label, image_addr, image_size,
> -                                          &loaded_dp, &blk);
> -               if (ret != EFI_SUCCESS)
> +                                          &loaded_dp, &blk, temp_bdev);
> +               if (ret != EFI_SUCCESS) {
> +                       cleanup_temp_blkdev(temp_bdev);
> +                       temp_bdev = NULL;
>                         goto err;
> +               }
>
>                 source_buffer = NULL;
>                 source_size = 0;
> @@ -545,11 +583,15 @@ static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
>                 source_buffer = (void *)image_addr;
>                 source_size = image_size;
>         } else {
> -               log_err("Error: file type is not supported\n");
> +               log_err("Error: disk image is not supported\n");
>                 ret = EFI_UNSUPPORTED;
>                 goto err;
>         }
>
> +       /* Clean up temporary device if it was created but not used for disk image */
> +       if (!part_drv)
> +               cleanup_temp_blkdev(temp_bdev);
> +
>         ctx->image_size = image_size;
>         ctx->image_addr = image_addr;
>         ctx->loaded_dp = loaded_dp;
> --
> 2.51.0
>

Thanks
/Ilias
