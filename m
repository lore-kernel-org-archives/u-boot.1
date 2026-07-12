Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D92E9C43458
	for <u-boot@archiver.kernel.org>; Sun, 12 Jul 2026 13:09:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D90D284A7A;
	Sun, 12 Jul 2026 15:09:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="bI+A3E5K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBA0384A6F; Sun, 12 Jul 2026 15:09:32 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 314C584940
 for <u-boot@lists.denx.de>; Sun, 12 Jul 2026 15:09:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t24NYcM9JyU6AizIg+QjJ2pqoJgLiDIxDLQtlCxVokMrdBzjfhNpaM8Cb9fhIzjDNRNVBHbCrusCqfS3WH9hVErM7Qo5RCIWa1gdODQ391nHHc4D1dKcjXn8ThZ2qt1Uc7REoXH9CIqkOx1EdQq5PX9HskFXwi7zF8dhGMIJfL3f5P46kFW1yToHJur7EHBzFeMIFM5FoASCYX+ellshgOKRhuiwPTC4vQxuGbLVMg17G1ARkSmsm4xmtEseD7wvgJgjt7Jyn0STPQXdQj7TyF3J3KK3nAlkTV77iexqisJOsHzf/gAihsm5FElE7C5yGhvLqEJ3gxRwbwHoxObvJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5NiKFmSirTkTADPzx41oSSyFMF9SwK8xJkIU3+RZPQU=;
 b=uZCse6jm8hkYNYiUI3LSIB1u7Yem7w7k2wg4/YHGdKsR3pGAa4MsUQZM7SBu5Ad513aZBDHwBTqKuEhT4qRGdWth4lOKd8ypMN1UVw0OOmZ4ljXFo7dnb+uzqrXjO2Pf2fUgCMXUoXQgBu5RGdLcMycH+lY8IIXQrPik8wRupev6x2zfpXRgeFjJFajjJ/r1HYCUm6jFIvbZH/P6yGx7tvz6Mw9eYVdfJ/dgzWG0LmXiJlARWGzUU4LR/Qy2OgvB4RaPcgOLDQyKjDFHrr14+eoeEqbVNUuZHtx+uNKJwpzP2jaFpPdIQZvxi7WroCbRvwys65BCq7t/kszMk5u+tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5NiKFmSirTkTADPzx41oSSyFMF9SwK8xJkIU3+RZPQU=;
 b=bI+A3E5K5x9d3sl+0DAcFsLJvbqesKZtFelQRmVu86uEUZd4JnpYGvBfyRBPVHq96dySRh9ugKVRJ62ph331YvaqzRo+bKBPv7h4DvRPJ3Y0UKc2L/uFAd1ua2c8fbOFJ9QCRCkOXzHyHnGHEkuDQa1koLbQjQVxHoyYM7venVn3KdR5P87vB3kgEM7YwZ9MVKra75ehuUo3Qw3gQ/SAn16f9aj1dByZeJv5MVjZdLmRsY0J55ETdCqyUhDWcJ+qVddo1mhsNTKyMuj6JzcjHgyCBBULcMXtMXw2Eb0lx264Ck0gk4rZCyuFGkrlsm/8U96fn+INY8R2Zav+cigMPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by GVXPR04MB10945.eurprd04.prod.outlook.com (2603:10a6:150:21e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.19; Sun, 12 Jul
 2026 13:09:27 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0181.019; Sun, 12 Jul 2026
 13:09:27 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sun, 12 Jul 2026 21:07:32 +0800
Subject: [PATCH 5/5] mmc: fix mmc_deinit regression when card is at 1.8V
 signaling
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260712-mmc-fix-v1-5-99a1136bbe54@nxp.com>
References: <20260712-mmc-fix-v1-0-99a1136bbe54@nxp.com>
In-Reply-To: <20260712-mmc-fix-v1-0-99a1136bbe54@nxp.com>
To: u-boot@lists.denx.de
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 Jens Wiklander <jenswi@kernel.org>, 
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>, 
 Yanir Levin <yanir.levin@tandemg.com>, 
 Eran Moshe <emoshe@gsitechnology.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Christoph Stoidner <c.stoidner@phytec.de>, 
 Tanmay Kathpalia <tanmay.kathpalia@gmail.com>, 
 Jimmy Durand Wesolowski <jimmy.wesolowski@mobileye.com>, 
 Iulian Banaga <iulianeugen.banaga@mobileye.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SI2PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:196::9) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|GVXPR04MB10945:EE_
X-MS-Office365-Filtering-Correlation-Id: 46882352-1c94-49f8-05d1-08dee016cd6d
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|19092799006|1800799024|376014|366016|7416014|6133799003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: UgmCcF0m0tHB/Dsbf6xzleyG1klZWBxBTo8HRojWSowMbyxEEOqcqfwpf/i2eVuKXlqkkbdDoW4m8cxPf/4r0xePHNNsO3ix+k0KrURJTTyKpNyic/QoqljNPjBKt1q3Dw5M4rebu6yh2KNUT7pHvXaqHkkXpItylA/3Djsl/I92o4Un46O2JRsB+oDjUpOpfj8J4dgcnb/pId/fIEjB3sw1zhC5XhEp9rpLrMfIb/xZeRGyF93bIFiIOvRY6RyIkZHiBtW6uGTsc5k/P0WMXw2S56NBftRhAeDeehRMRNcQGu7l4M7ZZr7TepyV1WYZWS56Wr3bkPr9ZjhsIWywfpxazQ/73PyULnADtlwDMzaJQ/ngz/huflEHMu/3kJXI9ZOA9V4YnDSWvnJVU1AhVW7XgQxlYzGLaTHH1u4I3cXPFSnmH8cxfSkhjrxkXHLVXRk5oRPy6N7Le/Av9clhog4lLbYpNsU1sJOHdD548rsDo/D2gVkEd+nnlB+cg0mVHnpsHvdMGR4pvuSZRDZDiqX5La1RVej5wtysM64qkmKLKVTX5SLOeB5MbYVZIBubtyAQ+2uzKX3GenLjPVzuymnh9No2bq8QtHisKe0dU7sWH4g2y1dhCHCEAbtTqvDRk5GV4PD5rjRdHOsvmK0da00bYK5NLCAiFsifbTxANT4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(19092799006)(1800799024)(376014)(366016)(7416014)(6133799003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkRSWDJKQXBtL1I1LyszbCtpMkRpODlJWTd0NDFoTHVEeTdVT1lhUWJseExI?=
 =?utf-8?B?cUNaSnJHeHdrZ1pHR0V3elVEc2VrUkxMVnMvM3NZaGtUbFVBdzFMVkphVE5V?=
 =?utf-8?B?NlR5ZFM2b0Z2RGxzdlpENVlUMmZaZE9OMy85anFLQTM3TGErMTVOazBzZEp3?=
 =?utf-8?B?MCtjK0pWNmpwbnZiY2tYZUtsNDh4OHFRdCtvMUtiUEkxeWVxVDVpN2tPVERs?=
 =?utf-8?B?N0h5Vyt3SlZ4MEd1TVhnV0FKY2RRMlZDREhyRXA5Y09nSW5TYXJkMW1nSHpk?=
 =?utf-8?B?ZHU5OFExTmcvOFNVZ3ViWmthYzdpMEw3anZJYjB0UGZkakN3TFFhVExlT00v?=
 =?utf-8?B?MGhQOU5SMHVXL2NJV29CdHg4NTV3RGtXcTF6aXBnSmxURHNBUXpha3B1QXVy?=
 =?utf-8?B?REdVMnUxeXpLalcxZ0syWWpOTWhJY0N0RVBzTFBMUkdDMENWVWk0L3ZuMjdG?=
 =?utf-8?B?dVprUzRJMklTZFNpTEgwd3RJWnZJS1J2VlRmQTI0N1Bpb0QrYWIzaURKRnN6?=
 =?utf-8?B?ZEVLcFE0OG9ZTks2NlVFNkZaeStpbWh4NERPOHdTbkZYYWNwYnBJNmx3STZV?=
 =?utf-8?B?dWsvZ3JIWFkzMnRxdkl1OEdHL0U0TVhIcWJIS0NuOWxvYm1DdWF0YUFMa3pX?=
 =?utf-8?B?cXNsM3BVTnU1bWJXTG8vdk5BSStUQmFWM0ZxWHdCT1pTWmJuOVUyYjgzZUM0?=
 =?utf-8?B?OEhFRDJObG1rcTdHcWZnN3BIS3h6MUhJR25RNGFXR1VMQkQ2bWlUZG12Z3pG?=
 =?utf-8?B?Kzc2S3BCL3NKcmI5Tms3ZE9aaFFGV0ZXWTFqUDlRbU5QRTZTalU5eHh4M2hS?=
 =?utf-8?B?Z0JOV1dlL0RGN05BZmJzK0VHYmxXYWxXWlZXd1gyMDVkam85QTZQN0ttaWFB?=
 =?utf-8?B?TVNsTis0YVljZFlxTlNrRGtUNitlMnZDMGV2Sno3cWZXdExUZm9kdXJrUVFS?=
 =?utf-8?B?ZmdQcGg1d0k0RTZiMHFmTERwcCtqUkt2V3pjbXEranBrSlpJRjczeWYyOFZJ?=
 =?utf-8?B?dWl6WXlkcXVhcTFod0lJeHZ3V0w5TitjdmFkU2E0NjBWSzVzVERhYTQzQ2NU?=
 =?utf-8?B?Mk5qNlArQlV3ODZQNXZHQzlXbE51N3YxNXczWGtTWVFkMTZ5MHlTdmovOElQ?=
 =?utf-8?B?UERWYTdKMElmZXFhc3NiOWplZUpPNVBjVzFrLzIzbFFCOWJ3RGE0Rkl4ekZh?=
 =?utf-8?B?YUxIYnZHSitBVHBOUHEyeHNzeXpNOEY3SmtmOU9xYmU4aGZiRmNBd2ZIbFBO?=
 =?utf-8?B?dko0NEF4d0UxVVhOTFgzYkZJUktaMDdOU3dTb2NOWlYrMXBibE1oN3BOYTdN?=
 =?utf-8?B?TFFHYUNWWjFiaUticjdrcnJkUlhPV21rUk5RcHpWQ21hbE1qREtIQi91VzNT?=
 =?utf-8?B?V01hOUJPTk94U1JGdVVBM3Q5ajNtVmVQTzdhZjlhVGpOcE9td2dwTUd0V1Ex?=
 =?utf-8?B?RVFUeUN6V2UxSFhHVXk5ZEdQRk9ZQ3RZRGRRWFFadU9uQzNoUXdNWkt3RW50?=
 =?utf-8?B?VnJpQ09rVXQ0Zk5DVnJYaGtwK2FOMUV4bkl5Q2p3QUpuN2crR210VFNROE1P?=
 =?utf-8?B?WTM4QlZJVmFlYzhuY24rUEVhTWtndUNTaDJNWENITW9jdFJGdmphZ2ZiZmI0?=
 =?utf-8?B?cUlDWTQxZS9ob1p0NzNyQ2lXYXI5OFlIV2ZIWWlJQ3g5Z3huVHdab2pVUFA1?=
 =?utf-8?B?V1dLMTlpcms2UmYyTVIraGVhRFBFeUF0WDZ4eXpzNHo3M1JqVWlVS1dNTnJI?=
 =?utf-8?B?YjRCMDJvcHloRUt6ZTZ1K1ZXMVlqOWZ0SkJyNEE1c3VRSVcxR0JhU1M2Q0lz?=
 =?utf-8?B?aGN1M1ZZb3IwQ1I4U1V6WVhkMEdlc25zclBMQTdlZVNJMG5DbFVwS1UyTjY3?=
 =?utf-8?B?d29mTmVwc210eUs5cFB5Z3pHZ1U3cWdLeDh3RlBZSWlBQXBYUWVDOGJEV3d0?=
 =?utf-8?B?b0ZGbWtUbnMrbzlCOVhjV1liVng3Q2tPenlNNndZeWJIUUtHNFd4VFY0dnZC?=
 =?utf-8?B?VGlHTUIxb05xTk5zdFFiNUM0WFlPUmhHc3UxczZrMy9ZMHdUbmlUR2QxRnZ4?=
 =?utf-8?B?K2RwMzV0WFRiWVQ3N0M4OVRrZTVndjJUNGw3dVh6Z0FKOEs1eWRmL0xEVlZ6?=
 =?utf-8?B?M1hZQmhBcWk4R0lkM2JtaXFmTEloSk10NWR3M2lVSUlxOGVTSWgrdTlEMU1z?=
 =?utf-8?B?Q1h4UzlLZ0gvUVB1cStXQVJDL2xvUVU4T252bitlUHlLYW5aSSszUVhJeWZn?=
 =?utf-8?B?WjZJT3ZhOFhrMFNaUklYMitTSzNCakhxbk52NEtXSFRaNDg1Z3JGVUFmNGVL?=
 =?utf-8?B?ZytWeDh3SEE4bFdCN2E4ZWhIanUwMy9pbmxqSVRoajFEN01pejhGMVp1TGE0?=
 =?utf-8?Q?EZUr8rTbcr1Y9bm6BmYFFXh5EOG3yFeuE8f5m?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46882352-1c94-49f8-05d1-08dee016cd6d
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2026 13:09:27.4885 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VEJQvZ0lfu3dU4i+UODEcSBY/PvurKQG7RZWtPluqLSzKVtZr5IHSPDHkYidOABcRkMUue8PobiyMHqxcQLjQc1Tw//O/OVzBhY3E+8ojJFwclkYyxL154E1SFiy72Je
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10945
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

From: Peng Fan <peng.fan@nxp.com>

Commit 906ee6785b1c ("mmc: sd: Handle UHS-I voltage signaling without
power cycle") added detection of cards already operating at 1.8V
signaling via mmc_sd_card_using_v18(). This correctly handles the
warm-reboot scenario in mmc_startup(), but causes a regression in
mmc_deinit().

The problem: mmc_deinit() strips ALL UHS capabilities from the card
caps and calls sd_select_mode_and_width() to downgrade the card before
kernel handoff. But sd_select_mode_and_width() now checks
mmc_sd_card_using_v18(), sees the card is at 1.8V, sets uhs_en=true,
and tries to use UHS modes -- which were just stripped from the caps.
The fallback modes (SD_HS, MMC_LEGACY) all fail because they require
3.3V signaling, which the card cannot revert to without a power cycle.

Per SD Physical Layer Specification: "Once the card enters 1.8V
signaling mode, the card cannot be switched to 3.3V signaling without
power cycle. If the card receives CMD0, card returns to Idle state but
still works with SDR12 timing."

Fix this by preserving UHS_SDR12 in the filtered caps when the card is
operating at 1.8V. SDR12 is the minimum valid UHS-I mode and is always
available at 1.8V signaling per the SD specification.

Fixes: 906ee6785b1c ("mmc: sd: Handle UHS-I voltage signaling without power cycle")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mmc/mmc.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index 5fd12d21f92..809d7b6b578 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -3178,6 +3178,17 @@ int mmc_deinit(struct mmc *mmc)
 			  MMC_CAP(UHS_SDR50) | MMC_CAP(UHS_DDR50) |
 			  MMC_CAP(UHS_SDR104));
 
+#if CONFIG_IS_ENABLED(MMC_UHS_SUPPORT)
+		/*
+		 * Per SD spec, once a card enters 1.8V signaling it
+		 * cannot revert to 3.3V without a power cycle.
+		 * If the card is operating at 1.8V, keep UHS_SDR12
+		 * as the minimum fallback mode.
+		 */
+		if (mmc_sd_card_using_v18(mmc))
+			caps_filtered |= MMC_CAP(UHS_SDR12);
+#endif
+
 		return sd_select_mode_and_width(mmc, caps_filtered);
 	} else {
 		caps_filtered = mmc->card_caps &

-- 
2.51.0

