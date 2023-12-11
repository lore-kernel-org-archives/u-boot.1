Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 069D1C4332F
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 19:47:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 334CE871AA;
	Mon, 11 Dec 2023 20:47:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gs6jEOK0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 051D287710; Mon, 11 Dec 2023 20:47:08 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E50A687032
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 20:47:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-33622099f23so1101806f8f.0
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 11:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702324025; x=1702928825; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MksC9JPL7uCcnAJCZK81863YVJsay4iF56NeSKjiV1g=;
 b=gs6jEOK0mqHfC0g5IiCohLdZ7HmZSE99jLE5xwmumTJbCsxAAWYdihgMeBdl6VplJh
 +ExgUdIvKkja+0HDyZDUDDKP6JoYb+PgMdSI2182kdeZveOPtPPS76XnRuuDFVa17wot
 1laARMShsrx2yplvWSA58t9PlEj8ef5LXdY4HKksqNFO1iLKXuEpBCs40/KRC0f9BYxA
 EQta+J5KWNVXdbcAYTvpVhy5+rEk4WW4u7zOJG8vUTJPeLkTEAJoroIQ+7SrsRQqXM/u
 Us4NVQf+mesPqy7G1//aQbp9URZwvFfbZgYMWglXgLH7GHbs3qY0DEYCDYzvwXKseBg4
 DquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702324025; x=1702928825;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MksC9JPL7uCcnAJCZK81863YVJsay4iF56NeSKjiV1g=;
 b=LeKum1w5CJitHOr22Rybq+EvxonqLfkT8EYX++S2sILssXyDodF3ZUk8BJ1xwrHTax
 LB/L6wNM6bWqS2D+6/RvAPU3IJ1K8EYEv2a1vxIbaiB79jGzrJDX3lWgm7/JPLteCxyi
 daZcON1gnI9nGFCsATs3kzwE5paQioLlzLSeARwWF+dH+Ven/6YBcCkmqGuEXJL3jHlG
 c/tlADUAEzfmihDsgSz1ELiWnhRuSdw1gdde9Kp9Jhtmmgqkg5apodM9WSw4KUe4CooY
 szKo8Sc0woL7YfAPhWuPhNf5iOf8hHt263z8X31rsUm9mbJuZf4PRw2rknexVgYQyEwL
 RjwQ==
X-Gm-Message-State: AOJu0YyQro7/JJ8knSxXjLFCuULZeCdhM5B2JVx3Tf3AyIqt8VvG/0jl
 9OmEo45HMzjllggbipvAZ7S0ZK1Qwwgny5PvdGrhCQ==
X-Google-Smtp-Source: AGHT+IGY5eW71tkKcMtoxciCjkqTkZaXLj7t6mGJvhV3EZfECBm8QSx5R3fY0/XDEk7AqWrkFi4Skw==
X-Received: by 2002:adf:fc8b:0:b0:334:b225:daf1 with SMTP id
 g11-20020adffc8b000000b00334b225daf1mr2652432wrr.51.1702324025267; 
 Mon, 11 Dec 2023 11:47:05 -0800 (PST)
Received: from [192.168.1.83] (host-92-17-96-230.as13285.net. [92.17.96.230])
 by smtp.gmail.com with ESMTPSA id
 m11-20020adfe94b000000b00333504001acsm9237827wrn.15.2023.12.11.11.47.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Dec 2023 11:47:04 -0800 (PST)
Message-ID: <8eeafbf4-04c9-465a-ac79-4356664033f5@linaro.org>
Date: Mon, 11 Dec 2023 19:47:04 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] iommu: fix compilation when CONFIG_PCI disabled
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, Dragan Simic <dsimic@manjaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
References: <20231211-b4-dwc3-qcom-v1-0-46275113b4f2@linaro.org>
 <20231211-b4-dwc3-qcom-v1-1-46275113b4f2@linaro.org>
 <e99c00cbe8b0cf7f8a4c9217d5298625@manjaro.org>
 <20231211191726.GV2513409@bill-the-cat>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20231211191726.GV2513409@bill-the-cat>
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



On 11/12/2023 19:17, Tom Rini wrote:
> On Mon, Dec 11, 2023 at 08:08:32PM +0100, Dragan Simic wrote:
>> On 2023-12-11 19:41, Caleb Connolly wrote:
>>> The dev_pci_iommu_enable() function is only available when CONFIG_PCI is
>>> enabled, replace the runtime check with a preprocessor one to fix
>>> compilation with pci disabled.
>>>
>>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>>> ---
>>>  drivers/iommu/iommu-uclass.c | 5 +++--
>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/iommu/iommu-uclass.c b/drivers/iommu/iommu-uclass.c
>>> index 72f123df55a5..98731d5e2c44 100644
>>> --- a/drivers/iommu/iommu-uclass.c
>>> +++ b/drivers/iommu/iommu-uclass.c
>>> @@ -100,9 +100,10 @@ int dev_iommu_enable(struct udevice *dev)
>>>  		dev->iommu = dev_iommu;
>>>  	}
>>>
>>> -	if (CONFIG_IS_ENABLED(PCI) && count < 0 &&
>>> -	    device_is_on_pci_bus(dev))
>>> +#if CONFIG_IS_ENABLED(PCI)
>>> +	if (count < 0 && device_is_on_pci_bus(dev))
>>>  		return dev_pci_iommu_enable(dev);
>>> +#endif
>>>
>>>  	return 0;
>>>  }
>>
>> Perhaps there's no need to introduce an ifdef here.
> 
> Yes, how exactly are you getting a build failure? dev_pci_iommu_enable
> should be available and return false with CONFIG_PCI=n.

Hi,

Without this patch I get

../drivers/iommu/iommu-uclass.c: In function 'dev_iommu_enable':
../drivers/iommu/iommu-uclass.c:116:24: warning: implicit declaration of
function 'dev_pci_iommu_enable'; did you mean 'dev_iommu_enable'?
[-Wimplicit-function-declaration]
  116 |                 return dev_pci_iommu_enable(dev);
      |                        ^~~~~~~~~~~~~~~~~~~~
      |                        dev_iommu_enable

Grepping shows there is only one definition, which is the static
function definition in iommu-uclass which is #ifdef'd out when
CONFIG_PCI is disabled.

; rg "dev_pci_iommu_enable"
drivers/iommu/iommu-uclass.c
18:static int dev_pci_iommu_enable(struct udevice *dev)
116:            return dev_pci_iommu_enable(dev);
> 

Am I missing a patch or something? The function is only defined in one
place in the whole of U-Boot.

-- 
// Caleb (they/them)
