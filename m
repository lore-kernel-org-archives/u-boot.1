Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E520C369BA
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 18:51:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75A1D82E38;
	Wed, 16 Apr 2025 20:51:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="isA2RgVw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 187BE82E3F; Wed, 16 Apr 2025 20:51:57 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D75CC82BA2
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 20:51:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5e677f59438so10471318a12.2
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 11:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744829514; x=1745434314; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VknqdcgxoGYyUks+mPwEA3ElVy42oLBxPzb0mS4Pk6s=;
 b=isA2RgVw60yK3oMHVyoDyL7Gig7cowmb2Cbu1qrXD55qav3HW6SMHLUs91TqDJW5ld
 o3Vtd86P7FlhJLf+Fbnzxeh4Ae5YzRkJgZ3PpgHovjMVa1hWEwap0qebWE3fvi7wM+tF
 MxrUyp97ydniWuY0tjycG6WmfHfQCBArKD0/guUowcjCJco3HPAH0yQe9F7csTPAQAdo
 svNIW8eFhUHkHGxb+Yhx64AbovAds3Uqwe7uhJruUStzjrjFIhDf5HLLtd/RA2ykJm0N
 RwjaNXTDEHu735FY8rhVOb5f6mQPC1+8t35clSnAoyOHGN6EBRe1cooEfxPzaYUJAP1Y
 qTfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744829514; x=1745434314;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VknqdcgxoGYyUks+mPwEA3ElVy42oLBxPzb0mS4Pk6s=;
 b=dYP+GYZuUpJYaDvW2JJOMGa98dh+xu5ZIZrAljjNLYb4wWyGKmQbMDpCQmqglHzGEe
 fURKDdRAG0Hj/72eHzR14I2CxzP1wE3DCaBBjJ0OkJ5Oe+Mfj5oaHmYodVELFODkA6jx
 hxWMxjfWKkhe5oJ6ldEJzjFJvk/EMADUGCzWTIf/5D0lnLPX7f91a9C2fFLQLONW2wuN
 YHr+DzWlZJ7PVkjs2XLC3sqhHrzN0wBwYC0E9YWHFuYcIKggYxIOk2Rga+NOK1Yw7rnU
 ZJnCa7q/zFWu16MCACaYf+TZxMR0abmdXTnrTI7LRhyKdgzAoKP1VYE/7PrChne2QW7c
 g5Eg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIDb3iQIgqIeWOqdfSkFVqnPVV3TCNH6GRjDfhS1t292QsZ3ROJJBpgYbKQLdndOKk7qIlUe4=@lists.denx.de
X-Gm-Message-State: AOJu0Yw9e112jKCVmKJuKkBxAsyvBSyyo4yHiS+GUEH50Jba5laV6VgI
 f2NFXJc09DWL+bc/oUGeoHpD97cTYrAN/tLPzoH499keLkRmd5lkBLqrEuq+TZM=
X-Gm-Gg: ASbGnctN0n3AE9b6rmCNeNJdeek+BM0jAiEeu8WOzjtCo5aweWHnwSq06+7Cc3mGP3P
 FapZ172fXRimOxt0LyZec7jTfsomjEZDZXBZAQS8Tp5m5G1b+e1ut/7B1s7QpAnZwKnl0W1pj+A
 8JNwFDqPEZJc6cKTXruABEVJhpT2xD4Et9CJD9VFRizAya6VBifAjA/vIjqNGyDP2tM3ka1XbDT
 zSuqhRIeOKFy22bjZapTCuZQafaAUagvv2HWTCTTJTHbSOcMI7GiQTWxQT89vOCx/gU8XB5DrUP
 67IwUwy8ld+4xkZ89XyltDgCH8Rhi7vc/jiGRDM/TjctPkvyFfk=
X-Google-Smtp-Source: AGHT+IEjGyfWqbfdHlArc1VL4O3PDfGpM8C3MkXN8JVjgVwPj8SfjQssD90M67qu9ZUeFu/fCheNqg==
X-Received: by 2002:a05:6402:210a:b0:5e5:437b:74a7 with SMTP id
 4fb4d7f45d1cf-5f4b71fc23bmr2725398a12.8.1744829513988; 
 Wed, 16 Apr 2025 11:51:53 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:ef30:4dd7:8393:2255:f87])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f36f5054dbsm9376273a12.49.2025.04.16.11.51.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Apr 2025 11:51:53 -0700 (PDT)
Date: Wed, 16 Apr 2025 20:51:48 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Sam Day <me@samcday.com>
Cc: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
Subject: Re: [PATCH 1/3] usb: udc: ci: support USB gadget driver model
Message-ID: <Z__8RKVP37t6Aw1K@linaro.org>
References: <20250412-msm8916-usb-v1-0-2925239caf4b@samcday.com>
 <20250412-msm8916-usb-v1-1-2925239caf4b@samcday.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250412-msm8916-usb-v1-1-2925239caf4b@samcday.com>
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

On Sat, Apr 12, 2025 at 07:39:57PM +0000, Sam Day wrote:
> When CONFIG_DM_USB_GADGET is enabled, a UCLASS_USB_GADGET_GENERIC driver
> will be defined that wraps the ChipIdea UDC operations. The
> (dm_)?usb_gadget_.* symbols will no longer be defined (as these are now
> handled by the UDC uclass).
> 
> If CONFIG_DM_USB_GADGET is not enabled, this driver behaves as it
> previously did.
> 
> This new driver does not declare any compatibles of its own. It requires
> a glue driver to bind it. The ehci_msm driver will be updated in the
> following commit to do exactly that.
> 
> Signed-off-by: Sam Day <me@samcday.com>

Thanks a lot for working on this. Seems to work without problems on my
dragonboard410c. Just some minor nits below to reduce code duplication.

> ---
>  drivers/usb/gadget/ci_udc.c | 84 ++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 83 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/ci_udc.c b/drivers/usb/gadget/ci_udc.c
> index 4bff75da759ded6716641713fbe47f6ba79386dc..179f8540da30c693d11d772aacc00cc37f7669c5 100644
> --- a/drivers/usb/gadget/ci_udc.c
> +++ b/drivers/usb/gadget/ci_udc.c
> @@ -10,6 +10,7 @@
>  #include <command.h>
>  #include <config.h>
>  #include <cpu_func.h>
> +#include <dm.h>
>  #include <net.h>
>  #include <malloc.h>
>  #include <wait_bit.h>
> @@ -94,8 +95,18 @@ static struct usb_request *
>  ci_ep_alloc_request(struct usb_ep *ep, unsigned int gfp_flags);
>  static void ci_ep_free_request(struct usb_ep *ep, struct usb_request *_req);
>  
> +#if CONFIG_IS_ENABLED(DM_USB_GADGET)
> +static int ci_udc_gadget_start(struct usb_gadget *g,
> +		struct usb_gadget_driver *driver);
> +static int ci_udc_gadget_stop(struct usb_gadget *g);
> +#endif
> +
>  static const struct usb_gadget_ops ci_udc_ops = {
>  	.pullup = ci_pullup,
> +#if CONFIG_IS_ENABLED(DM_USB_GADGET)
> +	.udc_start = ci_udc_gadget_start,
> +	.udc_stop = ci_udc_gadget_stop,
> +#endif
>  };
>  
>  static const struct usb_ep_ops ci_ep_ops = {
> @@ -927,7 +938,7 @@ void udc_irq(void)
>  	}
>  }
>  
> -int dm_usb_gadget_handle_interrupts(struct udevice *dev)
> +static int ci_udc_handle_interrupts(struct udevice *dev)
>  {
>  	struct ci_udc *udc = (struct ci_udc *)controller.ctrl->hcor;
>  	u32 value;
> @@ -1072,6 +1083,71 @@ static int ci_udc_probe(void)
>  	return 0;
>  }
>  
> +#if CONFIG_IS_ENABLED(DM_USB_GADGET)
> +static int ci_udc_generic_probe(struct udevice *dev)
> +{
> +	int ret;
> +#if CONFIG_IS_ENABLED(DM_USB)
> +	ret = usb_setup_ehci_gadget(&controller.ctrl);
> +#else
> +	ret = usb_lowlevel_init(0, USB_INIT_DEVICE, (void **)&controller.ctrl);
> +#endif

...

> [...]
> +static int ci_udc_generic_remove(struct udevice *dev)
> +{
> +	usb_del_gadget_udc(&controller.gadget);
> +
> +	if (IS_ENABLED(CONFIG_DM_USB)) {
> +		usb_remove_ehci_gadget(&controller.ctrl);
> +	} else {
> +		usb_lowlevel_stop(0);
> +		controller.ctrl = NULL;
> +	}

This style is nice for compile testing. But in the probe() function
above you're still using the #if/#else pre-processor style. Can it use
if (IS_ENABLED(...)) too?

	if (IS_ENABLED(CONFIG_DM_USB))
		ret = usb_setup_ehci_gadget(&controller.ctrl);
	else
		ret = usb_lowlevel_init(0, USB_INIT_DEVICE, (void **)&controller.ctrl);
	if (ret)
		return ret;

This seems to compile at least.

If yes, can you make the same cleanup for the old !DM_USB_GADGET case,
so the two code paths are consistent?

> +
> +	return 0;
> +}
> +
> +static const struct usb_gadget_generic_ops ci_udc_generic_ops = {
> +	.handle_interrupts	= ci_udc_handle_interrupts,
> +};
> +
> +U_BOOT_DRIVER(ci_udc_generic) = {
> +	.name = "ci-udc",
> +	.id = UCLASS_USB_GADGET_GENERIC,
> +	.ops = &ci_udc_generic_ops,
> +	.probe = ci_udc_generic_probe,
> +	.remove = ci_udc_generic_remove,
> +};
> +
> +static int ci_udc_gadget_start(struct usb_gadget *g,
> +				 struct usb_gadget_driver *driver)
> +{
> +	controller.driver = driver;
> +	return 0;
> +}
> +
> +static int ci_udc_gadget_stop(struct usb_gadget *g)
> +{
> +	controller.driver = NULL;
> +	udc_disconnect();
> +
> +	ci_ep_free_request(&controller.ep[0].ep, &controller.ep0_req->req);
> +	free(controller.items_mem);
> +	free(controller.epts);
> +
> +	return 0;
> +}

I wonder if you could just define the start and stop function outside
the #if blocks and call them from usb_gadget_unregister_driver()
and usb_gadget_register_driver(). This would avoid duplicating the code,
reducing the risk that someone forgets to update one of those when
making changes.

The same could be also said for probe()/remove(), i.e. moving the

	if (IS_ENABLED(CONFIG_DM_USB)) {
		usb_remove_ehci_gadget(&controller.ctrl);
	} else {
		usb_lowlevel_stop(0);
		controller.ctrl = NULL;
	}

block to a separate function and calling that from both variants. Not
sure if that would also be worth it?

Thanks,
Stephan
