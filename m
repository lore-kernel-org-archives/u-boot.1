Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC4231125811
	for <u-boot@archiver.kernel.org>; Wed, 11 Mar 2026 18:05:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33EA784035;
	Wed, 11 Mar 2026 19:05:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fa02tFfP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C179840DF; Wed, 11 Mar 2026 19:05:54 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33BF384013
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 19:05:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel.schwierzeck@gmail.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4838c15e3cbso1161575e9.3
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 11:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773252351; x=1773857151; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=m6IbQm7IVmYrQcO+DDcMCAnogH5IyhTLbFZusFgPpnc=;
 b=fa02tFfPQoz7fzHCvV310ygbxsvlTEHF0/MggsoXcxHfCZmbJH/o8KtzZpTu5ll/Y+
 Njqms9fTKrTHGqnjXrBEmdM37tC8IxYBqszQYan7tcKNvwTdRg0pJksH7UYYg2Ent8gz
 dYMqwgFtoJ1G2W98flOeV5O/VZjp89WwkuG3NgAoZfPLJkT7q3xlBCvd+N5+X7fYiF4C
 sHaAn5/TkjQdnWsBY/DrWQrhnoKkEoBjPv5kkdLop9QFM11AjQGT+7RJWnJ9MrfN0skl
 80bKoRgQ1z02TNDMNkRpoETIc1yOvTwDA0gF3OrXW+6DFMXBGTTqXh3APp3Zz5L5UwxA
 SExg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773252351; x=1773857151;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m6IbQm7IVmYrQcO+DDcMCAnogH5IyhTLbFZusFgPpnc=;
 b=L/DcddZvfTmcaq2OPF0iMBRQO5pEkbR82pP6My2HNTFYPCYjAkHYrIkshAPkFI7yH4
 LFLOsKQGXSc93xwYv4OH5R8F5lU440qG12AqB69dQ9/ME+fpGCCutdk5UjRfa+iFOOIp
 0BQTkRy11sgBWrfGDgcKQYNp5MU7frobmhcHOSO8pn5RVF+t0PxGirpSoz3n4SNoT9Dg
 zpzwLtzdS/1oFBydtxyQV3be+OiDyjxUnU4QgZEcN0mwrPAw75WsJNZ0A5O09afyyaVD
 Eb6z6hb6h2hyPiO99mDZ5VPqER0GIReE55Tw6/Qv3cqD9ujwW6lD7tst2WqHAiVA9o9O
 X16A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVv8BI1fst751mxiBAxya/1t5NTd6Rbh9JuHmSA0gZAyIU52cADI6YjK3606Z0YIrJef/cwBc8=@lists.denx.de
X-Gm-Message-State: AOJu0YxDvK4bsXiDNA0UGchPPV0FhRXeL5N5hSJfzQbflwqAWILj2SaV
 f0IFwJy66jwUK19VdY2TF2FlgzrwJDF3Bcr9ior2VK2dOwJb3ubRMpTy
X-Gm-Gg: ATEYQzw7vsTwfEqO85Qcysq1+0JsBvCQ30fe+/pbk6nBDZfq5CpBf4NABONmmhV3oN8
 ZqXHZbc+7Y5xLwO8wfzRylYxRPWFbuZcITSU456F1jTHRLZkPCHaqlNSWBHHpriHgcxsC3m9Bvt
 +6WL67J/CjLIHuNXmOugmhouF9wy2KuTrG4yL4Ru46gz2saCJoLcgB2Fi2mEYBR+ET32OGvY9KG
 PNXq8R4CoC4P0HQ2J8VyofXVAK3YYRE+So2kIU50HBM5m4OCzvpmtUvkm/EatAdu9QYWWAheFPQ
 ANUzoovAKbLhyjcYVdInxJXyJ3PGboxzNh0zR2UexZcOWwF7gJbQqXKTYGN0OrjhNI5ZCAbJ+xC
 y5iMhkFW/U5/uIkgIi8YEpvqAOhAwBL6tc3K/JeGkE3OpchEFnlOwrglAnjC3Z6KiZ12RydRh8H
 MGSv6g2fQ83QoWyppZtdJJ3Aeu+adP8qH1L2Ru8ATL2TvAUr2cToxX4YWzPU4FEyUTcGlGwaC4h
 Kw=
X-Received: by 2002:a05:600c:3b18:b0:485:3fe6:2209 with SMTP id
 5b1f17b1804b1-4854b0bdf5dmr61291465e9.11.1773252351477; 
 Wed, 11 Mar 2026 11:05:51 -0700 (PDT)
Received: from ?IPV6:2001:9e8:9a:de10:fba3:eefe:bd9c:fc8c?
 ([2001:9e8:9a:de10:fba3:eefe:bd9c:fc8c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe2273e8sm1045385f8f.33.2026.03.11.11.05.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Mar 2026 11:05:50 -0700 (PDT)
Message-ID: <5450d168-6878-43ab-bc03-c832ba02618e@gmail.com>
Date: Wed, 11 Mar 2026 19:05:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/7] mips: loongson: minimal initial SoC support
To: sgdfkk@163.com, duhuanpeng@139.com, u-boot@lists.denx.de
Cc: chenhuacai@loongson.cn, jiaxun.yang@flygoat.com,
 Du Huanpeng <u74147@gmail.com>
References: <20260311084129.12809-1-sgdfkk@163.com>
 <20260311084129.12809-2-sgdfkk@163.com>
From: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
Content-Language: en-US
In-Reply-To: <20260311084129.12809-2-sgdfkk@163.com>
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



On 3/11/26 09:41, sgdfkk@163.com wrote:
> From: Du Huanpeng <u74147@gmail.com>
> 
> Loongson 1C is a cost-effective SOC chip for industrial control and
> the Internet of Things. The Loongson 1C includes a floating-point
> processing unit, supports multiple types of memory, and supports
> high-capacity MLC NAND Flash. Loongson 1C provides developers with a
> wealth of peripheral interfaces and on-chip modules, including Camera
> controller, USB OTG and USB HOST interfaces, AC97/I2S controller, LCD
> controller, SPI interface, UART interface, etc., providing sufficient
> computing power and multi-application connectivity.
> 
> Some highlights of this SoC are:
> - Single core LS232, MIPS32 instruction set compatible, main frequency
> 300MHZ
> - 16KB data cache and 16KB instruction cache
> - 64 bit float unit, hardware division
> - 8/16 bit SDRAM controller, 45 ~ 133MHz
> - 8/16 bit SRAM, NAND
> - I2S/AC97, LCD, MAC, USB, OTG, SPI, I2C, PWM, CAN, SDIO, ADC
> - 12 UARTs
> 
> Links:
> https://www.loongson.cn/
> 
> introduce base support for the ls1c300 SoC.
> - debug UART2
> - serial console
> - clock
> - watchdog
> - sysreset
> - uart
> 
> Signed-off-by: Du Huanpeng <u74147@gmail.com>
> ---
>   MAINTAINERS                              |  9 ++++
>   arch/mips/Kconfig                        | 11 ++++
>   arch/mips/Makefile                       |  1 +
>   arch/mips/mach-loongson/Kconfig          | 69 ++++++++++++++++++++++++
>   arch/mips/mach-loongson/Makefile         |  6 +++
>   arch/mips/mach-loongson/cpu.c            | 19 +++++++
>   arch/mips/mach-loongson/ls1c300/Makefile |  7 +++
>   arch/mips/mach-loongson/ls1c300/init.c   | 61 +++++++++++++++++++++
>   arch/mips/mach-loongson/spl.c            | 46 ++++++++++++++++
>   9 files changed, 229 insertions(+)
>   create mode 100644 arch/mips/mach-loongson/Kconfig
>   create mode 100644 arch/mips/mach-loongson/Makefile
>   create mode 100644 arch/mips/mach-loongson/cpu.c
>   create mode 100644 arch/mips/mach-loongson/ls1c300/Makefile
>   create mode 100644 arch/mips/mach-loongson/ls1c300/init.c
>   create mode 100644 arch/mips/mach-loongson/spl.c
> 

Reviewed-by: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>

-- 
- Daniel

