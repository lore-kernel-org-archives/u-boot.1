Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5613ECF07A3
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 05:23:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 989348907B;
	Thu, 10 Oct 2024 07:23:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Fat1RPao";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7AD388DF4; Wed,  9 Oct 2024 17:42:00 +0200 (CEST)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7899B88D5A
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 17:41:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e2904ce7e14so648389276.0
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 08:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728488517; x=1729093317; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YK7yxNh+M1gKbbktebrQwJpUIdtunsejPkSrvLg6m30=;
 b=Fat1RPaozPP8pTaTcScAoj6eJImUCipkbzLOymIHjPi6KHl5sK6x8T6x5UrkUzh1MJ
 EW0TlLH3RqvoF4P0124CHJW1bZiOQRVFxKsQIuGfI7UstH3jEiLhEb5V1nxYZPrcrb79
 VvL66803SfSaXogu7YkoIYVgMYBa9c3RacUFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728488517; x=1729093317;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YK7yxNh+M1gKbbktebrQwJpUIdtunsejPkSrvLg6m30=;
 b=lB5i8L61NbVRV/ijrG7OLr2pLrOhH5d5qXuyJthQM0W3rP6GnJ9mf6w7iR1YkD4CWZ
 L6sf0MLAkpLKPNsSIlEFlAGS3cZhGndjcpOqfgLsTbDO7/5j2t3nLju6NV0lzzX4aVrJ
 qivEN2nwA/nXy+EHmyyESvYcMqOP4p3FvsJXa2PaDx1w9SF26SA3cxbyc36s2LbKdjLx
 Hs6rqsr2oMAm9k0ii1BZ8KkTha/V7D7EDWRTnFDW4MUZFW3FnNXnHu/alwgDgqN+AKIp
 /NAM8ZPJPrTfYTSnIWHRWo0/cCbZ+pXncgAbA9Oxn7stMguTsaUd6Ko/v8SZKulk0YGD
 osWg==
X-Gm-Message-State: AOJu0YyDk0x0UeSWqcHQ8kcbwMSTWqxV9Sj6OoE0eG+rEsAtOHy6x6wZ
 JG75kRHaZ3KjKMjTvz3wjZTHokKUWkeNZ5hSLQI6yfxwDKVSF4tO6IqLv4tfJDw=
X-Google-Smtp-Source: AGHT+IHXR47WvWLKUzMW4mXxTP7z8dsc0DViahw0KJAUUccyQk7fGxrj0LBQ+uDsVb/1OZmiz/lK2Q==
X-Received: by 2002:a5b:9c6:0:b0:e26:5a7:1fdd with SMTP id
 3f1490d57ef6-e28fe43fc9fmr2263275276.22.1728488517130; 
 Wed, 09 Oct 2024 08:41:57 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cba46cced5sm46988186d6.7.2024.10.09.08.41.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 08:41:56 -0700 (PDT)
Date: Wed, 9 Oct 2024 09:41:51 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, manish.pandey2@arm.com,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Stefan Bosch <stefan_b@posteo.net>, Mario Six <mario.six@gdsys.cc>,
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
Message-ID: <20241009154151.GK14210@bill-the-cat>
References: <20241003215112.3103601-1-raymond.mao@linaro.org>
 <20241003215112.3103601-4-raymond.mao@linaro.org>
 <20241009143824.GJ14210@bill-the-cat>
 <CAEfUkUJXa55pJP-DypJy-FGhpkQiSFAS3QB+6s5+55PWmwbZ7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jPAr36nDb2l9C/Ve"
Content-Disposition: inline
In-Reply-To: <CAEfUkUJXa55pJP-DypJy-FGhpkQiSFAS3QB+6s5+55PWmwbZ7Q@mail.gmail.com>
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


--jPAr36nDb2l9C/Ve
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 09, 2024 at 11:32:29AM -0400, Raymond Mao wrote:
> Hi Tom,
>=20
> On Wed, 9 Oct 2024 at 10:38, Tom Rini <trini@konsulko.com> wrote:
>=20
> > On Thu, Oct 03, 2024 at 02:50:16PM -0700, Raymond Mao wrote:
> >
> > > Adapt digest header files to support both original libs and MbedTLS
> > > by switching on/off MBEDTLS_LIB_CRYPTO.
> > > Introduce <alg>_LEGACY kconfig for legacy hash implementations.
> > > sha256.o should depend on SHA256 kconfig only but not SUPPORT_EMMC_RP=
MB,
> > > SHA256 should be selected when SUPPORT_EMMC_RPMB is enabled instead.
> > >
> > > `IS_ENABLED` or `CONFIG_IS_ENABLED` is not applicable here, since
> > > including <linux/kconfig.h> causes undefined reference on schedule()
> > > with sandbox build, as <linux/kconfig.h> includes <generated/autoconf=
=2Eh>
> > > which enables `CONFIG_HW_WATCHDOG` and `CONFIG_WATCHDOG` but no
> > schedule()
> > > are defined in sandbox build,
> > > Thus we use `#if defined(CONFIG_MBEDTLS_LIB_CRYPTO)` instead.
> > >
> > > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > > Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >
> > There's three platforms where we see something like:
> >        arm: (for 1/1 boards) all +5651.0 data +112.0 rodata +139.0 text
> > +5400.0
> >             o4-imx6ull-nano: all +5651 data +112 rodata +139 text +5400
> >                u-boot: add: 23/0, grow: 1/0 bytes: 1172/0 (1172)
> >                  function                                   old     new
> >  delta
> >                  hash_command                               108     296
> > +188
> >                  sha1_finish                                  -     156
> > +156
> >                  static.sha1_update                           -     114
> > +114
> >                  hash_algo                                    -     112
> > +112
> >                  sha1_padding                                 -      64
> >  +64
> >                  hash_lookup_algo                             -      60
> >  +60
> >                  sha1_starts                                  -      52
> >  +52
> >                  crc16_ccitt_wd_buf                           -      36
> >  +36
> >                  sha256_csum_wd                               -      34
> >  +34
> >                  sha1_csum_wd                                 -      34
> >  +34
> >                  hash_finish_sha256                           -      34
> >  +34
> >                  hash_finish_sha1                             -      34
> >  +34
> >                  crc32_wd_buf                                 -      34
> >  +34
> >                  hash_finish_crc32                            -      28
> >  +28
> >                  hash_finish_crc16_ccitt                      -      28
> >  +28
> >                  hash_init_sha256                             -      22
> >  +22
> >                  hash_init_sha1                               -      22
> >  +22
> >                  hash_update_crc32                            -      20
> >  +20
> >                  hash_update_crc16_ccitt                      -      20
> >  +20
> >                  hash_init_crc32                              -      20
> >  +20
> >                  hash_init_crc16_ccitt                        -      20
> >  +20
> >                  hash_update_sha256                           -      16
> >  +16
> >                  hash_update_sha1                             -      16
> >  +16
> >                  sha1_update                                  -       8
> >   +8
> >
> > This is because:
> > > diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
> > > index 982e84dc3bc..5d7fd904950 100644
> > > --- a/drivers/mmc/Kconfig
> > > +++ b/drivers/mmc/Kconfig
> > > @@ -119,6 +119,7 @@ config MMC_HW_PARTITIONING
> > >  config SUPPORT_EMMC_RPMB
> > >       bool "Support eMMC replay protected memory block (RPMB)"
> > >       imply CMD_MMC_RPMB
> > > +     select SHA256
> > >       help
> > >         Enable support for reading, writing and programming the
> > >         key for the Replay Protection Memory Block partition in eMMC.
> >
> > Wasn't true / required before now, no hashing algorithms were enabled.
> > This was fine because:
> > [snip]
> > > diff --git a/lib/Makefile b/lib/Makefile
> > > index c4950b78a29..33755778283 100644
> > > --- a/lib/Makefile
> > > +++ b/lib/Makefile
> > > @@ -50,7 +50,6 @@ obj-$(CONFIG_XXHASH) +=3D xxhash.o
> > >  obj-y +=3D net_utils.o
> > >  obj-$(CONFIG_PHYSMEM) +=3D physmem.o
> > >  obj-y +=3D rc4.o
> > > -obj-$(CONFIG_SUPPORT_EMMC_RPMB) +=3D sha256.o
> > >  obj-$(CONFIG_RBTREE) +=3D rbtree.o
> > >  obj-$(CONFIG_BITREVERSE) +=3D bitrev.o
> > >  obj-y +=3D list_sort.o
> >
> > Got us the library access without bringing in everything else. And since
> > two of the platforms that are hitting this now are "nano" this is an
> > important thing to figure out how to continue to support. If there's
> > just no way around it, we can likely live with the size increase, but
> > I'd like to see this looked in to specifically first, thanks!
> >
> To address this, I think there are two options.
> 1. Introduce SUPPORT_EMMC_RPMB into the MbedTLS sub makefile.
> 2. Make MBEDTLS_LIB_CRYPTO depends on !SUPPORT_EMMC_RPMB.
> 1) looks to be ugly, I prefer 2) if you agree.

Well, part of the size issue is that it looks like a number of other
algorithms are now being enabled too?

--=20
Tom

--jPAr36nDb2l9C/Ve
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcGpDsACgkQFHw5/5Y0
tyzC2wwAqSsMcM7+UgFzwu7vQPIAnG1TDDYC0Zgt+Cxd9mFnPfoC6YKpKIX3E8Wd
f6zBbsbATGRKpuDlA6enSg75SavTQevYQs4zFgIYZtkVn8OGIjbKIkn9gm5EAFOL
7Yo07Ec3/ivi1fy7DNB5qNevQIOIci984MJ24PXXpQBnIlAI35x9ImSin2jrKpqv
qVVmhGrFPKpO1svefsvnCXe+lDS/FGu/N0b8VCoftbdPnCWiM0xywEa2QwgqbWK+
2GSZVk5TxDpRPV0/ImRvvkMmXDk3LWv18+tBTsrbS5Vh4Q5rUbzGKAHTMlYgpwhy
4aoQ23nXZPukghysIp0Cd9IEN+nusrtpmB/eMqObBk12HBPtT//sFsI/Pv/ZLfBE
4muA+5H5K0FuUVscVHu7t9rLhsBzspoRUamFAfuMdsBUB1UF2PQVlPmXY0LroAsJ
GD3yxncNMCY+1Fu4z9ize9YgXTfsogbTeLPXwjbkhSC5DSGbo2/d6LszlRGwDx5d
VCJUxTlo
=+/kC
-----END PGP SIGNATURE-----

--jPAr36nDb2l9C/Ve--
