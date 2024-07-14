Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D48FC3DA49
	for <u-boot@archiver.kernel.org>; Sun, 14 Jul 2024 15:49:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C46D3880F9;
	Sun, 14 Jul 2024 17:49:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="dxg7hesP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3F3F88168; Sun, 14 Jul 2024 17:49:12 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D22D187FA7
 for <u-boot@lists.denx.de>; Sun, 14 Jul 2024 17:49:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1720972127; x=1721576927; i=xypron.glpk@gmx.de;
 bh=4H1CO/91rwEf3ZiCYVI7frd5+H91q1Edc/0LRpqpGmQ=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=dxg7hesPjaudEv/MDkkwAhq1AZG3aKpCDFV4X1llUyIal1H/423ym2FwnMeJcL4W
 LUwMhQSXCHriZULMttH7mbN/8Qc/IH+HJb+CSblZH2TIZD7xVOM79ppxl9C4eJeQG
 LnL8jNoXX/EYWY45RLxdLehwfrbF4dahzKCIqVKy0zAcm49R5gfHRmpKE4BPj8FMz
 3RjntKcKAAgZh6eIA/pgBtsS5JUlvcYKTp/2JsReDnnqcgmxWTQgsU15Sz/zCJN+T
 jlCd5lEx/ZIptYu/IqmMeobaUX0jNm7u95C5/Eu9XpyaDd7eLs4FuVrpi7qxe2jzV
 CzAmj+KGwOCk+cEYGg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([62.143.93.80]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N1fis-1sMBvj2X1s-00tJya; Sun, 14
 Jul 2024 17:48:47 +0200
Message-ID: <ebd5ff75-5971-47ec-be02-9b51346af4c4@gmx.de>
Date: Sun, 14 Jul 2024 17:48:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] riscv: spacemit: bananapi_f3: initial support added
To: Kongyang Liu <seashell11234455@gmail.com>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, Bin Meng <bmeng@tinylab.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, Leo <ycliang@andestech.com>,
 Michal Simek <michal.simek@amd.com>,
 Padmarao Begari <padmarao.begari@microchip.com>,
 Randolph <randolph@andestech.com>, Rick Chen <rick@andestech.com>,
 Samuel Holland <samuel@sholland.org>, Tom Rini <trini@konsulko.com>,
 Yu Chien Peter Lin <peterlin@andestech.com>, u-boot@lists.denx.de
References: <20240714150828.736-1-seashell11234455@gmail.com>
 <20240714150828.736-2-seashell11234455@gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240714150828.736-2-seashell11234455@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ff0Qm2Aq8zY0DiQyZHVVacdoyMCfNpd9bwtSn+0KeNecJB4le/L
 +RofQcddEzGRk6X8+IZJjemNTSQg+tP7geVOqsiKTwLBgPcni/CVUR1jvfqEO8z40Cc+ccV
 kPAK5d6kj1/iZOHEbRETfPU+G33KOoUeghihcNAC9YqL9W3F5iad1nKRHXCugb1/ZHTBPN7
 JYFbMPc4LLijubsndpIdw==
UI-OutboundReport: notjunk:1;M01:P0:tzktjw9ijyU=;6AEUqgzeeltnv9KAuDmyFGBGZjd
 1utbUTxzpBw2VIyVz3BBAuVxpkZ3ZRwBSvCm/mozloorxq9rqNqFTx6m9734mV7JXMN2JSE9k
 mLLQfbbUFJ6V6vFFC8k2BNRLec+luCUrlMAB+NfPBJeqoYZXwtkMUPmySW5y1z8YDoLse9gFJ
 plSbop+Vz9rLcHmDLRRVkohE+w3hBMk/D+9z2feyGR78hpXJ8HwP4zUcuNF0kaspTgLKj2sTQ
 UabMUQ3unlv6u74vpLnsKBMHxwP+3luouhF4xCwqi1JnHLxicXXuDXtQYDafSXW+VJHV76WHm
 4iv2NNewcIpCF2YnSLwiYGlOEwFfYj5c8epBR3KpPZO9EiwYHlN91k5rXmeCq/XlfszRusOKg
 sHhlKn/ylJZudTmTXYGtFYIZkqoy22ykwa3OZghVSeJn8QX3AaBVgJJDb6QoMs0D8ST36jIuk
 PH6VXNXuyLKXL9WDqYInjDp1Yr603ep77BjeVByx2FFNDYbZ22gfk95SSSMUOTq9ObgKGpuYZ
 vMNhW4JBvVMwITVafWdIt5lotyRdRfkWij8BA8wUWEfwj5QtcAyXykCwf9FTo4dzYWrBenCy/
 TO6rxTei54YDw3GQmatNyHkDFTPJBXP5JtjRQmypWwWa6zKsCfSlYRHLJNAswSIGSBrLrFMHS
 Kp7F97g1eb8OXJttbGCcKbdE4vcqVIcR+bQRg5vw0HO4Epay7R2C1deQagJ57XxVAUrsVs6Ls
 9n2z6poLaGm+8ralhan62ZOS64ArFHsiI86PfB3MFc2Y8vay0oEYyLNpTNGpGPwYcCQBHjt6v
 40zDwBuqUyt5r9KwjKuEdPxA==
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

On 7/14/24 17:08, Kongyang Liu wrote:
> Add basic support for SpacemiT's Banana Pi F3 board
>
> Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
>
> ---
>
>   arch/riscv/Kconfig                     |   5 +
>   arch/riscv/cpu/k1/Kconfig              |  18 ++
>   arch/riscv/cpu/k1/Makefile             |   6 +
>   arch/riscv/cpu/k1/cpu.c                |   9 +
>   arch/riscv/cpu/k1/dram.c               |  39 +++
>   arch/riscv/dts/Makefile                |   1 +
>   arch/riscv/dts/k1-bananapi-f3.dts      |  20 ++
>   arch/riscv/dts/k1.dtsi                 | 375 +++++++++++++++++++++++++
>   board/spacemit/bananapi_f3/Kconfig     |  25 ++
>   board/spacemit/bananapi_f3/MAINTAINERS |   6 +
>   board/spacemit/bananapi_f3/Makefile    |   5 +
>   board/spacemit/bananapi_f3/board.c     |   9 +
>   configs/bananapi_f3_defconfig          |  20 ++
>   include/configs/bananapi_f3.h          |  15 +
>   14 files changed, 553 insertions(+)
>   create mode 100644 arch/riscv/cpu/k1/Kconfig
>   create mode 100644 arch/riscv/cpu/k1/Makefile
>   create mode 100644 arch/riscv/cpu/k1/cpu.c
>   create mode 100644 arch/riscv/cpu/k1/dram.c
>   create mode 100644 arch/riscv/dts/k1-bananapi-f3.dts
>   create mode 100644 arch/riscv/dts/k1.dtsi
>   create mode 100644 board/spacemit/bananapi_f3/Kconfig
>   create mode 100644 board/spacemit/bananapi_f3/MAINTAINERS
>   create mode 100644 board/spacemit/bananapi_f3/Makefile
>   create mode 100644 board/spacemit/bananapi_f3/board.c
>   create mode 100644 configs/bananapi_f3_defconfig
>   create mode 100644 include/configs/bananapi_f3.h
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index fa3b016c52..211f19a585 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -11,6 +11,9 @@ choice
>   config TARGET_ANDES_AE350
>   	bool "Support Andes ae350"
>
> +config TARGET_BANANAPI_F3
> +	bool "Support BananaPi F3 Board"
> +
>   config TARGET_MICROCHIP_ICICLE
>   	bool "Support Microchip PolarFire-SoC Icicle Board"
>
> @@ -88,6 +91,7 @@ source "board/sifive/unleashed/Kconfig"
>   source "board/sifive/unmatched/Kconfig"
>   source "board/sipeed/maix/Kconfig"
>   source "board/sophgo/milkv_duo/Kconfig"
> +source "board/spacemit/bananapi_f3/Kconfig"
>   source "board/starfive/visionfive2/Kconfig"
>   source "board/thead/th1520_lpi4a/Kconfig"
>   source "board/xilinx/mbv/Kconfig"
> @@ -99,6 +103,7 @@ source "arch/riscv/cpu/fu540/Kconfig"
>   source "arch/riscv/cpu/fu740/Kconfig"
>   source "arch/riscv/cpu/generic/Kconfig"
>   source "arch/riscv/cpu/jh7110/Kconfig"
> +source "arch/riscv/cpu/k1/Kconfig"
>
>   # architecture-specific options below
>
> diff --git a/arch/riscv/cpu/k1/Kconfig b/arch/riscv/cpu/k1/Kconfig
> new file mode 100644
> index 0000000000..79c9fefb66
> --- /dev/null
> +++ b/arch/riscv/cpu/k1/Kconfig
> @@ -0,0 +1,18 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +# Copyright (C) 2024, Kongyang Liu <seashell11234455@gmail.com>
> +
> +config SPACEMIT_K1
> +	bool
> +	select BINMAN
> +	select ARCH_EARLY_INIT_R
> +	select SYS_CACHE_SHIFT_6
> +	imply CPU
> +	imply CPU_RISCV
> +	imply RISCV_TIMER if (RISCV_SMODE || SPL_RISCV_SMODE)
> +	imply RISCV_ACLINT if RISCV_MMODE
> +	imply SPL_RISCV_ACLINT if SPL_RISCV_MMODE
> +	imply CMD_CPU
> +	imply SPL_CPU
> +	imply SPL_OPENSBI
> +	imply SPL_LOAD_FIT
> diff --git a/arch/riscv/cpu/k1/Makefile b/arch/riscv/cpu/k1/Makefile
> new file mode 100644
> index 0000000000..da12e0f64e
> --- /dev/null
> +++ b/arch/riscv/cpu/k1/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +# Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
> +
> +obj-y +=3D dram.o
> +obj-y +=3D cpu.o
> diff --git a/arch/riscv/cpu/k1/cpu.c b/arch/riscv/cpu/k1/cpu.c
> new file mode 100644
> index 0000000000..233a6a3d64
> --- /dev/null
> +++ b/arch/riscv/cpu/k1/cpu.c
> @@ -0,0 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0+

Thanks a lot for adding the board.

GPL-2.0-or-later, see https://spdx.org/licenses/GPL-2.0-or-later.html

> +/*
> + * Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
> + */
> +
> +int cleanup_before_linux(void)
> +{
> +	return 0;
> +}
> diff --git a/arch/riscv/cpu/k1/dram.c b/arch/riscv/cpu/k1/dram.c
> new file mode 100644
> index 0000000000..41a596eef4
> --- /dev/null
> +++ b/arch/riscv/cpu/k1/dram.c
> @@ -0,0 +1,39 @@
> +// SPDX-License-Identifier: GPL-2.0+

ditto

> +/*
> + * Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
> + */
> +
> +#include <asm/global_data.h>
> +#include <config.h>
> +#include <linux/sizes.h>
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +int dram_init(void)
> +{
> +	gd->ram_base =3D CFG_SYS_SDRAM_BASE;
> +	/* TODO get ram size from ddr controller */
> +	gd->ram_size =3D SZ_4G;
> +	return 0;
> +}
> +
> +int dram_init_banksize(void)
> +{
> +	gd->bd->bi_dram[0].start =3D CFG_SYS_SDRAM_BASE;
> +	gd->bd->bi_dram[0].size =3D min_t(phys_size_t, gd->ram_size, SZ_2G);
> +
> +	if (gd->ram_size > SZ_2G && CONFIG_NR_DRAM_BANKS > 1) {
> +		gd->bd->bi_dram[1].start =3D 0x100000000;
> +		gd->bd->bi_dram[1].size =3D gd->ram_size - SZ_2G;
> +	}
> +
> +	return 0;
> +}
> +
> +phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
> +{
> +	if (gd->ram_size > SZ_2G)
> +		return SZ_2G;
> +
> +	return gd->ram_size;
> +}
> diff --git a/arch/riscv/dts/Makefile b/arch/riscv/dts/Makefile
> index 17cda483e1..71267f96f8 100644
> --- a/arch/riscv/dts/Makefile
> +++ b/arch/riscv/dts/Makefile
> @@ -1,6 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0+
>
>   dtb-$(CONFIG_TARGET_ANDES_AE350) +=3D ae350_32.dtb ae350_64.dtb
> +dtb-$(CONFIG_TARGET_BANANAPI_F3) +=3D k1-bananapi-f3.dtb
>   dtb-$(CONFIG_TARGET_MICROCHIP_ICICLE) +=3D mpfs-icicle-kit.dtb
>   dtb-$(CONFIG_TARGET_MILKV_DUO) +=3D cv1800b-milkv-duo.dtb
>   dtb-$(CONFIG_TARGET_QEMU_VIRT) +=3D qemu-virt32.dtb qemu-virt64.dtb
> diff --git a/arch/riscv/dts/k1-bananapi-f3.dts b/arch/riscv/dts/k1-banan=
api-f3.dts
> new file mode 100644
> index 0000000000..542049d9d3
> --- /dev/null
> +++ b/arch/riscv/dts/k1-bananapi-f3.dts
> @@ -0,0 +1,20 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Copyright (C) 2024 Yangyu Chen <cyy@cyyself.name>
> + */
> +
> +#include "k1.dtsi"
> +#include "binman.dtsi"
> +
> +/ {
> +	model =3D "Banana Pi BPI-F3";
> +	compatible =3D "bananapi,bpi-f3", "spacemit,k1";
> +
> +	chosen {
> +		stdout-path =3D "serial0";
> +	};
> +};
> +
> +&uart0 {
> +	status =3D "okay";
> +};
> diff --git a/arch/riscv/dts/k1.dtsi b/arch/riscv/dts/k1.dtsi
> new file mode 100644
> index 0000000000..b301f45fd5
> --- /dev/null
> +++ b/arch/riscv/dts/k1.dtsi
> @@ -0,0 +1,375 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT

Elsewhere you use GPL-2.0-or-later. Any special reason to be more
restrictive here?

> +/*
> + * Copyright (C) 2024 Yangyu Chen <cyy@cyyself.name>
> + */
> +
> +/dts-v1/;
> +/ {
> +	#address-cells =3D <2>;
> +	#size-cells =3D <2>;
> +	model =3D "SpacemiT K1";
> +	compatible =3D "spacemit,k1";

According to the devicetree specification "a memory device node is
required for all devicetrees".

> +
> +	aliases {
> +		serial0 =3D &uart0;
> +		serial1 =3D &uart2;
> +		serial2 =3D &uart3;
> +		serial3 =3D &uart4;
> +		serial4 =3D &uart5;
> +		serial5 =3D &uart6;
> +		serial6 =3D &uart7;
> +		serial7 =3D &uart8;
> +		serial8 =3D &uart9;
> +	};
> +
> +	cpus {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +		timebase-frequency =3D <24000000>;
> +
> +		cpu-map {
> +			cluster0 {
> +				core0 {
> +					cpu =3D <&cpu_0>;
> +				};
> +				core1 {
> +					cpu =3D <&cpu_1>;
> +				};
> +				core2 {
> +					cpu =3D <&cpu_2>;
> +				};
> +				core3 {
> +					cpu =3D <&cpu_3>;
> +				};
> +			};
> +
> +			cluster1 {
> +				core0 {
> +					cpu =3D <&cpu_4>;
> +				};
> +				core1 {
> +					cpu =3D <&cpu_5>;
> +				};
> +				core2 {
> +					cpu =3D <&cpu_6>;
> +				};
> +				core3 {
> +					cpu =3D <&cpu_7>;
> +				};
> +			};
> +		};
> +
> +		cpu_0: cpu@0 {
> +			compatible =3D "spacemit,x60", "riscv";
> +			device_type =3D "cpu";
> +			reg =3D <0>;
> +			riscv,isa =3D "rv64imafdcv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_=
zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc=
_svinval_svnapot_svpbmt";
> +			riscv,isa-base =3D "rv64i";
> +			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "v", "zicbom"=
,
> +					       "zicbop", "zicboz", "zicntr", "zicond", "zicsr",
> +					       "zifencei", "zihintpause", "zihpm", "zfh", "zba",
> +					       "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
> +					       "sscofpmf", "sstc", "svinval", "svnapot", "svpbmt";
> +			riscv,cbom-block-size =3D <64>;
> +			riscv,cbop-block-size =3D <64>;
> +			riscv,cboz-block-size =3D <64>;
> +			mmu-type =3D "riscv,sv39";
> +
> +			cpu0_intc: interrupt-controller {
> +				compatible =3D "riscv,cpu-intc";
> +				interrupt-controller;
> +				#interrupt-cells =3D <1>;
> +			};
> +		};
> +
> +		cpu_1: cpu@1 {
> +			compatible =3D "spacemit,x60", "riscv";
> +			device_type =3D "cpu";
> +			reg =3D <1>;
> +			riscv,isa =3D "rv64imafdcv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_=
zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc=
_svinval_svnapot_svpbmt";
> +			riscv,isa-base =3D "rv64i";
> +			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "v", "zicbom"=
,
> +					       "zicbop", "zicboz", "zicntr", "zicond", "zicsr",
> +					       "zifencei", "zihintpause", "zihpm", "zfh", "zba",
> +					       "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
> +					       "sscofpmf", "sstc", "svinval", "svnapot", "svpbmt";
> +			riscv,cbom-block-size =3D <64>;
> +			riscv,cbop-block-size =3D <64>;
> +			riscv,cboz-block-size =3D <64>;
> +			mmu-type =3D "riscv,sv39";
> +
> +			cpu1_intc: interrupt-controller {
> +				compatible =3D "riscv,cpu-intc";
> +				interrupt-controller;
> +				#interrupt-cells =3D <1>;
> +			};
> +		};
> +
> +		cpu_2: cpu@2 {
> +			compatible =3D "spacemit,x60", "riscv";
> +			device_type =3D "cpu";
> +			reg =3D <2>;
> +			riscv,isa =3D "rv64imafdcv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_=
zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc=
_svinval_svnapot_svpbmt";
> +			riscv,isa-base =3D "rv64i";
> +			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "v", "zicbom"=
,
> +					       "zicbop", "zicboz", "zicntr", "zicond", "zicsr",
> +					       "zifencei", "zihintpause", "zihpm", "zfh", "zba",
> +					       "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
> +					       "sscofpmf", "sstc", "svinval", "svnapot", "svpbmt";
> +			riscv,cbom-block-size =3D <64>;
> +			riscv,cbop-block-size =3D <64>;
> +			riscv,cboz-block-size =3D <64>;
> +			mmu-type =3D "riscv,sv39";
> +
> +			cpu2_intc: interrupt-controller {
> +				compatible =3D "riscv,cpu-intc";
> +				interrupt-controller;
> +				#interrupt-cells =3D <1>;
> +			};
> +		};
> +
> +		cpu_3: cpu@3 {
> +			compatible =3D "spacemit,x60", "riscv";
> +			device_type =3D "cpu";
> +			reg =3D <3>;
> +			riscv,isa =3D "rv64imafdcv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_=
zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc=
_svinval_svnapot_svpbmt";
> +			riscv,isa-base =3D "rv64i";
> +			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "v", "zicbom"=
,
> +					       "zicbop", "zicboz", "zicntr", "zicond", "zicsr",
> +					       "zifencei", "zihintpause", "zihpm", "zfh", "zba",
> +					       "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
> +					       "sscofpmf", "sstc", "svinval", "svnapot", "svpbmt";
> +			riscv,cbom-block-size =3D <64>;
> +			riscv,cbop-block-size =3D <64>;
> +			riscv,cboz-block-size =3D <64>;
> +			mmu-type =3D "riscv,sv39";
> +
> +			cpu3_intc: interrupt-controller {
> +				compatible =3D "riscv,cpu-intc";
> +				interrupt-controller;
> +				#interrupt-cells =3D <1>;
> +			};
> +		};
> +
> +		cpu_4: cpu@4 {
> +			compatible =3D "spacemit,x60", "riscv";
> +			device_type =3D "cpu";
> +			reg =3D <4>;
> +			riscv,isa =3D "rv64imafdcv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_=
zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc=
_svinval_svnapot_svpbmt";
> +			riscv,isa-base =3D "rv64i";
> +			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "v", "zicbom"=
,
> +					       "zicbop", "zicboz", "zicntr", "zicond", "zicsr",
> +					       "zifencei", "zihintpause", "zihpm", "zfh", "zba",
> +					       "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
> +					       "sscofpmf", "sstc", "svinval", "svnapot", "svpbmt";
> +			riscv,cbom-block-size =3D <64>;
> +			riscv,cbop-block-size =3D <64>;
> +			riscv,cboz-block-size =3D <64>;
> +			mmu-type =3D "riscv,sv39";
> +
> +			cpu4_intc: interrupt-controller {
> +				compatible =3D "riscv,cpu-intc";
> +				interrupt-controller;
> +				#interrupt-cells =3D <1>;
> +			};
> +		};
> +
> +		cpu_5: cpu@5 {
> +			compatible =3D "spacemit,x60", "riscv";
> +			device_type =3D "cpu";
> +			reg =3D <5>;
> +			riscv,isa =3D "rv64imafdcv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_=
zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc=
_svinval_svnapot_svpbmt";
> +			riscv,isa-base =3D "rv64i";
> +			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "v", "zicbom"=
,
> +					       "zicbop", "zicboz", "zicntr", "zicond", "zicsr",
> +					       "zifencei", "zihintpause", "zihpm", "zfh", "zba",
> +					       "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
> +					       "sscofpmf", "sstc", "svinval", "svnapot", "svpbmt";
> +			riscv,cbom-block-size =3D <64>;
> +			riscv,cbop-block-size =3D <64>;
> +			riscv,cboz-block-size =3D <64>;
> +			mmu-type =3D "riscv,sv39";
> +
> +			cpu5_intc: interrupt-controller {
> +				compatible =3D "riscv,cpu-intc";
> +				interrupt-controller;
> +				#interrupt-cells =3D <1>;
> +			};
> +		};
> +
> +		cpu_6: cpu@6 {
> +			compatible =3D "spacemit,x60", "riscv";
> +			device_type =3D "cpu";
> +			reg =3D <6>;
> +			riscv,isa =3D "rv64imafdcv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_=
zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc=
_svinval_svnapot_svpbmt";
> +			riscv,isa-base =3D "rv64i";
> +			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "v", "zicbom"=
,
> +					       "zicbop", "zicboz", "zicntr", "zicond", "zicsr",
> +					       "zifencei", "zihintpause", "zihpm", "zfh", "zba",
> +					       "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
> +					       "sscofpmf", "sstc", "svinval", "svnapot", "svpbmt";
> +			riscv,cbom-block-size =3D <64>;
> +			riscv,cbop-block-size =3D <64>;
> +			riscv,cboz-block-size =3D <64>;
> +			mmu-type =3D "riscv,sv39";
> +
> +			cpu6_intc: interrupt-controller {
> +				compatible =3D "riscv,cpu-intc";
> +				interrupt-controller;
> +				#interrupt-cells =3D <1>;
> +			};
> +		};
> +
> +		cpu_7: cpu@7 {
> +			compatible =3D "spacemit,x60", "riscv";
> +			device_type =3D "cpu";
> +			reg =3D <7>;
> +			riscv,isa =3D "rv64imafdcv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_=
zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc=
_svinval_svnapot_svpbmt";
> +			riscv,isa-base =3D "rv64i";
> +			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "v", "zicbom"=
,
> +					       "zicbop", "zicboz", "zicntr", "zicond", "zicsr",
> +					       "zifencei", "zihintpause", "zihpm", "zfh", "zba",
> +					       "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
> +					       "sscofpmf", "sstc", "svinval", "svnapot", "svpbmt";
> +			riscv,cbom-block-size =3D <64>;
> +			riscv,cbop-block-size =3D <64>;
> +			riscv,cboz-block-size =3D <64>;
> +			mmu-type =3D "riscv,sv39";
> +
> +			cpu7_intc: interrupt-controller {
> +				compatible =3D "riscv,cpu-intc";
> +				interrupt-controller;
> +				#interrupt-cells =3D <1>;
> +			};
> +		};
> +	};
> +
> +	soc {
> +		compatible =3D "simple-bus";
> +		interrupt-parent =3D <&plic>;
> +		#address-cells =3D <2>;
> +		#size-cells =3D <2>;
> +		dma-noncoherent;
> +		ranges;
> +
> +		uart0: serial@d4017000 {
> +			compatible =3D "spacemit,k1-uart", "snps,dw-apb-uart";
> +			reg =3D <0x0 0xd4017000 0x0 0x100>;
> +			interrupts =3D <42>;
> +			clock-frequency =3D <14857000>;
> +			reg-shift =3D <2>;
> +			reg-io-width =3D <4>;
> +			status =3D "disabled";
> +		};
> +
> +		uart2: serial@d4017100 {
> +			compatible =3D "spacemit,k1-uart", "snps,dw-apb-uart";
> +			reg =3D <0x0 0xd4017100 0x0 0x100>;
> +			interrupts =3D <44>;
> +			clock-frequency =3D <14857000>;
> +			reg-shift =3D <2>;
> +			reg-io-width =3D <4>;
> +			status =3D "disabled";
> +		};
> +
> +		uart3: serial@d4017200 {
> +			compatible =3D "spacemit,k1-uart", "snps,dw-apb-uart";
> +			reg =3D <0x0 0xd4017200 0x0 0x100>;
> +			interrupts =3D <45>;
> +			clock-frequency =3D <14857000>;
> +			reg-shift =3D <2>;
> +			reg-io-width =3D <4>;
> +			status =3D "disabled";
> +		};
> +
> +		uart4: serial@d4017300 {
> +			compatible =3D "spacemit,k1-uart", "snps,dw-apb-uart";
> +			reg =3D <0x0 0xd4017300 0x0 0x100>;
> +			interrupts =3D <46>;
> +			clock-frequency =3D <14857000>;
> +			reg-shift =3D <2>;
> +			reg-io-width =3D <4>;
> +			status =3D "disabled";
> +		};
> +
> +		uart5: serial@d4017400 {
> +			compatible =3D "spacemit,k1-uart", "snps,dw-apb-uart";
> +			reg =3D <0x0 0xd4017400 0x0 0x100>;
> +			interrupts =3D <47>;
> +			clock-frequency =3D <14857000>;
> +			reg-shift =3D <2>;
> +			reg-io-width =3D <4>;
> +			status =3D "disabled";
> +		};
> +
> +		uart6: serial@d4017500 {
> +			compatible =3D "spacemit,k1-uart", "snps,dw-apb-uart";
> +			reg =3D <0x0 0xd4017500 0x0 0x100>;
> +			interrupts =3D <48>;
> +			clock-frequency =3D <14857000>;
> +			reg-shift =3D <2>;
> +			reg-io-width =3D <4>;
> +			status =3D "disabled";
> +		};
> +
> +		uart7: serial@d4017600 {
> +			compatible =3D "spacemit,k1-uart", "snps,dw-apb-uart";
> +			reg =3D <0x0 0xd4017600 0x0 0x100>;
> +			interrupts =3D <49>;
> +			clock-frequency =3D <14857000>;
> +			reg-shift =3D <2>;
> +			reg-io-width =3D <4>;
> +			status =3D "disabled";
> +		};
> +
> +		uart8: serial@d4017700 {
> +			compatible =3D "spacemit,k1-uart", "snps,dw-apb-uart";
> +			reg =3D <0x0 0xd4017700 0x0 0x100>;
> +			interrupts =3D <50>;
> +			clock-frequency =3D <14857000>;
> +			reg-shift =3D <2>;
> +			reg-io-width =3D <4>;
> +			status =3D "disabled";
> +		};
> +
> +		uart9: serial@d4017800 {
> +			compatible =3D "spacemit,k1-uart", "snps,dw-apb-uart";
> +			reg =3D <0x0 0xd4017800 0x0 0x100>;
> +			interrupts =3D <51>;
> +			clock-frequency =3D <14857000>;
> +			reg-shift =3D <2>;
> +			reg-io-width =3D <4>;
> +			status =3D "disabled";
> +		};
> +
> +		plic: interrupt-controller@e0000000 {
> +			compatible =3D "spacemit,k1-plic", "sifive,plic-1.0.0";
> +			reg =3D <0x0 0xe0000000 0x0 0x4000000>;
> +			interrupts-extended =3D <&cpu0_intc 11>, <&cpu0_intc 9>,
> +					      <&cpu1_intc 11>, <&cpu1_intc 9>,
> +					      <&cpu2_intc 11>, <&cpu2_intc 9>,
> +					      <&cpu3_intc 11>, <&cpu3_intc 9>,
> +					      <&cpu4_intc 11>, <&cpu4_intc 9>,
> +					      <&cpu5_intc 11>, <&cpu5_intc 9>,
> +					      <&cpu6_intc 11>, <&cpu6_intc 9>,
> +					      <&cpu7_intc 11>, <&cpu7_intc 9>;
> +			interrupt-controller;
> +			#address-cells =3D <0>;
> +			#interrupt-cells =3D <1>;
> +			riscv,ndev =3D <159>;
> +		};
> +
> +		clint: timer@e4000000 {
> +			compatible =3D "spacemit,k1-clint", "sifive,clint0";
> +			reg =3D <0x0 0xe4000000 0x0 0x10000>;
> +			interrupts-extended =3D <&cpu0_intc 3>, <&cpu0_intc 7>,
> +					      <&cpu1_intc 3>, <&cpu1_intc 7>,
> +					      <&cpu2_intc 3>, <&cpu2_intc 7>,
> +					      <&cpu3_intc 3>, <&cpu3_intc 7>,
> +					      <&cpu4_intc 3>, <&cpu4_intc 7>,
> +					      <&cpu5_intc 3>, <&cpu5_intc 7>,
> +					      <&cpu6_intc 3>, <&cpu6_intc 7>,
> +					      <&cpu7_intc 3>, <&cpu7_intc 7>;
> +		};
> +	};
> +};
> diff --git a/board/spacemit/bananapi_f3/Kconfig b/board/spacemit/bananap=
i_f3/Kconfig
> new file mode 100644
> index 0000000000..0082a0d2af
> --- /dev/null
> +++ b/board/spacemit/bananapi_f3/Kconfig
> @@ -0,0 +1,25 @@
> +if TARGET_BANANAPI_F3
> +
> +config SYS_BOARD
> +	default "bananapi_f3"
> +
> +config SYS_VENDOR
> +	default "spacemit"
> +
> +config SYS_CPU
> +	default "k1"
> +
> +config SYS_CONFIG_NAME
> +	default "bananapi_f3"
> +
> +config TEXT_BASE
> +	default 0x00200000
> +
> +config SPL_OPENSBI_LOAD_ADDR
> +	default 0x00000000
> +
> +config BOARD_SPECIFIC_OPTIONS
> +	def_bool y
> +	select SPACEMIT_K1
> +
> +endif
> diff --git a/board/spacemit/bananapi_f3/MAINTAINERS b/board/spacemit/ban=
anapi_f3/MAINTAINERS
> new file mode 100644
> index 0000000000..fc0f8487e6
> --- /dev/null
> +++ b/board/spacemit/bananapi_f3/MAINTAINERS
> @@ -0,0 +1,6 @@
> +BananaPi F3
> +M:	Kongyang Liu <seashell11234455@gmail.com>
> +S:	Maintained
> +F:	board/spacemit/bananapi_f3/
> +F:	configs/bananapi_f3_defconfig
> +F:	doc/board/spacemit/bananapi_f3.rst
> diff --git a/board/spacemit/bananapi_f3/Makefile b/board/spacemit/banana=
pi_f3/Makefile
> new file mode 100644
> index 0000000000..a087013f5c
> --- /dev/null
> +++ b/board/spacemit/bananapi_f3/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0+

GPL-2.0-or-later

See https://spdx.org/licenses/GPL-2.0-or-later.html

> +#
> +# Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
> +
> +obj-y :=3D board.o
> diff --git a/board/spacemit/bananapi_f3/board.c b/board/spacemit/bananap=
i_f3/board.c
> new file mode 100644
> index 0000000000..eaa47be173
> --- /dev/null
> +++ b/board/spacemit/bananapi_f3/board.c
> @@ -0,0 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0+

ditto

> +/*
> + * Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
> + */
> +
> +int board_init(void)
> +{
> +	return 0;
> +}
> diff --git a/configs/bananapi_f3_defconfig b/configs/bananapi_f3_defconf=
ig
> new file mode 100644
> index 0000000000..ce197d60bd
> --- /dev/null
> +++ b/configs/bananapi_f3_defconfig
> @@ -0,0 +1,20 @@
> +CONFIG_RISCV=3Dy
> +CONFIG_SYS_MALLOC_LEN=3D0x1000000
> +CONFIG_NR_DRAM_BANKS=3D2
> +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x1000000
> +CONFIG_DEFAULT_DEVICE_TREE=3D"k1-bananapi-f3"

The vendor SPL probably passes a device-tree to OpenSBI.

The BananaPi BPI-F3 is sold with different RAM sizes. SPL might already
have determined the size and added the information to the device-tree.

Could we use that device-tree with CONFIG_OF_BOARD?
We also need the memory reservation added by OpenSBI.

> +CONFIG_SYS_LOAD_ADDR=3D0x200000
> +CONFIG_TARGET_BANANAPI_F3=3Dy
> +CONFIG_ARCH_RV64I=3Dy
> +CONFIG_RISCV_SMODE=3Dy
> +CONFIG_FIT=3Dy
> +CONFIG_SYS_BOOTM_LEN=3D0xa000000
> +CONFIG_SUPPORT_RAW_INITRD=3Dy
> +CONFIG_SYS_CBSIZE=3D256
> +CONFIG_SYS_PBSIZE=3D276
> +CONFIG_HUSH_PARSER=3Dy
> +CONFIG_SYS_PROMPT=3D"bananapi_f3# "

Can we use the default prompt, please. This will make it easier to
support nearly identical boards in future.

Best regards

Heinrich

> +CONFIG_ENV_OVERWRITE=3Dy
> +CONFIG_SYS_NS16550=3Dy
> +CONFIG_SYS_NS16550_MEM32=3Dy
> diff --git a/include/configs/bananapi_f3.h b/include/configs/bananapi_f3=
.h
> new file mode 100644
> index 0000000000..872c2014a4
> --- /dev/null
> +++ b/include/configs/bananapi_f3.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
> + *
> + */
> +
> +#ifndef __CONFIG_H
> +#define __CONFIG_H
> +
> +#include <linux/serial_reg.h>
> +
> +#define CFG_SYS_SDRAM_BASE         0x0
> +#define CFG_SYS_NS16550_IER        UART_IER_UUE
> +
> +#endif /* __CONFIG_H */

