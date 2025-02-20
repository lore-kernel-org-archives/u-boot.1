Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71DB0C021B1
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 08:28:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03B0E80EC0;
	Thu, 20 Feb 2025 09:28:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="LqclA22f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CA1380F42; Thu, 20 Feb 2025 09:28:48 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E219680A46
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 09:28:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 95F4E3F2BC
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 08:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1740040124;
 bh=y3AZm+U0oXP7JrNXgpYTGprBARTMUiJP6+d7XsdEook=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=LqclA22fIgQNo7Nkw8PaNjBLxufsYmLXIg/OBku5I2QoL74a3sj6ANPAZt6Tv/DTx
 pZ99Ql695985DQzbs2OkS1f258798GSPabL1ZUN7jcrkkylPuEWWCRg+S/YpMadV/E
 FtKRc5m0NqBDEzrR4RHc6qCCl/hZtokTMaZGscPQDvrzIkkQ0AS/cgFikt44mWoT9N
 e27EagabpABIl6E/cF4vsTnZypVuQiKXPYI2YLfrM+aK7Ce9Aowb8Jc9bEYA85Mtne
 ghDVRdk91xazm+7Y+nQfY8Ht5IeBNCME1Iii1leUtiC2EK+cZGmy/Psbuqtk/+sFD/
 xFDN8BWn2rF4A==
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-38f2f78aee1so290606f8f.0
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 00:28:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740040124; x=1740644924;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y3AZm+U0oXP7JrNXgpYTGprBARTMUiJP6+d7XsdEook=;
 b=JKgejK48WlGfElNJdmwDGAzbn/Lt17rfsvJAB9yuweHRJvioKKAKf16ZcEYod36+hU
 NiKHGMtOEhH47iTII2kqGuWe/fuN2l7wJuOoa3YTKKPrDnm4+RJMT4WjB324gOipFVhc
 3nkFBC7NBkRPv9qz/ntLBe/tFvZ99f5Celx1/9RM9sUHgAunC1wL8WrbZFvuKA4cLoYM
 wB+bSqNC9t5mE1/BvhvpZQU7t/lZYC/LRrKFyIGyiHiM0qtlO4r/g1so8h5p9CTtEFhA
 JatKMi9Rk4Nxdem9Lc0bScEAklK0p2W06e4NSxMMcSs99FgAQp+HgdwVKbGgW6dmHAiM
 SGYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVS+JHKUskUZomXOYKBB7WIFALhBg7XlfCN+j+wuoF6dWbOiLLCsMdG0GT1ehWZ99BqtC9ZdWg=@lists.denx.de
X-Gm-Message-State: AOJu0YwIOeLM6z4UE//rWCRcBGcHzmoSRqCgoMG+7HeDshBqXfVvmfAU
 nnyKn3GBghyWjt60CSa8qbVhY73IFl/w1BOk9/Gep0Aw90qzqt7tK30+W4Jw/eIbJ6lL7LwaRep
 oeO/Jgx6fikL6PGegDPyD0h8B3Kby3V0G3nEb8wBo5cPp36IU5+Tcv2ObxfYjT/a0rlk=
X-Gm-Gg: ASbGncvhkYul2Puw4NCXZax15uARGJ2AikstbfL382vbXr2P8mpUVAfh6JR6W7zpunm
 CgYy8NRY9Dn4ZJpBNWKNf09kEKMYcSFaRoPYEADVVbXiGfJX8GNcA7E3XoyQZYme2hKrEB+UnM7
 TOCTGv2GIsE2+LYADayeWxQrvDvuKQhUcNo2kFvhNYeIlv88J7D20kUVN8Ysra0UGd98c5I2zdg
 Li1Smuc7nnjWbfVelsInXhIKvpkzfncrB0GfjqnYN7YZdxlu0arQta2Dd4kYiR0QYndQ/St3izO
 shqAUdFyF73u+iRZF1QBpv1ZmgF83Vx3AMRiJVSXHbDsoYx6i8jAK06O1wpolQAH2JofQiyrg8R
 Ygg==
X-Received: by 2002:a05:6000:4026:b0:38f:3aae:830b with SMTP id
 ffacd0b85a97d-38f6163270bmr1837460f8f.26.1740040123896; 
 Thu, 20 Feb 2025 00:28:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8GpL+zLanwQoR5Ylx2T8nI1fVeqvFK0SbYtAP18vh8U7GmJbMWNE2XHuWIxKP80YpjaY2QQ==
X-Received: by 2002:a05:6000:4026:b0:38f:3aae:830b with SMTP id
 ffacd0b85a97d-38f6163270bmr1837443f8f.26.1740040123522; 
 Thu, 20 Feb 2025 00:28:43 -0800 (PST)
Received: from [192.168.123.161]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258ccd95sm19930218f8f.25.2025.02.20.00.28.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2025 00:28:42 -0800 (PST)
Message-ID: <d281f696-834f-4a54-8326-a8a6511de5ce@canonical.com>
Date: Thu, 20 Feb 2025 09:28:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] lmb: move lmb_map_update_notify() to EFI
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Liya Huang <1425075683@qq.com>, Adriano Cordova <adrianox@gmail.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Janne Grunau <j@jannau.net>,
 u-boot@lists.denx.de
References: <20250216111241.6846-1-heinrich.schuchardt@canonical.com>
 <20250216111241.6846-3-heinrich.schuchardt@canonical.com>
 <CADg8p955dW_tPw597XqRDp5SkxeQRY0L96nHn+uVUzanPX1R6g@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CADg8p955dW_tPw597XqRDp5SkxeQRY0L96nHn+uVUzanPX1R6g@mail.gmail.com>
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

On 2/17/25 10:55, Sughosh Ganu wrote:
> On Sun, 16 Feb 2025 at 16:42, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> When building with qemu_arm64_defconfig with CONFIG_CC_OPTIMIZE_FOR_DEBUG=y
>> and CONFIG_EFI_LOADER an error undefined reference to efi_add_memory_map_pg
>> occurs.
> 
> "and CONFIG_EFI_LOADER disabled".
> 
>>
>> Move the EFI dependent part of lmb_map_update_notify() to the EFI
>> sub-system.
> 
> Can this be rebased on the pmem patch series [1]. The pmem patches
> make certain changes to the name of the function being tweaked here,
> so it will be better if this patch series is rebased on top of the
> pmem patch series. Thanks.

This is a bug fix which will go into master.

Your pmem patches will go into next once Ilias and I have finished 
reviewing.

Best regards

Heinrich

> 
> -sughosh
> 
> [1] - https://lore.kernel.org/u-boot/20250203105912.196654-1-sughosh.ganu@linaro.org/T/#mf8100ad07f82b781d14102b39948b36ec8edea0a
>>
>> Reported-by: Liya Huang <1425075683@qq.com>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> Acked-by: Liya Huang <1425075683@qq.com>
>> ---
>>   include/efi_loader.h        | 15 +++++++++++++++
>>   lib/efi_loader/efi_memory.c | 27 +++++++++++++++++++++++++++
>>   lib/lmb.c                   | 31 +++----------------------------
>>   3 files changed, 45 insertions(+), 28 deletions(-)
>>
>> diff --git a/include/efi_loader.h b/include/efi_loader.h
>> index dcae6a731a0..db3d20fd753 100644
>> --- a/include/efi_loader.h
>> +++ b/include/efi_loader.h
>> @@ -1263,6 +1263,21 @@ efi_status_t efi_disk_get_device_name(const efi_handle_t handle, char *buf, int
>>    */
>>   void efi_add_known_memory(void);
>>
>> +/**
>> + * efi_map_update_notify() - notify EFI of memory map changes
>> + *
>> + * @addr:      start of memory area
>> + * @size:      size of memory area
>> + * @op:                type of change
>> + * Return:     0 if change could be processed
>> + */
>> +#ifdef CONFIG_EFI_LOADER
>> +int efi_map_update_notify(phys_addr_t addr, phys_size_t size,
>> +                         enum lmb_map_op op);
>> +#else
>> +#define efi_map_update_notify(addr, size, op) (0)
>> +#endif
>> +
>>   /**
>>    * efi_load_option_dp_join() - join device-paths for load option
>>    *
>> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
>> index 1212772471e..11d092dc289 100644
>> --- a/lib/efi_loader/efi_memory.c
>> +++ b/lib/efi_loader/efi_memory.c
>> @@ -865,3 +865,30 @@ int efi_memory_init(void)
>>
>>          return 0;
>>   }
>> +
>> +int efi_map_update_notify(phys_addr_t addr, phys_size_t size,
>> +                         enum lmb_map_op op)
>> +{
>> +       u64 efi_addr;
>> +       u64 pages;
>> +       efi_status_t status;
>> +
>> +       efi_addr = (uintptr_t)map_sysmem(addr, 0);
>> +       pages = efi_size_in_pages(size + (efi_addr & EFI_PAGE_MASK));
>> +       efi_addr &= ~EFI_PAGE_MASK;
>> +
>> +       status = efi_add_memory_map_pg(efi_addr, pages,
>> +                                      op == LMB_MAP_OP_RESERVE ?
>> +                                      EFI_BOOT_SERVICES_DATA :
>> +                                      EFI_CONVENTIONAL_MEMORY,
>> +                                      false);
>> +       if (status != EFI_SUCCESS) {
>> +               log_err("LMB Map notify failure %lu\n",
>> +                       status & ~EFI_ERROR_MASK);
>> +               return -1;
>> +       }
>> +       unmap_sysmem((void *)(uintptr_t)efi_addr);
>> +
>> +       return 0;
>> +}
>> +
>> diff --git a/lib/lmb.c b/lib/lmb.c
>> index 7534a231c99..93fc1bea07c 100644
>> --- a/lib/lmb.c
>> +++ b/lib/lmb.c
>> @@ -426,37 +426,12 @@ long io_lmb_free(struct lmb *io_lmb, phys_addr_t base, phys_size_t size)
>>
>>   static struct lmb lmb;
>>
>> -static bool lmb_should_notify(u32 flags)
>> -{
>> -       return !lmb.test && !(flags & LMB_NONOTIFY) &&
>> -               CONFIG_IS_ENABLED(EFI_LOADER);
>> -}
>> -
>>   static int lmb_map_update_notify(phys_addr_t addr, phys_size_t size,
>>                                   enum lmb_map_op op, u32 flags)
>>   {
>> -       u64 efi_addr;
>> -       u64 pages;
>> -       efi_status_t status;
>> -
>> -       if (!lmb_should_notify(flags))
>> -               return 0;
>> -
>> -       efi_addr = (uintptr_t)map_sysmem(addr, 0);
>> -       pages = efi_size_in_pages(size + (efi_addr & EFI_PAGE_MASK));
>> -       efi_addr &= ~EFI_PAGE_MASK;
>> -
>> -       status = efi_add_memory_map_pg(efi_addr, pages,
>> -                                      op == LMB_MAP_OP_RESERVE ?
>> -                                      EFI_BOOT_SERVICES_DATA :
>> -                                      EFI_CONVENTIONAL_MEMORY,
>> -                                      false);
>> -       if (status != EFI_SUCCESS) {
>> -               log_err("%s: LMB Map notify failure %lu\n", __func__,
>> -                       status & ~EFI_ERROR_MASK);
>> -               return -1;
>> -       }
>> -       unmap_sysmem((void *)(uintptr_t)efi_addr);
>> +       if (CONFIG_IS_ENABLED(EFI_LOADER) &&
>> +           !lmb.test && !(flags & LMB_NONOTIFY))
>> +               return efi_map_update_notify(addr, size, op);
>>
>>          return 0;
>>   }
>> --
>> 2.47.1
>>

