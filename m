Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F3FEEE4997
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 21:17:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4994E869FD;
	Fri, 18 Aug 2023 23:17:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LHflqjPA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA8DB86A01; Fri, 18 Aug 2023 23:17:15 +0200 (CEST)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0220F869F9
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 23:17:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6889078ee66so1161359b3a.0
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 14:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692393431; x=1692998231;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+bY416MCVOS84biPL7WwkgwRJmTleF5gMDuvxRfEriA=;
 b=LHflqjPAIelL/AsElZMZIDBJGUxpduo7y0u5ug5kE/hmL6Rm66bq6pg3nsUAWH3B0E
 VPXeQnVzCmq7mcgaaroEj0/8VWqJwb3t2A0KyBr94o9rh85hLGdPiWv+oT2IeErRjriB
 6GRXi0zovwt698bZjDt2vFfJSGapG1/3K4MfcZ/jt7XNcqjzFwigtTps27ZCTE3ozKtM
 Ac6T1Si/0u7WIPQbsFs0zT/m0fLKwzMnhfEwaPznsWNJU/FpvQFQprk7Int4pha7eC61
 tb9Who0xngyilBkYoP7BIRfqn5D8OjLsX/MDmL+x5Ol6UQZgTL9o4AchZI4q9t7Z5e/3
 mo1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692393431; x=1692998231;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+bY416MCVOS84biPL7WwkgwRJmTleF5gMDuvxRfEriA=;
 b=I18tneHGgfGe7uNJ7PWNolgP199rugbuxi4yY7WCUxvSxWQ+ISUTE0y3ucRskyGvNd
 ASNAEsMW+wy5WEakIxsbn4IScUzLMH2w/taGxHzzysp31cOyHkbQ8t7Sg+l/uOzDQMqz
 jypp0CEj05M3E2tCM/0YfDCsUUXrkIGPGnxulsbHM6R+4Tkt4Ix8FmUy/v7YJxWQUrqw
 ryuxCCZ0CB8M8mcRRpYrDBKwL7IQxuByQA3lijUR7hVqlIfVTWGmh/dxxoEJ0WajqyE5
 kq8PatIMaNJozSbHmblZJA5+ScSTEpwb+xDQ5NuBnUBdJQS8BWMzIV5QZvdY3z9qQ+xU
 wigw==
X-Gm-Message-State: AOJu0Ywg5X/+ZvyOOJVJRtYO536MNm+Rx2t24MLgkb7C7oWrooNQkdmm
 /uwpRAtbcKHQoToT33iG2KA=
X-Google-Smtp-Source: AGHT+IFbnGhUKKa29F8RthlQ8FqP6AUPCz/HQ/ksyOCl5zehSBxB38inieSLras0ZONnodIP8TaGzw==
X-Received: by 2002:a05:6a00:21cf:b0:687:1be4:46e7 with SMTP id
 t15-20020a056a0021cf00b006871be446e7mr525956pfj.9.1692393431132; 
 Fri, 18 Aug 2023 14:17:11 -0700 (PDT)
Received: from [10.64.107.252] (static-198-54-134-172.cust.tzulo.com.
 [198.54.134.172]) by smtp.gmail.com with ESMTPSA id
 c24-20020aa781d8000000b00686a80f431dsm1936317pfn.126.2023.08.18.14.17.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Aug 2023 14:17:10 -0700 (PDT)
Message-ID: <00d8e7d3-15a0-20cc-90bd-7a2fbc1867e8@gmail.com>
Date: Fri, 18 Aug 2023 14:17:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 1/5] sunxi: psci: clean away preprocessor macros
Content-Language: en-US
From: Sam Edwards <cfsworks@gmail.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>,
 Samuel Holland <samuel@sholland.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Icenowy Zheng <uwu@icenowy.me>,
 Maksim Kiselev <bigunclemax@gmail.com>
References: <20230816173420.83232-1-CFSworks@gmail.com>
 <20230816173420.83232-2-CFSworks@gmail.com>
 <20230818151103.3fe5a32e@donnerap.manchester.arm.com>
 <ba7bf86f-3f4d-036a-9531-72a97d741f91@gmail.com>
In-Reply-To: <ba7bf86f-3f4d-036a-9531-72a97d741f91@gmail.com>
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

On 8/18/23 10:40, Sam Edwards wrote:
> On 8/18/23 07:11, Andre Przywara wrote:
> 
> Hi Andre,
> 
>> The resulting object file is different (8 byte larger,
>> even), so it's hard to prove
> 
> I'm no stranger to reading object code. Since the output should be 
> identical in principle, I'll spend a little bit of time today seeing if 
> I can identify what's changing. If it's easy enough, I'd like to adjust 
> my patch so that the optimizer does produce the same output. (Keep in 
> mind I'm on Clang, though. If Clang already gives the same output for 
> both, I'll just report back to use that when comparing.)

I built only psci.o from every ARM32 sunxi for which we have a defconfig 
(and for which PSCI is supported), for 81 targets total (though there 
are only 4 variations: R40, sun7i, H3/sun6i, and "everything else"). I 
am working with Clang version 16.0.6.

I compared only the secure text section. The command to extract this 
looks like:
llvm-objcopy -O binary --only-section=._secure.text psci.o text.bin
This is important because there are debug sections that will change when 
the source file line numbers change, so we must ignore those when comparing.

In the majority of cases, there are no changes to the text section 
introduced by this patch. In the R40 case, there's a small change where 
the compiler adds a NULL check onto the result of the `(void *)cpucfg + 
SUN8I_R40_PWR_CLAMP(cpu)` computation, which we can ignore as it won't 
affect anything in practice. In the sun7i case, the only changes are 
because I am NOT hardcoding the CPU to 0, which does look like I broke 
it (since that means it will use cpu=1). So I'm going to need to fix 
that in v3.

For good measure, I also applied the same methodology to patch 2 in this 
series, and that introduces no text section changes whatsoever in any of 
the tested cases. So patch 2 (theoretically, anyway) needs no bugfixes 
or hardware testing.

Patch 3 does cause a text section change for all targets. I will have to 
investigate why, in case I messed up any of the offsets when migrating 
off of structs.

Regards,
Sam
