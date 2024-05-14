Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C46F8C04FFE
	for <u-boot@archiver.kernel.org>; Tue, 14 May 2024 12:52:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23384880F8;
	Tue, 14 May 2024 14:52:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BXr+YbJC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9381880C5; Tue, 14 May 2024 14:52:11 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3667880F8
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 14:52:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4200ee78f33so24466695e9.3
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 05:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715691129; x=1716295929;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=/l4HhfZfmHt1FeKpaqF6I1mqOV0CI60Gy5SvyEw6D08=;
 b=BXr+YbJCu1sIVdwQboug9cHwC6W7V2CEAQXdN7PfeaY3QV2qhy0w/Mabd/O6fw1GSO
 tlwdDW3V8uV5oMmqmWH7tAfpeag48YjqgxUlk8K8FME/sPS/uv0emnZ02IwaR/+4cN9P
 txhP+qc2Xpy3qPsstWw4zxHaaUY3zNnVH4ByWMf6Y33JKhtXuQvACKQY/J0y2z7EBjui
 m0j0Z4MMcFeawa+RS5knnRpWfhrBzX2xyF7qzFIek9oRwtkO1Hh/acVNeLlV/1881a2F
 X1aiHONYcyZn97tQP3CK3evuBTseuLx/RC/BTzucUETCivDKYLt5BbbLAKL+c4TscWRE
 a4cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715691129; x=1716295929;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/l4HhfZfmHt1FeKpaqF6I1mqOV0CI60Gy5SvyEw6D08=;
 b=MnTr0RTCNVT4IXU5SvAW+HOyWRFH33nXR4ObcpVQ882OcKPtzeNMmv/TH/f46IGAor
 rtM9hylmevXQweOzXre/aG9yynv3Al9af1jL5QXzJTyco5+e4ViAd+V4MMmFaYzj3Gt/
 taTZjDs0K0NfE2Vzyv9XOyQlZOh6ko8Em2d7ip/khlNiknH+Ltnh6TjtyVRuBVnE46si
 Z83w6TcHIfQOJzizHNoYev2bGdQrcdnFXmZwtTCDt1TiuX+5drNkr28W6u2m5lfZ3h87
 gaeHvXZ9/snpQy1oBXrDtoAK+PGHVU6EriM2AGCIickJ4tp5wXeHlg30Yu04vLVhqXYL
 jXsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPcQxbjU2VuolHW59YUAs3fUk/a+gknEivgpYjZ3nktiRso2HtpHHMTECkuquuUdRQItnVm+O+x3CPzqBgxI5beAOObQ==
X-Gm-Message-State: AOJu0Yx/6forUGYT2Jlk8xReEmv7T6Xt+8iwSBIsPCz5xbO2BM6+H/T3
 o9ulIF5aIVn8f6TO+h9SPjlq2TSXCmrR3pTaorPMXl1k/9eQCRVRKkd47RemcCo=
X-Google-Smtp-Source: AGHT+IHekw99H9HYMBnT63IeWV5T9iFI8cr/de7ZitP0TTxL0kPKx2qMEyEXmHVDroKxOTNcXO+ATQ==
X-Received: by 2002:a05:600c:45c5:b0:41b:a8e8:3ff6 with SMTP id
 5b1f17b1804b1-41fea93a4cfmr85817775e9.11.1715691129305; 
 Tue, 14 May 2024 05:52:09 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccfe1277sm188997015e9.42.2024.05.14.05.52.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 May 2024 05:52:08 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>, u-boot@lists.denx.de
Cc: Felipe Balbi <felipe.balbi@linux.intel.com>, Marek Vasut
 <marex@denx.de>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Nishanth Menon
 <nm@ti.com>, Sjoerd Simons <sjoerd@collabora.com>, Alexander Sverdlin
 <alexander.sverdlin@siemens.com>
Subject: Re: [PATCH 2/6] usb: dwc3: gadget: clear SUSPHY bit before ep cmds
In-Reply-To: <20240412202611.3565052-3-alexander.sverdlin@siemens.com>
References: <20240412202611.3565052-1-alexander.sverdlin@siemens.com>
 <20240412202611.3565052-3-alexander.sverdlin@siemens.com>
Date: Tue, 14 May 2024 14:52:07 +0200
Message-ID: <87zfss4kug.fsf@baylibre.com>
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
> Upstream Linux commit 2b0f11df84bb.
>
> Synopsys Databook 2.60a has a note that if we're
> sending an endpoint command we _must_ make sure that
> DWC3_GUSB2PHY(n).SUSPHY bit is cleared.
>
> This patch implements that particular detail.
>
> Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  drivers/usb/dwc3/gadget.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 17c19285f1c24..8f6513752f085 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -302,8 +302,25 @@ int dwc3_send_gadget_ep_cmd(struct dwc3 *dwc, unsigned ep,
>  {
>  	u32			timeout = 500;
>  	u32			reg;
> +
> +	int			susphy = false;
>  	int			ret = -EINVAL;
>  
> +	/*
> +	 * Synopsys Databook 2.60a states, on section 6.3.2.5.[1-8], that if
> +	 * we're issuing an endpoint command, we must check if
> +	 * GUSB2PHYCFG.SUSPHY bit is set. If it is, then we need to clear it.
> +	 *
> +	 * We will also set SUSPHY bit to what it was before returning as stated
> +	 * by the same section on Synopsys databook.
> +	 */
> +	reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
> +	if (unlikely(reg & DWC3_GUSB2PHYCFG_SUSPHY)) {
> +		susphy = true;
> +		reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
> +		dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
> +	}
> +
>  	dwc3_writel(dwc->regs, DWC3_DEPCMDPAR0(ep), params->param0);
>  	dwc3_writel(dwc->regs, DWC3_DEPCMDPAR1(ep), params->param1);
>  	dwc3_writel(dwc->regs, DWC3_DEPCMDPAR2(ep), params->param2);
> @@ -331,6 +348,12 @@ int dwc3_send_gadget_ep_cmd(struct dwc3 *dwc, unsigned ep,
>  		udelay(1);
>  	} while (1);
>  
> +	if (unlikely(susphy)) {
> +		reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
> +		reg |= DWC3_GUSB2PHYCFG_SUSPHY;
> +		dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
> +	}
> +
>  	return ret;
>  }
>  
> -- 
> 2.44.0
