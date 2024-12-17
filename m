Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F0F0E77184
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 20:15:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D50A801CE;
	Tue, 17 Dec 2024 21:15:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="L0sMStMZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA0A9801FB; Tue, 17 Dec 2024 21:15:54 +0100 (CET)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C24780107
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 21:15:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6d8a3e99e32so50214476d6.2
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 12:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734466551; x=1735071351; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Vju8pg0g5NJhrgZANCE12zDZIFxUsDsy9Qf7xa9l/F8=;
 b=L0sMStMZ51bzYfScGN+4Z4LrXRiT4lod+dqsU0BVDawzUZ5vRPo0iGb/zfjnH3wLIO
 4doz93uEZHFpC96GKqiW1yqPeeLsabJoQXnOQ3kOslOyhVirjMuYshzfQaGDqOvAIfxg
 9U5IcS/jfuiyngg4K+RomN5ISYi5RCUQvNQ8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734466551; x=1735071351;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vju8pg0g5NJhrgZANCE12zDZIFxUsDsy9Qf7xa9l/F8=;
 b=FApRMZX+8FB0wO99owEg+MsRQ5Gk8+MUske3KYjao9e0nYHtXQaViX4pq/kA1baUWA
 /lyj302BE4AwdwhUPJ1CbvFMS4fgpL7wFazIua7YLK7uw0zhSFCYESvYqXvXotGDH9V8
 +1svRRwpBcoHbPeWg6b3gM1OpwSMKUsVKJgj4z+gofPWPhCPqXxeyDR3WHWfZMEjgnTd
 rtsKiefBli5xSkgMdfhaz304cjqIya4polwxj1t9OspVBcHhG1wmRvF/mgBJpmbrKv6I
 WYYWuR8jVs+2bYxK3cU0RYlIUhYeSv6hU1r9naoSuEw9CF8JLcbO3szu00xOrTocOnJI
 cWzA==
X-Gm-Message-State: AOJu0Yz95wMcHwHWEkOOC2vCUnyInuWB2toriBPRjXLVsnfDRXlbqhPZ
 W3yOBPEzUUQlwc5vu+I3VReb0p5OQEy7Sl3AwS9rHYX3t1lZXXmaedwh6KMXre0=
X-Gm-Gg: ASbGnctkT6vOFlz2bbT16MgiZNY+Z+bsxXD9pIkTDIYSd7sqgWqi6GkAaW1G7D30ZIs
 aWC3q3CoG+LyVEqMC6fjVgSpxdGkUy3C1v10lh6W4YeMukDGrnde6uY15M41FsqzEEC8ZByyhoH
 jCYed1f5uoJ8Xhy5SFRZOO5rlHifZw9Exdb5blBfxBijMY2c9tO+6etvRxDl0hxFr4xknhtMYGs
 UbCUx7e4YnivcN+56Ejxn/GtsPOFFAcsy1aXThDjUevFfP8DXszLyj/
X-Google-Smtp-Source: AGHT+IHQ+VEHH25jDG2D9+GPu3Scc4t7QAQRzrwBulP43i7+zM87fK8Wngh8TuGMkcYmFjqj4EeRug==
X-Received: by 2002:ad4:5e87:0:b0:6d8:a84b:b508 with SMTP id
 6a1803df08f44-6dd091ad824mr6002986d6.12.1734466550935; 
 Tue, 17 Dec 2024 12:15:50 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dccd256fd9sm42246706d6.37.2024.12.17.12.15.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 12:15:50 -0800 (PST)
Date: Tue, 17 Dec 2024 14:15:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 1/2] bloblist: Introduce BLOBLIST_PRIOR_STAGE options
Message-ID: <20241217201546.GS1505244@bill-the-cat>
References: <20241212151142.1562825-1-trini@konsulko.com>
 <CAFLszTiF8m7P8mBCNRhhiRQt=bcfRB3ddaaumF_EXETTXbUmDQ@mail.gmail.com>
 <20241213170736.GW1505244@bill-the-cat>
 <CAFLszTiPxTDqB9r+rdT4gARCA1HPx9ELO+tWELB1eKuijFvAeA@mail.gmail.com>
 <20241217040040.GJ1505244@bill-the-cat>
 <CAFLszTgaVwvJVoN=io-Djso1MuahhR9wr35VVORzQTYPLW9FFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+VQGEjgvjGf3WL+7"
Content-Disposition: inline
In-Reply-To: <CAFLszTgaVwvJVoN=io-Djso1MuahhR9wr35VVORzQTYPLW9FFw@mail.gmail.com>
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


--+VQGEjgvjGf3WL+7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 12:45:46PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 16 Dec 2024 at 21:00, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sun, Dec 15, 2024 at 05:25:24PM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Fri, 13 Dec 2024 at 10:07, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Fri, Dec 13, 2024 at 07:32:24AM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Thu, 12 Dec 2024 at 08:11, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > Introduce an option to control if we expect that a prior stage =
has
> > > > > > created a bloblist already and thus it is safe to scan the addr=
ess. We
> > > > > > need to have this be configurable because we do not (and cannot=
) know
> > > if
> > > > > > the address at CONFIG_BLOBLIST_ADDR is in regular DRAM or some =
special
> > > > > > on-chip memory and so it may or may not be safe to read from th=
is
> > > > > > address this early.
> > > > > >
> > > > > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > > > > ---
> > > > > > Cc: Simon Glass <sjg@chromium.org>
> > > > > > ---
> > > > > >  common/Kconfig | 32 ++++++++++++++++++++++++++++++++
> > > > > >  lib/fdtdec.c   | 11 +++--------
> > > > > >  2 files changed, 35 insertions(+), 8 deletions(-)
> > > > > >
> > > > >
> > > > > Since this is the essentially the same as my OF_BLOBLIST patch, w=
hich
> > > > > was rejected:
> > > > >
> > > > > NAK
> > > > >
> > > > > The issue is not whether some 'previous stage' set up a bloblist.=
 For
> > > > > example, if VPL_BLOBLIST_PRIOR_STAGE is enabled, that presumably =
means
> > > > > that TPL set it up. But it doesn't mean that TPL put the FDT in t=
here.
> > > >
> > > > This is wrong. The root problem is saying that the bloblist is in
> > > > possibly uninitialized memory. The code is quite happy to NOT find =
the
> > > > device tree in the bloblist and continue searching other paths.
> > >
> > > But until the bloblist is set up, it doesn't exist.
> >
> > An almost philosophical statement, yes. How should the generic code know
> > if it exists, or does not exist? That is the question.
>=20
> U-Boot code 'knows', since if this is the first phase which enables
> CONFIG_IS_ENABLED(BLOBLOST), then the bloblist is available
> before/after relocation as well as after RAM setup in SPL.

And when U-Boot isn't the first stage?

> > > We should not be
> > > looking for a bloblist that we know is not there yet. The bloblist is=
 set
> > > up by bloblist_init(). You seem to be imputing your own semantics for
> > > bloblist.
> >
> > We don't know if the bloblist exists or not. That's the problem. It
> > could already exist. That's the whole reason we're in this particular
> > argument.
>=20
> See above.

Yes, you seem to be missing the case where U-Boot isn't the first stage.

> > > In SPL, init happens in board_init_r(), i.e. after RAM is set up. So =
don't
> > > look in the bloblist until it is set up! It doesn't exist.
> >
> > Unless of course it was setup before. We don't know if it was setup
> > before or not until we look. A big part of the problem is that for prior
> > to U-Boot bloblist we don't need to use main DRAM, the bloblist is tiny
> > and we have some other persistent memory available. Unfortunately, x86
> > does not.
>=20
> The only situation where this matters is for the devicetree, which I
> why i created OF_BLOBLIST, a way to indicate that the bloblist should
> be checked for a devicetree.

Yes, you keep looking at this from the wrong direction and seem to have
backed yourself in to a corner. Why are you insisting that for the
normal use case of memory infos and maybe display parameters we need to
carve out a hunk of main memory? A bloblist is perfectly capable of NOT
containing things. We can avoid having to care about what phase of
things we're in too.

> > > In U-Boot proper, we look for it before relocation, so we can relocat=
e and
> > > expand it for use with ACPI tables, etc.
> >
> > I'm not sure that's relevant. This means we've taken what we were passed
> > at a fixed address and allocated more space for it and are using it
> > somewhere else.
>=20
> Yes
>=20
> >
> > > Take a look at this patch, too:
> > >
> > > 3d6531803e1 bloblist: Support initing from multiple places
> >
> > I'm not sure it's relevant. It does show we have a problem of not
> > knowing if the bloblist exists, or not. And I don't think we're solving
> > that right today (nor does v1 of my patch).
>=20
> OK
>=20
> >
> > > > An alternative here would be to better document the requirements of
> > > > BLOBLIST_ADDR, and then just disable it on chromebook_coral until
> > > > someone is inclined to move DDR init in to TPL, or someone finds a
> > > > non-main-memory address to use for BLOBLIST_ADDR or switches to usi=
ng
> > > > BLOBLIST_ALLOC.
> > >
> > > Coral's TPL runs in cache-as-ram, with a 30KB limit on code size. It =
cannot
> > > do DDR init in TPL because the DDR blob is large (160KB?) and there i=
s a
> > > ton of setup to do first, in any case. When CAR goes away, its memory
> > > vanishes, so you need to have copied the bloblist somewhere else (the
> > > bloblist holds the MRC data which needs to be written to SPI flash la=
ter
> > > on, when possible). This all works perfectly and there is really no n=
eed to
> > > change anything.
> >
> > Ah, so there's some of the details finally. And oh goodness, we're
> > writing to the SPI flash on each boot? That's not good for longevity...
>=20
> It writes a sector each time, across an area which can hold quite a
> few writes. It only writes when the details change, so it is fine.
> This algorithm has worked in the field for years across tens of
> millions of devices and is common on x86.

To be clear, I wasn't saying that its your design.

> > > Again, you seem to be imputing semantics to bloblist which don't exis=
t.
> >
> > Unfortunately some things were missed along the way, and are still
> > missing.
>=20
> Well we should have started from OF_BLOBLIST and then dealt with
> problems as they came up. In fact, so far there are no problems which
> it can't solve.
>=20
> As it is, we have Raymond sending a patch to push the prior-stage mess
> into TPM, for reasons which make no sense to me. It is just adding
> confusion.
>=20
> One other thing we would have likely done by now if my patch[1] had
> gone in a year ago, is moving away from BLOBLIST_FIXED to using a
> register protocol. That is more deterministic.
>=20
> Regards,
> Simon
>=20
> [1] https://patchwork.ozlabs.org/project/uboot/patch/20230830180524.31591=
6-31-sjg@chromium.org/

I think once again your obsession with OF_BLOBLIST and device tree is
causing you to miss everything else. Today we can take a *bloblist* via
register. Linaro wrote that, even. The next problem really is that we
can't pass that bloblist along to the next stage because all of the
U-Boot side of things assumes fixed address.

--=20
Tom

--+VQGEjgvjGf3WL+7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdh2+8ACgkQFHw5/5Y0
tyxV5Qv/WdyODvZL7n+PL4rxTO4Fdu9SI3RU/H7QembHcL3QkP+n30asv1V5LCsU
j79WjoIt1MeZBDzzgQipIAqRNUwCHptoA3DFhdoeaJJrMW4qJOJXB+DjRx97vr+H
2BiWRTLxQuHhNUy7YgaigpNZQV6r+lgRTMqlBj/hqXextSEEyqFqKIrDAx6o5hwH
DTAN5g4g85XwGWK+qviYXcRsBrpiQ8dBBTTQbcgLBBvwjNy0Jx2w6qgyJIOQakhP
K3Z0gXuPOFjwDBHEh6qktG3WEurMP82KpX4Ea+9zBk5HD0p0i/irSzwJw/pdaxEa
BLR7GgEyXOzHhXs3Swp/rqMaoA3Qk39DuT4Nix2OzsGLmL/taK8GC6XJxL98VqmK
WmfQu7Kx9mdNfwjvbD5UpPi312o/rScSR/fD7bumcb05LfSpj2QZMVD5A0bZUmiH
XAzTZHh4pVxq251ihbEooHeGfudNvlo1vDq0kbC4l12niBDAqy+B+4BGOSYIluAv
Q39CTe9g
=WoOU
-----END PGP SIGNATURE-----

--+VQGEjgvjGf3WL+7--
