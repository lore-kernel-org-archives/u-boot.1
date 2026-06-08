Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E75F0CD8C8E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 07:02:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36E8A83FEC;
	Mon,  8 Jun 2026 09:02:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FjfpHoJX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 341BA84154; Mon,  8 Jun 2026 09:02:35 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1643807C4
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 09:02:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 730516001D;
 Mon,  8 Jun 2026 07:02:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 922171F00893;
 Mon,  8 Jun 2026 07:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780902151;
 bh=LJTjj/SzIKFhRJxC2lk14aqO70CfGBJ6RwKp1bSOv/Q=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=FjfpHoJXIXzlTWrdHzBQTGvM7tGPTzBztGO1A5bxih8jo7yF6mdR/i17fvI1IvzVI
 T+ZwY5KeeYdE4fLadAUEQNz62LOIDgPelYvRyg7fBYAFoakVlvSGiaMI7kZN2mVI+w
 WOj0X2ogcBFFN63l2Te/yfeyqRJnUqIeaoA8MMb+CxINxhvOUU5D9YNPeqApvjh/AT
 YWS9LTXt/ASRC4w9pUnrL4cM9LKBaORlNFIAirUkmNJl9TyJud5RHesSlAxR+4Z2HG
 mOz9nK3zSP10QPqL4oAVmSuoJNHqeNIfnCcLK8jlSVZazeIOH4uoj0/8Lto0ogvswm
 Q9StyBFk5UNnA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Zixun LI <admin@hifiphile.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Stephan Gerhold <stephan.gerhold@linaro.org>,
 u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>, Tom Rini
 <trini@konsulko.com>, Andrew Goodbody <andrew.goodbody@linaro.org>, Zixun
 LI <admin@hifiphile.com>
Subject: Re: [PATCH v2] usb: gadget: atmel: use calloc() to allocate
 endpoint list
In-Reply-To: <20260606-udc_malloc-v2-1-1155326b182b@hifiphile.com>
References: <20260606-udc_malloc-v2-1-1155326b182b@hifiphile.com>
Date: Mon, 08 Jun 2026 09:02:27 +0200
Message-ID: <87pl21zf98.fsf@kernel.org>
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

On Sat, Jun 06, 2026 at 10:27, Zixun LI <admin@hifiphile.com> wrote:

> malloc() doesn't zero out memory, leaving ep->ep.enabled uninitiated,
> which could make this flag falsely true.
>
> In next usb_ep_enable() call since this flag is true, ep->ops->enable()
> will be skipped. Then usb_ep_queue() will fail on uninitialized endpoint.
>
> Fixes: 59310d1ecb9f ("usb: gadget: introduce 'enabled' flag in struct usb_ep")
> Signed-off-by: Zixun LI <admin@hifiphile.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
> On SAM9X60 I had a problem with unreliable usb_ether functionality,
> sometimes 'dhcp' command returns with error 'rx submit --> -108'.
> ---
> Changes in v2:
> - Add more details to commit message.
> - Link to v1: https://patch.msgid.link/20260521-udc_malloc-v1-1-b6118f809ada@hifiphile.com
> ---
>  drivers/usb/gadget/atmel_usba_udc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
> index f7a92ded6da..a5a2252dee9 100644
> --- a/drivers/usb/gadget/atmel_usba_udc.c
> +++ b/drivers/usb/gadget/atmel_usba_udc.c
> @@ -1219,7 +1219,7 @@ static struct usba_ep *usba_udc_pdata(struct usba_platform_data *pdata,
>  	struct usba_ep *eps;
>  	int i;
>  
> -	eps = malloc(sizeof(struct usba_ep) * pdata->num_ep);
> +	eps = calloc(pdata->num_ep, sizeof(struct usba_ep));
>  	if (!eps) {
>  		log_err("failed to alloc eps\n");
>  		return NULL;
>
> ---
> base-commit: 5732bd0f457b4c671e46574d64d4acb099c0f0a5
> change-id: 20260521-udc_malloc-eb8355d08afe
>
> Best regards,
> --  
> Zixun LI <admin@hifiphile.com>
