Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE4A0E7716B
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 10:05:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3BF5890A8;
	Wed,  4 Dec 2024 11:05:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="twbRJiGo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4019B8967A; Wed,  4 Dec 2024 11:05:28 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DD5C88E35
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 11:05:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4B4A5Fit1586975
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Dec 2024 04:05:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1733306715;
 bh=3cZ7nKXxir7V69D+BOfD8eG/8hhOnui2SkA4H39ydks=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=twbRJiGo+TDafpZk+hkkiAj7Cq5noGvOyZbbUfoCbeKicLKA7tawQ5yIy068jh3ws
 N/gRsFPLzFQRgP9PIWOMZl2EAA/jM/R6ZsWvMtkmj+uEwOKDVd7ymIOZ9ouFbPoyuP
 D2vaiSjGnwFUabjYNNLfp6OkAPTk0H2ABJEsZOX4=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4B4A5FJA004774
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 4 Dec 2024 04:05:15 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 4
 Dec 2024 04:05:14 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 4 Dec 2024 04:05:14 -0600
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.81])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B4A5DHh115266;
 Wed, 4 Dec 2024 04:05:13 -0600
Date: Wed, 4 Dec 2024 15:35:12 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Roger Quadros <rogerq@kernel.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <vigneshr@ti.com>, <bb@ti.com>, 
 <trini@konsulko.com>, <marex@denx.de>, <hnagalla@ti.com>,
 <mkorpershoek@baylibre.com>, <caleb.connolly@linaro.org>,
 <neil.armstrong@linaro.org>, <jan.kiszka@siemens.com>,
 <j-humphreys@ti.com>, <nm@ti.com>, <u-boot@lists.denx.de>, <srk@ti.com>
Subject: Re: [PATCH v2 1/2] usb: dwc3-generic: set "mode" based on caller of
 dwc3_generic_probe()
Message-ID: <4cgkdnpdn7j5tnfwvvskm3ltiqfnp5lx5gc5hwcrsljpg4bdin@hpkkswe4dej6>
References: <20241203093748.138260-1-s-vadapalli@ti.com>
 <20241203093748.138260-2-s-vadapalli@ti.com>
 <9254b268-2336-48ca-91de-9da34a93b467@kernel.org>
 <6hohujytkznjcemgu2cjhk2x5pxw7euwzojbt6ktji2yp6zft2@i77rsmzwfgj5>
 <5bd5c98c-530b-4f05-9fbc-e2d867be920a@kernel.org>
 <dj32jyfvxsds6wsax4tk7kw75zfiutggd5gfbwpklym7gifjih@awk6aerfjwl2>
 <6b4cb5ed-3d19-4fb2-aba7-90f0a0f4f4f0@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6b4cb5ed-3d19-4fb2-aba7-90f0a0f4f4f0@kernel.org>
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

On Wed, Dec 04, 2024 at 11:57:14AM +0200, Roger Quadros wrote:
> 
> 
> On 04/12/2024 09:47, Siddharth Vadapalli wrote:
> > On Wed, Dec 04, 2024 at 09:32:23AM +0200, Roger Quadros wrote:
> >>
> >>
> >> On 04/12/2024 07:16, Siddharth Vadapalli wrote:
> >>> On Tue, Dec 03, 2024 at 09:23:11PM +0200, Roger Quadros wrote:
> > 
> > [...]
> > 
> >>>>> +++ b/drivers/usb/dwc3/dwc3-generic.c
> >>>>> @@ -51,7 +51,8 @@ struct dwc3_generic_host_priv {
> >>>>>  };
> >>>>>  
> >>>>>  static int dwc3_generic_probe(struct udevice *dev,
> >>>>> -			      struct dwc3_generic_priv *priv)
> >>>>> +			      struct dwc3_generic_priv *priv,
> >>>>> +			      enum usb_dr_mode mode)
> >>>>
> >>>> This is not necessary as dwc3_generic_host_probe will only be
> >>>> registered if dr_mode == "host" and dwc3_generic_peripheral_probe
> >>>> will only be registered if dr_mode == "host" or "peripheral"
> >>>
> >>> But I don't see it happening that way. dwc3_generic_host_probe() or
> >>> dwc3_generic_peripheral_probe() seem to be invoked based on the command
> >>> executed - USB Host command will trigger generic_host_probe() while USB
> >>> Device/Gadget command will trigger generic_peripheral_probe().
> >>>
> >>
> >> But, when dr_mode is "otg" generic host driver is *not* bound to the
> >> DWC3 device. So dwc3_generic_host_probe() will never be called for it.
> > 
> > In USB DFU boot, "dwc3_generic_peripheral_boot()" is invoked. Please
> > test it out on AM625-SK. I was able to observe this on AM62A7-SK.
> 
> We do want dwc3_generic_peripheral_boot() to be invoked with dr_mode is "otg".
> As we still do not support dual-role switching in u-boot.
> 
> And you need that for DFU as well. Did I miss something?

You were mentioning that "dwc3_generic_host_probe()" will not be called,
but that is unrelated to the issue. I was pointing out that
"dwc3_generic_peripheral_probe()" is invoked, with plat->dr_mode set to
"otg" which currently results in PRTCAPDIR set to 11b which results in
the issue. So the patch aims to address this by setting mode based on
caller rather than using what is mentioned in the device-tree. This
should be in sync when "dr_mode" is either "host"/"peripheral", but in
the case of "otg", we run into issues which is fixed by this patch.

[...]

> >>> 2. dr_mode = "otg" results in the "PRTCAPDIR" field of the "GCTL"
> >>> register of the USB Controller being set to 11b. According to the
> >>> datasheet of the Designware USB Dual Role Controller, "PRTCAPDIR"
> >>> should never be set to any value other than 01b (Host) and 10b (Device).
> >>> Quoting the datasheet:
> >>> "Programming this field with random data causes the controller
> >>> to keep toggling between the host mode and the device mode."
> >>>
> >>> Therefore, in order to avoid programming 11b in "PRTCAPDIR", and, given
> >>> that the caller specifies the intended role, rather than simply using
> >>> the "dr_mode" property to set the role, set the role on the basis of the
> >>> caller (intended role) and the device-tree (platform support).
> >>> ----------------------------------------------------------------------------
> >>>
> >>> Point #2 above is the main reason why dr_mode cannot be set to "otg" in
> >>> dwc3_generic_probe(). The only difference now is that the check can be
> >>> dropped as you have indicated, so the last paragraph above will change
> >>
> >> Finally we are at the root of the problem. But the solution is not to
> >> change the dr_mode but instead handle it correctly in dwc3_core_init_mode()
> >>
> >> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> >> index a35b8c2f646..7f42b6e62c6 100644
> >> --- a/drivers/usb/dwc3/core.c
> >> +++ b/drivers/usb/dwc3/core.c
> >> @@ -752,13 +752,8 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
> >>  		}
> >>  		break;
> >>  	case USB_DR_MODE_OTG:
> >> -		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_OTG);
> >> -		ret = dwc3_host_init(dwc);
> >> -		if (ret) {
> >> -			dev_err(dwc->dev, "failed to initialize host\n");
> >> -			return ret;
> >> -		}
> >> -
> >> +		/* We don't support dual-role so restrict to Device mode */
> >> +		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_DEVICE);
> > 
> > But is this acceptable? Why not default to Host? I went through a series
> 
> I will let others chime in if it is acceptable or not.
> 
> > Why not default to host? 
> 
> Because we don't bind the generic_host driver at all when dr_mode = "otg".
> So XHCI driver will not be probed and host mode will not function.
> 
> > I went through a series
> > for defaulting OTG to Device for the Cadence Controller which was
> > objected at:
> > https://lore.kernel.org/r/62c5fe13-7f0e-e736-273e-31a8bbddbf13@kernel.org/
> > with the suggestion to use the cable to determine the role.
> > 
> 
> dual-role is a new feature for this driver in u-boot which can be added
> in the future if needed.
> The current problem is to get DFU/device mode to work when dr_mode is "otg".
> 
> As the dwc3-generic driver only registers the device controller when
> dr_mode is "otg" I don't see any other neater way to fix it than to
> limit the controller to device mode if dr_mode is "otg".

Why not do what this patch does? What is the issue with the current
patch (apart from the checks, which I could retain as well if others
wish so)? The caller clearly mentions the expected role, so why not use
that?

> 
> The only only other driver calling dwc3_init() is dwc3-layerscape.c. whose
> commit log states
> "OTG mode is not supported yet. The dr_mode in the devicetree will either
>  have to be set to peripheral or host."
> 
> Or you can go all the way and get the dual-role mode working the right way
> where you check user request along with cable status and allow/prevent a
> certain role.

The current patch seems to be an intermediate solution (actually, it
might be what should have been done when the code was first introduced
itself. Why use plat->dr_mode at all, except maybe to check if the
platform supports what is requested by the caller?)

Regards,
Siddharth.
