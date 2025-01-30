Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C645C0218A
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 09:09:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4910E80C85;
	Thu, 30 Jan 2025 10:09:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="La7HJrYx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19BF881F69; Thu, 30 Jan 2025 10:09:20 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D6AB80B9B
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 10:09:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-38be3bfb045so1179052f8f.0
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 01:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738228157; x=1738832957; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0K2xhb1qasTlBn2GJS18mi4u2WoHQHoCVEkLXarfz/c=;
 b=La7HJrYxl5XGK7DO2qe0JOY5lBpOGiUrI97CU49COyXPPNwykCUwo4xVI9//3W3ncZ
 Vvs+m/c17twUrjPjTGuvyamWlnlGqLewqmVOz1xVD7DitAqKoFm2TnZ5+4PTFK4wM3AF
 sLig2JSifEx07vuWT++eijNaH6CAZPukUm0mEfZXvsMyOFaS4GKBIKI0uiD871ICYAym
 RXnRwqD+BHTlSxjw+61e6uJxdnETuxoy8bp5xh/rO4Bh/3//IKmK4alOwrzkRjo0H4B1
 5lY46iNaY+tM1+31nKU657IYPjgkBqBeLxkGxwf1mOxecWcDkn6LCa/ZW80BBbY1gjtz
 eIbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738228157; x=1738832957;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0K2xhb1qasTlBn2GJS18mi4u2WoHQHoCVEkLXarfz/c=;
 b=B1HQMgJ/0EEGBqLIHK9qECFRW2elbFdC1/16YlCdxKtI0pNhzV8AwRbgoWuKhtDF+3
 MccQ0yBl3ljFJh27ADUc5QL6Df2b3ayN1J8hYxKvKKwoDGijnVE+oR/8H5hrdHpdl3nv
 oLL5Jb/R2rJyVatHjnlb42Yz4NGuSv10NoSuEM5g6aupfqls68VJlC4D/4CtkvHvjYhS
 0v+oO9GCEZf1DTlyqqQzGNaGjUvI2m4U1NeUkq0TnCdfJV1XY7LN3nB8Mr0XY0g15E9Q
 ue3D9McminTR037/FaBuwCJouXlRxr4+RGU+5YxvavJYUwpziue43lx2ftxTll6f2saG
 g1uw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxrdloTxDz3AWZnzvs3Q4Bd99+CqAMS5MVT0nuupQxunBjVRW2RP9b2vO5lS8k9LL27cAWARc=@lists.denx.de
X-Gm-Message-State: AOJu0Yy3Wi6E3HZLAVoNQO7zmmdWdjmCOequNSbxD9zp3+uISpAyL3kg
 dxaX5pt6UuqFlwHfw1edbcH7CGZYk/xSDI/OfKsVg07dSw1UhAcF6zghRCYis0k=
X-Gm-Gg: ASbGncsySpKmglWibJtRn95Tskm8aIcdjule/16ziDdBRYckQRh/2vAwh/0qNSjNu3J
 TeuI+utAWriNeC53+XFvMu9/lR3b0mv24JYbOf2YMBiRyT+DK14EP29TWfG/j52JUC/a0Y0lYsg
 h4pWerv5CAwD7qG3AbLQjBaTIILEwKcchEMTxtPyaLn2+I2CrXWaiUuiHXtc+S6Ol1Zoi3DOH5N
 5z2o+UTgBWcJvJaY1J05EDGeRnc70c9Qn906Ei5SiTgz8+6ZNv3PqjrIqz1Xi1EfIV07w77VVk8
 DuG64Bss+gfGl/r1iEMiMelwOnSqxWngwktWhEJR3EN/mRmNR9dy0LZ0j3J3ZkeEQAy/Ywg=
X-Google-Smtp-Source: AGHT+IF9PM2leGw5Pd+zPqrUQRjJPrwnnSQCWoX2My6Oao/HqMs+G4Z0JeF06ar9LdrOMciShUwIhA==
X-Received: by 2002:a5d:6d06:0:b0:38b:f4dc:44ad with SMTP id
 ffacd0b85a97d-38c5a94f4f1mr1853968f8f.5.1738228155989; 
 Thu, 30 Jan 2025 01:09:15 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:14f6:2931:46df:28c5?
 ([2a01:e0a:3cb:7bb0:14f6:2931:46df:28c5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc26d05sm51363495e9.12.2025.01.30.01.09.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2025 01:09:15 -0800 (PST)
Message-ID: <27974e6c-caca-484c-b6c4-c960f082f24b@linaro.org>
Date: Thu, 30 Jan 2025 10:09:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/4] meminfo: add memory details for armv8
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, maz@kernel.org,
 trini@konsulko.com, CFSworks@gmail.com
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>, =?UTF-8?Q?Pierre-Cl=C3=A9ment_Tosi?=
 <ptosi@google.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>, Peter Hoyes <Peter.Hoyes@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, Sam Day <me@samcday.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Michal Simek <michal.simek@amd.com>, Christian Marangi
 <ansuelsmth@gmail.com>, u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250130072100.27297-1-ilias.apalodimas@linaro.org>
 <20250130072100.27297-2-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250130072100.27297-2-ilias.apalodimas@linaro.org>
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

Hi Ilias,

On 1/30/25 08:20, Ilias Apalodimas wrote:
> Upcoming patches are mapping memory with RO, RW^X etc permsissions.
> Fix the meminfo command to display them properly
> 
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  arch/arm/cpu/armv8/cache_v8.c    | 18 +++++++++++++++++-
>  arch/arm/include/asm/armv8/mmu.h |  2 ++
>  cmd/meminfo.c                    |  5 +++++
>  3 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
> index 5d6953ffedd1..a4ca56c8ed42 100644
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
> @@ -568,6 +568,17 @@ static void pretty_print_table_attrs(u64 pte)
>  static void pretty_print_block_attrs(u64 pte)
>  {
>  	u64 attrs = pte & PMD_ATTRINDX_MASK;
> +	u64 perm_attrs = pte & PMD_ATTRMASK;
> +
> +	if ((perm_attrs & PTE_BLOCK_PXN) && (perm_attrs & PTE_BLOCK_UXN) &&
> +	    perm_attrs & PTE_BLOCK_RO)
> +		printf("%-5s", " | RO");
> +	else if ((perm_attrs & PTE_BLOCK_PXN) && (perm_attrs & PTE_BLOCK_UXN))
> +		printf("%-5s", " | RW");
> +	else if (perm_attrs & PTE_BLOCK_RO)
> +		printf("%-5s", " | RX");
> +	else
> +		printf("%-5s", " | RWX");

We could also print out the unprivileged and privileged permissions
explicitly, for example rwxRWX or rw-RW- etc. but maybe the format
you're proposing is more to the point since it is not detailed
debugging info that we're after.

>  
>  	switch (attrs) {
>  	case PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE):
> @@ -1112,3 +1123,8 @@ void __weak enable_caches(void)
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

Acked-by: Jerome Forissier <jerome.forissier@linaro.org>
