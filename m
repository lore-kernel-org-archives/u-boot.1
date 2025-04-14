Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D9AC369B5
	for <u-boot@archiver.kernel.org>; Mon, 14 Apr 2025 20:34:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 432A98215D;
	Mon, 14 Apr 2025 22:34:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="M/y7kIIO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EF7682169; Mon, 14 Apr 2025 22:34:52 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D22FE82153
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 22:34:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3feb0db95e6so3076590b6e.1
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 13:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744662888; x=1745267688; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LOc3Hf6bL0RT2y0EIRwzgezpTnX3j/SX5iysGQjuSfo=;
 b=M/y7kIIO1JhZQ0Aa5ud57ToRTk+FSmi3IQkmK9ZOcKDxhf3MNav+9qc7VKlOgXTdlC
 MnhQnj5Z6o4+LBKMEL0NPFfJAE2nvqnOec7AMFzAIT7CQT1DYTY5lpmGOf2vZzbiMlaj
 TzG7jPHfXDyN19a3besB7E4Uy1e4G4nixNNiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744662888; x=1745267688;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LOc3Hf6bL0RT2y0EIRwzgezpTnX3j/SX5iysGQjuSfo=;
 b=E9Jl73+Cx5kqkU72OZLr8eCB6b+qvYTo2opO/mfGfDmkr3oVpOAAuem//D9BFPwofG
 Usmbn7xLKa6/WSCxMIUsFcUQ5CmJi8+Z+SDn0c4tzDTRfo5U+iWr9Si9pbjZTWzacqwQ
 3A67d76gPuy7Q0n4ucOIb911vJSuMTdhxr//hSwDDxyHbXmyHeyXrF0qbKGiq/VukyPI
 1mck/ZITNGmqxtBz5G3zBxp0qMIKNg3dafClgZLpwAagIzrH8Fc+YQ6tH5D2NI0Xkun1
 1ZAo53pb3NsupQoSqJ6DNVAJtQmS/k/buseNXMyQYL4ebVT/8FbRDBCz1gKxh2L3bG8A
 B68A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjTw1F/3S7loKKvdMEng5i4yYlyG1ZvO91WuM0JMHko2blsHTqhAr0mvmOkip9VQn0RO3BlyU=@lists.denx.de
X-Gm-Message-State: AOJu0Yz49nJh6rBqWeizNWTrdNURLff5PI7qxBxA06nyEQ+uGxD7WkC5
 5IILTxuCJQyi8gGMRZCnb15woTuy6n3TEXhfj+/q8lVdKAJEE+f73I536+fchn8=
X-Gm-Gg: ASbGncuRmPfphIG1qT2O+cog1b35vOekj2ft1f5ywq1aDjcD4lNwu/oWW6OLX1PKLhl
 7rnDwkYTXRL3cxCdDfqIWFd/bVvzI26hyWUlLOnX6zC9jsiYyFSk9kkLbHPsVFrRp/Fg4fQyefl
 LrVyN9YDK6vhjZlb3b1r/1kBFEOLiytwY1CTvxevsINwbQxocHuOJKM0K4L5c3ozRJDA1MFdVhc
 QGq9/7YEeXALu0+8xf4RULLXr2IAh+vW5/NjPYEBE9zKXp5y8KeHV8dndEBJ1ids2UZcP2ODcPd
 Yz9PJdvxd3pPzQ0hPUES9tYFkhe3/F+WiuutHaI/07A6zIjwUun+6Ln0IqNbinhyy+EoVVqd7wx
 o1g==
X-Google-Smtp-Source: AGHT+IH7v5Ck/yvx8PkcK8gWukhsqSR1Jbd2yfriGbpC/y4cNaelv+KV+/AUVXSBjje2CCRhAI4XWw==
X-Received: by 2002:a05:6808:1805:b0:3f8:55b7:87a0 with SMTP id
 5614622812f47-4008503b60fmr6519286b6e.14.1744662888463; 
 Mon, 14 Apr 2025 13:34:48 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4007639c638sm2103938b6e.35.2025.04.14.13.34.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Apr 2025 13:34:47 -0700 (PDT)
Date: Mon, 14 Apr 2025 14:34:44 -0600
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
Message-ID: <20250414203444.GE5495@bill-the-cat>
References: <20250403215239.GO5495@bill-the-cat>
 <CAFLszTjB7Ax24c1SF4yEt7xzJKpO5tHyQsjGutrhDteFYebyyg@mail.gmail.com>
 <20250403225058.GQ5495@bill-the-cat>
 <CAFLszTit0LgAxbMjw-96rzJ0Z7LyV-RgzpXMqG2PJj-YguorXg@mail.gmail.com>
 <20250404175710.GU5495@bill-the-cat>
 <CAFLszTgBMP-WsAw=z807e9RUY1YNB=Ky+s1MhW=x6dYt7_V+-g@mail.gmail.com>
 <20250406223854.GE5495@bill-the-cat>
 <CAFLszTjLugnmipzzCcAttyvZqQdohNV==jDj_mGzs2_1eFJw1w@mail.gmail.com>
 <20250407143056.GL5495@bill-the-cat>
 <CAFLszTjJekLH7Z3NMewpK1hYvMgXfrJ_0TknKhuZ0QRk3ZO3sg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="I7qcaqJs/nsA+W95"
Content-Disposition: inline
In-Reply-To: <CAFLszTjJekLH7Z3NMewpK1hYvMgXfrJ_0TknKhuZ0QRk3ZO3sg@mail.gmail.com>
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


--I7qcaqJs/nsA+W95
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 01:34:10PM -0600, Simon Glass wrote:
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
> No, that's not actually true. The problem is that no one would listen
> and everyone was sure I was wrong.

That's another way of saying "no one understood you", IMO.

> I sent the series on the basis that you were open to my maintaining
> bloblist in your tree. I didn't know there were extra conditions. So
> please let me know which way you want to go on this.

I thought we had made progress on the community call, but now you're
sending this so I don't know?

You need to:
- Not break handoff spec. Raymond is telling you how to get a QEMU that
  uses that now, and I'm actively waiting on Harrison Mutai to answer
  one last question I had before adding vexpress_fvp to our CI. So this
  should be a reasonable requirement.
- You were going to add register passing of bloblist location for x86,
  and then add register passing of bloblist between U-Boot phases
  without relying on BLOBLIST_FiXED.
- Some amount of un-tangling "do we have a bloblist" from "did we get a
  bloblist" is needed, so we can just check "Did we get a bloblist? Y/N"
  in lib/fdtdec.c::fdtdec_setup(). With that, we can add OF_BLOBLIST as
  a choice with OF_SEPARATE / OF_EMBEDED and we can remove a bunch of
  the logic at the top of lib/fdtdec.c::fdtdec_setup() too.

--=20
Tom

--I7qcaqJs/nsA+W95
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmf9cVIACgkQFHw5/5Y0
tyy5wAv/VkvxPExnrQZM2Fi6bDblLg5VmzdiuoCOgdUG8P3Du7WNIZ6PfQbBn5Vm
BlLpEXgB9kLop/ScHTEy2DhA4ZGUgPYqlydCZehftJoOBXLq7y30/Rn7thKtHsCe
ey7K9dZwEphyWvjoT1Vyg0/aGcznDFegPkdonmbxHSTgDngZ96ke0TbUhQ5eagwQ
h71aNV///DgWKE7v1eaTqV5SkEWv3j8Usu8BYePDJqZoLgIh5VQ/6NDuPuk/E7Cc
Cq+TUsELEiSq1tCfZsbwy8ItCNAKAZNy2ZRUWuAyx84iM4Vqs44WMtAw/yRyL9qI
b24Y6NbeICLlO6YhYLgolUP8JQU9tKw9CeSswsAO+HYRhFa/oghXqvUEUqlu2vMC
UkhFzQrTSanHe5BxdYwe7z//vdOVgOhdNvCoPPTbll+UFY/jqFj6yL9O72jZBh9U
LhZtNzQ0EWfoZiLswbiw2aqmtEXvOdb2J0rPIDo77ecWNTeXOw9+ZvwkCGsPpNdq
gtZyiMlQ
=ZOSa
-----END PGP SIGNATURE-----

--I7qcaqJs/nsA+W95--
