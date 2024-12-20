Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA46E77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 16:20:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C5F080352;
	Fri, 20 Dec 2024 17:20:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Os7sbXWX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DB398036F; Fri, 20 Dec 2024 17:20:10 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5C6680326
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 17:20:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BKGJmgh499492
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Dec 2024 10:19:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1734711588;
 bh=4o2wOfiFnFopQNQf/H8x1dNqpfXoxpN991Xogiob/S0=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=Os7sbXWXFXkIQ7r46b4MptDWlAdVp7TPAXo7mo3LUNYn8xQ+rQvGfAorFZXeAhm1Y
 NgTwMVHZx/WADsur1E07jgkXkgVqWsLtN38dGCl41/b8BPxCQdQuzwfBDNG06qFJ1b
 tbn7cu5lNL2NxbdYJDZ5ayklws+4hQZ8K71xdbr0=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BKGJmqu012677
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 20 Dec 2024 10:19:48 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 20
 Dec 2024 10:19:47 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 20 Dec 2024 10:19:47 -0600
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.81])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BKGJkXt093600;
 Fri, 20 Dec 2024 10:19:47 -0600
Date: Fri, 20 Dec 2024 21:49:46 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros
 <rogerq@kernel.org>, <vigneshr@ti.com>, <bb@ti.com>,
 <lukma@denx.de>, <n-francis@ti.com>, <mkorpershoek@baylibre.com>,
 <afd@ti.com>, <glaroque@baylibre.com>, <sjoerd@collabora.com>,
 <martyn.welch@collabora.com>, <rasmus.villemoes@prevas.dk>,
 <caleb.connolly@linaro.org>, <j-humphreys@ti.com>, <nm@ti.com>,
 <u-boot@lists.denx.de>, <srk@ti.com>
Subject: Re: [PATCH v2 4/5] arm: dts: k3-am62p5-sk-u-boot: enable USB0 for
 USB DFU boot
Message-ID: <5qksc7opj374tssk365jfo5orxmymwn3pzcvchtodf2nenvtsa@4v2dldntch7z>
References: <20241218124542.3519447-1-s-vadapalli@ti.com>
 <20241218124542.3519447-5-s-vadapalli@ti.com>
 <e4b23017-375e-4430-aef2-001c1b6402ca@kernel.org>
 <noztdv7z4cwzjwc5sgqvzli36ppm2tlgrpqjgxbkbtojs34jnp@3lhnfx6ol4in>
 <a0dd6878-5f26-47a0-8025-ba9d9d320a31@kernel.org>
 <20241219170044.GX1505244@bill-the-cat>
 <lq5jqpiifhnmdvfqy2wguqklikcpo3hl37p3ojbm6pfsl6supl@opm7xkmql4y7>
 <20241220142528.GA1505244@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241220142528.GA1505244@bill-the-cat>
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

On Fri, Dec 20, 2024 at 08:25:28AM -0600, Tom Rini wrote:
> On Fri, Dec 20, 2024 at 10:19:31AM +0530, Siddharth Vadapalli wrote:
> > On Thu, Dec 19, 2024 at 11:00:44AM -0600, Tom Rini wrote:
> > 
> > Hello Tom,
> > 
> > > On Thu, Dec 19, 2024 at 11:41:10AM +0200, Roger Quadros wrote:
> > > > 
> > > > 
> > > > On 19/12/2024 07:50, Siddharth Vadapalli wrote:
> > 
> > [...]
> > 
> > > > > 
> > > > > Please let me know if this patch can be merged on the condition that I
> > > > > post the patch for making the same set of changes in the Linux
> > > > > device-tree as well.
> > > > 
> > > > Tom, what do you suggest?
> > > 
> > > I feel like Nishanth will say it if I don't, so, it's blocked until it
> > > comes in via OF_UPSTREAM being re-synced. That's the rule to avoid the
> > > problems we've had in the past.
> > 
> > Thank you for the clarification. If you merge this series partially
> > (i.e. this patch is dropped), please drop the next patch for
> > documentation as well since the feature will not be functional without
> > this patch and hence shouldn't be documented as being functional.
> 
> Please post a v3 of this patch with that can be taken now, off-hand I

Did you mean "v3 of this *series*, with this DT patch and the
Documentation patch dropped in the v3 series?

> don't know how well the kernel cycle will sync up with taking the dts
> change such that we'll also get it.

Regards,
Siddharth.
