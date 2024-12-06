Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED421E77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 07:19:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 199D88929F;
	Fri,  6 Dec 2024 08:19:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="kRdtxWBa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 990368932A; Fri,  6 Dec 2024 08:19:17 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 637F88926F
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 08:19:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4B67J7Ul2040729
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 6 Dec 2024 01:19:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1733469547;
 bh=unPLR5sWdMSH1KdZtoGoFB7y0vbQR9ArsumWQW2e168=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=kRdtxWBaKhTwerEEUbuidqQvunaNR8DJzi2RYjPRiBfdXnJ09CEhlNzi9Uu2nEB0p
 Fqo4TKqFHyQRCynIpjAu/tsrR8kQEkQwUaUnpjvHqr3LrjBpU5KRwPPGKjF+2wk4xj
 LOkjIlxE3EVy/xAOS6GzBTF8l+lmqkKAoMLtA55c=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B67J7xo000781;
 Fri, 6 Dec 2024 01:19:07 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 6
 Dec 2024 01:19:07 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 6 Dec 2024 01:19:07 -0600
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.81])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B67J6sc042295;
 Fri, 6 Dec 2024 01:19:06 -0600
Date: Fri, 6 Dec 2024 12:49:05 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Roger Quadros <rogerq@kernel.org>
CC: Tom Rini <trini@konsulko.com>, Martyn Welch <martyn.welch@collabora.com>, 
 Sjoerd Simons <sjoerd@collabora.com>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, <marex@denx.de>,
 <vigneshr@ti.com>, <nm@ti.com>, <j-humphreys@ti.com>,
 <s-vadapalli@ti.com>, <srk@ti.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH] configs: am62x_evm_*: Fix USB DFU configuration
Message-ID: <unf757pwgah5ylkcfdumtdo5zs2ny3nxct5u26t6up7aldqim2@mxhhtb53gw4x>
References: <20241203-am62-usb-xhci-v1-1-a791cb914186@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241203-am62-usb-xhci-v1-1-a791cb914186@kernel.org>
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

On Tue, Dec 03, 2024 at 10:40:29PM +0200, Roger Quadros wrote:

Hello Roger,

> CONFIG_USB_XHCI_DWC3 is not required for AM62x as the XHCI
> driver is registered through the dwc3-generic driver.
> 
> CONFIG_USB_XHCI_DWC3 causes problems by hijacking the
> USB controller even if it is not set for Host mode in
> device tree.
> 
> 'dm tree' output after 'usb start' is fixed from
> 
>  simple_bus    5  [ + ]   dwc3-am62             |   |-- dwc3-usb@f900000
>  usb_gadget    0  [   ]   dwc3-generic-periphe  |   |   |-- usb@31000000
>  usb           0  [ + ]   xhci-dwc3             |   |   `-- usb@31000000
>  usb_hub       0  [ + ]   usb_hub               |   |       `-- usb_hub
>  simple_bus    6  [ + ]   dwc3-am62             |   |-- dwc3-usb@f910000
>  usb           1  [ + ]   dwc3-generic-host     |   |   |-- usb@31100000
>  usb_hub       1  [ + ]   usb_hub               |   |   |   `-- usb_hub
>  usb           1  [ + ]   xhci-dwc3             |   |   `-- usb@31100000
>  usb_hub       2  [ + ]   usb_hub               |   |       `-- usb_hub
> 
> [notice that 'xhci-dwc3' and 'usb_hub' drivers are probed
>  for both USB instances although the first instance
>  is supposed to be 'peripheral' only]
> 
> to
> 
>  simple_bus    5  [   ]   dwc3-am62             |   |-- dwc3-usb@f900000
>  usb_gadget    0  [   ]   dwc3-generic-periphe  |   |   `-- usb@31000000
>  simple_bus    6  [ + ]   dwc3-am62             |   |-- dwc3-usb@f910000
>  usb           1  [ + ]   dwc3-generic-host     |   |   `-- usb@31100000
>  usb_hub       0  [ + ]   usb_hub               |   |       `-- usb_hub

While this fixes the issue, I am wondering if the issue lies elsewhere.
In U-Boot, the compatible "snps,dwc3" is associated with:
drivers/usb/host/xhci-dwc3.c
while in Linux, the compatible "snps,dwc3" is associated with:
drivers/usb/dwc3/core.c

So there seem to be two alternatives that I could think of:
1. Modify U-Boot to match Linux in the sense that we associate
"snps,dwc3" with drivers/usb/dwc3/core.c in U-Boot.
2. With the understanding that "dr_mode" doesn't have to be host/otg for
the compatible "snps,dwc3" which is tied to drivers/usb/host/xhci-dwc3.c,
do the following to exit probe when "dr_mode" is "peripheral":
-------------------------------------------------------------------------
diff --git a/drivers/usb/host/xhci-dwc3.c b/drivers/usb/host/xhci-dwc3.c
index e3e0ceff43e..edfd7b97a73 100644
--- a/drivers/usb/host/xhci-dwc3.c
+++ b/drivers/usb/host/xhci-dwc3.c
@@ -208,6 +208,8 @@ static int xhci_dwc3_probe(struct udevice *dev)
        writel(reg, &dwc3_reg->g_usb2phycfg[0]);

        dr_mode = usb_get_dr_mode(dev_ofnode(dev));
+       if (dr_mode == USB_DR_MODE_PERIPHERAL)
+               return -ENODEV;
        if (dr_mode == USB_DR_MODE_OTG &&
            dev_read_bool(dev, "usb-role-switch")) {
                dr_mode = usb_get_role_switch_default_mode(dev_ofnode(dev));
-------------------------------------------------------------------------
which will still show "xhci-dwc3" in the output of "dm tree" after "usb
start", but the driver won't be probed (absence of "+" in the "Probed"
column of "dm tree" output).

I just wanted to point this out as a possible fix for other scenarios.
Disabling "CONFIG_USB_XHCI_DWC3" seems to be the best choice in the
current scenario (i.e. it shouldn't have been set in "USB DFU" fragment
to begin with).

> 
> Fixes: dfc2dff5a844 ("configs: am62x_evm_*: Enable USB and DFU support")
> Signed-off-by: Roger Quadros <rogerq@kernel.org>

Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>

> ---
>  configs/am62x_a53_usbdfu.config | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/configs/am62x_a53_usbdfu.config b/configs/am62x_a53_usbdfu.config
> index 3a19cf23287..0d3c6df1e73 100644
> --- a/configs/am62x_a53_usbdfu.config
> +++ b/configs/am62x_a53_usbdfu.config
> @@ -16,7 +16,6 @@ CONFIG_USB=y
>  CONFIG_DM_USB_GADGET=y
>  CONFIG_SPL_DM_USB_GADGET=y
>  CONFIG_USB_XHCI_HCD=y
> -CONFIG_USB_XHCI_DWC3=y
>  CONFIG_USB_DWC3=y
>  CONFIG_USB_DWC3_GENERIC=y
>  CONFIG_SPL_USB_DWC3_GENERIC=y
> 
> ---
> base-commit: 3073246d1be682071d8b3d07d06c2484907aed60
> change-id: 20241203-am62-usb-xhci-be62bc9584c9
> 
> Best regards,
> -- 
> Roger Quadros <rogerq@kernel.org>
> 
