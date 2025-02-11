Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28648C0219B
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 22:58:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DCB1807C0;
	Tue, 11 Feb 2025 23:58:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="B5MYN0ev";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6B6F80BAD; Tue, 11 Feb 2025 22:08:12 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BE22809D0
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 22:08:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-438a3216fc2so60174605e9.1
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 13:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739308090; x=1739912890; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Q6WpGvu60VMNBcnvkiCsOU6t2SiYsa20z38CT7RN0Bw=;
 b=B5MYN0eveEBFclavusNuMYcfb0EKPdVoKkbha9K+QOyRG7CC+Dg8stz8JVZ4n0qvkU
 18Um3QlTLpALUeuo32RNYNrq6I2bsJ4zZM8RBbn6cxbtHxb93w87y8ZGbwGEv0wctqQ+
 L6ikUllbsvSLoQ1vchhboYN7Qno9Arb1N2NWVnG9HKX0M1C6I7KIps0ni1Y22BELtXpC
 hhHUghrrUW9BT2iFm1V1EH1IqJVOHbYkiUGXYnXOBUIUQb8Oq1myjMiJIFGnXA3i4/mB
 LaMelIuU1zYh9xRa136ud52tR96NuHuR76nwaSOhMcqBKTIaQoHYxvqh0N9TnK6LHX6o
 dejw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739308090; x=1739912890;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q6WpGvu60VMNBcnvkiCsOU6t2SiYsa20z38CT7RN0Bw=;
 b=pbBl/Kt/ifHEI0o4DViqCU3Thvv/MWBynLP822PQBQR1oWV58EJRN3599qAp+GlrDU
 FXPXDbCU+V+UXO9cTpHsj/7HileuhZkgLCpSWInShirt3agptZS8M9XZGYu+HCo5n9dt
 dXaIJ7cul6e+uBr2js3EE5WNOa0sd7gROBkc2z0jOOdYmnrxW1T5uIEUSMn8akfIn4sB
 aOAGkFrMaMLUP+7Q6d0Gao9JMLtsEpHqEs0pNpiO/ZqOLNZNtDbGADpA4vBlXP4SeDmU
 zAcjX9VBajVs5L8AwlKuSmHqn+IRBJsk2PpNosHFwn4BnVbdVIs+diV2ZiRO62NRi9F7
 OFYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkeuWLQUcFbmLOqHf6JFxwaqpdVkfOpODYb5iva95FFjRCB8TYgQ5X7SUrTxpG1Jfr9oVzt9Q=@lists.denx.de
X-Gm-Message-State: AOJu0Yw23B+5Cgc94jshvS9lLFA77AsgLQAU1IXU+JzvOmveEpEJIY3s
 JbJe7NxF/iTF/3LtgMid2hHmTjGHVVrdMb3dCGtcEM2PxUW3w7ikfqufFV1A9T0=
X-Gm-Gg: ASbGnctIcjM1zYVwUa4mEszPI4/Phs/IJffzaJ64zFsdK2QZTnI+9NH+FGD1foR8eYV
 tKTMXyvO1FODPwW/JEKn6YLT+5dofi+p90Zw2ptCXd+mmBv5FYPJ+rcUreUCyEBJ/zenZvXMxil
 FHzdXWga7cqhLf0ewwQJ3hjMHrr1CaJevUyQyqBeN0EAGOfDZbt8Irb906T8sdzvsqWg30kgxO9
 zaqJp/RV6+nrS+9FCD46xH0If4d7KWC0s0MBwqM6BohFSxzI+AK8gsE4nYaKgpsYpwmqr8CtgFM
 DeyRAny2WFdF3qk1buPVyu+qLKibfM7Lqb80NCX0DgGkOKTftYLqTtiIEeJXiLgyyeitjg==
X-Google-Smtp-Source: AGHT+IFAhRqtHq2o4Rfr1QTDAceYm/LG8tsiToSQDMCAS0Rd0k8/JdNdlI/4dXMtpSdT7Ha4j4hJtQ==
X-Received: by 2002:a05:600c:870d:b0:439:34d3:63cd with SMTP id
 5b1f17b1804b1-4395816f381mr6866505e9.9.1739308090036; 
 Tue, 11 Feb 2025 13:08:10 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:1d11:ab01:c8c:8100:5ea8:e20d?
 ([2a0a:ef40:1d11:ab01:c8c:8100:5ea8:e20d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dd4342502sm10189627f8f.26.2025.02.11.13.08.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Feb 2025 13:08:09 -0800 (PST)
Message-ID: <95fb9f26-7ced-4722-aabd-5851f48fe837@linaro.org>
Date: Tue, 11 Feb 2025 21:08:06 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/6] meminfo: add memory details for armv8
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, xypron.glpk@gmx.de,
 trini@konsulko.com
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
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
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20250205071714.635518-2-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 11 Feb 2025 23:58:52 +0100
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



On 2/5/25 07:16, Ilias Apalodimas wrote:
> Upcoming patches are mapping memory with RO, RW^X etc permsissions.
> Fix the meminfo command to display them properly
> 
> Acked-by: Jerome Forissier <jerome.forissier@linaro.org>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   arch/arm/cpu/armv8/cache_v8.c    | 26 +++++++++++++++++++++++---
>   arch/arm/include/asm/armv8/mmu.h |  2 ++
>   cmd/meminfo.c                    |  5 +++++
>   3 files changed, 30 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
> index 5d6953ffedd1..c4b3da4a8da7 100644
> --- a/arch/arm/cpu/armv8/cache_v8.c
> +++ b/arch/arm/cpu/armv8/cache_v8.c
> @@ -421,7 +421,7 @@ static int count_ranges(void)
>   	return count;
>   }
>   
> -#define ALL_ATTRS (3 << 8 | PMD_ATTRINDX_MASK)
> +#define ALL_ATTRS (3 << 8 | PMD_ATTRMASK)
>   #define PTE_IS_TABLE(pte, level) (pte_type(&(pte)) == PTE_TYPE_TABLE && (level) < 3)
>   
>   enum walker_state {
> @@ -568,6 +568,20 @@ static void pretty_print_table_attrs(u64 pte)
>   static void pretty_print_block_attrs(u64 pte)
>   {
>   	u64 attrs = pte & PMD_ATTRINDX_MASK;
> +	u64 perm_attrs = pte & PMD_ATTRMASK;
> +	char mem_attrs[16] = { 0 };
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
>   	switch (attrs) {
>   	case PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE):
> @@ -613,6 +627,7 @@ static void print_pte(u64 pte, int level)
>   {
>   	if (PTE_IS_TABLE(pte, level)) {
>   		printf(" %-5s", "Table");
> +		printf(" %-12s", "|");
>   		pretty_print_table_attrs(pte);
>   	} else {
>   		pretty_print_pte_type(pte);
> @@ -642,9 +657,9 @@ static bool pagetable_print_entry(u64 start_attrs, u64 end, int va_bits, int lev
>   
>   	printf("%*s", indent * 2, "");
>   	if (PTE_IS_TABLE(start_attrs, level))
> -		printf("[%#011llx]%14s", _addr, "");
> +		printf("[%#016llx]%19s", _addr, "");
>   	else
> -		printf("[%#011llx - %#011llx]", _addr, end);
> +		printf("[%#016llx - %#016llx]", _addr, end);
>   
>   	printf("%*s | ", (3 - level) * 2, "");
>   	print_pte(start_attrs, level);
> @@ -1112,3 +1127,8 @@ void __weak enable_caches(void)
>   	icache_enable();
>   	dcache_enable();
>   }
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
>   #define PTE_BLOCK_NG		(1 << 11)
>   #define PTE_BLOCK_PXN		(UL(1) << 53)
>   #define PTE_BLOCK_UXN		(UL(1) << 54)
> +#define PTE_BLOCK_RO            (UL(1) << 7)
>   
>   /*
>    * AttrIndx[2:0]
> @@ -75,6 +76,7 @@
>   #define PMD_ATTRMASK		(PTE_BLOCK_PXN		| \
>   				 PTE_BLOCK_UXN		| \
>   				 PMD_ATTRINDX_MASK	| \
> +				 PTE_BLOCK_RO		| \
>   				 PTE_TYPE_VALID)
>   
>   /*
> diff --git a/cmd/meminfo.c b/cmd/meminfo.c
> index 5e83d61c2dd3..3915e2bbb268 100644
> --- a/cmd/meminfo.c
> +++ b/cmd/meminfo.c
> @@ -15,6 +15,10 @@
>   
>   DECLARE_GLOBAL_DATA_PTR;
>   
> +void __weak arch_dump_mem_attrs(void)
> +{
> +}
> +
>   static void print_region(const char *name, ulong base, ulong size, ulong *uptop)
>   {
>   	ulong end = base + size;
> @@ -54,6 +58,7 @@ static int do_meminfo(struct cmd_tbl *cmdtp, int flag, int argc,
>   
>   	puts("DRAM:  ");
>   	print_size(gd->ram_size, "\n");
> +	arch_dump_mem_attrs();
>   
>   	if (!IS_ENABLED(CONFIG_CMD_MEMINFO_MAP))
>   		return 0;

-- 
Caleb (they/them)

