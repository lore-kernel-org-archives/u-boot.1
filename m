Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DCF1C52D6F
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 16:47:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0589788B5D;
	Wed, 21 Aug 2024 18:47:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="d0AiDvrz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB98688E0F; Wed, 21 Aug 2024 18:47:32 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 860B488B5D
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 18:47:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-58ef19aa69dso6923953a12.3
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 09:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724258850; x=1724863650; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tob89hLnRWXdpxZ0uJ1aVU0dtDcDQ0vsaL+BENTid5I=;
 b=d0AiDvrzd/F4erU+852jEpf9wCijcEek5O1/Vxnkn3AAV3pbn7eEZdvWGmX7I1dCUm
 bu1ihfQg7O7xvGP0gmRaixb+zHWKFkWAsZGzCIi12W8Fcx3HI3QkhVArkB7zb4o6ioo+
 fNZvQoPi47mPq2gg970YTKEY1DpGcKFBs3gBwhlO6vB+QtERk0pQTDRzyaV0lay5nTrj
 8OubVdiQVOoWr4luiCvu5DUrKjeRHeMNyKGyQ8v6bn/nZDNX+9Z81gYcm9AbmU91PeDs
 pqQPIUUogr3R5/ReG3BD+x7Lw5QhCveHswoYj6cqpcI2+V8oETF0ry1KZQ1ToqkYyB0q
 8OFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724258850; x=1724863650;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tob89hLnRWXdpxZ0uJ1aVU0dtDcDQ0vsaL+BENTid5I=;
 b=gY1ecDtNAdk2k8Jf4acFrddsYiGGrY8Nh+/kufzNoWOaH9SGtC3g9G6m+hntlHz+zN
 BigVObmFHiLLucg5d4VZaBGLwY3ZDRgJigJOSHTEtcoUyTGcuyvhRjZ0S5aLLgt1oLTY
 pLCXUXZ5aZghnFrSRmeOJJeiT4Vt1qGtG+kJozRQr8T5V7LsIQRk5IH3N3q0bBEtj6zg
 rUZiuEw9kNfoAEtOmBjgr7ph4MoX1/P8qiI1VzG2sFIFNRTmb/bdW+NX+fZDA0sRYK7a
 ajYUk/I9ckQY+35ivxe57/oYeTZU/H7D32Blb+5bPtLqWn4KmRjA1rkQ1NFVmA4XsSKj
 Nviw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0Im8x5l72nJ6egdnQV6KmhnXcKRLEavUL1r2rULnIBaRa4LXjNqmPs7ZChxqeMTy9WNCeVJU=@lists.denx.de
X-Gm-Message-State: AOJu0YxsLMG+hnloiBHX/L1syQIHKdsAamVIo0jm5eixEPbOtNJh9eZ3
 yE6XoP4FdJVqyhjtIM2ETk0CUr7jn+aeIGgpitlWCitGiuxkdrWhgE843eFFE5w=
X-Google-Smtp-Source: AGHT+IHJI8plLWv8h6vg+wldHkiR8+3rUZKAKHpp0UnZAHTLB0AxakNjAFpTdFSTHE8k7hgpOx3dgA==
X-Received: by 2002:a05:6402:d07:b0:5be:c955:586 with SMTP id
 4fb4d7f45d1cf-5bf1f26936fmr1836843a12.35.1724258849630; 
 Wed, 21 Aug 2024 09:47:29 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::676e? ([2a02:8109:aa0d:be00::676e])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bef1261249sm4492777a12.6.2024.08.21.09.47.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Aug 2024 09:47:29 -0700 (PDT)
Message-ID: <c03c84a4-660a-4f20-8da4-e29d613600ac@linaro.org>
Date: Wed, 21 Aug 2024 18:47:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] clk/qcom: add initial clock driver for sc7280
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20240821-b4-rb3gen2-v2-0-49b07633f3a8@linaro.org>
 <20240821-b4-rb3gen2-v2-1-49b07633f3a8@linaro.org>
 <CAFLszTjjS8m2DsNp0nMEknM0ggu4QEET81iSyYFGDYWCwVjf2w@mail.gmail.com>
 <2a45562f-792f-4ad5-9871-bef82ccd2d18@linaro.org>
 <CAFLszTjwjUnGYMdujDUNePBiEU8_oMpkZYpSK8REKxrMYUadpw@mail.gmail.com>
 <eda3f2ad-d011-4ae6-b722-9114daafeae1@linaro.org>
 <CAFLszTidT+=wySmu1uo2auxnsbdvm0Qkav-vwu-3vbU9iuEhhA@mail.gmail.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAFLszTidT+=wySmu1uo2auxnsbdvm0Qkav-vwu-3vbU9iuEhhA@mail.gmail.com>
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



On 21/08/2024 18:16, Simon Glass wrote:
> Hi Caleb,
> 
> On Wed, 21 Aug 2024 at 08:49, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>
>>
>>
>> On 21/08/2024 16:37, Simon Glass wrote:
>>> Hi Caleb,
>>>
>>> On Wed, 21 Aug 2024 at 08:11, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>>>
>>>> Hi Simon,
>>>>>> +U_BOOT_DRIVER(gcc_sc7280) = {
>>>>>> +       .name           = "gcc_sc7280",
>>>>>> +       .id             = UCLASS_NOP,
>>>>>> +       .of_match       = gcc_sc7280_of_match,
>>>>>> +       .bind           = qcom_cc_bind,
>>>>>> +       .flags          = DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
>>>>>> +};
>>>>>
>>>>> This should use driver model, with a UCLASS_CLK and UCLASS_RESET
>>>>
>>>> Please refer to qcom_cc_bind() which binds the clock, reset, and power
>>>> domain drivers.
>>>
>>> Gosh, why? Are these devices not in the devicetree?
>>
>> They are, the gcc block contains clock, reset, and pd parts. On Linux
>> this is not an issue because a single device can be multiple different
>> classes (e..g when you register a reset you do it for a device) whereas
>> U-Boot requires a device per class.
>>
>> e.g. see devm_reset_controller_register() in Linux, it populates a
>> struct reset_controller_dev which references the struct device created
>> for the node. In U-Boot you have to create a new device which _is_ the
>> reset controller.
> 
> OK, I see. Rockchip has a CRU (Clock & Reset Unit) which uses syscon
> to access registers. The clock driver 'owns' the node in U-Boot and it
> manually binds a reset driver. It isn't great, either.
> 
> Looking at drivers/clk/qcom/clock-sdm845.c (for example), I can't
> actually find "qcom,gcc-sdm845" (for example) in U-Boot, except as a
> binding. Can you please point me to the node?

It's in dts/upstream/src/arm64/qcom/sdm845.dtsi

> 
> Re devm_reset_controller_register(), yes the U-Boot driver model is a
> lot more regular, e.g. we don't really want drivers creating their own
> struct udevice. We want all devices to be created automatically by the
> devicetree and most memory allocations to be done automatically. This
> helps to reduce code size and execution time. You probably know all
> this :-)

Yeah, U-Boot's model is simpler for most cases. This makes sense. But it 
doesn't reflect the reality of DT so well in cases like this.
> 
> To a significant degree, the devicetree bindings are created without
> much thought to efficient operation in U-Boot. I hope that eventually
> this might change.

I strongly disagree with this mental model. This is the approach I see 
vendors take in their BSP sources and the result is not pleasant.

DT should (within reason) never be written with the OS in mind. It is an 
agnostic structure to describe the hardware. I think the new power 
sequencing subsystem in Linux does a good job at embodying how we should 
approach consuming DT.

> 
> Anyway, with the devicetree we have, I wonder how we could do this better?
> 
> Some ideas:
> 
> 1. Allow DM to bind multiple devices to each devicetree node, perhaps
> as a Kconfig option (to avoid time penalty for all boards), or by
> requiring a new DM_FLAG_MULTI_NODE flag. The devices would then be
> independent, with no common parent device

This would make sharing match data hard, and likely cause issues with 
generic compatible strings.
> 
> 2. As 1 but have DM create a parent 'UCLASS_MULTI' device
> automatically. I am thinking that we should have a new uclass for
> these things, or rename the NOP uclass. This option would allow easy
> access to the parent device, if needed.

This is the current approach, we just bind the clk/reset/pd drivers 
explicitly, allowing us to create and share common data. I don't believe 
there is a sensible way to do this generically.
> 
> 3. Implement devices which are in more than one uclass. There would
> still be a primary uclass, but others can be added too. This would
> involve declaring a list of secondary uclasses in the U_BOOT_DRIVER()
> macro. We would then have a struct dmtag_node for each secondary
> uclass, containing the ID and the uclass pointer. Certain functions
> would need to be updated to support this, and again it could be behind
> a Kconfig.

Many device classes in U-Boot rely on going from a struct udevice to 
some uclass specific data or ops. I have always found this to be a bit 
odd, though simpler to deal with than Linux.
> 
> What do you think?

I think if we're to try and solve this at all, the Linux model is by far 
the most sensible. It is already tried and tested, and would have the 
huge bonus of simplifying driver porting.

barebox went with this approach and it seems to have worked out quite 
well for them.

All that being said, while it's taken me some time to get my head around 
"the U-Boot way", I think there is still value in the simplicity of 
U-Boot's approach. I also think the solution we've ended up with (after 
many iterations I might add) in clock-qcom is clean, simple, and easy to 
understand; though I do agree that U-Boot's DM is definitely hitting the 
limit of what complexity it can handle.

I would honestly be much more interested in seeing early init get 
cleaned up, OF_LIVE becoming the default, and the ofnode abstraction 
going away.

Kind regards,
> 
> Regards,
> Simon

-- 
// Caleb (they/them)
