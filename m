Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D6ADC54E76
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 15:59:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 024C4871B2;
	Sun, 19 Nov 2023 16:59:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pkuxoB8i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED2C28713C; Sun, 19 Nov 2023 16:59:27 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16C8A8710A
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 16:59:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6ce2b6cb933so2187106a34.0
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 07:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700409547; x=1701014347; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=upbP9jooJ6LpiOAd0Qbtc+/DobwB8SAhZu0AZYzr83A=;
 b=pkuxoB8id5m6fH60yhCQPnc55zJLd0ykspcRneSTvSKmyfOkaBDGoKLVRLsrj0YnQo
 RIymcpWa9ZmAHMmOFmfuk59K+7iRVp+8KTqBm60FCX+fu3CpHu+C9FjQ4d94JNtjjeAV
 PMEcja2Ju7HYO1hOq2AUWiO+CdGBkWhDfA2HE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700409547; x=1701014347;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=upbP9jooJ6LpiOAd0Qbtc+/DobwB8SAhZu0AZYzr83A=;
 b=hY7Cas6DYdPPpKs08ZD0rbDqD4CaH8koxVoyMngFtU/C0c02W3qLBXf3w3dB+L4ZkZ
 uylraLL7FKrBahJfRFBbZ11g5yLJo8vGii/MSbUkW6RUhY8wefgsiJNNVXgcbmEq0XzQ
 r9sQ6XZ076HS+iSI70GVpczifNnChbXojT1tUb+AxbyWXu2kLSWxwixuKEvag/vm/dwj
 Xh69HsCiQjE+FrRe8Fv2XNg5R+U8hVD3oLdHGa40l+/C91t9hmWpNDPxXmfnJR657Hrp
 /ltXbvOGtCnf5Tn7ZEvzda4NSK+I6SdVCbejfO1mDeFu6CEfe6LSkczAJbqvRmsg7L6l
 6Snw==
X-Gm-Message-State: AOJu0YydswkXPnzEQgrqpJLmCgpHslkHRHAvYLYulneKgVPiHg4uuM7w
 XbYlpmkLX7WXftIkm+X26jCIsQ==
X-Google-Smtp-Source: AGHT+IE0g0TCLLxaIanLpMEn/OChVen/EgCtkE1Hd03pD7fKvviQUxFRDeyO/ocxRg4XYYwS8D4qiQ==
X-Received: by 2002:a05:6358:8a0:b0:16d:984a:7459 with SMTP id
 m32-20020a05635808a000b0016d984a7459mr2827536rwj.26.1700409546924; 
 Sun, 19 Nov 2023 07:59:06 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-af10-dfdb-a5aa-dfc7.res6.spectrum.com.
 [2603:6081:7b00:6400:af10:dfdb:a5aa:dfc7])
 by smtp.gmail.com with ESMTPSA id
 s185-20020a0dd0c2000000b005b03d703564sm1817205ywd.137.2023.11.19.07.59.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Nov 2023 07:59:06 -0800 (PST)
Date: Sun, 19 Nov 2023 10:59:04 -0500
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, xypron.glpk@gmx.de, masahisa.kojima@linaro.org,
 raymond.mao@linaro.org
Subject: Re: Pull request for efi-next-18112023
Message-ID: <20231119155904.GB2513409@bill-the-cat>
References: <20231118202945.265566-1-ilias.apalodimas@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hFK8rY775K2CKvlr"
Content-Disposition: inline
In-Reply-To: <20231118202945.265566-1-ilias.apalodimas@linaro.org>
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


--hFK8rY775K2CKvlr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 18, 2023 at 10:29:45PM +0200, Ilias Apalodimas wrote:

> Hi Tom,
>=20
> The following changes since commit ae7ec8b0be41b59ef323f7531c0fe6745e8fef=
45:
>=20
>   Merge branch '2023-11-16-assorted-updates' into next (2023-11-17 08:38:=
05 -0500)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-tpm/ tags/efi-next-1811=
2023
>=20
> for you to fetch changes up to c022eed4bedf2e16e737fde22b03289d2a48cb27:
>=20
>   doc: uefi: add HTTP Boot support (2023-11-18 10:08:09 +0200)
>=20
> EFI HTTP Boot is currently supported by using a combination of
> wget, blkmap and bootefi commands. The user has to download the
> image, mount it using blkmap and then execute the efi installer
> using bootefi.
> This series simplifies the user experience. Instead of doing all the
> steps manually, users can now enable a new Kconfig (EFI_HTTP_BOOT)
> which will select wget, blkmap and dns options. They can then use
> efidebug command to add a boot option for the EFI Bootmanager using
> =3D> efidebug boot add -u 3 netinst http://<path>
> =3D> efidebug boot order 3
> =3D> bootefi bootmgr
>=20
> The boot manager will automatically download and mount the image.
> Once it's mounted it will locate and launch the installer.
>=20
> It's worth noting that this rarely fails, but the reason is irrelevant
> to the current patchset. More information can be found here
> https://lore.kernel.org/u-boot/CAOMZO5CoduEgwgdQiybmoKh6qQZOezUtRRQO4ecaG=
dZBBz5dDw@mail.gmail.com/
> The tl;dr is that wget sometimes fails to download the file correctly
> or set the size env variables. We expect all these to be solved once
> LWIP is stable and pulled
>=20
> The CI reported no issues
> https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/18623
> Please consider pulling!
>=20

Applied to u-boot/next, thanks!

--=20
Tom

--hFK8rY775K2CKvlr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVaMMgACgkQFHw5/5Y0
tyx3EQv+KQYiRwyYLgzJJL3Gf7Eh5EJBLBbmAf5CiCHt7G4vgsbzk/s3BK25YRMm
DBCGwnLAJN/2l9jwJ8MzPSkREs9rEg1GIScChM6GVk0irJqAyAMac1MX9WEI/XvK
3Xoxk8Ph1rVkADLZ+4xp4ebSiWXQ/DkQeNkkEvFNUOBkrFavDRhSWjunJslMDxZr
mLJVF6Z47t1523awf/QN70cqcQoZoBj0j596ReQKT6lj0fTs1tTby8VWNAfyZyRV
3bOWZwTuQ1VfJs5Kb96Tfw9K+YWQxaHUzW1G+dgroOZeNqA37svk+EFmq++zKneQ
C3NnZE5VP8o9NnuIC3IVx58yBpkXFNSdZPDMIU1DhFkAXPGRH6o03NWWw9cvX+Ev
NxNMb20Wy4cC/KihaLsHDCBYiwGwnMMC9SSM/OCPuYCPMKE1uRmkZlV4CnyVHe1Q
8givEjdtELFMaywjPe98vlhw7a3b8dLMJXWR4MrK+2EtGxIA567AfCU/Hz8i2/Gt
gIK6W1F1
=UVqr
-----END PGP SIGNATURE-----

--hFK8rY775K2CKvlr--
