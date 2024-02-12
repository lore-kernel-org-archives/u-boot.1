Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2077C4829B
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 13:15:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BF3087B63;
	Mon, 12 Feb 2024 14:15:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TVuRTLdP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6409A87BC3; Mon, 12 Feb 2024 14:15:21 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FB158718A
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 14:15:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a2f22bfb4e6so424498766b.0
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 05:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707743718; x=1708348518; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9qM2GAhqwdZ2GkJzFxj3b24ONlGU5Gwf2sk392R7gr4=;
 b=TVuRTLdPwAnWWH2+OrN50CBrBWPDjOA4avPOkUygNlPexKY+13HJl5z2o2Rzwmz4dY
 venzA1FaJ1QD+kvfqnLce3sI4utnMiMvw17rF8lJfGcYXCOZBP+CzC2rWIQDYFOJAeUG
 whz9ykGzBwNMSlmPOK+9c4MiLoNIlYiznyxZIbDcVAO1IMahLqWKtnu2jKgBo+UWNZtP
 AKHAJyEZDfeOiXW0MazlZjSFXLLL/6HaQqSQsUsrf7los0C7N/IRbtsTG16rqwWX0KDm
 cALMHIQnZZjWIanqZKiP7sVLt04AGOp6esI5myfh/IRe+yk2Nsxz+dUSjgtuC+xItQ2o
 inWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707743718; x=1708348518;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9qM2GAhqwdZ2GkJzFxj3b24ONlGU5Gwf2sk392R7gr4=;
 b=UyHCtLzG8Y3YV5W3B9phdTSIZs3+2UmuXcdWaCLe7/mJIVqbj+lELo/iygszGt6mZF
 46UvUSqh3I+sTS6aFg/UTUUKEk7hU4EyFCi+W7YtUBMil8IYjaaTotl7se7r8QQfMcqB
 pp0LiiyawN2OnySB3MYmnv1xoFObmDmXTOPNUwrcGzfYAAQyUDUmjjLDHVr0AZQnB5rJ
 cKWdJv2/a1QpKJFiXaZewUHPXTpdIjJ2lYhbXVD7eHORJbIKufC7X0tisRG29jSOUKcL
 WCnQz1e9ECIvIY/MTybx0fzQnK3htxKr6UZV7pxWfLuSAUztZIPXdM6FXpHcWrLbjMz+
 gaYw==
X-Gm-Message-State: AOJu0YxX76XXLgdjFrOVJiG+biFRMwjRx5uiw1I+17eNnMeNoUwgTPI2
 udYUoZdBmMQH6HOFLbwgSpWwTlWzLKpc0B3UUk1EDoq6LaF7j5y3BpywkLcuY6Y=
X-Google-Smtp-Source: AGHT+IEhVTW6bZ2uw3jWrrCEbtDdiIPq+eyjTdJ5BcGxHYNm6KVobw3baR8OuL24YpqZsY4uww8VlA==
X-Received: by 2002:a17:906:4111:b0:a38:577b:2a23 with SMTP id
 j17-20020a170906411100b00a38577b2a23mr4590197ejk.20.1707743718565; 
 Mon, 12 Feb 2024 05:15:18 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVxezzqH/vHzJGGOpB3zN+lqu6YzP0TZO0CvFBcaEs0M+dFCOi5UJl+nhHDpBw9l5IK4SkufcNMah0CBxh3jl0wtkB0r9dpJ6QCDKZ9fPFSMNN8en/F3o3po3zJ+NkmrtHT6m4QM9ZjnJnaZkLbCrVBdM5hTgVH/o6BDKk27BHsprX2h3fpbVmtNmYuDGfO6leGajFsX/sBzZwnfU8YZHQzNaqvbcn/facWKShYjUvo6xrPvhuYuYSbIanVJ84AndOnUTgegz8dc1OhCx4kdZSWOt4yozTpFAQk7ykTgNtux324PBfE04aYnr0wBcvJbEiDicCKoAc9e/u3CvuZGcQv2eSjiymudjYWxbd7+k1W1RRxj7mJKQhyIbZxsvj+vezq/fGPX3rNhwgvJXTJI6uVgUTQbV9P5bg51fijRnN1UplUKo6L2ZLav6CJV851nZBJvnG5tHAg1yeCxM86+0n+GGt4JDcQxPkfGJH3uSkRzvopFTDP3pfJaUkQQzlFST+bfuIgwj4OAdSWorvKJzeRVcqA5u+D/mkxRiDBpzGVqF+2d0QfnUOwJXDWOjSJI4NtuX1mrjxngMXlUFH/biSDnHcBCzn+3So+waC9Pu7LeHp47rjGk6o6RRCzppc8cwBTd83SIPg3U7a/Ixds
Received: from ?IPV6:2a01:e0a:3cb:7bb0:19f8:2209:bed2:ce0d?
 ([2a01:e0a:3cb:7bb0:19f8:2209:bed2:ce0d])
 by smtp.gmail.com with ESMTPSA id
 r14-20020a170906c28e00b00a3be732b9b1sm202742ejz.40.2024.02.12.05.15.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Feb 2024 05:15:18 -0800 (PST)
Message-ID: <44d1809d-4317-4363-a0e2-c83029357285@linaro.org>
Date: Mon, 12 Feb 2024 14:15:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] rockchip: rk3399: Update stack and bss addresses
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andy Yan <andy.yan@rock-chips.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Nick Xie <nick@khadas.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Deepak Das <deepakdas.linux@gmail.com>, Alexandre Vicenzi <linux@alxd.me>,
 Xiaobo Tian <peterwillcn@gmail.com>, Peter Robinson <pbrobinson@gmail.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>, Levin Du
 <djw@t-chip.com.cn>, Suniel Mahesh <sunil@amarulasolutions.com>,
 FUKAUMI Naoki <naoki@radxa.com>,
 Christopher Obbard <chris.obbard@collabora.com>, u-boot@lists.denx.de
References: <20240212005914.3512640-1-jonas@kwiboo.se>
 <20240212005914.3512640-3-jonas@kwiboo.se>
 <d8e10b17-0571-4ebc-9783-2301c429c6b3@theobroma-systems.com>
 <c3f2027d-3d87-4b71-bb13-35090640dc9a@kwiboo.se>
 <3b213c6d-9b97-48d1-8c36-4970dd1c4aa8@theobroma-systems.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <3b213c6d-9b97-48d1-8c36-4970dd1c4aa8@theobroma-systems.com>
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



On 2/12/24 12:51, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 2/12/24 12:08, Jonas Karlman wrote:
>> Hi Quentin,
>>
>> On 2024-02-12 11:37, Quentin Schulz wrote:
>>> Hi Jonas,
>>>
>>> On 2/12/24 01:59, Jonas Karlman wrote:
>>>> With the stack and text base used by U-Boot SPL and proper on RK3399
>>>> there is a high likelihood of overlapping when U-Boot proper + FDT nears
>>>> 1 MiB in size.
>>>>
>>>> Currently the following memory layout is used:
>>>> - 0x00000000 (@0 MiB): U-Boot SPL text base
>>>> - 0x00040000 (@256 KiB): TF-A
>>>> - 0x00200000 (@2 MiB): U-Boot proper text base
>>>> - 0x00300000 (@3 MiB): U-Boot proper init stack
>>>> - 0x00400000 (@4 MiB): U-Boot SPL init stack
>>>> - 0x00400000 (@4 MiB): U-Boot SPL bss
>>>> - 0x02000000 (@64 MiB): U-Boot SPL reloc stack
>>>> - 0x08400000 (@132 MiB): optional OPTEE
>>>>
>>>> SPL load TF-A, U-Boot proper and optional OPTEE after SPL stack has
>>>> relocated, meaning that there is room for close to 2 MiB (@2-4 MiB).
>>>> However, the initial stack used by U-Boot proper is limiting the size
>>>> of U-Boot proper + FDT to below 1 MiB (@2-3 MiB).
>>>>
>>>> Instead change to use the following memory layout:
>>>> - 0x00000000 (@0 MiB): U-Boot SPL text base
>>>> - 0x00040000 (@256 KiB): TF-A
>>>> - 0x00200000 (@2 MiB): U-Boot proper text base
>>>> - 0x00400000 (@4 MiB): U-Boot SPL init stack
>>>> - 0x00800000 (@8 MiB): U-Boot proper init stack (changed)
>>>> - 0x02000000 (@32 MiB): U-Boot SPL bss (changed)
>>>> - 0x04000000 (@64 MiB): U-Boot SPL reloc stack
>>>> - 0x08400000 (@132 MiB): optional OPTEE
>>>>
>>>> This should leave room for loading and running a U-Boot proper close
>>>> to 6 MiB (@2-8 MiB) in size. When U-Boot proper has relocated is should
>>>> be possible to use @2-132 MiB and @164 MiB+ for scripts, kernel etc.
>>>>
>>>> With the moved SPL reloc stack it is also possible to use a much larger
>>>> malloc area in SPL, e.g. using default SPL_STACK_R_MALLOC_SIMPLE_LEN.
>>>>
>>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>>
>>> Do we not need to update memory addresses in the environment as well?
>>
>> The addresses in environment is to my knowledge only used in U-Boot
>> proper after relocation. And at that time we should be free to use @2+
>> MiB up to somewhere close to gd ram_top/relocaddr. The optional Rockchip
>> OPTEE blobb may occupy @132-164 MiB, but I do not think loading OPTEE
>> blobs works as-is, so that may not be a big issue.
>>
> 
> Upstream OP-TEE OS seems to support RK3399, c.f. https://github.com/OP-TEE/optee_os/blob/master/core/arch/arm/plat-rockchip/platform_rk3399.c

It does indeed. I run the quarterly release tests on a RockPi4B. We record which
platforms have been tested in the commit description for each release tag. For
example, see [1].

In the configuration I test, OP-TEE is loaded at 0x30000000 and uses 32MB (for
some reason the Linux DT reserves 36MB but I don't think it matters much).

[1] https://github.com/OP-TEE/optee_os/commit/18b424c23aa5a798dfe2e4d20b4bde3919dc4e99

-- 
Jerome
