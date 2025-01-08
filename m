Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 213CBE77188
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 15:52:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84478805FB;
	Wed,  8 Jan 2025 16:52:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="dGDn6cZb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C948D80607; Wed,  8 Jan 2025 16:52:33 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 591488036B
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 16:52:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ptosi@google.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-aa692211331so204560666b.1
 for <u-boot@lists.denx.de>; Wed, 08 Jan 2025 07:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1736351551; x=1736956351; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0AdCbfcO/af6f+IHi687QXt57/hG+C6kg0Qyua1qPLI=;
 b=dGDn6cZbQbm6233C1DxcQfvQOweQhDxAO3mvFmJxiDxLqpWE/VMohfreteCbNxoYfi
 t859t9cqFaD1GMHADWsFhlQFTVPeFcClxPrpU0iq65WxO8AxEYNWz9g9sfyJT0tXo9r+
 Z0BCTQTlh/ynMFGUR7k89jQf+bgXu3KyN9OhlZmSEr+jNbdM4yGvKjNWGKfeDY5XTnHA
 jl9xykS376qBKQN4d49i68BVn8DJXgqfBD1LS3P8wFvuqE5B1c4cg4ShAufVmKQoUJ5A
 nSEYvGgcJs3lD330/X3nNvCi1dmPbIV0OiemGlO6Kw4+fe3eWYUtVh+p6Evr8a8NbZZM
 GSXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736351551; x=1736956351;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0AdCbfcO/af6f+IHi687QXt57/hG+C6kg0Qyua1qPLI=;
 b=mKOpZmmPvK6W2DYWtBTYDJcSuJ7Ak3U1GZc0rZbw8L5EaoKSeL0tidZep2kt4NEnIl
 OmXzn4qgLcgsbNNDswsA2EYt8Cve/RIJ09DC4OW1wHIOQobKvKFynd+h4WizIxsU2bBY
 jNryRqCuQx6ktZ8gEoNvQDcCjBdf6YfeHtsOOJxyitUDEZSc2vCzJBs2LW0O5p2JzdYX
 3LFHaSbI6bguasPVhEClN00pHhDECjrepkRTndgDM2oKRiU4jMHwWrTQXuBPnOgMxtLr
 6CZNMblRFkiwT3OS6L5uVo/Pop09oPoKadiDAX9BJF4B7x/PsrHV/Wg1FYLX3kkZk25K
 rcfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkRKCWfGIst//FZamu1seECUeScrDI7rclfdsZnz2LG+13X9++GbDUiCcEAW3DhpDAEtp1Xik=@lists.denx.de
X-Gm-Message-State: AOJu0YxJeOFgQ3+bKRZM4T5RVJSnRQOwROg7L4qe7LcJypeDYgSIyeg1
 U8QZpsGuY/qqxfBOW61A0Z/1sLHZfT012wR+1Su7+AQp7xSLpAKJdWw5Dlwo8w==
X-Gm-Gg: ASbGncuMMNH9UAdlJk9TDM/uaDDliX7D+GdvbVQFdFnQRnQCasJ3YgR/5tk01Jau/q5
 DQ+wCiYBinsdurItFQjQTL+VbxZ+1oncIqr5McK03y7cFITYWOHebwm4sHeLNdNn2LBhUQBHWXt
 lrAsTeZH7RV2xxHG0lVTuStMblU61moPHkSckfqRhMPcbvamj+pAe2G6vuIxdKATqJYOWAhSEjD
 v6cDgfhqLvm4fR7mJxNTPaJSL8tEP1vZIkoMtgX7i/jxQNKpFzYWTr8Bth9sKt7C1BHpS6xSmZ6
 oOBjd8siOg==
X-Google-Smtp-Source: AGHT+IHG2UOFxTcRQUVOQprKZupsvHG7B7T1qQDzo+qxYaQdQZSSU933OOognsIHMzvW5tQC7n+uUw==
X-Received: by 2002:a17:907:7ea3:b0:aae:bb48:211e with SMTP id
 a640c23a62f3a-ab291928ea1mr601343166b.27.1736351550399; 
 Wed, 08 Jan 2025 07:52:30 -0800 (PST)
Received: from google.com (194.0.34.34.bc.googleusercontent.com. [34.34.0.194])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0e82f5c4sm2501652866b.30.2025.01.08.07.52.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 07:52:29 -0800 (PST)
Date: Wed, 8 Jan 2025 15:52:25 +0000
From: =?utf-8?Q?Pierre-Cl=C3=A9ment?= Tosi <ptosi@google.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Marc Zyngier <maz@kernel.org>, Andre Przywara <andre.przywara@arm.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Peter Hoyes <Peter.Hoyes@arm.com>, Simon Glass <sjg@chromium.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot-qcom@groups.io, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] armv8: mmu: don't switch to emergency tlb when adding a
 dynamic mapping
Message-ID: <wyoagqda5bxjx3xbj5spdsp3n65woxf5u3mkz3a2fdrinn4bo2@pqmc5tidoeys>
References: <20250108142235.1194640-1-caleb.connolly@linaro.org>
 <86septwdlr.wl-maz@kernel.org>
 <37c914cd-8f66-4474-8b88-7464b256cd49@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37c914cd-8f66-4474-8b88-7464b256cd49@linaro.org>
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

Hi Caleb,

On Wed, Jan 08, 2025 at 04:19:07PM +0100, Caleb Connolly wrote:
> Hi Marc,
> 
> Thanks for your comments.
> 
> On 08/01/2025 16:05, Marc Zyngier wrote:
> > On Wed, 08 Jan 2025 14:22:24 +0000,
> > Caleb Connolly <caleb.connolly@linaro.org> wrote:
> >>
> >> This seems to cause crashes on a bunch of Qualcomm platforms. It's safer
> >> to just update the live table and flush it.
> > 
> > You may want to provide a bit more information, because that's not
> > much to go on, really.
> 
> Best I have is "the board hangs and then resets when trying to switch
> pagetables", I didn't manage to narrow it down exactly, but since it
> seems to work to update the tables without switching that feels like a
> better approach at least for now.
> 
> In hindsight, this mmu_map_region() function is not great in a lot of
> ways, I'm still getting my head around the MMU and I expect this will
> keep being improved.

Yes, [1] should not have used map_range() on live PTs as it assumes that

1. the PTs it modifies aren't live so doesn't perform Break Before Make;
2. the MMU is off so doesn't perform cache maintenance (on AArch64, CPU caches
   can't be enabled without also enabling the MMU)

This patch attempts to (somehow) address 2. but 1. is still an issue anyway.

FYI, see the discussion around [2] which is somewhat related. I suppose at least
adding documentation to clearly state the assumptions map_range() makes would be
helpful, in the short term.

> > 
> >>
> >> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> >> ---
> >>  arch/arm/cpu/armv8/cache_v8.c | 11 ++---------
> >>  arch/arm/include/asm/system.h |  3 +--
> >>  drivers/soc/qcom/cmd-db.c     |  2 +-
> >>  3 files changed, 4 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
> >> index e6be6359c5d9..43051d156122 100644
> >> --- a/arch/arm/cpu/armv8/cache_v8.c
> >> +++ b/arch/arm/cpu/armv8/cache_v8.c
> >> @@ -338,9 +338,9 @@ static void map_range(u64 virt, u64 phys, u64 size, int level,
> >>  		size -= next_size;
> >>  	}
> >>  }
> >>  
> >> -void mmu_map_region(phys_addr_t addr, u64 size, bool emergency)
> >> +void mmu_map_region(phys_addr_t addr, u64 size)
> >>  {
> >>  	u64 va_bits;
> >>  	int level = 0;
> >>  	u64 attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_INNER_SHARE;
> >> @@ -350,19 +350,12 @@ void mmu_map_region(phys_addr_t addr, u64 size, bool emergency)
> >>  	get_tcr(NULL, &va_bits);
> >>  	if (va_bits < 39)
> >>  		level = 1;
> >>  
> >> -	if (emergency)
> >> -		map_range(addr, addr, size, level,
> >> -			  (u64 *)gd->arch.tlb_emerg, attrs);
> >> -
> >> -	/* Switch pagetables while we update the primary one */
> >> -	__asm_switch_ttbr(gd->arch.tlb_emerg);
> >> -
> >>  	map_range(addr, addr, size, level,
> >>  		  (u64 *)gd->arch.tlb_addr, attrs);
> >>  
> >> -	__asm_switch_ttbr(gd->arch.tlb_addr);
> >> +	flush_dcache_range(gd->arch.tlb_addr, gd->arch.tlb_size);
> > 
> > Why would you invalidate anything when *mapping* something? By
> > definition, if there was nothing mapped before, there is nothing to
> > invalidate (hint: the architecture forbids negative caching).
> 
> This isn't flushing the region or TLB, it's flushing the translation
> table we just modified.
> 
> I'm wondering if this tlb_addr variable is misnamed, I'm reading ARM
> docs which suggest the TLB is some cache inside(?) the MMU, but this
> tlb_addr in U-Boot actually points to the translation table in memory if
> my understanding is correct?

You're correct that tlb_addr has nothing to do with TLBs. IIRC, it's the
contiguous region (with a size fixed at boot time, distinct from the malloc
region) from which memory holding page tables is allocated.

> 
> Kind regards,
> > 
> > 	M.
> > 
> 
> -- 
> // Caleb (they/them)
> 

[1]: https://lore.kernel.org/u-boot/20240809-b4-snapdragon-improvements-v1-8-7c353f3e8f74@linaro.org/
[2]: https://lore.kernel.org/u-boot/43haokus4jdxguk4arig5tsqcgq2wbezwpbj7oti6pdkvrfual@wa7vz2iypcv5/

HTH,

Pierre
