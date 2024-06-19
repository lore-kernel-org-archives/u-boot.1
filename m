Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 643B1C27C79
	for <u-boot@archiver.kernel.org>; Wed, 19 Jun 2024 14:43:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B47F8840F;
	Wed, 19 Jun 2024 16:43:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="O/FVU3dK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEEE188363; Wed, 19 Jun 2024 16:43:08 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0BA88842C
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 16:43:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id CB29C3FE0F
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 14:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1718808184;
 bh=9uwRo8DNAlInZCB7qTuTLV+v4oS0Dt5WXI1aXS8Teu0=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=O/FVU3dKWKXA6m6NZ9Aba5/cxcPvNpP+8PZCBW7YccIEaPQjle+yEE9V8UuFNq4dn
 zTiB7nl4p4RfYH8/puwryKc47LVVxhSxJM50BaeTASDCnuLPX19SAcBfZfo+bN/Hbw
 X3aQffczPWnVb1h+WUMrKdMniu8qvr7DrzUGA6fy8pbsRMRy8f/h/Q+UeV/N9QcTI1
 tkLA+oKMuElSLVnSnVG32Zqn4uhz/ZFOik+HWS+1be4J75hhYFLdoAdFZODH13x3e+
 726vcGc3fZNCp8oUsFb9HQk1VD/qEN+VggGIt/gXmxKokZ9lPH8IFNs0suf8jPF9pO
 VQlKJyuD4lScw==
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-421e17ae038so48904405e9.0
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 07:43:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718808183; x=1719412983;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9uwRo8DNAlInZCB7qTuTLV+v4oS0Dt5WXI1aXS8Teu0=;
 b=tA8qfNZgEeQvs2Pi1DnNwpZp8No1XulhCKtR1OH8Jh9V8HcCt2Z9zPG9SCciZt9RJr
 iK5JEaS5EABPrM5M3dNp14U+bLsC9BsEj7gSDYYfdVZ1SyZ9UZLjepsGsxGIWXUA3oCu
 Qfx5yODj3/V9JJCMlokEc1j6GbBhhtamfAc101823etIP8Oyfa9GmbbSf1dECvnFrtis
 GXE7KizJP/UCsVinFpxV+MuTltzqQZziHpJPH/F0K0Iuou4me7VOMw/qtKIXmzKPIC3v
 W3JpM5yM/Xos9NiwP9gGl/RB48Wx9me9a3o01ScdgKdV2OSF511xGvOHgOwAckezJbez
 sz9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDqzb5/XWE61tMoiO2LQeXAnAMvKFjsn1cRf7Auu+lPcpiuzsZsqtTZ4Bwnv0CUWNfKdUFrhgM4trpCckkNQ01M5YsrQ==
X-Gm-Message-State: AOJu0Yx4PjuxrFzQFMI+siKx+0lO42RyzFGt6eDvS2je4uj02PXLmnyp
 AAZiMC/A5s3ox00zoma6IQ0MKm4vk+/s4kTH5rbdPxF1pSkYn4LEdrSy4LfmS+q367DzohEyCSL
 q9ZJFPNTuspGQXdcLQyeScXtZrx2CCxVBRgi6TalEtlzpIn0ozsjaY4OzPUdzwaQI5Qs=
X-Received: by 2002:adf:f003:0:b0:360:7c13:761e with SMTP id
 ffacd0b85a97d-3631999003emr2071206f8f.65.1718808183585; 
 Wed, 19 Jun 2024 07:43:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnjiTmx7dGmPuYBNAWukPbSNdGf1WG7lIXojK32RTPr6EMvvU7ukRr+O29e7wHrSHYVZDrrg==
X-Received: by 2002:adf:f003:0:b0:360:7c13:761e with SMTP id
 ffacd0b85a97d-3631999003emr2071182f8f.65.1718808183130; 
 Wed, 19 Jun 2024 07:43:03 -0700 (PDT)
Received: from [192.168.123.126]
 (ip-178-202-041-025.um47.pools.vodafone-ip.de. [178.202.41.25])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36437896ee5sm490801f8f.20.2024.06.19.07.43.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jun 2024 07:43:02 -0700 (PDT)
Message-ID: <9c8751b4-4f6b-4a05-879a-13aec4ecddbb@canonical.com>
Date: Wed, 19 Jun 2024 16:43:01 +0200
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
 <e1fb4d81-a20c-4a10-904e-8b19eb17f4e5@canonical.com>
 <CAC_iWjKwP0psK0cuQLion54h5ZQdYL8-R_1oDvTYktin56OFDQ@mail.gmail.com>
 <CAC_iWjL3pSQDgkNvLQjUEO2JbhtaRhCy81ZDn=WPiONmEZvVWQ@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAC_iWjL3pSQDgkNvLQjUEO2JbhtaRhCy81ZDn=WPiONmEZvVWQ@mail.gmail.com>
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

On 19.06.24 15:19, Ilias Apalodimas wrote:
> On Wed, 19 Jun 2024 at 16:05, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
>>
>> On Wed, 19 Jun 2024 at 15:36, Heinrich Schuchardt
>> <heinrich.schuchardt@canonical.com> wrote:
>>>
>>> On 19.06.24 14:23, Ilias Apalodimas wrote:
>>>> On Sun, 16 Jun 2024 at 20:31, Heinrich Schuchardt
>>>> <heinrich.schuchardt@canonical.com> wrote:
>>>>>
>>>>> If we have multiple weak implementations of functions, the linker might
>>>>> choose any of these. ARM and RISC-V already provide a weak implementation
>>>>> of flush_dcache_all().
>>>>>
>>>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>>>> ---
>>>>>    cmd/cache.c | 3 +++
>>>>>    1 file changed, 3 insertions(+)
>>>>>
>>>>> diff --git a/cmd/cache.c b/cmd/cache.c
>>>>> index 0254ff17f9b..16fa0f7c652 100644
>>>>> --- a/cmd/cache.c
>>>>> +++ b/cmd/cache.c
>>>>> @@ -52,11 +52,14 @@ static int do_icache(struct cmd_tbl *cmdtp, int flag, int argc,
>>>>>           return 0;
>>>>>    }
>>>>>
>>>>> +/* ARM and RISC-V define a weak flush_dcache_all() themselves. */
>>>>> +#if !defined(CONFIG_ARM) && !defined(CONFIG_RISCV)
>>>>>    void __weak flush_dcache_all(void)
>>>>>    {
>>>>>           puts("No arch specific flush_dcache_all available!\n");
>>>>>           /* please define arch specific flush_dcache_all */
>>>>>    }
>>>>
>>>> Aren't we supposed to add a single __weak function so the linker can
>>>> replace it? IOW why is the declaration for Arm/riscv a weak one?
>>>
>>> Some sub-architectures override the architecture specific weak
>>> implementation, e.g.
>>>
>>> arch/riscv/cpu/andes/cache.c:44:
>>> void flush_dcache_all(void)
>>>
>>> arch/arm/cpu/arm926ejs/cache.c:17:
>>> void flush_dcache_all(void)
>>
>> Ok, this does fix a problem, but afaict this is a band-aid and the
>> cache management is a mess overall -- e.g invalidate_icache_all() will
>> suffer from the same issue if a sub-architecture decides to define its
>> own in the future.
>>
>> Would it be less bad to define
>> static inline __weak flush_dcache_all(void)
>> {
>> }
>> static inline __weak flush_icache_all(void)
>> {
>> }
> 
> ugh, this but without the inline!
> 
> Thanks
> /Ilias

GCC does not allow both a weak and a strong implementation in the same 
module:

   CC      board/sandbox/sandbox.o
arch/sandbox/cpu/cache.c:15:6: error: redefinition of 
‘invalidate_icache_all’
    15 | void invalidate_icache_all(void)
       |      ^~~~~~~~~~~~~~~~~~~~~
In file included from arch/sandbox/cpu/cache.c:6:
include/cpu_func.h:74:13: note: previous definition of 
‘invalidate_icache_all’ with type ‘void(void)’
    74 | void __weak invalidate_icache_all(void)
       |             ^~~~~~~~~~~~~~~~~~~~~

Best regards

Heinrich

>> in include/cpu_func.h instead of a random cmd file?
>> We can only define those if !CONFIG_ARM && !!CONFIG_RISCV and add a
>> comment on why.
>> It's kind of putting lipstick on a pig, but at least we'll have them
>> gathered in a single header file and know what we have to fix.
>>
>> Cheers
>> /Ilias
>>>
>>> Best regards
>>>
>>> Heinrich
>>>
>>>>
>>>> Thanks
>>>> /Ilias
>>>>> +#endif
>>>>>
>>>>>    static int do_dcache(struct cmd_tbl *cmdtp, int flag, int argc,
>>>>>                        char *const argv[])
>>>>> --
>>>>> 2.43.0
>>>>>
>>>

