Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84107C04FFE
	for <u-boot@archiver.kernel.org>; Tue, 14 May 2024 12:55:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAB77880F8;
	Tue, 14 May 2024 14:55:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="w+ncWqUn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 447A4880C5; Tue, 14 May 2024 14:55:14 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D9FF880F8
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 14:55:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-420160f8f52so14268845e9.0
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 05:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715691311; x=1716296111;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=3TyGFFmgXMxN2VeCCNCxDYVKdMirkH0hdWsB9PslaFI=;
 b=w+ncWqUnqrySq2iMupCSyYUeJ/4oswCND9qG8ldyv3ooGXQPcl7YrPJXQ02KYIJUKP
 qP9e0lCDckbh3XuZGVB+bXm+tlykfnsxDU6aR4V2VNbKN4yehvwFH2nvevkSfVrTAj7G
 usJgt4yPdQrksKaGCqI8XL/dKiYouJth/7ZMAStPM6NtTMG0/W5MsOt+2pcRA1FYfNaW
 6MFO4+RAS/LVbZN9orFRW10b3R5qsDvTD13XZ+lVs2aIiMD28Mj/i0f7OzbbgcR25CUs
 Ow921nhmQpqgIjhLPHmm5hiOsV+Q/aJybhoCkbgyE2vsSjQU9XYHioCn099VbLI51MD8
 VOSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715691311; x=1716296111;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3TyGFFmgXMxN2VeCCNCxDYVKdMirkH0hdWsB9PslaFI=;
 b=iW+JIGl1PlPYWLC0UgjHCH+ifTHpUmSiuVIyI3eu2JXS2khe1inaVdX8oXZq4TcqKV
 u42EOJzqHxNYhs7DcjQImxndH1TuwjbFgvwk0OXIZEtWZVh+AEaJOpD7OQfr3objX8/u
 c/QIFcuDv9c0yy0CyUVSZKBsGjLW9BVvr4y1vOq7P+75MUe3ncjbqLhQI9wdzvrjNadM
 O3GE0u9pLECQXQctv8IQh5qTUkkGXYAqcn7icdTtcliXyP7LGMkprt27tJqwltQO+hQB
 ZBHYTDx75eM3L3GtyomAyxeEPDVx4LS3wo7mwnb4cSVGWPshKnhetVoouTG0ATGo974c
 y+GQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIic+UDAQw1rl0pcssrHBLE+Ut/O2y9viMTRStXrnJF2idUD/AsSlLUJuMkaGHpnICEgN47fK+cF24g+aZhaROvNrG0A==
X-Gm-Message-State: AOJu0YwLDJIlW8s8aMIJJeI3s/CeoaxPe28y3aWURdmovCI1LkjziXjr
 DXEDc2JF4E4vYjJDe/4KMQWV0EkE2uqsf8qEmVvNdm16jsh43iLx3t7UNDdNecXz1PU4w2YrUS/
 ZccI=
X-Google-Smtp-Source: AGHT+IF/+fsDSMmaOxJU3wneS7AJaGvMp7HiDi0Pf+9BrERv5ZDkUISMptiw9zpc5fGELMyfJhRs4g==
X-Received: by 2002:a05:600c:45ce:b0:420:171c:3d70 with SMTP id
 5b1f17b1804b1-420171c3e17mr38267745e9.16.1715691311494; 
 Tue, 14 May 2024 05:55:11 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-420113d808bsm106529715e9.12.2024.05.14.05.55.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 May 2024 05:55:10 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>, u-boot@lists.denx.de
Cc: Felipe Balbi <felipe.balbi@linux.intel.com>, Marek Vasut
 <marex@denx.de>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Nishanth Menon
 <nm@ti.com>, Sjoerd Simons <sjoerd@collabora.com>, Alexander Sverdlin
 <alexander.sverdlin@siemens.com>
Subject: Re: [PATCH 3/6] usb: dwc3: gadget: only resume USB2 PHY in <=HIGHSPEED
In-Reply-To: <20240412202611.3565052-4-alexander.sverdlin@siemens.com>
References: <20240412202611.3565052-1-alexander.sverdlin@siemens.com>
 <20240412202611.3565052-4-alexander.sverdlin@siemens.com>
Date: Tue, 14 May 2024 14:55:10 +0200
Message-ID: <87wmnw4kpd.fsf@baylibre.com>
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

> From: Felipe Balbi <felipe.balbi@linux.intel.com>
>
> Upstream Linux commit ab2a92e7a608.
>
> As a micro-power optimization, let's only resume the
> USB2 PHY if we're working on <=HIGHSPEED. If we're
> gonna work on SUPERSPEED or SUPERSPEED+, there's no
> point in resuming the USB2 PHY.
>
> Fixes: 2b0f11df84bb ("usb: dwc3: gadget: clear SUSPHY bit before ep cmds")
> Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  drivers/usb/dwc3/gadget.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 8f6513752f085..00845dbadd27a 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -314,11 +314,13 @@ int dwc3_send_gadget_ep_cmd(struct dwc3 *dwc, unsigned ep,
>  	 * We will also set SUSPHY bit to what it was before returning as stated
>  	 * by the same section on Synopsys databook.
>  	 */
> -	reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
> -	if (unlikely(reg & DWC3_GUSB2PHYCFG_SUSPHY)) {
> -		susphy = true;
> -		reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
> -		dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
> +	if (dwc->gadget.speed <= USB_SPEED_HIGH) {
> +		reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
> +		if (unlikely(reg & DWC3_GUSB2PHYCFG_SUSPHY)) {
> +			susphy = true;
> +			reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
> +			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
> +		}
>  	}
>  
>  	dwc3_writel(dwc->regs, DWC3_DEPCMDPAR0(ep), params->param0);
> -- 
> 2.44.0
