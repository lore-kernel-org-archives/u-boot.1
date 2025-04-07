Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F4E7C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 18:22:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A26048302D;
	Mon,  7 Apr 2025 20:22:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DDIeis/V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 642F183045; Mon,  7 Apr 2025 20:22:44 +0200 (CEST)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB73082F85
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 20:22:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-603fd257386so996260eaf.1
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 11:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744050160; x=1744654960; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=34IZzuLYvwU5Hqdu6RYGkNcgHaSG7ExOAR/qOB4HO+s=;
 b=DDIeis/VDjIcQyVs2wSqxP8ngEFDtV5JvDvH/W7RDZI1OBH99Zq4pB02QNG7QG27mu
 Sq9UxNzEZ3mXRhaTLiBixOPgDiEPJ1M8y0K3K4ptLG39fd2gYLWh8id+gskcn4yeWIbJ
 uBZ5WClmnTvLxRKH+uARY3N3PWDyMovQd6bKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744050160; x=1744654960;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=34IZzuLYvwU5Hqdu6RYGkNcgHaSG7ExOAR/qOB4HO+s=;
 b=nJWNzSchnvRscNufURieP0yDMA9zf4Cmu+Hd7LRmods7yyef71ph/rJFcqm54GX9C6
 TBFeh/5cfAA1xggRCwCp2tHr1oAgcK2hPjb/hg2REAvaHklHUnZ3rdMlYV/+912LX2r0
 jkJCjXGbrjPWFko7q10PwBpiVPDFtS61IcMsWJIX8APxmF3APNRosa6laa7YLCHLsv8G
 sXTnZrbnTztld25nN/0gkLoxqfRKGeiOm9ecpWFzMCpoS0cq30DUiMgxLYKb4E+N+xTE
 plNwaEgY93kletp/DpLTA4tyrtut/fEjGKxVBWgZ0Roqe94j/OYH6JV9ICWjBIQEvjUo
 b2Lg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvSQ0uRpTrgnHz1VqrUGDn1e1GJc2EWb8CT3h4Ypt1wLU8VKlk1iYzJ3FmYLGlAjkcwgVfG7g=@lists.denx.de
X-Gm-Message-State: AOJu0YxQh40vhfbcsr400zwTmYBWtfs+8gXwpVA8ruSKu9f/htzyC8pD
 jBarZZG4Gj1QT1KpL4LyJCcatQlmMyB2QETADuXDjmz9SmXYADnamo1vB1CrLtE=
X-Gm-Gg: ASbGncsTO6IdJd6BaByp5bcPTUAeZcCeYPjrnO0kw9cjqrTw0jh6QaP8RorI3hOumCo
 zZaLT/IJfMzqM766/EV1xiYnKCZQgB3dK8gYPd7Wyh4fWz1nkYFmkU2XYukgwNNAuWgdO8cauZz
 D06kJjywxdqf+RJMb+oJvSNFn+55v4h/2hXgycrRkzR4F++XnlluzBAHevvPz/Y/xyPk3ezybNH
 9Nxei1e3sF0NRjlCOY9AXlQfmBgb3BHY3/ckfoeoQNPX3FSNd7QFr/yI1Xe2e6ZkUwUXHx2MMWN
 Q2vpwKcKC3PBe5jfRM3eNvHjmBPPnCefD/RDECPv7t40ssaYBWTQPxsGK5xM57BDZlBe1rOeaZF
 09jQadA==
X-Google-Smtp-Source: AGHT+IHWNXhjIhEjpBfIxzTv12vsO57I8jwq0/pyiXCW1AjE5T0+NpDJXOLe6kDIofOlxTqqM83XsA==
X-Received: by 2002:a05:6820:1c90:b0:604:117:1a5d with SMTP id
 006d021491bc7-604157fe7fdmr5989199eaf.7.1744050160312; 
 Mon, 07 Apr 2025 11:22:40 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6044f48f1f3sm30917eaf.4.2025.04.07.11.22.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 11:22:39 -0700 (PDT)
Date: Mon, 7 Apr 2025 12:22:35 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Raymond Mao <raymond.mao@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Harrison Mutai <harrison.mutai@arm.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Jerry Van Baren <vanbaren@cideas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Levi Yun <yeoreum.yun@arm.com>,
 Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Marek Vasut <marex@denx.de>, Matthias Brugger <mbrugger@suse.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sumit Garg <sumit.garg@kernel.org>,
 This contributor prefers not to receive mails <noreply@example.com>,
 mason1920 <mason1920@use.startmail.com>
Subject: Re: [PATCH 0/4] bloblist: fdt: Clean up the code
Message-ID: <20250407182235.GM5495@bill-the-cat>
References: <20250403215239.GO5495@bill-the-cat>
 <CAFLszTjB7Ax24c1SF4yEt7xzJKpO5tHyQsjGutrhDteFYebyyg@mail.gmail.com>
 <20250403225058.GQ5495@bill-the-cat>
 <CAFLszTit0LgAxbMjw-96rzJ0Z7LyV-RgzpXMqG2PJj-YguorXg@mail.gmail.com>
 <20250404175710.GU5495@bill-the-cat>
 <CAFLszTgBMP-WsAw=z807e9RUY1YNB=Ky+s1MhW=x6dYt7_V+-g@mail.gmail.com>
 <20250406223854.GE5495@bill-the-cat>
 <CAFLszTjLugnmipzzCcAttyvZqQdohNV==jDj_mGzs2_1eFJw1w@mail.gmail.com>
 <20250407143056.GL5495@bill-the-cat>
 <CAFLszThqjXZkoZxa7m+WLtSefnHk2zusJiO8re+bx2rYV4BWzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OUP/uS+AA59Nqkbn"
Content-Disposition: inline
In-Reply-To: <CAFLszThqjXZkoZxa7m+WLtSefnHk2zusJiO8re+bx2rYV4BWzA@mail.gmail.com>
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


--OUP/uS+AA59Nqkbn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 07, 2025 at 09:24:16AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 7 Apr 2025 at 08:31, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Apr 07, 2025 at 12:35:15PM +1200, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Mon, 7 Apr 2025 at 10:38, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Mon, Apr 07, 2025 at 10:06:07AM +1200, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Sat, 5 Apr 2025 at 06:57, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Sat, Apr 05, 2025 at 06:39:39AM +1300, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Fri, 4 Apr 2025 at 11:51, Tom Rini <trini@konsulko.com> wr=
ote:
> > > > > > > >
> > > > > > > > On Fri, Apr 04, 2025 at 11:41:08AM +1300, Simon Glass wrote:
> > > > > > > > > Hi Tom,
> > > > > > > > >
> > > > > > > > > On Fri, 4 Apr 2025 at 10:52, Tom Rini <trini@konsulko.com=
> wrote:
> > > > > > > > > >
> > > > > > > > > > On Fri, Apr 04, 2025 at 09:40:29AM +1300, Simon Glass w=
rote:
> > > > > > > > > > > Hi Raymond,
> > > > > > > > > > >
> > > > > > > > > > > On Fri, 4 Apr 2025 at 08:54, Raymond Mao <raymond.mao=
@linaro.org> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > Hi Simon,
> > > > > > > > > > > >
> > > > > > > > > > > > On Thu, 3 Apr 2025 at 14:18, Simon Glass <sjg@chrom=
ium.org> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > Hi Raymond,
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Fri, 4 Apr 2025 at 07:13, Raymond Mao <raymond=
=2Emao@linaro.org> wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Hi Simon,
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On Thu, 3 Apr 2025 at 13:57, Simon Glass <sjg@c=
hromium.org> wrote:
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Hi Raymond,
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > On Fri, 4 Apr 2025 at 03:09, Raymond Mao <ray=
mond.mao@linaro.org> wrote:
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Hi Simon,
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > On Fri, 28 Mar 2025 at 11:44, Simon Glass <=
sjg@chromium.org> wrote:
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > The bloblist code took what I consider to=
 be a wrong turn a year or so
> > > > > > > > > > > > > > > > > ago. As discussed with Tom, this series p=
roposes a way to arrange things
> > > > > > > > > > > > > > > > > so that it is simpler to understand and m=
anage.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > - Unwind some of the nesting in bloblist_=
init()
> > > > > > > > > > > > > > > > > - Avoid needing to init the bloblist just=
 to get the FDT
> > > > > > > > > > > > > > > > > - Create a deterministic OF_BLOBLIST opti=
on rather than using guesswork
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > We now have a kconfig BLOBLIST_PASSAGE_MAND=
ATORY which means
> > > > > > > > > > > > > > > > mandatorily use bloblist to hand over every=
thing between boot stages
> > > > > > > > > > > > > > > > including fdt, creating OF_BLOBLIST is not =
necessary.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Yes, I noticed that, but BLOBLIST_PASSAGE_MAN=
DATORY indicates that
> > > > > > > > > > > > > > > there must be a bloblist, not that it must co=
ntain a devicetree. So I
> > > > > > > > > > > > > > > wasn't sure about removing it.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > See my comments to your [2/4] patch, if BLOBLIS=
T_PASSAGE_MANDATORY is
> > > > > > > > > > > > > > selected, we can override any fdt from board or=
 env with the one from
> > > > > > > > > > > > > > the bloblist.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Yes, but we should be explicit about what is goin=
g on here. With
> > > > > > > > > > > > > OF_BLOBLIST we indicate that the devicetree is co=
ming from the
> > > > > > > > > > > > > bloblist. It becomes one of the sources for devic=
etree, like
> > > > > > > > > > > > > OF_SEPARATE and OF_EMBED
> > > > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > BLOBLIST_PASSAGE_MANDATORY indicates the fdt from b=
loblist will be
> > > > > > > > > > > > mandatorily used and override other fdt sources lik=
e from the board or
> > > > > > > > > > > > env variables.
> > > > > > > > > > >
> > > > > > > > > > > So long as you are OK with OF_BLOBLIST as well, I hav=
e no objection to
> > > > > > > > > > > keeping BLOBLIST_PASSAGE_MANDATORY, although I don't =
like the name
> > > > > > > > > > > very much. But I can see why it is called that as my =
standard passage
> > > > > > > > > > > series was actually never applied. So I suppose I'll =
need to have
> > > > > > > > > > > another try at that.
> > > > > > > > > > >
> > > > > > > > > > > So to be clear, I want a separate option for devicetr=
ee, called
> > > > > > > > > > > OF_BLOBLIST, which I can enable/disable as needed, wi=
thout affecting
> > > > > > > > > > > your option.
> > > > > > > > > >
> > > > > > > > > > Sigh. Can I ask what the use case for this will be? And=
 we are going to
> > > > > > > > > > get rid of BLOBLIST_FIXED at some point, yes?
> > > > > > > > >
> > > > > > > > > I thought we agreed that this was acceptable. We argued t=
he toss for
> > > > > > > > > months on this point and I would rather not revisit it.
> > > > > > > > >
> > > > > > > > > Yes, I will look at removing BLOBLIST_FIXED once this is =
in. I'm
> > > > > > > > > pretty sure it can be done. The only tricky bit is coming=
 up with a
> > > > > > > > > bloblist protocol for x86.
> > > > > > > >
> > > > > > > > Yes, I'm stuck between being "flexible and saying yes" and =
how long we
> > > > > > > > have to live with what I also think are bad designs.
> > > > > > > >
> > > > > > > > So maybe the pre-requisite here is that with "bloblist" and=
 "standard
> > > > > > > > passage" being divorced, what is the requirement for blobli=
st again?
> > > > > > > > Because in practice, all of the problems we've had come dow=
n to looking
> > > > > > > > in fixed address locations before they're valid. You want t=
o handle this
> > > > > > > > by saying "Ah, we won't look before it's valid with other C=
ONFIG flags"
> > > > > > > > and I say we should handle this by not using a fixed addres=
s to start
> > > > > > > > with.
> > > > > > > >
> > > > > > > > If we have to add OF_BLOBLIST now and delete it in a few mo=
nths, sigh,
> > > > > > > > OK. But it shouldn't need to exist long term.
> > > > > > >
> > > > > > > For me, OF_BLOBLIST is needed for x86 devices which don't pas=
s the
> > > > > > > devicetree in the bloblist.
> > > > > >
> > > > > > I don't understand why that would become the case when it's not=
 true
> > > > > > today.
> > > > >
> > > > > If you look at the top obbfdtdec_setup() in your tree you can see=
 the
> > > > > special-case code related to TPL, that I'm wanting to get rid of.
> > > >
> > > > OK, but all of that too is for the case of a fixed bloblist being in
> > > > uninitialized memory. Which is why I don't like BLOBLIST_FIXED and =
want
> > > > to see passing of the bloblist from xPL -> PPL be implemented and s=
o xPL
> > > > can allocate a bloblist (or grow a passed one if needed).
> > >
> > > We are going around in circles though. Having it is registers doesn't
> > > help with the problem that there isn't an FDT in the bloblist.
> >
> > Sure it does. If we're passed a bloblist in a register we can then see
> > if it has a DT (and use it) or not (and move to the next DT location).
> >
> > > Also, I thought you decided that I could maintain bloblist. Have you
> > > changed your mind?
> >
> > You just mis-understood me. Yes, you can maintain bloblist. But also,
> > Yes, I need to understand what you're doing. The root of the OF_BLOBLIST
> > problems is that no one understood you.
>=20
> Is there a call tomorrow, or is it next week?

Tomorrow.

--=20
Tom

--OUP/uS+AA59Nqkbn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmf0F+QACgkQFHw5/5Y0
tyz8Jgv+JEPA8ARZf3QE1YzyplSLwGjZkHCvIXyxSmSPDBHndVfLAREvnJTYlIK3
FXAmcEq1RDRh5rbNdxKT9lmtyMzZJBitmPeBDgNHZWSjMwZg1E5KUywkpN+vu4jh
jQs/1obEL6lEprd8p1VAEFrgGUgskRJkveZ2ktVdIcFxQoNnXXkAmP43O88HYQTH
KIVVZFO3o/62ZIyV2rtfnre39DUNqAmGcJn4ErJWbrhhdmnK0NPOA8dMuWwuEG/s
sGgAq0tt1nFGo+MvlupgK6jY9Ct1LYdubv17bL2wtC+27/tqJ5nf9BpZSoJ8gbK1
PRlOQh7qARAkSJEtI7E4hBk2oLRBJoK20g+zWwMUpZXZCovybdU8EI3I+OQhY/MN
mpMRdiWSGtPdGyAItUd+qhdja1OXKlGBdlD7ksiUooesa5U0YAEKsbK5iNwAndtc
mrXuCMjaGnT1n3pxLz6bVQD78ESXj7x0wQixorAIP8knIb8Qe7mm1QSf7aThXDnK
InwBYvo/
=mxAo
-----END PGP SIGNATURE-----

--OUP/uS+AA59Nqkbn--
