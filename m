Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42B77EF8FF1
	for <u-boot@archiver.kernel.org>; Wed,  4 Mar 2026 15:01:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 705D583AA9;
	Wed,  4 Mar 2026 16:01:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Su1/r/0P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACCC383AA9; Wed,  4 Mar 2026 16:01:52 +0100 (CET)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F8AB83642
 for <u-boot@lists.denx.de>; Wed,  4 Mar 2026 16:01:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-40f1a1f77a6so1362938fac.2
 for <u-boot@lists.denx.de>; Wed, 04 Mar 2026 07:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772636509; x=1773241309; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xNZL/G2u/iP+KsTF9sFRYyUwoB742w2APfJ7CdyS0no=;
 b=Su1/r/0PCxPnyH7oIyyn6U5osupSaq3l+d2JxJbrmE5zTY3wp/yym9F2FvgjC4/NjY
 8U2u0BbkWD/ZNiR/qaogBG7DUTj7bwOOhWXK/+gkSGiNsjQLZg3orkT1Wh/YbfC4d9hz
 jZpuy8ht6OybPldQX3/0BmUy2/6OlxRzOIO0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772636509; x=1773241309;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xNZL/G2u/iP+KsTF9sFRYyUwoB742w2APfJ7CdyS0no=;
 b=mav6vbXPHBavE+You4wqlG9Qyml+RtmZxKdy4ImB+ZbH3gkwguJ546U/xWfhaD7bwY
 aQsyPN9EhkxU++8RafsjcuPCNfFj4tqO2xABU4lZdffvFwQQ1kilc6lSglrAfXkMkPdu
 Wyt/SckeWD8NMi23ydSF7MR6a5gzqJg6fbYu2pzVK3wE3tN7CxlHibvUoNIZoEOPIqDc
 3nxmw+JKw+TCdh6unsXi5gDlLSd250+JA5VxyNRmNsAN6Fh9xFrUD4nliV4IEezG6fSz
 2yQStOTNuxk3iT9YXuL2r5rkvoPhjnhjh2MAKTm7MZ23yBbUFgGJjK00W5D5ybsMYVZz
 nmow==
X-Gm-Message-State: AOJu0YwLgidulnAYDEV3k0rFglvwov/0x5G54mMHUHn5aU/MSGRfrXPW
 bdCMhNd/LhUWBsm22lSBv93XlA40gpraFFuokdu5LcTRL+uyf+i+uljZ9GjpG03eyta+Ucpd0h0
 /wR50
X-Gm-Gg: ATEYQzwr7729VPixpBuKB66OPznwES31Ykc9Q19K4awj3CZo2z4QzKx1Sm3PaGwHkvf
 UNr6txlazaDUJS23doOsJETepTKsJETnXE2qwGq+Wg23oxP7/dJTA0vcBGv7xtTDezJcVEvAaKP
 hfpIg/lwweJaL4CS0dHfhAHWt3ln1BhIf9u5pNKj2H9RgZfWWCzT7VS46DJuObQP0CPQcNGfA7U
 3cbuUK48kml39GuTm03kojz3qO0Cd6XvLknJlIYMCeNINb4XROoIWvsIH8fcyXTKRMUQdhQo0NK
 5JoR2pxWDI+Cmlcg9ezuPpQrvNS3SwucIBMnU8jLR2Oeb1y6IkpbMpOEcJOSBiT7KRawsnE4cln
 o137aD2jVEURlgffdV7X+cbFcn+HXnJzIoNT2j8pmI7ZAY5pYY8nhhelxPYNahFG4Pwj+9fSdyR
 D+eG0cFiPO8h0PSyRFWGuILBvmNw5lStrsNt5/FUZ6LbwCUZTbkPzUIzvbPOwdIKLMLtPp+kenp
 Pm/oBqd8atpfVx9W2vESf/rjQpIsfo6SkW1QChVzmfUJ6aznes=
X-Received: by 2002:a05:6870:171b:b0:3e7:e420:6229 with SMTP id
 586e51a60fabf-416ab50cdccmr1084487fac.6.1772636508482; 
 Wed, 04 Mar 2026 07:01:48 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4160cf93b49sm18209071fac.5.2026.03.04.07.01.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 07:01:47 -0800 (PST)
Date: Wed, 4 Mar 2026 09:01:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Conor Dooley <conor@kernel.org>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <simon.glass@canonical.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>
Subject: Re: [PATCH] kbuild: unexport sub_make_done to fix child make
 invocations
Message-ID: <20260304150145.GX1388590@bill-the-cat>
References: <20260214024736.3726811-1-simon.glass@canonical.com>
 <177256385549.3975993.592734328770415000.b4-ty@konsulko.com>
 <20260304-robe-praising-5509e3a984cd@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="V/T7zFzcpyN+4ThV"
Content-Disposition: inline
In-Reply-To: <20260304-robe-praising-5509e3a984cd@spud>
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


--V/T7zFzcpyN+4ThV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 04, 2026 at 09:54:22AM +0000, Conor Dooley wrote:
> On Tue, Mar 03, 2026 at 12:50:55PM -0600, Tom Rini wrote:
> > On Fri, 13 Feb 2026 19:47:34 -0700, Simon Glass wrote:
> >=20
> > > The exported sub_make_done variable leaks into the environment of all
> > > child processes. When make targets like tcheck spawn independent make
> > > invocations with O=3D, those child makes inherit sub_make_done=3D1, s=
kip
> > > the KBUILD_OUTPUT setup and try to build in the source tree.
> > >=20
> > > There is a workaround that resets sub_make_done to 0 for specific test
> > > targets, but this isn't great since it has tolist every target that
> > > spawns independent make invocations.
> > >=20
> > > [...]
> >=20
> > Applied to u-boot/master, thanks!
> >=20
> > [1/1] kbuild: unexport sub_make_done to fix child make invocations
> >       commit: 4284306d22c5b6d64ecd62b462551d9d313c8104
>=20
>=20
> This breaks the build for me:
> make ARCH=3Driscv CROSS_COMPILE=3Driscv64-unknown-linux-gnu- O=3Dbuild mi=
crochip_mpfs_generic_defconfig
>   GEN     Makefile
> #
> # configuration written to .config
> #
> make ARCH=3Driscv CROSS_COMPILE=3Driscv64-unknown-linux-gnu- O=3Dbuild
>   HOSTCC  scripts/basic/fixdep
>   GEN     Makefile
>   HOSTCC  scripts/kconfig/conf.o
>   YACC    scripts/kconfig/zconf.tab.[ch]
>   LEX     scripts/kconfig/zconf.lex.c
>   HOSTCC  scripts/kconfig/zconf.tab.o
>   HOSTLD  scripts/kconfig/conf
> scripts/kconfig/conf  --syncconfig Kconfig
> ***
> *** Configuration file ".config" not found!
> ***
> *** Please run some configurator (e.g. "make oldconfig" or
> *** "make menuconfig" or "make xconfig").
> ***
> make[4]: *** [/stuff/u-boot/scripts/kconfig/Makefile:75: syncconfig] Erro=
r 1
> make[3]: *** [/stuff/u-boot/Makefile:702: syncconfig] Error 2
> make[2]: *** [../Makefile:189: __sub-make] Error 2
> make[1]: *** No rule to make target 'include/config/auto.conf', needed by=
 'include/config/uboot.release'.  Stop.
> make: *** [Makefile:189: __sub-make] Error 2

That's odd. What host distro and make? I don't see that on Ubuntu 24.04.

--=20
Tom

--V/T7zFzcpyN+4ThV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaahJWQAKCRAr4qD1Cr/k
CmJwAQCoc+ectrujKdHHcZJV5eYxK48kIC0mCUp0OxhtsjEJiAEAtB94GtYksykR
5gABtxaSOFw6IKGgqQshoISG8gkegg4=
=vuMg
-----END PGP SIGNATURE-----

--V/T7zFzcpyN+4ThV--
