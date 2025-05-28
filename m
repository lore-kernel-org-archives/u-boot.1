Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3593FC3ABB2
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 17:45:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 631AA82FAB;
	Wed, 28 May 2025 19:45:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GK6O4uFm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55F4283A91; Wed, 28 May 2025 19:05:42 +0200 (CEST)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E97D983A5B
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 19:05:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-6062e41916dso20178eaf.1
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 10:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748451938; x=1749056738; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=t/yAv5kPWMuG89DIVHklSZkFE6BdGUjYUE7Um0QfmUI=;
 b=GK6O4uFmaLAAXI6bczJEwE10JmUDoqBbob/3Pw74IYfGp2bZS03pyb8t5FbKSAd1ba
 GcTmGIqGgNtgJms+RvlJ3M8cbaYeyeQpszWHQ9w2TsiA3vOHUi5bOqFNEIu5DtoD4GjE
 Wsb5GrthDsn6wsc2g5XanUAMeguVmU8abcmto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748451938; x=1749056738;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t/yAv5kPWMuG89DIVHklSZkFE6BdGUjYUE7Um0QfmUI=;
 b=kE4ia88tCFg3AH9Lz+t7xn9gsGCI7Epv+uhMrO3sdZ5o0Eab7/EvYbQtwnxHGl5FyB
 LxH3qJBxD6fs6UP37GiXR9IZQ1Xq7mnBPtx6prdVDEw2FarRTkBUDtXRTpptHnitNV2W
 6OIzCfOFJBNIuYwVoEg2li29nywuBZNO+oHg2Nvpfhggf35bir41xEO9kyi3rMD+q3Lk
 EaXUrFfLFaDia5eF9orLZS1Y/cTeQkvYOt5Out3gPcHJ1XT9TgXB1MdFksEt9pSR/6GI
 XiA4fKs1xZAsNgIoUkry2wB+H+wTR/FWAJiu6AvXmylK2dW5esFTS1kGM0DymGzXT+VK
 K2Gg==
X-Gm-Message-State: AOJu0YxGoEH+OY3pJPXWle/spGlD5ibJgWIZPLGmGREbEbkf16zV6CV6
 dXHkwvHisQq/cCscIXrwoU1X3aH9yDu7gGBhB754ChjE9BI1+VW4sa6R07BCHtcgk0s=
X-Gm-Gg: ASbGncvlV1XQZrXZ1cgMM+pf9/7gcv7o3jdvUtO/kdKdhAXH2rSH1VhiQF8Qo4fwL3W
 D6tdJ6kW85zabngY/ycN8VAjbe3/iwCM+3PI/7F3B94JFWsH8zrcSN7GWuGBc1oAnitGIuX+YTn
 mCC6a1+dUMoJJfeoIhgm/ArlCOXXLy4cGz2QzbjdU3b226+7LJv//oVNpjRn2NvIUp3CtxZsbvh
 VWvEM68jX+TUYWKL0xnY9RRwpZRhCGMGjGWxjeij2oLwjA7yPXH1VfIEDmFjUmnm1myDSlzTjmO
 bSWPkv90e/Ag3zeDg8BZFpq9R90E4bb+qvHKyMMH8DmbhcISTaEEtSV7RreAvhtiPh5NT/zGMLD
 hZk+iIPLAivKK
X-Google-Smtp-Source: AGHT+IEscc4t72F00UPULHXQsCH/1TqK2kzc60h7uB3JBTi2x2GwBnsdOiviB3vkuVn+0xG6jW/WgQ==
X-Received: by 2002:a05:6870:d294:b0:2d4:c19a:94e5 with SMTP id
 586e51a60fabf-2e862106460mr7296301fac.39.1748451938084; 
 Wed, 28 May 2025 10:05:38 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2e8e1a3782fsm312213fac.38.2025.05.28.10.05.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 10:05:37 -0700 (PDT)
Date: Wed, 28 May 2025 11:05:33 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 =?iso-8859-1?Q?Fran=E7ois?= Ozog <francois.ozog@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bill Mills <bill.mills@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Phelps <andrew.phelps@canonical.com>,
 Alexander Graf <agraf@csgraf.de>,
 Boyan Karatotev <boyan.karatotev@arm.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Fabio Estevam <festevam@gmail.com>,
 Harrison Mutai <harrison.mutai@arm.com>, Jonas Karlman <jonas@kwiboo.se>,
 Liviu Dudau <liviu.dudau@foss.arm.com>, Liya Huang <1425075683@qq.com>,
 Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
 Marek =?iso-8859-1?Q?Moj=EDk?= <marek.mojik@nic.cz>,
 Marek Vasut <marex@denx.de>, Matthias Brugger <mbrugger@suse.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Sean Anderson <seanga2@gmail.com>, Stefan Roese <sr@denx.de>,
 Stefano Babic <sbabic@nabladev.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>,
 Xu Zhang <423756212@qq.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 00/25] passage: Define a standard for firmware data flow
Message-ID: <20250528170533.GE100073@bill-the-cat>
References: <20250528123236.1138632-1-sjg@chromium.org>
 <20250528142521.GW100073@bill-the-cat>
 <CAFLszTiHxdkoGbdOg8rzmn9kUmt925LZvZNxSXQC5Y4A=s2Vig@mail.gmail.com>
 <20250528151927.GB100073@bill-the-cat>
 <CAFLszTh3WDhn_ZSRsBMTpD8i5AyNLFGiV0cbPhOfCUAud1_WOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Xp7Z45B7ao1e4WIh"
Content-Disposition: inline
In-Reply-To: <CAFLszTh3WDhn_ZSRsBMTpD8i5AyNLFGiV0cbPhOfCUAud1_WOg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Wed, 28 May 2025 19:45:48 +0200
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


--Xp7Z45B7ao1e4WIh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 05:08:38PM +0100, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 28 May 2025 at 16:19, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, May 28, 2025 at 03:32:12PM +0100, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Wed, 28 May 2025 at 15:25, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Wed, May 28, 2025 at 06:32:02AM -0600, Simon Glass wrote:
> > > > >
> > > > > This series adds a standard way of passing information between di=
fferent
> > > > > firmware phases. This already exists in U-Boot at a very basic le=
vel, in
> > > > > the form of a bloblist containing an spl_handoff structure, but t=
he intent
> > > > > here is to define something useful across projects.
> > > > >
> > > > > The need for this is growing as firmware fragments into multiple =
binaries
> > > > > each with its own purpose. Without any run-time connection, we mu=
st rely
> > > > > on build-time settings which are brittle and painful to keep in s=
ync.
> > > > >
> > > > > This feature is named 'standard passage' since the name is more u=
nique
> > > > > than many others that could be chosen, it is a passage in the sen=
se that
> > > > > information is flowing from one place to another and it is standa=
rd,
> > > > > because that is what we want to create.
> > > > >
> > > > > The implementation is mostly a pointer to a bloblist in a registe=
r, with
> > > > > an extra register to point to a devicetree, for more complex data=
=2E This
> > > > > should cover all cases (small memory footprint as well as complex=
 data
> > > > > flow) and be easy enough to implement on all architectures.
> > > > >
> > > > > The emphasis is on enabling open communcation between binaries, n=
ot
> > > > > enabling passage of secret, undocumented data, although this is p=
ossible
> > > > > in a private environment.
> > > > >
> > > > > To try this out:
> > > > >
> > > > > $ ./scripts/build-qemu -a arm -rsx
> > > > >
> > > > > This will build and run QEMU for arm64 and you should see the sta=
nddard
> > > > > passage working:
> > > > >
> > > > >    Core:  49 devices, 13 uclasses, devicetree: passage
> > > > >
> > > > > This series is available at u-boot-dm/pass-working
> > > > >
> > > > > Changes in v5:
> > > > > - Add RFC for test script
> > > >
> > > > And this is why I question if you are working in good faith. I've
> > > > rejected this countless times. I'm still rejecting it. Stop includi=
ng
> > > > it. Point at the version you could easily be maintaining in the con=
trib
> > > > repository where you have write access and no one will be telling y=
ou to
> > > > not do something. People would even review the patches since it wou=
ld be
> > > > against mainline.
> > >
> > > I fully understand that you don't want the script and I'm only
> > > including (as an RFC) so people can actually try this series out. I
> > > didn't want to point to my tree as I thought that would annoy you. I
> > > already went through why the contrib tree is not suitable for me.
> >
> > So I have to take changes that I disagree with, but you can't work with
> > a tree for your tooling where the community would be happy to provide
> > feedback? That does not sound like compromise. Again, I have trouble
> > believing that you are working in good faith to resolve the differences
> > here.
>=20
> Yes, as mentioned before I would like you to take changes you disagree
> with, at least once we have discussed alternatives and I'm sure that's
> the way I want to go. It would save a lot of grief if you could do
> that.
>=20
> I could use your contrib/ repo but there isn't a lot of point, since I
> have to have my own tree anyway, due to rejected / changes-requested
> patches. It's just lots of fiddling around for no gain. I'm fine with
> your not having the scripts in your tree and I'm fine with maintaining
> the Python tools in my tree. Basically it seems my tree is the dumping
> ground for the stuff you don't want in 'pure U-Boot', or don't want
> yet. If you would like me to sync my scripts to the contrib/ tree
> every now and then, yes I can do that. I don't see much point since we
> can't reference them in docs or test them in CI, but I'm willing to do
> it.
>=20
> But I do want to post patches so I can get feedback from people who
> are interested. Perhaps we could set up an 'experimental' mailing list
> for that, since you seem really unhappy when I send them to the U-Boot
> mailing list?
>=20
> Re your 'good faith' thing, I'm really just trying to make progress
> and I wish there was less 'email overhead' and more action. If you
> have concerns, it would be better to discuss a resolution f2f or on a
> VC, not endless email threads which don't relate to the patches I'm
> sending. The series we are discussing here was sent in 2021 based on
> bloblist from 2018! [1]. It is why Firmware Handoff happened. Give me
> some credit for foresight, at least.

You need to decide if it's more important to work with the community or
have your way every time. You cannot have both. You need to accept that
some things you think are good ideas have been rejected or you need to
fork off from U-Boot. Or you can ask the community to take over as the
project head. If the community wants you to run things, I will step
down and just be an individual contributor again. Five months of this
experiment shows me that it's not working at all and will only be a
bigger problem as time goes on.

--=20
Tom

--Xp7Z45B7ao1e4WIh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmg3Ql0ACgkQFHw5/5Y0
tyyVDwv+LlUHM6bp8YMtrImHtYTBJRv1I9sZ8I+MItxNvHa/Uawx7eA7IOUQ5iNf
0Pjn3Wz4Al83EfMC3Ez1eSUt6tQKwsgJ4NsGXdDURx6FqLBC/XUK3kLVbeEXYUu1
++bXeAZ5/CtgiWHTg3WH8FlVNNqMwBmYG82Lef9w03QCO7F8qr3wK1M+rISrZKfK
ppAXbJx56lNfxHfNp6Dr0mDCAb+9gnacBQ+nv4XDNT9V0rPYNIuxREDknxpXBKor
w2vXSt2okINwoNcYn7m/rzexStz1ClCmiodIpJS6C1ciBe8LRXfqELTLFuP0ejh5
JxOgdm6PsWT+VxWnAR+FI1SkU/m2/KSSzxRsboFYzAZqvlHrHzmccnDfXe+WOwTo
BJPGdlSPeuDtAS1oJHHSloh9zF43ySc4HfaKzko4aV7mQamzHaA7Ti8xTmHN3hmt
usU+yEfmE9S/z53mDhEx5SBL0AdA1SQSV34Qahj/HoKn37WC65RllkcxplCLuOIi
nX24LAzf
=nStp
-----END PGP SIGNATURE-----

--Xp7Z45B7ao1e4WIh--
