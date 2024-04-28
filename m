Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC93C4345F
	for <u-boot@archiver.kernel.org>; Sun, 28 Apr 2024 13:32:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF1E6882D9;
	Sun, 28 Apr 2024 15:32:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="J/9dxsmU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 281A088308; Sun, 28 Apr 2024 15:32:55 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B085882AF
 for <u-boot@lists.denx.de>; Sun, 28 Apr 2024 15:32:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a58989cd1f8so462257666b.1
 for <u-boot@lists.denx.de>; Sun, 28 Apr 2024 06:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714311172; x=1714915972; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1OJH7hsLok++OkguDqhGYtVffiqU9XIQwKibpkMbzuU=;
 b=J/9dxsmUnjFkjunjmzF9W7NwKCMWJBOaKuYeqCforGSh9uFjyLAXso6qlqLHljcy0J
 gqDBrhp6qr8tM1snmg5WkKNLSXPouazVUgHIW9mv2io51gv3mGxZBsboNJ1CoWh+N6dK
 tyHoTRTMQXxQYj+FXB4mMpHnkrr7CVeipynwbwQzsv4El4YrCI2uZbkTMCmAkVwKRmCe
 E40wxQkYPF8ftQ+g4OdfXfPRrXMyvb7PAknf084gEhXGK6UXvZabXGOuWWUTOvXio5oK
 DEi7Pt3FUY5JEXtWs8Lb993ICk4PZdp6aI8LpPlN5iib/TF+QWDDA9elSa0uCbj49TnC
 LIBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714311172; x=1714915972;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1OJH7hsLok++OkguDqhGYtVffiqU9XIQwKibpkMbzuU=;
 b=U4mTntiAgvIeQ/twowO0sFTfKs+wxh3InHvQrBBQiT/k0CadgAmGBtWfUqivK0bg+S
 X3YsqkzR2saNSOMpBVcZz5gkTDzvHOKINg6YinyYyndfEi0BDBEX4q0LRJuFPFbIK1dd
 yaeikzEF5etv7x9XMbsQih3LZI9bEruC1mDrjDhp+ye5Y6khqP0iDX6zJmR8cmtIgV3W
 x9TyxpzHAxAIBKdVufJ7RqyCZe9zEdX6Ea0CL8JtBrpuC5ja3BPRLM9Id27WQA56Gy8d
 D2fb62YNS7qzDZ5EinA9TcxApLKggxuxAw7Blxcl/PAf92CVpkxyAmIa9L5dCV30BJqa
 AZkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgn/KvvDO7lQa5kZvEmXxEOzQk5mZdSWvpyJRt3mow40aAz3V8wQ8lo+qGgMdt3/H6MgSZsd863tPW3GE1a8dbpjMM8Q==
X-Gm-Message-State: AOJu0Yyoir1A6NxYLgtvZ5n3ZBmVsHZjlpYmO632wo0epix2p02ZLHnf
 rmmzWICBW1kHwEYr37AukYJnyeQm1D4LKotP6nrBv2l0GA6hIWGiZ8ZvJiPpJJD4LozKzBXcKQC
 qZhMN0RNM975Hk/ojh7GCDw44JB6aDJs5S2oxdQ==
X-Google-Smtp-Source: AGHT+IF8bPP0W4z/3e2FYxW7/d6iCEgxqIZ1EIk57OwetDIihWU5oFTzvLCwHxOlTfxqCMhCw7U4JfUhiNa4YhWD2mU=
X-Received: by 2002:a17:906:d929:b0:a55:75f6:ce0f with SMTP id
 rn9-20020a170906d92900b00a5575f6ce0fmr3286662ejb.13.1714311172609; Sun, 28
 Apr 2024 06:32:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240426141321.232236-1-heinrich.schuchardt@canonical.com>
 <20240426141321.232236-14-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240426141321.232236-14-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sun, 28 Apr 2024 16:32:16 +0300
Message-ID: <CAC_iWjKnXv6+v7P8wqmXW9rJt7YyZ=0WyWMpgskmdk28z5jAsw@mail.gmail.com>
Subject: Re: [RFC 13/14] efi_loader: export efi_load_image_from_path
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Shantur Rathore <i@shantur.com>, Bin Meng <bmeng@tinylab.org>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Raymond Mao <raymond.mao@linaro.org>, Mark Kettenis <kettenis@openbsd.org>, 
 Joao Marcos Costa <jmcosta944@gmail.com>, u-boot@lists.denx.de
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

On Fri, 26 Apr 2024 at 17:14, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> We can reuse this function to load the device-tree.

This patch is correct, but needs splitting.
It exports the function, but also adds IS_ENABLED etc, that belong to
an earlier patch

Thanks
/Ilias
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  include/efi_loader.h          |  4 ++++
>  lib/efi_loader/efi_bootmgr.c  | 17 +++++++++++++----
>  lib/efi_loader/efi_boottime.c |  1 -
>  3 files changed, 17 insertions(+), 5 deletions(-)
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index ed2b517b130..0bf325fdc4b 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -664,6 +664,10 @@ efi_status_t EFIAPI efi_load_image(bool boot_policy,
>                                    void *source_buffer,
>                                    efi_uintn_t source_size,
>                                    efi_handle_t *image_handle);
> +/* Load image from path */
> +efi_status_t efi_load_image_from_path(bool boot_policy,
> +                                     struct efi_device_path *file_path,
> +                                     void **buffer, efi_uintn_t *size);
>  /* Start image */
>  efi_status_t EFIAPI efi_start_image(efi_handle_t image_handle,
>                                     efi_uintn_t *exit_data_size,
> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> index 3d58a928b10..9ae948bcf08 100644
> --- a/lib/efi_loader/efi_bootmgr.c
> +++ b/lib/efi_loader/efi_bootmgr.c
> @@ -1265,12 +1265,21 @@ efi_status_t efi_bootmgr_run(void *fdt)
>                 return ret;
>         }
>
> -       fdt_lo = load_fdt_from_load_option();
> -       if (fdt_lo)
> -               fdt = fdt_lo;
> +       if (!IS_ENABLED(CONFIG_GENERATE_ACPI_TABLE)) {
> +               fdt_lo = load_fdt_from_load_option();
> +               if (fdt_lo)
> +                       fdt = fdt_lo;
> +       }
>
> +       /*
> +        * Needed in ACPI case to create reservations based on
> +        * control device-tree.
> +        */
>         ret = efi_install_fdt(fdt);
> -       free(fdt_lo);
> +
> +       if (!IS_ENABLED(CONFIG_GENERATE_ACPI_TABLE))
> +               free(fdt_lo);
> +
>         if (ret != EFI_SUCCESS) {
>                 if (EFI_CALL(efi_unload_image(handle)) == EFI_SUCCESS)
>                         free(load_options);
> diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
> index 33f03c0cb0f..50ce8386051 100644
> --- a/lib/efi_loader/efi_boottime.c
> +++ b/lib/efi_loader/efi_boottime.c
> @@ -1996,7 +1996,6 @@ error:
>   * @size:              size of the loaded image
>   * Return:             status code
>   */
> -static
>  efi_status_t efi_load_image_from_path(bool boot_policy,
>                                       struct efi_device_path *file_path,
>                                       void **buffer, efi_uintn_t *size)
> --
> 2.43.0
>
