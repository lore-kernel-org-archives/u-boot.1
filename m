Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9816C197A0
	for <u-boot@archiver.kernel.org>; Mon, 20 Nov 2023 07:58:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA48A870A4;
	Mon, 20 Nov 2023 08:58:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="r5RgGrOz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E433870D9; Mon, 20 Nov 2023 08:58:04 +0100 (CET)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CD288708C
 for <u-boot@lists.denx.de>; Mon, 20 Nov 2023 08:57:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2c878e228b4so14973971fa.1
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 23:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700467070; x=1701071870; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DGC3xf83m9FUTwlIqbILkF8AVMYv3h/318ej1U6XMcU=;
 b=r5RgGrOzGrX0ctRNOD+ZijTRqL0HWjpb/vaS9Zd1F3c43RZBHn4hqU7vRb+/v8ZlCJ
 seurJxwKpOdYAsTNpVeHLoVLZnhM8upauvc8Lj1IjEOKmc5OivOjU0NBX/eK1MAeTMYc
 sBNWxWmjivTk+5oYn3Ee/AYZNVk96/Q6uFfASdGEmJMpfBxlL7Ok0/+DpiEo2O2IV+ij
 F/3j9jTMgON+RNzjmtWNpxRChvm0w4llrLN1F1STRmc3krP5Tjn2mVdmVbac8MC4AD6r
 NxzLcKXFZW6PL21dITG+soTw9LpxCukB81JMA7cxHauarwGUg0BndLNOWA7V57ClUof/
 n8Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700467070; x=1701071870;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DGC3xf83m9FUTwlIqbILkF8AVMYv3h/318ej1U6XMcU=;
 b=uto1xLi+ntMQ7YjjDsJ0S6+jb7aEMne41cttzewuOWEH7vpCEw1XNMSiPP6AsjDcyp
 F3lFMljz+fRsXkzz9Tec7O05Q1aVa0ensJ3cAi6HkIcnElt81t2GlIqQEcXD/9ca+DiR
 4oNnpVqlarLabqzYdkyDkfX5c369hmrFJPHkAtuj1Kyr5pOHsUas1dMfXKG+1xeepFKW
 EHP7L5QSZ1BU1MZ3BY3eVs4Nu8T9loipP/Ie3O0jKcwIlCfFMo8Zo5Tb6BwEeHlKvh5/
 HAb3R9dog37b1SJEavrTRnQ+yYE6YfMas6glJiZIL/sa8ROSvEyOyeqM4EEEQ2okUeRz
 0ybQ==
X-Gm-Message-State: AOJu0YwRnHV2cMYCTavnxxu3jMoRpg916cg9lAa8q5gG7XnvlJTG3lyW
 Kx/aJp809KiHLkoAQTHzZdieKrT0M5C32agKF5mf3g==
X-Google-Smtp-Source: AGHT+IH3qtWitQP8/LbNLe8dj7uhXkgZWE55Z20MEsPqqFM6PRu36u+0hCTJt7TiFFwa9rsNWofaQ64R0AOVISq4qWU=
X-Received: by 2002:a2e:8ecc:0:b0:2c6:eb1c:10d1 with SMTP id
 e12-20020a2e8ecc000000b002c6eb1c10d1mr4574380ljl.25.1700467069577; Sun, 19
 Nov 2023 23:57:49 -0800 (PST)
MIME-Version: 1.0
References: <20231118114032.19098-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231118114032.19098-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 20 Nov 2023 09:57:13 +0200
Message-ID: <CAC_iWjLrCnr0N4Sa_c8Vmr_U4HyFy5rYhvjE1pmHfFmnO3axWg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] cmd: eficonfig: create shortened boot options
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Masahisa Kojima <masahisa.kojima@linaro.org>, u-boot@lists.denx.de
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

On Sat, 18 Nov 2023 at 13:40, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The boot options created by eficonfig should use shortened device-paths to
> avoid problems if drives are enumerated in a different sequence.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         Correctly handle the case that dp_volume does not refer to a block
>         device.
> ---
>  cmd/eficonfig.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/cmd/eficonfig.c b/cmd/eficonfig.c
> index e6e8a0a488..34a59cb15d 100644
> --- a/cmd/eficonfig.c
> +++ b/cmd/eficonfig.c
> @@ -528,7 +528,10 @@ struct efi_device_path *eficonfig_create_device_path(struct efi_device_path *dp_
>         p += fp_size;
>         *((struct efi_device_path *)p) = END;
>
> -       dp = efi_dp_append(dp_volume, (struct efi_device_path *)buf);
> +       dp = efi_dp_shorten(dp_volume);
> +       if (!dp)
> +               dp = dp_volume;
> +       dp = efi_dp_append(dp, &fp->dp);
>         free(buf);
>
>         return dp;
> --
> 2.40.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
