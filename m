Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D318AE77188
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 14:06:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24FD4800DF;
	Wed,  8 Jan 2025 15:06:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="J5PR3GnS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 444C9803DC; Wed,  8 Jan 2025 15:06:53 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D8618006D
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 15:06:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-aa692211331so182448666b.1
 for <u-boot@lists.denx.de>; Wed, 08 Jan 2025 06:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736345208; x=1736950008; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dAr+i9rX58KK6hiFiBW6cWV2bOSP0pFvSh8MisH2XlQ=;
 b=J5PR3GnSX3CBqJyFfcs86JfHY/S7qCBwfX75phHX4lsCpNj0FAbZdfk2hY85EqcEhN
 JuVLqQILj6085Lk+aZqRYldW/1kAeTclWWeTsNCU0u5tHfXopAZRqNMZyENmjdOEHtoC
 BFRl2h5ghNw2wgQicYR+8I6Kz/0qqxCowDhuapnuxqsdOczT+YuYGMpSmwoJayFvTClO
 DxlwuMf5MQX3LuDaqw5nZh8IvzP0Q7u0Qlx8VK0p4/L2XrO66TZj4+bck5T+eshArAQQ
 4JsAM0IzNUIb7fzSkIAjgKq4BLTLTdMLG7SEnYtMzH7MtG6sA+sixWJEwHFCRNks2ImC
 2xvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736345208; x=1736950008;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dAr+i9rX58KK6hiFiBW6cWV2bOSP0pFvSh8MisH2XlQ=;
 b=n1nwczUhcxxFfcrko+dprrAUrpI8wPzU3uk1kT0I9Ty1PTTX0mJfNGHp+sao+Istam
 erKRH/AEKwdF7YC38QR9UrjW0dfeOIF//fzXSZQmacd9tpM6d6mc4bTMpesM0yHYz5xH
 b7DYgF4apcWGvAhjbYa/Y2ug5Uo4hLUdumQsMzW/3l/36R73pGEk6r3vRGgeqe5J6G1A
 NUMGyxiMy/p19fD72WCx3AzJtS1FoHD9JvI9vEjvrYKqoFjkxrpEZ6v6a+ied6JvrFAW
 MI4jWE9jJwRby2Pp7XLOsVFfkl7OR7iVuSSCwK4uuwhktjfepiP1p37lvTDUXQD09aiS
 KZig==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHZ9SQGwKYVvNW2izQyvOu7hXW/I0o50JomQN4YpekU+UTrZs/tcoHl7R1jxto/zYAjhsTjbA=@lists.denx.de
X-Gm-Message-State: AOJu0YyMN6vNq67VbfLuBUkgq/Hl/gTHJrY3hQF2XNlD9ORZUDod/Biq
 JwefWfiIu6pILpw/cCkiQSoprFoxlJKCH4alPZEshJsqiPYycALBNDbGUxPK5zE=
X-Gm-Gg: ASbGncu3Us6w1+xg6TaZPcFr20QUnThZML77O91OdZrqzW5hAIwfOQyW2ygq0f1v1Fb
 88+epu5C7yQgDZdwrj1uhmxPM0liNtG0k6280n82ib/Wx1vbkz/TuhJ5Xo6ers1ouYtc7oylyJi
 965KWeEEcGzkJhjWl1kYmSARwsQdgkkq3Nmt+uzSNHkgtFq41PSY9u8+/Fj0hdgw1kUv36uu75c
 QX1B71C0dewZio0GNlpP6T6GbgJPP6XRT0nbLbSeNQF/YrUEaPShVH6QpV6DYO2kvsAwzm8hzmN
 Eek/yivQkUUk1o9VIF2NTOpylt2aAKZLhkpbdVs=
X-Google-Smtp-Source: AGHT+IG1/l3fgm/05SMj2uR0GdzWQxFC/BN8/0AnWumQcf6LKsELFWj9xKQTlSNNgQ4x4/SQ11zZjQ==
X-Received: by 2002:a17:906:794d:b0:aae:83c7:fd50 with SMTP id
 a640c23a62f3a-ab2a79f1e11mr265961966b.9.1736345208494; 
 Wed, 08 Jan 2025 06:06:48 -0800 (PST)
Received: from ?IPV6:2a02:8109:888d:ff00:ca7f:54ff:fe52:4519?
 ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0f014decsm2512153566b.149.2025.01.08.06.06.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2025 06:06:47 -0800 (PST)
Message-ID: <a56b87c0-0e70-4e0b-aeb7-9f10b2c7c6d0@linaro.org>
Date: Wed, 8 Jan 2025 15:06:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/5] dts: sa8775p-ride-r3-u-boot: add override dtsi
Content-Language: en-US
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: neil.armstrong@linaro.org, trini@konsulko.com, sumit.garg@linaro.org,
 lukma@denx.de, seanga2@gmail.com, ilias.apalodimas@linaro.org,
 sjg@chromium.org, Volodymyr_Babchuk@epam.com, lehmanju@devpi.de,
 bhupesh.linux@gmail.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250103051404.1965469-1-quic_varada@quicinc.com>
 <20250103051404.1965469-2-quic_varada@quicinc.com>
 <1ae282b0-8e68-4360-b3d2-73a10b7b8f37@linaro.org>
 <Z3zyuZZ0TA47KXpZ@hu-varada-blr.qualcomm.com>
 <909dc9b6-fb70-45c7-83f2-74c89b5049a5@linaro.org>
 <Z34RRETdZn8rDhYe@hu-varada-blr.qualcomm.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <Z34RRETdZn8rDhYe@hu-varada-blr.qualcomm.com>
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



On 08/01/2025 06:46, Varadarajan Narayanan wrote:
> On Tue, Jan 07, 2025 at 12:36:23PM +0100, Caleb Connolly wrote:
>>
>>
>> On 07/01/2025 10:24, Varadarajan Narayanan wrote:
>>> On Fri, Jan 03, 2025 at 04:17:14PM +0100, neil.armstrong@linaro.org wrote:
>>>> On 03/01/2025 06:14, Varadarajan Narayanan wrote:
>>>>> Add initial support for the QCS9100 (derived from SA8775p) Ride platforms.
>>>>> Define memory layout statically.
>>>>>
>>>>> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>>>>> ---
>>>>>   arch/arm/dts/sa8775p-ride-r3-u-boot.dtsi | 22 ++++++++++++++++++++++
>>>>>   arch/arm/dts/sa8775p-ride-u-boot.dtsi    | 11 +++++++++++
>>>>>   2 files changed, 33 insertions(+)
>>>>>   create mode 100644 arch/arm/dts/sa8775p-ride-r3-u-boot.dtsi
>>>>>   create mode 100644 arch/arm/dts/sa8775p-ride-u-boot.dtsi
>>>>>
>>>>> diff --git a/arch/arm/dts/sa8775p-ride-r3-u-boot.dtsi b/arch/arm/dts/sa8775p-ride-r3-u-boot.dtsi
>>>>> new file mode 100644
>>>>> index 0000000000..7d01d5f6a1
>>>>> --- /dev/null
>>>>> +++ b/arch/arm/dts/sa8775p-ride-r3-u-boot.dtsi
>>>>> @@ -0,0 +1,22 @@
>>>>> +// SPDX-License-Identifier: BSD-3-Clause
>>>>> +/*
>>>>> + * Copyright (c) 2025, Qualcomm Innovation Center, Inc. All rights reserved.
>>>>> + */
>>>>> +
>>>>> +/ {
>>>>> +	model = "Qualcomm QCS9100 Ride Rev3";
>>>>> +	compatible = "qcom,qcs9100-ride-r3", "qcom,qcs9100", "qcom,sa8775p";
>>>>
>>>> Why do you redefine those ? they are already defined in the upstream sa8775p-ride-r3.dts
>>>
>>> To include QCS9100 info to the model and compatible strings,
>>> so that users might not get confused if a wrong U-Boot has
>>> booted on the platform.
>>
>> They are already defined in dts/upstream/src/arm64/qcom/sa8775p-ride-r3.dts
>>
>> That file is patched at build time to include this dtsi file at the end.
> 
> [1] defines it as "Qualcomm SA8775P Ride Rev3". We want to define
> as "Qualcomm QCS9100 Ride Rev3", i.e. s/SA8775P/QCS9100/. That is
> why having it here. This would not be needed once [2] gets into
> U-Boot.

hmm I see, well that's a pickle. I don't think we have a process yet for
handling these cases where we're blocked on a DTS sync.

I would rather avoid creating this weird situation where we use the
sa8775p dts and pretend it's a different board especially if it's only
temporary until the proper dts lands.

Some proposals:

1. remove the model/compatible properties assuming the sa8775p-ride-r3
board using the same memory map, add another u-boot dtsi for
qcs9100-ride-r3 once it's merged in
2. import qcs9100-ride-r3.dts into arch/arm/dts in u-boot as part of
this series (but need to remember to remove it later!)
3. somehow cherry-pick the relevant patch into the subtree early or ask
Tom to sync the DT subtree
4. wait for the next sync which hopefully won't be too long(?)

I'd be ok with 1 or maybe 2 for this specific case, I'll see if 3/4 are
viable for the future.

Feel free to pick one of those approaches and respin if that works for you.

Kind regards,
> 
> 1. https://source.denx.de/u-boot/u-boot/-/blob/master/dts/upstream/src/arm64/qcom/sa8775p-ride-r3.dts
> 2. https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/qcom/qcs9100-ride-r3.dts
> 
> Thanks
> Varada
> 
>>> Please let me know if this should still be removed.
>>>
>>> Thanks
>>> Varada
>>>
>>>>> +
>>>>> +	/* Will be removed when bootloader updates later */
>>>>> +	memory@80000000 {
>>>>> +		device_type = "memory";
>>>>> +		reg = <0x0 0x80000000 0x0 0x3ee00000>,
>>>>> +		      <0x0 0xc0000000 0x0 0x04d00000>,
>>>>> +		      <0xD 0x00000000 0x2 0x54100000>,
>>>>> +		      <0xA 0x80000000 0x1 0x52d00000>,
>>>>> +		      <0x9 0x00000000 0x1 0x80000000>,
>>>>> +		      <0x1 0x00000000 0x2 0xf7500000>,
>>>>> +		      <0x0 0xd0000000 0x0 0x00100000>,
>>>>> +		      <0x0 0xd3500000 0x0 0x07c00000>;
>>>>> +	};
>>>>
>>>> Ack, this should be removed once the SMEM code is merged.
>>>>
>>>>> +};
>>>>> diff --git a/arch/arm/dts/sa8775p-ride-u-boot.dtsi b/arch/arm/dts/sa8775p-ride-u-boot.dtsi
>>>>> new file mode 100644
>>>>> index 0000000000..979462dfec
>>>>> --- /dev/null
>>>>> +++ b/arch/arm/dts/sa8775p-ride-u-boot.dtsi
>>>>> @@ -0,0 +1,11 @@
>>>>> +// SPDX-License-Identifier: BSD-3-Clause
>>>>> +/*
>>>>> + * Copyright (c) 2025, Qualcomm Innovation Center, Inc. All rights reserved.
>>>>> + */
>>>>> +/dts-v1/;
>>>>> +
>>>>> +#include "sa8775p-ride.dts"
>>>>
>>>> Why ? this file will be automatically appended to sa8775p-ride.dts, no need to import is before.
>>>>
>>>>> +/ {
>>>>> +	model = "Qualcomm QCS9100 Ride";
>>>>> +	compatible = "qcom,qcs9100-ride", "qcom,qcs9100", "qcom,sa8775p";
>>>>
>>>> Same, unneeded.
>>>>
>>>> In fact, this file is completely unneeded.
>>>>
>>>>> +};
>>>>
>>>> Neil
>>>>
>>
>> --
>> // Caleb (they/them)
>>

-- 
// Caleb (they/them)

