Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9BB7E7717D
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 11:07:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D6BE8012C;
	Fri, 13 Dec 2024 12:07:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A/Zdzzrl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BAF980192; Fri, 13 Dec 2024 12:07:20 +0100 (CET)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E172800D6
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 12:07:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=heiko.thiery@gmail.com
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-30039432861so16787971fa.2
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 03:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734088038; x=1734692838; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fgp5VZqdk+6zGCiFSoyb8uDK8jcxFn3C6BobqpSsAmo=;
 b=A/Zdzzrlj2EjV63Hd9/hyeuFxysa0oB472mgxZo4OZws+glAZM1PjywA17FvWLjQh7
 5BZwnGcWXrO8axP7UUKClxuBjJeyy4Fd6YcPWD23pTNhUZufbEE7WVu1US23f1GuPCvp
 PBzaJ5BmUNMeIr/N5SbheGeZLiUp5Db+XvndkX8/y+bVxhCClPT62PjCooKwnlRE04G4
 Pv0HafEqO6nm+J3tt1scpQqs7nKFNf8jEPIOQAPcm+KVQ9PLPC58Y0nEupQ6Fmwjv0kz
 nNZo847ALsg19tp1vvbpaenBEqo+6StM93IvbM5kuC0q/1qHkFGh1iYqgYUNbamtapjN
 s73g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734088038; x=1734692838;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fgp5VZqdk+6zGCiFSoyb8uDK8jcxFn3C6BobqpSsAmo=;
 b=LFgbaekP4UFnQJ9BgJaiRx+pXutx/xZj/01eLdDiviU9SLdjC8cSozbeuoED1C9ZNf
 2og0hV9Zzs9YoJbZI7AqbPBzk9zmdmKRFXYbL3vZQwOnj7NUpWLVoln+Z7grObVHc0Xc
 uNRhAlxTwLD4xORLR3jBkshZQOdsRAFa1fTGnZYtni9MYKbSVrf2f6tojbqiKXmkbqa6
 dAxVK5oYMfiEhWz5NWYNEF9GKTEIpMvgTCTbQgg36xLAw0cHC9I7YNj10xaxJhjbz+Ve
 PcZCNE1OXCRo4WMX6xg+uZO0lQ3wJL0Kx677gTd0vkhiGH9RNhj3J0tPE/JchWbSPJE1
 hAqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+JaOu2EOWVzWrf/ZlhyuUj65g1JdMd1Y3HX9hcE/dSuUOQd+zOQ2I8ggeVteBkC9Ik5Obal4=@lists.denx.de
X-Gm-Message-State: AOJu0Yx8cC82jn1zAhlvKudHG0I/JoJFfmIUyOh3i1Wc4uRGGdB0/ttH
 ULz3Ve5B/GFySw1JuUnHmchglbWvYED24rTwXlnZGy5X88vI5DbsbBavPgHn1iBw8RH2m0mmN0J
 cruE8PNjT8+dFQrBlBLEr8fQCY2g=
X-Gm-Gg: ASbGncuwmX8eA8Hc6eoi8Vhp9HJd/V0NHRUdjOcb84g2fD/4UgcrDhZ4A932S4t21Im
 zfbzJvQjSS6bAxyHwIMavDkh+9WJVs+YNRP3qrAE=
X-Google-Smtp-Source: AGHT+IHfKXbzPnMFYeiV0E615+hfYZaadcjj69aXeqSEcD5Y1oIorOya7DxvQq32FDi8rLFAXyz+vk/oxRBOlrV+2bI=
X-Received: by 2002:a2e:a802:0:b0:302:350c:c630 with SMTP id
 38308e7fff4ca-302544cc849mr8649801fa.22.1734088037533; Fri, 13 Dec 2024
 03:07:17 -0800 (PST)
MIME-Version: 1.0
References: <20241213102321.2166920-1-mwalle@kernel.org>
 <20241213102321.2166920-4-mwalle@kernel.org>
In-Reply-To: <20241213102321.2166920-4-mwalle@kernel.org>
From: Heiko Thiery <heiko.thiery@gmail.com>
Date: Fri, 13 Dec 2024 12:07:05 +0100
Message-ID: <CAEyMn7ZvEA+zdgAu635p5NZ4ti_SChRbmrdapCCCfnKqRB9qSA@mail.gmail.com>
Subject: Re: [PATCH 3/5] board: sl28: fix network on variant 3
To: Michael Walle <mwalle@kernel.org>
Cc: Peng Fan <peng.fan@nxp.com>, u-boot@lists.denx.de,
 thomas.schaefer@kontron.com
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

Hi,

Am Fr., 13. Dez. 2024 um 11:23 Uhr schrieb Michael Walle <mwalle@kernel.org>:
>
> Network is broken on variant 3 boards since commit 61ff13283c3b ("board:
> sl28: move to OF_UPSTREAM") because it was removing the variant 3
> handling. That is because at that time the var3 device tree was not
> upstream. FWIW variant 3 is actually the same as the base variant, but
> I've missed that the -u-boot.dtsi is not inlcuded in this case which
> will set the ethernet alias.  Now that the var3 device tree is upstream,
> just re-add it to the SPL handling again.
>
> Fixes: 61ff13283c3b ("board: sl28: move to OF_UPSTREAM")
> Signed-off-by: Michael Walle <mwalle@kernel.org>

Reviewed-by: Heiko Thiery <heiko.thiery@gmail.com>

> ---
>  board/kontron/sl28/spl.c       | 3 ++-
>  configs/kontron_sl28_defconfig | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/board/kontron/sl28/spl.c b/board/kontron/sl28/spl.c
> index 45a4fc65120..6b31f5e3a7c 100644
> --- a/board/kontron/sl28/spl.c
> +++ b/board/kontron/sl28/spl.c
> @@ -50,9 +50,10 @@ int board_fit_config_name_match(const char *name)
>                 return strcmp(name, "freescale/fsl-ls1028a-kontron-sl28-var1");
>         case 2:
>                 return strcmp(name, "freescale/fsl-ls1028a-kontron-sl28-var2");
> +       case 3:
> +               return strcmp(name, "freescale/fsl-ls1028a-kontron-sl28-var3");
>         case 4:
>                 return strcmp(name, "freescale/fsl-ls1028a-kontron-sl28-var4");
> -       case 3:
>         default:
>                 return strcmp(name, "freescale/fsl-ls1028a-kontron-sl28");
>         }
> diff --git a/configs/kontron_sl28_defconfig b/configs/kontron_sl28_defconfig
> index eae06b546da..1f684093252 100644
> --- a/configs/kontron_sl28_defconfig
> +++ b/configs/kontron_sl28_defconfig
> @@ -78,7 +78,7 @@ CONFIG_CMD_RNG=y
>  CONFIG_OF_CONTROL=y
>  CONFIG_SPL_OF_CONTROL=y
>  CONFIG_OF_UPSTREAM=y
> -CONFIG_OF_LIST="freescale/fsl-ls1028a-kontron-sl28 freescale/fsl-ls1028a-kontron-sl28-var1 freescale/fsl-ls1028a-kontron-sl28-var2 freescale/fsl-ls1028a-kontron-sl28-var4"
> +CONFIG_OF_LIST="freescale/fsl-ls1028a-kontron-sl28 freescale/fsl-ls1028a-kontron-sl28-var1 freescale/fsl-ls1028a-kontron-sl28-var2 freescale/fsl-ls1028a-kontron-sl28-var3 freescale/fsl-ls1028a-kontron-sl28-var4"
>  CONFIG_ENV_OVERWRITE=y
>  CONFIG_ENV_IS_IN_SPI_FLASH=y
>  CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
> --
> 2.39.5
>
