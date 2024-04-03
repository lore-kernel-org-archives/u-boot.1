Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EA06CD128A
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 15:37:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89F1B8838A;
	Wed,  3 Apr 2024 17:37:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rjX2El5S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EF0C8839F; Wed,  3 Apr 2024 17:37:56 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 419B187D1A
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 17:37:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-516c547fb4eso31003e87.0
 for <u-boot@lists.denx.de>; Wed, 03 Apr 2024 08:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712158673; x=1712763473; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FxFR6+CKPkFEb+a9JsHwGLpWWT6sTdKIurikwZ2136Q=;
 b=rjX2El5SHf3wOH9dECb9tQIjXk6bSkzGgYLlCHjtzL02oFjZj1S0/jeDfAYTRZITmJ
 uozp5eu0y8Bs6oeA1+C9kQ1A6EOQsb3DWFLkdQOGRxPpP/hg/h+b13PTDwpJNB48C0Z3
 YbsI2y4GPA8WBdt2/S4SoNbGoumJT3XjH83S1vR0sx4rCgCYO61RHrXeGAR0Hfl5uxFK
 6MvcGEbykIxpPH24De1jrtbmbjtMK6sPg9GyE/J9gMF+xwU3SbF8C0IZ0hKm0rD/75Ag
 iOBGtkhKNNrF8SJvuZi6B5WPpyAAAkRA+QlgIoC+op3XM7Jns1GpfPfCBPzOQPghJckQ
 K2Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712158673; x=1712763473;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FxFR6+CKPkFEb+a9JsHwGLpWWT6sTdKIurikwZ2136Q=;
 b=Yvnb89+8GBi6/nO9O/gua32pbfWGLonxb4IYRqtdNUTACp2hplzuDKtx5HvbzREGqu
 x1TgGew6Ju5Nb0pmFS5gApGUbx5UI1GeLx+SPRz3IPRpWnMi/ayIbqJcyR0frd4wM8+F
 S3eBArEVxJOIwZXCXnZ+yJybNN4TkH8JRyB6ZKrwkVnJVN2jrJB5YxxvfJRGQlBo53LN
 oxsACmJAx9InWNku2EpSbWx5VMAOiFAVIlKzB8MLsIJRdDASvR58mzXaxNF3vvNhQOGm
 wiQR8+q4BZhbSEZ//gy5MabbyDW4B5tjvDqg1G7//sQ3t5jnCv71QaPasrZn0aRhZiXF
 iTZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCuzyYSVYC7a2z3sO3BXdaRyO8WiJAS/Kk9lWQ2ArpBzPcdBhFfIRGf17E0h9ECIa7+h+YTxvHtVp1VdLojAkCozXpBQ==
X-Gm-Message-State: AOJu0YxwMYlYNXIXrvfIpSGte3YZk3Hwyv+rmQqRua81syeQs33yLV7+
 jnzWuY+UeaEN0THopHYDsx4YboMhVidTSir6V/lv5bpFFjdE4TFDvm2Vb8PZok7QymbxRNyNnUE
 1f8OwJiuoIsHOrwci6ajbAWGxa4BeOGhprJ23RC12z7plC4jop9U=
X-Google-Smtp-Source: AGHT+IHj6/tW/PRWrgx7tQ01njgetATo3haJiCb876cbfAOYtE15lP9Hiyho54GVxVjS/UwMiueXe8UYgbhd1tUrDoE=
X-Received: by 2002:a05:6512:3d27:b0:516:9f03:6a9a with SMTP id
 d39-20020a0565123d2700b005169f036a9amr9963552lfv.25.1712158673453; Wed, 03
 Apr 2024 08:37:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240403153335.96971-1-heinrich.schuchardt@canonical.com>
 <20240403153335.96971-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240403153335.96971-3-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 3 Apr 2024 18:37:17 +0300
Message-ID: <CAC_iWjK7OjdxsmCpuLW_FtEn1Mf+a9heD9s-KtbL2x0yuvxcjQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] efi_loader: EFI_VARIABLE_READ_ONLY should be 32bit
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Masahisa Kojima <kojima.masahisa@socionext.com>, u-boot@lists.denx.de
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

On Wed, 3 Apr 2024 at 18:34, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> GetVariable() and SetVariable() only accept a 32bit value for attributes.
> It makes not sense to define EFI_VARIABLE_READ_ONLY as unsigned long.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  include/efi_variable.h        | 2 +-
>  lib/efi_loader/efi_variable.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/include/efi_variable.h b/include/efi_variable.h
> index 805e6c5f1e0..42a2b7c52be 100644
> --- a/include/efi_variable.h
> +++ b/include/efi_variable.h
> @@ -8,7 +8,7 @@
>
>  #include <linux/bitops.h>
>
> -#define EFI_VARIABLE_READ_ONLY BIT(31)
> +#define EFI_VARIABLE_READ_ONLY 0x80000000
>
>  enum efi_auth_var_type {
>         EFI_AUTH_VAR_NONE = 0,
> diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable.c
> index efe17d98f5a..48ad813d79b 100644
> --- a/lib/efi_loader/efi_variable.c
> +++ b/lib/efi_loader/efi_variable.c
> @@ -276,8 +276,8 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
>                 /* attributes won't be changed */
>                 if (!delete &&
>                     ((ro_check && var->attr != attributes) ||
> -                    (!ro_check && ((var->attr & ~(u32)EFI_VARIABLE_READ_ONLY)
> -                                   != (attributes & ~(u32)EFI_VARIABLE_READ_ONLY))))) {
> +                    (!ro_check && ((var->attr & ~EFI_VARIABLE_READ_ONLY)
> +                                   != (attributes & ~EFI_VARIABLE_READ_ONLY))))) {
>                         return EFI_INVALID_PARAMETER;
>                 }
>                 time = var->time;
> --
> 2.43.0
>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
