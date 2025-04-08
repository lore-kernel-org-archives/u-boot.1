Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 755C6C3600C
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 12:14:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B37C882E86;
	Tue,  8 Apr 2025 14:14:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ATCzhopd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 252D182ECC; Tue,  8 Apr 2025 14:14:00 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B113382E50
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 14:13:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43cfb6e9031so49775265e9.0
 for <u-boot@lists.denx.de>; Tue, 08 Apr 2025 05:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744114437; x=1744719237; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6TP8w4i+SCVHwcwGKZitP9mBYBJjumAQ7LXmmvgftsk=;
 b=ATCzhopdLgPfVoUBEAOtLtEGpHRNxjAY9kYGveP2ljWmHSU7EzLhuqaEJPrjCGxOmf
 ci1ZP5C5l6mtfXrZmLwvEsLAgDEZtfZbkdcxGqW6eHyGZ+PFe1T5vmgHtnqj9j0E6UIj
 hAL/dxkLCKGgiIJVo0Bw6KMdenPrx7V+TW6S1WN3cAgOmDnWQrQRk9uqpLgiFV47wMtn
 uNt9Nft4+ClMsBgxt1rd9DEPl8yKztpH1b3YNkbP246snrWPrI2qhSEcY+0AgcnmSaKK
 1BUMOC6ZG+pHTCu01b3UpmnUWVxlgLF6eU5v4Uk4LXV4NGYOoxa1l0eG7p9Bu04d+cCH
 /M6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744114437; x=1744719237;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6TP8w4i+SCVHwcwGKZitP9mBYBJjumAQ7LXmmvgftsk=;
 b=Wt3FN6pWIKfIxzdiOZsgoOhAbIxFtvg6xK3VfvKRG4jmV/2RmlOCcPntYzdVLfXi/w
 /+v0PUdAoapHi0FDAubimMwatu1PIEgxuecTILoIA4Cwo0fQiZnWl/LWmc1h9K92yJil
 4/NI1UXQr8nsd9yrRySycN9AriYsCffw7jj8qx6D6cWvYs1Q/UzYmUD3x4FOu942Uyiu
 RlgKveXqpGQSDZVEZIA9A21CxVK6e46wjPRNDIymnm7SuH/HyjqwwexVeXfFS03JNscp
 Fc/fKjRahXHA0nxqLl9WEGR0xRfbSJ4H1HybQKi4e4x4wep06hOBOIxV0DEeBVLecI+9
 OM4A==
X-Gm-Message-State: AOJu0YwibOjKDJsFkBd2/CdD4YD749QSQYe7Y0zwRNUvzgpAm/SU8cfT
 207MZdH9e7Jz6lyFU5CtjL3dftGNcmv4guE5T3xV/VXusyOy13Jsf+LPgZf9tqE=
X-Gm-Gg: ASbGnctI7m6KSkroPjDd3qzmNZ88q9HLI70ncO02u+bDoe/wC6Z7m71T2xI7rhs/lNe
 HeOi6QUxqioyjYo+DPq9dj5MDLbQyg/XZgJdJeOBnMYeCV9plIuyyfyKuc6r4lnxVXIVcVMeAbk
 ffETDChhtR6inst1DLvpZyPOCfBZLTJww0cB0LWCK1Mh5VSJ0v0dZ/Wp7yflWrJQ9lMxNjXXL+3
 aOhSwVuuR7BUFjg1zQuS2L2r/lAYBovA5ZLyb7LLTlm9++pqNQhvj5O8mUG56jLf6PNqIZMJdir
 curctMDNpaR81diAFxo7lIpS7qTwRSucTUatwhRup/Hqda6QNaBwTNCKXazDxqdeOtMmvE/D3eZ
 jl+HjGK8=
X-Google-Smtp-Source: AGHT+IH6DyzXxD3XonRQ5wKOAIGAKzmoXvMWIibf+eccoUGoVbWAOkIbEM7r8fEhVfDpR1a1fqFc3w==
X-Received: by 2002:a05:600c:4f54:b0:43c:fbe2:df3c with SMTP id
 5b1f17b1804b1-43f17260f66mr11652205e9.26.1744114437206; 
 Tue, 08 Apr 2025 05:13:57 -0700 (PDT)
Received: from [192.168.1.47] (i5E863B08.versanet.de. [94.134.59.8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301a6a60sm14457017f8f.29.2025.04.08.05.13.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Apr 2025 05:13:56 -0700 (PDT)
Message-ID: <179cca81-d835-4966-b992-361bc1d08d03@linaro.org>
Date: Tue, 8 Apr 2025 14:13:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] qcom_defconfig: Disable MMC HS200 mode support
To: Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, neil.armstrong@linaro.org, trini@konsulko.com,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20250407132810.35149-1-sumit.garg@kernel.org>
 <20250407132810.35149-3-sumit.garg@kernel.org>
 <510b1e90-bf1e-4a7b-8a86-c8fbaf485fb6@linaro.org> <Z_SmE-gQzzs5HJqi@sumit-X1>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <Z_SmE-gQzzs5HJqi@sumit-X1>
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



On 4/8/25 06:29, Sumit Garg wrote:
> On Mon, Apr 07, 2025 at 04:30:44PM +0200, Caleb Connolly wrote:
>>
>>
>> On 4/7/25 15:28, Sumit Garg wrote:
>>> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
>>>
>>> Currently the msm_sdhci doesn't yet support DLL configurations which are
>>> required to enable bus speeds greater that 100MHz. So disable HS200 mode
>>> support as of now as it requires bus speeds of 200MHz.
>>>
>>> This should fix eMMC issues reported on RB1.
>>
>> This fixes the write corruption issues? Nice find!!
> 
> Yeah, thanks.
> 
>>
>> Is this a problem on ALL Qualcomm platforms? the sdcard seems to work fine
>> on other boards, would this reduce their performance?
> 
> Yes this problem should affect all Qualcomm platforms but it hasn't been
> seen there as mostly SD cards available don't support HS200 mode. The SD
> cards usually works in high speed mode whose performance remains
> unaffected by this change. It only affects RB1/RB2 as eMMC flash on
> these support HS200 mode but the U-Boot driver currently is incapable of
> supporting that.

Ok awesome. Could you include this info in the commit message? Then

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>

Kind regards,>
> -Sumit
> 
>>
>>>
>>> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
>>> ---
>>>    configs/qcom_defconfig | 1 -
>>>    1 file changed, 1 deletion(-)
>>>
>>> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
>>> index a2b54b95f19..537806450dc 100644
>>> --- a/configs/qcom_defconfig
>>> +++ b/configs/qcom_defconfig
>>> @@ -81,7 +81,6 @@ CONFIG_QCOM_HYP_SMMU=y
>>>    CONFIG_MISC=y
>>>    CONFIG_NVMEM=y
>>>    CONFIG_I2C_EEPROM=y
>>> -CONFIG_MMC_HS200_SUPPORT=y
>>>    CONFIG_MMC_SDHCI=y
>>>    CONFIG_MMC_SDHCI_ADMA=y
>>>    CONFIG_MMC_SDHCI_MSM=y
>>
>> -- 
>> Caleb (they/them)
>>

-- 
Caleb (they/them)

