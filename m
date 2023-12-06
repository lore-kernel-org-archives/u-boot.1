Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D463C4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 09:23:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BABF086314;
	Wed,  6 Dec 2023 10:23:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Fy/okkhr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20EE586EEE; Wed,  6 Dec 2023 10:23:25 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DF37807D9
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 10:23:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4EF683F65A
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 09:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1701854599;
 bh=VMnL00gUe+vQisfDC7XCxAeEGL3fLcp1DUMYkyc8IQo=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=Fy/okkhrOsamWWMSTv3Xjub3Spv46hRNTpBuStoqU711AapcDwtI0kECgrAxk5ajP
 XTrEIvtTbzO1zyFqD7JDMvFEX0tAhJSd4QZtem/yGpnvQBgH+OKu9UjaebwPo2EDcE
 R8l+keTDyGO5XD5lUZtqw4cfLX5jih3G9HG2EJaGphc7UUt6eLj6S7C/C0gGns8h/k
 UyEAfQ9Fwy+aGsd29S+RJ/wUctjylVVkNcNCQ9knsHrlLH4O9kTSjXnR8rUGHh/yZp
 Hhq0KJQ+JZlKrVCvWUaU/Vl1xkTUiNl1YBYZlaild5oxT5LRVK7oOkV7nSQlyFwkVo
 c98/N/EMsqghQ==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-40c032abab6so33842405e9.3
 for <u-boot@lists.denx.de>; Wed, 06 Dec 2023 01:23:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701854599; x=1702459399;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VMnL00gUe+vQisfDC7XCxAeEGL3fLcp1DUMYkyc8IQo=;
 b=wIKJOm55TgAOQtN29zZcRl6hUsBb/2kZxnug4g0jAhZTpyT9o1Beixy1Fa5wCsgHAv
 DNUXbu8TpRA8qGFoJzBeuJpANHFUeZYgKhwqUQxECBlZdNQG520FMmdEn2f7GM2n0SV8
 32XxAFJrIiGhR+7CQI+KSp6RkJNbOdb+f1KXgUr+AqAHJyP/Jf/kBzyZaUXEuq9L/kzY
 YrtRiGeyyjbi9Z/XMFFTo4EQNJnq2IqbVtoQchrffGQVcUJeLpxElGgwx4cGQJkVBZIj
 1X0asmggG5qDaKVSDlqRX7UqK90++pKBqmqNrZ+qgQJzto7TTGp1Kic7MnAz5TWCeoQH
 hq5g==
X-Gm-Message-State: AOJu0YwrTuxpx0xQsDpNkJAXYWhqrjF4+dQUKn4yOcfpTNRj95tKo9xN
 WBUCEn6sVjM7Krw/5JGgfco2hrk4EkjVODvyj4fnI6eHkFu/9WE5WDEiYmD+rszT8o0MYFEHf6z
 xgvjcAdr7RZfYEDpd/YOSezakVsBdKl4=
X-Received: by 2002:a05:600c:474a:b0:40c:837:480f with SMTP id
 w10-20020a05600c474a00b0040c0837480fmr301091wmo.24.1701854598855; 
 Wed, 06 Dec 2023 01:23:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHsXnghlXBOZpuB5hj2wpdLkGQj0RHPrHrVX9YGm852kQhYI3HlKqyWAXs9GFveMKZbpDgt2Q==
X-Received: by 2002:a05:600c:474a:b0:40c:837:480f with SMTP id
 w10-20020a05600c474a00b0040c0837480fmr301086wmo.24.1701854598383; 
 Wed, 06 Dec 2023 01:23:18 -0800 (PST)
Received: from [192.168.123.67] (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 o18-20020a05600c4fd200b0040b45282f88sm24748753wmq.36.2023.12.06.01.23.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Dec 2023 01:23:17 -0800 (PST)
Message-ID: <35373146-3e24-461f-88b7-58eb01be1c45@canonical.com>
Date: Wed, 6 Dec 2023 10:23:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] efi_loader: boot options should relate to the ESP
To: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
References: <20231205023751.61679-1-heinrich.schuchardt@canonical.com>
 <CADQ0-X9Euv7UwVS49N=DvQxN+O_+6fq_jJw=Jiqauau6TyLpUg@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CADQ0-X9Euv7UwVS49N=DvQxN+O_+6fq_jJw=Jiqauau6TyLpUg@mail.gmail.com>
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

On 05.12.23 07:23, Masahisa Kojima wrote:
> Hi Heinrich,
> 
> On Tue, 5 Dec 2023 at 11:38, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> * Only generate removable media entries for EFI system partitions.
>> * Only offer EFI system partitions for boot options in the eficonfig
>>    command.
>>
>> Fixes: c416f1c0bcab ("bootmenu: add removable media entries")
>> Fixes: 87d791423ac6 ("eficonfig: menu-driven addition of UEFI boot option")
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   cmd/eficonfig.c              | 6 ++++--
>>   lib/efi_loader/efi_bootmgr.c | 3 ++-
>>   2 files changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/cmd/eficonfig.c b/cmd/eficonfig.c
>> index 34a59cb15d..c066b28b6b 100644
>> --- a/cmd/eficonfig.c
>> +++ b/cmd/eficonfig.c
>> @@ -626,8 +626,10 @@ static efi_status_t eficonfig_select_volume(struct eficonfig_select_file_info *f
>>          efi_handle_t *volume_handles = NULL;
>>          struct efi_simple_file_system_protocol *v;
>>
>> -       ret = efi_locate_handle_buffer_int(BY_PROTOCOL, &efi_simple_file_system_protocol_guid,
>> -                                          NULL, &count, (efi_handle_t **)&volume_handles);
>> +       /* Find all EFI system partitions */
>> +       ret = efi_locate_handle_buffer_int(BY_PROTOCOL,
>> +                                          &efi_system_partition_guid,
>> +                                          NULL, &count, &volume_handles);
> 
> UEFI specification v2.10 section '3.5 Boot Mechanisms' says
> "EFI can boot from a device using the EFI_SIMPLE_FILE_SYSTEM_PROTOCOL or the
> EFI_LOAD_FILE_PROTOCOL."
> 
> So in my understanding of the UEFI spec, I think
> efi_simple_file_system_protocol_guid
> is correct here.
> 
>>          if (ret != EFI_SUCCESS) {
>>                  eficonfig_print_msg("No block device found!");
>>                  return ret;
>> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
>> index 48153bd5ff..9e84391186 100644
>> --- a/lib/efi_loader/efi_bootmgr.c
>> +++ b/lib/efi_loader/efi_bootmgr.c
>> @@ -1047,8 +1047,9 @@ efi_status_t efi_bootmgr_update_media_device_boot_option(void)
>>          efi_handle_t *volume_handles = NULL;
>>          struct eficonfig_media_boot_option *opt = NULL;
>>
>> +       /* Find all EFI system partitions */
>>          ret = efi_locate_handle_buffer_int(BY_PROTOCOL,
>> -                                          &efi_simple_file_system_protocol_guid,
>> +                                          &efi_system_partition_guid,
> 
> In EDK II reference implementation[0], it enumerates all
> block_io_protocol devices
> and eliminates logical partitions.
> Should we do the same? If yes, I can prepare the patch on this.

This is what the boot options look like on an EDK II system:

$ efibootmgr -v
BootCurrent: 000D
Timeout: 3 seconds
BootOrder: 
000D,000B,000C,0003,0004,0005,0006,0007,0008,0009,000A,0000,0001,0002
Boot0000* UiApp 
FvVol(5eda4200-2c5f-43cb-9da3-0baf74b1b30c)/FvFile(462caa21-7614-4503-836e-8ab6f4662331)
Boot0001* helloworld 
VenHw(0d51905b-b77e-452a-a2c0-eca0cc8d514a,000054f20000000000)/Sata(1,65535,0)/HD(1,GPT,40c323d0-6b76-47c4-bc82-e05bf5d23c9f,0x2000,0x200000)/File(\helloworld.efi)h.e.l.l.o. 
.w.o.r.l.d...
Boot0002* UEFI Crucial_CT128M550SSD1 14270C7CFEFE 
VenHw(0d51905b-b77e-452a-a2c0-eca0cc8d514a,000054f20000000000)/Sata(1,65535,0)N.....YM....R,Y.
Boot0003* UEFI eMMC Device 
VenHw(0d51905b-b77e-452a-a2c0-eca0cc8d514a,00006ef00000000000)/eMMC(0)/Ctrl(0x0)N.....YM....R,Y.
Boot0004* UEFI eMMC Device 2 
VenHw(0d51905b-b77e-452a-a2c0-eca0cc8d514a,00006ef00000000000)/eMMC(0)/Ctrl(0x1)N.....YM....R,Y.
Boot0005* UEFI eMMC Device 3 
VenHw(0d51905b-b77e-452a-a2c0-eca0cc8d514a,00006ef00000000000)/eMMC(0)/Ctrl(0x2)N.....YM....R,Y.
Boot0006* UEFI PXEv4 (MAC:000000000001) 
MAC(000000000001,1)/IPv4(0.0.0.00.0.0.0,0,0)N.....YM....R,Y.
Boot0007* UEFI PXEv4 (MAC:000000000002) 
MAC(000000000002,1)/IPv4(0.0.0.00.0.0.0,0,0)N.....YM....R,Y.
Boot0008* UEFI PXEv4 (MAC:000000000003) 
MAC(000000000003,1)/IPv4(0.0.0.00.0.0.0,0,0)N.....YM....R,Y.
Boot0009* UEFI PXEv4 (MAC:000000000004) 
MAC(000000000004,1)/IPv4(0.0.0.00.0.0.0,0,0)N.....YM....R,Y.
Boot000A* UEFI Shell 
FvVol(5eda4200-2c5f-43cb-9da3-0baf74b1b30c)/FvFile(7c04a583-9e3e-4f1c-ad65-e05268d0b4d1)
Boot000B* UEFI HL-DT-ST DVDRAM GTC0N 
VenHw(0d51905b-b77e-452a-a2c0-eca0cc8d514a,000054f40000000000)/Sata(1,65535,0)N.....YM....R,Y.
Boot000C* ubuntu 
HD(1,GPT,5a1ba4fc-f9b4-4da2-b5e1-065e9cd10e3a,0x800,0x100000)/File(\EFI\ubuntu\grubaa64.efi)
Boot000D* grub 
HD(1,GPT,5a1ba4fc-f9b4-4da2-b5e1-065e9cd10e3a,0x800,0x100000)/File(\EFI\grub\shimaa64.efi)
Boot1001* helloworld 
HD(1,GPT,40c323d0-6b76-47c4-bc82-e05bf5d23c8f,0x2000,0x200000)/File(helloworld.efi)

As you described autogenerated boot options are on block device level 
irrespective of the existence of an ESP.

EDK II does not to care if /EFI/BOOT/BOOT<ARCH>.EFI is on a partition 
with the ESP partition type.

We should try to mimic the EDK II behavior.

Best regards

Heinrich

> 
> [0] https://github.com/tianocore/edk2/blob/master/MdeModulePkg/Library/UefiBootManagerLib/BmBoot.c#L2220
> 
> Regards,
> Masahisa Kojima
> 
>>                                             NULL, &count,
>>                                             (efi_handle_t **)&volume_handles);
>>          if (ret != EFI_SUCCESS)
>> --
>> 2.40.1
>>

