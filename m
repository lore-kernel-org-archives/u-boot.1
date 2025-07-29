Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C35B0C87FC9
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 16:04:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 177A082BA1;
	Tue, 29 Jul 2025 18:04:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fl3OCb1s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7358182BA7; Tue, 29 Jul 2025 18:04:56 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0989382B07
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 18:04:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3b78310b296so1735830f8f.2
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 09:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753805093; x=1754409893; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l2vThJaJKcczSlKxJfC9nYfe3t/gDUxhwPCU9O8fvQQ=;
 b=fl3OCb1s+uqitBmVfxGZy7c1XCNz0Ogw1gddWN5V027DjtYR8YtRKVNOHm15d8bKXs
 RD417ew1f6id6JzUkFAK/9XbZvo9ZvV2VIU5tXjOSxhP4AByq38LaVh2YVdGklwEWuGP
 jDzZhZ0Kj5RLoxZoS0naZpyWl+Exq+9KcQ5jdcFy9tRNIF+AcvcrZkstHNdYGXfXdnOd
 N2OhvxiIpS0MhzjZgjTZLxDzIQcDY2VNiJuvx1rGlDZwvCW9IZKuy7ywHpK+GgHGub4M
 32dFZlQTRDNsanxMU7Jz/q8kYGhexeLEancFSjjgMLRCdBAYc33sWcW21mM15NJP3/5+
 Ds6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753805093; x=1754409893;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l2vThJaJKcczSlKxJfC9nYfe3t/gDUxhwPCU9O8fvQQ=;
 b=D482uDP4Zw/VaLUgaZLWueobI3e/xNxsZ8EWA5UiKpPhweifo55HShExPqWqttpYhQ
 b3jqFPTqFWV5Agpfw5NPk7CkH8iwz8Ym2g+GNYoqjLNj9vZOKCYvwRTEjTmMvuMsxCQ8
 iI75gxwbNG/yEfJifELLM6rWPVBGzsf4HOenQcvMz1q8UgLpAvREsLLXHIMKDbjv6OVU
 +BkZijxN1GjQeHueXF/uHOslk6vU2gvWG32rZ/QHjGa1l1dXBF7HwXrfc8OL7eyYYvNc
 KE0g9K9W3Jlqh+8o5Gsdo/wLa+kWjErEocdhSJuTC8pzgEn8R0jR7mhOSsg1OxUouiGC
 rwxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWY13VPbeLh3671Edv6krgnu/ALzjQuSSz17C3ztOZtTxc+gKZ7dwtjvLiPq2qZQNjQmtVWEVw=@lists.denx.de
X-Gm-Message-State: AOJu0Yw0t/59DF1JQYgDD5GxKIQt1STOP/7X2QGUjuyAqTUVOOomcYZD
 K0lF9OXsunOjH5NbGwNxlqqiUes8OsTfKsCqDPbZETNWYhOHg69tzkEJG9sWuMInxltIE+ACDkh
 2UunW
X-Gm-Gg: ASbGncvGHBnxc56cPqBZS1+tLroM+2nbW8aM0lVyGj2Wtrr7VJA1lRt2KS3oBnJdA0+
 7kI4eGyiyBVvwgUNeLtttCqSHt1ogBbquvAKJRuCFzd+mt+BDUsQKE6DXkDboL26wJIry+8zTfI
 OATHW+YAVCqGDW3V6US1xzifN3XoSxg2514KaaNBtklURzX2VZxSmlnyguMsl1P552PUxDDkobj
 9mRgUP6D56kojiRil+Mp0+ZyxFXmYdCg5fgjEsM7rXc8tmr1FSTNxM0zIjpseQoUQ4/v9gWaitY
 mWAjuPzrHBgCmJI2r6cstu1aAPu+3TOj18QmHGGX2wtEiq2XBtW5TtG3n/1HBzJj2Gw8Yjgd44D
 LYRXMsx9nLCx8F9SPbP2JXiBnWIcXdsjttez/3cgvK7OosUKQDgZ017Jxg5L1yUcCMTcKuhxehQ
 ==
X-Google-Smtp-Source: AGHT+IE8XP51jZfvQq577mnPNP8UERVq7ZuZpm4W29UVUSDLpnhFrHtR6WDlCjn7x9mP9d7Z47Mzeg==
X-Received: by 2002:a5d:5d87:0:b0:3b7:908e:e466 with SMTP id
 ffacd0b85a97d-3b795035673mr123031f8f.55.1753805093322; 
 Tue, 29 Jul 2025 09:04:53 -0700 (PDT)
Received: from [172.18.195.54] (ip-185-104-138-124.ptr.icomera.net.
 [185.104.138.124]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b778eba147sm12783742f8f.27.2025.07.29.09.04.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Jul 2025 09:04:52 -0700 (PDT)
Message-ID: <96e236f9-32c9-42f5-8483-03814230bd32@linaro.org>
Date: Tue, 29 Jul 2025 18:04:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: Add pixel3_defconfig for Pixel 3 / 3 XL
To: David Heidelberg <david@ixit.cz>, Tom Rini <trini@konsulko.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.denx.de
References: <20250729103950.1154040-2-david@ixit.cz>
 <ea359f49-2961-430f-8abf-a6e3e4650791@linaro.org>
 <a8b5d85e-1cd1-4281-b799-310e15a4c8a3@ixit.cz>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <a8b5d85e-1cd1-4281-b799-310e15a4c8a3@ixit.cz>
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



On 7/29/25 17:59, David Heidelberg wrote:
> Hello Casey.
> 
> On 29/07/2025 13:52, Casey Connolly wrote:
>> Hi David,
>>
>> Thanks for the patch! Great to see more devices up and running :D
>>
>> On 7/29/25 12:39, David Heidelberg wrote:
>>> Introduce a defconfig for the Pixel 3 and Pixel 3 XL.
>>>
>>> On these devices, U-Boot must be chainloaded via Fastboot. However, 
>>> due to
>>> a Fastboot bug, U-Boot won’t start unless a specific condition is met.
>>>
>>> To work around this, U-Boot must provide a TEXT_OFFSET of 0x00080000,
>>> which allows Fastboot to successfully launch U-Boot.
>>
>> tbh I think we could just make this the default TEXT_BASE, since we 
>> don't set one in qcom_defconfig. I don't think(?) that would mess up 
>> anything else since U-Boot is relocatable anyways.
>>
>> Neil: any thoughts there?
>>
>>>
>>> Clearing the framebuffer improves the Pixel 3 experience,
>>> as it prevents collisions with the Fastboot logo left on the display.
>>
>> Does framebuffer actually work on the 3 (non-XL)? This reminds me that 
>> we should turn off dcache flush for simplefb heh
> 
> I can't confirm for Pixel 3 (at least until I meet with Petr Hodina and 
> test), but generally after defining the FB node in dts, it *should*.

I was never able to get simplefb working in Linux, nor did it work when 
i tried U-Boot on blueline, I think panel self-refresh is disabled there 
for some reason :/

> 
>>
>>>
>>> Instead of:
>>> $ make CROSS_COMPILE=aarch64-linux-gnu- O=.output qcom_defconfig 
>>> qcom- phone.config
>>> do
>>> $ make CROSS_COMPILE=aarch64-linux-gnu- O=.output pixel3_defconfig 
>>> qcom-phone.config
>>>
>>> Cc: Neil Armstrong <neil.armstrong@linaro.org>
>>> Cc: Casey Connolly <casey.connolly@linaro.org>
>>> Signed-off-by: David Heidelberg <david@ixit.cz>
>>> ---
>>>   configs/pixel3_defconfig | 13 +++++++++++++
>>>   1 file changed, 13 insertions(+)
>>>   create mode 100644 configs/pixel3_defconfig
>>
>> I think this makes more sense as a config fragment than a standalone 
>> defconfig, since it's just changing a few core options that don't have 
>> any other effects
>>
>> $ make qcom_defconfig google-blueline.config qcom-phone.config
>>
>> What do you think? Otherwise it should be renamed to 
>> qcom_google_blueline_defconfig or something like that.
> 
> I have nothing against config fragment, but the blueline and crosshatch 
> are HW wise almost identical differentiating in peripherals, so this 
> configuration should be common for both of them.
right, it can be called blueline and still used for both.

I forgot to ask, please also add a new file in doc/board/qualcomm to 
describe the Pixel 3, it should just explain the need for the 
fragment/custom defconfig and then :ref: to the generic board.rst 
documentation.

Another todo of mine is to introduce a hardware support table like 
amlogic have to document all the boards.

> 
>>
>>>
>>> diff --git a/configs/pixel3_defconfig b/configs/pixel3_defconfig
>>> new file mode 100644
>>> index 00000000000..9c0c8ca63c4
>>> --- /dev/null
>>> +++ b/configs/pixel3_defconfig
>>> @@ -0,0 +1,13 @@
>>> +# Pixel 3 has special requirement to have TEXT_BASE set for the 
>>> fastboot.
>>> +
>>> +#include "qcom_defconfig"
>>> +
>>> +# Otherwise buildman thinks this isn't an ARM platform
>>> +CONFIG_ARM=y
>>> +
>>> +# some Pixel 3 bootloaders aren't able to start without TEXT_BASE
>>> +CONFIG_TEXT_BASE=0x80080000
>>> +CONFIG_HAVE_SYS_UBOOT_START=y
>>
>> Can you explain the purpose of HAVE_SYS_UBOOT_START here? It just 
>> allows for SYS_UBOOT_START which afaict isn't used?
> 
> I re-did the testing and this option is not needed, so I'm happy to drop 
> it in next revision.

Great

> 
>>
>>> +
>>> +# fastboot logo distorts u-boot output
>>> +# CONFIG_NO_FB_CLEAR is not set
>>
>> I'd like to add this to qcom_defconfig, I was holding off until I 
>> could add an option to prevent simplefb from doing dcache flash on 
>> qcom which makes display refreshes actually fast... Would you be 
>> interested in adding a config option for that?
> 
> If you can insert this option into the qcom_defconfig, that would likely 
> make sense.

My plan is to add that after adding an option to disable dcache flush, 
since otherwise it introduces a huge delay to booting for no real reason 
on most devices.

Kind regards,
// Casey(she/her)

> 
> 
> Thank you for the review,
> David
> 
>>
>> Kind regards,// Casey (she/her)
> 

