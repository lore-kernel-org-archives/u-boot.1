Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A29F9C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 15:32:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D392986F87;
	Mon,  6 Nov 2023 16:32:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="t1/Gfayy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31C6087086; Mon,  6 Nov 2023 16:32:15 +0100 (CET)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E13D870A2
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 16:32:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-7789cb322deso299103685a.3
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 07:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699284722; x=1699889522; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7W0SjFfoiKHuRpc7KyoPQGEN0HwJNgA02mLvFP4MbUw=;
 b=t1/GfayySCqudcaj+8sLZBbWM2xCuoX08i3x++/9NgCI2ncRmATRiLVlbvoEwqO2gL
 tcxkHC6vdqLotsozvf5ClyF3MMu3SKJzeziWnHsC2ZGehyo749NntpGWDZjEK3PbEyea
 0ymb1IT2nY1sj4HGGDN10CjeS1Ov+XEh5Mqlc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699284722; x=1699889522;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7W0SjFfoiKHuRpc7KyoPQGEN0HwJNgA02mLvFP4MbUw=;
 b=FepgGdTkGr1xr3J2zLKTSzJ15TDZeWfBN0fWR9poKctCzq7NPpR4gHgN42JGmc4Oe6
 nrF/DvAqGyo1ympSXfcwOSoNr7wfVHJdFIhYIpo9F++Dg0FMimCfu7+GiT1FwudPB4DM
 cXWBkwPoIGG6ENPr7/AZMo3SIo/By4IzdoHpSc3FgzAHnHrOwuJ4Uq1Gbaw2WWCzeVVd
 mJY4SxW/opkxfh0fvT44kLuVT5LlAT7mm309eHLFs8AbKKrrEcufGIcSfHTIPSLucLye
 H4e8coh/xbA0sPAv1iNqGeWHa41RPYFKELC9KaeCCGbywlw6OFQ4aQ0M216uGZOWQEe6
 wvdA==
X-Gm-Message-State: AOJu0Ywf+7iv0bgQdnrFNMidjGZ+b7sDi1aCfINrB8E6wMgPZoWDbQU/
 Oy8Scg83YlJAm8/Dl7+c9IkhPA==
X-Google-Smtp-Source: AGHT+IEBJaJV8f+WSu+MNfU31wXAPcj0X5VQysKu7sLStJcce+gxkccS1j4YnFPKzlwzPS7dkd1S9w==
X-Received: by 2002:a05:620a:86ce:b0:778:9be8:275c with SMTP id
 pr14-20020a05620a86ce00b007789be8275cmr32849906qkn.33.1699284721898; 
 Mon, 06 Nov 2023 07:32:01 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 p25-20020a05620a22f900b007671cfe8a18sm3419856qki.13.2023.11.06.07.32.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 07:32:01 -0800 (PST)
Date: Mon, 6 Nov 2023 10:31:59 -0500
From: Tom Rini <trini@konsulko.com>
To: Manorit Chawdhry <m-chawdhry@ti.com>
Cc: Simon Glass <sjg@chromium.org>, Nishanth Menon <nm@ti.com>,
 Andrew Davis <afd@ti.com>, Roger Quadros <rogerq@kernel.org>,
 vigneshr@ti.com, jonas@kwiboo.se, srk@ti.com, bb@ti.com,
 praneeth@ti.com, u-boot@lists.denx.de
Subject: Re: [PATCH 1/2] board: ti: am62x: am62x.env: Fix boot_targets
Message-ID: <20231106153159.GH496310@bill-the-cat>
References: <20231004132324.44198-1-rogerq@kernel.org>
 <20231004132324.44198-2-rogerq@kernel.org>
 <26457fd1-439d-fb87-52cc-350a884a8dcd@ti.com>
 <20231004135436.ihofrxutzcdefica@audacious>
 <895a5d8f-1d5f-4f90-90a1-ca75bc1ff54f@ti.com>
 <20231005163645.GS8465@bill-the-cat>
 <20231005171010.zvza7uqyn4mcgp5g@handsaw>
 <20231005171614.yiatmyczip2jnmf4@surround>
 <CAPnjgZ1fnqgk5W_8-jkJL1keXGM4CfnK-jPnFtQcFcV+y89+cA@mail.gmail.com>
 <20231106055351.f2fny5ys6avi5qnk@ula0497581>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0+q1skHCkP0EhF12"
Content-Disposition: inline
In-Reply-To: <20231106055351.f2fny5ys6avi5qnk@ula0497581>
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


--0+q1skHCkP0EhF12
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 06, 2023 at 11:23:51AM +0530, Manorit Chawdhry wrote:
> Hi Simon,
>=20
> On 11:22-20231005, Simon Glass wrote:
> > Hi Nishanth,
> >=20
> > On Thu, 5 Oct 2023 at 11:16, Nishanth Menon <nm@ti.com> wrote:
> > >
> > > On 12:10-20231005, Nishanth Menon wrote:
> > > > On 12:36-20231005, Tom Rini wrote:
> > > > > On Thu, Oct 05, 2023 at 09:19:48AM -0500, Andrew Davis wrote:
> > > > > > On 10/4/23 8:54 AM, Nishanth Menon wrote:
> > > > > > > On 08:48-20231004, Andrew Davis wrote:
> > > > > > > > On 10/4/23 8:23 AM, Roger Quadros wrote:
> > > > > > > > > ti_mmc is not a valid boot_target for standard boot flow =
so
> > > > > > > >
> > > > > > > > Is there some way to make it into a valid boot_target? Othe=
rwise
> > > > > > > > how do we use uEnv.txt files, or boot from FIT images with =
overlays?
> > > > > > >
> > > > > > > envboot takes care of uEnv.txt file (see
> > > > > > > https://lore.kernel.org/all/20231004132324.44198-3-rogerq@ker=
nel.org/)
> > > > > > >
> > > > > > > Early remote proc loading and FIT image is a question for std=
boot itself.
> > > > > > >
> > > > > >
> > > > > > If stdboot is missing these features then we shouldn't switch u=
ntil it
> > > > > > has them. I'm all for switching to this, but only if it is comp=
lete.
> > > > >
> > > > > Depends on what you mean?  Did you mean an option to run scripts
> > > > > (exists) or an option to do what TI needs done, via
> > > > > boot/bootmeth_something.c ?  If the latter, someone from TI needs=
 to
> > > > > figure out what that should be and do (but plumbing-wise everythi=
ng it
> > > > > needs should exist).
> > > >
> > > > Andrew is generalizing here (on the wrong patch though).
> > > >
> > > > On am62x platforms, there is nothing regressing with this series. T=
he
> > > > challenge is early remote_proc loading which is done for J7* platfo=
rms.
> > > >
> > > > How that is initiated as part of bootmethods is something of a gap.
> > > >
> > > > The other gap has been support for uEnv.txt -> which we can workaro=
und
> > > > at the moment by using CONFIG_BOOTCOMMAND=3D"run envboot; bootflow =
scan
> > > > -lb" in defconfig (This series from Roger already does that - hence=
 I am
> > > > saying that Andrew is complaining on the wrong series).
> > > >
> > > > Ideally, we should just have CONFIG_BOOTCOMMAND=3D"bootflow scan -l=
b" and
> > > > uEnv.txt remoteproc loads and the various standard bootmethods shou=
ld
> > > > "just work".
> > >
> > >
> > > I forgot to add: FIT image authenticated boot flow. That is really wh=
at
> > > ti_mmc distroboot method was trying to solve.
> > >
> > > Maybe Simon or someone know how the stdboot flow handles authenticated
> > > kernel image and dtb boot flow with FIT image?
> >=20
> > Yes you can use FIT configuration verification and things should work a=
s normal.
> >=20
>=20
> Could you give any reference documentation for this?

I suspect you should start with doc/usage/fit/beaglebone_vboot.rst

--=20
Tom

--0+q1skHCkP0EhF12
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVJBu8ACgkQFHw5/5Y0
tyymVwwAkFejxm4l4h3Nka64cV6HK4elqwtIy188JxRPNYkh7Cxsr9kCNPof8ZiX
i8dq8IJoo9v4rcVA0XvYVMa1xScwxIpoMaJtfJg/DbMBIVTacqJO4IQa1DI5FbxI
gwbbZWNpeTDDAV3DSpU8XTyeOHA3/TjcecW0GGES/4k5jgnuWyV3FAiTi8Sa5rMH
hCS38AgfVVkAIzcCQu0fJ5ZY78ssLQWZujhsCXGBwjftfJuY26eKX40hN3Ca48ua
MTNei8iG3O7/EMaPA8GfIqAUlqDC2hrLQejoH3noedzKVhtA8cesQgUBcIP976r+
6dhKx3OwHmHR+WNXAU6fd5tmUSioiG/lsYixl4zkeGrFREyBX+00v74dAgpGKi9K
JditkwBRzpr5vzeAqj6mz2qjE3N+/AzBDCk6tYA/msDnPjbhoTuu2wEM9aaIfbO7
BrxvP05UDKUmr3fcw7aSl9BJekBz3ReLnBIYgFZWHLtNIuFRtDrxKs59mtIDyEia
KzjDJOQ6
=4LtK
-----END PGP SIGNATURE-----

--0+q1skHCkP0EhF12--
