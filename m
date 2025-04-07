Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 450C9C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 20:34:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA7C982C87;
	Mon,  7 Apr 2025 22:34:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eMMegpsP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F9A082C87; Mon,  7 Apr 2025 22:34:29 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CC0982B8E
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 22:34:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3f6a92f234dso2729290b6e.3
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 13:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744058065; x=1744662865; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RlNY5DHO77M0aAkhAw6d5QQV2prFVL77KlxAmoKsx8c=;
 b=eMMegpsPtNkQgm+s1ftblDDNE/4syTnvn3lP1riZbTsFj+1d0ZbKO0K3ZJlI6q3sru
 xSTMPwo3gnRhDRkg3/Y28Z2uI88WavUM0g/FI+5J3ymLFljzWZ97g/aG9u44j5RmCkXE
 YoXfZdHCS2GffEQOcAC12z4UD6KAKKmJk073g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744058065; x=1744662865;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RlNY5DHO77M0aAkhAw6d5QQV2prFVL77KlxAmoKsx8c=;
 b=aq/JvKFFvZYuHgAr8eQ20SWijbmqvMOJiddvw3vDt9NlKDONN+g+4Wf3vhwZzKsloR
 rJqudjvNygxANmHrmRw9YWX/85lYilNT2DpYg/pqmc0NAqHW9Bb0TSlADF9oALsGdLRQ
 V9xvs3aXIQ2LNELaxEImp+/rPTP/WiPzDcwAQB459gWRqiCQAxqBy+EE/eMjuI9hsUBu
 +/KkmktEi+V3SGTNoFc/QnWT0/zLTAgUyFqdwIpuNq34BAbyG1GiajE1ztRfU2L+9c0y
 VmQfbTtx7UyQe5zCZty8vKAhWPPo0n6uw/xtjhCqVCdPTbes+5NAYKEPTqxXM+YixGdP
 a+aA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWN65g/WxCS0FrPXB0YsxRAIOK0LNNeZMEXmY7q7QWaccIywEilF0DoVKEJtj/0n087Zh3iaI=@lists.denx.de
X-Gm-Message-State: AOJu0YzIaPaZvYgJUlWMF48qKvFzykv5jHehR/J2jF5KBOWCaOOVwT7K
 q2718hyyRzc15hS5qf9e7aV5DQSnNAfmdMIpp8aqRId8G3rJJoJqjEKz/0jQtzA=
X-Gm-Gg: ASbGnctqmCdB/gC14tV9M2baROQk2RBe5jlO0O9wMJWeP3mxbgmqO3t4QOpFgIROtzj
 Qv7JxC9cXLiUZPcaByQJzJ/eZqvzXxplGEpKKy8v/bTNHetR3LfgW7/2TjxxHJE09oMlLNOKd9W
 aKWqJrZBHQejt1mGKaYUDq+C3WzItN2BsZ1frXJXJ/Fiur1yBl2PN0K1RpvUOv2nJQkC+qRczIL
 D3g0e7vfY1AMJdCr8v90XwyWuhb208sghBmub112TzqjyOLOpO44Of9/RbJsnVz2wMzGPEWjxiu
 m6qmpkTXNWVKtM+O9Gs7Wup4GGMwQf4AsTRFWQ6Mdz8IgSYyFdisxnM4yYbFzF8nBiZiNNP7NY5
 FZVf8wg==
X-Google-Smtp-Source: AGHT+IFfpA5V3i01wpIgxxO0FGAC3UT0dLshgch+cYTjONb1U9aA7bn4qaHcaPaoQt6oiBjYe1mFyQ==
X-Received: by 2002:a05:6808:1644:b0:3f8:91d1:d950 with SMTP id
 5614622812f47-4004564e62dmr9492556b6e.38.1744058065177; 
 Mon, 07 Apr 2025 13:34:25 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40069351187sm70443b6e.29.2025.04.07.13.34.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 13:34:24 -0700 (PDT)
Date: Mon, 7 Apr 2025 14:34:21 -0600
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
Message-ID: <20250407203421.GP5495@bill-the-cat>
References: <20250403225058.GQ5495@bill-the-cat>
 <CAFLszTit0LgAxbMjw-96rzJ0Z7LyV-RgzpXMqG2PJj-YguorXg@mail.gmail.com>
 <20250404175710.GU5495@bill-the-cat>
 <CAFLszTgBMP-WsAw=z807e9RUY1YNB=Ky+s1MhW=x6dYt7_V+-g@mail.gmail.com>
 <20250406223854.GE5495@bill-the-cat>
 <CAFLszTjLugnmipzzCcAttyvZqQdohNV==jDj_mGzs2_1eFJw1w@mail.gmail.com>
 <20250407143056.GL5495@bill-the-cat>
 <CAFLszThqjXZkoZxa7m+WLtSefnHk2zusJiO8re+bx2rYV4BWzA@mail.gmail.com>
 <20250407182235.GM5495@bill-the-cat>
 <CAFLszTiWHTGoN68-eoh6MpHt8ywdXLJ7FbW-KtUstvijY-phnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xXbWJK/UyVqTWAWy"
Content-Disposition: inline
In-Reply-To: <CAFLszTiWHTGoN68-eoh6MpHt8ywdXLJ7FbW-KtUstvijY-phnw@mail.gmail.com>
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


--xXbWJK/UyVqTWAWy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 07, 2025 at 02:17:46PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 7 Apr 2025 at 12:22, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Apr 07, 2025 at 09:24:16AM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Mon, 7 Apr 2025 at 08:31, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Mon, Apr 07, 2025 at 12:35:15PM +1200, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Mon, 7 Apr 2025 at 10:38, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Mon, Apr 07, 2025 at 10:06:07AM +1200, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Sat, 5 Apr 2025 at 06:57, Tom Rini <trini@konsulko.com> wr=
ote:
> > > > > > > >
> > > > > > > > On Sat, Apr 05, 2025 at 06:39:39AM +1300, Simon Glass wrote:
> > > > > > > > > Hi Tom,
> > > > > > > > >
> > > > > > > > > On Fri, 4 Apr 2025 at 11:51, Tom Rini <trini@konsulko.com=
> wrote:
> > > > > > > > > >
> > > > > > > > > > On Fri, Apr 04, 2025 at 11:41:08AM +1300, Simon Glass w=
rote:
> > > > > > > > > > > Hi Tom,
> > > > > > > > > > >
> > > > > > > > > > > On Fri, 4 Apr 2025 at 10:52, Tom Rini <trini@konsulko=
=2Ecom> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Fri, Apr 04, 2025 at 09:40:29AM +1300, Simon Gla=
ss wrote:
> > > > > > > > > > > > > Hi Raymond,
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Fri, 4 Apr 2025 at 08:54, Raymond Mao <raymond=
=2Emao@linaro.org> wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Hi Simon,
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On Thu, 3 Apr 2025 at 14:18, Simon Glass <sjg@c=
hromium.org> wrote:
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Hi Raymond,
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > On Fri, 4 Apr 2025 at 07:13, Raymond Mao <ray=
mond.mao@linaro.org> wrote:
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Hi Simon,
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > On Thu, 3 Apr 2025 at 13:57, Simon Glass <s=
jg@chromium.org> wrote:
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > Hi Raymond,
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > On Fri, 4 Apr 2025 at 03:09, Raymond Mao =
<raymond.mao@linaro.org> wrote:
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > Hi Simon,
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > On Fri, 28 Mar 2025 at 11:44, Simon Gla=
ss <sjg@chromium.org> wrote:
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > The bloblist code took what I conside=
r to be a wrong turn a year or so
> > > > > > > > > > > > > > > > > > > ago. As discussed with Tom, this seri=
es proposes a way to arrange things
> > > > > > > > > > > > > > > > > > > so that it is simpler to understand a=
nd manage.
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > - Unwind some of the nesting in blobl=
ist_init()
> > > > > > > > > > > > > > > > > > > - Avoid needing to init the bloblist =
just to get the FDT
> > > > > > > > > > > > > > > > > > > - Create a deterministic OF_BLOBLIST =
option rather than using guesswork
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > We now have a kconfig BLOBLIST_PASSAGE_=
MANDATORY which means
> > > > > > > > > > > > > > > > > > mandatorily use bloblist to hand over e=
verything between boot stages
> > > > > > > > > > > > > > > > > > including fdt, creating OF_BLOBLIST is =
not necessary.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > Yes, I noticed that, but BLOBLIST_PASSAGE=
_MANDATORY indicates that
> > > > > > > > > > > > > > > > > there must be a bloblist, not that it mus=
t contain a devicetree. So I
> > > > > > > > > > > > > > > > > wasn't sure about removing it.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > See my comments to your [2/4] patch, if BLO=
BLIST_PASSAGE_MANDATORY is
> > > > > > > > > > > > > > > > selected, we can override any fdt from boar=
d or env with the one from
> > > > > > > > > > > > > > > > the bloblist.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Yes, but we should be explicit about what is =
going on here. With
> > > > > > > > > > > > > > > OF_BLOBLIST we indicate that the devicetree i=
s coming from the
> > > > > > > > > > > > > > > bloblist. It becomes one of the sources for d=
evicetree, like
> > > > > > > > > > > > > > > OF_SEPARATE and OF_EMBED
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > BLOBLIST_PASSAGE_MANDATORY indicates the fdt fr=
om bloblist will be
> > > > > > > > > > > > > > mandatorily used and override other fdt sources=
 like from the board or
> > > > > > > > > > > > > > env variables.
> > > > > > > > > > > > >
> > > > > > > > > > > > > So long as you are OK with OF_BLOBLIST as well, I=
 have no objection to
> > > > > > > > > > > > > keeping BLOBLIST_PASSAGE_MANDATORY, although I do=
n't like the name
> > > > > > > > > > > > > very much. But I can see why it is called that as=
 my standard passage
> > > > > > > > > > > > > series was actually never applied. So I suppose I=
'll need to have
> > > > > > > > > > > > > another try at that.
> > > > > > > > > > > > >
> > > > > > > > > > > > > So to be clear, I want a separate option for devi=
cetree, called
> > > > > > > > > > > > > OF_BLOBLIST, which I can enable/disable as needed=
, without affecting
> > > > > > > > > > > > > your option.
> > > > > > > > > > > >
> > > > > > > > > > > > Sigh. Can I ask what the use case for this will be?=
 And we are going to
> > > > > > > > > > > > get rid of BLOBLIST_FIXED at some point, yes?
> > > > > > > > > > >
> > > > > > > > > > > I thought we agreed that this was acceptable. We argu=
ed the toss for
> > > > > > > > > > > months on this point and I would rather not revisit i=
t.
> > > > > > > > > > >
> > > > > > > > > > > Yes, I will look at removing BLOBLIST_FIXED once this=
 is in. I'm
> > > > > > > > > > > pretty sure it can be done. The only tricky bit is co=
ming up with a
> > > > > > > > > > > bloblist protocol for x86.
> > > > > > > > > >
> > > > > > > > > > Yes, I'm stuck between being "flexible and saying yes" =
and how long we
> > > > > > > > > > have to live with what I also think are bad designs.
> > > > > > > > > >
> > > > > > > > > > So maybe the pre-requisite here is that with "bloblist"=
 and "standard
> > > > > > > > > > passage" being divorced, what is the requirement for bl=
oblist again?
> > > > > > > > > > Because in practice, all of the problems we've had come=
 down to looking
> > > > > > > > > > in fixed address locations before they're valid. You wa=
nt to handle this
> > > > > > > > > > by saying "Ah, we won't look before it's valid with oth=
er CONFIG flags"
> > > > > > > > > > and I say we should handle this by not using a fixed ad=
dress to start
> > > > > > > > > > with.
> > > > > > > > > >
> > > > > > > > > > If we have to add OF_BLOBLIST now and delete it in a fe=
w months, sigh,
> > > > > > > > > > OK. But it shouldn't need to exist long term.
> > > > > > > > >
> > > > > > > > > For me, OF_BLOBLIST is needed for x86 devices which don't=
 pass the
> > > > > > > > > devicetree in the bloblist.
> > > > > > > >
> > > > > > > > I don't understand why that would become the case when it's=
 not true
> > > > > > > > today.
> > > > > > >
> > > > > > > If you look at the top obbfdtdec_setup() in your tree you can=
 see the
> > > > > > > special-case code related to TPL, that I'm wanting to get rid=
 of.
> > > > > >
> > > > > > OK, but all of that too is for the case of a fixed bloblist bei=
ng in
> > > > > > uninitialized memory. Which is why I don't like BLOBLIST_FIXED =
and want
> > > > > > to see passing of the bloblist from xPL -> PPL be implemented a=
nd so xPL
> > > > > > can allocate a bloblist (or grow a passed one if needed).
> > > > >
> > > > > We are going around in circles though. Having it is registers doe=
sn't
> > > > > help with the problem that there isn't an FDT in the bloblist.
> > > >
> > > > Sure it does. If we're passed a bloblist in a register we can then =
see
> > > > if it has a DT (and use it) or not (and move to the next DT locatio=
n).
> > > >
> > > > > Also, I thought you decided that I could maintain bloblist. Have =
you
> > > > > changed your mind?
> > > >
> > > > You just mis-understood me. Yes, you can maintain bloblist. But als=
o,
> > > > Yes, I need to understand what you're doing. The root of the OF_BLO=
BLIST
> > > > problems is that no one understood you.
> > >
> > > Is there a call tomorrow, or is it next week?
> >
> > Tomorrow.
>=20
> OK, do we have somewhere to add things to the agenda? I'd like to
> spend some time answering your bloblist questions here.

There's not a written agenda, no. But yes, if you're on, we can talk
there.

--=20
Tom

--xXbWJK/UyVqTWAWy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmf0NskACgkQFHw5/5Y0
tywtHwwAhZy0P3kHB1stwH8cs0KXFQd1DX7Lx0aujS+iXgySJLsNJb0Q2+rKikqk
7k0VjLsfyjh1DU+Hexxg3C0uIbI2tFCLJlBuICrQEAj+BcPCyD8WoXiXgP42eGVB
JrBb7NnUysPH3kF2Lp7BvZGwD2xZWzoxcjbj7SZhmRBoYc5/f7smz0in0kllWO3R
gFximza8TkmlCz+f3BhUYlYOQEk8IoCuZ0CmvZuMJbwV0UnG6wxMJ1G4QGPcJCZY
yv27ebhUcr5BKnX895YdEDQi3xWgIPXI4tK6yMLXZROQXASIN3aS+d4phpL7O0ik
cLF7Yt3gvrKzdFZtd9Q6Xwxi8oxj41hqZ2WI2hjV7jKMdsmB1FUMOa1KUuecQm/S
4Jz1rHn4Rm7/Xj3BtRksJLc6M2kU+9ru0EiQpPoVVNJvxSfrs+JeDSxjjxcInXFB
cUl9vxXqMs5sWEQEySR/Xm98zacWavAZH8vBDcxHuxCHTWYABBK23YJ4+OCknNUZ
xkynZ+eW
=GBur
-----END PGP SIGNATURE-----

--xXbWJK/UyVqTWAWy--
