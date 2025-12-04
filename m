Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6367DD20694
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 13:40:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 700C183A94;
	Thu,  4 Dec 2025 14:40:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="U8QYkvha";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32AF383A9F; Thu,  4 Dec 2025 14:40:54 +0100 (CET)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E84C583A84
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 14:40:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-3ec5df386acso666607fac.1
 for <u-boot@lists.denx.de>; Thu, 04 Dec 2025 05:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764855645; x=1765460445; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=f4cDoF3B1tt6xQYZhXd4h7JptJIf85pCqOoBgs+2I6Y=;
 b=U8QYkvhaE327xBa+oxnQSjZy3qbq2C/ZAPf8o/EO8LFP8PRQF6h1ue6cU2CVg74dNB
 H8deirHsihpkcr/09SGrsPWlTNz9imkM0y9JMze8NaEYnL/9b0oh40tFIv57K6TRhY2g
 F6HRi+M56dwoRRm20iymhOoBZvrdv8i2YChI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764855645; x=1765460445;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f4cDoF3B1tt6xQYZhXd4h7JptJIf85pCqOoBgs+2I6Y=;
 b=gybMvHIdjO04nNM5SbhV8K+zFcuSCLJiiYl/d+Ri6qUP5p1w+lJVpXeMyI2SovHJSf
 8GtCUgHJEZbX683fHrTO5F7tFO6hWEpBUZ4DiX2U0VlyJbuFCZ8+mW47T8IPK3ee1Qz/
 127b0D+MtQAIR5lFlsglzCrqEaQ8/u64WjpdZ6du/uWAAPoByB+V2PBEC23FL7shvN3G
 /I17wJRdo7YNIJT/udm7yD3UV4tOpCxvQRFNy3iGHSrQxW+pW5NGGRmtu5qx2bGU9cS6
 JNVUo5CGFDiYxbDzQE5mIRIlovVuKhDqcNrjQBZD2KnD7geHR5mmxa6G0ycZHp3Xi+Ip
 7F8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuyms3aV27Jh9+/IaXcNglJZz8sB3rpRyVILcMXUjNjfCXTzynEZTbXYkiww2G3Caiz5PNyLs=@lists.denx.de
X-Gm-Message-State: AOJu0YzJe1ivv5TwUBzVjlDkfkELfaj3if4IUVOa/EoQcqEIcN6txl4t
 MI2FPdJKFhoRYG6yLqGjd8MNC9ehw9yaKIQvBwZYOHKy4IZqtXjfq4AM2F9yxwPgeBY=
X-Gm-Gg: ASbGnctTlZ4l68VB8xy1T9FX1Sf36+9kKGybLUbCYiNGo7bydD1DAHgdbbB7UAIU3vW
 3Zmvn0/YXu+wfpbi5sWYa0a299OWhviFGJ6dhcLOzfc/Uvv4lPQSkgaE/jnDH1UXKQCGkO2lgSq
 57DWfBA+w4HJBJmqSiTAJtNw/MaHBr3KWdim3bt7uhRewALJuKW9v4OrHN2H9Si+elj79u7cq6K
 F8+bZTP0Ww+z5tZ2SGzsslOOU68FMWLAuOWVTFnOKpzS7JLdMh8PysamKcAf6V1gQJeVXOgIgh2
 d64r9gZmJkLRVVWl4dbU0s9tHR3g+QfNwPUzctBMZQzTTXqB3Y81zhG7M7HCfze9h0hiQBPSivu
 Big/KupAoHdOuExwJmLK7QKQFVSC0uPCaxA+REBX3GQBwQR0uSDExMQ/YXMk6HdUf2WjmQkRr2W
 aXoKGwbYmHw6VdXJipLW3ZviZVgm24yAH1wkTQhb0j2yHSIgWe/w==
X-Google-Smtp-Source: AGHT+IFYrIWWnRMDxocyRDdJhkRvbZ3L/E87RA7ftdqwiodMV9i5fXJrRDd1GuVBMnTJlJ256wzKYw==
X-Received: by 2002:a05:6870:8886:b0:3e8:8e57:a7a4 with SMTP id
 586e51a60fabf-3f5067e6219mr1483134fac.55.1764855645490; 
 Thu, 04 Dec 2025 05:40:45 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f50a727d7csm1296464fac.0.2025.12.04.05.40.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 05:40:44 -0800 (PST)
Date: Thu, 4 Dec 2025 07:40:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Kory Maincent <kory.maincent@bootlin.com>, Patryk <pbiel7@gmail.com>,
 u-boot@lists.denx.de, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Greg Malysa <malysagreg@gmail.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Duje =?utf-8?Q?Mihanovi=C4=87?= <duje@dujemihanovic.xyz>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Sumit Garg <sumit.garg@kernel.org>, Heiko Schocher <hs@nabladev.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 E Shattow <e@freeshell.de>, Raymond Mao <raymondmaoca@gmail.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Shiji Yang <yangshiji66@outlook.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Yao Zi <ziyao@disroot.org>,
 Leonard Anderweit <l.anderweit@phytec.de>
Subject: Re: [PATCH 0/6] Add support for fwumdata
Message-ID: <20251204134040.GU303283@bill-the-cat>
References: <20251202-feature_fwumdata-v1-0-d55154de4103@bootlin.com>
 <20251203110108.1d93975d@kmaincent-XPS-13-7390>
 <CAC_iWjJ0PFXABOkwPSSdjRuFSPUF79fVCWNRvU5s1PLCuV5ydQ@mail.gmail.com>
 <CA+DkFDbecwtJkX-7wHzQjhVbi-tpjzZVzc7N3kvhr5OtKivgWA@mail.gmail.com>
 <20251203155924.3dd3c5a0@kmaincent-XPS-13-7390>
 <20251203151048.GP303283@bill-the-cat>
 <CAC_iWjLbB=2FqXr5H5UdBNxyiEANUAJOdVO8Jh0BMVVbjQvocQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="aOJUccF1hEuTv7X6"
Content-Disposition: inline
In-Reply-To: <CAC_iWjLbB=2FqXr5H5UdBNxyiEANUAJOdVO8Jh0BMVVbjQvocQ@mail.gmail.com>
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


--aOJUccF1hEuTv7X6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 04, 2025 at 01:55:36PM +0200, Ilias Apalodimas wrote:
> On Wed, 3 Dec 2025 at 17:10, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Dec 03, 2025 at 03:59:24PM +0100, Kory Maincent wrote:
> > > On Wed, 3 Dec 2025 15:04:10 +0100
> > > Patryk <pbiel7@gmail.com> wrote:
> > >
> > > > Hi Ilias,
> > > >
> > > > > > > Add a new fwumdata tool to allows users to read, display, and=
 modify FWU
> > > > > > > (Firmware Update) metadata from Linux userspace. It provides
> > > > > > > functionality similar to fw_printenv/fw_setenv but for FWU me=
tadata.
> > > > > > > Users can view metadata, change active/previous bank indices,=
 modify
> > > > > > > bank states, and set image acceptance flags. Configuration is=
 done via
> > > > > > > fwumdata.config file.
> > > > > > >
> > > > > > > Made a few change to mkfwumdata tool along the way.
> > > > > >
> > > > > > Still wondering about the choice of putting this fwumdata tool =
in U-Boot
> > > > > > instead of TF-A. TF-A is the boot part that manages the update =
process and
> > > > > > rollback through the FWU metadata,
> > > > > > therefore, this is where it should belong.
> > > > > > Why, in the first place, mkfwumdata was accepted into U-boot in=
stead of
> > > > > > TF-A?
> > > > >
> > > > > The actual update happens via capsule updates only, which runs in
> > > > > BL33. TF-A needs to be aware in case it's involved in the boot pr=
ocess
> > > > > and fails to boot. In that case BL2 is responsible for booting vi=
a the
> > > > > other bank.
> > > > > But generally speaking it's U-Boot that processes and usually upd=
ates that
> > > > > file
> > > >
> > > > If I may add something - actually for me this is not that obvious,
> > > > e.g. on our platform we update the metadata directly from Linux, not
> > > > from the u-boot capsule. As far as I'm aware, the ST, in their
> > > > OpenstLinux does the same. I'm also not sure why it would be the bad
> > > > idea to do this from Linux. Ofc the BL2 handles bank selection as w=
ell
> > > > as rollback in case of boot failure on a newly selected bank.
> > >
> > > I agreed with Patryk. U-boot is only an update agent (as explained by=
 the
> > > standard) of FWU metadata as Barebox or Linux could be. FWU metadata =
is an ARM
> > > standard which is related to the update of the images that boot after=
 the ARM
> > > firmware. It is not related to any project. As TF-A is the mainstream=
 project
> > > for ARM firmware having mkfwumdata and fwumdata in it seems more suit=
able.
> > > I am not familiar with these EFI capsule update, does it not rely on =
TF-A to
> > > select the boot image according to the FWU metadata state?
> > >
> > > Anyway, now it is too late and mkfwumdata has already landed in U-boo=
t for 2
> > > years. Not sure what we should do here. Put all in U-boot and let the=
 other
> > > projects (barebox) copy the code if they need it? Or move all to TF-A=
 while
> > > keeping a deprecated copy of mkfwumdata in U-boot to not break things?
> >
> > Perhaps in the medium term we can split that tooling out from the main
> > project source tree itself, to make it easier for OSes to use this tool
> > (and other tools we have). There's nothing U-Boot specific about this,
> > if I'm following the thread right.
>=20
> Indeed. However U-Boot was the first project to adopt and implement
> that spec. So the tool was naturally added here

Lets start by adding it here then, thanks.

--=20
Tom

--aOJUccF1hEuTv7X6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaTGPVQAKCRAr4qD1Cr/k
Ct4oAQCeyvs7pB/WtTCgNxnQzeSzU5l0+LfGoGr7SlbPbAMWAgD+PIY17HQEoTjs
h8b4W/BJR9qZ4aSPbQKcc4vRCGdPKAA=
=Y4CN
-----END PGP SIGNATURE-----

--aOJUccF1hEuTv7X6--
