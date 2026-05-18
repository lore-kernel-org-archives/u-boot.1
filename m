Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23588CD4F3C
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 07:36:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72F0F83FEE;
	Mon, 18 May 2026 09:36:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fHPs/1EF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0362184150; Mon, 18 May 2026 09:36:37 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0F8483EF9
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 09:36:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id F0BD1409B8;
 Mon, 18 May 2026 07:36:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CCCBC2BCB7;
 Mon, 18 May 2026 07:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779089791;
 bh=kQzWPvEomlsw9Cnn8e3WQA+2XVnUZINT8Ba+wyPiqr0=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=fHPs/1EFTBXN4AKSuQtilsCwoQcomiLV3pl+sTbOB3CfCetjWJs5WEx7qtM0+nCzn
 ON5ysk18Ow8HRbdTNLlLwdFfYlKNGt0cglCMCTdzMUY+nMxiXIg5pWj6ysrryAvyPr
 gkMt/J0Ei9PwXn5p6ydPWanvgXJhZGoi+hUaYiqPpqNMDw5IaeZnfDB6kWSoXsdDvR
 eiYlIKcc545GP1GvVyKDIjYXT3UosOXKxUc2rsmxe9ZowuZGB2KfQ0iK2UGFWUwQMZ
 LFlrHaP7xzyEETp7ua2KhH13ucY4e1LgPj4ITIVFNs6aUr3f6BA4YO4CohsHCZ78Ev
 I0eD+4Vx2j2Uw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Zixun LI <admin@hifiphile.com>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Marek Vasut <marex@denx.de>, Tom Rini
 <trini@konsulko.com>, Zixun LI <zli@ogga.fr>, Andrew Goodbody
 <andrew.goodbody@linaro.org>, Zixun LI <admin@hifiphile.com>, Stephan
 Gerhold <stephan.gerhold@linaro.org>
Subject: Re: [PATCH v2] usb: gadget: atmel: do not disable endpoints in
 reset_all_endpoints()
In-Reply-To: <20260515-udc_ep-v2-1-cd335b4e62e4@hifiphile.com>
References: <20260515-udc_ep-v2-1-cd335b4e62e4@hifiphile.com>
Date: Mon, 18 May 2026 09:36:28 +0200
Message-ID: <87lddhw4n7.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Zixun,

Thank you for the patch.

On Fri, May 15, 2026 at 12:05, Zixun LI <admin@hifiphile.com> wrote:

> Endpoints should not be disabled on bus reset inside UDC driver,
> otherwise a race condition will happen between gadget driver. Gadget
> driver will free the requests and disable endpoints in disconnect ops.
>
> Also remove outdated comment about it in usba_ep_disable().
>
> Fixes: 59310d1ecb9f ("usb: gadget: introduce 'enabled' flag in struct usb_ep")
>
> Signed-off-by: Zixun LI <admin@hifiphile.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

Note: there should not be an empty newline between the fixes and the signed-off.
It should be:

Fixes: 59310d1ecb9f ("usb: gadget: introduce 'enabled' flag in struct usb_ep")
Signed-off-by: Zixun LI <admin@hifiphile.com>

Not:

Fixes: 59310d1ecb9f ("usb: gadget: introduce 'enabled' flag in struct usb_ep")
<empty newline>
Signed-off-by: Zixun LI <admin@hifiphile.com>

No need to resend a v3 for it, I can fix it up while applying.

> ---
> Changes in v2:
> - Remove outdated comment in usba_ep_disable()
> - Reword commit message
> - Link to v1: https://patch.msgid.link/20260512-udc_ep-v1-1-8a783e44cf7f@hifiphile.com
>
> To: Mattijs Korpershoek <mkorpershoek@kernel.org>
> To: Stephan Gerhold <stephan.gerhold@linaro.org>
> To: u-boot@lists.denx.de
> Cc: Lukasz Majewski <lukma@denx.de>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Zixun LI <admin@hifiphile.com>
> Cc: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>  drivers/usb/gadget/atmel_usba_udc.c | 18 ------------------
>  1 file changed, 18 deletions(-)
>
> diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
> index f7a92ded6da..a2eee2bca2c 100644
> --- a/drivers/usb/gadget/atmel_usba_udc.c
> +++ b/drivers/usb/gadget/atmel_usba_udc.c
> @@ -289,10 +289,6 @@ static int usba_ep_disable(struct usb_ep *_ep)
>  
>  	if (!ep->desc) {
>  		spin_unlock_irqrestore(&udc->lock, flags);
> -		/* REVISIT because this driver disables endpoints in
> -		 * reset_all_endpoints() before calling disconnect(),
> -		 * most gadget drivers would trigger this non-error ...
> -		 */
>  		if (udc->gadget.speed != USB_SPEED_UNKNOWN)
>  			DBG(DBG_ERR, "ep_disable: %s not enabled\n",
>  			    ep->ep.name);
> @@ -571,20 +567,6 @@ static void reset_all_endpoints(struct usba_udc *udc)
>  		list_del_init(&req->queue);
>  		request_complete(ep, req, -ECONNRESET);
>  	}
> -
> -	/* NOTE:  normally, the next call to the gadget driver is in
> -	 * charge of disabling endpoints... usually disconnect().
> -	 * The exception would be entering a high speed test mode.
> -	 *
> -	 * FIXME remove this code ... and retest thoroughly.
> -	 */
> -	list_for_each_entry(ep, &udc->gadget.ep_list, ep.ep_list) {
> -		if (ep->desc) {
> -			spin_unlock(&udc->lock);
> -			usba_ep_disable(&ep->ep);
> -			spin_lock(&udc->lock);
> -		}
> -	}
>  }
>  
>  static struct usba_ep *get_ep_by_addr(struct usba_udc *udc, u16 wIndex)
>
> ---
> base-commit: 5732bd0f457b4c671e46574d64d4acb099c0f0a5
> change-id: 20260512-udc_ep-51a3f7a6befb
>
> Best regards,
> --  
> Zixun LI <admin@hifiphile.com>
