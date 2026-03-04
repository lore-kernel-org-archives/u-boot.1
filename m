Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68B02EF8FF3
	for <u-boot@archiver.kernel.org>; Wed,  4 Mar 2026 15:09:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D177C83AA9;
	Wed,  4 Mar 2026 16:09:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jKQ6dp30";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF39683F61; Wed,  4 Mar 2026 16:09:47 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A30EA83642
 for <u-boot@lists.denx.de>; Wed,  4 Mar 2026 16:09:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=conor@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 0350741729;
 Wed,  4 Mar 2026 15:09:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 922B5C2BC87;
 Wed,  4 Mar 2026 15:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1772636983;
 bh=obniYOmm9DDaU5WgHYsB8eUMYygJbYHTelko/9/MauM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jKQ6dp30JhlqJYoXsKuiouVYqRv5u5kZKcRspIJy50GtXnAPrS1errHPsjn+6iaJg
 MxGgW7ML3ZtleLF/bXlx8+ozIPvk2m59N9l1JA8Mf/LXM1wWQtdXtnfPjeZgAy+zaN
 b4il6M2Xx06lJBP5hMvbvgImWZUsXUdwlF4VPcYo9q5LxggGjQ3xbI+FTO+CJ9E+S3
 ML54NJn+f7yb9jfc5rYVxbrpLz4OVHgGzwo+fKoObpQ53Dl6ovC7ZChCjHyonmc3MC
 eIyIDU/nfMzdg7s2eHgy8INpt0/RdDRIqXUtfwUYqTcMTycTOmntkr8R3MNafXr8UU
 w3+k0+BkqeLbQ==
Date: Wed, 4 Mar 2026 15:09:40 +0000
From: Conor Dooley <conor@kernel.org>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <simon.glass@canonical.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>
Subject: Re: [PATCH] kbuild: unexport sub_make_done to fix child make
 invocations
Message-ID: <20260304-acquaint-wager-688fd7fbae6a@spud>
References: <20260214024736.3726811-1-simon.glass@canonical.com>
 <177256385549.3975993.592734328770415000.b4-ty@konsulko.com>
 <20260304-robe-praising-5509e3a984cd@spud>
 <20260304150145.GX1388590@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OPn+X4B11WqZkzSA"
Content-Disposition: inline
In-Reply-To: <20260304150145.GX1388590@bill-the-cat>
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


--OPn+X4B11WqZkzSA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 04, 2026 at 09:01:45AM -0600, Tom Rini wrote:
> On Wed, Mar 04, 2026 at 09:54:22AM +0000, Conor Dooley wrote:
> > On Tue, Mar 03, 2026 at 12:50:55PM -0600, Tom Rini wrote:
> > > On Fri, 13 Feb 2026 19:47:34 -0700, Simon Glass wrote:
> > >=20
> > > > The exported sub_make_done variable leaks into the environment of a=
ll
> > > > child processes. When make targets like tcheck spawn independent ma=
ke
> > > > invocations with O=3D, those child makes inherit sub_make_done=3D1,=
 skip
> > > > the KBUILD_OUTPUT setup and try to build in the source tree.
> > > >=20
> > > > There is a workaround that resets sub_make_done to 0 for specific t=
est
> > > > targets, but this isn't great since it has tolist every target that
> > > > spawns independent make invocations.
> > > >=20
> > > > [...]
> > >=20
> > > Applied to u-boot/master, thanks!
> > >=20
> > > [1/1] kbuild: unexport sub_make_done to fix child make invocations
> > >       commit: 4284306d22c5b6d64ecd62b462551d9d313c8104
> >=20
> >=20
> > This breaks the build for me:
> > make ARCH=3Driscv CROSS_COMPILE=3Driscv64-unknown-linux-gnu- O=3Dbuild =
microchip_mpfs_generic_defconfig
> >   GEN     Makefile
> > #
> > # configuration written to .config
> > #
> > make ARCH=3Driscv CROSS_COMPILE=3Driscv64-unknown-linux-gnu- O=3Dbuild
> >   HOSTCC  scripts/basic/fixdep
> >   GEN     Makefile
> >   HOSTCC  scripts/kconfig/conf.o
> >   YACC    scripts/kconfig/zconf.tab.[ch]
> >   LEX     scripts/kconfig/zconf.lex.c
> >   HOSTCC  scripts/kconfig/zconf.tab.o
> >   HOSTLD  scripts/kconfig/conf
> > scripts/kconfig/conf  --syncconfig Kconfig
> > ***
> > *** Configuration file ".config" not found!
> > ***
> > *** Please run some configurator (e.g. "make oldconfig" or
> > *** "make menuconfig" or "make xconfig").
> > ***
> > make[4]: *** [/stuff/u-boot/scripts/kconfig/Makefile:75: syncconfig] Er=
ror 1
> > make[3]: *** [/stuff/u-boot/Makefile:702: syncconfig] Error 2
> > make[2]: *** [../Makefile:189: __sub-make] Error 2
> > make[1]: *** No rule to make target 'include/config/auto.conf', needed =
by 'include/config/uboot.release'.  Stop.
> > make: *** [Makefile:189: __sub-make] Error 2
>=20
> That's odd. What host distro and make? I don't see that on Ubuntu 24.04.

Originally my CI found it in a docker container with "from: ubuntu:noble",
so 24.04. I reproduced it locally on debian unstable with make 4.4.1

--OPn+X4B11WqZkzSA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaahLNAAKCRB4tDGHoIJi
0pzzAQDDcF9qvJdi3h65xstNLt7zLrcJe13pdD4+3dbirfrPAwD+J8/hNrBcWdVr
zX/u65oIgkpQj86BFx4viB7v+eoFLgk=
=5Bdw
-----END PGP SIGNATURE-----

--OPn+X4B11WqZkzSA--
