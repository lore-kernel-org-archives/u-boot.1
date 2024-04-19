Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65A20C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 12:06:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DE5F88770;
	Fri, 19 Apr 2024 14:06:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="SvXbfh9v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18BC08876B; Fri, 19 Apr 2024 14:06:31 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 278418874F
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 14:06:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=4839221eac=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 43J9VDC9032319; Fri, 19 Apr 2024 14:06:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=CAHoE0Q3YWWVEddNjNSW0lNv2amNFcZ834SPWnhLXrk=; b=Sv
 Xbfh9vl3r3SGiDKDmO+XoM9HYfHBdEylAHsLQUnH5bu0pDraI7Y9sDd8o2Io12I1
 3/zeh0iiM2eTHxcWLZrOUp42sTA6LcgUEZ+niDx+F0sRSivyHHqmM7E7V9jBF30m
 tb0goBfrM0Z2A8JVhGHNQys4Cbhe9GZxeLAFKsou+zS8PP1zLJ1mp3NYJMrZajMK
 2uXKAgywowQ7eyh6E2QZymyWCweoBdnWLnmbA3IpnColUJCB0mF+i0UNPYpaFJ12
 HFzsOSLtrzNQ/LYFygWfnCEFyqJrs5OKy1ZeNjn1gx4yexBAoNWJFI3z4ZBQwQuc
 vKOJxvmxFNPBEZ/PHVbg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xgecyra3x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Apr 2024 14:06:19 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 67E224004D;
 Fri, 19 Apr 2024 14:06:15 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 18F5A21861A;
 Fri, 19 Apr 2024 14:05:51 +0200 (CEST)
Received: from [10.252.13.94] (10.252.13.94) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 19 Apr
 2024 14:05:50 +0200
Message-ID: <fde6d749-b667-4188-a359-2b50a4f0f875@foss.st.com>
Date: Fri, 19 Apr 2024 14:05:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/11] net: dwc_eth_qos: Use FIELD_PREP for ETH_SEL
 bitfield
Content-Language: en-US
To: Marek Vasut <marex@denx.de>, <u-boot@lists.denx.de>
CC: Christophe Roullier <christophe.roullier@st.com>, Joe Hershberger
 <joe.hershberger@ni.com>, Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Ramon Fried <rfried.dev@gmail.com>, <u-boot@dh-electronics.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20240326120745.27581-1-marex@denx.de>
 <20240326120745.27581-6-marex@denx.de>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20240326120745.27581-6-marex@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.252.13.94]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-19_08,2024-04-19_01,2023-05-22_02
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



On 3/26/24 13:07, Marek Vasut wrote:
> Use FIELD_PREP to configure content of ETH_SEL bitfield in SYSCFG_PMCSETR
> register. No functional change.
> 
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
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
> V2: Add RB from Patrice
> ---
>  drivers/net/dwc_eth_qos_stm32.c | 33 ++++++++++++++++-----------------
>  1 file changed, 16 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/net/dwc_eth_qos_stm32.c b/drivers/net/dwc_eth_qos_stm32.c
> index d7ec0c9be36..7545026b158 100644
> --- a/drivers/net/dwc_eth_qos_stm32.c
> +++ b/drivers/net/dwc_eth_qos_stm32.c
> @@ -26,6 +26,7 @@
>  #include <reset.h>
>  #include <syscon.h>
>  #include <wait_bit.h>
> +#include <linux/bitfield.h>
>  #include <linux/delay.h>
>  
>  #include "dwc_eth_qos.h"
> @@ -40,9 +41,9 @@
>  #define SYSCFG_PMCSETR_ETH_SELMII	BIT(20)
>  
>  #define SYSCFG_PMCSETR_ETH_SEL_MASK	GENMASK(23, 21)
> -#define SYSCFG_PMCSETR_ETH_SEL_GMII_MII	0
> -#define SYSCFG_PMCSETR_ETH_SEL_RGMII	BIT(21)
> -#define SYSCFG_PMCSETR_ETH_SEL_RMII	BIT(23)
> +#define SYSCFG_PMCSETR_ETH_SEL_GMII_MII	0x0
> +#define SYSCFG_PMCSETR_ETH_SEL_RGMII	0x1
> +#define SYSCFG_PMCSETR_ETH_SEL_RMII	0x4
>  
>  static ulong eqos_get_tick_clk_rate_stm32(struct udevice *dev)
>  {
> @@ -142,35 +143,33 @@ static int eqos_probe_syscfg_stm32(struct udevice *dev,
>  
>  	switch (interface_type) {
>  	case PHY_INTERFACE_MODE_MII:
> -		value = SYSCFG_PMCSETR_ETH_SEL_GMII_MII |
> -			SYSCFG_PMCSETR_ETH_REF_CLK_SEL;
> +		value = FIELD_PREP(SYSCFG_PMCSETR_ETH_SEL_MASK,
> +				   SYSCFG_PMCSETR_ETH_SEL_GMII_MII);
> +		value |= SYSCFG_PMCSETR_ETH_REF_CLK_SEL;
>  		log_debug("PHY_INTERFACE_MODE_MII\n");
>  		break;
>  	case PHY_INTERFACE_MODE_GMII:
> +		value = FIELD_PREP(SYSCFG_PMCSETR_ETH_SEL_MASK,
> +				   SYSCFG_PMCSETR_ETH_SEL_GMII_MII);
>  		if (eth_clk_sel_reg)
> -			value = SYSCFG_PMCSETR_ETH_SEL_GMII_MII |
> -				SYSCFG_PMCSETR_ETH_CLK_SEL;
> -		else
> -			value = SYSCFG_PMCSETR_ETH_SEL_GMII_MII;
> +			value |= SYSCFG_PMCSETR_ETH_CLK_SEL;
>  		log_debug("PHY_INTERFACE_MODE_GMII\n");
>  		break;
>  	case PHY_INTERFACE_MODE_RMII:
> +		value = FIELD_PREP(SYSCFG_PMCSETR_ETH_SEL_MASK,
> +				   SYSCFG_PMCSETR_ETH_SEL_RMII);
>  		if (eth_ref_clk_sel_reg)
> -			value = SYSCFG_PMCSETR_ETH_SEL_RMII |
> -				SYSCFG_PMCSETR_ETH_REF_CLK_SEL;
> -		else
> -			value = SYSCFG_PMCSETR_ETH_SEL_RMII;
> +			value |= SYSCFG_PMCSETR_ETH_REF_CLK_SEL;
>  		log_debug("PHY_INTERFACE_MODE_RMII\n");
>  		break;
>  	case PHY_INTERFACE_MODE_RGMII:
>  	case PHY_INTERFACE_MODE_RGMII_ID:
>  	case PHY_INTERFACE_MODE_RGMII_RXID:
>  	case PHY_INTERFACE_MODE_RGMII_TXID:
> +		value = FIELD_PREP(SYSCFG_PMCSETR_ETH_SEL_MASK,
> +				   SYSCFG_PMCSETR_ETH_SEL_RGMII);
>  		if (eth_clk_sel_reg)
> -			value = SYSCFG_PMCSETR_ETH_SEL_RGMII |
> -				SYSCFG_PMCSETR_ETH_CLK_SEL;
> -		else
> -			value = SYSCFG_PMCSETR_ETH_SEL_RGMII;
> +			value |= SYSCFG_PMCSETR_ETH_CLK_SEL;
>  		log_debug("PHY_INTERFACE_MODE_RGMII\n");
>  		break;
>  	default:


Applied on u-boot-stm32/master 
