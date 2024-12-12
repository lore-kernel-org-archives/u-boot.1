Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76955E77180
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 07:49:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB598801F5;
	Thu, 12 Dec 2024 08:49:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eNzEnDlS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12020801FE; Thu, 12 Dec 2024 08:49:52 +0100 (CET)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD91C800D9
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 08:49:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e399e904940so183267276.2
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 23:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733989789; x=1734594589; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YP/9Gku1fKWDVa6SzERTFm1n2v32KuxCNizwYKzS0rI=;
 b=eNzEnDlS7ZaU5TpwkIZJmBdL3k+pn8j2/o3T9SRjYYFARfKR7nFjUDJuXO7KxUKrPP
 Ew0jJ67UKr+icbrl7C8eDINl27FSTSSULN8hT3wxwt67jb3cRGO2WQGaIUjIr+ZPrpCt
 8ifBWNcE23HVlAj286Q9ImeOrkrihAxKntZd0Qz5cMhl0FieuwvHQ48pDErPV2uXooNl
 iLjp+CH5HBEf5AJ4IiqWim9u8Z5rNEBvAJBDIg58YiRU7+AGXslRNIH+1e0vxvmmg+Fo
 bYK2s49aaXqjs3nxJHtJchs05TXgKzbtP/bD/NTYIDwNzmVc8hCAMM76fB4QEdVDCDAn
 R9UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733989789; x=1734594589;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YP/9Gku1fKWDVa6SzERTFm1n2v32KuxCNizwYKzS0rI=;
 b=OFBeDYpVDiha/aJAHvqUEcWNGlH0dPW4IFc+Pz20xo+okAInFtta9ioxlmQ8YPbkWt
 aftZkc8Nc5AXWPAeiZRQMChesQeLZ3H9Ud1jVVJnC2CI9g+QQvEAo74ZGHJwO4Hcq7LY
 j4AmsixFLftRcBt5yhTfWIhsbEKdsObebXpT8k7QKt4d3mL8WNiIhnZziKsfUe7xcY19
 iXpTOK5Saia7GuLU72nlR39aY0f6OC+ZTR8OXuu2CBp7T/ZLg9ysNZ9R4icaNuhA6Cjt
 xEixJOBjmMh877wexBHve8VibVe+GBe5ip27836dbkTI/zDmbfzLDggxElbpCIOK344L
 tDBQ==
X-Gm-Message-State: AOJu0YywAR6WxeI8kaEZQjjonZD2IJiyLsYo++4Tq+OdtBakCHtNY6XU
 dC4nNsSnGDaanQq5mUaqdEbNinTc7HOslbkg0y222hoHJ3oGZqIiYVj6UVjuj06L+ekSElosr3B
 +MFd6PcXR7YBSCH4TrM3tyrmCE4T+ubIDbTN6Cw==
X-Gm-Gg: ASbGncv3tycPrc5vfAsAybq4easGnm5xRO0sz/IEDxy8y4cIZo6u2wgb3SiubVgVnO6
 Ua5FMgppZu2VxV30Z9AwVEFr8noglkUhGJFsx5g==
X-Google-Smtp-Source: AGHT+IGmikv+NaVfPEXD2chpCsLhKNIl6ktxCOnGHrDrYixaltKPt4dO/8fA9pWjvMWi1pDeMRjiD3FnAVNQm64Z+NQ=
X-Received: by 2002:a05:6902:114f:b0:e39:7170:c2ac with SMTP id
 3f1490d57ef6-e3dabac1b60mr1782031276.53.1733989788741; Wed, 11 Dec 2024
 23:49:48 -0800 (PST)
MIME-Version: 1.0
References: <20241211223822.2446254-1-sjg@chromium.org>
 <20241211223822.2446254-5-sjg@chromium.org>
In-Reply-To: <20241211223822.2446254-5-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 12 Dec 2024 09:49:12 +0200
Message-ID: <CAC_iWjKaywBv3qyk=fHNqH_anC3xT63Ua2=DMG2w1=LEt2vDLg@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] efi_loader: Add a version of efi_binary_run() with
 more parameters
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Moritz Fischer <moritzf@google.com>, Patrick Wildt <pwildt@google.com>
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
> This uses a few global variables at present. With the bootflow we have
> the required parameters, so add a function which accepts these. Update
> the existing function to call the new one with the globals.
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
> index 8febd325f34..8ebd48547cb 100644
> --- a/lib/efi_loader/efi_bootbin.c
> +++ b/lib/efi_loader/efi_bootbin.c
> @@ -209,18 +209,22 @@ out:
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
> +efi_status_t efi_binary_run_(void *image_ptr, size_t size, void *fdt,
> +                            struct efi_device_path *device,
> +                            struct efi_device_path *image)
>  {

This needs to be static here. Not the next patch. But I don't think we
need this at all (look below)

>         efi_status_t ret;
>
> @@ -236,6 +240,23 @@ efi_status_t efi_binary_run(void *image_ptr, size_t size, void *fdt)
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
> +       return efi_binary_run_(image, size, fdt, bootefi_device_path,
> +                              bootefi_image_path);
>  }

We don't need functions and wrappers for such a simple call. Just
update all the callisites with the extra parameters and keep one
function

Thanks
/Ilias
> --
> 2.34.1
>
