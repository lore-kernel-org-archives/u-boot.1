Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 443B6CF9C69
	for <u-boot@archiver.kernel.org>; Sun, 22 Sep 2024 21:42:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B91888CC5;
	Sun, 22 Sep 2024 23:41:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727041317;
	bh=NpHRRGCWoIeDtrlQrVTtvshwCIHRONFjvC29ICyx6Ds=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CHIPqCvP4bTvZlBl/tDFmvlMZ2T/wX9e3lF0EWQxFgV0B0AoZdeCe/EsRp/dmf5U2
	 UCXjdZi2zKfx2tjIPMjmo1mXbo44wCP4O7x2lqzcJwg/3Egk3j+aeHoxWbza/rvnfl
	 7pId4fQipVyGLUyGHWU/q4VUGmTQj85UY043YOrzFxKkQbsYsh0CFg0EjJYVjoRFrv
	 CrCvdVofBfaOq2dmZsT0cmdg7HnCHjv6eCjhjmD+D0c/+2ZYQ8kAeE2uZgkBJEqfhB
	 wJDZyqBEiP1dG+vJUhzyLop06O7gMz2Dd2L6DnMkfOpBQrRgJ+HJGPLTServbgdZ6d
	 03AV+8qw45iBw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 1E70388B93;
 Sun, 22 Sep 2024 23:41:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1727041314;
 bh=NpHRRGCWoIeDtrlQrVTtvshwCIHRONFjvC29ICyx6Ds=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=exLYd/KwIgCK5sMG1NLP1uTy8jd1Qui47DJ+dhVTp6dQwda1nqGYXmzMOTW7DrGVp
 MvN1CcE0jvClUj2nyprkZsFtuWBvR8Wz9vhT8zrOE+WcmVnMXSOA3GOTcwzVLAobl/
 gXMcBl4UniOD4peDG5SC9xzZrvyipehGG4J1pUuUfsKQwormwknRuwVm+LRFofqsZT
 DzDlNGzKXzgA1vxTasqoZXzwK7uwAKqWfKzZjGgEqw05RBDVBXsSmO7c4uVlGLoiv3
 jcMo+hQC9sMLdL8EnuB4bnIBvII65V5jAa7C3Lf+fllKr/sKozFTcGIo3/nHj9Vqp2
 jPN2qNhmB+e9Q==
Message-ID: <f03fd4f5-1a77-4b59-bbac-4b0f098d015c@denx.de>
Date: Sun, 22 Sep 2024 23:27:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] ARM: socfpga: add Enclustra AA1 SoM support
To: Lothar Rubusch <l.rubusch@gmail.com>, u-boot@lists.denx.de,
 trini@konsulko.com, simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com
References: <20240917062157.3181-1-l.rubusch@gmail.com>
 <20240917062157.3181-4-l.rubusch@gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240917062157.3181-4-l.rubusch@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 9/17/24 8:21 AM, Lothar Rubusch wrote:

[...]

> diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
> index 6b6a162f56..d42e7817be 100644
> --- a/arch/arm/mach-socfpga/Kconfig
> +++ b/arch/arm/mach-socfpga/Kconfig
> @@ -221,6 +221,10 @@ config TARGET_SOCFPGA_TERASIC_SOCKIT
>   	bool "Terasic SoCkit (Cyclone V)"
>   	select TARGET_SOCFPGA_CYCLONE5
>   
> +config TARGET_SOCFPGA_ENCLUSTRA_MERCURY_AA1
> +	bool "Enclustra Mercury+ AA1"
> +	select TARGET_SOCFPGA_ARRIA10
> +

Keep the list sorted.

>   endchoice
>   
>   config SYS_BOARD
> @@ -244,6 +248,7 @@ config SYS_BOARD
>   	default "sr1500" if TARGET_SOCFPGA_SR1500
>   	default "stratix10-socdk" if TARGET_SOCFPGA_STRATIX10_SOCDK
>   	default "vining_fpga" if TARGET_SOCFPGA_SOFTING_VINING_FPGA
> +	default "mercury_aa1" if TARGET_SOCFPGA_ENCLUSTRA_MERCURY_AA1

Keep the list sorted.

>   config SYS_VENDOR
>   	default "intel" if TARGET_SOCFPGA_AGILEX5_SOCDK
> @@ -264,6 +269,7 @@ config SYS_VENDOR
>   	default "terasic" if TARGET_SOCFPGA_TERASIC_DE10_NANO
>   	default "terasic" if TARGET_SOCFPGA_TERASIC_DE10_STANDARD
>   	default "terasic" if TARGET_SOCFPGA_TERASIC_SOCKIT
> +	default "enclustra" if TARGET_SOCFPGA_ENCLUSTRA_MERCURY_AA1

Keep the list sorted.

>   config SYS_SOC
>   	default "socfpga"
> @@ -289,5 +295,8 @@ config SYS_CONFIG_NAME
>   	default "socfpga_sr1500" if TARGET_SOCFPGA_SR1500
>   	default "socfpga_stratix10_socdk" if TARGET_SOCFPGA_STRATIX10_SOCDK
>   	default "socfpga_vining_fpga" if TARGET_SOCFPGA_SOFTING_VINING_FPGA
> +	default "socfpga_mercury_aa1" if TARGET_SOCFPGA_ENCLUSTRA_MERCURY_AA1

Keep the list sorted.

> +source "board/enclustra/common/Kconfig"

include the socfpga Kconfig directly, if more SoMs gets upstreamed, they 
might be Xilinx too so including common/Kconfig won't make sense here.

>   endif

[...]

> diff --git a/board/enclustra/mercury_aa1/MAINTAINERS b/board/enclustra/mercury_aa1/MAINTAINERS
> new file mode 100644
> index 0000000000..862cb1ae31
> --- /dev/null
> +++ b/board/enclustra/mercury_aa1/MAINTAINERS
> @@ -0,0 +1,11 @@
> +Enclustra Mercury+ AA1
> +M:	Lothar Rubusch <l.rubusch@gmail.com>
> +S:	Maintained
> +F:	board/enclustra/mercury_aa1/
> +F:	board/enclustra/common/
> +F:	include/configs/socfpga_mercury_aa1.h
> +F:	configs/socfpga_enclustra_mercury_aa1_defconfig
> +F:	arch/arm/dts/socfpga_enclustra_mercury_aa1.dtsi
> +F:	arch/arm/dts/socfpga_enclustra_mercury_aa1_emmc_boot.dtsi
> +F:	arch/arm/dts/socfpga_enclustra_mercury_aa1_qspi_boot.dtsi

Try these regex patterns (see top level MAINTAINERS file for details) , 
they should cover pretty much everything listed here automatically:

N: enclustra
N: mercury_aa1

> +F:	doc/board/enclustra/mercury-aa1.rst
> diff --git a/board/enclustra/mercury_aa1/Makefile b/board/enclustra/mercury_aa1/Makefile
> new file mode 100644
> index 0000000000..53c84d8156
> --- /dev/null
> +++ b/board/enclustra/mercury_aa1/Makefile
> @@ -0,0 +1,8 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +# Copyright (c) 2024 Enclustra GmbH
> +
> +ifeq ($(CONFIG_SPL_BUILD),)
> +
> +obj-y += aa1_set_storage_cmd.o
> +
> +endif
> diff --git a/board/enclustra/mercury_aa1/aa1_set_storage_cmd.c b/board/enclustra/mercury_aa1/aa1_set_storage_cmd.c
> new file mode 100644
> index 0000000000..650457feba
> --- /dev/null
> +++ b/board/enclustra/mercury_aa1/aa1_set_storage_cmd.c
> @@ -0,0 +1,177 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2024 Enclustra GmbH
> + * <info@enclustra.com>
> + */
> +
> +#include <command.h>
> +#include <env.h>
> +#include <init.h>
> +#include <dm/uclass.h>
> +#include <asm-generic/gpio.h>
> +#include <asm/io.h>
> +
> +/* Pin muxing */
> +#define ALTERA_NONE 0
> +#define ALTERA_MMC 1
> +#define ALTERA_QSPI 2
> +#define ALTERA_EMMC 3
> +#define MMC_CLK_DIV 0x9
> +#define QSPI_CLK_DIV 0x384
> +#define ALTERA_PINMUX_OFFS 0xffd07200
> +#define ALTERA_CLKMGR_MAINPLL_CNTR6CLK_BASE 0xFFD04078
> +
> +static int altera_current_storage = ALTERA_NONE;
> +
> +static void set_mux_mmc(void)
> +{
> +	u32 pinmux_arr[] = {0x0c, 0x8,  // IO4 connected to SDMMC

This can be static const u32 , DTTO all the other arrays.

> +		0x10, 0x8,	// IO5
> +		0x14, 0x8,	// IO6
> +		0x18, 0x8,	// IO7
> +		0x1c, 0x8,	// IO8
> +		0x20, 0x8,	// IO9
> +		0x24, 0xf,	// IO10 connected to GPIO
> +		0x28, 0xf,	// IO11
> +		0x2c, 0xf,	// IO12
> +		0x30, 0xf,	// IO13
> +		0x34, 0xf,	// IO14
> +		0x38, 0xf};	// IO15
> +	u32 len, i, offset, value;
> +
> +	len = sizeof(pinmux_arr) / sizeof(u32);
> +	for (i = 0; i < len; i += 2) {

Surely this function and all of its follow up almost identical copies 
can be deduplicated.

> +		offset = pinmux_arr[i];
> +		value = pinmux_arr[i + 1];
> +		writel(value, ALTERA_PINMUX_OFFS + offset);
> +	}
> +}
> +
> +static void set_mux_emmc(void)
> +{
> +	u32 pinmux_arr[] = {0x0c, 0x8,  // IO4
> +		0x10, 0x8,	// IO5
> +		0x14, 0x8,	// IO6
> +		0x18, 0x8,	// IO7
> +		0x1c, 0x8,	// IO8
> +		0x20, 0x8,	// IO9
> +		0x24, 0xf,	// IO10
> +		0x28, 0xf,	// IO11
> +		0x2c, 0x8,	// IO12
> +		0x30, 0x8,	// IO13
> +		0x34, 0x8,	// IO14
> +		0x38, 0x8};	// IO15
> +	u32 len, i, offset, value;
> +
> +	len = sizeof(pinmux_arr) / sizeof(u32);
> +	for (i = 0; i < len; i += 2) {
> +		offset = pinmux_arr[i];
> +		value = pinmux_arr[i + 1];
> +		writel(value, ALTERA_PINMUX_OFFS + offset);
> +	}
> +}
> +
> +static void set_mux_qspi(void)

Some more specific name of this symbol would be useful, e.g. 
enclustra_mercury_aa1_set_mux_qspi , since that symbol then shows up in 
e.g. objdump -D and unique name makes it easy to identify what it is.

> +{
> +	u32 pinmux_arr[] = {0x0c, 0x4,  // IO4 connected to QSPI
> +		0x10, 0x4,	// IO5
> +		0x14, 0x4,	// IO6
> +		0x18, 0x4,	// IO7
> +		0x1c, 0x4,	// IO8
> +		0x20, 0x4,	// IO9
> +		0x24, 0xf,	// IO10
> +		0x28, 0xf,	// IO11
> +		0x2c, 0xf,	// IO12
> +		0x30, 0xf,	// IO13
> +		0x34, 0xf,	// IO14
> +		0x38, 0xf};	// IO15
> +	u32 len, i, offset, value;
> +
> +	len = sizeof(pinmux_arr) / sizeof(u32);
> +	for (i = 0; i < len; i += 2) {
> +		offset = pinmux_arr[i];
> +		value = pinmux_arr[i + 1];
> +		writel(value, ALTERA_PINMUX_OFFS + offset);
> +	}
> +}
> +
> +static void altera_set_storage(int store)
> +{
> +	unsigned int gpio_flash_sel;
> +	unsigned int gpio_flash_oe;
> +
> +	if (store == altera_current_storage)
> +		return;
> +
> +	if (gpio_lookup_name("portb5", NULL, NULL, &gpio_flash_oe)) {
> +		printf("ERROR: GPIO not found\n");
> +		return;
> +	}
> +
> +	if (gpio_request(gpio_flash_oe, "flash_oe")) {
> +		printf("ERROR: GPIO request failed\n");

Does this look up have to be done for every single invocation of the 
command ?

This is missing gpio_free() for fail case.

Return value should be propagated in case of failure.

> +		return;
> +	}
> +
> +	if (gpio_lookup_name("portc6", NULL, NULL, &gpio_flash_sel)) {
> +		printf("ERROR: GPIO not found\n");
> +		return;
> +	}
> +
> +	if (gpio_request(gpio_flash_sel, "flash_sel")) {
> +		printf("ERROR: GPIO request failed\n");
> +		return;
> +	}
> +
> +	switch (store) {
> +	case ALTERA_MMC:
> +		set_mux_mmc();
> +		gpio_direction_output(gpio_flash_sel, 0);
> +		gpio_direction_output(gpio_flash_oe, 0);
> +		altera_current_storage = ALTERA_MMC;
> +		writel(MMC_CLK_DIV, ALTERA_CLKMGR_MAINPLL_CNTR6CLK_BASE);
> +		break;
> +	case ALTERA_EMMC:
> +		set_mux_emmc();
> +		gpio_direction_output(gpio_flash_sel, 1);
> +		gpio_direction_output(gpio_flash_oe, 1);
> +		altera_current_storage = ALTERA_EMMC;
> +		writel(MMC_CLK_DIV, ALTERA_CLKMGR_MAINPLL_CNTR6CLK_BASE);
> +		break;
> +	case ALTERA_QSPI:
> +		set_mux_qspi();
> +		gpio_direction_output(gpio_flash_sel, 1);
> +		gpio_direction_output(gpio_flash_oe, 0);
> +		altera_current_storage = ALTERA_QSPI;
> +		writel(QSPI_CLK_DIV, ALTERA_CLKMGR_MAINPLL_CNTR6CLK_BASE);
> +		break;
> +	default:
> +		altera_current_storage = ALTERA_NONE;
> +		break;
> +	}
> +
> +	gpio_free(gpio_flash_sel);
> +	gpio_free(gpio_flash_oe);
> +}
> +
> +static int altera_set_storage_cmd(struct cmd_tbl *cmdtp, int flag,
> +			   int argc, char * const argv[])
> +{
> +	if (argc != 2)
> +		return CMD_RET_USAGE;
> +
> +	if (!strcmp(argv[1], "MMC"))
> +		altera_set_storage(ALTERA_MMC);
> +	else if (!strcmp(argv[1], "QSPI"))
> +		altera_set_storage(ALTERA_QSPI);
> +	else if (!strcmp(argv[1], "EMMC"))
> +		altera_set_storage(ALTERA_EMMC);
> +	else
> +		return CMD_RET_USAGE;
> +
> +	return CMD_RET_SUCCESS;
> +}
> +
> +U_BOOT_CMD(altera_set_storage, 2, 0, altera_set_storage_cmd,
> +	   "Set non volatile memory access",
> +	   "<MMC|QSPI|EMMC> - Set access for the selected memory device");
> diff --git a/board/enclustra/mercury_aa1/bitstream.its b/board/enclustra/mercury_aa1/bitstream.its
> new file mode 100644
> index 0000000000..d16e4598de
> --- /dev/null
> +++ b/board/enclustra/mercury_aa1/bitstream.its
> @@ -0,0 +1,32 @@
> +/dts-v1/;
> +
> +/ {
> +	description = "FIT image with FPGA bistream";
> +	#address-cells = <1>;

This address-cells shouldn't be needed here ?

> +
> +	images {
> +		fpga-periph-1 {
> +			description = "FPGA peripheral bitstream";
> +			data = /incbin/("bitstream.periph.rbf");
> +			type = "fpga";
> +			arch = "arm";
> +			compression = "none";
> +		};
> +
> +		fpga-core-1 {
> +			description = "FPGA core bitstream";
> +			data = /incbin/("bitstream.core.rbf");
> +			type = "fpga";
> +			arch = "arm";
> +			compression = "none";
> +		};
> +	};
> +
> +	configurations {
> +		default = "config-1";
> +		config-1 {
> +			description = "Boot with FPGA early IO release config";
> +			fpga = "fpga-periph-1", "fpga-core-1";
> +		};
> +	};
> +};

[...]

> diff --git a/include/configs/socfpga_mercury_aa1.h b/include/configs/socfpga_mercury_aa1.h
> new file mode 100644
> index 0000000000..a5b63336e8
> --- /dev/null
> +++ b/include/configs/socfpga_mercury_aa1.h
> @@ -0,0 +1,33 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (C) 2024 Enclustra GmbH
> + * <info@enclustra.com>
> + */
> +
> +#ifndef __CONFIG_SOCFGPA_MERCURY_AA1_H__
> +#define __CONFIG_SOCFGPA_MERCURY_AA1_H__
> +
> +#include <asm/arch/base_addr_a10.h>
> +
> +/*
> + * U-Boot general configurations
> + */
> +
> +/* Memory configurations  */
> +#define PHYS_SDRAM_1_SIZE		0x80000000
> +
> +/*
> + * Serial / UART configurations
> + */
> +#define CFG_SYS_BAUDRATE_TABLE {4800, 9600, 19200, 38400, 57600, 115200}

Is this needed or is the default baud rate table enough ?

> +/*
> + * L4 OSC1 Timer 0
> + */
> +/* reload value when timer count to zero */
> +#define TIMER_LOAD_VAL			0xFFFFFFFF
Is this needed ?
