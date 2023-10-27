Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DA2FC25B67
	for <u-boot@archiver.kernel.org>; Fri, 27 Oct 2023 12:24:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E4838771F;
	Fri, 27 Oct 2023 14:24:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="o+Z41OLu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D77CD87723; Fri, 27 Oct 2023 14:24:51 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF4B98757B
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 14:24:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-507cee17b00so2923718e87.2
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 05:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698409489; x=1699014289; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EMU0gLueMFg3DVm0WDolAT7EuzIN5OfVlX1oTej7tX0=;
 b=o+Z41OLuLHMytntWNzrH/BRxfDGhCb7KrwhSXDU/CQh2iYB3CUOgN5Go6tP4o73yJr
 LmMMJgTkPCPJvXCbB/bXYPcfNYgxlTLKw56pSNRp1zXBMTTfgYi1OsQa1GEMBWRwBadk
 +kv72fl1FsItA/3WQNURKE1qWkzTouNMA9SMvOY6+r6QIrnrgCcjF9zd4tQajMiUjhbN
 0bMhwU3hDMX5R4iBihyzaBZeGno8Leb0mR+bDSqGvHV1YxEuU9aXBPHBucO3266FjT4/
 sNfHFVRtNfUbFi0RD/YqqlGPV7hdO0FhdKLtZJr7/OUz6uyZxa3Om5WaPKHASY3AaB5a
 Uj9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698409489; x=1699014289;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EMU0gLueMFg3DVm0WDolAT7EuzIN5OfVlX1oTej7tX0=;
 b=lqNA8d8PuYUwUPvuGm1B6z/VCkxCpXNDLgsyg+hwuaTBW48wjfe/riUQK1fRnX21we
 WfYRqtjXXTvlAJiFXhnLqF2+G57ozbyNVThMf7j1an5jvaSUKq8rkcWr+TYPOOiipJdJ
 sl3GKSAK55kUmF+7n2tmZOBMvnDZFs8ThWw6w2qT7YJxjCvxRskIkl75XwHynigIbKEU
 StbKMYjFJT/f2kEzqs5iJMy1quvTNjBBU7cufQ5pgsWLLM/dM+LL7yALg4PX0GhVTdWA
 bDMoFGLrUmbt4d8sm5MGGqql9GOZIhmMVUSm3FR0LPsn2S/up/6OUYe6qY54k7cKgYWg
 Gxmg==
X-Gm-Message-State: AOJu0YybfSuNe8n7Og5D13+bS5WRAvyZ1ZnQhxNtDLG6LC8Y3E13Dn7Z
 LbUY/UhK0+/fzb+g0JqQz+X8ugvl3u9dWEFgrpHsMvXfthb8s/FsF5s=
X-Google-Smtp-Source: AGHT+IFRy/7bAEedNONReXRKc156OkBcu3amDbWRhWSZ8LGXjKjG3iqjzM/Jt7YiMYXEFcbAFZBsMMKiDPBpabc236I=
X-Received: by 2002:a05:6512:224d:b0:4fe:8ba9:4c4 with SMTP id
 i13-20020a056512224d00b004fe8ba904c4mr2409536lfu.59.1698409489231; Fri, 27
 Oct 2023 05:24:49 -0700 (PDT)
MIME-Version: 1.0
References: <20231026053052.622453-1-takahiro.akashi@linaro.org>
 <20231026053052.622453-13-takahiro.akashi@linaro.org>
In-Reply-To: <20231026053052.622453-13-takahiro.akashi@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 27 Oct 2023 15:24:13 +0300
Message-ID: <CAC_iWjL+ZQXx=gm0PQwPg1p8UufWfCwZ5TkgJeGZe0p5doDWxQ@mail.gmail.com>
Subject: Re: [RFC 12/13] lib: uuid: move CONFIG_RANDOM_UUID
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: trini@konsulko.com, sjg@chromium.org, xypron.glpk@gmx.de, 
 jbx6244@gmail.com, u-boot@lists.denx.de
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

On Thu, 26 Oct 2023 at 08:31, AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:
>
> This option is independent from any commands and should be managed
> under lib. For instance, drivers/block/rkmtd.c is a user.
>
> It would be better to remove this configuration.
>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
>  cmd/Kconfig | 7 -------
>  lib/Kconfig | 7 +++++++
>  2 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 3a8483f7d042..c42745d06b39 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -1143,13 +1143,6 @@ config CMD_GPT
>           Enable the 'gpt' command to ready and write GPT style partition
>           tables.
>
> -config RANDOM_UUID
> -       bool "GPT Random UUID generation"
> -       select LIB_UUID
> -       help
> -         Enable the generation of partitions with random UUIDs if none
> -         are provided.
> -
>  config CMD_GPT_RENAME
>         bool "GPT partition renaming commands"
>         depends on CMD_GPT
> diff --git a/lib/Kconfig b/lib/Kconfig
> index f6ca559897e7..b6d580c30615 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -74,6 +74,13 @@ config HAVE_PRIVATE_LIBGCC
>  config LIB_UUID
>         bool
>
> +config RANDOM_UUID
> +       bool "GPT Random UUID generation"
> +       select LIB_UUID
> +       help
> +         Enable the generation of partitions with random UUIDs if none
> +         are provided.
> +
>  config SPL_LIB_UUID
>         depends on SPL
>         bool
> --
> 2.34.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
