Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47AFDC5478C
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 20:27:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51A4D87FCC;
	Mon,  4 Mar 2024 21:27:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="gBJ9Wjkm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3D7187FCC; Mon,  4 Mar 2024 21:27:21 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F4F687FC9
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 21:27:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 424KRHgN070822;
 Mon, 4 Mar 2024 14:27:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1709584037;
 bh=3K4QQnnYhZmfvdwyR+OGpkVLlYRFVbhaxQLGu0bxKR0=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=gBJ9WjkmNoiY22PXRM9CO3hvYM+naq/G/ELV2ckoCsExBV0B/7pQINzv8yfitpL3q
 d9Msrpzp3YXI3XNYAJdiNRC1m9cD4dKBUtFTLvEWjcRefZ+zEEvvq6XpywEjXYR+UZ
 9cPjuD06a/5y0ts9SwLfqEaeN/nAarEBme8dS0E8=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 424KRHdH021466
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 4 Mar 2024 14:27:17 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 4
 Mar 2024 14:27:17 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 4 Mar 2024 14:27:17 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 424KRHv6106280;
 Mon, 4 Mar 2024 14:27:17 -0600
Date: Mon, 4 Mar 2024 14:27:17 -0600
From: Bryan Brattlof <bb@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>
CC: Wadim Egorov <w.egorov@phytec.de>, <u-boot@lists.denx.de>, <nm@ti.com>,
 <upstream@lists.phytec.de>
Subject: Re: [PATCH 1/2] arm: mach-k3: am625: copy bootindex to OCRAM for
 main domain SPL
Message-ID: <20240304202717.7ruiozbuzy4bv5iz@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20240226133006.3279993-1-w.egorov@phytec.de>
 <20240226133006.3279993-2-w.egorov@phytec.de>
 <eeda9c00-d7c6-444b-ba77-f70b2f19eb2a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <eeda9c00-d7c6-444b-ba77-f70b2f19eb2a@ti.com>
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

Hey Vignesh!

On March  4, 2024 thus sayeth Vignesh Raghavendra:
> Hi Wadim,
> 
> On 26/02/24 19:00, Wadim Egorov wrote:
> > Texas Instruments has begun enabling security settings on the SoCs it
> > produces to instruct ROM and TIFS to begin protecting the Security
> > Management Subsystem (SMS) from other binaries we load into the chip by
> > default.
> > 
> > One way ROM and TIFS do this is by enabling firewalls to protect the
> > OCSRAM and HSM RAM regions they're using during bootup.
> > 
> > The HSM RAM the wakeup SPL is in is firewalled by TIFS to protect
> > itself from the main domain applications. This means the 'bootindex'
> > value in HSM RAM, left by ROM to indicate if we're using the primary
> > or secondary boot-method, must be moved to OCSRAM (that TIFS has open
> > for us) before we make the jump to the main domain so the main domain's
> > bootloaders can keep access to this information.
> > 
> > Based on commit
> >   b672e8581070 ("arm: mach-k3: copy bootindex to OCRAM for main domain SPL")
> > 
> 
> FYI, this is mostly a problem in non SPL flow (TI prosperity SBL for
> example) where HSM RAM would be used by HSM firmware. This should be a
> issue in R5 SPL flow.  Do you see any issues today? If so, whats the
> TIFS firmware being used?
> 
> > Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> > ---
> >  arch/arm/mach-k3/Kconfig                      |  3 ++-
> >  arch/arm/mach-k3/am625_init.c                 | 15 +++++++++++++--
> >  arch/arm/mach-k3/include/mach/am62_hardware.h | 15 +++++++++++++++
> >  3 files changed, 30 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
> > index 03898424c9..f5d06593f7 100644
> > --- a/arch/arm/mach-k3/Kconfig
> > +++ b/arch/arm/mach-k3/Kconfig
> > @@ -75,7 +75,8 @@ config SYS_K3_BOOT_PARAM_TABLE_INDEX
> >  	default 0x41cffbfc if SOC_K3_J721E
> >  	default 0x41cfdbfc if SOC_K3_J721S2
> >  	default 0x701bebfc if SOC_K3_AM642
> > -	default 0x43c3f290 if SOC_K3_AM625
> > +	default 0x43c3f290 if SOC_K3_AM625 && CPU_V7R
> > +	default 0x7000f290 if SOC_K3_AM625 && ARM64
> >  	default 0x43c3f290 if SOC_K3_AM62A7 && CPU_V7R
> >  	default 0x7000f290 if SOC_K3_AM62A7 && ARM64
> >  	help
> > diff --git a/arch/arm/mach-k3/am625_init.c b/arch/arm/mach-k3/am625_init.c
> > index 6c96e88114..67cf63b103 100644
> > --- a/arch/arm/mach-k3/am625_init.c
> > +++ b/arch/arm/mach-k3/am625_init.c
> > @@ -35,8 +35,10 @@ static struct rom_extended_boot_data bootdata __section(".data");
> >  static void store_boot_info_from_rom(void)
> >  {
> >  	bootindex = *(u32 *)(CONFIG_SYS_K3_BOOT_PARAM_TABLE_INDEX);
> > -	memcpy(&bootdata, (uintptr_t *)ROM_EXTENDED_BOOT_DATA_INFO,
> > -	       sizeof(struct rom_extended_boot_data));
> > +	if (IS_ENABLED(CONFIG_CPU_V7R)) {
> > +		memcpy(&bootdata, (uintptr_t *)ROM_EXTENDED_BOOT_DATA_INFO,
> > +		       sizeof(struct rom_extended_boot_data));
> > +	}
> >  }
> >  
> >  static void ctrl_mmr_unlock(void)
> > @@ -175,6 +177,15 @@ void board_init_f(ulong dummy)
> >  		k3_sysfw_loader(true, NULL, NULL);
> >  	}
> >  
> > +#if defined(CONFIG_CPU_V7R)
> > +	/*
> > +	 * Relocate boot information to OCRAM (after TIFS has opend this
> > +	 * region for us) so the next bootloader stages can keep access to
> > +	 * primary vs backup bootmodes.
> > +	 */
> > +	writel(bootindex, K3_BOOT_PARAM_TABLE_INDEX_OCRAM);
> > +#endif
> > +
> >  	/*
> >  	 * Force probe of clk_k3 driver here to ensure basic default clock
> >  	 * configuration is always done.
> > diff --git a/arch/arm/mach-k3/include/mach/am62_hardware.h b/arch/arm/mach-k3/include/mach/am62_hardware.h
> > index 54380f36e1..9f504f4642 100644
> > --- a/arch/arm/mach-k3/include/mach/am62_hardware.h
> > +++ b/arch/arm/mach-k3/include/mach/am62_hardware.h
> > @@ -76,8 +76,23 @@
> >  #define CTRLMMR_MCU_RST_CTRL			(MCU_CTRL_MMR0_BASE + 0x18170)
> >  
> >  #define ROM_EXTENDED_BOOT_DATA_INFO		0x43c3f1e0
> > +#define K3_BOOT_PARAM_TABLE_INDEX_OCRAM         0x7000F290
> >  
> > +/*
> > + * During the boot process ROM will kill anything that writes to OCSRAM.
> 
> R5 ROM is long gone when R5 SPL starts, how would it kill anything?

Looks like this was based on my patch long ago for the AM62Ax family. 
From what little I remember about this was ROM is leaving behind a 
firewall that we need TIFS's help to bring down for us. So I just
blamed ROM ;)

IDK if this is an issue for the AM62x family though.

> 
> > + * This means the wakeup SPL cannot use this region during boot. To
> > + * complicate things, TIFS will set a firewall between HSM RAM and the
> > + * main domain.
> > + *
> > + * So, during the wakeup SPL, we will need to store the EEPROM data
> > + * somewhere in HSM RAM, and the main domain's SPL will need to store it
> > + * somewhere in OCSRAM
> > + */
> > +#ifdef CONFIG_CPU_V7R
> >  #define TI_SRAM_SCRATCH_BOARD_EEPROM_START	0x43c30000
> > +#else
> > + #define TI_SRAM_SCRATCH_BOARD_EEPROM_START	0x70000001
> 
> Why not  0x70000000 ?

Ah an off by one by me :) 0x70000000 should be fine

> 
> > +#endif /* CONFIG_CPU_V7R */
> >  
> 
> Can't we store directly in OCRAM in both stages? This RAM should be
> accessible post TIFS is up (ie post k3_sysfw_loader() call)

I'll have to double check but I think this should work.

~Bryan
