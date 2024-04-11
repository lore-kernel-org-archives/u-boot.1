Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57B35CD1284
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 08:37:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAC1088384;
	Thu, 11 Apr 2024 10:37:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="RDBO11PP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 695D48838F; Thu, 11 Apr 2024 10:37:42 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 575ED86FCE
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 10:37:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 768C33F5CF
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 08:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1712824659;
 bh=QaN8XXIPNchqSSXDCYh9r8QryuT71zk3m5J/RKSgqQs=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=RDBO11PPB1Cz+L33RJf2LFGKuB5bsRKuj6sEqscJWy3FjSleACNhH0UwzekpqPWpy
 Tkyc22YZ+ezkO/HVM/YOTIq1lHheLkYsWVAiSkOs3LFuFhZiB7nzfxego5SfdMjQ5g
 B/5SZ4Re55eJcs09LJi6RnuUOOPpQ8PXZpx38cB2u4Mycg2Q+hQwWBppNV4QTasF/r
 Su9r7Z8R4MhC6fMZuZxhtRbNZvnOhk6j5VvvwPBWUDwvALFwvYcOouTCPUuGimm8Kz
 ffurVTgeoH9HvOP502IBxvvAAgmrwkjTrIRykVQbl7AeuYIC9jLcRvgqTvMiQP9/E+
 MBvV9u2ffVSRQ==
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2d87d146022so42713461fa.3
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 01:37:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712824659; x=1713429459;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QaN8XXIPNchqSSXDCYh9r8QryuT71zk3m5J/RKSgqQs=;
 b=Q7UY3C3WRlKPY1nYuVzuwIuBEP56DCeDY5WMagFZiVX28fE6gNYlLkvgxNkavDz/Zz
 h5LSF/4HwAsPxkc1WiDybrFZ7H9RwhDOYXRSTHtDk0DcfakQUSLU1JThbkS2aeTpTz3u
 0D9vmYIYpjJrEyOEe1ymiItxj0D0ZQ8wS7q0VcGXtgbrSrIrEoEOOLMHhIFSOgN3a49S
 T7E8lR4p0h1or9PuwPFEin9+5LEyoFG4WVOX8BRIZluHECGTAlaKYAf8wYeOoZuAwhY1
 K7/p6b4kh0oSiuB7UB614xtCs8vJdEl+/s0mXOmFCcVfHZhpTMGeQR+mjdsfnyeniXdz
 OWRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+RTz3V6mcxkTWA01Lb5nGhO4mIFP/coTRnI6FVbYnsGIpaTCdV5xGs8iBvxnr9xVTsp8j4Cy649SvdZ3tecRrhNLGkA==
X-Gm-Message-State: AOJu0YxW3g/dp7u+WUJ8nHLT1XkTXnFK2FVYxOaCIIBSti2THzfH0Kgg
 PjgYuASd49LGC5+eocXwBwMd+Euyu9pMyoPYxc9iQW5ELGxWKLWT9+eSuToZuii+K5Huq519fd1
 6Ne629e/8gHEod/3XhtwKPcEtApRFcOHg+efTtat9Xi0ArCVnzvx5KAj1ZUuPCVK49k4=
X-Received: by 2002:a2e:bc23:0:b0:2d6:c23f:7dff with SMTP id
 b35-20020a2ebc23000000b002d6c23f7dffmr3903966ljf.44.1712824658933; 
 Thu, 11 Apr 2024 01:37:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBXHwOHxiaMH7bmQ4yhiz8E+8ruwzWHTV+GdL1oM3P4Qwlz724Kii6ITtFAt+iy0Q3c4TlZg==
X-Received: by 2002:a2e:bc23:0:b0:2d6:c23f:7dff with SMTP id
 b35-20020a2ebc23000000b002d6c23f7dffmr3903946ljf.44.1712824658516; 
 Thu, 11 Apr 2024 01:37:38 -0700 (PDT)
Received: from [192.168.123.126]
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 d16-20020adff2d0000000b003418364032asm1216013wrp.112.2024.04.11.01.37.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Apr 2024 01:37:38 -0700 (PDT)
Message-ID: <2ee61041-2fe6-4b3a-96af-f657242ce9a3@canonical.com>
Date: Thu, 11 Apr 2024 10:37:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] clk: sifive: append missing \n to messages
To: Sean Anderson <seanga2@gmail.com>
Cc: Anup Patel <Anup.Patel@wdc.com>, u-boot@lists.denx.de,
 Lukasz Majewski <lukma@denx.de>, Paul Walmsley <paul.walmsley@sifive.com>
References: <20240216163535.275085-1-heinrich.schuchardt@canonical.com>
 <d98c06e7-ba9f-f09b-2f59-f678de6d4b93@gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <d98c06e7-ba9f-f09b-2f59-f678de6d4b93@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 11.04.24 05:13, Sean Anderson wrote:
> On 2/16/24 11:35, Heinrich Schuchardt wrote:
>> If multiple messages are written, line-feeds improve the readability.
>>
>> Fixes: c40b6df87fc0 ("clk: Add SiFive FU540 PRCI clock driver")
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   drivers/clk/analogbits/wrpll-cln28hpc.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/clk/analogbits/wrpll-cln28hpc.c 
>> b/drivers/clk/analogbits/wrpll-cln28hpc.c
>> index a3cb109d357..537c696b727 100644
>> --- a/drivers/clk/analogbits/wrpll-cln28hpc.c
>> +++ b/drivers/clk/analogbits/wrpll-cln28hpc.c
>> @@ -81,7 +81,7 @@ static int __wrpll_calc_filter_range(unsigned long 
>> post_divr_freq)
>>   {
>>       if (post_divr_freq < MIN_POST_DIVR_FREQ ||
>>           post_divr_freq > MAX_POST_DIVR_FREQ) {
>> -        WARN(1, "%s: post-divider reference freq out of range: %lu",
>> +        WARN(1, "%s: post-divider reference freq out of range: %lu\n",
>>                __func__, post_divr_freq);
>>           return -ERANGE;
>>       }
>> @@ -229,7 +229,7 @@ int wrpll_configure_for_rate(struct wrpll_cfg *c, 
>> u32 target_rate,
>>       int range;
>>       if (c->flags == 0) {
>> -        WARN(1, "%s called with uninitialized PLL config", __func__);
>> +        WARN(1, "%s called with uninitialized PLL config\n", __func__);
>>           return -EINVAL;
>>       }
>> @@ -335,7 +335,7 @@ unsigned long wrpll_calc_output_rate(const struct 
>> wrpll_cfg *c,
>>       u64 n;
>>       if (c->flags & WRPLL_FLAGS_EXT_FEEDBACK_MASK) {
>> -        WARN(1, "external feedback mode not yet supported");
>> +        WARN(1, "external feedback mode not yet supported\n");
>>           return ULONG_MAX;
>>       }
> 
> Reviewed-by: Sean Anderson <seanga2@gmail.com>
> 
> But maybe these should be dev_dbg?

The messages look like indicating misconfiguration. So the user should 
see these.

The kernel code also uses WARN() (and also lacks the line-feeds).

CCing Paul as the Linux maintainer and author.

Best regards

Heinrich
