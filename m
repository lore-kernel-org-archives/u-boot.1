Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5518BEE4993
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 11:13:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AD9B864B3;
	Wed, 23 Aug 2023 13:13:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RGUHXy0A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4260864BE; Wed, 23 Aug 2023 13:13:16 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03CB386435
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 13:13:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thierry.reding@gmail.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-50078e52537so5577844e87.1
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 04:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692789194; x=1693393994;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V0EZTYVEJEE3PvogTs64Dl0J/tjPb4U8jbTM02BnRf0=;
 b=RGUHXy0AtVH2sQBYmkXybYPMrqxKTyJzDuJGG5ywbMzz3Is/Nu/+EwN2boCe+ekOFz
 cHbwvimMriGzBKbFa+mySODyx8yl6HNNz7UWserW8cXB10wK6aOebK2ZRI88fCT2lpJv
 4qOqZL6zkj6iZzspWeHhlv4jYOLZoifom5whtldMBIMieRZzQ3InbxJ+q5QtAQZKePcq
 pB3a37AqSGimPX3f064PnSK9pP4DgHQVhV+LiBbuH2fdEzI9a4dKrNaIh9kfP6OossOs
 eiJyIQJ2Up/1iQovd18X9m3k5Lic9QAvsVmHfuZWL3bDJn/vf3/fzmcFKG5O1bPBYRdv
 f5qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692789194; x=1693393994;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V0EZTYVEJEE3PvogTs64Dl0J/tjPb4U8jbTM02BnRf0=;
 b=f0M1sPikNDSmcuoWTxufBRwTUKwK/zfugxp7GeAaL9Tx7uiVT8yP1B12fipfxrzIGh
 uPF/+zpi1VDz42vfcj63C5k1f5Cx+pwg9MgpIJjp+0WlDO3L+2wPVYCIAJwMTHbNkDTg
 2UMXaFZ2ZJdDegHRkmG49e7xMloo/L4TrF8bUf38TKvXkxFhB6WaQS6G6H48CkTeGxQI
 xoqAEcHUmoP/zxH8YtwSNOvvffnrbmDxzsOvN1w4nFt3nirg93VvqVOIdYE+dm2MU1Mr
 8UUpM/ll1eWkNlaGYRBO2h3ymxIPyRKSGdgrom4RekRm/5nj3xvZOslHsXYgJvJwCgKg
 4w6w==
X-Gm-Message-State: AOJu0YwYrdPgJlG3oCYgLFHqnFqJaEhyiA5We+L1QWn2n/RycwCIwfTK
 XvXz2lsu0yBBZETxy6lLm04=
X-Google-Smtp-Source: AGHT+IHiE4Gsczg31wkqvZrDfaxVvxvATbp1z3GCFDKAMrEnTFDT9vqpcL8Jc5cyCnSU4wAdCKdMAA==
X-Received: by 2002:a05:6512:b28:b0:4fe:8ba8:16a9 with SMTP id
 w40-20020a0565120b2800b004fe8ba816a9mr10962801lfu.55.1692789193809; 
 Wed, 23 Aug 2023 04:13:13 -0700 (PDT)
Received: from orome (p200300e41f1bd600f22f74fffe1f3a53.dip0.t-ipconnect.de.
 [2003:e4:1f1b:d600:f22f:74ff:fe1f:3a53])
 by smtp.gmail.com with ESMTPSA id
 jp19-20020a170906f75300b0099cd1c0cb21sm9654432ejb.129.2023.08.23.04.13.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 04:13:13 -0700 (PDT)
Date: Wed, 23 Aug 2023 13:13:11 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Thierry Reding <treding@nvidia.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v1 15/19] ARM: tegra: board2: add generic late init
Message-ID: <ZOXpx6oq8MYkoHcw@orome>
References: <20230822112217.4646-1-clamor95@gmail.com>
 <20230822112217.4646-16-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="DziJKLUMM2nsF9Fz"
Content-Disposition: inline
In-Reply-To: <20230822112217.4646-16-clamor95@gmail.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
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


--DziJKLUMM2nsF9Fz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 22, 2023 at 02:22:13PM +0300, Svyatoslav Ryhel wrote:
> Board specific late init allows vendors to set up different device
> or board specific env variables (like serial number, platform name).
> In case this information is missing, u-boot will lack info regards
> serial or platform.
>=20
> To avoid this prior nvidia_board_late_init internal generic function
> is called which fills required data. In this case platform name is
> obtained from get_chip and serialno is filled with SoC id.
>=20
> Though SoC id is not dedicated to be devices serial but it fits well
> in case of restriction of data about device and since SoC is basically
> a main chip of the device.
>=20
> Tested-by: Andreas Westman Dorcsak <hedmoo@yahoo.com> # ASUS Transformers
> Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # Nvidia Tegratab
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  arch/arm/mach-tegra/board2.c | 43 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>=20
> diff --git a/arch/arm/mach-tegra/board2.c b/arch/arm/mach-tegra/board2.c
> index 981768bb0e..ee69cb657a 100644
> --- a/arch/arm/mach-tegra/board2.c
> +++ b/arch/arm/mach-tegra/board2.c
> @@ -26,6 +26,10 @@
>  #include <asm/arch-tegra/gpu.h>
>  #include <asm/arch-tegra/usb.h>
>  #include <asm/arch-tegra/xusb-padctl.h>
> +#ifndef CONFIG_TEGRA186
> +#include <asm/arch-tegra/fuse.h>
> +#include <asm/arch/gp_padctrl.h>
> +#endif
>  #if IS_ENABLED(CONFIG_TEGRA_CLKRST)
>  #include <asm/arch/clock.h>
>  #endif
> @@ -256,6 +260,37 @@ int board_early_init_f(void)
>  }
>  #endif	/* EARLY_INIT */
> =20
> +#ifndef CONFIG_TEGRA186
> +static void nvidia_board_late_init_generic(void)
> +{
> +	char serialno_str[17];
> +
> +	/* Set chip id as serialno */
> +	sprintf(serialno_str, "%016llx", tegra_chip_uid());
> +	env_set("serial#", serialno_str);
> +
> +	switch (tegra_get_chip()) {
> +	case CHIPID_TEGRA20:
> +		env_set("platform", "Tegra 2 T20");
> +		break;
> +	case CHIPID_TEGRA30:
> +		env_set("platform", "Tegra 3 T30");
> +		break;
> +	case CHIPID_TEGRA114:
> +		env_set("platform", "Tegra 4 T114");
> +		break;
> +	case CHIPID_TEGRA124:
> +		env_set("platform", "Tegra K1 T124");
> +		break;
> +	case CHIPID_TEGRA210:
> +		env_set("platform", "Tegra X1 T210");

This variable is presumably something that you'd want to match on in a
script, so perhaps we can settle on something a bit more canonical. In
upstream Linux we use tegraXYZ quite consistently and you'll see that
reflected in things like compatible strings, so I'd suggest reusing the
same naming scheme here to simplify and avoid confusion.

Thierry

--DziJKLUMM2nsF9Fz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmTl6ccACgkQ3SOs138+
s6FjdhAAnxAlWqvyMwfMOKrMhj6/VHQaG1yKcWbB4n9Ws4uT5OS0qijeOrP50MLw
NET9fxB00rcF/SoM9TBArZkdWdu9ROkajkbg8WusbbkB8v5Eg4P6RryaHj+VED6J
Ejl7P1dNogH1pjGy/JWyNQrz1k7D89m1bUsWKdS/S7KZaGCr7zaew3hCILMzeAxc
dKACyPDAWGzdEfE0tnq1vRff+am2/l7DBeMru96B1ib7ZGQ1GVS1LY1Mec6gR9XU
E77pOPVCN8HZi2Cx38bkGibF8RbQGfbB/fDzB7fRAkGS3roe6IgDch+fm/KqWp4m
xL5oy97rH4KMX/YKjwie9/Q7YJ/my/fsL0w4Oj8+UK6eCCMyAstVYiyKm78How4S
ZiK6YWDJDfYSJGyinjv8JzxN7u7tlpg1uuh7xVcvLI+D9/zudw30nMnV42S/nBKR
OUJmrtRXfPSw1eTPnY3Hr96gthLh5wi3PP9xEPJm11t5G3QZa4j7rkbcBAVfiHrx
M89yE85VlcnNQcZU1sBcMErRiIe9oCx0zQF12Du0Wu4pHOLs2zNETeFC6tAIf+L0
UXjeNhpWthKLIcgEW/zG5GAgdOpklpeAjDKw/FB8SZ9RQsqk5sW5jiPmZy8xQwPy
VECGWj63V/PJNhI3mrh+Kz14GmIDEsxtp2hKoIGUZR5lhIbCzNs=
=3uf1
-----END PGP SIGNATURE-----

--DziJKLUMM2nsF9Fz--
