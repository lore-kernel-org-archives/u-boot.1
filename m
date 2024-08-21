Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DF19C52D6F
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 14:49:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FE9188DDF;
	Wed, 21 Aug 2024 16:49:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ngEmNFMT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B682E88363; Wed, 21 Aug 2024 16:49:25 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D01668843A
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 16:49:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a83856c6f51so379920066b.2
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 07:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724251758; x=1724856558; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n4EFSgiyWPJPKzfEbQkDgAQ4aqmFb41u4PxM9y2uWoI=;
 b=ngEmNFMT7D0Ok6uGxTpXrQevuml65dbWs041RAtayuaX4ygEY8yAmzl5eVlIlZFHvb
 GSb+tW8mM6ueqPJEoCLbBQ52xBR5cnX31N47o0uUwWoS69wI4f0hUvlwSn2j3f8Re7Z4
 y0hc4648zSjJq1tG71lmVGrIwvAE/8A/SBQF8xNy21TTNPZa2Nk0JIxb9Yb9S+SArVe8
 bihPOeqUm4Goa1nNkSRfnQR6VaJkUrAQPJQLUVaS5GYRzMQryUdobekgwQe4Q3/MqSog
 7NdDxZFHEKfeZLJpmQIL483Hm9jHoOYJjLZNUmta3nR0ojWHWsnGvseONxLZghQVkxI2
 7LyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724251758; x=1724856558;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n4EFSgiyWPJPKzfEbQkDgAQ4aqmFb41u4PxM9y2uWoI=;
 b=JXy0gBf0UZWZSgLeLXcDFa9EN5lqcK7GAbY3ZM5Qw7oHNRWEqSVsgoxq3XrRK6FohA
 qXWv18DPEdW6bimEOYqHw5mLImvN3mBzVsFlCX0VpG9Eu/oTTm8/CZMf4Rxy8Dcs7+uh
 UV/L6TLjHhi6KH+Lr74AmYX6993spwsbINnxjtLnlLEk/OB/P5sk5+rwevWjRTCFUi8G
 kF1mOPNHMgER9Q8qX4nmVBgNmq6fZBuLCkHWMQA5yszu4i0uWvkhchKLcUXdGkjX7eRZ
 IAdFVqxKlwi2iwSYPSQ0/279+FBQbRdMcfRbveduPUYsVsI/sfBAwlvQo/m5cmwFoYzc
 kinA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYQmRyloxRNSB60Q8WBR4Y7F96DfW8zCIFTpIMppGL9GmwVR1eqIetHgneD1XvlNEQkLWAYt0=@lists.denx.de
X-Gm-Message-State: AOJu0YxinBKShbshvfC8LuJDuj6lx+SrXyDsAHSMietvdgvP1v6er3Yz
 GlqdZ0FUUgzx+IoPD2VTnGzfHUKW6RicdKAGyEsBCHwwtYRy4tkfkV9KQEzRM2s=
X-Google-Smtp-Source: AGHT+IFSEaVRzAX4rjApc3invBJD9vS6S3+KBmcWYoLy6+RtaGnPYA206zJaeafBZex5OCn7ow0q8A==
X-Received: by 2002:a05:6402:5407:b0:5a2:e73f:1528 with SMTP id
 4fb4d7f45d1cf-5bf1f0dab9dmr2137609a12.12.1724251758223; 
 Wed, 21 Aug 2024 07:49:18 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::676e? ([2a02:8109:aa0d:be00::676e])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bebbde3edfsm8115392a12.29.2024.08.21.07.49.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Aug 2024 07:49:17 -0700 (PDT)
Message-ID: <eda3f2ad-d011-4ae6-b722-9114daafeae1@linaro.org>
Date: Wed, 21 Aug 2024 16:49:16 +0200
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
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAFLszTjwjUnGYMdujDUNePBiEU8_oMpkZYpSK8REKxrMYUadpw@mail.gmail.com>
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



On 21/08/2024 16:37, Simon Glass wrote:
> Hi Caleb,
> 
> On Wed, 21 Aug 2024 at 08:11, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>
>> Hi Simon,
>>>> +U_BOOT_DRIVER(gcc_sc7280) = {
>>>> +       .name           = "gcc_sc7280",
>>>> +       .id             = UCLASS_NOP,
>>>> +       .of_match       = gcc_sc7280_of_match,
>>>> +       .bind           = qcom_cc_bind,
>>>> +       .flags          = DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
>>>> +};
>>>
>>> This should use driver model, with a UCLASS_CLK and UCLASS_RESET
>>
>> Please refer to qcom_cc_bind() which binds the clock, reset, and power
>> domain drivers.
> 
> Gosh, why? Are these devices not in the devicetree?

They are, the gcc block contains clock, reset, and pd parts. On Linux 
this is not an issue because a single device can be multiple different 
classes (e..g when you register a reset you do it for a device) whereas 
U-Boot requires a device per class.

e.g. see devm_reset_controller_register() in Linux, it populates a 
struct reset_controller_dev which references the struct device created 
for the node. In U-Boot you have to create a new device which _is_ the 
reset controller.
> 
> Regards,
> Simon

-- 
// Caleb (they/them)
