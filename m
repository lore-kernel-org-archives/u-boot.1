Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2405C83F03
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 13:35:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2507E8206E;
	Fri,  4 Jul 2025 15:35:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Bd2i6V0f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B28F08206E; Fri,  4 Jul 2025 15:35:04 +0200 (CEST)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF7BE806D8
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 15:35:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-60f276c7313so626344eaf.2
 for <u-boot@lists.denx.de>; Fri, 04 Jul 2025 06:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751636100; x=1752240900; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7dxNye92mJU/8SpaMf89BlnVDNiEwuvMy6JXlC/cWrA=;
 b=Bd2i6V0fDITe1gCMlUAUBvesd5Sq8AKSK5tltgm1XQJNB9IQYPb7+AWLcmRQbfubof
 VvX/Y+ELraryUJJp3ndwLkQekLU1nkzP5GPws1C0FTW6OqcF7nspGwnhdIhN5wMSZ40r
 /WBdw+NuH71QCKlDddPRsu5DT1zzRxLu04Mno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751636100; x=1752240900;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7dxNye92mJU/8SpaMf89BlnVDNiEwuvMy6JXlC/cWrA=;
 b=M9xpJ2KsJWlW//g50/sZZDn3sdxF6V1mzAXnEd0y7O+Zg1BnKZ4IU0/JlDSEvUSyQ5
 y02rN61kmp0mbtkYY9ZgkQUURRlFekosNi6ihwjey0fkn+6H0Ee+8CTrX5ns7QdlzoJZ
 cDbeJskWzppVizpoPVAUtkX2+RVDABqmipOFAKy4ylQPMC6265U9l+NLsBU1JXenN/s8
 7QXUopzMsQGmIXNzHFnW4+mOMEg3BviRcLXqJkuObJCiu6pcBrykKoSZYcpKFcIkDEwv
 6mAh6CFU5tS+pq2XHJJSO5ObtYLwadFRk4pQC68bqo7YR6nd12kO6DqM6U4eAV5UPFje
 2tRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWau+PAVvufkWqjcgMf21rHiRbDdBBeWjuHwS96Daarhcj1MtpZ7TjyowMH/5FrGeAzc6tRgs=@lists.denx.de
X-Gm-Message-State: AOJu0YxYn61+I42tns1Eyb9ts3UTBa+4n0TMMmkhu0YgDkni/A6nGvkm
 1Cd6RzUO/8vZFAG5lN0Om6UYW0Js7Avz2SkM6oKSgDgwM0R7XSXUeTJc9I29AM/pGYA=
X-Gm-Gg: ASbGncvLJFOK75VFR6G04pSok7+r1zmUqJVuvn1QVtZ4lEyo5a6fqwFbII/6LZgrjE5
 ApbKLCAzwj5K5guqFS23/xSUBFHwO0/UDJtigLPhzVhltNaFzXyQyJ6NQURxuKPrRFBAQ0qbfAp
 VpOGbLoJbFkl2YVGOBfZJTaIeDAp44k7/3GWnr2ne7EzypC5FQT01zxIUPrAzRmqxb3eis/s4tp
 uCQm4Is8T+l2OWyKDBmHCfNnwoWNuYqhI8zksi3G6W27h4X+XLDnM5FUA9TBwfqEGGfaLHbVp4d
 xF+Xds3p2SRBX74fs9BF1oU7hxiw0PZ5WrTXg1XsarBRVm6YuMBikJtoSX6im2V2AQHay19m5w0
 Zt4SXrS4z2guVrp7Rjgbi
X-Google-Smtp-Source: AGHT+IG2GJBS1VFxVG6T/MJ6ZLkA5JZFscqMw/8zCgrWhLODLn7WYDkVOViw/LcCI9IBT2W0qPls1A==
X-Received: by 2002:a05:6820:2114:b0:611:4bfe:610a with SMTP id
 006d021491bc7-61392be7a60mr1394605eaf.8.1751636100307; 
 Fri, 04 Jul 2025 06:35:00 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73c9f751e24sm379011a34.19.2025.07.04.06.34.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 06:34:59 -0700 (PDT)
Date: Fri, 4 Jul 2025 07:34:57 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: Pieter Van Trappen <pieter.van.trappen@cern.ch>, vtpieter@gmail.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH v3 1/4] Improve user feedback in case of FPGA bitstream
 load failure
Message-ID: <20250704133457.GE6424@bill-the-cat>
References: <20250626093519.115655-1-vtpieter@gmail.com>
 <20250626093519.115655-2-vtpieter@gmail.com>
 <6e88abac-88fd-4b65-abff-bb36c2e7203c@amd.com>
 <0a6df085-d0f6-4274-8f47-2ef291aada32@cern.ch>
 <86a735fc-3281-4b43-94ea-a8bc8cf72b0c@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5GJaPZWsmlIOYEfp"
Content-Disposition: inline
In-Reply-To: <86a735fc-3281-4b43-94ea-a8bc8cf72b0c@amd.com>
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


--5GJaPZWsmlIOYEfp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 04, 2025 at 03:21:08PM +0200, Michal Simek wrote:
>=20
>=20
> On 7/4/25 14:38, Pieter Van Trappen wrote:
> > On 02/07/2025 10:51, Michal Simek wrote:
> > > On 6/26/25 11:35, vtpieter@gmail.com wrote:
> > > > From: Pieter Van Trappen <pieter.van.trappen@cern.ch>
> > > >=20
> > > > In cmd/fpga.c, change some `debug` calls to `log_err` for important
> > > > user feedback and use CMD_RET_FAILURE in favor of CMD_RET_USAGE due=
 to
> > > > its long output which hides the actual, useful return message. Chan=
ge
> > > > the remaining `debug` calls to `log_debug`. Remove all 'fpga:' and
> > > > __func__ strings as `log_*` has this covered.
> > > >=20
> > > > For `do_fpga_loads`, move up the `do_fpga_check_params` call for mo=
re
> > > > consistent command output; use a constant instead of multiple '5' u=
se.
> > > >=20
> > > > In drivers/fpga/zynq*.c, change 'up to' to 'above' which corrects t=
his
> > > > confusing/wrong statement.
> > > >=20
> > > > Signed-off-by: Pieter Van Trappen <pieter.van.trappen@cern.ch>
> > > > ---
> > > > =C2=A0 cmd/fpga.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 99 +++++++++++++++++++++------------------=
--
> > > > =C2=A0 drivers/fpga/zynqmppl.c |=C2=A0 4 +-
> > > > =C2=A0 drivers/fpga/zynqpl.c=C2=A0=C2=A0 |=C2=A0 4 +-
> > > > =C2=A0 3 files changed, 54 insertions(+), 53 deletions(-)
> > >=20
> > > I would be the best if you can create also cover letter.
> > > But let me reply to this patch but issue is likely related to
> > > others. I am also not in CC on 3/4.
> >=20
> > Hi Michal, well there's a cover letter (v3 0/4) but it's only been sent
> > to the mailing list cause for the actual patches I use the
> > get_maintainer.pl script (only). Probably also the reason why the 3/4
> > patch, amending the sandbox_defconfig, didn't reach you. I'll make sure
> > all v4 patches are sent to you.
> >=20
> > > Anyway CI is failing with
> > > $ tools/buildman/buildman -o ${UBOOT_TRAVIS_BUILD_DIR} -w -E -W -e
> > > -- board ${TEST_PY_BD} ${OVERRIDE}
> > > Building current source for 1 boards (1 thread, 64 jobs per thread)
> > > =C2=A0=C2=A0=C2=A0 sandbox:=C2=A0 +=C2=A0=C2=A0 sandbox
> > > +drivers/fpga/fpga.c:23:13: error: =E2=80=98fpga_no_sup=E2=80=99 defi=
ned but not
> > > used [- Werror=3Dunused-function]
> > > +=C2=A0=C2=A0 23 | static void fpga_no_sup(char *fn, char *msg)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~~
> > > +cc1: all warnings being treated as errors
> > > +make[3]: *** [scripts/Makefile.build:249: drivers/fpga/fpga.o] Error=
 1
> > > +make[2]: *** [scripts/Makefile.build:388: drivers/fpga] Error 2
> > > +make[1]: *** [Makefile:1930: drivers] Error 2
> > >=20
> > > which should be fixed.
> >=20
> > OK I can fix this. Where does this CI job run? Also do you know if there
> > a reason why not all -Werror options are on by default in the Makefile
> > (KBUILD_CFLAGS) while they are on for the CI?
>=20
> As far as I know we have two pipelines. One in Azure and another via gitl=
ab.
> I do use gitlab one as the part of source.denx.de.
>=20
> I can't see any platform which has WERROR enabled by default.
>=20
> M
>=20
>  30 config WERROR
>  31         bool "Compile U-Boot with warnings as errors"
>  32         help
>  33           A U-Boot build should not cause any compiler warnings, and =
this
>  34           enables the '-Werror' flag to enforce that rule.
>  35
>  36           However, if you have a new (or very old) compiler or linker=
 with odd
>  37           and unusual warnings, or you have some architecture with pr=
oblems,
>  38           you may need to disable this config option in order to
>  39           successfully build U-Boot.
>=20

We've had -Werror being passed in CI, via buildman for basically
forever, but only recently added the WERROR Kconfig option to make it
easier for the non-buildman flow to also use it.

--=20
Tom

--5GJaPZWsmlIOYEfp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhn2IEACgkQFHw5/5Y0
tyw1lgv8DvMSIqqWiuNpSqBHxjxx/do+N8NSKN+JLggX+brSMWCXf/fn4ob/LsB2
vslexgABEdEy8n0OO5gjEsCCvt6mkJml67gLZXA1H+m1/bOGMB8d3TMcCLwYXi4x
YQn2Ph4PblhVfwivir7FdoMczGC7o921nOXJe6Xl/BJjR2SKGx+U/vqv74td/CaJ
oTZgxKKB8Q7NpueoD7hETrCoK78auTPFIa3oT1nFUK4YQ8m/UEamBBc+TUxARtW1
rfayxrKrTfcMnq7GlS3Mf3L6vx7idPmm3ABDm6/dshFR66itzljj4aHUeIWHc90n
jCqJeTKOHIoJ9sIu8XZySNXXDw3Lc3adPAlg3X9I6TTQGxirCkgUFk/Z6xri8fBM
tu75DDsoU/+KZRGe37tvgYEGb3Wq0vM9LsoDlk/Xyi+Ssugrb3iQuukdJoFl2XRp
0M9O8cC/YUzP0sILJ44zlzVvyAGGFnFkTnfPpNpau0+lGJnlvktocica0YWGzxh6
Hr4Azf/1
=isav
-----END PGP SIGNATURE-----

--5GJaPZWsmlIOYEfp--
