Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49B57CCD195
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 21:57:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDC8A8382E;
	Fri, 17 Oct 2025 23:57:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bwgb6hs5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88EE283835; Fri, 17 Oct 2025 23:57:52 +0200 (CEST)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CDD283804
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 23:57:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-3c9a5fd1b72so387236fac.0
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 14:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760738269; x=1761343069; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QtUOogGN+0n9/TMSScUiVCoSAbrAH84UtRVG2wy+/Ro=;
 b=bwgb6hs5kbWO3EG5nILIQhxb+yHxYPKvS8xcrMBtkkhKC2ZgYFXfZ2IzF6vkfjWp7w
 XJPjB1mQFWpZqADR6lAIntzfEpJqd4OolgDApUTkSLjEISpTvVioN5SXvt8Wa/OiJdvD
 P86uoB/8LAZAa6RLukKEYqsETQx6UeyS+KqK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760738269; x=1761343069;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QtUOogGN+0n9/TMSScUiVCoSAbrAH84UtRVG2wy+/Ro=;
 b=cPZvFE8CZDaixslM7sxj/Q6i5Cgkb4vt5qGk7nYIssRIxyeIJ8WhDXje8GWfi/fEE8
 YJnubw1GYanH9ArcetUmA5zcO+1OEOwpcwluH1xNWxXDL4UEp29J/UozJoo3WUfpCofu
 UtionthtkZxDBqEWIZtk/yh34/cDOkt2msVrRhv56/yE6S1Oo7JvVzpmDiQo+U2t+XMG
 ERQd78Eu5S1f64SClAwkiAOTCnavs0fsj2V822pZ45UniOUs8g3MmovJ5kArrfpPOREh
 nZFRCIYUiHPjSNN2hNzPpy+Prq9COeoJlCyq6S+FivopRWicWgvTpPLWdfC/GC4UCvdQ
 iWhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjH7BhcXTVUyI72InBW5sfSqNoMk5xXcLoI5eu5nfhZl9ZhxqPsMoSTSkgmh0M9kpawdOtl8Q=@lists.denx.de
X-Gm-Message-State: AOJu0Yw4UiVzPkynYVnEqFYtBYhi8MaF0NMivKNvtfDi+6OBVqT2VI4S
 bHWugKlMB3BYTfnLGVEmd5wewqkCVBPzQECeoV/WIsx4p/1suu3R3NC8pgSqKZzFvyg=
X-Gm-Gg: ASbGnctN6BMN+Z9g+FdoPlLGE6Nb/NTmZvBE8jArbwBMoZCClbL2IA65nKD8KIdQVn7
 /mTPmKPocE17Clk3Ql98EXg4xQIT4s6ymMhnIBaGcIYVFv4/H0805D2BW/QlKeNG4Lr9Myxp7kz
 lDCMoAAaOMVbfo6rkhbLXOG0M1XzKC5eMPRpQFOKL91JiA5W50wrfBsPlIcjB5QykHlYFh3L/88
 ASHcA5Ka47Wb4u73sIjUHZNDUCZOepxd8wNTcGTscqKHOGw5MKiHjnZRAtlYlnSg+Bf/bAsfylm
 HRn3FyD5IqzSCoUDfi4cIjtsfgKYw71Qo7X/hZaBRfM6FQJzhkA3uQhUaFRRFVjaLAsUi/AIUWR
 ke1zmzu/R2FSpNZhVrbuBrR6eDpH60izPaUufigD9hq1Uw5351CN8u9yz4qJF0DpMxpbkZZo89A
 GK0qY/8+n8eq9Hx9X1Wo6ZQNWzjuaxuyrlJGr78FYr3KLv47S5pw==
X-Google-Smtp-Source: AGHT+IHplOVuEi24GZdv5DakE4p4wzDfzB6FrTBOd6w1f78Xjfl7HnPQlElfzaNntBI7CYgKh2p9pg==
X-Received: by 2002:a05:6870:248b:b0:387:3c81:ee9 with SMTP id
 586e51a60fabf-3c98d1460aamr2386439fac.51.1760738268977; 
 Fri, 17 Oct 2025 14:57:48 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3c9af31d53bsm226370fac.12.2025.10.17.14.57.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 14:57:48 -0700 (PDT)
Date: Fri, 17 Oct 2025 15:57:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Eddie Kovsky <ekovsky@redhat.com>
Cc: Loic Poulain <loic.poulain@linaro.org>, Tobias Olausson <tobias@eub.se>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Simon Glass <sjg@chromium.org>, Jan Stancek <jstancek@redhat.com>,
 Enric Balletbo i Serra <eballetb@redhat.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] Add support for OpenSSL Provider API
Message-ID: <20251017215745.GJ6688@bill-the-cat>
References: <20251017171329.255689-1-ekovsky@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gEWrkq38sKS+WNEC"
Content-Disposition: inline
In-Reply-To: <20251017171329.255689-1-ekovsky@redhat.com>
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


--gEWrkq38sKS+WNEC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 11:13:27AM -0600, Eddie Kovsky wrote:

> The Engine API has been deprecated since the release of OpenSSL 3.0. End =
users
> have been advised to migrate to the new Provider interface. Several
> distributions have already removed support for engines, which is preventi=
ng
> U-Boot from being compiled in those environments.
>=20
> The Kconfig option OPENSSL_NO_DEPRECATED introduces support for the Provi=
der API
> while continuing to use the existing Engine API on distros shipping older
> releases of OpenSSL.
>=20
> This is based on similar work contributed by Jan Stancek
> updating Linux to use the Provider interface.
>=20
>     commit 558bdc45dfb2669e1741384a0c80be9c82fa052c
>     Author: Jan Stancek <jstancek@redhat.com>
>     Date:   Fri Sep 20 19:52:48 2024 +0300
>=20
>         sign-file,extract-cert: use pkcs11 provider for OPENSSL MAJOR >=
=3D 3
>=20
> The changes have been tested with the FIT signature verification vboot te=
sts on
> Fedora 42 and Debian 13. All 30 tests pass with both the legacy Engine li=
brary
> installed and with the Provider API.
>=20
> Signed-off-by: Eddie Kovsky <ekovsky@redhat.com>
> ---
>  lib/aes/aes-encrypt.c |  2 +
>  lib/rsa/Kconfig       |  8 ++++
>  lib/rsa/rsa-sign.c    | 93 ++++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 101 insertions(+), 2 deletions(-)

Thanks for doing this, I'm glad to see the work, and my comments are
really style things to fix up and v2 once there's been time for real
content comments if any.

[snip]
> diff --git a/lib/rsa/Kconfig b/lib/rsa/Kconfig
> index 9033384e60a3..622f06f8dba0 100644
> --- a/lib/rsa/Kconfig
> +++ b/lib/rsa/Kconfig
> @@ -20,6 +20,14 @@ config SPL_RSA
>  	bool "Use RSA Library within SPL"
>  	depends on SPL
> =20
> +config OPENSSL_NO_DEPRECATED
> +	bool "Build U-Boot without support for OpenSSL Engine"
> +	default n

This is the default, you can drop this.

[snip]
> diff --git a/lib/rsa/rsa-sign.c b/lib/rsa/rsa-sign.c
> index 92b9d7876e52..9ebbcdfd52f3 100644
> --- a/lib/rsa/rsa-sign.c
> +++ b/lib/rsa/rsa-sign.c
> @@ -19,15 +19,51 @@
>  #include <openssl/err.h>
>  #include <openssl/ssl.h>
>  #include <openssl/evp.h>
> +#if (IS_ENABLED(CONFIG_OPENSSL_NO_DEPRECATED))
> +#include <err.h>
> +#include <openssl/provider.h>
> +#include <openssl/store.h>
> +#else
>  #include <openssl/engine.h>
> +#endif // CONFIG_OPENSSL_NO_DEPRECATED

Two things (here and elsewhere). One, since we're generally using
'#ifndef CONFIG_OPENSSL_NO_DEPRECATED' just using '#ifdef
CONFIG_OPENSSL_NO_DEPRECATED' is fine, using a macro here is not aiding
readability. Two, if the if/else/endif is within the patch context we
really don't need a comment on the endif part.

--=20
Tom

--gEWrkq38sKS+WNEC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaPK71gAKCRAr4qD1Cr/k
Cm5FAQCGLwu//mJjn2+NO7banCmQ/w2xzlEaRUlrnV+ogbCCGwEAn8pgc0lrfh1Z
3ffV092rtgglmEkseyB5zsd2HqSGPwc=
=kxu0
-----END PGP SIGNATURE-----

--gEWrkq38sKS+WNEC--
