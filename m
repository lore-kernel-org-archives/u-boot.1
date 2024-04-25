Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55C1EC4345F
	for <u-boot@archiver.kernel.org>; Thu, 25 Apr 2024 08:10:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0AEF88F10;
	Thu, 25 Apr 2024 10:10:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xlM7Oo53";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 933CF88F10; Thu, 25 Apr 2024 10:10:50 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 945978816A
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 10:10:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-572242ed990so585960a12.0
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 01:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714032648; x=1714637448; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sv6+YhdBMvuwJDnaTZEAbCUkoYx2IXszYn7CkaenqHY=;
 b=xlM7Oo53FO7L0jzLa+6t8uLdlKHNA1O1vvLUD4logJW/AbOSS5KGwxLi5mobxchxan
 13NwOo+q+SkOk9YdEJwmC9XyEgo34jWodzHQitRhWHuQ5HwsQyL1XL9E02B1lxgN/GH0
 XwPVEvCnqsTYpjAlBxSHucJlRbM64Hpbm6uxeCkUtpkZZ+m/kiRm1VXA2vOK+siZF9Cy
 +JQTr7HqQtRTY+6tvXhG1vJnsQgYHiUdZ73ShOuNr52jpxsp/6zJK6w+b2zjR7cgCSYi
 Nn+Te45voSYpfMZoTSJAw2IHXYNGKA90DUbjPzR9zIpdbYI9glZBtmMZxux66Yrrb10V
 bw7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714032648; x=1714637448;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sv6+YhdBMvuwJDnaTZEAbCUkoYx2IXszYn7CkaenqHY=;
 b=e4mLBkhJhYEsM4pgRdO/VAKnTpBfhNZMmjDwqdodJDx8UcFY1MiO5OhYJFxvkHcNwe
 P11qazjRzJD4RY6H5HfjGANG3JNx0edUnBBA7KK8B89Okx3xkM0jMbpatpEGYljjTSQX
 bzshWcrdo4vQPi8fViQzPxRgtW4VkNJ6hnCdmwFhIujTrbkcWa08T7JPRDWEHyIl8aUB
 ww0z3hMV1HrRVouv5qJ715sij3r4FiHtUZHqQhFNl0BndkfvGbwL0gi0puZZIG8Tch9Z
 dym9CdW8DvVRZMI27QPmIZmY/rNy20p9/0J59GPQ5vvoBs73kgnOS+EtK3PVzVpVzRZQ
 l1FQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXt+Z0ueBxAmHuTJioHUItFoHJKHJfDdV5saf4ZRRbDM32Micmze5A9F1mYyl0+26BuCl8O8G9nUqsAwksQAKjvMAf89w==
X-Gm-Message-State: AOJu0Yx9+bagJTwT2X60EbGDexpO2YFbjvNq8VGNDQ+6xQx2oBbEi1m5
 MwksQyCgkkWKm6zUyFyr9aUPwM6qwOQYTCiJwtp5DDAxe4g+pff5uAaXHwt68UDf8lHBrBKMN72
 tZT/sFcuJdxkVLiCofZW2Ljo+1YMFn9sDkRngrw==
X-Google-Smtp-Source: AGHT+IH2gLpiVMC/k9VLU6nlwxsVnoQFVjENdAhFE82EKbMW0Q6odsvTpM8msH+/y2665NwLxyzBlwzSvlqfNw41yls=
X-Received: by 2002:a17:906:3385:b0:a58:7f48:18c4 with SMTP id
 v5-20020a170906338500b00a587f4818c4mr3276205eja.68.1714032647963; Thu, 25 Apr
 2024 01:10:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240425080625.26838-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240425080625.26838-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 25 Apr 2024 11:10:11 +0300
Message-ID: <CAC_iWjL3ong6a6xMAcFCPHjzQf5=S_wSrp+9h2W6PYioj+GHuw@mail.gmail.com>
Subject: Re: [PATCH v2] efi_loader: do not install dtb if bootmgr fails
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Masahisa Kojima <kojima.masahisa@socionext.com>,
 Raymond Mao <raymond.mao@linaro.org>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de
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

Hi Heinrich,

On Thu, 25 Apr 2024 at 11:06, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> If the UEFI boot manager fails there is no point in installing the
> device-tree as a configuration table.
>
> Unload image if device-tree cannot be installed.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         Unload image if device-tree cannot be installed.
> ---
>  lib/efi_loader/efi_bootmgr.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> index ca2ebdaa32f..aa2cc0eb52f 100644
> --- a/lib/efi_loader/efi_bootmgr.c
> +++ b/lib/efi_loader/efi_bootmgr.c
> @@ -1209,15 +1209,21 @@ efi_status_t efi_bootmgr_run(void *fdt)
>                 return CMD_RET_FAILURE;
>         }
>
> -       ret = efi_install_fdt(fdt);
> -       if (ret != EFI_SUCCESS)
> -               return ret;
> -
>         ret = efi_bootmgr_load(&handle, &load_options);
>         if (ret != EFI_SUCCESS) {
>                 log_notice("EFI boot manager: Cannot load any image\n");
>                 return ret;
>         }
>
> +       ret = efi_install_fdt(fdt);
> +       if (ret != EFI_SUCCESS) {
> +               if (EFI_CALL(efi_unload_image(*handle)) == EFI_SUCCESS)
> +                       free(load_options);
> +               else
> +                       log_err("Unloading image failed\n");
> +
> +               return ret;
> +       }
> +

This should be fine, I was just wondering, why not leave the
efi_install_fdt() and uninstall it if efi_bootmgr_load() fails.
That would remove the unload complexity if the fdt install fails.

Thanks
/Ilias

>         return do_bootefi_exec(handle, load_options);
>  }
> --
> 2.43.0
>
