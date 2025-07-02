Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1475C83013
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 12:21:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBCE680E9A;
	Wed,  2 Jul 2025 14:21:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FcVrz6YI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A94F82103; Wed,  2 Jul 2025 14:21:31 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B2C9800D7
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 14:21:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-711d4689084so73052527b3.0
 for <u-boot@lists.denx.de>; Wed, 02 Jul 2025 05:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751458888; x=1752063688; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nfj8NVPltGGbYiP/MshSYoPeUDuCIMwbDGbK/1MyAfs=;
 b=FcVrz6YIbb31bj8upQhRTDNJGWsHPHbUfwwQqAD5wU80Nx0gu5lRBmK2khZzY3Q4jR
 HVTV6vwEp+SI5iLznrITinPwuA1N3p6BWFbBoAtjir6MecsVSeIVX9Y4MxnvvrSLty2K
 lXVRGdkoT3M9kY4EYqax6pI9U4UaMonuwX/mw+i2UzU3HfSOagytSFhSpG6N1Ln1SK1K
 Y+Sn6/21u5eBznAhO6H2xlJdI4Abd+aZTK/mHv0hlFXmoHEHd+3ZtSO7i9ixXBF347rH
 b6ykTQkUn2uvGjwOot85EW7gTMBfStZDuE7i1uyPp4XZb1E+Md3W4zUOntI2DdlkGlNx
 4wJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751458888; x=1752063688;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nfj8NVPltGGbYiP/MshSYoPeUDuCIMwbDGbK/1MyAfs=;
 b=Cj8pqm74uxwbFRBbEmcgZket2H4oDBlnM38D8p5uZUjTLFAkSYOYMM79TETf9BwBCM
 XZXom1GbtBrpkMyBprWL21EiQT/bBdEF+oVXfBDMDcmreIomab1mxS/Jz4Atrdxj7I35
 7iudhDxc6EsLO/wAf83QsP8dLnuuIqXU6aBTR+KcwBizQlBMTsSr/ioUJFNZsIhVV16X
 VdT3Yon2qXr7uOaLIGVZZ8TNeCZoLxmc/+LCnw1Wu6bno+yjkJ8dORoKSRomVjhouO04
 xZ9tX8dV53Kw6NDjlgPGe7Afg+hN50jzBdNtaBo6kMi5VNoTB+Eo1dQjPr9If9KaJEWR
 IBgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHnmu1xfZq/W7rCnam0IzYi4amrMTJSqRWPUTLHq68RjoM71/r39bOmidMavV6zVFVICQwxVk=@lists.denx.de
X-Gm-Message-State: AOJu0YymlqPcffHxJU+3eeDkG8C90DRmfHyd4KKTiOxddbW+o0yBfTMW
 7u81Wgkz743iQIOLeig9ts4TEZEgByS54JP0NkLJIYPny779QxjgMaZKMo+Ddcr7iw+IX9+gj6y
 9W8SLLbF2ACJls/0QmSZHPMVFvDiL0BbEygZPlxOutA==
X-Gm-Gg: ASbGnctVdXvRFkisqGzRNQA6KfqkVtxJDlSPoByx/UmA1H/A2r6COtJT8AZjJ16Z2jq
 coAgyPfGNKAh9zJpfaUUpdLhoE2atJrRY2lk0kkvpG5hntMkFYyDyuJwOLaCB4iOriNAPgk8fHR
 IBHxBDzsY4hyO5C/y9JCNLm+cV7gwaLDysg6QPAIaYI3ay
X-Google-Smtp-Source: AGHT+IE9JyzgUKmoXYXgDhcnl8IGH2TGAYi9n405DuwdX0oi546yWUTHQVzmFT3tuXs0Iiz5wzRByf9qPZ8as/to2ZA=
X-Received: by 2002:a05:690c:6603:b0:70f:87c5:5270 with SMTP id
 00721157ae682-7164d4ce2b0mr34918027b3.19.1751458887993; Wed, 02 Jul 2025
 05:21:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250701-efiloader_fix-v2-0-eb6db16bbe4e@linaro.org>
 <20250701-efiloader_fix-v2-2-eb6db16bbe4e@linaro.org>
In-Reply-To: <20250701-efiloader_fix-v2-2-eb6db16bbe4e@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 2 Jul 2025 15:20:52 +0300
X-Gm-Features: Ac12FXxxTXYNeR8k-3DABLiMKJRb_5rtVQuJDzwnQEcGckayAQD4g39StF5Oq8Q
Message-ID: <CAC_iWjK-3hq4KUoEDj5Yv4uk-tJfP-BbiXxgR+3Kd=929YCGLA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] efi_loader: Prevent dereference of uninitialised
 variable
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Adriano Cordova <adrianox@gmail.com>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

Thanks Andrew

On Wed, 2 Jul 2025 at 13:01, Andrew Goodbody <andrew.goodbody@linaro.org> wrote:
>
> If phandler is returned as NULL from efi_search_protocol then
> protocol_interface is never assigned to. Instead return
> EFI_UNSUPPORTED as per the spec.
>
> This issue found by Smatch.
>
> Also eliminate the use of the variable protocol_interface as it is not
> needed.
>
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>


>  lib/efi_loader/efi_http.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/lib/efi_loader/efi_http.c b/lib/efi_loader/efi_http.c
> index 189317fe2d2..9a0f2675132 100644
> --- a/lib/efi_loader/efi_http.c
> +++ b/lib/efi_loader/efi_http.c
> @@ -453,7 +453,6 @@ static efi_status_t EFIAPI efi_http_service_binding_destroy_child(
>         efi_status_t ret = EFI_SUCCESS;
>         struct efi_http_instance *http_instance;
>         struct efi_handler *phandler;
> -       void *protocol_interface;
>
>         if (num_instances == 0)
>                 return EFI_EXIT(EFI_NOT_FOUND);
> @@ -463,18 +462,18 @@ static efi_status_t EFIAPI efi_http_service_binding_destroy_child(
>
>         efi_search_protocol(child_handle, &efi_http_guid, &phandler);
>
> -       if (phandler)
> -               protocol_interface = phandler->protocol_interface;
> +       if (!phandler)
> +               return EFI_EXIT(EFI_UNSUPPORTED);
>
>         ret = efi_delete_handle(child_handle);
>         if (ret != EFI_SUCCESS)
>                 return EFI_EXIT(ret);
>
> -       http_instance = (struct efi_http_instance *)protocol_interface;
> +       http_instance = phandler->protocol_interface;
>         efi_free_pool(http_instance->http_load_addr);
>         http_instance->http_load_addr = NULL;
>
> -       free(protocol_interface);
> +       free(phandler->protocol_interface);
>
>         num_instances--;
>
>
> --
> 2.39.5
>
