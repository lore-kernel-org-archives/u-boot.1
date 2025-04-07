Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05200C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 14:28:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8397382BCD;
	Mon,  7 Apr 2025 16:28:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="d+7mbPjn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0741882C55; Mon,  7 Apr 2025 16:28:00 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01D9A82B63
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 16:27:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43cef035a3bso29803035e9.1
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 07:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744036077; x=1744640877; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=70LDqLwknicRnkifX5hoF6K2fZA0AugyHDOagcUxy8U=;
 b=d+7mbPjn7myr2NhIo8/4Ye6C+IOG//QP+Yz1OZIBkNMSVcDEeafCzLja/XuMfoAanw
 vJnCJjjjeNjAv9aXXrxBYpSQY1EhBCvVO8HO+LoxVidHYOZau1D0i6eYtgElCgoEhpE1
 D7rpiH4jv9+GR0GE7TLdYajtVNkphNCEFXn5gF0UGHCw23C1yJrYp3eWyCpQ72nMTyD5
 SecuSQTfBnBgL0OOYiYVm4A9G/xM92VY+B+0KtkAKueonKbOQEBFStj938yZ84cRDZu7
 fEBDo/dnDCPvfQr6266U+css6T84xuY9lm2/LX+P/5VI9fJCVhBZU4KDhXhtyvYeaQPb
 EofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744036077; x=1744640877;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=70LDqLwknicRnkifX5hoF6K2fZA0AugyHDOagcUxy8U=;
 b=CulTm4DaSf/Wu50acBBQvU1st9LeB6n7bU2Yo5d+2TNnPeLzPznpIpi9ab6p8pD21P
 u9tQRAyOeuDsIAUpYRmgExlBcbZ9aAwmfwMuHV2N9fVIlmh4pQ1O9y0WPIh9hmoN8S1+
 s4UOHbGtr1e0LVzm9ebHSsm/cKwbGyzNFmlMaQHaxarrmFhJkENPqffQqYOmDNCWD7fX
 f8PhrfkTpnHqnqynkEV+FiVyCVXy+w0b1Z8s49SSIXC4KWJdw1MgoA4rdivHqquWOM3b
 UVXAY/S80WY+v1usPsrJATmxzo0FXANEBqL70WOZstGAs2VkpAhmHlnxJ9jwTrPAyZod
 fIfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWo+g8SL33k7f1vWyjBX0ll2rK2gCAhUvAVK7HkSJHLm9wzIUimIIncO2uTwdNwF1GRqiWKLUk=@lists.denx.de
X-Gm-Message-State: AOJu0YxvC8zW7Qepju9cF0U+HIJP24P6NTCiF5wodutyxVcg49GDgXHF
 SLuvJ4J8SdewqDDwJLo+qB6Fa9Lt45BhsoPNZyq/hli61In5tb4M7tbAOXxINyY=
X-Gm-Gg: ASbGncsPc6kYhPxizTwXkzwrFxc/CrfFzrLM7dW9gyDgqVX3ZAfW26qR0n//tvK++Np
 jLiTkBgfLINNNodgzUQ7wGmta98QY+6yzkDo+OFvWsdGZrdGARzXiAF33hKMAcvUq7WYLal7py6
 gvlBW29kaGYSRDLj6qqmA2Lrj3irIrmcwikBorddzNB2SH/solejDJ/jeBBaxgXJ+u491xGD0ja
 8Ry+PC6z4kZczeqpXKziAoB/xMQgzZ61VVr5v3+nIpdb0WcfXayFVgpFvQo1dfE1a258PhiT86u
 4i5JVHoFLQgVHF5BivH91yAoEWEFDNzfwDlGdWzU2Rws0QArqpz4a98JuWZzOo2q7AsBXgcAWdU
 /3tlOMPksLEQ=
X-Google-Smtp-Source: AGHT+IEG0PTRY3hKjq0Fvlng4NRasv5i9u2ruT1hlufkGnq/YDaev77KV+osr5PVr6Zqo8/MU+WXfw==
X-Received: by 2002:a05:600c:474e:b0:43d:fa5d:9315 with SMTP id
 5b1f17b1804b1-43ecfa07060mr93056165e9.33.1744036077454; 
 Mon, 07 Apr 2025 07:27:57 -0700 (PDT)
Received: from [192.168.1.47] (212-60-142-46.pool.kielnet.net. [46.142.60.212])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c30096b9csm12310734f8f.13.2025.04.07.07.27.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Apr 2025 07:27:56 -0700 (PDT)
Message-ID: <353d3a52-d101-4938-9f8d-2b8db3ca9b87@linaro.org>
Date: Mon, 7 Apr 2025 16:27:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] clk/qcom: apq8096: fix the sdhci clock
To: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>, neil.armstrong@linaro.org
Cc: sumit.garg@kernel.org, u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250407120536.236003-1-jorge.ramirez@oss.qualcomm.com>
 <20250407120536.236003-3-jorge.ramirez@oss.qualcomm.com>
 <ca4b11e9-4bd0-4a9b-9980-ff2367f8c43f@linaro.org> <Z/PeZVBhwcNOVRAD@trex>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <Z/PeZVBhwcNOVRAD@trex>
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



On 4/7/25 16:17, Jorge Ramirez wrote:
> On 07/04/25 14:36:51, neil.armstrong@linaro.org wrote:
>> On 07/04/2025 14:05, Jorge Ramirez-Ortiz wrote:
>>> Select the right clock for sdhci.
>>>
>>> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
>>> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
>>> ---
>>>    drivers/clk/qcom/clock-apq8096.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/clk/qcom/clock-apq8096.c b/drivers/clk/qcom/clock-apq8096.c
>>> index bc00826a5e8..551f52d5197 100644
>>> --- a/drivers/clk/qcom/clock-apq8096.c
>>> +++ b/drivers/clk/qcom/clock-apq8096.c
>>> @@ -83,7 +83,7 @@ static ulong apq8096_clk_set_rate(struct clk *clk, ulong rate)
>>>    	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
>>>    	switch (clk->id) {
>>> -	case GCC_SDCC1_APPS_CLK: /* SDC1 */
>>> +	case GCC_SDCC2_APPS_CLK: /* SDC2 */
>>
>> Should be GCC_SDCC2_AHB_CLK
> 
> why? also if I do that, mcc fails to probe

GCC_SDCC2_APPS_CLK is correct, that's the "core" clock and the one the 
sdhci_msm driver calls clk_set_rate() on. So this patch is good. I 
suspect the misuse of GCC_SDCC1_APPS_CLK is from way back when this 
board had a custom DT that didn't follow upstream.

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>>
>>
>>>    		return clk_init_sdc(priv, rate);
>>>    		break;
>>>    	case GCC_BLSP2_UART2_APPS_CLK: /*UART2*/
>>

-- 
Caleb (they/them)

