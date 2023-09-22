Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC8E6CD4854
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 19:28:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97A3F86529;
	Fri, 22 Sep 2023 21:28:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mad0xZhM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 216A08640F; Fri, 22 Sep 2023 21:28:56 +0200 (CEST)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38B948652A
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 21:28:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-d8195078f69so2983196276.3
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 12:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695410931; x=1696015731; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RPNh5IKk4OV6xyudUNWgx3IHTWOJZ7VlXRYF5y1pJMQ=;
 b=mad0xZhMqz8phErDIlO828Auslq0+Bsk1FXKvqyJq1itXTcf6/IexTW6QulQTR1r4K
 j2BRz8E97QAu28Lg2w2a6mw20WH4hNg9Hs27/2VGw1MnYxg7o8rgKk7y4XcXR/tHdG2p
 j+6Ot5rhgVIeRgppGc30ycdQOGFj5XUr3WACA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695410931; x=1696015731;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RPNh5IKk4OV6xyudUNWgx3IHTWOJZ7VlXRYF5y1pJMQ=;
 b=pvpXVr4zYM7D5sF9kbwtqDdaAYPRCL7dYBWWCit1zqErnxy0SnIlb1IRt02Fkrkr65
 xpCvlwpLRRHaOaQy2qf6OvOVBPgQoa0N+p1Z3qj+4+ZtI11Iefj7S41AKVDB1Irkwwjs
 JK9YEMUt5Rhx8yQzbJNINmxm/MVI/B6KG8er076t6/GQb01VM2EgySTNooew3RLwGgXQ
 XJTpWEIytfsNRgAVq4un+1w57Xi6ttyPQ24rLwa6NYRz+Lc0bIvFkemgoJfbIfxxDO8r
 uu8iz8oBTo9WeIgYYvnGfdvAImO5m4DmtZp/Hq8a/NX/1twkEmNeAj72BJYcDIf91NUd
 iFtQ==
X-Gm-Message-State: AOJu0YzJiEBsYeARLZycOpSxdaaRdEAMZ+2fclM3dS6A0TWuUJ0yLHm8
 FRy35MbmSpz/Oo9suhNgfVq15w==
X-Google-Smtp-Source: AGHT+IHbp2zhdi6knTx8GW60pXZqoq/nRTR4h1HghD+iAKmXzridPhGJ2Q5GQtAJIoBlHm5SOTYZgA==
X-Received: by 2002:a25:38f:0:b0:d81:89e9:9f48 with SMTP id
 137-20020a25038f000000b00d8189e99f48mr230371ybd.63.1695410930751; 
 Fri, 22 Sep 2023 12:28:50 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-b22c-a20b-ddfe-6409.res6.spectrum.com.
 [2603:6081:7b00:6400:b22c:a20b:ddfe:6409])
 by smtp.gmail.com with ESMTPSA id
 e141-20020a25e793000000b00d77928cdcf6sm990332ybh.15.2023.09.22.12.28.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 12:28:49 -0700 (PDT)
Date: Fri, 22 Sep 2023 15:28:47 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Marek Vasut <marex@denx.de>,
 Bin Meng <bmeng@tinylab.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Nikhil M Jain <n-jain1@ti.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Stefan Roese <sr@denx.de>
Subject: Re: [PATCH 09/32] spl: Avoid an #ifdef when printing gd->malloc_ptr
Message-ID: <20230922192847.GD305624@bill-the-cat>
References: <20230830180524.315916-1-sjg@chromium.org>
 <20230830180524.315916-10-sjg@chromium.org>
 <20230830213916.GL3101304@bill-the-cat>
 <CAPnjgZ165AgX0VTWWbHTiEfwP_R5qdwcUQKWoJ7x3G0PYHT3aw@mail.gmail.com>
 <20230921153557.GR305624@bill-the-cat>
 <CAPnjgZ0ZqySaVa6LKWz7p7h8gjH1yTsLtds_8hF+DEXQGC459g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="G2JIrR3shCq0JPw9"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ0ZqySaVa6LKWz7p7h8gjH1yTsLtds_8hF+DEXQGC459g@mail.gmail.com>
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


--G2JIrR3shCq0JPw9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 22, 2023 at 12:27:36PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 21 Sept 2023 at 09:36, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Sep 20, 2023 at 07:03:34PM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Wed, 30 Aug 2023 at 15:39, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Wed, Aug 30, 2023 at 12:04:40PM -0600, Simon Glass wrote:
> > > > > Use an accessor in the header file to avoid this.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > ---
> > > > >
> > > > >  common/spl/spl.c                  | 9 +++++----
> > > > >  include/asm-generic/global_data.h | 7 +++++++
> > > > >  2 files changed, 12 insertions(+), 4 deletions(-)
> > > > >
> > > > > diff --git a/common/spl/spl.c b/common/spl/spl.c
> > > > > index f0a90c280da..f5cef81000c 100644
> > > > > --- a/common/spl/spl.c
> > > > > +++ b/common/spl/spl.c
> > > > > @@ -876,10 +876,11 @@ void board_init_r(gd_t *dummy1, ulong dummy=
2)
> > > > >       } else {
> > > > >               debug("Unsupported OS image.. Jumping nevertheless.=
=2E\n");
> > > > >       }
> > > > > -#if CONFIG_VAL(SYS_MALLOC_F_LEN) && !defined(CONFIG_SPL_SYS_MALL=
OC_SIZE)
> > > > > -     debug("SPL malloc() used 0x%lx bytes (%ld KB)\n", gd->mallo=
c_ptr,
> > > > > -           gd->malloc_ptr / 1024);
> > > > > -#endif
> > > > > +     if (IS_ENABLED(CONFIG_SYS_MALLOC_F) &&
> > > > > +         !IS_ENABLED(CONFIG_SPL_SYS_MALLOC_SIZE))
> > > > > +             debug("SPL malloc() used 0x%lx bytes (%ld KB)\n",
> > > > > +                   gd_malloc_ptr(), gd_malloc_ptr() / 1024);
> >
> > This is not more readable.  But I guess my comment was unclear as you're
> > mixing changes here.  gd_malloc_ptr() rather than gd->malloc_ptr is a
> > wash, to me.  I think one could argue it's not a helpful abstraction.
> > but it's so that you can avoid CONFIG_VAL here, and say "if (...)" not
> > "#if ..." here.
>=20
> Yes,
>=20
> >
> > > > > +
> > > > >       bootstage_mark_name(get_bootstage_id(false), "end phase");
> > > > >  #ifdef CONFIG_BOOTSTAGE_STASH
> > > > >       ret =3D bootstage_stash((void *)CONFIG_BOOTSTAGE_STASH_ADDR,
> > > > > diff --git a/include/asm-generic/global_data.h b/include/asm-gene=
ric/global_data.h
> > > > > index 8fc205ded1a..edf9ff6823f 100644
> > > > > --- a/include/asm-generic/global_data.h
> > > > > +++ b/include/asm-generic/global_data.h
> > > > > @@ -573,6 +573,13 @@ static_assert(sizeof(struct global_data) =3D=
=3D GD_SIZE);
> > > > >  #define gd_malloc_start()    0
> > > > >  #define gd_set_malloc_start(val)
> > > > >  #endif
> > > > > +
> > > > > +#if CONFIG_VAL(SYS_MALLOC_F_LEN)
> > > > > +#define gd_malloc_ptr()              gd->malloc_ptr
> > > > > +#else
> > > > > +#define gd_malloc_ptr()              0L
> > > > > +#endif
> > > > > +
> > > > >  /**
> > > > >   * enum gd_flags - global data flags
> > > > >   *
> > > >
> > > > This is another case where readability is not improved. I also have=
 a
> > > > bad feeling that changing that exact area had some unintended
> > > > consequences from the compiler, that totally should not have happen=
ed.
> > > > But maybe that was something in a similar code section instead.
> > >
> > > The improvement is in the C file...here we have an accessor in the
> > > header file as has been done elsewhere.
> > >
> > > Do you have any more details on the problem you mention? I will align
> > > the accessor to the struct member which should resolve it.
> >
> > It's unfortunately one of those cases to do a global before/after build
> > and see if anything does or does not get tripped up.  As I believe I did
> > use CONFIG_VAL there and not a check on CONFIG_SYS_MALLOC_F itself for a
> > reason, at the time.
>=20
> But the CONFIG_VAL symbols actually depends on CONFIG_SYS_MALLOC_F, so
> I can't imagine what it might be. Of course if the value is 0, then
> the 'if CONFIG_VAL()' test would fail, but to what purpose?

Yes, there's been a time or two where I banged my head against the
figurative wall trying to understand what exactly the compiler could be
seeing as why to change something.  I don't have a "reasonable"
explanation.  Readability aside, "tidy things up" changes need to be on
their own so that their impact can be seen aside from the new
functionality changes.

--=20
Tom

--G2JIrR3shCq0JPw9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUN6ukACgkQFHw5/5Y0
tyzkFgv/Q8TWEUjm0X54PszpS130jFflH6SoZ0TbVZD7biKPHjEx6mM1rBLKPual
7cl0dQw3003cR4keIqUGkaOiCvwoEEXIIHUl97Dk6irzyZA4+eo/HPbLs9hcxGz2
XqbhdrCFOKNL0cXyuR8bb4DWI6XkG+/4MXHQdDMA/i0at/2KJgLtGqgYAoJesc7f
zJ0zt52UxFe/C/AS7dr+rydTTFVZAtUwsFNn8fsGtrImZ6MqHiWuYAF0MOZ+k7Z5
zedg2Nu2Tbpf3Q04m3H7ic/pULeymrij50b4ZpHxvVUkzF1hFn6IkQV4M1lGgMpv
pRAej0SOOL2Q7h88ktwdAayU79TLxsowqiZKZK8z2S1BLyasDQaUeJDCdggu3Hoy
6WhCKWvDUPY5hkkQXsPqIuGvfs77WSecQCAis5sZHLtib6+9L2LTyVqBL3LkADR/
yvFQEjzzOvjMkI9BZG8KImdRVSWT0pn1Jbuy5n4w7YdrYBwGPEPZqn9uh+Mn8t76
ATsrzY+V
=85q5
-----END PGP SIGNATURE-----

--G2JIrR3shCq0JPw9--
