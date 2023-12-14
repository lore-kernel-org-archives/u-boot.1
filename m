Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71B53C4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 02:30:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1525878C2;
	Thu, 14 Dec 2023 03:30:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="sS9p/rJP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDAAB8799B; Thu, 14 Dec 2023 03:30:17 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92BCE87808
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 03:30:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BE2Tw5o083374;
 Wed, 13 Dec 2023 20:29:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1702520998;
 bh=tx8COOmodkY8D4ok3sHL1Wojbcx12NHfo42PerO73UA=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=sS9p/rJPk/skBm6+h3xtyTN+RIcUAFBtHiDxSbnkt1+8xeYiTPccDNaDPXlM7H4Hi
 ocbNSQ2W04VMbSGR9Xlk1Y/1VoPffqtGZpepuAL6KLZck/4ITsprjP9MGwGUEYWvJR
 IJFomLNluitxcKmeZWMwwrBlH9tZavvXgIQ0X+aI=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BE2TwRx083773
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 13 Dec 2023 20:29:58 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 13
 Dec 2023 20:29:58 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 13 Dec 2023 20:29:58 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BE2Tvpe029843;
 Wed, 13 Dec 2023 20:29:57 -0600
Date: Wed, 13 Dec 2023 20:29:57 -0600
From: Bryan Brattlof <bb@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>
CC: Apurva Nandan <a-nandan@ti.com>, Hari Nagalla <hnagalla@ti.com>, Lukasz
 Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>, Andrew Davis
 <afd@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Dasnavis Sabiya
 <sabiya.d@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Aradhya Bhatia
 <a-bhatia1@ti.com>, Christian Gmeiner <christian.gmeiner@gmail.com>,
 Nishanth Menon <nm@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Roger Quadros <rogerq@kernel.org>, Jayesh Choudhary <j-choudhary@ti.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, <u-boot@lists.denx.de>, Sinthu Raja M
 <sinthu.raja@mistralsolutions.com>, Udit Kumar <u-kumar1@ti.com>
Subject: Re: [PATCH v6 03/17] arm: mach-k3: Add basic support for J784S4 SoC
 definition
Message-ID: <20231214022957.osbtyza473rjrcxa@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20231206123753.1486031-1-a-nandan@ti.com>
 <20231206123753.1486031-4-a-nandan@ti.com>
 <1ffc84ba-a7db-4b63-9fd9-03ff04a8a1ad@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <1ffc84ba-a7db-4b63-9fd9-03ff04a8a1ad@ti.com>
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

On December  7, 2023 thus sayeth Neha Malcom Francis:
> Hi Apurva,
> 
> On 06/12/23 18:07, Apurva Nandan wrote:
> > Add J784S4 initialization files for initial SPL boot.
> > 
> > Signed-off-by: Hari Nagalla <hnagalla@ti.com>
> > [ add firewall configurations and change the R5 MCU scratchpad ]
> > Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> > Signed-off-by: Dasnavis Sabiya <sabiya.d@ti.com>
> > Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> > ---
> >   arch/arm/mach-k3/Kconfig                      |  16 +-
> >   arch/arm/mach-k3/Makefile                     |   2 +
> >   arch/arm/mach-k3/arm64-mmu.c                  |  52 +++
> >   arch/arm/mach-k3/include/mach/hardware.h      |   4 +
> >   .../mach-k3/include/mach/j784s4_hardware.h    |  60 ++++
> >   arch/arm/mach-k3/include/mach/j784s4_spl.h    |  47 +++
> >   arch/arm/mach-k3/include/mach/spl.h           |   4 +
> >   arch/arm/mach-k3/j784s4_fdt.c                 |  15 +
> >   arch/arm/mach-k3/j784s4_init.c                | 335 ++++++++++++++++++
> >   arch/arm/mach-k3/r5/Makefile                  |   1 +
> >   10 files changed, 529 insertions(+), 7 deletions(-)
> >   create mode 100644 arch/arm/mach-k3/include/mach/j784s4_hardware.h
> >   create mode 100644 arch/arm/mach-k3/include/mach/j784s4_spl.h
> >   create mode 100644 arch/arm/mach-k3/j784s4_fdt.c
> >   create mode 100644 arch/arm/mach-k3/j784s4_init.c
> > 

...

> > +
> > +void k3_mmc_stop_clock(void)
> > +{
> > +	if (IS_ENABLED(CONFIG_K3_LOAD_SYSFW)) {
> > +		if (spl_boot_device() == BOOT_DEVICE_MMC1) {
> > +			struct mmc *mmc = find_mmc_device(0);
> > +
> > +			if (!mmc)
> > +				return;
> > +
> > +			mmc->saved_clock = mmc->clock;
> > +			mmc_set_clock(mmc, 0, true);
> > +		}
> > +	}
> > +}
> > +
> > +void k3_mmc_restart_clock(void)
> > +{
> > +	if (IS_ENABLED(CONFIG_K3_LOAD_SYSFW)) {
> > +		if (spl_boot_device() == BOOT_DEVICE_MMC1) {
> > +			struct mmc *mmc = find_mmc_device(0);
> > +
> > +			if (!mmc)
> > +				return;
> > +
> > +			mmc_set_clock(mmc, mmc->saved_clock, false);
> > +		}
> > +	}
> > +}

...

> > +void board_init_f(ulong dummy)
> > +{
> > +	struct udevice *dev;
> > +	int ret, ctr = 1;
> > +
> > +	/*
> > +	 * Cannot delay this further as there is a chance that
> > +	 * K3_BOOT_PARAM_TABLE_INDEX can be over written by SPL MALLOC section.
> > +	 */
> > +	store_boot_info_from_rom();
> > +
> > +	/* Make all control module registers accessible */
> > +	ctrl_mmr_unlock();
> > +
> > +	if (IS_ENABLED(CONFIG_CPU_V7R)) {
> > +		disable_linefill_optimization();
> > +		setup_k3_mpu_regions();
> > +	}
> > +
> > +	/* Init DM early */
> > +	ret = spl_early_init();
> > +
> > +	/* Prepare console output */
> > +	preloader_console_init();
> > +
> > +	if (IS_ENABLED(CONFIG_K3_LOAD_SYSFW)) {
> > +		/*
> > +		 * Process pinctrl for the serial0 a.k.a. WKUP_UART0 module and continue
> > +		 * regardless of the result of pinctrl. Do this without probing the
> > +		 * device, but instead by searching the device that would request the
> > +		 * given sequence number if probed. The UART will be used by the system
> > +		 * firmware (SYSFW) image for various purposes and SYSFW depends on us
> > +		 * to initialize its pin settings.
> > +		 */
> > +		ret = uclass_find_device_by_seq(UCLASS_SERIAL, 0, &dev);
> > +		if (!ret)
> > +			pinctrl_select_state(dev, "default");
> > +
> > +		/*
> > +		 * Load, start up, and configure system controller firmware. Provide
> > +		 * the U-Boot console init function to the SYSFW post-PM configuration
> > +		 * callback hook, effectively switching on (or over) the console
> > +		 * output.
> > +		 */
> > +		k3_sysfw_loader(is_rom_loaded_sysfw(&bootdata),
> > +				k3_mmc_stop_clock, k3_mmc_restart_clock);
> > +
> 
> All these K3 specific code, should we push it out to a separate function
> like J721S2? (commit fca27ee8b993bd1a5752fc2156b1e86358fa8041 "arch:
> mach-k3: Update board specific API name to K3 generic API name")
> 
> Else we can take this up in a separate clean up series.
>

Do we still have a need to support the split binary (sysfw.itb) boot
anymore now that binman is building tiboot3 for us? I don't think we 
will ever be in a situation where ROM hasn't loaded the firmware for us.

> > +#ifdef CONFIG_SPL_OF_LIST
> > +		if (IS_ENABLED(CONFIG_TI_I2C_BOARD_DETECT))
> > +			do_board_detect();
> > +#endif
> > +

Should we tie CONFIG_SPL_OF_LIST and CONFIG_TI_I2C_BOARD_DETECT together 
in Kconfig to avoid this?

> > +		if (IS_ENABLED(CONFIG_SPL_CLK_K3)) {
> > +			/*
> > +			 * Force probe of clk_k3 driver here to ensure basic default clock
> > +			 * configuration is always done for enabling PM services.
> > +			 */
> > +			ret = uclass_get_device_by_driver(UCLASS_CLK,
> > +							  DM_DRIVER_GET(ti_clk),
> > +							  &dev);
> > +			if (ret)
> > +				panic("Failed to initialize clk-k3!\n");
> > +		}
> > +
> > +		remove_fwl_configs(cbass_hc_cfg0_fwls, ARRAY_SIZE(cbass_hc_cfg0_fwls));
> > +		remove_fwl_configs(cbass_hc2_fwls, ARRAY_SIZE(cbass_hc2_fwls));
> > +		remove_fwl_configs(cbass_rc_cfg0_fwls, ARRAY_SIZE(cbass_rc_cfg0_fwls));
> > +		remove_fwl_configs(infra_cbass0_fwls, ARRAY_SIZE(infra_cbass0_fwls));
> > +		remove_fwl_configs(mcu_cbass0_fwls, ARRAY_SIZE(mcu_cbass0_fwls));
> > +		remove_fwl_configs(wkup_cbass0_fwls, ARRAY_SIZE(wkup_cbass0_fwls));
> > +		remove_fwl_configs(navss_cbass0_fwls, ARRAY_SIZE(navss_cbass0_fwls));
> > +	}
> > +
> > +	/* Output System Firmware version info */
> > +	k3_sysfw_print_ver();
> > +
> > +	if (IS_ENABLED(CONFIG_TARGET_J784S4_R5_EVM)) {
> > +		ret = uclass_get_device_by_name(UCLASS_MISC, "msmc", &dev);
> > +		if (ret)
> > +			panic("Probe of msmc failed: %d\n", ret);
> > +
> > +		ret = uclass_get_device(UCLASS_RAM, 0, &dev);
> > +		if (ret)
> > +			panic("DRAM 0 init failed: %d\n", ret);
> > +
> > +		while (dev) {
> > +			ret = uclass_next_device_err(&dev);
> > +			if (ret) {
> > +				printf("Initialized %d DRAM controllers\n", ctr);
> > +				break;
> > +			}
> > +			ctr++;

Nice! However I'm worried we miss events with controllers that we wanted 
and failed to probe. Should we invert this check?

The uclass_foreach_dev() macro could help here too, but I don't see that 
used very much. There may be a better idea i'm missing

> 
> This looks fine. With the above comment addressed or not:
> Reviewed-by: Neha Malcom Francis <n-francis@ti.com>
>

~Bryan
