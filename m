Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33D47C3DA61
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 15:03:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C49788937;
	Wed, 24 Jul 2024 17:03:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oGgnoK18";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18D268892E; Wed, 24 Jul 2024 17:03:26 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7D0C88962
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 17:03:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4266f344091so51075615e9.0
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 08:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721833402; x=1722438202;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=l71GUNd+bj7NQjmqtoWUMnGob/2y6+OVO8exST300Lg=;
 b=oGgnoK18CHsAzvhITTBSKScLcnJ0WjKGQJjucmliSjlhcZlDccRK+SqHydALWF7MLr
 eOJdBM3VA/D7s2+MQh8NORY9TlCLXGQEsYb+lzw2b8Am49bx6/QQy/h5+iTAc6QVAjsV
 oapYFbNQwGbP/Xgu0J8/FzArq9yNd5u0iWFmac5+kVxRnD5Y70o3sZ+QUyd3ZFq60kkY
 bLZxY5RcvTlMnnToTfmLMAbUJuzo+7SCvNn/2j0lYMLLH3UJrCAa7iSPN6wA9tbSt5kD
 KpTuV6F9NHslUObhlRw/2eCcxtMwB91o3Rl6nN4aiMQn7YA8b8XcMHLswtCm77QG1Oi4
 MuAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721833402; x=1722438202;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l71GUNd+bj7NQjmqtoWUMnGob/2y6+OVO8exST300Lg=;
 b=CzbfG75Bea2dCy6lg76SMCNT/eOSm1IDprih8LoItOe8p2OGPruUeLGO3ntjglJwZ7
 zao9I+1HCDY6qn++nWpwVpnA/wCj0KCAvyN1rhZj30b2QYo7kySaVp3yjDdU5fRMjQQy
 Fsutho2YmkqBZu/p9k3/ahJK0gGg41W/3ltJxbLCYGzSUSHq1DDK1f5fN3HFf9zwMtEI
 W3yizI1WqPGxAo2LF0hchiyfiwpzJLfRVRBIiNsDnzfPGMM9AOwgkyBe7AP+kM3CC6OD
 nIN7Uhr1x0l6ZgpsqiL2i0/xpvnDxfGRVjkFyQ/78NQVM+exGP3O9p6Lar5rkOZT1AaI
 9D0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNLLiCk2srV06M4KeLaWwsDPRfH5e1d69D4nVHTptlANihqEtIX9PrSbPAOMNVSMTsVLTh08qm78ZdyTWKHI9Z5vdv7Q==
X-Gm-Message-State: AOJu0Yy2RoN4WbFP4UyzuneetQP18ZqZnJvWAwY0Ak9rSUH356efkQlH
 oa351lcbbn0Sfd8NLg62WUKj/mBvbVaGs5vUnxhUs715tDy7K/cdeN+d/+vjf/Q=
X-Google-Smtp-Source: AGHT+IE2aVVKOXkT5o8lXWG2L5cXijUgU2EMaP935Mvnn96/BB7fX7ERQj61ZK0KsnDItFUULI8vhA==
X-Received: by 2002:a5d:64ac:0:b0:368:31c7:19d3 with SMTP id
 ffacd0b85a97d-369f09a2093mr2510710f8f.9.1721833401284; 
 Wed, 24 Jul 2024 08:03:21 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3687868b24csm14548543f8f.25.2024.07.24.08.03.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 08:03:20 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 1/3] usb: dwc3: allocate setup_buf with
 dma_alloc_coherent()
In-Reply-To: <20240719-u-boot-dwc3-gadget-dcache-fixup-v1-1-58a5f026ea8e@linaro.org>
References: <20240719-u-boot-dwc3-gadget-dcache-fixup-v1-0-58a5f026ea8e@linaro.org>
 <20240719-u-boot-dwc3-gadget-dcache-fixup-v1-1-58a5f026ea8e@linaro.org>
Date: Wed, 24 Jul 2024 17:03:18 +0200
Message-ID: <87r0bi4ytl.fsf@baylibre.com>
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

Hi Neil,

Thank you for the patch.

On ven., juil. 19, 2024 at 15:56, Neil Armstrong <neil.armstrong@linaro.org> wrote:

> Also allocate the setup_buf with dma_alloc_coherent() since it's

The subject of the patch says:

"usb: dwc3: allocate setup_buf with dma_alloc_coherent()"

Isn't this line just repeating the title?

> also consumed by the hardware DMA.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/usb/dwc3/core.h   | 2 ++
>  drivers/usb/dwc3/ep0.c    | 4 ++--
>  drivers/usb/dwc3/gadget.c | 8 ++++----
>  3 files changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> index 7374ce950da..ce35460c405 100644
> --- a/drivers/usb/dwc3/core.h
> +++ b/drivers/usb/dwc3/core.h
> @@ -670,6 +670,7 @@ struct dwc3_scratchpad_array {
>   * @ep0_trb: dma address of ep0_trb
>   * @ep0_usb_req: dummy req used while handling STD USB requests
>   * @ep0_bounce_addr: dma address of ep0_bounce
> + * @setup_buf_addr: dma address if setup_buf

if -> of

Both remarks being minor, please add:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

>   * @scratch_addr: dma address of scratchbuf
>   * @lock: for synchronizing
>   * @dev: pointer to our struct device
> @@ -757,6 +758,7 @@ struct dwc3 {
>  	dma_addr_t		ep0_trb_addr;
>  	dma_addr_t		ep0_bounce_addr;
>  	dma_addr_t		scratch_addr;
> +	dma_addr_t		setup_buf_addr;
>  	struct dwc3_request	ep0_usb_req;
>  
>  	/* device lock */
> diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
> index 16b11ce3d9f..0c7e0123368 100644
> --- a/drivers/usb/dwc3/ep0.c
> +++ b/drivers/usb/dwc3/ep0.c
> @@ -381,7 +381,7 @@ static int dwc3_ep0_handle_status(struct dwc3 *dwc,
>  	dep = dwc->eps[0];
>  	dwc->ep0_usb_req.dep = dep;
>  	dwc->ep0_usb_req.request.length = sizeof(*response_pkt);
> -	dwc->ep0_usb_req.request.buf = dwc->setup_buf;
> +	dwc->ep0_usb_req.request.buf = (void *)dwc->setup_buf_addr;
>  	dwc->ep0_usb_req.request.complete = dwc3_ep0_status_cmpl;
>  
>  	return __dwc3_gadget_ep0_queue(dep, &dwc->ep0_usb_req);
> @@ -663,7 +663,7 @@ static int dwc3_ep0_set_sel(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
>  	dep = dwc->eps[0];
>  	dwc->ep0_usb_req.dep = dep;
>  	dwc->ep0_usb_req.request.length = dep->endpoint.maxpacket;
> -	dwc->ep0_usb_req.request.buf = dwc->setup_buf;
> +	dwc->ep0_usb_req.request.buf = (void *)dwc->setup_buf_addr;
>  	dwc->ep0_usb_req.request.complete = dwc3_ep0_set_sel_cmpl;
>  
>  	return __dwc3_gadget_ep0_queue(dep, &dwc->ep0_usb_req);
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 7d6bcc2627f..d41b590afb8 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -2622,8 +2622,8 @@ int dwc3_gadget_init(struct dwc3 *dwc)
>  		goto err1;
>  	}
>  
> -	dwc->setup_buf = memalign(CONFIG_SYS_CACHELINE_SIZE,
> -				  DWC3_EP0_BOUNCE_SIZE);
> +	dwc->setup_buf = dma_alloc_coherent(DWC3_EP0_BOUNCE_SIZE,
> +					(unsigned long *)&dwc->setup_buf_addr);
>  	if (!dwc->setup_buf) {
>  		ret = -ENOMEM;
>  		goto err2;
> @@ -2670,7 +2670,7 @@ err4:
>  	dma_free_coherent(dwc->ep0_bounce);
>  
>  err3:
> -	kfree(dwc->setup_buf);
> +	dma_free_coherent(dwc->setup_buf);
>  
>  err2:
>  	dma_free_coherent(dwc->ep0_trb);
> @@ -2692,7 +2692,7 @@ void dwc3_gadget_exit(struct dwc3 *dwc)
>  
>  	dma_free_coherent(dwc->ep0_bounce);
>  
> -	kfree(dwc->setup_buf);
> +	dma_free_coherent(dwc->setup_buf);
>  
>  	dma_free_coherent(dwc->ep0_trb);
>  
>
> -- 
> 2.34.1
