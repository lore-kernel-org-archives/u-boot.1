Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4516C001E0
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 07:13:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 034938773C;
	Mon, 23 Oct 2023 09:13:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Z0qQHAgx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50DF38769C; Mon, 23 Oct 2023 09:13:00 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C59BC87895
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 09:12:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-507b18cf2e1so3983605e87.3
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 00:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698045177; x=1698649977; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1E/BofI/xjurw6qNJCB6F230Dl4vSa5B4t2d7GNEd5U=;
 b=Z0qQHAgxzpXgjP1GqfaQ739FvvWPRTzS1t0g8u1PWP+0nSwZbIGl7Gwq1Jb4bnhdLd
 Xgb+D2GT+yOMxE2BQNJyoJv+nU2nfKQfoWWH/V6iM/3Qg1YiPZV4rambb6l07fh/V8/c
 j+6SaaV445q3VdxQKP9AdLRFHVoA2n7H+djXygiXoUljSJmgzRWkqjbf6Om5Bp4BAzC4
 UQWP60U9yNgdN6ehGAURj6GQ0ddQwNuJIagWomqbaTEnGaqgRiBwdMYUVTjihZbCXdMq
 1ihzluLYxsgWtPqHzwrhiA0Xa13in1/kKGPVDYaIbrqdYPNQGvX1KcVPt/oUZ1jYcogy
 /shA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698045177; x=1698649977;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1E/BofI/xjurw6qNJCB6F230Dl4vSa5B4t2d7GNEd5U=;
 b=m24yxVJ5hUQ+r2tQUtQaYQ3QBePwUHJAdeeX1wvTV/F0oLFpg6DH4uBARtHVfwpoio
 lLJRM1DKHTBbondawLDGyvD0FKNsovJeO0uSgIkyNFtnSixAvsef9GcfyVqh4EApAT+I
 nj+KxWmY2aCpB4fgFe9gTGaefaeagL4koJJOkjSKEzwf0hGl183UDknYIVVjxLqClm0s
 bRczIJJ58xVkL3wPLi4qBiDc69Nw6oXs4inVdP6PFxPq6rs7vrTid7rBiNfRSGE/ZqdA
 D2eQIskSskZMOG8bPIYr+rAiqOKGUmH/1dlyX9kbLIvWFcYxtCw+7h6aeVUG9wALcSi2
 +Wtw==
X-Gm-Message-State: AOJu0YyYb3VNxvf0npidyT/5J2gHRQL6A3fFDwU88rF+U2tyn63dXxRP
 SJpDYz551YbyMKnOs9CRZo0nEHFWmORIzHi2CX7Tdw==
X-Google-Smtp-Source: AGHT+IEHuTpapBqGtAtHfp9ggiC2RxnVjEh1vK8WjvF474h40g3ooTJ+sBVe1vh6zHpg8ON7pox8R096hVqfdihVWGU=
X-Received: by 2002:ac2:53bb:0:b0:507:9855:bc68 with SMTP id
 j27-20020ac253bb000000b005079855bc68mr6237036lfh.37.1698045176982; Mon, 23
 Oct 2023 00:12:56 -0700 (PDT)
MIME-Version: 1.0
References: <20231022062012.97271-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231022062012.97271-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 23 Oct 2023 10:12:20 +0300
Message-ID: <CAC_iWjJ2FeFFX-ZhrnZocAucHpXRmmM0MoAvMB5qNN2KJdUziA@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: fix efi_dp_from_eth
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Sun, 22 Oct 2023 at 09:20, Heinrich Schuchardt <
heinrich.schuchardt@canonical.com> wrote:

> When compiling the sandbox with CONFIG_LTO=n, CONFIG_NET=n an error is
> reported:
>
>     /usr/bin/ld: lib/efi_loader/efi_device_path.o:
>     in function `efi_dp_from_eth':
>     lib/efi_loader/efi_device_path.c:985:(.text+0xcf4):
>     undefined reference to `eth_get_dev'
>
> Add a missing configuration check.
>
> As the function is exported __maybe_unused can be removed.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/efi_loader/efi_device_path.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/lib/efi_loader/efi_device_path.c
> b/lib/efi_loader/efi_device_path.c
> index ed7214f3a3..f3a0e855b3 100644
> --- a/lib/efi_loader/efi_device_path.c
> +++ b/lib/efi_loader/efi_device_path.c
> @@ -977,11 +977,14 @@ struct efi_device_path *efi_dp_from_uart(void)
>         return buf;
>  }
>
> -struct efi_device_path __maybe_unused *efi_dp_from_eth(void)
> +struct efi_device_path *efi_dp_from_eth(void)
>  {
>         void *buf, *start;
>         unsigned dpsize = 0;
>
> +       if (!IS_ENABLED(CONFIG_NETDEVICES))
> +               return NULL;
> +
>         assert(eth_get_dev());
>
>         dpsize += dp_size(eth_get_dev());
> --
> 2.40.1
>
>
 Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
