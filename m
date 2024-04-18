Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C327BC4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 05:24:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEC9B88503;
	Thu, 18 Apr 2024 07:24:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="leYnbUxl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F13D8855A; Thu, 18 Apr 2024 07:24:48 +0200 (CEST)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 163FA884EA
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 07:24:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-518f8a69f82so508507e87.2
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 22:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713417885; x=1714022685; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wt4Zp9nM+Dh6YW486JBVRv+l1J5pN2iVSAThwAQKhqs=;
 b=leYnbUxltfeTULihTApmSmSdLkOPPKB229AyJ32d2OYCw60pSpnUbsNel6PedTrHV4
 okv+j3ah3fY9Pz3P1+O6AB4UBv5Cq6V3CE916aFlCX1ozThItgLltOxZEu2doH94VtaT
 F4Bxprk419I5NlxhYEsZxfh1tWr99uqSdB6X/3syhwblY3oYrZmsxyuRPqdyvNwsUzsx
 cgRlWTTAB58LysuH4S2aIju6+YxWAWfVMZlCBAGzhUTQYo63fFqHxoqgPW8N1PdfoPHW
 zsYZ++sJVAMc6iOuQm//6CGEIFBZYOEkk8apCF/zKEaYdEKbmW1+o1+xE0+3IuP1x7gx
 ORWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713417885; x=1714022685;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wt4Zp9nM+Dh6YW486JBVRv+l1J5pN2iVSAThwAQKhqs=;
 b=BYFbg0M6LYWkQ2OZ0T+0uFK44MXLGJT8l7Yzu1V+6EKTpFE5zMkdw0EWs3ZTKmbVDb
 ax6mYdXD5VzcX6MLRtI2Wfqdk3vLsr9p1UqLV/EpsuCpqCXxQWa1RSMOaP6DeNe6Kjpt
 YpSYPIhmQtAjIfuVeB50yzG2tD4k/1+olXukME9tJPockg4URo+9RNlt41uWoJ2xick5
 TJqAc3u2Ki07tvD4KjOwNYlNaFoNfRuxJ3p8RMFvNu8HxJDMHGpEYsrTNO6K5zP3hT8E
 X/0YdINetESJah9bR2RdcsSGGrUVs19hDbEnA54BqxkQdF9JCFBBi3DIiVeEbVMNi3/x
 AazA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXu5Jf8DpxTRkXxeyy2WnVTS0sY4JJdK0HOVwuCqQeKTJSpMV3tOQ12Z1lZjqvo0umUsOtp3teuQxS+GZIbv6jpajecGw==
X-Gm-Message-State: AOJu0YyqcEzb7o1JpArVYVVUD8U6eqASU+/Gs8k/DpZi9P+D6ImmJecw
 X3fPrX0Is40j0B6vqkNDcstW0rrP3KlRtS7tLVdz5XY5aBibsXRHOU8NXm2rybnye425ZMAVsCN
 37tB9vrcojaIzaGP6jUBE6cYpZdLymcYVlMfONA==
X-Google-Smtp-Source: AGHT+IH7a5Ume/7UTD7NhNbH4VYv69nlHAGWopjYWbD8tC70YVoNlUBnntUrlsjejfq5CYIuKM5zn3PbnYXl2GO4OLw=
X-Received: by 2002:ac2:5386:0:b0:513:ca77:82cc with SMTP id
 g6-20020ac25386000000b00513ca7782ccmr984244lfh.8.1713417885230; Wed, 17 Apr
 2024 22:24:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240418023202.11327-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240418023202.11327-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 18 Apr 2024 08:24:09 +0300
Message-ID: <CAC_iWj+B2UVZiiqVfjNBLDvgexE=5ixtmJF-pj3p9DAdNf2S9Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] efi_loader: typo mstching
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: "Reported-by : E Shattow" <lucent@gmail.com>, u-boot@lists.denx.de
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

On Thu, 18 Apr 2024 at 05:32, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> %s/mstching/matching/
>
> Reported-by: E Shattow <lucent@gmail.com>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         correct Reported-by line
> ---
>  lib/efi_loader/efi_var_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/efi_loader/efi_var_common.c b/lib/efi_loader/efi_var_common.c
> index aa8feffd3ec..ed53bcf3939 100644
> --- a/lib/efi_loader/efi_var_common.c
> +++ b/lib/efi_loader/efi_var_common.c
> @@ -419,7 +419,7 @@ void *efi_get_var(const u16 *name, const efi_guid_t *vendor, efi_uintn_t *size)
>  }
>
>  /**
> - * efi_var_collect() - Copy EFI variables mstching attributes mask
> + * efi_var_collect() - Copy EFI variables matching attributes mask
>   *
>   * @bufp:      buffer containing variable collection
>   * @lenp:      buffer length
> --
> 2.43.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
