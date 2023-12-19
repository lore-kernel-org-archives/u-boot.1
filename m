Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9410C46CCD
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 15:40:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AE7E86FF4;
	Tue, 19 Dec 2023 16:40:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PzrL5KOC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DA2C86EA6; Tue, 19 Dec 2023 16:40:41 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA6D1871AA
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 16:40:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-5e248b40c97so38669347b3.2
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 07:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703000437; x=1703605237; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pzHoEL3gqHkwC/utXzlFXzvbdMFLBf+m6qmVnRz7FjA=;
 b=PzrL5KOCpCvV7lH65LHlK1rNAkpojVb1+7Eybv86AhI+b75TLmmC6ohV9YbdUeEfKg
 XFCVZXcT6GJ8lXB2PtcJOwQ7UDRLftE9QVH7Zq/7hrqgm7Mj4EzccyVqglv+Hy3UMaal
 35sp1AD6UpoDDtQvZGAR7p2G/cR8V9mQKx/sk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703000437; x=1703605237;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pzHoEL3gqHkwC/utXzlFXzvbdMFLBf+m6qmVnRz7FjA=;
 b=v8FAYkbrPHa0QnVV+wiEbfGSrWj9pm7ldEKgsIahlKhVWgit4hp8nnzwIh1OzGsQOV
 qpgMX5IyfxndAm9meOMCuN5cDcrY8Y/fsnxZIgfSytdOI8ntAGQHdDEmzEa6tQZ6JeUB
 YH9f93NXygB5lDHW1wTel3XjZq8t1nCiSURwflQmEI9Fv64Y663I1ObBp9tMnYCUkbPI
 HQmA2zryklc0JzVSa8KGrH15ISdUIWjS/Q0Ht5/yV/5rHBrd2h3jinN8MkgZL+r2A20a
 1R1sT7zo3LnfMVEZBQLinipX3byJCuDFuMWCnJpzWy9TSpg3UIPNRLAPMu5uUVv1BIaW
 Krqg==
X-Gm-Message-State: AOJu0YzZiMFuXwFIJnGl8RER8tkK16Xxy1oRMAWV5H1avNtW90iJgHtr
 VhmMQMrTRB+HrRSEH8dGfj05Ag==
X-Google-Smtp-Source: AGHT+IG6YYQVoT7dQLDL2ShH4jvdeHDoivsy4bGRaF1VXWS6Otgn0WO5GuwQgBcT+v61RNPxm3bV6Q==
X-Received: by 2002:a81:7243:0:b0:5d7:1940:f3eb with SMTP id
 n64-20020a817243000000b005d71940f3ebmr13567023ywc.83.1703000437529; 
 Tue, 19 Dec 2023 07:40:37 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-923c-ac63-6854-a688.res6.spectrum.com.
 [2603:6081:7b00:6400:923c:ac63:6854:a688])
 by smtp.gmail.com with ESMTPSA id
 n8-20020a819c48000000b005e39c92db54sm4642556ywa.95.2023.12.19.07.40.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 07:40:37 -0800 (PST)
Date: Tue, 19 Dec 2023 10:40:35 -0500
From: Tom Rini <trini@konsulko.com>
To: Michael Walle <mwalle@kernel.org>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, xypron.glpk@gmx.de,
 Abdellatif.ElKhlifi@arm.com, Drew.Reed@arm.com,
 ilias.apalodimas@linaro.org, nd@arm.com, sjg@chromium.org,
 u-boot@lists.denx.de
Subject: Re: Adding EFI runtime support to the Arm's FF-A bus
Message-ID: <20231219154035.GV2513409@bill-the-cat>
References: <B06FB6F5-416C-440D-BC72-070673DF3177@gmx.de>
 <20231219101124.2847425-1-mwalle@kernel.org>
 <87plz2nzr1.fsf@bloch.sibelius.xs4all.nl>
 <f2eb636cd895aae348d4357537267fd2@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CUoiyrBoLl2h8cIq"
Content-Disposition: inline
In-Reply-To: <f2eb636cd895aae348d4357537267fd2@kernel.org>
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


--CUoiyrBoLl2h8cIq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 01:47:07PM +0100, Michael Walle wrote:
> Hi Mark,
>=20
> > > > Any runtime device drivers for variable storage should not be in the
> > > > U-Boot runtime but live in the secure world (e.g. OP-TEE) FF-A is t=
he
> > > > new ARM protocol for talking to the secure world and hence fits into
> > > > the picture.
> > >=20
> > > What if I just want a simple embedded boot stack where I don't
> > > want any secure world and just want to be able to boot a COTS linux
> > > distribution via EFI?
> >=20
> > That already works for many Linux distros.  As long as the distro
> > installs the appropriate BOOTxxx.EFI file you don't actually need to
> > set any EFI variables for the OS to boot.  It can't get any simpler
> > than that.  Of the main Linux distros it seems that only Debian
> > doesn't do this.  Someone should probably lobby Debian to do this as
> > well as it would mean that Debian would just work on an EBBR compliant
> > system.
>=20
> I know. Last time I checked CentOS (or was it Ubuntu?) tried to
> set EFI variables and the installer just failed. Might be fixed now,
> though.
>=20
> > Things get more complicated if you want to install multiple OSes.
> > Then having EFI variable support makes things a lot more
> > straightforward.
> >=20
> > And of course EFI secure boot needs EFI variable support as well (with
> > proper support) for authenticated EFI variables.  But IMHO that no
> > longer falls into "simple embedded boot stack" territory.
>=20
> Thats clear.
>=20
> > > Assuming, that there might be a simple dedicated EEPROM to store the
> > > variables which is not exposed to linux, is that something which would
> > > be rejected by u-boot mainline now?
> >=20
> > Not necessarily.  But such an approach will have limitations:
> >=20
> > * Completely hiding the EEPROM from the OS may be hard.  Even if you
> >   have a dedicated SPI controller for the EEPROM things like the SPI
> >   bus clock or power domains may still be under OS control.
>=20
> Fair point, but I was thinking about the ls1028a for example, where - if
> I remember correctly - there was one dedicated i2c controller in a sense
> of isolation, probably to use with a secure OS. Also there is no dynamic
> clocking.
>=20
> So, technically it should be possible, even with a low overhead, like no
> device model etc, which could reside in the efi os services. Just testing
> the waters here, not that I'm interested in adding support for that in
> u-boot. Just a bit concerned that it (EFI variables) will only work with
> a full stack (tf-a, optee) in the future.

I would fully expect us to continue to support the case you're
describing. It just may have limitations or as you describe
implementation work needing to be done to support handling security
differently. But it should (*cough*) be abstracted such that it's
possible to do so.

--=20
Tom

--CUoiyrBoLl2h8cIq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWBuW8ACgkQFHw5/5Y0
tyxQQQv/QLqdzxbFX1M4bfsj9r50hWidiFqxJMkgW6fyVUURU4bDA2eUWGT+teT2
qkSg/zYCzU4DdFElQ2nd+WZtpe+XrzKiRM7xZi5fpGbyToccM56TGK4zzYgnp0qI
7HcmA5TEt7dwTVXrJwmkTnq5lhGSH7EHpKgXDkN6eehJnaWrrGwlv6LIWgULYQN0
G25rzyAAfflf9OF7+StAdOWUreKlsliRTMhC8J9kUe1vTARtynR9ls2FDQKJ/QDN
tkM4rtCkJgGaH23S85RdbD1ydgu6+fGnbn3VsqzBacK1/bUnwHlcvJeBsOCYZDxe
xFX2rZpp+YNjSCM1+FfR9CKVQYWfUAaQDHjxRv4+rjNo8DnNzKXn5R1Bcd71/DH1
Fwq4uSuxJdVh76ZmpgU7ljenPiVTFPOJu7WIgNQYdYv1BkKTwoJjUOiGz9v4qHWw
P588D+AwViZcetlZ6E75A9he9ClmAy0UqiioBkv4dHg3l3ecLm7jSbny5COZgkPk
w5m2x33O
=bBHW
-----END PGP SIGNATURE-----

--CUoiyrBoLl2h8cIq--
