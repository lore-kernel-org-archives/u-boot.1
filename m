Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95239C54E41
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 17:35:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DF7A88055;
	Tue,  5 Mar 2024 18:35:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="zRpEF+gi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA67D88095; Tue,  5 Mar 2024 18:35:01 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E284879BB
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 18:34:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 425HYv12024270;
 Tue, 5 Mar 2024 11:34:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1709660097;
 bh=dhxVezcjVWbv4kjSX9ROOC6lQATruOPCiMXq5J/uxks=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=zRpEF+gineH3NrPpDMZ+ksZ2c0UIj8a5EBJ5+ceBncQ3z13j36EY+7rQqvENcZsf5
 2TAnGTFoqWGHkokGBraZjcFyGpHdF22ZmXz6yd7tcsTaok6DRbXIMVo0fi0zu1+TPk
 kG6/aPo6WKMg/GZnugT5x4KE5uIrmwdBrAWf1yJI=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 425HYvnp048279
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 5 Mar 2024 11:34:57 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 5
 Mar 2024 11:34:57 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 5 Mar 2024 11:34:57 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 425HYv7V116973;
 Tue, 5 Mar 2024 11:34:57 -0600
Date: Tue, 5 Mar 2024 11:34:57 -0600
From: Bryan Brattlof <bb@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>
CC: Wadim Egorov <w.egorov@phytec.de>, <u-boot@lists.denx.de>, <nm@ti.com>,
 <upstream@lists.phytec.de>
Subject: Re: [PATCH 1/2] arm: mach-k3: am625: copy bootindex to OCRAM for
 main domain SPL
Message-ID: <20240305173457.ir564jlw3euux54n@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20240226133006.3279993-1-w.egorov@phytec.de>
 <20240226133006.3279993-2-w.egorov@phytec.de>
 <eeda9c00-d7c6-444b-ba77-f70b2f19eb2a@ti.com>
 <20240304202717.7ruiozbuzy4bv5iz@bryanbrattlof.com>
 <2428cd68-f69f-4915-bd94-f7b6bb84152c@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <2428cd68-f69f-4915-bd94-f7b6bb84152c@ti.com>
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

On March  5, 2024 thus sayeth Vignesh Raghavendra:
> 
> 
> On 05/03/24 01:57, Bryan Brattlof wrote:
> > Hey Vignesh!
> > 
> > On March  4, 2024 thus sayeth Vignesh Raghavendra:
> >> Hi Wadim,
> >>
> >> On 26/02/24 19:00, Wadim Egorov wrote:
> >>> Texas Instruments has begun enabling security settings on the SoCs it
> >>> produces to instruct ROM and TIFS to begin protecting the Security
> >>> Management Subsystem (SMS) from other binaries we load into the chip by
> >>> default.
> >>>
> >>> One way ROM and TIFS do this is by enabling firewalls to protect the
> >>> OCSRAM and HSM RAM regions they're using during bootup.
> >>>
> >>> The HSM RAM the wakeup SPL is in is firewalled by TIFS to protect
> >>> itself from the main domain applications. This means the 'bootindex'
> >>> value in HSM RAM, left by ROM to indicate if we're using the primary
> >>> or secondary boot-method, must be moved to OCSRAM (that TIFS has open
> >>> for us) before we make the jump to the main domain so the main domain's
> >>> bootloaders can keep access to this information.
> >>>
> >>> Based on commit
> >>>   b672e8581070 ("arm: mach-k3: copy bootindex to OCRAM for main domain SPL")
> >>>
> >>
> >> FYI, this is mostly a problem in non SPL flow (TI prosperity SBL for
> >> example) where HSM RAM would be used by HSM firmware. This should be a
> >> issue in R5 SPL flow.  Do you see any issues today? If so, whats the
> >> TIFS firmware being used?
> >>
> >>> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> >>> ---
> >>>  arch/arm/mach-k3/Kconfig                      |  3 ++-
> >>>  arch/arm/mach-k3/am625_init.c                 | 15 +++++++++++++--
> >>>  arch/arm/mach-k3/include/mach/am62_hardware.h | 15 +++++++++++++++
> >>>  3 files changed, 30 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
> >>> index 03898424c9..f5d06593f7 100644
> >>> --- a/arch/arm/mach-k3/Kconfig
> >>> +++ b/arch/arm/mach-k3/Kconfig
> >>> @@ -75,7 +75,8 @@ config SYS_K3_BOOT_PARAM_TABLE_INDEX
> >>>  	default 0x41cffbfc if SOC_K3_J721E
> >>>  	default 0x41cfdbfc if SOC_K3_J721S2
> >>>  	default 0x701bebfc if SOC_K3_AM642
> >>> -	default 0x43c3f290 if SOC_K3_AM625
> >>> +	default 0x43c3f290 if SOC_K3_AM625 && CPU_V7R
> >>> +	default 0x7000f290 if SOC_K3_AM625 && ARM64
> >>>  	default 0x43c3f290 if SOC_K3_AM62A7 && CPU_V7R
> >>>  	default 0x7000f290 if SOC_K3_AM62A7 && ARM64
> >>>  	help
> >>> diff --git a/arch/arm/mach-k3/am625_init.c b/arch/arm/mach-k3/am625_init.c
> >>> index 6c96e88114..67cf63b103 100644
> >>> --- a/arch/arm/mach-k3/am625_init.c
> >>> +++ b/arch/arm/mach-k3/am625_init.c
> >>> @@ -35,8 +35,10 @@ static struct rom_extended_boot_data bootdata __section(".data");
> >>>  static void store_boot_info_from_rom(void)
> >>>  {
> >>>  	bootindex = *(u32 *)(CONFIG_SYS_K3_BOOT_PARAM_TABLE_INDEX);
> >>> -	memcpy(&bootdata, (uintptr_t *)ROM_EXTENDED_BOOT_DATA_INFO,
> >>> -	       sizeof(struct rom_extended_boot_data));
> >>> +	if (IS_ENABLED(CONFIG_CPU_V7R)) {
> >>> +		memcpy(&bootdata, (uintptr_t *)ROM_EXTENDED_BOOT_DATA_INFO,
> >>> +		       sizeof(struct rom_extended_boot_data));
> >>> +	}
> >>>  }
> >>>  
> >>>  static void ctrl_mmr_unlock(void)
> >>> @@ -175,6 +177,15 @@ void board_init_f(ulong dummy)
> >>>  		k3_sysfw_loader(true, NULL, NULL);
> >>>  	}
> >>>  
> >>> +#if defined(CONFIG_CPU_V7R)
> >>> +	/*
> >>> +	 * Relocate boot information to OCRAM (after TIFS has opend this
> >>> +	 * region for us) so the next bootloader stages can keep access to
> >>> +	 * primary vs backup bootmodes.
> >>> +	 */
> >>> +	writel(bootindex, K3_BOOT_PARAM_TABLE_INDEX_OCRAM);
> >>> +#endif
> >>> +
> >>>  	/*
> >>>  	 * Force probe of clk_k3 driver here to ensure basic default clock
> >>>  	 * configuration is always done.
> >>> diff --git a/arch/arm/mach-k3/include/mach/am62_hardware.h b/arch/arm/mach-k3/include/mach/am62_hardware.h
> >>> index 54380f36e1..9f504f4642 100644
> >>> --- a/arch/arm/mach-k3/include/mach/am62_hardware.h
> >>> +++ b/arch/arm/mach-k3/include/mach/am62_hardware.h
> >>> @@ -76,8 +76,23 @@
> >>>  #define CTRLMMR_MCU_RST_CTRL			(MCU_CTRL_MMR0_BASE + 0x18170)
> >>>  
> >>>  #define ROM_EXTENDED_BOOT_DATA_INFO		0x43c3f1e0
> >>> +#define K3_BOOT_PARAM_TABLE_INDEX_OCRAM         0x7000F290
> >>>  
> >>> +/*
> >>> + * During the boot process ROM will kill anything that writes to OCSRAM.
> >>
> >> R5 ROM is long gone when R5 SPL starts, how would it kill anything?
> > 
> > Looks like this was based on my patch long ago for the AM62Ax family. 
> > From what little I remember about this was ROM is leaving behind a 
> > firewall that we need TIFS's help to bring down for us. So I just
> > blamed ROM ;)
> 
> Thats true. ROM does bare minimum and so wont open up firewall around
> main SRAM. but TIFS does, so you should be able to access this region
> post k3_sysfw_loader().
> 
> > 
> > IDK if this is an issue for the AM62x family though.
> > 
> 
> It might be if one tries to "select" DT using EEPROM detect before SYSFW
> is up. But that's not the case any more right?

Yep we still need to figure out a plan for multiple DDR configs or see 
if we can move the DDR init to later in the boot as that is the only 
thing left that still needs the board detection this early on.

There is a little race condition here as TIFS can respond to some 
messages before it's finished its init. IDK if we can send it anything 
to act like a fence and stall us until the firewalls are down though.

> 
> >>
> >>> + * This means the wakeup SPL cannot use this region during boot. To
> >>> + * complicate things, TIFS will set a firewall between HSM RAM and the
> >>> + * main domain.
> >>> + *
> >>> + * So, during the wakeup SPL, we will need to store the EEPROM data
> >>> + * somewhere in HSM RAM, and the main domain's SPL will need to store it
> >>> + * somewhere in OCSRAM
> >>> + */
> >>> +#ifdef CONFIG_CPU_V7R
> >>>  #define TI_SRAM_SCRATCH_BOARD_EEPROM_START	0x43c30000
> >>> +#else
> >>> + #define TI_SRAM_SCRATCH_BOARD_EEPROM_START	0x70000001
> >>
> >> Why not  0x70000000 ?
> > 
> > Ah an off by one by me :) 0x70000000 should be fine
> > 
> >>
> >>> +#endif /* CONFIG_CPU_V7R */
> >>>  
> >>
> >> Can't we store directly in OCRAM in both stages? This RAM should be
> >> accessible post TIFS is up (ie post k3_sysfw_loader() call)
> > 
> > I'll have to double check but I think this should work.

This should work, using the HSM's RAM was just a short sided work around 
before the HS chips started being produced.

~Bryan
