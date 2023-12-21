Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D542C35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 19:02:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B798887886;
	Thu, 21 Dec 2023 20:02:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eqWJXO4f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 583C7877D8; Thu, 21 Dec 2023 20:02:46 +0100 (CET)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 835FA8786F
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 20:02:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-67f8ca6146aso2659506d6.0
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 11:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703185362; x=1703790162; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mNrA4t8rGCP6Ejaf8GHTFzCtbt2ZZufpGlJnbDLhDSk=;
 b=eqWJXO4fkT7iMDx0DsRgVRb9lwo7pnOUuQUsMgL9KGrKPwj6HQeutEGJS33nc9ia9a
 x0XqFD5hpMFJb6rBLmt2bbMS7DW3DgQ2BLOoJA1ht026RPGu7U1gC5BlAEpfGwh2OFlo
 BgsmnQV4KmhfvG/MHicaIE5/DK6Yi9lVEgP6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703185362; x=1703790162;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mNrA4t8rGCP6Ejaf8GHTFzCtbt2ZZufpGlJnbDLhDSk=;
 b=Z4fPn9OayYFPz0WuwdpB/EoUtx0SUIpCpU64vvl0YbPcM7Ox7kPiugEHc/+fLNyM2v
 /zVe+FI0spPvsVFWS4B9ViLG1F6N6GS7WE/kvLY4vHeGlWZkSYCVn2XGR0kdR63UnsFf
 C7piHqgpompihr7p42lowzAv9dH+GhvCchdUAyw2D0dAp4wp81D10nixOYxokCj0dsZD
 EIyJwCxtfg525O26xG2FHVwqiyI5H1CB7/5OShUKQwsH3N5lECJqyRx06L1GegEltOIa
 eg95urFQSbfyKZPphtF3RGyJcqokKN5LYrEOtOuaktSuPTXnjdhy+guQwS5oJzJw5c94
 T0vQ==
X-Gm-Message-State: AOJu0YwdDAbNh6wx5qN8gTfyCOKVFG28zCiZfBEdRMuCZ8pyXQ6ygMa5
 Tvl2WGWdwAuwu+488ru5xEYhIMC743aJgA==
X-Google-Smtp-Source: AGHT+IEfh1HSA7fx+efv2SbfnWcj7NlpBJHGCE70rMfklVfDZwyA5O95PGnTLt2zMK0U+tR54N+0OQ==
X-Received: by 2002:a05:6214:d4d:b0:67f:5dc2:a4a1 with SMTP id
 13-20020a0562140d4d00b0067f5dc2a4a1mr141260qvr.105.1703185362256; 
 Thu, 21 Dec 2023 11:02:42 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-550c-6b1c-99f9-93ae.res6.spectrum.com.
 [2603:6081:7b00:6400:550c:6b1c:99f9:93ae])
 by smtp.gmail.com with ESMTPSA id
 v8-20020ad448c8000000b0067f056e121csm810095qvx.97.2023.12.21.11.02.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 11:02:41 -0800 (PST)
Date: Thu, 21 Dec 2023 14:02:40 -0500
From: Tom Rini <trini@konsulko.com>
To: Enrico Leto <enrico.leto@siemens.com>
Cc: u-boot@lists.denx.de, Alexander Sverdlin <alexander.sverdlin@siemens.com>
Subject: Re: [PATCH v3 4/6] siemens: board: clean up draco products vs common
Message-ID: <20231221190240.GL2513409@bill-the-cat>
References: <20231218085915.3739975-1-enrico.leto@siemens.com>
 <20231218085915.3739975-5-enrico.leto@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7Ur58IwEjV/uq6Qx"
Content-Disposition: inline
In-Reply-To: <20231218085915.3739975-5-enrico.leto@siemens.com>
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


--7Ur58IwEjV/uq6Qx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 09:59:13AM +0100, Enrico Leto wrote:

> The common folder was initialially created for the common parts of the
> products based on draco-am355x board family. These are the product
> lines 'pxm2', 'rut' and the base line named 'draco'!
>=20
> Adding the new capricorn-imx8 board family, common was enhanced without
> cleanup.
>=20
> Move all am355x specifics to a new file 'board_am335x'.
>=20
> Reviewed-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> Signed-off-by: Enrico Leto <enrico.leto@siemens.com>

For this series, I see a few different failure to builds now:
https://source.denx.de/u-boot/u-boot/-/jobs/759652
https://source.denx.de/u-boot/u-boot/-/jobs/759653

--=20
Tom

--7Ur58IwEjV/uq6Qx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWEi8wACgkQFHw5/5Y0
tyx5eQv+ITfqVHS3grw7FIq1LTjS2pO2H4AeJNRRQ9KebfvWzFTyvCH+rkKg2Li6
Vha0O0iBB0rhsyOz6p7aFq4dXwm2cDJtNw9kCJKgi0i8tr5ENocXqUY4G6INwezj
DxgAFVMooCsFUYQXXY28kCCNjy9BXFZWX822oX0sKm5AoXmWmPEoKr9LYLbmTuaN
Re2mIyOxJ9Dbk5sPJ0zmj2o3Y+l6051xYWqBNlTBMI73WcQgFWGcYF+1r1kmNUNB
K/Wf1ZpY4DNNWhjvdYzBzROHtXZzp/JP3hePZ6Txhli5TrUy8/cssdglekNiuWKq
OMp8byJRRhn1FOGzBvXV5iKy8j4AO+e563VycEqKl9WsAdE+JiI2PdFPNjMIE5OC
sI4F/P+0Tkgb5By0e/KP/BpkLIzAPtGkg3D+aNOgjJjeTKQtx6pMd3dfByQDE/Ev
cL97byCS8+7f5Qgyx3A99RpHTIB0d6N+PCWlokD6pjZqQPbn7bSMBICnvGc+nbZo
2vB668x+
=g4Zi
-----END PGP SIGNATURE-----

--7Ur58IwEjV/uq6Qx--
