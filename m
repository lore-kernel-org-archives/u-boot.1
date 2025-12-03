Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1D00CFD376
	for <u-boot@archiver.kernel.org>; Wed,  3 Dec 2025 15:10:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2761E83FDE;
	Wed,  3 Dec 2025 16:10:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cFRAjJ7o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0062983FE6; Wed,  3 Dec 2025 16:10:56 +0100 (CET)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A815F83FCD
 for <u-boot@lists.denx.de>; Wed,  3 Dec 2025 16:10:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-6592f1f55a8so1520799eaf.2
 for <u-boot@lists.denx.de>; Wed, 03 Dec 2025 07:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764774652; x=1765379452; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ouEVGEHu1mvXRwsl82bVG3DLpCPOgVuf9IGV84mt59o=;
 b=cFRAjJ7oNASuluI/OD8/bKG57+UytycuivUyAvKd2PHaummbeHafvUX7fHH0GCAnGu
 X8fyibQ369SrCioisTwuzBZ4YJPCdnsDnnyuyJ0XPUPRW8TbRIftmQswv4r62XzPuCsP
 TwArzk9xc5qFt4i3PPxoOHmA24lxwTVCU1oeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764774652; x=1765379452;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ouEVGEHu1mvXRwsl82bVG3DLpCPOgVuf9IGV84mt59o=;
 b=JdnKcVU+t9MHo9PSg1mXTQvPOGHmbXA1sfeM7BcwHO6mCLgkSBYULGK3869fIPOUkZ
 HB5auCRHrpReUxwaC6X44IF3adhZOAoR1ej9walTCayf4S9/jEI/9GYx0iHUpPFZS+K+
 zr46lvCd/sjoEdcCvouGrcu1QHNxlMEf0NJZOUlft2VuPxt/A5O1IZIJgAlxjRtFd/uS
 bgQv5rTRS0M+MVrejmEX9xauM0LOaEoXPQ3OB4cJbN+H1/YYHRB62D6gjABn/4zhdC3X
 402dJRELWU+nAIJlP57UF69adgGC5SEqHqHEs3WHrxyUnBifksG4VPZuKIHf10yDYr4Q
 u1XQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUS3uiGPzZA5jB0w/4sTyUJVyapDhHK3M5GPaWKC6xUcR3eooi1Wmz5jMYJpJUv+j0RtCUNRRI=@lists.denx.de
X-Gm-Message-State: AOJu0Yz+KAWwb7q76uI2TRthVz2xz2iRxMuDqnJtX3NfSrksbhRey/6B
 oxpBP9pCfC3SvXdcFApuRzbnxA9InIxL8OV6Pa4vbajabUEmV+b1oJyQAu2uE9PJo1g=
X-Gm-Gg: ASbGncsar5dM3zl5Nj6QZtiGNGeU/0csxBjLyryE7+ao6L6EiTTiNn+GR1xYBLBmFoz
 /bHFdsUjxx++Rkvr8VPxeQSl8vyednQsofuRvg/kfS7X5+DJIFIIQBHDVCNcm4P2IvgDnhSFLXE
 V1D6U0uI6mLgzNpYF/cOXixPPVRa5j7seQSgtjUph0bmhXAPcLopQn1eEKc2xP9jcDFM//9TWSQ
 Sli+Kp43STsUfyWyN7mDNsscvyp2ucLd4Vq8JwqDxPCb4SduILJ7+CyBqjA6jvlcByIpta4+wyv
 pBtegXV2SCC2w9VFxjFCKUA8BMSCWZ3C32ZIxnaU5TL9wzRvhyOCXKTeixKzWPokHZcLKsLIklH
 +Vh/A+Ptsn54pEqnjppewavitZmw4M3JUpx3aogMLXIY5WZ8cM3JGO1gVDiDQHt1EXxqXfLpOXN
 lj4CGMpnB4vSw7b0H+4QIbNcHlM6+j7BV61DSkK85YmGTCRrjWmw==
X-Google-Smtp-Source: AGHT+IF5swLzSM1UY78KXwt5UuSsJA+Bzgn2NIR8FIqBu/OnmpHBAl5rCrl2H1YJRYhj5ndS3uGc1g==
X-Received: by 2002:a05:6808:c1e3:b0:44f:e954:ba44 with SMTP id
 5614622812f47-4536e41d5c2mr989584b6e.28.1764774652306; 
 Wed, 03 Dec 2025 07:10:52 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4531e72b214sm7135125b6e.5.2025.12.03.07.10.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Dec 2025 07:10:51 -0800 (PST)
Date: Wed, 3 Dec 2025 09:10:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Patryk <pbiel7@gmail.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
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
Message-ID: <20251203151048.GP303283@bill-the-cat>
References: <20251202-feature_fwumdata-v1-0-d55154de4103@bootlin.com>
 <20251203110108.1d93975d@kmaincent-XPS-13-7390>
 <CAC_iWjJ0PFXABOkwPSSdjRuFSPUF79fVCWNRvU5s1PLCuV5ydQ@mail.gmail.com>
 <CA+DkFDbecwtJkX-7wHzQjhVbi-tpjzZVzc7N3kvhr5OtKivgWA@mail.gmail.com>
 <20251203155924.3dd3c5a0@kmaincent-XPS-13-7390>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WZXtkhRmWf3iYQQo"
Content-Disposition: inline
In-Reply-To: <20251203155924.3dd3c5a0@kmaincent-XPS-13-7390>
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


--WZXtkhRmWf3iYQQo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 03, 2025 at 03:59:24PM +0100, Kory Maincent wrote:
> On Wed, 3 Dec 2025 15:04:10 +0100
> Patryk <pbiel7@gmail.com> wrote:
>=20
> > Hi Ilias,
> >=20
> > > > > Add a new fwumdata tool to allows users to read, display, and mod=
ify FWU
> > > > > (Firmware Update) metadata from Linux userspace. It provides
> > > > > functionality similar to fw_printenv/fw_setenv but for FWU metada=
ta.
> > > > > Users can view metadata, change active/previous bank indices, mod=
ify
> > > > > bank states, and set image acceptance flags. Configuration is don=
e via
> > > > > fwumdata.config file.
> > > > >
> > > > > Made a few change to mkfwumdata tool along the way. =20
> > > >
> > > > Still wondering about the choice of putting this fwumdata tool in U=
-Boot
> > > > instead of TF-A. TF-A is the boot part that manages the update proc=
ess and
> > > > rollback through the FWU metadata,
> > > > therefore, this is where it should belong.
> > > > Why, in the first place, mkfwumdata was accepted into U-boot instea=
d of
> > > > TF-A? =20
> > >
> > > The actual update happens via capsule updates only, which runs in
> > > BL33. TF-A needs to be aware in case it's involved in the boot process
> > > and fails to boot. In that case BL2 is responsible for booting via the
> > > other bank.
> > > But generally speaking it's U-Boot that processes and usually updates=
 that
> > > file =20
> >=20
> > If I may add something - actually for me this is not that obvious,
> > e.g. on our platform we update the metadata directly from Linux, not
> > from the u-boot capsule. As far as I'm aware, the ST, in their
> > OpenstLinux does the same. I'm also not sure why it would be the bad
> > idea to do this from Linux. Ofc the BL2 handles bank selection as well
> > as rollback in case of boot failure on a newly selected bank.
>=20
> I agreed with Patryk. U-boot is only an update agent (as explained by the
> standard) of FWU metadata as Barebox or Linux could be. FWU metadata is a=
n ARM
> standard which is related to the update of the images that boot after the=
 ARM
> firmware. It is not related to any project. As TF-A is the mainstream pro=
ject
> for ARM firmware having mkfwumdata and fwumdata in it seems more suitable.
> I am not familiar with these EFI capsule update, does it not rely on TF-A=
 to
> select the boot image according to the FWU metadata state?
>=20
> Anyway, now it is too late and mkfwumdata has already landed in U-boot fo=
r 2
> years. Not sure what we should do here. Put all in U-boot and let the oth=
er
> projects (barebox) copy the code if they need it? Or move all to TF-A whi=
le
> keeping a deprecated copy of mkfwumdata in U-boot to not break things?

Perhaps in the medium term we can split that tooling out from the main
project source tree itself, to make it easier for OSes to use this tool
(and other tools we have). There's nothing U-Boot specific about this,
if I'm following the thread right.

--=20
Tom

--WZXtkhRmWf3iYQQo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaTBS9AAKCRAr4qD1Cr/k
CtmqAP9DLTHLXBkYsvDbfuFDgBg7dqxVhjmTjsVtM7+j64UG6wEA1ZqPraAUNqlD
i577lwTIJYMSoSFav2/2/km0MRVcYQE=
=YtdT
-----END PGP SIGNATURE-----

--WZXtkhRmWf3iYQQo--
