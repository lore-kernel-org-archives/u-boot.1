Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 930F9E77188
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 16:58:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 216B88060C;
	Tue, 14 Jan 2025 17:58:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nIRSc8+D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 578E0806B7; Tue, 14 Jan 2025 17:58:53 +0100 (CET)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CDD08022E
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 17:58:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-46b1d40ac6bso45426161cf.0
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 08:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736873930; x=1737478730; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=R38MYMjJn3Kz5P/F9UYT6ndrENz+ahOc4op9gwMfmUk=;
 b=nIRSc8+D2GiVyT2HYphsfCcxZPaZDUxY9Mc6qFKcvoVyJzYE8tZTQ0BTCnewMGxkiu
 1oqT0jhTUAm+5jpUK2ZGK4Al5/mEIEiQAPEJcYr5hEGMc0g54N2A68SBFt2V++zXwMnX
 XYfcdUQwOqRUblsmUJpxuInUutb6HdFO+NSUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736873930; x=1737478730;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R38MYMjJn3Kz5P/F9UYT6ndrENz+ahOc4op9gwMfmUk=;
 b=eHGNqQDnl/VK0CACtpgYS04dmJWoBvfX/BytWgYTCQFOv12pii1SiLum0yvMC7lk9m
 f5xYD/xpu3KyTzlsaU31rxiJPiS8Uj8c8SYGvEAlJSjE9das7xrKNz99ArXFeP1WZq7D
 aOM3THC+dL5MC/XWsHSqFPNZGNazJqUY+51uB/a4ZRV6QSVcSIIiP2cLHt6EwsArLsUE
 fz0E0w/DjZ+nC8Fqly5mU9PIgUaVZD0Tbznvz4qFxoIyxGf6AQiiellyKRQPi2sqQUUt
 5lD0ZB40jLzk7DRIsrsEQS6fJ3oGwbY2ec/GnbLgIjMzxjpbO7F7bWXNwN3RrlKnglt9
 5TcA==
X-Gm-Message-State: AOJu0Yzk+JIV78gZ7lVQHRyjVnKS0YAR6apJkIp+vFYGX8lK3f3YwnPV
 bazr/0PBVhSwCGS0nSpooDhJAAhzdX6EESBoaWl4O0qJ/SCCSf3uwodFP1DsGQR0CHvVT9iOjsc
 T
X-Gm-Gg: ASbGncu56h61A3LETmHOg1+xb4EbMYQHe1BTeDG+nysHL7IRle5e2e6vR6ezaIPqqka
 upCglX92arB46wuyjTijsC8LfJBIPyhhlO/8Kxg2Q0JyEk2oFJT0NJcgr5P9tRFUNRHaTncdC5y
 H/GWXxDJFUtjUemgm/lTOqU/zJkPM2SkyVIKlcQGBlDO+jQSZdtJ21mbgWbrp+GHsG21U9J8Ox/
 HvLc1FrfdV1+UZT+bS6cKBFXDfaZ2xexOInzBsky+ZeI84RUBOECQ==
X-Google-Smtp-Source: AGHT+IEfJVJRo1wDy7XEhBSfydE+aOMwQf+6oCX/WtXKmiIQNcxD/VEBn5I8N/VwlS6kS52m67pclQ==
X-Received: by 2002:a05:622a:514e:b0:467:59d5:b20b with SMTP id
 d75a77b69052e-46c7afe1e36mr333428741cf.4.1736873930074; 
 Tue, 14 Jan 2025 08:58:50 -0800 (PST)
Received: from bill-the-cat ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dfad9b29f1sm54447966d6.67.2025.01.14.08.58.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 08:58:49 -0800 (PST)
Date: Tue, 14 Jan 2025 10:58:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Stefano Babic <sbabic@denx.de>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH 2/6] drivers/mmc/Kconfig: Make DM_MMC a hidden symbol
Message-ID: <20250114165846.GL3476@bill-the-cat>
References: <20241220222612.1757884-1-trini@konsulko.com>
 <20241220222612.1757884-3-trini@konsulko.com>
 <975a6b12-f401-4909-9163-20b7f1d6d542@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fxj6+BmRNi2LP6yH"
Content-Disposition: inline
In-Reply-To: <975a6b12-f401-4909-9163-20b7f1d6d542@cherry.de>
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


--fxj6+BmRNi2LP6yH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 02:43:44PM +0100, Quentin Schulz wrote:
> Hi Tom,
>=20
> On 12/20/24 11:22 PM, Tom Rini wrote:
> > At this point in time, DM is always enabled. So if MMC is enabled, it
> > should select DM_MMC. No drivers need to depend on DM_MMC being enabled
> > now, so remove that from dependency lists. This now means that a number
> > of platforms which select'd DM_MMC need to select MMC instead.
> >=20
> > Signed-off-by: Tom Rini <trini@konsulko.com>
[snip]
> > @@ -1211,7 +1210,6 @@ config ARCH_U8500
> >   	select CPU_V7A
> >   	select DM
>=20
> I guess this can be removed in may places since it defaults to y and we a=
re
> relying on it being set to y?

Yes, a clean-up to remove "select DM" would be good. This dates back to
before everyone was converted.

> [...]
>=20
> > diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
> > index 9f2fecce3826..46513db0d6e3 100644
> > --- a/drivers/mmc/Kconfig
> > +++ b/drivers/mmc/Kconfig
> > @@ -3,7 +3,7 @@ menu "MMC Host controller Support"
> >   config MMC
> >   	bool "MMC/SD/SDIO card support"
> >   	default ARM || PPC || SANDBOX
> > -	select DM_MMC if DM
> > +	select DM_MMC
> >   	help
> >   	  This selects MultiMediaCard, Secure Digital and Secure
> >   	  Digital I/O support.
> > @@ -39,14 +39,14 @@ config MMC_BROKEN_CD
> >   	  If card  detection feature is broken, just poll to detect.
> >   config DM_MMC
> > -	bool "Enable MMC controllers using Driver Model"
> > +	bool
> >   	depends on DM
>=20
> We can probably remove this depends on as well since DM is implied?

Correct.

> Generally, I'm wondering why we are even keeping this symbol and not merg=
ing
> MMC and DM_MMC together? This is not a blocker for this change though, we
> can go babysteps :)

What makes merging MMC and DM_MMC somewhat tricky is that DM is not
required in SPL/TPL. So yeah, small steps here is the way forward.

--=20
Tom

--fxj6+BmRNi2LP6yH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeGl8YACgkQFHw5/5Y0
tyy+Bgv/ZF/I6aU0JIbIBAaOxy8bGXQw3MC0ox+yfKbmvBDPxZAE4nQ28izya0Gx
5lMKrNNBrCRSNHd8nMsD0m2BmviQ8uyZJRjJGjDQPOsjjp2QjZRCn/vHA3H2Pxy1
ieikkaUvN1pYgEJvbnK84IqzxUAJbTriURYS6ed6DmqdOpf+9wSD/8am0KSBJmGb
CI0Cmkjw8htPhXDcbxjSm5XN+Lvowx8rVdlPKfEYCaTGNAo/r82L/tUdP9TRG6kr
Rc6Uh8wtQTTTXHPBQ6+tviqOSVRPHCNwzsL/F9c/pgilkh9QmBU4BJqyolOEg8sU
B0+30giFgh9TReMeWYnPSRMS55STR5OPj0qO1lb0UMBz7B4lMLRkipXgop4WIg0g
7jmKVuhxY8v3s0Li7Lhm4AFa6IKcEaHd3SjAaMXXviyXE8itUjpCHGHgi6IIJ5sp
moLeZSb3IJ4Tq4C0Isf4Fd47h1+wqokklV+gBkYp1T6fEk5lUOmctl3BaFTF8WVl
UmGnhvva
=5qs+
-----END PGP SIGNATURE-----

--fxj6+BmRNi2LP6yH--
