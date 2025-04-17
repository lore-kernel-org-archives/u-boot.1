Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8CF5C369C9
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 22:37:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC80E82A96;
	Fri, 18 Apr 2025 00:37:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IkOo+Tn+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4302082B3F; Fri, 18 Apr 2025 00:37:08 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8986682A71
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 00:37:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-400b948600aso315246b6e.0
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 15:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744929424; x=1745534224; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=szc23njMJh2hb4NxMod0r44zgQovUnGivWM0ArPOOZs=;
 b=IkOo+Tn+cBV14TmIjUK2ftuqH6mkP87SDnVizE3gLnqgObzieLftkCGc2Pp6lNDh9w
 eEwoFI3hcgOS8KOYAaQ+ZLkJ2radnHZmPqsn+Ucke3P0mu6SHUzQAeKFb/U2F0Q8z2bc
 1d7mL6yCloKLuyiIyZV5Ci6fXoGEJMhi6HHgg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744929424; x=1745534224;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=szc23njMJh2hb4NxMod0r44zgQovUnGivWM0ArPOOZs=;
 b=DrGh1awrkqoTH0efBZx3hDLHFo/Wj4ZiZ5c4HKpFd5wBT8fFOmfNfkq6b6IM3+6jah
 Zm1JmnaClDYyAAbbcPGJBFQM+kP3nwV3QhmG4iY8AH0DrZLCbbt58x0EnDHnYDlqIVS+
 I4goVxtbWnWbb5wxwtCouEOk9QsIZrFnolTvB8JvvN+uh2MPxXnMsrHSkIGoXXet8EBy
 iccjrRwExm2dEEDjRCWChFdoP1j3MwkerZqxrkBxY2pM42mz6wE0ja3WsoxQ9ESLE2MR
 pS1v5X/pSE9tW+DNWEAnvMummJphf5Yjb/mh5gwKbygfxoP9xl2A4biYnv/h1DHfYiHT
 Z+eg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuLR+QiypoYtIFZHf6gtbYkj7nsSKlbX+LEvopz+Q7zKKzeJA2ccTouY8NF0pdl8AOozjWygQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwdNhFQgPuV2AZq0Rqd/pyeRuM/t+/L7CeEM7wr0N5yVoSjtcnG
 xMBfrYDtI2KBvBw1Ncfx1UQf75kDwE5+kvqN4focb/nKLyqk/CNCETzDH9mNL5c=
X-Gm-Gg: ASbGncv3xN2jM6qgfRnnSVqSlDFU8gViBQhQsv+KMbTRgMWCSxUsXpPPW+UlKFneRRx
 Bg9ljs5TIF0gF2Hy7UHySuaAfo/QfG2gpdp747HwDS7pXR2JdS2zxZAc9l0rjvfaT0lgcXBnPrv
 3onWJW2iTVmAUKr+xhkZLIzB81oTsiINsJ9LeN6QVZT7qOdFjob3WG69xF2ccxkpkxB/4WvxQd4
 kBICFdbz3ne9VbX1TwGu/WK8Ia5oaCIsQgkhQJPY21Q+VR98WMc6letdibD7xC5TcotmBFXflCs
 q7vLCGB/ggppbwd0ZcOHqeGud7cBtpgWZE9nPQmhQfmNw47HBu87E2EXwNpe5QRTWAg78xuVs09
 jvg==
X-Google-Smtp-Source: AGHT+IE0UXfyHxpt+QHSCmpF1kSVtoq3qYr5CFmCC26z5g2RK8OJipXQLZwbDDL9M8w8Q721ZOfH1A==
X-Received: by 2002:a05:6808:811a:b0:3f8:93c5:6d85 with SMTP id
 5614622812f47-401c0a70a24mr279200b6e.16.1744929424155; 
 Thu, 17 Apr 2025 15:37:04 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-401beeffe05sm108297b6e.30.2025.04.17.15.37.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 15:37:03 -0700 (PDT)
Date: Thu, 17 Apr 2025 16:37:00 -0600
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
Message-ID: <20250417223700.GH5495@bill-the-cat>
References: <20250407143056.GL5495@bill-the-cat>
 <CAFLszTjJekLH7Z3NMewpK1hYvMgXfrJ_0TknKhuZ0QRk3ZO3sg@mail.gmail.com>
 <20250414203444.GE5495@bill-the-cat>
 <CAFLszTiP9T=j1AAUDcxQDCF=sN82mxsZiEG3h5MbRsNyAFwmgg@mail.gmail.com>
 <20250417141432.GV5495@bill-the-cat>
 <CAFLszTga9RuHamjjWFRXR5X0uzq1zBqC5YiLjKEOhAj+ZSm0gA@mail.gmail.com>
 <20250417215802.GD5495@bill-the-cat>
 <CAFLszTgudBv6sNBU-HX=a+BMZZNVF6ur8FgudAzhXv+bRepLbA@mail.gmail.com>
 <20250417221449.GF5495@bill-the-cat>
 <CAFLszThsLMZ9jvkWoUnmW5xSm9qz+zKXzDOu_b7uaDOHXhSkUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6OBPI5OIddyMluM+"
Content-Disposition: inline
In-Reply-To: <CAFLszThsLMZ9jvkWoUnmW5xSm9qz+zKXzDOu_b7uaDOHXhSkUA@mail.gmail.com>
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


--6OBPI5OIddyMluM+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 04:28:42PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 17 Apr 2025 at 16:14, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Apr 17, 2025 at 04:02:20PM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Thu, 17 Apr 2025 at 15:58, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Thu, Apr 17, 2025 at 03:24:17PM -0600, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Thu, 17 Apr 2025 at 08:14, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Thu, Apr 17, 2025 at 07:14:35AM -0600, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Mon, 14 Apr 2025 at 14:34, Tom Rini <trini@konsulko.com> w=
rote:
> > > > > > > >
> > > > > > > > On Mon, Apr 14, 2025 at 01:34:10PM -0600, Simon Glass wrote:
> > > > > > > > > Hi Tom,
> > > > > > > > >
> > > > > > > > > On Mon, 7 Apr 2025 at 08:31, Tom Rini <trini@konsulko.com=
> wrote:
> > > > > > > > > >
> > > > > > > > > > On Mon, Apr 07, 2025 at 12:35:15PM +1200, Simon Glass w=
rote:
> > > > > > > > > > > Hi Tom,
> > > > > > > > > > >
> > > > > > > > > > > On Mon, 7 Apr 2025 at 10:38, Tom Rini <trini@konsulko=
=2Ecom> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Mon, Apr 07, 2025 at 10:06:07AM +1200, Simon Gla=
ss wrote:
> > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Sat, 5 Apr 2025 at 06:57, Tom Rini <trini@kons=
ulko.com> wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On Sat, Apr 05, 2025 at 06:39:39AM +1300, Simon=
 Glass wrote:
> > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > On Fri, 4 Apr 2025 at 11:51, Tom Rini <trini@=
konsulko.com> wrote:
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > On Fri, Apr 04, 2025 at 11:41:08AM +1300, S=
imon Glass wrote:
> > > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > On Fri, 4 Apr 2025 at 10:52, Tom Rini <tr=
ini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > On Fri, Apr 04, 2025 at 09:40:29AM +130=
0, Simon Glass wrote:
> > > > > > > > > > > > > > > > > > > Hi Raymond,
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > On Fri, 4 Apr 2025 at 08:54, Raymond =
Mao <raymond.mao@linaro.org> wrote:
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > Hi Simon,
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > On Thu, 3 Apr 2025 at 14:18, Simon =
Glass <sjg@chromium.org> wrote:
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > Hi Raymond,
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > On Fri, 4 Apr 2025 at 07:13, Raym=
ond Mao <raymond.mao@linaro.org> wrote:
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > Hi Simon,
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > On Thu, 3 Apr 2025 at 13:57, Si=
mon Glass <sjg@chromium.org> wrote:
> > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > Hi Raymond,
> > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > On Fri, 4 Apr 2025 at 03:09, =
Raymond Mao <raymond.mao@linaro.org> wrote:
> > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > Hi Simon,
> > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > On Fri, 28 Mar 2025 at 11:4=
4, Simon Glass <sjg@chromium.org> wrote:
> > > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > > The bloblist code took wh=
at I consider to be a wrong turn a year or so
> > > > > > > > > > > > > > > > > > > > > > > > > ago. As discussed with To=
m, this series proposes a way to arrange things
> > > > > > > > > > > > > > > > > > > > > > > > > so that it is simpler to =
understand and manage.
> > > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > > - Unwind some of the nest=
ing in bloblist_init()
> > > > > > > > > > > > > > > > > > > > > > > > > - Avoid needing to init t=
he bloblist just to get the FDT
> > > > > > > > > > > > > > > > > > > > > > > > > - Create a deterministic =
OF_BLOBLIST option rather than using guesswork
> > > > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > > We now have a kconfig BLOBL=
IST_PASSAGE_MANDATORY which means
> > > > > > > > > > > > > > > > > > > > > > > > mandatorily use bloblist to=
 hand over everything between boot stages
> > > > > > > > > > > > > > > > > > > > > > > > including fdt, creating OF_=
BLOBLIST is not necessary.
> > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > > Yes, I noticed that, but BLOB=
LIST_PASSAGE_MANDATORY indicates that
> > > > > > > > > > > > > > > > > > > > > > > there must be a bloblist, not=
 that it must contain a devicetree. So I
> > > > > > > > > > > > > > > > > > > > > > > wasn't sure about removing it.
> > > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > > See my comments to your [2/4] p=
atch, if BLOBLIST_PASSAGE_MANDATORY is
> > > > > > > > > > > > > > > > > > > > > > selected, we can override any f=
dt from board or env with the one from
> > > > > > > > > > > > > > > > > > > > > > the bloblist.
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > > Yes, but we should be explicit ab=
out what is going on here. With
> > > > > > > > > > > > > > > > > > > > > OF_BLOBLIST we indicate that the =
devicetree is coming from the
> > > > > > > > > > > > > > > > > > > > > bloblist. It becomes one of the s=
ources for devicetree, like
> > > > > > > > > > > > > > > > > > > > > OF_SEPARATE and OF_EMBED
> > > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > > BLOBLIST_PASSAGE_MANDATORY indicate=
s the fdt from bloblist will be
> > > > > > > > > > > > > > > > > > > > mandatorily used and override other=
 fdt sources like from the board or
> > > > > > > > > > > > > > > > > > > > env variables.
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > So long as you are OK with OF_BLOBLIS=
T as well, I have no objection to
> > > > > > > > > > > > > > > > > > > keeping BLOBLIST_PASSAGE_MANDATORY, a=
lthough I don't like the name
> > > > > > > > > > > > > > > > > > > very much. But I can see why it is ca=
lled that as my standard passage
> > > > > > > > > > > > > > > > > > > series was actually never applied. So=
 I suppose I'll need to have
> > > > > > > > > > > > > > > > > > > another try at that.
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > So to be clear, I want a separate opt=
ion for devicetree, called
> > > > > > > > > > > > > > > > > > > OF_BLOBLIST, which I can enable/disab=
le as needed, without affecting
> > > > > > > > > > > > > > > > > > > your option.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > Sigh. Can I ask what the use case for t=
his will be? And we are going to
> > > > > > > > > > > > > > > > > > get rid of BLOBLIST_FIXED at some point=
, yes?
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > I thought we agreed that this was accepta=
ble. We argued the toss for
> > > > > > > > > > > > > > > > > months on this point and I would rather n=
ot revisit it.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > Yes, I will look at removing BLOBLIST_FIX=
ED once this is in. I'm
> > > > > > > > > > > > > > > > > pretty sure it can be done. The only tric=
ky bit is coming up with a
> > > > > > > > > > > > > > > > > bloblist protocol for x86.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Yes, I'm stuck between being "flexible and =
saying yes" and how long we
> > > > > > > > > > > > > > > > have to live with what I also think are bad=
 designs.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > So maybe the pre-requisite here is that wit=
h "bloblist" and "standard
> > > > > > > > > > > > > > > > passage" being divorced, what is the requir=
ement for bloblist again?
> > > > > > > > > > > > > > > > Because in practice, all of the problems we=
've had come down to looking
> > > > > > > > > > > > > > > > in fixed address locations before they're v=
alid. You want to handle this
> > > > > > > > > > > > > > > > by saying "Ah, we won't look before it's va=
lid with other CONFIG flags"
> > > > > > > > > > > > > > > > and I say we should handle this by not usin=
g a fixed address to start
> > > > > > > > > > > > > > > > with.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > If we have to add OF_BLOBLIST now and delet=
e it in a few months, sigh,
> > > > > > > > > > > > > > > > OK. But it shouldn't need to exist long ter=
m.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > For me, OF_BLOBLIST is needed for x86 devices=
 which don't pass the
> > > > > > > > > > > > > > > devicetree in the bloblist.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > I don't understand why that would become the ca=
se when it's not true
> > > > > > > > > > > > > > today.
> > > > > > > > > > > > >
> > > > > > > > > > > > > If you look at the top obbfdtdec_setup() in your =
tree you can see the
> > > > > > > > > > > > > special-case code related to TPL, that I'm wantin=
g to get rid of.
> > > > > > > > > > > >
> > > > > > > > > > > > OK, but all of that too is for the case of a fixed =
bloblist being in
> > > > > > > > > > > > uninitialized memory. Which is why I don't like BLO=
BLIST_FIXED and want
> > > > > > > > > > > > to see passing of the bloblist from xPL -> PPL be i=
mplemented and so xPL
> > > > > > > > > > > > can allocate a bloblist (or grow a passed one if ne=
eded).
> > > > > > > > > > >
> > > > > > > > > > > We are going around in circles though. Having it is r=
egisters doesn't
> > > > > > > > > > > help with the problem that there isn't an FDT in the =
bloblist.
> > > > > > > > > >
> > > > > > > > > > Sure it does. If we're passed a bloblist in a register =
we can then see
> > > > > > > > > > if it has a DT (and use it) or not (and move to the nex=
t DT location).
> > > > > > > > > >
> > > > > > > > > > > Also, I thought you decided that I could maintain blo=
blist. Have you
> > > > > > > > > > > changed your mind?
> > > > > > > > > >
> > > > > > > > > > You just mis-understood me. Yes, you can maintain blobl=
ist. But also,
> > > > > > > > > > Yes, I need to understand what you're doing. The root o=
f the OF_BLOBLIST
> > > > > > > > > > problems is that no one understood you.
> > > > > > > > >
> > > > > > > > > No, that's not actually true. The problem is that no one =
would listen
> > > > > > > > > and everyone was sure I was wrong.
> > > > > > > >
> > > > > > > > That's another way of saying "no one understood you", IMO.
> > > > > > > >
> > > > > > > > > I sent the series on the basis that you were open to my m=
aintaining
> > > > > > > > > bloblist in your tree. I didn't know there were extra con=
ditions. So
> > > > > > > > > please let me know which way you want to go on this.
> > > > > > > >
> > > > > > > > I thought we had made progress on the community call, but n=
ow you're
> > > > > > > > sending this so I don't know?
> > > > > > > >
> > > > > > > > You need to:
> > > > > > > > - Not break handoff spec. Raymond is telling you how to get=
 a QEMU that
> > > > > > > >   uses that now, and I'm actively waiting on Harrison Mutai=
 to answer
> > > > > > > >   one last question I had before adding vexpress_fvp to our=
 CI. So this
> > > > > > > >   should be a reasonable requirement.
> > > > > > > > - You were going to add register passing of bloblist locati=
on for x86,
> > > > > > > >   and then add register passing of bloblist between U-Boot =
phases
> > > > > > > >   without relying on BLOBLIST_FiXED.
> > > > > > > > - Some amount of un-tangling "do we have a bloblist" from "=
did we get a
> > > > > > > >   bloblist" is needed, so we can just check "Did we get a b=
loblist? Y/N"
> > > > > > > >   in lib/fdtdec.c::fdtdec_setup(). With that, we can add OF=
_BLOBLIST as
> > > > > > > >   a choice with OF_SEPARATE / OF_EMBEDED and we can remove =
a bunch of
> > > > > > > >   the logic at the top of lib/fdtdec.c::fdtdec_setup() too.
> > > > > > >
> > > > > > > That seems very much like a list of instructions. So in fact =
you still
> > > > > > > want to be the maintainer?
> > > > > >
> > > > > > I mean, I'm the project maintainer. No, I'm not going to sit ov=
er your
> > > > > > shoulder and tell you how to do that. But I am telling you what=
 is and
> > > > > > isn't acceptable. I don't just blindly take patches from anyone=
=2E You are
> > > > > > not being singled out here.
> > > > >
> > > > > Heaven forbid. Although I see that you reverted the PXE stuff rat=
her
> > > > > than taking my fix-up patch. That's different from what you did w=
ith
> > > > > all the lmb breakage.
> > > >
> > > > Because you said I should just revert it since I didn't "support" i=
t.
> > > > And didn't look in to booti. So yes, that series needs a re-baking =
to
> > > > also fix booti as it has a similar set of handling things outside t=
he
> > > > bootm state machine, and really re-checking nothing else got missed.
> > >
> > > If you want the series I'm happy to resend it with the fix integrated.
> > > Yes I carefully checked that nothing else got missed. Still, I did
> > > that the first time and still missed something.
> > >
> > > Just let me know.
> >
> > The "booti" code still needs to be fixed too, that was the first of the
> > bug reports.
>=20
> Yes, I suggested plumbing through a setting to ignore SYS_BOOTM_LEN
> and use 4x the compressed size instead. If you are OK with that then I
> can incorporate it.

I'd prefer to take the existing code we have in cmd/booti.c and
migrate that similar to your patch for bootz, so that we don't change
expected behavior and can evaluate any later cleanups by themselves and
not related to fixing regressions.

--=20
Tom

--6OBPI5OIddyMluM+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgBgogACgkQFHw5/5Y0
tyyNUQv7BK1GTAuyvzn2Ec1b5OPq7MAAqsjynEuH+OU5alDwiAvITX8a3EakvS5B
4S0Br6rDDVjpMyTZ1lTDi+8h0wLqRiLx9tg93YpMQiEU0AL3FdF/UzbbwDX/buzh
RppvGMrfNPUeUrNPI45Wl25RXpbKNTOS6q/z3dKm4uYTKF+vl+a2g5+HJqEns+SA
CTYGduEDt/2cJaV9grbL4h2Z1ITlLBVkKlKxNG+Ldk4CxDueii1trVQ/lcYd+yq4
U5kJ0GRa6QKEwS4bKf/K9MY7eD7YPYaOCiohT5HClw32i0tFKtcgaaj0IkG8Cuni
AJuZh8Jon4oq7BKtbePYdqqLsshXFbrcSIqngeJE8D8uk2w++shCOwSUSlLC6YqD
X1/cUTNqn9icFO1PdX4AwdLKTjVFJY/ujiOy4WYeLOXK1W2cxjIwCFxzypUgZQ27
Nl/SLRAquyC+MIH+mKlF7MWBOX6of+UL5HGDbkx1lFZN42Ok5gSnkoWZP0nwRSgC
NHqi7xOu
=H149
-----END PGP SIGNATURE-----

--6OBPI5OIddyMluM+--
