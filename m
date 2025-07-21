Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9AFCC83F26
	for <u-boot@archiver.kernel.org>; Mon, 21 Jul 2025 20:31:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE2CC831B5;
	Mon, 21 Jul 2025 22:31:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="l6yHRgLs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45AC9831D7; Mon, 21 Jul 2025 22:31:24 +0200 (CEST)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94A35830EA
 for <u-boot@lists.denx.de>; Mon, 21 Jul 2025 22:31:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-71840959355so46786057b3.1
 for <u-boot@lists.denx.de>; Mon, 21 Jul 2025 13:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753129879; x=1753734679; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k2pEfdxBNQsyNi5bh+JZb9iM9h7F+vQf1DfiIyqtqE4=;
 b=l6yHRgLsJsfKoPUcBQKsD0zTe7uYt+Orpb4fYO2mgV0hJUTeBrCKVPXw2QobyN19+u
 RBDTwcSjpwYP0f50Mfn5ipIt5uqiewBBPLIbhS3FIpSLoM+Fr4ca2/zh4dZzUg/rkwJk
 Hsl4EwE/zywtIimJlQsqscvDTpctPG6Zg45ao9+IHSK7wNyj1InN/t6e60evgfaMpjFi
 u1rvbXrl2Q3tMXLmUKJxJFhNt2f6Wfr/3jPdO+YoWqoQ70Pc5K+X/26Pduf+uaXl92Nv
 AN2srt3uQTp0t9w7fbwY+jnO+hKQ1wB8aiTH57bctYRd8QFrio4nz61/SStBrJxs80gq
 IhTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753129879; x=1753734679;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k2pEfdxBNQsyNi5bh+JZb9iM9h7F+vQf1DfiIyqtqE4=;
 b=DjtiterR7DwhDzteqQIauJI47Y8g+yDvsXzik8+JEtS4aEUyKxJTbAjHJqOHRoZx4Y
 L+hgxf9m8qu66tHDWwp/pa8otkkJDIoRZ92tM8FoHErJ61G7zOXQFnui5Gc+0u1VdyO3
 hbVjCspdz1nrcpIxufsQYfKSsKT+hClih4CIHc/lCqdDZxrT2H3NM/9St6BetlMr5txz
 q01G8WPAn8kRAwtgGvcsqKSeMuZKltP36WmliOaubQz+OAj7DBkXFFVmhckSX2FxJ1Xp
 AYnwcR3OsqSLFA/EQm1mgbhh/9ep2VIZZ2fPLWEHsnvr6MgSxp1AknYY9sOQ/8iUJRBR
 9nTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrPzzZsvGq8PYG8KDsot67SZi5Vcs8NP39Dnb4VBsTFHm/bONsh4nz7TKNQMVVpLnu2wHBsBI=@lists.denx.de
X-Gm-Message-State: AOJu0YxpOIBwQIQKJOqtORBWzZ0OuJVssTmhQg53j15qCFmQdWk0ZBKA
 wcuEY/nDirwFTNui+VjtyAom0lNOR8ZIRpq2zMxpuxjn00XBcnf3bDMng8c31HrN8gsQ9B7E5zj
 oss1OXINaF1L2b3qxgs45Lt00UN0R++X+wswxbnbrdg==
X-Gm-Gg: ASbGncstgYtePinD8Utj91evYBmbc8BqCg4Z+BS2NoZKifHFg4u09kzgQVJhRi2vSbI
 CLy4juMDbhMYdvhKecZMCAtdcyb+zcOy92dYDZkl1G3DhFZxEQsw7CtSMhA1/6rugQbt3GdrmIM
 gqZVZ/DexAopm5pr9GDa17pwWHgBzLSVqHiqjwwBV9THaf0XBUmuIFHhJgJpZfcfFP9TpnEiAeR
 Rcglc0=
X-Google-Smtp-Source: AGHT+IFPGiCGT9sgzwb8YOHOZw7Efsye4a94gEt6NGtV7pfaLo8k7g5Y3jK0s6DYDZ+waaOOqbbktN2xd7uYbXZ3SOY=
X-Received: by 2002:a05:690c:6d88:b0:716:45a8:d360 with SMTP id
 00721157ae682-719a06c0787mr13985407b3.0.1753129879201; Mon, 21 Jul 2025
 13:31:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250720-samsung-mmc-fixes-v1-0-cb705abfa594@grimler.se>
 <20250720-samsung-mmc-fixes-v1-1-cb705abfa594@grimler.se>
In-Reply-To: <20250720-samsung-mmc-fixes-v1-1-cb705abfa594@grimler.se>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Mon, 21 Jul 2025 15:31:07 -0500
X-Gm-Features: Ac12FXwlOi0LoTIvuyaGsmCvVWidK4IhetnViOqfZEgSx0geuNu-wAPc3-WB77A
Message-ID: <CAPLW+4=v=wz0KriSEMxwt8g1QBh6mwD+Ov0v0=-Q1KdAV8fetQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] mmc: s5p_sdhci: remove duplicated card detect code
To: Henrik Grimler <henrik@grimler.se>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 David Virag <virag.david003@gmail.com>, Minkyu Kang <mk7.kang@samsung.com>, 
 Tom Rini <trini@konsulko.com>, ~postmarketos/upstreaming@lists.sr.ht, 
 replicant@osuosl.org, u-boot@lists.denx.de
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

On Sun, Jul 20, 2025 at 12:00=E2=80=AFPM Henrik Grimler <henrik@grimler.se>=
 wrote:
>
> The common sdhci infrastructure is already parsing the cd-gpios
> property, since commit 451931ea7002 ("mmc: sdhci: Read cd-gpio from
> devicetree"). The s5p code is therefore duplicated, and also broken
> since it assumes that the GPIO value is inverted, while the sdhci code
> correctly follows the ACTIVE_LOW/ACTIVE_HIGH flag specified in the
> device tree.
>
> This fix was originally authored by Simon Shields:
> https://github.com/fourkbomb/u-boot/commit/2eac9dea7903
>
> The change has been tested on exynos4210-i9100, a device similar to
> exynos4210-trats.
>
> Signed-off-by: Henrik Grimler <henrik@grimler.se>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  drivers/mmc/s5p_sdhci.c | 10 ----------
>  1 file changed, 10 deletions(-)
>
> diff --git a/drivers/mmc/s5p_sdhci.c b/drivers/mmc/s5p_sdhci.c
> index 278019f02abbe7ee7f16c48758af3b48449ec078..b2faecefc00f479f53c2c6156=
da66a8fe46e4529 100644
> --- a/drivers/mmc/s5p_sdhci.c
> +++ b/drivers/mmc/s5p_sdhci.c
> @@ -141,14 +141,6 @@ static int do_sdhci_init(struct sdhci_host *host)
>                 }
>         }
>
> -       if (dm_gpio_is_valid(&host->cd_gpio)) {
> -               ret =3D dm_gpio_get_value(&host->cd_gpio);
> -               if (ret) {
> -                       debug("no SD card detected (%d)\n", ret);
> -                       return -ENODEV;
> -               }
> -       }
> -
>         return s5p_sdhci_core_init(host);
>  }
>
> @@ -183,8 +175,6 @@ static int sdhci_get_config(const void *blob, int nod=
e, struct sdhci_host *host)
>
>         gpio_request_by_name_nodev(offset_to_ofnode(node), "pwr-gpios", 0=
,
>                                    &host->pwr_gpio, GPIOD_IS_OUT);
> -       gpio_request_by_name_nodev(offset_to_ofnode(node), "cd-gpios", 0,
> -                                  &host->cd_gpio, GPIOD_IS_IN);
>
>         return 0;
>  }
>
> --
> 2.50.1
>
