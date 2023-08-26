Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 602B2C83F01
	for <u-boot@archiver.kernel.org>; Sat, 26 Aug 2023 23:50:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11A9C846EE;
	Sun, 27 Aug 2023 01:50:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZZDVbTvi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 934688475C; Sun, 27 Aug 2023 01:50:06 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD0378468A
 for <u-boot@lists.denx.de>; Sun, 27 Aug 2023 01:50:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-59205f26e47so24049387b3.2
 for <u-boot@lists.denx.de>; Sat, 26 Aug 2023 16:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693093802; x=1693698602;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AgGujID3BErndfRxtyqjJ816iMKgQ5h7eubyndWrt4w=;
 b=ZZDVbTviuP+kaXSY9EgDc6+X9VMlbouUQhLY6DReBg7Fcu7vIhuLJ0UDIZh6S8j2dK
 mYKVlpb5EgPPvZ5VfzWa9je7f2scfZIRnihCFjbyILzUbSXL5Lc0PM3Zbna95XiuXHx2
 Yqz06UEw9c72nZe26OhuEMn36KPNbssTKgNP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693093802; x=1693698602;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AgGujID3BErndfRxtyqjJ816iMKgQ5h7eubyndWrt4w=;
 b=dk1BlsJlzvGnpRHCimyLMWJmXuZ4sNC5lEW/U3SDwbrfri95y6ciq3yKrzbeupWv/2
 TbB8Am/KOV8lxKukQvDiB/46fMZOz4HgUcvl8zzz9x2gEWl90SPLF+G1DyY20mp82Y7h
 h2zNVSkO8hCOJkKyJ/W/bVFUBcum4uDb2vB91y66n8TB4x6R3vRKcxQ/TcuxlZ80LaFc
 G9zsOkdzjhy2hBwwhV4O+Oi6x7+MBkbJgdttndDRziEfcJVxj9P7cPKs99Juce+v0lIU
 2+7x17908s/d+AAtPAJaKp0C7cP1NijMMibgSEuviBRhgRCbjADt5UMSF4bZ22lUo128
 dEqA==
X-Gm-Message-State: AOJu0YxXWtH+Xnox05wrIVZGAtb487VDTj4sNJ5B89oGmj4+2mLS6Uuo
 YxScS17hqULCY+/bqCoRnYvYuK2Edbn0+8P31l3fsA==
X-Google-Smtp-Source: AGHT+IGyeJDtemMqmpOpLJwrfKPH1LM4eG9sCWIS5KdCwzD7USAr/4qv6cRl4xvgMwmDfmdSvdKYqQ==
X-Received: by 2002:a0d:ca8e:0:b0:576:8d7f:d163 with SMTP id
 m136-20020a0dca8e000000b005768d7fd163mr22309317ywd.8.1693093802558; 
 Sat, 26 Aug 2023 16:50:02 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-cf2b-5e4e-16cb-5c6a.res6.spectrum.com.
 [2603:6081:7b00:6400:cf2b:5e4e:16cb:5c6a])
 by smtp.gmail.com with ESMTPSA id
 y130-20020a0dd688000000b005704c4d3579sm1316869ywd.40.2023.08.26.16.50.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Aug 2023 16:50:01 -0700 (PDT)
Date: Sat, 26 Aug 2023 19:50:00 -0400
From: Tom Rini <trini@konsulko.com>
To: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Fabio Estevam <festevam@gmail.com>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
 Stefan Agner <stefan.agner@toradex.com>,
 Stefano Babic <sbabic@denx.de>, u-boot@lists.denx.de
Subject: Re: [PATCH] mach-imx: bootaux: fix building with disabled bootelf
Message-ID: <20230826235000.GX3953269@bill-the-cat>
References: <20230826132410.378846-1-oleksandr.suvorov@foundries.io>
 <aa9044e9-62a6-4bf2-a390-eb6d3d5d9bf0@gmx.de>
 <CAOF=9Asr33iVjGANQTPLYurxJn+QjDXuNE09dN66bBuKc6SHFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Qss6fh3ahNwDjPhS"
Content-Disposition: inline
In-Reply-To: <CAOF=9Asr33iVjGANQTPLYurxJn+QjDXuNE09dN66bBuKc6SHFQ@mail.gmail.com>
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


--Qss6fh3ahNwDjPhS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 26, 2023 at 06:16:36PM +0300, Oleksandr Suvorov wrote:
> Hi Heinrich,
>=20
> On Sat, Aug 26, 2023 at 4:46=E2=80=AFPM Heinrich Schuchardt <xypron.glpk@=
gmx.de> wrote:
> >
> > On 8/26/23 15:24, Oleksandr Suvorov wrote:
> > > If CMD_ELF disabled and IMX_BOOTAUX enabled, the u-boot building ends
> > > up with a linking error [1]. Select LIB_ELF for all cases when
> > > valid_elf_image() is used in the imx_bootaux module.
> > >
> > > [1]
> > > ld: /tmp/ccaF1rpv.ltrans0.ltrans.o: in function `do_bootaux':
> > > arch/arm/mach-imx/imx_bootaux.c:108: undefined reference to `valid_el=
f_image'
> > >
> > > Fixes: c0f037f6a2a ("mach-imx: bootaux: elf firmware support")
> > > Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
> > > ---
> > >
> > >   arch/arm/mach-imx/Kconfig | 1 +
> > >   1 file changed, 1 insertion(+)
> > >
> > > diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> > > index d94b5828d0d..cbe62d6b8f9 100644
> > > --- a/arch/arm/mach-imx/Kconfig
> > > +++ b/arch/arm/mach-imx/Kconfig
> > > @@ -32,6 +32,7 @@ config IMX_RDC
> > >   config IMX_BOOTAUX
> > >       bool "Support boot auxiliary core"
> > >       depends on ARCH_MX7 || ARCH_MX6 || ARCH_VF610 || ARCH_IMX8 || A=
RCH_IMX8M
> > > +     select LIB_ELF if !ARCH_IMX8 || IMX8QXP
> >
> > For CONFIG_IMX8QXP=3Dy arch/arm/mach-imx/imx8/cpu.c uses valid_elf_imag=
e().
> >
> > Shouldn't the IMX8QXP case be handled in arch/arm/mach-imx/imx8/Kconfig?
> >
> > config IMX8QXP
> >         select LIB_ELF
>=20
> We need to select LIB_ELF for this SoC only if IMX_BOOTAUX is enabled:
> the arch/arm/mach-imx/imx8/cpu.c guards with #ifdef CONFIG_IMX_BOOTAUX
> functions that
> call lib/elf.o members.

And what about the rest of the platforms above?  There's certainly some
missing Kconfig enforcement of requirements, but I suspect it's wider
than just one set of SoC families for a long-standing feature.

--=20
Tom

--Qss6fh3ahNwDjPhS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTqj6cACgkQFHw5/5Y0
tyzL4AwAkSEj43pP+HLmRE6EELXG3jCRX/rlWyFGGZz1f3spAozLBp/ZTUGPF93o
M9756MjsgNH5HFQC6fHSYVrOmezztja/TUWKIfV0G5u9k9U1X0Xq6tUm/mcRd21L
SzFCWIA9OejrVHIErixAxYyZOIg4TQGqvgJ7lzp8saAsDsoD6L5rT4d2CzmukySo
zfzZpwizSngDjjOAV3t1W9gSnenRgUBmq/NhzbVmBiWqIjA2GxFdvpnpsSxuj0bj
a6yrA/z5qcLq4lddMxwTEnsaggEzn6arZJOPzVf4RJg7AlJYzHAGkwqYpNY4AF81
9B3TQ269wzhFIDyQdOT4WV5U8pgjbJ+8BYAWSRVc3++5hCJXrzBF7bzSVa4I/hPV
+cy5syHBcAOEkid8hp/M892MzKNoZVyZ37Ks3RDOOgMrNuBKvvrgWC5bfhPVY4x9
Efr0Zogv9ZbcnMcuPdTB2RdRY0Yqh/CXZj/OhJSvO0zx8IMLg7mSDbjljUVmmVwA
34QWhuAo
=YvM2
-----END PGP SIGNATURE-----

--Qss6fh3ahNwDjPhS--
