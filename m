Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64DE1CCF9E0
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 18:08:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DA3583890;
	Mon, 27 Oct 2025 19:08:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="xiRYSZOx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 554EE838BF; Mon, 27 Oct 2025 19:08:46 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57DE28384E
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 19:08:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59RI8bHS2481540;
 Mon, 27 Oct 2025 13:08:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1761588517;
 bh=8Z0w0NvVgrped+xFXBauc57wRdDtng9givE5vKPYyrM=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=xiRYSZOxjPE4SDbcY5BeDFBGYhYrhu0x03LKr1/ByygCuzyBO1/cYSegns58RpPdB
 fVbpiZ5q/SMVmWsxicu6HxnN9Xq4jWwT1xld4xGu3n+LyQlz0WHQSR1cRo0kVivouA
 xP39jLJMSkv+B8BX+DTkSRZXniysksCmuRBRMde8=
Received: from DFLE212.ent.ti.com (dfle212.ent.ti.com [10.64.6.70])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59RI8b781823060
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 27 Oct 2025 13:08:37 -0500
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Oct
 2025 13:08:37 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 27 Oct 2025 13:08:37 -0500
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59RI8aYn1080614;
 Mon, 27 Oct 2025 13:08:36 -0500
Message-ID: <8127d3c6-3b1e-4e8c-9ae5-efd7740cc54c@ti.com>
Date: Mon, 27 Oct 2025 13:08:36 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] board: am62x: Add support for reading eeprom data
To: "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>,
 <u-boot@lists.denx.de>, Anshul Dalal <anshuld@ti.com>, Bryan Brattlof
 <bb@ti.com>
CC: Tom Rini <trini@konsulko.com>, Garrett Giordano <ggiordano@phytec.com>,
 Wadim Egorov <w.egorov@phytec.de>, Neha Malcom Francis <n-francis@ti.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Santhosh Kumar K <s-k6@ti.com>, "Jonathan
 Humphreys" <j-humphreys@ti.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Devarsh Thakkar <devarsht@ti.com>,
 Prasanth Babu Mantena <p-mantena@ti.com>, Judith Mendez <jm@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Dhruva Gole <d-gole@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, "Neil
 Armstrong" <neil.armstrong@linaro.org>,
 Aashvij Shenai <a-shenai@ti.com>, "Peng Fan" <peng.fan@nxp.com>
References: <20251024-am62xeeprom-v2-0-0e372347e7d4@baylibre.com>
 <20251024-am62xeeprom-v2-2-0e372347e7d4@baylibre.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20251024-am62xeeprom-v2-2-0e372347e7d4@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

On 10/24/25 9:17 AM, Guillaume La Roque (TI.com) wrote:
> I2C EEPROM data contains the board name and its revision.
> Add support for:
> - Reading EEPROM data and store a copy at end of SRAM
> - Updating env variable with relevant board info
> - Printing board info during boot
> 
> Use the generic do_board_detect_am6() and setup_serial_am6()
> functions to avoid code duplication across AM6x family boards.
> 
> Signed-off-by: Guillaume La Roque (TI.com) <glaroque@baylibre.com>
> ---
>   arch/arm/mach-k3/am62x/Kconfig |  3 +++
>   board/ti/am62x/evm.c           | 54 +++++++++++++++++++++++++++++++++++++++++-
>   configs/am62x_evm_r5_defconfig |  1 +
>   3 files changed, 57 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-k3/am62x/Kconfig b/arch/arm/mach-k3/am62x/Kconfig
> index 81199ada3a1..f7ad52db7d8 100644
> --- a/arch/arm/mach-k3/am62x/Kconfig
> +++ b/arch/arm/mach-k3/am62x/Kconfig
> @@ -14,6 +14,8 @@ config TARGET_AM625_A53_EVM
>   	select ARM64
>   	select BINMAN
>   	select OF_SYSTEM_SETUP
> +	imply TI_COMMON_CMD_OPTIONS
> +	imply TI_I2C_BOARD_DETECT
>   
>   config TARGET_AM625_R5_EVM
>   	bool "TI K3 based AM625 EVM running on R5"
> @@ -25,6 +27,7 @@ config TARGET_AM625_R5_EVM
>   	select K3_DDRSS
>   	select BINMAN
>   	imply SYS_K3_SPL_ATF
> +	imply TI_I2C_BOARD_DETECT
>   
>   config TARGET_PHYCORE_AM62X_A53
>   	bool "PHYTEC phyCORE-AM62x running on A53"
> diff --git a/board/ti/am62x/evm.c b/board/ti/am62x/evm.c
> index c2c7a0216b9..591324ecc15 100644
> --- a/board/ti/am62x/evm.c
> +++ b/board/ti/am62x/evm.c
> @@ -22,8 +22,16 @@
>   #include <dm/uclass.h>
>   #include <asm/arch/k3-ddr.h>
>   
> +#include "../common/board_detect.h"
>   #include "../common/fdt_ops.h"
>   
> +#define board_is_am62x_skevm()  (board_ti_k3_is("AM62-SKEVM") || \
> +				 board_ti_k3_is("AM62B-SKEVM"))
> +#define board_is_am62b_p1_skevm() board_ti_k3_is("AM62B-SKEVM-P1")
> +#define board_is_am62x_lp_skevm()  board_ti_k3_is("AM62-LP-SKEVM")
> +#define board_is_am62x_sip_skevm()  board_ti_k3_is("AM62SIP-SKEVM")
> +#define board_is_am62x_play()	board_ti_k3_is("BEAGLEPLAY-A0-")

BeaglePlay is not a TI AM62x EVM variant, its support is handled
separately over in board/beagle/beagleplay/, might be good to drop
this line to avoid any confusion around how the board is supported.

Andrew

> +
>   DECLARE_GLOBAL_DATA_PTR;
>   
>   #if CONFIG_IS_ENABLED(SPLASH_SCREEN)
> @@ -74,9 +82,53 @@ struct efi_capsule_update_info update_info = {
>   	.images = fw_images,
>   };
>   
> -#ifdef CONFIG_BOARD_LATE_INIT
> +#if CONFIG_IS_ENABLED(TI_I2C_BOARD_DETECT)
> +int checkboard(void)
> +{
> +	struct ti_am6_eeprom *ep = TI_AM6_EEPROM_DATA;
> +
> +	if (!do_board_detect_am6())
> +		printf("Board: %s rev %s\n", ep->name, ep->version);
> +
> +	return 0;
> +}
> +
> +#if CONFIG_IS_ENABLED(BOARD_LATE_INIT)
> +static void setup_board_eeprom_env(void)
> +{
> +	char *name = "am62x_skevm";
> +
> +	if (do_board_detect_am6())
> +		goto invalid_eeprom;
> +
> +	if (board_is_am62x_skevm())
> +		name = "am62x_skevm";
> +	else if (board_is_am62b_p1_skevm())
> +		name = "am62b_p1_skevm";
> +	else if (board_is_am62x_lp_skevm())
> +		name = "am62x_lp_skevm";
> +	else if (board_is_am62x_sip_skevm())
> +		name = "am62x_sip_skevm";
> +	else if (board_is_am62x_play())
> +		name = "am62x_beagleplay";
> +	else
> +		printf("Unidentified board claims %s in eeprom header\n",
> +		       board_ti_get_name());
> +
> +invalid_eeprom:
> +	set_board_info_env_am6(name);
> +}
> +#endif
> +#endif
> +
> +#if CONFIG_IS_ENABLED(BOARD_LATE_INIT)
>   int board_late_init(void)
>   {
> +	if (IS_ENABLED(CONFIG_TI_I2C_BOARD_DETECT)) {
> +		setup_board_eeprom_env();
> +		setup_serial_am6();
> +	}
> +
>   	ti_set_fdt_env(NULL, NULL);
>   	return 0;
>   }
> diff --git a/configs/am62x_evm_r5_defconfig b/configs/am62x_evm_r5_defconfig
> index 18ffc991b25..d42bdf1f074 100644
> --- a/configs/am62x_evm_r5_defconfig
> +++ b/configs/am62x_evm_r5_defconfig
> @@ -85,6 +85,7 @@ CONFIG_SPL_CLK_K3_PLL=y
>   CONFIG_SPL_CLK_K3=y
>   CONFIG_TI_SCI_PROTOCOL=y
>   CONFIG_DA8XX_GPIO=y
> +CONFIG_DM_I2C=y
>   CONFIG_DM_MAILBOX=y
>   CONFIG_K3_SEC_PROXY=y
>   CONFIG_SPL_MISC=y
> 

