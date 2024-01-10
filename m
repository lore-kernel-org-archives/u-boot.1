Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F5F7C4707B
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 14:13:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07EBD87A79;
	Wed, 10 Jan 2024 15:13:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1704896036;
	bh=gVAslJSXLq7liONQEf+1Sk5cMLCLT3Ayk5SJ+PJwvu8=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IWfu3YijZUnQIWgITqLqVzZl4NVOw78k8oxGR8hmMJzJzrQXyz9LuAPFt+My4H0gE
	 umaImTyVO0V/X3a95FXWSlO3PbWpCUWWT++3GdcZopLuK4nY9fa7zyVVteLFCLnCLw
	 urDFFTMQEfcfKk/LdI/EFLB+bnC1z94AJUB6jVj3PfEaWtNuaWZ96j4tDdW8IZ4XDO
	 5GmciU8c8z5TagSd8MVWS2R+LxVKNhi+iXj1lnRD5vE3wf4uYHZ5gt9Bgydne4DZf+
	 yFkZD2enBuEc+9zebrgkl/mXviGTvDku3XmmCcnSR9NanPU/VlTh4cFJd37mYYwD8P
	 LBF3nHX8jMFUw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 751EE86758; Wed, 10 Jan 2024 15:13:55 +0100 (CET)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [80.241.59.204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66BE087A79
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 15:13:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4T98t64R8xz9smh;
 Wed, 10 Jan 2024 15:13:50 +0100 (CET)
Message-ID: <92b2a7b1-171f-4c8b-b90a-2bb3399ccc1b@denx.de>
Date: Wed, 10 Jan 2024 15:13:50 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v3 3/3] arm: mvebu: eDPU: support new board revision
Content-Language: en-US
To: Robert Marko <robert.marko@sartura.hr>, u-boot@lists.denx.de
References: <20231129101117.60177-1-robert.marko@sartura.hr>
 <20231129101117.60177-3-robert.marko@sartura.hr>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20231129101117.60177-3-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 11/29/23 11:11, Robert Marko wrote:
> There is a new eDPU revision that uses Marvell 88E6361 switch onboard.
> We can rely on detecting the switch to enable and fixup the Linux DTS
> so a single DTS can be used.
> 
> There is currently no support for the 88E6361 switch and thus no working
> networking in U-Boot, so we disable both ports.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> Reviewed-by: Stefan Roese <sr@denx.de>

Applied to u-boot-marvell/master

Thanks,
Stefan

> ---
> Changes in v3:
> * Add check for DM_MDIO
> 
>   arch/arm/dts/armada-3720-eDPU-u-boot.dtsi |  13 ++-
>   arch/arm/dts/armada-3720-eDPU.dts         |  47 ++++++++
>   board/Marvell/mvebu_armada-37xx/board.c   | 128 ++++++++++++++++++++++
>   configs/eDPU_defconfig                    |   1 +
>   4 files changed, 184 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/dts/armada-3720-eDPU-u-boot.dtsi b/arch/arm/dts/armada-3720-eDPU-u-boot.dtsi
> index cb02b70e54..c3d450dd83 100644
> --- a/arch/arm/dts/armada-3720-eDPU-u-boot.dtsi
> +++ b/arch/arm/dts/armada-3720-eDPU-u-boot.dtsi
> @@ -32,14 +32,17 @@
>   	bootph-all;
>   };
>   
> -&eth0 {
> -	/* G.hn does not work without additional configuration */
> -	status = "disabled";
> -};
> -
>   &eth1 {
>   	fixed-link {
>   		speed = <1000>;
>   		full-duplex;
>   	};
>   };
> +
> +/*
> + * eDPU v2 has a MV88E6361 switch on the MDIO bus and U-boot is used
> + * to patch the Linux DTS if its found so enable MDIO by default.
> + */
> +&mdio {
> +	status = "okay";
> +};
> diff --git a/arch/arm/dts/armada-3720-eDPU.dts b/arch/arm/dts/armada-3720-eDPU.dts
> index 57fc698e55..d6d37a1f6f 100644
> --- a/arch/arm/dts/armada-3720-eDPU.dts
> +++ b/arch/arm/dts/armada-3720-eDPU.dts
> @@ -12,3 +12,50 @@
>   &eth0 {
>   	phy-mode = "2500base-x";
>   };
> +
> +/*
> + * External MV88E6361 switch is only available on v2 of the board.
> + * U-Boot will enable the MDIO bus and switch nodes.
> + */
> +&mdio {
> +	status = "disabled";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&smi_pins>;
> +
> +	/* Actual device is MV88E6361 */
> +	switch: switch@0 {
> +		compatible = "marvell,mv88e6190";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		reg = <0>;
> +		status = "disabled";
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;
> +				label = "cpu";
> +				phy-mode = "2500base-x";
> +				managed = "in-band-status";
> +				ethernet = <&eth0>;
> +			};
> +
> +			port@9 {
> +				reg = <9>;
> +				label = "downlink";
> +				phy-mode = "2500base-x";
> +				managed = "in-band-status";
> +			};
> +
> +			port@a {
> +				reg = <10>;
> +				label = "uplink";
> +				phy-mode = "2500base-x";
> +				managed = "in-band-status";
> +				sfp = <&sfp_eth1>;
> +			};
> +		};
> +	};
> +};
> diff --git a/board/Marvell/mvebu_armada-37xx/board.c b/board/Marvell/mvebu_armada-37xx/board.c
> index f532486b70..1685b12b84 100644
> --- a/board/Marvell/mvebu_armada-37xx/board.c
> +++ b/board/Marvell/mvebu_armada-37xx/board.c
> @@ -14,6 +14,7 @@
>   #include <mmc.h>
>   #include <miiphy.h>
>   #include <phy.h>
> +#include <fdt_support.h>
>   #include <asm/global_data.h>
>   #include <asm/io.h>
>   #include <asm/arch/cpu.h>
> @@ -50,6 +51,7 @@ DECLARE_GLOBAL_DATA_PTR;
>   /* Single-chip mode */
>   /* Switch Port Registers */
>   #define MVEBU_SW_LINK_CTRL_REG		(1)
> +#define MVEBU_SW_PORT_SWITCH_ID		(3)
>   #define MVEBU_SW_PORT_CTRL_REG		(4)
>   #define MVEBU_SW_PORT_BASE_VLAN		(6)
>   
> @@ -57,6 +59,8 @@ DECLARE_GLOBAL_DATA_PTR;
>   #define MVEBU_G2_SMI_PHY_CMD_REG	(24)
>   #define MVEBU_G2_SMI_PHY_DATA_REG	(25)
>   
> +#define SWITCH_88E6361_PRODUCT_NUMBER	0x2610
> +
>   /*
>    * Memory Controller Registers
>    *
> @@ -73,6 +77,30 @@ DECLARE_GLOBAL_DATA_PTR;
>   #define A3700_MC_CTRL2_SDRAM_TYPE_DDR3	2
>   #define A3700_MC_CTRL2_SDRAM_TYPE_DDR4	3
>   
> +static bool is_edpu_plus(void)
> +{
> +	struct udevice *bus;
> +	ofnode node;
> +	int val;
> +
> +	if (!CONFIG_IS_ENABLED(DM_MDIO))
> +		return false;
> +
> +	node = ofnode_by_compatible(ofnode_null(), "marvell,orion-mdio");
> +	if (!ofnode_valid(node) ||
> +	    uclass_get_device_by_ofnode(UCLASS_MDIO, node, &bus) ||
> +	    device_probe(bus)) {
> +		printf("Cannot find MDIO bus\n");
> +		return -ENODEV;
> +	}
> +
> +	val = dm_mdio_read(bus, 0x0, MDIO_DEVAD_NONE, MVEBU_SW_PORT_SWITCH_ID);
> +	if (val == SWITCH_88E6361_PRODUCT_NUMBER)
> +		return true;
> +	else
> +		return false;
> +}
> +
>   int board_early_init_f(void)
>   {
>   	return 0;
> @@ -357,6 +385,41 @@ static int espressobin_last_stage_init(void)
>   	return 0;
>   }
>   
> +static int edpu_plus_last_stage_init(void)
> +{
> +	struct udevice *dev;
> +	int ret;
> +
> +	if (is_edpu_plus()) {
> +		ret = uclass_get_device_by_name(UCLASS_ETH,
> +						"ethernet@40000",
> +						&dev);
> +		if (!ret) {
> +			device_remove(dev, DM_REMOVE_NORMAL);
> +			device_unbind(dev);
> +		}
> +
> +		/* Currently no networking support on the eDPU+ board */
> +		ret = uclass_get_device_by_name(UCLASS_ETH,
> +						"ethernet@30000",
> +						&dev);
> +		if (!ret) {
> +			device_remove(dev, DM_REMOVE_NORMAL);
> +			device_unbind(dev);
> +		}
> +	} else {
> +		ret = uclass_get_device_by_name(UCLASS_ETH,
> +						"ethernet@30000",
> +						&dev);
> +		if (!ret) {
> +			device_remove(dev, DM_REMOVE_NORMAL);
> +			device_unbind(dev);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>   /* Bring-up board-specific network stuff */
>   static int last_stage_init(void)
>   {
> @@ -364,6 +427,9 @@ static int last_stage_init(void)
>   	if (of_machine_is_compatible("globalscale,espressobin"))
>   		return espressobin_last_stage_init();
>   
> +	if (of_machine_is_compatible("methode,edpu"))
> +		return edpu_plus_last_stage_init();
> +
>   	return 0;
>   }
>   EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, last_stage_init);
> @@ -465,12 +531,74 @@ static int espressobin_fdt_setup(void *blob)
>   	return 0;
>   }
>   
> +static int edpu_plus_fdt_setup(void *blob)
> +{
> +	const char *ports[] = { "downlink", "uplink" };
> +	uint8_t mac[ETH_ALEN];
> +	const char *path;
> +	int i, ret;
> +
> +	if (is_edpu_plus()) {
> +		ret = fdt_set_status_by_compatible(blob,
> +						   "marvell,orion-mdio",
> +						   FDT_STATUS_OKAY);
> +		if (ret)
> +			printf("Failed to enable MDIO!\n");
> +
> +		ret = fdt_set_status_by_alias(blob,
> +					      "ethernet1",
> +					      FDT_STATUS_DISABLED);
> +		if (ret)
> +			printf("Failed to disable ethernet1!\n");
> +
> +		path = fdt_get_alias(blob, "ethernet0");
> +		if (path)
> +			do_fixup_by_path_string(blob, path, "phy-mode", "2500base-x");
> +		else
> +			printf("Failed to update ethernet0 phy-mode to 2500base-x!\n");
> +
> +		ret = fdt_set_status_by_compatible(blob,
> +						   "marvell,mv88e6190",
> +						   FDT_STATUS_OKAY);
> +		if (ret)
> +			printf("Failed to enable MV88E6361!\n");
> +
> +		/*
> +		 * MAC-s for Uplink and Downlink ports are stored under
> +		 * non standard variable names, so lets manually fixup the
> +		 * switch port nodes to have the desired MAC-s.
> +		 */
> +		for (i = 0; i < 2; i++) {
> +			if (eth_env_get_enetaddr(ports[i], mac)) {
> +				do_fixup_by_prop(blob,
> +						 "label",
> +						 ports[i],
> +						 strlen(ports[i]) + 1,
> +						 "mac-address",
> +						 mac, ARP_HLEN, 1);
> +
> +				do_fixup_by_prop(blob,
> +						 "label",
> +						 ports[i],
> +						 strlen(ports[i]) + 1,
> +						 "local-mac-address",
> +						 mac, ARP_HLEN, 1);
> +			}
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>   int ft_board_setup(void *blob, struct bd_info *bd)
>   {
>   #ifdef CONFIG_ENV_IS_IN_SPI_FLASH
>   	if (of_machine_is_compatible("globalscale,espressobin"))
>   		return espressobin_fdt_setup(blob);
>   #endif
> +	if (of_machine_is_compatible("methode,edpu"))
> +		return edpu_plus_fdt_setup(blob);
> +
>   	return 0;
>   }
>   #endif
> diff --git a/configs/eDPU_defconfig b/configs/eDPU_defconfig
> index 238f91cf6b..34c302485b 100644
> --- a/configs/eDPU_defconfig
> +++ b/configs/eDPU_defconfig
> @@ -17,6 +17,7 @@ CONFIG_DEBUG_UART=y
>   CONFIG_FIT=y
>   CONFIG_FIT_VERBOSE=y
>   CONFIG_DISTRO_DEFAULTS=y
> +CONFIG_OF_BOARD_SETUP=y
>   CONFIG_USE_PREBOOT=y
>   # CONFIG_DISPLAY_CPUINFO is not set
>   # CONFIG_DISPLAY_BOARDINFO is not set

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
