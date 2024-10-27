Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F4DD13577
	for <u-boot@archiver.kernel.org>; Sun, 27 Oct 2024 17:44:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A363C8841E;
	Sun, 27 Oct 2024 18:44:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jgvZUYUy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C5398852D; Sun, 27 Oct 2024 18:44:18 +0100 (CET)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EBB88839A
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 18:44:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-71e5a1c9071so2668626b3a.0
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 10:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730051052; x=1730655852; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fcjDD/zh1z6lUnPcDfCuBnU4dYdTfY0JjRfbXdAg9WA=;
 b=jgvZUYUyRZf+Tqug698n2OKEsYZM1GmAk+ueQx+BUi0HTchknnhGIe/xA6po8iP790
 9I1JR9KKgAOlAbnYOLUHMeR5VL7dn9gcEcihtDbEEdStBSD1e6BjcDABB0k5lCvR1cy6
 tk4b0ZqmyfKXBqoCkS6QAXMN14mxbqWsNloY9b6YjWtIty0o0PGPI8CzLzBhpl0x2ylH
 Wk4uKsiF+uwukgOia+c71oQSVPA7YgY0eXsWH9jraNyiqd2DMzN7W/KvxSWGdQU0CEey
 NCsJLolJtjIP4vMUm4PFgKcG6SLv3zrBif73t9W7j3QiFHUDt3uDjZh4nT4AJpkXHcY/
 C+eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730051052; x=1730655852;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fcjDD/zh1z6lUnPcDfCuBnU4dYdTfY0JjRfbXdAg9WA=;
 b=b6Amvpsi3ZplvFDgpxG2L0at0IH+sDYdIJWpJ0Ywfnv+NyYAvjCufAygJCh8U4+nFk
 PWWcCwiT/TLUz/XeadTHeWkzozfyP0KYMf2vT9x1+6ya3Qtgj0TzjhEu6JLWT8zvUZZp
 h3w6ezW1C+AJG0NMJap5M4sboFupkAzum3p6+dGh9P33exto0plp7DztYbePhuAQ+FMp
 CQV3UUBVFT7EvilEJkXpglqqkLws+WgeM5lbIzcvWTrqEM6OhCz/LBmzS8aE5iupTnBG
 Oz2OspD/y0wUt9IRJhbOk+UGSiCvbeT6D3MMYy+g5MRLoYwd6Q9UgprTwkJW4lqOtAOs
 FpHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWA219k9bH9YgA1jaqU09abIFeDEGn+hznQHL5x7Y0CMRNebgSFtVj5mfFV+K0xHRbg4gGs2oY=@lists.denx.de
X-Gm-Message-State: AOJu0YxuYzJryLjPR0gKMHH64zWg77pfCz+6qK6xCGYtBTUdkSLIfSQ0
 unFJCfNGhZd/otDcsmcWUSyY0DTlwNah3DjQe0OBjWckz2/LELaYSkehuRgcN13P77jolHae8vr
 VIcHTH7+rh9ipnCdutbOPQbGod9bk9Au6JShcNA==
X-Google-Smtp-Source: AGHT+IEfgy2xjkJcv+VjogOqksgLmvJdwaypuX15Pw58fZ9lQJIRF5wIk1aqnYCSwrds5icGDZn8+NXaBtM+f3xwY8E=
X-Received: by 2002:a05:6a00:1303:b0:71e:7636:3323 with SMTP id
 d2e1a72fcca58-72062f81c4dmr9700911b3a.7.1730051051693; Sun, 27 Oct 2024
 10:44:11 -0700 (PDT)
MIME-Version: 1.0
References: <20241026064048.370062-1-heinrich.schuchardt@canonical.com>
 <20241026064048.370062-5-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241026064048.370062-5-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sun, 27 Oct 2024 19:43:35 +0200
Message-ID: <CAC_iWj+0kk7KD+uygh=qx-jHucH=uOQdp-GgE9SGXuYZB_5AfA@mail.gmail.com>
Subject: Re: [PATCH 4/5] efi_loader: fix GetInfo and SetInfo
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Richard Weinberger <richard@nod.at>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
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

On Sat, 26 Oct 2024 at 09:41, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> * Some of our file system drivers cannot report a file size for
>   directories. Use a dummy value in this case.
> * For SetInfo the UEFI spec requires to ignore the file size field.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/efi_loader/efi_file.c | 30 ++++++++++++++++++++----------
>  1 file changed, 20 insertions(+), 10 deletions(-)
>
> diff --git a/lib/efi_loader/efi_file.c b/lib/efi_loader/efi_file.c
> index c92d8ccf004..95b3c890ee9 100644
> --- a/lib/efi_loader/efi_file.c
> +++ b/lib/efi_loader/efi_file.c
> @@ -864,8 +864,16 @@ static efi_status_t EFIAPI efi_file_getinfo(struct efi_file_handle *file,
>                 }
>
>                 ret = efi_get_file_size(fh, &file_size);
> -               if (ret != EFI_SUCCESS)
> -                       goto error;
> +               if (ret != EFI_SUCCESS) {
> +                       if (!fh->isdir)
> +                               goto error;
> +                       /*
> +                        * Some file drivers don't implement fs_size() for
> +                        * directories. Use a dummy non-zero value.
> +                        */
> +                       file_size = 4096;
> +                       ret = EFI_SUCCESS;
> +               }
>
>                 memset(info, 0, required_size);
>
> @@ -976,14 +984,16 @@ static efi_status_t EFIAPI efi_file_setinfo(struct efi_file_handle *file,
>                 }
>                 free(new_file_name);
>                 /* Check for truncation */
> -               ret = efi_get_file_size(fh, &file_size);
> -               if (ret != EFI_SUCCESS)
> -                       goto out;
> -               if (file_size != info->file_size) {
> -                       /* TODO: we do not support truncation */
> -                       EFI_PRINT("Truncation not supported\n");
> -                       ret = EFI_ACCESS_DENIED;
> -                       goto out;
> +               if (!fh->isdir) {
> +                       ret = efi_get_file_size(fh, &file_size);
> +                       if (ret != EFI_SUCCESS)
> +                               goto out;
> +                       if (file_size != info->file_size) {
> +                               /* TODO: we do not support truncation */
> +                               EFI_PRINT("Truncation not supported\n");
> +                               ret = EFI_ACCESS_DENIED;
> +                               goto out;
> +                       }
>                 }
>                 /*
>                  * We do not care for the other attributes
> --
> 2.45.2
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
