Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B9C3C3DA6E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 19:00:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81AC687A4B;
	Mon,  8 Jan 2024 20:00:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="oP4pVwxp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAE0E87A77; Mon,  8 Jan 2024 20:00:45 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9418086D37
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 20:00:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 408J0ICC006386;
 Mon, 8 Jan 2024 13:00:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1704740418;
 bh=8sl0DCLX+l5H5SR/KoYRcCEN3kAvS1R+UAgL+78YSAU=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=oP4pVwxpPpWBHeG6k5OT9oOIZC3pkPf90E1q5HpZR/df+FtDWADwIZwUVZyNOY3Xs
 cAIwdZb+qzs68OzAxJMGxfU4uVg6Vp8R8zZpDSkA+trEbxIJhquyFiRdVMQCEKvg9G
 nW+E11tJx8qXLjLqy2b1KCAoeZsUvPu/kNR+YqVk=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 408J0Hb4013144
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 8 Jan 2024 13:00:18 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 8
 Jan 2024 13:00:17 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 8 Jan 2024 13:00:17 -0600
Received: from [10.249.40.136] ([10.249.40.136])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 408J0Goh023814;
 Mon, 8 Jan 2024 13:00:16 -0600
Message-ID: <f94817a7-b81a-479b-bef2-2c255c4e0f1d@ti.com>
Date: Mon, 8 Jan 2024 13:00:16 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] board: beagle: beagleboneai64: Set fdtfile from C
 code instead of findfdt script
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>, Tom Rini <trini@konsulko.com>
CC: Kamlesh Gurudasani <kamlesh@ti.com>, Sinthu Raja <sinthu.raja@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Roger Quadros <rogerq@kernel.org>, Simon Glass
 <sjg@chromium.org>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nikhil M Jain <n-jain1@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Bryan Brattlof <bb@ti.com>, Robert Nelson <robertcnelson@gmail.com>,
 <u-boot@lists.denx.de>, Jon Humphreys <j-humphreys@ti.com>
References: <20240108173301.2692332-1-nm@ti.com>
 <20240108173301.2692332-9-nm@ti.com>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240108173301.2692332-9-nm@ti.com>
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

On 1/8/24 11:32 AM, Nishanth Menon wrote:
> Stop using the findfdt script and switch to setting the fdtfile from C
> code.
> 
> While at this, replace findfdt in environment with a warning as it is
> no longer needed
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>   board/beagle/beagleboneai64/beagleboneai64.c   | 14 ++++++++++++++
>   board/beagle/beagleboneai64/beagleboneai64.env |  1 -
>   configs/j721e_beagleboneai64_a72_defconfig     |  3 ++-
>   3 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/board/beagle/beagleboneai64/beagleboneai64.c b/board/beagle/beagleboneai64/beagleboneai64.c
> index c8c1c78ae5a2..1982f738b04e 100644
> --- a/board/beagle/beagleboneai64/beagleboneai64.c
> +++ b/board/beagle/beagleboneai64/beagleboneai64.c
> @@ -28,3 +28,17 @@ int dram_init_banksize(void)
>   {
>   	return fdtdec_setup_memory_banksize();
>   }
> +
> +#ifdef CONFIG_BOARD_LATE_INIT
> +int board_late_init(void)
> +{
> +	char fdtfile[50];
> +
> +	snprintf(fdtfile, sizeof(fdtfile), "%s/%s.dtb",
> +		 CONFIG_TI_EVM_FDT_FOLDER_PATH, CONFIG_DEFAULT_DEVICE_TREE);
> +

Why not use your new ti_set_fdt_env() helper? It makes this board
consistent with TI boards (sets "name_fdt" and adds warning for
"findfdt" like your commit message says you do..).

Andrew

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
>   #include <env/ti/ti_common.env>
> -#include <env/ti/default_findfdt.env>
>   #include <env/ti/mmc.env>
>   
>   name_kern=Image
> diff --git a/configs/j721e_beagleboneai64_a72_defconfig b/configs/j721e_beagleboneai64_a72_defconfig
> index 959f86844d32..9e53658eacb9 100644
> --- a/configs/j721e_beagleboneai64_a72_defconfig
> +++ b/configs/j721e_beagleboneai64_a72_defconfig
> @@ -34,7 +34,8 @@ CONFIG_AUTOBOOT_PROMPT="Press SPACE to abort autoboot in %d seconds\n"
>   CONFIG_AUTOBOOT_DELAY_STR="d"
>   CONFIG_AUTOBOOT_STOP_STR=" "
>   CONFIG_OF_SYSTEM_SETUP=y
> -CONFIG_BOOTCOMMAND="run set_led_state_start_load;run findfdt; run envboot; bootflow scan -lb;run set_led_state_fail_load"
> +CONFIG_BOOTCOMMAND="run set_led_state_start_load; run envboot; bootflow scan -lb;run set_led_state_fail_load"
> +CONFIG_BOARD_LATE_INIT=y
>   CONFIG_LOGLEVEL=7
>   CONFIG_SPL_MAX_SIZE=0xc0000
>   CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
