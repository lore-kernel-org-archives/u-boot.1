Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3912C4167D
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 20:20:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EFBA876AF;
	Wed,  1 Nov 2023 21:20:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="L41ywg9n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E6AF876C4; Wed,  1 Nov 2023 21:20:53 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C41C98768F
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 21:20:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E6854404AC
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 20:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1698870043;
 bh=ebA7ugCpMTArmUWXe/JzisYmnv1TT7890/UHo5RHKhk=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=L41ywg9nWoqANomh0LOHEtF3uZYvH4QgUL/53H3XAym5MflKD3XztamJoK9qwkZjr
 l84Cg8qtyB/VQieDiyDVVlwY27w2RTC3cYzsMOB1ilBikXcCgGs6XNRaRPJ3HCf6oy
 I2a1m6TqSH/Ygc+H+2Rvto5iDEE4vIhQ4boKGrJApfL1C4XGKyjc62EHJLhqwkpSGE
 S34fz6JaEw8CXLL1jvJo03pO4JV7qZrg4SGt3TQWIR+EfFXGyOqmi+GnIledkJ6p51
 gtKrZ/BXoW271pHJxKVmPfT2AuRLCgyNK89BgGXOK0FVYye5JIGORyVvonHv4Uc9Vh
 UzwKPTBjVnsTA==
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5079fd9754cso104938e87.0
 for <u-boot@lists.denx.de>; Wed, 01 Nov 2023 13:20:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698870043; x=1699474843;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ebA7ugCpMTArmUWXe/JzisYmnv1TT7890/UHo5RHKhk=;
 b=lWpFAdrbywInt3/kraCawYqIMP2mSltrCCdh0CUMUYrtEoSLIyGv92wHvwv1X4kIb4
 uVPqgxVbf9EXSd4bGt0sj+BNaL5BU9pK2Jd8hXMaIfrYmXn1haldWyuSoKlIQvK2LLFU
 6YGT8CPswo4hxiO1YMiZlrX/C56rOrQk132sn/PN78HFzthpowyypgSnp9JnNdvQmPdF
 iLCWWq7oSiYPBm64zvoYePvwLkF1KQ6YmV2jcRj4+CEFQh7Nfl4fgsEMNlRqwX6y0Q+L
 e857t6T/Pajqqj4psvOwvGvhhlwPFWtFuXztIa/r485dt8YWgWfhcF1g4VgOE2xH1RGw
 S/5A==
X-Gm-Message-State: AOJu0YxRUrEQ/UgeLytvNSjvQTm1OhPhltsCTzVvHtOIuQ65x3q6H+/L
 Exrgejz+tdZxLyJ+0KGOz9hUs/wWphLq1LGLcjbCROF+2ZT+JZU8uJvMaqdMR24JvVhQAR6Z+VC
 yLcruATlShrsQ/8enniL/fKgj+RTBEcA=
X-Received: by 2002:a05:6512:48d8:b0:503:3808:389a with SMTP id
 er24-20020a05651248d800b005033808389amr11318514lfb.11.1698870043087; 
 Wed, 01 Nov 2023 13:20:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbgl/OAnE2M5673mdzbPnbQq1DN57NIgQl+mR+pvv83OCp8R/uT01yfYXb2ICgoNhrfbToZw==
X-Received: by 2002:a05:6512:48d8:b0:503:3808:389a with SMTP id
 er24-20020a05651248d800b005033808389amr11318493lfb.11.1698870042673; 
 Wed, 01 Nov 2023 13:20:42 -0700 (PDT)
Received: from [10.0.29.1] ([159.148.28.2]) by smtp.gmail.com with ESMTPSA id
 er22-20020a05651248d600b005009c4ba3f0sm292354lfb.72.2023.11.01.13.20.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Nov 2023 13:20:41 -0700 (PDT)
Message-ID: <50ff2080-5831-4963-937d-331248b59973@canonical.com>
Date: Wed, 1 Nov 2023 22:20:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] rng: Provide a RNG based on the RISC-V Zkr ISA
 extension
Content-Language: en-US
To: Andre Przywara <andre.przywara@arm.com>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Anup Patel <apatel@ventanamicro.com>, Xiang W <merlew4n6@gmail.com>,
 Chanho Park <chanho61.park@samsung.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Peter Hoyes <Peter.Hoyes@arm.com>,
 Alexey Romanov <avromanov@salutedevices.com>, Simon Glass
 <sjg@chromium.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20231031125552.26698-1-heinrich.schuchardt@canonical.com>
 <20231101170559.680ab493@donnerap.manchester.arm.com>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20231101170559.680ab493@donnerap.manchester.arm.com>
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

On 11/1/23 19:05, Andre Przywara wrote:
> On Tue, 31 Oct 2023 14:55:50 +0200
> Heinrich Schuchardt <heinrich.schuchardt@canonical.com> wrote:
> 
> Hi Heinrich,
> 
>> The Zkr ISA extension (ratified Nov 2021) introduced the seed CSR. It
>> provides an interface to a physical entropy source.
>>
>> A RNG driver based on the seed CSR is provided. It depends on
>> mseccfg.sseed being set in the SBI firmware.
> 
> As you might have seen, I added a similar driver for the respective Arm
> functionality:
> https://lore.kernel.org/u-boot/20230830113230.3925868-1-andre.przywara@arm.com/
> 
> And I see that you seem to use the same mechanism to probe and init the
> driver: U_BOOT_DRVINFO and fail in probe() if the feature is not
> implemented.
> One downside of this approach is that the driver is always loaded (and
> visible in the DM tree), even with the feature not being available.
> That doesn't seem too much of a problem on the first glance, but it
> occupies a device number, and any subsequent other DM_RNG devices
> (like virtio-rng) typically get higher device numbers. So without
> the feature, but with virtio-rng, I get:
> VExpress64# rng 0
> No RNG device
> VExpress64# rng 1
> 00000000: f3 88 b6 d4 24 da 49 ca 49 f7 9e 66 5f 12 07 b2  ....$.I.I..f_...


Essentially in any case were you have multiple drivers for the same 
device using uclass_get_device(, 0, ) and uclass_find_first_device() 
will only give you the first bound device and not the first successfully 
probed device. Furthermore neither of this functions causes probing. 
This is not restricted to the RNG drivers but could also happen with 
multiple TPM drivers or multiple watchdogs.

This patch is related to the problem:

[PATCH v1] rng: add dm_rng_read_default() helper
https://lore.kernel.org/u-boot/4e28a388-f5b1-4cf7-b0e3-b12a876d0567@gmx.de/T/#me44263ec9141e3ea65ee232aa9a411fc6201bd95

We have weak function platform_get_rng_device() which should be moved to 
drivers/rng/rng-uclass.c.

We could add a function to drivers/core/uclass.c to retrieve the first 
successfully probed device. Another approach would be to implement 
uclass_driver.post_probe() in the RNG uclass to take note of the first 
successfully probed device.

@Simon:
What would make most sense from a DM design standpoint?

Best regards

Heinrich

> ....
> 
> Now the EFI code always picks RNG device 0, which means we don't get
> entropy in this case.
> 
> Do you have any idea how to solve this?
> Maybe EFI tries to probe further - but that sounds arbitrary.
> Or we find another way for probing the device, maybe via some artificial
> CPU feature "bus"? There is UCLASS_CPU, but that doesn't look helpful?
> 
> If anyone has any idea, I'd be grateful.
> 
> Cheers,
> Andre
> 
>> If the seed CSR readable, is not determinable by S-mode without risking
>> an exception. For safe driver probing allow to resume via a longjmp
>> after an exception.
>>
>> As the driver depends on mseccfg.sseed=1 we should wait with merging the
>> driver until a decision has been taken in the RISC-V PRS TG on prescribing
>> this.
>>
>> Setting mseccfg.sseed=1 is queued for OpenSBI [1]. This has been discussed
>> in the RISC-V Boot & Runtime Services TG. Standardization has to be pursued
>> via the upcoming platform specification.
>>
>> A bug fix for QEMU relating to the Zkr extension is available in [2].
>>
>> A similar Linux driver has been proposed in [3].
>>
>> [1] lib: sbi: Configure seed bits when MSECCFG is readable
>>      https://patchwork.ozlabs.org/project/opensbi/patch/20230712083254.1585244-1-sameo@rivosinc.com/
>> [2] [PATCH v2 1/1] target/riscv: correct csr_ops[CSR_MSECCFG]
>>      https://lore.kernel.org/qemu-devel/20231030102105.19501-1-heinrich.schuchardt@canonical.com/
>> [3] [PATCH v4 4/4] RISC-V: Implement archrandom when Zkr is available
>>      https://lore.kernel.org/linux-riscv/20230712084134.1648008-5-sameo@rivosinc.com/
>>
>> v3:
>> 	Add API documentation.
>> v2:
>> 	Catch exception if mseccfg.sseed=0.
>>
>> Heinrich Schuchardt (2):
>>    riscv: allow resume after exception
>>    rng: Provide a RNG based on the RISC-V Zkr ISA extension
>>
>>   arch/riscv/lib/interrupts.c |  13 ++++
>>   doc/api/index.rst           |   1 +
>>   drivers/rng/Kconfig         |   8 +++
>>   drivers/rng/Makefile        |   1 +
>>   drivers/rng/riscv_zkr_rng.c | 116 ++++++++++++++++++++++++++++++++++++
>>   include/interrupt.h         |  45 ++++++++++++++
>>   6 files changed, 184 insertions(+)
>>   create mode 100644 drivers/rng/riscv_zkr_rng.c
>>   create mode 100644 include/interrupt.h
>>
> 

