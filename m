Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E080CE79D7
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 14:22:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13E1B86AFB;
	Wed, 20 Sep 2023 16:22:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EMy/Jub9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C555286B26; Wed, 20 Sep 2023 16:22:57 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1C6A86A9E
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 16:22:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-59c0b9ad491so54572527b3.1
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 07:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695219774; x=1695824574; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IDS3lppqNFMJgWqlio6d9dpV/mokmFVvFw8aQwevZC4=;
 b=EMy/Jub9xPSAAgqVkPelDF7D5ITk2hJ2QDFme0ktEohqgX8wcbXpHaaCQMtCkgBOHN
 KYKkV2b16Z0muaOIwIwwaxsT7Go5zh7Jr/8ICO2RP+3ncwUDOvusts400pvNmhYn58oL
 AXv7rYwWjvgSFfMVzMtR4D6IyCqPCiAb8VYlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695219774; x=1695824574;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IDS3lppqNFMJgWqlio6d9dpV/mokmFVvFw8aQwevZC4=;
 b=IwceaUr1yK2z4wiXqbb2Cd3S3OQdi4eZ1rKB009RstB8khgutql9jk2Ry5pm44NwFB
 BzcJ2hIqRwalDiYmmMU7Ig55x9nAcxpY0Cd858YzD9G0c3JQZWnEtWBii0QWPlXxDPCn
 SGrc6Jt+HIxviBPyr5xNrmx6qC52g+W/oh8pd9LHJXXEdvUGzXbbDXC6r2EyTkXm0MDO
 ZUmKkpMIsja+TljTIwm0SqiIBzhtsXQH5y9H9CoLrgcXdLUzxI7r0kiMNYPs1HvbI/7i
 Qaa+yUPFqv/PTBjW3PkXTOzG4US6Nyvdjtq3S3Ki/MN48pMhsmK1fvPi3Q8QPPK4lkD7
 GbVA==
X-Gm-Message-State: AOJu0YyB5KkhomqA7GdSN9Wwfk6YVJAiZLAElM+eqPNe+mVfBgkZsouW
 6kUvjRXUXv8VLITlX8/6b6TBVw==
X-Google-Smtp-Source: AGHT+IERajO06paWvsQEoHRQZNeI7zh+XqYNd1s4Dt3Saw8/LLx7/jbxc9M9F1NX9vPltS2zKpqFtg==
X-Received: by 2002:a81:4ed2:0:b0:59e:9fbc:a16c with SMTP id
 c201-20020a814ed2000000b0059e9fbca16cmr2795065ywb.35.1695219774437; 
 Wed, 20 Sep 2023 07:22:54 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-eb6c-8990-1b3a-d2e2.res6.spectrum.com.
 [2603:6081:7b00:6400:eb6c:8990:1b3a:d2e2])
 by smtp.gmail.com with ESMTPSA id
 w20-20020a81a214000000b005773babc3cdsm3780448ywg.83.2023.09.20.07.22.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Sep 2023 07:22:53 -0700 (PDT)
Date: Wed, 20 Sep 2023 10:22:52 -0400
From: Tom Rini <trini@konsulko.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: u-boot@lists.denx.de, Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
Subject: Re: [PATCH] bmips: Add Inteno XG6846 board
Message-ID: <20230920142252.GO305624@bill-the-cat>
References: <20230920074225.1130769-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rwFWWdithUw7ctzq"
Content-Disposition: inline
In-Reply-To: <20230920074225.1130769-1-linus.walleij@linaro.org>
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


--rwFWWdithUw7ctzq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 20, 2023 at 09:42:25AM +0200, Linus Walleij wrote:

> This adds support for the Inteno XG6846 board based on the
> Broadcom MIPS 6328 SoC.
>=20
> The default boot will read a uImage from flash and boot it.
>=20
> Cc: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
[snip]
> diff --git a/arch/mips/dts/inteno,xg6846.dts b/arch/mips/dts/inteno,xg684=
6.dts
> new file mode 100644
> index 000000000000..180cfdcac9d4
> --- /dev/null
> +++ b/arch/mips/dts/inteno,xg6846.dts
> @@ -0,0 +1,57 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2023 Linus Walleij <linusw@kernel.org>
> + *
> + * This is a diet version of the device tree from Linux,
> + * suitable for U-Boot.
> + */

We shouldn't need a diet version of the tree.  If it's reasonably done
and stable in the kernel, we can even move towards just passing the
U-Boot tree along to Linux.

> diff --git a/board/inteno/xg6846/Kconfig b/board/inteno/xg6846/Kconfig
> new file mode 100644
> index 000000000000..4dd78b3b1960
> --- /dev/null
> +++ b/board/inteno/xg6846/Kconfig
> @@ -0,0 +1,12 @@
> +if BOARD_INTENO_XG6846
> +
> +config SYS_BOARD
> +	default "xg6846"
> +
> +config SYS_VENDOR
> +	default "inteno"
> +
> +config SYS_CONFIG_NAME
> +	default "inteno_xg6846"
> +
> +endif
[snip]
> diff --git a/board/inteno/xg6846/Makefile b/board/inteno/xg6846/Makefile
> new file mode 100644
> index 000000000000..311e1db7a775
> --- /dev/null
> +++ b/board/inteno/xg6846/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +
> +obj-y +=3D xg6846.o
> diff --git a/board/inteno/xg6846/xg6846.c b/board/inteno/xg6846/xg6846.c
> new file mode 100644
> index 000000000000..b3b6751a6256
> --- /dev/null
> +++ b/board/inteno/xg6846/xg6846.c
> @@ -0,0 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2023 Linus Walleij <linusw@kernel.org>
> + */
> +
> +#include <common.h>

So basically just an empty object file.  Can we just _not_ have
something here, if we perhaps don't set SYS_BOARD?  I assume if there's
just nothing here the link rules fail.

--=20
Tom

--rwFWWdithUw7ctzq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmULADkACgkQFHw5/5Y0
tywtswv/W8IUtJOK0hs9trWlWB/y1L0x9SUSY7+rq7ZQunruaxwmZBZKzDS4fYG+
4gCCVEnIVnYqzAZKpKJSQvbyjeKI4anYxXSey48BfCqgsIYxEaaj9ItwvOm8rFDl
HZ7oXe8N0wvIZASLTIQTvi+6T2CR2M++Y1aiTC3nJDxxxqpyMX8aNsYxGVQEQiJg
irsZIzztK3E0BW8v0N4H5sSOYIBDQOhqYMEaXK9ZTgiZzIpcepFoXzWGV1MV4WB1
2baklwXNbmdns8o7EpzqnSkxv8OQYWeMs8Rqv8oCVSLKWu0I0ACDGXHVjZ/oKuWT
yyDjrGqqeJqxbjQWTiLPhRtOUx9Tp0sKZnehCFw3lO5rGWXi4rQjJtHwaCrK5K23
rLsJwtM4vTdOIikp8fK8doQN7VsL7qhemCwczhY1PVXCDgVKWY7/c/1n0yrDo+CD
cBY/7AD1QnOynBuZqG0ZeMu4Rfcosey4acLmZ3KI66wy+dGB8Yj21u0ZvglMiVfL
XeH1W6er
=HHWQ
-----END PGP SIGNATURE-----

--rwFWWdithUw7ctzq--
