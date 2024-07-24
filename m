Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85D74C3DA63
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 10:15:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0677688881;
	Wed, 24 Jul 2024 12:15:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vHJMvs5C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47878888FA; Wed, 24 Jul 2024 12:15:40 +0200 (CEST)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4687B8883E
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 12:15:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2ef2ed59200so40378251fa.3
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 03:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721816137; x=1722420937;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=o9SDdR7HPHRBrAoUiOkap0LB5qMl0j8/M+icVGxefz0=;
 b=vHJMvs5CUSEZArlLdZdDmv2BkmREjGUQvrDARUr6PzOasz1h9ZIU5FA7N3OhYXBBvk
 WhWF2Gan3utISX/ARxc4MFc8aXoEYItLvLZgw4HDrbY31SuLx4Iei6SDXu0uezd67kIf
 hS2egNSO4YsUKUrEKbpkJ/QN54yiXBhSrm7xfkYcQOKgYUrhmO9Iw1B/YwLoR6A9HE1X
 04oLEqfvBXPL6Sn7/jx+t3AHFSH8qTHxQIWNa3YoVWd7yPKnqqoe7mmxymTLVv4d52Oj
 CIymY2P7C3FIguz/MU0yWdSIMHgphDzawpGMxJF5bDVBs6aaykRM972g4TrFRsgGKNsg
 p4TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721816137; x=1722420937;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o9SDdR7HPHRBrAoUiOkap0LB5qMl0j8/M+icVGxefz0=;
 b=GJJVATmm2XjZN6vuW0ij71xm8507QYTiga+0JIwwlKMWLthY5AXQMWB7nP1Hn5khq/
 +LD9bPnagUN5I5c1gPPGGXjysNsXNZ8JJpRtr0DC99d7bzYdh/msmPjvRZoYnUMETLZv
 IecrFC/jF9vGHuI2q7h+9vGZgXIb4c6rszavme6vLS7elC1USe91YgYZQcHxPDdH6gou
 JnnQelz/XFBtJcebjHSZdDbTIi1BpVkj6DC605I+ETuM7JPNJQSoR5HP4xAplN5pcniE
 yBGyWdXeSBznQfzm0xUDQBmMfcnxL+mpIqCd3EduwK4VDf4xp3bg/OaxmoDfNPp30IAB
 OPqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJ3ZHUZDYjs420AGGz82508tQoYKkjOBUHYCaZiNRdkuHqW3CgIedD725oAaK26VxoJ7S8ipmtew6rKT8UmRYybaBMoA==
X-Gm-Message-State: AOJu0Ywe5pPxTslk+lMM8hNyywMf/iGwRWt1C6wEB2Iqga7hnnCRfvl8
 mzTNELvy+DCiRMhH/PaoBTd4DDcMlnsPnZvwdxx8X7DWpUJmITOSlAJ7hH8amwzink0ZJuzd6Pw
 t
X-Google-Smtp-Source: AGHT+IHxOE+DBXYm30b4sK6TZomiF9l+jpRy9fIeOLuebHy3v0HIR/uwml2TeLuZTn5hCW6m6ZLAkw==
X-Received: by 2002:a2e:9687:0:b0:2ee:df26:9d4d with SMTP id
 38308e7fff4ca-2f03255bf63mr10718971fa.47.1721816137023; 
 Wed, 24 Jul 2024 03:15:37 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427f937aa9esm22833035e9.12.2024.07.24.03.15.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 03:15:36 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Zixun LI <admin@hifiphile.com>, Lukasz Majewski <lukma@denx.de>, Marek
 Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
Cc: Zixun LI <zli@ogga.fr>, u-boot@lists.denx.de
Subject: Re: [PATCH v3 4/7] usb: gadget: atmel: Move usba_udc_pdata() with
 other static functions
In-Reply-To: <20240723131817.262596-5-zli@ogga.fr>
References: <20240723131817.262596-1-zli@ogga.fr>
 <20240723131817.262596-5-zli@ogga.fr>
Date: Wed, 24 Jul 2024 12:15:35 +0200
Message-ID: <87a5i75c54.fsf@baylibre.com>
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

On mar., juil. 23, 2024 at 15:18, Zixun LI <admin@hifiphile.com> wrote:

> To make all static functions in the top, no functional change.
>
> Signed-off-by: Zixun LI <zli@ogga.fr>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  drivers/usb/gadget/atmel_usba_udc.c | 80 ++++++++++++++---------------
>  1 file changed, 40 insertions(+), 40 deletions(-)
>
> diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
> index 2e3d8f36a2..a3d24501ba 100644
> --- a/drivers/usb/gadget/atmel_usba_udc.c
> +++ b/drivers/usb/gadget/atmel_usba_udc.c
> @@ -1179,6 +1179,46 @@ static int atmel_usba_stop(struct usba_udc *udc)
>  	return 0;
>  }
>  
> +static struct usba_ep *usba_udc_pdata(struct usba_platform_data *pdata,
> +				      struct usba_udc *udc)
> +{
> +	struct usba_ep *eps;
> +	int i;
> +
> +	eps = malloc(sizeof(struct usba_ep) * pdata->num_ep);
> +	if (!eps) {
> +		log_err("failed to alloc eps\n");
> +		return NULL;
> +	}
> +
> +	udc->gadget.ep0 = &eps[0].ep;
> +
> +	INIT_LIST_HEAD(&udc->gadget.ep_list);
> +	INIT_LIST_HEAD(&eps[0].ep.ep_list);
> +
> +	for (i = 0; i < pdata->num_ep; i++) {
> +		struct usba_ep *ep = &eps[i];
> +
> +		ep->ep_regs = udc->regs + USBA_EPT_BASE(i);
> +		ep->dma_regs = udc->regs + USBA_DMA_BASE(i);
> +		ep->fifo = udc->fifo + USBA_FIFO_BASE(i);
> +		ep->ep.ops = &usba_ep_ops;
> +		ep->ep.name = pdata->ep[i].name;
> +		ep->ep.maxpacket = pdata->ep[i].fifo_size;
> +		ep->fifo_size = ep->ep.maxpacket;
> +		ep->udc = udc;
> +		INIT_LIST_HEAD(&ep->queue);
> +		ep->nr_banks = pdata->ep[i].nr_banks;
> +		ep->index = pdata->ep[i].index;
> +		ep->can_dma = pdata->ep[i].can_dma;
> +		ep->can_isoc = pdata->ep[i].can_isoc;
> +		if (i)
> +			list_add_tail(&ep->ep.ep_list, &udc->gadget.ep_list);
> +	};
> +
> +	return eps;
> +}
> +
>  static struct usba_udc controller = {
>  	.regs = (unsigned *)ATMEL_BASE_UDPHS,
>  	.fifo = (unsigned *)ATMEL_BASE_UDPHS_FIFO,
> @@ -1244,46 +1284,6 @@ int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
>  	return 0;
>  }
>  
> -static struct usba_ep *usba_udc_pdata(struct usba_platform_data *pdata,
> -				      struct usba_udc *udc)
> -{
> -	struct usba_ep *eps;
> -	int i;
> -
> -	eps = malloc(sizeof(struct usba_ep) * pdata->num_ep);
> -	if (!eps) {
> -		log_err("failed to alloc eps\n");
> -		return NULL;
> -	}
> -
> -	udc->gadget.ep0 = &eps[0].ep;
> -
> -	INIT_LIST_HEAD(&udc->gadget.ep_list);
> -	INIT_LIST_HEAD(&eps[0].ep.ep_list);
> -
> -	for (i = 0; i < pdata->num_ep; i++) {
> -		struct usba_ep *ep = &eps[i];
> -
> -		ep->ep_regs = udc->regs + USBA_EPT_BASE(i);
> -		ep->dma_regs = udc->regs + USBA_DMA_BASE(i);
> -		ep->fifo = udc->fifo + USBA_FIFO_BASE(i);
> -		ep->ep.ops = &usba_ep_ops;
> -		ep->ep.name = pdata->ep[i].name;
> -		ep->ep.maxpacket = pdata->ep[i].fifo_size;
> -		ep->fifo_size = ep->ep.maxpacket;
> -		ep->udc = udc;
> -		INIT_LIST_HEAD(&ep->queue);
> -		ep->nr_banks = pdata->ep[i].nr_banks;
> -		ep->index = pdata->ep[i].index;
> -		ep->can_dma = pdata->ep[i].can_dma;
> -		ep->can_isoc = pdata->ep[i].can_isoc;
> -		if (i)
> -			list_add_tail(&ep->ep.ep_list, &udc->gadget.ep_list);
> -	};
> -
> -	return eps;
> -}
> -
>  int usba_udc_probe(struct usba_platform_data *pdata)
>  {
>  	struct usba_udc *udc;
> -- 
> 2.45.2
