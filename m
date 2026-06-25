Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6433CCDB479
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 11:52:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58B8984704;
	Thu, 25 Jun 2026 13:52:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Us2f9ZOF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59D06847C8; Thu, 25 Jun 2026 13:52:36 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 128418460E
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 13:52:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8374F3FB8B
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 11:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1782388353;
 bh=tAJYJImSsuhlkJ4a88q4VxkP/6NqF7lkEItclEbkCQg=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=Us2f9ZOFBlDgJRTvPekOc8hvUXSe3uFj/yA6dQthKL/NxrR3E6+a1qyVO0gM8q8RH
 GYyuBsjNsRChyGso81adbUxkJTCS1/Q27JnP0orwRpH66kEAbtb364FG8U0P1VyoKr
 sUyJhZcTSby7CvE958Cd3HrDReae+kGhDqdUSNtHmgMTalDFbiHJIT672Mo8/wLYm2
 OphECmXmqBSN4y3xcCIVPVt4b31D8vfJLrdku8YgdbxZ2/acmavjHFaSwlQrtATNOW
 mE3SxeOd0vWA2mNCJu4hpa1L1OLVP10ZI+ZWTlJTif96O0SjAIK3sFGjiiSdutbehu
 LTT9EZdtRJy5KxT6g0geNQC3LQCGpvXjlrU0eNuxp8wCiSU+9ifN+UnVNXk61VKLNZ
 M6MRZw4YD5jshOvKCBF2+x/CPyarO9xSssKKhZ8YsYdMpBcAuidK/gHuhYeGRmnQJd
 Mp1Z8ro+RnImtNT/a4CGBkBxVOT4BNQi9Ahtken0uGa39JrX6QdwmDI8lGl8lon3vX
 tLMC7M3he4JUVEM52pfwAMAExWw5ErQCla1/y9sYFJmhEKMbcLlYo7nB/EsHrqewyX
 BNx81l58taLqa6Ouc1H7hv9OOebtxFaNFyPUsZzAHFIYwtYrQZDLmR5YqFzsHfGl4C
 u2HlpP9KE8RPfArXLIRVqQhE=
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4923411f041so19147625e9.2
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 04:52:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782388353; x=1782993153;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tAJYJImSsuhlkJ4a88q4VxkP/6NqF7lkEItclEbkCQg=;
 b=Wy6zhxMXgxxb1HHTultNrPmKO7MYP3sWhysYEKmpgyrA3BhHv719FH1jLasYHcXA+S
 Cq6G9W9PvhXO2EUztVQsoLiJQVPjr8l6bnqg4R5L/29RWkasgKCZ31uecclXPcb4Rsph
 ZXSqSoK1e4FvWriz/DJJ+qPsEBAJUjGsgXj8FjJozrwX/O2wiKz69BSRCIJK5dZSO7BC
 3gFFlPEZy4E0QD08E5Pki8vbcER/QO5C9Kb6I9emNstfxtSI45K0YRzwKVAfgu43se5v
 +uYBj/K8wq5qXbj7gs44PcoR27gXVMiASQH4Cc/LlwoWGKP0b8/VeJsP6sg37L+fCJ2G
 oAPg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/OIgjTxQ0cr4C2L07vKq8wHMG44QRHafibeaI5TrBF0BfkPIjeVIBNmRdoa9zofkC68db4dL0=@lists.denx.de
X-Gm-Message-State: AOJu0YyaI95LAZUb9iKWpNMC8g9v6iX7zA6TTRs/4Po3rl1FdugMHOiH
 rlkmGXtex6dkINZZ3xJPD7xMWvpQ9c7Rj5dA3DpvXHfZJjvLdn/5L7SWNpKQf8FNEOIGunJda6P
 OlFgAejLbvdAujw6/Lx9QH5Br5P6TDEBQGfwsjNaok6PLhg/YYyTkgLrqFDRwikbDGE+TGbk=
X-Gm-Gg: AfdE7clSu/U71lhcaTBtkh7UAJY/qxt6D21FTUh0le+oAW6teR+LaY9dyt5v9+Jde1E
 Wn+x6eKgLW6HRkfp4aocK38AOuLz0nEXEzzc3Os1HWmQucULfpUM/ll/MlxpVDme1OXxT/h+s5E
 7ohaOIJz8PQRv0v1sXrtvCIaeTbkPo0ZmHhdAI1H9DzVHBja1SYat4wJcMTZ9LqJocRi50TtCvE
 +WTZczRem1rQ20e1KAC7KW1DN8ISQ+z0Uv0w492jkTyZUyrbvSzEtL5XNOUilXDJmu2D8K+X4ik
 K7QzXGHyfMehFYutrfSsc/xzCCsJQ9kDHOmCcYj032DDqN6aCpARvSx3HmrHjkbo96AHZyBuQ+7
 U6owiwgJGqPkLwhxM3FAK/+BUn3ntKj96NizMOBmik5HCr05DRHee5D5BMZ9K38pQBqCCPeBAGR
 REps0+vlzuzAOvZVo46RZU8qs9fCceNok=
X-Received: by 2002:a05:600c:c3c1:20b0:492:4335:4d4c with SMTP id
 5b1f17b1804b1-492668833c0mr23871635e9.30.1782388353067; 
 Thu, 25 Jun 2026 04:52:33 -0700 (PDT)
X-Received: by 2002:a05:600c:c3c1:20b0:492:4335:4d4c with SMTP id
 5b1f17b1804b1-492668833c0mr23871345e9.30.1782388352629; 
 Thu, 25 Jun 2026 04:52:32 -0700 (PDT)
Received: from ?IPV6:2a02:3035:680:3cd0:3c05:30a:d738:8c39?
 ([2a02:3035:680:3cd0:3c05:30a:d738:8c39])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c1ee01c3bsm16344877f8f.10.2026.06.25.04.52.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jun 2026 04:52:31 -0700 (PDT)
Message-ID: <f824b5ae-8fc1-44be-9267-4177bb2cdc9c@canonical.com>
Date: Thu, 25 Jun 2026 13:52:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/11] efi_loader: move console-input helpers to
 efi_app_common
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>,
 u-boot@lists.denx.de
References: <20260621081915.19154-1-heinrich.schuchardt@canonical.com>
 <20260621081915.19154-7-heinrich.schuchardt@canonical.com>
 <CAFLszTjyf2u2oNMGVdpQv1pEo5Y0APOkwkgBiV0_RiZfS+9q0g@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAFLszTjyf2u2oNMGVdpQv1pEo5Y0APOkwkgBiV0_RiZfS+9q0g@mail.gmail.com>
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
>> efi_loader: move console-input helpers to efi_app_common
>>
>> Move the shared console-input helpers to efi_app_common:
>>
>> * efi_drain_input() - drain the console input queue
>> * efi_input_yn()    - read a y/n/ESC key from the user
>> * efi_input()       - read a UTF-16 string from the console
>>
>> The common efi_input_yn() calls efi_drain_input() once at entry,
>> replacing the open-coded cin->reset() calls that each application
>> previously duplicated.
>>
>> dbginfodump and smbiosdump had no efi_drain_input() call in their
>> command loops; add the call so the console queue is drained before
>> each prompt, fixing a latent input-echo artefact.
>>
>> The common state is extended with a cin pointer (initialized by
>> efi_app_init from sys_table->con_in) so the helpers can access the
>> console-input protocol without additional parameters.
>>
>> [...]
>>
>> lib/efi_loader/dbginfodump.c    |  61 ----------------------
>>   lib/efi_loader/dtbdump.c        | 109 ----------------------------------------
>>   lib/efi_loader/efi_app_common.c |  88 ++++++++++++++++++++++++++++++++
>>   lib/efi_loader/efi_app_common.h |  29 +++++++++++
>>   lib/efi_loader/initrddump.c     | 109 ----------------------------------------
>>   lib/efi_loader/smbiosdump.c     | 108 +--------------------------------------
>>   6 files changed, 119 insertions(+), 385 deletions(-)
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> thoughts below
> 
>> diff --git a/lib/efi_loader/dbginfodump.c b/lib/efi_loader/dbginfodump.c
>> @@ -277,7 +217,6 @@ efi_status_t EFIAPI efi_main(efi_handle_t image_handle,
>>        handle = image_handle;
>>        systable = systab;
>>        cout = systable->con_out;
>> -     cin = systable->con_in;
>>        bs = systable->boottime;
> 
> The commit message says efi_drain_input() is added to dbginfodump and
> smbiosdump command loops, but only smbiosdump's command_loop() gets it
> - dbginfodump's efi_main() loop does not. On top of that, the old
> dbginfodump efi_input() opened with cin->reset(cin, true); the new
> common efi_input() does not drain at entry, so this patch silently
> removes drain-on-input from dbginfodump. Please add efi_drain_input()
> to dbginfodump's command loop too, or update the commit message.
> 
>> diff --git a/lib/efi_loader/efi_app_common.c b/lib/efi_loader/efi_app_common.c
>> @@ -104,3 +106,89 @@ bool starts_with(u16 *string, u16 *keyword)
>> +efi_status_t efi_input(u16 *buffer, efi_uintn_t buffer_size)
>> +{
>> +     struct efi_input_key key = { 0 };
>> +     efi_uintn_t index;
>> +     efi_uintn_t pos = 0;
>> +     u16 outbuf[2] = u" ";
>> +     efi_status_t ret;
>> +
>> +     *buffer = 0;
> 
> efi_input_yn() drains at entry but efi_input() does not - easy to trip
> over later. Either drain inside efi_input() too (matching the old
> dbginfodump/smbiosdump versions), or document in the header that
> callers must drain themselves. What do you think?
> 
> Regards,
> Simon

In the end this is the only usage of efi_input():

lib/efi_loader/efi_app_common.c:359:            ret = efi_input(command, 
CMD_BUFFER_SIZE);

One could argue if draining the console in the command() loop is needed 
or if we want a type ahead buffer.

For input_yn() I think draining is a necessity.

For input() I could imagine future usages where you want to be able to 
paste multiple lines.

The description of efi_status_t efi_input_yn() clearly states that it 
drains the input. While efi_input() does not mention it. So I think the 
documentation is clear.

Thanks for pointing out the discrepancy for dtbdump. Missed that when 
splitting the original single patch.

In the end all apps use the same command loop with efi_drain().

Best regards

Heinrich
