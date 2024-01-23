Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C381C47258
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 09:27:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D3088799A;
	Tue, 23 Jan 2024 10:27:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67D6387B9E; Tue, 23 Jan 2024 10:27:32 +0100 (CET)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by phobos.denx.de (Postfix) with ESMTP id 5AC6C8799A
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 10:27:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.05,213,1701097200"; 
 d="asc'?scan'208";a="191418950"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie5.idc.renesas.com with ESMTP; 23 Jan 2024 18:27:25 +0900
Received: from [10.226.92.252] (unknown [10.226.92.252])
 by relmlir5.idc.renesas.com (Postfix) with ESMTP id 3320F400F737;
 Tue, 23 Jan 2024 18:27:23 +0900 (JST)
Message-ID: <55fb536e-aae8-48c2-bcba-873461aa8c04@bp.renesas.com>
Date: Tue, 23 Jan 2024 09:27:22 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] clk: renesas: Drop include common.h
Content-Language: en-GB
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
References: <20240121173211.273726-1-marek.vasut+renesas@mailbox.org>
From: Paul Barker <paul.barker.ct@bp.renesas.com>
In-Reply-To: <20240121173211.273726-1-marek.vasut+renesas@mailbox.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------77q456z0dpb46aypSgIA000V"
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
--------------77q456z0dpb46aypSgIA000V
Content-Type: multipart/mixed; boundary="------------R6N80MaAbfUGPaubekGinZuX";
 protected-headers="v1"
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Message-ID: <55fb536e-aae8-48c2-bcba-873461aa8c04@bp.renesas.com>
Subject: Re: [PATCH 1/3] clk: renesas: Drop include common.h
References: <20240121173211.273726-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240121173211.273726-1-marek.vasut+renesas@mailbox.org>

--------------R6N80MaAbfUGPaubekGinZuX
Content-Type: multipart/mixed; boundary="------------bERM5EmwYohEYZiLYKGEM0av"

--------------bERM5EmwYohEYZiLYKGEM0av
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 21/01/2024 17:31, Marek Vasut wrote:
> The header file is not necessary in either of those files,
> remove it as common.h is going away.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Lukasz Majewski <lukma@denx.de>
> Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
> Cc: Sean Anderson <seanga2@gmail.com>
> ---
>  drivers/clk/renesas/clk-rcar-gen2.c     | 1 -
>  drivers/clk/renesas/clk-rcar-gen3.c     | 1 -
>  drivers/clk/renesas/r8a774a1-cpg-mssr.c | 1 -
>  drivers/clk/renesas/r8a774b1-cpg-mssr.c | 1 -
>  drivers/clk/renesas/r8a774c0-cpg-mssr.c | 1 -
>  drivers/clk/renesas/r8a774e1-cpg-mssr.c | 1 -
>  drivers/clk/renesas/r8a7790-cpg-mssr.c  | 1 -
>  drivers/clk/renesas/r8a7791-cpg-mssr.c  | 1 -
>  drivers/clk/renesas/r8a7792-cpg-mssr.c  | 1 -
>  drivers/clk/renesas/r8a7794-cpg-mssr.c  | 1 -
>  drivers/clk/renesas/r8a7795-cpg-mssr.c  | 1 -
>  drivers/clk/renesas/r8a7796-cpg-mssr.c  | 1 -
>  drivers/clk/renesas/r8a77965-cpg-mssr.c | 1 -
>  drivers/clk/renesas/r8a77970-cpg-mssr.c | 1 -
>  drivers/clk/renesas/r8a77980-cpg-mssr.c | 1 -
>  drivers/clk/renesas/r8a77990-cpg-mssr.c | 1 -
>  drivers/clk/renesas/r8a77995-cpg-mssr.c | 1 -
>  drivers/clk/renesas/r8a779a0-cpg-mssr.c | 1 -
>  drivers/clk/renesas/r8a779f0-cpg-mssr.c | 1 -
>  drivers/clk/renesas/r8a779g0-cpg-mssr.c | 1 -
>  drivers/clk/renesas/r9a06g032-clocks.c  | 1 -
>  drivers/clk/renesas/rcar-cpg-lib.c      | 1 -
>  drivers/clk/renesas/renesas-cpg-mssr.c  | 1 -
>  23 files changed, 23 deletions(-)
>=20
> diff --git a/drivers/clk/renesas/clk-rcar-gen2.c b/drivers/clk/renesas/=
clk-rcar-gen2.c
> index 850d6411190..66ffef96b69 100644
> --- a/drivers/clk/renesas/clk-rcar-gen2.c
> +++ b/drivers/clk/renesas/clk-rcar-gen2.c
> @@ -10,7 +10,6 @@
>   * Copyright (C) 2016 Glider bvba
>   */
> =20
> -#include <common.h>
>  #include <clk-uclass.h>
>  #include <dm.h>
>  #include <errno.h>
> diff --git a/drivers/clk/renesas/clk-rcar-gen3.c b/drivers/clk/renesas/=
clk-rcar-gen3.c
> index 0d274bb986e..196903e406c 100644
> --- a/drivers/clk/renesas/clk-rcar-gen3.c
> +++ b/drivers/clk/renesas/clk-rcar-gen3.c
> @@ -10,7 +10,6 @@
>   * Copyright (C) 2016 Glider bvba
>   */
> =20
> -#include <common.h>
>  #include <clk-uclass.h>
>  #include <dm.h>
>  #include <dm/device-internal.h>
> diff --git a/drivers/clk/renesas/r8a774a1-cpg-mssr.c b/drivers/clk/rene=
sas/r8a774a1-cpg-mssr.c
> index 6f94906cc99..d23041a8026 100644
> --- a/drivers/clk/renesas/r8a774a1-cpg-mssr.c
> +++ b/drivers/clk/renesas/r8a774a1-cpg-mssr.c
> @@ -9,7 +9,6 @@
>   * Copyright (C) 2016 Glider bvba
>   */
> =20
> -#include <common.h>
>  #include <clk-uclass.h>
>  #include <dm.h>
> =20
> diff --git a/drivers/clk/renesas/r8a774b1-cpg-mssr.c b/drivers/clk/rene=
sas/r8a774b1-cpg-mssr.c
> index 1a794980319..81d7dfe5421 100644
> --- a/drivers/clk/renesas/r8a774b1-cpg-mssr.c
> +++ b/drivers/clk/renesas/r8a774b1-cpg-mssr.c
> @@ -9,7 +9,6 @@
>   * Copyright (C) 2016 Glider bvba
>   */
> =20
> -#include <common.h>
>  #include <clk-uclass.h>
>  #include <dm.h>
> =20
> diff --git a/drivers/clk/renesas/r8a774c0-cpg-mssr.c b/drivers/clk/rene=
sas/r8a774c0-cpg-mssr.c
> index ec8ce6ad7d6..f92fd25c0f7 100644
> --- a/drivers/clk/renesas/r8a774c0-cpg-mssr.c
> +++ b/drivers/clk/renesas/r8a774c0-cpg-mssr.c
> @@ -10,7 +10,6 @@
>   * Copyright (C) 2015 Renesas Electronics Corp.
>   */
> =20
> -#include <common.h>
>  #include <clk-uclass.h>
>  #include <dm.h>
>  #include <linux/bitops.h>
> diff --git a/drivers/clk/renesas/r8a774e1-cpg-mssr.c b/drivers/clk/rene=
sas/r8a774e1-cpg-mssr.c
> index 6a8fe92b975..7c7cb7b6a05 100644
> --- a/drivers/clk/renesas/r8a774e1-cpg-mssr.c
> +++ b/drivers/clk/renesas/r8a774e1-cpg-mssr.c
> @@ -9,7 +9,6 @@
>   * Copyright (C) 2015 Glider bvba
>   */
> =20
> -#include <common.h>
>  #include <clk-uclass.h>
>  #include <dm.h>
>  #include <linux/bitops.h>
> diff --git a/drivers/clk/renesas/r8a7790-cpg-mssr.c b/drivers/clk/renes=
as/r8a7790-cpg-mssr.c
> index 686f2af0052..190b68ee7d3 100644
> --- a/drivers/clk/renesas/r8a7790-cpg-mssr.c
> +++ b/drivers/clk/renesas/r8a7790-cpg-mssr.c
> @@ -9,7 +9,6 @@
>   * Copyright (C) 2013 Ideas On Board SPRL
>   */
> =20
> -#include <common.h>
>  #include <clk-uclass.h>
>  #include <dm.h>
>  #include <linux/bitops.h>
> diff --git a/drivers/clk/renesas/r8a7791-cpg-mssr.c b/drivers/clk/renes=
as/r8a7791-cpg-mssr.c
> index dcb0fd85c52..30711bf8921 100644
> --- a/drivers/clk/renesas/r8a7791-cpg-mssr.c
> +++ b/drivers/clk/renesas/r8a7791-cpg-mssr.c
> @@ -9,7 +9,6 @@
>   * Copyright (C) 2013 Ideas On Board SPRL
>   */
> =20
> -#include <common.h>
>  #include <clk-uclass.h>
>  #include <dm.h>
>  #include <linux/bitops.h>
> diff --git a/drivers/clk/renesas/r8a7792-cpg-mssr.c b/drivers/clk/renes=
as/r8a7792-cpg-mssr.c
> index 496e51aa73f..623981e9c38 100644
> --- a/drivers/clk/renesas/r8a7792-cpg-mssr.c
> +++ b/drivers/clk/renesas/r8a7792-cpg-mssr.c
> @@ -9,7 +9,6 @@
>   * Copyright (C) 2013 Ideas On Board SPRL
>   */
> =20
> -#include <common.h>
>  #include <clk-uclass.h>
>  #include <dm.h>
>  #include <linux/bitops.h>
> diff --git a/drivers/clk/renesas/r8a7794-cpg-mssr.c b/drivers/clk/renes=
as/r8a7794-cpg-mssr.c
> index f1828a6e543..c4124917923 100644
> --- a/drivers/clk/renesas/r8a7794-cpg-mssr.c
> +++ b/drivers/clk/renesas/r8a7794-cpg-mssr.c
> @@ -9,7 +9,6 @@
>   * Copyright (C) 2013 Ideas On Board SPRL
>   */
> =20
> -#include <common.h>
>  #include <clk-uclass.h>
>  #include <dm.h>
>  #include <linux/bitops.h>
> diff --git a/drivers/clk/renesas/r8a7795-cpg-mssr.c b/drivers/clk/renes=
as/r8a7795-cpg-mssr.c
> index 0e9b9ccf979..e511f74982b 100644
> --- a/drivers/clk/renesas/r8a7795-cpg-mssr.c
> +++ b/drivers/clk/renesas/r8a7795-cpg-mssr.c
> @@ -10,7 +10,6 @@
>   * Copyright (C) 2015 Renesas Electronics Corp.
>   */
> =20
> -#include <common.h>
>  #include <clk-uclass.h>
>  #include <dm.h>
>  #include <linux/bitops.h>
> diff --git a/drivers/clk/renesas/r8a7796-cpg-mssr.c b/drivers/clk/renes=
as/r8a7796-cpg-mssr.c
> index d741d547ec8..02b078ad3df 100644
> --- a/drivers/clk/renesas/r8a7796-cpg-mssr.c
> +++ b/drivers/clk/renesas/r8a7796-cpg-mssr.c
> @@ -12,7 +12,6 @@
>   * Copyright (C) 2015 Renesas Electronics Corp.
>   */
> =20
> -#include <common.h>
>  #include <clk-uclass.h>
>  #include <dm.h>
>  #include <linux/bitops.h>
> diff --git a/drivers/clk/renesas/r8a77965-cpg-mssr.c b/drivers/clk/rene=
sas/r8a77965-cpg-mssr.c
> index cf4503803d0..037861eb9b4 100644
> --- a/drivers/clk/renesas/r8a77965-cpg-mssr.c
> +++ b/drivers/clk/renesas/r8a77965-cpg-mssr.c
> @@ -11,7 +11,6 @@
>   * Copyright (C) 2015 Renesas Electronics Corp.
>   */
> =20
> -#include <common.h>
>  #include <clk-uclass.h>
>  #include <dm.h>
>  #include <linux/bitops.h>
> diff --git a/drivers/clk/renesas/r8a77970-cpg-mssr.c b/drivers/clk/rene=
sas/r8a77970-cpg-mssr.c
> index 32923b423fe..d8bb5aab1fe 100644
> --- a/drivers/clk/renesas/r8a77970-cpg-mssr.c
> +++ b/drivers/clk/renesas/r8a77970-cpg-mssr.c
> @@ -9,7 +9,6 @@
>   * Copyright (C) 2015 Glider bvba
>   */
> =20
> -#include <common.h>
>  #include <clk-uclass.h>
>  #include <dm.h>
>  #include <linux/bitops.h>
> diff --git a/drivers/clk/renesas/r8a77980-cpg-mssr.c b/drivers/clk/rene=
sas/r8a77980-cpg-mssr.c
> index f35032b95f1..9d8335af783 100644
> --- a/drivers/clk/renesas/r8a77980-cpg-mssr.c
> +++ b/drivers/clk/renesas/r8a77980-cpg-mssr.c
> @@ -10,7 +10,6 @@
>   * Copyright (C) 2015 Glider bvba
>   */
> =20
> -#include <common.h>
>  #include <clk-uclass.h>
>  #include <dm.h>
>  #include <linux/bitops.h>
> diff --git a/drivers/clk/renesas/r8a77990-cpg-mssr.c b/drivers/clk/rene=
sas/r8a77990-cpg-mssr.c
> index 87b06666c8b..4c9acd76e18 100644
> --- a/drivers/clk/renesas/r8a77990-cpg-mssr.c
> +++ b/drivers/clk/renesas/r8a77990-cpg-mssr.c
> @@ -10,7 +10,6 @@
>   * Copyright (C) 2015 Renesas Electronics Corp.
>   */
> =20
> -#include <common.h>
>  #include <clk-uclass.h>
>  #include <dm.h>
>  #include <linux/bitops.h>
> diff --git a/drivers/clk/renesas/r8a77995-cpg-mssr.c b/drivers/clk/rene=
sas/r8a77995-cpg-mssr.c
> index dd2c9483292..f49faa47cb3 100644
> --- a/drivers/clk/renesas/r8a77995-cpg-mssr.c
> +++ b/drivers/clk/renesas/r8a77995-cpg-mssr.c
> @@ -10,7 +10,6 @@
>   * Copyright (C) 2015 Renesas Electronics Corp.
>   */
> =20
> -#include <common.h>
>  #include <clk-uclass.h>
>  #include <dm.h>
>  #include <linux/bitops.h>
> diff --git a/drivers/clk/renesas/r8a779a0-cpg-mssr.c b/drivers/clk/rene=
sas/r8a779a0-cpg-mssr.c
> index 652bfe4f6d3..ba086be0268 100644
> --- a/drivers/clk/renesas/r8a779a0-cpg-mssr.c
> +++ b/drivers/clk/renesas/r8a779a0-cpg-mssr.c
> @@ -10,7 +10,6 @@
>   * Copyright (C) 2015 Renesas Electronics Corp.
>   */
> =20
> -#include <common.h>
>  #include <clk-uclass.h>
>  #include <dm.h>
> =20
> diff --git a/drivers/clk/renesas/r8a779f0-cpg-mssr.c b/drivers/clk/rene=
sas/r8a779f0-cpg-mssr.c
> index 643e8b8da97..108655f145d 100644
> --- a/drivers/clk/renesas/r8a779f0-cpg-mssr.c
> +++ b/drivers/clk/renesas/r8a779f0-cpg-mssr.c
> @@ -7,7 +7,6 @@
>   * Based on r8a779a0-cpg-mssr.c
>   */
> =20
> -#include <common.h>
>  #include <clk-uclass.h>
>  #include <dm.h>
> =20
> diff --git a/drivers/clk/renesas/r8a779g0-cpg-mssr.c b/drivers/clk/rene=
sas/r8a779g0-cpg-mssr.c
> index 219024a7416..781806eed58 100644
> --- a/drivers/clk/renesas/r8a779g0-cpg-mssr.c
> +++ b/drivers/clk/renesas/r8a779g0-cpg-mssr.c
> @@ -7,7 +7,6 @@
>   * Based on r8a779f0-cpg-mssr.c
>   */
> =20
> -#include <common.h>
>  #include <clk-uclass.h>
>  #include <dm.h>
> =20
> diff --git a/drivers/clk/renesas/r9a06g032-clocks.c b/drivers/clk/renes=
as/r9a06g032-clocks.c
> index d2f61236fee..d207bf615ce 100644
> --- a/drivers/clk/renesas/r9a06g032-clocks.c
> +++ b/drivers/clk/renesas/r9a06g032-clocks.c
> @@ -7,7 +7,6 @@
>   * Michel Pollet <michel.pollet@bp.renesas.com>, <buserror@gmail.com>
>   */
> =20
> -#include <common.h>
>  #include <clk-uclass.h>
>  #include <dm.h>
>  #include <dm/device_compat.h>
> diff --git a/drivers/clk/renesas/rcar-cpg-lib.c b/drivers/clk/renesas/r=
car-cpg-lib.c
> index a2fca660a8e..8862fbc7579 100644
> --- a/drivers/clk/renesas/rcar-cpg-lib.c
> +++ b/drivers/clk/renesas/rcar-cpg-lib.c
> @@ -10,7 +10,6 @@
>   * Copyright (C) 2016 Glider bvba
>   */
> =20
> -#include <common.h>
>  #include <clk-uclass.h>
>  #include <dm.h>
>  #include <errno.h>
> diff --git a/drivers/clk/renesas/renesas-cpg-mssr.c b/drivers/clk/renes=
as/renesas-cpg-mssr.c
> index 10bd54d6002..35bad7f5f73 100644
> --- a/drivers/clk/renesas/renesas-cpg-mssr.c
> +++ b/drivers/clk/renesas/renesas-cpg-mssr.c
> @@ -9,7 +9,6 @@
>   *
>   * Copyright (C) 2016 Glider bvba
>   */
> -#include <common.h>
>  #include <clk-uclass.h>
>  #include <dm.h>
>  #include <errno.h>

Reviewed-by: Paul Barker <paul.barker.ct@bp.renesas.com>
--------------bERM5EmwYohEYZiLYKGEM0av
Content-Type: application/pgp-keys; name="OpenPGP_0x27F4B3459F002257.asc"
Content-Disposition: attachment; filename="OpenPGP_0x27F4B3459F002257.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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3D
=3DsIIN
-----END PGP PUBLIC KEY BLOCK-----

--------------bERM5EmwYohEYZiLYKGEM0av--

--------------R6N80MaAbfUGPaubekGinZuX--

--------------77q456z0dpb46aypSgIA000V
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSiu8gv1Xr0fIw/aoLbaV4Vf/JGvQUCZa+GegUDAAAAAAAKCRDbaV4Vf/JGvW0Y
AP4qZs6Jnn5ELzw60WZ2N3/hh2J9qFJWm8DJoYPQ0B95QQEAilM01UsutoTA9nc77orDH5wOAJVI
Bn+uuPKOop5anwo=
=1Haf
-----END PGP SIGNATURE-----

--------------77q456z0dpb46aypSgIA000V--
