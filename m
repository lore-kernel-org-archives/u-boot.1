Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14BF5C021B8
	for <u-boot@archiver.kernel.org>; Sat,  1 Mar 2025 07:45:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E68E80FE1;
	Sat,  1 Mar 2025 08:45:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="A8EX//xN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB4408118B; Sat,  1 Mar 2025 08:45:30 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50D5B810F6
 for <u-boot@lists.denx.de>; Sat,  1 Mar 2025 08:45:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 5217jQ7l2257681
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 1 Mar 2025 01:45:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1740815126;
 bh=flfXgXhfORp9CpcCL6aiPDsjJQfm2zg1r+U4/bELYME=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=A8EX//xN2iAnBg2yf1zQmNkGK+OPOC/PU2T1OSrzLu9CHZFdUnNViDRA/xHhS2Yp1
 LZuwFc9Pb/4scB8HKZ5G9drk0VvimHZ9avtbEi0lMJ0KrBeYc2vEhsqu529ewXPqPu
 XKpLwdLWSmptd18TwTkx8rBC2DLhupnq+yqyv16M=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 5217jQuG024685
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 1 Mar 2025 01:45:26 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 1
 Mar 2025 01:45:25 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 1 Mar 2025 01:45:25 -0600
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.113])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5217jOOx097922;
 Sat, 1 Mar 2025 01:45:25 -0600
Date: Sat, 1 Mar 2025 13:15:24 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Jon Humphreys <j-humphreys@ti.com>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <trini@konsulko.com>,
 <u-boot@lists.denx.de>, <srk@ti.com>
Subject: Re: [PATCH 1/2] configs: am62x_r5: introduce fragment for USB MSC boot
Message-ID: <20250301074524.344wlatipbfb7sea@uda0492258>
References: <20250226103504.1841697-1-s-vadapalli@ti.com>
 <20250226103504.1841697-2-s-vadapalli@ti.com>
 <86eczhlg65.fsf@udb0321960.dhcp.ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <86eczhlg65.fsf@udb0321960.dhcp.ti.com>
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

On Fri, Feb 28, 2025 at 06:59:14PM -0600, Jon Humphreys wrote:

Hello Jon,

> Siddharth Vadapalli <s-vadapalli@ti.com> writes:
> 
> > Introduce the config fragment for enabling USB MSC boot. USB MSC boot
> > involves fetching the next stage of the bootloader from a USB Mass Storage
> > device such as a USB Flash Drive with the USB controller on the SoC acting
> > as the USB Host.
> >
> > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > ---
> >  configs/am62x_r5_usbmsc.config | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >  create mode 100644 configs/am62x_r5_usbmsc.config
> >
> > diff --git a/configs/am62x_r5_usbmsc.config b/configs/am62x_r5_usbmsc.config
> > new file mode 100644
> > index 0000000000..2ce6afb662
> > --- /dev/null
> > +++ b/configs/am62x_r5_usbmsc.config
> > @@ -0,0 +1,22 @@
> > +CONFIG_USB=y
> > +CONFIG_SPL_USB_HOST=y
> > +CONFIG_SPL_SYSCON=y
> > +CONFIG_SPL_MISC=y
> > +CONFIG_USB_XHCI_HCD=y
> > +CONFIG_USB_GADGET=y
> > +CONFIG_SPL_USB_GADGET=y
> > +CONFIG_USB_DWC3=y
> > +CONFIG_SPL_USB_DWC3_GENERIC=y
> > +CONFIG_SPL_USB_DWC3_AM62=y
> > +CONFIG_SPL_USB_STORAGE=y
> 
> Hi Siddharth,
> 
> You either need to set CONFIG_USB_STORAGE as well in
> am62x_r5_usbmsc.config, or otherwise modify usb.h to include the
> declaration of usb_stor_info().
> 
> Eg use:
> 
> #if defined CONFIG_SPL_USB_STORAGE || defined CONFIG_USB_STORAGE
> 
> instead of
> 
> #ifdef CONFIG_USB_STORAGE
> 
> See the build log:
> 
> spl_usb.c:41:29: error: implicit declaration of function usb_stor_scan

Thank you for reviewing the patch and pointing this out. I will enable
CONFIG_USB_STORAGE in am62x_r5_usbmsc.config to fix this and post the v2
series.

Regards,
Siddharth.
