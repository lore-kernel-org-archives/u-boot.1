Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0BE7CCA470
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 07:51:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 493ED83957;
	Wed,  8 Oct 2025 09:51:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hs9/isE5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8114383981; Wed,  8 Oct 2025 09:51:40 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 518A683956
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 09:51:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-46e37d10f3eso47719845e9.0
 for <u-boot@lists.denx.de>; Wed, 08 Oct 2025 00:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759909898; x=1760514698; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XgW7r8u/0JOkvPoYRBpgFdEl8s7esT46GqFR5O7Ddm0=;
 b=hs9/isE5UFva6VoVH/PpAm92OeRtFDNnJf3CTi18GHaQSzDS+uIViX2w1zvxWFqyQ4
 uxoF2if9hGfq5qi7HEfjBtB89mLlesFIAjtHsuE6tZgCT6ycPW0rJ8woq59uSEbUcKvM
 5wJkaaQbDQEFAo5z02BlpIghy+rkhVmMH2GM6HoqN/C/ST7n/iUUKrX+KknHR7C04wZ4
 8OXw7NhurGZjeDQRzwLjQxy6cc/0FDaIh/aUtLZ+on0XKVAILkvEsCWOtCbFwpP3y01w
 ZygfZXAz1zH68Tpguaqxpa6cT2TSX0eZ8FS3sRVYnYGXGAdDCDTMPPGLppYZugIAAg7n
 cXWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759909898; x=1760514698;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XgW7r8u/0JOkvPoYRBpgFdEl8s7esT46GqFR5O7Ddm0=;
 b=UDdFxT4+jodSSW6m0Za9nq1ZtsdfXw1N6xFa9FVxs3MwcMVH5s7UIgVUCMSKaoZLLK
 uu7MdzxK3aOj32KdxJ97c33coMsBt7+gLS/LrdciL3Woup5p49K0Whf0YQzP2nJxHPnS
 zytiVp5vjffmEP3JlV/NdAOA1ceimnvLQ9jlQumrFScge+FClCFsjPmszyzd1y5Bh4Xu
 0JaQy9KZYDbBWUhjz+T/Q8EkejEw3M0YVKMX2Mi7yPM+Z2l+LLCJBcXnXI0ITd/xDi6E
 g70wtJNMOT/cRCTn+0RVBJyVp3oWtxOPM4CVJkOQh/7qXNtGCEaCSG/PJb1ZBsTKsgVN
 KC3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUS+uXxUDHNAsQjNvZZdIiRXrlzZheSkB4POMs0btuKS2f1WGDQZ+t4BhwVZ8CmxsZVhBcTN/4=@lists.denx.de
X-Gm-Message-State: AOJu0YzfT+S2vL26KThaTwHZh5J8xeGeh3OICsuUIxQQE+vBNq9pAyK3
 H0AOFkwSKHKPGXVApmAsp5vVX216msd5003hfqe87ihsiuDxg/e6/1UvOTF6doWgXuUtK2+i47b
 ktiMD
X-Gm-Gg: ASbGncsRQLJnIQe17HiMACnST2A624GWotrWutUbYvgAlWgEFJVLURt7NWn16xiKgmi
 3jjw2Bl4Ik5jkyvhtRFbbnGWlorrvNa/KlhDStVW9xr6NpVNkAf4QVelqh+m5J2OKo/AIr47p4c
 vovQDgablbCUug0YYWUM5a2XMsei2zopVYvPWeNYqlgg648Ym3rzIMt2xFmKPKmuemOb2G6YE9q
 PLzd0SZZ0s0aysxYFQTjWqSanycqnT4Zyvl9w331kgqyZ/Vj7AqRb7FJ+fZyp0oKqT5ZPlnJ+1k
 QNnapdee3F0vGpY2BGHdlLxhf1rvNsNiVXmNCloSUAtW35D6fFHNrM+VgjdS/dPD9TEdiljn2z1
 Io9Zjn/NR7k25vmWtAdLcgVwTYu/FnJEiVpl1Uo1dYD9ZfjbCG0oIoxih24pKjKLYD3QlxV6u93
 rwJQyqtQ/9
X-Google-Smtp-Source: AGHT+IEbCnFc4onSuFkFHz3/C9Z3wZT7vkoA1FL/J9zL90axKPIMKmfRsoCNxMFBE6AxMPIU7ukBEA==
X-Received: by 2002:a05:600c:1e85:b0:46e:39e4:1721 with SMTP id
 5b1f17b1804b1-46fa9aa261amr14928505e9.12.1759909897685; 
 Wed, 08 Oct 2025 00:51:37 -0700 (PDT)
Received: from [192.168.7.93] ([212.114.21.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fa9d629casm25622445e9.16.2025.10.08.00.51.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Oct 2025 00:51:37 -0700 (PDT)
Message-ID: <fd81c827-bef1-458d-bebe-0ac0d90216d3@linaro.org>
Date: Wed, 8 Oct 2025 09:51:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: dwc_eth_ops: Correct check for FDT_64BIT
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20251001203043.2828376-1-trini@konsulko.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20251001203043.2828376-1-trini@konsulko.com>
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

Hi Tom,

On 10/1/25 22:30, Tom Rini wrote:
> There is no xPL_FDT_64BIT symbol and it would furthermore not likely
> make sense for there to be one. Correct this check to use
> CONFIG_IS_ENABLED and not IS_ENABLED.

The other way around ;-)

> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  drivers/net/dwc_eth_qos.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
> index 551ee0ea6a02..a098916a674b 100644
> --- a/drivers/net/dwc_eth_qos.c
> +++ b/drivers/net/dwc_eth_qos.c
> @@ -1411,7 +1411,7 @@ static fdt_addr_t eqos_get_base_addr_common(struct udevice *dev, fdt_addr_t addr
>  	struct eqos_priv *eqos = dev_get_priv(dev);
>  
>  	if (addr == FDT_ADDR_T_NONE) {
> -#if CONFIG_IS_ENABLED(FDT_64BIT)
> +#if IS_ENABLED(CONFIG_FDT_64BIT)
>  		dev_err(dev, "addr=0x%llx is invalid.\n", addr);
>  #else
>  		dev_err(dev, "addr=0x%x is invalid.\n", addr);

Thanks,
-- 
Jerome
