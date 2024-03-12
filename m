Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16B29C54E58
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 12:27:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7407487F0E;
	Tue, 12 Mar 2024 13:27:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="JR7U7WoK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FEED87F17; Tue, 12 Mar 2024 13:27:24 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D9A487F04
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 13:27:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=380108150e=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42CAD5QI019102; Tue, 12 Mar 2024 13:27:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=wIFJP/GE5kAvtV052Ngg3Os1EqJlOAIqzgQFErJlJrI=; b=JR
 7U7WoKlgNAVSWLVJeqN9qJxZ0nKXhy3Up97l0E3EqrmMdiuCjO5I5WWxGf4gSjxJ
 jAoXljz6p7CIT/P7OakiTv5gaezrVAlWZnzmJYrBQlyT+R6ybqTZexit0wCechGt
 UHUnfFSlI0OAUgDUww3Vkg28Kt5mebN7g9DeTofFJRk8HgWe9onGdzPNmVaB3JHw
 6dAG0PnoNr6vVZ4NC+ygG4uiXQDDyDXXbiO0S5R6RL5qDEllDwb6OBqRxTJDlAHM
 XJikuxa1sPNQUMCAgtyzwZm98NJvE4F0LgZoqkUeD40psG6/aPtOY9drjkXqZ2sJ
 RLWcwQVg0odnEnHBsdAw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3wrds8n6c6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Mar 2024 13:27:11 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 484DC40044;
 Tue, 12 Mar 2024 13:27:08 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 99AD82656E0;
 Tue, 12 Mar 2024 13:26:42 +0100 (CET)
Received: from [10.201.20.71] (10.201.20.71) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 12 Mar
 2024 13:26:42 +0100
Message-ID: <68ca30b2-9e93-46f0-81c1-9ada0addf0c6@foss.st.com>
Date: Tue, 12 Mar 2024 13:26:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] net: dwc_eth_qos: Fold board_interface_eth_init
 into STM32 glue code
Content-Language: en-US
To: Marek Vasut <marex@denx.de>, <u-boot@lists.denx.de>
CC: Christophe Roullier <christophe.roullier@st.com>, Joe Hershberger
 <joe.hershberger@ni.com>, Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Ramon Fried <rfried.dev@gmail.com>, <u-boot@dh-electronics.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20240309021831.264018-1-marex@denx.de>
 <20240309021831.264018-4-marex@denx.de>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20240309021831.264018-4-marex@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.71]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_08,2024-03-12_01,2023-05-22_02
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



On 3/9/24 03:11, Marek Vasut wrote:
> Move board_interface_eth_init() into eqos_probe_syscfg_stm32() in STM32
> driver glue code. The eqos_probe_syscfg_stm32() parses STM32 specific DT
> properties of this MAC and configures SYSCFG registers accordingly, there
> is nothing board specific happening in this function, move it into generic
> driver code instead. Drop the now unused duplicates from board files.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Christophe Roullier <christophe.roullier@st.com>
> Cc: Joe Hershberger <joe.hershberger@ni.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Ramon Fried <rfried.dev@gmail.com>
> Cc: u-boot@dh-electronics.com
> Cc: uboot-stm32@st-md-mailman.stormreply.com
> ---
>  board/dhelectronics/dh_stm32mp1/board.c | 82 -----------------------
>  board/st/stm32mp1/stm32mp1.c            | 82 -----------------------
>  drivers/net/dwc_eth_qos_stm32.c         | 86 ++++++++++++++++++++++++-
>  3 files changed, 84 insertions(+), 166 deletions(-)
> 
> diff --git a/board/dhelectronics/dh_stm32mp1/board.c b/board/dhelectronics/dh_stm32mp1/board.c
> index d1f662d9701..f179c857116 100644
> --- a/board/dhelectronics/dh_stm32mp1/board.c
> +++ b/board/dhelectronics/dh_stm32mp1/board.c
> @@ -48,12 +48,10 @@
>  
>  /* SYSCFG registers */
>  #define SYSCFG_BOOTR		0x00
> -#define SYSCFG_PMCSETR		0x04
>  #define SYSCFG_IOCTRLSETR	0x18
>  #define SYSCFG_ICNR		0x1C
>  #define SYSCFG_CMPCR		0x20
>  #define SYSCFG_CMPENSETR	0x24
> -#define SYSCFG_PMCCLRR		0x44
>  
>  #define SYSCFG_BOOTR_BOOT_MASK		GENMASK(2, 0)
>  #define SYSCFG_BOOTR_BOOTPD_SHIFT	4
> @@ -69,16 +67,6 @@
>  
>  #define SYSCFG_CMPENSETR_MPU_EN		BIT(0)
>  
> -#define SYSCFG_PMCSETR_ETH_CLK_SEL	BIT(16)
> -#define SYSCFG_PMCSETR_ETH_REF_CLK_SEL	BIT(17)
> -
> -#define SYSCFG_PMCSETR_ETH_SELMII	BIT(20)
> -
> -#define SYSCFG_PMCSETR_ETH_SEL_MASK	GENMASK(23, 21)
> -#define SYSCFG_PMCSETR_ETH_SEL_GMII_MII	0
> -#define SYSCFG_PMCSETR_ETH_SEL_RGMII	BIT(21)
> -#define SYSCFG_PMCSETR_ETH_SEL_RMII	BIT(23)
> -
>  #define KS_CCR		0x08
>  #define KS_CCR_EEPROM	BIT(9)
>  #define KS_BE0		BIT(12)
> @@ -679,76 +667,6 @@ void board_quiesce_devices(void)
>  #endif
>  }
>  
> -/* eth init function : weak called in eqos driver */
> -int board_interface_eth_init(struct udevice *dev,
> -			     phy_interface_t interface_type)
> -{
> -	u8 *syscfg;
> -	u32 value;
> -	bool eth_clk_sel_reg = false;
> -	bool eth_ref_clk_sel_reg = false;
> -
> -	/* Gigabit Ethernet 125MHz clock selection. */
> -	eth_clk_sel_reg = dev_read_bool(dev, "st,eth-clk-sel");
> -
> -	/* Ethernet 50Mhz RMII clock selection */
> -	eth_ref_clk_sel_reg =
> -		dev_read_bool(dev, "st,eth-ref-clk-sel");
> -
> -	syscfg = (u8 *)syscon_get_first_range(STM32MP_SYSCON_SYSCFG);
> -
> -	if (!syscfg)
> -		return -ENODEV;
> -
> -	switch (interface_type) {
> -	case PHY_INTERFACE_MODE_MII:
> -		value = SYSCFG_PMCSETR_ETH_SEL_GMII_MII |
> -			SYSCFG_PMCSETR_ETH_REF_CLK_SEL;
> -		debug("%s: PHY_INTERFACE_MODE_MII\n", __func__);
> -		break;
> -	case PHY_INTERFACE_MODE_GMII:
> -		if (eth_clk_sel_reg)
> -			value = SYSCFG_PMCSETR_ETH_SEL_GMII_MII |
> -				SYSCFG_PMCSETR_ETH_CLK_SEL;
> -		else
> -			value = SYSCFG_PMCSETR_ETH_SEL_GMII_MII;
> -		debug("%s: PHY_INTERFACE_MODE_GMII\n", __func__);
> -		break;
> -	case PHY_INTERFACE_MODE_RMII:
> -		if (eth_ref_clk_sel_reg)
> -			value = SYSCFG_PMCSETR_ETH_SEL_RMII |
> -				SYSCFG_PMCSETR_ETH_REF_CLK_SEL;
> -		else
> -			value = SYSCFG_PMCSETR_ETH_SEL_RMII;
> -		debug("%s: PHY_INTERFACE_MODE_RMII\n", __func__);
> -		break;
> -	case PHY_INTERFACE_MODE_RGMII:
> -	case PHY_INTERFACE_MODE_RGMII_ID:
> -	case PHY_INTERFACE_MODE_RGMII_RXID:
> -	case PHY_INTERFACE_MODE_RGMII_TXID:
> -		if (eth_clk_sel_reg)
> -			value = SYSCFG_PMCSETR_ETH_SEL_RGMII |
> -				SYSCFG_PMCSETR_ETH_CLK_SEL;
> -		else
> -			value = SYSCFG_PMCSETR_ETH_SEL_RGMII;
> -		debug("%s: PHY_INTERFACE_MODE_RGMII\n", __func__);
> -		break;
> -	default:
> -		debug("%s: Do not manage %d interface\n",
> -		      __func__, interface_type);
> -		/* Do not manage others interfaces */
> -		return -EINVAL;
> -	}
> -
> -	/* clear and set ETH configuration bits */
> -	writel(SYSCFG_PMCSETR_ETH_SEL_MASK | SYSCFG_PMCSETR_ETH_SELMII |
> -	       SYSCFG_PMCSETR_ETH_REF_CLK_SEL | SYSCFG_PMCSETR_ETH_CLK_SEL,
> -	       syscfg + SYSCFG_PMCCLRR);
> -	writel(value, syscfg + SYSCFG_PMCSETR);
> -
> -	return 0;
> -}
> -
>  #if defined(CONFIG_OF_BOARD_SETUP)
>  int ft_board_setup(void *blob, struct bd_info *bd)
>  {
> diff --git a/board/st/stm32mp1/stm32mp1.c b/board/st/stm32mp1/stm32mp1.c
> index a17c314daeb..f284b0dfd28 100644
> --- a/board/st/stm32mp1/stm32mp1.c
> +++ b/board/st/stm32mp1/stm32mp1.c
> @@ -52,12 +52,10 @@
>  
>  /* SYSCFG registers */
>  #define SYSCFG_BOOTR		0x00
> -#define SYSCFG_PMCSETR		0x04
>  #define SYSCFG_IOCTRLSETR	0x18
>  #define SYSCFG_ICNR		0x1C
>  #define SYSCFG_CMPCR		0x20
>  #define SYSCFG_CMPENSETR	0x24
> -#define SYSCFG_PMCCLRR		0x44
>  
>  #define SYSCFG_BOOTR_BOOT_MASK		GENMASK(2, 0)
>  #define SYSCFG_BOOTR_BOOTPD_SHIFT	4
> @@ -73,16 +71,6 @@
>  
>  #define SYSCFG_CMPENSETR_MPU_EN		BIT(0)
>  
> -#define SYSCFG_PMCSETR_ETH_CLK_SEL	BIT(16)
> -#define SYSCFG_PMCSETR_ETH_REF_CLK_SEL	BIT(17)
> -
> -#define SYSCFG_PMCSETR_ETH_SELMII	BIT(20)
> -
> -#define SYSCFG_PMCSETR_ETH_SEL_MASK	GENMASK(23, 21)
> -#define SYSCFG_PMCSETR_ETH_SEL_GMII_MII	0
> -#define SYSCFG_PMCSETR_ETH_SEL_RGMII	BIT(21)
> -#define SYSCFG_PMCSETR_ETH_SEL_RMII	BIT(23)
> -
>  #define USB_LOW_THRESHOLD_UV		200000
>  #define USB_WARNING_LOW_THRESHOLD_UV	660000
>  #define USB_START_LOW_THRESHOLD_UV	1230000
> @@ -742,76 +730,6 @@ void board_quiesce_devices(void)
>  	setup_led(LEDST_OFF);
>  }
>  
> -/* eth init function : weak called in eqos driver */
> -int board_interface_eth_init(struct udevice *dev,
> -			     phy_interface_t interface_type)
> -{
> -	u8 *syscfg;
> -	u32 value;
> -	bool eth_clk_sel_reg = false;
> -	bool eth_ref_clk_sel_reg = false;
> -
> -	/* Gigabit Ethernet 125MHz clock selection. */
> -	eth_clk_sel_reg = dev_read_bool(dev, "st,eth-clk-sel");
> -
> -	/* Ethernet 50Mhz RMII clock selection */
> -	eth_ref_clk_sel_reg =
> -		dev_read_bool(dev, "st,eth-ref-clk-sel");
> -
> -	syscfg = (u8 *)syscon_get_first_range(STM32MP_SYSCON_SYSCFG);
> -
> -	if (!syscfg)
> -		return -ENODEV;
> -
> -	switch (interface_type) {
> -	case PHY_INTERFACE_MODE_MII:
> -		value = SYSCFG_PMCSETR_ETH_SEL_GMII_MII |
> -			SYSCFG_PMCSETR_ETH_REF_CLK_SEL;
> -		log_debug("PHY_INTERFACE_MODE_MII\n");
> -		break;
> -	case PHY_INTERFACE_MODE_GMII:
> -		if (eth_clk_sel_reg)
> -			value = SYSCFG_PMCSETR_ETH_SEL_GMII_MII |
> -				SYSCFG_PMCSETR_ETH_CLK_SEL;
> -		else
> -			value = SYSCFG_PMCSETR_ETH_SEL_GMII_MII;
> -		log_debug("PHY_INTERFACE_MODE_GMII\n");
> -		break;
> -	case PHY_INTERFACE_MODE_RMII:
> -		if (eth_ref_clk_sel_reg)
> -			value = SYSCFG_PMCSETR_ETH_SEL_RMII |
> -				SYSCFG_PMCSETR_ETH_REF_CLK_SEL;
> -		else
> -			value = SYSCFG_PMCSETR_ETH_SEL_RMII;
> -		log_debug("PHY_INTERFACE_MODE_RMII\n");
> -		break;
> -	case PHY_INTERFACE_MODE_RGMII:
> -	case PHY_INTERFACE_MODE_RGMII_ID:
> -	case PHY_INTERFACE_MODE_RGMII_RXID:
> -	case PHY_INTERFACE_MODE_RGMII_TXID:
> -		if (eth_clk_sel_reg)
> -			value = SYSCFG_PMCSETR_ETH_SEL_RGMII |
> -				SYSCFG_PMCSETR_ETH_CLK_SEL;
> -		else
> -			value = SYSCFG_PMCSETR_ETH_SEL_RGMII;
> -		log_debug("PHY_INTERFACE_MODE_RGMII\n");
> -		break;
> -	default:
> -		log_debug("Do not manage %d interface\n",
> -			  interface_type);
> -		/* Do not manage others interfaces */
> -		return -EINVAL;
> -	}
> -
> -	/* clear and set ETH configuration bits */
> -	writel(SYSCFG_PMCSETR_ETH_SEL_MASK | SYSCFG_PMCSETR_ETH_SELMII |
> -	       SYSCFG_PMCSETR_ETH_REF_CLK_SEL | SYSCFG_PMCSETR_ETH_CLK_SEL,
> -	       syscfg + SYSCFG_PMCCLRR);
> -	writel(value, syscfg + SYSCFG_PMCSETR);
> -
> -	return 0;
> -}
> -
>  enum env_location env_get_location(enum env_operation op, int prio)
>  {
>  	u32 bootmode = get_bootmode();
> diff --git a/drivers/net/dwc_eth_qos_stm32.c b/drivers/net/dwc_eth_qos_stm32.c
> index fd29a604987..7520a136ed0 100644
> --- a/drivers/net/dwc_eth_qos_stm32.c
> +++ b/drivers/net/dwc_eth_qos_stm32.c
> @@ -24,11 +24,26 @@
>  #include <netdev.h>
>  #include <phy.h>
>  #include <reset.h>
> +#include <syscon.h>
>  #include <wait_bit.h>
>  #include <linux/delay.h>
>  
>  #include "dwc_eth_qos.h"
>  
> +/* SYSCFG registers */
> +#define SYSCFG_PMCSETR		0x04
> +#define SYSCFG_PMCCLRR		0x44
> +
> +#define SYSCFG_PMCSETR_ETH_CLK_SEL	BIT(16)
> +#define SYSCFG_PMCSETR_ETH_REF_CLK_SEL	BIT(17)
> +
> +#define SYSCFG_PMCSETR_ETH_SELMII	BIT(20)
> +
> +#define SYSCFG_PMCSETR_ETH_SEL_MASK	GENMASK(23, 21)
> +#define SYSCFG_PMCSETR_ETH_SEL_GMII_MII	0
> +#define SYSCFG_PMCSETR_ETH_SEL_RGMII	BIT(21)
> +#define SYSCFG_PMCSETR_ETH_SEL_RMII	BIT(23)
> +
>  static ulong eqos_get_tick_clk_rate_stm32(struct udevice *dev)
>  {
>  #ifdef CONFIG_CLK
> @@ -108,11 +123,78 @@ static int eqos_stop_clks_stm32(struct udevice *dev)
>  	return 0;
>  }
>  
> +static int eqos_probe_syscfg_stm32(struct udevice *dev,
> +				   phy_interface_t interface_type)
> +{
> +	bool eth_ref_clk_sel_reg = false;
> +	bool eth_clk_sel_reg = false;
> +	u8 *syscfg;
> +	u32 value;
> +
> +	/* Gigabit Ethernet 125MHz clock selection. */
> +	eth_clk_sel_reg = dev_read_bool(dev, "st,eth-clk-sel");
> +
> +	/* Ethernet 50Mhz RMII clock selection */
> +	eth_ref_clk_sel_reg = dev_read_bool(dev, "st,eth-ref-clk-sel");
> +
> +	syscfg = (u8 *)syscon_get_first_range(STM32MP_SYSCON_SYSCFG);
> +	if (!syscfg)
> +		return -ENODEV;
> +
> +	switch (interface_type) {
> +	case PHY_INTERFACE_MODE_MII:
> +		value = SYSCFG_PMCSETR_ETH_SEL_GMII_MII |
> +			SYSCFG_PMCSETR_ETH_REF_CLK_SEL;
> +		log_debug("PHY_INTERFACE_MODE_MII\n");
> +		break;
> +	case PHY_INTERFACE_MODE_GMII:
> +		if (eth_clk_sel_reg)
> +			value = SYSCFG_PMCSETR_ETH_SEL_GMII_MII |
> +				SYSCFG_PMCSETR_ETH_CLK_SEL;
> +		else
> +			value = SYSCFG_PMCSETR_ETH_SEL_GMII_MII;
> +		log_debug("PHY_INTERFACE_MODE_GMII\n");
> +		break;
> +	case PHY_INTERFACE_MODE_RMII:
> +		if (eth_ref_clk_sel_reg)
> +			value = SYSCFG_PMCSETR_ETH_SEL_RMII |
> +				SYSCFG_PMCSETR_ETH_REF_CLK_SEL;
> +		else
> +			value = SYSCFG_PMCSETR_ETH_SEL_RMII;
> +		log_debug("PHY_INTERFACE_MODE_RMII\n");
> +		break;
> +	case PHY_INTERFACE_MODE_RGMII:
> +	case PHY_INTERFACE_MODE_RGMII_ID:
> +	case PHY_INTERFACE_MODE_RGMII_RXID:
> +	case PHY_INTERFACE_MODE_RGMII_TXID:
> +		if (eth_clk_sel_reg)
> +			value = SYSCFG_PMCSETR_ETH_SEL_RGMII |
> +				SYSCFG_PMCSETR_ETH_CLK_SEL;
> +		else
> +			value = SYSCFG_PMCSETR_ETH_SEL_RGMII;
> +		log_debug("PHY_INTERFACE_MODE_RGMII\n");
> +		break;
> +	default:
> +		log_debug("Do not manage %d interface\n",
> +			  interface_type);
> +		/* Do not manage others interfaces */
> +		return -EINVAL;
> +	}
> +
> +	/* clear and set ETH configuration bits */
> +	writel(SYSCFG_PMCSETR_ETH_SEL_MASK | SYSCFG_PMCSETR_ETH_SELMII |
> +	       SYSCFG_PMCSETR_ETH_REF_CLK_SEL | SYSCFG_PMCSETR_ETH_CLK_SEL,
> +	       syscfg + SYSCFG_PMCCLRR);
> +	writel(value, syscfg + SYSCFG_PMCSETR);
> +
> +	return 0;
> +}
> +
>  static int eqos_probe_resources_stm32(struct udevice *dev)
>  {
>  	struct eqos_priv *eqos = dev_get_priv(dev);
> -	int ret;
>  	phy_interface_t interface;
> +	int ret;
>  
>  	debug("%s(dev=%p):\n", __func__, dev);
>  
> @@ -123,7 +205,7 @@ static int eqos_probe_resources_stm32(struct udevice *dev)
>  		return -EINVAL;
>  	}
>  
> -	ret = board_interface_eth_init(dev, interface);
> +	ret = eqos_probe_syscfg_stm32(dev, interface);
>  	if (ret)
>  		return -EINVAL;
>  

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
