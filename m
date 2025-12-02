Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30C09CFD2F6
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 04:59:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95DE183DCA;
	Tue,  2 Dec 2025 05:59:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="EvQ+cauL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 739F183DDD; Tue,  2 Dec 2025 05:59:39 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 127C183D9F
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 05:59:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C90EF3F278
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 04:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1764651575;
 bh=pna7Os2iEGEE10bRAq+dbKdmWvWHhvmwQP4VXcuSSYw=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=EvQ+cauLyUKBtdCzzGpSFgY2amjOEb2e9/WrGqrQZYCSpIyX+EA/gVdZodQ7k22yX
 DdwnQpg4vIzN6eAkgXjGyk0if8pc40/7mARNAcTMcBuVurJXGIMafq+usblpcgL//1
 8uC7AUUQk2CEzmIbyJS95zCuqo53ul4HGsvGkm0ll68CLrNxDtWMCyprlbrcKqWj7d
 j41XXGPQtlE6p6XYTSmgq9deImHgz3qXSRJu09kW8lg65/oJ8VxbCkY6Lik1elJyI+
 1rEG7TKSSEtkdYM+4StXf09KhOEC8eZEssqjjqBHxGysu4H61CPmKeXJzQ4I+r+tXO
 zFlRJmGdwg0Pg11B06S8xFQU3VTlemParvfD6RAYoINP+gZuRh2fZxu4ITVoyvcj5j
 76DRyjaqT97u7USKvEPc1phYZFRo/Mt8p7nERkUP2TN3ce8St+3x8DJ82AJgGksy7R
 ntVFEIHV6QZ6RthkTaVuxR1LyDY01M4qlHyEWf6r98ToEVX8ut5wfmQQ0pinKQ6BEj
 oVk+yjXk50ZcRbi6f/DMum5nRMhi0gc22uZLvu0/gWUh2+97LO9d453fSjGlB/uDI2
 9U+2tHvkbf+NyO7vxUTC/VknGkosTsOKFmeiEGFNsvGeHWETIoKKx7V15L11s71b8n
 d1ZNSBwZcPP34iap2K6vKz6Y=
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47788165c97so35308995e9.0
 for <u-boot@lists.denx.de>; Mon, 01 Dec 2025 20:59:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764651575; x=1765256375;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pna7Os2iEGEE10bRAq+dbKdmWvWHhvmwQP4VXcuSSYw=;
 b=W66Qe1X+6J6XLM7H4Cr806QaYKOUE4RrQpuinyAM6NxwuFPSt509l4MdMCYVBFED5A
 8oWIyeRk/l3i/nxVseJdMZsxfLuoASrB7abfAACbHHM1kyyzar/dpb81s7h5ZtVrEHcP
 /Ikbumhy123/XKRXxep0BoZrAgK4M0yTlzTSPkxBHa8Zmk8wZfVF0ozlVYFvF9S5+UYZ
 +IJdJo5dq6A1bAqTabq50P83AhUgyyBwBUada8iACInGnw+4VG8hb6Upvh+zcQaCyTs5
 5LjlLy/lmY8EzbmWASPRQUWyOZYCt7tnhnpT6HnkFdK9cbHU5NG+OctlzBh/0aoo0DGP
 zJAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXma/MCKknWjhGmymAwsmLxLwzMpg6GXucHUY8RLMEHDC6eBTO846QxfAMciw8HUbR5XyUgQ+Q=@lists.denx.de
X-Gm-Message-State: AOJu0Yw9JysDxxaZfOWuMbxm9EjqPvWqw0RIdI+kes+Qg/gK9r2iP8LB
 eTAX5J2l00FlYWOgLumor25P121+AEFfkI6ApWdNtzuc8avWL8Yy1I/z6FYaaN28CSh62oBBtMl
 fn08U3eZN/ggxXuEcpwMPU8JugznIbrCQkOH/6P5szzUokMxyHxt6Bz+kgPhqQlvgm/hDqhQ=
X-Gm-Gg: ASbGnctoOiWrlAxDe3BnYW0fH/kB2CPo6zttUdMI3hhQ7eMP59O+Z3tnxQc3Q8d6mEX
 /MQHs2HoW4OiA3BpRHBPBu2hYBlRtDedtaYLieCM4X9GQpmoStHyex1gd8CTyh5GKNF+OMc9z6/
 mRkGv3+OM3TnWSTzuGZiKOqwrEFsVT2bex4lUaLZyI6eMZC9ZFpPH6kLcYBkMrwfyS+n3w/wJ4n
 w/K5luSRD2oZ9HAYuG5qBR84tVuprzKUCM69PuhhVbxx9w4ymrnn4QrnRNgyxxcV/i5jyYSUfWd
 xun5i5N4X2V66vv8WyurRfmJKCezH1ANNSz0wNNqH/IzgcM7CMjbQ6nibGF/v08JJ87FJFP7Q94
 UWhbbfjiP5xIrxGf7V2wb4lzPwg0iGaVrVARdllyh+aW17zWvO31lxNun8UIVfzzRb8FJrUEelF
 D6yIxazd0=
X-Received: by 2002:a05:600c:45cf:b0:477:8ba7:fe0a with SMTP id
 5b1f17b1804b1-477c01c001bmr462155685e9.24.1764651575350; 
 Mon, 01 Dec 2025 20:59:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGOFPeCF+ZlZaLSqGQfIC2zrmZZJ8oLqn2raY3G/siyLJua6YxpEwH0jL7cv2/51Zuh8KF5MA==
X-Received: by 2002:a05:600c:45cf:b0:477:8ba7:fe0a with SMTP id
 5b1f17b1804b1-477c01c001bmr462155595e9.24.1764651574978; 
 Mon, 01 Dec 2025 20:59:34 -0800 (PST)
Received: from [192.168.123.154]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47927a1944esm4409325e9.5.2025.12.01.20.59.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Dec 2025 20:59:34 -0800 (PST)
Message-ID: <7ed5d25b-c9ad-4b6c-8e5d-662290aede1d@canonical.com>
Date: Tue, 2 Dec 2025 05:59:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] RISC-V: implement private GCC library
To: Yao Zi <ziyao@disroot.org>
Cc: E Shattow <e@freeshell.de>, Hal Feng <hal.feng@starfivetech.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Minda Chen <minda.chen@starfivetech.com>, u-boot@lists.denx.de,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>
References: <20251201174904.652954-1-heinrich.schuchardt@canonical.com>
 <20251201174904.652954-2-heinrich.schuchardt@canonical.com>
 <aS5jmyp_VanBqY6h@pie>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <aS5jmyp_VanBqY6h@pie>
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

On 12/2/25 04:57, Yao Zi wrote:
> On Mon, Dec 01, 2025 at 06:49:03PM +0100, Heinrich Schuchardt wrote:
>> The following functions are provided:
>>
>> Count leading zero bits
>>
>> * int __clzsi2 (unsigned int a)
>> * int __clzdi2 (unsigned long a)
>> * int __clzti2 (unsigned long long a)
>>
>> Count trailing zero bits
>>
>> * int __ctzsi2 (unsigned int a)
>> * int __ctzdi2 (unsigned long a)
>> * int __ctzti2 (unsigned long long a)
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
> 
> I noted there's another series with the same subject[1] sent almost at
> the same time, and I couldn't tell the difference at the first glance.
> Is this an incident?

Thank you for reviewing.

That was my mistake. I have set the first mail series [1] to superseded 
in Patchwork.

> 
>>   arch/Kconfig            |   1 +
>>   arch/riscv/lib/Makefile |   2 +
>>   arch/riscv/lib/clz.c    | 105 ++++++++++++++++++++++++++++++++++++++++
>>   arch/riscv/lib/ctz.c    |  95 ++++++++++++++++++++++++++++++++++++
>>   lib/Kconfig             |   2 +-
>>   5 files changed, 204 insertions(+), 1 deletion(-)
>>   create mode 100644 arch/riscv/lib/clz.c
>>   create mode 100644 arch/riscv/lib/ctz.c
>>
>> diff --git a/arch/Kconfig b/arch/Kconfig
>> index 3133f892f94..4af0da2485f 100644
>> --- a/arch/Kconfig
>> +++ b/arch/Kconfig
>> @@ -159,6 +159,7 @@ config PPC
>>   config RISCV
>>   	bool "RISC-V architecture"
>>   	select CREATE_ARCH_SYMLINK
>> +	select HAVE_PRIVATE_LIBGCC if 64BIT
> 
> Are 32-bit platforms excluded for lacking of enough library functions?
> Should we exclude !RISCV_ISA_F || !RISCV_ISA_D platforms as well? Though
> there's no in-tree 64-bit port without F/D extension.

As I am not aware of any RVA23 distro for 32bit RISC-V, I see no current 
need.

32-bit support will require additionally implementing __ashldi3, 
__lshldi3, __udivdi3.

If you want to implement these extra functions, you cannot trust the 
documentation. The functions don't take the arguments described in 
https://gcc.gnu.org/onlinedocs/gccint/Integer-library-routines.html. E.g 
__ashldi3 expects a 64 bit value passed in registers a0 (low bits), a1 
(high bits) while the shift is passed in a2. 32-bit __udivdi3 expects 
two 64-bit values.

See 
https://github.com/gcc-mirror/gcc/blob/addda4a7e8593c37c90eb4c1d7edda29fa4bde31/libgcc/libgcc2.c#L412

libgcc is published under GPL-3 and therefore we cannot simply copy that 
code into our GPL-2 project.

Best regards

Heinrich

> 
>>   	select HAVE_SETJMP
>>   	select HAVE_INITJMP
>>   	select SUPPORT_ACPI
> 
> Regards,
> Yao Zi
> 
> [1]: https://lore.kernel.org/u-boot/20251201174705.652626-1-zfsdt@canonical.com/

