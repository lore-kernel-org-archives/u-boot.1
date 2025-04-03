Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFFA7C3600C
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 12:47:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F2158205B;
	Thu,  3 Apr 2025 14:47:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nsHMTOB+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2EDE82063; Thu,  3 Apr 2025 14:47:50 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DF2882045
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 14:47:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43cf257158fso5433745e9.2
 for <u-boot@lists.denx.de>; Thu, 03 Apr 2025 05:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743684468; x=1744289268; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ukowvy+6MCsPt7P62xlbGxOyHdyyhoQDnUjqgXuaqyc=;
 b=nsHMTOB+7GBC0Ca5vnGBcUUCqdWtCPM2O7MIMp0E0lxvr8CZ2y8wp56ZCCqxkgksIS
 YQI5jIDZlABUKFjHszzRa9Bn3VvVXNX5f1sVzg47IOSQf0+7KiWosDI8rbSpu954OcHh
 dW0uBnVFF26p3oUOtoDyIQ9Wqy78PlZl9WUOFa1tN7weVYJHdWJ5WLic0qwPt6qFuNwR
 sEpp2Ezq3JlEFzjfsHFFkfS+2PP//UhP5oJEdkXL+kqJowcxevg7MA2OTsdsCmcO8uMr
 KcBywarPPC2CrLKYAyJBoDqcvD0A1xt0q6DFtcOvDbSNHKbETT+OdCs9nzlKkH/5X+pu
 W+kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743684468; x=1744289268;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ukowvy+6MCsPt7P62xlbGxOyHdyyhoQDnUjqgXuaqyc=;
 b=ZPHMBNzNDRxtDF87mHCDETE5K2/jClwdJT4gt/KspF7vu5/NmyplqRVpT6NukxP48N
 PYR0ioCNIG2MW+b0kE0TbkzDnGWsUmY/qhAf6klXipKsRheB6SFpYHHOh+EeqlUvrBbP
 vkO/lEOTFhM1uNVjJuidnNmvrn+f/dhv1HW46pTDjbOCS+lmiaDue9C2rL4dL9hbsRfv
 3ZjAgl0Vs9XFTsMqqKC2hVprKdeBuOWsKpG3HSjWNCfRX8and+p+8zw+HnxjFeJhhP+b
 P+2DFvGwzgjFPp1mp4fE2ii19Je5adkP6H43+G2O82ybjxCWJfIkFERM0pxAHJFmcbJ0
 AiiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYODzEJV/JrzukKvcMCU9lAiqXKl1aytwjMo3AWG+W0Y1fl0UazMZiPN+OFG1ZCqAmUf0eZrE=@lists.denx.de
X-Gm-Message-State: AOJu0YxI8FZcWTVGg5YC9stkmRztPScsVesqINZWdpD62WaOUlLQEF/X
 3m2VDr66u8xzKefODQ8QjblCMUwsKlTIjr4i8SkLlR7/N89Q/P+osEOAeZg73qg=
X-Gm-Gg: ASbGncvwx/cjvZfRaeZZFsSuSdRjmGKWC0WHk/wdH9vDDGnxQr07D5tPakfqvURmWMb
 ERPnsxhwf9+cdgcu2Dhpb1vZS2U9hg32VBIqeZdN+vPDn0+/jJXOWASd/pK/oMObnSJfj0Q7mzy
 rTZ3JHS8XRRsPtJj70VeVyV5RpL1jeUx9qlB6WpgRU8tO9o3EeY6xidojARwwefCZ7Wd3JUOYyb
 kJS3dIAVq3TBvLZ7bwmZHLXdQKJEaExrZnsEBwCNBbbO+gwLZOtzkrgyvdjQEaOslm8nMz9bUxd
 YPygVqcfTq9d0Yxdl52kLXiGeOpF0XYIUzhJmqmAbJqzogwLZdV3Bh1BXt6b/nYKNghIqcDEKf9
 NIPZ5MZ3l5Fg=
X-Google-Smtp-Source: AGHT+IFlnMBWCn1r3YHyncd/7Pdc9EIsrqHgEo6wjT08gHXkQfI8u392I1H7bZRxlUfNEc9X8rK+gg==
X-Received: by 2002:a05:600c:35c8:b0:43d:db5:7b1a with SMTP id
 5b1f17b1804b1-43ec139c2c6mr25819185e9.12.1743684467823; 
 Thu, 03 Apr 2025 05:47:47 -0700 (PDT)
Received: from [192.168.1.47] (167-60-142-46.pool.kielnet.net. [46.142.60.167])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ea8d16d35sm58792745e9.0.2025.04.03.05.47.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Apr 2025 05:47:46 -0700 (PDT)
Message-ID: <bade55c2-e34c-4871-bd6e-07a6dc818734@linaro.org>
Date: Thu, 3 Apr 2025 14:47:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] mach-snapdragon: CapsuleUpdate: support all boot
 methods
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
References: <20250326-b4-qcom-capsule-update-improvements-v1-0-afe2e3696675@linaro.org>
 <20250326-b4-qcom-capsule-update-improvements-v1-2-afe2e3696675@linaro.org>
 <CAC_iWjKSFkuHCBFHcd04m7mz+33EbsmPWvSX6+u2Pvo=3nwy5w@mail.gmail.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAC_iWjKSFkuHCBFHcd04m7mz+33EbsmPWvSX6+u2Pvo=3nwy5w@mail.gmail.com>
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



On 4/1/25 14:42, Ilias Apalodimas wrote:
> Hi Caleb
> 
> On Wed, 26 Mar 2025 at 19:41, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>
>> Expand capsule update support to correctly identify which partition
>> U-Boot is flashed to (between xbl, uefi, and boot including A/B
>> variants).
>>
>> Use qcom_boot_source to determine if we were chainloaded from ABL,
>> meaning U-Boot is on the boot partition, otherwise we assume uefi if
>> it's available, finally leaving the xbl partition.
>>
>> Set a different fw_name based on the target partition to prevent GUID
>> collisions, since a board may support U-Boot flashed to boot or XBL we
>> need to differentiate them since the U-Boot binary must be built
>> differently.
>>
> 
> [...]
> 
> 
>> -               if (!strncmp(info.name, partname, strlen(partname))) {
>> -                       log_debug("Found active %s partition: '%s'!\n", partname, info.name);
>> -                       strlcpy(name, info.name, sizeof(info.name));
>> -                       return partnum;
>> +               desc = dev_get_uclass_plat(dev);
>> +               if (!desc || desc->part_type == PART_TYPE_UNKNOWN)
>> +                       continue;
>> +               for (partnum = 1;; partnum++) {
>> +                       ret = part_get_info(desc, partnum, &info);
>> +                       if (ret)
>> +                               break;
>> +
>> +                       slot_status = (struct part_slot_status *)&info.type_flags;
>> +
>> +                       /*
>> +                        * Qualcomm Linux devices have a "uefi" partition, it's A/B but the
>> +                        * flags might not be set so we assume the A partition unless the B
>> +                        * partition is active.
>> +                        */
>> +                       if (!strncmp(info.name, "uefi", strlen("uefi")))
> 
> since it's a static string, use sizeof() to compute it at build time.

Ahh nice, I'll do that.

> I get what you are trying to do here and automatically detect the boot
> partition, I'll have a closer look in case we can somehow make this
> loop shorter.
> 
> {
>> +                               /*
>> +                                * If U-Boot was chainloaded somehow we can't be flashed to
>> +                                * the uefi partition
>> +                                */
>> +                               if (qcom_boot_source != QCOM_BOOT_SOURCE_XBL)
>> +                                       continue;
>> +
>> +                               *target_part_type = TARGET_PART_UEFI;
>> +                               /*
>> +                                * Found an active UEFI partition, this is where U-Boot is
>> +                                * flashed.
>> +                                */
>> +                               if (slot_status->active)
>> +                                       goto found;
>> +
>> +                               /* Prefer A slot if it's not marked active */
>> +                               if (get_part_slot(info.name) == SLOT_A) {
> 
> SLOT_NONE only applies to non-uefi partitions?

Yes, having a "uefi" partition is only the case on 2 boards that I'm 
aware of, and both have a/b variants. The xbl and boot partitions exist 
on A/B and non-A/B devices so we have to handle all variants there.
> 
>> +                                       /*
>> +                                        * If we found the A slot after the B slot (both
>> +                                        * inactive) then we assume U-Boot is on the A slot.
>> +                                        */
>> +                                       if (uefi_partnum >= 0)
>> +                                               goto found;
>> +
>> +                                       /* Didn't find the B slot yet */
>> +                                       uefi_partnum = partnum;
>> +                                       strlcpy(ptn_name, info.name, 32);
> 
> sizeof(ptn_name)

Thanks
> 
>> +                               } else {
>> +                                       /*
>> +                                        * Found inactive B slot after inactive A slot, return
>> +                                        * the A slot
>> +                                        */
>> +                                       if (uefi_partnum >= 0) {
>> +                                               partnum = uefi_partnum;
>> +                                               goto found;
>> +                                       }
>> +
>> +                                       /*
>> +                                        * Didn't find the A slot yet. Record that we found the
>> +                                        * B slot
> 
> [...]
> 
> Cheers
> /Ilias

-- 
Caleb (they/them)

