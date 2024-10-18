Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9914D3F29E
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 21:00:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 445EF88D29;
	Fri, 18 Oct 2024 23:00:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ceAaHvZb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B72288D5B; Fri, 18 Oct 2024 23:00:10 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 032AD88D13
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 23:00:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6cbf340fccaso21021886d6.1
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 14:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729285207; x=1729890007; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0teoYoH1+28VyHj5RGs2+tSjWiFt9YBnyEk50DPFT18=;
 b=ceAaHvZbbRtiHAoWqBA7NaU6Ha/3QjJmPFYGkL5iHPJmrcOryErSjpku1mnzjE+HZX
 HxaZZz+71X8gl0KAPfCWD+4thQP2c42Wsa1Egt6z5colMZLjoO0uG4+iZWIV1yUGLYKm
 RKLTM1RqEuqRoq3pA2UFn8BybbZuNfEkV9Lks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729285207; x=1729890007;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0teoYoH1+28VyHj5RGs2+tSjWiFt9YBnyEk50DPFT18=;
 b=TI579gq8BARtprfitoVp3PwI41ltO+qrWSx+t/JvCirdaVM16xNBo7EAJQoSnQu0So
 MWazFmYas+++tSXqE4R5A7fKi44s8sJAfCYBrgYCGjU22VJ0IQvVj0hQqPKpyS6aBjlu
 s56A67FWN9AGBlB4XD9cgc7vNCj/5QPPTXbKPUpc9+DTPgIRnhLjTJr8R/BADLmMZ/sd
 2BAdwoiDgIml35r7PrKtvqMFogjDnPyRNlfvwUSTY5zD1InK4Yx353RBQsf12xV5dbI7
 WpspB5gyukcFdZcNfvzpaQOfDskSNk0nskbBY5LxwGVpnXukRuZqnCnTzH+pHkc5ddUT
 95wQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV76YdC/M1j9lGMNKbomn0MJCxedXcJJIBZE5mUDprHnzNIIVutp1ENvc1QgQwIyjnvcjlJJkc=@lists.denx.de
X-Gm-Message-State: AOJu0YzA0qe4uT/eDZ11mN6+ctfxKp71+K9wVARRFIwn5NVepHX/oggP
 hkR84ZgtOvS5+Le8Vz83FeiwOI/Jjk0MDCE/rJaeByQ4NNp5rBsf0RR/06Gx6yAYhWrHuEHNWNM
 EMF8=
X-Google-Smtp-Source: AGHT+IGkkDLhGSkmEbeffL7lRyPVPGjZ46PJC30hZMJonFoinZnETe/l3aHqu2YrnazibTV/YcGikg==
X-Received: by 2002:a05:6214:19ea:b0:6cc:819:5075 with SMTP id
 6a1803df08f44-6cc378a929cmr115021386d6.18.1729285206710; 
 Fri, 18 Oct 2024 14:00:06 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cde111b340sm10552316d6.7.2024.10.18.14.00.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 14:00:06 -0700 (PDT)
Date: Fri, 18 Oct 2024 15:00:02 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Mark Kettenis <kettenis@openbsd.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 2/2] sandbox: add bootmethod EFI boot-manager
Message-ID: <20241018210002.GK4959@bill-the-cat>
References: <20241018011837.126813-1-heinrich.schuchardt@canonical.com>
 <20241018011837.126813-3-heinrich.schuchardt@canonical.com>
 <CAFLszTjjF1r4f6NjrYSFz36DK_X6v6rYMwDCUqiSLOPysGRC7g@mail.gmail.com>
 <ee96c1c0-c1d5-4f18-a1eb-f6460e859683@canonical.com>
 <CAFLszThZ-s1Kwhv0DBoEG2uKE=MFdb_CmOY5hn0O5dVuFUP=Vw@mail.gmail.com>
 <20241018203657.GJ4959@bill-the-cat>
 <f761d5f8-22ed-4310-8a48-e13bae888cbe@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qIP+Ji8fRZFwt/MY"
Content-Disposition: inline
In-Reply-To: <f761d5f8-22ed-4310-8a48-e13bae888cbe@canonical.com>
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


--qIP+Ji8fRZFwt/MY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 10:49:16PM +0200, Heinrich Schuchardt wrote:
> On 10/18/24 22:36, Tom Rini wrote:
> > On Fri, Oct 18, 2024 at 02:17:36PM -0600, Simon Glass wrote:
> > > Hi Heinrich,
> > >=20
> > > On Fri, 18 Oct 2024 at 11:26, Heinrich Schuchardt
> > > <heinrich.schuchardt@canonical.com> wrote:
> > > >=20
> > > > On 10/18/24 19:21, Simon Glass wrote:
> > > > > Hi Heinrich,
> > > > >=20
> > > > > On Thu, 17 Oct 2024 at 19:18, Heinrich Schuchardt
> > > > > <heinrich.schuchardt@canonical.com> wrote:
> > > > > >=20
> > > > > > The EFI boot-manager is the default method to boot EFI binaries.
> > > > > > We should be able to use it on the Sandbox.
> > > > > >=20
> > > > > > * Enable EFI boot-manager bootmethod on the sandbox.
> > > > > > * Adjust unit tests to reflect the additional boot method.
> > > > > >=20
> > > > > > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonic=
al.com>
> > > > > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > > > > > Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> > > > > > ---
> > > > > > v2:
> > > > > >           no changes
> > > > > > ---
> > > > > >    arch/sandbox/dts/test.dts |  4 ++++
> > > > > >    test/boot/bootmeth.c      | 28 +++++++++++++++++-----------
> > > > > >    2 files changed, 21 insertions(+), 11 deletions(-)
> > > > >=20
> > > > > This is better, but I still see this.
> > > > >=20
> > > > > =3D> bootflow scan
> > > > >        efi_var_to_file() Cannot persist EFI variables without sys=
tem partition
> > > > >=20
> > > > > Please find a way to get rid of it. I can give some suggestions i=
f you like.
> > > > >=20
> > > >=20
> > > > Would you, please, mind providing a rationale why you want this cor=
rect
> > > > message not to be written.
> > > >=20
> > > > I expect the sandbox to behave as any other board and provide warni=
ngs
> > > > when they are adequate.
> > >=20
> > > Well, what I am supposed to do to fix this warning? I just don't want
> > > unactionable messages coming up in bootstd.
>=20
> The user runs a system that tries to boot via EFI. He does not have an bl=
ock
> device with an ESP. For sure that is an actionable warning:
>=20
> The user should insert properly formatted media.
>=20
> And your test should put an ESP on the image.
>=20
> > >=20
> > > If it happens all the time and cannot be fixed, you could add an
> > > option to the driver to ignore it, which can be controlled from the
> > > devicetree node.
>=20
> As said it can be easily fixed. Create an ESP on one of the block devices.
>=20
> Do you really expect a user to change the device-tree to suppress a warni=
ng?
>=20
> Wouldn't it be more plausible to remove the EFI boot method from the
> bootflow instead if that device is never to be booted via EFI?

Assuming that Simon is trying to test an image that won't be used with
EFI, but we check EFI first, is there a call we can do to check for
validity and if fails, move on?

--=20
Tom

--qIP+Ji8fRZFwt/MY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcSzEsACgkQFHw5/5Y0
tywfbAwAuO4qno3DlqTT6uBQToPEQlyuVW2KJk4NYDck+nEudLaTJN3vqBwaEmUh
uyYysisg+nZIfBe2itd+AV92PXHPf6qK7JPhPqQ04OVuXsqqfQOcv08PJacLRdP5
XXgIjPi1BOkyhdJWxR8MqBOmcYKt+NHa9U0Dg1ChfRPmqq8hCd9i+mNHr0DOIueQ
5c+wWHG30tcxUsaBU6yiqFrKLkxz1kVWSPJBS0g7F+hHZ+0Dqvi5eRBbSp+cQqOG
XN0B642rmLfXiA3UsLFgiO08a14szbCWJX1qoaxi3K4v5FXAgK+q3RKDoNdJT8X1
VFleUv+ZVLZOebf7VlJPRXLPAnXn5ZlXjnIduPp7i82jpidczI10GR1B2dp26q0v
8lzhgi7o4QYh/wGzhBDbDeTgBGE7ZdiZE1Vk1F73rT3UzcX1BfYW2O53woieOns3
snPVjiK61i3tz/NuJxT8bZv8Zovuqw/EFdfJyowXw2z7I53pk4/GLV8gOFLceRa/
ClWHpiQ8
=z8Uk
-----END PGP SIGNATURE-----

--qIP+Ji8fRZFwt/MY--
