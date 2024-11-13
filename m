Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4176D462BF
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 15:24:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20CDE8905E;
	Wed, 13 Nov 2024 16:24:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="t6oqX11D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6496C890FD; Wed, 13 Nov 2024 16:24:30 +0100 (CET)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0705F89040
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 16:24:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3e60825aa26so4148429b6e.1
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 07:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731511467; x=1732116267; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZIU8J+PDEziLOZ+3tOcf/QWELmsn1bnsC78q6UC31PE=;
 b=t6oqX11D6zAvqdeJlfhhSc2ha0LkTTT+Ss82+oS/pKX8XmT6CVwAvrcz0bGC4GvWcV
 JVE9vqv2NzlJcIGbE3zcn39odsNMzjr5L50eVCOJg0OZxhmDE8dEHNxz9RfQ5ZrvKaCp
 rZvWdB0/hTBrvoN9iN20vBK7ctnZcoaHHSN8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731511467; x=1732116267;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZIU8J+PDEziLOZ+3tOcf/QWELmsn1bnsC78q6UC31PE=;
 b=a4DGz8RjgzRTYlc1X2ngZQI04rFXi9sS12W/DTs4eAwu6gWzN8lL/xhXHmL6SBPcIZ
 ofHEqUyKRmhfM1O+0VwyIP8zXxc58dt84vKWBiNhNyDsYQE+rOg+QVs4zsRKu3XkPlWq
 5UonWwJVrZ3PYfinJmwC3SRkf2HGLxrlwkIgtNKDNWAAXHEGuYy2WBYvqeCx+07v6ZfD
 bAPwOtv4xG9aMst6U2G0Vj94GzJWrQLzf1DPmCL5gRdDgftfywlLgkxLLYqKPYOd6UaS
 lrfB44kT2ODCU0Lwq1Cxxk1eQLy9MQ/I1ucuNom/IGrdiOkqc7qwWxZIgJc2h093aQyq
 4pew==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUvZT/3kfMT7beHkBt2K7CR5eOQJzavcnpUlNC8JUnWP8WcvjO1Q/KDY0yjC+no6pUPeUfupg=@lists.denx.de
X-Gm-Message-State: AOJu0YyIqSJy3Z3vcYJMlEYjrkkOcJaqozZRDrHIwlzNIzqa43zTdbEY
 OIdqtpeJhaBMkovAx0+uXdD3fKK385tV6Ek2GCb44JA360L1yonrxI3E5H366Q8=
X-Google-Smtp-Source: AGHT+IE1dZg/xohJ8/Iz8fvVlfLF4/9bBJN20iQhNWHuwPPlhmv3AqcmXqvPQ1JuMlVlffl8MJwYjg==
X-Received: by 2002:a05:6808:3194:b0:3e7:5ab1:35b4 with SMTP id
 5614622812f47-3e794706397mr20406199b6e.30.1731511466686; 
 Wed, 13 Nov 2024 07:24:26 -0800 (PST)
Received: from bill-the-cat ([145.14.135.248])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3e7b096b66asm608116b6e.18.2024.11.13.07.24.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 07:24:25 -0800 (PST)
Date: Wed, 13 Nov 2024 09:24:23 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 3/8] bootstd: Avoid depending on BLK
Message-ID: <20241113152423.GP3600562@bill-the-cat>
References: <CAFLszTivbDM10hCKTvnhKdWXsd6Xc8uMkt8PHt2nw3a1jASgnQ@mail.gmail.com>
 <20241018043858.GV4959@bill-the-cat>
 <CAFLszTjDeYRPoTneoKOkB1dRaSNM3AUEApGc+rmxKmLvQVvEqA@mail.gmail.com>
 <20241018151152.GX4959@bill-the-cat>
 <CAFLszTj=u-NSYq3RXJP=wcbPZ0C=ikvX62yyOPF1D+vw11RUiQ@mail.gmail.com>
 <20241018175254.GB4959@bill-the-cat>
 <CAFLszTiQHArgoS5zK6aKpi1kiTBcAT4wEkbFaVSt5FjVQ8vmpQ@mail.gmail.com>
 <20241018182937.GE4959@bill-the-cat>
 <CAFLszTjKs0NocoePYyCZMufYg5ahKEHNcux_EwJkT6N1=1T+cQ@mail.gmail.com>
 <CAFLszTj8MK4QmxrQqALXi01EuXHrT2zXwbhR9qmC=txE1nqgLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="amZX8m/Bsm1bR3DK"
Content-Disposition: inline
In-Reply-To: <CAFLszTj8MK4QmxrQqALXi01EuXHrT2zXwbhR9qmC=txE1nqgLw@mail.gmail.com>
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


--amZX8m/Bsm1bR3DK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 07:39:53AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 18 Oct 2024 at 12:48, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Tom,
> >
> > On Fri, 18 Oct 2024 at 12:29, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, Oct 18, 2024 at 12:06:46PM -0600, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Fri, 18 Oct 2024 at 11:52, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Fri, Oct 18, 2024 at 11:20:40AM -0600, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Fri, 18 Oct 2024 at 09:11, Tom Rini <trini@konsulko.com> wro=
te:
> > > > > > >
> > > > > > > On Fri, Oct 18, 2024 at 09:00:49AM -0600, Simon Glass wrote:
> > > > > > > > Hi Tom,
> > > > > > > >
> > > > > > > > On Thu, 17 Oct 2024 at 22:39, Tom Rini <trini@konsulko.com>=
 wrote:
> > > > > > > > >
> > > > > > > > > On Thu, Oct 17, 2024 at 04:12:02PM -0700, Simon Glass wro=
te:
> > > > > > > > >
> > > > > > > > > > In principle bootstd can work without block devices, ev=
en if it does
> > > > > > > > > > require driver model to be enabled in that case.
> > > > > > > > > >
> > > > > > > > > > The use of a 'depends on BLK' for BOOTSTD conflicts wit=
h the way 'BLK'
> > > > > > > > > > is now defined, producing recursive errors through mult=
iple different
> > > > > > > > > > paths, one of which is this (with Linksprite_pcDuino3 a=
nd
> > > > > > > > > > BOOTSTD_DEFAULTS enabled):
> > > > > > > > > >
> > > > > > > > > >   arch/arm/Kconfig:7:error: recursive dependency detect=
ed!
> > > > > > > > > >   arch/arm/Kconfig:7: symbol ARM64 is selected by ARCH_=
UNIPHIER_V8_MULTI
> > > > > > > > > >   arch/arm/mach-uniphier/Kconfig:17: symbol ARCH_UNIPHI=
ER_V8_MULTI is
> > > > > > > > > >      part of choice <choice>
> > > > > > > > > >   arch/arm/mach-uniphier/Kconfig:6: choice <choice> con=
tains symbol
> > > > > > > > > >      ARCH_UNIPHIER_V8_MULTI
> > > > > > > > > >   arch/arm/mach-uniphier/Kconfig:17: symbol ARCH_UNIPHI=
ER_V8_MULTI is
> > > > > > > > > >      part of choice SPL
> > > > > > > > > >   arch/arm/mach-stm32mp/Kconfig:3: symbol SPL depends o=
n SUPPORT_SPL
> > > > > > > > > >   common/spl/Kconfig:1: symbol SUPPORT_SPL is selected =
by ASPEED_AST2600
> > > > > > > > > >   arch/arm/mach-aspeed/Kconfig:26: symbol ASPEED_AST260=
0 is part of
> > > > > > > > > >      choice <choice>
> > > > > > > > > >   arch/arm/mach-aspeed/Kconfig:12: choice <choice> cont=
ains symbol
> > > > > > > > > >      ASPEED_AST2500
> > > > > > > > > >   arch/arm/mach-aspeed/Kconfig:17: symbol ASPEED_AST250=
0 is part of
> > > > > > > > > >      choice DM_RESET
> > > > > > > > > >   arch/arm/mach-renesas/Kconfig.rcar3:197: symbol DM_RE=
SET is selected
> > > > > > > > > >      by CLK_RCAR_GEN3
> > > > > > > > > >   drivers/clk/renesas/Kconfig:53: symbol CLK_RCAR_GEN3 =
depends on
> > > > > > > > > >      CLK_RENESAS
> > > > > > > > > >   drivers/clk/renesas/Kconfig:1: symbol CLK_RENESAS dep=
ends on CLK
> > > > > > > > > >   drivers/clk/Kconfig:3: symbol CLK is selected by IMX8=
M_POWER_DOMAIN
> > > > > > > > > >   drivers/power/domain/Kconfig:35: symbol IMX8M_POWER_D=
OMAIN depends on
> > > > > > > > > >      POWER_DOMAIN
> > > > > > > > > >   drivers/power/domain/Kconfig:3: symbol POWER_DOMAIN i=
s selected by
> > > > > > > > > >      BCM6318_USBH_PHY
> > > > > > > > > >   drivers/phy/Kconfig:83: symbol BCM6318_USBH_PHY depen=
ds on PHY
> > > > > > > > > >   drivers/phy/Kconfig:4: symbol PHY is selected by USB_=
EHCI_MX7
> > > > > > > > > >   drivers/usb/host/Kconfig:211: symbol USB_EHCI_MX7 dep=
ends on USB
> > > > > > > > > >   drivers/usb/Kconfig:1: symbol USB is selected by BOOT=
STD_DEFAULTS
> > > > > > > > > >   boot/Kconfig:455: symbol BOOTSTD_DEFAULTS depends on =
BOOTSTD
> > > > > > > > > >   boot/Kconfig:398: symbol BOOTSTD depends on BLK
> > > > > > > > > >   drivers/block/Kconfig:1: symbol BLK is selected by PV=
BLOCK
> > > > > > > > > >   drivers/xen/Kconfig:1: symbol PVBLOCK depends on XEN
> > > > > > > > > >   Kconfig:176: symbol XEN depends on ARM64
> > > > > > > > > >
> > > > > > > > > > We don't want to revert the change to BLK, which has be=
en in place for
> > > > > > > > > > a year now. We don't want to select BLK in BOOTSTD sinc=
e it should
> > > > > > > > > > support booting without block devices. The only realist=
ic option is to
> > > > > > > > > > remove BOOTSTD's dependency on BLK.
> > > > > > > > > >
> > > > > > > > > > Disable standard boot on the one board which fails.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > > ---
> > > > > > > > > >
> > > > > > > > > > Changes in v3:
> > > > > > > > > > - Drop wip (work-in-progress) comment in commit
> > > > > > > > > >
> > > > > > > > > > Changes in v2:
> > > > > > > > > > - Add new patch to resolve BOOTSTD->BLK recursion with =
Kconfig
> > > > > > > > > >
> > > > > > > > > >  boot/Kconfig                                   | 2 +-
> > > > > > > > > >  configs/gardena-smart-gateway-mt7688_defconfig | 1 +
> > > > > > > > > >  2 files changed, 2 insertions(+), 1 deletion(-)
> > > > > > > > > >
> > > > > > > > > > Applied to u-boot-dm, thanks!
> > > > > > > > >
> > > > > > > > > No, this is wrong, it's pulling in BOOTSTD on a ton of pl=
atforms that
> > > > > > > > > didn't have it before.
> > > > > > > >
> > > > > > > > This affects 103 boards and the size growth is considerable:
> > > > > > > >
> > > > > > > >    aarch64: (for 22/22 boards) all +15697.0 bss +26.2 data =
+710.9
> > > > > > > > rodata +1822.1 text +13137.8
> > > > > > > >        arc: (for 4/4 boards) all +15338.0 bss +4.0 data +52=
6.0 rodata
> > > > > > > > +2096.0 text +12712.0
> > > > > > > >        arm: (for 26/26 boards) all +18882.8 data +619.2 rod=
ata +1998.8
> > > > > > > > text +16264.8
> > > > > > > >       m68k: (for 17/17 boards) all +23859.9 bss +3.5 data +=
1595.8
> > > > > > > > rodata +1722.8 text +20537.8
> > > > > > > > microblaze: (for 1/1 boards) all +24713.0 bss -88.0 data +1=
248.0
> > > > > > > > rodata +2288.0 text +21265.0
> > > > > > > >       mips: (for 23/23 boards) all +21659.1 bss +39.5 data =
+746.6
> > > > > > > > rodata +2155.7 text +18717.4
> > > > > > > >      nios2: (for 2/2 boards) all +24856.0 bss +4.0 data +70=
4.0 text +24148.0
> > > > > > > >    powerpc: (for 13/13 boards) all +21746.6 data +836.3 rod=
ata +807.2
> > > > > > > > text +20103.2
> > > > > > > >
> > > > > > > > Added options are:
> > > > > > > >
> > > > > > > >    + all: CONFIG_BOOTDEV_ETH=3D1 CONFIG_BOOTMETH_EXTLINUX=
=3D1
> > > > > > > > CONFIG_BOOTMETH_GLOBAL=3D1 CONFIG_BOOTMETH_VBE=3D1
> > > > > > > > CONFIG_BOOTMETH_VBE_REQUEST=3D1 CONFIG_BOOTMETH_VBE_SIMPLE=
=3D1
> > > > > > > > CONFIG_BOOTMETH_VBE_SIMPLE_OS=3D1 CONFIG_BOOTSTD=3D1
> > > > > > > > CONFIG_BOOTSTD_BOOTCOMMAND=3D1 CONFIG_CMD_BOOTFLOW=3D1 CONF=
IG_MENU=3D1
> > > > > > > > CONFIG_PXE_UTILS=3D1
> > > > > > > >
> > > > > > > > Should I manually disable it on those platforms? I've reach=
ed the
> > > > > > > > point where bootstd needs to be available when BLK is not e=
nabled, so
> > > > > > > > need some sort of solution.
> > > > > > >
> > > > > > > What is the use case for needing all of this, without BLK bei=
ng set? I'm
> > > > > > > not sure which platforms that grew here also need bootstd?
> > > > > >
> > > > > > It is just that some XPL (I can say that now) platforms don't e=
nable
> > > > > > BLK but do need to read from a device, e.g. MMC.
> > > > >
> > > > > Er, how is that an issue for any of the XPL phases? We have
> > > > > {SPL,TPL,VPL}_BLK symbols. And BLK itself is def_bool'd on DM and=
 MMC,
> > > > > etc. And all boards enable DM now.
> > > >
> > > > I was using MMC_TINY... I still have one more series for rk3399...so
> > > > if things build OK I can perhaps just drop this patch and figure th=
is
> > > > out later?
> > >
> > > Yeah, please drop this for now and re-visit things. MMC_TINY is only =
for
> > > SPL (but tested as CONFIG_IS_ENABLED(MMC_TINY) because maybe it makes
> > > sense in the TPL sense? But it's distinctly not BLK and DM, iirc).
> >
> > Yes, I meant XPL_BLK, not BLK, oops.
>=20
> This objection is one of a few things blocking the sunxi bootstd
> conversion. If you want to see the problem for yourself, try building
> Linksprite_pcDuino3 with this series applied sans this patch.
>=20
> The other thing blocking it is bootmgr, which we either need to
> disable for sunxi, or revert a patch which the author doesn't want
> reverted.
>=20
> So for now I'll just send a v4 with patches for those two things and
> we can discuss it again.

We're not going to get the sunxi series in for v2025.01, so we have time
to think about this still and try and get the code to match up with the
use cases.

--=20
Tom

--amZX8m/Bsm1bR3DK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmc0xKcACgkQFHw5/5Y0
tywuaQv/cg3hpGu0iYTDbcO9jf2uEiAnpJladyzOjswn0bbu81Wflg5tGjODIvqj
TGgfZCp1OysdPT90aIkBSpSEhHMhQQQl+oCPrBLMMpLo0Lw2Wkx3OeF7i2sllyNg
FQbPO2HOdDCO1jac5dY8caoM7Ukd1IvnROvHSXp7l0RjHDcpkLf2hSzVbrnmGAwi
XJtF/s1b/r21DnTuMj/q5mbFjRlyZ6bpI3pxT+oHIXtINwX8TFymUhXhAL3wDXkj
x4IfkNjBNGTsiOrTYePXZPrbmeMnynJV6xh6N4pDC1DzOQUqMFDIiIprBUocyQKR
8gksf0lpmeBnjqpCFpGrOABt34b7GDL7JgKDBIaA6hFrpqfOSgcCpA1euodwIqZw
WWJX158ZQMkpGLHgB8G/Lr7QczhZz/aDt7x+oaTK27zTuY6VjbRvOxR74evgRe8t
123uq0wkS2Q0T72nAIJ47aWfUb5rx7EASKjxqVEkl8EjEIAK4fri9gFxk8gfd2U+
Emnu5P8K
=KKKI
-----END PGP SIGNATURE-----

--amZX8m/Bsm1bR3DK--
