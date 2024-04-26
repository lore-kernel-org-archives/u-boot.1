Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A4BCC4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 23:51:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 181DA8829B;
	Sat, 27 Apr 2024 01:51:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qooGFJoO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB204882D0; Sat, 27 Apr 2024 01:51:37 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC25288297
 for <u-boot@lists.denx.de>; Sat, 27 Apr 2024 01:51:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a4702457ccbso362481766b.3
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 16:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714175495; x=1714780295; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0NTe5EXq216olxUzm25KFdZfzOt66bVEJbFt2JsudOU=;
 b=qooGFJoOOovu15kwswB3fq1lgR9/9Ct2M+9h2K2NJLEMzT2vwjv8MdnMNTwOJnbw2t
 GkH3xBoldzAdEwx0CJaYXRF0g3mUwlLKIskbsGb6KRIzYaHGTaeCker8HcHBw1NLF4ye
 JUVnXK1oJjHN3mNsSzmwBqMQPbBZNT7WAUNDb0cIvWd5wugp9XOwys9rULyYQlsy4EVi
 aGZ8TjIYX2DvwnRZ5Ny8Fyywacycz8u4gvtp6tCIewgShn8ibsfAjSORKejksMyfFWsO
 rLj1iKj/0ryeijVns4iFFfvQhY6jdp+3twHGI6ng95zh/tDLEqUn1TEf+xYfWvxb4Oj1
 tvvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714175495; x=1714780295;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0NTe5EXq216olxUzm25KFdZfzOt66bVEJbFt2JsudOU=;
 b=GoSb8SU0rlXdTs8ZFnE6JUyzvol65eCBY+9Pd5g6YuUhzH1YNL7Hi9QH8jjssB0ouE
 D4rXIgymrWZos1N48Tlp1gsEhb9MsJ+gDB9xR8XYreL2JEhlAShhewwB0T0N1V+3Qzyf
 q8PU2zLyn12n2OOm+I78OLDeGjXMObdoT3/Oa6GdIDZxHLZw0rAbxA9Fs2bPpjdU2Duo
 LNi4GlwtT5HNYAt5CNIs+4DV0+DwOc8t4MepnMZ7B8CDoQlcw51pcAwsTrDzUU8oPCGT
 tpy+VlvIbTTt+Yz5qZAo9k3VqBzxYmUKuEJB2lYcgW+cdY4X2R8S6ftkmuO1pBIlfHaz
 l6vw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPxhGHJwM7k/yv+Xq6REyyHmeKQaWndpop5r9DxPA8oup2BHcdoPnOvA8pRN3A3tgh6yuIzJaHTQ9au5ejwagIIamKpA==
X-Gm-Message-State: AOJu0Yz+VSEpRw3oknXJcNhfNj6jTK0IXfo5TkKMsKHJJH65h9gft0dL
 L0ixUhkT3AYyTgIKSdiQ1kV0+Upa1p8NtEFm/+tL7THdh//bWUebCrxAJRgYv8RLpPv2viLnZvw
 z4lZ9H3vLmlYIe+fBOg5XuWYsQ1p0OE92fP6LYw==
X-Google-Smtp-Source: AGHT+IG6k9sj+k+ejFEq28Q0OHi6R8BOOPfCJF94i4jaEwUHJRIHjNXGSBKGU/8YsxFI5FXqUhORFN+asDwbITS6k9Q=
X-Received: by 2002:a17:906:3918:b0:a58:7e41:c65a with SMTP id
 f24-20020a170906391800b00a587e41c65amr2889078eje.25.1714175495072; Fri, 26
 Apr 2024 16:51:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240426141321.232236-1-heinrich.schuchardt@canonical.com>
 <20240426141321.232236-2-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240426141321.232236-2-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sat, 27 Apr 2024 02:50:58 +0300
Message-ID: <CAC_iWj+WT8_zZSaz2LOt8DcsRMpkeZOa=WF==-_RQytnvuBvpg@mail.gmail.com>
Subject: Re: [RFC 01/14] efi_loader: pass GUID by address to efi_dp_from_lo
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

On Fri, 26 Apr 2024 at 17:13, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> We should not pass GUIDs by value as this requires copying.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  include/efi_loader.h             | 2 +-
>  lib/efi_loader/efi_helper.c      | 4 ++--
>  lib/efi_loader/efi_load_initrd.c | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 69442f4e58d..9600941aa32 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -743,7 +743,7 @@ efi_status_t EFIAPI efi_register_protocol_notify(const efi_guid_t *protocol,
>  efi_status_t efi_file_size(struct efi_file_handle *fh, efi_uintn_t *size);
>
>  /* get a device path from a Boot#### option */
> -struct efi_device_path *efi_get_dp_from_boot(const efi_guid_t guid);
> +struct efi_device_path *efi_get_dp_from_boot(const efi_guid_t *guid);
>
>  /* get len, string (used in u-boot crypto from a guid */
>  const char *guid_to_sha_str(const efi_guid_t *guid);
> diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
> index 6918fd5e48a..c5d13c0f19c 100644
> --- a/lib/efi_loader/efi_helper.c
> +++ b/lib/efi_loader/efi_helper.c
> @@ -72,7 +72,7 @@ out:
>   *
>   * Return:     device path or NULL. Caller must free the returned value
>   */
> -struct efi_device_path *efi_get_dp_from_boot(const efi_guid_t guid)
> +struct efi_device_path *efi_get_dp_from_boot(const efi_guid_t *guid)
>  {
>         struct efi_load_option lo;
>         void *var_value;
> @@ -92,7 +92,7 @@ struct efi_device_path *efi_get_dp_from_boot(const efi_guid_t guid)
>         if (ret != EFI_SUCCESS)
>                 goto err;
>
> -       return efi_dp_from_lo(&lo, &guid);
> +       return efi_dp_from_lo(&lo, guid);
>
>  err:
>         free(var_value);
> diff --git a/lib/efi_loader/efi_load_initrd.c b/lib/efi_loader/efi_load_initrd.c
> index 67d1f75d525..d91135436c4 100644
> --- a/lib/efi_loader/efi_load_initrd.c
> +++ b/lib/efi_loader/efi_load_initrd.c
> @@ -63,7 +63,7 @@ static efi_status_t get_initrd_fp(struct efi_device_path **initrd_fp)
>          * We can then use this specific return value and not install the
>          * protocol, while allowing the boot to continue
>          */
> -       dp = efi_get_dp_from_boot(efi_lf2_initrd_guid);
> +       dp = efi_get_dp_from_boot(&efi_lf2_initrd_guid);
>         if (!dp)
>                 return EFI_INVALID_PARAMETER;
>
> --
> 2.43.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
