Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5717ED116F3
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 14:39:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72DAE83B22;
	Mon,  1 Dec 2025 15:39:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="U6guypuz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6817783B4E; Mon,  1 Dec 2025 15:39:10 +0100 (CET)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DC0883B03
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 15:39:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-656d9230cf2so2209046eaf.1
 for <u-boot@lists.denx.de>; Mon, 01 Dec 2025 06:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764599947; x=1765204747; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7ElB1hThv5PMcN3D6FirYRKPMN+vG//0FZN0ozsez/I=;
 b=U6guypuzM+YOx4ylhqLF34KAsLL1WSvUFWFULRSABS3MMZ44IRE3hIASaZ45J7/1I0
 NCJvTD4S/BEk8pIZgABDjl3pJeIh1wvOGtdjaygB+koQZWnAD0gu383oovXhp8VFenfr
 EkCyA+fMp2dYt74IPliPW62LpX/qRtTAtkiPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764599947; x=1765204747;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7ElB1hThv5PMcN3D6FirYRKPMN+vG//0FZN0ozsez/I=;
 b=mbpHi4JlqKhAZMZNUkLIM1HjQVL07KXweE7JROcrDQYxsyWUrpMtHSNthpRHWbpImF
 FCtfqd0c+n7fpzRjN2tgXawNuxyRKI70kmSO3mCCCtoyub38G73ZI0PgJlVkm5Sqxk5b
 H40k7BVlBDZwigIDOzPr3XKJuMKVpa+6FjXf/vi//wQptNPhVVjU8JtEsIC87UFJbhDr
 rTbLzwiDC0v/k/wh0n/T/2ThDrdzCYS/YX6wTv2bBLQkpuEPenV9iX3lyM1wEGVQRHfs
 LwOn+aO9JgBw9xLAAc2FQe+jXxphtWiKvn8eLtsaznDVfIS3KvnCofME2P7kpJlhS7LK
 rmew==
X-Forwarded-Encrypted: i=1;
 AJvYcCWye8Ud3wqyijHYfKR5IjPNtcyxSdiVAZZcfL/t5WyC/fzc3F6xWeR30pjLesmtLPIlGqpjl78=@lists.denx.de
X-Gm-Message-State: AOJu0YyB5uNY03V0jcc+t0YbKyNIqPvkEHpg1ytfrad0ZNHdBMw7DfsW
 tlHZtb4K1uVSs01H7JFTuLVxOOQLdJWCb4ovwKgMMTbndtolFTAbNSwbNToRH6HJRlg=
X-Gm-Gg: ASbGnct5Op39z/HkMx6hlz9vR/iE9azC9/bVeNUhUskZQOrMraVd4PICCul7RSloJpc
 YdRuBZPfUgYQwazJSJkOQoblju+J/IvMamQJVx8P+3usCBlcGrXFDaGPnt8hN4U4j/TLkbjoGAJ
 9GgZ7QJSOJR0ekN7QO1TKT55QZk+2JnrjXvvQmNbEFeuKIfkfNQbOhLYZ/SuAhF+H+ewxEoU/2Y
 jUxNryod28fW+3ZkkjvSI404GZBuZoPVQKtxPchB7n8Gxrs+0xcDR4gAIISK6ZPS1pfp4ktXVJB
 +SNnNB7iwzl3xb2GkERL8aIr3IQsPEE6E8tQL3SeP2WviKy58T+jPfqbWIRL7Afo/0upvu/DKPX
 ONOK+dCDXEE+4nunQZSWroYxb2p7jQals0LCzvHoQId2CNQfeqslSh26YN44uj8/5sH6snpy4yI
 SptanVcgDOgsZwZ/q8NtamEStCfGrOfXp0haHyPopbMAcdJ1jznA==
X-Google-Smtp-Source: AGHT+IH9AC/R0ecp4OXzYfufWnjJo3sijz5ub2mAGTcgDxTvso/GIXOM7uM9LNh4sKOWawj5tLBoHw==
X-Received: by 2002:a05:6820:4d41:20b0:657:6103:4929 with SMTP id
 006d021491bc7-6579255a14cmr11345778eaf.7.1764599946900; 
 Mon, 01 Dec 2025 06:39:06 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-659332ff598sm2556518eaf.8.2025.12.01.06.39.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 06:39:06 -0800 (PST)
Date: Mon, 1 Dec 2025 08:39:03 -0600
From: Tom Rini <trini@konsulko.com>
To: Joseph Guo <qijian.guo@nxp.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Ye Li <ye.li@nxp.com>,
 Alice Guo <alice.guo@nxp.com>, Adam Ford <aford173@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>,
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Subject: Re: [PATCH 2/2] imx: Support i.MX91 11x11 FRDM board
Message-ID: <20251201143903.GC303283@bill-the-cat>
References: <20251127-imx91_frdm-v1-0-8f42646d89ad@nxp.com>
 <20251127-imx91_frdm-v1-2-8f42646d89ad@nxp.com>
 <20251127141451.GV2125796@bill-the-cat>
 <aSz/0jfNn9A3pUmB@lsvm11u0000395.swis.ap-northeast-2.aws.nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4N0FiRaVkoh46JUt"
Content-Disposition: inline
In-Reply-To: <aSz/0jfNn9A3pUmB@lsvm11u0000395.swis.ap-northeast-2.aws.nxp.com>
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


--4N0FiRaVkoh46JUt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 01, 2025 at 11:39:14AM +0900, Joseph Guo wrote:
> On Thu, Nov 27, 2025 at 08:14:51AM -0600, Tom Rini wrote:
> > On Thu, Nov 27, 2025 at 06:54:58PM +0900, Joseph Guo wrote:
> > > Add i.MX91 11x11 EVK Board support.
> > >  - Four ddr scripts included w/o inline ecc feature. Support
> > >    both 1gb and 2gb DDR
> > >  - SDHC/EQOS/I2C/UART supported
> > >  - PCA9451 supported, default nominal drive mode
> > >  - Documentation added.
> > >=20
> > > Signed-off-by: Joseph Guo <qijian.guo@nxp.com>
> > > ---
> > >  arch/arm/dts/imx91-11x11-frdm-u-boot.dtsi          |  195 ++
> > >  arch/arm/mach-imx/imx9/Kconfig                     |    8 +
> > >  board/freescale/imx91_frdm/Kconfig                 |   19 +
> > >  board/freescale/imx91_frdm/MAINTAINERS             |    7 +
> > >  board/freescale/imx91_frdm/Makefile                |   16 +
> > >  board/freescale/imx91_frdm/imx91_frdm.c            |   28 +
> > >  board/freescale/imx91_frdm/imx91_frdm.env          |   88 +
> > >  .../imx91_frdm/lpddr4_2400mts_1gb_timing.c         | 1996 ++++++++++=
++++++++++
> > >  .../imx91_frdm/lpddr4_2400mts_2gb_timing.c         | 1996 ++++++++++=
++++++++++
> > >  .../imx91_frdm/lpddr4_2400mts_ecc_1gb_timing.c     | 1996 ++++++++++=
++++++++++
> > >  .../imx91_frdm/lpddr4_2400mts_ecc_2gb_timing.c     | 1996 ++++++++++=
++++++++++
> > >  board/freescale/imx91_frdm/lpddr4_timing.h         |   12 +
> > >  board/freescale/imx91_frdm/spl.c                   |  204 ++
> > >  configs/imx91_11x11_frdm_defconfig                 |  143 ++
> > >  configs/imx91_11x11_frdm_inline_ecc_defconfig      |  143 ++
> > >  doc/board/nxp/imx91_frdm.rst                       |   99 +
> > >  doc/board/nxp/index.rst                            |    1 +
> > >  include/configs/imx91_frdm.h                       |   25 +
> > >  18 files changed, 8972 insertions(+)
> > >=20
> > > diff --git a/arch/arm/dts/imx91-11x11-frdm-u-boot.dtsi b/arch/arm/dts=
/imx91-11x11-frdm-u-boot.dtsi
> > > new file mode 100644
> > > index 0000000000000000000000000000000000000000..7934ec89cfa58c1c033ba=
08ae7be826f5823bc1b
> > > --- /dev/null
> > > +++ b/arch/arm/dts/imx91-11x11-frdm-u-boot.dtsi
> > > @@ -0,0 +1,195 @@
> > > +// SPDX-License-Identifier: GPL-2.0+
> > > +/*
> > > + * Copyright 2025 NXP
> > > + */
> > > +
> > > +#include "imx91-u-boot.dtsi"
> > > +
> > > +/ {
> > > +	wdt-reboot {
> > > +		compatible =3D "wdt-reboot";
> > > +		wdt =3D <&wdog3>;
> > > +		bootph-pre-ram;
> > > +		bootph-some-ram;
> > > +	};
> > > +
> > > +	firmware {
> > > +		optee {
> > > +			compatible =3D "linaro,optee-tz";
> > > +			method =3D "smc";
> > > +		};
> > > +	};
> > > +};
> > > +
> > > +&{/soc@0} {
> > > +	bootph-all;
> > > +	bootph-pre-ram;
> > > +};
> >=20
> > These should be upstreamed and are not u-boot specific.
> >
>=20
> Hi Tom,
>=20
> Thanks for your comments.
>=20
> Can you please point out which node and why?
> optee and wdt are always u-boot specific. These nodes have
> never been put into upstream before.

I was referring to bootph-* as they have been in upstream schemas for
quite some time now.

--=20
Tom

--4N0FiRaVkoh46JUt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaS2ohAAKCRAr4qD1Cr/k
Ck0CAP42a16z/GgJ8F1M7kgQ664YDggbF1Xi3bYHsCl8gumR8QD+PaxrzaovvsI1
OlGnA9O1OtLe8eSirE/ne7hOJ/LhFA4=
=wZPy
-----END PGP SIGNATURE-----

--4N0FiRaVkoh46JUt--
