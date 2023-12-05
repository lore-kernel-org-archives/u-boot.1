Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EAF4C4167B
	for <u-boot@archiver.kernel.org>; Tue,  5 Dec 2023 11:33:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92637876AC;
	Tue,  5 Dec 2023 12:33:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="UMQZRBCR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7277A87767; Tue,  5 Dec 2023 12:33:12 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5648386E88
 for <u-boot@lists.denx.de>; Tue,  5 Dec 2023 12:33:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-jain1@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B5BX5oG042877;
 Tue, 5 Dec 2023 05:33:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1701775985;
 bh=zl3nQvwjChldxXKyv1/M0tHC/oao5Ia+Tnvryw9tvoA=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=UMQZRBCRLGzC5ONn4UtGlNL7hy55dnug5CkNRuJTwTFZ+exU0XXEvnw+faWsc1Zie
 dpeJ7zUP1sWv1euyZC7ZafHuZa3qIpHtwTJtq/UblG+TMQguq2UZun9QlwlrRtj5o5
 9rLREVdCRfAkT8FQk23f7FC182K4eD7e24SFIG20=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B5BX50r030203
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 5 Dec 2023 05:33:05 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 5
 Dec 2023 05:33:05 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 5 Dec 2023 05:33:05 -0600
Received: from [172.24.227.70] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B5BX0aY122440;
 Tue, 5 Dec 2023 05:33:01 -0600
Message-ID: <d7519811-ec90-4003-8cc8-4739b8675aa5@ti.com>
Date: Tue, 5 Dec 2023 17:03:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] arm: mach-k3: common: Reserve video memory from
 end of the RAM
Content-Language: en-US
To: Devarsh Thakkar <devarsht@ti.com>, <u-boot@lists.denx.de>,
 <sjg@chromium.org>, <agust@denx.de>, <trini@konsulko.com>,
 <bmeng.cn@gmail.com>, <msuchanek@suse.de>,
 <rasmus.villemoes@prevas.dk>, <yangshiji66@outlook.com>
CC: <praneeth@ti.com>, <nm@ti.com>, <vigneshr@ti.com>, <a-bhatia1@ti.com>,
 <j-luthra@ti.com>, <nsekhar@ti.com>
References: <20231110152944.647535-1-devarsht@ti.com>
 <20231110152944.647535-2-devarsht@ti.com>
From: Nikhil Jain <n-jain1@ti.com>
In-Reply-To: <20231110152944.647535-2-devarsht@ti.com>
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

On 10/11/23 20:59, Devarsh Thakkar wrote:
> Add function spl_reserve_video which is a wrapper
> around video_reserve to setup video memory and update
> the relocation address pointer.
>
> Setup video memory before page table reservation so that
> framebuffer memory gets reserved from the end of RAM.
>
> This is as per the new policy being discussed for passing
> blobs where each of the reserved areas for bloblists
> to be passed need to be reserved at the end of RAM.
>
> This is done to enable the next stage to directly skip
> the pre-reserved area from previous stage right from the end of RAM
> without having to make any gaps/holes to accommodate those
> regions which was the case before as previous stage
> reserved region not from the end of RAM.
>
> Suggested-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>

Reviewed-By: Nikhil M Jain <n-jain1@ti.com>

Regards,
Nikhil
> ---
> V2:
> - Make a generic function "spl_reserve_video" under
>   common/spl which can be re-used by other platforms too
>   for reserving video memory from spl.
>
> V3:
> - Change spl_reserve_video to spl_reserve_video_from_ram_top
>   which enforce framebuffer reservation from end of RAM
> - Use gd->ram_top instead of local ram_top and update
>   gd->reloc_addr after each reservation
> - Print error message on framebuffer reservation
> ---
>  arch/arm/mach-k3/common.c | 17 ++++++++++++-----
>  common/spl/spl.c          | 27 +++++++++++++++++++++++++++
>  include/spl.h             |  6 ++++++
>  3 files changed, 45 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
> index c3006ba387..6590045140 100644
> --- a/arch/arm/mach-k3/common.c
> +++ b/arch/arm/mach-k3/common.c
> @@ -525,19 +525,26 @@ void remove_fwl_configs(struct fwl_data *fwl_data, size_t fwl_data_size)
>  void spl_enable_dcache(void)
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
> +		pr_err("ERROR: Failed to framebuffer memory in SPL\n");
> +
> +	gd->arch.tlb_addr = gd->relocaddr - gd->arch.tlb_size;
>  	gd->arch.tlb_addr &= ~(0x10000 - 1);
>  	debug("TLB table from %08lx to %08lx\n", gd->arch.tlb_addr,
>  	      gd->arch.tlb_addr + gd->arch.tlb_size);
> diff --git a/common/spl/spl.c b/common/spl/spl.c
> index 732d90d39e..452bf303de 100644
> --- a/common/spl/spl.c
> +++ b/common/spl/spl.c
> @@ -41,6 +41,7 @@
>  #include <fdt_support.h>
>  #include <bootcount.h>
>  #include <wdt.h>
> +#include <video.h>
>  
>  DECLARE_GLOBAL_DATA_PTR;
>  DECLARE_BINMAN_MAGIC_SYM;
> @@ -151,6 +152,32 @@ void spl_fixup_fdt(void *fdt_blob)
>  #endif
>  }
>  
> +/*
> + * Reserve video memory for SPL splash screen from
> + * end of RAM
> + *
> + * RETURN
> + * 0 : On success
> + * Non-zero : On failure
> + */
> +int spl_reserve_video_from_ram_top(void)
> +{
> +	if (CONFIG_IS_ENABLED(VIDEO)) {
> +		ulong addr;
> +		int ret;
> +
> +		addr = gd->ram_top;
> +		ret = video_reserve(&addr);
> +		if (ret)
> +			return ret;
> +		debug("Reserving %luk for video at: %08lx\n",
> +		      ((unsigned long)gd->relocaddr - addr) >> 10, addr);
> +		gd->relocaddr = addr;
> +	}
> +
> +	return 0;
> +}
> +
>  ulong spl_get_image_pos(void)
>  {
>  	if (!CONFIG_IS_ENABLED(BINMAN_UBOOT_SYMBOLS))
> diff --git a/include/spl.h b/include/spl.h
> index 0d49e4a454..39f2a7581d 100644
> --- a/include/spl.h
> +++ b/include/spl.h
> @@ -825,6 +825,12 @@ int spl_usb_load(struct spl_image_info *spl_image,
>  
>  int spl_ymodem_load_image(struct spl_image_info *spl_image,
>  			  struct spl_boot_device *bootdev);
> +/**
> + * spl_reserve_video_from_ram_top() - Reserve framebuffer memory from end of RAM
> + *
> + * Return: 0 on success, otherwise error code
> + */
> +int spl_reserve_video_from_ram_top(void);
>  
>  /**
>   * spl_invoke_atf - boot using an ARM trusted firmware image
