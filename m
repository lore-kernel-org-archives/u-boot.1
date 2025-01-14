Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39DAFC02184
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 08:39:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58FAC80085;
	Tue, 14 Jan 2025 09:39:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7711C80657; Tue, 14 Jan 2025 09:39:02 +0100 (CET)
Received: from metis.whiteo.stw.pengutronix.de
 (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A9138007D
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 09:39:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=pengutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=a.fatoum@pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77]
 helo=[127.0.0.1])
 by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
 (envelope-from <a.fatoum@pengutronix.de>)
 id 1tXcRm-0005m6-9r; Tue, 14 Jan 2025 09:38:50 +0100
Message-ID: <25177dc9-628f-4798-9ee8-b1a4a7845b19@pengutronix.de>
Date: Tue, 14 Jan 2025 09:38:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] armv8: mmu: don't switch to emergency tlb when adding a
 dynamic mapping
To: =?UTF-8?Q?Pierre-Cl=C3=A9ment_Tosi?= <ptosi@google.com>,
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: Marc Zyngier <maz@kernel.org>, Andre Przywara <andre.przywara@arm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Hoyes <Peter.Hoyes@arm.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot-qcom@groups.io, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.denx.de
References: <20250108142235.1194640-1-caleb.connolly@linaro.org>
 <86septwdlr.wl-maz@kernel.org>
 <37c914cd-8f66-4474-8b88-7464b256cd49@linaro.org>
 <wyoagqda5bxjx3xbj5spdsp3n65woxf5u3mkz3a2fdrinn4bo2@pqmc5tidoeys>
Content-Language: en-US
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <wyoagqda5bxjx3xbj5spdsp3n65woxf5u3mkz3a2fdrinn4bo2@pqmc5tidoeys>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: u-boot@lists.denx.de
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

Hi Pierre,

On 08.01.25 16:52, Pierre-Clément Tosi wrote:
> Hi Caleb,
> 
> On Wed, Jan 08, 2025 at 04:19:07PM +0100, Caleb Connolly wrote:
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
>>
>> In hindsight, this mmu_map_region() function is not great in a lot of
>> ways, I'm still getting my head around the MMU and I expect this will
>> keep being improved.
> 
> Yes, [1] should not have used map_range() on live PTs as it assumes that
> 
> 1. the PTs it modifies aren't live so doesn't perform Break Before Make;

Quoting ARM ARM (L.a) D8.17.1 "Using break-before-make when updating translation
table entries":

  If multiple execution threads use the same translation tables, then when a
  translation table entry is modified in one or more of the following ways,
  the architecture requires software to use a break-before-make sequence: [...]

So I am wondering: Does the break-before-make requirement even apply to a
single-threaded software like U-Boot?

Cheers,
Ahmad

> 2. the MMU is off so doesn't perform cache maintenance (on AArch64, CPU caches
>    can't be enabled without also enabling the MMU)
> 
> This patch attempts to (somehow) address 2. but 1. is still an issue anyway.
> 
> FYI, see the discussion around [2] which is somewhat related. I suppose at least
> adding documentation to clearly state the assumptions map_range() makes would be
> helpful, in the short term.
> 
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
>>
>> I'm wondering if this tlb_addr variable is misnamed, I'm reading ARM
>> docs which suggest the TLB is some cache inside(?) the MMU, but this
>> tlb_addr in U-Boot actually points to the translation table in memory if
>> my understanding is correct?
> 
> You're correct that tlb_addr has nothing to do with TLBs. IIRC, it's the
> contiguous region (with a size fixed at boot time, distinct from the malloc
> region) from which memory holding page tables is allocated.
> 
>>
>> Kind regards,
>>>
>>> 	M.
>>>
>>
>> -- 
>> // Caleb (they/them)
>>
> 
> [1]: https://lore.kernel.org/u-boot/20240809-b4-snapdragon-improvements-v1-8-7c353f3e8f74@linaro.org/
> [2]: https://lore.kernel.org/u-boot/43haokus4jdxguk4arig5tsqcgq2wbezwpbj7oti6pdkvrfual@wa7vz2iypcv5/
> 
> HTH,
> 
> Pierre


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
