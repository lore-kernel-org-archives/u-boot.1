Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E23EE77188
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 14:29:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A66B805E9;
	Wed,  8 Jan 2025 15:29:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NMGLggDo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 564EC80600; Wed,  8 Jan 2025 15:29:47 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADE958036B
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 15:29:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-aaf900cc7fbso1128662066b.3
 for <u-boot@lists.denx.de>; Wed, 08 Jan 2025 06:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736346584; x=1736951384; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O/aeZLQdDsFjEYvJAgnVWYJSFuRhtrwuSGyp5F+OLuc=;
 b=NMGLggDoObYfcKqCAFxIj6BNvz4Jl3PUAbuxKik3i1TuxocSFepNzgDvwDHdGKTlvq
 5vPpajeG5uCvwBisQqcltKViqVKj5IgYLAkdrFmsSJBcuKJxcsedxexp1dd+9gCCtrKX
 YXVIfAng5/IL68f51iDONpPZA50kIPJ0npsQ4p0PKs3XFCkzOlKr3yLFN4FehSo8bazY
 +9icTkzVNHu4+Foar6RUp7KKCJU00faNrInrY53ly1ywYhdHADZ+Q2GCUNsFRARnRPuR
 XvZ3EIdP2Gao9b3HbC22b0CwxpllFpsrWdQrJyEvsFM6ZZ78mBdGs2dfohaobf0aW69X
 C5uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736346584; x=1736951384;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O/aeZLQdDsFjEYvJAgnVWYJSFuRhtrwuSGyp5F+OLuc=;
 b=aTcl7ECJpYrqZzd2SbNIp8+K3W3LXkQbDDZ6vXMmqOI5qX/KnIeDGnRhr+xAZ9t8ng
 aBo16tGe8clDgq+tQTb9CsFyuC2/c+eAY5mHYkAl02nA+RETsjtzrpedaMV9b58oMrAx
 mgrR1VfNjrVPCDZ60/jGjY1EnlDLEwCy/pnvEoIZfv565kVaXjV+msEHAYjrQRlGXn6d
 dzwu04zkR/RK5ol8NiI8SlTMxGIzYt9E9eOhNawVQ1r7Jg4kgzSmDfkE7UQtEEM6pHi4
 hGvAxH319MGrhbc9XJIVmB2UwJsvbxHFZ8BZaalKrwXcNpispKz9HnaU3fH1oDwMjQgQ
 SHtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbdbY8ux5cFHdCncgIYgV96Bk+Iors2lQNSfUH94asch0+Rd5AxZlOAW9+a4+ifYTQmLr/z9s=@lists.denx.de
X-Gm-Message-State: AOJu0YyWzX2sAl4m9MwPELSKQJ04yWZw2090QgGVoQxwbqNkuGFlyBnn
 URW7+2JSatPJH/F+kzn7iF7WyWIkgKuHH1z2a69HuQpOvpoxV3t57ULpu9OcyRE=
X-Gm-Gg: ASbGncuaRUE+JV8/npV3xFe91Mjg18qEd13Fxqn0G/vm/e9pLE7bb5KjO/sbnqPaVHO
 Ea7cmaA7358jO6qmpMJ5b2ymikAZOI/VGHU7QC8BCeJYYMzDqGquwUSRXAlTm2+VIEDCUUSBEcg
 n1NK21nYkdE5ii4qzud/lNHaL1fIISFc0E5P+ZAzYSOvm5yonsOHHb+a6GxlTQyYPWQRDLQ46W9
 k35d8qvUA+3RhfeO/Ex+smRt+okbtlBTTQ4+rTod1izin8bPYO9yfLSO6QZelgbdJCYVEhUxVKo
 /tvHpzw5my3SAfk7LBXIcSM37JELasNK25lq/oE=
X-Google-Smtp-Source: AGHT+IFj4NIZ4KaISb37WpKAw/gJbRK5H7T1kdWEEJj6+2Y5H2coXwt0dRv7nWV2nV5nB7fhiiGcBg==
X-Received: by 2002:a17:906:ef0e:b0:aa6:3f93:fb99 with SMTP id
 a640c23a62f3a-ab2ab74ba27mr268422666b.36.1736346584034; 
 Wed, 08 Jan 2025 06:29:44 -0800 (PST)
Received: from ?IPV6:2a02:8109:888d:ff00:ca7f:54ff:fe52:4519?
 ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0efe494dsm2527878766b.101.2025.01.08.06.29.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2025 06:29:43 -0800 (PST)
Message-ID: <bf8b7d1a-8c0e-4d02-892f-09776d270cf7@linaro.org>
Date: Wed, 8 Jan 2025 15:29:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/5] dts: sa8775p-ride-r3-u-boot: add override dtsi
Content-Language: en-US
To: u-boot-qcom@groups.io, Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: neil.armstrong@linaro.org, trini@konsulko.com, lukma@denx.de,
 seanga2@gmail.com, ilias.apalodimas@linaro.org, sjg@chromium.org,
 Volodymyr_Babchuk@epam.com, lehmanju@devpi.de, bhupesh.linux@gmail.com,
 u-boot@lists.denx.de
References: <20250103051404.1965469-1-quic_varada@quicinc.com>
 <20250103051404.1965469-2-quic_varada@quicinc.com>
 <1ae282b0-8e68-4360-b3d2-73a10b7b8f37@linaro.org>
 <Z3zyuZZ0TA47KXpZ@hu-varada-blr.qualcomm.com>
 <909dc9b6-fb70-45c7-83f2-74c89b5049a5@linaro.org>
 <Z34RRETdZn8rDhYe@hu-varada-blr.qualcomm.com>
 <a56b87c0-0e70-4e0b-aeb7-9f10b2c7c6d0@linaro.org>
 <CAFA6WYPkOTb_tM86AEbUyJ4LJxu=9_f2ZQe3rQzZmy8K6uBbvg@mail.gmail.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAFA6WYPkOTb_tM86AEbUyJ4LJxu=9_f2ZQe3rQzZmy8K6uBbvg@mail.gmail.com>
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



On 08/01/2025 15:20, Sumit Garg via groups.io wrote:
> On Wed, 8 Jan 2025 at 19:36, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>
>>
>>
>> On 08/01/2025 06:46, Varadarajan Narayanan wrote:
>>> On Tue, Jan 07, 2025 at 12:36:23PM +0100, Caleb Connolly wrote:
>>>>
>>>>
>>>> On 07/01/2025 10:24, Varadarajan Narayanan wrote:
>>>>> On Fri, Jan 03, 2025 at 04:17:14PM +0100, neil.armstrong@linaro.org wrote:
>>>>>> On 03/01/2025 06:14, Varadarajan Narayanan wrote:
>>>>>>> Add initial support for the QCS9100 (derived from SA8775p) Ride platforms.
>>>>>>> Define memory layout statically.
>>>>>>>
>>>>>>> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>>>>>>> ---
>>>>>>>   arch/arm/dts/sa8775p-ride-r3-u-boot.dtsi | 22 ++++++++++++++++++++++
>>>>>>>   arch/arm/dts/sa8775p-ride-u-boot.dtsi    | 11 +++++++++++
>>>>>>>   2 files changed, 33 insertions(+)
>>>>>>>   create mode 100644 arch/arm/dts/sa8775p-ride-r3-u-boot.dtsi
>>>>>>>   create mode 100644 arch/arm/dts/sa8775p-ride-u-boot.dtsi
>>>>>>>
>>>>>>> diff --git a/arch/arm/dts/sa8775p-ride-r3-u-boot.dtsi b/arch/arm/dts/sa8775p-ride-r3-u-boot.dtsi
>>>>>>> new file mode 100644
>>>>>>> index 0000000000..7d01d5f6a1
>>>>>>> --- /dev/null
>>>>>>> +++ b/arch/arm/dts/sa8775p-ride-r3-u-boot.dtsi
>>>>>>> @@ -0,0 +1,22 @@
>>>>>>> +// SPDX-License-Identifier: BSD-3-Clause
>>>>>>> +/*
>>>>>>> + * Copyright (c) 2025, Qualcomm Innovation Center, Inc. All rights reserved.
>>>>>>> + */
>>>>>>> +
>>>>>>> +/ {
>>>>>>> + model = "Qualcomm QCS9100 Ride Rev3";
>>>>>>> + compatible = "qcom,qcs9100-ride-r3", "qcom,qcs9100", "qcom,sa8775p";
>>>>>>
>>>>>> Why do you redefine those ? they are already defined in the upstream sa8775p-ride-r3.dts
>>>>>
>>>>> To include QCS9100 info to the model and compatible strings,
>>>>> so that users might not get confused if a wrong U-Boot has
>>>>> booted on the platform.
>>>>
>>>> They are already defined in dts/upstream/src/arm64/qcom/sa8775p-ride-r3.dts
>>>>
>>>> That file is patched at build time to include this dtsi file at the end.
>>>
>>> [1] defines it as "Qualcomm SA8775P Ride Rev3". We want to define
>>> as "Qualcomm QCS9100 Ride Rev3", i.e. s/SA8775P/QCS9100/. That is
>>> why having it here. This would not be needed once [2] gets into
>>> U-Boot.
>>
>> hmm I see, well that's a pickle. I don't think we have a process yet for
>> handling these cases where we're blocked on a DTS sync.
>>
>> I would rather avoid creating this weird situation where we use the
>> sa8775p dts and pretend it's a different board especially if it's only
>> temporary until the proper dts lands.
>>
>> Some proposals:
>>
>> 1. remove the model/compatible properties assuming the sa8775p-ride-r3
>> board using the same memory map, add another u-boot dtsi for
>> qcs9100-ride-r3 once it's merged in
>> 2. import qcs9100-ride-r3.dts into arch/arm/dts in u-boot as part of
>> this series (but need to remember to remove it later!)
> 
>> 3. somehow cherry-pick the relevant patch into the subtree early
> 
> This is the preferred approach, following should create a cherry-pick
> patch for this platform on top of next branch:
> 
> $ ./tools/update-subtree.sh pick dts db6231faa8ef46e5ff5d5ece0c930a07c6358562
> 
> Then you should rather include that cherry picked patch in this
> patch-set instead. The next DT sync will take care of it
> automatically.

ah that's perfect, thanks Sumit. Then this is the right way to go.

Kind regards,
> 
> -Sumit
> 
>> or ask
>> Tom to sync the DT subtree
>> 4. wait for the next sync which hopefully won't be too long(?)
>>
>> I'd be ok with 1 or maybe 2 for this specific case, I'll see if 3/4 are
>> viable for the future.
>>
>> Feel free to pick one of those approaches and respin if that works for you.
>>
>> Kind regards,
>>>
>>> 1. https://source.denx.de/u-boot/u-boot/-/blob/master/dts/upstream/src/arm64/qcom/sa8775p-ride-r3.dts
>>> 2. https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/qcom/qcs9100-ride-r3.dts
>>>
>>> Thanks
>>> Varada
>>>
>>>>> Please let me know if this should still be removed.
>>>>>
>>>>> Thanks
>>>>> Varada
>>>>>
>>>>>>> +
>>>>>>> + /* Will be removed when bootloader updates later */
>>>>>>> + memory@80000000 {
>>>>>>> +         device_type = "memory";
>>>>>>> +         reg = <0x0 0x80000000 0x0 0x3ee00000>,
>>>>>>> +               <0x0 0xc0000000 0x0 0x04d00000>,
>>>>>>> +               <0xD 0x00000000 0x2 0x54100000>,
>>>>>>> +               <0xA 0x80000000 0x1 0x52d00000>,
>>>>>>> +               <0x9 0x00000000 0x1 0x80000000>,
>>>>>>> +               <0x1 0x00000000 0x2 0xf7500000>,
>>>>>>> +               <0x0 0xd0000000 0x0 0x00100000>,
>>>>>>> +               <0x0 0xd3500000 0x0 0x07c00000>;
>>>>>>> + };
>>>>>>
>>>>>> Ack, this should be removed once the SMEM code is merged.
>>>>>>
>>>>>>> +};
>>>>>>> diff --git a/arch/arm/dts/sa8775p-ride-u-boot.dtsi b/arch/arm/dts/sa8775p-ride-u-boot.dtsi
>>>>>>> new file mode 100644
>>>>>>> index 0000000000..979462dfec
>>>>>>> --- /dev/null
>>>>>>> +++ b/arch/arm/dts/sa8775p-ride-u-boot.dtsi
>>>>>>> @@ -0,0 +1,11 @@
>>>>>>> +// SPDX-License-Identifier: BSD-3-Clause
>>>>>>> +/*
>>>>>>> + * Copyright (c) 2025, Qualcomm Innovation Center, Inc. All rights reserved.
>>>>>>> + */
>>>>>>> +/dts-v1/;
>>>>>>> +
>>>>>>> +#include "sa8775p-ride.dts"
>>>>>>
>>>>>> Why ? this file will be automatically appended to sa8775p-ride.dts, no need to import is before.
>>>>>>
>>>>>>> +/ {
>>>>>>> + model = "Qualcomm QCS9100 Ride";
>>>>>>> + compatible = "qcom,qcs9100-ride", "qcom,qcs9100", "qcom,sa8775p";
>>>>>>
>>>>>> Same, unneeded.
>>>>>>
>>>>>> In fact, this file is completely unneeded.
>>>>>>
>>>>>>> +};
>>>>>>
>>>>>> Neil
>>>>>>
>>>>
>>>> --
>>>> // Caleb (they/them)
>>>>
>>
>> --
>> // Caleb (they/them)
>>
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Groups.io Links: You receive all messages sent to this group.
> View/Reply Online (#862): https://groups.io/g/u-boot-qcom/message/862
> Mute This Topic: https://groups.io/mt/110407462/8413174
> Group Owner: u-boot-qcom+owner@groups.io
> Unsubscribe: https://groups.io/g/u-boot-qcom/leave/13197796/8413174/1557304080/xyzzy [caleb.connolly@linaro.org]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
> 

-- 
// Caleb (they/them)

