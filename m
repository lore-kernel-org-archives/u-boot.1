Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 529E9C83F25
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 10:04:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCA7F83381;
	Tue, 22 Jul 2025 12:04:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="HfkBdV6V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D832D833C6; Tue, 22 Jul 2025 12:04:00 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42ADD83346
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 12:03:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56MA3oIl1471096;
 Tue, 22 Jul 2025 05:03:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1753178630;
 bh=C0GfBbjwYwl3fvDuD984Pxwt9/Yw37h1f54bsN9nRRw=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=HfkBdV6VS7KLPP2jYFQ3mv9wYMW7K5HWV8/n+gmKlqRbd2xOOjvLNlJ4hLYmLbJfG
 svZalXEF5GdgPjAw0rcQqCu2XbthSxvmue8kDB8meF9IjLLWvWAxVE/ERqWAy8htnk
 WwIDP4BpFpHNM8MgndfjTzOksKN7Jxuf4FltcLCk=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56MA3opc4019284
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 22 Jul 2025 05:03:50 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 22
 Jul 2025 05:03:49 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 22 Jul 2025 05:03:49 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.169])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56MA3lxU854707;
 Tue, 22 Jul 2025 05:03:48 -0500
Date: Tue, 22 Jul 2025 15:33:47 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <trini@konsulko.com>,
 <sjg@chromium.org>, <joe.hershberger@ni.com>, <rfried.dev@gmail.com>,
 <marek.vasut+renesas@mailbox.org>, <jerome.forissier@linaro.org>,
 <kever.yang@rock-chips.com>, <alexthreed@gmail.com>,
 <skylake.huang@mediatek.com>, <u-boot@lists.denx.de>,
 <u-kumar1@ti.com>, <praneeth@ti.com>, <nm@ti.com>, <srk@ti.com>
Subject: Re: [PATCH] net: phy: Support overriding Auto Negotiation timeout
 with env variable
Message-ID: <770cbe13-ff0a-4fb0-b912-43290b3435ca@ti.com>
References: <20250722060554.352952-1-s-vadapalli@ti.com>
 <e92c9774-ad98-4f7b-bafe-eaf068f3ad72@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e92c9774-ad98-4f7b-bafe-eaf068f3ad72@cherry.de>
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

On Tue, Jul 22, 2025 at 10:49:04AM +0200, Quentin Schulz wrote:
> Hi Siddarth,
> 
> On 7/22/25 8:05 AM, Siddharth Vadapalli wrote:
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
> 
> I'm not entirely convinced it makes sense to do that but I'm not against it,
> will let others decide. If we go forward with it, please see comments below.
> 
> > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > ---
> > 
> > Hello,
> > 
> > This patch is based on commit
> > 7598b469c16 Merge tag 'u-boot-dfu-next-20250703' of https://source.denx.de/u-boot/custodians/u-boot-dfu into next
> > of the next branch of Mainline U-Boot.
> > 
> > Patch has been tested on J784S4-EVM validating the following cases:
> > 1. PHY Auto-Negotiation performed with "phy_aneg_timeout" unset.
> >     CONFIG_PHY_TIMEOUT with a value of 4,000 takes effect.
> >     => Auto Negotiation succeeds
> > 2. PHY Auto-Negotiation performed with "phy_aneg_timeout" set to 10,000.
> >     "phy_aneg_timeout" overrides CONFIG_PHY_TIMEOUT.
> >     [Higher value than default specified by CONFIG_PHY_ANEG_TIMEOUT]
> >     => Auto Negotiation succeeds
> > 3. PHY Auto-Negotiation performed with "phy_aneg_timeout" set to 2,000.
> >     "phy_aneg_timeout" overrides CONFIG_PHY_TIMEOUT.
> >     [Lower value than default specified by CONFIG_PHY_ANEG_TIMEOUT]
> >     => Auto Negotiation times out
> > 
> > Test Logs:
> > https://gist.github.com/Siddharth-Vadapalli-at-TI/697eadcbb26786435df48a834c968375
> > 
> > Regards,
> > Siddharth.
> > 
> >   doc/usage/environment.rst | 8 ++++++++
> >   drivers/net/phy/phy.c     | 6 +++++-
> >   2 files changed, 13 insertions(+), 1 deletion(-)
> > 
> > diff --git a/doc/usage/environment.rst b/doc/usage/environment.rst
> > index bb6c351b441..7447bb85d3e 100644
> > --- a/doc/usage/environment.rst
> > +++ b/doc/usage/environment.rst
> > @@ -335,6 +335,14 @@ netretry
> >       Useful on scripts which control the retry operation
> >       themselves.
> > +phy_aneg_timeout
> > +    If set, the specified value will override CONFIG_PHY_ANEG_TIMEOUT
> > +    which defaults to 4000. The default value of CONFIG_PHY_ANEG_TIMEOUT
> > +    may be sufficient for most use-cases, but certain link-partners
> > +    may require a larger timeout due to the Ethernet PHY they use.
> > +    Alternatively, the timeout can be reduced as well if the use-case
> > +    demands it.
> > +
> 
> Please also update the Kconfig symbol's help to mention this new variable
> can override the value in that symbol.

Sure, I will do so.

> 
> Please also mention the base and unit of that variable. Reading the code, it
> seems it's forced decimal and the unit is milliseconds?

The unit is the same as CONFIG_PHY_ANEG_TIMEOUT which it overrides.

> 
> >   rng_seed_size
> >       Size of random value added to device-tree node /chosen/rng-seed.
> >       This variable is given as a decimal number.
> > diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
> > index e6fed8c41d7..0f5c9685b59 100644
> > --- a/drivers/net/phy/phy.c
> > +++ b/drivers/net/phy/phy.c
> 
> Please also update other users of CONFIG_PHY_ANEG_TIMEOUT. I would recommend
> to abstract the logic to get the timeout into a function so that consumers
> don't have to do the parsing themselves, they simply call that function to
> get the actual timeout.
> 
> Users are drivers/net/phy/aquantia.c and drivers/net/xilinx_axi_emac.c as
> well at the very least.
> 
> I'm wondering if we should only have this environment variable and make it
> default to CONFIG_PHY_ANEG_TIMEOUT instead? Then the logic would be to
> simply read this variable.

Would it be better to increase the default value of
CONFIG_PHY_ANEG_TIMEOUT to maybe 20,000 instead? If auto negotiation
completes earlier, then there won't be any issues for existing users.
The only problem could be if it is expected to fail earlier for
triggering a fallback mechanism. Please let me know what you think.

Regards,
Siddharth.
