Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16683CCD184
	for <u-boot@archiver.kernel.org>; Tue, 21 Oct 2025 07:52:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BB2A831D6;
	Tue, 21 Oct 2025 09:52:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ex2/un4k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F08D832BC; Tue, 21 Oct 2025 09:52:27 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AB65800B6
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 09:52:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id E08416023B;
 Tue, 21 Oct 2025 07:52:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 181F9C4CEF1;
 Tue, 21 Oct 2025 07:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1761033143;
 bh=q5NyjwaoGUFzOMWe6elH9eLG0q1VI0gXPuJCytEQeio=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=ex2/un4kF8vTc5FmwJp+dXsh0rAoFPsysC70NNMye11Chr+Mm7tQ/fIvbjgzeG8bm
 Io4PzAKcLYWH1aDj25JwqXIm3Qlddgy9aA1jJ+7IUpgiG53VPb58a4+4+avEGI9IQM
 OSctmeOki2+TL5nOsyz7hXoeHibwZK1TRT5w4Fzts965jyaCrBwuNFqDDra7tiKzVu
 kbvML7JIPWqvVJE0YK+b+r8/YRRg4ntlkhHCIh38fKl/W3CUjFSaqujPC2i1+rUi/D
 u1eACujE9TNcu5wsMuBSMR8rX04WDYV2XzOSX3V68y2Epr7yLAFuO1AvdAlzuW1JET
 e3mWkCVrglq+g==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Bryan Brattlof <bb@ti.com>, Garrett
 Giordano <ggiordano@phytec.com>, Wadim Egorov <w.egorov@phytec.de>, Neha
 Malcom Francis <n-francis@ti.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Santhosh Kumar K <s-k6@ti.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Devarsh Thakkar
 <devarsht@ti.com>, Anshul Dalal <anshuld@ti.com>, Prasanth Babu Mantena
 <p-mantena@ti.com>, Judith Mendez <jm@ti.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, "Guillaume La Roque (TI.com)"
 <glaroque@baylibre.com>
Subject: Re: [PATCH] board: am62x: Add support for reading eeprom data
In-Reply-To: <20251017-am62xeeprom-v1-1-31f83124189f@baylibre.com>
References: <20251017-am62xeeprom-v1-1-31f83124189f@baylibre.com>
Date: Tue, 21 Oct 2025 09:52:21 +0200
Message-ID: <87ecqwbsju.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Guillaume,

Thank you for the patch.

On Fri, Oct 17, 2025 at 08:24, "Guillaume La Roque (TI.com)" <glaroque@baylibre.com> wrote:

> I2C EEPROM data contains the board name and its revision.
> Add support for:
> - Reading EEPROM data and store a copy at end of SRAM
> - Updating env variable with relevant board info
> - Printing board info during boot.
>
> Signed-off-by: Guillaume La Roque (TI.com) <glaroque@baylibre.com>
> ---
>  arch/arm/mach-k3/am62x/Kconfig |  3 ++
>  board/ti/am62x/evm.c           | 95 +++++++++++++++++++++++++++++++++++++++++-
>  configs/am62x_evm_r5_defconfig |  1 +
>  3 files changed, 98 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-k3/am62x/Kconfig b/arch/arm/mach-k3/am62x/Kconfig
> index 81199ada3a1..f7ad52db7d8 100644
> --- a/arch/arm/mach-k3/am62x/Kconfig
> +++ b/arch/arm/mach-k3/am62x/Kconfig
> @@ -14,6 +14,8 @@ config TARGET_AM625_A53_EVM
>  	select ARM64
>  	select BINMAN
>  	select OF_SYSTEM_SETUP
> +	imply TI_COMMON_CMD_OPTIONS
> +	imply TI_I2C_BOARD_DETECT
>  
>  config TARGET_AM625_R5_EVM
>  	bool "TI K3 based AM625 EVM running on R5"
> @@ -25,6 +27,7 @@ config TARGET_AM625_R5_EVM
>  	select K3_DDRSS
>  	select BINMAN
>  	imply SYS_K3_SPL_ATF
> +	imply TI_I2C_BOARD_DETECT
>  
>  config TARGET_PHYCORE_AM62X_A53
>  	bool "PHYTEC phyCORE-AM62x running on A53"
> diff --git a/board/ti/am62x/evm.c b/board/ti/am62x/evm.c
> index d7b07a0d34d..fbd45608efa 100644
> --- a/board/ti/am62x/evm.c
> +++ b/board/ti/am62x/evm.c
> @@ -22,8 +22,18 @@
>  #include <dm/uclass.h>
>  #include <asm/arch/k3-ddr.h>
>  
> +#include "../common/board_detect.h"
>  #include "../common/fdt_ops.h"
>  
> +#include "../common/k3-ddr.h"
> +
> +#define board_is_am62x_skevm()  (board_ti_k3_is("AM62-SKEVM") || \
> +				 board_ti_k3_is("AM62B-SKEVM"))
> +#define board_is_am62b_p1_skevm() board_ti_k3_is("AM62B-SKEVM-P1")
> +#define board_is_am62x_lp_skevm()  board_ti_k3_is("AM62-LP-SKEVM")
> +#define board_is_am62x_sip_skevm()  board_ti_k3_is("AM62SIP-SKEVM")
> +#define board_is_am62x_play()	board_ti_k3_is("BEAGLEPLAY-A0-")
> +
>  DECLARE_GLOBAL_DATA_PTR;
>  
>  #if CONFIG_IS_ENABLED(SPLASH_SCREEN)
> @@ -74,9 +84,92 @@ struct efi_capsule_update_info update_info = {
>  	.images = fw_images,
>  };
>  
> -#ifdef CONFIG_BOARD_LATE_INIT
> +#if CONFIG_IS_ENABLED(TI_I2C_BOARD_DETECT)
> +int do_board_detect(void)

Can't this be static?

> +{
> +	int ret;
> +
> +	ret = ti_i2c_eeprom_am6_get_base(CONFIG_EEPROM_BUS_ADDRESS,
> +					 CONFIG_EEPROM_CHIP_ADDRESS);
> +	if (ret) {
> +		printf("EEPROM not available at 0x%02x, trying to read at 0x%02x\n",
> +		       CONFIG_EEPROM_CHIP_ADDRESS, CONFIG_EEPROM_CHIP_ADDRESS + 1);
> +		ret = ti_i2c_eeprom_am6_get_base(CONFIG_EEPROM_BUS_ADDRESS,
> +						 CONFIG_EEPROM_CHIP_ADDRESS + 1);
> +		if (ret)
> +			pr_err("Reading on-board EEPROM at 0x%02x failed %d\n",
> +			       CONFIG_EEPROM_CHIP_ADDRESS + 1, ret);
> +	}
> +
> +	return ret;
> +}

This code seems very close to what's already in board/ti/am64x/evm.c
Maybe it's not needed before merging this patch, but should we consider
reducing code duplication and move this to a common place?

> +
> +int checkboard(void)
> +{
> +	struct ti_am6_eeprom *ep = TI_AM6_EEPROM_DATA;
> +
> +	if (!do_board_detect())
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
> +	if (do_board_detect())
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
> +
> +static void setup_serial(void)
> +{
> +	struct ti_am6_eeprom *ep = TI_AM6_EEPROM_DATA;
> +	unsigned long board_serial;
> +	char *endp;
> +	char serial_string[17] = { 0 };
> +
> +	if (env_get("serial#"))
> +		return;
> +
> +	board_serial = simple_strtoul(ep->serial, &endp, 16);
> +	if (*endp != '\0') {
> +		pr_err("Error: Can't set serial# to %s\n", ep->serial);
> +		return;
> +	}
> +
> +	snprintf(serial_string, sizeof(serial_string), "%016lx", board_serial);
> +	env_set("serial#", serial_string);
> +}
> +#endif
> +#endif
> +
> +#if CONFIG_IS_ENABLED(BOARD_LATE_INIT)
>  int board_late_init(void)
>  {
> +	if (IS_ENABLED(CONFIG_TI_I2C_BOARD_DETECT)) {
> +		setup_board_eeprom_env();
> +		setup_serial();
> +	}
> +
>  	ti_set_fdt_env(NULL, NULL);
>  	return 0;
>  }
> diff --git a/configs/am62x_evm_r5_defconfig b/configs/am62x_evm_r5_defconfig
> index 18ffc991b25..d42bdf1f074 100644
> --- a/configs/am62x_evm_r5_defconfig
> +++ b/configs/am62x_evm_r5_defconfig
> @@ -85,6 +85,7 @@ CONFIG_SPL_CLK_K3_PLL=y
>  CONFIG_SPL_CLK_K3=y
>  CONFIG_TI_SCI_PROTOCOL=y
>  CONFIG_DA8XX_GPIO=y
> +CONFIG_DM_I2C=y
>  CONFIG_DM_MAILBOX=y
>  CONFIG_K3_SEC_PROXY=y
>  CONFIG_SPL_MISC=y
>
> ---
> base-commit: 2ba64e303b2706e5c42a6bf982326d632342ca66
> change-id: 20251016-am62xeeprom-41a1920b8bd2
>
> Best regards,
> -- 
> Guillaume La Roque (TI.com) <glaroque@baylibre.com>
