Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C173C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 15:22:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5240A86C56;
	Mon,  6 Nov 2023 16:22:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kGawAiMf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 381F886E40; Mon,  6 Nov 2023 16:22:12 +0100 (CET)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9A6786BD4
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 16:22:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-66d0c777bf0so30555146d6.3
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 07:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699284128; x=1699888928; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/Eq8JEejMlO6n1gXU846iiBs7vlJBrTQyRgidKljhUs=;
 b=kGawAiMf7d+Lg8VEAYVDlccqxYxI2OmPU6pDQOIGpj2w/mFHFHq+iwvUHMP9mCNt1O
 bv853vsreLK2G5NQVyZYnKr9KanHtAWvSi9+x7NcKnRJNpY0xA5nhVvn9Zfcfz+IjygT
 BVs56ZN2opWQtILBr7wswx6NEoyfQdhDw4e30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699284128; x=1699888928;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Eq8JEejMlO6n1gXU846iiBs7vlJBrTQyRgidKljhUs=;
 b=m/v6RLIfI3JnWgcuPSN+jSQQwNAPECdNdQvIQi6KA7TF3oYLxdBTqkG2m3Mo2Kl/7c
 bt3zb4w0BOayqhgDH7GI15VazVvflTrwHANVzp2zKwAcPWb1Zx51fBvG27Fqmm9JmwT9
 UIJBroYGwSPg2ZQLWaEbL8me70lEw/6KTMLEwzxiIlZPd8cYxBFASBm50mOpCzRPgtPp
 4E4vQQyNmwCNHjtGRuUwj8D/J5FFRRfLxBvCgIIATAzezEITjT1jmUPQFRFxD5c06RUK
 h/Rc2Njxh/fhx7AyPjMogoKM2E9GixY0OdzcJPmLaNSlJMHuK4CyG4m2wNK2V7eq9gx0
 hX8Q==
X-Gm-Message-State: AOJu0YyloBx8FKc0T/5U/i3uaHgOcRVN7dGtA3e5htVERMrtP84Esdm9
 Jw8d8uzVMA837alNAogdq9TJfw==
X-Google-Smtp-Source: AGHT+IHnaoLS/KmaR2T2n3sE6qqsX3UX24Sq6nNlYTm/wIhj9WauJZofWLQOAhKdULulBr/MyCYlPg==
X-Received: by 2002:ad4:5bcc:0:b0:65d:1270:6846 with SMTP id
 t12-20020ad45bcc000000b0065d12706846mr34728035qvt.29.1699284128325; 
 Mon, 06 Nov 2023 07:22:08 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 qh8-20020a0562144c0800b00668bb8be252sm3483441qvb.60.2023.11.06.07.22.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 07:22:07 -0800 (PST)
Date: Mon, 6 Nov 2023 10:22:05 -0500
From: Tom Rini <trini@konsulko.com>
To: Nishanth Menon <nm@ti.com>
Cc: Manorit Chawdhry <m-chawdhry@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sinthu Raja <sinthu.raja@ti.com>, Reid Tonking <reidt@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Simon Glass <sjg@chromium.org>, Robert Nelson <robertcnelson@gmail.com>,
 Jason Kridner <jkridner@beagleboard.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 10/15] configs: j721e_evm_a72_defconfig: Switch to bootstd
Message-ID: <20231106152205.GG496310@bill-the-cat>
References: <20231103003805.2420005-1-nm@ti.com>
 <20231103003805.2420005-11-nm@ti.com>
 <20231106052826.nbtzqzudnh7v3yix@ula0497581>
 <20231106122116.g6xwxgl4hrdpcgeh@debit>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zSdeEx5PPIb3jIz8"
Content-Disposition: inline
In-Reply-To: <20231106122116.g6xwxgl4hrdpcgeh@debit>
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


--zSdeEx5PPIb3jIz8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 06, 2023 at 06:21:16AM -0600, Nishanth Menon wrote:
> On 10:58-20231106, Manorit Chawdhry wrote:
> > Hi Nishanth,
> >=20
> > On 19:38-20231102, Nishanth Menon wrote:
> > > Switch to using bootstd. Note with this change, we will stop using
> > > distro_bootcmd and instead depend entirely on bootflow method of
> > > starting the system up.
> > >=20
> > > Signed-off-by: Nishanth Menon <nm@ti.com>
> > > ---
> > >  configs/j721e_evm_a72_defconfig | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/configs/j721e_evm_a72_defconfig b/configs/j721e_evm_a72_=
defconfig
> > > index 99e0e168ebf7..98ac7ca59789 100644
> > > --- a/configs/j721e_evm_a72_defconfig
> > > +++ b/configs/j721e_evm_a72_defconfig
> > > @@ -29,10 +29,11 @@ CONFIG_SPL_SPI=3Dy
> > >  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> > >  CONFIG_SPL_LOAD_FIT=3Dy
> > >  CONFIG_SPL_LOAD_FIT_ADDRESS=3D0x81000000
> > > -CONFIG_DISTRO_DEFAULTS=3Dy
> > >  CONFIG_OF_BOARD_SETUP=3Dy
> > >  CONFIG_OF_SYSTEM_SETUP=3Dy
> > > -CONFIG_BOOTCOMMAND=3D"run envboot; run distro_bootcmd;"
> > > +CONFIG_BOOTSTD_FULL=3Dy
> > > +CONFIG_BOOTSTD_DEFAULTS=3Dy
> > > +CONFIG_BOOTCOMMAND=3D"run envboot; bootflow scan -lb"
> >=20
> > Coming back to [0], AM62x didn't have early remote procs but j721e does,
> > do you have any alternatives in place before migrating J7 platforms to
> > stdboot?
>=20
> As I have stated before. distro boot support for remote proc has been
> hacked up atm. what needs to happen is standardize it. Which is
> independent of this series.
>=20
> Please discuss with stdboot folks how to get it in. WORST case, envboot
> is still supported, so in effect, what is achieved today can still
> continue to occur with envboot.

There's not "stdboot folks" to talk with about this. The first step
would be someone from TI posting some RFC patches about how exactly the
remote proc support should be handled in that case, explaining where the
what being run comes from and so forth. Maybe the answer is that
"envboot" just keeps being defined and run before hand because that's
the standard way to handle what needs doing on those processors? At
least personally I feel like there's a gap in knowledge of what the use
cases here are. Thanks.

--=20
Tom

--zSdeEx5PPIb3jIz8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVJBJMACgkQFHw5/5Y0
tyxyOQv/dHew/YOEB6d/LEY52tA6S9xpP3c0cYrf4T7G32PprTqk3kvRVt7ITgNB
IxB0y+vxl8JwcjOzWZgDPhUUYESNUFgwKE0oU/B39qRMiWpRrWLmHvXyaVFS9ikI
zgx60OqO62BoeY13O+/d8OYzanaPpF+dPPMiFMMstjvCqtCi6qoCOMaVXBe3Un3Q
dza3cB0stBt7jt/0Q28zsIGXeCPOAbXMX53wT6S8jPb6Kw19wzdpKDNyLsPCbfzX
AuIksg6ZBDy2NQJ4N48ESQXmj/ULrMCj25D9xeBMvyO4Om/wcRPoKiOM18i4kv7A
bwp2n1HtfaA9xPotvFbiY8BLaojWvDNdrDFbSd4Ub7SXDE8AMzcFr/PHcNVOUnDp
WWgs5wzEQWZMn1axR4UaMYG17zM4/PkK3zDc4tG50dUl/AxWUNv/E6V4Yt8bPDjH
xgYgciIrKcjE+QHPPYKacympSCvP4NCXCa1vWwdIHTJrnGyd7gcTX0jAeNtBCSba
NP1XPQPm
=B5Mf
-----END PGP SIGNATURE-----

--zSdeEx5PPIb3jIz8--
