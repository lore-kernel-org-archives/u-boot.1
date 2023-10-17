Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21AB7CDB474
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 23:06:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2C0A86CB1;
	Wed, 18 Oct 2023 01:06:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="G4y0p4Lz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08DE386DD5; Wed, 18 Oct 2023 01:06:20 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EF3E86C6E
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 01:06:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 51EFC3F443
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 23:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1697583976;
 bh=CTQ38Ko697/r//SevzJ3GEVVN6tpRi+MkJaK+Va4V2M=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=G4y0p4LzS2EVV+lYCmO7qIh6kuks9t0m5W77i1Sfxx4PyXdAmIcUYf6YVf8+5FkUg
 RP7eTnOQi2Th2bfgwhVemHw4kngYvrZY1QSMfwF7gRUrx4Yt0kcRZE5F89suhLXwOj
 +ePyVmpJIW9sZ5mtpbucIFSKSLbRiFLg3DpRl5gSVX/2GWunzJQt29KvlNecJFcV+S
 iOWBFrnI9rq/dESrJ9KJ42tiRS4kC6d/ADQhiJkX80GHFbIJOiwXOA/MEA9YupLTjO
 tPHO4gl09cBazmuMFVLvtxquXdZHMHROO5AA4mZ6ycdnbVVMc9rGqyGDSDWU3LUmaB
 wGu72D+zb9e+A==
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40839252e81so2706515e9.3
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 16:06:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697583976; x=1698188776;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CTQ38Ko697/r//SevzJ3GEVVN6tpRi+MkJaK+Va4V2M=;
 b=ILO+R1FV7wwoBDN1ZopIHfgy6QrPOFy121cG2KKQd08iHiRi8OV46bg/8QxHbCIq0W
 E9nkaoQ6kmBf23Sa5JFvHmQKdL2FDfNwDlaXcBLVNwD0M9WGJ+dLMUT/ZXoB4VSn8gra
 t+WNlYDx9qUW0+dkf9VBgBjG7ooTf3wCfseWTFNgebmK5oXRk5pUuYROxgFmowLSta/b
 /5z89z7oedrr1k54T1ngLBj7twUfYYW3rVuqFblPZ5iMu5KTIn3Xvu71kb7uB05XOgsb
 Y07EHUmOsyT/XUKa/aqzz2AoWa8BpFjs8qj2yMoUiRgKxK35BAzOYyeiOAOE37Qasm+s
 Weyw==
X-Gm-Message-State: AOJu0YyMX5J+thSJaTjKwhK82X/ENfjiRVYK8ElVuCnTZTF29+AO62sS
 SmnoEISlC9qORu4Rs5gMIjNyEV4T7zs1u59nzAz5ewH2pbskJPS1JdRWCjP6YHoTkDO9ctUUcpY
 HwVxHQzbnICBZPs2FFSKJWSPx0skyT1k=
X-Received: by 2002:a05:600c:354c:b0:407:7e7a:6017 with SMTP id
 i12-20020a05600c354c00b004077e7a6017mr2928062wmq.11.1697583975861; 
 Tue, 17 Oct 2023 16:06:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHU4EQNK+xv8FzMOkrjKSI9Rki241yXbgzMLBpzOFRrduQCGkUr49u4j75BBf5wP/rujw6Vxw==
X-Received: by 2002:a05:600c:354c:b0:407:7e7a:6017 with SMTP id
 i12-20020a05600c354c00b004077e7a6017mr2928051wmq.11.1697583975450; 
 Tue, 17 Oct 2023 16:06:15 -0700 (PDT)
Received: from [192.168.123.67] (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 o30-20020a05600c511e00b004063cd8105csm140818wms.22.2023.10.17.16.06.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Oct 2023 16:06:14 -0700 (PDT)
Message-ID: <a3794e0f-1889-45b2-911b-0b81c5ef1203@canonical.com>
Date: Wed, 18 Oct 2023 01:06:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] efi_loader: expose the device-tree file name
Content-Language: en-US
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: ilias.apalodimas@linaro.org, u-boot@lists.denx.de
References: <20231017085507.12094-1-heinrich.schuchardt@canonical.com>
 <87wmvlqnwl.fsf@bloch.sibelius.xs4all.nl>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <87wmvlqnwl.fsf@bloch.sibelius.xs4all.nl>
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

On 17.10.23 17:17, Mark Kettenis wrote:
>> From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> Date: Tue, 17 Oct 2023 10:55:07 +0200
>>
>> Forward and backward compatibility of Linux kernel device-trees is
>> sometimes missing. One solution approach is to load a kernel specific
>> device-tree. This can either be done via a U-Boot scripts (like the one
>> generated by Debian package flash-kernel or by a boot loader like GRUB.
>> The boot loader approach currently requires to know the device-tree name
>> before first boot which makes it unusable for generic images.
> 
> Even if the device trees are compatible, we often see that additonal
> nodes get added at a later stage.  So the ability to load a more
> complete device tree for the OS is useful and means a user doesn't
> necessarily need to update U-Boot to make additional devices work in
> their OS.

OpenBSD should call the EFI_DT_FIXUP_PROTOCOL exposed by U-Boot after 
loading device-trees.

https://github.com/U-Boot-EFI/EFI_DT_FIXUP_PROTOCOL

> 
>> Expose the device-tree file name as EFI variable FdtFile.
>> This will allow bootloaders to load a kernel specific device-tree.
> 
> Right.  I'm considering adding support for loading device trees to the
> OpenBSD bootloader and this feature would be really useful since it
> would allow me to automagically load the right device tree from the
> root filesystem of the OS.
> 
> Is my understanding right that this is a null-terminated (8-bit) ASCII
> string?  Can this variable be documented somewhere, maybe together
> with the EFI_DT_FIXUP_PROTOCOL?

Yes, the string is NUL terminated ASCII. The best place for 
documentation would be the EBBR specification.

Best regards

Heinrich

> 
> 
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   lib/efi_loader/efi_setup.c | 26 ++++++++++++++++++++++++++
>>   1 file changed, 26 insertions(+)
>>
>> diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
>> index e6de685e87..b24feb94dc 100644
>> --- a/lib/efi_loader/efi_setup.c
>> +++ b/lib/efi_loader/efi_setup.c
>> @@ -26,6 +26,27 @@ void __weak allow_unaligned(void)
>>   {
>>   }
>>   
>> +/**
>> + * efi_init_fdtfile() - set EFI variable FdtFile
>> + *
>> + * Return:	status code
>> + */
>> +static efi_status_t efi_init_fdtfile(void)
>> +{
>> +	char *val;
>> +
>> +	val = env_get("fdtfile");
>> +	if (!val)
>> +		return EFI_SUCCESS;
>> +
>> +	return efi_set_variable_int(u"FdtFile",
>> +				    &efi_u_boot_guid,
>> +				    EFI_VARIABLE_BOOTSERVICE_ACCESS |
>> +				    EFI_VARIABLE_RUNTIME_ACCESS |
>> +				    EFI_VARIABLE_READ_ONLY,
>> +				    strlen(val) + 1, val, false);
>> +}
>> +
>>   /**
>>    * efi_init_platform_lang() - define supported languages
>>    *
>> @@ -250,6 +271,11 @@ efi_status_t efi_init_obj_list(void)
>>   	if (ret != EFI_SUCCESS)
>>   		goto out;
>>   
>> +	/* Define EFI variable FdtFile */
>> +	ret = efi_init_fdtfile();
>> +	if (ret != EFI_SUCCESS)
>> +		goto out;
>> +
>>   	/* Indicate supported features */
>>   	ret = efi_init_os_indications();
>>   	if (ret != EFI_SUCCESS)
>> -- 
>> 2.40.1
>>
>>

