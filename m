Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5806FCD3427
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 12:39:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32750848D8;
	Tue,  5 May 2026 14:39:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EiU0pfam";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F49E848CE; Tue,  5 May 2026 14:39:41 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C70E3848CE
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 14:39:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-43d734223e4so3040153f8f.0
 for <u-boot@lists.denx.de>; Tue, 05 May 2026 05:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777984778; x=1778589578; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5QhY9lOZPF0Dmzq/Mo2EHYzJlujFDmhpjD9P1RtbAs0=;
 b=EiU0pfamWv/DHWB/51Cn9Vj69sN0MzAexPchbRHrWrEYgV8b6T5BJPvfOtnmDJABZo
 1WeYmGopDm8yXmuqZvEuCYaYLXRyybLMnm4Zj7H9vHGBcgNiEtXGuz4XWTLYjTIBYsBK
 MJluyoOhIBlBUM7Sq6umqwl4IFG6OBEtVNQcvGFrGWCSbAvK3ykbhQ7CeJSICdl2dfgE
 BLsPZ0wbur/6vEZwau3It7Zt7v95qaUKJUTHZ1NteawVcvGtR06T442Q8lHm2VcAsAa1
 TnPnB+KrEdToLp62BSTsAMCSG9HKKpPntobwSZhFgegF85lbFxb9XtJCL+GCw9XdXjN/
 UFLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777984778; x=1778589578;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5QhY9lOZPF0Dmzq/Mo2EHYzJlujFDmhpjD9P1RtbAs0=;
 b=Tl8nc+xBgb6dC7sfgP5JBqjveZhyRZO4mytnnc9HcO1XQfxftSOt7HrGe57JFWWXhD
 HmG7K12qY+FqH/UqfGZNSuQC0vcYZ1ggv9om872YUgnrpFAfxvMQjmkjI3S+NYFvCrDZ
 SDA/Py/WAQomO/VFaM9RiwD4DcmYdHvrbgvaJNLRP/jJuAND8Vgqu5UwGHk+rwoNV31Q
 48T+E/xjIMIuGhqg7atPoHl5raWNxiOYIuRSV3aF5nw028sRfBXaP+WBma9ttsXGsHWu
 dntc6mNNOa5sQ3G/p2lN1HKe+Rek+gNf8wSWMDYZG/WhOYkjOdEkmfX058/IRWNaf8SU
 +Epw==
X-Gm-Message-State: AOJu0YxKrMmg9MV3uLLHdAikO79eBm8v24Oq087d1+jdJEimoBOfkQKo
 +UlnnJj5CkC8Y7CU5Ouy1Hc7Y5BoZmTHUMUKKo4mUkIR6F/U42qbSHCQeQpohxDx6nE=
X-Gm-Gg: AeBDietJLEYPSF3r+j9mPAgPaHQj4VSbpxTfQ/Y4HLRdrQ4K8fBGjX8V4mja9TayzA9
 IGXtPu6yYy8Cmox6oX17zCDnJ6ASFm0EYznASrm+g52v0rliF1e3MakFDSdFjAETJtTrtUuHIac
 y/K3aXcIgS6zI3vwnynXfmrh9gxvSAeKW1WWCtUmzey6pAvWd49pwOWTF5Xp/1kTnArtYpUAgMH
 ZlMcKQnoB0Y4PdQ+MMO1/ok2DB+9OS67zvYyF6lH6NEexeBFEvdGZw6Q7aGUxdKKvmCpSfi0TmE
 xMtYiO449AD/pQ3ntxm+zmwIaCDovnvhx4yd3dgZ7VDMlYsGLRjOnuqtxCsj3Fsj2+StV8xqSbX
 QISbhBLjTreCBgXxkb4kZXBZuJxJfguVkf5QpuWaGSD8aoWkYWAMggDESZNjMF/5eg0Ts9RpIHs
 IqWGZKJumIrWQa0hBozHwi6CHrES8s0vG6E9V8VNQ+M0+PbjXJ+08lj5fAi6jESIpgsTPYC/34N
 VWUWhf9gLvhds8=
X-Received: by 2002:a05:6000:4301:b0:44b:bf8d:3092 with SMTP id
 ffacd0b85a97d-44fd86a521dmr6287019f8f.0.1777984778009; 
 Tue, 05 May 2026 05:39:38 -0700 (PDT)
Received: from [192.168.1.36] (p4fc3dd86.dip0.t-ipconnect.de. [79.195.221.134])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45055d36dacsm4163469f8f.32.2026.05.05.05.39.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2026 05:39:37 -0700 (PDT)
Message-ID: <9870f8f4-a719-4ea5-93b7-5442d499c19f@linaro.org>
Date: Tue, 5 May 2026 14:39:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/15] mach-snapdragon: fix reserved memory carveout
Content-Language: en-US
To: Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alice Guo <alice.guo@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Raymond Mao
 <raymond.mao@riscstar.com>, Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Heiko Schocher <hs@nabladev.com>,
 Michal Simek <michal.simek@amd.com>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
References: <20260504-b4-modernise-smem-v2-0-c01ec2ff3886@linaro.org>
 <20260504-b4-modernise-smem-v2-5-c01ec2ff3886@linaro.org>
 <afnhrel-ik0jOPD1@sumit-xelite>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <afnhrel-ik0jOPD1@sumit-xelite>
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



On 05/05/2026 14:25, Sumit Garg wrote:
> On Mon, May 04, 2026 at 08:57:33PM +0200, Casey Connolly wrote:
>> The memory carveout logic was fairly limited and had a few issues,
>> rework it and teach it not to unmap regions that have a compatible
>> property (since they may be used in U-Boot) or that don't have the
>> no-map property.
>>
>> The carveout process adds ~100ms to the boot time depending on the
>> platform.
>>
>> This prepares us for using SMEM as a source of truth and improving
>> support for U-boot as a first stage bootloader since SMEMs memory map
>> doesn't already carve out some regions like ABL does.
>>
>> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
>> ---
>>  arch/arm/mach-snapdragon/board.c | 86 +++++++++++++++++++++++++---------------
>>  1 file changed, 53 insertions(+), 33 deletions(-)
>>
>> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
>> index 829a0109ac78..e12d3d00caa4 100644
>> --- a/arch/arm/mach-snapdragon/board.c
>> +++ b/arch/arm/mach-snapdragon/board.c
>> @@ -622,27 +622,36 @@ u64 get_page_table_size(void)
>>  {
>>  	return SZ_1M;
>>  }
>>  
>> +struct mem_resource_attrs {
>> +	fdt_addr_t start;
>> +	fdt_addr_t size;
>> +	u64 attrs;
>> +};
> 
> Let's move the struct declaration towards the top.

it's only used by this one function, it felt easier to keep things
readable this way. Probably we'll move this stuff to its own file at
some point.

> 
>> +
>>  static int fdt_cmp_res(const void *v1, const void *v2)
> 
> This API should now be renamed as mem_cmp_resources(), no?

yeah

> 
>>  {
>> -	const struct fdt_resource *res1 = v1, *res2 = v2;
>> +	const struct mem_resource_attrs *res1 = v1, *res2 = v2;
>>  
>>  	return res1->start - res2->start;
>>  }
>>  
>> -#define N_RESERVED_REGIONS 32
>> +#define N_RESERVED_REGIONS 64
>>  
>> -/* Mark all no-map regions as PTE_TYPE_FAULT to prevent speculative access.
>> +/* Map and unmap reserved memory regions as appropriate.
>> + * Mark all no-map regions as PTE_TYPE_FAULT to prevent speculative access.
>>   * On some platforms this is enough to trigger a security violation and trap
>>   * to EL3.
>> + * Regions that may be accessed by drivers get mapped explicitly.
>>   */
>> -static void carve_out_reserved_memory(void)
>> +static void configure_reserved_memory(void)
>>  {
>> -	static struct fdt_resource res[N_RESERVED_REGIONS] = { 0 };
>> +	static struct mem_resource_attrs res[N_RESERVED_REGIONS] = { 0 };
>>  	int parent, rmem, count, i = 0;
>>  	phys_addr_t start;
>>  	size_t size;
>> +	u64 attrs;
>>  
>>  	/* Some reserved nodes must be carved out, as the cache-prefetcher may otherwise
>>  	 * attempt to access them, causing a security exception.
>>  	 */
>> @@ -651,14 +660,19 @@ static void carve_out_reserved_memory(void)
>>  		log_err("No reserved memory regions found\n");
>>  		return;
>>  	}
>>  
>> -	/* Collect the reserved memory regions */
>> +	/* Collect the reserved memory regions and appropriate attrs */
>>  	fdt_for_each_subnode(rmem, gd->fdt_blob, parent) {
>>  		const fdt32_t *ptr;
>> -		int len;
>> +		attrs = PTE_TYPE_FAULT;
>> +		/* If the no-map property isn't set then the region is valid */
>>  		if (!fdt_getprop(gd->fdt_blob, rmem, "no-map", NULL))
>> -			continue;
>> +			attrs = PTE_TYPE_VALID | PTE_BLOCK_MEMTYPE(MT_NORMAL);
>> +		/* If the compatible property is set then this region may be accessed by drivers and should
>> +		 * be marked valid too. */
>> +		if (fdt_getprop(gd->fdt_blob, rmem, "compatible", NULL))
>> +			attrs = PTE_TYPE_VALID | PTE_BLOCK_MEMTYPE(MT_NORMAL);
>>  
>>  		if (i == N_RESERVED_REGIONS) {
>>  			log_err("Too many reserved regions!\n");
>>  			break;
>> @@ -667,50 +681,55 @@ static void carve_out_reserved_memory(void)
>>  		/* Read the address and size out from the reg property. Doing this "properly" with
>>  		 * fdt_get_resource() takes ~70ms on SDM845, but open-coding the happy path here
>>  		 * takes <1ms... Oh the woes of no dcache.
>>  		 */
>> -		ptr = fdt_getprop(gd->fdt_blob, rmem, "reg", &len);
>> +		ptr = fdt_getprop(gd->fdt_blob, rmem, "reg", NULL);
>>  		if (ptr) {
>>  			/* Qualcomm devices use #address/size-cells = <2> but all reserved regions are within
>>  			 * the 32-bit address space. So we can cheat here for speed.
>>  			 */
>>  			res[i].start = fdt32_to_cpu(ptr[1]);
>> -			res[i].end = res[i].start + fdt32_to_cpu(ptr[3]);
>> +			res[i].size = fdt32_to_cpu(ptr[3]);
>> +			res[i].attrs = attrs;
>>  			i++;
>>  		}
>>  	}
>>  
>>  	/* Sort the reserved memory regions by address */
>>  	count = i;
>> -	qsort(res, count, sizeof(struct fdt_resource), fdt_cmp_res);
>> +	qsort(res, count, sizeof(res[0]), fdt_cmp_res);
>> +	debug("Mapping %d regions!\n", count);
>>  
>>  	/* Now set the right attributes for them. Often a lot of the regions are tightly packed together
>> -	 * so we can optimise the number of calls to mmu_change_region_attr() by combining adjacent
>> +	 * so we can optimise the number of calls to mmu_change_region_attr_nobreak() by combining adjacent
>>  	 * regions.
>>  	 */
>> -	start = ALIGN_DOWN(res[0].start, SZ_2M);
>> -	size = ALIGN(res[0].end - start, SZ_2M);
>> +	start = res[0].start;
>> +	size = res[0].size;
>> +	attrs = res[0].attrs;
>> +	/* For each region after the first one, either increase the `size` to eventually be mapped or
>> +	 * map the region we have and start a new one, this allows us to reduce the number of calls to
>> +	 * mmu_map_region(). The loop is therefore "lagging" behind by one iteration. */
>>  	for (i = 1; i <= count; i++) {
>> -		/* We ideally want to 2M align everything for more efficient pagetables, but we must avoid
>> -		 * overwriting reserved memory regions which shouldn't be mapped as FAULT (like those with
>> -		 * compatible properties).
>> -		 * If within 2M of the previous region, bump the size to include this region. Otherwise
>> -		 * start a new region.
>> -		 */
>> -		if (i == count || start + size < res[i].start - SZ_2M) {
>> -			debug("  0x%016llx - 0x%016llx: reserved\n",
>> -			      start, start + size);
>> -			mmu_change_region_attr(start, size, PTE_TYPE_FAULT);
>> -			/* If this is the final region then quit here before we index
>> -			 * out of bounds...
>> -			 */
>> +		/* If i == count we are done, just map the last region. If the last region is
>> +		 * too far away or the attrs don't match then map the meta-region we have and
>> +		 * start a new one. */
>> +		if (i == count || start + size < res[i].start - SZ_8K || attrs != res[i].attrs) {
> 
> I suppose this SZ_8K instead of SZ_2M is intentional here? It works now
> due to page table optimization I guess?

I realised there was a possibility for incorrectly mapping stuff with
2M. Probably not with the logic as it is but e.g. if you don't
explicitly map reserved regions that need to be mapped then they can get
unmapped here.

> 
> -Sumit
> 
>> +			debug("  0x%016llx - 0x%016llx: %s\n",
>> +				start, start + size, attrs == PTE_TYPE_FAULT ? "FAULT" : "VALID");
>> +			/* No need to break-before-make since dcache is disabled */
>> +			mmu_change_region_attr_nobreak(start, size, attrs);
>> +			/* We have now mapped all the regions */
>>  			if (i == count)
>>  				break;
>> -			start = ALIGN_DOWN(res[i].start, SZ_2M);
>> -			size = ALIGN(res[i].end - start, SZ_2M);
>> +			/* Start a new meta-region */
>> +			start = res[i].start;
>> +			size = res[i].size;
>> +			attrs = res[i].attrs;
>>  		} else {
>> -			/* Bump size if this region is immediately after the previous one */
>> -			size = ALIGN(res[i].end - start, SZ_2M);
>> +			/* This region is next to (<8K) the previous one so combine them.
>> +			 * Accounting for any small (<8K) gap. */
>> +			size = (res[i].start - start) + res[i].size;
>>  		}
>>  	}
>>  }
>>  
>> @@ -744,13 +763,14 @@ void enable_caches(void)
>>  	gd->arch.tlb_emerg = gd->arch.tlb_addr;
>>  	gd->arch.tlb_addr = tlb_addr;
>>  	gd->arch.tlb_size = tlb_size;
>>  
>> -	/* We do the carveouts only for QCS404, for now. */
>> +	/* On some boards speculative access may trigger a NOC or XPU violation so explicitly mark reserved
>> +	 * regions as inacessible (PTE_TYPE_FAULT) */
>>  	if (fdt_node_check_compatible(gd->fdt_blob, 0, "qcom,qcs404") == 0) {
>>  		carveout_start = get_timer(0);
>>  		/* Takes ~20-50ms on SDM845 */
>> -		carve_out_reserved_memory();
>> +		configure_reserved_memory();
>>  		debug("carveout time: %lums\n", get_timer(carveout_start));
>>  	}
>>  	dcache_enable();
>>  }
>>
>> -- 
>> 2.53.0
>>

-- 
// Casey (she/her)

