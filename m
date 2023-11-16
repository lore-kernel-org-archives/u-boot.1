Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E490C197A0
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 19:54:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B3CC87483;
	Thu, 16 Nov 2023 20:54:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="PUjpKaJU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1520687454; Thu, 16 Nov 2023 20:54:54 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9389F8615A
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 20:54:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 02E9C3F6EF
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 19:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1700164489;
 bh=UKkThPq8yU7Jzaq+GUBKGuEw4f63Mi4AKgPnYbemwIM=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=PUjpKaJUJyO3q+jVYb/Fpi3tceWFgc/ZmS/Hib0hw4cx2jWj8/8vbptvYQni9xDoo
 ZVNj1IVOM2iaHiFQ46lTB1QXyBg0f7jzAOYQF28MnZtmKIvTJdBdp5elUS/bTGwWfG
 lowt0Osv64XorqU8xQkSYFuHvd/9b7XEtKJGW9nVGSHi+/ue5KYyiv0EIPzPV8jDeB
 yGc2uTTbaOtz4Z4Hgz0WbWU8wRFwk7HTIGBKzuPIGsH1BOd4OYo95IPos36kuGmBFo
 stmzYKlY6q92h1ubMPuIoarLj2QFUflC8dl9lrdNquoxBW3aMjcKGFN1qKMHjmtCKu
 5Y3RfOcfReAuw==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4083a670d25so7939755e9.0
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 11:54:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700164487; x=1700769287;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UKkThPq8yU7Jzaq+GUBKGuEw4f63Mi4AKgPnYbemwIM=;
 b=OEp1OLqFO5i2zqNOPbmS5o9hs9LPplRTEHagoyxVmGXuP9tjGfFgyZnSljXqVIdJmQ
 piOd9Cd+fwYQ5K64lBuMLaa7e2dMPyaMRMJYlOnodp5MPrTFqD/D1np5UKW8wA947ZvJ
 t76sCTehofF7oGE9/bjPgx/FPxLTfTOCgEKmXjV2d07XME7w34M94GPWX4Od3WdOsC1+
 E2YBFXXEeZ5+S4YnmIo9CyabNdyOXclWup0FVoGgYbAusJ+rXZxojvvDHxSPvDeZJ0dF
 prfIf5tl6bJfPQ58dbA2/3sV+VYlpOY+emJmvRl98dz4pfosnerrEJyib3D0LysOEqzd
 1E1g==
X-Gm-Message-State: AOJu0YxKlOQgyHz9TASfp13kwUGmrku4qJdq3VU0+u7gRiF1rtweYQdT
 inZgWpOsf7bD2C/UmrZmYXWTWM1C5c81Ys/+BUW2VgOdo+ztW6JFftcCH0y3OvOljpAmErMXkBl
 /BRnWEHJYnkEjw7dbD8sXmXzNOEUjOwk=
X-Received: by 2002:a05:600c:21c2:b0:40a:463c:1d8c with SMTP id
 x2-20020a05600c21c200b0040a463c1d8cmr13396495wmj.21.1700164487148; 
 Thu, 16 Nov 2023 11:54:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8lMvEKYv+IqQaskhq8m3zEOKj+FehRWaczYMwvUjFt9psbXLIFS3IfVrp45kRs1AqXblyHQ==
X-Received: by 2002:a05:600c:21c2:b0:40a:463c:1d8c with SMTP id
 x2-20020a05600c21c200b0040a463c1d8cmr13396482wmj.21.1700164486714; 
 Thu, 16 Nov 2023 11:54:46 -0800 (PST)
Received: from [192.168.123.94] (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 x16-20020a05600c21d000b004063cd8105csm4605940wmj.22.2023.11.16.11.54.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Nov 2023 11:54:46 -0800 (PST)
Message-ID: <a9f15562-d6fe-40d7-9fed-098061a5e523@canonical.com>
Date: Thu, 16 Nov 2023 20:54:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] risc-v: add support for QEMU provided ACPI tables
Content-Language: en-US, de-DE
To: Tom Rini <trini@konsulko.com>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Alexander Gendin <agendin@matrox.com>, Zong Li <zong.li@sifive.com>,
 Yu Chien Peter Lin <peterlin@andestech.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kautuk Consul <kconsul@ventanamicro.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de
References: <20231115142355.123038-1-heinrich.schuchardt@canonical.com>
 <20231115142355.123038-4-heinrich.schuchardt@canonical.com>
 <20231116183549.GC170968@bill-the-cat>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20231116183549.GC170968@bill-the-cat>
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

On 11/16/23 19:35, Tom Rini wrote:
> On Wed, Nov 15, 2023 at 03:23:52PM +0100, Heinrich Schuchardt wrote:
>> If U-Boot provides ACPI tables on RISC-V QEMU, we need to copy what QEMU
>> provides.
>>
>> Provide the qfw command to retrieve information from the QEMU firmware.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   board/emulation/qemu-riscv/Kconfig | 2 ++
>>   lib/Kconfig                        | 2 +-
>>   2 files changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/board/emulation/qemu-riscv/Kconfig b/board/emulation/qemu-riscv/Kconfig
>> index d56b4b5bc1..933b035991 100644
>> --- a/board/emulation/qemu-riscv/Kconfig
>> +++ b/board/emulation/qemu-riscv/Kconfig
>> @@ -33,6 +33,8 @@ config BOARD_SPECIFIC_OPTIONS # dummy
>>   	def_bool y
>>   	select GENERIC_RISCV
>>   	select SUPPORT_SPL
>> +	select CMD_QFW if GENERATE_ACPI_TABLE
>> +	select QFW_MMIO if GENERATE_ACPI_TABLE
>>   	imply AHCI
>>   	imply SMP
>>   	imply BOARD_LATE_INIT
>> diff --git a/lib/Kconfig b/lib/Kconfig
>> index 19649517a3..a94adc388f 100644
>> --- a/lib/Kconfig
>> +++ b/lib/Kconfig
>> @@ -300,7 +300,7 @@ config SPL_ACPI
>>   config GENERATE_ACPI_TABLE
>>   	bool "Generate an ACPI (Advanced Configuration and Power Interface) table"
>>   	depends on ACPI
>> -	select QFW if QEMU
>> +	select QFW if QEMU || TARGET_QEMU_VIRT
>>   	help
>>   	  The Advanced Configuration and Power Interface (ACPI) specification
>>   	  provides an open standard for device configuration and management
> 
> In this case we aren't "generating" the table, we're using the table
> we've been passed, yes? I think that further shows the need to add a
> symbol which means that, and use it where appropriate. Or am I
> misunderstanding the GENERATE_ACPI_TABLE symbol?
> 

If you look at drivers/misc/qfw.c you will find, that we only read ACPI 
tables created in QEMU if CONFIG_GNERATE_ACPI_TABLE=y. This contradicts 
the long text of the configuration symbol.

CONFIG_GNERATE_ACPI_TABLE is used to decide if we publish a device-tree 
in the EFI sub-system.

Simon tried to clean up EFI a bit in 53e8e6f98679 ("efi: x86: Correct 
the condition for installing ACPI tables") but did not change cmd/bootefi.c.

I would agree to calling the current usage of the symbol incoherent.

Best regards

Heinrich
