Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53AC9C61D85
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 17:38:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 965C287590;
	Tue, 21 Nov 2023 18:38:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Yv05+dX4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87B3487595; Tue, 21 Nov 2023 18:38:24 +0100 (CET)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4720087574
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 18:38:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6c4eb5fda3cso5913378b3a.2
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 09:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700588300; x=1701193100; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6+JZlqWz/1r54JnY1igSm/zzUzZ0EwHIgzwHJ+rnuyc=;
 b=Yv05+dX4hE3Xo935i09Ip+WW1bcXR9RG1D46EyJnRBRFJJILnFPLpngEGCkcvtT83g
 odogYx9kceWDUAvmJpV1AOjDA/ut4aybCmdCpuVrtFhT+Zi/7ADFbrw7KhLFTi9eUXHN
 YOriEBKRPirsj5ZQStFOsNuxt2LfSmdyGCAH5Z5ib684uIExEzsQlW/yr4i5eu++qnwp
 xJwGHDlhgDrnxGDiPa9iQl2HVdeq8u23Ol1DVuMXMgsKBqeAR9N03AC/Un8bh1vZkqEF
 a3pYbs6wdMewTzUT21iytfzATkaybmznb5eJiFHPCiJ9wKR+gmMdumm5CJEbG6yJ1iBs
 abtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700588300; x=1701193100;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6+JZlqWz/1r54JnY1igSm/zzUzZ0EwHIgzwHJ+rnuyc=;
 b=mYp0zYk7ZPJ6E1/PwJT+DGI1BfRxXa+OKa9528/1gUgKa1PqTywGFCLKeW5sn4yXOL
 JGGlkRudVqBQFqzuNdCdj33u0cEDWEUks/LSNFMymBEJLksh2OCiXR9SWZTOL2+UzpJC
 1fcVxv75ASU8TUkuej8wtTPH7pN/sDKg3vQ02HLWd6iDsu79A26UWLSEcHnM8lnAqftx
 QZhpguXNk8lYOwYfMBsOL5fGFPxlNkElD5x8yWpK3qNdRou363bcX/zN7LS5JXI0zIEx
 3SHdasn6X1MvjnFbhIhKGcbv21whMhVJLAHJCNLlljjWW2TwnQG6Ja9zYovWejeZfr6R
 sI6w==
X-Gm-Message-State: AOJu0YzUniUyyajqDJ1+Zfgo/nwn+JO7Ooc4JrOuusM3Fu8ni9IpeSLF
 XmKfZwTvdSDLn+L8NJjY3iHxRgoi9ki/hTJHRxIeaQ==
X-Google-Smtp-Source: AGHT+IG5sySGCQ0YgE2W/A6+Ikyu14XowG9OKnzqNBEgdFYB61sEi+Sv1VXHL0GsuLNxNXPmKmxdqFL0nOSs6zvJRNc=
X-Received: by 2002:a05:6a20:8fa6:b0:188:5e5:82e6 with SMTP id
 k38-20020a056a208fa600b0018805e582e6mr10054269pzj.61.1700588300590; Tue, 21
 Nov 2023 09:38:20 -0800 (PST)
MIME-Version: 1.0
References: <20231109201313.29791-1-semen.protsenko@linaro.org>
In-Reply-To: <20231109201313.29791-1-semen.protsenko@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 21 Nov 2023 11:38:09 -0600
Message-ID: <CAPLW+4kFgeUP+bvbPcLbTiakF-SmcnNj7Fu-H12Vtm_xKVbS6g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] board: samsung: Fix SYS_CONFIG_NAME configs in
 axy17lte Kconfig
To: Minkyu Kang <promsoft@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Dzmitry Sankouski <dsankouski@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Tom, Minkyu,

On Thu, Nov 9, 2023 at 2:13=E2=80=AFPM Sam Protsenko <semen.protsenko@linar=
o.org> wrote:
>
> There is a couple of issues related to SYS_CONFIG_NAME config in
> axy17lte Kconfig.
>
> 1. The global SYS_CONFIG_NAME in axy17lte Kconfig overrides
>    SYS_CONFIG_NAME for all boards specified after this line in
>    arch/arm/mach-exynos/Kconfig:
>
>        source "board/samsung/axy17lte/Kconfig"
>
>    Right now it's the last 'source' line there, so the issue is not
>    reproducible. But once some board is moved or added after this line
>    the next build error will happen:
>
>        GEN     include/autoconf.mk.dep
>      In file included from ./include/common.h:16:
>      include/config.h:3:10: fatal error: configs/exynos78x0-common.h.h:
>                             No such file or directory
>          3 | #include <configs/exynos78x0-common.h.h>
>            |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>      compilation terminated.
>
>    That's happening because axy17lte Kconfig defines SYS_CONFIG_NAME
>    option in global namespace (not guarded with any "if TARGET_..."), so
>    it basically rewrites the correct SYS_CONFIG_NAME defined in the
>    hypothetical boards which might appear after axy17lte in mach-exynos
>    Kconfig.
>
> 2. Another side of the issue is that SYS_CONFIG_NAME is defined
>    incorrectly in axy17lte Kconfig:
>
>        config SYS_CONFIG_NAME
>            default "exynos78x0-common.h"
>
>    The .h extension should not have been specified there. It's leading
>    to a build error, as the generated include file has a double '.h'
>    extension.
>
> 3. Each target in axy17lte/Kconfig defines its own SYS_CONFIG_NAME. But
>    all of those in fact incorrect, as corresponding
>    include/configs/<CONFIG_SYS_CONFIG_NAME>.h header files don't exist.
>
> 4. The global SYS_CONFIG_NAME pretty much repeats the help description
>    from arch/Kconfig and doc/README.kconfig.
>
> Corresponding defconfig files (a*y17lte_defconfig) fix above issues by
> overriding SYS_CONFIG_NAME and correctly setting it to
> "exynos78x0-common".
>
> Fix all mentioned issues by removing the incorrect global
> SYS_CONFIG_NAME and instead specifying it (correctly) in SYS_CONFIG_NAME
> options for each target instead.
>
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> Fixes: 3e2095e960b4 ("board: samsung: add support for Galaxy A series of =
2017 (a5y17lte)")
> ---

If this series (v2) looks good to you, can you please apply it? It's
needed for the new Exynos dev board port I'm working on right now, and
expect to submit the patches soon.

Thanks!

> Changes in v2:
>   - Don't just remove global SYS_CONFIG_NAME, also fix SYS_CONFIG_NAME
>     for each target in Kconfig
>
>  board/samsung/axy17lte/Kconfig | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
>
> diff --git a/board/samsung/axy17lte/Kconfig b/board/samsung/axy17lte/Kcon=
fig
> index a018547ff5d4..64a4ffa7e673 100644
> --- a/board/samsung/axy17lte/Kconfig
> +++ b/board/samsung/axy17lte/Kconfig
> @@ -1,11 +1,3 @@
> -config SYS_CONFIG_NAME
> -       string "Board configuration name"
> -       default "exynos78x0-common.h"
> -       help
> -         This option contains information about board configuration name=
.
> -         Based on this option include/configs/<CONFIG_SYS_CONFIG_NAME>.h=
 header
> -         will be used for board configuration.
> -
>  if TARGET_A5Y17LTE
>  config SYS_BOARD
>         default "axy17lte"
> @@ -16,7 +8,7 @@ config SYS_VENDOR
>         default "samsung"
>
>  config SYS_CONFIG_NAME
> -       default "a5y17lte"
> +       default "exynos78x0-common"
>
>  config EXYNOS7880
>      bool "Exynos 7880 SOC support"
> @@ -33,7 +25,7 @@ config SYS_VENDOR
>         default "samsung"
>
>  config SYS_CONFIG_NAME
> -       default "a5y17lte"
> +       default "exynos78x0-common"
>
>  config EXYNOS7880
>      bool "Exynos 7880 SOC support"
> @@ -50,7 +42,7 @@ config SYS_VENDOR
>         default "samsung"
>
>  config SYS_CONFIG_NAME
> -       default "a3y17lte"
> +       default "exynos78x0-common"
>
>  config EXYNOS7870
>      bool "Exynos 7870 SOC support"
> --
> 2.39.2
>
