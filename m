Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41B72F8E4A0
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 02:57:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B01584246;
	Fri, 17 Apr 2026 04:57:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="JiJ3oI9J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECEEF8429E; Fri, 17 Apr 2026 04:57:49 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 032AE8422D
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 04:57:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4fxfgt1jJtz9vCR;
 Fri, 17 Apr 2026 04:57:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1776394666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3lbvp9W3lv8Wl7O+eOGMbOSnh6hLwPKxIaEEuUWdzNY=;
 b=JiJ3oI9J2bIwzvGSlz04h/STcBBYvcHP6TSEuPdZGGmiz433bZScEDAvHLNfRVtJ8kiABE
 d7CQN8jgpc8KHCL/NZGPdybnrj5r0ljVoVuvUQTcmykFG7tlaGa01QGtdlPRdj76XXwkfq
 fZX/iBbxs5gAIwNMwCRcSJuJDk5fkgng19/f4XTo9l3xERl+0c/Bl9OQ49B9HFcMZOqDPB
 GP58kjPjFcoM/uqObtV4beIQktJdp9AGgO7VhLh/5VyTLB37Va619Ytv6hda0pAldXzqrK
 4nfVnAV2cKjeVuLWarMayXS2hZZSChgnx0wwYYFCsVPPr9QEXUJNuVosEwmxQw==
Message-ID: <090d1961-40e1-44f0-9007-8e839ccbb47f@mailbox.org>
Date: Thu, 16 Apr 2026 20:11:36 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3 2/2] usb: gadget: renesas: add support for RZ/G2L SoC
To: Michele Bisogno <micbis.openwrt@gmail.com>, u-boot@lists.denx.de,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>
Cc: paul@pbarker.dev, jh80.chung@samsung.com, peng.fan@nxp.com,
 lukma@denx.de, mkorpershoek@kernel.org, trini@konsulko.com
References: <20260416153827.14256-1-micbis.openwrt@gmail.com>
 <20260416153827.14256-3-micbis.openwrt@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260416153827.14256-3-micbis.openwrt@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: h785h1zpfrbmqemzfjkth78dg4gpruk6
X-MBO-RS-ID: d05e0aebd1c6adae033
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

On 4/16/26 5:38 PM, Michele Bisogno wrote:
> common: Add "renesas,rzg2l-usbhs" compatible and support
> reset deassertion. Fix a re-entrancy bug by calling usb_del_gadget_udc()
> in the remove callback to prevent stale UDC list entries.
> fifo: Refactor PIO push/pop logic to handle trailing bytes
> using iowrite8/ioread8. This ensures correct data alignment on
> RZ/G2L and simplifies the data transfer loop.

This looks like two separate changes.

> Signed-off-by: Michele Bisogno <micbis.openwrt@gmail.com>
> ---
>   drivers/usb/gadget/rcar/common.c | 15 +++++++++++++++
>   drivers/usb/gadget/rcar/fifo.c   | 23 +++++++++++++----------
>   2 files changed, 28 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/usb/gadget/rcar/common.c b/drivers/usb/gadget/rcar/common.c
> index 2ba022a3f2c..1f266ae5ac9 100644
> --- a/drivers/usb/gadget/rcar/common.c
> +++ b/drivers/usb/gadget/rcar/common.c
> @@ -16,6 +16,7 @@
>   #include <linux/usb/ch9.h>
>   #include <linux/usb/gadget.h>
>   #include <usb.h>
> +#include <reset.h>
>   
>   #include "common.h"
>   
> @@ -397,6 +398,7 @@ static int usbhs_udc_otg_probe(struct udevice *dev)
>   	struct usbhs_priv_otg_data *priv = dev_get_priv(dev);
>   	struct usb_gadget *gadget;
>   	struct clk_bulk clk_bulk;
> +	struct reset_ctl_bulk reset_bulk;
>   	int ret = -EINVAL;
>   
>   	priv->base = dev_read_addr_ptr(dev);
> @@ -411,6 +413,14 @@ static int usbhs_udc_otg_probe(struct udevice *dev)
>   	if (ret)
>   		return ret;
>   
> +	ret = reset_get_bulk(dev, &reset_bulk);
> +	if (ret)
> +		return ret;
> +
> +	ret = reset_deassert_bulk(&reset_bulk);
> +	if (ret)
> +		return ret;

This reset handling should be a separate patch.

>   	clrsetbits_le32(priv->base + UGCTRL2, UGCTRL2_USB0SEL_MASK, UGCTRL2_USB0SEL_EHCI);
>   	clrsetbits_le16(priv->base + LPSTS, LPSTS_SUSPM, LPSTS_SUSPM);
>   
> @@ -447,7 +457,11 @@ err_clk:
>   static int usbhs_udc_otg_remove(struct udevice *dev)
>   {
>   	struct usbhs_priv_otg_data *priv = dev_get_priv(dev);
> +	struct usb_gadget *gadget;
>   
> +	gadget = usbhsg_get_gadget(&priv->usbhs_priv);
> +	if (gadget)
> +		usb_del_gadget_udc(gadget);

This also looks like a separate fix for some other issue ?

Also, reset_assert/put_bulk() is missing here ?

>   	usbhs_rcar3_power_ctrl(&priv->usbhs_priv, false);
>   	usbhs_mod_remove(&priv->usbhs_priv);
>   	usbhs_fifo_remove(&priv->usbhs_priv);
> @@ -460,6 +474,7 @@ static int usbhs_udc_otg_remove(struct udevice *dev)
>   
>   static const struct udevice_id usbhs_udc_otg_ids[] = {
>   	{ .compatible = "renesas,rcar-gen3-usbhs" },
> +	{ .compatible = "renesas,rzg2l-usbhs"},

Separate patch please, this should be last, after all the fixes.

>   	{},
>   };
>   
> diff --git a/drivers/usb/gadget/rcar/fifo.c b/drivers/usb/gadget/rcar/fifo.c
> index 6016b2987d5..b5340b4d860 100644
> --- a/drivers/usb/gadget/rcar/fifo.c

This whole FIFO part should also be a separate patch, and it should also 
be implemented for the Linux kernel, otherwise the two code bases will 
diverge. Please submit a matching patch to Linux.

> +++ b/drivers/usb/gadget/rcar/fifo.c
> @@ -535,18 +535,21 @@ static int usbhsf_pio_try_push(struct usbhs_pkt *pkt, int *is_done)
>   	 * 32-bit access only
>   	 */
>   	if (len >= 4 && !((unsigned long)buf & 0x03)) {
> -		iowrite32_rep(addr, buf, len / 4);
> -		len %= 4;
> -		buf += total_len - len;
> +		int words = len / 4;
> +
> +		iowrite32_rep(addr, buf, words);
> +		buf += (words * 4);
> +		len -= (words * 4);
>   	}
>   
>   	/* the rest operation */
> -	if (usbhs_get_dparam(priv, cfifo_byte_addr)) {
> -		for (i = 0; i < len; i++)
> -			iowrite8(buf[i], addr + (i & 0x03));
> -	} else {
> -		for (i = 0; i < len; i++)
> -			iowrite8(buf[i], addr + (0x03 - (i & 0x03)));
> +	if (len > 0) {
> +		if (len == 2 && !((unsigned long)buf & 0x01)) {
> +			iowrite16(*(u16 *)buf, addr);
> +		} else {
> +			for (i = 0; i < len; i++)
> +				iowrite8(buf[i], addr);
> +		}
>   	}
>   
>   	/*
> @@ -716,7 +719,7 @@ static int usbhsf_pio_try_pop(struct usbhs_pkt *pkt, int *is_done)
>   		if (!(i & 0x03))
>   			data = ioread32(addr);
>   
> -		buf[i] = (data >> ((i & 0x03) * 8)) & 0xff;
> +		buf[i] = ioread8(addr);
>   	}
>   
>   usbhs_fifo_read_end:

[...]
