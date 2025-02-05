Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E686C02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 13:17:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E504A809A4;
	Wed,  5 Feb 2025 14:15:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EQkS8WfX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5643806DC; Wed,  5 Feb 2025 10:27:09 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD4FC805D7
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 10:27:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-aaecf50578eso147187766b.2
 for <u-boot@lists.denx.de>; Wed, 05 Feb 2025 01:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738747627; x=1739352427; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WstL9eTkj6JWp/n5N0Js46htEXFdeNsjX63fJwAqFTA=;
 b=EQkS8WfXHy9BsXsraBEXZZ2ZZIadCtd9aHIojBjbUJKTWEVdyi3kppTsrs1Sf7btPG
 7OUdffMnL5NfhfrkpdOxQnYHG5kU2gdWGSsG3La4C+ySB+6fiMvghyV7HY9lfAzOLk/V
 EF0nosVdaSJ4XNx0Zx3FmdAv63GyHCTvXGnziM2uS0tbB8J6+WLwuQ++kwb8SaTAxiut
 eHF1x2YZZclHUiabqR75eU8XK7q/DJcBQi9V8QQOFQMDxWi9pBFjPOaCU4YQTNHBs4t5
 ktmULOQ8ZnjXG4faICep5tAvWOhqCrlh+ZN7fk3WPbKvumA5pKIAOz11wu+ymmurFLiw
 Ic3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738747627; x=1739352427;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WstL9eTkj6JWp/n5N0Js46htEXFdeNsjX63fJwAqFTA=;
 b=gHA1LL0Tcw44rSuIHl2APGQLPdL1uTRqS+hRdLQ/TXi7tmzgx2bNhOP5xja7zMGNjn
 QJNByHGmd53w3DqJWqelew0G62PnbICoLBoQdQRJyZNb9rXKW1DnBrhkJiN287R3+/6J
 aR588S73ub4c6aXMKnBFGzjJdwo/U2zkHU8vX8oMJU5Kjepn0xeAAqjZZqUosYsyP/zD
 QmuhZawAVSzArdjssZ1dv7BzwQYJED9si15EWKeh5mQW89vcCExBhnEfz0xc0oR/bO3X
 qlnlnsa2yfMpLBx4bM+ielH6pSxlk6rxaevagctiIMvQqAyIQOgEiJ2pTScr5SsdFMRp
 wW7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMeFF5LdO7gwa3fryoFz4FtMX5QEkFOB0wG810oXTpzNMULFWQHHC5jw5C5lBZK0BpHmRvwkA=@lists.denx.de
X-Gm-Message-State: AOJu0YxQTWiKcFVgmzv4G5DLuCFoUCM8wU28wMGNMnoy9lEa9GIm1aWg
 BMTnK7ADx6UtN8HDacWUS7SZHO9KAuPYuMmW8gDVFWF7Zuz1Hn/qgK04BvUPIbY=
X-Gm-Gg: ASbGncuROYfYmQvc9g50gXcwOt5caFR5TIDZZdndPtBiFOtDH8aqby99oZ2aTJYzmiv
 Lc1JP+u8Bg2Jb6IStopjmGB1RiDTSpFglYUfmddr6G/om52jhLbyfDeiN+F0yH0QtE2CytAB95c
 eznjL9J1qmgLQ2ibftKRKjEMvfDmWzqY8F0X29YWskUAy13mVlp5PgKb6QuDeTaA8SKlan4fqoh
 KpUiimdVio5EZu+IpAFpNjTL5fwTwGq6dHxcO3QA8zDL0JTTR775u1PNGNLi9A7I4G89R3hIMjB
 mC3542QmiflLzQKuoh9gNk3F/vfj/XBqizceJks2TIpUqwBGH/Hhpg1096e+P25o23Oo
X-Google-Smtp-Source: AGHT+IE8jdoNKG9Hoo5aHjqn1Ti7uLa4zlNRu1+56SVdlzNqbpBkx/Mt+szhBiC5Jm6yJSj6aHx1qQ==
X-Received: by 2002:a17:907:1b14:b0:ab6:f688:dae5 with SMTP id
 a640c23a62f3a-ab75e2f1185mr213287166b.36.1738747627147; 
 Wed, 05 Feb 2025 01:27:07 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:ed29:9eea:a05:44fd?
 ([2a01:e0a:3cb:7bb0:ed29:9eea:a05:44fd])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab6e4a0000dsm1062036666b.89.2025.02.05.01.27.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Feb 2025 01:27:06 -0800 (PST)
Message-ID: <445a0c31-5a18-42e7-bb95-e380437d57f4@linaro.org>
Date: Wed, 5 Feb 2025 10:27:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/6] meminfo: add memory details for armv8
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, xypron.glpk@gmx.de,
 trini@konsulko.com
Cc: Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Marek Vasut <marex@denx.de>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Max Filippov <jcmvbkbc@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>,
 =?UTF-8?Q?Pierre-Cl=C3=A9ment_Tosi?= <ptosi@google.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, Peter Hoyes <Peter.Hoyes@arm.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, Sam Day <me@samcday.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Stefan Roese <sr@denx.de>,
 Jagan Teki <jagan@amarulasolutions.com>, Alex Shumsky
 <alexthreed@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Joshua Watt <jpewhacker@gmail.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Michal Simek <michal.simek@amd.com>, Christian Marangi
 <ansuelsmth@gmail.com>, Jonas Jelonek <jelonek.jonas@gmail.com>,
 uboot-snps-arc@synopsys.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250205071714.635518-1-ilias.apalodimas@linaro.org>
 <20250205071714.635518-2-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250205071714.635518-2-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 05 Feb 2025 14:15:26 +0100
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



On 2/5/25 08:16, Ilias Apalodimas wrote:
> Upcoming patches are mapping memory with RO, RW^X etc permsissions.
> Fix the meminfo command to display them properly
> 
> Acked-by: Jerome Forissier <jerome.forissier@linaro.org>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  arch/arm/cpu/armv8/cache_v8.c    | 26 +++++++++++++++++++++++---
>  arch/arm/include/asm/armv8/mmu.h |  2 ++
>  cmd/meminfo.c                    |  5 +++++
>  3 files changed, 30 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
> index 5d6953ffedd1..c4b3da4a8da7 100644
> --- a/arch/arm/cpu/armv8/cache_v8.c
> +++ b/arch/arm/cpu/armv8/cache_v8.c
> @@ -421,7 +421,7 @@ static int count_ranges(void)
>  	return count;
>  }
>  
> -#define ALL_ATTRS (3 << 8 | PMD_ATTRINDX_MASK)
> +#define ALL_ATTRS (3 << 8 | PMD_ATTRMASK)
>  #define PTE_IS_TABLE(pte, level) (pte_type(&(pte)) == PTE_TYPE_TABLE && (level) < 3)
>  
>  enum walker_state {
> @@ -568,6 +568,20 @@ static void pretty_print_table_attrs(u64 pte)
>  static void pretty_print_block_attrs(u64 pte)
>  {
>  	u64 attrs = pte & PMD_ATTRINDX_MASK;
> +	u64 perm_attrs = pte & PMD_ATTRMASK;
> +	char mem_attrs[16] = { 0 };

11 is enough is seems?

> +	int cnt = 0;
> +
> +	if (perm_attrs & PTE_BLOCK_PXN)
> +		cnt += snprintf(mem_attrs + cnt, sizeof(mem_attrs) - cnt, "PXN ");
> +	if (perm_attrs & PTE_BLOCK_UXN)
> +		cnt += snprintf(mem_attrs + cnt, sizeof(mem_attrs) - cnt, "UXN ");
> +	if (perm_attrs & PTE_BLOCK_RO)
> +		cnt += snprintf(mem_attrs + cnt, sizeof(mem_attrs) - cnt, "RO");
> +	if (!mem_attrs[0])
> +		snprintf(mem_attrs, sizeof(mem_attrs), "RWX ");
> +
> +	printf(" | %-10s", mem_attrs);
>  
>  	switch (attrs) {
>  	case PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE):
> @@ -613,6 +627,7 @@ static void print_pte(u64 pte, int level)
>  {
>  	if (PTE_IS_TABLE(pte, level)) {
>  		printf(" %-5s", "Table");
> +		printf(" %-12s", "|");
>  		pretty_print_table_attrs(pte);
>  	} else {
>  		pretty_print_pte_type(pte);
> @@ -642,9 +657,9 @@ static bool pagetable_print_entry(u64 start_attrs, u64 end, int va_bits, int lev
>  
>  	printf("%*s", indent * 2, "");
>  	if (PTE_IS_TABLE(start_attrs, level))
> -		printf("[%#011llx]%14s", _addr, "");
> +		printf("[%#016llx]%19s", _addr, "");
>  	else
> -		printf("[%#011llx - %#011llx]", _addr, end);
> +		printf("[%#016llx - %#016llx]", _addr, end);
>  
>  	printf("%*s | ", (3 - level) * 2, "");
>  	print_pte(start_attrs, level);
> @@ -1112,3 +1127,8 @@ void __weak enable_caches(void)
>  	icache_enable();
>  	dcache_enable();
>  }
> +
> +void arch_dump_mem_attrs(void)
> +{
> +	dump_pagetable(gd->arch.tlb_addr, get_tcr(NULL, NULL));
> +}
> diff --git a/arch/arm/include/asm/armv8/mmu.h b/arch/arm/include/asm/armv8/mmu.h
> index 0ab681c893d3..6af8cd111a44 100644
> --- a/arch/arm/include/asm/armv8/mmu.h
> +++ b/arch/arm/include/asm/armv8/mmu.h
> @@ -66,6 +66,7 @@
>  #define PTE_BLOCK_NG		(1 << 11)
>  #define PTE_BLOCK_PXN		(UL(1) << 53)
>  #define PTE_BLOCK_UXN		(UL(1) << 54)
> +#define PTE_BLOCK_RO            (UL(1) << 7)
>  
>  /*
>   * AttrIndx[2:0]
> @@ -75,6 +76,7 @@
>  #define PMD_ATTRMASK		(PTE_BLOCK_PXN		| \
>  				 PTE_BLOCK_UXN		| \
>  				 PMD_ATTRINDX_MASK	| \
> +				 PTE_BLOCK_RO		| \
>  				 PTE_TYPE_VALID)
>  
>  /*
> diff --git a/cmd/meminfo.c b/cmd/meminfo.c
> index 5e83d61c2dd3..3915e2bbb268 100644
> --- a/cmd/meminfo.c
> +++ b/cmd/meminfo.c
> @@ -15,6 +15,10 @@
>  
>  DECLARE_GLOBAL_DATA_PTR;
>  
> +void __weak arch_dump_mem_attrs(void)
> +{
> +}
> +
>  static void print_region(const char *name, ulong base, ulong size, ulong *uptop)
>  {
>  	ulong end = base + size;
> @@ -54,6 +58,7 @@ static int do_meminfo(struct cmd_tbl *cmdtp, int flag, int argc,
>  
>  	puts("DRAM:  ");
>  	print_size(gd->ram_size, "\n");
> +	arch_dump_mem_attrs();
>  
>  	if (!IS_ENABLED(CONFIG_CMD_MEMINFO_MAP))
>  		return 0;
