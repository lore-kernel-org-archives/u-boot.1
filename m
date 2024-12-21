Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A507E7718B
	for <u-boot@archiver.kernel.org>; Sat, 21 Dec 2024 08:46:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F221480423;
	Sat, 21 Dec 2024 09:46:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JmPk5pF4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2744D80433; Sat, 21 Dec 2024 09:46:03 +0100 (CET)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7665803E0
 for <u-boot@lists.denx.de>; Sat, 21 Dec 2024 09:46:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e5372a2fbddso2392270276.3
 for <u-boot@lists.denx.de>; Sat, 21 Dec 2024 00:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734770759; x=1735375559; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2UdEW76IRHQE4a5At5i7j2B1WLeBSQyqNOFLcebd1go=;
 b=JmPk5pF4hamx5oB4PhZNqY5z1SY2vxMFtDpiE0A6F+YgPJ9Bts/ttNrEhw3cE1l5qG
 gmJMXYp2lSVz9urm71bYabiqzSOy9L85ab+2Fgo8C1DLpXQUIEe6ZOtPlaSS+StOfEmc
 iPN1hbVLIPAPBNy2KsZKDXRolSlgtcZTjBRaaGj1avv3QkvN2VeB80WGfvyGkLj+LQbh
 Q2hfZ3aU+GNAH06fZxFCFUxj3n1XMCxz9RRNs6BguC57KIvFf4AWefmYiA6awzguL6YA
 wjdhtGMECH2XZ7AKnB8ZukaxO//K4vsHw2q1vml/OkM4ObBAtlLMqRbWL8nnF56EUVFJ
 71wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734770759; x=1735375559;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2UdEW76IRHQE4a5At5i7j2B1WLeBSQyqNOFLcebd1go=;
 b=qQCiMxiTvJJSDObrvKxhVnfveJQflCclBd61DKbHC1mc0tWfWSs4gw3neemBxGOv7y
 HnMuF0ndIE7DroGcsCoPo8lOIj7xtbwk7/XC23biN+qfb4wRkCW1AsXlr4RJ/13S27Yf
 i28WnZZPUd9Ka2xeHibos6WPuQAThZHcRi4MufjKTYuOT9v6fh35w1uaq2TEpWzXZ/lj
 cYqNvASK/kXCCzaIjqkVRPg3CTtI5euZeq+vQt1aIciw3CQudNBx949QTwP8f7uyc2YT
 qduG6/VZTajGXXQm1p/4txSZXqTzEE3IS3K0TQjnntI1tnyO0xxbtYTXCHGuFfZ5LyRV
 o3Tw==
X-Gm-Message-State: AOJu0YzYJl7sh7auygwxTquVSvcTVcVJy4WP2oEpRDvE1T4F8w2vWYoc
 T3z6AK0kfiHFrtooM2KkpSmBWMMWZyt8m+zPRIwFetfmbpjwFllJmVBBRAaN+umTsvz495hiB+I
 7tATsAK10dXEA7lRkji6TBVjiljlIZWHNvVVyQx3hKOf/7u/YO0s=
X-Gm-Gg: ASbGnct9rR7ouSw9W6iTq5J52626O8T8tsbEIXYkSYR+P3ysH96jk+nC0kmNLHwTBc4
 oSNaF928oFUkXKoz4QG6S90yXw960Db1X+xhVoQ==
X-Google-Smtp-Source: AGHT+IGxwy7nOHVX5KiugAaKLjGR/LumCs5dk/TBj6G7u3JGi8FTeA9DVEU3e8VmcuhR+N07IjBbYfcyi1fCniXvL4E=
X-Received: by 2002:a05:6902:200d:b0:e39:b357:cb15 with SMTP id
 3f1490d57ef6-e538c2594f1mr5038198276.16.1734770759538; Sat, 21 Dec 2024
 00:45:59 -0800 (PST)
MIME-Version: 1.0
References: <20241219023832.1098689-1-sjg@chromium.org>
 <20241219023832.1098689-5-sjg@chromium.org>
In-Reply-To: <20241219023832.1098689-5-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sat, 21 Dec 2024 10:45:23 +0200
Message-ID: <CAC_iWjKwu8hDrO3X+gy36_Ccfb3F6nEW_V8ZopT2E1kOz5Xbng@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] efi_loader: Add a version of efi_binary_run() with
 more parameters
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Tom Rini <trini@konsulko.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Adriano Cordova <adrianox@gmail.com>, Moritz Fischer <moritzf@google.com>
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

Hi Simon,

On Thu, 19 Dec 2024 at 04:39, Simon Glass <sjg@chromium.org> wrote:
>
> This uses a few global variables at present. With the bootflow we have
> the required parameters, so add a function which accepts these. Update
> the existing function to call the new one with the globals.
>
> - Rename efi_binary_run_() to _efi_binary_run()
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v1)
>
>  lib/efi_loader/efi_bootbin.c | 29 +++++++++++++++++++++++++----
>  1 file changed, 25 insertions(+), 4 deletions(-)
>
> diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
> index b42ff3cb4e0..f7aedeaab8a 100644
> --- a/lib/efi_loader/efi_bootbin.c
> +++ b/lib/efi_loader/efi_bootbin.c
> @@ -228,18 +228,22 @@ out:
>  }
>
>  /**
> - * efi_binary_run() - run loaded UEFI image
> + * efi_binary_run_() - run loaded UEFI image
>   *
>   * @image_ptr: memory address of the UEFI image
>   * @size:      size of the UEFI image
>   * @fdt:       device-tree
> + * @device:    EFI device-path
> + * @image:     EFI image-path
>   *
>   * Execute an EFI binary image loaded at @image.
>   * @size may be zero if the binary is loaded with U-Boot load command.
>   *
>   * Return:     status code
>   */
> -efi_status_t efi_binary_run(void *image_ptr, size_t size, void *fdt)
> +efi_status_t _efi_binary_run(void *image_ptr, size_t size, void *fdt,
> +                            struct efi_device_path *device,
> +                            struct efi_device_path *image)
>  {
>         efi_status_t ret;
>
> @@ -255,6 +259,23 @@ efi_status_t efi_binary_run(void *image_ptr, size_t size, void *fdt)
>         if (ret != EFI_SUCCESS)
>                 return ret;
>
> -       return efi_run_image(image_ptr, size, bootefi_device_path,
> -                            bootefi_image_path);
> +       return efi_run_image(image_ptr, size, device, image);
> +}
> +
> +/**
> + * efi_binary_run() - run loaded UEFI image
> + *
> + * @image:     memory address of the UEFI image
> + * @size:      size of the UEFI image
> + * @fdt:       device-tree
> + *
> + * Execute an EFI binary image loaded at @image.
> + * @size may be zero if the binary is loaded with U-Boot load command.
> + *
> + * Return:     status code
> + */
> +efi_status_t efi_binary_run(void *image, size_t size, void *fdt)
> +{
> +       return _efi_binary_run(image, size, fdt, bootefi_device_path,
> +                              bootefi_image_path);
>  }
> --
> 2.34.1
>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
