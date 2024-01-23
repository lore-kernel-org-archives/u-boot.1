Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BE95C47DDB
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 09:28:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D997587994;
	Tue, 23 Jan 2024 10:28:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 600D687BBC; Tue, 23 Jan 2024 10:28:08 +0100 (CET)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by phobos.denx.de (Postfix) with ESMTP id 9A52E87701
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 10:28:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.05,213,1701097200"; 
 d="asc'?scan'208";a="191419015"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie5.idc.renesas.com with ESMTP; 23 Jan 2024 18:28:04 +0900
Received: from [10.226.92.252] (unknown [10.226.92.252])
 by relmlir5.idc.renesas.com (Postfix) with ESMTP id 98DB8400F737;
 Tue, 23 Jan 2024 18:28:03 +0900 (JST)
Message-ID: <92a6bca5-2f9c-49f4-9b92-87527018244a@bp.renesas.com>
Date: Tue, 23 Jan 2024 09:28:02 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] pinctrl: renesas: Drop include common.h
Content-Language: en-GB
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
References: <20240121173211.273726-1-marek.vasut+renesas@mailbox.org>
 <20240121173211.273726-2-marek.vasut+renesas@mailbox.org>
From: Paul Barker <paul.barker.ct@bp.renesas.com>
In-Reply-To: <20240121173211.273726-2-marek.vasut+renesas@mailbox.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------A8IvgqNvsJSKcYBeXXOfGFYy"
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------A8IvgqNvsJSKcYBeXXOfGFYy
Content-Type: multipart/mixed; boundary="------------wzK4dRL7H8XMZDylgOIL4aif";
 protected-headers="v1"
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Message-ID: <92a6bca5-2f9c-49f4-9b92-87527018244a@bp.renesas.com>
Subject: Re: [PATCH 2/3] pinctrl: renesas: Drop include common.h
References: <20240121173211.273726-1-marek.vasut+renesas@mailbox.org>
 <20240121173211.273726-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240121173211.273726-2-marek.vasut+renesas@mailbox.org>

--------------wzK4dRL7H8XMZDylgOIL4aif
Content-Type: multipart/mixed; boundary="------------yMWV1YiipYKn02F7y0OnNglB"

--------------yMWV1YiipYKn02F7y0OnNglB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 21/01/2024 17:31, Marek Vasut wrote:
> The header file is not necessary in either of those files,
> remove it as common.h is going away.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
> ---
>  drivers/pinctrl/renesas/pfc-r8a7790.c  | 1 -
>  drivers/pinctrl/renesas/pfc-r8a7791.c  | 1 -
>  drivers/pinctrl/renesas/pfc-r8a7792.c  | 1 -
>  drivers/pinctrl/renesas/pfc-r8a7794.c  | 1 -
>  drivers/pinctrl/renesas/pfc-r8a77951.c | 1 -
>  drivers/pinctrl/renesas/pfc-r8a7796.c  | 1 -
>  drivers/pinctrl/renesas/pfc-r8a77965.c | 1 -
>  drivers/pinctrl/renesas/pfc-r8a77970.c | 1 -
>  drivers/pinctrl/renesas/pfc-r8a77980.c | 1 -
>  drivers/pinctrl/renesas/pfc-r8a77990.c | 1 -
>  drivers/pinctrl/renesas/pfc-r8a77995.c | 1 -
>  drivers/pinctrl/renesas/pfc-r8a779a0.c | 1 -
>  drivers/pinctrl/renesas/pfc-r8a779f0.c | 1 -
>  drivers/pinctrl/renesas/pfc-r8a779g0.c | 1 -
>  drivers/pinctrl/renesas/pfc.c          | 1 -
>  drivers/pinctrl/renesas/pinctrl-rza1.c | 1 -
>  16 files changed, 16 deletions(-)
>=20
> diff --git a/drivers/pinctrl/renesas/pfc-r8a7790.c b/drivers/pinctrl/re=
nesas/pfc-r8a7790.c
> index 7203648bbc8..e1811c4c908 100644
> --- a/drivers/pinctrl/renesas/pfc-r8a7790.c
> +++ b/drivers/pinctrl/renesas/pfc-r8a7790.c
> @@ -8,7 +8,6 @@
>   * Copyright (C) 2012  Kuninori Morimoto <kuninori.morimoto.gx@renesas=
=2Ecom>
>   */
> =20
> -#include <common.h>
>  #include <dm.h>
>  #include <errno.h>
>  #include <dm/pinctrl.h>
> diff --git a/drivers/pinctrl/renesas/pfc-r8a7791.c b/drivers/pinctrl/re=
nesas/pfc-r8a7791.c
> index b25453ed285..fa94a51e5e7 100644
> --- a/drivers/pinctrl/renesas/pfc-r8a7791.c
> +++ b/drivers/pinctrl/renesas/pfc-r8a7791.c
> @@ -6,7 +6,6 @@
>   * Copyright (C) 2014-2017 Cogent Embedded, Inc.
>   */
> =20
> -#include <common.h>
>  #include <dm.h>
>  #include <errno.h>
>  #include <dm/pinctrl.h>
> diff --git a/drivers/pinctrl/renesas/pfc-r8a7792.c b/drivers/pinctrl/re=
nesas/pfc-r8a7792.c
> index 08f1f97af6e..7c1e6d40749 100644
> --- a/drivers/pinctrl/renesas/pfc-r8a7792.c
> +++ b/drivers/pinctrl/renesas/pfc-r8a7792.c
> @@ -6,7 +6,6 @@
>   * Copyright (C) 2016 Cogent Embedded, Inc., <source@cogentembedded.co=
m>
>   */
> =20
> -#include <common.h>
>  #include <dm.h>
>  #include <errno.h>
>  #include <dm/pinctrl.h>
> diff --git a/drivers/pinctrl/renesas/pfc-r8a7794.c b/drivers/pinctrl/re=
nesas/pfc-r8a7794.c
> index e5d125ceca0..29eab2610c1 100644
> --- a/drivers/pinctrl/renesas/pfc-r8a7794.c
> +++ b/drivers/pinctrl/renesas/pfc-r8a7794.c
> @@ -7,7 +7,6 @@
>   * Copyright (C) 2015-2017 Cogent Embedded, Inc. <source@cogentembedde=
d.com>
>   */
> =20
> -#include <common.h>
>  #include <dm.h>
>  #include <errno.h>
>  #include <dm/pinctrl.h>
> diff --git a/drivers/pinctrl/renesas/pfc-r8a77951.c b/drivers/pinctrl/r=
enesas/pfc-r8a77951.c
> index 5d1c81c3eae..81568ae4a5e 100644
> --- a/drivers/pinctrl/renesas/pfc-r8a77951.c
> +++ b/drivers/pinctrl/renesas/pfc-r8a77951.c
> @@ -5,7 +5,6 @@
>   * Copyright (C) 2015-2019 Renesas Electronics Corporation
>   */
> =20
> -#include <common.h>
>  #include <dm.h>
>  #include <errno.h>
>  #include <dm/pinctrl.h>
> diff --git a/drivers/pinctrl/renesas/pfc-r8a7796.c b/drivers/pinctrl/re=
nesas/pfc-r8a7796.c
> index 163d1805dfb..3de43febbd3 100644
> --- a/drivers/pinctrl/renesas/pfc-r8a7796.c
> +++ b/drivers/pinctrl/renesas/pfc-r8a7796.c
> @@ -11,7 +11,6 @@
>   * Copyright (C) 2015  Renesas Electronics Corporation
>   */
> =20
> -#include <common.h>
>  #include <dm.h>
>  #include <errno.h>
>  #include <dm/pinctrl.h>
> diff --git a/drivers/pinctrl/renesas/pfc-r8a77965.c b/drivers/pinctrl/r=
enesas/pfc-r8a77965.c
> index 377143d3918..3a6813cee61 100644
> --- a/drivers/pinctrl/renesas/pfc-r8a77965.c
> +++ b/drivers/pinctrl/renesas/pfc-r8a77965.c
> @@ -12,7 +12,6 @@
>   * Copyright (C) 2015  Renesas Electronics Corporation
>   */
> =20
> -#include <common.h>
>  #include <dm.h>
>  #include <errno.h>
>  #include <dm/pinctrl.h>
> diff --git a/drivers/pinctrl/renesas/pfc-r8a77970.c b/drivers/pinctrl/r=
enesas/pfc-r8a77970.c
> index 1cc6fa4f3fc..3c9c060d245 100644
> --- a/drivers/pinctrl/renesas/pfc-r8a77970.c
> +++ b/drivers/pinctrl/renesas/pfc-r8a77970.c
> @@ -12,7 +12,6 @@
>   * Copyright (C) 2015  Renesas Electronics Corporation
>   */
> =20
> -#include <common.h>
>  #include <dm.h>
>  #include <errno.h>
>  #include <dm/pinctrl.h>
> diff --git a/drivers/pinctrl/renesas/pfc-r8a77980.c b/drivers/pinctrl/r=
enesas/pfc-r8a77980.c
> index 523faa0ac8f..14a4b4dc731 100644
> --- a/drivers/pinctrl/renesas/pfc-r8a77980.c
> +++ b/drivers/pinctrl/renesas/pfc-r8a77980.c
> @@ -12,7 +12,6 @@
>   * Copyright (C) 2015 Renesas Electronics Corporation
>   */
> =20
> -#include <common.h>
>  #include <dm.h>
>  #include <errno.h>
>  #include <dm/pinctrl.h>
> diff --git a/drivers/pinctrl/renesas/pfc-r8a77990.c b/drivers/pinctrl/r=
enesas/pfc-r8a77990.c
> index 215a19ef9cd..e3a9c5e053d 100644
> --- a/drivers/pinctrl/renesas/pfc-r8a77990.c
> +++ b/drivers/pinctrl/renesas/pfc-r8a77990.c
> @@ -11,7 +11,6 @@
>   * Copyright (C) 2016-2017 Renesas Electronics Corp.
>   */
> =20
> -#include <common.h>
>  #include <dm.h>
>  #include <errno.h>
>  #include <dm/pinctrl.h>
> diff --git a/drivers/pinctrl/renesas/pfc-r8a77995.c b/drivers/pinctrl/r=
enesas/pfc-r8a77995.c
> index c0d69937ddb..eccf5c15907 100644
> --- a/drivers/pinctrl/renesas/pfc-r8a77995.c
> +++ b/drivers/pinctrl/renesas/pfc-r8a77995.c
> @@ -11,7 +11,6 @@
>   * Copyright (C) 2015  Renesas Electronics Corporation
>   */
> =20
> -#include <common.h>
>  #include <dm.h>
>  #include <errno.h>
>  #include <dm/pinctrl.h>
> diff --git a/drivers/pinctrl/renesas/pfc-r8a779a0.c b/drivers/pinctrl/r=
enesas/pfc-r8a779a0.c
> index 3c4b03b1b4c..6f898385027 100644
> --- a/drivers/pinctrl/renesas/pfc-r8a779a0.c
> +++ b/drivers/pinctrl/renesas/pfc-r8a779a0.c
> @@ -7,7 +7,6 @@
>   * This file is based on the drivers/pinctrl/renesas/pfc-r8a7795.c
>   */
> =20
> -#include <common.h>
>  #include <dm.h>
>  #include <errno.h>
>  #include <dm/pinctrl.h>
> diff --git a/drivers/pinctrl/renesas/pfc-r8a779f0.c b/drivers/pinctrl/r=
enesas/pfc-r8a779f0.c
> index 5123e26e0ac..de5ec6c812a 100644
> --- a/drivers/pinctrl/renesas/pfc-r8a779f0.c
> +++ b/drivers/pinctrl/renesas/pfc-r8a779f0.c
> @@ -7,7 +7,6 @@
>   * This file is based on the drivers/pinctrl/renesas/pfc-r8a779a0.c
>   */
> =20
> -#include <common.h>
>  #include <dm.h>
>  #include <errno.h>
>  #include <dm/pinctrl.h>
> diff --git a/drivers/pinctrl/renesas/pfc-r8a779g0.c b/drivers/pinctrl/r=
enesas/pfc-r8a779g0.c
> index 20498a1c2f7..6749c15f4ea 100644
> --- a/drivers/pinctrl/renesas/pfc-r8a779g0.c
> +++ b/drivers/pinctrl/renesas/pfc-r8a779g0.c
> @@ -7,7 +7,6 @@
>   * This file is based on the drivers/pinctrl/renesas/pfc-r8a779a0.c
>   */
> =20
> -#include <common.h>
>  #include <dm.h>
>  #include <errno.h>
>  #include <dm/pinctrl.h>
> diff --git a/drivers/pinctrl/renesas/pfc.c b/drivers/pinctrl/renesas/pf=
c.c
> index 3ac25cbd080..4ceb5db47ff 100644
> --- a/drivers/pinctrl/renesas/pfc.c
> +++ b/drivers/pinctrl/renesas/pfc.c
> @@ -11,7 +11,6 @@
> =20
>  #define DRV_NAME "sh-pfc"
> =20
> -#include <common.h>
>  #include <dm.h>
>  #include <errno.h>
>  #include <dm/device_compat.h>
> diff --git a/drivers/pinctrl/renesas/pinctrl-rza1.c b/drivers/pinctrl/r=
enesas/pinctrl-rza1.c
> index a445cdba713..2d993be2b2a 100644
> --- a/drivers/pinctrl/renesas/pinctrl-rza1.c
> +++ b/drivers/pinctrl/renesas/pinctrl-rza1.c
> @@ -5,7 +5,6 @@
>   * Copyright (C) 2019 Marek Vasut <marek.vasut@gmail.com>
>   */
> =20
> -#include <common.h>
>  #include <dm.h>
>  #include <asm/global_data.h>
>  #include <dm/lists.h>

Reviewed-by: Paul Barker <paul.barker.ct@bp.renesas.com>

--------------yMWV1YiipYKn02F7y0OnNglB
Content-Type: application/pgp-keys; name="OpenPGP_0x27F4B3459F002257.asc"
Content-Disposition: attachment; filename="OpenPGP_0x27F4B3459F002257.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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3D
=3DsIIN
-----END PGP PUBLIC KEY BLOCK-----

--------------yMWV1YiipYKn02F7y0OnNglB--

--------------wzK4dRL7H8XMZDylgOIL4aif--

--------------A8IvgqNvsJSKcYBeXXOfGFYy
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSiu8gv1Xr0fIw/aoLbaV4Vf/JGvQUCZa+GowUDAAAAAAAKCRDbaV4Vf/JGvZRE
AP9zZ4iDhPWZqI7pbgqQyuj6mKb6tJNQrKYGEqtzrte4+gEAvI9+bON8DCsKw4qC14L4f1iBl7fA
pgEPW9PlXOqm2AM=
=mgaV
-----END PGP SIGNATURE-----

--------------A8IvgqNvsJSKcYBeXXOfGFYy--
