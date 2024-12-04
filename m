Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 323DEE7716D
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 07:47:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90DB589350;
	Wed,  4 Dec 2024 08:47:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="TqzI/GJg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B515893A3; Wed,  4 Dec 2024 08:47:27 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAD9D88E6F
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 08:47:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4B47lEVO2011445
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Dec 2024 01:47:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1733298435;
 bh=sl3lbQ1MRaqQxM3C9O6qI1ksoXlXze5eJdu6tkwuaNo=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=TqzI/GJgZv+8KBFx4e3eANeAS4cqr9BtXNoUxakDxmHSRi0dIhkWB00t4mQ5G2SHX
 xBLHwW+9bxEAI7MkabfZy9N/bdID4gjuWm//z/uldBuCd1FLfAddYQtDU9bNfRCcbw
 Bob2RmfVDSCvsAnvwLpNOIbfiLQQREWG2dhDAzKY=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4B47lEHJ009609
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 4 Dec 2024 01:47:14 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 4
 Dec 2024 01:47:14 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 4 Dec 2024 01:47:14 -0600
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.81])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B47lDLX083210;
 Wed, 4 Dec 2024 01:47:13 -0600
Date: Wed, 4 Dec 2024 13:17:12 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Roger Quadros <rogerq@kernel.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <vigneshr@ti.com>, <bb@ti.com>, 
 <trini@konsulko.com>, <marex@denx.de>, <hnagalla@ti.com>,
 <mkorpershoek@baylibre.com>, <caleb.connolly@linaro.org>,
 <neil.armstrong@linaro.org>, <jan.kiszka@siemens.com>,
 <j-humphreys@ti.com>, <nm@ti.com>, <u-boot@lists.denx.de>, <srk@ti.com>
Subject: Re: [PATCH v2 1/2] usb: dwc3-generic: set "mode" based on caller of
 dwc3_generic_probe()
Message-ID: <dj32jyfvxsds6wsax4tk7kw75zfiutggd5gfbwpklym7gifjih@awk6aerfjwl2>
References: <20241203093748.138260-1-s-vadapalli@ti.com>
 <20241203093748.138260-2-s-vadapalli@ti.com>
 <9254b268-2336-48ca-91de-9da34a93b467@kernel.org>
 <6hohujytkznjcemgu2cjhk2x5pxw7euwzojbt6ktji2yp6zft2@i77rsmzwfgj5>
 <5bd5c98c-530b-4f05-9fbc-e2d867be920a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5bd5c98c-530b-4f05-9fbc-e2d867be920a@kernel.org>
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

On Wed, Dec 04, 2024 at 09:32:23AM +0200, Roger Quadros wrote:
> 
> 
> On 04/12/2024 07:16, Siddharth Vadapalli wrote:
> > On Tue, Dec 03, 2024 at 09:23:11PM +0200, Roger Quadros wrote:

[...]

> >>> +++ b/drivers/usb/dwc3/dwc3-generic.c
> >>> @@ -51,7 +51,8 @@ struct dwc3_generic_host_priv {
> >>>  };
> >>>  
> >>>  static int dwc3_generic_probe(struct udevice *dev,
> >>> -			      struct dwc3_generic_priv *priv)
> >>> +			      struct dwc3_generic_priv *priv,
> >>> +			      enum usb_dr_mode mode)
> >>
> >> This is not necessary as dwc3_generic_host_probe will only be
> >> registered if dr_mode == "host" and dwc3_generic_peripheral_probe
> >> will only be registered if dr_mode == "host" or "peripheral"
> > 
> > But I don't see it happening that way. dwc3_generic_host_probe() or
> > dwc3_generic_peripheral_probe() seem to be invoked based on the command
> > executed - USB Host command will trigger generic_host_probe() while USB
> > Device/Gadget command will trigger generic_peripheral_probe().
> > 
> 
> But, when dr_mode is "otg" generic host driver is *not* bound to the
> DWC3 device. So dwc3_generic_host_probe() will never be called for it.

In USB DFU boot, "dwc3_generic_peripheral_boot()" is invoked. Please
test it out on AM625-SK. I was able to observe this on AM62A7-SK.

> 
> > 
> >>
> >>>  {
> >>>  	int rc;
> >>>  	struct dwc3_generic_plat *plat = dev_get_plat(dev);
> >>> @@ -62,7 +63,19 @@ static int dwc3_generic_probe(struct udevice *dev,
> >>>  
> >>>  	dwc3->dev = dev;
> >>>  	dwc3->maximum_speed = plat->maximum_speed;
> >>> -	dwc3->dr_mode = plat->dr_mode;
> >>> +
> >>> +	/*
> >>> +	 * If the controller supports OTG as indicated by plat->dr_mode,
> >>> +	 * then either Host or Peripheral mode is acceptable.
> >>> +	 * Otherwise, error out since the platform cannot support the mode
> >>> +	 * being requested by the caller of dwc3_generic_probe().
> >>> +	 */
> >>> +	if (plat->dr_mode != mode && plat->dr_mode != USB_DR_MODE_OTG) {
> >>> +		pr_err("Requested usb mode is not supported by platform\n");
> >>
> >> This is actually not necessary. Sorry for suggesting this approach before.
> > 
> > While the check may not be necessary, dr_mode *should* be set based on
> > the caller and not based on plat->dr_mode. The reason I say so is that
> > plat->dr_mode could be "otg" in the device-tree. But "otg" shouldn't be
> > used for further configuration. I had indicated the reason for this in
> > the cover-letter, which I am pasting below for your reference:
> > 
> > ---------------------------------------------------------------------------
> > Currently, dwc3_generic_probe() sets the mode based on the device-tree
> > rather than setting it on the basis of the caller. While this might be
> > correct when the mode is "host" or "peripheral" in the device-tree, it is
> > wrong when the mode is "otg" in the device-tree. It is wrong because of two
> > reasons:
> > 1. There is no OTG state machine in U-Boot. Hence the role will never
> > switch to the correct one eventually among host or peripheral.
> > 2. dr_mode = "otg" results in the "PRTCAPDIR" field of the "GCTL"
> > register of the USB Controller being set to 11b. According to the
> > datasheet of the Designware USB Dual Role Controller, "PRTCAPDIR"
> > should never be set to any value other than 01b (Host) and 10b (Device).
> > Quoting the datasheet:
> > "Programming this field with random data causes the controller
> > to keep toggling between the host mode and the device mode."
> > 
> > Therefore, in order to avoid programming 11b in "PRTCAPDIR", and, given
> > that the caller specifies the intended role, rather than simply using
> > the "dr_mode" property to set the role, set the role on the basis of the
> > caller (intended role) and the device-tree (platform support).
> > ----------------------------------------------------------------------------
> > 
> > Point #2 above is the main reason why dr_mode cannot be set to "otg" in
> > dwc3_generic_probe(). The only difference now is that the check can be
> > dropped as you have indicated, so the last paragraph above will change
> 
> Finally we are at the root of the problem. But the solution is not to
> change the dr_mode but instead handle it correctly in dwc3_core_init_mode()
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index a35b8c2f646..7f42b6e62c6 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -752,13 +752,8 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
>  		}
>  		break;
>  	case USB_DR_MODE_OTG:
> -		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_OTG);
> -		ret = dwc3_host_init(dwc);
> -		if (ret) {
> -			dev_err(dwc->dev, "failed to initialize host\n");
> -			return ret;
> -		}
> -
> +		/* We don't support dual-role so restrict to Device mode */
> +		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_DEVICE);

But is this acceptable? Why not default to Host? I went through a series
for defaulting OTG to Device for the Cadence Controller which was
objected at:
https://lore.kernel.org/r/62c5fe13-7f0e-e736-273e-31a8bbddbf13@kernel.org/
with the suggestion to use the cable to determine the role.

Regards,
Siddharth.
