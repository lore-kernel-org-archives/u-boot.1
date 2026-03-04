Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AECF4EF8FF4
	for <u-boot@archiver.kernel.org>; Wed,  4 Mar 2026 15:45:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2D90838BB;
	Wed,  4 Mar 2026 16:45:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cla9VFAn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13C3A83642; Wed,  4 Mar 2026 16:45:56 +0100 (CET)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D06C0839A8
 for <u-boot@lists.denx.de>; Wed,  4 Mar 2026 16:45:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-40f20af93aaso843969fac.1
 for <u-boot@lists.denx.de>; Wed, 04 Mar 2026 07:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772639152; x=1773243952; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pc2RPUB+AfwhQ+ht0QCawi8C4BX1SFxaKCcSQFvI1w0=;
 b=cla9VFAnTpircmlNXRLV6GH7iMKodd3p2Srjq5X7DOAEXvD1wUiePq6lSgyDC40/ig
 FSTSGzmHTZGrQobVw70c5y/X8fCbC+FVasIvHDhJ+01jo8ySRtiQ64HP4/6SnglM0vCx
 t7KZQAig40beL7mt9qkdxesa8qMG5xzUak+40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772639152; x=1773243952;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pc2RPUB+AfwhQ+ht0QCawi8C4BX1SFxaKCcSQFvI1w0=;
 b=gEfSZjqmKoJYBlyqIKlMEgb6lmwqmsi03kSyYtf3X1KoI3zCkjk9oSAJQghcFczPLW
 Jmsuv/QVaKYSO+nRQnS5pzKWcYIlX9BJh+eU2HOAM4MJ8CocBaBszV3EAouRUYR5zzqA
 84CEqB0zS5RyDd04RZtQPMgSa1l/xrfaijtRsrdtGvfTA356B+qxt1EffLnXTbbGmRRs
 HHmhEe2fniCyT9AatqBcVDgPXZNyNi51drI7mN9V7vgoeBHfJ5v7rznaNWWwzamuMx6J
 nnbPwvpAH+m5kzENuVZrso4UyGzXpdprG8NAink3/e+Bb0wQB0kmscH1zD2cDqh+n4v4
 P0Hg==
X-Gm-Message-State: AOJu0Ywvj/15Li5pKUOfynwB3r06wssd6vZvNnSXhLEvLKZPR+ctzoks
 +opKYrjm7y2I82Z4kufHjwvJRNpDZL5tjAzb/Z52Zwk1pJXILNMPVqg9eD+KNTDMeoo=
X-Gm-Gg: ATEYQzx+ZjM2O9F7+kacRYy0I8Wp9pcS9BhfHoL/UUoZCm5ow2JTfq31Ksqq1SFwbCI
 zMLlC9yeF5vzktnxKZMToJvu6dfn1+tjgRO3d/JghSdZfxWvj+H4nnIwl4FFuGQ7JFAV+A4zVI2
 DAbI6cjda6FKInMS1PvBZPxh6n1wjgoBCW4N/75O3Y/zFP0kTd+kBDVBw3/bBVgmcDQ/C2dbTPn
 MSaYHAJYlbx/fusAL7C+amS4fasEHQKbRyssV1K/nD+Hxx2D9GgExhQ0rN2Un7HZs1P4rPP1c0l
 wYNm46EJhy+ZnarPIEWrLzC8Pyq9J50RxX4U/OfPYtPyfGhC8mzffTAXZftPYTdiu0+kUosx2w5
 n6TS45viXh1Xs1WgLMUtDzZ/ZOCUwzJnaVwVuJYOFY1Nc351a9J3Env7OX0BRfwy6HQRNojzvU2
 5ipPzuGVwwq66n9Ih0b4h0nA15O7vxVIlfKAjpFaLyx+A0QW7ZV9oyDITRjcMLN3ymgo+prC3pY
 BNkIcUDytGYz90RxrDuzE1yN4V3U2428lDQRxKz03ZzyPallUg=
X-Received: by 2002:a05:6870:c1d5:b0:409:794e:fed with SMTP id
 586e51a60fabf-416abb18f8dmr1196137fac.47.1772639152369; 
 Wed, 04 Mar 2026 07:45:52 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4160d277316sm17754668fac.17.2026.03.04.07.45.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 07:45:51 -0800 (PST)
Date: Wed, 4 Mar 2026 09:45:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Conor Dooley <conor@kernel.org>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <simon.glass@canonical.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>
Subject: Re: [PATCH] kbuild: unexport sub_make_done to fix child make
 invocations
Message-ID: <20260304154549.GZ1388590@bill-the-cat>
References: <20260214024736.3726811-1-simon.glass@canonical.com>
 <177256385549.3975993.592734328770415000.b4-ty@konsulko.com>
 <20260304-robe-praising-5509e3a984cd@spud>
 <20260304150145.GX1388590@bill-the-cat>
 <20260304-acquaint-wager-688fd7fbae6a@spud>
 <20260304151154.GY1388590@bill-the-cat>
 <20260304-germproof-gawk-d26040529131@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="49PoW/c3JTvnrPQj"
Content-Disposition: inline
In-Reply-To: <20260304-germproof-gawk-d26040529131@spud>
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


--49PoW/c3JTvnrPQj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 04, 2026 at 03:24:45PM +0000, Conor Dooley wrote:
> On Wed, Mar 04, 2026 at 09:11:54AM -0600, Tom Rini wrote:
> > On Wed, Mar 04, 2026 at 03:09:40PM +0000, Conor Dooley wrote:
> > > On Wed, Mar 04, 2026 at 09:01:45AM -0600, Tom Rini wrote:
> > > > On Wed, Mar 04, 2026 at 09:54:22AM +0000, Conor Dooley wrote:
> > > > > On Tue, Mar 03, 2026 at 12:50:55PM -0600, Tom Rini wrote:
> > > > > > On Fri, 13 Feb 2026 19:47:34 -0700, Simon Glass wrote:
> > > > > >=20
> > > > > > > The exported sub_make_done variable leaks into the environmen=
t of all
> > > > > > > child processes. When make targets like tcheck spawn independ=
ent make
> > > > > > > invocations with O=3D, those child makes inherit sub_make_don=
e=3D1, skip
> > > > > > > the KBUILD_OUTPUT setup and try to build in the source tree.
> > > > > > >=20
> > > > > > > There is a workaround that resets sub_make_done to 0 for spec=
ific test
> > > > > > > targets, but this isn't great since it has tolist every targe=
t that
> > > > > > > spawns independent make invocations.
> > > > > > >=20
> > > > > > > [...]
> > > > > >=20
> > > > > > Applied to u-boot/master, thanks!
> > > > > >=20
> > > > > > [1/1] kbuild: unexport sub_make_done to fix child make invocati=
ons
> > > > > >       commit: 4284306d22c5b6d64ecd62b462551d9d313c8104
> > > > >=20
> > > > >=20
> > > > > This breaks the build for me:
> > > > > make ARCH=3Driscv CROSS_COMPILE=3Driscv64-unknown-linux-gnu- O=3D=
build microchip_mpfs_generic_defconfig
> > > > >   GEN     Makefile
> > > > > #
> > > > > # configuration written to .config
> > > > > #
> > > > > make ARCH=3Driscv CROSS_COMPILE=3Driscv64-unknown-linux-gnu- O=3D=
build
> > > > >   HOSTCC  scripts/basic/fixdep
> > > > >   GEN     Makefile
> > > > >   HOSTCC  scripts/kconfig/conf.o
> > > > >   YACC    scripts/kconfig/zconf.tab.[ch]
> > > > >   LEX     scripts/kconfig/zconf.lex.c
> > > > >   HOSTCC  scripts/kconfig/zconf.tab.o
> > > > >   HOSTLD  scripts/kconfig/conf
> > > > > scripts/kconfig/conf  --syncconfig Kconfig
> > > > > ***
> > > > > *** Configuration file ".config" not found!
> > > > > ***
> > > > > *** Please run some configurator (e.g. "make oldconfig" or
> > > > > *** "make menuconfig" or "make xconfig").
> > > > > ***
> > > > > make[4]: *** [/stuff/u-boot/scripts/kconfig/Makefile:75: syncconf=
ig] Error 1
> > > > > make[3]: *** [/stuff/u-boot/Makefile:702: syncconfig] Error 2
> > > > > make[2]: *** [../Makefile:189: __sub-make] Error 2
> > > > > make[1]: *** No rule to make target 'include/config/auto.conf', n=
eeded by 'include/config/uboot.release'.  Stop.
> > > > > make: *** [Makefile:189: __sub-make] Error 2
> > > >=20
> > > > That's odd. What host distro and make? I don't see that on Ubuntu 2=
4.04.
> > >=20
> > > Originally my CI found it in a docker container with "from: ubuntu:no=
ble",
> > > so 24.04. I reproduced it locally on debian unstable with make 4.4.1
> >=20
> > That's even more puzzling (noble is 24.04) since that sounds very close
> > to our CI too. Can you please look more in to what's going on?
>=20
> Can I assume your CI also sets O=3D<something> then? Is the CI config
> stuff in tree, or somewhere else?

We use buildman, which in turn does separate output directories. We
also, in Azure, have one job that uses O=3D specifically. Things are
defiend in .gitlab-ci.yml and .azure-pipelines.yml

--=20
Tom

--49PoW/c3JTvnrPQj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaahTqgAKCRAr4qD1Cr/k
Cm4uAP4uTm0sqJA/0zPDgQaz44Qh7/CxdoZgetPuGh/lwGr4rgD9GZr77ISzM8m0
uozmtlap8Rh/IsNKRa4I3kxM35HNBwA=
=C7zn
-----END PGP SIGNATURE-----

--49PoW/c3JTvnrPQj--
