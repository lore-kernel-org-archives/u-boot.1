Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F242AC369C9
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 22:15:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 265E582EBE;
	Fri, 18 Apr 2025 00:14:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dD7uleAs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4255830A0; Fri, 18 Apr 2025 00:14:57 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F95082E38
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 00:14:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-2c7f876b320so768692fac.1
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 15:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744928094; x=1745532894; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=c+rZ3OBm21o3e4zZUztoJqQiUfOsb3qWeF+rXnc09u0=;
 b=dD7uleAsmkcI5CmmJcSjMgRaBuSykNfIkVTdtIHPVb6ivdKkxo9ZCgt8g73mdncN7q
 uR+PLysnFJYHSxnrt51oYELIPDa/de5Y37IA+HokOE01KjSpwQXLAvYJshON8GcfuHHb
 It6e/VICbCuYs2Pjr6jvVAAino7SE/FoZWN2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744928094; x=1745532894;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c+rZ3OBm21o3e4zZUztoJqQiUfOsb3qWeF+rXnc09u0=;
 b=p6ija7Tz4IiKW0smcnPcoewHv68wFuxgDoG1JT6PNkT4KuBEcIc1Y5BRFWJ8g2Zj5J
 k1viJlI8otaxsJNaMfWDuwaiBBul1NZkwwQ+/SM/TuBt/FxhQxZFujy7RFcob6183ybx
 4otYJlvAge1t0S+Py+nfvB5k7DKsZ4aGMZsOvzwIDudrW4uwKKQXRbFh18vJDjh2gany
 cTkaMqJjX6ktsznZtKvauLfgQWriaO1PQ1SosRIATI2Wda9R2BDcSu3zwlAvjibwWeoZ
 3PxiyLZWBLveULugNb3A4Ru19xPnWpNNPpyjP+jd4RGx4dGHc43pcKomDv2tOdGugmml
 au2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHV9fD0/Y7IJVW3Qi9Y9sYgd/p9nrD6jRDj6+/zfHAdv+qhHv1/mmq0aJGZz+U0jvCwqwmQ6Q=@lists.denx.de
X-Gm-Message-State: AOJu0Ywty9Bhk177j8uG9Dn906uumKZT/24ZwsqhAjyW3n3OWJVsI03c
 9g2DS2EG7YpJZz/RzjGIG27yTUjM17OH8Ya5YVFBvIxlNB8iDqwFl6nXVlCH1bA=
X-Gm-Gg: ASbGnctbadJ6rTj9YtKzfOd6O/wmoLibufXDDCUmbHO95KC5sKSmO8mogsb3rVS+mnN
 WuMQS5ER5W238D+1MA5aDR7pMXo6yDWmaPeprAElxIuqL8lMKqUjc6rZgmIeJDSLB/ipUSjuy+u
 SJo47wUMzp0OnAAmRwtn83pUvxTZn/bqVwQSD0VrwqazKfFo48SR8VSPUYksjJ3Ah+HZ1QNBihN
 8Bu+prCGp1WgGw4y5jw6aSxCMfmGIDteiQl0T4zHpB38FwtFN+Vyakjzk8i9gqRqO08yTB2LHE/
 d/laixjqhgWkrB5VcQ705NY8SETmrBRKYIDNvfNhe4i8j4KWMgDBfzJFoIgw9LYe9AQ5VP6N9+z
 AMQ==
X-Google-Smtp-Source: AGHT+IFX1QIBONr3rWM53CUH6bC41nE4+djqS1Eu4kjx2GD+RSvhVMkUUMCEfMZ2nKTcOjyZodZInw==
X-Received: by 2002:a05:6870:af85:b0:2bc:66cc:1507 with SMTP id
 586e51a60fabf-2d526a26341mr392957fac.12.1744928093763; 
 Thu, 17 Apr 2025 15:14:53 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2d52140f107sm148244fac.26.2025.04.17.15.14.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 15:14:52 -0700 (PDT)
Date: Thu, 17 Apr 2025 16:14:49 -0600
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
Message-ID: <20250417221449.GF5495@bill-the-cat>
References: <20250406223854.GE5495@bill-the-cat>
 <CAFLszTjLugnmipzzCcAttyvZqQdohNV==jDj_mGzs2_1eFJw1w@mail.gmail.com>
 <20250407143056.GL5495@bill-the-cat>
 <CAFLszTjJekLH7Z3NMewpK1hYvMgXfrJ_0TknKhuZ0QRk3ZO3sg@mail.gmail.com>
 <20250414203444.GE5495@bill-the-cat>
 <CAFLszTiP9T=j1AAUDcxQDCF=sN82mxsZiEG3h5MbRsNyAFwmgg@mail.gmail.com>
 <20250417141432.GV5495@bill-the-cat>
 <CAFLszTga9RuHamjjWFRXR5X0uzq1zBqC5YiLjKEOhAj+ZSm0gA@mail.gmail.com>
 <20250417215802.GD5495@bill-the-cat>
 <CAFLszTgudBv6sNBU-HX=a+BMZZNVF6ur8FgudAzhXv+bRepLbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MtieCvh5oGSVE9JL"
Content-Disposition: inline
In-Reply-To: <CAFLszTgudBv6sNBU-HX=a+BMZZNVF6ur8FgudAzhXv+bRepLbA@mail.gmail.com>
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


--MtieCvh5oGSVE9JL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 04:02:20PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 17 Apr 2025 at 15:58, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Apr 17, 2025 at 03:24:17PM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Thu, 17 Apr 2025 at 08:14, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Thu, Apr 17, 2025 at 07:14:35AM -0600, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Mon, 14 Apr 2025 at 14:34, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Mon, Apr 14, 2025 at 01:34:10PM -0600, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Mon, 7 Apr 2025 at 08:31, Tom Rini <trini@konsulko.com> wr=
ote:
> > > > > > > >
> > > > > > > > On Mon, Apr 07, 2025 at 12:35:15PM +1200, Simon Glass wrote:
> > > > > > > > > Hi Tom,
> > > > > > > > >
> > > > > > > > > On Mon, 7 Apr 2025 at 10:38, Tom Rini <trini@konsulko.com=
> wrote:
> > > > > > > > > >
> > > > > > > > > > On Mon, Apr 07, 2025 at 10:06:07AM +1200, Simon Glass w=
rote:
> > > > > > > > > > > Hi Tom,
> > > > > > > > > > >
> > > > > > > > > > > On Sat, 5 Apr 2025 at 06:57, Tom Rini <trini@konsulko=
=2Ecom> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Sat, Apr 05, 2025 at 06:39:39AM +1300, Simon Gla=
ss wrote:
> > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Fri, 4 Apr 2025 at 11:51, Tom Rini <trini@kons=
ulko.com> wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On Fri, Apr 04, 2025 at 11:41:08AM +1300, Simon=
 Glass wrote:
> > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > On Fri, 4 Apr 2025 at 10:52, Tom Rini <trini@=
konsulko.com> wrote:
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > On Fri, Apr 04, 2025 at 09:40:29AM +1300, S=
imon Glass wrote:
> > > > > > > > > > > > > > > > > Hi Raymond,
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > On Fri, 4 Apr 2025 at 08:54, Raymond Mao =
<raymond.mao@linaro.org> wrote:
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > Hi Simon,
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > On Thu, 3 Apr 2025 at 14:18, Simon Glas=
s <sjg@chromium.org> wrote:
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > Hi Raymond,
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > On Fri, 4 Apr 2025 at 07:13, Raymond =
Mao <raymond.mao@linaro.org> wrote:
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > Hi Simon,
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > On Thu, 3 Apr 2025 at 13:57, Simon =
Glass <sjg@chromium.org> wrote:
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > Hi Raymond,
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > On Fri, 4 Apr 2025 at 03:09, Raym=
ond Mao <raymond.mao@linaro.org> wrote:
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > Hi Simon,
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > On Fri, 28 Mar 2025 at 11:44, S=
imon Glass <sjg@chromium.org> wrote:
> > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > The bloblist code took what I=
 consider to be a wrong turn a year or so
> > > > > > > > > > > > > > > > > > > > > > > ago. As discussed with Tom, t=
his series proposes a way to arrange things
> > > > > > > > > > > > > > > > > > > > > > > so that it is simpler to unde=
rstand and manage.
> > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > - Unwind some of the nesting =
in bloblist_init()
> > > > > > > > > > > > > > > > > > > > > > > - Avoid needing to init the b=
loblist just to get the FDT
> > > > > > > > > > > > > > > > > > > > > > > - Create a deterministic OF_B=
LOBLIST option rather than using guesswork
> > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > We now have a kconfig BLOBLIST_=
PASSAGE_MANDATORY which means
> > > > > > > > > > > > > > > > > > > > > > mandatorily use bloblist to han=
d over everything between boot stages
> > > > > > > > > > > > > > > > > > > > > > including fdt, creating OF_BLOB=
LIST is not necessary.
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > Yes, I noticed that, but BLOBLIST=
_PASSAGE_MANDATORY indicates that
> > > > > > > > > > > > > > > > > > > > > there must be a bloblist, not tha=
t it must contain a devicetree. So I
> > > > > > > > > > > > > > > > > > > > > wasn't sure about removing it.
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > See my comments to your [2/4] patch=
, if BLOBLIST_PASSAGE_MANDATORY is
> > > > > > > > > > > > > > > > > > > > selected, we can override any fdt f=
rom board or env with the one from
> > > > > > > > > > > > > > > > > > > > the bloblist.
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > Yes, but we should be explicit about =
what is going on here. With
> > > > > > > > > > > > > > > > > > > OF_BLOBLIST we indicate that the devi=
cetree is coming from the
> > > > > > > > > > > > > > > > > > > bloblist. It becomes one of the sourc=
es for devicetree, like
> > > > > > > > > > > > > > > > > > > OF_SEPARATE and OF_EMBED
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > BLOBLIST_PASSAGE_MANDATORY indicates th=
e fdt from bloblist will be
> > > > > > > > > > > > > > > > > > mandatorily used and override other fdt=
 sources like from the board or
> > > > > > > > > > > > > > > > > > env variables.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > So long as you are OK with OF_BLOBLIST as=
 well, I have no objection to
> > > > > > > > > > > > > > > > > keeping BLOBLIST_PASSAGE_MANDATORY, altho=
ugh I don't like the name
> > > > > > > > > > > > > > > > > very much. But I can see why it is called=
 that as my standard passage
> > > > > > > > > > > > > > > > > series was actually never applied. So I s=
uppose I'll need to have
> > > > > > > > > > > > > > > > > another try at that.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > So to be clear, I want a separate option =
for devicetree, called
> > > > > > > > > > > > > > > > > OF_BLOBLIST, which I can enable/disable a=
s needed, without affecting
> > > > > > > > > > > > > > > > > your option.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Sigh. Can I ask what the use case for this =
will be? And we are going to
> > > > > > > > > > > > > > > > get rid of BLOBLIST_FIXED at some point, ye=
s?
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > I thought we agreed that this was acceptable.=
 We argued the toss for
> > > > > > > > > > > > > > > months on this point and I would rather not r=
evisit it.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Yes, I will look at removing BLOBLIST_FIXED o=
nce this is in. I'm
> > > > > > > > > > > > > > > pretty sure it can be done. The only tricky b=
it is coming up with a
> > > > > > > > > > > > > > > bloblist protocol for x86.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Yes, I'm stuck between being "flexible and sayi=
ng yes" and how long we
> > > > > > > > > > > > > > have to live with what I also think are bad des=
igns.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > So maybe the pre-requisite here is that with "b=
loblist" and "standard
> > > > > > > > > > > > > > passage" being divorced, what is the requiremen=
t for bloblist again?
> > > > > > > > > > > > > > Because in practice, all of the problems we've =
had come down to looking
> > > > > > > > > > > > > > in fixed address locations before they're valid=
=2E You want to handle this
> > > > > > > > > > > > > > by saying "Ah, we won't look before it's valid =
with other CONFIG flags"
> > > > > > > > > > > > > > and I say we should handle this by not using a =
fixed address to start
> > > > > > > > > > > > > > with.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > If we have to add OF_BLOBLIST now and delete it=
 in a few months, sigh,
> > > > > > > > > > > > > > OK. But it shouldn't need to exist long term.
> > > > > > > > > > > > >
> > > > > > > > > > > > > For me, OF_BLOBLIST is needed for x86 devices whi=
ch don't pass the
> > > > > > > > > > > > > devicetree in the bloblist.
> > > > > > > > > > > >
> > > > > > > > > > > > I don't understand why that would become the case w=
hen it's not true
> > > > > > > > > > > > today.
> > > > > > > > > > >
> > > > > > > > > > > If you look at the top obbfdtdec_setup() in your tree=
 you can see the
> > > > > > > > > > > special-case code related to TPL, that I'm wanting to=
 get rid of.
> > > > > > > > > >
> > > > > > > > > > OK, but all of that too is for the case of a fixed blob=
list being in
> > > > > > > > > > uninitialized memory. Which is why I don't like BLOBLIS=
T_FIXED and want
> > > > > > > > > > to see passing of the bloblist from xPL -> PPL be imple=
mented and so xPL
> > > > > > > > > > can allocate a bloblist (or grow a passed one if needed=
).
> > > > > > > > >
> > > > > > > > > We are going around in circles though. Having it is regis=
ters doesn't
> > > > > > > > > help with the problem that there isn't an FDT in the blob=
list.
> > > > > > > >
> > > > > > > > Sure it does. If we're passed a bloblist in a register we c=
an then see
> > > > > > > > if it has a DT (and use it) or not (and move to the next DT=
 location).
> > > > > > > >
> > > > > > > > > Also, I thought you decided that I could maintain bloblis=
t. Have you
> > > > > > > > > changed your mind?
> > > > > > > >
> > > > > > > > You just mis-understood me. Yes, you can maintain bloblist.=
 But also,
> > > > > > > > Yes, I need to understand what you're doing. The root of th=
e OF_BLOBLIST
> > > > > > > > problems is that no one understood you.
> > > > > > >
> > > > > > > No, that's not actually true. The problem is that no one woul=
d listen
> > > > > > > and everyone was sure I was wrong.
> > > > > >
> > > > > > That's another way of saying "no one understood you", IMO.
> > > > > >
> > > > > > > I sent the series on the basis that you were open to my maint=
aining
> > > > > > > bloblist in your tree. I didn't know there were extra conditi=
ons. So
> > > > > > > please let me know which way you want to go on this.
> > > > > >
> > > > > > I thought we had made progress on the community call, but now y=
ou're
> > > > > > sending this so I don't know?
> > > > > >
> > > > > > You need to:
> > > > > > - Not break handoff spec. Raymond is telling you how to get a Q=
EMU that
> > > > > >   uses that now, and I'm actively waiting on Harrison Mutai to =
answer
> > > > > >   one last question I had before adding vexpress_fvp to our CI.=
 So this
> > > > > >   should be a reasonable requirement.
> > > > > > - You were going to add register passing of bloblist location f=
or x86,
> > > > > >   and then add register passing of bloblist between U-Boot phas=
es
> > > > > >   without relying on BLOBLIST_FiXED.
> > > > > > - Some amount of un-tangling "do we have a bloblist" from "did =
we get a
> > > > > >   bloblist" is needed, so we can just check "Did we get a blobl=
ist? Y/N"
> > > > > >   in lib/fdtdec.c::fdtdec_setup(). With that, we can add OF_BLO=
BLIST as
> > > > > >   a choice with OF_SEPARATE / OF_EMBEDED and we can remove a bu=
nch of
> > > > > >   the logic at the top of lib/fdtdec.c::fdtdec_setup() too.
> > > > >
> > > > > That seems very much like a list of instructions. So in fact you =
still
> > > > > want to be the maintainer?
> > > >
> > > > I mean, I'm the project maintainer. No, I'm not going to sit over y=
our
> > > > shoulder and tell you how to do that. But I am telling you what is =
and
> > > > isn't acceptable. I don't just blindly take patches from anyone. Yo=
u are
> > > > not being singled out here.
> > >
> > > Heaven forbid. Although I see that you reverted the PXE stuff rather
> > > than taking my fix-up patch. That's different from what you did with
> > > all the lmb breakage.
> >
> > Because you said I should just revert it since I didn't "support" it.
> > And didn't look in to booti. So yes, that series needs a re-baking to
> > also fix booti as it has a similar set of handling things outside the
> > bootm state machine, and really re-checking nothing else got missed.
>=20
> If you want the series I'm happy to resend it with the fix integrated.
> Yes I carefully checked that nothing else got missed. Still, I did
> that the first time and still missed something.
>=20
> Just let me know.

The "booti" code still needs to be fixed too, that was the first of the
bug reports.

--=20
Tom

--MtieCvh5oGSVE9JL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgBfVUACgkQFHw5/5Y0
tyxQUAv+Ms/LAfgStdMjVz3viC0Rknk/SWD3xo+5RoVkXUepSfnzmsaInW6/wQ81
cBY37JEgJ1I4bYWMl9zDnjpgdZgVG5mvarKx2xIAOG2oxrhGB/lq8jW5j5ZHVpeW
C9q89Tih98d8a6FqigFOonJVryaT1UDZ7SxpPyLCc9rGuvfy8FqwGgWIgvpcHlSY
wmMTeBPZdSDGDVgZjH8Q5AgunzzETMszL9Mr3UPbgFxko77DrfreOi1pD4f4X/KD
u9tBC/daKTfwNJn6reA4PpfLdiJqClDOzi+oMFlN/W4P70bhGpLbo/gBTUXoxdn/
ZVWk+qKURW0rWQ4Ymvp2doQ9/AMbrBqy0XpGlvkqtyNVhU2GoleOTM5uAtVfNAEl
7gHcMoigWmbfDLb3bhinkAXFBot06dIlJErKurnUVkbUDYAIPdudteuxWwtoRR2p
XqdAkc0pkIh8S2Y19F1rhaP1F3N1kBHKjZOD7zT2kuRShPypGLOFVui/H6dbh9bD
giUCd+9j
=YrFm
-----END PGP SIGNATURE-----

--MtieCvh5oGSVE9JL--
