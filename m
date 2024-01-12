Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B67B5C4725D
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 12:55:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09E968309D;
	Fri, 12 Jan 2024 13:55:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RyJKQp3h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96EF780844; Fri, 12 Jan 2024 13:55:52 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0DF88309D
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 13:55:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-33765009941so5088840f8f.3
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 04:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705064149; x=1705668949; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TeqjHEcTaQ62TfH7KpMAmF0Mqpl0791pOZOmV1a/7bY=;
 b=RyJKQp3hg8ODnYyePK8YndCCMlNxDXtg0Yo26MnIXm4atp8ekJEns8UeLPfNUbMtq+
 2QGYVlJyWLqQeLuMlzNpWNq7xFaGCOz57GYhWzJvYrh9/lVtdHmsxHitTcMIPeuow8+P
 vSE/pD9ljVAe3OingZ5BQtbJ/u/XyG0HNcRfuPxxv2YKWVSxvj8hSuM23PJWpGAy3R7J
 pIdIGJGUqTIk13fyNXGDfR2xV1iyIPsJfQcToTtiUSCyQIbfmP0Xr2m/X48xb4Pio6UP
 qWwh2jrE9GfJvt7HOVl6KxfqLwAAdOpMR5ifzzMNpw5tj9C6KJXuHrHLrphd2vLkArVy
 CIsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705064149; x=1705668949;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TeqjHEcTaQ62TfH7KpMAmF0Mqpl0791pOZOmV1a/7bY=;
 b=nl4QtzUzVWZmNKPy2cTeh1OlqR2oIhPsZNq1BEMTno0K+2Vh9+CX9oJZDAg/lDAUI4
 r6RyL07/3ZhxgImcBYLP0X8vo2ZKbClP7qb/ZInK2LR0HAQpecVJzuWqVZ05DdYSJDt/
 ERjZGJhdWD11WVqCiBVbJvZzE1JItaP6qVPxcpS/CM8q86XBDAKKe/6kp2qv8pCLUW5y
 Ajh4h7iT2hfOHHX5N2ucr3ircSC0wC6TJR2aBn31zY1rj9DSvHSL+xKy4/ri7qljK95F
 74SZYUtdiBaRnK/n/q6H7JD6b0OmLRzbsw5sFpjpEFRIO4fQZTaaWyx7APlzXGRZEE4G
 5gog==
X-Gm-Message-State: AOJu0YwewI1LYPe72iiuZ1we040cBALWt9HKK2oAcVkmrLM2ghaaxA5i
 fKBbDaaP9HGmVdccxKe7qi2J2pU2S3cxYw==
X-Google-Smtp-Source: AGHT+IH9pPgpYuocIu0I39Wu0y1E74gfYIiwvWc1tV8rI0X7AGweY1lENnJPVUPIk6ILi/zWaVH5Iw==
X-Received: by 2002:a5d:6087:0:b0:336:4a0e:4c81 with SMTP id
 w7-20020a5d6087000000b003364a0e4c81mr692690wrt.135.1705064149154; 
 Fri, 12 Jan 2024 04:55:49 -0800 (PST)
Received: from [192.168.1.83] (host-92-17-96-230.as13285.net. [92.17.96.230])
 by smtp.gmail.com with ESMTPSA id
 c1-20020a5d4f01000000b003377be178a5sm3823771wru.78.2024.01.12.04.55.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jan 2024 04:55:48 -0800 (PST)
Message-ID: <1274a3b8-f776-4cd5-9f3f-2bb47def44e4@linaro.org>
Date: Fri, 12 Jan 2024 12:55:47 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/7] usb: dwc3: Switch to device mode on gadget start
Content-Language: en-US
To: Sjoerd Simons <sjoerd@collabora.com>, u-boot@lists.denx.de
Cc: Martyn Welch <martyn.welch@collabora.com>,
 Roger Quadros <rogerq@kernel.org>, Nishanth Menon <nm@ti.com>,
 Igor Prusov <ivprusov@salutedevices.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Simon Glass
 <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>
References: <20240112085317.1866449-1-sjoerd@collabora.com>
 <20240112085317.1866449-3-sjoerd@collabora.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240112085317.1866449-3-sjoerd@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Sjoerd,

On 12/01/2024 08:52, Sjoerd Simons wrote:
> When dr_mode is "otg" the dwc3 is initially configured in _OTG mode;
> However in this mode the gadget functionality doesn't work without
> further configuration. To resolve that on gadget start switch to _DEVICE
> mode globally and go back to _OTG on stop again.
> 
> For this the dwc3_set_mode is renamed to dwc3_core_set_mode to avoid a
> conflict with the same function exposed by xhci-dwc3

I think exporting dwc3_core_set_mode() is probably sensible here. But
I'm not so sure on calling it from dwc3_gadget_start(), that's making
assumptions about board specific implementation details - some boards
might require additional configuration to switch into gadget mode.

What about calling dwc3_core_set_mode() from within your board-specific
board_usb_init() function?

Obviously as you said the ideal solution here is that we can correctly
traverse the type-c connector model from within U-Boot, but that's a
whole other kettle of fish :P

On Qualcomm platforms I'm currently handling this by overriding the
dr_mode property in a <board>-u-boot.dtsi file, if you aren't using the
same DT for U-Boot and Linux then maybe this would be acceptable for you
too?

Kind regards,
> 
> Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
> 
> ---
> 
> Changes in v4:
> - New patch
> 
>  drivers/usb/dwc3/core.c   | 10 +++++-----
>  drivers/usb/dwc3/core.h   |  1 +
>  drivers/usb/dwc3/gadget.c |  6 ++++++
>  3 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 4b4fcd8a22e..d22d4c4bb6a 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -42,7 +42,7 @@
>  static LIST_HEAD(dwc3_list);
>  /* -------------------------------------------------------------------------- */
>  
> -static void dwc3_set_mode(struct dwc3 *dwc, u32 mode)
> +void dwc3_core_set_mode(struct dwc3 *dwc, u32 mode)
>  {
>  	u32 reg;
>  
> @@ -736,7 +736,7 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
>  
>  	switch (dwc->dr_mode) {
>  	case USB_DR_MODE_PERIPHERAL:
> -		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_DEVICE);
> +		dwc3_core_set_mode(dwc, DWC3_GCTL_PRTCAP_DEVICE);
>  		ret = dwc3_gadget_init(dwc);
>  		if (ret) {
>  			dev_err(dwc->dev, "failed to initialize gadget\n");
> @@ -744,7 +744,7 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
>  		}
>  		break;
>  	case USB_DR_MODE_HOST:
> -		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_HOST);
> +		dwc3_core_set_mode(dwc, DWC3_GCTL_PRTCAP_HOST);
>  		ret = dwc3_host_init(dwc);
>  		if (ret) {
>  			dev_err(dwc->dev, "failed to initialize host\n");
> @@ -752,7 +752,7 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
>  		}
>  		break;
>  	case USB_DR_MODE_OTG:
> -		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_OTG);
> +		dwc3_core_set_mode(dwc, DWC3_GCTL_PRTCAP_OTG);
>  		ret = dwc3_host_init(dwc);
>  		if (ret) {
>  			dev_err(dwc->dev, "failed to initialize host\n");
> @@ -810,7 +810,7 @@ static void dwc3_core_exit_mode(struct dwc3 *dwc)
>  	 * switch back to peripheral mode
>  	 * This enables the phy to enter idle and then, if enabled, suspend.
>  	 */
> -	dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_DEVICE);
> +	dwc3_core_set_mode(dwc, DWC3_GCTL_PRTCAP_DEVICE);
>  	dwc3_gadget_run(dwc);
>  }
>  
> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> index 4162a682298..1e7eda89a34 100644
> --- a/drivers/usb/dwc3/core.h
> +++ b/drivers/usb/dwc3/core.h
> @@ -1057,6 +1057,7 @@ int dwc3_gadget_resize_tx_fifos(struct dwc3 *dwc);
>  void dwc3_of_parse(struct dwc3 *dwc);
>  int dwc3_init(struct dwc3 *dwc);
>  void dwc3_remove(struct dwc3 *dwc);
> +void dwc3_core_set_mode(struct dwc3 *dwc, u32 mode);
>  
>  static inline int dwc3_host_init(struct dwc3 *dwc)
>  { return 0; }
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 406d36ceafe..69d9fe40e2f 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -1468,6 +1468,9 @@ static int dwc3_gadget_start(struct usb_gadget *g,
>  
>  	dwc->gadget_driver	= driver;
>  
> +	if (dwc->dr_mode == DWC3_GCTL_PRTCAP_OTG)
> +		dwc3_core_set_mode(dwc, DWC3_GCTL_PRTCAP_DEVICE);
> +
>  	reg = dwc3_readl(dwc->regs, DWC3_DCFG);
>  	reg &= ~(DWC3_DCFG_SPEED_MASK);
>  
> @@ -1559,6 +1562,9 @@ static int dwc3_gadget_stop(struct usb_gadget *g)
>  	__dwc3_gadget_ep_disable(dwc->eps[0]);
>  	__dwc3_gadget_ep_disable(dwc->eps[1]);
>  
> +	if (dwc->dr_mode == DWC3_GCTL_PRTCAP_OTG)
> +		dwc3_core_set_mode(dwc, DWC3_GCTL_PRTCAP_OTG);
> +
>  	dwc->gadget_driver	= NULL;
>  
>  	spin_unlock_irqrestore(&dwc->lock, flags);

-- 
// Caleb (they/them)
