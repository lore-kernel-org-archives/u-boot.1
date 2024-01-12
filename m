Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C31E3C4707C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 21:27:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 713D0879DA;
	Fri, 12 Jan 2024 22:26:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="paTN+DyA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BF97875FA; Fri, 12 Jan 2024 22:15:37 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EB7C87831
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 22:15:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40CLFP2k070698;
 Fri, 12 Jan 2024 15:15:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1705094125;
 bh=4Jp/yULRvCYkSXPwwBF2Lc0PIP6XQAgFwERbV4TYOTc=;
 h=From:To:CC:Subject:In-Reply-To:References:Date;
 b=paTN+DyAvqNBXFbi6+y+ixShwrm0kk45AGAj65VIU6qljB1d//FvQ/thTMQcYKyAl
 rVifYaZOCyzdpaD7/YbMDzX3Ngz2qkGY3eYN98NHpAA5lrn/u/a8FcKfLuT3Rk7j81
 EBqNDfbOsJyCcsnBo9jT40X1UkVb0+odsdBohkg0=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40CLFPFD007224
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 12 Jan 2024 15:15:25 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 12
 Jan 2024 15:15:25 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 12 Jan 2024 15:15:25 -0600
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40CLFP5C062093;
 Fri, 12 Jan 2024 15:15:25 -0600
From: Jon Humphreys <j-humphreys@ti.com>
To: Nishanth Menon <nm@ti.com>, Tom Rini <trini@konsulko.com>
CC: Kamlesh Gurudasani <kamlesh@ti.com>, Sinthu Raja <sinthu.raja@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Roger Quadros <rogerq@kernel.org>, Simon Glass
 <sjg@chromium.org>, Andrew Davis <afd@ti.com>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Nikhil M Jain <n-jain1@ti.com>, "Manorit
 Chawdhry" <m-chawdhry@ti.com>, Bryan Brattlof <bb@ti.com>, Robert Nelson
 <robertcnelson@gmail.com>, <u-boot@lists.denx.de>,
 Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH V2 08/10] board: beagle: beagleboneai64: Set fdtfile
 from C code instead of findfdt script
In-Reply-To: <20240109191506.3820908-9-nm@ti.com>
References: <20240109191506.3820908-1-nm@ti.com>
 <20240109191506.3820908-9-nm@ti.com>
Date: Fri, 12 Jan 2024 15:15:25 -0600
Message-ID: <86jzoeckya.fsf@udb0321960.dhcp.ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Fri, 12 Jan 2024 22:26:42 +0100
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

Nishanth Menon <nm@ti.com> writes:

> Stop using the findfdt script and switch to setting the fdtfile from C
> code.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> Changes from V1:
> * Just macro name change s/TI_EVM_FDT_FOLDER_PATH/TI_FDT_FOLDER_PATH
> * Commit message update to drop the "warning added to findfdt" since
>   that is not done.
>
> I have retained the explicit setting of fdtfile to remove dependency on
> TI evm specific logic. Also, the dynamic population of fdtfile instead
> of env_set("fdtfile", "ti/k3-j721e-beagleboneai64.dtb") to allow for the
> upcoming board variants to be able to  configure the dtb name via a
> config fragment.
>
> V1: https://lore.kernel.org/r/20240108173301.2692332-9-nm@ti.com
>  board/beagle/beagleboneai64/beagleboneai64.c   | 14 ++++++++++++++
>  board/beagle/beagleboneai64/beagleboneai64.env |  1 -
>  configs/j721e_beagleboneai64_a72_defconfig     |  3 ++-
>  3 files changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/board/beagle/beagleboneai64/beagleboneai64.c b/board/beagle/beagleboneai64/beagleboneai64.c
> index c8c1c78ae5a2..c5b4ff7df47a 100644
> --- a/board/beagle/beagleboneai64/beagleboneai64.c
> +++ b/board/beagle/beagleboneai64/beagleboneai64.c
> @@ -28,3 +28,17 @@ int dram_init_banksize(void)
>  {
>  	return fdtdec_setup_memory_banksize();
>  }
> +
> +#ifdef CONFIG_BOARD_LATE_INIT
> +int board_late_init(void)
> +{
> +	char fdtfile[50];
> +
> +	snprintf(fdtfile, sizeof(fdtfile), "%s/%s.dtb",
> +		 CONFIG_TI_FDT_FOLDER_PATH, CONFIG_DEFAULT_DEVICE_TREE);
> +
> +	env_set("fdtfile", fdtfile);
> +
> +	return 0;
> +}
> +#endif
> diff --git a/board/beagle/beagleboneai64/beagleboneai64.env b/board/beagle/beagleboneai64/beagleboneai64.env
> index 4f0a94a8113e..647b25d14c8e 100644
> --- a/board/beagle/beagleboneai64/beagleboneai64.env
> +++ b/board/beagle/beagleboneai64/beagleboneai64.env
> @@ -1,5 +1,4 @@
>  #include <env/ti/ti_common.env>
> -#include <env/ti/default_findfdt.env>
>  #include <env/ti/mmc.env>
>  
>  name_kern=Image
> diff --git a/configs/j721e_beagleboneai64_a72_defconfig b/configs/j721e_beagleboneai64_a72_defconfig
> index 959f86844d32..9e53658eacb9 100644
> --- a/configs/j721e_beagleboneai64_a72_defconfig
> +++ b/configs/j721e_beagleboneai64_a72_defconfig
> @@ -34,7 +34,8 @@ CONFIG_AUTOBOOT_PROMPT="Press SPACE to abort autoboot in %d seconds\n"
>  CONFIG_AUTOBOOT_DELAY_STR="d"
>  CONFIG_AUTOBOOT_STOP_STR=" "
>  CONFIG_OF_SYSTEM_SETUP=y
> -CONFIG_BOOTCOMMAND="run set_led_state_start_load;run findfdt; run envboot; bootflow scan -lb;run set_led_state_fail_load"
> +CONFIG_BOOTCOMMAND="run set_led_state_start_load; run envboot; bootflow scan -lb;run set_led_state_fail_load"
> +CONFIG_BOARD_LATE_INIT=y
>  CONFIG_LOGLEVEL=7
>  CONFIG_SPL_MAX_SIZE=0xc0000
>  CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> -- 
> 2.43.0

Reviewed-by: Jonathan Humphreys <j-humphreys@ti.com>
