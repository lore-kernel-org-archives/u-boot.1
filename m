Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 756F0C47073
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 17:31:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A03F5877C8;
	Wed, 10 Jan 2024 18:31:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CzM6aDMP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54C66878F1; Wed, 10 Jan 2024 18:31:31 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A387F87732
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 18:31:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id CFF4C616D4;
 Wed, 10 Jan 2024 17:31:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4496AC433F1;
 Wed, 10 Jan 2024 17:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1704907886;
 bh=zx12f1na6gxkEqQ3TvtFtoNh3UCf6WYBiy3Bs+8KpX4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=CzM6aDMPlhw4rfZJ7WVl230mbnLPypc2x4k1BQ91/XJixlZmX0sccHRO0UrzC6Uvk
 w4TxdtSBgz5EfF03BxzLrP38b654/coqyskZJbTKNBoiUUIDsXKON8WnKUKvWLkULX
 4C/BgkVu3GbO1ZNE/ywjGf6lG6ze5Ue+JEOhAgHzTfdpeqWOU/vAGqxNzAjfjcRtjh
 cpOEin6N8x78hx2x3TYDQKW/oIq9GiKsed3AYSEc9b6Dac490WTQm3u7w+GOcFt24w
 Z6su1BejhJPHeQ6YXpNMrNyH+WZKRdqaEI6Zhh1qxQm38Z3bOEGNrtM56j9DL2YwyP
 YpoGRM5kwwwMA==
Message-ID: <bca19b42-64fa-442d-9eff-66c1bb6f84ec@kernel.org>
Date: Wed, 10 Jan 2024 19:31:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 10/10] include: env: ti: Drop default_findfdt
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>, Tom Rini <trini@konsulko.com>
Cc: Kamlesh Gurudasani <kamlesh@ti.com>, Sinthu Raja <sinthu.raja@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Andrew Davis <afd@ti.com>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nikhil M Jain <n-jain1@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Bryan Brattlof <bb@ti.com>, Robert Nelson <robertcnelson@gmail.com>,
 u-boot@lists.denx.de, Jon Humphreys <j-humphreys@ti.com>
References: <20240109191506.3820908-1-nm@ti.com>
 <20240109191506.3820908-11-nm@ti.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240109191506.3820908-11-nm@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 09/01/2024 21:15, Nishanth Menon wrote:
> We shouldn't need finfdt anymore. Drop the env script.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> Changes from V1: None.
> 
> V1: https://lore.kernel.org/r/20240108173301.2692332-11-nm@ti.com
>  include/env/ti/default_findfdt.env | 12 ------------
>  1 file changed, 12 deletions(-)
>  delete mode 100644 include/env/ti/default_findfdt.env
> 
> diff --git a/include/env/ti/default_findfdt.env b/include/env/ti/default_findfdt.env
> deleted file mode 100644
> index a2b51dd923bb..000000000000
> --- a/include/env/ti/default_findfdt.env
> +++ /dev/null
> @@ -1,12 +0,0 @@
> -default_device_tree=CONFIG_DEFAULT_DEVICE_TREE
> -default_device_tree_arch=ti
> -#ifdef CONFIG_ARM64
> -findfdt=
> -	setenv name_fdt ${default_device_tree_arch}/${default_device_tree}.dtb;
> -	setenv fdtfile ${name_fdt}
> -#else
> -default_device_tree_subarch=omap
> -findfdt=
> -	setenv name_fdt ${default_device_tree_arch}/${default_device_tree_subarch}/${default_device_tree}.dtb;
> -	setenv fdtfile ${name_fdt}
> -#endif

FYI. findfdt is still used in:

am335x_baltos_defconfig:CONFIG_BOOTCOMMAND="run findfdt; run usbboot;run mmcboot;setenv mmcdev 1; setenv bootpart 1:2; run mmcboot;run nandboot;"
am335x_boneblack_vboot_defconfig:CONFIG_BOOTCOMMAND="run findfdt; run init_console; run finduuid; run distro_bootcmd"
am335x_evm_defconfig:CONFIG_BOOTCOMMAND="run findfdt; run init_console; run finduuid; run distro_bootcmd"
am335x_evm_spiboot_defconfig:CONFIG_BOOTCOMMAND="run findfdt; run init_console; run finduuid; run distro_bootcmd"
am335x_hs_evm_defconfig:CONFIG_BOOTCOMMAND="run findfdt; run init_console; run finduuid; run distro_bootcmd"
am335x_hs_evm_uart_defconfig:CONFIG_BOOTCOMMAND="run findfdt; run init_console; run finduuid; run distro_bootcmd"
am335x_igep003x_defconfig:CONFIG_BOOTCOMMAND="run findfdt;run mmcboot;run nandboot;run netboot;"
am43xx_evm_defconfig:CONFIG_BOOTCOMMAND="run findfdt; run finduuid; run distro_bootcmd"
am43xx_evm_qspiboot_defconfig:CONFIG_BOOTCOMMAND="run findfdt; run finduuid; run distro_bootcmd"
am43xx_evm_rtconly_defconfig:CONFIG_BOOTCOMMAND="run findfdt; run finduuid; run distro_bootcmd"
am43xx_evm_usbhost_boot_defconfig:CONFIG_BOOTCOMMAND="run findfdt; run finduuid; run distro_bootcmd"
am43xx_hs_evm_defconfig:CONFIG_BOOTCOMMAND="run findfdt; run finduuid; run distro_bootcmd"
am43xx_hs_evm_qspi_defconfig:CONFIG_BOOTCOMMAND="run findfdt; run finduuid; run distro_bootcmd"
am57xx_evm_defconfig:CONFIG_BOOTCOMMAND="if test ${dofastboot} -eq 1; then echo Boot fastboot requested, resetting dofastboot ...;setenv dofastboot 0; saveenv;echo Booting into fastboot ...; fastboot 1;fi;if test ${boot_fit} -eq 1; then run update_to_fit;fi;run findfdt; run finduuid; run distro_bootcmd;run emmc_android_boot; "
am57xx_hs_evm_defconfig:CONFIG_BOOTCOMMAND="if test ${dofastboot} -eq 1; then echo Boot fastboot requested, resetting dofastboot ...;setenv dofastboot 0; saveenv;echo Booting into fastboot ...; fastboot 1;fi;if test ${boot_fit} -eq 1; then run update_to_fit;fi;run findfdt; run finduuid; run distro_bootcmd;run emmc_android_boot; "
am57xx_hs_evm_usb_defconfig:CONFIG_BOOTCOMMAND="if test ${dofastboot} -eq 1; then echo Boot fastboot requested, resetting dofastboot ...;setenv dofastboot 0; saveenv;echo Booting into fastboot ...; fastboot 1;fi;if test ${boot_fit} -eq 1; then run update_to_fit;fi;run findfdt; run finduuid; run distro_bootcmd;run emmc_android_boot; "
am65x_evm_a53_defconfig:CONFIG_BOOTCOMMAND="run findfdt; run distro_bootcmd; run init_${boot}; run boot_rprocs; if test ${boot_fit} -eq 1; then run get_fit_${boot}; run get_overlaystring; run run_fit; else; run get_kern_${boot}; run get_fdt_${boot}; run get_overlay_${boot}; run run_kern; fi;"
dra7xx_evm_defconfig:CONFIG_BOOTCOMMAND="if test ${dofastboot} -eq 1; then echo Boot fastboot requested, resetting dofastboot ...;setenv dofastboot 0; saveenv;echo Booting into fastboot ...; fastboot 1;fi;if test ${boot_fit} -eq 1; then run update_to_fit;fi;run findfdt; run finduuid; run distro_bootcmd;run emmc_android_boot; "
dra7xx_hs_evm_defconfig:CONFIG_BOOTCOMMAND="if test ${dofastboot} -eq 1; then echo Boot fastboot requested, resetting dofastboot ...;setenv dofastboot 0; saveenv;echo Booting into fastboot ...; fastboot 1;fi;if test ${boot_fit} -eq 1; then run update_to_fit;fi;run findfdt; run finduuid; run distro_bootcmd;run emmc_android_boot; "
dra7xx_hs_evm_usb_defconfig:CONFIG_BOOTCOMMAND="if test ${dofastboot} -eq 1; then echo Boot fastboot requested, resetting dofastboot ...;setenv dofastboot 0; saveenv;echo Booting into fastboot ...; fastboot 1;fi;if test ${boot_fit} -eq 1; then run update_to_fit;fi;run findfdt; run finduuid; run distro_bootcmd;run emmc_android_boot; "
k2g_evm_defconfig:CONFIG_BOOTCOMMAND="run findfdt; run envboot; run init_${boot}; run get_mon_${boot} run_mon; run set_name_pmmc get_pmmc_${boot} run_pmmc; run get_kern_${boot}; run init_fw_rd_${boot}; run get_fdt_${boot}; run run_kern"
k2g_hs_evm_defconfig:CONFIG_BOOTCOMMAND="run findfdt; run envboot; run run_mon_hs; run init_${boot}; run get_fit_${boot}; bootm ${addr_fit}#${name_fdt}"
omap3_beagle_defconfig:CONFIG_BOOTCOMMAND="run findfdt; run distro_bootcmd"
omap4_panda_defconfig:CONFIG_BOOTCOMMAND="if test ${boot_fit} -eq 1; then run update_to_fit; fi; run findfdt; run init_console; run envboot; run distro_bootcmd"
omap4_sdp4430_defconfig:CONFIG_BOOTCOMMAND="if test ${boot_fit} -eq 1; then run update_to_fit; fi; run findfdt; run init_console; run envboot; run distro_bootcmd"

-- 
cheers,
-roger
