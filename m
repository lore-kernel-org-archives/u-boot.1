Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53433C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 13:59:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B87F78144A;
	Fri, 28 Mar 2025 14:59:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="og0WWDdq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBA2981A0C; Fri, 28 Mar 2025 14:59:35 +0100 (CET)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7B708070C
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 14:59:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-2bd2218ba4fso770418fac.1
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 06:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743170370; x=1743775170; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=aHUxbwNmuUph9lFSgtQWsJhIBJEx5dIMMxY1d1/QmVM=;
 b=og0WWDdqC8G4OCVHBzwGB7B6UYjNa906U6NdNuptNkFJcbmItwj7Vrbtx8pzmeLg7I
 QK1vCdy5Q8Akbz5rGUkl4Hk6tGLvtQF85Y93GNTkHpTw0WzM2sbnLtY6TegRM237KglF
 3D54ipEJCvUuMmQvGgUkCtRobhaUA9c1yWVM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743170370; x=1743775170;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aHUxbwNmuUph9lFSgtQWsJhIBJEx5dIMMxY1d1/QmVM=;
 b=RcbfeVNCg55I8wtZXRgGSeUkMIXJwwcvlOkbVSFQFNzSnIxeGcyJuXQYT3cm0AapGh
 DrLagATe957PVQT9xxAYjty3YKWvrzTolbikC6uC6aFQrkMDaOcYDUXCLjqiLmR5Ug9H
 81toelI26/Eqgd8Ltyqrk2jrJVRLe9msJjpgEh5SYyy71iU/beohALNpfbHD71JYKwgt
 d2rQlOgYHz3chLkSxMVTxjuyg/jvToEt2bgFyIwoqU6FyXLwsu0uucoGNbbJad50U4uL
 BaAIkgJjh/xpLRwpfbjGQUX3lAwF7zKaCBFfEFMUu4s+jIZDOc6ij/ktcz9zz1HxC5JF
 REYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOy++uF+mvKCfh2Bf1IZruqPs2uBnN7SoFMyUDuahlXCHHfp+CoyJfBG9RaF+2MQO3b5d6HEY=@lists.denx.de
X-Gm-Message-State: AOJu0YyN95OrbBblgGNoiqFxFHrOKrjRhKgJoqtz+Oe1shTnZaquRVJk
 gSOPRTYzfOMxjNpMLXhcf2qgxg4JDsglg56w7KD4b35tcq9HIqpgoQiNt9DWKqo=
X-Gm-Gg: ASbGncsRoBzvKFDQ00OGnAzktbqhamenRlRdPh3kb7HJkmxG9tZiVdjRh5GHBTU7mMD
 FKqsZkundNbv6vTTcNcpkNgFZz92icvSuuQSItdSLyv88WlToEkEazxfSDwsjuQbrj6tNItTpzk
 pLHEQ0iGd4il7HZBooZ3MIN+Vqo7M0MTkxUl3J5u1dRz8PhlvdUJyWKhYxSedQa42EgulFKBok7
 gkWPu7JsL1fC/IzsQd5dyIPliCmGNxRfxHe3Gqd3/sG2Do0+sH6BZGgp5Xe0WFJBub/wB12vEpF
 u7GOzZkEacXHyetrPjtA/5k1sKq0dxYu/itxwK7986wlM1yi/WuOUY05MyAKLZhRpDaE7Vir7i4
 7Nd8iSg==
X-Google-Smtp-Source: AGHT+IFfxj7zqH7RHfj989z5Yo0O6viZzHlMmKy7pSMSz3YtsENwqKqAFqljFDsZSNQiD5LGmiPNtw==
X-Received: by 2002:a05:6870:ec87:b0:2c2:c92a:579b with SMTP id
 586e51a60fabf-2c848032803mr4440947fac.20.1743170370237; 
 Fri, 28 Mar 2025 06:59:30 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72c58092ee8sm371736a34.1.2025.03.28.06.59.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 06:59:29 -0700 (PDT)
Date: Fri, 28 Mar 2025 07:59:26 -0600
From: Tom Rini <trini@konsulko.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Simon Glass <sjg@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Anatolij Gustschin <agust@denx.de>,
 Fabio Estevm <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Mario Six <mario.six@gdsys.cc>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 u-boot@lists.denx.de, Ian Ray <ian.ray@gehealthcare.com>,
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Adam Ford <aford173@gmail.com>, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v5 00/12] Add imx8mp video support
Message-ID: <20250328135926.GU93000@bill-the-cat>
References: <20250326-ge-mainline-display-support-v5-0-ea4bc3fc9bca@bootlin.com>
 <87h63fq0j8.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Qej0VJnsTyyxf0bP"
Content-Disposition: inline
In-Reply-To: <87h63fq0j8.fsf@bootlin.com>
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


--Qej0VJnsTyyxf0bP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 04:22:51PM +0100, Miquel Raynal wrote:
>=20
> > - Fixed the tests, again.
>=20
> I observe that the doc explicitly says that we should run tests
> (specifically the DM tests) using -T to use the test.dts DT
> instead of the default -D sandbox.dts.
>=20
> However Azure pipelines do not use the test device tree and obviously
> fail sometimes:
> https://dev.azure.com/u-boot/u-boot/_build/results?buildId=3D10823&view=
=3Dlogs&j=3D1b505e53-b56b-5aa3-debb-1f30f6ef305e&t=3Dd20c71d4-f145-577a-cd4=
d-4cd8ed956b7a
>=20
> Is there a trick to tell the pipelines to just use the test device tree t=
hat I missed?

Ugh, neither CI handles that. I think up until now everyone has patched
both device trees, or just sandbox.dts instead. And I don't really know
why we would have two different device trees here...

--=20
Tom

--Qej0VJnsTyyxf0bP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfmqz4ACgkQFHw5/5Y0
tyzQxAv/XOhFqvmFz2niyiDRDv7tlVMO0XlXbGKc1PIHImeAth2PPThuU8ac7m8E
epQIE6S3AKfs1IzuPSjcowg3HepyitnUANbwQSX8M/w4ItLk1A6huX+dBfHmfc4A
fcVYJ49qTWAt/3su8yU6E9UEDHMMY3E7+yYNrQuugYFCGw1puF6JrbkKMB1NW6q8
iWpH2vPEeRW8gg1o1dV+J+BMnUM7dJ0c1Z+f2NzgB/uMWFxA0SR3gFqKgSR2Wa6Z
OKoAmb5iQrscz9mi/TPqRHZunOIbfBWCTzoOskXB+nWy1Fq10fj3Z57QSl3afm2l
9zh3yvJB9lAGhghE53uuHZx6xFLWYqugIPsL8OIqKkhyrhUwuBdtYIvlQo3j0rx+
OJXLzz4+8H+bWdFBpEzFYSHQO5Bo1xeK5A67uvGZXCR/TmyPL+qgMEPp36BJTUDC
Kx3dvzuNnTov0h03HzfS9NAYYGziRHO0CuavuRtDP7/XgSKNqFoVZse+ARHzYNa6
5rX29Tg/
=fdV4
-----END PGP SIGNATURE-----

--Qej0VJnsTyyxf0bP--
