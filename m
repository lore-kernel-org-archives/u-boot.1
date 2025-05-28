Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1127AC3ABB2
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 15:28:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 689D08331B;
	Wed, 28 May 2025 17:28:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dkrz6t6K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26635833C6; Wed, 28 May 2025 17:28:37 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B57508329C
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 17:28:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a366843fa6so2913266f8f.1
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 08:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748446114; x=1749050914; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Kwa425+7b87LPCiBbKUfpyMV6u5+rKNLo7T4pa7PEjQ=;
 b=dkrz6t6KvQT33ZAbAklxCbS+SkW3x+vhbJcmibXkAaGWyavR+na86bGvtGMAMPNQCQ
 1lxKt2mw8cvJ62Ojop7JlsoqvKZmMovd+KfAHwOP/oJPi8dW+DVk0lKHxRjbUSjJYKY+
 gGfj2Ta7+Zoz2mm8VjwUGlMyV9CmxgAadmSBHTnsQ0nFPwJXfwCJ2rhTdKcWwOHlB3mn
 z6vk4jVbopRMeleHGi67tN2o2f2fjhjwvOm+6gaK9DHR0QWb21dqzsHlDTV9tUtkexLT
 680KI2sOR6BuQTvmtQs61ohAbCacqkO4D9bt3FE8DHmPs5ql3LnyFb5O2ppQfsfTQriq
 VOZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748446114; x=1749050914;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Kwa425+7b87LPCiBbKUfpyMV6u5+rKNLo7T4pa7PEjQ=;
 b=InBYIgwnKcHWDmjBV5Uqm4XqtcUjdp6Jket1p97fd3v083UP4zOfskZwT/OK+QaZtw
 X/eUDOP705Z3WPOnnkXqNGGl6PO4ROPtdYyHebMx1XV+KbfZm6OMrl0PLIdvSBiTm6Rb
 +URGYjE+4dqkLoIaijeSzEff1e+eS45sYorn5acin+vV/r6NxhrMvaVxRyfDEIf2P5rk
 c/hFI0jlc4OrQuvZKj+pvVYJ5vf06i9VdUr9FAsw5cG60MehXKrYKjzeeOELcdVxSeBO
 Imp6jh6D9pzbyYDGXF6csBl50YkH0ZXv8tEVIhCOXJjQcsur5r2IVpkMaTcmPYaWL1HO
 VafA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/CmGyPtnL/NyVbiQWsjUsFCBy4Uax8PQtzHHbwHrGBSorbEmZOgLoOeLl+lgnUhSsEsz0kbE=@lists.denx.de
X-Gm-Message-State: AOJu0Yxh6QRX0eS1ZvFY7ttywtuuK3qtBYDvW6m8TL0gnvZBp65cHV/o
 yFmK1tNSmvb3U3NYhbRuM32aIIT+WqWz6vBmSJZk2ZNj0DzqT6BInSL9tRjYA2GtNtA=
X-Gm-Gg: ASbGnctBw9kbQuNEhlI5t4W5/VGnrrPOUareJnf0PMNvhY1bsbeGAhXE1fRo6vfYOEb
 KGWEH1PosZLFgFTzVkhFBw3ozsCdXt6nO3v3hhcnNXPww7AVifZqBL6NDa9EC+uCZxOZhr2abVn
 RGeo0L0WtgAdWFX444ji7mFBRzJA66Zyvv+67Yz85RXoiVFCHHelG2EdQ4URN7dzTRUX1oLE7wZ
 3yUUOmbKVpXO6Oy9Wg/qZTNEfcxyWzhcoXRbkU9F8zyv4coL0prXf8SMiEtgVb5p4fPqqhO6yJD
 wfAB62XMySHma7WaG5Bor77lAza2QUFdy1l3Uw+OpVhkvJ5NgnuL+P3Q0Cxu0tFBuEClXS2TPb4
 3t37zHariRme5CbkeSEx4oiElKRszce8=
X-Google-Smtp-Source: AGHT+IGq/mFsx7H2dCYOZxNPLXxcC3K2LwGNbh3QqrpwBBh6YJA/cvS/wpK+5WeSVpiuwlY4XAXfww==
X-Received: by 2002:a05:6000:40c9:b0:3a3:6a9a:5ebf with SMTP id
 ffacd0b85a97d-3a4cb436e22mr13740720f8f.20.1748446114080; 
 Wed, 28 May 2025 08:28:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:f07d:7465:d8f9:92f1?
 ([2a01:e0a:3cb:7bb0:f07d:7465:d8f9:92f1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4eac6eb5esm1736910f8f.2.2025.05.28.08.28.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 May 2025 08:28:33 -0700 (PDT)
Message-ID: <5623adb2-8755-4c04-bdd2-498907b00b4d@linaro.org>
Date: Wed, 28 May 2025 17:28:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] makefile: fix Clang link error when RSA_PUBLIC_KEY_PARSER
 is selected
To: Tom Rini <trini@konsulko.com>
Cc: Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Peter Robinson <pbrobinson@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sam Edwards <cfsworks@gmail.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
References: <20250527210508.1488509-1-raymond.mao@linaro.org>
 <6b992b47-de7c-45ce-9c3c-ca4a2295f7c9@linaro.org>
 <20250528141945.GV100073@bill-the-cat>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250528141945.GV100073@bill-the-cat>
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



On 5/28/25 16:19, Tom Rini wrote:
> On Wed, May 28, 2025 at 10:25:06AM +0200, Jerome Forissier wrote:
>> Hi Rayond,
>>
>> On 5/27/25 23:05, Raymond Mao wrote:
>>> MbedTLS bignum module needs '__udivti3' which is a 128-bit division
>>> function provided by the compiler runtime, typically libgcc for GCC or
>>> clang_rt.builtins for Clang.
>>> Thus 'clang_rt.builtins' library is required when building using Clang.
>>
>> How do you reproduce the problem? Can you give the config and build
>> command you are using?
>>
>>>
>>> Fixes: 13de8483388c ("mbedtls: add mbedtls into the build system")
>>> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
>>> ---
>>>  Makefile | 6 +++++-
>>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Makefile b/Makefile
>>> index f88684947ee..16506dcaec6 100644
>>> --- a/Makefile
>>> +++ b/Makefile
>>> @@ -37,7 +37,6 @@ else ifeq ("riscv32", $(MK_ARCH))
>>>  else ifeq ("riscv64", $(MK_ARCH))
>>>    export HOST_ARCH=$(HOST_ARCH_RISCV64)
>>>  endif
>>> -undefine MK_ARCH
>>>  
>>>  # Avoid funny character set dependencies
>>>  unexport LC_ALL
>>> @@ -915,8 +914,13 @@ PLATFORM_LIBGCC = arch/$(ARCH)/lib/lib.a
>>>  else
>>>  ifndef CONFIG_CC_IS_CLANG
>>>  PLATFORM_LIBGCC := -L $(shell dirname `$(CC) $(c_flags) -print-libgcc-file-name`) -lgcc
>>> +else ifeq ($(CONFIG_RSA_PUBLIC_KEY_PARSER_MBEDTLS),y)
>>> +# mbedtls bignum needs '__udivti3' - a 128-bit division function that's provided by clang-rt.
>>> +CLANG_RT_DIR := $(shell $(CC) --print-resource-dir)/lib/linux
>>> +PLATFORM_LIBGCC := -L$(CLANG_RT_DIR) -lclang_rt.builtins-$(MK_ARCH)
>>
>> I'm afraid this won't work when cross-compiling because the compiler-rt
>> builtins libraries are usually not installed with the compiler.
>> For example on my Ubuntu 24.04 machine:
>>
>> $ clang --version
>> Ubuntu clang version 18.1.3 (1ubuntu1)
>> Target: x86_64-pc-linux-gnu
>> Thread model: posix
>> InstalledDir: /usr/bin
> 
> How about if you use the llvm.org packages?

Nope. Doesn't seem to have the compiler-rt libs for multiple targets :-/

$ wget https://github.com/llvm/llvm-project/releases/download/llvmorg-20.1.0/LLVM-20.1.0-Linux-X64.tar.xz
[...]
LLVM-20.1.0-Linux-X64.tar.xz     100%[==================================>]   1.88G   265MB/s    in 7.4s
$ tar tvf LLVM-20.1.0-Linux-X64.tar.xz | grep 'libclang_rt\.builtins'
-rw-r--r-- runner/docker    270638 2025-03-04 23:03 LLVM-20.1.0-Linux-X64/lib/clang/20/lib/x86_64-unknown-linux-gnu/libclang_rt.builtins.a


Thanks,
-- 
Jerome
