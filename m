Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0961E77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 05:50:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28B1B8021D;
	Fri, 20 Dec 2024 06:50:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="xMvYspnu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F80780291; Fri, 20 Dec 2024 06:50:04 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2344E80079
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 06:50:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BK5nnED117656
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 19 Dec 2024 23:49:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1734673790;
 bh=x2ARPsnzthF6i0uzBc3sFCbYuA2Fq/TIUK+/gPGPtX4=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=xMvYspnu94vOK92xU8y/eZF6DgenAa37E2S+JVBIsEODHxv0C59u5/ipxQXOoSb9U
 QMLvDW7cvb3bBObAf1pZGAcKQKgWxuix4yg1nXC0Mwk/7Z6GYHQAVOZe2k1Pl+z2Z/
 0IS1MneMpfAJChOpGhKAnMtVddOzDqCHFZ+Dt6O4=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BK5nnnf063696;
 Thu, 19 Dec 2024 23:49:49 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 19
 Dec 2024 23:49:49 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 19 Dec 2024 23:49:49 -0600
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.81])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BK5nmLe045785;
 Thu, 19 Dec 2024 23:49:49 -0600
Date: Fri, 20 Dec 2024 11:19:47 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Roger Quadros <rogerq@kernel.org>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, <vigneshr@ti.com>,
 <bb@ti.com>, <lukma@denx.de>, <n-francis@ti.com>,
 <mkorpershoek@baylibre.com>, <afd@ti.com>, <glaroque@baylibre.com>,
 <sjoerd@collabora.com>, <martyn.welch@collabora.com>,
 <rasmus.villemoes@prevas.dk>, <caleb.connolly@linaro.org>,
 <j-humphreys@ti.com>, <nm@ti.com>, <u-boot@lists.denx.de>, <srk@ti.com>
Subject: Re: [PATCH v2 4/5] arm: dts: k3-am62p5-sk-u-boot: enable USB0 for
 USB DFU boot
Message-ID: <pnedyv4gzyen2qyagucohtkcw4zgysuviuextxfg6m4ffk5gkb@emgx6hjkulwp>
References: <20241218124542.3519447-1-s-vadapalli@ti.com>
 <20241218124542.3519447-5-s-vadapalli@ti.com>
 <e4b23017-375e-4430-aef2-001c1b6402ca@kernel.org>
 <noztdv7z4cwzjwc5sgqvzli36ppm2tlgrpqjgxbkbtojs34jnp@3lhnfx6ol4in>
 <a0dd6878-5f26-47a0-8025-ba9d9d320a31@kernel.org>
 <20241219170044.GX1505244@bill-the-cat>
 <lq5jqpiifhnmdvfqy2wguqklikcpo3hl37p3ojbm6pfsl6supl@opm7xkmql4y7>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <lq5jqpiifhnmdvfqy2wguqklikcpo3hl37p3ojbm6pfsl6supl@opm7xkmql4y7>
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

On Fri, Dec 20, 2024 at 10:19:31AM +0530, Siddharth Vadapalli wrote:
> On Thu, Dec 19, 2024 at 11:00:44AM -0600, Tom Rini wrote:
> 
> Hello Tom,
> 
> > On Thu, Dec 19, 2024 at 11:41:10AM +0200, Roger Quadros wrote:
> > > 
> > > 
> > > On 19/12/2024 07:50, Siddharth Vadapalli wrote:
> 
> [...]
> 
> > > > 
> > > > Please let me know if this patch can be merged on the condition that I
> > > > post the patch for making the same set of changes in the Linux
> > > > device-tree as well.
> > > 
> > > Tom, what do you suggest?
> > 
> > I feel like Nishanth will say it if I don't, so, it's blocked until it
> > comes in via OF_UPSTREAM being re-synced. That's the rule to avoid the
> > problems we've had in the past.
> 
> Thank you for the clarification. If you merge this series partially
> (i.e. this patch is dropped), please drop the next patch for
> documentation as well since the feature will not be functional without
> this patch and hence shouldn't be documented as being functional.

I have posted the equivalent of this patch for Linux at:
https://lore.kernel.org/r/20241220054550.153360-1-s-vadapalli@ti.com/

Regards,
Siddharth.
