Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 219B6CD4F24
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 10:55:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 950AE836AC;
	Wed, 13 May 2026 12:55:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="vAQElwQ8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 918D483FB0; Wed, 13 May 2026 12:55:49 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 817168341A
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 12:55:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CSyyTsWthe1dOtnSnAlpjwvQd9SG4HGXP8F5eroJwfjoK482Za0GQW63X9k2PRjHzvou0Vu1Ujvz5Hzw1OgaZhi86ykSqQYMP/kBbm6h3Bst/74LIEfX6SiMjzVyqs1IKuDH0z88qC4Uq2u0aFtvYXKiMHDZKXPwsWypxLt2vnCUIUbNW1FNcg1xJKNdkTxZrVUazJ8Whk2+eWzq3IBsnKLn9wXGX/QMumX3B3n58/24nccaolU7a/SZkoamPHCfDNi/0KCUBD5qjAG//jSI0HES24ItK2cHgUihe738sCfj6Q4C3H7lueSDO2Donkz7rM6RS+ILY6XT8z72n7kkTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cmlhF1zwodn/BIm02OC8N5m5Isv+sXpatlu0DqDodz0=;
 b=NIEZnN4/BctgulcW2LJw831h/9QhkZMB8pqPYvjKqsX6wm4DftxL0IB34z286IBMtcdtcsLQr8tKSNtP3Pw6WF2A5o0KZK3NAyRtGDyGRtg8z6KEnKot6qr68RdKXLzgbaEd3sni0gox/3Sy+OI7qoFmaoJ9Z6D1JIspx6xh4/3wm3Vy0b2X4i96B24kJ+pMsH9e016vwKF0PDs6yklTPWGUaGIFHP9yLgTFyIixhka9G820FSP1baofGtJETfBTvZGyXluXIUj0FWopvsh5HME6ovg0vdrcH23qtkiqR29W/oiT1SVQSbuyyHDRr2GkjeAD+WL/VRvMz/qgOc1qOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cmlhF1zwodn/BIm02OC8N5m5Isv+sXpatlu0DqDodz0=;
 b=vAQElwQ8xhqiziP4Nc2zVhhBJOHya0wz5lQAIFvSB9B/lnxsYhienJ82AKVLGRmggvsIt5Rz7yZ0prtOfhmvjCjTFhRP7PginTRu5FKCbJlXLRLiCxfUXYkYrpKJ8K81mha8H4q/R5k99Tugl+MsxOJr8qV0dmao125wyXY+i25eyvpNavxBxexF3G0BKKDiP/RQjwQmVf6UtzkqlTVHY+/KVj1f0KQAYy8UH76Du0uPovLhil96akIFprAESjveV1qNtFqMDavoJ6F6+FVY2eYWnM3bTyQ06SGrLwYSCb6dgjrPV2d09Y2X9GPNNxzZNctbopansjMdX6Y6aN+i5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by AS5PR04MB9828.eurprd04.prod.outlook.com (2603:10a6:20b:678::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 10:55:44 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 10:55:44 +0000
Date: Wed, 13 May 2026 18:58:33 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Henrik Grimler <henrik@grimler.se>,
 Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Kaustabh Chakraborty <kauschluss@disroot.org>,
 Peng Fan <peng.fan@nxp.com>, u-boot@lists.denx.de,
 Minkyu Kang <mk7.kang@samsung.com>, Tom Rini <trini@konsulko.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Anand Moon <linux.amoon@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Lukas Timmermann <uboot@timmermann.space>
Subject: Re: [PATCH v2 1/4] mmc: exynos_dw_mmc: add proper init sequence for
 HS400 support
Message-ID: <agRZWQWWj+30B6hy@shlinux89>
References: <20260503-dwmmc-exynos-hs400-es-v2-0-3ff1526142a7@disroot.org>
 <20260503-dwmmc-exynos-hs400-es-v2-1-3ff1526142a7@disroot.org>
 <20260505190729.GA6951@l14.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505190729.GA6951@l14.localdomain>
X-ClientProxiedBy: MA5P287CA0055.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d3::8) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|AS5PR04MB9828:EE_
X-MS-Office365-Filtering-Correlation-Id: 279a4d93-00a3-49dd-8bbd-08deb0de2e69
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|19092799006|52116014|38350700014|56012099003|22082099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info: 50QBdepDsstHqIeVS0htq9wK223PyTQoWesrTods3vec9j7lOVbyyUbQMeCgtPmAVHYIJGQ1Z6BT/qKuvraXJPWV7GOJ871dagjvypOFh14w+1hvNoVprChbm23LA4XNkPR7Xdf3QZFOpZMftlFK7xzIEfqiBII9nTV5JzFgKWPppcCIpNA48H/XzL0doqHHcB6nCHuL4OjKBhXVC8ga4/SPk3UzdVz4xKEAmtty9+a1JGs3Knu5ZX08fEG3VcSE8BYHLfqxIo1pbXjezUF3eVyXzsLdZcB1P7M5XFZEbGQAUcvOAUPCv4fE2XIfHEh1LYXg53XpmMwvrmKi4UXmYRxXWzMUvhJkZr48YbmwXC6mqLR3jFlzhyfTddsUdr7wir6F49H4B5CbyuSkVRuF+IiJ/ItiH9t9w8ucRAvGZyHNjVKBfA9zEY7EU6dC9KACnejnngbV94FN3YE9nPKklHoI/NU3zOa2VTZoLCU5bAyRBebG7cpiChinxe/0kZ1PdpSSWxr7OEYPSB0e7Uo/IGFKYiAP/iA9LRcZpcyj5Q8KxWjLVPGFoVALeC5Ax53+3M+Iv7zyuu4XIme7axzonDP8xBDK/n/VfQzrLToQkRS/2jUs2wiYAoD1OkspFamVawnSQDde1QDPFOL1z3jyfwi3TDSdc6q+rSXV1JtFj/xuUuRwpMUHK5VOVOsPcG2LlGxJq59IvsLCbed/ToTLMQZm6rfuJ+HIGsP8evfCVyw0vu/PsBeGGkbsNjxC7wpF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(52116014)(38350700014)(56012099003)(22082099003)(18002099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PBEaCgG2qa0c5g8/loJT047vraop+5CddxAzv5d+lSBMfrOsSVL/8KrN6Ofr?=
 =?us-ascii?Q?YbNox6bzYST8o6FxFrhZzFgcbttk6q/FjILYgq6w1RFjs46QmOlN9JLLjYvL?=
 =?us-ascii?Q?APC+bHKx2m9SDB5GMYUOq8s5t2GQ/11/WB4vaBf/gudD00uIN68OasMKEm0r?=
 =?us-ascii?Q?aW/Z3tjYDqR/oOtb+QgnRMFdXpfsVT8UTEDCk+qy7MkPfD5uYFZDESukVSmy?=
 =?us-ascii?Q?t96tG1FNGsEC1nJnnRtMYClRCoP1rkbD2dSIfXjlL5MFJiMV5ep5lxSIYje5?=
 =?us-ascii?Q?oGEdrTz9d5UVdUGeb1r4d8oVvM/vecTjt2zQ4AKXL1PIKi1jVGKOKPAuFVYA?=
 =?us-ascii?Q?91QOqO42PohYD2JGANitq8sDmmVxmozM7h51/k7Fx1/SsyjZnLeOpuM5wX1s?=
 =?us-ascii?Q?4FtFf+iMwaozEur1ZP0zEF28ctKU/oOCALOC/jyXJ7IOoPn+ws4TJfw+szQ+?=
 =?us-ascii?Q?3zMni1eqKH4ztdPSmk3yXdLAYPPLX5/VeX4e36gt7QTZZIniReczonL5/KhM?=
 =?us-ascii?Q?Fe88wzunIPL6aADAofiF/m0hN4kul/ksw3QreanFqeCG/fT24cgeqccZ311g?=
 =?us-ascii?Q?sFIUou/kx6uHgz93utyyLjVnoHCF+2wuHutb6YOEeNCb/C9npcH6n282qGs+?=
 =?us-ascii?Q?A4BfFp9Vfgich75ssg3EgJmA0LlvFhk/FANorBIqFXFZfye+zr+gRLzATVLP?=
 =?us-ascii?Q?lI1S4jkAsqhiSvIDlYYGuLfaGGDwdTXf6lEtLVEzg7rmJKuDbj9rZ1jOoh17?=
 =?us-ascii?Q?BBYbL04q1j4IgvTzkSnMR6plTqdkb42NuYH1lOlvMkBnJBZLJ5YZtYNtED43?=
 =?us-ascii?Q?CBzN0zSJOfhkhFAC9VL0nVzuvCd+5KTMvyYmUg5noqUaJzEfXwhc5Wzdbxzq?=
 =?us-ascii?Q?vIL+977+svPP/4ALJdB7G4Gh8hG43VrKtMsSTvehc7+MOtxO2tjp7HOmdH8L?=
 =?us-ascii?Q?vTRzrlbp2n6Wu62sWVJ1q+k52WfNs1Y1LEcZd9YoDwHPaGksFYo4qWVZvQdM?=
 =?us-ascii?Q?aPKeaq2RHE0bgaMBTvpmuTLCfu6djabHiCEfoK0bs2MsB0y6pLZGWQcgbTFY?=
 =?us-ascii?Q?1gdIBhrDR/FTiOXNSgnWWXQtc7172gubbGZ6/A6EkmeNbydm+ZQSgxYKmeQq?=
 =?us-ascii?Q?BVlA46wGw3vTiLXILGiC57xolETmCAOH+T6f3mWsIRz+HxX1rqWCdFp5jSqX?=
 =?us-ascii?Q?9EmNmRVzlhVVU3imfi/ir0F74TDdgcO/VYruwZS3v0KWmfT8u5nt3dwwB24H?=
 =?us-ascii?Q?wRnsjIeEPuwikuoxGPa2sO72azhgLX/D1xmZGMBJCHxwbFwWZB0wVZM8ktyb?=
 =?us-ascii?Q?9hXN0objylLEn/DOIgxjohSlXAJw3rSi4DXbV/yvePWy1vielvAl/W79Z59/?=
 =?us-ascii?Q?XmdpAsCkCRZ1paWu0vVq3NmNjsUYDBdxeed/rzELyQNADcESJtZ4We1ouMDy?=
 =?us-ascii?Q?cqg0NzWmhE7rsaorXOhEA5oXH/BJvWNzQpMPgRJiiUZXTAL17HKivywFVbT3?=
 =?us-ascii?Q?Wmes99A/tP0DMJfgIoJLqVCXBbIyxza0/4SjBe2E2oGP3b+iwP7Iz230Kp2z?=
 =?us-ascii?Q?tny3lgqzuRf8TNyJsm3Bue+1g2ZWfAeTk6aXer6extwXtFaUwB/o03joUKzR?=
 =?us-ascii?Q?034pPKSzQWv4EEe3jzUPP+CsbIRp7CbLltBfZj+Ig+cJ0tzOLeqmab6kYQPt?=
 =?us-ascii?Q?ayoaN1Mzj052bP+3XAR4P+S/l+WVaDwdlhOdojRN7hsn7887jYhZ45jo30kY?=
 =?us-ascii?Q?XfvV1E+clQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 279a4d93-00a3-49dd-8bbd-08deb0de2e69
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 10:55:44.6134 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tUH73ZKmD6yt9XGGbTOsPJK2ciQ8LjhI29/cDRirCWLym8UylyHjDLyqm44fAjX4vA9fjqNVyMwarBMIUTLlPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9828
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

On Tue, May 05, 2026 at 09:07:29PM +0200, Henrik Grimler wrote:
>Hi Kaustabh,
>
>On Sun, May 03, 2026 at 05:51:26PM +0530, Kaustabh Chakraborty wrote:
>> HS400 support was added, but configuration necessary for HS400 support
>> was left out. Add necessary changes, which includes:
>> - Device tree properties, such as "samsung,dw-mshc-hs400-timing" and
>>   "samsung,read-strobe-delay", which function as per dt-bindings.
>> - Registers related to HS400, which are necessary to enable HS400+ support.
>> - Appropriate timing tunings for the HS400 mode.
>> 
>> Note that these changes are loosely based off of its Linux kernel
>> counterpart.
>> 
>> Fixes: bbe3b9fa0922 ("mmc: exynos_dw_mmc: add support for MMC HS200 and HS400 modes")
>> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
>
>Reviewed-by: Henrik Grimler <henrik@grimler.se>
>
>This works fine on exynos5422-odroid-xu4 without hs400. I was not able
>to get hs400 working on the device, seems more changes than just dts
>update are needed.

Is this patchset good for you all or is there any plan for a new version for
2026.07?

Thanks
Peng

>
>Best regards,
>Henrik Grimler
>
>> ---
>>  arch/arm/mach-exynos/include/mach/dwmmc.h |  5 ++
>>  drivers/mmc/exynos_dw_mmc.c               | 81 +++++++++++++++++++++++++++++++
>>  2 files changed, 86 insertions(+)
>> 
>> diff --git a/arch/arm/mach-exynos/include/mach/dwmmc.h b/arch/arm/mach-exynos/include/mach/dwmmc.h
>> index 4432deedef7..50081326c25 100644
>> --- a/arch/arm/mach-exynos/include/mach/dwmmc.h
>> +++ b/arch/arm/mach-exynos/include/mach/dwmmc.h
>> @@ -15,6 +15,11 @@
>>  #define DWMCI_SET_DRV_CLK(x)		((x) << 16)
>>  #define DWMCI_SET_DIV_RATIO(x)		((x) << 24)
>>  
>> +/* HS400 Related Registers */
>> +#define DWMCI_HS400_DQS_EN		0x180
>> +#define DWMCI_HS400_ASYNC_FIFO_CTRL	0x184
>> +#define DWMCI_HS400_DLINE_CTRL		0x188
>> +
>>  /* Protector Register */
>>  #define DWMCI_EMMCP_BASE		0x1000
>>  #define EMMCP_MPSECURITY		(DWMCI_EMMCP_BASE + 0x0010)
>> diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
>> index 7ccd113bd79..6558cdc803d 100644
>> --- a/drivers/mmc/exynos_dw_mmc.c
>> +++ b/drivers/mmc/exynos_dw_mmc.c
>> @@ -8,6 +8,7 @@
>>  #include <dwmmc.h>
>>  #include <asm/global_data.h>
>>  #include <malloc.h>
>> +#include <mmc.h>
>>  #include <errno.h>
>>  #include <asm/arch/dwmmc.h>
>>  #include <asm/arch/clk.h>
>> @@ -30,6 +31,14 @@
>>  #define CLKSEL_UP_SAMPLE(x, y)		(((x) & ~CLKSEL_CCLK_SAMPLE(7)) | \
>>  					 CLKSEL_CCLK_SAMPLE(y))
>>  
>> +/* RCLK_EN register defines */
>> +#define DATA_STROBE_EN			BIT(0)
>> +#define AXI_NON_BLOCKING_WR	BIT(7)
>> +
>> +/* DLINE_CTRL register defines */
>> +#define DQS_CTRL_RD_DELAY(x, y)		(((x) & ~0x3FF) | ((y) & 0x3FF))
>> +#define DQS_CTRL_GET_RD_DELAY(x)	((x) & 0x3FF)
>> +
>>  /**
>>   * DOC: Quirk flags for different Exynos DW MMC blocks
>>   *
>> @@ -71,6 +80,11 @@ struct dwmci_exynos_priv_data {
>>  	struct clk clk;
>>  	u32 sdr_timing;
>>  	u32 ddr_timing;
>> +	u32 hs400_timing;
>> +	u32 tuned_sample;
>> +	u32 dqs_delay;
>> +	u32 saved_dqs_en;
>> +	u32 saved_strobe_ctrl;
>>  	const struct exynos_dwmmc_variant *chip;
>>  };
>>  
>> @@ -162,6 +176,27 @@ static u8 exynos_dwmmc_get_ciu_div(struct dwmci_host *host)
>>  				& DWMCI_DIVRATIO_MASK) + 1;
>>  }
>>  
>> +static void exynos_config_hs400(struct dwmci_host *host, enum bus_mode mode)
>> +{
>> +	struct dwmci_exynos_priv_data *priv = exynos_dwmmc_get_priv(host);
>> +	u32 dqs, strobe;
>> +
>> +	dqs = priv->saved_dqs_en;
>> +	strobe = priv->saved_strobe_ctrl;
>> +
>> +	switch (mode) {
>> +	case MMC_HS_400:
>> +		dqs |= DATA_STROBE_EN;
>> +		strobe = DQS_CTRL_RD_DELAY(strobe, priv->dqs_delay);
>> +		break;
>> +	default:
>> +		dqs &= ~DATA_STROBE_EN;
>> +	}
>> +
>> +	dwmci_writel(host, DWMCI_HS400_DQS_EN, dqs);
>> +	dwmci_writel(host, DWMCI_HS400_DLINE_CTRL, strobe);
>> +}
>> +
>>  /* Configure CLKSEL register with chosen timing values */
>>  static int exynos_dwmci_clksel(struct dwmci_host *host)
>>  {
>> @@ -170,6 +205,9 @@ static int exynos_dwmci_clksel(struct dwmci_host *host)
>>  	u32 timing;
>>  
>>  	switch (host->mmc->selected_mode) {
>> +	case MMC_HS_400:
>> +		timing = CLKSEL_UP_SAMPLE(priv->hs400_timing, priv->tuned_sample);
>> +		break;
>>  	case MMC_DDR_52:
>>  		timing = priv->ddr_timing;
>>  		break;
>> @@ -186,6 +224,9 @@ static int exynos_dwmci_clksel(struct dwmci_host *host)
>>  
>>  	dwmci_writel(host, priv->chip->clksel, timing);
>>  
>> +	if (CONFIG_IS_ENABLED(MMC_HS400_SUPPORT))
>> +		exynos_config_hs400(host, host->mmc->selected_mode);
>> +
>>  	return 0;
>>  }
>>  
>> @@ -223,6 +264,16 @@ static void exynos_dwmci_board_init(struct dwmci_host *host)
>>  {
>>  	struct dwmci_exynos_priv_data *priv = exynos_dwmmc_get_priv(host);
>>  
>> +	if (CONFIG_IS_ENABLED(MMC_HS400_SUPPORT)) {
>> +		priv->saved_strobe_ctrl = dwmci_readl(host, DWMCI_HS400_DLINE_CTRL);
>> +		priv->saved_dqs_en = dwmci_readl(host, DWMCI_HS400_DQS_EN);
>> +		priv->saved_dqs_en |= AXI_NON_BLOCKING_WR;
>> +		dwmci_writel(host, DWMCI_HS400_DQS_EN, priv->saved_dqs_en);
>> +		if (!priv->dqs_delay)
>> +			priv->dqs_delay =
>> +				DQS_CTRL_GET_RD_DELAY(priv->saved_strobe_ctrl);
>> +	}
>> +
>>  	if (priv->chip->quirks & DWMCI_QUIRK_DISABLE_SMU) {
>>  		dwmci_writel(host, EMMCP_MPSBEGIN0, 0);
>>  		dwmci_writel(host, EMMCP_SEND0, 0);
>> @@ -319,6 +370,22 @@ static int exynos_dwmmc_of_to_plat(struct udevice *dev)
>>  				   DWMCI_SET_DIV_RATIO(div);
>>  	}
>>  
>> +	err = dev_read_u32_array(dev, "samsung,dw-mshc-hs400-timing", timing, 2);
>> +	if (err) {
>> +		debug("DWMMC%d: Can't get hs400-timings, using ddr-timings\n",
>> +		      host->dev_index);
>> +		priv->hs400_timing = priv->ddr_timing;
>> +	} else {
>> +		priv->hs400_timing = DWMCI_SET_SAMPLE_CLK(timing[0]) |
>> +				     DWMCI_SET_DRV_CLK(timing[1]) |
>> +				     DWMCI_SET_DIV_RATIO(1);
>> +		if (dev_read_u32(dev, "samsung,read-strobe-delay", &priv->dqs_delay)) {
>> +			priv->dqs_delay = 0;
>> +			debug("DWMMC%d: read-strobe-delay is not found, assuming usage of default value\n",
>> +			      host->dev_index);
>> +		}
>> +	}
>> +
>>  	host->buswidth = dev_read_u32_default(dev, "bus-width", 4);
>>  	host->fifo_depth = dev_read_u32_default(dev, "fifo-depth", 0);
>>  	host->bus_hz = dev_read_u32_default(dev, "clock-frequency", 0);
>> @@ -356,6 +423,16 @@ static int exynos_dwmmc_get_best_clksmpl(u8 candidates)
>>  	return -EIO;
>>  }
>>  
>> +static int dw_mci_exynos_prepare_hs400_tuning(struct dwmci_host *host)
>> +{
>> +	struct dwmci_exynos_priv_data *priv = exynos_dwmmc_get_priv(host);
>> +
>> +	dwmci_writel(host, priv->chip->clksel, priv->hs400_timing);
>> +	host->bus_hz = exynos_dwmci_get_clk(host, host->clock);
>> +
>> +	return 0;
>> +}
>> +
>>  static int exynos_dwmmc_execute_tuning(struct udevice *dev, u32 opcode)
>>  {
>>  	struct dwmci_exynos_priv_data *priv = dev_get_priv(dev);
>> @@ -365,6 +442,9 @@ static int exynos_dwmmc_execute_tuning(struct udevice *dev, u32 opcode)
>>  	u32 clksel;
>>  	int ret;
>>  
>> +	if (mmc->hs400_tuning)
>> +		dw_mci_exynos_prepare_hs400_tuning(host);
>> +
>>  	clksel = dwmci_readl(host, priv->chip->clksel);
>>  	start_smpl = CLKSEL_CCLK_SAMPLE(clksel);
>>  
>> @@ -387,6 +467,7 @@ static int exynos_dwmmc_execute_tuning(struct udevice *dev, u32 opcode)
>>  		return ret;
>>  	}
>>  
>> +	priv->tuned_sample = ret;
>>  	dwmci_writel(host, priv->chip->clksel, CLKSEL_UP_SAMPLE(clksel, ret));
>>  
>>  	return 0;
>> 
>> -- 
>> 2.53.0
>> 
