Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0685E7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 07:44:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E54DD801DB;
	Thu, 12 Dec 2024 08:44:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rC27CALn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7FC2801F5; Thu, 12 Dec 2024 08:44:04 +0100 (CET)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96919800D9
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 08:44:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-6ef7f8acc33so3002607b3.1
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 23:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733989441; x=1734594241; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zRCbrGP/YcD4xcKZCOsh/dvcTKTuILGWK8EbjbHesLk=;
 b=rC27CALnNUroMqWGl/mg8iH5oINwmUP/8WQqQf6c8TbV5Yr1/+6PKiah6Uet7Y7zgs
 kHznq5re63JF9rZI2h2wpa2ule2bsX3SqgmxIUegY4aR0kIyF1HMBPS9dWbBz6W34Dlk
 /92ZWJbcFN+jzI/OpnZ94yhrnaSyc6NF5KhpVYJ8VTm3sg2MyL/OgoU2CQOkzupCktW+
 hFjveiDtvavKorGxOaQP+hTSYJW5eVJtb1CEQuQ8rqJk2FKljCD8bbxyaDLOCp0OJx7w
 cdeACUYY24Sg47AvG8Y1MYruXEEbEH0+eKOYQO+PLVqrsnv7A1wDlYFWnophKGDCejdh
 aKKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733989441; x=1734594241;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zRCbrGP/YcD4xcKZCOsh/dvcTKTuILGWK8EbjbHesLk=;
 b=WRvh3Fx3da6oL4TTkVoOLaAp1lHb0FbOxAYfbeEsBnGEGhGEaxCyuo2gXS5uUYXisT
 8vqLtkzjw2+vbB+qngtWdvvFyGunJH7UzOGrnw0ILNxD8IzOln9QVHwSOHZMTNaL0fm1
 tWo9Hoq/eoKcsciU4cqWmYxz3yAxmHe8tltzkLcAEb8CVnaxYrKpSc5KGluaRPAhxLvk
 WaBNZnfRaqXb6AwaXtzjQYKwstq7hoxU8XhdF2XbvPPN1moTxB3Ml8RsrhJ3kSSWt3Ad
 OZgVftHr8fleqNx9OZkTNIpwMdg4nYKzXHfo8y/Iu8ap3OVKo8MRgN2kHbrNpP0qvldd
 E9Kg==
X-Gm-Message-State: AOJu0YyMN/7PekqJICjAXKm94BAAl9x+Aoq0su2ncM2hkhymyNsbz9M7
 F/QSyz4zFgU/NAKjTWFou2N4Qf/MzEbs8FSpRlA0rfaKazN5sQCvEh5ZAjD/KkDypqHByHTkGoN
 162QqXDWWsrwr4Epwh9aHIWNxkfALo4grMkbTOQ==
X-Gm-Gg: ASbGncupWo/W3Pol4Jty5kC6tCXtx+XUXDloFCfHeot2DIggTAiLwBAUeywXBCm3Yv2
 fCLPx8O2IxFsjnN6EKRs/qck6rQRp1bCEd+gxnw==
X-Google-Smtp-Source: AGHT+IE6cd+++9JzCmeBOAFhNWOYb+ZW39bFecmQHX7We9wLaHbzPQ/wn8SWNOlwww8dIPEbcN40Yjxx7Fk/DiNgk0U=
X-Received: by 2002:a05:6902:1617:b0:e3c:8ec9:c896 with SMTP id
 3f1490d57ef6-e3da1eee93amr2032665276.34.1733989441399; Wed, 11 Dec 2024
 23:44:01 -0800 (PST)
MIME-Version: 1.0
References: <20241211223822.2446254-1-sjg@chromium.org>
 <20241211223822.2446254-4-sjg@chromium.org>
In-Reply-To: <20241211223822.2446254-4-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 12 Dec 2024 09:43:25 +0200
Message-ID: <CAC_iWj+5-uoXq9BanaOSxedVgbBYNFQ2AZVqka+J7iwMv=eC5w@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] efi_loader: Update efi_run_image() to accept image
 and device path
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

On Thu, 12 Dec 2024 at 00:38, Simon Glass <sjg@chromium.org> wrote:
>
> Provide these globals as parameters to this function, on the way to
> making it possible to start an image without relying on the globals.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> Changes in v2:
> - Adjust argument ordering for efi_run_image()
>
>  lib/efi_loader/efi_bootbin.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
> index ec8f4e4f7f4..8febd325f34 100644
> --- a/lib/efi_loader/efi_bootbin.c
> +++ b/lib/efi_loader/efi_bootbin.c
> @@ -139,9 +139,13 @@ void efi_set_bootdev(const char *dev, const char *devnr, const char *path,
>   *
>   * @source_buffer:     memory address of the UEFI image
>   * @source_size:       size of the UEFI image
> + * @device:            EFI device-path
> + * @image:             EFI image-path
>   * Return:             status code
>   */
> -static efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size)
> +static efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size,
> +                                 struct efi_device_path *device,
> +                                 struct efi_device_path *image)
>  {
>         efi_handle_t mem_handle = NULL, handle;
>         struct efi_device_path *file_path = NULL;
> @@ -149,7 +153,7 @@ static efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size)
>         efi_status_t ret;
>         u16 *load_options;
>
> -       if (!bootefi_device_path || !bootefi_image_path) {
> +       if (!device || !image) {
>                 log_debug("Not loaded from disk\n");
>                 /*
>                  * Special case for efi payload not loaded from disk,
> @@ -169,9 +173,8 @@ static efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size)
>                         goto out;
>                 msg_path = file_path;
>         } else {
> -               file_path = efi_dp_concat(bootefi_device_path,
> -                                         bootefi_image_path, 0);
> -               msg_path = bootefi_image_path;
> +               file_path = efi_dp_concat(device, image, 0);
> +               msg_path = image;
>                 log_debug("Loaded from disk\n");
>         }
>
> @@ -208,7 +211,7 @@ out:
>  /**
>   * efi_binary_run() - run loaded UEFI image
>   *
> - * @image:     memory address of the UEFI image
> + * @image_ptr: memory address of the UEFI image
>   * @size:      size of the UEFI image
>   * @fdt:       device-tree
>   *
> @@ -217,7 +220,7 @@ out:
>   *
>   * Return:     status code
>   */
> -efi_status_t efi_binary_run(void *image, size_t size, void *fdt)
> +efi_status_t efi_binary_run(void *image_ptr, size_t size, void *fdt)

The * is enough, please drop the _ptr rename

>  {
>         efi_status_t ret;
>
> @@ -233,5 +236,6 @@ efi_status_t efi_binary_run(void *image, size_t size, void *fdt)
>         if (ret != EFI_SUCCESS)
>                 return ret;
>
> -       return efi_run_image(image, size);
> +       return efi_run_image(image_ptr, size, bootefi_device_path,
> +                            bootefi_image_path);
>  }
> --
> 2.34.1
>

With the ptr rename removed
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
