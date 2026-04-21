Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBA8AF8FA6D
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 12:25:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFEA783FFA;
	Tue, 21 Apr 2026 14:25:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="jDEOqicW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2568584286; Tue, 21 Apr 2026 14:25:28 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3E9F805D7
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 14:25:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=koRVeNoZuoQRbCqnKofeLr5aNKBUlThzciotwk9ceepQ/eGq9OUzYCB0JbJTMuXMnc9PageZ7njTzZ7lc91603dI5MXR5l08Yp8Ac2h/iIDa8uR4D1AEOrILolZ5ciw0KJfta/NiEZ9XC6eVzeuoqz7E61nhunHPnd0s/bxiZq0N+JZbcSeUi7u75PnTFphalNfFfSStsCzOD0VF35FO2dQJNH9EZQDMmEhWZV0KQn0xR7FnXukvq5WyTqN8F8PJ5Z099jc2X68uFCavyHz4GtGtsfnEeEb8qgq6ZLXYhJAwtVQj1avm6IM/pV1lKbfDFSqHs/bhFvdkVxpEekrUvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zWzXJxc/0SVyhfuVZ8qKJcfJxn4ny3tXEIR1NrFxp8w=;
 b=RGeDQJiaaXnisHZQX3aEE9ETAjjg/y9wVLPhiVJCgHqHW1fgUW9NZrPDr3jdXOQgaYWmpLa3TbHSl5cMBTQMgbZbJCgp2Fo0QemvN5SUjkPLbOytfuHJsmsA30hbzV/dPtKielpFzo5zkoVhFZMLz1G1pO4uX8rECehRSm2e924krckH2SPBnoM2SieCcdQkg9SPUjqqzO3cmJ8fDUrNNWEq7qTMP9PYvDwx+hRPini2KoSvFVd+6hc8ZhQYmklWEW+R6aTEmIxIB9H89NT6ylaABxu6L/OH5tllCwZRPBF1CDXirr2ds4M4tGF0XfxcabFWf76Ob+uznJHDRwDtVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWzXJxc/0SVyhfuVZ8qKJcfJxn4ny3tXEIR1NrFxp8w=;
 b=jDEOqicWQ0MhikD6U0MIkW1jeCvovw7UwM0n/nZmpjsqHfHLw89ehRFVT5K0xbQvXPvrqiuPQnGr/leTIYmDQBByoXZf17wasAoG/JUeqOoMc/ei4EK7ImPmdiBIzSO85R2rnUUMV1Gh3F4LnvDl4ZdZWmuW+gspAKAhMO5LJJfkeEBsdsAVjEHwBbsX2n/mVleNtdqDQnZ71yW1GxJQjL3DJkmCcbclCESVkCR//Mcri7dAiD1ccrG5lmiE9OkYirONfAxQcGLEhW/jC1iXQPJv55HbmhJ3QIWJLcYGklE6juR7mxkOTpW8rVl55nf7kqWx2jtK363dONsd0jDPGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DUYPR04MB12667.eurprd04.prod.outlook.com (2603:10a6:10:65d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.33; Tue, 21 Apr
 2026 12:25:24 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9818.033; Tue, 21 Apr 2026
 12:25:24 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 21 Apr 2026 21:41:17 +0800
Subject: [PATCH 05/15] imx8mq: pico: drop redundant gd clearing in board_init_f
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-imx8mq-dm-pmic-v1-5-0e2b490542b1@nxp.com>
References: <20260421-imx8mq-dm-pmic-v1-0-0e2b490542b1@nxp.com>
In-Reply-To: <20260421-imx8mq-dm-pmic-v1-0-0e2b490542b1@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 kernel@puri.sm
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Yannic Moog <y.moog@phytec.de>, 
 Ye Li <ye.li@nxp.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Alice Guo <alice.guo@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marco Franchi <marcofrk@gmail.com>, Alifer Moraes <alifer.wsdm@gmail.com>, 
 "Lukas F. Hartmann" <lukas@mntre.com>, Patrick Wildt <patrick@blueri.se>, 
 Marek Vasut <marex@denx.de>, Heiko Thiery <heiko.thiery@gmail.com>, 
 Ilko Iliev <iliev@ronetix.at>, Angus Ainslie <angus@akkea.ca>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: MAXP287CA0011.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::24) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DUYPR04MB12667:EE_
X-MS-Office365-Filtering-Correlation-Id: b53c47f6-958e-425b-214b-08de9fa10fe8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|376014|366016|1800799024|19092799006|38350700014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: JOGqb6KRBBU45Gqh/HORfmwHpu3ovjtXEP+2ALwy9QZYJPLQlh9/RXCZ2Je1AL4tXQaeqwo2pky8GxGkQbLssg7Csp29l614pTLatPt7r1zrds5kgrlsfDS9mXonzR5NSkhKsxmuxFNjsW+l1OJKs2daR+kdtYdIBsC0ablBHYggNHGC6T4Rn04nh9STiQVa7RdRlfGATFqcJ+huBgplaa46+WhnPecVq0pcKEEPcOyUV9ekNpZV+ceAO0mfmUlAqSnTdvcLL3XQDoeFG3lU3b481rClr3wcvwQICOh2cGBT616Hz66/IR+jciETJhehj9KkJh0jz/DLKCff6oAsL7m9Fp+PpoelykMyGO66ac+u/fxWLwIc4fGhJrDK7eqUYRuJXQiUfm2LxR/g7N9jpHto8XHHcvQUJO8AQ/HHSAOB5HyRmkUjHjBu39LHnkpeHPH2yvH95K1vNMeTqiOls3QesZfCVWkwRB+iLonBxHw5/Tl8PxEgctfbpJ8Nu7PQd+hwrOE3NY3Gxg3Hbi0uu2gk2srYZgwBL46aNldQmyGqUdtkxN+JGnx5070fzjBAOc5gkYUrQGZQc0ReeeGueJLO9M0yqKItyp7wLxBAeDpUtLqdeSEgQ8/V7fOR/SzCrkOdnJoAeAoDVxV0JCrCVWT4zPgMUlkupjp+6eWKWzlMPrIkJ2BMo82xb0HS2N2FEAGny/WvGbs4XbexyTP/rjlf08RdLS5bneV9Fxu9r2aEFQaIMIDf3keA3lSALdzI9rSG3VYkNwgiJy8x/eKQBtH+SyUy8vW0vblD42HQf3Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(19092799006)(38350700014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2JNUW12SHd6K3BnV0N2SHZDZC9LQVc3RUs1aXU3bWtBcG5XbmZqbzhUTity?=
 =?utf-8?B?KytCNTdobmhwYTBYWmlIdVJSc1Jad1pSazc3MVBZNUhrTXF6dG9FaXdZSnZM?=
 =?utf-8?B?VkdhdzdKRDI3N2M3em15bGRZa3UvSWpOOTBFSXJDZXc3QjVaVGJvTTdZd243?=
 =?utf-8?B?ZXFxcEFOWXpRVmVpRlFpUVA4djhaL2MyT1BvUGdnU2NxY0FmVDdLQUt5TXA4?=
 =?utf-8?B?aHBzaU43aFN2VG9EZk9aWlY0L21DdklzdkVSSkcrOTZUeWlhbUZVMlJBcU9C?=
 =?utf-8?B?cTBQY2FXZDJqSExNSVBaRjhRbGF4WlNLcWNqbG5lZThsYWxRSkwybTNROUdJ?=
 =?utf-8?B?K2tmaGVVcndDNnBMaE40cENpT1kyTVdHbDUreGJZd2tROEJ1Ukx3VkNhMEls?=
 =?utf-8?B?eE02ODc2TkZEVnlscWJXVnY3emRnbkFoUnpHNTEvY3gzSldXM1c4Y2diUUpq?=
 =?utf-8?B?QWx5ZGFtOFJyYjRWOUd0bXNUTk9uMnR1cFNYMmt0V29nSDlINGxEaVAxaWdr?=
 =?utf-8?B?SlBYTzlQZXQwMUwzUVp5Y2pFbzJDMXdRRGFZTE5reGlPeWpZTGY2Zi9aODRR?=
 =?utf-8?B?K2IrQk5mN3NEbHBtWEIrUEFhZXlkTUl4OVp2bUhMWjA5ZDFveEhIZ2ZQdm9x?=
 =?utf-8?B?RDh1bmllYkNna1pFVVBxNzBmNXhBc3ZxQkhYSkZQeFBEQmFWdVpLQnlkZlIv?=
 =?utf-8?B?Z0RwSTF5SXFYN1RBcEI5V0NFMk5YaEQ4bG5mT1VvcU4vM0xndk8vOGZiM2pv?=
 =?utf-8?B?Q1VlZnI2N0I3RkhMTmtDSnR3M2E4VE5kRk5wcGtvRlZvZ09pVHRuREd5dVZj?=
 =?utf-8?B?NVMwMXNuQWgzdHV5eGVramIrbUtsZ00yZWNxWGR0bU1VR042QjUvazlQVUs2?=
 =?utf-8?B?WGRNTGZmMmRHVC9mUlFBQis5UG1vQmZYdG8wdjZYUUNnOXhsQS9ESmx2dHpv?=
 =?utf-8?B?aDFtUERob0tEOTMvU1RsL0V6WURwVHVYWWtjZ2J1VWF5Tjk1YkdSUVJKTHNj?=
 =?utf-8?B?R2FueHZ5MVZ4aCtSSE9uME9MckJjSXNnczk4eDE5bEk4NHFSZzhiTG9idFJK?=
 =?utf-8?B?ZFp1QlcyaFRVN09peGdXTTFSbkJpUmtjZzVkVkpuTHQ4Q3ZwVXE5TGxoTE5C?=
 =?utf-8?B?RzNUOWd1MlFIOEo5ZktTS29HV3FDTVlwT0x3STlEZ2ozaTJtQjlCL3dHVytV?=
 =?utf-8?B?UGJLdWF5cEdXWFRyemZBNndvTGFMd3AwSmcremJLVlBOR3Z0Nm1KODNvM0Y5?=
 =?utf-8?B?VUI4MFgyczA1MTQyWTc1UVIyV2txQ0RQSW1WanVnMUMvRXhXd0xPL0VzaXQr?=
 =?utf-8?B?OWJrK2tNMHFKaUMwNjdkMzFmVHZDazEydVpQT2VQaDkvSWorR3ZKTlVQbE9Z?=
 =?utf-8?B?SUQ0V0hrN21pMXI0VXlscFVUUC9IOWRldEpIQzZRWkYzZjIxTGNNYk1KNWdh?=
 =?utf-8?B?NTlDUnlIejVrRTRVbVY2c0wvYnZQTmZzWi81NG1WVUFkaVBPWTVnQVg0UkEv?=
 =?utf-8?B?ZmwweTk0VWEzc0lvdy83UXVIMGVzazEvK29ScERjUHNlbXF6bmM5blVaRnE0?=
 =?utf-8?B?VVE1YVhkaTJnUy9BSkkraXZjTFQ1WFlRR0xjOWM1cWEwRHF5UHhWOXBCWVVG?=
 =?utf-8?B?Rko1c0NoRFJaMVNGM2k5dEVxSUxrZ2cxUy81cDh5STRMMnM5cVpzTERlaTh3?=
 =?utf-8?B?Uy9qS2hOVzdEUWdCYTRObVc4dW1WNG5JbXRyMEViNTg4Vk4vbE1tZGRJbDc4?=
 =?utf-8?B?MS9Fa2pZb0RWSlJ5TUdaczRrc08wN2NyYWVvK2xidERTZitjdFljU1BId2pP?=
 =?utf-8?B?K2d1NmlSQTMyaU5iNm4wUWxOZXNHbk9idjRFbFBPM05GTFpXOFJLU0lxUU9u?=
 =?utf-8?B?RWo0QkNEYlc3MHd5SHBZUnM4NDRRcnJlWEp1OGMzZEVTYU43bkgxN1UrWEJB?=
 =?utf-8?B?Y0R4Y0x5aFI3VExKdHg1SVFNaGxkRmhWUkhLMzVJaEgxZzVLaVlwOTdwQ3RG?=
 =?utf-8?B?UnJwVTdXVUV6RUtWL2NZcEVuaDlJSlJrZFpuZmhWaFVwQVNNL3Q2Zm0yc3ZS?=
 =?utf-8?B?YjlzNnF2YzJoVWQ1S1A4SjZCcVNJNllFb04zT1Z5aXViejNlU0VCbENaN0li?=
 =?utf-8?B?TXMycHlteC9vZjNCMmpqM05EV3J2UDJDZHNpL3FROU9UL25vaU9jVitwNXhm?=
 =?utf-8?B?eGxEM3VDbTh4ajgxK25FNksyeHgzZllwcG5xa3cyTGJXZkZKQllFeHJUK21Z?=
 =?utf-8?B?ZEt3U0Mwc1grYnNVNGtPUFUvL21MU1ZMeXh4bXU4RUdFbmlrZTdrWFBMWHZY?=
 =?utf-8?B?SEpYTzZra002aWhCYUN1VkZmdncrb0lKN3JzQVNIN2c1YnZua2VJZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b53c47f6-958e-425b-214b-08de9fa10fe8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 12:25:24.2475 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +rr7dLMCVfjlauxT5ApV5nCsZrSJzt54J7iCkQI9lPxHN53JfZl7dqvs0gRQkozJ6AK+g5Us89E7aWlOmzszNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUYPR04MB12667
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

The global data (gd) area is already zeroed in
board_init_f_init_reserve() before board_init_f() is called.
Remove the duplicate gd clearing from board_init_f().

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/technexion/pico-imx8mq/spl.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/board/technexion/pico-imx8mq/spl.c b/board/technexion/pico-imx8mq/spl.c
index c9d68b402ae..eed7f70e833 100644
--- a/board/technexion/pico-imx8mq/spl.c
+++ b/board/technexion/pico-imx8mq/spl.c
@@ -10,7 +10,6 @@
 #include <asm/arch/ddr.h>
 #include <asm/arch/imx8mq_pins.h>
 #include <asm/arch/sys_proto.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/mach-imx/gpio.h>
 #include <asm/mach-imx/iomux-v3.h>
@@ -24,8 +23,6 @@
 
 #include "lpddr4_timing.h"
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #define DDR_DET_1		IMX_GPIO_NR(3, 11)
 #define DDR_DET_2		IMX_GPIO_NR(3, 12)
 #define DDR_DET_3		IMX_GPIO_NR(3, 13)
@@ -196,9 +193,6 @@ void board_init_f(ulong dummy)
 {
 	int ret;
 
-	/* Clear global data */
-	memset((void *)gd, 0, sizeof(gd_t));
-
 	arch_cpu_init();
 
 	init_uart_clk(0);

-- 
2.51.0

