Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED070C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 12:09:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54C1387CAD;
	Tue, 31 Oct 2023 13:09:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="vEgERbin";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E3B487443; Tue, 31 Oct 2023 13:09:16 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F10287CAF
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 13:09:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C97733FAE7
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 12:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1698754149;
 bh=XGCIauUbAY6mWvXkKWR6tt2DpGkp0toFGGpSSnNdgSU=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=vEgERbinD466+O+6skRXQ376tBr4PonEon+wyYfzE7Y2SbPP6By0AcTOoytzYElua
 ntsxnMfwf9CgC+yeYYq1TvmLXWd4RMQEkASSgs3uyKEIpe7LO6DivnQt5lNVHmoreb
 NFmCXMCHiEgL3W3HFPYbDIltSJNdQ/xDgbDqbZ+4xRn/5m+NxzGaXoy4u2U5Mj1u5n
 ARQ6xWULliYcI49ly5IRibCb4ec2urYuRClP3YQ1z49JjzzpMTs8BSxebDKJoNf4M2
 BHAle3kEaLZx5sCLY5I8D1ZUgk8bpxwapgFU+8QsTpQ7u5tEXcMImMXHfqqHzULTWw
 aTgILPJBQwrBw==
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-507b8ac8007so6504813e87.0
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 05:09:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698754149; x=1699358949;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XGCIauUbAY6mWvXkKWR6tt2DpGkp0toFGGpSSnNdgSU=;
 b=FFk/gPDhCMjinNMLd7BxdBBXETb+yIP8LSMsCMUf8cXriQgJLEUlyBukGtn3T/c2cG
 oVs1vCYv+WdnyGt8RmQQqfkHerREceyaEvlYb0MAcM4p1lXfPHKbIGQ5wGt80EZqIQc9
 1FsiGz/McjPiE6kp6ODg5Rzl2k4syoz06Dc5srPajGEGeZA/ub4iqLK9W5DOcKiRCOha
 XHv+dULgSs5Yx1ahYZ0eNzYGiVQJtcP4menHRpGxEmHfdWCg1846GCTim5dFIsxlfKBf
 jFR3e9aRZQx9l7b4jt4W1PhkrvWm2QWp4rpDyq8kwXVneqsy3W1NqMKGayaTNWJRcZri
 3hEQ==
X-Gm-Message-State: AOJu0YxPIwuhhwt8CHEjf/12Fe0f+KJqVgBwYO3tZOL/ZPWF5NswaLeR
 PSaHANd4RPzQBuXz6t6511zKjUktMUvLSeFCQaymema/VU2M50INL9aZ6Uimdk2jWcSKDcqHMrC
 /NsJJwj21QjrvqWu/SouPxyY0CEdAAXs=
X-Received: by 2002:a2e:9dd9:0:b0:2c5:2475:f848 with SMTP id
 x25-20020a2e9dd9000000b002c52475f848mr10086892ljj.15.1698754149128; 
 Tue, 31 Oct 2023 05:09:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4NyRx/ZQUpCLnU7TzKh0C9+tR4/ZkgeEh5ewi2aTeOrEAcWeOS1jH0TJk7+Lcz3ofKtGdxA==
X-Received: by 2002:a2e:9dd9:0:b0:2c5:2475:f848 with SMTP id
 x25-20020a2e9dd9000000b002c52475f848mr10086866ljj.15.1698754148709; 
 Tue, 31 Oct 2023 05:09:08 -0700 (PDT)
Received: from [10.0.29.1] ([159.148.28.2]) by smtp.gmail.com with ESMTPSA id
 t5-20020a2e5345000000b002c013211ec7sm180400ljd.100.2023.10.31.05.09.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Oct 2023 05:09:08 -0700 (PDT)
Message-ID: <de0fc9e4-00a2-4069-8017-151d2d348311@canonical.com>
Date: Tue, 31 Oct 2023 14:09:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 1/2] riscv: allow resume after exception
Content-Language: en-US, de-DE
To: Xiang W <merlew4n6@gmail.com>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Anup Patel
 <apatel@ventanamicro.com>, Kautuk Consul <kconsul@ventanamicro.com>,
 Chanho Park <chanho61.park@samsung.com>, u-boot@lists.denx.de
References: <20231029084533.44607-1-heinrich.schuchardt@canonical.com>
 <20231029084533.44607-2-heinrich.schuchardt@canonical.com>
 <CAJ8bkyx5=CBLkGGDkeWGevJNwffkU7sAady=5q58a+FFErO9jg@mail.gmail.com>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAJ8bkyx5=CBLkGGDkeWGevJNwffkU7sAady=5q58a+FFErO9jg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 10/31/23 09:53, Xiang W wrote:
> setjmp can be called in set_resume.

Unfortunately this is not possible. A longjmp buffer only stores 
register values and not the stack content.

Let's assume that setjmp() is moved into set_resume():

Let a function call set_resume(). The caller's address will be on the 
stack. Once the set_resume returns and the caller invokes another 
function the original stack content will be overwritten. When an 
exception occurs the longjmp will reenter set_resume() with the original 
stack pointer value pointing to a stack that does not match the original 
call to set_resume and set_resume will return to a random address.

Best regards

Heinrich

> 
> Regards,
> Xiang W
> 
> Heinrich Schuchardt <heinrich.schuchardt@canonical.com> 于2023年10月29日周日 16:56写道：
>>
>> If CSRs like seed are readable by S-mode, may not be determinable by
>> S-mode. For safe driver probing allow to resume via a longjmp after an
>> exception.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>> v2:
>>          new patch
>> ---
>>   arch/riscv/lib/interrupts.c | 13 +++++++++++++
>>   include/interrupt.h         | 22 ++++++++++++++++++++++
>>   2 files changed, 35 insertions(+)
>>   create mode 100644 include/interrupt.h
>>
>> diff --git a/arch/riscv/lib/interrupts.c b/arch/riscv/lib/interrupts.c
>> index 02dbcfd423..a26ccc721f 100644
>> --- a/arch/riscv/lib/interrupts.c
>> +++ b/arch/riscv/lib/interrupts.c
>> @@ -12,6 +12,7 @@
>>   #include <linux/compat.h>
>>   #include <efi_loader.h>
>>   #include <hang.h>
>> +#include <interrupt.h>
>>   #include <irq_func.h>
>>   #include <asm/global_data.h>
>>   #include <asm/ptrace.h>
>> @@ -21,6 +22,13 @@
>>
>>   DECLARE_GLOBAL_DATA_PTR;
>>
>> +static struct resume_data *resume;
>> +
>> +void set_resume(struct resume_data *data)
>> +{
>> +       resume = data;
>> +}
>> +
>>   static void show_efi_loaded_images(uintptr_t epc)
>>   {
>>          efi_print_image_infos((void *)epc);
>> @@ -105,6 +113,11 @@ static void _exit_trap(ulong code, ulong epc, ulong tval, struct pt_regs *regs)
>>                  "Store/AMO page fault",
>>          };
>>
>> +       if (resume) {
>> +               resume->code = code;
>> +               longjmp(resume->jump, 1);
>> +       }
>> +
>>          if (code < ARRAY_SIZE(exception_code))
>>                  printf("Unhandled exception: %s\n", exception_code[code]);
>>          else
>> diff --git a/include/interrupt.h b/include/interrupt.h
>> new file mode 100644
>> index 0000000000..1baa60bcf2
>> --- /dev/null
>> +++ b/include/interrupt.h
>> @@ -0,0 +1,22 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +
>> +#include <asm/setjmp.h>
>> +
>> +/**
>> + * struct resume_data - data for resume after interrupt
>> + */
>> +struct resume_data {
>> +       /** @jump: longjmp buffer */
>> +       jmp_buf jump;
>> +       /** @code: exception code */
>> +       ulong code;
>> +};
>> +
>> +/**
>> + * set_resume() - set longjmp buffer for resuming after interrupt
>> + *
>> + * When resuming the exception code will be returned in @data->code.
>> + *
>> + * @data:      pointer to structure with longjmp address
>> + */
>> +void set_resume(struct resume_data *data);
>> --
>> 2.40.1
>>

