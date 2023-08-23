Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38519EE49A0
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 14:44:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 703518650A;
	Wed, 23 Aug 2023 16:43:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VbCXoZvQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4431086504; Wed, 23 Aug 2023 16:43:03 +0200 (CEST)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F04BF864FA
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 16:43:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-590685a3be5so39943877b3.0
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 07:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692801779; x=1693406579;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RhGQH8bgFJa0xEJeRPCdHSz1RJzXAmvwBkOimC99Yik=;
 b=VbCXoZvQgy/txhNnZV7wBEQScXKhguQXSlLRSmcMmvfwDGQepfQn4MJBu3c9E20Hzj
 EUY4gcsDBREPDLXgYpswA9X/T0QWwhq17CyDVotpg2T0VEbhKyjPXQ5fXHtrbNqJAMZ0
 I27VCECt+WtiYBVKmeRgsoxJASdHM1CJN9zBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692801779; x=1693406579;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RhGQH8bgFJa0xEJeRPCdHSz1RJzXAmvwBkOimC99Yik=;
 b=GVrofet/63RypSi6suZEqn0FPEziJat5vp0VoGWKX+QGGABoyO9zE3PElshnDqwJDR
 OOEknaM3o3mtXJpDJJLxIfHq/HYaG8HEsrOWqiDMw8MzES2TzOI4d/1j483yjYiTrgO7
 fz61xYv0J5ojffOhSLZk5pyxyvpg+mLtSirtb67/+CweT/BgwFZuzxPuvC3rOK9OG4zX
 87Kpo7+jKsaFGSaPtu1Dvt5QtWpigUGBOEEriCu5CV5WwVWzW4KPKvKtIdkc8zjpMXAg
 qGOjJAIP5AhJ6w9hnOdRrPICQoN9klFb2Mg2MeKts2D/GG7ElivWwqzLtc9F7eA2vptX
 TzJw==
X-Gm-Message-State: AOJu0YzadZpjTYh1eWObv6CZwiv4T/kw0OniNqRzKb1uubeZ99xt16mD
 gbm8BGJFRyHHo1k/5QvYyLrEjg==
X-Google-Smtp-Source: AGHT+IFmA6ZG7QUB0jWATGpukYWhGFIe3H5cK5cjs4eMqlG7UnOmMul8KIuitNLB4Bb3ouq+S1f3AA==
X-Received: by 2002:a05:690c:2c8a:b0:58d:71c0:34d1 with SMTP id
 ep10-20020a05690c2c8a00b0058d71c034d1mr10325926ywb.6.1692801779704; 
 Wed, 23 Aug 2023 07:42:59 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5ca1-6af2-305a-b62a.res6.spectrum.com.
 [2603:6081:7b00:6400:5ca1:6af2:305a:b62a])
 by smtp.gmail.com with ESMTPSA id
 i63-20020a0df842000000b005772e9388cdsm3345949ywf.62.2023.08.23.07.42.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 07:42:59 -0700 (PDT)
Date: Wed, 23 Aug 2023 10:42:57 -0400
From: Tom Rini <trini@konsulko.com>
To: Nishanth Menon <nm@ti.com>
Cc: Neha Francis <n-francis@ti.com>, Bryan <bb@ti.com>,
 Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH V4 7/8] board: ti: am62x: Add am62x_beagleplay_*
 defconfigs and env file
Message-ID: <20230823144257.GG3953269@bill-the-cat>
References: <20230822184135.2328409-1-nm@ti.com>
 <20230822184135.2328409-8-nm@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lAnw5ImbmygkAuz4"
Content-Disposition: inline
In-Reply-To: <20230822184135.2328409-8-nm@ti.com>
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


--lAnw5ImbmygkAuz4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 22, 2023 at 01:41:34PM -0500, Nishanth Menon wrote:
> Add defconfig fragments for am625 based beagleplay and corresponding
> customized environment file for beagleplay.
>=20
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> Changes:
> * new env file to override boot targets, led sequence etc.
> * config files updates for GPIO, I2C etc for A53.
> * Speed up of A53 mmc support.
>=20
> V3: https://lore.kernel.org/all/20230815164440.2713726-4-nm@ti.com/
> V2: https://lore.kernel.org/u-boot/20230727234446.3651836-4-nm@ti.com/
> V1: https://lore.kernel.org/all/20230725185253.2123433-6-nm@ti.com/
>  board/ti/am62x/beagleplay.env        | 23 ++++++++++++
>  board/ti/am62x/beagleplay_a53.config | 55 ++++++++++++++++++++++++++++
>  board/ti/am62x/beagleplay_r5.config  | 15 ++++++++
>  3 files changed, 93 insertions(+)
>  create mode 100644 board/ti/am62x/beagleplay.env
>  create mode 100644 board/ti/am62x/beagleplay_a53.config
>  create mode 100644 board/ti/am62x/beagleplay_r5.config
>=20
> diff --git a/board/ti/am62x/beagleplay.env b/board/ti/am62x/beagleplay.env
> new file mode 100644
> index 000000000000..8f39fb214333
> --- /dev/null
> +++ b/board/ti/am62x/beagleplay.env
> @@ -0,0 +1,23 @@
> +#include <env/ti/ti_armv7_common.env>

On a related note, we should really rename that.  The ti_armv7_common
files predate TI having armv8 platforms.  So whatever parts really are
common in the .env and .h files should just be in a slightly more
generically named file.

--=20
Tom

--lAnw5ImbmygkAuz4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTmGvEACgkQFHw5/5Y0
tyzQ0QwAqYEUz7Kw0D9nTkEt259EfbgmjdHPCPGKJgK753UZztjDEa+q5a9RSLqV
dgqHrBCxqZuTVWjz3i+lh4t6hGci278jrhWk4s3vfpzxr2UJSkaS4cV3UFD+vHDi
qJamjrmyR224IpE6PmeLDL3kvmTGyko8T9DLEA/3kMCq+uhhHiag02V23n8MSmPa
H+gO1t94ZNzVZ2gxZyXAh9ge/WMfYsz43ZNd1MJAhSi0V1vU0D1VY6p9NNq1FF4E
Qp3xFlcL3ULI6pgki2ZdYXTzHLOTeM2nQX5EnGa9ksnXdko6zi3jWWROWBJCu/pp
1xITGpfX9Bee01JDPGJfDxGRA69Usz9z8W6kqtFJp7k+iGy0qYKu9q5BaLcKb7te
XHt0AwoxMIWZ5iVKSTxG8tDJPfbaKUxTip8mZNSzSDRCqdsrQBGRvrBokk+DiUBT
Er7bPFqZiIXKBVga+uy8C3bi1eioojBk+6QZ8eewkoTteqs0s9L/6cH9cLAwNRv3
y8n79KGZ
=EB1D
-----END PGP SIGNATURE-----

--lAnw5ImbmygkAuz4--
