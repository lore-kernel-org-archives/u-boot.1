Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD872C02190
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 10:13:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4155B82012;
	Thu, 30 Jan 2025 11:13:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="QuL9t+Dg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEA6780C85; Thu, 30 Jan 2025 11:13:15 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7B8C82076
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 11:13:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1738231983; x=1738836783; i=xypron.glpk@gmx.de;
 bh=eBW2PzPVHoTvZBXtAVWbELfccH6JeK3RDtoXQm9Lzp8=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=QuL9t+Dgs0+qDMLM5XXPbRrNE2CqaNVJpAioX7gXF8GbamvIsn4imlTOEUdYrhRJ
 fZ79k1/diHA/H1LGSnC1B2aLdmd/u9Vhs7DMRBfs2zqsZ3CDS1O02VzbW8R1Q39Wp
 XswQoA+hVhIi6p2jL+TUzXsWI0dbkd15jqiP9VdPJOp5G+qeQyM8z+JGftFBVjCHQ
 1XY9pr45sltSJgDPnfaNThrx/hZKU31XH9yD9IQzPTxMhiKrcbizE5ABDJmBwOhUU
 vqEFzYy4OqwoBpDzDxTG/cqbK5Eauw8uhKrJwkkxoAy2jAja0QgPj8FF/KHO+EioX
 2FOu5lFyIfV2tth/jw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MmlXK-1tDlxR1gfO-00iz9T; Thu, 30
 Jan 2025 11:13:03 +0100
Message-ID: <60b99e2f-a354-4449-bdd2-abba07615321@gmx.de>
Date: Thu, 30 Jan 2025 11:12:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/4] arm64: mmu_change_region_attr() add an option not
 to break PTEs
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>, =?UTF-8?Q?Pierre-Cl=C3=A9ment_Tosi?=
 <ptosi@google.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>, Peter Hoyes <Peter.Hoyes@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, Sam Day <me@samcday.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Michal Simek
 <michal.simek@amd.com>, Jerome Forissier <jerome.forissier@linaro.org>,
 u-boot@lists.denx.de, u-boot-qcom@groups.io, maz@kernel.org,
 trini@konsulko.com, CFSworks@gmail.com
References: <20250130072100.27297-1-ilias.apalodimas@linaro.org>
 <20250130072100.27297-4-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250130072100.27297-4-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YccUF44PiYMnz3+pkJamXluz7N7+PP1H740+56uVNMeWQkQb8R9
 Ztu6DdHGh6qTvqffWqP7sNVK+5YNyFH57ng1mn756iYu9RDX8LZWnADj/JhnyTRhVqikO8W
 2NT61Zdra+ryhB2A33Q+E/5kSr16hNnJRh4OUnkRGSdJGhzNogVBN82HppKrF79IOpFJgKQ
 oBDBf7R7MKVMHtg1GyYVA==
UI-OutboundReport: notjunk:1;M01:P0:ZxjUxCX3nHY=;sWYTDFPQFCLjFSW5/yTQ9oRgVIf
 MCRZPqUv1cbB4Dv8gUBAsvFw1xHC9vOft0gbW0H77AEZdcJkkYCEK826SLsrYGK5E4NsLEH16
 G+yzl2ZXiFZyM+CllqlaSICYxcKKCCQT/oNyoRpU0GrrATOOQmwxBRQOLyPhpUcimChC4PcHI
 qOKELkC9dMe6YLraVQ7UUcNv4EEAHpZEX35PBr+SbRa9h4YiQSENhEkLAhZkfWGXIFw0afiZw
 gGdyfloI+LqTkP4JMd+WpGFCMTAMik/FzhTXOl3+GedD21gU5bTWCZbyJZD0ZuT+HPGtXPJO9
 e7Ih/Qi9sTgc2JsNaRqkcgBGpbXXaI4XqibcfrjpW5pxNXMgLnfi6Cs1Wa59rdJs9tpHP61pe
 kUeIhKFP2tJQc+c3z1Ol6Fzlz8+j/0IjN8NJyXSPPLGPkjezpERgG7OSO/7IyRB7z9+BUkwnV
 MckJExbRv/gFPkqvwOmP09JsW/kne2fsos64go/pprjTNlU19da9Dw/LehcQrfONbLrDX+syo
 T2dBYcwbdMNaAJH9br3j2VO7HBHdVectj4CDgvMPTZFfQhqaK45QDHiNs6zUnyZB64W98pqwC
 t7vNMwNv2h7T5k77+zFyoGhE+iR0gMk9JoGN3WqVrarqHnskqBUuwiQV7nVWtZ0QwqQj1nYjI
 IlXT27UCoNV9nVmGTfCfb4KzOneEXCHJL5tG4lfZBXeL6wnutQlKcYulXUvdhmNF4ybI58PGJ
 /xCKglQk9kCuF9/2unDy1MzZe0mEUKP40RvmWEm9uSFokjSUCJwzL5aX4Ewt7h6GeAS0MA3xI
 RUn78bhdVcY2Y7vu1MMLH6Da1y6yK+9JOSxvCieHZT1hgT5YWpajdWthRZ5y9QXnploNmFvyx
 sZSAZzSvIAOpYkZnzaJDvxjX3cNi3vs5ANBgVWeNiafoBXr/Qj3Fn4CFY3jm/AxG0VeFMLL3A
 OAWcifafCaaPoMkjaIXPleghSPG1q6riVInx590kRtPy1oP8Ln4zYEc3oqyUM+OS0PsndoyKb
 JNbApGpaFjz5jvVCGxcPnqdVwfiJ7A9sQQubrAO7THVPOTg+hk95hm1q4/GtyZKO0dsizMC/X
 7OEL9jVSKEjfsC94hnvRmHc3FLWybX/9LeOx32Q62BD1XvasveUXzgdqFS/OHbAJSsA4m5g7x
 YqzJZ/P5etjFZJAnPcGIAGWbCX2Fu5CvGMqUU8o2zFQ==
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

On 1/30/25 07:20, Ilias Apalodimas wrote:
> The ARM ARM on section 8.17.1 describes the cases where
> break-before-make is required when changing live page tables.
> Since we can use this function to tweak block and page permssions,
> where BBM is not required add an extra argument to the function.
>
> While at it add a function we can use to change the attributes of normal
> memory without breaking the pages tables first
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>   arch/arm/cpu/armv8/cache_v8.c           | 27 ++++++++++++++++++++++++-
>   arch/arm/cpu/armv8/fsl-layerscape/cpu.c | 10 ++++-----
>   arch/arm/include/asm/system.h           |  3 ++-
>   arch/arm/mach-snapdragon/board.c        |  2 +-
>   4 files changed, 34 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8=
.c
> index a4ca56c8ed42..60d0870013e8 100644
> --- a/arch/arm/cpu/armv8/cache_v8.c
> +++ b/arch/arm/cpu/armv8/cache_v8.c
> @@ -968,11 +968,14 @@ void mmu_set_region_dcache_behaviour(phys_addr_t s=
tart, size_t size,
>    * The procecess is break-before-make. The target region will be marke=
d as
>    * invalid during the process of changing.
>    */
> -void mmu_change_region_attr(phys_addr_t addr, size_t siz, u64 attrs)
> +void mmu_change_region_attr(phys_addr_t addr, size_t siz, u64 attrs, bo=
ol bbm)

The function description should be moved to the include or be completed
here.

>   {
>   	int level;
>   	u64 r, size, start;
>
> +	if (!bbm)
> +		goto skip_bbm;
> +
>   	start =3D addr;
>   	size =3D siz;
>   	/*
> @@ -997,6 +1000,7 @@ void mmu_change_region_attr(phys_addr_t addr, size_=
t siz, u64 attrs)
>   			   gd->arch.tlb_addr + gd->arch.tlb_size);
>   	__asm_invalidate_tlb_all();
>
> +skip_bbm:
>   	/*
>   	 * Loop through the address range until we find a page granule that f=
its
>   	 * our alignment constraints, then set it to the new cache attributes
> @@ -1020,6 +1024,27 @@ void mmu_change_region_attr(phys_addr_t addr, siz=
e_t siz, u64 attrs)
>   	__asm_invalidate_tlb_all();
>   }
>
> +void mmu_set_attrs(phys_addr_t addr, size_t size, int type)

Please, add a function description.

The function should either be static or added to an include file.

> +{
> +	u64 attrs =3D PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_INNER_SHARE | P=
TE_TYPE_VALID;
> +
> +	switch (type) {
> +	case 1:
> +	/* RO */
> +		attrs |=3D PTE_BLOCK_PXN | PTE_BLOCK_UXN | PTE_BLOCK_RO;
> +		break;
> +	case 2:
> +		/* RX */
> +		attrs |=3D PTE_BLOCK_RO;
> +		break;
> +	case 3:
> +		/* RW */
> +		attrs |=3D PTE_BLOCK_PXN | PTE_BLOCK_UXN;
> +	}
> +
> +	mmu_change_region_attr(addr, size, attrs, false);
> +}
> +
>   #else	/* !CONFIG_IS_ENABLED(SYS_DCACHE_OFF) */
>
>   /*
> diff --git a/arch/arm/cpu/armv8/fsl-layerscape/cpu.c b/arch/arm/cpu/armv=
8/fsl-layerscape/cpu.c
> index d2d3e346a36f..caf1dab05936 100644
> --- a/arch/arm/cpu/armv8/fsl-layerscape/cpu.c
> +++ b/arch/arm/cpu/armv8/fsl-layerscape/cpu.c
> @@ -1573,7 +1573,7 @@ void update_early_mmu_table(void)
>   					PTE_BLOCK_MEMTYPE(MT_NORMAL)	|
>   					PTE_BLOCK_OUTER_SHARE		|
>   					PTE_BLOCK_NS			|
> -					PTE_TYPE_VALID);
> +					PTE_TYPE_VALID, true);
>   	} else {
>   		mmu_change_region_attr(
>   					CFG_SYS_SDRAM_BASE,
> @@ -1581,7 +1581,7 @@ void update_early_mmu_table(void)
>   					PTE_BLOCK_MEMTYPE(MT_NORMAL)	|
>   					PTE_BLOCK_OUTER_SHARE		|
>   					PTE_BLOCK_NS			|
> -					PTE_TYPE_VALID);
> +					PTE_TYPE_VALID, true);
>   #ifdef CONFIG_SYS_DDR_BLOCK3_BASE
>   #ifndef CONFIG_SYS_DDR_BLOCK2_SIZE
>   #error "Missing CONFIG_SYS_DDR_BLOCK2_SIZE"
> @@ -1594,7 +1594,7 @@ void update_early_mmu_table(void)
>   					PTE_BLOCK_MEMTYPE(MT_NORMAL)	|
>   					PTE_BLOCK_OUTER_SHARE		|
>   					PTE_BLOCK_NS			|
> -					PTE_TYPE_VALID);
> +					PTE_TYPE_VALID, true);
>   			mmu_change_region_attr(
>   					CONFIG_SYS_DDR_BLOCK3_BASE,
>   					gd->ram_size -
> @@ -1603,7 +1603,7 @@ void update_early_mmu_table(void)
>   					PTE_BLOCK_MEMTYPE(MT_NORMAL)	|
>   					PTE_BLOCK_OUTER_SHARE		|
>   					PTE_BLOCK_NS			|
> -					PTE_TYPE_VALID);
> +					PTE_TYPE_VALID, true);
>   		} else
>   #endif
>   		{
> @@ -1614,7 +1614,7 @@ void update_early_mmu_table(void)
>   					PTE_BLOCK_MEMTYPE(MT_NORMAL)	|
>   					PTE_BLOCK_OUTER_SHARE		|
>   					PTE_BLOCK_NS			|
> -					PTE_TYPE_VALID);
> +					PTE_TYPE_VALID, true);
>   		}
>   	}
>   }
> diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system=
.h
> index dbf9ab43e280..0a8ca19e45e9 100644
> --- a/arch/arm/include/asm/system.h
> +++ b/arch/arm/include/asm/system.h
> @@ -287,8 +287,9 @@ void flush_l3_cache(void);
>    * @emerg: Also map the region in the emergency table
>    */
>   void mmu_map_region(phys_addr_t start, u64 size, bool emerg);
> -void mmu_change_region_attr(phys_addr_t start, size_t size, u64 attrs);
> +void mmu_change_region_attr(phys_addr_t start, size_t size, u64 attrs, =
bool bbm);

Please, add a function description.

Best regards

Heinrich

>
> +void mmu_set_attrs(phys_addr_t addr, size_t size, int type);
>   /*
>    * smc_call() - issue a secure monitor call
>    *
> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon=
/board.c
> index 2ef936aab757..13f4e8e640ef 100644
> --- a/arch/arm/mach-snapdragon/board.c
> +++ b/arch/arm/mach-snapdragon/board.c
> @@ -577,7 +577,7 @@ static void carve_out_reserved_memory(void)
>   		if (i =3D=3D count || start + size < res[i].start - SZ_2M) {
>   			debug("  0x%016llx - 0x%016llx: reserved\n",
>   			      start, start + size);
> -			mmu_change_region_attr(start, size, PTE_TYPE_FAULT);
> +			mmu_change_region_attr(start, size, PTE_TYPE_FAULT, true);
>   			/* If this is the final region then quit here before we index
>   			 * out of bounds...
>   			 */

