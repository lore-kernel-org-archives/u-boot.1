Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1901C87FCA
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 08:37:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A2B9843E3;
	Thu,  7 Aug 2025 10:37:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cFlaDPUs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FAAB84474; Thu,  7 Aug 2025 10:37:08 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F012A843E2
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 10:37:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 5571B61416;
 Thu,  7 Aug 2025 08:37:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83BB2C4CEEB;
 Thu,  7 Aug 2025 08:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1754555824;
 bh=XEILugtF3OTgFelE8OxzFaApAQhXviuEN7AOeKpCL+Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cFlaDPUsHVauZdXhvCK6uWmKUcYH00gcSRJgRBrYic09ongvfd8V3wZyqNGwvB2XD
 FTOzvcH6vqpITxNrsf7Tw0t7cw4k2fxY/Ypv54kRdIib81E1wJztFiDjVTKAMSySny
 2j5sFnjhW2OFYau0btOP7rNiNPxuolD/eh/bHaMXoekg29BhYAHZclfirbJofXUcvU
 /+ax4RP/NHEFzwhsDdn8+PoyBF5LloFyJYnl843bVtqQFfCp5QMFU0cGSTSmrMd5SF
 kTJoSld8j8Lv6ydBUgg36I9OSRkEr0iZeIBs6SGd0NW1lxmyfv5+Pbpo+R08NxJUSk
 izUcxEDqbHGhQ==
Date: Thu, 7 Aug 2025 10:36:59 +0200
From: Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: Smatch report for drivers/net/phy/marvell10g.c
Message-ID: <bxuuwcj7jm33go7yj4jnafoowrttu2qvbxej7nvdn3pm5az4sj@6xpf3ym2s2ek>
References: <623c39a5-2438-42d5-aafe-bb80dfd12b82@linaro.org>
 <20250806145315.GO124814@bill-the-cat>
 <8a05c8a6-a0eb-4f84-aa48-0d0e0f532fa4@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a05c8a6-a0eb-4f84-aa48-0d0e0f532fa4@mailbox.org>
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

On Wed, Aug 06, 2025 at 05:36:27PM +0200, Marek Vasut wrote:
> On 8/6/25 4:53 PM, Tom Rini wrote:
> > On Tue, Aug 05, 2025 at 05:30:49PM +0100, Andrew Goodbody wrote:
> > 
> > > I have these Smatch reports.
> > > 
> > > drivers/net/phy/marvell10g.c:384 mv3310_select_mactype() warn: was ||
> > > intended here instead of &&?
> > > drivers/net/phy/marvell10g.c:387 mv3310_select_mactype() warn: was ||
> > > intended here instead of &&?
> > > drivers/net/phy/marvell10g.c:390 mv3310_select_mactype() warn: was ||
> > > intended here instead of &&?
> > > 
> > > Now there is obviously incorrect code there as it cannot work correctly as
> > > is, phydev->interface cannot equal two different enums at the same time, but
> > > simply swapping the && for || is not going to work either. Could anyone
> > > please point me in the direction of a fix?
> > 
> > Adding Marek as r8a779f0_spider and r8a779f4_s4sk are the only two
> > boards which enable CONFIG_PHY_MARVELL_10G (aside, ./tools/qconfig.py -b
> > and then ./tools/qconfig.py -f CONFIG_FOO is handy to see what boards
> > enable a given option and helpful when get_maintainer.pl has nothing
> > specific).
> They use the 2xxx series PHY, so this code is avoided. However, it seems
> even linux-next has the same behavior in .select_mactype() callback . They
> use test_bit() in there, but otherwise also use && instead of || which looks
> odd. Maybe that is a genuine bug which got ported over from Linux and needs
> to be fixed both there and here ?

In linux there is a bitmap of supported interface modes given to the
function. Then for example we test whether 10gbase-r and sgmii are both
supported by the host (SoC):

  ...
  else if (test_bit(PHY_INTERFACE_MODE_SGMII, interfaces) &&
           test_bit(PHY_INTERFACE_MODE_10GBASER, interfaces))
          return MV_V2_33X0_PORT_CTRL_MACTYPE_10GBASER;
  ...

If both 10gbase-r and sgmii are supported by the SoC, we tell the PHY to
use mactype 4 (MV_V2_33X0_PORT_CTRL_MACTYPE_10GBASER).

Obiously this does not work in U-Boot it we translate it to
  interface == MODE_SGMII && interface == MODE_10GBASER
since the interface variable is not a bitmap of supported interfaces,
but rather the current interface mode (maybe from device-tree).

Looking at U-Boot's marvell10g code, I also see mv_test_bit macro
and how it is being used:

  #define mv_test_bit(iface, phydev) \
    ({ if ((phydev)->interface & (iface)) return 0; })

  mv_test_bit(PHY_INTERFACE_MODE_SGMII, phydev);

This is completely wrong, since the ->interface member is not a bitmap
(rather the currnet selected interface) nor are the PHY_INTERFACE_MODE_*
values one-bit values.

So this code will not work correctly at all in U-Boot.


Now as to why Linux also has interfaces bitmap in addition to the current
selected interface.

The reason why in Linux we use bitmap of supported interface modes is so
that we can select the best serdes mode switching behavior for the PHY.

For example if the host only supports 10gbase-r serdes mode, then the PHY
must always talk to the host in 10gbase-r mode, even if the RJ-45 copper
speed was autonegotiated to lower speed (i.e. 1gbps). (There is another
complication called rate matching that needs to be done in that case,
but this is not important now.)

If the host supports both 10gbase-r and sgmii serdes modes, we want the
PHY to switch to sgmii if the RJ-45 speed is 1000/100/10, and to switch
to 10gbase-r if the RJ-45 speed is 10000.

The register configuring this behavior is called MACTYPE in the Marvell
PHY.

The following table shows how the PHY will change serdes mode depedning
on the RJ-45 speed for some of the MACTYPE settings:

               mactype=4   mactype=6  mactype=7  mactype=0
  RJ-45 speed  sds mode    sds mode   sds mode   sds mode
  ---------------------------------------------------------
  10/100/1000  sgmii       10gbase-r  usxgmii    sgmii
  2500         2500base-x  10gbase-r  usxgmii    2500base-x
  5000         5gbase-r    10gbase-r  usxgmii    5gbase-r
  10000        10gbase-r   10gbase-r  usxgmii    rxaui

Marek
