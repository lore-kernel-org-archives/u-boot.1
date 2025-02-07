Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0866CC02192
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 07:43:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 528ED801DE;
	Fri,  7 Feb 2025 08:43:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="ZDMSDv24";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F299C80756; Fri,  7 Feb 2025 08:43:27 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA7FE801BE
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 08:43:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id DD9A93F284
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 07:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1738914203;
 bh=aAoXnppupKjRjyDg3kNBmRqeLoqH2HhwRbcwEtyDW8E=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=ZDMSDv24hrVRiRiFsvPQaT6RMhCewlRVODgrWS6cbmuoznKWDW8CdMqdOpCVBEt4T
 +mhJ6QUG7Nr1/ZaKdoqhNPj4XqBAaDISC/wZdQnnAOPssecJrxZnO+569icVDUe1nP
 PvS3lZ9xaudtLCy5r1MPzabkWULFAH9fTOzEzuqxIDDsGjaUAaK2oqQShyr2lFu33Y
 okB37ADnWlj1rrNaO4EvBelpZY/npnG3gsWEZR5fv26Mqd6Wph2y4eI5fDRixTq2A0
 svju6PWbrRAtelZuMQw5R8g79pbU1KLgKdRNN0oqJzZ1FoaUOKauAgupYe39+cLeZU
 z/W6KoYGLKNQA==
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-38dbe2c0305so570254f8f.3
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 23:43:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738914202; x=1739519002;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aAoXnppupKjRjyDg3kNBmRqeLoqH2HhwRbcwEtyDW8E=;
 b=uRv9C8mhMkBml244SDZxeuAt46muGiJ4BrKILOsAKUToXIfJRTNLLFXv4mz2GFA92L
 odrx+rfwcvmtXA20VG11+uUlDeOketsfuPd08yCunCe4c9+6VoNcod+KLHCwBvOXuVWI
 5CTM/PeCK9PoDeXjLPmRnTpW6F1k/Hgjasv/bGZ2Htz3e8IFMCKPFtRm37vk+8HQf6Mr
 qvrgY5x58ok1nkqizWcthSR2qduOXUqKeVc3MnBRGvAFDQVfhUb40wm8Q1ZZMA3wz+dH
 UxnN0HBsb/43HyPA2kPyyQyImy2ND0zCm8SNlDAGh13IlLh7a8o5bgldL6QFFpIdtDmt
 ChKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlM3Kg8Yu6E8bcoDb7emAVmETLeEjN7MWyg34e4rOvsTdGcs7PxEY1UgGuOTFGEiGb5oPQPtI=@lists.denx.de
X-Gm-Message-State: AOJu0Yy0UrOjMcWK9WNqVP0JKoXr+/0g+Lmo+VTfDeTloQ5s5eTsWoS6
 tZWjgZjAAX2AYRD/Z+X9+BBvFDQGCr7a7G80tcysBnh8YGl2ipqRzM9Ki47aUZ8ed1vf3PELu3N
 q6MftjKmQMwWywm/l7R+V+u78oZLdkzPIyF3+cnQ//ddBLMq/Zh1O5s0hjOVvUytQ7C0=
X-Gm-Gg: ASbGncuofvfW/reI02qQ3WE53NYf8kKYXas6Ggq/WKrIg4oiC4FL7FRmV8W91SwtVO+
 8qlXmNbD60fWGOYyj3hiu8j38znTM47A1X9TF653li4ZHT+nGc74keRarm3yAz34ipKgpXrrfTX
 SagHfDXvK60TkOWZtdRzPQLdlptZmkyqSALAT6QZtvGNL1xf1hUl2ap//LYxBV2rQMtO/mRQtUO
 JTGzOoYv6IHtpsP4VMaUoJDi/06k+WBBylQ6RZRDxxbLrG+5TsT8DzWVpmOOU3yAFKo+KkafuQp
 FPlZsh16Bfyy2qczk1hDzK58KwLXsVlQoqQFd94pU8LCpgviSHu5lWPBmcKN9rZcGS1tgEq/lp+
 vsQ==
X-Received: by 2002:a05:6000:1548:b0:38d:ca76:9e78 with SMTP id
 ffacd0b85a97d-38dca76a034mr664625f8f.9.1738914202142; 
 Thu, 06 Feb 2025 23:43:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXDtSliyf5e7633Lj93iz0gjvVCwn9nt9T3s1hORommeCbi9tl1IeZu4/B+ph9YGICBw4DUg==
X-Received: by 2002:a05:6000:1548:b0:38d:ca76:9e78 with SMTP id
 ffacd0b85a97d-38dca76a034mr664611f8f.9.1738914201750; 
 Thu, 06 Feb 2025 23:43:21 -0800 (PST)
Received: from [192.168.123.161]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390daf3c70sm80595275e9.26.2025.02.06.23.43.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2025 23:43:20 -0800 (PST)
Message-ID: <6fd3784d-d3d0-4780-9156-8371c0f95a5c@canonical.com>
Date: Fri, 7 Feb 2025 08:43:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] configs: SiFive Unmatched: add 'nvme scan' to
 preboot
To: Simon Glass <sjg@chromium.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Green Wan
 <green.wan@sifive.com>, Yong-Xuan Wang <yongxuan.wang@sifive.com>,
 u-boot@lists.denx.de, Yuri Zaporozhets <yuriz@vodafonemail.de>
References: <20241112102644.37459-1-heinrich.schuchardt@canonical.com>
 <CAFLszTjvmy2a8G7jU7_xO-QfGoOBihqAHXZecrtHXm1qa5o9_A@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAFLszTjvmy2a8G7jU7_xO-QfGoOBihqAHXZecrtHXm1qa5o9_A@mail.gmail.com>
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

On 11/13/24 14:39, Simon Glass wrote:
> Hi Heinrich,
> 
> On Tue, 12 Nov 2024 at 03:26, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> Without 'nvme scan' the ESP on the NVMe drive is not found early.
>> EFI variables cannot be persisted.
>>
>>      Hit any key to stop autoboot:  0
>>      Cannot persist EFI variables without system partition
>>      ** Booting bootflow '<NULL>' with efi_mgr
>>      Loading Boot0000 'mmc 0' failed
>>      EFI boot manager: Cannot load any image
>>      Boot failed (err=-14)
>>      scanning bus for devices...
>>      ** Booting bootflow 'nvme#1.blk#1.bootdev.part_1' with efi
>>      Booting /\EFI\BOOT\BOOTRISCV64.EFI
>>      error: no suitable video mode found.
>>      GNU GRUB  version 2.12
>>
>> With 'nmve scan' booting works as expected.
>>
>>      Hit any key to stop autoboot:  0
>>      ** Booting bootflow '<NULL>' with efi_mgr
>>      Loading Boot0000 'mmc 0' failed
>>      Loading Boot0001 'nvme 0' failed
>>      Booting: nvme 1
>>      error: no suitable video mode found.
>>      GNU GRUB  version 2.12
>>
>> Reported by Yuri Zaporozhets <yuriz@vodafonemail.de>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>> v2:
>>          mention board in subject
>> ---
>>   configs/sifive_unmatched_defconfig | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/configs/sifive_unmatched_defconfig b/configs/sifive_unmatched_defconfig
>> index 058e5fab683..1ea744ffa80 100644
>> --- a/configs/sifive_unmatched_defconfig
>> +++ b/configs/sifive_unmatched_defconfig
>> @@ -27,7 +27,7 @@ CONFIG_FIT=y
>>   CONFIG_SPL_LOAD_FIT_ADDRESS=0x84000000
>>   CONFIG_BOOTSTD_DEFAULTS=y
>>   CONFIG_USE_PREBOOT=y
>> -CONFIG_PREBOOT="setenv fdt_addr ${fdtcontroladdr};fdt addr ${fdtcontroladdr};"
>> +CONFIG_PREBOOT="setenv fdt_addr ${fdtcontroladdr};fdt addr ${fdtcontroladdr};nvme scan"
>>   CONFIG_DEFAULT_FDT_FILE="sifive/hifive-unmatched-a00.dtb"
>>   CONFIG_SYS_CBSIZE=256
>>   CONFIG_SYS_PBSIZE=276
>> --
>> 2.45.2
>>
> 
> This is handled automatically by bootstd. It uses 'hunters' to scan
> devices as it goes. So this scan would not be wanted unless the device
> is booting from nvme.
> 
> It seems that bootmgr is very-much doing its own thing in U-Boot. Can
> we make it run the hunters, instead, perhaps?
> 
> Regards,
> Simon

The bootstd runs the NVMe hunter *after* executing the EFI bootmgr bootmeth.

We must scan NVMe before running the EFI bootmgr bootmeth to find the 
ESP on it.

Best regards

Heinrich
