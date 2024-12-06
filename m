Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0DB4E77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 09:39:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D336389627;
	Fri,  6 Dec 2024 10:39:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="dxZ9U6jQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8489389639; Fri,  6 Dec 2024 10:39:04 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46F0089498
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 10:39:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4B69cr3t2056725
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 6 Dec 2024 03:38:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1733477933;
 bh=AK0Az5h+1siTuhbKNERoO+q7BeU884KhY/1RTFFMJCU=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=dxZ9U6jQf4hTUga9KnlFOl94TOilHBLVASIrgl27O4w9w/BjWyEiLfdzrylFpT2/H
 aCn71X9WPP4UCazDll0r510ifwsx7X3wqUeylmnaZFxzgcRzhA0nZ48U2KOKonxRyc
 24rDuOpmKgcKz2/rFW+o+tROUztRkLNYMdtW56KM=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B69crqL092514;
 Fri, 6 Dec 2024 03:38:53 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 6
 Dec 2024 03:38:53 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 6 Dec 2024 03:38:53 -0600
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.81])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B69cqau118823;
 Fri, 6 Dec 2024 03:38:53 -0600
Date: Fri, 6 Dec 2024 15:08:51 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Roger Quadros <rogerq@kernel.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, Tom Rini <trini@konsulko.com>,
 Martyn Welch <martyn.welch@collabora.com>, Sjoerd Simons
 <sjoerd@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, <marex@denx.de>,
 <vigneshr@ti.com>, <nm@ti.com>, <j-humphreys@ti.com>, <srk@ti.com>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH] configs: am62x_evm_*: Fix USB DFU configuration
Message-ID: <bxy6wjdqspy7n5yaqy2lgelxfl6ldtgwkfube7vxpe7ektwldr@npg574indxwk>
References: <20241203-am62-usb-xhci-v1-1-a791cb914186@kernel.org>
 <unf757pwgah5ylkcfdumtdo5zs2ny3nxct5u26t6up7aldqim2@mxhhtb53gw4x>
 <d103c8e4-d599-4c75-9239-11e7e8adf6e9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d103c8e4-d599-4c75-9239-11e7e8adf6e9@kernel.org>
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

On Fri, Dec 06, 2024 at 11:17:28AM +0200, Roger Quadros wrote:
> Hello Siddharth,
> 
> On 06/12/2024 09:19, Siddharth Vadapalli wrote:

[...]

> > While this fixes the issue, I am wondering if the issue lies elsewhere.
> > In U-Boot, the compatible "snps,dwc3" is associated with:
> > drivers/usb/host/xhci-dwc3.c
> > while in Linux, the compatible "snps,dwc3" is associated with:
> > drivers/usb/dwc3/core.c
> > 
> > So there seem to be two alternatives that I could think of:
> > 1. Modify U-Boot to match Linux in the sense that we associate
> > "snps,dwc3" with drivers/usb/dwc3/core.c in U-Boot.
> 
> Many platforms (grep for CONFIG_USB_XHCI_DWC3
> in configs/) use xhci-dwc3 to get Host mode working
> without the need for core.c. Maybe it was more simpler that way?
> Also see USB_XHCI_DWC3_OF_SIMPLE.
> 
> So if we drop "snps,dwc3" from xhci-dwc3, we will have to ensure each
> and every platform works.

Yes, that will require significant effort and testing.

> 
> > 2. With the understanding that "dr_mode" doesn't have to be host/otg for
> > the compatible "snps,dwc3" which is tied to drivers/usb/host/xhci-dwc3.c,
> > do the following to exit probe when "dr_mode" is "peripheral":
> > -------------------------------------------------------------------------
> > diff --git a/drivers/usb/host/xhci-dwc3.c b/drivers/usb/host/xhci-dwc3.c
> > index e3e0ceff43e..edfd7b97a73 100644
> > --- a/drivers/usb/host/xhci-dwc3.c
> > +++ b/drivers/usb/host/xhci-dwc3.c
> > @@ -208,6 +208,8 @@ static int xhci_dwc3_probe(struct udevice *dev)
> >         writel(reg, &dwc3_reg->g_usb2phycfg[0]);
> > 
> >         dr_mode = usb_get_dr_mode(dev_ofnode(dev));
> > +       if (dr_mode == USB_DR_MODE_PERIPHERAL)
> > +               return -ENODEV;
> >         if (dr_mode == USB_DR_MODE_OTG &&
> >             dev_read_bool(dev, "usb-role-switch")) {
> >                 dr_mode = usb_get_role_switch_default_mode(dev_ofnode(dev));
> > -------------------------------------------------------------------------
> > which will still show "xhci-dwc3" in the output of "dm tree" after "usb
> > start", but the driver won't be probed (absence of "+" in the "Probed"
> > column of "dm tree" output).
> 
> I agree with your second proposal.
> But it is a separate bug (in xhci-dwc3 driver) which also
> fixes the issue this patch is fixing.
> 
> Regardless, I think both fixes should go in.
> 
> Could you please send a patch to fix xhci-dwc3? Thanks!

Sure. Thank you for reviewing the suggestions and sharing your feedback.

Regards,
Siddharth.
