Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AF00C4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 17:16:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEEC88710A;
	Wed,  1 Nov 2023 18:16:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T97cH/Ez";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0C3E87507; Wed,  1 Nov 2023 18:16:32 +0100 (CET)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8562887D61
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 18:16:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7781bc3783fso490857385a.1
 for <u-boot@lists.denx.de>; Wed, 01 Nov 2023 10:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698858987; x=1699463787; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DX6vsIk1eIG6U/Z8SHmraHng3mPJPXdGpBZkI9N/bZs=;
 b=T97cH/Ezyl+s23nPWpv6wzAY+1HH9MfjuaX1Z07lA69sd04/pG4KowS1qr0jMmp7Kx
 v1YZFRdr6/zR9Z7MhZdmMyuKfuwz39lPJ2MvvUNfoa0Gpgebk/7gle7M8VzGJY/JS3Ez
 W8/1/UkXYMdGGK9oSKAYAISJqzweUQ1jEmVOidQuXQ4qhkrhBQVcKzOCuJ3esigr46z/
 w5CfOAqxKBAU9QbBX+mLcjK/GZVfqGT4KxsvVrc47EdoF6bDkjelRFiFNiCcSO77nF67
 jkYr9wUyi+6wzvbFUf7VkaSznOdp1Gcxu/jOxSTB2eVlsdA12T7km7mSK84LOlaAjTWx
 Iwlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698858987; x=1699463787;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DX6vsIk1eIG6U/Z8SHmraHng3mPJPXdGpBZkI9N/bZs=;
 b=BXU8ROjjapKQEoM3CubBc9rAAbFqI2Uo93bYtUCR1twc4/g9I8D/0eFyTPYK7yXK34
 lTL62/lDfoQuyRSeimefdtl0HIC3qo5Nm6KWqrminlV4Pkc8uCF3wgyYxd311y06i5U/
 ydbWeRQS99/1wl6BYiMd2U1X6mJxuPXLGyBYPsOsvt/tZQiMgiYaK0lIEvjXtgx5f1xA
 3g3JF77fLx0dj6KdXQL2CI13Z4o+wk+OTMJGTaJKMuB5H2vUcRfvMwEjOx3rfS8tImpR
 7gzy9fAh8Z4i45evjqHNNePR3GANJ6rh1orlGmIKJhy+R1t7yywo2uq3/iSCGXM1YkFc
 Grng==
X-Gm-Message-State: AOJu0Yx3e50H6/uB7Cx33y9SDvKqD+ofYQForQR2oHFWmDStd2JtwWPo
 mA0x8gGCoF9N9koCSthhYHg=
X-Google-Smtp-Source: AGHT+IH4wxksfCQE7RujU4VQqW3Dqr0fDdffoYpgj4D/QGX15jVwbB4BLSZ3kgEM5Zr0Chx4CpQnxQ==
X-Received: by 2002:a05:620a:2717:b0:77a:2ff:779b with SMTP id
 b23-20020a05620a271700b0077a02ff779bmr16325656qkp.21.1698858985661; 
 Wed, 01 Nov 2023 10:16:25 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 de14-20020a05620a370e00b007756c8ce8f5sm610456qkb.59.2023.11.01.10.16.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Nov 2023 10:16:25 -0700 (PDT)
Message-ID: <5f170b50-94ac-5bf6-87d2-a3e12b8ba364@gmail.com>
Date: Wed, 1 Nov 2023 13:16:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 0/2] rng: Provide a RNG based on the RISC-V Zkr ISA
 extension
Content-Language: en-US
To: Andre Przywara <andre.przywara@arm.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Anup Patel <apatel@ventanamicro.com>, Xiang W <merlew4n6@gmail.com>,
 Chanho Park <chanho61.park@samsung.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Peter Hoyes <Peter.Hoyes@arm.com>
References: <20231031125552.26698-1-heinrich.schuchardt@canonical.com>
 <20231101170559.680ab493@donnerap.manchester.arm.com>
From: Sean Anderson <seanga2@gmail.com>
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

On 11/1/23 13:05, Andre Przywara wrote:
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

Wouldn't the right way be to detect the hardware in bind()?

--Sean

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

