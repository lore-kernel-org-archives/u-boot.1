Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A124CD4F24
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 11:24:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EFE283FB0;
	Wed, 13 May 2026 13:24:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="qlr7KGm/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFC8784099; Wed, 13 May 2026 13:24:14 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83C53836AC
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 13:24:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 8F16E41925;
 Wed, 13 May 2026 11:24:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17F91C2BCB7;
 Wed, 13 May 2026 11:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778671450;
 bh=OhPWXkB6utBT9sa5rdW0F5o5r84u6E0ZfP8U+OdgV+8=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=qlr7KGm/EsQmU7M9Lr4NAHLrssoSbDGEVitiJg/vIAMy2+adONT6ltyUA7x/F1pEH
 MGuOPKgObuu6+wqZDIHL9OfSYj4ZFvtBvZTboF9Hvt8SfFknQ72aPP5hwkvmit698X
 R3GokEFnqNhithbqiD+oNtnlIyW6a38fvF7RgsYSGt+HHx7I7F1ZjjdOTokOoFphSE
 i8kf7WCNFjo+o1HTSJYEPI12D/jMtoCV/Bag0YIYhyKoJIAeDPy70QWPUXpr2XYZXL
 tmbRFP04y0VnSnMums7jY6ySBPyok8yyPHwilTU53lLmtKD/9QTOD/elgRUVC64kYm
 HksYSCxyOvfoA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Zixun LI <admin@hifiphile.com>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>, Tom Rini
 <trini@konsulko.com>, Zixun LI <zli@ogga.fr>, Andrew Goodbody
 <andrew.goodbody@linaro.org>, Zixun LI <admin@hifiphile.com>
Subject: Re: [PATCH] usb: gadget: atmel: do not disable endpoints in
 reset_all_endpoints()
In-Reply-To: <20260512-udc_ep-v1-1-8a783e44cf7f@hifiphile.com>
References: <20260512-udc_ep-v1-1-8a783e44cf7f@hifiphile.com>
Date: Wed, 13 May 2026 13:24:07 +0200
Message-ID: <87h5obv9go.fsf@kernel.org>
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

On Tue, May 12, 2026 at 15:11, Zixun LI <admin@hifiphile.com> wrote:

> Endpoints should not be disabled on bus reset event inside UDC driver,
> otherwise a racing condition will happen between gadget driver. Gadget

nitpick: a racing condition -> a race condition

> driver will free the requests and disable endpoints in disconnect ops
> later.
>
Add:

Fixes: 59310d1ecb9f ("usb: gadget: introduce 'enabled' flag in struct usb_ep")
> Signed-off-by: Zixun LI <admin@hifiphile.com>

Just above your Signed-off-by: to mark this as a fix.

> ---
>  drivers/usb/gadget/atmel_usba_udc.c | 14 --------------
>  1 file changed, 14 deletions(-)

Earlier in the driver, in the usba_ep_disable() function, there is the
following section:

"""
	if (!ep->desc) {
		spin_unlock_irqrestore(&udc->lock, flags);
		/* REVISIT because this driver disables endpoints in
		 * reset_all_endpoints() before calling disconnect(),
		 * most gadget drivers would trigger this non-error ...
		 */
		if (udc->gadget.speed != USB_SPEED_UNKNOWN)
			DBG(DBG_ERR, "ep_disable: %s not enabled\n",
			    ep->ep.name);
		return -EINVAL;
	}
	ep->desc = NULL;
"""

With this patch, the REVISIT comment is no longer valid. Can we remove
it?

Also, I believe (but I may be wrong, please try it out) that we can
maybe remove the whole if (!ep->desc) block from usba_ep_disable() since
that should be handled by the enabled flag wrapper introduced by
commit 59310d1ecb9f ("usb: gadget: introduce 'enabled' flag in struct usb_ep")


>
> diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
> index f7a92ded6da..b0de22961de 100644
> --- a/drivers/usb/gadget/atmel_usba_udc.c
> +++ b/drivers/usb/gadget/atmel_usba_udc.c
> @@ -571,20 +571,6 @@ static void reset_all_endpoints(struct usba_udc *udc)
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
