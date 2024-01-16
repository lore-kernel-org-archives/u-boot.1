Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D7FEC4706C
	for <u-boot@archiver.kernel.org>; Tue, 16 Jan 2024 10:46:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E8B3876E5;
	Tue, 16 Jan 2024 11:46:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qW/PJDph";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F0D987985; Tue, 16 Jan 2024 11:46:32 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0872876E5
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 11:46:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40e7065b692so24833275e9.3
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 02:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1705401989; x=1706006789;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=5pOOGlEDXuBOoY/+3mqavNfKbcwDc8T+8I4Rs4YUc1w=;
 b=qW/PJDph0af6f8jHdySeRjZF+xl3L2L11ZGTpx9uTo964gy1klDdVtYqrMXFBKTh1q
 jlCXS7gpDRBj99VnnpjFtJdfzOt6QVTug3xaLriBN9guYISEQADuJHZZ9B6Qm3DWiYv3
 YReCM8jSXQcOc/pFeanjUJS+4oj+Gq8wh0P1vCyQi7dzKLKVaMYlpvb3kScYtKt0LYHt
 6mWQoFGMedRFf/FGLMyOnlVqCuSwMRmBi7gNbKGEISVphPLbyRlgv41HaTdG0SP+rh4l
 IZMpNdETREPqE0DLL0nd7wgrEWm+pPJNxnWLtdsRjBeqs5NzK1KYgnSrW7uTinDCV2dn
 Dhhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705401989; x=1706006789;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5pOOGlEDXuBOoY/+3mqavNfKbcwDc8T+8I4Rs4YUc1w=;
 b=SJH2SD+NXioBjH4/UpC4jgCwjvGjf9OMHI6USY+6TRk68NFYJ3UCw5bCTen+BWmYgw
 vOPcRopN5w5RaRD5TjPdpcm8YzaF68/+hMdLQKtiQ7Ijm8dxkjN6eD7gik6NGDWD9kE5
 KjPye1r0eD0Ap0efrsockdJedWW442KreIY5TSBIJquiDMc6z0lw1/vrMlH8PCpM5PWZ
 EPiajNLOvyAifhKhUXw+TwlKnZP9YfYQEo0ky4amD2pcRmG/uAJRdYcqw/tiVt0XoSQ+
 qyWnODMZ1J7fuDPq88vQT05h9KReMarLbLINAcW7m6zYn7mb6IakdnTde5c5FfcD3du1
 9niw==
X-Gm-Message-State: AOJu0YxPbyCyH/8luUeoHLyQRymvwYGy1hawkWCsB4b47awhxN5RsW+l
 XAN+jJNe14O2IHprzbMuMYqvyvY79nNELg==
X-Google-Smtp-Source: AGHT+IEnNzfKfdkiPhK8CTRiuv4wPj0gyyS/0OXT+MTPZ4majB52vNsfAZaJj3iNbOzkaKiNQ7XPsQ==
X-Received: by 2002:a05:600c:4b1a:b0:40e:768d:b267 with SMTP id
 i26-20020a05600c4b1a00b0040e768db267mr1965910wmp.41.1705401988943; 
 Tue, 16 Jan 2024 02:46:28 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 r20-20020a05600c35d400b0040d8eca092esm22903952wmq.47.2024.01.16.02.46.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 02:46:28 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Sjoerd Simons <sjoerd@collabora.com>, u-boot@lists.denx.de
Cc: Martyn Welch <martyn.welch@collabora.com>, Roger Quadros
 <rogerq@kernel.org>, Nishanth Menon <nm@ti.com>, Caleb Connolly
 <caleb.connolly@linaro.org>, Igor Prusov <ivprusov@salutedevices.com>,
 Marek Vasut <marex@denx.de>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Simon Glass <sjg@chromium.org>, Svyatoslav
 Ryhel <clamor95@gmail.com>
Subject: Re: [PATCH v4 2/7] usb: dwc3: Switch to device mode on gadget start
In-Reply-To: <20240112085317.1866449-3-sjoerd@collabora.com>
References: <20240112085317.1866449-1-sjoerd@collabora.com>
 <20240112085317.1866449-3-sjoerd@collabora.com>
Date: Tue, 16 Jan 2024 11:46:27 +0100
Message-ID: <87mst54ku4.fsf@baylibre.com>
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

Hi Sjoerd,

Thank you for the patch.

On ven., janv. 12, 2024 at 09:52, Sjoerd Simons <sjoerd@collabora.com> wrote:

> When dr_mode is "otg" the dwc3 is initially configured in _OTG mode;
> However in this mode the gadget functionality doesn't work without
> further configuration. To resolve that on gadget start switch to _DEVICE
> mode globally and go back to _OTG on stop again.
>
> For this the dwc3_set_mode is renamed to dwc3_core_set_mode to avoid a
> conflict with the same function exposed by xhci-dwc3
>
> Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

nitpick below.

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

Doesn't this bit deserves a comment ? When looking at the code it's not
obvious that we do this because PRTCAP_OTG is non-functional without any
additional configuration.

Maybe something in the lines of:

   /**
    * WORKAROUND: in OTG mode, gadget functionality is non-functional.
    * Switch to gadget mode only to enable gadget mode
    */

?

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
> -- 
> 2.43.0
