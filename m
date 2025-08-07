Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D86C87FCA
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 15:07:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12CCE845C5;
	Thu,  7 Aug 2025 17:07:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UJ1t+DXZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D42D2845C9; Thu,  7 Aug 2025 17:07:10 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87874845B3
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 17:07:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3b792b0b829so906118f8f.3
 for <u-boot@lists.denx.de>; Thu, 07 Aug 2025 08:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754579228; x=1755184028; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1NPoBVvBVglgwFwseFIQSlJTjrIPpVM+D9vZtsczBUk=;
 b=UJ1t+DXZo3LPKd54kCFnnu6fR/SG3Aq9ceMRGe5vv20HJr+iSGzU25X5z7wtxZ7J49
 L4WK1eetdFwkTTeUQBEBOeRCM8sSTWtZYOGla4OHby7vvBlzXqOso2OTGLsFQ7KWT54P
 EGoLuoklbB5BUyTG9ET0dEDVkQQVdTMEVabUecVBkBFlGSnhYaVYdOxhbR8Si24U1hwH
 ssScIz407emLH2T7NmNQJC2/TDRlBg9g6X+B/Qi4+J7M1qw2qDJwhFCoK+l9yV/tm8z4
 b/0KLOW21wsXsW/Quu4ngoWswL4IGG3HTvpfaRfTdu0wM+hVLdNhU4vry124T3qxbuBK
 Q2RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754579228; x=1755184028;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1NPoBVvBVglgwFwseFIQSlJTjrIPpVM+D9vZtsczBUk=;
 b=u28CoAcu7RW3SbZe4dV0VsHVf/q0Pq4ozw8GzzonSy5qXvmA9/WXicE1w4YiVKsZdD
 wrytjsanpWGeIMbj9PFaNdGjQhoaP82yT/IW8ajri1Tp0nYqqYjVL+Tn4FSIavJKyj22
 1WauaPGfhu8vapYp5zSiXNHrNqquwV1sKwuPOa2Y98n52m7TEQnBZe+WGfbXXteEBkal
 0yVgj4upckvPyDNvNqbML+VbMDOdqX5pRwRN2Cm7CzYcd2fYwT1AldhWobTbfrZ4vyAR
 YDOifH84nOAz7xGMuweJkMSdkCts9fB+GTtPoMoaySmRlOC6pasH+3vSWD0EnRZnD190
 +xAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDA0V5omdufInzaQymJR5TIvwvgmCRTiad18Lah5Inq35LTHcW4vq6A00GCuNvgqjKZCixBuE=@lists.denx.de
X-Gm-Message-State: AOJu0YzmG/i0OUsAqA7IeqwCoXhGqhyJuRDSbIckgdrppxuVY7FNxLpq
 al7l0VoP/LXhMPe2GXeAdds8hB8v12dU602zln8r6KgfwSuec7mZcTeL/OhYyvhmokc=
X-Gm-Gg: ASbGnctNA0vs2mBipN1jk10M8aRjUm/gnF6V2jUMo1QXhWPNOudci34TWnSIucAX6iG
 aPWHIZmMntsXqrIirTBJNZ/74DhfhUADNuAE0TAX/SdJKtPRrJ42VDu/l1aL4cD6Jm1oKGK1LFr
 bZ55P+PbcnC2Zv/HRmFYnxMAC0t5kMbOk3ETd1kLPt/GYf8h8XwpHM0oaYAetC7oTIBAS5f0Qyg
 z/N8u71Z1luFDWclgtSTuj3LEStLpjga5mCu2+pifax2C8CqiutxY3hcQawDQUA4O3dddlI2BBA
 LrBFM8AYeq9XbpGMxwBCGkYEvywrxxR6nNiemLINO1O1iBNObVS4u4Ai/ssPgv+7M7Gp6WenUsQ
 LKIeS6I+2ArpvM5to+gy6uieUXuJ76K+T0hdwcJd19Uy4JASVVSe4Z0/whYioVO0qCIySz0Tyw4
 VCuQ==
X-Google-Smtp-Source: AGHT+IEgeXGFqt/8N7ZVklBT55xfGRgC+GqfqTENQ9uCNgz/8aJqMRq2oPSMRfukR28VamzIgD/dKw==
X-Received: by 2002:a05:6000:2d0b:b0:3b8:f8e5:f6be with SMTP id
 ffacd0b85a97d-3b8f8e5f822mr2780159f8f.4.1754579227916; 
 Thu, 07 Aug 2025 08:07:07 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:f9e:3c01:377e:cf4f:d0ff:80bf?
 ([2a0a:ef40:f9e:3c01:377e:cf4f:d0ff:80bf])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3b9eddsm27059428f8f.22.2025.08.07.08.07.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Aug 2025 08:07:07 -0700 (PDT)
Message-ID: <e70bf33e-49a8-4141-8a1e-a7a6c6d73375@linaro.org>
Date: Thu, 7 Aug 2025 16:07:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] adc: meson-saradc: uint cannot be less than zero
To: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
References: <20250722-meson_saradc-v1-1-1ab45d53da9d@linaro.org>
 <17e87341-745b-4f5e-af9c-4c9abe9a2e72@linaro.org>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <17e87341-745b-4f5e-af9c-4c9abe9a2e72@linaro.org>
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

On 24/07/2025 09:30, Neil Armstrong wrote:
> On 22/07/2025 16:06, Andrew Goodbody wrote:
>> timeout is declared as a uint but then tested for being less than zero
>> which must always fail. Change the while loop for a pre-decrement on
>> timeout and test timeout for being zero.
>>
>> This issue was found by Smatch.
>>
>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>> ---
>>   drivers/adc/meson-saradc.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/adc/meson-saradc.c b/drivers/adc/meson-saradc.c
>> index 60e348968fb..0144ff828c5 100644
>> --- a/drivers/adc/meson-saradc.c
>> +++ b/drivers/adc/meson-saradc.c
>> @@ -205,9 +205,9 @@ static int meson_saradc_lock(struct 
>> meson_saradc_priv *priv)
>>       do {
>>           udelay(1);
>>           regmap_read(priv->regmap, MESON_SAR_ADC_DELAY, &val);
>> -    } while (val & MESON_SAR_ADC_DELAY_BL30_BUSY && timeout--);
>> +    } while (val & MESON_SAR_ADC_DELAY_BL30_BUSY && --timeout);
>> -    if (timeout < 0) {
>> +    if (!timeout) {
>>           printf("Timeout while waiting for BL30 unlock\n");
>>           return -ETIMEDOUT;
>>       }
>> @@ -256,9 +256,9 @@ static int meson_saradc_wait_busy_clear(struct 
>> meson_saradc_priv *priv)
>>       do {
>>           udelay(1);
>>           regmap_read(priv->regmap, MESON_SAR_ADC_REG0, &regval);
>> -    } while (FIELD_GET(MESON_SAR_ADC_REG0_BUSY_MASK, regval) && 
>> timeout--);
>> +    } while (FIELD_GET(MESON_SAR_ADC_REG0_BUSY_MASK, regval) && -- 
>> timeout);
>> -    if (timeout < 0)
>> +    if (!timeout)
>>           return -ETIMEDOUT;
>>       return 0;
>>
>> ---
>> base-commit: bd0ade7d090a334b3986936d63a34001d99722ad
>> change-id: 20250722-meson_saradc-4bba9dc18333
>>
>> Best regards,
> 
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Is there anything else needed before this can be merged please?

Thanks,
Andrew
