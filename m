Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51399CAC581
	for <u-boot@archiver.kernel.org>; Mon,  8 Sep 2025 11:02:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E20F82AE9;
	Mon,  8 Sep 2025 13:02:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="a40rfmDM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5657F82C84; Mon,  8 Sep 2025 13:02:16 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6237800B6
 for <u-boot@lists.denx.de>; Mon,  8 Sep 2025 13:02:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 588B25YX088810;
 Mon, 8 Sep 2025 06:02:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1757329325;
 bh=i+7n6zQSPOlhxGYThL8RB6EVDQtBazP3J7kOV08d3+4=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=a40rfmDMLp7rCss1Zwpo0i5Okl5rIat/LQ6nJvSasykDUeNM5A22LatfuindjflzA
 Z4Zul4+U8z3gHruzdkTG6zCsE+Ib+sSkEBpdyZa8BUaVqyuX17kIX2C0giGoVk81OC
 hjzkiIkGgPebs9+ropkbHPrSu4VgfuMIRSiWcNhw=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 588B253w2955367
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 8 Sep 2025 06:02:05 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 8
 Sep 2025 06:02:04 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 8 Sep 2025 06:02:04 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.231.84])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 588B23sj787884;
 Mon, 8 Sep 2025 06:02:04 -0500
Date: Mon, 8 Sep 2025 16:32:03 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Heiko Thiery <heiko.thiery@gmail.com>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <trini@konsulko.com>,
 <joe.hershberger@ni.com>, <rfried.dev@gmail.com>,
 <matthias.schiffer@ew.tq-group.com>, <richard.genoud@bootlin.com>,
 <c-vankar@ti.com>, <u-boot@lists.denx.de>, <srk@ti.com>
Subject: Re: [PATCH] net: ti: am65-cpsw-nuss: invoke phy_config() in driver's
 .start callback
Message-ID: <1b370af1-cdb0-42ac-9389-d97fd4b4a8fe@ti.com>
References: <20250416125643.2234165-1-s-vadapalli@ti.com>
 <CAEyMn7ZhsU9vBeSHcPY_oJZXbA51BU50T5HXVRg=6-Ocac4ywg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAEyMn7ZhsU9vBeSHcPY_oJZXbA51BU50T5HXVRg=6-Ocac4ywg@mail.gmail.com>
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

On Mon, Sep 08, 2025 at 10:52:37AM +0200, Heiko Thiery wrote:
> Hi Siddhardth,
> 
> Am Mi., 16. Apr. 2025 um 14:57 Uhr schrieb Siddharth Vadapalli
> <s-vadapalli@ti.com>:
> >
> > Currently, the phy_config() API is invoked by the driver only once since it
> > has been probed. While this works in general, it doesn't allow the driver
> > to bring the PHY back to its default reset state. As a result, the driver
> > might not be able to recover the PHY from a bad state. To address this,
> > move phy_config() into the driver's start callback (am65_cpsw_start()).
> >
> > Apart from providing the means to recover the PHY in the event of failure,
> > the implementation is in line with the idea of "reset and configure" that
> > is already followed by am65_cpsw_start() when it comes to programming the
> > CPSW MAC.
> >
> 
> I do not know if this is the same issue here, but I see that in case
> no cable is connected and I try to do a dhcp command the board/network
> stack of a J722S EVM stays in a broken state. After plugging a cable
> it is not possible to do a successful dhcp. It requires a reset to get
> a working network again. Same issue can be reproduced when unterrupt a
> running dhcp task with CTRL-C.
> 
> ----
> U-Boot 2025.07-rc3-g259a4765c26b (Sep 08 2025 - 10:44:20 +0200)
> 
> SoC:   J722S SR1.0 HS-FS
> Model: Texas Instruments J722S EVM
> DRAM:  2 GiB (total 8 GiB)
> Core:  91 devices, 29 uclasses, devicetree: separate
> MMC:   mmc@fa10000: 0, mmc@fa00000: 1
> Loading Environment from nowhere... OK
> In:    serial@2800000
> Out:   serial@2800000
> Err:   serial@2800000
> Net:   eth0: ethernet@8000000port@1
> Hit any key to stop autoboot:  0
> => dhcp
> ethernet@8000000port@1 Waiting for PHY auto negotiation to
> complete......... TIMEOUT !
> am65_cpsw_nuss_port ethernet@8000000port@1: phy_startup failed
> am65_cpsw_nuss_port ethernet@8000000port@1: am65_cpsw_start end error
> BOOTP broadcast 1
> 
> ----
> 
> Do you have an idea what is going on here?

The following are some experiments that I performed along with the
results:
1. Board:  J784S4-EVM
   U-Boot: 2025.10-rc3 (latest)
   Results of the test:
   dhcp fails when the Ethernet cable is not connected. Connecting the
   cable and re-running the 'dhcp' command works. Reset is not required.
2. Board:  J784S4-EVM
   U-Boot: 2025.07-rc3 (same as the one being used in above test logs)
   Results of the test:
   Identical to '1.'.
3. Board: J722S-EVM
   U-Boot: 2025.07-rc3 (same as the one being used in above test logs)
   Results of the test:
   Issue reported above is seen.
4. Board: J722S-EVM
   U-Boot: 2025.07-rc3 (same as the one being used in above test logs)
   + Revert commit corresponding to the current patch which is:
   https://github.com/u-boot/u-boot/commit/05dc050059d2
   Results of the test:
   Issue reported above is still seen.
5. Board: AM62P5-SK
   U-Boot: 2025.07-rc3 (same as the one being used in above test logs)
   + Revert commit corresponding to the current patch which is:
   https://github.com/u-boot/u-boot/commit/05dc050059d2
   Results of the test:
   Issue reported above is still seen.

To summarize, the issue is unrelated to the current patch. Moreover,
the issue is not seen on the J784S4-EVM. I will spend time trying to
narrow down the root-cause of the issue.

Regards,
Siddharth.
