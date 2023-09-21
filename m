Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DBCDE7108E
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 15:36:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2F90866D0;
	Thu, 21 Sep 2023 17:36:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="b3YoyTJS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 364F286ABC; Thu, 21 Sep 2023 17:36:03 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B026865A6
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 17:36:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-59bdb3d03b1so13907997b3.3
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 08:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695310560; x=1695915360; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ygxPTfMtM7cuHpOj6D0+9iGjhS9yM0/zKfmMMtgbyII=;
 b=b3YoyTJSw5V3DLBKzmfyzCZ9CHEfFkIsRachnYd0IrB5F8PYyGZ7NFUze7wL3rsTY7
 iaphGcbazR4Hkp65YJplMQNmoqjYfjFZViRNK2jiCI5pPZh25bIOdJTZXZwOSxAWNP70
 5abNoeURxTGSTaXAu2qw9sLQuJ/YCAgoXFzOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695310560; x=1695915360;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ygxPTfMtM7cuHpOj6D0+9iGjhS9yM0/zKfmMMtgbyII=;
 b=kA1xd7fwKpyhDN2+WC9SqVWgVp75ZczsyUE7OapCJs1H6Yxxl5ybbisGpR+6G366dz
 S2yX9urWPU9ZkO+7VhhL0vmpULEq5mUAOrsZVNkKIarxT1vrb/2+Os3GSZ96HBpmStbc
 GMPMGUHG0jpPfUQF1Do5Qis402YJnQctY5gLkiNC9utcjAtWi6TnM0ob5uC2N9jXI0BE
 ZnzplMgYsAq9zwsgk/oKZhgyITaZYREnX3t1yzRkC02t4JD4/loZ05odv1fHOem98P6r
 pGmLiIeziHl3Xwk6zBB3aYvnSmqsZRxONV4z6Kobhi+LEqJOwE16YyKEhiXZegK2T2zE
 qkmQ==
X-Gm-Message-State: AOJu0YwqIP2fgsdSXYGXgiKV4xX/aEcfeu99Fi4xtRL7jdyjV2Uz/P3z
 9IRfIh71Shjhs5xGuI5EmONRGbql8zgodgTR2H+AJA==
X-Google-Smtp-Source: AGHT+IEHQaReEykartNu8rU4EP3ZZtnzOTR4MtejNH5KRTj8oKBr3ibh17IBzzgpQdo4JAqp7ijE7Q==
X-Received: by 2002:a81:54c4:0:b0:585:ef4e:6d93 with SMTP id
 i187-20020a8154c4000000b00585ef4e6d93mr5709261ywb.47.1695310559777; 
 Thu, 21 Sep 2023 08:35:59 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-46ac-83a0-07b5-e9a6.res6.spectrum.com.
 [2603:6081:7b00:6400:46ac:83a0:7b5:e9a6])
 by smtp.gmail.com with ESMTPSA id
 x9-20020a814a09000000b00589c103d00asm379495ywa.79.2023.09.21.08.35.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 08:35:59 -0700 (PDT)
Date: Thu, 21 Sep 2023 11:35:57 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Marek Vasut <marex@denx.de>,
 Bin Meng <bmeng@tinylab.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Nikhil M Jain <n-jain1@ti.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Stefan Roese <sr@denx.de>
Subject: Re: [PATCH 09/32] spl: Avoid an #ifdef when printing gd->malloc_ptr
Message-ID: <20230921153557.GR305624@bill-the-cat>
References: <20230830180524.315916-1-sjg@chromium.org>
 <20230830180524.315916-10-sjg@chromium.org>
 <20230830213916.GL3101304@bill-the-cat>
 <CAPnjgZ165AgX0VTWWbHTiEfwP_R5qdwcUQKWoJ7x3G0PYHT3aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="aZXbDJRcb6VmmO4x"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ165AgX0VTWWbHTiEfwP_R5qdwcUQKWoJ7x3G0PYHT3aw@mail.gmail.com>
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


--aZXbDJRcb6VmmO4x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 20, 2023 at 07:03:34PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 30 Aug 2023 at 15:39, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Aug 30, 2023 at 12:04:40PM -0600, Simon Glass wrote:
> > > Use an accessor in the header file to avoid this.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > >  common/spl/spl.c                  | 9 +++++----
> > >  include/asm-generic/global_data.h | 7 +++++++
> > >  2 files changed, 12 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/common/spl/spl.c b/common/spl/spl.c
> > > index f0a90c280da..f5cef81000c 100644
> > > --- a/common/spl/spl.c
> > > +++ b/common/spl/spl.c
> > > @@ -876,10 +876,11 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
> > >       } else {
> > >               debug("Unsupported OS image.. Jumping nevertheless..\n"=
);
> > >       }
> > > -#if CONFIG_VAL(SYS_MALLOC_F_LEN) && !defined(CONFIG_SPL_SYS_MALLOC_S=
IZE)
> > > -     debug("SPL malloc() used 0x%lx bytes (%ld KB)\n", gd->malloc_pt=
r,
> > > -           gd->malloc_ptr / 1024);
> > > -#endif
> > > +     if (IS_ENABLED(CONFIG_SYS_MALLOC_F) &&
> > > +         !IS_ENABLED(CONFIG_SPL_SYS_MALLOC_SIZE))
> > > +             debug("SPL malloc() used 0x%lx bytes (%ld KB)\n",
> > > +                   gd_malloc_ptr(), gd_malloc_ptr() / 1024);

This is not more readable.  But I guess my comment was unclear as you're
mixing changes here.  gd_malloc_ptr() rather than gd->malloc_ptr is a
wash, to me.  I think one could argue it's not a helpful abstraction.
but it's so that you can avoid CONFIG_VAL here, and say "if (...)" not
"#if ..." here.

> > > +
> > >       bootstage_mark_name(get_bootstage_id(false), "end phase");
> > >  #ifdef CONFIG_BOOTSTAGE_STASH
> > >       ret =3D bootstage_stash((void *)CONFIG_BOOTSTAGE_STASH_ADDR,
> > > diff --git a/include/asm-generic/global_data.h b/include/asm-generic/=
global_data.h
> > > index 8fc205ded1a..edf9ff6823f 100644
> > > --- a/include/asm-generic/global_data.h
> > > +++ b/include/asm-generic/global_data.h
> > > @@ -573,6 +573,13 @@ static_assert(sizeof(struct global_data) =3D=3D =
GD_SIZE);
> > >  #define gd_malloc_start()    0
> > >  #define gd_set_malloc_start(val)
> > >  #endif
> > > +
> > > +#if CONFIG_VAL(SYS_MALLOC_F_LEN)
> > > +#define gd_malloc_ptr()              gd->malloc_ptr
> > > +#else
> > > +#define gd_malloc_ptr()              0L
> > > +#endif
> > > +
> > >  /**
> > >   * enum gd_flags - global data flags
> > >   *
> >
> > This is another case where readability is not improved. I also have a
> > bad feeling that changing that exact area had some unintended
> > consequences from the compiler, that totally should not have happened.
> > But maybe that was something in a similar code section instead.
>=20
> The improvement is in the C file...here we have an accessor in the
> header file as has been done elsewhere.
>=20
> Do you have any more details on the problem you mention? I will align
> the accessor to the struct member which should resolve it.

It's unfortunately one of those cases to do a global before/after build
and see if anything does or does not get tripped up.  As I believe I did
use CONFIG_VAL there and not a check on CONFIG_SYS_MALLOC_F itself for a
reason, at the time.

--=20
Tom

--aZXbDJRcb6VmmO4x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUMYtwACgkQFHw5/5Y0
tyxxzAv/bsVOk45z39eDGZIzC4SUY75k/WwWDI+t5TWSNrPf/+fDyZuF7AcvkLZA
ztdJHezFVZNaLiB7YgR7tzgk6P/cSRvJnaUtAiVlNmbSQj4uUmkPDDXR3e/hxV+Y
mSYKtwLeZHa3yNv9Uk0bxvnxhgmGTYF1UrRFg7flRgmUiUaDK+yro//HJMQ9bTLo
yKX8xJKfxiu6RPOIX2e8iQ4+aH3TQ7+xgY0B0I1jYQoR2dc/mbE2fh6RGbsCVatf
y9m+971AElQYoHO0FPH8tjW8/pzwIa/M45TDabwaYoB4D67Ljc5pzmkUy4Ob4LQn
RWuw4oXxKj9zsuXzFKM1aT6/1roFZgI3yo/J9Vj2HK8A/TcRiDul4F2YZiEEARRx
SFxnPWp/XdeSqsZgMh+IqTYY2Pa6/evz8uzDFk9VM2Gk6o6M0pez+KCnHaxeo3KD
wqqHptr5ER0GrlXS3G/E4Fi4G9fYeHucIwsFZrCk9wJNTCzFvQw2uDrDdXUrwTL7
w6SueAtv
=Q2nG
-----END PGP SIGNATURE-----

--aZXbDJRcb6VmmO4x--
