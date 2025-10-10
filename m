Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECD93CCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 11:20:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7312683FCF;
	Fri, 10 Oct 2025 13:20:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Y9WOsGVa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79CA183FC1; Fri, 10 Oct 2025 13:20:25 +0200 (CEST)
Received: from mail-yx1-xb12c.google.com (mail-yx1-xb12c.google.com
 [IPv6:2607:f8b0:4864:20::b12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C99483FC1
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 13:20:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-635c9db8a16so1924779d50.0
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 04:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760095222; x=1760700022; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ife7oOTgKrqjjZMBoXKZIwquaz07FoXhotbNtKTztaA=;
 b=Y9WOsGVai+BSIwp+qtHFU4AAfrYawDjO/xc39Iwy0hbwduFWU5CiAXM9hnEXf23OKu
 sNooh69l8Q0evrxBd4E+Py3PMZK2laSAaVdsB7FM3MSeei1X9Swl9+YcTGDfSw2DJWRE
 3mvMIYfVj0Tz9enw82ygqh2NCDDu1RCFVKFoiC3nq/AAC54DYcy9xKErZ7Z4vgGiD5JB
 bRrV1doETBBihV9zLtqRiJ52nlGs8oQ9Z2U9LBAj9orOUdYw6m0jXYWm1FwXNwyZdVSY
 XLGFsm0EV99cvnGGxH2mQvPokr5B0iGa10+V0Eq4FS+WxH9I6SeViQ6gFPQxLdRsOshD
 ZU+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760095222; x=1760700022;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ife7oOTgKrqjjZMBoXKZIwquaz07FoXhotbNtKTztaA=;
 b=jZuKPn97AcRp7SyvndvFj6lb/7lpDJQ/ufbWm+5zNOg6zqfCDrWXHrc+6uWVxxPZxu
 A41Qq7A1zNKxk2MLt/7hjm9H1bO3mU2el/01AA520gO4mw3/ZdtfI5jivNpxs0odmZg9
 JDxblby67dPVwdM8DFcQWrfe0A9i1yX21MXBnnvhcXyxPYoVdLpZMEuvRBU0pVxjM0cL
 5Y1pO6GFKr8vGzJ9f0JgfbsNZclv5bWvXtuViOxgMxeq+eLmrfCDNNiTQpSvwj5e3cAx
 LgBYrht7oYsAi6UHWwcmnFbhKgYeWRDbpjytWusqwFhEiWvL1mjoL/Q0LGOC1A/wWcff
 Tt1Q==
X-Gm-Message-State: AOJu0YzByJotoBgcrUL5tZuImlPDR+QSMwKH5nW8m381igTyRGIaef2W
 PGtYvU/hUkvRAKOQiJJOvFwuffFCXf61LkTwz57tTeyBfqpJQxWubzIUFD8ZbsnHoKSNdkyM+AF
 M9eOkN/e+jTXKY87RLcZT0sBYXmkvcJD4Om2cCBnY0Q==
X-Gm-Gg: ASbGnctNp28CiWjeZga2Xos/r22+inAZ929VCMPWt/uWOP+gWkfnjzo0HfSI+2szg4s
 d7CCEK97EkGczSfCp/UszsXMPbW6kHnjmszK86yMGMphT0n6nKLNoVJlJAFKuJy85J12rHjVndN
 bAUCamRvBw3NUUsZqKuy4+XaAsTfhuj/D5q4oGECBJccXpniXlJHt7JlL1BcmNqhoQ+3kaf1e7F
 sAbq1krIR7rUpRdz+I6bqkyD3d81CSb54GSJDKXsDD/RSRjsHSi2me5bm99f+4T4IJm+4J/qMoq
 K8MvGFzLkDAQVVyzXe+b
X-Google-Smtp-Source: AGHT+IEPpR1LPy4d2va624hzPp/+OmMNsYivDBgwyrTx6vg/Mw+l04fURSrTtj3dGuz84MUnUpgZV4GAgR6yjvU8DpE=
X-Received: by 2002:a05:690e:345:b0:62a:42ce:b7b9 with SMTP id
 956f58d0204a3-63ccb872a12mr8236090d50.1.1760095222166; Fri, 10 Oct 2025
 04:20:22 -0700 (PDT)
MIME-Version: 1.0
References: <20251009-detect_disk_image_type-v8-0-a8b50a3b4acf@linaro.org>
 <20251009-detect_disk_image_type-v8-2-a8b50a3b4acf@linaro.org>
In-Reply-To: <20251009-detect_disk_image_type-v8-2-a8b50a3b4acf@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 10 Oct 2025 14:19:46 +0300
X-Gm-Features: AS18NWBpMtD4E4yb8Pg3VDS0MULhIqAemi_aOPQBgtLJcAfY_1kSfag7mra4V10
Message-ID: <CAC_iWjK96Xzv0TwQ3CCp+2q84d0hZ7w0Qr154vM0C38aThyR=g@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] efi_loader: Improve disk image detection in
 efi_bootmgr
To: Javier Tia <javier.tia@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

On Thu, 9 Oct 2025 at 16:18, Javier Tia <javier.tia@linaro.org> wrote:
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
>  lib/efi_loader/efi_bootmgr.c | 49 +++++++++++++++++++++++++++++++-------------
>  1 file changed, 35 insertions(+), 14 deletions(-)
>
> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> index 662993fb809..d472dde158a 100644
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

I think this needs to be a log_warning() because we might be booting an EFI app.
Heinrich any preference?

[....]

Other than that
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
