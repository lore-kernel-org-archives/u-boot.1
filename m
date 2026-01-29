Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EC0FD46C01
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 00:37:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E53A83C91;
	Thu, 29 Jan 2026 01:37:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="U5GvTVz1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43A1583CDF; Thu, 29 Jan 2026 01:37:19 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44F7683B91
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 01:37:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4f1gFl2KJsz9tnZ;
 Thu, 29 Jan 2026 01:37:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769647035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1OfgsuQigzGFt0ueMjOG3oojSisBu4NPp9xkgYPgxlA=;
 b=U5GvTVz1neaEQrbaTUFRMyTpd5WBog+oQcBfa6MA7Wf/2JQEfNAAnwyKoOpKDus+JjEs6E
 0O+FVbr8qmSFhsIVR2FEdLioIWn4Kaa9JzP6m2Aqv/ZqdyQcEPSfkA7oG3UYwar+Nmz9VH
 6p+Jejt2xS851yhss38ntt/R+EX4PsrJZRj7dUFG90OIaYy8oS9Mu9ryQ7124ULXk9n1tG
 y9zWic80AoG12XfNnL3YKK4Rzgni8O2iPMfFglzpxqDAkzCza5VMzSrx2QgwEAHchHWzIn
 B9dl5TmWN7OrV9DfIhni9IZHnYbVtrHg12aX1gOyiF1+mJwvAePKZLT8/Xh+Nw==
Message-ID: <854dcb2b-e29f-4925-ac17-795320486bff@mailbox.org>
Date: Thu, 29 Jan 2026 01:27:45 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] usb: gadget: dwc2: Move dr_mode check from of_to_plat()
 to bind()
To: Jonas Karlman <jonas@kwiboo.se>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20260128225057.1699019-1-jonas@kwiboo.se>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260128225057.1699019-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: aac2ed51142bdeebeee
X-MBO-RS-META: h8rructark6due4h14bqrenmxh4ce6tw
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

On 1/28/26 11:50 PM, Jonas Karlman wrote:

> +static int dwc2_udc_otg_bind(struct udevice *dev)
> +{
> +	enum usb_dr_mode dr_mode = usb_get_dr_mode(dev_ofnode(dev));
> +
> +	if (dr_mode != USB_DR_MODE_PERIPHERAL && dr_mode != USB_DR_MODE_OTG) {
> +		dev_dbg(dev, "Invalid mode\n");

Please print the mode while at it.

> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
>   static int dwc2_gadget_handle_interrupts(struct udevice *dev)
>   {
>   	return dwc2_udc_handle_interrupt();
> @@ -1186,6 +1192,7 @@ U_BOOT_DRIVER(dwc2_udc_otg) = {
>   	.of_match = dwc2_udc_otg_ids,
>   	.ops	= &dwc2_gadget_ops,
>   	.of_to_plat = dwc2_udc_otg_of_to_plat,
> +	.bind = dwc2_udc_otg_bind,
>   	.probe = dwc2_udc_otg_probe,
>   	.remove = dwc2_udc_otg_remove,
>   	.plat_auto	= sizeof(struct dwc2_plat_otg_data),

The rest looks good, thanks !
