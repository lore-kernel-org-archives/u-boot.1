Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B561EC48BC4
	for <u-boot@archiver.kernel.org>; Sat, 17 Feb 2024 10:59:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF77487CF8;
	Sat, 17 Feb 2024 11:59:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="sOYFd8Ay";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57DB487DFA; Sat, 17 Feb 2024 11:59:10 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9568C87C9E
 for <u-boot@lists.denx.de>; Sat, 17 Feb 2024 11:59:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=4c2a=J2=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1708167522;
 bh=MHUeerPFf/toE3t0R5NTpHy4p/b9TQXbfw0vksRbcWU=;
 b=sOYFd8Ay1jNVvmgT1FshfxOeuUe5l4TgYQUIqyl8Nj8ODM18ToKTYqcixMBBz9lrZu1hA5D5S
 WCXTqyi1dXzK/sJf0pSIZErEK+k1fEo/9OCNEBe80zrvoZQgqCG4YJDSYqwer/tAx7hKU4eWYpW
 dAoPp/uuCBtTlo+sZNYfaMderbDDBURmHZ2MEUAnnK6LvalAW+Jj4M1IEiItCz8lqzqiSknp2W6
 ozESDuaozRBjqvKS0jalEPbukiHzLJ4eMaS9MVdkB9Gp7s5xVTYT0BF6Kh/xo/WaOztpKtMr29u
 t8QaSO8PhqADcWZ6SlBU5B9iEwluB3Gmp+ZPpf8Q8ZYQ==
Message-ID: <3509a1d6-8935-4824-8fcd-832e201580b5@kwiboo.se>
Date: Sat, 17 Feb 2024 11:58:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/39] usb: dwc3-generic: support external vbus
 regulator
Content-Language: en-US
To: Caleb Connolly <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>, Sumit
 Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>, Dzmitry
 Sankouski <dsankouski@gmail.com>, Peng Fan <peng.fan@nxp.com>, Jaehoon
 Chung <jh80.chung@samsung.com>, Rayagonda Kokatanur
 <rayagonda.kokatanur@broadcom.com>, Lukasz Majewski <lukma@denx.de>, Sean
 Anderson <seanga2@gmail.com>, "Jorge Ramirez-Ortiz"
 <jorge.ramirez.ortiz@gmail.com>, Stephan Gerhold <stephan@gerhold.net>
References: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
 <20240215-b4-qcom-common-target-v4-2-ed06355c634a@linaro.org>
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240215-b4-qcom-common-target-v4-2-ed06355c634a@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65d091628fb73e66318e1956
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

On 2024-02-15 21:52, Caleb Connolly wrote:
> Add support for a vbus-supply regulator specified in devicetree. This
> provides generic support to avoid hardcoded GPIO configuration in board
> init code.
> 
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
> This patch has no dependencies
> 
> Cc: Marek Vasut <marex@denx.de>
> ---
>  drivers/usb/dwc3/dwc3-generic.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
> index 6fb2de8a5ace..48da621ba966 100644
> --- a/drivers/usb/dwc3/dwc3-generic.c
> +++ b/drivers/usb/dwc3/dwc3-generic.c
> @@ -21,6 +21,7 @@
>  #include <linux/usb/ch9.h>
>  #include <linux/usb/gadget.h>
>  #include <malloc.h>
> +#include <power/regulator.h>
>  #include <usb.h>
>  #include "core.h"
>  #include "gadget.h"
> @@ -47,6 +48,7 @@ struct dwc3_generic_priv {
>  struct dwc3_generic_host_priv {
>  	struct xhci_ctrl xhci_ctrl;
>  	struct dwc3_generic_priv gen_priv;
> +	struct udevice *vbus_dev;

vbus_supply may be a better name, it is a name used by other drivers.

>  };
>  
>  static int dwc3_generic_probe(struct udevice *dev,
> @@ -240,6 +242,13 @@ static int dwc3_generic_host_probe(struct udevice *dev)
>  	if (rc)
>  		return rc;
>  
> +	rc = device_get_supply_regulator(dev, "vbus-supply", &priv->vbus_dev);
> +	if (rc)
> +		debug("%s: No vbus regulator found: %d\n", dev->name, rc);
> +
> +	if (priv->vbus_dev)
> +		regulator_set_enable(priv->vbus_dev, true);

This should use the following form:

	rc = regulator_set_enable_if_allowed(priv->vbus_supply, true);
	if (rc && rc != -ENOSYS)
		return rc;

That should only report an error if there is an error enabling the
regulator, or -ENOSYS if regulator support has been disabled.

Because fixed and gpio regulators now are referenced counted you will
need to clean up and disable the supply if the call to xhci_register()
fails, something like following should probably work:

	rc = xhci_register(dev, hccr, hcor);
	if (rc)
		regulator_set_enable_if_allowed(priv->vbus_supply, false);

	return rc;

> +
>  	hccr = (struct xhci_hccr *)priv->gen_priv.base;
>  	hcor = (struct xhci_hcor *)(priv->gen_priv.base +
>  			HC_LENGTH(xhci_readl(&(hccr)->cr_capbase)));
> @@ -256,6 +265,9 @@ static int dwc3_generic_host_remove(struct udevice *dev)
>  	if (rc)
>  		return rc;
>  
> +	if (priv->vbus_dev)
> +		regulator_set_enable(priv->vbus_dev, false);

This can safely use the following without any if check:

	regulator_set_enable_if_allowed(priv->vbus_supply, false);

Regards,
Jonas

> +
>  	return dwc3_generic_remove(dev, &priv->gen_priv);
>  }
>  
> 

