Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 920BED69108
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 13:10:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02DE1893D0;
	Thu, 28 Nov 2024 14:10:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SOCpZk3p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C853289CF4; Thu, 28 Nov 2024 14:10:36 +0100 (CET)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85BDB893A3
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 14:10:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id E384AA43BA2;
 Thu, 28 Nov 2024 13:08:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADBE3C4CECE;
 Thu, 28 Nov 2024 13:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1732799433;
 bh=ApJuxzjfZ9XoMjAu2TKrd2QetarJcu01EaEhnEJxK5E=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=SOCpZk3pUn3hUIoFC40insIxaxrbSjqn5ZndcE7kg0AqUV1fL0/DS8Jf4ntcyKNrH
 adqSCKXY6B76MSmMp77hQDql8nBAqaAh16d7FNtylw4/mdlclSlZsRDRp4O4jsmkyA
 dc51F564ohcNF3l5deDsySXKTU/G1BUYrMYRv8CH1Ve6RQykD1h4q073xCqh9SaZpk
 PdDlRIussckWFdLskYqLOh1+yJEb+xbdmG+e9BPK/xGQ9fryhkjTcw1Qf31MYLW89I
 4sDhra4OJQ6GuWPpbWAJHMqsUXvF9bLS4oAt+y6AHCaUCQzkATPKOM03gdUBXZxcz0
 udsMmjLDX6Arg==
Message-ID: <f4c4cb82-0e8c-49a1-aff0-2c539f15047d@kernel.org>
Date: Thu, 28 Nov 2024 15:10:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] usb: dwc3-generic: set "mode" based on caller of
 dwc3_generic_probe()
To: Siddharth Vadapalli <s-vadapalli@ti.com>, vigneshr@ti.com, bb@ti.com,
 trini@konsulko.com, marex@denx.de, hnagalla@ti.com,
 mkorpershoek@baylibre.com, caleb.connolly@linaro.org,
 neil.armstrong@linaro.org, jan.kiszka@siemens.com, jonas@kwiboo.se,
 j-humphreys@ti.com, nm@ti.com, devarsht@ti.com, ilias.apalodimas@linaro.org
Cc: u-boot@lists.denx.de, srk@ti.com
References: <20241126120322.1760862-1-s-vadapalli@ti.com>
 <20241126120322.1760862-2-s-vadapalli@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20241126120322.1760862-2-s-vadapalli@ti.com>
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



On 26/11/2024 14:03, Siddharth Vadapalli wrote:
> There are only two callers of "dwc3_generic_probe()", namely:
> 1. dwc3_generic_peripheral_probe()
> 2. dwc3_generic_host_probe()
> Currently, the "mode" is set based on the device-tree node of the
> platform device. Also, the DWC3 core doesn't support updating the "mode"
> dynamically at runtime if it is set to "OTG", i.e. "OTG" is treated as a
> separate mode in itself, rather than being treated as a mode which should
> eventually lead to "host"/"peripheral".
> 
> Given that the callers of "dwc3_generic_probe()" clarify the expected
> "mode" of the USB Controller, use that "mode" instead of the one
> specified in the device-tree. This shall allow the USB Controller to
> function both as a "Host" and as a "Peripheral" when the "mode" is "otg"
> in the device-tree, based on the caller of "dwc3_generic_probe()".
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
>  drivers/usb/dwc3/dwc3-generic.c | 9 +++++----

TI AM62a is not even using this driver so how did you test this?
Did I miss a DT patch?

>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
> index 2ab41cbae45..55e62b35c61 100644
> --- a/drivers/usb/dwc3/dwc3-generic.c
> +++ b/drivers/usb/dwc3/dwc3-generic.c
> @@ -51,7 +51,8 @@ struct dwc3_generic_host_priv {
>  };
>  
>  static int dwc3_generic_probe(struct udevice *dev,
> -			      struct dwc3_generic_priv *priv)
> +			      struct dwc3_generic_priv *priv,
> +			      enum usb_dr_mode mode)
>  {
>  	int rc;
>  	struct dwc3_generic_plat *plat = dev_get_plat(dev);
> @@ -62,7 +63,7 @@ static int dwc3_generic_probe(struct udevice *dev,
>  
>  	dwc3->dev = dev;
>  	dwc3->maximum_speed = plat->maximum_speed;
> -	dwc3->dr_mode = plat->dr_mode;
> +	dwc3->dr_mode = mode;

if platform supported mode was "host" only or "peripheral" only
then you shouldn't we prevent from using the other role?

In u-boot shell, if user starts Host driver first and then starts peripheral driver
how does it work?
Did you test this case?

>  #if CONFIG_IS_ENABLED(OF_CONTROL)
>  	dwc3_of_parse(dwc3);
>  
> @@ -197,7 +198,7 @@ static int dwc3_generic_peripheral_probe(struct udevice *dev)
>  {
>  	struct dwc3_generic_priv *priv = dev_get_priv(dev);
>  
> -	return dwc3_generic_probe(dev, priv);
> +	return dwc3_generic_probe(dev, priv, USB_DR_MODE_PERIPHERAL);
>  }
>  
>  static int dwc3_generic_peripheral_remove(struct udevice *dev)
> @@ -241,7 +242,7 @@ static int dwc3_generic_host_probe(struct udevice *dev)
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

