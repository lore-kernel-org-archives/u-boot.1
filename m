Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D14AC369C2
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 10:53:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF8C781F0D;
	Fri, 25 Apr 2025 12:53:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LWsoqxnq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91CB281F45; Fri, 25 Apr 2025 12:53:40 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63CC4807B1
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 12:53:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-acb2faa9f55so264043866b.3
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 03:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745578418; x=1746183218; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tOiwyqhtbJ3AiWFvL1zZNZogcxkgdSDjvKqVVB85hBQ=;
 b=LWsoqxnqgIPXYI2rXXH7hRma0gCZdRqg51t0vcC7H/Wm/DL0qRiUhc3ThvNbZwae9R
 WbSLujMGk3Y6F9dRbsZee/EHLosASopXulfwV0LTll1fuwa2Qg/dEmlckX6zJKYBfixu
 BVI57Jp/YxvQxOspwxsRubp1HwMYYC9LiyNvzfBgyHmbGSFDbZKpfog9XAUrAgfTxKnc
 NMC1UjiiuVjIDBFqPBgqAnTlsnchGMZVvKgvV6txABKb2Vx+yN0pffFLVhomGGP1mPcs
 eSWZNpv78sBuz37L1lc6zWqHcxKatXTH22JjfCNP+qYhbcDQu1C5o/GcGvuBlEwxRMRy
 kDlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745578418; x=1746183218;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tOiwyqhtbJ3AiWFvL1zZNZogcxkgdSDjvKqVVB85hBQ=;
 b=UU7KbISTj63r2joo8gOD6ow6kZqJL5hCIq7q/UjX52rIfI7cvv76E1BEz+h/vVGocM
 /LvDtJqZ1hNhzfmbKOEBrZ8CAxGi1BXpZJizyzug5XKhdMeAY9pzV8InglpYbh2IaKwq
 vlu5uNehp55bwOhHBQoZ3wx+7Nr4NclsMjKD3OtT9CYRIm9zVgM0MVN4TVa0MfYZaACG
 E+/FB4Gh5nV38WnSvpi8jb9Bs0jLBsiam0wxORuXrJmzezZrnFlQAmeZaQ5oPJ4tGy5o
 SeAxx193ejDhlnIZjpYcBB7nmSv+Ba9xE6nfhVp1C0SLffZPmqR3+sJhAzJv0ObwatPv
 WdZw==
X-Gm-Message-State: AOJu0Yy3IhGCTVOzv3ExRUSk6EpLMgvCJO5v/AU2lCF9V2rlryvtn9cW
 zejf1Cqry/7IsqQIFL0xeS3Hxnu/AaejlowFDc0ViL4plk/PQJ5JY6MeFOtnlsljwuec1aNKk/e
 H
X-Gm-Gg: ASbGnctfb52W6TgxFhactMDDJUChuIhDZ388M8ASZtUjCTKYJ0Pxvfd9ICDDfSs5pSA
 QyOwttxApeZpmGcjuMe7wXR/Ri5Ac3cGPEtessmoVcyU3RduT4Pfi+s83H0Ad+JPPyCBcE2MUu5
 qWCB7ULb0YklEbc8zYoFGdTtjjxacWV+oaYpJ8hl/OCzDIMngXRKn8OlWL9yUCJ1t9gEoLiAeWx
 DtreXJ6/Sxu6VQVDjS9H+iGOx80z1J+A5z6CaUoIf9vKKA//dnI0qGLDXnBN5rNZOoHLL0Ky+7M
 amzFjFNKe2c+ZiMztQyFch19Sc0fa8kh03VCk6HrF2jjRTg7
X-Google-Smtp-Source: AGHT+IGCLUyw5eAaY/XAgHvFTP/EywGmvWilTQP9/EEL7E0NLtw08CFL/570EBdRmGUruBmUeXXGng==
X-Received: by 2002:a17:907:2d1e:b0:acb:5ae1:f6b8 with SMTP id
 a640c23a62f3a-ace71047f55mr170431566b.7.1745578417701; 
 Fri, 25 Apr 2025 03:53:37 -0700 (PDT)
Received: from [192.168.0.32] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ace6edb0becsm114712966b.167.2025.04.25.03.53.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 03:53:37 -0700 (PDT)
Message-ID: <ada5be57-5af8-4236-87e2-abdfd8440ce3@linaro.org>
Date: Fri, 25 Apr 2025 13:53:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] watchdog: at91sam9_wdt: Add SAM9X60 support
To: Zixun LI <admin@hifiphile.com>, Tom Rini <trini@konsulko.com>,
 Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de
References: <20250417-wdt-v2-0-49939de473e1@hifiphile.com>
 <20250417-wdt-v2-6-49939de473e1@hifiphile.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <20250417-wdt-v2-6-49939de473e1@hifiphile.com>
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



On 4/17/25 12:09, Zixun LI wrote:
> SAM9X60 has a slightly different watchdog implementation:
> - Timer value moved into a new register WLR
> - Some MR register fields have their position changed

I would add the support for sam9x60 as a single patch, this one and
previous (patch 5) which adds the registers definition.
I don't see a reason for a patch to add unused register definitions and
then create another patch that uses them.

> 
> This patch add SAM9X60 support, also adds a compatible
> for SAMA5D4 who is the same as existing SAM9260.
> 
> Signed-off-by: Zixun LI <admin@hifiphile.com>
> ---
>  arch/arm/mach-at91/include/mach/at91_wdt.h |  7 ++++++
>  drivers/watchdog/at91sam9_wdt.c            | 39 ++++++++++++++++++++++++------
>  2 files changed, 38 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/include/mach/at91_wdt.h b/arch/arm/mach-at91/include/mach/at91_wdt.h
> index 9ba5283123bcf637bb1c3c66f7b98104e232ae05..9a3976d9e970c212d348daeabc14c2fd6c54a8b5 100644
> --- a/arch/arm/mach-at91/include/mach/at91_wdt.h
> +++ b/arch/arm/mach-at91/include/mach/at91_wdt.h
> @@ -19,9 +19,16 @@
>  
>  #else
>  
> +enum {
> +	AT91_WDT_MODE_SAM9260 = 0,
> +	AT91_WDT_MODE_SAM9X60 = 1
> +};
> +
>  struct at91_wdt_priv {
>  	void __iomem *regs;
>  	u32 mr;
> +	u32 wddis;
> +	u8 mode;
>  };
>  
>  #endif
> diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
> index 5ca3e5a5fdefb3101c97754f10b65c0acd69a522..72e13787448e366036dce4a451cc2294e5b60a0d 100644
> --- a/drivers/watchdog/at91sam9_wdt.c
> +++ b/drivers/watchdog/at91sam9_wdt.c
> @@ -49,7 +49,7 @@ static int at91_wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
>  	ticks = WDT_SEC2TICKS(timeout);
>  
>  	/* Check if disabled */
> -	if (readl(wdt->regs + AT91_WDT_MR) & AT91_WDT_MR_WDDIS) {
> +	if (readl(wdt->regs + AT91_WDT_MR) & wdt->wddis) {
>  		printf("sorry, watchdog is disabled\n");
>  		return -1;
>  	}
> @@ -60,11 +60,21 @@ static int at91_wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
>  	 * Since WDV is a 12-bit counter, the maximum period is
>  	 * 4096 / 256 = 16 seconds.
>  	 */
> -	wdt->mr = AT91_WDT_MR_WDRSTEN	/* causes watchdog reset */
> -		| AT91_WDT_MR_WDDBGHLT		/* disabled in debug mode */
> -		| AT91_WDT_MR_WDD(0xfff)	/* restart at any time */
> -		| AT91_WDT_MR_WDV(ticks);	/* timer value */
> -	writel(wdt->mr, wdt->regs + AT91_WDT_MR);
> +
> +	if (wdt->mode == AT91_WDT_MODE_SAM9260) {
> +		wdt->mr = AT91_WDT_MR_WDRSTEN	/* causes watchdog reset */
> +		    | AT91_WDT_MR_WDDBGHLT	/* disabled in debug mode */
> +		    | AT91_WDT_MR_WDD(0xfff)	/* restart at any time */
> +		    | AT91_WDT_MR_WDV(ticks);	/* timer value */
> +		writel(wdt->mr, wdt->regs + AT91_WDT_MR);
> +	} else if (wdt->mode == AT91_WDT_MODE_SAM9X60) {
> +		writel(AT91_SAM9X60_WLR_COUNTER(ticks),	/* timer value */
> +		       wdt->regs + AT91_SAM9X60_WLR);
> +
> +		wdt->mr = AT91_SAM9X60_MR_PERIODRST /* causes watchdog reset */
> +			| AT91_SAM9X60_MR_WDDBGHLT; /* disabled in debug mode */
> +		writel(wdt->mr, wdt->regs + AT91_WDT_MR);
> +	}
>  
>  	return 0;
>  }
> @@ -74,7 +84,7 @@ static int at91_wdt_stop(struct udevice *dev)
>  	struct at91_wdt_priv *wdt = dev_get_priv(dev);
>  
>  	/* Disable Watchdog Timer */
> -	wdt->mr |= AT91_WDT_MR_WDDIS;
> +	wdt->mr |= wdt->wddis;
>  	writel(wdt->mr, wdt->regs + AT91_WDT_MR);
>  
>  	return 0;
> @@ -96,7 +106,14 @@ static const struct wdt_ops at91_wdt_ops = {
>  };
>  
>  static const struct udevice_id at91_wdt_ids[] = {
> -	{ .compatible = "atmel,at91sam9260-wdt" },
> +	{ .compatible = "atmel,at91sam9260-wdt",
> +	  .data = AT91_WDT_MODE_SAM9260 },
> +	{ .compatible = "atmel,sama5d4-wdt",
> +	  .data = AT91_WDT_MODE_SAM9260 },
> +	{ .compatible = "microchip,sam9x60-wdt",
> +	  .data = AT91_WDT_MODE_SAM9X60 },
> +	{ .compatible = "microchip,sama7g5-wdt",
> +	  .data = AT91_WDT_MODE_SAM9X60 },
>  	{}
>  };
>  
> @@ -108,6 +125,12 @@ static int at91_wdt_probe(struct udevice *dev)
>  	if (!wdt->regs)
>  		return -EINVAL;
>  
> +	wdt->mode = dev_get_driver_data(dev);
> +	if (wdt->mode == AT91_WDT_MODE_SAM9260)
> +		wdt->wddis = AT91_WDT_MR_WDDIS;
> +	else if (wdt->mode == AT91_WDT_MODE_SAM9X60)
> +		wdt->wddis = AT91_SAM9X60_MR_WDDIS;
> +
>  	debug("%s: Probing wdt%u\n", __func__, dev_seq(dev));
>  
>  	return 0;
> 

