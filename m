Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CE3AC3ABC9
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 14:35:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3B1E82BDA;
	Thu, 15 May 2025 16:35:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="h0oWrwn3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E04982BDA; Thu, 15 May 2025 16:35:21 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07CC282BC1
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 16:35:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6f8ae08e38dso4096146d6.2
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 07:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747319716; x=1747924516; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=69KP9FDbXq3+kcEtWA3tIEu1lmHm4O50iJjLUqiuujk=;
 b=h0oWrwn39evzTCLuyuiAa0M4KCwlzmgZcsp8GcL2l2qoJWGRQiosQm/JtRoToUwRqf
 ifmL4Bp6KsClQ9ASKt4qMpz0LUgb9+OcIeN2W+m7leD0j9KhKK3gacm3mkwM1mA9ZQ7X
 2QwQutIVmf3yQ5kY8NhBR56dbNaHMo7FaUZ9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747319716; x=1747924516;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=69KP9FDbXq3+kcEtWA3tIEu1lmHm4O50iJjLUqiuujk=;
 b=uvXbkwfDlriDFe1A9lPk+QsOHAyCQU9nTcHDUqYyknzlHaagEoGQ/B0WEDNb9gvOA/
 bYBu5dlL4tFTfB/4uqffppH5mVhp0b9uZwXKUvL7Q9a6/CT7aYtIzP0U+sL+XLkvKny+
 rhDrXN/mNzOxwxfe9gIzLZak8ecHZHhgGDl+eEJtp1Avib+YKtGThVHgsdPJqvF3mL+x
 2SrH10cCr+kGAAlCnQ9uRSed6vIjTbv9Ixan17q6cV8lI18QXJStpqK9OXQ44jiKHMrC
 CPQWHDJphEaMN5X9khNb5gBkZLyLi43JYyk+BajrHEf9KCPzzy1Geag48B5GfC3/L28N
 TFWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHZEGIkicdRKOs+vo7RyQYTQ5caULFWr26aBKgpOji70w62cfdzjll7fkyERCg9Q5X5Fzyyi4=@lists.denx.de
X-Gm-Message-State: AOJu0Yw96V869p4rISyz3xZMA3J23IzSccbFWuLSAImuEVSJFOlXO0Fl
 v7QSWzC1TUdMshn6az4a0OCBDpWhGGpJdT2XqzhMKaFHWsQHhYwtuSX7WLNLWq/sPFUuSx3Yx0Y
 G/EY=
X-Gm-Gg: ASbGncsT9Vg7+uGJZX7bpWKIWRiHnA3l/nontIeF2Y8MW/7AkUtLi3URV9rbBos2aYd
 xvKE4ElVAZPs+VfhxXMB8mjlYZ1gPhycurRSjRI4y5YtdFhGjWOPyaNKVrbCLKgkqRqGgcPyoEr
 oOncXpBdVFj55fxwOx61Ux0d2ab6DIIV7EXrylwFbMhnnvyez3BmYQAHav22JGbLh6ljTsrByq3
 wtdIb29AKfwWWAfYREaGMHwVwwmTifwK+62/Ta2wvPyhyNITvw6BxcA/o5GLJBn4jKW5qQVEpxn
 IkzIaojkUbFUGgTv7v7U+MHfkRFYFSD9VWj8HVHwq4FG0ePCDbQXlmuC3kkFkK0cGcnJ2SEjlWs
 wQiVQXPPddKY+
X-Google-Smtp-Source: AGHT+IEPCzY9qcxyc3Ke1WCq7AWwIHnf7yj/KQo4dlJCSLaTv52T7sbc6z+vUwTBI2GODTr6K/ANeg==
X-Received: by 2002:a05:6820:2082:b0:607:e15c:be07 with SMTP id
 006d021491bc7-609df23117emr3986251eaf.7.1747319706088; 
 Thu, 15 May 2025 07:35:06 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-609ea0d225dsm412291eaf.27.2025.05.15.07.35.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 07:35:05 -0700 (PDT)
Date: Thu, 15 May 2025 08:35:02 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 u-boot@lists.denx.de, linux-amarula@amarulasolutions.com,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Paul Geurts <paul.geurts@prodrive-technologies.com>,
 Peng Fan <peng.fan@nxp.com>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@nabladev.com>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>,
 Vitor Soares <vitor.soares@toradex.com>
Subject: Re: [PATCH] arm: imx: imx8m: soc: fix the macro name
Message-ID: <20250515143502.GI603748@bill-the-cat>
References: <20250515100253.730388-1-dario.binacchi@amarulasolutions.com>
 <58419801-d2c8-49bc-9c0b-ca07e423c950@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Knm2EL5H/24/w2jR"
Content-Disposition: inline
In-Reply-To: <58419801-d2c8-49bc-9c0b-ca07e423c950@cherry.de>
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


--Knm2EL5H/24/w2jR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 01:37:44PM +0200, Quentin Schulz wrote:
> Hi Dario,
>=20
> On 5/15/25 12:02 PM, Dario Binacchi wrote:
> > From: Michael Trimarchi <michael@amarulasolutions.com>
> >=20
> > The function arch_spl_mmc_get_uboot_raw_sector() was never compiled,
> > even when the option CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION was
> > enabled. So rename the macro SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION to
> > CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION.
> >=20
> > Fixes: 2a00d73d081a ("spl: mmc: Try to clean up raw-mode options")
> > Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> > Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> >=20
> > ---
> >=20
> >   arch/arm/mach-imx/imx8m/soc.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/arch/arm/mach-imx/imx8m/soc.c b/arch/arm/mach-imx/imx8m/so=
c.c
> > index 567e8e9e81a0..806adcf145fa 100644
> > --- a/arch/arm/mach-imx/imx8m/soc.c
> > +++ b/arch/arm/mach-imx/imx8m/soc.c
> > @@ -791,7 +791,7 @@ int boot_mode_getprisec(void)
> >   #endif
> >   #if defined(CONFIG_IMX8MN) || defined(CONFIG_IMX8MP)
> > -#ifdef SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
> > +#ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
>=20
> Maybe a good opportunity to switch to
>=20
> #if IS_ENABLED(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION)

I honestly don't know if that's more readable, but don't strongly care.

> ?
>=20
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
>=20
> I had a random idea but I'm wondering if there's a way we could check all
> symbols listed in IS_ENABLED/CONFIG_IS_ENABLED and check they actually ex=
ist
> in Kconfig somewhere? This would not have caught this one since we were
> using #ifdef but wondering if it could help with migrations/renaming?

I think that might be something tools/qconfig.py --scan-source prints
out about, but the output then requires manual investigation. I also
*think* it missed one set of cases, but I've added a checkpatch.pl
change to be louder about it.

--=20
Tom

--Knm2EL5H/24/w2jR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgl+5YACgkQFHw5/5Y0
tywsZwv8CucYirJ7SZB5KPOAHHot5NLHUKVnQz0mCmztgD+yL7niU8YXExW0ZlcN
g4Hm5aI5LTDcyXQza5EXV7ipbZduPj0KxznL78kZblsjJf0Rs/1/dlvBzC0lsY6C
YNiZq5Zck00xJJrjZKsJXHPLGZMf1cYPXuw6u2ETZgQN+DlZXLg3VbNmOCcMR9pY
5hIi/oI8sK6+nrNp6EAMzD9yKAWUsdWVdMWSZob0t2FBw/WUephH7oQAPgaihL8Q
dzUI4WYkgyXYsgMEXNVzbeQu147uqqrpy3yfbJNe+pFKdvja2c69kDM3Yw1kdDTv
bcPSh+Bc3JbCpxvt7c5g/64bERrV0co5Hn89ERzFiDbGK59C3N4KYxnfiEruXA/p
DgNStpwqWV91zdwYWoSb7tz7azsGrKxh/1UGyDOSJCHxqzjUvy6rrbW15/MpqmEi
RVWLFAVEAB4GbeCj+Ga4mRzSMi+P17/8kR8B420mQdIul1bhXai8YJBFf8UKh/nb
TQUIn9Wx
=8Gmg
-----END PGP SIGNATURE-----

--Knm2EL5H/24/w2jR--
