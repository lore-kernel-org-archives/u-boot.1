Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 791E4C54E76
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 16:00:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 765AC87168;
	Sun, 19 Nov 2023 16:59:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dUy6Bylc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0B41870E2; Sun, 19 Nov 2023 16:59:29 +0100 (CET)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45E5B8749D
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 16:59:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-da041ffef81so3642527276.0
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 07:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700409552; x=1701014352; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Rchym97Go7b6jGFFnL6wdw2gwGGBnxMWoydUYrE6C/0=;
 b=dUy6BylcRHi3iwW3TuDbzdMUQtLYsEU02dYmFiBWIeL2HBTdgYFu1cj8/ZXoRiPWOd
 ekyUdM2tQpfEWsuv3eVqQ8WaxUj6veHslHKoBfKMb8iosxsQoHpmCgrJW5iqvk65E32N
 DAZWMSkI2ShYQP9DgY+5Z3sqZyIlX0gwinLOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700409552; x=1701014352;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rchym97Go7b6jGFFnL6wdw2gwGGBnxMWoydUYrE6C/0=;
 b=ajTX2x6quo6jXiHdWHgnsup1cO/6/QtM/LmIODLCec5QyDUCxCqD5760z4t9qpSe+x
 91dl0AwwvbMgvt+KpzXdYrpydUbvRx9d+ZFMY5j054q0W1nuf7o9PZW4jy8AVrkciZ/e
 FyhPT6iuc5PbTdV6/mQaGFdP9l82VrZEiRHtqjMc+HxVYlITGbUgoojCJIhEPPkkYeP5
 QRqqDKEaErFGLbd4yoHWbHMRTBFKHtCPTFGi1Wy7Ao6jC6SETPP+5Ebbckx3WJX55h+c
 3TmeP7A4LqZrm446SwPNlTv6wFWMLwYWo6Bx/drmjYw10F53vlcMoyfFF7PpDkZ1fxj3
 FAWQ==
X-Gm-Message-State: AOJu0Yxt8AaOtXzYuO2rL7klASsPfQBhsEc3+0bTWZtFz5FXZzMn7uFl
 H5kkjRLQ/GF7PdhxR9B8584ZEQ==
X-Google-Smtp-Source: AGHT+IGDRV6GsN4MuU/s4IyKW+7fOSZmMAypzz4YHb3hu6QgM1RVUnQRC5E5xaK8FI0ciAFGR6IIRQ==
X-Received: by 2002:a25:8b05:0:b0:d9a:4db9:3259 with SMTP id
 i5-20020a258b05000000b00d9a4db93259mr5002382ybl.38.1700409552158; 
 Sun, 19 Nov 2023 07:59:12 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-af10-dfdb-a5aa-dfc7.res6.spectrum.com.
 [2603:6081:7b00:6400:af10:dfdb:a5aa:dfc7])
 by smtp.gmail.com with ESMTPSA id
 p19-20020a25f453000000b00d815cb9accbsm1522817ybe.32.2023.11.19.07.59.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Nov 2023 07:59:11 -0800 (PST)
Date: Sun, 19 Nov 2023 10:59:09 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Stefan Roese <sr@denx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Anatolij Gustschin <agust@denx.de>, Devarsh Thakkar <devarsht@ti.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Nikhil M Jain <n-jain1@ti.com>, Stefan Roese <sr@denx.de>
Subject: Re: [PATCH 1/5] cyclic: Disable in SPL builds
Message-ID: <20231119155909.GC2513409@bill-the-cat>
References: <20231119144700.631322-1-sjg@chromium.org>
 <20231119144700.631322-2-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rNIwEMRIUqRA4BXj"
Content-Disposition: inline
In-Reply-To: <20231119144700.631322-2-sjg@chromium.org>
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


--rNIwEMRIUqRA4BXj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 19, 2023 at 07:46:39AM -0700, Simon Glass wrote:

> The cyclic subsystem is currently enabled in all build phases or none.
> So far it doesn't have any purpose within SPL builds, so adjust the
> rules to prevent it being built in that case.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  common/Makefile  | 2 +-
>  include/cyclic.h | 6 ++++--
>  2 files changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/common/Makefile b/common/Makefile
> index 1495436d5d45..27443863bf9b 100644
> --- a/common/Makefile
> +++ b/common/Makefile
> @@ -77,7 +77,7 @@ obj-$(CONFIG_CROS_EC) +=3D cros_ec.o
>  obj-y +=3D dlmalloc.o
>  obj-$(CONFIG_$(SPL_TPL_)SYS_MALLOC_F) +=3D malloc_simple.o
> =20
> -obj-$(CONFIG_CYCLIC) +=3D cyclic.o
> +obj-$(CONFIG_$(SPL_TPL_)CYCLIC) +=3D cyclic.o
>  obj-$(CONFIG_$(SPL_TPL_)EVENT) +=3D event.o
> =20
>  obj-$(CONFIG_$(SPL_TPL_)HASH) +=3D hash.o

This is fine, but I suspect we're missing SPL_CYCLIC as a symbol and
SPL_WDT should be select'ing that, same as "WDT".

> diff --git a/include/cyclic.h b/include/cyclic.h
> index 44ad3cb6b803..d3b368dd90df 100644
> --- a/include/cyclic.h
> +++ b/include/cyclic.h
> @@ -11,6 +11,7 @@
>  #ifndef __cyclic_h
>  #define __cyclic_h
> =20
> +#include <linux/kconfig.h>
>  #include <linux/list.h>
>  #include <asm/types.h>

Is this really needed? What's blowing up since we should have -include
=2E../linux/kconfig.h cover this.

--=20
Tom

--rNIwEMRIUqRA4BXj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVaMM0ACgkQFHw5/5Y0
tyygxgwAkGaNA3+8vmggEtaUlup1z4WAIswYeYAix6oiC+cSKUwoyTmRGLEL1m23
B6xcZ39+fG5Hlivz0qi8lqsEjEa284jXuZWSLJP3rOK3GxY4Fa5Kja4rwv7w/0Er
93txJT7BP2xxMF3TBMVmyumgcQP7rFOyqyWamxINibkUzhAO9KU/8a0NvPCvTZRZ
zmCvALaDTDmmZitTju9p7G3ZyCRPL9hIMcmCxZgbF8yCd5XL0SegwvNJqcJVd19F
AkLn0XyLljPPMN6Z37UFVIxAFWgCDFu2RgoPT/Grr+2nCJ3gWl3HBqdA9REJEUNB
Sn37RiTk29tcNQHndXK6igMOWU2qSs6UFk47HwDq1uoa/jlDXOl6OOXaxFm6uI/E
qWU9g5tiUfGDkh6qvYcWR3ehh8m3FSVZ4HJ0673FlsVjWb7V1YzvzbSkTdkpxFu7
TA0Y/dkmTi/gl9N9xZvhtwYsIFhugcDP4ea1x68mCt+eFfu6owJtNMhSPy5/tVWV
r8JW7+js
=9Rve
-----END PGP SIGNATURE-----

--rNIwEMRIUqRA4BXj--
