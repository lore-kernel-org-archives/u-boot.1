Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF098C4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 13:42:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E9DA876F6;
	Wed,  1 Nov 2023 14:42:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="baQ0Z7Pr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C449A8766A; Wed,  1 Nov 2023 14:42:37 +0100 (CET)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 529DA876F0
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 14:42:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-4196ae80fc3so44464481cf.0
 for <u-boot@lists.denx.de>; Wed, 01 Nov 2023 06:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698846151; x=1699450951; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ltu305M50liw5B7IOoIsEiZtTbfCa8DMK76aCUCAqVc=;
 b=baQ0Z7Prz8RuEfXBOAY94peaF6vahggjb5b7AWgpDG9rW9eQrDCBdYrxfKNLhKB/hT
 Uyq2yF/sHJjqTYN0rg0u0H9+VJhwpIxcjUQN8MeyLa8QRTfZfF0czHSUecDlK6HwPH0t
 qRxiIaEt3SJ0wS0j2vwT+ndQ2NYxVuiiDFpqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698846151; x=1699450951;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ltu305M50liw5B7IOoIsEiZtTbfCa8DMK76aCUCAqVc=;
 b=WUdRImGdJl+gpeDcJZu+JDY7qT9k5Un0WgnhUQSWQ5AgMKXOTBZScEX2XlPCt+Lxrz
 r+5cYXXwxa0YllNzxVljBzDPu1BlTT50o+Vlp0x4w5qiJ+PadrPBaX8paO1chYqeqO7c
 fCMxK4FtdDj7jmaPJAMaB8A6Z7HWWuXKtqz4pxw7oOCXLbXpxpaa/nByerMiC7krN9oS
 rEyIbkfP1w/ksYtTp6jogh0lL5PMwTYT94l3l/YdYeMUKKm4TaseeRP/eLkS0caa8FxI
 8GwrrzTpZItMEgEX0rz+8wcdpOQbRkDCNyRKqhuBfGlLxYXybLFKL1uzMrrLMLoEs3Y3
 Pk5A==
X-Gm-Message-State: AOJu0YyvsAo8XYng5HEngT81dHQMwpYUOywysQBpcw3SGJhEe9yHZwSY
 yMb7p2LemZcBoi4vdctKKcRxIw==
X-Google-Smtp-Source: AGHT+IHuLzCrNUVsNzew+GDHvzJ01IhvXK677F0FAd1i1uhiajZ7bQjgH4e9bInmtszn4ZewWuU8pw==
X-Received: by 2002:ad4:4ee3:0:b0:66d:49aa:6844 with SMTP id
 dv3-20020ad44ee3000000b0066d49aa6844mr23520194qvb.19.1698846151327; 
 Wed, 01 Nov 2023 06:42:31 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 w1-20020a05620a094100b0076d6a08ac98sm1422021qkw.76.2023.11.01.06.42.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 06:42:30 -0700 (PDT)
Date: Wed, 1 Nov 2023 09:42:28 -0400
From: Tom Rini <trini@konsulko.com>
To: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: u-boot@lists.denx.de, nd@arm.com, jon.mason@arm.com, rui.silva@linaro.org
Subject: Re: [PATCH 1/3] corstone1000: add compressed kernel support
Message-ID: <20231101134228.GA496310@bill-the-cat>
References: <20231026125051.321493-1-abdellatif.elkhlifi@arm.com>
 <20231026125051.321493-2-abdellatif.elkhlifi@arm.com>
 <20231031174617.GW496310@bill-the-cat>
 <20231101102041.GA21252@e130802.arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0pLK40ClxopdgJP5"
Content-Disposition: inline
In-Reply-To: <20231101102041.GA21252@e130802.arm.com>
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


--0pLK40ClxopdgJP5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 01, 2023 at 10:20:41AM +0000, Abdellatif El Khlifi wrote:
> Hi Tom,
>=20
> > On Thu, Oct 26, 2023 at 01:50:49PM +0100, abdellatif.elkhlifi@arm.com w=
rote:
> >=20
> > > From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> > >=20
> > > unzip the kernel before executing it
> > >=20
> > > The Corstone-1000 kernel has become too large to fit in the available
> > > storage.  Switching to a compressed kernel avoids the problem, but
> > > requires uncompressing it.
> > >=20
> > > Changes made are generated using savedefconfig.
> > >=20
> > > Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> > > Signed-off-by: Jon Mason <jon.mason@arm.com>
> > > Signed-off-by: Rui Miguel Silva <rui.silva@linaro.org>
> > > ---
> > >  configs/corstone1000_defconfig | 1551 ++++++++++++++++++++++++++++++=
+-
> > >  1 file changed, 1550 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/configs/corstone1000_defconfig b/configs/corstone1000_de=
fconfig
> > > index 3b5733b777..f25da79ec8 100644
> > > --- a/configs/corstone1000_defconfig
> > > +++ b/configs/corstone1000_defconfig
> > > @@ -1,69 +1,1618 @@
> >=20
> > This wasn't done as savedefconfig, so I had to do a tiny bit of
> > reworking to re-save it and then again on 3/3 for it to apply. In the
> > future please make sure defconfig changes really are savedefconfig'd,
> > thanks and applied to u-boot/master.
>=20
> Sorry for the extra work done.
>=20
> However, I already followed these steps to generate the defconfig.
> The steps below show that generating the defconfig at the current commit =
level generates a .config identical to corstone1000_defconfig.
> I used the HEAD of next. Please, am I missing something here ?
>=20
> More details:
>=20
> b055167ef05898075dc2b2fa3ea244f56932c75e (HEAD) corstone1000: add compres=
sed kernel support
> e29b932aa07fa0226d325b35d96cd4eea0370129 (origin/next) Merge branch '2023=
-09-30-Kconfig-updates' into next
>=20
> $ make corstone1000_defconfig savedefconfig
>   HOSTCC  scripts/basic/fixdep
>   HOSTCC  scripts/kconfig/conf.o
>   YACC    scripts/kconfig/zconf.tab.c
>   LEX     scripts/kconfig/zconf.lex.c
>   HOSTCC  scripts/kconfig/zconf.tab.o
>   HOSTLD  scripts/kconfig/conf
> #
> # configuration written to .config
> #
> scripts/kconfig/conf  --savedefconfig=3Ddefconfig Kconfig
> $ diff -pruN configs/corstone1000_defconfig .config=20

Uh, that's not what I see, nor is it what was in your patch. The patch
turned configs/corstone1000_defconfig in to the 1600 line .config file.
And the step you're missing is "mv defconfig configs/corstone1000_defconfig"
after doing savedefconfig.

--=20
Tom

--0pLK40ClxopdgJP5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGyBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVCVcEACgkQFHw5/5Y0
tywEggv42OWUx+PHcl46MRV9CRpU8fEfSI4gEGMuJaKxy+KZF7e559m90lbSPGWG
PtjZ2f3GCSEI5Wb6jWNGRa1CaBmRC9WXVGu1pqoKgCxQh8yK4x3GeM1ldJg2EDUI
NcAz4iDLcAZpSB4kHdFwhtySd3FwFASZ7Obi3PDNZbfV3fDRoRpNMuQYDqr0e/zL
iB+2G88LiEtnTvquYLvqM0FC7rqRBMzy/NRA3Z2srBkYfaZTHMk322HmrTxHv2TK
zVIwcTgLTk+Sch0ZF8u3r/ffzxqRxvN3AfjwG/lreDIuMid0JKtV4M3+Tx1q86FX
gbjF7V22nMg1Bq8Okx6Ed9571d3GMTYC1wRunHUjMtoBnB05avTh/U8u91RDkfSK
KjY1YwQyHnyCpMv7n6EYa2H59dNsLERCEGcZGTAbKLEJoZ+yXNKSJdMgiYxi3z/P
KHDcaV+kSYxwb7uo/xNYysAELyh+rdSlgLvZx9qHDbpUMVEXNNqz048J1s0Fgzzy
td57DG8=
=+6Pg
-----END PGP SIGNATURE-----

--0pLK40ClxopdgJP5--
