Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AA8DE77199
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 15:19:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A34558036B;
	Wed,  8 Jan 2025 16:19:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="As6evMW6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1837A805E2; Wed,  8 Jan 2025 16:19:12 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA50B8001F
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 16:19:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5d3f28881d6so25092352a12.1
 for <u-boot@lists.denx.de>; Wed, 08 Jan 2025 07:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736349549; x=1736954349; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dYdIa5gUsbSn5ZGj9lfbD3gDZHkLFt6hKvtFlb6fzzw=;
 b=As6evMW6aFY/l4YdGBD9v/9JSVtzSNHx9ZOxOYNKoWpA+mFl0lqoQHDa5pN2PyJ/Pe
 +m5boqUEVWj1Ms49XaVK7uYdngyagvrPsbhMZC0qg1gYSvl9x1d7FfDxVvXwSS8/jZfJ
 vQVI3AwQ/NyjKSgS95CaUX8Yz9VfMI/EIBEQS5dtudXTHAEJaY/gr5OW9GLWVOeN2/eq
 f/1Qj04T/TrgY7JpIO+78MZLMLiBfdUCyO6QPrPRVStlk4T268Jdhj2fAKkYGhBAR85N
 E7gk/6MWgU/XEUQziIItBN8QCr/nTugV28N9eoVmgP2g9JIa23uXrDQlSDrYQIS5lev2
 YrHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736349549; x=1736954349;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dYdIa5gUsbSn5ZGj9lfbD3gDZHkLFt6hKvtFlb6fzzw=;
 b=oH1zq0Urt6YMI34TC8a2gLLPMXXwblOXHQBBNGDQY3nvaHLJH0WuZCz3CY5tpRF7tE
 ELJfEvNi5zMvcp7A6np/ucyTbLck9BFVQcUXW4+G8xSGWYUTJSXx8KbeGlOM6SoRVto5
 5QDlncK7gAFMshgHPbwmHaYWFi4CQEOQqewGb/va57cUfoBaoQ9bD6/YI8PAjs3GnTDx
 peMbPfXik3byTjcZXaTSlgUC8eL1UmZhufgh0JDcI/rt4+sHM4bymnC7fAFHqF1F9RAp
 wtbJ6te2KOFn12WxrrZWFEEjm5QbZ8y6tycvCIcbTF/oMX+PbcGQwYcEGA+rxpZtaWWq
 PQCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUos2SzfPozjpZUtZt8kcmgflEYdBDcPS0ZvNfLgClPgCy7yJ+Go+u5bwV4z8P13qX3fBUfxsw=@lists.denx.de
X-Gm-Message-State: AOJu0YxBmCgoPf+IZCFh2CaAIhXTL3p7LV0Zr6h9C8ua/IHyhJXZJYaE
 tSbvtBuxDc1TFriImbefhAMojNNawPTe6VrQ7prtdvf14GZ6yrtERHt8oiulzJA=
X-Gm-Gg: ASbGnct90ymHOKSZym5MOroSR/rCKPMMv5LUppyvAhbso/gg1quVMDqy/7DOLkHARnu
 v6sgmtNn48L4XV3LLScicpgtcUKcWXF9IxCq9UKnWCWXj82u5vDkXCedpli8z5xnNrjp1vV2lg9
 luhPxPmuAyJkyQrfI+YrVtza08RN3lBR0KI3X9MXPya9fTihbGWD5Zst/mRGJZtDidYFHb2tY8X
 FRvNBzclO+qQKVI9iFTGNTMt+PT2pYdT8lkA9NArENnRrIwm0r35uchRxJ/sCfWZdnbhGQlH4Z9
 2sqhTBZDIBDbfDQB/9w6rGET4BRruFGCMsefjK4=
X-Google-Smtp-Source: AGHT+IH189fElZA358G4c9QzsKrWHp1xTPg2jxCQn9P+21sqnJn7mhr1VqxRFRYI0ug1rIxWf2ZtPw==
X-Received: by 2002:a05:6402:51c9:b0:5d3:ba42:e9e3 with SMTP id
 4fb4d7f45d1cf-5d972e0e3a0mr7414137a12.13.1736349549119; 
 Wed, 08 Jan 2025 07:19:09 -0800 (PST)
Received: from ?IPV6:2a02:8109:888d:ff00:ca7f:54ff:fe52:4519?
 ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0e8961d6sm2495298666b.75.2025.01.08.07.19.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2025 07:19:08 -0800 (PST)
Message-ID: <37c914cd-8f66-4474-8b88-7464b256cd49@linaro.org>
Date: Wed, 8 Jan 2025 16:19:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] armv8: mmu: don't switch to emergency tlb when adding a
 dynamic mapping
Content-Language: en-US
To: Marc Zyngier <maz@kernel.org>
Cc: Andre Przywara <andre.przywara@arm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Hoyes <Peter.Hoyes@arm.com>, =?UTF-8?Q?Pierre-Cl=C3=A9ment_Tosi?=
 <ptosi@google.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot-qcom@groups.io, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.denx.de
References: <20250108142235.1194640-1-caleb.connolly@linaro.org>
 <86septwdlr.wl-maz@kernel.org>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <86septwdlr.wl-maz@kernel.org>
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

Hi Marc,

Thanks for your comments.

On 08/01/2025 16:05, Marc Zyngier wrote:
> On Wed, 08 Jan 2025 14:22:24 +0000,
> Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>
>> This seems to cause crashes on a bunch of Qualcomm platforms. It's safer
>> to just update the live table and flush it.
> 
> You may want to provide a bit more information, because that's not
> much to go on, really.

Best I have is "the board hangs and then resets when trying to switch
pagetables", I didn't manage to narrow it down exactly, but since it
seems to work to update the tables without switching that feels like a
better approach at least for now.

In hindsight, this mmu_map_region() function is not great in a lot of
ways, I'm still getting my head around the MMU and I expect this will
keep being improved.
> 
>>
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>> ---
>>  arch/arm/cpu/armv8/cache_v8.c | 11 ++---------
>>  arch/arm/include/asm/system.h |  3 +--
>>  drivers/soc/qcom/cmd-db.c     |  2 +-
>>  3 files changed, 4 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
>> index e6be6359c5d9..43051d156122 100644
>> --- a/arch/arm/cpu/armv8/cache_v8.c
>> +++ b/arch/arm/cpu/armv8/cache_v8.c
>> @@ -338,9 +338,9 @@ static void map_range(u64 virt, u64 phys, u64 size, int level,
>>  		size -= next_size;
>>  	}
>>  }
>>  
>> -void mmu_map_region(phys_addr_t addr, u64 size, bool emergency)
>> +void mmu_map_region(phys_addr_t addr, u64 size)
>>  {
>>  	u64 va_bits;
>>  	int level = 0;
>>  	u64 attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_INNER_SHARE;
>> @@ -350,19 +350,12 @@ void mmu_map_region(phys_addr_t addr, u64 size, bool emergency)
>>  	get_tcr(NULL, &va_bits);
>>  	if (va_bits < 39)
>>  		level = 1;
>>  
>> -	if (emergency)
>> -		map_range(addr, addr, size, level,
>> -			  (u64 *)gd->arch.tlb_emerg, attrs);
>> -
>> -	/* Switch pagetables while we update the primary one */
>> -	__asm_switch_ttbr(gd->arch.tlb_emerg);
>> -
>>  	map_range(addr, addr, size, level,
>>  		  (u64 *)gd->arch.tlb_addr, attrs);
>>  
>> -	__asm_switch_ttbr(gd->arch.tlb_addr);
>> +	flush_dcache_range(gd->arch.tlb_addr, gd->arch.tlb_size);
> 
> Why would you invalidate anything when *mapping* something? By
> definition, if there was nothing mapped before, there is nothing to
> invalidate (hint: the architecture forbids negative caching).

This isn't flushing the region or TLB, it's flushing the translation
table we just modified.

I'm wondering if this tlb_addr variable is misnamed, I'm reading ARM
docs which suggest the TLB is some cache inside(?) the MMU, but this
tlb_addr in U-Boot actually points to the translation table in memory if
my understanding is correct?

Kind regards,
> 
> 	M.
> 

-- 
// Caleb (they/them)

