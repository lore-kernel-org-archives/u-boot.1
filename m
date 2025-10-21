Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F612CCD1A5
	for <u-boot@archiver.kernel.org>; Tue, 21 Oct 2025 20:45:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AACCC82B20;
	Tue, 21 Oct 2025 22:45:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="cTsLRXA3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FFF0807C0; Tue, 21 Oct 2025 22:45:37 +0200 (CEST)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21F178323A
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 22:45:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oiIFeJvcplMgYOhG72PmTIuvySmVJWIIpACLkKaYH89vAlOD11CUktQBURov6sXt868XoTd+N7uzhiyMusNiSBaVrIwX97OVrktO9rWjqkunBaBLUnhjk4ymgrOCdszFZFPcFMNraECYvMeHAovT+m7Elu/gNitYFw9fncQDpzj+0BPHSVIE4k0zD/FVKowzh5Z81cY2FVdZWNUoQIrHUd7D/GS6u5jdBfdRNU0AK+qze2Y5Q1NXA30ZXJoxsEONAv82LBjV0KMioGybr9BICAFGzOfWl4gALsl3nHkiVxSzrqU5VMsIu84EU123yqnQO43T7E8PHttxUh5JaDLFwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p2n6inOa9inuDdqCuZ8g0i67mSCHwgQyQ6bOQm6L+CU=;
 b=UaXoKy17FF+fsTcCrakYzIkL7Ck3ieHhoIUXtIw2dZ9IhNZciAV4ylhwAlEjX3xRSjtzmQx/rt64Pa/4boG85nOCy1QBA5spYL/SOz+NqzHCzF3w6pfO1yuMJzf7xJXsYW5XHl1RXKmEnqWWPGDVvq7fIakRJm/YTnZ1nwgf6CuaMaL0eI7Iy05z0qtPGINISSccZSLQCXhPPPI9LSWtlFmvZNri0gt/peP//HkHxZGIuKNNnVJxU60XWeQrE+LnlTF2l6HPmLdWH3rtJD51PUGXUGN8XR8mSbLGfcYNFlqZIbVDGqgUJ+0einfSGe+Qxa5nVRP806Z2uXW6f+/Lnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p2n6inOa9inuDdqCuZ8g0i67mSCHwgQyQ6bOQm6L+CU=;
 b=cTsLRXA358EiuMWFuTZy5oKfhBGZI96OBGfpDvBqE+OovSt81w/GudwLLG6F2c8nLGZUOWetFGmCBGPvAN/tWomdB4jcba77A+fOG1Bpzyg1+ImN/yA3rpApW8stR/ltWvOPyDET0e5R4XHZb/hE4UvAgL6tKl0pZqKNKzdxaSn5wAWkF/FmhMr3v1ua0eYapF7ngKs0cix26bmP8lpXaM8hryVt4l6ue11u2DKmEYw/USO0XevmXGziycvfU7iDK9Xwd3IEI0XIKdAFFEb/Vj4a2Aka6wc8DzfpFZ203JJqtQB/Q6WejaEZWnW6djyHN6SFFuEboNSm+k9XFaJgrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by DM6PR03MB5132.namprd03.prod.outlook.com (2603:10b6:5:1e4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Tue, 21 Oct
 2025 20:45:31 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844%3]) with mapi id 15.20.9253.011; Tue, 21 Oct 2025
 20:45:31 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, peng.fan@nxp.com, jh80.chung@samsung.com,
 marex@denx.de, tien.fong.chee@altera.com, tanmay.kathpalia@altera.com
Subject: [PATCH] mmc: sd: Handle UHS-I voltage signaling without power cycle
Date: Tue, 21 Oct 2025 13:45:26 -0700
Message-ID: <20251021204526.22701-1-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0069.namprd03.prod.outlook.com
 (2603:10b6:a03:331::14) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|DM6PR03MB5132:EE_
X-MS-Office365-Filtering-Correlation-Id: ad15a09b-27ce-42ef-a1a0-08de10e2c6b6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3tThsRHEAM7gIuCdpIqiuZ24FdYQb9OfZ4gj4GsCtJwc/uRT+lWWJl9kdONd?=
 =?us-ascii?Q?5OcCoRl0r/KRfwaBin3uQ6CvieaVbSYCDxVcbZ6kt5+s4K3i6LNdwr475xj5?=
 =?us-ascii?Q?YyZ3j10mhMDuxXpL2a5FQtcn+0+vJqLGrwxBE0DgSNz1TuBHDNXnX7Y7Zmr3?=
 =?us-ascii?Q?CejC80+VXECuVE8MgSOxQryvU7EC60S9guHa0O+f5Rsp+Y5PM/+1a2diqfwu?=
 =?us-ascii?Q?gFmxaNHYbtya1KJ6houlpL1uUTtwH8wUx2rw7uxXs9DvgmyLIRXCNBFvnn3Q?=
 =?us-ascii?Q?mSrROPLF5npnY84Km2sqNd+FRaIDeidTZYjcRCihZQ3XhGfaoJvHfK/+Gtzx?=
 =?us-ascii?Q?Hq4H4bNtIyTiH47IGhDt1/RfbGXF4UL+fwAEPHqf4oM1BNr53wpPBuYMjXwT?=
 =?us-ascii?Q?mHMyHdA1giT/XtL51hkCQtIUkXjgCRn5PXlYAqzyEtblOKBJff9uMzr80UCG?=
 =?us-ascii?Q?kXoCA5JbDDf1GQgHdgs8I8ZcP6y3nmFHbw2FVU4RRwwiVd0DqAwlUS6KTDO6?=
 =?us-ascii?Q?1GiKSpe2fR8T2d11T8JUGk6j7ThvfsPU1HgpMITGXcYGcoOMFmBREV38/GF8?=
 =?us-ascii?Q?kae4PX5lOTaCCPztBg706YUhRZG067ydAAmeToj6R7/QpXaeNqUI8ZEVkwpL?=
 =?us-ascii?Q?7t9hOsj225Yp4dVkb8IOYr72fuAJL/NJtFmaqM1p411i34IUjOg0pinOH8q8?=
 =?us-ascii?Q?N7iALc/a27vaMW7hrZsxHI3FnlYYosOPpztwPb02RcbzN/XJ4o+5Is2h/gRs?=
 =?us-ascii?Q?uKO9aMnQIuW4TEJhnBOOUHhmSF7EcwzjnWSe+L54wUhU+zrPenZTNANR6bV2?=
 =?us-ascii?Q?s0HojwWKf4sMJMfHa4dpClIa5HXCQo/SSgQTgpAaF9uie2ag/q3qyPWbi10m?=
 =?us-ascii?Q?wWc3SRyLLj3sI80wMottYa9XPd13ZoE1aw3UknQ9teplohYKnGAQkVXxFwEB?=
 =?us-ascii?Q?ZVcPfFujXids4M3mGoctGAHHgp8VktZF6li/pCJzmKeAjVeSPdj12wsmUU3Z?=
 =?us-ascii?Q?u6ot2tp8Ejsy6ni2YL8GT2FnXKCm79yrjhGTmAhk2hYepb0r9yhQR+Ae9vCE?=
 =?us-ascii?Q?OJwqwIyYNDTI0nxDr1+GVksar92bViIXz8skLpyGWWh91/WLAE0GUO2YbrLf?=
 =?us-ascii?Q?1gxen1cuCaAxd9MCDCme+OiNFO0k+tS1A3W5RunzOhEZwQ+utOlHrDxBOpN1?=
 =?us-ascii?Q?UnnHH/UsvFiSk28b3r4lS//Um94pHESIyx+DUUYkyEK2ZHPteOxlQkr6DoRT?=
 =?us-ascii?Q?7YR13MUiGin6lDgkaxhnIA/KwzUyoeBIHMrJhcKh8uPPU7xNxThUI2jHO4IW?=
 =?us-ascii?Q?JanPX8XyzZVXURKpi0f74phbiHZ5IUpaouoeBW+68eBpX33Vb22FbbKF6K/V?=
 =?us-ascii?Q?ohXSJc8JMPV7FT6HsD4qJSFafJfh/oyIohG5PswLEfs+CWL1GAfEdoFbxSSw?=
 =?us-ascii?Q?IctvPt7O3xEDSqkHtygcRalT0K3t2PLT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vRiIpl7sq5xT38x/g4EpQyCN7mTzobkgC/YWmkyeCsIgrODH6zdD+oJzLNe7?=
 =?us-ascii?Q?8YvAVmZyhdsdaTppJjBWGpCoWvmJvPgnxjixiKoOyQU6Z7ZXya4YmxXVDbD1?=
 =?us-ascii?Q?rBny7s+Qxxg8/FKonqmqcH2CMYFOt0LdqGv7lJubGQawq9z6NDEE8itxfz/2?=
 =?us-ascii?Q?y+Oz5z4D8pD+XEmng486HoUeQ+ElnfSJFvqCLQYaX8btyhEL/bOipnUlgghQ?=
 =?us-ascii?Q?YK9sliYaSywPuwZU2wER4g+ZnqgZjHgfUN6g0J4nRbXfEV0Q9WUGLCKuqDmJ?=
 =?us-ascii?Q?bxS/XrUws8jLULDeL2lIMTYTmDZBexxFgcrI8k91N82LjYSUhb87iSv8rfrf?=
 =?us-ascii?Q?LjamQPin5DBSh7uszselEfY/19gCHpRX03FVUS0r+78HRxgYR5iMH8d4Ii/v?=
 =?us-ascii?Q?oQC7fokMBfRjQGHUznNrSMT1lCMmiWNfXOMKXLHfYnQnxIW35qR3Nw7CwYbC?=
 =?us-ascii?Q?JjBl2WshkXWTkxauiLe7y/2zUQlJPzdksMsmPgngZF6jxptgglfd1+qv8rv3?=
 =?us-ascii?Q?n33xb/++3W/pExjeGKtAtavCDIiOMoG4iZmh+8HcxjMBeKCthEKLd02eUV1n?=
 =?us-ascii?Q?TRk4rLbhIX9zMz9LVLT+M5Lcn1n7qvTT2SpbF3gWSBmqgTsUnrTHLTRL2rSR?=
 =?us-ascii?Q?UNyBlUcqfRk4giLqrvQURTqEGlMqWdL/xREkqOMWhXOMgVGHtw90FkUCnVHP?=
 =?us-ascii?Q?zwWg51lkI187ww86pZl4GFyTftKlSGu/UcMsscr60TWNPFghqxq20RBkrW4x?=
 =?us-ascii?Q?GXnXYexFgx8PxlrHiZ1oAeufdz1bKSPNcyVFb0Mb6PViC2Ynp0MBoEohKZSx?=
 =?us-ascii?Q?0bWKcVV3JyQcLJ9bTYG0KM6O9qnhMqxAiOOCK+d7gEwGyDiAdIhbmzWVSkSq?=
 =?us-ascii?Q?ce38RR2kAf/722Vmp8qv0Ihql4ZUWBrQ11z98ycB2uRz7/x25U+mXlwjZvha?=
 =?us-ascii?Q?+w+JKdhxD9C+7UEjg4lRkulEafpx8UBicSB4eMMphOK0cGhXZifEKs9DBaT2?=
 =?us-ascii?Q?ZHXdjHCDtaa8HnRRaYrnuvBU27OVtDV38g8rBlLo2fT7RVSVlr8dTcPPb01a?=
 =?us-ascii?Q?e1UCrRByAtV7q+R4Bp2KtwyRyAV277DwPPDqHYxs2MAmDrZnoBD2wq2Z5F+C?=
 =?us-ascii?Q?ZDxjcVo4ru74dYronL2IEwErU+Jdhsry+IRFxo8iP2AoBWSU4zmrhaufRPVx?=
 =?us-ascii?Q?6c+dM1Dfow5siPvBL27DVfhL/r4OivM1Hz9ByEEGQ6AKR0dd+z6iDu3giVxd?=
 =?us-ascii?Q?1DLktwGnNd35faFzRg1WQoYVvvuA55OpulD7sQ8zzIg8xTY2GaIdt0Uzpn6g?=
 =?us-ascii?Q?pI+ThdX2WNqSQaak7K6hGLMG9/uEtxbhH0sPF7EiNoe+zM7j2xt6gW88dGSd?=
 =?us-ascii?Q?xon/0oscq15sZ3JDUlDjRCvY0MOfVfR/VBlXhtiPpW6q7B72KOUPl3QRc36A?=
 =?us-ascii?Q?Vw3eiB/A/OEPU8re6IpVVtixt4Uo7x1edqNq10b850IrRZZjYuBCti2wmBJO?=
 =?us-ascii?Q?lNRdRObMBBj4Z++C/NoHcvZBKfCkC6qheJA6ch9ylS+7ttR73q0WgcdHHQJB?=
 =?us-ascii?Q?eqAXEEhMdXYfubmhNwvNwIKvso/vXLcQlmCgnf+/LMMWJ0Uv4wTjvffMlKgA?=
 =?us-ascii?Q?oQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad15a09b-27ce-42ef-a1a0-08de10e2c6b6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 20:45:31.7388 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ES7IWfT1TgWBg9hE/TpQwcuNledkkzZVhK9K3a+0p8XItvlQRQ48qsYXuaWgUrjM9VwfqodxnoWA/ogeGT7wtIec0wZFa/QEF6bh4nqkVY8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5132
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

Some boards have SD card connectors where the power rail cannot be switched
off by the driver. However there are various circumstances when a card
might be re-initialized, such as after system resume, warm re-boot, or
error handling. However, a UHS card will continue to use 1.8V signaling
unless it is power cycled.

If the card has not been power cycled, it may still be using 1.8V
signaling. According to the SD spec., the Bus Speed Mode (function group 1)
bits 2 to 4 are zero if the card is initialized at 3.3V signal level. Thus
they can be used to determine if the card has already switched to 1.8V
signaling. Detect that situation and try to initialize a UHS-I (1.8V)
transfer mode.

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
---
 drivers/mmc/mmc.c | 55 ++++++++++++++++++++++++++++++++++++++---------
 include/mmc.h     |  3 +++
 2 files changed, 48 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index ec61ed92e86..e1f62a5d0ad 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -643,6 +643,19 @@ static int mmc_switch_voltage(struct mmc *mmc, int signal_voltage)
 
 	return 0;
 }
+
+static bool mmc_sd_card_using_v18(struct mmc *mmc)
+{
+	/*
+	 * According to the SD spec., the Bus Speed Mode (function group 1) bits
+	 * 2 to 4 are zero if the card is initialized at 3.3V signal level. Thus
+	 * they can be used to determine if the card has already switched to
+	 * 1.8V signaling.
+	 */
+	bool volt = mmc->sd3_bus_mode &
+	       (SD_MODE_UHS_SDR50 | SD_MODE_UHS_SDR104 | SD_MODE_UHS_DDR50);
+	return volt;
+}
 #endif
 
 static int sd_send_op_cond(struct mmc *mmc, bool uhs_en)
@@ -1369,9 +1382,6 @@ static int sd_get_capabilities(struct mmc *mmc)
 	ALLOC_CACHE_ALIGN_BUFFER(__be32, switch_status, 16);
 	struct mmc_data data;
 	int timeout;
-#if CONFIG_IS_ENABLED(MMC_UHS_SUPPORT)
-	u32 sd3_bus_mode;
-#endif
 
 	mmc->card_caps = MMC_MODE_1BIT | MMC_CAP(MMC_LEGACY);
 
@@ -1451,16 +1461,16 @@ static int sd_get_capabilities(struct mmc *mmc)
 	if (mmc->version < SD_VERSION_3)
 		return 0;
 
-	sd3_bus_mode = __be32_to_cpu(switch_status[3]) >> 16 & 0x1f;
-	if (sd3_bus_mode & SD_MODE_UHS_SDR104)
+	mmc->sd3_bus_mode = __be32_to_cpu(switch_status[3]) >> 16 & 0x1f;
+	if (mmc->sd3_bus_mode & SD_MODE_UHS_SDR104)
 		mmc->card_caps |= MMC_CAP(UHS_SDR104);
-	if (sd3_bus_mode & SD_MODE_UHS_SDR50)
+	if (mmc->sd3_bus_mode & SD_MODE_UHS_SDR50)
 		mmc->card_caps |= MMC_CAP(UHS_SDR50);
-	if (sd3_bus_mode & SD_MODE_UHS_SDR25)
+	if (mmc->sd3_bus_mode & SD_MODE_UHS_SDR25)
 		mmc->card_caps |= MMC_CAP(UHS_SDR25);
-	if (sd3_bus_mode & SD_MODE_UHS_SDR12)
+	if (mmc->sd3_bus_mode & SD_MODE_UHS_SDR12)
 		mmc->card_caps |= MMC_CAP(UHS_SDR12);
-	if (sd3_bus_mode & SD_MODE_UHS_DDR50)
+	if (mmc->sd3_bus_mode & SD_MODE_UHS_DDR50)
 		mmc->card_caps |= MMC_CAP(UHS_DDR50);
 #endif
 
@@ -1830,7 +1840,11 @@ static int sd_select_mode_and_width(struct mmc *mmc, uint card_caps)
 	uint widths[] = {MMC_MODE_4BIT, MMC_MODE_1BIT};
 	const struct mode_width_tuning *mwt;
 #if CONFIG_IS_ENABLED(MMC_UHS_SUPPORT)
-	bool uhs_en = (mmc->ocr & OCR_S18R) ? true : false;
+	/*
+	 * Enable UHS mode if the card advertises 1.8V support (S18R in OCR)
+	 * or is already operating at 1.8V signaling.
+	 */
+	bool uhs_en = (mmc->ocr & OCR_S18R) || mmc_sd_card_using_v18(mmc);
 #else
 	bool uhs_en = false;
 #endif
@@ -2701,6 +2715,27 @@ static int mmc_startup(struct mmc *mmc)
 		err = sd_get_capabilities(mmc);
 		if (err)
 			return err;
+
+#if CONFIG_IS_ENABLED(MMC_UHS_SUPPORT)
+		/*
+		 * If the card has already switched to 1.8V signaling, then
+		 * set the signal voltage to 1.8V.
+		 */
+		if (mmc_sd_card_using_v18(mmc)) {
+			/*
+			 * During a signal voltage level switch, the clock must be gated
+			 * for 5 ms according to the SD spec.
+			 */
+			mmc_set_clock(mmc, mmc->clock, MMC_CLK_DISABLE);
+			err = mmc_set_signal_voltage(mmc, MMC_SIGNAL_VOLTAGE_180);
+			if (err)
+				return err;
+			/* Keep clock gated for at least 10 ms, though spec only says 5 ms */
+			mdelay(10);
+			mmc_set_clock(mmc, mmc->clock, MMC_CLK_ENABLE);
+		}
+#endif
+
 		err = sd_select_mode_and_width(mmc, mmc->card_caps);
 	} else {
 		err = mmc_get_capabilities(mmc);
diff --git a/include/mmc.h b/include/mmc.h
index c6b2ab4a29f..51d3f2f8dd5 100644
--- a/include/mmc.h
+++ b/include/mmc.h
@@ -759,6 +759,9 @@ struct mmc {
 #endif
 	u8 *ext_csd;
 	u32 cardtype;		/* cardtype read from the MMC */
+#if CONFIG_IS_ENABLED(MMC_UHS_SUPPORT)
+	u32 sd3_bus_mode;	/* Supported UHS-I bus speed modes */
+#endif
 	enum mmc_voltage current_voltage;
 	enum bus_mode selected_mode; /* mode currently used */
 	enum bus_mode best_mode; /* best mode is the supported mode with the
-- 
2.43.7

