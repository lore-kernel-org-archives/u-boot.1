Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 112EFC04FFE
	for <u-boot@archiver.kernel.org>; Tue, 14 May 2024 12:57:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85791882D4;
	Tue, 14 May 2024 14:57:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IVZqmZUk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1F07880F8; Tue, 14 May 2024 14:57:07 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4F2288312
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 14:57:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-522297f91bcso5180727e87.3
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 05:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715691423; x=1716296223;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=c3Xk2HyA0N06BUB+c8fdXeHbHypKSFd6cNq3Vchrfzc=;
 b=IVZqmZUk7MBPAyRgBVdYYA2mWoWPW0eVKS0eKuDuNkZ6FwRkD7QuoZpb4yWFJkwKU2
 DviSx6HcQBaVLCVVaSbqs2MV9WdFYUQo+NDA6eyLfP4o+Pk2Q79XEHoYrgpndNF97Xnl
 g4zmiDyehiwZbXxGifHlnQB+bfiA+ZJ/hIBeHWhUbgQ1LGXrM8BWMEh3ByU3Fwh6tiBn
 VEyMLlQ3OAFPjdj0e0pVYG7gO9+KhlwMVgwJT0aC0SqJIbcgvMxpn6XKTuKF2w3F1YUt
 GY2ylC+boPNkpp9ylqBxRt2cOTECs9urq0c5A+hUw+XkxsMQq7J47BcwdvpA2dTIiisS
 tGaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715691423; x=1716296223;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c3Xk2HyA0N06BUB+c8fdXeHbHypKSFd6cNq3Vchrfzc=;
 b=XLLAY3xfDpnoxh1fFjL3k1RHKfMVMnltQYqTwOUwtnKts9dMtJqYr7dohXfk0bDzt6
 GoyffZSWx38uujQhJ0jT+WDH6dceTTFQ1rcOl9yQ4rQysTPj2hE91INVMKoVk8BZ69TM
 Nwpos2TN92ciMsKyT8cTN0Dm5A8ByPDd5OEXv0UJk+vDjUvoJX/9ZcU3anW+BfI3iS2x
 v2Kkh+QmJTCC+k0mlKs3yXzqePjte4r4UmI00O+9WsLRYPcfuyynFfhGpXfHg3xIKjKC
 ULbkbHVRxdBrpfkf+Gy4wpQhSb/NK5QzNjbezg8MMKbJQUumERpbkuTy5UydcaEbfq1a
 YVnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7mJsIZfUxQBIupYpkNtOGpwMYc37gEUdVIQIRq4k/VxFzJkz+6X6C1V91EU59Zli/Ppc2XOmfcXXMktNMb6JMCFqMJw==
X-Gm-Message-State: AOJu0YwuXjPKRa6iXRdnBZmMl8oySketJtSYXJ/MBzSe3FQsptDlwq+r
 cxNa/x+22itTZZRfbVf4glP3z6/PA6sZ3VvVyn4doReaWWiGs299CqF9reEktqU=
X-Google-Smtp-Source: AGHT+IHNVvL6gzeHCvZU6ba65G/TjPrgyZgkCNe3p8OKhN2Crkkv4ecRRn7pOAQ/RTPE5jyDlw+S9g==
X-Received: by 2002:a05:6512:324a:b0:520:6fb:41d with SMTP id
 2adb3069b0e04-5221016e79bmr6612295e87.55.1715691422732; 
 Tue, 14 May 2024 05:57:02 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502baad1f0sm13758036f8f.89.2024.05.14.05.57.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 May 2024 05:57:02 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>, u-boot@lists.denx.de
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Marek Vasut <marex@denx.de>,
 Felipe Balbi <felipe.balbi@linux.intel.com>, Nishanth Menon <nm@ti.com>,
 Sjoerd Simons <sjoerd@collabora.com>, Thinh Nguyen <thinhn@synopsys.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>
Subject: Re: [PATCH 4/6] usb: dwc3: gadget: Check ENBLSLPM before sending ep
 command
In-Reply-To: <20240412202611.3565052-5-alexander.sverdlin@siemens.com>
References: <20240412202611.3565052-1-alexander.sverdlin@siemens.com>
 <20240412202611.3565052-5-alexander.sverdlin@siemens.com>
Date: Tue, 14 May 2024 14:57:01 +0200
Message-ID: <87ttj04kma.fsf@baylibre.com>
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

Hi Alexander,

Thank you for the patch.

On ven., avril 12, 2024 at 22:26, "A. Sverdlin" <alexander.sverdlin@siemens.com> wrote:

> From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
>
> Upstream Linux commit 87dd96111b0b.
>
> When operating in USB 2.0 speeds (HS/FS), if GUSB2PHYCFG.ENBLSLPM or
> GUSB2PHYCFG.SUSPHY is set, it must be cleared before issuing an endpoint
> command.
>
> Current implementation only save and restore GUSB2PHYCFG.SUSPHY
> configuration. We must save and clear both GUSB2PHYCFG.ENBLSLPM and
> GUSB2PHYCFG.SUSPHY settings. Restore them after the command is
> completed.
>
> DWC_usb3 3.30a and DWC_usb31 1.90a programming guide section 3.2.2
>
> Signed-off-by: Thinh Nguyen <thinhn@synopsys.com>
> Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  drivers/usb/dwc3/gadget.c | 29 +++++++++++++++++++----------
>  1 file changed, 19 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 00845dbadd27a..c14d7870b9461 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -301,26 +301,35 @@ int dwc3_send_gadget_ep_cmd(struct dwc3 *dwc, unsigned ep,
>  		unsigned cmd, struct dwc3_gadget_ep_cmd_params *params)
>  {
>  	u32			timeout = 500;
> +	u32			saved_config = 0;
>  	u32			reg;
>  
> -	int			susphy = false;
>  	int			ret = -EINVAL;
>  
>  	/*
> -	 * Synopsys Databook 2.60a states, on section 6.3.2.5.[1-8], that if
> -	 * we're issuing an endpoint command, we must check if
> -	 * GUSB2PHYCFG.SUSPHY bit is set. If it is, then we need to clear it.
> +	 * When operating in USB 2.0 speeds (HS/FS), if GUSB2PHYCFG.ENBLSLPM or
> +	 * GUSB2PHYCFG.SUSPHY is set, it must be cleared before issuing an
> +	 * endpoint command.
>  	 *
> -	 * We will also set SUSPHY bit to what it was before returning as stated
> -	 * by the same section on Synopsys databook.
> +	 * Save and clear both GUSB2PHYCFG.ENBLSLPM and GUSB2PHYCFG.SUSPHY
> +	 * settings. Restore them after the command is completed.
> +	 *
> +	 * DWC_usb3 3.30a and DWC_usb31 1.90a programming guide section 3.2.2
>  	 */
>  	if (dwc->gadget.speed <= USB_SPEED_HIGH) {
>  		reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
>  		if (unlikely(reg & DWC3_GUSB2PHYCFG_SUSPHY)) {
> -			susphy = true;
> +			saved_config |= DWC3_GUSB2PHYCFG_SUSPHY;
>  			reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
> -			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
>  		}
> +
> +		if (reg & DWC3_GUSB2PHYCFG_ENBLSLPM) {
> +			saved_config |= DWC3_GUSB2PHYCFG_ENBLSLPM;
> +			reg &= ~DWC3_GUSB2PHYCFG_ENBLSLPM;
> +		}
> +
> +		if (saved_config)
> +			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
>  	}
>  
>  	dwc3_writel(dwc->regs, DWC3_DEPCMDPAR0(ep), params->param0);
> @@ -350,9 +359,9 @@ int dwc3_send_gadget_ep_cmd(struct dwc3 *dwc, unsigned ep,
>  		udelay(1);
>  	} while (1);
>  
> -	if (unlikely(susphy)) {
> +	if (saved_config) {
>  		reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
> -		reg |= DWC3_GUSB2PHYCFG_SUSPHY;
> +		reg |= saved_config;
>  		dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
>  	}
>  
> -- 
> 2.44.0
