Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44583C3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 09:58:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAB8F83B83;
	Thu, 10 Apr 2025 11:58:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZRWqDKhg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BB1083B85; Thu, 10 Apr 2025 11:58:50 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B4A3830E4
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 11:58:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id AE2B6A49AA7;
 Thu, 10 Apr 2025 09:53:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 160B2C4CEDD;
 Thu, 10 Apr 2025 09:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1744279127;
 bh=XMELsuYhQG2w4Eggz+zVs0axZnEt3NbNQizAQ3ipUnA=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=ZRWqDKhgPXT86awTRbQcnxsag9fmJsuj6g977KL0V2jASyO7sNBvZQST/qC/vOuTc
 nco6pii96epp9IVREA1D9jvOJIH3hZQOnQhJyYVQIScm/BDgm8DLyuK6soqF+iaaI0
 gayhPrUJp4k9jL8aVaKore+vw+uKb9EgA/XTztl++sItDX4LIG/DyIQaA9imN3iXlT
 /8XOr7tDKsftl4pwlFFaOdsCaqOMMF6o0vLwif3lqXtaSF0RpJ/u98vvUtxw4F94SJ
 wR3ShuFtwoAWwD4zWjO/H9pE0P9sryvlcxGOPzqLbOun7EDXmxkPuPuR6WqT83TN9Y
 Shnv9a3lP3rWA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Stephan Gerhold <stephan.gerhold@linaro.org>, Lukasz Majewski
 <lukma@denx.de>, Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, Loic Poulain
 <loic.poulain@oss.qualcomm.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/3] usb: gadget: f_acm: Claim requested USB endpoints
In-Reply-To: <20250407-acm-fixes-v1-1-e3dcb592d6d6@linaro.org>
References: <20250407-acm-fixes-v1-0-e3dcb592d6d6@linaro.org>
 <20250407-acm-fixes-v1-1-e3dcb592d6d6@linaro.org>
Date: Thu, 10 Apr 2025 11:58:43 +0200
Message-ID: <871pu0gwx8.fsf@baylibre.com>
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

Hi Stephan,

Thank you for the patch.

On lun., avril 07, 2025 at 16:59, Stephan Gerhold <stephan.gerhold@linaro.org> wrote:

> U-Boot has an older version of the Linux gadget API, where USB endpoints
> returned by usb_ep_autoconfig() are not automatically claimed. As written
> in the documentation comment:
>
>  "To prevent the endpoint from being returned by a later autoconfig call,
>   claim it by assigning ep->driver_data to some non-null value."
>
> Right now f_acm doesn't do that, which means that e.g. ep_in and ep_notify
> may end up being assigned the same endpoint. Surprisingly, the ACM console
> is still somehow working, but this is not the expected behavior. It will
> break with a later commit that disallows calling usb_ep_enable() multiple
> times.
>
> Fix this by assigning some data to ep->driver_data, similar to the other
> gadget drivers.
>
> Fixes: fc2b399ac03b ("usb: gadget: Add CDC ACM function")
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>  drivers/usb/gadget/f_acm.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/usb/gadget/f_acm.c b/drivers/usb/gadget/f_acm.c
> index f18c6a0a76110df62e925de1882316eed463b343..2665fa4168f99b35a8c595aa24cb3fc4e8ab8529 100644
> --- a/drivers/usb/gadget/f_acm.c
> +++ b/drivers/usb/gadget/f_acm.c
> @@ -238,18 +238,21 @@ static int acm_bind(struct usb_configuration *c, struct usb_function *f)
>  		return -ENODEV;
>  
>  	f_acm->ep_in = ep;
> +	ep->driver_data = c->cdev; /* claim */
>  
>  	ep = usb_ep_autoconfig(gadget, &acm_fs_out_desc);
>  	if (!ep)
>  		return -ENODEV;
>  
>  	f_acm->ep_out = ep;
> +	ep->driver_data = c->cdev; /* claim */
>  
>  	ep = usb_ep_autoconfig(gadget, &acm_fs_notify_desc);
>  	if (!ep)
>  		return -ENODEV;
>  
>  	f_acm->ep_notify = ep;
> +	ep->driver_data = c->cdev; /* claim */
>  
>  	if (gadget_is_dualspeed(gadget)) {
>  		/* Assume endpoint addresses are the same for both speeds */
>
> -- 
> 2.47.2
