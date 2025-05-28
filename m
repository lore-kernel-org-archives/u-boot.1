Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68FE1C5AD49
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 16:54:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2309483AAC;
	Wed, 28 May 2025 18:54:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Wu954UTj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AF93832F9; Wed, 28 May 2025 17:19:35 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4559A8329C
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 17:19:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-2d0920ce388so2079260fac.0
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 08:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748445572; x=1749050372; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qA9Udb9eBCGzXFBNz6INRTeAqdTkugi7lKHtWO4Oe4Q=;
 b=Wu954UTjogty5QQMiik2x/fus6stlpjW+vNKa3L3VL0byr1w5Op2UHyx0rBolmi4Cu
 qm2ng12gwPbw58GDIsc18qKGQ2rimlMj1TYZXBF2psNYAKyX4/opub61DsN6mtD1lfEB
 X0n+ATm+1uwrLsKIOlAP0JQNDRG/BWvj6QMlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748445572; x=1749050372;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qA9Udb9eBCGzXFBNz6INRTeAqdTkugi7lKHtWO4Oe4Q=;
 b=JL9fsdxv5+2AsRh4P43nqaX5TpMGPrOml5T8RcjAZa1NqAuDHNVckYhHlfWTAwsMXB
 Jk9CxhjGR1XSxgTogI6+iyzFqVYEjaS/7jtx2PbQyg7On3NtdTJFzEf1JUnrP33gnPWl
 LrrYSPwZr3FvyWG8/997ZfDrVC+l0zx4LvNGUnQC9LM86plEfm7Ojq8MrXe8daxpvZtK
 jXZagM1/q7SMvuNviq2ue9f26FkYC1/q/C16PAV8FgEv07IQGWNT6vT91NPixBpYzc+z
 V2YEtarRC0TBR2tpzjMof0HKqBjs17vk7d4021uUPMl8KExsrIMAh5byjVi/KDy7TUXO
 gqQQ==
X-Gm-Message-State: AOJu0YwUwX/SqywoxGxqEqMKYkbf7pVEcbJ+hjSpVqy9eiFE2yd2tbQS
 hOEMCLy5MAOy7pmcPvcxl1uXOLZb424LVoL4evXe6LIng/0s/dvG/6YGMAwm20VoJUBnQ2xWdgT
 coe2tSIY=
X-Gm-Gg: ASbGncuhZeLImoaWv105/oNdFCAfwf+cVYhIz39N5Dvin3XjZ1rrzSSChtNLdpwa1BF
 n/XxCg17MOhG7fB3GWphAB2CgEKn+Zv5z6GbZAEo9aWOlOE0hdcMLXJ2VE6jPT+yEX6x0rYFyI4
 f9hO6kJ/PkSB/p80zCfjNzqW67QU1TfTVaBHsoqTaLvDDt4RxVxRpRrqRX8gqi6szZOqHENl9Mv
 uu+iiNhJurmoe3qknXWcdDgz1R78Z9I9ZXpZbLdAuolf8zYnklrHY2XqMxd+Uq55l0t5RlGytMp
 fEPr0j5Diq7pEx4Tn/iJeC1KEcCoriAPzZHNC19yVZFBz3Loo7n7A7A0wETvsWBHTZir8EKH9At
 LtdHtgxQbthty
X-Google-Smtp-Source: AGHT+IHt1y6uP140FCGPwCd1umQRJ7YqsoFH9gV1I+QHkB7k6n+FRsNvH7As5n07PcZGswyJHhXqmA==
X-Received: by 2002:a05:6870:4008:b0:2e8:f5d4:6077 with SMTP id
 586e51a60fabf-2e8f5d46ec1mr434331fac.38.1748445571801; 
 Wed, 28 May 2025 08:19:31 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2e8e176b4f7sm263557fac.27.2025.05.28.08.19.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 08:19:30 -0700 (PDT)
Date: Wed, 28 May 2025 09:19:27 -0600
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
Message-ID: <20250528151927.GB100073@bill-the-cat>
References: <20250528123236.1138632-1-sjg@chromium.org>
 <20250528142521.GW100073@bill-the-cat>
 <CAFLszTiHxdkoGbdOg8rzmn9kUmt925LZvZNxSXQC5Y4A=s2Vig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FQ8O+vMEqOogGsJJ"
Content-Disposition: inline
In-Reply-To: <CAFLszTiHxdkoGbdOg8rzmn9kUmt925LZvZNxSXQC5Y4A=s2Vig@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Wed, 28 May 2025 18:54:00 +0200
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


--FQ8O+vMEqOogGsJJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 03:32:12PM +0100, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 28 May 2025 at 15:25, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, May 28, 2025 at 06:32:02AM -0600, Simon Glass wrote:
> > >
> > > This series adds a standard way of passing information between differ=
ent
> > > firmware phases. This already exists in U-Boot at a very basic level,=
 in
> > > the form of a bloblist containing an spl_handoff structure, but the i=
ntent
> > > here is to define something useful across projects.
> > >
> > > The need for this is growing as firmware fragments into multiple bina=
ries
> > > each with its own purpose. Without any run-time connection, we must r=
ely
> > > on build-time settings which are brittle and painful to keep in sync.
> > >
> > > This feature is named 'standard passage' since the name is more unique
> > > than many others that could be chosen, it is a passage in the sense t=
hat
> > > information is flowing from one place to another and it is standard,
> > > because that is what we want to create.
> > >
> > > The implementation is mostly a pointer to a bloblist in a register, w=
ith
> > > an extra register to point to a devicetree, for more complex data. Th=
is
> > > should cover all cases (small memory footprint as well as complex data
> > > flow) and be easy enough to implement on all architectures.
> > >
> > > The emphasis is on enabling open communcation between binaries, not
> > > enabling passage of secret, undocumented data, although this is possi=
ble
> > > in a private environment.
> > >
> > > To try this out:
> > >
> > > $ ./scripts/build-qemu -a arm -rsx
> > >
> > > This will build and run QEMU for arm64 and you should see the standda=
rd
> > > passage working:
> > >
> > >    Core:  49 devices, 13 uclasses, devicetree: passage
> > >
> > > This series is available at u-boot-dm/pass-working
> > >
> > > Changes in v5:
> > > - Add RFC for test script
> >
> > And this is why I question if you are working in good faith. I've
> > rejected this countless times. I'm still rejecting it. Stop including
> > it. Point at the version you could easily be maintaining in the contrib
> > repository where you have write access and no one will be telling you to
> > not do something. People would even review the patches since it would be
> > against mainline.
>=20
> I fully understand that you don't want the script and I'm only
> including (as an RFC) so people can actually try this series out. I
> didn't want to point to my tree as I thought that would annoy you. I
> already went through why the contrib tree is not suitable for me.

So I have to take changes that I disagree with, but you can't work with
a tree for your tooling where the community would be happy to provide
feedback? That does not sound like compromise. Again, I have trouble
believing that you are working in good faith to resolve the differences
here.

--=20
Tom

--FQ8O+vMEqOogGsJJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmg3KX8ACgkQFHw5/5Y0
tywxHAwAlA/ak9ngBDCz8F+HvYRXP/qq+ol4YYHDMH/7rPTc1zwhnFXtZcx5aJi6
3v9wP4+ihX/zE9rIvmY7rX/1hPKTE1M5U9A1vCaJpnJHs5ciR53nJgDXjYfgu48m
cFSpMl567NyfzC7auYDGR6k1sRULszDAXB7LGc5WBlSrSIofcqZv5dUWLMVe4jp/
eMVwpIwSBRt80Ik63SXhO2byeXGVz9gnRZm35/uHIBIMxZMVLbhA2Zl50hzsJ6Ld
uQuRuP/JwaO8Et96S4cmiVTJ9t7KlY0RBJzgKAwW28DNXPl7/1ujwYCOuqrxZcNb
5m8siF0PlOf3UErAxTMpAkWsZLJLgLV981lwEC0FEcxpsh9fWR81LBysJ32f76hW
X5lEi/d1XyhJoejf194E4lUG27wVeyAGXkCLsoxmGamCaCM8awkNdF0RykM50CMQ
Elt1JVUbUvtkIeuwJi37ktrtMMKwNd/oRMMqZbVXhN4nuk0ejPg1UMSWKYa1wwcK
obyFFlaL
=X2ej
-----END PGP SIGNATURE-----

--FQ8O+vMEqOogGsJJ--
