Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFF63CD4F4A
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 17:45:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA4DE83AA9;
	Mon, 18 May 2026 19:45:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Gi8qW8ME";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFA3483EF9; Mon, 18 May 2026 19:45:07 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92E4580433
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 19:45:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-479d37e7d7fso733803b6e.1
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 10:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779126304; x=1779731104; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+zvhgdn/L0qhJChcpOmRdYalgUyqRJhwDXKrj/FC0ls=;
 b=Gi8qW8MEvsq6gucKZoi4zjmn6QJ4lM1tN/3Kcknjfgq+ebZn0o7e/flhqNLQTm/g6v
 3WHF98+0voSuw58Yt1a+Q9pni8EytrMquGvJMaUtgCNBrI7RdvqK7QB9TySRY9GaVvzd
 GJqmHqWaxaUvReN2um8Rbco9v2otDVynbyzRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779126304; x=1779731104;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+zvhgdn/L0qhJChcpOmRdYalgUyqRJhwDXKrj/FC0ls=;
 b=U62spjj2IeDRFqrUs5WpRz+HWS0FeAZ3SKIfukXCL0cC3BT2p1OCRDySq0M76TyfOQ
 fNaI6vxHmMifu933riYPrmRDMw+2a7wtCJ5BguY0YDrRbDOIaLGnW8W7QxVSrLV6ASCF
 +Bo3lrYAcgD4Y21HbcnJUeEU1gFfx3FwziLtwy5kc1004JLzcd3ZbtTku4qltknFp++S
 k3NIoiWu0sRe+0EfzYyvV1LpM+bk+xeCDIgeE0o5WePlu8NBWQ6ZdPhQhJA2c4uGZbtz
 Zo4XEI85cozYB6sVnT1vOI4J05SM0BWxmN2H5Zjrmr/ebAnfVTZJiO7KxR9svqQjDSnl
 TOrA==
X-Gm-Message-State: AOJu0YzH0NgTi7CC0ieRpnYmg9pTNIg5VV3lNo05R8tafeZetvmF9ZUO
 c0qBdjIh7/rnILFLp2VxaADIy4eGVaSrJ7ZZg0gNYQV6D1HozJSkJJGPhCoh7BS3uyQ=
X-Gm-Gg: Acq92OER8h5Mt/920uILODuUSJsTCyl09ldtyj6DE9uAqd3oZ+JcJCrfE4MXA2hyrek
 L4RwCmOp1xWbtl7eb+oDdQf5pBDvyHLQe2DTxUv7FRSXJtni2hx9yH5D7ADdQcdl6D2JFlCP1lg
 zLmeMb1kcFMB2CslT9foKB8ztCmG5Xf0oO0JtVsa73LD2mCmsgRgnyIGcNwlILsambDP+a5stXX
 q+eWHj9WcRt16mGb8MMH7IqlHM6RE6essT5U1N0Hoh8ngvSMR0jlksTbx04dt5J5hSZD3Ox5aJz
 8lDqbyp+29ezZ1TieyWOMB1pllUXBVY0FkHM6xeNSAUcVVBpXrq6qOkwuZchW+3IRJP5yKRg8KB
 wHIl45H4fhEIFAMPF/aNVjbnOe2uC5XqbLuT18V3rj1mjwZqPyXDwVlG4axd4uxoXgGVrObhh/Y
 6F0LGRrCSNRlaX+KcWyWG7En4n/WelIsMrkSXEj5nsdc2eIOukxO4wzjNI4o7kULpMSXx/j1pfl
 8oh2WIo1VGNMIZTk3M40BzYPpXmwPjT0HEHATONEBokX/ML2z4OcfuJT5jhDg==
X-Received: by 2002:a05:6808:3c4d:b0:482:aebb:e7c8 with SMTP id
 5614622812f47-482e573983bmr9800550b6e.30.1779126304301; 
 Mon, 18 May 2026 10:45:04 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43a956f4957sm4919144fac.12.2026.05.18.10.45.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 10:45:03 -0700 (PDT)
Date: Mon, 18 May 2026 11:45:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Marek Vasut <marek.vasut@mailbox.org>, Marek Vasut <marex@denx.de>,
 Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Philip Molloy <philip.molloy@analog.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Stefan Roese <stefan.roese@mailbox.org>, Yao Zi <me@ziyao.cc>
Subject: Re: [PATCH 00/11] Move test/py image creation into separate per-OS
 modules
Message-ID: <20260518174500.GT1858239@bill-the-cat>
References: <20260517225122.2966807-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dcMeiRraROoDolWe"
Content-Disposition: inline
In-Reply-To: <20260517225122.2966807-1-sjg@chromium.org>
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


--dcMeiRraROoDolWe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 17, 2026 at 04:50:58PM -0600, Simon Glass wrote:
>=20
> test_ut.py has accumulated a setup_*_image() helper for every Linux
> distribution that the bootflow tests want to boot. Each one is mostly
> shell script and partition layout, so the file is large and the test
> logic is hidden among image-creation details.
>=20
> Move each setup function to its own module under test/py/img/, with a
> shared common.py for mkdir_cond(), copy_partition() and the extlinux
> helper. Each patch moves one image at a time so reviewers can see the
> relocation cleanly.
>=20
> While here, also redirect the generated disk images to the
> persistent-data directory instead of writing them under the source
> tree. The sandbox mmc, scsi and usb-flash drivers now look there first.
>=20
> Further improvement are planned, such as using the context manager when
> creating partitions.

I think this further exposes a problem / feedback I gave a while ago
now. We shouldn't have "distribution" tests, we should have tests that
exercise the various paths in the code.

--=20
Tom

--dcMeiRraROoDolWe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCagtQGAAKCRAr4qD1Cr/k
CjrDAQDicjh1XpHbbxir034rkZMDskdoG5fmbWiEqi1XIWcD7wD/ZRoYJ7O7NdI3
va9DazF4tm30cvVH6JaLVvHZTMGCfQA=
=vTbr
-----END PGP SIGNATURE-----

--dcMeiRraROoDolWe--
