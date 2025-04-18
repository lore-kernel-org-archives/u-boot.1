Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A514C369AB
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 13:33:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A65F882A3B;
	Fri, 18 Apr 2025 15:33:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eLyeKAGE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65D9482A3B; Fri, 18 Apr 2025 15:33:22 +0200 (CEST)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C60F82A1C
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 15:33:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-6042c04fd18so880345eaf.2
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 06:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744983199; x=1745587999; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SuoudUQe8+OuDfnKwxYFxDuuG+EwTEZhuabqsyi8xhg=;
 b=eLyeKAGEo/FpT/3A9dtgTNyWllvweQISXS3GUTtNzvC0YWWRtIq//vtQgJj1T6MWpK
 Awxldz80p42h3BpielgLGjc7MOQXZ5qhRfDKcCjy2MjXN49WvEOt2OqjC0rgvsgqucYh
 E1xPNVboioOxXrWo9gsIG0loP5yZBrShQECZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744983199; x=1745587999;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SuoudUQe8+OuDfnKwxYFxDuuG+EwTEZhuabqsyi8xhg=;
 b=I1ZWvVBa4ZSLmvUeBQ6SLcbvoAROLGnoHUCL3Ig52JQh/osixO+rfIETlALQlFmXrI
 s0jOjH9XZ7+mL1iW26qGeVaP/D4O5JgXggkGSldNLjN/v6d1tkAEPhnkjKzTIVpPygtZ
 avXIB7jfn++O5JoPSHR2YUoWtkJt23ryd3FIJ2YwbfjyovEJohsZFWx9lBlrassB75KC
 xrVkfl2KW4PNPIv0BwZfU2nebSbSalupmxaAbHJT/lft5y+TAr5W52wH/D8/Q0/u6ZdM
 XNwLseg6ImlXMam/jrNDU1NsyToSq7iUVnXyMUK1pijh0H/dsD5JwXujF/E+AMIe3XeD
 JXLg==
X-Gm-Message-State: AOJu0YzgNhh5c0h9TcJL4KLhOOZYk/uJK8u33lIVuOlS+JzOveBDtZ6X
 K0JNiI6KByRNxz2H6TNRe/dE2tz0KsxxlALUWB1WVf2dWSU1b/4EZ7M62z9b+4s=
X-Gm-Gg: ASbGncuKt7kYZFsZuF77J9kAojjoc8ZoBoNij3Af0jEf5tn0KRvkBwU0MYBiT1bL/XV
 AF0iohNgJbSC2T52RuJU9Q15KQX9sxuvHUY+jGvS7pb/ids9mjU8oSuD9MATtHdlot2+zQYZm+i
 MBWHeJspUgJaYzquDdaJGgzdRV8Np98R71Ma2AYTN6MZIE8gRzn/YrP/BDJGqNbblasVKm1fFxi
 FJsefiGdjpmTj215BXbsTn3ze2yubGtEaN1Tspxxys06g1E5CPVceyCL8eTGgbWR9zyHB923Hsz
 kPJWklJwerYPyONCSeFYtIDUZz54jnLQHk7v6swUn0NuDoy2wdyE9EyJSVu/EdQJ3T9eMTtiD5C
 HKFMK3PTf5swt
X-Google-Smtp-Source: AGHT+IFNWMCue3L0Fj2tiLvSFSnWGiVVEYnZMssCJrz7pb7+dpCJ2pOJd2F6Oa36szXyLW6m6HfWIA==
X-Received: by 2002:a05:6820:2295:b0:604:6b0:c259 with SMTP id
 006d021491bc7-6060053e971mr1572381eaf.4.1744983198854; 
 Fri, 18 Apr 2025 06:33:18 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-605ff69cc32sm367121eaf.29.2025.04.18.06.33.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Apr 2025 06:33:18 -0700 (PDT)
Date: Fri, 18 Apr 2025 07:33:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jonas Karlman <jonas@kwiboo.se>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Matthew Garrett <mgarrett@aurora.tech>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH 0/3] booti: Remove the SYS_BOOTM_LEN limit for booti
Message-ID: <20250418133315.GJ5495@bill-the-cat>
References: <20250418125111.2193434-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qOoIW+46ZCApZ6+A"
Content-Disposition: inline
In-Reply-To: <20250418125111.2193434-1-sjg@chromium.org>
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


--qOoIW+46ZCApZ6+A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 18, 2025 at 06:50:59AM -0600, Simon Glass wrote:

> This series restores the original behaviour of extlinux booting linux
> 'Image' files, which is to ignore CONFIG_SYS_BOOTM_LEN and instead uses
> a limit of 10x the compressed size.
>=20
> It also adds RISC-V support, since it uses a similar format to ARM64.
>=20
> Future work should integrate the code in 'booti' into main 'bootm'
> logic.
>=20
>=20
> Simon Glass (3):
>   boot: Add a function to check if a linux Image is supported
>   bootm: Add RISC-V support in booti_is_supported()
>   booti: Allow ignoring SYS_BOOTM_LEN with the booti command
>=20
>  boot/bootm.c    | 31 +++++++++++++++++++++++++------
>  cmd/booti.c     |  1 +
>  include/bootm.h |  3 +++
>  3 files changed, 29 insertions(+), 6 deletions(-)

This is like pulling teeth. We aren't ignoring SYS_BOOTM_LEN so much as
it was never relevant here to start with. The documentation
(doc/usage/cmd/booti.rst) has explained that we use 10 x
kernel_comp_size for the limit. The "bootm" namespace has largely been
about uImage (and then FIT images when not using it's own namespace)
images and not applied elsewhere, which is why bootz/booti handled
things outside that namespace. And then, still, this series doesn't
unify cmd/booti.c with your changes, it just introduces duplicated
functionality, which is generally understood to be a bad thing.

So again, please do similar to what you did for cmd/bootz.c and that
report and move the existing functionality over. We can then look at
cleaning it up (which should look like / abstract what we do for
compressed FIT images) as a follow up, in order to make bisecting any
regressions here easier down the line. Thanks.

--=20
Tom

--qOoIW+46ZCApZ6+A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGyBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgCVJAACgkQFHw5/5Y0
tyyTlwv4sEhGcUDYSAQNKgM2ZxWn6lyh76B+ukywL/CE9IT7ACfph0I+Wn1tqxw9
RyXDxlt+uRkih+RFccCDHiZWna79GSBLd+q9X8vSkImuhObRHyTsewTFrgP0xb05
X5r8uoNz4ohV5SOxmj6vjZWc29zo8pre55zCTKZpRXn7je/pzsdYMfT8qYFPWgL5
vQeTWfh8W5mQ6jq2QbhYW9eYWwgSc4GIhHjn1SYK7825u9zREY4FKMTsKxjFq4KI
w2V9y3JIQJd6AW0TDyLPqUYpJ6AGmYLkNVldAYBQMzLfvV53JlI2PeXqKBzdtQHj
YHZTmol+QnnT9HV2yi8ppn2SSXxmEGMv7vLPPUn/jlB5g5sMhiC1BZgYHhSuxg/a
sA3S4YvGanNx93YBBIWl+NtOGFI0YT7RLLSpiJi+RGOkvXx4ehYUoka5X4E+vloS
P1OpsarOPNu7QZXhdbJRQpt0MCIem4/D9fBfFW44+Bx6ipalczunRP7j6noqKN7C
IjjTOto=
=aek8
-----END PGP SIGNATURE-----

--qOoIW+46ZCApZ6+A--
