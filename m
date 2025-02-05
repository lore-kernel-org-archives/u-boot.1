Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E755C02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 05:55:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3D9480104;
	Wed,  5 Feb 2025 06:55:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="MeJbjVYh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E433805E2; Wed,  5 Feb 2025 06:55:09 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A42BB80087
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 06:55:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 5155t3wA3295999
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 4 Feb 2025 23:55:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1738734904;
 bh=m4N+5AsRvBG5a+F39WB+szucCO3APgnlPbJ2cwJcP88=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=MeJbjVYhkR4s6U9rcFtn0ztniWL8CSUR6BXOq94nR5MPfXhlec4P/+wD8/24sTN9G
 9w2fAyhpUJ2fuWW/KAJtABm/Mixj2RfyqkYo5vDZ0K/Kt3cjb183f7BAULv0aeS6DX
 9EMjNf1vZeR/g5+7MOHAscoApEN2hee1mk9sGEt0=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5155t37W046077;
 Tue, 4 Feb 2025 23:55:03 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 4
 Feb 2025 23:55:03 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 4 Feb 2025 23:55:03 -0600
Received: from localhost (lcpd911.dhcp.ti.com [172.24.227.226])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5155t2Fu042555;
 Tue, 4 Feb 2025 23:55:02 -0600
Date: Wed, 5 Feb 2025 11:25:02 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Wadim Egorov <w.egorov@phytec.de>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, <trini@konsulko.com>, 
 <n-francis@ti.com>, <nmorrisson@phytec.com>, <d.schultz@phytec.de>,
 <sjg@chromium.org>
Subject: Re: [PATCH v2 2/3] board: phytec: phycore_am64x: Add support for 1
 GB RAM variant and ECC
Message-ID: <20250205055502.zduyeiflus7yxojt@lcpd911>
References: <20250205043013.1404917-1-w.egorov@phytec.de>
 <20250205043013.1404917-2-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250205043013.1404917-2-w.egorov@phytec.de>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

On Feb 05, 2025 at 05:30:12 +0100, Wadim Egorov wrote:
> Detect RAM size via EEPROM and adjust DDR size and banks accordingly.
> Include necessary fixups to handle ECC-enabled configurations.
> 
> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> Tested-by: Daniel Schultz <d.schultz@phytec.de>
> ---
> v2: Add Tested-by from Daniel
> ---
>  board/phytec/phycore_am64x/Kconfig         |  25 +++++
>  board/phytec/phycore_am64x/phycore-am64x.c | 105 ++++++++++++++++++++-
>  2 files changed, 128 insertions(+), 2 deletions(-)
> 
> diff --git a/board/phytec/phycore_am64x/Kconfig b/board/phytec/phycore_am64x/Kconfig
> index 829526c3295..a709b71ba4d 100644
> --- a/board/phytec/phycore_am64x/Kconfig
> +++ b/board/phytec/phycore_am64x/Kconfig
> @@ -35,3 +35,28 @@ config SYS_CONFIG_NAME
>  source "board/phytec/common/Kconfig"
>  
>  endif
> +
> +config PHYCORE_AM64X_RAM_SIZE_FIX
> +        bool "Set phyCORE-AM64x RAM size fix instead of detecting"
> +        default false
> +        help
> +          RAM size is automatic being detected with the help of

s/automatic/automatically

> +          the EEPROM introspection data. Set RAM size to a fix value
> +          instead.
> +
> +choice
> +        prompt "phyCORE-AM64x RAM size"
> +        depends on PHYCORE_AM64X_RAM_SIZE_FIX
> +        default PHYCORE_AM64X_RAM_SIZE_2GB
> +
> +config PHYCORE_AM64X_RAM_SIZE_1GB
> +        bool "1GB RAM"
> +        help
> +          Set RAM size fix to 1GB for phyCORE-AM64x.
> +
> +config PHYCORE_AM64X_RAM_SIZE_2GB
> +        bool "2GB RAM"
> +        help
> +          Set RAM size fix to 2GB for phyCORE-AM64x.
> +
> +endchoice
> diff --git a/board/phytec/phycore_am64x/phycore-am64x.c b/board/phytec/phycore_am64x/phycore-am64x.c
> index 8f3b22657c7..f14c87f5c72 100644
> --- a/board/phytec/phycore_am64x/phycore-am64x.c
> +++ b/board/phytec/phycore_am64x/phycore-am64x.c
> @@ -11,9 +11,12 @@
>  #include <env.h>
>  #include <env_internal.h>
>  #include <spl.h>
> +#include <asm/arch/k3-ddr.h>

If adding new header might as well put it below asm/arch/hardware.h to
maintain some level of sort?

>  #include <fdt_support.h>
>  #include <asm/arch/hardware.h>
>  
> +#include "../common/am6_som_detection.h"
> +

I am already seeing 3 different way am6_som_detection.h is being
included. Please can we consider using <> to abstract these relative
paths?
It looks much cleaner that way and easier to maintain IMHO.

>  DECLARE_GLOBAL_DATA_PTR;
>  
>  int board_init(void)
> @@ -21,15 +24,113 @@ int board_init(void)
>  	return 0;
>  }
>  
> +static u8 phytec_get_am64_ddr_size_default(void)
> +{
> +	int ret;
> +	struct phytec_eeprom_data data;
> +
> +	if (IS_ENABLED(CONFIG_PHYCORE_AM64X_RAM_SIZE_FIX)) {
> +		if (IS_ENABLED(CONFIG_PHYCORE_AM64X_RAM_SIZE_1GB))
> +			return EEPROM_RAM_SIZE_1GB;
> +		else if (IS_ENABLED(CONFIG_PHYCORE_AM64X_RAM_SIZE_2GB))
> +			return EEPROM_RAM_SIZE_2GB;
> +	}
> +
> +	ret = phytec_eeprom_data_setup(&data, 0, EEPROM_ADDR);
> +	if (!ret && data.valid)
> +		return phytec_get_am6_ddr_size(&data);
> +
> +	/* Default DDR size is 2GB */
> +	return EEPROM_RAM_SIZE_2GB;
> +}
> +
>  int dram_init(void)
>  {
> -	return fdtdec_setup_mem_size_base();
> +	u8 ram_size;
> +
> +	if (!IS_ENABLED(CONFIG_CPU_V7R))
> +		return fdtdec_setup_mem_size_base();
> +
> +	ram_size = phytec_get_am64_ddr_size_default();
> +
> +	switch (ram_size) {
> +	case EEPROM_RAM_SIZE_1GB:
> +		gd->ram_size = 0x40000000;
> +		break;
> +	case EEPROM_RAM_SIZE_2GB:
> +		gd->ram_size = 0x80000000;
> +		break;
> +	default:
> +		gd->ram_size = 0x80000000;
> +	}
> +
> +	return 0;
>  }
>  
>  int dram_init_banksize(void)
>  {
> -	return fdtdec_setup_memory_banksize();
> +	u8 ram_size;
> +
> +	memset(gd->bd->bi_dram, 0, sizeof(gd->bd->bi_dram[0]) * CONFIG_NR_DRAM_BANKS);
> +
> +	if (!IS_ENABLED(CONFIG_CPU_V7R))
> +		return fdtdec_setup_memory_banksize();
> +
> +	ram_size = phytec_get_am64_ddr_size_default();
> +	switch (ram_size) {
> +	case EEPROM_RAM_SIZE_1GB:
> +		gd->bd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
> +		gd->bd->bi_dram[0].size = 0x40000000;
> +		gd->ram_size = 0x40000000;
> +		break;
> +
> +	case EEPROM_RAM_SIZE_2GB:
> +		gd->bd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
> +		gd->bd->bi_dram[0].size = 0x80000000;
> +		gd->ram_size = 0x80000000;
> +		break;
> +
> +	default:
> +		/* Continue with default 2GB setup */
> +		gd->bd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
> +		gd->bd->bi_dram[0].size = 0x80000000;
> +		gd->ram_size = 0x80000000;
> +		printf("DDR size %d is not supported\n", ram_size);
> +	}
> +
> +	return 0;
> +}
> +
> +#if defined(CONFIG_K3_DDRSS)
> +int do_board_detect(void)
> +{
> +	void *fdt = (void *)gd->fdt_blob;
> +	int bank;
> +
> +	u64 start[CONFIG_NR_DRAM_BANKS];
> +	u64 size[CONFIG_NR_DRAM_BANKS];
> +
> +	dram_init();
> +	dram_init_banksize();

No check for any failures from fdtdec_setup_memory_banksize ?

> +
> +	for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
> +		start[bank] = gd->bd->bi_dram[bank].start;
> +		size[bank] = gd->bd->bi_dram[bank].size;
> +	}
> +
> +	return fdt_fixup_memory_banks(fdt, start, size, CONFIG_NR_DRAM_BANKS);
> +}
> +#endif

Nit:
Try and end #endifs like this:
#endif /* CONFIG_K3_DDRSS */

Follow the convention everywhere else as it really improves code
readability.

> +
> +#if IS_ENABLED(CONFIG_XPL_BUILD)
> +void spl_perform_fixups(struct spl_image_info *spl_image)
> +{
> +	if (IS_ENABLED(CONFIG_K3_DDRSS) && IS_ENABLED(CONFIG_K3_INLINE_ECC))
> +		fixup_ddr_driver_for_ecc(spl_image);
> +	else
> +		fixup_memory_node(spl_image);
>  }
> +#endif
>  
>  #define CTRLMMR_USB0_PHY_CTRL	0x43004008
>  #define CORE_VOLTAGE		0x80000000
> -- 
> 2.34.1
> 

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated
