Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72425C021B3
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 02:18:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57CE280F5C;
	Fri, 21 Feb 2025 03:18:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="f2+69NDr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B09F806FE; Fri, 21 Feb 2025 03:18:16 +0100 (CET)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DB798004F
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 03:18:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6e65acc886fso2775196d6.3
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 18:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740104289; x=1740709089; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uaWYt3BPCMNdW0vZC3JO5qurErFVxCpmtAxB56ImiTk=;
 b=f2+69NDrpUuJVl2pSdBpCF/WcsmSV5nB5GwGWh8H2/VwJsSdC+vKc6m+6pIlqQtGKi
 piPGWYpuKgVS4Ew3pkZtW4kp5YFqi+539r/vdKN1A2vXOfd38N1XG2hIvpcarnWD85l1
 levfsdNGlKUjPF9VU4hQwMeL4b2jVcJGO9qp4iaOn9Tutt6GrgqleicNTuaTcUIGVyz+
 LIqjLkQ+dNCFlXMYcA9vXi4TrYG+RbwF6SwxjhOD2fjpM8ku/+CI2lJdv6PAur0TQ0Q8
 TaYV38gjb5oyWycvVUWkZfvO9EDjo8Tpy+emF7G33ick/J+tQChDtQP0pCg7/2B5Mf7Z
 BnOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740104289; x=1740709089;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uaWYt3BPCMNdW0vZC3JO5qurErFVxCpmtAxB56ImiTk=;
 b=dCRbtZAh1iuQ0NP5g/2O30qZsUH3MW/iDhjCtKqz+kVb9VB/dxKuxEBb0wxfX++vDm
 NhB7mtPcHfHnaZMifdL5SyHmQ1A5sjS9Ypwb1/OlDMvmJ4kAOhoz+Iawt3VGbSnlSA9k
 /BxHU28O0PRUpKjGuJAg49jxjljSAuOHedDntHfh4QY9vpaQaUgQh972ROXjruNIVcsg
 WM9+zoFgmWMsR1ovi6Hl2UpCZlmlUZw16Lf1gyX4IkhvZ/QEHJ5bMetat7EQ65UxqNzF
 R529mWJlcoOy1cMKZEABD0SJjX7W1t28jjOJEniu/SvJIhBfaKPe7ewfPZuCUhaKW0kD
 ybdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIW9ynz5kxsLcPGkoRcB/hvxHqF4wWbZwi8mcpdQtVtmiglkrvNjA+fjOwjiiijnpHXRfHbE4=@lists.denx.de
X-Gm-Message-State: AOJu0YzEUdH5ZmRtd/UYkbJ5v1QrHdA7JShasakYg7yxFEbk7u7tS6Q0
 6d+ijx69/vHnPPyYVFLTTuXXol2dudqiQxX3CgyqLdDO5al5qjN1pgvFvQ==
X-Gm-Gg: ASbGncvLhdl4J7dJbK0qFuVmNiaZnTospP7DdQuAeIBAgkU9hZ6u1cgs6hBf9Zkm+GR
 j9zyfCHZAQ4v+pL/3LPuErQWQYkKv1QIa/az/7AQra5O7IuTYVSwzAtSG0/totIb1zHif2SS/Ti
 v70mzyKt88ZkqzhiwKeF7lqz7KWR0sBam2xfwZWKagKPiRL8x0agefELUi2lHW7rkhK2m46+kJn
 yc3qSQDcs7DXRqWyyefuOgTaWQtYA2mgZ52ZpLrgtyXG/QDD45rzVgQTtWh86pm4lRl7b6LfrXg
 hfYDTmiyK47zlqP+G/z2L6ZQP7XmQIlTtKv92/jT0UzM8G2kdRX5oOAWPg9JYKVOFcXJdif8//6
 mEg==
X-Google-Smtp-Source: AGHT+IFXs/dk6SmAS/2Oe7B61WnlXOEfQNcAscbVZ3KL5wl5Gt0fiXI6g0KlNqkURNTw6Vpgmb88xw==
X-Received: by 2002:a05:6214:f27:b0:6d8:aa37:fe17 with SMTP id
 6a1803df08f44-6e6ae82469cmr7720736d6.5.1740104289300; 
 Thu, 20 Feb 2025 18:18:09 -0800 (PST)
Received: from [192.168.1.201] (pool-108-28-192-105.washdc.fios.verizon.net.
 [108.28.192.105]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e65daffd71sm92277316d6.101.2025.02.20.18.18.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2025 18:18:08 -0800 (PST)
Message-ID: <3691d944-0ddc-c617-60df-43adde3abe1e@gmail.com>
Date: Thu, 20 Feb 2025 21:18:06 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [BUG report] spl: image size check fails in spl_load()
Content-Language: en-US
To: Anshul Dalal <anshuld@ti.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Cc: "Raghavendra, Vignesh" <vigneshr@ti.com>
References: <20250214111251.2349093-1-anshuld@ti.com>
 <8a2961af-fbaa-74f6-8f2a-be9dd5e84a8a@gmail.com>
 <D7VCHLXD35RU.EG0QM37AEZ3X@ti.com>
 <b8af49dd-7999-a89f-600c-2d337bc6bb66@gmail.com>
 <D7X0SJC303BY.Y2SK7Q0VHNTT@ti.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <D7X0SJC303BY.Y2SK7Q0VHNTT@ti.com>
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

On 2/20/25 00:22, Anshul Dalal wrote:
> On Wed Feb 19, 2025 at 9:17 PM IST, Sean Anderson wrote:
>> On 2/18/25 01:07, Anshul Dalal wrote:
>>> On Sat Feb 15, 2025 at 11:18 PM IST, Sean Anderson wrote:
>>>> On 2/14/25 06:12, Anshul Dalal wrote:
>>>>> Hi all!
>>>>>
>>>>> I was trying to implement falcon boot on TI AM62x EVM with the kernel image on
>>>>> SD card's filesystem but the following check in `_spl_load` at
>>>>> `include/spl_load.h:95` fails to -EIO as per the latest commit [89d3333]:
>>>>>
>>>>> 	return read < spl_image->size ? -EIO : 0;
>>>>>
>>>>> The check seems to be comparing the image size gathered from the header
>>>>> (spl_image->size) with the number of bytes read form the loader.
>>>>>
>>>>>    From spl_load.h:
>>>>>
>>>>> 	ret = spl_parse_image_header(spl_image, bootdev, header);
>>>>> 	if (ret)
>>>>> 		return ret;
>>>>>
>>>>> 	base_offset = spl_image->offset;
>>>>> 	/* Only NOR sets this flag. */
>>>>> 	if (IS_ENABLED(CONFIG_SPL_NOR_SUPPORT) &&
>>>>> 	    spl_image->flags & SPL_COPY_PAYLOAD_ONLY)
>>>>> 		base_offset += sizeof(*header);
>>>>> 	image_offset = ALIGN_DOWN(base_offset, spl_get_bl_len(info));
>>>>> 	overhead = base_offset - image_offset;
>>>>> 	size = ALIGN(spl_image->size + overhead, spl_get_bl_len(info));
>>>>>
>>>>> 	read = info->read(info, offset + image_offset, size,
>>>>> 			  map_sysmem(spl_image->load_addr - overhead, size));
>>>>>
>>>>> 	if (read < 0)
>>>>> 		return read;
>>>>>
>>>>> 	return read < spl_image->size ? -EIO : 0;
>>>>>
>>>>> During kernel build process the header size is computed including the BSS
>>>>> whereas it's removed when creating the uncompressed image. Therefore the size
>>>>> of the uncompressed image on filesystem will be smaller than the size specified
>>>>> in the header. Which leads to failure of the above check.
>>>>>
>>>>>    From linux kernel's `arch/arm64/kernel/image.h:63`:
>>>>>
>>>>> 	#define HEAD_SYMBOLS						\
>>>>> 		DEFINE_IMAGE_LE64(_kernel_size_le, _end - _text);	\
>>>>> 		DEFINE_IMAGE_LE64(_kernel_flags_le, __HEAD_FLAGS);
>>>>>
>>>>> Disabling the check leads to a successful boot directly to the kernel.
>>>>> Therefore it seems like the check is non functional as the size in the kernel
>>>>> header does not correspond with the file size of the kernel image.
>>>>
>>>> Did this work before v2024.04?
>>>>
>>>
>>> No, the check existed by v2024.04. I tested on the commit prior to
>>> 775074165d97 (the commit that added the check) and falcon boot works.
>>
>> Sorry, that's what I meant. E.g. did this work in v2024.01 etc.
>>
>> Just wanted to determine whether this was a bug or a feature request.
>>
>>>> How exactly are you loading your image? E.g. what are the values of
>>>>
>>>
>>> I have my DTB and kernel Image on the 1st partition of the SD card which
>>> is FAT. Which also includes the u-boot.img in case falcon fails and we
>>> need a fallback.
>>>
>>>> CONFIG_SPL_OS_BOOT
>>>> CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR
>>>> CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
>>>> CONFIG_SPL_FALCON_BOOT_MMCSD
>>>> CONFIG_SPL_FS_FAT
>>>> CONFIG_SPL_FS_EXT4
>>>> CONFIG_SPL_FS_LOAD_PAYLOAD_NAME
>>>> CONFIG_SUPPORT_EMMC_BOOT
>>>>
>>>
>>> Since I'm not booting from RAW mmc but instead FS boot, I don't think
>>> the SYS_MMCSD_RAW_* configs are relevant but in any case:
>>>
>>> CONFIG_SPL_OS_BOOT=y
>>> CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
>>> # CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION is not set
>>> # CONFIG_SPL_FALCON_BOOT_MMCSD is not set
>>> CONFIG_SPL_FS_FAT=y
>>> # CONFIG_SPL_FS_EXT4 is not set
>>> CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"
>>> # CONFIG_SUPPORT_EMMC_BOOT is not set
>>>
>>> Some other relevant configs:
>>>
>>> CONFIG_SYS_MMCSD_FS_BOOT=y
>>> CONFIG_SYS_MMCSD_FS_BOOT_PARTITION=1
>>> CONFIG_SPL_PAYLOAD_ARGS_ADDR=0x82000000
>>> CONFIG_SPL_FS_LOAD_KERNEL_NAME="Image"
>>> CONFIG_SPL_FS_LOAD_ARGS_NAME="k3-am625-sk.dtb"
>>>
>>>>    From what I can tell, the OS_BOOT path should not call spl_load in the first place.
>>>
>>> It is called from spl_load_image_fat which is in turn called by
>>> spl_load_image_fat_os as it's last return statement during falcon boot.
>>
>> Ah, there it is. This function is used both by OS_BOOT and regular boot. I intentionally
>> tried not to touch the OS_BOOT path, but it looks like one change got in anyway.
>>
>>>>
>>>> In any case, the root problem is that the size reported by the kernel is actually the
>>>> space the kernel will need when it is loaded, and not the size of the data to load
>>>> (which we need). So if we have a short read, we have no way of knowing if the filesystem
>>>> is corrupt, the image was truncated while writing, or if it's just missing the bss. And
>>>> we still have to rely of the image size so that we can load from e.g. NAND or SPI where
>>>> there is no filesystem.
>>>>
>>>
>>> There seems to be no way to get the actual size of the kernel image just
>>> from the image header. I think we should drop the check (at least in
>>> case of FS boot without a FIT image). On NAND or SPI, the size from the
>>> header would be larger than the actual file size. So, at worst we would
>>> have read some extra data where BSS was supposed to be anyways.
>>>
>>>> One way to fix this could be to move the length check to spl_load_info->read. This would
>>>> involve updating all the callers and callees.
>>>>
>>>
>>> I think it would be better handled in spl_load where we can more easily
>>> have separate checks for FIT and a kernel image whereas
>>> spl_info_info->read would have no way of knowing if the binary type
>>> without passing in the header as well.
>>
>> Yeah, I thought about this after I sent the email...
>>
>>> I suggest we do something like the following in spl_load:
>>>
>>> 	if (image_get_magic(header) == FDT_MAGIC)
>>> 		return read < spl_image->size ? -EIO : 0;
>>> 	else
>>> 		return read == 0 ? -EIO : 0;
>>
>> I would prefer not doing this sort of thing since it grows the size of every SPL, but only a
>> few do falcon boot. Maybe it's better to skip the size check only for OS_BOOT and CMD_BOOTI.
>>
>> Or maybe we can move this hack to spl_fit_read. i.e:
>>
>> 	ret = fat_read_file(filename, buf, file_offset, size, &actread);
>> 	if (ret)
>> 		return ret;
>>
>> 	if (CONFIG_IS_ENABLED(OS_BOOT) && IS_ENABLED(CMD_BOOTI))
>> 		return size;
>> 	else
>> 		return actread;
>>
>> I think this would have the least impact overall.
>>
> 
> Looks good to me, we would need to do the same for ext4 in spl_ext.c. I
> can send a patch with the fix if you'd like.

Sure.

--Sean
