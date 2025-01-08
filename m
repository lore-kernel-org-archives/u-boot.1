Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19143E77188
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 16:07:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87AC1800DF;
	Wed,  8 Jan 2025 17:07:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NjpBLKbZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D7AD80196; Wed,  8 Jan 2025 17:07:22 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F0278006D
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 17:07:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-aab6fa3e20eso2824616266b.2
 for <u-boot@lists.denx.de>; Wed, 08 Jan 2025 08:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736352439; x=1736957239; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zZ/vwm/oWa7myqz2+N7kyDX8TNB6pQd/3I4XlGTUCfo=;
 b=NjpBLKbZl2L8V5jJphF77/bwWO+6SYMmQkABsMFYhqfOZgnEaQ2B9CEzLN8p18AcGs
 fwoeQKHvn8NJtCriRB35hrdkFqd2fwAcMIDsAhITISbpIqZXL/wxzMg4Ohh9bv2mRF9t
 13Bke7wUsLaKSsY+ygaHDl0lmFyIjtfH7/tpVEbR4Srasc2Zm/80XnWJBLn9i3zjlclG
 WxDWqvHrNNQ4+ZckkL+0n1efYDjEQduYXhFJZgVKEHQyoQNijUcr7J0GPmbfe1b/JBry
 2SpUuFU2TmtCEhSbwj/A3397Cr7xnAqvemQEwPtAqM+vkunKUkMnSmS4yKRTT847XPtx
 Rquw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736352439; x=1736957239;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zZ/vwm/oWa7myqz2+N7kyDX8TNB6pQd/3I4XlGTUCfo=;
 b=tvr5BezOhyLbwxtfPnOf5Ww2uD+cc++cRwnHSmk2se3YBOzXo1xtClX0iUPH44VqGh
 i6zw6kTfitfST79ekmBduugFCSxubYlqXjZzRtnUCU5AQnHKsEL0nvo1rLwvZvCPGo9f
 a6xpXSB916XcqzWGHqkPkDYUMM3OqhEqNZRQ8LvlerZLZl9YVQQrZscWyfQ/W+TxgVr+
 QAxEpy4hRDZDSY/HtNfZkPCD1Ir7tMYddYokqGFr23yCLJKsscZtWcX3S1P2Wj/KBYer
 E+iFc6TB1n+1JxWXMBPreh2oobSlgkQxV960tJ9vvUjR52XW5u8l423585Y0+PRh6FtD
 ATQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/uus+M90jqKqoQreNPLpMXSopsoUCjNbXDn6oRG47WzQKvL89/DShVfPidPQnSqKBylaR6qw=@lists.denx.de
X-Gm-Message-State: AOJu0YywnCmv77rAi+p55d6Qgwn8ElLB+9bfme/9FQ2/d9Q+fylMk6rH
 alBilIVaFhW5C/vwvkEDrj4jzgiOz01TUzyHjifcaSdbGvYWXrNOO221zJwMYAg=
X-Gm-Gg: ASbGncsxnUVAkhcXDnRnBKzmysj6TdjCxMtl+xzM14EF49OBQVwUSBQBP1Y1/eXykOA
 qZ7Qu9FWyn4MYGShCRLMdXahTOqZ2kVv9YtHBdWXNwYPW2A2eYjCUYqb9nUnQ9h97gVoyEu2a5Z
 Q7VXOlHTEwHxWB4/Kv0DuTmgkh1fAT0lP/AK+nMA6CagTMgKkiKA+ApPUqgGQHuddiWC/iMK3If
 szVTRCi3UVoPz+1RdDIG6FdyUgMh4xu7xCC06e464tQ8jon6M7LNf56n4Pcf9y5/mM5hRy05kkH
 4vRavtyhGcomKCTvhq4sApHihpr9hJfQlAVm8OA=
X-Google-Smtp-Source: AGHT+IHpg0yI5SJyeHJtxmZXvQFV/rVepyiRFHMti5QEOylaM0Ngw3CAjdec4xo/fWVhz1lb15ZXcg==
X-Received: by 2002:a17:907:9490:b0:aa6:6885:e2f0 with SMTP id
 a640c23a62f3a-ab2abc78dd7mr313450666b.46.1736352439459; 
 Wed, 08 Jan 2025 08:07:19 -0800 (PST)
Received: from ?IPV6:2a02:8109:888d:ff00:ca7f:54ff:fe52:4519?
 ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0e894c2esm2548639966b.67.2025.01.08.08.07.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2025 08:07:18 -0800 (PST)
Message-ID: <ef1fd090-a867-4546-8066-919ed61886bd@linaro.org>
Date: Wed, 8 Jan 2025 17:07:17 +0100
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
 <37c914cd-8f66-4474-8b88-7464b256cd49@linaro.org>
 <86r05dwbva.wl-maz@kernel.org>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <86r05dwbva.wl-maz@kernel.org>
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



On 08/01/2025 16:42, Marc Zyngier wrote:
> On Wed, 08 Jan 2025 15:19:07 +0000,
> Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>
>> Hi Marc,
>>
>> Thanks for your comments.
>>
>> On 08/01/2025 16:05, Marc Zyngier wrote:
>>> On Wed, 08 Jan 2025 14:22:24 +0000,
>>> Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>>>
>>>> This seems to cause crashes on a bunch of Qualcomm platforms. It's safer
>>>> to just update the live table and flush it.
>>>
>>> You may want to provide a bit more information, because that's not
>>> much to go on, really.
>>
>> Best I have is "the board hangs and then resets when trying to switch
>> pagetables", I didn't manage to narrow it down exactly, but since it
>> seems to work to update the tables without switching that feels like a
>> better approach at least for now.
> 
> I think you should completely characterise the issue before changing
> things like this. My hunch is that the so-called "emergency" page
> tables do not map the page tables you're modifying. Or something along
> those lines. But you really want to get to the bottom of it.

Well, I was the person who added this function and the only user is a
qualcomm driver which needed this because it accesses some reserved
memory which is sometimes not included in the memory map we get from a
previous bootloader stage.

I guess it happened to work on the board I was using at the time, but on
newer platforms with a different hypervisor or when running in EL2 this
code does not work correctly at all.

I can't really find much good documentation on the specific steps that
should be followed to do what I want to do here, but considering that
this patch works and the current version doesn't it seems like an
improvement at least.

And yes, I'd like to spend more time getting my head around this, I'm
sure it's something I'll return to.


> 
>>
>> In hindsight, this mmu_map_region() function is not great in a lot of
>> ways, I'm still getting my head around the MMU and I expect this will
>> keep being improved.
>>>
>>>>
>>>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>>>> ---
>>>>  arch/arm/cpu/armv8/cache_v8.c | 11 ++---------
>>>>  arch/arm/include/asm/system.h |  3 +--
>>>>  drivers/soc/qcom/cmd-db.c     |  2 +-
>>>>  3 files changed, 4 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
>>>> index e6be6359c5d9..43051d156122 100644
>>>> --- a/arch/arm/cpu/armv8/cache_v8.c
>>>> +++ b/arch/arm/cpu/armv8/cache_v8.c
>>>> @@ -338,9 +338,9 @@ static void map_range(u64 virt, u64 phys, u64 size, int level,
>>>>  		size -= next_size;
>>>>  	}
>>>>  }
>>>>  
>>>> -void mmu_map_region(phys_addr_t addr, u64 size, bool emergency)
>>>> +void mmu_map_region(phys_addr_t addr, u64 size)
>>>>  {
>>>>  	u64 va_bits;
>>>>  	int level = 0;
>>>>  	u64 attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_INNER_SHARE;
>>>> @@ -350,19 +350,12 @@ void mmu_map_region(phys_addr_t addr, u64 size, bool emergency)
>>>>  	get_tcr(NULL, &va_bits);
>>>>  	if (va_bits < 39)
>>>>  		level = 1;
>>>>  
>>>> -	if (emergency)
>>>> -		map_range(addr, addr, size, level,
>>>> -			  (u64 *)gd->arch.tlb_emerg, attrs);
>>>> -
>>>> -	/* Switch pagetables while we update the primary one */
>>>> -	__asm_switch_ttbr(gd->arch.tlb_emerg);
>>>> -
>>>>  	map_range(addr, addr, size, level,
>>>>  		  (u64 *)gd->arch.tlb_addr, attrs);
>>>>  
>>>> -	__asm_switch_ttbr(gd->arch.tlb_addr);
>>>> +	flush_dcache_range(gd->arch.tlb_addr, gd->arch.tlb_size);
>>>
>>> Why would you invalidate anything when *mapping* something? By
>>> definition, if there was nothing mapped before, there is nothing to
>>> invalidate (hint: the architecture forbids negative caching).
>>
>> This isn't flushing the region or TLB, it's flushing the translation
>> table we just modified.
> 
> Ah, you're obviously right. I can't read today...
> 
> But it then begs the question: are the page tables configured to be
> accessed by the page-table walker in a non-cacheable fashion? That'd
> be rather silly, and the only reason why you'd need any form of CMO at
> this point.

you're probably right. Barebox has a broader arch_remap_range() function
which seems to be much more robustly implemented, definitely worth
taking things from there going forwards I think.
> 
>> I'm wondering if this tlb_addr variable is misnamed, I'm reading ARM
>> docs which suggest the TLB is some cache inside(?) the MMU, but this
>> tlb_addr in U-Boot actually points to the translation table in memory if
>> my understanding is correct?
> 
> That's my impression, but each time I look at this code, I feel a bit
> sick...

Yeah there are a whole lot of problems here and barebox has already
solved a lot of them (thanks Ahmad) so hopefully we can start aligning
with them and improve things on the U-Boot side...

In the meantime, this patch at least partially fixes a function that was
broken from it's inception, alternatively I can remove it and do some
ugly hacks in board code to ensure the region is in the memory map
before we create it.
> 
> 	M.
> 

-- 
// Caleb (they/them)

