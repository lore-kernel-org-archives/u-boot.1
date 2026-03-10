Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDFF9FD2D79
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 13:14:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76259840B6;
	Tue, 10 Mar 2026 14:12:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="BHlcMaFX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58ED083981; Tue, 10 Mar 2026 10:15:16 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EB9583F9B
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 10:15:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jPPmFKfIJwXqgzrOsObPcHPgPP0mtTf6JQR0VFwgKvjzPzBjVL1tOv8o4YyD3QHgsEVN6rTzQ7L/KYXztCJ7b59DTK2f67p7HC5KAicVx1Pr8Z+i98BpWEtP5pc7oGtlaaZcYnvB3oN3ABSKmoVrqTLY+L+op7Q/qYIRhI/7IPUzpvfiLuv+LfGFAc6BMF7OU8Pl+XehidDm4EPx8DepB7MUD0VvlK9D2jkGpXbASEZa6QZnY0j0J6koPmgqGYpqmNLxfhScYx/nEiUcJlmc+OQ/kl/NWqkmsucD0b/pHPOpchBeyEByM0zia5v8nsB36zSjHZ4NxRCBontKXnUeGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gSfc2One9H8qMeG1KqVwixEtNuk6NomzEfuv8nWGg/I=;
 b=VD1vK6ybv3bLuyh5MVvgB2Q2IY/RZgMZ4ZC7V9n2RPCLCnUnuYGNs1sw2JOC72pXFMMq9AbQV6VdaihU5TQNuR5G+cPs9W+RFfigOkBtu4EiU9hFXQt0rfUdKCZ9zv4oBGrBcDSHt7yAKL9qM4tZqJynPZDOMUstXqlHSGPaQCoXxwQ5ODW5NickqkHh/fhbtwGcdxPEWG2xgH5Ej/xO6hfPstYSN+mZdvvJQDG8ATAZoZj7N0UkYnwsayWLq7sMsU+0VQDJBh+a0Gz5zwnn8f5NIMitGFO1H5llljnbDKXXrZlyGCXhUhjS76k4OBBwMfUXSXOvO8nNu5oP7xbQsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gSfc2One9H8qMeG1KqVwixEtNuk6NomzEfuv8nWGg/I=;
 b=BHlcMaFXoR7GCcGg6V7ac/AztZL6jJt5W8vd+xH27syVHAXpl+yChNR89B41q+/pcLA5nBTCpKwEe790xEZrFOLfdsPiAhxeEIjIevo2goSxyXery/dvkPgCkFWWLtqEO2OGZIZW+ye2WJae3t4oWxJc5TOnZIwzbwq64n1/A9C/E8yxfedltLb35uE/IL3GQJmPhDp8NJ7ZdG8rR18LqwTDoZY51Tj9z5uLpeZZUWMasBzmm/Oxm/v9avBHlgN9u3aRsKftZPezVZCz/8vn/RRjSdM7P31Z1wG1Tx/PeT/so3d6RDA2WQncqa9/c76gE/4mQBDEpYl4hD7sp7NrAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by GV2PR04MB11192.eurprd04.prod.outlook.com (2603:10a6:150:279::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 09:15:09 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9678.024; Tue, 10 Mar 2026
 09:15:09 +0000
From: alice.guo@oss.nxp.com
Date: Tue, 10 Mar 2026 15:53:44 +0800
Subject: [PATCH v1 10/10] imx: Remove hardcoded watchdog base address
 macros
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-wdog-v1-10-2ee21e890634@nxp.com>
References: <20260310-wdog-v1-0-2ee21e890634@nxp.com>
In-Reply-To: <20260310-wdog-v1-0-2ee21e890634@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Christoph Stoidner <c.stoidner@phytec.de>, upstream@lists.phytec.de
Cc: Joseph Guo <qijian.guo@nxp.com>, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>, 
 Ji Luo <ji.luo@nxp.com>, Marek Vasut <marex@nabladev.com>, 
 Jacky Bai <ping.bai@nxp.com>, Stefan Roese <stefan.roese@mailbox.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 David Zang <davidzangcs@gmail.com>, Simon Glass <sjg@chromium.org>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, Primoz Fiser <primoz.fiser@norik.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>, 
 Joseph Guo <qijian.guo@nxp.com>, Mathieu Othacehe <m.othacehe@gmail.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Jindong Yue <jindong.yue@nxp.com>, Frank Li <Frank.Li@nxp.com>, 
 Max Krummenacher <max.krummenacher@toradex.com>, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SG2PR02CA0071.apcprd02.prod.outlook.com
 (2603:1096:4:54::35) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|GV2PR04MB11192:EE_
X-MS-Office365-Filtering-Correlation-Id: f0963e0f-455a-4f9d-1824-08de7e8586d5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|52116014|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 5AEG+MPoWglDdK8SDcOi/GHq2bKAhhdqVO3EYrjqEqA0PbSQhTQJ8VMCBgbVtPOLfS9UPdidAQ+EUEixMRP8Y2D9cQTk4wzfqcWIiAr9bPeanrsFiPpFEJFSnZLobTa7VGDHwdWnxAv+s+2my2+y4FnVFS8EVz4o5Bb9eBSmuBBwyh1alJ+87iHVE+KdScan2eJ++XT/S5yDG5GbEeiV6OkToOMG8+VZ8AGGaRwi4ZmRuR9Qbdc6Zp5rDGAueVRT+qDbGq8AujxlGp5u52X9lvlqO+GLsW1BZN08SUxJ6dxcKQCHyQpnHrolMBlhYdW9eA8SMABmx6CwbYEPmsP2G17615iOuRURUbNZEDnz1wWK0yJ1uBs2LNPLeeQMbbwa928Ms9sJvUoi8yiagrLHVy3/5uGSQbDLwTyttROEti2IGN916cDBdljyoxpxxxoKop51fZC0Gfpi4dfgUq68H6XYEXoYm+JeUyosVnlhEr1KHgshrwD1VwaO7asyyxeomsFJfZplRFe48c5aCe0vsNwsq+C2LLEweUTmEPNB7FXEPxUCDF3x7Nh/ueoHC7vqfdqZwtxNRJi8drt+CV/fWTtLXRfkmfe1X1KpzI5S60pkS1y0CUX2+OeCkkc6UH+LClRMMDAYpI0JUz35BEsA3C99m9bsJuRFtrkrLxOckcz+uiLxD15KnoUYbC0OM7oQWatg7tHXdWG6wC6JwIq0bODXqA3eYrO5fSmBgL0+2sccX8T2gB4amX5XDYr22zpzYWlPTxl4WqrMNLUnVeGYC8EHCVe2CX0lVaAKagut1II=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(52116014)(19092799006)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHQ0SzZHZ3poUE9RVHdUelc3alRCRjFRNDJBM1Z3R3VYdTZ4UEdDRTVEQ1lP?=
 =?utf-8?B?YmFFM05Zcy9YSTdWVG4xVytBbjB4YVA4UFM1VEpqcXhET2t0Um14b2pFU1dx?=
 =?utf-8?B?dFM5dC9wVmxEbldxTTRIM0MxM1FrcENvUXMrUXFlQ1FpcXp5YUE3bThtQkdM?=
 =?utf-8?B?RmduZGhISG1uYnBISVBNTEJnRjd4U0RhbHRlRUE4MzJqTG9MbXZPT2dGeUJD?=
 =?utf-8?B?MGdHU3BYSWpVMFNMODFLVmZBRDF3UzJzNUIyWU1oQm5vRmkyaTZUZjJ2dFQ5?=
 =?utf-8?B?UzBGQVZVYmdaUmpQOVhoK0RuOVk4YXJackxIUlZhRzEvWFpESFZ4TS8rWS83?=
 =?utf-8?B?anV5dStvV1hiWEhmUnNkbDhhTDU1TkdCek5WS1RQRXY0MldaL095dno2Mytz?=
 =?utf-8?B?Mkp5NHZ6RUZ1RlZXS0x4U1ZkMm9ZU2I2UEh4Wm8yRkZ1VGJwaGdITXE2eVF0?=
 =?utf-8?B?QzRxN1R1Q28xbk9WbHZsa2xrUVNUUHlSclF0WW9TOHU0d3JpTlhScG1Jbi9X?=
 =?utf-8?B?UkVtcXpJYTkxN1AyVTlFR29Sd1pHVG9nTDVyaTdkRlRYei9aMXdQbEpRSFZG?=
 =?utf-8?B?TjlJRHl4aWk2MHFmNldGWGZnSW96YWlDUzRITDFqWlg1L1ppOWhDd3BDVFVl?=
 =?utf-8?B?RVFWMHBZTG1vaGhYWVZNWXRBRkwwNVphZHVvdW90aHN4a0pXV3FWTGNBanZi?=
 =?utf-8?B?RGIvQUtkMmFIMityT3J4dG1Ya2o1bXBPbmJIQitjL0k5OG12RWVyZGxPSXRY?=
 =?utf-8?B?R1BWT0FnTGJnb1BWYWpZV3FGMGdJYjlSOEozZFdjK0s1U2xPb0ZxblJLbC94?=
 =?utf-8?B?QVJ1R2VPT2xmd2l1Ykt5NUQva1lFQnJWM0FTbkw3WDUwZUVGNysxelhwQjhB?=
 =?utf-8?B?bmtSanMyQU9URjZLUXhmQXM1bW1tS3VadHNoeUhaOXh4MlVYdlpJTkJCWGF6?=
 =?utf-8?B?L0tLUmdkZzZsM1hoc2lpaDJOc2h1UlVGYjladzJwRjlFL0xTOVRPOWQ4cVVl?=
 =?utf-8?B?MGtzb1FMWkdEa0JodUxZb0V1V3J0YTYzcEo0NlNZakErM2FnRy9MbW1uSEVj?=
 =?utf-8?B?MUNodXRQNEF0NTdSa1ZjUlZ0ekdPWUFyc0ZXMEkvQkkvQzd6S2lybGoyZWZa?=
 =?utf-8?B?czJ6SzhKSU5LeThXZlB0Qnhmc2tvYjhNZ0xoY0FHbHZlMURya1RMSitURUhP?=
 =?utf-8?B?R0hLREtLTi91Y0VJakd5cG1OVE95aEVISUpQQ1NxY3JvcU1YSmxpOUN5SDVu?=
 =?utf-8?B?eDk3Tm9pTHB0YVpLaGhJVHl5aFZ6Nm1nODRyRlRzZExsNzFhMmowZjJXV0JX?=
 =?utf-8?B?MllGRS85RTl6WW5PNjJzandIUEp1VllzcEVxSG5odzBFaXp6ZXlJRjhPbnNh?=
 =?utf-8?B?aTc4ZUZwOHNlT3JXQUEwTjRIUSswajlJWU0xMHNHT1dCOWZnalNZanNCQ2hI?=
 =?utf-8?B?b254UW1LWDBqd1djZ3hERWZVTHRCbXZud202YTRUQ1JoSk5XbDRaQi9CVmJG?=
 =?utf-8?B?K1ZWMUVKNklHQldZd2hMZk9NQXBMWCtNUU42dzNBejZmTCt1VngrbGFJeitB?=
 =?utf-8?B?TWFVM0tGdForT1NPNGZEU0kxWnJta3R2emVzR2swc3ZZdk04NEx2SkJJYjJV?=
 =?utf-8?B?amp6c3NoVTIxSXozMmxEcng3VjE2UkhkYTBOQStrY3JoY3NBZTN4Q3BWOGc0?=
 =?utf-8?B?cjdrQzNMNGIrSFpyTGhEMlk3TXo1VkNaOFViRnR6OFFzQnYvQVNoWTI5ZHV6?=
 =?utf-8?B?ZldNbVZrU2NyQlJ3V085cFMxakJxVkUySEMrN3RuME1TU0lmQnZKd0wyUytL?=
 =?utf-8?B?Ukozc0IrbE95RUlRYXJzM0xaT3NGeWhQc2V3SWFOck5OaW9RdFpOSk9laE9o?=
 =?utf-8?B?MWFuQmt5K3FzUVJ5b0JIQk9XbW9taUpNTWhnQ25yWGV0dXk1cDZ5OVkrVVcw?=
 =?utf-8?B?Y1F2eUZITU1uVVRpZm85MWFlS0RTNHF6bGZRMmRRS2FGTDdrczlZOXRsMWxE?=
 =?utf-8?B?Q1FpZHZrYjZsRlAvWHNORUh3L2RFYmcwcEc0R3BwTytud2M5enpDaVR6SnVF?=
 =?utf-8?B?aElGemlnN0F3dXB4d3FqQVJRU0tCL1NBTDB1cGUyS0R3ZXRkb3UyaGppaXhQ?=
 =?utf-8?B?NkZvVmxJby9BVVdVWFlFWEh0bDRlNkpZYWtkUDRVdWRXY0x1Y0NsbVF3VUJN?=
 =?utf-8?B?d29nVklvVFZYcHZ1RVNNK1hoOFIvc2FZaEQ1NEkwVmxDRUpTRkpORjdLRHg2?=
 =?utf-8?B?Slk1MmxvT1k5NW8yOGZubVVEbDhkaStYUk5PSzF1bE9JZ053T0wyZ2R5L2pY?=
 =?utf-8?B?MUZ5SDB2d0hFL0xnejdFWVdJVEFiUGQyeUlMcHc3ZGE4bDAzSVZxUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0963e0f-455a-4f9d-1824-08de7e8586d5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 09:15:09.3129 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0oFR60wQDpXAGXH3uC1HH3i1IajZHCYgiKlL+mOutTPEo6wWfTTzo8KcKu4Oqzid3cB7nDH3mF7FTUBhqCndvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11192
X-Mailman-Approved-At: Tue, 10 Mar 2026 14:12:11 +0100
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

From: Alice Guo <alice.guo@nxp.com>

The watchdog base addresses are now obtained from the devicetree via
the imx_wdog_alias_to_addr() function. Remove the hardcoded macro
definitions as they are no longer needed.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/include/asm/arch-imx8ulp/imx-regs.h | 2 --
 arch/arm/include/asm/arch-imx9/imx-regs.h    | 9 ---------
 include/configs/imx8ulp_evk.h                | 2 --
 include/configs/imx91_evk.h                  | 2 --
 include/configs/imx91_frdm.h                 | 2 --
 include/configs/imx93_evk.h                  | 3 ---
 include/configs/imx93_frdm.h                 | 3 ---
 include/configs/imx93_qsb.h                  | 2 --
 include/configs/imx93_var_som.h              | 3 ---
 include/configs/imx94_evk.h                  | 3 ---
 include/configs/imx95_evk.h                  | 2 --
 include/configs/kontron-osm-s-mx93.h         | 2 --
 include/configs/mx7ulp_com.h                 | 3 ---
 include/configs/mx7ulp_evk.h                 | 3 ---
 include/configs/phycore_imx93.h              | 3 ---
 include/configs/toradex-smarc-imx95.h        | 2 --
 16 files changed, 46 deletions(-)

diff --git a/arch/arm/include/asm/arch-imx8ulp/imx-regs.h b/arch/arm/include/asm/arch-imx8ulp/imx-regs.h
index a038cc1df33..f9c5e21c14f 100644
--- a/arch/arm/include/asm/arch-imx8ulp/imx-regs.h
+++ b/arch/arm/include/asm/arch-imx8ulp/imx-regs.h
@@ -20,8 +20,6 @@
 
 #define SIM1_BASE_ADDR		0x29290000
 
-#define WDG3_RBASE		0x292a0000UL
-
 #define SIM_SEC_BASE_ADDR	0x2802B000
 
 #define CGC1_SOSCDIV_ADDR	0x292C0108
diff --git a/arch/arm/include/asm/arch-imx9/imx-regs.h b/arch/arm/include/asm/arch-imx9/imx-regs.h
index 2d084e5227a..fbf2e6a2b01 100644
--- a/arch/arm/include/asm/arch-imx9/imx-regs.h
+++ b/arch/arm/include/asm/arch-imx9/imx-regs.h
@@ -17,15 +17,6 @@
 
 #define ANATOP_BASE_ADDR    0x44480000UL
 
-#ifdef CONFIG_IMX94
-#define WDG3_BASE_ADDR      0x49220000UL
-#define WDG4_BASE_ADDR      0x49230000UL
-#else
-#define WDG3_BASE_ADDR      0x42490000UL
-#define WDG4_BASE_ADDR      0x424a0000UL
-#endif
-#define WDG5_BASE_ADDR      0x424b0000UL
-
 #define GPIO2_BASE_ADDR	    0x43810000UL
 #define GPIO3_BASE_ADDR	    0x43820000UL
 #define GPIO4_BASE_ADDR	    0x43840000UL
diff --git a/include/configs/imx8ulp_evk.h b/include/configs/imx8ulp_evk.h
index edfd6f70815..b4f80fb944b 100644
--- a/include/configs/imx8ulp_evk.h
+++ b/include/configs/imx8ulp_evk.h
@@ -30,6 +30,4 @@
 #define PHYS_SDRAM			0x80000000
 #define PHYS_SDRAM_SIZE			0x80000000 /* 2GB DDR */
 
-/* Using ULP WDOG for reset */
-#define WDOG_BASE_ADDR			WDG3_RBASE
 #endif
diff --git a/include/configs/imx91_evk.h b/include/configs/imx91_evk.h
index 9c5014fd0a5..13918e2b873 100644
--- a/include/configs/imx91_evk.h
+++ b/include/configs/imx91_evk.h
@@ -16,6 +16,4 @@
 #define PHYS_SDRAM		0x80000000
 #define PHYS_SDRAM_SIZE		0x80000000 /* 2GB DDR */
 
-#define WDOG_BASE_ADDR		WDG3_BASE_ADDR
-
 #endif
diff --git a/include/configs/imx91_frdm.h b/include/configs/imx91_frdm.h
index 6d051ed88a5..480b3fb477a 100644
--- a/include/configs/imx91_frdm.h
+++ b/include/configs/imx91_frdm.h
@@ -20,6 +20,4 @@
 #define PHYS_SDRAM		0x80000000
 #define PHYS_SDRAM_SIZE		SZ_2G /* 2GB DDR */
 
-#define WDOG_BASE_ADDR		WDG3_BASE_ADDR
-
 #endif
diff --git a/include/configs/imx93_evk.h b/include/configs/imx93_evk.h
index ffd72a38bcb..67774f54790 100644
--- a/include/configs/imx93_evk.h
+++ b/include/configs/imx93_evk.h
@@ -26,7 +26,4 @@
 #define PHYS_SDRAM                      0x80000000
 #define PHYS_SDRAM_SIZE			0x80000000 /* 2GB DDR */
 
-/* Using ULP WDOG for reset */
-#define WDOG_BASE_ADDR          WDG3_BASE_ADDR
-
 #endif
diff --git a/include/configs/imx93_frdm.h b/include/configs/imx93_frdm.h
index c98c10774cb..bcea360b399 100644
--- a/include/configs/imx93_frdm.h
+++ b/include/configs/imx93_frdm.h
@@ -20,7 +20,4 @@
 #define PHYS_SDRAM			0x80000000
 #define PHYS_SDRAM_SIZE			0x80000000 /* 2GB DDR */
 
-/* Using ULP WDOG for reset */
-#define WDOG_BASE_ADDR			WDG3_BASE_ADDR
-
 #endif
diff --git a/include/configs/imx93_qsb.h b/include/configs/imx93_qsb.h
index a7b94f7ab57..350f094c2a6 100644
--- a/include/configs/imx93_qsb.h
+++ b/include/configs/imx93_qsb.h
@@ -16,6 +16,4 @@
 #define PHYS_SDRAM		0x80000000
 #define PHYS_SDRAM_SIZE		0x80000000 /* 2GB DDR */
 
-#define WDOG_BASE_ADDR		WDG3_BASE_ADDR
-
 #endif
diff --git a/include/configs/imx93_var_som.h b/include/configs/imx93_var_som.h
index 9dc10aea407..6a425e6d1ea 100644
--- a/include/configs/imx93_var_som.h
+++ b/include/configs/imx93_var_som.h
@@ -38,7 +38,4 @@
 
 #define CFG_SYS_FSL_USDHC_NUM 2
 
-/* Using ULP WDOG for reset */
-#define WDOG_BASE_ADDR          WDG3_BASE_ADDR
-
 #endif
diff --git a/include/configs/imx94_evk.h b/include/configs/imx94_evk.h
index f93c3c4e4a8..2623c13db06 100644
--- a/include/configs/imx94_evk.h
+++ b/include/configs/imx94_evk.h
@@ -18,7 +18,4 @@
 #define PHYS_SDRAM_SIZE			     0x70000000UL /* 2GB  - 256MB DDR */
 #define PHYS_SDRAM_2_SIZE	             0x180000000 /* 8GB */
 
-/* Using ULP WDOG for reset */
-#define WDOG_BASE_ADDR          WDG3_BASE_ADDR
-
 #endif
diff --git a/include/configs/imx95_evk.h b/include/configs/imx95_evk.h
index 3d22740b3f4..1fdc9ce21ef 100644
--- a/include/configs/imx95_evk.h
+++ b/include/configs/imx95_evk.h
@@ -23,6 +23,4 @@
 #define PHYS_SDRAM_2_SIZE		0x380000000 /* 14GB (Totally 16GB) */
 #endif
 
-#define WDOG_BASE_ADDR			WDG3_BASE_ADDR
-
 #endif
diff --git a/include/configs/kontron-osm-s-mx93.h b/include/configs/kontron-osm-s-mx93.h
index ab2b42298c8..fed75e6fa12 100644
--- a/include/configs/kontron-osm-s-mx93.h
+++ b/include/configs/kontron-osm-s-mx93.h
@@ -25,6 +25,4 @@
 #define CFG_MXC_USB_FLAGS		0
 #endif
 
-#define WDOG_BASE_ADDR          WDG3_BASE_ADDR
-
 #endif /* __KONTRON_MX93_CONFIG_H */
diff --git a/include/configs/mx7ulp_com.h b/include/configs/mx7ulp_com.h
index d27e9d2eaa1..501c3059cc3 100644
--- a/include/configs/mx7ulp_com.h
+++ b/include/configs/mx7ulp_com.h
@@ -15,9 +15,6 @@
 #include "imx7ulp_spl.h"
 #endif
 
-/* Using ULP WDOG for reset */
-#define WDOG_BASE_ADDR			WDG1_RBASE
-
 #define CFG_SYS_HZ_CLOCK		1000000 /* Fixed at 1MHz from TSTMR */
 
 /* UART */
diff --git a/include/configs/mx7ulp_evk.h b/include/configs/mx7ulp_evk.h
index ace1eee70cf..21dbec837f0 100644
--- a/include/configs/mx7ulp_evk.h
+++ b/include/configs/mx7ulp_evk.h
@@ -11,9 +11,6 @@
 #include <linux/sizes.h>
 #include <asm/arch/imx-regs.h>
 
-/* Using ULP WDOG for reset */
-#define WDOG_BASE_ADDR			WDG1_RBASE
-
 #define CFG_SYS_HZ_CLOCK		1000000 /* Fixed at 1Mhz from TSTMR */
 
 /* UART */
diff --git a/include/configs/phycore_imx93.h b/include/configs/phycore_imx93.h
index 07364dff403..a6dd0478585 100644
--- a/include/configs/phycore_imx93.h
+++ b/include/configs/phycore_imx93.h
@@ -22,7 +22,4 @@
 #define PHYS_SDRAM                   0x80000000
 #define PHYS_SDRAM_SIZE              0x80000000
 
-/* Using ULP WDOG for reset */
-#define WDOG_BASE_ADDR          WDG3_BASE_ADDR
-
 #endif /* __PHYCORE_IMX93_H */
diff --git a/include/configs/toradex-smarc-imx95.h b/include/configs/toradex-smarc-imx95.h
index e1aebd70af2..8a880b96503 100644
--- a/include/configs/toradex-smarc-imx95.h
+++ b/include/configs/toradex-smarc-imx95.h
@@ -19,6 +19,4 @@
 #define PHYS_SDRAM_SIZE		(SZ_2G - SZ_256M)
 #define PHYS_SDRAM_2_SIZE	SZ_6G
 
-#define WDOG_BASE_ADDR	WDG3_BASE_ADDR
-
 #endif

-- 
2.43.0

