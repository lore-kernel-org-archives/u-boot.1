Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62FD7C43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 22:08:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE23184CB2;
	Tue, 14 Jul 2026 00:08:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Q/aiOw1E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22BC584CBA; Tue, 14 Jul 2026 00:08:51 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0D7B84B73
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 00:08:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-4a458daacfbso999949b6e.3
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 15:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783980527; x=1784585327; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2zatpppT6ESxtGKyWzWKAgb2RJecBC1fdy7Tf9/C1yU=;
 b=Q/aiOw1EjhLcbE/5MfFZRigTdnY9Oq2zE2YPbgZ1lX//bEoMcR4kOXV80gxB+9TW7i
 oCdE/sC/oFN0sk+910JTCzpTRXFXKKPBuVxsHoEq8xi57bIYuFdaGlDyWsrl/IY2iR32
 k50+/jPVHdHYEi68cDBsDOjbuPCcOMJeeCq5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783980527; x=1784585327;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2zatpppT6ESxtGKyWzWKAgb2RJecBC1fdy7Tf9/C1yU=;
 b=bPz0SbLDwIhC516SErQeI4HqiKva/w0Je2KNNmZMRhl3FHJPn0b696T4hYPm+DWs9v
 e5leFtvdIJGtAauo4sUYC/eB22CV2M3YHsVmYyyOX4A+0C43IcyzjI+lNrZx5/iATprP
 sciyrsgJDCj+zXJRdaRZYmjTnTirmmnzF8MTJLp1P8OzDfgkpBHqYZSoScGq6PLifqOs
 1RZdhS18OsOYeULYjBryYCIO3myfyidkTx5ELgbiKTyz2gQjdX2F1/bOqsK2CDMzzlbI
 15GOQOBnrzUH+GattfJFbDmBLBfGXBGawWHf6i0nfOwDlGl7bjD4WH6JdFvk2Ks5Wbne
 arIQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+jJeglGoO1dJkRpHZktskS+akVIP3/t34HpCuOneJt8xYY25IyJCfNgb3nMLkIFCu5BqvkHXg=@lists.denx.de
X-Gm-Message-State: AOJu0YzELU2nqiUv2Zz7PvFLu0wYPgEER0+8R7L7uCJ4Ys9emlGxjj+j
 nT7dj7qGIKhoL9t8LbeHcoA8SbDVWw3SaV5argR6DQNrytM6MD1qAYlFwgep7kjQrLc=
X-Gm-Gg: AfdE7cmMIEQij9d9D7IUrTYk98i951BfeB3NXYLisdsEKuGsQSKHTDP3hI7SLXMlGsE
 DKDbCrX0MtpNQeKTxcV6AlhgmhvPC0wgV9iGj4KMgSZoF1E2+Y2Xkpy4DOzo/oDbdn6kTK3Vg65
 EaP1xLVHMdKsUtSjCliNdb9ou29xVOkZDI1WqnWqIfegidHaqaacKqlVF6c01Lge2tfeT399Gn9
 8Gb254eFVjbsMdtUg+PQC0VT3Qq2ez0dm0SKhxeSzF+Rih9EE9RYk8rFQVG38sIpVd/WcLFnSaw
 OQgjQmX3n8pO4GG+qHovKsbLjk5k6CRS68sM8P6szoTlM6AoYTZ08NlaaoU355ihrxcFx6IbO/t
 aEVrnOf9iq6SRK9HDXkav2KJTjPuS2sXSTAMf9qg9KvS3DPZ9IzKpKB/cXXvZUfraq9ePhrJF1h
 rc1jNWHEGJt7c6rOwIzE4BDDdT9F6RvE19/CUOe6KAne3nP3SZrzDPgpQQ4QpP40BHoylZzIX2H
 za7+ML+bkioE/hLqqp2yX5K9LWTtF/BuTxfVg==
X-Received: by 2002:a05:6808:344c:b0:4a3:fb6c:a3d0 with SMTP id
 5614622812f47-4a42ac4c499mr7879789b6e.9.1783980527167; 
 Mon, 13 Jul 2026 15:08:47 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4a1acc82f3csm12953386b6e.3.2026.07.13.15.08.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 15:08:44 -0700 (PDT)
Date: Mon, 13 Jul 2026 16:08:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Simon Glass <sjg@chromium.org>, Ludwig Nussel <ludwig.nussel@siemens.com>,
 Anton Ivanov <anton@binarly.io>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Randolph Sapp <rs@ti.com>, Francois Berder <fberder@outlook.fr>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 3/3] test: fit: verify dm-verity roothash is covered by
 the config signature
Message-ID: <20260713220842.GY749385@bill-the-cat>
References: <cover.1783816074.git.daniel@makrotopia.org>
 <4adbf45f0d33802ebd2afd627f639e47c6609e17.1783816074.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="iSXD30lw5v2Njwpx"
Content-Disposition: inline
In-Reply-To: <4adbf45f0d33802ebd2afd627f639e47c6609e17.1783816074.git.daniel@makrotopia.org>
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


--iSXD30lw5v2Njwpx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 12, 2026 at 01:33:46AM +0100, Daniel Golle wrote:

> A dm-verity protected filesystem image is not hashed by U-Boot; its
> integrity is delegated to the kernel, which trusts the roothash taken
> from the FIT dm-verity subnode. For that chain of trust to hold, the
> roothash (and salt) must be part of the region covered by the
> configuration signature, otherwise an attacker can replace both the
> filesystem and the roothash while keeping the signature valid.
>=20
> Add two independent checks of this property:
>=20
>  - test/py/tests/test_fit_verity_sign.py signs a configuration that
>    references a filesystem image carrying a dm-verity subnode, then
>    confirms that tampering the roothash or the salt is rejected by
>    fit_check_sign. A control that tampers a byte known to be signed
>    proves the check can fail.
>=20
>  - test/boot/fit_verity.c gains a runtime unit test that builds the
>    exact node list the configuration signature is computed over,
>    turns it into hashed regions and checks both that the roothash
>    bytes fall inside a signed region and that tampering them changes
>    the hash. It needs no private key, so it also runs on real devices
>    and uses the same hash path a device would.
>=20
> To let the unit test build the signed-region node list, rename the
> config node-list helper to fit_config_get_signed_nodes() and expose it
> only when unit tests are built (VISIBLE_IF_UT), keeping it static in
> normal builds.
>=20
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  boot/image-fit-sig.c                  |  25 +++-
>  include/image.h                       |  25 ++++
>  test/boot/fit_verity.c                | 194 ++++++++++++++++++++++++++
>  test/py/tests/test_fit_verity_sign.py | 162 +++++++++++++++++++++
>  4 files changed, 399 insertions(+), 7 deletions(-)
>  create mode 100644 test/py/tests/test_fit_verity_sign.py
>=20
> diff --git a/boot/image-fit-sig.c b/boot/image-fit-sig.c
> index c2f09885492..1181fefb55f 100644
> --- a/boot/image-fit-sig.c
> +++ b/boot/image-fit-sig.c
> @@ -340,8 +340,19 @@ static int fit_config_add_hash(const void *fit, int =
image_noffset,
>  	return 0;
>  }
> =20
> +/*
> + * fit_config_get_signed_nodes() is internal, but the fit_verity unit te=
st
> + * needs to build the same signed-region node list. Make it visible when=
 unit
> + * tests are built and keep it static otherwise.
> + */
> +#if CONFIG_IS_ENABLED(UNIT_TEST)
> +#define VISIBLE_IF_UT
> +#else
> +#define VISIBLE_IF_UT static
> +#endif

I don't like this kind of "game", and I think it's why we generally just
don't mark functions as static that could be, if not for UNIT_TEST.
Finding a more general way to handle this would be good and an unrelated
clean-up (after verifying that for example, marking a ton of stuff as
now static results in a more compact binary or provides some obvious
gain).

My other comment would be that we should be doing like=20
doc/develop/pytest//test_fit.rst for example and making sure we have
good and usable generated documentation (so using pydoc comments, not
"#" style). And FYI that usually means building and viewing the docs
locally, not just making sure CI passes, it can be tricky I've found to
get examples annotated correctly to render usefully.

--=20
Tom

--iSXD30lw5v2Njwpx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCalVh6QAKCRAr4qD1Cr/k
CrJFAQC/sABjhIjZQxrfHo+AOioSMrJhXGuEn2wq0Q6UmTapnQEA1rM34VlBdE8D
UBk3zDiAZxIUdyXn0+9ds0rdo49XRgA=
=b7FK
-----END PGP SIGNATURE-----

--iSXD30lw5v2Njwpx--
