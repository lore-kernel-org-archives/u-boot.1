Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A6FFD69104
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 12:41:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5661E89877;
	Thu, 28 Nov 2024 13:41:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LaiDu1U6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28B7989CEC; Thu, 28 Nov 2024 13:41:25 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE19D8986D
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 13:41:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-aa543c4db92so106504666b.0
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 04:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732797682; x=1733402482; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=daIsPMXeBlgSp1iAlRHmw9xdiKKM/MHyAINTH5e3fcU=;
 b=LaiDu1U6MLxBqnCTZZ5J2HhaQd+P7qN5wvbWGaFd067oriE62kiCUCKuC0Wl89UWCH
 s/NAPs6TC+uHfRhq5UiAp0dBfQ6uBUmLu2kBxapv9lNgf5dG1X8vNRx/n4EmTOhyUgEr
 vkFPs/axqeGkp6HJ2ZZ//XNavSMIPkkajPJwHy3LsGQaIZdgcN6kG1HaHu9XxuEmHASM
 041X3ExA4vUZmUr8i1aaXSJSuLBZ2Z6ZLTWLkXPAOqx/h9SemE5Ty5LpCrydVKKD+clk
 6/CkYGNovPLqpct936GNsaS3F2LeNFbQKkDJUNfma967JpGpegJaECkjtvhZqoNL5/QG
 zm2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732797682; x=1733402482;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=daIsPMXeBlgSp1iAlRHmw9xdiKKM/MHyAINTH5e3fcU=;
 b=iGASTExMmIbNLK7KcaciKWgcYhKhldzneSrpT9M9kJPsV4k1k8cfZfQu7BE2Uu5zj2
 bf71qDEPmYu3Dd2d39ePLciKCqMyciCSx/T6ggqnrkwP/1Z+s4pTI1Ut5gNggcWG8+PT
 91eEpOMcw/iwCtVQDbGrcpw/hH87O77HOJRrRaoI7JpXN6PmCKnnyyl7OZs6FSMqiji3
 mXyShYwJZY9k0UDXCaLFyzxO1RmthfUC8YfVxio/QUWzdxzGMNdHucwMVr+Cb91zeEML
 WR6bXydhu59a7gGnlicz7azc0Y4Iq1aiXBdmc3nFUNheQO/mqx70zpK+Yxleq92sLE5H
 D0sg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4MbUGQSZ98L0V+p3eh+dOjOgv26qHWjcuXdYcf81EfxJjzoVzFIYpfn24pMTOzi0BjWSG9Og=@lists.denx.de
X-Gm-Message-State: AOJu0YyhuSjO1tJ9vORCho2o1zWNsZRgQEGexg7u5wzmFyyPnxWSuL1z
 y2npMBiwYE3EDcevKOcf8xEu6tc8/N9dW4CCXSmqnlbzcS//6WZ8gDR7z7Pe9dA=
X-Gm-Gg: ASbGncsqJvmZvQRokXKgb5iC13D9bdZWnAtzhO+EeB/L8Juebz5uYuw1bw4yFmGD9xt
 jPso8ImfDKuGzLoE+hHd1x02WoZR4s/lgkiGyew8uaxsAfyko2TkyUrLejRwuNqtfrligrIcLYQ
 HO6ox7IgqX5hQas4Ip0za1ZBx1qsomV0PnXVrNxvWBE2+7qU+EpRfgZ2HXRzbx5TfODtoIj1riP
 ss57ogRufjooJRqGGeCuq25Q1bfnItPlNwb0GIth4ppeFKPqeC5leDrHo22i0C6MdlioSTBVWnd
 vnZDRLJK2Dzejx0NR/SxhhJG8lvjHhJV
X-Google-Smtp-Source: AGHT+IFxfbO4X5LI2gpnPHPeExvZR1ADHRPgdc6YrO2Kbkwe00mv8HQARxSGxT94oDI0+oT8IFa3pw==
X-Received: by 2002:a17:906:310b:b0:aa5:d7c:2acf with SMTP id
 a640c23a62f3a-aa580ed0299mr410892266b.12.1732797682405; 
 Thu, 28 Nov 2024 04:41:22 -0800 (PST)
Received: from ?IPV6:2a02:8109:888d:ff00:ca7f:54ff:fe52:4519?
 ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa599953c69sm62582366b.187.2024.11.28.04.41.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Nov 2024 04:41:21 -0800 (PST)
Message-ID: <62e7b798-f9ff-46d2-ad7e-44c4a8e572b0@linaro.org>
Date: Thu, 28 Nov 2024 13:41:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 07/14] efi: stub: add known memory to U-Boot's EFI
 memory map
Content-Language: en-US
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Anatolij Gustschin <agust@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
References: <20241124-b4-efistub-arm64-v1-0-3e33f0340071@linaro.org>
 <20241124-b4-efistub-arm64-v1-7-3e33f0340071@linaro.org>
 <CADg8p94ma+FcJH2dAx=PtNjSq77Y0bGH8V_k64z_7+ij8R=P3Q@mail.gmail.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CADg8p94ma+FcJH2dAx=PtNjSq77Y0bGH8V_k64z_7+ij8R=P3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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

Hi Sughosh,

Thanks for the review.

On 28/11/2024 07:38, Sughosh Ganu wrote:
> On Mon, 25 Nov 2024 at 01:58, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>
>> When running U-Boot as an EFI payload with CONFIG_EFI_STUB, the reserved
>> regions from the previous stage EFI bootloader should be carried over
>> since they may not fully align with the reserved-memory regions in
>> devicetree.
>>
>> Implement a helper to map these pages when the EFI subsystem starts up.
>>
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>> ---
>>  include/efi_stub.h          |  7 +++++++
>>  lib/efi/efi_info.c          | 31 +++++++++++++++++++++++++++++++
>>  lib/efi_loader/efi_memory.c |  5 +++++
>>  3 files changed, 43 insertions(+)
>>
>> diff --git a/include/efi_stub.h b/include/efi_stub.h
>> index ff3befd4830b..343c84435970 100644
>> --- a/include/efi_stub.h
>> +++ b/include/efi_stub.h
>> @@ -56,5 +56,12 @@ int of_populate_from_efi(struct device_node *root);
>>   * EFI payload with CONFIG_EFI_STUB enabled.
>>   */
>>  int dram_init_banksize_from_efi(void);
>>
>> +/**
>> + * efi_add_known_memory_from_efi() - Add known memory pages from the memory map
>> + * of the EFI bootloader that booted U-Boot. This is only applicable when running
>> + * U-Boot as an EFI payload with CONFIG_EFI_STUB enabled.
>> + */
>> +void efi_add_known_memory_from_efi(void);
>> +
>>  #endif /* _EFI_STUB_H */
>> diff --git a/lib/efi/efi_info.c b/lib/efi/efi_info.c
>> index f9743a3e7fad..ef4e646b082b 100644
>> --- a/lib/efi/efi_info.c
>> +++ b/lib/efi/efi_info.c
>> @@ -5,8 +5,9 @@
>>   * Access to the EFI information table
>>   */
>>
>>  #include <efi.h>
>> +#include <efi_loader.h>
>>  #include <efi_stub.h>
>>  #include <errno.h>
>>  #include <mapmem.h>
>>  #include <asm/global_data.h>
>> @@ -177,4 +178,34 @@ int dram_init_banksize_from_efi(void)
>>         }
>>
>>         return 0;
>>  }
>> +
>> +/* Called by U-Boot's EFI subsystem to add known memory. In our case
>> + * we need to add some specific memory types from the original bootloaders
>> + * EFI memory map
>> + */
>> +void efi_add_known_memory_from_efi(void)
>> +{
>> +       struct efi_mem_desc *desc, *end;
>> +       struct efi_entry_memmap *map;
>> +       int ret, size;
>> +
>> +       EFI_PRINT("Adding known memory from previous stage EFI bootloader\n");
>> +
>> +       ret = efi_info_get(EFIET_MEMORY_MAP, (void **)&map, &size);
>> +       if (ret) {
>> +               EFI_PRINT("%s: Missing memory map\n", __func__);
>> +               return;
>> +       }
>> +       end = (struct efi_mem_desc *)((ulong)map + size);
>> +
>> +       for (desc = map->desc; desc < end; desc = efi_get_next_mem_desc(desc, map->desc_size)) {
>> +               switch (desc->type) {
>> +               case EFI_RESERVED_MEMORY_TYPE:
>> +                       efi_add_memory_map_pg(desc->physical_start, desc->num_pages, desc->type, false);
>> +                       break;
>> +               default:
>> +                       continue;
>> +               }
>> +       }
>> +}
> 
> If this is DRAM memory that is being added, this now needs to happen
> through LMB to ensure that these reserved memory regions don't get
> used by the LMB allocator. You can check if something can be added to
> the lmb_reserve_common() function. These regions will get marked as
> boot services data. If these are to be kept as reserved memory even in
> the OS, the memory type of these regions can be updated by keeping
> this function. But the point to consider is that this needs to be
> updated in the LMB memory map also.

Right I see. Thanks.

I'm not sure if this function is really necessary, I added it while
trying to debug some EFI crash but the cause was something else.

In theory the DT reserved-memory regions should match the reserved
regions from the EFI (I'm fairly sure this is the case for the X1E
laptops anyways), and I suppose there's no risk of mapping these as
normal memory anyway since we populate the dram banks from the same EFI
memory map.

So probably I'll remove this function from the next revision.

Kind regards,
> 
> -sughosh
> 
>> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
>> index d2f5d563f2a0..50b0010608e7 100644
>> --- a/lib/efi_loader/efi_memory.c
>> +++ b/lib/efi_loader/efi_memory.c
>> @@ -7,8 +7,9 @@
>>
>>  #define LOG_CATEGORY LOGC_EFI
>>
>>  #include <efi_loader.h>da
>> +#include <efi_stub.h>
>>  #include <init.h>
>>  #include <lmb.h>
>>  #include <log.h>
>>  #include <malloc.h>
>> @@ -834,8 +835,12 @@ static void add_u_boot_and_runtime(void)
>>  int efi_memory_init(void)
>>  {
>>         efi_add_known_memory();
>>
>> +#ifdef CONFIG_EFI_STUB
>> +       efi_add_known_memory_from_efi();
>> +#endif
>> +
>>         add_u_boot_and_runtime();
>>
>>  #ifdef CONFIG_EFI_LOADER_BOUNCE_BUFFER
>>         /* Request a 32bit 64MB bounce buffer region */
>>
>> --
>> 2.47.0
>>

-- 
// Caleb (they/them)

