Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B43AEA7943
	for <u-boot@archiver.kernel.org>; Wed,  4 Feb 2026 21:31:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF4C183A36;
	Wed,  4 Feb 2026 22:31:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="msikYnQc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E00D83A36; Wed,  4 Feb 2026 22:31:47 +0100 (CET)
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com
 [IPv6:2607:f8b0:4864:20::c41])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8F98800AE
 for <u-boot@lists.denx.de>; Wed,  4 Feb 2026 22:31:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc41.google.com with SMTP id
 006d021491bc7-662efd1bdd4so221121eaf.0
 for <u-boot@lists.denx.de>; Wed, 04 Feb 2026 13:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770240703; x=1770845503; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jnxqnxsfQ9sJK8UqSA5R7fc8w/24ZZDTUXRVmebypGc=;
 b=msikYnQcgbyBvO0u4KQkiCRFl2qBaie1mJrVJOgwKrTDJlIqsSZd6x4Dbj7gv3W5Vu
 4XGg42Ix3xfUWGM9W5SFAwnXLyad57Ug5nQrfK1ARXNGvb41sh9NWcRTRhSRuApfp6GS
 bLDnQBz0MrHhbYHZ+ygalA744cNCI5/MYE3V0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770240703; x=1770845503;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=jnxqnxsfQ9sJK8UqSA5R7fc8w/24ZZDTUXRVmebypGc=;
 b=tWMHxgM+7DGnYn9/gC8tVKnB3uZiwJZ8wytSxM9FxghGIU6nUl9VqeTKp/BrnJO2Zk
 MOWCWEdHrEyLw5WseSntB8h19jrcpffIZcQO+bbtOjEqjtKO0rEuQ/+XA9O0a0CDqMFh
 +v1EO1NNRgp3wVrvvOXy9INxfOD31YDC/wEuDY2WTVqjSl22gWQXe6umr+NxmkeXkprM
 ftNMCW3yrtrWDogPu9TwKRSej/WA9RysFTKKkgGgrex3BRG2YkdWFUf+ide+sdKis38B
 RQ2cBG7n2vcSFBb0kbzBcAxQPwo/nblOYhU7Vh4Ks6QA26SYnbD9z2AGwAMxpUnFPegE
 5e2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvNgtAij/ey5kHVIV1ycf50mwGeZCbDMsluqc5sS1mHnrVqmQ8Zyni27ANEggvc3TzYOLroKo=@lists.denx.de
X-Gm-Message-State: AOJu0Yx1i/fxKBnp9KG4OWsLJD86kMnIHnlzjKaVXt3ojjJADw5NK3IF
 uVCELkm4Cl6rg9M0qs/oDuisxwgcM1e08hGdoEoBBQIxCDn9CR8DNBvWa+5DYraRjio=
X-Gm-Gg: AZuq6aJf5FoYD7Rg74ZwER6oaw1FgEIAEj1XmcV0v+t21i/xJFK7/nvrXvG6Q3r4+H7
 VwATbSJiAT58X+zd4soOqUPhtoY2Ays8ubIFua/fzyvTSze6xe0Vu0+b1nU7C8FY8kC9C0BoQFF
 1afFFtxUCSxb6xNw5IFazmTzZwi8GPYjQfG5hyaJasFBpJPBsPrUVuO84XyetbHxZuz/7Qa5v9W
 zX/Fs4XfQ5BfmwcS86oMfF/bsjCvT7bHELcaHLK3wcqGo66v5+h1Ugegb748hdus1/I7HCEVd0w
 teN8Y+gnTF5n9h0rdSh6vBKwgChMPeFXPuycaY8HSjuPZV5Pq3k6ZaIU+so5Y0WB46UROMcZl/v
 EIUcdFvuOBE0qIsvZDHLu1DoI946OdIlgLzBdlsxDP80PA36hg0/ctdqfSNd/kV1j/63N8EvRMd
 Y7F2/pdFfL1GZqAUBNUPqmb8F+64hFaYmMCYDeQiSPuAJ6Yy+hvxxkp3A94c7QdMQKGAlQf1Xxh
 JArRHF+HS3X4dJCAIS8hjOtsBWNRhdLuBEVQ+OcsMhmxO/i3Q==
X-Received: by 2002:a05:6820:604:b0:663:1400:1894 with SMTP id
 006d021491bc7-66bac82b088mr338040eaf.11.1770240703617; 
 Wed, 04 Feb 2026 13:31:43 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-66a354bdf2bsm1841606eaf.9.2026.02.04.13.31.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 13:31:42 -0800 (PST)
Date: Wed, 4 Feb 2026 15:31:39 -0600
From: Tom Rini <trini@konsulko.com>
To: Phil Sutter <phil@nwl.cc>, u-boot@lists.denx.de,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Beleswar Padhi <b-padhi@ti.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Adam Ford <aford173@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Eugen Hristev <eugen.hristev@linaro.org>,
 Fabio Estevam <festevam@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>, Joel Stanley <joel@jms.id.au>,
 Kever Yang <kever.yang@rock-chips.com>,
 Michal Simek <michal.simek@amd.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ryan Chen <ryan_chen@aspeedtech.com>, Stefano Babic <sbabic@nabladev.com>
Subject: Re: [PATCH 02/10] arm: Update linker scripts to ensure appended
 device tree is aligned
Message-ID: <20260204213139.GE2603314@bill-the-cat>
References: <20260115222828.3931345-1-trini@konsulko.com>
 <20260115222828.3931345-3-trini@konsulko.com>
 <aYO3HOmFFVAkjfKD@orbyte.nwl.cc>
 <20260204212010.GD2603314@bill-the-cat>
 <aYO5r8Na5-fRYHgA@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1jKPg8WRml1qibS1"
Content-Disposition: inline
In-Reply-To: <aYO5r8Na5-fRYHgA@orbyte.nwl.cc>
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


--1jKPg8WRml1qibS1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 04, 2026 at 10:27:11PM +0100, Phil Sutter wrote:
> On Wed, Feb 04, 2026 at 03:20:10PM -0600, Tom Rini wrote:
> > On Wed, Feb 04, 2026 at 10:16:12PM +0100, Phil Sutter wrote:
> > > Hi,
> > >=20
> > > On Thu, Jan 15, 2026 at 04:19:32PM -0600, Tom Rini wrote:
> > > > With commit 0535e46d55d7 ("scripts/dtc: Update to upstream version
> > > > v1.7.2-35-g52f07dcca47c") it is now a fatal error to U-Boot if our
> > > > device tree is not 8-byte aligned. In commit f613a6e15ef7 ("ARM: OM=
AP2+:
> > > > Pad SPL binary to 8-byte alignment before DTB") Beleswar Padhi expl=
ains
> > > > that we must have ALIGN(x) statements inside of a section to ensure=
 that
> > > > padding is included and not simply that the linker address counter =
is
> > > > incremented. To that end, this patch:
> > > > - Expands some linker sections to be more readable when adding a se=
cond
> > > >   statement to the section.
> > > > - Aligns the final section before _end (for U-Boot) or
> > > >   _image_binary_end or __bss_end (for xPL phases) by 8-bytes by add=
ing
> > > >   '. =3D ALIGN(8);' to the final section before the symbol.
> > > > - Ensure that we do have alignment by adding an ASSERT so that when=
 not
> > > >   aligned we fail to link (and explain why).
> > > > - Remove now-spurious  '. =3D ALIGN(x);' statements that were inten=
ded to
> > > >   provide the above alignments.
> > > >=20
> > > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > >=20
> > > For unclear reasons, this seems to break boot via xmodem protocol on =
my
> > > Synology DS414. I found this commit via 'git bisect'. The symptom is:
> > >=20
> > > | kwboot version 2026.04-rc1-00098-g6ad0cf8f83db
> > > | Detected kwbimage v1 with SPI boot signature
> > > | Patching image boot signature to UART
> > > | Aligning image header to Xmodem block size
> > > | Sending boot message. Please reboot the target...\
> > > | Sending boot image header (67584 bytes)...
> > > |   0 % [............................................................=
=2E.........]
> > > |  13 % [............................................................=
=2E.........]
> > > |  26 % [............................................................=
=2E.........]
> > > |  39 % [............................................................=
=2E.........]
> > > |  53 % [............................................................=
=2E.........]
> > > |  66 % [............................................................=
=2E.........]
> > > |  79 % [............................................................=
=2E.........]
> > > |  92 % [......................................                      =
          ]
> > > | Done
> > > | Missing DTB
> > > | spl_init() failed: -2
> > > | ### ERROR ### Please RESET the board ###
> > > |=20
> > > |=20
> > > | xmodem: Connection timed out
> > >=20
> > > Debug printf()s in fdtdec_prepare_fdt() show that fdt_check_header()
> > > returns -FDT_ERR_BADMAGIC.
> > >=20
> > > With HEAD at a8d982e1f1726 ("x86: cpu: Fix crash on FTRACE enabled
> > > builds"), reverting arch/arm/cpu/u-boot-spl.lds like so:
> > >=20
> > > | @@ -41,14 +41,21 @@ SECTIONS
> > > |                 __binman_sym_start =3D .;
> > > |                 KEEP(*(SORT(.binman_sym*)));
> > > |                 __binman_sym_end =3D .;
> > > | -               . =3D ALIGN(8);
> > > |         }
> > > | =20
> > > | +       . =3D ALIGN(4); /* critical! */
> > > |         __image_copy_end =3D .;
> > > | +       .rel.dyn : {
> > > | +               __rel_dyn_start =3D .;
> > > | +               *(.rel*)
> > > | +               __rel_dyn_end =3D .;
> > > | +       }
> > > | +
> > > | +       . =3D ALIGN(8);
> > > |         _image_binary_end =3D .;
> > > |         _end =3D .;
> > > | =20
> > > | -       .bss : {
> > > | +       .bss __rel_dyn_start (OVERLAY) : {
> > > |                 __bss_start =3D .;
> > > |                 *(.bss*)
> > > |                  . =3D ALIGN(8);
> > >=20
> > > The SPL image starts up again and continues loading the real uboot
> > > image. Note that I have no idea what these changes actually do, so I
> > > need instructions if I should dig further.
> >=20
> > Does:
> > https://patchwork.ozlabs.org/project/uboot/patch/20260130183635.2612933=
-1-trini@konsulko.com/
> > fix it?
>=20
> Sadly not, same result.

Ugh. What file, specifically, do you send via xmodem? And so that maybe
I can more easily replicate the failure, are you using the kernel.org
gcc-14.2.0 toolchain or something else?

--=20
Tom

--1jKPg8WRml1qibS1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaYO6tAAKCRAr4qD1Cr/k
CqO/AQDTl0mzjYIwgVxW1XrqNY4HoeIdiCIbqzhIx7bHyRkB8AD+M2jRukByZkhW
HTqYF6xyRZCVqEg7EZtDrFQCORuCCAU=
=vy27
-----END PGP SIGNATURE-----

--1jKPg8WRml1qibS1--
