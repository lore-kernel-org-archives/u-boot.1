Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82B0DC25B76
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 07:56:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A070888398;
	Tue, 11 Jun 2024 09:56:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UoDxzHs/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 737E8885F2; Tue, 11 Jun 2024 09:56:17 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BAF588398
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 09:56:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4217f2e3450so23944275e9.1
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 00:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718092575; x=1718697375;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=KJmqaAbcywqWLZ6fPVgOhOIxBvifrl0/cDeloSg1vWE=;
 b=UoDxzHs/0guN1sMMWRZtCyOqT5wXB9zgSJVUlKWl/BiZPKjB9NsN7VZkNMM134LgEZ
 En39aQzgmjw3kyd+AY35ZBCeOAZR1yoPVhl/SWawq/Zn24diC04MZPFAFEnxM+7CQcNL
 Ss0D8pezFpOwogsi03bSRzLnLRN6iI70FoxC5Lwz8ufgQQe7wnvjCXRzOMm7PJ0kLW0T
 HMtB75vVDjScCTOxBG7w+cRtXZ73oTQvX7totosoZY3Y7i9eB1rnQ/e7JzljO07Zohas
 FfciTtI2vpb7ZavnEWBjHkPlVD7xku3v7r1ZsZBf20pCUCrUdb0qVqU43sj0hE+ai41N
 x7+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718092575; x=1718697375;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KJmqaAbcywqWLZ6fPVgOhOIxBvifrl0/cDeloSg1vWE=;
 b=Ttl7199GJ8G3gJo0eoYcpldJEIMNwM6hUBCycx7qhDFM2zn+gvhDjiiHFe4bCbsS5+
 hPYoJum1vRvTRGocMvM4m6CHM6cfSmipTBJmaCra9v+hMaaTI+wzhbzem/BJdKKPkHC3
 PXhTNR61cSq8Cries3JvtU7nVxJneBe+ImvICouzykbsYVMzdwqUZYVASTTQHRJEIaM2
 l1QsfNCKMuZ7s7WRlN4lA/tZws9c9TG9ImbhVUIinaA4Pm9+vblaoNL7uXDJ/HTCmbnn
 JunsDWZBtATIjbJie67+YdnAbrv9G47sgfDElK0OhImPkwymNL/a8s1eKArYgilF+UFk
 L+kw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8/qmUW0BKDATCVBc4HagcZ9Q/hbJKvROdQv9MT5Z+P3GOaitYAO0dX0pI3XYtnuM6LLOj/JnBHQ6DkpmKwSdSnU+kYw==
X-Gm-Message-State: AOJu0YyieW35+rKmvK6y7SmYfj12H+N/xeQcCn32Q+YAgP8GDzXlVsHE
 +djdsSyHpuiv3mNi80Ff0kqsWTC+n64oeiYBDQjdH3IoGi/qG1fU9tfmbSzR1j0=
X-Google-Smtp-Source: AGHT+IG700IW4tauCGqxx9y3vuSRv0t0OxJAYeZ8wnNxIFPVjcd6QIsHU6IGRDXT8m7cXX7lbLjq9w==
X-Received: by 2002:a5d:6383:0:b0:35f:1bc3:ae71 with SMTP id
 ffacd0b85a97d-35f1bc3aff5mr5794181f8f.63.1718092574621; 
 Tue, 11 Jun 2024 00:56:14 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35f2c3fd63fsm1249224f8f.51.2024.06.11.00.56.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 00:56:14 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de, Li
 Jun <jun.li@nxp.com>, Peng Fan <peng.fan@nxp.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, Alexander Sverdlin
 <alexander.sverdlin@siemens.com>, Felipe Balbi
 <felipe.balbi@linux.intel.com>, Lukasz Majewski <lukma@denx.de>, Nishanth
 Menon <nm@ti.com>, Simon Glass <sjg@chromium.org>, Thinh Nguyen
 <Thinh.Nguyen@synopsys.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 6/6] usb: dwc3: gadget: Convert epautoconf workaround to
 match_ep callback
In-Reply-To: <20240609213449.194762-6-marek.vasut+renesas@mailbox.org>
References: <20240609213449.194762-1-marek.vasut+renesas@mailbox.org>
 <20240609213449.194762-6-marek.vasut+renesas@mailbox.org>
Date: Tue, 11 Jun 2024 09:56:11 +0200
Message-ID: <87v82fzzdw.fsf@baylibre.com>
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

Hi Marek,

Thank you for the patch.

On dim., juin 09, 2024 at 23:32, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:

> Use the .match_ep() callback instead of workaround in core code.
> Replace descriptor parsing with ch9 macros with the same effect.
> Drop the SPL specific behavior, it is unclear why SPL should even
> be special.

Li, Peng,

Is this good for you as well?

You seem to be the author/committer of:
c93edbf5385e ("usb: gadget: don't change ep name for dwc3 while ep autoconfig")

I'd like to make sure this patch does not break your use-case.
Please let me know within 2 weeks or so, otherwise I'll apply the changes.

>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

To me, this looks good.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com> # on vim3

> ---
> Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> Cc: Felipe Balbi <felipe.balbi@linux.intel.com>
> Cc: Lukasz Majewski <lukma@denx.de>
> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>  drivers/usb/dwc3/gadget.c       | 33 +++++++++++++++++++++++
>  drivers/usb/gadget/epautoconf.c | 46 +--------------------------------
>  2 files changed, 34 insertions(+), 45 deletions(-)
>
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index fab32575647..3ef2f016a60 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -1606,6 +1606,38 @@ static int dwc3_gadget_stop(struct usb_gadget *g)
>  	return 0;
>  }
>  
> +static struct usb_ep *dwc3_find_ep(struct usb_gadget *gadget, const char *name)
> +{
> +	struct usb_ep *ep;
> +
> +	list_for_each_entry(ep, &gadget->ep_list, ep_list)
> +		if (!strcmp(ep->name, name))
> +			return ep;
> +
> +	return NULL;
> +}
> +
> +static struct
> +usb_ep *dwc3_gadget_match_ep(struct usb_gadget *gadget,
> +			     struct usb_endpoint_descriptor *desc,
> +			     struct usb_ss_ep_comp_descriptor *comp_desc)
> +{
> +	/*
> +	 * First try standard, common configuration: ep1in-bulk,
> +	 * ep2out-bulk, ep3in-int to match other udc drivers to avoid
> +	 * confusion in already deployed software (endpoint numbers
> +	 * hardcoded in userspace software/drivers)
> +	 */
> +	if (usb_endpoint_is_bulk_in(desc))
> +		return dwc3_find_ep(gadget, "ep1in");
> +	if (usb_endpoint_is_bulk_out(desc))
> +		return dwc3_find_ep(gadget, "ep2out");
> +	if (usb_endpoint_is_int_in(desc))
> +		return dwc3_find_ep(gadget, "ep3in");
> +
> +	return NULL;
> +}
> +
>  static const struct usb_gadget_ops dwc3_gadget_ops = {
>  	.get_frame		= dwc3_gadget_get_frame,
>  	.wakeup			= dwc3_gadget_wakeup,
> @@ -1613,6 +1645,7 @@ static const struct usb_gadget_ops dwc3_gadget_ops = {
>  	.pullup			= dwc3_gadget_pullup,
>  	.udc_start		= dwc3_gadget_start,
>  	.udc_stop		= dwc3_gadget_stop,
> +	.match_ep		= dwc3_gadget_match_ep,
>  };
>  
>  /* -------------------------------------------------------------------------- */
> diff --git a/drivers/usb/gadget/epautoconf.c b/drivers/usb/gadget/epautoconf.c
> index 66599ce8efa..a4da4f72de9 100644
> --- a/drivers/usb/gadget/epautoconf.c
> +++ b/drivers/usb/gadget/epautoconf.c
> @@ -166,18 +166,6 @@ static int ep_matches(
>  	return 1;
>  }
>  
> -static struct usb_ep *
> -find_ep(struct usb_gadget *gadget, const char *name)
> -{
> -	struct usb_ep	*ep;
> -
> -	list_for_each_entry(ep, &gadget->ep_list, ep_list) {
> -		if (0 == strcmp(ep->name, name))
> -			return ep;
> -	}
> -	return NULL;
> -}
> -
>  /**
>   * usb_ep_autoconfig - choose an endpoint matching the descriptor
>   * @gadget: The device to which the endpoint must belong.
> @@ -213,39 +201,7 @@ struct usb_ep *usb_ep_autoconfig(
>  	struct usb_endpoint_descriptor	*desc
>  )
>  {
> -	struct usb_ep	*ep = NULL;
> -	u8		type;
> -
> -	type = desc->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK;
> -
> -	/* First, apply chip-specific "best usage" knowledge.
> -	 * This might make a good usb_gadget_ops hook ...
> -	 */
> -	if (!IS_ENABLED(CONFIG_SPL_BUILD) &&
> -	    IS_ENABLED(CONFIG_USB_DWC3_GADGET) &&
> -	    !strcmp("dwc3-gadget", gadget->name)) {
> -		const char *name = NULL;
> -		/*
> -		 * First try standard, common configuration: ep1in-bulk,
> -		 * ep2out-bulk, ep3in-int to match other udc drivers to avoid
> -		 * confusion in already deployed software (endpoint numbers
> -		 * hardcoded in userspace software/drivers)
> -		 */
> -		if ((desc->bEndpointAddress & USB_DIR_IN) &&
> -		    type == USB_ENDPOINT_XFER_BULK)
> -			name = "ep1in";
> -		else if ((desc->bEndpointAddress & USB_DIR_IN) == 0 &&
> -			 type == USB_ENDPOINT_XFER_BULK)
> -			name = "ep2out";
> -		else if ((desc->bEndpointAddress & USB_DIR_IN) &&
> -			 type == USB_ENDPOINT_XFER_INT)
> -			name = "ep3in";
> -
> -		if (name)
> -			ep = find_ep(gadget, name);
> -		if (ep && ep_matches(gadget, ep, desc))
> -			return ep;
> -	}
> +	struct usb_ep *ep;
>  
>  	if (gadget->ops->match_ep) {
>  		ep = gadget->ops->match_ep(gadget, desc, NULL);
> -- 
> 2.43.0
