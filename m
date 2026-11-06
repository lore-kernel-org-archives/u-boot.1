Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429D2606A326
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 16:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wtG2hFmd;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=urEncruj
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 12D9781551;
	Fri,  6 Nov 2026 16:42:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xWhVO0jfNzwN; Fri,  6 Nov 2026 16:42:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 06C3E8138E
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793983364;
	b=MwpUnbCF6mmIkcmjhDvx/i20dH8V/IcAJEG1MD7FJiH5E65JfGMvScja6AvqoskPv0OE
	 0d+fCp3Iy/eECzQWKh1VK1ObuJKQMqNW9MeW5o0PZpUfHzjWx8K822OEmeSLgng/8/X5/
	 Jnf56umfVCvJrTfxVy9A1EdrKb0KMcGua7u/9XVd1VQz8RqxYxgU1ykylUfKNwuL2jI/n
	 VooMEZOm6QekoLLVuvbCUJLRnVjP1izYrlzHRMfWcxT0FllyJRSpgugsdrcXet7L/zIXM
	 NOlONOeRrD9cgR/YzHgdRx9CrNLqgxya8gvmsJwnCaHXO4P8NBa8mNuPrL6/kUu65nA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793983364;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:To:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=iCXvagcMFPMFHqQ4GkarqkM9ISr/W/drXe9Hj/CCfuE=;
	b=DfnI5HHPEd+IZb7S0McWRaE52myEaYduYqmW+6T1B+52oNhvO/CZSMyOsxc4PgxD/fUW
	 iO0nYBAlLRg1+40CEnV+SMDq03551cX3wOgIxPsR0Bukz+z5yl/ftkg9ESNDC2y2AkIRc
	 42obcZ/Fg3PmCvqqfoi73YEfGXAwrB01AlHeUF1hzQe2ZpZWrfgjVNPTDeNck9MGfg27W
	 D3KpmlUFwNKeVhNUvu6PPrnvUKpyfwzH+mmdS2wJyvz53dVl9a42ZEqMXyr1LRD7Z4uJg
	 x6+NhPgc7jrIvoNAhY0yk/P/YgAW4jb53X92iFzg5BB/7lOaNfQYPeV6IMqERld2dNA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793983364;
	bh=iCXvagcMFPMFHqQ4GkarqkM9ISr/W/drXe9Hj/CCfuE=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wtG2hFmdAspn5eC/9KFjVu4LcV3XLSv4igMbGgNlwJKACfogPCA0G2kPs1VXeMD+F
	 T6XwnNKWln7pUHxBpLEs82V814uwsx/o4NpE5kHrwi5fs2KYdE4FgqMPRLiyJ/JfB7
	 o8lcqL5HdrjrHW5xVoP73ZPieXTUc2FUiLkHWGuGac3qducI1I5PkOy8tOHy76P9nU
	 +mWGAVDxkEDM+EqTCALq0CAuOC6NRWwl1CLW5ezR1gzeEw6uwFQerDJ5CSG/s8VUrp
	 qfy9tlNOpNp20FbQgx6LF88oQSago3CK7OaYGrANXso490Tf9EtOAhpDYf5qRDcS7Z
	 4zabsGXhsqWJw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 06C3E8138E;
	Fri,  6 Nov 2026 16:42:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5ADD931F
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 16:42:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 412576073B
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 16:42:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LLgZdNyL5wqV for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 16:42:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E0596606BB
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::b"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:30::b;
 helo=mail-wr2-x0b.google.com; envelope-from=casey.connolly@linaro.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=urEncruj
Received: from mail-wr2-x0b.google.com (mail-wr2-x0b.google.com
 [IPv6:2a00:1450:4864:30::b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E0596606BB
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 16:42:41 +0000 (UTC)
Received: by mail-wr2-x0b.google.com with SMTP id
 ffacd0b85a97d-48df160d369so245929f8f.0
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 08:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793983359; x=1794588159;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=iCXvagcMFPMFHqQ4GkarqkM9ISr/W/drXe9Hj/CCfuE=;
 b=urEncrujdUX9qy4g3mEp4pUS+TnAGwV6d/L5BpS4jlLmxj3DPkIvsGdU/ts6vMl8ed
 UUlTydIpyi1CV0H94DFt4fzzH3L6SRpFxvCqZrBFYAs2pz030B3ReKuG3Lg8rHSEvl2a
 gY403szc+DsmPjvGs0ussKqVfpxkbcB8utH+CsZx/tjw/RAe80OmswOKgXs10wsaJBa9
 Qorb1NK6/Um4KVR8FjDq2MJ8z342AY0+X33AWNjeftBtmOE+aPY5GK/vU4fmWAhv9WQG
 Uctp4iuISW3h4SDgnkEnQL87daV9YDA8mulUZqDsYC+L5SH9lu3DoxySSDLRsMt5XxAA
 APLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793983359; x=1794588159;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=iCXvagcMFPMFHqQ4GkarqkM9ISr/W/drXe9Hj/CCfuE=;
 b=1BfSoM3WHKXzrcOcWGOaNC3CL25wvHNJ/UzXiK52hYNjyknuS+zCmNRcBcLJJazeM5
 9FzOPR9DakcTQRrSU2X6OlTYT1r0S1CvPkQarbtk3HI3hM+fDc4tmYcQ2eJFhFFnNYCf
 XlJP9MkuQCrKxdkUp3BfEQ/4pUTo+wKDcyDmIFhmaFdzquqPZ9KZm0PRBm+nYNXzff5f
 m1Z+/hj6+krE76WtZYSydI3yjqjpBVixinCT+eCIin5oBg+YeHJyweSm8yXYl63fedj+
 1exH4jKuKHbm28RVYJyMbK0vfD5p0y+xWqZYO4AEDUcv1FFeDKJW5lXXOz5AaTW3mT9B
 TUYg==
X-Forwarded-Encrypted: i=1;
 AL+hErHga7xD0OvmlxMp6dBVMe0N1qW2/yGdTvArruirVnKZXBCiOrFaWHOvDUb5vBlLM9Axj7yrJ8s=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9deYeNwdL0OMyB4MpSpsnwrhDjqJsQasEIf4tZ/hVg2qE5cOHD
 Xt9yaPjenpyobEhML5T9T5DeSwPMe4zwEV+1BCYXm4iRUqyRuhRvCCMbpOp7apt3tq0=
X-Gm-Gg: AYBFou2bPgoOPoiyJ9JuExWaKcjeebzmb5abaJ0jusG34jsKqT5lfe1KT3XsBbVbptF
 VL4bpAM66UWEphE5hv1ZOHV4w9KTSAwoh6r+Q2BPlankP9oty/IssmmoJsvq5r/NJNUwFGcswEu
 80YKFDd3W1vzF/P2m9rTmlCY0L4GzNJIxFamDqtpDOTWYUx3HeHlnsPrGaYVACKAmxtj7aYx+oG
 xuumu6X3vqtpu8ACsyZl1MAxGgHNvCzXpAcM41aQAc/BM4+Jj4wwzeHl7QbU7JWuX3nGt/3bxuC
 4dh5jfs5gZYsX1miWlprzN4NTGeq+Wz+CFzOMWvtxi6TS75MDy/xgMzM32dCsBFWKgZvHg+xd2j
 9A9nU7IJDhDSRCBPkk9X4f194PlvoRdhIxRfewUyazlbaokMElbRc9eKCxpkkbzzNurtzUzrwDG
 GnL1Tn3H0++MApiqMkUkrtbEHsTowH0VZ9S+Vm5TyPczzLE6+I/L7jEoALKPYA3Y/PUh+3sFqyt
 dI/1B50ZBJBnAhiBJ3Lrzj9lpqZktOehXb543mrM/AxNsfPOuq+dNgNALyhvThoElRNLpRhoSzf
 B++P7WkbqWupro88hWFChP6o7/B78mxFOEqOMJYIpUogGH/wdD2bgirIXDKYGvDZkkzT
X-Received: by 2002:a05:6000:310a:b0:48e:5444:a1d3 with SMTP id
 ffacd0b85a97d-4927e553b25mr5191301f8f.11.1793983359362; 
 Fri, 06 Nov 2026 08:42:39 -0800 (PST)
Received: from [192.168.1.37] (p5b29ebc8.dip0.t-ipconnect.de. [91.41.235.200])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d7bcfcbfsm4624763f8f.43.2026.11.06.08.42.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2026 08:42:38 -0800 (PST)
Message-ID: <7600fb5d-d245-438b-8e26-4a1261c47acd@linaro.org>
Date: Fri, 6 Nov 2026 17:42:37 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mach-snapdragon: skip reserved-memory regions outside
 DRAM
Content-Language: en-US
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>, trini@konsulko.com,
 ilias.apalodimas@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, Michael.Srba@seznam.cz, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
References: <20261105171752.2344459-1-aswin.murugan@oss.qualcomm.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20261105171752.2344459-1-aswin.murugan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Aswin,

On 05/11/2026 18:17, Aswin Murugan wrote:
> configure_reserved_memory() updates PTE attributes for every
> reserved-memory node, but regions located in inter-bank gaps were
> never mapped by build_mem_map(). Attempting to update such regions
> causes find_pte()/split_block() to fail.
> 
> Add region_in_dram() and skip reserved-memory regions that are not
> fully contained within a populated gd->dram[] bank before modifying
> PTE attributes. This preserves unmapped DRAM gaps and avoids MMU
> setup failures.

this still sounds like a bug in the MMU code to me. Does this diff fix
it? Not sure if the second hunk is needed

diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
index 1c1e33bec24f..7b717413c297 100644
--- a/arch/arm/cpu/armv8/cache_v8.c
+++ b/arch/arm/cpu/armv8/cache_v8.c
@@ -891,8 +891,13 @@ static u64 set_one_region(u64 start, u64 size, u64
attrs, bool flag, int level)
 	int levelshift = level2shift(level);
 	u64 levelsize = 1ULL << levelshift;
 	u64 *pte = find_pte(start, level);

+	/* Don't panic when unmapping a page which isn't mapped */
+	if (pte_type(pte) == PTE_TYPE_FAULT && attrs == PTE_TYPE_FAULT &&
+	    size < levelsize)
+		return size;
+
 	/* Can we can just modify the current level block PTE? */
 	if (is_aligned(start, size, levelsize)) {
 		if (flag) {
 			*pte &= ~PMD_ATTRMASK;
@@ -1033,8 +1038,12 @@ void mmu_change_region_attr(phys_addr_t addr,
size_t siz, u64 attrs)
 	flush_dcache_range(gd->arch.tlb_addr,
 			   gd->arch.tlb_addr + gd->arch.tlb_size);
 	__asm_invalidate_tlb_all();

+	/* If we were unmapping a region then we have nothing to make and can
return. */
+	if (attrs == PTE_TYPE_FAULT)
+		return;
+
 	mmu_change_region_attr_nobreak(addr, siz, attrs);
 }

 int pgprot_set_attrs(phys_addr_t addr, size_t size, enum pgprot_attrs perm)


> 
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
> Changes in v2:
> 
> - Drop the previous approach of mapping inter-bank DRAM gaps as
>   MT_DEVICE_NGNRNE regions to avoid reserved-memory MMU failures.
> - Fix configure_reserved_memory() by validating reserved-memory
>   regions against DRAM banks and skipping regions outside DRAM.
> 
> Link to v1: https://lore.kernel.org/u-boot/20260917091932.4150797-1-aswin.murugan@oss.qualcomm.com/
> ---
>  arch/arm/mach-snapdragon/mem_map.c | 32 ++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/arch/arm/mach-snapdragon/mem_map.c b/arch/arm/mach-snapdragon/mem_map.c
> index f3d2308b4bb..7a7e0c0160c 100644
> --- a/arch/arm/mach-snapdragon/mem_map.c
> +++ b/arch/arm/mach-snapdragon/mem_map.c
> @@ -83,6 +83,25 @@ static int fdt_cmp_res(const void *v1, const void *v2)
>  	return res1->start - res2->start;
>  }
>  
> +/*
> + * Returns true if [start, start+size) is fully contained within a single
> + * populated DRAM bank. Reserved-memory regions outside any real bank were
> + * never mapped by build_mem_map() and have no PTE for
> + * mmu_change_region_attr_nobreak() to rewrite.
> + */
> +static bool region_in_dram(phys_addr_t start, phys_addr_t size)
> +{
> +	int bank;
> +
> +	for (bank = 0; bank < CONFIG_NR_DRAM_BANKS && gd->dram[bank].size; bank++) {
> +		if (start >= gd->dram[bank].start &&
> +		    start + size <= gd->dram[bank].start + gd->dram[bank].size)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>  #define N_RESERVED_REGIONS 64
>  
>  /* Map and unmap reserved memory regions as appropriate.
> @@ -140,6 +159,19 @@ static void configure_reserved_memory(void)
>  			 */
>  			res[i].start = fdt32_to_cpu(ptr[1]);
>  			res[i].size = fdt32_to_cpu(ptr[3]);
> +
> +			/*
> +			 * Skip regions not backed by real DRAM (e.g. in an
> +			 * inter-bank gap). These addresses don't physically
> +			 * exist and were correctly left unmapped; updating
> +			 * their attributes would panic in find_pte()/split_block().
> +			 */
> +			if (!region_in_dram(res[i].start, res[i].size)) {
> +				log_debug("Skipping reserved region 0x%llx-0x%llx: no backing DRAM\n",
> +					  (u64)res[i].start, (u64)(res[i].start + res[i].size));
> +				continue;
> +			}
> +
>  			res[i].attrs = attrs;
>  			i++;
>  		}

-- 
// Casey (she/her)

