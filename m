Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EEBFCFD2F6
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 06:15:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6956083DEA;
	Tue,  2 Dec 2025 07:15:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="U1HfbP0+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84E5B83DF2; Tue,  2 Dec 2025 07:15:49 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25C9D83DE0
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 07:15:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6DDC13F4A6
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 06:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1764656140;
 bh=VNOKI2V8euw4UfBHr4VCOdHz+oZFiL1OKbTXmllX4eM=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=U1HfbP0+0Af2h/UZUiYzZwGxnu+WKw6UJlTxZDjkYz5wa718/O2vV2Td24RwvgNTl
 6ROD34bA3FCRCOXZxlunZtdcTeOamvyiCe3UlQukDuQVPCbwH6xxYp0h7Ffhchw6RU
 ZL60dvRb5BORNEjxdd+Ux9Pj1nQ+dCmS+b1OoQfGFQFcArqajDnrvF4Xiw+4WTbVlq
 kD+2uHgj4jmnRJBoHPqakQKVFnqUN9b9Gm/U6Yse62T0IUo5eeIvXHL4bp4qbVm7bv
 JwBE7U1s8HS2yGawNXNDjsGHi/IOoNoK7zMSatIPK6niHnqQrAAAnz6Tqju2amMFtO
 n87H6dC1p3Jh5VV3hSQ+CODOkKWvnHE+OYsLyEXWP1bpVK4NuB5d7aYmdh7limyEpO
 6MHM3aao4SP71l8DoOGDaVHDFOLwFkTTNaBtDC0UeGUszehU7/2eLhg49vFNq/tfOt
 YylXbZ9bGcBcTM+5kaMFL9Av9/LtJai/NyPEQwc6vTMtGLTuB6rg2elpyO/Etm8qFm
 6Ffkk9Zk37wU7RPlxrjp8T3MuWiEnXfk0q7sM0jivKcScCtVT/d3gqnBfAT4Lakbbd
 WIWwlz0klOz/Gt6/Y625svGmn67INftGZjcA/iBmgDtX2sPsBSy8bl/G+s7aBW1wSM
 3AY5g2mX4jhVipV0DqYxtVKI=
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-477a11d9f89so22278955e9.3
 for <u-boot@lists.denx.de>; Mon, 01 Dec 2025 22:15:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764656140; x=1765260940;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VNOKI2V8euw4UfBHr4VCOdHz+oZFiL1OKbTXmllX4eM=;
 b=narJ6aV9FJyIA3iEMfENXdqBiwkMMRW5BIZ2LzTlOGMXlP87Ns48jBWSC9pPptvQO3
 rxbvc5/opR8+WjHX7IQkGMr4T+YHvKFiS55cdFYfp9CzUJnEU5WdwtMa4G0nydewKA24
 GL3YCLEihPnmqB3zUFwSDosVtthytNc/aWTNchqEMvNdZd/CMiBf00vLmCq/aXC5nGlz
 XKc2K/EGQ0G73dQSaBUYugF/fx2w9/ov3oD/VaLvJt4/L1p92WgwI4+fUzXv8Ga07uZa
 rVRJcFgandcRGBhKTGSu4KLxWA/vxVL3Gx0IzvJf0LSCuPW2Tf5HGKxUbY/mAAH9bwIg
 7HlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVy27v5q8QP/Xr/i503F7p5NAlvxdyNNciAsQUBCiIydI8YgZfKS8VHnEj4qpAD3UalAVNAces=@lists.denx.de
X-Gm-Message-State: AOJu0YwQk3QL4rom+WQG+Z+VjYJL27cSkO0VXN8KrlxHedNemcsOwG73
 +rgG3YiYSKzAPyuno5B9cI0Luk60aZhulXPqearuSTreXQeWAL+uIOBvIF9yLFslLRYTOBGjjrx
 IR2S8SK3SoAYQ35YUywo7tqmS5eC5MIjNoEQMHzE95uoPNvpudBzXoct9nXRivvoyy621N1A=
X-Gm-Gg: ASbGncv+D4g/zbkiIRv4IJcPnaYgNM9IhCmomljmGvrN4ac43FgrKM//x01eH+i3jFa
 k2oofKAMxRDADryBRLBq1DhflIhhbm28dyT0I6tc1I/8oxKlizr6pcKyfduNI4t4ZbggbJqvPcs
 mkO9LsNTxH75RsfMSbk+Im2VUuzJtHEyq8qtPZUJlDRHSDTbtRPjMxaIA4j6j/zkK0ImEZfojrr
 Es/gxIJJaX0gv7wosmvsPzHB2DnwH14oe+yk4+rqO7OaV4zubneqGwwQkdYyWq6BM7tAk2gcgvb
 DOj5d3GMHQrpnsFdy7LKAFc7214PmNtg5LffkiqlXv+UHaEFSdxGBwUTCBYuC+Ve1qJeyylrKLB
 4DMZkubuX3cC4nthxUAOHdgtadC9rIJzkRdPVmWJWmxepY+RkwOtwuEeM2rvhWjRAwA1yfhg5dK
 zaVynGhrg=
X-Received: by 2002:a05:600c:4f88:b0:46e:506b:20c5 with SMTP id
 5b1f17b1804b1-477c01c0c9cmr383932675e9.26.1764656139960; 
 Mon, 01 Dec 2025 22:15:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFrTiOS5oLhJy9Z1IldtfdhQTKi/6bTAhPAneOSY3vcYNDtcFMIETjfJsjJYjMg8xnX6PsrnA==
X-Received: by 2002:a05:600c:4f88:b0:46e:506b:20c5 with SMTP id
 5b1f17b1804b1-477c01c0c9cmr383932455e9.26.1764656139592; 
 Mon, 01 Dec 2025 22:15:39 -0800 (PST)
Received: from [192.168.123.154]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-479279f366bsm5971545e9.14.2025.12.01.22.15.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Dec 2025 22:15:39 -0800 (PST)
Message-ID: <0fb06358-cbed-4613-b9fd-b21962b2c0be@canonical.com>
Date: Tue, 2 Dec 2025 07:15:37 +0100
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
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <33d528eff4e6453fdd8d442866e6af2544c7c9ad.camel@icenowy.me>
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

On 12/2/25 06:28, Icenowy Zheng wrote:
> 在 2025-12-02星期二的 03:57 +0000，Yao Zi写道：
>> On Mon, Dec 01, 2025 at 06:49:03PM +0100, Heinrich Schuchardt wrote:
>>> The following functions are provided:
>>>
>>> Count leading zero bits
>>>
>>> * int __clzsi2 (unsigned int a)
>>> * int __clzdi2 (unsigned long a)
>>> * int __clzti2 (unsigned long long a)
>>>
>>> Count trailing zero bits
>>>
>>> * int __ctzsi2 (unsigned int a)
>>> * int __ctzdi2 (unsigned long a)
>>> * int __ctzti2 (unsigned long long a)
>>>
>>> Signed-off-by: Heinrich Schuchardt
>>> <heinrich.schuchardt@canonical.com>
>>> ---
>>
>> I noted there's another series with the same subject[1] sent almost
>> at
>> the same time, and I couldn't tell the difference at the first
>> glance.
>> Is this an incident?
>>
>>>   arch/Kconfig            |   1 +
>>>   arch/riscv/lib/Makefile |   2 +
>>>   arch/riscv/lib/clz.c    | 105
>>> ++++++++++++++++++++++++++++++++++++++++
>>>   arch/riscv/lib/ctz.c    |  95 ++++++++++++++++++++++++++++++++++++
>>>   lib/Kconfig             |   2 +-
>>>   5 files changed, 204 insertions(+), 1 deletion(-)
>>>   create mode 100644 arch/riscv/lib/clz.c
>>>   create mode 100644 arch/riscv/lib/ctz.c
>>>
>>> diff --git a/arch/Kconfig b/arch/Kconfig
>>> index 3133f892f94..4af0da2485f 100644
>>> --- a/arch/Kconfig
>>> +++ b/arch/Kconfig
>>> @@ -159,6 +159,7 @@ config PPC
>>>   config RISCV
>>>          bool "RISC-V architecture"
>>>          select CREATE_ARCH_SYMLINK
>>> +       select HAVE_PRIVATE_LIBGCC if 64BIT
>>
>> Are 32-bit platforms excluded for lacking of enough library
>> functions?

Yes. See 
https://lore.kernel.org/u-boot/20251201174904.652954-1-heinrich.schuchardt@canonical.com/T/#mbf44c9f5073649bbf2e1368ffbeaec82680a268d

>> Should we exclude !RISCV_ISA_F || !RISCV_ISA_D platforms as well?
>> Though

libgcc.a as provided by distros assumes that you have the D and F 
extensions. Either a specific libgcc.a will be needed or we will have to 
implement the missing functions in the private lib if such platforms.

It would make more sense to set CONFIG_USE_PRIVATE_LIBGCC=n for such 
platforms than setting CONFIG_HAVE_PRIVATE_LIBGCC=n.

Which way we want to go can be decided when such platforms arrive.

>> there's no in-tree 64-bit port without F/D extension.
> 
> The S7 core in U74-MC complex seems to have only IMAC, no F/D.
The S7 core is not supported by U-Boot.

Best regards

Heinrich

> 
>>
>>>          select HAVE_SETJMP
>>>          select HAVE_INITJMP
>>>          select SUPPORT_ACPI
>>
>> Regards,
>> Yao Zi
>>
>> [1]:
>> https://lore.kernel.org/u-boot/20251201174705.652626-1-zfsdt@canonical.com/
> 

