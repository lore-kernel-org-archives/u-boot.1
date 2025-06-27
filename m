Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B399C7EE30
	for <u-boot@archiver.kernel.org>; Fri, 27 Jun 2025 00:01:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBC4D82C65;
	Fri, 27 Jun 2025 02:01:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qFbRMsm8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 485E182CEB; Fri, 27 Jun 2025 02:01:05 +0200 (CEST)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8EB182B34
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 02:01:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-40669fd81b5so1157911b6e.1
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 17:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750982461; x=1751587261; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JJZz5Sb0LgcBBJPVGybSulq6nOT6FirbyiQU27AMy3Q=;
 b=qFbRMsm8ynzV6JmNNSefkgrDgVbZZcMR6ASihLob0VM2KX6BqDp9Vvt8lkRvHRr3cS
 yISsLsXxnQfbvzMUlt03Gg9iU9NGnF/49WL8I5HwB2X5RcOx9W5hS1HNdb2ehhzPa70b
 eVOYlL5N0rWiAzALBIRAApTvlYCS9mJN12ppE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750982461; x=1751587261;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JJZz5Sb0LgcBBJPVGybSulq6nOT6FirbyiQU27AMy3Q=;
 b=wu7bkZJTdtUPFOK3s17ZVCFbj8AdyGvGx0SXjFfbJ2hYz8YUffodGfp1zuoK4oGZeJ
 TvPlx3l34Zg8GWRAEJiCiei1dl1R/9uxEn1q9PpXefAyOT2HqiaTq1bP5bodIPkBGpDL
 Nfrr6QBvpr86t2pChVuPESTttXoULK0CtVm0stB07xojPxUNsPKNyPMfSR+qZk7W/ayU
 d+mzozX1pAS9J14/zoTdBEa21eAN8toQrLRKvlfT6eK+swNl+NdLlzBi6iVRYOttpUDE
 3oPOcc6HGjOus5xkrTb/tWtC/NiypltQiAZvF4VMshObXuRUtYCcOVqwj7r/Cna7IAL5
 R6IQ==
X-Gm-Message-State: AOJu0YxCLwJ9i2iih3WN+Hgoa7Z+DwV8OnczPeA+iujR3oAekASj2Zyt
 PuWrdWOyHuwxPaMTMj7UNaF7t5+JwD9/DixTyxBqMMDxKOqemLFEBqNws1VXL910Nuo=
X-Gm-Gg: ASbGncsNxw+ivGPJY9KcHmCjqt9mBmtfRY9yhuFMMINC8aCNPnWMpISeEYvWgGsc2RB
 pfN2mhfHkdjsZMUOjGO4K8i7MMsZU/EF+oW0FHHNsL49OXdfWR9Jpl+4RRMYyC3aIi4wkgWGvTe
 /jvJ8t8xQMmMAO8HzF9GvOLcFSjBAUmcpKyiYTERSTeRtsX7+LvEBbRxZMd+agMaxOKiRKW6siT
 2cinJZOHo+jlKEzwvullOtXM0LMtd34G0UJIC16oTScCrBhhigyptThhkPFcHAw1ej24juYAvvf
 iaNjmFBxWWCVKq1cix+kGJnSg3VSHpRAomdeuiDscnNcPEW6baG/bCnPhQEHy+cYpnPQc6kH3NS
 sZaCdV9mVcAGdDB0vqrjFq2o=
X-Google-Smtp-Source: AGHT+IFz7kyk2Q+G0Vkf8rV0PxFJIwPoiZqyIlOOTjQMjOzpjzgsPo+6HEFCYTGNkHwx7Lk0psZtkQ==
X-Received: by 2002:a05:6808:6a96:b0:40a:a3c0:43d9 with SMTP id
 5614622812f47-40b33db2a22mr806049b6e.17.1750982461286; 
 Thu, 26 Jun 2025 17:01:01 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-611b857b8ffsm116773eaf.20.2025.06.26.17.00.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 17:01:00 -0700 (PDT)
Date: Thu, 26 Jun 2025 18:00:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, afd@ti.com, nm@ti.com, bb@ti.com
Subject: Re: [RFC PATCH v1 4/4] cmd: Kconfig: disable loading raw images in
 secure os boot
Message-ID: <20250627000058.GC4003484@bill-the-cat>
References: <20250626120443.1405409-1-anshuld@ti.com>
 <20250626120443.1405409-5-anshuld@ti.com>
 <20250626234741.GB4003484@bill-the-cat>
 <DAWVBW49Y1VW.1FGEQJ4TMI0VG@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nWfRr44wJCVvHqmI"
Content-Disposition: inline
In-Reply-To: <DAWVBW49Y1VW.1FGEQJ4TMI0VG@ti.com>
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


--nWfRr44wJCVvHqmI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025 at 05:23:59AM +0530, Anshul Dalal wrote:
> On Fri Jun 27, 2025 at 5:17 AM IST, Tom Rini wrote:
> > On Thu, Jun 26, 2025 at 05:34:42PM +0530, Anshul Dalal wrote:
> >
> >> Raw kernel images can not be authenticated so disable loading such
> >> binaries in secure falcon mode. This change restricts the falcon mode
> >> SPL to FIT as the only viable boot image which can be authenticated.
> >>=20
> >> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> >> ---
> >>  cmd/Kconfig | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>=20
> >> diff --git a/cmd/Kconfig b/cmd/Kconfig
> >> index ed741d43cea..8eb55dd7f6e 100644
> >> --- a/cmd/Kconfig
> >> +++ b/cmd/Kconfig
> >> @@ -353,12 +353,13 @@ config BOOTM_ELF
> >> =20
> >>  config CMD_BOOTZ
> >>  	bool "bootz"
> >> +	depends on !SPL_SECURE_OS_BOOT
> >>  	help
> >>  	  Boot the Linux zImage
> >> =20
> >>  config CMD_BOOTI
> >>  	bool "booti"
> >> -	depends on ARM64 || RISCV || SANDBOX
> >> +	depends on (ARM64 || RISCV || SANDBOX) && !SPL_SECURE_OS_BOOT
> >>  	default y
> >>  	help
> >>  	  Boot an AArch64 Linux Kernel image from memory.
> >
> > This is just pushing things too far and we need to step back and fix it,
> > sorry. We need BOOTZ_IMAGE_FORMAT and BOOTI_IMAGE_FORMAT to go with
> > LEGACY_IMAGE_FORMAT, and then SPL_... variants too, and then use those
> > symbols.
>=20
> I can respin one of my earlier patch series[1] that migrated these
> CMD_BOOTx symbols to SPL. But we should still disable those new symbols
> to prevent loading of unverifiable raw kernel images in secure os boot
> right?
>=20
> [1]: https://lore.kernel.org/u-boot/20250408141436.712387-1-anshuld@ti.co=
m/

I think I wasn't clear enough, sorry. We need in boot/Kconfig:

config BOOTZ_IMAGE_FORMAT
  bool
  help
    Support for the Linux Kernel "zImage" format on 32bit ARM systems.

config BOOT_IMAGE_FORMAT
  bool
  help
    Support for the Linux Kernel "Image" format found on 64bit ARM
    systems, RISC-V and other architectures within the Linux Kernel.

=2E..
config SYS_BOOTM_LEN
  ...
  depends on ... BOOTZ_IMAGE_FORMAT || SPL_BOOTZ_IMAGE_FORMAT ...


in cmd/Kconfig
config CMD_BOOTZ
  bool ...
  depends on BOOTZ_IMAGE_FORMAT

And then code / Makefiles outside of the command should use the
appropriate new symbol. arch/arm/lib/Makefile for example:
obj-$(CONFIG_$(PHASE_)BOOTZ_IMAGE_FORMAT) +=3D zimage.o
obj-$(CONFIG_$(PHASE_)BOOTI_IMAGE_FORMAT) +=3D image.o

And then yes, the SPL variants need to depend on !SPL_OS_BOOT_SECURE

--=20
Tom

--nWfRr44wJCVvHqmI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhd3zAACgkQFHw5/5Y0
tyz+AQwAsCqnz/hQQhwy5HkYJMcsyCglX6netaqtJi5f99pnW/rGencOazJOguNr
wsHpiklKm6t46T5W8Mm4G+lnx+v2xa+TpRAAot5MM8Yx/rNrO/BmwzP3BvWF/6oS
t/VZSoOwQty1+Bd3JiqrfiYUjHv++QgPXTT7wJ7oh8GrEMrbSjEgLWgpk+qTkxg0
TFmYb1xNMGVQeHnstI2kIfXQCQ65+we5wH2SS+Pwlh1T2uidjnzRGo8+iu0C0xN6
sZrDH+OL2YeEAcTEGhQXa5Q8r095pmqB6+LgGHbUgo6Y1esBQ1ZMjjdpi4SswT7d
fSScEnPZj2UkpeadOgmtcpdtxzjY+4UoaOh3fc6M7svXiRYfamOCkHEvHieCDgOU
bgQv85e8gzzs5Fe/JeCskRGE6mXdqU872bZHH0N//oTf0+8X/pc53MZmOeHOubRc
k8HTowh2olutsg7bK6y6ejXAnvQQ87uiE0kDj87CijJLxSIM0oSW19rxr/tI9SBg
mx4pSNTf
=0MpY
-----END PGP SIGNATURE-----

--nWfRr44wJCVvHqmI--
