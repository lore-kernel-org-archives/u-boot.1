Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEBCEC83F26
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 08:28:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A52F68313F;
	Tue, 29 Jul 2025 10:28:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="CrKAq88V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D249082E34; Tue, 29 Jul 2025 07:24:40 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 925C382BCD
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 07:24:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56T5ODfh2467685;
 Tue, 29 Jul 2025 00:24:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1753766653;
 bh=XVFZB5l+qIeq5Sdg7L3DGyJSnUL4Xra5XeFnwFXVfg8=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=CrKAq88V9+hsujWoQZV02LzXB6lggx6EkVps/sj10QNnUw/UhLGgEsqsgVZ1ADpF3
 XPAKln+m3GBP9lDxC4kg1XTMFWyhan7wGQpsiQTJxSo44Geyd2H/TORUqcmc6jN/xi
 TugsBYMNFBkh6F5ctDn254H172cm6LlxM5G7SZ8c=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56T5ODYK2528712
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 29 Jul 2025 00:24:13 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 29
 Jul 2025 00:24:12 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 29 Jul 2025 00:24:12 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.231.84])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56T5OBo73188748;
 Tue, 29 Jul 2025 00:24:11 -0500
Date: Tue, 29 Jul 2025 10:54:10 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Andrew Davis <afd@ti.com>
CC: "Kumar, Udit" <u-kumar1@ti.com>, Siddharth Vadapalli <s-vadapalli@ti.com>, 
 <trini@konsulko.com>, <yegorslists@googlemail.com>, <vigneshr@ti.com>,
 <bb@ti.com>, <nm@ti.com>, <robertcnelson@gmail.com>,
 <m-chawdhry@ti.com>, <vaishnav.a@ti.com>, <j-choudhary@ti.com>,
 <a-nandan@ti.com>, <ggiordano@phytec.com>, <w.egorov@phytec.de>,
 <francesco.dolcini@toradex.com>, <paulk@sys-base.io>,
 <marek.vasut+renesas@mailbox.org>, <romain.gantois@bootlin.com>,
 <kory.maincent@bootlin.com>, <mkorpershoek@kernel.org>,
 <festevam@gmail.com>, <a-dutta@ti.com>, <ddrokosov@salutedevices.com>,
 <anshuld@ti.com>, <jm@ti.com>, <sjg@chromium.org>, <p-mantena@ti.com>,
 <n-francis@ti.com>, <s-k6@ti.com>, <rogerq@kernel.org>,
 <seanga2@gmail.com>, <kamlesh@ti.com>, <a-shenai@ti.com>,
 <c-vankar@ti.com>, <kishon@ti.com>, <dannenberg@ti.com>,
 <e@freeshell.de>, <h-salunke@ti.com>, <semen.protsenko@linaro.org>,
 <peng.fan@nxp.com>, <quentin.schulz@cherry.de>,
 <sumit.garg@kernel.org>, <d.schultz@phytec.de>,
 <emanuele.ghidoli@toradex.com>, <hiago.franco@toradex.com>,
 <joao.goncalves@toradex.com>, <u-boot@lists.denx.de>,
 <praneeth@ti.com>, <srk@ti.com>
Subject: Re: [PATCH 01/45] configs: am335x_baltos_defconfig: Increase aneg
 timeout to 20000 ms
Message-ID: <e5a3f9d5-c420-4282-89ad-2b41fba58e84@ti.com>
References: <20250728145034.225997-1-s-vadapalli@ti.com>
 <20250728145034.225997-2-s-vadapalli@ti.com>
 <a0f6b8ef-ac29-4f53-8d02-c20b1cb0305c@ti.com>
 <9303e5f8-9723-45e4-9ef6-5aef6234bd10@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9303e5f8-9723-45e4-9ef6-5aef6234bd10@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-Mailman-Approved-At: Tue, 29 Jul 2025 10:28:01 +0200
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

On Mon, Jul 28, 2025 at 11:36:53AM -0500, Andrew Davis wrote:

Hello Andrew,

> On 7/28/25 10:33 AM, Kumar, Udit wrote:
> > 
> > On 7/28/2025 8:19 PM, Siddharth Vadapalli wrote:
> > > Increase the PHY Auto-Negotiation timeout to 20,000 ms from the current
> > > default of 4,000 ms inherited from "Kconfig" for PHY_ANEG_TIMEOUT.
> > > 
> > > The motivation for this change is that existing devices will continue
> > > working as-is (timeout is an upper bound and auto-negotiation can be
> > > done earlier), while older Hardware connected to the board that might
> > > occasionally take longer than 4,000 ms for the Auto-Negotiation process
> > > will benefit from an increased timeout.
> > 
> > 
> > Can we think of using TI_COMMON_OPTION , similar to TI_COMMON_CMD_OPTIONS
> > 
> 
> Or simply change the default in Kconfig to something like:
> 
> default 20000 if ARCH_K3 || ARCH_OMAP2PLUS || ARCH_KEYSTONE
> default 4000
> 
> Much better than 45 patches updating each board defconfig individually.

Thank you for the suggestion and I agree that this is much simpler than
the existing approach taken in this series.

> 
> Side question, if this is right for TI plats, why is it not right for
> all the other platforms? Should this be the new base default timeout?
> I don't really think so in either case, the point of the timeout is to
> switch to a fallback port or boot mode in a reasonable time, not sure
> 20 seconds is reasonable..

The timeout is not due to the PHY on TI boards. Rather, it is for the
Link-Partner PHY on the device connected to the TI boards. Based on my
testing, the DP83867 PHY can consistently complete auto-negotiation
under 4 seconds at 1 Gbps Full-Duplex configuration (Tested over 1000
iterations). On the other hand, certain Network Switches which are
acting as the Link-Partner seem to randomly take around 8 seconds.

Since the "config" is a timeout rather than a delay, having a higher
value for the benefit of Link-Partner PHY wouldn't have adverse affect
except in the case where we wish to timeout earlier to start a fallback
mechanism.

Regarding the "20 seconds" being unreasonable, I agree that it seems
invalid, but there are other platforms which use that value. Hence, I
used the same value. I assume that the value wasn't randomly set and is
probably based on testing for those platforms.

> 
> (you probably don't need ~50 people in the TO/CC on this one either, not
> everyone who has ever touched the defconfigs cares about PHY timeouts)

I used the "get_maintainer.pl" script to get the list of email IDs.

Regards,
Siddharth.
