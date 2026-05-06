Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD66CCD342F
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 00:57:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2342584944;
	Wed,  6 May 2026 02:57:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="sdaeLiRS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84824846A1; Wed,  6 May 2026 02:57:41 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 350B884944
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 02:57:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oR2V0hruiZEq9Sr75QijUCRuZT0IOTMr9ncIZlQ39cNnvZe3MWxWkakJb6rHtCOsKVA2SGidQPMYMf4fwwu/iVWsoG2L+fUo8//e8YSKd+lJF6vnaXE6p94Syn3Zuqgp56L8fdjuEfrHAClrL1cf3n7nA/5VNK5rDinF77tzeWCATuvU0ODFWxZwaeqBHtUXId+JP3wn+wbgxoaSqWeKdTcwEWdpGMC9JLqVpA9YE4WHRiQWPi38RIdSbMHFJzTsgtZoL3ES8vI6CRmNudkjNV1KIsvUNlm1tfpGo1F7WyP9UY/A9MM3HYaqhsCo3olO3NDcQHRSogKOZN59sSc+oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xTSIH3ntY3CCqAdT/docDwZr05ez8RVK4AaNvZgmxh8=;
 b=f9ocwI65X4SZoWp+cmPO0Ci5Z5rBO7icg6INRWNIaxkq0j2va6+6WYtaQ4IrjGpVSqskShnl71K1jeya6zRWyMDon3+C4n2IzoeFknXWWwuLnNBUGp5vLibsWp/k2SRAmKT5ShNYv8qXR6Fw4VTScYci1LrvFdwMuuVJa4ikRrFxbpEwDDokTzoZvSLLr66ZgvQVF/xvMtZsrUUYxg0OYgWiM8XGmYUCtygVXDx6aRaqsht8socFZGO6PHV3AaEypzJdlnvpMB8NZhxarG3yDSEx4DJNfEpvb8q6+hxl977bmIdB0vsqHvtiF3hRzVsZjXZdGRAoYitnuba9Gi2maQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xTSIH3ntY3CCqAdT/docDwZr05ez8RVK4AaNvZgmxh8=;
 b=sdaeLiRSnJs6InApJyNA+OSpHxIXUX+3HhuefFh2KtjNpO6uIscT21rFoS96Tm2KctnVHXyBEndLC8wbD3IJK3+fFDa6critmrGF5RXavQutjJjRkkqeO1cbv9zRL/FSN8gplla9GYM3RTnCgOgf8uOHABNTI0QTYJQ/qGtz6nKOJZNUM5fCXYZ2AtZHnFEQ3cKsl3K+kTfSwU1Y6w0XojGYA1I7P+FcEZsdjLXKbzVt/vYDebfC+uRJuDExFr85sycNpKbUmG9E1o49Eeuw3X9wRoFXvjBD5ZpVNjHea3agVje+NGCxIsGs8IuB4RbBs05U7TFykkulANlC25rkaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by PR3PR04MB7273.eurprd04.prod.outlook.com (2603:10a6:102:89::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 00:57:35 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 00:57:35 +0000
Date: Wed, 6 May 2026 10:14:27 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: tze.yee.ng@altera.com
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>, alif.zakuan.yuslaimi@altera.com,
 Boon Khai Ng <boon.khai.ng@altera.com>
Subject: Re: [PATCH] mmc: sdhci-cadence: trigger tuning for SD HS mode on
 SD6HC (v6) PHY
Message-ID: <afqkA0gI773LcIqx@nxa18884-linux.ap.freescale.net>
References: <f385cf516e8a75fff5c90aa9e54f8e54044f0dd9.1777947009.git.tze.yee.ng@altera.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f385cf516e8a75fff5c90aa9e54f8e54044f0dd9.1777947009.git.tze.yee.ng@altera.com>
X-ClientProxiedBy: SI2PR06CA0012.apcprd06.prod.outlook.com
 (2603:1096:4:186::13) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|PR3PR04MB7273:EE_
X-MS-Office365-Filtering-Correlation-Id: fdbe08f1-1750-40ff-212b-08deab0a761b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|52116014|19092799006|366016|38350700014|10063799003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: +t+yxqWDcS+1vL1JFmzS3OP3HarG2l3fQfAX2jfz998R9RpbFbSNMhGEUVgMxhLcJNE+7KCq6eZBO2LdGmiZdQKuaGPv1iDyA0NLBqyLscfDXnx08in7UtCeqTsmuq9/ev/l4+V3GA2hcpXldhqXRsqwJR4X4wvGirCcVUUyycJ0F4nL+8CFkKLYYvpp1Gf9FChwLEZH7y/eBAeKpdecyMKDPVrJjuknZzZ/1xW8Ssjiu53jKGHzHXM1+KTxq8G/GQql15SDXY+LbFlrbnqIxaAeklqtw1q27wskioKl5PQ7GPoFkBjURK8CBfByIQzvQHj/8TCqJCc8NSH3SeOCsdO+uRsvgqjjgOlOeLEC2mA8EISIpwcGsVy8qvLL/DNHP7ftirXUJ+kx25P+hyH3FnjKwYQ7IBdUARnhso6sxT2aaW5/9XQyeEh5ft99Oxx06O+1D1dSTBkxdocakknOChgJCEeteSZret+fiGiRD518sn5J+xO3M9VVDOWO8YEa5CaiBQq8rf8WPquoB0WQiuXvl6n9GuSZeXKaZ7W2RJ5RkgW606oTIJtJZx+6Un0iaFF6py8VfDV+cF9vp5lqHkZLPvtoCpt8surCynJo/Xrm2kkH/4OJOTZ70mCJz+vGlJtPXIq8OzOddw7NqSSHvx2GpI7cqybXbbKZ2TZ/T0jEB0OPGK+7usxhmEc3MU/nnvMdJYKIaAzzXoePgez+NyuhMa6Mrrl3uaFUpOsw2BrP7gIzg8Nrb8HvcUbZkE4j
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(19092799006)(366016)(38350700014)(10063799003)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DyC+ZrDVL+1XRdy8U25I5TJcDfOR2u7n60AEVNApWN8eT0Togk/azDT5WyD+?=
 =?us-ascii?Q?Zwqx1iy0syZO+rx0TV0+tDG4y2TBTc0EW75C5f8C40I2JMT45JMSx/vK1QKo?=
 =?us-ascii?Q?ulgBFYmj+U/8LSgErEu5HG6bKP2t8prz9WoohySYTwZsMguF6/HwDcCkiyIo?=
 =?us-ascii?Q?szegTcf/xQlDVmH7GDe8CQu/fkodroTYolHp4Lca6ciaPaabyE389clarvo2?=
 =?us-ascii?Q?CadkkfaB6o1V5GsjXz3D+QyPh8yJs12Dyjvkv89YnQKnIv7hpY3HQYXdYEHp?=
 =?us-ascii?Q?sX2eoyRWjhzjy7s5ytTa4lv3dwU461PII91fZTF4qEW1PFCx2d6I/yTZGBh4?=
 =?us-ascii?Q?hj2BOq7oHt1FyHoO3VZ0mFeO3Ng6z4RepGr+4U25RBzvNoxhSxkSTbnY6YcP?=
 =?us-ascii?Q?eCL7219Fdku8W5kD3FtJ6aAI3zlPrdVyvkHCFRqb5xRFGlO+2YpEML+r/OjC?=
 =?us-ascii?Q?/3hfPLp9WctS0vZIurIy8m2yIs6dA+uHcN4cUS0O0UjgRYfq2bQSps7VHzUT?=
 =?us-ascii?Q?5vSWs/HivmA51koMl/XRl4ZDrDVSj8VAwiIKYEu7sBgJa+1E3Ojjl0Llt7Uw?=
 =?us-ascii?Q?aKf9j2i2GSyeMm8r5Aba3TYE8amA68q16D215f+U8A/x2Ltgk8slmSuKA0ZG?=
 =?us-ascii?Q?q5DprUwb9xIPRi3M6ovnebCLe+TvvaR4pOdgIMUAAcaWKzPlarr7ySkoNpl/?=
 =?us-ascii?Q?cg/apJSignEOrGaaFHDpZb/q2EQrtodZTFu4Yk0ZeDgE1jGbsqrBJlhl560U?=
 =?us-ascii?Q?5ki5Gfpu3TgWgneVKADDY6OrnvTQEEsHePq+H54cJv371jlrsYvGd+TQ5/xm?=
 =?us-ascii?Q?m0/prA4a5QcAtvUnBhIMd8ODk8MIOLV+BH4tKbHk1Eb+/Ctw9Bu1CnJzGVjL?=
 =?us-ascii?Q?MxyCSb76ePYNOydMO3WobpomIcjVeRC1JoGkjaZMfJqI/miqbqdPWu1ZmUO/?=
 =?us-ascii?Q?8nVtdNaNlrOpVBapU3U8BxWmh8ljDPvTMy18NNjMrRfcOSVFH9imui/b9uYe?=
 =?us-ascii?Q?F08wVTefF/LSny9sQjAAvYSemNS7z55qH0DE3K6EPZalw/lsUpYY2Eoq/53H?=
 =?us-ascii?Q?06j2CDiZvE4/GkisAIZHzNzTSeZa6HbDHz/spaoVmi1abgbgws5Wxlvkosk1?=
 =?us-ascii?Q?FEWsIm9vKuNqOxtFGyseSyQvU7bOFN/RHSW2PdGzT6FkZvGXi8fPcJ5JRftE?=
 =?us-ascii?Q?6yu1aNW7Tmv/Lc0xakKXX5CmBoaMhs+SWshr4Pfi90+swWxpejkXmu29Mmpl?=
 =?us-ascii?Q?EZwqx0qexq9/35b3Z1jJna3nfmybZIaETxtJir+DwBw85Qxkc6QaP2AUYoqm?=
 =?us-ascii?Q?X+8KIPfxAl2UaBaKiws/gsUkk/ZT+Nn/+czUmzEa+I3PsQDxkGqW3Q00FiB5?=
 =?us-ascii?Q?5aNBc9wz8IfqXfftcxmybMo17m7s0U1Eer1XWNowTp7okDCPdzSo2hxbF62b?=
 =?us-ascii?Q?tBdjPZJIbwjsb4f+3jKcZm0WPgr/c3B1VAAE73kPr1EfolRWxrpZNAhDOU0/?=
 =?us-ascii?Q?QBR7eKIt4J2dasIHbQKO5LJ8khZwfvAy8L6sCnwrYhK+kVvs39HbfRhB6BcF?=
 =?us-ascii?Q?/ocEj8DlctSI43wboCp+SEZXU8VQxGD0CVP1BrWbNjuVr9cybta7DZTj765p?=
 =?us-ascii?Q?wrzw39DPaa/pO0FL4agLGzB+PEAEOWn4PVWsHnF49VRkwBNPndGpDoNfdr6W?=
 =?us-ascii?Q?FjabrO2pZLC0shiMjUYbioisH8jyp5R/eGTJJOZkRwc5yoLW2uovTqGX8/3Y?=
 =?us-ascii?Q?dSKgKnKFEA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdbe08f1-1750-40ff-212b-08deab0a761b
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 00:57:35.6105 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UaQKM00YZACuIcCeB8bgjkny9vtDyZUNp3RBkalRP1h6vwE2/YXWR/DtNmjsvHrQKD9dwVcHRSCRstOaFJ1vCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7273
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

On Mon, May 04, 2026 at 07:36:03PM -0700, tze.yee.ng@altera.com wrote:
>From: Tze Yee Ng <tze.yee.ng@altera.com>
>
>The Cadence SD6HC (SDHCI spec v4.20+) controller uses a soft PHY whose
>DLL delay characteristics vary with PVT (Process, Voltage, Temperature)
>and board-level trace routing.
>
>A static delay value programmed via device tree for SD High Speed mode is
>insufficient because the optimal sampling point varies per board, SD card,
>and operating conditions. Runtime calibration is required.
>
>While the SD Physical Layer Specification does not mandate tuning for
>SD HS mode (only for UHS-I SDR50/SDR104), the Cadence SD6HC PHY
>requires runtime calibration of its receive data delay line to find a
>valid sampling window under constrained clock conditions.
>
>The tuning is triggered from the set_ios_post callback because at that
>moment hardware has committed the new bus width, clock frequency, and speed
>mode to the controller registers. This ensuring the tuning sequence runs
>at the correct SD HS operating conditions.
>
>The tuning is gated by a device tree property "cdns,sd-hs-tuning" so
>that only boards requiring runtime calibration opt in. When enabled,
>the driver performs a 40-tap DLL sweep using CMD19 to find the largest
>consecutive passing window, then programs the midpoint into
>PHY_DLL_SLAVE_CTRL_REG.
>
>To enable on a board, add to the MMC node in device tree:
>
>    &mmc {
>        cdns,sd-hs-tuning;

Has this property been accepted by Linux Upstream?

Regards
Peng

>    };
>
>Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
>---
> drivers/mmc/sdhci-cadence.c  | 108 ++++++++++++++++++++++++++++++++++-
> drivers/mmc/sdhci-cadence.h  |   5 ++
> drivers/mmc/sdhci-cadence6.c |  45 ++++++++++++++-
> 3 files changed, 156 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/mmc/sdhci-cadence.c b/drivers/mmc/sdhci-cadence.c
>index 5bbc18dfa51..a76f9e8d6bd 100644
>--- a/drivers/mmc/sdhci-cadence.c
>+++ b/drivers/mmc/sdhci-cadence.c
>@@ -39,6 +39,9 @@ static const struct sdhci_cdns_phy_cfg sdhci_cdns_phy_cfgs[] = {
> 	{ "cdns,phy-dll-delay-strobe", SDHCI_CDNS_PHY_DLY_STROBE, },
> };
> 
>+static int __maybe_unused sdhci_cdns_execute_tuning(struct udevice *dev,
>+						    unsigned int opcode);
>+
> static int sdhci_cdns_write_phy_reg(struct sdhci_cdns_plat *plat,
> 				    u8 addr, u8 data)
> {
>@@ -155,8 +158,93 @@ static void sdhci_cdns_set_control_reg(struct sdhci_host *host)
> 		sdhci_cdns6_phy_adj(mmc->dev, plat, mmc->selected_mode);
> }
> 
>+static __maybe_unused bool sdhci_cdns_sd_needs_tuning(struct mmc *mmc)
>+{
>+	struct sdhci_cdns_plat *plat = dev_get_plat(mmc->dev);
>+
>+	if (!IS_SD(mmc))
>+		return false;
>+
>+	if (!dev_read_bool(mmc->dev, "cdns,sd-hs-tuning"))
>+		return false;
>+
>+	/* Already tuned for this mode */
>+	if (plat->tuned_mode == mmc->selected_mode)
>+		return false;
>+
>+	switch (mmc->selected_mode) {
>+	case SD_HS:
>+		return mmc->bus_width == 4;
>+	/* Add future modes here, e.g.:
>+	 * case UHS_SDR50:
>+	 *	return true;
>+	 */
>+	default:
>+		return false;
>+	}
>+}
>+
>+static int sdhci_cdns_set_ios_post(struct sdhci_host *host)
>+{
>+	struct mmc *mmc = host->mmc;
>+	struct sdhci_cdns_plat *plat = dev_get_plat(mmc->dev);
>+	int ret __maybe_unused;
>+	/*
>+	 * The SD6HC soft PHY requires runtime DLL delay calibration
>+	 * for SD High Speed mode. The default PHY_DLL_SLAVE_CTRL_REG
>+	 * values (READ_DQS_CMD_DELAY and READ_DQS_DELAY = 0) do not
>+	 * provide sufficient timing margin due to PVT and board trace
>+	 * variations.
>+	 *
>+	 * Tuning is performed once per entry into SD_HS mode
>+	 * (tracked by plat->tuned_mode state). The calibrated PHY delay
>+	 * values remain valid while the card stays in SD_HS mode, and
>+	 * leaving that tuned mode clears the state so re-entering SD_HS
>+	 * triggers tuning again.
>+	 *
>+	 * This must be done in set_ios_post (not set_control_reg)
>+	 * because the SDHCI controller must already be operating at
>+	 * the target bus width, clock, and speed mode before CMD19
>+	 * tuning commands can succeed.
>+	 */
>+
>+	if (IS_ENABLED(CONFIG_MMC_SUPPORTS_TUNING)) {
>+		if (SDHCI_GET_VERSION(host) >= SDHCI_SPEC_420 &&
>+		    sdhci_cdns_sd_needs_tuning(mmc)) {
>+			ret = sdhci_cdns_execute_tuning(mmc->dev,
>+							MMC_CMD_SEND_TUNING_BLOCK);
>+			if (ret) {
>+				dev_err(mmc->dev,
>+					"SD_HS tuning failed (ret=%d), using default PHY\n",
>+					ret);
>+				/* Restore default PHY settings and avoid retrying in this mode */
>+				sdhci_cdns6_phy_adj(mmc->dev, plat,
>+						    mmc->selected_mode);
>+				plat->tuned_mode = mmc->selected_mode;
>+				plat->tuned_dll_slave_ctrl = sdhci_cdns6_phy_get_dll_slave(plat);
>+				return 0;
>+			}
>+			/*
>+			 * Tuning succeeded. The tuned_mode is already set by
>+			 * execute_tuning(), so the tuned value will be preserved
>+			 * across subsequent PHY reconfigurations.
>+			 */
>+			dev_dbg(mmc->dev, "SD_HS tuning successful\n");
>+		}
>+
>+		/* Reset when mode changes away from a tuned mode */
>+		if (mmc->selected_mode != plat->tuned_mode) {
>+			plat->tuned_mode = MMC_MODES_END;
>+			plat->tuned_dll_slave_ctrl = 0;
>+		}
>+	}
>+
>+	return 0;
>+}
>+
> static const struct sdhci_ops sdhci_cdns_ops = {
> 	.set_control_reg = sdhci_cdns_set_control_reg,
>+	.set_ios_post = sdhci_cdns_set_ios_post,
> };
> 
> static int sdhci_cdns_set_tune_val(struct sdhci_cdns_plat *plat,
>@@ -204,6 +292,7 @@ static int __maybe_unused sdhci_cdns_execute_tuning(struct udevice *dev,
> 	int cur_streak = 0;
> 	int max_streak = 0;
> 	int end_of_streak = 0;
>+	int ret;
> 	int i;
> 
> 	/*
>@@ -229,7 +318,24 @@ static int __maybe_unused sdhci_cdns_execute_tuning(struct udevice *dev,
> 		return -EIO;
> 	}
> 
>-	return sdhci_cdns_set_tune_val(plat, end_of_streak - max_streak / 2);
>+	ret = sdhci_cdns_set_tune_val(plat, end_of_streak - max_streak / 2);
>+	if (ret)
>+		return ret;
>+
>+	/*
>+	 * Mark this mode as tuned. This is critical for both driver tuning
>+	 * (SD_HS via set_ios_post) and framework tuning (UHS_SDR104, MMC_HS_200,
>+	 * MMC_HS_400) so that subsequent PHY reconfigurations restore the
>+	 * calibrated DLL value instead of overwriting with DT defaults.
>+	 *
>+	 * For HS400, tuning is performed while the controller is in HS200 mode
>+	 * (mmc->selected_mode == MMC_HS_200 and mmc->hs400_tuning == true).
>+	 * Record the tuned mode as MMC_HS_400 so the calibrated DLL value is
>+	 * preserved across the HS200???HS400 transition.
>+	 */
>+	plat->tuned_mode = mmc->hs400_tuning ? MMC_HS_400 : mmc->selected_mode;
>+
>+	return 0;
> }
> 
> static struct dm_mmc_ops sdhci_cdns_mmc_ops;
>diff --git a/drivers/mmc/sdhci-cadence.h b/drivers/mmc/sdhci-cadence.h
>index 7101f00b75b..ea517491860 100644
>--- a/drivers/mmc/sdhci-cadence.h
>+++ b/drivers/mmc/sdhci-cadence.h
>@@ -7,6 +7,8 @@
> #ifndef SDHCI_CADENCE_H_
> #define SDHCI_CADENCE_H_
> 
>+#include <mmc.h>
>+
> /* HRS - Host Register Set (specific to Cadence) */
> /* PHY access port */
> #define SDHCI_CDNS_HRS04		0x10
>@@ -60,10 +62,13 @@ struct sdhci_cdns_plat {
> 	struct mmc_config cfg;
> 	struct mmc mmc;
> 	void __iomem *hrs_addr;
>+	enum bus_mode tuned_mode;
>+	u32 tuned_dll_slave_ctrl;
> };
> 
> int sdhci_cdns6_phy_adj(struct udevice *dev, struct sdhci_cdns_plat *plat, u32 mode);
> int sdhci_cdns6_phy_init(struct udevice *dev, struct sdhci_cdns_plat *plat);
> int sdhci_cdns6_set_tune_val(struct sdhci_cdns_plat *plat, unsigned int val);
>+u32 sdhci_cdns6_phy_get_dll_slave(struct sdhci_cdns_plat *plat);
> 
> #endif
>diff --git a/drivers/mmc/sdhci-cadence6.c b/drivers/mmc/sdhci-cadence6.c
>index ca1086e2359..c8b42532e17 100644
>--- a/drivers/mmc/sdhci-cadence6.c
>+++ b/drivers/mmc/sdhci-cadence6.c
>@@ -173,6 +173,30 @@ static void sdhci_cdns6_write_phy_reg(struct sdhci_cdns_plat *plat, u32 addr, u3
> 	writel(val, plat->hrs_addr + SDHCI_CDNS_HRS05);
> }
> 
>+static bool sdhci_cdns6_mode_is_tuned(struct sdhci_cdns_plat *plat, u32 mode)
>+{
>+	/*
>+	 * Check if the given mode has a valid tuned DLL value.
>+	 * Only modes that support tuning (driver or framework) can have
>+	 * valid tuned values. This prevents the initial state (tuned_mode=0)
>+	 * from falsely matching MMC_LEGACY.
>+	 */
>+	if (plat->tuned_mode != mode)
>+		return false;
>+
>+	switch (mode) {
>+	case SD_HS:		/* Driver tuning via set_ios_post */
>+	case UHS_SDR50:		/* Future driver tuning support */
>+	case UHS_SDR104:	/* Framework tuning */
>+	case MMC_HS_200:	/* Framework tuning */
>+	case MMC_HS_400:	/* Framework tuning */
>+	case MMC_HS_400_ES:	/* Framework tuning */
>+		return true;
>+	default:
>+		return false;
>+	}
>+}
>+
> static int sdhci_cdns6_reset_phy_dll(struct sdhci_cdns_plat *plat, bool reset)
> {
> 	void __iomem *reg = plat->hrs_addr + SDHCI_CDNS_HRS09;
>@@ -259,7 +283,18 @@ int sdhci_cdns6_phy_adj(struct udevice *dev, struct sdhci_cdns_plat *plat, u32 m
> 	sdhci_cdns6_write_phy_reg(plat, PHY_DQS_TIMING_REG_ADDR, sdhci_cdns6_phy_cfgs[0].val);
> 	sdhci_cdns6_write_phy_reg(plat, PHY_GATE_LPBK_CTRL_REG_ADDR, sdhci_cdns6_phy_cfgs[1].val);
> 	sdhci_cdns6_write_phy_reg(plat, PHY_DLL_MASTER_CTRL_REG_ADDR, sdhci_cdns6_phy_cfgs[4].val);
>-	sdhci_cdns6_write_phy_reg(plat, PHY_DLL_SLAVE_CTRL_REG_ADDR, sdhci_cdns6_phy_cfgs[2].val);
>+	if (sdhci_cdns6_mode_is_tuned(plat, mode)) {
>+		/*
>+		 * Use previously saved tuned DLL slave control value.
>+		 * Note: 0 is a valid tuned value (e.g., optimal tap at position 0),
>+		 * so we check both mode match AND that it's a tunable mode.
>+		 */
>+		sdhci_cdns6_write_phy_reg(plat, PHY_DLL_SLAVE_CTRL_REG_ADDR,
>+					  plat->tuned_dll_slave_ctrl);
>+	} else {
>+		sdhci_cdns6_write_phy_reg(plat, PHY_DLL_SLAVE_CTRL_REG_ADDR,
>+					  sdhci_cdns6_phy_cfgs[2].val);
>+	}
> 
> 	/* Switch Off the DLL Reset */
> 	ret = sdhci_cdns6_reset_phy_dll(plat, false);
>@@ -318,6 +353,9 @@ int sdhci_cdns6_set_tune_val(struct sdhci_cdns_plat *plat, unsigned int val)
> 
> 	sdhci_cdns6_write_phy_reg(plat, PHY_DLL_SLAVE_CTRL_REG_ADDR, tmp);
> 
>+	/* Store tuned DLL slave control value which will be reapplied via set_ios(). */
>+	plat->tuned_dll_slave_ctrl = tmp;
>+
> 	/* Switch Off the DLL Reset */
> 	ret = sdhci_cdns6_reset_phy_dll(plat, false);
> 	if (ret) {
>@@ -327,3 +365,8 @@ int sdhci_cdns6_set_tune_val(struct sdhci_cdns_plat *plat, unsigned int val)
> 
> 	return 0;
> }
>+
>+u32 sdhci_cdns6_phy_get_dll_slave(struct sdhci_cdns_plat *plat)
>+{
>+	return sdhci_cdns6_read_phy_reg(plat, PHY_DLL_SLAVE_CTRL_REG_ADDR);
>+}
>-- 
>2.43.7
>
>
