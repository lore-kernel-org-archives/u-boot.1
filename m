Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48A49C67861
	for <u-boot@archiver.kernel.org>; Mon,  8 Apr 2024 18:36:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 282B188165;
	Mon,  8 Apr 2024 20:35:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="AFwOs/wL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEC9788060; Mon,  8 Apr 2024 17:51:11 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E433887F78
 for <u-boot@lists.denx.de>; Mon,  8 Apr 2024 17:51:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=48288bfef0=christophe.roullier@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 438BiFOd010796; Mon, 8 Apr 2024 17:51:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 content-type:message-id:date:mime-version:subject:to:references
 :cc:from:in-reply-to; s=selector1; bh=89BumtlToVlgIYtuLo/TZfICF4
 0r4QaD8XTXYEmTg5Q=; b=AFwOs/wL0BYYALT8xei1mcEhh6KFnyYC0pSXci7emZ
 bblYxLyHOyXK7qrCyuNX6K7y4sKazsahDu4Qn4slgB6HxI3/kmNUYJKJGimHmkCP
 sZcuL0+LYexp3jB37wYgiO80rrp5vyZmsBlDuB5TUK9q+8I/aqs9Vkd5pjSxbg2Z
 9aZA1r/0pcEj6t3CDJNgu/4fmMGBBe/ATsqltiShCykghHgs+K+vyqrlr/jxKHCY
 4fSavy6Te2zBHFvXSCJoDa2HJ8Z5yEAbI/TFHKJa9v2reECn/uVxdqkEOBqPo4Hh
 kQyEEd8dXHOjOQPtsBGQICKJQGm2Donms7Z09wegWekw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xautfqr0y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Apr 2024 17:50:59 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 1CC8F40044;
 Mon,  8 Apr 2024 17:50:56 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E3122223F17;
 Mon,  8 Apr 2024 17:50:30 +0200 (CEST)
Received: from [10.48.86.106] (10.48.86.106) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 8 Apr
 2024 17:50:30 +0200
Message-ID: <e5230a47-e4ef-4f68-a3a0-006a3d2819ca@foss.st.com>
Date: Mon, 8 Apr 2024 17:50:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/11] net: dwc_eth_qos: Add DT parsing for STM32MP13xx
 platform
To: Marek Vasut <marex@denx.de>, <u-boot@lists.denx.de>
References: <20240326120745.27581-1-marex@denx.de>
 <20240326120745.27581-10-marex@denx.de>
 <DU2PR10MB7787F61FC3E236ED43D750418F002@DU2PR10MB7787.EURPRD10.PROD.OUTLOOK.COM>
Content-Language: en-US
CC: Joe Hershberger <joe.hershberger@ni.com>, Patrice CHOTARD - foss
 <patrice.chotard@foss.st.com>, Patrick DELAUNAY - foss
 <patrick.delaunay@foss.st.com>,
 Ramon Fried <rfried.dev@gmail.com>, <u-boot@dh-electronics.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
From: Christophe ROULLIER <christophe.roullier@foss.st.com>
In-Reply-To: <DU2PR10MB7787F61FC3E236ED43D750418F002@DU2PR10MB7787.EURPRD10.PROD.OUTLOOK.COM>
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
> Cc: Christophe ROULLIER<christophe.roullier@st.com>; Marek Vasut<marex@denx.de>; Joe Hershberger<joe.hershberger@ni.com>; Patrice CHOTARD - foss<patrice.chotard@foss.st.com>; Patrick DELAUNAY - foss<patrick.delaunay@foss.st.com>; Ramon Fried<rfried.dev@gmail.com>;u-boot@dh-electronics.com;uboot-stm32@st-md-mailman.stormreply.com
> Subject: [PATCH v2 09/11] net: dwc_eth_qos: Add DT parsing for STM32MP13xx platform
>
> From: Christophe Roullier<christophe.roullier@st.com>
>
> Manage 2 ethernet instances, select which instance to configure with mask If mask is not present in DT, it is stm32mp15 platform.
>
> Signed-off-by: Christophe Roullier<christophe.roullier@st.com>
> Signed-off-by: Marek Vasut<marex@denx.de>  # Rework the code
> ---
> Cc: Christophe Roullier<christophe.roullier@st.com>
> Cc: Joe Hershberger<joe.hershberger@ni.com>
> Cc: Patrice Chotard<patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay<patrick.delaunay@foss.st.com>
> Cc: Ramon Fried<rfried.dev@gmail.com>
> Cc:u-boot@dh-electronics.com
> Cc:uboot-stm32@st-md-mailman.stormreply.com
> ---
> V2: - Drop unrelated clock frequency validation
>      - Move "st,ext-phyclk" property support into separate patch
>      - This leaves only the regmap parts here
> ---
>   drivers/net/dwc_eth_qos_stm32.c | 41 ++++++++++++++++++++++-----------
>   1 file changed, 28 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/net/dwc_eth_qos_stm32.c b/drivers/net/dwc_eth_qos_stm32.c index 0b13d01346b..5a20fe5bea2 100644
> --- a/drivers/net/dwc_eth_qos_stm32.c
> +++ b/drivers/net/dwc_eth_qos_stm32.c
> @@ -23,6 +23,7 @@
>   #include <net.h>
>   #include <netdev.h>
>   #include <phy.h>
> +#include <regmap.h>
>   #include <reset.h>
>   #include <syscon.h>
>   #include <wait_bit.h>
> @@ -33,11 +34,16 @@
>
>   /* SYSCFG registers */
>   #define SYSCFG_PMCSETR         0x04
> -#define SYSCFG_PMCCLRR         0x44
> +#define SYSCFG_PMCCLRR_MP13    0x08
> +#define SYSCFG_PMCCLRR_MP15    0x44
> +
> +#define SYSCFG_PMCSETR_ETH1_MASK       GENMASK(23, 16)
> +#define SYSCFG_PMCSETR_ETH2_MASK       GENMASK(31, 24)
>
>   #define SYSCFG_PMCSETR_ETH_CLK_SEL     BIT(16)
>   #define SYSCFG_PMCSETR_ETH_REF_CLK_SEL BIT(17)
>
> +/* STM32MP15xx specific bit */
>   #define SYSCFG_PMCSETR_ETH_SELMII      BIT(20)
>
>   #define SYSCFG_PMCSETR_ETH_SEL_MASK    GENMASK(23, 21)
> @@ -130,23 +136,30 @@ static int eqos_probe_syscfg_stm32(struct udevice *dev,  {
>          /* Ethernet 50MHz RMII clock selection. */
>          const bool eth_ref_clk_sel = dev_read_bool(dev, "st,eth-ref-clk-sel");
> +       /* SoC is STM32MP13xx with two ethernet MACs */
> +       const bool is_mp13 = device_is_compatible(dev, "st,stm32mp13-dwmac");
>          /* Gigabit Ethernet 125MHz clock selection. */
>          const bool eth_clk_sel = dev_read_bool(dev, "st,eth-clk-sel");
> -       u8 *syscfg;
> +       struct regmap *regmap;
> +       u32 regmap_mask;
>          u32 value;
>
> -       syscfg = (u8 *)syscon_get_first_range(STM32MP_SYSCON_SYSCFG);
> -       if (!syscfg)
> -               return -ENODEV;
> +       regmap = syscon_regmap_lookup_by_phandle(dev, "st,syscon");
> +       if (IS_ERR(regmap))
> +               return PTR_ERR(regmap);
> +
> +       regmap_mask = dev_read_u32_index_default(dev, "st,syscon", 2,
> +                                                SYSCFG_PMCSETR_ETH1_MASK);
>
>          switch (interface_type) {
>          case PHY_INTERFACE_MODE_MII:
>                  dev_dbg(dev, "PHY_INTERFACE_MODE_MII\n");
>                  value = FIELD_PREP(SYSCFG_PMCSETR_ETH_SEL_MASK,
>                                     SYSCFG_PMCSETR_ETH_SEL_GMII_MII);
> -               value |= SYSCFG_PMCSETR_ETH_REF_CLK_SEL;
> +               if (!is_mp13)   /* Select MII mode on STM32MP15xx */
> +                       value |= SYSCFG_PMCSETR_ETH_SELMII;
>                  break;
> -       case PHY_INTERFACE_MODE_GMII:
> +       case PHY_INTERFACE_MODE_GMII:   /* STM32MP15xx only */
>                  dev_dbg(dev, "PHY_INTERFACE_MODE_GMII\n");
>                  value = FIELD_PREP(SYSCFG_PMCSETR_ETH_SEL_MASK,
>                                     SYSCFG_PMCSETR_ETH_SEL_GMII_MII); @@ -177,13 +190,15 @@ static int eqos_probe_syscfg_stm32(struct udevice *dev,
>                  return -EINVAL;
>          }
>
> -       /* clear and set ETH configuration bits */
> -       writel(SYSCFG_PMCSETR_ETH_SEL_MASK | SYSCFG_PMCSETR_ETH_SELMII |
> -              SYSCFG_PMCSETR_ETH_REF_CLK_SEL | SYSCFG_PMCSETR_ETH_CLK_SEL,
> -              syscfg + SYSCFG_PMCCLRR);
> -       writel(value, syscfg + SYSCFG_PMCSETR);
> +       /* Shift value at correct ethernet MAC offset in SYSCFG_PMCSETR */
> +       value <<= ffs(regmap_mask) - ffs(SYSCFG_PMCSETR_ETH1_MASK);
>
> -       return 0;
> +       /* Update PMCCLRR (clear register) */
> +       regmap_write(regmap, is_mp13 ?
> +                            SYSCFG_PMCCLRR_MP13 : SYSCFG_PMCCLRR_MP15,
> +                            regmap_mask);
> +
> +       return regmap_update_bits(regmap, SYSCFG_PMCSETR, regmap_mask, value);
>   }
>
>   static int eqos_probe_resources_stm32(struct udevice *dev)
> --
> 2.43.0
Reviewed-by: Christophe ROULLIER <christophe.roullier@foss.st.com>
