Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B1BEC02193
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 15:49:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0473E800B3;
	Tue,  4 Feb 2025 16:49:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MBdnUac0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AC5E801FD; Tue,  4 Feb 2025 16:49:51 +0100 (CET)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13B4880040
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 16:49:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-43618283dedso58932975e9.3
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 07:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738684188; x=1739288988; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qrlGeHfAOIIbXEMaA6tZ8uimnCfj2650KJYXlXp45fM=;
 b=MBdnUac0FosLG6HhohJo3SWA8X7uW3FYq1FGTlttWi6H2dZhOZ6P8B3IMRz74K5aCK
 skPfe5voRB9vLGYHH2raCZ56TOOz0eCNYduRYiX6Aufwf7r9iDTov++yjKHiNZaopksv
 ZuuPpDwfWvFlk89nEldccnqdS+XrTlgv6nI+SMssDtj84+myoY3jAWExdP/LRzFfsbfC
 xDlFwcMj+uNRM6ygOaWom1bR7mNURybJB1vBsh3dugfo/jEzjibSUq2AJ1WL2ZAeb7b3
 kVCFNU1ZdH9ZWrYy51oCD8k4hS0raTYpghPNckptlAcN/JXZXUegWPXA7mu/2GqHMzYf
 Y/sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738684188; x=1739288988;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qrlGeHfAOIIbXEMaA6tZ8uimnCfj2650KJYXlXp45fM=;
 b=tIKYIKpIOu6Z/OhFIVak9YWaUdns9R1Gbu+kZJJLyuLB2Hns2X6PUQu74KPdJO90SM
 u9L3mvEKsOnxhzdo6g0xjbEfXqof5lKbiT15H8QYwLLdehlmNAQFmtbh8kZnVtF5cRNZ
 A0+CEHKv36LKJOCMOIe2HDRhLATX4+0pp6ard0Qy+NbyMy4OhqM+RuLdvZeeV5LoVUnN
 HS8x1uyYYgxIaXYkalNURc62/ubf5VVbMm3TTsgXr49P0zcZzk6RqiY6T6EstXKHIJPq
 WVU4E6ZJ5rJ5edV4jYgaUzMBMIEhEEg86xtdc/G6xA7q1O2i7B0PVKvA9xTrvnGrSJx/
 34ig==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWhunBwc1exYHGxobidOdPAPPNHUJXauuKVNW/+HONl0yGjtMv40B7j/2vD+YoaIG9ckWixTk=@lists.denx.de
X-Gm-Message-State: AOJu0YzPsJ1ZcLBC22JX+QfPIS1duaQMHuBZJohGPsm44MMeXI3+9L/x
 d9BQxj6Sx7jEuMdMyvE76hnFlVAOVt0CBYhRWBU5OQnKrJT4xrdMCm09Mvc+CxE=
X-Gm-Gg: ASbGnctRoVxSYV6gWAp6FqvMfBIYwcP66zwsXqLYU640Bews8s6MCYcbD7gOJCRFBCH
 x0gd5O2n0zFrJLfpGtI3DIgAvqtb/Zl1EOxez0Obx71wUAiiOpwZof+0ooL7LR+vQW+4cOuxwSt
 FuBc3Xchd7X2eCYCOtA1Lxn8vGXgC3PRdQsKdIeh34KBB9iZK3HHaFKdrnmk7AGfNqWrkTUEZkA
 2w2pd7WVrn4Uzqy10WMGl0yIpyWgaUiZMj/6YwKDDdFaPkwFYtr68080zM03taM8irQmAeYU92H
 0xgcmsw18VHsMZ+cAYsKroaUcOTe
X-Google-Smtp-Source: AGHT+IFWdYIh3VFMGpPrEGfkHL4YuQ5VlBgUaBRYoG+0S9KdIo4AC5/7S0CMSUVokRCaVXIBeUi7sQ==
X-Received: by 2002:a5d:6d0d:0:b0:38c:5fbf:10e3 with SMTP id
 ffacd0b85a97d-38c5fbf156dmr14218556f8f.7.1738684188437; 
 Tue, 04 Feb 2025 07:49:48 -0800 (PST)
Received: from [192.168.7.95] ([212.114.21.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438e245f492sm192739465e9.38.2025.02.04.07.49.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2025 07:49:48 -0800 (PST)
Message-ID: <cd384aa6-c4fd-41ea-a092-8dbd4059fe0f@linaro.org>
Date: Tue, 4 Feb 2025 16:49:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: Kconfig: Select DM_RNG for LWIP
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de, git@xilinx.com
Cc: Adriano Cordova <adrianox@gmail.com>, Anand Moon <linux.amoon@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
References: <a594ad9352a4935df53d664a951473a2b1f5fafb.1738594978.git.michal.simek@amd.com>
 <e1dddae3-d44d-4b76-a1a1-a30e19e6c3ed@amd.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <e1dddae3-d44d-4b76-a1a1-a30e19e6c3ed@amd.com>
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



On 2/4/25 12:22, Michal Simek wrote:
> 
> 
> On 2/3/25 16:03, Michal Simek wrote:
>> LWIP wget.c/mbedtls_hardware_poll() is calling dm_rng_read() but dependency
>> is not recorded anywhere that's why select DM_RNG when LWIP stack i used.
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
>>
>>   net/Kconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/net/Kconfig b/net/Kconfig
>> index 24508026200d..6c684624fd6f 100644
>> --- a/net/Kconfig
>> +++ b/net/Kconfig
>> @@ -249,6 +249,7 @@ config WGET
>>       select PROT_TCP if NET
>>       select PROT_TCP_LWIP if NET_LWIP
>>       select PROT_DNS_LWIP if NET_LWIP
>> +    select DM_RNG if NET_LWIP
>>       help
>>         Selecting this will enable wget, an interface to send HTTP requests
>>         via the network stack.
> 
> Just a summary. Jerome and Ilias will look at solving this dependency in C file not to have this dependency listed. WGET will work without RNG device but HTTPS won't work. There is also connection to MBEDTLS which will be handled.
> 
> Thanks,
> Michal

Superseded by https://lists.denx.de/pipermail/u-boot/2025-February/579396.html.

Thanks,
-- 
Jerome
