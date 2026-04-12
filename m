Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B6E7E93800
	for <u-boot@archiver.kernel.org>; Sun, 12 Apr 2026 20:27:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 989EF84181;
	Sun, 12 Apr 2026 22:27:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nUH9bqyd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DA95840D8; Sun, 12 Apr 2026 22:12:27 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27E9F83B99
 for <u-boot@lists.denx.de>; Sun, 12 Apr 2026 22:12:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rgallaispou@gmail.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-43d01d6b50cso3760940f8f.1
 for <u-boot@lists.denx.de>; Sun, 12 Apr 2026 13:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776024744; x=1776629544; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D1XB+h1qqYqpT50eRwbAokQi0YxnIdNg27stw8IAQds=;
 b=nUH9bqyduJFyWhP1gqr+ONrMsjnmflBo9gNGuLIAZGNzr91PzI/MrdGTuPTKax91b5
 /CYDqZJY1gfxMt7jO+f8c+2j8AV4tOTCBV9qbbsb1oVUQa7SzKhdPFkQaTbDNCCPPH+/
 GvRnm7HGPszYT6hmQMIqFnhw38VpWN25KxhIJTFQMaP4aQxg97vbUM4FA34uN57Nc0eX
 Rake1/evgxpykn+aWI/O8XdKIio8HznSpQYojzNSA23o6ErezTp5PLwOWPp0j/FneLjc
 CHH2asKjl/clzgsg6c+MfhrPCHs9KKlRGIbIvPJJI+9cUYwxsa2mGRvifnYYq3kly+Be
 DD0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776024744; x=1776629544;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D1XB+h1qqYqpT50eRwbAokQi0YxnIdNg27stw8IAQds=;
 b=SvXHz0q0jIxWKJghdvUIPv/6TzhcqDYbloG4CIOmcZIO7dR79HNZ6xLo/QVfpbNUNo
 MABF2wlEmQJqAkkq/lCxyS/px86dcliMy1NLikPbkS/1vMmbByP5+CpfA2v0lgLp4gDv
 J125HMr1OryeRNYSGR8WkYRqNUoFYr651YpFUqc2bDO5R8GhPv8G9DJyRiVcjH+iM2GV
 Bz0qkwvIv/SDT0ZLV/+/9euwjWlIgBQM+S1ZXiIUU/7hUlLAYo0JNvBxVZQeqhdDohVn
 CDIGPz68siAzaXXqmhV4xoPRPhlxr9HlmvHSDJTq/CeSkfz98DAg6eDh572gE40E4kxD
 1nug==
X-Forwarded-Encrypted: i=1;
 AFNElJ/MbhvOR4Fw4OSg7sMU7U8zTTjXFDtJ0ZBUKSe9kwxgDGt589cf295PtlsOWHy4fFoEva3k0j8=@lists.denx.de
X-Gm-Message-State: AOJu0Yxrq9E5P401g0TbmPatCHCLULWA+0pUEsfCNJefLPKn/CDZ7BKh
 DxrhDZkTn4vcWzVnn78Ig1Ras7HIxAe2OfQ3ktFdRxxhb/dE9Jr3tMQB
X-Gm-Gg: AeBDievPmuVhhUCxyXFyndpxMEDXMVE4yX0YyA3pJ9k1e1l7J7ATMu57qyBIxycG4Ml
 Zu7hMdnuWEQrHA7KX4MZaYhvXSFBqXgjjO2/Jxpje/sKmvKUQNdXX8MhTJtbFnU8fxTnEEquj8k
 0/YYN+S1P+zAku49t//nH7y+Tj/dGMsloi7rLn/qmyZE5pl60540hiLnNtwCVo1nJj2KhcThJi1
 TPN98Nxfy8YgauzepM/3xrMdvgvoqwGBN7Y2W4LXgckWKIEVa15iYZ9MGENizh38zA3FzcnZixa
 l80A4C3JVKwIvLqVRHtarv5X6Ifl1q0EzF81WdGOoD00qFZnr41GI0pysKhCQoTP7Ms95O+dodV
 Z/yVH0PfO4Si7vyYaYawnMpqVOmL4evTjRIz4GDDqPE6iO31iqr2+uSy7jO/q7iDE8Eqr9OfcGo
 X81IJD6FEC9vaVt9UMRRv5p8Yg4PmCxHMuUMN1VwDbFxNAQdurzN0zwE18gLMswdyg4vgPe/A=
X-Received: by 2002:a05:6000:4285:b0:43c:4810:dc4a with SMTP id
 ffacd0b85a97d-43d642d3630mr15654266f8f.38.1776024744370; 
 Sun, 12 Apr 2026 13:12:24 -0700 (PDT)
Received: from ?IPV6:2001:861:3385:e20:f99c:d6cf:27e6:2b03?
 ([2001:861:3385:e20:f99c:d6cf:27e6:2b03])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d63e50200sm26915884f8f.29.2026.04.12.13.12.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Apr 2026 13:12:23 -0700 (PDT)
Message-ID: <c4b646c5-7038-4fd8-b794-f304502452c0@gmail.com>
Date: Sun, 12 Apr 2026 22:11:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Uboot-stm32] [PATCH] clk: stm32: Add STM32MP23 support
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 uboot-stm32@st-md-mailman.stormreply.com, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Valentin Caron
 <valentin.caron@foss.st.com>, Lukasz Majewski <lukma@denx.de>,
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Nicolas Le Bayon <nicolas.le.bayon@st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
References: <20260401-add_stm32mp23_clock_support-v1-1-ff5fa33d8b67@foss.st.com>
Content-Language: en-US
From: =?UTF-8?Q?Rapha=C3=ABl_Gallais-Pou?= <rgallaispou@gmail.com>
In-Reply-To: <20260401-add_stm32mp23_clock_support-v1-1-ff5fa33d8b67@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 12 Apr 2026 22:27:06 +0200
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



On 4/1/26 11:34, Patrice Chotard wrote:
> Add STM32MP23 support.
> 
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>

Hi Patrice,
> ---
>   drivers/clk/stm32/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Raphaël Gallais-Pou <rgallaispou@gmail.com>

Best regards,

> 
> diff --git a/drivers/clk/stm32/Kconfig b/drivers/clk/stm32/Kconfig
> index 4e488136eac..e63385d3051 100644
> --- a/drivers/clk/stm32/Kconfig
> +++ b/drivers/clk/stm32/Kconfig
> @@ -49,7 +49,7 @@ config CLK_STM32MP21
>   config CLK_STM32MP25
>   	bool "Enable RCC clock driver for STM32MP25"
>   	depends on ARCH_STM32MP && CLK
> -	default y if STM32MP25X
> +	default y if STM32MP23X || STM32MP25X
>   	select CLK_STM32_CORE
>   	help
>   	  Enable the STM32 clock (RCC) driver. Enable support for
> 
> ---
> base-commit: ba7bf918dafcd093ad733b07ba490baeb20cf5da
> change-id: 20260401-add_stm32mp23_clock_support-bb1480914811
> 
> Best regards,

