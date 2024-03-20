Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF72CC54E67
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 21:15:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4834E87D91;
	Wed, 20 Mar 2024 22:15:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="g+/5LPBq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E326C88049; Wed, 20 Mar 2024 22:15:27 +0100 (CET)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 087AA87A0B
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 22:15:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2d48d75ab70so4911441fa.0
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 14:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710969324; x=1711574124; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=efkX70iBNAZGKdrPzUJdq24gh4dOyV+1aunmW+9uoTc=;
 b=g+/5LPBq+rzmZD1szJEmSf+TOkcv4Fs9F7kaUTChXzeeYYv3TWrw8+Z8723NetURpq
 LDfFzA59ocJ4F52xTznLXZkG+yZWnRYsOiOD2UKpYnEZ1MPpF/0YndTmsxFClNqDd8YI
 k+r+KFFkDbVjtrpANLwnm+NbDD6h9XkXlHg9xowJ+DOkqlodEiNELP0LLBSnjal5l611
 vw0kSzOQ0lG1tG1TMZsoiHLPsnrBGVrFHhERFO8eQ4dNUWIhS+w7pKhSyGmd/ldGPRhz
 mzt9Vw8o8WTQUKXVJH0yhNF1R1Z21qAFqcd+8KAAkWMaYdVjUXu4W2rOaO1Vn0hoQJF3
 cjSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710969324; x=1711574124;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=efkX70iBNAZGKdrPzUJdq24gh4dOyV+1aunmW+9uoTc=;
 b=kMvDhLKaFFUVdjlMmQR+Hy159wn8M9Eb4TPhTNwpdH1ddOgC+sMKJ9/08k9zpddoyM
 Sz0YFAAVLpRS+QCf0+uOnRlbsDqZPQUzFxyA7GtNt4xf4YBJ580iACHjgprn9nSZpHaq
 MnqwtOUUgtpUD1PNXijsQyO7Sta2MVp7tUU07ijAubYU2pC59j7PTiJT1laos9iS3DbP
 gYGZRKY/LHg/Rp2oX+tClG10o42s3/NgQM87SO3C7ZR++Yjc2vm4y1ZbA2q8bIWI67E9
 Xdr7QyWh27iOquxNAvd4oO6R49RNzfjEqJq/tmZCwXUJTGJcJtLby+BbjjHSsGkJgixR
 zE4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXH5dOiqdlrcZMUgHzHkrnsTb8Aa+jhrYXnB+fcc8F7BWMqTmv3TpSSY9/X5WCtBVu8spzVGsm6zBAXgygu34EGMABNsg==
X-Gm-Message-State: AOJu0Yw1y59O1ip6sfslsQ1jsMuWH8efAvwfoozzGp3i1bVdOms5ZPql
 zgPuo0ixk+EopywBJZM/JmoltBxz+Prmj2bRaNi2gffefRcVBL3HO3mrYPPSHvihgWKAXgP4PWA
 qKSBj3HbtUZEl1GcMp9CdTAOmZ3zD24VOwo3Ro4G0t8G4sHDCUkw=
X-Google-Smtp-Source: AGHT+IE5gRkyy5OQrJp/BxwYLJzoBtQ3NvLlqmi3QhozIDlE/kl/JxGEaoLBbOQng4AuEatofkRIWpV1ZTgwHCCgWww=
X-Received: by 2002:a05:651c:2cc:b0:2d4:a74a:56f1 with SMTP id
 f12-20020a05651c02cc00b002d4a74a56f1mr85411ljo.35.1710969324127; Wed, 20 Mar
 2024 14:15:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240316093644.54869-1-heinrich.schuchardt@canonical.com>
 <20240316093644.54869-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240316093644.54869-3-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 20 Mar 2024 23:14:47 +0200
Message-ID: <CAC_iWjLvtKQmFM6uVQL4GLEHmZ2M9K00SE7oJAh+hVK9diT9wQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] cmd: bootefi: Don't show usage help if EFI binary
 fails.
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, u-boot@lists.denx.de
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

On Sat, 16 Mar 2024 at 11:37, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> If an EFI binary returns an error code EFI_INVALID_PARAMETER, we show the
> usage help for the bootefi command:
>
>     Shell> exit 0x8000000000000002
>     ## Application failed, r = 2
>     bootefi - Boots an EFI payload from memory
>
>     Usage:
>     bootefi <image address>[:<image size>] [<fdt address>]
>       - boot EFI payload
>     bootefi bootmgr [fdt address]
>       - load and boot EFI payload based on BootOrder/BootXXXX variables.
>
>         If specified, the device tree located at <fdt address> gets
>         exposed as EFI configuration table.
>
> This makes no sense.
>
> Fixes: 296faf4f7ef1 ("cmd: bootefi: re-organize do_bootefi()")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  cmd/bootefi.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/cmd/bootefi.c b/cmd/bootefi.c
> index 9cf9027bf40..b509440cde0 100644
> --- a/cmd/bootefi.c
> +++ b/cmd/bootefi.c
> @@ -154,9 +154,7 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int flag, int argc,
>             !strcmp(argv[1], "bootmgr")) {
>                 ret = efi_bootmgr_run(fdt);
>
> -               if (ret == EFI_INVALID_PARAMETER)
> -                       return CMD_RET_USAGE;
> -               else if (ret)
> +               if (ret != EFI_SUCCESS)
>                         return CMD_RET_FAILURE;
>
>                 return CMD_RET_SUCCESS;
> @@ -218,9 +216,7 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int flag, int argc,
>
>         ret = efi_binary_run(image_buf, size, fdt);
>
> -       if (ret == EFI_INVALID_PARAMETER)
> -               return CMD_RET_USAGE;
> -       else if (ret)
> +       if (ret != EFI_SUCCESS)
>                 return CMD_RET_FAILURE;
>
>         return CMD_RET_SUCCESS;
> --
> 2.43.0
>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
