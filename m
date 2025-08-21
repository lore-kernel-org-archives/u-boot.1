Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39E82CA0EF8
	for <u-boot@archiver.kernel.org>; Thu, 21 Aug 2025 11:51:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 973C480B9B;
	Thu, 21 Aug 2025 13:51:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="Q6Qloa9f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBFC681D5D; Thu, 21 Aug 2025 13:51:13 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69E5480548
 for <u-boot@lists.denx.de>; Thu, 21 Aug 2025 13:51:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-afcb61f6044so154240766b.0
 for <u-boot@lists.denx.de>; Thu, 21 Aug 2025 04:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1755777071; x=1756381871;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=YJzOIXr0PUtOCTxIF/v4iX4sAJyDfhE+4w1ErEa5eD4=;
 b=Q6Qloa9fchvo7HucXoW81nPm8CUcOoQGWhO+je763YVNBba02IkOvsq+4SQZCbM5zp
 S+MVq8nHFhwCygMLZM8Z+KdQk6J9wc+AYxhxjMI3KVRloRjC+821f5OFneQ0AEQ3qRHk
 0Omgice2P1HnmL6PUxhvZSen98xyFMxE5dU+rIFT0Kz4xkUz6aK0JrHX+YN5mzDuoZQy
 dSZbAwv5zPCcId9pExq/5+PJuLLB9aPNa33xmgoB24rypaqirEOdrn0OwgG+puYojgc3
 DanKOeGeM5RDmQG0WHoiVvjIdR+nHnK4nT4RIa6R4GOBru82FwrBo6K6eEbK+5FQI3UM
 vEhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755777071; x=1756381871;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YJzOIXr0PUtOCTxIF/v4iX4sAJyDfhE+4w1ErEa5eD4=;
 b=N1jxfQtXYpys2lq268gAd01GfmHaRKbK9WrH5MGd9mY4EffH1n7rB12gCPMppKpkbb
 SlDlRwDxRpitLrhOG/dRRJiHTwq2u+HKFtTHb4gM4SHRXtspk7jiqMeCVL+lNGdnLeVF
 PcglSS+J4QbxmH/WcTHV0HDS6zzpsd//0RZkRyADwUnKnM/kVlsyIh+PNVuq2B9HasAA
 lm2E04ECdgM74vrwh32poEqmDOqlh4qCTkHf5BlsbNq1fYL8+xHTZrUUa7wPyzWV87en
 neP6UIcM8oW/dIT4ndzZRYPnGt+o5gYxVQtqaaJDenN8JeObXaAVh+RvxxnlqOLLgk7r
 VDFQ==
X-Gm-Message-State: AOJu0YxtIdqEfKbgDEi4MCDlECttTUdXSq8MAQircCnmYEMlY3LoykpN
 iTQ4YirZns96ZjDnGm3Tj9e/b1lxAF5ANXzlMU6lMDdpzol8KkFCrrOT5WVBGcQIFg==
X-Gm-Gg: ASbGncsItG2Sm5cB/5kKdNdtczVLcrah0l5OG4gYtxyP8kF6nx4lfxWtWwlO1RJxln/
 659WYZBoCj5B9nNC7CMDKYfPD/1q5TcW1FxQqI8+SgGX5WvjKm6tT59L99J+xwPJTQfb5xLkwDl
 pMBtisAgPm1a+p3baaTohS+y6NKVQuZ2RL9X8KPYC5Kr6ttC2yiOL2u2M1fwyd4Bo9ogEIaEmLX
 IQJQaTQWopkAMzm7IMImcyrxhcjkqscckBNmB03TgV+13wnheFxJAT3uSf1+jFlbUlor4w+HXZi
 q7sz2zGGc4GnLExUrggXNJv6jRE0Nk9t5T49rSbB8IQTZTUHTguhisQkjhNeHWeQowafm7j0Q0s
 buMf2Y018HMs1aGdoEJDf7akzgpkO/wXXOVALEZ+tefQl0YKtRUw=
X-Google-Smtp-Source: AGHT+IFqBBRSsP7uldrStHkluApe170U10nvHNgJGo8YzBtUonf30JuHSmeGR4040s0UY3xQyjSI5A==
X-Received: by 2002:a17:907:1b1d:b0:af9:6c38:c4ff with SMTP id
 a640c23a62f3a-afe0b30730fmr155547566b.19.1755777070675; 
 Thu, 21 Aug 2025 04:51:10 -0700 (PDT)
Received: from [192.168.0.105] (nat-108f.starnet.cz. [109.164.53.108])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-afdf0ba2a42sm338536466b.49.2025.08.21.04.51.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Aug 2025 04:51:10 -0700 (PDT)
Message-ID: <85e68eb1-6bc0-44e2-a1a5-99de60ac499a@monstr.eu>
Date: Thu, 21 Aug 2025 13:51:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: axi_emac: Fix timeout test
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250806-net_xilinx_axi-v2-1-6311cf59451d@linaro.org>
Content-Language: en-US
From: Michal Simek <monstr@monstr.eu>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250806-net_xilinx_axi-v2-1-6311cf59451d@linaro.org>
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



On 8/18/25 11:24, Andrew Goodbody wrote:
> The timeout test in axi_dma_init is not correct due to the
> post-decrement used on the timeout variable which will mean timeout is
> not 0 if the timeout occurs. Make the timeout variable an int instead of
> a u32 and then test for timeout being -1.
> 
> This issue was found by Smatch.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
> Changes in v2:
> - Refactor the code so it returns on success from the while loop
> - Link to v1: https://lore.kernel.org/r/20250806-net_xilinx_axi-v1-1-00be06069c76@linaro.org
> ---
>   drivers/net/xilinx_axi_emac.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/xilinx_axi_emac.c b/drivers/net/xilinx_axi_emac.c
> index c8038ddef1b..22e119370c8 100644
> --- a/drivers/net/xilinx_axi_emac.c
> +++ b/drivers/net/xilinx_axi_emac.c
> @@ -558,7 +558,7 @@ static int axiemac_write_hwaddr(struct udevice *dev)
>   /* Reset DMA engine */
>   static void axi_dma_init(struct axidma_priv *priv)
>   {
> -	u32 timeout = 500;
> +	int timeout = 500;
>   
>   	/* Reset the engine so the hardware starts from a known state */
>   	writel(XAXIDMA_CR_RESET_MASK, &priv->dmatx->control);
> @@ -571,11 +571,11 @@ static void axi_dma_init(struct axidma_priv *priv)
>   		if (!((readl(&priv->dmatx->control) |
>   				readl(&priv->dmarx->control))
>   						& XAXIDMA_CR_RESET_MASK)) {
> -			break;
> +			return;
>   		}
>   	}
> -	if (!timeout)
> -		printf("%s: Timeout\n", __func__);
> +
> +	printf("%s: Timeout\n", __func__);
>   }
>   
>   static int axiemac_start(struct udevice *dev)
> 
> ---
> base-commit: 007610da2cca405ea7739fc120d90085be4b6ac2
> change-id: 20250806-net_xilinx_axi-9ca9a791d611
> 
> Best regards,

Applied.
M
-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs

