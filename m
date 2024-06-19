Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA281C27C53
	for <u-boot@archiver.kernel.org>; Wed, 19 Jun 2024 12:36:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56488881C6;
	Wed, 19 Jun 2024 14:36:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="TvKPgYlT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DCD388431; Wed, 19 Jun 2024 14:36:54 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AC9087E06
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 14:36:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6B21B3FE5E
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 12:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1718800611;
 bh=WIGIPqbOqlwoMRVQ8pQ2UxDcaVpJjxkglQQNV/tDSQY=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=TvKPgYlTPw07cW01KRiHnPCxmJOOQH9bIufk6IsRYgoIDuzUx9km9eGcUTf4ton4P
 nTBP0R3r0agufYLDafg0Kh8JZswQ2cryQQsMO5i2wWAPTmux69HSIYL4yZCP1HxQJk
 PkPxSjr8t5WadfNrxYP88qZesw7bbZha4WspTFkkNLTTo9e0ngdyNFZ+y+2blUDyfB
 7EzQAwhY93uPDd8EBkxKE/q5sbz+DnjHE8CHmrETz0280hNpDcFHJq7Vm3BHVhOFW+
 UO2DXOXGBiULeX7Hk4wc3u+3YX7ZZGkeaMHqeZ4Lbc6i06KsCTHQtIB4TDLKxmzClX
 GuKuM3i9w5n+A==
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2ebeef33f21so56055151fa.2
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 05:36:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718800611; x=1719405411;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WIGIPqbOqlwoMRVQ8pQ2UxDcaVpJjxkglQQNV/tDSQY=;
 b=M3T1UgWCsQvdDF6+gDgYDwKpdnEhthFi+usM9O+ZQWAF3XPMpdqm/op7mws8OCXucu
 x8EDrnleO7rjqCAV78v9ITkq5sHPzLjDw8dQTSdPU1CUFKYS+LphqWRYnOTTJaFibxYi
 ZQkckHSBJSWYisrDMoQuSCFzo+jylZ3k86lUT38WuuZsQQmVWVldsFbk/A5V6TzXcfCg
 H5jqhw4h2ZBZoahNE2XR0fjkAc+TRKXbE5BPBzDr3JOXOt1Wzzp6ointtvWxxKCDt5Ck
 iEHXjPdGBug1vhjFIguct6YNXNEkoIaT45U/ktE4+j5JIzbTw1c56mwjBfOu/kLZOVti
 cz5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7m8dx4r/zzsnxRpwDmLDpCnWwM9se4OJGV6D9PdfLND1PaEGBR7QQRkCstIyYcCQqeZweOrYfd5BUm1lKDDtjpskzpg==
X-Gm-Message-State: AOJu0YzN/6tOVLAvPU/9WvQUekD4slGgZcO3W8Deg+sjaLUoKVoCkl6E
 B8hVolB7nyoX0Eq+Tjuo6FU3V3AX7ISIqbCvag1mhBrghS0+1kQ4Wjy0zua9bRVnSICPm3pBuzc
 53aq65if0p+sctg9jHnseP0AMsldQt9/bzOyWb7WDdNwvD2j/cxuwvIfh8K7jfrfKN/Y=
X-Received: by 2002:a2e:95cf:0:b0:2ec:5cf:565e with SMTP id
 38308e7fff4ca-2ec3cec04c8mr20469411fa.12.1718800610832; 
 Wed, 19 Jun 2024 05:36:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFZGtSmlBc62BVTwDKPiQpaYPPGXvzWqmShcTxHWPKbai6KI2Q7O3A32vneXdJhSjasnrcLQ==
X-Received: by 2002:a2e:95cf:0:b0:2ec:5cf:565e with SMTP id
 38308e7fff4ca-2ec3cec04c8mr20469181fa.12.1718800610425; 
 Wed, 19 Jun 2024 05:36:50 -0700 (PDT)
Received: from [192.168.123.126]
 (ip-178-202-041-025.um47.pools.vodafone-ip.de. [178.202.41.25])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42286fe9184sm259668735e9.13.2024.06.19.05.36.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jun 2024 05:36:49 -0700 (PDT)
Message-ID: <e1fb4d81-a20c-4a10-904e-8b19eb17f4e5@canonical.com>
Date: Wed, 19 Jun 2024 14:36:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] cmd: avoid duplicate weak flush_dcache_all()
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Dan Carpenter <dan.carpenter@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, u-boot@lists.denx.de
References: <20240616173105.7430-1-heinrich.schuchardt@canonical.com>
 <20240616173105.7430-2-heinrich.schuchardt@canonical.com>
 <CAC_iWj+W5grPjuD9=v7ZOYGPFDE7_mFxF7fJhERTTJCjjpk4aQ@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAC_iWj+W5grPjuD9=v7ZOYGPFDE7_mFxF7fJhERTTJCjjpk4aQ@mail.gmail.com>
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

On 19.06.24 14:23, Ilias Apalodimas wrote:
> On Sun, 16 Jun 2024 at 20:31, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> If we have multiple weak implementations of functions, the linker might
>> choose any of these. ARM and RISC-V already provide a weak implementation
>> of flush_dcache_all().
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   cmd/cache.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/cmd/cache.c b/cmd/cache.c
>> index 0254ff17f9b..16fa0f7c652 100644
>> --- a/cmd/cache.c
>> +++ b/cmd/cache.c
>> @@ -52,11 +52,14 @@ static int do_icache(struct cmd_tbl *cmdtp, int flag, int argc,
>>          return 0;
>>   }
>>
>> +/* ARM and RISC-V define a weak flush_dcache_all() themselves. */
>> +#if !defined(CONFIG_ARM) && !defined(CONFIG_RISCV)
>>   void __weak flush_dcache_all(void)
>>   {
>>          puts("No arch specific flush_dcache_all available!\n");
>>          /* please define arch specific flush_dcache_all */
>>   }
> 
> Aren't we supposed to add a single __weak function so the linker can
> replace it? IOW why is the declaration for Arm/riscv a weak one?

Some sub-architectures override the architecture specific weak 
implementation, e.g.

arch/riscv/cpu/andes/cache.c:44:
void flush_dcache_all(void)

arch/arm/cpu/arm926ejs/cache.c:17:
void flush_dcache_all(void)

Best regards

Heinrich

> 
> Thanks
> /Ilias
>> +#endif
>>
>>   static int do_dcache(struct cmd_tbl *cmdtp, int flag, int argc,
>>                       char *const argv[])
>> --
>> 2.43.0
>>

