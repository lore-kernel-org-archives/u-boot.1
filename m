Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32671C4167B
	for <u-boot@archiver.kernel.org>; Sun, 10 Dec 2023 16:05:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32ED9876F0;
	Sun, 10 Dec 2023 17:05:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tkcyxsVc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 745F2876F0; Sun, 10 Dec 2023 17:05:29 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19BB687076
 for <u-boot@lists.denx.de>; Sun, 10 Dec 2023 17:05:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-5c08c47c055so34671127b3.1
 for <u-boot@lists.denx.de>; Sun, 10 Dec 2023 08:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702224326; x=1702829126; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bhSRUEtlBE1CtRCfOvxm3BzHO7Pro/i+feqTCim8bDo=;
 b=tkcyxsVc9tc1E+kDj1j6v5SeSzeMU6RyKBWyw8kXfyzWim6Yf2vRYVD5xkUReSV3k5
 nsbt25Wa0+FoAevjqBvXNy9LMlETHiE7BXs9MawbkJDYSR5h4d5z5bCisI6+we2qbIEL
 NGE8qjw5wsSX/K24YC9/q9UCqqMFIE3NqwwhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702224326; x=1702829126;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bhSRUEtlBE1CtRCfOvxm3BzHO7Pro/i+feqTCim8bDo=;
 b=MvX6w8pNShmPC1AMRrPPvgbRlPIL76SUFjreviO0eXfjzoy4nU8zs4Fs3hrXStomwH
 qiJNdiL90TbTO30tS1QRiE6tb7xdB5K3o0zHUO+/C9AdSmiZxptDi9yP4DaLpShapxPV
 d3tslmYCi9KrUyWxM8bnoX7AHKHZcyTai0nBG5ZjgScGMtK0N24i93oem71aXRt94eNK
 mCp98DYwoZgS3+WZ5yreC9V+IloCVnozQ4d2Nfh9dxfuv8WHx+lzT93iUxnLlpNnDQVk
 FzN/V57iWReziQZHYSR7Ox8VjJ2gUFwOTB8FUEBWPaS8iYiq874edcdfPSrnCORXi0jb
 K0xQ==
X-Gm-Message-State: AOJu0Yw0scjDmBnotW0er9++WSZq3ZX3H6PTePHMD/44c7UwTmcW7ogM
 D/MBRH0LVQMPzAQZwd9IbVs7kg==
X-Google-Smtp-Source: AGHT+IG1Sr1LWaQYWcbWcEVU/0HRom+Qo7pKkBVgIOtDbEFR4mTgb1gumzD6wPWk8ds5TndDtJujww==
X-Received: by 2002:a0d:f603:0:b0:5d7:60ed:6a93 with SMTP id
 g3-20020a0df603000000b005d760ed6a93mr2396036ywf.54.1702224325612; 
 Sun, 10 Dec 2023 08:05:25 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-8dee-9b11-e8b3-3204.res6.spectrum.com.
 [2603:6081:7b00:6400:8dee:9b11:e8b3:3204])
 by smtp.gmail.com with ESMTPSA id
 em1-20020a05690c2b0100b005df5d596225sm1347040ywb.2.2023.12.10.08.05.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Dec 2023 08:05:24 -0800 (PST)
Date: Sun, 10 Dec 2023 11:05:22 -0500
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Sumit Garg <sumit.garg@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Stephan Gerhold <stephan@gerhold.net>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 00/21] Qualcomm generic board support
Message-ID: <20231210160522.GQ2513409@bill-the-cat>
References: <20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org>
 <CAFA6WYPe8_onKNYzAVr9RHVbwUZCTiEkDizwnfL6QRsqii-JUg@mail.gmail.com>
 <20231122140100.GT2513409@bill-the-cat>
 <CAFA6WYNoz-Pqn38FpKLj9eJxX6B019HvQoukdCma3S=+O6tOCg@mail.gmail.com>
 <20231122142758.GU2513409@bill-the-cat>
 <CAC_iWjJ6KKJH=oBcXD7gb6f8KcK+OQV4Qo=B=UNeEUk-w2q61A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NCqOBg1UYq9ndh/s"
Content-Disposition: inline
In-Reply-To: <CAC_iWjJ6KKJH=oBcXD7gb6f8KcK+OQV4Qo=B=UNeEUk-w2q61A@mail.gmail.com>
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


--NCqOBg1UYq9ndh/s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 06, 2023 at 12:44:47PM +0200, Ilias Apalodimas wrote:
> Hi Tom,
>=20
> On Wed, 22 Nov 2023 at 16:28, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Nov 22, 2023 at 07:44:09PM +0530, Sumit Garg wrote:
> > > On Wed, 22 Nov 2023 at 19:31, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Wed, Nov 22, 2023 at 11:51:29AM +0530, Sumit Garg wrote:
> > > > > Hi Caleb,
> > > > >
> > > > > On Tue, 21 Nov 2023 at 22:39, Caleb Connolly <caleb.connolly@lina=
ro.org> wrote:
> > > > [snip]
> > > > > > =3D=3D DT loading =3D=3D
> > > > > >
> > > > > > Previously, boards used the FDT blob embedded into U-Boot (via
> > > > > > OF_SEPARATE). However, most Qualcomm boards run U-Boot as a sec=
ondary
> > > > > > bootloader, so we can instead rely on the first-stage bootloade=
r to
> > > > > > populate some useful FDT properties for us (notably the /memory=
 node and
> > > > > > KASLR seed) and fetch the DTB that it provides. Combined with t=
he memory
> > > > > > map changes above, this let's us entirely avoid configuring the=
 memory
> > > > > > map explicitly.
> > > > >
> > > > > Since with this change, we don't need to embed FDT blob in the u-=
boot
> > > > > binary, so I was thinking if we really need to import DTs from Li=
nux
> > > > > for different platforms and then play a catchup game?
> > > > >
> > > > > IMO, the build command would look like following if we import
> > > > > pre-built FDT blob from Linux:
> > > > >
> > > > > - Build u-boot::
> > > > >
> > > > >        $ export CROSS_COMPILE=3D<aarch64 toolchain prefix>
> > > > >        $ make qcom_defconfig
> > > > >        $ make
> > > > >
> > > > > - gzip u-boot::
> > > > >
> > > > >        gzip u-boot-nodtb.bin
> > > > >
> > > > > - Append dtb to gzipped u-boot::
> > > > >
> > > > >         cat u-boot-nodtb.bin.gz
> > > > > <linux-tree>/arch/arm64/boot/dts/qcom/your-board.dtb >
> > > > > u-boot-nodtb.bin.gz-dtb
> > > > >
> > > > > This would avoid the maintenance burden to keep DT in sync with t=
hat
> > > > > of Linux. And since DT bindings in Linux are backwards compatible=
, we
> > > > > can say u-boot should work with DTB picked up from any Linux kern=
el
> > > > > stable release.
> > > >
> > > > I guess one question I have is, are we being passed the device tree
> > > > (since we're acting like the Linux Kernel)
> > >
> > > Yeah that is the case here, see patch #1 in this series regarding how
> > > FDT address is being retrieved from previous stage bootloader (ABL on
> > > sdm845 and qcs404 SoCs).
> >
> > That's what I thought.
> >
> > > > or knowing that we have the
> > > > dtb attached to the end of us and making use of the old kernel appe=
nded
> > > > dtb option? We're fine in for example the rpi_arm64 case of just be=
ing
> > > > given a device tree from the previous stage and not needing one in-=
tree.
> > >
> > > That's good to know and we can replicate that for Qcom platforms which
> > > are chainloaded and don't need an embedded DT.
> >
> > So yes, moving these towards the direction of rpi_arm64 and specifically
> > using imply OF_HAS_PRIOR_STAGE or select OF_HAS_PRIOR_STAGE (force that
> > the dtb must be provided to us) sounds like the right direction to take
> > these platforms.
> >
>=20
> IMHO that option isn't that useful.  Grepping for OF_HAS_PRIOR_STAGE
> shows that we use it to print where the DT came from unless I am
> missing something...

So first, all of "imply OF_HAS_PRIOR_STAGE" is wrong and should be
"select OF_HAS_PRIOR_STAGE". And then yes, it's OF_HAS_PRIOR_STAGE +
OF_BOARD (which is default y if OF_HAS_PRIOR_STAGE). That is the set of
symbols for lib/fdtdec.c::fdtdec_setup() to know to call
board_fdt_blob_setup() and it's up to the board to know where to find
the device tree we were given at run time. Generally the case here is
that we're being a fake Linux Kernel and our dtb is in memory address $X
and that in turn is set in the appropriate register.

> On top of that having implies in the Kconfig to control those prints
> makes little sense to me and it's a half-baked solution anyway,
> because may boards don't fill this properly.  This thing was cleaned
> up in 2e8d2f88439d, 2ea63271e522f, and d6f8ab30a2af46 but then got
> reintroduced in 275b4832f6bf91 without anyone acking or reviewing. I
> am fine with Caleb suggests here, but I think we can do way better.

I think the tags just got missed in 275b4832f6bf91 because that's close
enough to what I wanted at the time.

> Instead of having that imply we can get rid of it and only have
> OF_BOARD(and perhaps rename it). So a general cleanup I have in mind
> is

I _think_ the problem is that we wanted to be able to allow developers
to still be able to override the device tree. So we imply (should be
select) OF_HAS_PRIOR_STAGE so that OF_BOARD=3Dy unless told otherwise.

> CONFIG_OF_SEPARATE -> rename it to CONFIG_OF_APPEND because it is
> actually appended at the end of the binary.

I'm indifferent on this part. Reading lib/fdtdec.c::fdt_find_separate()
I can see why it's "separate" and not "append", but one could reword
things to read "append" and not "separate".

> CONFIG_OF_EMBED -> Leave it as is, it's there for debugging mostly.

Agreed.

> CONFIG_OF_BOARD perhaps rename it to something more useful, but the
> semantics are 'The DT comes from an *external* source. A bloblist,
> some EEPROM location, CPU registers etc'
> CONFIG_OF_HAS_PRIOR_STAGE -> Get rid of it again. gd already has
> gd->fdt_src, just add a FDTSRC_UNKNOWN as default and delegate the
> responsibility of filling this properly at fdtdec_setup(). The boards
> that use OF_BOARD can fill this in properly, instead of relying on
> Kconfig imply options and we can even be more explicit on where the DT
> came from.

I don't know.  All of the things you mention for what CONFIG_OF_BOARD
comes down to "the board defines where it comes from", and so OF_BOARD
is what we came up with. And maybe that whole "imply" rather than
"select" thing is so that a developer can more clearly change to
OF_SEPARATE instead.

--=20
Tom

--NCqOBg1UYq9ndh/s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV14bgACgkQFHw5/5Y0
tyzjMgv7BB4zqvh9FrXV9A9ZhH2fIrTJ7Z5RjJ3VyWjmQWVRXF7E9mfhG1VzN0sC
+5DvdPgHIUlXBZExNriwOCgJ/NFc1vQs0HZly8rhnel78k1r5rY+T6dK6T/lTysc
NkUASLvtv8otcEWsJs5b4uSQHTqMHdPYMN8p7q+JK/2aIjmzpxZH36gfriBmFrVF
YflG0NDywNZhttIlOJKCkhYwsXk8CVxCyhWwxCc6FB04KH+27kJVqKbwoYx6DqE8
WH38Nx/UJ+hqJTILrJ+KnMxiqLiCMvvf4yLrHyT5B8osSqaxjwL9Ie8aw1At9MSP
S062yBUrEALnEKf2yhdKT+ZaayL7hbQm2k1iqPRs+0s8pQrfuIIu1mUm+RQcNe6J
b+A5W58g/4+FHdY7LeDOO/GTg4aXBnEp/bxcNRdIAX+yt80hBknETpcdRp51xn+y
AzQeXVdgjp9lmKf9H30Blp80wyDrcVWyWUPYntonoU3x9b2ul3L1oxf4f723erwg
58WedvMa
=+GY5
-----END PGP SIGNATURE-----

--NCqOBg1UYq9ndh/s--
