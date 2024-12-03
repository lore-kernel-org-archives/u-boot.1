Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E80B4E74ACA
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 19:23:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19DEB89655;
	Tue,  3 Dec 2024 20:23:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="m9zbFoVK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1742D8965A; Tue,  3 Dec 2024 20:23:21 +0100 (CET)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9169288E78
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 20:23:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 3A07DA40C0D;
 Tue,  3 Dec 2024 19:21:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2797BC4CECF;
 Tue,  3 Dec 2024 19:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1733253797;
 bh=0LAKjnWIEuounVDW3CXejYK4vFxILzVbv/RR3hQLccY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=m9zbFoVKQJ8xHmYC0P2v08jeB9oXZ6OQ+mYs3oA9e7uDqVEACsLL3Ea1sQU8b4fJP
 9zfW5KBR3x+G/ueVgdJP+rXFKU439vOKzWaB7/U9t3lFBgDU9z8zCbOGLFlNNSK/Zk
 w7qkZiVXwOzaL4+br85m1mDu3OFR2SRNzbjgoYPd+iZwNmhVHc6Vc2mGCtMGKg4opr
 DcM2r44cK7DCmfJUQXdtUgcpw8p75KO2kj5XWkNP2BpbH42zu7Re9bj33N3k9IGR5o
 u3PtAh/B3i/kt5DpnIHny91VDyfID7mOELbuTae3yk8GtMynuipS3oKaw+P0GOmRF5
 cZPgUeVDfaRXw==
Message-ID: <9254b268-2336-48ca-91de-9da34a93b467@kernel.org>
Date: Tue, 3 Dec 2024 21:23:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] usb: dwc3-generic: set "mode" based on caller of
 dwc3_generic_probe()
To: Siddharth Vadapalli <s-vadapalli@ti.com>, vigneshr@ti.com, bb@ti.com,
 trini@konsulko.com, marex@denx.de, hnagalla@ti.com,
 mkorpershoek@baylibre.com, caleb.connolly@linaro.org,
 neil.armstrong@linaro.org, jan.kiszka@siemens.com, j-humphreys@ti.com,
 nm@ti.com
Cc: u-boot@lists.denx.de, srk@ti.com
References: <20241203093748.138260-1-s-vadapalli@ti.com>
 <20241203093748.138260-2-s-vadapalli@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20241203093748.138260-2-s-vadapalli@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Siddharth,


On 03/12/2024 11:37, Siddharth Vadapalli wrote:
> There are only two callers of "dwc3_generic_probe()", namely:
> 1. dwc3_generic_peripheral_probe()
> 2. dwc3_generic_host_probe()
> Currently, the "mode" is set based on the device-tree node of the
> platform device. Also, the DWC3 core doesn't support updating the "mode"
> dynamically at runtime if it is set to "OTG", i.e. "OTG" is treated as a
> separate mode in itself, rather than being treated as a mode which should
> eventually lead to "host"/"peripheral".

Actually this is not entirely true. Sorry for not catching this earlier.
I did a deep dive today to debug why XHCI is being registered for both ports on am62.

I see that configs/am62x_a53_usbdfu.config is setting CONFIG_USB_XHCI_DWC3.
This is wrong. It should not be used for AM62x platform.

Also.

Please see dwc3_glue_bind_common().

        if (CONFIG_IS_ENABLED(DM_USB_GADGET) &&
            (dr_mode == USB_DR_MODE_PERIPHERAL || dr_mode == USB_DR_MODE_OTG)) {
                printf("%s: dr_mode: OTG or Peripheral\n", __func__);
                driver = "dwc3-generic-peripheral";
        } else if (CONFIG_IS_ENABLED(USB_HOST) && dr_mode == USB_DR_MODE_HOST) {
                printf("%s: dr_mode: HOST\n", __func__);
                driver = "dwc3-generic-host";
        } else {
                printf("%s: unsupported dr_mode %d\n", __func__, dr_mode);
                return -ENODEV;
        }

        ret = device_bind_driver_to_node(parent, driver, name,
                                         node, &dev);
        if (ret) {


So if dr_mode is "otg" it will be bound to dwc3-generic-peripheral driver only.
I verified that even if I change dr_mode from "peripheral" to "otg" DFU mode
does work from u-boot shell.

Which makes my suggestions for checking dr_mode during and your patch seem unnecessary.

What is not clear though is, why is DFU mode not working for you. At which stage
DFU is failing? R5 SPL/A53 SPL?

Can you please try disabling CONFIG_USB_XHCI_DWC3 in all configs as it will
hijack the controller exclusively for host mode.

> 
> Given that the callers of "dwc3_generic_probe()" clarify the expected
> "mode" of the USB Controller, use that "mode" instead of the one
> specified in the device-tree. This shall allow the USB Controller to
> function both as a "Host" and as a "Peripheral" when the "mode" is "otg"
> in the device-tree, based on the caller of "dwc3_generic_probe()".
> 
> Ideally, the USB ID pin should be used to determine whether or not the
> requested role can be enabled. However, that can be implemented in the
> future as an incremental feature over the current implementation.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
> 
> v1:
> https://patchwork.ozlabs.org/project/uboot/list/?series=434253&state=%2A&archive=both
> Changes since v1:
> - Based on the feedback received on the v1 series, the device-tree
>   specified role is also taken into account in dwc3_generic_probe(), in
>   addition to the caller of dwc3_generic_probe().
> 
>  drivers/usb/dwc3/dwc3-generic.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
> index 2ab41cbae45..fe98b50c42c 100644
> --- a/drivers/usb/dwc3/dwc3-generic.c
> +++ b/drivers/usb/dwc3/dwc3-generic.c
> @@ -51,7 +51,8 @@ struct dwc3_generic_host_priv {
>  };
>  
>  static int dwc3_generic_probe(struct udevice *dev,
> -			      struct dwc3_generic_priv *priv)
> +			      struct dwc3_generic_priv *priv,
> +			      enum usb_dr_mode mode)

This is not necessary as dwc3_generic_host_probe will only be
registered if dr_mode == "host" and dwc3_generic_peripheral_probe
will only be registered if dr_mode == "host" or "peripheral"

>  {
>  	int rc;
>  	struct dwc3_generic_plat *plat = dev_get_plat(dev);
> @@ -62,7 +63,19 @@ static int dwc3_generic_probe(struct udevice *dev,
>  
>  	dwc3->dev = dev;
>  	dwc3->maximum_speed = plat->maximum_speed;
> -	dwc3->dr_mode = plat->dr_mode;
> +
> +	/*
> +	 * If the controller supports OTG as indicated by plat->dr_mode,
> +	 * then either Host or Peripheral mode is acceptable.
> +	 * Otherwise, error out since the platform cannot support the mode
> +	 * being requested by the caller of dwc3_generic_probe().
> +	 */
> +	if (plat->dr_mode != mode && plat->dr_mode != USB_DR_MODE_OTG) {
> +		pr_err("Requested usb mode is not supported by platform\n");

This is actually not necessary. Sorry for suggesting this approach before.

> +		return -EINVAL;
> +	}
> +	dwc3->dr_mode = mode;
> +
>  #if CONFIG_IS_ENABLED(OF_CONTROL)
>  	dwc3_of_parse(dwc3);
>  
> @@ -197,7 +210,7 @@ static int dwc3_generic_peripheral_probe(struct udevice *dev)
>  {
>  	struct dwc3_generic_priv *priv = dev_get_priv(dev);
>  
> -	return dwc3_generic_probe(dev, priv);
> +	return dwc3_generic_probe(dev, priv, USB_DR_MODE_PERIPHERAL);
>  }
>  
>  static int dwc3_generic_peripheral_remove(struct udevice *dev)
> @@ -241,7 +254,7 @@ static int dwc3_generic_host_probe(struct udevice *dev)
>  	struct dwc3_generic_host_priv *priv = dev_get_priv(dev);
>  	int rc;
>  
> -	rc = dwc3_generic_probe(dev, &priv->gen_priv);
> +	rc = dwc3_generic_probe(dev, &priv->gen_priv, USB_DR_MODE_HOST);
>  	if (rc)
>  		return rc;
>  

-- 
cheers,
-roger

