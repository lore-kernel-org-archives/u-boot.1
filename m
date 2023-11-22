Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F7F6C61D97
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 21:09:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77C7B87655;
	Wed, 22 Nov 2023 22:09:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mVwhuYZw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83B8087669; Wed, 22 Nov 2023 22:09:10 +0100 (CET)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 601EC87590
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 22:09:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-da0cfcb9f40so213484276.2
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 13:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700687347; x=1701292147; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0RDapowTpJzev7CXPhZppQj3FyDwCO6KUmK6CYeHX64=;
 b=mVwhuYZwGIeXIr4+qRxp9B2hHZI12h1v4sDEAsw5LF3l68qUyfjGOoSGEfGmmNm7W4
 hFNQG1TJXcmqZa0lj/dsViavlw3Kd0Khu3lnBn7tVvKZUjqB/K/Q7fxF6ngrBTgfGaXw
 R3WZHQAn/Er/UImOMpeAc1fRbxGxconiwTo6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700687347; x=1701292147;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0RDapowTpJzev7CXPhZppQj3FyDwCO6KUmK6CYeHX64=;
 b=O0zW/RtEQI/d99St7cTlBK/8zoQnWbDQoAsch/btGD922LzIf5nxwoIgYXhSd6y6TF
 ZHiO2fP1gtCLOzIqJfeejOvxXfzZrxls/FrLeHnR9f/yIpcfQOuItkfo+5894hmjMKzP
 CN+yoq6oDDLijJLTcv2he29Bvcu5k/r2vxuSQLob+4vguE6EAp75KoHA1t3DO+ciwwi/
 jPRtsyrTYBuE7Cgfc9MLVuuQTZu9WGX4SAcGjiFAYST9G+8TZzfI7h21G4y8UrfOKVxL
 GjFeOhp+W7svXzVizJiNXpZr6aXqOTaZ17Lf35KE/4cAW2RKic2H582DoJIi2qR30CTQ
 Sk+A==
X-Gm-Message-State: AOJu0YwuGyDYqyGaDj5SWw/WyrV59saV2zWobVL8eqBTNV2sU4sAsf0J
 uS3u2YPUKGiDtnK6T8CV7P9cUWTwlY5ngl7vY5evpQ==
X-Google-Smtp-Source: AGHT+IGajCdF0idl2wiOcDlB0ITTmS1LperoZt2ICFRsTWxfXJZYtR4u7+OBOg0TT8JRs/6LX61IwQ==
X-Received: by 2002:a25:b298:0:b0:db3:fac6:faea with SMTP id
 k24-20020a25b298000000b00db3fac6faeamr3944660ybj.55.1700687347100; 
 Wed, 22 Nov 2023 13:09:07 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-999e-39fe-b112-e0fa.res6.spectrum.com.
 [2603:6081:7b00:6400:999e:39fe:b112:e0fa])
 by smtp.gmail.com with ESMTPSA id
 e193-20020a2537ca000000b00da06fc45421sm1583411yba.54.2023.11.22.13.09.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Nov 2023 13:09:05 -0800 (PST)
Date: Wed, 22 Nov 2023 16:09:03 -0500
From: Tom Rini <trini@konsulko.com>
To: Angelo Dureghello <angelo@kernel-space.org>
Cc: u-boot@lists.denx.de, Huan Wang <alison.wang@nxp.com>
Subject: Re: [PATCH 04/11] m68k: Rework asm/global_data.h slightly
Message-ID: <20231122210903.GT2513409@bill-the-cat>
References: <20231122131154.2444690-1-trini@konsulko.com>
 <20231122131154.2444690-4-trini@konsulko.com>
 <8d7b5e58-031b-d3bd-7270-b19c8e2a13cd@kernel-space.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2OwKRCjVZPGts7F/"
Content-Disposition: inline
In-Reply-To: <8d7b5e58-031b-d3bd-7270-b19c8e2a13cd@kernel-space.org>
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


--2OwKRCjVZPGts7F/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 10:04:38PM +0100, Angelo Dureghello wrote:
> Hi Tom,
>=20
> thanks,
>=20
> On 22/11/23 2:11 PM, Tom Rini wrote:
> > In the architecture global data, replace the one case of u32 with
> > unsigned long. Now, we can drop config.h here but then do need to add it
> > in two m68k-centric spaces.
> >=20
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> > Cc: Huan Wang <alison.wang@nxp.com>
> > Cc: Angelo Dureghello <angelo@kernel-space.org>
> > ---
> >   arch/m68k/include/asm/cache.h       | 2 ++
> >   arch/m68k/include/asm/global_data.h | 4 +---
> >   arch/m68k/lib/traps.c               | 1 +
> >   3 files changed, 4 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/arch/m68k/include/asm/cache.h b/arch/m68k/include/asm/cach=
e.h
> > index 8ed2b4dbab47..6ef7f7be1af8 100644
> > --- a/arch/m68k/include/asm/cache.h
> > +++ b/arch/m68k/include/asm/cache.h
> > @@ -9,6 +9,8 @@
> >   #ifndef __CACHE_H
> >   #define __CACHE_H
> > +#include <config.h>
> > +
> >   #if defined(CONFIG_MCF520x) || defined(CONFIG_MCF523x) || \
> >       defined(CONFIG_MCF52x2)
> >   #define CFG_CF_V2
> > diff --git a/arch/m68k/include/asm/global_data.h b/arch/m68k/include/as=
m/global_data.h
> > index 5f576ba16f9a..c2ef5770a3df 100644
> > --- a/arch/m68k/include/asm/global_data.h
> > +++ b/arch/m68k/include/asm/global_data.h
> > @@ -7,8 +7,6 @@
> >   #ifndef	__ASM_GBL_DATA_H
> >   #define __ASM_GBL_DATA_H
> > -#include <config.h>
> > -
> >   /* Architecture-specific global data */
> >   struct arch_global_data {
> >   #ifdef CONFIG_SYS_I2C_FSL
> > @@ -24,7 +22,7 @@ struct arch_global_data {
> >   	unsigned long sdhc_clk;
> >   #endif
> >   #if defined(CONFIG_FSL_ESDHC)
> > -	u32 sdhc_per_clk;
> > +	unsigned long sdhc_per_clk;
> >   #endif
> >   };
> > diff --git a/arch/m68k/lib/traps.c b/arch/m68k/lib/traps.c
> > index c283351181d8..2a025c5a6e86 100644
> > --- a/arch/m68k/lib/traps.c
> > +++ b/arch/m68k/lib/traps.c
> > @@ -7,6 +7,7 @@
> >    * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
> >    */
> > +#include <config.h>
> >   #include <init.h>
> >   #include <watchdog.h>
> >   #include <command.h>
>=20
>=20
> testing this getting some errors
>=20
> +drivers/watchdog/mcf_wdt.c: In function 'mcf_watchdog_init':
> +drivers/watchdog/mcf_wdt.c:43:26: error: 'CFG_SYS_CLK' undeclared (first
> use in this function)
> +   43 |         cycles_per_sec =3D CFG_SYS_CLK / fixed_divider;
> +      |                          ^~~~~~~~~~~
>=20
>=20
> Seems solved by
>=20
> diff --git a/drivers/watchdog/mcf_wdt.c b/drivers/watchdog/mcf_wdt.c
> index b555bbeb68..f5ff221dd5 100644
> --- a/drivers/watchdog/mcf_wdt.c
> +++ b/drivers/watchdog/mcf_wdt.c
> @@ -11,6 +11,7 @@
>  #include <asm/io.h>
>  #include <wdt.h>
>  #include <linux/bitops.h>
> +#include <config.h>

Did you have the whole series applied? That is a reasonable solution,
but I didn't see a failure here, thanks for the report.

--=20
Tom

--2OwKRCjVZPGts7F/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVebe8ACgkQFHw5/5Y0
tyz0jgwArD7nj7G1E30ifN8JTWb++sXpkT5lTJK+DZgdDSZ82y6+NYzTl8ljSpsb
HWfBuenQRKpnxeDAVbcLQ5AXzhB3hkZjUkZteSDntyuT4ZIVv28TBEOhzBlauE9m
1CvQ8Rlw1BPBsoNSaWXwtRhVf3TNvISot3yharirjMofwSl9rfWzl7wvXRCOCLuO
JZwWBbYjRgqoCzWNQuXzZ2dBmhlAMVwmws1oc1fljbsKBtC/BU8j8lI68mW6p1lj
LwZEW8Vz4W6TPzchgjOUURkXm6a9kvJRtGEAzQ73ZRAbjER8bB9XTqZNHB6QWlei
Tbek8U6PA7is8R5HIgJv+Y21VYYxj+YzH09vWinuZBIuLlVDOBN2UFkGEepWFDSZ
LfceDUVAxDZLlTKZdgVrA9Y1OPXyMJ1Y6qD4T3DJYvGWKusVBO8cyHL6mcnD0pBX
SGI5x8H5/jMbshMLq39aPkZEErJ5lzV4sibddmA7ucG5/d5uLTmqjG/wed1NOLbm
xvC4N4yu
=n+2i
-----END PGP SIGNATURE-----

--2OwKRCjVZPGts7F/--
