Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60E0BC48297
	for <u-boot@archiver.kernel.org>; Fri,  9 Feb 2024 22:30:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 943E787E6F;
	Fri,  9 Feb 2024 23:30:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nc8iB8l1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FB7F87E7F; Fri,  9 Feb 2024 23:30:44 +0100 (CET)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5A4187E6E
 for <u-boot@lists.denx.de>; Fri,  9 Feb 2024 23:30:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-7857964f57aso63662485a.1
 for <u-boot@lists.denx.de>; Fri, 09 Feb 2024 14:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1707517840; x=1708122640; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BOCsjP6/w8m7gijfsPQapQKb+UMDWobSVK8jHgw4PKY=;
 b=nc8iB8l1McJrHw+CXdAMtVwCakt1v+URX5anJm3PVde1Oe2VTYnLQEjK8p2rUcUkfA
 6o0S00bj7w/v9bGjoZY2071p0cVub7wDajL1ciW167raT3FBDbMwuu/vBLqvEJAfqtdF
 JKd3Q5IhACzp9uaIEnmIJTmbaC4QpNei7SayY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707517840; x=1708122640;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BOCsjP6/w8m7gijfsPQapQKb+UMDWobSVK8jHgw4PKY=;
 b=a02kJUu85O8XjTp2S9Xn6x3nvpo4h9E5COBde4LbIwVDnXw3sShMT4eN1mULigUhvl
 MGFXLKXHaiaJp6JaOWYK5uba3PZh83fdhAPqHcMHxivxeJi9x9fcaFZDeSAELInJnNpG
 nmXi+1AT+lGeqNrZL6I9wJz7gg4/6+SEGRJCfSHfG7CyIZTO0tYvXZFao6tQNa90hEsO
 DYqejB51N0iChUlGIv2Yj0ytOarcApKkD+2BLbAAOGwH+Ny7CeOdgoB5sT/PTiPxoNeg
 zrXZ47HtmuwEsTCn7vkYFBpJ9fnYhMgHGEVn2I5CIrG1BQef9fXL/O3MqIBDI8nyWnXC
 XvJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEDRoYF0IZrZDRzbJhrm8RudQSXFyn3Qv0ZLNKeCCwAI75H4DDQIQACmhiduN128FiEvBletPm9wNco/rm+S5FQSs9Zg==
X-Gm-Message-State: AOJu0Yx3puR0mtce+K3liEnc2dAguL3S21iVV+bDB6NA9rSRQgJxKTC8
 BXrbD9oo/WBQU+ivM7Mpd4hZHOz4uTH/kjLSFIkOqMM4fpTiUy3qHo3x5M4XZ4U=
X-Google-Smtp-Source: AGHT+IFFjLoAU3KzmicBvbAN3mj3gUukupfYBVRyU5xVX72Jd3KQ6zEkpR1dDgTqYSxtlK/H8fht4w==
X-Received: by 2002:a05:620a:9da:b0:785:5b35:d64 with SMTP id
 y26-20020a05620a09da00b007855b350d64mr438193qky.71.1707517840592; 
 Fri, 09 Feb 2024 14:30:40 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWunwFs9OPxYccTLzLXq9KmCaLOiZIPgfokXZDegyNrQvwD2Njwcz7/amDY+QkY2cNUvxjVfF+hDttoS8os33oh2/BMiOETEpvsLYLhCuICVd9dvZCtkmKH518RUqctJvRTneWm1yxOf+7Pf2oNcBEAXtu4gGPbd0VyUlqvYKcUuDKyKFo5A+YLDsp65oNL5vgi4iWm9BZ49vzU/oLikX+G3eU4e/CAS4HGJbzJfpsYAr/njJPG2I7hyRWUwmo0BUDl6MEJBvqBtPmTFIN2jygCTIgbkawXklIHUoHtGudPXrROp91N+awNJaiHNc5e0ISwo+uXZyfStMlY0LQMg60q2RRTM8Dg1nsPdxm6QkAC8JNEBgiRLS72tcvITkWw5VjHeuuhyQ==
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 y20-20020a05620a44d400b00783f70bc497sm136995qkp.115.2024.02.09.14.30.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 14:30:40 -0800 (PST)
Date: Fri, 9 Feb 2024 17:30:37 -0500
From: Tom Rini <trini@konsulko.com>
To: Nishanth Menon <nm@ti.com>
Cc: Kamlesh Gurudasani <kamlesh@ti.com>, Sinthu Raja <sinthu.raja@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Roger Quadros <rogerq@kernel.org>, Simon Glass <sjg@chromium.org>,
 Andrew Davis <afd@ti.com>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nikhil M Jain <n-jain1@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Bryan Brattlof <bb@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, u-boot@lists.denx.de,
 Jon Humphreys <j-humphreys@ti.com>
Subject: Re: [PATCH V3 04/11] board: ti: am62x: Set fdtfile from C code
 instead of findfdt script
Message-ID: <20240209223037.GA3031127@bill-the-cat>
References: <20240130130615.670783-1-nm@ti.com>
 <20240130130615.670783-5-nm@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DsUYPoG429wj5xn3"
Content-Disposition: inline
In-Reply-To: <20240130130615.670783-5-nm@ti.com>
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


--DsUYPoG429wj5xn3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 07:06:08AM -0600, Nishanth Menon wrote:

> Stop using the findfdt script and switch to setting the fdtfile from
> C code.
>=20
> While at this, replace findfdt in environment with a warning as it is
> no longer needed
>=20
> Reviewed-by: Jonathan Humphreys <j-humphreys@ti.com>
> Reviewed-by: Roger Quadros <rogerq@kernel.org>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> Changes in V3:
> - none other than picking up reviews.
>=20
> V2: https://lore.kernel.org/r/20240109191506.3820908-4-nm@ti.com
>=20
>  board/ti/am62x/am62x.env        | 1 -
>  board/ti/am62x/evm.c            | 8 ++++++++
>  configs/am62x_evm_a53_defconfig | 1 +
>  3 files changed, 9 insertions(+), 1 deletion(-)

This introduces:
+(am62x_evm_a53) board/ti/am62x/evm.c: In function 'board_late_init':
+(am62x_evm_a53) board/ti/am62x/evm.c:60:9: error: implicit declaration of =
function 'ti_set_fdt_env' [-Werror=3Dimplicit-function-declaration]
+(am62x_evm_a53)    60 |         ti_set_fdt_env(NULL, NULL);
+(am62x_evm_a53)       |         ^~~~~~~~~~~~~~
+(am62x_evm_a53) cc1: all warnings being treated as errors
+(am62x_evm_a53) make[2]: *** [scripts/Makefile.build:257: board/ti/am62x/e=
vm.o] Error 1
+(am62x_evm_a53) make[1]: *** [Makefile:1859: board/ti/am62x] Error 2
+(am62x_evm_a53) make: *** [Makefile:177: sub-make] Error 2

--=20
Tom

--DsUYPoG429wj5xn3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXGp4kACgkQFHw5/5Y0
tyzjsAwAoTvVNhw6pRuz4C3dNLOZU7Fftzs2QGRpdxS+a7K6oSPp6wjQRWkRbOER
ivyMYpvbPibqYkxhYNg2bmPxVOyofi5a15bhJTdl6+6jr9znmC05nEC7vVBFWz8L
FzGSWdAIr1cUi4OQEd9xP53jYTI7de/Ya0HV3LWX8pSiaD8nhizmmLqRAZpGbJpL
F7UGOLMzFhqpWYjoS6zkJtaPXa1MWep9Hu+V3AeZ/08LCFk8rv2dKodQ0flgQzQQ
JhdOFbIY86qQ2dj0Nw86KiqwwTJQFAFnhspR7eqUpdF4WytrxTjwO+K2dAKEH/3+
3u+GC4LW4/DHydX93GLk0RvoG4/ZfDTUTh+7WRpnqGrH9PM6EogHP/e8BGtVa59p
TiE7uYXk56CjBsXFv/jZWtcaQFjr2DBKzbzPnhym6//xgDNc+lQNBqojayKlTye0
+jEEuCQojQ9UlsXYAPc0wQC4NyPq9HBbkEcCPNuB1CuI4P6auJrhgLJZ4xLoW2OF
llZpXBQ1
=IBcf
-----END PGP SIGNATURE-----

--DsUYPoG429wj5xn3--
