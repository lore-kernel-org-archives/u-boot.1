Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E59DC47258
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 11:54:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE0EA878C6;
	Wed, 17 Jan 2024 12:54:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VkG29FoP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55A41878DA; Wed, 17 Jan 2024 12:54:00 +0100 (CET)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40AEB87707
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 12:53:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-50e7c6f0487so12747669e87.3
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 03:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705492437; x=1706097237; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OOf0n5mU7L3hNZqYtNPulDfvsdTSkQDFwQydC/dlkZg=;
 b=VkG29FoPhLen8kaoTzdpR7nYrfksEgLKWmPK1KjCxjrE8CupH0KtC+RYVOufnwvv7F
 FMKn3h/CL4PnR0v6ilTYe2WuACXYAcbPfquzMhOwd2bxT5yULPrR5cdq3VNmZBFIi2IW
 6ul/ITF7Xd0wjjilNTosizEBCAwi/fI47tumk56OXsBOgut3wWIvSx9kNQJ7v1tfW9ul
 Uq+lr0H8BdptZihPYAHTqc1JySJIy7OeiDPUHGSn+B1daf/q4Mf9L/Mrbt09UrbJ3lgi
 Fpj5Y+hK/BZsHCIRQ005FnJfdWAHFv4QI9CpjdGrswVwi+KSkveqnjc8m6/WTm6kz3BY
 6o8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705492437; x=1706097237;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OOf0n5mU7L3hNZqYtNPulDfvsdTSkQDFwQydC/dlkZg=;
 b=OICNh2cg2W3k6/5XoMjOeClU+cC2Tj0cVeMZJFzhFoUKCBYtU2mDdDmgin5rFr13Zp
 g7q0sUy0HeIM/KdZsvyy4SBgm8EvQ85aRI2zX/qRVnoOSaeofcrtU4SA4yaUgLaOP0r/
 fC2p1MRTPXrLaXgZMk2SPCx8cLWOkuQkEj2gSXxfsKZAgWsLVNFsnk7Qq/44WFoKJctj
 +URrJMWlm6BFVADyCxGFfKLWiM5SPatQrAHXvG7BwPe7Z/5szzOEOc63lc2fcmkfI8Ue
 gHHv6OzAeIDe9v1tpY5F5OqZFOnDOjMNQHRbtZJEHHZqYOneqmvnR+DwwBO1cWPfabiV
 Twaw==
X-Gm-Message-State: AOJu0YzMefkBHDHjydnC5Xt50bJ5pzpFYIphMKidByFFH0kl1wnUA2PW
 32Z8fGFmYrhIWYq2R2gYiz18fRMo6J8lY56F3VT6lFRhX7oQaw==
X-Google-Smtp-Source: AGHT+IEM6q+xrDZHWzuWkEPR6x80aAByCk4VSGHarXfLhdOz+GTMR6qGLlTnQD6FD+1QDnRJsa3YSGFO6pDN0mt3A+A=
X-Received: by 2002:a05:6512:e8a:b0:50f:5fc:3784 with SMTP id
 bi10-20020a0565120e8a00b0050f05fc3784mr1164944lfb.79.1705492437591; Wed, 17
 Jan 2024 03:53:57 -0800 (PST)
MIME-Version: 1.0
References: <20240117094432.1049168-1-masahisa.kojima@linaro.org>
 <20240117094432.1049168-3-masahisa.kojima@linaro.org>
In-Reply-To: <20240117094432.1049168-3-masahisa.kojima@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 17 Jan 2024 13:53:21 +0200
Message-ID: <CAC_iWjJ2FJjOmo6J-Y8q+hav8oTpYqmFmvqTHz8x_NDrUGPx5w@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] efi_loader: create common function to free struct
 efi_disk_obj
To: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <takahiro.akashi@linaro.org>
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

On Wed, 17 Jan 2024 at 11:46, Masahisa Kojima
<masahisa.kojima@linaro.org> wrote:
>
> Current error handling of creating raw disk/partition has
> following issues.
>  - duplicate free for EFI handle, EFI handle is already freed
>    in efi_delete_handle()
>  - missing free for struct efi_device_path and
>    struct efi_simple_file_system_protocol in some error paths
>
> To address those issues, this commit creates the common function
> to free the struct efi_disk_obj resources and calls it in case
> of error.
>
> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> ---
>  lib/efi_loader/efi_disk.c | 26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)
>
> diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
> index ce46c1092a..4897a7a7a8 100644
> --- a/lib/efi_loader/efi_disk.c
> +++ b/lib/efi_loader/efi_disk.c
> @@ -371,6 +371,20 @@ static int efi_fs_exists(struct blk_desc *desc, int part)
>         return 1;
>  }
>
> +static void efi_disk_free_diskobj(struct efi_disk_obj *diskobj)
> +{
> +       struct efi_device_path *dp = diskobj->dp;
> +       struct efi_simple_file_system_protocol *volume = diskobj->volume;
> +
> +       /*
> +        * ignore error of efi_delete_handle() since this function
> +        * is expected to be called in error path.
> +        */
> +       efi_delete_handle(&diskobj->header);
> +       efi_free_pool(dp);
> +       free(volume);
> +}
> +
>  /**
>   * efi_disk_add_dev() - create a handle for a partition or disk
>   *
> @@ -528,9 +542,7 @@ static efi_status_t efi_disk_add_dev(
>         }
>         return EFI_SUCCESS;
>  error:
> -       efi_delete_handle(&diskobj->header);
> -       free(diskobj->volume);
> -       free(diskobj);
> +       efi_disk_free_diskobj(diskobj);
>         return ret;
>  }
>
> @@ -569,8 +581,7 @@ static int efi_disk_create_raw(struct udevice *dev, efi_handle_t agent_handle)
>                 return ret;
>         }
>         if (efi_link_dev(&disk->header, dev)) {
> -               efi_free_pool(disk->dp);
> -               efi_delete_handle(&disk->header);
> +               efi_disk_free_diskobj(disk);
>
>                 return -EINVAL;
>         }
> @@ -624,8 +635,9 @@ static int efi_disk_create_part(struct udevice *dev, efi_handle_t agent_handle)
>                 return -1;
>         }
>         if (efi_link_dev(&disk->header, dev)) {
> -               efi_free_pool(disk->dp);
> -               efi_delete_handle(&disk->header);
> +               efi_disk_free_diskobj(disk);
> +
> +               /* TODO: closing the parent EFI_BLOCK_IO_PROTOCOL is missing. */
>
>                 return -1;
>         }
> --
> 2.34.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
