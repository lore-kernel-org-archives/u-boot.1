Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEC94C3065A
	for <u-boot@archiver.kernel.org>; Mon,  1 Jul 2024 15:01:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED2B6886A0;
	Mon,  1 Jul 2024 17:01:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="y8ioLW8P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 942378866B; Mon,  1 Jul 2024 17:01:34 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56BD7886A0
 for <u-boot@lists.denx.de>; Mon,  1 Jul 2024 17:01:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-52cdbc20faeso4479344e87.1
 for <u-boot@lists.denx.de>; Mon, 01 Jul 2024 08:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719846089; x=1720450889; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jQTaA9wgQTqop3uWpviwV+AueZrG8MEG6NSssolQHYE=;
 b=y8ioLW8PIBcmSDcVStku9ifgP1IVpB2rNujhZ2bFwgTem3jVyfSTKsOWYlIZoDZl0X
 BhBEcXUrMxRzibWAP6HuzcWdnZ9UA1a7iIwOn6/PvZk4GZ4WW2TloArdlBUTOoeQd5Du
 mSZ30nwJlSW54lWGdcFBpCW+VkYRaH2UAI8PbcBfvLXSPL8HZsbOVwv9SnPDmWNKN9OM
 ehnrYf0ml/rvMoLKdhWlUI3LPcwWupeqntfyx0Ymp0wt3xP0X/IFKKz8HHPaCkKBI5Cz
 nRgQGxSkQOvKsn1ThedZTRvwxgMen48GWgOeD4WNCwqWfeVUVgVLvTYwY/OcFQzWCWk4
 /OPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719846089; x=1720450889;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jQTaA9wgQTqop3uWpviwV+AueZrG8MEG6NSssolQHYE=;
 b=WEA1tljX/Xx7LQJLEXe/iMjBexyvkPU0pbip/TCQYDH3lDxzMUwn4q6SheuKN3DDBu
 h1feF78vpx6wx9M0/MeKir2lP9abu7Y+bCzwPEKFhE4CHbYnNfssuGStF68ev/C8U1hU
 64XYeHupWfd5nKmA2YbLlpA+B4qfp/dC/MFXJRBvifg+wxFG7wcyQk9y7QADI3yPASny
 Bzex3giasIKBA9K9D7qN97NZJZxRLoCqtMQqOBqAssIANh35KrL3DPekNA/yGHd7TG5k
 rPxJLdyge+0aL2IUoHW4ct9u1vBSgnGhu0b+Fkmk/rZ/4XuXJwULybXGYeLgVrqsLJ1b
 3QAA==
X-Gm-Message-State: AOJu0Yyd91RcplDMvr8IZlVmheTl+HsCQ2IcZCvm69mtmbpd6A7gKdhG
 9/X9HyVNrSp9axILGR+CYjVYboRi+FEMRNBrytol5JSVJoiTYU3hwCk7pjxfOGA=
X-Google-Smtp-Source: AGHT+IFVEKeCENkAT1ZMufkBwYNXeEgCMXk49UYWr8s4cxd5k0qTKFy5y2XJ0Kqw5M9M5BM/HhkXQw==
X-Received: by 2002:a05:6512:3b12:b0:52c:e17c:3753 with SMTP id
 2adb3069b0e04-52e82647353mr3859005e87.5.1719846089069; 
 Mon, 01 Jul 2024 08:01:29 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:ea8:cd01:2a82:217:96f3:c43e?
 ([2a0a:ef40:ea8:cd01:2a82:217:96f3:c43e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0cd4a1sm10280883f8f.23.2024.07.01.08.01.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jul 2024 08:01:28 -0700 (PDT)
Message-ID: <230eedde-87bd-4625-b258-a345427b659c@linaro.org>
Date: Mon, 1 Jul 2024 16:01:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sandbox: Fix LTO to work with STACKPROTECTOR
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
References: <20240624092900.2108175-1-andrew.goodbody@linaro.org>
 <CAFLszTg1HmMT-Lzv2aUEmG-jHr0gOAScpdk2RbDueCu_bCnKvw@mail.gmail.com>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <CAFLszTg1HmMT-Lzv2aUEmG-jHr0gOAScpdk2RbDueCu_bCnKvw@mail.gmail.com>
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

On 01/07/2024 14:57, Simon Glass wrote:
> Hi Andrew,
> 
> On Mon, 24 Jun 2024 at 10:29, Andrew Goodbody
> <andrew.goodbody@linaro.org> wrote:
>>
>> Add the STACKPROTECTOR symbols to the script that generates the
>> symbols that should not be removed by the use of LTO when linking
>> a shared object. This prevents a fail to build due to link errors.
>>
>> https://source.denx.de/u-boot/u-boot/-/issues/35
>>
>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>> ---
>>
>>   scripts/gen_ll_addressable_symbols.sh | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/scripts/gen_ll_addressable_symbols.sh b/scripts/gen_ll_addressable_symbols.sh
>> index d0864804aa..ebf89b04bf 100755
>> --- a/scripts/gen_ll_addressable_symbols.sh
>> +++ b/scripts/gen_ll_addressable_symbols.sh
>> @@ -13,3 +13,5 @@ set -e
>>   echo '#include <common.h>'
>>   $@ 2>/dev/null | grep -oe '_u_boot_list_2_[a-zA-Z0-9_]*_2_[a-zA-Z0-9_]*' | \
>>          sort -u | sed -e 's/^\(.*\)/extern char \1[];\n__ADDRESSABLE(\1);/'
>> +$@ 2>/dev/null | grep -oe '__stack_chk_.*' | \
>> +       sort -u | sed -e 's/^\(.*\)/extern char \1[];\n__ADDRESSABLE(\1);/'
>> --
> 
> It is OK to add these new ones, but here you seem to be adding lots of
> other things also. So far we are only allowing linker lists. So can
> you update this to allow just linker lists and stack_chk? Perhaps
> egrep (_u_boot_list_2_|__stack_chk_) or similar?
> 
> Regards,
> Simon

I am sorry but I do not follow you here. I am not sure what you mean by 
'linker lists'. The script is matching on symbols from object files as 
output by nm. I have not changed that original match expression.

My addition only adds the following 3 symbols to the output of 
gen_ll_addressable_symbols.sh

__stack_chk_guard
__stack_chk_fail
__stack_chk_fail_local

These all come from the same file, common/stackprot.c

I can reduce the match to just search for '__stack_chk_guard' and that 
still works and I can put that as another expression in the grep instead 
of doing the whole nm | grep | sort | sed thing a second time. Would 
that address your concerns?

Thanks,
Andrew
