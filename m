Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B35DC48BF6
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 05:06:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43C7687F10;
	Mon,  4 Mar 2024 06:06:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="tnNsx0tQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4474A87F10; Mon,  4 Mar 2024 06:06:48 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8DCD87F4A
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 06:06:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vigneshr@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42456gw3122684;
 Sun, 3 Mar 2024 23:06:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1709528802;
 bh=nhPsa8LimxKfmh1IpmuqGABypd7NRoumBHw5Ks7GgiU=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=tnNsx0tQQprUDWDacf8larWikSCp3qnLgZPTchBrSs2KWO0AxPJZP2088XeBo6SvT
 BJFis63ZH7+htzkS1FI6g7P7TDpZrb10G6XzXz1u3hY8dj+nP5yihXuSlhbgq7A6ZQ
 ZsGJHEILMDhVpbXpQEKyRyvfSdOFboip0zT/YApo=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42456gCC105029
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 3 Mar 2024 23:06:42 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 3
 Mar 2024 23:06:42 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 3 Mar 2024 23:06:42 -0600
Received: from [172.24.227.94] (uda0132425.dhcp.ti.com [172.24.227.94])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42456eFW130981;
 Sun, 3 Mar 2024 23:06:40 -0600
Message-ID: <eeda9c00-d7c6-444b-ba77-f70b2f19eb2a@ti.com>
Date: Mon, 4 Mar 2024 10:36:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm: mach-k3: am625: copy bootindex to OCRAM for main
 domain SPL
Content-Language: en-US
To: Wadim Egorov <w.egorov@phytec.de>, <u-boot@lists.denx.de>
CC: <nm@ti.com>, <upstream@lists.phytec.de>, <bb@ti.com>
References: <20240226133006.3279993-1-w.egorov@phytec.de>
 <20240226133006.3279993-2-w.egorov@phytec.de>
From: Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20240226133006.3279993-2-w.egorov@phytec.de>
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

Hi Wadim,

On 26/02/24 19:00, Wadim Egorov wrote:
> Texas Instruments has begun enabling security settings on the SoCs it
> produces to instruct ROM and TIFS to begin protecting the Security
> Management Subsystem (SMS) from other binaries we load into the chip by
> default.
> 
> One way ROM and TIFS do this is by enabling firewalls to protect the
> OCSRAM and HSM RAM regions they're using during bootup.
> 
> The HSM RAM the wakeup SPL is in is firewalled by TIFS to protect
> itself from the main domain applications. This means the 'bootindex'
> value in HSM RAM, left by ROM to indicate if we're using the primary
> or secondary boot-method, must be moved to OCSRAM (that TIFS has open
> for us) before we make the jump to the main domain so the main domain's
> bootloaders can keep access to this information.
> 
> Based on commit
>   b672e8581070 ("arm: mach-k3: copy bootindex to OCRAM for main domain SPL")
> 

FYI, this is mostly a problem in non SPL flow (TI prosperity SBL for
example) where HSM RAM would be used by HSM firmware. This should be a
issue in R5 SPL flow.  Do you see any issues today? If so, whats the
TIFS firmware being used?

> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> ---
>  arch/arm/mach-k3/Kconfig                      |  3 ++-
>  arch/arm/mach-k3/am625_init.c                 | 15 +++++++++++++--
>  arch/arm/mach-k3/include/mach/am62_hardware.h | 15 +++++++++++++++
>  3 files changed, 30 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
> index 03898424c9..f5d06593f7 100644
> --- a/arch/arm/mach-k3/Kconfig
> +++ b/arch/arm/mach-k3/Kconfig
> @@ -75,7 +75,8 @@ config SYS_K3_BOOT_PARAM_TABLE_INDEX
>  	default 0x41cffbfc if SOC_K3_J721E
>  	default 0x41cfdbfc if SOC_K3_J721S2
>  	default 0x701bebfc if SOC_K3_AM642
> -	default 0x43c3f290 if SOC_K3_AM625
> +	default 0x43c3f290 if SOC_K3_AM625 && CPU_V7R
> +	default 0x7000f290 if SOC_K3_AM625 && ARM64
>  	default 0x43c3f290 if SOC_K3_AM62A7 && CPU_V7R
>  	default 0x7000f290 if SOC_K3_AM62A7 && ARM64
>  	help
> diff --git a/arch/arm/mach-k3/am625_init.c b/arch/arm/mach-k3/am625_init.c
> index 6c96e88114..67cf63b103 100644
> --- a/arch/arm/mach-k3/am625_init.c
> +++ b/arch/arm/mach-k3/am625_init.c
> @@ -35,8 +35,10 @@ static struct rom_extended_boot_data bootdata __section(".data");
>  static void store_boot_info_from_rom(void)
>  {
>  	bootindex = *(u32 *)(CONFIG_SYS_K3_BOOT_PARAM_TABLE_INDEX);
> -	memcpy(&bootdata, (uintptr_t *)ROM_EXTENDED_BOOT_DATA_INFO,
> -	       sizeof(struct rom_extended_boot_data));
> +	if (IS_ENABLED(CONFIG_CPU_V7R)) {
> +		memcpy(&bootdata, (uintptr_t *)ROM_EXTENDED_BOOT_DATA_INFO,
> +		       sizeof(struct rom_extended_boot_data));
> +	}
>  }
>  
>  static void ctrl_mmr_unlock(void)
> @@ -175,6 +177,15 @@ void board_init_f(ulong dummy)
>  		k3_sysfw_loader(true, NULL, NULL);
>  	}
>  
> +#if defined(CONFIG_CPU_V7R)
> +	/*
> +	 * Relocate boot information to OCRAM (after TIFS has opend this
> +	 * region for us) so the next bootloader stages can keep access to
> +	 * primary vs backup bootmodes.
> +	 */
> +	writel(bootindex, K3_BOOT_PARAM_TABLE_INDEX_OCRAM);
> +#endif
> +
>  	/*
>  	 * Force probe of clk_k3 driver here to ensure basic default clock
>  	 * configuration is always done.
> diff --git a/arch/arm/mach-k3/include/mach/am62_hardware.h b/arch/arm/mach-k3/include/mach/am62_hardware.h
> index 54380f36e1..9f504f4642 100644
> --- a/arch/arm/mach-k3/include/mach/am62_hardware.h
> +++ b/arch/arm/mach-k3/include/mach/am62_hardware.h
> @@ -76,8 +76,23 @@
>  #define CTRLMMR_MCU_RST_CTRL			(MCU_CTRL_MMR0_BASE + 0x18170)
>  
>  #define ROM_EXTENDED_BOOT_DATA_INFO		0x43c3f1e0
> +#define K3_BOOT_PARAM_TABLE_INDEX_OCRAM         0x7000F290
>  
> +/*
> + * During the boot process ROM will kill anything that writes to OCSRAM.

R5 ROM is long gone when R5 SPL starts, how would it kill anything?

> + * This means the wakeup SPL cannot use this region during boot. To
> + * complicate things, TIFS will set a firewall between HSM RAM and the
> + * main domain.
> + *
> + * So, during the wakeup SPL, we will need to store the EEPROM data
> + * somewhere in HSM RAM, and the main domain's SPL will need to store it
> + * somewhere in OCSRAM
> + */
> +#ifdef CONFIG_CPU_V7R
>  #define TI_SRAM_SCRATCH_BOARD_EEPROM_START	0x43c30000
> +#else
> + #define TI_SRAM_SCRATCH_BOARD_EEPROM_START	0x70000001

Why not  0x70000000 ?

> +#endif /* CONFIG_CPU_V7R */
>  

Can't we store directly in OCRAM in both stages? This RAM should be
accessible post TIFS is up (ie post k3_sysfw_loader() call)

>  static inline int k3_get_core_nr(void)
>  {

-- 
Regards
Vignesh
