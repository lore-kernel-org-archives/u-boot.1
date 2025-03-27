Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AFADC3600B
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 12:30:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C97E8070C;
	Thu, 27 Mar 2025 13:30:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QZscK0Qx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9D4381273; Thu, 27 Mar 2025 13:30:18 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E367806FC
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 13:30:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43cf05f0c3eso6489745e9.0
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 05:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743078616; x=1743683416; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CCYNhyRiSeM5NE54wVf2CcG9guIPzH6ZFvQ2Qo5EuLo=;
 b=QZscK0Qxk28fR3GdZiUGvAokwSqJgt4ccZlHbP2EJGe4dD+BhHdPdA55SYmmIOkh73
 0MDN399Nf13Y/E+lagKs+SztLliJMULpy3SfsQiDt38I0MvpsjoLaHMjGYPCQrOHUlyk
 29kVa/YDKvRDs8OstqT2YN05rzX064H2DiG+oKewumof2MrUi9IMtu0hqjTjSNYxygBN
 6O4Yew/VA9JkU/YcKOyH/MN/k+oyIuPVbwtJXL14rF/kAbq/s0yK3ZVypdQwDkHTSOrG
 xr3EcJi834OtVsNdTQfoCiN9kEZsqFLcTtWwC3RnL4VWOMOVuGscKuWZXyVLTgveodVQ
 z46A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743078616; x=1743683416;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CCYNhyRiSeM5NE54wVf2CcG9guIPzH6ZFvQ2Qo5EuLo=;
 b=UrwKgMZImLIqJyPWi7WOLutwRKSIYCLtyJytv3dRafvDsZJf2qTzqvLUjTYghMLl9Y
 Yz3jN02XEbuAwEZdDejZoymJkTuB/vrAJuRTb/I9oLCZXJTZywHjz+V3WlF5maqsdSEh
 YmpBupPu+T+ASCTZ85MhRMG3yxx8eJbt4HO6It8Z3zqdamJeD94ka88DDANBWIW0IAuW
 yxMaE7btgvC2nMCJidjmDNsGnvprMwpHvrCwfi4bdGIf9mKLeqEC5NH+RKkRdLpfztn3
 gVJO+WYZbOF3tAsTDFXBR+bn80Z9o7lYJM8qc5P4wG8fbLfpX/aX1igBdcFSC/aPefsC
 D1Xw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUz59TmuV/fK7xqJzh+K55cYQ5cNCUsXiRIuoh1j7yQ9Oi5BOBc7RG4TL2BYK7qOpGqWN5nPjI=@lists.denx.de
X-Gm-Message-State: AOJu0YwTFXKn024pGAZJMGVQ66idsG7H8Rku2ey6cIWcp/XYpjF7+0ge
 raO5XjF6jhZknoAwf9S3er5qk2bgxLkOQia1yM676TO5Q76memBs2vbu1qeDeaU=
X-Gm-Gg: ASbGncsqBJPcUHHp+8zxYJ2VGznRkJ/VjBXeIVXNxWBbHQvQL7qVm2xNHena0GEynQx
 3T3UgAcoRySAzx5jDLDsU/qfV23xt/HuOQXiyK7yrpa9OGKPFwn9eqngCeYMlfiKhqMaANf7CtA
 4EJgN+YcXDIXtV4lh1oZSFgL2bXGsP+GY+tlth0b0ZZgy1CooolQvFcFOlUz2p5BaT7/gwR/0nF
 Z5QeqCjKBf+5BdC88NSkfiRg04vQeZ2x9R1hd1gwb99A+iKQ1RzA0aYkKiyampsc/5AgxiRSTRu
 ktGr9xXmwPCoDY6VPP0mrzOyBQWPwPJJ5dFZFPt0J5DsdGQqPkkyjxZ7Y9RxZxA8GGyw6SLm6iI
 =
X-Google-Smtp-Source: AGHT+IFd0MkQKzBBiKoAiIm3qZwavotICLRLhlvx4hUW0cGqOATwZn67rS06XXZaXGAdrGzuhJRqjg==
X-Received: by 2002:a05:600c:c83:b0:43c:fc04:6d34 with SMTP id
 5b1f17b1804b1-43d8506e9d9mr32513655e9.20.1743078615720; 
 Thu, 27 Mar 2025 05:30:15 -0700 (PDT)
Received: from [192.168.1.38] (i5E863BED.versanet.de. [94.134.59.237])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d82f7c3d9sm37040275e9.36.2025.03.27.05.30.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Mar 2025 05:30:14 -0700 (PDT)
Message-ID: <ed674ab9-85d3-4053-b032-63f7d329fa35@linaro.org>
Date: Thu, 27 Mar 2025 13:30:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] qcom_defconfig: enable capsule update support
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
References: <20250326-b4-qcom-capsule-update-improvements-v1-0-afe2e3696675@linaro.org>
 <20250326-b4-qcom-capsule-update-improvements-v1-4-afe2e3696675@linaro.org>
 <20250327084603.GA5432@nxa18884-linux>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20250327084603.GA5432@nxa18884-linux>
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



On 3/27/25 09:46, Peng Fan wrote:
> On Wed, Mar 26, 2025 at 06:40:37PM +0100, Caleb Connolly wrote:
>> We can now correctly identify which partition U-Boot is flashed to
>> between uefi, xbl, and boot (including A/B support) so enable capsule
>> update support for all boards.
>>
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>> ---
>> configs/qcm6490_defconfig | 6 ------
>> configs/qcom_defconfig    | 3 +++
>> 2 files changed, 3 insertions(+), 6 deletions(-)
>>
>> diff --git a/configs/qcm6490_defconfig b/configs/qcm6490_defconfig
>> index ba26924da161b1c4b5378955185f314b05cb1006..5ddc5ab3ef8cfe8f9cc09eb573c1a8130b394b43 100644
>> --- a/configs/qcm6490_defconfig
>> +++ b/configs/qcm6490_defconfig
>> @@ -18,10 +18,4 @@ CONFIG_DEBUG_UART_CLOCK=14745600
>> CONFIG_TEXT_BASE=0x9fc00000
>> CONFIG_REMAKE_ELF=y
>>
>> CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs6490-rb3gen2"
>> -
>> -# Enable capsule updates
>> -CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
>> -CONFIG_EFI_CAPSULE_ON_DISK=y
>> -CONFIG_EFI_IGNORE_OSINDICATIONS=y
>> -CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
>> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
>> index ba4d38d100e053e3708ee2623bf3530787b6b94f..d69185f3c2f0452e6757b785a023cf612bfa3839 100644
>> --- a/configs/qcom_defconfig
>> +++ b/configs/qcom_defconfig
>> @@ -5,8 +5,11 @@ CONFIG_SYS_INIT_SP_BSS_OFFSET=1572864
>> CONFIG_ARCH_SNAPDRAGON=y
>> CONFIG_NR_DRAM_BANKS=24
>> CONFIG_DEFAULT_DEVICE_TREE="qcom/sdm845-db845c"
>> CONFIG_SYS_LOAD_ADDR=0xA0000000
>> +CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
>> +CONFIG_EFI_CAPSULE_ON_DISK=y
>> +CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
>> CONFIG_BUTTON_CMD=y
>> CONFIG_FIT=y
>> CONFIG_FIT_VERBOSE=y
>> CONFIG_BOOTSTD_FULL=y
> 
> For capsule update, CONFIG_EFI_MM_COMM_TEE is not needed?

No, Qualcomm have a proprietary TEE. We rely on storing EFI variables in 
a file on the ESP. There does seem to be an issue where capsule updates 
don't occur unless that file already exists though...
> 
> Regards,
> Peng
>>
>> -- 
>> 2.49.0
>>

-- 
Caleb (they/them)

