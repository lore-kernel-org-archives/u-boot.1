Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EB6FCD5BB0
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 17:03:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24DAF846F1;
	Fri, 22 May 2026 19:03:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ewq18U8+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4047084851; Fri, 22 May 2026 19:03:35 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B82AC846DF
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 19:03:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7dbca22dbfeso4063694a34.1
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 10:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779469411; x=1780074211; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lH9nU/HchQn9WuOJX0xXc8gkVOQzTr/yYHlW+dTNBls=;
 b=Ewq18U8+ANzmKf0eKOBvNCmtm5BbajHdtr3SEKr/5Ph4hOhgk8qmpOMs71ql6lcYZW
 Hmkx4mxOB95YfArNK+UgiESRRQrvI4EbIGSgzjhMoU8QBhW4UAy+5IbTHSApwiUt22l3
 wjDlEk/emBTkbmAJYdf6pMX6YRXQ2EIsQVRGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779469411; x=1780074211;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lH9nU/HchQn9WuOJX0xXc8gkVOQzTr/yYHlW+dTNBls=;
 b=Wu/vzTEk+Qk0TBA6BWhH+EQfJEUjnuXAe6Fq0hrML+g5VzmnFrHcAxJC6fzMuR33eP
 BPg41I/eKGWyyWv3ly3RCmpyjRjEp398Tqm3LwWGPfF+PKuflQwUgDecgXyiinIQXeWr
 eTC7hui5/9/g5AUxUgL1aI/HMoarxnSkm5xBAADDWzdtE4deQ+5wHXY8AQb6aEYhz06D
 DM9d6VO1DWx49+26ScZfNItvAbl2Eutsd9A5Iehgsrnbi4iISxnpUo3CUfXh2qirqsFK
 8rCEFFVDSdhUIUKtQKiArHEGY4HlohTP18hz0RIy8DB9OorPjqh14hVjdHtbPuyLBW+t
 IctQ==
X-Gm-Message-State: AOJu0YxJTMSCCLu0vrxwwW8B71WFXms1JDI/PuTamey7CE0ifKP0AUec
 K2XwTE7OqheJ8DLP9ZVLE2YzYBAEOm8cieNse097COkOB/ODldBqRNCm3OfBgnEh1Q4=
X-Gm-Gg: Acq92OESkpvkwEbct5X7e+QUrkXxB+ntrjeORlZQjVtNLrizz2CTHeiWfkf9vjdDDFo
 H+KqLN+qRf8NP8h0Ab6cR+6HKz7V2MP1EQh7egYy9R/vUA/w9nxzqPHC42JxETLfjL1DahrjPuR
 dBJDs8mlE1OtAHjfwjzW4HjkkrwozkuAHy/5MUSm9y6mPmR5xAKsaEi5/C4ELgJSO1jJtnyz5n8
 zRt+05LUYNfkb8NArm3ZgmAQLCVXB1zW5NX2gH02v7fu+Lo68wXA3L0UbXFAdPhjHh6CJUZsnXz
 RSTL0UJEe3otFx8PquVKbOrg4zFtDvVUEGia+LhJkx1NlheihFKnXiSF+VkCZEtWt+lZhowmd3z
 0yX4+ei+9YXE6+M6+HN9BhA3fEKdjoejGrnttxmX4auWbAlK+rRwrlbmlXf/GKlVtoWOn/dmK+J
 SrjWQHNLb7HhEDrMm2r2MkNvCvLg+bSvMUYuS9kOqds4FMfpnq4vYGOX+GER+hqcmvTcGnX0xgt
 yJEMtJb8KJ6DAgSmlH9ZIHVoMgcNSf8jp1dEH8sXhtYgB51jJQqFQvOwksAT5BFSFU=
X-Received: by 2002:a05:6830:82e8:b0:7d7:fcac:6374 with SMTP id
 46e09a7af769-7e5fecedad3mr2347314a34.8.1779469411081; 
 Fri, 22 May 2026 10:03:31 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-235.totalplay.net.
 [187.191.8.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e6060b2dffsm1386166a34.0.2026.05.22.10.03.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 10:03:30 -0700 (PDT)
Date: Fri, 22 May 2026 11:03:28 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Sean Anderson <seanga2@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Heiko Schocher <hs@nabladev.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH 0/2] Convert env export and import to use getopt()
Message-ID: <20260522170328.GU1858239@bill-the-cat>
References: <20260520201218.3752042-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="10hNYigzd7GlXElK"
Content-Disposition: inline
In-Reply-To: <20260520201218.3752042-1-sjg@chromium.org>
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


--10hNYigzd7GlXElK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 02:12:12PM -0600, Simon Glass wrote:

> U-Boot has had a getopt() implementation for over five years but it is
> not used much; most commands hand-roll their own argv loops to spot
> -x style flags. The env export and env import sub-commands have the
> gnarliest of these parsers in nvedit.c
>=20
> Each one walks every -prefixed argv element by hand, opens an inner
> loop to split grouped flags and tracks a counter to catch a repeated
> format flag.
>=20
> This short series converts both sub-commands to getopt(). The mutex
> check for the format flags is done after the option loop, since it is
> a per-command rule rather than an option-parsing rule, and the trailing
> positional list is read straight out of argv from gs.index onwards.
>=20
> There is no functional change. getopt() stops at the first non-option,
> just as the hand-rolled loops did, so options still have to appear
> before the positional arguments.
>=20
> Each command gains a 'select GETOPT' so the parser is linked in on
> boards that do not already enable it.
>=20
> For firefly-rk3399:
>=20
>   03: cmd: nvedit: Use getopt() in env export
>      aarch64: (for 1/1 boards) all -45.0 rodata +27.0 text -72.0
>   04: cmd: nvedit: Use getopt() in env import
>      aarch64: (for 1/1 boards) all -27.0 rodata -55.0 text +28.0
>=20
>=20
> Simon Glass (2):
>   cmd: nvedit: Use getopt() in env export
>   cmd: nvedit: Use getopt() in env import
>=20
>  cmd/Kconfig  |   2 +
>  cmd/nvedit.c | 186 +++++++++++++++++++++++----------------------------
>  env/common.c |   2 +-
>  3 files changed, 85 insertions(+), 105 deletions(-)

For the record, here's a link to v2:
https://lore.kernel.org/u-boot/20260519233207.2765755-1-sjg@chromium.org/
And here's the full size change for firefly-rk3399:
Summary of 3 commits for 1 boards (1 thread, 12 jobs per thread)
01: arm: Fix typo in linker script
   aarch64:  w+   firefly-rk3399
+(firefly-rk3399) Image 'simple-bin' is missing external blobs and is non-f=
unctional: atf-bl31
+(firefly-rk3399)
+(firefly-rk3399) /binman/simple-bin/fit/images/@atf-SEQ/atf-bl31 (atf-bl31=
):
+(firefly-rk3399)    See the documentation for your board. You may need to =
build ARM Trusted
+(firefly-rk3399)    Firmware and build with BL31=3D/path/to/bl31.bin
+(firefly-rk3399) Image 'simple-bin' is missing optional external blobs but=
 is still functional: tee-os
+(firefly-rk3399) /binman/simple-bin/fit/images/@tee-SEQ/tee-os (tee-os):
+(firefly-rk3399)    See the documentation for your board. You may need to =
build Open Portable
+(firefly-rk3399)    Trusted Execution Environment (OP-TEE) and build with =
TEE=3D/path/to/tee.bin
+(firefly-rk3399) Some images are invalid
02: cmd: nvedit: Use getopt() in env export
   aarch64: (for 1/1 boards) all +883.0 rodata +199.0 text +684.0
            firefly-rk3399 : all +883 rodata +199 text +684
               u-boot: add: 5/0, grow: 0/-2 bytes: 1184/-500 (684)
                 function                                   old     new   d=
elta
                 __getopt                                     -     520    =
+520
                 static.bdinfo_print_all                      -     324    =
+324
                 print_eth                                    -     236    =
+236
                 print_bi_dram                                -      92    =
 +92
                 getopt_init_state                            -      12    =
 +12
                 do_env_export                              548     476    =
 -72
                 do_bdinfo                                  588     160    =
-428
03: cmd: nvedit: Use getopt() in env import
   aarch64: (for 1/1 boards) all -27.0 rodata -55.0 text +28.0
            firefly-rk3399 : all -27 rodata -55 text +28
               u-boot: add: 0/0, grow: 1/0 bytes: 28/0 (28)
                 function                                   old     new   d=
elta
                 do_env_import                              668     696    =
 +28

And so this is why I'm just deferring this until someone has the time to
pick up and address the underlying problems with this potential
migration that have been raised in the previous iterations.

--=20
Tom

--10hNYigzd7GlXElK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCahCMXAAKCRAr4qD1Cr/k
CjbOAP9pEG8sZ9+x+BRn3E5jEiW+GmveQHc1PlYCNrrbPFRiJQD48YHgz3Jc95ho
z/gFZKgEQ908fbrSVK7PoRWB5wDyCQ==
=IYvA
-----END PGP SIGNATURE-----

--10hNYigzd7GlXElK--
