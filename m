Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C785C369A6
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 12:20:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AE3E83BEB;
	Thu, 10 Apr 2025 14:20:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cOZisCN9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07F8883C01; Thu, 10 Apr 2025 14:20:03 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 575E183B7E
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 14:20:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id E9A8C5C53E3;
 Thu, 10 Apr 2025 12:17:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1625FC4CEDD;
 Thu, 10 Apr 2025 12:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1744287598;
 bh=aMxjbJ2BxsuUcICdAVDcvFCGzIVSXDEbJXcnR/ZoORs=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=cOZisCN94wv2M2jx1iouYaY4/yFRSqT00yi6MR/WzYLQEvA0JL8zcHcfaXUMMyyNV
 Bd3qjiT/4wgY7WR3Hksp8wrqGwT0/zDaMxdxmADCKeq4Q/fZ3ALJaeVDglfGCQPBlb
 FjienkyxAPpyvVn0Byq9DtcUGUcUIi+DjYuS1Nn2fNwwmX2uzMJc9bm1EC6Z0VE4bA
 yoZEIT6k49qfpsO99uxYk8mPedmAqZWHOT/kUUsVTC5vFUIxwGrzIbI+cDPuRexEzZ
 YJI/jPeUBij7UWkpOIKsb649ubaaXZMh1Q+EyVkGm98AnbD8rtq6A3DLJtyq2MKOq5
 mkf6mTJxeqMEw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Stephan Gerhold <stephan.gerhold@linaro.org>, Lukasz Majewski
 <lukma@denx.de>, Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, Loic Poulain
 <loic.poulain@oss.qualcomm.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 3/3] usb: gadget: introduce 'enabled' flag in struct usb_ep
In-Reply-To: <20250407-acm-fixes-v1-3-e3dcb592d6d6@linaro.org>
References: <20250407-acm-fixes-v1-0-e3dcb592d6d6@linaro.org>
 <20250407-acm-fixes-v1-3-e3dcb592d6d6@linaro.org>
Date: Thu, 10 Apr 2025 14:19:55 +0200
Message-ID: <87v7rcfbtg.fsf@baylibre.com>
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

> f_acm calls usb_ep_disable(f_acm->ep_notify) unconditionally in
> acm_start_ctrl(), even if the USB endpoint was never enabled before. This
> causes crashes for some UDC drivers (e.g. ci_udc), because they dereference
> data structures that are assigned only after having called usb_ep_enable().
>
> The f_acm driver in U-Boot is similar to the Linux driver, where this issue
> does not occur because usb_ep_disable() and usb_ep_enable() internally
> track the enabled state. In Linux this change was made in commit
> b0bac2581c19 ("usb: gadget: introduce 'enabled' flag in struct usb_ep") by
> Robert Baldyga.
>
> Fix the crashes for f_acm by making the same change in U-Boot. This makes
> the API less bug-prone and avoids introducing crashes when adapting new
> gadget drivers from Linux.
>
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>  include/linux/usb/gadget.h | 27 +++++++++++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
> index c7927df15aa386f33eb3b3889adee854d42386a8..fe79bf64a0e1c037e69e694fe58cbe5343e18a70 100644
> --- a/include/linux/usb/gadget.h
> +++ b/include/linux/usb/gadget.h
> @@ -179,6 +179,7 @@ struct usb_ep {
>  	const struct usb_ep_ops	*ops;
>  	struct list_head	ep_list;
>  	struct usb_ep_caps	caps;
> +	bool			enabled;
>  	unsigned		maxpacket:16;
>  	unsigned		maxpacket_limit:16;
>  	unsigned		max_streams:16;
> @@ -230,7 +231,18 @@ static inline void usb_ep_set_maxpacket_limit(struct usb_ep *ep,
>  static inline int usb_ep_enable(struct usb_ep *ep,
>  				const struct usb_endpoint_descriptor *desc)
>  {
> -	return ep->ops->enable(ep, desc);
> +	int ret;
> +
> +	if (ep->enabled)
> +		return 0;
> +
> +	ret = ep->ops->enable(ep, desc);
> +	if (ret)
> +		return ret;
> +
> +	ep->enabled = true;
> +
> +	return 0;
>  }
>  
>  /**
> @@ -247,7 +259,18 @@ static inline int usb_ep_enable(struct usb_ep *ep,
>   */
>  static inline int usb_ep_disable(struct usb_ep *ep)
>  {
> -	return ep->ops->disable(ep);
> +	int ret;
> +
> +	if (!ep->enabled)
> +		return 0;
> +
> +	ret = ep->ops->disable(ep);
> +	if (ret)
> +		return ret;
> +
> +	ep->enabled = false;
> +
> +	return 0;
>  }
>  
>  /**
>
> -- 
> 2.47.2
