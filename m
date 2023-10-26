Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6ABDC25B48
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 07:10:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45A16875A4;
	Thu, 26 Oct 2023 09:10:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1698304224;
	bh=JQJB9Emsf+GLurX+ApZa7JZp3jUNvv9urnRpfZWH1rg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KqtlyO7zG9sb0AP0UFyQ12n0BDysXQN2Q4h1jRl9UE5qSNtblDy2C0SJkhuZbDaNj
	 A8KU1c1+bbSNzOBfZlDJ7BRlFLRHCfZB+vM3Mewk/FssnO7aY/8Vo0nhA/3TFp/uhr
	 5VeV/jZ8VpkJwcKJFoDRbIrZ0Dp8P2InyGxRpoW04eUyW7Z/PRFLUsfKPquRTWZ9U1
	 pE6G6x7zZGdBkqUdKzR//pHHdCuJo59OmNAml5mLS7TJOxADHzj4hnmDlP/aU+F6hj
	 kX+9Giy/DKAM0f9NPSiyWU44XDLUJgyPtuJaXOj6kgAZiHMKEjJcd4jmKIvUYZwX6W
	 Slh+G65+HxhxQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id C099D87AEB; Thu, 26 Oct 2023 09:10:22 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org
 [IPv6:2001:67c:2050:101:465::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4397A875A1
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 09:10:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4SGH4V2KJ9z9sRh;
 Thu, 26 Oct 2023 09:10:18 +0200 (CEST)
Message-ID: <0bcf9e62-4ada-4d44-b621-0603aeabb84a@denx.de>
Date: Thu, 26 Oct 2023 09:10:17 +0200
MIME-Version: 1.0
Subject: Re: [PATCH u-boot-marvell] arm: mvebu: turris_mox: Extend to support
 RIPE Atlas Probe
Content-Language: en-US
To: =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 =?UTF-8?B?TWljaGFsIEhydcWhZWNrw70=?= <michal.hrusecky@nic.cz>,
 =?UTF-8?Q?Marek_Moj=C3=ADk?= <marek.mojik@nic.cz>,
 =?UTF-8?Q?Maximili=C3=A1n_Maliar?= <maximilian.maliar@nic.cz>
References: <20231020142916.26193-1-kabel@kernel.org>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20231020142916.26193-1-kabel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4SGH4V2KJ9z9sRh
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

On 10/20/23 16:29, Marek Behún wrote:
> Extend Turris Mox board code to support CZ.NIC's RIPE Atlas Probe.
> 
> Signed-off-by: Marek Behún <kabel@kernel.org>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan


> ---
>   arch/arm/dts/Makefile                   |  1 +
>   arch/arm/dts/armada-3720-ripe-atlas.dts | 91 +++++++++++++++++++++++++
>   arch/arm/mach-mvebu/Kconfig             |  6 +-
>   board/CZ.NIC/turris_mox/mox_sp.c        | 12 +++-
>   board/CZ.NIC/turris_mox/mox_sp.h        |  8 ++-
>   board/CZ.NIC/turris_mox/turris_mox.c    | 72 +++++++++++++++++--
>   configs/turris_mox_defconfig            |  3 +-
>   7 files changed, 180 insertions(+), 13 deletions(-)
>   create mode 100644 arch/arm/dts/armada-3720-ripe-atlas.dts
> 
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index 4569483d5f..e39a7647b4 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -319,6 +319,7 @@ else
>   dtb-$(CONFIG_ARCH_MVEBU) +=			\
>   	armada-3720-db.dtb			\
>   	armada-3720-espressobin.dtb		\
> +	armada-3720-ripe-atlas.dtb		\
>   	armada-3720-turris-mox.dtb		\
>   	armada-3720-eDPU.dtb			\
>   	armada-3720-uDPU.dtb			\
> diff --git a/arch/arm/dts/armada-3720-ripe-atlas.dts b/arch/arm/dts/armada-3720-ripe-atlas.dts
> new file mode 100644
> index 0000000000..4457845266
> --- /dev/null
> +++ b/arch/arm/dts/armada-3720-ripe-atlas.dts
> @@ -0,0 +1,91 @@
> +// SPDX-License-Identifier: GPL-2.0+ or X11
> +/*
> + * Device Tree file for CZ.NIC' RIPE Atlas Probe
> + * 2021 by Marek Behún <marek.behun@nic.cz>
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/leds/common.h>
> +#include "armada-372x.dtsi"
> +
> +/ {
> +	model = "CZ.NIC's RIPE Atlas Probe";
> +	compatible = "cznic,ripe-atlas", "marvell,armada3720",
> +		     "marvell,armada3710";
> +
> +	aliases {
> +		ethernet0 = &eth0;
> +		mmc0 = &sdhci0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x00000000 0x00000000 0x00000000 0x20000000>;
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		led {
> +			gpios = <&gpiosb 21 GPIO_ACTIVE_LOW>;
> +			color = <LED_COLOR_ID_RED>;
> +			function = LED_FUNCTION_ACTIVITY;
> +		};
> +	};
> +
> +	vsdc_reg: vsdc-reg {
> +		compatible = "regulator-gpio";
> +		regulator-name = "vsdc";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-boot-on;
> +
> +		gpios = <&gpiosb 23 GPIO_ACTIVE_HIGH>;
> +		gpios-states = <0>;
> +		states = <1800000 0x1
> +			  3300000 0x0>;
> +		enable-active-high;
> +	};
> +};
> +
> +&comphy {
> +	status = "disabled";
> +};
> +
> +&mdio {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&smi_pins>;
> +	status = "okay";
> +
> +	phy1: ethernet-phy@1 {
> +		reg = <1>;
> +	};
> +};
> +
> +&eth0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&rgmii_pins>;
> +	phy-mode = "rgmii";
> +	phy-handle = <&phy1>;
> +	status = "okay";
> +};
> +
> +&sdhci0 {
> +	bus-width = <8>;
> +	non-removable;
> +	vqmmc-supply = <&vsdc_reg>;
> +	marvell,pad-type = "sd";
> +	status = "okay";
> +};
> +
> +&uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart1_pins>;
> +	status = "okay";
> +};
> diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
> index 5c7f4bf964..c80d8587b1 100644
> --- a/arch/arm/mach-mvebu/Kconfig
> +++ b/arch/arm/mach-mvebu/Kconfig
> @@ -144,8 +144,12 @@ config TARGET_TURRIS_OMNIA
>   	select ATSHA204A
>   
>   config TARGET_TURRIS_MOX
> -	bool "Support Turris Mox"
> +	bool "Support CZ.NIC's Turris Mox / RIPE Atlas Probe"
>   	select ARMADA_3700
> +	select BOARD_TYPES
> +	select ENV_IS_IN_MMC
> +	select ENV_IS_IN_SPI_FLASH
> +	select MULTI_DTB_FIT
>   
>   config TARGET_MVEBU_ARMADA_8K
>   	bool "Support Armada 7k/8k platforms"
> diff --git a/board/CZ.NIC/turris_mox/mox_sp.c b/board/CZ.NIC/turris_mox/mox_sp.c
> index 87f67512fb..11d8756471 100644
> --- a/board/CZ.NIC/turris_mox/mox_sp.c
> +++ b/board/CZ.NIC/turris_mox/mox_sp.c
> @@ -10,6 +10,8 @@
>   #include <linux/delay.h>
>   #include <mach/mbox.h>
>   
> +#include "mox_sp.h"
> +
>   const char *mox_sp_get_ecdsa_public_key(void)
>   {
>   	static char public_key[135];
> @@ -42,12 +44,13 @@ static inline void res_to_mac(u8 *mac, u32 t1, u32 t2)
>   	mac[5] = t2;
>   }
>   
> -int mbox_sp_get_board_info(u64 *sn, u8 *mac1, u8 *mac2, int *bv, int *ram)
> +int mbox_sp_get_board_info(u64 *sn, u8 *mac1, u8 *mac2, int *bv, int *ram,
> +			   enum cznic_a3720_board *board)
>   {
> -	u32 out[8];
> +	u32 out[9];
>   	int res;
>   
> -	res = mbox_do_cmd(MBOX_CMD_BOARD_INFO, NULL, 0, out, 8);
> +	res = mbox_do_cmd(MBOX_CMD_BOARD_INFO, NULL, 0, out, 9);
>   	if (res < 0)
>   		return res;
>   
> @@ -69,5 +72,8 @@ int mbox_sp_get_board_info(u64 *sn, u8 *mac1, u8 *mac2, int *bv, int *ram)
>   	if (mac2)
>   		res_to_mac(mac2, out[6], out[7]);
>   
> +	if (board)
> +		*board = out[8] + 1;
> +
>   	return 0;
>   }
> diff --git a/board/CZ.NIC/turris_mox/mox_sp.h b/board/CZ.NIC/turris_mox/mox_sp.h
> index 83b6037458..720880d5df 100644
> --- a/board/CZ.NIC/turris_mox/mox_sp.h
> +++ b/board/CZ.NIC/turris_mox/mox_sp.h
> @@ -8,8 +8,14 @@
>   
>   #include <common.h>
>   
> +enum cznic_a3720_board {
> +	BOARD_UNDEFINED		= 0x0,
> +	BOARD_TURRIS_MOX	= 0x1,
> +	BOARD_RIPE_ATLAS	= 0x3,
> +};
> +
>   const char *mox_sp_get_ecdsa_public_key(void);
>   int mbox_sp_get_board_info(u64 *sn, u8 *mac1, u8 *mac2, int *bv,
> -			   int *ram);
> +			   int *ram, enum cznic_a3720_board *board);
>   
>   #endif /* _BOARD_CZNIC_TURRIS_MOX_MOX_SP_H_ */
> diff --git a/board/CZ.NIC/turris_mox/turris_mox.c b/board/CZ.NIC/turris_mox/turris_mox.c
> index 370c2668b0..63b8699219 100644
> --- a/board/CZ.NIC/turris_mox/turris_mox.c
> +++ b/board/CZ.NIC/turris_mox/turris_mox.c
> @@ -15,6 +15,7 @@
>   #include <dm.h>
>   #include <dm/of_extra.h>
>   #include <env.h>
> +#include <env_internal.h>
>   #include <event.h>
>   #include <fdt_support.h>
>   #include <init.h>
> @@ -45,6 +46,26 @@
>   
>   DECLARE_GLOBAL_DATA_PTR;
>   
> +int board_fit_config_name_match(const char *name)
> +{
> +	if (!gd->board_type) {
> +		enum cznic_a3720_board board;
> +
> +		if (mbox_sp_get_board_info(NULL, NULL, NULL, NULL, NULL,
> +					   &board) < 0) {
> +			printf("Cannot determine board, defaulting to Turris MOX!\n");
> +			board = BOARD_TURRIS_MOX;
> +		}
> +
> +		gd->board_type = board;
> +	}
> +
> +	return !((gd->board_type == BOARD_TURRIS_MOX &&
> +		  !strcmp(name, "armada-3720-turris-mox")) ||
> +		 (gd->board_type == BOARD_RIPE_ATLAS &&
> +		  !strcmp(name, "armada-3720-ripe-atlas")));
> +}
> +
>   #if defined(CONFIG_OF_BOARD_FIXUP)
>   int board_fix_fdt(void *blob)
>   {
> @@ -53,6 +74,9 @@ int board_fix_fdt(void *blob)
>   	int i, size, ret;
>   	bool eth1_sgmii;
>   
> +	if (gd->board_type != BOARD_TURRIS_MOX)
> +		return 0;
> +
>   	/*
>   	 * SPI driver is not loaded in driver model yet, but we have to find out
>   	 * if pcie should be enabled in U-Boot's device tree. Therefore we have
> @@ -388,16 +412,23 @@ static void load_spi_dtb(void)
>   
>   int misc_init_r(void)
>   {
> +	int i, ret, addrcnt;
>   	u8 mac[2][6];
> -	int i, ret;
>   
> -	ret = mbox_sp_get_board_info(NULL, mac[0], mac[1], NULL, NULL);
> +	ret = mbox_sp_get_board_info(NULL, mac[0], mac[1], NULL, NULL, NULL);
>   	if (ret < 0) {
>   		printf("Cannot read data from OTP!\n");
>   		return 0;
>   	}
>   
> -	for (i = 0; i < 2; ++i) {
> +	if (gd->board_type == BOARD_TURRIS_MOX)
> +		addrcnt = 2;
> +	else if (gd->board_type == BOARD_RIPE_ATLAS)
> +		addrcnt = 1;
> +	else
> +		addrcnt = 0;
> +
> +	for (i = 0; i < addrcnt; ++i) {
>   		u8 oldmac[6];
>   
>   		if (is_valid_ethaddr(mac[i]) &&
> @@ -405,7 +436,13 @@ int misc_init_r(void)
>   			eth_env_set_enetaddr_by_index("eth", i, mac[i]);
>   	}
>   
> -	load_spi_dtb();
> +	if (gd->board_type == BOARD_RIPE_ATLAS) {
> +		env_set("board", "ripe_atlas");
> +		env_set("board_name", "ripe_atlas");
> +		env_set("fdtfile", "marvell/armada-3720-ripe-atlas.dtb");
> +	} else {
> +		load_spi_dtb();
> +	}
>   
>   	return 0;
>   }
> @@ -528,14 +565,15 @@ static void handle_reset_button(void)
>   int show_board_info(void)
>   {
>   	int i, ret, board_version, ram_size, is_sd;
> -	const char *pub_key;
> +	const char *pub_key, *model;
>   	const u8 *topology;
>   	u64 serial_number;
>   
> -	printf("Model: CZ.NIC Turris Mox Board\n");
> +	model = fdt_getprop(gd->fdt_blob, 0, "model", NULL);
> +	printf("Model: %s\n", model);
>   
>   	ret = mbox_sp_get_board_info(&serial_number, NULL, NULL, &board_version,
> -				     &ram_size);
> +				     &ram_size, NULL);
>   	if (ret < 0) {
>   		printf("  Cannot read board info: %i\n", ret);
>   	} else {
> @@ -550,6 +588,9 @@ int show_board_info(void)
>   	else
>   		printf("  Cannot read ECDSA Public Key\n");
>   
> +	if (gd->board_type != BOARD_TURRIS_MOX)
> +		return 0;
> +
>   	ret = mox_get_topology(&topology, &module_count, &is_sd);
>   	if (ret)
>   		printf("Cannot read module topology!\n");
> @@ -668,10 +709,24 @@ err:
>   	return NULL;
>   }
>   
> +enum env_location env_get_location(enum env_operation op, int prio)
> +{
> +	if (prio > 0)
> +		return ENVL_UNKNOWN;
> +
> +	if (gd->board_type == BOARD_RIPE_ATLAS)
> +		return ENVL_MMC;
> +
> +	return ENVL_SPI_FLASH;
> +}
> +
>   static int last_stage_init(void)
>   {
>   	struct gpio_desc reset_gpio = {};
>   
> +	if (gd->board_type != BOARD_TURRIS_MOX)
> +		return 0;
> +
>   	/* configure modules */
>   	if (get_reset_gpio(&reset_gpio) < 0)
>   		goto handle_reset_btn;
> @@ -801,6 +856,9 @@ int ft_board_setup(void *blob, struct bd_info *bd)
>   {
>   	int res;
>   
> +	if (gd->board_type != BOARD_TURRIS_MOX)
> +		return 0;
> +
>   	/*
>   	 * If MOX B (PCI), MOX F (USB) or MOX G (Passthrough PCI) modules are
>   	 * connected, enable the PCIe node.
> diff --git a/configs/turris_mox_defconfig b/configs/turris_mox_defconfig
> index e0ca6337bd..c9815b612f 100644
> --- a/configs/turris_mox_defconfig
> +++ b/configs/turris_mox_defconfig
> @@ -52,9 +52,10 @@ CONFIG_CMD_HASH=y
>   CONFIG_CMD_BTRFS=y
>   CONFIG_CMD_EXT4_WRITE=y
>   CONFIG_MAC_PARTITION=y
> +CONFIG_OF_LIST="armada-3720-turris-mox armada-3720-ripe-atlas"
>   CONFIG_ENV_OVERWRITE=y
> -CONFIG_ENV_IS_IN_SPI_FLASH=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> +CONFIG_SYS_MMC_ENV_PART=2
>   CONFIG_ARP_TIMEOUT=200
>   CONFIG_NET_RETRY_COUNT=50
>   CONFIG_NETCONSOLE=y

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
