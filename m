Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F3EAC2BBCA
	for <u-boot@archiver.kernel.org>; Tue, 25 Jun 2024 14:14:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE99D884C8;
	Tue, 25 Jun 2024 16:14:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Q77LquqX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FBF8884AC; Tue, 25 Jun 2024 16:14:48 +0200 (CEST)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26C2088356
 for <u-boot@lists.denx.de>; Tue, 25 Jun 2024 16:14:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-5c21a177affso202714eaf.2
 for <u-boot@lists.denx.de>; Tue, 25 Jun 2024 07:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1719324885; x=1719929685; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pxK51jKqmKaeZvecOUa5UJC0XRMR7dTSrfyiZZ6eCDE=;
 b=Q77LquqXHKNrEHwSK84dTex6rpDyI1zfsKh2sedUHD0DM+qIIAYhFxOb5VWsFivXab
 h1uD2BU5OsCjiziLiHHvbu+l3KfPvAbUjULddeaXpbuihfsQETotbdey2rbyLPq/lcqp
 8RWi1Au2q21RAC7gJEm6U2STAbJZJ29prUe0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719324885; x=1719929685;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pxK51jKqmKaeZvecOUa5UJC0XRMR7dTSrfyiZZ6eCDE=;
 b=BTa10/4ua0XmeFoRa5u71/tml0EXXiyDWTPEmpFsMQZ2B+wqW3XBkt82t+Rb8M5JO+
 th8D72PSAgpoD8Y6KCwFeqOqxuMvXv3Y7lAUv9dsNG9Gx1QzqbVwPvRnOBJnAouia+/4
 5MpD9osfINIXlMFXSGBC4Ka6xisYa70U+b4fbyn9rZnBbG5WJ63EZ7EpF7mXPVCuhzck
 QJF68YnL6agLGHkKvir4B9MgkWJ1M+MqoHNOpc61Qxa2psbGHlvtcnPX3R+tV3lL/UEo
 iWkQ/UHxBc6vh6VEUvW79APkOk/1xJJ9flHvFsZoPvPsbdVBXf87xq74XihLvf1OrvjO
 8ehA==
X-Gm-Message-State: AOJu0YzkQAnlcfKQ5V+oZliM+r8g3vlEFyzx/jMj3AAgxubgPVIxv5Z4
 lUMHRiSIH1A9P6ZOODeOuprnHhsYHsuYn9YkQx/N7FZs8lVBDoOUBPj5VGpjc48=
X-Google-Smtp-Source: AGHT+IFc/hAFjSzLkjfGpHgkybkkAtj9wdBJ/YvXNHkb+0RljIr6KiZDVdZ4WJy9dSlstTj4MoJL9g==
X-Received: by 2002:a4a:8515:0:b0:5ba:ffcb:c760 with SMTP id
 006d021491bc7-5c1ebb01d47mr7949701eaf.5.1719324875249; 
 Tue, 25 Jun 2024 07:14:35 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-197-45.totalplay.net.
 [187.190.197.45]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5c1d58ff8f4sm1808995eaf.41.2024.06.25.07.14.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jun 2024 07:14:34 -0700 (PDT)
Date: Tue, 25 Jun 2024 08:14:32 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Bin Meng <bmeng.cn@gmail.com>, Sean Anderson <seanga2@gmail.com>
Subject: Re: [PATCH v3 06/19] test: Avoid failing skipped tests
Message-ID: <20240625141432.GP38804@bill-the-cat>
References: <20240623203213.1571666-1-sjg@chromium.org>
 <20240623203213.1571666-7-sjg@chromium.org>
 <20240624180556.GG38804@bill-the-cat>
 <CAFLszTiJYVQZ=2kqC6FUQMfrFwtSraET_3nG-2oZhMV=Ts7OEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="AHfEoxGm7XccCPDs"
Content-Disposition: inline
In-Reply-To: <CAFLszTiJYVQZ=2kqC6FUQMfrFwtSraET_3nG-2oZhMV=Ts7OEw@mail.gmail.com>
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


--AHfEoxGm7XccCPDs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 01:38:00PM +0100, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 24 Jun 2024 at 19:06, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sun, Jun 23, 2024 at 02:32:00PM -0600, Simon Glass wrote:
> >
> > > When a test returns -EAGAIN this should not be considered a failure.
> > > Fix what seems to be a problem case, where the pytests see a failure
> > > when a test has merely been skipped.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > > (no changes since v1)
> > >
> > >  test/test-main.c | 16 +++++++++++-----
> > >  1 file changed, 11 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/test/test-main.c b/test/test-main.c
> > > index 3fa6f6e32ec..cda1a186390 100644
> > > --- a/test/test-main.c
> > > +++ b/test/test-main.c
> > > @@ -448,7 +448,7 @@ static int ut_run_test(struct unit_test_state *ut=
s, struct unit_test *test,
> > >  static int ut_run_test_live_flat(struct unit_test_state *uts,
> > >                                struct unit_test *test)
> > >  {
> > > -     int runs;
> > > +     int runs, ret;
> > >
> > >       if ((test->flags & UT_TESTF_OTHER_FDT) && !IS_ENABLED(CONFIG_SA=
NDBOX))
> > >               return skip_test(uts);
> > > @@ -458,8 +458,11 @@ static int ut_run_test_live_flat(struct unit_tes=
t_state *uts,
> > >       if (CONFIG_IS_ENABLED(OF_LIVE)) {
> > >               if (!(test->flags & UT_TESTF_FLAT_TREE)) {
> > >                       uts->of_live =3D true;
> > > -                     ut_assertok(ut_run_test(uts, test, test->name));
> > > -                     runs++;
> > > +                     ret =3D ut_run_test(uts, test, test->name);
> > > +                     if (ret !=3D -EAGAIN) {
> > > +                             ut_assertok(ret);
> > > +                             runs++;
> > > +                     }
> > >               }
> > >       }
> > >
> > > @@ -483,8 +486,11 @@ static int ut_run_test_live_flat(struct unit_tes=
t_state *uts,
> > >           (!runs || ut_test_run_on_flattree(test)) &&
> > >           !(gd->flags & GD_FLG_FDT_CHANGED)) {
> > >               uts->of_live =3D false;
> > > -             ut_assertok(ut_run_test(uts, test, test->name));
> > > -             runs++;
> > > +             ret =3D ut_run_test(uts, test, test->name);
> > > +             if (ret !=3D -EAGAIN) {
> > > +                     ut_assertok(ret);
> > > +                     runs++;
> > > +             }
> > >       }
> > >
> > >       return 0;
> >
> > How did you trigger this case exactly?
>=20
> I noticed this in CI, where some skipped tests were shown as failed in
> the log, even though they were not counted as failures in the final
> results.

That's really really strange, do you have an example log or something
around still?

--=20
Tom

--AHfEoxGm7XccCPDs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZ60MgACgkQFHw5/5Y0
tyxSOwv6ApanqHQYHrbF48ocT6qHPCNBErEku5NKELgChzfkqrBmgRQ0/hRvg3lO
SayHzpmdxb1p34y8Fnk5Neiw5VzX+yjZXSFWV5qt+aU+lFw1xs/saq7a6gHIl+XQ
qbZPI6kGCRQvnCRbyNPIWZlisjZaZUOxgnWCbfTIx4raMDs89Jy9kjTjBtTKd4i4
ExuTXe/s6bzie8DRD66v/hwP27UlHTmNYt06qfYKJrc3pa6CzsprtcRzBif7mQ0W
UK931Hfn2aNpYrizuz2DNZIMddLpb35S907XsNidwGbMQn14RWr0eoTbO4UBMbFV
ujDLZtccP1mRc3Ll7ybF3NOn41rVuO5pZHbPfkzzFvlG1+i7jPn09vfAVSIQ0XU6
Y5sXksHjlrifnRteiE/Ah2IKY4D0glcjDTWBt+/68cpR4fgyL5FQmbzn0gsHo86c
ta1urjzEq+VAGQmKuAYpD3MZ6RACJei0SJdODIAnOnyyCdEXEVufuw9K7paoYynz
VgkW4tPq
=6j7K
-----END PGP SIGNATURE-----

--AHfEoxGm7XccCPDs--
