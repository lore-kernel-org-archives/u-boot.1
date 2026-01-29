Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E93D6B076
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 15:34:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 894CC83F32;
	Thu, 29 Jan 2026 16:34:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cB0Fndr2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECF1E83FDE; Thu, 29 Jan 2026 16:34:17 +0100 (CET)
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com
 [IPv6:2607:f8b0:4864:20::243])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C52583B32
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 16:34:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x243.google.com with SMTP id
 5614622812f47-45f015a3259so450054b6e.2
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 07:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769700850; x=1770305650; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=oidoLvGRslCuowaQ4V+YwbNMDVHZ29qAjfnE4ldUKJk=;
 b=cB0Fndr2U66qxMcR6bhRdsEmCKgPFUh7JDAsH/+7Z5h4cjEpVvYQInO+zUgkHY1vQn
 jut7avPX3HxDQXUC6MtdDqUQD7Sp4BUh/grKaLx0nDdAzt2jQy00LXSQv+N7lDY5DoTS
 HZudYJ49qL2zBrq2NeBcPcBsso9eejVUrbgb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769700850; x=1770305650;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oidoLvGRslCuowaQ4V+YwbNMDVHZ29qAjfnE4ldUKJk=;
 b=qlZOoz/DMiLW5X1EvKFUr9F/3KS0mQ0+eqOGXVuCbbhXI/k5KcPvJ0AjG77qZO8zYd
 bfy64icWDDqHWM4F0eBRr1whMlbZLTdigmIw+J3EZdKtveceGHDoHFpPhOZO+BgZN56w
 Y2HbeOTb2hKWXNOdTIXNr/Zh/4fTIR9TPisl/rThGBHQk3Tt/RR910MXdJ+ACwjGwf9j
 FvEBIgYcIqSwLu0f29O9yDhEPBMklTeMz+s4sPbsWlEsAEzkUbRjWpR2ePKMJ9lepyZc
 HCTij/VMgu5FeHPcdiMD3BGgeweTbKKolWcJSrqaaA1mQsRTtqAZ4yCTn8xrnHaa15IR
 rEAA==
X-Gm-Message-State: AOJu0YxHNwJBPLtrEg7meMQNzGAWKwaay32XD83sVeYHRFq63g/CPEsl
 4BnR9RVtiypXT2ZEwZHIvBcstdfG9hxwxqO73UJlD0F3aLScy2r4QaAkP75BPZW1FSc=
X-Gm-Gg: AZuq6aIZC0y1av0+R3OA2XpIOGPfqwWN9Ly7e9GJ8pvfCzctbRdEgM7Kv1cSLzeO+DS
 v/JsQT5X+SuUsmfgLjy1EgmwHjMZk57aUjY/5ioU4IK7I9swXdKFlb2DhXLr5AxuZo9HVvRjPPD
 WobX0creEM6wSIy9l3/Jw9foILIiYGdCmwTh6AwFh1mWIX73+sjgojC13V27GiPv89Jz0GgTsVB
 B89IKQ6/5hNB5nQiqKuNCnpurb89msdY6Gx0XZf2brAldkChJiqs4UDxDlacsfFb0Mw8jepNORa
 eoMkaFZ4emBo0Y4OtPW2WRRz95C44gY+B4j9YrG5UNZRqeP5NY7x4GXt1GA3k2HtyOVNplu/GEr
 ENSur1uosvpDZXCR7d+KaVy7CgybhwzSsHrrV4pwSLHv4kgdf27DHC2BXoN5aLQidGLqOdW1FN7
 GDP4PvteODxhNMdoMn8poXDatjkdVagbIg+Pvg/mtLayF+RnKWh57A5cznnvTC+GHOdTewcOHSJ
 lrS7ubPEwIvNUuysY1djg/rXpeS4oLRlcp0hWs=
X-Received: by 2002:a05:6808:bcc:b0:450:bbed:7a75 with SMTP id
 5614622812f47-45f34bd2eb2mr1684b6e.28.1769700850076; 
 Thu, 29 Jan 2026 07:34:10 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45f08d898c6sm3208327b6e.2.2026.01.29.07.34.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 07:34:09 -0800 (PST)
Date: Thu, 29 Jan 2026 09:34:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Sune Brian <briansune@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH] arm: Remove rel.dyn from SPL linker scripts
Message-ID: <20260129153407.GX3416603@bill-the-cat>
References: <CAN7C2SA4gFg8zxqs8aT4_ng9wTFLHdMO=C9b8LdtszMkcp0aWw@mail.gmail.com>
 <20260128145118.GJ3416603@bill-the-cat>
 <CAN7C2SBq+=xFH_doVfQqNFuVtjqVDCZUt3DVoB2MJJ6RMEhGgw@mail.gmail.com>
 <20260129145416.GR3416603@bill-the-cat>
 <CAN7C2SC05Gv_WKmNA-3JpEzPUBW27KuZrMOgXdMeL1vQXS_v1Q@mail.gmail.com>
 <20260129151919.GU3416603@bill-the-cat>
 <CAN7C2SBMTxqeN45RiAuz4oW9bKVUYDgJzmHH+eM0pNN3X6QpHw@mail.gmail.com>
 <20260129152644.GW3416603@bill-the-cat>
 <CAN7C2SA85pMyF_Mn4YrwQnaLD4Ks8y3Zr3RGn1hkEds6nM1SYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="B6bDhwCGBvBAkKJu"
Content-Disposition: inline
In-Reply-To: <CAN7C2SA85pMyF_Mn4YrwQnaLD4Ks8y3Zr3RGn1hkEds6nM1SYg@mail.gmail.com>
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


--B6bDhwCGBvBAkKJu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 29, 2026 at 11:31:51PM +0800, Sune Brian wrote:
> On Thu, Jan 29, 2026 at 11:26=E2=80=AFPM Tom Rini <trini@konsulko.com> wr=
ote:
> >
> > On Thu, Jan 29, 2026 at 11:25:03PM +0800, Sune Brian wrote:
> > > On Thu, Jan 29, 2026 at 11:19=E2=80=AFPM Tom Rini <trini@konsulko.com=
> wrote:
> > > >
> > > > On Thu, Jan 29, 2026 at 11:06:59PM +0800, Sune Brian wrote:
> > > > > On Thu, Jan 29, 2026 at 10:54=E2=80=AFPM Tom Rini <trini@konsulko=
=2Ecom> wrote:
> > > > > >
> > > > > > On Thu, Jan 29, 2026 at 10:58:21AM +0800, Sune Brian wrote:
> > > > > > > On Wed, Jan 28, 2026 at 10:51=E2=80=AFPM Tom Rini <trini@kons=
ulko.com> wrote:
> > > > > > > >
> > > > > > > > On Wed, Jan 28, 2026 at 10:49:37PM +0800, Sune Brian wrote:
> > > > > > > >
> > > > > > > > > Hi Tom,
> > > > > > > > >
> > > > > > > > > The commits after c08da5d03c2a0b72e81a11ff7ca507e3a6414db3
> > > > > > > > > All Cyclone V boards are unable to boot, not sure this pa=
tch is the fix?
> > > > > > > >
> > > > > > >
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > > Yes, those commits were unintentional and have been reverte=
d.
> > > > > > >
> > > > > > > Had tested the last commit 6a1bdb7e952d5841f42742fefa907cae5d=
c8d50a
> > > > > > > Same situation that the boards are unable to enter the SPL ph=
ase.
> > > > > > > The commit 8de6e8f8a076d2c9b6d38d8563db135c167077ec works pro=
perly.
> > > > > > > After that things are broken.
> > > > > >
> > > > > > Please give
> > > > > > https://patchwork.ozlabs.org/project/uboot/patch/20260129035512=
=2E639362-1-marek.vasut+renesas@mailbox.org/
> > > > > > a try as I think it might have been working before by alignment=
 luck
> > > > > > rather than design.
> > > > >
> > > > > Hi Tom,
> > > > >
> > > > > It is the revert itself that is broken.
> > > > > I tested f4dfa5d3c2680322fd17fcc7c6221876e00a03c2
> > > > >
> > > > >
> > > > > U-Boot SPL 2026.01-00754-gf4dfa5d3c268-dirty (Jan 29 2026 - 22:56=
:17 +0800)
> > > > > Trying to boot from MMC1
> > > > >
> > > > > Which revert is correct.
> > > > >
> > > > > But once dc2d8423b19d30472b02e02b41504226908a4291
> > > > > And revert to 431f1ce46bbffff0db8f03437a34400b11b30175
> > > > >
> > > > > Then all these broken I don't understand why even file diff cannot
> > > > > show any changes.
> > > > >
> > > > > Do you mean the revert is broken and fixed by alignment?
> > > >
> > > > I mean that arbitrary changes (as part of testing these things, the
> > > > "-dirty" in the version string would lead to failing trees now pass=
ing)
> > > > can make the difference between pass/fail to boot. Did you try Mare=
k's
> > > > patch I linked to?
> > >
> > > Yes, I had tried. Cannot boot same as I had mentioned failing commit =
#.
> > > I apply that patch on the latest master commit.
> >
> > The other, maybe, thing is you need a bigger SPL_SYS_MALLOC_F_LEN ?
> > Otherwise, you'll need to dig more and see why the device tree isn't
> > being found where expected on your platform, and possibly where it is
> > instead.
>=20
> No the failing point is done after
>=20
> f4dfa5d3c2680322fd17fcc7c6221876e00a03c2
> Revert "arm: spl: Correct alignment of .rel.dyn section"
> This reverts commit 380ddb4. Signed-off-by: Tom Rini <trini@konsulko.com>
>=20
> This commit I tried to boot and works..
>=20
> Then this commit
>=20
> dc2d8423b19d30472b02e02b41504226908a4291
> count rel_dyn
> Signed-off-by: Tom Rini <trini@konsulko.com>
>=20
> I manually replaced the old Makefile.xpl and also worked it boot.
>=20
> Then 431f1ce46bbffff0db8f03437a34400b11b30175
>=20
> Revert a number of incorrect commits
> As part of debugging the appended device tree failure, I inadvertently
> committed some changes as I was debugging to master, and not a private
> branch, and pushed them as part of the release. This reverts commit
> dc2d842 through 380ddb4. Signed-off-by: Tom Rini <trini@konsulko.com>
>=20
> This is the point that everything no longer boots.
>=20
> But between those commits there are no extra codes.
>=20
> After that all things no longer work.

Yes, and I need you to investigate your failure case here. There is no
code change between a working commit and a failing commit, which leads
me to the suggestions I gave for debugging.

--=20
Tom

--B6bDhwCGBvBAkKJu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaXt97wAKCRAr4qD1Cr/k
CjDBAQCkmmCRSgUa0vA9az6tmqbQsRfP7FOLKSpqj3tsF71bbgEA2Z9Dp5iZabwc
bfkRzyD20sH/DmH6k5entxOID5ZHCgI=
=WlDr
-----END PGP SIGNATURE-----

--B6bDhwCGBvBAkKJu--
