Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62975C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 07:09:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0D8F88189;
	Mon, 15 Apr 2024 09:09:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ByairiYg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA22D881D0; Mon, 15 Apr 2024 09:09:37 +0200 (CEST)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 936348813C
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 09:09:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-5d8b519e438so2072972a12.1
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 00:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713164974; x=1713769774; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MusjT0TUdrKpUR3rqpIP+5n3EI2bjtH4csy1sMeT+aY=;
 b=ByairiYgbizH/XV71RaVeujFYlPUARbLKVRXOuLysOKvNmK53+itMYmovSJSHR2iP6
 KM2yy86G3iYX6Um0XvD9uPW/qoN8ogFnmUrMP1RnKoiV3jOFtkanHLlujwmC7WcuxXPY
 eD2eiey8tP8FWITA6e6vty7L6dZ77swrjlhA5EFG/+uzkhUt4ZH9NXP7ZH2GW7YyaM2M
 RYYRxaTs6tGpCCBpBS0Ht/ofAabKTCs4EBGo4vl/dUdV3YilmIly1b4tWiSw6V06M339
 1YO7ruXtQiJ0zivmiOG4ipgRnDC47HNXfNH2wM/Fc0Uh88zTiO1oMMrPJIK34WP529Pt
 ZcSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713164974; x=1713769774;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MusjT0TUdrKpUR3rqpIP+5n3EI2bjtH4csy1sMeT+aY=;
 b=NrguFIfKErg37xRwMXH821C+IYzgYjFPkZvhrlnR2y4F6OV8aQ6ejGW6d8BkDzni7+
 lKM0Kqx7Nv0vAbWitEebvhv2MQT0bOUGRG9nJWt+WWjfjfHykbYYBtL3jiV3iOPinvNc
 nKK1RojOSWjQ/frdCzZOU3K7zKEJEYKKw4f4Lr5OLpe9f8KFB4w2Sjx9fdSkHT6A/yHR
 K9yRr2ppQslOYrxse+0Bja6EJyepxARA7o6veqOSQupNdRoAKCCbaDPsnvFvLcpvPFxC
 kXHTx840S2ze7GIV6pA6DedE3Yv6kTZguNjvghFAgmTiwc/f87uc6w85uFHYp9o0+yMS
 +7CQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXucnn2R+40w9kb9yC36SHBG0/OvNYpUM+ylVNY5dWfhlbSGYrXqI3nLuAX3GbohxLvY0KZD9IQHkOrRyE4GOX5mwCfcA==
X-Gm-Message-State: AOJu0YxclsHpbH4c4BvZUjlvt6xPESAl7/JJ2aqOWli0za26j9Z0TPpo
 MdgqpBV8lGrqFy/djp8U7MpjyaewSL2oFZniFTPkUJGFw8Rxz1aWpQpv0A==
X-Google-Smtp-Source: AGHT+IGFzejOfbu44I+mJIuEd9XCw/7QGvfV3rCGo4fY/AJCJafhW8zv75/yJF+h0jIL7kr+B/P7Sw==
X-Received: by 2002:a17:90a:9ac:b0:2a0:4c3b:2c39 with SMTP id
 41-20020a17090a09ac00b002a04c3b2c39mr7500780pjo.23.1713164973971; 
 Mon, 15 Apr 2024 00:09:33 -0700 (PDT)
Received: from [192.168.0.8] (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 mz10-20020a17090b378a00b002a63e966fd7sm6441437pjb.47.2024.04.15.00.09.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Apr 2024 00:09:33 -0700 (PDT)
Message-ID: <7149031f-b359-4218-9a52-e4ab0ea16c4c@gmail.com>
Date: Mon, 15 Apr 2024 16:09:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] mtd: spi-nor-core: Rework default_init() to take
 flash_parameter
To: Tudor Ambarus <tudor.ambarus@linaro.org>, u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, pratyush@kernel.org,
 d-gole@ti.com, Bacem.Daassi@infineon.com,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
References: <cover.1713154967.git.Takahiro.Kuwano@infineon.com>
 <9db9fb39e655b514c21952e0a5005572510ad3ec.1713154967.git.Takahiro.Kuwano@infineon.com>
 <377037b3-1bf2-492b-bb88-de233d8b373c@linaro.org>
Content-Language: en-US
From: Takahiro Kuwano <tkuw584924@gmail.com>
In-Reply-To: <377037b3-1bf2-492b-bb88-de233d8b373c@linaro.org>
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

Hi Tudor,

On 4/15/2024 3:47 PM, Tudor Ambarus wrote:
> 
> 
> On 4/15/24 05:33, tkuw584924@gmail.com wrote:
>> From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
>>
>> default_init() fixup hook should be used to initialize flash parameters
>> when its information is not provided in SFDP. To support that case, it
>> needs to take flash_parameter structure like as other hooks.
>>
>> Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
>> ---
> 
> I'd like to get rid of the default_init hook, let's not extend it if
> possible. Can you use the late_init hook instead?
> 
It looks easy to migrate from default_init to late_init so I will do it.
Could you provide the links to related discussion in Linux MTD side so that
I can summarize it in commit message?

Thanks,
Takahiro
