Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE28CA101F
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 01:56:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0BB1831C2;
	Thu, 11 Sep 2025 03:56:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 743F883236; Thu, 11 Sep 2025 03:56:55 +0200 (CEST)
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 136A58319C
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 03:56:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.54] (unknown [98.97.63.30]) (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 9A00FB2201A5;
 Thu, 11 Sep 2025 03:56:50 +0200 (CEST)
Message-ID: <5ce9ad71-2d24-408b-ba55-cd87bf96afb1@freeshell.de>
Date: Wed, 10 Sep 2025 18:56:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/8] imx9: scmi: Update the files under
 arch/arm/mach-imx/imx9/scmi/ to support i.MX94
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>
References: <20250901-imx94-v1-0-c85ae7cdd95c@oss.nxp.com>
 <20250901-imx94-v1-4-c85ae7cdd95c@oss.nxp.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20250901-imx94-v1-4-c85ae7cdd95c@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
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

Hi Alice,

On 9/1/25 03:48, Alice Guo (OSS) wrote:
> From: Ye Li <ye.li@nxp.com>
> 
> - Add base addresses for WDG3, WDG4, GPIO6, and GPIO7 for i.MX94.
> - Introduce common.h with macros of clock IDs, power domains, and CPU
>   types for platform-specific replacement (e.g., i.MX94, i.MX95).
> - Extend imx_get_mac_from_fuse() to support i.MX94.
> 
> Signed-off-by: Ye Li <ye.li@nxp.com>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> Acked-by: Peng Fan <peng.fan@nxp.com>
> Reviewed-by: Jacky Bai <ping.bai@nxp.com>
> ---
>  arch/arm/include/asm/arch-imx9/imx-regs.h |  9 ++++++
>  arch/arm/mach-imx/imx9/scmi/clock.c       | 28 +++++++++--------
>  arch/arm/mach-imx/imx9/scmi/common.h      | 41 +++++++++++++++++++++++++
>  arch/arm/mach-imx/imx9/scmi/soc.c         | 50 ++++++++++++++++++++++++-------
>  4 files changed, 105 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/arm/include/asm/arch-imx9/imx-regs.h b/arch/arm/include/asm/arch-imx9/imx-regs.h
> index 5127fe8f286..a44fa6663c3 100644
> --- a/arch/arm/include/asm/arch-imx9/imx-regs.h
> +++ b/arch/arm/include/asm/arch-imx9/imx-regs.h
> @@ -17,14 +17,23 @@
>  
>  #define ANATOP_BASE_ADDR    0x44480000UL
>  
> +#ifdef CONFIG_IMX94
> +#define WDG3_BASE_ADDR      0x49220000UL
> +#define WDG4_BASE_ADDR      0x49230000UL
> +#else
>  #define WDG3_BASE_ADDR      0x42490000UL
>  #define WDG4_BASE_ADDR      0x424a0000UL
> +#endif
>  #define WDG5_BASE_ADDR      0x424b0000UL
>  
>  #define GPIO2_BASE_ADDR	    0x43810000UL
>  #define GPIO3_BASE_ADDR	    0x43820000UL
>  #define GPIO4_BASE_ADDR	    0x43840000UL
>  #define GPIO5_BASE_ADDR	    0x43850000UL
> +#ifdef CONFIG_IMX94
> +#define GPIO6_BASE_ADDR	    0x43860000UL
> +#define GPIO7_BASE_ADDR	    0x43870000UL
> +#endif
>  
>  #define FSB_BASE_ADDR       0x47510000UL
>  
> diff --git a/arch/arm/mach-imx/imx9/scmi/clock.c b/arch/arm/mach-imx/imx9/scmi/clock.c
> index 6e6541eaa31..1f071873dca 100644
> --- a/arch/arm/mach-imx/imx9/scmi/clock.c
> +++ b/arch/arm/mach-imx/imx9/scmi/clock.c
> @@ -6,16 +6,18 @@
>  #include <asm/arch/clock.h>
>  #include <dm/uclass.h>
>  #include <scmi_agent.h>
> +#include <scmi_nxp_protocols.h>

>  #include "../../../../../dts/upstream/src/arm64/freescale/imx95-clock.h"

What is this? I asked and it was suggested to send a patch upstream, but
they said no. Ref:
https://lore.kernel.org/lkml/PAXPR04MB845970863A16718967270D1A880EA@PAXPR04MB8459.eurprd04.prod.outlook.com/

> +#include "common.h"
>  
>  u32 get_arm_core_clk(void)
>  {
>  	u32 val;
>  
> -	val = imx_clk_scmi_get_rate(IMX95_CLK_SEL_A55C0);
> +	val = imx_clk_scmi_get_rate(SCMI_CLK(SEL_A55C0));
>  	if (val)
>  		return val;
> -	return imx_clk_scmi_get_rate(IMX95_CLK_A55);
> +	return imx_clk_scmi_get_rate(SCMI_CLK(A55));
>  }
>  
>  void init_uart_clk(u32 index)
> @@ -24,13 +26,13 @@ void init_uart_clk(u32 index)
>  
>  	switch (index) {
>  	case 0:
> -		clock_id = IMX95_CLK_LPUART1;
> +		clock_id = SCMI_CLK(LPUART1);
>  		break;
>  	case 1:
> -		clock_id = IMX95_CLK_LPUART2;
> +		clock_id = SCMI_CLK(LPUART2);
>  		break;
>  	case 2:
> -		clock_id = IMX95_CLK_LPUART3;
> +		clock_id = SCMI_CLK(LPUART3);
>  		break;
>  	default:
>  		return;
> @@ -38,7 +40,7 @@ void init_uart_clk(u32 index)
>  
>  	/* 24MHz */
>  	imx_clk_scmi_enable(clock_id, false);
> -	imx_clk_scmi_set_parent(clock_id, IMX95_CLK_24M);
> +	imx_clk_scmi_set_parent(clock_id, SCMI_CLK(24M));
>  	imx_clk_scmi_set_rate(clock_id, 24000000);
>  	imx_clk_scmi_enable(clock_id, true);
>  }
> @@ -49,19 +51,19 @@ unsigned int mxc_get_clock(enum mxc_clock clk)
>  	case MXC_ARM_CLK:
>  		return get_arm_core_clk();
>  	case MXC_IPG_CLK:
> -		return imx_clk_scmi_get_rate(IMX95_CLK_BUSWAKEUP);
> +		return imx_clk_scmi_get_rate(SCMI_CLK(BUSWAKEUP));
>  	case MXC_CSPI_CLK:
> -		return imx_clk_scmi_get_rate(IMX95_CLK_LPSPI1);
> +		return imx_clk_scmi_get_rate(SCMI_CLK(LPSPI1));
>  	case MXC_ESDHC_CLK:
> -		return imx_clk_scmi_get_rate(IMX95_CLK_USDHC1);
> +		return imx_clk_scmi_get_rate(SCMI_CLK(USDHC1));
>  	case MXC_ESDHC2_CLK:
> -		return imx_clk_scmi_get_rate(IMX95_CLK_USDHC2);
> +		return imx_clk_scmi_get_rate(SCMI_CLK(USDHC2));
>  	case MXC_ESDHC3_CLK:
> -		return imx_clk_scmi_get_rate(IMX95_CLK_USDHC3);
> +		return imx_clk_scmi_get_rate(SCMI_CLK(USDHC3));
>  	case MXC_UART_CLK:
> -		return imx_clk_scmi_get_rate(IMX95_CLK_LPUART1);
> +		return imx_clk_scmi_get_rate(SCMI_CLK(LPUART1));
>  	case MXC_FLEXSPI_CLK:
> -		return imx_clk_scmi_get_rate(IMX95_CLK_FLEXSPI1);
> +		return imx_clk_scmi_get_rate(SCMI_CLK(FLEXSPI1));
>  	default:
>  		return -1;
>  	};
> diff --git a/arch/arm/mach-imx/imx9/scmi/common.h b/arch/arm/mach-imx/imx9/scmi/common.h
> new file mode 100644
> index 00000000000..df26ecff3e4
> --- /dev/null
> +++ b/arch/arm/mach-imx/imx9/scmi/common.h
> @@ -0,0 +1,41 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright 2025 NXP
> + */
> +
> +#ifndef _SCMI_CLOCK_COMMON_H_
> +#define _SCMI_CLOCK_COMMON_H_
> +

> +#ifdef CONFIG_IMX94
> +#define IMX_PLAT 94
> +#include <../dts/upstream/src/arm64/freescale/imx94-clock.h>
> +#include <../dts/upstream/src/arm64/freescale/imx94-power.h>
> +
> +#define IMX94_CLK_FLEXSPI1 IMX94_CLK_XSPI1
> +#endif
> +
> +#ifdef CONFIG_IMX95
> +#define IMX_PLAT 95
> +#include <../dts/upstream/src/arm64/freescale/imx95-clock.h>
> +#include <../dts/upstream/src/arm64/freescale/imx95-power.h>
> +
> +#define IMX95_PD_M70 IMX95_PD_M7
> +#endif

Again this weird include relative-global path... not good.

I don't know what it should be, sorry. It is fragile and we should do
something better.

> +
> +#define IMX_PLAT_STR__(plat) # plat
> +#define IMX_PLAT_STR_(IMX_PLAT) IMX_PLAT_STR__(IMX_PLAT)
> +#define IMX_PLAT_STR IMX_PLAT_STR_(IMX_PLAT)
> +
> +#define SCMI_CLK__(plat, clk) IMX ## plat ## _CLK_ ## clk
> +#define SCMI_CLK_(plat, clk) SCMI_CLK__(plat, clk)
> +#define SCMI_CLK(clk) SCMI_CLK_(IMX_PLAT, clk)
> +
> +#define SCMI_PD__(plat, pd) IMX ## plat ## _PD_ ## pd
> +#define SCMI_PD_(plat, pd) SCMI_PD__(plat, pd)
> +#define SCMI_PD(pd) SCMI_PD_(IMX_PLAT, pd)
> +
> +#define SCMI_CPU__(plat) MXC_CPU_IMX ## plat
> +#define SCMI_CPU_(plat) SCMI_CPU__(plat)
> +#define SCMI_CPU SCMI_CPU_(IMX_PLAT)
> +
> +#endif
> diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
> index f0b2aad8701..43aecca6f48 100644
> --- a/arch/arm/mach-imx/imx9/scmi/soc.c
> +++ b/arch/arm/mach-imx/imx9/scmi/soc.c
> @@ -21,6 +21,7 @@
>  #include <linux/iopoll.h>
>  #include <scmi_agent.h>
>  #include <scmi_nxp_protocols.h>
> +#include "common.h"
>  
>  DECLARE_GLOBAL_DATA_PTR;
>  
> @@ -176,7 +177,7 @@ u32 get_cpu_rev(void)
>  {
>  	u32 rev = (gd->arch.soc_rev >> 24) - 0xa0;
>  
> -	return (MXC_CPU_IMX95 << 12) | (CHIP_REV_1_0 + rev);
> +	return (SCMI_CPU << 12) | (CHIP_REV_1_0 + rev);
>  }
>  
>  #define UNLOCK_WORD 0xD928C520
> @@ -437,12 +438,16 @@ void imx_get_mac_from_fuse(int dev_id, unsigned char *mac)
>  {
>  	u32 val[2] = {};
>  	int ret, num_of_macs;
> +	u32 bank = 40;
>  
> -	ret = fuse_read(40, 5, &val[0]);
> +	if (is_imx94())
> +		bank = 66;
> +
> +	ret = fuse_read(bank, 5, &val[0]);
>  	if (ret)
>  		goto err;
>  
> -	ret = fuse_read(40, 6, &val[1]);
> +	ret = fuse_read(bank, 6, &val[1]);
>  	if (ret)
>  		goto err;
>  
> @@ -458,10 +463,32 @@ void imx_get_mac_from_fuse(int dev_id, unsigned char *mac)
>  	mac[3] = (val[0] >> 24) & 0xff;
>  	mac[4] = val[1] & 0xff;
>  	mac[5] = (val[1] >> 8) & 0xff;
> -	if (dev_id == 1)
> -		mac[5] = mac[5] + 3;
> -	if (dev_id == 2)
> -		mac[5] = mac[5] + 6;
> +
> +	if (is_imx94()) {
> +		/*
> +		 * i.MX94 uses the following mac address offset list:
> +		 * | No.    | Module      | Mac address user          |
> +		 * |--------|-------------|---------------------------|
> +		 * | 0 ~ 1  | ethercat    | port0/port1               |
> +		 * | 2      | netc switch | internal enetc3 mac/swp0  |
> +		 * | 3 ~ 6  |             | enetc3 vf1~3/swp1         |
> +		 * | 7      | enetc mac   | enetc0 pf                 |
> +		 * | 8      |             | enetc1 pf                 |
> +		 * | 9      |             | enetc2 pf                 |
> +		 * | 10     | netc switch | swp2                      |
> +		 */
> +		if (dev_id == 0)
> +			mac[5] = mac[5] + 2; /* enetc3 mac/swp0 */
> +		if (dev_id == 1)
> +			mac[5] = mac[5] + 8; /* enetc1 */
> +		if (dev_id == 2)
> +			mac[5] = mac[5] + 9; /* enetc2 */
> +	} else {
> +		if (dev_id == 1)
> +			mac[5] = mac[5] + 3;
> +		if (dev_id == 2)
> +			mac[5] = mac[5] + 6;
> +	}
>  
>  	debug("%s: MAC%d: %pM\n", __func__, dev_id, mac);
>  	return;
> @@ -518,7 +545,6 @@ static char *rst_string_imx94[32] = {
>  	"por"
>  };
>  
> -
>  int get_reset_reason(bool sys, bool lm)
>  {
>  	struct scmi_imx_misc_reset_reason_in in = {
> @@ -612,8 +638,8 @@ int get_reset_reason(bool sys, bool lm)
>  const char *get_imx_type(u32 imxtype)
>  {
>  	switch (imxtype) {
> -	case MXC_CPU_IMX95:
> -		return "95";/* iMX95 FULL */
> +	case SCMI_CPU:
> +		return IMX_PLAT_STR;
>  	default:
>  		return "??";
>  	}
> @@ -701,6 +727,10 @@ int arch_cpu_init(void)
>  		gpio_reset(GPIO3_BASE_ADDR);
>  		gpio_reset(GPIO4_BASE_ADDR);
>  		gpio_reset(GPIO5_BASE_ADDR);
> +#ifdef CONFIG_IMX94
> +		gpio_reset(GPIO6_BASE_ADDR);
> +		gpio_reset(GPIO7_BASE_ADDR);
> +#endif
>  	}
>  
>  	return 0;
> 

Best regards,

-E Shattow

