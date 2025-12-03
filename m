Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E43FFD15DB7
	for <u-boot@archiver.kernel.org>; Wed,  3 Dec 2025 17:27:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25DBD83E48;
	Wed,  3 Dec 2025 18:27:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aZVgFehf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F303E83E7F; Wed,  3 Dec 2025 18:27:07 +0100 (CET)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8BCE83DA7
 for <u-boot@lists.denx.de>; Wed,  3 Dec 2025 18:27:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-3e8f418e051so3227fac.3
 for <u-boot@lists.denx.de>; Wed, 03 Dec 2025 09:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764782824; x=1765387624; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AsehBriQTibnWNUHlmA7nTPchj+rYiU1+12zds6CnxU=;
 b=aZVgFehfz+WRhMAGnvhOcpeXjgw+/FLFJfXjlJWWhCmEkCK3/AzXEAdgfRrN+OOy3q
 1ar4yw4P7v3f9prRdi0NXs2owLQiAp4hqj0qtYpLj6BVl2z1BeXcdXTtysBcu8Ra14/Z
 OebCo1yE2vvarmqvvJlvmVQ5UnWotdLlrBVFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764782824; x=1765387624;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AsehBriQTibnWNUHlmA7nTPchj+rYiU1+12zds6CnxU=;
 b=WgW+i4Kfdab0lKAVo9q3ICVzSnwDiXfOdM1sE8pOGydK+ESX2dAljYRNTjJNdyLjNG
 DuprDOZfELLFcAzvTulaVjNFagAb1lq5RUzfHgAoVNf0UGxE5NZ+eHj7kuMRAoW7ZmFE
 TtGEDja8kFHmJl9bcpVigw8joWY8E5DYuXtwyFNQgbJhJF7xi162IAo4MI3jxvu5fz9c
 hFfN5Mm0uVdqja0rKppTd6qKEfnHSYdv1CMmzigHFw+vAKZY+iI8AuGoAvSP76/OrH3w
 afcgplLxz+yF7uhA//Xf9YHVMjp4tTGS38r/38o+eAxp4P493Na1VojBd+yjWu2CFvdE
 +e4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUna5ROOUWN/QmVfiEAesssrgPpNqmTilItHsPqhVDa8VFi4NwDg2esuaYNIyDlzH398+fJgWE=@lists.denx.de
X-Gm-Message-State: AOJu0YzgimyxDm2aMm3Bqw/xTZ1Iup+ROx0N6IqJu3CMg7AuF3RV3Eji
 Nlyc8O3bFhjnYgupi6gH3yixaJSCs0bs3AqM5uoWuOIMCmwABwj1ilivjNRasVw557U=
X-Gm-Gg: ASbGncuD5hSS9M1xSDTcKjY7d+jOrzK42bbbWCM1E+WwIU4OYd3L9DQp1t96kT9rzF9
 p+Xhj3GDxVNMfeQCmPudP0zxQJRwzOIAc+Rra09GSA12U+iEc/cHK30RI4T220OnXuE+uw25Gdn
 SQ3tchcnSWNWxaS7Z89fQl1AEgOdHMvTQT+saXJeAlrmXuobt4SM1oDk4adgy5ILahVvvf8ElW8
 RzKxrKYaZ0tJzXYiDaFJQG7UTPJmL19k9GQLL6WfovJwmTy3Lng+qAiqysBLwAlZD2Od/1veEMf
 vNN2p1xJKAzhMhQioaTUFZX/x0l4S5Y3baBgs+5eU/fA21dkisrnLMoTVt6WWF3LRQ52IdSaZWu
 dUePhAoJLoHwIcoJy9KT/vcWg5JG9DOeI1XYCjjVjADNOeUZNzOElmoCfu/6B4c1JisCP+Zy/b0
 qkEM27vwvVARL3R1pNRjRDDC3JxnjB0taimqftjINc2u9EI60LQw==
X-Google-Smtp-Source: AGHT+IF+xCX4gYUd6/JUva7eYEp1SHseIiexXdDdiXyHFoLDFvh3wsQ8aAQdpcltvE+vDZk5tdGAFA==
X-Received: by 2002:a05:6871:2941:b0:3c8:d325:b7ac with SMTP id
 586e51a60fabf-3f1691860c6mr1930345fac.4.1764782824235; 
 Wed, 03 Dec 2025 09:27:04 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f0dd029507sm10135902fac.17.2025.12.03.09.27.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Dec 2025 09:27:03 -0800 (PST)
Date: Wed, 3 Dec 2025 11:26:59 -0600
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
Message-ID: <20251203172659.GS303283@bill-the-cat>
References: <20251202-feature_fwumdata-v1-0-d55154de4103@bootlin.com>
 <20251203110108.1d93975d@kmaincent-XPS-13-7390>
 <CAC_iWjJ0PFXABOkwPSSdjRuFSPUF79fVCWNRvU5s1PLCuV5ydQ@mail.gmail.com>
 <CA+DkFDbecwtJkX-7wHzQjhVbi-tpjzZVzc7N3kvhr5OtKivgWA@mail.gmail.com>
 <20251203155924.3dd3c5a0@kmaincent-XPS-13-7390>
 <20251203151048.GP303283@bill-the-cat>
 <20251203181329.7b33676c@kmaincent-XPS-13-7390>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Mg8NhzK96jqLdpvi"
Content-Disposition: inline
In-Reply-To: <20251203181329.7b33676c@kmaincent-XPS-13-7390>
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


--Mg8NhzK96jqLdpvi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 03, 2025 at 06:13:29PM +0100, Kory Maincent wrote:
> On Wed, 3 Dec 2025 09:10:48 -0600
> Tom Rini <trini@konsulko.com> wrote:
>=20
> > On Wed, Dec 03, 2025 at 03:59:24PM +0100, Kory Maincent wrote:
> > > On Wed, 3 Dec 2025 15:04:10 +0100
> > > Patryk <pbiel7@gmail.com> wrote:
> > >  =20
> > > > Hi Ilias,
> > > >  =20
> > > > > > > Add a new fwumdata tool to allows users to read, display, and
> > > > > > > modify FWU (Firmware Update) metadata from Linux userspace. It
> > > > > > > provides functionality similar to fw_printenv/fw_setenv but f=
or FWU
> > > > > > > metadata. Users can view metadata, change active/previous bank
> > > > > > > indices, modify bank states, and set image acceptance flags.
> > > > > > > Configuration is done via fwumdata.config file.
> > > > > > >
> > > > > > > Made a few change to mkfwumdata tool along the way.   =20
> > > > > >
> > > > > > Still wondering about the choice of putting this fwumdata tool =
in
> > > > > > U-Boot instead of TF-A. TF-A is the boot part that manages the =
update
> > > > > > process and rollback through the FWU metadata,
> > > > > > therefore, this is where it should belong.
> > > > > > Why, in the first place, mkfwumdata was accepted into U-boot in=
stead
> > > > > > of TF-A?   =20
> > > > >
> > > > > The actual update happens via capsule updates only, which runs in
> > > > > BL33. TF-A needs to be aware in case it's involved in the boot pr=
ocess
> > > > > and fails to boot. In that case BL2 is responsible for booting vi=
a the
> > > > > other bank.
> > > > > But generally speaking it's U-Boot that processes and usually upd=
ates
> > > > > that file   =20
> > > >=20
> > > > If I may add something - actually for me this is not that obvious,
> > > > e.g. on our platform we update the metadata directly from Linux, not
> > > > from the u-boot capsule. As far as I'm aware, the ST, in their
> > > > OpenstLinux does the same. I'm also not sure why it would be the bad
> > > > idea to do this from Linux. Ofc the BL2 handles bank selection as w=
ell
> > > > as rollback in case of boot failure on a newly selected bank. =20
> > >=20
> > > I agreed with Patryk. U-boot is only an update agent (as explained by=
 the
> > > standard) of FWU metadata as Barebox or Linux could be. FWU metadata =
is an
> > > ARM standard which is related to the update of the images that boot a=
fter
> > > the ARM firmware. It is not related to any project. As TF-A is the
> > > mainstream project for ARM firmware having mkfwumdata and fwumdata in=
 it
> > > seems more suitable. I am not familiar with these EFI capsule update,=
 does
> > > it not rely on TF-A to select the boot image according to the FWU met=
adata
> > > state?
> > >=20
> > > Anyway, now it is too late and mkfwumdata has already landed in U-boo=
t for 2
> > > years. Not sure what we should do here. Put all in U-boot and let the=
 other
> > > projects (barebox) copy the code if they need it? Or move all to TF-A=
 while
> > > keeping a deprecated copy of mkfwumdata in U-boot to not break things=
? =20
> >=20
> > Perhaps in the medium term we can split that tooling out from the main
> > project source tree itself, to make it easier for OSes to use this tool
> > (and other tools we have). There's nothing U-Boot specific about this,
> > if I'm following the thread right.
>=20
> This isn't clear to me.
> Are you saying that we should plan in removing mkfwumdata in the medium t=
erm?
> And in the short time, sending the two tools to TF-A to get them accepted.

I mean in general, there are a lot of things in the u-boot source tree
that may or may not really make sense to have, in tree. We also can't,
right now, easily support or handle having multiple distinct projects
under the u-boot umbrella. I'm wondering if we should figure out how
to support a few source repositories under our umbrella, in a way that
would make life easier for other projects too.

--=20
Tom

--Mg8NhzK96jqLdpvi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaTBy3AAKCRAr4qD1Cr/k
Co2jAP9UuqQshtdU9SHiq5zySUgUKvw4MJVUYzMGuCkRgmU28AD+Mub7Xq5EciEP
3pvM95p+guG8mbYfyecK5Ad91cQ2VgM=
=m18B
-----END PGP SIGNATURE-----

--Mg8NhzK96jqLdpvi--
