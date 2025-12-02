Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F980CFD2F6
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 10:02:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDFBC83E3A;
	Tue,  2 Dec 2025 11:02:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="LprNscmh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9771D83E40; Tue,  2 Dec 2025 11:02:09 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 321FB83E28
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 11:02:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5258D3F5D1
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 10:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1764669724;
 bh=6f5Hss0ndulqzZv3Big0KinZ3+t9C9iQ3UQStfZixvM=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=LprNscmhADzXXYdqVc9QpxzmRGwPw9emNb/w5bAPj8jNysjOMhvJ9a4KPP1Iwdx8n
 Zhze7YanAqbi8KGDpaNWTb7Bn3lM/byIjeBFBbh9/kR4+b1mLa3k/qXxfnuwQHrTMg
 nXA1yikjYLv74sec82nbR+IMvoc/f+UP2s9gA1b39Bawu9xnZhnOl5QOr3oTQC5kpM
 U6lf4H2M0dzYdZQY1okK1J6N8i9c5c30k51BxLRSbbrD72i2yDQydKknlR1tqJYiXm
 x6dYJ8mdwEGm0YsV+h2dyn2bRd4jjjCQnic6U4EIN5VDezmMj/P9rvnNxQV+PT6yaY
 5H1YFhXwhXJvSIZgrcx46TJpmy3QmNIxhFOZm6EJdqLxmltEMFmkoU4Cak/Drnu7Z1
 m9eA9EDTaWgrmuBS3xTRVDLRi8ZsHXiH5ZH5kSlkg7pItMU8dd3JSykHdTFQbs9Yq1
 YESCf7Og+tO++1PeAospIQ7ELmUJel4FriezQvuSmKYzu48drYTxnGhvvfDKX/ihAn
 XAcgwu6VDjD4Qcs7tjlxr77X5ozy7Oeykwvgn+LI3C6WjzQfD1qGzwveCmUJQzvgEy
 OppmSnyjVEiLg0ZgTjBx3pkekz5U6gxfNyUQtPZe2eoFq38iJHZFtBHLYUrgcIHaUv
 MUL9UDZfIuy1bRcbKUk+IzPw=
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47799717212so38429925e9.3
 for <u-boot@lists.denx.de>; Tue, 02 Dec 2025 02:02:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764669724; x=1765274524;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6f5Hss0ndulqzZv3Big0KinZ3+t9C9iQ3UQStfZixvM=;
 b=Hpz4hpsesNwXkwqwA3mZe7ulFe80/l1xrTfWyOHjfuLD5mMYaclloT3UALReEzviGO
 epco4QoUDF1cZG6CstE3X1AZBLiYx8885xGxPbLrXkOJKAFUyx/fUIACayPqBB7zu9Ck
 THH1PtsFfum00f2IOd1DjJedqDvXrftwWwbgUWz+vjhSObRtjJQkW+QjxI1G1dD8uEKJ
 xEA59fGwx7i2yPJR+ern06BEXENyXsn6SSZ938luFtVwrgJsvf9OiMO4+FR/meaqVpN+
 QZkcf+hvQ7Mlrbab75kwfH75HrIvcXV8OdAfPBDTXu4yFPi9wO+gH6O90RCpAfk789LL
 i0hA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnhyIe7AxFomZ19essxmVX0l1dhe6tRO09hG/xK4VGsJcbWE8OZ2LiDNWJznVo0aHZ6xHXFWQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwACx4XKMNlyWtvV+68E54EtfERZuFiNrYD3NPJiBZrg4v5FgRd
 Tq0hJeM7VaDST1ut2HegeEexPG7jb8JFjL4tKoPkWPWI0hYm+qKghUrNjHukQoLOK3ktT8+2Wlt
 ISU/ju3BrCKj4isMPdArWZV5YOAIiyh3Gt7WgaQgP21C25SY4RW2LrQu1hcg87++/MadryCUooE
 Fp/AE=
X-Gm-Gg: ASbGncs50p53RAG24+0N+VugrW95/GPl7et/eeal3+ou6jp+1yOZniZVRwQHQNVohOf
 8Y1tqQIF0ByutW196b5qGTbSkzydU9doqwluV0pQfFSj5UYJa3WrkyfkYCp3LGLNYpUVJpDZmrc
 0i/mYMI7ieNQmAFKV/7O/o3h5ERZUwkmdPzpfJl4T48aoxueFQrjDw3mcOcni9Ej8BZZgsx809M
 6jxJh9ZEzqt3gzEHV0iSY7U0u4h9QgYGJu4RQx1i8h2Kgh1WrxcB+zUNa5gqeZ52X9I7OgelzKQ
 8fCXz10CwVhqAvrd/cxwKNC7rIR+UrUgV68/iejglEOycKxNCAa7qQQF+BewhtKci/h1a7TJYSL
 GnNW1CxpWxvw0OdlCERoz7u2IsfzWuGeAAcHq2t7bf7Cq9mbxTouzKnGur9G96pihTHBSNKwIMn
 KipNjgtJo=
X-Received: by 2002:a05:600c:1f0f:b0:477:8b2e:aa7d with SMTP id
 5b1f17b1804b1-477c1132bf2mr412752575e9.30.1764669723763; 
 Tue, 02 Dec 2025 02:02:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFyrxAX6BfZfEavCTLTITpXj2LJNycQDWbmOFpyepoJmIvzNIcXQkJEkZst/1+XgA9bpddSXA==
X-Received: by 2002:a05:600c:1f0f:b0:477:8b2e:aa7d with SMTP id
 5b1f17b1804b1-477c1132bf2mr412752105e9.30.1764669723285; 
 Tue, 02 Dec 2025 02:02:03 -0800 (PST)
Received: from [192.168.103.123]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4790ade13ddsm348557825e9.8.2025.12.02.02.02.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Dec 2025 02:02:02 -0800 (PST)
Message-ID: <67d09f48-20f3-4ab5-8739-862efc2da6cf@canonical.com>
Date: Tue, 2 Dec 2025 11:02:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] RISC-V: implement private GCC library
To: Icenowy Zheng <uwu@icenowy.me>
Cc: E Shattow <e@freeshell.de>, Hal Feng <hal.feng@starfivetech.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Minda Chen <minda.chen@starfivetech.com>, u-boot@lists.denx.de,
 Yao Zi <ziyao@disroot.org>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>
References: <20251201174904.652954-1-heinrich.schuchardt@canonical.com>
 <20251201174904.652954-2-heinrich.schuchardt@canonical.com>
 <aS5jmyp_VanBqY6h@pie>
 <33d528eff4e6453fdd8d442866e6af2544c7c9ad.camel@icenowy.me>
 <0fb06358-cbed-4613-b9fd-b21962b2c0be@canonical.com>
 <ae7181d47cdec3deca43d19b899ba27acddfa982.camel@icenowy.me>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <ae7181d47cdec3deca43d19b899ba27acddfa982.camel@icenowy.me>
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

On 12/2/25 08:03, Icenowy Zheng wrote:
> 在 2025-12-02星期二的 07:15 +0100，Heinrich Schuchardt写道：
>> On 12/2/25 06:28, Icenowy Zheng wrote:
>>> 在 2025-12-02星期二的 03:57 +0000，Yao Zi写道：
>>>> On Mon, Dec 01, 2025 at 06:49:03PM +0100, Heinrich Schuchardt
>>>> wrote:
>>>>> The following functions are provided:
>>>>>
>>>>> Count leading zero bits
>>>>>
>>>>> * int __clzsi2 (unsigned int a)
>>>>> * int __clzdi2 (unsigned long a)
>>>>> * int __clzti2 (unsigned long long a)
>>>>>
>>>>> Count trailing zero bits
>>>>>
>>>>> * int __ctzsi2 (unsigned int a)
>>>>> * int __ctzdi2 (unsigned long a)
>>>>> * int __ctzti2 (unsigned long long a)
>>>>>
>>>>> Signed-off-by: Heinrich Schuchardt
>>>>> <heinrich.schuchardt@canonical.com>
>>>>> ---
>>>>
>>>> I noted there's another series with the same subject[1] sent
>>>> almost
>>>> at
>>>> the same time, and I couldn't tell the difference at the first
>>>> glance.
>>>> Is this an incident?
>>>>
>>>>>    arch/Kconfig            |   1 +
>>>>>    arch/riscv/lib/Makefile |   2 +
>>>>>    arch/riscv/lib/clz.c    | 105
>>>>> ++++++++++++++++++++++++++++++++++++++++
>>>>>    arch/riscv/lib/ctz.c    |  95
>>>>> ++++++++++++++++++++++++++++++++++++
>>>>>    lib/Kconfig             |   2 +-
>>>>>    5 files changed, 204 insertions(+), 1 deletion(-)
>>>>>    create mode 100644 arch/riscv/lib/clz.c
>>>>>    create mode 100644 arch/riscv/lib/ctz.c
>>>>>
>>>>> diff --git a/arch/Kconfig b/arch/Kconfig
>>>>> index 3133f892f94..4af0da2485f 100644
>>>>> --- a/arch/Kconfig
>>>>> +++ b/arch/Kconfig
>>>>> @@ -159,6 +159,7 @@ config PPC
>>>>>    config RISCV
>>>>>           bool "RISC-V architecture"
>>>>>           select CREATE_ARCH_SYMLINK
>>>>> +       select HAVE_PRIVATE_LIBGCC if 64BIT
>>>>
>>>> Are 32-bit platforms excluded for lacking of enough library
>>>> functions?
>>
>> Yes. See
>> https://lore.kernel.org/u-boot/20251201174904.652954-1-heinrich.schuchardt@canonical.com/T/#mbf44c9f5073649bbf2e1368ffbeaec82680a268d
>>
>>>> Should we exclude !RISCV_ISA_F || !RISCV_ISA_D platforms as well?
>>>> Though
>>
>> libgcc.a as provided by distros assumes that you have the D and F
>> extensions. Either a specific libgcc.a will be needed or we will have
>> to
>> implement the missing functions in the private lib if such platforms.
>>
>> It would make more sense to set CONFIG_USE_PRIVATE_LIBGCC=n for such
>> platforms than setting CONFIG_HAVE_PRIVATE_LIBGCC=n.
>>
>> Which way we want to go can be decided when such platforms arrive.
>>
>>>> there's no in-tree 64-bit port without F/D extension.
>>>
>>> The S7 core in U74-MC complex seems to have only IMAC, no F/D.
>> The S7 core is not supported by U-Boot.

https://starfivetech.com/uploads/u74_core_complex_manual_21G1.pdf
talks of U7 and has "The U7 FPU provides full hardware support for the 
IEEE 754-2008 floating-point standard for 32-bit single-precision and 
64-bit double-precision arithmetic."

https://www.sifive.com/document-file/freedom-u740-c000-manual mentions: 
"The S7 RISC‑V Core supports the RV64IMAC extension string."

The main user of floating point variables in U-Boot is the TrueType 
library. I guess without TrueType you will not be using the floating 
point unit

> 
> Well at least SPL is run on the S7 cores, although the SBI should keep
> the S7 core from being running main U-Boot.

On the Unmatched board the HSM extension reports the S7 hart of the 
Unmatched board as stopped.

Harts:
   0: stopped
   1: started
   2: stopped
   3: stopped
   4: stopped

But it seems that the SBI API does not allow to determine if a hart 
actually has entered OpenSBI.

qemu-riscv64_smode_defconfig can be booted with
-cpu rv64,zfa=off,f=off,d=off

Best regards

Heinrich
>>>
>>>>
>>>>>           select HAVE_SETJMP
>>>>>           select HAVE_INITJMP
>>>>>           select SUPPORT_ACPI
>>>>
>>>> Regards,
>>>> Yao Zi
>>>>
>>>> [1]:
>>>> https://lore.kernel.org/u-boot/20251201174705.652626-1-zfsdt@canonical.com/
>>>
>>
> 

