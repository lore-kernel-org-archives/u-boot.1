Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59CB0C36010
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 14:36:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF11E805C8;
	Thu, 27 Mar 2025 15:36:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CaVXV1Wf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09A1A806FC; Thu, 27 Mar 2025 15:36:16 +0100 (CET)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53B0E8003E
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 15:36:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-600038877ebso600441eaf.0
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 07:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743086172; x=1743690972; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1iEjdALe+6gQ9wHKFxseRImzOkEn0elrr9Lru+QpVV0=;
 b=CaVXV1Wf/QMmIbi/OIvw+2a9PMkcu+MJ1tD2mNIwtRDr1aYpcuEn+09U/KCi7JF2os
 Y9hr3WgLy6UipQuB4+VwXrRvlpzOzg/e4ZDWhSG7LuSCRPPOKTc8CA21NfmBUR5wPbJX
 2DLhJJhUB9jgccuAyDGlyv9PXKNcs+PztB2wg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743086172; x=1743690972;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1iEjdALe+6gQ9wHKFxseRImzOkEn0elrr9Lru+QpVV0=;
 b=AtvN+kmRWv/cYNK0q2GK0zj6vxlxc0paNLWXvLBKW6QifhpU99m1EJyb7CI+ydWCZG
 kOmJpUlUcdK1mFcK0XsQZ/U9MLqjvJbrOCNJSNOyAqoJREtLcvh78OaKXz2Ap7QSNeWU
 +44JYuY/c4m0qyjK1l4xi6ydvXswYBYIyxLgHbFfAKznfCbxAUXnerLdPvC361OMvIrO
 CEqTY2ZzgEXxrdnUjebV6HVKqNX3RI5bjProlB38twXkvaeIAgVWKfDW8HACl6H2l0yD
 sewgTgDxanHyJjmSzo+z0eLxHRjtVkszkSkBO362YuyrTLh1Jwdc1DgpJYxOtS0kFIsP
 BQgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXscOI95ewXNUJagRF1UE82sQ99sfal+J/2A1Q0u8KzF5GUCMqX178uaXJT7dhzrOHeDkA7jI=@lists.denx.de
X-Gm-Message-State: AOJu0YxAvxAk+mEYxz8I1wkzwaoYSMik2uWNagTLEYkvseFuoEpXL+2w
 aTIfsiItyh6r8HVSH7qfVfkJP7Hj94SA+QFQQy2sjphs3XwaX243w/RO9WCThQo=
X-Gm-Gg: ASbGnctiCoq79oYGsgbSaw0tSSMX2IuTLPYVIyFcM/8pPjH1TEONgjfvXXLDkEZiQul
 TwrgvFCXpeBSlBoLQy0L3GR2sXv+KUyMFMzTC/EdY80ETYFhqi+CoLod/F8z8pJihtGt2Le/D1n
 5J3mbI7w4j0t0fS82qQnzK+xquZ8QBXeYn4KHEAgSeqhpPiFlsF/UIGhLB6AqgmKwkOj2tGD7kq
 qPIBywBIIuAM3Eu0uouBWR9NUj8RM1/ci/+qLr6eJ3rknNBvS4BUNrE7LunDt0qxptXh1sOeEIP
 i2c1ig+A/J9zksG9LWFr2IMAKtVW93JgLgphQj/vNSigGkgMMQG5JuKjf/OKAucuxtf2SaRO98q
 qRQ3WJw==
X-Google-Smtp-Source: AGHT+IETgmtMuPOBwrW1hrUJovkXX+CaqcZheOcrL+6rQYEWxvDVReMftbPlSTbRwSe19NghHK9PuA==
X-Received: by 2002:a05:6870:5b9b:b0:2c1:3d93:c192 with SMTP id
 586e51a60fabf-2c848221302mr1846075fac.37.1743086171804; 
 Thu, 27 Mar 2025 07:36:11 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2c77f05de8asm3615277fac.36.2025.03.27.07.36.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Mar 2025 07:36:10 -0700 (PDT)
Date: Thu, 27 Mar 2025 08:36:08 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 4/8] env: Rename SYS_MMC_ENV_DEV to ENV_SDMMC_DEVICE_INDEX
Message-ID: <20250327143608.GR93000@bill-the-cat>
References: <20250322215624.18994-1-marek.vasut+renesas@mailbox.org>
 <20250322215624.18994-4-marek.vasut+renesas@mailbox.org>
 <90254a96-5d67-4d34-afe6-772af42ee557@cherry.de>
 <e385568e-59b1-4adf-9fb7-d87b4254eae9@mailbox.org>
 <20250326001521.GN93000@bill-the-cat>
 <d576535e-f8d0-4ae7-b8b7-f4316535a6ee@mailbox.org>
 <d9382933-70f2-4c3c-abf2-4fd711fbfc4f@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bIGI5h5wmTu644R1"
Content-Disposition: inline
In-Reply-To: <d9382933-70f2-4c3c-abf2-4fd711fbfc4f@cherry.de>
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


--bIGI5h5wmTu644R1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 10:22:34AM +0100, Quentin Schulz wrote:
> Hi Marek,
>=20
> On 3/26/25 2:37 AM, Marek Vasut wrote:
> > On 3/26/25 1:15 AM, Tom Rini wrote:
> > > On Wed, Mar 26, 2025 at 12:02:08AM +0100, Marek Vasut wrote:
> > > > On 3/24/25 1:39 PM, Quentin Schulz wrote:
> > > > > Hi Marek,
> > > >=20
> > > > Hi,
> > > >=20
> > > > > On 3/22/25 10:55 PM, Marek Vasut wrote:
> > > > > > Rename the variable and add ENV_ prefix, so that all configurat=
ion
> > > > > > options which are related to environment would have an CONFIG_E=
NV_
> > > > > > prefix. No functional change.
> > > > > >=20
> > > > > > Use ENV_SDMMC_DEVICE_INDEX to clarify this is the SD/MMC device
> > > > > > index, a number, as enumerated by U-Boot. Update the help text
> > > > > > accordingly.
> > > > > >=20
> > > > >=20
> > > > > I disagree with this part of the rename (MMC->SDMMC), our drivers=
 all
> > > > > are using mmc (env/mmc.*, drivers/mmc/*, cmd/mmc.c, ...) for
> > > > > both SD and
> > > > > MMC. We also have ENV_IS_IN_MMC which is for both. I don't think =
it's
> > > > > worth the confusion.
> > > >=20
> > > > My main problem is, that it is confusing to call everything
> > > > _mmc_ even if
> > > > most of it also applies to SD . There is no way to discern parts
> > > > which are
> > > > MMC specific from parts which are common to SD and MMC now.
> > >=20
> > > Do we have support for anything using the MMC part of the standard th=
at
> > > is not storage? I certainly agree it's confusingly named atm, but I
> > > think changing some parts but not other parts will make it worse, not
> > > better.
> > That's not what I am concerned about. What I am concerned about is that
> > we are talking about partitions, and only eMMC supports HW partitions,
> > but both SD and MMC support SW partitions . So we should refer to
> > CONFIG_..._SDMMC_..._SW_PARTITION here when talking about SW partitions
> > , but CONFIG_..._MMC_..._HW_PARTITION when talking about eMMC HW
> > partitions. Currently we are missing the two and it yields a horrid
> > confusion. That is in fact what prompted this series.
>=20
> But the controllers handling SD cards or eMMC are both called mmc in devi=
ce
> tree and in U-Boot (see mmc command). So for me, MMC covers both. As a
> matter of fact, the mmc command also handles the boot partition that is
> specific to eMMC.
>=20
> Quite interestingly, the MMC (MultiMediaCard) Wikipedia page starts with
>=20
> "Not to be confused with SD card or eMMC" and then the first sentence in =
the
> history section is "The latest version of the eMMC standard", c.f.
> https://en.wikipedia.org/wiki/MultiMediaCard
>=20
> So essentially, I'm wondering:
> - if boot partitions are specific to eMMC and not simpy MMC (and are not
> part of SD card). I know eMMC has a separate standard than MMC.
> - if there are other things than eMMC (and SD cards) that are supported by
> the MMC subsystem (outside of the embedded world). It seems like this is
> taking the MMC =3D eMMC shortcut that I'm not sure is correct?
>=20
> To add to the confusion, Rockchip often has MMC controllers named SDMMC (=
and
> their use varies depending on the SoC, sometimes for SD, sometimes for eM=
MC,
> sometimes for SDIO).

This I think is part of the problem (and re Rockchip, my recollection is
that at least some TI parts and manuals have similar naming issues).
It's a terribly confusing area to start without and outside of U-Boot
itself.

My suggestions in general would be:
- Don't rename files / commands (and this series was not doing so
  either).
- Whenever possible take things out of CONFIG_SYS / CFG_SYS and instead
  rename them at least partially for CONFIG_ENV_... or CONFIG_MMC_... or
  CONFIG_SPL_...
- We only have two "SDMMC" symbols so lets not add more
- Use "MMC_" as the namespace and help text (and where useful, doc/
  documentation) to further explain to humans what is being implemented.

--=20
Tom

--bIGI5h5wmTu644R1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmflYlEACgkQFHw5/5Y0
tyzxQQv7BgG77sXbhDUHTvT1f2OdmfAnpkwmvNMMC4TlVKl/wSCRmt7wHbP1WbZR
QwRkSqH8pwH/EbzwfZeNWMA8IdN9u45hH7+8jh5W0J5TaJ9TIoeMcfMLmre+LbtR
M+aALfru9aqwfANAAwrEz4Ksd8j57QC3Vrq2QqXNzPRdMJwSUWmVKq+kN2kC03PW
s6ymVbWR6Za17ndntLLhnJn2v5aS/INOkiqYCTxf44XRHxeskY3jAkNikLng23d2
kjqvUbHrfHvWC5syBXrleMztGfiMgGjhl7t9gNlI6BCteqmt8TvuL+TQw8ARyK+J
UzcHECEHBsdTxVB9hBY5s6rQ4iKWCl34FFpFtbbT3vaqZNSCHj5XagcBHCbPwhRO
oyycmzHfXcqss8OV4+eKXCaS0jv79KfKR8BxqklYIlmmfLrP+d4SKV2EbRxGwnz0
HiCCLr2J7BxhR943BFtQXSangtd8aAG4eqPuLcCnq+iP7nIFdUgeTZSdR9TXni5f
9YNaaRD6
=ruht
-----END PGP SIGNATURE-----

--bIGI5h5wmTu644R1--
