Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98CACC71135
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 07:42:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0A4880C93;
	Mon, 16 Jun 2025 09:42:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pmmZmsqy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8835381E18; Mon, 16 Jun 2025 09:42:05 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 803528007D
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 09:42:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3a4e742dc97so3380606f8f.0
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 00:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750059723; x=1750664523; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ERG2LW6OLPxoGiVcfMGKZ0eJLwFFeSXI9FMFnAjqazU=;
 b=pmmZmsqyuVVGIeIcOK6f8EhDC0n5j3qkrRKavEiV/HnWKzeeEOtDU1Ig6xy6PuEmxC
 wk3+bB64C8i2Q7vK1tldD4B3/x0fp/dY6LJiuoxrhpm+AGY7VWxSUBMwp5KzhSelG8B8
 kG2z+HELRe84ABMvYOVeflt3B/rXVxXcPVYp4OEaQEdV820O++7EABqIbm+SP10KqkD9
 m+zCKFyg+c+FDNrHARw3OR+1umaKDA3JzAjQryVgLoXOFigowho9Zsp5V1WcKtWXmw38
 S0xFVbjafNkkfJraGEP6XK7BiVXRSjg9L96mmClZX4j+Ejj4QvlNBO70MpWFbxqD52F2
 03PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750059723; x=1750664523;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ERG2LW6OLPxoGiVcfMGKZ0eJLwFFeSXI9FMFnAjqazU=;
 b=io1QHknC9CLQ0ZGjREM/YorzIxFajrByOk2VUwlflLMBiW4oU0sM/GVaxCtTJVGbBo
 L7bgFoW1xb8iJYAop+Ub6cN2HHcoWCtKTyNbPlzeWAqAw8MCfJ0N+7Zp6ojmGBWgJ1jO
 hPxQmhU0NEMAv/c8ObHUXLklWjtoJVkUTy++Ky/xqYx6R8jmXzvJev7aF0mKTw6I+XuG
 mVydwOKQbl0H7hr+cEmJYrtuS3gRXXQEgvobrwytJvLiyWfXxiOnulAktdjmNItx+6c9
 wJY5L6rQpBULtL61eMS7y++vaspJg6KAjJruz7Ex1Z5muebSVr//4MpubRvFUMiUduPC
 yLAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxdCGkHgymx0SYzKj0lZWrLS6cAUkP1ACZ4pGf2m96+CfLr4lNuZbnoWmArYKIyBEYPGEUeuM=@lists.denx.de
X-Gm-Message-State: AOJu0YzgtRot0jwH6i0TJ90U+lL8jkq+emCW8okgXaQ8upUeF3jF5YKZ
 RhEC/YCpJAJBN391TJekz4snS7Ll3NdKTdsFWL4ZCf6bnFa86iZJHka4D2O2EVIF96w=
X-Gm-Gg: ASbGncs3qlkjnQdZomlMBz+TEeu3Z1VbMc3DPvhzGQ1ICW9xhemZ6IXSZnZrPZOx4+c
 8x2L7mNICq28Tk5PVlKQSI3HULD+xH5miVIYGtYsTWvaR+3+PfFvmGOb6dK6d/io0SCrKYPrQjS
 6LteiDt1tUQ4b3f0zv89F0+nw+2Vxhl9cL3iuf6REQc+I5loeztzRRFLb5Cq1V8j+ib572UBwgs
 BDl0Lm6ZCr1qqSTRYHlUcMRrhx1086mjqr/WvXX5TFzusLqfznbwp4NLjrerJS981htKFFZ17kz
 re48FrB3Wh7ngvHaeXD76JucLLvUvG5FcdPMtJvc6sLSBGHmHbQ7aKKNo3ejp3cFFle85YPjTwv
 7p5HDvqAXR6WAawdapk6TsxoTmDnfjxiyPXDGV/g=
X-Google-Smtp-Source: AGHT+IHWqdULL0Maoh9DOGMevPLTfxsDBthiSV0+DOjfYQ0KVFSyPB1BUriC6ZJmy61xHpV7vF9W8g==
X-Received: by 2002:a05:6000:2207:b0:3a5:1241:afde with SMTP id
 ffacd0b85a97d-3a5723949c0mr7632219f8f.9.1750059722874; 
 Mon, 16 Jun 2025 00:42:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:ed5:5ba4:73c4:b199?
 ([2a01:e0a:3cb:7bb0:ed5:5ba4:73c4:b199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568a54d74sm10421134f8f.10.2025.06.16.00.42.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Jun 2025 00:42:02 -0700 (PDT)
Message-ID: <7cc96ced-c999-4779-b56e-8f7b93104a20@linaro.org>
Date: Mon, 16 Jun 2025 09:42:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] tools: zynqmp: add build script and documentation for
 ZynqMP KV260
To: Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>
Cc: Neal Frager <neal.frager@amd.com>,
 U-Boot mailing list <u-boot@lists.denx.de>
References: <20250612153311.2379944-1-jerome.forissier@linaro.org>
 <20250612164939.GO1382132@bill-the-cat>
 <b806f55f-da5a-4373-a6c2-15b1cab93da3@linaro.org>
 <eefb84b0-f995-446a-b885-8de9e0b2f295@amd.com>
 <20250613143943.GX1382132@bill-the-cat>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250613143943.GX1382132@bill-the-cat>
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



On 6/13/25 16:39, Tom Rini wrote:
> On Fri, Jun 13, 2025 at 09:59:52AM +0200, Michal Simek wrote:
>>
>>
>> On 6/13/25 09:38, Jerome Forissier wrote:
>>>
>>>
>>> On 6/12/25 18:49, Tom Rini wrote:
>>>> On Thu, Jun 12, 2025 at 05:32:41PM +0200, Jerome Forissier wrote:
>>>>
>>>>> Add a script to help build a functional U-Boot binary for the ZynqMP
>>>>> Kria KV260. Also add some documentation.
>>>>>
>>>>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>>>>> ---
>>>>>
>>>>>   doc/board/xilinx/index.rst        |  1 +
>>>>>   doc/board/xilinx/zynqmp-kv260.rst | 27 +++++++++
>>>>>   tools/zynqmp_kv260_build.sh       | 43 ++++++++++++++
>>>>>   tools/zynqmp_pmufw_elf_convert.py | 96 +++++++++++++++++++++++++++++++
>>>>>   4 files changed, 167 insertions(+)
>>>>>   create mode 100644 doc/board/xilinx/zynqmp-kv260.rst
>>>>>   create mode 100755 tools/zynqmp_kv260_build.sh
>>>>>   create mode 100755 tools/zynqmp_pmufw_elf_convert.py
>>>>
>>>> Helper build scripts don't belong in the tools directory. If they're
>>>> super helpful, I don't object to adding them to
>>>> u-boot-extras/contrib/<you>/ directory.
>>>
>>> OK
>>>
>>>> But there's a number of
>>>> documented examples already on checkout and build TF-A then do ... for
>>>> your platform.
>>>
>>> There is doc/board/xilinx/zynqmp.rst which deals with quite few ZynqMP
>>> boards but not the KV260. In addition, it has a number of shortcomings:
>>> - It mentions pmu.bin but does not say where to get if from
>>> - It doesn't say how to build TF-A (bl31.bin), some very specific build
>>> options are needed.
>>> - I consider that detailed build instructions belong in things called
>>> scripts or Makefiles, that were invented long ago exactly for that
>>> purpose :) IMO the documentation should tell the bare minimum and ideally
>>> be unnecessary.
>>>
>>> I am not particularly proud of the fact that I spent more than a whole
>>> day trying to get U-Boot master to boot on my KV260, and without the help
>>> of Michal, no doubt I would still be trying... So, how about I submit the
>>> zynqmp_kv260_build.sh script to the u-boot-extras/contrib/<me>/ directory
>>> and just point to it in doc/board/xilinx/zynqmp.rst?
>>
>> no issue from my side.
> 
> I am also fine with this approach (and you should have access to the
> repository, and I need to go do some admin work to make it easier to add
> all custodians), and once Michal is happy with the script too.
> 
>>
>>
>>>>> diff --git a/tools/zynqmp_pmufw_elf_convert.py b/tools/zynqmp_pmufw_elf_convert.py
>>>>> new file mode 100755
>>>>> index 00000000000..b4eb2695831
>>>>> --- /dev/null
>>>>> +++ b/tools/zynqmp_pmufw_elf_convert.py
>>>>> @@ -0,0 +1,96 @@
>>>>> +#!/usr/bin/env python3
>>>>> +# SPDX-License-Identifier: GPL-2.0+
>>>>> +# Copyright (C) 2025 Linaro Ltd.
>>>>> +#
>>>>> +# Written by Gemini (Google AI) then reviewed and edited to remove some comments
>>>>
>>>> I'm glad this calls out where it's from. I'm not comfortable for a
>>>> number of ethical reasons on taking LLM-generated code. I'm also a
>>>> little surprised we don't already have something like this with binman
>>>> today?
>>>
>>> Nervermind. 'llvm-objcopy -O binary pmufw.elf pmufw.bin' works just
>>> fine :) so I'll use that instead. Note that the binutils objcopy
>>> cannot be used because it is target-specific and the MicroBlaze
>>> version is not so easily available. While LLVM supports many targets
>>> natively.
>>
>> yes/no. Toolchains are wired via buildman already and available at kernel.org.
>> Connection to llvm is adding another dependency.
>>
>> I think putting this script to u-boot-extras is fine. To upstream u-boot
>> could be more problematic because as I mentioned there are some issues with
>> the way you use. You should be able to take bl31.elf from
>> soc-prebuilt-firmware repo too.
>> You can also look what Neal did in buildroot to get it work which is better
>> place for building tfa and putting images together from different locations.
> 
> FWIW, it's things like this as to why I prefer more and better
> documentation in u-boot itself and build scripts in contrib. Everything
> has so many other use cases and then host dependencies that it's a Lot
> OF Work to have something that handles everything. Having seen a number
> of "helper build scripts" that then went very wrong once out in the wild
> over the years is another part of my reasoning.

I have pushed the script to the u-boot-extras repo, as
contrib/jforissier/zynqmp_kv260_build.sh.

Thanks!
-- 
Jerome
