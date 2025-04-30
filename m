Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFE18C3ABA9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 19:32:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C32280050;
	Wed, 30 Apr 2025 21:32:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="opNGaEyw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7399380079; Wed, 30 Apr 2025 21:32:53 +0200 (CEST)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF8C98004F
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 21:32:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-2c7e5f7f0e3so107924fac.3
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 12:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746041569; x=1746646369; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JWgDESDaum7rlbMpg9KKUUiilmsWwim/5srg5oZ1fi4=;
 b=opNGaEyw2D4X8IWwW54ofpakp+FvoqE3/WnwE8ifziXAW8KJzrbAnv1CFF/ax6fK+R
 CVNi/VEcCj8oLxMyEKi1DG+6NpBQMU5zt/TFDa7NrDWzUOnY06aFLBYnWUySiUOE8IcS
 4CSVv+ZttRV/tbF0JPp0tjpdACo1zVxErTnZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746041569; x=1746646369;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JWgDESDaum7rlbMpg9KKUUiilmsWwim/5srg5oZ1fi4=;
 b=hWe9ujc4kvhSqbJ4dYTlZLURBBvtJmRhXrm2AjahHId2Xfu+4BVCSkzACWJkFPhTRe
 L2I/z/6uwHGf6Gn7DQ4K71L9ItbE6uG54s7nDN7zvGgXVIkYaMNIi6AtCPw3rKveOsLk
 LnJFjeGJ8NAwLwP9NDCMHSVdw4Z/s+xHqwuRpb4LTTVHRD38jfDffsNuFStDg3VgdZPr
 4+DTHqDsNdlPnmYC0Rx76DXr13WxKgO+zoVkMJP9RWtZU/OcTVMY631V4ZZ8KT2SCJhv
 iubydl87PPJZ4my4tLLtpLgzEfy1xhKrByyZZzlup5linuhl9sKpGkv0GBcY9q6kDjas
 jHkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4aN+WdvpGCcbgk85hYm4efZ0Vu28KT1yLqyIAWKQquRSX3hZQeUaNrAgwW2AR07ujFVCKOkk=@lists.denx.de
X-Gm-Message-State: AOJu0Yxs4cSPNTzTdgXgzheC4t7KzWSOcmD8qbojnd6gsohdtfKJU/CC
 lipjt+ScXykOptgSzHpVa1cGcKDDKoOtHUU5xf9z5Yp+exvdBP88D0o+K8pRr38=
X-Gm-Gg: ASbGncup1ZPg8WD87u+cAi+mJsAlJST4A1q0M7uzRNcNmjf3hKXoG1vEZJRZ1bRt35Q
 ZeFHquIisOc4YUBereENvY7l+Yp1FFMRMsDCR/RWDIYmZSRPu7LcNBXv8PjZE5Y6VSSHPOZXco8
 YN4xSJPGTNM8MgTDgkDrigZIiBlcD3WMqo4VQtpkm1VRi/pI3dR2xnUGTr31cL2/LYZ3ADNAOkj
 0/bPYEb7ugq/sxqcyCRVhhgFrOLOzVB20ER5O5FyAdx2DFQ3uWELonVXhfaEugOsEoYeeDxuL7B
 hYYxs638QRyhtRdZDDgsA+B5cxLACcHrvZA0aYuFLtaSioYiE/lSJ5CocQxwynfBP6FJQ2r6135
 Ctg==
X-Google-Smtp-Source: AGHT+IFD8b/Hh58WDtOzYNyPIuJ8qTb7hoEaPdCxPEVepR6/1sh4H3/1hpSHf4XCJO0SGRiPtZTjAg==
X-Received: by 2002:a05:6870:a794:b0:297:2376:9b17 with SMTP id
 586e51a60fabf-2da8c4990c5mr342175fac.19.1746041569419; 
 Wed, 30 Apr 2025 12:32:49 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2da6e598264sm586843fac.50.2025.04.30.12.32.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 12:32:48 -0700 (PDT)
Date: Wed, 30 Apr 2025 13:32:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Bryan Brattlof <bb@ti.com>
Cc: "Raghavendra, Vignesh" <vigneshr@ti.com>, Anshul Dalal <anshuld@ti.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v1] arm: add call to cleanup_before_linux for go command
Message-ID: <20250430193246.GZ1261075@bill-the-cat>
References: <20250430135751.2626849-1-anshuld@ti.com>
 <20250430162904.nmjqomr2kmxhllfc@bryanbrattlof.com>
 <20250430163156.GV1261075@bill-the-cat>
 <fa03eca6-1cdc-4ff6-abb6-fde05682da01@ti.com>
 <20250430174004.GX1261075@bill-the-cat>
 <20250430192604.5dmv465thftsm2uj@bryanbrattlof.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2HeXqIewWwIXPcc8"
Content-Disposition: inline
In-Reply-To: <20250430192604.5dmv465thftsm2uj@bryanbrattlof.com>
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


--2HeXqIewWwIXPcc8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 02:26:04PM -0500, Bryan Brattlof wrote:
> On April 30, 2025 thus sayeth Tom Rini:
> > On Wed, Apr 30, 2025 at 10:56:27PM +0530, Raghavendra, Vignesh wrote:
> > >=20
> > >=20
> > > On 4/30/2025 10:01 PM, Tom Rini wrote:
> > > > On Wed, Apr 30, 2025 at 11:29:04AM -0500, Bryan Brattlof wrote:
> > > >> On April 30, 2025 thus sayeth Anshul Dalal:
> > > >>> As discussed here[1], the go command causes undefined behavior wh=
en used
> > > >>> for running custom OSes since the icache might hold outdated data=
=2E OSes
> > > >>> usually also expect the MMU to be disabled upon execution.
> > > >>>
> > > >>> Therefore this patch adds a call to cleanup_before_linux before w=
e jump
> > > >>> to the loaded program/os which disables both the caches and the M=
MU.
> > > >>> This makes the go command's behavior consistent with riscv platfo=
rms.
> > > >>>
> > > >>
> > > >> I know quite a few other OSes are beginning to use U-Boot (QNX,=20
> > > >> GreenHills or all the other RTOSes) each with their own requiremen=
ts=20
> > > >> from the bootloader. I'm curious if we should make boot* a little =
more=20
> > > >> generic rather than abuse the 'go' command.
> > >=20
> > > VXworks has its own:
> > > https://docs.u-boot.org/en/stable/usage/os/vxworks.html
> > >=20
> > > I suppose QNX and others should ideally have their own cmds as needed.
> >=20
> > Well, what's the QNX output file format (options?) again?
>=20
> I've only ever seen outputs in compressed binary formats but I've been=20
> told there are tools to produce an ELF for the simulators
>=20
> >=20
> > > > Well, that's what bootelf is for :)
> > > >=20
> > >=20
> > > And if its not an elf but some .bin file "go" cmd should be used in
> > > conjunction with "cache" cmd here to flush/disable cache, I guess?
> >=20
> > Well, what exactly are we talking about? Is this an "in theory" or some
> > project(s) which exist today?
> >=20
>=20
> I noticed this thread mainly because of the number of RTOS people asking=
=20
> me about low level stuff U-Boot and TF-A is doing. I haven't seen any=20
> 'In-Production' type bugs but I wouldn't be surprised if U-Boot is being=
=20
> used in their CI environments today.

A number of RTOSes are already supported via "bootm". If they've stopped
working (as we don't have tests in CI for them) I'd love patches to fix
and at least instructions on how to make it fail somewhere, ideally
QEMU.

> > There's a whole lot of reasons for either a legacy header and bootm or a
> > not-legacy FIT image. The "go" command is for the "U-Boot is a debugger"
> > side of the world, not how you should kick off some OS/application in
> > production. It is all of the "this is dangerous" idioms.
> >=20
> > > If so, we should probably update the docs for this cmd appropriately =
so
> > > as to avoid end users overloading like what RISC-V did?
> >=20
> > Yes, we should clarify things as needed and unwind, most likely, what
> > RISC-V is doing. But not blindly so as perhaps there's now, sigh, a
> > production / in-the-wild case here and we're now in a sticky spot.
>=20
> I like the idea of boot${OS} flags if only to standardize the interface=
=20
> of how each OS should boot. I worry about situation where custom=20
> scripting is being used to boot in production rather than stdboot

Right. And that's part of why in this day and age, regular uses should
not be using "go". We've had and supported RTOSes via "bootm" for what
amounts to forever. We've had "bootelf" for arbitrary things for ages
too (and in turn, your custom app/RTOS/whatever using the normal bare
metal ELF linker script, target, etc makes it easier on that side too).
In more recent times, having a whatever project spit out an EFI binary
instead is also possible and done sometimes.

--=20
Tom

--2HeXqIewWwIXPcc8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgSetUACgkQFHw5/5Y0
tyzBbQv/aH0AGitXLfHdNxIQWaOH1n4jZU8yerB6zhUoigussbpuNFVVj6SYRrGk
87sqb5Poaxtfd1HoSLmjBrzq2aKutandqXkG+xECx69XhbVargaLJnhXre52D/N3
cTX6LoXyitTeKBKR+hwjeJpNZ33/q4GBnXNtioib11b+peBjSGgMEjnJ9NSW8N8O
dKLOq5KIbC/cRdax3c16PP8VyESyVXFRMgLBSSF/qXX/KeSeztxunq0jWRGQwa80
QdmQipw+BhND+74rl2Q/96mpM8+BMWPcI+l2Wev/nfsIjkKvihmX9OWIuohqySyL
FHNsdAJquGyA4OHUE+mfqiaz8OyWVDiM4ZcmM75DMAKi9OAGODxnaTcyGuqWPGWv
CDafK1itd/b7ISRDI85poN2nkn6VLfCSjOEiBIHaQAgXvNKiDoKAO9twSBbUYtSS
6+/1SxvNendKpWWrXFU6hY86o3Upy/ut+YLqexgSr9DZ3BWj0iHX9lHiBXb8mtvk
4Gi3qeTh
=nlSs
-----END PGP SIGNATURE-----

--2HeXqIewWwIXPcc8--
