Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 731F0CAC5BB
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 13:26:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00585839B9;
	Wed,  8 Oct 2025 15:26:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FzPmWZcp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74AC883D77; Wed,  8 Oct 2025 15:26:35 +0200 (CEST)
Received: from mail-yx1-xb134.google.com (mail-yx1-xb134.google.com
 [IPv6:2607:f8b0:4864:20::b134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FF8D8394A
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 15:26:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-6353f2937f3so9038066d50.3
 for <u-boot@lists.denx.de>; Wed, 08 Oct 2025 06:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759929992; x=1760534792; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QqWAcRkU9pCp0PNSYTE5u3zd7Z1nQla1RTaNsamaJec=;
 b=FzPmWZcpWYTSadn6VDe11b/Gb75y0jlTJiqlXQmBBa5JWdEIG7ELKloP2z/H9gcOfk
 UkmoNdvpD2eOGr5gOF6YiwFvUAIjk4a/cyydiPly3FHOKHQEgD4Fo4S6Ib/FdWpJwEU5
 aE9pIdK2N8bUr3UDu1vq1YCuTVyc9Z6xpV4PFkTQ3LLIe7GLYGj3NwJV+Rgf8N9i/LIC
 Ld+iBEIqZGaDkzV5K3Xol59sxPvHfJ6DErf55yRQLC/iyqF5DI9IvBq9H22JjcNV/vcF
 cmzdvj/f2fkylx9arwgKKmsSRwQPBZzDbthsrbuib5rpIrHikrXivESqejQWuqM3xSqa
 WKvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759929992; x=1760534792;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QqWAcRkU9pCp0PNSYTE5u3zd7Z1nQla1RTaNsamaJec=;
 b=nBHf5iCjqje8xgdUBygXTxwClupBWudam8D6CZS074hNaZvtEoBkr/M3D1UbOIAta4
 fu9mMYe/w8CyWB+NsCOCkmLhUWAP7H7TQG6FkWczkjoxt+UUutPbo+ZCjxhyd6WDFJsQ
 +nGSmZUFsoY0TmyxGUJsvgCdfnzHJZxVBI4G5V+SNSwoDCwyMS5gNuoX1P/tg0LzL3E/
 RVHT9+ojtSXG9a7P92u60U3pxzGLsCHj/OcVH+xbBucMugcsGoipSBPKYoEhd/5tpHju
 3Tc1zHpTYhGIJRfO1p7c9FTifkWUnNEc1v0l6KaVqRhgSSfWDIZgbLnvsD+SZTXjTWqp
 CSow==
X-Gm-Message-State: AOJu0YwJMGW45jyrDASXIb1uk91+JJczwyB3oDjPFVhDCSsyMIAIFiUY
 9bptiFRl4LGwLL4DpeIoIoVPtf/Qdv7sKRPDV/pTibAGlhiQW9upu7v42iIub+gODK+8wwaduN5
 peES/haiX+8HsYfJ/JaiPShS2IFlhRtAyHQpgQoaDdA==
X-Gm-Gg: ASbGncsrUOwLl3lRP1AKtLFjC86mqOEK+Dhj8XBFgO3LNuqLYaLaqbFsEfb8Xi6nM6g
 Cle3fOjsiNnJrkFY22Kyzw1s8UwSjQF+lfer1ryzUMeE/CjdIKtEH6OOnf86Dn8MskwKevFerSA
 AIwzzIclrLUqpiph6GJi7yyuLUp2Lkv98gbBdT9xkV2T8fUkQX+TbWKvF20xcmY6HD5dr+4vTln
 EIg1z7p3XeqBvDCmEoIBS+oWXA9D9kJuq2F1B1wo5IjxBXMR7L1ETXK
X-Google-Smtp-Source: AGHT+IHAI6tCrv1pYDx9PuQvE9mh1kxkgBECdqwU7n29q0ek9lSJzzB6tqlw9s2yrIOyw6zO2PGN/OaF0T4Hg/UQYME=
X-Received: by 2002:a53:d048:0:10b0:5f4:3486:edb3 with SMTP id
 956f58d0204a3-63ccb68e4e5mr3455199d50.0.1759929991912; Wed, 08 Oct 2025
 06:26:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250925224838.567562-1-javier.tia@linaro.org>
 <20250925224838.567562-3-javier.tia@linaro.org>
In-Reply-To: <20250925224838.567562-3-javier.tia@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 8 Oct 2025 16:25:55 +0300
X-Gm-Features: AS18NWCXfRUIq7D48BZUzDn_teIVCAA2BeH_NBHy6MThpR-2DPFkkSA-yHN9JJs
Message-ID: <CAC_iWjKPQEb2vL6=N7HJO0wRTBPMsiqrzXtbwKr9z8LzQfFDxw@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] efi_loader: Improve disk image detection in
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

On Fri, 26 Sept 2025 at 01:48, Javier Tia <javier.tia@linaro.org> wrote:
>
> Enhances the process for identifying disk images within the EFI boot
> manager. Utilize part_driver_lookup_type() to verify the validity of a
> downloaded file as a disk image, rather than depending on file
> extensions.
>
> part_driver_lookup_type() is now used in the prepare_loaded_image()
> function in the EFI boot manager to detect partitions on a block device
> created from a downloaded image. This allows the boot manager to boot
> from any disk image that can be recognized by a partition driver, not
> just ISO and IMG images.
>
> Update prepare_loaded_image() to create the ramdisk block device
> internally, obtain the blk_desc and use part_driver_lookup_type() to
> detect a valid partition table.
>
> In try_load_from_uri_path(), try prepare_loaded_image() first to detect
> disk images, and fall back to PE-COFF detection only if that fails.
>
> Signed-off-by: Javier Tia <javier.tia@linaro.org>
> ---
>  include/part.h               |  6 ++---
>  lib/efi_loader/efi_bootmgr.c | 51 +++++++++++++++++++++++++-----------
>  2 files changed, 39 insertions(+), 18 deletions(-)
>
> diff --git a/include/part.h b/include/part.h
> index 52fd3d534e0..715900a7ac7 100644
> --- a/include/part.h
> +++ b/include/part.h
> @@ -471,9 +471,6 @@ ulong disk_blk_erase(struct udevice *dev, lbaint_t start, lbaint_t blkcnt);
>  #define part_get_info_ptr(x)   x
>  #endif
>
> -static inline struct part_driver *part_driver_lookup_type(struct blk_desc *desc)
> -{ return NULL; }

This was added in the previous patch. Why is this patch deleting it
and re-adding it?
All the pre-requisites should be part of patch #1

Regards
/Ilias
> -
>  /**
>   * struct part_driver - partition driver
>   */
> @@ -752,6 +749,9 @@ struct part_driver *part_driver_lookup_type(struct blk_desc *desc);
>  static inline int part_driver_get_count(void)
>  { return 0; }
>
> +static inline struct part_driver *part_driver_lookup_type(struct blk_desc *desc)
> +{ return NULL; }
> +
>  static inline struct part_driver *part_driver_get_first(void)
>  { return NULL; }
>
> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> index 662993fb809..9ae11d4ebf0 100644
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
> @@ -347,6 +348,9 @@ static efi_status_t fill_default_file_path(struct udevice *blk,
>   * @dp:                pointer to default file device path
>   * @blk:       pointer to created blk udevice
>   * Return:     status code
> + *
> + * This function handles device creation internally and performs cleanup
> + * on error paths.
>   */
>  static efi_status_t prepare_loaded_image(u16 *label, ulong addr, ulong size,
>                                          struct efi_device_path **dp,
> @@ -355,10 +359,31 @@ static efi_status_t prepare_loaded_image(u16 *label, ulong addr, ulong size,
>         u64 pages;
>         efi_status_t ret;
>         struct udevice *ramdisk_blk;
> +       struct blk_desc *desc;
> +       struct part_driver *part_drv;
>
> +       /* Create the ramdisk block device internally */
>         ramdisk_blk = mount_image(label, addr, size);
> -       if (!ramdisk_blk)
> -               return EFI_LOAD_ERROR;
> +       if (!ramdisk_blk) {
> +               log_err("Failed to create ramdisk block device\n");
> +               return EFI_DEVICE_ERROR;
> +       }
> +
> +       /* Get the block descriptor and detect partitions */
> +       desc = dev_get_uclass_plat(ramdisk_blk);
> +       if (!desc) {
> +               log_err("Failed to get block descriptor\n");
> +               ret = EFI_DEVICE_ERROR;
> +               goto err;
> +       }
> +
> +       /* Use part_driver_lookup_type for comprehensive partition detection */
> +       part_drv = part_driver_lookup_type(desc);
> +       if (!part_drv) {
> +               log_err("Image is not a valid disk image\n");
> +               ret = EFI_INVALID_PARAMETER;
> +               goto err;
> +       }
>
>         ret = fill_default_file_path(ramdisk_blk, dp);
>         if (ret != EFI_SUCCESS) {
> @@ -389,7 +414,6 @@ static efi_status_t prepare_loaded_image(u16 *label, ulong addr, ulong size,
>  err:
>         if (blkmap_destroy(ramdisk_blk->parent))
>                 log_err("Destroying blkmap failed\n");
> -
>         return ret;
>  }
>
> @@ -407,7 +431,7 @@ static efi_status_t efi_bootmgr_release_uridp(struct uridp_context *ctx)
>         if (!ctx)
>                 return ret;
>
> -       /* cleanup for iso or img image */
> +       /* cleanup for disk image */
>         if (ctx->ramdisk_blk_dev) {
>                 ret = efi_add_memory_map(ctx->image_addr, ctx->image_size,
>                                          EFI_CONVENTIONAL_MEMORY);
> @@ -452,6 +476,7 @@ static void EFIAPI efi_bootmgr_http_return(struct efi_event *event,
>         EFI_EXIT(ret);
>  }
>
> +
>  /**
>   * try_load_from_uri_path() - Handle the URI device path
>   *
> @@ -466,7 +491,6 @@ static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
>  {
>         char *s;
>         int err;
> -       int uri_len;
>         efi_status_t ret;
>         void *source_buffer;
>         efi_uintn_t source_size;
> @@ -516,18 +540,15 @@ static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
>         image_size = ALIGN(image_size, SZ_2M);
>
>         /*
> -        * If the file extension is ".iso" or ".img", mount it and try to load
> -        * the default file.
> -        * If the file is PE-COFF image, load the downloaded file.
> +        * Check if the downloaded file is a disk image or PE-COFF image.
> +        * Try disk image detection first using prepare_loaded_image().
>          */
> -       uri_len = strlen(uridp->uri);
> -       if (!strncmp(&uridp->uri[uri_len - 4], ".iso", 4) ||
> -           !strncmp(&uridp->uri[uri_len - 4], ".img", 4)) {
> -               ret = prepare_loaded_image(lo_label, image_addr, image_size,
> -                                          &loaded_dp, &blk);
> -               if (ret != EFI_SUCCESS)
> -                       goto err;
>
> +       /* First, try to treat the image as a disk image */
> +       ret = prepare_loaded_image(lo_label, image_addr, image_size,
> +                                  &loaded_dp, &blk);
> +       if (ret == EFI_SUCCESS) {
> +               /* Image is a disk image, set up for disk boot */
>                 source_buffer = NULL;
>                 source_size = 0;
>         } else if (efi_check_pe((void *)image_addr, image_size, NULL) == EFI_SUCCESS) {
> --
> 2.51.0
>
