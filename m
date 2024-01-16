Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED900C47077
	for <u-boot@archiver.kernel.org>; Tue, 16 Jan 2024 10:55:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FE10876E5;
	Tue, 16 Jan 2024 11:55:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EicaXe8a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 034FA84694; Tue, 16 Jan 2024 11:55:19 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7C5887897
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 11:55:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3376f71fcbbso7574399f8f.1
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 02:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1705402515; x=1706007315;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=f4G8i502nDVCqEL4qAvHlrYDQNckL0188WYqflwAp5U=;
 b=EicaXe8auinI5tW232+txxaGmrvFRJrf1R/eNx//IUbW3p8HxbLw2QXwTV228Zb3Ts
 QdJr075kJbxvCQAdYlGfLk8EvGREX7hx8LML5I0Rw3hORHcUhvwIpRkHtCApkOwi8FwA
 GXWaPD7J3W2duX9EHYbP5aQR5s1iKprQqWlhTDjmh9Nrf/2WuZlLL5G5ryGPMn/a/D91
 yxny5dgzHjWKK0dELAGpxZKyq+e/xMPQLXypdImOUJAIvgDniY+VdMgceV8qdVjNAYca
 5c33sP05zwlQnsFMBdDqo36HHF0sfEZQV9KT1Phf0weRpa7bv+DBVpZnXM6fXi55DEfO
 5boQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705402515; x=1706007315;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f4G8i502nDVCqEL4qAvHlrYDQNckL0188WYqflwAp5U=;
 b=mKmm77wDW+rIyVbklm1eWbFlk2iiESm1ukIzAl6xyLjQObXVGtX6UMYwGjGnKpKapM
 iWX+KLFYkrG6HP1RETjur39k99o9Voe/HTEZqy7GacpHQfFCkFZnkVUXBGlw3J8R2psZ
 /sxeqcuT/YfdBZ2Q9Tjl118M69cDOCikgIqhFU2sKlmkDGnhl6dzCeKdfS5T/nn/SavS
 1TnVwrC0OnLXSmCTpDlR9Rra5V8IR8/k+KUf7MAUH85nvkOoQdIkTcY8wgYu7XG8eYVF
 98rTlj3GuegXkyAe08GQQAEa+o85gdFr0o/m75Cd7LuUzblN4ADTtnrblWeqk73wL54g
 eG7g==
X-Gm-Message-State: AOJu0Yxj3YXfjyaiS0waFIn8uEQUdOe00gPbKxm38JyQE0pZPh91PrXU
 xoppPKnXQk+KWZ+8+gP2zPb+ScEEopPWcg==
X-Google-Smtp-Source: AGHT+IF39HD7SRxtVit+RrKXEWD8L3xl4EqIvvHm4y3bHtPY3owaH/8BwybgRzstsclX22CRTmu5nw==
X-Received: by 2002:adf:f10a:0:b0:337:3f72:3de3 with SMTP id
 r10-20020adff10a000000b003373f723de3mr2656505wro.46.1705402515286; 
 Tue, 16 Jan 2024 02:55:15 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 v23-20020a5d5917000000b00337876596d1sm14210153wrd.111.2024.01.16.02.55.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 02:55:14 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Caleb Connolly <caleb.connolly@linaro.org>, Sjoerd Simons
 <sjoerd@collabora.com>, u-boot@lists.denx.de
Cc: Martyn Welch <martyn.welch@collabora.com>, Roger Quadros
 <rogerq@kernel.org>, Nishanth Menon <nm@ti.com>, Igor Prusov
 <ivprusov@salutedevices.com>, Marek Vasut <marex@denx.de>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Simon Glass <sjg@chromium.org>, Svyatoslav
 Ryhel <clamor95@gmail.com>
Subject: Re: [PATCH v4 2/7] usb: dwc3: Switch to device mode on gadget start
In-Reply-To: <1274a3b8-f776-4cd5-9f3f-2bb47def44e4@linaro.org>
References: <20240112085317.1866449-1-sjoerd@collabora.com>
 <20240112085317.1866449-3-sjoerd@collabora.com>
 <1274a3b8-f776-4cd5-9f3f-2bb47def44e4@linaro.org>
Date: Tue, 16 Jan 2024 11:55:13 +0100
Message-ID: <87jzo94kfi.fsf@baylibre.com>
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

Hi Sjoerd, Caleb

On ven., janv. 12, 2024 at 12:55, Caleb Connolly <caleb.connolly@linaro.org> wrote:

> Hi Sjoerd,
>
> On 12/01/2024 08:52, Sjoerd Simons wrote:
>> When dr_mode is "otg" the dwc3 is initially configured in _OTG mode;
>> However in this mode the gadget functionality doesn't work without
>> further configuration. To resolve that on gadget start switch to _DEVICE
>> mode globally and go back to _OTG on stop again.
>> 
>> For this the dwc3_set_mode is renamed to dwc3_core_set_mode to avoid a
>> conflict with the same function exposed by xhci-dwc3
>
> I think exporting dwc3_core_set_mode() is probably sensible here. But
> I'm not so sure on calling it from dwc3_gadget_start(), that's making
> assumptions about board specific implementation details - some boards
> might require additional configuration to switch into gadget mode.

Indeed. As an example, take the Khadas VIM3 which has a glue driver to
do the mode switching.

>
> What about calling dwc3_core_set_mode() from within your board-specific
> board_usb_init() function?

With DM_USB_GADGET, board_usb_init/cleanup() are no longer used.

For VIM3, I solved this with:
https://lore.kernel.org/all/20221024-meson-dm-usb-v1-1-2ab077a503b9@baylibre.com/

Maybe that can help?

>
> Obviously as you said the ideal solution here is that we can correctly
> traverse the type-c connector model from within U-Boot, but that's a
> whole other kettle of fish :P
>
> On Qualcomm platforms I'm currently handling this by overriding the
> dr_mode property in a <board>-u-boot.dtsi file, if you aren't using the
> same DT for U-Boot and Linux then maybe this would be acceptable for you
> too?

I would prefer a <board>-u-boot.dtsi change as well.

>
> Kind regards,
>> 
>> Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
>> 
>> ---
>> 
>> Changes in v4:
>> - New patch
>> 
>>  drivers/usb/dwc3/core.c   | 10 +++++-----
>>  drivers/usb/dwc3/core.h   |  1 +
>>  drivers/usb/dwc3/gadget.c |  6 ++++++
>>  3 files changed, 12 insertions(+), 5 deletions(-)
>> 
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index 4b4fcd8a22e..d22d4c4bb6a 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -42,7 +42,7 @@
>>  static LIST_HEAD(dwc3_list);
>>  /* -------------------------------------------------------------------------- */
>>  
>> -static void dwc3_set_mode(struct dwc3 *dwc, u32 mode)
>> +void dwc3_core_set_mode(struct dwc3 *dwc, u32 mode)
>>  {
>>  	u32 reg;
>>  
>> @@ -736,7 +736,7 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
>>  
>>  	switch (dwc->dr_mode) {
>>  	case USB_DR_MODE_PERIPHERAL:
>> -		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_DEVICE);
>> +		dwc3_core_set_mode(dwc, DWC3_GCTL_PRTCAP_DEVICE);
>>  		ret = dwc3_gadget_init(dwc);
>>  		if (ret) {
>>  			dev_err(dwc->dev, "failed to initialize gadget\n");
>> @@ -744,7 +744,7 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
>>  		}
>>  		break;
>>  	case USB_DR_MODE_HOST:
>> -		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_HOST);
>> +		dwc3_core_set_mode(dwc, DWC3_GCTL_PRTCAP_HOST);
>>  		ret = dwc3_host_init(dwc);
>>  		if (ret) {
>>  			dev_err(dwc->dev, "failed to initialize host\n");
>> @@ -752,7 +752,7 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
>>  		}
>>  		break;
>>  	case USB_DR_MODE_OTG:
>> -		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_OTG);
>> +		dwc3_core_set_mode(dwc, DWC3_GCTL_PRTCAP_OTG);
>>  		ret = dwc3_host_init(dwc);
>>  		if (ret) {
>>  			dev_err(dwc->dev, "failed to initialize host\n");
>> @@ -810,7 +810,7 @@ static void dwc3_core_exit_mode(struct dwc3 *dwc)
>>  	 * switch back to peripheral mode
>>  	 * This enables the phy to enter idle and then, if enabled, suspend.
>>  	 */
>> -	dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_DEVICE);
>> +	dwc3_core_set_mode(dwc, DWC3_GCTL_PRTCAP_DEVICE);
>>  	dwc3_gadget_run(dwc);
>>  }
>>  
>> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
>> index 4162a682298..1e7eda89a34 100644
>> --- a/drivers/usb/dwc3/core.h
>> +++ b/drivers/usb/dwc3/core.h
>> @@ -1057,6 +1057,7 @@ int dwc3_gadget_resize_tx_fifos(struct dwc3 *dwc);
>>  void dwc3_of_parse(struct dwc3 *dwc);
>>  int dwc3_init(struct dwc3 *dwc);
>>  void dwc3_remove(struct dwc3 *dwc);
>> +void dwc3_core_set_mode(struct dwc3 *dwc, u32 mode);
>>  
>>  static inline int dwc3_host_init(struct dwc3 *dwc)
>>  { return 0; }
>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>> index 406d36ceafe..69d9fe40e2f 100644
>> --- a/drivers/usb/dwc3/gadget.c
>> +++ b/drivers/usb/dwc3/gadget.c
>> @@ -1468,6 +1468,9 @@ static int dwc3_gadget_start(struct usb_gadget *g,
>>  
>>  	dwc->gadget_driver	= driver;
>>  
>> +	if (dwc->dr_mode == DWC3_GCTL_PRTCAP_OTG)
>> +		dwc3_core_set_mode(dwc, DWC3_GCTL_PRTCAP_DEVICE);
>> +
>>  	reg = dwc3_readl(dwc->regs, DWC3_DCFG);
>>  	reg &= ~(DWC3_DCFG_SPEED_MASK);
>>  
>> @@ -1559,6 +1562,9 @@ static int dwc3_gadget_stop(struct usb_gadget *g)
>>  	__dwc3_gadget_ep_disable(dwc->eps[0]);
>>  	__dwc3_gadget_ep_disable(dwc->eps[1]);
>>  
>> +	if (dwc->dr_mode == DWC3_GCTL_PRTCAP_OTG)
>> +		dwc3_core_set_mode(dwc, DWC3_GCTL_PRTCAP_OTG);
>> +
>>  	dwc->gadget_driver	= NULL;
>>  
>>  	spin_unlock_irqrestore(&dwc->lock, flags);
>
> -- 
> // Caleb (they/them)
