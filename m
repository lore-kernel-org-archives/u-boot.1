Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41400C36017
	for <u-boot@archiver.kernel.org>; Wed,  2 Apr 2025 15:13:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B98980194;
	Wed,  2 Apr 2025 17:13:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="E1mxi+nd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC73281703; Wed,  2 Apr 2025 17:13:15 +0200 (CEST)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15B8D8006D
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 17:13:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-601a891ab8fso537484eaf.1
 for <u-boot@lists.denx.de>; Wed, 02 Apr 2025 08:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743606791; x=1744211591; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kf9pc5I8ZYh8TUyZymUAEA7SIelm5p1ZTM4boNZgkJk=;
 b=E1mxi+ndjd34DOM31rmOLBYOTA1GPBc/R1kLtq8j9ijF/1mrix/z3xj+rUZ+8biZwO
 0h3dyXw76lGcYa4v3OSX8Hn4ATCzK60Bz60WPNqkx3ysi4UKY8jazyguaZkwqGzrMe4d
 SJkOZf1Ybe2GvFZg0Pk45o8rm5NbWS23MDrN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743606791; x=1744211591;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kf9pc5I8ZYh8TUyZymUAEA7SIelm5p1ZTM4boNZgkJk=;
 b=XzZEwqzj77Yh3JMVvjI7Mzdf1cBJjUH2tukJV7yBwzPoDra50OPEmbrsuNWyBRi1Tr
 j9AVH23p4QuRlJRJA38LMg6SeXMpx+Y8zpB/RiWjoGcWKDxShHmiRmQo7uCoaUgQ3Smw
 o8xfxuqwOMCmZ7Ec7+gKqsRMgWo0dnFeSMbl9z3OXZ/AXXQZpKCSmItCEuuHdogR5inm
 JBHnupZHNLwtwwvUU9GSlm7YnYkKxIbEgOyOveNVwqDJsWrBs+dIm2be8wzhh8a6QMkQ
 CjdLmmcmKGU8Hu2WSLHGKvIrMbaUq2inOmwUqi8RwRO+VtMrXTvxihINIy5Zb7aHehua
 JduA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQBapEXROCd+wYjcXiKxOf1Xy6qr1+WteGEQqM4AQNEvXZKek/Ic4v3NdOQm+i6viHuK1zOSE=@lists.denx.de
X-Gm-Message-State: AOJu0Yw3O2zqWQ4pnsFzGJK9rdO1VWUtam2tvSfD96cf40hfsCjP7ES/
 3uYWpLiDg5WLO7mh+aVWIvZ8pNMNqgx3Ajiyjyc0byBQayBLiFtRBeRzy6CxiEs=
X-Gm-Gg: ASbGncuRlC7N0I7GrNyfsOPaXOM188aobJbo1ZEsUQ+XfQb9+547PiDeA1pfClMSYwh
 qFct1wSD2Z9fOqdqfwonRKWnKlbZCLBFcF2/sd9nLb5xnCMm1OtbKglnpUxUatOXnxoV26m066y
 k3GeMqv2/gT66VkhwAFoYo5NRnEyof0KPYkbu0AfQVJc/ghCnfmAETNQFZ2mdo3b2gEsei21BOy
 OspKncLoYKznqkTQsaPT8B3nw1nYnZ3KWdfJFJ+D4LTocXcYFcCkcgoSE7gZ6VxtEl928GH/Nmx
 GRe7xZtMd5yFxRvw2PdcLdlN8CxBO8WNdGfQCrCRvG4Ehvj98qW7zJ9VYOgu2WtldSRkHWtn6nT
 VYukAXZh85PejbH2L
X-Google-Smtp-Source: AGHT+IFtjle6YiC95TN4Jr/aW+sEBMy1QUF5q0caWFSK8d2OtF3N7q/5AoIAuKJ/B08bwnk+f5+UCw==
X-Received: by 2002:a05:6820:1ad4:b0:603:fa95:9777 with SMTP id
 006d021491bc7-604029d217fmr1511359eaf.0.1743606790744; 
 Wed, 02 Apr 2025 08:13:10 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-602845027b6sm2229774eaf.16.2025.04.02.08.13.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Apr 2025 08:13:09 -0700 (PDT)
Date: Wed, 2 Apr 2025 09:13:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] env: Introduce support for SPI NAND flash
Message-ID: <20250402151307.GX5495@bill-the-cat>
References: <20250401225803.27519-1-ansuelsmth@gmail.com>
 <20250402150542.GV5495@bill-the-cat>
 <67ed536a.050a0220.3bc19f.b184@mx.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="IUPhj02A7A5BJ6q/"
Content-Disposition: inline
In-Reply-To: <67ed536a.050a0220.3bc19f.b184@mx.google.com>
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


--IUPhj02A7A5BJ6q/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 02, 2025 at 05:10:31PM +0200, Christian Marangi wrote:
> On Wed, Apr 02, 2025 at 09:05:42AM -0600, Tom Rini wrote:
> > On Wed, Apr 02, 2025 at 12:57:57AM +0200, Christian Marangi wrote:
> >=20
> > > Introduce support for SPI NAND flash. Currently we only support SPI
> > > flash based on the lagacy sf cmd that assume SPI flash are always NOR.
> > > This is not the case as to SPI controller also NAND can be attached. =
Add
> > > support for it by adding an env driver that base entirely on the MTD
> > > api.
> > >=20
> > > Introduce a new kconfig ENV_IS_IN_SPI_NAND_FLASH and
> > > CONFIG_SYS_SNAND_ENV_DEV to define the name of the SPI nand as exposed
> > > by mtd list.
> > >=20
> > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > ---
> > >  env/Kconfig            |  41 ++++-
> > >  env/Makefile           |   1 +
> > >  env/env.c              |   3 +
> > >  env/snand.c            | 338 +++++++++++++++++++++++++++++++++++++++=
++
> > >  include/env_internal.h |   1 +
> > >  5 files changed, 380 insertions(+), 4 deletions(-)
> > >  create mode 100644 env/snand.c
> >=20
> > Since this uses the generic mtd API, it can also support SPI NOR, and
> > "regular" NAND too yes? If so, I'd like to see this named more
> > generically (and my feedback about naming things from the UFS one
> > applies here too), and then perhaps a follow-up converting some other
> > platforms to use this? Thanks.
> >=20
>=20
> I assume yes. So maybe we can change this to env/mtd.c? Any hint for a
> better name?

Sounds good to me.

> Can you link the feedback from UFS, I can't find it.

Here:
https://lore.kernel.org/u-boot/7a5ac5c2-5bb7-45d2-838b-63fa07766c4f@linaro.=
org/T/#m90111fe8a18efad7fc4f4e03745fe5e7b00db028

--=20
Tom

--IUPhj02A7A5BJ6q/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmftVAMACgkQFHw5/5Y0
tyzw5gv+PQmRicBnxLKLxz7wWtKFIaGVGaJPpYMXswupJVxkajMk1w4KwgEbBVir
37OIsIUX/coge1oiQpfu3zp7OqChUf4SAf079mt18214X26h+JBZkwItBlP6dVMX
7qwVVtoSn6c2CVjI8hcVcX7j/QQ/7uXRaWaEVUXPoYgv+j4I2axnvuwuGM9UNbZP
TPK9ilNuk/rCdoF4xaRu1QhsEwS92Di0OJN3R8U6uJR3G4BmgAsGHtoC0GhDAUec
QHSwhwZZ0cr2sMSN6mWjHZPfeIHvKMk8wVCM/eeEJe7N3VLB9813TA9B8fEGxAom
6hIvjI3BYXH+yb31t2WxUUgdMdO+Yp6CtDlhmiyMldYzZOau97VG7GBxh/OOGTbe
8VhnX8wEpaj8M2ywLcmapyOtqr7LAyWrH1BRiLwc4y8xyxG3LjX5XwDlvLxjWFNY
2t2/+LuubZgxr485q7D86k+jxaSISvcbntNf4wkbOUyFIzsVb2z4gDyoZpR9xOyD
JWWOPrXB
=/iXZ
-----END PGP SIGNATURE-----

--IUPhj02A7A5BJ6q/--
