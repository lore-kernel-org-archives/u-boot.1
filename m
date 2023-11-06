Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F01FC4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 16:54:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AD6686538;
	Mon,  6 Nov 2023 17:54:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="UAs2iw1j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37E8286758; Mon,  6 Nov 2023 17:54:34 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 113B98272A
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 17:54:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A6GsQuP058481;
 Mon, 6 Nov 2023 10:54:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699289666;
 bh=w+9dcjU2myvQ4avqtNZIDDyOPD3q3cXP1CIQpKn5KIc=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=UAs2iw1jcn1WlQviIGLMDh/Y4AwktwsrYrMI9DrvV2cKaY8wVoe8j7hneVm+gkFaz
 6KUcKGXxdj55dvK9GChqoiITsyLu9/fyQJZ3kVpy5rh0l3o/Wh3ldfs347x+jPwe+s
 pnMfA689z6xS/cS8KHFUIO/ZDS1ZfHYr5Rfl5oVs=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A6GsQ59059181
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 6 Nov 2023 10:54:26 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 6
 Nov 2023 10:54:26 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 6 Nov 2023 10:54:26 -0600
Received: from [10.250.34.172] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A6GsPi1097102;
 Mon, 6 Nov 2023 10:54:25 -0600
Message-ID: <e875e2ee-2d92-4b27-b9a8-6bd7d6281c49@ti.com>
Date: Mon, 6 Nov 2023 10:54:25 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 08/12] arm: mach-k3: arm64-mmu: Refactor to be
 independent of board
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>, Tom Rini <trini@konsulko.com>
CC: Heinrich Schuchardt <xypron.glpk@gmx.de>, Sinthu Raja <sinthu.raja@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Reid Tonking <reidt@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>,
 Robert Nelson <robertcnelson@gmail.com>, Jason Kridner
 <jkridner@beagleboard.org>, <u-boot@lists.denx.de>
References: <20231104072150.3339-1-nm@ti.com> <20231104072150.3339-9-nm@ti.com>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20231104072150.3339-9-nm@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

On 11/4/23 2:21 AM, Nishanth Menon wrote:
> Refactor J721E J7200 definition to make this independent of board
> macros.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>   arch/arm/mach-k3/arm64-mmu.c | 50 ++++++++++++++++++------------------
>   1 file changed, 25 insertions(+), 25 deletions(-)
> 
> diff --git a/arch/arm/mach-k3/arm64-mmu.c b/arch/arm/mach-k3/arm64-mmu.c
> index f8087d2421e7..8cb6614035a5 100644
> --- a/arch/arm/mach-k3/arm64-mmu.c
> +++ b/arch/arm/mach-k3/arm64-mmu.c
> @@ -68,12 +68,11 @@ struct mm_region *mem_map = am654_mem_map;
>   
>   #ifdef CONFIG_SOC_K3_J721E
>   
> -#ifdef CONFIG_TARGET_J721E_A72_EVM
> -/* NR_DRAM_BANKS + 32bit IO + 64bit IO + terminator */
> -#define NR_MMU_REGIONS	(CONFIG_NR_DRAM_BANKS + 6)
> +#ifdef CONFIG_SOC_K3_J721E_J7200
> +#define NR_MMU_REGIONS	(CONFIG_NR_DRAM_BANKS + 5)
>   
>   /* ToDo: Add 64bit IO */
> -struct mm_region j721e_mem_map[NR_MMU_REGIONS] = {
> +struct mm_region j7200_mem_map[NR_MMU_REGIONS] = {

Git diff seems to have gotten confused with your re-ordering, makes
this hard to review what you are actually changing here..

Also you reminded me of a patch I forgot to send from long ago, just
sent it, should make this patch a little more simple if it goes in
first.

Andrew

>   	{
>   		.virt = 0x0UL,
>   		.phys = 0x0UL,
> @@ -90,13 +89,13 @@ struct mm_region j721e_mem_map[NR_MMU_REGIONS] = {
>   	}, {
>   		.virt = 0xa0000000UL,
>   		.phys = 0xa0000000UL,
> -		.size = 0x1bc00000UL,
> +		.size = 0x04800000UL,
>   		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL_NC) |
>   			 PTE_BLOCK_NON_SHARE
>   	}, {
> -		.virt = 0xbbc00000UL,
> -		.phys = 0xbbc00000UL,
> -		.size = 0x44400000UL,
> +		.virt = 0xa4800000UL,
> +		.phys = 0xa4800000UL,
> +		.size = 0x5b800000UL,
>   		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
>   			 PTE_BLOCK_INNER_SHARE
>   	}, {
> @@ -112,26 +111,21 @@ struct mm_region j721e_mem_map[NR_MMU_REGIONS] = {
>   		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
>   			 PTE_BLOCK_NON_SHARE |
>   			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> -	}, {
> -		.virt = 0x4d80000000UL,
> -		.phys = 0x4d80000000UL,
> -		.size = 0x0002000000UL,
> -		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL_NC) |
> -			 PTE_BLOCK_INNER_SHARE
>   	}, {
>   		/* List terminator */
>   		0,
>   	}
>   };
>   
> -struct mm_region *mem_map = j721e_mem_map;
> -#endif /* CONFIG_TARGET_J721E_A72_EVM */
> +struct mm_region *mem_map = j7200_mem_map;
>   
> -#ifdef CONFIG_TARGET_J7200_A72_EVM
> -#define NR_MMU_REGIONS	(CONFIG_NR_DRAM_BANKS + 5)
> +#else /* CONFIG_SOC_K3_J721E_J7200 */
> +
> +/* NR_DRAM_BANKS + 32bit IO + 64bit IO + terminator */
> +#define NR_MMU_REGIONS	(CONFIG_NR_DRAM_BANKS + 6)
>   
>   /* ToDo: Add 64bit IO */
> -struct mm_region j7200_mem_map[NR_MMU_REGIONS] = {
> +struct mm_region j721e_mem_map[NR_MMU_REGIONS] = {
>   	{
>   		.virt = 0x0UL,
>   		.phys = 0x0UL,
> @@ -148,13 +142,13 @@ struct mm_region j7200_mem_map[NR_MMU_REGIONS] = {
>   	}, {
>   		.virt = 0xa0000000UL,
>   		.phys = 0xa0000000UL,
> -		.size = 0x04800000UL,
> +		.size = 0x1bc00000UL,
>   		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL_NC) |
>   			 PTE_BLOCK_NON_SHARE
>   	}, {
> -		.virt = 0xa4800000UL,
> -		.phys = 0xa4800000UL,
> -		.size = 0x5b800000UL,
> +		.virt = 0xbbc00000UL,
> +		.phys = 0xbbc00000UL,
> +		.size = 0x44400000UL,
>   		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
>   			 PTE_BLOCK_INNER_SHARE
>   	}, {
> @@ -170,14 +164,20 @@ struct mm_region j7200_mem_map[NR_MMU_REGIONS] = {
>   		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
>   			 PTE_BLOCK_NON_SHARE |
>   			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +	}, {
> +		.virt = 0x4d80000000UL,
> +		.phys = 0x4d80000000UL,
> +		.size = 0x0002000000UL,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL_NC) |
> +			 PTE_BLOCK_INNER_SHARE
>   	}, {
>   		/* List terminator */
>   		0,
>   	}
>   };
>   
> -struct mm_region *mem_map = j7200_mem_map;
> -#endif /* CONFIG_TARGET_J7200_A72_EVM */
> +struct mm_region *mem_map = j721e_mem_map;
> +#endif /* CONFIG_SOC_K3_J721E_J7200 */
>   
>   #endif /* CONFIG_SOC_K3_J721E */
>   
