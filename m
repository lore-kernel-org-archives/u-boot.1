Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D953C25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 15:49:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B6A3884A7;
	Tue, 28 May 2024 17:49:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fkZ0J4ez";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CA32884DC; Tue, 28 May 2024 17:49:35 +0200 (CEST)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF7838842A
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 17:49:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1f082d92864so7440325ad.1
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 08:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716911371; x=1717516171; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DsYpkPY0/BNQ0rsd0bMNQDITmSsj4f1Cxn9EZgVP5TQ=;
 b=fkZ0J4ezlJE4bcdBq6HB4CNGNM3Nfe+JFC6keTrZuZalYOgfgsqnnO0uImVEa53r+F
 sGOzEOLeTB9MorU915zZl33RdxTWRczPEZHAG41RaCB6d23sOhN1LBsv1hblsSkepb1w
 O0QgQzxRbEjqLOm+ek4WWTGAHCl7z22JZzOX9/c12UIwQD0+b1G6Bjv4Nejpzo3LPuCW
 eGHu0Y2O7x9TsqmMmZxyk8MT8yaImGRwZxRbMm+KGYsFFfJ1jr+NsnSg0dlVoDvL33rC
 7fNZ+D1nudK+3JM2GUKncUgpOH0gZQqdtbnxI5e/tV/+wDZpquByoDSHn4NkqnaIEaD2
 edWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716911371; x=1717516171;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DsYpkPY0/BNQ0rsd0bMNQDITmSsj4f1Cxn9EZgVP5TQ=;
 b=Jv+IzGrGTjB4XZBY8TV6/uqubtI777XEpSYq/SjnMXgth+CdqLYePBULtKTje8M1FT
 vJAY7r0Gmi5x76IP0OsD+wS9pa7EnqWU2nq5YAqQhMfdh5C8wPKxMg2dGqA5kqNBBon1
 IrCwKFqR8VFWzYb5m4UKKZ7F2HRMtJiNO4Xvwqc1Eais9k8k3Ydd02CVpSufcsmUd7VE
 KDkMxavadxVU9yt3jJCSxGz8A7ixFbfwVuD0KpvpB6LMQ8C9IPI1WrNSsukotVAJ8ZPC
 WY1TfD6mI3xsxX9xNkH6mJ8AoDlMBdLrei5+auk0zdP0Mdn8roQthVWq2kuzupJlXy1i
 nMYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXX2BRzYgwrHsw+T+IZm0846EkFdw9hLGNvuyxy79/dbxbLHPzOkCVAtes97SJQRHut2t78bCnH7IqsHxMnt/DLpekScw==
X-Gm-Message-State: AOJu0Yyb57IX9ivlRveii4MFXgAqaPao3dVDbWdRjyNhwIAApfCZs5Gc
 H4RcJHyQlj+pYjfabny2mkD9o6RlO0QIcH1g8DuZrHG2+Yyx8wNcTfOMzoZg2Km1GjIRhtcujtx
 wTR7nSJuHvZlTbM2IUZqVlJvFlcPgPVXd5rj89A==
X-Google-Smtp-Source: AGHT+IEQiZzRd8inK0Wvi+fKbtvmSY77nSx9cdmVjdMgwGrD4npVh5VG8O8Cp+M9+LLD09vGUHqPyQiZ2WdWJ6ssFfU=
X-Received: by 2002:a17:902:c945:b0:1f4:771d:a802 with SMTP id
 d9443c01a7336-1f4771daa10mr77039035ad.22.1716911371325; Tue, 28 May 2024
 08:49:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240528144252.179247-1-heinrich.schuchardt@canonical.com>
 <20240528144252.179247-8-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240528144252.179247-8-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 28 May 2024 18:48:54 +0300
Message-ID: <CAC_iWj+MHnvEH7AiG9H0KxbCSXxkxRHP=o1yRXqQqzYBWVQ8cw@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] efi_loader: export efi_load_image_from_path
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Shantur Rathore <i@shantur.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Raymond Mao <raymond.mao@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Bin Meng <bmeng@tinylab.org>, Mark Kettenis <kettenis@openbsd.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
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

On Tue, 28 May 2024 at 17:43, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> We can reuse this function to load the device-tree.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         Move unrelated changes to different patch.
> ---
>  include/efi_loader.h          | 4 ++++
>  lib/efi_loader/efi_boottime.c | 1 -
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 1b4bc987a23..ab7bed22971 100644
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
> diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
> index 630c5f52c4f..eedc5f39549 100644
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

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
