Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BDEDC25B10
	for <u-boot@archiver.kernel.org>; Fri, 10 May 2024 17:32:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8451587EF7;
	Fri, 10 May 2024 19:32:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qmrnVoj9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0B4088027; Fri, 10 May 2024 19:32:09 +0200 (CEST)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5604587EF5
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 19:32:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-439656c1b50so12810701cf.1
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 10:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715362326; x=1715967126; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/AL6GzQ8FgCmFZfCx6kHP+ZOfYsBsyIteBhLn2YQReI=;
 b=qmrnVoj9kv0GmPOPm7e2SATtkB9PN/KkKOIcRZCPepAS0T55Y7yGj7orJ3t9eGpVPs
 2U/b07MDg3Ron7KD1zYMneraTogYsuu9mhowi+9SLeSP02xMPjGjanHLN0M+YYOz26Sg
 78xDj3rYRWvycHHIZOHnrXYjKMlwZLAwuR0yo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715362326; x=1715967126;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/AL6GzQ8FgCmFZfCx6kHP+ZOfYsBsyIteBhLn2YQReI=;
 b=hQJDKv9bus9A70yJn1fU5A4SjYowZUO2/mdjBV9g8h5Yj/zs9Yw57jaAxGEMXNdaNm
 UcJs3PfUgbpOABYmK6oQRz6AqXeW+yuYw3A/wpC75d9C/iJsLJ4OoX5N6zjZbG9QqTvv
 gMKCWiqck9GjhrxmGnermNjdeHzYrk6WL74SROUWuH4+y0gAknLyb/UXiuLGC5Et+4Do
 Jw3FvPez4Wu8XRvj21gwglNFcMyHFEdWvDf2hw5kNUcX4IqBnf06ovv/MjR1wrvUQK+W
 uffuPxTj+p/2joHCq9rBOTujTyW0yyO2VHRePgRlLFXI6ilv9IREAQ3xvulzbypkiIma
 A8gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUof5rUt5/uqOf9e7Wc99lwDdldq3qSnPzy6LzdgEvOmr1yownX1J5ZsxdYRBhdKRFMgz5uqwz65HzIoGS1tRcTOpb+ig==
X-Gm-Message-State: AOJu0Yyr34jJR4mspjAMLdO6EpWZziGEy4ssyDWApl/vCaKEIaCfmGIk
 obImMuAiOOLCDNXnkE5e+AYOq+zy6zgRlFel/vdIq/FJN0xawcsgZ+KEjwSp0Vo=
X-Google-Smtp-Source: AGHT+IGxqSkNn9Tq6mIuk7XZta3RDvBiy0d+NnMPlG7QLZK5oMvZIoZP8qKoi9E2LkkE2xet9GsKyQ==
X-Received: by 2002:ac8:58d4:0:b0:43a:df11:f872 with SMTP id
 d75a77b69052e-43dfda8cebcmr35578871cf.4.1715362326073; 
 Fri, 10 May 2024 10:32:06 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43df55273cfsm23599541cf.49.2024.05.10.10.32.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 May 2024 10:32:05 -0700 (PDT)
Date: Fri, 10 May 2024 11:32:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Jonathan Humphreys <j-humphreys@ti.com>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Judith Mendez <jm@ti.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>, Simon Glass <sjg@chromium.org>,
 Nikhil M Jain <n-jain1@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Maxime Ripard <mripard@kernel.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Roger Quadros <rogerq@kernel.org>, Bryan Brattlof <bb@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 4/7] dts: beagleplay: binman: Include firmware
 capsules binman nodes
Message-ID: <20240510173200.GV2568172@bill-the-cat>
References: <20240419212819.170033-1-j-humphreys@ti.com>
 <20240419212819.170033-5-j-humphreys@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9TyPSf/MfPk2jSP9"
Content-Disposition: inline
In-Reply-To: <20240419212819.170033-5-j-humphreys@ti.com>
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


--9TyPSf/MfPk2jSP9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 04:28:16PM -0500, Jonathan Humphreys wrote:

> Fill in the BeaglePlay's capsule GUID properties of the base binman capsu=
le
> nodes.
>=20
> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
> ---
>  arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi | 27 ++++++++++++++++++++
>  arch/arm/dts/k3-am625-r5-beagleplay.dts      | 15 +++++++++++
>  2 files changed, 42 insertions(+)

This series introduces failure to build in CI, and it's a little tricky
to replicate locally, depending on your environment. You first need to
NOT have BINMAN_INDIRS set and instead be using fake binaries. Second,
it seems python version dependent perhaps? I don't see this on my host,
but by:
- Using the CI container
- Setting up a virtualenv inside of it
- pip install -r tools/buildman/requirements.txt
I get:
$ ./tools/buildman/buildman --keep-outputs --reproducible-builds -dvel --fo=
rce-build -PEWM --output /tmp/am62x_beagleplay_r5 --board am62x_beagleplay_=
r5
Building current source for 1 boards (1 thread, 12 jobs per thread)
       arm:  +   am62x_beagleplay_r5
+(am62x_beagleplay_r5) Image 'tiboot3-am62x-gp-evm.bin' is missing optional=
 external blobs but is still functional: ti-fs-gp.bin
+(am62x_beagleplay_r5)
+(am62x_beagleplay_r5) /binman/tiboot3-am62x-gp-evm.bin/ti-fs-gp.bin (ti-sy=
sfw/ti-fs-firmware-am62x-gp.bin):
+(am62x_beagleplay_r5)    Missing blob
+(am62x_beagleplay_r5) binman: object of type 'NoneType' has no len()
+(am62x_beagleplay_r5) make[1]: *** [Makefile:1126: .binman_stamp] Error 1
+(am62x_beagleplay_r5) make: *** [Makefile:177: sub-make] Error 2
    0    0    1 /1              am62x_beagleplay_r5

--=20
Tom

--9TyPSf/MfPk2jSP9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmY+WgwACgkQFHw5/5Y0
tyySgQwApfDxABzpwQvs0zmpEjQ+5A7eoj6vwA2dGL8/Cvsa+ozD4MBPef9EsOmm
Uc91aV6iHP0yItxxY+YNyJ/noB/mJJ5ClMAqFuqf1EruXXUsy7aLvjaXsdQz+JZz
dV+WJL4IUrSqXe+ayvBfUV1LCRSo/o/YbQnkaO/f1i2TJ5veGfV0Hq2l7/BNEqWl
C0ugWKOoGKerwUM3a40iVFLqkWMDX53cC9z1bBOgq3L6fCfNBVnLRqkCIoiQ7ZLN
dwEzIdd8XRDDfqAWz/F60O/mGvdhGtjfYRrHOib17cZ54bRyYzjTonGLz3SfJ7Ne
kB5qpMZkKMFtTDIiv3nvQHJ6uJngY7IP2aeN1UexWfra9oeyb3Ovc0Qq86FIrytm
uJNuyKR9QrBdV8CAg4B3IXECVTKAbgCvfkB/e+VAo3qu13Jg3bQ0Ke6zBa0/EfNk
ULmoaUfUCStsLvhiOXZPuSp28ljqWzhysM1SDFJgPLtCRbSz5sZBeleJuArXfmdR
FR34SRHl
=GMQR
-----END PGP SIGNATURE-----

--9TyPSf/MfPk2jSP9--
