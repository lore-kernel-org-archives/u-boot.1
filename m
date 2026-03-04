Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C24B1EB7EB2
	for <u-boot@archiver.kernel.org>; Wed,  4 Mar 2026 09:54:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03A66839A8;
	Wed,  4 Mar 2026 10:54:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ST7mjSDB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 157B583D8A; Wed,  4 Mar 2026 10:54:31 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84651838BB
 for <u-boot@lists.denx.de>; Wed,  4 Mar 2026 10:54:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=conor@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B6EF643C52;
 Wed,  4 Mar 2026 09:54:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52587C2BC87;
 Wed,  4 Mar 2026 09:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1772618066;
 bh=0YRy9RLI30Tl+LcnLGXQUxKk5ykivFGco1yOH+QW17k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ST7mjSDBhXoA0AzHmTBGODB+uvM8AiRXu4bz0DBKZCzYd10XUMYG94/TR1z3ac2Zn
 phoMiuHE4wBDPLLV/zQ9YkB/IInjIeBcXoCxNjFEwUd4j4T3b9EVCvF4pueeEAxVQG
 EyK3Y2OKOfm59QBCpbgO24PbshAS7uHEqJ+H7D0uvm5GT0dIedwIOO4hHIgAL5LPQr
 9bQe0yZSOQTe8jK9yEbPpITmCbkhjpSxA5BeG/CnRdNhuTqPaKoHSEubFifry9O47+
 Q4mX1tQnjBHxVZxNtqdlINVi5TRtji2HqNTzNQNDDx1qiWE/XNdbblHa9kW4MrPTL/
 mbMAtpi6h7WZQ==
Date: Wed, 4 Mar 2026 09:54:22 +0000
From: Conor Dooley <conor@kernel.org>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <simon.glass@canonical.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>
Subject: Re: [PATCH] kbuild: unexport sub_make_done to fix child make
 invocations
Message-ID: <20260304-robe-praising-5509e3a984cd@spud>
References: <20260214024736.3726811-1-simon.glass@canonical.com>
 <177256385549.3975993.592734328770415000.b4-ty@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="v/48bD2FJmnN4WIZ"
Content-Disposition: inline
In-Reply-To: <177256385549.3975993.592734328770415000.b4-ty@konsulko.com>
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


--v/48bD2FJmnN4WIZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 03, 2026 at 12:50:55PM -0600, Tom Rini wrote:
> On Fri, 13 Feb 2026 19:47:34 -0700, Simon Glass wrote:
>=20
> > The exported sub_make_done variable leaks into the environment of all
> > child processes. When make targets like tcheck spawn independent make
> > invocations with O=3D, those child makes inherit sub_make_done=3D1, skip
> > the KBUILD_OUTPUT setup and try to build in the source tree.
> >=20
> > There is a workaround that resets sub_make_done to 0 for specific test
> > targets, but this isn't great since it has tolist every target that
> > spawns independent make invocations.
> >=20
> > [...]
>=20
> Applied to u-boot/master, thanks!
>=20
> [1/1] kbuild: unexport sub_make_done to fix child make invocations
>       commit: 4284306d22c5b6d64ecd62b462551d9d313c8104


This breaks the build for me:
make ARCH=3Driscv CROSS_COMPILE=3Driscv64-unknown-linux-gnu- O=3Dbuild micr=
ochip_mpfs_generic_defconfig
  GEN     Makefile
#
# configuration written to .config
#
make ARCH=3Driscv CROSS_COMPILE=3Driscv64-unknown-linux-gnu- O=3Dbuild
  HOSTCC  scripts/basic/fixdep
  GEN     Makefile
  HOSTCC  scripts/kconfig/conf.o
  YACC    scripts/kconfig/zconf.tab.[ch]
  LEX     scripts/kconfig/zconf.lex.c
  HOSTCC  scripts/kconfig/zconf.tab.o
  HOSTLD  scripts/kconfig/conf
scripts/kconfig/conf  --syncconfig Kconfig
***
*** Configuration file ".config" not found!
***
*** Please run some configurator (e.g. "make oldconfig" or
*** "make menuconfig" or "make xconfig").
***
make[4]: *** [/stuff/u-boot/scripts/kconfig/Makefile:75: syncconfig] Error 1
make[3]: *** [/stuff/u-boot/Makefile:702: syncconfig] Error 2
make[2]: *** [../Makefile:189: __sub-make] Error 2
make[1]: *** No rule to make target 'include/config/auto.conf', needed by '=
include/config/uboot.release'.  Stop.
make: *** [Makefile:189: __sub-make] Error 2

--v/48bD2FJmnN4WIZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaagBTgAKCRB4tDGHoIJi
0gGjAP4plf31yObYmyLuNsOqF17gUy0QiLEMVDuE/XQxXEwXLgEA1g/n0ry7uPLU
IhsBVUEucTm3DkeP4lDSnjG+mu/yygU=
=7S07
-----END PGP SIGNATURE-----

--v/48bD2FJmnN4WIZ--
