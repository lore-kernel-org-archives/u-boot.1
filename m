Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAD35C4707B
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 18:34:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 252B587A61;
	Wed, 10 Jan 2024 19:34:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="jeruu7GI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15008876EA; Wed, 10 Jan 2024 19:34:54 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEF3886FBF
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 19:34:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40AIYYjJ033377;
 Wed, 10 Jan 2024 12:34:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1704911674;
 bh=9kJJ69oW+UV4Dwv2urFucZYHAdEJ6r5uBT8VY8/hhR4=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=jeruu7GIrFpRsDktEc49TI2EJQ1M9MZh86wgV8fOwBRYNstxWehZCq1qYW8GoJteY
 P4SdkBFd33Lzaem4Jx2MT4cQHVBAov6y4sksn86WQET2l7QmFKKQcfXmQSMupPla4a
 TVqJMs8jA+cx+Ycogt/XX8dc9gFNfFY8sjrCKMv4=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40AIYYG4029308
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 10 Jan 2024 12:34:34 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 10
 Jan 2024 12:34:34 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 10 Jan 2024 12:34:34 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40AIYYiA109467;
 Wed, 10 Jan 2024 12:34:34 -0600
Date: Wed, 10 Jan 2024 12:34:34 -0600
From: Nishanth Menon <nm@ti.com>
To: Roger Quadros <rogerq@kernel.org>
CC: Tom Rini <trini@konsulko.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Sinthu
 Raja <sinthu.raja@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Heinrich
 Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Andrew Davis <afd@ti.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Nikhil M Jain
 <n-jain1@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Bryan Brattlof
 <bb@ti.com>, Robert Nelson <robertcnelson@gmail.com>,
 <u-boot@lists.denx.de>, Jon Humphreys <j-humphreys@ti.com>
Subject: Re: [PATCH V2 10/10] include: env: ti: Drop default_findfdt
Message-ID: <20240110183434.kj2nc6o6btnztkit@eclipse>
References: <20240109191506.3820908-1-nm@ti.com>
 <20240109191506.3820908-11-nm@ti.com>
 <bca19b42-64fa-442d-9eff-66c1bb6f84ec@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <bca19b42-64fa-442d-9eff-66c1bb6f84ec@kernel.org>
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

On 19:31-20240110, Roger Quadros wrote:
> 
> 
[..]
> FYI. findfdt is still used in:
> 
> am335x_baltos_defconfig:CONFIG_BOOTCOMMAND="run findfdt; run usbboot;run mmcboot;setenv mmcdev 1; setenv bootpart 1:2; run mmcboot;run nandboot;"
> am335x_boneblack_vboot_defconfig:CONFIG_BOOTCOMMAND="run findfdt; run init_console; run finduuid; run distro_bootcmd"
> am335x_evm_defconfig:CONFIG_BOOTCOMMAND="run findfdt; run init_console; run finduuid; run distro_bootcmd"
> am335x_evm_spiboot_defconfig:CONFIG_BOOTCOMMAND="run findfdt; run init_console; run finduuid; run distro_bootcmd"
> am335x_hs_evm_defconfig:CONFIG_BOOTCOMMAND="run findfdt; run init_console; run finduuid; run distro_bootcmd"
> am335x_hs_evm_uart_defconfig:CONFIG_BOOTCOMMAND="run findfdt; run init_console; run finduuid; run distro_bootcmd"
> am335x_igep003x_defconfig:CONFIG_BOOTCOMMAND="run findfdt;run mmcboot;run nandboot;run netboot;"
> am43xx_evm_defconfig:CONFIG_BOOTCOMMAND="run findfdt; run finduuid; run distro_bootcmd"
> am43xx_evm_qspiboot_defconfig:CONFIG_BOOTCOMMAND="run findfdt; run finduuid; run distro_bootcmd"
> am43xx_evm_rtconly_defconfig:CONFIG_BOOTCOMMAND="run findfdt; run finduuid; run distro_bootcmd"
> am43xx_evm_usbhost_boot_defconfig:CONFIG_BOOTCOMMAND="run findfdt; run finduuid; run distro_bootcmd"
> am43xx_hs_evm_defconfig:CONFIG_BOOTCOMMAND="run findfdt; run finduuid; run distro_bootcmd"
> am43xx_hs_evm_qspi_defconfig:CONFIG_BOOTCOMMAND="run findfdt; run finduuid; run distro_bootcmd"
> am57xx_evm_defconfig:CONFIG_BOOTCOMMAND="if test ${dofastboot} -eq 1; then echo Boot fastboot requested, resetting dofastboot ...;setenv dofastboot 0; saveenv;echo Booting into fastboot ...; fastboot 1;fi;if test ${boot_fit} -eq 1; then run update_to_fit;fi;run findfdt; run finduuid; run distro_bootcmd;run emmc_android_boot; "
> am57xx_hs_evm_defconfig:CONFIG_BOOTCOMMAND="if test ${dofastboot} -eq 1; then echo Boot fastboot requested, resetting dofastboot ...;setenv dofastboot 0; saveenv;echo Booting into fastboot ...; fastboot 1;fi;if test ${boot_fit} -eq 1; then run update_to_fit;fi;run findfdt; run finduuid; run distro_bootcmd;run emmc_android_boot; "
> am57xx_hs_evm_usb_defconfig:CONFIG_BOOTCOMMAND="if test ${dofastboot} -eq 1; then echo Boot fastboot requested, resetting dofastboot ...;setenv dofastboot 0; saveenv;echo Booting into fastboot ...; fastboot 1;fi;if test ${boot_fit} -eq 1; then run update_to_fit;fi;run findfdt; run finduuid; run distro_bootcmd;run emmc_android_boot; "
> am65x_evm_a53_defconfig:CONFIG_BOOTCOMMAND="run findfdt; run distro_bootcmd; run init_${boot}; run boot_rprocs; if test ${boot_fit} -eq 1; then run get_fit_${boot}; run get_overlaystring; run run_fit; else; run get_kern_${boot}; run get_fdt_${boot}; run get_overlay_${boot}; run run_kern; fi;"
> dra7xx_evm_defconfig:CONFIG_BOOTCOMMAND="if test ${dofastboot} -eq 1; then echo Boot fastboot requested, resetting dofastboot ...;setenv dofastboot 0; saveenv;echo Booting into fastboot ...; fastboot 1;fi;if test ${boot_fit} -eq 1; then run update_to_fit;fi;run findfdt; run finduuid; run distro_bootcmd;run emmc_android_boot; "
> dra7xx_hs_evm_defconfig:CONFIG_BOOTCOMMAND="if test ${dofastboot} -eq 1; then echo Boot fastboot requested, resetting dofastboot ...;setenv dofastboot 0; saveenv;echo Booting into fastboot ...; fastboot 1;fi;if test ${boot_fit} -eq 1; then run update_to_fit;fi;run findfdt; run finduuid; run distro_bootcmd;run emmc_android_boot; "
> dra7xx_hs_evm_usb_defconfig:CONFIG_BOOTCOMMAND="if test ${dofastboot} -eq 1; then echo Boot fastboot requested, resetting dofastboot ...;setenv dofastboot 0; saveenv;echo Booting into fastboot ...; fastboot 1;fi;if test ${boot_fit} -eq 1; then run update_to_fit;fi;run findfdt; run finduuid; run distro_bootcmd;run emmc_android_boot; "
> k2g_evm_defconfig:CONFIG_BOOTCOMMAND="run findfdt; run envboot; run init_${boot}; run get_mon_${boot} run_mon; run set_name_pmmc get_pmmc_${boot} run_pmmc; run get_kern_${boot}; run init_fw_rd_${boot}; run get_fdt_${boot}; run run_kern"
> k2g_hs_evm_defconfig:CONFIG_BOOTCOMMAND="run findfdt; run envboot; run run_mon_hs; run init_${boot}; run get_fit_${boot}; bootm ${addr_fit}#${name_fdt}"
> omap3_beagle_defconfig:CONFIG_BOOTCOMMAND="run findfdt; run distro_bootcmd"
> omap4_panda_defconfig:CONFIG_BOOTCOMMAND="if test ${boot_fit} -eq 1; then run update_to_fit; fi; run findfdt; run init_console; run envboot; run distro_bootcmd"
> omap4_sdp4430_defconfig:CONFIG_BOOTCOMMAND="if test ${boot_fit} -eq 1; then run update_to_fit; fi; run findfdt; run init_console; run envboot; run distro_bootcmd"

Yep - I have not cleaned up OR moved to stdboot any of the older
platforms (pre k3). That said the script that this patch is deleting is
not used anywhere else at this point in the series. So, it is safe to
remove. The existing platforms implement findfdt in many different ways
unfortunately.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
