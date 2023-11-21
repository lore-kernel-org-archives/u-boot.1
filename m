Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B4EEC61D90
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 19:00:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 348028758C;
	Tue, 21 Nov 2023 20:00:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IRDsE0V5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14FD18758C; Tue, 21 Nov 2023 20:00:08 +0100 (CET)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FB2386FB2
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 20:00:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-da41acaea52so5553750276.3
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 11:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700593204; x=1701198004; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hp5GNIWd5wgGIyAjN52RoEAj+jfxWHEcS6DkBRCZT6M=;
 b=IRDsE0V50WZOyxvUPK8PDC73xE7mk2U+teyQPQEz7YdXddobZY1o15fq3zD0fFaFt3
 aSi34b+4lekJrMgnWIuAVPoTs9f4rKXwDqOfPEFWUw1dGJPZ80V1A/TM0l4IJO02Pemt
 bukqC065BlF2V1n56pw3uIQUGpIvmYsNVipXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700593204; x=1701198004;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hp5GNIWd5wgGIyAjN52RoEAj+jfxWHEcS6DkBRCZT6M=;
 b=iJpvib0a97MNpBaKB3HhpBszOKcTsZnPW/hwUptLWB5GFjuIVOyIDaT9soFz5zTj4X
 Qsf8YB5FfUndSs5DJa+rlJmIv8oYWyUyPJB5FCNYgCf3qSEWkwjzKGEa+v3B8Dyr176V
 W+yU5BgvllzCkiVpbrxkXtB79NdWUaeX/cosFYAcSfCeC1wDuKyHcNeKHe1YgxwBir70
 e+snynPwfk1p5HGMckMZCUgiv1Vw7HdpkmNXQS5wdb7QYMVG26rNBCKEU1ntmk0GtByz
 TI4uVoKutX5Prja8/EXG3vQ+bXa5RidynVcveJpgpKMhN/+Om0S2Umx+M2ID8EiT16ct
 HVPQ==
X-Gm-Message-State: AOJu0YyYXmejEPlATsoyFiXPWw2PFeqKWkMKh8zDgSDkXcEWv15fskeN
 pUnD2Fj8k4nbQgIzBqQgxUgsrOmvRZnfjmQqaF5wtQ==
X-Google-Smtp-Source: AGHT+IGiefCsWL9Sx3epZxllPoG6D/mXy4VrGO3vb51BP29Ml7HmzRdJuYP3vXxZR1576QuOHZcIrw==
X-Received: by 2002:a5b:5d2:0:b0:daf:7468:459 with SMTP id
 w18-20020a5b05d2000000b00daf74680459mr11415922ybp.3.1700593203709; 
 Tue, 21 Nov 2023 11:00:03 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-92fa-6f17-75b6-6213.res6.spectrum.com.
 [2603:6081:7b00:6400:92fa:6f17:75b6:6213])
 by smtp.gmail.com with ESMTPSA id
 e7-20020a056214110700b0066d32666a27sm4157809qvs.66.2023.11.21.11.00.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 11:00:03 -0800 (PST)
Date: Tue, 21 Nov 2023 14:00:00 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Leo <ycliang@andestech.com>, Rick Chen <rick@andestech.com>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Yu Chien Peter Lin <peterlin@andestech.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Miao Yan <yanmiaobest@gmail.com>, Asherah Connor <ashe@kivikakk.ee>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/7] acpi: Kconfig symbol CONFIG_QFW_ACPI
Message-ID: <20231121190000.GA2513409@bill-the-cat>
References: <20231121152740.24783-1-heinrich.schuchardt@canonical.com>
 <20231121152740.24783-2-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xbo6GALluPqn6yZQ"
Content-Disposition: inline
In-Reply-To: <20231121152740.24783-2-heinrich.schuchardt@canonical.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--xbo6GALluPqn6yZQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 04:27:34PM +0100, Heinrich Schuchardt wrote:

> We have two implementations of write_acpi_tables(). One for writing ACPI
> tables based on ACPI_WRITER() entries another based on copying tables from
> QEMU.
>=20
> Create a symbol CONFIG_QFW_ACPI that signifies copying ACPI tables from
> QEMU and use it consistently.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
> 	new patch
> ---
>  drivers/misc/Kconfig   | 7 +++++++
>  drivers/misc/qfw.c     | 4 ++--
>  lib/acpi/Makefile      | 2 +-
>  lib/acpi/acpi_writer.c | 4 ++--
>  4 files changed, 12 insertions(+), 5 deletions(-)

I still feel like this is a weird direction to go in and that:
> diff --git a/lib/acpi/acpi_writer.c b/lib/acpi/acpi_writer.c
> index 946f90e8e7..9b9fdc190b 100644
> --- a/lib/acpi/acpi_writer.c
> +++ b/lib/acpi/acpi_writer.c
> @@ -48,7 +48,7 @@ int acpi_write_one(struct acpi_ctx *ctx, const struct a=
cpi_writer *entry)
>  	return 0;
>  }
> =20
> -#ifndef CONFIG_QEMU
> +#ifndef CONFIG_QFW_ACPI
>  static int acpi_write_all(struct acpi_ctx *ctx)
>  {
>  	const struct acpi_writer *writer =3D
> @@ -115,7 +115,7 @@ ulong acpi_get_rsdp_addr(void)
> =20
>  	return map_to_sysmem(gd->acpi_ctx->rsdp);
>  }
> -#endif /* QEMU */
> +#endif /* QFW_ACPI */
> =20
>  void acpi_setup_ctx(struct acpi_ctx *ctx, ulong start)
>  {

Will need to be tweaked later on still with some other symbol to denote
"ACPI tables were passed along on real hardware by $mechanism". But we
can cross that when we come to it.

--=20
Tom

--xbo6GALluPqn6yZQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVc/i0ACgkQFHw5/5Y0
tyx6Sgv+Iz5mpQqvJT8TwqjMV73MbQPFmBPW2UWmW2rb4I9XqLJHrLyDxiYK2Yle
ExY2xh9dG3f70PEZDRzS0Ue7YccQTMjaJo2BRMl8KjcZBw/Gk2rjP5goTKePGxK5
/eo2QDrXOWaBD0sdtcKp6OxU8FA77w4uXOW06QCa5nhOHjN5G3x/BaV29l6N8HOb
rljKmrgVOa8OAUBXriZHPAQXdCh5y5AeVR2Ri5/PV+miSaQLO/Bj8Xr+DYJYTRB6
igIwQtFXjfma11bBaTy6dZ8OHsOrO0m3GRi6WTXW0tiCKfMD0jp6OnDwIMChTrBg
oraW0Zj/oYfNXjMtCtSLmEoODAgg2CHu8I3bw9h7ccY3ONYnck1ZpgEsxv1kj6F0
3LD9fuRPIzZUg6drlFhubsLrmLliUR5ItbYFueEGl+MgHBL2xMTkEUmQMwKHJxIN
MvRcZnTRuLpzp+O4pHC8bECq59x78dnweSFy3jeNeVj8TL2Xh/HG0WAdyblvUJMC
Fan8e4kE
=IAte
-----END PGP SIGNATURE-----

--xbo6GALluPqn6yZQ--
