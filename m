Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A467C52D6F
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 09:21:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAC0188B52;
	Wed, 21 Aug 2024 11:21:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="lgeSA7NR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B07088BC2; Wed, 21 Aug 2024 11:21:26 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E52F889F8
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 11:21:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1E08F4107D
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 09:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1724232083;
 bh=JhLoNQNg38sjcwCfQM74nR77y+gs16m1ssIftX2NN1g=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=lgeSA7NR56i+jsFy60TBiU6YxEMMtw1mPVIUmI9j460DNkwKwKuUVFDPrqi7k3Fae
 8eX81CLp9vhk/3CLDKMQWpY3xOdonExYBGVEH8ZsxQqZ2/3SR5sb33Uhndr1MlYPV8
 T2cACmB1Jpz0TQ4TrF6wkBg2SuBPSfjfAe+RequndYS4KYI2XkS0aFQhqzabqd/vNS
 Nwar8rFofcwnwHyBSc4VUoRgo+eFp68kQSS+9rhH8EKjukUPldMGaihcMghELgwUzh
 sGuL5+NhpGHq7Ykf1PhTPKFxBg4bZbG9QE1qn1UMQTisU81p8iJH/kX98YKkyZP23x
 h2IxrN/hL38lw==
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-52f00bde210so7467410e87.1
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 02:21:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724232082; x=1724836882;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JhLoNQNg38sjcwCfQM74nR77y+gs16m1ssIftX2NN1g=;
 b=esVjNIw1110VrNKIe7NqCTOUOThjuh24BvFgdHK/dcUZaJi+n1HL9wIPSdQBa4pmC0
 ZOxXaMaO9qC75vQPs/oFPqcxF9R8OheQp1NifFy6rLvHwJdNjcHxoOzqI6RnE/mQCx36
 I0m8ZmErABBBX71ADCnbp16k5XB1x0WZM8SX60kQFOv3Omh4y25J4I9EtTtdq9bfUpS1
 d6qW2+1AVqvCJrUAlSo3vU7UlKos6EGhBhmlIkDRkWCltiRZND3aBWP52yc7p6bsbDUi
 cCDSbUxeI8rnJD/VHL1tKCrANyhvotihrelyyLgWOjbZPJbdjSYBIdidaEDiuIryDU4f
 IaNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVu2/8axXrJGgDUbuoShWix0VXawrpi7//01n0cZY+6FWKWpRfrRpyP4hPyLXB/349KynPEof0=@lists.denx.de
X-Gm-Message-State: AOJu0YyN1t2mGlbz8lmIX8ektBzz+8V4B5u1A+AWdZgEQHkTRNt7Vl87
 A0B+lTIp0FLW9NMo8pZtIeN0QrticFS930FoslvThtOT3MUTEjxKIA7gpHYakTAe4McELdVysSL
 DXu0aEjHB6U+gh3TrGQPNDoEm/bvXFIz0I6wkj8qTUpyxuWE2J8VJ1Gc8zzIC8lSDKis=
X-Received: by 2002:a05:6512:3090:b0:52f:2adf:d445 with SMTP id
 2adb3069b0e04-53348590f5amr901269e87.41.1724232082209; 
 Wed, 21 Aug 2024 02:21:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2Wc2a2U8vuSwAHiAT0HYPa97Zt4KfO9a4EAee4rM73Qzm3X6p/+IYv0vzoBhvRqq3QLBTig==
X-Received: by 2002:a05:6512:3090:b0:52f:2adf:d445 with SMTP id
 2adb3069b0e04-53348590f5amr901250e87.41.1724232081250; 
 Wed, 21 Aug 2024 02:21:21 -0700 (PDT)
Received: from [192.168.103.101]
 (dynamic-046-114-001-175.46.114.pool.telefonica.de. [46.114.1.175])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a867c3feaffsm40596466b.90.2024.08.21.02.21.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Aug 2024 02:21:20 -0700 (PDT)
Message-ID: <72e591e0-ba19-4035-ac29-c628da948a74@canonical.com>
Date: Wed, 21 Aug 2024 11:21:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] board: qemu-riscv: Override enable_caches
To: Mayuresh Chitale <mchitale@ventanamicro.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?Q?=C5=81ukasz_Stelmach?= <l.stelmach@samsung.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, u-boot@lists.denx.de,
 Rick Chen <rick@andestech.com>
References: <20240820093800.5436-1-mchitale@ventanamicro.com>
 <20240820093800.5436-4-mchitale@ventanamicro.com>
 <d7363b19-5cc6-4590-adfb-0889ea3aaf5f@canonical.com>
 <CAN37VV4+YkL3=H+M0qahnaPA6oHzGU_pnp4-MqftUK3fty2jhg@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAN37VV4+YkL3=H+M0qahnaPA6oHzGU_pnp4-MqftUK3fty2jhg@mail.gmail.com>
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

On 21.08.24 11:11, Mayuresh Chitale wrote:
> Hi Heinrich,
> 
> On Tue, Aug 20, 2024 at 5:43 PM Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> On 20.08.24 11:37, Mayuresh Chitale wrote:
>>> Define enable_caches function for the qemu-riscv board which probes for
>>> the cbom-block-size dt property when RISCV_ISA_ZICBOM is enabled. Also
>>> add flush_dcache_range and invalidate_dcache_range functions which use
>>> the corresponding CBO ops.
>>>
>>> Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
>>> ---
>>>    board/emulation/qemu-riscv/qemu-riscv.c | 16 ++++++++++++++++
>>>    1 file changed, 16 insertions(+)
>>>
>>> diff --git a/board/emulation/qemu-riscv/qemu-riscv.c b/board/emulation/qemu-riscv/qemu-riscv.c
>>> index e5193e31e3..1795d2f831 100644
>>> --- a/board/emulation/qemu-riscv/qemu-riscv.c
>>> +++ b/board/emulation/qemu-riscv/qemu-riscv.c
>>> @@ -14,6 +14,7 @@
>>>    #include <usb.h>
>>>    #include <virtio_types.h>
>>>    #include <virtio.h>
>>> +#include <asm/cache.h>
>>>
>>>    DECLARE_GLOBAL_DATA_PTR;
>>>
>>> @@ -70,3 +71,18 @@ void *board_fdt_blob_setup(int *err)
>>>        /* Stored the DTB address there during our init */
>>>        return (void *)(ulong)gd->arch.firmware_fdt_addr;
>>>    }
>>> +
>>> +void enable_caches(void)
>>> +{
>>> +     riscv_zicbom_init();
>>> +}
>>
>> Enable caches may be called multiple times. But riscv_zicbom_init() only
>> needs to be called once.
> Ok.
>>
>>> +
>>> +void flush_dcache_range(unsigned long start, unsigned long end)
>>> +{
>>> +     cbo_flush(start, end);
>>> +}
>>> +
>>> +void invalidate_dcache_range(unsigned long start, unsigned long end)
>>> +{
>>> +     cbo_inval(start, end);
>>> +}
>>
>> The ZICBOM extension is not specific to a single board. We should not
>> add this code to board files but into the central place for cache
>> operations, i.e. arch/riscv/lib/cache.c.
> Most of the code is already cache.c. I didn't know if it would suffice
> for all platforms so I decided to override the weak functions like in
> ARM.


With the suggestion below boards needing a board specific solution can 
still override the weak functions. But I would expect that in future new 
boards converge on zicbom.

Best regards

Heinrich

> 
>> E.g.
>>
>> static int get_zicbom_block_size()
>> {
>>          if (!CONFIG_IS_ENABLED(RISCV_ISA_ZICBOM))
>>                  return 0;
>>          if (zicbom_block_size)
>>                  return zicbom_block_size;
>>
>>          uclass_first_device(UCLASS_CPU, &dev);
>>          if (!dev) {
>>                  log_err("Failed to get CPU device!\n");
>>                  return 0;
>>          }
>>
>>          if (dev_read_u32(dev, "riscv,cbom-block-size", &zicbom_block_size))
>>                  return 0;
>>
>>          return zicbom_block_size
>> }
>>
>> __weak void invalidate_icache_range(unsigned long start, unsigned long end)
>> {
>>          if (CONFIG_IS_ENABLED(RISCV_ISA_ZICBOM) && get_zicbom_block_size())
>>                  cbo_inval(start, end);
>>          else
>>                  invalidate_icache_all();
>> }
>>
>> Cc: Rick as one of the RISC-V maintainers.
> Ok.
>>
>> Best regards
>>
>> Heinrich
>>

