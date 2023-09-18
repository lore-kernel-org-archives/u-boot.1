Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8978DC46CA1
	for <u-boot@archiver.kernel.org>; Mon, 18 Sep 2023 06:52:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB9C286898;
	Mon, 18 Sep 2023 08:52:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1695019932;
	bh=STzJBD17D3nJcHz9J/hsgHgUlXypweHaQOgveTWgKIA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bexNai1cZXcciAxuINnJ/gGUs4FoXYCyhbmCMz1ERH3tsewMq5aI2JQiFWrKqxTRM
	 hrcRATWcLypZnMclng94jp7Pb1dy3NTK4azrjx0fRmWFkdy45VKOAtlQgIncqntdbm
	 C42IB4kGqqsBqOPhOg4/wWK8UbLGtwEldMt3LhHJ7OVKBAgjFh9Co/Fp84WTKZUcdH
	 Y1pEEoGrUsDScuFKjM0cLpbTXLfsgckZz1YlOQOn7dwb0QN7uEpz622wDqwAmGksl7
	 FgboiznM2ft4+tB8oblXx4C62WQbVVSzx2fxEVZzCSJmlV7Wk2kSHmSHTMrXPyHM/h
	 hEVzIsIA47mkQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54D95868D8; Mon, 18 Sep 2023 08:52:12 +0200 (CEST)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [80.241.59.204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61E898658D
 for <u-boot@lists.denx.de>; Mon, 18 Sep 2023 08:52:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4RpwT42CCkz9sSM;
 Mon, 18 Sep 2023 08:52:08 +0200 (CEST)
Message-ID: <51933c10-3fb2-fbb2-3830-db33f97bc37a@denx.de>
Date: Mon, 18 Sep 2023 08:52:07 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 3/3] arm: mvebu: eDPU: support new board revision
Content-Language: en-US
To: Robert Marko <robert.marko@sartura.hr>, u-boot@lists.denx.de
Cc: luka.perkov@sartura.hr
References: <20230914101642.1603383-1-robert.marko@sartura.hr>
 <20230914101642.1603383-3-robert.marko@sartura.hr>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20230914101642.1603383-3-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4RpwT42CCkz9sSM
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

On 9/14/23 12:16, Robert Marko wrote:
> There is a new eDPU revision that uses Marvell 88E6361 switch onboard.
> We can rely on detecting the switch to enable and fixup the Linux DTS
> so a single DTS can be used.
> 
> There is currently no support for the 88E6361 switch and thus no working
> networking in U-Boot, so we disable both ports.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
>   arch/arm/dts/armada-3720-eDPU-u-boot.dtsi |  13 ++-
>   arch/arm/dts/armada-3720-eDPU.dts         |  47 ++++++++
>   board/Marvell/mvebu_armada-37xx/board.c   | 125 ++++++++++++++++++++++
>   configs/eDPU_defconfig                    |   2 +
>   4 files changed, 182 insertions(+), 5 deletions(-)
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
> index 6527155c6e..6d633e94f3 100644
> --- a/board/Marvell/mvebu_armada-37xx/board.c
> +++ b/board/Marvell/mvebu_armada-37xx/board.c
> @@ -13,6 +13,7 @@
>   #include <mmc.h>
>   #include <miiphy.h>
>   #include <phy.h>
> +#include <fdt_support.h>
>   #include <asm/global_data.h>
>   #include <asm/io.h>
>   #include <asm/arch/cpu.h>
> @@ -49,6 +50,7 @@ DECLARE_GLOBAL_DATA_PTR;
>   /* Single-chip mode */
>   /* Switch Port Registers */
>   #define MVEBU_SW_LINK_CTRL_REG		(1)
> +#define MVEBU_SW_PORT_SWITCH_ID		(3)
>   #define MVEBU_SW_PORT_CTRL_REG		(4)
>   #define MVEBU_SW_PORT_BASE_VLAN		(6)
>   
> @@ -56,6 +58,8 @@ DECLARE_GLOBAL_DATA_PTR;
>   #define MVEBU_G2_SMI_PHY_CMD_REG	(24)
>   #define MVEBU_G2_SMI_PHY_DATA_REG	(25)
>   
> +#define SWITCH_88E6361_PRODUCT_NUMBER	0x2610
> +
>   /*
>    * Memory Controller Registers
>    *
> @@ -72,6 +76,27 @@ DECLARE_GLOBAL_DATA_PTR;
>   #define A3700_MC_CTRL2_SDRAM_TYPE_DDR3	2
>   #define A3700_MC_CTRL2_SDRAM_TYPE_DDR4	3
>   
> +static bool is_edpu_plus(void)
> +{
> +	struct udevice *bus;
> +	ofnode node;
> +	int val;
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
> @@ -353,6 +378,41 @@ static int espressobin_last_stage_init(void)
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
>   int last_stage_init(void)
>   {
> @@ -360,6 +420,9 @@ int last_stage_init(void)
>   	if (of_machine_is_compatible("globalscale,espressobin"))
>   		return espressobin_last_stage_init();
>   
> +	if (of_machine_is_compatible("methode,edpu"))
> +		return edpu_plus_last_stage_init();
> +
>   	return 0;
>   }
>   #endif
> @@ -460,12 +523,74 @@ static int espressobin_fdt_setup(void *blob)
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
> index 77ea2b2eec..d8bf35330d 100644
> --- a/configs/eDPU_defconfig
> +++ b/configs/eDPU_defconfig
> @@ -17,12 +17,14 @@ CONFIG_DEBUG_UART=y
>   # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
>   CONFIG_FIT=y
>   CONFIG_FIT_VERBOSE=y
> +CONFIG_OF_BOARD_SETUP=y
>   CONFIG_DISTRO_DEFAULTS=y
>   CONFIG_USE_PREBOOT=y
>   # CONFIG_DISPLAY_CPUINFO is not set
>   # CONFIG_DISPLAY_BOARDINFO is not set
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
>   CONFIG_BOARD_EARLY_INIT_F=y
> +CONFIG_LAST_STAGE_INIT=y
>   CONFIG_SYS_MAXARGS=32
>   CONFIG_SYS_PBSIZE=1048
>   # CONFIG_CMD_ELF is not set

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
