Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8922CC83F17
	for <u-boot@archiver.kernel.org>; Wed, 23 Jul 2025 10:15:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C859A82BF6;
	Wed, 23 Jul 2025 12:15:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ThSakw/5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 965D482B0F; Wed, 23 Jul 2025 12:15:49 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6138C82B07
 for <u-boot@lists.denx.de>; Wed, 23 Jul 2025 12:15:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56NAFTsc1699161;
 Wed, 23 Jul 2025 05:15:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1753265729;
 bh=IhXFEI5OwV7gblWQ5241NVApkSBGxPOIY3t4M6OUHaQ=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=ThSakw/5H9pJFiFhvxZ6f4rL0imZ4Mk16UbrWM0iprgi3g0qIGdB5adCpUygRq+5e
 AxVDtNJl79HQSrba2tIE5RVuEgX7NYXDwi2xAtsH9bWIv24wlMxzrNbG8XICjl+kCH
 FoHn2hdBnofpinRK1CSCFM1jMCaMSS6GYOYJQZwQ=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56NAFS8f2296261
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 23 Jul 2025 05:15:28 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 23
 Jul 2025 05:15:28 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 23 Jul 2025 05:15:27 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.169])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56NAFQG62824618;
 Wed, 23 Jul 2025 05:15:27 -0500
Date: Wed, 23 Jul 2025 15:45:26 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <trini@konsulko.com>,
 <sjg@chromium.org>, <joe.hershberger@ni.com>, <rfried.dev@gmail.com>,
 <michal.simek@amd.com>, <marek.vasut+renesas@mailbox.org>,
 <marek.vasut@mailbox.org>, <dsimic@manjaro.org>,
 <jerome.forissier@linaro.org>, <kever.yang@rock-chips.com>,
 <alexthreed@gmail.com>, <ilias.apalodimas@linaro.org>,
 <pbrobinson@gmail.com>, <paul.barker.ct@bp.renesas.com>,
 <lucienzx159@gmail.com>, <skylake.huang@mediatek.com>,
 <u-boot@lists.denx.de>, <u-kumar1@ti.com>, <praneeth@ti.com>,
 <nm@ti.com>, <srk@ti.com>
Subject: Re: [PATCH v2] net: phy: Support overriding Auto Negotiation timeout
 with env variable
Message-ID: <4814febe-bc65-4fe0-926b-dcb94135cf9d@ti.com>
References: <20250723062642.634345-1-s-vadapalli@ti.com>
 <c2c4887b-aeb0-4880-8241-058ef26552fd@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c2c4887b-aeb0-4880-8241-058ef26552fd@cherry.de>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

On Wed, Jul 23, 2025 at 11:25:50AM +0200, Quentin Schulz wrote:
> Hi Siddharth,
> 
> On 7/23/25 8:26 AM, Siddharth Vadapalli wrote:
> > The Auto Negotiation procedure between two Ethernet PHYs consists of
> > determining the best commonly supported parameters among Speed,
> > Duplex Mode and Flow Control.
> > 
> > The time taken for this procedure is not only dependent on the local
> > PHY used, but also on the link-partner PHY.
> > 
> > While a timeout can be specified in the form of a "CONFIG" on the basis
> > of the local PHY present on the device, since the timeout also depends
> > on the link-partner PHY, it might be necessary to modify the timeout.
> > 
> > To avoid rebuilding the bootloader for a given device, just because it
> > may be connected to various link-partner PHYs, each with a different
> > timeout, introduce an environment variable named "phy_aneg_timeout" and
> > override "CONFIG_PHY_ANEG_TIMEOUT" with "phy_aneg_timeout".
> > 
> > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > ---
> > 
> > Hello,
> > 
> > This patch is based on commit
> > 7598b469c16 Merge tag 'u-boot-dfu-next-20250703' of https://source.denx.de/u-boot/custodians/u-boot-dfu into next
> > of the next branch of Mainline U-Boot.
> > 
> 
> Between the release and -rc2 (excluded), please use master branch and not
> next as your base, see
> https://docs.u-boot.org/en/latest/develop/release_cycle.html

Thank you for pointing it out. I will base the patch on master.

> 
> > v1 of this patch is at:
> > https://patchwork.ozlabs.org/project/uboot/patch/20250722060554.352952-1-s-vadapalli@ti.com/
> > Changes since v1:
> > - Switched to env_get_ulong() based on feedback from Marek Vasut at:
> >    https://patchwork.ozlabs.org/project/uboot/patch/20250722060554.352952-1-s-vadapalli@ti.com/#3550426
> > - Addressed feedback from Quentin Schulz at:
> >    https://patchwork.ozlabs.org/project/uboot/patch/20250722060554.352952-1-s-vadapalli@ti.com/#3550263
> >    by performing the following changes:
> >    1) Updated drivers/net/phy/Kconfig by documenting that phy_aneg_timeout
> >       env variable can override the value of CONFIG_PHY_ANEG_TIMEOUT
> >    2) Updated doc/usage/environment.rst by documenting the base and unit
> >       of phy_aneg_timeout
> >    3) Updated drivers/net/phy/aquantia.c and drivers/net/xilinx_axi_emac.c
> >       to support overriding CONFIG_PHY_ANEG_TIMEOUT with phy_aneg_timeout
> > 
> > Patch has been tested on J784S4-EVM validating the following cases:
> > 1. PHY Auto-Negotiation performed with "phy_aneg_timeout" unset.
> >     CONFIG_PHY_TIMEOUT with a value of 4,000 takes effect.
> >     => Auto Negotiation succeeds
> > 2. PHY Auto-Negotiation performed with "phy_aneg_timeout" set to 20,000.
> >     "phy_aneg_timeout" overrides CONFIG_PHY_TIMEOUT.
> >     [Higher value than default specified by CONFIG_PHY_ANEG_TIMEOUT]
> >     => Auto Negotiation succeeds
> > 3. PHY Auto-Negotiation performed with "phy_aneg_timeout" set to 200.
> >     "phy_aneg_timeout" overrides CONFIG_PHY_TIMEOUT.
> >     [Lower value than default specified by CONFIG_PHY_ANEG_TIMEOUT]
> >     => Auto Negotiation times out
> > 
> > Test Logs:
> > https://gist.github.com/Siddharth-Vadapalli-at-TI/3e9cbdfedc541032768b14c15244f590
> > 
> > Regards,
> > Siddharth.
> > 
> >   doc/usage/environment.rst     | 9 +++++++++
> >   drivers/net/phy/Kconfig       | 4 +++-
> >   drivers/net/phy/aquantia.c    | 8 +++++---
> >   drivers/net/phy/phy.c         | 7 +++++--
> >   drivers/net/xilinx_axi_emac.c | 7 +++++--
> >   5 files changed, 27 insertions(+), 8 deletions(-)
> > 
> > diff --git a/doc/usage/environment.rst b/doc/usage/environment.rst
> > index bb6c351b441..b48c11faffa 100644
> > --- a/doc/usage/environment.rst
> > +++ b/doc/usage/environment.rst
> > @@ -335,6 +335,15 @@ netretry
> >       Useful on scripts which control the retry operation
> >       themselves.
> > +phy_aneg_timeout
> > +    If set, the specified value will override CONFIG_PHY_ANEG_TIMEOUT
> > +    which defaults to 4000 (decimal) millisecond. This variable has
> 
> Please do not specify the default here, it may be different per board and
> this would then be misleading.

I was referring to the default specified in the Kconfig for
config PHY_ANEG_TIMEOUT
But I understand that it may be interpret in the context of the board.

> 
> > +    the same base and unit as CONFIG_PHY_ANEG_TIMEOUT.
> 
> +that is, decimal and milliseconds.

Ok.

> 
> > +    The default value of CONFIG_PHY_ANEG_TIMEOUT may be sufficient for
> > +    most use-cases, but certain link-partners may require a larger
> > +    timeout due to the Ethernet PHY they use. Alternatively, the timeout
> > +    can be reduced as well if the use-case demands it.
> > +
> >   rng_seed_size
> >       Size of random value added to device-tree node /chosen/rng-seed.
> >       This variable is given as a decimal number.
> > diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
> > index 3132718e4f8..7fa1a89fca4 100644
> > --- a/drivers/net/phy/Kconfig
> > +++ b/drivers/net/phy/Kconfig
> > @@ -23,7 +23,9 @@ config PHY_ANEG_TIMEOUT
> >   	int "PHY auto-negotiation timeout"
> >   	default 4000
> >   	help
> > -	  Default PHY auto-negotiation timeout.
> > +	  Default PHY auto-negotiation timeout in millisecond (decimal).
> 
> Not a native, but my gut says it should be "in milliseconds".

https://physics.nist.gov/cuu/Units/checklist.html
"Unit symbols are unaltered in the plural."

	proper:
		l = 75 cm
	improper:
		l = 75 cms

> 
> > +	  This can be overridden by the phy_aneg_timeout environment
> > +	  variable that has the same base and unit.
> >   if PHY_ADDR_ENABLE
> >   config PHY_ADDR
> > diff --git a/drivers/net/phy/aquantia.c b/drivers/net/phy/aquantia.c
> > index d2db8d9f792..72f29824468 100644
> > --- a/drivers/net/phy/aquantia.c
> > +++ b/drivers/net/phy/aquantia.c
> > @@ -552,13 +552,15 @@ int aquantia_config(struct phy_device *phydev)
> >   int aquantia_startup(struct phy_device *phydev)
> >   {
> >   	u32 speed;
> > -	int i = 0;
> > +	ulong i = 0;
> >   	int reg;
> >   	phydev->duplex = DUPLEX_FULL;
> >   	/* if the AN is still in progress, wait till timeout. */
> >   	if (!aquantia_link_is_up(phydev)) {
> > +		ulong aneg_timeout = env_get_ulong("phy_aneg_timeout", 10,
> > +						   CONFIG_PHY_ANEG_TIMEOUT);
> 
> Considering phy_aneg_timeout stores a value in milliseconds, I believe a u32
> is plenty enough as that would mean 4294967295 milliseconds max which is
> almost 50 days, I think that's enough for a timeout :)
> 
> Up to you on the type of the variable but ulong seems overkill (it is what
> env_get_ulong will return but we don't need more). Since this comes from the
> user at runtime, I would suggest to *not* take a signed type so that a type
> overflow is defined behavior (it wraps and is minimally 0).
> 
> Same remark for other drivers. ulong is fine as is, just taking a lot of
> space in memory for no benefit.

I used ulong since "env_get_ulong" returns ulong. I will use u32
instead since it is good enough as long as an unsigned variable is used
to store the value.

Thank you for reviewing the patch and providing feedback.

Regards,
Siddharth.
