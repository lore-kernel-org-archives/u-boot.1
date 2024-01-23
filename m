Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92687C47258
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 14:54:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0260D87D3E;
	Tue, 23 Jan 2024 15:51:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="AbNWhqyK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 488C787D51; Tue, 23 Jan 2024 15:51:21 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9914087D49
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 15:51:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-nandan@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40NEp7C4018639;
 Tue, 23 Jan 2024 08:51:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706021467;
 bh=p6mYxuiie7XImkTFkkPZWeLtL6cSf6+/Z2wFUZ44i78=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=AbNWhqyKLKhPJ8nUMapaTGI5VqnlRWoQHaX+kEZrXBFJKiqq4usIWAH+JWOwDEljJ
 cHlIRNombi70B4rfPIE1siLr9p2rdgFiQwx7OGN9kkt8NjItdbub1wlFVJMxLyMOuy
 cgWfTfljG+XZGq8M1mDR7wkgAObz0fQW6XM/2MZU=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40NEp7mx015693
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 23 Jan 2024 08:51:07 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Jan 2024 08:51:06 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Jan 2024 08:51:06 -0600
Received: from [10.24.68.115] (ti.dhcp.ti.com [10.24.68.115] (may be forged))
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40NEp0nh118897; 
 Tue, 23 Jan 2024 08:51:01 -0600
Message-ID: <c5fd33d8-a1be-41e0-974e-7b4c5f80b318@ti.com>
Date: Tue, 23 Jan 2024 20:21:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/16] arm: mach-k3: Add basic support for J784S4 SoC
 definition
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>
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
References: <20240119175043.3904751-1-a-nandan@ti.com>
 <20240119175043.3904751-3-a-nandan@ti.com>
 <20240119193403.kgzt2zcxa55wexr3@skedaddle>
From: Apurva Nandan <a-nandan@ti.com>
In-Reply-To: <20240119193403.kgzt2zcxa55wexr3@skedaddle>
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


On 20/01/24 01:04, Nishanth Menon wrote:
> On 23:20-20240119, Apurva Nandan wrote:
>
> [...]
>
>> +void k3_spl_init(void)
>> +{
>> +	struct udevice *dev;
>> +	int ret;
>> +
>> +	/*
>> +	 * Cannot delay this further as there is a chance that
>> +	 * K3_BOOT_PARAM_TABLE_INDEX can be over written by SPL MALLOC section.
>> +	 */
>> +	store_boot_info_from_rom();
>> +
>> +	/* Make all control module registers accessible */
>> +	ctrl_mmr_unlock();
>> +
>> +	if (IS_ENABLED(CONFIG_CPU_V7R)) {
>> +		disable_linefill_optimization();
>> +		setup_k3_mpu_regions();
>> +	}
>> +
>> +	/* Init DM early */
>> +	ret = spl_early_init();
>> +
>> +	/* Prepare console output */
>> +	preloader_console_init();
>> +
>> +	if (IS_ENABLED(CONFIG_CPU_V7R)) {
>> +		/*
>> +		 * Process pinctrl for the serial0 a.k.a. WKUP_UART0 module and continue
>> +		 * regardless of the result of pinctrl. Do this without probing the
>> +		 * device, but instead by searching the device that would request the
>> +		 * given sequence number if probed. The UART will be used by the system
>> +		 * firmware (SYSFW) image for various purposes and SYSFW depends on us
> Nit pick - there is no SYSFW image anymore - it is either TIFS or DM.
>
>> +		 * to initialize its pin settings.
>> +		 */
>> +		ret = uclass_find_device_by_seq(UCLASS_SERIAL, 0, &dev);
>> +		if (!ret)
>> +			pinctrl_select_state(dev, "default");
>> +
>> +		/*
>> +		 * Load, start up, and configure system controller firmware. Provide
>> +		 * the U-Boot console init function to the SYSFW post-PM configuration
>> +		 * callback hook, effectively switching on (or over) the console
>> +		 * output.
>> +		 */
>> +		k3_sysfw_loader(is_rom_loaded_sysfw(&bootdata), NULL, NULL);
>> +
>> +		if (IS_ENABLED(CONFIG_SPL_CLK_K3)) {
>> +			/*
>> +			 * Force probe of clk_k3 driver here to ensure basic default clock
>> +			 * configuration is always done for enabling PM services.
>> +			 */
>> +			ret = uclass_get_device_by_driver(UCLASS_CLK,
>> +							  DM_DRIVER_GET(ti_clk),
>> +							  &dev);
>> +			if (ret)
>> +				panic("Failed to initialize clk-k3!\n");
>> +		}
>> +
>> +		remove_fwl_configs(cbass_hc_cfg0_fwls, ARRAY_SIZE(cbass_hc_cfg0_fwls));
>> +		remove_fwl_configs(cbass_hc2_fwls, ARRAY_SIZE(cbass_hc2_fwls));
>> +		remove_fwl_configs(cbass_rc_cfg0_fwls, ARRAY_SIZE(cbass_rc_cfg0_fwls));
>> +		remove_fwl_configs(infra_cbass0_fwls, ARRAY_SIZE(infra_cbass0_fwls));
>> +		remove_fwl_configs(mcu_cbass0_fwls, ARRAY_SIZE(mcu_cbass0_fwls));
>> +		remove_fwl_configs(wkup_cbass0_fwls, ARRAY_SIZE(wkup_cbass0_fwls));
>> +		remove_fwl_configs(navss_cbass0_fwls, ARRAY_SIZE(navss_cbass0_fwls));
>> +	}
>> +
>> +	/* Output System Firmware version info */
>> +	k3_sysfw_print_ver();
>> +}
>> +
>> +void k3_mem_init(void)
>> +{
>> +	struct udevice *dev;
>> +	int ret, ctr = 1;
>> +
>> +	if (IS_ENABLED(CONFIG_K3_J721E_DDRSS)) {
>> +		ret = uclass_get_device(UCLASS_RAM, 0, &dev);
>> +		if (ret)
>> +			panic("DRAM 0 init failed: %d\n", ret);
>> +
>> +		while (dev) {
> why loop on dev? is it possible to have ret != 0 and dev = 0?
>
Some variable needs to be used for loop condition, do you want it to be ret?
or maybe you can suggest your idea for this please.
>> +			ret = uclass_next_device_err(&dev);
>> +			if (ret) {
>> +				printf("Initialized %d DRAM controllers\n", ctr);
>> +				break;
>> +			}
>> +			ctr++;
> What is the use of ctr++ ?? please do a limit check for instances.
This is to keep the logic independent of board evm, so that no include 
of EVM config is needed.
ctr is just used to notify user about how many DDR are up during boot, 
else it is not needed.

I can remove the ctr and printf, if you want.

For a limit check, how can we get number of DDR instances on the EVM, I 
don't know, can you please suggest some way?

There is no config that stores this info afaik.

>
> [...]
>
> Next time, please respond to the review comment questions so that I
> know that you have considered and decided something is not necessary
> or something was missed in the new version - for example what happened
> to mmc_stop/restart?
mmc_stop/restart were removed (mentioned in series changelog)

-- 
Regards,
Apurva Nandan,
Texas Instruments.

