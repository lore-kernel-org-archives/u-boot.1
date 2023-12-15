Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05F86C35274
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 22:49:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED46687C73;
	Fri, 15 Dec 2023 23:48:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uGXL+hBH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D20BF87C71; Fri, 15 Dec 2023 23:48:35 +0100 (CET)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B06B587C6F
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 23:48:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-77f642b9a22so177690785a.0
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 14:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702680512; x=1703285312; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ca7ZxgNc5oNTpqAc0gnUHS2hFSlgV15Z4o2RE9GHoQs=;
 b=uGXL+hBHASVeRmWIoj2sVXYZWRimHYQL9dXKvVfGK1fQU3uTAdcZ2oEg3Vz8zmijct
 H1UiMnJwFsFLErN+GKj2V77Tt7qmCGFHdjEhldGxLo7wg+uss9dPy8idCZjsrZQTYpqZ
 FT5uJQFybu53tq3JPgn7kAv2qWoM6pcGc3flo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702680512; x=1703285312;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ca7ZxgNc5oNTpqAc0gnUHS2hFSlgV15Z4o2RE9GHoQs=;
 b=r6JrBHJEXauVKZ3cMUuvpE3fOjDx1yiO5C2WYd7v3mNUAIR1BgaPQsVkihadsiSMNC
 0h+dOUoXUnWmB85QvWJ7TAWjw2aM1d7n0YYG8ngjs9uWgc9CHVmdvcjq4qUZu90AhUrf
 I7CawsryXI2DrT5bp8dwae3aye9pPBoPwtmtpBX7ROuhhOjzzRrhhDesxWho0p8lBRMS
 /yOrIZNK0xRLR6irghOVaIoJDozrR/rVtGw/s3w0Av2KZER9lAySqEfz9YuquHAOmRUR
 jz7FISs0RXgaTUQoINhzshmTpWWCCRxg3f6XyOCUFw+KPx4RV13Qeb8ktM92cKBKK3U/
 82LQ==
X-Gm-Message-State: AOJu0Yww2+CM97zHyVkBxKzKxCp2D/6ehLJxgeBf4MDmQmCeMs6lGnvO
 jPCWE623iEA53nu9U4c1n0Rnsg==
X-Google-Smtp-Source: AGHT+IH17eEV3MSQ8tOzfNFaASFIdpQawVQEItPjlBDDFwZGn3ffvAptPQd3uAmcblX+T+P7F0fbYQ==
X-Received: by 2002:a05:620a:454d:b0:77f:3740:8e50 with SMTP id
 u13-20020a05620a454d00b0077f37408e50mr22662979qkp.74.1702680512557; 
 Fri, 15 Dec 2023 14:48:32 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-4efc-63ef-4955-a8ab.res6.spectrum.com.
 [2603:6081:7b00:6400:4efc:63ef:4955:a8ab])
 by smtp.gmail.com with ESMTPSA id
 az6-20020a05620a170600b0077fb0ba0f35sm721514qkb.90.2023.12.15.14.48.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Dec 2023 14:48:32 -0800 (PST)
Date: Fri, 15 Dec 2023 17:48:30 -0500
From: Tom Rini <trini@konsulko.com>
To: Vishal Mahaveer <vishalm@ti.com>
Cc: u-boot@lists.denx.de, Vignesh Raghavendra <vigneshr@ti.com>,
 Bryan Brattlof <bb@ti.com>, Praneeth Bajjuri <praneeth@ti.com>
Subject: Re: [PATCH 3/4] board: ti: am62x/am62ax: Update MCU GPIO interrupt
 allocation in board config
Message-ID: <20231215224830.GJ2513409@bill-the-cat>
References: <20231128194024.20809-1-vishalm@ti.com>
 <20231128194024.20809-4-vishalm@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+aPFx3flwb/XUgtH"
Content-Disposition: inline
In-Reply-To: <20231128194024.20809-4-vishalm@ti.com>
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


--+aPFx3flwb/XUgtH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 01:40:23PM -0600, Vishal Mahaveer wrote:

> Share the MCU GPIO interrupts between A53 core and DM R5 core. Allocating
> 2 instances each to A53 and DM R5.
>=20
> Signed-off-by: Vishal Mahaveer <vishalm@ti.com>

Applied to u-boot/next, thanks!

--=20
Tom

--+aPFx3flwb/XUgtH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV8174ACgkQFHw5/5Y0
tyyevwwAumNmTkvM8F8ICy/vl04dD3onzgNEk8+3Hy9xYjqfOo4QKwZ2Qj3IWp4k
EkL3zdjrdFPPst5SgEDMfjeHx5iAJEUgQkHSqbT8apDO+xCGJaQLIpRfSQUJdgsy
rK+dubl3mW5s9Nl+ZsKi4t5KkwVU0jfZecJeFP3UwPcqwBREazTyaQgcKhlA3x0T
SVbbUgKQw8wdQvgfNLmgyaot4tINsAaotszq5Zqf3ViX/7J24f7b7aiRQk4lYEHN
E/j0ZhfJXITQKhBtP52UL4X4OUeSdnn6lDRpNJOpYDUQbJhpBvjoMmDsE4y4a8xU
yUmcDBF86OaEcodjyOwzB3bhmPtvWq/b3vfIRW3vLOh25SZPoDSVKVy9yTRTRp4a
6IWIBCfRv+v6YIIeqmcR8trxtW6pyP0epMu5m7QbYfd2LJtYPjEF/3K4wsngM9ty
Yku8ALnIqoGHIDqqil4aNMZ3xyRKPe8ATrR4mjKQAbkXBw/0ePsnO7XfxcVum/rF
IMJliaaY
=32gH
-----END PGP SIGNATURE-----

--+aPFx3flwb/XUgtH--
