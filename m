Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5953FC54E71
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 16:28:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 938AA87F39;
	Tue, 19 Mar 2024 17:28:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N463lmwS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A05187F6F; Tue, 19 Mar 2024 17:28:02 +0100 (CET)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 551AA87E3E
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 17:27:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maximmosk4@gmail.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-513d3746950so7123602e87.1
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 09:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710865677; x=1711470477; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wwH9c1nRcUj2Y2Btq1UvwEt2PEE8zSowm/eukcdFHig=;
 b=N463lmwSa3mHESnRj5fRjeuBQ6FoiVQLnbNCUqNHtFkaMJH8lgiCPD6IS9ViD1Qkkt
 1u8PR0FsgVkFDrcCuIhn5aPxislZJanNt76kCX/AKA9B6WSMI3z9sjbtHztgq0+ss/Pp
 2vo3tJzB1vxedphgZGL2RKeYcT65QU339H66IrkHYg+4+USfhQzwhAzbeMOzMc9iQ5GC
 g/wdAQeWjpLsIep58Yg+fdOVVNRVR/qwjJ+SZGtD0FCxhGgqJlae6hXWepUOUlIEQ1Kp
 R8oysrPUyobkFwmDVcrrfwCewnmrZXLaiTH1KIAYYYgps19V5PLuTsBEkszCQ3YZGwDT
 MNLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710865677; x=1711470477;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wwH9c1nRcUj2Y2Btq1UvwEt2PEE8zSowm/eukcdFHig=;
 b=p7nWFa71cqVVFs6UXyXL/3S0xH8MCAXjqA6sbgtaX/UHtVclZQeQo12inlwsyehboT
 iLLdDdNIZHtxxCmb6rxEH4Ue0tDBk0/ziPoReYYhXPxqj1X/16b7bsC2erVYyVQifUD1
 fKOOHdZMwwrztUgsQc9M5yONo/NpCW7rvPupOZEydGJsZI8Z7QgZ8Nx/4j0E0qolsHlI
 weJAo+CiWH7CPj+HmuWb66tjLFLTj+pC+w6bqp8hZ+jmps7DfCgJQezP8pUUaJcHGQZF
 Ws+7uUQpNRJis39Of6J/JiGtPn5SQExrslwmK1XAdoA/fVYPo28w6b9ermz+ZCAxfX5O
 +V3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIrTI4B3cR3MdfF3/4tRg82v9VSfB6XYRx17V/v1KjreVH+E3Ir0/b+RWCADqyvVOPmq8TYg0SybuxzyyyBfOvM780nw==
X-Gm-Message-State: AOJu0YxZjyza5zi1GfVH86ztEVNUcI3CpLOfvQCqFf8Bsj1qsaVyTJa0
 tjnIjXDPbYPOZ0O5KEav3MKN3vlWHTOoYolOK16X+fv1J4KEZXifrYiwtigu
X-Google-Smtp-Source: AGHT+IFdou0NpxaxnZHYwLIWJ1RgmxXWxsyV0SfGfeaP88boM8vsO2fdw87fYdctKtjZHccBQ//rqg==
X-Received: by 2002:a05:6512:5d6:b0:513:2c56:f5e2 with SMTP id
 o22-20020a05651205d600b005132c56f5e2mr8544462lfo.60.1710865677245; 
 Tue, 19 Mar 2024 09:27:57 -0700 (PDT)
Received: from [192.168.1.6] (109-252-14-191.nat.spd-mgts.ru. [109.252.14.191])
 by smtp.gmail.com with ESMTPSA id
 u15-20020a05651220cf00b00513c54ba806sm1991152lfr.96.2024.03.19.09.27.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Mar 2024 09:27:56 -0700 (PDT)
Message-ID: <40506267-4f51-4a3a-90f9-fd7e17b61896@gmail.com>
Date: Tue, 19 Mar 2024 19:27:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: bootm: add ELF file support
To: Sean Anderson <sean.anderson@seco.com>, u-boot@lists.denx.de
References: <20240319161022.41451-1-Maxim.Moskalets@kaspersky.com>
 <d22c23bc-8fbc-469f-90ea-2d6b51c12580@seco.com>
Content-Language: en-US
From: "Maxim M. Moskalets" <maximmosk4@gmail.com>
In-Reply-To: <d22c23bc-8fbc-469f-90ea-2d6b51c12580@seco.com>
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

Hi Sean

On 19.03.2024 19:15, Sean Anderson wrote:
> Hi Maxim,
>
> On 3/19/24 12:10, Maxim Moskalets wrote:
>> [You don't often get email from maximmosk4@gmail.com. Learn why this is important at https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2faka.ms%2fLearnAboutSenderIdentification&umid=d3728a4f-0e7b-4ded-94bc-5bd133b6deef&auth=d807158c60b7d2502abde8a2fc01f40662980862-7a67d937c0016d0d3292f79af55f0ce3d78f480b ]
>>
>> Some operating systems (e.g. seL4) and embedded applications are ELF
>> images. It is convenient to use FIT-images to implement trusted boot.
>> Added "elf" image type for booting using bootm command.
> Why not use objcopy to create a binary?
>
> --Sean
When expanding ELF to binary, the size can grow significantly due to the 
layout of the file.
ELF is also more convenient for debugging due to its clear structure and 
ease of getting symbols and other debugging information.

--Maxim
>> Signed-off-by: Maxim Moskalets <maximmosk4@gmail.com>
>> ---
>>   boot/bootm_os.c  | 21 +++++++++++++++++++++
>>   boot/image-fit.c |  3 ++-
>>   boot/image.c     |  3 +++
>>   include/image.h  |  1 +
>>   4 files changed, 27 insertions(+), 1 deletion(-)
>>
>> diff --git a/boot/bootm_os.c b/boot/bootm_os.c
>> index ccde72d22c..71bfb34926 100644
>> --- a/boot/bootm_os.c
>> +++ b/boot/bootm_os.c
>> @@ -395,6 +395,24 @@ static int do_bootm_qnxelf(int flag, struct bootm_info *bmi)
>>   }
>>   #endif
>>
>> +#if defined(CONFIG_CMD_ELF)
>> +static int do_bootm_elf(int flag, struct bootm_info *bmi)
>> +{
>> +       struct bootm_headers *images = bmi->images;
>> +       char *local_args[2] = {NULL};
>> +       char str[19] = ""; /* "0x" + 16 digits + "\0" */
>> +
>> +       sprintf(str, "0x%lx", images->ep); /* write entry-point into string */
>> +       str[18] = '\0';
>> +       local_args[0] = bmi->argv[0];
>> +       local_args[1] = str;    /* and provide it via the arguments */
>> +
>> +       do_bootelf(NULL, 0, 2, local_args);
>> +
>> +       return 1;
>> +}
>> +#endif
>> +
>>   #ifdef CONFIG_INTEGRITY
>>   static int do_bootm_integrity(int flag, struct bootm_info *bmi)
>>   {
>> @@ -536,6 +554,9 @@ static boot_os_fn *boot_os[] = {
>>   #ifdef CONFIG_BOOTM_EFI
>>          [IH_OS_EFI] = do_bootm_efi,
>>   #endif
>> +#if defined(CONFIG_CMD_ELF)
>> +       [IH_OS_ELF] = do_bootm_elf,
>> +#endif
>>   };
>>
>>   /* Allow for arch specific config before we boot */
>> diff --git a/boot/image-fit.c b/boot/image-fit.c
>> index 89e377563c..0419bef6d2 100644
>> --- a/boot/image-fit.c
>> +++ b/boot/image-fit.c
>> @@ -2180,7 +2180,8 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
>>                  fit_image_check_os(fit, noffset, IH_OS_TEE) ||
>>                  fit_image_check_os(fit, noffset, IH_OS_OPENRTOS) ||
>>                  fit_image_check_os(fit, noffset, IH_OS_EFI) ||
>> -               fit_image_check_os(fit, noffset, IH_OS_VXWORKS);
>> +               fit_image_check_os(fit, noffset, IH_OS_VXWORKS) ||
>> +               fit_image_check_os(fit, noffset, IH_OS_ELF);
>>
>>          /*
>>           * If either of the checks fail, we should report an error, but
>> diff --git a/boot/image.c b/boot/image.c
>> index 073931cd7a..5b88d6808c 100644
>> --- a/boot/image.c
>> +++ b/boot/image.c
>> @@ -134,6 +134,9 @@ static const table_entry_t uimage_os[] = {
>>   #endif
>>          {       IH_OS_OPENSBI,  "opensbi",      "RISC-V OpenSBI",       },
>>          {       IH_OS_EFI,      "efi",          "EFI Firmware" },
>> +#ifdef CONFIG_CMD_ELF
>> +       {       IH_OS_ELF,      "elf",          "ELF Image" },
>> +#endif
>>
>>          {       -1,             "",             "",                     },
>>   };
>> diff --git a/include/image.h b/include/image.h
>> index 21de70f0c9..9a40bca22c 100644
>> --- a/include/image.h
>> +++ b/include/image.h
>> @@ -100,6 +100,7 @@ enum {
>>          IH_OS_TEE,                      /* Trusted Execution Environment */
>>          IH_OS_OPENSBI,                  /* RISC-V OpenSBI */
>>          IH_OS_EFI,                      /* EFI Firmware (e.g. GRUB2) */
>> +       IH_OS_ELF,                      /* ELF Image (e.g. seL4) */
>>
>>          IH_OS_COUNT,
>>   };
>> --
>> 2.39.2
>>
>
> [Embedded World 2024, SECO SpA]<https://www.messe-ticket.de/Nuernberg/embeddedworld2024/Register/ew24517689>

