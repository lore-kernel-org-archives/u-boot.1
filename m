Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D83FBC25B74
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 15:30:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58715884D5;
	Fri, 24 May 2024 17:30:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XxBf4K+C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43A9D88859; Fri, 24 May 2024 17:30:49 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 415D288495
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 17:30:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a62614b9ae1so146015366b.0
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 08:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716564647; x=1717169447; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/mIQP2SQkSd5v9oXLLMRHZ1tdMp8BLk9jSDFJboxoas=;
 b=XxBf4K+Ct7rQ784Ght93mK4N2iZ2Hpg9/ScC9ZJWUj3AC3NxUT+CZ2RpXWhvUVCTMq
 03eRJz0ZxA066M4qnSsq1QEDpEZeKyy+zdJYR4ku41BwX41xnpHl8aYdhUhKoJgSwF5O
 ttE6VwwoSBI0/S2ciyXQnmbz/XaNUxyWCBCbqPIlGV+lxL1QkW+f8gW2TGFz5XIuPctH
 r1xipFfDxAIMQ7btdMe5jEVrmLdHYlfx7c8xG4/7gteuBbDhrI/mZchu15xis73E+Ff5
 VucZZXejWpWP3VAzB5zSsQX+b48KwEFyXSo1fUFvI8t/ACbNWDl5J1ZWNrzpHOXeDOMR
 lyEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716564647; x=1717169447;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/mIQP2SQkSd5v9oXLLMRHZ1tdMp8BLk9jSDFJboxoas=;
 b=GUvGSpR/agiJ2YktilcVeC28STgaHXAYR6U9WF+E8tnOWKKcx9OIHaS17V1J5X7M63
 n6iPicoEKhsCwxbd0UJXoDMGLhggFcfx1dcV1gxKQxIYvMy08FhZ/m47nheKzuhgKgGc
 4iIVz8YRmViROombLuLyffxTm4/amZEg7W2u0G1GFz1D6Omzd3uGD2JiwRlOYim9ptuB
 Eb2QjBzFCwgPyjfAgAf6wZ4sOaYSqjL7IvDPLR99/uLG9cNQ9E6MWXF6SvReNH7j1xVK
 oEjrhJULvGmTG+pmOrkVkkI8TMGWOT7YsIc4XA04tytoP1/4TR+heTNM+T5Ln548hClq
 R7pw==
X-Gm-Message-State: AOJu0Ywy+aGXFmKGGjnLjTGQ+Gj6RJtrv1iB4N79cmGkJjqvtPu62fZ7
 NfE/b1rA9kwF3zqaKTfnt3yULQwAZAOv5CeB80rCv6Ii47z5vrrGtLv5pyfdmys=
X-Google-Smtp-Source: AGHT+IE+BODVMc3Pu9unXVhpImwYzN4HR0RfBDsLVkQWkhxds5gCLfePTJMiS/vVhgFVeFjyhMxL+w==
X-Received: by 2002:a17:906:3519:b0:a59:a18e:3fd9 with SMTP id
 a640c23a62f3a-a62641c49c7mr192056666b.5.1716564646673; 
 Fri, 24 May 2024 08:30:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:4db2:46ef:25c5:9c4c?
 ([2a01:e0a:3cb:7bb0:4db2:46ef:25c5:9c4c])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626cc519dfsm146861466b.141.2024.05.24.08.30.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 May 2024 08:30:46 -0700 (PDT)
Message-ID: <50cc2e57-a582-494e-a6a4-94ff5efea422@linaro.org>
Date: Fri, 24 May 2024 17:30:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/15] configs: add qemu_arm64_lwip_defconfig
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bin Meng <bmeng@tinylab.org>
References: <cover.1716393035.git.jerome.forissier@linaro.org>
 <67ac1063406f022ccc35b94ba41317b6e9ee8b3e.1716393035.git.jerome.forissier@linaro.org>
 <20240523150246.GO2568172@bill-the-cat>
 <0684e59c-523b-4b6f-9ed2-138122c8c127@linaro.org>
 <20240524150808.GZ2568172@bill-the-cat>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20240524150808.GZ2568172@bill-the-cat>
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



On 5/24/24 17:08, Tom Rini wrote:
> On Fri, May 24, 2024 at 12:09:33PM +0200, Jerome Forissier wrote:
>>
>>
>> On 5/23/24 17:02, Tom Rini wrote:
>>> On Wed, May 22, 2024 at 06:00:12PM +0200, Jerome Forissier wrote:
>>>
>>>> Add qemu_arm64_lwip_defconfig which was created from
>>>> qemu_arm64_defconfig with CONFIG_NET_LWIP enabled.
>>>>
>>>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>>>> ---
>>>>  configs/qemu_arm64_lwip_defconfig | 70 +++++++++++++++++++++++++++++++
>>>>  1 file changed, 70 insertions(+)
>>>>  create mode 100644 configs/qemu_arm64_lwip_defconfig
>>>>
>>>> diff --git a/configs/qemu_arm64_lwip_defconfig b/configs/qemu_arm64_lwip_defconfig
>>>> new file mode 100644
>>>> index 0000000000..c8dadbce37
>>>> --- /dev/null
>>>> +++ b/configs/qemu_arm64_lwip_defconfig
>>>> @@ -0,0 +1,70 @@
>>>> +CONFIG_ARM=y
>>>> +CONFIG_POSITION_INDEPENDENT=y
>>>> +CONFIG_ARCH_QEMU=y
>>>
>>> Setting aside that I would like lwip to default to y, at least in the
>>> first few iterations (so that testing is easier),
>>
>> I could certainly do this. By creating a new defconfig, my goal was to
>> minimize the impacts on existing use cases.
> 
> Yes but then it makes it harder to out of the box see what the deltas
> are.
> 
>>> this should be using
>>> the #include method rather than duplicating the whole config.
>>
>> I've done that for v2. Let me know if you still prefer I change
>> qemu_arm64_defconfig instead.
> 
> This is fine for v2, yeah. Once that's posted I'll grab everything and:
> - Throw it at the small HW lab I have
> - Enable it by default for everyone and throw it at CI

At this point you can expect quite a few failures (unresolved symbols to
begin with) because so many parts of the network-related code peek & poke
various parts of the net implementation without formally depending on NET
(i.e., !NET_LWIP). Some more work is clearly needed to port to lwIP, how
much is probably something the CI run will help understand.

Thanks,
-- 
Jerome

> - Also throw it at my script for world build before/after and using
>   buildman's bloat checker to see what grew how much where.

