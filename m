Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5F8CCD1284
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 15:37:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09789883BA;
	Thu,  4 Apr 2024 17:37:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="SnkWSnJN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77CA0883A9; Thu,  4 Apr 2024 17:37:45 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DA768827D
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 17:37:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B49EB3F632
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 15:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1712245053;
 bh=qC/hBtesgcgo0UEhD9e0FYUZ41EzbV3E+K34hB4Yr10=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=SnkWSnJN376HTWVg2uvR31zEuImZAhOLf7L2iOxQhK9Mv2+ng6yPnC76ryl6VAjVb
 XIrpT5zroYVOJAnItiO1yt099wkW47irlQyRbllMrw/IDKI3Kbd/TcMUdwxDFdGJSS
 cCLEUyko4PXrVewpElSoB2meZeOWAOH7AUrvLVYzrrUMkQ1gpLGEazfXe2UALqLaXP
 XUuioE0sr9LIpfGi6rbrDGmLCP0HHbB3dJfMPJhvxyE/XQ+p6xXOsnObbAyDMwLdrX
 hd7V/FKIrUZxxF3d7o9OAHlk3w/eo6ewv7ShocsklME+qW/e57TlQvD8z4ZKogMMk3
 Lk2CaE3zoNMHw==
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-415610b70e5so5272885e9.2
 for <u-boot@lists.denx.de>; Thu, 04 Apr 2024 08:37:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712245050; x=1712849850;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qC/hBtesgcgo0UEhD9e0FYUZ41EzbV3E+K34hB4Yr10=;
 b=bUlM600hvkvrpZJPTX8Z8FPX5krOkLYb7Loy6v4vfRiqh7l5zH/DNXD88kgP+2vSq/
 LaEEKHpaOrLNF+3s+9pKZPP0UaH/1XaAoLIi820mJ1DVycYty1YwwJC1S1URI2hhZSHh
 SH8DhnhZ5eOnc19MQTTHyxJJbL+UbWdY4NRBxJY6s8PUQPxZXwyn2qsn141x9YfBO++i
 3Klid/UY4xat6mfqJqin+pKnAsbEnybSd6KWP/672HJbZ9vDH2x+BhMT66dMAn89QtdK
 nCfNcImttY7eOwasHYicge8dc1QQ7jAElQfE9ivuCG5gOcT8y5eRuojpFJzkkDsQBHh2
 Z1Qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXf+2UPdaiZwJK1ShT1gV4AJgQJGpD6Cg/Adnb3tO4hjDZyoV+y1O55xSRA+coe+6LTpkZAMLfAxvpmsh4F2cbWlYlhpg==
X-Gm-Message-State: AOJu0YxORnllAS4AgmZL+xXbdXQvrv9WZj9dyfo0BOEWlnKmXaxhJ71b
 V2W4TRNqqXszxb2Qz1ccss2v7Dv9iMzL1OwAIQhmWsITPbuIc7kfkRcfSmlTDuj0yAJK8HY96xL
 WcjBBBvJcvHIms1nliTpBCvOAJ4cpTHZ4eH04Tcm9GoRqF6laLKJDVvv5RKlEjylAlL0=
X-Received: by 2002:a05:600c:1c87:b0:415:666e:9438 with SMTP id
 k7-20020a05600c1c8700b00415666e9438mr119539wms.3.1712245049758; 
 Thu, 04 Apr 2024 08:37:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGi4UYN/bYSyLjFl3WIWq4Q0C7fzx9KNUyDy7PGeoCmysbSX6yunA0wJEdA/S55H+jAXyFO0A==
X-Received: by 2002:a05:600c:1c87:b0:415:666e:9438 with SMTP id
 k7-20020a05600c1c8700b00415666e9438mr119514wms.3.1712245049251; 
 Thu, 04 Apr 2024 08:37:29 -0700 (PDT)
Received: from [192.168.123.126]
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 b14-20020adff90e000000b0033e745b8bcfsm20313231wrr.88.2024.04.04.08.37.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Apr 2024 08:37:28 -0700 (PDT)
Message-ID: <c291e8c4-de90-4de2-9052-efb14b8a7133@canonical.com>
Date: Thu, 4 Apr 2024 17:37:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] boot: correct the default sequence of boot methods
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: trini@konsulko.com, sjg@chromium.org, ilias.apalodimas@linaro.org,
 sumit.garg@linaro.org, bb@ti.com, mr.bossman075@gmail.com,
 leon@georgemail.eu, eajames@linux.ibm.com, bmeng@tinylab.org, i@shantur.com,
 kettenis@openbsd.org, rfried.dev@gmail.com, seanedmond@microsoft.com,
 abdellatif.elkhlifi@arm.com, kojima.masahisa@socionext.com,
 sughosh.ganu@linaro.org, lucent@gmail.com, u-boot@lists.denx.de
References: <20240404114742.81187-1-heinrich.schuchardt@canonical.com>
 <20240404114742.81187-2-heinrich.schuchardt@canonical.com>
 <87r0fli2bq.fsf@bloch.sibelius.xs4all.nl>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <87r0fli2bq.fsf@bloch.sibelius.xs4all.nl>
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

On 04.04.24 17:18, Mark Kettenis wrote:
>> From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> Date: Thu,  4 Apr 2024 13:47:39 +0200
>>
>> The default sequence of boot methods is determined by alphabetical sorting
>> during linkage.
>>
>> * efi_mgr must run before efi to be UEFI compliant
>> * pxe should run as last resort
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> 
> This sound very much like you're working around a standard boot design
> flaw.
> 
> Who does the alphabetical sorting here?  Is that just a result of how
> the toolchain behaves?  If so, that sounds fragile to me and I think
> it would be better to make the order explicit in the code.

Thanks for reviewing.

Please, observe the SORT command in our linker script lines

     KEEP(*(SORT(__u_boot_list*)));

This ensures that linker generated lists are always alphabetically 
sorted. We rely on this in other places too. See 
part_driver_lookup_type() where GPT must be tested before FAT (commit 
96e5b03c8ab7 ("dm: part: Convert partition API use to linker lists").

Best regards

Heinrich

> 
> Cheers,
> 
> Mark
> 
>> ---
>> v2:
>> 	no change
>> ---
>>   boot/bootmeth_efi.c     | 2 +-
>>   boot/bootmeth_efi_mgr.c | 2 +-
>>   boot/bootmeth_pxe.c     | 2 +-
>>   test/boot/bootflow.c    | 2 +-
>>   4 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
>> index c4eb331d69e..a46b6c9c805 100644
>> --- a/boot/bootmeth_efi.c
>> +++ b/boot/bootmeth_efi.c
>> @@ -489,7 +489,7 @@ static const struct udevice_id distro_efi_bootmeth_ids[] = {
>>   	{ }
>>   };
>>   
>> -U_BOOT_DRIVER(bootmeth_efi) = {
>> +U_BOOT_DRIVER(bootmeth_4efi) = {
>>   	.name		= "bootmeth_efi",
>>   	.id		= UCLASS_BOOTMETH,
>>   	.of_match	= distro_efi_bootmeth_ids,
>> diff --git a/boot/bootmeth_efi_mgr.c b/boot/bootmeth_efi_mgr.c
>> index ed29d7ef021..b7d429f2c3d 100644
>> --- a/boot/bootmeth_efi_mgr.c
>> +++ b/boot/bootmeth_efi_mgr.c
>> @@ -114,7 +114,7 @@ static const struct udevice_id efi_mgr_bootmeth_ids[] = {
>>   	{ }
>>   };
>>   
>> -U_BOOT_DRIVER(bootmeth_efi_mgr) = {
>> +U_BOOT_DRIVER(bootmeth_3efi_mgr) = {
>>   	.name		= "bootmeth_efi_mgr",
>>   	.id		= UCLASS_BOOTMETH,
>>   	.of_match	= efi_mgr_bootmeth_ids,
>> diff --git a/boot/bootmeth_pxe.c b/boot/bootmeth_pxe.c
>> index 8d489a11aa4..70f693aa239 100644
>> --- a/boot/bootmeth_pxe.c
>> +++ b/boot/bootmeth_pxe.c
>> @@ -184,7 +184,7 @@ static const struct udevice_id extlinux_bootmeth_pxe_ids[] = {
>>   	{ }
>>   };
>>   
>> -U_BOOT_DRIVER(bootmeth_pxe) = {
>> +U_BOOT_DRIVER(bootmeth_zpxe) = {
>>   	.name		= "bootmeth_pxe",
>>   	.id		= UCLASS_BOOTMETH,
>>   	.of_match	= extlinux_bootmeth_pxe_ids,
>> diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
>> index 4845b7121c8..e60e9309fa9 100644
>> --- a/test/boot/bootflow.c
>> +++ b/test/boot/bootflow.c
>> @@ -377,7 +377,7 @@ static int bootflow_system(struct unit_test_state *uts)
>>   	if (!IS_ENABLED(CONFIG_EFI_BOOTMGR))
>>   		return -EAGAIN;
>>   	ut_assertok(uclass_first_device_err(UCLASS_BOOTSTD, &bootstd));
>> -	ut_assertok(device_bind(bootstd, DM_DRIVER_GET(bootmeth_efi_mgr),
>> +	ut_assertok(device_bind(bootstd, DM_DRIVER_GET(bootmeth_3efi_mgr),
>>   				"efi_mgr", 0, ofnode_null(), &dev));
>>   	ut_assertok(device_probe(dev));
>>   	sandbox_set_fake_efi_mgr_dev(dev, true);
>> -- 
>> 2.43.0
>>
>>

