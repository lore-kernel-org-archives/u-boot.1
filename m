Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 963F9C4828F
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 15:53:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC3728767C;
	Fri,  2 Feb 2024 16:53:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="PuGvMPm/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14B0F877BB; Fri,  2 Feb 2024 16:53:41 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8207875FD
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 16:53:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 412FrW89127409;
 Fri, 2 Feb 2024 09:53:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706889212;
 bh=XOkx370mc/9oGaQ6SVt7aBo/GWsMJVNfl2FTgVdnFmk=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=PuGvMPm/UCT6g+eY6wIYUmQoH2/NTOlMEEqkpmyEJpy5w0UFYWM8zCTJnruuXC0fN
 N9ZZxF2jp3oLt2o6Xlk41iu+kwVuBxNv5S35k4M331H05k96ZmgR+MRLGVW+Uzzqli
 JX5qaW1KJkSz0QH4ThdEGZ7yZbxKE7hSzBAblUAU=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 412FrWLk127948
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 2 Feb 2024 09:53:32 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 2
 Feb 2024 09:53:31 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 2 Feb 2024 09:53:31 -0600
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 412FrVp7015029;
 Fri, 2 Feb 2024 09:53:31 -0600
Message-ID: <f5dc14c5-1537-4bd6-aec2-cf7f3da20a36@ti.com>
Date: Fri, 2 Feb 2024 09:53:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/13] arm: dts: introduce am62p5 uboot dts files
To: Bryan Brattlof <bb@ti.com>, Tom Rini <trini@konsulko.com>, Vignesh
 Raghavendra <vigneshr@ti.com>, Hari Nagalla <hnagalla@ti.com>
CC: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Nishanth Menon <nm@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 UBoot Mailing List <u-boot@lists.denx.de>
References: <20240201030634.1120963-16-bb@ti.com>
 <20240201030634.1120963-27-bb@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240201030634.1120963-27-bb@ti.com>
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

On 1/31/24 9:06 PM, Bryan Brattlof wrote:
> Include the uboot device tree files needed to boot the board.
> 
> Signed-off-by: Bryan Brattlof <bb@ti.com>
> ---
>   arch/arm/dts/Makefile                      |    2 +
>   arch/arm/dts/k3-am62p-ddr-lp4-50-1600.dtsi | 2800 ++++++++++++++++++++
>   arch/arm/dts/k3-am62p-sk-binman.dtsi       |  173 ++
>   arch/arm/dts/k3-am62p5-r5-sk.dts           |  101 +
>   arch/arm/dts/k3-am62p5-sk-u-boot.dtsi      |   49 +
>   arch/arm/mach-k3/Makefile                  |    1 +
>   arch/arm/mach-k3/am62p5_init.c             |    4 +-
>   dts/arch/arm64/ti                          |    1 +
>   8 files changed, 3129 insertions(+), 2 deletions(-)
>   create mode 100644 arch/arm/dts/k3-am62p-ddr-lp4-50-1600.dtsi
>   create mode 100644 arch/arm/dts/k3-am62p-sk-binman.dtsi
>   create mode 100644 arch/arm/dts/k3-am62p5-r5-sk.dts
>   create mode 100644 arch/arm/dts/k3-am62p5-sk-u-boot.dtsi
>   create mode 120000 dts/arch/arm64/ti
> 
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index 34ebf2b58417d..36de84287d4c2 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -1424,6 +1424,8 @@ dtb-$(CONFIG_SOC_K3_AM625) += k3-am625-sk.dtb \
>   dtb-$(CONFIG_SOC_K3_AM62A7) += k3-am62a7-sk.dtb \
>   			      k3-am62a7-r5-sk.dtb
>   
> +dtb-$(CONFIG_SOC_K3_AM62P5) += k3-am62p5-r5-sk.dtb
> +
>   dtb-$(CONFIG_ARCH_MEDIATEK) += \
>   	mt7622-rfb.dtb \
>   	mt7623a-unielec-u7623-02-emmc.dtb \
> diff --git a/arch/arm/dts/k3-am62p-ddr-lp4-50-1600.dtsi b/arch/arm/dts/k3-am62p-ddr-lp4-50-1600.dtsi
> new file mode 100644
> index 0000000000000..f66435201530f
> --- /dev/null
> +++ b/arch/arm/dts/k3-am62p-ddr-lp4-50-1600.dtsi
> @@ -0,0 +1,2800 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * This file was generated with the
> + * AM62Px SysConfig DDR Subsystem Register Configuration Tool v0.10.02
> + * Thu Jan 25 2024 10:43:46 GMT-0600 (Central Standard Time)
> + * DDR Type: LPDDR4
> + * F0 = 50MHz    F1 = NA     F2 = 1600MHz
> + * Density (per channel): 16Gb
> + * Number of Ranks: 2
> + */
> +
> +#define DDRSS_PLL_FHS_CNT 5
> +#define DDRSS_PLL_FREQUENCY_1 800000000
> +#define DDRSS_PLL_FREQUENCY_2 800000000
> +#define DDRSS_SDRAM_IDX 17
> +#define DDRSS_REGION_IDX 17
> +
> +#define DDRSS_CTL_0_DATA 0x00000B00
> +#define DDRSS_CTL_1_DATA 0x00000000
> +#define DDRSS_CTL_2_DATA 0x00000000
> +#define DDRSS_CTL_3_DATA 0x00000000
> +#define DDRSS_CTL_4_DATA 0x00000000
> +#define DDRSS_CTL_5_DATA 0x00000000

I wonder if it would be better to generate this file
during build..

[...]

> +&main_bcdma {
> +	reg = <0x00 0x485c0100 0x00 0x100>,
> +	      <0x00 0x4c000000 0x00 0x20000>,
> +	      <0x00 0x4a820000 0x00 0x20000>,
> +	      <0x00 0x4aa40000 0x00 0x20000>,
> +	      <0x00 0x4bc00000 0x00 0x100000>,
> +	      <0x00 0x48600000 0x00 0x8000>,
> +	      <0x00 0x484a4000 0x00 0x2000>,
> +	      <0x00 0x484c2000 0x00 0x2000>;
> +	reg-names = "gcfg", "bchanrt", "rchanrt", "tchanrt",
> +		    "ringrt", "cfg", "tchan", "rchan";
> +};
> +

Do we still need these? Thought they got fixed kernel side already.

> +&main_pktdma {
> +	reg = <0x00 0x485c0000 0x00 0x100>,
> +	      <0x00 0x4a800000 0x00 0x20000>,
> +	      <0x00 0x4aa00000 0x00 0x40000>,
> +	      <0x00 0x4b800000 0x00 0x400000>,
> +	      <0x00 0x485e0000 0x00 0x20000>,
> +	      <0x00 0x484a0000 0x00 0x4000>,
> +	      <0x00 0x484c0000 0x00 0x2000>,
> +	      <0x00 0x48430000 0x00 0x4000>;
> +	reg-names = "gcfg", "rchanrt", "tchanrt", "ringrt",
> +		    "cfg", "tchan", "rchan", "rflow";
> +};
> diff --git a/arch/arm/mach-k3/Makefile b/arch/arm/mach-k3/Makefile
> index 42161376469e2..820b313a83c23 100644
> --- a/arch/arm/mach-k3/Makefile
> +++ b/arch/arm/mach-k3/Makefile
> @@ -20,5 +20,6 @@ obj-$(CONFIG_SOC_K3_J721S2) += j721s2_init.o
>   obj-$(CONFIG_SOC_K3_AM642) += am642_init.o
>   obj-$(CONFIG_SOC_K3_AM625) += am625_init.o
>   obj-$(CONFIG_SOC_K3_AM62A7) += am62a7_init.o
> +obj-$(CONFIG_SOC_K3_AM62P5) += am62p5_init.o
>   endif
>   obj-y += common.o security.o
> diff --git a/arch/arm/mach-k3/am62p5_init.c b/arch/arm/mach-k3/am62p5_init.c
> index 5b6795cc7d246..9ff877d5d26e8 100644
> --- a/arch/arm/mach-k3/am62p5_init.c
> +++ b/arch/arm/mach-k3/am62p5_init.c
> @@ -110,7 +110,7 @@ void board_init_f(ulong dummy)
>   	 * through a SYSFW PM-init step and will need a re-init in some way
>   	 * due to changing module clock frequencies.
>   	 */
> -	if (IS_ENABLED(CONFIG_K3_EARLY_CONS))
> +	if (IS_ENABLED(CONFIG_K3_EARLY_CONS)) {

Looks like fixes for a previous patch that didn't get squashed.

Andrew

>   		ret = early_console_init();
>   		if (ret)
>   			panic("early_console_init() failed: %d\n", ret);
> @@ -122,7 +122,7 @@ void board_init_f(ulong dummy)
>   	 * callback hook, effectively switching on (or over) the console
>   	 * output.
>   	 */
> -	if (IS_ENABLED(CONFIG_K3_LOAD_SYSFW) {
> +	if (IS_ENABLED(CONFIG_K3_LOAD_SYSFW)) {
>   		ret = is_rom_loaded_sysfw(&bootdata);
>   		if (!ret)
>   			panic("ROM has not loaded TIFS firmware\n");
> diff --git a/dts/arch/arm64/ti b/dts/arch/arm64/ti
> new file mode 120000
> index 0000000000000..5ed559a6d0849
> --- /dev/null
> +++ b/dts/arch/arm64/ti
> @@ -0,0 +1 @@
> +../../../devicetree-rebasing/src/arm64/ti/
> \ No newline at end of file
