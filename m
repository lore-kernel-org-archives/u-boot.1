Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B4DDC77B7F
	for <u-boot@archiver.kernel.org>; Fri, 27 Jun 2025 08:53:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D806382E52;
	Fri, 27 Jun 2025 10:53:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QB+9p8cz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB21782EA5; Fri, 27 Jun 2025 10:53:20 +0200 (CEST)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F38682E35
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 10:53:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-710f39f5cb9so19842397b3.3
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 01:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751014394; x=1751619194; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=booPdE3qR/JxtqODSLobSgqZuvGEYP9WUivtmYbLI9o=;
 b=QB+9p8czv9ODEsVCr+LTkYI9zbaLVFbRyVG5iOR7VpweLk1cmD78Vzl49fKNH32MvJ
 YEHPB3fbB/a/3wM2WFnA/zm/Fqq4bGVC/wrdyMuBMJc0d9SeOyMGF/bxPGZwHpxC6iCY
 jhpqt/9Q5rJz9k+twvffz2KyfYyXUY874u3RaAhUdv8AveE+8QxWL2U0FTycPExiXznd
 jzb6c/q7DhgN5edtsLlkY6IZVahBkLBTfH0gWzB7CcBUE8I7err4xK1PB69oHs0b6Htt
 rBpKlLcOXYoeX4AsqL6VnuDBsJTJq6uyoJh8o8NLKTs2PBWAUeWX6r4OwXmTV0onkTjt
 WBYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751014394; x=1751619194;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=booPdE3qR/JxtqODSLobSgqZuvGEYP9WUivtmYbLI9o=;
 b=FYMWATNLWMr+wQNTCPQWBrdUMGNh8ljzfyDkUcwMdvdNKvqkNJHYommmtd7xlXjlK5
 qn+SVi/TsZOH/Y3OjZfKNtzJfuCxXMr9+7EQIWBuqn409cCOL/F2klkqYbNiDsA7CRUi
 HwOunE3srtD9C0J88MyPPJ1BNiA5hSTIIzreHAqDsYlch5jFLRMBQmNaq8f2TSJGrjSH
 TOMsyey+P4i5DcPDjVoiA6P3R857+9ysRTTti4dTD5XYnGrmGhJcufaLMYtfDDsG8iZW
 YavI5uz7Cf12D/ACqbfnpbToeMQGMidYqbXIYb47781VNRlZIA5pjPZDvmkCfHHMGQYH
 bCvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjIL/2K2iPirqolUzPXBeBQgBHLQkSFHZ5ak4KeIiiTC/xAJI99P5QZs8hsaybTATzJ7DF6u4=@lists.denx.de
X-Gm-Message-State: AOJu0YzgWpUMLoEuBUZFXffLpvC7FIBtUdc9UZMuAUFcj4luU5tMkK4w
 Vyxet4o0QPZxZf9DZI4Vcv4s6yDsdew6LU1soo9x4os5wrrg+QpSHQ1cyq7WrtlIJT1Vgnpdamv
 doLyT1oHSZ6oy6VsMx3Pw41xoRUHnMYda1AHbyP0thoKp2hkCg4vjm6w=
X-Gm-Gg: ASbGncuTRcCH1kIYKIEBoTuyqzwMl4J2OeE/b0ONJBkwUlt9nGGXVhL2BZeoB91iL6c
 mqJkp59AOpvMEY8yS1sI+SJnL1NHi/ETt/FowDPBq9alsgQ2RYnzxcx7W24d4LulSnRgZX5GOF+
 XGJKQzfeN5eII59jRtLfGjtSENX+yrylEiznJ3QFN6nxxM
X-Google-Smtp-Source: AGHT+IH/Q+pUJm3G330gAo3aZX0CkjsIm1hyFCJPPp05jqR93y69l1NRP1HHROwIgJBySCbePeRtO3FKVb+zDNxC3Jk=
X-Received: by 2002:a05:690c:d90:b0:70e:7ae4:5a21 with SMTP id
 00721157ae682-7151713eb3dmr35610237b3.4.1751014393951; Fri, 27 Jun 2025
 01:53:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250625-tpm_enum-v1-1-73a1aff0bd4c@linaro.org>
In-Reply-To: <20250625-tpm_enum-v1-1-73a1aff0bd4c@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 27 Jun 2025 11:52:38 +0300
X-Gm-Features: Ac12FXw9bWgClq-UjyaF7gOgjDpVhSQygFou9Xi5D6tUfsAeLQUNzVn4-VHOOdc
Message-ID: <CAC_iWj+5ikQ56G_tOrp39nP2+LnbmVuZ+AxOOHN_RD2A=qFBYw@mail.gmail.com>
Subject: Re: [PATCH] cmd: tpm: Fix attempt to return value not in enum
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Tim Harvey <tharvey@gateworks.com>, u-boot@lists.denx.de
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

Hi Andrew,

On Thu, 26 Jun 2025 at 12:57, Andrew Goodbody
<andrew.goodbody@linaro.org> wrote:
>
> The function tpm2_name_to_algorithm is defined as returning an
> enum for the algorithm specified but it also attempts to return
> an error on failure, but that error is not included in the enum.
> Add the error to the enum so that it can be returned.
>
> This issue was reported by Smatch.
>
> Fixes: 954b95e77ef0 (tpm-v2: add support for mapping algorithm names to algos)

This doesn't really fix a bug so please drop this.

> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>

The change itself is fine , but can you also change the callsites to
return TPM2_ALG_INVAL instead of -EINVAL?

Thanks
/Ilias


> ---
>  cmd/tpm-v1.c                 | 1 +
>  cmd/tpm_test.c               | 1 +
>  drivers/tpm/sandbox_common.c | 1 +
>  include/tpm-v2.h             | 1 +
>  4 files changed, 4 insertions(+)
>
> diff --git a/cmd/tpm-v1.c b/cmd/tpm-v1.c
> index 6e019d1c729..25402f7543b 100644
> --- a/cmd/tpm-v1.c
> +++ b/cmd/tpm-v1.c
> @@ -8,6 +8,7 @@
>  #include <malloc.h>
>  #include <vsprintf.h>
>  #include <asm/unaligned.h>
> +#include <linux/errno.h>
>  #include <tpm-common.h>
>  #include <tpm-v1.h>
>  #include "tpm-user-utils.h"
> diff --git a/cmd/tpm_test.c b/cmd/tpm_test.c
> index af83d78c3fe..1d9644d5aae 100644
> --- a/cmd/tpm_test.c
> +++ b/cmd/tpm_test.c
> @@ -7,6 +7,7 @@
>  #include <cpu_func.h>
>  #include <log.h>
>  #include <time.h>
> +#include <linux/errno.h>
>  #include <tpm-v1.h>
>  #include <linux/printk.h>
>  #include "tpm-user-utils.h"
> diff --git a/drivers/tpm/sandbox_common.c b/drivers/tpm/sandbox_common.c
> index 596e0156389..4bc003a2c09 100644
> --- a/drivers/tpm/sandbox_common.c
> +++ b/drivers/tpm/sandbox_common.c
> @@ -7,6 +7,7 @@
>
>  #define LOG_CATEGORY   UCLASS_TPM
>
> +#include <linux/errno.h>
>  #include <tpm-v1.h>
>  #include <tpm-v2.h>
>  #include <asm/unaligned.h>
> diff --git a/include/tpm-v2.h b/include/tpm-v2.h
> index ece422df0c7..6c516dd3c9b 100644
> --- a/include/tpm-v2.h
> +++ b/include/tpm-v2.h
> @@ -266,6 +266,7 @@ enum tpm2_return_codes {
>   * TPM2 algorithms.
>   */
>  enum tpm2_algorithms {
> +       TPM2_ALG_INVAL          = -EINVAL,
>         TPM2_ALG_SHA1           = 0x04,
>         TPM2_ALG_XOR            = 0x0A,
>         TPM2_ALG_SHA256         = 0x0B,
>
> ---
> base-commit: 903eb123236ccbd8ef05d43507a2a910b785bd56
> change-id: 20250625-tpm_enum-098ee9a5eb6b
>
> Best regards,
> --
> Andrew Goodbody <andrew.goodbody@linaro.org>
>
