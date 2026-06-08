Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0588BCD8CA4
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 18:41:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 404508407D;
	Mon,  8 Jun 2026 20:41:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UBSqBc9E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE6E98407D; Mon,  8 Jun 2026 16:26:30 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E720807C4
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 16:26:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-4859b1fc7a8so2274927b6e.0
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 07:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780928787; x=1781533587; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=g+jG2zcWdIwbcB5ii/onm6Hv9KarIHRBnb0Cb2iIpzo=;
 b=UBSqBc9ERNg3wwmTqwr2KgL1hpaxT8c2FRYwOV2Wg/QhZFBTYGS6qUvUOtgPKimggA
 oCKqJHb+F4v9EjF/q+lvxFIQa5LCUqhmS0HCyLLfL91v56Ygeo7EClFbA2Bml7ZtJQh3
 JyYkvNGOq6sIqV+bhRBHwYHreHIGNpWyEss8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780928787; x=1781533587;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g+jG2zcWdIwbcB5ii/onm6Hv9KarIHRBnb0Cb2iIpzo=;
 b=h3dI+s1k6+Le+r2MjeIktaTidvNCbBk0wm96d2nQiYxRMSOdlRJ0PAX4v2NKEnTg4R
 svF5RTe7vemf5JKF86WqiSpSxAcqbRWnOyufa0u/W29sIcUaSFwJfgzKq82u8Ge7drfo
 FIzI6EM3my0JIoNe/GMttQxH8jAxRi1U622ChPfVpjwkw7aHuE5xXZX/5rCVKbzJ0Llh
 8mPtXz/BtgGF7tbBod9eKHI/iTRBq4AAaF2P0gdB9QhXueOyVMSo2t+M1XORNcVqaeFi
 joVoZLmYlkA1dojWVLi4FJS1ujdqybkmvcySmYZaRNnN83QYDfcm/mhzxPiA+4BQZtDL
 KOFA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Nmz7lI1GvQ7nNd0g6wf5CJj5NT/sEZrDDhPvyUmKSCGmM2ZVReh0WCsB486CRP4i9ShWbUYs=@lists.denx.de
X-Gm-Message-State: AOJu0YwAxBXMx+/qMOK6O0CrWuvDqSWINIKFrr4fe6dFZ+DXHBH5qYXG
 Ays5wT5W7hKZgAmotBPkJP5hhRXlPLh0CXhvStu/WTniN7x79V7lMpcalgz+GRYKS3E=
X-Gm-Gg: Acq92OH46QZluHkfQBB87NBXVi9bQ61Eb6jPsBkAeidRma+34++vUeQttpv4IYArqj4
 aD6AkX+9uCzDUa/9Ss8iXpKr0sQ8ZphTMVKAqaJhHS1KEWiZ5R3Brs01JsdS2p6gIOpbe3t1+1P
 Bbsk7/fv2hRST2iEAatRIctDoZbOj+sQEIoDdsdYd2raFWXx/6tp3XSGM5HWkmrx/c1CqXy1AlM
 fQOizU4+nJ5FqUNTaFdDVUi065v0rv2S23g21MgUeZ/ETtqfnMQrTiFaDGxUh7oxgbTO7ElhS6I
 ovzSmjC3gCbIvDz22hc4NdERMgTREK1feLC79HVtlaU/kCxBzbrZAb7o0IigzusmCHHHTqXFw0e
 WuiGh9MMUndEjcZr1xkKahxpUUa2hsa25W8mReDB7wobqdAf6x3WiqPrEZPJ5Rv51tUfQfAe/09
 0CGySqWuPz1J2l0AsaOnbJT5kouM9VtrNH/gF7Bt3LCZWL3DDg6YTbNu5QGh5s5zy8N8OELW8c6
 ufVQEPZCZl4t+vC2MCR6mw8KINgKpnd6JY99lsbBtHQtYWyydVDDxvjKat/Iw==
X-Received: by 2002:a05:6808:2384:b0:486:447d:da88 with SMTP id
 5614622812f47-4868e0e34d4mr8760262b6e.36.1780928786865; 
 Mon, 08 Jun 2026 07:26:26 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4865b7ad946sm13485221b6e.8.2026.06.08.07.26.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 07:26:26 -0700 (PDT)
Date: Mon, 8 Jun 2026 08:26:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Casey Connolly <casey.connolly@linaro.org>, Sam Day <me@samcday.com>,
 u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Bryan Brattlof <bb@ti.com>, Yannic Moog <y.moog@phytec.de>,
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Denis Mukhin <dmukhin@ford.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Javier Tia <floss@jetm.me>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Peng Fan <peng.fan@nxp.com>, Anshul Dalal <anshuld@ti.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tingting Meng <tingting.meng@altera.com>, Alice Guo <alice.guo@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Minkyu Kang <mk7.kang@samsung.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Henrik Grimler <henrik@grimler.se>
Subject: Re: [PATCH 00/13] Generate Android boot images with binman
Message-ID: <20260608142622.GK382693@bill-the-cat>
References: <20260606-android-binman-v1-0-c7a3c14b8a3d@samcday.com>
 <e21e557b-1573-472f-9666-2bffdb0f4e86@linaro.org>
 <tIT4bs5x6xJ7santHOgWRakaoZ-AJjcaxOX4BW8jop3rcmOLVy8kooUuTmH1QJViVTgyHjeSiP9TvRiH_zcwYTMB63CogsgYT61ORUBllYA=@samcday.com>
 <bd859b0f-45df-45e5-abb2-99076d503a59@linaro.org>
 <CAFLszTj0HfKTH3GJiSzw7L=7Gq5Qk9VJd5UBUna2_p_iw3eK9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="G/jSVOdb9RpM/8YO"
Content-Disposition: inline
In-Reply-To: <CAFLszTj0HfKTH3GJiSzw7L=7Gq5Qk9VJd5UBUna2_p_iw3eK9Q@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Mon, 08 Jun 2026 20:41:42 +0200
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


--G/jSVOdb9RpM/8YO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 08, 2026 at 07:00:23AM -0600, Simon Glass wrote:
> Hi Casey,
>=20
> On Sun, 7 Jun 2026 at 08:48, Casey Connolly <casey.connolly@linaro.org> w=
rote:
> >
> > Hi Sam,
> >
> > On 6/7/26 01:05, Sam Day wrote:
> > > Salutations Casey,
> > >
> > > On Saturday, 6 June 2026 at 10:03 PM, Casey Connolly <casey.connolly@=
linaro.org> wrote:
> > >
> > >> Hi Sam,
> > >>
> > >> On 6/6/26 02:52, Sam Day via B4 Relay wrote:
> > >>> U-Boot is seeing increasing adoption on pocket computers, many of w=
hich
> > >>> (sadly) have fused bootloader chains. Many of these bootloaders hav=
e a
> > >>> very rigid definition of what a "valid" downstream payload looks li=
ke.
> > >>> Sometimes it's just a boring old v0/v2 Android boot image. Sometimes
> > >>> it's something decidedly more grotesque.
> > >>>
> > >>> To date, this last-mile packaging step has been trapped in downstre=
am CI
> > >>> pipelines, blogposts, documentation, etc. This patch series aims to
> > >>> gather up all that esoterica and institutional knowledge and codify=
 it
> > >>> in U-Boot's build system, using binman.
> > >>
> > >> Awesome!!! :D
> > >>
> > >> So happy to see this being worked on, it's a huge benefit to have th=
is
> > >> here in the build system.
> > >>
> > >> That said, I think we need a bit of discussion around binman, I
> > >> previously worked on using it for teaching the build system to emit =
=2Embn
> > >> files (see [1]), in the end getting binman to co-operate was a bunch=
 of
> > >> really annoying work and I wound up with a sub-par result.
> > >
> > > Yes, I saw that series. I tried to engage you on Matrix about it a fe=
w days ago
> > > to get a sense for why you felt that binman was unsalvageable. I shou=
ld have
> > > engaged you properly here on the list, that's my bad.
> > >
> > >>
> > >> The new approach which made a whole lot more sense is to use a vendor
> > >> Makefile fragment to add a custom build target, skip dealing with bi=
nman
> > >> and just have the necessary info in Python (since adding a table ent=
ry
> > >> to a Python script is really no different to adding a binman DTB nod=
e).
> > >> That's in [2].
> > >
> > > I would prefer to use binman. It's already well documented. It's alre=
ady in
> > > use by countless other boards in U-Boot. I prefer maintaining DTSI's =
for the
> > > configuration DSL than some Python dicts. Also, at some point once en=
ough
> > > devices have their native Android boot artifact described, there will=
 be
> > > clear patterns that can be neatly tucked away into shared DTSI fragme=
nts.
> >
> >  From my side, binman is a no-go for a bunch of reasons, polluting the
> > device dtb being a big one, the ability to debug and maintain it is also
> > not something i feel particularly confident about. Hence having a
> > standalone tool would be the appropriate way to go for this, I really
> > want to avoid having to learn this bespoke overly complex build tooling
> > when it's selling points aren't things that have much value for Qualcom=
m.
>=20
> Binman is the usual U-Boot way to build images. We should not be
> inventing new, custom ways of doing things, least of all more scripts.
> We should should be describing the image, not coding it.
>=20
> >
> > >
> > >>
> > >> I'm really not in favour of adding a binman node to the DTB that U-B=
oot
> > >> uses, and I think it's kinda dumb that this is the only sensible way=
 to
> > >> configure binman today...
> > >
> > > I see nothing wrong with that. Can you expand on your concerns a litt=
le more?
> >
> > It really just goes against the goal of using upstream DT. Previously I
> > managed to get binman to parse its config from a separate DTB but that
> > was hellish to integrate the tooling for.
> >
> > Having this random node at runtime for completely unnecessary arbitrary
> > reasons feels just wrong to me.
>=20
> On some boards (e.g. x86) it is used at runtime to locate things. In
> any case it provides a clear indication of what is where, in data
> rather than code. We don't need to make it use a separate DT, so far
> as I can tell.
>=20
> >
> > >
> > >>
> > >> The way that mkmbn works is it just has all the device-specific conf=
ig
> > >> in a dictionary where the key is the compatible string, it finds the=
 DTB
> > >> in the U-Boot image and gets the appropriate mbn config from there.
> > >>
> > >> I see you've clearly put a lot of effort into this, and I hate to ask
> > >> you to do a lot more, but I'd really like to avoid using binman, wou=
ld
> > >> you be willing to rework this to put the config in Python and just h=
ave
> > >> a custom make target like in the mkmbn patches? You can probably bas=
e it
> > >> on top.
> > >
> > > I'm definitely not interested in doing that. I would, however, be ver=
y willing
> > > to address any specific concerns you have with binman.
> >
> > That's a shame to hear>
> > > At any rate, if you want to NAK any binman usage in the qualcomm side=
, that's
> > > fair enough. Please let me know if you see absolutely no path forward=
, and I'll
> > > split the series to just focus on the binman etype impls and their us=
age on
> > > the Exynos side. That would be a bummer, but I'm intending to maintai=
n a
> > > long-lived close-to-mainline downstream anyway, so I would continue w=
idening
> > > the support there and hope that your opinion on binman changes in fut=
ure :D
> >
> > I don't feel comfortable depending on binman for Qualcomm, so we'll
> > leave it there.
>=20
> I'd like to figure this out, particularly as Qualcomm is ramping up
> its U-Boot efforts.

I believe the problems with binman and Qualcomm platforms have been well
enough documented and discussed in the thread where Casey attempted to
make it all work with binman and found how ill-suited it seemed to be,
unfortunately.

--=20
Tom

--G/jSVOdb9RpM/8YO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaibRDgAKCRAr4qD1Cr/k
ChOgAQDUE61lTKqD9dThnAoeL2QskVbR2+qxMSYUJw4M1gSgjAEAnVRygqmn3oue
BEe6uosoYQPNSshhsSTyTpma7VAIdQc=
=giAI
-----END PGP SIGNATURE-----

--G/jSVOdb9RpM/8YO--
