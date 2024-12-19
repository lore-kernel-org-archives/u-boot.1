Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA24E77184
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 05:51:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0BFF8021D;
	Thu, 19 Dec 2024 06:51:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="TkVAAKs1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C250A80274; Thu, 19 Dec 2024 06:51:09 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9ABA68021A
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 06:51:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BJ5omvu263932
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Dec 2024 23:50:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1734587449;
 bh=prdKvHe782DRRCOsWC1xcXzauQBh6E2E6HztUu1jYRM=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=TkVAAKs1y4oUT63IgVJkUTh3o7Lq9Pk0V9HUn9iBkT2/Bf3GN7yXRIvyVBTK80o52
 gE/6Q50s0lf+vGGyHapn6835ctGP6w03xCEkwZmRouwy3Z71zP7cDbO3L7rgQXvTGE
 +UYMaTnLyd2hkt+FmO/BTXAZUEW1PJkyFz+gviik=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BJ5omJx006260
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 18 Dec 2024 23:50:48 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 18
 Dec 2024 23:50:48 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 18 Dec 2024 23:50:48 -0600
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.81])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BJ5okt2104043;
 Wed, 18 Dec 2024 23:50:47 -0600
Date: Thu, 19 Dec 2024 11:20:46 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Roger Quadros <rogerq@kernel.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <vigneshr@ti.com>, <bb@ti.com>, 
 <trini@konsulko.com>, <lukma@denx.de>, <n-francis@ti.com>,
 <mkorpershoek@baylibre.com>, <afd@ti.com>, <glaroque@baylibre.com>,
 <sjoerd@collabora.com>, <martyn.welch@collabora.com>,
 <rasmus.villemoes@prevas.dk>, <caleb.connolly@linaro.org>,
 <j-humphreys@ti.com>, <nm@ti.com>, <u-boot@lists.denx.de>, <srk@ti.com>
Subject: Re: [PATCH v2 4/5] arm: dts: k3-am62p5-sk-u-boot: enable USB0 for
 USB DFU boot
Message-ID: <noztdv7z4cwzjwc5sgqvzli36ppm2tlgrpqjgxbkbtojs34jnp@3lhnfx6ol4in>
References: <20241218124542.3519447-1-s-vadapalli@ti.com>
 <20241218124542.3519447-5-s-vadapalli@ti.com>
 <e4b23017-375e-4430-aef2-001c1b6402ca@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e4b23017-375e-4430-aef2-001c1b6402ca@kernel.org>
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

On Wed, Dec 18, 2024 at 04:05:47PM +0200, Roger Quadros wrote:

Hello Roger,

> Hi Siddharth,
> 
> On 18/12/2024 14:45, Siddharth Vadapalli wrote:
> > Enable USB0 instance of the USB controller for USB DFU boot functionality
> > which requires the "bootph-all" property in order to have USB enabled at
> > all stages of the USB DFU boot.
> > 
> > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> > ---
> > v1:
> > https://patchwork.ozlabs.org/project/uboot/patch/20241217131658.2920799-5-s-vadapalli@ti.com/
> > Changes since v1:
> > - Collected Reviewed-by tag.
> > 
> >  arch/arm/dts/k3-am62p5-sk-u-boot.dtsi | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/arch/arm/dts/k3-am62p5-sk-u-boot.dtsi b/arch/arm/dts/k3-am62p5-sk-u-boot.dtsi
> > index cf087c6e343..c2091fc1a51 100644
> > --- a/arch/arm/dts/k3-am62p5-sk-u-boot.dtsi
> > +++ b/arch/arm/dts/k3-am62p5-sk-u-boot.dtsi
> > @@ -16,3 +16,13 @@
> >  &dmsc {
> >  	bootph-pre-ram;
> >  };
> > +
> > +/* Required for USB DFU boot */
> > +&usbss0 {
> > +	status = "okay";
> > +};
> 
> This should come via upstream DT sync?
> 
> > +
> > +/* Required for USB DFU boot */
> > +&usb0 {
> > +	bootph-all;
> > +};
> 
> This as well? But I don't see it upstream. Do you have a patch for upstream DT?

I haven't posted the patch for Linux device-tree yet. I will post it and
it can be synced with U-Boot later. In order to avoid blocking USB DFU
support on the Linux device-tree sync, I have posted this patch for this
series to be complete in terms of functionality. If Linux device-tree
based sync is the only way to enable this, then the following patch in
this series for documentation should also be dropped since the feature
will not be functional without the changes made by this patch.

Please let me know if this patch can be merged on the condition that I
post the patch for making the same set of changes in the Linux
device-tree as well.

Regards,
Siddharth.
