Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A14A7C36002
	for <u-boot@archiver.kernel.org>; Sun,  6 Apr 2025 22:39:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1F3A82B8E;
	Mon,  7 Apr 2025 00:39:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GnCkMgD/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 275B182C2B; Mon,  7 Apr 2025 00:39:02 +0200 (CEST)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B869982B45
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 00:38:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-2c2504fa876so1027720fac.0
 for <u-boot@lists.denx.de>; Sun, 06 Apr 2025 15:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743979138; x=1744583938; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7/Xzmo3HSXiSMfwSt62J+qWC8kJXx6ankLOo287SdUI=;
 b=GnCkMgD/bQCDUy3ZHrcg6te63G2wF34CTXpVDFRvlJ1RrPBz/+n8ffUXWUz3y+cVIY
 sPEEIJnS1LH9QiZW9slwiiWVc0QD1vdvgkOkHxR2I04GfkhJznHvpieXgTZ5n1pcEZke
 xpKMrGvpsbesGs3iFMtdsjXtyR0pkHnTjE9aM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743979138; x=1744583938;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7/Xzmo3HSXiSMfwSt62J+qWC8kJXx6ankLOo287SdUI=;
 b=NOx2tZwhLa96QrD9FRMAXhTHEibfCJlY8ufZsT7+UJa4if5tfu6MSSYsyQfO7IRDbC
 efrVvpoiDafMa/9R/NtLaXwDoe0cTKMam94MDbbBmF2pArlHcIclxvSFsXizsAvjNizA
 sg3dYHWt4kto8gHxE5KyDhI51esxWeW6SREqvUxk5j6GJyuR8fuGhncqcD+0CNLnkeoT
 Gpm5bxiMJ01Izl1Wmi0L7jeabmUsXWATRKvPlhkccToDSaW68M836sR2ghMFQoUfDhu2
 3vjCODe/HXPkcX5kq9Uvz352RnsLOtUvcF1CP/e8nV0v2PlUiQK7DPWVyC4NAtkGi36i
 330Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVY0LP6K756dYHHrJHIbXMvlHBBCEafu5ohfXohy2brdR4HigkMNMcwP+3bqbaGziLOE95l4rE=@lists.denx.de
X-Gm-Message-State: AOJu0Yy4O8rS7vKDMLyEQpNo8TFL9/BGqOPWc50bh0dfB6GhIFdmxkxY
 AC7LvZpX8b/L7LT31ehn1yCGwFb/ebfDvcmlrgigU5GlG9OYtBBks5HsT3Qwn6Q=
X-Gm-Gg: ASbGncuQ8Vb20QPhbTaKBlzNTvFd/TvfTtS343+/7S3Rtjr7r4qDTjk3O0+eE28YCNQ
 f54NXNLF7aNF8gP+okIjpG11wnSDwPyrbP6pwqflIWymR6Doa1RDiZyfd5QMXJMhJStt0Y4Tzil
 m31R64cDxCVfwmCi66hdZILIucKsytVHhN5B6sVOE3R/b4e8oZjkDBuCrvRqpVQf9LsH2B3CKv2
 MormX1bORrd7K4nV58VxjRmsGTE8UB6zWCGkQnzvQzaDsL/e3FZHPifeG7XaEaoo8zMhWlAaNkm
 4/XSJS5H1/3yBrd8ykXmzgl7d4fSqThU3UfyU0s5fOuJVuz26+vqm+9m/Y9WDnwlMFEKoYkGFzS
 2NiX3Pw==
X-Google-Smtp-Source: AGHT+IFMUsyGzri7tr/iIZmEVK28s+Hq2zSEQdd/RVd9xVzzhVXnf7IPj/ouZdNPriwvIqVIC9hacQ==
X-Received: by 2002:a05:6870:a54e:b0:29e:40f8:ad9b with SMTP id
 586e51a60fabf-2cc9e5be733mr6577670fac.14.1743979138275; 
 Sun, 06 Apr 2025 15:38:58 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72e30511428sm1500741a34.16.2025.04.06.15.38.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Apr 2025 15:38:57 -0700 (PDT)
Date: Sun, 6 Apr 2025 16:38:54 -0600
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
Message-ID: <20250406223854.GE5495@bill-the-cat>
References: <CAEfUkU+OHK3GdqROVFe4J0=OoRsw_u7znef6iLuibY4vsLOBkQ@mail.gmail.com>
 <CAFLszTgjKXK6adB2fa3S4o+AAm1Amyg5WdJ9EuOg4xoXBFLeCg@mail.gmail.com>
 <CAEfUkULg0bzG564_vo43Bta5C4_EirZNt39ncgua0VFjd1C-tw@mail.gmail.com>
 <CAFLszTjGn1JGdpNAZVL6CC+pQLsOrG6gjmo8kRzjbnR_=6CMvw@mail.gmail.com>
 <20250403215239.GO5495@bill-the-cat>
 <CAFLszTjB7Ax24c1SF4yEt7xzJKpO5tHyQsjGutrhDteFYebyyg@mail.gmail.com>
 <20250403225058.GQ5495@bill-the-cat>
 <CAFLszTit0LgAxbMjw-96rzJ0Z7LyV-RgzpXMqG2PJj-YguorXg@mail.gmail.com>
 <20250404175710.GU5495@bill-the-cat>
 <CAFLszTgBMP-WsAw=z807e9RUY1YNB=Ky+s1MhW=x6dYt7_V+-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="y8ORRqXNp2iSEFWZ"
Content-Disposition: inline
In-Reply-To: <CAFLszTgBMP-WsAw=z807e9RUY1YNB=Ky+s1MhW=x6dYt7_V+-g@mail.gmail.com>
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


--y8ORRqXNp2iSEFWZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 07, 2025 at 10:06:07AM +1200, Simon Glass wrote:
> Hi Tom,
>=20
> On Sat, 5 Apr 2025 at 06:57, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sat, Apr 05, 2025 at 06:39:39AM +1300, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Fri, 4 Apr 2025 at 11:51, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Fri, Apr 04, 2025 at 11:41:08AM +1300, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Fri, 4 Apr 2025 at 10:52, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Fri, Apr 04, 2025 at 09:40:29AM +1300, Simon Glass wrote:
> > > > > > > Hi Raymond,
> > > > > > >
> > > > > > > On Fri, 4 Apr 2025 at 08:54, Raymond Mao <raymond.mao@linaro.=
org> wrote:
> > > > > > > >
> > > > > > > > Hi Simon,
> > > > > > > >
> > > > > > > > On Thu, 3 Apr 2025 at 14:18, Simon Glass <sjg@chromium.org>=
 wrote:
> > > > > > > > >
> > > > > > > > > Hi Raymond,
> > > > > > > > >
> > > > > > > > > On Fri, 4 Apr 2025 at 07:13, Raymond Mao <raymond.mao@lin=
aro.org> wrote:
> > > > > > > > > >
> > > > > > > > > > Hi Simon,
> > > > > > > > > >
> > > > > > > > > > On Thu, 3 Apr 2025 at 13:57, Simon Glass <sjg@chromium.=
org> wrote:
> > > > > > > > > > >
> > > > > > > > > > > Hi Raymond,
> > > > > > > > > > >
> > > > > > > > > > > On Fri, 4 Apr 2025 at 03:09, Raymond Mao <raymond.mao=
@linaro.org> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > Hi Simon,
> > > > > > > > > > > >
> > > > > > > > > > > > On Fri, 28 Mar 2025 at 11:44, Simon Glass <sjg@chro=
mium.org> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > The bloblist code took what I consider to be a wr=
ong turn a year or so
> > > > > > > > > > > > > ago. As discussed with Tom, this series proposes =
a way to arrange things
> > > > > > > > > > > > > so that it is simpler to understand and manage.
> > > > > > > > > > > > >
> > > > > > > > > > > > > - Unwind some of the nesting in bloblist_init()
> > > > > > > > > > > > > - Avoid needing to init the bloblist just to get =
the FDT
> > > > > > > > > > > > > - Create a deterministic OF_BLOBLIST option rathe=
r than using guesswork
> > > > > > > > > > > > >
> > > > > > > > > > > > We now have a kconfig BLOBLIST_PASSAGE_MANDATORY wh=
ich means
> > > > > > > > > > > > mandatorily use bloblist to hand over everything be=
tween boot stages
> > > > > > > > > > > > including fdt, creating OF_BLOBLIST is not necessar=
y.
> > > > > > > > > > >
> > > > > > > > > > > Yes, I noticed that, but BLOBLIST_PASSAGE_MANDATORY i=
ndicates that
> > > > > > > > > > > there must be a bloblist, not that it must contain a =
devicetree. So I
> > > > > > > > > > > wasn't sure about removing it.
> > > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > See my comments to your [2/4] patch, if BLOBLIST_PASSAG=
E_MANDATORY is
> > > > > > > > > > selected, we can override any fdt from board or env wit=
h the one from
> > > > > > > > > > the bloblist.
> > > > > > > > >
> > > > > > > > > Yes, but we should be explicit about what is going on her=
e. With
> > > > > > > > > OF_BLOBLIST we indicate that the devicetree is coming fro=
m the
> > > > > > > > > bloblist. It becomes one of the sources for devicetree, l=
ike
> > > > > > > > > OF_SEPARATE and OF_EMBED
> > > > > > > > >
> > > > > > > >
> > > > > > > > BLOBLIST_PASSAGE_MANDATORY indicates the fdt from bloblist =
will be
> > > > > > > > mandatorily used and override other fdt sources like from t=
he board or
> > > > > > > > env variables.
> > > > > > >
> > > > > > > So long as you are OK with OF_BLOBLIST as well, I have no obj=
ection to
> > > > > > > keeping BLOBLIST_PASSAGE_MANDATORY, although I don't like the=
 name
> > > > > > > very much. But I can see why it is called that as my standard=
 passage
> > > > > > > series was actually never applied. So I suppose I'll need to =
have
> > > > > > > another try at that.
> > > > > > >
> > > > > > > So to be clear, I want a separate option for devicetree, call=
ed
> > > > > > > OF_BLOBLIST, which I can enable/disable as needed, without af=
fecting
> > > > > > > your option.
> > > > > >
> > > > > > Sigh. Can I ask what the use case for this will be? And we are =
going to
> > > > > > get rid of BLOBLIST_FIXED at some point, yes?
> > > > >
> > > > > I thought we agreed that this was acceptable. We argued the toss =
for
> > > > > months on this point and I would rather not revisit it.
> > > > >
> > > > > Yes, I will look at removing BLOBLIST_FIXED once this is in. I'm
> > > > > pretty sure it can be done. The only tricky bit is coming up with=
 a
> > > > > bloblist protocol for x86.
> > > >
> > > > Yes, I'm stuck between being "flexible and saying yes" and how long=
 we
> > > > have to live with what I also think are bad designs.
> > > >
> > > > So maybe the pre-requisite here is that with "bloblist" and "standa=
rd
> > > > passage" being divorced, what is the requirement for bloblist again?
> > > > Because in practice, all of the problems we've had come down to loo=
king
> > > > in fixed address locations before they're valid. You want to handle=
 this
> > > > by saying "Ah, we won't look before it's valid with other CONFIG fl=
ags"
> > > > and I say we should handle this by not using a fixed address to sta=
rt
> > > > with.
> > > >
> > > > If we have to add OF_BLOBLIST now and delete it in a few months, si=
gh,
> > > > OK. But it shouldn't need to exist long term.
> > >
> > > For me, OF_BLOBLIST is needed for x86 devices which don't pass the
> > > devicetree in the bloblist.
> >
> > I don't understand why that would become the case when it's not true
> > today.
>=20
> If you look at the top of fdtdec_setup() in your tree you can see the
> special-case code related to TPL, that I'm wanting to get rid of.

OK, but all of that too is for the case of a fixed bloblist being in
uninitialized memory. Which is why I don't like BLOBLIST_FIXED and want
to see passing of the bloblist from xPL -> PPL be implemented and so xPL
can allocate a bloblist (or grow a passed one if needed).

--=20
Tom

--y8ORRqXNp2iSEFWZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfzAn4ACgkQFHw5/5Y0
tyw5wQv9ETSOdCdnWHh0On7KphwTCk+yruNa/2sitjWDNm/4NKWTVjb5D082S/to
OPIcGGfMuQ30/pcufXl01O843b7d6K8y+kMnXUJkinwHx3GLvxGvlWmM/NBS8ocv
AH1E8yNiQvuMaV8MCFPpUjXCwC6OPgHNwFA4c4tuZblp5UM4KUvdm6/7uI0EYIJJ
zL5TG/axS8V+l0EcyJbOeXaVQwHIl1JbtYkBNUiRUDoJDgyLYBkLpy+h2mJREl1G
ApBrnTN7SubJ7ttsRjOm9/o0RNhuDX9ZTCtpNNtZCnzEJzlb/xqOcYS0n1kRLPdZ
+lEnbpaBWTJN2Y8Ea9cfvbnikOnJKxJMCmn+F4GMxF4j9kswCX53CUBzIX3c2x1v
1ero5VPw7qnybBte2yXHRVjUx0vqOJ7qKJPG11AwAWqwEiOhYzOonCB34E1iSzv3
TGYr84ul+MlIn+dJqGFjH3FJASji2IXkz8FxHsXMGLxXiAqk/vNuPQc++Qp7/VYL
k1n/mcT6
=CLFs
-----END PGP SIGNATURE-----

--y8ORRqXNp2iSEFWZ--
