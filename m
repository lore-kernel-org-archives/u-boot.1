Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 805C6C369B2
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 14:14:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0806682FCA;
	Thu, 17 Apr 2025 16:14:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UB2NnFHv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26CF08300B; Thu, 17 Apr 2025 16:14:40 +0200 (CEST)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86B3982F87
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 16:14:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3fa6c54cc1aso477471b6e.1
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 07:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744899276; x=1745504076; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fYM5r8CtFKNwxr75ViYbvKNb7WDZXT7//eMdHszuBSE=;
 b=UB2NnFHv8SzAadJ49Gf56u3/c1noyUQp3KOg7da8UQmcQF9OqN0qafodY3VBzlWBmr
 rF/EdVg8XoXjXmhSlftZxrCPzplAIosqyisKb18EXNrh9yxLF5+fjg5MNGG4ytgWEkU5
 KLJJw/E7JwYPRbIxo4WMZbsL6rVi9TDqO6NMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744899276; x=1745504076;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fYM5r8CtFKNwxr75ViYbvKNb7WDZXT7//eMdHszuBSE=;
 b=ZATiWrtIr4MLcILKfX6xc54njfA0AP/Iv9xMtHCYLbePdzuCpce5xpvF7Eee1ZLYW4
 PYEPqU92GAikHvNwCc689p4tbieyPtYDey94uSinXSVz7f7y4pWyzE/S4OZSY6z1FfZ2
 gPHdxHsOXmIu+bFIec43sly0IyA0WkkXSrWXdgLmYap2YrS8JWR3iFBOsjrDChTX/EMW
 AEuygMPYyiNECHCh96tTIRGkE9YU8VLFznOxKNz8zqaDjIfoKdStiB35sv/CJPm64IOw
 bquXtPLIU8FSxIW4oIh3vjAw/yCY7JWNUBtH4RH89jmuHrgz6VbK+sEFvwa14j5OosrD
 /yww==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkmF7vFn7eLsOfAnUwRuaDq67X/Hl+FeBt/sgSgW3M/LTBVLTSWznCXyJNlqtLDxtx6BXth0Y=@lists.denx.de
X-Gm-Message-State: AOJu0YwAvk20X69FrV8Uudwks2fPbTXZDkA7sTAe38K1sjxJnIETQ6xl
 m0iEJHgq2zROa25PtxNX6oV5Fz6/B9y9x3lDusvVtnhcuGP36Q+TxMZttZ+wYWM=
X-Gm-Gg: ASbGncvfvxZ+m5uPVvFZg+yMm36WSYomLqkNiysIsY6VqEslUYEwkVE0xw8VQJDKDg9
 ZZlugudZ3qOESztv0dWzFSi2UlMEhryDcEHujE2AI1As2nNzorymnWUUB7xoAhTKNVJ62CJtnsS
 vxRdxNruCBj7Sju9hGv6dnEEEOnWhpsnCgwrWenobpH7wtgQJLPhQFpNlinZNyEfSTiWKMs3AUf
 4FLD2KNRQAThv1u6XDPKyr3QrA+YJucNT7LeKpwDBOmrZuzoer1Yg7+f2rKbWKn7rKw3L8Kiqpw
 W2lalOSbNucTIfIdReL3CcIhVjbVdfKuQ488vPcRYRhEcMExoTq46cOPM2Mpq1bzR8hvf0N488Y
 vNQ==
X-Google-Smtp-Source: AGHT+IFzy62kXQOEYxVjxry7LJsQOuoyyuCx5uKHnyC0q+Qux9viBLgeSWn2NXpqIKoOElgs2zcpYQ==
X-Received: by 2002:a05:6808:2124:b0:3f9:eeca:5dcb with SMTP id
 5614622812f47-400b02375d1mr3284958b6e.37.1744899276051; 
 Thu, 17 Apr 2025 07:14:36 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4007639dfd1sm3173218b6e.31.2025.04.17.07.14.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 07:14:35 -0700 (PDT)
Date: Thu, 17 Apr 2025 08:14:32 -0600
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
Message-ID: <20250417141432.GV5495@bill-the-cat>
References: <20250403225058.GQ5495@bill-the-cat>
 <CAFLszTit0LgAxbMjw-96rzJ0Z7LyV-RgzpXMqG2PJj-YguorXg@mail.gmail.com>
 <20250404175710.GU5495@bill-the-cat>
 <CAFLszTgBMP-WsAw=z807e9RUY1YNB=Ky+s1MhW=x6dYt7_V+-g@mail.gmail.com>
 <20250406223854.GE5495@bill-the-cat>
 <CAFLszTjLugnmipzzCcAttyvZqQdohNV==jDj_mGzs2_1eFJw1w@mail.gmail.com>
 <20250407143056.GL5495@bill-the-cat>
 <CAFLszTjJekLH7Z3NMewpK1hYvMgXfrJ_0TknKhuZ0QRk3ZO3sg@mail.gmail.com>
 <20250414203444.GE5495@bill-the-cat>
 <CAFLszTiP9T=j1AAUDcxQDCF=sN82mxsZiEG3h5MbRsNyAFwmgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="28KzhVXF0Eb2Eg0k"
Content-Disposition: inline
In-Reply-To: <CAFLszTiP9T=j1AAUDcxQDCF=sN82mxsZiEG3h5MbRsNyAFwmgg@mail.gmail.com>
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


--28KzhVXF0Eb2Eg0k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 07:14:35AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 14 Apr 2025 at 14:34, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Apr 14, 2025 at 01:34:10PM -0600, Simon Glass wrote:
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
> > > No, that's not actually true. The problem is that no one would listen
> > > and everyone was sure I was wrong.
> >
> > That's another way of saying "no one understood you", IMO.
> >
> > > I sent the series on the basis that you were open to my maintaining
> > > bloblist in your tree. I didn't know there were extra conditions. So
> > > please let me know which way you want to go on this.
> >
> > I thought we had made progress on the community call, but now you're
> > sending this so I don't know?
> >
> > You need to:
> > - Not break handoff spec. Raymond is telling you how to get a QEMU that
> >   uses that now, and I'm actively waiting on Harrison Mutai to answer
> >   one last question I had before adding vexpress_fvp to our CI. So this
> >   should be a reasonable requirement.
> > - You were going to add register passing of bloblist location for x86,
> >   and then add register passing of bloblist between U-Boot phases
> >   without relying on BLOBLIST_FiXED.
> > - Some amount of un-tangling "do we have a bloblist" from "did we get a
> >   bloblist" is needed, so we can just check "Did we get a bloblist? Y/N"
> >   in lib/fdtdec.c::fdtdec_setup(). With that, we can add OF_BLOBLIST as
> >   a choice with OF_SEPARATE / OF_EMBEDED and we can remove a bunch of
> >   the logic at the top of lib/fdtdec.c::fdtdec_setup() too.
>=20
> That seems very much like a list of instructions. So in fact you still
> want to be the maintainer?

I mean, I'm the project maintainer. No, I'm not going to sit over your
shoulder and tell you how to do that. But I am telling you what is and
isn't acceptable. I don't just blindly take patches from anyone. You are
not being singled out here.

> To be clear, I don't disagree with the list here but I am not willing
> to argue with people anymore about how it should work. I designed it
> and I know how it should work.
>=20
> Also I think I now understand what you are saying about bloblist and
> standard passage being split. It's because most of my standard passage
> series from a few years back was never applied.
>=20
> So I'd like to go back and revisit that and get it applied, including
> the gitlab test for the new qemu_arm/64_spl

I assume you'll be posting a v2 of something, which can be applied,
soon then?

--=20
Tom

--28KzhVXF0Eb2Eg0k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgBDMAACgkQFHw5/5Y0
tyw4awwAp1i1A00I8Ei4ZoJ23n5oldkBtYXYYeUi/l3lO7QyuWkExB4tKbHxZgsR
57Oxi4CsiUqi8ihj4InGc+J6ifwPqOXveifEIZobtDMEbwnYvOyr5rlmPTimEMhw
ftSxXbqni3OOpG2V813wZ0/utUiHUVhRkqi7+AyqNGIrsal5qKkdh/q1M8iH0vIo
FyVRHuDN6SzG6201oTKMR4tJmy9uSbwRxED5aNSNM0qO75dqcB+12w/jyVkOtxUm
o/4Hhpej7ZTS0+T0YaAfgJTH4lwoq54r4UgLUC6RqBDqrtX0A+fgQaDsz1bi6fVE
MJsAEVoUJjo2VIXEUzltOBTGN38lvsh5tlnYmmCisdatlYcv9iZ6j1rY+6NorZ2P
jCXjs0Al/C3EfeySEr+509qmTbFgoKZR+23Hj0b8kwTVc+/fywh9rGvW16VBktOM
ZkW3wqmyBy2P83BD1k1zV+yL4gLxnrGFSZunKxeKa3q4lpQ0EkYvJTIOTW5JzTi1
Ohaoy2QC
=rdQR
-----END PGP SIGNATURE-----

--28KzhVXF0Eb2Eg0k--
