Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4CC2C83F03
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 08:33:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F1168091A;
	Fri,  4 Jul 2025 10:33:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vdR78vUb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE64281D5D; Fri,  4 Jul 2025 10:33:06 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3443B803DF
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 10:33:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-ae401ebcbc4so37736166b.1
 for <u-boot@lists.denx.de>; Fri, 04 Jul 2025 01:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751617983; x=1752222783; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UvuVAxlLp/5bHzOrwSSpy0fUCXzenNUK79w/x4atwUA=;
 b=vdR78vUb6jtfttvODhgXb+9jFkC230FbLAlbPFnpnRInTOkLbzH8xj0tenTItozkCJ
 GfdHwcHjjEHtOxQw2aVNGK7jMXNHQjUMX2Dao5e7CmOQklWsecPwkZDy3mPXGTrRwzjP
 mrC2DNJwh+A/n8PDNOkglIVgZAqfmQAN4qz5kg1kZBEaDfPuS9uuXNGSqvLHnzAK7ehY
 xg9eL4ne4AwHtiLpEJNLXmpl86ZPG3HnwBM5IlKYMAsD8rmX71CtvkWDsYOdYHfmww4J
 JNRud1lKHd4u6NyjoffcIW7YWuuuhytih2ELFYXSBY3cx8jCWuCwqDPp8tVJ7Tm1yzsH
 oDQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751617983; x=1752222783;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UvuVAxlLp/5bHzOrwSSpy0fUCXzenNUK79w/x4atwUA=;
 b=DhJ3Z3GsGbZ7A++cdYFoLv2HfHIVz/DFQ5t8HVerZ3P0vBMtR6aFXk2QXpb03NT3fK
 3qbRgx6XBtjvkwgNLGL8XMJUOJ2Vm+07kvdtdb1Qi4ziZVywr55BhowC7/lH2n4OQ9XV
 UaAFei0G9YiQj9yq39dgNpO//V7Kdc9wHzidsffq8kn/MAaIIxlGKChRWuC6euOmzf2K
 19cR7g/VSKTmXwuwIATFHJdXowHG9MEU/6yKbE98nas1K9gzlDzGuGlZfiDgcndYMtVH
 /AdxJJymeUsRkJ+VU++rhmZzyqg/r4tEK1dDlwJ43GeEjBMCnJn002nCjFGiFifIvn0f
 O3xQ==
X-Gm-Message-State: AOJu0YwYcU3o9m28ulLH0HQzclKaCN4YCPMKCNdbCz662o0z2RyD639C
 JJjpq9iTQPXzIPmu5/ViZymyc1ESnwBrtR1sI8tqCzcHStGVc1iBPBvqu/LibAQtkPE=
X-Gm-Gg: ASbGnctSY7RaYLqhV3a4OtWY3ndOGz4bPs851YEOAeQNbImoelhRPVDBQQW8TGW1vTo
 2CklMSn8I2Ivps5oaQEXNCgLjLlqLAyfHr7TcqwiHZSC1SgD1HNoB6xi36v1eUTLtTnNcrQQT4d
 V5LfE7coPGz7yjNJn0TWnp9jAKKsnaPieyGN/7v8qgYFcmxXFHfXNZB8rA0JdcJMpJ7waDIKZ9R
 +4ovw9hjJ6Lz4DtKhCjSf04No3/guNJGkLLExYIH6sGAP0QFLqKJ5vtUkdVb3NN5DK+25hmAkts
 5ORUB3Csn9sT/9ijKDitW15Ptk59Sv6E3hXxSnnQOhtGxpelYuwmHy4PNBCkg+A7WN/ny92rNue
 1igZEfFjOrzTKbYkJ4MjwLvUoOiCSSgs/pfnTfuljHA==
X-Google-Smtp-Source: AGHT+IEBOkl7vqtgucKs8/XRZR8ShMFGL4r2eXf4/J6JAnZ2Szrg1eaRk29AnTRj6svE6lqPlVEFOQ==
X-Received: by 2002:a17:907:d106:b0:ae0:d4f2:dff3 with SMTP id
 a640c23a62f3a-ae3fbd93190mr160969066b.58.1751617983401; 
 Fri, 04 Jul 2025 01:33:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:713c:93e8:d764:c0f8?
 ([2a01:e0a:3cb:7bb0:713c:93e8:d764:c0f8])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae3f692fbddsm134207366b.62.2025.07.04.01.33.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Jul 2025 01:33:02 -0700 (PDT)
Message-ID: <0b7fcdb0-0d18-41ef-8607-cf060ce3d058@linaro.org>
Date: Fri, 4 Jul 2025 10:33:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/3] Static initcalls
To: Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Otavio Salvador <otavio@ossystems.com.br>, dl-uboot-imx <uboot-imx@nxp.com>
References: <20250404135038.2134570-1-jerome.forissier@linaro.org>
 <CAOMZO5Dhs2GRgvjDCBbwsxxZadsVCrpXaWm4qToYfpak+CAKuw@mail.gmail.com>
 <CAOMZO5Bjxx5tjj75Bo8A4WJWBnV3Q8h1UHK45_xZgOavig0C9w@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAOMZO5Bjxx5tjj75Bo8A4WJWBnV3Q8h1UHK45_xZgOavig0C9w@mail.gmail.com>
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

Hi Fabio,

On 7/4/25 04:34, Fabio Estevam wrote:
> Adding Tom.
> 
> On Thu, Jul 3, 2025 at 11:33 PM Fabio Estevam <festevam@gmail.com> wrote:
>>
>> Hi Jerome and Tom,
>>
>> On Fri, Apr 4, 2025 at 10:51 AM Jerome Forissier
>> <jerome.forissier@linaro.org> wrote:
>>>
>>> This series replaces the dynamic initcalls (with function pointers) with
>>> static calls, and gets rid of initcall_run_list(), init_sequence_f,
>>> init_sequence_f_r and init_sequence_r. This makes the code simpler and the
>>> binary slighlty smaller: -2281 bytes/-0.21 % with LTO enabled and -510
>>> bytes/-0.05 % with LTO disabled (xilinx_zynqmp_kria_defconfig).
>>>
>>> Execution time doesn't seem to change noticeably. There is no impact on
>>> the SPL.
>>>
>>> The inline assembly fixes, although they look unrelated, are triggered
>>> on some platforms with LTO enabled. For example: kirkwood_defconfig.
>>>
>>> CI: https://source.denx.de/u-boot/custodians/u-boot-net/-/pipelines/25514
>>>
>>> Changes in v6:
>>> - Rebase on next branch
>>
>> This series breaks the boot on an imx6dl sabresd board (mx6sabresd_defconfig):
>>
>> U-Boot SPL 2025.04-01075-g3c9c3d852e00 (Jul 03 2025 - 23:23:12 -0300)
>> Trying to boot from MMC1
>>
>> (Hangs here)
>>
>> I ran a git bisect from 2025.04 to master, and that was the result:
>>
>> 8c98b57d72d5e5b94ed064fe1041e51216165334 is the first bad commit
>> commit 8c98b57d72d5e5b94ed064fe1041e51216165334
>> Merge: 739ad58dbee8 bbee3d41b33f
>> Author: Tom Rini <trini@konsulko.com>
>> Date:   Mon Apr 14 08:59:45 2025 -0600
>>
>>     Merge patch series "Static initcalls"
>>
>>     Jerome Forissier <jerome.forissier@linaro.org> says:
>>
>>     This series replaces the dynamic initcalls (with function pointers) with
>>     static calls, and gets rid of initcall_run_list(), init_sequence_f,
>>     init_sequence_f_r and init_sequence_r. This makes the code simpler and the
>>     binary slighlty smaller: -2281 bytes/-0.21 % with LTO enabled and -510
>>     bytes/-0.05 % with LTO disabled (xilinx_zynqmp_kria_defconfig).
>>
>>     Execution time doesn't seem to change noticeably. There is no impact on
>>     the SPL.
>>
>>     The inline assembly fixes, although they look unrelated, are triggered
>>     on some platforms with LTO enabled. For example: kirkwood_defconfig.
>>
>>     CI: https://source.denx.de/u-boot/custodians/u-boot-net/-/pipelines/25514
>>
>>     Link: https://lore.kernel.org/r/20250404135038.2134570-1-jerome.forissier@linaro.org
>>
>>  arch/arm/include/asm/system.h             |  22 ++-
>>  arch/arm/lib/cache.c                      |   5 +-
>>  arch/arm/mach-kirkwood/include/mach/cpu.h |   9 +-
>>  arch/sh/lib/board.c                       |   9 +-
>>  common/board_f.c                          | 223 ++++++++++++++-------------
>>  common/board_r.c                          | 247 +++++++++++++++---------------
>>  include/initcall.h                        |  49 +++---
>>  lib/Makefile                              |   1 -
>>  lib/initcall.c                            | 102 ------------
>>  test/py/tests/test_trace.py               |   8 +-
>>  10 files changed, 297 insertions(+), 378 deletions(-)
>>  delete mode 100644 lib/initcall.c
>>
>> Any ideas?

Have you tried the master branch recently? Hopefully commit 410d59095a9f
("arm: kirkwood: fix freeze on boot") should fix the issue.

Thanks,
-- 
Jerome
