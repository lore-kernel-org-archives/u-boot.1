Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4BE4EE0202
	for <u-boot@archiver.kernel.org>; Wed, 13 Sep 2023 18:33:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D23C1865D0;
	Wed, 13 Sep 2023 20:33:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uZO9Y3rw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 515818664A; Wed, 13 Sep 2023 20:32:59 +0200 (CEST)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8997F864EC
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 20:32:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-d7b9de8139fso155883276.1
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 11:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1694629975; x=1695234775; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jjVxDp83F1DsAE7UkXKCrqeD1evQYXjd5P/V2JC0xO0=;
 b=uZO9Y3rwdQTO3IwHrOtIi1y5AL6JKTXyVveOl/h3PM3CDD4Z/A+uhQQ3o6ZqNPvJdE
 CvyMnA1HDfSF7xKwPXtjil0U9D8BHmu+8hGDfFOS21jq2Nn4M8aAZVPxRDZt4nnnwhc9
 RBIxP5J199yfyEnFLQd9fREW1honUhHnhiaq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694629975; x=1695234775;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jjVxDp83F1DsAE7UkXKCrqeD1evQYXjd5P/V2JC0xO0=;
 b=BvWb/GaxDX1tcNZHRERYyIccxMSpMN2xjBCeZO7aUWDFtnii50Ls//c/+j4Vx6YAOH
 V6XksIy0kn/k2d0mal/dz5DBey2wfXD2TYFR5jmTuynOB/2M1YDdanJkxN3CiPpAFtp9
 LvDR4Oi0Acl1I1ZmCvrs07yyUO14saHB/3aJ350hdGovIYSrqIf8pJfGhJxUQqK7nJv+
 3QYJ680BTxDpzuTqPEc47VO6spPEVaMRdeeBGudDu48Pe8xN7trxlkbabj+ge9tToXVd
 wwXxoTYNh0t6Po5E3q6fPuvZTqSONa0HHlzJ1L0UbTpu9T2alk7HK9u4UHx6w/UetacJ
 wl+w==
X-Gm-Message-State: AOJu0YzA6Loei9uLbGTxMUYqjgyJ0RE02m6PM23+RVCR0UOOt0k3GGsB
 lrPBFS5uW6YTFwIn+lB+yt57pw==
X-Google-Smtp-Source: AGHT+IGbYvF+MVkt7dqv3c2fg3OWl4ybq2MCkZrxaCCm51Bsc2nLPVfdyIcHgMIKVkNRhpATys+2OA==
X-Received: by 2002:a25:6806:0:b0:d81:61c8:aef5 with SMTP id
 d6-20020a256806000000b00d8161c8aef5mr1988071ybc.40.1694629975180; 
 Wed, 13 Sep 2023 11:32:55 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-2580-cbcf-c7bd-45ce.res6.spectrum.com.
 [2603:6081:7b00:6400:2580:cbcf:c7bd:45ce])
 by smtp.gmail.com with ESMTPSA id
 83-20020a251856000000b00d0b0bbe574asm2860681yby.44.2023.09.13.11.32.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Sep 2023 11:32:54 -0700 (PDT)
Date: Wed, 13 Sep 2023 14:32:52 -0400
From: Tom Rini <trini@konsulko.com>
To: Trevor Woerner <twoerner@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH] am33xx: ignore return value from usb_ether_init()
Message-ID: <20230913183252.GO305624@bill-the-cat>
References: <20230831024951.22599-1-twoerner@gmail.com>
 <20230831101511.GD8826@kitsune.suse.cz>
 <CAHUNapQxb=5sr3FPscBht_SAYh4++yvbMscwEnmQRJhw1TdO1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZfNdkGNpS/QTPd0L"
Content-Disposition: inline
In-Reply-To: <CAHUNapQxb=5sr3FPscBht_SAYh4++yvbMscwEnmQRJhw1TdO1g@mail.gmail.com>
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


--ZfNdkGNpS/QTPd0L
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 13, 2023 at 08:50:49AM -0400, Trevor Woerner wrote:

> Can this get added to the next release? I don't see it in -next.

I was going to pick this up for v2024.01 (i.e. the next branch)
soon'ish.

>=20
> On Thu, Aug 31, 2023 at 6:15=E2=80=AFAM Michal Such=C3=A1nek <msuchanek@s=
use.de> wrote:
>=20
> > Hello,
> >
> > On Wed, Aug 30, 2023 at 10:49:50PM -0400, Trevor Woerner wrote:
> > > In 2cb43ef1c223 ("usb: ether: Fix error handling in usb_ether_init") =
the
> > error
> > > handling of usb_ether_init() was changed. Not a single other call site
> > of this
> > > function checks its return value, therefore follow suit in the am33xx
> > code.
> >
> > then there is the question what point is there in having a return value
> > in this function at all.
> >
> > Anyway, it's fine to not check the return value in the caller if there
> > is no use for the error.
> >
> > Reviewed-by: Michal Such=C3=A1nek <msuchanek@suse.de>
> >
> > >
> > > Do not cause the boot to halt if the usb gadget ethernet initializati=
on
> > fails:
> > >
> > >       initcall sequence 9ffdbd84 failed at call 808024b9 (err=3D-19)
> > >       ### ERROR ### Please RESET the board ###
> > >
> > > Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> > > ---
> > >  arch/arm/mach-omap2/am33xx/board.c | 6 +-----
> > >  1 file changed, 1 insertion(+), 5 deletions(-)
> > >
> > > diff --git a/arch/arm/mach-omap2/am33xx/board.c
> > b/arch/arm/mach-omap2/am33xx/board.c
> > > index ecc0a592e993..8f772310a1a7 100644
> > > --- a/arch/arm/mach-omap2/am33xx/board.c
> > > +++ b/arch/arm/mach-omap2/am33xx/board.c
> > > @@ -270,11 +270,7 @@ int arch_misc_init(void)
> > >               return ret;
> > >
> > >  #if defined(CONFIG_DM_ETH) && defined(CONFIG_USB_ETHER)
> > > -     ret =3D usb_ether_init();
> > > -     if (ret) {
> > > -             pr_err("USB ether init failed\n");
> > > -             return ret;
> > > -     }
> > > +     usb_ether_init();
> > >  #endif
> > >
> > >       return 0;
> > > --
> > > 2.41.0.327.gaa9166bcc0ba
> > >
> >

--=20
Tom

--ZfNdkGNpS/QTPd0L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUCAEsACgkQFHw5/5Y0
tywVWgv/WSJZsDNC8CuPY+pMCmGBSv9hLTl//BQhIf/WwcdLBMa60hDjf7VoYCGa
rpKpTZ3WEQ9pGK/xNyHbGnAZLGDCMVZuffae5ue58+8sJpBz7KoWpmKMz9tgEymB
Dzi09uLuLu96PSL71CkzDMlAWTj+zzMH0Mskxo+pF6YLltigkuqFXI+Mzpj+26jS
MOhYAU4uWUim1KFE7RSvQlwtharIHz4TcVqycrDvSfLSoeQMFgspntzLIrbFH4Ma
C3cTVOy3T7Hi4vuExWvpeFP6Mr6OKLkBh5vGh9fFWJNxSlq0MRyGnB4uKpSOT3Ut
Ge95vHavnREVPfyOFA5+MB9dlnl6o++5L4zI+X8Pu0TadQZtQnNTDAnK9TF2bucb
kDA4lKODqFPwHk5KU1tP20Ouysjkg4gjtL9y42ODE7iMsXWwrZiBV8hSLMc+0ykl
kjgp2MqNiiUOD6TcRcsVPGTfYKW9fnCO/SfKVeh2SSeowIRXaN/TiSsluYRPXrVQ
61PQq4tQ
=Oozn
-----END PGP SIGNATURE-----

--ZfNdkGNpS/QTPd0L--
