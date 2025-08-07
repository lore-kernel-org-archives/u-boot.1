Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9473C87FCA
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 14:56:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DECA845B0;
	Thu,  7 Aug 2025 16:56:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ttgZoFra";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 616DC845B4; Thu,  7 Aug 2025 16:56:06 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1263D8459D
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 16:56:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3b8d0f1fb49so622999f8f.2
 for <u-boot@lists.denx.de>; Thu, 07 Aug 2025 07:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754578563; x=1755183363; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RD1EGMK9sp9hXyNdULVuv/LOWhHzq4+iTdE1v4k524w=;
 b=ttgZoFraK8fqEbDg6CAP4C2N+RPOYGiGYqFI6c1BjboBzertA/aSxaUB6OOtOrCGMG
 Y2wdRyK1GRkaSr38vHQ7nvjxM073Mf599Tw0uPQVoQ/OHYmss3ECAMSt56PAeEsSZY55
 P0tRRI9JZrXk1yJ4NA4GEZj8f2U0IxjtqjzrDovmbulEOPFbA2PROPz4ZrRduzPgUklR
 +m1/6/SKk1VSUdF7ih/8kml8rXazRSov3nKmKDVmmmGMznCMnpNbzuzuMtyYXJmOYSQI
 TWXnA+LIbVgKuzQISjOj9Ml2Hn5cTdaT/iR/BnIHjNQ482aL3oGQqVVA+4TabHZvWfTw
 AECQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754578563; x=1755183363;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RD1EGMK9sp9hXyNdULVuv/LOWhHzq4+iTdE1v4k524w=;
 b=QJNM3owOvro/a4LqknEWI2Z8oyQO6dB5I1B9w+gCw5aOCBxXxxKdMFMacvcvDclIMg
 vpkGQMqugQinXCYp3I27kzdei10SwSeeVUuJt5wnk1pUjFVmgsCT6YbPgRYHXmmbcyNH
 f6UaZb/iOr/cB+nWR6NAnw0GjLNOUVf8xogJFLjieAhUQuAYIBKkrKzfvWPiO12vRHJy
 9Dzo/uDaz8oRiSPdjaQWld+Jtm9pukOIQRVXNcZRHQho4nrutNwvCyjl+sS7ekj+5YgQ
 CzjoidqLzMSbKD2kuPq2lLS6lE7mMpmwQs9WpQY+KZqGlsIwWlmVbvAppT8L3tpB1WzI
 q+lw==
X-Gm-Message-State: AOJu0Yxp7FwqckW/QeaE0/gXxJi43Fw0grDcPfjImv4Z9hWG/tw10ZCP
 rmEixU0wIygxhp4C920sapB3xrdCNcxZeumIVfHGgxy+juqOcg//wRXM0/vj7AvkZvo=
X-Gm-Gg: ASbGnctLhUJfrTm3XFU8if/XbP4k7CTY4LIWfXeN2M5fDufnZtlVBlzZVb+Km7WzsxW
 zzgHXXu99U1HvDFyyZVCzsN3GszXEWL8G7wqtkcUB5WUVUIUfs84swto/oR8ee0VXZOclK3Op2j
 k/6kvAaaH7ZkQo32eaf8Z7gDsFDfEJYd1/GD9FUHJM4ZxPOSvW3o0IrDzD+WCvxHCrmZhyg9zNa
 xmjSq97neyxr7s+p0oUpyPe19qUIYCfWBmfVrW6BjiqJDmLzTVLvaiZxZy6SwOnotDR9VCMCzXk
 iZgVcCfgHYHEdCfylkmfGATmzgCQRjsy/TYYQWFdr7K/KQ5P1yBPh3KAzJ4fq0kpaggQTwIaQFF
 31pL8/JofuCHj6tyGafvMsfFGBiIxeRXCzetmr5TOrsv3Oz9UjcILhmcQB0J7S59u7qP7+v8xw2
 d5BA==
X-Google-Smtp-Source: AGHT+IGoa9DWzvhpksLW3h5uxXT4omHtQYUpQHsVKAojAhdLOGCqmA1GurxsfT7kuPbSy4TMZRaLrg==
X-Received: by 2002:a05:6000:4308:b0:3b7:8268:8335 with SMTP id
 ffacd0b85a97d-3b8f41f2c7cmr5853013f8f.42.1754578563318; 
 Thu, 07 Aug 2025 07:56:03 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:f9e:3c01:377e:cf4f:d0ff:80bf?
 ([2a0a:ef40:f9e:3c01:377e:cf4f:d0ff:80bf])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b8ff860acbsm824520f8f.51.2025.08.07.07.56.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Aug 2025 07:56:02 -0700 (PDT)
Message-ID: <964f03a6-6784-4450-ae20-0cbd8ad3383d@linaro.org>
Date: Thu, 7 Aug 2025 15:56:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: mtd: Prevent use of uninitialised variable
To: Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250626-mtd_fix-v1-1-1ffcc59a9d0a@linaro.org>
 <b8e3d928-7f3c-46ef-bf6d-6eb8a48931ac@cherry.de>
 <84d760dc-cc1d-46ab-bded-d7c6f72abbf5@linaro.org>
 <b6afd62d-407b-4671-bac8-5a2608acfc22@cherry.de>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <b6afd62d-407b-4671-bac8-5a2608acfc22@cherry.de>
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

On 26/06/2025 12:32, Quentin Schulz wrote:
> Hi Andrew,
> 
> On 6/26/25 1:29 PM, Andrew Goodbody wrote:
>> On 26/06/2025 12:14, Quentin Schulz wrote:
>>> Hi Andrew,
>>>
>>> On 6/26/25 12:49 PM, Andrew Goodbody wrote:
>>>> ret maybe used uninitialised in some cases so instead
>>>> initialise it first to prevent this.
>>>>
>>>
>>> I don't believe that's true, can you tell us which code path(s) could 
>>> trigger this because I didn't find one the 2min I spent reading the 
>>> code.
>>
>> No error path taken before line 563, ret is still not assigned to.
>> remaining == 0 which could come from being passed 0 on the command 
>> line, line 518, unless there is a check for that that I missed?
>> Code reaches line 591 without assigning to ret.
>>
> 
> Indeed, clearly missed that!
> 
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> 
> Thanks!
> Quentin

Is there anything else needed before this can be merged please?

Thanks,
Andrew
