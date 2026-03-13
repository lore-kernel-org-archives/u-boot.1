Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52724107BCE4
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 21:03:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9DE68430A;
	Fri, 13 Mar 2026 22:03:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="k+w4kob1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98D4484324; Fri, 13 Mar 2026 22:03:07 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17A9B842DF
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 22:03:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7d75ed779bfso2752079a34.2
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 14:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773435784; x=1774040584; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gwPTpfFkShPwnjJ7MI70avYcGEyE823I9Bu37lWJRS4=;
 b=k+w4kob1E2G6avhTfuThbdVp9LcA+8PLlxL6nWkHta5dt129oIRIvoxyV2N72CWytw
 PhCwwSFqABv2VhFL6WWEZSxASx82zYVUHvZPLdrDqn6sQ6w9sJWZpNbWrb4/YMy7+ARi
 NG+RLlDTkuY36Mpf0jGM99FZ0nUpf2+nI8MsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773435784; x=1774040584;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gwPTpfFkShPwnjJ7MI70avYcGEyE823I9Bu37lWJRS4=;
 b=FNZnr8Ev0a9BhhQTtZRfgscgeuKOOD7oFT5YxUrErepGiFLp9EBgOl3VVHqq0+6ii4
 AHwQJXki83QqbsaEgt8g9D0tuyGEF38/1zrkkdyBR97Zi5gaiVNYk9EiN17OJu3S5BBS
 YgvkA3a3DXJGIK46E3w7FAGg1usNaOL6neUap5wv8ZgPnhu1fLlDK9ZpmfE6Q3ZTiKJQ
 BSGHdJ3jX7bA0+lnytgCuSLM+dMY4w+mFFkGFW8AgPNXlWHIj/G6tTDFtWxZx/adJCJf
 blWW8tl3mR9+ayQEP0aDA3Ij8FfIgZ3GtOWAlJiBmoo1M+wHKAEb+CBdSFWrYpQOlzyK
 LQdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHPLu/TIvTuGVnYE2RzfoZMPHLrIWZIId8dKgTqWqfaPpRa9EojFf2wjZKU1+GTXDWW4d4z+w=@lists.denx.de
X-Gm-Message-State: AOJu0YwIFTlpsFc6vl3o+6NPQ19Mx1dlrmvAYSjvJXt1vXM1V4wzDloh
 Air7Vv92ye+S8NE3uu9tk9Mm01tZaH8Oe0MHTP1i4z40SpPVl3YLxgnyXb3uviPH714=
X-Gm-Gg: ATEYQzyzGXszLBWJrOw4ZD7oj8PSs0X67XD2OFVRLhnjmkVx4PYYzud6Bdz+N0jW4GP
 UCxVHKzu4MssTopYOh2aWgYhdSvtE7vO2qQZnabcW4uvpXbrmTn49Bta+PFgsGxqc9Qj+wqBrnX
 cl7kIn4JPD1AbYjbU/be9f8O/RyYODbEOw4qlRd3ph9EzpfcjTfFjCkjsk9zA4Uy1qiuthUu/JO
 jYnRVAeSMHtT2RD2vm72zDa8n4P8e8TV8zIBdH4jxu/PscBIyxxFjcb7ujeOAUB4TxA6wzg0vgX
 sIuNSmnzfyauCosGjcA9X93ZSpVaPTbAgS6aP4+iSrGGr3tfT5EFg8P2zBdPS1v7TlhwWh/SkB+
 lvgPngSb3nyCK6m0wbnZDH3x2aHU8c9n0NPxqpUd6xH/4Z/3lWIfXml2HQn0yULTSrvKQafMDL5
 sh1u4WoFai3MiRY/gUdsrn3uT9/PTEnL9RV4nEIjXhLDluEjOVistcjU85RLXhniGkZRycJ1mH+
 85JVsow3ada/2SAqVGzfO7V9FXGnz0vvg/5Far15rWsGG+q
X-Received: by 2002:a4a:ee84:0:b0:67b:a489:3b72 with SMTP id
 006d021491bc7-67bdaa76b8bmr2620436eaf.64.1773435783657; 
 Fri, 13 Mar 2026 14:03:03 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4177e1fb90csm9693104fac.4.2026.03.13.14.03.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 14:03:02 -0700 (PDT)
Date: Fri, 13 Mar 2026 15:03:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: peng.fan@nxp.com, uboot-imx@nxp.com, u-boot@lists.denx.de,
 marex@nabladev.com, Fabio Estevam <festevam@nabladev.com>
Subject: Re: [PATCH 1/2] doc: imx95_evk: Update Arm GNU toolchain version to
 14.2
Message-ID: <20260313210300.GH502704@bill-the-cat>
References: <20260313210005.781958-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+4F8j9cAWaPoMhkf"
Content-Disposition: inline
In-Reply-To: <20260313210005.781958-1-festevam@gmail.com>
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


--+4F8j9cAWaPoMhkf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 06:00:04PM -0300, Fabio Estevam wrote:

> From: Fabio Estevam <festevam@nabladev.com>
>=20
> The imx-oei and imx-sm build systems defaults to:
>=20
>   TC_VERSION ?=3D 14.2.rel1
>=20
> but the documentation still instructs users to download the 13.3 toolchai=
n.
> This causes the build to fail because the expected directory name does
> not exist.
>=20
> Update the documentation to reference the 14.2 toolchain to match the bui=
ld
> system default.
>=20
> Signed-off-by: Fabio Estevam <festevam@nabladev.com>
> ---
>  doc/board/nxp/imx95_evk.rst | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/doc/board/nxp/imx95_evk.rst b/doc/board/nxp/imx95_evk.rst
> index b8c3f4bed500..e87d7e27b618 100644
> --- a/doc/board/nxp/imx95_evk.rst
> +++ b/doc/board/nxp/imx95_evk.rst
> @@ -60,8 +60,8 @@ branch: master
>  .. code-block:: bash
> =20
>     $ sudo apt -y install make gcc g++-multilib srecord
> -   $ wget https://developer.arm.com/-/media/Files/downloads/gnu/13.3.rel=
1/binrel/arm-gnu-toolchain-13.3.rel1-x86_64-arm-none-eabi.tar.xz
> -   $ tar xvf arm-gnu-toolchain-13.3.rel1-x86_64-arm-none-eabi.tar.xz
> +   $ wget https://developer.arm.com/-/media/Files/downloads/gnu/14.2.rel=
1/binrel/arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi.tar.xz
> +   $ tar xvf arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi.tar.xz
>     $ export TOOLS=3D$PWD
>     $ git clone -b master https://github.com/nxp-imx/imx-oei.git
>     $ cd imx-oei
> @@ -100,8 +100,8 @@ branch: master
>  .. code-block:: bash
> =20
>     $ sudo apt -y install make gcc g++-multilib srecord
> -   $ wget https://developer.arm.com/-/media/Files/downloads/gnu/13.3.rel=
1/binrel/arm-gnu-toolchain-13.3.rel1-x86_64-arm-none-eabi.tar.xz
> -   $ tar xvf arm-gnu-toolchain-13.3.rel1-x86_64-arm-none-eabi.tar.xz
> +   $ wget https://developer.arm.com/-/media/Files/downloads/gnu/14.2.rel=
1/binrel/arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi.tar.xz
> +   $ tar xvf arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi.tar.xz
>     $ export TOOLS=3D$PWD
>     $ git clone -b master https://github.com/nxp-imx/imx-sm.git
>     $ cd imx-sm

As this is no worse than before, OK. But we should really be globally
consistent about toolchain wording and that CI runs with the kernel.org
community toolchains.

--=20
Tom

--+4F8j9cAWaPoMhkf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCabR7gAAKCRAr4qD1Cr/k
CllXAP98Rk7dTdm4aGprPgH+/Uk69uqfnGgQAY06k/7fTaWxrwEAl8TpsHBIpiU1
bs67SYewpYTq/bkXmcF79gILuFG7KAk=
=Q1BJ
-----END PGP SIGNATURE-----

--+4F8j9cAWaPoMhkf--
