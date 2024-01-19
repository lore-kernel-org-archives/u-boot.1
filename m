Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CF82C4725D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 19:34:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76EE287CB2;
	Fri, 19 Jan 2024 20:34:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="sXTRSbg7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4618B87CB2; Fri, 19 Jan 2024 20:34:16 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B879E87BA2
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 20:34:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40JJY3la117270;
 Fri, 19 Jan 2024 13:34:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1705692843;
 bh=PX4H7tGlrqw0iQ3DOLbUd9JatGw+ViSWhlZZ6Yun5RU=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=sXTRSbg7oL30nURJs9EUI5+v3eeRSprkocWnxl7qdkGiWxp302T8EGe2H1ovnPOca
 q1Cumt2HrEB2LjmyKD5/Uh4TLtr/AzIy3MY6cbcvOU9owLCThjyWzz/C7BnDR7isfw
 EOpXYbMf4LqKLaa6T6raptr7CL7tut8tyKhIw3Pk=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40JJY3Ye097713
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 19 Jan 2024 13:34:03 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 19
 Jan 2024 13:34:03 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 19 Jan 2024 13:34:03 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40JJY31R067854;
 Fri, 19 Jan 2024 13:34:03 -0600
Date: Fri, 19 Jan 2024 13:34:03 -0600
From: Nishanth Menon <nm@ti.com>
To: Apurva Nandan <a-nandan@ti.com>
CC: Hari Nagalla <hnagalla@ti.com>, Lukasz Majewski <lukma@denx.de>, Sean
 Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Neha
 Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>, Andrew
 Davis <afd@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Dasnavis Sabiya
 <sabiya.d@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Aradhya Bhatia
 <a-bhatia1@ti.com>, Bryan Brattlof <bb@ti.com>, Christian Gmeiner
 <christian.gmeiner@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Roger Quadros
 <rogerq@kernel.org>, Jayesh Choudhary <j-choudhary@ti.com>, Ralph Siemsen
 <ralph.siemsen@linaro.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, <u-boot@lists.denx.de>,
 Sinthu Raja M <sinthu.raja@mistralsolutions.com>,
 Udit Kumar <u-kumar1@ti.com>
Subject: Re: [PATCH v8 02/16] arm: mach-k3: Add basic support for J784S4 SoC
 definition
Message-ID: <20240119193403.kgzt2zcxa55wexr3@skedaddle>
References: <20240119175043.3904751-1-a-nandan@ti.com>
 <20240119175043.3904751-3-a-nandan@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240119175043.3904751-3-a-nandan@ti.com>
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

On 23:20-20240119, Apurva Nandan wrote:

[...]

> +void k3_spl_init(void)
> +{
> +	struct udevice *dev;
> +	int ret;
> +
> +	/*
> +	 * Cannot delay this further as there is a chance that
> +	 * K3_BOOT_PARAM_TABLE_INDEX can be over written by SPL MALLOC section.
> +	 */
> +	store_boot_info_from_rom();
> +
> +	/* Make all control module registers accessible */
> +	ctrl_mmr_unlock();
> +
> +	if (IS_ENABLED(CONFIG_CPU_V7R)) {
> +		disable_linefill_optimization();
> +		setup_k3_mpu_regions();
> +	}
> +
> +	/* Init DM early */
> +	ret = spl_early_init();
> +
> +	/* Prepare console output */
> +	preloader_console_init();
> +
> +	if (IS_ENABLED(CONFIG_CPU_V7R)) {
> +		/*
> +		 * Process pinctrl for the serial0 a.k.a. WKUP_UART0 module and continue
> +		 * regardless of the result of pinctrl. Do this without probing the
> +		 * device, but instead by searching the device that would request the
> +		 * given sequence number if probed. The UART will be used by the system
> +		 * firmware (SYSFW) image for various purposes and SYSFW depends on us

Nit pick - there is no SYSFW image anymore - it is either TIFS or DM.

> +		 * to initialize its pin settings.
> +		 */
> +		ret = uclass_find_device_by_seq(UCLASS_SERIAL, 0, &dev);
> +		if (!ret)
> +			pinctrl_select_state(dev, "default");
> +
> +		/*
> +		 * Load, start up, and configure system controller firmware. Provide
> +		 * the U-Boot console init function to the SYSFW post-PM configuration
> +		 * callback hook, effectively switching on (or over) the console
> +		 * output.
> +		 */
> +		k3_sysfw_loader(is_rom_loaded_sysfw(&bootdata), NULL, NULL);
> +
> +		if (IS_ENABLED(CONFIG_SPL_CLK_K3)) {
> +			/*
> +			 * Force probe of clk_k3 driver here to ensure basic default clock
> +			 * configuration is always done for enabling PM services.
> +			 */
> +			ret = uclass_get_device_by_driver(UCLASS_CLK,
> +							  DM_DRIVER_GET(ti_clk),
> +							  &dev);
> +			if (ret)
> +				panic("Failed to initialize clk-k3!\n");
> +		}
> +
> +		remove_fwl_configs(cbass_hc_cfg0_fwls, ARRAY_SIZE(cbass_hc_cfg0_fwls));
> +		remove_fwl_configs(cbass_hc2_fwls, ARRAY_SIZE(cbass_hc2_fwls));
> +		remove_fwl_configs(cbass_rc_cfg0_fwls, ARRAY_SIZE(cbass_rc_cfg0_fwls));
> +		remove_fwl_configs(infra_cbass0_fwls, ARRAY_SIZE(infra_cbass0_fwls));
> +		remove_fwl_configs(mcu_cbass0_fwls, ARRAY_SIZE(mcu_cbass0_fwls));
> +		remove_fwl_configs(wkup_cbass0_fwls, ARRAY_SIZE(wkup_cbass0_fwls));
> +		remove_fwl_configs(navss_cbass0_fwls, ARRAY_SIZE(navss_cbass0_fwls));
> +	}
> +
> +	/* Output System Firmware version info */
> +	k3_sysfw_print_ver();
> +}
> +
> +void k3_mem_init(void)
> +{
> +	struct udevice *dev;
> +	int ret, ctr = 1;
> +
> +	if (IS_ENABLED(CONFIG_K3_J721E_DDRSS)) {
> +		ret = uclass_get_device(UCLASS_RAM, 0, &dev);
> +		if (ret)
> +			panic("DRAM 0 init failed: %d\n", ret);
> +
> +		while (dev) {
why loop on dev? is it possible to have ret != 0 and dev = 0?

> +			ret = uclass_next_device_err(&dev);
> +			if (ret) {
> +				printf("Initialized %d DRAM controllers\n", ctr);
> +				break;
> +			}
> +			ctr++;

What is the use of ctr++ ?? please do a limit check for instances.

[...]

Next time, please respond to the review comment questions so that I
know that you have considered and decided something is not necessary
or something was missed in the new version - for example what happened
to mmc_stop/restart?

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
