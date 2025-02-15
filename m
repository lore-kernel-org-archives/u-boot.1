Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4589C021A0
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 18:28:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73FEE80756;
	Sat, 15 Feb 2025 19:28:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RducuqRI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 496CF80EAF; Sat, 15 Feb 2025 19:28:55 +0100 (CET)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9159180077
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 19:28:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2f9b91dff71so4516316a91.2
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 10:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739644131; x=1740248931; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jKQi/ejiUbc1qt55ebHZeb7I7vhaKt4t/ZylgMAnvUM=;
 b=RducuqRIw2Omr6U7L+Fq0GGR4SZKz8gi+f5oq+QtHtDpegiLacbHvbeYf0oCobTgJb
 LgZD7upnHP+AwUHyCAO+jWNfQZz3LifEANdc6NCsmSOB/Tl1EqHf9xn2bT3b7GxDmNj0
 v7+NaXN/4c7LLDWJK3n1wmA+HQ6TvM/oHtKAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739644131; x=1740248931;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jKQi/ejiUbc1qt55ebHZeb7I7vhaKt4t/ZylgMAnvUM=;
 b=KLLi7n3Et6mTXd7wm92pWsJjFQX9H7UvmxLe6Nyn/7sUykVdrgKypnEcfxGgcx18gX
 c2C2UzjtrS+pcHDpPpphjoewSbCj6P/xXiNBlViAF74wn0NryLlHUpmGgbA/r3B8vl/k
 EkRlZ9tUKrdTN1guHNRCD0dote5C51+Ct5juNuIg4IZZgtfbhM3C5Yl9cq1HKEHGqb8i
 CB//Mm+oqDHueJxWemKqQ6bwpMF3046MhmS0hSLcoFgd4YwYlR4C1fVbTSJKAjBf5CHX
 9QtOMQPyvhl3DxwVkXyAIPKpxLLJ67SbfKK1DSPMB3ekBgpsROw1jJFEunbbAcbIQkGs
 vxkw==
X-Gm-Message-State: AOJu0YyTDtACBRS6hFIVgjzbS3nckKPZ4dVvdsnrSwwjGdmWykmg1ask
 nQZ0X7KUjEea8rlBWZbJ7V0FrdBcpZxkAFIFlOdUzsGbrFGTsqxOLTQK1jobNws=
X-Gm-Gg: ASbGncvcVffHSugt+ymuHnyOpOIDvBRX8wTh7FfncUmqj91Q1lFHRlCTVPyAOj33iYS
 Riwbd4DbGjXkz0N0onfdCXWWxw9te+V3rw8cOMBXxHnH0IB/Z04a4zzvnBiace2jmfNL1p8aTTv
 aVpv6W/AA8XCNt2arAUyP+7U5imNnp1Mz9BgZdw8tDT0PPm76V+40ZNyO8Fi8R4nr9JGnccsbQC
 50dZZAQvDmBP9qdT80kF+wnKQR8xj4os+DJ9x8OGfrqcsRD4oDzXzaWaNQCKEv5s8Na6Xkbjrgq
 g8md5PhnpuyaMQ==
X-Google-Smtp-Source: AGHT+IHKbvyOm5oS25IEg9w1P7vr11H2XUgp9ACfSDqUVFYXLypay1DkIRqypF7WEKklJbJKmj9IOQ==
X-Received: by 2002:a17:90b:17c1:b0:2f1:2fa5:1924 with SMTP id
 98e67ed59e1d1-2fc41046e53mr4972069a91.26.1739644131043; 
 Sat, 15 Feb 2025 10:28:51 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fbf999b619sm7251750a91.32.2025.02.15.10.28.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2025 10:28:50 -0800 (PST)
Date: Sat, 15 Feb 2025 12:28:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Levi Yun <yeoreum.yun@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>
Subject: Re: [PATCH v2 33/35] RFC: Revert "bloblist: Load the bloblist from
 the previous loader"
Message-ID: <20250215182847.GW1233568@bill-the-cat>
References: <20250209211502.2299245-1-sjg@chromium.org>
 <20250209211502.2299245-34-sjg@chromium.org>
 <20250210143305.GA1233568@bill-the-cat>
 <CAFLszTgc2GsN-O_7aq+pC_0xeJQjh-qa7EAnN1i3djp0ZO5g-w@mail.gmail.com>
 <20250211135944.GZ1233568@bill-the-cat>
 <CAFLszThU+r-F_OUSM2rWVScfvgBTSCjDzxrYi5iBaBh7WNqHKQ@mail.gmail.com>
 <CAFLszThvdHTKoV3aWMSNBEV6zeg_kO=ca=tK2RJe-Rf8_UYivQ@mail.gmail.com>
 <20250215150116.GS1233568@bill-the-cat>
 <CAFLszThi7DzdheY7Cp3zQSNsV-4a1GBvB=CVQczdyrXjBBuSOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9FJMMaQg0hT2l0yQ"
Content-Disposition: inline
In-Reply-To: <CAFLszThi7DzdheY7Cp3zQSNsV-4a1GBvB=CVQczdyrXjBBuSOA@mail.gmail.com>
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


--9FJMMaQg0hT2l0yQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 15, 2025 at 10:24:50AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Sat, 15 Feb 2025 at 08:01, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sat, Feb 15, 2025 at 05:11:45AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Sat, 15 Feb 2025 at 05:06, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Tom,
> > > >
> > > > On Tue, 11 Feb 2025 at 06:59, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Tue, Feb 11, 2025 at 06:10:54AM -0700, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Mon, 10 Feb 2025 at 07:33, Tom Rini <trini@konsulko.com> wro=
te:
> > > > > > >
> > > > > > > On Sun, Feb 09, 2025 at 02:14:54PM -0700, Simon Glass wrote:
> > > > > > >
> > > > > > > > The logic of this has become too confusing.
> > > > > > > >
> > > > > > > > The primary issue with the patch is that U-Boot needs to se=
t up a
> > > > > > > > bloblist in the first phase where BLOBLIST is enabled. Subs=
equent
> > > > > > > > phases can then use that bloblist.
> > > > > > > >
> > > > > > > > But the first phase of U-Boot cannot assume that one exists.
> > > > > > > >
> > > > > > > > Reverting this commit seems like a better starting point fo=
r getting
> > > > > > > > things working for all use-cases.
> > > > > > > >
> > > > > > > > Note: The work to tidy this up is apparently underway. For =
this series,
> > > > > > > > a revert is the easiest path.
> > > > > > > >
> > > > > > > > This reverts commit 66131310d8ff1ba228f989b41bd8812f43be41c=
3.
> > > > > > > >
> > > > > > > > https://lore.kernel.org/u-boot/CAPnjgZ3hMHtiH=3Df5ZKXNniOfV=
_-vFryq1Gn7QZ5hKU8Wjo8igw@mail.gmail.com/
> > > > > > > >
> > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > ---
> > > > > > > >
> > > > > > > > (no changes since v1)
> > > > > > > >
> > > > > > > >  common/bloblist.c  | 64 ++++++++++++++--------------------=
------------
> > > > > > > >  include/bloblist.h | 10 --------
> > > > > > > >  2 files changed, 19 insertions(+), 55 deletions(-)
> > > > > > >
> > > > > > > We aren't reverting this change so if you plan to move this s=
eries out of
> > > > > > > your downstream fork you should start from that and stop post=
ing it,
> > > > > > > that just leads to confusion.
> > > > > >
> > > > > > Who is 'we', and start from what?
> > > > >
> > > > > We, being the community, in here, the community mainline U-Boot p=
roject
> > > > > tree.
> > > > >
> > > > > > My goal with this series is to have something that actually boo=
ts on a
> > > > > > real board, so the bloblist changes are needed for that, partic=
ularly
> > > > > > as the 'vbe' board in the lab tests this on the hardware. I
> > > > > > deliberately put these two patches at the end of the series so =
you can
> > > > > > ignore them if you'd like.
> > > > > >
> > > > > > But for now, as I understand it, there are no users of standard
> > > > > > passage in tree, so actually it would be fine to apply them.
> > > > >
> > > > > And you can ignore all the feedback you like for your downstream =
fork,
> > > > > sure.
> > > > >
> > > > > Part of the feedback in this series already was "Yes, we can clea=
n this
> > > > > up a bit more if bloblist will do its own thing instead".
> > > >
> > > > So I see that Raymond's patch is a significant rewrite of what is
> > > > there today, with multiple aims and changes. I would rather add my
> > > > revert and start from a cleaner place.
> > >
> > > Also, I forgot to mention that U-Boot doesn't seem to support the
> > > firmware handoff protocol in SPL? If so, could you point me to the
> > > code?
> >
> > Yes, you never implemented handoff between stages in U-Boot via
> > register. That's not a use case for the platforms that don't use U-Boot
> > for SPL.
>=20
> If you let me own bloblist, I'll own it, but for now I am staying away.

Would you be working against mainline again, and not breaking standard
passage (as it's been split off) ?

--=20
Tom

--9FJMMaQg0hT2l0yQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmew3N8ACgkQFHw5/5Y0
tyw+IQwAmW5ScnhyQ2CkfnpiC5oPIGn2iMXmBc3gCuAcN08QtGK7oXo88S9rF1Hc
d/HTecZ9DpWY2NigiV9GdJpL5AMthZWSQKv7zWfxecyt4hGoSIYSByAlCf53Tqg4
p8332e6sXTajAyVtrMWxG/trSr7qwHp6GOCFWODnrX86RUzLMrI2qrC/lN2Us0R/
JeRRpi5mcYnK8zeT6EhyvfvKB4B4O0ctHfATMxDJ3r2O5yLftHKdPyo3BXHoWcYp
n0mJU+u4uV2DrCB2jjcgNvZKhgRHeZuSWCNx9EgCKOqWSK9nn26TuEEMM6g/I1my
n6ADRjC+ubtG2hPaJ+e5Rha9CeSXfXbFku158lj9snmPjX9MJ9ze+KYdxU8qMoOI
PiNGWpYKBHw9Vu7l8LP7MVo6dRy5aMWPgKgCjmhugxx6NlgvSKlweNP6EnUg9j4y
m+7ImDSXvGJPnsnvuh8Z043crfNPS+CXHGA30qzWRArYb6e6PnazJKeJmF4f/JHE
YGtVN0rq
=qnS7
-----END PGP SIGNATURE-----

--9FJMMaQg0hT2l0yQ--
