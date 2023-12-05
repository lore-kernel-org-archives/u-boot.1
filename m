Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CB97C4167B
	for <u-boot@archiver.kernel.org>; Tue,  5 Dec 2023 12:34:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C0BF870EA;
	Tue,  5 Dec 2023 13:34:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="RB3hiu9t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A504870B7; Tue,  5 Dec 2023 13:34:30 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 679A186EA6
 for <u-boot@lists.denx.de>; Tue,  5 Dec 2023 13:34:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-jain1@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B5CYMLm078116;
 Tue, 5 Dec 2023 06:34:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1701779662;
 bh=t7uK/vPq/YO9pn/69fgiEPA1D8UmOHWzU8aMRtpDtS4=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=RB3hiu9t26M/pg2qQmlvwV52oDnQvZDVs30Nidttfb9NVbE4Ar7JmY8E+LHc7q7GP
 ffezdWVcdUQiuiOmYoHAcQ4vFaXdPzzMnsx1vB+bBn95L5yw7q24ed4wRAv28BEvYt
 8E/gr8fNRKBfe4LkOtv1W54DoA+8e9OqbB8soQ5A=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B5CYMcu065671
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 5 Dec 2023 06:34:22 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 5
 Dec 2023 06:34:22 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 5 Dec 2023 06:34:22 -0600
Received: from [172.24.227.70] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B5CYHJ0128212;
 Tue, 5 Dec 2023 06:34:18 -0600
Message-ID: <be9291d2-ecaa-4bd1-91d8-27ced61543a5@ti.com>
Date: Tue, 5 Dec 2023 18:04:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/8] arm: mach-k3: common: Reserve video memory from
 end of the RAM
Content-Language: en-US
To: Devarsh Thakkar <devarsht@ti.com>, <u-boot@lists.denx.de>,
 <sjg@chromium.org>, <agust@denx.de>, <trini@konsulko.com>,
 <bmeng.cn@gmail.com>, <msuchanek@suse.de>,
 <rasmus.villemoes@prevas.dk>, <yangshiji66@outlook.com>
CC: <praneeth@ti.com>, <nm@ti.com>, <vigneshr@ti.com>, <a-bhatia1@ti.com>,
 <j-luthra@ti.com>, <nsekhar@ti.com>
References: <20231125162705.1383401-1-devarsht@ti.com>
 <20231125162705.1383401-3-devarsht@ti.com>
From: Nikhil Jain <n-jain1@ti.com>
In-Reply-To: <20231125162705.1383401-3-devarsht@ti.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Devarsh,

On 25/11/23 21:56, Devarsh Thakkar wrote:
> Setup video memory before page table reservation using
> "spl_reserve_video_from_ram_top" which ensures framebuffer memory gets
> reserved from the end of RAM.
>
> This is done to enable the next stage to directly skip the
> pre-reserved area from previous stage right from the end of RAM without
> having to make any gaps/holes to accommodate those regions which was the
> case before as previous stage reserved region not from the end of RAM.
>
> Use gd->ram_top instead of local ram_top and update gd->reloc_addr after
> each reservation to ensure further regions are reserved properly.
>
> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>

Reviewed-by: Nikhil M Jain <n-jain1@ti.com>

Regards,
Nikhil
> ---
> V2:
>  - Make a generic function "spl_reserve_video" under
>    common/spl which can be re-used by other platforms too
>    for reserving video memory from spl.
>
> V3:
>  - Change spl_reserve_video to spl_reserve_video_from_ram_top
>    which enforce framebuffer reservation from end of RAM
>  - Use gd->ram_top instead of local ram_top and update
>    gd->reloc_addr after each reservation
>  - Print error message on framebuffer reservation
>
> V4:
>  - Split this into a separate patch
> ---
>  arch/arm/mach-k3/common.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
> index fd400e7e3d..42ceeb5296 100644
> --- a/arch/arm/mach-k3/common.c
> +++ b/arch/arm/mach-k3/common.c
> @@ -524,19 +524,26 @@ void remove_fwl_configs(struct fwl_data *fwl_data, size_t fwl_data_size)
>  void spl_enable_cache(void)
>  {
>  #if !(defined(CONFIG_SYS_ICACHE_OFF) && defined(CONFIG_SYS_DCACHE_OFF))
> -	phys_addr_t ram_top = CFG_SYS_SDRAM_BASE;
> +	gd->ram_top = CFG_SYS_SDRAM_BASE;
> +	int ret = 0;
>  
>  	dram_init();
>  
>  	/* reserve TLB table */
>  	gd->arch.tlb_size = PGTABLE_SIZE;
>  
> -	ram_top += get_effective_memsize();
> +	gd->ram_top += get_effective_memsize();
>  	/* keep ram_top in the 32-bit address space */
> -	if (ram_top >= 0x100000000)
> -		ram_top = (phys_addr_t) 0x100000000;
> +	if (gd->ram_top >= 0x100000000)
> +		gd->ram_top = (phys_addr_t)0x100000000;
>  
> -	gd->arch.tlb_addr = ram_top - gd->arch.tlb_size;
> +	gd->relocaddr = gd->ram_top;
> +
> +	ret = spl_reserve_video_from_ram_top();
> +	if (ret)
> +		panic("Failed to reserve framebuffer memory (%d)\n", ret);
> +
> +	gd->arch.tlb_addr = gd->relocaddr - gd->arch.tlb_size;
>  	gd->arch.tlb_addr &= ~(0x10000 - 1);
>  	debug("TLB table from %08lx to %08lx\n", gd->arch.tlb_addr,
>  	      gd->arch.tlb_addr + gd->arch.tlb_size);
