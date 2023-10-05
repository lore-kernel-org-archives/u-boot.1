Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C6BFE936EC
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 00:03:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 572F086E04;
	Thu,  5 Oct 2023 02:02:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="AdSH2thR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5294086E51; Thu,  5 Oct 2023 02:02:52 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2454086590
 for <u-boot@lists.denx.de>; Thu,  5 Oct 2023 02:02:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4705E3F66D
 for <u-boot@lists.denx.de>; Thu,  5 Oct 2023 00:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1696464167;
 bh=3sanlyXOlAzhqP/ipqIn9gTlqLsugALCIYIvECshh9A=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=AdSH2thR6+jc9i4I0O6EL38PpSJ1kUV4/OW4SXPegg6kBjCe+8kwVU/bBNsL5ztoG
 cP18fYcOWwVCefbiGnRBDo0XhFuip/X8Ykh6bSAiY3RoxUPxAMKNbUaNiO1AN9HI6+
 RfZGIvxpgD0HqBT8/1/M+ubuanJkmR4Uh3hZn7tYvyckZcj2xVzONBPZIRX6Lj3/aK
 yG4hchsvfO+eleJfHgkbImlL/OajVVhINbOqBEGKpHbYtU6DKl/fyJDaMBTdqYGXvC
 NYD1qhHOHIWZQAMkAouaEeHKLF6QG4GzDZdzS+KMYRx5h32faC+v6VvHrY/u2AXR65
 saRjZcGJPWMdA==
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-314256aedcbso371813f8f.0
 for <u-boot@lists.denx.de>; Wed, 04 Oct 2023 17:02:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696464165; x=1697068965;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3sanlyXOlAzhqP/ipqIn9gTlqLsugALCIYIvECshh9A=;
 b=NWHc5dxM9q6RzLi9fmEtL1jdbtfVU7bqyYyhVjGisfAQPw/cmle9PDCGJM/ihXJaTB
 ix8OBGE/QQFCUvtl+etogJrlZAUkWVS0gYuC2LiaZYzd1JOE1WkYsc6ZPG5as6i+1LLo
 05P2XP6pucfgQHvgD/YfKVt5i3kVQvMS7qcbu/QMUKFVn1ZGRa4xsWJQCRfmy/h0615F
 EG+xtVzRZD980g6ynKoFp6SG4Hb+5WE2jq8j4Iz6LVv5DL5ArkIEXsPHykgXXHpgqlTQ
 44N3H+BeAO34ndSyHi4NjXUNS4lpg6LwrLLyYv0739TjnYePLJfdXkI2Kxo9QXEESDG7
 CMmA==
X-Gm-Message-State: AOJu0Yx5bDfk1GbxlZIvpytH4CTExDEkrxlxVTDazwk45214ZYIaKpaH
 +1EVOImLaXvL0JL451yqqYwljgTnvXuKCCcNhaS48BA8XD015j0KTW46j+0shszVmv0ltJZKiqC
 dmqr0JIgxcTUlHTgNz4QzWLtB1S0g/0c=
X-Received: by 2002:a5d:6986:0:b0:31a:e972:3601 with SMTP id
 g6-20020a5d6986000000b0031ae9723601mr3492571wru.54.1696464165069; 
 Wed, 04 Oct 2023 17:02:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFh3ifFtgFadh5O+4lP2DPxKeFcPlAGxJ6Eban5TAsuXwXC7Rp61JHJqQwHI/FViyDlM+Rt/g==
X-Received: by 2002:a5d:6986:0:b0:31a:e972:3601 with SMTP id
 g6-20020a5d6986000000b0031ae9723601mr3492559wru.54.1696464164763; 
 Wed, 04 Oct 2023 17:02:44 -0700 (PDT)
Received: from [192.168.123.94] (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 z12-20020adfec8c000000b00324853fc8adsm305109wrn.104.2023.10.04.17.02.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Oct 2023 17:02:44 -0700 (PDT)
Message-ID: <3011f86a-7df9-416c-9b0f-a6b07d14667a@canonical.com>
Date: Thu, 5 Oct 2023 02:02:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] riscv: remove dram_init_banksize()
Content-Language: en-US
To: "Wu, Fei" <fei2.wu@intel.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, Anup Patel <apatel@ventanamicro.com>,
 u-boot@lists.denx.de, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>
References: <20230926071634.22016-1-heinrich.schuchardt@canonical.com>
 <fcc91051-81c5-7b0f-fd93-d971200e5c2d@intel.com>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <fcc91051-81c5-7b0f-fd93-d971200e5c2d@intel.com>
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

On 9/26/23 09:46, Wu, Fei wrote:
> On 9/26/2023 3:16 PM, Heinrich Schuchardt wrote:
>> Remove dram_init_banksize() on the architecture level.
>>
>> Limiting used RAM to under 4 GiB is only necessary for CPUs which have a
>> DMA issue. SoC specific code already exists for FU540, FU740, JH7110.
>>
>> Not all RISC-V boards will have memory below 4 GiB.
>>
>> A weak implementation of dram_init_banksize() exists in common/board_f.c.
>>
>> See the discussion in
>> https://lore.kernel.org/u-boot/545fe813-cb1e-469c-a131-0025c77aeaa2@canonical.com/T/
>>
> Thanks you Heinrich, this patch itself is okay to me, but it still
> doesn't address the problem in that thread. In setup_dest_addr():
> 
> #ifdef CFG_SYS_SDRAM_BASE
>          gd->ram_base = CFG_SYS_SDRAM_BASE;
> #endif
>          gd->ram_top = gd->ram_base + get_effective_memsize();
>          gd->ram_top = board_get_usable_ram_top(gd->mon_len);
> 
> ram_base is modified in #ifdef so that ram_base and
> get_effective_memsize() is not well paired. e.g. two ranges of memory
> [2GB, 3GB) and [4GB, 6GB), ram_base is set to 2GB of 1st range and
> get_effective_memsize() returns 2GB of 2nd range, ram_top will be set to
> 4GB which is not desired. Will you address this too?

No, that is an independent issue. I only want to get rid of the generic 
restriction to memory below 4 GiB on RISC-V.

I would recommend to set ram_top to the highest available memory address 
of the highest RAM bank with some special handling of the ARM LPAE case 
or 32bit in general. But this is not a RISC-V specific topic.

Best regards

Heinrich

> 
> Best Regards,
> Fei.
> 
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   arch/riscv/cpu/generic/dram.c | 16 ----------------
>>   1 file changed, 16 deletions(-)
>>
>> diff --git a/arch/riscv/cpu/generic/dram.c b/arch/riscv/cpu/generic/dram.c
>> index 94d8018407..1b51bae9b6 100644
>> --- a/arch/riscv/cpu/generic/dram.c
>> +++ b/arch/riscv/cpu/generic/dram.c
>> @@ -20,19 +20,3 @@ int dram_init_banksize(void)
>>   {
>>   	return fdtdec_setup_memory_banksize();
>>   }
>> -
>> -phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
>> -{
>> -	/*
>> -	 * Ensure that we run from first 4GB so that all
>> -	 * addresses used by U-Boot are 32bit addresses.
>> -	 *
>> -	 * This in-turn ensures that 32bit DMA capable
>> -	 * devices work fine because DMA mapping APIs will
>> -	 * provide 32bit DMA addresses only.
>> -	 */
>> -	if (gd->ram_top >= SZ_4G)
>> -		return SZ_4G - 1;
>> -
>> -	return gd->ram_top;
>> -}
> 

