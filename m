Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9860BCD11C2
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 02:38:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C126C87B71;
	Thu, 11 Apr 2024 04:37:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ng1qzx4W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A56A187B71; Thu, 11 Apr 2024 04:37:57 +0200 (CEST)
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com
 [IPv6:2607:f8b0:4864:20::e36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 785E587861
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 04:37:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-vs1-xe36.google.com with SMTP id
 ada2fe7eead31-479d6a85be8so1894522137.3
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 19:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712803074; x=1713407874; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=owVYAHCr1XuTJ1P/YZ0cSAC1cTziZOHYmXEJplfmC2g=;
 b=ng1qzx4WAxH28InemHZK+iZ4+zKy2lv2EnwtHik81hyj6bbough1cGHCy7kPRSd0mG
 8O/raCylF9ci1sfydk4qGkKrh6QzNPHdxsq4Yvb0NTKNVm23biIYSheodLkeSd1qHfsG
 UyNbc6Een8gLi3xxNfT/NsqnO2BOtRPg+mqymF7ye6f3WGaTDbPj7livmoBQZjloCsQf
 J/AlJJEsrG3kuVElCIS1qemUDJUwlA29TMqltfO6CmrYQV9ErAHXOZf4h8potCbFfmG3
 E+XYOJ0I3d+kVXyU1EESaAQxpFzz/o6KyMARtdwJreJs120C6bpdKUn61OxaZzbK6f29
 VuMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712803074; x=1713407874;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=owVYAHCr1XuTJ1P/YZ0cSAC1cTziZOHYmXEJplfmC2g=;
 b=fxUQVcJ5t+GyWd1H9ARMrGIvHoHPpeMn5Bg+f8oZE9tb32OaSpjA/O9zc0vNP6zPux
 KyKghep47ocW7Kst0F9sfN9Zkatvw0p2MAUjfQdMAw22SGKSEItbVEqLa8y9HAk0NDuM
 9A//vsz4TsgQgtg7dG0ZagUo1UvMAzdSmTG+x/vl8aBRSs2RguK7dh/Ba5+oGQGBqqjV
 IWkKUoHlRHr3stN2BuvC2ev6kEgefcPOGMPzDFKL+qMGwamQEdHHQDZg6KhVi6on/yV/
 gzBpkJ9QPug8URNjdFlWtL6Pq59qFGaJHkUUu62+3YeK+2wc/0NyNKjNWjp2iTRKtJiS
 RHjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7BfADivOfCWIltnNsZ1VkW/lxfsCN9rUWXzmoZVMKRg31PxPJ9RVxmLd0Nr7+A7il+QVOLogoIwgDqAGt3k5hILLngQ==
X-Gm-Message-State: AOJu0Yzl13gwYHssUwJyNmZM1awmrdt4v73lfx1cgYt3DzW+KW8/tEdM
 CrjX8ukFYtBa9QA0FAt+1p6uTm1s/35lWzvZZNITInWkAqLYb3Zj
X-Google-Smtp-Source: AGHT+IF5CprbEBcewh60cXFWiz9OBiUC01+xC+BH59TtnXgo3OLVsJ8uLitRWVdYFj9ovDlAt76mgA==
X-Received: by 2002:a05:6102:3752:b0:47a:2a5e:683b with SMTP id
 u18-20020a056102375200b0047a2a5e683bmr3246660vst.8.1712803074293; 
 Wed, 10 Apr 2024 19:37:54 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 mi3-20020a056214558300b0069b33319fbesm342074qvb.25.2024.04.10.19.37.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Apr 2024 19:37:53 -0700 (PDT)
Message-ID: <61d7423a-5240-c746-b724-4d51b7d5ad74@gmail.com>
Date: Wed, 10 Apr 2024 22:37:52 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] dm: core: add support for fallback drivers
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, Simon Glass
 <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
References: <20240410-b4-stub-drivers-v1-0-6935bd2c07d1@linaro.org>
 <20240410-b4-stub-drivers-v1-1-6935bd2c07d1@linaro.org>
 <1EFAA3ED-7C3B-43DA-AA0A-FC520FF16290@gmx.de>
 <20240410194452.GG2493117@bill-the-cat>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20240410194452.GG2493117@bill-the-cat>
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

On 4/10/24 15:44, Tom Rini wrote:
> On Wed, Apr 10, 2024 at 07:27:17PM +0200, Heinrich Schuchardt wrote:
>>
>>
>> Am 10. April 2024 19:06:57 MESZ schrieb Caleb Connolly <caleb.connolly@linaro.org>:
>>> Introduce support for a uclass to provide a fallback/stub driver which
>>> can be used when no device is found for a given node. This might be
>>> useful for handling non-essential clock controllers like the RPMh on
>>> Qualcomm platforms, or during early bringup to get UART output before a
>>> real clock driver has been created.
>>>
>>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>>> ---
>>> drivers/core/Kconfig  | 10 ++++++++++
>>> drivers/core/uclass.c | 24 +++++++++++++++++++++++-
>>> include/dm/uclass.h   |  3 +++
>>> 3 files changed, 36 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/core/Kconfig b/drivers/core/Kconfig
>>> index 1081d61fcf01..09075b9b7a15 100644
>>> --- a/drivers/core/Kconfig
>>> +++ b/drivers/core/Kconfig
>>> @@ -466,5 +466,15 @@ config BOUNCE_BUFFER
>>>
>>> 	  A second possible use of bounce buffers is their ability to
>>> 	  provide aligned buffers for DMA operations.
>>>
>>> +menuconfig FALLBACK_DRIVERS
>>
>> Wouldn't it be preferable to mark individual drivers as fallback drivers in their declaration?
>>
>> This would allow alternative fallback drivers and would not require any definitions at uclass level.
>>
>> Just by building a fallback driver you would enable the fallback behavior for its uclass.
> 
> I think some of this is addressed in the cover letter. My concern /
> questions come down to I think just a matter of naming. Both "fallback"
> and "stub" are used at times. As a concept, we have some areas where we
> need a no-op driver because whereas the DT describes a relationship in
> the hardware, here in U-Boot we can just accept things as configured. To
> me "fallback" implies more functionality of the driver when it's really
> just a generic no-op driver to fill in the dependencies within the tree.
> Can we rename things a bit along those lines?
> 

I would rather just have a stub driver with compatibles for all clocks we want
it to match. I think having a generic fallback driver could cause issues in the
future if we need to switch over to using a real driver.

--Sean
