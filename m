Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39AFAEFCE20
	for <u-boot@archiver.kernel.org>; Wed,  4 Mar 2026 17:34:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82D5683D8A;
	Wed,  4 Mar 2026 18:34:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EO00HCZD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 858BF83F61; Wed,  4 Mar 2026 18:34:33 +0100 (CET)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B57C83642
 for <u-boot@lists.denx.de>; Wed,  4 Mar 2026 18:34:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7d55b97f358so5723877a34.3
 for <u-boot@lists.denx.de>; Wed, 04 Mar 2026 09:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772645670; x=1773250470; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FmefEI9fq1zOaEzqSWnugs7a2ifKgd2FzUhhfla+4/A=;
 b=EO00HCZDvhCMiNmfzZ0uITzEEDU/YLyz7TyMDM7O0/DKdTYfGUg2vuAdZsO0X66rPx
 CnoUPmWNd6YHjctUb+1uLRBedLFOW/W4A0HaZS6P1BXlwrmrGUXpmlGeHv3aT6rMqHDL
 dbQ/iSvPFxHsl/ddwCP3oTRznu+qTyt0ge430=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772645670; x=1773250470;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FmefEI9fq1zOaEzqSWnugs7a2ifKgd2FzUhhfla+4/A=;
 b=sgRjHhoto6cuh/U4QyDshTfbPThrzzJ33KB2JnFNV/kG4okRjVaA44hg3gFOVFYPnb
 ZHpWf3dbseNCf5DEnSHbNuC/wqXE9mtez1V2LIfLuuEvHfbBxuy6sx/US+pKebm6lS4t
 aNx1gH09Kr8yOzOZVHdjRxPtD75rnjq84B2eLiVJKEoiYEiAqlT37PD+O0wN1ULM5C8F
 2eLr27+i6bpDJOt/Img1MVxSDnUWMyRZLNPnaXCAKYkq0iTo5WI1Ltc2Ti65aDB9KySQ
 76tb4JTtdASRePZMGMrbKvsKqmaoChVDStv4hBhWusIPT61dLYSpzT7KcoP3RoGJWyvV
 8hWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDwOqiUI4pZTtQVH4bUe9I3NgF0neLeJGY7Fcdjuczt5CwT38usQP7/3H9/X6OccssKLbS+Ko=@lists.denx.de
X-Gm-Message-State: AOJu0YxZAjdRtzuolOanYkC4YYiumF5MlM8o9+AqtKP6mi/Z32abMDnM
 7Pyvr3q/kEvVF+dvtesObHHEoyzfTIvfKxE4gBr0wXCKkikqeOvIwB2k49Lz3s2attI=
X-Gm-Gg: ATEYQzxSkFQQPq9newG+BBbwxxWKmqQFd8+8fis0szMUUH2SUzxJA/K9LgXCS8MWVGS
 ATRFoOOTZI4iciMl+eqGOAEXWPE6PCl1Bb3C2BvUu4UvPiXg8V7RbkASk8lEe8B71XE32qHgxol
 oE0xjKP09XtjAVpzLncKxAkqs02bt2uT1IzVJx75Uf4sL7uGXR+61rfxNtLXcXwY213LrokaImS
 Dlxiq91J8H7n4IP8zWYZAqPFkDwQGTuMJXzQrt+b39zEKYJCQOe9A33eCV+iUd6X6F4+DT3SWiq
 2DxZtxEonkTNi2QQ6nzbHPedLP3bOx+tqYS6oKHhMDuSSZ8GFKPs1F8WR+EejDddE9cWkwbNQtb
 GPeS4xpTz6IBMk/RLbnZwn2APHpjx1KSIbenTknJ8aQdmuverd1PLoI82mbIOcic0Db0m5sBByz
 xxxSVz21mMFR8ApeME398VNtDZAl3O6JiY1INXo4/lxqRZ6gMbiWeoY+65NvG/4wvxkZDt4Ib0y
 MMMIJTWQ2tyijZKsl37ib3V7FDlywq+QpNO77QPN1XjkbshaUgo4qrmiTUx6g==
X-Received: by 2002:a05:6830:4429:b0:7d5:becb:19ba with SMTP id
 46e09a7af769-7d6ca3ade62mr2450135a34.11.1772645669903; 
 Wed, 04 Mar 2026 09:34:29 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d5998bc31asm11732068a34.23.2026.03.04.09.34.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 09:34:29 -0800 (PST)
Date: Wed, 4 Mar 2026 11:34:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Conor Dooley <conor@kernel.org>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>, Simon Glass <simon.glass@canonical.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>
Subject: Re: [PATCH] kbuild: unexport sub_make_done to fix child make
 invocations
Message-ID: <20260304173427.GB1388590@bill-the-cat>
References: <20260214024736.3726811-1-simon.glass@canonical.com>
 <177256385549.3975993.592734328770415000.b4-ty@konsulko.com>
 <20260304-robe-praising-5509e3a984cd@spud>
 <20260304150145.GX1388590@bill-the-cat>
 <20260304-acquaint-wager-688fd7fbae6a@spud>
 <20260304151154.GY1388590@bill-the-cat>
 <20260304-germproof-gawk-d26040529131@spud>
 <20260304154549.GZ1388590@bill-the-cat>
 <CAC_iWjKehyCeLfmPWGUHAHF5YXaynWMzyYnuc-wqZmDmjQQnZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mtWKiWUe1BwtsNdn"
Content-Disposition: inline
In-Reply-To: <CAC_iWjKehyCeLfmPWGUHAHF5YXaynWMzyYnuc-wqZmDmjQQnZg@mail.gmail.com>
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


--mtWKiWUe1BwtsNdn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 04, 2026 at 06:57:42PM +0200, Ilias Apalodimas wrote:
> Hi Tom
>=20
>=20
>=20
> On Wed, 4 Mar 2026 at 17:45, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Mar 04, 2026 at 03:24:45PM +0000, Conor Dooley wrote:
> > > On Wed, Mar 04, 2026 at 09:11:54AM -0600, Tom Rini wrote:
> > > > On Wed, Mar 04, 2026 at 03:09:40PM +0000, Conor Dooley wrote:
> > > > > On Wed, Mar 04, 2026 at 09:01:45AM -0600, Tom Rini wrote:
> > > > > > On Wed, Mar 04, 2026 at 09:54:22AM +0000, Conor Dooley wrote:
> > > > > > > On Tue, Mar 03, 2026 at 12:50:55PM -0600, Tom Rini wrote:
> > > > > > > > On Fri, 13 Feb 2026 19:47:34 -0700, Simon Glass wrote:
> > > > > > > >
> > > > > > > > > The exported sub_make_done variable leaks into the enviro=
nment of all
> > > > > > > > > child processes. When make targets like tcheck spawn inde=
pendent make
> > > > > > > > > invocations with O=3D, those child makes inherit sub_make=
_done=3D1, skip
> > > > > > > > > the KBUILD_OUTPUT setup and try to build in the source tr=
ee.
> > > > > > > > >
> > > > > > > > > There is a workaround that resets sub_make_done to 0 for =
specific test
> > > > > > > > > targets, but this isn't great since it has tolist every t=
arget that
> > > > > > > > > spawns independent make invocations.
> > > > > > > > >
> > > > > > > > > [...]
> > > > > > > >
> > > > > > > > Applied to u-boot/master, thanks!
> > > > > > > >
> > > > > > > > [1/1] kbuild: unexport sub_make_done to fix child make invo=
cations
> > > > > > > >       commit: 4284306d22c5b6d64ecd62b462551d9d313c8104
> > > > > > >
> > > > > > >
> > > > > > > This breaks the build for me:
> > > > > > > make ARCH=3Driscv CROSS_COMPILE=3Driscv64-unknown-linux-gnu- =
O=3Dbuild microchip_mpfs_generic_defconfig
> > > > > > >   GEN     Makefile
> > > > > > > #
> > > > > > > # configuration written to .config
> > > > > > > #
> > > > > > > make ARCH=3Driscv CROSS_COMPILE=3Driscv64-unknown-linux-gnu- =
O=3Dbuild
> > > > > > >   HOSTCC  scripts/basic/fixdep
> > > > > > >   GEN     Makefile
> > > > > > >   HOSTCC  scripts/kconfig/conf.o
> > > > > > >   YACC    scripts/kconfig/zconf.tab.[ch]
> > > > > > >   LEX     scripts/kconfig/zconf.lex.c
> > > > > > >   HOSTCC  scripts/kconfig/zconf.tab.o
> > > > > > >   HOSTLD  scripts/kconfig/conf
> > > > > > > scripts/kconfig/conf  --syncconfig Kconfig
> > > > > > > ***
> > > > > > > *** Configuration file ".config" not found!
> > > > > > > ***
> > > > > > > *** Please run some configurator (e.g. "make oldconfig" or
> > > > > > > *** "make menuconfig" or "make xconfig").
> > > > > > > ***
> > > > > > > make[4]: *** [/stuff/u-boot/scripts/kconfig/Makefile:75: sync=
config] Error 1
> > > > > > > make[3]: *** [/stuff/u-boot/Makefile:702: syncconfig] Error 2
> > > > > > > make[2]: *** [../Makefile:189: __sub-make] Error 2
> > > > > > > make[1]: *** No rule to make target 'include/config/auto.conf=
', needed by 'include/config/uboot.release'.  Stop.
> > > > > > > make: *** [Makefile:189: __sub-make] Error 2
> > > > > >
> > > > > > That's odd. What host distro and make? I don't see that on Ubun=
tu 24.04.
> > > > >
> > > > > Originally my CI found it in a docker container with "from: ubunt=
u:noble",
> > > > > so 24.04. I reproduced it locally on debian unstable with make 4.=
4.1
> > > >
> > > > That's even more puzzling (noble is 24.04) since that sounds very c=
lose
> > > > to our CI too. Can you please look more in to what's going on?
> > >
> > > Can I assume your CI also sets O=3D<something> then? Is the CI config
> > > stuff in tree, or somewhere else?
> >
> > We use buildman, which in turn does separate output directories. We
> > also, in Azure, have one job that uses O=3D specifically. Things are
> > defiend in .gitlab-ci.yml and .azure-pipelines.yml
>=20
> I get the same error with
> make ARCH=3Darm CROSS_COMPILE=3Daarch64-linux-gnu- qemu_arm64_lwip_defcon=
fig O=3Dbuild
> make ARCH=3Darm CROSS_COMPILE=3Daarch64-linux-gnu- O=3Dbuild
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
> make[4]: *** [/home/apalos/work/u-boot-tpm/scripts/kconfig/Makefile:75:
> syncconfig] Error 1
> make[3]: *** [/home/apalos/work/u-boot-tpm/Makefile:702: syncconfig] Erro=
r 2
> make[2]: *** [../Makefile:189: __sub-make] Error 2
> make[1]: *** No rule to make target 'include/config/auto.conf', needed
> by 'include/config/uboot.release'.  Stop.
> make: *** [Makefile:189: __sub-make] Error 2
>=20
> Also the patch has a Fixes tag, but it doesn't actually fix anything.
> It just tries to improve something. Can we revert it on master at
> least? Do you want me to send a patch?

Sigh, I'll revert it, thanks.

--=20
Tom

--mtWKiWUe1BwtsNdn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaahtIgAKCRAr4qD1Cr/k
Ct0vAQCZiCs+3BreNSuhokdeUMdfMpEIXg8TnmDV++nKieP5rgEAsaO+pYwXHLLE
Irj0wfUNvXBsI9qvAd2HEZbctN22Agk=
=aAS6
-----END PGP SIGNATURE-----

--mtWKiWUe1BwtsNdn--
