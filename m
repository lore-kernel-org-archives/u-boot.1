Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38642C5B543
	for <u-boot@archiver.kernel.org>; Thu,  5 Jun 2025 16:04:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 421ED8091A;
	Thu,  5 Jun 2025 18:04:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bI1/m6Kz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F7DE81E25; Thu,  5 Jun 2025 18:04:33 +0200 (CEST)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC6B280050
 for <u-boot@lists.denx.de>; Thu,  5 Jun 2025 18:04:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-3ddb5f6f008so10977395ab.0
 for <u-boot@lists.denx.de>; Thu, 05 Jun 2025 09:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749139469; x=1749744269; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sQ5qdl8UX4H38ZmmMt43pZwqJf5ecdaHMa7RoMW/v1M=;
 b=bI1/m6Kzph7WPRID4KF6iePSdzDcLAPRZS++uoGd42KI6/QCQtwUctbDDV6JtFw95N
 PoW3/LzcU2UETgjdd455kmwgiuYsETpuJ0LOdK7+Q4zU6GdjU6JBuZHOsi672JF+0E7Y
 BmsBWxKSwfp5F+FeAIn75BgcIR4KeJ8KqhQik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749139469; x=1749744269;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sQ5qdl8UX4H38ZmmMt43pZwqJf5ecdaHMa7RoMW/v1M=;
 b=b1zTGyfDk3/ASLupfKo45Tihnzznfbbvg0cb5UoZNL+/R12ufgXF1JwFVJhLmP3aZq
 f20kIeEqsNwPr7BGr6qhJFHpkL+O1rr0nFm+wOlRYkU4hyD4Cm2tqS12eJzBxaFvj/Pm
 tB0AeAboz4Z5DUJQKfYDdtOdQ81u65AkeKbEfbO8VfTASlzPmimL6x11XZrOqB6bwDKZ
 AQ8BIgn3hhj1py4nEXAgDBtcwAQiW7xhH3FK+LLgHrQ76kSEfKkUeEIhyf0s9SBtm6Be
 U2CRw3VgBv1bVmI5ttRzokKTDiVl1wit8K8tNkfUl0C95XH84/hdbSEggwJ/puvbeiHO
 FHTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWStvWKWC9ZZvjaU5ap6Rymm53VDkPTssCWVffgqtrLXTHzbCjgn+XM+yvBTNLY7CU/74DkQQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yw771/fJdd0cdMB+nK5nZ+gBdmv26EYbUtIkG/z0qLnp8OSjlZ3
 2HNulvB9SOD6rUFIqcztJe+2XySZDUql2RroUNceKlXVeelvxujBYRh9uta+0R3cpeKmb/SkE++
 4Svo866U=
X-Gm-Gg: ASbGncucoHMoapw5RAAJdL5SQGzZm8Up42KkH2JG4zG1rIwHT4Rxd+mpSdfNIvqcTag
 hPQQY44lJRg1kiKizyHjHhKygMCqx/Qe02GQ7c8cubpQmN4vc6yAquaU9pZrniTizf/CKQtyWLm
 cjk3NB9oNRc9EgbEY+8ngj7Vh5xQO6YrflwKbFMskMdl/cIoPxIuf55m/w/Bmx5uOrx5BuiCCtO
 oj0xELewniR3HbDwqwWtnffLZkxsMAQ1GB15vOvkFv03m6k+uBb4RNISiM+BwIKok/jmSOLmD4a
 klM2NBPafzwEmdhaIY0Q7uBiiI3je9/TKppMb6e+dg+a5YcGyC8B6p91eJu5ueMtb3W60wsc31u
 XcTexZ+mFiFlujOsRvR5LZZKREERkqu5hKg==
X-Google-Smtp-Source: AGHT+IGW7AjUexlPZnuhBkJ1fzroxDMOauqPbXl38Y2SfbolPCbrr9oQEnI+aD+Cnk3DQVIPntB6iQ==
X-Received: by 2002:a05:6870:a7a2:b0:2e9:7e3:933f with SMTP id
 586e51a60fabf-2ea00684093mr55973fac.3.1749139459149; 
 Thu, 05 Jun 2025 09:04:19 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2e906456892sm3142838fac.7.2025.06.05.09.04.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 09:04:18 -0700 (PDT)
Date: Thu, 5 Jun 2025 10:04:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Martin Schwan <m.schwan@phytec.de>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Wadim Egorov <w.egorov@phytec.de>
Subject: Re: [PATCH v3 0/2] bootstd: New bootmeth for RAUC A/B systems
Message-ID: <20250605160416.GZ1382132@bill-the-cat>
References: <20250604-wip-bootmeth-rauc-v3-0-f9fad913c57e@phytec.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="R2baNZbjUQJuieRX"
Content-Disposition: inline
In-Reply-To: <20250604-wip-bootmeth-rauc-v3-0-f9fad913c57e@phytec.de>
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


--R2baNZbjUQJuieRX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 04, 2025 at 02:15:28PM +0200, Martin Schwan wrote:

> This series implements a new bootmeth for RAUC A/B systems. RAUC (Robust
> Auto Update Controller) is a lightweight update client, providing "Safe
> and Secure OTA Updates for Embedded Linux". See the following links for
> more information about RAUC:
>=20
>   https://rauc.io/
>   https://rauc.readthedocs.io/en/latest/
>=20
> PHYTEC uses RAUC in its Yocto based distribution "Ampliphy" as the
> default way of updating embedded devices based on PHYTEC hardware. So
> far, the logic selecting the correct partitions and files to boot was
> being implemented in the U-Boot environment. While this is a
> straightforward way to do it, adding and supporting new platforms became
> somewhat tedious and is platform-specific. The introduction of U-Boot's
> "Standard Boot" provided a convincing alternative, promising a simpler
> and more portable way of booting, even for RAUC systems. This led me to
> implement a new bootmeth supporting RAUC A/B systems. Note, that this
> new bootmeth is not proprietary to PHYTEC products and is designed to
> work on other hardware with a RAUC A/B system, too.
>=20
> The bootmeth currently only supports symmetric A/B partitioning layouts.
> E.g. A/rescue is not (yet) supported. The partition indexes and default
> slot tries can be specified via configuration options.
>=20
> For now, the bootmeth_rauc uses a similar approach for loading the
> Kernel and device tree as the bootmeth_script, in that it requires a FIT
> containing a U-Boot script loading the desired distro. It could be
> possible to support booting without a script and load the Kernel and DT
> directly with this bootmeth, but I found the script method to be very
> flexible for now, in letting the distro decide what to load.
>=20
> The bootmeth_rauc was tested on a phyBOARD-Pollux i.MX8M Plus [1] with
> BSP-Yocto-Ampliphy-i.MX8MP-PD24.1.2 [2].
>=20
> Supported boot devices are currently only MMC devices, but it should be
> possible to add SPI flashes in the future.
>=20
> To test this patch stack with PHYTEC's phyBOARD-Pollux i.MX8M Plus
> board, you need to adjust the boot files to include the boot.scr.uimg
> containing the distro's boot script and set "optargs" to "${raucargs}"
> in it. Also disable any legacyboot in the U-Boot environment and simply
> boot with Standard Boot:
>=20
>   bootmeth order rauc
>   bootflow scan -lb
>=20
> Regards,
> Martin
>=20
> [1]: https://www.phytec.eu/en/produkte/single-board-computer/phyboard-pol=
lux/
> [2]: https://download.phytec.de/Software/Linux/BSP-Yocto-i.MX8MP/BSP-Yoct=
o-Ampliphy-i.MX8MP-PD24.1.2/

I'm really glad to see this and I will take it in to -next once there's
been enough time for people to have a chance to offer review comments.
Thanks!

--=20
Tom

--R2baNZbjUQJuieRX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhBv/kACgkQFHw5/5Y0
tywKawv+MtnmnapwXREQiHD8nHNfOcX6XzsvCeQTUvVoElQ1wTFA60tK+38EPk7F
jcOyEQ75ZeKZvhsoPteoMloAYmiT9u+/uEc4MHiIHbYq8l/rVNnG1C+QTxZV60yG
JUBNcLllL+6NQXByczhfqc/oOn1zYDIMeF5OoCYoef9oaGqr1FQxlqiavtZqto6H
vJZJhjA7mP/o1gfYxjP3rJ+MiaPOaBj5Ji2VnHfkJJvioqX1DQBKe+bcq2WWx2Qz
boICIxyxHBPWUPcoSmJURYk7HPAsYt+FQupnpfnVQHiqfLq0t+qIlBO2ysgZtko+
ZYCHsZEWI1z1G9QibGkT/9bZJuOFpXCTsxRVMAsVjaYO3C9OSR860UJJx2Oaprkx
IGw7TDsC9lY4XBmsbxQrOxTU5UJwk5L3vZRZ36hdin7CdXnqhPiGqixfrAPdEI4+
OVkctKwirYfTsP/MgPOqdaRPJGdVZ4CpYSVMRk/Pol01ksoU4m55SUXTg9Dpm0qX
9cc9wzLX
=iNH4
-----END PGP SIGNATURE-----

--R2baNZbjUQJuieRX--
