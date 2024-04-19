Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D67FC4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 12:11:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2802288780;
	Fri, 19 Apr 2024 14:11:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="qXZ1kUYZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1A1E88781; Fri, 19 Apr 2024 14:11:35 +0200 (CEST)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D23738877D
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 14:11:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=4839221eac=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 43J7svsX019688; Fri, 19 Apr 2024 14:11:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=WHoq/yCPV2U3quCX4Ks/U3DHEusF+D8OktwXtz0jgVI=; b=qX
 Z1kUYZ8GU7zGoRrLsB0aVdg7WFrrL5FY9bq+d/hfBz/Y2haUTyNI5Zwc5py/J0UZ
 lcqn7We1fcPdutv7lg6Obdi/6qupmljSJXzFJq1Q6rdebgq3t1LBRd53HH5bUAUH
 ovXrvBy/BxzdfYKtKLlP5PPyHMllsoovjwLog5R+a/GSPMwAwhszvNPXowZxb04U
 vWNnl89Xel9zp6tB4gdT3Fk+NUVFrSo4lEc9BQsCXPIYTxRoqkwAGQEGnlQeFv1s
 UJTLZvCtGYsYnWDpS0ldT+39Z0MF8lhr0BU0DDb/0IPLyIVj/CR9g5TDSsgufjGr
 J/bxsYHOYSJoNQGRVmAA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xg50j9da9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Apr 2024 14:11:23 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 9681D40045;
 Fri, 19 Apr 2024 14:11:19 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D58FE21860C;
 Fri, 19 Apr 2024 14:10:55 +0200 (CEST)
Received: from [10.252.13.94] (10.252.13.94) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 19 Apr
 2024 14:10:55 +0200
Message-ID: <3ae7468e-4cd7-426c-b195-8bf4514f537e@foss.st.com>
Date: Fri, 19 Apr 2024 14:10:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/11] net: dwc_eth_qos: Constify st,eth-* values
 parsed out of DT
Content-Language: en-US
To: Marek Vasut <marex@denx.de>, <u-boot@lists.denx.de>
CC: Christophe Roullier <christophe.roullier@st.com>, Joe Hershberger
 <joe.hershberger@ni.com>, Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Ramon Fried <rfried.dev@gmail.com>, <u-boot@dh-electronics.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20240326120745.27581-1-marex@denx.de>
 <20240326120745.27581-9-marex@denx.de>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20240326120745.27581-9-marex@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.252.13.94]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
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
> Use const bool for the values parsed out of DT. Drop the duplicate
> assignment of false into those bool variables, assign them directly
> with the content parsed out of DT. Abbreviate the variable name too.
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
> V2: - Add RB from Patrice
>     - Add trailing fullstop at the end of code comment
> ---
>  drivers/net/dwc_eth_qos_stm32.c | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/dwc_eth_qos_stm32.c b/drivers/net/dwc_eth_qos_stm32.c
> index 72f65f80540..0b13d01346b 100644
> --- a/drivers/net/dwc_eth_qos_stm32.c
> +++ b/drivers/net/dwc_eth_qos_stm32.c
> @@ -128,17 +128,13 @@ static int eqos_stop_clks_stm32(struct udevice *dev)
>  static int eqos_probe_syscfg_stm32(struct udevice *dev,
>  				   phy_interface_t interface_type)
>  {
> -	bool eth_ref_clk_sel_reg = false;
> -	bool eth_clk_sel_reg = false;
> +	/* Ethernet 50MHz RMII clock selection. */
> +	const bool eth_ref_clk_sel = dev_read_bool(dev, "st,eth-ref-clk-sel");
> +	/* Gigabit Ethernet 125MHz clock selection. */
> +	const bool eth_clk_sel = dev_read_bool(dev, "st,eth-clk-sel");
>  	u8 *syscfg;
>  	u32 value;
>  
> -	/* Gigabit Ethernet 125MHz clock selection. */
> -	eth_clk_sel_reg = dev_read_bool(dev, "st,eth-clk-sel");
> -
> -	/* Ethernet 50Mhz RMII clock selection */
> -	eth_ref_clk_sel_reg = dev_read_bool(dev, "st,eth-ref-clk-sel");
> -
>  	syscfg = (u8 *)syscon_get_first_range(STM32MP_SYSCON_SYSCFG);
>  	if (!syscfg)
>  		return -ENODEV;
> @@ -154,14 +150,14 @@ static int eqos_probe_syscfg_stm32(struct udevice *dev,
>  		dev_dbg(dev, "PHY_INTERFACE_MODE_GMII\n");
>  		value = FIELD_PREP(SYSCFG_PMCSETR_ETH_SEL_MASK,
>  				   SYSCFG_PMCSETR_ETH_SEL_GMII_MII);
> -		if (eth_clk_sel_reg)
> +		if (eth_clk_sel)
>  			value |= SYSCFG_PMCSETR_ETH_CLK_SEL;
>  		break;
>  	case PHY_INTERFACE_MODE_RMII:
>  		dev_dbg(dev, "PHY_INTERFACE_MODE_RMII\n");
>  		value = FIELD_PREP(SYSCFG_PMCSETR_ETH_SEL_MASK,
>  				   SYSCFG_PMCSETR_ETH_SEL_RMII);
> -		if (eth_ref_clk_sel_reg)
> +		if (eth_ref_clk_sel)
>  			value |= SYSCFG_PMCSETR_ETH_REF_CLK_SEL;
>  		break;
>  	case PHY_INTERFACE_MODE_RGMII:
> @@ -171,7 +167,7 @@ static int eqos_probe_syscfg_stm32(struct udevice *dev,
>  		dev_dbg(dev, "PHY_INTERFACE_MODE_RGMII\n");
>  		value = FIELD_PREP(SYSCFG_PMCSETR_ETH_SEL_MASK,
>  				   SYSCFG_PMCSETR_ETH_SEL_RGMII);
> -		if (eth_clk_sel_reg)
> +		if (eth_clk_sel)
>  			value |= SYSCFG_PMCSETR_ETH_CLK_SEL;
>  		break;
>  	default:

Applied on u-boot-stm32/master 
