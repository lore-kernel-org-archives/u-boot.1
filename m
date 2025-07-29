Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3015C83F26
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 12:34:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D1B982C65;
	Tue, 29 Jul 2025 14:34:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iUofXtXk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9393382C87; Tue, 29 Jul 2025 14:34:36 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD26482BCD
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 14:34:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a575a988f9so3005540f8f.0
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 05:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753792473; x=1754397273; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vB6BEYVb/7HT3qD8Bj65pwnRdmMrLDU/FohhPqQFQ4Q=;
 b=iUofXtXkj0xRdVs8UqKwzgo9hjAXuX14iHZng/Nlhgitn73gADMDgXb1rThPWMGNYH
 xYJISHaCKrf08W6/RzWPmvAMRuNuvJQuu69iCO6r7x9TF70NYanSjihO9WbejIx7fNVB
 W86t+RbrBcd+ME5aTORtQJZmoii2fQ5Tq3Yz5g8akr5ONcW2NYWvo1pqNmyluyWkAP7w
 m6c5oAAFPumEfHHOPOZSxl8l2PMBN16jgCPwL3KuKUk3ZE47pHJE8Ih1ZUsmcmkAkqrE
 0f7on9qw99LmTVYupfNLJ+TgPkB4NusWMP9H4Irwm8NTuiqQqPfYmgDGPbmN7VzmqFqm
 1IZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753792473; x=1754397273;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vB6BEYVb/7HT3qD8Bj65pwnRdmMrLDU/FohhPqQFQ4Q=;
 b=fyF7jyI1a6L9Bh1XGnS5P7EUceo7+ebCg9l/SgkMtLQS5TzGDOva0/X8lHDqt6bzbU
 MxUXMx2l6cljiz630AExBgJvg6i8INi/CcDzOySe3p/bs10f1o5GOTuPUYvOFHtNokSb
 zYAJTnPGxDd3dyHidzdS+5XpIBfHzCoj4V8KJ0hSwx+HePL2F06c5TaxIC69IIIgnrAE
 QyKUc3gt8F2SGzQaDevupQrfsHbd2S+OLRY5Gs3DfLj8T/zd4qFHydxrEj7qiN9nbDcn
 DNMKNcGYytdNf90T8PmRHRG3BC+qZdxEIuGWr0mylak/uSVb2Wr+0jTRfUJHCXaBX89H
 62ww==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrwsWt3HJyQx+gkT+0L2b+mENT8u/sfUNjiDlq4cXBNX50YHJXIBI2EDro2j8elpnX1f/z4EA=@lists.denx.de
X-Gm-Message-State: AOJu0Yxl9bhesda9aN4uG3BdkehrwwbE4Xaw6QdkntdOQN+FnUnqnark
 e/gCzJd4eAkGOpZ5RZS/IUQ3QyWuhBdoGrczZXKIaSnhN2GxQGY331ps/56CwxNDRNc=
X-Gm-Gg: ASbGncvANSDXP84SNl9YD9BV+TK5UiX5ostxziQZ0f5LfJkDBBFydPf8qIAIyv6d5m0
 oCAcfwlJ4wFZH8X6eTYAOVEOBzJZbA2uEiw8RkX5Ovt7YgKjKXxcd/jw7ANCKQaPYYCslTL0OG/
 pZf2TSFHhjboXoQqsUyUsyGqSpW+FDh1eUPit7O4R/5mvn+p2HZmozAQw5NdfCKSKc1hzgnxweJ
 d624O7ahNEhbv46LGWLraEHlgSkrKRtGWrGhvFn2fociIXBl17VDZuYZtryDsp5M6e8KxsZQBjs
 +w0OfihPZU0QRZQssT8t1xsBxLwR5fqPkisj3gd7Ran1+ZZmfnj5077aH4t59pfrKQV9b0umVmd
 7/Xq6mdHRlyfrHo9PDabnkKobUJIE4OCERbkoKlWlZyti2+7n9DR1kAaxEji5FJb2AOQpg82iaA
 ==
X-Google-Smtp-Source: AGHT+IF5AEu5v4eOKNvInEuglDKKnMZ2BWf5KpNUQvpu9iq5n6VHum4fpkM6zmBrDr9Gtsn4Y8FH/w==
X-Received: by 2002:a05:6000:2585:b0:3b6:c88:7b74 with SMTP id
 ffacd0b85a97d-3b7766945aamr9657238f8f.59.1753792472781; 
 Tue, 29 Jul 2025 05:34:32 -0700 (PDT)
Received: from [172.18.195.54] (ip-185-104-138-124.ptr.icomera.net.
 [185.104.138.124]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458705377f0sm195675585e9.6.2025.07.29.05.34.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Jul 2025 05:34:32 -0700 (PDT)
Message-ID: <81467621-2ad5-4980-bc3d-2be38a3ee725@linaro.org>
Date: Tue, 29 Jul 2025 14:34:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] arm64: stack backtraces
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ben Dooks <ben.dooks@codethink.co.uk>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
References: <20250725-b4-arm64-backtrace-symbols-v2-0-230a9665085b@linaro.org>
 <e91ce58d-405a-4161-85b6-36afb63aa1fc@gmx.de>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <e91ce58d-405a-4161-85b6-36afb63aa1fc@gmx.de>
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



On 7/25/25 17:23, Heinrich Schuchardt wrote:
> On 25.07.25 14:57, Casey Connolly wrote:
>> Implement support for printing stack backtraces on ARM64, make
>> framepointer support configurable by the build system with
>> CONFIG_FRAMEPOINTER and teach U-Boot to walk the framepointers and
>> unwind the stack when an exception occurs. Also show all 64 bits of the
>> exception syndrom register (ESR).
>>
>> Additionally, a new global unwind_stack() function is added, this can
>> be called from anywhere to print a backtrace which can be useful when
>> debugging certain problems.
>>
>> In the future, stack unwinding with symbol support could be extended
>> to for example only emit log messages when a function is called in a
>> specific code path. This would allow for less noise when debugging hot
>> paths under certain conditions, but this feature is left as future work.
>>
>> === Handling relocation ===
>>
>> Since U-Boot relocates itself at runtime, and can be built to be
>> position independent in the first place (effectively "relocating" itself
>> when it first starts too), we can't really rely on gd->reloc_off.
>>
>> The approach taken here is to subtract CONFIG_TEXT_BASE from the address
>> of each symbol in the lookup table (while it's being generated), then
>> when decoding we just subtract the address of the _start label since it
>> is always correct pre and post relocation. This allows us to avoid all
>> the awkward maths since the symbols are always relative to 0x0 in the
>> lookup table.
>>
>> Example output:
>>
>> "Synchronous Abort" handler, esr 0x0000000096000004, far 0xfffffffffffff
>> elr: 000000009fc6f768 lr : 000000009fc6f710 (reloc)
>> elr: 00000001ffe49768 lr : 00000001ffe49710
>> x0 : 000fffffffffffff x1 : 0000000000000009
>> x2 : 00000001efdbadd0 x3 : 0000000000000000
>> x4 : 00000001efd99a28 x5 : 00000001ffec7676
>> x6 : 00000001efdbac70 x7 : 0000000000000000
>> x8 : 0000000000000002 x9 : 0000000000000034
>> x10: 000000000000000d x11: 0000000000000006
>> x12: 0000000000001000 x13: 00000000c3400000
>> x14: 00000000fffffff8 x15: 00000001efd99837
>> x16: 00000001ffe146b8 x17: 0000000000000000
>> x18: 00000001efdbac70 x19: 000000000a6f8800
>> x20: 00000001efe06fd0 x21: 0000000000000001
>> x22: 00000001ffef5b80 x23: 00000001ffee08c0
>> x24: 0000000000000002 x25: 0000000000000000
>> x26: 0000000000000000 x27: 0000000000000000
>> x28: 00000001efe512c0 x29: 00000001efd99c80
>>
>> Code: 2a010000 b9001260 d5033fbf 92fffe00 (39400001)
>>
>> CONFIG_TEXT_BASE   : 0x9fc00000
>> Relocated base addr: 0x1ffdda000
>> Backtrace:
>>     <0x000001ffe496d0> dwc3_qcom_glue_configure+0x40
>>     <0x000001ffe494a4> dwc3_glue_probe+0x10c
>>     <0x000001ffe1757c> device_probe+0x254
>>     <0x000001ffe1757c> device_probe+0x114
>>     <0x000001ffe4ff70> usb_init+0x158
>>     <0x000001ffe00fe4> do_usb_start+0xc
>>     <0x000001ffe01018> do_usb+0x78
>>     <0x000001ffe0dec4> cmd_process+0x140
>>     <0x000001ffe04e24> run_list_real+0x6f0
>>     <0x000001ffe05554> parse_stream_outer+0x148
>>     <0x000001ffe04d30> parse_string_outer+0x90
>>     <0x000001ffe0d148> run_command_list+0x50
>>     <0x000001ffe02be0> main_loop+0x28
>>     <0x000001ffe065c0> board_init_r+0x3c8
>>     <0x000001ffddd00c> relocation_return+0x4
>>
>> Resetting CPU ...
> 
> Thank you Casey for picking this up.
> 
> It working fine but there are some points to think about:

Thanks for taking a look!

> 
> It would make sense to show both the relocated and the non-relocated 
> addresses like we do for elr and lr. The value after subtracting the 
> relocation address is what I need when looking at the objdump.

OK, I can see why that would be useful, I'll give it a whirl.

> 
> The format of addresses with and without symbols does not match:
> 
> Backtrace:
>          <0x0000007f6ba868> cmd_process+0x130
>          <0x0000007f6af900> run_list_real+0x718
>          <0x0000007f6b0058> parse_stream_outer+0x14c
>          <0x0000007f6b06b4> parse_file_outer+0x34
>          <0x0000007f6b9dfc> cli_loop+0x18
>          <0x0000007f6ad6b0> main_loop+0x50
>          <0x0000007f6b0f94> board_init_r+0x378
>          <0x0000007f68400c> relocation_return+0x4
> 
> Backtrace:
>          (0x0000007f6d394c)
>          (0x0000007f6c8fcc)
>          (0x0000007f6c9158)
>          (0x0000007f6c969c)
>          (0x0000007f6d2dc8)
>          (0x0000007f6c66b4)
>          (0x0000007f6ca2c0)
>          (0x0000007f69d010)
> 
> I don't think parentheses are needed. But if we use them they should 
> look the same for the same content.

I was trying to differentiate between the addresses being symbol 
addresses vs lr addresses, but yeah maybe the different parentheses 
doesn't add much here. I used the <> to follow the kernel style.

> 
> I guess symbol lookup could be used in other places in future. I don't 
> see a necessity to let it depend on frame-pointers. Instead frame- 
> pointers should imply symbol-lookup. 'imply' should also work on RISC-V 
> where symbol-lookup is still missing.

Makes sense to me.

> 
> There should be at least one defconfig for 32-bit and one defconfig for 
> 64-bit that builds with both.

Hmm, well I'll enable it in qcom_defconfig for sure, I don't have any 
32-bit boards to test though, can you help with this?

> 
> I am missing the function name and offset for the function where the 
> exception actually occurred. Could we treat the value of elr like a 
> framepointer and add it as first line?

Oh yeah, I messed this up actually we should pass elr in except_msg(), 
I'll fix that.

Kind regards,
// Casey (she/her)

> 
> Best regards
> 
> Heinrich
> 
>>
>> ---
>> Changes in v2:
>> - Include calling function in backtrace (current LR)
>> - Implement support for runtime symbol lookup
>> - Use symbol lookup to print more informative backtraces when available
>> - Adjust backtrace format and print U-Boot base address
>> - Link to v1: https://lore.kernel.org/u-boot/20250703051951.43372-1- 
>> heinrich.schuchardt@canonical.com
>>
>> To: Tom Rini <trini@konsulko.com>
>> To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> Cc: Simon Glass <sjg@chromium.org>
>> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> Cc: Ben Dooks <ben.dooks@codethink.co.uk>
>> Cc: Rick Chen <rick@andestech.com>
>> Cc: Leo <ycliang@andestech.com>
>> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>> Cc: u-boot@lists.denx.de
>>
>> ---
>> Casey Connolly (3):
>>        drop unused kallsyms support
>>        add support for symbol lookups
>>        arm64: implement printing backtraces with symbols
>>
>> Heinrich Schuchardt (4):
>>        cmd/exception: missing include string.h
>>        Kconfig: make CONFIG_FRAMEPOINTER available on arm64
>>        arm64: initialize the frame pointer register
>>        arm64: simplify interrupt code
>>
>>   Kconfig                      |  25 ++
>>   Makefile                     |  24 +-
>>   arch/arm/Makefile            |   9 +-
>>   arch/arm/lib/crt0_64.S       |   1 +
>>   arch/arm/lib/interrupts_64.c | 133 ++++++---
>>   arch/riscv/Kconfig           |  21 --
>>   common/Makefile              |   1 -
>>   common/kallsyms.c            |  42 ---
>>   common/system_map.c          |   8 -
>>   include/exception.h          |   1 +
>>   include/symbols.h            |  22 ++
>>   lib/Kconfig                  |   9 +
>>   lib/symbols.c                | 141 ++++++++++
>>   tools/Makefile               |   3 +
>>   tools/symbols.c              | 646 +++++++++++++++++++++++++++++++++ 
>> ++++++++++
>>   15 files changed, 965 insertions(+), 121 deletions(-)
>> ---
>> base-commit: f2f451d9d6d3756458d5037e3e5135e5211582d7
>>
>> // Caleb (they/them)
>>
>>
> 
.
