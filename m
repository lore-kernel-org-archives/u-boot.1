Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6012C71141
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 18:56:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C847282C2F;
	Wed, 11 Jun 2025 20:56:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qr8HDtJb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5E9A82B97; Wed, 11 Jun 2025 20:56:52 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79EEA828A2
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 20:56:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-72c172f1de1so101886a34.3
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 11:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749668209; x=1750273009; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Fma1aF54frahApSOiQiHMe91ieQK8uE8Oc7C1DZir0E=;
 b=qr8HDtJbjT1D49f6n8QLzHLotKtvlC9SOpEE147pi9RyRQ7KPlep+O+iBs2YFqQDxD
 akqUQ/dwqCAvWp4BTmfg2u1gXyecPVmZyjhHYnjfKN9mV8jb74bEKxQRnhy1flRMdxGM
 z8DAs4ALVwquxMpDZRtwqNP5XbwjH8+43huYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749668209; x=1750273009;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fma1aF54frahApSOiQiHMe91ieQK8uE8Oc7C1DZir0E=;
 b=IRJzpxPhUnYMzWJ7i6PMr8ssuJr1D5xCy7PZdBNdz/SxnEjYxO/hpMYPWo86QO+0MR
 QMNX8AALlQDd49kp6kVddtmarsoFYJpX2NvJEN0z1SW0WZHtMdDzxK8llbKuItIsAbq0
 oDm+A0do5T7cGMF2A4mza09xtYvF3O25cY/dGDEDVag/p6YeeCt8O2bPWztWkR4go8TH
 qscpal4dEkl13yd/TCA3Nq6NC/BjwHjguVAC4k8IiQe9n/lv4iCmDCkRc1PVMBW2GfQu
 ilW5kcoQSOgWiydBmVtPoLxNiZNKYCUfsCRh/xAuEO+1H3xqCa7kYATxNk6gWf7Wds52
 oTXA==
X-Gm-Message-State: AOJu0Yy1xidYnAxjALXajUICk8KFaUr5997CuOyqfg94d8NChmzbnH7v
 22lAqVqU3LggpjcuUzDuAFuimPkzCEIynXePlgmf1R//K1x+hIwHvxc9sSTewayRUCM=
X-Gm-Gg: ASbGnctMkDfss/xWUs2uTDyAwBX9H4ONeszhYavsiyX/KVVB6yedNtfNBodn3rw5okL
 51Pk9lVbbntrZdyYJmUg6T2qHPBycJIoYu/pO8bKL8dZBDOOAIk9z6xJ0aqGC1X3LIMjgMPl24o
 viVcf+9sEJAfn18X5ltnkwaBnPCvQNJPS1nQa1fWqxfJT1e2uGGtQJhcokVC7j/vyGERBozBD6a
 jiVv94w1BGLkKw/zjvKAN0fvlDc9yAc3bxCcDJVj+Uq3fHf8Z4sWDLfwgZbnxsMKqAF2+Ox9Vn6
 LUhMV7bZXN5y4z8lYZ3gFThVPScr3789D2w15QmsWfWcbhYuDNe3KqUMbWoZznTtwW57ypUFy6/
 /0Nfs38+JTtQuWh/MwkJ8hEZGpjAMfAiXDA==
X-Google-Smtp-Source: AGHT+IGCzqc0L/jC8rmtm1ykVvgG+tA4t35yXr/vqZmlTLW7xCAo0IUBLYunM27qTp0vWq//yvIiCg==
X-Received: by 2002:a05:6830:2c0b:b0:73a:102:840a with SMTP id
 46e09a7af769-73a05f625fcmr2746602a34.28.1749668209233; 
 Wed, 11 Jun 2025 11:56:49 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73a06fdf538sm409141a34.26.2025.06.11.11.56.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Jun 2025 11:56:48 -0700 (PDT)
Date: Wed, 11 Jun 2025 12:56:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Gabriel FERNANDEZ <gabriel.fernandez@foss.st.com>,
 Marek Vasut <marex@denx.de>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 Simeon Marijon <simeon.marijon@foss.st.com>,
 Valentin Caron <valentin.caron@foss.st.com>
Subject: Re: [PULL] Pull request for u-boot next / v2025.10 =
 u-boot-stm32-20250611
Message-ID: <20250611185646.GJ1382132@bill-the-cat>
References: <65e007f8-fe6b-4fc4-ae88-9f6abd4d554b@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="c76C4t2JM+z06PrN"
Content-Disposition: inline
In-Reply-To: <65e007f8-fe6b-4fc4-ae88-9f6abd4d554b@foss.st.com>
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


--c76C4t2JM+z06PrN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 11:35:34AM +0200, Patrice CHOTARD wrote:

> Hi Tom
>=20
> Please pull the STM32 related patches for u-boot/next, v2025.10 =3D u-boo=
t-stm32-20250611
>=20
> https://source.denx.de/u-boot/custodians/u-boot-stm/-/pipelines/26607
>=20
> Thanks
> Patrice
>=20
> The following changes since commit 59d00e20fced23e6463aa09db889dd548baee6=
77:
>=20
>   Merge tag 'v2025.07-rc4' into next (2025-06-09 16:28:28 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-stm.git tags/u-boot-stm=
32-20250611
>=20
> for you to fetch changes up to 40c158933307d8977d9d7871ab1c8d1415a6bcde:
>=20
>   board: stm32: add stm32h747-discovery board support (2025-06-11 09:42:5=
6 +0200)
>=20

After re-doing the dts/upstream parts to be cherry picks from
devicetree-rebasing directly, applied to u-boot/next, thanks!

--=20
Tom

--c76C4t2JM+z06PrN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhJ0WoACgkQFHw5/5Y0
tywOHwwAs35X0+axfWIdoB5CqX1qR0vZGgDOW8UXtT2YY8uDv46W36vPvlO8utzY
IvbSkTbrpCRDYD/xCr8FbsTrCrzNcWMhAXRx8dvdpnNTwnAP1Hziie9EkO1gFxZk
y3SMTzMfp+4/pr3tw9S7Y0hw/OM13UFXy5rh2SI8oGJwD57BiRMfphkQtHMbma4W
gbJz4Q46uUm/0C0ShH55nsBxHRw0S2m+wVGzCXTtiXFSsgFmcyXU2oPxIAgcaGhR
DknW8L+wVdPGbhPIvc6IYNA2uWu5qhYD194ICF8ZgrPdTriAEDmX4RKdLtCyVHoj
cCOOnsjNbIu/JNrracPoTm7/bqAYGWJK8lKH4J9tJLZybXWydOc7AHPW+DtCTft6
G6TS8mhn0I2TkxcKYrsznm3jQxP9xsmsD3v4bIOPgpOP+QYUpgEqfO7g9CPDHcrB
cG4ttXa72wcnkXbpwLmzJ4pIBaTwxm+UU1ya3O2rByq59jQqSkhT5JXC7R7t/Ore
M0vTNGVR
=0iBj
-----END PGP SIGNATURE-----

--c76C4t2JM+z06PrN--
