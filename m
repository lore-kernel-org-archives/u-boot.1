Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B78CFC021A0
	for <u-boot@archiver.kernel.org>; Thu, 13 Feb 2025 18:02:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBBC380F5C;
	Thu, 13 Feb 2025 19:02:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="b9LTv91H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBCB080EBD; Thu, 13 Feb 2025 19:02:23 +0100 (CET)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FF8880ECB
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 19:02:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e5b22d35268so997178276.3
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 10:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739469740; x=1740074540; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=W+Dxdh1Lr1C99NtFsLjgESvXJ1UONBeAvFgjkNftXcQ=;
 b=b9LTv91H5yRmFTt0olEXEaOElk3eVX+fq/opKgeMjS8u3vasVzpqAmNJecCNFea5tA
 4JwT3r8CswrSVKcgvqQ41lF14gCRp4uk3jwN/IBSa8b9/uo5oedLkdZsoDPU/HVzqfqw
 ERXiWvt0OaOejgTNfJ2sVJV35FncEIMrZGFBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739469740; x=1740074540;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W+Dxdh1Lr1C99NtFsLjgESvXJ1UONBeAvFgjkNftXcQ=;
 b=Tcm1bX5xORXTZ353fPsFkZtU7mvJWNT5mf8nW/ix3hDDDrOSs4vbdvFqerABetuOAc
 Nboj5+NavMw1gQLm+mElK3xAzWpdSClfl2aULhaxu2O9tyGqbS6tw980HPqHMaaaCGxD
 0Ou5eW/KVva3p8h4mAzP0/niOdcqYd4zpgpj9v/seH9/FQCv3g2AKxsTxaO1J9v43iFC
 ss3aw3ewCnJfWyviRp8c338ZphrE2kul3MmUYa1MsEWDigPXxLpAfsLXpdi+Eq8/+k/a
 B4rSOI+c5W6D6AdI01qevNM9Vyyr3dVSBMq8IGABHfa2NO6faFt7+HLJPhBcQiJJR6pr
 ujeQ==
X-Gm-Message-State: AOJu0YyxaRHwMlV0owH+BC+LtwUYTxjTQwjD2oAZDPwb4QzQkk1QZsaH
 4WQ/jymYsBx1t/HQGc6a4uvT93O2aS/ClubyVvVna0taBHFkInzb25ccMw0k3F8=
X-Gm-Gg: ASbGncsdSI0prZnM0KXbcog6Uzra4w2QU73rfMQm0J6OI3dDokhqpsyCRMlE5fOhMVJ
 xLXnHpRCF7t6ZpSnLy2Y7XVCVw/Hi9uFtRsHcWzjS+xG+rSL5TJUdE3QG3FFTN2c2EManOUXAGx
 Z0ExjDdhnGdVcfQiiFlVWTGViMrayx6bXCO9YEHPVrgXwZiN0JlqNuY8LjTxcvPidPds6sCSXsn
 FWnck63ID3xmTQSYJKCqNEcHvYuUfHiBagj14p8WWjQ59bRUT0mlPNfkfOkYx7wBOISAeGlI4SU
 UYxyYR8FKJ0CsZM=
X-Google-Smtp-Source: AGHT+IHYInx3v4MMx/z8k+8SIkia7vKSlqdVLXEuOTZdezj93WzaUpWjLK8xEX570J15dA9J5WgNkQ==
X-Received: by 2002:a05:6902:1704:b0:e5d:b88a:5533 with SMTP id
 3f1490d57ef6-e5db88a571dmr1962509276.44.1739469738779; 
 Thu, 13 Feb 2025 10:02:18 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e5dae0da2c3sm501518276.46.2025.02.13.10.02.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 10:02:18 -0800 (PST)
Date: Thu, 13 Feb 2025 12:02:14 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
Subject: Re: xPL Proposal
Message-ID: <20250213180214.GX1233568@bill-the-cat>
References: <CAFLszTg6sKpZ1yP3Pjgk9_Fx3MOh=ieT2oaHfgLf3_nC+xXA9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="SjHjYmNSqOUelnn1"
Content-Disposition: inline
In-Reply-To: <CAFLszTg6sKpZ1yP3Pjgk9_Fx3MOh=ieT2oaHfgLf3_nC+xXA9g@mail.gmail.com>
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


--SjHjYmNSqOUelnn1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 08:03:20AM -0700, Simon Glass wrote:

> Hi,
>=20
> I just wanted to send a note to (re-)introduce my ideas[1] for the
> next iteration of xPL.
>=20
> A recent series introduced 'xPL' as the name for the various
> pre-U-Boot phases, so now CONFIG_XPL_BUILD means that this is any xPL
> phase and CONFIG_SPL means this really is the SPL phase, not TPL. We
> still use filenames and function naming which uses 'spl', but could
> potentially adjust that.
>=20
> The major remaining problem IMO is that it is quite tricky and
> expensive (in terms of time) to add a new phase. We also have some
> medium-sized problems:
>=20
> a. The $(PHASE_), $(SPL_) rules in the Makefile are visually ugly and
> can be confusing, particularly when combined with ifdef and ifneq
>=20
> b. We have both CONFIG_IS_ENABLED() and IS_ENABLED() and they mean
> different things. For any given option, some code uses one and some
> the other, depending on what problems people have met along the way.
>=20
> c. An option like CONFIG_FOO is ambiguous, in that it could mean that
> the option is enabled in one or more xPL phases, or just in U-Boot
> proper. The only way to know is to look for $(PHASE_) etc. in the
> Makefiles and CONFIG_IS_ENABLED() in the code. This is very confusing
> and has not scaled well.
>=20
> d. We need to retain an important feature: options from different
> phases can depend on each other. As an example, we might want to
> enable MMC in SPL by default, if MMC is enabled in U-Boot proper. We
> may also want to share values between phases, such as TEXT_BASE. We
> can do this easily today, just by adding Kconfig rules.
>=20
> Proposal
>=20
> 1. Adjust kconf to generate separate autoconf.h files for each phase.
> These contain the values for each Kconfig option for that phase. For
> example CONFIG_TEXT_BASE in autoconf_spl.h is SPL's text base.
>=20
> 2. Add a file to resolve the ambiguity in (c) above, listing the
> Kconfig options which should not be enabled/valid in any xPL build.
> There are around 200 of these.
>=20
> 3. Introduce CONFIG_PPL as a new prefix, meaning U-Boot proper (only),
> useful in rare cases. This indicates that the option applies only to
> U-Boot proper and is not defined in any xPL build. It is analogous to
> CONFIG_TPL_xxx meaning 'enabled in TPL'. Only a dozen of these are
> needed at present, basically to allow access to the value for another
> phase, e.g. SPL wanting to find CONFIG_PPL_TEXT_BASE so that it knows
> the address to which U-Boot should be loaded.
>=20
> 4. There is no change to the existing defconfig files, or 'make
> menuconfig', which works just as today, including dependencies between
> options across all phases.
>=20
> 5. (next) Expand the Kconfig language[2] to support declaring phases
> (SPL, TPL, etc.) and remove the need for duplicating options (DM_MMC,
> SPL_DM_MMC, TPL_DM_MMC, VPL_DM_MMC), so allowing an option to be
> declared once for any/all phases. We can then drop the file in 2
> above.
>=20
> With this, maintaining Kconfig options, Makefiles and adding a new
> phase should be considerably easier.
>=20
> Regards,
> Simon
>=20
> [1] https://lore.kernel.org/u-boot/20230131152702.249197-1-sjg@chromium.o=
rg/
> [2] https://lore.kernel.org/u-boot/CAK7LNARQ-PgxiCh+gm2efpfXmNBkdTp18OTk3=
sHtqNsk6by5-Q@mail.gmail.com/

I'm not sure where to bring this up, so I'm going back to the top. I
wondered if your proposal fixed the problem described here:
https://lore.kernel.org/all/01020194f07b459d-184820e6-90c2-44fe-9850-f57fc2=
ebaafe-000000@eu-west-1.amazonses.com/
which goes back to here:
https://lore.kernel.org/u-boot/20250211043335.92538-1-naoki@radxa.com/T/#m1=
5a3058ef1ec8afb76528e1ed3edf864c8a77ef0

So I took:
https://source.denx.de/u-boot/custodians/u-boot-dm/-/tree/splc-working?ref_=
type=3Dheads
and then modified pinebook-pro-rk3399_defconfig as described.

This fails to build to start with as:
  CC      spl/drivers/usb/gadget/g_dnl.o
In file included from /home/trini/work/u-boot/u-boot/drivers/usb/gadget/g_d=
nl.c:25:
/home/trini/work/u-boot/u-boot/drivers/usb/gadget/composite.c: In function =
'config_buf':
/home/trini/work/u-boot/u-boot/drivers/usb/gadget/composite.c:214:47: error=
: 'CONFIG_USB_GADGET_VBUS_DRAW' undeclared (first use in this function)
  214 |         c->bMaxPower =3D config->bMaxPower ? : (CONFIG_USB_GADGET_V=
BUS_DRAW / 2);
      |                                               ^~~~~~~~~~~~~~~~~~~~~=
~~~~~~
/home/trini/work/u-boot/u-boot/drivers/usb/gadget/composite.c:214:47: note:=
 each undeclared identifier is reported only once for each function it appe=
ars in
/home/trini/work/u-boot/u-boot/drivers/usb/gadget/composite.c: In function =
'set_config':
/home/trini/work/u-boot/u-boot/drivers/usb/gadget/composite.c:462:53: error=
: 'CONFIG_USB_GADGET_VBUS_DRAW' undeclared (first use in this function)
  462 |         power =3D c->bMaxPower ? (2 * c->bMaxPower) : CONFIG_USB_GA=
DGET_VBUS_DRAW;
      |                                                     ^~~~~~~~~~~~~~~=
~~~~~~~~~~~~
/home/trini/work/u-boot/u-boot/drivers/usb/gadget/g_dnl.c: At top level:
/home/trini/work/u-boot/u-boot/drivers/usb/gadget/g_dnl.c:49:36: error: 'CO=
NFIG_USB_GADGET_MANUFACTURER' undeclared here (not in a function)
   49 | static const char manufacturer[] =3D CONFIG_USB_GADGET_MANUFACTURER;
      |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from /home/trini/work/u-boot/u-boot/arch/arm/include/asm/b=
yteorder.h:29,
                 from /home/trini/work/u-boot/u-boot/include/linux/libfdt_e=
nv.h:15,
                 from /home/trini/work/u-boot/u-boot/include/linux/libfdt.h=
:6,
                 from /home/trini/work/u-boot/u-boot/include/fdtdec.h:17,
                 from /home/trini/work/u-boot/u-boot/include/usb.h:14,
                 from /home/trini/work/u-boot/u-boot/drivers/usb/gadget/g_d=
nl.c:15:
/home/trini/work/u-boot/u-boot/drivers/usb/gadget/g_dnl.c:65:44: error: 'CO=
NFIG_USB_GADGET_VENDOR_NUM' undeclared here (not in a function)
   65 |         .idVendor =3D __constant_cpu_to_le16(CONFIG_USB_GADGET_VEND=
OR_NUM),
      |                                            ^~~~~~~~~~~~~~~~~~~~~~~~=
~~~~
/home/trini/work/u-boot/u-boot/include/linux/byteorder/little_endian.h:24:6=
0: note: in definition of macro '__constant_cpu_to_le16'
   24 | #define __constant_cpu_to_le16(x) ((__force __le16)(__u16)(x))
      |                                                            ^
/home/trini/work/u-boot/u-boot/drivers/usb/gadget/g_dnl.c:66:45: error: 'CO=
NFIG_USB_GADGET_PRODUCT_NUM' undeclared here (not in a function)
   66 |         .idProduct =3D __constant_cpu_to_le16(CONFIG_USB_GADGET_PRO=
DUCT_NUM),
      |                                             ^~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~
/home/trini/work/u-boot/u-boot/include/linux/byteorder/little_endian.h:24:6=
0: note: in definition of macro '__constant_cpu_to_le16'
   24 | #define __constant_cpu_to_le16(x) ((__force __le16)(__u16)(x))
      |                                                            ^
make[4]: *** [/home/trini/work/u-boot/u-boot/scripts/Makefile.build:267: sp=
l/drivers/usb/gadget/g_dnl.o] Error 1
make[3]: *** [/home/trini/work/u-boot/u-boot/scripts/Makefile.build:407: sp=
l/drivers/usb/gadget] Error 2
make[2]: *** [/home/trini/work/u-boot/u-boot/scripts/Makefile.spl:523: spl/=
drivers] Error 2
make[1]: *** [/home/trini/work/u-boot/u-boot/Makefile:2055: spl/u-boot-spl]=
 Error 2
make[1]: Leaving directory '/tmp/pinebook-pro-rk3399'
make: *** [Makefile:177: sub-make] Error 2

I tried adding the following:
diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index e120efeb0073..c28ff53f3770 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -47,6 +47,16 @@ config USB_GADGET_MANUFACTURER
 	  Vendor name of the USB device emulated, reported to the host device.
 	  This is usually either the manufacturer of the device or the SoC.
=20
+config SPL_USB_GADGET_MANUFACTURER
+	string
+	depends on USB_GADGET_MANUFACTURER
+	default USB_GADGET_MANUFACTURER
+
+config TPL_USB_GADGET_MANUFACTURER
+	string
+	depends on USB_GADGET_MANUFACTURER
+	default USB_GADGET_MANUFACTURER
+
 config USB_GADGET_VENDOR_NUM
 	hex "Vendor ID of the USB device"
 	default 0x1f3a if ARCH_SUNXI
@@ -57,6 +67,16 @@ config USB_GADGET_VENDOR_NUM
 	  This is usually the board or SoC vendor's, unless you've registered
 	  for one.
=20
+config SPL_USB_GADGET_VENDOR_NUM
+	depends on USB_GADGET_VENDOR_NUM
+	default USB_GADGET_VENDOR_NUM
+	hex
+
+config TPL_USB_GADGET_VENDOR_NUM
+	depends on USB_GADGET_VENDOR_NUM
+	default USB_GADGET_VENDOR_NUM
+	hex
+
 config USB_GADGET_PRODUCT_NUM
 	hex "Product ID of the USB device"
 	default 0x1010 if ARCH_SUNXI
@@ -70,6 +90,16 @@ config USB_GADGET_PRODUCT_NUM
 	help
 	  Product ID of the USB device emulated, reported to the host device.
=20
+config SPL_USB_GADGET_PRODUCT_NUM
+	hex
+	depends on USB_GADGET_PRODUCT_NUM
+	default USB_GADGET_PRODUCT_NUM
+
+config TPL_USB_GADGET_PRODUCT_NUM
+	hex
+	depends on USB_GADGET_PRODUCT_NUM
+	default USB_GADGET_PRODUCT_NUM
+
 config USB_GADGET_ATMEL_USBA
 	bool "Atmel USBA"
 	select USB_GADGET_DUALSPEED
@@ -149,6 +179,11 @@ config USB_GADGET_VBUS_DRAW
 	   This value will be used except for system-specific gadget
 	   drivers that have more specific information.
=20
+config SPL_USB_GADGET_VBUS_DRAW
+	int
+	depends on USB_GADGET_VBUS_DRAW
+	default USB_GADGET_VBUS_DRAW
+
 config SDP_LOADADDR
 	hex "Default load address at SDP_WRITE and SDP_JUMP"
 	default 0

But I guess there's just a bug with that iteration of the series and
converting non-boolean options to all their xPL variants.

It also I think highlights two big problems.

One, without the Kconfig language modification as well we're going to
have an even worse problem of duplicating questions.

Two, it doesn't solve the problem of it being confusing to avoid
building FOO when FOO isn't needed on a phase. In this example we're
still building drivers/usb/dwc3/ in TPL and need 2/2 in that series to
disable a warning.

--=20
Tom

--SjHjYmNSqOUelnn1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeuM58ACgkQFHw5/5Y0
tyzwxwwAqg2ZhG+R6G3pCia74MK+Mzjx6YUPBoTX09Ng7ladw3dzxtWIvDZumxcv
UtQMBJ9OGOepQpJjE7EceYopvswqwut4hljBGihduK+AJEcWhusPY0Pn3Lq7y+pl
qzs6hL1baeySI/CweGK8RWMkrT/lLZhjaTFdTmc91kgRWdUkVKo3BdB2Xdp2Qr3k
Grep92RavdWDaKpCHroKKDstsrCEPkyOCEUGXceSqigq4BOvbaCtQjKUvcx3v6mD
5UhJZUgNKzHQcC8INw8rts8dF2HU/M1wR6DuVKl6CNWDxfLfWiCbgPNLB8narLZL
n5yR0W/A10TccvkHYwm5uXqsvROUKBzQIwV+MzqfB9xovicifWPnnxI+fZhpEkdY
3191LBlFCHYEBVintsohNq0VrMSwDZ0KuHoxEwgcGnCNU0IPLc7gxsVjLwNJG2nd
0eNuZADj/98nHScPXLUwdhek57FHSmY6T71DaZYGdb2NllYVCkZUKC2O9wuvvviL
wcadPvb4
=ZkFu
-----END PGP SIGNATURE-----

--SjHjYmNSqOUelnn1--
