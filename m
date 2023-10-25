Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62ADAC07545
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 19:57:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 109C087468;
	Wed, 25 Oct 2023 21:57:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="PvXQ5TOH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D599D874CE; Wed, 25 Oct 2023 21:57:42 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 887FC8712B
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 21:57:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E5D843FADB
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 19:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1698263856;
 bh=NfCtIutdOGs7F9GY+4skSc3uQGVyDeIze6TbIDC/leo=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=PvXQ5TOHCY3Wr+yax2+3NS9xDxqLIgFASS2Pw9YCwLEcI3woO0cazdQ9OnOIj/QAH
 CGUfK4fHkabZcF1lAkJQrKU31au6wHJajnVqUPeXxELisOKj0Qdrjd4pVJCbKCsmg+
 PYqBDPsX9iYRfbekQUtuCToYKj8o7RszEDfhCpL8Vv9/Yx9KGWBrurpnmSNjc8Ax5v
 /NIjlSEsYro1iiFjP0xdfB1nr4XRVcPXJ+wjqsHzTrRcqpsb8yg4AHcCPMDqTf+Qi2
 6K7BDfojD+UL8NVEn1mjPSZdQfWzBuLReAbWBvu3EZ6iVkFVOQzR9VVZWEy/WBlCCl
 8HQImlRKjxIcg==
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-40853e14f16so919785e9.1
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 12:57:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698263855; x=1698868655;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NfCtIutdOGs7F9GY+4skSc3uQGVyDeIze6TbIDC/leo=;
 b=a4HEfF9YKCSwv8yybWwWtA+IX/R6HwsrMkp8fU5p8oPzvFokrqEwGabdcA/p8hSvaw
 GhgNueJmctFJL2JZ0QVlSLiuOOjF6zVVJ74mTQ5QhNzz3gUvCzkOCIY4gP084PnH68zI
 X1BgVEAOiNUlIlFFn3VIezXhSoaSrsxfb0cWMLDOlK8NCgFG7jM3MQ8LSmHYPkoV4t8I
 Rvqmy9BnWaSk3Dzvk8LOkTf3uuYrdR5phvIBf02GSUxDFEqJCbBaDZQ+jmOTC2QQBj0v
 Ojxs14T73rmmO92dWhLsnOPNloL4kYkT7k3JG9WewT1E7nKha/XqjJGfzbrU0/h2Q+Uw
 RUXQ==
X-Gm-Message-State: AOJu0Yw2iqScEhAzWyPMISSYsy9ovNv5ajhCOLztUPXx5Nvo2ZTUO8KA
 7B1L2K3alZBYuOo5yT9wImRKVYWj4ZZuY0wimx+z1cvm1QybV0u9hsvgukPVOjytQZ8NAPtVctu
 OOR94tycouzPJOUsVgN3CYfI9DfqfITS1O7ZVvxU=
X-Received: by 2002:a5d:5042:0:b0:32d:c69b:99b8 with SMTP id
 h2-20020a5d5042000000b0032dc69b99b8mr11970763wrt.35.1698263855345; 
 Wed, 25 Oct 2023 12:57:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7UAHsVgiG5nTjLEP0pmGOfH4L1cpYsKg0d4psPzB9AKmbHEbssGYrIcyJfDRMsn9y5wOMAA==
X-Received: by 2002:a5d:5042:0:b0:32d:c69b:99b8 with SMTP id
 h2-20020a5d5042000000b0032dc69b99b8mr11970745wrt.35.1698263854909; 
 Wed, 25 Oct 2023 12:57:34 -0700 (PDT)
Received: from [192.168.123.94] (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 w10-20020adfec4a000000b0032d2f09d991sm12651058wrn.33.2023.10.25.12.57.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Oct 2023 12:57:34 -0700 (PDT)
Message-ID: <1ac5013d-8991-4abd-baad-94776801c58c@canonical.com>
Date: Wed, 25 Oct 2023 21:57:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] efi_loader: expose the device-tree file name
Content-Language: en-US, de-DE
To: Simon Glass <sjg@google.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
References: <20231024062032.8543-1-heinrich.schuchardt@canonical.com>
 <CAPnjgZ07zojtkV6ReQiC3XPf_AW96YnAc6APqhfk7wUDMmyOrA@mail.gmail.com>
 <CAPnjgZ3zFnAaivWa1BaUDbTfzRc-SZ_H8+YSvAKtwBJ64=XftQ@mail.gmail.com>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAPnjgZ3zFnAaivWa1BaUDbTfzRc-SZ_H8+YSvAKtwBJ64=XftQ@mail.gmail.com>
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

On 10/25/23 20:23, Simon Glass wrote:
> Hi Heinrich,
> 
> On Tue, 24 Oct 2023 at 18:02, Simon Glass <sjg@google.com> wrote:
>>
>> Hi Heinrich,
>>
>> On Mon, 23 Oct 2023 at 23:20, Heinrich Schuchardt
>> <heinrich.schuchardt@canonical.com> wrote:
>>>
>>> Forward and backward compatibility of Linux kernel device-trees is
>>> sometimes missing. One solution approach is to load a kernel specific
>>> device-tree. This can either be done via a U-Boot scripts (like the one
>>> generated by Debian package flash-kernel or by a boot loader like GRUB.
>>> The boot loader approach currently requires to know the device-tree name
>>> before first boot which makes it unusable for generic images.
>>>
>>> Expose the device-tree file name as EFI variable FdtFile.
>>> This will allow bootloaders to load a kernel specific device-tree.
>>
>> kernel-specific
>>
>>>
>>> The variable will not be exposed on ACPI based systems or if the
>>> environment variable fdtfile is not defined.
>>>
>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>> ---
>>> v4:
>>>          Generalize the description of the content of $fdtfile.
>>> v3:
>>>          Add documentation
>>> v2:
>>>          Use a unique GUID to enable future U-Boot independent
>>>          standardization.
>>>          Do not try to add the variable on ACPI based systems.
>>> ---
>>>   doc/develop/uefi/uefi.rst  | 14 ++++++++++++++
>>>   include/efi_loader.h       |  5 +++++
>>>   lib/efi_loader/efi_setup.c | 30 ++++++++++++++++++++++++++++++
>>>   3 files changed, 49 insertions(+)
>>>
>>> diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
>>> index fb16ac743a..702c490831 100644
>>> --- a/doc/develop/uefi/uefi.rst
>>> +++ b/doc/develop/uefi/uefi.rst
>>> @@ -916,6 +916,20 @@ So our final format of the FilePathList[] is::
>>>
>>>       Loaded image - end node (0xff) - VenMedia - initrd_1 - [end node (0x01) - initrd_n ...] - end node (0xff)
>>>
>>> +EFI variable FdtFile
>>> +~~~~~~~~~~~~~~~~~~~~
>>> +
>>> +Ideally U-Boot would always expose a device-tree that can be used for booting
>>> +any operating systems. Unfortunately operating systems like Linux sometimes
>>> +break forward and backward compatibility. In this case there is a need to load
>>> +an operating system version specific device-tree.
>>
>> This seems to be a strong statement. Given the effort that goes into
>> the DT, changes are supposed to be backwards-compatible. Is this
>> generally true, or is it just that we want an up-to-date DT for the
>> kernel to enable new features?
> 
> Did you see this comment?

It would have been nice to put the person which made that comment on copy.

The truth lies in the world "supposed":

The idea of a device-tree that never needs to change is quite old and 
never became true on ARM devices.

We all know Linux tends to break both forward and backward compatibility 
of device-trees. Here is a nice example:

d0c6707ca423 ("arm64: dts: allwinner: H5: NanoPi Neo Plus2: phy-mode 
rgmii-id")

Driver changes broke forward and backwards compatibility of a lot of 
Allwinner boards.

Distros will continue to load the device-tree that matches the kernel to 
get the best possible board support and need to do this efficiently.

Best regards

Heinrich

> 
> Regards,
> Simon
> 
>>
>>> +
>>> +U-Boot has an environment variable fdtfile identifying the device-tree file to
>>> +load. The content of this variable is exposed as EFI variable Fdtfile, vendor
>>> +GUID d45dde69-3bd6-40e0-90d5-6b606aa57730. It contains the device-tree path
>>> +name as a NUL terminated ASCII string. On many architectures the file name is
>>
>> NUL-terminated
>>
>>> +preceded by a vendor directory ('vendor-directory/board-name.dtb').
>>> +
>>>   Links
>>>   -----
>>>
>>> diff --git a/include/efi_loader.h b/include/efi_loader.h
>>> index e24410505f..146e7f1bce 100644
>>> --- a/include/efi_loader.h
>>> +++ b/include/efi_loader.h
>>> @@ -152,6 +152,11 @@ static inline efi_status_t efi_launch_capsules(void)
>>>          EFI_GUID(0x8108ac4e, 0x9f11, 0x4d59, \
>>>                   0x85, 0x0e, 0xe2, 0x1a, 0x52, 0x2c, 0x59, 0xb2)
>>>
>>> +/* Vendor GUID for the FdtFile variable */
>>> +#define VENDOR_FDTFILE_GUID \
>>> +       EFI_GUID(0xd45dde69, 0x3bd6, 0x40e0, \
>>> +                0x90, 0xd5, 0x6b, 0x60, 0x6a, 0xa5, 0x77, 0x30)
>>> +
>>>   /* Use internal device tree when starting UEFI application */
>>>   #define EFI_FDT_USE_INTERNAL NULL
>>>
>>> diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
>>> index e6de685e87..71bcde645b 100644
>>> --- a/lib/efi_loader/efi_setup.c
>>> +++ b/lib/efi_loader/efi_setup.c
>>> @@ -17,6 +17,8 @@
>>>
>>>   efi_status_t efi_obj_list_initialized = OBJ_LIST_NOT_INITIALIZED;
>>>
>>> +efi_guid_t vendor_fdtfile_guid = VENDOR_FDTFILE_GUID;
>>> +
>>>   /*
>>>    * Allow unaligned memory access.
>>>    *
>>> @@ -26,6 +28,27 @@ void __weak allow_unaligned(void)
>>>   {
>>>   }
>>>
>>> +/**
>>> + * efi_init_fdtfile() - set EFI variable FdtFile
>>> + *
>>> + * Return:     status code
>>> + */
>>> +static efi_status_t efi_init_fdtfile(void)
>>> +{
>>> +       char *val;
>>> +
>>> +       val = env_get("fdtfile");
>>> +       if (!val)
>>> +               return EFI_SUCCESS;
>>> +
>>> +       return efi_set_variable_int(u"FdtFile",
>>> +                                   &vendor_fdtfile_guid,
>>> +                                   EFI_VARIABLE_BOOTSERVICE_ACCESS |
>>> +                                   EFI_VARIABLE_RUNTIME_ACCESS |
>>> +                                   EFI_VARIABLE_READ_ONLY,
>>> +                                   strlen(val) + 1, val, false);
>>> +}
>>> +
>>>   /**
>>>    * efi_init_platform_lang() - define supported languages
>>>    *
>>> @@ -250,6 +273,13 @@ efi_status_t efi_init_obj_list(void)
>>>          if (ret != EFI_SUCCESS)
>>>                  goto out;
>>>
>>> +       /* Define EFI variable FdtFile */
>>> +       if (!CONFIG_IS_ENABLED(GENERATE_ACPI_TABLE)) {
>>> +               ret = efi_init_fdtfile();
>>> +               if (ret != EFI_SUCCESS)
>>> +                       goto out;
>>> +       }
>>> +
>>>          /* Indicate supported features */
>>>          ret = efi_init_os_indications();
>>>          if (ret != EFI_SUCCESS)
>>> --
>>> 2.40.1
>>>
>>
>> Assuming my concerns above are figured out:
>>
>> Reviewed-by: Simon Glass <sjg@chromium.org>
>>
>> Regards,
>> SImon

