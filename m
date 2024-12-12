Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06FE7E7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 07:53:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FEEA8010E;
	Thu, 12 Dec 2024 08:53:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="k4sMzlo1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8626880137; Thu, 12 Dec 2024 08:53:29 +0100 (CET)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25DC0800DF
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 08:53:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e3989d27ba3so185656276.1
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 23:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733990006; x=1734594806; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9lZFhdtE75kVpHExs6OQt23L4GZKnpl9pSRsePnWdXU=;
 b=k4sMzlo1OPugyvRh5BUkp87j9WvUalauFJjWCeH2QU5IULiAIEzX2rrxoQDF/oSfXA
 V8I5PWh7GJWEDou6iSJeKWSP9SbFFqnq+66+4/LSrqn0DklDc2316NxBV0gDv1MAmku7
 1CPpMwa5X2kTPxrPB1EllIYVZumO6kynUvsEnVdsYDZpQKgNWZrRDu6YOezwiKtsPR7i
 PCpp4nQTU6A+ZZSxeMFQsw4BIrBLtWNzgBJqtZgeBEntO+a8vIV8KJVy5Y0t37FcaM7e
 6SOJcmWvIVGCKOeXJx5VhmXMpHZKdNsice3tjKE5qL5+b6qNIaOZ0+Dm4MbBY0Ig6wKO
 T7rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733990006; x=1734594806;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9lZFhdtE75kVpHExs6OQt23L4GZKnpl9pSRsePnWdXU=;
 b=mA0ICOWT/TVIgKtSWxTpK21f+HnASYZZWza0M8YRR0rwK7fIeOxYylthK6+7b5XPtw
 hgdsJv6zTpx3e4tZFEfF5/Ahpu9xBf82f5zbFs17ARdSOf7djWyzDHdTiJBMiurTu0/Y
 mD+236NsFlrv/7Zt3754WIby+3jE6qw87o63p0gtDn8I/+hGMwcwyvuyHZ6QdnPIsn5x
 vG8FD0ieS0aapA/6FPfVbUO/Xf84vBA9ghtXuOXpWMcqGr3WxkWEtf8+9gD6dx/9owYM
 97Jrvb3/8ms+hLADMh/977BCajy7K61f6FBxCJ24CRIC4HIojqJvck4dgjeieGch1GYU
 msyg==
X-Gm-Message-State: AOJu0YxcocacLrhX08J0BjlBgmuobocVlOmyOx+chb0TBEZ0GDkZ2IjF
 UxMDh/i7ETiBSbM+3LqnBsXJ9UH0rz5p5Eyd7TpSeqeB9qe3A2798kSTCthZn15ZYop6qfVP3Jc
 HKQowRkuHxz4lU4xXimyCzAtqhtdcpTQUxrfRnw==
X-Gm-Gg: ASbGnctNaRarOF7nhzDimhJXApVwaIgKh94OKCdHyNfpVtqdY/5M+DsmCq1HrmXTLk4
 vz/aX+ltM7j6xTeKA5t/g1uXFvSwgDLqMBVHerw==
X-Google-Smtp-Source: AGHT+IGWOvK3suKStJgKZgBVDR7DAETfadTIeHZ4aWn5y6Wj6HQ5cIvZM1UVRDF5vtboPmsQS+i35zVi/cbI9HLMX98=
X-Received: by 2002:a05:6902:2188:b0:e38:8fdf:ffdc with SMTP id
 3f1490d57ef6-e3da0d5baf9mr2241310276.22.1733990006021; Wed, 11 Dec 2024
 23:53:26 -0800 (PST)
MIME-Version: 1.0
References: <20241211223822.2446254-1-sjg@chromium.org>
 <20241211223822.2446254-6-sjg@chromium.org>
In-Reply-To: <20241211223822.2446254-6-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 12 Dec 2024 09:52:50 +0200
Message-ID: <CAC_iWjLk_moWeTpo-dR_FV7E4+40U0S+DjD5dd3nWhf2KSGDrg@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] efi_loader: Move the fallback code from
 efi_run_image()
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Moritz Fischer <moritzf@google.com>
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

Checkpatch has errors on this. Please have a look

Also for some reason is fails to apply after patch 4.

Thanks
/Ilias


On Thu, 12 Dec 2024 at 00:38, Simon Glass <sjg@chromium.org> wrote:
>
> This code is only needed if an invalid image/device path is passed in.
> Move the code out to a caller where this can be dealt with. The normal
> flow will provide these parameters.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v1)
>
>  lib/efi_loader/efi_bootbin.c | 103 ++++++++++++++++-------------------
>  1 file changed, 48 insertions(+), 55 deletions(-)
>
> diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
> index 8ebd48547cb..582b2745ced 100644
> --- a/lib/efi_loader/efi_bootbin.c
> +++ b/lib/efi_loader/efi_bootbin.c
> @@ -147,36 +147,13 @@ static efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size,
>                                   struct efi_device_path *device,
>                                   struct efi_device_path *image)
>  {
> -       efi_handle_t mem_handle = NULL, handle;
> -       struct efi_device_path *file_path = NULL;
> -       struct efi_device_path *msg_path;
> +       efi_handle_t handle;
> +       struct efi_device_path *msg_path, *file_path;
>         efi_status_t ret;
>         u16 *load_options;
>
> -       if (!device || !image) {
> -               log_debug("Not loaded from disk\n");
> -               /*
> -                * Special case for efi payload not loaded from disk,
> -                * such as 'bootefi hello' or for example payload
> -                * loaded directly into memory via JTAG, etc:
> -                */
> -               file_path = efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE,
> -                                           source_buffer, source_size);
> -               /*
> -                * Make sure that device for device_path exist
> -                * in load_image(). Otherwise, shell and grub will fail.
> -                */
> -               ret = efi_install_multiple_protocol_interfaces(&mem_handle,
> -                                                              &efi_guid_device_path,
> -                                                              file_path, NULL);
> -               if (ret != EFI_SUCCESS)
> -                       goto out;
> -               msg_path = file_path;
> -       } else {
> -               file_path = efi_dp_concat(device, image, 0);
> -               msg_path = image;
> -               log_debug("Loaded from disk\n");
> -       }
> +       file_path = efi_dp_concat(device, image, 0);
> +       msg_path = image;
>
>         log_info("Booting %pD\n", msg_path);
>
> @@ -195,36 +172,13 @@ static efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size,
>         ret = do_bootefi_exec(handle, load_options);
>
>  out:
> -       if (mem_handle) {
> -               efi_status_t r;
> -
> -               r = efi_uninstall_multiple_protocol_interfaces(
> -                       mem_handle, &efi_guid_device_path, file_path, NULL);
> -               if (r != EFI_SUCCESS)
> -                       log_err("Uninstalling protocol interfaces failed\n");
> -       }
> -       efi_free_pool(file_path);
>
>         return ret;
>  }
>
> -/**
> - * efi_binary_run_() - run loaded UEFI image
> - *
> - * @image_ptr: memory address of the UEFI image
> - * @size:      size of the UEFI image
> - * @fdt:       device-tree
> - * @device:    EFI device-path
> - * @image:     EFI image-path
> - *
> - * Execute an EFI binary image loaded at @image.
> - * @size may be zero if the binary is loaded with U-Boot load command.
> - *
> - * Return:     status code
> - */
> -efi_status_t efi_binary_run_(void *image_ptr, size_t size, void *fdt,
> -                            struct efi_device_path *device,
> -                            struct efi_device_path *image)
> +static efi_status_t efi_binary_run_(void *image_ptr, size_t size, void *fdt,
> +                                   struct efi_device_path *device,
> +                                   struct efi_device_path *image)
>  {
>         efi_status_t ret;
>
> @@ -257,6 +211,45 @@ efi_status_t efi_binary_run_(void *image_ptr, size_t size, void *fdt,
>   */
>  efi_status_t efi_binary_run(void *image, size_t size, void *fdt)
>  {
> -       return efi_binary_run_(image, size, fdt, bootefi_device_path,
> -                              bootefi_image_path);
> +       efi_handle_t mem_handle = NULL;
> +       struct efi_device_path *file_path = NULL;
> +       efi_status_t ret;
> +
> +       if (!bootefi_device_path || !bootefi_image_path) {
> +               log_debug("Not loaded from disk\n");
> +               /*
> +                * Special case for efi payload not loaded from disk,
> +                * such as 'bootefi hello' or for example payload
> +                * loaded directly into memory via JTAG, etc:
> +                */
> +               file_path = efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE, image,
> +                                           size);
> +               /*
> +                * Make sure that device for device_path exist
> +                * in load_image(). Otherwise, shell and grub will fail.
> +                */
> +               ret = efi_install_multiple_protocol_interfaces(&mem_handle,
> +                                                              &efi_guid_device_path,
> +                                                              file_path, NULL);
> +               if (ret != EFI_SUCCESS)
> +                       goto out;
> +       } else {
> +               log_debug("Loaded from disk\n");
> +       }
> +
> +       ret = efi_binary_run_(image, size, fdt, bootefi_device_path,
> +                             bootefi_image_path);
> +out:
> +       if (mem_handle) {
> +               efi_status_t r;
> +
> +               r = efi_uninstall_multiple_protocol_interfaces(mem_handle,
> +                                       &efi_guid_device_path, file_path, NULL);
> +               if (r != EFI_SUCCESS)
> +                       log_err("Uninstalling protocol interfaces failed\n");
> +       }
> +       efi_free_pool(file_path);
> +
> +       return ret;
>  }
> +
> --
> 2.34.1
>
