Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9B93E7717D
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 12:59:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF2CB88D72;
	Mon,  9 Dec 2024 13:59:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="TjqmZehz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D769E893B1; Mon,  9 Dec 2024 13:59:55 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 949F688D72
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 13:59:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4B9CxfLq2768786
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Dec 2024 06:59:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1733749181;
 bh=BvAz1fc3FjFIlYOqqNvZEuS0OynAloPPyIWc1aY2vcQ=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=TjqmZehznyOx7vQOUczPq5KwR7CmICGPNz5kfdYW+hPg31u53njb0mVAirY5xzBMK
 o+72av3Olb4zAP/9jY49OgBAKrGCaDUcFLwUmMLfR+6SL97epSw92p4EjNmCMdZxiE
 RadWCodpm7JQDo2zyYPL9YJHBRG5Im0JP/Ls8M50=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4B9Cxf8n061125
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 9 Dec 2024 06:59:41 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 9
 Dec 2024 06:59:40 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 9 Dec 2024 06:59:40 -0600
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.81])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B9CxdW4056003;
 Mon, 9 Dec 2024 06:59:40 -0600
Date: Mon, 9 Dec 2024 18:29:38 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Roger Quadros <rogerq@kernel.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, Tom Rini <trini@konsulko.com>,
 Martyn Welch <martyn.welch@collabora.com>, Sjoerd Simons
 <sjoerd@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, <marex@denx.de>,
 <vigneshr@ti.com>, <nm@ti.com>, <j-humphreys@ti.com>, <srk@ti.com>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH] configs: am62x_evm_*: Fix USB DFU configuration
Message-ID: <yjd6rzbuwd7465fv7xuh4d5b457onx3v5hg5cyhmouqbnmtdju@xk5oysy3itlr>
References: <20241203-am62-usb-xhci-v1-1-a791cb914186@kernel.org>
 <unf757pwgah5ylkcfdumtdo5zs2ny3nxct5u26t6up7aldqim2@mxhhtb53gw4x>
 <d103c8e4-d599-4c75-9239-11e7e8adf6e9@kernel.org>
 <a9c458f8-68e5-448b-9977-e7bf37b00d35@kernel.org>
 <subjsndbckmj5kgcy6dkh4av5abxkeufjqibwjbom267yotj2a@id3kbhlg2dc7>
 <581a7ace-8d42-405f-bba6-755024cd76a3@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <581a7ace-8d42-405f-bba6-755024cd76a3@kernel.org>
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

On Mon, Dec 09, 2024 at 02:32:37PM +0200, Roger Quadros wrote:

Hello Roger,

> On 06/12/2024 12:07, Siddharth Vadapalli wrote:

[...]

> > Looking at the list of compatibles in dwc3-generic.c and focusing on the
> > compatible "ti,keystone-dwc3", I see that this compatible is present in:
> > dts/upstream/src/arm/ti/keystone/keystone.dtsi
> > among other keystone device-tree files. The hierarchy of the nodes and
> > compatibles for the USB Subsystem and the USB Controller in Keystone is
> > similar to that of AM62*. The difference however is the following:
> > A) For non AM62* devices:
> 
> note there are 2 cases here:
> 
> A1) that enable CONFIG_USB_DWC3_GENERIC
> 
> > 	USB Subsystem [Wrapper] driver is dwc3-generic.c
> Yes.
> 
> > 		USB Controller [DWC3] driver is xhci-dwc3.c
> 
> No.
> 
> Note that none of the platforms that enable CONFIG_USB_DWC3_GENERIC
> enable CONFIG_USB_XHCI_DWC3. They should not because dwc3-generic.c
> takes care of registering the XHCI driver via xhci_register/deregister()

Thank you for pointing this out.

> 
> A2) that don't enable CONFIG_USB_DWC3_GENERIC
> 
> These are usually only interested in host mode, they enable
> CONFIG_USB_XHCI_DWC3 and may also enable CONFIG_USB_XHCI_DWC3_OF_SIMPLE
> 
> So  USB Wrapper/glue driver is DWC3_OF_SIMPLE
> 	USB driver is xhci-dwc3.c
> 
> Some platforms have their own glue
> 	CONFIG_USB_XHCI_STI	dwc3-sti-glue.c
> 	CONFIG_USB_XHCI_OCTEON	dwc3-octeon-glue.c
> 
> > B) For AM62* devices:
> > 	USB Subsystem [Wrapper] driver is dwc3-am62.c
> > 	which exposes its own ".glue_configure" callback similar to what
> > 	is done in dwc3-generic.c for other devices.
> 
> The Subsystem driver is still dwc3-generic.c. Glue driver is dwc3-am62.c
> 
> > 		USB Controller [DWC3] driver is xhci-dwc3.c
> 
> No.
> We don't require CONFIG_USB_XHCI_DWC3 as XHCI registration is done
> by dwc3-generic. USB Host driver is USB_XHCI_HCD.

Ok.

> 
> > So maybe non AM62* devices have:
> > 	dwc3-generic.c for Subsystem + xhci-dwc3.c for USB Controller
> > while AM62* devices have:
> > 	dwc3-am62.c for Subsystem + dwc3-generic.c (neither Subsystem
> > 	nor Controller?) + xhci-dwc3.c for USB Controller
> > We could probably end up with the two driver situation similar to non
> > AM62* devices if we update dwc3-generic.c to handle the configuration
> > performed by dwc3-am62.c. But that still means we have two drivers:
> > dwc3-generic.c and xhci-dwc3.c
> > Maybe viewing the output of "dm tree" on a non AM62* device with both
> > CONFIG_USB_XHCI_DWC3 and CONFIG_USB_DWC3_GENERIC enabled will let us
> > know whether that is a valid configuration or not.
> 
> Enabling both is an invalid configuration and no config does it. AM62 was
> doing it wrong and so we fix it with this patch.

Understood. Thank you for explaining. I agree that the fix in this patch
is correct and your earlier suggestion of Kconfig guards:
"Maybe we still need some Kconfig guards that prevent both
CONFIG_USB_XHCI_DWC3 and USB_DWC3_GENERIC to be set together as 2 drivers
will claim the controller if dr_mode is USB_DR_MODE_OTG or
USB_DR_MODE_HOST."
could be implemented in a follow up patch.

Regards,
Siddharth.
