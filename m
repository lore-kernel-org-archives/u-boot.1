Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA36C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 16:37:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC5BE84A30;
	Tue,  7 Jul 2026 18:37:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fu3uIjl0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 179E184942; Tue,  7 Jul 2026 16:24:08 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 797508490A
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 16:24:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7e9f69ee6f4so3643756a34.2
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 07:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783434244; x=1784039044; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6GOBFFIHgIuq1uT7Z6ppC4jWOSsRSY5xlCxlfTSEQEI=;
 b=fu3uIjl079/XWRTCtjc0yupIcYZgg0wf2whwA+H72guUhPvHSgrUHoaVEhCEvYY0au
 q+UTm3dwvuHVCCMXVBvqOvGo8cjMZQyJ5WqFhU18RBPyk6juYsw41CmxrGLQwoOrf4yY
 YBqDMYK19KG4/fKVVpuHEgJVhqRIBkwRsdVIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783434244; x=1784039044;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6GOBFFIHgIuq1uT7Z6ppC4jWOSsRSY5xlCxlfTSEQEI=;
 b=gABf201+Zav8qfRxnsWIrCU8kOL5mbdBpHDCEbJXsg5y0uM1x6pcql55LVZhwG5Yo3
 2ynXLSjLl6kuejHiuE0EZC7cdHLGnvs0K5yBGkf3xoU7x0P7sdhsHBaf9HrMHu1NBnfW
 2iu8xr1b0iBmRgwTuvB7KmwxdmDK1UNF4cXcEFwfvSHyLqAiJKk+h+MYluJDNdEK9mBZ
 Asc5yTiSg8gOnMenjk3DXrR0GB5dgZORb1gny5LczUKK5f9wi2hVVzUXod84V0htNBzM
 m1/gv7Sxt7DE1Gm8o+ppaSrGTcew0QsXadwlNbS1RwfHFXjBFTigHUpyaynB5O97Tby9
 ibFQ==
X-Gm-Message-State: AOJu0Yw7gejXHiwuZTiJr53QYoIEGtV0qgpwTEgX+KjxURlYOnHWeA9M
 6kzheOF1FXLjc0jz3gbs+92991/FKpS/z4CnRj2QnwALU8I122Uf3zfAmPd0RT8ZASQ=
X-Gm-Gg: AfdE7cnAA16bVtCivQK/FpiHMvQJXw0davlr07FJaulEj700udGcjVIoJn6EL7oL53M
 Nm9Y72Rr6MWaMG6UhTUAKsfUJlva3HMkwigX7i8QhN37Wa/EFFb8STXVHAHFC8akJINv+JKeZM1
 v9V8qnNgUY35JLrR7ArZDt3MpuMjhLV4rRFQu8DczniqRCCfluLC9pH75EQs4Q00XJPtJ+/vlzj
 k5HjbL2ILEL7rNAaqZmvBzpFjC5EaCiJQXh9CY++M+Bj8Eij2BFljWhXI25L978l8K4VJYQkQ8g
 F+mr+rfTEKN5L/GCWwvOERJF4fGZjLRrYvXgFoWNr9VRYPazZG97KqCloNP461yYTcj9/zdYP2S
 6R3mLKod+7rDlIM/kjqBSBTsvyKfjKzeqyJ1hUYRPOH0/X54oDjjEvbw7LuhZxBrytwBZUJfbfv
 V81ydz5n4HmsVFezyZpsSxngRcr+1oZVPnEGJvlCfjEoxKzeUdJNjaJSni1IaWE/5sfRCInwnpy
 V1Mq7BYWCbLTsabsDA7jJzXQQpAGl1w4LH1ZA==
X-Received: by 2002:a05:6830:904:b0:7eb:3af8:8c1a with SMTP id
 46e09a7af769-7ebb21f1ad0mr3468146a34.9.1783434243945; 
 Tue, 07 Jul 2026 07:24:03 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7eb542d017csm14015086a34.8.2026.07.07.07.24.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 07:24:02 -0700 (PDT)
Date: Tue, 7 Jul 2026 08:23:59 -0600
From: Tom Rini <trini@konsulko.com>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: u-boot@lists.denx.de, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Lukasz Majewski <lukma@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Heiko Schocher <hs@nabladev.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Anshul Dalal <anshuld@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Andre Przywara <andre.przywara@arm.com>,
 Hrushikesh Salunke <h-salunke@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Justin Swartz <justin.swartz@risingedge.co.za>,
 Daniel Palmer <daniel@thingy.jp>, Andrew Davis <afd@ti.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Charkov <alchark@gmail.com>, Simon Glass <sjg@chromium.org>,
 Yao Zi <me@ziyao.cc>, Kory Maincent <kory.maincent@bootlin.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>,
 Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH v3 3/6] clk: ti: Remove AM33xx dependency
Message-ID: <20260707142359.GH749385@bill-the-cat>
References: <20260608-omap4-support-v3-0-8595ccd203f0@bootlin.com>
 <20260608-omap4-support-v3-3-8595ccd203f0@bootlin.com>
 <bcd09f47-a51a-4360-8164-2c2273d0237d@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TL1v8AqbzqGeRPEh"
Content-Disposition: inline
In-Reply-To: <bcd09f47-a51a-4360-8164-2c2273d0237d@bootlin.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Tue, 07 Jul 2026 18:37:14 +0200
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


--TL1v8AqbzqGeRPEh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 07, 2026 at 03:45:58PM +0200, Bastien Curutchet wrote:
> Hi Tom,
>=20
> On 6/8/26 3:11 PM, Bastien Curutchet wrote:
> > The clock controller driven by this driver exists on other OMAP platfor=
ms
> > than the AM33xx. Yet, it uses functions provided by
> > arch/arm/mach-omap2/am33xx/clock.c making it unusable by other OMAPs.
> >=20
> > Replace am33xx-specific do_{enable/disable}_clocks() with new static
> > functions implemented locally.
> > Replace the am33xx-specific clock header with the one shared by all OMAP
> > platforms.
> >=20
> > Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
> > ---
> >   drivers/clk/ti/clk-ctrl.c | 48 ++++++++++++++++++++++++++++++++++++--=
---------
> >   1 file changed, 37 insertions(+), 11 deletions(-)
> >=20
> > diff --git a/drivers/clk/ti/clk-ctrl.c b/drivers/clk/ti/clk-ctrl.c
> > index c5c97dc35c4..08f7410edce 100644
> > --- a/drivers/clk/ti/clk-ctrl.c
> > +++ b/drivers/clk/ti/clk-ctrl.c
> > @@ -8,7 +8,11 @@
> >   #include <dm.h>
> >   #include <dm/device_compat.h>
> >   #include <clk-uclass.h>
> > -#include <asm/arch-am33xx/clock.h>
> > +#include <asm/ti-common/omap_clock.h>
> > +#include <asm/io.h>
> > +#include <linux/iopoll.h>
> > +
> > +#define TRANSITION_TIMEOUT_US	10000
> >   struct clk_ti_ctrl_offs {
> >   	fdt_addr_t start;
> > @@ -33,10 +37,37 @@ static int clk_ti_ctrl_check_offs(struct clk *clk, =
fdt_addr_t offs)
> >   	return -EFAULT;
> >   }
> > +#define IDLEST_DISABLED		(MODULE_CLKCTRL_IDLEST_DISABLED << MODULE_CLK=
CTRL_IDLEST_SHIFT)
> > +#define IDLEST_TRANSITION	(MODULE_CLKCTRL_IDLEST_TRANSITIONING << MODU=
LE_CLKCTRL_IDLEST_SHIFT)
> > +static int clk_ti_ctrl_disable_clock_module(u32 addr)
> > +{
> > +	int val;
> > +
> > +	clrsetbits_le32(addr, MODULE_CLKCTRL_MODULEMODE_MASK,
> > +			MODULE_CLKCTRL_MODULEMODE_SW_DISABLE <<
> > +			MODULE_CLKCTRL_MODULEMODE_SHIFT);
> > +
> > +	return readl_relaxed_poll_timeout(addr, val,
> > +					  (val & MODULE_CLKCTRL_IDLEST_MASK) =3D=3D IDLEST_DISABLED,
> > +					  TRANSITION_TIMEOUT_US);
> > +}
> > +
> > +static int clk_ti_ctrl_enable_clock_module(u32 addr)
> > +{
> > +	int val;
> > +
> > +	clrsetbits_le32(addr, MODULE_CLKCTRL_MODULEMODE_MASK,
> > +			MODULE_CLKCTRL_MODULEMODE_SW_EXPLICIT_EN <<
> > +			MODULE_CLKCTRL_MODULEMODE_SHIFT);
> > +	return readl_relaxed_poll_timeout(addr, val,
> > +					  ((val & MODULE_CLKCTRL_IDLEST_MASK) !=3D IDLEST_DISABLED) &&
> > +					  ((val & MODULE_CLKCTRL_IDLEST_MASK) !=3D IDLEST_TRANSITION),
> > +					  TRANSITION_TIMEOUT_US);
>=20
> This is the culprit. In arch/arm/mach-omap2/am333x/clock.c, the timeout is
> computed using CPU ticks. Here, readl_relaxed_poll_timeout() relies on a
> timer. On the beaglebone, this timer dependency creates a sort of circular
> dependency during initialization (enable clock -> init timer -> enable cl=
ock
> -> init timer) which leads to a division-by-0 during the second timer
> initialization. This division triggers the hang() outputting the "### ERR=
OR
> ### Please RESET the board ###".
>=20
> I'm going to send a new series for the OMAP4 support that uses a CPU-based
> loop in this driver instead of readl_relaxed_poll_timeout().

Thanks for digging. Please note that this was in the next branch and so
is in master now, so just a fixup on top is needed.

--=20
Tom

--TL1v8AqbzqGeRPEh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCak0L9AAKCRAr4qD1Cr/k
CqRpAP0TeyDSFMPwAwLAzeBc6/fofezrsGHEBCcy/qnzLjiyYwEAoG2ibFQZ/21l
fR0n2uiP/EqSDZBay4+C1fsaGERypAw=
=9Bv5
-----END PGP SIGNATURE-----

--TL1v8AqbzqGeRPEh--
