Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A162DD1A435
	for <u-boot@archiver.kernel.org>; Sat, 12 Oct 2024 04:11:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4E0588936;
	Sat, 12 Oct 2024 06:11:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lsdMBqia";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93E3F893F8; Fri, 11 Oct 2024 23:59:31 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34EC8893E4
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 23:59:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6cb97afcec9so20506916d6.2
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 14:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728683968; x=1729288768; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+tfE9Kb7MKrjYuvM6seluPLTz5U0TjptRjbPbqCfuBU=;
 b=lsdMBqia5qyHffx99T+UztsRVxL/KQaAFDMcy7ukxj4eQgSy9RYRQoWKcVOjxIMhXs
 +vBbweeU3Vpvfr7AIByHwq0b5/eqzOmqks86rbcICn6BCXlm/j/JjT77b4t0qKshRq7a
 1kjjsvnQPco8txWS6L4tRx2OkQJaIjm3c/hi0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728683968; x=1729288768;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+tfE9Kb7MKrjYuvM6seluPLTz5U0TjptRjbPbqCfuBU=;
 b=r2QdfQmXPAM/7bBqyIh5rbeF/xfZa0eIzQpeLX7PcyN+bL3kwxZ+N+gmdV7ZiNcuN6
 ClxAoU3ZJ5FWs+KoTjmkGk0tf4kwOsYgwwuEr2NnSFu58+nSEFShIpQvVf6qWrm9UWFd
 ztnACwzTKngdiJWPriqJqSjrm4sgcmqn+454iB6z+YTG8FuYiSyazZZm5VrDnvdVJl3r
 Kmx6Ankp+pezStWF7Etxr3vvO5VR3Txwcm9/SkW8se4mVMi6bh2FD+sCgQ/yqeYZUidD
 7GLkfCsUcLiyWquOXY0YI+wFygG0nkqLLCQCh0gbUHUSlq+UNqxk4IfrMplor6f4Vgrm
 yvPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWor4cA5IPw7fPrR1fav0bpACrz9TnsbMH8Br1O6A7+VRpGyS0pVzw0ugtidUGpSbj/GctRb3I=@lists.denx.de
X-Gm-Message-State: AOJu0YytC/od3VXDCR3AA0r2YutHKt5DDMXfeOSeGaNDDUCQ6m3cEdVT
 SQFBTz/scBEI+yJOfskkx9fZ1PA7boS17ox1HVaOAag394ioEzAvrSFKFvY++vU=
X-Google-Smtp-Source: AGHT+IF+8f3kRK/lZNEDBQUitNd0m4wGLVNi3aPGPJMSv53iG1AiIJiojpLj4NkLenJl47rNbSSObQ==
X-Received: by 2002:a05:6214:2e46:b0:6cb:4a84:e02a with SMTP id
 6a1803df08f44-6cbeff4f83bmr70543206d6.16.1728683967980; 
 Fri, 11 Oct 2024 14:59:27 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cbe867c43asm19871936d6.138.2024.10.11.14.59.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 14:59:26 -0700 (PDT)
Date: Fri, 11 Oct 2024 15:59:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 manish.pandey2@arm.com, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Sumit Garg <sumit.garg@linaro.org>, Sean Anderson <seanga2@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Andrew Davis <afd@ti.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jonathan Humphreys <j-humphreys@ti.com>, Marek Vasut <marex@denx.de>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Greg Malysa <greg.malysa@timesys.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>, Jonas Karlman <jonas@kwiboo.se>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH v8 03/27] lib: Adapt digest header files to MbedTLS
Message-ID: <20241011215921.GY14210@bill-the-cat>
References: <20241003215112.3103601-1-raymond.mao@linaro.org>
 <20241003215112.3103601-4-raymond.mao@linaro.org>
 <20241009143824.GJ14210@bill-the-cat>
 <CAEfUkUJXa55pJP-DypJy-FGhpkQiSFAS3QB+6s5+55PWmwbZ7Q@mail.gmail.com>
 <CAC_iWj+dBpgCM-WaJBgRyXmn1jWO--tGRTXjAT0hJL5G0V8D0g@mail.gmail.com>
 <20241009175243.GL14210@bill-the-cat>
 <CAEfUkUKT9JJHUcpNn8rFFbRVfpQ8wyYmka4zwZkBKYj2-F-ofA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jbeGw96Yk7+HZyP7"
Content-Disposition: inline
In-Reply-To: <CAEfUkUKT9JJHUcpNn8rFFbRVfpQ8wyYmka4zwZkBKYj2-F-ofA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Sat, 12 Oct 2024 06:11:56 +0200
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


--jbeGw96Yk7+HZyP7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 02:25:20PM -0400, Raymond Mao wrote:
> Hi Tom,
>=20
> On Wed, 9 Oct 2024 at 13:52, Tom Rini <trini@konsulko.com> wrote:
>=20
> > On Wed, Oct 09, 2024 at 08:32:29PM +0300, Ilias Apalodimas wrote:
> > > On Wed, 9 Oct 2024 at 18:32, Raymond Mao <raymond.mao@linaro.org> wro=
te:
> > > >
> > > > Hi Tom,
> > > >
> > > > On Wed, 9 Oct 2024 at 10:38, Tom Rini <trini@konsulko.com> wrote:
> > > >>
> > > >> On Thu, Oct 03, 2024 at 02:50:16PM -0700, Raymond Mao wrote:
> > > >>
> > > >> > Adapt digest header files to support both original libs and Mbed=
TLS
> > > >> > by switching on/off MBEDTLS_LIB_CRYPTO.
> > > >> > Introduce <alg>_LEGACY kconfig for legacy hash implementations.
> > > >> > sha256.o should depend on SHA256 kconfig only but not
> > SUPPORT_EMMC_RPMB,
> > > >> > SHA256 should be selected when SUPPORT_EMMC_RPMB is enabled inst=
ead.
> > > >> >
> > > >> > `IS_ENABLED` or `CONFIG_IS_ENABLED` is not applicable here, since
> > > >> > including <linux/kconfig.h> causes undefined reference on schedu=
le()
> > > >> > with sandbox build, as <linux/kconfig.h> includes
> > <generated/autoconf.h>
> > > >> > which enables `CONFIG_HW_WATCHDOG` and `CONFIG_WATCHDOG` but no
> > schedule()
> > > >> > are defined in sandbox build,
> > > >> > Thus we use `#if defined(CONFIG_MBEDTLS_LIB_CRYPTO)` instead.
> > > >> >
> > > >> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > > >> > Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > >>
> > > >> There's three platforms where we see something like:
> > > >>        arm: (for 1/1 boards) all +5651.0 data +112.0 rodata +139.0
> > text +5400.0
> > > >>             o4-imx6ull-nano: all +5651 data +112 rodata +139 text
> > +5400
> > > >>                u-boot: add: 23/0, grow: 1/0 bytes: 1172/0 (1172)
> > > >>                  function                                   old
> >  new   delta
> > > >>                  hash_command                               108
> >  296    +188
> > > >>                  sha1_finish                                  -
> >  156    +156
> > > >>                  static.sha1_update                           -
> >  114    +114
> > > >>                  hash_algo                                    -
> >  112    +112
> > > >>                  sha1_padding                                 -
> > 64     +64
> > > >>                  hash_lookup_algo                             -
> > 60     +60
> > > >>                  sha1_starts                                  -
> > 52     +52
> > > >>                  crc16_ccitt_wd_buf                           -
> > 36     +36
> > > >>                  sha256_csum_wd                               -
> > 34     +34
> > > >>                  sha1_csum_wd                                 -
> > 34     +34
> > > >>                  hash_finish_sha256                           -
> > 34     +34
> > > >>                  hash_finish_sha1                             -
> > 34     +34
> > > >>                  crc32_wd_buf                                 -
> > 34     +34
> > > >>                  hash_finish_crc32                            -
> > 28     +28
> > > >>                  hash_finish_crc16_ccitt                      -
> > 28     +28
> > > >>                  hash_init_sha256                             -
> > 22     +22
> > > >>                  hash_init_sha1                               -
> > 22     +22
> > > >>                  hash_update_crc32                            -
> > 20     +20
> > > >>                  hash_update_crc16_ccitt                      -
> > 20     +20
> > > >>                  hash_init_crc32                              -
> > 20     +20
> > > >>                  hash_init_crc16_ccitt                        -
> > 20     +20
> > > >>                  hash_update_sha256                           -
> > 16     +16
> > > >>                  hash_update_sha1                             -
> > 16     +16
> > > >>                  sha1_update                                  -
> >  8      +8
> > > >>
> > > >> This is because:
> > > >> > diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
> > > >> > index 982e84dc3bc..5d7fd904950 100644
> > > >> > --- a/drivers/mmc/Kconfig
> > > >> > +++ b/drivers/mmc/Kconfig
> > > >> > @@ -119,6 +119,7 @@ config MMC_HW_PARTITIONING
> > > >> >  config SUPPORT_EMMC_RPMB
> > > >> >       bool "Support eMMC replay protected memory block (RPMB)"
> > > >> >       imply CMD_MMC_RPMB
> > > >> > +     select SHA256
> > > >> >       help
> > > >> >         Enable support for reading, writing and programming the
> > > >> >         key for the Replay Protection Memory Block partition in
> > eMMC.
> > > >>
> > > >> Wasn't true / required before now, no hashing algorithms were enab=
led.
> > > >> This was fine because:
> > > >> [snip]
> > > >> > diff --git a/lib/Makefile b/lib/Makefile
> > > >> > index c4950b78a29..33755778283 100644
> > > >> > --- a/lib/Makefile
> > > >> > +++ b/lib/Makefile
> > > >> > @@ -50,7 +50,6 @@ obj-$(CONFIG_XXHASH) +=3D xxhash.o
> > > >> >  obj-y +=3D net_utils.o
> > > >> >  obj-$(CONFIG_PHYSMEM) +=3D physmem.o
> > > >> >  obj-y +=3D rc4.o
> > > >> > -obj-$(CONFIG_SUPPORT_EMMC_RPMB) +=3D sha256.o
> > > >> >  obj-$(CONFIG_RBTREE) +=3D rbtree.o
> > > >> >  obj-$(CONFIG_BITREVERSE) +=3D bitrev.o
> > > >> >  obj-y +=3D list_sort.o
> > > >>
> > > >> Got us the library access without bringing in everything else. And
> > since
> > > >> two of the platforms that are hitting this now are "nano" this is =
an
> > > >> important thing to figure out how to continue to support. If there=
's
> > > >> just no way around it, we can likely live with the size increase, =
but
> > > >> I'd like to see this looked in to specifically first, thanks!
> > > >>
> > > > To address this, I think there are two options.
> > > > 1. Introduce SUPPORT_EMMC_RPMB into the MbedTLS sub makefile.
> > > > 2. Make MBEDTLS_LIB_CRYPTO depends on !SUPPORT_EMMC_RPMB.
> > > > 1) looks to be ugly, I prefer 2) if you agree.
> > >
> > > 2 is not a good idea either. We can't just drop RPMB support when
> > > mbedTLS is enabled
> >
> > To be clear, while I hope we can do something about this growth, I would
> > rather live with it (as it's not an unreasonable amount) than do 2, and
> > if 1 is too ugly, probably skip that as well. If it's not a matter of
> > loosening some select statements, or maybe introducing a library type
> > symbol we can see if anyone else more motivated has a better idea as
> > it's literally 3 platforms (ev-imx280-nano-x-mb is the other nano, and
> > then uniphier_v8 where it's arguably a missing feature anyhow) rather
> > than a large number of them. And not even other "mini" or "nano"
> > configs.
> >
> > Yes. I figured out what the problem is.
> The "select SHA256" change doesn't matter, but size growth was introduced=
 by
> the inline function in sha1_alt.h I added in patch #2 of v8.
> I already fixed this in my working branch:
>=20
>    aarch64: (for 1/1 boards) all +8502.0 data +224.0 rodata +218.0 text
> +8060.0
>             uniphier_v8    : all +8502 data +224 rodata +218 text +8060
>        arm: (for 2/2 boards) all +5649.0 data +112.0 rodata +137.0 text
> +5400.0
>             o4-imx6ull-nano: all +5651 data +112 rodata +139 text +5400
>             ev-imx280-nano-x-mb: all +5647 data +112 rodata +135 text +54=
00
>=20
> Now there is no "u-boot: add" any more on these three boards.
> I will update v9 with this fix, and we don't need either 1) or 2) options
> mentioned
> in my previous reply.

Erm, it looks like you just don't have the flag passed to show the
functions that changed? That's pretty close to the text change I saw.
For reference I do:
-----8>
#!/bin/bash

# Initial and constant buildman args
ARGS=3D"-devl -PEWM"
ALL=3D0
KEEP=3D0

# Find our arguments
while test $# -ne 0; do
	if [ "$1" =3D=3D "--all" ]; then
		ALL=3D1
		shift 1
	elif [ "$1" =3D=3D "--branch" ]; then
		BRANCH=3D$2
		shift 2
	elif [ "$1" =3D=3D "--keep" ]; then
		KEEP=3D1
		ARGS=3D"$ARGS -k"
		shift 1
	elif [ "$1" =3D=3D "--board" ]; then
		MACHINE=3D"--board $2"
		OUTDIR=3D/tmp/$2
		shift 2
	else
		MACHINE=3D$1
		shift 1
	fi
done

OUTDIR=3D${OUTDIR:-/tmp/$MACHINE}

if [ -z "$MACHINE" ]; then
	echo Usage: $0 MACHINE [--all] [--keep] [--branch BRANCH]
	exit 1
fi

# If not all, then only first/last
if [ $ALL -ne 1 ]; then
	ARGS=3D"$ARGS --step 0"
fi

if [ ! -z $BRANCH ]; then
	ARGS=3D"$ARGS -b $BRANCH"
else
	ARGS=3D"$ARGS -b `git rev-parse --abbrev-ref HEAD`"
fi

mkdir -p ${OUTDIR}

export SOURCE_DATE_EPOCH=3D`date +%s`
=2E/tools/buildman/buildman -o ${OUTDIR} $ARGS -SBC $MACHINE
=2E/tools/buildman/buildman -o ${OUTDIR} $ARGS -SsB $MACHINE

[ $KEEP -eq 0 ] && rm -rf ${OUTDIR}
<----8

--=20
Tom

--jbeGw96Yk7+HZyP7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcJn7YACgkQFHw5/5Y0
tyytsgv/YV7nZwT3svznGi7aD/JnUJtNcEWYxvidvXICeAGgOomZB8ePA/XEl16m
olGgev2Rm4doPYPZbBbykMvGEdtnaAhLOpCaRwfDNtN7ZSJZpirZiA7hwC3eF6b8
btkEziRjgXnSwEfrCElybPsnC1yby4AMoPvCfbCnbW46aldEqjn5Fbw+++HhpZzi
QIRF9rLmaZqfiUboPRy+cGrb2mn5vBq88Bw1CIq/7QaEqB6iTBWxK6YkyDh+Jq9O
vhJt8bzgSMSbMa9SYoU8cWqGQe/UvuniUAJtUv4HyCflxyB1n6/EoDZ070nUm8aw
B/iqP3iNaUsvrJwqLvSj1YlHJjWPlbZ0gkfLD9WhGLqiEGY4C8yqHCFaqtBnDux0
6Ma6HUIQAsN+4nV3vTqswzM2g7IWXtZUYcyfTJk0W2cYIQn5D6YAPR1bpIAtNB6p
JeAxRSLqzoex1LTVaCcWMZhCpPqvr6z319b4Uko1wefdfomUD4XQZoyftaRkCveW
je225as6
=JnmQ
-----END PGP SIGNATURE-----

--jbeGw96Yk7+HZyP7--
