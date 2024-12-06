Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 819D5E77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 10:07:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4D328923A;
	Fri,  6 Dec 2024 11:07:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="StJacQEB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 075798903C; Fri,  6 Dec 2024 11:07:26 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B01089638
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 11:07:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4B6A7EKA1895641
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 6 Dec 2024 04:07:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1733479634;
 bh=E0nyTRuOWXIx7bqrmkJVMd3+TH0sWtxeqD72/qzpX2k=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=StJacQEBT3SCnciuwKXlupuc5m4RPtIY2haoey5/Di+FvMMXLSbiiRnjYmAWyHrx6
 K/s3o/uk/lutxOMpQ9uK+BrHpvVzW/XdHWHwd6d5iAbmiHZq0SWNPGryIvt7pWNJXq
 DnYyangsH4iGj7qCs7MKfMSWYz5RlAzeAp4/jPIc=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4B6A7E4N067922
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 6 Dec 2024 04:07:14 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 6
 Dec 2024 04:07:13 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 6 Dec 2024 04:07:13 -0600
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.81])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B6A7C5S022386;
 Fri, 6 Dec 2024 04:07:13 -0600
Date: Fri, 6 Dec 2024 15:37:12 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Roger Quadros <rogerq@kernel.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, Tom Rini <trini@konsulko.com>,
 Martyn Welch <martyn.welch@collabora.com>, Sjoerd Simons
 <sjoerd@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, <marex@denx.de>,
 <vigneshr@ti.com>, <nm@ti.com>, <j-humphreys@ti.com>, <srk@ti.com>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH] configs: am62x_evm_*: Fix USB DFU configuration
Message-ID: <subjsndbckmj5kgcy6dkh4av5abxkeufjqibwjbom267yotj2a@id3kbhlg2dc7>
References: <20241203-am62-usb-xhci-v1-1-a791cb914186@kernel.org>
 <unf757pwgah5ylkcfdumtdo5zs2ny3nxct5u26t6up7aldqim2@mxhhtb53gw4x>
 <d103c8e4-d599-4c75-9239-11e7e8adf6e9@kernel.org>
 <a9c458f8-68e5-448b-9977-e7bf37b00d35@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a9c458f8-68e5-448b-9977-e7bf37b00d35@kernel.org>
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

On Fri, Dec 06, 2024 at 11:44:38AM +0200, Roger Quadros wrote:
> 
> 
> On 06/12/2024 11:17, Roger Quadros wrote:
> > Hello Siddharth,
> > 
> > On 06/12/2024 09:19, Siddharth Vadapalli wrote:

[...]

> >> 2. With the understanding that "dr_mode" doesn't have to be host/otg for
> >> the compatible "snps,dwc3" which is tied to drivers/usb/host/xhci-dwc3.c,
> >> do the following to exit probe when "dr_mode" is "peripheral":
> >> -------------------------------------------------------------------------
> >> diff --git a/drivers/usb/host/xhci-dwc3.c b/drivers/usb/host/xhci-dwc3.c
> >> index e3e0ceff43e..edfd7b97a73 100644
> >> --- a/drivers/usb/host/xhci-dwc3.c
> >> +++ b/drivers/usb/host/xhci-dwc3.c
> >> @@ -208,6 +208,8 @@ static int xhci_dwc3_probe(struct udevice *dev)
> >>         writel(reg, &dwc3_reg->g_usb2phycfg[0]);
> >>
> >>         dr_mode = usb_get_dr_mode(dev_ofnode(dev));
> >> +       if (dr_mode == USB_DR_MODE_PERIPHERAL)
> >> +               return -ENODEV;
> >>         if (dr_mode == USB_DR_MODE_OTG &&
> >>             dev_read_bool(dev, "usb-role-switch")) {
> >>                 dr_mode = usb_get_role_switch_default_mode(dev_ofnode(dev));
> >> -------------------------------------------------------------------------
> >> which will still show "xhci-dwc3" in the output of "dm tree" after "usb
> >> start", but the driver won't be probed (absence of "+" in the "Probed"
> >> column of "dm tree" output).
> 
> I realized later that if dr_mode == USB_DR_MODE_OTG/HOST which is the case
> for am62a, then xhci-dwc3.c will still be probed and we have 2 drivers
> probed for the same controller?

Yes, that's true!

> 
> We do not want that right?
> So not having CONFIG_USB_XHCI_DWC3 is still required for am62*.

Yes.

> 
> Maybe we still need some Kconfig guards that prevent both CONFIG_USB_XHCI_DWC3
> and USB_DWC3_GENERIC to be set together as 2 drivers will claim the
> controller if dr_mdoe is USB_DR_MODE_OTG or USB_DR_MODE_HOST.

Looking at the list of compatibles in dwc3-generic.c and focusing on the
compatible "ti,keystone-dwc3", I see that this compatible is present in:
dts/upstream/src/arm/ti/keystone/keystone.dtsi
among other keystone device-tree files. The hierarchy of the nodes and
compatibles for the USB Subsystem and the USB Controller in Keystone is
similar to that of AM62*. The difference however is the following:
A) For non AM62* devices:
	USB Subsystem [Wrapper] driver is dwc3-generic.c
		USB Controller [DWC3] driver is xhci-dwc3.c
B) For AM62* devices:
	USB Subsystem [Wrapper] driver is dwc3-am62.c
	which exposes its own ".glue_configure" callback similar to what
	is done in dwc3-generic.c for other devices.
		USB Controller [DWC3] driver is xhci-dwc3.c
So maybe non AM62* devices have:
	dwc3-generic.c for Subsystem + xhci-dwc3.c for USB Controller
while AM62* devices have:
	dwc3-am62.c for Subsystem + dwc3-generic.c (neither Subsystem
	nor Controller?) + xhci-dwc3.c for USB Controller
We could probably end up with the two driver situation similar to non
AM62* devices if we update dwc3-generic.c to handle the configuration
performed by dwc3-am62.c. But that still means we have two drivers:
dwc3-generic.c and xhci-dwc3.c
Maybe viewing the output of "dm tree" on a non AM62* device with both
CONFIG_USB_XHCI_DWC3 and CONFIG_USB_DWC3_GENERIC enabled will let us
know whether that is a valid configuration or not.

Regards,
Siddharth.
