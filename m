Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18352C25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 09:04:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FB2C87D6B;
	Tue, 28 May 2024 11:04:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yFSWoFGR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A5BF8845B; Tue, 28 May 2024 11:04:18 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 177EA87D6B
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 11:04:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42101a2ac2cso4257015e9.0
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 02:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716887055; x=1717491855;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=144jkLjivzRQtED+niK38hgoKQ5b3j9Eg59Go8ZtKf0=;
 b=yFSWoFGR/obsC7wicUn9pbJRKAGFfWTTTz/ds8hbe/iXm7Urjhvzsz/Dx4S8TvmkA5
 xOWUdN33jPM+2cmmgQ0JPUOjG33GpCJPM06jJ/vZDDSY9U/5mQ2Fb/8Kujfuzg9+4zff
 wk7DcilWwBeefsujOQUeWdlNO0GQOGKvCoaYysEcL5C31cip3KvmhvALuJklfRWsjrMD
 PWHXm6Pn9wBMGlBY8AFV3smhev8x3CwbnRY/ah5ZMe2UW02Y0tyRGswZIO9Ro7C2pQP3
 LcEnAL1fDo80pAm7XrfuEeB9SIP4YejkAS2CEaOUy/LfHpEg4uBvCeUBjXoy22IF7jQa
 IZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716887055; x=1717491855;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=144jkLjivzRQtED+niK38hgoKQ5b3j9Eg59Go8ZtKf0=;
 b=Y2lw801Xc96ij191/fnAP+SrXB49J26e/YU9YBIPAbIRy5zCbblS3NHybZ7AwexHeA
 vIazBDXxYCZzh6BEmba8LTQs1Zbts3efZTnnoIMTrkqOuT98ryqhWpnblSQQyIMv7MZ3
 ANStJEhzuKmaWjhGGh1a5pKjwdRvrk41qZHV/mouhFsLqzz9uwSCYclsBt9WMZUSDRBe
 orezPyebb0x5/VudXzCZMPErP1AJKAL42h65BHJAjiNM7IzzDOWw+8TkkK+Sy88IRl8f
 sfXOCbTV0OZDRUtl2vFNCDf19DZ6wNx1R9kqdHqiAfnnnhwFwdPpLiqJg4bF79oeT3O1
 jmFQ==
X-Gm-Message-State: AOJu0YzGKWxs3EeH1rVKhDEfkvnXharSeVjZObZzC9XsI6fCD4nszNMs
 iA7a2X4PdU6HJ+5WPIrE1jE8AQTGHv5KdwIr8HJBCwSq4hevJnyXP3ulKm0xJzg=
X-Google-Smtp-Source: AGHT+IG563GNUBmkKLEs6Aidp6LD0GDETpNvWYn9n765J3zCmKyMB8PQmJPT7lFnagA/gZY1Qo4GRw==
X-Received: by 2002:a05:600c:358a:b0:421:1f6f:3e15 with SMTP id
 5b1f17b1804b1-4211f6f3f19mr8652015e9.16.1716887055401; 
 Tue, 28 May 2024 02:04:15 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3557a08a8bcsm11129579f8f.44.2024.05.28.02.04.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 02:04:14 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, Lukasz Majewski
 <lukma@denx.de>, Marek Vasut <marex@denx.de>, Tom Rini
 <trini@konsulko.com>, Marek Szyprowski <m.szyprowski@samsung.com>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] usb: dwc3: gadget: fix crash in dwc3_gadget_giveback()
In-Reply-To: <20240528-topic-sm8x50-dwc3-gadget-crash-fix-v1-1-58434ab4b3d3@linaro.org>
References: <20240528-topic-sm8x50-dwc3-gadget-crash-fix-v1-1-58434ab4b3d3@linaro.org>
Date: Tue, 28 May 2024 11:04:11 +0200
Message-ID: <87o78qgvec.fsf@baylibre.com>
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

On mar., mai 28, 2024 at 10:35, Neil Armstrong <neil.armstrong@linaro.org> wrote:

> If the ep0 stalls or request are dequeued when gagdet is stopped,
> the request dma may not be mapped yet and dwc3_flush_cache() may be
> called with a NULL pointer.
>
> Check req->request.dma before calling dwc3_flush_cache() and later
> the usb_gadget_unmap_request() functions since it means that
> usb_gadget_map_request() hasn't been called yet.
>
> Fixes: fd15b58c1a9 ("dwc3: flush cache only if there is a buffer attached to a request")
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  drivers/usb/dwc3/gadget.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index fab32575647..92c7c6d08b7 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -248,7 +248,7 @@ void dwc3_gadget_giveback(struct dwc3_ep *dep, struct dwc3_request *req,
>  
>  	list_del(&req->list);
>  	req->trb = NULL;
> -	if (req->request.length)
> +	if (req->request.dma && req->request.length)
>  		dwc3_flush_cache((uintptr_t)req->request.dma, req->request.length);
>  
>  	if (req->request.status == -EINPROGRESS)
> @@ -256,7 +256,7 @@ void dwc3_gadget_giveback(struct dwc3_ep *dep, struct dwc3_request *req,
>  
>  	if (dwc->ep0_bounced && dep->number == 0)
>  		dwc->ep0_bounced = false;
> -	else
> +	else if (req->request.dma)
>  		usb_gadget_unmap_request(&dwc->gadget, &req->request,
>  				req->direction);
>  
>
> ---
> base-commit: 7e52d6ccfb76e2afc2d183b357abe2a2e2f948cf
> change-id: 20240528-topic-sm8x50-dwc3-gadget-crash-fix-fa0404ffce33
>
> Best regards,
> -- 
> Neil Armstrong <neil.armstrong@linaro.org>
