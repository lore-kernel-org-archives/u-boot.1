Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDF04C369C9
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 21:58:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 499AF82991;
	Thu, 17 Apr 2025 23:58:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="as02VCpJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 410E782CFD; Thu, 17 Apr 2025 23:58:10 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A018381F7E
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 23:58:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-72fffa03ac6so517734a34.3
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 14:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744927086; x=1745531886; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LHRx+1Y2D3U+dp3SoQzZhNaGtrpo7Nl4fX67r24yEpw=;
 b=as02VCpJsFC8WkqnrTx4M0duB0nQ/aGwi54WlDxqxhnyYjozT88IH2WTb6tpyuw5d/
 jetKQkzn8ki44faKSN7htqjmuFJz8OQ6oxMkTvvgy/IY4V17gqgrhqTgClGp0iwA3Duj
 ENE152QTfjG/AmU5DCAsSFXEFBt20wpFPMNv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744927086; x=1745531886;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LHRx+1Y2D3U+dp3SoQzZhNaGtrpo7Nl4fX67r24yEpw=;
 b=KLEZe8dTRFIUOysQiOOfuVTA02IFnesXGrLizDW5AdMsLtb5NbfnRKqruW4DK9yoUA
 lKOYYtglHjF+LA8XnzZFW3DoNhqcJESFdYy8O5IKaTSp8+msQTHZmgC8zJgHVRGi2VoW
 Sj3wHOgDO0zm8TSmPh0wOz8TkDIq3mHlFMNgazjbtib8ZqzA85CWMe0zdwKOvZ/bleDF
 FDujqdxvs5RrTJKAK+sEkKtVj6X4ThS4q1N64VHk35mvQB4weqy2kvOFvwau1UOhoWrJ
 IA19uRGc3KyeQ4rEcaJemdxn0gOU/A0tb3aYCbvb+xnuMpT+GKO1greF2T3/VJ95MKX3
 HyQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKAfpMJlFb9i/LTulJfK7E+nGxxJ5CunmZqy1+fwjLWW+WSh9wOR9DyYZdB0IArNuEhWwuyvY=@lists.denx.de
X-Gm-Message-State: AOJu0YwI6YK6sk/jcgwNLesE7T5rxm7kVc/A7nlpN+05xz5UtS6dhNz/
 NZce+e8Gx8g4ZOpFehCxp5CYwhGvGCjqBhrbyWdKE7b3P+nxdbq7r5eIrwPi+uw=
X-Gm-Gg: ASbGnctQ4YtCMJSxCsKzwOqNGmY2QyvNrH4hDBJ1dOymOovb4oIWkurnTVorN7PlEGu
 29Mj12Q2EhBsWXvYhArchAiltjQ+kxIwGXJXPlHISJWy+yn8TfzguZgC2vlIT0XIHxzsALmoGaC
 ODS6cW25i7k8QD8Sot27H7skk3Gv+QZNr3RqaOiHYyjbmlaYXrk2c0IgYeYsc/v6WhLjbjV71ok
 Kml0/oM9/JOGcF53je5A/a8WRM4ujJL96RGK+5MW+2AGY5mmnD9uJRpBMJ4RY+BujM3yPsHWIYt
 Mw2XhS6OyvyhnYvwveHxDKU7h1OIvHMKw7vd7PWzbokyCij4pxLhpr1IB3Sv77cnievgPnC3XPM
 9+Q==
X-Google-Smtp-Source: AGHT+IGf+49tgDZS1igdRKfwSZIBbORKkpyYrYmHyJgbLMlRrg3992NOPFWbiXCJu1zB63vNKMAAhg==
X-Received: by 2002:a05:6830:4193:b0:72a:1a9f:7dc7 with SMTP id
 46e09a7af769-7300620c87cmr207449a34.7.1744927086273; 
 Thu, 17 Apr 2025 14:58:06 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7300478ed86sm109132a34.11.2025.04.17.14.58.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 14:58:05 -0700 (PDT)
Date: Thu, 17 Apr 2025 15:58:02 -0600
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
Message-ID: <20250417215802.GD5495@bill-the-cat>
References: <20250404175710.GU5495@bill-the-cat>
 <CAFLszTgBMP-WsAw=z807e9RUY1YNB=Ky+s1MhW=x6dYt7_V+-g@mail.gmail.com>
 <20250406223854.GE5495@bill-the-cat>
 <CAFLszTjLugnmipzzCcAttyvZqQdohNV==jDj_mGzs2_1eFJw1w@mail.gmail.com>
 <20250407143056.GL5495@bill-the-cat>
 <CAFLszTjJekLH7Z3NMewpK1hYvMgXfrJ_0TknKhuZ0QRk3ZO3sg@mail.gmail.com>
 <20250414203444.GE5495@bill-the-cat>
 <CAFLszTiP9T=j1AAUDcxQDCF=sN82mxsZiEG3h5MbRsNyAFwmgg@mail.gmail.com>
 <20250417141432.GV5495@bill-the-cat>
 <CAFLszTga9RuHamjjWFRXR5X0uzq1zBqC5YiLjKEOhAj+ZSm0gA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="E5JcD4jz4EHkUxLA"
Content-Disposition: inline
In-Reply-To: <CAFLszTga9RuHamjjWFRXR5X0uzq1zBqC5YiLjKEOhAj+ZSm0gA@mail.gmail.com>
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


--E5JcD4jz4EHkUxLA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 03:24:17PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 17 Apr 2025 at 08:14, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Apr 17, 2025 at 07:14:35AM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Mon, 14 Apr 2025 at 14:34, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Mon, Apr 14, 2025 at 01:34:10PM -0600, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Mon, 7 Apr 2025 at 08:31, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Mon, Apr 07, 2025 at 12:35:15PM +1200, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Mon, 7 Apr 2025 at 10:38, Tom Rini <trini@konsulko.com> wr=
ote:
> > > > > > > >
> > > > > > > > On Mon, Apr 07, 2025 at 10:06:07AM +1200, Simon Glass wrote:
> > > > > > > > > Hi Tom,
> > > > > > > > >
> > > > > > > > > On Sat, 5 Apr 2025 at 06:57, Tom Rini <trini@konsulko.com=
> wrote:
> > > > > > > > > >
> > > > > > > > > > On Sat, Apr 05, 2025 at 06:39:39AM +1300, Simon Glass w=
rote:
> > > > > > > > > > > Hi Tom,
> > > > > > > > > > >
> > > > > > > > > > > On Fri, 4 Apr 2025 at 11:51, Tom Rini <trini@konsulko=
=2Ecom> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Fri, Apr 04, 2025 at 11:41:08AM +1300, Simon Gla=
ss wrote:
> > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Fri, 4 Apr 2025 at 10:52, Tom Rini <trini@kons=
ulko.com> wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On Fri, Apr 04, 2025 at 09:40:29AM +1300, Simon=
 Glass wrote:
> > > > > > > > > > > > > > > Hi Raymond,
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > On Fri, 4 Apr 2025 at 08:54, Raymond Mao <ray=
mond.mao@linaro.org> wrote:
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Hi Simon,
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > On Thu, 3 Apr 2025 at 14:18, Simon Glass <s=
jg@chromium.org> wrote:
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > Hi Raymond,
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > On Fri, 4 Apr 2025 at 07:13, Raymond Mao =
<raymond.mao@linaro.org> wrote:
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > Hi Simon,
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > On Thu, 3 Apr 2025 at 13:57, Simon Glas=
s <sjg@chromium.org> wrote:
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > Hi Raymond,
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > On Fri, 4 Apr 2025 at 03:09, Raymond =
Mao <raymond.mao@linaro.org> wrote:
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > Hi Simon,
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > On Fri, 28 Mar 2025 at 11:44, Simon=
 Glass <sjg@chromium.org> wrote:
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > The bloblist code took what I con=
sider to be a wrong turn a year or so
> > > > > > > > > > > > > > > > > > > > > ago. As discussed with Tom, this =
series proposes a way to arrange things
> > > > > > > > > > > > > > > > > > > > > so that it is simpler to understa=
nd and manage.
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > - Unwind some of the nesting in b=
loblist_init()
> > > > > > > > > > > > > > > > > > > > > - Avoid needing to init the blobl=
ist just to get the FDT
> > > > > > > > > > > > > > > > > > > > > - Create a deterministic OF_BLOBL=
IST option rather than using guesswork
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > We now have a kconfig BLOBLIST_PASS=
AGE_MANDATORY which means
> > > > > > > > > > > > > > > > > > > > mandatorily use bloblist to hand ov=
er everything between boot stages
> > > > > > > > > > > > > > > > > > > > including fdt, creating OF_BLOBLIST=
 is not necessary.
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > Yes, I noticed that, but BLOBLIST_PAS=
SAGE_MANDATORY indicates that
> > > > > > > > > > > > > > > > > > > there must be a bloblist, not that it=
 must contain a devicetree. So I
> > > > > > > > > > > > > > > > > > > wasn't sure about removing it.
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > See my comments to your [2/4] patch, if=
 BLOBLIST_PASSAGE_MANDATORY is
> > > > > > > > > > > > > > > > > > selected, we can override any fdt from =
board or env with the one from
> > > > > > > > > > > > > > > > > > the bloblist.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > Yes, but we should be explicit about what=
 is going on here. With
> > > > > > > > > > > > > > > > > OF_BLOBLIST we indicate that the devicetr=
ee is coming from the
> > > > > > > > > > > > > > > > > bloblist. It becomes one of the sources f=
or devicetree, like
> > > > > > > > > > > > > > > > > OF_SEPARATE and OF_EMBED
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > BLOBLIST_PASSAGE_MANDATORY indicates the fd=
t from bloblist will be
> > > > > > > > > > > > > > > > mandatorily used and override other fdt sou=
rces like from the board or
> > > > > > > > > > > > > > > > env variables.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > So long as you are OK with OF_BLOBLIST as wel=
l, I have no objection to
> > > > > > > > > > > > > > > keeping BLOBLIST_PASSAGE_MANDATORY, although =
I don't like the name
> > > > > > > > > > > > > > > very much. But I can see why it is called tha=
t as my standard passage
> > > > > > > > > > > > > > > series was actually never applied. So I suppo=
se I'll need to have
> > > > > > > > > > > > > > > another try at that.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > So to be clear, I want a separate option for =
devicetree, called
> > > > > > > > > > > > > > > OF_BLOBLIST, which I can enable/disable as ne=
eded, without affecting
> > > > > > > > > > > > > > > your option.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Sigh. Can I ask what the use case for this will=
 be? And we are going to
> > > > > > > > > > > > > > get rid of BLOBLIST_FIXED at some point, yes?
> > > > > > > > > > > > >
> > > > > > > > > > > > > I thought we agreed that this was acceptable. We =
argued the toss for
> > > > > > > > > > > > > months on this point and I would rather not revis=
it it.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Yes, I will look at removing BLOBLIST_FIXED once =
this is in. I'm
> > > > > > > > > > > > > pretty sure it can be done. The only tricky bit i=
s coming up with a
> > > > > > > > > > > > > bloblist protocol for x86.
> > > > > > > > > > > >
> > > > > > > > > > > > Yes, I'm stuck between being "flexible and saying y=
es" and how long we
> > > > > > > > > > > > have to live with what I also think are bad designs.
> > > > > > > > > > > >
> > > > > > > > > > > > So maybe the pre-requisite here is that with "blobl=
ist" and "standard
> > > > > > > > > > > > passage" being divorced, what is the requirement fo=
r bloblist again?
> > > > > > > > > > > > Because in practice, all of the problems we've had =
come down to looking
> > > > > > > > > > > > in fixed address locations before they're valid. Yo=
u want to handle this
> > > > > > > > > > > > by saying "Ah, we won't look before it's valid with=
 other CONFIG flags"
> > > > > > > > > > > > and I say we should handle this by not using a fixe=
d address to start
> > > > > > > > > > > > with.
> > > > > > > > > > > >
> > > > > > > > > > > > If we have to add OF_BLOBLIST now and delete it in =
a few months, sigh,
> > > > > > > > > > > > OK. But it shouldn't need to exist long term.
> > > > > > > > > > >
> > > > > > > > > > > For me, OF_BLOBLIST is needed for x86 devices which d=
on't pass the
> > > > > > > > > > > devicetree in the bloblist.
> > > > > > > > > >
> > > > > > > > > > I don't understand why that would become the case when =
it's not true
> > > > > > > > > > today.
> > > > > > > > >
> > > > > > > > > If you look at the top obbfdtdec_setup() in your tree you=
 can see the
> > > > > > > > > special-case code related to TPL, that I'm wanting to get=
 rid of.
> > > > > > > >
> > > > > > > > OK, but all of that too is for the case of a fixed bloblist=
 being in
> > > > > > > > uninitialized memory. Which is why I don't like BLOBLIST_FI=
XED and want
> > > > > > > > to see passing of the bloblist from xPL -> PPL be implement=
ed and so xPL
> > > > > > > > can allocate a bloblist (or grow a passed one if needed).
> > > > > > >
> > > > > > > We are going around in circles though. Having it is registers=
 doesn't
> > > > > > > help with the problem that there isn't an FDT in the bloblist.
> > > > > >
> > > > > > Sure it does. If we're passed a bloblist in a register we can t=
hen see
> > > > > > if it has a DT (and use it) or not (and move to the next DT loc=
ation).
> > > > > >
> > > > > > > Also, I thought you decided that I could maintain bloblist. H=
ave you
> > > > > > > changed your mind?
> > > > > >
> > > > > > You just mis-understood me. Yes, you can maintain bloblist. But=
 also,
> > > > > > Yes, I need to understand what you're doing. The root of the OF=
_BLOBLIST
> > > > > > problems is that no one understood you.
> > > > >
> > > > > No, that's not actually true. The problem is that no one would li=
sten
> > > > > and everyone was sure I was wrong.
> > > >
> > > > That's another way of saying "no one understood you", IMO.
> > > >
> > > > > I sent the series on the basis that you were open to my maintaini=
ng
> > > > > bloblist in your tree. I didn't know there were extra conditions.=
 So
> > > > > please let me know which way you want to go on this.
> > > >
> > > > I thought we had made progress on the community call, but now you're
> > > > sending this so I don't know?
> > > >
> > > > You need to:
> > > > - Not break handoff spec. Raymond is telling you how to get a QEMU =
that
> > > >   uses that now, and I'm actively waiting on Harrison Mutai to answ=
er
> > > >   one last question I had before adding vexpress_fvp to our CI. So =
this
> > > >   should be a reasonable requirement.
> > > > - You were going to add register passing of bloblist location for x=
86,
> > > >   and then add register passing of bloblist between U-Boot phases
> > > >   without relying on BLOBLIST_FiXED.
> > > > - Some amount of un-tangling "do we have a bloblist" from "did we g=
et a
> > > >   bloblist" is needed, so we can just check "Did we get a bloblist?=
 Y/N"
> > > >   in lib/fdtdec.c::fdtdec_setup(). With that, we can add OF_BLOBLIS=
T as
> > > >   a choice with OF_SEPARATE / OF_EMBEDED and we can remove a bunch =
of
> > > >   the logic at the top of lib/fdtdec.c::fdtdec_setup() too.
> > >
> > > That seems very much like a list of instructions. So in fact you still
> > > want to be the maintainer?
> >
> > I mean, I'm the project maintainer. No, I'm not going to sit over your
> > shoulder and tell you how to do that. But I am telling you what is and
> > isn't acceptable. I don't just blindly take patches from anyone. You are
> > not being singled out here.
>=20
> Heaven forbid. Although I see that you reverted the PXE stuff rather
> than taking my fix-up patch. That's different from what you did with
> all the lmb breakage.

Because you said I should just revert it since I didn't "support" it.
And didn't look in to booti. So yes, that series needs a re-baking to
also fix booti as it has a similar set of handling things outside the
bootm state machine, and really re-checking nothing else got missed.

> > > To be clear, I don't disagree with the list here but I am not willing
> > > to argue with people anymore about how it should work. I designed it
> > > and I know how it should work.
> > >
> > > Also I think I now understand what you are saying about bloblist and
> > > standard passage being split. It's because most of my standard passage
> > > series from a few years back was never applied.
> > >
> > > So I'd like to go back and revisit that and get it applied, including
> > > the gitlab test for the new qemu_arm/64_spl
> >
> > I assume you'll be posting a v2 of something, which can be applied,
> > soon then?
>=20
> Yes, v3 is posted. It took a while as the original series was from 2021.

OK.

--=20
Tom

--E5JcD4jz4EHkUxLA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgBeWoACgkQFHw5/5Y0
tyxuAAv+J8ebF2HkINZZbv/I1/FRt4MskEwK5EC13e5qORHBagoo5SZwuiQc/jrG
7b4ll+ZhRn9UCbpzKpSg2bDxKZwekM5/wZm2GW6uRg7cEenssLTBUoJWwp8fFPkz
vwF4AFe/uCuRpey0TWqUCDaYFHkAIg6s9yp7OUGi9GwP/hgUQVGALKJTgzoVbR4J
UJ0WOCPnbpQC+DJolEljegvFTWiKPE6HT08QkHUXwTqu2Q89cld/sYg+5Gq1I5+I
9vxZoXVcA1Gsc34oYsd+M5aUcszdOO8xs5z5PO2utFJH3TPjQapD6eXjVa5Hv0/0
/mPgkFmzHS7YY9jL4r+al3/C+7htFTnPMc8ez9zXQXZeXchqRbTwjYGFoQw2fID0
JXOgpL6j+sbApb3avQjQqwVH14WBHC5Y22i6I4O+1Ib3t6MwQHF1J4Mjtc+RZWb8
KmWQlgixS5v1SgdFvCgLnTbVhVsJ+3Q1iQI674Vnu3+fAFfukoBB8kPHMYCrCEaA
TZbJ7hYK
=pknr
-----END PGP SIGNATURE-----

--E5JcD4jz4EHkUxLA--
