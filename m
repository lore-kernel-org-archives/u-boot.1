Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57FB6C3DA6E
	for <u-boot@archiver.kernel.org>; Sun, 31 Dec 2023 14:29:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D420487613;
	Sun, 31 Dec 2023 15:29:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="trV8jeFx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D50987613; Sun, 31 Dec 2023 15:29:31 +0100 (CET)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34E47875A0
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 15:29:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-67f83812a32so45040296d6.3
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 06:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1704032965; x=1704637765; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RkyvzXjmYtpzNYGCWdHMYcRLVd5pMUyUZDEsD9y0O6w=;
 b=trV8jeFxbYCBFa6rUqEAOqIC78dUZ0QWITjYb0St/T6d9gzT7Rm37MYCfEpeCTEVDW
 dk6/tvAkxZHq8QCcrnmMAGNb6+RFiLWPsMcSW1w1EFMI4PINGENHCnA6xY5+WlU2ibvS
 LZQwmr2BbH7yu4CtvPnGkNRS81z0BraJwkQ1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704032965; x=1704637765;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RkyvzXjmYtpzNYGCWdHMYcRLVd5pMUyUZDEsD9y0O6w=;
 b=QNvNcr/mzz1cXBcmM3Vh8PFCOVKhEZ/OXAs+MkihULaFRfUEN42YAQ0E06mM/XNKPi
 klrtn9/DvEvjRnWcla/KWpR+YABEkDHf8oBiWqy0FVIq/rUbFmS/x6E/dEiDAlDtrVMg
 z8v3XeOVoDevFISbHymrBHwqbpAeh9VpkPM0xu6R3hGrl/vAdAgutjYJU700eHDHtwqc
 x732nAYQXDFY2Fs8DWETYf4RAMMeMmFupuvapFGObF/puBhSiSCq0942/gKGLazrZUTA
 Pie2Bj8msZtYyupCfOTzzBQyAjjVbfN6n5/Rw6QagwYfzkeld33fArABj4hiH9llMWey
 HJ0Q==
X-Gm-Message-State: AOJu0YzSK1ro09vcM/5n7FRZ5w60ewPCu9GZDH929n1PdEVi/B/tmqs/
 ScX5SOcbMkhMF1QoIolhXGdrcJ9Ra9g37cRlmlPegkL3SF4=
X-Google-Smtp-Source: AGHT+IGyV/OFLhkkbNeXX8ZNY3JQlSCuLb1HLaCh1zGTU3mmDQju9L3STu2Fd4YLQjFYe4laNqZDUA==
X-Received: by 2002:a05:6214:248d:b0:67e:b7ce:9668 with SMTP id
 gi13-20020a056214248d00b0067eb7ce9668mr17803220qvb.23.1704032964979; 
 Sun, 31 Dec 2023 06:29:24 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 bd18-20020ad45692000000b0067eff6713a8sm8713638qvb.87.2023.12.31.06.29.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Dec 2023 06:29:24 -0800 (PST)
Date: Sun, 31 Dec 2023 09:29:22 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Raymond Mao <raymond.mao@linaro.org>, Marek Vasut <marex@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Baruch Siach <baruch@tkos.co.il>, Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerry Van Baren <vanbaren@cideas.com>, Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Nikhil M Jain <n-jain1@ti.com>, Qu Wenruo <wqu@suse.com>,
 Sean Anderson <seanga2@gmail.com>, Stefan Roese <sr@denx.de>
Subject: Re: [PATCH v6] fdt: Allow the devicetree to come from a bloblist
Message-ID: <20231231142922.GB2652760@bill-the-cat>
References: <20231228194725.2482268-1-sjg@chromium.org>
 <20231228212429.GR2652760@bill-the-cat>
 <CAFLszTif8GwJYdKF5Mq=gBB-ZW4wjJ7B9cjHRJdNi=QVAxMo=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DlR1KQtjqFIAHrAV"
Content-Disposition: inline
In-Reply-To: <CAFLszTif8GwJYdKF5Mq=gBB-ZW4wjJ7B9cjHRJdNi=QVAxMo=w@mail.gmail.com>
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


--DlR1KQtjqFIAHrAV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 31, 2023 at 05:47:30AM -0700, Simon Glass wrote:
> Hi,
>=20
> On Thu, Dec 28, 2023 at 2:24=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Thu, Dec 28, 2023 at 07:47:25PM +0000, Simon Glass wrote:
> >
> > > Standard passage provides for a bloblist to be passed from one firmwa=
re
> > > phase to the next. That can be used to pass the devicetree along as w=
ell.
> > > Add an option to support this.
> > >
> > > Tests for this will be added as part of the Universal Payload work.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > [snip]
> > > diff --git a/dts/Kconfig b/dts/Kconfig
> > > index 00c0aeff893..ae451b9caf7 100644
> > > --- a/dts/Kconfig
> > > +++ b/dts/Kconfig
> > > @@ -105,6 +105,19 @@ config OF_EMBED
> > >
> > >  endchoice
> > >
> > > +config OF_BLOBLIST
> > > +     bool "Provided by a bloblist at runtime"
> > > +     depends on BLOBLIST && OF_SEPARATE
> >
> > This is now even more confusing, frankly. The help for OF_SEPARATE says:
> > If this option is enabled, the device tree will be built and placed as a
> > separate u-boot.dtb file alongside the U-Boot image.
> >
> > So why would you enable that to then have a device tree passed via
> > bloblist instead?
>=20
> Historical....

Sorry, I mean the help text doesn't make any sense, with your patch. So
that needs to be fixed. That's part of how everyone else is going to try
and understand this mess of options afterwards.

> > We should probably start by fixing all of this confusing naming / logic
> > and then correct things such that:
> > - OF_EMBED wins if set. This is the override-has-been-set we-must-use-it
> >   switch. First choice, not last choice. If binman needs tweaks so that
> >   it will still generate images for platforms in this case, that needs
> >   to happen.
>=20
> Perhaps we should rename this to OF_EMBED_DEBUG ? Really it should not
> be used by any board.

It may or may not be appropriate for use by boards, in production. Maybe
future designs can avoid this, but I think current ones cannot. But
that's also a separate thread an cleanup task to bring up. Again, I
suspect one of the use cases here is "embed the DTB so that we secure
boot check and validate a single memory range".

> > - If we have a bloblist, we scan the bloblist for DT and if found, use
> >   it.
>=20
> unless we don't want to, e.g. because that DT has a bug or we want to
> use a different one during development.

Nope. If the bloblist has a bug we either have to perform a fixup (the
bloblist can't be changed but it's a situation where we're less strict)
or for development go back up to OF_EMBED. That's the switch for
development where you changed the device tree.

> > - If it looks like we've been booted as a fake Linux kernel, and we can
> >   start with just aarch64 and let riscv come in as a follow up, so
> >   what's documented within
> >   https://www.kernel.org/doc/html/latest/arch/arm64/booting.html#call-t=
he-kernel-image
> >   then we use that device tree.
>=20
> Eek, really? Is this the rpi case and you are trying to make it
> generic? I would rather that be a board-specific thing, calling into a
> generic implementation. We should encourage bloblist.

No, it's the generic case. It's not board specific. It's what we do,
iirc, on Apple M1/M2/etc, some subsets of Tegra I believe (I know I've
done it for xavier-based systems, but then abandoned the effort),
certainly some of the older qualcomm platforms, and I believe that's one
of the entry points for the newer qualcomm platforms.

I spelled out the case above the way that I did because it's a valid
case that's not going away. In addition to the places where we can't
change the firmware chain, it's also for the places where people don't
want to change the firmware chain, or because it's an important bringup
path.

And part of the problem here is that we've just done it ad-hoc so many
times that it's scattered about the tree.

> >   - This _may_ just end up having to be "Does x0 (or similar) point to a
> >     valid DT?" as I don't know how correct everything using this method
> >     today is too what the spec above lists.
>=20
> OK, well a generic impl would be good I suppose, but dereferencing
> pointers to look for a magic number might not end well.

It's a long standing ad-hoc standard.

> > - If we have a dtb appended to use by what we call today OF_SEPARATE but
> >   should really stop calling it that we use that.
>=20
> Yes it is a complete misnomer now. I will try to think of a better
> name. It really just controls generation of u-boot.dtb and what goes
> in u-boot.bin so perhaps we can just drop it and have OF_EMBED be
> false in the normal case. Or rename to OF_STANDARD ?

I'm not sure about the name either.

> > At that point, we can probably have zero "totally board specific kludge
> > for device tree location", and kill off OF_HAS_PRIOR_STAGE too (since
> > that's really just bloblist or fake-linux-kernel). We'll also be able to
> > support migration from fake-linux-kernel to bloblist
>=20
> OF_HAS_PRIOR_STAGE controls things like building the DT

No, it doesn't.  Please re-read the code as it stands today. What it
does control is..

> and OF_BOARD

Yes, it then has OF_BOARD be enabled by default. And also OF_OMIT_DTB,
which is a funny negative symbol (enable OF_OMIT_DTB to not perform
action).

> ... which from what you say above can perhaps go away. But there are
> quite a lot of board_fdt_blob_setup() functions...it doesn't look like
> they are all the same.

Looks fairly common to me, I see a handful of "implement arm64 linux
kernel boot", then "whatever riscv is doing", and "get dtb from ATF".
Where that last one should be able to migrate to bloblist if I
understand things right and so we'll need to ask the maintainers what
they need long term here. There's very few "grab dtb from NOR flash",
but they do exist.

> Automatic is OK I suppose. I just want to make sure that these things
> can be disabled easily so it is possible to use the DT built by U-Boot
> without hacking the code. That is my goal with having a Kconfig to
> enable this mechanisms.

But the rest of us still don't understand your use case, or all of your
use cases, is the sticking point. Ideally, if a bloblist is possible, it
should have the dtb. Otherwise, if we're passed a DTB because something
thinks it's booting the OS, that's the DTB the OS must get (or at least
the starting point of it). Otherwise, yes, if we have our own DTB, we
can give that to the OS. To try and rephrase something you've said,
BLOBLIST=3Dy && OF_BLOBLIST=3Dn should only be a developer option. So why
can't we just use the developer option we have today? Other than that
it's currently last-case, not first-case, which is wrong.

--=20
Tom

--DlR1KQtjqFIAHrAV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWRercACgkQFHw5/5Y0
tyyplAv/cQh6LIX12JCrmLInHCzBBNpFznUdr9Lj63RWi5NI22RxSwSlS9AbN23j
zvJX21oNSF42op3/VEvUypDlS8umvGc9nmwZi17XAuqPnWC70fhTstYiTO96Sz/V
n4o8bWAmC7XzviJopeRjExkDXawy7L4D3V7SiL4ceVl2O0YKD40G5+OevLFNuW5Z
C7J6Oi9T6vypgkzXsVNjtatWtfvFNT1DLGjD5iqbdndDmYxoojVqL+DRL2Nm/XqQ
prwu7hvyH6AhcSjqwra3ic2JsYleBOlS2hSJnUWBXJB52BYP8vt6mP6qxQnPmuCP
eq9lhCdB2Smi6csG3sxmd+6M68kBXXy6n6bnnedEN/0OTKlaPhGw01QE8O6Wc0Y7
DhYHXU9II2K69waCuwf2tErkhQpAK3poQsLpKImUuGvs5vrsgkmbdYLEg2zSYwpQ
Y48gnZ4nUVzdW6cx8EFYR7yLgmaV/oMCwrsEC7qbAEjI4sJfqhdUblMzvx4OPvH6
l6IwSPzO
=bj1Q
-----END PGP SIGNATURE-----

--DlR1KQtjqFIAHrAV--
