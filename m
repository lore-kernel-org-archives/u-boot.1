Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01815C4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 13:39:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C6EC88374;
	Thu,  2 May 2024 15:39:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tmcTGh+b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 799C588377; Thu,  2 May 2024 15:39:20 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D62A882D0
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 15:39:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a58d0aea14cso858280166b.2
 for <u-boot@lists.denx.de>; Thu, 02 May 2024 06:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714657157; x=1715261957; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tseZyvTBIRu1GJaaCErqWELEm7LGKnImKJb6E8ED87U=;
 b=tmcTGh+b97frqbErKDvWs7+HJ9lc849hCLLOl2b81rTlzwG3P6JL2znH6jF05fv8AT
 Kf9zfxvU+LCzD0Qc8iGRWknza7rx3bONjgqBik+H3yH5MGPRSx1oF5jhU/TVa0VJxWht
 v9acrAUsaRSyvW9i8Yd7EbaPYIXtIB5kTVG0FEwUdfjNB6EPPAHq/cwienDV7RTunglB
 aKRDUPUhMuGN/W9yMtF1tqIssactTtSMgmEdVDR/41z/XR9M8XKDf0LDRPL/ZUchppax
 8irNMPG+mzbhEb8vkHyIIyLV7Ew/OwyTaMiCtM8K9WmQqYGFautPnLo4L1gmPxqCFDBb
 prnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714657157; x=1715261957;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tseZyvTBIRu1GJaaCErqWELEm7LGKnImKJb6E8ED87U=;
 b=CQxqaHFl/GCpW5G0Ig7Rt1N1Ph2T1cV2E5dF848S6ylU1oGkMV05U6k8kpazADD75H
 vL+DdOIYywylWlXpH+jPFLNjgDk3lOpV/RZaz3LCUqa5mnq9WI972rsE24fWC1OP3Is/
 IN+qSGtxGu2+Opnrh5SPRwPCkc+zng0PoHfyLmzWBR0FAtPth0VVs4SK+0vJJRLDFJAy
 wKVkxdM+Nb20FSNsz17dYUiKSE/VCUyJa/72kJs9t9ggyzTKU5FzTqwT8ajnoLJw+BuT
 YpeUn6iyguTuH3Db/iyAPRL5Kc5yOhVCo5Qom+VMN7u7XuY7YbNmSKfsjGXkLmDrAL7z
 NbNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDzqv6DPnnpurn4A4yUtWpuInGFiUMwQ1Yjr1Q2f+pS4Twu/jr20z8f3M7X33kqwfTL6AzhriSzCrDGm1VljNFxtvsPg==
X-Gm-Message-State: AOJu0YwFXv2Q9bwIRP4DwN2VD5sIovFSt+hfLMegP0OAXMqxA9UA9BFq
 PboKgokzUzkWim/bFJYD9dj773GkvYpsleLtkYcZfneM2q1Mnv5s7vi/mpbW5LPMfuO8EZsncmv
 79618KA==
X-Google-Smtp-Source: AGHT+IFnf7TG7TCtTIAhyxRohaOtuRmnYoKRQsAOGak5vDQF9Mhoa8N+nwlHC1goshUv8x+4/B8xoQ==
X-Received: by 2002:a50:aad3:0:b0:565:dfac:a686 with SMTP id
 r19-20020a50aad3000000b00565dfaca686mr3849020edc.38.1714657156963; 
 Thu, 02 May 2024 06:39:16 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::8bb3? ([2a02:8109:aa0d:be00::8bb3])
 by smtp.gmail.com with ESMTPSA id
 cq27-20020a056402221b00b005727eb1ed6asm540403edb.68.2024.05.02.06.39.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 May 2024 06:39:16 -0700 (PDT)
Message-ID: <8652f1b6-2115-454a-8da8-b24622d1e0cd@linaro.org>
Date: Thu, 2 May 2024 15:39:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ehci: msm: bring up iface + core clocks
To: Sam Day <me@samcday.com>, u-boot@lists.denx.de
References: <20240502-msm8916-hs-usb-clocks-v1-0-eeccf483b68d@samcday.com>
 <20240502-msm8916-hs-usb-clocks-v1-2-eeccf483b68d@samcday.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240502-msm8916-hs-usb-clocks-v1-2-eeccf483b68d@samcday.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 02/05/2024 15:16, Sam Day wrote:
> This seems to be necessary on my samsung-a5. Without this patch, the
> first access of EHCI registers causes a bus stall and subsequent reset.
> 
> I am unsure why this wasn't already necessary for db410c, perhaps those
> clocks are already enabled on boot.
> 
> Signed-off-by: Sam Day <me@samcday.com>
> ---
>   drivers/usb/host/ehci-msm.c | 37 +++++++++++++++++++++++++++++++++++--
>   1 file changed, 35 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-msm.c b/drivers/usb/host/ehci-msm.c
> index 98fe7bc3bc..b2e294dd64 100644
> --- a/drivers/usb/host/ehci-msm.c
> +++ b/drivers/usb/host/ehci-msm.c
> @@ -7,8 +7,10 @@
>    * Based on Linux driver
>    */
>   
> +#include <clk.h>
>   #include <common.h>
>   #include <dm.h>
> +#include <dm/device_compat.h>
>   #include <dm/lists.h>
>   #include <errno.h>
>   #include <usb.h>
> @@ -25,6 +27,8 @@ struct msm_ehci_priv {
>   	struct usb_ehci *ehci; /* Start of IP core*/
>   	struct ulpi_viewport ulpi_vp; /* ULPI Viewport */
>   	struct phy phy;
> +	struct clk iface_clk;
> +	struct clk core_clk;

You could simplify this with the bulk clock API, but I'm easy either way.

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
>   };
>   
>   static int msm_init_after_reset(struct ehci_ctrl *dev)
> @@ -53,20 +57,46 @@ static int ehci_usb_probe(struct udevice *dev)
>   	struct ehci_hcor *hcor;
>   	int ret;
>   
> +	ret = clk_get_by_name(dev, "core", &p->core_clk);
> +	if (ret) {
> +		dev_err(dev, "Failed to get core clock: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = clk_get_by_name(dev, "iface", &p->iface_clk);
> +	if (ret) {
> +		dev_err(dev, "Failed to get iface clock: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = clk_prepare_enable(&p->core_clk);
> +	if (ret)
> +		return ret;
> +
> +	ret = clk_prepare_enable(&p->iface_clk);
> +	if (ret)
> +		goto cleanup_core;
> +
>   	hccr = (struct ehci_hccr *)((phys_addr_t)&ehci->caplength);
>   	hcor = (struct ehci_hcor *)((phys_addr_t)hccr +
>   			HC_LENGTH(ehci_readl(&(hccr)->cr_capbase)));
>   
>   	ret = generic_setup_phy(dev, &p->phy, 0);
>   	if (ret)
> -		return ret;
> +		goto cleanup_iface;
>   
>   	ret = board_usb_init(0, plat->init_type);
>   	if (ret < 0)
> -		return ret;
> +		goto cleanup_iface;
>   
>   	return ehci_register(dev, hccr, hcor, &msm_ehci_ops, 0,
>   			     plat->init_type);
> +
> +cleanup_iface:
> +	clk_disable_unprepare(&p->iface_clk);
> +cleanup_core:
> +	clk_disable_unprepare(&p->core_clk);
> +	return ret;
>   }
>   
>   static int ehci_usb_remove(struct udevice *dev)
> @@ -82,6 +112,9 @@ static int ehci_usb_remove(struct udevice *dev)
>   	/* Stop controller. */
>   	clrbits_le32(&ehci->usbcmd, CMD_RUN);
>   
> +	clk_disable_unprepare(&p->iface_clk);
> +	clk_disable_unprepare(&p->core_clk);
> +
>   	ret = generic_shutdown_phy(&p->phy);
>   	if (ret)
>   		return ret;
> 

-- 
// Caleb (they/them)
