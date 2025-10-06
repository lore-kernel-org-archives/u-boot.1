Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7534ECAC5B8
	for <u-boot@archiver.kernel.org>; Mon,  6 Oct 2025 15:56:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2FD783E16;
	Mon,  6 Oct 2025 17:56:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Aq3rop5Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 531EC83E18; Mon,  6 Oct 2025 17:56:13 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 126ED83DEA
 for <u-boot@lists.denx.de>; Mon,  6 Oct 2025 17:56:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-42557c5cedcso2667039f8f.0
 for <u-boot@lists.denx.de>; Mon, 06 Oct 2025 08:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759766170; x=1760370970; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QsyPDpYwzdWEEUyWol9lZBis6jmRG0lMkBgM+JGdP+o=;
 b=Aq3rop5YsIbaAEIGfsD2lNKXCcLzv4EeNwfDEs2fo97Oj1DMu/DhqF6Vna9YHrPYHV
 xHHkwPyxA9f+LNLUl5JqHSytthJhyGMfaoBpwojybY2Lb+tyxqI3KpSbHCTwlWV6SEaO
 SydeOcjeJ4YfKJyofZu/lq7NY3MCQnYDD7I+BQd4eeGN9D/yW4clIMnaLxCR0mjlR6Lf
 VaojF2j3X/hRFq+m2Gv91OwHr/qPCDjKIAA2KnlQxVvHwqyYgld1lQkfgsvVF84WVYQ0
 eGlP+E2xfRiPnMrmpt4JeS1AUMYdWWETJuJW6Jf5Wjjvt8amai7IgUSKB2TgjElavdiI
 y2ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759766170; x=1760370970;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QsyPDpYwzdWEEUyWol9lZBis6jmRG0lMkBgM+JGdP+o=;
 b=U3i8I1gXr+CD5cqv9pAtKDYUdDNaA+tSM/IccetEvqUJiyLioC3/GXXS99J+VQWYg7
 OUFx1ufYnEebMpp/rytcgvYQRS4jf7/i2pE7T+WPvNmHPQeJF/kewnpV74GoTGpXqihy
 kpu+j5m3/tlL481R70Rh1GixHelxMkZCAov/cReE3PhUVvLnmnKik89HO/yRLT8SvBKx
 kQ/xmN+OOz6lNtyvIBx/IBjKwAyEAc1pnjWEK0qjt3AlJRg4auTyof5UdxHF1Gr0CDjX
 dUoTAym60XZLh4jryXziz0Snl09pkvIhvxAxYdcCljhKPiSm0OYy5spaV4lWJBmKl/kB
 dVpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYeBQM/PnmcKRzY9Okvz90lIHg42onQcdx9EE+04q7OC8EqOwNDaUwobtHMPIOB63q395SoQI=@lists.denx.de
X-Gm-Message-State: AOJu0YzjS8bv1YNSh0A3Jk/yAXg+toJRfkfC9ps9ysAWbwa76bwfxY07
 mVFIWFsTeUxI7Kou44JvAey1o1hJdgARGSYH3HICD+j5J4GSQdi1iib1nAzTU4biFfhmQxNkGaM
 zP7fl
X-Gm-Gg: ASbGncsVBgyjtXY5cDCS1D45tIFe3EG23jNXUWGbnd92YEeQvfOqHjumggqeKELmkFy
 ZJ+pTOZ11Fh7QywGJV8WdzyJUYgO5TOeTZpmzFLQjegX21ZqQGNfVVpq5xD6qRlEscZJD1CWUHA
 20QGtxrycljdnCH4s9udRfV/beI+gJQc2tOF2GX2nwKeg7vMLPeHkEO2q+74/He1wkiKMH5gOWB
 +ugj9U8sgqst2jeTdSdJkpaTeMktYOgINC153ic3HLgIh8CA+YW7nJEj6nGcB/Qu5zYR0Rgfe5X
 mu6pZjpq//K2p0cviTZf1Kc5tH15WK0LjAvvTlzF1OoPtf1SoGHFKRCjiz8Ph3kdaABIaEwV2qC
 jOqzsDd5UzE5/UHxL6qD2LxVj3lLix5SfdJPkv6cME5RIrexuwufsaMQPlFgI5oEOgTcCPp5BC/
 SQ7fp3geJcT58djMF7Rr1tqqbkP4/VdVTO9Cc8tg==
X-Google-Smtp-Source: AGHT+IFeU7hTiba7HUWOWcMO10zAC4gnJS2o6w/lbpm/FnjwswzUqCzXJAR8bmjGrXXvnCDGxnfyhg==
X-Received: by 2002:a05:6000:4285:b0:3e5:5822:ec9d with SMTP id
 ffacd0b85a97d-4256719ea15mr6787288f8f.41.1759766170456; 
 Mon, 06 Oct 2025 08:56:10 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:fed:4601:d8c:ebdc:373e:b4a0?
 ([2a0a:ef40:fed:4601:d8c:ebdc:373e:b4a0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e6118854bsm140242175e9.1.2025.10.06.08.56.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Oct 2025 08:56:10 -0700 (PDT)
Message-ID: <8e8e9b69-3d02-4011-af54-45e470ed2ebd@linaro.org>
Date: Mon, 6 Oct 2025 16:56:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] b4-config: Improve b4 config for correct operation
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <20251001-fix_b4-v1-1-fc515dec0546@linaro.org>
 <cd667b19-ec20-4d4e-8b4e-4c991df4fcd0@cherry.de>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <cd667b19-ec20-4d4e-8b4e-4c991df4fcd0@cherry.de>
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

On 06/10/2025 16:38, Quentin Schulz wrote:
> Hi Andrew, Tom,
> 
> On 10/1/25 11:28 AM, Andrew Goodbody wrote:
>> The recent change to .b4-config resulted in some expected recipients not
>> being added to the address lists. Rework the commands so that all
>> expected recipients are added while maintaining the ordering from the
>> first change.
>>
>> Fixes: 26efc940c86 ("b4-config: configure `b4` for U-Boot")
>>
>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>> ---
>>   .b4-config | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/.b4-config b/.b4-config
>> index 
>> 6ba10cf9b50e6acb8a789544d35a13641e6c0411..1f9ada793e652c99854e4d15241734c9b3bfc117 100644
>> --- a/.b4-config
>> +++ b/.b4-config
>> @@ -2,6 +2,5 @@
>>   # See https://b4.docs.kernel.org/en/latest/config.html
>>   [b4]
>> -    send-series-to = u-boot@lists.denx.de
>> -    send-auto-to-cmd = echo ""
>> -    send-auto-cc-cmd = scripts/get_maintainer.pl
>> +    send-auto-to-cmd = scripts/get_maintainer.pl --nogit --nogit- 
>> fallback --nogit-chief-penguins --norolestats --nom
>> +    send-auto-cc-cmd = scripts/get_maintainer.pl --nogit-fallback -- 
>> nogit-chief-penguins --norolestats --nol
>>
> 
> This seems to differ with b4 defaults[1] by swapping --nom and --nol 
> between to and cc recipients. Is this expected?

Hi Quentin,

Yes this is expected and intended. Please see the discussion here
https://lore.kernel.org/u-boot/20250929160453.GI6093@bill-the-cat/T/#m3d26d2ca4c42d620260fedaeca5f869a41fe26e5
where the original patch
http://patchwork.ozlabs.org/project/uboot/patch/20240717-b4-config-v1-1-0bc9e80ef582@flygoat.com/
attempted to bring the use of b4 into line with U-Boot commit guidelines 
by putting the U-Boot list in To: and maintainers in Cc:.
In the meantime I was getting complaints that my patches were not 
including recent committers in the Cc: list and that patch did not 
address this although at one point I thought it would.
So the current settings now put the list into To: and also add recent 
committers into the Cc: list.

I am not sure where the expectation to Cc: recent committers comes from 
apart from the fact that when you run get_maintainer.pl on the command 
line, then they are listed there.

Andrew

> I've been using b4 for years in U-Boot without a .b4-config so I'm 
> curious why we suddenly have a need for one and I think it'd make sense 
> to document that (now as a comment in .b4-config since this patch has 
> been merged already).
> 
> Cheers,
> Quentin
> 
> [1] https://b4.docs.kernel.org/en/latest/config.html#contributor- 
> oriented-settings

