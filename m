Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A82D3CDB474
	for <u-boot@archiver.kernel.org>; Sun, 22 Oct 2023 16:34:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A711C87741;
	Sun, 22 Oct 2023 18:34:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="P+DNb0Zw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 086DE87751; Sun, 22 Oct 2023 18:34:10 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C71D187733
 for <u-boot@lists.denx.de>; Sun, 22 Oct 2023 18:34:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D10273F129
 for <u-boot@lists.denx.de>; Sun, 22 Oct 2023 16:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1697992443;
 bh=USnvCTXvJR7I7aYXFjxnzxqlwV0MhzcNErEvmQjCIRE=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=P+DNb0ZwvrFrRrPdMibEcu5S1EimgEQi26L7XpbUGCxvHKxGn7rXava+0u5ESVllP
 Gr2WBUXJ5go2ko9B5wyfR70cYB1tJWYWevE76YhQKJ6aIVHcpHx6k/TFq6MG1hAE9k
 Ylwd6Orj+jy5+0QOt6NxenqWQlEZNepyTEvgHL5GezV90MmCY8Nbo5CH4viGnfpmkO
 Jaon42fc2G7XeQDpF8gVQn1rBiQK5k+bPJeZ3hSW3v8PhCY5kpZYfEk9pwsG4MrovK
 TvQIDGZZCEXsuKoY0ucrbHfvhSfue25vJIB1DGue8yDVNcx4/eLcWmgJq/Gm1Bcdbh
 FRuoANML/NeZg==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4083c9b426fso16015075e9.2
 for <u-boot@lists.denx.de>; Sun, 22 Oct 2023 09:34:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697992443; x=1698597243;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=USnvCTXvJR7I7aYXFjxnzxqlwV0MhzcNErEvmQjCIRE=;
 b=JgBBzCNQAKVjsv7U/doUckMDjezpSig/+rm42qmOir9nlwiPV/2X0jj+ZqP6OeozZ6
 Aa3nlLMm+0a/cRfcwdKQhGNC1v+0KfsW7oRgZ0i/nbVk/tLkqAOBPmOgdTUUjaNV+MVd
 09gDGm2Plybk4O4cBIO2k8If+AH5vOBw/mOljiWM+8Jp5D5I7ATAxRfdFCeF4O8j6TqH
 +G8YRq4mwZrNAkYOZ3qPKVfmg25t1Ebe96GGa12CWU3lbOr8irl1mpVExqvAD4tFrOpE
 9NXRkvOFcwQyzkADQ4PwYnU5iJpHQYHMXaxQoY+tFgabqbS4aqoweLKFfsRKM8dgqRwc
 Sj8w==
X-Gm-Message-State: AOJu0YyBtvhIjjb4RcE48AwF9gaX3FEiuVnX8f+k+F/Y3dtM0x0//1g5
 4hNlNU5fHK5FhLzi3jRiwYwhvqs/2k6y0jpm4Etzw8Dq4e4k9FGy5iVm4DUYfzSpECtbQQVJY42
 Svi3d87qFnP776tnpy9i7WS/t15aaXO0=
X-Received: by 2002:a05:600c:4445:b0:408:80bb:ae80 with SMTP id
 v5-20020a05600c444500b0040880bbae80mr2514002wmn.7.1697992443356; 
 Sun, 22 Oct 2023 09:34:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9DkmuXDGx/RE2qRnMXbOVWQbSJS23O84Z1Jw49lTsFDL3fK25QFfqSpyDem3Hm4HDR5p4cQ==
X-Received: by 2002:a05:600c:4445:b0:408:80bb:ae80 with SMTP id
 v5-20020a05600c444500b0040880bbae80mr2513989wmn.7.1697992442878; 
 Sun, 22 Oct 2023 09:34:02 -0700 (PDT)
Received: from [192.168.123.94] (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 ay10-20020a05600c1e0a00b00405442edc69sm9500201wmb.14.2023.10.22.09.34.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 Oct 2023 09:34:02 -0700 (PDT)
Message-ID: <4c4fee5a-82ab-46e2-a450-f874b2a9ad5c@canonical.com>
Date: Sun, 22 Oct 2023 18:34:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] efi_loader: expose the device-tree file name
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>
References: <20231022084733.113326-1-heinrich.schuchardt@canonical.com>
 <20231022155543.GC496310@bill-the-cat>
Content-Language: en-US, de-DE
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20231022155543.GC496310@bill-the-cat>
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

On 10/22/23 17:55, Tom Rini wrote:
> On Sun, Oct 22, 2023 at 10:47:33AM +0200, Heinrich Schuchardt wrote:
> 
>> Forward and backward compatibility of Linux kernel device-trees is
>> sometimes missing. One solution approach is to load a kernel specific
>> device-tree. This can either be done via a U-Boot scripts (like the one
>> generated by Debian package flash-kernel or by a boot loader like GRUB.
>> The boot loader approach currently requires to know the device-tree name
>> before first boot which makes it unusable for generic images.
>>
>> Expose the device-tree file name as EFI variable FdtFile.
>> This will allow bootloaders to load a kernel specific device-tree.
>>
>> The variable will not be exposed on ACPI based systems or if the
>> environment variable fdtfile is not defined.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>> v3:
>> 	Add documentation
>> v2:
>> 	Use a unique GUID to enable future U-Boot independent
>> 	standardization.
>> 	Do not try to add the variable on ACPI based systems.
>> ---
>>   doc/develop/uefi/uefi.rst  | 17 +++++++++++++++++
>>   include/efi_loader.h       |  5 +++++
>>   lib/efi_loader/efi_setup.c | 30 ++++++++++++++++++++++++++++++
>>   3 files changed, 52 insertions(+)
>>
>> diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
>> index fb16ac743a..a81d09ae81 100644
>> --- a/doc/develop/uefi/uefi.rst
>> +++ b/doc/develop/uefi/uefi.rst
>> @@ -916,6 +916,23 @@ So our final format of the FilePathList[] is::
>>   
>>       Loaded image - end node (0xff) - VenMedia - initrd_1 - [end node (0x01) - initrd_n ...] - end node (0xff)
>>   
>> +EFI variable FdtFile
>> +~~~~~~~~~~~~~~~~~~~~
>> +
>> +Ideally U-Boot would always expose a device-tree that can be used for booting
>> +any operating systems. Unfortunately operating systems like Linux sometimes
>> +break forward and backward compatibility. In this case there is a need to load
>> +an operating system version specific device-tree.
>> +
>> +U-Boot has an environment variable fdtfile identifying the device-tree file to
>> +load. The content of this variable is exposed as EFI variable Fdtfile, vendor
>> +GUID d45dde69-3bd6-40e0-90d5-6b606aa57730. It contains the device-tree path
>> +name as a NUL terminated ASCII string.
>> +
>> +On 32bit ARM this is currently only a file name, e.g. 'imx6dl-wandboard.dtb'.
>> +On other architectures the file name is preceded by the vendor directory, e.g.
>> +'rockchip/rk3326-odroid-go2.dtb'.
> 
> The Linux Kernel has split 32bit ARM up by directory now, too.

Since Linux v6.5. That is why I wrote "currently". Once we migrate the 
values of $fdtfile in U-Boot we may want to change 
distro_efi_try_bootflow_files() to search both with and without vendor 
directory.

Are there already plans for that migration?

Best regards

Heinrich
