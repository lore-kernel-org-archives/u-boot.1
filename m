Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE00DC3DA62
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 08:23:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52D0F88997;
	Tue, 16 Jul 2024 10:23:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="dDIRtRXW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50FDB8875C; Tue, 16 Jul 2024 10:23:56 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E5F388969
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 10:23:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 79E4E3F0DE
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 08:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1721118231;
 bh=C8iuCyF5hBLiXGd5B0LYWiXx1UL0n3m1vCMHPp9FHng=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=dDIRtRXWDC1SoxwedkssOULL7VN58M0J27ABBI2D5UOWmTnBXdry1N79dplWRvygv
 K8nbcY2aVKHZzERcCDJiYwEKkQHUy62n8tUHSLEQm0xPXy3s2FkFnFZk18PCM8e0bc
 e1rngSrmGxQqNs+gg4oi/s4G8qVhtQO8QjalW3e5tsduiObi6RGK4EUOVoO9qCE3U1
 6dRWfoKaW100jZn/UH39Au1MjsPvBwKKfS1XAGj1NsS6ijgxaALl7zfFEdFq8vHL+m
 KXLmDwhiCfWryOI72bEVB0Pm4fxuIn0wo9Hr+qHlIx/InTTaNgV7c3DiK9W/k7bQKj
 FXLuxngOABzdg==
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-36796a0687bso3580273f8f.2
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 01:23:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721118231; x=1721723031;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C8iuCyF5hBLiXGd5B0LYWiXx1UL0n3m1vCMHPp9FHng=;
 b=BngxWR9ckgBYd3sPv/Nr1AWLiLpA3F2+vLJGxMJDBX8oLJMuvf+0sENecDSkZCbCjf
 5CJbw7kewceQSfFgVd1NfpveAk3B6GtuGrajRm1cyuBajrSqhyoov7BHv24EWDFJ+cd6
 NUDehz2jSYJfrEIPyTbAQABSTpBeaBIbBe51cLYagt8cIqjJaIvT09v4VbhH8z65l37B
 UIdB2rCQ9DQTcVSzCvb3VmofoqW3Cy1mVgGjD7rKwkU3gziK/cROf0hVFZxcGXYHdEQN
 t7ZUlG98wqcj7eEGkXIvFAQI5vNNOaW5vAgSJOlitID0dRrqlJ28tIKmDT66NfYfKMhE
 s9Gg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX473zPj0WdbzxAcd9itAaw+MTb56cxKFcJDiqxogi/RsjebUyuPQPhFmwmtWBCkFyOrrnFb+TKlUL/LSI9oxKgjsA9uQ==
X-Gm-Message-State: AOJu0Yza3ik52mk1KlA6Q0AXCZPXpb7B+x+mmTQGrf9Yv7u1Ho91KYvL
 LDXs0lFquH8ipMd0y3qs5Z2dQxQszOwRvcQNMTwtnH3X51CpgXLqtlxI7i0l4ToXkhm86ODeHIj
 +gBh4mUuKVWgeyCxFlcz2K2iFmSJ0CBcNN0D4cGb3eGlKwzYfTICqQbAgL/HcQr3IwFA=
X-Received: by 2002:a5d:4579:0:b0:367:9409:f7f7 with SMTP id
 ffacd0b85a97d-368260e9da9mr815820f8f.31.1721118231068; 
 Tue, 16 Jul 2024 01:23:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGO+rbWt2YTVp5vk953qgoHi2veP4q0yftr+//RAagf865bSNY7d1z9YjxvTGhBaKex3vIFRw==
X-Received: by 2002:a5d:4579:0:b0:367:9409:f7f7 with SMTP id
 ffacd0b85a97d-368260e9da9mr815798f8f.31.1721118230643; 
 Tue, 16 Jul 2024 01:23:50 -0700 (PDT)
Received: from [192.168.123.161]
 (ip-062-143-093-080.um16.pools.vodafone-ip.de. [62.143.93.80])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dab3e71sm8278099f8f.12.2024.07.16.01.23.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 01:23:50 -0700 (PDT)
Message-ID: <3f60c188-5325-4c9c-a036-42aa1ecb7aad@canonical.com>
Date: Tue, 16 Jul 2024 10:23:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] boot: provide CONFIG_BOOTMETH_QFW Kconfig parameter
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Eddie James <eajames@linux.ibm.com>, AKASHI Takahiro
 <akashi.tkhro@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>
References: <20240716024032.22254-1-heinrich.schuchardt@canonical.com>
 <CAFLszTgSE-Zd1OpoisD4pCi6mFw2KgYzfFwpOsstUw08LGO-Qg@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAFLszTgSE-Zd1OpoisD4pCi6mFw2KgYzfFwpOsstUw08LGO-Qg@mail.gmail.com>
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

On 7/16/24 09:04, Simon Glass wrote:
> Hi Heinrich,
> 
> On Tue, 16 Jul 2024 at 03:40, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> U-Boot is often used conjunction with QEMU to boot via EFI or syslinux.
>> Here the QFW boot method is not needed.
>>
>> At least for qemu-riscv64_smode_defconfig the kernel parameter is used
>> to specify the U-Boot binary. Trying to run U-Boot as a kernel makes
>> no sense.
>>
>> Provide Kconfig parameter CONFIG_BOOTMETH_QFW to decide if the QFW boot
>> method shall be provided.
>>
>> Disable the QFW boot method for all architectures but the sandbox by
>> default.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   boot/Kconfig  | 9 +++++++++
>>   boot/Makefile | 2 +-
>>   2 files changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/boot/Kconfig b/boot/Kconfig
>> index 95300b008c5..d7e034c89e7 100644
>> --- a/boot/Kconfig
>> +++ b/boot/Kconfig
>> @@ -568,6 +568,15 @@ config BOOTMETH_EFI_BOOTMGR
>>            the EFI binary to be launched is determined. To set the EFI variables
>>            use the eficonfig command.
>>
>> +config BOOTMETH_QFW
>> +       bool "Boot method using QEMU parameters"
>> +       depends on QFW
>> +       default y if SANDBOX
>> +       help
>> +        Use QEMU parameters -kernel, -initrd, -append to determine the kernel,
>> +        initial RAM disk, and kernel command line parameters to boot an
>> +        operating system. U-Boot's control device-tree is passed to the kernel.
> 
> I added the bootmeth to deal with this part of the old qemu-arm.h :
> 
> /* Try files from QEMU's -kernel/-initrd, through the QEMU firmware device. */
> #define BOOTENV_DEV_QFW(devtypeu, devtypel, instance) \
> "bootcmd_qfw= " \
> "if qfw load $kernel_addr_r $ramdisk_addr_r; then " \
> "  booti $kernel_addr_r $ramdisk_addr_r:$filesize $fdtcontroladdr; " \
> "  if test $? -eq 1; then " \
> "    bootz $kernel_addr_r $ramdisk_addr_r:$filesize $fdtcontroladdr; " \
> "  fi ; " \
> "fi\0"
> #define BOOTENV_DEV_NAME_QFW(devtypeu, devtypel, instance) "qfw "
> 
> Are you sure this is not used?

Those lines were only on ARM. On RISC-V the -bios parameter is used to 
replace the OpenSBI embedded in QEMU and -kernel is used for S-mode U-Boot.

So on RISC-V this boot method would only be usable for 
CONFIG_SPL_RISCV_MMODE=y or CONFIG_RISCV_MMODE=y.

Let me resubmit with default=y. That way the method is at least 
customizable.

Best regards

Heirnich

> 
>> +
>>   config BOOTMETH_VBE
>>          bool "Bootdev support for Verified Boot for Embedded"
>>          depends on FIT
>> diff --git a/boot/Makefile b/boot/Makefile
>> index 84ccfeaecec..92e6adb887c 100644
>> --- a/boot/Makefile
>> +++ b/boot/Makefile
>> @@ -11,7 +11,6 @@ obj-$(CONFIG_CMD_BOOTZ) += bootm.o bootm_os.o
>>   obj-$(CONFIG_CMD_BOOTI) += bootm.o bootm_os.o
>>
>>   obj-$(CONFIG_PXE_UTILS) += pxe_utils.o
>> -obj-$(CONFIG_QFW) += bootmeth_qfw.o
>>
>>   endif
>>
>> @@ -31,6 +30,7 @@ obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_EXTLINUX) += bootmeth_extlinux.o
>>   obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_EXTLINUX_PXE) += bootmeth_pxe.o
>>   obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_EFILOADER) += bootmeth_efi.o
>>   obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_CROS) += bootm.o bootm_os.o bootmeth_cros.o
>> +obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_QFW) += bootmeth_qfw.o
>>   obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_SANDBOX) += bootmeth_sandbox.o
>>   obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_SCRIPT) += bootmeth_script.o
>>   obj-$(CONFIG_$(SPL_TPL_)CEDIT) += cedit.o
>> --
>> 2.45.2
>>
> 
> Regards,
> Simon

