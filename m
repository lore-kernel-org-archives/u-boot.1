Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F20BC54E60
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 12:48:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA99687F2D;
	Tue, 12 Mar 2024 13:48:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="IQe4b+qW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7819287F3D; Tue, 12 Mar 2024 13:48:47 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FAE887653
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 13:48:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=380108150e=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42CAuvj6019301; Tue, 12 Mar 2024 13:48:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=8UUbrkR+fECmt0unl99bV5asJsoHBPY5QTWP5Mz9/aM=; b=IQ
 e4b+qWQfT+LpTPtajt8GzcCYczmAXIG4r9HN0Nd9e1vGGQPlPWpqSX4/ZECJplSS
 WyTZP+XtNEtDs8dL9FWli1juVFIrLqwERp5TXhjUN5iK3mZaGGPLe/vxpJwbu90N
 Q4xZ8RA49eojuuWhP1xHP4q59DuHdv2TnNb0wT/AP026RyK9qScxXYC6ro8Vc9M3
 6QqzlfTLjMyvAgeroESJhzsNKXT0PUwYsCGWD5iy7FNPsgAYm4Qk6TdM5ff7bOhi
 gcBfZ8pO0sqxJPgLs9V8k5tIyQgPE4bhLfU/XBoMolMBkw1CN6dJSgPyDjqJJRDm
 ZBBoTaq2M4VAzwtdxkCw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3wrds8n91y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Mar 2024 13:48:35 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 26CE540046;
 Tue, 12 Mar 2024 13:48:32 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D1AF125F7D7;
 Tue, 12 Mar 2024 13:48:07 +0100 (CET)
Received: from [10.201.20.71] (10.201.20.71) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 12 Mar
 2024 13:48:06 +0100
Message-ID: <515d659f-8096-41aa-8749-553fcb8021fe@foss.st.com>
Date: Tue, 12 Mar 2024 13:48:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] net: dwc_eth_qos: Add support of STM32MP13xx
 platform
Content-Language: en-US
To: Marek Vasut <marex@denx.de>, <u-boot@lists.denx.de>
CC: Christophe Roullier <christophe.roullier@st.com>, Joe Hershberger
 <joe.hershberger@ni.com>, Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Ramon Fried <rfried.dev@gmail.com>, <u-boot@dh-electronics.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20240309021831.264018-1-marex@denx.de>
 <20240309021831.264018-12-marex@denx.de>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20240309021831.264018-12-marex@denx.de>
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
> From: Christophe Roullier <christophe.roullier@st.com>
> 
> Add compatible "st,stm32mp13-dwmac" to manage STM32MP13 boards.
> 
> Signed-off-by: Christophe Roullier <christophe.roullier@st.com>
> Signed-off-by: Marek Vasut <marex@denx.de> # Rebase, reshuffle, squash code
> ---
> Cc: Christophe Roullier <christophe.roullier@st.com>
> Cc: Joe Hershberger <joe.hershberger@ni.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Ramon Fried <rfried.dev@gmail.com>
> Cc: u-boot@dh-electronics.com
> Cc: uboot-stm32@st-md-mailman.stormreply.com
> ---
>  drivers/net/dwc_eth_qos.c       |  4 ++++
>  drivers/net/dwc_eth_qos.h       |  1 +
>  drivers/net/dwc_eth_qos_stm32.c | 11 +++++++++++
>  3 files changed, 16 insertions(+)
> 
> diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
> index 203bfc0848c..e02317905e5 100644
> --- a/drivers/net/dwc_eth_qos.c
> +++ b/drivers/net/dwc_eth_qos.c
> @@ -1505,6 +1505,10 @@ static const struct udevice_id eqos_ids[] = {
>  	},
>  #endif
>  #if IS_ENABLED(CONFIG_DWC_ETH_QOS_STM32)
> +	{
> +		.compatible = "st,stm32mp13-dwmac",
> +		.data = (ulong)&eqos_stm32mp13_config
> +	},
>  	{
>  		.compatible = "st,stm32mp1-dwmac",
>  		.data = (ulong)&eqos_stm32mp15_config
> diff --git a/drivers/net/dwc_eth_qos.h b/drivers/net/dwc_eth_qos.h
> index bafd0d339fb..8b3d0d464d3 100644
> --- a/drivers/net/dwc_eth_qos.h
> +++ b/drivers/net/dwc_eth_qos.h
> @@ -290,5 +290,6 @@ int eqos_null_ops(struct udevice *dev);
>  extern struct eqos_config eqos_imx_config;
>  extern struct eqos_config eqos_rockchip_config;
>  extern struct eqos_config eqos_qcom_config;
> +extern struct eqos_config eqos_stm32mp13_config;
>  extern struct eqos_config eqos_stm32mp15_config;
>  extern struct eqos_config eqos_jh7110_config;
> diff --git a/drivers/net/dwc_eth_qos_stm32.c b/drivers/net/dwc_eth_qos_stm32.c
> index 00bf6d45568..e167a7ba901 100644
> --- a/drivers/net/dwc_eth_qos_stm32.c
> +++ b/drivers/net/dwc_eth_qos_stm32.c
> @@ -314,6 +314,17 @@ static struct eqos_ops eqos_stm32_ops = {
>  	.eqos_get_tick_clk_rate = eqos_get_tick_clk_rate_stm32
>  };
>  
> +struct eqos_config __maybe_unused eqos_stm32mp13_config = {
> +	.reg_access_always_ok = false,
> +	.mdio_wait = 10000,
> +	.swr_wait = 50,
> +	.config_mac = EQOS_MAC_RXQ_CTRL0_RXQ0EN_ENABLED_DCB,
> +	.config_mac_mdio = EQOS_MAC_MDIO_ADDRESS_CR_250_300,
> +	.axi_bus_width = EQOS_AXI_WIDTH_32,
> +	.interface = dev_read_phy_mode,
> +	.ops = &eqos_stm32_ops
> +};
> +
>  struct eqos_config __maybe_unused eqos_stm32mp15_config = {
>  	.reg_access_always_ok = false,
>  	.mdio_wait = 10000,
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
