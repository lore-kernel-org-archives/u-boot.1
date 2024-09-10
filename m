Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0782ECE564
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 09:50:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D69788FC9;
	Tue, 10 Sep 2024 11:50:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gFJUH6gv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA68988FB7; Tue, 10 Sep 2024 11:50:22 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2FAE88C1B
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 11:50:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-42cbaf9bfdbso12021335e9.0
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 02:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725961810; x=1726566610; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YbppJgl6wdos+sFIVR8ApXSBMia2tiIIGkDLj12AvVs=;
 b=gFJUH6gv4AnkdvGjjPc4jka0KJiP3GUj5BHC5XdMESU2GkxEK2MCEjv05UJSAo4TJa
 hQ1X9h9QgJyfd0LSP1+l5ToGRVN3tXt2O+4zSXtnYghzkvApad1VfBTHbj98uQBxYBA7
 2O5Z97qB44szBrNNRV451/I0FWC5vsynvgYLI5+jY+j92mj+6JrmIfDVHy2MWKdd2FUp
 1l6dYVoMDg68fke3rQ43AiXSBCRqg7KmQ8rAnj3fGLsC7O8rsjIjDmgwmj9GLL1ffBSW
 O3lblUsK+QfWJ44HIc6bOpz8+mppm2/rcueH2haNRPDnL/q1sKUAPKU6IlN9l7WuxnHN
 eLkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725961810; x=1726566610;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YbppJgl6wdos+sFIVR8ApXSBMia2tiIIGkDLj12AvVs=;
 b=kc2hAxi0UfJ2Dx0AgqSjJ75L6pgka89MFoIvIbCjb9lxUrhl546F2SzD1Xx3/y1zzX
 qolLs8xxSESS5Frc6MhphUtn+hIvGOiz1yuysEHD8GUN1i/1IVBxQjDXydjnFyxAejOr
 52yRgGKWIEWtARKFkIlwxHyZKl4X2Qd1l02wrqXH5Gg6NDuOQcOtYjdQAneAwk4WV+Jr
 tDjFOz4IX5f6qjiPwUfjfQR0LrVxiLCMOCbnndbhkFJuVLbD0Ynhg7AKsMctxFf5pR7W
 tliMrgD6NgI0pe0TNl9Gyz8+bxarwRik6Dg5mLCqgLrv6qBMNSTWh0GDszSasaw3Pr0S
 v67w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGgSX+b22YlbPv0YZKZm5y3N7GHUPkUcHD/GiNOZ7Rs82jl+RQ+09k7l0zb65c9HEa/DBujr0=@lists.denx.de
X-Gm-Message-State: AOJu0YzqUAEhlTDzYfDmw+WSnW7j2Exx5DajrFe6RO2YmUZZL4qjUSEL
 Xd0gHzSTXknedto9mvb11K0X9umySt/38sPzf7ie07HMWJwG9CNfInA26v0qehY=
X-Google-Smtp-Source: AGHT+IHi8o2cHO4yZh2gPFv/HXOd6opkJ3wRKlk5mzNdNa7j8jvX2o7JSKfghSnMr89l/fzfo3Og+w==
X-Received: by 2002:a5d:590f:0:b0:371:7e73:eb43 with SMTP id
 ffacd0b85a97d-378896a403bmr8004657f8f.42.1725961810116; 
 Tue, 10 Sep 2024 02:50:10 -0700 (PDT)
Received: from [192.168.7.95] ([212.114.21.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378956de00fsm8371653f8f.99.2024.09.10.02.50.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 02:50:09 -0700 (PDT)
Message-ID: <ba59fbf9-5158-4f4b-b797-5c6253282576@linaro.org>
Date: Tue, 10 Sep 2024 11:50:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 21/25] Kconfig: fix undefined symbols (g_dnl*) when
 NET_LWIP is default enabled
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Miquel Raynal <miquel.raynal@bootlin.com>
References: <cover.1725625913.git.jerome.forissier@linaro.org>
 <9462e25d33d93c670a882e6ee329ca7e6668d7ab.1725625913.git.jerome.forissier@linaro.org>
 <0571d892-caa7-4f36-a094-bedb77ac33df@denx.de>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <0571d892-caa7-4f36-a094-bedb77ac33df@denx.de>
Content-Type: text/plain; charset=UTF-8
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



On 9/9/24 16:35, Marek Vasut wrote:
> On 9/6/24 2:33 PM, Jerome Forissier wrote:
>> Fix for link errors on am62px_evm_a53and other platforms when NET_LWIP
>> is enabled:
>>
>>   common/dfu.c:34:(.text.run_usb_dnl_gadget+0x68): undefined reference to `g_dnl_clear_detach
>>   [...]
>>   common/spl/spl_dfu.c:29:(.text.spl_dfu_cmd+0xb0): undefined reference to `run_usb_dnl_gadget'
>>
>> - DFU_OVER_USB compiles common/dfu.c which calls g_dnl_clear_detach()
>> which is implemented in drivers/usb/gadget/g_dnl.c which needs
>> USB_GADGET_DOWNLOAD
>> - SPL_DFU compiles common/spl/spl_dfu.c which calls run_usb_dnl_gadget()
>> which is implemented in common/dfu.c which needs DFU_OVER_USB
>>
>> Therefore add these dependencies to Kconfig.
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>> ---
>>   drivers/dfu/Kconfig        | 1 +
>>   drivers/usb/gadget/Kconfig | 1 +
>>   2 files changed, 2 insertions(+)
>>
>> diff --git a/drivers/dfu/Kconfig b/drivers/dfu/Kconfig
>> index d034b501360..7de629f103a 100644
>> --- a/drivers/dfu/Kconfig
>> +++ b/drivers/dfu/Kconfig
>> @@ -8,6 +8,7 @@ config DFU_OVER_USB
>>       bool
>>       select HASH
>>       depends on USB_GADGET
>> +    depends on USB_GADGET_DOWNLOAD
> 
> Is it necessary to 'depends' on both USB_GADGET and USB_GADGET_DOWNLOAD ? The later should imply the former is already selected, no ?

Yes, it looks like so. Will fix.

> 
>>   config DFU_OVER_TFTP
>>       bool
>> diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
>> index 03fe3bca197..ce9364c3172 100644
>> --- a/drivers/usb/gadget/Kconfig
>> +++ b/drivers/usb/gadget/Kconfig
>> @@ -324,6 +324,7 @@ config SPL_DFU
>>       select SPL_HASH
>>       select SPL_DFU_NO_RESET
>>       depends on SPL_RAM_SUPPORT
>> +    depends on DFU_OVER_USB
> Keep the list sorted please.

Sure.

I will post this one separately as I did for other fixes. Thanks for
the review.

-- 
Jerome
