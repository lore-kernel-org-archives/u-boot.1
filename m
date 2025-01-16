Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19C11C02183
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 20:05:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D27380312;
	Thu, 16 Jan 2025 21:05:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Iix0iOuN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D2358033D; Thu, 16 Jan 2025 21:05:08 +0100 (CET)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3782D8022B
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 21:05:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-7b6ff72ba5aso116687785a.1
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 12:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737057905; x=1737662705; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QWO2n1SqMcxfwBTTCq7veHCE/Zd1bPhCFeJJNYNXSQM=;
 b=Iix0iOuNKUkjIowwchVohhAds742dq08ViZ222adE1JNX3rDba87YkrWsOPQ0W7Xh0
 ZHt6ybntVlgZWHMRyL9nHDy2Ay1xOwRZZOJSFiq7H34cCD8/NH8B0tSDs1Nx8kepVTTU
 achaFTRF3i2/RFFlE09CRvaT8HMx+HIBajHGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737057905; x=1737662705;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QWO2n1SqMcxfwBTTCq7veHCE/Zd1bPhCFeJJNYNXSQM=;
 b=bX8J5lqc4kei0ycJY1csmmFnkA9zBECv2EVobpaWCYlwZxoH9wT4/XIVDtpITfpxXW
 CwUGDwqWfauZIiFywWdNLOIlP11riMZiSUbSuxdii+NRaa5h8IL3VIHTwPxR20QaXn9d
 kKBOtDFTTtmtvrZ2+pfS7JFvo/I1P7dRFBJDS9IaLNu4KU/0PL+cs8psUIoSzpzema4Q
 oNrzTOSh6eRibpgTj7n/av3X+CbDO5+9djkJXPB6wJV3fK7AuRCdZ2W88r1r/dKbE3aa
 9Zy16V+ujDTVrhMqSdcyMKs8gtBmUZbBuKWdF8bRaYxcG3Aos7qBUqYKKxvZxM6GqJv6
 WkjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUs71KoVoOi0Et/VLBWRwN6OzyvwJPsIU4arYDH2rxQK1n54kJTqvtO/w4ckksSxDf76f9aeOQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyJrInFhFvJ7HDOptgDXLV9AfwNAUx4YYJH6N7uSjYit/2/OfpF
 x33dK/TRazHFG89cEguQUanu00/YqGksha1/nCsMSIyzKyIh/EVkFELpsj8mc2Q=
X-Gm-Gg: ASbGncvZ3PwlUVqkEIds4htBQLrUkYTTgaK4rrUot0WNA+dTyF9SuV8UzZyy7gwr+Gz
 hLYdr7jlaOqC5XE6CjIWdpHfKEoAv2YK0QDKygC2AnT391iu6mnmMsH4f6zyu0yU6j8MBPtbxZL
 inOEe7QgznPsnI0GimcpVPsKxJW1E96b5NJk2G3f0GcsAgcgC2Aaan2fJzdxMoyPZ/dlhGb7iWa
 AUUX6bYhO9zIZ5XAD49/C0N2BHqRnsgWhkGbhzkvJTdLfQ+YKvaqg==
X-Google-Smtp-Source: AGHT+IEZvl6pGYQprcRzQN083iOl8+uWl+k7hHiCrl6T9Za2xFmsX8JcxNcpxLwWeYS1T1WL+S5WIQ==
X-Received: by 2002:a05:620a:261c:b0:7b6:d327:cc47 with SMTP id
 af79cd13be357-7be63219ac8mr30258585a.8.1737057905062; 
 Thu, 16 Jan 2025 12:05:05 -0800 (PST)
Received: from bill-the-cat ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be614ef182sm36970485a.95.2025.01.16.12.05.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 12:05:04 -0800 (PST)
Date: Thu, 16 Jan 2025 14:05:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marex@denx.de>
Cc: Tim Harvey <tharvey@gateworks.com>, Alice Guo <alice.guo@oss.nxp.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, u-boot@lists.denx.de,
 Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>,
 Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v4 20/20] imx95_evk: add i.MX95 19x19 EVK board basic
 support
Message-ID: <20250116200500.GL3476@bill-the-cat>
References: <20250115-imx95-v1-0-93b28a514dea@oss.nxp.com>
 <20250115-imx95-v1-20-93b28a514dea@oss.nxp.com>
 <CAJ+vNU0_GWaVtwiWw3Mt1J6jc57XgDWOehdzrPhfTAg+gJq4oA@mail.gmail.com>
 <CAJ+vNU2QytTfGuHcnY8QfoLBvxCxcMP4fKqvPYaM8w_rX-czkA@mail.gmail.com>
 <788bf415-6110-4811-8a91-1949ad42252b@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="A2EicWBov1ebm3TJ"
Content-Disposition: inline
In-Reply-To: <788bf415-6110-4811-8a91-1949ad42252b@denx.de>
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


--A2EicWBov1ebm3TJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 09:03:35PM +0100, Marek Vasut wrote:
> On 1/16/25 8:42 PM, Tim Harvey wrote:
> > On Thu, Jan 16, 2025 at 11:38=E2=80=AFAM Tim Harvey <tharvey@gateworks.=
com> wrote:
> > >=20
> > > On Wed, Jan 15, 2025 at 5:30=E2=80=AFAM Alice Guo <alice.guo@oss.nxp.=
com> wrote:
> > > >=20
> > > > From: Ye Li <ye.li@nxp.com>
> > > >=20
> > > > This patch adds i.MX95 19x19 EVK board basic support.
> > > >=20
> > > > Messaging unit for EdgeLock Secure Enclave, messaging unit for Syst=
em
> > > > Manager, uSDHC for SD Card, gpio, lpuart are supported now.
> > > >=20
> > > > Signed-off-by: Ye Li <ye.li@nxp.com>
> > > > Signed-off-by: Alice Guo <alice.guo@nxp.com>
> > > > Reviewed-by: Peng Fan <peng.fan@nxp.com>
> > > > ---
> > > <snip...>
> > > > diff --git a/board/freescale/imx95_evk/imx95_evk.c b/board/freescal=
e/imx95_evk/imx95_evk.c
> > > > new file mode 100644
> > > > index 0000000000000000000000000000000000000000..1ed15ca47b157067a73=
76b0b32101dc7f9899f4f
> > > > --- /dev/null
> > > > +++ b/board/freescale/imx95_evk/imx95_evk.c
> > > > @@ -0,0 +1,54 @@
> > > > +// SPDX-License-Identifier: GPL-2.0+
> > > > +/*
> > > > + * Copyright 2025 NXP
> > > > + */
> > > > +
> > > > +#include <env.h>
> > > > +#include <init.h>
> > > > +#include <asm/global_data.h>
> > > > +#include <asm/arch-imx9/ccm_regs.h>
> > > > +#include <asm/arch/clock.h>
> > > > +#include <fdt_support.h>
> > > > +#include <asm/io.h>
> > > > +#include <linux/bitfield.h>
> > > > +#include <linux/bitops.h>
> > > > +#include <linux/delay.h>
> > > > +#include <miiphy.h>
> > > > +#include <netdev.h>
> > > > +#include <asm/gpio.h>
> > > > +#include <asm/mach-imx/sys_proto.h>
> > > > +#include <scmi_agent.h>
> > > > +#include <scmi_protocols.h>
> > > > +#include "../../../dts/upstream/src/arm64/freescale/imx95-clock.h"
> > > > +#include "../../../dts/upstream/src/arm64/freescale/imx95-power.h"
> > >=20
> > > Hi Alice,
> > >=20
> > > Most of the above are not needed (and should be alphabetized anyway)
> > >=20
> > > The only ones needed are:
> > > #include <asm/arch/clock.h>
> > > #include <asm/gpio.h>
> > > #include <asm/mach-imx/sys_proto.h>
> > >=20
> > > > +
> > > > +DECLARE_GLOBAL_DATA_PTR;
> > >=20
> > > not needed as you don't use gd
> > >=20
> > > Best Regards,
> > >=20
> > > Tim
> >=20
> > Hi Alic,
> >=20
> > One more thing to do for next series. Refresh your
> > imx95_19x19_evk_defconfig as its very out of sync:
> >=20
> > make imx95_19x19_evk_defconfig
> > make savedefconfig
> > cp defconfig configs/imx95_19x19_evk_defconfig
> And please enable CONFIG_FIT and CONFIG_FIT_VERBOSE .

Which should already be there if using bootstd to boot and not distro
boot scripts, another thing that should be done now and not later.

--=20
Tom

--A2EicWBov1ebm3TJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeJZmMACgkQFHw5/5Y0
tyxfWgv9GMQxNJtSX3OgMdzTdXFTpyweMBgz3M+awESSrVyKIou8xCrm53j8YzMr
pcufeLAyOH4s4yDv2IxHIK2aBcCFO0Yr0GFNcLn2go3mW/BGhTEFsTRblAwx2Blm
ixqounZv2Nq+9DIEpMYSfwku5dBnpVrx6rLv4Uigo6PcVW26yVv76RFWqIQnB0BK
P4Zi2eAYzJ/7kZd30+O2djJkowbD5XzXZsiRDt9GfQ/Ozfrez0/vRZayZveLVWhe
9yTjUILsmSr5OOti8GZrIwwxZECApueYdo1J11o4zo3TnsVyzu9W6lUaOP5TmyDC
u3lXDGxJfPUz1u/vt/wgjpeXviSRmcauS4hg04dvSHoyCrjg/MktV4LtSYS5XWLi
PocLPwcDywYD0J9fQlEHIS/MmK+rD6r7YwOt9m+qv0D7waORQrrNqk3lHpHayvKF
Iss2EX5/2/KD7SVaUEczgoafvPZwbnah5vuOClleZkrXUtn2pOYX/sdzvNMdeyxa
nSBOXZbP
=S8HH
-----END PGP SIGNATURE-----

--A2EicWBov1ebm3TJ--
