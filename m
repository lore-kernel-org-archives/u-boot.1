Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1818C7115D
	for <u-boot@archiver.kernel.org>; Fri, 20 Jun 2025 11:03:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 184F882D17;
	Fri, 20 Jun 2025 13:03:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gaKEj/LV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 163E682BA1; Fri, 20 Jun 2025 13:03:36 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E9DC82D6F
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 13:03:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43ea40a6e98so19811835e9.1
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 04:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750417413; x=1751022213; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TfQA+yj6bJJkuPy0W6Tt3HJFoy8ezy8qeBtgGERQ6Q8=;
 b=gaKEj/LVS2HNt/KLHmvuarlyoriJhwzN7DkLEy29nm0I2g/WTwgRDYSJUdZlP7DP4p
 afVYv9mVMhBw0Slz+lKYcovpbjkZElTZmRiuKB50499xqlWaJtSOym5kRcqZrve9KZ76
 gML7rj8FIfo9/PcsOVDV8QmPLJ9gdkuT+euLDnhkHgQkr3WwS62OU+HHAO4LrSSOgXA9
 OnBHxLuL7gRi6u7YJHDKkj0RbxNqDUH4wBe48llvxYTqCcuPGYQnj9489BjcOPO3KUXo
 I2vLHP4ozOphdmzCcbVE3LtQuJqRcTG8yIBasyr5rNhpB/XtKMdFdrObgLowQbkeY24S
 3NLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750417413; x=1751022213;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TfQA+yj6bJJkuPy0W6Tt3HJFoy8ezy8qeBtgGERQ6Q8=;
 b=pFo9+uqdhSewTTW0ejN7aozIdGThqt0XUyBQU12/WBE8CnBoGq5ssw3PkpZVdnwFfD
 K63iDcmaAqoCQhyxQ6aWHYnwU/7U1ybwABUAFOeHM18tO/TArPkqsB1g8b6dMIVjavdC
 yd8W4RYnNaHrhkUsNRQ5LJKJwAzRSQMvb7yksTgvXCVVzxScdu7j3THl4aIH8LaNbmz2
 4GiqtHK86GXbLV7BV1KzBN8SNsFTyZ7QCQe0gr6gvCv0H1YAEmjuGLcccpP5xCsVVItt
 cwTJkqprI902UXclcAG+A6wfQ2VVvnHQ/K34v5FIJKLIPUS0nFiWV3xDmqR6rehrKmcm
 7M6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5p8cafSAH1ffXW+QxHZrVQxobPYqUJOvlxPztK1Zo8VzQKbcU4bDsj2kNp3g2EQqpoT+r6+E=@lists.denx.de
X-Gm-Message-State: AOJu0YxCiLazCC8SPLhUb8D5ecBkda52HudTwbbZEkR48kiDawZ9pkW+
 y6muKxnueGhDt5nZWhpxq+LDFvH7zTxntBxV1r+UlOwqb0o5YQOPjZIKgXCb7Y1DURA=
X-Gm-Gg: ASbGncvRV/bdMoO0GhFCd/3Z83piSHB9+wi7a9mcr3lNkjV2qnmPZ8ogr/259Ur3Zz3
 gBLrsFvdpah3XglKmquq7J40CbboYRsDI+yOomgAYASGeySvCy47ATFFY5TxUpsmuw3cveIymOA
 xYT7jG6IezWSFT+2NsY7GbFNc02M5+1JGAHiZr1eTvrWfEAD4b7Zh/96fRaLlzhcSrVEM0x9Zxj
 gCEJVI4eXs+GhfMiKHcilXb1hBXb9O4V7NncKXPOz6DCUc769C5/FiaLQY3S9L3fjxEW506TNYl
 AJE1oVZ8O6hpagn+KTmsUqw4E5b1RcpIy4Md13WrsvOawFtaBsTuBMDwVAojn8aXTmMkcMtDBJK
 wTuDOpMbeRyhyVB+I3sgGXYUOujHYjaVlc+3AUdN2RA==
X-Google-Smtp-Source: AGHT+IHLBqvvKyZ+rf3oIgOShxLNccB/mu6y6vf2kcTSZrLmkBDxkryPVks+RRQE+OfwKZ+2za9PxQ==
X-Received: by 2002:a05:600c:4e8b:b0:453:608:a18b with SMTP id
 5b1f17b1804b1-453654cb7dfmr25595795e9.9.1750417411977; 
 Fri, 20 Jun 2025 04:03:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:6677:431e:31d2:9da9?
 ([2a01:e0a:3cb:7bb0:6677:431e:31d2:9da9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d117c5f2sm1779422f8f.55.2025.06.20.04.03.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Jun 2025 04:03:29 -0700 (PDT)
Message-ID: <eb06107f-2a8b-4347-9937-89d099f22c89@linaro.org>
Date: Fri, 20 Jun 2025 13:03:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: arm: mvebu: Kirkwood boards are broken by commit 6fe50e3
From: Jerome Forissier <jerome.forissier@linaro.org>
To: Tony Dinh <mibodhi@gmail.com>, Stefan Roese <sr@denx.de>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
References: <CAJaLiFwpdskG-eQjFKQseB3ResK=6Lt_RNRbXZTEFq7FYYSuAg@mail.gmail.com>
 <47e2ae8a-19b1-4841-bdde-e2994d1a7f70@linaro.org>
Content-Language: en-US
In-Reply-To: <47e2ae8a-19b1-4841-bdde-e2994d1a7f70@linaro.org>
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

On 6/20/25 12:53, Jerome Forissier wrote:
> Hi Tony,
> 
> On 6/19/25 22:37, Tony Dinh wrote:
>> Hi Jerome,
>>
>> While fixing some ext4 file system problems on 2025.07-rc4, I ran into
>> a problem booting a few Kirkwood boards. kwboot loaded the u-boot
>> image,
>> and then u-boot execution was frozen without anything going to the
>> serial console. I did a bisect and found the commit that caused it.
>>
>> https://github.com/trini/u-boot/commit/6fe50e39508043f386fc1bd40bbc02b8a75c1940
>>
>> When I tried to reverse this commit, I had a build error like this
>> "{standard input}:24246: Error: selected processor does not support
>> `mrc p15,1,r3,c15,c1,0' in Thumb mode"
>>
>> Currently, the only way to boot Kirkwood boards is to disable either
>> CONFIG_LTO or CONFIG_SYS_THUMB_BUILD or both.
>>
>> I'm using the pogo_v4 and nsa325 boards as test beds. Please let me
>> know if I can help with testing to troubleshoot this regression.
>>
>> All the best,
>> Tony
> 
> The problem seems to be that some arm32 instructions are inlined
> inside thumb code and that's not allowed on this CPU without some
> interworking instruction (bx, blx etc.). For example, consider
> board_init_r(), is is mainly 16-bit instructions (Thumb):
> 
> 006186a0 <board_init_r>:
> board_init_r():
> /home/jerome/work/u-boot/common/board_r.c:799
>   6186a0:       b5f0            push    {r4, r5, r6, r7, lr}
>   6186a2:       b0ab            sub     sp, #172        @ 0xac
> get_gd():
> /home/jerome/work/u-boot/./arch/arm/include/asm/global_data.h:127
>   6186a4:       464a            mov     r2, r9
> ...
> 
> but then suddenly:
> 
> /home/jerome/work/u-boot/arch/arm/mach-kirkwood/cpu.c:242
>   619aae:       9b15            ldr     r3, [sp, #84]   @ 0x54
> writefr_extra_feature_reg():
> /home/jerome/work/u-boot/./arch/arm/include/asm/arch/cpu.h:100
>   619ab0:       ee2f3f11        mcr     15, 1, r3, cr15, cr1, {0}
>                 ^^^^^^^^
>                 32-bit arm instruction
> 
> I would expect some call to a *_from_thumb() veneer, such as in:
> 
> 006009dc <do_bootm_qnxelf>:
> [...]
> /home/jerome/work/u-boot/boot/bootm_os.c:379
>   600a02:       9501            str     r5, [sp, #4]
> /home/jerome/work/u-boot/boot/bootm_os.c:384
>   600a04:       f04a fc7c       bl      64b300 <__dcache_status_from_thumb>
> 
> 
> 0064b130 <__dcache_enable_from_thumb>:
> __dcache_enable_from_thumb():
>   64b130:       4778            bx      pc
>   64b132:       e7fd            b.n     64b130 <__dcache_enable_from_thumb>
>   64b134:       e59fc000        ldr     ip, [pc]        @ 64b13c <__dcache_enable_from_thumb+0xc>
>   64b138:       e08cf00f        add     pc, ip, pc
>   64b13c:       fffffb28        .word   0xfffffb28
> 
> We may need to move the inline functions with mrc/mcr to a .S file,
> making sure it's built with -marm on CPUs that do not support Thumb2.
> Then hopefully the proper interworking sequence would be inserted by the
> linker as is the case when Thumb is calling into object files resulting
> from .c files built with -marm (for example: arch/arm/mach-kirkwood/cpu.c
> which has CFLAGS_cpu.o := -marm).
> 
> In the meantime, could you try the following patch?
> 
> diff --git a/common/Makefile b/common/Makefile
> index 35991562a12..a509675335a 100644
> --- a/common/Makefile
> +++ b/common/Makefile
> @@ -19,6 +19,8 @@ obj-y += version.o
>  # # boards
>  obj-y += board_f.o
>  obj-y += board_r.o
> +CFLAGS_board_f.o += -marm
> +CFLAGS_board_r.o += -marm
>  obj-$(CONFIG_DISPLAY_BOARDINFO) += board_info.o
>  obj-$(CONFIG_DISPLAY_BOARDINFO_LATE) += board_info.o
> 
> I think it should resolve the issue, but is does also increase the
> size of the binary (+4 KiB). So the .S solution would definitely be
> better if it works IMO. I'll try to propose something ASAP, will
> likely be on Monday, feel free to give it a try by yourself though :)

Or maybe this which is a bit less radical:

diff --git a/common/Makefile b/common/Makefile
index 35991562a12..f0b7eadf7d2 100644
--- a/common/Makefile
+++ b/common/Makefile
@@ -19,6 +19,8 @@ obj-y += version.o
 # # boards
 obj-y += board_f.o
 obj-y += board_r.o
+CFLAGS_REMOVE_board_f.o := $(LTO_CFLAGS)
+CFLAGS_REMOVE_board_r.o := $(LTO_CFLAGS)
 obj-$(CONFIG_DISPLAY_BOARDINFO) += board_info.o
 obj-$(CONFIG_DISPLAY_BOARDINFO_LATE) += board_info.o

Still results in +1 KiB.

-- 
Jerome
