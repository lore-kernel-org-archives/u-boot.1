Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C583CA0EE4
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 09:20:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6948080107;
	Mon, 18 Aug 2025 11:20:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="B3tJOFKu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B805C80194; Mon, 18 Aug 2025 11:20:28 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E969F800D7
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 11:20:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3bb2fb3a436so2082426f8f.1
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 02:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755508825; x=1756113625; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KsrmQPHk2QhcXx6gM92ZGHaXiANs0dzYtPgBmEdSFMc=;
 b=B3tJOFKuxNosNcR/Sq6kowlEF4rCAu6TV1ufIjeKLiIrsE6C2dGJhDvH8eDUi4h0oB
 PNzdXYbWIH7TwqVlbld1n2+on/bJDxAP+MjGkpD8bsOt/ohsxWvjuxEu4ANIMKCN3XUn
 sKkhLvqPd6UzDnEyOq2CFMeixDQMnYVrSY6eYpkWSeYJClE6Ae8zWbhr7vXVcWL8OvDv
 W+RwNBRG/j/lJsoTNnlCCHfoC4+N+Dnz6ddB2FklpSyD4aBO0z4YQa7YLPLq67r/Fewe
 VNBoAI/yBk3qXTutBMXC7wT9sXjk5Gt5U+qtjd4DH3CI7m0zCKyIKeSJxUy2XjKKuP9e
 3O2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755508825; x=1756113625;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KsrmQPHk2QhcXx6gM92ZGHaXiANs0dzYtPgBmEdSFMc=;
 b=IMHo4k4njTY31eeoejj/njXO/hygRQbbSxPO0qBBk0hiNs7NVO6KfJTPFa+3gWAmSw
 UKZ45zuXF8tBvxepK3gSN6+snaTLdBoNhn1WY5vmltQA0JA08oaAVn4Y+4kyfY0mUBMN
 ztmztn99q6dZX1Yahpx0cvCgufmqquAzWJsDCDXcbeTqzhBm0x2+gilIOhAbiCb0l7zz
 4FkoqVE20sG21uNW3egWw00jXIufVEBoXIeAmZizcyErSRSUi3BNaW1DnquQqhQU2ZTA
 UxL1BHZ2luJLGKuYx3irl0v6WG4DCTJ1LWoWIOOEvCsSDNU8VyeGaxzOrTZwHK4Sx1Zv
 ZyHg==
X-Gm-Message-State: AOJu0Yx1YtcuZh7A36MAXx4YyQw7LIT8qzagfEAB1BDtJj89fF3H6/jt
 dVrDhyNkT3ylj9b/u0er6hAZ55BX9gbxtjjauRJbwxGzK0dwaXCZzbZKcxSoKYHjH9jlSAYXRnh
 8zXXh
X-Gm-Gg: ASbGncufsYf7C9w55q9QxPqtTZMXnBh39Nvd6ZZzjYJZygHmJmCzcbG5EKjPFjVeKAf
 wsFuTZBch1N1zGk8V6TRTz0pnMwdzh9rJR//IQU8BWHFLARFKlx/HUKaDooA0e8e2vC6UsP7Z15
 4FdcFPB4hRwpoFntKtQ1B0YTHJkS0SCtEDCIXonWaed6eW7OM4jL/ZYReuwA+Z+sxgFgXHhQ6PJ
 8X0Btl1dl+1YsK25GfP8jDbcVqrCq8JlTMUC4SyZ57Q+TaUSc52WC4JeD7+ef5xC18sKr6RDj1g
 RoBNXt2vpeyRdh1yrXnhNTMwLFe8lVKH6/NBTy2Wuwv66v0+zEOdztMhp5/zLTQ0I9V84zNGGZE
 K4kPyYTLVWhgqAO/z5VsH+E1PPAaXvY+gx2xKA+EajmjGXhSrDVEgrl0pNls7E/Aj0iwnR+ia7p
 uJgA==
X-Google-Smtp-Source: AGHT+IEgrHblgU+PLTk7blj0e37kSF+MC2XSOfpJTPVSeKXL2HcpOWUWeqO6wWSdhFj2Zc8gGlzjcw==
X-Received: by 2002:a05:6000:2912:b0:3a4:f8fa:8a3a with SMTP id
 ffacd0b85a97d-3bc684d7b8emr5274905f8f.18.1755508825192; 
 Mon, 18 Aug 2025 02:20:25 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:f9e:3c01:69b5:38a0:910b:c9c8?
 ([2a0a:ef40:f9e:3c01:69b5:38a0:910b:c9c8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3bc4afe7a63sm10064645f8f.15.2025.08.18.02.20.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Aug 2025 02:20:24 -0700 (PDT)
Message-ID: <ae0d6718-d5d1-4716-9e26-7a764447898f@linaro.org>
Date: Mon, 18 Aug 2025 10:20:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: axi_emac: Fix timeout test
To: Michal Simek <michal.simek@amd.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250806-net_xilinx_axi-v1-1-00be06069c76@linaro.org>
 <3ed4d268-8911-4b4d-b2be-764de71c54c3@amd.com>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <3ed4d268-8911-4b4d-b2be-764de71c54c3@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 18/08/2025 09:41, Michal Simek wrote:
> 
> 
> On 8/6/25 13:10, Andrew Goodbody wrote:
>> The timeout test in axi_dma_init is not correct due to the
>> post-decrement used on the timeout variable which will mean timeout is
>> not 0 if the timeout occurs. Make the timeout variable an int instead of
>> a u32 and then test for timeout being -1.
>>
>> This issue was found by Smatch.
>>
>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>> ---
>>   drivers/net/xilinx_axi_emac.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/xilinx_axi_emac.c b/drivers/net/ 
>> xilinx_axi_emac.c
>> index c8038ddef1b..c46678c1f3b 100644
>> --- a/drivers/net/xilinx_axi_emac.c
>> +++ b/drivers/net/xilinx_axi_emac.c
>> @@ -558,7 +558,7 @@ static int axiemac_write_hwaddr(struct udevice *dev)
>>   /* Reset DMA engine */
>>   static void axi_dma_init(struct axidma_priv *priv)
>>   {
>> -    u32 timeout = 500;
>> +    int timeout = 500;
>>       /* Reset the engine so the hardware starts from a known state */
>>       writel(XAXIDMA_CR_RESET_MASK, &priv->dmatx->control);
>> @@ -574,7 +574,7 @@ static void axi_dma_init(struct axidma_priv *priv)
>>               break;
>>           }
>>       }
>> -    if (!timeout)
>> +    if (timeout == -1)
>>           printf("%s: Timeout\n", __func__);
>>   }
>>
>> ---
>> base-commit: 007610da2cca405ea7739fc120d90085be4b6ac2
>> change-id: 20250806-net_xilinx_axi-9ca9a791d611
>>
>> Best regards,
> 
> 
> What about to do it like this?
> diff --git a/drivers/net/xilinx_axi_emac.c b/drivers/net/xilinx_axi_emac.c
> index c8038ddef1b8..22e119370c84 100644
> --- a/drivers/net/xilinx_axi_emac.c
> +++ b/drivers/net/xilinx_axi_emac.c
> @@ -558,7 +558,7 @@ static int axiemac_write_hwaddr(struct udevice *dev)
>   /* Reset DMA engine */
>   static void axi_dma_init(struct axidma_priv *priv)
>   {
> -       u32 timeout = 500;
> +       int timeout = 500;
> 
>          /* Reset the engine so the hardware starts from a known state */
>          writel(XAXIDMA_CR_RESET_MASK, &priv->dmatx->control);
> @@ -571,11 +571,11 @@ static void axi_dma_init(struct axidma_priv *priv)
>                  if (!((readl(&priv->dmatx->control) |
>                                  readl(&priv->dmarx->control))
>                                                  & 
> XAXIDMA_CR_RESET_MASK)) {
> -                       break;
> +                       return;
>                  }
>          }
> -       if (!timeout)
> -               printf("%s: Timeout\n", __func__);
> +
> +       printf("%s: Timeout\n", __func__);
>   }
> 
>   static int axiemac_start(struct udevice *dev)
> 
> M

Sure. V2 coming.

Andrew
