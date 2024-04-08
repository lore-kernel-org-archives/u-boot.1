Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CC18C67861
	for <u-boot@archiver.kernel.org>; Mon,  8 Apr 2024 18:37:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 922C988166;
	Mon,  8 Apr 2024 20:35:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="vcta7CSo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F1FA88060; Mon,  8 Apr 2024 17:52:12 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 526A487F78
 for <u-boot@lists.denx.de>; Mon,  8 Apr 2024 17:52:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=48288bfef0=christophe.roullier@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 438BrlCr029165; Mon, 8 Apr 2024 17:51:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 content-type:message-id:date:mime-version:subject:to:references
 :cc:from:in-reply-to; s=selector1; bh=5Ip9UDLsXDUJSH1hGrxWd8gmvU
 Co8YfObnEYklH8Di8=; b=vcta7CSoiSYtzg4e8hoL9gzUwXrXNIk2I5TdOdrTb/
 PDQwKaVZOrNgX6bQD2qsKiYuO9usEW04POuHHbRUM+wgVxY3IprEIXvfkVyVg1y6
 HkX2BAPk06UQS4JN+LFfBKkkCSYIC83gFJ1Bwoel1CFK6lhxX7Tctzm8BV4mZH/A
 LBuIqdvVd7tQqMdtMVAnzgarUlk9OO0DLdG4iuwpAalkEUY/Q5qZchT/lsoULDF6
 o6St0V5xPOQRocI0XwJMSdLPaufUR6o3sQ0qw63UwFaGrRgISB5svm34OXTxQq/V
 PChOG/oZfdhWMmj6tA3Dpp0wiq/oXAGcfi7Ekzurj+7g==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xauh4yjtt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Apr 2024 17:51:58 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 654514002D;
 Mon,  8 Apr 2024 17:51:55 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C6D6D216EE1;
 Mon,  8 Apr 2024 17:51:29 +0200 (CEST)
Received: from [10.48.86.106] (10.48.86.106) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 8 Apr
 2024 17:51:28 +0200
Message-ID: <62fb769e-51fd-4c07-9af6-da751f6f0736@foss.st.com>
Date: Mon, 8 Apr 2024 17:51:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/11] net: dwc_eth_qos: Add support of STM32MP13xx
 platform
To: Marek Vasut <marex@denx.de>, <u-boot@lists.denx.de>
References: <20240326120745.27581-1-marex@denx.de>
 <20240326120745.27581-11-marex@denx.de>
 <DU2PR10MB7787E5DD3C53330D616436E68F002@DU2PR10MB7787.EURPRD10.PROD.OUTLOOK.COM>
Content-Language: en-US
CC: Patrice CHOTARD - foss <patrice.chotard@foss.st.com>, Marek Vasut
 <marex@denx.de>, Joe Hershberger <joe.hershberger@ni.com>,
 Patrick DELAUNAY - foss <patrick.delaunay@foss.st.com>,
 Ramon Fried <rfried.dev@gmail.com>, <u-boot@dh-electronics.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
From: Christophe ROULLIER <christophe.roullier@foss.st.com>
In-Reply-To: <DU2PR10MB7787E5DD3C53330D616436E68F002@DU2PR10MB7787.EURPRD10.PROD.OUTLOOK.COM>
X-Originating-IP: [10.48.86.106]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_14,2024-04-05_02,2023-05-22_02
X-Mailman-Approved-At: Mon, 08 Apr 2024 20:35:45 +0200
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

> -----Original Message-----
> From: Marek Vasut<marex@denx.de>
> Sent: Tuesday, March 26, 2024 1:08 PM
> To:u-boot@lists.denx.de
> Cc: Christophe ROULLIER<christophe.roullier@st.com>; Patrice CHOTARD - foss<patrice.chotard@foss.st.com>; Marek Vasut<marex@denx.de>; Joe Hershberger<joe.hershberger@ni.com>; Patrick DELAUNAY - foss<patrick.delaunay@foss.st.com>; Ramon Fried<rfried.dev@gmail.com>;u-boot@dh-electronics.com;uboot-stm32@st-md-mailman.stormreply.com
> Subject: [PATCH v2 10/11] net: dwc_eth_qos: Add support of STM32MP13xx platform
>
> From: Christophe Roullier<christophe.roullier@st.com>
>
> Add compatible "st,stm32mp13-dwmac" to manage STM32MP13 boards.
>
> Reviewed-by: Patrice Chotard<patrice.chotard@foss.st.com>
> Signed-off-by: Christophe Roullier<christophe.roullier@st.com>
> Signed-off-by: Marek Vasut<marex@denx.de>  # Rebase, reshuffle, squash code
> ---
> Cc: Christophe Roullier<christophe.roullier@st.com>
> Cc: Joe Hershberger<joe.hershberger@ni.com>
> Cc: Patrice Chotard<patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay<patrick.delaunay@foss.st.com>
> Cc: Ramon Fried<rfried.dev@gmail.com>
> Cc:u-boot@dh-electronics.com
> Cc:uboot-stm32@st-md-mailman.stormreply.com
> ---
> V2: Add RB from Patrice
> ---
>   drivers/net/dwc_eth_qos.c       |  4 ++++
>   drivers/net/dwc_eth_qos.h       |  1 +
>   drivers/net/dwc_eth_qos_stm32.c | 11 +++++++++++
>   3 files changed, 16 insertions(+)
>
> diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c index 203bfc0848c..e02317905e5 100644
> --- a/drivers/net/dwc_eth_qos.c
> +++ b/drivers/net/dwc_eth_qos.c
> @@ -1505,6 +1505,10 @@ static const struct udevice_id eqos_ids[] = {
>          },
>   #endif
>   #if IS_ENABLED(CONFIG_DWC_ETH_QOS_STM32)
> +       {
> +               .compatible = "st,stm32mp13-dwmac",
> +               .data = (ulong)&eqos_stm32mp13_config
> +       },
>          {
>                  .compatible = "st,stm32mp1-dwmac",
>                  .data = (ulong)&eqos_stm32mp15_config diff --git a/drivers/net/dwc_eth_qos.h b/drivers/net/dwc_eth_qos.h index bafd0d339fb..8b3d0d464d3 100644
> --- a/drivers/net/dwc_eth_qos.h
> +++ b/drivers/net/dwc_eth_qos.h
> @@ -290,5 +290,6 @@ int eqos_null_ops(struct udevice *dev);  extern struct eqos_config eqos_imx_config;  extern struct eqos_config eqos_rockchip_config;  extern struct eqos_config eqos_qcom_config;
> +extern struct eqos_config eqos_stm32mp13_config;
>   extern struct eqos_config eqos_stm32mp15_config;  extern struct eqos_config eqos_jh7110_config; diff --git a/drivers/net/dwc_eth_qos_stm32.c b/drivers/net/dwc_eth_qos_stm32.c index 5a20fe5bea2..435473f99a6 100644
> --- a/drivers/net/dwc_eth_qos_stm32.c
> +++ b/drivers/net/dwc_eth_qos_stm32.c
> @@ -279,6 +279,17 @@ static struct eqos_ops eqos_stm32_ops = {
>          .eqos_get_tick_clk_rate = eqos_get_tick_clk_rate_stm32  };
>
> +struct eqos_config __maybe_unused eqos_stm32mp13_config = {
> +       .reg_access_always_ok = false,
> +       .mdio_wait = 10000,
> +       .swr_wait = 50,
> +       .config_mac = EQOS_MAC_RXQ_CTRL0_RXQ0EN_ENABLED_DCB,
> +       .config_mac_mdio = EQOS_MAC_MDIO_ADDRESS_CR_250_300,
> +       .axi_bus_width = EQOS_AXI_WIDTH_32,
> +       .interface = dev_read_phy_mode,
> +       .ops = &eqos_stm32_ops
> +};
> +
>   struct eqos_config __maybe_unused eqos_stm32mp15_config = {
>          .reg_access_always_ok = false,
>          .mdio_wait = 10000,
> --
> 2.43.0
>
Reviewed-by: Christophe ROULLIER <christophe.roullier@foss.st.com>
