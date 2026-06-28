Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FBD1C43458
	for <u-boot@archiver.kernel.org>; Sun, 28 Jun 2026 06:06:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 536F584844;
	Sun, 28 Jun 2026 08:06:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="qVhCQTME";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13F63846A4; Sun, 28 Jun 2026 08:06:33 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4D9084844
 for <u-boot@lists.denx.de>; Sun, 28 Jun 2026 08:06:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4474C3F282
 for <u-boot@lists.denx.de>; Sun, 28 Jun 2026 06:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1782626789;
 bh=TZWTziCX0vT9/iO41CDxMldGrBan38El78q4EZYEOJ8=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=qVhCQTMEZFi2OQ5SSnkhUsTJfUAp3oH1srXDUbW5iXk6A+fR5r613gway0a+DFAvm
 3RAfAWky4LOwRFm81I4Y1Ko5qa9gCWtGWhxpOjzt0SuDuRgFIlUyb9NIKEkUznxq2o
 z9tvX2jHOZDE5Cxf3mBXneAD5j3OzL10vPOJGjSD+uvAFyy0bWPzZQFZ/a87zSQKc0
 hJgVlg9zQAzUe++gY4vX4GPFlD6qY2n70C14qpjiXQJzX1Aj485epSySk0QeJyNm2n
 M+g+B0ZhD/QPtdc9+T6VWfhX2QOcEw9ZzvdxHn1scxlwPDfV/U0jO/1WBFpXVx+X6Q
 Ov339UI/m84wJbEGronIS01R4sYRwarTAqBK9UDtRNkwyQeXXMiGRH0X6pxjitcqt8
 UE9yC700dWPRE6EXEA88j5wziGpgIY1cy79n1QmDWLxAiO41/8D5OceHWPSpsor4js
 jK4M05Ux4Z8bXaiSg/E8pGhmihnGgNhGOuM70EFpB5x7vnKdPy4jxxIi/6SVwweWaK
 /lKsMp0kBKv6vrhqG9SW7N87fZ0tuDJlJrv8JOUaE8QQVBOzjfkNV4BydCJM3tZK44
 oUeASonOrhnxJgiv2BQLMBHLM3HxMZJLkCM0V+atF2xm/LZqbpaExru0gMiXR0Zfo8
 3qAtCxidiQepVPb4+LzAm9mw=
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4938c67308fso4629685e9.2
 for <u-boot@lists.denx.de>; Sat, 27 Jun 2026 23:06:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782626789; x=1783231589;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TZWTziCX0vT9/iO41CDxMldGrBan38El78q4EZYEOJ8=;
 b=KrJ6fKDplt5rwDEyDgLrqQ2J03TekJCJ8Ja+7eMF+xPAyS9w0EJDCrifssVxeQ+Bi0
 epY5p7DKB64yEWGfxRSKgFB4QwWkrjMH0gsylY3V3yJpq7OCGfIaItwOK4eY8ZQyHFMT
 aLNYSxM8fmBBRoFbg77A7ZuT6FaAcbmBzUbowGBwcBS0hQBXcTiJLV3HbyWvtAxG5okj
 cnjB8YgNgm2u1CrrnnBLE2OTKmqQkvsW+cwt3PUTRMOZtJwnXS0HX+CLGQmunWTivPqc
 i9wyrjP7zlRRJQUeYFKC/80CQAJ9AraA34McVEXwsdrNeyBdDM1rZArokvrLpYeCS05y
 yO8g==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Hsd5zVqdGi+lqDTlMkhizQXpG+tyQW5O7KEZ+FU+RXp84dGblqMWZ37TAgmFQIu9ef6kI8gQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzM4GTYBZV9L238s2WMktGPsSae9R9jBqJRXb9i0FhCi4CYcfK8
 lXiJB/BCN+4eldefF6yslIT4EzaEdKo6K36nTlY6kq9gmtvZtTNVvBagQwqIrMzE2ipXI4sX1ci
 p93+ggaRbA5PXj96qxhOBRGgSEX8vLj2K48sluqvRjms9uzoSAd4h4/1Q4v6uB0Xf3GTAbgA=
X-Gm-Gg: AfdE7ckfQccOGC0HZm8+yWY57bXhBWwanVS7iCefl58fUAz7adTwwviIhurppUqhz3M
 3hgzvWvbCCpbVDRiYpEFa5hexr02IFa3CvvuoUPxSw80VQzNduUh2ogX7yNB55HV5qBJuUP/0fZ
 V+vcm6+i7d2JlTGwhqDzsvUnJpCU4NBlcoUbXXsPsAk/Hc5tJOholbbaUQubIVQbVMhkVYDtooA
 waE9CuOZ2UiGy7xPeCwh1+9LhvP21cesxDbqTBzOcNJJvpKBVP1+39M5xBAkf3/HWr8CH1qdfHb
 qLvmrEWdu5/UpH4UdNff+VRPyHZAEe2H37PJ3U9Qkc/xDyjed1L3qScJPkJM3pmWgmWG7I/8Owe
 +bBEsDlkJZQdQr/jLa2dgwRo8r6Jegg5pQoSWDL8KWvKs3p6htT/3XWZ6mqkZV0DOPHWKwfIUqK
 Di69WobVWtDLVH7Av/DXNT6zS12HL4Cg+dRh20yMng+aSW1LF9
X-Received: by 2002:a05:600c:c8f:b0:490:4663:691b with SMTP id
 5b1f17b1804b1-49266855407mr185482155e9.7.1782626788708; 
 Sat, 27 Jun 2026 23:06:28 -0700 (PDT)
X-Received: by 2002:a05:600c:c8f:b0:490:4663:691b with SMTP id
 5b1f17b1804b1-49266855407mr185481795e9.7.1782626788321; 
 Sat, 27 Jun 2026 23:06:28 -0700 (PDT)
Received: from [192.168.123.154]
 (dynamic-046-114-110-002.46.114.pool.telefonica.de. [46.114.110.2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46fccca2781sm14155022f8f.6.2026.06.27.23.06.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 27 Jun 2026 23:06:27 -0700 (PDT)
Message-ID: <b852fb2a-00d8-4e91-a82e-001b86a3e189@canonical.com>
Date: Sun, 28 Jun 2026 08:06:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/11] efi_loader: move efi_main and command loop to
 efi_app_common
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>,
 u-boot@lists.denx.de, heinrich.schuchardt@canonical.com
References: <20260621081915.19154-1-heinrich.schuchardt@canonical.com>
 <20260621081915.19154-10-heinrich.schuchardt@canonical.com>
 <CAFLszThopRDCMspX9yMC3f72fOj9mzqDcFmDVDO-UmucCBUMiw@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAFLszThopRDCMspX9yMC3f72fOj9mzqDcFmDVDO-UmucCBUMiw@mail.gmail.com>
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

On 6/25/26 10:54, Simon Glass wrote:
> Hi Heinrich,
> 
> On 2026-06-21T08:19:04, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>> efi_loader: move efi_main and command loop to efi_app_common
>>
>> Add the remaining shared code to efi_app_common to complete the
>> refactoring:
>>
>> * efi_main() - common entry point; calls efi_app_init(), prints
>>    app_banner, calls command_loop(), then clears the screen on exit.
>> * struct efi_app_cmd - table entry holding the keyword, help text,
>>    and a handler of type void (*fn)(u16 *args).
>> * command_loop() - iterates app_cmds[], matches keywords with
>>    starts_with(), and falls back to efi_app_help() on no match.
>> * efi_app_help() - prints each table entry's help line plus the
>>    built-in 'exit' line.
>>
>> Each dump app is updated accordingly:
>> * efi_main is removed; command_loop becomes non-static.
>> * app_banner[] is defined at file scope with the application's
>>    title string.
>> * Per-app duplicate state (bs, handle, systable) is removed; apps
>>    now use the common module's state.
>> [...]
>>
>> lib/efi_loader/dbginfodump.c    |  95 +++++-------------------------
>>   lib/efi_loader/dtbdump.c        | 109 +++++++---------------------------
>>   lib/efi_loader/efi_app_common.c | 111 ++++++++++++++++++++++++++++++++++-
>>   lib/efi_loader/efi_app_common.h |  31 +++++-----
>>   lib/efi_loader/initrddump.c     |  91 +++++------------------------
>>   lib/efi_loader/smbiosdump.c     | 126 ++++++++--------------------------------
>>   6 files changed, 205 insertions(+), 358 deletions(-)
> 
>> diff --git a/lib/efi_loader/efi_app_common.c b/lib/efi_loader/efi_app_common.c
>> @@ -304,3 +317,99 @@ efi_status_t save_file(u16 *filename, void *buf, efi_uintn_t size)
>> +extern u16 app_banner[];
>> +extern struct efi_app_cmd app_cmds[];
> 
> Please move these extern declarations into efi_app_common.h next to
> struct efi_app_cmd - inline externs in the .c file hide the contract
> that every consumer must define both symbols; putting them in the
> header makes the interface explicit and lets the compiler catch type
> mismatches.
> 
>> diff --git a/lib/efi_loader/dbginfodump.c b/lib/efi_loader/dbginfodump.c
>> @@ -118,20 +99,27 @@ static void print_info(struct efi_loaded_image *info)
>> -static efi_status_t do_dump(void)
>> +static void do_dump(u16 * __maybe_unused args)
>>   {
>>        struct dbg_info_header *dbg;
>> +
>> +     if (!device_path_to_text)
>> +             bs->locate_protocol(&guid_device_path_to_text_protocol, NULL,
>> +                                  (void **)&device_path_to_text);
>> +
>>        u32 count;
> 
> Declarations should be at the top of the block; u32 count lands after
> the locate_protocol() call. Also, the locate_protocol() return value
> is now ignored, so a permanent failure silently leaves
> device_path_to_text NULL with no diagnostic; the previous code printed
> 'No device path to text protocol' on error. Please restore that or at
> least check the return.
> 
>> diff --git a/lib/efi_loader/dbginfodump.c b/lib/efi_loader/dbginfodump.c
>> @@ -164,60 +152,9 @@ static efi_status_t do_dump(void)
>>                print(u'\r\n');
>>        }
>>
>> -     return EFI_SUCCESS;
>>   }
> 
> Stray blank line before the closing brace.
> 
>> diff --git a/lib/efi_loader/smbiosdump.c b/lib/efi_loader/smbiosdump.c
>> @@ -156,16 +143,13 @@ static efi_status_t do_save(u16 *filename)
>> -     ret = do_check();
>> -     if (ret != EFI_SUCCESS)
>> -             return ret;
>> -
>>        smbios3_anchor = get_config_table(&smbios3_guid);
> 
> Behaviour change not mentioned in the commit message: previously
> 'save' refused to write a malformed table because it ran do_check()
> first; now it happily writes whatever is there. If intentional, please
> call it out; otherwise restore the check.
> 
>> diff --git a/lib/efi_loader/efi_app_common.c b/lib/efi_loader/efi_app_common.c
>> @@ -304,3 +317,99 @@ efi_status_t save_file(u16 *filename, void *buf, efi_uintn_t size)
>> +                     for (cmd = app_cmds; cmd->fn; ++cmd) {
>> +                             if (starts_with(pos, (u16 *)cmd->cmd)) {
>> +                                     efi_uintn_t len;
>> +
>> +                                     for (len = 0; cmd->cmd[len]; ++len)
>> +                                             ;
> 
> Isn't there a u16 strlen-style helper that exists here? Also,
> cmd->cmd[len - 1] below assumes len > 0; an empty keyword would
> underflow. Worth an assertion or comment documenting the invariant.

Neither efi_freestanding.c nor efi_app_common.c have one.
Maybe in future we could add one.

Let's check len below this line.

> 
>> diff --git a/lib/efi_loader/dbginfodump.c b/lib/efi_loader/dbginfodump.c
>> @@ -0,0 +0,0 @@
>> +struct efi_app_cmd app_cmds[] = {
>> +     { u'dump', u"dump - print debug info table\r\n", do_dump },
>> +     { }
>> +};
> 
> The original help text column-aligned the dash ('dump       - print
> ...') across all apps. With the new table the dash sits right after
> the keyword, so 'load' and 'save <initrd>' no longer line up in
> initrddump, and likewise for dtbdump/smbiosdump. Easy to restore by
> padding the help strings.

Maintaining such an alignment in the app definition does not seem right.
If we want to restore the alignment, we can do that in a future patch 
for the help() function.

Best Heinrich
