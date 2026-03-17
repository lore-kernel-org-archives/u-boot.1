Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94093FED9E4
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 16:02:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCD7884383;
	Tue, 17 Mar 2026 17:02:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dVMVHLX8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71A4784390; Tue, 17 Mar 2026 17:02:55 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0050A84359
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 17:02:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7d7412cfb9eso5359343a34.1
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 09:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773763371; x=1774368171; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Lfd49rjZLVveP+V9wA07wnX0fBBRr7fqrSXje32RLnk=;
 b=dVMVHLX8QKxJoFPqtDpgm39BdkdPApjC991+GB7Z0kwTpKqW9Y9qpKUcI1Hj2uzScN
 cmUXzSnoU5Uyuv4dpcudxBPShe4tFGXSh6FFOXvnXxwcs12koqY4wdmIT0OsUor+SJyn
 XZx9yr+g/wClrUhqNiYkL+bskoX6bErTI+uPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773763371; x=1774368171;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lfd49rjZLVveP+V9wA07wnX0fBBRr7fqrSXje32RLnk=;
 b=DbPdt8z/t6Q/5gKdNeCOnAv1vR2f3T+H1HpQMl9r0KTQPw3hyb7NWvewM7US3pAr5x
 GkuNbbPbZKgLdlgxin1UgtwOtIfxQybIP71dhcncUlz6U0QSBZEZlhakr3ODw/eqtWN9
 GoCRWExVdk0vyalatHRXxG1/PghK8OmuEOgd0vbPEEzAb93vg11pKEDXljF2+tqFMft4
 jTJKGUyw1QxTMITepJeDvPH5pb2UyuyW0ZdlcsEoIe/z5NI224ipmHfPKEnizaXbKUDf
 hjysZ+gsYFqrMhl9rnWd9yIu3IDPJZeVK/mk8qk1hGv9N8z3kj8+EGWJ5pl2PRr79hrb
 rVTw==
X-Gm-Message-State: AOJu0YyDdUWa5CMfhldly38UNjkRgyOrSuV6IB/q6MshmdbRMxaXochp
 148vazwvyWReBBV9TmA90ZHu4goCu4SPiC5SEnA28pN1wXAIub5X2hFbAq8zTDSIvCcQMB5b5ro
 g0227sTY=
X-Gm-Gg: ATEYQzwcb2cmw4YEjPpWg52OdyIvrzSgZz2cBQZXnEhg6iEyJPYZszI/dzIfHHDBE4Q
 +lNCkVmx5Pz+1JgpC/zHy5kPsojzv4PADCb3Kz44R98Vi41MGnWpnMCqeD5uXqaBhZiOIGkrjQ3
 4+5XH/BNu56oLoXzna9jdFuViVvpTa3YVcv5XawC23gcCHR9DugUqM/V4vMM6L63YnpT82Q0l8X
 jPacZRng9gpGCSC5uUbAKESbujL9QqdsBmd9h+OSqXU1CYMFzwTo4IMgznjr9EZXXkOJDNgC3wl
 bJX6F/fThItBfUsYSSTDlo9Db5f/qL81DpPsZi1Djm/fNpZxKA0jDVZJctWT0xz7CPPi4F88+G8
 8X09KfnfDOnqVygTcXLzxhkpYTyP1zrXMGcd5iLur8xFPEDltwXwIyJ2ejYc5eV2EYAJCn9Ag8x
 blF9sVyHbx/YVBArsnOmpJjEg1kE5kfKzvuJ1IM5dGqRd4YC3VdzCZTG+6+Hb5AtvfPNLmliQRR
 iRyaOCRdqDc/AkPv0RDPONjzedR62Gb32MKSSeHfTXgKpBS3YztF5Wn2RY=
X-Received: by 2002:a05:6830:6a94:b0:7d7:b846:1ad4 with SMTP id
 46e09a7af769-7d7b8461c9amr3080096a34.7.1773763371235; 
 Tue, 17 Mar 2026 09:02:51 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d7c9b39e11sm29272a34.18.2026.03.17.09.02.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 09:02:49 -0700 (PDT)
Date: Tue, 17 Mar 2026 10:02:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] microblaze: Rework TARGET_MICROBLAZE_GENERIC
 implementation
Message-ID: <20260317160247.GE502704@bill-the-cat>
References: <20260317012412.4162279-1-trini@konsulko.com>
 <92a3aa0d-4d2f-4845-9ac2-6bcb976bced8@amd.com>
 <20260317144955.GC502704@bill-the-cat>
 <0f352388-4e79-483a-a4ca-2f14f4bea6c8@amd.com>
 <20260317154136.GD502704@bill-the-cat>
 <e239e4da-635f-448e-b6d3-c3721e66b8e6@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TWuh6Pq7dLAWWVov"
Content-Disposition: inline
In-Reply-To: <e239e4da-635f-448e-b6d3-c3721e66b8e6@amd.com>
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


--TWuh6Pq7dLAWWVov
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 04:51:12PM +0100, Michal Simek wrote:
>=20
>=20
> On 3/17/26 16:41, Tom Rini wrote:
> > On Tue, Mar 17, 2026 at 04:35:30PM +0100, Michal Simek wrote:
> > >=20
> > >=20
> > > On 3/17/26 15:49, Tom Rini wrote:
> > > > On Tue, Mar 17, 2026 at 01:06:15PM +0100, Michal Simek wrote:
> > > > >=20
> > > > >=20
> > > > > On 3/17/26 02:24, Tom Rini wrote:
> > > > > > As exposed by "make randconfig", some symbols such as
> > > > > > XILINX_MICROBLAZE0_PVR can be set without TARGET_MICROBLAZE_GEN=
ERIC but
> > > > > > have a transitive dependency on it. The easiest path of resolut=
ion here
> > > > > > is that since there is only one valid microblaze "board", rewor=
k that
> > > > > > symbol to be non-optional.
> > > > > >=20
> > > > > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > > > > ---
> > > > > > Cc: Michal Simek <michal.simek@amd.com>
> > > > > > ---
> > > > > >     arch/microblaze/Kconfig | 10 +++-------
> > > > > >     1 file changed, 3 insertions(+), 7 deletions(-)
> > > > > >=20
> > > > > > diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
> > > > > > index 4261e5009fdc..16c55ddfd95c 100644
> > > > > > --- a/arch/microblaze/Kconfig
> > > > > > +++ b/arch/microblaze/Kconfig
> > > > > > @@ -7,12 +7,8 @@ config SYS_ARCH
> > > > > >     config STATIC_RELA
> > > > > >     	def_bool y
> > > > > > -choice
> > > > > > -	prompt "Target select"
> > > > > > -	optional
> > > > > > -
> > > > > >     config TARGET_MICROBLAZE_GENERIC
> > > > > > -	bool "Support microblaze-generic"
> > > > > > +	def_bool y
> > > > > >     	select BOARD_LATE_INIT
> > > > > >     	select DM
> > > > > >     	select DM_SERIAL
> > > > > > @@ -26,8 +22,8 @@ config TARGET_MICROBLAZE_GENERIC
> > > > > >     	select MTD
> > > > > >     	select SPI
> > > > > >     	imply CMD_DM
> > > > > > -
> > > > > > -endchoice
> > > > > > +	help
> > > > > > +	  Support microblaze-generic
> > > > > >     source "board/xilinx/Kconfig"
> > > > > >     source "board/xilinx/microblaze-generic/Kconfig"
> > > > >=20
> > > > > Applied.
> > > >=20
> > > > Please drop this for now, I need to do a v2 and I've found another
> > > > randconfig that gives me:
> > > > WARNING: unmet direct dependencies detected for XILINX_MICROBLAZE0_=
PVR
> > > >     Depends on [n]: MICROBLAZE [=3Dy] && TARGET_MICROBLAZE_GENERIC =
[=3Dn]
> > > >     Selected by [y]:
> > > >     - CPU_MICROBLAZE [=3Dy] && CPU [=3Dy] && MICROBLAZE [=3Dy]
> > > >=20
> > >=20
> > > I expect this is from cpuinfo driver.
> >=20
> > Yes, it is. But it's one of the problems randconfig exposes since it
> > does funny things when generating a valid .config, and seeing what blows
> > up. What I have in progress now is removing TARGET_MICROBLAZE_GENERIC
> > entirely and using MICROBLAZE in the few tests.
> >=20
>=20
> it should be fine to mark it as dependency.
>=20
> M
>=20
> diff --git a/drivers/cpu/Kconfig b/drivers/cpu/Kconfig
> index 6a96be94de49..c805c0bbfa19 100644
> --- a/drivers/cpu/Kconfig
> +++ b/drivers/cpu/Kconfig
> @@ -35,9 +35,8 @@ config CPU_ARMV8
>=20
>  config CPU_MICROBLAZE
>         bool "Enable Microblaze CPU driver"
> -       depends on CPU && MICROBLAZE
> +       depends on CPU && MICROBLAZE && XILINX_MICROBLAZE0_PVR
>         select DM_EVENT
> -       select XILINX_MICROBLAZE0_PVR
>         help
>           Support CPU cores for Microblaze architecture.

That's another way to go yes, if you want to post that I'll drop this
part of my current WIP branches, thanks!

--=20
Tom

--TWuh6Pq7dLAWWVov
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCabl7IwAKCRAr4qD1Cr/k
CmbpAQCXJBeHnf0C8Bp0H5MGxe41H4oAFb/Nk6qbn0lgi1l1wAD7Bggry11rnRqz
bu50eLM8rjhYG7sEXV60iZqPFk1ISwE=
=XbNC
-----END PGP SIGNATURE-----

--TWuh6Pq7dLAWWVov--
