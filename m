Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B83CF07A5
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 05:23:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AFB7890AF;
	Thu, 10 Oct 2024 07:23:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AAn5U0Fz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B69288D7D; Wed,  9 Oct 2024 19:52:54 +0200 (CEST)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5BE088D7E
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 19:52:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7afc5e480dbso140567585a.3
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 10:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728496371; x=1729101171; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dAtGcZNwFSvqAqMljluNspQswjRMlNaznkJwj+w6juU=;
 b=AAn5U0Fz0tM4awHns0K+MXeeZvYRRv4yC3eJCi4bxauH0h9mXbx32zDgeqZ0/iUQeS
 jPzBRviMR0DBNogRvyPQ3U7IhBtiLX7MIa5ZNOwnZKdtL0qMwdppNCY7ULZuwp0Lp9gp
 WzZYgeBPhVh7n7Fk1JAILnSIWUjT7ia430zXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728496371; x=1729101171;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dAtGcZNwFSvqAqMljluNspQswjRMlNaznkJwj+w6juU=;
 b=tOWpT2tQBr9bZr6CsqQnrLHNaT1JQ/AWV1ymoBJfO4uvfgDFeJzKHRwgZVjd6T/fTw
 SNSMASWdaIq9YzEIEbEuITobXRdQSnXdYRY/Vo6qIplsfUZ52aNW8/3la3iajy8QylEz
 Vpk2VMJX2XoXMbwHidTav37a+NeZSDIhS/fga27HI9YHSZym7yWgtci/HCM9Nlq6VTSV
 UcuQ++CUPaNr5RndhM5tutapS/5HH8DuRvnh5isRhWmHpKRe1kW+U+zetzznSTz73KX4
 FOl31LSBJaH3Rjy/V0PoxxwInjXCsOGjv00EDni2Ue0NvJ0lO70C3Ws1QMLH2dIsXE2e
 7oCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeOigYsiW0y4Jg1YjA4/aS1Nbem/bkvriDM7cj0UdoehybcDGgMWgJREZwoMoXCQTMaT9bA2A=@lists.denx.de
X-Gm-Message-State: AOJu0YwsnAmxhTGsPx8+rXslS1dvfo/rlyiqgd6uHLYrW83KszQMxvGK
 4RrQV5Ua5MFVbM/KKC7CA4hQwY7D/ITKenrVBTMTKqQMuef9zQWL19UrrwE0wvE=
X-Google-Smtp-Source: AGHT+IF0MylFb3MuMfnoTwCmmtVlGRqSBlZP+/0xKdIxPw0+0DENYdKY1ndIISyROf2bS3/0krQYoA==
X-Received: by 2002:a05:620a:1983:b0:79d:6dd8:f420 with SMTP id
 af79cd13be357-7b111ccb74amr148912685a.7.1728496370567; 
 Wed, 09 Oct 2024 10:52:50 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7afcfe7ab7bsm104495685a.57.2024.10.09.10.52.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 10:52:49 -0700 (PDT)
Date: Wed, 9 Oct 2024 11:52:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de,
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
Message-ID: <20241009175243.GL14210@bill-the-cat>
References: <20241003215112.3103601-1-raymond.mao@linaro.org>
 <20241003215112.3103601-4-raymond.mao@linaro.org>
 <20241009143824.GJ14210@bill-the-cat>
 <CAEfUkUJXa55pJP-DypJy-FGhpkQiSFAS3QB+6s5+55PWmwbZ7Q@mail.gmail.com>
 <CAC_iWj+dBpgCM-WaJBgRyXmn1jWO--tGRTXjAT0hJL5G0V8D0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wqVzTR5qwG8UY1Ek"
Content-Disposition: inline
In-Reply-To: <CAC_iWj+dBpgCM-WaJBgRyXmn1jWO--tGRTXjAT0hJL5G0V8D0g@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Thu, 10 Oct 2024 07:23:03 +0200
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


--wqVzTR5qwG8UY1Ek
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 09, 2024 at 08:32:29PM +0300, Ilias Apalodimas wrote:
> On Wed, 9 Oct 2024 at 18:32, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Hi Tom,
> >
> > On Wed, 9 Oct 2024 at 10:38, Tom Rini <trini@konsulko.com> wrote:
> >>
> >> On Thu, Oct 03, 2024 at 02:50:16PM -0700, Raymond Mao wrote:
> >>
> >> > Adapt digest header files to support both original libs and MbedTLS
> >> > by switching on/off MBEDTLS_LIB_CRYPTO.
> >> > Introduce <alg>_LEGACY kconfig for legacy hash implementations.
> >> > sha256.o should depend on SHA256 kconfig only but not SUPPORT_EMMC_R=
PMB,
> >> > SHA256 should be selected when SUPPORT_EMMC_RPMB is enabled instead.
> >> >
> >> > `IS_ENABLED` or `CONFIG_IS_ENABLED` is not applicable here, since
> >> > including <linux/kconfig.h> causes undefined reference on schedule()
> >> > with sandbox build, as <linux/kconfig.h> includes <generated/autocon=
f.h>
> >> > which enables `CONFIG_HW_WATCHDOG` and `CONFIG_WATCHDOG` but no sche=
dule()
> >> > are defined in sandbox build,
> >> > Thus we use `#if defined(CONFIG_MBEDTLS_LIB_CRYPTO)` instead.
> >> >
> >> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> >> > Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >>
> >> There's three platforms where we see something like:
> >>        arm: (for 1/1 boards) all +5651.0 data +112.0 rodata +139.0 tex=
t +5400.0
> >>             o4-imx6ull-nano: all +5651 data +112 rodata +139 text +5400
> >>                u-boot: add: 23/0, grow: 1/0 bytes: 1172/0 (1172)
> >>                  function                                   old     ne=
w   delta
> >>                  hash_command                               108     29=
6    +188
> >>                  sha1_finish                                  -     15=
6    +156
> >>                  static.sha1_update                           -     11=
4    +114
> >>                  hash_algo                                    -     11=
2    +112
> >>                  sha1_padding                                 -      6=
4     +64
> >>                  hash_lookup_algo                             -      6=
0     +60
> >>                  sha1_starts                                  -      5=
2     +52
> >>                  crc16_ccitt_wd_buf                           -      3=
6     +36
> >>                  sha256_csum_wd                               -      3=
4     +34
> >>                  sha1_csum_wd                                 -      3=
4     +34
> >>                  hash_finish_sha256                           -      3=
4     +34
> >>                  hash_finish_sha1                             -      3=
4     +34
> >>                  crc32_wd_buf                                 -      3=
4     +34
> >>                  hash_finish_crc32                            -      2=
8     +28
> >>                  hash_finish_crc16_ccitt                      -      2=
8     +28
> >>                  hash_init_sha256                             -      2=
2     +22
> >>                  hash_init_sha1                               -      2=
2     +22
> >>                  hash_update_crc32                            -      2=
0     +20
> >>                  hash_update_crc16_ccitt                      -      2=
0     +20
> >>                  hash_init_crc32                              -      2=
0     +20
> >>                  hash_init_crc16_ccitt                        -      2=
0     +20
> >>                  hash_update_sha256                           -      1=
6     +16
> >>                  hash_update_sha1                             -      1=
6     +16
> >>                  sha1_update                                  -       =
8      +8
> >>
> >> This is because:
> >> > diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
> >> > index 982e84dc3bc..5d7fd904950 100644
> >> > --- a/drivers/mmc/Kconfig
> >> > +++ b/drivers/mmc/Kconfig
> >> > @@ -119,6 +119,7 @@ config MMC_HW_PARTITIONING
> >> >  config SUPPORT_EMMC_RPMB
> >> >       bool "Support eMMC replay protected memory block (RPMB)"
> >> >       imply CMD_MMC_RPMB
> >> > +     select SHA256
> >> >       help
> >> >         Enable support for reading, writing and programming the
> >> >         key for the Replay Protection Memory Block partition in eMMC.
> >>
> >> Wasn't true / required before now, no hashing algorithms were enabled.
> >> This was fine because:
> >> [snip]
> >> > diff --git a/lib/Makefile b/lib/Makefile
> >> > index c4950b78a29..33755778283 100644
> >> > --- a/lib/Makefile
> >> > +++ b/lib/Makefile
> >> > @@ -50,7 +50,6 @@ obj-$(CONFIG_XXHASH) +=3D xxhash.o
> >> >  obj-y +=3D net_utils.o
> >> >  obj-$(CONFIG_PHYSMEM) +=3D physmem.o
> >> >  obj-y +=3D rc4.o
> >> > -obj-$(CONFIG_SUPPORT_EMMC_RPMB) +=3D sha256.o
> >> >  obj-$(CONFIG_RBTREE) +=3D rbtree.o
> >> >  obj-$(CONFIG_BITREVERSE) +=3D bitrev.o
> >> >  obj-y +=3D list_sort.o
> >>
> >> Got us the library access without bringing in everything else. And sin=
ce
> >> two of the platforms that are hitting this now are "nano" this is an
> >> important thing to figure out how to continue to support. If there's
> >> just no way around it, we can likely live with the size increase, but
> >> I'd like to see this looked in to specifically first, thanks!
> >>
> > To address this, I think there are two options.
> > 1. Introduce SUPPORT_EMMC_RPMB into the MbedTLS sub makefile.
> > 2. Make MBEDTLS_LIB_CRYPTO depends on !SUPPORT_EMMC_RPMB.
> > 1) looks to be ugly, I prefer 2) if you agree.
>=20
> 2 is not a good idea either. We can't just drop RPMB support when
> mbedTLS is enabled

To be clear, while I hope we can do something about this growth, I would
rather live with it (as it's not an unreasonable amount) than do 2, and
if 1 is too ugly, probably skip that as well. If it's not a matter of
loosening some select statements, or maybe introducing a library type
symbol we can see if anyone else more motivated has a better idea as
it's literally 3 platforms (ev-imx280-nano-x-mb is the other nano, and
then uniphier_v8 where it's arguably a missing feature anyhow) rather
than a large number of them. And not even other "mini" or "nano"
configs.

--=20
Tom

--wqVzTR5qwG8UY1Ek
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcGwugACgkQFHw5/5Y0
tyz44Qv/fY6pm9c5lxBaU43Y1r4Qp/Pz8er8NbhI/bYoP3pa+FZ/BmA1eKYYWZSR
8+gJKp7SMVdrSpbPADg9VBQZoJFwf7Ej0Cs/6mTfNe39cUHadyEhzMxAE4uZJK3h
/KI5smHt4nmXcaKETFWuLVp2oOKyQJFWlroPxo2KLipeJXvgJtdBT6PI+OqLKDW9
flhpWXrP4F1goVhBnMfvs3CjBc9+p/FNjbPsn1cDMLqL+qM+F0DT7uW7k/olvXg3
RJScXLbGjRIXJKLg3Bj+JzsRdCqhdcRRtn17PfwUK+XY2m9/6i1B47C0v26sevQO
xkQyhTL9KLMaUCyKsYQb3DHvm5gIoxZSxAwQHN9Xru2OC9eyYy7dgy/9qFh/sM/3
JoVe8qDQWH2mMcOM+r/BHN91ktGij4gzyogrj1rMoard89I9vTn1w7X2QR/1JO4i
1mI6fsYjE24Mhypt296I6pUpoH57Lyt+lIsM44SBA7RqNcplp75zfUPuYRiGtZB/
ILmk+sv5
=zSMz
-----END PGP SIGNATURE-----

--wqVzTR5qwG8UY1Ek--
