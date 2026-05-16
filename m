Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39F9FCD4F21
	for <u-boot@archiver.kernel.org>; Sat, 16 May 2026 08:27:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6890A8407D;
	Sat, 16 May 2026 10:27:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="O9M5QZ34";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA438845E3; Sat, 16 May 2026 10:27:32 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5884F83EF9
 for <u-boot@lists.denx.de>; Sat, 16 May 2026 10:27:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gagb0BMW3St8y0XRa1lnV8iOtuXrQTTWJJkeY+J/HDCIL5/9dGI3YePeeFQt2KCojODvRvkDXXsm5PzkHCMUMLcYsTlDIVMfwhtDJ4cEm6lFAXiGyvv1u/pAIu4AZp8cqL61bw8kV4fDV4rtE9EyrSpA61LsQLDIjjZiF/jOVgwbZvMSRFAGc6STree2ZQP1CZU1e3dEWkZ+hDCnifSEs6sjhoEfSVhrnyH7ps1S/+nbBxGxvWl10W42rtfRQXmHRELvnPj4zEZmq1ZU9H4XPa/4stUV2RtQuCFa9CJj/OOEen/zlrj4ZranGye53fgCvVlV0CNCvtsnwbHhVtq2BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xqkg2c4X7B/UvJlRTJUj02RoEijt2bToBX1kG/aNMOI=;
 b=V2nsQYXlsQY2141PnAHjkT+XzGHuhVuvdUY66ouKv00TvCh4s4nPw6kuspdaE3ME7z7f2kDeU84r7hJ2rjPT4ZlKLCwxHnM65ThR7/aGO0eHc+6rp4w3ivKMniPv9vWjjXy21AjGSmbUlsBuhGNgHnLJQjfuueBVI9spTj+yj8SPDFSTzdDmt50KTLHMkm/aU5JTPUi7yiziR1dxT36f6cicPzUbgHpa9U9bNz1iWnl267e48tpk+4dwb70OUxIu9jB+6DM0mhG9UDsX0O3roUSCvg3NUFBxBJI0VT99q7WbBTAqsuNFp1PEhu6z6RBmX1D9Gbr1nixt1WitCvYDew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqkg2c4X7B/UvJlRTJUj02RoEijt2bToBX1kG/aNMOI=;
 b=O9M5QZ34jpN6GwuJTA9Cu/c0EZia78INkCrtSkZFIKygpSWCo/yvNE27sTa6ZzyVXOo30KHlPPFL/CmS0Tsvv8DNFVrjYZYgR2UynQHwjtetm2Fv3giilVnn98DtFQEbljgJcI1cUARDnxVtsg33TBI8gv+n3Q95BVY+JQz7WHAUQ9Bh2JaGja/nsgYSI0Ob8CNPCu+RrbUKHQ86BVtUeAFtpwCfUXY90IyU2p5UtJ2Dq3qPnpUQK0YriA90WQ4oD9n+y53ZUfO7lPg2zB0Ga8aCFLLa4tIaK8sjr7SKBWp7AratO524GXdi+7HrACfmdnbJ0sTflF/oAc9lYeAR9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by DBBPR04MB7564.eurprd04.prod.outlook.com (2603:10a6:10:1f7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Sat, 16 May
 2026 08:27:23 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0025.020; Sat, 16 May 2026
 08:27:22 +0000
Date: Sat, 16 May 2026 17:44:31 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>, Judith Mendez <jm@ti.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, marex@denx.de, tien.fong.chee@altera.com
Subject: Re: [PATCH] mmc: sd: Handle UHS-I voltage signaling without power
 cycle
Message-ID: <agg8f-Q_RnVI9Gyl@nxa18884-linux.ap.freescale.net>
References: <20251021204526.22701-1-tanmay.kathpalia@altera.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021204526.22701-1-tanmay.kathpalia@altera.com>
X-ClientProxiedBy: SGAP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::26)
 To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|DBBPR04MB7564:EE_
X-MS-Office365-Filtering-Correlation-Id: 68cc172a-b173-4a75-fcc5-08deb324f3ec
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|19092799006|52116014|1800799024|38350700014|11063799003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: r6wfLEwV3BqOQT2yjKO0FQRfsoCly3zSoXmtYpj2fhl4hMeBN5Pg2TGkbDufWvArT1dAxXlz/FFLxPsk71LUvhDerRCxNsnOTz+c3cuu+uBXcz5ztMcDpjaCBQ77HK57O5Y627jQOHPH8gPC61hM76xF/2LvbuL8/1wbQreyKDRBlfSHpvAoIdsptZtzvycjkppqTszMQgJVYW01bV3bQFVo4H2lEPSb79Z+wWy/2vplj0iOLbJa1fPZZtS76UNpjCPetEPXFwN9vrRoHEFbccU9yUhxyhJUFjn1L+iFMCdcu3LUelCcL6/ajklrtPP7C7i+ILrmYlfiLoxfFDo1t2vrsI45SFVumcdIMHv5PcwpMkOEiVnKiSpKgUDOyYv1xPVdE+XpgZfOO9blSCE9J7Wv6IhwHy2QdXUkpzTmMlLCSQ2UTPwMEIkVNs3RPUp/Nai6RKR3fWy1KXaFO1LjImLbe1tov72NNiVEeOsJ4Y/7PR+miRRKZ8j8z1P4hZgI9aPRIKdk9yXd97IwEjHrfnacsd1tEJlOyUPilqLSDr+dvNWoJ5AvnOzLMvAz2fnZ/+h6PA9e21WMBKMT6u10yItnOsXpqeRgcOtjIAAotZAKZ007KFD2QSpg80Cbo/rpkzBEPig9fPsmgNzfdzH7uL/t2gbLC6boMsPQf7QJU5NxAafirpJrqngF4Q5Z8M1cFX8kuW9o9JVoXJOd78Qh7ie5UEiuqMhzShWzQ4OgNSopoLPgW9vmBKbe9oqq/m33
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(19092799006)(52116014)(1800799024)(38350700014)(11063799003)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SP1SN6GSP+qoIVBtMLF4DbRr2raXMDu9YxBEo+hXGlnzXF0MD6yWR5r1JYQr?=
 =?us-ascii?Q?0eTPVzwNS1mELQuDsEWrYHpcofWGcTjL8eeUy2h13hIpXC+1MktVmbWA+EFU?=
 =?us-ascii?Q?xiY+RtC9U4eajxXRoBQsqcVmtr8cqEeUGkRT6On11PzsbJ0aUdg/sC7cU/7x?=
 =?us-ascii?Q?cZLZiDuEkipCKZ+pYAHV8jNk4WsjYY/mn8j1Q9KtRim+OGYDBEf/qk4a6bE1?=
 =?us-ascii?Q?hIROuFx9QahSLo2L6nHR/3AB/230oQBKneUo12a0rjgFgK+v04H3t2qSGA/t?=
 =?us-ascii?Q?TFcrl0+dnSnKwg0Xth8MWg0w9+vsRitcl4bi5ed1dDZtrh2Rxz1LY02javtc?=
 =?us-ascii?Q?9/QK8CsKlj051DcfuInLduR5ju0BDqY0I3mMmyapYN2oypTv4ttbQiFCY9GX?=
 =?us-ascii?Q?u3u+Z/BdBNjHMi7C3qBE2fx6cIr4bFZVlYiBGetpnTen+cNONWd+P1+L2XM3?=
 =?us-ascii?Q?y0ivyOdyGhzysGtJqV8eP9ATqmD97o2R0fqprNJuDnBRgtmYLpYB09dnrJmP?=
 =?us-ascii?Q?MBujlRuk4YuoNn1Azogar2wZCQkls4+gi91g5ipy0xrj657AW18fJY5xt/qs?=
 =?us-ascii?Q?sxgR8NRwYdWKQneYPmhHgbhrUymuserZboDaADxr1nzEEO8tNkxUfVEJjEKb?=
 =?us-ascii?Q?WYJRpA6MZMtthmesguBhJrThSjpXSPQVgOTFs4Rn+6EM0Uawi5pd1aaxEvxZ?=
 =?us-ascii?Q?lH2hBFpS6+H9BY1YuvH/gMNWSMWNTZbAWay78YQKDSryiwKO8Ff20IbhExoB?=
 =?us-ascii?Q?zgiPsT6OTbfQU1oOv5L5NpMM8Kk+Ww8vtMo63v44WpJLfO+cupetUdVSWB5G?=
 =?us-ascii?Q?C7Wu4QHNqza/6D9aE90lcJFfhQ0EpHtoavMv9x1zcfKmCpmhvpMiHhp8pf0G?=
 =?us-ascii?Q?OH92fyLXLmxIl1IDAueiTnUMnBd239K2T1EwQXYxrEa5vlTCwhxoh27KCe3L?=
 =?us-ascii?Q?Ck7bYB642XA8oh7qAve8MNt0lG9uBuk2welZ5WWcmH5qqf7R2FoMDUafX2A4?=
 =?us-ascii?Q?b/cW7XR4ITpXbKDidaqDfxGivfFmdF9A9WeEMnx7++OXsk/aI5/PcR92XANp?=
 =?us-ascii?Q?OLcpmPqAEdnegwnyduTSBXqyFImeMM99m14bWKdvfVjvSiFOFxaJSYW3+pmO?=
 =?us-ascii?Q?JK4RT+W53mFRHmZeoOt4+sJU20nz6TdJ1rNypFwJEVcuWPMWTFy03JCJCQdI?=
 =?us-ascii?Q?b9TveIkhjjBf1xJ7EONGSR13JEUtaPgHkKF7MDgRcW2Xq5kIlo+iFxF4kng1?=
 =?us-ascii?Q?iNVmSxgcb+8meNIY3iuar68fsE5qryuhnfYbhoQBCRx3jtC36CbQQhnTyjXs?=
 =?us-ascii?Q?Wy7u4TO1cAT9cAgCuVX/0iS/LVVO19AL0EQlODNgaw+4IZgrWoB3vc2s3cZM?=
 =?us-ascii?Q?Z1Xj2Y+N/tP7YUdhhHXRrk9z5GPpXW/q5a4YcrF7DDcYybFkunILKQnXL7kg?=
 =?us-ascii?Q?fyca0WmVbw/6iLAI+22UH/wfl9DYB1D+n89Ou5egdMf5e4L7CxGs+xdMaitW?=
 =?us-ascii?Q?Beh9C1kxK8jra+CjotWHck1UtKHoK+owAUEDdDNQKuBmWrEDx3YYodU4k6Ym?=
 =?us-ascii?Q?ZnKYIDAqJ1osBFqKil7yxM++dDyN2c+YJBuG/S4FfOZOUqOypljCs+5Hmzro?=
 =?us-ascii?Q?MCOF0Dt2jzAhFk1nitT2+AXCyt4g69Iq3Sdx8UWriDiKrQ+b5g4IBeKzB4m/?=
 =?us-ascii?Q?mKs8M/JQ8N2SsWxMjRzU2cQMJL+yuxNvwalrKYqlVKW1GnY2oqrH4aAQt99b?=
 =?us-ascii?Q?dXHGJJt72Q=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68cc172a-b173-4a75-fcc5-08deb324f3ec
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2026 08:27:22.8163 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V71wHQkrsXHOn66Zt9kIiBRYqm/a7iiWPIr45VvnYCA30RIDzg79eH9dOmiADADoQCi9Ji7GtFcQv9o1IyzqNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7564
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

Revisit this patch, since it break one board [1].

[1] https://lore.kernel.org/all/52ec8007-ce50-4f12-b796-4b8c2aa1822e@ti.com/

On Tue, Oct 21, 2025 at 01:45:26PM -0700, Tanmay Kathpalia wrote:
>Some boards have SD card connectors where the power rail cannot be switched
>off by the driver. However there are various circumstances when a card
>might be re-initialized, such as after system resume, warm re-boot, or
>error handling. However, a UHS card will continue to use 1.8V signaling
>unless it is power cycled.
>
>If the card has not been power cycled, it may still be using 1.8V
>signaling. According to the SD spec., the Bus Speed Mode (function group 1)
>bits 2 to 4 are zero if the card is initialized at 3.3V signal level. Thus
>they can be used to determine if the card has already switched to 1.8V
>signaling. Detect that situation and try to initialize a UHS-I (1.8V)
>transfer mode.
>
>Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
>---
> drivers/mmc/mmc.c | 55 ++++++++++++++++++++++++++++++++++++++---------
> include/mmc.h     |  3 +++
> 2 files changed, 48 insertions(+), 10 deletions(-)
>
>diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
>index ec61ed92e86..e1f62a5d0ad 100644
>--- a/drivers/mmc/mmc.c
>+++ b/drivers/mmc/mmc.c
>@@ -643,6 +643,19 @@ static int mmc_switch_voltage(struct mmc *mmc, int signal_voltage)
> 
> 	return 0;
> }
>+
>+static bool mmc_sd_card_using_v18(struct mmc *mmc)
>+{
>+	/*
>+	 * According to the SD spec., the Bus Speed Mode (function group 1) bits
>+	 * 2 to 4 are zero if the card is initialized at 3.3V signal level. Thus
>+	 * they can be used to determine if the card has already switched to
>+	 * 1.8V signaling.
>+	 */
>+	bool volt = mmc->sd3_bus_mode &
>+	       (SD_MODE_UHS_SDR50 | SD_MODE_UHS_SDR104 | SD_MODE_UHS_DDR50);

This is wrong.
sd3_bus_mode is sd supported bits, not the current running bits.

To detect the sd card running bits, need to use: 
(__be32_to_cpu(switch_status[4]) >> 24) & 0xF

>+	return volt;
>+}
> #endif
> 
> static int sd_send_op_cond(struct mmc *mmc, bool uhs_en)
>@@ -1369,9 +1382,6 @@ static int sd_get_capabilities(struct mmc *mmc)
> 	ALLOC_CACHE_ALIGN_BUFFER(__be32, switch_status, 16);
> 	struct mmc_data data;
> 	int timeout;
>-#if CONFIG_IS_ENABLED(MMC_UHS_SUPPORT)
>-	u32 sd3_bus_mode;
>-#endif
> 
> 	mmc->card_caps = MMC_MODE_1BIT | MMC_CAP(MMC_LEGACY);
> 
>@@ -1451,16 +1461,16 @@ static int sd_get_capabilities(struct mmc *mmc)
> 	if (mmc->version < SD_VERSION_3)
> 		return 0;
> 
>-	sd3_bus_mode = __be32_to_cpu(switch_status[3]) >> 16 & 0x1f;
>-	if (sd3_bus_mode & SD_MODE_UHS_SDR104)
>+	mmc->sd3_bus_mode = __be32_to_cpu(switch_status[3]) >> 16 & 0x1f;
>+	if (mmc->sd3_bus_mode & SD_MODE_UHS_SDR104)
> 		mmc->card_caps |= MMC_CAP(UHS_SDR104);
>-	if (sd3_bus_mode & SD_MODE_UHS_SDR50)
>+	if (mmc->sd3_bus_mode & SD_MODE_UHS_SDR50)
> 		mmc->card_caps |= MMC_CAP(UHS_SDR50);
>-	if (sd3_bus_mode & SD_MODE_UHS_SDR25)
>+	if (mmc->sd3_bus_mode & SD_MODE_UHS_SDR25)
> 		mmc->card_caps |= MMC_CAP(UHS_SDR25);
>-	if (sd3_bus_mode & SD_MODE_UHS_SDR12)
>+	if (mmc->sd3_bus_mode & SD_MODE_UHS_SDR12)
> 		mmc->card_caps |= MMC_CAP(UHS_SDR12);
>-	if (sd3_bus_mode & SD_MODE_UHS_DDR50)
>+	if (mmc->sd3_bus_mode & SD_MODE_UHS_DDR50)
> 		mmc->card_caps |= MMC_CAP(UHS_DDR50);
> #endif
> 
>@@ -1830,7 +1840,11 @@ static int sd_select_mode_and_width(struct mmc *mmc, uint card_caps)
> 	uint widths[] = {MMC_MODE_4BIT, MMC_MODE_1BIT};
> 	const struct mode_width_tuning *mwt;
> #if CONFIG_IS_ENABLED(MMC_UHS_SUPPORT)
>-	bool uhs_en = (mmc->ocr & OCR_S18R) ? true : false;
>+	/*
>+	 * Enable UHS mode if the card advertises 1.8V support (S18R in OCR)
>+	 * or is already operating at 1.8V signaling.
>+	 */
>+	bool uhs_en = (mmc->ocr & OCR_S18R) || mmc_sd_card_using_v18(mmc);

In theory, 

bool uhs_en = (mmc->ocr & OCR_S18R) ? true : false; is correct.

OCR (including S18R/S18A) only reflects voltage switch negotiation
capability and intent, not the current signaling voltage. So your sd card
should have OCR_S18R returned per my understanding.

> #else
> 	bool uhs_en = false;
> #endif
>@@ -2701,6 +2715,27 @@ static int mmc_startup(struct mmc *mmc)
> 		err = sd_get_capabilities(mmc);
> 		if (err)
> 			return err;
>+
>+#if CONFIG_IS_ENABLED(MMC_UHS_SUPPORT)
>+		/*
>+		 * If the card has already switched to 1.8V signaling, then
>+		 * set the signal voltage to 1.8V.
>+		 */
>+		if (mmc_sd_card_using_v18(mmc)) {

To switch voltage, ACMD41 is required, see mmc_switch_voltage.
Forcing switch to 1.8 here has some risk.

>+			/*
>+			 * During a signal voltage level switch, the clock must be gated
>+			 * for 5 ms according to the SD spec.
>+			 */
>+			mmc_set_clock(mmc, mmc->clock, MMC_CLK_DISABLE);
>+			err = mmc_set_signal_voltage(mmc, MMC_SIGNAL_VOLTAGE_180);
>+			if (err)
>+				return err;
>+			/* Keep clock gated for at least 10 ms, though spec only says 5 ms */
>+			mdelay(10);
>+			mmc_set_clock(mmc, mmc->clock, MMC_CLK_ENABLE);
>+		}
>+#endif

A proper redesign is required. So I am going to revert this patch.

Thanks
Peng
