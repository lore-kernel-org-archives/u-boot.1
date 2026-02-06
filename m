Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F91EE20A7
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 13:56:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CED5836D3;
	Fri,  6 Feb 2026 14:56:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uogV4g9Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5113F83A64; Fri,  6 Feb 2026 14:56:27 +0100 (CET)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28CED8352B
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 14:56:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-45c8b850f96so469899b6e.0
 for <u-boot@lists.denx.de>; Fri, 06 Feb 2026 05:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770386184; x=1770990984; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Oda+2QMmfaPXy6sjO9eQzTDF5vgQbVSziVzFEJNKfbo=;
 b=uogV4g9Qf/UbInZk7QHXkw6/o2OOKJEiECyTsGA/N6Vak8Y9M1yeQ1nwlNBPM8BZDt
 a2bLrEdk3HBl1mDfpdfOJpLgPySVIXNFmzILtczH4lFiuR8M33Xn5XM8w7zHbZinztP3
 VDVIis9l/2IMUMTOj0O2IMn1CNchN7U7PY/04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770386184; x=1770990984;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Oda+2QMmfaPXy6sjO9eQzTDF5vgQbVSziVzFEJNKfbo=;
 b=Tk62rlgJ8KHNrkHjLau+Ha3zJXgbymhfnQs9z1wAsmCn4qLHsIljbVvAFe2xfWcRlU
 wKXiSsd6sA1bYN8132rruG4DK2+hiBECHZxVn7WQcm3c7rAGoNufC1oO89sS46YzNaCz
 fxqG2eBbferTh9lxASfzpymZPR1zstMFOYX+Rv17HtHcjeOJEQyIR3OrPj8v2yxc4fxB
 hOx9Tky8NA1wNoz9O9CGRSoBcMe8Dtck//V2bvAFj/xSqHAQwh9FfvVg5sKoW8rP3Cgc
 HBpAaaiMfUfrL+gGUhY3phI42jkje9gWmQ8X6T0l/EY7XiP4cANrZ+TU/D13/r/2wwch
 doGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYtENzI7TLphNq2Hs8YRgFfMtu3EJs46vwBTQvkVhwaeaKQJiUZTbXeBY0KXeyg0lFYuz0448=@lists.denx.de
X-Gm-Message-State: AOJu0YwAEy00+jR5wnmWHoyzM2eCcWu1l6/te5PglS2qUxLdWS69wWJX
 Hc2U+QtHldQyAh679CVPEzktT6ywSYJKlhdKWdwgvbs3lIM/QdWnCO/188jIFy5n1XY=
X-Gm-Gg: AZuq6aLafKVv3MNrWTfmLDBfVDullyXLFU9w59IeJuCf1vFn1SPIehsRCAdxS7FXHDb
 YWWNfEjqGgN3l1fPO1H2+1uCR7BBFG+smtYt/upGyQ8qZesNyvX8G2mBGYIH5TzWmNe8AdJFN49
 9Y0VKWGZS6XVj/F8XolyHB1zsXbF/vyV0I4M7chI+vN+/bxzn7E95TiRjBol1gpPDOKLr2CzspT
 mCLXnLSxqI6RuWGQ07nDRVjmLDn0armanEmmvmMLLPhsFZUUF7j2YJnH/bIXUp/eDWgmPosORyN
 RdDCTbwVOM57bGcQqzCd0h763XJhzQXRDMQFvphJQSRgtpUZp9zzAi4e2KUNKkS/vrIbvUOThWL
 W6VHQszhWi0ZP04qmcW8GBOKjW7+jIhBKZWAcjvTAA++/EZ/to7j9VJAkS4IsGjtZX5oZXD3fmB
 MeONwTJFNQXun5iNYv+uk0kiW2mQJmz2WJgmgsRWZfSMlG/g2bMk0JTROVGoYjoWKNAzohVcd8X
 HjhzVIFg8JAkVsNspcvIh0jkw2wEMP62ksI+lE=
X-Received: by 2002:a05:6820:488c:b0:663:bad:972d with SMTP id
 006d021491bc7-66d0cb3cb2bmr1055519eaf.63.1770386183691; 
 Fri, 06 Feb 2026 05:56:23 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-66d38bdeed5sm1183825eaf.4.2026.02.06.05.56.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 05:56:22 -0800 (PST)
Date: Fri, 6 Feb 2026 07:56:20 -0600
From: Tom Rini <trini@konsulko.com>
To: Julien Stephan <jstephan@baylibre.com>
Cc: David Lechner <dlechner@baylibre.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 5/5] arm: mediatek: consolidate ARMv8 memory maps
Message-ID: <20260206135620.GQ2603314@bill-the-cat>
References: <20260205-mtk-mach-clean-up-duplicates-v1-0-b7d4a43c18eb@baylibre.com>
 <20260205-mtk-mach-clean-up-duplicates-v1-5-b7d4a43c18eb@baylibre.com>
 <CAEHHSvasBSDP8S+v5qbiAgJdNH9bvLcogi3oh8FJMgpfQ9VAOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZP6jimLNgp2DnVIS"
Content-Disposition: inline
In-Reply-To: <CAEHHSvasBSDP8S+v5qbiAgJdNH9bvLcogi3oh8FJMgpfQ9VAOg@mail.gmail.com>
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


--ZP6jimLNgp2DnVIS
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 06, 2026 at 11:07:14AM +0100, Julien Stephan wrote:
> Le ven. 6 f=E9vr. 2026 =E0 00:52, David Lechner <dlechner@baylibre.com> a=
 =E9crit :
> >
> > Consolidate all mem_map definitions for MediaTek ARMv8 platforms into a
> > single file. The size of the DDR and MMIO regions can vary, so Kconfig
> > options are added to configure them by target.
> >
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > ---
> >  arch/arm/mach-mediatek/Kconfig                     | 21 ++++++++++++++=
++
> >  arch/arm/mach-mediatek/Makefile                    |  1 +
> >  .../arm/mach-mediatek/armv8-mem-map.c              | 14 ++++-------
> >  arch/arm/mach-mediatek/mt7622/init.c               | 20 ---------------
> >  arch/arm/mach-mediatek/mt7981/init.c               | 21 --------------=
--
> >  arch/arm/mach-mediatek/mt7986/init.c               | 21 --------------=
--
> >  arch/arm/mach-mediatek/mt7987/init.c               | 21 --------------=
--
> >  arch/arm/mach-mediatek/mt7988/init.c               | 21 --------------=
--
> >  arch/arm/mach-mediatek/mt8183/init.c               | 20 ---------------
> >  arch/arm/mach-mediatek/mt8512/init.c               | 21 --------------=
--
> >  arch/arm/mach-mediatek/mt8516/init.c               | 20 ---------------
> >  arch/arm/mach-mediatek/mt8518/init.c               | 21 --------------=
--
> >  board/mediatek/mt8365_evk/MAINTAINERS              |  5 ----
> >  board/mediatek/mt8365_evk/Makefile                 |  3 ---
> >  board/mediatek/mt8390_evk/MAINTAINERS              |  6 -----
> >  board/mediatek/mt8390_evk/Makefile                 |  3 ---
> >  board/mediatek/mt8390_evk/mt8390_evk.c             | 29 --------------=
--------
> >  17 files changed, 27 insertions(+), 241 deletions(-)
[snip]
> > -struct mm_region *mem_map =3D mt8518_mem_map;
> > diff --git a/board/mediatek/mt8365_evk/MAINTAINERS b/board/mediatek/mt8=
365_evk/MAINTAINERS
> > deleted file mode 100644
> > index e0d65efe812..00000000000
> > --- a/board/mediatek/mt8365_evk/MAINTAINERS
> > +++ /dev/null
>=20
> Hi David,
>=20
> You are removing board/mediatek/mt8365_evk directory (and mt8390_evk
> below), so you left mt8365_evk_defconfig (and mt8365_evk_defconfig)
> without any entries in MAINTAINERS files.
> So maybe we should add them to the MAINTAINERS file at the root directory?

defconfigs without MAINTAINERS entries will fail CI (and you can do this
locally with tools/buildman/buildman --maintainer-check). We should just
create board/mediatek/MAINTAINERS or arch/arm/mach-mediatek/MAINTAINERS.

--=20
Tom

--ZP6jimLNgp2DnVIS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaYXzAAAKCRAr4qD1Cr/k
Cp2DAQDzyWx88f6DQtvUaD34vOJ6n+luZSDi35VU7//A1X5pEwD/TMQAQHTUNt/P
Jp3lehdp9BkEiYQ2+1abPc5I4dNzIQw=
=WyaU
-----END PGP SIGNATURE-----

--ZP6jimLNgp2DnVIS--
