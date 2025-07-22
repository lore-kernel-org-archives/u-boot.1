Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A25B9C83F27
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 13:04:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1514B83865;
	Tue, 22 Jul 2025 15:04:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="g00TNbA9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD3D183844; Tue, 22 Jul 2025 15:04:03 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFC6283865
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 15:04:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56MD3sI71049482;
 Tue, 22 Jul 2025 08:03:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1753189434;
 bh=uSR148hPo9d852/RSEBi/ugfg5ebJFl6hLxpFLwWANA=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=g00TNbA9g1LNTDhzIGy6HoJt0CVMOzzbloU/ibi3sbyHj5694hRFJpWcIhxUJPq82
 cVttMe8JDu/1ODJM8UmN/VK284a8Zl+PKglZh2NL8hlPkelYqFtyZf/VprnPHNnSiR
 ti/FVn9NnfU3wyim7k+w6VgTXMpRcj/xdcLfFSBY=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56MD3rwf1636716
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 22 Jul 2025 08:03:53 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 22
 Jul 2025 08:03:53 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 22 Jul 2025 08:03:53 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.169])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56MD3pW81364431;
 Tue, 22 Jul 2025 08:03:52 -0500
Date: Tue, 22 Jul 2025 18:33:51 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Marek Vasut <marek.vasut@mailbox.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <trini@konsulko.com>,
 <sjg@chromium.org>, <joe.hershberger@ni.com>, <rfried.dev@gmail.com>,
 <marek.vasut+renesas@mailbox.org>, <jerome.forissier@linaro.org>,
 <quentin.schulz@cherry.de>, <kever.yang@rock-chips.com>,
 <alexthreed@gmail.com>, <skylake.huang@mediatek.com>,
 <u-boot@lists.denx.de>, <u-kumar1@ti.com>, <praneeth@ti.com>,
 <nm@ti.com>, <srk@ti.com>
Subject: Re: [PATCH] net: phy: Support overriding Auto Negotiation timeout
 with env variable
Message-ID: <9c497e20-a355-44aa-8d68-8867cf7f4fea@ti.com>
References: <20250722060554.352952-1-s-vadapalli@ti.com>
 <6d6759e3-1ebe-4e60-bac3-93f1b40aa726@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6d6759e3-1ebe-4e60-bac3-93f1b40aa726@mailbox.org>
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

On Tue, Jul 22, 2025 at 02:57:33PM +0200, Marek Vasut wrote:
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
> >   rng_seed_size
> >       Size of random value added to device-tree node /chosen/rng-seed.
> >       This variable is given as a decimal number.
> > diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
> > index e6fed8c41d7..0f5c9685b59 100644
> > --- a/drivers/net/phy/phy.c
> > +++ b/drivers/net/phy/phy.c
> > @@ -9,6 +9,7 @@
> >    */
> >   #include <console.h>
> >   #include <dm.h>
> > +#include <env.h>
> >   #include <log.h>
> >   #include <malloc.h>
> >   #include <net.h>
> > @@ -243,6 +244,9 @@ int genphy_update_link(struct phy_device *phydev)
> >   	if ((phydev->autoneg == AUTONEG_ENABLE) &&
> >   	    !(mii_reg & BMSR_ANEGCOMPLETE)) {
> >   		int i = 0;
> > +		char *s = env_get("phy_aneg_timeout");
> env_get_ulong("phy_aneg_timeout", 10, CONFIG_PHY_ANEG_TIMEOUT);

Thank you for the suggestion. I will use the helper mentioned above
instead of the custom implementation in the next version of the patch.

Regards,
Siddharth.
