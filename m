Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D29F2C4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 10:20:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 440528869F;
	Fri, 26 Apr 2024 12:20:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OCRA1v11";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04657886A3; Fri, 26 Apr 2024 12:20:13 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 086F98869E
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 12:20:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a5557e3ebcaso331648566b.1
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 03:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714126810; x=1714731610; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DMsuRHK07RB9MMdtRKUh6BhrCYKw7jS4IFRy4LJDf4g=;
 b=OCRA1v111evORdzM8Vl8GwWq+Sk+g1wnnXP8oPn3keKoVS6OCgveLNlD9NplnPmDHQ
 RNm8Yxm4jjaisg8ZitySA6Olr7095Babt5f6GGHLLJYQ7Oh5n1TrM6+GWJHQCumxre7A
 rebVPaoteskJHAtMnyzOHfuToXtXqeMVg8d6O96XnucM50Dfwq3LcRFm/O3IcJPFfU2V
 0Bnd4NHGQeg5AEf4bB1KpYX9d0xxEN/4t9uRzD6Wnf7pRxi8PngdtlpPw0EOyphV4Z5d
 zgu8TBprIh773xf5vfcwZMaDeAAIausa23mjlpzxcIMRugwfFUoDfxklpzSGQE2+r0Ym
 6bvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714126810; x=1714731610;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DMsuRHK07RB9MMdtRKUh6BhrCYKw7jS4IFRy4LJDf4g=;
 b=vuo9/j6siaxNNJfKdeTGkVb2LWltkvPkJdfr1NW8NplOLE06NanCZgMufiWaue+ZB6
 ojlk0pP+tuA1GkWVY5c+C6CsOUKzbBEMC9CJbTFAsjcUqc7vqLENaML5DI1Ok+1DihkM
 CrT0Y+ReweFAXrt1Yz1G5s8tb1xnUqW1krljfnuPava0m2W2xaXYmXZ7uxsg4flsIia4
 TpO7/kQ/K/8ieCkHzNufx5Fs6zN79FdzGsa/HqwtQALvCiSK8ZPTjfdejtmzijRkP/A+
 9+UnmUu7x82U9820RQUd0tGIZh/NeQWPLG+PPJUnAjgTNw4+LacCwRTDyFQjKMWXzWZr
 O+SQ==
X-Gm-Message-State: AOJu0Yz9HnItDsrVZeYvOB5EvXbAVT5rLdXGVWEikeyZjmz4MNnnN23X
 pYbv2BjJRmL8Xgc/NjihRe66prrZmJrIj2VsPeXnbKTUU/8piuZpPhS+G/jJFyjIqTPCGsr/4bm
 FRrwNQJc5xZ2wKAQyK1R5jemb5mqD0a7ChUCyl0CF2ZCQmnNKALRghg==
X-Google-Smtp-Source: AGHT+IG2ZvmyRJET6AZmqvmKUo5AjPQp1xToG9H1ffefwE1NJfcLCUqPE3QqkRdaW+vYTg8rmmjgZ0zZMqhHvS2QwPE=
X-Received: by 2002:a17:907:77d9:b0:a58:9a67:967b with SMTP id
 kz25-20020a17090777d900b00a589a67967bmr4990938ejc.27.1714126810626; Fri, 26
 Apr 2024 03:20:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240426100938.89303-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240426100938.89303-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 26 Apr 2024 13:19:34 +0300
Message-ID: <CAC_iWj+wyOYf86jCTPWZae-_uvFV3ORH9D_qvhHANcCgCy_HPQ@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: fix description efi_dp_shorten
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
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

On Fri, 26 Apr 2024 at 13:09, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Use Sphinx style for return value.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/efi_loader/efi_device_path.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
> index 46aa59b9e40..aec224d8466 100644
> --- a/lib/efi_loader/efi_device_path.c
> +++ b/lib/efi_loader/efi_device_path.c
> @@ -102,7 +102,7 @@ int efi_dp_match(const struct efi_device_path *a,
>   * See UEFI spec, section 3.1.2 for "short-form device path".
>   *
>   * @dp:                original device-path
> - * @Return:    shortened device-path or NULL
> + * Return:     shortened device-path or NULL
>   */
>  struct efi_device_path *efi_dp_shorten(struct efi_device_path *dp)
>  {
> --
> 2.43.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
