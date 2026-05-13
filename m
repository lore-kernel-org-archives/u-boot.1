Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC21FCD4F3D
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 13:56:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50F85836AC;
	Wed, 13 May 2026 15:56:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="l60KocdR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0501483FB0; Wed, 13 May 2026 15:56:14 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5E3A8341A
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 15:56:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7de4e6c5a30so7290784a34.0
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 06:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778680570; x=1779285370; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AsKbcgGqzCbAga9VF/eW6HLesYFy6rb++ULDupN4e4o=;
 b=l60KocdRLN+YXU9u8WRadIeTmJDvs3rqvqBTSs/8nmou34t4SO6Z703rC9o2wYyZn8
 NtUbIpftDD9tgVrPQzVQ0vIaySG4mF1RV5Y+t+DUytDqhlTU4er+qsMZPNTL//qIe4ml
 OrsFMlZ5jHBMDVZfrmgOI3PeCUkewsYLhm6NA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778680570; x=1779285370;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AsKbcgGqzCbAga9VF/eW6HLesYFy6rb++ULDupN4e4o=;
 b=R2xpHvXz8/Uwa2AZB9q6BvKaN42bU1HTFcgbzcbyTntuvIom4rP6HPnSZHLSgC4nEz
 TbfJfcHDY5j3Fl2pvxPNeMeWzLBoBHVCQ/pXHaii+GhUXUlLDq5kZ5qlQawxV3s+DhbA
 6S+lPc2ANCF5YuoW7v2m8bFnA9KBueobdNFHRaqhPLJyZMnbUNf2HruVf+1QmUbSX985
 l7acDO0MRC5xUJOJWuSSpoOSHKxE0PIdfg+k42NudrScl71k0muWkoA+j8kWvBxmvBc+
 An/Zq7Qyt+rLigU8jv3R5LOije0z6UAsew9hbYQW76BTv+JLrJqIdIFjtbrLfniH9a+G
 iLUA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/mlftwTOyjKhLzUyehetmKkOh0SYe/nWVdbUmTmktr5DzZN0y7xwmjxvtrZtBugm4EkLz+vxM=@lists.denx.de
X-Gm-Message-State: AOJu0YwzJYx+7ZBSQ/prOugKJLLUkGP7RVhi+uUYHh1x0+YR5CV3J07+
 zAYUAzMtbcrs41+6nnIQFAbcOe/kh7nQQBlcM3HGN47xcugNQpzeOC/l7Zgh/apl4Lk=
X-Gm-Gg: Acq92OHAlQ/tew4s517eGqghcanAJf8bmCtM379/qnRCSm3FIpyxYSdXJ6IlAHNYdLv
 E4rPmCAYHTK/ELHXS45LdgcD2FvTjR9oZH/tQJLHB8cjnMf40kegdEz1SE3wayBtdVuNnU3MkoR
 4qFVmrwcq1rbw8YWrNimxEMxmlGrxWTbHUKIKA55IKNZhkU8Jmxcjnhv2IgPD8vQehnhNOq8k7B
 1uuFb3Q1S5Z0WZ1EF2DE2vDfBxzeDysdgfw/QcovsB1RovIOlwBWhmoyqSCOwOgwvAlMN8ro51j
 Yd+Qw4cMsLWvElgM1KWDIVDhvSQDx81jWnvCWkgI6pFmQRcX0/wpJuzMORx0ULhJ0Rl1ltMw2ry
 D5XXIcKQfzXJZHA1XDCIRcaIpv9l0x7uqm7RCzW9teuCFqm1vPM3tRKbLg/nJqlkC67n0mqypHv
 beOYzSiJYurXa4crUD6+m4VwzrP6lIX5lX7p/eDUoVpXzEydb6ZFQIUdSP8WO08qLFUw5iqD3bX
 UzxX7yuVLWerwt7q2RNbPt5xdirPoDJkn1v3W1XKbPWMBXIAdJ6FOUuC1RXog==
X-Received: by 2002:a05:6830:618d:b0:7dd:f615:a84e with SMTP id
 46e09a7af769-7e3dc882950mr1534367a34.18.1778680570558; 
 Wed, 13 May 2026 06:56:10 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367dfb66csm11040846a34.27.2026.05.13.06.56.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 06:56:09 -0700 (PDT)
Date: Wed, 13 May 2026 07:56:06 -0600
From: Tom Rini <trini@konsulko.com>
To: Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: David Lechner <dlechner@baylibre.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Christian Marangi <ansuelsmth@gmail.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peng Fan <peng.fan@nxp.com>, Anis Chali <chalianis1@gmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Yao Zi <me@ziyao.cc>,
 Sean Anderson <sean.anderson@linux.dev>,
 Michal Simek <michal.simek@amd.com>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>
Subject: Re: [PATCH v5 06/11] pinctrl: airoha: add pin controller and gpio
 driver for AN7581 SoC
Message-ID: <20260513135606.GS1858239@bill-the-cat>
References: <20260509111157.4039434-1-mikhail.kshevetskiy@iopsys.eu>
 <20260509111157.4039434-7-mikhail.kshevetskiy@iopsys.eu>
 <fd91e95b-d45b-4fdf-807d-54f87a19b26a@baylibre.com>
 <633941db-10eb-49ad-a2dd-a81a71e6b6c9@genexis.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TPO/U4YnyVcRv1hb"
Content-Disposition: inline
In-Reply-To: <633941db-10eb-49ad-a2dd-a81a71e6b6c9@genexis.eu>
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


--TPO/U4YnyVcRv1hb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 01:30:47PM +0200, Benjamin Larsson wrote:
> Hi.
>=20
> On 13/05/2026 01:42, David Lechner wrote:
> > On 5/9/26 6:11 AM, Mikhail Kshevetskiy wrote:
> > > This patch adds U-Boot pin controller and gpio driver for Airoha AN75=
81 SoC.
> > >=20
> > > Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> > > ---
> > >   drivers/pinctrl/airoha/Kconfig          |    5 +
> > >   drivers/pinctrl/airoha/Makefile         |    2 +
> > >   drivers/pinctrl/airoha/pinctrl-an7581.c | 1076 ++++++++++++++++++++=
+++
> > >   3 files changed, 1083 insertions(+)
> > >   create mode 100644 drivers/pinctrl/airoha/pinctrl-an7581.c
> > >=20
> > > diff --git a/drivers/pinctrl/airoha/Kconfig b/drivers/pinctrl/airoha/=
Kconfig
> > > index eb87afbb374..986d23c2e3d 100644
> > > --- a/drivers/pinctrl/airoha/Kconfig
> > > +++ b/drivers/pinctrl/airoha/Kconfig
> > > @@ -9,3 +9,8 @@ config PINCTRL_AIROHA
> > >   	select REGMAP
> > >   	select SYSCON
> > >   	bool
> > > +
> > > +config PINCTRL_AIROHA_AN7581
> > > +	tristate "AN7581 pin controller and gpio driver"
> > > +	depends on TARGET_AN7581
> > > +	select PINCTRL_AIROHA
> > > diff --git a/drivers/pinctrl/airoha/Makefile b/drivers/pinctrl/airoha=
/Makefile
> > > index a25b744dd7a..909bd9a04d9 100644
> > > --- a/drivers/pinctrl/airoha/Makefile
> > > +++ b/drivers/pinctrl/airoha/Makefile
> > > @@ -1,3 +1,5 @@
> > >   # SPDX-License-Identifier: GPL-2.0
> > >   obj-$(CONFIG_PINCTRL_AIROHA)		+=3D pinctrl-airoha.o
> > > +
> > > +obj-$(CONFIG_PINCTRL_AIROHA_AN7581)	+=3D pinctrl-an7581.o
> > > diff --git a/drivers/pinctrl/airoha/pinctrl-an7581.c b/drivers/pinctr=
l/airoha/pinctrl-an7581.c
> > > new file mode 100644
> > > index 00000000000..606e042b069
> > > --- /dev/null
> > > +++ b/drivers/pinctrl/airoha/pinctrl-an7581.c
> > > @@ -0,0 +1,1076 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * Author: Lorenzo Bianconi <lorenzo@kernel.org>
> > > + * Author: Benjamin Larsson <benjamin.larsson@genexis.eu>
> > > + * Author: Markus Gothe <markus.gothe@genexis.eu>
> > > + */
> > > +#include "airoha-common.h"
> > > +
> > It still throws me off that the en7581_ prefix is not the same
> > as the file name/driver name/config symbol name. If en7581
> > is preferred, can we change everything (an7581) to match?
>=20
> The physical chip is marked AN7581 but I have seen some old EN7581 uses in
> Airoha(Econet) material. I'm not really happy with this situation but for
> some reason the en7581 name has been pushed for this SoC in mainline kern=
el
> code.
>=20
> Ideally linux and uboot should use the same naming but I'm fine with
> whatever gets code landing upstream.

I agree consistent naming with the linux kernel is important here.

--=20
Tom

--TPO/U4YnyVcRv1hb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCagSC8wAKCRAr4qD1Cr/k
Cla1AQClM5czO7uDJ4CEN19IVv4FaW1tV2cEA9boGdGIDceEFQEA9gfmYQw6xljZ
CSY606/Yracwo1u6+/W5XjZz61bBeQo=
=3uGA
-----END PGP SIGNATURE-----

--TPO/U4YnyVcRv1hb--
