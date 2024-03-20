Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC8CCC54E71
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 01:19:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 175D187F8E;
	Wed, 20 Mar 2024 02:19:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="E8W31uAN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25BEC87ECD; Wed, 20 Mar 2024 02:19:00 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BFFC88076
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 02:18:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-6098b9ed2a3so58376407b3.0
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 18:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1710897536; x=1711502336; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YmXduqnMeTsoff2nW4dQpv+JHIpGNnTrxcUBtnH1rmM=;
 b=E8W31uAN5E/xg7L459gsb58VwkbWNKag2snEH4tFnRZn5fIZGieRv3ITIquPBowr7D
 7U0+Blpr5HMVxQiLP0PcNT7RPgh1XeFHQ/zPqKJDOSC073+zTeCGi+lH4ms0tD6o/qm/
 Eo/c074EIbf0l47l7zn+aOWj/7vCCMOuOXZBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710897536; x=1711502336;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YmXduqnMeTsoff2nW4dQpv+JHIpGNnTrxcUBtnH1rmM=;
 b=oYcGkVKpciVdsumaARmQDzp1MGuJ4bvSoSLJyZBm1m367Y4ZCUC1p1W2JDg3baKW19
 9k3A5dpFoV6+UcaPCD6oMJJl32eDAT6LPeNoIOhA0+2uOY2OXEqd7Qkc6AtMFMBGxBwQ
 nGg6UtmX3Pe9EB/RzQV9b3VYuCOWalkQpX7KYiTHEbquTv0z5gxKXXgWYorYY3UtgeP5
 vkc2Nik9mK6UJPPv0A7dXs/sEoquSGGgOcyfsoprSanvVgRl4HmcHWk4/vYK28mqRecu
 XQ5gen2fWqjJxALnDCUKoTz+lBf8d2+9ZRqwmhmPiHFOXZ75umoUZUQ6Tbf2ixkTne/G
 cCsg==
X-Gm-Message-State: AOJu0Yw2obfqAfbVyy9vajnd7aiyuF3eA998omc0+l6LV9K19aGAPg/E
 Grn/ewQNps9ljLe9EeDtXsclg3CS+j60sVIVHNC+B+G3TUWcPa48XjUvKQXXe8Q=
X-Google-Smtp-Source: AGHT+IFu+R7REGytHY+fm3AU8QaUwHOzv/oegxOTZbjb3HeycgpIZTYQBA6dVKt1gzF3lSH1uCuTqw==
X-Received: by 2002:a81:8687:0:b0:610:e262:2675 with SMTP id
 w129-20020a818687000000b00610e2622675mr3842222ywf.25.1710897536215; 
 Tue, 19 Mar 2024 18:18:56 -0700 (PDT)
Received: from bill-the-cat (065-184-193-066.res.spectrum.com. [65.184.193.66])
 by smtp.gmail.com with ESMTPSA id
 r74-20020a819a4d000000b0060a07fdf93bsm2631588ywg.134.2024.03.19.18.18.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 18:18:55 -0700 (PDT)
Date: Tue, 19 Mar 2024 21:18:53 -0400
From: Tom Rini <trini@konsulko.com>
To: Greg Malysa <greg.malysa@timesys.com>
Cc: u-boot@lists.denx.de,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jesse Taube <mr.bossman075@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>, Nishanth Menon <nm@ti.com>,
 Shengyu Qu <wiagn233@outlook.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] build: Revive and update LDR format support
Message-ID: <20240320011853.GK3442575@bill-the-cat>
References: <20240320010922.30856-1-greg.malysa@timesys.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4/PGaKcE342rR7i9"
Content-Disposition: inline
In-Reply-To: <20240320010922.30856-1-greg.malysa@timesys.com>
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


--4/PGaKcE342rR7i9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 09:09:22PM -0400, Greg Malysa wrote:

> LDR format files are used primarily by Analog Devices processors but may
> be of interest to other vendors. Previously support existed for this
> format as part of the U-Boot build, but it has been unmaintained and
> unused for a long time. In preparation for adding support for modern ADI
> processors that use LDR, modernize the LDR support:
>=20
> - Introduce CONFIG_LDR_CPU as the CPU string recognized by the LDR tool
>   may not be the same as CONFIG_CPU
> - Add an SPL target that repackages u-boot-spl inside an LDR file
>=20
> An almost identical target for packaging u-boot into an LDR file already
> exists and did not need to be updated
>=20
> Co-developed-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
> Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
> Signed-off-by: Ian Roberts <ian.roberts@timesys.com>
> Signed-off-by: Greg Malysa <greg.malysa@timesys.com>
>=20
> ---
>=20
>  Kconfig              | 9 ++++++++-
>  Makefile             | 2 +-
>  scripts/Makefile.spl | 5 +++++
>  3 files changed, 14 insertions(+), 2 deletions(-)
>=20
> diff --git a/Kconfig b/Kconfig
> index 5710934000..3f3ce6054e 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -715,10 +715,17 @@ config SYS_CLK_FREQ
>  	  A static value for the CPU frequency.  Note that if not required
>  	  for a given SoC, this can be left at 0.
> =20
> -source "api/Kconfig"
> +config LDR_CPU
> +	string "CPU name to be passed to LDR utility."
> +	help
> +	  Set the CPU name for the -T parameter in the LDR utility.  This is
> +	  generally used on processors from Analog Devices, but may be also
> +	  be useful for other vendors.
> =20
>  endmenu		# General setup

This looks like a new prompted option, without a default, for every
platform. If so, as is it will cause everything in CI to fail to build.
This should "depend on" some relevant LDR symbol, once that's been
added, rather than as a ground-work patch. This rest seems fine, FWIW.

--=20
Tom

--4/PGaKcE342rR7i9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmX6OXkACgkQFHw5/5Y0
tyxzLAv9FVmMvu+B1hEZXmKJmpiQtp8NcK4HLiCqaeX4BQEnTAW5D0Kx9guAQrgz
suRk8c7dQqWODyAZR3S+JAJC5BshRWy7gbDdPbETFjB6pGSSWIX++9LI2sWUjpUn
LocjVLoZgdIeFBjmq1VTWWmgZRed/+/gENyf96ZQorhp+mVCsesO200RnjXIOCdF
bPtWWayb8/FjcOm6gVFqfMNQlrI8jz/zmHuwVduG7hUgLCVGYHGApL846PaXgN5t
r3I5lABNPxchOvvCLrQNO+qHKhbPZPoVmudkZcqbwHpzj647gjmdaEYjNaYBsZFS
oOYXYLayYp3/M//hqW1PkhbTdYNeWuN4LDAPozHvsD7ZuL5lWsV62DcDUSyVLHWI
cEnZb5tCHyRSHk0ztYhgIgWPu38TyAZOMA9kGO3gz1PVpSUcrM5ut/XCN/5M8IDK
kqbA0b++xsFG0KtfJk0u06DUcEDXTyk3wRkAQIIu2Hi3iNx7I93qOUoaom7ITgpv
iZLUysUx
=U78u
-----END PGP SIGNATURE-----

--4/PGaKcE342rR7i9--
