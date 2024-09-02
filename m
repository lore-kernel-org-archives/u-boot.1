Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD05BCD13CF
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 15:39:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 430E488363;
	Mon,  2 Sep 2024 17:39:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fBpxlyqE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4461B88883; Mon,  2 Sep 2024 17:39:11 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 043CF88327
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 17:39:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3dd16257b7bso1602026b6e.1
 for <u-boot@lists.denx.de>; Mon, 02 Sep 2024 08:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725291548; x=1725896348; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=F5q6C1YsTPBwiQ80RDSitJS+bLU5vzFVXu/RODb42ZQ=;
 b=fBpxlyqE/dx7SAtExMxrQrjEdyNPe/NOed+0B9v332IJi01soTBzzOFVx1f/WSxPR7
 1nW4jzEQD8JnIL2g7deYZ95vMzUPhVhqKRde+ZNZHVOvhucyKdpcYDlzVa6TrSvac5VU
 BzSpyWJq9vuCM0oTripS7XIG7m3cuX0+uv39M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725291548; x=1725896348;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F5q6C1YsTPBwiQ80RDSitJS+bLU5vzFVXu/RODb42ZQ=;
 b=vk9rCt4L7xR2bE5gx0XeLJZvgvgodmvO2Cd17HTuYWbD6Td3lU2bDm9BoLCTYcuQf0
 dkHD2DZkkdnLKrx4edNNcLoZLBmHNUbsF76CapbDF+03Dy2m+5xC4LTcY2uVYgZbVu8h
 m5sAmYdQtRODqGNQmALW8cfJlaNGQYzQ71NUDlNNjPRYKfmSV4aRgkBs9HjWkXKAhjMB
 2zroRNMVxFNGUBMtvkhNwNFanWzF64Xx8+FWUk9+f22/m896W5i4ZvokB9GDpJRfkiwr
 +GenZGDKRaDiaU36+iKDplDxCQOkKvhXjaYYtNLMcjtfocQcOJh7cSVr2S66k2XlTbF7
 zRbg==
X-Gm-Message-State: AOJu0YzBYsffsSFUOAyWeKTGnKyvxgW5FizL+Z087MKfFK0os0La9ayJ
 85MN5SUKR/byBagzc6nV3tUpAMzt6uOhuEUBKifdJZv/7t2StinUQQuOu7sEOCs=
X-Google-Smtp-Source: AGHT+IGZmFrk6zXy1/jgFlzSKF+qRfSjV1FLzJNFpwTDo7/iiJdkoyF41UgwvC/pb961o6v6fjopmA==
X-Received: by 2002:a05:6808:1206:b0:3d9:2c62:72b4 with SMTP id
 5614622812f47-3df1c0d2a21mr8234248b6e.19.1725291547610; 
 Mon, 02 Sep 2024 08:39:07 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45682d67e19sm40501551cf.63.2024.09.02.08.39.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Sep 2024 08:39:07 -0700 (PDT)
Date: Mon, 2 Sep 2024 09:39:04 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v3 2/3] buildman: Allow skipping the dtc build
Message-ID: <20240902153904.GX2479150@bill-the-cat>
References: <20240815195746.749042-1-sjg@chromium.org>
 <20240815195746.749042-3-sjg@chromium.org>
 <20240816172237.GA1626301@bill-the-cat>
 <CAFLszTh1Nig-hs+Gtxzg8f-=vE1z4BvNSfEyUGtatZohj0pnuQ@mail.gmail.com>
 <CAFLszTgufCxvXjJupqDphcGwJ0gfvrYxQACK3kYRKaumpKgrYQ@mail.gmail.com>
 <20240822141013.GQ1626301@bill-the-cat>
 <CAFLszTiV8Nut06NeJFqT87y8qSTfzMYwxY6vc10+Q6NY6u2m-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lpeFPnBItdPXO4J3"
Content-Disposition: inline
In-Reply-To: <CAFLszTiV8Nut06NeJFqT87y8qSTfzMYwxY6vc10+Q6NY6u2m-A@mail.gmail.com>
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


--lpeFPnBItdPXO4J3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 01, 2024 at 02:09:39PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 22 Aug 2024 at 08:10, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Aug 21, 2024 at 09:00:25PM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Fri, 16 Aug 2024 at 17:53, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Tom,
> > > >
> > > > On Fri, 16 Aug 2024 at 11:22, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Thu, Aug 15, 2024 at 01:57:45PM -0600, Simon Glass wrote:
> > > > >
> > > > > > For most boards, the device-tree compiler is built in-tree, ign=
oring the
> > > > > > system version. Add a special option to skip this build. This c=
an be
> > > > > > useful when the system dtc is up-to-date, as it speeds up the b=
uild.
> > > > > >
> > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > ---
> > > > > >
> > > > > > (no changes since v1)
> > > > > >
> > > > > >  tools/buildman/builder.py       | 27 +++++++++++++++++++++++++=
+-
> > > > > >  tools/buildman/builderthread.py |  4 ++--
> > > > > >  tools/buildman/buildman.rst     |  3 +++
> > > > > >  tools/buildman/cmdline.py       |  2 ++
> > > > > >  tools/buildman/control.py       |  3 ++-
> > > > > >  tools/buildman/test.py          | 31 +++++++++++++++++++++++++=
++++++
> > > > > >  6 files changed, 66 insertions(+), 4 deletions(-)
> > > > >
> > > > > We should probably do this more generically, outside of buildman.=
 We
> > > > > have scripts/dtc-version.sh and if the system version isn't new e=
nough
> > > > > (and we just need to define whatever the minimum version is), the=
n we
> > > > > build our (not currently that new anymore) dtc instead.
> > > >
> > > > Yes I think I did a patch for that ages ago [1], but it was rejecte=
d.
> > > >
> > > > I'd be very happy for it to be applied as I think it is a better
> > > > solution than this one.
> > > >
> > > > I see that some poor sod tried to do this in Linux this morning.
> > >
> > > Any thoughts on that patch?
> >
> > I'm open to re-considering [1] again, but we need to handle the warning
> > problem first. That means...
> >
> > > Also I do see one problem. Newer dtc version produce a lot of
> > > warnings, which causes CI to fail. So if we always use the newest
> > > version, people are going to see a ton of warnings when they run
> > > locally. Am I missing something here?
> >
> > Well, it would be great to get our Kbuild logic anywhere close to
> > in-sync again with upstream. But syncing up the disabling warning flags
> > shouldn't be too hard.
>=20
> So, coming back to this patch, the nice thing about it is that it is
> deterministic. So people who build U-Boot and don't want funky
> behaviour will be happy. It will use the internal dtc by default. To
> use the external one, you must provide an option.
>=20
> This patch only affects buildman, but as you can see the mechanism it
> uses is to set the DTC variable, which people can do without buildman.
> It's just a convenience, but useful enough to have a flag, I believe.

Wait, that's right, we have DTC as a thing that can be set in the
environment, so why do we need something for buildman at all?

--=20
Tom

--lpeFPnBItdPXO4J3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbV3A4ACgkQFHw5/5Y0
tywBlwwAuBodfSHQ52BAoqxfXOmMWjPd+zp2iMqH8VSeslm32X0o6frln3qKoxt0
3FhtrBQNBXxGwTqsL8tXB9lLYh0lzB7U7VVgoKOMmKCJpzuQRJdzyQu2QYGTUTZs
e9HiRFxlxNWPiVoaeuBsteeQPgG4tHB26LRtu/qbMg/cmq+hNkExI1wSagTbkhT9
WZr/U0iEjVMkbGPhG/dYtvR2rGc9vHvbBVSLN/SjJ/IWU4iCSftcUGFPO4nh+oFn
fnqZEjKtZWIveWQ14lktEwvk6qcKJ/qFzg0/cVnMgi1HmCdw++xNQXOOAFreZ9Mr
fFGXa5D7m1E8t5Zq2q51nEEoCk7yh7jM3LBy8P/1PlNkhNPB7dDfHj/aALlnYMRQ
98jQYxKDnkk6cWZ5qSmHKifaeFzm/qKVJrYCGTjGauntg8VVQ0C1kVW+weo1a8Cg
tumKJCgfwcgAmlS4fv1xsrUkxgL8FDSoRGK3uvypoc1W1CKhhJ5BGPOKiw0Ve9bn
yW90jDz6
=SPbP
-----END PGP SIGNATURE-----

--lpeFPnBItdPXO4J3--
