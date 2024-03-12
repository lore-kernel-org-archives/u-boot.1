Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8252DC54E58
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 12:39:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA5CA87F1F;
	Tue, 12 Mar 2024 13:39:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="FCoaJouc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5719E87F2F; Tue, 12 Mar 2024 13:39:38 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6784F87D55
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 13:39:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=380108150e=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42CBhi2L008049; Tue, 12 Mar 2024 13:39:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=1aH9QdNkCeJnw8wlPsjSXFNDSFOIMwqyrEi9gjR6ZXc=; b=FC
 oaJoucbq8iT3RGv1qzEUkV4KvewdkGfgAJQIUj5wEdOvKCa+sziOm7DSq9DKxdLW
 HNSGi9tlt6UpX4oKI7nDR8Xzcz5Q4hwNAjviZzBLQS02Z5lCGATP+B8UodR93Hfx
 PtQAtbVaXOVPKFkbmawzHUhgXTg4EXgu8CdJqxluPZLHgFywRNqxxfcE0cE5GPov
 AeiXcVDSBvC3IIgFQRWWPoqi0DnBzkZB+yJidl9dLKr0mYDD+frU9inMDf2yeDwX
 b1608M7kjNtMyoEViwH4boFEjwsWmuepQpzCAVdXLBvHpxePq5JbUGWGPOz1awcf
 7rZOIVcfts0JbzeKAWgQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3wrds8n7xs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Mar 2024 13:39:27 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 51F1340046;
 Tue, 12 Mar 2024 13:39:23 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9B4D02676C1;
 Tue, 12 Mar 2024 13:38:58 +0100 (CET)
Received: from [10.201.20.71] (10.201.20.71) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 12 Mar
 2024 13:38:58 +0100
Message-ID: <0094c033-ee7e-4851-9663-1ddc337dd569@foss.st.com>
Date: Tue, 12 Mar 2024 13:38:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/11] net: dwc_eth_qos: Use FIELD_PREP for ETH_SEL
 bitfield
Content-Language: en-US
To: Marek Vasut <marex@denx.de>, <u-boot@lists.denx.de>
CC: Christophe Roullier <christophe.roullier@st.com>, Joe Hershberger
 <joe.hershberger@ni.com>, Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Ramon Fried <rfried.dev@gmail.com>, <u-boot@dh-electronics.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20240309021831.264018-1-marex@denx.de>
 <20240309021831.264018-6-marex@denx.de>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20240309021831.264018-6-marex@denx.de>
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
> Use FIELD_PREP to configure content of ETH_SEL bitfield in SYSCFG_PMCSETR
> register. No functional change.
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
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
